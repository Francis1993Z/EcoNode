// Crédit hypothécaire par source (module Bâtiments, avec ou sans le module renovation), lecture seule : une partie aux
// réglages de l'interface avec Produits, Bâtiments et Banques. Chaque jour, chaque hausse du capital d'une hypothèque
// (nouvelle hypothèque ou tirage) est classée : achat d'un logement par un ménage, rénovation d'un occupant, chantier d'un
// bailleur, rénovation d'un bailleur, rachat par un bailleur ; chaque baisse est un remboursement (versements, ventes) ou
// une radiation. Relevé tous les 250 jours : montants par source, ventes de logements, prix et valeur des maisons,
// salaire, indice des prix, prix offert et prix de référence du module.
//
//   dart run tool/credit.dart graine population jours [--renovation 0|1] [--param nom=valeur,...]
//
// Sortie : une ligne lisible et « CREDIT {json} » par relevé.

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

String m1(double v) => (v / 1e6).toStringAsFixed(2);

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final p = parametresInterface(pop);
  var renovation = true;
  for (var i = 3; i < a.length; i++) {
    switch (a[i]) {
      case '--renovation':
        renovation = a[++i] == '1';
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
        ..banking = true
        ..renovation = renovation);
  // la veille : capital de chaque hypothèque, propriétaire (genre et identifiant) de chaque bâtiment
  var principal = <int, double>{for (final m in s.mortgages) m.id: m.principal};
  var owner = <int, String>{for (final b in s.buildings) b.id: '${b.ownerKind}:${b.ownerId}'};
  final acc = <String, double>{};
  void add(String k, double v) => acc[k] = (acc[k] ?? 0) + v;
  var sales0 = s.bstats.sales, built0 = s.bstats.built, reno0 = s.bstats.renovated, written0 = 0.0;
  for (var d = 1; d <= days; d++) {
    s.step();
    final now = <int, double>{};
    for (final m in s.mortgages) {
      now[m.id] = m.principal;
      final before = principal[m.id];
      final up = before == null ? m.principal : m.principal - before;
      final b = s.building(m.buildingId);
      if (up > 1e-6 && b != null) {
        final changed = owner[b.id] != '${b.ownerKind}:${b.ownerId}';
        final String k;
        if (m.borrowerKind == 1) {
          k = changed ? 'achat' : 'renoOccupant'; // un achat change le propriétaire ; un tirage de rénovation, non
        } else if (m.borrowerKind == 0) {
          k = !b.done || b.modules < s.modulesOf(b) || (before == null && b.builtDay == s.day)
              ? 'chantier'
              : (changed ? 'rachat' : 'renoBailleur');
        } else {
          k = 'autre';
        }
        add(k, up);
      } else if (up < -1e-6) {
        add('rembourse', -up);
      }
    }
    for (final e in principal.entries) {
      if (!now.containsKey(e.key)) add('solde', e.value); // hypothèque soldée (vente, remboursement final, radiation)
    }
    principal = now;
    owner = {for (final b in s.buildings) b.id: '${b.ownerKind}:${b.ownerId}'};
    if (d % 250 != 0) continue;
    final h = s.history.last;
    final houses = s.buildings.where((b) => b.done && b.units == 1).toList();
    final fair = houses.isEmpty ? 0.0 : houses.fold(0.0, (x, b) => x + s.fairValue(b) / s.sizeOf(b)) / houses.length;
    final debt = s.mortgages.fold(0.0, (x, m) => x + m.principal);
    final hh = s.mortgages.where((m) => m.borrowerKind == 1).fold(0.0, (x, m) => x + m.principal);
    final r = {
      'jour': d,
      for (final k in ['achat', 'renoOccupant', 'chantier', 'renoBailleur', 'rachat', 'autre', 'rembourse', 'solde'])
        k: acc[k] ?? 0.0,
      'hypotheques': debt,
      'hypothequesMenages': hh,
      'ventes': s.bstats.sales - sales0,
      'chantiers': s.bstats.built - built0,
      'renovations': s.bstats.renovated - reno0,
      'prixVenteMoyen': s.bstats.priceEma,
      'valeurMaison': fair,
      'salaire': h.wage,
      'ipc': h.cpi,
      'prixModule': s.moduleCost(),
      'valeurModule': s.moduleValue(),
      'proprietaires': s.homeOwners,
      'radie': s.bank.writtenOff - written0,
    };
    print('j$d achats ${m1(acc['achat'] ?? 0)} M, rénov. occupants ${m1(acc['renoOccupant'] ?? 0)} M, chantiers '
        '${m1(acc['chantier'] ?? 0)} M, rénov. bailleurs ${m1(acc['renoBailleur'] ?? 0)} M, remboursé '
        '${m1((acc['rembourse'] ?? 0) + (acc['solde'] ?? 0))} M ; hypothèques ${m1(debt)} M ; ventes ${r['ventes']} ; '
        'maison ${fair.round()} \$ ; module ${s.moduleCost().round()} \$ (valeur ${s.moduleValue().round()}) ; '
        'salaire ${h.wage.round()} ; IPC ${h.cpi.toStringAsFixed(2)}');
    print('CREDIT ${jsonEncode(r)}');
    acc.clear();
    sales0 = s.bstats.sales;
    built0 = s.bstats.built;
    reno0 = s.bstats.renovated;
    written0 = s.bank.writtenOff;
  }
}
