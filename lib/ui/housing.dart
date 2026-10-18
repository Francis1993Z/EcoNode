// Marché immobilier (module Bâtiments) : fiche d'un logement, en vente ou non, et onglet « Immobilier » qui montre le marché.
// L'interface ne modifie rien dans le moteur : elle lit les bâtiments, les hypothèques et les statistiques du parc, et tient
// son propre journal quotidien du marché (HousingLog) pour les courbes.

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../engine/model.dart';
import '../engine/sim.dart';
import 'charts.dart';
import 'controller.dart';
import 'format.dart';
import 'palette.dart';
import 'widgets.dart';

// ------------------------------------------------------------------ journal du marché

/// Une valeur par jour simulé, relevée par l'interface après chaque jour (rien n'est écrit dans le moteur).
class HousingLog {
  static const int _cap = 6000;
  final List<int> days = [];
  final List<double> listed = []; // logements en vente
  final List<double> building = []; // chantiers en cours
  final List<double> askAvg = []; // prix demandé moyen des logements en vente
  final List<double> fairAvg = []; // valeur courante moyenne du parc habitable
  final List<double> priceEma = []; // prix de vente moyen lissé (moteur)
  final List<double> ownerShare = []; // part des ménages propriétaires-occupants
  final List<double> heat = []; // chaleur du marché, de −1 à +1
  final List<double> debt = []; // encours des hypothèques
  final List<double> salesCum = []; // ventes cumulées
  final List<double> foreclosuresCum = []; // saisies cumulées
  final List<double> refusedCum = []; // achats refusés cumulés

  void clear() {
    for (final l in [days, listed, building, askAvg, fairAvg, priceEma, ownerShare, heat, debt, salesCum, foreclosuresCum, refusedCum]) {
      l.clear();
    }
  }

  void sample(Sim s) {
    if (!s.modules.buildings || s.buildings.isEmpty) return;
    if (days.isNotEmpty && days.last == s.day) return;
    var nListed = 0, nBuilding = 0, nHab = 0;
    var ask = 0.0, fair = 0.0;
    for (final b in s.buildings) {
      if (!b.done) {
        nBuilding++;
        continue;
      }
      if (b.habitable) {
        nHab++;
        fair += s.fairValue(b);
      }
      if (b.listedDay != null) {
        nListed++;
        ask += s.askPrice(b);
      }
    }
    if (days.length >= _cap) {
      const drop = 1000;
      for (final l in [listed, building, askAvg, fairAvg, priceEma, ownerShare, heat, debt, salesCum, foreclosuresCum, refusedCum]) {
        l.removeRange(0, drop);
      }
      days.removeRange(0, drop);
    }
    days.add(s.day);
    listed.add(nListed.toDouble());
    building.add(nBuilding.toDouble());
    askAvg.add(nListed > 0 ? ask / nListed : (askAvg.isEmpty ? 0 : askAvg.last));
    fairAvg.add(nHab > 0 ? fair / nHab : 0);
    priceEma.add(s.bstats.priceEma);
    ownerShare.add(s.citizens.isEmpty ? 0 : s.homeOwners / s.citizens.length);
    heat.add(s.housingHeat);
    debt.add(s.mortgageDebt());
    salesCum.add(s.bstats.sales.toDouble());
    foreclosuresCum.add(s.bstats.foreclosures.toDouble());
    refusedCum.add(s.bstats.refused.toDouble());
  }

  /// Variation sur [window] jours d'un compteur cumulé (ventes sur 30 jours, par exemple).
  static List<double> rolling(List<double> cum, [int window = 30]) =>
      [for (var i = 0; i < cum.length; i++) cum[i] - cum[math.max(0, i - window)]];
}

// ------------------------------------------------------------------ état d'un logement

/// Libellé et couleur de l'état d'un logement.
({String label, Color color}) buildingStatus(Pal pal, Building b) {
  if (!b.done) return (label: 'en construction', color: pal.ink3);
  final dead = b.habitable ? '' : ' · inhabitable';
  if (b.listedDay != null) {
    return (label: b.ownerKind == 2 ? 'en vente (saisi)$dead' : 'en vente$dead', color: pal.accent);
  }
  switch (b.ownerKind) {
    case 2:
      return (label: 'en liquidation$dead', color: pal.bad);
    case 1:
      return (label: 'occupé par son propriétaire$dead', color: pal.ok);
    default:
      return (label: 'loué par un bailleur$dead', color: pal.transfo);
  }
}

String ownerLabel(Sim sim, Building b) {
  switch (b.ownerKind) {
    case 0:
      return sim.firm(b.ownerId ?? -1)?.name ?? 'bailleur disparu';
    case 1:
      return sim.citizen(b.ownerId ?? -1)?.name ?? 'ménage disparu';
    default:
      return 'la Caisse (liquidation)';
  }
}

String _ownerKindLabel(int kind) => kind == 0 ? 'bailleur' : (kind == 1 ? 'ménage' : 'Caisse');

Widget _title(BuildContext context, String text) =>
    Text(text, style: TextStyle(color: Pal.of(context).ink, fontSize: 17, fontWeight: FontWeight.w800));

// ------------------------------------------------------------------ fiche d'un logement

class BuildingView extends StatelessWidget {
  final SimController ctrl;
  const BuildingView(this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final b = sim.building(ctrl.selection.id ?? -1);
    if (b == null) {
      return Padding(
          padding: const EdgeInsets.all(16), child: Text('Ce logement n’existe plus.', style: TextStyle(color: pal.ink2)));
    }
    final p = sim.params;
    final st = buildingStatus(pal, b);
    final m = sim.mortgageOf(b);
    final fair = sim.fairValue(b);
    final rc = sim.replacementCost();
    final listed = b.listedDay != null && b.done;
    final ask = listed ? sim.askPrice(b) : 0.0;
    final owe = m?.principal ?? 0.0;
    final landlord = b.ownerKind == 0 ? sim.firm(b.ownerId ?? -1) : null;
    final owner = b.ownerKind == 1 ? sim.citizen(b.ownerId ?? -1) : null;
    final rent = landlord?.price['logement'];
    final daysListed = listed ? sim.day - b.listedDay! : 0;
    final margin = b.ownerKind == 2 ? -0.10 : p.listingMargin;
    final factor = listed ? math.max(p.listingFloor, 1 - p.listingDecay * daysListed) : 1.0;

    return ListView(padding: const EdgeInsets.all(12), children: [
      Row(children: [
        Expanded(child: _title(context, 'Logement n° ${b.id}')),
        Pill(st.label, st.color),
      ]),
      const SizedBox(height: 10),
      if (!sim.modules.buildings)
        Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('Le module Bâtiments est coupé : ce logement est figé.', style: TextStyle(color: pal.warn, fontSize: 12))),
      Section('Le bien', [
        KV('Construit le jour', '${b.builtDay}'),
        KV('Modules posés', '${b.modules} / ${p.dwellingModules}${b.done ? '' : '  (chantier en cours)'}'),
        _Meter('État', b.cond, threshold: Building.minCond),
        KV('Habitable', b.habitable ? 'oui' : (b.done ? 'non (état sous ${pct(Building.minCond)})' : 'non (en chantier)'),
            color: b.habitable || !b.done ? null : pal.bad),
      ]),
      if (b.done)
        Section('Valeur', [
          KV('Valeur courante', money0(fair)),
          KV('Coût de remplacement (neuf)', money0(rc)),
          KV('Chaleur du marché', '${fmtNum(sim.housingHeat, 2)}  (${_heatWord(sim.housingHeat)})'),
          KV('Payé ou dépensé par le propriétaire', money0(b.basis)),
          KV('Gain ou perte en cas de vente à la valeur courante', '${fair - b.basis >= 0 ? '+' : ''}${money0(fair - b.basis)}',
              color: fair - b.basis >= 0 ? pal.ok : pal.bad),
        ]),
      if (listed)
        Section('En vente', [
          KV('Mis en vente le jour', '${b.listedDay}  (depuis $daysListed j)'),
          KV('Prix demandé aujourd’hui', money0(ask)),
          KV('Rapport à la valeur courante', pct(fair > 0 ? ask / fair : 0)),
          KV('Marge de départ', '${margin >= 0 ? '+' : ''}${pct(margin)}${b.ownerKind == 2 ? '  (la Caisse vend sous la valeur)' : ''}'),
          KV('Baisse accumulée', pct(1 - factor), color: factor <= p.listingFloor + 1e-9 ? pal.warn : null),
          if (factor <= p.listingFloor + 1e-9) Text('Le prix a atteint son plancher.', style: TextStyle(color: pal.warn, fontSize: 12)),
          if (b.ownerKind == 1) KV('Retiré de la vente dans', '${math.max(0, 200 - daysListed)} j  (sans acheteur)'),
          if (owe > 0) KV('Hypothèque à rembourser', money0(owe)),
          KV('Produit net pour le vendeur', money0(ask - owe), color: ask - owe < 0 ? pal.bad : null),
          KV('Locataires qui veulent acheter', '${_wouldBuy(sim)}'),
        ])
      else if (b.done)
        Section('Pas en vente', [
          Text(
              b.ownerKind == 1
                  ? 'Le propriétaire y habite. Il peut le mettre en vente s’il déménage (chance quotidienne ${pct(p.relocateChance)}).'
                  : (b.ownerKind == 0
                      ? 'Le bailleur le loue. Il en met en vente quand la demande de logements est faible.'
                      : 'La Caisse liquide ce bâtiment ; il sera mis en vente.'),
              style: TextStyle(color: pal.ink2, fontSize: 12.5)),
          KV('Prix demandé s’il était mis en vente', money0(sim.fairValue(b) * (1 + margin))),
        ]),
      Section('Propriétaire', [
        _LinkRow(
            label: _ownerKindLabel(b.ownerKind),
            text: ownerLabel(sim, b),
            onTap: landlord != null
                ? () => ctrl.select(Selection('firm', landlord.id))
                : (owner != null ? () => ctrl.select(Selection('citizen', owner.id)) : null)),
        if (owner != null) ...[
          KV('Argent', money0(owner.money)),
          KV('Emploi', owner.employer == null ? 'sans emploi' : (sim.firm(owner.employer!)?.name ?? '—'),
              color: owner.employer == null ? pal.warn : null),
        ],
        if (landlord != null) ...[
          if (rent != null) KV('Loyer demandé', '${money(rent)} / jour'),
          if (rent != null && fair > 0) KV('Rendement brut annuel', pct(rent * 365 / fair)),
          Text('Les locataires ne sont pas rattachés à un logement précis : le bailleur loue au marché.',
              style: TextStyle(color: pal.ink3, fontSize: 11.5)),
        ],
        if (b.ownerKind == 2 && b.payee != null) KV('Surplus de la vente pour', sim.citizen(b.payee!)?.name ?? '—'),
        if (b.ownerKind == 2 && b.payee == null) const KV('Surplus de la vente pour', 'l’État'),
      ]),
      if (m != null)
        Section('Hypothèque', [
          KV('Capital dû', money0(m.principal)),
          KV('Rapport dette / valeur', pct(fair > 0 ? m.principal / fair : 0), color: fair > 0 && m.principal > fair ? pal.bad : null),
          KV('Valeur nette (valeur − dette)', money0(fair - m.principal), color: fair - m.principal < 0 ? pal.bad : null),
          KV('Taux annuel', pct(m.rate)),
          KV('Versement quotidien', money(m.payment)),
          KV('Jours restants', '${m.termLeft}'),
          KV('Depuis le jour', '${m.since}'),
          KV('Jours de retard', '${m.missed}', color: m.missed > 0 ? pal.bad : null),
          if (m.borrowerKind == 2) const KV('Débiteur', 'plus de débiteur'),
          if (m.borrowerKind != 2)
            _LinkRow(
                label: 'Débiteur',
                text: m.borrowerKind == 0 ? (sim.firm(m.borrowerId ?? -1)?.name ?? '—') : (sim.citizen(m.borrowerId ?? -1)?.name ?? '—'),
                onTap: () => ctrl.select(Selection(m.borrowerKind == 0 ? 'firm' : 'citizen', m.borrowerId)))
        ])
      else if (b.done)
        Section('Hypothèque', [Text('Aucune hypothèque sur ce bien.', style: TextStyle(color: pal.ink2, fontSize: 12.5))]),
      Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
            onPressed: () => ctrl.setTab(Tabs.housing),
            icon: const Icon(Icons.home_work_outlined, size: 16),
            label: const Text('Voir le marché immobilier')),
      ),
      const SizedBox(height: 24),
    ]);
  }

  static int _wouldBuy(Sim sim) => sim.citizens.where((c) => c.homeId == null && c.wantsToOwn && c.employer != null).length;
}

String _heatWord(double h) => h > 0.5 ? 'marché serré' : (h < -0.5 ? 'logements vacants en abondance' : 'équilibré');

class _LinkRow extends StatelessWidget {
  final String label;
  final String text;
  final VoidCallback? onTap;
  const _LinkRow({required this.label, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return Row(children: [
      Text(label[0].toUpperCase() + label.substring(1), style: TextStyle(color: pal.ink2, fontSize: 12.5)),
      const Spacer(),
      Flexible(
        child: onTap == null
            ? Text(text, textAlign: TextAlign.right, style: mono(pal.ink, 12.5, weight: FontWeight.w600))
            : TextButton(onPressed: onTap, child: Text(text, overflow: TextOverflow.ellipsis)),
      ),
    ]);
  }
}

/// Jauge de 0 à 100 % avec un seuil.
class _Meter extends StatelessWidget {
  final String label;
  final double value;
  final double? threshold;
  const _Meter(this.label, this.value, {this.threshold});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final v = value.clamp(0.0, 1.0).toDouble();
    final col = threshold != null && v < threshold! ? pal.bad : (v < 0.6 ? pal.warn : pal.ok);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(children: [
        SizedBox(width: 130, child: Text(label, style: TextStyle(color: pal.ink2, fontSize: 12.5))),
        Expanded(
          child: Stack(alignment: Alignment.centerLeft, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: v, minHeight: 8, color: col, backgroundColor: pal.rule2),
            ),
            if (threshold != null)
              Align(
                alignment: Alignment(threshold! * 2 - 1, 0),
                child: Container(width: 2, height: 12, color: pal.ink3),
              ),
          ]),
        ),
        SizedBox(width: 56, child: Text(pct(v), textAlign: TextAlign.right, style: mono(pal.ink2, 11))),
      ]),
    );
  }
}

// ------------------------------------------------------------------ onglet Immobilier

class HousingTab extends StatelessWidget {
  final SimController ctrl;
  const HousingTab(this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    if (!sim.modules.buildings) {
      return ListView(padding: const EdgeInsets.all(12), children: [
        _title(context, 'Marché immobilier'),
        const SizedBox(height: 10),
        Section('Module coupé', [
          Text(
              'Le module Bâtiments n’est pas actif dans cette partie : les logements ne sont ni construits, ni achetés, ni revendus. '
              'On peut l’activer ici (il prend effet au prochain jour) ou à la création d’une partie (« Marché immobilier »).',
              style: TextStyle(color: pal.ink2, fontSize: 12.5)),
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(Modules.labels['buildings']!, style: const TextStyle(fontSize: 13)),
            value: false,
            onChanged: (v) {
              sim.modules.buildings = v;
              ctrl.touch();
            },
          ),
        ]),
      ]);
    }
    final log = ctrl.housing;
    final bs = sim.buildings;
    final n = sim.citizens.length;
    final listed = [for (final b in bs) if (b.done && b.listedDay != null) b];
    final building = bs.where((b) => !b.done).length;
    final liquidation = bs.where((b) => b.done && b.ownerKind == 2).length;
    final ruined = bs.where((b) => b.done && !b.habitable).length;
    final owners = sim.homeOwners;
    final renters = n - owners;
    final wantBuy = sim.citizens.where((c) => c.homeId == null && c.wantsToOwn && c.employer != null).length;
    final homeless = sim.citizens.where((c) => c.homeless).length;
    var ask = 0.0, fair = 0.0, daysSum = 0.0;
    final byOwner = [0, 0, 0];
    for (final b in listed) {
      ask += sim.askPrice(b);
      fair += sim.fairValue(b);
      daysSum += sim.day - b.listedDay!;
      byOwner[b.ownerKind]++;
    }
    final st = sim.bstats;

    final sorted = List<Building>.from(listed)..sort((a, b) => sim.askPrice(a).compareTo(sim.askPrice(b)));
    final site = bs.where((b) => !b.done).toList()..sort((a, b) => b.modules.compareTo(a.modules));
    final seized = bs.where((b) => b.done && b.ownerKind == 2 && b.listedDay == null).toList();

    final d30 = HousingLog.rolling(log.salesCum);
    final f30 = HousingLog.rolling(log.foreclosuresCum);
    final r30 = HousingLog.rolling(log.refusedCum);

    // histogrammes : durée en vente, état du parc
    const dayEdges = [10, 30, 60, 100, 200];
    final dayBins = List<double>.filled(dayEdges.length + 1, 0);
    for (final b in listed) {
      final d = sim.day - b.listedDay!;
      var i = 0;
      while (i < dayEdges.length && d >= dayEdges[i]) {
        i++;
      }
      dayBins[i]++;
    }
    final dayLabels = ['<10 j', '10–30', '30–60', '60–100', '100–200', '200 j +'];
    final condBins = List<double>.filled(10, 0);
    for (final b in bs) {
      if (b.done) condBins[(b.cond * 10).floor().clamp(0, 9).toInt()]++;
    }
    final condLabels = [for (var i = 0; i < 10; i++) '${i * 10}%'];

    return ListView(padding: const EdgeInsets.all(12), children: [
      _title(context, 'Marché immobilier'),
      const SizedBox(height: 10),
      Section('Parc', [
        KV('Bâtiments', '${bs.length}  (habitables : ${sim.dwellings})'),
        KV('En construction', '$building'),
        KV('Inhabitables (état sous ${pct(Building.minCond)})', '$ruined', color: ruined > 0 ? pal.warn : null),
        KV('En liquidation (saisis)', '$liquidation', color: liquidation > 0 ? pal.bad : null),
        KV('Propriétaires-occupants', '$owners  (${pct(n > 0 ? owners / n : 0)} des ménages)'),
        KV('Locataires', '$renters'),
        KV('… qui voudraient acheter', '$wantBuy'),
        KV('Sans logis', '$homeless', color: homeless > 0 ? pal.bad : null),
        _Meter('Chaleur du marché', (sim.housingHeat + 1) / 2),
        Text('${fmtNum(sim.housingHeat, 2)} : ${_heatWord(sim.housingHeat)}', style: TextStyle(color: pal.ink3, fontSize: 11)),
      ]),
      Section('En vente', [
        KV('Logements en vente', '${listed.length}'),
        if (listed.isNotEmpty) ...[
          KV('… bailleurs · ménages · Caisse', '${byOwner[0]} · ${byOwner[1]} · ${byOwner[2]}'),
          KV('Prix demandé moyen', money0(ask / listed.length)),
          KV('Valeur courante moyenne de ces logements', money0(fair / listed.length)),
          KV('Rabais moyen demandé sur la valeur', pct(fair > 0 ? 1 - ask / fair : 0)),
          KV('Durée moyenne en vente', '${fmtNum(daysSum / listed.length, 0)} j'),
        ],
        KV('Prix de vente moyen (lissé)', st.priceEma > 0 ? money0(st.priceEma) : '—'),
      ]),
      Section('Depuis le début', [
        KV('Ventes', '${st.sales}'),
        KV('Logements construits', '${st.built}'),
        KV('Hypothèques accordées', '${st.opened}'),
        KV('Achats refusés', '${st.refused}'),
        KV('Saisies', '${st.foreclosures}', color: st.foreclosures > 0 ? pal.bad : null),
        KV('Chantiers abandonnés', '${st.abandoned}'),
        KV('Gains de revente (cumul)', money0(st.gains), color: pal.ok),
        KV('Pertes de revente (cumul)', money0(st.losses), color: st.losses > 0 ? pal.bad : null),
        KV('Dette hypothécaire', kmoney(sim.mortgageDebt())),
      ]),
      _MarketMap(ctrl, listed),
      if (log.days.length > 2) ...[
        ChartCard(
          title: 'Prix des logements',
          unit: '\$',
          minY: 0,
          series: [
            Series('Valeur courante moyenne', pal.ink3, downsample(log.fairAvg)),
            Series('Prix demandé moyen', pal.accent, downsample(log.askAvg)),
            Series('Prix de vente (lissé)', pal.money, downsample(log.priceEma)),
          ],
        ),
        ChartCard(
          title: 'Offre : logements en vente et chantiers',
          minY: 0,
          series: [
            Series('En vente', pal.accent, downsample(log.listed)),
            Series('En construction', pal.primaire, downsample(log.building)),
          ],
        ),
        ChartCard(
          title: 'Transactions sur 30 jours',
          minY: 0,
          series: [
            Series('Ventes', pal.money, downsample(d30)),
            Series('Achats refusés', pal.warn, downsample(r30)),
            Series('Saisies', pal.bad, downsample(f30)),
          ],
        ),
        ChartCard(
          title: 'Propriétaires-occupants',
          unit: '%',
          minY: 0,
          series: [Series('Part des ménages', pal.ok, downsample(log.ownerShare))],
        ),
        ChartCard(
          title: 'Chaleur du marché (−1 détendu, +1 serré)',
          minY: -1,
          series: [Series('Chaleur', pal.warn, downsample(log.heat))],
        ),
        ChartCard(
          title: 'Dette hypothécaire',
          unit: '\$',
          minY: 0,
          series: [Series('Encours', pal.transfo, downsample(log.debt))],
        ),
      ],
      HistogramCard(title: 'Durée en vente (nb de logements)', values: dayBins, labels: dayLabels, color: pal.accent),
      HistogramCard(title: 'État du parc (nb de bâtiments, par tranche d’état)', values: condBins, labels: condLabels, color: pal.transfo),
      Section('En vente (les moins chers d’abord)', [
        if (sorted.isEmpty) Text('Aucun logement en vente.', style: TextStyle(color: pal.ink3, fontSize: 12)),
        for (final b in sorted.take(30)) _BuildingRow(ctrl, b),
        if (sorted.length > 30) Text('… et ${sorted.length - 30} autres', style: TextStyle(color: pal.ink3, fontSize: 12)),
      ]),
      if (site.isNotEmpty)
        Section('Chantiers en cours', [
          for (final b in site.take(12)) _BuildingRow(ctrl, b),
          if (site.length > 12) Text('… et ${site.length - 12} autres', style: TextStyle(color: pal.ink3, fontSize: 12)),
        ]),
      if (seized.isNotEmpty)
        Section('Saisis, pas encore en vente', [
          for (final b in seized.take(12)) _BuildingRow(ctrl, b),
          if (seized.length > 12) Text('… et ${seized.length - 12} autres', style: TextStyle(color: pal.ink3, fontSize: 12)),
        ]),
      const SizedBox(height: 24),
    ]);
  }
}

/// Section de la fiche d'un bailleur (entreprise « immobilier ») : son parc, ses logements en vente, ses hypothèques.
Widget landlordSection(BuildContext context, SimController ctrl, Firm f) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final mine = [for (final b in sim.buildings) if (b.ownerKind == 0 && b.ownerId == f.id) b];
  final done = mine.where((b) => b.done).toList();
  final forSale = done.where((b) => b.listedDay != null).toList()..sort((a, b) => sim.askPrice(a).compareTo(sim.askPrice(b)));
  final site = mine.length - done.length;
  var debt = 0.0, fair = 0.0;
  for (final b in done) {
    debt += sim.mortgageOf(b)?.principal ?? 0.0;
    fair += sim.fairValue(b);
  }
  final rent = f.price['logement'];
  return Section('Parc de logements', [
    KV('Logements', '${done.length}  (habitables : ${done.where((b) => b.habitable).length})'),
    KV('En vente', '${forSale.length}'),
    KV('En construction', '$site'),
    KV('Valeur courante du parc', kmoney(fair)),
    KV('Dette hypothécaire', kmoney(debt), color: debt > fair * 0.8 ? pal.warn : null),
    if (rent != null) KV('Loyer demandé', '${money(rent)} / jour'),
    if (rent != null && done.isNotEmpty && fair > 0) KV('Rendement brut annuel', pct(rent * done.length * 365 / fair)),
    for (final b in forSale.take(8)) _BuildingRow(ctrl, b),
    if (forSale.length > 8) Text('… et ${forSale.length - 8} autres en vente', style: TextStyle(color: pal.ink3, fontSize: 12)),
    Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
          onPressed: () => ctrl.setTab(Tabs.housing),
          icon: const Icon(Icons.home_work_outlined, size: 16),
          label: const Text('Voir le marché immobilier')),
    ),
  ]);
}

/// Une ligne de liste : état, propriétaire, prix demandé ou valeur ; toucher ouvre la fiche.
class _BuildingRow extends StatelessWidget {
  final SimController ctrl;
  final Building b;
  const _BuildingRow(this.ctrl, this.b);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final st = buildingStatus(pal, b);
    final price = b.done ? (b.listedDay != null ? sim.askPrice(b) : sim.fairValue(b)) : 0.0;
    return InkWell(
      onTap: () => ctrl.select(Selection('building', b.id)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(children: [
          SizedBox(width: 44, child: Text('n° ${b.id}', style: mono(pal.ink2, 11.5))),
          Container(width: 8, height: 8, margin: const EdgeInsets.only(right: 6), decoration: BoxDecoration(color: st.color, shape: BoxShape.circle)),
          Expanded(
              child: Text('${ownerLabel(sim, b)} · ${b.done ? 'état ${pct(b.cond)}' : '${b.modules}/${sim.params.dwellingModules} modules'}',
                  overflow: TextOverflow.ellipsis, style: TextStyle(color: pal.ink, fontSize: 12.5))),
          if (b.listedDay != null) Text('${sim.day - b.listedDay!} j  ', style: TextStyle(color: pal.ink3, fontSize: 11)),
          if (b.done) Text(money0(price), style: mono(pal.ink2, 12)),
        ]),
      ),
    );
  }
}

// ------------------------------------------------------------------ carte des logements en vente

/// Nuage de points des logements en vente : état (x) et prix demandé (y), avec la valeur courante en trait ; la couleur dit
/// qui vend. Toucher un point ouvre la fiche du logement.
class _MarketMap extends StatelessWidget {
  final SimController ctrl;
  final List<Building> listed;
  const _MarketMap(this.ctrl, this.listed);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final pts = [for (final b in listed) _Pt(b, b.cond, sim.askPrice(b))];
    final rc = sim.replacementCost();
    final heat = sim.housingHeat;
    double fairAt(double cond) => rc * (0.25 + 0.75 * cond) * (1 + 0.15 * heat);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(color: pal.sheet, borderRadius: BorderRadius.circular(8), border: Border.all(color: pal.rule2)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Carte des logements en vente (état et prix demandé)', style: TextStyle(color: pal.ink, fontSize: 12, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Wrap(spacing: 10, runSpacing: 2, children: [
          for (final e in [('Bailleur', pal.transfo), ('Ménage', pal.conso), ('Caisse (saisi)', pal.bad), ('Valeur courante', pal.ink3)])
            Row(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: e.$2, shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Text(e.$1, style: TextStyle(color: pal.ink2, fontSize: 10.5)),
            ]),
        ]),
        const SizedBox(height: 6),
        if (pts.isEmpty)
          Padding(padding: const EdgeInsets.symmetric(vertical: 24), child: Text('Aucun logement en vente.', style: TextStyle(color: pal.ink3, fontSize: 12)))
        else
          LayoutBuilder(builder: (context, box) {
            final painter = _MapPainter(pts, fairAt, pal);
            return GestureDetector(
              onTapUp: (d) {
                final hit = painter.nearest(d.localPosition, Size(box.maxWidth, 190));
                if (hit != null) ctrl.select(Selection('building', hit.b.id));
              },
              child: SizedBox(height: 190, width: double.infinity, child: CustomPaint(painter: painter)),
            );
          }),
        if (pts.isNotEmpty)
          Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text('Au-dessus du trait : plus cher que la valeur courante. Un prix qui baisse avec les jours sans acheteur descend vers le trait.',
                  style: TextStyle(color: pal.ink3, fontSize: 10.5))),
      ]),
    );
  }
}

class _Pt {
  final Building b;
  final double x, y;
  _Pt(this.b, this.x, this.y);
}

class _MapPainter extends CustomPainter {
  final List<_Pt> pts;
  final double Function(double cond) fairAt;
  final Pal pal;
  late final double top; // prix en haut de la carte
  late final double bot; // prix en bas de la carte
  late final double xlo; // état à gauche de la carte (la carte s'ajuste aux logements en vente)
  _MapPainter(this.pts, this.fairAt, this.pal) {
    var lo = 1.0;
    var pmin = double.infinity, pmax = 0.0;
    for (final p in pts) {
      if (p.x < lo) lo = p.x;
      if (p.y < pmin) pmin = p.y;
      if (p.y > pmax) pmax = p.y;
    }
    xlo = math.min(0.9, (lo * 10).floor() / 10);
    top = math.max(fairAt(1), pmax) * 1.06;
    final bot0 = math.min(fairAt(xlo), pmin) * 0.9;
    bot = math.max(0.0, math.min(bot0, top * 0.9));
  }

  static const double left = 44, bottom = 18, pad = 6;

  Offset at(_Pt p, Size s) => pos(p.x, p.y, s);
  Offset pos(double cond, double price, Size s) => Offset(
      left + ((cond - xlo) / (1 - xlo)).clamp(0.0, 1.0) * (s.width - left - pad),
      pad + (1 - ((price - bot) / (top - bot)).clamp(0.0, 1.0)) * (s.height - bottom - pad));

  _Pt? nearest(Offset o, Size s) {
    _Pt? best;
    var bd = 18.0 * 18.0;
    for (final p in pts) {
      final q = at(p, s);
      final d = (q - o).distanceSquared;
      if (d < bd) {
        bd = d;
        best = p;
      }
    }
    return best;
  }

  @override
  bool shouldRepaint(covariant _MapPainter old) => true;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = pal.gridMinor
      ..strokeWidth = 1;
    void label(String t, Offset o, {bool right = false}) {
      final tp = TextPainter(text: TextSpan(text: t, style: mono(pal.ink3, 9)), textDirection: ui.TextDirection.ltr)..layout();
      tp.paint(canvas, right ? Offset(o.dx - tp.width, o.dy) : o);
    }

    for (var i = 0; i <= 4; i++) {
      final y = pad + i * (size.height - bottom - pad) / 4;
      canvas.drawLine(Offset(left, y), Offset(size.width - pad, y), grid);
      label(kmoney(bot + (top - bot) * (1 - i / 4)), Offset(left - 4, y - 5), right: true);
    }
    for (var i = 0; i <= 5; i++) {
      final x = left + i * (size.width - left - pad) / 5;
      canvas.drawLine(Offset(x, pad), Offset(x, size.height - bottom), grid);
      label('${((xlo + (1 - xlo) * i / 5) * 100).round()}%', Offset(x - 8, size.height - bottom + 3));
    }
    // valeur courante selon l'état
    final line = Path()..moveTo(pos(xlo, fairAt(xlo), size).dx, pos(xlo, fairAt(xlo), size).dy);
    for (var i = 1; i <= 20; i++) {
      final c = xlo + (1 - xlo) * i / 20;
      final o = pos(c, fairAt(c), size);
      line.lineTo(o.dx, o.dy);
    }
    canvas.drawPath(
        line,
        Paint()
          ..color = pal.ink3
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5);
    final shown = pts.length > 3000 ? pts.sublist(0, 3000) : pts;
    for (final p in shown) {
      final col = p.b.ownerKind == 0 ? pal.transfo : (p.b.ownerKind == 1 ? pal.conso : pal.bad);
      canvas.drawCircle(at(p, size), 3.4, Paint()..color = col.withValues(alpha: 0.7));
    }
  }
}
