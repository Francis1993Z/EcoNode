// Formation et mobilité entre filières, lecture seule : à quel point est-il facile de se former et de changer de métier ?
//
//   dart run tool/formation.dart graine population jours [--param nom=valeur,...] [--sortie fichier]
//
// Mêmes réglages que l'interface (tool/emergence.dart:parametresInterface), tous les modules actifs. Sortie : une ligne
// « FORM {json} » (sur la sortie standard, ou dans le fichier) :
//   - annees : par année de partie (365 jours) : chômage moyen, indice des prix moyen, cours suivis (hausses de
//     qualification), changements de classe (0→1, 1→2), changements d'employeur, changements de filière (le nouvel
//     employeur est d'une autre filière que le précédent), postes vacants moyens par filière, chômeurs moyens par
//     filière du dernier emploi, part des employés hors de la filière de leur premier emploi (par classe) ;
//   - etudes : pour chaque changement de classe, [classe atteinte, jours depuis la dernière montée ou l'arrivée] ;
//   - moyennes : synthèse (taux annuels par habitant, durée moyenne d'une montée de classe, part hors filière).
// Filière de formation (avant le module « formation ») = filière du premier employeur du citoyen.

import 'dart:convert';
import 'dart:io';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final p = parametresInterface(pop);
  String? fichier;
  for (var i = 3; i < a.length; i++) {
    switch (a[i]) {
      case '--sortie':
        fichier = a[++i];
      case '--param':
        for (final kv in a[++i].split(',')) {
          final j = kv.indexOf('=');
          regler(p, kv.substring(0, j), kv.substring(j + 1));
        }
    }
  }
  for (final t in templates.keys) {
    if (!typeField.containsKey(t)) throw StateError('type sans filière : $t');
  }
  final s = Sim(seed: seed, params: p, modules: Modules(), safeguards: Safeguards());
  final nf = fieldKeys.length;

  // état par citoyen
  final premier = <int, int>{}; // filière du premier emploi
  final dernier = <int, int>{}; // filière du dernier employeur
  final skillPrec = <int, double>{};
  final classePrec = <int, int>{};
  final depuisMontee = <int, int>{}; // jour de la dernière montée de classe (ou d'arrivée)
  final employeurPrec = <int, int?>{};
  final etudes = <List<num>>[];

  int? champ(Citizen c) {
    final e = c.employer;
    if (e == null) return null;
    final f = s.firm(e);
    return f == null ? null : fieldOf(f.type);
  }

  void voir(Citizen c, int jour) {
    skillPrec[c.id] = c.skill;
    classePrec[c.id] = c.level;
    depuisMontee[c.id] = jour;
    employeurPrec[c.id] = c.employer;
    final fl = champ(c);
    if (fl != null) {
      premier[c.id] = fl;
      dernier[c.id] = fl;
    }
  }

  for (final c in s.citizens) {
    voir(c, 0);
  }

  final annees = <Map<String, Object>>[];
  var an = <String, double>{};
  var vac = List<double>.filled(nf, 0), chom = List<double>.filled(nf, 0);
  var hors = List<double>.filled(3, 0), tot = List<double>.filled(3, 0);
  void add(String k, double v) => an[k] = (an[k] ?? 0) + v;
  final chrono = Stopwatch()..start();
  var totalHors = 0.0, totalEmp = 0.0;
  // module formation : compteurs du moteur au début de l'année, entreprises vivantes (morts par cause)
  final st = s.formationStats;
  var st0 = [0.0, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0.0];
  List<num> lire() => [st.studyDays, st.graduations, st.reconversions, st.enrolFull, st.enrolNight, st.loans,
        st.tuitionStudents, st.tuitionState, st.stalledDays.toDouble()];
  final vivantes = <int, Firm>{for (final f in s.firms) f.id: f};
  for (var d = 1; d <= days; d++) {
    if ((d - 1) % 365 == 0) {
      st0 = lire();
      an = {};
      vac = List<double>.filled(nf, 0);
      chom = List<double>.filled(nf, 0);
      hors = List<double>.filled(3, 0);
      tot = List<double>.filled(3, 0);
    }
    s.step();
    for (final c in s.citizens) {
      if (!skillPrec.containsKey(c.id)) {
        voir(c, d);
        add('arrivees', 1);
        continue;
      }
      if (c.skill > skillPrec[c.id]! + 1e-12) add('cours', ((c.skill - skillPrec[c.id]!) / p.learnRate).round().toDouble());
      skillPrec[c.id] = c.skill;
      if (c.level > classePrec[c.id]!) {
        etudes.add([c.level, d - depuisMontee[c.id]!]);
        depuisMontee[c.id] = d;
        add('montees', 1);
        add('montees_${c.level}', 1);
      }
      classePrec[c.id] = c.level;
      if (c.employer != employeurPrec[c.id]) {
        if (c.employer != null) {
          add('embauches', 1);
          final fl = champ(c);
          if (fl != null) {
            final avant = dernier[c.id];
            if (avant != null && avant != fl) add('chgt_filiere', 1);
            dernier[c.id] = fl;
            premier.putIfAbsent(c.id, () => fl);
          }
        }
        employeurPrec[c.id] = c.employer;
      }
      if (c.studyField >= 0) add('etudiants', 1);
      if (s.studiesFullTime(c)) add('etudiants_plein', 1);
      if (c.employer == null) add('sans_emploi', 1);
      final fl = champ(c);
      if (fl != null && c.degrees.isNotEmpty && s.topDegree(c) > 0 && s.degreeIn(c, fl) == 0) add('hors_diplome', 1);
      if (fl != null) {
        tot[c.level]++;
        if (premier[c.id] != fl) hors[c.level]++;
        totalEmp++;
        if (premier[c.id] != fl) totalHors++;
      } else {
        final dr = dernier[c.id];
        if (dr != null) chom[dr] += 1;
      }
    }
    for (final f in s.firms) {
      if (s.publicService(f)) continue;
      vac[fieldOf(f.type)] += f.vacancies;
    }
    final presentes = <int>{for (final f in s.firms) f.id};
    for (final f in s.firms) {
      if (!vivantes.containsKey(f.id) && !s.publicService(f)) {
        vivantes[f.id] = f;
        add('naissances', 1);
      }
    }
    for (final id in vivantes.keys.toList()) {
      if (presentes.contains(id)) continue;
      add('mort_${s.closeCause(vivantes.remove(id)!)}', 1);
      add('morts', 1);
    }
    final h = s.history.last;
    add('salaire', h.wage);
    add('chomage', h.unemp);
    add('ipc', h.cpi);
    add('pop', s.citizens.length.toDouble());
    if (d % 365 == 0 || d == days) {
      final n = d % 365 == 0 ? 365 : d % 365;
      final m = <String, Object>{
        'annee': (d - 1) ~/ 365,
        'jours': n,
        for (final e in an.entries)
          e.key: const {'chomage', 'ipc', 'pop', 'salaire', 'etudiants', 'etudiants_plein', 'sans_emploi', 'hors_diplome'}
                  .contains(e.key)
              ? e.value / n
              : e.value,
        'formation': [for (var k = 0; k < st0.length; k++) lire()[k] - st0[k]],
        '_diplomes': lire()[1] - st0[1],
        if (s.formationReady) 'penurie': [for (final r in s.fieldShortage) r[1] + r[2]],
        if (s.formationReady) 'vacants_qualifies': [for (final r in s.fieldVacancies) r[1] + r[2]],
        'vacants': [for (final v in vac) v / n],
        'chomeurs_filiere': [for (final v in chom) v / n],
        'hors_filiere': [for (var k = 0; k < 3; k++) tot[k] == 0 ? 0.0 : hors[k] / tot[k]],
        'employes_classe': [for (var k = 0; k < 3; k++) tot[k] / n],
      };
      annees.add(m);
    }
  }
  // synthèse : taux annuels par habitant, après la première année (le départ n'est pas représentatif)
  final nAn = annees.length;
  double tauxAn(String k) {
    var t = 0.0, j = 0;
    for (final m in annees) {
      t += ((m[k] as num?) ?? 0).toDouble();
      j += m['jours'] as int;
    }
    final popMoy = annees.fold(0.0, (t, m) => t + ((m['pop'] as num).toDouble() * (m['jours'] as int))) / j;
    return t / (j / 365) / popMoy;
  }

  double moyDuree(int cl) {
    final l = etudes.where((e) => e[0] == cl).map((e) => e[1].toDouble()).toList();
    return l.isEmpty ? -1 : l.reduce((x, y) => x + y) / l.length;
  }

  final stock = s.formationReady ? s.diplomaStock() : null;
  final popFin = s.citizens.length;

  final out = {
    'graine': seed,
    'population': pop,
    'jours': days,
    'options': a.skip(3).join(' '),
    'secondes': chrono.elapsedMilliseconds / 1000,
    'moyennes': {
      'cours_par_hab_an': tauxAn('cours'),
      'montees_par_hab_an': tauxAn('montees'),
      'embauches_par_hab_an': tauxAn('embauches'),
      'chgt_filiere_par_hab_an': tauxAn('chgt_filiere'),
      'duree_montee_0_1': moyDuree(1),
      'duree_montee_1_2': moyDuree(2),
      'hors_filiere': totalEmp == 0 ? 0.0 : totalHors / totalEmp,
      'diplomes_par_hab_an': tauxAn('_diplomes'),
      'duree_etudes': st.graduations == 0 ? -1 : st.studyDays / st.graduations,
      'reconversions': st.reconversions,
      'inscriptions_plein': st.enrolFull,
      'inscriptions_soir': st.enrolNight,
      'prets_par_hab': st.loans / popFin,
      'jours_sans_cours': st.stalledDays,
      'etudiants': annees.fold(0.0, (t, m) => t + ((m['etudiants'] as num?) ?? 0) * (m['jours'] as int)) / days / popFin,
      'etudiants_plein': annees.fold(0.0, (t, m) => t + ((m['etudiants_plein'] as num?) ?? 0) * (m['jours'] as int)) / days / popFin,
      'sans_emploi': annees.fold(0.0, (t, m) => t + ((m['sans_emploi'] as num?) ?? 0) * (m['jours'] as int)) / days / popFin,
      'salaire': annees.fold(0.0, (t, m) => t + (m['salaire'] as num) * (m['jours'] as int)) / days,
      'ipc': annees.fold(0.0, (t, m) => t + (m['ipc'] as num) * (m['jours'] as int)) / days,
      'ipc_fin': s.history.last.cpi,
      'morts': annees.fold(0.0, (t, m) => t + ((m['morts'] as num?) ?? 0)),
      'naissances': annees.fold(0.0, (t, m) => t + ((m['naissances'] as num?) ?? 0)),
      'chomage': annees.fold(0.0, (t, m) => t + (m['chomage'] as num) * (m['jours'] as int)) / days,
      'annees': nAn,
    },
    'annees': annees,
    'etudes': etudes,
    if (stock != null) 'diplomes': stock.holders,
    if (stock != null) 'en_formation': stock.students,
  };
  final ligne = 'FORM ${jsonEncode(out)}';
  if (fichier == null) {
    print(ligne);
  } else {
    File(fichier).writeAsStringSync('$ligne\n');
  }
}
