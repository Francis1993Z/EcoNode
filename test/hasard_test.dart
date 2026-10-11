// Hasard en flux indépendants (nombres aléatoires communs) : valeurs de référence identiques sur la VM et sur le web,
// indépendance des flux, ordre du jour stable. Ce fichier tourne aussi dans le navigateur :
//   flutter test --platform chrome test/hasard_test.dart
// (sous Windows sans Chrome, CHROME_EXECUTABLE peut désigner Edge).

import 'dart:math' as math;

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('hachage et tirages : valeurs de référence, identiques sur la VM et sur le web', () {
    // valeurs calculées sur la VM ; un écart dans le navigateur signalerait une arithmétique 32 bits non portable
    expect(hash32(0, 0), 4279838538);
    expect(hash32(42, 1), 2416545486);
    expect(hash32(1, 42), 3507548966);
    expect(hash32(0xFFFFFFFF, 0x7FFFFFFF), 4141235960);
    expect(hash32(123456789, 987654321), 890124905);
    expect(hash32(0x80000000, 0x80000001), 3897674484);
    final s = Sim(seed: 42);
    expect(s.draw(Flux.maladie, 17), 0.26128904800862074);
    expect(s.draw(Flux.maladie, 100001, 3), 0.947804483352229);
    expect(s.draw(Flux.depart, 17), 0.7659328319132328);
    expect(s.draw(Flux.depart, 100001, 3), 0.09385158400982618);
    expect(s.draw(Flux.offres, 100001, 3), 0.9999472070485353);
    expect(s.draw(Flux.traits, 17), 0.17137286579236388);
  });

  test('partie de 150 jours : même empreinte sur la VM et sur le web', () {
    final s = Sim(seed: 42);
    for (var i = 0; i < 150; i++) {
      s.step();
    }
    final h = s.history.last;
    expect(h.total, 1554280.650390625);
    expect(h.mH, 612390.296875);
    expect(h.mF, 781337.3544921875);
    expect(h.cpi, 2.5159360376256);
    expect(h.gini, 0.228082077519016);
    expect(h.wage, 210.03488148880768);
    expect(h.unemp, 0.12083333333333333);
    expect(s.firms.length, 27);
    expect(s.firms.first.id, 100001); // identifiant stable : 100 000 + 10 000 × rang du type + rang de création
  });

  test('flux indépendants : moyenne, variance et corrélations de 100 000 tirages', () {
    final s = Sim(seed: 3);
    const n = 100000;
    List<double> draws(Flux f, [int shift = 0]) => [for (var i = 1; i <= n; i++) s.draw(f, i + shift)];
    double mean(List<double> x) => x.fold(0.0, (a, b) => a + b) / x.length;
    double corr(List<double> x, List<double> y) {
      final mx = mean(x), my = mean(y);
      var sxy = 0.0, sxx = 0.0, syy = 0.0;
      for (var i = 0; i < x.length; i++) {
        sxy += (x[i] - mx) * (y[i] - my);
        sxx += (x[i] - mx) * (x[i] - mx);
        syy += (y[i] - my) * (y[i] - my);
      }
      return sxy / math.sqrt(sxx * syy);
    }

    for (final f in Flux.values) {
      final x = draws(f);
      final m = mean(x);
      final v = x.fold(0.0, (a, b) => a + (b - m) * (b - m)) / n;
      expect((m - 0.5).abs(), lessThan(0.005), reason: f.name); // écart type de la moyenne : 0,0009
      expect((v - 1 / 12).abs(), lessThan(0.002), reason: f.name);
    }
    // deux flux pour les mêmes agents, et deux agents voisins dans un même flux (écart type attendu : 0,003)
    expect(corr(draws(Flux.maladie), draws(Flux.depart)).abs(), lessThan(0.015));
    expect(corr(draws(Flux.offres), draws(Flux.prix)).abs(), lessThan(0.015));
    expect(corr(draws(Flux.maladie), draws(Flux.maladie, 1)).abs(), lessThan(0.015));
  });

  test('ordre du jour : retirer un agent ne change pas l’ordre relatif des autres', () {
    final s = Sim(seed: 9);
    int cmp(int a, int b) {
      final ka = s.orderKey(Flux.consommation, a), kb = s.orderKey(Flux.consommation, b);
      return ka != kb ? ka.compareTo(kb) : a.compareTo(b);
    }

    final ids = List<int>.generate(300, (i) => i + 1);
    final all = [...ids]..sort(cmp);
    final without = ids.where((i) => i != 137).toList()..sort(cmp);
    expect(without, all.where((i) => i != 137).toList());
  });

  test('les tirages d’un agent ne dépendent pas des autres agents', () {
    final a = Sim(seed: 5), b = Sim(seed: 5, params: Params()..population = 200);
    for (final f in Flux.values) {
      expect(b.draw(f, 17), a.draw(f, 17), reason: f.name);
    }
  });
}
