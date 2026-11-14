// Sonde, lecture seule : ce que l'étranger achète (module Rénovation), par tranche de 500 jours.
//
//   dart run tool/exportations.dart graine population jours [--filets 0|1]
//
// Réglages de tool/derive.dart (interface, Produits, Bâtiments, Banques, Rénovation). Par tranche : exportations totales,
// et pour chaque bien de la filière du bâtiment (matériaux, heures des métiers, module) : valeur exportée, jours avec une
// commande étrangère, prix à l'export rapporté au prix d'ici et au coût unitaire des entreprises actives. Puis les cinq
// biens les plus exportés.

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
  const biens = ['planches', 'briques', 'tuyaux', 'fils', 'fusibles', 'charpente', 'electricite', 'plomberie', 'batiment'];
  final valeur = <String, double>{}, jours = <String, int>{}, ratioPrix = <String, List<double>>{};
  final ratioCout = <String, List<double>>{};
  var total = 0.0, fx = 0.0;
  for (var d = 1; d <= days; d++) {
    s.step();
    fx += s.fx;
    for (final e in s.flows.values) {
      if (e.to != 'X') continue;
      valeur[e.good] = (valeur[e.good] ?? 0) + e.value;
      total += e.value;
    }
    for (final g in biens) {
      final actives = [for (final f in s.firms) if (f.workers.isNotEmpty && f.outputs.containsKey(g)) f];
      if (actives.isEmpty) continue;
      if (actives.any((f) => s.foreignOrderOf(f, g) > 0)) jours[g] = (jours[g] ?? 0) + 1;
      final px = s.exportPrice(g);
      var prix = 0.0, cout = 0.0, n = 0;
      for (final f in actives) {
        final c = f.unitCostCache[g];
        if (c == null || c <= 0) continue;
        prix += f.price[g]!;
        cout += c;
        n++;
      }
      if (n > 0) {
        (ratioPrix[g] ??= []).add(px / (prix / n));
        (ratioCout[g] ??= []).add(px / (cout / n));
      }
    }
    if (d % 500 != 0) continue;
    double moy(List<double>? l) => l == null || l.isEmpty ? double.nan : l.reduce((x, y) => x + y) / l.length;
    print('jours ${d - 499}-$d : exportations ${f2(total / 500 / 1e3)} k\$/j, taux de change ${f2(fx / 500)}');
    for (final g in biens) {
      print('  $g : ${f2((valeur[g] ?? 0) / 500)} \$/j, commande ${jours[g] ?? 0} j, export/prix ${f2(moy(ratioPrix[g]))}, '
          'export/coût ${f2(moy(ratioCout[g]))}, jours actifs ${ratioPrix[g]?.length ?? 0}');
    }
    final top = valeur.entries.toList()..sort((x, y) => y.value.compareTo(x.value));
    print('  premiers : ${top.take(5).map((e) => '${e.key} ${f2(e.value / 500)}').join(', ')}');
    valeur.clear();
    jours.clear();
    ratioPrix.clear();
    ratioCout.clear();
    total = 0;
    fx = 0;
  }
}
