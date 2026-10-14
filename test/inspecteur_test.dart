// Inspecteur (interface) : les employés d'une entreprise, avec leur rôle, leur salaire et leur ancienneté ;
// l'organigramme ; les négociations récentes ; la fiche d'un citoyen. Le panneau est construit sur une surface assez
// haute pour que toute la liste soit bâtie (ListView ne construit que ce qui est visible).

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:econodes/ui/controller.dart';
import 'package:econodes/ui/format.dart';
import 'package:econodes/ui/inspector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> show(WidgetTester tester, SimController ctrl) async {
  tester.view.physicalSize = const Size(460, 20000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(MaterialApp(home: Scaffold(body: InspectorTab(ctrl))));
}

void main() {
  testWidgets('entreprise : chaque employé avec son rôle, son salaire et son ancienneté ; organigramme ; négociations',
      (tester) async {
    final ctrl = SimController(seed: 7);
    expect(ctrl.sim.modules.jobs, isTrue, reason: 'l’interface lance ses parties avec le module');
    for (var d = 0; d < 120; d++) {
      ctrl.sim.step();
    }
    final sim = ctrl.sim;
    final f = sim.firms.where((f) => f.talks.isNotEmpty && f.workers.length >= 3).reduce(
        (a, b) => a.workers.length >= b.workers.length ? a : b);
    ctrl.selection = Selection('firm', f.id);
    await show(tester, ctrl);

    expect(find.text('EMPLOYÉS (${f.workers.length})'), findsOneWidget);
    expect(find.text('ORGANIGRAMME'), findsOneWidget);
    expect(find.text('NÉGOCIATIONS RÉCENTES'), findsOneWidget);
    for (final id in f.workers) {
      final c = sim.citizen(id)!;
      final role = roles[f.type]![c.role].label;
      expect(find.text(c.name), findsWidgets, reason: '${c.name} absent de la liste');
      expect(find.textContaining(role), findsWidgets, reason: 'rôle $role absent');
      expect(find.text(money0(c.wage)), findsWidgets, reason: 'salaire de ${c.name} absent');
      expect(find.text(tenureLabel(sim.tenure(c))), findsWidgets, reason: 'ancienneté de ${c.name} absente');
    }
    // chaque rôle de l'organigramme, avec sa qualification
    for (final r in roles[f.type]!) {
      expect(find.textContaining(roleRequirement(r)), findsWidgets, reason: r.label);
    }

    // toucher un employé ouvre sa fiche : rôle, contrat, ancienneté, salaire de réserve
    final c = sim.citizen(f.workers.first)!;
    await tester.tap(find.text(c.name).first);
    await tester.pump();
    expect(ctrl.selection, Selection('citizen', c.id));
    await show(tester, ctrl);
    expect(find.text('Rôle'), findsOneWidget);
    expect(find.text(roles[f.type]![c.role].label), findsWidgets);
    expect(find.text('Salaire du contrat'), findsOneWidget);
    expect(find.text('Ancienneté'), findsOneWidget);
    expect(find.text('Salaire pour changer d’emploi'), findsOneWidget);
  });

  testWidgets('module coupé : la liste montre le salaire unique et propose d’activer le module', (tester) async {
    final ctrl = SimController(seed: 7)..sim = Sim(seed: 7);
    for (var d = 0; d < 30; d++) {
      ctrl.sim.step();
    }
    final f = ctrl.sim.firms.reduce((a, b) => a.workers.length >= b.workers.length ? a : b);
    ctrl.selection = Selection('firm', f.id);
    await show(tester, ctrl);
    expect(find.text('EMPLOYÉS (${f.workers.length})'), findsOneWidget);
    expect(find.text('ORGANIGRAMME'), findsNothing);
    expect(find.text(money0(f.wage)), findsWidgets);
    await tester.tap(find.byType(SwitchListTile).first);
    await tester.pump();
    expect(ctrl.sim.modules.jobs, isTrue);
  });
}
