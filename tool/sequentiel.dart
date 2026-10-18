// Comparaison appariée à arrêt séquentiel : on ajoute des graines par lots (5 par défaut) et on s'arrête quand la demi-largeur
// de l'intervalle de confiance à 95 % de la différence médiane B − A passe, pour chaque indicateur, sous son seuil (30 graines
// au plus). Le nombre de graines devient un résultat : celui qu'il faut pour trancher, pas un nombre posé d'avance.
//
//   dart run tool/sequentiel.dart --population 2500 --days 1000 --a "param:sellerSample=0" --b ref [options]
//
//   --population N       taille de la population (défaut 2 500, le niveau d'exploration)
//   --days D --warmup W  durée et chauffe (défaut 1 000 et 100)
//   --a SPEC --b SPEC    les deux configurations (voir Config.apply de tool/stabilite.dart : « ref », « param:x=1 », « credit=0 »…)
//   --phases base,nets   étapes jouées (sans filets, avec filets)
//   --lot 5 --max 30     graines ajoutées par lot ; plafond
//   --seuils unempMean=0.02,hungerMean=0.01,homelessMean=0.01,firmsMean=0.05
//                        demi-largeur voulue : en valeur absolue (parts : 0,02 = 2 points) ; firmsMean est relatif
//                        (0,05 = 5 % de la médiane de A)
//   --sans-arret         joue jusqu'au plafond sans s'arrêter (pour tracer la demi-largeur en fonction du nombre de graines)
//   --isolats N          parties simultanées (défaut : nombre de processeurs)
//   --save f.json --out rapport.md
//
// Intervalle : bootstrap percentile de la médiane des différences par graine (10 000 tirages), comme `stabilite --compare`.
// Une graine joue la configuration A et la configuration B avec les mêmes flux de hasard : la comparaison est appariée.

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:econodes/engine/model.dart' show Modules;

import 'stabilite.dart' show Config, Json, Task, baseJob, bootstrapMedian, runAll;

class Ind {
  final String key, label;
  final bool relatif;
  double seuil;
  Ind(this.key, this.label, this.seuil, {this.relatif = false});
}

List<Ind> indicateurs() => [
      Ind('unempMean', 'Chômage moyen', 0.02),
      Ind('hungerMean', 'Faim moyenne', 0.01),
      Ind('homelessMean', 'Sans-abri moyen', 0.01),
      Ind('firmsMean', 'Parc moyen d’entreprises', 0.05, relatif: true),
    ];

double median(List<double> v) {
  final l = List<double>.of(v)..sort();
  final m = l.length ~/ 2;
  return l.length.isOdd ? l[m] : (l[m - 1] + l[m]) / 2;
}

String pc(double v) => '${(v * 100).toStringAsFixed(2).replaceAll('.', ',')} pt';

Future<void> main(List<String> args) async {
  var pop = 2500, days = 1000, warmup = 100, lot = 5, max = 30;
  var specA = 'ref', specB = 'ref';
  var phases = ['base', 'nets'];
  var sansArret = false;
  var isolats = Platform.numberOfProcessors;
  String? save, out;
  final inds = indicateurs();
  for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--population':
        pop = int.parse(args[++i]);
      case '--days':
        days = int.parse(args[++i]);
      case '--warmup':
        warmup = int.parse(args[++i]);
      case '--a':
        specA = args[++i];
      case '--b':
        specB = args[++i];
      case '--phases':
        phases = args[++i].split(',');
      case '--lot':
        lot = int.parse(args[++i]);
      case '--max':
        max = int.parse(args[++i]);
      case '--sans-arret':
        sansArret = true;
      case '--isolats':
        isolats = int.parse(args[++i]);
      case '--seuils':
        for (final kv in args[++i].split(',')) {
          final p = kv.split('=');
          inds.firstWhere((x) => x.key == p[0]).seuil = double.parse(p[1]);
        }
      case '--save':
        save = args[++i];
      case '--out':
        out = args[++i];
      default:
        throw ArgumentError('Option inconnue : ${args[i]}');
    }
  }
  final base = Config('ref', Modules(), {'population': '$pop'});
  final configs = [base.apply(specA), base.apply(specB)];
  final sw = Stopwatch()..start();
  void progress(String m) => stderr.writeln('[${(sw.elapsedMilliseconds / 1000).toStringAsFixed(0).padLeft(5)} s] $m');

  // résultats[phase][config][graine]
  final res = {
    for (final p in phases) p: [<int, Json>{}, <int, Json>{}]
  };
  // historique : par lot, par étape, par indicateur : (n, médiane des différences, bas, haut, demi-largeur)
  final histo = <Map<String, Map<String, List<double>>>>[];
  var n = 0;
  while (n < max) {
    final seeds = [for (var s = n + 1; s <= math.min(max, n + lot); s++) s];
    final tasks = <Task>[];
    for (var ci = 0; ci < 2; ci++) {
      for (final p in phases) {
        for (final s in seeds) {
          tasks.add(Task(ci, p, '${ci == 0 ? 'A' : 'B'} ${p == 'base' ? 'sans' : 'avec'} filets, graine $s',
              baseJob(s, configs[ci], days, warmup, p == 'nets', const {})));
        }
      }
    }
    final out0 = await runAll(tasks, isolats, progress);
    for (var t = 0; t < tasks.length; t++) {
      final r = out0[t];
      res[tasks[t].phase]![tasks[t].config][r['seed'] as int] = r;
    }
    n += seeds.length;
    final entry = <String, Map<String, List<double>>>{};
    var tousPasse = true;
    for (final p in phases) {
      final e = entry[p] = {};
      for (final ind in inds) {
        final a = res[p]![0], b = res[p]![1];
        final diffs = <double>[], va = <double>[];
        for (final s in a.keys) {
          if (!b.containsKey(s)) continue;
          final x = (a[s]![ind.key] as num).toDouble(), y = (b[s]![ind.key] as num).toDouble();
          diffs.add(y - x);
          va.add(x);
        }
        final (lo, hi) = bootstrapMedian(diffs);
        var half = (hi - lo) / 2;
        final ref = ind.relatif ? median(va).abs() : 1.0;
        if (ind.relatif) half = ref > 0 ? half / ref : double.infinity;
        final d = ind.relatif && ref > 0 ? ref : 1.0; // les différences relatives sont rapportées à la médiane de A
        e[ind.key] = [n.toDouble(), median(diffs) / d, lo / d, hi / d, half];
        if (half > ind.seuil) tousPasse = false;
      }
    }
    histo.add(entry);
    progress('$n graines : ${tousPasse ? 'tous les seuils sont atteints' : 'seuils pas tous atteints'}');
    if (tousPasse && !sansArret) break;
  }

  // nombre de graines nécessaire : premier lot à partir duquel la demi-largeur reste sous le seuil
  String besoin(String p, Ind ind) {
    int? stable;
    for (var i = histo.length - 1; i >= 0; i--) {
      if (histo[i][p]![ind.key]![4] <= ind.seuil) {
        stable = histo[i][p]![ind.key]![0].round();
      } else {
        break;
      }
    }
    return stable == null ? 'plus de $n' : '$stable';
  }

  final b = StringBuffer();
  b.writeln('# Comparaison à arrêt séquentiel\n');
  b.writeln('- A : `$specA` ; B : `$specB` ; $pop habitants, $days jours (chauffe $warmup) ; lots de $lot graines, $n graines jouées '
      '(plafond $max)${sansArret ? ', sans arrêt anticipé' : ''}.');
  b.writeln('- Temps : ${(sw.elapsedMilliseconds / 1000).toStringAsFixed(0)} s. Intervalle : bootstrap percentile de la médiane des '
      'différences par graine (B − A), 95 %.\n');
  for (final p in phases) {
    b.writeln('## ${p == 'base' ? 'Sans filets' : 'Avec filets'}\n');
    b.writeln('| Indicateur | Seuil (demi-largeur) | Différence médiane B − A [intervalle] | Demi-largeur à $n graines | '
        'Graines nécessaires |');
    b.writeln('|---|---|---|---|---|');
    for (final ind in inds) {
      final h = histo.last[p]![ind.key]!;
      String fmt(double v) => ind.relatif ? '${(v * 100).toStringAsFixed(1).replaceAll('.', ',')} %' : pc(v);
      b.writeln('| ${ind.label} | ${fmt(ind.seuil)} | ${fmt(h[1])} [${fmt(h[2])} ; ${fmt(h[3])}] | ${fmt(h[4])} | '
          '${besoin(p, ind)} |');
    }
    b.writeln('\nDemi-largeur selon le nombre de graines :\n');
    b.writeln('| Graines | ${inds.map((x) => x.label).join(' | ')} |');
    b.writeln('|---|${inds.map((_) => '---').join('|')}|');
    for (final e in histo) {
      b.writeln('| ${e[p]![inds.first.key]![0].round()} | ${[
        for (final ind in inds)
          ind.relatif
              ? '${(e[p]![ind.key]![4] * 100).toStringAsFixed(1).replaceAll('.', ',')} %'
              : pc(e[p]![ind.key]![4])
      ].join(' | ')} |');
    }
    b.writeln();
  }
  if (out != null) {
    File(out).parent.createSync(recursive: true);
    File(out).writeAsStringSync(b.toString());
  } else {
    stdout.write(b);
  }
  if (save != null) {
    File(save).parent.createSync(recursive: true);
    File(save).writeAsStringSync(jsonEncode({
      'a': specA,
      'b': specB,
      'population': pop,
      'days': days,
      'warmup': warmup,
      'graines': n,
      'seuils': {for (final i in inds) i.key: i.seuil},
      'historique': histo,
      'phases': {
        for (final p in phases) p: [for (var c = 0; c < 2; c++) res[p]![c].values.toList()]
      },
    }));
  }
}
