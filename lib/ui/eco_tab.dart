// Onglets Économie, Journal et Modèle.

import 'package:flutter/material.dart';

import '../engine/model.dart';
import '../engine/sim.dart';
import 'charts.dart';
import 'controller.dart';
import 'format.dart';
import 'palette.dart';
import 'start_params.dart';
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
      _productsSection(context, ctrl, upd),
      _creditSection(context, ctrl, upd),
      _banksSection(context, ctrl, upd),
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
        ]),
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: const EdgeInsets.only(bottom: 8),
          title: const Text('Paramètres de départ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          subtitle: const Text('Pris en compte au prochain « Recommencer » (les mêmes que l’écran de départ).',
              style: TextStyle(fontSize: 11)),
          children: [StartParamsEditor(ctrl.startParams, onChanged: () => setState(() {}))],
        ),
        const SizedBox(height: 8),
        Btn('Recommencer', () {
          ctrl.newGame(seed.round(), params: freshParams(ctrl.startParams, pop.round()));
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


/// Variétés de produits : l'interrupteur, les réglages du choix des ménages et le panneau de chaque catégorie.
Widget _productsSection(BuildContext context, SimController ctrl, void Function(void Function()) upd) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final p = sim.params;
  final on = sim.modules.products;
  final cats = [...consumerVarieties, ...equipmentVarieties];
  return Section('Variétés de produits et marques', [
    Text(
        'Chaque entreprise d’un bien de consommation ou d’équipement vend sa variété : un nom, une qualité (qui coûte en '
        'productivité). Les ménages connaissent quelques variétés par catégorie (vitrine, publicité, collègues, habitude) '
        'et achètent celle qui leur plaît le plus : qualité, prix, notoriété, goût personnel. Les variétés naissent et '
        'meurent avec les entreprises.',
        style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
    SwitchListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(Modules.labels['products']!, style: const TextStyle(fontSize: 13)),
      subtitle: const Text('Prend effet au prochain jour : chaque entreprise reçoit sa variété.', style: TextStyle(fontSize: 11)),
      value: on,
      onChanged: (v) => upd(() => sim.modules.products = v),
    ),
    ParamSlider(
        label: 'Importance de la qualité',
        value: p.prodQualityWeight,
        min: 0,
        max: 3,
        format: (v) => '×${fmtNum(v, 2)}',
        hint: 'Poids de la qualité dans l’utilité d’une variété (la qualité va de 60 à 140 %).',
        onChanged: (v) => upd(() => p.prodQualityWeight = (v * 20).round() / 20)),
    ParamSlider(
        label: 'Sensibilité au prix',
        value: p.prodPriceSens,
        min: 0,
        max: 3,
        format: (v) => '×${fmtNum(v, 2)}',
        hint: 'Poids du prix (rapporté au prix mondial) ; chaque citoyen en a de 0,5 à 1,5 fois cette valeur.',
        onChanged: (v) => upd(() => p.prodPriceSens = (v * 20).round() / 20)),
    ParamSlider(
        label: 'Durée d’oubli',
        value: p.prodForgetDays.toDouble(),
        min: 5,
        max: 365,
        format: (v) => '${fmtNum(v, 0)} j',
        hint: 'Une variété ni achetée ni revue depuis ce nombre de jours sort de la liste du citoyen.',
        onChanged: (v) => upd(() => p.prodForgetDays = v.round())),
    ParamSlider(
        label: 'Taille de la liste de connaissance',
        value: p.prodKnownMax.toDouble(),
        min: 1,
        max: 8,
        format: (v) => '${v.round()} variétés',
        hint: 'Variétés connues au plus par catégorie ; la plus ancienne est oubliée quand une nouvelle arrive.',
        onChanged: (v) => upd(() => p.prodKnownMax = v.round())),
    const SizedBox(height: 4),
    if (!on && sim.products.isEmpty)
      Text('Module coupé : aucune variété.', style: TextStyle(color: pal.ink3, fontSize: 12))
    else
      for (final g in cats) _categoryTile(context, ctrl, g),
  ]);
}

/// Panneau d'une catégorie : nombre de variétés vivantes, part du premier vendeur, et chaque variété (part, prix, qualité).
Widget _categoryTile(BuildContext context, SimController ctrl, String g) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final list = sim.varietiesOf(g);
  final top = list.isEmpty ? 0.0 : sim.marketShare(list.first);
  final margin = sim.categoryMargin(g);
  return ExpansionTile(
    dense: true,
    tilePadding: EdgeInsets.zero,
    childrenPadding: const EdgeInsets.only(bottom: 6),
    title: Text(goods[g]!.label, style: TextStyle(color: pal.ink, fontSize: 12.5)),
    subtitle: Text(
        '${list.length} variété${list.length > 1 ? 's' : ''} vivante${list.length > 1 ? 's' : ''}'
        '${list.isEmpty ? '' : ' · premier vendeur ${pct(top)}'}${margin == null ? '' : ' · marge ${pct(margin)}'}',
        style: TextStyle(color: pal.ink3, fontSize: 11)),
    children: [
      if (list.isEmpty) Text('Aucune variété.', style: TextStyle(color: pal.ink3, fontSize: 11.5)),
      for (final pr in list)
        InkWell(
          onTap: () => ctrl.select(Selection('firm', pr.firmId)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(children: [
              Expanded(
                  child: Text('« ${pr.name} » · ${sim.firm(pr.firmId)?.name ?? ''}',
                      overflow: TextOverflow.ellipsis, style: TextStyle(color: pal.ink2, fontSize: 11.5))),
              Text(
                  '${pct(sim.marketShare(pr))} · ${money(sim.firm(pr.firmId)?.price[g] ?? 0)} · q ${fmtNum(pr.quality * 100, 0)} %'
                  '${equipmentVarieties.contains(g) ? ' · ×${fmtNum(pr.gain, 2)}' : ''}',
                  style: mono(pal.ink, 11)),
            ]),
          ),
        ),
      if (sim.poorEma[g] != null)
        KV('Demande faiblement servie (lissée)', '${fmtNum(sim.poorEma[g]!, 1)} ${goods[g]!.unit}/j'),
    ],
  );
}


/// Crédit aux citoyens : l'interrupteur, les réglages et les totaux.
Widget _creditSection(BuildContext context, SimController ctrl, void Function(void Function()) upd) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final p = sim.params;
  var cards = 0, loans = 0, late = 0;
  var cardDebt = 0.0, loanDebt = 0.0;
  for (final c in sim.citizens) {
    if (c.cardLimit > 0) cards++;
    loans += c.loans.length;
    if (c.arrears > 0) late++;
    cardDebt += c.card;
    for (final l in c.loans) {
      loanDebt += l.balance;
    }
  }
  return Section('Crédit aux citoyens', [
    Text(
        'Un citoyen à court d’argent pour manger, se loger ou se soigner paie avec sa carte de crédit et la rembourse quand '
        'son revenu arrive ; un creux de chômage ou un achat important passe par un prêt personnel. Le taux suit sa cote. '
        'Quand il ne peut plus payer, il fait faillite : la banque radie la dette et lui ferme le crédit un temps.',
        style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
    SwitchListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(Modules.labels['banking']!, style: const TextStyle(fontSize: 13)),
      subtitle: const Text('Coupé en cours de partie : les dettes se remboursent, plus aucun crédit nouveau.',
          style: TextStyle(fontSize: 11)),
      value: sim.modules.banking,
      onChanged: (v) => upd(() => sim.modules.banking = v),
    ),
    ParamSlider(
        label: 'Taux de la carte de crédit (base annuelle)',
        value: p.cardRate,
        min: 0.05,
        max: 0.35,
        format: pct,
        hint: 'Taux de base ; la cote y ajoute jusqu’à ${pct(p.creditRiskPremium / 2)} et une banque qui resserre, 5 points.',
        onChanged: (v) => upd(() => p.cardRate = (v * 200).round() / 200)),
    ParamSlider(
        label: 'Faillite : jours de retard',
        value: p.bkArrearsDays.toDouble(),
        min: 30,
        max: 360,
        format: (v) => '${v.round()} j',
        hint: 'Un citoyen qui n’a pas rattrapé ses paiements en retard depuis ce nombre de jours fait faillite.',
        onChanged: (v) => upd(() => p.bkArrearsDays = v.round())),
    ParamSlider(
        label: 'Faillite : dette sans emploi (années de revenu)',
        value: p.bkDebtIncome,
        min: 0.5,
        max: 5,
        format: (v) => '${fmtNum(v, 1)} an${v >= 2 ? 's' : ''}',
        hint: 'Sans emploi, une dette au-delà de ce nombre d’années de revenu déclenche la faillite.',
        onChanged: (v) => upd(() => p.bkDebtIncome = (v * 10).round() / 10)),
    ParamSlider(
        label: 'Faillite : crédit fermé ensuite',
        value: p.bkBanDays.toDouble(),
        min: 0,
        max: 2190,
        format: (v) => '${v.round()} j',
        hint: 'Durée pendant laquelle un failli n’obtient aucun crédit ; sa cote reste abaissée ensuite.',
        onChanged: (v) => upd(() => p.bkBanDays = v.round())),
    ParamSlider(
        label: 'Service de la dette maximal',
        value: p.dsrMax,
        min: 0.1,
        max: 0.8,
        format: pct,
        hint: 'Mensualités et paiement minimum de la carte, en part du revenu mensuel : au-delà, la banque refuse.',
        onChanged: (v) => upd(() => p.dsrMax = (v * 100).round() / 100)),
    const SizedBox(height: 4),
    KV('Cartes ouvertes · prêts personnels en cours', '$cards · $loans'),
    KV('Dette des citoyens : cartes · prêts', '${money0(cardDebt)} · ${money0(loanDebt)}'),
    KV('Citoyens en retard de paiement', '$late', color: late > 0 ? pal.warn : null),
    KV('Prêté aux citoyens · radié (total)', '${money0(sim.consumerLent)} · ${money0(sim.consumerWrittenOff)}'),
    KV('Faillites personnelles (total)', '${sim.consumerBankruptcies}', color: sim.consumerBankruptcies > 0 ? pal.warn : null),
  ]);
}


/// Banques : réglages, liste (capital, ratio, prêts, dépôts, taux, profit, clients, état) et nombre de banques dans le temps.
Widget _banksSection(BuildContext context, SimController ctrl, void Function(void Function()) upd) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final p = sim.params;
  String rate(double v) => '${fmtNum(v * 100, 1)} %';
  return Section('Banques', [
    Text(
        'À partir de deux banques, chaque compte appartient à une banque. Elles visent le profit : intérêts reçus moins '
        'intérêts des dépôts, pertes et coûts (employés, local). Les paiements entre banques se règlent en réserves ; '
        'une banque à court emprunte aux autres au taux directeur. Les clients changent rarement de banque.',
        style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
    ParamSlider(
        label: 'Banques de départ (nouvelle partie)',
        value: p.nBanks.toDouble(),
        min: 1,
        max: 8,
        format: (v) => '${v.round()}',
        hint: '1 : la Caisse populaire seule, sans concurrence. Pris en compte à la prochaine partie.',
        onChanged: (v) => upd(() => p.nBanks = v.round())),
    ParamSlider(
        label: 'Dotation par citoyen (nouvelle partie)',
        value: p.reservePerCitizen,
        min: 0,
        max: 200000,
        format: money0,
        hint: 'Réserves de chaque banque de départ, par citoyen ; contrepartie : capital d’un actionnaire institutionnel, '
            'jamais distribué, dont les dividendes vont aux citoyens.',
        onChanged: (v) => upd(() => p.reservePerCitizen = (v / 1000).round() * 1000.0)),
    ParamSlider(
        label: 'Taux directeur',
        value: p.policyRate,
        min: 0,
        max: 0.12,
        format: rate,
        hint: 'Taux du marché interbancaire, et plafond des taux de dépôt.',
        onChanged: (v) => upd(() => p.policyRate = (v * 400).round() / 400)),
    ParamSlider(
        label: 'Coût fixe : employés par banque',
        value: p.bankStaff.toDouble(),
        min: 0,
        max: 20,
        format: (v) => '${v.round()}',
        hint: 'Chaque banque achète chaque jour le travail de ce nombre d’employés de services comptables (embauchés sur le '
            'marché du travail par les cabinets).',
        onChanged: (v) => upd(() => p.bankStaff = v.round())),
    ParamSlider(
        label: 'Coût fixe : loyer quotidien',
        value: p.bankRentDaily,
        min: 0,
        max: 1000,
        format: money0,
        hint: 'Loyer du local, versé chaque jour à un bailleur.',
        onChanged: (v) => upd(() => p.bankRentDaily = (v / 10).round() * 10.0)),
    ParamSlider(
        label: 'Fondation de banques : taux',
        value: p.bankFoundRate * 10000,
        min: 0,
        max: 50,
        format: (v) => '${fmtNum(v / 100, 2)} %/j',
        hint: 'Chance quotidienne qu’un citoyen candidat (désir de posséder, ambition, tolérance au risque) examine un projet '
            'de banque ; il ne fonde que si le profit espéré sur la part de marché restante couvre le risque.',
        onChanged: (v) => upd(() => p.bankFoundRate = v.round() / 10000)),
    ParamSlider(
        label: 'Capital minimum d’une banque',
        value: p.bankMinCapital,
        min: 0,
        max: 1000000,
        format: money0,
        hint: 'Montant absolu, en dollars, que le fondateur verse de sa poche (pas proportionnel à la population).',
        onChanged: (v) => upd(() => p.bankMinCapital = (v / 5000).round() * 5000.0)),
    ParamSlider(
        label: 'Coût d’entrée irrécupérable',
        value: p.bankEntryCost,
        min: 0,
        max: 200000,
        format: money0,
        hint: 'Permis et systèmes, versés à l’État à la fondation : perdus même si la banque ferme.',
        onChanged: (v) => upd(() => p.bankEntryCost = (v / 1000).round() * 1000.0)),
    KV('Banques fondées · fermées (total)', '${sim.banksFounded} · ${sim.banksClosed}'),
    KV('Profit espéré d’une nouvelle banque', sim.banks.isEmpty ? '—' : '${money0(sim.bankEntrantProfit())}/j'),
    const SizedBox(height: 6),
    if (sim.banks.isEmpty)
      Text(sim.modules.banking ? 'La Caisse populaire seule (une banque).' : 'Module coupé.',
          style: TextStyle(color: pal.ink3, fontSize: 12))
    else ...[
      for (final b in sim.banks)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Text('${b.name}${b.ownerId != null ? ' (fondée par ${sim.citizen(b.ownerId!)?.name ?? 'un citoyen parti'})' : ''}',
                      style: TextStyle(color: b.alive ? pal.ink : pal.ink3, fontSize: 12.5, fontWeight: FontWeight.w600))),
              Text(b.alive ? b.state : 'fermée j${b.closed}',
                  style: TextStyle(
                      color: !b.alive ? pal.ink3 : (b.state == 'saine' ? pal.ok : pal.warn), fontSize: 11.5)),
            ]),
            if (b.alive) ...[
              KV('Capital · ratio de capital',
                  '${kmoney(b.equityNow)} · ${b.capitalRatio.isFinite ? pct(b.capitalRatio) : '—'}'),
              KV('Prêts · dépôts · réserves', '${kmoney(b.loans)} · ${kmoney(b.deposits)} · ${kmoney(b.reserves)}'),
              KV('Taux : dépôts · prêts · carte',
                  '${rate(b.depositRate)} · ${rate(p.interestRate + b.loanSpread)} · ${rate(p.cardRate + b.cardSpread)}'),
              KV('Profit lissé · clients', '${money0(b.profitEma)}/j · ${b.clients}',
                  color: b.profitEma < 0 ? pal.warn : null),
              if (b.interbank != 0)
                KV(b.interbank > 0 ? 'Prêté aux autres banques' : 'Emprunté aux autres banques', kmoney(b.interbank.abs())),
            ],
          ]),
        ),
      if (sim.bankCountHist.length > 1)
        ChartCard(
            title: 'Nombre de banques',
            minY: 0,
            series: [Series('banques', pal.money, downsample([for (final n in sim.bankCountHist) n.toDouble()]))]),
    ],
  ]);
}
