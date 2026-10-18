// Onglets Économie, Journal et Modèle.

import 'package:flutter/material.dart';

import '../engine/model.dart';
import '../engine/sim.dart';
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

    final priceColors = {'pain': pal.primaire, 'repas': pal.conso, 'logement': pal.transfo, 'tele': pal.money};
    TableRow header(String t) => TableRow(children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 2),
            child: Text(t.toUpperCase(),
                style: TextStyle(color: pal.ink3, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.6)),
          ),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
        ]);

    return ListView(padding: const EdgeInsets.all(12), children: [
      Section('Marchés', [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2.4),
            1: FlexColumnWidth(1.6),
            2: FlexColumnWidth(0.8),
            3: FlexColumnWidth(1.3),
            4: FlexColumnWidth(1.3)
          },
          children: [
            TableRow(children: [
              for (final t in ['Bien', 'Prix', 'Vend.', 'Volume', 'Manque'])
                Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(t, style: TextStyle(color: pal.ink3, fontSize: 10.5, fontWeight: FontWeight.w700))),
            ]),
            for (final s in sectors) ...[
              header(sectorLabels[s]!),
              for (final e in goods.entries.where((e) => e.value.sector == s))
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(children: [
                      Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(color: pal.sector(e.value.sector), shape: BoxShape.circle)),
                      const SizedBox(width: 5),
                      Flexible(
                          child: Text(e.value.label,
                              style: TextStyle(color: pal.ink, fontSize: 12), overflow: TextOverflow.ellipsis)),
                    ]),
                  ),
                  Text(money(sim.bestPrice(e.key)), style: mono(pal.ink, 11.5)),
                  Text('${sim.sellersOf(e.key).length}', style: mono(pal.ink2, 11.5)),
                  Text(qty(sim.marketStats[e.key]?.qty ?? 0.0), style: mono(pal.ink2, 11.5)),
                  Text(qty(sim.unmet[e.key] ?? 0.0),
                      style: mono((sim.unmet[e.key] ?? 0.0) > 0.5 ? pal.bad : pal.ink3, 11.5)),
                ]),
            ],
          ],
        ),
      ]),
      ChartCard(title: 'Chômage', unit: '%', minY: 0, series: [Series('chômage', pal.bad, col((p) => p.unemp))]),
      ChartCard(title: 'Bonheur moyen', unit: '%', minY: 0, series: [Series('bonheur', pal.ok, col((p) => p.happiness))]),
      ChartCard(title: 'Indice des prix (panier des ménages, départ = 100)', series: [
        Series('indice', pal.warn, col((p) => p.cpi * 100)),
      ]),
      ChartCard(title: 'Salaire moyen et panier de survie', unit: '\$', series: [
        Series('salaire', pal.accent, col((p) => p.wage)),
        Series('panier / jour', pal.warn, col((p) => p.need)),
      ]),
      ChartCard(title: 'Prix de quelques biens', unit: '\$', series: [
        for (final g in priceColors.keys) Series(goods[g]!.label, priceColors[g]!, col((p) => p.prices[g] ?? 0.0)),
      ]),
      ChartCard(title: 'Où est l’argent', stacked: true, unit: '\$', series: [
        Series('ménages', pal.accent, col((p) => p.mH)),
        Series('entreprises', pal.primaire, col((p) => p.mF)),
        Series('État', pal.conso, col((p) => p.mE)),
        Series('Caisse', pal.money, col((p) => p.mB)),
      ]),
      ChartCard(title: 'Dette des entreprises', unit: '\$', minY: 0, series: [Series('dette', pal.bad, col((p) => p.debt))]),
      ChartCard(title: 'Machines en service', minY: 0, series: [Series('machines', pal.primaire, col((p) => p.machines))]),
      ChartCard(title: 'Qualifications', stacked: true, minY: 0, series: [
        for (var i = 0; i < 3; i++)
          Series(classLabels[i], [pal.ink3, pal.transfo, pal.accent][i], col((p) => p.classes[i].toDouble())),
      ]),
      ChartCard(title: 'Détresse', minY: 0, series: [
        Series('affamés', pal.warn, col((p) => p.hungry.toDouble())),
        Series('sans logis', pal.bad, col((p) => p.homeless.toDouble())),
      ]),
      ChartCard(
          title: 'Dépenses des ménages / jour',
          unit: '\$',
          minY: 0,
          series: [Series('dépenses', pal.transfo, col((p) => p.gdp))]),
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
    Color colorOf(String t) {
      switch (t) {
        case 'god':
          return pal.accent;
        case 'warn':
        case 'alert':
          return pal.bad;
        case 'short':
        case 'net':
          return pal.warn;
        default:
          return pal.ink2;
      }
    }

    const filters = {
      'all': 'Tout',
      'alert': 'Alertes',
      'net': 'Filets',
      'god': 'Divin',
      'warn': 'Avertissements',
      'short': 'Pénuries',
      'info': 'Infos',
    };
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
                child: ChoiceChip(
                    label: Text(e.value), selected: filter == e.key, onSelected: (_) => setState(() => filter = e.key)),
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
  double pop = 240;
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
        ParamSlider(
            label: 'Marge de base',
            value: p.markup,
            min: 1,
            max: 1.6,
            format: (v) => '×${fmtNum(v, 2)}',
            hint: 'Prix = coût de revient × marge, puis ajusté selon stocks et demande.',
            onChanged: (v) => upd(() => p.markup = v)),
        ParamSlider(
            label: 'Part du revenu dépensée (α₁)',
            value: p.mpcIncome,
            min: 0.2,
            max: 0.95,
            format: pct,
            hint: 'Part du revenu au-delà des besoins dépensée chaque jour en divertissement et luxe.',
            onChanged: (v) => upd(() => p.mpcIncome = v)),
        ParamSlider(
            label: 'Richesse visée (jours de revenu)',
            value: p.wealthTargetDays,
            min: 3,
            max: 120,
            format: (v) => '${fmtNum(v, 0)} j',
            hint: 'Au-delà du coussin, les ménages dépensent chaque jour (1 − α₁) / T de leur richesse : ils convergent vers T jours de revenu.',
            onChanged: (v) => upd(() => p.wealthTargetDays = v.roundToDouble())),
        ParamSlider(
            label: 'Coussin des ménages (jours de survie)',
            value: p.bufferDays,
            min: 2,
            max: 40,
            format: (v) => '${fmtNum(v, 0)} j',
            onChanged: (v) => upd(() => p.bufferDays = v.roundToDouble())),
        ParamSlider(
            label: 'Vitesse d’ajustement des prix',
            value: p.priceStep,
            min: 0.005,
            max: 0.08,
            format: pct,
            onChanged: (v) => upd(() => p.priceStep = v)),
        ParamSlider(
            label: 'Vitesse d’ajustement des salaires',
            value: p.wageStep,
            min: 0.003,
            max: 0.05,
            format: pct,
            onChanged: (v) => upd(() => p.wageStep = v)),
        ParamSlider(
            label: 'Stock visé (jours de ventes)',
            value: p.invTargetDays,
            min: 1,
            max: 12,
            format: (v) => '${fmtNum(v, 1)} j',
            onChanged: (v) => upd(() => p.invTargetDays = v)),
        ParamSlider(
            label: 'Taux de dividendes',
            value: p.dividendRate,
            min: 0,
            max: 0.3,
            format: pct,
            onChanged: (v) => upd(() => p.dividendRate = v)),
        ParamSlider(
            label: 'Mobilité des travailleurs',
            value: p.jobSwitch,
            min: 0,
            max: 0.2,
            format: pct,
            onChanged: (v) => upd(() => p.jobSwitch = v)),
        ParamSlider(
            label: 'Effet de la publicité sur la dépense',
            value: p.adsEffect,
            min: 0,
            max: 2,
            format: (v) => '+${pct(v)} max',
            onChanged: (v) => upd(() => p.adsEffect = v)),
        ParamSlider(
            label: 'Envie de se former',
            value: p.eduRate,
            min: 0,
            max: 1,
            format: pct,
            hint: 'Chance quotidienne de suivre un cours, multipliée par l’ambition de chacun.',
            onChanged: (v) => upd(() => p.eduRate = v)),
        ParamSlider(
            label: 'Risque de maladie (par jour)',
            value: p.illness,
            min: 0,
            max: 0.03,
            format: (v) => pct(v),
            onChanged: (v) => upd(() => p.illness = v)),
        ParamSlider(
            label: 'Usure des machines (par jour)',
            value: p.depreciation,
            min: 0,
            max: 0.02,
            format: (v) => pct(v),
            hint: 'Avec entretien ; sans entretien, l’usure est 2,5 fois plus rapide.',
            onChanged: (v) => upd(() => p.depreciation = v)),
      ]),
      _entrepreneurSection(context, ctrl, upd),
      Section('Nouvelle partie', [
        Row(children: [
          Expanded(
              child: NumField(
                  label: 'Graine', value: seed, decimals: 0, onSubmit: (v) => setState(() => seed = v.abs().roundToDouble()))),
          const SizedBox(width: 8),
          Expanded(
              child: NumField(
                  label: 'Population',
                  value: pop,
                  decimals: 0,
                  onSubmit: (v) => setState(() => pop = v.abs().clamp(40, 1000).toDouble()))),
          const SizedBox(width: 8),
          Expanded(
              child: NumField(
                  label: 'Capital initial',
                  value: wallet,
                  suffix: '\$',
                  decimals: 0,
                  onSubmit: (v) => setState(() => wallet = v.abs()))),
        ]),
        const SizedBox(height: 8),
        Btn('Recommencer', () {
          final np = Params()
            ..population = pop.round()
            ..startWallet = wallet;
          ctrl.newGame(seed.round(), params: np);
        }, primary: true, icon: Icons.restart_alt),
        Text(
            'Même graine, mêmes réglages : la simulation se déroule toujours de la même façon. '
            'Les modules et les filets en cours sont conservés.',
            style: TextStyle(color: pal.ink3, fontSize: 11)),
      ]),
      Section('Comment ça marche', [
        Text(
          '• Chaque jour : embauches, production, salaires, achats d’intrants et de services, consommation, filets, '
          'usure des machines et dette, prix et salaires, dividendes, État.\n'
          '• Trois secteurs : primaire (extraction, ressources illimitées), secondaire (transformation), tertiaire (services). '
          'Les entreprises achètent comptabilité, entretien, publicité et R-D ; elles s’endettent pour acheter des machines.\n'
          '• Les citoyens ont des désirs (faim, logement, santé, divertissement, luxe) dont la satisfaction s’use. '
          'Leurs goûts dépendent de leur qualification (manœuvre, technicien, professionnel), qui monte avec la formation.\n'
          '• La Caisse populaire crée la monnaie qu’elle prête ; le remboursement la détruit. Sinon, l’argent ne se crée ni ne '
          'se perd que par le god mode et le commerce extérieur : les invariants comptables le vérifient au bit près.\n'
          '• L’onglet Diagnostic montre les anomalies détectées et les filets de sécurité, avec leurs compteurs.',
          style: TextStyle(color: pal.ink2, fontSize: 12.5, height: 1.45),
        ),
      ]),
      const SizedBox(height: 24),
    ]);
  }
}


/// Entrepreneuriat des citoyens : l'interrupteur du module, ses réglages et ce qu'il produit.
Widget _entrepreneurSection(BuildContext context, SimController ctrl, void Function(void Function()) upd) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final p = sim.params;
  final on = sim.modules.entrepreneurship;
  final year = sim.day ~/ 365;
  final f = sim.entryFunnel;
  int fn(String k) => f['fond_$k'] ?? 0;
  final refusals = {
    'capital': 'épargne insuffisante',
    'pret_paiements': 'prêt refusé : paiements trop lourds',
    'pret_fonds_propres': 'prêt refusé : fonds propres de la Caisse',
    'pret_credit_coupe': 'prêt impossible : crédit coupé',
  };
  final tol = (p.entRiskMean - p.entRiskSpread).clamp(0.0, 1.0).toDouble();
  final tolHi = (p.entRiskMean + p.entRiskSpread).clamp(0.0, 1.0).toDouble();
  return Section('Entrepreneuriat des citoyens', [
    Text(
        'Des citoyens qui veulent posséder, ont assez d’ambition et de tolérance au risque, examinent de temps en temps un '
        'secteur où la demande reste sans réponse. Ils comparent ce qu’ils espéreraient y gagner (marge observée, demande non '
        'servie, connaissance du secteur) à leur revenu actuel, pesé par leur aversion au risque. Capital : leur épargne '
        'plus un prêt de la Caisse selon ses règles prudentielles. Ils deviennent propriétaires et premiers employés.',
        style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
    SwitchListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(Modules.labels['entrepreneurship']!, style: const TextStyle(fontSize: 13)),
      subtitle: Text(
          sim.modules.entry
              ? 'Prend effet au prochain jour. Coupé : les créations redeviennent automatiques.'
              : 'Suppose « Entrée et sortie d’entreprises », actuellement coupée : rien ne sera fondé.',
          style: const TextStyle(fontSize: 11)),
      value: on,
      onChanged: (v) => upd(() => sim.modules.entrepreneurship = v),
    ),
    ParamSlider(
        label: 'Taux de fondation (multiplicateur)',
        value: p.entFoundRate,
        min: 0,
        max: 10,
        format: (v) => '×${fmtNum(v, 1)}',
        hint: 'Chance quotidienne qu’un candidat examine un projet : ${fmtNum(p.entConsiderRate * 100, 2)} % × ce '
            'multiplicateur. 0 : personne ne fonde.',
        onChanged: (v) => upd(() => p.entFoundRate = (v * 10).round() / 10)),
    ParamSlider(
        label: 'Tolérance au risque : moyenne',
        value: p.entRiskMean,
        min: 0,
        max: 1,
        format: pct,
        hint: 'Un citoyen au-dessous de ${pct(p.entMinTolerance)} ne fonde jamais ; plus il est tolérant, moins sa mise '
            'perdue pèse dans sa décision.',
        onChanged: (v) => upd(() => p.entRiskMean = (v * 100).round() / 100)),
    ParamSlider(
        label: 'Tolérance au risque : dispersion',
        value: p.entRiskSpread,
        min: 0,
        max: 0.5,
        format: pct,
        hint: 'Les tolérances s’étalent de ${pct(tol)} à ${pct(tolHi)} (répartition uniforme). Change la distribution de '
            'tous les citoyens, présents compris.',
        onChanged: (v) => upd(() => p.entRiskSpread = (v * 100).round() / 100)),
    ParamSlider(
        label: 'Exigence de capital (× capital de démarrage)',
        value: p.entCapitalMult,
        min: 0.5,
        max: 3,
        format: (v) => '×${fmtNum(v, 2)}',
        hint: 'Capital de démarrage = 10 jours de salaires + 5 jours d’intrants de l’équipe. Le fondateur en met au moins '
            '${pct(p.entMinOwnShare)} ; le reste est un prêt de la Caisse, qu’elle peut refuser.',
        onChanged: (v) => upd(() => p.entCapitalMult = (v * 20).round() / 20)),
    const SizedBox(height: 4),
    KV('Fondations par des citoyens : année ${year + 1} · précédente',
        '${sim.foundedIn(year)} · ${year > 0 ? sim.foundedIn(year - 1) : '—'}'),
    KV('Fermetures : année ${year + 1} · précédente', '${sim.closedIn(year)} · ${year > 0 ? sim.closedIn(year - 1) : '—'}'),
    KV('Candidats à fonder aujourd’hui', on ? '${sim.foundingCandidates()} sur ${sim.citizens.length}' : '—'),
    KV('Projets examinés · fondés (total)', '${fn('projet')} · ${fn('creation')}'),
    for (final e in refusals.entries)
      if (fn(e.key) > 0) KV('Refus : ${e.value}', '${fn(e.key)}', color: pal.warn),
    Text(
        'Repère, non visé : au Canada, environ 10 % d’entrées et 9 % de sorties d’entreprises par an (Statistique Canada). '
        'Aucun réglage n’a été ajusté pour s’en approcher.',
        style: TextStyle(color: pal.ink3, fontSize: 11, height: 1.35)),
  ]);
}
