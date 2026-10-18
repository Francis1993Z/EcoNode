// Méthode de calibration : criblage de Morris, puis hypercube latin sur les paramètres retenus. Livre l'outil, ne calibre
// pas : il dit quels paramètres comptent, et comment la sortie y répond, pas quelles valeurs choisir.
//
//   dart run tool/criblage.dart morris [options]       criblage : quels paramètres comptent (effets élémentaires)
//   dart run tool/criblage.dart lhs --params a,b [opt] hypercube latin sur quelques paramètres retenus
//
//   --population 2500   taille (le niveau d'exploration)    --days 600 --warmup 100   durée et chauffe
//   --params a,b,c      paramètres (noms de tool/parametres.dart ; défaut du criblage : tous)
//   --trajectoires 8    (morris) nombre de trajectoires r : r × (k + 1) parties
//   --points 30         (lhs) nombre de points
//   --graine 1          graine du plan d'expérience (pas celle des parties)
//   --filets 1|0        filets de sécurité actifs (défaut 1)
//   --isolats N         parties simultanées (défaut : nombre de processeurs)
//   --save f.json --out rapport.md
//
// Morris (1991, avec les trajectoires aléatoires de Campolongo et al. 2007) : p = 4 niveaux par paramètre, pas Δ = 2/3 ;
// une trajectoire part d'un point aléatoire de la grille et déplace les paramètres un par un, dans un ordre aléatoire, de
// ±Δ. L'effet élémentaire d'un paramètre est (y après − y avant) / (±Δ), en unités de la plage normalisée [0, 1]. On
// rapporte μ* (moyenne des valeurs absolues : l'importance), μ (moyenne : le sens) et σ (écart-type : non-linéarité ou
// interactions). Tous les points d'une trajectoire jouent la même graine de partie : seuls les paramètres changent, pas le
// hasard ; chaque trajectoire a sa graine. Les plages (tool/parametres.dart) sont d'exploration, pas des valeurs réalistes.
//
// Hypercube latin : chaque paramètre est découpé en N strates de même largeur, un point par strate, les strates
// permutées au hasard d'un paramètre à l'autre. Sorties : tableau des points, corrélations de rang (Spearman) de chaque
// paramètre avec chaque indicateur, et les points qui tiennent les bandes visées.
//
// Si le nombre de parties devient trop grand, un modèle de substitution (Lamperti, Roventini et Sani, 2018 : forêt
// d'arbres ou processus gaussien appris sur quelques centaines de parties, puis exploré à bas coût) prend le relais ;
// il n'est pas fait ici, la taille actuelle (une centaine de parties à 2 500 citoyens) n'en a pas besoin.

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:econodes/engine/model.dart' show Modules;
import 'package:econodes/engine/sim.dart' show Mulberry32;

import 'parametres.dart';
import 'stabilite.dart' show Config, Task, baseJob, runAll;

/// Les sorties étudiées : clé de la synthèse d'une partie, libellé, facteur d'affichage.
const List<(String, String)> sorties = [
  ('unempMean', 'Chômage moyen'),
  ('hungerMean', 'Faim moyenne'),
  ('homelessMean', 'Sans-abri moyen'),
  ('firmsMean', 'Parc moyen d’entreprises'),
  ('inflMean', 'Inflation moyenne par jour'),
  ('giniMean', 'Gini moyen'),
];

String fmt(double v, String key) {
  String c(String s) => s.replaceAll('.', ',');
  if (key == 'firmsMean') return c(v.toStringAsFixed(1));
  if (key == 'giniMean') return c(v.toStringAsFixed(3));
  if (key == 'inflMean') return '${c((v * 100).toStringAsFixed(3))} %';
  return '${c((v * 100).toStringAsFixed(1))} %';
}

String nb(double v, [int d = 2]) => v.toStringAsFixed(d).replaceAll('.', ',');

class Plan {
  final List<ParamDef> params;
  final List<List<double>> points; // positions normalisées dans [0, 1], une ligne par partie
  final List<int> seeds; // graine de la partie de chaque ligne
  Plan(this.params, this.points, this.seeds);
}

/// Un plan de Morris : r trajectoires de k + 1 points.
Plan planMorris(List<ParamDef> ps, int r, int seed) {
  final rng = Mulberry32(seed);
  final k = ps.length;
  const levels = 4;
  const delta = 2 / 3;
  final pts = <List<double>>[];
  final seeds = <int>[];
  for (var t = 0; t < r; t++) {
    final x = [for (var i = 0; i < k; i++) (rng.next() * levels).floor() / (levels - 1)];
    pts.add(List<double>.of(x));
    seeds.add(t + 1);
    final order = List<int>.generate(k, (i) => i);
    for (var i = k - 1; i > 0; i--) {
      final j = (rng.next() * (i + 1)).floor();
      final tmp = order[i];
      order[i] = order[j];
      order[j] = tmp;
    }
    for (final i in order) {
      final up = x[i] + delta <= 1 + 1e-9, down = x[i] - delta >= -1e-9;
      final plus = up && (!down || rng.next() < 0.5);
      x[i] = plus ? x[i] + delta : x[i] - delta;
      pts.add(List<double>.of(x));
      seeds.add(t + 1);
    }
  }
  return Plan(ps, pts, seeds);
}

/// Un hypercube latin de n points ; la graine de la partie i est i + 1.
Plan planLhs(List<ParamDef> ps, int n, int seed) {
  final rng = Mulberry32(seed);
  final cols = <List<double>>[];
  for (var j = 0; j < ps.length; j++) {
    final perm = List<int>.generate(n, (i) => i);
    for (var i = n - 1; i > 0; i--) {
      final q = (rng.next() * (i + 1)).floor();
      final tmp = perm[i];
      perm[i] = perm[q];
      perm[q] = tmp;
    }
    cols.add([for (var i = 0; i < n; i++) (perm[i] + rng.next()) / n]);
  }
  return Plan(ps, [for (var i = 0; i < n; i++) [for (var j = 0; j < ps.length; j++) cols[j][i]]], [for (var i = 0; i < n; i++) i + 1]);
}

double spearman(List<double> a, List<double> b) {
  List<double> ranks(List<double> v) {
    final idx = List<int>.generate(v.length, (i) => i)..sort((x, y) => v[x].compareTo(v[y]));
    final r = List<double>.filled(v.length, 0);
    var i = 0;
    while (i < idx.length) {
      var j = i;
      while (j + 1 < idx.length && v[idx[j + 1]] == v[idx[i]]) {
        j++;
      }
      for (var q = i; q <= j; q++) {
        r[idx[q]] = (i + j) / 2 + 1;
      }
      i = j + 1;
    }
    return r;
  }

  final ra = ranks(a), rb = ranks(b);
  final n = a.length;
  final ma = ra.fold(0.0, (x, y) => x + y) / n, mb = rb.fold(0.0, (x, y) => x + y) / n;
  var sab = 0.0, saa = 0.0, sbb = 0.0;
  for (var i = 0; i < n; i++) {
    sab += (ra[i] - ma) * (rb[i] - mb);
    saa += (ra[i] - ma) * (ra[i] - ma);
    sbb += (rb[i] - mb) * (rb[i] - mb);
  }
  return saa > 0 && sbb > 0 ? sab / math.sqrt(saa * sbb) : 0;
}

Future<void> main(List<String> args) async {
  if (args.isEmpty || (args[0] != 'morris' && args[0] != 'lhs')) {
    stderr.writeln('Usage : dart run tool/criblage.dart morris|lhs [options] (voir l’en-tête du fichier)');
    exit(2);
  }
  final mode = args[0];
  var pop = 2500, days = 600, warmup = 100, r = 8, points = 30, gseed = 1, nets = true;
  var isolats = Platform.numberOfProcessors;
  List<String>? names;
  String? save, out;
  for (var i = 1; i < args.length; i++) {
    switch (args[i]) {
      case '--population':
        pop = int.parse(args[++i]);
      case '--days':
        days = int.parse(args[++i]);
      case '--warmup':
        warmup = int.parse(args[++i]);
      case '--params':
        names = args[++i].split(',');
      case '--trajectoires':
        r = int.parse(args[++i]);
      case '--points':
        points = int.parse(args[++i]);
      case '--graine':
        gseed = int.parse(args[++i]);
      case '--filets':
        nets = args[++i] != '0';
      case '--isolats':
        isolats = int.parse(args[++i]);
      case '--save':
        save = args[++i];
      case '--out':
        out = args[++i];
      default:
        throw ArgumentError('Option inconnue : ${args[i]}');
    }
  }
  final ps = names == null
      ? parametresCalibrables
      : [for (final n in names) parametresCalibrables.firstWhere((d) => d.nom == n, orElse: () => throw ArgumentError('Paramètre inconnu : $n'))];
  final plan = mode == 'morris' ? planMorris(ps, r, gseed) : planLhs(ps, points, gseed);
  final sw = Stopwatch()..start();
  void progress(String m) => stderr.writeln('[${(sw.elapsedMilliseconds / 1000).toStringAsFixed(0).padLeft(5)} s] $m');
  progress('${plan.points.length} parties (${mode == 'morris' ? '$r trajectoires × ${ps.length + 1} points' : '$points points'}), '
      '$pop habitants, $days jours');

  final tasks = <Task>[];
  for (var i = 0; i < plan.points.length; i++) {
    final params = {'population': '$pop'};
    for (var j = 0; j < ps.length; j++) {
      params[ps[j].nom] = ps[j].valeur(plan.points[i][j]).toString();
    }
    tasks.add(Task(0, 'base', 'point ${i + 1}', baseJob(plan.seeds[i], Config('p', Modules(), params), days, warmup, nets, const {})));
  }
  final res = await runAll(tasks, isolats, progress);
  final y = <String, List<double>>{
    for (final (k, _) in sorties) k: [for (final x in res) (x[k] as num).toDouble()],
  };
  final crashes = [for (var i = 0; i < res.length; i++) if (res[i]['crash'] != null) i + 1];

  final b = StringBuffer();
  b.writeln('# ${mode == 'morris' ? 'Criblage de Morris' : 'Hypercube latin'}\n');
  b.writeln('- $pop habitants, $days jours (chauffe $warmup), filets ${nets ? 'actifs' : 'coupés'}, k = 5 par défaut, '
      '${plan.points.length} parties en ${(sw.elapsedMilliseconds / 1000).toStringAsFixed(0)} s.');
  b.writeln('- Paramètres et plages d\'exploration : ${ps.map((d) => '`${d.nom}` [${nb(d.bas, 4)} ; ${nb(d.haut, 4)}]').join(', ')}.');
  if (crashes.isNotEmpty) b.writeln('- Parties interrompues : ${crashes.join(', ')}.');
  b.writeln();

  if (mode == 'morris') {
    final k = ps.length;
    // effets élémentaires : dans chaque trajectoire, les k pas consécutifs
    final ee = <String, List<List<double>>>{for (final (key, _) in sorties) key: [for (var j = 0; j < k; j++) []]};
    for (var t = 0; t < r; t++) {
      final o = t * (k + 1);
      for (var s = 1; s <= k; s++) {
        final a = plan.points[o + s - 1], c = plan.points[o + s];
        final j = [for (var q = 0; q < k; q++) if ((a[q] - c[q]).abs() > 1e-9) q].single;
        final d = c[j] - a[j];
        for (final (key, _) in sorties) {
          ee[key]![j].add((y[key]![o + s] - y[key]![o + s - 1]) / d);
        }
      }
    }
    for (final (key, label) in sorties) {
      b.writeln('## $label\n');
      b.writeln('Effet d\'un passage du bas au haut de la plage, en unité de l\'indicateur (${key == 'firmsMean' ? 'entreprises' : key == 'giniMean' ? 'indice' : key == 'inflMean' ? 'points de % par jour' : 'points de pourcentage'}).\n');
      b.writeln('| Paramètre | μ* (importance) | μ (sens) | σ | σ / μ* |');
      b.writeln('|---|---|---|---|---|');
      final rows = <(String, double, double, double)>[];
      for (var j = 0; j < k; j++) {
        final e = ee[key]![j];
        final mu = e.fold(0.0, (x, v) => x + v) / e.length;
        final mus = e.fold(0.0, (x, v) => x + v.abs()) / e.length;
        final sd = e.length > 1 ? math.sqrt(e.fold(0.0, (x, v) => x + (v - mu) * (v - mu)) / (e.length - 1)) : 0.0;
        rows.add((ps[j].nom, mus, mu, sd));
      }
      rows.sort((a, c) => c.$2.compareTo(a.$2));
      final scale = key == 'firmsMean' || key == 'giniMean' ? 1.0 : 100.0;
      for (final (n, mus, mu, sd) in rows) {
        b.writeln('| `$n` | ${nb(mus * scale)} | ${nb(mu * scale)} | ${nb(sd * scale)} | ${mus > 0 ? nb(sd / mus) : '—'} |');
      }
      b.writeln();
    }
    b.writeln('Lecture : μ* grand = le paramètre compte ; μ de même signe que μ* = effet monotone ; σ / μ* au-dessus de 1 = effet '
        'qui change de sens ou dépend des autres paramètres. Avec r = $r trajectoires, un μ* proche de σ / √r est du bruit.\n');
  } else {
    b.writeln('## Corrélations de rang (Spearman) entre paramètres et indicateurs\n');
    b.writeln('| Paramètre | ${sorties.map((s) => s.$2).join(' | ')} |');
    b.writeln('|---|${sorties.map((_) => '---').join('|')}|');
    for (var j = 0; j < ps.length; j++) {
      final col = [for (final p in plan.points) p[j]];
      b.writeln('| `${ps[j].nom}` | ${sorties.map((s) => nb(spearman(col, y[s.$1]!))).join(' | ')} |');
    }
    b.writeln('\nAvec ${plan.points.length} points, une corrélation de valeur absolue sous '
        '${nb(2 / math.sqrt(plan.points.length))} ne se distingue pas de zéro.\n');
    b.writeln('## Points\n');
    b.writeln('| # | ${ps.map((d) => d.nom).join(' | ')} | ${sorties.map((s) => s.$2).join(' | ')} |');
    b.writeln('|---|${ps.map((_) => '---').join('|')}|${sorties.map((_) => '---').join('|')}|');
    for (var i = 0; i < plan.points.length; i++) {
      b.writeln('| ${i + 1} | ${[for (var j = 0; j < ps.length; j++) nb(ps[j].valeur(plan.points[i][j]), 4)].join(' | ')} | '
          '${[for (final (key, _) in sorties) fmt(y[key]![i], key)].join(' | ')} |');
    }
    final bons = [
      for (var i = 0; i < plan.points.length; i++)
        if (y['unempMean']![i] <= 0.10 && y['hungerMean']![i] < 0.02 && y['homelessMean']![i] < 0.02) i + 1
    ];
    b.writeln('\nPoints dans les bandes de stabilité (chômage ≤ 10 %, faim < 2 %, sans-abri < 2 %) : '
        '${bons.isEmpty ? 'aucun' : '${bons.length} sur ${plan.points.length} (${bons.join(', ')})'}.');
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
      'mode': mode,
      'population': pop,
      'days': days,
      'params': [for (final d in ps) {'nom': d.nom, 'bas': d.bas, 'haut': d.haut}],
      'points': plan.points,
      'graines': plan.seeds,
      'sorties': y,
    }));
  }
}
