// Suivi des entreprises nées pendant une partie, lecture seule : tous les 10 jours de leur vie, effectif, trésorerie,
// demande lissée, bénéfice lissé, prix face au moins cher des concurrents, propriétaire ; et la cause de leur fermeture.
//
//   dart run tool/demographie_suivi.dart graine population jours [premier_jour] [--param nom=valeur,...]
//
// Mêmes réglages que tool/demographie.dart (interface, Produits actif, filets actifs).

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

String f0(double v) => v.toStringAsFixed(0);
String f2(double v) => v.toStringAsFixed(2);

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final debut = a.length > 3 && !a[3].startsWith('--') ? int.parse(a[3]) : 30;
  final p = parametresInterface(pop);
  for (var i = 3; i < a.length; i++) {
    if (a[i] == '--param') {
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
        ..products = true);
  final connues = {for (final f in s.firms) f.id};
  final suivies = <int, Firm>{};
  final nees = <int, int>{};
  for (var d = 1; d <= days; d++) {
    s.step();
    final presentes = <int>{};
    for (final f in s.firms) {
      presentes.add(f.id);
      if (connues.add(f.id) && d >= debut && !s.publicService(f)) {
        suivies[f.id] = f;
        nees[f.id] = d;
        final concurrents = s.sellersOf(f.g0).where((x) => x.workers.isNotEmpty && !identical(x, f)).length;
        print('j$d NAISSANCE ${f.name} (${f.type}) capital ${f0(f.startCapital)} salaire ${f0(f.wage)} '
            'demande ${f2(f.demandEma[f.g0] ?? 0)} concurrents actifs $concurrents');
      }
    }
    for (final id in suivies.keys.toList()) {
      final f = suivies[id]!;
      final age = d - nees[id]!;
      if (!presentes.contains(id)) {
        print('j$d MORT ${f.name} à $age j : ${s.closeCause(f)} (dernière perte : ${f.lastLoss})');
        suivies.remove(id);
        continue;
      }
      if ((age > 12 && age % 10 != 0) || age > 400) continue;
      final g = f.g0;
      final autres = s.sellersOf(g).where((x) => x.workers.isNotEmpty && !identical(x, f)).map((x) => x.price[g]!);
      final pmin = autres.isEmpty ? 0.0 : autres.reduce((x, y) => x < y ? x : y);
      print('  ${f.name} âge $age : effectif ${f.workers.length}/${f.desired} caisse ${f0(f.money)} '
          'demande ${f2(f.demandEma[g] ?? 0)} vendu ${f2(f.sold[g] ?? 0)} prix ${f2(f.price[g]!)} '
          '(min concurrent ${f2(pmin)}, coût ${f2(f.unitCostCache[g] ?? 0)}) bénéfice lissé ${f0(f.profitEma)} '
          'dette ${f0(f.debt)} perte « ${f.lastLoss} » propriétaire ${f.ownerId}${f.ownerId == f.founderId ? ' (fondateur)' : ''}');
    }
  }
}
