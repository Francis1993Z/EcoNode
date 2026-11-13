// Chaîne de la rénovation (module renovation), lecture seule : une partie aux réglages de l'interface avec Bâtiments, le
// module actif ; tous les 50 jours, l'état de chaque entreprise des métiers du bâtiment (employés, postes ouverts,
// trésorerie, prix, ventes, demande, stock, bénéfice lissé), et chaque événement qui les nomme (fermeture, renflouement,
// plus d'employés).
//
//   dart run tool/chaine.dart graine population jours [--banques 0|1] [--param nom=valeur,...]

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

String f0(double v) => v.toStringAsFixed(0);
String f1(double v) => v.toStringAsFixed(1);

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final p = parametresInterface(pop);
  var banques = true;
  for (var i = 3; i < a.length; i++) {
    switch (a[i]) {
      case '--banques':
        banques = a[++i] == '1';
      case '--param':
        for (final kv in a[++i].split(',')) {
          final j = kv.indexOf('=');
          regler(p, kv.substring(0, j), kv.substring(j + 1));
        }
    }
  }
  final s = Sim(
      seed: seed,
      params: p,
      modules: Modules()
        ..jobs = true
        ..entrepreneurship = true
        ..products = true
        ..buildings = true
        ..banking = banques
        ..renovation = true);
  bool watched(Firm f) => renovationTypes.contains(f.type);
  final seen = <String>{};
  final sold = <int, double>{};
  for (var d = 1; d <= days; d++) {
    s.step();
    for (final f in s.firms) {
      if (watched(f)) sold[f.id] = (sold[f.id] ?? 0) + (f.sold[f.g0] ?? 0);
    }
    for (final e in s.events) {
      if (e.day != s.day) continue;
      final hit = s.firms.where(watched).any((f) => e.text.contains(f.name)) ||
          (e.text.contains('ferme') && renovationTypes.any((t) => e.text.contains(templates[t]!.label)));
      if (hit && seen.add('${e.day} ${e.text}')) print('j${e.day} [${e.type}] ${e.text}');
    }
    if (d % 50 != 0) continue;
    print('j$d module ${f0(s.bestPrice('batiment'))} \$ ; rénovations en cours ${s.buildings.where((b) => b.renoLeft > 0).length}');
    for (final f in s.firms.where(watched)) {
      final g = f.g0;
      print('   ${f.template.code} ${f.name} : employés ${f.workers.length} postes ${f.vacancies} trésorerie ${f0(f.money)} '
          'prix ${f1(f.price[g]!)} ventes ${f1((sold[f.id] ?? 0) / 50)}/j demande ${f1(f.demandEma[g] ?? 0)} '
          'stock ${f1(f.inv[g] ?? 0)} bénéfice ${f1(f.profitEma)} salaire ${f0(f.wage)} offre ${f0(f.offer)} '
          'non pourvus ${f.unfilledDays} j');
      sold[f.id] = 0;
    }
  }
}
