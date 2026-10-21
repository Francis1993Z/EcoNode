// Disparition des filières (anomalie A2) : pour chaque bien, le premier jour où il n'a plus aucun producteur actif
// (entreprise qui le produit et qui a au moins un employé), et s'il en a encore un à la fin.
//
//   dart run tool/filieres.dart --population 240 --graines 10 --jours 1500 [--modules ...] [--param ...] [--filets 0|1]
//
// Sortie : une ligne par graine et par bien éteint (jour de la première extinction, producteur à la fin ou non), puis un
// résumé par bien : graines où il s'est éteint, jours (minimum, médiane, maximum), graines où il est revenu.
import 'dart:io';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'stabilite.dart' show applyParam;

void main(List<String> args) {
  var pop = 240, seeds = 10, days = 1500;
  var nets = true;
  final modules = Modules();
  final params = <String, String>{};
  for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--population':
        pop = int.parse(args[++i]);
      case '--graines':
        seeds = int.parse(args[++i]);
      case '--jours':
        days = int.parse(args[++i]);
      case '--filets':
        nets = args[++i] != '0';
      case '--modules':
        for (final kv in args[++i].split(',')) {
          final p = kv.split('=');
          modules.set(p[0], p.length < 2 || p[1] != '0');
        }
      case '--param':
        for (final kv in args[++i].split(',')) {
          final j = kv.indexOf('=');
          params[kv.substring(0, j)] = kv.substring(j + 1);
        }
      default:
        throw ArgumentError('Option inconnue : ${args[i]}');
    }
  }
  final gone = <String, List<int>>{}; // bien -> jours d'extinction (une valeur par graine éteinte)
  final back = <String, int>{}; // bien -> graines où il a de nouveau un producteur à la fin
  for (var g = 1; g <= seeds; g++) {
    final p = Params()..population = pop;
    for (final e in params.entries) {
      applyParam(p, e.key, e.value);
    }
    final s = Sim(seed: g, params: p, modules: modules.copy(), safeguards: nets ? Safeguards() : Safeguards.none());
    final produced = <String>{for (final f in s.firms) ...f.outputs.keys};
    final first = <String, int>{};
    for (var d = 1; d <= days; d++) {
      s.step();
      for (final good in produced) {
        if (first.containsKey(good)) continue;
        if (!s.firms.any((f) => f.outputs.containsKey(good) && f.workers.isNotEmpty)) first[good] = d;
      }
    }
    for (final e in first.entries) {
      final alive = s.firms.any((f) => f.outputs.containsKey(e.key) && f.workers.isNotEmpty);
      stdout.writeln('graine $g : ${e.key.padRight(14)} éteint au jour ${e.value}${alive ? ' (de nouveau produit à la fin)' : ''}');
      (gone[e.key] ??= []).add(e.value);
      if (alive) back[e.key] = (back[e.key] ?? 0) + 1;
    }
  }
  stdout.writeln('\nRésumé ($pop citoyens, $seeds graines × $days jours, filets ${nets ? 'actifs' : 'coupés'}, '
      'modules coupés ${Modules.keys.where((k) => !modules.get(k)).join(', ')}) :');
  final keys = gone.keys.toList()..sort((a, b) => gone[b]!.length.compareTo(gone[a]!.length));
  for (final k in keys) {
    final v = gone[k]!..sort();
    stdout.writeln('  ${(goods[k]?.label ?? k).padRight(22)} éteint dans ${v.length}/$seeds graines, jours ${v.first} / '
        '${v[v.length ~/ 2]} / ${v.last} (min / médiane / max), revenu à la fin dans ${back[k] ?? 0}');
  }
}
