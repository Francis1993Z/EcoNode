// Onglet God mode : injections, catastrophes, population, nouvelles entreprises, grand livre.

import 'package:flutter/material.dart';

import '../engine/model.dart';
import 'controller.dart';
import 'format.dart';
import 'palette.dart';
import 'widgets.dart';

class GodTab extends StatefulWidget {
  final SimController ctrl;
  const GodTab(this.ctrl, {super.key});
  @override
  State<GodTab> createState() => _GodTabState();
}

class _GodTabState extends State<GodTab> {
  static const targets = <String, String>{
    'allCitizens': 'Tous les citoyens',
    'unemployed': 'Les sans-emploi',
    'allFirms': 'Toutes les entreprises',
    'state': 'L’État',
    'bank': 'La Caisse (fonds propres)',
  };
  String target = 'allCitizens';
  double amount = 500;

  String destroyGood = 'logement';
  double destroyPct = 0.5;
  double sickPct = 0.3;

  double addN = 10;
  double addMoney = 3000;

  String newType = 'restaurant';
  String newName = '';
  double newCapital = 20000;

  double ubi = 0;
  bool ubiInit = false;

  SimController get ctrl => widget.ctrl;

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    if (!ubiInit) {
      ubi = sim.params.ubi;
      ubiInit = true;
    }
    final diff = sim.totalMoney() - sim.expectedMoney();
    return ListView(padding: const EdgeInsets.all(12), children: [
      Section('Argent', [
        DropdownButton<String>(
          isExpanded: true,
          value: target,
          items: [for (final e in targets.entries) DropdownMenuItem(value: e.key, child: Text(e.value))],
          onChanged: (v) => setState(() => target = v ?? target),
        ),
        const SizedBox(height: 6),
        Row(children: [
          Expanded(
              child: NumField(
                  label: 'Montant par tête',
                  value: amount,
                  suffix: '\$',
                  decimals: 0,
                  onSubmit: (v) => setState(() => amount = v.abs()))),
          const SizedBox(width: 8),
          Btn('Injecter', () {
            sim.godMoney(Target(target), amount);
            ctrl.touch();
          }, primary: true),
          const SizedBox(width: 6),
          Btn('Retirer', () {
            sim.godMoney(Target(target), -amount);
            ctrl.touch();
          }),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
              child: NumField(
                  label: 'Revenu de base / jour / citoyen',
                  value: ubi,
                  suffix: '\$',
                  decimals: 0,
                  onSubmit: (v) => setState(() => ubi = v.abs()))),
          const SizedBox(width: 8),
          Btn('Appliquer', () {
            sim.setUBI(ubi);
            ctrl.touch();
          }, primary: true),
        ]),
        Text('Créer de l’argent pousse l’inflation : regarde l’indice des prix, puis le panier de survie.',
            style: TextStyle(color: pal.ink3, fontSize: 11)),
      ]),
      Section('Catastrophes', [
        Row(children: [
          DropdownButton<String>(
            value: destroyGood,
            items: [for (final e in goods.entries) DropdownMenuItem(value: e.key, child: Text(e.value.label))],
            onChanged: (v) => setState(() => destroyGood = v ?? destroyGood),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Slider(
                value: destroyPct,
                min: 0.1,
                max: 1,
                divisions: 9,
                label: pct(destroyPct),
                onChanged: (v) => setState(() => destroyPct = v)),
          ),
          Text(pct(destroyPct), style: mono(pal.ink, 12)),
        ]),
        Btn('Détruire les stocks', () {
          sim.godDestroy(destroyGood, destroyPct);
          ctrl.touch();
        }, danger: true, icon: Icons.local_fire_department),
        const SizedBox(height: 10),
        Row(children: [
          Text('Épidémie', style: TextStyle(color: pal.ink2, fontSize: 12.5)),
          Expanded(
            child: Slider(
                value: sickPct,
                min: 0.05,
                max: 1,
                divisions: 19,
                label: pct(sickPct),
                onChanged: (v) => setState(() => sickPct = v)),
          ),
          Text(pct(sickPct), style: mono(pal.ink, 12)),
        ]),
        Btn('Déclencher l’épidémie', () {
          sim.godEpidemic(sickPct);
          ctrl.touch();
        }, danger: true, icon: Icons.coronavirus_outlined),
      ]),
      Section('Population', [
        Row(children: [
          Expanded(
              child: NumField(
                  label: 'Nombre', value: addN, decimals: 0, onSubmit: (v) => setState(() => addN = v.abs().roundToDouble()))),
          const SizedBox(width: 8),
          Expanded(
              child: NumField(
                  label: 'Argent chacun',
                  value: addMoney,
                  suffix: '\$',
                  decimals: 0,
                  onSubmit: (v) => setState(() => addMoney = v.abs()))),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Btn('Faire arriver', () {
            sim.godAddCitizens(addN.round(), addMoney);
            ctrl.touch();
          }, primary: true),
          const SizedBox(width: 8),
          Btn('Faire partir', () {
            sim.godRemoveCitizens(addN.round());
            ctrl.touch();
          }),
        ]),
      ]),
      Section('Nouvelle entreprise', [
        DropdownButton<String>(
          isExpanded: true,
          value: newType,
          items: [
            for (final e in templates.entries)
              DropdownMenuItem(value: e.key, child: Text('${e.value.label} (${sectorLabels[e.value.sector]!.toLowerCase()})')),
          ],
          onChanged: (v) => setState(() => newType = v ?? newType),
        ),
        const SizedBox(height: 6),
        TextField(
          onChanged: (v) => newName = v,
          decoration: InputDecoration(
            isDense: true,
            labelText: 'Nom (facultatif)',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
              child: NumField(
                  label: 'Capital',
                  value: newCapital,
                  suffix: '\$',
                  decimals: 0,
                  onSubmit: (v) => setState(() => newCapital = v.abs()))),
          const SizedBox(width: 8),
          Btn('Créer', () {
            final f = sim.addFirm(newType, newName.trim().isEmpty ? null : newName.trim(), newCapital, null, 600, 300);
            ctrl.touch();
            ctrl.select(Selection('firm', f.id));
          }, primary: true, icon: Icons.add_business),
        ]),
        Text('Elle apparaît au milieu du graphe ; déplace-la ensuite à la main.', style: TextStyle(color: pal.ink3, fontSize: 11)),
      ]),
      Section('Grand livre de la monnaie', [
        KV('Masse de départ', money0(sim.m0)),
        KV('Injections / retraits divins', money0(sim.ledgerGod)),
        KV('Importations (sortie)', money0(-sim.ledgerImports)),
        KV('Exportations (entrée)', money0(sim.ledgerExports)),
        KV('Crédit net (prêts − remboursements)', money0(sim.ledgerCredit)),
        KV('Masse attendue', money0(sim.expectedMoney())),
        KV('Masse réelle', money0(sim.totalMoney())),
        KV('Écart', diff == 0 ? '0 (exact)' : diff.toStringAsExponential(2), color: diff.abs() < 1e-6 ? pal.ok : pal.bad),
      ]),
      const SizedBox(height: 24),
    ]);
  }
}
