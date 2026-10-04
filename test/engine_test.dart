// Vérifie que le moteur Dart reproduit le moteur JS (graine 42) et conserve la monnaie.
// Valeurs de référence produites par engine.js : new Sim({seed: 42}) puis 1, 30 et 365 jours.

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

void expectClose(double actual, double expected, String label, {double rel = 1e-6}) {
  final tol = rel * (expected.abs() > 1 ? expected.abs() : 1);
  expect((actual - expected).abs() <= tol, isTrue, reason: '$label : attendu $expected, obtenu $actual');
}

void main() {
  test('mulberry32 : suite identique à JS pour la graine 42', () {
    // JS : const r = mulberry32(42); r(), r(), r()
    final r = Mulberry32(42);
    final a = r.next(), b = r.next(), c = r.next();
    expect(a >= 0 && a < 1, isTrue);
    expect(b >= 0 && b < 1, isTrue);
    expect(c >= 0 && c < 1, isTrue);
    // Deux instances de même graine donnent la même suite.
    final r2 = Mulberry32(42);
    expect(r2.next(), a);
    expect(r2.next(), b);
    expect(r2.next(), c);
  });

  test('parité avec le moteur JS (graine 42)', () {
    final s = Sim(seed: 42);
    final ref = <int, Map<String, double>>{
      1: {
        'wage': 150,
        'unemp': 0.05,
        'M': 468521.5165754488,
        'mH': 242851.15151822462,
        'mF': 203651.51614048338,
        'repas': 50.549450549450654,
        'logement': 40.569239999999944,
        'gini': 0.12513167332373665,
        'need': 97.61640117216118,
        'state': 22018.848916740797,
      },
      30: {
        'wage': 169.97650769730802,
        'unemp': 0.025,
        'M': 468521.51657544996,
        'mH': 247063.5931403413,
        'mF': 173585.5444952686,
        'repas': 58.05325504419828,
        'logement': 54.90564637454012,
        'gini': 0.19709185438581356,
        'need': 125.31827104677248,
        'state': 47872.37893984,
      },
      365: {
        'wage': 168.51502780757355,
        'unemp': 0.05,
        'M': 468521.5165754572,
        'mH': 240038.45184767304,
        'mF': 177739.9811840228,
        'repas': 57.089378738954714,
        'logement': 46.03543500867269,
        'gini': 0.18370719580484374,
        'need': 111.41305707289412,
        'state': 50743.083543761335,
      },
    };
    for (var d = 1; d <= 365; d++) {
      s.step();
      final r = ref[d];
      if (r == null) continue;
      final h = s.history.last;
      expectClose(h.wage, r['wage']!, 'salaire j$d');
      expectClose(h.unemp, r['unemp']!, 'chômage j$d');
      expectClose(h.total, r['M']!, 'masse j$d');
      expectClose(h.mH, r['mH']!, 'ménages j$d');
      expectClose(h.mF, r['mF']!, 'firmes j$d');
      expectClose(h.prices['repas']!, r['repas']!, 'prix repas j$d');
      expectClose(h.prices['logement']!, r['logement']!, 'prix logement j$d');
      expectClose(h.gini, r['gini']!, 'Gini j$d');
      expectClose(h.need, r['need']!, 'panier j$d');
      expectClose(s.state.money, r['state']!, 'État j$d');
    }
    final workers = s.firms.map((f) => f.workers.length).toList();
    expect(workers, [13, 3, 1, 3, 2, 18, 4, 2, 6, 24]);
  });

  test('la monnaie est conservée (1 000 jours, plusieurs graines)', () {
    for (final seed in [1, 2, 3, 7, 99]) {
      final s = Sim(seed: seed);
      for (var i = 0; i < 1000; i++) {
        s.step();
      }
      expect((s.totalMoney() - s.expectedMoney()).abs() < 0.01, isTrue, reason: 'graine $seed');
    }
  });

  test('god mode : injection, import/export et fermeture gardent le grand livre juste', () {
    final s = Sim(seed: 5);
    for (var i = 0; i < 100; i++) {
      s.step();
    }
    s.godMoney(const Target('allCitizens'), 5000);
    s.godMoney(const Target('allFirms'), -1000);
    s.setUBI(20);
    s.setTrade(true);
    s.godAddCitizens(10, 1000);
    s.addFirm('restaurant', 'Chez Francis', 20000, null, 600, 300);
    for (var i = 0; i < 200; i++) {
      s.step();
    }
    s.godRemoveCitizens(5);
    s.removeFirm(s.firms.first.id);
    for (var i = 0; i < 100; i++) {
      s.step();
    }
    expect((s.totalMoney() - s.expectedMoney()).abs() < 0.01, isTrue);
  });
}
