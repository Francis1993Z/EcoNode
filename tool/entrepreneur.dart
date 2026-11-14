// Sonde, lecture seule : vie et mort des entrepreneurs généraux (module Rénovation).
//
//   dart run tool/entrepreneur.dart graine population jours [--filets 0|1]
//
// Réglages de tool/derive.dart (interface, Produits, Bâtiments, Banques, Rénovation).
// Tous les 250 jours : chantiers ouverts (bâtiments passés sous le seuil), modules demandés, vendus et manqués par jour,
// entrepreneurs actifs et leurs employés, état et âge du parc.
// À chaque fermeture d'un entrepreneur : son âge, la cause (Sim.closeCause), et ses 90 derniers jours avec employés :
// modules vendus et produits par jour, recettes et coûts par jour, trésorerie au début et à la fin, prix, coût unitaire,
// demande lissée, effectif voulu, stock.

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface;

String f1(double v) => v.toStringAsFixed(1);
String f2(double v) => v.toStringAsFixed(2);

class Jour {
  final int workers, desired;
  final double sold, produced, revenue, costs, money, price, cost, demand, inv, debt;
  Jour(this.workers, this.desired, this.sold, this.produced, this.revenue, this.costs, this.money, this.price, this.cost,
      this.demand, this.inv, this.debt);
}

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
  final suivis = <Firm, List<Jour>>{};
  var enCours = <int>{};
  var ouverts = 0, modulesOuverts = 0, vendus = 0.0, manques = 0.0, demandes = 0.0;
  for (var d = 1; d <= days; d++) {
    s.step();
    // chantiers ouverts aujourd'hui
    final now = <int>{};
    for (final b in s.buildings) {
      if (b.renoLeft > 0) {
        now.add(b.id);
        if (!enCours.contains(b.id)) {
          ouverts++;
          modulesOuverts += b.renoLeft;
        }
      }
    }
    enCours = now;
    manques += s.unmet['batiment'] ?? 0;
    // entrepreneurs
    for (final f in s.firms) {
      if (f.type != 'entrepreneur') continue;
      final l = suivis[f] ??= [];
      final sold = f.sold['batiment'] ?? 0;
      vendus += sold;
      l.add(Jour(f.workers.length, f.desired, sold, f.produced['batiment'] ?? 0, f.revenue, f.costs, f.money,
          f.price['batiment'] ?? 0, f.unitCostCache['batiment'] ?? 0, f.demandEma['batiment'] ?? 0, f.inv['batiment'] ?? 0,
          f.debt));
    }
    demandes = vendus + manques;
    final morts = [for (final f in suivis.keys) if (!s.firms.contains(f)) f];
    for (final f in morts) {
      final l = suivis.remove(f)!;
      final actifs = l.where((j) => j.workers > 0).toList();
      final der = actifs.length > 90 ? actifs.sublist(actifs.length - 90) : actifs;
      double moy(double Function(Jour) v) => der.isEmpty ? 0 : der.fold(0.0, (x, j) => x + v(j)) / der.length;
      final pic = l.fold(0, (x, j) => j.workers > x ? j.workers : x);
      print('  FERMETURE j$d ${f.name} : vécu ${l.length} j (dont ${actifs.length} avec employés, au plus $pic), '
          'cause ${s.closeCause(f)} (« ${f.lastLoss} ») ; 90 derniers jours avec employés : vendus ${f2(moy((j) => j.sold))}/j, '
          'produits ${f2(moy((j) => j.produced))}/j, recettes ${f1(moy((j) => j.revenue))}/j, coûts ${f1(moy((j) => j.costs))}/j, '
          'trésorerie ${der.isEmpty ? '-' : f1(der.first.money)} → ${der.isEmpty ? '-' : f1(der.last.money)}, '
          'prix ${f1(moy((j) => j.price))}, coût unitaire ${f1(moy((j) => j.cost))}, demande lissée ${f2(moy((j) => j.demand))}, '
          'effectif ${f2(moy((j) => j.workers.toDouble()))} voulu ${f2(moy((j) => j.desired.toDouble()))}, '
          'stock ${f2(moy((j) => j.inv))}, dette ${der.isEmpty ? '-' : f1(der.last.debt)}');
    }
    if (d % 250 != 0) continue;
    final eg = [for (final f in s.firms) if (f.type == 'entrepreneur') f];
    final done = s.buildings.where((b) => b.done).toList();
    final sous = done.where((b) => b.cond < s.params.renoTrigger).length;
    print('j$d : chantiers ouverts ${f2(ouverts / 250)}/j (${f2(modulesOuverts / 250)} modules/j), modules demandés '
        '${f2(demandes / 250)}/j, vendus ${f2(vendus / 250)}/j, manqués ${f2(manques / 250)}/j ; en attente ${enCours.length}, '
        'sous le seuil $sous ; entrepreneurs ${eg.length} (employés ${eg.fold(0, (x, f) => x + f.workers.length)}, '
        'actifs ${eg.where((f) => f.workers.isNotEmpty).length}) ; état du parc '
        '${f2(done.fold(0.0, (x, b) => x + b.cond) / done.length)}, prix du module ${f1(s.moduleCost())}');
    ouverts = modulesOuverts = 0;
    vendus = manques = demandes = 0;
  }
}
