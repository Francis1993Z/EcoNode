// Dérive longue (anomalie N16), lecture seule : relevé tous les 250 jours d'une partie aux réglages de l'interface.
//
//   dart run tool/derive.dart graine population jours [--produits 0|1] [--batiments 0|1] [--banques 0|1]
//        [--param nom=valeur,...]
//
// Sortie : une ligne par relevé, puis « RESUME {json} » avec les moyennes de chaque tranche de 500 jours (chômage, prix,
// salaire, argent des ménages et des entreprises).

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

String f1(double v) => v.toStringAsFixed(1);
String f2(double v) => v.toStringAsFixed(2);

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final p = parametresInterface(pop);
  var produits = true, batiments = false, banques = false;
  for (var i = 3; i < a.length; i++) {
    switch (a[i]) {
      case '--produits':
        produits = a[++i] == '1';
      case '--batiments':
        batiments = a[++i] == '1';
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
        ..products = produits
        ..buildings = batiments
        ..banking = banques);
  // moyennes par tranche de 500 jours
  final tranches = <int, Map<String, double>>{};
  var u = 0.0;
  for (var d = 1; d <= days; d++) {
    s.step();
    final h = s.history.last;
    u += h.unemp;
    final t = (d - 1) ~/ 500;
    final m = tranches[t] ??= {};
    void add(String k, double v) => m[k] = (m[k] ?? 0) + v / 500;
    add('chomage', h.unemp);
    add('ipc', h.cpi);
    add('salaire', h.wage);
    if (d % 10 == 0) {
      var hh = 0.0, fm = 0.0;
      for (final c in s.citizens) {
        hh += c.money;
      }
      for (final f in s.firms) {
        fm += f.money;
      }
      add('menages', hh * 10);
      add('entreprises', fm * 10);
      add('machines', s.firms.fold(0.0, (x, f) => x + f.machines) * 10);
      add('actives', s.firms.where((f) => f.workers.isNotEmpty).length * 10.0);
    }
    if (d % 250 != 0) continue;
    final moneys = [for (final c in s.citizens) c.money]..sort();
    var hh = 0.0, fm = 0.0, debt = 0.0;
    for (final c in s.citizens) {
      hh += c.money;
    }
    for (final f in s.firms) {
      fm += f.money;
      debt += f.debt;
    }
    final act = s.firms.where((f) => f.workers.isNotEmpty).length;
    final mach = s.firms.fold(0.0, (x, f) => x + f.machines);
    print('j$d chômage ${f1(u / 250 * 100)} % IPC ${f2(h.cpi)} salaire ${f1(h.wage)} ; argent : ménages ${f2(hh / 1e6)} M '
        '(médiane ${f1(moneys[moneys.length ~/ 2])}), entreprises ${f2(fm / 1e6)} M, État ${f2(s.state.money / 1e6)} M, '
        'dettes des entreprises ${f2(debt / 1e6)} M ; entreprises actives $act, machines ${mach.round()}, '
        'variétés ${s.products.values.where((pr) => pr.alive).length}');
    u = 0;
  }
  final out = {
    'graine': seed,
    'population': pop,
    'jours': days,
    'options': a.skip(3).join(' '),
    'tranches': {
      for (final e in tranches.entries) '${e.key * 500 + 1}-${(e.key + 1) * 500}': e.value,
    },
  };
  print('RESUME ${jsonEncode(out)}');
}
