// Renaissance des filières (Params.revival, MODELE.md § 6.22) : coupée, aucun signal ; active, des biens sans producteur
// retrouvent un producteur frontières ouvertes ; la reprise depuis un instantané reste exacte (importations lissées).
// Variantes revivalFullCost (viabilité au coût complet, prix de départ face à l'import) et revivalPlannedDemand (demande
// dérivée au plan de production de l'aval).

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

import 'instantane_test.dart' show sameContinuation;

Params open({bool revival = false, bool fullCost = false, bool planned = false}) => Params()
  ..trade = true
  ..tradeWaves = true
  ..floatingFx = true
  ..foreignDemand = true
  ..revival = revival
  ..revivalFullCost = fullCost
  ..revivalPlannedDemand = planned;

/// Renaissances d'une partie : passages, d'un jour au suivant, de « aucun producteur actif » à « au moins un ».
int revivals(Sim s, int days) {
  final produced = <String>{for (final f in s.firms) ...f.outputs.keys};
  final dead = <String>{};
  var n = 0;
  for (var d = 1; d <= days; d++) {
    s.step();
    for (final g in produced) {
      if (!s.hasActiveProducer(g)) {
        dead.add(g);
      } else if (dead.remove(g)) {
        n++;
      }
    }
  }
  return n;
}

void main() {
  test('coupée : aucun signal de renaissance, aucune importation lissée', () {
    final s = Sim(seed: 2, params: open());
    for (var d = 0; d < 300; d++) {
      s.step();
    }
    expect(s.importEma, isEmpty);
    for (final g in goods.keys) {
      expect(s.revivalWant(g), 0, reason: g);
    }
  });

  test('active : un bien qui a un producteur actif n’envoie pas de signal de renaissance', () {
    final s = Sim(seed: 2, params: open(revival: true));
    for (var d = 0; d < 300; d++) {
      s.step();
    }
    expect(s.importEma, isNotEmpty);
    for (final g in goods.keys) {
      if (s.hasActiveProducer(g)) expect(s.revivalWant(g), 0, reason: g);
    }
  });

  test('frontières ouvertes : des filières éteintes renaissent avec la règle, pas sans elle', () {
    final without = revivals(Sim(seed: 1, params: open()), 600);
    final with_ = revivals(Sim(seed: 1, params: open(revival: true)), 600);
    expect(with_, greaterThan(without));
  });

  test('reprise depuis un instantané avec la règle, frontières ouvertes : même suite, au bit près', () {
    sameContinuation(() => Sim(seed: 4, params: open(revival: true)), 250, 400,
        before: (s) => expect(s.importEma, isNotEmpty));
  });

  test('coût complet coupé : aucun refus de relance de plus', () {
    final s = Sim(seed: 1, params: open(revival: true));
    for (var d = 0; d < 300; d++) {
      s.step();
    }
    for (final ty in templates.keys) {
      expect(s.revivalCostRefusal(ty, 1, 1, 100, 100, 0, 0, 0), isNull, reason: ty);
    }
  });

  test('coût complet : des relances sont refusées pour leur prix de départ face à l’import', () {
    final s = Sim(seed: 1, params: open(revival: true, fullCost: true));
    for (var d = 0; d < 600; d++) {
      s.step();
    }
    expect(s.entryFunnel['prix_import'] ?? 0, greaterThan(0));
  });

  test('demande au plan : la demande dérivée ne dépasse jamais celle comptée à la capacité des équipes', () {
    final s = Sim(seed: 3, params: open(revival: true));
    var less = 0;
    for (var d = 0; d < 400; d++) {
      s.step();
      if (d % 20 != 0) continue;
      for (final g in goods.keys) {
        s.params.revivalPlannedDemand = false;
        final crew = s.derivedWant(g);
        s.params.revivalPlannedDemand = true;
        final plan = s.derivedWant(g);
        s.params.revivalPlannedDemand = false;
        expect(plan, lessThanOrEqualTo(crew), reason: '$g, jour $d');
        if (plan < crew) less++;
      }
    }
    expect(less, greaterThan(0));
  });

  test('reprise depuis un instantané avec les deux variantes : même suite, au bit près', () {
    sameContinuation(() => Sim(seed: 4, params: open(revival: true, fullCost: true, planned: true)), 250, 400,
        before: (s) => expect(s.importEma, isNotEmpty));
  });
}
