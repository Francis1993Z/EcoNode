// Réglages par défaut depuis le 14 novembre 2026 : tous les modules et le commerce extérieur actifs, dans le moteur comme
// dans l'interface ; Modules.historique et Params.historique rendent les anciens (batterie de parité, référence).

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:econodes/ui/controller.dart';
import 'package:flutter_test/flutter_test.dart';

const anciensCoupes = ['buildings', 'jobs', 'entrepreneurship', 'products', 'banking', 'renovation'];

void main() {
  test('tous les modules et le commerce extérieur sont actifs par défaut ; historique() rend les anciens défauts', () {
    final m = Modules(), h = Modules.historique();
    for (final k in Modules.keys) {
      expect(m.get(k), isTrue, reason: k);
      expect(h.get(k), !anciensCoupes.contains(k), reason: k);
    }
    expect(Params().trade, isTrue);
    expect(Params.historique().trade, isFalse);
    final ctrl = SimController(seed: 1);
    for (final k in Modules.keys) {
      expect(ctrl.sim.modules.get(k), isTrue, reason: 'interface : $k');
    }
    expect(ctrl.sim.params.trade, isTrue);
    expect(ctrl.startParams.trade, isTrue);
  });

  test('partie aux nouveaux défauts : 300 jours sans écart comptable, rénovation et commerce en jeu', () {
    final s = Sim(seed: 1, devChecks: true); // lève une exception au premier écart
    expect(s.renovationActive, isTrue);
    for (var d = 0; d < 300; d++) {
      s.step();
    }
    expect(s.buildings, isNotEmpty);
    expect(s.firms.any((f) => f.type == 'entrepreneur'), isTrue);
    expect(s.firms.any((f) => f.type == 'construction'), isFalse);
    expect(s.ledgerImports + s.ledgerExports, greaterThan(0));
  });

  test('corrections du commerce extérieur : pas de repas importé, prix mondiaux qui bougent, comptes justes', () {
    final p = Params()
      ..worldPriceDrift = true
      ..localMeals = true
      ..homePreference = true
      ..tradeWaves = true
      ..floatingFx = true
      ..foreignDemand = true;
    final s = Sim(seed: 3, params: p, devChecks: true); // lève une exception au premier écart
    expect(s.tradable('repas'), isFalse);
    expect(s.tradable('pain'), isTrue);
    expect(s.importBias, closeTo(1.2, 1e-12));
    var repas = 0.0;
    for (var d = 0; d < 300; d++) {
      s.step();
      for (final e in s.flows.values) {
        if ((e.from == 'X' || e.to == 'X') && e.good == 'repas') repas += e.qty;
      }
    }
    expect(repas, 0);
    expect(s.worldDrift, isNotEmpty);
    expect(s.worldDrift.values.any((v) => (v - 1).abs() > 0.01), isTrue);
    // l'état des corrections passe par l'instantané
    final r = simFromSnapshot((jsonDecode(jsonEncode(s.toSnapshot())) as Map).cast<String, dynamic>());
    expect(r.worldDrift, s.worldDrift);
    expect(r.params.homePreference && r.params.localMeals && r.params.worldPriceDrift, isTrue);
  });

  test('un instantané des anciens défauts se relit avec ses modules récents coupés', () {
    final s = Sim(seed: 2, params: Params.historique(), modules: Modules.historique());
    for (var d = 0; d < 20; d++) {
      s.step();
    }
    final j = (jsonDecode(jsonEncode(s.toSnapshot())) as Map).cast<String, dynamic>();
    for (final k in Modules.lateKeys) {
      expect((j['modules'] as Map).containsKey(k), isFalse, reason: k); // coupé : absent de l'instantané
    }
    final r = simFromSnapshot(j);
    for (final k in anciensCoupes) {
      expect(r.modules.get(k), isFalse, reason: k);
    }
    expect(r.params.trade, isFalse);
  });
}
