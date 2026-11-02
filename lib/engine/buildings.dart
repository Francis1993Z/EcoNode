part of 'sim.dart';

// Bâtiments, construction et hypothèques (module « buildings »). Voir rapports/batiments-hypotheques.md.
//
// Le parc de logements est fait de bâtiments d'une unité. Un bailleur (entreprise « Immobilier ») possède des bâtiments,
// loue les nuitées (c'est la recette historique de l'entreprise : sa capacité est le nombre de ses logements habitables)
// et en vend quelques-uns. Un ménage peut acheter un logement à crédit (hypothèque de la Caisse), y habiter (il ne paie
// alors plus de nuitée), l'entretenir, le revendre à profit ou à perte ; saisi après trop de jours de retard.
// Un bailleur dont la demande dépasse le parc fait construire : la construction se vend en « modules » (un logement en
// demande Params.dwellingModules), achetés un par jour par chantier à l'entreprise Construction, ce qui donne au
// constructeur un revenu continu comme à toute autre entreprise.
//
// Comptabilité (invariants au bit près, comme le reste du moteur) :
//  - un prêt hypothécaire crée de la monnaie (transfer(null, emprunteur) ; ledgerCredit, bank.lent, dayFlows.loans) ;
//  - un remboursement de capital la détruit (ledgerCredit, bank.repaid, dayFlows.repaid) ; les intérêts vont aux fonds
//    propres de la Caisse (bank.interest, bank.equity, dayFlows.interest) ; des intérêts impayés sont capitalisés ;
//  - une saisie ne radie rien : le bâtiment passe en liquidation, la dette reste inscrite jusqu'à la vente. Le produit de
//    la vente rembourse le capital (monnaie détruite), le surplus revient à l'ancien propriétaire (ou à l'État), le solde
//    non couvert est radié (bank.writtenOff, bank.equity).
//  - tous les montants sont des multiples de 2⁻¹⁰ $ (quantize), donc les sommes sont exactes.

/// Statistiques cumulées du parc (affichage, rapports et tests).
class BuildingStats {
  int built = 0; // chantiers terminés
  int sales = 0; // ventes de bâtiments
  int foreclosures = 0; // saisies
  int opened = 0; // hypothèques accordées
  int refused = 0; // achats refusés (mise de fonds, service de la dette, fonds propres de la Caisse)
  int abandoned = 0; // chantiers abandonnés (propriétaire disparu)
  int bought = 0; // immeubles saisis rachetés par un bailleur (Params.buildingTypes)
  double gains = 0; // somme des gains de revente (prix − coût d'acquisition du vendeur), quand positifs
  double losses = 0; // somme des pertes de revente (valeur absolue)
  double priceEma = 0; // prix de vente moyen, lissé

  void clear() {
    built = sales = foreclosures = opened = refused = abandoned = bought = 0;
    gains = losses = priceEma = 0;
  }
}

/// x puissance n entière, par exponentiation rapide : le même résultat sur la VM et sur le web (pas de math.pow).
double _ipow(double x, int n) {
  var result = 1.0;
  var b = x;
  var e = n;
  while (e > 0) {
    if ((e & 1) == 1) result *= b;
    b *= b;
    e >>= 1;
  }
  return result;
}

/// Versement quotidien constant qui amortit [principal] en [n] jours au taux quotidien [r].
double _annuity(double principal, double r, int n) {
  if (n <= 0) return principal;
  if (r <= 1e-12) return principal / n;
  final g = _ipow(1 + r, n);
  return principal * r * g / (g - 1);
}

extension SimBuildings on Sim {
  Building? building(int id) => _bmap[id];
  Mortgage? mortgageOf(Building b) => b.mortgageId == null ? null : _mmap[b.mortgageId!];

  // ------------------------------------------------------------------ totaux

  /// Capital dû sur toutes les hypothèques.
  double mortgageDebt() {
    var d = 0.0;
    for (final m in mortgages) {
      d += m.principal;
    }
    return d;
  }

  int get homeOwners => citizens.where((c) => c.homeId != null).length;

  /// Logements habitables (loués ou occupés par leur propriétaire).
  int get dwellings {
    var n = 0;
    for (final b in buildings) {
      if (b.habitable) n += b.units;
    }
    return n;
  }

  // ------------------------------------------------------------------ valeurs

  /// Prix d'un module de construction : le meilleur prix offert, à défaut le prix de départ.
  double moduleCost() => bestPrice('batiment');

  /// Coût de remplacement d'un logement neuf.
  double replacementCost() => params.dwellingModules * moduleCost();

  /// Modules de construction d'un bâtiment : ceux de son type (Params.buildingTypes), sinon ceux d'un logement standard.
  int modulesOf(Building b) =>
      b.type == null ? params.dwellingModules : (buildingKinds[b.type!].size * params.dwellingModules).round();

  /// Taille d'un bâtiment en logements standards (entretien, provision pour l'usure) : 1 sans type.
  double sizeOf(Building b) => b.type == null ? 1.0 : modulesOf(b) / params.dwellingModules;

  /// Coût de remplacement d'un bâtiment neuf (sans type : celui d'un logement standard).
  double buildingCost(Building b) => modulesOf(b) * moduleCost();

  /// Valeur courante : coût de remplacement, rabattu selon l'état (un logement à l'état 0 vaut encore le quart : le
  /// terrain et les fondations), un peu plus cher quand les logements manquent (chaleur du marché, de −1 à +1 : ±15 %).
  double fairValue(Building b) => buildingCost(b) * (0.25 + 0.75 * b.cond) * (1 + 0.15 * housingHeat);

  /// Prix demandé aujourd'hui pour un bâtiment en vente : valeur courante plus une marge (la Caisse vend à 10 % sous la
  /// valeur), qui baisse chaque jour sans acheteur jusqu'à un plancher.
  double askPrice(Building b) {
    final p = params;
    final margin = b.ownerKind == 2 ? -0.10 : p.listingMargin;
    final days = day - (b.listedDay ?? day);
    final k = math.max(p.listingFloor, 1 - p.listingDecay * days);
    return quantize(fairValue(b) * (1 + margin) * k);
  }

  /// Taux annuel d'une hypothèque : taux de base + prime croissante avec le levier (0 jusqu'à 50 % de LTV, maximale à 95 %).
  double mortgageRate(double ltv) =>
      baseRate() + params.mortgageSpreadMax * ((ltv - 0.5) / 0.45).clamp(0.0, 1.0).toDouble();

  /// La Caisse peut-elle prêter ce montant ? Fonds propres ≥ plancher × (exposition pondérée actuelle + prêt pondéré).
  /// Params.equalBanks : la banque de l'emprunteur [bankId], avec ses propres fonds propres et ses prêts.
  bool _bankAllows(double loan, [int bankId = 0]) {
    if (!modules.credit) return false;
    if (modules.bankRegulation || safeguards.credit) {
      if (params.equalBanks && banks.isNotEmpty) {
        final b = banks[bankId < banks.length ? bankId : 0];
        return b.alive && b.equityNow >= safeguards.minCapitalRatio * (b.riskLoans + params.mortgageRiskWeight * loan);
      }
      final need = safeguards.minCapitalRatio * (totalDebt() + params.mortgageRiskWeight * loan);
      if (bank.equity < need) return false;
    }
    return true;
  }

  /// Banque d'un emprunteur (Params.equalBanks) : celle du citoyen ou de l'entreprise ; 0 sans le module banques.
  int _lenderOf(Account a) {
    if (!params.equalBanks || banks.isEmpty) return 0;
    return a is Citizen ? a.bankId : (a is Firm ? a.bankId : 0);
  }

  // ------------------------------------------------------------------ hypothèques : monnaie

  /// Crée une hypothèque : la Caisse crée la monnaie prêtée et la verse à l'emprunteur.
  Mortgage? _originate(Account borrower, int kind, int borrowerId, Building b, double amount, double rate, int term) {
    final a = transfer(null, borrower, amount);
    if (a <= 0) return null;
    ledgerCredit += a;
    bank.lent += a;
    dayFlows.loans += a;
    final m = Mortgage(_nextMortgageId++, b.id, kind, borrowerId, a, rate, term, day)..bankId = _lenderOf(borrower);
    m.payment = quantize(_annuity(a, rate / 365, term));
    mortgages.add(m);
    _mmap[m.id] = m;
    b.mortgageId = m.id;
    bstats.opened++;
    _flow('B', kind == 1 ? 'M' : borrowerId.toString(), '\$prêts', 1, a);
    if (trace != null) {
      _t('credit', 'hypotheque', borrower is Citizen ? borrower.name : (borrower is Firm ? borrower.name : ''),
          borrowerId, 'hypothèque', kind == 1 ? 'achat d’un logement' : 'chantier d’un bailleur', a,
          'taux ${fmtPct(rate)}, versement ${fmtMoney0(m.payment)}/j');
    }
    return m;
  }

  /// Tirage supplémentaire sur l'hypothèque d'un chantier.
  void _draw(Mortgage m, Account borrower, double amount) {
    final a = transfer(null, borrower, amount);
    if (a <= 0) return;
    ledgerCredit += a;
    bank.lent += a;
    dayFlows.loans += a;
    m.principal += a;
    m.payment = quantize(_annuity(m.principal, m.rate / 365, m.termLeft));
    _flow('B', m.borrowerKind == 1 ? 'M' : m.borrowerId.toString(), '\$prêts', 1, a);
  }

  /// Rembourse du capital depuis le compte [from] (la monnaie est détruite). Rend le montant remboursé.
  double _repayMortgage(Mortgage m, Account from, double amount) {
    final x = transfer(from, null, math.min(amount, m.principal));
    if (x <= 0) return 0;
    ledgerCredit -= x;
    m.principal -= x;
    bank.repaid += x;
    dayFlows.repaid += x;
    return x;
  }

  /// La Caisse renonce à ce qui reste dû : perte imputée aux fonds propres, la monnaie déjà créée reste.
  void _writeOffMortgage(Mortgage m, String why) {
    final rem = m.principal;
    if (rem > 0) {
      bank.writtenOff += rem;
      bank.equity -= rem;
      dayFlows.writtenOff += rem;
      if (params.equalBanks && banks.isNotEmpty) _attrib(m.bankId, -rem, loss: rem);
      m.principal = 0;
      if (trace != null) _t('credit', 'radiation', 'Caisse', null, 'radiation d’hypothèque', why, rem);
    }
    _dropMortgage(m);
  }

  void _dropMortgage(Mortgage m) {
    mortgages.remove(m);
    _mmap.remove(m.id);
    final b = _bmap[m.buildingId];
    if (b != null && b.mortgageId == m.id) b.mortgageId = null;
  }

  // ------------------------------------------------------------------ départ d'un propriétaire, saisie

  /// Le bâtiment quitte son propriétaire (saisie, fermeture d'un bailleur, départ d'un citoyen) : il passe en liquidation,
  /// sans débiteur sur l'hypothèque ; la Caisse le vend, et le produit rembourse d'abord l'hypothèque. Un chantier
  /// inachevé est abandonné (la dette est radiée).
  void _liquidate(Building b) {
    if (b.ownerKind == 2) return;
    int? payee;
    if (b.ownerKind == 1) {
      final c = _cmap[b.ownerId];
      if (c != null && c.homeId == b.id) c.homeId = null;
      payee = b.ownerId;
    } else {
      payee = _fmap[b.ownerId]?.ownerId;
    }
    final m = mortgageOf(b);
    if (m != null) {
      m.borrowerKind = 2;
      m.borrowerId = null;
      m.missed = 0;
    }
    b.ownerKind = 2;
    b.ownerId = null;
    b.payee = payee;
    if (!b.done) {
      _abandon(b);
      return;
    }
    b.listedDay = day;
  }

  void _abandon(Building b) {
    final m = mortgageOf(b);
    if (m != null) _writeOffMortgage(m, 'chantier abandonné');
    buildings.remove(b);
    _bmap.remove(b.id);
    bstats.abandoned++;
  }

  void _foreclose(Mortgage m) {
    final b = _bmap[m.buildingId];
    m.missed = 0;
    if (b == null) {
      _writeOffMortgage(m, 'bâtiment disparu');
      return;
    }
    bstats.foreclosures++;
    if (trace != null) {
      final who = m.borrowerKind == 1 ? _cmap[m.borrowerId]?.name : _fmap[m.borrowerId]?.name;
      _t('credit', 'saisie', who ?? '', m.borrowerId, 'saisie hypothécaire', 'plus de ${params.foreclosureDays} jours de retard',
          m.principal, 'bâtiment ${b.id}');
    }
    if (m.borrowerKind == 1) {
      final c = _cmap[m.borrowerId];
      _log('warn', '${c?.name ?? 'Un citoyen'} perd son logement : la Caisse saisit le bâtiment (dette ${fmtMoney0(m.principal)}).');
    }
    _liquidate(b);
  }

  /// Une entreprise disparaît (fermeture, god mode) : ses bâtiments passent en liquidation.
  void _firmGone(Firm f) {
    for (final b in List<Building>.from(buildings)) {
      if (b.ownerKind == 0 && b.ownerId == f.id) _liquidate(b);
    }
  }

  /// Un citoyen quitte la région : son logement passe en liquidation (le surplus de la vente ira à l'État).
  void _citizenGone(Citizen c) {
    if (c.homeId == null) return;
    final b = _bmap[c.homeId];
    c.homeId = null;
    if (b != null) _liquidate(b);
  }

  // ------------------------------------------------------------------ parc de départ

  /// Parc de départ : chaque bailleur possède autant de logements que sa capacité fixée. Ils sont de tout âge (état de
  /// 0,7 à 1) et valent leur valeur courante.
  void _seedBuildings() {
    _buildingsSeeded = true;
    final landlords = firms.where((f) => f.type == 'immobilier').toList();
    if (params.buildingTypes) {
      _seedTypedBuildings(landlords);
      return;
    }
    for (final f in landlords) {
      final n = f.capacity != null ? f.capacity!.round() : (1.06 * citizens.length / landlords.length).ceil();
      for (var i = 0; i < n; i++) {
        final b = Building(_nextBuildingId++, 0, f.id, day);
        b.done = true;
        b.modules = params.dwellingModules;
        b.cond = 1 - 0.3 * draw(Flux.logement, b.id, 7);
        b.basis = quantize(fairValue(b));
        buildings.add(b);
        _bmap[b.id] = b;
      }
    }
  }

  /// Parc de départ par types (Params.buildingTypes) : chaque bailleur a autant de logements que sa capacité fixée. Les
  /// maisons suffisent aux ménages qui veulent posséder et ont un emploi (plus 5 %) ; chaque bailleur en a sa part, selon
  /// son parc ; une maison est petite, moyenne ou grande au hasard (35, 45 et 20 %). Le reste du parc d'un bailleur est en
  /// duplex et en immeubles, tirés au hasard parmi ceux qui tiennent dans ce qui reste à loger.
  void _seedTypedBuildings(List<Firm> landlords) {
    const weights = [0.0, 0.0, 0.0, 2.0, 3.0, 3.0, 2.0, 1.0]; // duplex, immeubles d'un, deux et trois étages, multilogement
    final sizes = [
      for (final f in landlords) f.capacity != null ? f.capacity!.round() : (1.06 * citizens.length / landlords.length).ceil()
    ];
    final total = sizes.fold(0, (a, b) => a + b);
    final owners = citizens.where((c) => c.wantsToOwn && c.employer != null).length;
    final houses = math.min(total, (1.05 * owners).ceil());
    void add(Firm f, int Function(double u) typeOf) {
      final id = _nextBuildingId++;
      final b = Building(id, 0, f.id, day, typeOf(draw(Flux.logement, id, 13)));
      b.done = true;
      b.modules = modulesOf(b);
      b.cond = 1 - 0.3 * draw(Flux.logement, id, 7);
      b.basis = quantize(fairValue(b));
      buildings.add(b);
      _bmap[b.id] = b;
    }

    int house(double u) => u < 0.35 ? 0 : (u < 0.8 ? 1 : 2);
    var given = 0, acc = 0;
    for (var i = 0; i < landlords.length; i++) {
      final f = landlords[i];
      acc += sizes[i];
      final upto = total > 0 ? (houses * acc / total).round() : 0; // parts arrondies sans perte : la somme fait [houses]
      final h = upto - given;
      given = upto;
      for (var k = 0; k < h; k++) {
        add(f, house);
      }
      var rest = sizes[i] - h;
      while (rest > 0) {
        var sum = 0.0;
        for (var t = 3; t < buildingKinds.length; t++) {
          if (buildingKinds[t].units <= rest) sum += weights[t];
        }
        if (sum == 0) {
          add(f, house); // il reste un logement : une maison
          rest--;
          continue;
        }
        var chosen = 3;
        add(f, (u) {
          var x = u * sum;
          for (var t = 3; t < buildingKinds.length; t++) {
            if (buildingKinds[t].units > rest) continue;
            chosen = t;
            x -= weights[t];
            if (x < 0) break;
          }
          return chosen;
        });
        rest -= buildingKinds[chosen].units;
      }
    }
  }

  /// Propriétaires de départ (Params.ownersAtStart) : chaque citoyen qui veut posséder et a un emploi reçoit un logement du
  /// parc des bailleurs (à tour de rôle), entièrement payé : ni hypothèque, ni argent qui bouge. Une hypothèque de départ
  /// sans la monnaie qu'elle a créée ferait une économie qui doit plusieurs fois l'argent qu'elle possède (essayé : les
  /// remboursements détruisent la monnaie, chômage 58 % au jour 3 000) ; avec cette monnaie, les prix monteraient d'emblée
  /// au niveau de la vague. Les achats suivants (reventes, nouveaux acheteurs) passent par le crédit.
  void _seedOwners() {
    final stock = <List<Building>>[
      for (final f in firms)
        if (f.type == 'immobilier')
          [for (final b in buildings) if (b.ownerKind == 0 && b.ownerId == f.id && b.done && b.units == 1) b]
    ];
    final next = List<int>.filled(stock.length, 0);
    var turn = 0;
    var count = 0;
    for (final c in _ordered(citizens, Flux.logement, (c) => c.id)) {
      if (!c.wantsToOwn || c.employer == null || c.homeId != null) continue;
      Building? b;
      for (var k = 0; k < stock.length && b == null; k++) {
        final i = (turn + k) % stock.length;
        if (next[i] < stock[i].length) {
          b = stock[i][next[i]++];
          turn = i + 1;
        }
      }
      if (b == null) break;
      b
        ..ownerKind = 1
        ..ownerId = c.id
        ..basis = quantize(fairValue(b))
        ..listedDay = null;
      c.homeId = b.id;
      count++;
    }
    if (count > 0) {
      _log('info', '$count propriétaires de départ, logements payés (${fmtPct(count / math.max(1, citizens.length))} des citoyens).');
    }
  }

  // ------------------------------------------------------------------ chaque jour

  /// Début de journée : la capacité de chaque bailleur suit son parc habitable ; chaleur du marché.
  void _buildingsMorning() {
    if (!_buildingsSeeded) _seedBuildings();
    final units = <int, int>{};
    for (final b in buildings) {
      if (b.ownerKind == 0 && b.habitable) units[b.ownerId!] = (units[b.ownerId!] ?? 0) + b.units;
    }
    var cap = 0.0, demand = 0.0;
    for (final f in firms) {
      if (f.type != 'immobilier') continue;
      f.capacity = (units[f.id] ?? 0).toDouble();
      cap += f.capacity!;
      demand += f.demandEma['logement'] ?? 0.0;
    }
    final occ = cap > 0 ? demand / cap : 1.0;
    housingHeat = ((occ - 0.94) / 0.06).clamp(-1.0, 1.0).toDouble();
  }

  /// Après la paie : usure et entretien, service des hypothèques, marché des logements, chantiers.
  void _buildingsDay() {
    _wearAndMaintain();
    _serviceMortgages();
    _housingMarket();
    _construction();
    _updateCarry();
  }

  double _worn(double cond, double wear, double cover) =>
      math.max(0.0, cond - wear * (1 - params.buildingMaintShare * cover));

  /// Usure quotidienne ; chaque propriétaire achète des heures de réparation (un bailleur pour tout son parc). L'entretien
  /// complet compense la part buildingMaintShare de l'usure ; un bâtiment en liquidation n'est pas entretenu.
  void _wearAndMaintain() {
    final p = params;
    final wear = p.buildingWearYear / 365;
    final perFirm = <int, List<Building>>{};
    for (final b in buildings) {
      if (b.done && b.ownerKind == 0) (perFirm[b.ownerId!] ??= <Building>[]).add(b);
    }
    for (final e in perFirm.entries) {
      final f = _fmap[e.key];
      if (f == null) continue;
      var load = 0.0; // logements standards à entretenir
      for (final b in e.value) {
        load += sizeOf(b);
      }
      final need = p.maintHoursPerDwelling * load;
      final budget = math.max(0.0, f.money - 3 * f.wage * f.workers.length);
      final r = buy(f, f.id.toString(), 'reparation', need, budget, false);
      f.costs += r.spent;
      f.overhead += r.spent;
      final cover = need > eps ? math.min(1.0, r.qty / need) : 1.0;
      for (final b in e.value) {
        b.cond = _worn(b.cond, wear, cover);
      }
    }
    for (final b in buildings) {
      if (!b.done) continue;
      if (b.ownerKind == 1) {
        final c = _cmap[b.ownerId];
        var cover = 0.0;
        if (c != null) {
          final need = p.maintHoursPerDwelling * sizeOf(b);
          final budget = math.max(0.0, c.money - 3 * needCost);
          final r = buy(c, 'M', 'reparation', need, budget, false);
          cover = need > eps ? math.min(1.0, r.qty / need) : 1.0;
        }
        b.cond = _worn(b.cond, wear, cover);
      } else if (b.ownerKind == 2) {
        b.cond = _worn(b.cond, wear, 0);
      }
    }
  }

  /// Service quotidien des hypothèques : intérêts + capital (versement constant). Un chantier ne paie que les intérêts.
  /// Faute d'argent, les intérêts du jour sont capitalisés et le retard grandit ; au-delà de foreclosureDays, saisie.
  void _serviceMortgages() {
    for (final m in List<Mortgage>.from(mortgages)) {
      if (m.borrowerKind == 2) continue; // en liquidation : plus de débiteur, plus d'intérêts
      final b = _bmap[m.buildingId];
      final Account? acct = m.borrowerKind == 0 ? _fmap[m.borrowerId] : _cmap[m.borrowerId];
      if (b == null || acct == null) {
        // débiteur ou bâtiment disparu sans nettoyage : on met le bâtiment en liquidation
        if (b != null) {
          _liquidate(b);
        } else {
          _writeOffMortgage(m, 'bâtiment disparu');
        }
        continue;
      }
      final interest = quantize(m.principal * (m.rate / 365));
      var capital = 0.0;
      if (b.done) {
        capital = m.termLeft <= 1 ? m.principal : math.min(m.principal, math.max(0.0, quantize(m.payment - interest)));
      }
      final due = interest + capital;
      if (due <= 0) continue;
      if (acct.money >= due) {
        final pi = transfer(acct, bank, interest);
        bank.interest += pi;
        bank.equity += pi;
        dayFlows.interest += pi;
        if (params.equalBanks && banks.isNotEmpty) _attrib(m.bankId, pi, income: pi); // la banque prêteuse
        if (acct is Firm) acct.costs += pi;
        if (capital > 0) _repayMortgage(m, acct, capital);
        m.missed = 0;
        if (b.done && m.termLeft > 0) m.termLeft--;
        if (m.principal <= eps) _dropMortgage(m);
      } else {
        m.principal += interest; // intérêts impayés capitalisés
        bank.capitalized += interest;
        bank.equity += interest;
        if (params.equalBanks && banks.isNotEmpty) _attrib(m.bankId, interest, income: interest);
        dayFlows.capitalized += interest;
        m.missed++;
        if (m.missed > params.foreclosureDays) _foreclose(m);
      }
    }
  }

  // ------------------------------------------------------------------ marché des logements

  void _housingMarket() {
    final p = params;
    // 1. mises en vente : ménages qui déménagent (s'ils peuvent rembourser leur hypothèque), un logement par bailleur
    for (final c in _ordered(citizens.where((c) => c.homeId != null), Flux.logement, (c) => c.id)) {
      final b = _bmap[c.homeId];
      if (b == null) {
        c.homeId = null;
        continue;
      }
      if (b.listedDay != null) {
        if (day - b.listedDay! > 200) b.listedDay = null; // personne n'en veut à ce prix : il le retire
        continue;
      }
      if (draw(Flux.logement, c.id, 11) >= p.relocateChance) continue;
      final owe = mortgageOf(b)?.principal ?? 0.0;
      b.listedDay = day;
      if (askPrice(b) < owe) b.listedDay = null; // vendre à ce prix ne rembourserait pas l'hypothèque
    }
    for (final f in firms) {
      if (f.type != 'immobilier') continue;
      final mine = [for (final b in buildings) if (b.ownerKind == 0 && b.ownerId == f.id && b.done) b];
      var units = 0, forSale = 0; // en logements ; un bailleur ne met en vente que des maisons
      for (final b in mine) {
        units += b.units;
        if (b.listedDay != null) forSale += b.units;
      }
      final target = math.max(1, (0.03 * units).round());
      final demand = f.demandEma['logement'] ?? 0.0;
      if (forSale < target && demand < p.landlordBuildAbove * (units - forSale)) {
        for (final b in mine) {
          if (b.listedDay == null && b.cond >= 0.5 && b.units == 1) {
            b.listedDay = day;
            break;
          }
        }
      }
    }
    // 2. un immeuble saisi est racheté par un bailleur (Params.buildingTypes ; sans types, il n'y en a pas)
    _landlordPurchases();
    // 3. acheteurs : un locataire en emploi qui veut devenir propriétaire regarde le marché de temps en temps
    final listed = [for (final b in buildings) if (b.done && b.listedDay != null) b];
    if (listed.isEmpty) return;
    for (final c in _ordered(citizens, Flux.logement, (c) => c.id)) {
      if (c.homeId != null || !c.wantsToOwn || c.employer == null) continue;
      if (draw(Flux.logement, c.id, 12) >= p.buyLookChance) continue;
      _tryBuy(c, listed);
      listed.removeWhere((b) => b.listedDay == null);
      if (listed.isEmpty) break;
    }
  }

  /// Un ménage regarde le logement en vente le moins cher et tente de l'acheter. Il n'achète que des maisons (un logement).
  void _tryBuy(Citizen c, List<Building> listed) {
    if (params.buildingTypes) {
      _tryBuyTyped(c, listed);
      return;
    }
    Building? best;
    var bestAsk = double.infinity;
    for (final b in listed) {
      if (b.listedDay == null || b.units > 1 || (b.ownerKind == 1 && b.ownerId == c.id)) continue;
      final a = askPrice(b);
      if (a < bestAsk) {
        bestAsk = a;
        best = b;
      }
    }
    if (best != null) _buyAt(c, best, bestAsk);
  }

  /// Types de bâtiments : parmi les maisons en vente, le ménage prend la plus chère que ses moyens permettent ; s'il n'en
  /// peut payer aucune, il tente la moins chère (et le refus est compté, comme sans les types).
  void _tryBuyTyped(Citizen c, List<Building> listed) {
    Building? best, cheapest;
    var bestAsk = 0.0, cheapAsk = double.infinity;
    for (final b in listed) {
      if (b.listedDay == null || b.units > 1 || (b.ownerKind == 1 && b.ownerId == c.id)) continue;
      final a = askPrice(b);
      if (a < cheapAsk) {
        cheapAsk = a;
        cheapest = b;
      }
      if (a > bestAsk && _means(c, b, a) == 0) {
        bestAsk = a;
        best = b;
      }
    }
    if (best != null) {
      _buyAt(c, best, bestAsk);
    } else if (cheapest != null) {
      _buyAt(c, cheapest, cheapAsk);
    }
  }

  /// Le citoyen (locataire) tente d'acheter ce bâtiment en vente, au prix demandé aujourd'hui, aux conditions du marché.
  /// Rend vrai si la vente a lieu. Pour les tests et le god mode. Un ménage n'achète que des maisons.
  bool buyHome(Citizen c, Building b) {
    if (c.homeId != null || !b.done || b.listedDay == null || b.units > 1 || (b.ownerKind == 1 && b.ownerId == c.id)) {
      return false;
    }
    return _buyAt(c, b, askPrice(b));
  }

  /// Conditions de crédit d'un achat à ce prix : prêt (mise de fonds minimale), taux, versement quotidien et entretien
  /// (qui suit la taille du bâtiment).
  ({double loan, double rate, double pay, double maint}) _terms(Building b, double price) {
    final p = params;
    final loan = modules.credit ? quantize(price * p.ltvHousehold) : 0.0;
    final rate = mortgageRate(loan / price);
    final maint = p.maintHoursPerDwelling * bestPrice('reparation') * sizeOf(b);
    final pay = loan > 0 ? _annuity(loan, rate / 365, p.mortgageTermHousehold) : 0.0;
    return (loan: loan, rate: rate, pay: pay, maint: maint);
  }

  /// Les moyens du ménage suffisent-ils ? 0 : oui ; 1 : il n'a pas la mise de fonds et un coussin de 10 jours de besoins ;
  /// 2 : le service de la dette (versement + entretien) dépasse 35 % de son revenu ou 1,2 fois le loyer d'un logement de
  /// même taille.
  int _means(Citizen c, Building b, double price) {
    final p = params;
    final t = _terms(b, price);
    if (c.money < price - t.loan + 10 * needCost) return 1;
    if (t.loan > 0 &&
        (t.pay + t.maint > safeguards.maxPaymentRatio * c.incomeEma ||
            t.pay + t.maint > p.buyRentRatio * bestPrice('logement') * sizeOf(b))) {
      return 2;
    }
    return 0;
  }

  /// Conditions d'achat : mise de fonds et coussin de 10 jours de besoins, service de la dette (versement + entretien) sous
  /// 35 % du revenu et sous 1,2 fois le loyer, fonds propres de la Caisse (hypothèques pondérées à 35 %).
  bool _buyAt(Citizen c, Building b, double price) {
    if (!(price > 0)) return false;
    final owe = mortgageOf(b)?.principal ?? 0.0;
    if (b.ownerKind != 2) {
      // le vendeur doit pouvoir rembourser son hypothèque avec le produit de la vente et ses propres liquidités
      final Account? sellerAcct = b.ownerKind == 0 ? _fmap[b.ownerId] : _cmap[b.ownerId];
      if (sellerAcct == null || sellerAcct.money + price < owe) return false;
    }
    final means = _means(c, b, price);
    if (means == 1) return false;
    final t = _terms(b, price);
    final loan = t.loan, rate = t.rate;
    if (loan > 0) {
      if (means == 2) {
        bstats.refused++;
        return false;
      }
      if (!_bankAllows(loan, _lenderOf(c))) {
        bank.refusals++;
        bstats.refused++;
        if (trace != null) {
          _t('credit', 'refus', c.name, c.id, 'I4 : règles prudentielles de la Caisse',
              'fonds propres insuffisants pour une hypothèque', loan, 'fonds propres ${fmtMoney0(bank.equity)}');
        }
        return false;
      }
    }
    _sell(b, c, price, loan, rate);
    return true;
  }

  /// Transaction : l'acheteur reçoit son hypothèque, paie le prix ; le vendeur (ou la Caisse) rembourse d'abord ce qui est
  /// dû sur le bâtiment ; gains et pertes de revente sont comptés.
  void _sell(Building b, Citizen buyer, double price, double loan, double rate) {
    final oldKind = b.ownerKind;
    final seller = oldKind == 0 ? _fmap[b.ownerId] : (oldKind == 1 ? _cmap[b.ownerId] : null);
    final old = mortgageOf(b);
    final gain = price - b.basis;
    b.mortgageId = null; // celui du bâtiment sera la nouvelle hypothèque
    if (loan > 0) _originate(buyer, 1, buyer.id, b, loan, rate, params.mortgageTermHousehold);
    if (oldKind == 2) {
      // vente de la Caisse : le produit rembourse le capital, le surplus va à l'ancien propriétaire ou à l'État
      final applied = old != null ? _repayMortgage(old, buyer, price) : 0.0;
      final rest = price - applied;
      if (rest > 0) {
        final payee = b.payee != null ? _cmap[b.payee] : null;
        transfer(buyer, payee ?? state, rest);
      }
      if (old != null) {
        if (old.principal > eps) {
          _writeOffMortgage(old, 'vente à perte d’un bâtiment saisi');
        } else {
          _dropMortgage(old);
        }
      }
    } else if (seller == null) {
      transfer(buyer, state, price); // vendeur disparu sans nettoyage : ne devrait pas arriver
      if (old != null) _writeOffMortgage(old, 'vendeur disparu');
    } else {
      final paid = transfer(buyer, seller, price);
      var repaid = 0.0;
      if (old != null) {
        repaid = _repayMortgage(old, seller, math.min(old.principal, seller.money));
        if (old.principal > eps) {
          _writeOffMortgage(old, 'produit de vente insuffisant');
        } else {
          _dropMortgage(old);
        }
      }
      if (seller is Firm) seller.reinvest += math.max(0.0, paid - repaid);
      if (seller is Citizen) seller.homeId = null;
    }
    b.ownerKind = 1;
    b.ownerId = buyer.id;
    b.payee = null;
    b.listedDay = null;
    b.basis = price;
    buyer.homeId = b.id;
    bstats.sales++;
    if (gain >= 0) {
      bstats.gains += gain;
    } else {
      bstats.losses -= gain;
    }
    bstats.priceEma = bstats.priceEma == 0 ? price : 0.9 * bstats.priceEma + 0.1 * price;
    _flow(seller is Firm ? seller.id.toString() : 'M', 'M', '\$logements', 1, price);
    if (trace != null) {
      _t('compta', 'vente_logement', buyer.name, buyer.id, 'marché des logements',
          oldKind == 2 ? 'vente de la Caisse' : (oldKind == 0 ? 'vente d’un bailleur' : 'revente entre ménages'), price,
          'gain du vendeur ${fmtMoney0(gain)}, hypothèque ${fmtMoney0(loan)}');
    }
  }

  /// Un immeuble (ou un duplex) saisi, en vente par la Caisse, est racheté au prix demandé par le bailleur qui manque le plus
  /// de logements (sa demande de nuitées au-delà de landlordBuildAbove fois son parc, chantiers compris), s'il a la mise de
  /// fonds au-delà de sa réserve et que la Caisse lui prête le reste (ltvFirm). Les ménages n'achètent que des maisons :
  /// sans cela, un immeuble saisi resterait vide et sans entretien. Sans types de bâtiments, il n'y a pas d'immeuble.
  void _landlordPurchases() {
    final offers = [for (final b in buildings) if (b.done && b.listedDay != null && b.units > 1 && b.ownerKind == 2) b];
    if (offers.isEmpty) return;
    final p = params;
    final park = <int, int>{};
    for (final b in buildings) {
      if (b.ownerKind == 0) park[b.ownerId!] = (park[b.ownerId!] ?? 0) + b.units;
    }
    final landlords = [for (final f in firms) if (f.type == 'immobilier') f];
    final short = {
      for (final f in landlords) f.id: (f.demandEma['logement'] ?? 0.0) / p.landlordBuildAbove - (park[f.id] ?? 0)
    };
    stableSort<Building>(offers, (a, b) => askPrice(a).compareTo(askPrice(b)));
    for (final b in offers) {
      final price = askPrice(b);
      if (!(price > 0)) continue;
      final loan = modules.credit ? quantize(price * p.ltvFirm) : 0.0;
      Firm? buyer;
      var most = 0.0;
      for (final f in landlords) {
        final s = short[f.id]!;
        if (s < 1 || s <= most) continue;
        if (f.money - 3 * f.wage * f.workers.length < price - loan) continue;
        if (loan > 0 && !_firmMayBorrow(f, loan)) continue;
        buyer = f;
        most = s;
      }
      if (buyer == null) continue;
      _sellToFirm(b, buyer, price, loan);
      short[buyer.id] = short[buyer.id]! - b.units;
    }
  }

  /// Vente d'un bâtiment saisi à un bailleur : la Caisse prête la part [loan] (nouvelle hypothèque), le produit rembourse
  /// l'ancienne hypothèque, le surplus va à l'ancien propriétaire ou à l'État, le solde non couvert est radié.
  void _sellToFirm(Building b, Firm f, double price, double loan) {
    final p = params;
    final old = mortgageOf(b);
    final gain = price - b.basis;
    b.mortgageId = null; // celui du bâtiment sera la nouvelle hypothèque
    if (loan > 0) _originate(f, 0, f.id, b, loan, mortgageRate(p.ltvFirm), p.mortgageTermFirm);
    final applied = old != null ? _repayMortgage(old, f, price) : 0.0;
    final rest = price - applied;
    if (rest > 0) {
      final payee = b.payee != null ? _cmap[b.payee] : null;
      transfer(f, payee ?? state, rest);
    }
    if (old != null) {
      if (old.principal > eps) {
        _writeOffMortgage(old, 'vente à perte d’un immeuble saisi');
      } else {
        _dropMortgage(old);
      }
    }
    f.reinvest = math.max(0.0, f.reinvest - price);
    b.ownerKind = 0;
    b.ownerId = f.id;
    b.payee = null;
    b.listedDay = null;
    b.basis = price;
    bstats.sales++;
    bstats.bought++;
    if (gain >= 0) {
      bstats.gains += gain;
    } else {
      bstats.losses -= gain;
    }
    _flow('B', f.id.toString(), '\$logements', 1, price);
    if (trace != null) {
      _t('compta', 'vente_logement', f.name, f.id, 'marché des logements', 'rachat d’un immeuble saisi', price,
          '${b.units} logements, hypothèque ${fmtMoney0(loan)}');
    }
  }

  // ------------------------------------------------------------------ chantiers

  /// Un bailleur peut-il financer un tirage hypothécaire ? Crédit actif, pas d'interdit, versements sous 35 % de sa valeur
  /// ajoutée, fonds propres de la Caisse.
  bool _firmMayBorrow(Firm f, double amount) {
    final p = params;
    if (!modules.credit || day < f.creditBanUntil) return false;
    var pay = amount * (baseRate() / 365 + 1 / p.mortgageTermFirm);
    for (final m in mortgages) {
      if (m.borrowerKind == 0 && m.borrowerId == f.id) pay += m.principal * (m.rate / 365 + 1 / p.mortgageTermFirm);
    }
    final added = math.max(0.0, f.revenueEma - f.inputSpendEma);
    if (pay > safeguards.maxPaymentRatio * added) return false;
    if (!_bankAllows(amount, _lenderOf(f))) {
      bank.refusals++;
      return false;
    }
    return true;
  }

  /// Un nouveau chantier pour ce bailleur (aucun module posé), d'un type de buildingKinds ou, sans type, d'un logement
  /// standard.
  Building newSite(Firm f, [int? type]) {
    final b = Building(_nextBuildingId++, 0, f.id, day, type);
    buildings.add(b);
    _bmap[b.id] = b;
    return b;
  }

  /// Type du chantier qu'un bailleur lance (Params.buildingTypes) quand il lui manque [short] logements : le plus grand
  /// duplex ou immeuble qui ne dépasse pas ce manque et dont il peut payer sa part ([cash] au-delà de sa réserve couvre un
  /// jour et demi de chantier et la part du coût que la Caisse ne prête pas) ; à défaut, une maison (petite, moyenne ou
  /// grande au hasard : 35, 45 et 20 %) s'il peut en payer un jour et demi de chantier ; sinon null.
  int? _siteType(Firm f, int short, double cash) {
    final p = params;
    final mc = moduleCost();
    for (var t = buildingKinds.length - 1; t >= 3; t--) {
      final bt = buildingKinds[t];
      if (bt.units > short) continue;
      final cost = (bt.size * p.dwellingModules).round() * mc;
      if (cash >= 1.5 * bt.crew * mc && cash >= (1 - p.ltvFirm) * cost) return t;
    }
    if (cash < 1.5 * mc) return null;
    final u = draw(Flux.logement, f.id, 14);
    return u < 0.35 ? 0 : (u < 0.8 ? 1 : 2);
  }

  /// Un bailleur dont la demande dépasse son parc (chantiers compris) lance un chantier ; chaque chantier achète ses
  /// modules de construction (un par jour, ou la cadence de son type), financés en partie par un tirage hypothécaire.
  void _construction() {
    final p = params;
    for (final f in firms) {
      if (f.type != 'immobilier') continue;
      final mine = [for (final b in buildings) if (b.ownerKind == 0 && b.ownerId == f.id) b];
      final sites = [for (final b in mine) if (!b.done) b];
      var units = 0, siteUnits = 0; // logements terminés et en chantier
      for (final b in mine) {
        if (b.done) {
          units += b.units;
        } else {
          siteUnits += b.units;
        }
      }
      final demand = f.demandEma['logement'] ?? 0.0;
      final reserve = 3 * f.wage * f.workers.length;
      if (sites.length < 2 && day >= 5 && f.workers.isNotEmpty && demand > p.landlordBuildAbove * (units + siteUnits)) {
        if (!p.buildingTypes) {
          if (f.money - reserve >= 1.5 * moduleCost()) sites.add(newSite(f));
        } else {
          final short = (demand / p.landlordBuildAbove).ceil() - (units + siteUnits);
          final t = _siteType(f, short, f.money - reserve);
          if (t != null) sites.add(newSite(f, t));
        }
      }
      for (final b in sites) {
        final budget = f.money - 3 * f.wage * f.workers.length;
        if (budget <= 0) continue;
        final q = b.type == null ? 1 : math.min(buildingKinds[b.type!].crew, modulesOf(b) - b.modules);
        final r = buy(f, f.id.toString(), 'batiment', q.toDouble(), budget, true);
        if (r.qty < 1) continue;
        b.modules += r.qty.round();
        b.basis += r.spent;
        f.reinvest = math.max(0.0, f.reinvest - r.spent);
        var m = mortgageOf(b);
        final d = quantize(r.spent * p.ltvFirm);
        if (d > 0 && _firmMayBorrow(f, d)) {
          if (m == null) {
            m = _originate(f, 0, f.id, b, d, mortgageRate(p.ltvFirm), p.mortgageTermFirm);
          } else {
            _draw(m, f, d);
          }
        }
        if (b.modules >= modulesOf(b)) {
          b.done = true;
          b.cond = 1;
          bstats.built++;
          if (m != null) m.payment = quantize(_annuity(m.principal, m.rate / 365, m.termLeft));
          if (trace != null) {
            _t('compta', 'chantier_termine', f.name, f.id, 'construction',
                b.type == null ? 'logement terminé' : '${buildingKinds[b.type!].name} terminé', b.basis, 'bâtiment ${b.id}');
          }
        }
      }
    }
  }

  /// Coût quotidien du parc d'un bailleur, qui entre dans son prix de revient (donc dans le loyer) : intérêts de ses
  /// hypothèques et provision pour la part de l'usure qu'aucun entretien ne compense.
  void _updateCarry() {
    final p = params;
    final prov = replacementCost() * p.buildingWearYear * (1 - p.buildingMaintShare) / 365;
    for (final f in firms) {
      if (f.type != 'immobilier') continue;
      var interest = 0.0;
      for (final m in mortgages) {
        if (m.borrowerKind == 0 && m.borrowerId == f.id) interest += m.principal * (m.rate / 365);
      }
      var load = 0.0; // logements standards
      for (final b in buildings) {
        if (b.ownerKind == 0 && b.ownerId == f.id && b.done) load += sizeOf(b);
      }
      f.carry = interest + prov * load;
    }
  }

  // ------------------------------------------------------------------ locataires des immeubles

  /// Bâtiment où loue ce citoyen (Params.buildingTypes avec les baux), s'il tient encore : bail chez le propriétaire du
  /// bâtiment, bâtiment habitable. Null sinon.
  Building? dwellingOf(Citizen c) {
    final id = c.dwellingId;
    if (id == null || c.leaseFirm == null || c.homeId != null) return null;
    final b = _bmap[id];
    return b != null && b.habitable && b.ownerKind == 0 && b.ownerId == c.leaseFirm ? b : null;
  }

  /// Types de bâtiments avec les baux, en fin de journée : chaque locataire est rattaché à un logement de son bailleur. Un
  /// rattachement qui tient est gardé (dwellingOf, et pas plus de locataires que de logements) ; les autres locataires
  /// prennent le premier logement libre de leur bailleur, dans l'ordre du parc. Affichage seulement : rien d'autre dans le
  /// moteur ne lit ce rattachement.
  void _assignDwellings() {
    final used = <int, int>{};
    for (final c in citizens) {
      if (c.dwellingId == null) continue;
      final b = dwellingOf(c);
      if (b == null || (used[b.id] ?? 0) >= b.units) {
        c.dwellingId = null;
        continue;
      }
      used[b.id] = (used[b.id] ?? 0) + 1;
    }
    Map<int, List<Building>>? free;
    final next = <int, int>{};
    for (final c in citizens) {
      final lf = c.leaseFirm;
      if (lf == null || c.homeId != null || c.dwellingId != null) continue;
      if (free == null) {
        free = {};
        for (final b in buildings) {
          if (b.ownerKind == 0 && b.habitable) (free[b.ownerId!] ??= <Building>[]).add(b);
        }
      }
      final list = free[lf];
      if (list == null) continue;
      var i = next[lf] ?? 0;
      while (i < list.length && (used[list[i].id] ?? 0) >= list[i].units) {
        i++;
      }
      next[lf] = i;
      if (i == list.length) continue;
      c.dwellingId = list[i].id;
      used[list[i].id] = (used[list[i].id] ?? 0) + 1;
    }
  }
}
