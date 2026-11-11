// Creux de déflation (anomalie N6), lecture seule : une partie aux réglages de l'interface, relevée par tranches de
// 50 jours. Décompose l'indice des prix : salaire, coût salarial par unité consommée, dépense et argent par secteur,
// qualification, machines ; et les biens qui font bouger l'indice. Suit aussi l'argent entre ménages, entreprises et
// État par canal (flux du jour : achats, salaires, dividendes, capital…) et la trésorerie des entreprises par rapport
// à leurs réserves (8 jours de coûts pour le dividende, excessCashDays pour l'excédent).
//
//   dart run tool/deflation.dart graine population jours [--produits 0|1] [--batiments 0|1] [--param nom=valeur,...]
//
// Sortie : une ligne par tranche, puis « RESUME {json} » (une valeur par tranche pour chaque série).

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

String f1(double v) => v.toStringAsFixed(1);
String f2(double v) => v.toStringAsFixed(2);
String f3(double v) => v.toStringAsFixed(3);

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final p = parametresInterface(pop);
  var produits = true, batiments = false;
  for (var i = 3; i < a.length; i++) {
    switch (a[i]) {
      case '--produits':
        produits = a[++i] == '1';
      case '--batiments':
        batiments = a[++i] == '1';
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
        ..products = produits
        ..buildings = batiments);
  const pas = 50;
  final series = <String, List<double>>{};
  void put(String k, double v) => (series[k] ??= []).add(v);
  var spend = 0.0, cpiSum = 0.0, wageBill = 0.0, employed = 0.0, unemp = 0.0;
  // argent par canal : « payeur>bénéficiaire étiquette » (M ménages, E État, F entreprises, X extérieur, B banques)
  var canaux = <String, double>{};
  String cat(String id) => id == 'M' || id == 'E' || id == 'X' ? id : (int.tryParse(id) != null ? 'F' : 'B');
  var prevPrices = Map<String, double>.from(s.history.last.prices);
  var prevBasket = 0.0;
  for (final e in s.cpiWeights.entries) {
    prevBasket += e.value * prevPrices[e.key]!;
  }
  for (var d = 1; d <= days; d++) {
    s.step();
    final h = s.history.last;
    spend += s.householdSpend;
    for (final e in s.flows.values) {
      if (e.value <= 0) continue;
      // un flux de biens va du vendeur à l'acheteur : l'argent fait le chemin inverse
      final payer = e.isMoney ? e.from : e.to, payee = e.isMoney ? e.to : e.from;
      final x = cat(payer), y = cat(payee);
      if (x == y) continue;
      final k = '$x>$y ${e.isMoney ? e.good.substring(1) : 'achats'}';
      canaux[k] = (canaux[k] ?? 0) + e.value;
    }
    cpiSum += h.cpi;
    unemp += h.unemp;
    for (final c in s.citizens) {
      if (c.employer != null) {
        wageBill += c.wage;
        employed++;
      }
    }
    if (d % pas != 0) continue;
    final cpiAvg = cpiSum / pas, sp = spend / pas, wb = wageBill / pas, emp = employed / pas;
    // contributions des biens à la variation de l'indice sur la tranche (points de pourcentage)
    var basket = 0.0;
    final contrib = <String, double>{};
    for (final e in s.cpiWeights.entries) {
      basket += e.value * h.prices[e.key]!;
      contrib[e.key] = e.value * (h.prices[e.key]! - prevPrices[e.key]!) / prevBasket * 100;
    }
    final skill = s.citizens.fold(0.0, (x, c) => x + c.skill) / s.citizens.length;
    final active = s.firms.where((f) => f.workers.isNotEmpty).length;
    // argent des ménages qui ne dépensent pas : part des 10 % les plus riches
    final rich = [for (final c in s.citizens) c.money]..sort((x, y) => y.compareTo(x));
    final n10 = (rich.length / 10).ceil();
    final top10 = rich.take(n10).fold(0.0, (x, v) => x + v);
    put('jour', d.toDouble());
    put('ipc', h.cpi);
    put('ipcMoyen', cpiAvg);
    put('chomage', unemp / pas);
    put('salaire', emp > 0 ? wb / emp : 0);
    put('masseSalariale', wb);
    put('employes', emp);
    put('depense', sp);
    put('depenseReelle', sp / cpiAvg);
    // coût salarial par unité consommée (en unités du panier de départ) : masse salariale / dépense réelle
    put('coutUnitaire', wb / (sp / cpiAvg));
    put('menages', h.mH);
    put('entreprises', h.mF);
    put('etat', h.mE);
    put('banques', h.mB);
    put('total', h.total);
    put('vitesse', sp * 365 / h.total);
    put('top10', h.mH > 0 ? top10 / h.mH : 0);
    put('qualification', skill);
    put('machines', h.machines);
    put('tech', h.tech);
    put('actives', active.toDouble());
    final top = (contrib.entries.toList()..sort((x, y) => x.value.abs().compareTo(y.value.abs()))).reversed.take(4);
    print('j$d IPC ${f3(h.cpi)} (${f1((basket / prevBasket - 1) * 100)} %) chômage ${f1(unemp / pas * 100)} % '
        'salaire ${f1(emp > 0 ? wb / emp : 0)} dépense ${f1(sp / 1000)} k\$/j réelle ${f1(sp / cpiAvg / 1000)} k '
        'argent : ménages ${f2(h.mH / 1e6)} M entreprises ${f2(h.mF / 1e6)} M État ${f2(h.mE / 1e6)} M '
        'qualif ${f2(skill)} machines ${h.machines.round()} tech ${f2(h.tech)} actives $active ; '
        '${top.map((e) => '${e.key} ${e.value >= 0 ? '+' : ''}${f1(e.value)}').join(', ')}');
    for (final e in contrib.entries) {
      put('c_${e.key}', e.value);
    }
    // canaux de l'argent sur la tranche, par jour
    for (final e in canaux.entries) {
      put('f_${e.key}', e.value / pas);
    }
    // trésorerie des entreprises : publiques, sans propriétaire, privées sous la réserve du dividende (8 jours de coûts),
    // entre cette réserve et celle de l'excédent, au-delà
    var pub = 0.0, orphan = 0.0, below = 0.0, between = 0.0, above = 0.0, costs = 0.0;
    for (final f in s.firms) {
      final c = f.wage * f.workers.length + f.inputSpendEma + f.overheadEma;
      costs += c;
      if (s.publicService(f)) {
        pub += f.money;
      } else if (f.ownerId == null) {
        orphan += f.money;
      } else {
        final r8 = 8 * c + f.debt * 0.1 + f.reinvest, rx = p.excessCashDays * c + f.debt + f.reinvest;
        below += f.money < r8 ? f.money : r8;
        if (f.money > r8) between += (f.money < rx ? f.money : rx) - r8;
        if (f.money > rx) above += f.money - rx;
      }
    }
    put('tPubliques', pub);
    put('tSansProprio', orphan);
    put('tSousReserve', below);
    put('tEntreReserves', between);
    put('tExcedent', above);
    put('coutsJour', costs);
    final horsAchats = [
      for (final e in canaux.entries)
        if (e.key.startsWith('M>F') && !e.key.endsWith('achats')) '${e.key.substring(4)} ${f1(e.value / pas)}'
    ];
    print('     trésorerie : publiques ${f1(pub / 1000)} k, sans propriétaire ${f1(orphan / 1000)} k, sous 8 j '
        '${f1(below / 1000)} k, entre 8 j et ${p.excessCashDays.round()} j ${f1(between / 1000)} k, au-delà '
        '${f1(above / 1000)} k ; coûts ${f1(costs / 1000)} k\$/j ; ménages → entreprises hors achats : '
        '${horsAchats.join(', ')} \$/j');
    canaux = {};
    prevPrices = Map<String, double>.from(h.prices);
    prevBasket = basket;
    spend = cpiSum = wageBill = employed = unemp = 0;
  }
  print('RESUME ${jsonEncode({'graine': seed, 'population': pop, 'jours': days, 'options': a.skip(3).join(' '), 'series': series})}');
}
