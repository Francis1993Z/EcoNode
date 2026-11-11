// Plan de départ (anomalie N18), lecture seule : machines, prix des machines et entreprises au jour 0, réglages de
// l'interface, pour une suite de graines. Ne joue aucun jour : seulement le plan (et sa partie provisoire de 200 jours
// avec planFromHouseholds).
//
//   dart run tool/plan_depart.dart population graine-début graine-fin [--produits 0|1] [--param nom=valeur,...]
//
// Sortie : une ligne par graine, « graine machines prix-des-machines entreprises types-absents ».

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

void main(List<String> a) {
  final pop = int.parse(a[0]), from = int.parse(a[1]), to = int.parse(a[2]);
  var produits = true;
  final params = <String>[];
  for (var i = 3; i < a.length; i++) {
    if (a[i] == '--produits') {
      produits = a[++i] == '1';
    } else if (a[i] == '--param') {
      params.add(a[++i]);
    }
  }
  for (var seed = from; seed <= to; seed++) {
    final p = parametresInterface(pop);
    for (final kvs in params) {
      for (final kv in kvs.split(',')) {
        final j = kv.indexOf('=');
        regler(p, kv.substring(0, j), kv.substring(j + 1));
      }
    }
    final s = Sim(
        seed: seed,
        params: p,
        modules: Modules()
          ..jobs = true
          ..entrepreneurship = true
          ..products = produits);
    final mach = s.firms.fold(0.0, (x, f) => x + f.machines);
    final present = {for (final f in s.firms) f.type};
    final absents = [for (final t in defaultScenario.map((e) => e.type).toSet()) if (!present.contains(t)) t];
    print('PLAN pop=$pop produits=${produits ? 1 : 0} param=${params.join(',')} graine=$seed machines=${mach.round()} '
        'prix=${s.worldPrice['machines']!.toStringAsFixed(0)} entreprises=${s.firms.length} absents=${absents.join('+')}');
  }
}
