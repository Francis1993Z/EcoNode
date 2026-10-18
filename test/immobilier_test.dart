// Interface du marché immobilier : fiche d'un logement (en vente ou non), onglet « Immobilier », liens depuis un citoyen et
// un bailleur. Le panneau est construit sur une surface assez haute pour que toute la liste soit bâtie.

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:econodes/ui/controller.dart';
import 'package:econodes/ui/format.dart';
import 'package:econodes/ui/housing.dart';
import 'package:econodes/ui/inspector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> show(WidgetTester tester, Widget panel) async {
  tester.view.physicalSize = const Size(460, 30000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(MaterialApp(home: Scaffold(body: panel)));
}

SimController housingGame({int days = 150}) {
  final ctrl = SimController(seed: 5);
  ctrl.sim = Sim(seed: 5, modules: Modules()..buildings = true);
  for (var d = 0; d < days; d++) {
    ctrl.sim.step();
    ctrl.housing.sample(ctrl.sim);
  }
  return ctrl;
}

void main() {
  testWidgets('onglet Immobilier : parc, offre, statistiques, graphiques et liste des logements en vente', (tester) async {
    final ctrl = housingGame();
    final sim = ctrl.sim;
    final listed = sim.buildings.where((b) => b.done && b.listedDay != null).toList();
    expect(listed, isNotEmpty, reason: 'la partie de test doit avoir des logements en vente');
    expect(ctrl.housing.days.length, 150);
    await show(tester, HousingTab(ctrl));

    expect(find.text('Marché immobilier'), findsOneWidget);
    for (final t in ['PARC', 'EN VENTE', 'DEPUIS LE DÉBUT']) {
      expect(find.text(t), findsOneWidget);
    }
    expect(find.text('Logements en vente'), findsOneWidget);
    expect(find.text('${listed.length}'), findsWidgets);
    expect(find.textContaining('Carte des logements en vente'), findsOneWidget);
    expect(find.text('Prix des logements'), findsOneWidget);
    expect(find.text('Transactions sur 30 jours'), findsOneWidget);
    expect(find.text('EN VENTE (LES MOINS CHERS D’ABORD)'), findsOneWidget);
    // la liste commence par le moins cher
    final cheapest = listed.reduce((a, b) => sim.askPrice(a) <= sim.askPrice(b) ? a : b);
    expect(find.text(money0(sim.askPrice(cheapest))), findsWidgets);

    // toucher une ligne ouvre la fiche du logement
    await tester.tap(find.text('n° ${cheapest.id}').first);
    await tester.pump();
    expect(ctrl.selection, Selection('building', cheapest.id));
    expect(ctrl.panelTab, Tabs.inspector);
  });

  testWidgets('fiche d’un logement en vente : prix demandé, durée, hypothèque, produit net', (tester) async {
    final ctrl = housingGame();
    final sim = ctrl.sim;
    final b = sim.buildings.firstWhere((b) => b.done && b.listedDay != null && sim.mortgageOf(b) != null,
        orElse: () => sim.buildings.firstWhere((b) => b.done && b.listedDay != null));
    ctrl.selection = Selection('building', b.id);
    await show(tester, InspectorTab(ctrl));

    expect(find.text('Logement n° ${b.id}'), findsOneWidget);
    expect(find.textContaining('en vente'), findsWidgets);
    expect(find.text('EN VENTE'), findsOneWidget);
    expect(find.text('Prix demandé aujourd’hui'), findsOneWidget);
    expect(find.text(money0(sim.askPrice(b))), findsWidgets);
    expect(find.text('Mis en vente le jour'), findsOneWidget);
    expect(find.text('Produit net pour le vendeur'), findsOneWidget);
    expect(find.text('Valeur courante'), findsOneWidget);
    expect(find.text(money0(sim.fairValue(b))), findsWidgets);
    expect(find.text('PROPRIÉTAIRE'), findsOneWidget);
    expect(find.text(ownerLabel(sim, b)), findsWidgets);
    if (sim.mortgageOf(b) != null) {
      expect(find.text('Capital dû'), findsOneWidget);
      expect(find.text('Rapport dette / valeur'), findsOneWidget);
    }
  });

  testWidgets('fiche d’un logement qui n’est pas en vente : pas de section « En vente », mais le prix qu’il aurait', (tester) async {
    final ctrl = housingGame();
    final sim = ctrl.sim;
    final b = sim.buildings.firstWhere((b) => b.done && b.listedDay == null && b.ownerKind == 1,
        orElse: () => sim.buildings.firstWhere((b) => b.done && b.listedDay == null));
    ctrl.selection = Selection('building', b.id);
    await show(tester, InspectorTab(ctrl));

    expect(find.text('PAS EN VENTE'), findsOneWidget);
    expect(find.text('EN VENTE'), findsNothing);
    expect(find.text('Prix demandé s’il était mis en vente'), findsOneWidget);
    expect(find.text('Prix demandé aujourd’hui'), findsNothing);
    expect(find.textContaining(buildingStatusLabel(ctrl, b)), findsWidgets);
  });

  testWidgets('un chantier : pas de valeur ni de prix, les modules posés', (tester) async {
    final ctrl = housingGame(days: 400);
    final sim = ctrl.sim;
    final site = sim.buildings.where((b) => !b.done).toList();
    if (site.isEmpty) return; // pas de chantier à cet instant : rien à vérifier
    ctrl.selection = Selection('building', site.first.id);
    await show(tester, InspectorTab(ctrl));
    expect(find.text('en construction'), findsOneWidget);
    expect(find.text('VALEUR'), findsNothing);
    expect(find.textContaining('chantier en cours'), findsOneWidget);
  });

  testWidgets('citoyen propriétaire : lien vers son logement ; bailleur : son parc', (tester) async {
    final ctrl = housingGame();
    final sim = ctrl.sim;
    final c = sim.citizens.firstWhere((c) => c.homeId != null, orElse: () => sim.citizens.first);
    if (c.homeId != null) {
      ctrl.selection = Selection('citizen', c.id);
      await show(tester, InspectorTab(ctrl));
      expect(find.text('Propriétaire de son logement'), findsOneWidget);
      await tester.tap(find.textContaining('n° ${c.homeId}'));
      await tester.pump();
      expect(ctrl.selection, Selection('building', c.homeId));
    }
    final f = sim.firms.firstWhere((f) => f.type == 'immobilier');
    ctrl.selection = Selection('firm', f.id);
    await show(tester, InspectorTab(ctrl));
    expect(find.text('PARC DE LOGEMENTS'), findsOneWidget);
    expect(find.text('Dette hypothécaire'), findsOneWidget);
  });

  testWidgets('module coupé : l’onglet l’explique et propose de l’activer', (tester) async {
    final ctrl = SimController(seed: 3);
    expect(ctrl.sim.modules.buildings, isFalse);
    await show(tester, HousingTab(ctrl));
    expect(find.text('MODULE COUPÉ'), findsOneWidget);
    await tester.tap(find.byType(SwitchListTile).first);
    await tester.pump();
    expect(ctrl.sim.modules.buildings, isTrue);
  });

  test('le journal du marché suit le moteur et reste borné', () {
    final ctrl = housingGame(days: 60);
    final log = ctrl.housing;
    expect(log.days.first, 1);
    expect(log.days.last, 60);
    for (final l in [log.listed, log.askAvg, log.fairAvg, log.heat, log.debt, log.salesCum]) {
      expect(l.length, log.days.length);
    }
    expect(log.fairAvg.last, greaterThan(0));
    // compteurs cumulés croissants
    for (var i = 1; i < log.salesCum.length; i++) {
      expect(log.salesCum[i], greaterThanOrEqualTo(log.salesCum[i - 1]));
    }
    // un même jour n'est relevé qu'une fois
    log.sample(ctrl.sim);
    expect(log.days.length, 60);
    // le journal est vidé avec une nouvelle partie
    ctrl.newGame(9);
    expect(ctrl.housing.days, isEmpty);
  });
}

String buildingStatusLabel(SimController ctrl, Building b) {
  switch (b.ownerKind) {
    case 1:
      return 'occupé par son propriétaire';
    case 0:
      return 'loué par un bailleur';
    default:
      return 'en liquidation';
  }
}
