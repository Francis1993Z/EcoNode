// Tests par propriétés (tâche 4) : sur des parties tirées au hasard (graine, taille, modules, filets, paramètres, chocs
// du god mode), des propriétés qui doivent tenir chaque jour. Générateur maison, reproductible : chaque cas est
// donné par son numéro ; un échec cite le cas, le jour et l'agent.
// Repères : Thaler et Siebers (tests par propriétés en simulation à agents) ; Galán et al. 2009 (erreurs et artefacts).
//
// La conservation des flux du jour n'est pas retestée ici : les invariants comptables exacts la couvrent déjà
// (engine_test.dart, mode développement).

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

/// Une partie tirée au hasard, et ce qu'on lui a fait.
class Case {
  final int n;
  late final Sim sim;
  final List<String> setup = [];
  late final Mulberry32 _r;
  final List<(int, void Function(Sim), String)> shocks = [];

  double u() => _r.next();
  double between(double a, double b) => a + (b - a) * u();
  int pick(int a, int b) => a + (u() * (b - a + 1)).floor();

  Case(this.n, int days) {
    _r = Mulberry32(hash32(20261011, n));
    final p = Params()
      ..population = pick(40, 300)
      ..startWallet = between(1500, 5000)
      ..taxRate = between(0.05, 0.25)
      ..benefit = between(40, 120)
      ..interestRate = between(0.02, 0.12)
      ..priceMaxDaily = between(0.005, 0.03)
      ..wageMaxDaily = between(0.005, 0.03)
      ..dividendRate = between(0.02, 0.15)
      ..jobSwitch = between(0, 0.1)
      ..illness = between(0, 0.01)
      ..eiQualifyingDays = pick(10, 120)
      ..bankCapitalPerCitizen = u() < 0.3 ? 0 : between(0, 200) // une Caisse sans capital bute sur son plancher
      ..dividendFromRetained = u() < 0.5
      ..trade = u() < 0.3;
    final m = Modules();
    for (final k in Modules.keys) {
      m.set(k, u() < 0.75);
    }
    final sg = Safeguards();
    for (final k in Safeguards.keys) {
      sg.set(k, u() < 0.5);
    }
    final seed = pick(1, 1000000);
    sim = Sim(seed: seed, params: p, modules: m, safeguards: sg, devChecks: true);
    setup.add('graine $seed, population ${p.population}, modules coupés ${Modules.keys.where((k) => !m.get(k)).toList()}, '
        'filets ${Safeguards.keys.where(sg.get).toList()}, prix ±${p.priceMaxDaily}, salaires ±${p.wageMaxDaily}');
    // chocs : injection ou retrait d'argent, destruction de stocks, épidémie, arrivées et départs, faillite
    final nShocks = pick(0, 4);
    for (var i = 0; i < nShocks; i++) {
      final day = pick(20, days - 10);
      switch (pick(0, 5)) {
        case 0:
          final a = between(-2000, 5000);
          shocks.add((day, (s) => s.godMoney(const Target('allCitizens'), a), 'argent $a'));
        case 1:
          final g = goods.keys.elementAt(pick(0, goods.length - 1));
          final pct = between(0.3, 1);
          shocks.add((day, (s) => s.godDestroy(g, pct), 'stocks de $g ×${1 - pct}'));
        case 2:
          final share = between(0.1, 0.7);
          shocks.add((day, (s) => s.godEpidemic(share), 'épidémie $share'));
        case 3:
          final k = pick(1, 30);
          shocks.add((day, (s) => s.godAddCitizens(k, 2000), '$k arrivées'));
        case 4:
          final k = pick(1, 30);
          shocks.add((day, (s) => s.godRemoveCitizens(k), '$k départs'));
        default:
          final rank = pick(0, 1000);
          shocks.add((
            day,
            (s) {
              if (s.firms.isNotEmpty) s.godBankrupt(s.firms[rank % s.firms.length].id);
            },
            'faillite'
          ));
      }
    }
  }

  String get label => 'cas $n (${setup.join(' ; ')} ; chocs ${[for (final s in shocks) 'j${s.$1} ${s.$3}']})';
}

/// Fonds propres comptables d'une entreprise : trésorerie, stocks (extrants au prix affiché, intrants au meilleur prix
/// du marché), machines au meilleur prix des machines, moins la dette.
double equity(Sim s, Firm f) {
  var v = f.money - f.debt + f.machines * s.bestPrice('machines');
  for (final e in f.inv.entries) {
    v += e.value * (f.outputs.containsKey(e.key) ? f.price[e.key]! : s.bestPrice(e.key));
  }
  return v;
}

/// Ce que les propriétés relèvent pendant une partie.
class Watch {
  final List<String> failures = [];
  final Map<int, int> claimDay = {}; // citoyen → jour de sa dernière demande d'assurance-emploi admissible
  int dividends = 0, loans = 0, claims = 0, priceChecks = 0, wageChecks = 0, refusals = 0;
  final List<String> negativeEquityDividends = [];
  final Set<int> unpaidInsuredDays = {}; // jours où un jour assurable a été compté sans salaire ni cotisation

  void fail(String what) {
    if (failures.length < 20) failures.add(what);
  }
}

void play(Case c, int days, Watch w) {
  final s = c.sim;
  final p = s.params;
  s.trace = (e) {
    if (e.category == 'compta' && e.type == 'dividende' && s.modules.dividendTest) {
      // P1 (I1) : l'événement suit le versement ; les fonds propres d'avant y ajoutent le dividende
      w.dividends++;
      final f = s.firm(e.id!)!;
      final before = equity(s, f) + e.amount;
      if (before < 0) w.negativeEquityDividends.add('jour ${e.day}, ${f.name} : fonds propres ${before.round()} \$, '
          'dividende ${e.amount.toStringAsFixed(2)} \$, trésorerie ${f.money.round()} \$, dette ${f.debt.round()} \$');
    }
    if (e.category == 'credit' && e.type == 'pret' && s.modules.bankRegulation) {
      // P4 (I4) : prêt accordé → fonds propres de la Caisse ≥ plancher × encours, prêt compris
      w.loans++;
      final floor = s.safeguards.minCapitalRatio * s.totalDebt();
      if (s.bank.equity < floor - 1e-6) {
        w.fail('jour ${e.day}, prêt à ${e.agent} : fonds propres ${s.bank.equity} < plancher $floor');
      }
    }
    if (e.category == 'institutions' && e.type == 'demande_ae') {
      // P5 (I3) : une demande n'est admise qu'avec assez de jours d'emploi assurable et un dernier salaire
      w.claims++;
      final ci = s.citizen(e.id!)!;
      if (!s.modules.insurance) w.fail('jour ${e.day} : demande d’assurance-emploi alors que le module est coupé');
      if (ci.insuredDays < p.eiQualifyingDays || ci.lastWage <= 0) {
        w.fail('jour ${e.day}, ${ci.name} : demande admise avec ${ci.insuredDays} j assurables '
            '(minimum ${p.eiQualifyingDays}), dernier salaire ${ci.lastWage}');
      }
      w.claimDay[ci.id] = e.day;
    }
  };

  var prices = <int, Map<String, double>>{};
  var wages = <int, double>{};
  var insured = <int, int>{};
  for (var d = 1; d <= days; d++) {
    for (final sh in c.shocks) {
      if (sh.$1 == d) sh.$2(s);
    }
    s.step();

    // P2 : prix et salaire du jour dans ±priceMaxDaily / ±wageMaxDaily de la veille. Module jobs : le salaire affiché
    // (le salaire de l'entreprise y est la moyenne des contrats, qui change à chaque embauche ; voir emplois_test.dart)
    for (final f in s.firms) {
      final old = prices[f.id];
      if (old != null) {
        for (final g in f.outputs.keys) {
          final a = old[g]!, b = f.price[g]!;
          w.priceChecks++;
          if (b == 0.01 && a <= 0.01 / (1 - p.priceMaxDaily)) continue; // prix plancher
          if (b > a * (1 + p.priceMaxDaily) * (1 + 1e-12) || b < a * (1 - p.priceMaxDaily) * (1 - 1e-12)) {
            w.fail('jour $d, ${f.name}, prix de $g : $a → $b (${(b / a - 1) * 100} %)');
          }
        }
      }
      final ow = wages[f.id];
      if (ow != null) {
        w.wageChecks++;
        final b = s.modules.jobs ? f.offer : f.wage;
        final floor = b == (p.minWage > 1 ? p.minWage : 1.0);
        if (!floor && (b > ow * (1 + p.wageMaxDaily) * (1 + 1e-12) || b < ow * (1 - p.wageMaxDaily) * (1 - 1e-12))) {
          w.fail('jour $d, ${f.name}, salaire : $ow → $b');
        }
      }
    }
    prices = {for (final f in s.firms) f.id: Map.of(f.price)};
    wages = {for (final f in s.firms) f.id: s.modules.jobs ? f.offer : f.wage};

    // P3 : postes pourvus ≤ population ; un citoyen a au plus un employeur, et les deux registres concordent
    final seen = <int, int>{};
    var posts = 0;
    for (final f in s.firms) {
      posts += f.workers.length;
      for (final id in f.workers) {
        final prev = seen[id];
        if (prev != null) w.fail('jour $d : citoyen $id employé par $prev et ${f.id}');
        seen[id] = f.id;
        final ci = s.citizen(id);
        if (ci == null) {
          w.fail('jour $d, ${f.name} : employé $id inexistant');
        } else if (ci.employer != f.id) {
          w.fail('jour $d, ${f.name} : employé ${ci.name} dont l’employeur est ${ci.employer}');
        }
      }
    }
    if (posts > s.citizens.length) w.fail('jour $d : $posts postes pourvus pour ${s.citizens.length} citoyens');
    for (final ci in s.citizens) {
      if (ci.employer != null && seen[ci.id] != ci.employer) {
        w.fail('jour $d, ${ci.name} : employeur ${ci.employer} qui ne le compte pas');
      }
    }

    // P5 (I3) : prestations seulement sur demande admise, pendant la période de chômage en cours ; un jour assurable
    // seulement quand le salaire (et donc la cotisation) a été versé
    if (!s.modules.insurance && s.state.eiPaid != 0) w.fail('jour $d : assurance-emploi versée, module coupé');
    for (final ci in s.citizens) {
      // payé aujourd'hui : sans emploi au moment des prestations (daysUnemployed ≥ 1). Un citoyen mis à pied plus tard
      // dans la journée garde les jours restants d'une ancienne demande ; son dossier est revu le lendemain.
      if (s.modules.insurance && ci.employer == null && ci.daysUnemployed >= 1 && ci.eiDaysLeft > 0) {
        final cd = w.claimDay[ci.id];
        final spell = d - ci.daysUnemployed + 1;
        if (cd == null || cd < spell) w.fail('jour $d, ${ci.name} : prestations sans demande pendant ce chômage');
      }
      final before = insured[ci.id];
      if (before != null && ci.insuredDays > before) {
        final f = ci.employer != null ? s.firm(ci.employer!) : null;
        if (ci.insuredDays != before + 1) w.fail('jour $d, ${ci.name} : ${ci.insuredDays - before} jours assurables');
        if (f != null && f.wagesPaid <= 0) w.unpaidInsuredDays.add(d); // écart connu, voir le test dédié
      }
    }
    insured = {for (final ci in s.citizens) ci.id: ci.insuredDays};
  }
  w.refusals = s.bank.refusals;
}

const String nl = '\n';

void main() {
  const cases = 24, days = 250;
  final failures = <String>[];
  final dividends = <String>[];
  final unpaid = <String>[];
  var totals = [0, 0, 0, 0, 0, 0];
  var played = false;

  void playAll() {
    if (played) return;
    played = true;
    for (var n = 1; n <= cases; n++) {
      final c = Case(n, days);
      final w = Watch();
      try {
        play(c, days, w);
      } catch (e) {
        failures.add('${c.label} : exception $e');
        continue;
      }
      for (final x in w.failures) {
        failures.add('cas $n, $x');
      }
      for (final x in w.negativeEquityDividends) {
        dividends.add('cas $n, $x');
      }
      final bankruptDays = {for (final sh in c.shocks) if (sh.$3 == 'faillite') sh.$1};
      for (final d in w.unpaidInsuredDays) {
        if (!bankruptDays.contains(d)) unpaid.add('cas $n, jour $d (${c.label})');
      }
      totals = [
        totals[0] + w.dividends,
        totals[1] + w.loans,
        totals[2] + w.claims,
        totals[3] + w.priceChecks,
        totals[4] + w.wageChecks,
        totals[5] + w.refusals,
      ];
    }
  }

  test('propriétés sur $cases parties tirées au hasard ($days jours chacune)', () {
    playAll();
    expect(failures, isEmpty, reason: failures.take(10).join(nl));
    // les propriétés ont bien été exercées
    expect(totals.every((t) => t > 0), isTrue, reason: 'dividendes, prêts, demandes, prix, salaires : $totals');
    // ignore: avoid_print
    print('Vérifiés : ${totals[0]} dividendes, ${totals[1]} prêts, ${totals[2]} demandes d’assurance-emploi, '
        '${totals[3]} prix, ${totals[4]} salaires ; ${totals[5]} prêts refusés.');
  });

  test('I1 : aucune entreprise à fonds propres négatifs ne verse de dividende', () {
    playAll();
    expect(dividends, isEmpty, reason: dividends.take(5).join(nl));
  });

  // Recherche limitée des vendeurs (sellerSample > 0), mission « liste des vendeurs disponibles ». `verifyFastPaths`
  // fait vérifier par le moteur, avant chaque achat de ménage, que la liste de chaque bien est exactement l'ensemble des
  // entreprises actives avec une unité en stock, et, à chaque achat d'une unité sans offre, qu'aucun autre vendeur n'a
  // d'unité en stock (pas de fausse pénurie). Le test vérifie aussi la liste après chaque jour (chocs du god mode
  // compris : stocks détruits, faillites, arrivées et départs) et que le détecteur du moniteur reste muet.
  test('vendeurs disponibles : liste exacte et aucune fausse pénurie, avec k = 3, 5, 8 (12 parties)', () {
    var purchases = 0;
    for (var n = 1; n <= 12; n++) {
      final c = Case(100 + n, 150);
      final s = c.sim;
      s.params.sellerSample = const [3, 5, 8][n % 3];
      s.verifyFastPaths = true;
      for (var d = 1; d <= 150; d++) {
        for (final sh in c.shocks) {
          if (sh.$1 == d) sh.$2(s);
        }
        s.step();
        expect(s.availMismatches(), isEmpty, reason: '${c.label} jour $d');
        expect(s.monitor.active.containsKey('listeVendeurs'), isFalse, reason: '${c.label} jour $d');
      }
      purchases += s.marketStats.values.fold(0, (a, m) => a + (m.qty > 0 ? 1 : 0));
    }
    expect(purchases, greaterThan(0));
  });

  // Écart connu (rapporté, non corrigé : la règle reste à décider). Un jour où l'entreprise n'a rien en caisse, ses
  // employés ne sont pas payés et ne cotisent pas, mais le jour compte quand même comme emploi assurable. Une paie
  // partielle cotise toujours ; une caisse vide à la paie ne s'observe qu'après une faillite du god mode.
  test('I3 : un jour assurable sans cotisation n’arrive que le jour d’une faillite du god mode', () {
    playAll();
    expect(unpaid, isEmpty, reason: unpaid.take(5).join(nl));
  });
}
