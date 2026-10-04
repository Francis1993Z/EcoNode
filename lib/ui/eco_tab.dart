// Onglets Économie, Journal et Modèle.

import 'package:flutter/material.dart';

import '../engine/model.dart';
import 'charts.dart';
import 'controller.dart';
import 'format.dart';
import 'palette.dart';
import 'widgets.dart';

class EconomyTab extends StatelessWidget {
  final SimController ctrl;
  const EconomyTab(this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final h = sim.history;
    List<double> col(double Function(HistPoint) f) => downsample(h.map(f).toList());

    final priceColors = {'repas': pal.conso, 'logement': pal.transfo, 'souliers': pal.primaire, 'loisirs': pal.money};

    return ListView(padding: const EdgeInsets.all(12), children: [
      Section('Marchés', [
        Table(
          columnWidths: const {0: FlexColumnWidth(2.2), 1: FlexColumnWidth(1.6), 2: FlexColumnWidth(0.9), 3: FlexColumnWidth(1.3), 4: FlexColumnWidth(1.3)},
          children: [
            TableRow(children: [
              for (final t in ['Bien', 'Prix', 'Vend.', 'Volume', 'Manque'])
                Padding(padding: const EdgeInsets.only(bottom: 4), child: Text(t, style: TextStyle(color: pal.ink3, fontSize: 10.5, fontWeight: FontWeight.w700))),
            ]),
            for (final e in goods.entries)
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(children: [
                    Container(width: 7, height: 7, decoration: BoxDecoration(color: pal.sector(e.value.sector), shape: BoxShape.circle)),
                    const SizedBox(width: 5),
                    Flexible(child: Text(e.value.label, style: TextStyle(color: pal.ink, fontSize: 12), overflow: TextOverflow.ellipsis)),
                  ]),
                ),
                Text(money(sim.bestPrice(e.key)), style: mono(pal.ink, 11.5)),
                Text('${sim.sellersOf(e.key).length}', style: mono(pal.ink2, 11.5)),
                Text(qty(sim.marketStats[e.key]?.qty ?? 0.0), style: mono(pal.ink2, 11.5)),
                Text(qty(sim.unmet[e.key] ?? 0.0),
                    style: mono((sim.unmet[e.key] ?? 0.0) > 0.5 ? pal.bad : pal.ink3, 11.5)),
              ]),
          ],
        ),
      ]),
      ChartCard(title: 'Chômage', unit: '%', minY: 0, series: [Series('chômage', pal.bad, col((p) => p.unemp))]),
      ChartCard(title: 'Salaire moyen et panier de survie', unit: '\$', series: [
        Series('salaire', pal.accent, col((p) => p.wage)),
        Series('panier / jour', pal.warn, col((p) => p.need)),
      ]),
      ChartCard(title: 'Prix des biens finaux', unit: '\$', series: [
        for (final g in finalGoods) Series(goods[g]!.label, priceColors[g]!, col((p) => p.prices[g] ?? 0.0)),
      ]),
      ChartCard(title: 'Où est l’argent', stacked: true, unit: '\$', series: [
        Series('ménages', pal.accent, col((p) => p.mH)),
        Series('entreprises', pal.primaire, col((p) => p.mF)),
        Series('État', pal.conso, col((p) => p.mE)),
      ]),
      ChartCard(title: 'Détresse', minY: 0, series: [
        Series('affamés', pal.warn, col((p) => p.hungry.toDouble())),
        Series('sans logis', pal.bad, col((p) => p.homeless.toDouble())),
      ]),
      ChartCard(title: 'Dépenses des ménages / jour', unit: '\$', minY: 0, series: [Series('dépenses', pal.transfo, col((p) => p.gdp))]),
      ChartCard(title: 'Inégalités (Gini)', minY: 0, series: [Series('Gini', pal.conso, col((p) => p.gini))]),
      const SizedBox(height: 24),
    ]);
  }
}

class JournalTab extends StatefulWidget {
  final SimController ctrl;
  const JournalTab(this.ctrl, {super.key});
  @override
  State<JournalTab> createState() => _JournalTabState();
}

class _JournalTabState extends State<JournalTab> {
  String filter = 'all';

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final ev = widget.ctrl.sim.events.reversed.where((e) => filter == 'all' || e.type == filter).take(150).toList();
    Color colorOf(String t) => t == 'god'
        ? pal.accent
        : t == 'warn'
            ? pal.bad
            : t == 'short'
                ? pal.warn
                : pal.ink2;
    const filters = {'all': 'Tout', 'god': 'Divin', 'warn': 'Alertes', 'short': 'Pénuries', 'info': 'Infos'};
    return Column(children: [
      SizedBox(
        height: 48,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          children: [
            for (final e in filters.entries)
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: ChoiceChip(label: Text(e.value), selected: filter == e.key, onSelected: (_) => setState(() => filter = e.key)),
              ),
          ],
        ),
      ),
      Expanded(
        child: ev.isEmpty
            ? Center(child: Text('Rien à signaler.', style: TextStyle(color: pal.ink3)))
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: ev.length,
                itemBuilder: (context, i) {
                  final e = ev[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      SizedBox(width: 44, child: Text('j${e.day}', style: mono(pal.ink3, 11))),
                      Expanded(child: Text(e.text, style: TextStyle(color: colorOf(e.type), fontSize: 12.5))),
                    ]),
                  );
                },
              ),
      ),
    ]);
  }
}

class ModelTab extends StatefulWidget {
  final SimController ctrl;
  const ModelTab(this.ctrl, {super.key});
  @override
  State<ModelTab> createState() => _ModelTabState();
}

class _ModelTabState extends State<ModelTab> {
  double seed = 42;
  double pop = 80;
  double wallet = 3000;

  SimController get ctrl => widget.ctrl;

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final p = ctrl.sim.params;
    void upd(void Function() f) {
      f();
      ctrl.touch();
    }

    return ListView(padding: const EdgeInsets.all(12), children: [
      Section('Paramètres en direct', [
        ParamSlider(label: 'Marge de base', value: p.markup, min: 1, max: 1.6, format: (v) => '×${fmtNum(v, 2)}', hint: 'Prix = coût de revient × marge, puis ajusté selon stocks et demande.', onChanged: (v) => upd(() => p.markup = v)),
        ParamSlider(label: 'Dépense du surplus (par jour)', value: p.propensity, min: 0, max: 0.3, format: pct, hint: 'Part de l’argent au-delà du coussin que les ménages dépensent chaque jour.', onChanged: (v) => upd(() => p.propensity = v)),
        ParamSlider(label: 'Coussin des ménages (jours de survie)', value: p.bufferDays, min: 2, max: 40, format: (v) => '${fmtNum(v, 0)} j', onChanged: (v) => upd(() => p.bufferDays = v.roundToDouble())),
        ParamSlider(label: 'Vitesse d’ajustement des prix', value: p.priceStep, min: 0.005, max: 0.08, format: pct, onChanged: (v) => upd(() => p.priceStep = v)),
        ParamSlider(label: 'Vitesse d’ajustement des salaires', value: p.wageStep, min: 0.003, max: 0.05, format: pct, onChanged: (v) => upd(() => p.wageStep = v)),
        ParamSlider(label: 'Stock visé (jours de ventes)', value: p.invTargetDays, min: 1, max: 12, format: (v) => '${fmtNum(v, 1)} j', onChanged: (v) => upd(() => p.invTargetDays = v)),
        ParamSlider(label: 'Taux de dividendes', value: p.dividendRate, min: 0, max: 0.3, format: pct, onChanged: (v) => upd(() => p.dividendRate = v)),
        ParamSlider(label: 'Mobilité des travailleurs', value: p.jobSwitch, min: 0, max: 0.2, format: pct, onChanged: (v) => upd(() => p.jobSwitch = v)),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Les propriétaires renflouent leur entreprise'),
          value: p.recapitalize,
          onChanged: (v) => upd(() => p.recapitalize = v),
        ),
      ]),
      Section('Nouvelle partie', [
        Row(children: [
          Expanded(child: NumField(label: 'Graine', value: seed, decimals: 0, onSubmit: (v) => setState(() => seed = v.abs().roundToDouble()))),
          const SizedBox(width: 8),
          Expanded(child: NumField(label: 'Population', value: pop, decimals: 0, onSubmit: (v) => setState(() => pop = v.abs().clamp(10, 400).toDouble()))),
          const SizedBox(width: 8),
          Expanded(child: NumField(label: 'Capital initial', value: wallet, suffix: '\$', decimals: 0, onSubmit: (v) => setState(() => wallet = v.abs()))),
        ]),
        const SizedBox(height: 8),
        Btn('Recommencer', () {
          final np = Params()
            ..population = pop.round()
            ..startWallet = wallet;
          ctrl.newGame(seed.round(), params: np);
        }, primary: true, icon: Icons.restart_alt),
        Text('Même graine, mêmes réglages : la simulation se déroule toujours de la même façon.', style: TextStyle(color: pal.ink3, fontSize: 11)),
      ]),
      Section('Comment ça marche', [
        Text(
          '• Chaque jour : embauches, production, salaires, achats d’intrants, consommation des ménages, impôts, dividendes.\n'
          '• Les ménages ont besoin de manger, de se loger, de s’habiller et de se divertir ; ils achètent toujours le moins cher d’abord.\n'
          '• Chaque entreprise fixe son prix par coût de revient × marge, et le corrige selon son stock et la demande non servie.\n'
          '• Une entreprise qui peine à embaucher relève son salaire ; sinon il baisse très lentement.\n'
          '• L’argent ne se crée ni ne se perd que par le god mode et le commerce extérieur ; le grand livre le vérifie.',
          style: TextStyle(color: pal.ink2, fontSize: 12.5, height: 1.45),
        ),
      ]),
      const SizedBox(height: 24),
    ]);
  }
}
