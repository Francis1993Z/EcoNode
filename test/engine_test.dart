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
    s.godBankrupt(s.firms.firstWhere((f) => f.type == 'raffinerie').id);
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
    final s = Sim(seed: 9, safeguards: Safeguards.none());
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

  test('modules coupés : ni machines, ni dette, ni publicité, invariants exacts', () {
    final s = Sim(seed: 10, modules: Modules.none(), devChecks: true);
    run(s, 300);
    expect(s.totalDebt(), 0);
    expect(s.bank.lent, 0);
    expect(s.firms.every((f) => f.machines == 0 && f.brand == 0 && f.adminCover == 1), isTrue);
    expect(s.inv.worst, 0);
  });
}
