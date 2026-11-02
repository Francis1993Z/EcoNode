// Aller-retour d'instantané aux réglages de l'interface (lecture seule) : une partie sauvegardée puis rechargée doit
// continuer à l'identique (empreintes quotidiennes de 150 jours après le rechargement).
//
//   dart run tool/allerretour.dart batiments(0|1) [--param nom=valeur,...]
//
// Bâtiments à 1 : modules Bâtiments et Banques actifs, types de bâtiments compris (réglages de l'interface).
import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

void main(List<String> a) {
  final bld = a[0] == '1';
  final p = parametresInterface(400);
  for (var i = 1; i < a.length; i++) {
    if (a[i] != '--param') continue;
    for (final kv in a[++i].split(',')) {
      final j = kv.indexOf('=');
      regler(p, kv.substring(0, j), kv.substring(j + 1));
    }
  }
  final s = Sim(
      seed: 7,
      params: p,
      modules: Modules()
        ..jobs = true
        ..entrepreneurship = true
        ..products = true
        ..buildings = bld
        ..banking = bld,
      devChecks: true);
  for (var d = 0; d < 200; d++) {
    s.step();
  }
  final t = simFromSnapshot(jsonDecode(jsonEncode(s.toSnapshot())) as Map<String, dynamic>)..devChecks = true;
  var diff = 0;
  for (var d = 0; d < 150; d++) {
    s.step();
    t.step();
    final x = s.digest(), y = t.digest();
    for (final k in x.keys) {
      if (x[k] != y[k]) {
        if (diff < 5) print('jour ${s.day} : $k diffère');
        diff++;
      }
    }
  }
  final leases = s.citizens.where((c) => c.leaseFirm != null).length;
  final placed = s.citizens.where((c) => s.dwellingOf(c) != null).length;
  print('bâtiments ${bld ? 1 : 0}, types ${p.buildingTypes ? 1 : 0} : ${diff == 0 ? 'IDENTIQUE' : '$diff écarts'} sur 150 jours '
      'après rechargement ; baux $leases (rattachés $placed), sans-abri ${s.citizens.where((c) => c.homeless).length}, '
      'propriétaires ${s.citizens.where((c) => c.homeId != null).length}, bâtiments ${s.buildings.length}');
}
