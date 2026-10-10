// Tests du moteur v2 : déterminisme, invariants comptables exacts à chaque jour (mode développement),
// filets et détecteurs provoqués, modules coupés. Le protocole de stabilité complet est dans tool/stabilite.dart.

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

void run(Sim s, int days) {
  for (var i = 0; i < days; i++) {
    s.step();
  }
}

void main() {
  test('mulberry32 : deux instances de même graine donnent la même suite', () {
    final r = Mulberry32(42), r2 = Mulberry32(42);
    for (var i = 0; i < 100; i++) {
      final a = r.next();
      expect(a >= 0 && a < 1, isTrue);
      expect(r2.next(), a);
    }
  });

  test('déterminisme : même graine, même partie', () {
    final a = Sim(seed: 7), b = Sim(seed: 7);
    run(a, 300);
    run(b, 300);
    for (var i = 0; i < a.history.length; i++) {
      final x = a.history[i], y = b.history[i];
      expect(y.unemp, x.unemp);
      expect(y.total, x.total);
      expect(y.cpi, x.cpi);
      expect(y.gini, x.gini);
    }
    expect(b.events.length, a.events.length);
    expect(b.nets.total(), a.nets.total());
  });

  test('invariants comptables exacts à chaque jour, avec et sans filets', () {
    for (final seed in [1, 2]) {
      final s = Sim(seed: seed, devChecks: true); // lève une exception au premier écart
      run(s, 1500);
      expect(s.inv.worst, 0, reason: 'graine $seed');
      expect(s.totalMoney(), s.expectedMoney());
    }
    final s = Sim(seed: 3, safeguards: Safeguards.none(), devChecks: true);
    run(s, 800);
    expect(s.inv.worst, 0);
  });

  test('god mode : injections, crédit, faillite, fermeture gardent les invariants exacts', () {
    final s = Sim(seed: 5, devChecks: true);
    run(s, 100);
    s.godMoney(const Target('allCitizens'), 5000);
    s.godMoney(const Target('allFirms'), -1000);
    s.godMoney(const Target('bank'), 20000);
    s.setUBI(20);
    s.setTrade(true);
    s.godAddCitizens(10, 1000);
    s.addFirm('restaurant', 'Chez Francis', 20000, null, 600, 300);
    run(s, 200);
    s.godRemoveCitizens(5);
    final indebted = s.firms.where((f) => f.debt > 0).toList();
    if (indebted.isNotEmpty) s.godFirm(indebted.first.id, forgiveDebt: true);
    s.godBankrupt(s.firms.firstWhere((f) => f.workers.isNotEmpty).id); // la raffinerie a pu fermer et renaître
    s.removeFirm(s.firms.first.id);
    run(s, 100);
    expect(s.inv.worst, 0);
    expect(s.totalMoney(), s.expectedMoney());
  });

  test('anti-famine : sans aucun aliment, l’État nourrit et la cause est « pas de producteur »', () {
    final s = Sim(seed: 4);
    for (final t in ['boulangerie', 'boucherie', 'peche', 'restaurant']) {
      s.removeFirm(s.firms.firstWhere((f) => f.type == t).id);
    }
    run(s, 10);
    expect(s.nets.total('famine'), greaterThan(0));
    expect(s.nets.causes['famine']!.containsKey('pas de producteur'), isTrue);
    expect(s.citizens.every((c) => c.hungerDays < s.safeguards.famineDays), isTrue);
  });

  test('plancher de logement : sans parc immobilier, abri d’urgence pour cause de « parc plein »', () {
    final s = Sim(seed: 4);
    s.removeFirm(s.firms.firstWhere((f) => f.type == 'immobilier').id);
    run(s, 10);
    expect(s.nets.total('shelter'), greaterThan(0));
    expect(s.nets.causes['shelter']!.containsKey('parc plein'), isTrue);
  });

  test('un filet coupé ne se déclenche plus ; chaque déclenchement est compté une fois', () {
    final s = Sim(seed: 6);
    run(s, 150);
    for (final k in Safeguards.keys) {
      final byAgent = (s.nets.byAgent[k] ?? const <String, int>{}).values.fold(0, (a, b) => a + b);
      expect(byAgent, s.nets.total(k), reason: k);
      s.safeguards.set(k, false);
    }
    final before = {for (final k in Safeguards.keys) k: s.nets.total(k)};
    run(s, 50);
    for (final k in Safeguards.keys) {
      expect(s.nets.total(k), before[k], reason: k);
    }
  });

  test('détecteur d’invariant : de l’argent apparu hors grand livre ouvre une alerte critique', () {
    final s = Sim(seed: 8);
    run(s, 20);
    s.citizens.first.money += 1; // création monétaire sauvage
    s.step();
    expect(s.inv.money, closeTo(1, 1e-9));
    expect(s.monitor.active.containsKey('invariant'), isTrue);
    expect(s.monitor.active['invariant']!.critical, isTrue);
    final dev = Sim(seed: 8, devChecks: true);
    run(dev, 20);
    dev.citizens.first.money += 1;
    expect(dev.step, throwsStateError);
  });

  test('détecteurs : entreprise sans employé, chômage très élevé', () {
    // sans entrée ni sortie d'entreprises : on teste les détecteurs, pas la résorption du chômage
    final s = Sim(seed: 9, safeguards: Safeguards.none(), modules: Modules()..entry = false);
    run(s, 30);
    final f = s.firms.firstWhere((f) => f.type == 'tourisme');
    s.godBankrupt(f.id);
    for (final o in s.firms.where((o) => o.type != 'tourisme').take(18).toList()) {
      s.removeFirm(o.id);
    }
    run(s, 60);
    expect(s.monitor.opened['sansEmploye'] ?? 0, greaterThan(0));
    expect(s.monitor.opened['chomageHaut'] ?? 0, greaterThan(0));
    final a = s.monitor.active['chomageHaut'];
    if (a != null) {
      expect(a.since, lessThanOrEqualTo(s.day - s.monitor.cfg.unempDays + 1));
    }
  });

  test('détecteurs de causes : santé, efficacité, pénurie de main-d’œuvre, prix aberrant', () {
    // santé : sans hôpital (ni création d'entreprise), une population mal en point ne se soigne plus
    final s = Sim(seed: 11, modules: Modules()..entry = false);
    run(s, 20);
    for (final f in s.firms.where((f) => f.type == 'hopital').toList()) {
      s.removeFirm(f.id);
    }
    for (final c in s.citizens) {
      c.sat['sante'] = 0.3;
    }
    run(s, 35);
    expect(s.monitor.active['sante']?.critical, isTrue);
    expect(s.monitor.active['sante']!.agents, contains('aucun hôpital'));
    expect(s.monitor.active.containsKey('efficacite'), isTrue);
    expect(s.monitor.active['efficacite']!.agents.first, startsWith('santé'));

    // pénurie de main-d'œuvre : des entreprises qui ont de quoi embaucher ouvrent des postes que personne ne pourvoit
    // (persistance réduite : on teste la condition, pas la durée)
    final p = Sim(seed: 1, modules: Modules()..entry = false);
    run(p, 150);
    expect(p.monitor.active.containsKey('penurieTravail'), isFalse);
    p.monitor.cfg.laborShortageDays = 10;
    p.godMoney(const Target('allFirms'), 100000);
    for (final f in p.firms) {
      p.godFirm(f.id, prodMult: 0.33);
    }
    run(p, 15);
    expect(p.monitor.active.containsKey('penurieTravail'), isTrue);

    // embauches bloquées : sans trésorerie, une entreprise ne peut pas rouvrir les postes qu'elle voudrait
    final b = Sim(seed: 9, safeguards: Safeguards.none(), modules: Modules()..entry = false);
    run(b, 30);
    b.godBankrupt(b.firms.firstWhere((f) => f.type == 'restaurant').id);
    run(b, 45);
    expect(b.monitor.active['embaucheBloquee']?.value, greaterThan(0.1));

    // prix aberrant : le logement vendu 8 fois son prix de référence pendant plus de 30 jours
    final q = Sim(seed: 1, modules: Modules()..entry = false);
    run(q, 150);
    final im = q.firms.firstWhere((f) => f.type == 'immobilier');
    final key = 'prixAberrant:${im.id}';
    expect(q.monitor.active.containsKey(key), isFalse);
    q.godFirm(im.id, prices: {'logement': 8 * q.referencePrice('logement')}, lockPrice: true);
    run(q, 32);
    expect(q.monitor.active[key]?.value, greaterThan(5));
  });

  test('modules coupés : ni machines, ni dette, ni publicité, invariants exacts', () {
    final s = Sim(seed: 10, modules: Modules.none(), devChecks: true);
    run(s, 300);
    expect(s.totalDebt(), 0);
    expect(s.bank.lent, 0);
    expect(s.firms.every((f) => f.machines == 0 && f.brand == 0 && f.adminCover == 1), isTrue);
    expect(s.inv.worst, 0);
  });
}
