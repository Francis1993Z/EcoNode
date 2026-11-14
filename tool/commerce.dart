// Sonde, lecture seule : ce que le commerce extérieur fait à chaque filière.
//
//   dart run tool/commerce.dart graine population jours [--frontieres 0|1] [--filets 0|1] [--param nom=valeur,...]
//
// Réglages de l'interface (tool/emergence.dart), tous les modules actifs ; frontières ouvertes (1, défaut) ou fermées (0).
// Tous les 500 jours : taux de change, importations et exportations par jour, monnaie, chômage. À la fin, pour chaque bien,
// moyennes des jours après 1 000 : production, importations et exportations par jour, part importée de ce qui est acheté
// ici, prix d'ici (moyenne des vendeurs actifs) rapporté au prix d'import, prix d'import et ce qui le fait (prix mondial,
// facteur des vagues, taux de change), employés des entreprises qui le produisent ; puis, par type d'entreprise, les
// fermetures (et leurs causes) et les fondations sur toute la partie. Une ligne « BIEN {json} » par bien pour l'analyse.

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

String f2(double v) => v.toStringAsFixed(2);

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), days = int.parse(a[2]);
  final p = parametresInterface(pop);
  var filets = true;
  for (var i = 3; i < a.length; i++) {
    switch (a[i]) {
      case '--frontieres':
        p.trade = a[++i] == '1';
      case '--filets':
        filets = a[++i] == '1';
      case '--param':
        for (final kv in a[++i].split(',')) {
          final j = kv.indexOf('=');
          regler(p, kv.substring(0, j), kv.substring(j + 1));
        }
    }
  }
  final s = Sim(seed: seed, params: p, modules: Modules(), safeguards: filets ? Safeguards() : Safeguards.none());
  const from = 1000;
  final prod = <String, double>{}, imp = <String, double>{}, impV = <String, double>{}, exp = <String, double>{};
  final expV = <String, double>{}, prix = <String, double>{}, prixN = <String, int>{}, pImp = <String, double>{};
  final facteur = <String, double>{}, emplois = <String, double>{};
  final fermetures = <String, Map<String, int>>{}, fondations = <String, int>{};
  var connues = {for (final f in s.firms) f.id: f};
  var n = 0, fxSum = 0.0;
  var tImp = 0.0, tExp = 0.0, tFx = 0.0, tU = 0.0;
  for (var d = 1; d <= days; d++) {
    s.step();
    final h = s.history.last;
    // fermetures et fondations
    final now = {for (final f in s.firms) f.id: f};
    for (final e in connues.entries) {
      if (!now.containsKey(e.key)) {
        final m = fermetures[e.value.type] ??= {};
        final c = s.closeCause(e.value);
        m[c] = (m[c] ?? 0) + 1;
      }
    }
    for (final id in now.keys) {
      if (!connues.containsKey(id)) fondations[now[id]!.type] = (fondations[now[id]!.type] ?? 0) + 1;
    }
    connues = now;
    var di = 0.0, de = 0.0;
    for (final e in s.flows.values) {
      if (e.from == 'X' && goods.containsKey(e.good)) {
        di += e.value;
        if (d > from) {
          imp[e.good] = (imp[e.good] ?? 0) + e.qty;
          impV[e.good] = (impV[e.good] ?? 0) + e.value;
        }
      } else if (e.to == 'X' && goods.containsKey(e.good)) {
        de += e.value;
        if (d > from) {
          exp[e.good] = (exp[e.good] ?? 0) + e.qty;
          expV[e.good] = (expV[e.good] ?? 0) + e.value;
        }
      }
    }
    tImp += di;
    tExp += de;
    tFx += s.fx;
    tU += h.unemp;
    if (d > from) {
      n++;
      fxSum += s.fx;
      for (final g in s.goodKeys) {
        if (goods[g]!.tradable && !goods[g]!.perish) {
          pImp[g] = (pImp[g] ?? 0) + s.importPrice(g);
          facteur[g] = (facteur[g] ?? 0) + s.tradeFactorOf(g);
        }
      }
      for (final f in s.firms) {
        if (f.workers.isEmpty) continue;
        for (final g in f.outputs.keys) {
          prod[g] = (prod[g] ?? 0) + (f.produced[g] ?? 0);
          emplois[g] = (emplois[g] ?? 0) + f.workers.length;
          final pr = f.price[g];
          if (pr != null) {
            prix[g] = (prix[g] ?? 0) + pr;
            prixN[g] = (prixN[g] ?? 0) + 1;
          }
        }
      }
    }
    if (d % 500 == 0) {
      final total = s.citizens.fold(0.0, (x, c) => x + c.money) + s.firms.fold(0.0, (x, f) => x + f.money);
      print('j$d : change ${f2(tFx / 500)}, importations ${f2(tImp / 500)} \$/j, exportations ${f2(tExp / 500)} \$/j, '
          'chômage ${f2(100 * tU / 500)} %, indice ${f2(h.cpi)}, monnaie ménages + entreprises ${f2(total / 1e6)} M, '
          'entreprises actives ${s.firms.where((f) => f.workers.isNotEmpty).length}');
      tImp = tExp = tFx = tU = 0;
    }
  }
  print('change moyen après le jour $from : ${f2(fxSum / n)}');
  final biens = [...s.goodKeys]..sort((x, y) => ((impV[y] ?? 0) - (expV[y] ?? 0)).compareTo((impV[x] ?? 0) - (expV[x] ?? 0)));
  for (final g in biens) {
    final pr = prixN[g] == null ? double.nan : prix[g]! / prixN[g]!;
    final pi = pImp[g] == null ? double.nan : pImp[g]! / n;
    final q = (prod[g] ?? 0) / n, mi = (imp[g] ?? 0) / n, me = (exp[g] ?? 0) / n;
    final achete = q - me + mi;
    final j = {
      'bien': g,
      'production': q,
      'importations': mi,
      'exportations': me,
      'importationsValeur': (impV[g] ?? 0) / n,
      'exportationsValeur': (expV[g] ?? 0) / n,
      'partImportee': achete > 0 ? mi / achete : 0,
      'prixIci': pr,
      'prixImport': pi,
      'prixMondial': s.worldPrice[g],
      'facteur': facteur[g] == null ? null : facteur[g]! / n,
      'emplois': (emplois[g] ?? 0) / n,
    };
    print('BIEN ${jsonEncode({for (final e in j.entries) e.key: e.value is double && !(e.value as double).isFinite ? null : e.value})}');
  }
  for (final t in {...fermetures.keys, ...fondations.keys}) {
    print('TYPE ${jsonEncode({'type': t, 'fermetures': fermetures[t] ?? {}, 'fondations': fondations[t] ?? 0})}');
  }
}
