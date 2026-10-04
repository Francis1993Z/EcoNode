// Moteur de simulation ÉcoNodes. Un tour = un jour.
// Toute la monnaie passe par transfer() : la masse monétaire ne change que
// par le god mode ou le commerce extérieur. Port ligne à ligne de engine.js.

import 'dart:math' as math;

import 'model.dart';

/// mulberry32, identique à la version JS (arithmétique 32 bits non signée).
class Mulberry32 {
  int _a;
  Mulberry32(int seed) : _a = seed & 0xFFFFFFFF;

  static int _imul(int a, int b) {
    final ah = (a >>> 16) & 0xFFFF, al = a & 0xFFFF;
    final bh = (b >>> 16) & 0xFFFF, bl = b & 0xFFFF;
    return (al * bl + (((ah * bl + al * bh) & 0xFFFF) << 16)) & 0xFFFFFFFF;
  }

  double next() {
    _a = (_a + 0x6D2B79F5) & 0xFFFFFFFF;
    var t = _a;
    t = _imul(t ^ (t >>> 15), 1 | t);
    t = ((t + _imul(t ^ (t >>> 7), 61 | t)) & 0xFFFFFFFF) ^ t;
    return ((t ^ (t >>> 14)) & 0xFFFFFFFF) / 4294967296.0;
  }
}

/// Tri stable (List.sort de Dart ne l'est pas ; JS oui).
void stableSort<T>(List<T> list, int Function(T a, T b) cmp) {
  final idx = List<int>.generate(list.length, (i) => i);
  final copy = List<T>.from(list);
  idx.sort((i, j) {
    final c = cmp(copy[i], copy[j]);
    return c != 0 ? c : i.compareTo(j);
  });
  for (var k = 0; k < idx.length; k++) {
    list[k] = copy[idx[k]];
  }
}

String fmtMoney0(double v) {
  final r = v.round();
  final neg = r < 0;
  final s = r.abs().toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write(' ');
    b.write(s[i]);
  }
  return '${neg ? '-' : ''}${b.toString()} \$';
}

double round1(double v) => (v * 10).roundToDouble() / 10;

class _Offer {
  final Firm? firm; // null = extérieur
  final double p;
  final double r;
  _Offer(this.firm, this.p, this.r);
}

class Sim {
  late int seed;
  late Mulberry32 _rng;
  late Params params;
  int day = 0;
  int _nextId = 1;
  List<Citizen> citizens = [];
  final Map<int, Citizen> _cmap = {};
  List<Firm> firms = [];
  double ledgerGod = 0;
  double ledgerImports = 0;
  double ledgerExports = 0;
  final List<SimEvent> events = [];
  final List<HistPoint> history = [];
  Map<String, FlowEdge> flows = {};
  final Map<String, FlowEdge> flowsEma = {};
  Map<String, double> unmet = {};
  final Map<String, MarketStat> marketStats = {};
  final Map<String, int> lastShortage = {};
  double householdSpend = 0;
  // positions des nodes spéciaux dans le graphe (ménages, État, extérieur)
  final Map<String, List<double>> nodePos = {
    'M': [1200, 250],
    'E': [1200, 20],
    'X': [1200, 640],
  };
  late StateAccount state;
  late Map<String, double> worldPrice;
  late double m0;
  double needCost = 0;
  double avgWage = 0;

  Sim({int seed = 42, Params? params, List<ScenarioFirm>? scenario}) {
    reset(seed: seed, params: params, scenario: scenario);
  }

  double rng() => _rng.next();

  // ================================================================== Setup
  void reset({int seed = 42, Params? params, List<ScenarioFirm>? scenario}) {
    this.seed = seed;
    _rng = Mulberry32(seed);
    this.params = params ?? Params();
    day = 0;
    _nextId = 1;
    citizens = [];
    _cmap.clear();
    firms = [];
    ledgerGod = 0;
    ledgerImports = 0;
    ledgerExports = 0;
    events.clear();
    history.clear();
    flows = {};
    flowsEma.clear();
    unmet = {};
    marketStats.clear();
    lastShortage.clear();
    householdSpend = 0;
    nodePos['M'] = [1200, 250];
    nodePos['E'] = [1200, 20];
    nodePos['X'] = [1200, 640];
    state = StateAccount(20000);

    final p = this.params;
    // prix de départ : coût de revient + marge, résolus par itération
    final price = <String, double>{};
    for (final g in goods.keys) {
      price[g] = goods[g]!.guess;
    }
    for (var it = 0; it < 40; it++) {
      for (final t in templates.values) {
        var cost = p.startWage / t.rate;
        for (final e in t.inputs.entries) {
          cost += e.value * price[e.key]!;
        }
        final value = cost * p.markup;
        var tot = 0.0;
        for (final e in t.outputs.entries) {
          tot += e.value * price[e.key]!;
        }
        for (final e in t.outputs.entries) {
          price[e.key] = value * (e.value * price[e.key]! / tot) / e.value;
        }
      }
    }
    worldPrice = Map<String, double>.from(price);

    for (var i = 0; i < p.population; i++) {
      _newCitizen(p.startWallet * (0.6 + 0.8 * rng()));
    }

    final pool = List<Citizen>.from(citizens);
    _shuffle(pool);
    for (final s in (scenario ?? defaultScenario)) {
      final f = _newFirm(s.type, s.name, 0, null, s.x, s.y, price);
      for (var k = 0; k < s.workers && pool.isNotEmpty; k++) {
        _hire(f, pool.removeLast());
      }
      final batches = _capBatches(f, f.workers.length * f.rate);
      for (final e in f.outputs.entries) {
        final d = batches * e.value;
        f.demandEma[e.key] = d;
        f.inv[e.key] = goods[e.key]!.perish ? 0 : d * p.invTargetDays;
      }
      for (final e in f.inputs.entries) {
        f.inv[e.key] = batches * e.value * 5;
      }
      var inputCost = 0.0;
      for (final e in f.inputs.entries) {
        inputCost += batches * e.value * price[e.key]!;
      }
      f.money = math.max(6000.0, 12 * (f.wage * f.workers.length + inputCost));
      f.ownerId = citizens[(rng() * citizens.length).floor()].id;
    }
    m0 = totalMoney();
    needCost = bestPrice('repas') + bestPrice('logement') + bestPrice('souliers') / p.shoeLife;
    _record();
  }

  Citizen _newCitizen(double money) {
    var name = '';
    for (var k = 0; k < 30; k++) {
      final a = firstNames[(rng() * firstNames.length).floor()];
      final b = lastNames[(rng() * lastNames.length).floor()];
      name = '$a $b';
      if (!citizens.any((x) => x.name == name)) break;
    }
    final shoes = (rng() * params.shoeLife).floor() + 1;
    final c = Citizen(_nextId++, name, money, shoes);
    citizens.add(c);
    _cmap[c.id] = c;
    return c;
  }

  Firm _newFirm(String type, String? name, double money, int? ownerId, double? x, double? y,
      [Map<String, double>? priceTable]) {
    final t = templates[type]!;
    final f = Firm(_nextId++, type, name ?? t.label, Map<String, double>.from(t.inputs),
        Map<String, double>.from(t.outputs), t.rate, t.capacity, money, ownerId, params.startWage, x ?? 400, y ?? 250);
    final pt = priceTable ?? worldPrice;
    for (final g in f.outputs.keys) {
      f.price[g] = pt[g] ?? goods[g]!.guess;
      f.inv[g] = 0;
      f.demandEma[g] = 0;
    }
    for (final g in f.inputs.keys) {
      f.inv[g] = f.inv[g] ?? 0.0;
    }
    firms.add(f);
    return f;
  }

  // ============================================================= Utilitaires
  List<T> _shuffle<T>(List<T> a) {
    for (var i = a.length - 1; i > 0; i--) {
      final j = (rng() * (i + 1)).floor();
      final t = a[i];
      a[i] = a[j];
      a[j] = t;
    }
    return a;
  }

  Citizen? citizen(int id) => _cmap[id];

  Firm? firm(int id) {
    for (final f in firms) {
      if (f.id == id) return f;
    }
    return null;
  }

  double totalMoney() {
    var m = 0.0;
    for (final c in citizens) {
      m += c.money;
    }
    for (final f in firms) {
      m += f.money;
    }
    return m + state.money;
  }

  double expectedMoney() => m0 + ledgerGod + ledgerExports - ledgerImports;

  double transfer(Account? from, Account? to, double amt) {
    if (!(amt > 0)) return 0;
    if (from != null && from.money + eps < amt) throw StateError('Transfert à découvert');
    if (from != null) from.money -= amt;
    if (to != null) to.money += amt;
    if (from != null && from.money < 0) from.money = 0; // poussière flottante
    return amt;
  }

  void _flow(String from, String to, String good, double qty, double value) {
    final k = '$from>$to>$good';
    final e = flows[k] ?? (flows[k] = FlowEdge(from, to, good, 0, 0));
    e.qty += qty;
    e.value += value;
  }

  void _hire(Firm f, Citizen c) {
    if (c.employer != null) {
      final old = firm(c.employer!);
      if (old != null) _fire(old, c);
    }
    c.employer = f.id;
    c.daysUnemployed = 0;
    f.workers.add(c.id);
  }

  void _fire(Firm? f, Citizen? c) {
    if (f == null || c == null) return;
    f.workers.remove(c.id);
    c.employer = null;
  }

  double efficiency(Citizen c) {
    var e = 1.0;
    if (c.hunger >= 2) e *= 0.5;
    if (c.homeless) e *= 0.8;
    if (c.shoes <= 0) e *= 0.9;
    return e;
  }

  double _capBatches(Firm f, double b) => f.capacity != null ? math.min(b, f.capacity!) : b;

  List<Firm> sellersOf(String good) => firms.where((f) => f.outputs.containsKey(good)).toList();

  double bestPrice(String good) {
    var best = double.infinity;
    for (final f in firms) {
      if (f.outputs.containsKey(good) && (f.inv[good] ?? 0) >= 1 - eps && f.price[good]! < best) {
        best = f.price[good]!;
      }
    }
    if (params.trade && !goods[good]!.perish) {
      best = math.min(best, worldPrice[good]! * params.importMarkup);
    }
    if (best == double.infinity) {
      // aucun stock : on prend le prix affiché le plus bas comme référence
      for (final f in sellersOf(good)) {
        best = math.min(best, f.price[good]!);
      }
    }
    return best == double.infinity ? worldPrice[good]! : best;
  }

  /// Coût d'un lot : salaires + intrants au prix du marché, réparti entre les extrants.
  Map<String, double> unitCost(Firm f) {
    var batch = f.wage / math.max(eps, f.rate * f.prodMult);
    for (final e in f.inputs.entries) {
      batch += e.value * bestPrice(e.key);
    }
    var tot = 0.0;
    for (final e in f.outputs.entries) {
      tot += e.value * worldPrice[e.key]!;
    }
    final out = <String, double>{};
    for (final e in f.outputs.entries) {
      final share = tot > 0 ? e.value * worldPrice[e.key]! / tot : 1 / f.outputs.length;
      out[e.key] = batch * share / e.value;
    }
    return out;
  }

  /// Achat sur le marché : le moins cher d'abord.
  BuyResult buy(Account buyer, String buyerKey, String good, double qty, double budget, bool integer) {
    if (qty <= eps || budget <= eps) return const BuyResult(0, 0);
    final offers = <_Offer>[];
    for (final f in firms) {
      if (identical(f, buyer) || !f.outputs.containsKey(good)) continue;
      if ((f.inv[good] ?? 0) > eps) offers.add(_Offer(f, f.price[good]!, rng()));
    }
    final p = params;
    if (p.trade && !goods[good]!.perish) {
      offers.add(_Offer(null, worldPrice[good]! * p.importMarkup, rng()));
    }
    stableSort<_Offer>(offers, (a, b) {
      final d = a.p * (1 + 0.03 * a.r) - b.p * (1 + 0.03 * b.r);
      return d < 0 ? -1 : (d > 0 ? 1 : 0);
    });

    var remaining = qty;
    var spent = 0.0;
    var broke = false;
    for (final o in offers) {
      if (remaining <= eps) break;
      final double avail = o.firm == null ? double.infinity : (o.firm!.inv[good] ?? 0.0);
      final afford = (budget - spent) / o.p;
      double q = math.min(remaining, math.min(avail, afford));
      if (integer) q = (q + 1e-7).floorToDouble();
      if (afford < remaining && afford <= avail) broke = true;
      if (q <= eps) continue;
      final cost = math.min(q * o.p, buyer.money);
      if (o.firm == null) {
        transfer(buyer, null, cost);
        ledgerImports += cost;
      } else {
        final s = o.firm!;
        transfer(buyer, s, cost);
        s.inv[good] = (s.inv[good] ?? 0) - q;
        s.sold[good] = (s.sold[good] ?? 0) + q;
        s.revenue += cost;
      }
      _flow(o.firm == null ? 'X' : o.firm!.id.toString(), buyerKey, good, q, cost);
      final ms = marketStats[good]!;
      ms.qty += q;
      ms.value += cost;
      remaining -= q;
      spent += cost;
      if (broke) break;
    }
    if (remaining > eps && !broke) unmet[good] = (unmet[good] ?? 0) + remaining;
    return BuyResult(qty - remaining, spent);
  }

  void _log(String type, String text) {
    events.add(SimEvent(day, type, text));
    if (events.length > 300) events.removeAt(0);
  }

  // ================================================================= Tick
  void step() {
    final p = params;
    day++;
    flows = {};
    unmet = {};
    householdSpend = 0;
    for (final g in goods.keys) {
      marketStats[g] = MarketStat();
    }
    for (final f in firms) {
      f.sold = {};
      f.produced = {};
      f.revenue = 0;
      f.costs = 0;
      f.inputSpend = 0;
      f.wagesPaid = 0;
    }
    for (final c in citizens) {
      c.income = 0;
      c.spend = 0;
    }
    state.taxesToday = 0;
    state.paidToday = 0;
    for (final f in firms) {
      f.prevWorkers = f.workers.length;
    }

    // 0. Revenu de base divin (création monétaire)
    if (p.ubi > 0) {
      for (final c in citizens) {
        c.money += p.ubi;
        ledgerGod += p.ubi;
      }
    }

    _laborMarket();
    _produce();
    _payWages();
    _buyInputs();
    _consume();
    if (p.trade) _export();
    _expire();
    _decide();
    _finance();
    _record();
  }

  void _laborMarket() {
    final unemployed = _shuffle(citizens.where((c) => c.employer == null).toList());
    final hiring = firms.where((f) => f.vacancies > 0).toList();
    stableSort<Firm>(hiring, (a, b) => b.wage.compareTo(a.wage));
    for (final f in hiring) {
      while (f.vacancies > 0 && unemployed.isNotEmpty) {
        _hire(f, unemployed.removeLast());
        f.vacancies--;
      }
      f.unfilledDays = f.vacancies > 0 ? f.unfilledDays + 1 : 0;
    }
    // mobilité : un employé quitte pour un meilleur salaire
    final open = firms.where((f) => f.vacancies > 0).toList();
    if (open.isNotEmpty) {
      for (final c in List<Citizen>.from(citizens)) {
        if (c.employer == null || rng() > params.jobSwitch) continue;
        final cur = firm(c.employer!);
        var best = open[0];
        for (final b in open) {
          if (b.vacancies > 0 && b.wage > best.wage) best = b;
        }
        if (cur != null && best.vacancies > 0 && !identical(best, cur) && best.wage > cur.wage * 1.08) {
          _hire(best, c);
          best.vacancies--;
        }
      }
    }
    for (final c in citizens) {
      if (c.employer == null) c.daysUnemployed++;
    }
    // assurance-emploi payée par l'État, au prorata si la caisse est vide
    final idle = citizens.where((c) => c.employer == null).toList();
    if (idle.isNotEmpty && params.benefit > 0) {
      final each = math.min(params.benefit, state.money / idle.length);
      if (each > eps) {
        for (final c in idle) {
          transfer(state, c, each);
          c.income += each;
        }
        state.paid += each * idle.length;
        state.paidToday += each * idle.length;
        _flow('E', 'M', '\$prestations', idle.length.toDouble(), each * idle.length);
      }
    }
  }

  void _produce() {
    for (final f in firms) {
      var eff = 0.0;
      for (final id in f.workers) {
        eff += efficiency(_cmap[id]!);
      }
      final laborBatches = _capBatches(f, eff * f.rate * f.prodMult);
      var batches = laborBatches;
      for (final e in f.inputs.entries) {
        batches = math.min(batches, (f.inv[e.key] ?? 0) / e.value);
      }
      f.inputLimited = batches < laborBatches - eps;
      final g0 = f.g0;
      if (!goods[g0]!.perish && (f.inv[g0] ?? 0) > 2 * params.invTargetDays * math.max(f.demandEma[g0] ?? 0, 0.5)) {
        batches = math.min(batches, _plannedBatches(f)); // entrepôt plein : on ralentit
      }
      batches = math.max(0.0, batches);
      f.lastBatches = batches;
      f.effWorkers = eff;
      for (final e in f.inputs.entries) {
        f.inv[e.key] = (f.inv[e.key] ?? 0) - batches * e.value;
      }
      for (final e in f.outputs.entries) {
        final q = batches * e.value;
        f.inv[e.key] = (f.inv[e.key] ?? 0) + q;
        f.produced[e.key] = q;
      }
    }
  }

  void _payWages() {
    for (final f in firms) {
      final n = f.workers.length;
      if (n == 0) continue;
      final bill = f.wage * n;
      final each = f.money >= bill ? f.wage : f.money / n;
      final t = params.taxRate;
      for (final id in f.workers) {
        final c = _cmap[id]!;
        transfer(f, c, each * (1 - t));
        transfer(f, state, each * t);
        c.income += each * (1 - t);
      }
      f.wagesPaid = each * n;
      f.costs += each * n;
      state.taxes += each * n * t;
      state.taxesToday += each * n * t;
      if (each > 0) {
        _flow(f.id.toString(), 'M', '\$salaires', n.toDouble(), each * n * (1 - t));
        if (t > 0) _flow('M', 'E', '\$impôts', 1, each * n * t);
      }
      if (each < f.wage - eps) {
        // ne peut pas payer : mise à pied du dernier embauché
        final c = _cmap[f.workers.last];
        _fire(f, c);
        f.vacancies = 0;
        if (day - f.lastDistressLog > 10) {
          _log('warn', '${f.name} ne peut plus payer ses salaires — mise à pied.');
          f.lastDistressLog = day;
        }
      }
    }
  }

  double _plannedBatches(Firm f) {
    final g0 = f.g0;
    final per = f.outputs[g0]!;
    final d = f.demandEma[g0] ?? 0;
    double target;
    if (goods[g0]!.perish) {
      target = d * 1.05;
    } else {
      target = d + (params.invTargetDays * d - (f.inv[g0] ?? 0)) / 10;
    }
    return _capBatches(f, math.max(0.0, target / per));
  }

  void _buyInputs() {
    for (final f in _shuffle(List<Firm>.from(firms))) {
      if (f.inputs.isEmpty) continue;
      // on n'achète pas plus de matière que l'équipe peut transformer
      final crew = (f.workers.length + f.vacancies) * f.rate * f.prodMult * 1.2;
      final plan = math.min(math.max(_plannedBatches(f), f.lastBatches), _capBatches(f, crew));
      final want = <String, double>{};
      var wantValue = 0.0;
      for (final e in f.inputs.entries) {
        final target = plan * e.value * 5;
        final deficit = target - (f.inv[e.key] ?? 0);
        if (deficit > eps) {
          want[e.key] = deficit;
          wantValue += deficit * bestPrice(e.key);
        }
      }
      if (wantValue <= 0) continue;
      final budget = math.max(0.0, f.money - 5 * f.wage * f.workers.length);
      for (final e in want.entries) {
        final share = budget * (e.value * bestPrice(e.key)) / wantValue;
        final r = buy(f, f.id.toString(), e.key, e.value, math.min(share, f.money), false);
        f.inv[e.key] = (f.inv[e.key] ?? 0) + r.qty;
        f.costs += r.spent;
        f.inputSpend += r.spent;
      }
    }
  }

  void _consume() {
    final p = params;
    final pRepas = bestPrice('repas'), pLog = bestPrice('logement'), pSoul = bestPrice('souliers');
    final need = pRepas + pLog + pSoul / p.shoeLife;
    needCost = need;
    for (final c in _shuffle(List<Citizen>.from(citizens))) {
      final before = c.money;
      // nourriture d'abord
      var r = buy(c, 'M', 'repas', 1, c.money, true);
      c.hunger = r.qty >= 1 ? 0 : c.hunger + 1;
      // logement
      r = buy(c, 'M', 'logement', 1, c.money, true);
      c.homeless = r.qty < 1;
      // souliers
      c.shoes -= 1;
      if (c.shoes <= 0) {
        r = buy(c, 'M', 'souliers', 1, c.money, true);
        c.shoes = r.qty >= 1 ? p.shoeLife : 0;
      }
      // dépenses discrétionnaires : une part de l'épargne au-dessus du coussin
      final surplus = c.money - p.bufferDays * need;
      if (surplus > 0) {
        final budget = surplus * p.propensity;
        final pl = bestPrice('loisirs');
        var n = budget * 0.6 / pl;
        n = n.floorToDouble() + (rng() < n - n.floorToDouble() ? 1 : 0);
        if (n > 0) buy(c, 'M', 'loisirs', math.min(n, 200.0), c.money, true);
        var m = budget * 0.25 / pRepas; // sorties au resto
        m = m.floorToDouble() + (rng() < m - m.floorToDouble() ? 1 : 0);
        if (m > 0) buy(c, 'M', 'repas', math.min(m, 50.0), c.money, true);
        if (rng() < budget * 0.15 / pSoul) {
          r = buy(c, 'M', 'souliers', 1, c.money, true);
          if (r.qty >= 1) c.shoes += p.shoeLife;
        }
      }
      c.spend = before - c.money;
      householdSpend += c.spend;
    }
  }

  void _export() {
    for (final f in firms) {
      for (final g in f.outputs.keys) {
        if (goods[g]!.perish) continue;
        final excess = (f.inv[g] ?? 0) - 8 * math.max(f.demandEma[g] ?? 0, 0.5);
        if (excess <= eps) continue;
        final p = worldPrice[g]! * params.exportDiscount;
        final value = excess * p;
        f.inv[g] = (f.inv[g] ?? 0) - excess;
        f.money += value;
        f.revenue += value;
        ledgerExports += value;
        f.sold[g] = f.sold[g] ?? 0.0; // l'export ne compte pas comme demande locale
        _flow(f.id.toString(), 'X', g, excess, value);
      }
    }
  }

  void _expire() {
    for (final f in firms) {
      for (final g in f.outputs.keys) {
        if (goods[g]!.perish) f.inv[g] = 0;
      }
    }
  }

  void _decide() {
    final p = params;
    final n = citizens.length;
    final unemp = n > 0 ? citizens.where((c) => c.employer == null).length / n : 0.0;

    // répartir la demande non servie entre les producteurs du bien
    for (final e in unmet.entries) {
      final s = sellersOf(e.key);
      for (final f in s) {
        f.unmetShare[e.key] = e.value / s.length;
      }
    }

    // salaire de référence (norme du marché du travail)
    var wsum = 0.0;
    var wn = 0;
    for (final f in firms) {
      wsum += f.wage * f.workers.length;
      wn += f.workers.length;
    }
    final aw = wn > 0 ? wsum / wn : p.startWage;
    avgWage = aw;
    final baseMk = p.markup - 1;

    for (final f in firms) {
      final cost = unitCost(f);
      f.unitCostCache = cost;
      for (final g in f.outputs.keys) {
        final um = f.unmetShare[g] ?? 0;
        f.unmetShare[g] = 0;
        final demand = (f.sold[g] ?? 0) + um;
        if (g == f.g0) f.urgency = demand > eps ? um / demand : 0.0;
        f.demandEma[g] = 0.85 * (f.demandEma[g] ?? 0) + 0.15 * demand;
        f.markup[g] = f.markup[g] ?? baseMk;
        if (f.lockPrice) continue;
        // signal de rareté : stock trop bas (ou capacité saturée) → marge ↑ ; surstock → marge ↓
        var dir = 0;
        if (goods[g]!.perish) {
          final prod = f.produced[g] ?? 0;
          final util = prod > eps ? (f.sold[g] ?? 0) / prod : (um > 0 ? 1.0 : 0.0);
          if (um > eps && util > 0.97) {
            dir = 1;
          } else if (util < 0.85 && prod > eps) {
            dir = -1;
          }
        } else {
          final days = (f.inv[g] ?? 0) / math.max(f.demandEma[g]!, 0.05);
          if (days < 2 && demand > eps) {
            dir = 1;
          } else if (days > 8) {
            dir = -1;
          }
        }
        final pressure = 1 + 2 * math.min(1.0, um / math.max(f.sold[g] ?? 0, 1.0));
        final stepSize = p.priceStep * (0.5 + rng());
        var mk = f.markup[g]!;
        if (dir > 0) {
          mk += stepSize * pressure;
        } else if (dir < 0) {
          mk -= stepSize;
        } else {
          mk += (baseMk - mk) * 0.03; // la concurrence ramène la marge vers la normale
        }
        mk = math.max(-0.4, math.min(3.0, mk));
        f.markup[g] = mk;
        final target = cost[g]! * (1 + mk);
        f.price[g] = f.price[g]! + (target - f.price[g]!) * 0.25;
        if (f.price[g]! < 0.01) f.price[g] = 0.01;
      }

      // ------- plan d'embauche
      final nw = f.workers.length;
      final avgEff = nw > 0 ? math.max(0.3, f.effWorkers / nw) : 1.0;
      final per = math.max(eps, f.rate * f.prodMult * avgEff);
      var desired = (_plannedBatches(f) / per - 0.2).ceil();
      if (f.inputLimited) desired = math.min(desired, (f.lastBatches / per).ceil()); // pas d'embauche sans matière
      f.desired = desired;
      final bill = f.wage * nw;
      f.vacancies = 0;
      if (nw > 0 && f.money < bill * 2) {
        _fire(f, _cmap[f.workers[nw - 1]]);
      } else if (desired > nw) {
        final affordable = (f.money / (f.wage * 8)).floor() - nw;
        f.vacancies = math.max(0, math.min(desired - nw, math.min(3, affordable)));
      } else if (desired < nw - 1) {
        final k = math.min(nw - desired - 1, math.max(1, (nw * 0.08).ceil()));
        for (var i = 0; i < k; i++) {
          _fire(f, _cmap[f.workers.last]);
        }
      }

      // ------- salaires
      if (!f.lockWage) {
        // postes vacants : on monte le salaire, plus vite si des clients repartent les mains vides
        if (f.vacancies > 0 && f.unfilledDays >= 2) {
          f.wage *= 1 + p.wageStep * (1 + 3 * math.min(1.0, f.urgency));
          f.unfilledDays = 0;
        } else if (f.vacancies == 0 && unemp > 0.08) {
          f.wage *= 1 - p.wageStep * 0.1;
        }
        f.wage += (aw - f.wage) * 0.01; // les écarts de salaire se résorbent lentement
        if (f.wage < math.max(1.0, p.minWage)) f.wage = math.max(1.0, p.minWage);
      }

      // ------- profits et dividendes
      final profit = f.revenue - f.costs;
      f.profitEma = 0.9 * f.profitEma + 0.1 * profit;
      f.inputSpendEma = 0.9 * f.inputSpendEma + 0.1 * f.inputSpend;
      final reserve = 8 * (f.wage * f.workers.length + f.inputSpendEma);
      final owner = f.ownerId != null ? _cmap[f.ownerId!] : null;
      f.dividends = 0;
      if (owner != null && f.money > reserve) {
        final d = (f.money - reserve) * p.dividendRate;
        transfer(f, owner, d * (1 - p.taxRate));
        transfer(f, state, d * p.taxRate);
        state.taxes += d * p.taxRate;
        state.taxesToday += d * p.taxRate;
        owner.income += d * (1 - p.taxRate);
        f.dividends = d;
        _flow(f.id.toString(), 'M', '\$dividendes', 1, d * (1 - p.taxRate));
        if (p.taxRate > 0) _flow('M', 'E', '\$impôts', 1, d * p.taxRate);
      }
    }

    // pénuries notables
    for (final e in unmet.entries) {
      final ms = marketStats[e.key]!;
      if (e.value > 0.2 * (ms.qty + e.value) && e.value >= 1 && day - (lastShortage[e.key] ?? -99) > 20) {
        _log('short', 'Pénurie de ${goods[e.key]!.label.toLowerCase()} : ${e.value.round()} ${goods[e.key]!.unit} non servis.');
        lastShortage[e.key] = day;
      }
    }

    // flux lissés pour l'affichage
    for (final e in flowsEma.values) {
      e.qty *= 0.8;
      e.value *= 0.8;
    }
    for (final e in flows.entries) {
      final cur = flowsEma[e.key] ?? (flowsEma[e.key] = FlowEdge(e.value.from, e.value.to, e.value.good, 0, 0));
      cur.qty += 0.2 * e.value.qty;
      cur.value += 0.2 * e.value.value;
    }
    flowsEma.removeWhere((k, v) => v.value < 0.5 && !flows.containsKey(k));
  }

  /// Renflouement par les propriétaires, rachats, redistribution du surplus de l'État.
  void _finance() {
    final p = params;
    final buffer = p.bufferDays * (needCost > 0 ? needCost : 140);
    if (p.recapitalize) {
      for (final f in firms) {
        if ((f.demandEma[f.g0] ?? 0) < 0.05) continue;
        final nw = math.max(1, math.min(f.desired == 0 ? 1 : f.desired, f.workers.length + 3));
        final need = 10 * f.wage * nw - f.money;
        if (need <= 0 || f.money > 4 * f.wage * nw) continue;
        var owner = f.ownerId != null ? _cmap[f.ownerId!] : null;
        var surplus = owner != null ? owner.money - buffer : 0.0;
        if (surplus < need * 0.5) {
          // le propriétaire n'a pas les moyens : le citoyen le plus riche rachète
          Citizen? rich;
          for (final c in citizens) {
            if (rich == null || c.money > rich.money) rich = c;
          }
          if (rich != null && !identical(rich, owner) && rich.money - buffer > need * 2) {
            f.ownerId = rich.id;
            owner = rich;
            surplus = rich.money - buffer;
            _log('info', '${rich.name} rachète ${f.name}.');
          }
        }
        if (owner != null && surplus > 0) {
          final amt = math.min(need, surplus * 0.5);
          if (amt > f.wage) {
            transfer(owner, f, amt);
            _flow('M', f.id.toString(), '\$capital', 1, amt);
            if (day - f.lastRecapLog > 30) {
              _log('info', '${owner.name} renfloue ${f.name} (${fmtMoney0(amt)}).');
              f.lastRecapLog = day;
            }
          }
        }
      }
    }
    // l'État redistribue son surplus au-delà d'une réserve
    final e = state;
    final reserve = 30 * p.benefit * math.max(4.0, citizens.length * 0.1);
    if (p.stateRebate > 0 && e.money > reserve && citizens.isNotEmpty) {
      final total = (e.money - reserve) * p.stateRebate;
      final each = total / citizens.length;
      for (final c in citizens) {
        transfer(e, c, each);
        c.income += each;
      }
      e.paid += total;
      e.paidToday += total;
      _flow('E', 'M', '\$redistribution', 1, total);
    }
  }

  double gini() {
    final v = citizens.map((c) => math.max(0.0, c.money)).toList()..sort();
    final n = v.length;
    if (n == 0) return 0;
    var cum = 0.0, tot = 0.0;
    for (var i = 0; i < n; i++) {
      cum += (i + 1) * v[i];
      tot += v[i];
    }
    return tot > 0 ? (2 * cum) / (n * tot) - (n + 1) / n : 0.0;
  }

  void _record() {
    final n = citizens.length;
    final employed = citizens.where((c) => c.employer != null).toList();
    var mH = 0.0, mF = 0.0;
    for (final c in citizens) {
      mH += c.money;
    }
    for (final f in firms) {
      mF += f.money;
    }
    var wsum = 0.0;
    for (final c in employed) {
      final f = firm(c.employer!);
      if (f != null) wsum += f.wage;
    }
    final prices = <String, double>{};
    for (final g in goods.keys) {
      final ms = marketStats[g];
      prices[g] = ms != null && ms.qty > eps ? ms.value / ms.qty : bestPrice(g);
    }
    history.add(HistPoint(
      day: day,
      mH: mH,
      mF: mF,
      mE: state.money,
      total: mH + mF + state.money,
      unemp: n > 0 ? (n - employed.length) / n : 0.0,
      wage: employed.isNotEmpty ? wsum / employed.length : 0.0,
      prices: prices,
      gdp: householdSpend,
      hungry: citizens.where((c) => c.hunger >= 1).length,
      homeless: citizens.where((c) => c.homeless).length,
      gini: gini(),
      pop: n,
      need: needCost,
    ));
    if (history.length > 1500) history.removeAt(0);
    for (final f in firms) {
      final g0 = f.g0;
      f.hist.add(FirmPoint(f.money, f.workers.length, f.price[g0]!, f.sold[g0] ?? 0, f.revenue - f.costs));
      if (f.hist.length > 365) f.hist.removeAt(0);
      if (f.prevWorkers > 0 && f.workers.isEmpty) _log('warn', "${f.name} n'a plus d'employés.");
    }
  }

  // ============================================================= God mode
  double godMoney(Target target, double amount) {
    final list = _targets(target);
    var total = 0.0;
    for (final e in list) {
      var a = amount;
      if (a < 0) a = -math.min(-a, e.money);
      e.money += a;
      total += a;
    }
    ledgerGod += total;
    _log('god', '${total >= 0 ? 'Injection de ' : 'Retrait de '}${fmtMoney0(total.abs())} → ${_targetLabel(target)}.');
    return total;
  }

  double godGoods(int firmId, String good, double qty) {
    final f = firm(firmId);
    if (f == null) return 0;
    final before = f.inv[good] ?? 0;
    f.inv[good] = math.max(0.0, before + qty);
    final d = f.inv[good]! - before;
    _log('god',
        '${d >= 0 ? 'Ajout de ' : 'Retrait de '}${round1(d.abs())} ${goods[good]!.unit} de ${goods[good]!.label.toLowerCase()} chez ${f.name}.');
    return d;
  }

  double godDestroy(String good, double pct) {
    var lost = 0.0;
    for (final f in firms) {
      final cur = f.inv[good] ?? 0;
      if (cur > 0) {
        final q = cur * pct;
        f.inv[good] = cur - q;
        lost += q;
      }
    }
    _log('god',
        'Catastrophe : ${(pct * 100).round()} % des stocks de ${goods[good]!.label.toLowerCase()} détruits (${round1(lost)} ${goods[good]!.unit}).');
    return lost;
  }

  void godAddCitizens(int n, double money) {
    for (var i = 0; i < n; i++) {
      _newCitizen(money);
      ledgerGod += money;
    }
    _log('god', '$n nouveaux citoyens arrivent avec ${fmtMoney0(money)} chacun.');
  }

  void godRemoveCitizens(int n) {
    // départs : les sans-emploi d'abord ; leur argent quitte l'économie
    final order = List<Citizen>.from(citizens);
    stableSort<Citizen>(order, (a, b) => (a.employer != null ? 1 : 0) - (b.employer != null ? 1 : 0));
    var gone = 0;
    var money = 0.0;
    for (var i = 0; i < n && i < order.length; i++) {
      final c = order[i];
      if (firms.any((f) => f.ownerId == c.id)) continue;
      if (c.employer != null) _fire(firm(c.employer!), c);
      money += c.money;
      ledgerGod -= c.money;
      c.money = 0;
      citizens.remove(c);
      _cmap.remove(c.id);
      gone++;
    }
    _log('god', '$gone citoyens quittent la région (emportant ${fmtMoney0(money)}).');
  }

  /// Modifie une entreprise. `setCapacity` distingue « ne pas toucher » de « illimitée » (capacity == null).
  void godFirm(int id,
      {double? wage,
      bool? lockWage,
      Map<String, double>? prices,
      bool? lockPrice,
      double? prodMult,
      bool setCapacity = false,
      double? capacity}) {
    final f = firm(id);
    if (f == null) return;
    final notes = <String>[];
    if (wage != null && wage.isFinite) {
      f.wage = math.max(1.0, wage);
      notes.add('salaire ${fmtMoney0(f.wage)}');
    }
    if (lockWage != null) f.lockWage = lockWage;
    if (prices != null) {
      for (final e in prices.entries) {
        if (e.value.isFinite && f.price.containsKey(e.key)) {
          f.price[e.key] = math.max(0.01, e.value);
          notes.add('prix ${goods[e.key]!.label.toLowerCase()} ${fmtMoney0(f.price[e.key]!)}');
        }
      }
    }
    if (lockPrice != null) f.lockPrice = lockPrice;
    if (prodMult != null && prodMult.isFinite) {
      f.prodMult = math.max(0.05, prodMult);
      notes.add('productivité ×${f.prodMult.toStringAsFixed(2)}');
    }
    if (setCapacity) {
      f.capacity = capacity == null ? null : math.max(0.0, capacity);
      notes.add('capacité ${f.capacity == null ? 'illimitée' : f.capacity!.round().toString()}');
    }
    if (notes.isNotEmpty) _log('god', '${f.name} : ${notes.join(', ')}.');
  }

  void setUBI(double v) {
    params.ubi = math.max(0.0, v);
    _log('god', v > 0 ? 'Revenu de base divin : ${fmtMoney0(v)}/jour par citoyen.' : 'Revenu de base divin arrêté.');
  }

  void setTrade(bool on) {
    params.trade = on;
    _log('god', on ? 'Frontières ouvertes : import/export aux prix mondiaux.' : 'Frontières fermées : économie autarcique.');
  }

  Firm addFirm(String type, String? name, double money, int? ownerId, double x, double y) {
    final f = _newFirm(type, name, 0, ownerId, x, y);
    if (f.ownerId == null && citizens.isNotEmpty) {
      f.ownerId = citizens[(rng() * citizens.length).floor()].id;
    }
    f.money = money;
    ledgerGod += money;
    for (final g in f.outputs.keys) {
      final s = sellersOf(g).where((o) => !identical(o, f)).toList();
      if (s.isNotEmpty) {
        var sum = 0.0;
        var minP = double.infinity;
        for (final o in s) {
          sum += o.demandEma[g] ?? 0.0;
          minP = math.min(minP, o.price[g]!);
        }
        f.demandEma[g] = sum / (s.length + 1);
        f.price[g] = minP;
      } else {
        f.demandEma[g] = 1;
      }
    }
    f.vacancies = 2;
    _log('god', 'Nouvelle entreprise : ${f.name} (${templates[type]!.label.toLowerCase()}, capital ${fmtMoney0(money)}).');
    return f;
  }

  void removeFirm(int id) {
    final f = firm(id);
    if (f == null) return;
    for (final wid in List<int>.from(f.workers)) {
      _fire(f, _cmap[wid]);
    }
    final owner = f.ownerId != null ? _cmap[f.ownerId!] : null;
    if (owner != null) {
      transfer(f, owner, f.money);
    } else {
      ledgerGod -= f.money;
      f.money = 0;
    }
    firms.remove(f);
    final key = id.toString();
    flowsEma.removeWhere((k, v) => v.from == key || v.to == key);
    _log('god', '${f.name} ferme ses portes. Les employés sont mis à pied.');
  }

  List<Account> _targets(Target t) {
    switch (t.kind) {
      case 'allCitizens':
        return List<Account>.from(citizens);
      case 'allFirms':
        return List<Account>.from(firms);
      case 'citizen':
        final c = citizen(t.id ?? -1);
        return c == null ? <Account>[] : <Account>[c];
      case 'firm':
        final f = firm(t.id ?? -1);
        return f == null ? <Account>[] : <Account>[f];
      case 'unemployed':
        return List<Account>.from(citizens.where((c) => c.employer == null));
      case 'state':
        return <Account>[state];
    }
    return <Account>[];
  }

  String _targetLabel(Target t) {
    switch (t.kind) {
      case 'allCitizens':
        return 'tous les citoyens';
      case 'allFirms':
        return 'toutes les entreprises';
      case 'unemployed':
        return 'les sans-emploi';
      case 'state':
        return "l'État";
      case 'citizen':
        return citizen(t.id ?? -1)?.name ?? '?';
      case 'firm':
        return firm(t.id ?? -1)?.name ?? '?';
    }
    return '?';
  }
}
