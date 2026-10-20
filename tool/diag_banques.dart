// Diagnostic de l'effondrement « bâtiments × banques » : séries de la monnaie par secteur, du crédit et de l'emploi.
//
//   dart run tool/diag_banques.dart --population 240 --graine 1 --jours 3000 --modules buildings=1,banking=1 [--pas 25]
//   [--param nom=valeur,...] [--out fichier.csv]
//
// Une ligne tous les --pas jours : chômage, faim, sans-abri, monnaie des ménages, des entreprises, de l'État et de la
// Caisse (compte consolidé du système bancaire), fonds propres, réserves, dette des entreprises, hypothèques (ménages,
// bailleurs), crédit aux particuliers, propriétaires-occupants, saisies, ventes, chantiers, prix moyen d'un logement,
// loyer (prix de la nuitée), entreprises, bailleurs actifs, banques vivantes, taux de dépôt moyen, ristournes et
// dividendes versés, flux nets du système bancaire depuis le dernier point (prêts − remboursements − intérêts + ristournes
// + dépenses des banques − capital reçu).
import 'dart:io';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'stabilite.dart' show applyParam;

void main(List<String> args) {
  var pop = 240, seed = 1, days = 3000, step = 25;
  final modules = Modules();
  final params = <String, String>{};
  String? out;
  for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--population':
        pop = int.parse(args[++i]);
      case '--graine':
        seed = int.parse(args[++i]);
      case '--jours':
        days = int.parse(args[++i]);
      case '--pas':
        step = int.parse(args[++i]);
      case '--modules':
        for (final kv in args[++i].split(',')) {
          final p = kv.split('=');
          modules.set(p[0], p.length < 2 || p[1] != '0');
        }
      case '--param':
        for (final kv in args[++i].split(',')) {
          final j = kv.indexOf('=');
          params[kv.substring(0, j)] = kv.substring(j + 1);
        }
      case '--out':
        out = args[++i];
      default:
        throw ArgumentError('Option inconnue : ${args[i]}');
    }
  }
  final p = Params()..population = pop;
  for (final e in params.entries) {
    applyParam(p, e.key, e.value);
  }
  final s = Sim(seed: seed, params: p, modules: modules);
  final b = StringBuffer();
  const cols = [
    'jour', 'chomage', 'faim', 'sans_abri', 'm_menages', 'm_entreprises', 'm_etat', 'm_caisse', 'fonds_propres',
    'reserves', 'dette_entreprises', 'hyp_menages', 'hyp_bailleurs', 'credit_particuliers', 'proprietaires', 'saisies',
    'ventes', 'chantiers', 'prix_logement', 'loyer', 'entreprises', 'bailleurs_actifs', 'banques', 'taux_depot',
    'ristournes', 'flux_bancaires_nets', 'salaire_moyen', 'pib',
  ];
  b.writeln(cols.join(','));
  var rebates0 = 0.0, lent0 = 0.0, repaid0 = 0.0, interest0 = 0.0;
  String f(double v) => v.toStringAsFixed(2);
  for (var d = 1; d <= days; d++) {
    s.step();
    if (d % step != 0 && d != 1) continue;
    final h = s.history.last;
    var mH = 0.0, mF = 0.0;
    for (final c in s.citizens) {
      mH += c.money;
    }
    for (final x in s.firms) {
      mF += x.money;
    }
    var firmDebt = 0.0;
    for (final x in s.firms) {
      firmDebt += x.debt;
    }
    var hypM = 0.0, hypB = 0.0;
    for (final m in s.mortgages) {
      if (m.borrowerKind == 1) {
        hypM += m.principal;
      } else {
        hypB += m.principal;
      }
    }
    final landlords = s.firms.where((x) => x.type == 'immobilier' && x.workers.isNotEmpty).length;
    final alive = s.banks.where((x) => x.alive).toList();
    final dep = alive.isEmpty ? 0.0 : alive.map((x) => x.depositRate).reduce((a, c) => a + c) / alive.length;
    final bk = s.bank;
    final flows = (bk.lent - lent0) - (bk.repaid - repaid0) - (bk.interest - interest0) + (bk.rebates - rebates0);
    lent0 = bk.lent;
    repaid0 = bk.repaid;
    interest0 = bk.interest;
    final reb = bk.rebates - rebates0;
    rebates0 = bk.rebates;
    final n = s.citizens.length;
    b.writeln([
      d, f(100 * h.unemp), f(100 * h.hungry / n), f(100 * h.homeless / n), f(mH), f(mF), f(s.state.money), f(bk.money),
      f(bk.equity), f(bk.reserves), f(firmDebt), f(hypM), f(hypB), f(s.consumerLent > 0 ? s.consumerDebtOf() : 0),
      s.homeOwners, s.bstats.foreclosures, s.bstats.sales, s.bstats.built, f(s.bstats.priceEma), f(s.bestPrice('logement')),
      s.firms.length, landlords, alive.length, f(100 * dep), f(reb), f(flows), f(h.wage), f(h.gdp),
    ].join(','));
  }
  if (out != null) {
    File(out).parent.createSync(recursive: true);
    File(out).writeAsStringSync(b.toString());
  } else {
    stdout.write(b);
  }
  // les 8 entreprises qui détiennent le plus d'argent à la fin, sur la sortie d'erreur
  final top = List<Firm>.of(s.firms)..sort((a, c) => c.money.compareTo(a.money));
  for (final x in top.take(8)) {
    stderr.writeln('${x.type.padRight(12)} ${x.name.padRight(28)} argent ${x.money.toStringAsFixed(0).padLeft(9)} '
        'profit lissé ${x.profitEma.toStringAsFixed(1).padLeft(8)} non répartis ${x.retained.toStringAsFixed(0).padLeft(9)} '
        'dividende ${x.dividends.toStringAsFixed(1)} employés ${x.workers.length} dette ${x.debt.toStringAsFixed(0)}');
  }
}
