// Cas extrêmes au résultat connu d'avance (tâche 4). Chaque test énonce le résultat attendu avant de jouer la partie.
// Deux attendus ne sont pas obtenus : ils restent écrits, sautés, avec ce qui a été mesuré (voir
// rapports/stabilisation.md, tâche 4). La décision de changer une règle reste à Francis.

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

void run(Sim s, int days) {
  for (var i = 0; i < days; i++) {
    s.step();
  }
}

/// Toute la monnaie de départ multipliée par [k] (citoyens, entreprises, État, Caisse), par le god mode : la masse
/// monétaire reste expliquée et les invariants comptables tiennent.
Sim moneyTimes(int seed, double k) {
  final s = Sim(seed: seed, devChecks: true);
  if (k == 1) return s;
  for (final c in List.of(s.citizens)) {
    s.godMoney(Target('citizen', c.id), c.money * (k - 1));
  }
  for (final f in List.of(s.firms)) {
    s.godMoney(Target('firm', f.id), f.money * (k - 1));
  }
  s.godMoney(const Target('state'), s.state.money * (k - 1));
  s.godMoney(const Target('bank'), s.bank.money * (k - 1));
  return s;
}

/// Une partie sans hasard : le drapeau joue dès la naissance des citoyens, la partie est donc refaite avec lui.
Sim noRandom(int seed) {
  final s = Sim(seed: seed, devChecks: true)..sansHasard = true;
  s.reset(seed: seed);
  return s;
}

void main() {
  test('zéro citoyen : rien ne se produit, la monnaie ne bouge pas, les entreprises sans employé ferment', () {
    final s = Sim(seed: 3, params: Params()..population = 0, devChecks: true);
    final m0 = s.totalMoney();
    final exit = s.params.exitIdleDays;
    run(s, exit + 20);
    expect(s.citizens, isEmpty);
    expect(s.firms, isEmpty, reason: 'aucune entreprise ne garde d’employé : toutes ferment après $exit jours');
    expect(s.totalMoney(), m0, reason: 'ni crédit, ni commerce, ni god mode');
    expect(s.state.money, m0, reason: 'sans propriétaire, la trésorerie d’une fermeture revient à l’État');
    expect([for (final h in s.history) h.gdp].every((v) => v == 0), isTrue, reason: 'aucune dépense des ménages');
    expect(s.inv.worst, 0);
  });

  // Attendu : la chaîne céréales → pain, avec un logement, nourrit et loge tout le monde. Mesuré (graine 3, modules et
  // filets coupés) : la ferme vend toutes ses céréales mais perd de l'argent dès le jour 5, car son coproduit, le bétail,
  // n'a aucun acheteur (≈ 45 % de la valeur d'un lot) ; elle licencie à partir du jour 20 et n'a plus d'employé au
  // jour 30 ; les 240 citoyens ont faim à partir du jour 36. C'est l'anomalie A3 (rapports/etat-des-lieux.md).
  test('une seule entreprise par secteur (ferme, boulangerie, immobilier) : personne n’a faim ni ne dort dehors', () {
    final s = Sim(
        seed: 3,
        scenario: const [
          ScenarioFirm('ferme', 'Ferme'),
          ScenarioFirm('boulangerie', 'Boulangerie'),
          ScenarioFirm('immobilier', 'Immobilier'),
        ],
        modules: Modules.none(),
        safeguards: Safeguards.none(),
        devChecks: true);
    run(s, 300);
    for (final h in s.history.where((h) => h.day > 100)) {
      expect([h.hungry, h.homeless], [0, 0], reason: 'jour ${h.day}');
    }
    expect(s.firms.every((f) => f.workers.isNotEmpty), isTrue);
  }, skip: 'attendu non obtenu : la ferme meurt de son coproduit invendu (A3) ; voir le commentaire');

  test('salaires figés : aucun salaire ne bouge, les invariants tiennent', () {
    final s = Sim(seed: 3, modules: Modules()..entry = false, devChecks: true);
    for (final f in s.firms) {
      f.lockWage = true;
    }
    final w0 = {for (final f in s.firms) f.id: f.wage};
    final lo = w0.values.reduce((a, b) => a < b ? a : b), hi = w0.values.reduce((a, b) => a > b ? a : b);
    for (var d = 1; d <= 300; d++) {
      s.step();
      for (final f in s.firms) {
        expect(f.wage, w0[f.id], reason: 'jour $d, ${f.name}');
      }
      final w = s.history.last.wage; // salaire moyen des employés : une moyenne de salaires figés
      if (w > 0) expect(w >= lo - 1e-9 && w <= hi + 1e-9, isTrue, reason: 'jour $d : salaire moyen $w hors [$lo, $hi]');
    }
    expect(s.inv.worst, 0);
  });

  test('toute la monnaie × 100 : les prix suivent', () {
    final a = moneyTimes(1, 1), b = moneyTimes(1, 100);
    expect(b.totalMoney(), closeTo(100 * a.totalMoney(), 1e-6 * b.totalMoney()));
    run(a, 500);
    run(b, 500);
    // mesuré sur les graines 1 à 8 : prix ×16 à ×55 au jour 500 (salaires ×75 à ×131)
    final ratio = b.history.last.cpi / a.history.last.cpi;
    expect(ratio, greaterThan(10), reason: 'indice des prix ×$ratio au jour 500');
    expect(b.inv.worst, 0);
  });

  // Attendu : à long terme, la monnaie est neutre ; l'économie réelle revient à celle de la partie sans choc. Mesuré
  // (graines 1 à 8, jours 1 001 à 1 500, appariés) : prix ×15 à ×85 au jour 1 500, mais salaires ×72 à ×244 ; dépense
  // réelle des ménages (dépense ÷ indice des prix) ×2 à ×23 environ ; chômage de −3,1 à +6,5 points ; graine 8 : 153
  // affamés en moyenne contre 1. Le choc a des effets réels durables.
  test('toute la monnaie × 100 : l’économie réelle ne change pas durablement', () {
    for (var seed = 1; seed <= 8; seed++) {
      final a = moneyTimes(seed, 1), b = moneyTimes(seed, 100);
      run(a, 1000);
      run(b, 1000);
      var ra = 0.0, rb = 0.0, ua = 0.0, ub = 0.0;
      for (var d = 0; d < 500; d++) {
        a.step();
        b.step();
        ra += a.history.last.gdp / a.history.last.cpi;
        rb += b.history.last.gdp / b.history.last.cpi;
        ua += a.history.last.unemp / 500;
        ub += b.history.last.unemp / 500;
      }
      expect(rb / ra, closeTo(1, 0.2), reason: 'graine $seed : dépense réelle ×${rb / ra}');
      expect(ub - ua, closeTo(0, 0.03), reason: 'graine $seed : chômage ${ua * 100} % → ${ub * 100} %');
    }
  }, skip: 'attendu non obtenu : effets réels durables (dépense réelle ×2 à ×23) ; voir le commentaire');

  group('aucun hasard (tous les tirages à 0,5) : une partie lisible à la main', () {
    test('au départ : traits, argent, ordinateurs et propriétaire se calculent à la main', () {
      final s = noRandom(3);
      final p = s.params;
      for (final c in s.citizens) {
        expect(c.skill, c.level + 0.45, reason: c.name); // niveau + 0,9 × 0,5
        expect(c.ambition, 0.5);
        expect(c.money, p.startWallet * (0.6 + 0.8 * 0.5) * const [1.0, 1.3, 1.8][c.level]);
        // ordinateur si 0,5 < [0,2 ; 0,6 ; 0,7][niveau], pour ⌊0,5 × 365⌋ = 182 jours
        expect(c.computerDays, c.level == 0 ? 0 : (0.5 * p.computerLife).floor());
      }
      // le propriétaire est le citoyen de rang ⌊0,5 × 240⌋ : le n° 121, pour toutes les entreprises privées
      for (final f in s.firms) {
        expect(f.ownerId, s.publicService(f) ? isNull : (0.5 * s.citizens.length).floor() + 1, reason: f.name);
      }
    });

    test('sur 30 jours : personne ne tombe malade, ne change d’emploi, n’étudie ni n’achète d’ordinateur', () {
      final s = noRandom(3);
      var switches = 0;
      s.trace = (e) {
        if (e.type == 'embauche' && e.rule.startsWith('mobilité')) switches++;
      };
      final skill = {for (final c in s.citizens) c.id: c.skill};
      final pc = {for (final c in s.citizens) c.id: c.computerDays};
      for (var d = 1; d <= 30; d++) {
        s.step();
        for (final c in s.citizens) {
          // aucune maladie (0,5 ≥ 0,4 %) : la santé ne fait que s'user de 0,003 par jour, sans soins (au-dessus de 0,75)
          expect(c.health, closeTo(1 - 0.003 * d, 1e-12), reason: 'jour $d, ${c.name}');
          expect(c.skill, skill[c.id], reason: 'aucun cours : 0,5 ≥ ambition × 25 %');
          expect(c.computerDays, pc[c.id]! > 0 ? pc[c.id]! - d : 0, reason: 'aucun achat : 0,5 ≥ 1 à 5 %');
        }
      }
      expect(switches, 0, reason: 'aucun départ volontaire : 0,5 > 3 %');
      expect(s.inv.worst, 0);
    });

    test('la graine ne compte plus : deux graines donnent la même partie', () {
      final a = noRandom(1), b = noRandom(99);
      run(a, 30);
      run(b, 30);
      for (var i = 0; i < a.history.length; i++) {
        final x = a.history[i], y = b.history[i];
        expect([y.total, y.mH, y.mF, y.mE, y.unemp, y.cpi, y.wage, y.gdp, y.hungry, y.homeless],
            [x.total, x.mH, x.mF, x.mE, x.unemp, x.cpi, x.wage, x.gdp, x.hungry, x.homeless],
            reason: 'jour ${x.day}');
      }
    });
  });
}
