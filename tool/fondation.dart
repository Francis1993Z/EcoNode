// Pourquoi personne ne fonde d'entreprise d'un type (lecture seule) : une partie aux réglages de l'interface avec
// Produits, Bâtiments, Banques et le module renovation ; tous les 50 jours, si le type n'a plus d'entreprise active, le
// projet tel qu'un citoyen l'évaluerait (Sim._bestProject) : demande non servie et signal de renaissance, équipe,
// chômeurs disponibles, recette, coût du travail et des intrants, viabilité, capital exigé, citoyens qui en ont la mise.
//
//   dart run tool/fondation.dart graine population jours [type]      (type : entrepreneur par défaut)

import 'dart:math' as math;

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface;

String f0(double v) => v.toStringAsFixed(0);
String f2(double v) => v.toStringAsFixed(2);

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final ty = a.length > 3 ? a[3] : 'entrepreneur';
  final p = parametresInterface(pop);
  final s = Sim(
      seed: seed,
      params: p,
      modules: Modules()
        ..jobs = true
        ..entrepreneurship = true
        ..products = true
        ..buildings = true
        ..banking = true
        ..renovation = true);
  final t = templates[ty]!;
  final g = t.outputs.keys.first;
  for (var d = 1; d <= days; d++) {
    s.step();
    for (final e in s.events) {
      if (e.day == s.day && e.text.contains(t.label) && (e.text.contains('fonde') || e.text.contains('ferme'))) {
        print('j${e.day} ${e.text}');
      }
    }
    if (d % 50 != 0) continue;
    final active = s.firms.where((f) => f.type == ty && f.workers.isNotEmpty).length;
    if (active > 0) continue;
    var want = s.entryWant(g);
    final rw = p.revival ? s.revivalWant(g) : 0.0;
    if (p.revival) want = math.max(want, rw);
    final perWorker0 = t.rate * t.outputs[g]!;
    final w = want / t.outputs[g]! / t.rate;
    final team = w.ceil().clamp(1, 3).toInt();
    final batches = s.projectBatches(ty, want, team);
    final wage = s.marketOffer(t.skill) * avgRoleRel(ty);
    var inputCost = 0.0;
    final prices = <String>[];
    for (final e in t.inputs.entries) {
      inputCost += batches * e.value * s.bestPrice(e.key);
      prices.add('${e.key} ${f0(s.bestPrice(e.key))}');
    }
    var revenue0 = 0.0;
    for (final e in t.outputs.entries) {
      revenue0 += batches * e.value * s.projectPrice(ty, e.key);
    }
    final labour = p.revival ? s.entryLabour(g, w, team, wage) : team * wage;
    final viable = revenue0 >= 1.1 * (labour + inputCost);
    final capital = p.entCapitalMult * (10 * wage * team + 5 * inputCost);
    final buffer = p.bufferDays * s.needCost;
    final rich = s.citizens.where((c) => c.money - buffer >= p.entMinOwnShare * capital).length;
    final idle = s.citizens.where((c) => c.employer == null && c.skill + 1e-9 >= t.skill).length;
    print('j$d aucun ${t.label} actif : demande non servie ${f2(s.entryWant(g))} (renaissance ${f2(rw)}) /j, seuil '
        '${f2(p.entryMinShare * perWorker0)} ; équipe $team, chômeurs admissibles $idle ; lots ${f2(batches)} ; '
        'recette ${f0(revenue0)} \$/j contre travail ${f0(labour)} + intrants ${f0(inputCost)} (${viable ? 'viable' : 'pas viable'}) ; '
        'capital ${f0(capital)} \$, citoyens qui ont la mise : $rich ; prix ${prices.join(', ')} ; '
        'module ${f0(s.bestPrice(g))} (départ ${f0(s.worldPrice[g]!)}) ; en attente ${s.buildings.where((b) => b.renoLeft > 0).length}');
  }
}
