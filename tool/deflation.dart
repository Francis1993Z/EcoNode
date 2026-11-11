// Creux de déflation (anomalie N6), lecture seule : une partie aux réglages de l'interface, relevée par tranches de
// 50 jours. Décompose l'indice des prix : salaire, coût salarial par unité consommée, dépense et argent par secteur,
// qualification, machines ; et les biens qui font bouger l'indice.
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
  var prevPrices = Map<String, double>.from(s.history.last.prices);
  var prevBasket = 0.0;
  for (final e in s.cpiWeights.entries) {
    prevBasket += e.value * prevPrices[e.key]!;
  }
  for (var d = 1; d <= days; d++) {
    s.step();
    final h = s.history.last;
    spend += s.householdSpend;
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
    prevPrices = Map<String, double>.from(h.prices);
    prevBasket = basket;
    spend = cpiSum = wageBill = employed = unemp = 0;
  }
  print('RESUME ${jsonEncode({'graine': seed, 'population': pop, 'jours': days, 'options': a.skip(3).join(' '), 'series': series})}');
}
