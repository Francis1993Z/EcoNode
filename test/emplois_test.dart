// Rôles, contrats et négociation salariale (module « jobs ») : organigrammes, cohérence des contrats chaque jour,
// bornes de la négociation, rigidité à la baisse, salaire minimum, activation en cours de partie, instantanés.
// Avec le module coupé, la partie est identique au bit près à celle d'avant le module : l'empreinte de 150 jours de
// test/hasard_test.dart et celle de tool/parite.dart n'ont pas changé.

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

Sim make({int seed = 5, bool devChecks = true, void Function(Params)? tune, Safeguards? nets}) {
  final p = Params();
  tune?.call(p);
  return Sim(seed: seed, params: p, modules: Modules()..jobs = true, safeguards: nets, devChecks: devChecks);
}

/// Contrats cohérents : rôle de l'organigramme de l'employeur, qualification et ancienneté suffisantes, salaire positif
/// et au moins le minimum ; le salaire de l'entreprise est la moyenne des contrats.
void checkContracts(Sim s) {
  for (final c in s.citizens) {
    if (c.employer == null) {
      expect(c.role, -1, reason: '${c.name} sans emploi garde un rôle');
      continue;
    }
    final f = s.firm(c.employer!)!;
    final rs = roles[f.type]!;
    expect(c.role >= 0 && c.role < rs.length, isTrue, reason: '${c.name} : rôle ${c.role} hors de l’organigramme');
    final r = rs[c.role];
    expect(c.skill + 1e-9 >= r.minSkill, isTrue, reason: '${c.name} (${c.skill}) tient ${r.label} (${r.minSkill})');
    expect(s.tenure(c), greaterThanOrEqualTo(0));
    expect(s.tenure(c), greaterThanOrEqualTo(r.minTenure), reason: '${c.name} : ${r.label} sans l’ancienneté voulue');
    expect(c.wage > 0, isTrue);
    expect(c.wage + 1e-9 >= s.params.minWage, isTrue);
  }
  for (final f in s.firms) {
    if (f.workers.isEmpty) continue;
    var sum = 0.0;
    for (final id in f.workers) {
      sum += s.citizen(id)!.wage;
    }
    expect((f.wage - sum / f.workers.length).abs() <= 1e-9 * f.wage, isTrue, reason: '${f.name} : salaire moyen');
  }
}

void main() {
  test('organigrammes : chaque type a des rôles cohérents', () {
    for (final ty in templates.keys) {
      final rs = roles[ty];
      expect(rs, isNotNull, reason: 'pas d’organigramme pour $ty');
      expect(rs!, isNotEmpty);
      final t = templates[ty]!;
      // sans le module, tous les employés ont au moins la qualification du gabarit : il faut un rôle à leur portée
      expect(rs.any((r) => r.minSkill <= t.skill && !r.internal), isTrue, reason: '$ty : aucun rôle d’entrée');
      expect(rs.map((r) => r.label).toSet().length, rs.length, reason: '$ty : rôles en double');
      for (final r in rs) {
        expect(r.share > 0 && r.premium > 0 && r.minSkill >= 0 && r.minSkill <= 3, isTrue, reason: '$ty : ${r.label}');
      }
      // D'Hondt : le premier poste va au rôle de la plus forte part ; les effectifs suivent les parts
      final top = rs.indexWhere((r) => r.share == rs.map((x) => x.share).reduce((a, b) => a > b ? a : b));
      expect(seatOrder(ty, 1), [top]);
      const n = 40;
      final counts = List<int>.filled(rs.length, 0);
      for (final r in seatOrder(ty, n)) {
        counts[r]++;
      }
      final total = rs.fold<double>(0, (a, r) => a + r.share);
      for (var i = 0; i < rs.length; i++) {
        expect((counts[i] - n * rs[i].share / total).abs() <= 2, isTrue, reason: '$ty : ${rs[i].label} ${counts[i]}/$n');
      }
      expect(avgRoleRel(ty) > 0.3 && avgRoleRel(ty) < 2, isTrue, reason: '$ty : salaire moyen ${avgRoleRel(ty)}');
    }
    expect(nextSeat('hopital', [0, 0, 0, 0], {1}), 2, reason: 'rôle exclu');
  });

  test('module actif : invariants exacts et contrats cohérents chaque jour, toutes les étapes de la négociation', () {
    final s = make(seed: 5);
    checkContracts(s);
    for (var d = 1; d <= 500; d++) {
      s.step(); // devChecks : un invariant comptable rompu lève une exception
      checkContracts(s);
    }
    final l = s.labour.total;
    expect(l['embauche'], greaterThan(0));
    expect(l['promotion'], greaterThan(0));
    expect(l['revision'], greaterThan(0));
    expect(l['contre_offre']! + l['depart']!, greaterThan(0), reason: 'aucune offre d’un concurrent');
    // des salaires différents dans une même équipe
    expect(s.firms.any((f) {
      final w = [for (final id in f.workers) s.citizen(id)!.wage];
      return w.length > 1 && w.reduce((a, b) => a > b ? a : b) > w.reduce((a, b) => a < b ? a : b) + 1;
    }), isTrue);
  });

  test('négociation : salaire entre le plancher et le plafond ; refus quand le plancher dépasse le plafond', () {
    final s = make(seed: 9);
    var hires = 0, refusals = 0;
    final seen = <Talk>{};
    for (var d = 1; d <= 400; d++) {
      s.step();
      for (final f in s.firms) {
        for (final t in f.talks) {
          if (!seen.add(t) || t.day != s.day) continue;
          if (t.kind == 'embauche') {
            hires++;
            final low = t.offer * (1 - s.params.hireRange);
            final floor = t.reservation > low ? t.reservation : low;
            expect(t.wage >= floor - 1e-6 && t.wage <= t.cap + 1e-6, isTrue,
                reason: '${t.name} : ${t.wage} hors de [$floor ; ${t.cap}]');
          } else if (t.kind == 'refus') {
            refusals++;
            expect(t.reservation > t.cap, isTrue, reason: '${t.name} refuse sous son plafond');
          }
        }
      }
    }
    expect(hires, greaterThan(0));
    printOnFailure('$hires embauches, $refusals refus vérifiés');
    expect(s.bargain(90, 80, 130, 0.5), 110);
    expect(s.bargain(100, 130, 120, 0.5), isNull);
  });

  /// Joue [days] jours et vérifie qu'un contrat ne baisse qu'à son renouvellement (anniversaire de l'embauche), jusqu'à
  /// l'offre du rôle ancienneté comprise et d'au plus reviewCutMax. Rend le nombre de baisses observées.
  int checkCuts(Sim s, int days) {
    final before = <int, (int, double)>{};
    var cuts = 0;
    for (var d = 1; d <= days; d++) {
      s.step();
      for (final c in s.citizens) {
        final prev = before[c.id];
        if (c.employer != null && prev != null && prev.$1 == c.employer && c.wage < prev.$2 - 1e-9) {
          cuts++;
          final f = s.firm(c.employer!)!;
          expect(s.tenure(c) % s.params.reviewDays, 0, reason: '${c.name} : baisse hors renouvellement au jour ${s.day}');
          final t = f.talks.lastWhere((t) => t.citizen == c.id && t.day == s.day && t.kind == 'baisse');
          expect(t.wage, c.wage);
          expect(c.wage >= t.cap - 1e-9, isTrue, reason: '${c.name} : sous l’offre du rôle');
          expect(c.wage >= prev.$2 * (1 - s.params.reviewCutMax) - 1e-9, isTrue);
        }
        before[c.id] = c.employer == null ? (-1, 0.0) : (c.employer!, c.wage);
      }
    }
    return cuts;
  }

  test('contrats échelonnés : un salaire ne baisse qu’à son renouvellement, jusqu’à l’offre du rôle', () {
    final cuts = checkCuts(make(seed: 3), 500);
    expect(cuts, greaterThan(0), reason: 'aucun renouvellement à la baisse en 500 jours');
  });

  test('rigidité à la baisse (reviewCutMax = 0) : aucun contrat ne baisse', () {
    expect(checkCuts(make(seed: 3, tune: (p) => p.reviewCutMax = 0), 400), 0);
  });

  test('salaire minimum : une loi qui relève tous les contrats dessous', () {
    final s = make(seed: 4);
    for (var d = 1; d <= 60; d++) {
      s.step();
    }
    var top = 0.0;
    for (final c in s.citizens) {
      if (c.employer != null && c.wage > top) top = c.wage;
    }
    s.params.minWage = (top * 0.8).roundToDouble();
    s.step();
    checkContracts(s);
    for (final c in s.citizens) {
      if (c.employer != null) expect(c.wage + 1e-9 >= s.params.minWage, isTrue);
    }
  });

  test('activation puis coupure en cours de partie : chacun garde son salaire, les comptes restent exacts', () {
    final s = Sim(seed: 8, devChecks: true);
    for (var d = 1; d <= 80; d++) {
      s.step();
    }
    final wage = {for (final f in s.firms) f.id: f.wage};
    s.modules.jobs = true;
    // l'activation a lieu au début du jour suivant, avant le marché du travail : on la reproduit pour l'observer
    s.step();
    expect(s.jobsActive, isTrue);
    checkContracts(s);
    // ceux qui n'ont pas bougé gardent le salaire unique de la veille (sauf renouvellement, contre-offre ou promotion)
    var kept = 0;
    for (final f in s.firms) {
      for (final id in f.workers) {
        if (s.citizen(id)!.wage == wage[f.id]) kept++;
      }
    }
    expect(kept, greaterThan(0));
    for (var d = 1; d <= 80; d++) {
      s.step();
      checkContracts(s);
    }
    s.modules.jobs = false;
    for (var d = 1; d <= 40; d++) {
      s.step();
    }
    expect(s.jobsActive, isFalse);
    expect(s.citizens.every((c) => c.role == -1), isTrue);
  });

  test('instantané : reprise exacte avec le module actif', () {
    String snap(Sim s) => jsonEncode(s.toSnapshot());
    final full = make(seed: 6);
    final half = make(seed: 6);
    for (var d = 1; d <= 150; d++) {
      full.step();
      half.step();
    }
    final resumed = simFromSnapshot((jsonDecode(snap(half)) as Map).cast<String, dynamic>());
    expect(snap(resumed), snap(half));
    for (var d = 1; d <= 120; d++) {
      full.step();
      resumed.step();
    }
    expect(snap(resumed), snap(full));
    expect(resumed.digest(), full.digest());
  });

  test('sans filets : le module tient ses invariants et ses contrats', () {
    final s = make(seed: 2, nets: Safeguards.none());
    for (var d = 1; d <= 400; d++) {
      s.step();
    }
    checkContracts(s);
  });
}
