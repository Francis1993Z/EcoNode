// Démographie des entreprises, lecture seule : naissances, morts, survie et rachats d'une partie aux réglages de
// l'interface (mêmes options que tool/derive.dart).
//
//   dart run tool/demographie.dart graine population jours [--produits 0|1] [--batiments 0|1] [--banques 0|1]
//        [--filets 0|1] [--param nom=valeur,...] [--sortie fichier]
//
// Sortie : « DEMO {json} » sur une ligne (sur la sortie standard, ou dans le fichier) :
//   - entreprises : une fiche par entreprise privée vue pendant la partie, [type, naissance, mort, cause, rachats,
//     effectif maximal] (naissance 0 = entreprise du plan de départ ; mort null = vivante à la fin ; cause = closeCause
//     lue sur l'entreprise le jour de sa fermeture) ;
//   - annees : par année de partie (365 jours), entreprises privées en début d'année et en moyenne, actives (au moins un
//     employé) en moyenne, naissances, morts par cause, rachats, chômage moyen, indice des prix moyen.
// Les établissements publics (hôpital, école…) ne naissent ni ne meurent : ils sont exclus.

import 'dart:convert';
import 'dart:io';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final p = parametresInterface(pop);
  var produits = true, batiments = false, banques = false, filets = true;
  String? fichier;
  for (var i = 3; i < a.length; i++) {
    switch (a[i]) {
      case '--produits':
        produits = a[++i] == '1';
      case '--batiments':
        batiments = a[++i] == '1';
      case '--banques':
        banques = a[++i] == '1';
      case '--filets':
        filets = a[++i] == '1';
      case '--sortie':
        fichier = a[++i];
      case '--param':
        for (final kv in a[++i].split(',')) {
          final j = kv.indexOf('=');
          regler(p, kv.substring(0, j), kv.substring(j + 1));
        }
    }
  }
  final s = Sim(
      seed: seed,
      params: p,
      modules: Modules()
        ..jobs = true
        ..entrepreneurship = true
        ..products = produits
        ..buildings = batiments
        ..banking = banques,
      safeguards: filets ? Safeguards() : Safeguards.none());

  // fiche par entreprise : type, naissance, mort, cause, rachats, effectif maximal
  final fiches = <int, List<Object?>>{};
  final vivantes = <int, Firm>{};
  final proprio = <int, int?>{};
  void voir(Firm f, int jour) {
    if (s.publicService(f)) return;
    fiches[f.id] = [f.type, jour, null, null, 0, f.workers.length];
    vivantes[f.id] = f;
    proprio[f.id] = f.ownerId;
  }

  for (final f in s.firms) {
    voir(f, 0);
  }
  final annees = <Map<String, Object>>[];
  var an = <String, double>{};
  void add(String k, double v) => an[k] = (an[k] ?? 0) + v;
  final chrono = Stopwatch()..start();
  for (var d = 1; d <= days; d++) {
    if ((d - 1) % 365 == 0) an = {'debut': vivantes.length.toDouble()};
    s.step();
    final presentes = <int>{};
    for (final f in s.firms) {
      presentes.add(f.id);
      final fi = fiches[f.id];
      if (fi == null) {
        if (s.publicService(f)) continue;
        voir(f, d);
        add('naissances', 1);
        continue;
      }
      if (fi[2] != null) continue;
      if (f.workers.length > (fi[5] as int)) fi[5] = f.workers.length;
      if (f.ownerId != proprio[f.id]) {
        // changement de propriétaire : un rachat du filet de renflouement (le seul endroit qui en change)
        fi[4] = (fi[4] as int) + 1;
        proprio[f.id] = f.ownerId;
        add('rachats', 1);
      }
    }
    for (final id in vivantes.keys.toList()) {
      if (presentes.contains(id)) continue;
      final f = vivantes.remove(id)!;
      final cause = s.closeCause(f);
      fiches[id]![2] = d;
      fiches[id]![3] = cause;
      add('morts', 1);
      add('mort_$cause', 1);
    }
    final h = s.history.last;
    add('entreprises', vivantes.length / 365);
    add('actives', s.firms.where((f) => !s.publicService(f) && f.workers.isNotEmpty).length / 365);
    add('chomage', h.unemp / 365);
    add('ipc', h.cpi / 365);
    if (d % 365 == 0 || d == days) {
      final n = d % 365 == 0 ? 365 : d % 365;
      if (n < 365) {
        // année incomplète : les moyennes sont ramenées à ses jours
        for (final k in ['entreprises', 'actives', 'chomage', 'ipc']) {
          an[k] = an[k]! * 365 / n;
        }
      }
      annees.add({'annee': (d - 1) ~/ 365, 'jours': n, ...an, 'fin': vivantes.length.toDouble()});
    }
  }
  final out = {
    'graine': seed,
    'population': pop,
    'jours': days,
    'options': a.skip(3).join(' '),
    'secondes': chrono.elapsedMilliseconds / 1000,
    'entonnoir': s.entryFunnel,
    'annees': annees,
    'entreprises': fiches.values.toList(),
  };
  final ligne = 'DEMO ${jsonEncode(out)}';
  if (fichier == null) {
    print(ligne);
  } else {
    File(fichier).writeAsStringSync('$ligne\n');
  }
}
