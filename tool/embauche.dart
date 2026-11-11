// Marché du travail (anomalie N18), lecture seule : une partie aux réglages de l'interface, relevée par tranches de
// 50 jours. Embauches et refus, salaire de réserve des chômeurs (et la part qui tient à leur prestation) comparé au
// plafond des employeurs, postes ouverts, chômage par qualification, emploi par secteur, fermetures par cause.
//
//   dart run tool/embauche.dart graine population jours [--produits 0|1] [--param nom=valeur,...]
//
// Sortie : deux lignes par tranche, puis « RESUME {json} » (une valeur par tranche pour chaque série).

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

String f1(double v) => v.toStringAsFixed(1);
String f2(double v) => v.toStringAsFixed(2);

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final p = parametresInterface(pop);
  var produits = true;
  for (var i = 3; i < a.length; i++) {
    switch (a[i]) {
      case '--produits':
        produits = a[++i] == '1';
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
        ..products = produits);
  const pas = 50;
  final series = <String, List<double>>{};
  void put(String k, double v) => (series[k] ??= []).add(v);
  final acc = <String, double>{};
  void add(String k, double v) => acc[k] = (acc[k] ?? 0) + v;
  var closes = <String, int>{};
  var created = s.firmsCreated;
  var empl = <String, int>{};
  for (var d = 1; d <= days; d++) {
    s.step();
    final h = s.history.last;
    add('chomage', h.unemp);
    add('ipc', h.cpi);
    add('besoins', s.needCost);
    for (final k in LabourStats.kinds) {
      add(k, s.labour.today[k]!.toDouble());
    }
    var vac = 0.0, unfilled = 0.0, offerW = 0.0, offerN = 0.0;
    for (final f in s.firms) {
      vac += f.vacancies;
      if (f.vacancies > 0 && f.unfilledDays >= 2) unfilled++;
      if (f.workers.isNotEmpty) {
        offerW += f.offer * f.workers.length;
        offerN += f.workers.length;
      }
      // négociations du jour (au plus 12 gardées par entreprise)
      for (final t in f.talks) {
        if (t.day != s.day || t.cap <= 0) continue;
        if (t.kind == 'refus') {
          add('refusN', 1);
          add('refusReservePlafond', t.reservation / t.cap);
          add('refusReserveOffre', t.reservation / t.offer);
        } else if (t.kind == 'embauche') {
          add('embN', 1);
          add('embSalaireOffre', t.wage / t.offer);
        }
      }
    }
    add('postes', vac);
    add('nonPourvues', unfilled);
    add('offre', offerN > 0 ? offerW / offerN : 0);
    if (d % pas != 0) continue;

    // chômeurs : salaire de réserve, part tenue par la prestation, par qualification
    var nU = 0, atFloor = 0;
    var res = 0.0, last = 0.0, ben = 0.0;
    final byClass = [0, 0, 0], classN = [0, 0, 0];
    final keep = 1 - (p.progressiveTax ? p.taxRate1 : p.taxRate) - (s.modules.insurance ? p.eiRate : 0);
    for (final c in s.citizens) {
      classN[c.level]++;
      if (c.employer != null) continue;
      byClass[c.level]++;
      nU++;
      final r = s.reservationWage(c);
      res += r;
      last += c.wage;
      final b = s.benefitNow(c);
      ben += b;
      final floor = keep > 0.05 ? 1.1 * b / keep : 0.0;
      if (floor >= c.wage * (1 - p.reservationDecay * c.daysUnemployed) - 1e-9) atFloor++;
    }
    final nowCloses = {
      for (final e in s.entryFunnel.entries)
        if (e.key.startsWith('fermeture_')) e.key.substring(10): e.value
    };
    final dc = {
      for (final k in nowCloses.keys)
        if (nowCloses[k]! - (closes[k] ?? 0) > 0) k: nowCloses[k]! - (closes[k] ?? 0)
    };
    closes = nowCloses;
    final dCreated = s.firmsCreated - created;
    created = s.firmsCreated;
    final byType = <String, int>{};
    for (final f in s.firms) {
      byType[f.type] = (byType[f.type] ?? 0) + f.workers.length;
    }
    final moves = <String>[];
    for (final t in {...byType.keys, ...empl.keys}) {
      final dv = (byType[t] ?? 0) - (empl[t] ?? 0);
      if (dv.abs() >= 15) moves.add('$t ${dv > 0 ? '+' : ''}$dv');
    }
    empl = byType;
    double m(String k) => (acc[k] ?? 0) / pas;
    final refusN = acc['refusN'] ?? 0, embN = acc['embN'] ?? 0;
    put('jour', d.toDouble());
    put('chomage', m('chomage'));
    put('ipc', m('ipc'));
    put('salaire', h.wage);
    put('offre', m('offre'));
    put('besoins', m('besoins'));
    put('postes', m('postes'));
    put('nonPourvues', m('nonPourvues'));
    for (final k in LabourStats.kinds) {
      put(k, m(k));
    }
    put('refusReservePlafond', refusN > 0 ? acc['refusReservePlafond']! / refusN : 0);
    put('refusReserveOffre', refusN > 0 ? acc['refusReserveOffre']! / refusN : 0);
    put('embSalaireOffre', embN > 0 ? acc['embSalaireOffre']! / embN : 0);
    put('reserveChomeurs', nU > 0 ? res / nU : 0);
    put('dernierSalaire', nU > 0 ? last / nU : 0);
    put('prestation', nU > 0 ? ben / nU : 0);
    put('partPlancher', nU > 0 ? atFloor / nU : 0);
    for (var k = 0; k < 3; k++) {
      put('chomageClasse$k', classN[k] > 0 ? byClass[k] / classN[k] : 0);
      put('partClasse$k', classN[k] / s.citizens.length);
    }
    put('actives', s.firms.where((f) => f.workers.isNotEmpty).length.toDouble());
    put('creees', dCreated.toDouble());
    put('fermees', dc.values.fold(0, (x, v) => x + v).toDouble());
    print('j$d chômage ${f1(m('chomage') * 100)} % (classes ${[for (var k = 0; k < 3; k++) f1(classN[k] > 0 ? byClass[k] / classN[k] * 100 : 0)].join('/')} %, '
        'effectifs ${classN.join('/')}) IPC ${f2(m('ipc'))} salaire ${f1(h.wage)} offre ${f1(m('offre'))} besoins ${f1(m('besoins'))} ; '
        'postes ${f1(m('postes'))}/j (non pourvus ≥ 2 j : ${f1(m('nonPourvues'))} entreprises) ; '
        'embauches ${f1(m('embauche'))}/j refus ${f1(m('refus'))}/j hausses ${f1(m('revision'))} baisses ${f1(m('baisse'))} départs ${f1(m('depart'))}');
    print('     chômeurs : réserve ${f1(nU > 0 ? res / nU : 0)} \$ (dernier salaire ${f1(nU > 0 ? last / nU : 0)}, prestation '
        '${f1(nU > 0 ? ben / nU : 0)}, au plancher de la prestation ${f1(nU > 0 ? atFloor / nU * 100 : 0)} %) ; refus : réserve ÷ plafond '
        '${f2(refusN > 0 ? acc['refusReservePlafond']! / refusN : 0)}, ÷ offre ${f2(refusN > 0 ? acc['refusReserveOffre']! / refusN : 0)} ; '
        'embauche ÷ offre ${f2(embN > 0 ? acc['embSalaireOffre']! / embN : 0)} ; entreprises actives '
        '${s.firms.where((f) => f.workers.isNotEmpty).length}, créées $dCreated, fermées $dc ; mouvements ${moves.join(', ')}');
    acc.clear();
  }
  print('RESUME ${jsonEncode({'graine': seed, 'population': pop, 'jours': days, 'options': a.skip(3).join(' '), 'series': series})}');
}
