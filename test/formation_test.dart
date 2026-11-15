// Formation par filières (Params.formation, MODELE.md § 6.23) : coupée, rien ne change ; active, chaque poste qualifié
// est tenu par un diplômé de la filière, les comptes restent exacts, et une partie reprise d'un instantané continue au
// bit près (diplômes, études en cours, prêts étudiants en report).

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

import 'instantane_test.dart' show sameContinuation;

/// Études raccourcies (120 et 240 jours) : des diplômes sont décernés dans une partie de test.
Params court() => Params()
  ..formation = true
  ..eduTechDays = 120
  ..eduProDays = 240;

void main() {
  test('coupée dans le moteur : aucun diplôme, aucun étudiant', () {
    final s = Sim(seed: 4);
    expect(s.params.formation, isFalse);
    for (var d = 0; d < 60; d++) {
      s.step();
    }
    expect(s.citizens.every((c) => c.degrees.isEmpty && c.studyField < 0), isTrue);
    expect(s.formationReady, isFalse);
  });

  test('départ : chaque technicien et professionnel reçoit le diplôme de la filière de son employeur', () {
    final off = Sim(seed: 6);
    final on = Sim(seed: 6, params: Params()..formation = true);
    // même économie de départ : mêmes équipes
    expect([for (final f in on.firms) f.workers], [for (final f in off.firms) f.workers]);
    on.step();
    expect(on.formationReady, isTrue);
    for (final c in on.citizens) {
      expect(c.degrees.length, fieldKeys.length);
      final top = on.topDegree(c);
      expect(top, c.level, reason: 'meilleur diplôme = classe');
      expect(c.skill, closeTo(top + c.talent, 1e-9));
    }
  });

  test('active : invariants exacts et postes qualifiés tenus par des diplômés de la filière, chaque jour', () {
    final s = Sim(seed: 9, params: court(), devChecks: true);
    var studied = false;
    for (var d = 1; d <= 500; d++) {
      s.step();
      for (final c in s.citizens) {
        if (c.studyField >= 0) studied = true;
        if (c.employer == null || c.role < 0) continue;
        final f = s.firm(c.employer!)!;
        final role = roles[f.type]![c.role];
        expect(s.skillIn(c, fieldOf(f.type)) + 1e-9, greaterThanOrEqualTo(role.minSkill),
            reason: 'jour $d : ${c.name} tient « ${role.label} » chez ${f.name} sans le diplôme voulu');
      }
    }
    expect(studied, isTrue, reason: 'personne ne s’est inscrit');
    expect(s.formationStats.graduations, greaterThan(0));
  });

  test('un étudiant à temps plein est hors du marché du travail et ne touche pas de prestations', () {
    final s = Sim(seed: 9, params: court());
    for (var d = 1; d <= 400; d++) {
      s.step();
      for (final c in s.citizens) {
        if (!s.studiesFullTime(c)) continue;
        expect(c.employer, isNull);
        expect(s.seeksJob(c), isFalse);
      }
    }
  });

  test('reprise depuis un instantané : même suite, au bit près (études en cours, prêts étudiants)', () {
    sameContinuation(() => Sim(seed: 9, params: court()), 260, 420, before: (s) {
      expect(s.citizens.any((c) => c.studyField >= 0), isTrue, reason: 'aucun étudiant au moment de l’instantané');
      s.godAddCitizens(4, 3000); // nouveaux arrivants : diplôme au matin suivant
    });
  });

  test('activation en cours de partie : les diplômes sont attribués au matin suivant', () {
    final s = Sim(seed: 2);
    for (var d = 0; d < 50; d++) {
      s.step();
    }
    s.params.formation = true;
    s.step();
    expect(s.formationReady, isTrue);
    expect(s.citizens.every((c) => c.degrees.length == fieldKeys.length), isTrue);
  });
}
