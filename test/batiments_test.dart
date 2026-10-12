// Bâtiments, construction et hypothèques (module « buildings ») : parc de départ, octroi hypothécaire, saisie, revente,
// usure, nettoyage à la fermeture d'un bailleur, conservation comptable au bit près, instantanés.
//
// Ces tests ont été écrits sans pouvoir exécuter Dart (SDK inaccessible depuis l'environnement de rédaction) :
// à lancer avec `flutter test test/batiments_test.dart`. Les tests marqués « calibration » vérifient que le marché
// fonctionne avec les valeurs par défaut des paramètres ; ils peuvent échouer sans que le moteur soit faux.

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

void run(Sim s, int days) {
  for (var i = 0; i < days; i++) {
    s.step();
  }
}

Sim make({int seed = 3, bool devChecks = true, void Function(Params)? tune}) {
  final p = Params();
  tune?.call(p);
  return Sim(seed: seed, params: p, modules: Modules()..buildings = true, devChecks: devChecks);
}

/// Les liens entre bâtiments, propriétaires et hypothèques sont cohérents.
void checkParc(Sim s) {
  final ids = <int>{};
  final homes = <int>{};
  for (final b in s.buildings) {
    expect(ids.add(b.id), isTrue, reason: 'identifiant de bâtiment en double ${b.id}');
    expect(b.cond >= 0 && b.cond <= 1, isTrue, reason: 'état hors bornes ${b.cond}');
    if (b.ownerKind == 0) expect(s.firm(b.ownerId!), isNotNull, reason: 'bailleur disparu pour le bâtiment ${b.id}');
    if (b.ownerKind == 1) {
      final c = s.citizen(b.ownerId!);
      expect(c, isNotNull, reason: 'propriétaire disparu pour le bâtiment ${b.id}');
      expect(c!.homeId, b.id);
      expect(homes.add(c.id), isTrue, reason: 'un citoyen possède deux logements');
    }
    if (b.ownerKind == 2) expect(b.ownerId, isNull);
    if (!b.done) expect(b.ownerKind, isNot(2), reason: 'un chantier inachevé ne peut pas être en liquidation');
    final m = s.mortgageOf(b);
    if (b.mortgageId != null) {
      expect(m, isNotNull, reason: 'hypothèque absente pour le bâtiment ${b.id}');
      expect(m!.buildingId, b.id);
      expect(m.principal >= 0, isTrue);
      expect(m.borrowerKind == 2, b.ownerKind == 2, reason: 'débiteur et propriétaire divergent (bâtiment ${b.id})');
    }
  }
  for (final m in s.mortgages) {
    expect(s.building(m.buildingId), isNotNull, reason: 'hypothèque ${m.id} sans bâtiment');
  }
  for (final c in s.citizens) {
    if (c.homeId != null) {
      final b = s.building(c.homeId!);
      expect(b, isNotNull);
      expect(b!.ownerKind, 1);
      expect(b.ownerId, c.id);
    }
  }
  // les prêts de la Caisse : dettes des entreprises + capital hypothécaire
  var firmDebt = 0.0;
  for (final f in s.firms) {
    firmDebt += f.debt;
  }
  expect(s.totalLoans(), firmDebt + s.mortgageDebt());
  expect(s.inv.worst, 0);
}

/// Un bâtiment de bailleur, mis en vente, et un citoyen aisé et solvable pour l'acheter.
({Sim s, Building b, Citizen c}) scene({int seed = 3}) {
  final s = make(seed: seed, tune: (p) {
    p.buyLookChance = 0; // pas d'acheteur spontané : le test choisit qui achète quoi
    p.buyRentRatio = 1000; // on isole les règles de crédit de la calibration du loyer
  });
  run(s, 5);
  final b = s.buildings.firstWhere((x) => x.ownerKind == 0 && x.done);
  b.listedDay = s.day;
  final c = s.citizens.firstWhere((x) => x.homeId == null && x.employer != null);
  s.godMoney(Target('citizen', c.id), 20000 - c.money);
  c.incomeEma = 130;
  return (s: s, b: b, c: c);
}

void main() {
  test('le module est coupé par défaut : ni bâtiment, ni hypothèque, ni entreprise de construction', () {
    expect(Modules().buildings, isFalse);
    final s = Sim(seed: 3, devChecks: true);
    run(s, 120);
    expect(s.buildings, isEmpty);
    expect(s.mortgages, isEmpty);
    expect(s.firms.any((f) => f.type == 'construction'), isFalse);
    expect(s.totalLoans(), s.totalDebt());
    expect(s.citizens.every((c) => c.homeId == null && !c.wantsToOwn), isTrue);
  });

  test('parc de départ : un bâtiment par logement de capacité, une entreprise de construction', () {
    final s = make();
    expect(s.firms.any((f) => f.type == 'construction'), isTrue);
    for (final f in s.firms.where((f) => f.type == 'immobilier')) {
      final n = s.buildings.where((b) => b.ownerKind == 0 && b.ownerId == f.id && b.habitable).length;
      expect(n, f.capacity!.round());
      expect(n, greaterThan(0));
    }
    expect(s.dwellings, greaterThanOrEqualTo(s.citizens.length));
    expect(s.buildings.every((b) => b.done && b.cond >= 0.7 && b.cond <= 1), isTrue);
    checkParc(s);
    run(s, 30);
    // la capacité d'un bailleur suit son parc habitable
    for (final f in s.firms.where((f) => f.type == 'immobilier')) {
      final n = s.buildings.where((b) => b.ownerKind == 0 && b.ownerId == f.id && b.habitable).length;
      expect(f.capacity, n.toDouble());
    }
  });

  test('achat : mise de fonds de 5 %, hypothèque créée, monnaie créée puis détruite au bit près', () {
    final x = scene();
    final s = x.s, b = x.b, c = x.c;
    final price = s.askPrice(b);
    final lent0 = s.bank.lent, credit0 = s.ledgerCredit, money0 = c.money;
    expect(s.buyHome(c, b), isTrue);
    final m = s.mortgageOf(b)!;
    expect(m.principal, closeTo(price * s.params.ltvHousehold, 1 / 1024));
    expect(s.bank.lent - lent0, m.principal);
    expect(s.ledgerCredit - credit0, m.principal);
    expect(c.homeId, b.id);
    expect(b.ownerKind, 1);
    expect(b.listedDay, isNull);
    expect(b.basis, price);
    expect(c.money, closeTo(money0 + m.principal - price, 1 / 1024)); // mise de fonds payée
    expect(m.borrowerKind, 1);
    run(s, 40); // versement quotidien : intérêts aux fonds propres, capital détruit
    expect(s.mortgages.contains(m), isTrue);
    expect(m.principal, lessThan(price * s.params.ltvHousehold));
    expect(m.missed, 0);
    checkParc(s);
  });

  test('un propriétaire-occupant ne paie plus de nuitée', () {
    final x = scene();
    final s = x.s, c = x.c;
    expect(s.buyHome(c, x.b), isTrue);
    s.step();
    expect(c.homeless, isFalse);
    expect(c.sat['logement'], 1);
    // les autres citoyens louent toujours : la demande de nuitées est celle des locataires
    final renters = s.citizens.where((k) => k.homeId == null).length;
    expect(s.marketStats['logement']!.qty, lessThanOrEqualTo(renters.toDouble()));
  });

  test('octroi refusé : service de la dette au-delà de 35 % du revenu', () {
    final x = scene();
    final s = x.s;
    x.c.incomeEma = 5; // versement + entretien >> 35 % de 5 $/j
    final refused0 = s.bstats.refused, mortgages0 = s.mortgages.length;
    expect(s.buyHome(x.c, x.b), isFalse);
    expect(s.bstats.refused, refused0 + 1);
    expect(s.mortgages.length, mortgages0);
    expect(x.b.ownerKind, 0);
    expect(x.c.homeId, isNull);
    s.step();
    expect(s.inv.worst, 0);
  });

  test('octroi refusé : fonds propres de la Caisse sous le plancher (hypothèques pondérées à 35 %)', () {
    final x = scene();
    final s = x.s;
    s.bank.equity = 0;
    final refusals0 = s.bank.refusals;
    expect(s.buyHome(x.c, x.b), isFalse);
    expect(s.bank.refusals, refusals0 + 1);
    expect(s.mortgages, isEmpty);
    // avec assez de fonds propres pour le prêt pondéré, l'octroi passe
    final price = s.askPrice(x.b);
    s.bank.equity = s.safeguards.minCapitalRatio * (s.totalDebt() + s.params.mortgageRiskWeight * price) + 1;
    expect(s.buyHome(x.c, x.b), isTrue);
  });

  test('octroi refusé : mise de fonds insuffisante', () {
    final x = scene();
    final s = x.s;
    s.godMoney(Target('citizen', x.c.id), 100 - x.c.money);
    expect(s.buyHome(x.c, x.b), isFalse);
    expect(s.mortgages, isEmpty);
    expect(x.c.homeId, isNull);
  });

  test('saisie après 60 jours de retard : la dette reste inscrite, le bâtiment est mis en vente et ne s’entretient plus', () {
    final x = scene();
    final s = x.s, b = x.b, c = x.c;
    expect(s.buyHome(c, b), isTrue);
    final m = s.mortgageOf(b)!;
    final principal0 = m.principal;
    final off0 = s.bank.writtenOff;
    s.godMoney(Target('citizen', c.id), -c.money); // sans le sou
    m.payment = 1e6; // un versement hors de portée : retard chaque jour
    for (var d = 0; d < s.params.foreclosureDays; d++) {
      s.step();
    }
    expect(m.missed, greaterThan(0));
    expect(s.bstats.foreclosures, 0);
    expect(m.principal, greaterThan(principal0)); // intérêts impayés capitalisés
    run(s, 3);
    expect(s.bstats.foreclosures, 1);
    expect(b.ownerKind, 2);
    expect(b.ownerId, isNull);
    expect(b.payee, c.id); // le surplus éventuel reviendrait à l'ancien propriétaire
    expect(c.homeId, isNull);
    expect(m.borrowerKind, 2);
    expect(b.listedDay, isNotNull);
    expect(s.mortgages.contains(m), isTrue); // pas de radiation avant la vente de la garantie
    expect(s.bank.writtenOff, off0);
    final debt = m.principal;
    final cond = b.cond;
    run(s, 10);
    expect(m.principal, debt); // plus d'intérêts : la Caisse détient la garantie
    expect(b.cond, lessThan(cond)); // pas d'entretien
    checkParc(s);
  });

  test('vente de la Caisse : le produit rembourse le capital, le solde est radié des fonds propres', () {
    final x = scene();
    final s = x.s, b = x.b, c = x.c;
    expect(s.buyHome(c, b), isTrue);
    final m = s.mortgageOf(b)!;
    s.godMoney(Target('citizen', c.id), -c.money);
    m.payment = 1e6;
    run(s, s.params.foreclosureDays + 3);
    expect(b.ownerKind, 2);
    final owed = m.principal;
    final buyer = s.citizens.firstWhere((k) => k.homeId == null && k.employer != null && !identical(k, c));
    s.godMoney(Target('citizen', buyer.id), 40000 - buyer.money);
    buyer.incomeEma = 130;
    final price = s.askPrice(b); // 10 % sous la valeur courante
    final equity0 = s.bank.equity, repaid0 = s.bank.repaid, off0 = s.bank.writtenOff, former0 = c.money;
    expect(s.buyHome(buyer, b), isTrue);
    // le prix rembourse d'abord le capital dû ; l'écart éventuel est une perte de la Caisse, le surplus revient à l'ancien propriétaire
    final applied = price < owed ? price : owed;
    expect(s.bank.repaid - repaid0, closeTo(applied, 1 / 1024));
    expect(s.bank.writtenOff - off0, closeTo(price < owed ? owed - price : 0, 1 / 1024));
    expect(s.bank.equity - equity0, closeTo(price < owed ? -(owed - price) : 0, 1 / 1024));
    expect(c.money - former0, closeTo(price > owed ? price - owed : 0, 1 / 1024));
    expect(s.mortgages.contains(m), isFalse);
    expect(b.ownerKind, 1);
    expect(b.ownerId, buyer.id);
    s.step();
    checkParc(s);
  });

  test('revente entre ménages : gain ou perte = prix − coût d’acquisition du vendeur, comptés', () {
    final x = scene();
    final s = x.s, b = x.b, c = x.c;
    expect(s.buyHome(c, b), isTrue);
    final paid = b.basis;
    b.cond = 0.4; // le bâtiment s'est détérioré : revente à perte
    b.listedDay = s.day;
    final buyer = s.citizens.firstWhere((k) => k.homeId == null && k.employer != null && !identical(k, c));
    s.godMoney(Target('citizen', buyer.id), 40000 - buyer.money);
    buyer.incomeEma = 130;
    s.godMoney(Target('citizen', c.id), 40000 - c.money); // le vendeur peut combler l'écart avec sa dette
    final price = s.askPrice(b);
    expect(price, lessThan(paid));
    final losses0 = s.bstats.losses, sales0 = s.bstats.sales, off0 = s.bank.writtenOff;
    final old = s.mortgageOf(b)!;
    expect(s.buyHome(buyer, b), isTrue);
    expect(s.bstats.sales, sales0 + 1);
    expect(s.bstats.losses - losses0, closeTo(paid - price, 1 / 1024));
    expect(c.homeId, isNull); // le vendeur redevient locataire
    expect(s.mortgages.contains(old), isFalse); // son hypothèque est remboursée en entier (la Caisse ne perd rien)
    expect(s.bank.writtenOff, off0);
    expect(s.mortgageOf(b)!.borrowerId, buyer.id);
    s.step();
    checkParc(s);
  });

  test('revente entre ménages refusée si le vendeur ne peut pas rembourser son hypothèque', () {
    final x = scene();
    final s = x.s, b = x.b, c = x.c;
    expect(s.buyHome(c, b), isTrue);
    b.cond = 0.4;
    b.listedDay = s.day;
    s.godMoney(Target('citizen', c.id), -c.money); // le vendeur est sans le sou
    final buyer = s.citizens.firstWhere((k) => k.homeId == null && k.employer != null && !identical(k, c));
    s.godMoney(Target('citizen', buyer.id), 40000 - buyer.money);
    buyer.incomeEma = 130;
    expect(s.askPrice(b), lessThan(s.mortgageOf(b)!.principal));
    expect(s.buyHome(buyer, b), isFalse);
    expect(c.homeId, b.id);
  });

  test('revente à profit quand le marché est serré', () {
    final x = scene();
    final s = x.s, b = x.b, c = x.c;
    s.housingHeat = -1; // logements vacants : valeur −15 %
    expect(s.buyHome(c, b), isTrue);
    final paid = b.basis;
    s.housingHeat = 1; // logements rares : valeur +15 %
    b.listedDay = s.day;
    final buyer = s.citizens.firstWhere((k) => k.homeId == null && k.employer != null && !identical(k, c));
    s.godMoney(Target('citizen', buyer.id), 60000 - buyer.money);
    buyer.incomeEma = 200;
    final price = s.askPrice(b);
    expect(price, greaterThan(paid));
    final gains0 = s.bstats.gains;
    expect(s.buyHome(buyer, b), isTrue);
    expect(s.bstats.gains - gains0, closeTo(price - paid, 1 / 1024));
    s.step();
    checkParc(s);
  });

  test('usure : sans entretien, l’état baisse de 4 % par an ; avec entretien, de 1 %', () {
    final s = make(tune: (p) => p.buyLookChance = 0);
    run(s, 2);
    final b = s.buildings.firstWhere((x) => x.ownerKind == 0);
    final w = s.params.buildingWearYear / 365;
    final cond = b.cond;
    b.ownerKind = 2; // en liquidation : jamais entretenu (le test n'a pas besoin de l'ancien propriétaire)
    b.ownerId = null;
    b.listedDay = null;
    // un bâtiment en liquidation non listé ne bouge pas autrement
    run(s, 50);
    expect(b.cond, closeTo(cond - 50 * w, 1e-9));
    // un bailleur qui entretient perd au plus le quart restant (4 % × (1 − 75 %))
    final c2 = s.buildings.firstWhere((x) => x.ownerKind == 0);
    final cond2 = c2.cond;
    run(s, 50);
    expect(cond2 - c2.cond, lessThanOrEqualTo(50 * w + 1e-9));
    expect(cond2 - c2.cond, greaterThanOrEqualTo(50 * w * (1 - s.params.buildingMaintShare) - 1e-9));
  });

  test('un bailleur qui ferme : ses bâtiments passent en liquidation, ses chantiers sont abandonnés', () {
    final s = make(tune: (p) => p.buyLookChance = 0);
    run(s, 20);
    final f = s.firms.firstWhere((x) => x.type == 'immobilier');
    // un chantier de ce bailleur, avec une hypothèque (tirage manuel via un achat de module simulé : état seulement)
    final site = s.newSite(f)..modules = 3;
    final n = s.buildings.where((b) => b.ownerKind == 0 && b.ownerId == f.id && b.done).length;
    expect(n, greaterThan(0));
    s.removeFirm(f.id);
    expect(s.buildings.any((b) => b.id == site.id), isFalse); // chantier abandonné
    expect(s.bstats.abandoned, 1);
    expect(s.buildings.where((b) => b.ownerKind == 2 && b.listedDay != null).length, n);
    s.step();
    checkParc(s);
    run(s, 30);
    checkParc(s);
  });

  test('des citoyens propriétaires quittent la région : leurs logements passent en liquidation', () {
    final s = make(seed: 4, tune: (p) {
      p.buyLookChance = 0;
      p.buyRentRatio = 1000;
    });
    run(s, 10);
    var bought = 0;
    for (final c in List<Citizen>.from(s.citizens)) {
      if (bought >= 25) break;
      if (c.homeId != null || c.employer == null) continue;
      final b = s.buildings.where((x) => x.ownerKind == 0 && x.done && x.listedDay == null).firstOrNull;
      if (b == null) break;
      b.listedDay = s.day;
      s.godMoney(Target('citizen', c.id), 30000 - c.money);
      c.incomeEma = 130;
      if (s.buyHome(c, b)) bought++;
    }
    expect(bought, greaterThan(5));
    run(s, 3);
    checkParc(s);
    s.godRemoveCitizens(120);
    s.step();
    checkParc(s);
    expect(s.buildings.where((b) => b.ownerKind == 2).isNotEmpty, isTrue);
    run(s, 60);
    checkParc(s);
  });

  test('conservation : invariants nuls pendant 700 jours sur 4 graines, avec chocs', () {
    for (final seed in [1, 2, 3, 4]) {
      final s = make(seed: seed);
      for (var d = 1; d <= 700; d++) {
        if (d == 120) s.godAddCitizens(25, 2000);
        if (d == 300) s.godMoney(const Target('allCitizens'), 3000);
        if (d == 450) s.godRemoveCitizens(20);
        if (d == 500) s.godBankrupt(s.firms.firstWhere((f) => f.type == 'immobilier').id);
        s.step(); // en mode développement, un invariant rompu lève une exception
        if (d % 50 == 0) checkParc(s);
      }
      checkParc(s);
    }
  });

  test('calibration : le marché fonctionne avec les valeurs par défaut (ventes, hypothèques, bâtiments entretenus)', () {
    var sales = 0, opened = 0;
    for (final seed in [1, 2, 3, 4]) {
      final s = make(seed: seed);
      run(s, 800);
      sales += s.bstats.sales;
      opened += s.bstats.opened;
      // le parc suit la population sans god mode : presque personne n'est sans logis
      final homeless = s.citizens.where((c) => c.homeless).length;
      expect(homeless, lessThan(s.citizens.length * 0.1), reason: 'graine $seed : $homeless sans-abri');
      expect(s.dwellings, greaterThanOrEqualTo((s.citizens.length * 0.95).floor()), reason: 'graine $seed');
    }
    expect(sales, greaterThan(0));
    expect(opened, greaterThan(0));
  });

  test('instantané : reprise exacte avec bâtiments et hypothèques', () {
    String snap(Sim s) => jsonEncode(s.toSnapshot());
    final full = make(seed: 6, tune: (p) => p.buyLookChance = 0.1);
    final half = make(seed: 6, tune: (p) => p.buyLookChance = 0.1);
    run(full, 200);
    run(half, 200);
    expect(half.mortgages.length + half.buildings.length, greaterThan(0));
    final resumed = simFromSnapshot((jsonDecode(snap(half)) as Map).cast<String, dynamic>());
    expect(snap(resumed), snap(half));
    run(full, 150);
    run(resumed, 150);
    expect(snap(resumed), snap(full));
    expect(resumed.digest(), full.digest());
  });
}
