// Protocole statistique (tool/stabilite.dart) : quantiles, bootstrap, appariement par graine, et une partie lancée
// dans un isolat identique à la même partie lancée directement.

import 'dart:convert';
import 'dart:isolate';

import 'package:econodes/engine/model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tool/stabilite.dart';

void main() {
  test('quantiles de type 7 (ceux de R et de NumPy)', () {
    expect(quantile([1, 2, 3, 4], 0.25), 1.75);
    expect(quantile([1, 2, 3, 4], 0.5), 2.5);
    expect(quantile([1, 2, 3, 4], 0.75), 3.25);
    final d = Dist([5, 1, 4, 2, 3]);
    expect([d.min, d.q1, d.median, d.q3, d.max], [1, 2, 3, 4, 5]);
    // un choc non résorbé compte comme une durée infinie
    expect(quantile([1, 2, double.infinity, double.infinity], 0.5), double.infinity);
    expect(quantile([1, 2, double.infinity, double.infinity], 0.25), 1.75);
  });

  test('bootstrap de la médiane : reproductible, et l’intervalle exclut 0 pour un effet net', () {
    final shifted = [for (var i = 1; i <= 30; i++) 10.0 + i];
    final (lo, hi) = bootstrapMedian(shifted);
    expect(bootstrapMedian(shifted), (lo, hi));
    expect(lo, greaterThan(10));
    expect(hi, lessThan(41));
    expect(lo, lessThanOrEqualTo(Dist(shifted).median));
    expect(hi, greaterThanOrEqualTo(Dist(shifted).median));
    final centred = [for (var i = -15; i <= 15; i++) i.toDouble()];
    final (lo0, hi0) = bootstrapMedian(centred);
    expect(lo0 < 0 && hi0 > 0, isTrue);
  });

  test('comparaison appariée : les graines sont appariées par numéro, pas par rang', () {
    final ind = Ind('unempMean', 'Chômage moyen', 'pc', -1, 'régime', band: '≤ 10 %', inBand: (v) => v <= 0.10);
    final a = [
      {'seed': 1, 'unempMean': 0.10},
      {'seed': 2, 'unempMean': 0.20},
      {'seed': 3, 'unempMean': 0.30},
    ];
    final b = [
      {'seed': 3, 'unempMean': 0.25},
      {'seed': 1, 'unempMean': 0.05},
      {'seed': 2, 'unempMean': 0.15},
      {'seed': 4, 'unempMean': 0.99}, // sans partenaire : ignorée
    ];
    final p = pairUp(ind, a, b)!;
    expect(p.n, 3);
    expect(p.medD, closeTo(-0.05, 1e-12));
    expect(p.better, 3);
    expect(p.worse, 0);
    expect(p.conclusive, isTrue);
    expect(p.outA, 2);
    expect(p.outB, 2);
  });

  test('une partie lancée dans un isolat est identique à la même partie lancée directement', () async {
    final c = Config('ref', Modules(), {});
    final direct = runBase(3, c, 80, 20, true, const {});
    final isolated = await Isolate.run(baseJob(3, c, 80, 20, true, const {}));
    expect(jsonEncode(isolated), jsonEncode(direct));
    expect(direct['steady'], 60);
  });
}
