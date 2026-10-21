// Renaissance des filières (Params.revival, MODELE.md § 6.22) : coupée, aucun signal ; active, des biens sans producteur
// retrouvent un producteur frontières ouvertes ; la reprise depuis un instantané reste exacte (importations lissées).

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

import 'instantane_test.dart' show sameContinuation;

Params open({bool revival = false}) => Params()
  ..trade = true
  ..tradeWaves = true
  ..floatingFx = true
  ..foreignDemand = true
  ..revival = revival;

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
}
