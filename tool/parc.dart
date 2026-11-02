// Parc immobilier (types de bâtiments, Params.buildingTypes), lecture seule : relevé tous les 250 jours d'une partie aux
// réglages de l'interface, module Bâtiments actif.
//
//   dart run tool/parc.dart graine population jours [--banques 0|1] [--param nom=valeur,...]
//
// Comparer avec et sans types : --param buildingTypes=0 (l'interface les active). Sortie : une ligne par relevé, puis
// « RESUME {json} » : moyennes des jours 101 à la fin (sans-abri, chômage, prix, propriétaires), indice des prix aux
// jours 250 et final, prix de vente des maisons, parc par type à la fin, rachats d'immeubles, saisies, chantiers.

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

String f1(double v) => v.toStringAsFixed(1);
String f2(double v) => v.toStringAsFixed(2);

/// Clé du type d'un bâtiment (« standard » sans type).
String kindOf(Building b) => b.type == null ? 'standard' : buildingKinds[b.type!].key;

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final p = parametresInterface(pop);
  var banques = false;
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
        ..banking = banques);
  final cpi0 = s.history.last.cpi;
  var n = 0, cpi250 = 0.0, cpiMax = 0.0;
  var homelessMax = 0;
  final sum = <String, double>{};
  void add(String k, double v) => sum[k] = (sum[k] ?? 0) + v;
  for (var d = 1; d <= days; d++) {
    s.step();
    final h = s.history.last;
    final cpi = cpi0 > 0 ? h.cpi / cpi0 : h.cpi;
    if (d == 250) cpi250 = cpi;
    if (cpi > cpiMax) cpiMax = cpi;
    if (d > 100) {
      n++;
      add('sansAbri', h.homeless.toDouble());
      add('chomage', h.unemp);
      add('ipc', cpi);
      add('salaire', h.wage);
      add('proprietaires', s.homeOwners / s.citizens.length);
      add('logements', s.dwellings.toDouble());
      if (h.homeless > homelessMax) homelessMax = h.homeless;
    }
    if (d % 250 != 0 && d != days) continue;
    final units = <String, int>{}, count = <String, int>{};
    var sites = 0, liq = 0;
    for (final b in s.buildings) {
      if (!b.done) {
        sites++;
        continue;
      }
      if (b.ownerKind == 2) liq += b.units;
      units[kindOf(b)] = (units[kindOf(b)] ?? 0) + b.units;
      count[kindOf(b)] = (count[kindOf(b)] ?? 0) + 1;
    }
    final st = s.bstats;
    print('j$d chômage ${f1(h.unemp * 100)} %, sans-abri ${h.homeless}, ipc ${f2(cpi)}, salaire ${f1(h.wage)}, '
        'propriétaires ${s.homeOwners}, logements ${s.dwellings} (liquidation $liq), chantiers $sites, '
        'maison vendue ${f1(st.priceEma)}, ventes ${st.sales}, rachats ${st.bought}, saisies ${st.foreclosures}, '
        'construits ${st.built} ; bâtiments $count');
  }
  final units = <String, int>{}, count = <String, int>{};
  var tenants = 0, placed = 0, liqUnits = 0;
  for (final b in s.buildings) {
    if (!b.done) continue;
    units[kindOf(b)] = (units[kindOf(b)] ?? 0) + b.units;
    count[kindOf(b)] = (count[kindOf(b)] ?? 0) + 1;
    if (b.ownerKind == 2) liqUnits += b.units;
  }
  for (final c in s.citizens) {
    if (c.leaseFirm != null) tenants++;
    if (s.dwellingOf(c) != null) placed++;
  }
  final st = s.bstats;
  final r = <String, Object>{
    'graine': seed,
    'population': pop,
    'jours': days,
    'types': p.buildingTypes,
    'banques': banques,
    for (final e in sum.entries) e.key: e.value / n,
    'sansAbriMax': homelessMax,
    'chomageFinal': s.history.last.unemp,
    'ipc250': cpi250,
    'ipcMax': cpiMax,
    'ipcFinal': cpi0 > 0 ? s.history.last.cpi / cpi0 : 0,
    'prixMaison': st.priceEma,
    'joursDeSalaire': s.history.last.wage > 0 ? st.priceEma / s.history.last.wage : 0,
    'ventes': st.sales,
    'rachats': st.bought,
    'saisies': st.foreclosures,
    'construits': st.built,
    'abandonnes': st.abandoned,
    'refus': st.refused,
    'liquidation': liqUnits,
    'locataires': tenants,
    'rattaches': placed,
    'batiments': count,
    'logementsParType': units,
  };
  print('RESUME ${jsonEncode(r)}');
}
