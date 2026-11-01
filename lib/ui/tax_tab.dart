import 'package:flutter/material.dart';

import '../engine/model.dart';
import 'controller.dart';
import 'format.dart';
import 'palette.dart';
import 'widgets.dart';

/// Onglet Impôts : barème de l'impôt sur le revenu (taux unique ou progressif, Params.progressiveTax), ce que chaque tranche
/// paie aujourd'hui, recettes et redistribution de l'État, inégalités.
class TaxTab extends StatelessWidget {
  final SimController ctrl;
  const TaxTab(this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final p = sim.params;
    void upd(void Function() f) {
      f();
      ctrl.touch();
    }

    final w = sim.taxUnit;
    final cuts = sim.taxCuts();

    // tranches d'aujourd'hui (impôt progressif) : contribuables, revenu brut, impôt
    final rates = [p.taxRate1, p.taxRate2, p.taxRate3, p.taxRate4];
    final count = List<int>.filled(4, 0);
    final gross = List<double>.filled(4, 0);
    final tax = List<double>.filled(4, 0);
    for (final e in sim.grossToday.entries) {
      final g = e.value;
      final i = g < cuts[0] ? 0 : (g < cuts[1] ? 1 : (g < cuts[2] ? 2 : 3));
      count[i]++;
      gross[i] += g;
      tax[i] += sim.taxToday[e.key] ?? 0;
    }
    final grossAll = gross.fold(0.0, (a, b) => a + b);
    final taxAll = tax.fold(0.0, (a, b) => a + b);

    // inégalités : part de l'argent des ménages des 1 % et 10 % les plus riches
    final money = [for (final c in sim.citizens) c.money < 0 ? 0.0 : c.money]..sort((a, b) => b.compareTo(a));
    final total = money.fold(0.0, (a, b) => a + b);
    double share(double frac) {
      if (money.isEmpty || total <= 0) return 0;
      final n = (money.length * frac).ceil();
      return money.take(n).fold(0.0, (a, b) => a + b) / total;
    }

    final median = money.isEmpty ? 0.0 : money[money.length ~/ 2];

    String range(int i) {
      final lo = i == 0 ? 0.0 : cuts[i - 1];
      return i == 3 ? 'plus de ${money0(lo)}' : '${money0(lo)} à ${money0(cuts[i])}';
    }

    Widget row(List<String> cells, {bool head = false}) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(children: [
            for (var k = 0; k < cells.length; k++)
              Expanded(
                  flex: k == 0 ? 3 : 2,
                  child: Text(cells[k],
                      textAlign: k == 0 ? TextAlign.left : TextAlign.right,
                      style: head
                          ? TextStyle(color: pal.ink3, fontSize: 11, fontWeight: FontWeight.w600)
                          : mono(pal.ink, 11.5))),
          ]),
        );

    return ListView(padding: const EdgeInsets.all(12), children: [
      Section('Impôt sur le revenu', [
        Text(
            'L’impôt est prélevé sur les salaires, les dividendes et les excédents de trésorerie reversés aux propriétaires '
            '(pas sur les prestations). Les recettes vont au trésor de l’État, qui finance les services publics et '
            'reverse son surplus à parts égales à tous les citoyens.',
            style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
        SwitchListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: const Text('Impôt progressif', style: TextStyle(fontSize: 13)),
          subtitle: const Text(
              'Quatre tranches sur le revenu brut de la journée de chaque citoyen, en multiples du salaire moyen : le barème '
              'suit les prix. Chacun paie sur le total de ses revenus du jour, quel qu’en soit le nombre. Coupé : un taux '
              'unique sur chaque versement.',
              style: TextStyle(fontSize: 11)),
          value: p.progressiveTax,
          onChanged: (v) => upd(() => p.progressiveTax = v),
        ),
        if (!p.progressiveTax)
          ParamSlider(
              label: 'Taux unique',
              value: p.taxRate,
              min: 0,
              max: 0.6,
              format: pct,
              hint: 'Prélevé sur chaque salaire, dividende et excédent reversé.',
              onChanged: (v) => upd(() => p.taxRate = (v * 100).round() / 100))
        else ...[
          KV('Salaire moyen (unité du barème)', '${money0(w)} / jour'),
          for (var i = 0; i < 4; i++)
            ParamSlider(
                label: 'Taux de la tranche ${i + 1} (${range(i)} par jour)',
                value: rates[i],
                min: 0,
                max: 0.9,
                format: pct,
                onChanged: (v) => upd(() {
                      final r = (v * 100).round() / 100;
                      switch (i) {
                        case 0:
                          p.taxRate1 = r;
                        case 1:
                          p.taxRate2 = r;
                        case 2:
                          p.taxRate3 = r;
                        default:
                          p.taxRate4 = r;
                      }
                    })),
          ParamSlider(
              label: 'Fin de la tranche 1',
              value: p.taxCut1,
              min: 0.25,
              max: 5,
              format: (v) => '${fmtNum(v, 2)} salaire moyen',
              onChanged: (v) => upd(() => p.taxCut1 = (v * 4).round() / 4)),
          ParamSlider(
              label: 'Fin de la tranche 2',
              value: p.taxCut2,
              min: 0.5,
              max: 20,
              format: (v) => '${fmtNum(v, 1)} salaires moyens',
              onChanged: (v) => upd(() => p.taxCut2 = (v * 2).round() / 2)),
          ParamSlider(
              label: 'Fin de la tranche 3',
              value: p.taxCut3,
              min: 1,
              max: 100,
              format: (v) => '${fmtNum(v, 0)} salaires moyens',
              hint: 'Au-delà, le taux de la tranche 4 s’applique.',
              onChanged: (v) => upd(() => p.taxCut3 = v.roundToDouble())),
          TextButton(
            onPressed: () => upd(() {
              final d = Params();
              p
                ..taxCut1 = d.taxCut1
                ..taxCut2 = d.taxCut2
                ..taxCut3 = d.taxCut3
                ..taxRate1 = d.taxRate1
                ..taxRate2 = d.taxRate2
                ..taxRate3 = d.taxRate3
                ..taxRate4 = d.taxRate4;
            }),
            child: const Text('Barème par défaut'),
          ),
        ],
      ]),
      if (p.progressiveTax)
        Section('Aujourd’hui, par tranche', [
          row(['Tranche (revenu du jour)', 'Nombre', 'Revenu', 'Impôt', 'Taux'], head: true),
          for (var i = 0; i < 4; i++)
            row([
              '${i + 1} · ${range(i)}',
              '${count[i]}',
              money0(gross[i]),
              money0(tax[i]),
              gross[i] > 0 ? pct(tax[i] / gross[i]) : '—',
            ]),
          Divider(height: 10, color: pal.rule),
          row(['Total', '${count.fold(0, (a, b) => a + b)}', money0(grossAll), money0(taxAll),
            grossAll > 0 ? pct(taxAll / grossAll) : '—']),
          if (sim.grossToday.isEmpty)
            Text('Les chiffres apparaissent au prochain jour joué.', style: TextStyle(color: pal.ink3, fontSize: 11.5)),
        ]),
      Section('Recettes et redistribution', [
        KV('Impôts du jour', money0(sim.state.taxesToday)),
        KV('Trésor de l’État', money0(sim.state.money)),
        if (sim.stateDebt > 0) KV('Dette publique', money0(sim.stateDebt), color: pal.warn),
        ParamSlider(
            label: 'Part du surplus du trésor reversée chaque jour',
            value: p.stateRebate,
            min: 0,
            max: 0.2,
            format: pct,
            hint: 'Au-delà d’une réserve (30 jours de prestations pour un dixième des citoyens), cette part du trésor est '
                'reversée chaque jour à parts égales à tous les citoyens.',
            onChanged: (v) => upd(() => p.stateRebate = (v * 1000).round() / 1000)),
      ]),
      Section('Inégalités', [
        KV('Indice de Gini (argent des ménages)', fmtNum(sim.gini(), 3)),
        KV('Part du 1 % le plus riche', pct(share(0.01))),
        KV('Part des 10 % les plus riches', pct(share(0.10))),
        KV('Argent médian d’un ménage', money0(median)),
        KV('Le plus riche', money.isEmpty ? '—' : money0(money.first)),
      ]),
    ]);
  }
}
