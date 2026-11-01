// Émergence du module Produits (anomalie N2), lecture seule : lancements et disparitions de variétés, concentration des
// ventes, marge des vendeurs en place, connaissance des ménages, avec les réglages de l'interface.
//
//   dart run tool/emergence.dart graine population jours [--param nom=valeur,...] [--batiments 1]
//
// Sortie : une ligne de relevé tous les 100 jours, puis une ligne « RESUME {json} » (moyennes des jours après 300).

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'stabilite.dart' show applyParam;

/// Catégories différenciées vendues aux ménages (les machines sont à part : achetées par les entreprises).
const List<String> categories = ['pain', 'viande', 'repas', 'tele', 'loisirs', 'hotel', 'voyage', 'bijoux', 'ordinateur'];

/// Réglages de l'interface (SimController) à la date de l'outil.
Params parametresInterface(int population) => Params()
  ..population = population
  ..policyPassThrough = true
  ..tradeWaves = true
  ..floatingFx = true
  ..foreignDemand = true
  ..revival = true
  ..revivalPlannedDemand = true
  ..excessCashReturn = true
  ..publicImports = true
  ..stateBorrowing = true
  ..normalUtil = 0.5
  ..leases = true
  ..equalBanks = true
  ..purchaseLoans = true
  ..jointCostBySales = true
  ..walletAtTarget = true
  ..planFromHouseholds = true
  ..spreadHealth = true
  ..planWorkforce = true
  ..ownersAtStart = true
  ..reservePerCitizen = 2000;

/// Leviers du module Produits et de l'entrepreneuriat (absents du protocole de stabilité), puis ceux du protocole.
void regler(Params p, String nom, String valeur) {
  final v = double.parse(valeur);
  switch (nom) {
    case 'prodEntryMargin':
      p.prodEntryMargin = v;
    case 'prodAdRate':
      p.prodAdRate = v;
    case 'prodWordRate':
      p.prodWordRate = v;
    case 'prodForgetDays':
      p.prodForgetDays = v.round();
    case 'prodKnownMax':
      p.prodKnownMax = v.round();
    case 'prodHabit':
      p.prodHabit = v;
    case 'prodQualityWeight':
      p.prodQualityWeight = v;
    case 'prodPriceSens':
      p.prodPriceSens = v;
    case 'entFoundRate':
      p.entFoundRate = v;
    case 'entCapitalMult':
      p.entCapitalMult = v;
    default:
      applyParam(p, nom, valeur);
  }
}

String f1(double v) => v.toStringAsFixed(1);
String f2(double v) => v.toStringAsFixed(2);

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final p = parametresInterface(pop);
  var batiments = false;
  for (var i = 3; i < a.length; i++) {
    if (a[i] == '--param') {
      for (final kv in a[++i].split(',')) {
        final j = kv.indexOf('=');
        regler(p, kv.substring(0, j), kv.substring(j + 1));
      }
    } else if (a[i] == '--batiments') {
      batiments = a[++i] == '1';
    }
  }
  final s = Sim(
      seed: seed,
      params: p,
      modules: Modules()
        ..jobs = true
        ..entrepreneurship = true
        ..products = true
        ..buildings = batiments);

  var seen = {for (final pr in s.products.values) pr.id};
  final ventes = {for (final g in categories) g: <int, double>{}};
  // cumuls après le jour 300
  var n = 0, launches = 0, ends = 0;
  final sum = <String, double>{};
  void add(String k, double v) => sum[k] = (sum[k] ?? 0) + v;
  var launchWin = 0, endWin = 0;
  for (var d = 1; d <= days; d++) {
    s.step();
    for (final pr in s.products.values) {
      if (pr.category == 'machines') continue;
      if (!seen.contains(pr.id)) {
        seen.add(pr.id);
        launchWin++;
        if (d > 300) launches++;
      }
    }
    for (final g in categories) {
      for (final f in s.sellersOf(g)) {
        final q = f.sold[g] ?? 0;
        if (q > 0) ventes[g]![f.id] = (ventes[g]![f.id] ?? 0) + q;
      }
    }
    if (d % 100 != 0) continue;
    // disparitions de la fenêtre
    var deadNow = 0;
    for (final pr in s.products.values) {
      if (pr.category != 'machines' && !pr.alive && pr.ended != null && pr.ended! > d - 100) deadNow++;
    }
    endWin = deadNow;
    if (d > 300) ends += deadNow;
    var sellers = 0.0, alive = 0.0, hhi = 0.0, top = 0.0, margin = 0.0, nm = 0, blocked = 0;
    for (final g in categories) {
      sellers += s.sellersOf(g).where((f) => f.workers.isNotEmpty).length;
      alive += s.products.values.where((pr) => pr.alive && pr.category == g).length;
      final m = ventes[g]!;
      final tot = m.values.fold(0.0, (x, v) => x + v);
      if (tot > 0) {
        var h = 0.0, t = 0.0;
        for (final v in m.values) {
          h += (v / tot) * (v / tot);
          if (v / tot > t) t = v / tot;
        }
        hhi += h;
        top += t;
      }
      m.clear();
      final cm = s.categoryMargin(g);
      if (cm != null) {
        margin += cm;
        nm++;
      }
      if (s.entryWant(g) < 0) blocked++;
    }
    // connaissance : variétés vivantes et en stock connues par catégorie, chez les ménages qui en connaissent une
    var known = 0.0, nk = 0, two = 0;
    for (final c in s.citizens) {
      for (final g in categories) {
        final ks = c.known[g];
        if (ks == null || ks.isEmpty) continue;
        var k = 0;
        for (final id in ks.keys) {
          final pr = s.products[id];
          if (pr != null && pr.alive) k++;
        }
        if (k == 0) continue;
        known += k;
        nk++;
        if (k >= 2) two++;
      }
    }
    final nc = categories.length;
    final line = {
      'jour': d,
      'vendeurs': sellers / nc,
      'varietes': alive / nc,
      'lancements': launchWin,
      'disparitions': endWin,
      'hhi': hhi / nc,
      'premier': top / nc,
      'marge': nm > 0 ? margin / nm : 0,
      'bloquees': blocked,
      'connues': nk > 0 ? known / nk : 0,
      'deux': nk > 0 ? two / nk : 0,
      'chomage': s.history.last.unemp,
      'ipc': s.history.last.cpi,
    };
    print('j$d vendeurs/catégorie ${f1(line['vendeurs'] as double)} variétés ${f1(line['varietes'] as double)} '
        'lancements $launchWin disparitions $endWin HHI ${f2(line['hhi'] as double)} premier ${f2(line['premier'] as double)} '
        'marge ${f2(line['marge'] as double)} entrée bloquée $blocked/$nc connues ${f2(line['connues'] as double)} '
        '(≥ 2 : ${f1((line['deux'] as double) * 100)} %) chômage ${f1(s.history.last.unemp * 100)} % IPC ${f2(s.history.last.cpi)}');
    launchWin = 0;
    if (d > 300) {
      n++;
      for (final k in ['vendeurs', 'varietes', 'hhi', 'premier', 'marge', 'bloquees', 'connues', 'deux', 'chomage', 'ipc']) {
        add(k, (line[k] as num).toDouble());
      }
    }
  }
  final out = {
    'graine': seed,
    'population': pop,
    'jours': days,
    'params': a.skip(3).join(' '),
    'lancements_par_an': days > 300 ? launches / ((days - 300) / 365) : 0,
    'disparitions_par_an': days > 300 ? ends / ((days - 300) / 365) : 0,
    for (final e in sum.entries) e.key: n > 0 ? e.value / n : 0,
  };
  print('RESUME ${jsonEncode(out)}');
}
