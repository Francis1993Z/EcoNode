// Paramètres de départ d'une nouvelle partie : ceux qui fixent l'état du jour 0 (argent, salaires, prix, État, Caisse,
// banques). L'écran de départ et l'onglet Modèle éditent les mêmes valeurs (SimController.startParams).

import 'package:flutter/material.dart';

import '../engine/model.dart';
import 'palette.dart';
import 'widgets.dart';

/// Un paramètre de départ : libellé, unité, bornes, lecture et écriture.
class StartParam {
  final String group, label, suffix, hint;
  final int decimals;
  final double min, max;
  final double Function(Params) get;
  final void Function(Params, double) set;
  const StartParam(this.group, this.label, this.get, this.set,
      {this.suffix = '', this.decimals = 0, this.min = 0, this.max = 1e9, this.hint = ''});
}

final List<StartParam> startParamDefs = [
  StartParam('Économie', 'Argent par citoyen', (p) => p.startWallet, (p, v) => p.startWallet = v,
      suffix: '\$', max: 1e7, hint: 'Épargne moyenne au jour 0 (plus pour les plus qualifiés).'),
  StartParam('Économie', 'Salaire de base', (p) => p.startWage, (p, v) => p.startWage = v,
      suffix: '\$/j', min: 1, max: 1e5, hint: 'Salaire d’un manœuvre au départ ; les autres classes en sont des multiples.'),
  StartParam('Économie', 'Marge de base', (p) => p.markup, (p, v) => p.markup = v,
      decimals: 2, min: 1, max: 3, hint: 'Prix = coût de revient × marge.'),
  StartParam('Économie', 'Salaire minimum', (p) => p.minWage, (p, v) => p.minWage = v, suffix: '\$/j', max: 1e5),
  StartParam('État', 'Taux d’imposition', (p) => p.taxRate * 100, (p, v) => p.taxRate = v / 100,
      suffix: '%', decimals: 1, max: 90),
  StartParam('État', 'Prestation de base', (p) => p.benefit, (p, v) => p.benefit = v,
      suffix: '\$/j', max: 1e5, hint: 'Panier de survie versé aux sans-emploi (aide sociale).'),
  StartParam('Ménages', 'Coussin des ménages', (p) => p.bufferDays, (p, v) => p.bufferDays = v.roundToDouble(),
      suffix: 'j', min: 1, max: 365, hint: 'Jours de survie gardés avant toute dépense de loisir.'),
  StartParam('Ménages', 'Veulent posséder', (p) => p.ownerShare * 100, (p, v) => p.ownerShare = v / 100,
      suffix: '%', max: 100, hint: 'Logement (bâtiments) et désir de fonder (entrepreneuriat).'),
  StartParam('Entreprises', 'Délai entre créations', (p) => p.entryCooldown.toDouble(),
      (p, v) => p.entryCooldown = v.round(), suffix: 'j', max: 3650, hint: 'Délai minimal entre deux créations d’un même type d’entreprise.'),
  StartParam('Entreprises', 'Jours sans employé', (p) => p.exitIdleDays.toDouble(),
      (p, v) => p.exitIdleDays = v.round(), suffix: 'j', min: 1, max: 3650, hint: 'Une entreprise sans employé depuis ce nombre de jours ferme.'),
  StartParam('Crédit', 'Taux d’intérêt annuel', (p) => p.interestRate * 100, (p, v) => p.interestRate = v / 100,
      suffix: '%', decimals: 1, max: 50),
  StartParam('Crédit', 'Capital Caisse / citoyen', (p) => p.bankCapitalPerCitizen,
      (p, v) => p.bankCapitalPerCitizen = v, suffix: '\$', max: 1e7),
  StartParam('Crédit', 'Banques de départ', (p) => p.nBanks.toDouble(), (p, v) => p.nBanks = v.round(),
      min: 1, max: 20, hint: 'Module « Crédit et banques » : 1, la Caisse seule.'),
  StartParam('Crédit', 'Dotation / citoyen / banque', (p) => p.reservePerCitizen, (p, v) => p.reservePerCitizen = v,
      suffix: '\$', max: 1e7, hint: 'Réserves de chaque banque de départ (module « Crédit et banques », 2 banques ou plus).'),
];

/// Copie des paramètres de départ dans un Params neuf (les autres paramètres gardent leur valeur par défaut).
Params freshParams(Params start, int population) {
  final n = Params()
    ..population = population
    ..trade = start.trade;
  for (final d in startParamDefs) {
    d.set(n, d.get(start));
  }
  return n;
}

/// Éditeur des paramètres de départ, groupés, deux par ligne.
class StartParamsEditor extends StatelessWidget {
  final Params p;
  final VoidCallback onChanged;
  const StartParamsEditor(this.p, {super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final groups = <String, List<StartParam>>{};
    for (final d in startParamDefs) {
      (groups[d.group] ??= []).add(d);
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (final g in groups.entries) ...[
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 4),
          child: Text(g.key, style: TextStyle(color: pal.ink3, fontSize: 11, fontWeight: FontWeight.w700)),
        ),
        LayoutBuilder(
          builder: (context, box) {
            final w = box.maxWidth >= 320 ? (box.maxWidth - 8) / 2 : box.maxWidth;
            return Wrap(spacing: 8, runSpacing: 8, children: [
              for (final d in g.value)
                SizedBox(
                  width: w,
                  child: Tooltip(
                    message: d.hint,
                    child: NumField(
                      label: d.label,
                      value: d.get(p),
                      suffix: d.suffix,
                      decimals: d.decimals,
                      onSubmit: (v) {
                        d.set(p, v.clamp(d.min, d.max).toDouble());
                        onChanged();
                      },
                    ),
                  ),
                ),
            ]);
          },
        ),
      ],
      SwitchListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: const Text('Commerce extérieur', style: TextStyle(fontSize: 13)),
        subtitle: const Text('Importations et exportations au prix mondial.', style: TextStyle(fontSize: 11)),
        value: p.trade,
        onChanged: (v) {
          p.trade = v;
          onChanged();
        },
      ),
      TextButton.icon(
        onPressed: () {
          final d = Params();
          for (final x in startParamDefs) {
            x.set(p, x.get(d));
          }
          p.trade = d.trade;
          onChanged();
        },
        icon: const Icon(Icons.restore, size: 16),
        label: const Text('Valeurs par défaut'),
      ),
    ]);
  }
}
