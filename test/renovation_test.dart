// Rénovation et métiers du bâtiment (Modules.renovation) : biens et entreprises en jeu, entrepreneur général à la place
// de la Construction, entretien par les métiers, rénovation d'un bâtiment usé, occupant d'une ruine qui loue ailleurs puis
// rentre chez lui, prêt de rénovation, conservation comptable au bit près (devChecks), instantanés.

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

import 'instantane_test.dart' show sameContinuation;

void run(Sim s, int days) {
  for (var i = 0; i < days; i++) {
    s.step();
  }
}

/// Une partie avec bâtiments, baux et propriétaires de départ. 1 000 citoyens : à 240, les neuf entreprises du module se
/// partagent environ un employé de travail et la chaîne s'éteint vite (rapports/renovation.md).
Sim make({int seed = 3, bool renovation = true, int population = 1000}) {
  final p = Params.historique()
    ..population = population
    ..leases = true
    ..ownersAtStart = true;
  return Sim(
      seed: seed,
      params: p,
      modules: Modules.historique()
        ..buildings = true
        ..renovation = renovation,
      devChecks: true);
}

void main() {
  test('coupé : ni biens ni entreprises du module, la Construction reste', () {
    final s = make(renovation: false, population: 240);
    expect(s.renovationActive, isFalse);
    expect(s.goodKeys.where(renovationGoods.contains), isEmpty);
    expect(s.typeKeys.where(renovationTypes.contains), isEmpty);
    expect(s.firms.where((f) => renovationTypes.contains(f.type)), isEmpty);
    expect(s.firms.any((f) => f.type == 'construction'), isTrue);
    run(s, 20);
    expect(s.history.last.prices.keys.where(renovationGoods.contains), isEmpty);
    expect(s.worldPrice.keys.where(renovationGoods.contains), isEmpty);
    expect(s.marketStats.keys.where(renovationGoods.contains), isEmpty);
  });

  test('sans bâtiments, le module ne joue pas', () {
    final s = Sim(seed: 1, modules: Modules.historique()..renovation = true, params: Params.historique());
    expect(s.renovationActive, isFalse);
    expect(s.goodKeys.where(renovationGoods.contains), isEmpty);
  });

  test('actif : les neuf entreprises au départ, sans la Construction ; comptes justes au bit près sur 150 jours', () {
    final s = make();
    expect(s.renovationActive, isTrue);
    final types = {for (final f in s.firms) f.type};
    expect(types.containsAll(renovationTypes), isTrue, reason: '$types');
    expect(types.contains('construction'), isFalse);
    expect(s.typeKeys.contains('construction'), isFalse);
    // parc de départ entre le seuil de rénovation et l'état neuf
    for (final b in s.buildings) {
      expect(b.cond >= s.params.renoTrigger - 1e-12 && b.cond <= 1, isTrue, reason: 'bâtiment ${b.id} : ${b.cond}');
    }
    run(s, 150); // devChecks : les invariants comptables sont vérifiés chaque jour
  });

  test('l’entretien courant s’achète aux métiers, pas aux garages', () {
    final s = make();
    run(s, 20);
    var hours = 0.0;
    for (final g in buildingCareShares.keys) {
      hours += s.marketStats[g]?.qty ?? 0;
    }
    expect(hours, greaterThan(0));
  });

  test('un bâtiment de bailleur sous le seuil est remis à neuf avec des modules de l’entrepreneur général', () {
    final s = make();
    run(s, 5);
    final b = s.buildings.firstWhere((b) => b.done && b.ownerKind == 0);
    s.godMoney(Target('firm', b.ownerId), 300000);
    b.cond = 0.45;
    final before = s.bstats.renovated;
    s.step();
    expect(b.renoLeft > 0 || b.cond == 1, isTrue, reason: 'la rénovation n’a pas commencé');
    for (var d = 0; d < 300 && b.renoLeft > 0; d++) {
      s.step();
    }
    expect(b.renoLeft, 0);
    expect(b.cond, greaterThan(0.99));
    expect(s.bstats.renovated, greaterThan(before));
    expect(s.bstats.renoSpent, greaterThan(0));
  });

  test('un occupant dont la maison devient inhabitable loue ailleurs, puis rentre chez lui', () {
    final s = make();
    run(s, 3);
    final c = s.citizens.firstWhere((c) => c.homeId != null && c.employer != null);
    final b = s.building(c.homeId!)!;
    s.godMoney(Target('citizen', c.id), 50000); // de quoi payer un loyer et la rénovation
    // une ruine : la rénovation passe avant le logement dans la journée, et un module (1 / (0,6 × 10) d'état) ne suffit
    // pas à la rendre habitable
    b.cond = 0;
    expect(s.livesAtHome(c), isFalse);
    s.step();
    expect(s.livesAtHome(c), isFalse);
    expect(c.homeless, isFalse, reason: 'il aurait dû louer ailleurs');
    expect(c.leaseFirm, isNotNull);
    for (var d = 0; d < 400 && !(s.livesAtHome(c) && c.leaseFirm == null); d++) {
      s.step();
    }
    expect(s.livesAtHome(c), isTrue);
    expect(c.leaseFirm, isNull, reason: 'rentré chez lui, il n’a plus de bail');
    expect(c.homeId, b.id);
  });

  test('un occupant sans épargne emprunte sur sa maison pour la rénover', () {
    final s = make();
    run(s, 3);
    final c = s.citizens.firstWhere((c) => c.homeId != null && c.employer != null && s.mortgageOf(s.building(c.homeId!)!) == null);
    final b = s.building(c.homeId!)!;
    b.cond = 0.5;
    // chaque jour, il ne garde que son coussin : un module posé ne peut être payé que par un prêt (on n'emprunte que les
    // jours où l'entrepreneur général a des modules en stock)
    var placed = false;
    for (var d = 0; d < 200 && !placed; d++) {
      final extra = c.money - 10 * s.needCost;
      if (extra > 0) s.godMoney(Target('citizen', c.id), -extra);
      final before = b.renoLeft;
      s.step();
      placed = b.renoLeft > 0 && before > 0 ? b.renoLeft < before : b.cond > 0.5 && before > 0;
    }
    expect(placed, isTrue, reason: 'aucun module posé en 200 jours');
    final m = s.mortgageOf(b);
    expect(m, isNotNull, reason: 'pas de prêt de rénovation');
    expect(m!.principal, greaterThan(0));
    expect(m.borrowerKind, 1);
  });

  test('reprise depuis un instantané pendant une rénovation : même suite, au bit près', () {
    sameContinuation(() => make(), 40, 90, before: (s) {
      final landlord = s.buildings.firstWhere((b) => b.done && b.ownerKind == 0);
      landlord.cond = 0.4;
      landlord.renoLeft = 3;
      final home = s.buildings.firstWhere((b) => b.done && b.ownerKind == 1);
      home.cond = 0.25;
    });
  });
}
