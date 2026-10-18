// Fusion de synthèses du protocole de stabilité (tool/stabilite.dart --save) jouées dans des processus séparés.
//
//   dart run tool/fusion_syntheses.dart --save fusion.json [options] synthese.json… | dossier…
//
// Chaque synthèse d'entrée vient d'un lancement de tool/stabilite.dart sur une partie des graines ou des étapes, par
// exemple une graine et une étape par processus (--seeds 7 --phases nets --isolats 1 --save g07-nets.json). La fusion
// est la synthèse qu'aurait enregistrée un seul lancement sur toutes les graines et toutes les étapes : mêmes résultats
// par graine, dans le même ordre, mêmes chocs dans le même ordre, distributions recalculées par distributionsJson. Elle
// se relit par --relire et sert d'opérande à --compare. Seuls diffèrent la date, la durée et le nombre de parties
// simultanées (« seconds » et « isolates », écrits seulement avec --secondes et --isolats), et la clé « fusion » en plus
// (fichiers sources, temps cumulé) ; « runs » est recompté comme dans le lancement unique.
//
//   --save fusion.json      synthèse fusionnée (obligatoire)
//   --out rapport.md        écrit aussi son rapport : celui que donnerait --relire fusion.json
//   --graines 30            graines du lancement unique : 1 à N (défaut : toutes celles des entrées, par ordre croissant)
//   --seeds 3,1,2           graines du lancement unique, dans son ordre (l'ordre des parties compte pour le bootstrap
//                           de --compare)
//   --shock-seeds 1,2,3     graines des chocs, dans l'ordre du lancement unique (défaut : les graines) ; le champ
//                           « seeds » d'une entrée de chocs seuls est alors ignoré
//   --secondes 7200         durée réelle du lot, pour la ligne « Temps total » du rapport (avec --isolats)
//   --isolats 8             parties simultanées pendant le lot (avec --secondes)
//   --partiel               accepte un lot incomplet (lot en cours ou interrompu) : les parties manquantes sont
//                           signalées, pas refusées, et un fichier illisible (en cours d'écriture) est sauté
//
// Un dossier en argument vaut tous ses fichiers .json, par ordre de nom ; la sortie --save n'est jamais relue comme
// entrée. Les entrées doivent avoir la même configuration (version, niveau, durée, chauffe, jour et horizon des chocs,
// modules coupés, paramètres). Une même partie (étape et graine, ou choc, filets et graine) présente dans deux entrées
// n'est gardée qu'une fois si les deux résultats sont identiques (graine relancée après une coupure) ; s'ils diffèrent,
// c'est une erreur. Hors --partiel, chaque étape doit avoir toutes les graines, et chaque série de chocs (sans ou avec
// filets) tous les chocs de toutes les graines des chocs.
//
// Les étapes « avec filets sauf … » suivent l'ordre de leur première apparition dans les entrées (celui des --sauf du
// lancement unique) : donner les fichiers dans cet ordre si plusieurs étapes « sauf » sont fusionnées.

import 'dart:convert';
import 'dart:io';

import 'package:econodes/engine/sim.dart' show stableSort;

import 'stabilite.dart' show Json, distributionsJson, loadSummary, phaseLabel, report, shockLabels;

class FusionOptions {
  final List<String> inputs = [];
  String? save, out;
  List<int>? seeds, shockSeeds;
  double? seconds;
  int? isolates;
  bool partial = false;

  FusionOptions(List<String> args) {
    for (var i = 0; i < args.length; i++) {
      final a = args[i];
      String next() {
        if (i + 1 >= args.length) throw ArgumentError('Valeur manquante après $a');
        return args[++i];
      }

      int integer(String v) => int.tryParse(v) ?? (throw ArgumentError('$a : nombre entier attendu, pas « $v »'));
      List<int> list() => next().split(',').map(integer).toList();

      switch (a) {
        case '--save':
          save = next();
        case '--out':
          out = next();
        case '--graines':
          final n = integer(next());
          if (n < 1) throw ArgumentError('--graines : au moins 1');
          seeds = [for (var k = 1; k <= n; k++) k];
        case '--seeds':
          seeds = list();
        case '--shock-seeds':
          shockSeeds = list();
        case '--secondes':
          final v = next();
          seconds = double.tryParse(v) ?? (throw ArgumentError('--secondes : nombre attendu, pas « $v »'));
        case '--isolats':
          isolates = integer(next());
        case '--partiel':
          partial = true;
        default:
          if (a.startsWith('--')) throw ArgumentError('Option inconnue : $a');
          inputs.add(a);
      }
    }
    if (save == null) throw ArgumentError('--save fusion.json est obligatoire');
    if ((seconds == null) != (isolates == null)) throw ArgumentError('--secondes et --isolats vont ensemble');
    for (final (name, l) in [('--seeds', seeds), ('--shock-seeds', shockSeeds)]) {
      if (l != null && l.toSet().length != l.length) throw ArgumentError('$name : graine en double');
    }
  }
}

/// Une synthèse d'entrée et son fichier.
class Source {
  final String path;
  final Json sum;
  Source(this.path, this.sum);
  String get name => path.split(RegExp(r'[\\/]')).last;
}

/// Les fichiers d'entrée : les fichiers donnés, et les .json des dossiers donnés (par ordre de nom), sans la sortie.
List<String> inputFiles(FusionOptions o) {
  final files = <String>[];
  for (final a in o.inputs) {
    if (FileSystemEntity.isDirectorySync(a)) {
      files.addAll(Directory(a).listSync().whereType<File>().map((f) => f.path).where((p) => p.endsWith('.json')).toList()
        ..sort());
    } else {
      files.add(a);
    }
  }
  final save = File(o.save!);
  return [
    for (final f in files)
      if (!save.existsSync() || !File(f).existsSync() || !FileSystemEntity.identicalSync(f, save.path)) f,
  ];
}

/// Relit une synthèse enregistrée par stabilite.dart --save (format à étapes, version 2). Rend null pour un fichier
/// illisible en mode --partiel.
Source? readSource(String path, bool partial) {
  final Object? raw;
  try {
    raw = jsonDecode(File(path).readAsStringSync());
  } on FormatException catch (e) {
    if (!partial) throw FormatException('$path : JSON illisible (${e.message})');
    stderr.writeln('$path : JSON illisible, sauté (fichier en cours d’écriture ?)');
    return null;
  }
  if (raw is! Map) throw FormatException('$path : pas une synthèse');
  final m = raw.cast<String, dynamic>();
  if (m['mode'] == 'compare') throw FormatException('$path : comparaison enregistrée, pas une synthèse');
  if (m['sizes'] != null) throw FormatException('$path : synthèse du niveau 2, non prise en charge');
  if (m['phases'] == null) throw FormatException('$path : ancien format (sans « phases »), non pris en charge');
  if (m['version'] != 2) throw FormatException('$path : version ${m['version']} non prise en charge (attendu : 2)');
  return Source(path, m);
}

/// Champs de configuration qui doivent être les mêmes dans toutes les entrées.
const List<String> configKeys = [
  'version', 'level', 'label', 'days', 'warmup', 'shockDay', 'shockHorizon', 'modulesOff', 'params',
];

/// Forme comparable d'un champ de configuration ; l'ordre des paramètres ne compte pas.
String canon(String key, Object? v) {
  if (key == 'params' && v is Map) {
    final keys = v.keys.map((k) => k as String).toList()..sort();
    return jsonEncode({for (final k in keys) k: v[k]});
  }
  return jsonEncode(v);
}

String seedsText(Iterable<int> s) => (s.toList()..sort()).join(', ');

/// La synthèse fusionnée, clés dans l'ordre de summaryOf (tool/stabilite.dart).
Json merge(List<Source> src, FusionOptions o) {
  if (src.isEmpty) throw ArgumentError('Aucune synthèse à fusionner');
  final first = src.first;
  for (final s in src.skip(1)) {
    for (final k in configKeys) {
      if (canon(k, s.sum[k]) != canon(k, first.sum[k])) {
        throw StateError('${s.name} et ${first.name} n’ont pas la même configuration : '
            '$k = ${jsonEncode(s.sum[k])} contre ${jsonEncode(first.sum[k])}');
      }
    }
  }
  final problems = <String>[]; // parties manquantes : erreur, ou avertissement avec --partiel
  final duplicates = <String, int>{}; // « a.json et b.json » → parties identiques gardées une fois

  // graines : le champ « seeds » des entrées, dans l'ordre du lancement unique. Celui d'une entrée de chocs seuls ne
  // compte que si les chocs portent sur les graines des étapes (pas de --shock-seeds).
  final found = <int>{
    for (final s in src)
      if ((s.sum['phases'] as Map).isNotEmpty || o.shockSeeds == null) ...(s.sum['seeds'] as List).cast<int>(),
  };
  if (o.seeds != null) {
    final stray = found.difference(o.seeds!.toSet());
    if (stray.isNotEmpty) throw StateError('Graines des entrées absentes de --seeds / --graines : ${seedsText(stray)}');
    final none = o.seeds!.where((g) => !found.contains(g));
    if (none.isNotEmpty) problems.add('graines sans aucune entrée : ${seedsText(none)}');
  }
  final seeds = o.seeds == null ? (found.toList()..sort()) : [for (final g in o.seeds!) if (found.contains(g)) g];
  final rankOf = {for (var i = 0; i < seeds.length; i++) seeds[i]: i};

  // résultats par étape et par graine ; un doublon identique est gardé une fois
  final byPhase = <String, Map<int, (Json, String)>>{};
  for (final s in src) {
    for (final e in (s.sum['phases'] as Map).entries) {
      final phase = e.key as String;
      final bySeed = byPhase[phase] ??= {};
      for (final r in e.value as List) {
        final run = (r as Map).cast<String, dynamic>();
        final seed = run['seed'] as int;
        if (!found.contains(seed)) throw StateError('${s.name} : graine $seed absente de son champ « seeds »');
        final prev = bySeed[seed];
        if (prev == null) {
          bySeed[seed] = (run, s.name);
        } else if (jsonEncode(prev.$1) != jsonEncode(run)) {
          throw StateError('${phaseLabel(phase)}, graine $seed : résultats différents dans ${prev.$2} et ${s.name}');
        } else {
          duplicates.update('${prev.$2} et ${s.name}', (n) => n + 1, ifAbsent: () => 1);
        }
      }
    }
  }
  // ordre des étapes du lancement unique : sans filets, avec filets, puis les étapes « sauf » dans l'ordre d'apparition
  final order = [
    if (byPhase.containsKey('base')) 'base',
    if (byPhase.containsKey('nets')) 'nets',
    ...byPhase.keys.where((p) => p != 'base' && p != 'nets'),
  ];
  final phases = <String, List<Json>>{};
  for (final p in order) {
    final missing = seeds.where((g) => !byPhase[p]!.containsKey(g));
    if (missing.isNotEmpty) problems.add('${phaseLabel(p).toLowerCase()} : graines ${seedsText(missing)}');
    final runs = byPhase[p]!.values.map((v) => v.$1).toList();
    stableSort<Json>(runs, (a, b) => rankOf[a['seed']]! - rankOf[b['seed']]!);
    phases[p] = runs;
  }

  // chocs : un par (filets, type, graine), triés comme dans summaryOf : filets, puis type de choc, puis graine
  final byShock = <String, (Json, String)>{};
  for (final s in src) {
    for (final r in s.sum['shocks'] as List? ?? const []) {
      final shock = (r as Map).cast<String, dynamic>();
      final key = '${shock['nets']}/${shock['kind']}/${shock['seed']}';
      final prev = byShock[key];
      final what = 'Choc ${shock['kind']} ${shock['nets'] == true ? 'avec' : 'sans'} filets, graine ${shock['seed']}';
      if (prev == null) {
        byShock[key] = (shock, s.name);
      } else if (jsonEncode(prev.$1) != jsonEncode(shock)) {
        throw StateError('$what : résultats différents dans ${prev.$2} et ${s.name}');
      } else {
        duplicates.update('${prev.$2} et ${s.name}', (n) => n + 1, ifAbsent: () => 1);
      }
    }
  }
  for (final e in duplicates.entries) {
    stderr.writeln('${e.key} : ${e.value} partie(s) identique(s), gardée(s) une fois');
  }
  final shocks = byShock.values.map((v) => v.$1).toList();
  final shocksOn = o.shockSeeds ?? seeds;
  final kinds = shockLabels.keys.toList();
  final hint = o.shockSeeds == null ? ' (si les chocs portaient sur d’autres graines : --shock-seeds)' : '';
  if (shocks.isNotEmpty) {
    final stray = {for (final s in shocks) s['seed'] as int}.difference(shocksOn.toSet());
    if (stray.isNotEmpty) {
      throw StateError('Chocs sur des graines absentes de ${o.shockSeeds == null ? 'la liste des graines' : '--shock-seeds'} : '
          '${seedsText(stray)}$hint');
    }
    for (final nets in [false, true]) {
      if (!shocks.any((s) => s['nets'] == nets)) continue;
      final which = '${nets ? 'avec' : 'sans'} filets';
      // une graine sans aucun choc de la série : une ligne ; un choc manquant ici ou là : une ligne par type de choc
      final none = shocksOn.where((g) => kinds.every((k) => !byShock.containsKey('$nets/$k/$g'))).toSet();
      if (none.isNotEmpty) problems.add('chocs $which : graines ${seedsText(none)}$hint');
      for (final kind in kinds) {
        final missing = shocksOn.where((g) => !none.contains(g) && !byShock.containsKey('$nets/$kind/$g'));
        if (missing.isNotEmpty) problems.add('choc $kind $which : graines ${seedsText(missing)}');
      }
    }
  }
  int rank(Json r) =>
      ((r['nets'] == true ? 1 : 0) * kinds.length + kinds.indexOf(r['kind'] as String)) * 100000 +
      shocksOn.indexOf(r['seed'] as int);
  stableSort<Json>(shocks, (a, b) => rank(a) - rank(b));

  if (problems.isNotEmpty) {
    if (!o.partial) throw StateError('Lot incomplet (--partiel pour fusionner quand même) :\n  ${problems.join('\n  ')}');
    stderr.writeln('Lot incomplet, parties manquantes :\n  ${problems.join('\n  ')}');
  }

  // parties du lancement unique : une par étape et par graine, et une par graine et série de chocs (les chocs d'une
  // graine repartent d'un même début de partie)
  final runs = phases.values.fold(0, (a, l) => a + l.length) + {for (final s in shocks) '${s['nets']}/${s['seed']}'}.length;
  final seconds = [for (final s in src) (s.sum['seconds'] as num?)?.toDouble() ?? 0.0];
  return {
    'version': 2,
    if (first.sum['level'] != null) 'level': first.sum['level'],
    'date': DateTime.now().toIso8601String(),
    'label': first.sum['label'],
    'seeds': seeds,
    'days': first.sum['days'],
    'warmup': first.sum['warmup'],
    'shockDay': first.sum['shockDay'],
    'shockHorizon': first.sum['shockHorizon'],
    'modulesOff': first.sum['modulesOff'],
    'params': first.sum['params'],
    if (o.seconds != null) 'seconds': o.seconds,
    'runs': runs,
    if (o.isolates != null) 'isolates': o.isolates,
    'phases': phases,
    'shocks': shocks,
    'distributions': {for (final e in phases.entries) e.key: distributionsJson(e.key, e.value)},
    'fusion': {
      'sources': [for (final s in src) s.name],
      'secondsSum': seconds.fold(0.0, (a, b) => a + b), // temps cumulé des lancements, pas une durée réelle
    },
  };
}

void main(List<String> args) {
  try {
    final o = FusionOptions(args);
    final src = [
      for (final f in inputFiles(o))
        if (readSource(f, o.partial) case final s?) s,
    ];
    final sum = merge(src, o);
    File(o.save!)
      ..parent.createSync(recursive: true)
      ..writeAsStringSync(jsonEncode(sum));
    final phases = (sum['phases'] as Map<String, List<Json>>).entries.map((e) => '${phaseLabel(e.key).toLowerCase()} '
        '${e.value.length}');
    final shocks = (sum['shocks'] as List).length;
    stderr.writeln('${src.length} synthèses fusionnées (${[...phases, if (shocks > 0) 'chocs $shocks'].join(', ')}, '
        '${sum['runs']} parties) : ${o.save}');
    if (o.out != null) {
      // le rapport de la synthèse relue, comme --relire
      File(o.out!)
        ..parent.createSync(recursive: true)
        ..writeAsStringSync(report(loadSummary(o.save!)));
      stderr.writeln('rapport écrit : ${o.out}');
    }
  } on FormatException catch (e) {
    fail(e.source == null ? e.message : '$e');
  } on ArgumentError catch (e) {
    fail('${e.message}');
  } on StateError catch (e) {
    fail(e.message);
  } on FileSystemException catch (e) {
    fail('$e');
  }
}

/// Erreur d'usage ou lot incohérent : un message, sans pile d'appels.
void fail(String message) {
  stderr.writeln('fusion_syntheses : $message');
  exitCode = 1;
}
