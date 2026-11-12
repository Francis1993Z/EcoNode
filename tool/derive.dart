// Dérive longue (anomalie N16), lecture seule : relevé tous les 250 jours d'une partie aux réglages de l'interface.
//
//   dart run tool/derive.dart graine population jours [--produits 0|1] [--batiments 0|1] [--banques 0|1]
//        [--filets 0|1] [--renovation 0|1] [--sortie fichier] [--param nom=valeur,...]
//
// --filets : filets de sécurité actifs (1, défaut) ou tous coupés (0).
// --renovation : module « Rénovation et métiers du bâtiment » (suppose --batiments 1).
// --sortie : les lignes vont dans ce fichier (ajoutées à la fin), écrites sur le disque à chaque relevé : une partie
//            coupée en route (arrêt du serveur) garde tous ses relevés. Sans elle, sur la sortie standard.
//
// Sortie : par relevé, une ligne lisible et « RELEVE {json} » (moyennes des 250 jours, état au jour du relevé, secondes
// écoulées) ; à la fin, « RESUME {json} » avec les moyennes de chaque tranche de 500 jours (chômage, prix, salaire,
// argent des ménages et des entreprises).

import 'dart:convert';
import 'dart:io';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

String f1(double v) => v.toStringAsFixed(1);
String f2(double v) => v.toStringAsFixed(2);

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final p = parametresInterface(pop);
  var produits = true, batiments = false, banques = false, filets = true, renovation = false;
  String? fichier;
  for (var i = 3; i < a.length; i++) {
    switch (a[i]) {
      case '--produits':
        produits = a[++i] == '1';
      case '--batiments':
        batiments = a[++i] == '1';
      case '--banques':
        banques = a[++i] == '1';
      case '--filets':
        filets = a[++i] == '1';
      case '--renovation':
        renovation = a[++i] == '1';
      case '--sortie':
        fichier = a[++i];
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
        ..banking = banques
        ..renovation = renovation,
      safeguards: filets ? Safeguards() : Safeguards.none());
  final sortie = fichier == null ? null : File(fichier).openSync(mode: FileMode.writeOnlyAppend);
  void emit(String ligne) {
    if (sortie == null) {
      print(ligne);
    } else {
      sortie
        ..writeStringSync('$ligne\n')
        ..flushSync();
    }
  }

  final chrono = Stopwatch()..start();
  // moyennes par tranche de 500 jours
  final tranches = <int, Map<String, double>>{};
  var u = 0.0, ipc = 0.0, sal = 0.0;
  for (var d = 1; d <= days; d++) {
    s.step();
    final h = s.history.last;
    u += h.unemp;
    ipc += h.cpi;
    sal += h.wage;
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
    final varietes = s.products.values.where((pr) => pr.alive).length;
    emit('j$d chômage ${f1(u / 250 * 100)} % IPC ${f2(h.cpi)} salaire ${f1(h.wage)} ; argent : ménages ${f2(hh / 1e6)} M '
        '(médiane ${f1(moneys[moneys.length ~/ 2])}), entreprises ${f2(fm / 1e6)} M, État ${f2(s.state.money / 1e6)} M, '
        'dettes des entreprises ${f2(debt / 1e6)} M ; entreprises actives $act, machines ${mach.round()}, '
        'variétés $varietes');
    emit('RELEVE ${jsonEncode({
          'jour': d,
          'chomage': u / 250,
          'ipcMoyen': ipc / 250,
          'salaireMoyen': sal / 250,
          'ipc': h.cpi,
          'salaire': h.wage,
          'menages': hh,
          'mediane': moneys[moneys.length ~/ 2],
          'entreprises': fm,
          'etat': s.state.money,
          'banques': h.mB,
          'total': h.total,
          'detteEntreprises': debt,
          'credit': h.credit,
          'hypotheques': s.mortgages.fold(0.0, (x, m) => x + m.principal),
          'banquesActives': s.banks.where((b) => b.alive).length,
          'batiments': s.buildings.length,
          'actives': act,
          'entreprisesTotal': s.firms.length,
          'machines': mach,
          'varietes': varietes,
          'affames': h.hungry,
          'sansAbri': h.homeless,
          'bonheur': h.happiness,
          'gini': h.gini,
          'pib': h.gdp,
          'population': h.pop,
          // parc : état moyen des bâtiments terminés, inhabitables, rénovations en cours et terminées, chantiers terminés
          'etatParc': s.buildings.where((b) => b.done).fold(0.0, (x, b) => x + b.cond) /
              s.buildings.where((b) => b.done).length.clamp(1, 1 << 30),
          'inhabitables': s.buildings.where((b) => b.done && !b.habitable).length,
          'enRenovation': s.buildings.where((b) => b.renoLeft > 0).length,
          'renovees': s.bstats.renovated,
          'depensesReno': s.bstats.renoSpent,
          'construits': s.bstats.built,
          'prixModule': s.bestPrice('batiment'),
          // employés de la construction par type (module renovation : métiers et fournisseurs ; sinon la Construction)
          'construction': {
            for (final ty in [...renovationTypes, 'construction'])
              if (s.firms.any((f) => f.type == ty))
                ty: s.firms.where((f) => f.type == ty).fold(0, (x, f) => x + f.workers.length),
          },
          'secondes': chrono.elapsedMilliseconds / 1000,
        })}');
    u = ipc = sal = 0;
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
  emit('RESUME ${jsonEncode(out)}');
  sortie?.closeSync();
}
