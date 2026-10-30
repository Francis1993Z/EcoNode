// Disparition des filières (anomalie A2) : pour chaque bien, le premier jour où il n'a plus aucun producteur actif
// (entreprise qui le produit et qui a au moins un employé), et s'il en a encore un à la fin.
//
//   dart run tool/filieres.dart --population 240 --graines 10 --jours 1500 [--modules ...] [--param ...] [--filets 0|1]
//                               [--causes]
//
// Sortie : une ligne par graine et par bien éteint (jour de la première extinction, producteur à la fin ou non), puis un
// résumé par bien : graines où il s'est éteint, jours (minimum, médiane, maximum), graines où il est revenu.
//
// --causes : en plus, pour chaque bien, les jours passés sans producteur, le nombre de renaissances (passages de « aucun
// producteur actif » à « au moins un »), et, chaque jour sans producteur, la première condition de la création
// automatique (`Sim._entryExit`, `_found`) qui manque pour le type d'entreprise dont c'est le premier produit :
//   signal_import   pas de demande non servie : les ménages et les entreprises achètent tout à l'étranger
//   signal_aucun    pas de demande non servie, et personne n'en achète (les clients du bien ont disparu aussi)
//   main_oeuvre     pas assez de chômeurs qualifiés pour l'équipe
//   viabilite       au prix du marché, les ventes attendues ne paient pas l'équipe et ses intrants
//   frais_fixes     Params.revivalFullCost : elles les paient, mais pas avec les frais fixes attendus de la relance
//   prix_import     Params.revivalFullCost : le prix de départ de la relance dépasserait le prix d'import
//   capital         aucun citoyen n'a l'épargne voulue
//   possible        toutes les conditions sont remplies (délai entre deux créations, une création par jour, ou création
//                   du jour même)
//   public          service public (l'État le fournit, pas de création privée)
// Le relevé lit l'état du soir, après la journée : c'est la règle mécanique, pas celle du module entrepreneurship (qui
// partage le même signal, la demande non servie). Avec Params.revival, le signal est celui de la renaissance
// (`Sim.revivalWant` : demande non servie, importations ou demande dérivée).
import 'dart:io';
import 'dart:math' as math;

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'stabilite.dart' show applyParam;

/// Cas « viabilite » (mesure) : par bien, rapports ventes attendues ÷ (1,1 × coût de l'équipe et des intrants), et
/// signal en part de la production d'un employé.
final Map<String, List<double>> viabRatio = {}, viabWant = {};

const _causes = [
  'signal_import', 'signal_aucun', 'main_oeuvre', 'viabilite', 'frais_fixes', 'prix_import', 'capital', 'possible',
  'public',
];

/// Première condition de la création automatique qui manque pour ce type d'entreprise (voir l'en-tête).
String entryCause(Sim s, String ty) {
  final p = s.params;
  final t = templates[ty]!;
  final g = t.outputs.keys.first;
  if (s.publicGood(g)) return 'public';
  final diff = s.productsActive && isDifferentiated(g);
  var want = diff ? math.max(0.0, s.entryWant(g)) : (s.unmetEma[g] ?? 0);
  if (p.revival) want = math.max(want, s.revivalWant(g)); // Params.revival : signal de renaissance
  final perWorker0 = t.rate * t.outputs[g]!;
  if (want < p.entryMinShare * perWorker0) {
    return (s.marketStats[g]?.qty ?? 0) > 1e-9 ? 'signal_import' : 'signal_aucun';
  }
  final batches = want / t.outputs[g]!;
  final w = batches / t.rate;
  final team = w.ceil().clamp(1, 3).toInt();
  final wage = s.modules.jobs ? s.marketOffer(t.skill) * avgRoleRel(ty) : s.marketWage(t.skill);
  var inputCost = 0.0;
  for (final e in t.inputs.entries) {
    inputCost += batches * e.value * s.bestPrice(e.key);
  }
  final available = s.citizens.where((c) => c.employer == null && c.skill + 1e-9 >= t.skill).length;
  if (available < team) return 'main_oeuvre';
  var revenue0 = 0.0;
  for (final e in t.outputs.entries) {
    revenue0 += batches * e.value * math.min(s.bestPrice(e.key), 2 * s.worldPrice[e.key]!);
  }
  final labour = s.entryLabour(g, w, team, wage); // Params.revivalHours : heures nécessaires d'une relance
  if (revenue0 < 1.1 * (labour + inputCost)) {
    (viabRatio[g] ??= []).add(revenue0 / (1.1 * (labour + inputCost)));
    (viabWant[g] ??= []).add(want / perWorker0);
    return 'viabilite';
  }
  // Params.revivalFullCost : frais fixes et prix de départ face à l'import
  final full = s.revivalCostRefusal(ty, w, team, wage, labour, inputCost, revenue0, 0);
  if (full != null) return full == 'viabilite' ? 'frais_fixes' : full;
  final capital = 10 * wage * team + 5 * inputCost;
  final buffer = p.bufferDays * s.needCost;
  if (!s.citizens.any((c) => c.money - buffer >= 1.5 * capital)) return 'capital';
  return 'possible';
}

void main(List<String> args) {
  var pop = 240, seeds = 10, days = 1500;
  var nets = true, causes = false;
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
      case '--causes':
        causes = true;
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
  final deadDays = <String, int>{}; // bien -> jours sans producteur actif (toutes graines)
  final revivals = <String, int>{}; // bien -> renaissances (toutes graines)
  final why = <String, Map<String, int>>{}; // bien -> cause -> jours
  for (var g = 1; g <= seeds; g++) {
    final p = Params()..population = pop;
    for (final e in params.entries) {
      applyParam(p, e.key, e.value);
    }
    final s = Sim(seed: g, params: p, modules: modules.copy(), safeguards: nets ? Safeguards() : Safeguards.none());
    final produced = <String>{for (final f in s.firms) ...f.outputs.keys};
    // type d'entreprise dont le bien est le premier produit (celui que lit la création automatique)
    final maker = <String, String>{
      for (final e in templates.entries)
        if (produced.contains(e.value.outputs.keys.first)) e.value.outputs.keys.first: e.key
    };
    final first = <String, int>{};
    final dead = <String>{};
    for (var d = 1; d <= days; d++) {
      s.step();
      for (final good in produced) {
        final alive = s.firms.any((f) => f.outputs.containsKey(good) && f.workers.isNotEmpty);
        if (!alive) {
          first.putIfAbsent(good, () => d);
          if (causes) {
            deadDays[good] = (deadDays[good] ?? 0) + 1;
            final ty = maker[good];
            final c = ty == null ? 'coproduit' : entryCause(s, ty);
            final m = why[good] ??= {};
            m[c] = (m[c] ?? 0) + 1;
          }
          dead.add(good);
        } else if (dead.remove(good)) {
          revivals[good] = (revivals[good] ?? 0) + 1;
        }
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
      'modules coupés ${Modules.keys.where((k) => !modules.get(k)).join(', ')}'
      '${params.isEmpty ? '' : ', ${params.entries.map((e) => '${e.key}=${e.value}').join(', ')}'}) :');
  final keys = gone.keys.toList()..sort((a, b) => gone[b]!.length.compareTo(gone[a]!.length));
  for (final k in keys) {
    final v = gone[k]!..sort();
    stdout.writeln('  ${(goods[k]?.label ?? k).padRight(22)} éteint dans ${v.length}/$seeds graines, jours ${v.first} / '
        '${v[v.length ~/ 2]} / ${v.last} (min / médiane / max), revenu à la fin dans ${back[k] ?? 0}');
  }
  if (!causes) return;
  final total = seeds * days;
  final dk = deadDays.keys.toList()..sort((a, b) => deadDays[b]!.compareTo(deadDays[a]!));
  var sum = 0;
  for (final k in dk) {
    sum += deadDays[k]!;
  }
  stdout.writeln('\nJours sans producteur actif et causes (part des jours sans producteur) ; '
      'total ${(100 * sum / total).toStringAsFixed(1)} jours-biens pour 100 jours :');
  stdout.writeln('  ${'bien'.padRight(22)} ${'jours'.padLeft(6)} ${'%'.padLeft(5)} ${'renais.'.padLeft(7)}  '
      '${[..._causes, 'coproduit'].map((c) => c.padLeft(13)).join()}   viabilité : ventes/coût, signal/employé (médianes)');
  for (final k in dk) {
    final n = deadDays[k]!;
    final m = why[k] ?? {};
    stdout.writeln('  ${(goods[k]?.label ?? k).padRight(22)} ${'$n'.padLeft(6)} '
        '${(100 * n / total).toStringAsFixed(0).padLeft(5)} ${'${revivals[k] ?? 0}'.padLeft(7)}  '
        '${[..._causes, 'coproduit'].map((c) => (m[c] == null ? '·' : '${(100 * m[c]! / n).toStringAsFixed(0)} %').padLeft(13)).join()}'
        '${viabRatio[k] == null ? '' : '   ${_median(viabRatio[k]!).toStringAsFixed(2)}, ${_median(viabWant[k]!).toStringAsFixed(2)}'}');
  }
}

double _median(List<double> l) => (List<double>.of(l)..sort())[l.length ~/ 2];
