// Onglet Entreprises : le journal tenu par l'interface (FirmLog) suit fidèlement les entreprises privées du moteur.

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:econodes/ui/entreprises_tab.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('FirmLog : vivantes = entreprises privées, naissances − morts = variation, une cause par mort', () {
    final s = Sim(
        seed: 3,
        params: Params()
          ..population = 240
          ..revival = true
          ..excessCashReturn = true
          ..excessCashDays = 20
          ..directedSearch = true
          ..spreadTakeovers = true
          ..prodEntryMargin = 0.05,
        modules: Modules()
          ..jobs = true
          ..entrepreneurship = true
          ..products = true);
    final log = FirmLog()..sample(s);
    for (var d = 1; d <= 800; d++) {
      s.step();
      log.sample(s);
      final private = s.firms.where((f) => !s.publicService(f)).length;
      final alive = log.lives.values.where((l) => l.died == null).length;
      expect(alive, private, reason: 'jour $d');
    }
    final b = log.births.fold(0, (a, x) => a + x), m = log.deaths.fold(0, (a, x) => a + x);
    expect(log.firms.last - log.firms.first, b - m);
    expect(b, greaterThan(0), reason: 'des entreprises naissent en 800 jours');
    for (final l in log.lives.values.where((l) => l.died != null)) {
      expect(l.cause, isNotNull);
    }
    final w = log.window();
    expect(w.days, FirmLog.year);
    expect(w.birthRate, greaterThanOrEqualTo(0));
    final s1 = log.survival(s.day, 1);
    if (s1 != null) expect(s1.rate, inInclusiveRange(0, 1));
    final s2 = log.survival(s.day, 2);
    if (s1 != null && s2 != null) expect(s2.rate, lessThanOrEqualTo(s1.rate), reason: 'la survie baisse avec l’âge');
    expect(log.survival(s.day, 5), isNull, reason: 'aucune entreprise née n’a 5 ans au jour 800');
    // une remise à zéro vide le journal
    s.reset();
    log.sample(s);
    expect(log.days.length, 1);
  });
}
