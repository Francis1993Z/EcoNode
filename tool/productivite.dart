// Sonde, lecture seule : productivité de la filière du bâtiment (module Rénovation) comparée au reste de l'économie.
//
//   dart run tool/productivite.dart graine population jours [--filets 0|1]
//
// Réglages de tool/derive.dart (interface, Produits, Bâtiments, Banques, Rénovation). Tous les 500 jours, par type de la
// filière puis pour toutes les entreprises : entreprises avec employés, employés, niveau technologique moyen, gain des
// machines (machineMult), gain technologique (techMult), lots par employé rapportés au taux de base du gabarit
// (perWorker / rate), et utilisation (lots produits / lots que l'équipe pourrait produire). Puis la part de l'emploi de la
// filière.

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface;

String f2(double v) => v.toStringAsFixed(2);

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final filets = !(a.length > 4 && a[3] == '--filets' && a[4] == '0');
  final s = Sim(
      seed: seed,
      params: parametresInterface(pop),
      modules: Modules()
        ..jobs = true
        ..entrepreneurship = true
        ..products = true
        ..buildings = true
        ..banking = true
        ..renovation = true,
      safeguards: filets ? Safeguards() : Safeguards.none());
  // cumul sur la tranche : par type, somme des lots produits et de la capacité
  final prod = <String, double>{}, cap = <String, double>{};
  for (var d = 1; d <= days; d++) {
    s.step();
    for (final f in s.firms) {
      if (f.workers.isEmpty) continue;
      final g = f.g0;
      final batch = f.outputs[g]!;
      prod[f.type] = (prod[f.type] ?? 0) + (f.produced[g] ?? 0) / batch;
      cap[f.type] = (cap[f.type] ?? 0) + f.workers.length * s.perWorker(f);
    }
    if (d % 500 != 0) continue;
    print('jour $d');
    String ligne(String nom, Iterable<Firm> fs, Iterable<String> types) {
      final l = fs.where((f) => f.workers.isNotEmpty).toList();
      if (l.isEmpty) return '  $nom : aucune';
      double moy(double Function(Firm) v) => l.fold(0.0, (x, f) => x + v(f)) / l.length;
      final p = types.fold(0.0, (x, t) => x + (prod[t] ?? 0)), c = types.fold(0.0, (x, t) => x + (cap[t] ?? 0));
      return '  $nom : ${l.length} entr., ${l.fold(0, (x, f) => x + f.workers.length)} employés, niveau tech '
          '${f2(moy((f) => f.techLevel.toDouble()))}, machines ×${f2(moy(s.machineMult))}, tech ×${f2(moy(s.techMult))}, '
          'lots/employé ÷ base ${f2(moy((f) => s.perWorker(f) / f.template.rate))}, utilisation ${c > 0 ? f2(p / c) : '-'}';
    }
    for (final t in renovationTypes) {
      print(ligne(t, s.firms.where((f) => f.type == t), [t]));
    }
    final types = s.firms.map((f) => f.type).toSet();
    print(ligne('toutes', s.firms, types));
    final emplois = s.firms.fold(0, (x, f) => x + f.workers.length);
    final bat = s.firms.where((f) => renovationTypes.contains(f.type)).fold(0, (x, f) => x + f.workers.length);
    print('  emploi de la filière du bâtiment : $bat sur $emplois (${f2(100 * bat / emplois)} %)');
    prod.clear();
    cap.clear();
  }
}
