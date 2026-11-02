// Types de bâtiments (Params.buildingTypes) : maisons, duplex et immeubles. Parc de départ, logements des immeubles dans
// la capacité des bailleurs, achats réservés aux maisons, rachat d'un immeuble saisi par un bailleur, chantier d'un
// immeuble, rattachement des locataires à un logement, conservation comptable au bit près, instantanés.

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

void run(Sim s, int days) {
  for (var i = 0; i < days; i++) {
    s.step();
  }
}

Sim make({int seed = 3, void Function(Params)? tune}) {
  final p = Params()
    ..buildingTypes = true
    ..leases = true
    ..ownersAtStart = true;
  tune?.call(p);
  return Sim(seed: seed, params: p, modules: Modules()..buildings = true, devChecks: true);
}

/// Les liens entre bâtiments, propriétaires, locataires et hypothèques sont cohérents ; les ménages n'ont que des maisons.
void checkTypes(Sim s) {
  final perBuilding = <int, int>{};
  for (final b in s.buildings) {
    if (b.type != null) {
      expect(b.modules <= s.modulesOf(b), isTrue, reason: 'trop de modules posés sur le bâtiment ${b.id}');
      if (b.done) expect(b.modules, s.modulesOf(b));
    }
    if (b.ownerKind == 1) {
      expect(b.units, 1, reason: 'un ménage possède un immeuble (${b.id})');
      expect(s.citizen(b.ownerId!)!.homeId, b.id);
    }
    final m = s.mortgageOf(b);
    if (m != null) expect(m.borrowerKind == 2, b.ownerKind == 2);
  }
  for (final c in s.citizens) {
    final b = s.dwellingOf(c);
    if (b == null) continue;
    expect(b.ownerKind, 0);
    expect(b.ownerId, c.leaseFirm);
    expect(c.homeId, isNull);
    perBuilding[b.id] = (perBuilding[b.id] ?? 0) + 1;
  }
  for (final e in perBuilding.entries) {
    expect(e.value <= s.building(e.key)!.units, isTrue, reason: 'plus de locataires que de logements (${e.key})');
  }
  var firmDebt = 0.0;
  for (final f in s.firms) {
    firmDebt += f.debt;
  }
  expect(s.totalLoans(), firmDebt + s.mortgageDebt());
  expect(s.inv.worst, 0);
}

void main() {
  test('coupés par défaut : chaque bâtiment est un logement standard', () {
    expect(Params().buildingTypes, isFalse);
    final s = Sim(seed: 3, modules: Modules()..buildings = true, devChecks: true);
    run(s, 30);
    expect(s.buildings, isNotEmpty);
    expect(s.buildings.every((b) => b.type == null && b.units == 1), isTrue);
    expect(s.citizens.every((c) => c.dwellingId == null), isTrue);
    expect(s.dwellings, s.buildings.where((b) => b.habitable).length);
  });

  test('parc de départ : capacités des bailleurs en logements, maisons pour les propriétaires, immeubles pour le reste', () {
    final s = make();
    final landlords = s.firms.where((f) => f.type == 'immobilier').toList();
    final capacity = landlords.fold(0.0, (a, f) => a + f.capacity!).round();
    expect(s.dwellings, capacity); // tous les logements de départ, propriétaires compris
    final owners = s.citizens.where((c) => c.homeId != null).length;
    expect(owners, s.citizens.where((c) => c.wantsToOwn && c.employer != null).length);
    final houses = s.buildings.where((b) => b.units == 1).length;
    expect(houses, greaterThanOrEqualTo(owners));
    expect(s.buildings.any((b) => b.units > 1), isTrue);
    expect(s.buildings.every((b) => b.type != null && b.done && b.modules == s.modulesOf(b)), isTrue);
    // un immeuble vaut plus qu'une maison, et sa valeur suit sa taille
    final big = s.buildings.firstWhere((b) => b.units > 1);
    final ratio = s.fairValue(big) / (0.25 + 0.75 * big.cond) / s.replacementCost();
    expect(ratio, closeTo(s.sizeOf(big), 1e-9));
    checkTypes(s);
    run(s, 2);
    // la capacité d'un bailleur compte les logements de ses bâtiments habitables
    for (final f in landlords) {
      var n = 0;
      for (final b in s.buildings) {
        if (b.ownerKind == 0 && b.ownerId == f.id && b.habitable) n += b.units;
      }
      expect(f.capacity, n.toDouble());
    }
  });

  test('un ménage n’achète pas un immeuble ; un bailleur rachète un immeuble saisi', () {
    final s = make(tune: (p) {
      p.buyLookChance = 0;
      p.population = 1000; // plusieurs bailleurs
    });
    run(s, 10);
    final landlords = s.firms.where((f) => f.type == 'immobilier').toList();
    expect(landlords.length, greaterThan(1));
    final f1 = landlords.firstWhere((f) => s.buildings.any((b) => b.ownerKind == 0 && b.ownerId == f.id && b.units > 1));
    final f2 = landlords.firstWhere((f) => !identical(f, f1));
    final big = s.buildings.firstWhere((b) => b.ownerKind == 0 && b.ownerId == f1.id && b.units > 1);
    s.removeFirm(f1.id);
    expect(big.ownerKind, 2);
    expect(big.listedDay, isNotNull);
    final c = s.citizens.firstWhere((x) => x.homeId == null && x.employer != null);
    s.godMoney(Target('citizen', c.id), 1e6 - c.money);
    expect(s.buyHome(c, big), isFalse);
    // le bailleur f2 manque de logements et a de quoi payer
    s.godMoney(Target('firm', f2.id), 5e6);
    f2.demandEma['logement'] = 1e5;
    f2.revenueEma = 1e7;
    s.step();
    expect(big.ownerKind, 0);
    expect(big.ownerId, f2.id);
    expect(big.listedDay, isNull);
    expect(s.bstats.bought, greaterThan(0));
    final m = s.mortgageOf(big);
    if (m != null) expect(m.borrowerKind == 0 && m.borrowerId == f2.id, isTrue);
    checkTypes(s);
    run(s, 30);
    checkTypes(s);
  });

  test('chantier d’un immeuble de trois étages : 90 modules, 3 par jour, 12 logements de plus pour le bailleur', () {
    final s = make(tune: (p) => p.buyLookChance = 0);
    run(s, 5);
    final f = s.firms.firstWhere((x) => x.type == 'immobilier');
    s.godMoney(Target('firm', f.id), 2e6);
    final b = s.newSite(f, 6);
    expect(buildingKinds[6].units, 12);
    expect(s.modulesOf(b), 90);
    var days = 0;
    var before = 0;
    while (!b.done && days < 300) {
      before = b.modules;
      s.step();
      expect(b.modules - before, lessThanOrEqualTo(buildingKinds[6].crew));
      expect(b.modules, lessThanOrEqualTo(90));
      days++;
    }
    expect(b.done, isTrue, reason: 'chantier inachevé après $days jours (${b.modules} modules)');
    expect(days, greaterThanOrEqualTo(30));
    s.step();
    var n = 0;
    for (final x in s.buildings) {
      if (x.ownerKind == 0 && x.ownerId == f.id && x.habitable) n += x.units;
    }
    expect(f.capacity, n.toDouble());
    checkTypes(s);
  });

  test('conservation et locataires rattachés : 400 jours sur 2 graines', () {
    for (final seed in [4, 9]) {
      final s = make(seed: seed);
      for (var d = 0; d < 400; d++) {
        s.step();
        if (d % 50 == 49) checkTypes(s);
      }
      final leases = s.citizens.where((c) => c.leaseFirm != null).length;
      final placed = s.citizens.where((c) => s.dwellingOf(c) != null).length;
      expect(leases, greaterThan(0));
      expect(placed, greaterThanOrEqualTo((0.9 * leases).floor()), reason: 'graine $seed : $placed rattachés sur $leases baux');
    }
  });

  test('instantané : reprise exacte avec types de bâtiments et locataires rattachés', () {
    String snap(Sim s) => jsonEncode(s.toSnapshot());
    final full = make(seed: 6, tune: (p) => p.buyLookChance = 0.1);
    final half = make(seed: 6, tune: (p) => p.buyLookChance = 0.1);
    run(full, 200);
    run(half, 200);
    expect(half.citizens.any((c) => c.dwellingId != null), isTrue);
    final resumed = simFromSnapshot((jsonDecode(snap(half)) as Map).cast<String, dynamic>());
    expect(snap(resumed), snap(half));
    expect(resumed.params.buildingTypes, isTrue);
    run(full, 150);
    run(resumed, 150);
    expect(snap(resumed), snap(full));
    expect(resumed.digest(), full.digest());
  });
}
