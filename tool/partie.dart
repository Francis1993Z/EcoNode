// Une partie d'ÉcoNodes en ligne de commande, avec ses journaux complets (l'interface garde des listes plafonnées).
//
//   dart run tool/partie.dart [options]
//
//   --graine 42              graine (défaut : 42)
//   --jours 1500             dernier jour joué (défaut : 1500 ; après --from-snapshot, la partie continue jusque-là)
//   --filets 1               filets de sécurité actifs (1, défaut) ou coupés (0)
//   --sauf bailout,famine    filets coupés (les autres restent actifs)
//   --modules credit=0,...   coupe (0) ou active (1) des modules
//   --noyau                  coupe tous les modules ajoutés au modèle de base (les institutions restent actives)
//   --param nom=valeur       change un paramètre (comme tool/stabilite.dart)
//   --population 1000        taille de la population (comme --param population=1000)
//   --sans-hasard            tous les tirages valent 0,5 et les ordres du jour suivent les identifiants (cas extrême de
//                            la tâche 4 : une partie lisible à la main ; la graine ne compte plus)
//
//   --trace dossier/         écrit evenements.jsonl, series.csv, agents_fin.csv et entreprises.csv
//   --categories a,b         catégories gardées dans evenements.jsonl (défaut : toutes) :
//                            compta, travail, credit, filets, institutions, entrees_sorties, alertes
//   --snapshot-every 100     écrit l'état complet tous les 100 jours (instantane-j00100.json…)
//   --snapshot-at 250,400    écrit l'état complet à ces jours
//   --snapshot-dir dossier/  dossier des instantanés (défaut : celui de --trace, sinon instantanes/)
//   --from-snapshot f.json   reprend la partie depuis un instantané (sa configuration remplace les options ci-dessus)
//   --empreintes f.jsonl     écrit, chaque jour, un hachage de chaque partie de l'état (utilisé par --diff)
//
//   --diff vA vB             fait tourner deux versions du moteur sur la même partie (mêmes options) et donne le
//                            premier jour et les premières variables où elles divergent. vA et vB : un dossier qui
//                            contient ÉcoNodes, « travail » (ce dossier-ci) ou une révision git (commit, branche).
//                            Les deux versions doivent connaître --empreintes et --snapshot-at (ajoutés ici).

import 'dart:convert';
import 'dart:io';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:econodes/engine/trace.dart';

import 'stabilite.dart' show applyParam;

class _Opts {
  int seed = 42;
  int days = 1500;
  bool nets = true;
  Set<String> sauf = {};
  Modules modules = Modules();
  Map<String, String> params = {};
  bool noRandom = false;
  String? trace;
  Set<String>? categories;
  int? every;
  Set<int> at = {};
  String? snapDir;
  String? from;
  String? digests;
  List<String>? diff;
  final List<String> passThrough = []; // options de la partie, transmises aux deux versions par --diff

  _Opts(List<String> args) {
    for (var i = 0; i < args.length; i++) {
      final a = args[i];
      String next() {
        if (i + 1 >= args.length) throw ArgumentError('Valeur manquante après $a');
        return args[++i];
      }

      void keep(String v) => passThrough.addAll([a, v]);
      switch (a) {
        case '--graine':
        case '--seed':
          final v = next();
          seed = int.parse(v);
          keep(v);
        case '--jours':
        case '--days':
          final v = next();
          days = int.parse(v);
          keep(v);
        case '--filets':
          final v = next();
          nets = v != '0';
          keep(v);
        case '--sauf':
          final v = next();
          sauf = v.split(',').toSet();
          for (final k in sauf) {
            Safeguards().get(k); // filet inconnu : erreur tout de suite
          }
          keep(v);
        case '--noyau':
          modules = Modules.noyau();
          passThrough.add(a);
        case '--modules':
          final v = next();
          for (final kv in v.split(',')) {
            final p = kv.split('=');
            modules.set(p[0], p.length < 2 || p[1] != '0');
          }
          keep(v);
        case '--param':
          final v = next();
          for (final kv in v.split(',')) {
            final k = kv.indexOf('=');
            if (k < 0) throw ArgumentError('Paramètre sans valeur : $kv');
            applyParam(Params(), kv.substring(0, k), kv.substring(k + 1));
            params[kv.substring(0, k)] = kv.substring(k + 1);
          }
          keep(v);
        case '--population':
          final v = next();
          applyParam(Params(), 'population', v);
          params['population'] = v;
          keep(v);
        case '--sans-hasard':
          noRandom = true;
          passThrough.add(a);
        case '--trace':
          trace = next();
        case '--categories':
          categories = next().split(',').toSet();
          for (final c in categories!) {
            if (!traceCategories.contains(c)) throw ArgumentError('Catégorie inconnue : $c (${traceCategories.join(', ')})');
          }
        case '--snapshot-every':
          every = int.parse(next());
        case '--snapshot-at':
          at.addAll(next().split(',').map(int.parse));
        case '--snapshot-dir':
          snapDir = next();
        case '--from-snapshot':
          from = next();
        case '--empreintes':
          digests = next();
        case '--diff':
          diff = [next(), next()];
        default:
          throw ArgumentError('Option inconnue : $a');
      }
    }
  }

  Sim newSim() {
    final p = Params();
    for (final e in params.entries) {
      applyParam(p, e.key, e.value);
    }
    final sg = nets ? Safeguards() : Safeguards.none();
    for (final k in sauf) {
      sg.set(k, false);
    }
    final s = Sim(seed: seed, params: p, modules: modules, safeguards: sg);
    if (noRandom) {
      // le drapeau joue dès la naissance des citoyens : la partie est refaite avec lui
      s.sansHasard = true;
      s.reset(seed: seed, params: p, modules: modules, safeguards: sg);
    }
    return s;
  }
}

String _dayName(int d) => 'instantane-j${d.toString().padLeft(5, '0')}.json';

Future<void> main(List<String> args) async {
  final o = _Opts(args);
  if (o.diff != null) {
    try {
      exitCode = await runDiff(o.diff![0], o.diff![1], o.passThrough);
    } on StateError catch (e) {
      stderr.writeln(e.message);
      exitCode = 2;
    }
    return;
  }
  final sw = Stopwatch()..start();
  final s = o.from != null
      ? simFromSnapshot((jsonDecode(File(o.from!).readAsStringSync()) as Map).cast<String, dynamic>())
      : o.newSim();
  if (o.from != null) stderr.writeln('Reprise de ${o.from} au jour ${s.day} (graine ${s.seed}).');

  IOSink? events, series;
  Tracer? tracer;
  if (o.trace != null) {
    Directory(o.trace!).createSync(recursive: true);
    events = File('${o.trace}/evenements.jsonl').openWrite();
    series = File('${o.trace}/series.csv').openWrite();
    tracer = Tracer(s, events: events, series: series, only: o.categories);
  }
  final snapDir = o.snapDir ?? o.trace ?? 'instantanes';
  if (o.every != null || o.at.isNotEmpty) Directory(snapDir).createSync(recursive: true);
  final digests = o.digests == null ? null : (File(o.digests!)..parent.createSync(recursive: true)).openWrite();
  var snaps = 0;
  void snapshot() {
    File('$snapDir/${_dayName(s.day)}').writeAsStringSync(jsonEncode(s.toSnapshot()));
    snaps++;
  }

  if (o.at.contains(s.day)) snapshot();
  while (s.day < o.days) {
    s.step();
    tracer?.afterStep();
    digests?.writeln(jsonEncode({'jour': s.day, 'empreintes': s.digest()}));
    if ((o.every != null && s.day % o.every! == 0) || o.at.contains(s.day)) snapshot();
  }
  await digests?.close();
  if (tracer != null) {
    tracer.detach();
    await events!.close();
    await series!.close();
    File('${o.trace}/agents_fin.csv').writeAsStringSync(tracer.agentsCsv());
    File('${o.trace}/entreprises.csv').writeAsStringSync(tracer.firmsCsv());
  }
  final h = s.history.last;
  stdout.writeln('Graine ${s.seed}, jour ${s.day} : chômage ${(h.unemp * 100).toStringAsFixed(1)} %, '
      '${h.hungry} affamés, ${h.homeless} sans logis, indice des prix ${h.cpi.toStringAsFixed(3)}, '
      'écart comptable ${s.inv.worst}.');
  if (tracer != null) stdout.writeln('Journaux : ${o.trace} (${tracer.eventsWritten} événements).');
  if (snaps > 0) stdout.writeln('$snaps instantané(s) dans $snapDir.');
  stdout.writeln('Temps : ${(sw.elapsedMilliseconds / 1000).toStringAsFixed(1)} s.');
}

// ------------------------------------------------------------------ --diff

/// Dossier d'une version du moteur : un dossier existant, « travail », ou une révision git extraite dans un dossier
/// temporaire (supprimé à la fin).
Future<(String, Future<void> Function())> _prepare(String v, Directory tmp, String tag) async {
  Future<void> none() async {}
  if (v == 'travail' || v == '.') return (Directory.current.path, none);
  if (Directory(v).existsSync()) {
    if (!File('$v/tool/partie.dart').existsSync()) throw StateError('$v ne contient pas tool/partie.dart');
    return (v, none);
  }
  final ok = await Process.run('git', ['rev-parse', '--verify', '$v^{commit}']);
  if (ok.exitCode != 0) throw StateError('Ni dossier ni révision git : $v');
  final dir = '${tmp.path}/$tag';
  final add = await Process.run('git', ['worktree', 'add', '--detach', dir, v]);
  if (add.exitCode != 0) throw StateError('git worktree add $v : ${add.stderr}');
  // les dépendances sont celles de ce dossier-ci : on reprend sa configuration de paquets
  Directory('$dir/.dart_tool').createSync(recursive: true);
  File('.dart_tool/package_config.json').copySync('$dir/.dart_tool/package_config.json');
  if (!File('$dir/tool/partie.dart').existsSync()) {
    await Process.run('git', ['worktree', 'remove', '--force', dir]);
    throw StateError('La révision $v ne contient pas tool/partie.dart : elle ne sait pas écrire ses empreintes');
  }
  return (dir, () async => Process.run('git', ['worktree', 'remove', '--force', dir]).then((_) {}));
}

Future<void> _run(String dir, List<String> args, String label) async {
  final r = await Process.run(Platform.resolvedExecutable, ['run', 'tool/partie.dart', ...args], workingDirectory: dir);
  if (r.exitCode != 0) throw StateError('Version $label ($dir) : échec\n${r.stdout}\n${r.stderr}');
}

List<Map<String, dynamic>> _readDigests(String path) => [
      for (final l in File(path).readAsLinesSync())
        if (l.isNotEmpty) (jsonDecode(l) as Map).cast<String, dynamic>(),
    ];

/// Chemins des feuilles qui diffèrent entre deux arbres JSON, dans l'ordre des clés de [a] (puis celles de [b] seul).
void treeDiff(Object? a, Object? b, String path, List<String> out, {int max = 40}) {
  if (out.length >= max) return;
  if (a is Map && b is Map) {
    for (final k in a.keys) {
      treeDiff(a[k], b.containsKey(k) ? b[k] : const _Missing(), path.isEmpty ? '$k' : '$path.$k', out, max: max);
    }
    for (final k in b.keys) {
      if (!a.containsKey(k)) treeDiff(const _Missing(), b[k], path.isEmpty ? '$k' : '$path.$k', out, max: max);
    }
    return;
  }
  if (a is List && b is List) {
    // citoyens, entreprises, alertes : appariés par identifiant (ou clé), pas par rang : une fermeture décale la liste
    final field = _keyField(a, b);
    if (field != null) {
      final mb = {for (final x in b) (x as Map)[field]: x};
      final ida = {for (final x in a) (x as Map)[field]};
      for (final x in a) {
        final id = (x as Map)[field];
        treeDiff(x, mb.containsKey(id) ? mb[id] : const _Missing(), '$path[$field=$id]', out, max: max);
      }
      for (final x in b) {
        final id = (x as Map)[field];
        if (!ida.contains(id)) treeDiff(const _Missing(), x, '$path[$field=$id]', out, max: max);
      }
      return;
    }
    for (var i = 0; i < a.length || i < b.length; i++) {
      treeDiff(i < a.length ? a[i] : const _Missing(), i < b.length ? b[i] : const _Missing(), '$path[$i]', out,
          max: max);
    }
    return;
  }
  if (a != b) out.add('$path : A = ${_show(a)} ; B = ${_show(b)}');
}

/// Le champ qui identifie les éléments de deux listes d'objets (« id », sinon « key »), s'il y en a un.
String? _keyField(List a, List b) {
  for (final f in const ['id', 'key']) {
    bool ok(List l) => l.every((x) => x is Map && x[f] != null);
    if ((a.isNotEmpty || b.isNotEmpty) && ok(a) && ok(b)) return f;
  }
  return null;
}

class _Missing {
  const _Missing();
}

String _show(Object? v) {
  if (v is _Missing) return '(absent)';
  if (v is Map || v is List) {
    final t = jsonEncode(v);
    return t.length > 80 ? '${t.substring(0, 77)}…' : t;
  }
  return jsonEncode(v);
}

Future<int> runDiff(String va, String vb, List<String> game) async {
  final tmp = Directory.systemTemp.createTempSync('econodes-diff-');
  final cleanups = <Future<void> Function()>[];
  try {
    final (da, ca) = await _prepare(va, tmp, 'A');
    cleanups.add(ca);
    final (db, cb) = await _prepare(vb, tmp, 'B');
    cleanups.add(cb);
    stdout.writeln('A : $va ($da)\nB : $vb ($db)\nPartie : ${game.isEmpty ? 'options par défaut' : game.join(' ')}');
    final fa = '${tmp.path}/A.jsonl', fb = '${tmp.path}/B.jsonl';
    await Future.wait([
      _run(da, [...game, '--empreintes', fa], 'A'),
      _run(db, [...game, '--empreintes', fb], 'B'),
    ]);
    final a = _readDigests(fa), b = _readDigests(fb);
    // les réglages (paramètres, modules, filets) se comparent à part : on cherche le jour où la partie elle-même diverge
    final settings = a.isNotEmpty && b.isNotEmpty && a[0]['empreintes']['reglages'] != b[0]['empreintes']['reglages'];
    int? day;
    var sections = <String>[];
    for (var i = 0; i < a.length && i < b.length; i++) {
      final ea = (a[i]['empreintes'] as Map), eb = (b[i]['empreintes'] as Map);
      final keys = {...ea.keys, ...eb.keys}.cast<String>().where((k) => k != 'reglages');
      sections = [for (final k in keys) if (ea[k] != eb[k]) k];
      if (sections.isNotEmpty) {
        day = a[i]['jour'] as int;
        break;
      }
    }
    if (settings) stdout.writeln('Réglages différents (voir plus bas).');
    if (day == null) {
      if (settings) {
        await _settingsDiff(da, db, game, tmp);
      }
      stdout.writeln(a.length == b.length
          ? 'Aucune divergence en ${a.length} jours : les deux versions donnent la même partie.'
          : 'Mêmes états sur ${a.length < b.length ? a.length : b.length} jours, puis une version s’arrête '
              '(${a.length} contre ${b.length} jours).');
      return 0;
    }
    stdout.writeln('Première divergence : jour $day, dans : ${sections.join(', ')}.');
    // les deux parties rejouées jusqu'à ce jour, état complet écrit, puis comparé variable par variable
    final sa = '${tmp.path}/sA', sb = '${tmp.path}/sB';
    final upTo = _withDays(game, day);
    await Future.wait([
      _run(da, [...upTo, '--snapshot-at', '$day', '--snapshot-dir', sa], 'A'),
      _run(db, [...upTo, '--snapshot-at', '$day', '--snapshot-dir', sb], 'B'),
    ]);
    final ja = jsonDecode(File('$sa/${_dayName(day)}').readAsStringSync());
    final jb = jsonDecode(File('$sb/${_dayName(day)}').readAsStringSync());
    _report(ja as Map, jb as Map);
    return 1;
  } finally {
    for (final c in cleanups) {
      await c();
    }
    tmp.deleteSync(recursive: true);
  }
}

const List<String> _settingKeys = ['params', 'modules', 'safeguards'];

/// Réglages, puis état : les premières variables qui diffèrent, dans l'ordre de l'instantané.
void _report(Map ja, Map jb) {
  final set = <String>[];
  for (final k in _settingKeys) {
    treeDiff(ja[k], jb[k], k, set);
  }
  if (set.isNotEmpty) {
    stdout.writeln('Réglages qui diffèrent :');
    for (final d in set) {
      stdout.writeln('  $d');
    }
  }
  final state = <String>[];
  treeDiff({for (final e in ja.entries) if (!_settingKeys.contains(e.key)) e.key: e.value},
      {for (final e in jb.entries) if (!_settingKeys.contains(e.key)) e.key: e.value}, '', state);
  stdout.writeln(state.isEmpty
      ? 'L’état est identique.'
      : 'Premières variables d’état qui diffèrent (dans l’ordre de l’instantané, ${state.length >= 40 ? '40 premières' : state.length}) :');
  for (final d in state) {
    stdout.writeln('  $d');
  }
}

/// Réglages différents sans divergence de la partie : on les montre à partir de l'état du premier jour.
Future<void> _settingsDiff(String da, String db, List<String> game, Directory tmp) async {
  final sa = '${tmp.path}/rA', sb = '${tmp.path}/rB';
  final upTo = _withDays(game, 1);
  await Future.wait([
    _run(da, [...upTo, '--snapshot-at', '1', '--snapshot-dir', sa], 'A'),
    _run(db, [...upTo, '--snapshot-at', '1', '--snapshot-dir', sb], 'B'),
  ]);
  final ja = jsonDecode(File('$sa/${_dayName(1)}').readAsStringSync()) as Map;
  final jb = jsonDecode(File('$sb/${_dayName(1)}').readAsStringSync()) as Map;
  final set = <String>[];
  for (final k in _settingKeys) {
    treeDiff(ja[k], jb[k], k, set);
  }
  stdout.writeln('Réglages qui diffèrent :');
  for (final d in set) {
    stdout.writeln('  $d');
  }
}

/// Les options de la partie, avec --jours remplacé.
List<String> _withDays(List<String> game, int day) {
  final out = <String>[];
  for (var i = 0; i < game.length; i++) {
    if ((game[i] == '--jours' || game[i] == '--days') && i + 1 < game.length) {
      i++;
      continue;
    }
    out.add(game[i]);
  }
  return [...out, '--jours', '$day'];
}
