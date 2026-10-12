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
  double gains = 0; // somme des gains de revente (prix − coût d'acquisition du vendeur), quand positifs
  double losses = 0; // somme des pertes de revente (valeur absolue)
  double priceEma = 0; // prix de vente moyen, lissé

  void clear() {
    built = sales = foreclosures = opened = refused = abandoned = 0;
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
  int get dwellings => buildings.where((b) => b.habitable).length;

  // ------------------------------------------------------------------ valeurs

  /// Prix d'un module de construction : le meilleur prix offert, à défaut le prix de départ.
  double moduleCost() => bestPrice('batiment');

  /// Coût de remplacement d'un logement neuf.
  double replacementCost() => params.dwellingModules * moduleCost();

  /// Valeur courante : coût de remplacement, rabattu selon l'état (un logement à l'état 0 vaut encore le quart : le
  /// terrain et les fondations), un peu plus cher quand les logements manquent (chaleur du marché, de −1 à +1 : ±15 %).
  double fairValue(Building b) => replacementCost() * (0.25 + 0.75 * b.cond) * (1 + 0.15 * housingHeat);

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
      params.interestRate + params.mortgageSpreadMax * ((ltv - 0.5) / 0.45).clamp(0.0, 1.0).toDouble();

  /// La Caisse peut-elle prêter ce montant ? Fonds propres ≥ plancher × (exposition pondérée actuelle + prêt pondéré).
  bool _bankAllows(double loan) {
    if (!modules.credit) return false;
    if (modules.bankRegulation || safeguards.credit) {
      final need = safeguards.minCapitalRatio * (totalDebt() + params.mortgageRiskWeight * loan);
      if (bank.equity < need) return false;
    }
    return true;
  }

  // ------------------------------------------------------------------ hypothèques : monnaie

  /// Crée une hypothèque : la Caisse crée la monnaie prêtée et la verse à l'emprunteur.
  Mortgage? _originate(Account borrower, int kind, int borrowerId, Building b, double amount, double rate, int term) {
    final a = transfer(null, borrower, amount);
    if (a <= 0) return null;
    ledgerCredit += a;
    bank.lent += a;
    dayFlows.loans += a;
    final m = Mortgage(_nextMortgageId++, b.id, kind, borrowerId, a, rate, term, day);
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

  // ------------------------------------------------------------------ chaque jour

  /// Début de journée : la capacité de chaque bailleur suit son parc habitable ; chaleur du marché.
  void _buildingsMorning() {
    if (!_buildingsSeeded) _seedBuildings();
    final units = <int, int>{};
    for (final b in buildings) {
      if (b.ownerKind == 0 && b.habitable) units[b.ownerId!] = (units[b.ownerId!] ?? 0) + 1;
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
      final need = p.maintHoursPerDwelling * e.value.length;
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
          final need = p.maintHoursPerDwelling;
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
        if (acct is Firm) acct.costs += pi;
        if (capital > 0) _repayMortgage(m, acct, capital);
        m.missed = 0;
        if (b.done && m.termLeft > 0) m.termLeft--;
        if (m.principal <= eps) _dropMortgage(m);
      } else {
        m.principal += interest; // intérêts impayés capitalisés
        bank.capitalized += interest;
        bank.equity += interest;
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
      final forSale = mine.where((b) => b.listedDay != null).length;
      final target = math.max(1, (0.03 * mine.length).round());
      final demand = f.demandEma['logement'] ?? 0.0;
      if (forSale < target && demand < p.landlordBuildAbove * (mine.length - forSale)) {
        for (final b in mine) {
          if (b.listedDay == null && b.cond >= 0.5) {
            b.listedDay = day;
            break;
          }
        }
      }
    }
    // 2. acheteurs : un locataire en emploi qui veut devenir propriétaire regarde le marché de temps en temps
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

  /// Un ménage regarde le logement en vente le moins cher et tente de l'acheter.
  void _tryBuy(Citizen c, List<Building> listed) {
    Building? best;
    var bestAsk = double.infinity;
    for (final b in listed) {
      if (b.listedDay == null || (b.ownerKind == 1 && b.ownerId == c.id)) continue;
      final a = askPrice(b);
      if (a < bestAsk) {
        bestAsk = a;
        best = b;
      }
    }
    if (best != null) _buyAt(c, best, bestAsk);
  }

  /// Le citoyen (locataire) tente d'acheter ce bâtiment en vente, au prix demandé aujourd'hui, aux conditions du marché.
  /// Rend vrai si la vente a lieu. Pour les tests et le god mode.
  bool buyHome(Citizen c, Building b) {
    if (c.homeId != null || !b.done || b.listedDay == null || (b.ownerKind == 1 && b.ownerId == c.id)) return false;
    return _buyAt(c, b, askPrice(b));
  }

  /// Conditions d'achat : mise de fonds et coussin de 10 jours de besoins, service de la dette (versement + entretien) sous
  /// 35 % du revenu et sous 1,2 fois le loyer, fonds propres de la Caisse (hypothèques pondérées à 35 %).
  bool _buyAt(Citizen c, Building b, double price) {
    final p = params;
    if (!(price > 0)) return false;
    final owe = mortgageOf(b)?.principal ?? 0.0;
    if (b.ownerKind != 2) {
      // le vendeur doit pouvoir rembourser son hypothèque avec le produit de la vente et ses propres liquidités
      final Account? sellerAcct = b.ownerKind == 0 ? _fmap[b.ownerId] : _cmap[b.ownerId];
      if (sellerAcct == null || sellerAcct.money + price < owe) return false;
    }
    final loan = modules.credit ? quantize(price * p.ltvHousehold) : 0.0;
    final down = price - loan;
    final buffer = 10 * needCost;
    if (c.money < down + buffer) return false;
    final rate = mortgageRate(loan / price);
    final maint = p.maintHoursPerDwelling * bestPrice('reparation');
    if (loan > 0) {
      final pay = _annuity(loan, rate / 365, p.mortgageTermHousehold);
      if (pay + maint > safeguards.maxPaymentRatio * c.incomeEma || pay + maint > p.buyRentRatio * bestPrice('logement')) {
        bstats.refused++;
        return false;
      }
      if (!_bankAllows(loan)) {
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

  // ------------------------------------------------------------------ chantiers

  /// Un bailleur peut-il financer un tirage hypothécaire ? Crédit actif, pas d'interdit, versements sous 35 % de sa valeur
  /// ajoutée, fonds propres de la Caisse.
  bool _firmMayBorrow(Firm f, double amount) {
    final p = params;
    if (!modules.credit || day < f.creditBanUntil) return false;
    var pay = amount * (p.interestRate / 365 + 1 / p.mortgageTermFirm);
    for (final m in mortgages) {
      if (m.borrowerKind == 0 && m.borrowerId == f.id) pay += m.principal * (m.rate / 365 + 1 / p.mortgageTermFirm);
    }
    final added = math.max(0.0, f.revenueEma - f.inputSpendEma);
    if (pay > safeguards.maxPaymentRatio * added) return false;
    if (!_bankAllows(amount)) {
      bank.refusals++;
      return false;
    }
    return true;
  }

  /// Un nouveau chantier de logement pour ce bailleur (aucun module posé).
  Building newSite(Firm f) {
    final b = Building(_nextBuildingId++, 0, f.id, day);
    buildings.add(b);
    _bmap[b.id] = b;
    return b;
  }

  /// Un bailleur dont la demande dépasse son parc (chantiers compris) lance un chantier ; chaque chantier achète un module
  /// de construction par jour, financé en partie par un tirage hypothécaire.
  void _construction() {
    final p = params;
    for (final f in firms) {
      if (f.type != 'immobilier') continue;
      final mine = [for (final b in buildings) if (b.ownerKind == 0 && b.ownerId == f.id) b];
      final sites = [for (final b in mine) if (!b.done) b];
      final units = mine.length - sites.length;
      final demand = f.demandEma['logement'] ?? 0.0;
      final reserve = 3 * f.wage * f.workers.length;
      if (sites.length < 2 && day >= 5 && f.workers.isNotEmpty && demand > p.landlordBuildAbove * (units + sites.length) &&
          f.money - reserve >= 1.5 * moduleCost()) {
        sites.add(newSite(f));
      }
      for (final b in sites) {
        final budget = f.money - 3 * f.wage * f.workers.length;
        if (budget <= 0) continue;
        final r = buy(f, f.id.toString(), 'batiment', 1, budget, true);
        if (r.qty < 1) continue;
        b.modules++;
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
        if (b.modules >= p.dwellingModules) {
          b.done = true;
          b.cond = 1;
          bstats.built++;
          if (m != null) m.payment = quantize(_annuity(m.principal, m.rate / 365, m.termLeft));
          if (trace != null) {
            _t('compta', 'chantier_termine', f.name, f.id, 'construction', 'logement terminé', b.basis, 'bâtiment ${b.id}');
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
      var n = 0;
      for (final b in buildings) {
        if (b.ownerKind == 0 && b.ownerId == f.id && b.done) n++;
      }
      f.carry = interest + prov * n;
    }
  }
}
