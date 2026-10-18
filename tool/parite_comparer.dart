// Compare deux sorties de tool/parite_plateformes.sh (par exemple PC et serveur) et conclut : IDENTIQUE ou DIVERGENCE.
//
//   dart run tool/parite_comparer.dart <dossier A> <dossier B>
//
// - Instantanés et empreintes quotidiennes : octet pour octet. Pour un fichier d'empreintes qui diffère, le premier
//   jour et les parties de l'état qui divergent (citoyens, entreprises, marchés…) ; ensuite, pour situer la première
//   quantité qui diffère : tool/partie.dart --snapshot-at <jour> sur les deux machines, puis comparaison des états.
// - Sorties texte : au retour chariot près (print écrit CRLF sous Windows) et sans la ligne du dossier des instantanés
//   (un chemin propre à chaque machine).
// - Synthèse du niveau 0 : valeur par valeur, sans la date, la durée et le nombre d'isolats.
// Code de sortie : 0 si identique, 1 sinon.

import 'dart:convert';
import 'dart:io';

void main(List<String> args) {
  if (args.length != 2) {
    stderr.writeln('Usage : dart run tool/parite_comparer.dart <dossier A> <dossier B>');
    exit(2);
  }
  final da = args[0], db = args[1];
  var bad = 0;
  void say(String m) => stdout.writeln(m);

  List<String> files(String d) => [
        for (final e in Directory(d).listSync(recursive: true))
          if (e is File && (e.path.endsWith('.jsonl') || e.path.endsWith('.json') || e.path.endsWith('.txt')))
            e.path.substring(d.length + 1).replaceAll('\\', '/'),
      ]..removeWhere((p) => p == 'sha256.txt' || p == 'niveau0.json');
  final fa = files(da).toSet(), fb = files(db).toSet();
  for (final p in {...fa.difference(fb), ...fb.difference(fa)}) {
    bad++;
    say('ABSENT d’un côté : $p');
  }
  final common = fa.intersection(fb).toList()..sort();
  var same = 0;
  for (final p in common) {
    final ok = p.endsWith('.txt')
        ? _text(File('$da/$p')) == _text(File('$db/$p'))
        : _bytesEqual(File('$da/$p').readAsBytesSync(), File('$db/$p').readAsBytesSync());
    if (ok) {
      same++;
      continue;
    }
    bad++;
    say('DIFFÉRENT : $p');
    if (p.endsWith('.jsonl')) say('  ${_firstDivergence(File('$da/$p'), File('$db/$p'))}');
  }
  final snaps = common.where((p) => p.contains('instantane-')).length;
  final days = common.where((p) => p.endsWith('.jsonl')).fold(0, (a, p) => a + File('$da/$p').readAsLinesSync().length);
  say('$same / ${common.length} fichiers identiques ($snaps instantanés, $days jours d’empreintes).');

  final ja = jsonDecode(File('$da/niveau0.json').readAsStringSync()) as Map;
  final jb = jsonDecode(File('$db/niveau0.json').readAsStringSync()) as Map;
  for (final k in ['date', 'seconds', 'isolates']) {
    ja.remove(k);
    jb.remove(k);
  }
  final diffs = <String>[];
  var leaves = 0;
  void walk(Object? x, Object? y, String path) {
    if (x is Map && y is Map) {
      for (final k in {...x.keys, ...y.keys}) {
        walk(x[k], y[k], '$path.$k');
      }
    } else if (x is List && y is List) {
      if (x.length != y.length) diffs.add('$path : ${x.length} éléments / ${y.length}');
      for (var i = 0; i < x.length && i < y.length; i++) {
        walk(x[i], y[i], '$path[$i]');
      }
    } else {
      leaves++;
      if (x != y) diffs.add('$path : $x / $y');
    }
  }

  walk(ja, jb, '');
  say('Synthèse du niveau 0 : $leaves valeurs, ${diffs.length} différence(s).');
  for (final d in diffs.take(20)) {
    say('  $d');
  }
  bad += diffs.length;
  say(bad == 0 ? 'PARITÉ : IDENTIQUE' : 'PARITÉ : DIVERGENCE');
  exit(bad == 0 ? 0 : 1);
}

String _text(File f) => f
    .readAsStringSync()
    .replaceAll('\r', '')
    .split('\n')
    .where((l) => !l.contains('instantané(s) dans'))
    .join('\n');

bool _bytesEqual(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

String _firstDivergence(File a, File b) {
  final la = a.readAsLinesSync(), lb = b.readAsLinesSync();
  for (var i = 0; i < la.length && i < lb.length; i++) {
    if (la[i] == lb[i]) continue;
    final ea = (jsonDecode(la[i]) as Map), eb = (jsonDecode(lb[i]) as Map);
    final ka = ea['empreintes'] as Map, kb = eb['empreintes'] as Map;
    final parts = [for (final k in {...ka.keys, ...kb.keys}) if (ka[k] != kb[k]) k];
    return 'première divergence au jour ${ea['jour']}, dans : ${parts.join(', ')}';
  }
  return 'mêmes empreintes sur ${la.length < lb.length ? la.length : lb.length} jours, longueurs ${la.length} / ${lb.length}';
}
