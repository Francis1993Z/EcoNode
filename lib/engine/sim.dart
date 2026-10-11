// Moteur de simulation ÉcoNodes. Un tour = un jour.
// Toute la monnaie passe par transfer() : la masse monétaire ne change que par le god mode,
// le commerce extérieur et le crédit (un prêt de la Caisse crée de la monnaie, un remboursement en détruit).
// Les montants sont des multiples de 2⁻¹⁰ $ : additions et soustractions sont exactes en virgule flottante,
// si bien que les invariants comptables tiennent au bit près (tout écart non nul est un bogue).

import 'dart:convert';
import 'dart:math' as math;

import 'model.dart';
import 'monitor.dart';

part 'snapshot.dart';

/// mulberry32 (arithmétique 32 bits non signée) : même graine, même partie.
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

/// Mélange deux entiers de 32 bits : une étape de MurmurHash3 (x86, 32 bits) suivie de son brassage final.
/// Même arithmétique que Mulberry32 (masques, multiplication 32 bits en deux moitiés de 16 bits) : le résultat est
/// identique sur la VM (Android, ordinateur) et sur le web, où les entiers Dart sont des nombres JavaScript.
int hash32(int a, int b) {
  var k = Mulberry32._imul(b & 0xFFFFFFFF, 0xCC9E2D51);
  k = ((k << 15) | (k >>> 17)) & 0xFFFFFFFF;
  k = Mulberry32._imul(k, 0x1B873593);
  var h = (a & 0xFFFFFFFF) ^ k;
  h = ((h << 13) | (h >>> 19)) & 0xFFFFFFFF;
  h = (Mulberry32._imul(h, 5) + 0xE6546B64) & 0xFFFFFFFF;
  h ^= h >>> 16;
  h = Mulberry32._imul(h, 0x85EBCA6B);
  h ^= h >>> 13;
  h = Mulberry32._imul(h, 0xC2B2AE35);
  h ^= h >>> 16;
  return h & 0xFFFFFFFF;
}

/// Flux de hasard : un par décision. Un tirage ne dépend que de (graine, flux, jour, agent, sous-tirage), jamais de
/// l'ordre des appels : deux parties qui ne diffèrent que par une règle gardent les mêmes tirages partout ailleurs
/// (nombres aléatoires communs ; Klein et al. 2024, arXiv 2409.02086). Chaque flux a un code fixe : en ajouter un ne
/// change pas les tirages des autres. La création d'entreprise n'a pas de flux : elle ne tire rien (le fondateur est
/// le citoyen le plus riche).
enum Flux {
  traits(1), // traits à la naissance : qualification, argent, ambition, ordinateur, nom
  classes(2), // répartition des qualifications au départ
  recrutement(3), // ordre du premier recrutement
  proprietaire(4), // propriétaire d'une entreprise
  embauche(5), // ordre des chômeurs sur le marché du travail
  depart(6), // un employé part pour un meilleur salaire
  maladie(7), // maladie et sa gravité
  ordinateur(8), // envie d'acheter un ordinateur
  etudes(9), // envie de suivre un cours
  loisirs(10), // s'offrir un loisir plus cher que le budget du jour
  consommation(11), // ordre de passage des ménages
  achats(12), // ordre des entreprises pour leurs achats d'intrants et de services
  capital(13), // ordre des entreprises pour l'usure, la dette et l'investissement
  offres(14), // départage des offres à prix voisins
  prix(15), // pas d'ajustement de la marge
  divin(16); // actions du god mode (épidémie)

  const Flux(this.code);
  final int code;
}

/// Tri stable (List.sort de Dart ne l'est pas).
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
    if (i > 0 && (s.length - i) % 3 == 0) b.write(' ');
    b.write(s[i]);
  }
  return '${neg ? '-' : ''}${b.toString()} \$';
}

String fmtPct(double v, [int decimals = 1]) => '${(v * 100).toStringAsFixed(decimals).replaceAll('.', ',')} %';

double round1(double v) => (v * 10).roundToDouble() / 10;

String fmtNum1(double v) => round1(v).toStringAsFixed(1).replaceAll('.', ',');

/// Quantifie un montant au 2⁻¹⁰ $ inférieur : la somme de tels montants est exacte.
double quantize(double v) => (v * 1024).floorToDouble() / 1024;

class _Offer {
  final Firm? firm; // null = extérieur
  final double p;
  final double r;
  final double pull; // < 1 : la publicité rend l'offre plus attirante
  _Offer(this.firm, this.p, this.r, this.pull);
}

/// Plan de départ : prix et effectifs qui équilibrent l'offre et une demande estimée.
class _Plan {
  final Map<String, double> price;
  final Map<String, double> workers; // par type d'entreprise
  final Map<String, double> batches; // par type d'entreprise
  final Map<String, double> machinesPerWorker; // par type d'entreprise
  final double lambda; // part discrétionnaire de la demande retenue
  _Plan(this.price, this.workers, this.batches, this.machinesPerWorker, this.lambda);
}

// Demande quotidienne estimée par citoyen, pour dimensionner l'économie de départ.
const Map<String, double> _basicDemand = {
  'pain': 0.8,
  'viande': 0.25,
  'poisson': 0.15,
  'repas': 0.25,
  'logement': 1,
  'soins': 0.03,
  'cours': 0.12,
  'tele': 0.3,
};
const Map<String, double> _extraDemand = {
  'tele': 0.5,
  'loisirs': 0.25,
  'repas': 0.25,
  'bijoux': 0.03,
  'hotel': 0.05,
  'voyage': 0.02,
  'ordinateur': 0.003,
};

class Sim {
  late int seed;
  late Params params;
  late Modules modules;
  late Safeguards safeguards;
  bool devChecks; // mode développement : un invariant rompu lève une exception
  int day = 0;
  // identifiants stables, jamais réutilisés : les citoyens sont numérotés à partir de 1 ; une entreprise reçoit
  // 100 000 + 10 000 × (rang de son type) + son rang de création dans ce type (voir _newFirmId)
  int _nextCitizenId = 1;
  final Map<String, int> _firmSeq = {};
  // hasard (voir draw) : clés du jour par flux, achats du jour par (acheteur, bien), actions divines
  int _keysDay = -1;
  final List<int> _dayKeys = List<int>.filled(Flux.values.length, 0);
  final Map<int, int> _buySeq = {};
  int _godSeq = 0;
  List<Citizen> citizens = [];
  final Map<int, Citizen> _cmap = {};
  List<Firm> firms = [];
  final Map<int, Firm> _fmap = {};
  final Map<String, List<Firm>> _sellers = {};
  double ledgerGod = 0;
  double ledgerImports = 0;
  double ledgerExports = 0;
  double ledgerCredit = 0; // monnaie créée par le crédit, nette des remboursements
  final List<SimEvent> events = [];
  final List<HistPoint> history = [];
  Map<String, FlowEdge> flows = {};
  final Map<String, FlowEdge> flowsEma = {};
  Map<String, double> unmet = {};
  final Map<String, MarketStat> marketStats = {};
  final Map<String, int> lastShortage = {};
  final Map<String, double> unmetEma = {}; // demande non servie lissée (~10 jours), par bien
  final Map<String, int> _lastEntry = {}; // dernier jour de création, par type d'entreprise
  final Map<String, List<double>> _slots = {}; // place laissée dans le graphe par une entreprise fermée, par type
  int firmsCreated = 0;
  int firmsClosed = 0;
  double householdSpend = 0;
  // positions des nodes spéciaux (ménages, État, Caisse, extérieur) ; l'interface les dispose
  final Map<String, List<double>> nodePos = {
    'M': [1800, 120],
    'E': [1800, 0],
    'B': [1800, 520],
    'X': [1800, 640],
  };
  late StateAccount state;
  late BankAccount bank;
  late Map<String, double> worldPrice;
  late double m0;
  double needCost = 0;
  double avgWage = 0;
  double wage0 = 1; // salaire moyen au départ : base de l'indice des salaires (prix de référence corrigés)
  Map<String, double> hype = {}; // notoriété cumulée des vendeurs de chaque bien
  double adsBoost = 1; // hausse de la dépense des ménages due à la publicité
  // diagnostic
  final NetStats nets = NetStats();
  // services publics gratuits (institution I2) : files d'attente par ordre d'arrivée
  final List<int> careQueue = [];
  final List<int> schoolQueue = [];
  final Map<String, ServiceStats> services = {'soins': ServiceStats(), 'cours': ServiceStats()};
  final Monitor monitor = Monitor();
  final Invariants inv = Invariants();
  final DayFlows dayFlows = DayFlows(); // flux depuis la dernière vérification
  DayFlows lastFlows = DayFlows(); // flux de la dernière journée vérifiée
  double _depositsAtCheck = 0;
  Map<String, double> cpiWeights = {}; // panier par citoyen pour l'indice des prix
  double _cpiBase = 1;
  // Journal complet (outil en ligne de commande, trace.dart) : reçoit chaque événement ; null dans l'interface. Il ne
  // change aucun calcul : chaque appel est gardé par « trace != null », les textes ne sont construits que s'il écoute.
  void Function(TraceEvent e)? trace;

  void _t(String category, String type, String agent, int? id, String rule, String cause, double amount,
      [String detail = '']) {
    trace!(TraceEvent(day, category, type, agent, id, rule, cause, amount, detail));
  }

  Sim(
      {int seed = 42,
      Params? params,
      List<ScenarioFirm>? scenario,
      Modules? modules,
      Safeguards? safeguards,
      this.devChecks = false}) {
    reset(seed: seed, params: params, scenario: scenario, modules: modules, safeguards: safeguards);
  }

  /// Clé du jour d'un flux : hachage de (graine, flux, jour).
  int _dayKey(Flux f) {
    if (_keysDay != day) {
      for (final x in Flux.values) {
        _dayKeys[x.index] = hash32(hash32(seed & 0xFFFFFFFF, x.code), day);
      }
      _keysDay = day;
    }
    return _dayKeys[f.index];
  }

  /// Tirage uniforme dans [0, 1) qui ne dépend que de (graine, flux, jour, agent, sous-tirage), jamais de l'ordre des
  /// appels. Le sous-tirage distingue plusieurs tirages d'une même décision, pour un même agent, le même jour.
  double draw(Flux flux, int id, [int sub = 0]) {
    var h = hash32(_dayKey(flux), id);
    if (sub != 0) h = hash32(h, sub);
    return Mulberry32(h).next();
  }

  /// Clé d'ordre du jour d'un agent dans un flux.
  int orderKey(Flux flux, int id) => hash32(_dayKey(flux), id);

  /// Les agents rangés selon leur clé d'ordre du jour (égalités départagées par l'identifiant). Retirer un agent ne
  /// change pas l'ordre relatif des autres ; le mélange de Fisher-Yates qu'il remplace consommait un nombre de tirages
  /// variable, ce qui décalait tous les tirages suivants de la partie.
  List<T> _ordered<T>(Iterable<T> items, Flux flux, int Function(T) id) {
    final keyed = [for (final x in items) (orderKey(flux, id(x)), id(x), x)];
    keyed.sort((a, b) => a.$1 != b.$1 ? a.$1.compareTo(b.$1) : a.$2.compareTo(b.$2));
    return [for (final k in keyed) k.$3];
  }

  static final Map<String, int> _goodIndex = {for (final (i, g) in goods.keys.indexed) g: i};
  static final Map<String, int> _typeIndex = {for (final (i, t) in templates.keys.indexed) t: i};

  /// Identifiant d'un compte acheteur pour les tirages : citoyen, entreprise, ou 0 pour l'État.
  int _accountId(Account a) => a is Citizen ? a.id : (a is Firm ? a.id : 0);

  // ================================================================== Setup
  void reset(
      {int seed = 42, Params? params, List<ScenarioFirm>? scenario, Modules? modules, Safeguards? safeguards}) {
    this.seed = seed;
    this.params = params ?? Params();
    this.modules = modules ?? Modules();
    this.safeguards = safeguards ?? Safeguards();
    day = 0;
    _nextCitizenId = 1;
    _firmSeq.clear();
    _keysDay = -1;
    _buySeq.clear();
    _godSeq = 0;
    citizens = [];
    _cmap.clear();
    firms = [];
    _fmap.clear();
    _sellers.clear();
    ledgerGod = 0;
    ledgerImports = 0;
    ledgerExports = 0;
    ledgerCredit = 0;
    events.clear();
    history.clear();
    flows = {};
    flowsEma.clear();
    unmet = {};
    marketStats.clear();
    lastShortage.clear();
    unmetEma.clear();
    _lastEntry.clear();
    _slots.clear();
    firmsCreated = 0;
    firmsClosed = 0;
    householdSpend = 0;
    hype = {};
    adsBoost = 1;
    nets.clear();
    careQueue.clear();
    schoolQueue.clear();
    services['soins'] = ServiceStats();
    services['cours'] = ServiceStats();
    monitor.clear();
    dayFlows.reset();
    lastFlows = DayFlows();
    final p = this.params;
    state = StateAccount(250.0 * p.population);
    bank = BankAccount(quantize(p.bankCapitalPerCitizen * p.population));
    bank.capital = bank.money;
    for (final g in goods.keys) {
      marketStats[g] = MarketStat();
    }

    final full = scenario ?? defaultScenario;
    final perType = <String, int>{};
    for (final s in full) {
      perType[s.type] = (perType[s.type] ?? 0) + 1;
    }
    final plan = _plan(p, full, perType);
    // une entreprise dont le produit n'a aucune demande (module coupé) n'est pas créée
    final scen = full.where((s) => plan.batches[s.type]! > 1e-6).toList();
    worldPrice = Map<String, double>.from(plan.price);
    cpiWeights = {
      for (final g in householdGoods)
        if ((_basicDemand[g] ?? 0) + plan.lambda * (_extraDemand[g] ?? 0) > 0)
          g: (_basicDemand[g] ?? 0) + plan.lambda * (_extraDemand[g] ?? 0),
    };
    if (!this.modules.health) cpiWeights.remove('soins');
    if (!this.modules.education) cpiWeights.remove('cours');
    // un service public gratuit n'est pas un prix payé par les ménages
    for (final g in const ['soins', 'cours']) {
      if (publicGood(g)) cpiWeights.remove(g);
    }
    _cpiBase = 0;
    for (final e in cpiWeights.entries) {
      _cpiBase += e.value * plan.price[e.key]!;
    }

    // effectifs par entreprise, et qualifications à prévoir pour les pourvoir
    final staff = <int>[];
    final needByClass = [0, 0, 0];
    for (final s in scen) {
      final w = math.max(1, (plan.workers[s.type]! / perType[s.type]!).round());
      staff.add(w);
      needByClass[templates[s.type]!.skill] += w;
    }
    final pop = p.population;
    final pros = math.min(pop, (needByClass[2] * 1.15).ceil() + 1);
    final techs = math.min(pop - pros, (needByClass[1] * 1.1).ceil() + 1);
    final levels = <int>[for (var i = 0; i < pop; i++) i < pros ? 2 : (i < pros + techs ? 1 : 0)];
    // répartition des qualifications : les rangs sont rangés selon le hachage de l'identifiant à venir (i + 1)
    final ranks = _ordered(List<int>.generate(pop, (i) => i), Flux.classes, (i) => i + 1);
    final levelOf = List<int>.filled(pop, 0);
    for (var j = 0; j < pop; j++) {
      levelOf[ranks[j]] = levels[j];
    }
    for (var i = 0; i < pop; i++) {
      _newCitizen(level: levelOf[i]);
    }

    final created = <Firm>[];
    for (final s in scen) {
      final f = _newFirm(s.type, s.name, 0, null, 0, 0, plan.price);
      // échelle minimale : si la demande n'occupe pas un employé à plein temps, la petite production est moins productive
      f.rate = f.template.rate * _minScale(plan.workers[s.type]!, perType[s.type]!);
      created.add(f);
    }
    // les postes les plus qualifiés d'abord, chacun pris par le candidat le moins surqualifié
    final pool = _ordered(citizens, Flux.recrutement, (c) => c.id);
    final order = List<int>.generate(scen.length, (i) => i);
    stableSort<int>(order, (a, b) => created[b].template.skill - created[a].template.skill);
    for (final i in order) {
      final f = created[i];
      for (var k = 0; k < staff[i]; k++) {
        final c = _pickWorker(pool, f.template.skill);
        if (c == null) break;
        pool.remove(c);
        _hire(f, c);
      }
    }

    for (final f in firms) {
      final n = perType[f.type]!;
      if (f.type == 'immobilier') f.capacity = (1.06 * pop / n).ceilToDouble();
      final batches = _capBatches(f, plan.batches[f.type]! / n);
      var revenue = 0.0;
      for (final e in f.outputs.entries) {
        final d = batches * e.value;
        f.demandEma[e.key] = d;
        f.inv[e.key] = goods[e.key]!.perish ? 0 : d * p.invTargetDays;
        revenue += d * f.price[e.key]!;
      }
      var inputCost = 0.0;
      for (final e in f.inputs.entries) {
        f.inv[e.key] = batches * e.value * 5;
        inputCost += batches * e.value * plan.price[e.key]!;
      }
      f.machines = (plan.machinesPerWorker[f.type]! * f.workers.length).roundToDouble();
      f.revenueEma = revenue;
      f.outputEma = batches;
      f.money = quantize(math.max(6000.0, 12 * (f.wage * f.workers.length + inputCost)));
      f.ownerId = citizens[(draw(Flux.proprietaire, f.id) * citizens.length).floor()].id;
      if (publicService(f)) f.ownerId = null; // établissement public : l'État en est le propriétaire
    }
    for (final c in citizens) {
      final f = c.employer != null ? firm(c.employer!) : null;
      c.incomeEma = f != null ? f.wage * (1 - p.taxRate) : p.benefit;
    }
    m0 = totalMoney();
    bank.reserves = m0; // toute la monnaie de départ est « extérieure »
    bank.equity = bank.money;
    _depositsAtCheck = deposits();
    needCost = _needCost();
    _record();
    wage0 = history.last.wage > 0 ? history.last.wage : p.startWage;
    _checkInvariants();
  }

  /// Prix de référence d'un bien aujourd'hui : son prix d'équilibre au départ, corrigé de la hausse des salaires
  /// (le travail est le principal coût). Un prix bien au-dessus n'est pas de l'inflation, c'est une rente ou un coût
  /// de revient gonflé par une équipe sous-employée.
  double referencePrice(String good) {
    final w = history.isNotEmpty ? history.last.wage : 0.0;
    return worldPrice[good]! * (w > 0 && wage0 > 0 ? w / wage0 : 1.0);
  }

  /// Résout prix et effectifs de départ : la demande des ménages (besoins de base + une part discrétionnaire
  /// ajustée pour employer 94 % de la population) remonte les chaînes d'approvisionnement.
  _Plan _plan(Params p, List<ScenarioFirm> scen, Map<String, int> count) {
    final m = modules;
    final types = count.keys.toList();
    final price = <String, double>{for (final g in goods.keys) g: goods[g]!.guess};
    final pop = p.population.toDouble();
    final r = p.interestRate / 365;
    final b = <String, double>{for (final t in types) t: 1.0};
    final w = <String, double>{for (final t in types) t: 1.0};
    final k = <String, double>{for (final t in types) t: m.capital ? 0.5 * templates[t]!.capital : 0.0};
    final basic = Map<String, double>.from(_basicDemand);
    if (!m.health) basic.remove('soins');
    if (!m.education) basic.remove('cours');

    double perW(String ty) {
      final t = templates[ty]!;
      final kk = k[ty]!;
      return t.rate * (1 + t.capital * kk / (kk + 1));
    }

    double maintNeed(Template t, double workers, double machines) =>
        p.maintNeed * machines + (t.heavy ? 0.06 * workers : 0);
    bool needsMaint(Template t) => m.capital && t.maint != null && !t.outputs.containsKey(t.maint);
    bool needsCompta(Template t) => m.accounting && !t.outputs.containsKey('compta');

    // machines par employé là où une machine de plus ne rapporte plus assez (cf. _invest)
    double kStar(Template t, double wage) {
      final a = t.capital;
      if (a <= 0 || !m.capital) return 0;
      final cost = price['machines']! * (r + p.depreciation + 0.001) * 1.3;
      double gain(double kk) {
        final mpM = a / ((kk + 1) * (kk + 1));
        final mpL = 1 + a * kk / (kk + 1) - a * kk / ((kk + 1) * (kk + 1));
        return wage * mpM / mpL;
      }

      if (gain(0) <= cost) return 0;
      var lo = 0.0, hi = 4.0;
      for (var i = 0; i < 30; i++) {
        final mid = (lo + hi) / 2;
        if (gain(mid) > cost) {
          lo = mid;
        } else {
          hi = mid;
        }
      }
      return lo;
    }

    // passe 1 : équipements et effectifs sans pénalité de petite taille ; passe 2 : prix avec la pénalité,
    // équipements figés (sinon des machines chères font disparaître la demande de machines, et la Machinerie avec)
    var scaled = false;

    void solve(double lambda) {
      for (var it = 0; it < 80; it++) {
        final d = <String, double>{
          for (final g in goods.keys) g: pop * ((basic[g] ?? 0) + lambda * (_extraDemand[g] ?? 0)),
        };
        for (final ty in types) {
          final t = templates[ty]!;
          final n = count[ty]!;
          final mach = k[ty]! * w[ty]!;
          for (final e in t.inputs.entries) {
            d[e.key] = d[e.key]! + b[ty]! * e.value;
          }
          if (needsCompta(t)) d['compta'] = d['compta']! + 0.1 * n + 0.03 * w[ty]!;
          if (needsMaint(t)) d[t.maint!] = d[t.maint!]! + maintNeed(t, w[ty]!, mach);
          if (m.capital) d['machines'] = d['machines']! + p.depreciation * mach;
          if (t.ads && m.marketing) {
            var rev = 0.0;
            for (final e in t.outputs.entries) {
              rev += b[ty]! * e.value * price[e.key]!;
            }
            d['pub'] = d['pub']! + p.adsShare * rev / price['pub']!;
          }
          final rd = t.rnd;
          if (rd != null && m.rnd) d[rd] = d[rd]! + 0.3 * n;
        }
        for (final ty in types) {
          final t = templates[ty]!;
          var bb = 0.0;
          for (final e in t.outputs.entries) {
            bb = math.max(bb, d[e.key]! / e.value);
          }
          b[ty] = bb;
          w[ty] = bb / perW(ty);
        }
        for (final ty in types) {
          final t = templates[ty]!;
          final n = count[ty]!;
          final wage = p.startWage * classWage[t.skill];
          if (!scaled) k[ty] = kStar(t, wage);
          final mach = k[ty]! * w[ty]!;
          var cost = wage / (perW(ty) * (scaled ? _minScale(w[ty]!, n) : 1.0));
          for (final e in t.inputs.entries) {
            cost += e.value * price[e.key]!;
          }
          var fixed = m.capital ? price['machines']! * (r + p.depreciation) * mach : 0.0;
          if (needsCompta(t)) fixed += price['compta']! * (0.1 * n + 0.03 * w[ty]!);
          if (needsMaint(t)) fixed += price[t.maint!]! * maintNeed(t, w[ty]!, mach);
          cost += fixed / math.max(b[ty]!, 1e-3);
          final value = cost * p.markup / (t.ads && m.marketing ? 1 - p.adsShare : 1);
          var tot = 0.0;
          for (final e in t.outputs.entries) {
            tot += e.value * price[e.key]!;
          }
          for (final e in t.outputs.entries) {
            price[e.key] = value * (e.value * price[e.key]! / tot) / e.value;
          }
        }
      }
    }

    double total() => w.values.fold(0.0, (a, v) => a + v);
    final target = 0.94 * pop;
    var lambda = 0.0;
    solve(0);
    if (total() >= target) {
      // les besoins de base suffisent à occuper tout le monde : on réduit l'échelle
      final s = target / total();
      for (final ty in types) {
        w[ty] = w[ty]! * s;
        b[ty] = b[ty]! * s;
      }
    } else {
      var lo = 0.0, hi = 40.0;
      for (var i = 0; i < 30; i++) {
        final mid = (lo + hi) / 2;
        solve(mid);
        if (total() < target) {
          lo = mid;
        } else {
          hi = mid;
        }
      }
      lambda = lo;
      solve(lo);
    }
    scaled = true;
    solve(lambda);
    return _Plan(price, w, b, k, lambda);
  }

  /// Part de la productivité nominale d'une entreprise trop petite pour occuper un employé à plein temps.
  static double _minScale(double workers, int firms) => (workers / firms).clamp(0.001, 1.0).toDouble();

  /// Un citoyen. Ses traits ne dépendent que de (graine, jour, identifiant), par le flux « traits ». Au départ, sa
  /// qualification prévue (`level`) fixe son argent ; un immigrant (`money` donné) a une qualification de 0 à 1,6.
  Citizen _newCitizen({int? level, double? money}) {
    final id = _nextCitizenId++;
    double t(int k) => draw(Flux.traits, id, k);
    final skill = level != null ? level + 0.9 * t(1) : t(1) * 1.6;
    final cash = money ?? params.startWallet * (0.6 + 0.8 * t(2)) * const [1.0, 1.3, 1.8][level ?? 0];
    var name = '';
    for (var k = 0; k < 30; k++) {
      final a = firstNames[(t(10 + 2 * k) * firstNames.length).floor()];
      final b = lastNames[(t(11 + 2 * k) * lastNames.length).floor()];
      name = '$a $b';
      if (!citizens.any((x) => x.name == name)) break;
    }
    final c = Citizen(id, name, quantize(cash), skill, t(3));
    if (t(4) < const [0.2, 0.6, 0.7][c.level]) c.computerDays = (t(5) * params.computerLife).floor();
    citizens.add(c);
    _cmap[c.id] = c;
    return c;
  }

  Firm _newFirm(String type, String? name, double money, int? ownerId, double x, double y,
      [Map<String, double>? priceTable]) {
    final t = templates[type]!;
    final f = Firm(_newFirmId(type), type, name ?? t.label, Map<String, double>.from(t.inputs),
        Map<String, double>.from(t.outputs), t.rate, t.capacity, quantize(money), ownerId,
        params.startWage * classWage[t.skill], x, y);
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
    _fmap[f.id] = f;
    _rebuildSellers();
    return f;
  }

  void _rebuildSellers() {
    _sellers.clear();
    for (final f in firms) {
      for (final g in f.outputs.keys) {
        (_sellers[g] ??= []).add(f);
      }
    }
  }

  /// Identifiant stable d'une entreprise : 100 000 + 10 000 × (rang du type) + rang de création dans ce type. Créer
  /// une entreprise d'un type ne décale pas les identifiants (donc les tirages) des entreprises des autres types.
  int _newFirmId(String type) {
    final k = _firmSeq[type] = (_firmSeq[type] ?? 0) + 1;
    if (k >= 10000) throw StateError('Trop d’entreprises de type $type pour des identifiants stables');
    return 100000 + 10000 * _typeIndex[type]! + k;
  }

  // ============================================================= Utilitaires

  Citizen? citizen(int id) => _cmap[id];
  Firm? firm(int id) => _fmap[id];

  /// Dépôts : l'argent du public (citoyens, entreprises, État).
  double deposits() {
    var m = state.money;
    for (final c in citizens) {
      m += c.money;
    }
    for (final f in firms) {
      m += f.money;
    }
    return m;
  }

  /// Toute la monnaie, encaisse de la Caisse comprise.
  double totalMoney() => deposits() + bank.money;

  double expectedMoney() => m0 + ledgerGod + ledgerExports - ledgerImports + ledgerCredit;

  double totalDebt() {
    var d = 0.0;
    for (final f in firms) {
      d += f.debt;
    }
    return d;
  }

  /// Montant effectivement transféré (quantifié au 2⁻¹⁰ $ inférieur ; jamais au-delà du solde).
  double transfer(Account? from, Account? to, double amt) {
    if (!(amt > 0)) return 0;
    amt = quantize(amt);
    if (amt <= 0) return 0;
    if (from != null) {
      if (from.money + eps < amt) throw StateError('Transfert à découvert');
      if (amt > from.money) amt = from.money;
      from.money -= amt;
    }
    if (to != null) to.money += amt;
    return amt;
  }

  void _flow(String from, String to, String good, double qty, double value) {
    final k = '$from>$to>$good';
    final e = flows[k] ?? (flows[k] = FlowEdge(from, to, good, 0, 0));
    e.qty += qty;
    e.value += value;
  }

  void _hire(Firm f, Citizen c, [String why = 'poste ouvert']) {
    if (c.employer != null) {
      final old = firm(c.employer!);
      if (old != null) _fire(old, c, 'départ pour un autre emploi');
    }
    c.employer = f.id;
    c.daysUnemployed = 0;
    f.workers.add(c.id);
    if (trace != null) _t('travail', 'embauche', c.name, c.id, why, f.name, f.wage, 'entreprise ${f.id}');
  }

  void _fire(Firm? f, Citizen? c, [String why = '']) {
    if (f == null || c == null) return;
    f.workers.remove(c.id);
    c.employer = null;
    if (trace != null) _t('travail', 'fin_emploi', c.name, c.id, why, f.name, f.wage, 'entreprise ${f.id}');
  }

  /// Candidat admissible le moins surqualifié (garde les plus qualifiés pour les postes qui les exigent).
  Citizen? _pickWorker(List<Citizen> pool, int req) {
    Citizen? best;
    for (var i = pool.length - 1; i >= 0; i--) {
      final c = pool[i];
      if (c.skill + eps < req) continue;
      if (best == null || c.skill < best.skill) best = c;
    }
    return best;
  }

  /// Facteurs du rendement d'un employé ; leur produit est son efficacité (hors bonus de qualification).
  ({double faim, double logement, double sante, double moral}) efficiencyFactors(Citizen c) {
    final fun = math.min(1.0, c.sat['divertissement']! + 0.5 * c.sat['luxe']!);
    return (
      faim: c.hungerDays >= 2 ? 0.5 : (c.hungerDays == 1 ? 0.85 : 1.0),
      logement: c.homeless ? 0.8 : 1.0,
      sante: modules.health ? 0.4 + 0.6 * c.health : 1.0,
      moral: 0.85 + 0.15 * fun,
    );
  }

  /// Rendement d'un employé : faim, logement, santé, moral, et un bonus s'il est plus qualifié que le poste.
  double efficiency(Citizen c, [Firm? f]) {
    final k = efficiencyFactors(c);
    var e = k.faim * k.logement * k.sante * k.moral;
    if (f != null) e *= 1 + 0.05 * math.min(3.0, math.max(0.0, c.skill - f.template.skill));
    return e;
  }

  // ---- productivité d'une entreprise

  /// Gain dû aux machines : rendements décroissants selon le nombre de machines par employé.
  double machineMult(Firm f) {
    final a = f.template.capital;
    if (a <= 0 || !modules.capital) return 1;
    final k = f.machines / math.max(1, f.workers.length);
    return 1 + a * k / (k + 1);
  }

  /// ×1,15 par niveau. Des multiplications successives plutôt que math.pow, dont le dernier chiffre peut différer entre
  /// la VM et le web : une même graine doit donner la même partie partout.
  double techMult(Firm f) {
    var m = 1.0;
    for (var i = 1; i < f.techLevel; i++) {
      m *= 1.15;
    }
    return m;
  }

  /// Sans ingénierie, l'industrie lourde tourne au ralenti (jusqu'à moitié).
  double uptime(Firm f) => f.template.heavy && modules.capital ? 0.5 + 0.5 * f.maintCover : 1.0;

  /// Sans comptabilité, la gestion se désorganise (jusqu'à −12 %).
  double adminMult(Firm f) => 0.88 + 0.12 * f.adminCover;

  /// Lots par employé et par jour, à efficacité 1.
  double perWorker(Firm f) => f.rate * f.prodMult * machineMult(f) * techMult(f) * uptime(f) * adminMult(f);

  /// Taux annuel d'une entreprise : taux de base + prime de risque proportionnelle à son endettement,
  /// mesuré par rapport à la valeur de ses machines (garantie maximale : 80 %).
  double loanRate(Firm f, [double? machinePrice]) {
    final p = params;
    if (f.debt <= 0) return p.interestRate;
    final pm = machinePrice ?? bestPrice('machines');
    final lev = pm > 0 ? (f.debt / (math.max(f.machines, 1.0) * pm)).clamp(0.0, 1.0) : 0.0;
    return p.interestRate + p.riskSpread * lev;
  }

  /// Services de R-D à accumuler pour passer au niveau technologique suivant.
  double rndCost(int level) => 40.0 * level * level;

  double brandPull(Firm f) => 0.3 * f.brand / (f.brand + 20);

  double _capBatches(Firm f, double b) => f.capacity != null ? math.min(b, f.capacity!) : b;

  List<Firm> sellersOf(String good) => _sellers[good] ?? const <Firm>[];

  /// Meilleur prix pour une unité en stock (ou importée) ; infini si rien n'est disponible.
  double quote(String good) {
    var best = double.infinity;
    for (final f in sellersOf(good)) {
      if ((f.inv[good] ?? 0) >= 1 - eps && f.price[good]! < best) best = f.price[good]!;
    }
    if (params.trade && !goods[good]!.perish) {
      best = math.min(best, worldPrice[good]! * params.importMarkup);
    }
    return best;
  }

  /// Prix de référence : le meilleur disponible, sinon le plus bas affiché, sinon le prix mondial.
  double bestPrice(String good) {
    var best = quote(good);
    if (best == double.infinity) {
      for (final f in sellersOf(good)) {
        best = math.min(best, f.price[good]!);
      }
    }
    return best == double.infinity ? worldPrice[good]! : best;
  }

  /// Coût d'un lot : salaires, intrants au prix du marché, frais fixes (services, intérêts, usure), réparti entre les extrants.
  /// Un employé ne se divise pas : si l'équipe est sous-employée, ses salaires se répartissent sur la production prévue.
  Map<String, double> unitCost(Firm f) {
    final p = params;
    final per = math.max(eps, perWorker(f));
    final capacity = math.max(1, f.workers.length) * per;
    // utilisation de l'équipe sur ~20 jours : les achats des clients arrivent par lots, le coût ne doit pas suivre chaque creux
    final util = f.workers.isEmpty ? 1.0 : (f.outputEma / capacity).clamp(0.05, 1.0);
    var batch = f.wage / (per * util);
    final planned = math.max(math.max(f.lastBatches, _plannedBatches(f)), 0.05 * capacity);
    for (final e in f.inputs.entries) {
      batch += e.value * bestPrice(e.key);
    }
    var fixed = f.overheadEma + f.debt * loanRate(f) / 365;
    if (modules.capital) fixed += f.machines * p.depreciation * bestPrice('machines');
    batch += fixed / planned;
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

  /// Achat sur le marché : le moins cher d'abord (les ménages préfèrent un peu les marques connues).
  /// `forCitizen` : le citoyen pour qui l'État achète (aides, soins) ; ses tirages restent les siens.
  BuyResult buy(Account buyer, String buyerKey, String good, double qty, double budget, bool integer,
      {Citizen? forCitizen}) {
    budget = math.min(budget, buyer.money);
    if (qty <= eps || budget <= eps) return const BuyResult(0, 0);
    final household = buyerKey == 'M';
    // départage des offres : un tirage par (acheteur, bien, n-ième achat de ce bien aujourd'hui, vendeur)
    final who = forCitizen?.id ?? _accountId(buyer);
    final gi = _goodIndex[good]!;
    final n = _buySeq[who * 64 + gi] = (_buySeq[who * 64 + gi] ?? -1) + 1;
    final base = hash32(hash32(_dayKey(Flux.offres), who), hash32(gi, n));
    final offers = <_Offer>[];
    for (final f in sellersOf(good)) {
      if (identical(f, buyer)) continue;
      if ((f.inv[good] ?? 0) > eps) {
        offers.add(_Offer(f, f.price[good]!, Mulberry32(hash32(base, f.id)).next(), household ? 1 / (1 + brandPull(f)) : 1));
      }
    }
    final p = params;
    if (p.trade && !goods[good]!.perish) {
      offers.add(_Offer(null, worldPrice[good]! * p.importMarkup, Mulberry32(hash32(base, 0)).next(), 1));
    }
    stableSort<_Offer>(offers, (a, b) {
      final d = a.p * (1 + 0.03 * a.r) * a.pull - b.p * (1 + 0.03 * b.r) * b.pull;
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
      double paid;
      if (o.firm == null) {
        paid = transfer(buyer, null, cost);
        ledgerImports += paid;
        bank.reserves -= paid;
        dayFlows.imports += paid;
      } else {
        final s = o.firm!;
        paid = transfer(buyer, s, cost);
        s.inv[good] = (s.inv[good] ?? 0) - q;
        s.sold[good] = (s.sold[good] ?? 0) + q;
        s.revenue += paid;
      }
      _flow(o.firm == null ? 'X' : o.firm!.id.toString(), buyerKey, good, q, paid);
      final ms = marketStats[good]!;
      ms.qty += q;
      ms.value += paid;
      remaining -= q;
      spent += paid;
      if (broke) break;
    }
    if (remaining > eps && !broke) unmet[good] = (unmet[good] ?? 0) + remaining;
    return BuyResult(qty - remaining, spent);
  }

  void _log(String type, String text) {
    events.add(SimEvent(day, type, text));
    if (events.length > 300) events.removeAt(0);
  }

  /// Journal des alertes (ouverture et fermeture), appelé par le moniteur.
  void logAlert(Alert a, {required bool opened}) {
    final label = alertLabels[a.type] ?? a.type;
    if (trace != null) {
      final sub = a.subject;
      final name = sub == null ? '' : (sub.kind == 'firm' ? firm(sub.id)?.name : citizen(sub.id)?.name) ?? '';
      _t('alertes', opened ? 'ouverture' : 'fermeture', name, sub?.id, label, a.what, a.value,
          '${a.critical ? 'critique' : 'attention'} ; seuil ${a.threshold}${opened ? '' : ' ; ${(a.until ?? day) - a.since} j'}');
    }
    if (opened) {
      final who = a.agents.isEmpty ? '' : ' — ${a.agents.take(3).join(' ; ')}';
      _log('alert', '${a.critical ? '⛔' : '⚠'} $label : ${a.what}$who');
    } else {
      _log('alert', '✓ Fin de l’alerte « $label » (${(a.until ?? day) - a.since} j).');
    }
  }

  /// Coût quotidien de la survie : le point de faim le moins cher et une nuitée.
  double _needCost() {
    var food = double.infinity;
    for (final g in foods) {
      food = math.min(food, bestPrice(g) / uses[g]!.pts['faim']!);
    }
    return food + bestPrice('logement');
  }

  /// Sous ce seuil, l'État cesse de payer les soins et les cours.
  double _stateFloor() => 5 * params.benefit * math.max(4.0, citizens.length * 0.1);

  // ================================================================= Tick
  void step() {
    final p = params;
    day++;
    _buySeq.clear();
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
      f.overhead = 0;
      f.prevWorkers = f.workers.length;
    }
    for (final c in citizens) {
      c.incomeEma = 0.9 * c.incomeEma + 0.1 * c.income; // revenu complet de la veille (dividendes compris)
      c.income = 0;
      c.spend = 0;
    }
    state.taxesToday = 0;
    state.paidToday = 0;

    // 0. Revenu de base divin (création monétaire)
    if (p.ubi > 0) {
      for (final c in citizens) {
        final a = transfer(null, c, p.ubi);
        _godIn(a);
        c.income += a;
      }
    }

    _laborMarket();
    if (modules.publicBudget) _publicBudget();
    _produce();
    _payWages();
    _buyInputs();
    _consume();
    _safetyNets();
    if (p.trade) _export();
    _expire();
    _capital();
    _decide();
    _finance();
    for (final g in goods.keys) {
      unmetEma[g] = 0.9 * (unmetEma[g] ?? 0) + 0.1 * (unmet[g] ?? 0);
    }
    if (modules.entry) _entryExit();
    _record();
    _netSummary();
    _checkInvariants();
    monitor.check(this);
  }

  /// Monnaie créée (ou détruite si négatif) par le god mode pour le public.
  void _godIn(double a) {
    ledgerGod += a;
    bank.reserves += a;
    dayFlows.godPublic += a;
  }

  void _laborMarket() {
    final unemployed = _ordered(citizens.where((c) => c.employer == null), Flux.embauche, (c) => c.id);
    final hiring = firms.where((f) => f.vacancies > 0).toList();
    stableSort<Firm>(hiring, (a, b) => b.wage.compareTo(a.wage));
    for (final f in hiring) {
      while (f.vacancies > 0) {
        final c = _pickWorker(unemployed, f.template.skill);
        if (c == null) break;
        unemployed.remove(c);
        _hire(f, c, 'marché du travail : candidat admissible le moins surqualifié');
        f.vacancies--;
      }
      f.unfilledDays = f.vacancies > 0 ? f.unfilledDays + 1 : 0;
    }
    // mobilité : un employé quitte pour un meilleur salaire, si le poste est à sa portée
    final open = firms.where((f) => f.vacancies > 0).toList();
    if (open.isNotEmpty) {
      for (final c in List<Citizen>.from(citizens)) {
        if (c.employer == null || draw(Flux.depart, c.id) > params.jobSwitch) continue;
        final cur = firm(c.employer!);
        Firm? best;
        for (final b in open) {
          if (b.vacancies <= 0 || c.skill + eps < b.template.skill) continue;
          if (best == null || b.wage > best.wage) best = b;
        }
        if (cur != null && best != null && !identical(best, cur) && best.wage > cur.wage * 1.08) {
          _hire(best, c, 'mobilité : salaire plus de 8 % au-dessus');
          best.vacancies--;
        }
      }
    }
    for (final c in citizens) {
      if (c.employer == null) c.daysUnemployed++;
    }
    // assurance-emploi payée par l'État, au prorata si la caisse est vide
    final idle = citizens.where((c) => c.employer == null).toList();
    state.benefitCut = 1;
    if (modules.insurance) {
      _insurance(idle);
    } else if (idle.isNotEmpty && params.benefit > 0) {
      final each = math.min(params.benefit, state.money / idle.length);
      state.benefitCut = each / params.benefit;
      if (each > eps) {
        var total = 0.0;
        for (final c in idle) {
          final a = transfer(state, c, each);
          c.income += a;
          total += a;
        }
        state.paid += total;
        state.paidToday += total;
        _flow('E', 'M', '\$prestations', idle.length.toDouble(), total);
        if (trace != null) {
          _t('compta', 'prestations', '', null, 'prestation forfaitaire aux sans-emploi', '${idle.length} sans-emploi',
              total, state.benefitCut < 1 ? 'trésor insuffisant : ${fmtPct(state.benefitCut)} versés' : '');
        }
      }
    }
  }

  /// Rémunération assurable maximale : le salaire moyen de l'économie (I3).
  double insurableCap() {
    final w = avgWage > 0 ? avgWage : (history.isNotEmpty && history.last.wage > 0 ? history.last.wage : params.startWage);
    return params.eiInsurableCap * w;
  }

  /// Jours de prestations d'une demande, selon le taux de chômage du jour : de 36 semaines (6 % ou moins) à 45 (16 % et
  /// plus), comme pour un emploi à plein temps dans la table de la Loi sur l'assurance-emploi.
  int eiDuration(double unemp) {
    final p = params;
    final x = ((unemp - 0.06) / 0.10).clamp(0.0, 1.0);
    return (p.eiDaysLow + (p.eiDaysHigh - p.eiDaysLow) * x).round();
  }

  /// Assurance-emploi indexée puis aide sociale (institution I3). Au premier jour sans emploi, le citoyen qui a assez
  /// d'emploi assurable ouvre une demande : 55 % de son dernier salaire (plafonné) pendant une durée qui dépend du
  /// chômage. Sinon, ou une fois la durée épuisée, l'aide sociale lui verse le panier de survie. Si le trésor ne suffit
  /// pas, toutes les prestations baissent dans la même proportion.
  void _insurance(List<Citizen> idle) {
    final p = params;
    final st = state;
    st.eiClaimants = 0;
    st.assistRecipients = 0;
    st.benefitCut = 1;
    if (idle.isEmpty) return;
    final unemp = idle.length / math.max(1, citizens.length);
    final cap = insurableCap();
    final due = <double>[];
    var total = 0.0;
    for (final c in idle) {
      if (c.daysUnemployed == 1) {
        if (c.insuredDays >= p.eiQualifyingDays && c.lastWage > 0) {
          c.eiDaysLeft = eiDuration(unemp);
          c.eiBenefit = p.eiReplacement * math.min(c.lastWage, cap);
          if (trace != null) {
            _t('institutions', 'demande_ae', c.name, c.id, 'I3 : assurance-emploi', '${c.insuredDays} j assurables',
                c.eiBenefit, '${c.eiDaysLeft} j de prestations, chômage ${fmtPct(unemp)}');
          }
          c.insuredDays = 0;
        } else {
          c.eiDaysLeft = 0;
        }
      }
      final a = c.eiDaysLeft > 0 ? c.eiBenefit : needCost; // aide sociale : le panier de survie
      due.add(a);
      total += a;
    }
    final k = total > st.money ? st.money / total : 1.0;
    st.benefitCut = k;
    var ei = 0.0, assist = 0.0;
    for (var i = 0; i < idle.length; i++) {
      final c = idle[i];
      final a = transfer(st, c, due[i] * k);
      c.income += a;
      if (c.eiDaysLeft > 0) {
        c.eiDaysLeft--;
        ei += a;
        st.eiClaimants++;
      } else {
        assist += a;
        st.assistRecipients++;
      }
    }
    st.eiPaid += ei;
    st.assistPaid += assist;
    st.paid += ei + assist;
    st.paidToday += ei + assist;
    if (ei > 0) _flow('E', 'M', '\$assurance-emploi', st.eiClaimants.toDouble(), ei);
    if (assist > 0) _flow('E', 'M', '\$aide sociale', st.assistRecipients.toDouble(), assist);
    if (trace != null) {
      _t('institutions', 'prestations', '', null, 'I3 : assurance-emploi et aide sociale',
          '${st.eiClaimants} prestataires, ${st.assistRecipients} à l’aide sociale', ei + assist,
          'assurance-emploi ${fmtMoney0(ei)}, aide sociale ${fmtMoney0(assist)}'
              '${k < 1 ? ' ; trésor insuffisant : ${fmtPct(k)} versés' : ''}');
    }
  }

  void _produce() {
    for (final f in firms) {
      var eff = 0.0;
      for (final id in f.workers) {
        eff += efficiency(_cmap[id]!, f);
      }
      final laborBatches = _capBatches(f, eff * perWorker(f));
      var batches = laborBatches;
      if (f.inputs.isNotEmpty) {
        // intrants principaux : recette stricte ; intrants secondaires : la cadence baisse en proportion de leur poids.
        // Le poids se mesure au prix du jour. Essais moins bons : aux prix de référence (pain, viande et poisson
        // devenaient tous secondaires) et avec une liste explicite par recette (famine ×15) ; voir le journal.
        final theta = params.softInputShare;
        final prices = <String, double>{for (final g in f.inputs.keys) g: bestPrice(g)};
        var lotCost = f.wage / math.max(eps, perWorker(f));
        for (final e in f.inputs.entries) {
          lotCost += e.value * prices[e.key]!;
        }
        var soft = 1.0;
        for (final e in f.inputs.entries) {
          final stock = f.inv[e.key] ?? 0;
          final share = lotCost > eps ? e.value * prices[e.key]! / lotCost : 1.0;
          if (share >= theta) {
            batches = math.min(batches, stock / e.value);
          } else if (laborBatches > eps) {
            final avail = math.min(1.0, stock / (e.value * laborBatches));
            soft *= 1 - (1 - avail) * share / theta;
          }
        }
        batches = math.min(batches, laborBatches * soft);
      }
      f.inputLimited = batches < laborBatches - eps;
      // on produit la demande prévue (et le réassort du stock visé), pas toute la capacité de l'équipe
      batches = math.max(0.0, math.min(batches, _plannedBatches(f)));
      f.lastBatches = batches;
      f.outputEma = 0.95 * f.outputEma + 0.05 * batches;
      f.effWorkers = eff;
      for (final e in f.inputs.entries) {
        final stock = f.inv[e.key] ?? 0;
        f.inv[e.key] = stock - math.min(stock, batches * e.value); // un intrant secondaire manquant n'est pas consommé
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
      // assurance-emploi (I3) : cotisation sur la rémunération assurable, plafonnée au salaire moyen
      final ins = modules.insurance;
      final cot = ins ? math.min(each, insurableCap()) * params.eiRate : 0.0;
      var net = 0.0, tax = 0.0, premiums = 0.0;
      for (final id in f.workers) {
        final c = _cmap[id]!;
        final a = transfer(f, c, each * (1 - t) - cot);
        net += a;
        tax += transfer(f, state, each * t);
        if (ins) {
          premiums += transfer(f, state, cot);
          c.lastWage = f.wage;
          c.insuredDays++;
        }
        c.income += a;
      }
      f.wagesPaid = net + tax + premiums;
      f.costs += net + tax + premiums;
      state.taxes += tax;
      state.taxesToday += tax;
      state.eiPremiums += premiums;
      if (each > 0) {
        _flow(f.id.toString(), 'M', '\$salaires', n.toDouble(), net);
        if (tax > 0) _flow('M', 'E', '\$impôts', 1, tax);
      }
      if (trace != null) {
        _t('compta', 'salaires', f.name, f.id, 'paie', '$n employé(s)', net + tax + premiums,
            'net ${fmtMoney0(net)}, impôt ${fmtMoney0(tax)}, cotisations ${fmtMoney0(premiums)}'
                '${each < f.wage - eps ? ' ; salaires versés en partie' : ''}');
      }
      if (each < f.wage - eps) {
        // ne peut pas payer : mise à pied du dernier embauché
        final c = _cmap[f.workers.last];
        _fire(f, c, 'salaires impayables : mise à pied du dernier embauché');
        f.vacancies = 0;
        if (day - f.lastDistressLog > 10) {
          _log('warn', '${f.name} ne peut plus payer ses salaires — mise à pied.');
          f.lastDistressLog = day;
        }
      }
    }
  }

  /// Le bien est un service public gratuit, financé par enveloppe (institution I2).
  bool publicGood(String g) =>
      modules.publicBudget &&
      ((g == 'soins' && modules.health && modules.publicHealth) ||
          (g == 'cours' && modules.education && modules.publicEducation));

  /// Établissement public : il produit un service public gratuit (hôpital, école).
  bool publicService(Firm f) => f.outputs.keys.any(publicGood);

  /// Coût quotidien de l'équipe nécessaire à la demande attendue d'un établissement public, telle que la règle
  /// d'embauche permet de la constituer : l'effectif actuel plus les postes qu'elle ouvrirait aujourd'hui (au plus 3,
  /// et rien de plus si les intrants manquent), les intrants de ce que cette équipe peut produire, les services.
  /// Financer l'équipe théorique de la demande entière accumulerait l'argent du trésor dans un établissement qui ne peut
  /// pas l'employer (constaté : 500 000 $ dans un hôpital privé d'électronique).
  double serviceBudget(Firm f) {
    final nw = f.workers.length;
    final team = math.max(1, math.min(math.max(f.desired, nw), nw + maxPostsPerDay));
    final avgEff = nw > 0 ? math.max(0.3, f.effWorkers / nw) : 1.0;
    final batches = math.min(_plannedBatches(f), team * math.max(eps, perWorker(f) * avgEff));
    var inputs = 0.0;
    for (final e in f.inputs.entries) {
      inputs += batches * e.value * bestPrice(e.key);
    }
    return team * f.wage + inputs + f.overheadEma;
  }

  /// Enveloppe budgétaire des établissements publics (institution I2). L'État porte la trésorerie de chacun à
  /// `publicCashDays` jours du coût de l'équipe nécessaire : il rembourse ainsi chaque jour ce qui a été dépensé, dans la
  /// limite de ce coût. Au-dessus de son plancher, si le trésor ne suffit pas, toutes les enveloppes baissent dans la
  /// même proportion (et les files s'allongent). Un budget non dépensé revient au trésor.
  void _publicBudget() {
    for (final st in services.values) {
      st.envelopeToday = 0;
      st.wantedToday = 0;
    }
    final list = firms.where(publicService).toList();
    if (list.isEmpty) return;
    final want = <double>[];
    var total = 0.0;
    for (final f in list) {
      final target = params.publicCashDays * serviceBudget(f);
      final st = services[f.outputs.keys.firstWhere(publicGood)]!;
      if (f.money > 1.5 * target) {
        final back = transfer(f, state, f.money - target);
        st.envelopeTotal -= back;
        _flow(f.id.toString(), 'E', '\$budget non dépensé', 1, back);
        if (trace != null) {
          _t('institutions', 'budget_non_depense', f.name, f.id, 'I2 : enveloppe budgétaire',
              'trésorerie au-delà de 1,5 fois la cible', back, 'cible ${fmtMoney0(target)}');
        }
      }
      final w = math.max(0.0, target - f.money);
      want.add(w);
      total += w;
      st.wantedToday += w;
    }
    final avail = math.max(0.0, state.money - _stateFloor());
    final k = total > avail ? avail / total : 1.0;
    final short = <ServiceStats>{};
    for (var i = 0; i < list.length; i++) {
      if (want[i] <= 0) continue;
      final f = list[i];
      final g = f.outputs.keys.firstWhere(publicGood);
      final st = services[g]!;
      if (k < 1) short.add(st);
      final amt = transfer(state, f, want[i] * k);
      f.revenue += amt;
      st.envelopeToday += amt;
      st.envelopeTotal += amt;
      state.paid += amt;
      state.paidToday += amt;
      if (g == 'soins') {
        state.healthPaid += amt;
      } else {
        state.educationPaid += amt;
      }
      _flow('E', f.id.toString(), '\$enveloppe', 1, amt);
      if (trace != null) {
        _t('institutions', 'enveloppe', f.name, f.id, 'I2 : enveloppe budgétaire',
            k < 1 ? 'trésor insuffisant : ${fmtPct(k)} de l’enveloppe' : 'trésorerie ramenée à la cible', amt,
            'voulu ${fmtMoney0(want[i])}');
      }
    }
    for (final st in short) {
      st.shortDays++;
    }
  }

  /// Prend une unité de service public produite aujourd'hui chez un établissement public ; faux s'il n'en reste plus.
  bool _takePublic(String g) {
    for (final f in sellersOf(g)) {
      if (!publicService(f)) continue;
      final q = f.inv[g] ?? 0;
      if (q >= 1 - eps) {
        f.inv[g] = q - 1;
        f.sold[g] = (f.sold[g] ?? 0) + 1;
        _flow(f.id.toString(), 'M', g, 1, 0);
        return true;
      }
    }
    return false;
  }

  void _served(ServiceStats st, int wait) {
    st.servedToday++;
    st.servedTotal++;
    st.servedWait = 0.95 * st.servedWait + 0.05 * wait;
  }

  void _queueStats(ServiceStats st, List<int> queue, int? Function(Citizen) since) {
    st.queue = queue.length;
    var sum = 0;
    for (final id in queue) {
      sum += day - (since(_cmap[id]!) ?? day);
    }
    st.queueAge = queue.isEmpty ? 0 : sum / queue.length;
  }

  /// Soins et cours publics gratuits, servis par ordre d'arrivée avec la capacité produite aujourd'hui (I2).
  /// Ce qui reste à servir est noté comme demande non servie : c'est le signal d'embauche de l'établissement.
  void _serveQueues() {
    if (publicGood('soins')) {
      final st = services['soins']!;
      st.servedToday = 0;
      final rest = <int>[];
      var backlog = 0;
      var open = true;
      for (final id in careQueue) {
        final c = _cmap[id];
        if (c == null) continue; // a quitté l'économie
        // jusqu'à trois visites, comme une consultation payée
        var h = c.health, n = 0;
        while (open && n < 3 && h < 0.95) {
          if (!_takePublic('soins')) {
            open = false;
            break;
          }
          h = math.min(1.0, h + 0.3);
          n++;
        }
        if (n == 0) {
          rest.add(id);
          backlog += math.min(3, ((0.95 - h) / 0.3).ceil());
          continue;
        }
        c.sat['sante'] = h;
        _served(st, day - c.careSince!);
        c.careSince = null;
      }
      careQueue
        ..clear()
        ..addAll(rest);
      _queueStats(st, careQueue, (c) => c.careSince);
      if (backlog > 0) unmet['soins'] = (unmet['soins'] ?? 0) + backlog;
    }
    if (publicGood('cours')) {
      final st = services['cours']!;
      st.servedToday = 0;
      final rest = <int>[];
      var open = true;
      for (final id in schoolQueue) {
        final c = _cmap[id];
        if (c == null) continue;
        if (!open || !_takePublic('cours')) {
          open = false;
          rest.add(id);
          continue;
        }
        c.skill = math.min(3.0, c.skill + params.learnRate);
        _served(st, day - c.schoolSince!);
        c.schoolSince = null;
      }
      schoolQueue
        ..clear()
        ..addAll(rest);
      _queueStats(st, schoolQueue, (c) => c.schoolSince);
      if (rest.isNotEmpty) unmet['cours'] = (unmet['cours'] ?? 0) + rest.length;
    }
  }

  /// Lots que l'entreprise prévoit de produire (demande prévue et réassort du stock visé).
  double plannedBatches(Firm f) => _plannedBatches(f);

  /// Règle d'embauche : pour ouvrir un poste, il faut en caisse ce nombre de jours de salaire pour chaque employé,
  /// nouveaux compris.
  static const int hireCashDays = 8;

  /// Règle d'embauche : au plus ce nombre de postes ouverts par jour.
  static const int maxPostsPerDay = 3;

  /// Postes que la trésorerie permet d'ouvrir (négatif si elle ne couvre même pas l'équipe actuelle).
  int affordablePosts(Firm f) => (f.money / (f.wage * hireCashDays)).floor() - f.workers.length;

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
    for (final f in _ordered(firms, Flux.achats, (f) => f.id)) {
      if (f.inputs.isNotEmpty) {
        // on n'achète pas plus de matière que l'équipe peut transformer
        final crew = (f.workers.length + f.vacancies) * perWorker(f) * 1.2;
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
        if (wantValue > 0) {
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
      _buyServices(f);
    }
  }

  /// Services aux entreprises : comptabilité, entretien, publicité, recherche et développement.
  void _buyServices(Firm f) {
    final p = params;
    final m = modules;
    final t = f.template;
    final key = f.id.toString();
    final keep = 3 * f.wage * f.workers.length;
    double avail() => math.max(0.0, f.money - keep);
    double purchase(String g, double q, double budget) {
      final r = buy(f, key, g, q, budget, false);
      f.costs += r.spent;
      f.overhead += r.spent;
      return r.qty;
    }

    // comptabilité : toute entreprise en a besoin, selon sa taille
    if (!m.accounting || f.outputs.containsKey('compta')) {
      f.adminCover = 1;
    } else {
      final need = 0.1 + 0.03 * f.workers.length;
      final got = purchase('compta', need, avail());
      f.adminCover = 0.8 * f.adminCover + 0.2 * math.min(1.0, got / need);
    }
    // entretien des machines (et des opérations, pour l'industrie lourde)
    final mt = t.maint;
    if (!m.capital || mt == null || f.outputs.containsKey(mt)) {
      f.maintToday = 1;
      f.maintCover = 1;
    } else {
      final need = p.maintNeed * f.machines + (t.heavy ? 0.06 * f.workers.length : 0);
      final cover = need > eps ? math.min(1.0, purchase(mt, need, avail()) / need) : 1.0;
      f.maintToday = cover;
      f.maintCover = 0.85 * f.maintCover + 0.15 * cover;
    }
    // publicité : une part du chiffre d'affaires, tant que l'entreprise est rentable
    if (m.marketing && t.ads && f.profitEma > 0) {
      final budget = math.min(avail(), p.adsShare * f.revenueEma);
      final pp = bestPrice('pub');
      if (budget > 0.05 * pp) f.brand += purchase('pub', budget / pp, budget);
    }
    // recherche et développement : une part de la trésorerie excédentaire
    final rd = t.rnd;
    if (m.rnd && rd != null && f.profitEma > 0) {
      final reserve = 8 * (f.wage * f.workers.length + f.inputSpendEma);
      final budget = p.rndShare * math.max(0.0, f.money - reserve);
      final pr = bestPrice(rd);
      if (budget > 0.1 * pr) {
        f.rndProgress += purchase(rd, budget / pr, budget);
        final cost = rndCost(f.techLevel);
        if (f.rndProgress >= cost) {
          f.rndProgress -= cost;
          f.techLevel++;
          _log('info',
              '${f.name} passe à la technologie de niveau ${f.techLevel} (productivité ×${techMult(f).toStringAsFixed(2)}).');
        }
      }
    }
  }

  void _consume() {
    final p = params;
    needCost = _needCost();
    // pression publicitaire : notoriété des vendeurs de chaque bien
    hype = {};
    var totalBrand = 0.0;
    if (modules.marketing) {
      for (final f in firms) {
        if (f.brand <= eps) continue;
        totalBrand += f.brand;
        for (final g in f.outputs.keys) {
          hype[g] = (hype[g] ?? 0) + f.brand;
        }
      }
    }
    adsBoost = 1 + p.adsEffect * totalBrand / (totalBrand + 0.3 * math.max(1, citizens.length));
    final floor = _stateFloor();

    for (final c in _ordered(citizens, Flux.consommation, (c) => c.id)) {
      final before = c.money;
      for (final d in desires) {
        if (d != 'sante') c.sat[d] = math.max(0.0, c.sat[d]! - desireDecay[d]!);
      }
      // 1. manger : l'aliment qui rassasie le mieux pour son prix, selon ses goûts
      for (var n = 0; n < 5 && c.sat['faim']! < 1 - eps; n++) {
        final g = _choose(c, foods, 'faim', c.money, null, signal: n == 0);
        if (g == null) break;
        final r = buy(c, 'M', g, 1, c.money, true);
        if (r.qty < 1) break;
        _enjoy(c, g);
      }
      c.hungerDays = c.sat['faim']! < 0.5 ? c.hungerDays + 1 : 0;
      // 2. se loger
      final rl = buy(c, 'M', 'logement', 1, c.money, true);
      c.homeless = rl.qty < 1;
      c.homelessDays = c.homeless ? c.homelessDays + 1 : 0;
      c.sat['logement'] = c.homeless ? 0 : 1;
      // 3. se soigner, s'équiper, se former
      _health(c, floor);
      _computer(c);
      if (modules.education) _study(c, floor);
      // 4. se faire plaisir avec une part de l'épargne au-delà du coussin
      _leisure(c);
      c.spend = before - c.money;
      householdSpend += c.spend;
      c.happiness = happinessOf(c);
    }
    if (modules.publicBudget) _serveQueues();
  }

  /// Le bien qui apporte le plus de satisfaction par dollar, parmi ceux en stock et abordables.
  /// Si le favori manque, la demande non servie est notée (signal pour son producteur).
  String? _choose(Citizen c, List<String> list, String desire, double budget, Map<String, int>? counts,
      {bool signal = false}) {
    final lvl = c.level;
    String? best, top;
    var bestScore = 0.0, topScore = 0.0;
    for (final g in list) {
      final u = uses[g]!;
      final pts = u.pts[desire] ?? 0;
      if (pts <= 0) continue;
      final h = hype[g] ?? 0;
      final n = (counts?[g] ?? 0) / (dailyNorm[g] ?? 1);
      final appeal = u.taste[lvl] * pts * (1 + 0.4 * h / (h + 10)) / (1 + n * n);
      final s0 = appeal / math.max(0.01, bestPrice(g));
      if (s0 > topScore) {
        topScore = s0;
        top = g;
      }
      final q = quote(g);
      if (!q.isFinite || q > budget) continue;
      final s = appeal / math.max(0.01, q);
      if (s > bestScore) {
        bestScore = s;
        best = g;
      }
    }
    if (signal && top != null && top != best && !quote(top).isFinite) unmet[top] = (unmet[top] ?? 0) + 1;
    return best;
  }

  void _enjoy(Citizen c, String g) {
    for (final e in uses[g]!.pts.entries) {
      c.sat[e.key] = math.min(1.0, c.sat[e.key]! + e.value);
    }
  }

  /// Usure lente, maladies au hasard ; sous 75 % on consulte (aux frais de l'État si la santé est publique).
  void _health(Citizen c, double floor) {
    final p = params;
    if (!modules.health) {
      c.sat['sante'] = 1;
      return;
    }
    var h = c.health - desireDecay['sante']!;
    if (draw(Flux.maladie, c.id) < p.illness) h -= 0.2 + 0.3 * draw(Flux.maladie, c.id, 1);
    h = h.clamp(0.05, 1.0).toDouble();
    if (publicGood('soins')) {
      // soins publics gratuits : on s'inscrit dans la file de l'hôpital, servie par ordre d'arrivée (I2)
      if (h < 0.75 && c.careSince == null) {
        c.careSince = day;
        careQueue.add(c.id);
      }
      c.sat['sante'] = h;
      return;
    }
    if (h < 0.75) {
      for (var n = 0; n < 3 && h < 0.95; n++) {
        final pub = modules.publicHealth && state.money > floor;
        final r = buy(pub ? state : c, 'M', 'soins', 1, pub ? state.money - floor : c.money, true, forCitizen: c);
        if (r.qty < 1) break;
        h = math.min(1.0, h + 0.3);
        if (pub) {
          state.paid += r.spent;
          state.paidToday += r.spent;
          state.healthPaid += r.spent;
          _flow('E', 'M', '\$santé publique', 1, r.spent);
        }
      }
    }
    c.sat['sante'] = h;
  }

  /// Un ordinateur dure un an et divertit chaque jour ; techniciens et professionnels y tiennent.
  void _computer(Citizen c) {
    if (c.computerDays > 0) {
      c.computerDays--;
      c.sat['divertissement'] = math.min(1.0, c.sat['divertissement']! + 0.08);
      return;
    }
    if (draw(Flux.ordinateur, c.id) >= computerWish[c.level] * adsBoost) return;
    final pr = quote('ordinateur');
    if (!pr.isFinite) {
      unmet['ordinateur'] = (unmet['ordinateur'] ?? 0) + 1;
      return;
    }
    if (c.money - params.bufferDays * needCost < 2 * pr) return;
    final r = buy(c, 'M', 'ordinateur', 1, c.money, true);
    if (r.qty >= 1) c.computerDays = params.computerLife;
  }

  /// Les ambitieux suivent des cours ; la qualification monte d'un cran tous les 50 cours.
  void _study(Citizen c, double floor) {
    final p = params;
    if (c.skill >= 3 || draw(Flux.etudes, c.id) >= c.ambition * p.eduRate) return;
    if (publicGood('cours')) {
      // cours publics gratuits : on s'inscrit dans la file de l'école (I2)
      if (c.schoolSince == null) {
        c.schoolSince = day;
        schoolQueue.add(c.id);
      }
      return;
    }
    final pub = modules.publicEducation && state.money > floor;
    if (!pub) {
      final pr = quote('cours');
      if (pr.isFinite && c.money - p.bufferDays * needCost < 10 * pr) return;
    }
    final r = buy(pub ? state : c, 'M', 'cours', 1, pub ? state.money - floor : c.money, true, forCitizen: c);
    if (r.qty < 1) return;
    c.skill = math.min(3.0, c.skill + p.learnRate);
    if (pub) {
      state.paid += r.spent;
      state.paidToday += r.spent;
      state.educationPaid += r.spent;
      _flow('E', 'M', '\$éducation publique', 1, r.spent);
    }
  }

  /// Budget discrétionnaire du jour : C = α₁ · (revenu − besoins) + α₂ · (richesse − coussin), à la Godley-Lavoie.
  /// Chaque ménage converge vers T jours de revenu discrétionnaire ; personne n'accumule sans fin.
  /// La publicité accélère la dépense de l'épargne (richesse visée T / adsBoost) ; elle ne fait pas dépenser
  /// plus que le revenu, ce qui viderait les ménages puis ferait monter les prix.
  double leisureBudget(Citizen c) {
    final p = params;
    final excess = math.max(0.0, c.money - p.bufferDays * needCost);
    final income = math.max(0.0, c.incomeEma - needCost);
    return p.mpcIncome * income + p.propensity * adsBoost * excess;
  }

  /// Dépenses discrétionnaires : le budget du jour, réparti entre divertissement et luxe selon la classe,
  /// puis dépensé bien par bien (le plus de satisfaction par dollar, lassitude comprise).
  void _leisure(Citizen c) {
    final budget = math.min(leisureBudget(c), c.money);
    if (budget <= eps) return;
    final lvl = c.level;
    final wDiv = desireWeight['divertissement']![lvl] * (0.25 + math.max(0.0, 1 - c.sat['divertissement']!));
    final wLux = desireWeight['luxe']![lvl] * (0.25 + math.max(0.0, 1 - c.sat['luxe']!));
    final counts = <String, int>{};
    for (var di = 0; di < 2; di++) {
      final d = const ['divertissement', 'luxe'][di];
      var share = budget * (d == 'luxe' ? wLux : wDiv) / (wDiv + wLux);
      for (var k = 0; k < 60 && share > eps; k++) {
        var g = _choose(c, desireGoods[d]!, d, share, counts, signal: k == 0);
        if (g == null) {
          // rien d'abordable avec ce budget : on s'offre le favori de temps en temps (en moyenne, le budget)
          g = _choose(c, desireGoods[d]!, d, double.infinity, counts);
          if (g == null || draw(Flux.loisirs, c.id, di * 64 + k) >= share / quote(g)) break;
        }
        final r = buy(c, 'M', g, 1, c.money, true);
        if (r.qty < 1) break;
        _enjoy(c, g);
        counts[g] = (counts[g] ?? 0) + 1;
        share -= r.spent;
      }
    }
  }

  /// Bonheur : moyenne des satisfactions, pondérée selon ce qui compte pour sa classe.
  double happinessOf(Citizen c) {
    final lvl = c.level;
    var s = 0.0, w = 0.0;
    for (final d in desires) {
      final k = happinessWeight[d]![lvl];
      s += k * c.sat[d]!;
      w += k;
    }
    return s / w;
  }

  // ================================================================ Filets de sécurité

  /// Enregistre un déclenchement : compté, journalisé (jour, agent, montant, raison), résumé dans le journal du jour.
  void _net(String net, String agent, double amount, String cause, [String detail = '', int? id]) {
    nets.add(NetEvent(day, net, agent, amount, detail.isEmpty ? cause : '$cause — $detail'), cause);
    if (trace != null) _t('filets', net, agent, id, 'filet : ${Safeguards.labels[net]}', cause, amount, detail);
  }

  /// Pourquoi ce citoyen n'arrive pas à manger.
  String famineCause(Citizen c) {
    var cheapest = double.infinity;
    for (final g in foods) {
      cheapest = math.min(cheapest, quote(g));
    }
    if (!cheapest.isFinite) return 'pas de producteur';
    if (c.income <= eps && c.money < cheapest) return 'pas de revenu';
    return 'prix trop élevé';
  }

  /// Pourquoi ce citoyen n'a pas de logis.
  String shelterCause(Citizen c) {
    final q = quote('logement');
    if (!q.isFinite) return 'parc plein';
    if (c.income <= eps && c.money < q) return 'pas de revenu';
    return 'prix trop élevé';
  }

  void _safetyNets() {
    final sg = safeguards;
    if (!sg.famine && !sg.shelter) return;
    for (final c in citizens) {
      if (sg.famine && c.hungerDays >= sg.famineDays) _famineAid(c);
      if (sg.shelter && c.homelessDays >= sg.shelterDays) _shelterAid(c);
    }
  }

  /// Anti-famine : l'État achète de quoi manger ; à défaut (aucun stock, trésor vide), une ration magique.
  void _famineAid(Citizen c) {
    final cause = famineCause(c);
    final detail = cause == 'pas de producteur'
        ? 'aucun aliment en stock'
        : 'argent ${fmtMoney0(c.money)}, revenu du jour ${fmtMoney0(c.income)}';
    var spent = 0.0;
    for (var n = 0; n < 4 && c.sat['faim']! < 1 - eps; n++) {
      final g = _choose(c, foods, 'faim', state.money, null);
      if (g == null) break;
      final r = buy(state, 'M', g, 1, state.money, true, forCitizen: c);
      if (r.qty < 1) break;
      _enjoy(c, g);
      spent += r.spent;
    }
    final magic = c.sat['faim']! < 0.5;
    if (magic) c.sat['faim'] = 1; // ration magique : ni bien ni argent
    if (spent > 0) {
      state.paid += spent;
      state.paidToday += spent;
      _flow('E', 'M', '\$aide alimentaire', 1, spent);
    }
    c.hungerDays = 0;
    _net('famine', c.name, spent, cause, magic ? '$detail ; ration magique' : detail, c.id);
  }

  /// Plancher de logement : l'État paie une nuitée ; si le parc est plein, un abri d'urgence (magique).
  void _shelterAid(Citizen c) {
    final cause = shelterCause(c);
    final r = buy(state, 'M', 'logement', 1, state.money, true, forCitizen: c);
    final magic = r.qty < 1;
    if (r.spent > 0) {
      state.paid += r.spent;
      state.paidToday += r.spent;
      _flow('E', 'M', '\$abri d’urgence', 1, r.spent);
    }
    c.homeless = false;
    c.homelessDays = 0;
    c.sat['logement'] = 1;
    _net('shelter', c.name, r.spent, cause,
        magic ? 'abri d’urgence magique' : 'argent ${fmtMoney0(c.money)}, revenu du jour ${fmtMoney0(c.income)}', c.id);
  }

  /// Résumé quotidien des filets déclenchés, dans le journal principal.
  void _netSummary() {
    for (final e in nets.today.entries) {
      final causes = nets.causesToday[e.key]!.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      final why = causes.take(3).map((c) => '${c.key} ×${c.value}').join(', ');
      _log('net', 'Filet « ${Safeguards.labels[e.key]} » : ${e.value} déclenchement${e.value > 1 ? 's' : ''} ($why).');
    }
    nets.today.clear();
    nets.causesToday.clear();
  }

  void _export() {
    for (final f in firms) {
      for (final g in f.outputs.keys) {
        if (goods[g]!.perish) continue;
        final excess = (f.inv[g] ?? 0) - 8 * math.max(f.demandEma[g] ?? 0, 0.5);
        if (excess <= eps) continue;
        final value = transfer(null, f, excess * worldPrice[g]! * params.exportDiscount);
        f.inv[g] = (f.inv[g] ?? 0) - excess;
        f.revenue += value;
        ledgerExports += value;
        bank.reserves += value;
        dayFlows.exports += value;
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

  /// Usure des machines, service de la dette, investissement, ristournes de la Caisse.
  void _capital() {
    final p = params;
    final pm = bestPrice('machines');
    for (final f in _ordered(firms, Flux.capital, (f) => f.id)) {
      final key = f.id.toString();
      // usure : deux fois et demie plus rapide sans entretien
      if (modules.capital && f.machines > eps) {
        final cover = f.template.maint == null ? 1.0 : f.maintToday;
        final dep = f.machines * p.depreciation * (1 + 1.5 * (1 - cover));
        f.machines = math.max(0.0, f.machines - dep);
        f.costs += dep * pm; // amortissement : un coût, sans mouvement d'argent
      }
      // service de la dette
      f.interestToday = 0;
      if (f.debt > 0) {
        final interest = quantize(f.debt * loanRate(f, pm) / 365);
        if (f.money >= interest) {
          final paid = transfer(f, bank, interest);
          bank.interest += paid;
          bank.equity += paid;
          dayFlows.interest += paid;
          f.costs += paid;
          f.interestToday = paid;
          _flow(key, 'B', '\$intérêts', 1, paid);
          if (trace != null) {
            _t('compta', 'interets', f.name, f.id, 'service de la dette', 'intérêts du jour', paid,
                'dette ${fmtMoney0(f.debt)}');
          }
          final reserve = 6 * (f.wage * f.workers.length + f.inputSpendEma);
          var pay = math.max(f.debt / p.loanTermDays, 5.0);
          if (f.money > 2 * reserve) pay += 0.05 * (f.money - 2 * reserve); // remboursement anticipé
          pay = math.min(pay, math.min(f.debt, math.max(0.0, f.money - 2 * f.wage * f.workers.length)));
          final repaid = transfer(f, null, pay); // le remboursement détruit la monnaie créée par le prêt
          if (repaid > 0) {
            ledgerCredit -= repaid;
            f.debt -= repaid;
            bank.repaid += repaid;
            dayFlows.repaid += repaid;
            _flow(key, 'B', '\$remboursements', 1, repaid);
            if (trace != null) {
              _t('compta', 'remboursement', f.name, f.id, 'service de la dette', 'remboursement du capital', repaid,
                  'reste ${fmtMoney0(f.debt)}');
            }
          }
          f.missedPayments = 0;
        } else {
          f.debt += interest; // intérêts impayés ajoutés à la dette
          bank.capitalized += interest;
          bank.equity += interest;
          dayFlows.capitalized += interest;
          f.missedPayments++;
          if (trace != null) {
            _t('credit', 'interets_impayes', f.name, f.id, 'service de la dette', 'trésorerie insuffisante', interest,
                '${f.missedPayments} j de retard');
          }
          if (f.missedPayments > 60) {
            _log('warn', '${f.name} ne rembourse plus : la Caisse radie ${fmtMoney0(f.debt)} de dette.');
            _writeOff(f, 'plus de 60 jours de retard');
            f.creditBanUntil = day + 180;
          }
        }
      }
      if (modules.capital) _invest(f, pm);
    }
    // la Caisse ristourne son surplus à ses membres (tous les citoyens), une fois ses fonds propres au-dessus
    // de la cible (part des prêts) et de son capital de départ
    final surplus = math.min(bank.money, bank.equity - math.max(bank.capital, p.bankTargetRatio * totalDebt()));
    if (surplus > eps && citizens.isNotEmpty && p.bankRebate > 0) {
      final each = surplus * p.bankRebate / citizens.length;
      var total = 0.0;
      for (final c in citizens) {
        final a = transfer(bank, c, each);
        c.income += a;
        total += a;
      }
      bank.rebates += total;
      bank.equity -= total;
      dayFlows.rebates += total;
      _flow('B', 'M', '\$ristournes', 1, total);
      if (trace != null) {
        _t('compta', 'ristourne', 'Caisse', null, 'ristourne du surplus de la Caisse', 'fonds propres au-dessus de la cible',
            total, '${citizens.length} membres');
      }
    }
  }

  /// Faillite ordonnée (I5) : la trésorerie rembourse d'abord la dette envers la Caisse. Comme tout remboursement de
  /// capital, il détruit la monnaie créée par le prêt. Rend le montant remboursé ; le solde éventuel sera radié.
  double _repayFromCash(Firm f) {
    if (f.debt <= 0 || f.money <= 0) return 0;
    final repaid = transfer(f, null, math.min(f.money, f.debt));
    if (repaid <= 0) return 0;
    ledgerCredit -= repaid;
    f.debt -= repaid;
    bank.repaid += repaid;
    dayFlows.repaid += repaid;
    _flow(f.id.toString(), 'B', '\$remboursements', 1, repaid);
    if (trace != null) {
      _t('institutions', 'remboursement_faillite', f.name, f.id, 'I5 : faillite ordonnée',
          'la trésorerie rembourse la Caisse avant tout', repaid, 'reste ${fmtMoney0(f.debt)} à radier');
    }
    return repaid;
  }

  /// La Caisse renonce à la créance : la perte est imputée à ses fonds propres, la monnaie déjà créée reste.
  void _writeOff(Firm f, [String why = '']) {
    if (f.debt <= 0) return;
    if (trace != null) _t('credit', 'radiation', f.name, f.id, 'radiation de créance', why, f.debt);
    bank.writtenOff += f.debt;
    bank.equity -= f.debt;
    dayFlows.writtenOff += f.debt;
    f.debt = 0;
    f.missedPayments = 0;
  }

  /// Achète une machine si elle rapporte plus qu'elle ne coûte (intérêts + usure), à crédit au besoin.
  void _invest(Firm f, double pm) {
    final p = params;
    final t = f.template;
    final nw = f.workers.length;
    if (t.capital <= 0 || nw == 0 || day - f.lastInvest < 3 || !pm.isFinite) return;
    final w = nw.toDouble();
    final k = f.machines / w;
    if (k >= 4) return;
    final base = f.rate * f.prodMult * techMult(f) * uptime(f) * adminMult(f) * math.max(0.3, f.effWorkers / w);
    final a = t.capital;
    final mpM = base * a / ((k + 1) * (k + 1)); // lots/jour qu'apporterait une machine de plus
    final mpL = base * (1 + a * k / (k + 1)) - base * a * k / ((k + 1) * (k + 1)); // … un employé de plus
    var margin = 0.0;
    for (final e in f.outputs.entries) {
      margin += e.value * (f.price[e.key] ?? 0);
    }
    for (final e in f.inputs.entries) {
      margin -= e.value * bestPrice(e.key);
    }
    // une équipe déjà sous-employée n'a besoin d'aucune capacité de plus
    if (f.outputEma < 0.8 * w * perWorker(f)) return;
    // si la demande attend, la machine rapporte des ventes ; sinon elle remplace du travail, ce qui suppose
    // de pouvoir se passer d'un employé (impossible sous un employé)
    final growing = f.urgency > 0.05 || (f.vacancies > 0 && f.unfilledDays > 1);
    final value = growing ? mpM * math.max(0.0, margin) : (nw >= 2 ? f.wage * mpM / math.max(eps, mpL) : 0.0);
    final cost = pm * (loanRate(f, pm) / 365 + p.depreciation + 0.001);
    if (value < 1.3 * cost) return;
    final price = quote('machines');
    if (!price.isFinite) {
      unmet['machines'] = (unmet['machines'] ?? 0) + 1;
      return;
    }
    final cash = f.money - 6 * (f.wage * w + f.inputSpendEma);
    if (cash < price) {
      // pas de crédit à une entreprise en perte, ni à un établissement public (l'État le finance)
      if (!modules.credit || day < f.creditBanUntil || f.profitEma <= 0 || publicService(f)) return;
      final need = price - math.max(0.0, cash);
      if (f.debt + need > 0.8 * (f.machines + 1) * price) return; // garantie : 80 % de la valeur des machines
      if ((modules.bankRegulation || safeguards.credit) && !_creditOk(f, need)) return;
      _lend(f, need);
    }
    final r = buy(f, f.id.toString(), 'machines', 1, f.money, true);
    if (r.qty >= 1) {
      f.machines += 1;
      f.lastInvest = day;
    }
  }

  /// Fonds de roulement : une entreprise qui a des clients en attente et vend au-dessus de son coût emprunte
  /// de quoi payer 8 jours de salaires aux postes qu'elle veut ouvrir, dans la limite de 30 jours de chiffre d'affaires.
  void _workingCapital(Firm f, int posts) {
    final p = params;
    if (!modules.credit || posts <= 0 || day < f.creditBanUntil || f.urgency < 0.05) return;
    if (publicService(f)) return; // un établissement public n'emprunte pas : l'État le finance
    // la Caisse ne finance qu'une entreprise durablement rentable, dont les ventes couvrent déjà les salaires
    if (f.profitEma <= 0 || f.revenueEma < f.wage * f.workers.length) return;
    final need = f.wage * 8 * (f.workers.length + posts) - f.money;
    if (need <= 0) return;
    final room = p.workingCapitalDays * f.revenueEma - f.debt;
    final amt = math.min(need, room);
    if (amt < f.wage * 8) return; // pas même de quoi ouvrir un poste
    if ((modules.bankRegulation || safeguards.credit) && !_creditOk(f, amt)) return;
    _lend(f, amt, working: true);
  }

  /// Anti-crédit-fou : plafond paiements/valeur ajoutée et ratio minimal de fonds propres de la Caisse.
  bool _creditOk(Firm f, double need) {
    final sg = safeguards;
    final p = params;
    final pay = (f.debt + need) * (loanRate(f) / 365 + 1 / p.loanTermDays);
    final added = math.max(0.0, f.revenueEma - f.inputSpendEma);
    if (pay > sg.maxPaymentRatio * added) {
      _refuse(f, need, 'paiements > ${fmtPct(sg.maxPaymentRatio, 0)} de la valeur ajoutée',
          '${fmtMoney0(pay)}/j pour ${fmtMoney0(added)}/j de valeur ajoutée');
      return false;
    }
    final loans = totalDebt() + need;
    if (bank.equity < sg.minCapitalRatio * loans) {
      _refuse(f, need, 'fonds propres de la Caisse insuffisants',
          '${fmtMoney0(bank.equity)} pour ${fmtMoney0(loans)} de prêts (minimum ${fmtPct(sg.minCapitalRatio)})');
      return false;
    }
    return true;
  }

  /// Un prêt refusé : compté par la Caisse ; le filet anti-crédit-fou, s'il est actif, le compte aussi. Avec les règles
  /// prudentielles (I4), le filet n'a plus d'effet propre : c'est la Caisse qui refuse.
  void _refuse(Firm f, double need, String cause, String detail) {
    bank.refusals++;
    if (safeguards.credit) _net('credit', f.name, need, cause, detail, f.id);
    if (trace != null) {
      _t('credit', 'refus', f.name, f.id,
          modules.bankRegulation ? 'I4 : règles prudentielles de la Caisse' : 'filet : anti-crédit-fou', cause, need,
          detail);
    }
  }

  void _lend(Firm f, double amt, {bool working = false}) {
    final a = transfer(null, f, amt); // la Caisse crée la monnaie qu'elle prête
    f.debt += a;
    ledgerCredit += a;
    bank.lent += a;
    if (working) {
      bank.lentWorking += a;
      f.workingDebt += a;
    } else {
      bank.lentMachines += a;
    }
    dayFlows.loans += a;
    _flow('B', f.id.toString(), '\$prêts', 1, a);
    if (trace != null) {
      _t('credit', 'pret', f.name, f.id, working ? 'fonds de roulement' : 'achat de machine',
          working ? 'clients en attente, postes à ouvrir' : 'machine rentable', a, 'dette ${fmtMoney0(f.debt)}');
    }
  }

  // ================================================================ Entrée et sortie d'entreprises

  /// Salaire du marché pour une qualification exigée (moyenne pondérée par les effectifs).
  double marketWage(int skill) {
    var ws = 0.0, wn = 0;
    for (final o in firms) {
      if (o.template.skill != skill) continue;
      ws += o.wage * o.workers.length;
      wn += o.workers.length;
    }
    return wn > 0 ? ws / wn : params.startWage * classWage[skill];
  }

  /// Sortie : une entreprise sans employé depuis 30 jours ferme. Entrée : un bien qui n'a plus de producteur
  /// (ou dont les producteurs ont de fortes marges et laissent de quoi occuper un employé) attire une nouvelle entreprise.
  void _entryExit() {
    final p = params;
    for (final f in List<Firm>.from(firms)) {
      f.idleDays = f.workers.isEmpty ? f.idleDays + 1 : 0;
      if (f.idleDays >= p.exitIdleDays && !publicService(f)) _close(f); // un établissement public ne ferme pas
    }
    if (day < 30) return; // pas pendant le démarrage
    for (final ty in templates.keys) {
      if (day - (_lastEntry[ty] ?? -100000) < p.entryCooldown) continue;
      final t = templates[ty]!;
      final g = t.outputs.keys.first;
      if (publicGood(g)) continue; // l'État fournit ce service : pas de concurrent privé
      final want = unmetEma[g] ?? 0; // unités par jour non servies
      final perWorker0 = t.rate * t.outputs[g]!; // unités par employé et par jour, sans machines
      if (want < p.entryMinShare * perWorker0) continue;
      final active = sellersOf(g).where((f) => f.workers.isNotEmpty).toList();
      String why;
      if (active.isEmpty) {
        why = 'plus personne ne produit';
      } else {
        // concurrence : seulement après le démarrage, si les marges sont fortes et que la demande laissée occupe
        // un employé à plein temps
        if (day < 100 || active.length >= 3 || want < perWorker0) continue;
        if (!active.every((f) => f.profitEma > 0 && f.price[g]! >= p.entryMarginRatio * (f.unitCostCache[g] ?? double.infinity))) {
          continue;
        }
        why = 'demande non servie et fortes marges';
      }
      if (_found(ty, want, why)) return; // au plus une création par jour
    }
  }

  /// Un citoyen fonde une entreprise de ce type avec son épargne (10 jours de salaires, 5 jours d'intrants).
  bool _found(String ty, double want, String why) {
    final p = params;
    final t = templates[ty]!;
    final g = t.outputs.keys.first;
    final batches = want / t.outputs[g]!;
    final w = batches / t.rate; // employés nécessaires à productivité nominale
    final team = w.ceil().clamp(1, 3).toInt();
    final wage = marketWage(t.skill);
    var inputCost = 0.0;
    for (final e in t.inputs.entries) {
      inputCost += batches * e.value * bestPrice(e.key);
    }
    // une entreprise nouvelle embauche des chômeurs ; au plein emploi, elle ne ferait que débaucher ses voisines
    final available = citizens.where((c) => c.employer == null && c.skill + eps >= t.skill).length;
    if (available < team) return false;
    // viabilité : au prix que le marché paie (borné au double du prix mondial), les ventes attendues doivent couvrir
    // l'équipe et ses intrants ; un marché trop petit pour un employé reste sans producteur
    var revenue0 = 0.0;
    for (final e in t.outputs.entries) {
      revenue0 += batches * e.value * math.min(bestPrice(e.key), 2 * worldPrice[e.key]!);
    }
    if (revenue0 < 1.1 * (team * wage + inputCost)) return false;
    final capital = 10 * wage * team + 5 * inputCost;
    final buffer = p.bufferDays * needCost;
    Citizen? founder;
    for (final c in citizens) {
      if (c.money - buffer >= 1.5 * capital && (founder == null || c.money > founder.money)) founder = c;
    }
    if (founder == null) return false;
    final same = firms.where((o) => o.type == ty).toList();
    final slot = _slots.remove(ty) ?? (same.isNotEmpty ? [same.last.x, same.last.y + 170] : [600.0, 300.0]);
    final f = _newFirm(ty, '${t.label} ${founder.name.split(' ').last}', 0, founder.id, slot[0], slot[1]);
    f.rate = t.rate * _minScale(w, 1); // échelle minimale si la demande n'occupe pas un employé
    f.wage = wage;
    final paid = transfer(founder, f, capital);
    _flow('M', f.id.toString(), '\$capital', 1, paid);
    for (final e in f.outputs.entries) {
      f.demandEma[e.key] = batches * e.value;
    }
    f.outputEma = batches;
    final cost = unitCost(f);
    var revenue = 0.0;
    for (final o in f.outputs.keys) {
      final others = sellersOf(o).where((x) => !identical(x, f) && x.workers.isNotEmpty).map((x) => x.price[o]!);
      final own = cost[o]! * p.markup;
      f.price[o] = others.isEmpty ? own : math.min(own, others.reduce(math.min));
      revenue += f.demandEma[o]! * f.price[o]!;
    }
    f.revenueEma = revenue;
    f.vacancies = team;
    _lastEntry[ty] = day;
    firmsCreated++;
    if (trace != null) {
      _t('entrees_sorties', 'creation', f.name, f.id, 'entrée : demande non servie', why, paid,
          'fondateur ${founder.name} ; ${fmtNum1(want)} ${goods[g]!.unit}/j non servis ; équipe $team');
    }
    _log('info', '${founder.name} fonde ${f.name} avec ${fmtMoney0(paid)} : $why '
        '(${goods[g]!.label.toLowerCase()}, ${fmtNum1(want)} ${goods[g]!.unit}/j non servis).');
    return true;
  }

  /// Fermeture faute d'activité : la trésorerie revient au propriétaire, la dette est radiée, la place est libérée.
  void _close(Firm f) {
    final repaid = modules.bankruptcy ? _repayFromCash(f) : 0.0;
    final lost = f.debt;
    _writeOff(f, 'fermeture');
    final owner = f.ownerId != null ? _cmap[f.ownerId!] : null;
    final left = f.money;
    if (left > 0) transfer(f, owner ?? state, left);
    if (trace != null) {
      _t('entrees_sorties', 'fermeture', f.name, f.id, 'sortie : aucun employé depuis ${params.exitIdleDays} jours',
          'aucun employé', left, 'trésorerie rendue à ${owner?.name ?? 'l’État'} ; dette remboursée '
              '${fmtMoney0(repaid)}, radiée ${fmtMoney0(lost)}');
    }
    if (repaid > 0 || lost > 0) {
      _log('info', '${f.name} : ${fmtMoney0(repaid)} de dette remboursés par sa trésorerie, ${fmtMoney0(lost)} radiés.');
    }
    _slots[f.type] = [f.x, f.y];
    firms.remove(f);
    _fmap.remove(f.id);
    _rebuildSellers();
    final key = f.id.toString();
    flowsEma.removeWhere((k, v) => v.from == key || v.to == key);
    firmsClosed++;
    _log('info', '${f.name} ferme ses portes : aucun employé depuis ${params.exitIdleDays} jours'
        '${left > 0 ? ' (${fmtMoney0(left)} rendus à ${owner?.name ?? 'l’État'})' : ''}.');
  }

  /// Applique le plafond de dérive à une nouvelle valeur (prix ou salaire) ; journalise chaque plafonnement.
  double _capDrift(Firm f, double old, double next, String kind, String what) {
    if (!safeguards.drift || old <= 0) return next;
    final m = safeguards.maxDailyChange;
    final hi = old * (1 + m), lo = old * (1 - m);
    if (next <= hi && next >= lo) return next;
    final capped = next > hi ? hi : lo;
    final up = next > hi;
    _net('drift', f.name, (next - capped).abs(), '${up ? 'hausse' : 'baisse'} de $kind',
        '$what : ${fmtPct(next / old - 1)} ramené à ${fmtPct(capped / old - 1)}', f.id);
    return capped;
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

    // salaire de référence par qualification exigée (norme du marché du travail)
    final wsum = [0.0, 0.0, 0.0];
    final wn = [0, 0, 0];
    for (final f in firms) {
      final s = f.template.skill;
      wsum[s] += f.wage * f.workers.length;
      wn[s] += f.workers.length;
    }
    final norm = [for (var s = 0; s < 3; s++) wn[s] > 0 ? wsum[s] / wn[s] : p.startWage * classWage[s]];
    final tw = wn[0] + wn[1] + wn[2];
    avgWage = tw > 0 ? (wsum[0] + wsum[1] + wsum[2]) / tw : p.startWage;
    final baseMk = p.markup - 1;

    for (final f in firms) {
      f.revenueEma = 0.9 * f.revenueEma + 0.1 * f.revenue;
      f.overheadEma = 0.9 * f.overheadEma + 0.1 * f.overhead;
      f.brand *= 0.97; // la notoriété s'estompe sans nouvelles campagnes
      final cost = unitCost(f);
      f.unitCostCache = cost;
      for (final g in f.outputs.keys) {
        final um = f.unmetShare[g] ?? 0;
        f.unmetShare[g] = 0;
        final demand = (f.sold[g] ?? 0) + um;
        if (g == f.g0) f.urgency = demand > eps ? um / demand : 0.0;
        f.demandEma[g] = 0.85 * (f.demandEma[g] ?? 0) + 0.15 * demand;
        f.markup[g] = f.markup[g] ?? baseMk;
        // sans employés, le prix affiché reste celui de la fermeture ; un service public gratuit n'a pas de prix
        if (f.lockPrice || f.workers.isEmpty || publicService(f)) continue;
        // signal de rareté : stock trop bas (ou capacité saturée) → marge ↑ ; surstock → marge ↓
        var dir = 0;
        final prod = f.produced[g] ?? 0;
        if (goods[g]!.perish) {
          final util = prod > eps ? (f.sold[g] ?? 0) / prod : 0.0;
          if (um > eps && util > 0.97) {
            dir = 1;
          } else if (util < 0.85 && prod > eps) {
            dir = -1;
          }
        } else {
          final days = (f.inv[g] ?? 0) / math.max(f.demandEma[g]!, 0.05);
          if (days < 2 && demand > eps && (prod > eps || (f.inv[g] ?? 0) > eps)) {
            dir = 1; // la rareté ne fait monter le prix que si l'entreprise a de quoi vendre ou produit
          } else if (days > 8) {
            dir = -1;
          }
        }
        final pressure = 1 + 2 * math.min(1.0, um / math.max(f.sold[g] ?? 0, 1.0));
        final stepSize = p.priceStep * (0.5 + draw(Flux.prix, f.id, _goodIndex[g]!));
        final mkOld = f.markup[g]!;
        var mk = mkOld;
        if (dir > 0) {
          mk += stepSize * pressure;
        } else if (dir < 0) {
          mk -= stepSize;
        } else {
          mk += (baseMk - mk) * 0.03; // la concurrence ramène la marge vers la normale
        }
        mk = math.max(-0.4, math.min(3.0, mk));
        final target = cost[g]! * (1 + mk);
        final old = f.price[g]!;
        var np = old + (target - old) * 0.25;
        final hi = old * (1 + p.priceMaxDaily), lo = old * (1 - p.priceMaxDaily);
        // anti-emballement : tant que le prix est bridé dans un sens, la marge visée cesse d'aller dans ce sens ;
        // sinon elle continuerait de monter pendant la pénurie et ferait grimper les prix pendant des semaines.
        // Les hausses de coût, elles, continuent de se répercuter.
        if (np > hi) {
          np = hi;
          if (mk > mkOld) mk = mkOld;
        } else if (np < lo) {
          np = lo;
          if (mk < mkOld) mk = mkOld;
        }
        f.markup[g] = mk;
        np = _capDrift(f, old, np, 'prix', goods[g]!.label.toLowerCase());
        f.price[g] = np < 0.01 ? 0.01 : np;
      }

      // ------- plan d'embauche
      final nw = f.workers.length;
      final avgEff = nw > 0 ? math.max(0.3, f.effWorkers / nw) : 1.0;
      final per = math.max(eps, perWorker(f) * avgEff);
      var desired = (_plannedBatches(f) / per - 0.2).ceil();
      if (f.inputLimited) desired = math.min(desired, (f.lastBatches / per).ceil()); // pas d'embauche sans matière
      f.desired = desired;
      final bill = f.wage * nw;
      f.vacancies = 0;
      if (nw > 0 && f.money < bill * 2) {
        _fire(f, _cmap[f.workers[nw - 1]], 'trésorerie sous 2 jours de salaires');
      } else if (desired > nw) {
        var affordable = affordablePosts(f);
        if (affordable < math.min(desired - nw, maxPostsPerDay)) {
          _workingCapital(f, math.min(desired - nw, maxPostsPerDay));
          affordable = affordablePosts(f);
        }
        f.vacancies = math.max(0, math.min(desired - nw, math.min(maxPostsPerDay, affordable)));
      } else if (desired < nw - 1) {
        final k = math.min(nw - desired - 1, math.max(1, (nw * 0.08).ceil()));
        for (var i = 0; i < k; i++) {
          _fire(f, _cmap[f.workers.last], 'effectif au-dessus du plan de production');
        }
      }

      // ------- salaires
      if (!f.lockWage) {
        final old = f.wage;
        var w = old;
        // postes vacants depuis 2 jours : on monte le salaire chaque jour, plus vite si des clients repartent les
        // mains vides (avant : un jour sur deux, par à-coups de 1,5 à 6 %)
        if (f.vacancies > 0 && f.unfilledDays >= 2) {
          w *= 1 + p.wageStep * (1 + 3 * math.min(1.0, f.urgency));
        } else if (f.vacancies == 0 && unemp > 0.08) {
          w *= 1 - p.wageStep * 0.1;
        }
        w += (norm[f.template.skill] - w) * 0.01; // les écarts de salaire se résorbent lentement
        w = w.clamp(old * (1 - p.wageMaxDaily), old * (1 + p.wageMaxDaily)).toDouble();
        if (w < math.max(1.0, p.minWage)) w = math.max(1.0, p.minWage);
        // le salaire minimum est une loi : le plafond de dérive ne s'y applique pas
        f.wage = w > p.minWage ? math.max(p.minWage, _capDrift(f, old, w, 'salaire', 'salaire')) : w;
      }

      // ------- profits et dividendes
      final profit = f.revenue - f.costs;
      f.retained += profit;
      f.profitEma = 0.9 * f.profitEma + 0.1 * profit;
      f.inputSpendEma = 0.9 * f.inputSpendEma + 0.1 * f.inputSpend;
      final reserve = 8 * (f.wage * f.workers.length + f.inputSpendEma + f.overheadEma) + f.debt * 0.1;
      final owner = f.ownerId != null ? _cmap[f.ownerId!] : null;
      f.dividends = 0;
      if (owner != null && f.money > reserve && !publicService(f)) {
        var d = (f.money - reserve) * p.dividendRate;
        if (modules.dividendTest) {
          final d0 = d;
          d = solventDividend(f, d);
          if (trace != null && d < d0) {
            _t('institutions', 'dividende_retenu', f.name, f.id, 'I1 : test de solvabilité', _dividendCause(f),
                d0 - d, 'dividende voulu ${fmtMoney0(d0)}, versé ${fmtMoney0(d)}');
          }
        }
        if (d > 0) {
          final net = transfer(f, owner, d * (1 - p.taxRate));
          final tax = transfer(f, state, d * p.taxRate);
          state.taxes += tax;
          state.taxesToday += tax;
          owner.income += net;
          f.dividends = net + tax;
          f.retained -= f.dividends;
          _flow(f.id.toString(), 'M', '\$dividendes', 1, net);
          if (tax > 0) _flow('M', 'E', '\$impôts', 1, tax);
          if (trace != null) {
            _t('compta', 'dividende', f.name, f.id, 'dividende : ${fmtPct(p.dividendRate, 0)} de la trésorerie au-delà '
                'de la réserve', 'à ${owner.name}', net + tax, 'net ${fmtMoney0(net)}, impôt ${fmtMoney0(tax)}');
          }
        }
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

  /// Test de solvabilité avant dividende (institution I1, LCSA art. 42) : pas de dividende sans bénéfice lissé ; pas de
  /// dividende qui laisserait en caisse moins que le seuil d'embauche des postes voulus (8 jours de salaire par employé,
  /// nouveaux compris, pour les postes que la règle d'embauche ouvrirait aujourd'hui) ; jamais plus que le bénéfice
  /// lissé du jour.
  /// La contrainte du test de solvabilité qui a réduit le dividende (pour le journal complet).
  String _dividendCause(Firm f) {
    if (f.profitEma <= 0) return 'pas de bénéfice lissé';
    final want = math.min(f.desired - f.workers.length, maxPostsPerDay);
    final hire = want > 0 ? hireCashDays * f.wage * (f.workers.length + want) : 0.0;
    final cap = params.dividendFromRetained ? f.retained : f.profitEma;
    if (f.money - hire <= cap) return 'trésorerie nécessaire aux postes voulus';
    return params.dividendFromRetained ? 'plafond : bénéfices non répartis' : 'plafond : bénéfice lissé du jour';
  }

  double solventDividend(Firm f, double d) {
    if (f.profitEma <= 0) return 0;
    final want = math.min(f.desired - f.workers.length, maxPostsPerDay);
    final hire = want > 0 ? hireCashDays * f.wage * (f.workers.length + want) : 0.0;
    final cap = params.dividendFromRetained ? f.retained : f.profitEma;
    return math.max(0.0, math.min(d, math.min(cap, f.money - hire)));
  }

  /// Renflouement par les propriétaires (filet), rachats, redistribution du surplus de l'État.
  void _finance() {
    final p = params;
    final buffer = p.bufferDays * (needCost > 0 ? needCost : 140);
    if (safeguards.bailout) {
      for (final f in firms) {
        if ((f.demandEma[f.g0] ?? 0) < 0.05) continue;
        if (publicService(f)) continue; // établissement public : financé par son enveloppe, pas par un propriétaire
        final nw = math.max(1, math.min(f.desired == 0 ? 1 : f.desired, f.workers.length + 3));
        final need = 10 * f.wage * nw - f.money;
        if (need <= 0 || f.money > 4 * f.wage * nw) continue;
        var owner = f.ownerId != null ? _cmap[f.ownerId!] : null;
        var surplus = owner != null ? owner.money - buffer : 0.0;
        var bought = false;
        if (surplus < need * 0.5) {
          // le propriétaire n'a pas les moyens : le citoyen le plus riche rachète
          Citizen? rich;
          for (final c in citizens) {
            if (rich == null || c.money > rich.money) rich = c;
          }
          if (rich != null && !identical(rich, owner) && rich.money - buffer > need * 2) {
            if (trace != null) {
              _t('entrees_sorties', 'rachat', f.name, f.id, 'filet : renflouement (rachat)',
                  'le propriétaire n’a pas les moyens', 0, 'nouveau propriétaire ${rich.name}');
            }
            f.ownerId = rich.id;
            owner = rich;
            surplus = rich.money - buffer;
            bought = true;
            _log('info', '${rich.name} rachète ${f.name}.');
          }
        }
        if (owner != null && surplus > 0) {
          final want = math.min(need, surplus * 0.5);
          if (want > f.wage) {
            final amt = transfer(owner, f, want);
            _flow('M', f.id.toString(), '\$capital', 1, amt);
            _net('bailout', f.name, amt, bought ? 'après rachat' : 'par le propriétaire',
                '${owner.name} ; caisse ${fmtMoney0(f.money - amt)} pour $nw poste(s)', f.id);
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
      final each = (e.money - reserve) * p.stateRebate / citizens.length;
      var total = 0.0;
      for (final c in citizens) {
        final a = transfer(e, c, each);
        c.income += a;
        total += a;
      }
      e.paid += total;
      e.paidToday += total;
      _flow('E', 'M', '\$redistribution', 1, total);
      if (trace != null) {
        _t('compta', 'redistribution', 'État', null, 'redistribution du surplus de l’État', 'trésor au-delà de la réserve',
            total, '${citizens.length} citoyens');
      }
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

  /// Richesse médiane des citoyens.
  double medianWealth() {
    if (citizens.isEmpty) return 0;
    final v = citizens.map((c) => c.money).toList()..sort();
    final n = v.length;
    return n.isOdd ? v[n ~/ 2] : (v[n ~/ 2 - 1] + v[n ~/ 2]) / 2;
  }

  void _record() {
    final n = citizens.length;
    var mH = 0.0, mF = 0.0, wsum = 0.0, happy = 0.0;
    var employed = 0;
    final sat = <String, double>{for (final d in desires) d: 0.0};
    final classes = [0, 0, 0];
    for (final c in citizens) {
      mH += c.money;
      happy += c.happiness;
      classes[c.level]++;
      for (final d in desires) {
        sat[d] = sat[d]! + c.sat[d]!;
      }
      if (c.employer != null) {
        final f = firm(c.employer!);
        if (f != null) {
          wsum += f.wage;
          employed++;
        }
      }
    }
    if (n > 0) {
      for (final d in desires) {
        sat[d] = sat[d]! / n;
      }
    }
    var debt = 0.0, machines = 0.0, tech = 0.0;
    for (final f in firms) {
      mF += f.money;
      debt += f.debt;
      machines += f.machines;
      tech += f.techLevel;
    }
    final prices = <String, double>{};
    for (final g in goods.keys) {
      final ms = marketStats[g];
      // sans transaction aujourd'hui, on reprend le dernier prix observé (comme les instituts statistiques) :
      // un bien qui ne se vend pas ne fait pas bouger l'indice quand son vendeur ferme ou change d'affiche
      prices[g] = ms != null && ms.qty > eps
          ? ms.value / ms.qty
          : (history.isNotEmpty ? history.last.prices[g] ?? bestPrice(g) : bestPrice(g));
    }
    var basket = 0.0;
    for (final e in cpiWeights.entries) {
      basket += e.value * prices[e.key]!;
    }
    history.add(HistPoint(
      day: day,
      mH: mH,
      mF: mF,
      mE: state.money,
      mB: bank.money,
      total: mH + mF + state.money + bank.money,
      unemp: n > 0 ? (n - employed) / n : 0.0,
      wage: employed > 0 ? wsum / employed : 0.0,
      prices: prices,
      gdp: householdSpend,
      hungry: citizens.where((c) => c.hungerDays >= 1).length,
      homeless: citizens.where((c) => c.homeless).length,
      gini: gini(),
      pop: n,
      need: needCost,
      happiness: n > 0 ? happy / n : 0.0,
      debt: debt,
      machines: machines,
      tech: firms.isNotEmpty ? tech / firms.length : 1.0,
      credit: ledgerCredit,
      cpi: _cpiBase > 0 ? basket / _cpiBase : 1.0,
      sat: sat,
      classes: classes,
    ));
    if (history.length > 1500) history.removeAt(0);
    for (final f in firms) {
      final g0 = f.g0;
      f.hist.add(FirmPoint(f.money, f.workers.length, f.price[g0]!, f.sold[g0] ?? 0, f.revenue - f.costs, f.machines, f.debt));
      if (f.hist.length > 365) f.hist.removeAt(0);
      if (f.prevWorkers > 0 && f.workers.isEmpty) _log('warn', "${f.name} n'a plus d'employés.");
    }
  }

  // ================================================================ Invariants comptables

  /// Vérifie les quatre identités ; en mode développement, un écart lève une exception.
  void _checkInvariants() {
    final d = deposits();
    final loans = totalDebt();
    inv.money = totalMoney() - expectedMoney();
    inv.loans = loans - (bank.lent + bank.capitalized - bank.repaid - bank.writtenOff);
    inv.bank = (bank.reserves + loans) - (d + bank.equity);
    inv.flows = (d - _depositsAtCheck) - dayFlows.explained;
    lastFlows = DayFlows()
      ..loans = dayFlows.loans
      ..repaid = dayFlows.repaid
      ..interest = dayFlows.interest
      ..rebates = dayFlows.rebates
      ..godPublic = dayFlows.godPublic
      ..godBank = dayFlows.godBank
      ..exports = dayFlows.exports
      ..imports = dayFlows.imports
      ..capitalized = dayFlows.capitalized
      ..writtenOff = dayFlows.writtenOff;
    dayFlows.reset();
    _depositsAtCheck = d;
    if (devChecks && inv.worst > 0) {
      throw StateError('Invariant comptable rompu au jour $day : masse ${inv.money}, prêts ${inv.loans}, '
          'bilan ${inv.bank}, ΔM ${inv.flows}');
    }
  }

  // ============================================================= God mode
  double godMoney(Target target, double amount) {
    final list = _targets(target);
    var total = 0.0;
    for (final e in list) {
      final a = amount >= 0 ? transfer(null, e, amount) : -transfer(e, null, math.min(-amount, e.money));
      total += a;
      if (identical(e, bank)) {
        ledgerGod += a;
        bank.reserves += a;
        bank.equity += a;
        dayFlows.godBank += a;
      } else {
        _godIn(a);
      }
    }
    _log('god', '${total >= 0 ? 'Injection de ' : 'Retrait de '}${fmtMoney0(total.abs())} → ${_targetLabel(target)}.');
    if (trace != null) _t('compta', 'divin', _targetLabel(target), target.id, 'god mode', 'injection ou retrait', total);
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

  /// Épidémie : une part de la population perd la moitié de sa santé.
  int godEpidemic(double share) {
    var sick = 0;
    final seq = ++_godSeq;
    for (final c in citizens) {
      if (draw(Flux.divin, c.id, seq) < share) {
        c.sat['sante'] = math.max(0.05, c.health - 0.5);
        sick++;
      }
    }
    _log('god', 'Épidémie : $sick citoyens tombent malades.');
    return sick;
  }

  /// Formation accélérée : le citoyen passe à la classe suivante.
  void godTrain(int citizenId) {
    final c = citizen(citizenId);
    if (c == null || c.skill >= 3) return;
    c.skill = math.min(3.0, c.skill.floorToDouble() + 1);
    _log('god', '${c.name} devient ${classLabels[c.level].toLowerCase()}.');
  }

  void godAddCitizens(int n, double money) {
    for (var i = 0; i < n; i++) {
      final c = _newCitizen(money: money);
      _godIn(c.money);
      if (trace != null) _t('entrees_sorties', 'arrivee', c.name, c.id, 'god mode', 'immigration', c.money);
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
      if (c.employer != null) _fire(firm(c.employer!), c, 'départ de la région');
      if (trace != null) _t('entrees_sorties', 'depart', c.name, c.id, 'god mode', 'émigration', c.money);
      money += c.money;
      _godIn(-c.money);
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
      double? capacity,
      double? machines,
      int? techLevel,
      bool forgiveDebt = false}) {
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
    if (machines != null && machines.isFinite) {
      f.machines = math.max(0.0, machines);
      notes.add('${round1(f.machines)} machines');
    }
    if (techLevel != null) {
      f.techLevel = math.max(1, techLevel);
      f.rndProgress = 0;
      notes.add('technologie niveau ${f.techLevel}');
    }
    if (forgiveDebt && f.debt > 0) {
      notes.add('dette de ${fmtMoney0(f.debt)} effacée');
      _writeOff(f, 'dette effacée (god mode)');
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
    final f = _newFirm(type, name, money, ownerId, x, y);
    if (f.ownerId == null && citizens.isNotEmpty) {
      f.ownerId = citizens[(draw(Flux.proprietaire, f.id) * citizens.length).floor()].id;
    }
    _godIn(f.money);
    // salaire du marché pour cette qualification
    var ws = 0.0, wn = 0;
    for (final o in firms) {
      if (identical(o, f) || o.template.skill != f.template.skill) continue;
      ws += o.wage * o.workers.length;
      wn += o.workers.length;
    }
    if (wn > 0) f.wage = ws / wn;
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
    if (trace != null) _t('entrees_sorties', 'creation', f.name, f.id, 'god mode', 'entreprise ajoutée', f.money);
    return f;
  }

  void removeFirm(int id) {
    final f = firm(id);
    if (f == null) return;
    for (final wid in List<int>.from(f.workers)) {
      _fire(f, _cmap[wid], 'fermeture de l’entreprise (god mode)');
    }
    if (modules.bankruptcy) _repayFromCash(f);
    final hadDebt = f.debt > 0;
    _writeOff(f, 'fermeture (god mode)');
    if (trace != null) _t('entrees_sorties', 'retrait', f.name, f.id, 'god mode', 'entreprise retirée', f.money);
    final owner = f.ownerId != null ? _cmap[f.ownerId!] : null;
    if (owner != null) {
      transfer(f, owner, f.money);
    } else if (modules.bankruptcy) {
      transfer(f, state, f.money); // sans propriétaire (établissement public), le reste revient à l'État
    } else {
      _godIn(-f.money);
      f.money = 0;
    }
    firms.remove(f);
    _fmap.remove(id);
    _rebuildSellers();
    final key = id.toString();
    flowsEma.removeWhere((k, v) => v.from == key || v.to == key);
    _log('god', '${f.name} ferme ses portes. Les employés sont mis à pied${hadDebt ? ', la dette est radiée' : ''}.');
  }

  /// Faillite : l'entreprise perd sa trésorerie et ses stocks, sa dette est radiée ; elle reste en place.
  void godBankrupt(int id) {
    final f = firm(id);
    if (f == null) return;
    final lost = f.money;
    _godIn(-transfer(f, null, f.money));
    for (final g in f.inv.keys.toList()) {
      f.inv[g] = 0;
    }
    final debt = f.debt;
    _writeOff(f, 'faillite (god mode)');
    _log('god', 'Faillite de ${f.name} : ${fmtMoney0(lost)} de trésorerie et tous les stocks perdus'
        '${debt > 0 ? ', ${fmtMoney0(debt)} de dette radiés' : ''}.');
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
      case 'bank':
        return <Account>[bank];
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
      case 'bank':
        return 'la Caisse';
      case 'citizen':
        return citizen(t.id ?? -1)?.name ?? '?';
      case 'firm':
        return firm(t.id ?? -1)?.name ?? '?';
    }
    return '?';
  }
}
