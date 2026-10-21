// Onglet Inspecteur : détail de l'élément sélectionné dans le graphe.

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../engine/model.dart';
import '../engine/monitor.dart';
import '../engine/sim.dart';
import 'charts.dart';
import 'controller.dart';
import 'format.dart';
import 'housing.dart';
import 'palette.dart';
import 'widgets.dart';

class InspectorTab extends StatelessWidget {
  final SimController ctrl;
  const InspectorTab(this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final s = ctrl.selection;
    switch (s.kind) {
      case 'firm':
        final f = ctrl.sim.firm(s.id!);
        if (f == null) return const _Empty();
        return _FirmView(ctrl, f);
      case 'citizen':
        final c = ctrl.sim.citizen(s.id!);
        if (c == null) return const _Empty();
        return _CitizenView(ctrl, c);
      case 'building':
        return BuildingView(ctrl);
      case 'E':
        return _StateView(ctrl);
      case 'B':
        return _BankView(ctrl);
      case 'X':
        return _WorldView(ctrl);
      default:
        return _HomesView(ctrl);
    }
  }
}

class _Empty extends StatelessWidget {
  const _Empty();
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(16),
      child: Text('Cet élément n’existe plus.', style: TextStyle(color: Pal.of(context).ink2)));
}

Widget _title(BuildContext context, String text) =>
    Text(text, style: TextStyle(color: Pal.of(context).ink, fontSize: 17, fontWeight: FontWeight.w800));

/// Alertes actives qui concernent cette entreprise.
List<Alert> _alertsFor(SimController ctrl, int firmId) =>
    ctrl.sim.monitor.sorted.where((a) => a.key.endsWith(':$firmId')).toList();

/// Alertes d'une entreprise : une boîte de hauteur fixe, toujours présente (même vide), pour que l'arrivée ou la fin d'une
/// alerte ne déplace pas le reste de la fiche.
Widget _alertBox(BuildContext context, List<Alert> alerts) {
  final pal = Pal.of(context);
  return Section('Alertes (${alerts.length})', [
    FixedScrollBox(
      height: 54,
      children: [
        if (alerts.isEmpty) Text('Aucune alerte.', style: TextStyle(color: pal.ink3, fontSize: 12)),
        for (final a in alerts)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text('${a.critical ? '⛔' : '⚠'} ${alertLabels[a.type]} : ${a.what} (depuis j${a.since})',
                style: TextStyle(color: a.critical ? pal.bad : pal.warn, fontSize: 12)),
          ),
      ],
    ),
  ]);
}

// ------------------------------------------------------------------ entreprise

class _FirmView extends StatelessWidget {
  final SimController ctrl;
  final Firm f;
  const _FirmView(this.ctrl, this.f);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final tpl = f.template;
    final owner = f.ownerId != null ? sim.citizen(f.ownerId!) : null;
    final costs = sim.unitCost(f);
    final profit = f.profitEma;
    final hist = f.hist;
    final bailouts = sim.nets.byAgent['bailout']?[f.name] ?? 0;
    final refusals = sim.nets.byAgent['credit']?[f.name] ?? 0;
    final caps = sim.nets.byAgent['drift']?[f.name] ?? 0;
    final rnd = tpl.rnd;
    final maint = tpl.maint;

    return ListView(padding: const EdgeInsets.all(12), children: [
      Row(children: [
        Expanded(child: _title(context, f.name)),
        Pill(tpl.label, pal.sector(tpl.sector)),
      ]),
      const SizedBox(height: 10),
      _alertBox(context, _alertsFor(ctrl, f.id)),
      Section('Situation', [
        KV('Caisse', money0(f.money)),
        KV('Profit moyen / jour', '${profit >= 0 ? '+' : ''}${money0(profit)}', color: profit >= 0 ? pal.ok : pal.bad),
        KV('Employés', '${f.workers.length}  (postes ouverts : ${f.vacancies})'),
        KV(sim.modules.jobs ? 'Qualification du gabarit' : 'Qualification exigée', classLabels[tpl.skill]),
        if (sim.modules.jobs) ...[
          KV('Salaire moyen des contrats', money0(f.wage)),
          KV('Salaire affiché (${classLabels[tpl.skill].toLowerCase()})', money0(f.offer)),
        ] else
          KV('Salaire', money0(f.wage)),
        KV('Productivité par employé', '${fmtNum(sim.perWorker(f), 2)} lots/j'),
        KV('Capacité', f.capacity == null ? 'illimitée' : '${fmtNum(f.capacity!, 0)} lots/j'),
        if (owner != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(children: [
              Expanded(child: Text('Propriétaire', style: TextStyle(color: pal.ink2, fontSize: 12.5))),
              TextButton(
                  onPressed: () => ctrl.select(Selection('citizen', owner.id)),
                  child: Text('${owner.name} · ${kmoney(owner.money)}')),
            ]),
          ),
        if (f.inputLimited)
          Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text('⚠ Production limitée par manque d’intrants.', style: TextStyle(color: pal.warn, fontSize: 12))),
      ]),
      if (sim.modules.entrepreneurship && !sim.publicService(f)) _foundingSection(context, ctrl, f),
      if (sim.modules.products) _productSection(context, ctrl, f),
      if (sim.modules.banking) _firmBankSection(context, ctrl, f),
      if (sim.publicService(f)) _publicSection(context, ctrl, f),
      if (sim.modules.buildings && f.type == 'immobilier') landlordSection(context, ctrl, f),
      _StaffSection(ctrl, f),
      if (sim.modules.jobs) _orgChart(context, ctrl, f),
      if (sim.modules.jobs && f.talks.isNotEmpty) _talksSection(context, ctrl, f),
      Section('Capital et technologie', [
        KV('Machines', '${fmtNum(f.machines, 1)}  (×${fmtNum(sim.machineMult(f), 2)})'),
        KV('Technologie', 'niveau ${f.techLevel}  (×${fmtNum(sim.techMult(f), 2)})'),
        if (rnd != null)
          KV('R-D vers le niveau ${f.techLevel + 1}',
              '${fmtNum(f.rndProgress, 0)} / ${fmtNum(sim.rndCost(f.techLevel), 0)} ${goods[rnd]!.unit}s'),
        if (maint != null)
          KV('Entretien (${goods[maint]!.label.toLowerCase()})', pct(f.maintCover),
              color: f.maintCover < 0.7 ? pal.warn : null),
        if (tpl.heavy) KV('Opérations', '${pct(sim.uptime(f))} de la cadence', color: sim.uptime(f) < 0.85 ? pal.warn : null),
        KV('Comptabilité', pct(f.adminCover), color: f.adminCover < 0.7 ? pal.warn : null),
        if (tpl.ads) KV('Notoriété (publicité)', fmtNum(f.brand, 1)),
        KV('Dette', money0(f.debt), color: f.missedPayments > 0 ? pal.bad : null),
        if (f.debt > 0) KV('Intérêts du jour', money(f.interestToday)),
        if (f.missedPayments > 0) KV('Paiements manqués', '${f.missedPayments} j', color: pal.bad),
      ]),
      if (bailouts + refusals + caps > 0)
        Section('Filets déclenchés pour cette entreprise', [
          if (bailouts > 0) KV('Renflouements', '$bailouts', color: pal.warn),
          if (refusals > 0) KV('Prêts refusés (anti-crédit-fou)', '$refusals', color: pal.warn),
          if (caps > 0) KV('Prix ou salaires plafonnés', '$caps', color: pal.warn),
        ]),
      Section('Biens', [
        for (final g in [...f.outputs.keys, ...f.inputs.keys]) _goodBlock(context, g),
      ]),
      Section('Réglages divins', [
        Row(children: [
          Expanded(
              child: NumField(
                  label: sim.modules.jobs ? 'Salaire moyen (toute l’échelle)' : 'Salaire',
                  value: f.wage,
                  suffix: '\$',
                  decimals: 1,
                  onSubmit: (v) {
                    sim.godFirm(f.id, wage: v);
                    ctrl.touch();
                  })),
          const SizedBox(width: 8),
          _Lock('Fixer', f.lockWage, (v) {
            sim.godFirm(f.id, lockWage: v);
            ctrl.touch();
          }),
        ]),
        const SizedBox(height: 8),
        for (final g in f.outputs.keys) ...[
          Row(children: [
            Expanded(
                child: NumField(
                    label: 'Prix · ${goods[g]!.label}',
                    value: f.price[g],
                    suffix: '\$',
                    decimals: 2,
                    onSubmit: (v) {
                      sim.godFirm(f.id, prices: {g: v});
                      ctrl.touch();
                    })),
            const SizedBox(width: 8),
            _Lock('Fixer', f.lockPrice, (v) {
              sim.godFirm(f.id, lockPrice: v);
              ctrl.touch();
            }),
          ]),
          const SizedBox(height: 8),
        ],
        Row(children: [
          Expanded(
              child: NumField(
                  label: 'Productivité ×',
                  value: f.prodMult,
                  onSubmit: (v) {
                    sim.godFirm(f.id, prodMult: v);
                    ctrl.touch();
                  })),
          const SizedBox(width: 8),
          Expanded(
              child: NumField(
                  label: 'Capacité (lots/j)',
                  value: f.capacity,
                  decimals: 0,
                  onSubmit: (v) {
                    sim.godFirm(f.id, setCapacity: true, capacity: v);
                    ctrl.touch();
                  })),
          IconButton(
              tooltip: 'Capacité illimitée',
              onPressed: () {
                sim.godFirm(f.id, setCapacity: true, capacity: null);
                ctrl.touch();
              },
              icon: const Icon(Icons.all_inclusive)),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
              child: NumField(
                  label: 'Machines',
                  value: f.machines,
                  decimals: 1,
                  onSubmit: (v) {
                    sim.godFirm(f.id, machines: v);
                    ctrl.touch();
                  })),
          const SizedBox(width: 8),
          Expanded(
              child: NumField(
                  label: 'Niveau technologique',
                  value: f.techLevel.toDouble(),
                  decimals: 0,
                  onSubmit: (v) {
                    sim.godFirm(f.id, techLevel: v.round());
                    ctrl.touch();
                  })),
        ]),
        if (f.debt > 0) ...[
          const SizedBox(height: 8),
          Btn('Effacer la dette', () {
            sim.godFirm(f.id, forgiveDebt: true);
            ctrl.touch();
          }, icon: Icons.money_off),
        ],
      ]),
      _FirmMoney(ctrl, f),
      if (hist.length > 2)
        ChartCard(
          title: 'Caisse et dette',
          unit: '\$',
          series: [
            Series('caisse', pal.accent, downsample(hist.map((h) => h.money).toList())),
            Series('dette', pal.bad, downsample(hist.map((h) => h.debt).toList())),
          ],
        ),
      if (hist.length > 2)
        ChartCard(
          title: 'Employés et machines',
          series: [
            Series('employés', pal.transfo, downsample(hist.map((h) => h.workers.toDouble()).toList())),
            Series('machines', pal.primaire, downsample(hist.map((h) => h.machines).toList())),
          ],
          minY: 0,
        ),
      if (costs.isNotEmpty)
        Section('Coût de revient', [
          for (final e in costs.entries) KV(goods[e.key]!.label, money(e.value)),
          KV('Frais fixes / jour (services)', money(f.overheadEma)),
        ]),
      const SizedBox(height: 4),
      Row(children: [
        Expanded(
          child: Btn('Faillite', () {
            sim.godBankrupt(f.id);
            ctrl.touch();
          }, icon: Icons.trending_down),
        ),
        const SizedBox(width: 8),
        Expanded(child: Btn('Fermer', () => _confirmClose(context), danger: true, icon: Icons.delete_outline)),
      ]),
      const SizedBox(height: 24),
    ]);
  }

  Widget _goodBlock(BuildContext context, String g) {
    final pal = Pal.of(context);
    final gd = goods[g]!;
    final isOut = f.outputs.containsKey(g);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: pal.sector(gd.sector), shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(gd.label, style: TextStyle(color: pal.ink, fontWeight: FontWeight.w700, fontSize: 13)),
          const SizedBox(width: 6),
          Text(isOut ? 'produit' : 'intrant', style: TextStyle(color: pal.ink3, fontSize: 11)),
        ]),
        KV('Stock', '${qty(f.inv[g] ?? 0.0)} ${gd.unit}'),
        if (isOut && ctrl.sim.publicGood(g)) ...[
          const KV('Prix', 'gratuit (service public)'),
          KV('Servi hier', '${qty(f.sold[g] ?? 0.0)} ${gd.unit}'),
          KV('Produit hier', '${qty(f.produced[g] ?? 0.0)} ${gd.unit}'),
        ] else if (isOut) ...[
          KV('Prix affiché', money(f.price[g] ?? 0.0)),
          KV('Marge visée', pct(f.markup[g] ?? 0.0)),
          KV('Vendu hier', '${qty(f.sold[g] ?? 0.0)} ${gd.unit}'),
          KV('Produit hier', '${qty(f.produced[g] ?? 0.0)} ${gd.unit}'),
        ] else ...[
          KV('Meilleur prix du marché', money(ctrl.sim.bestPrice(g))),
          KV('Besoin par lot', '${fmtNum(f.inputs[g]!, 2)} ${gd.unit}'),
        ],
      ]),
    );
  }

  void _confirmClose(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Fermer ${f.name} ?'),
        content: Text(ctrl.sim.modules.bankruptcy
            ? 'Les employés sont mis à pied. La trésorerie rembourse d’abord la dette envers la Caisse, le solde '
                'impayé est radié, le reste va au propriétaire (ou à l’État).'
            : 'Les employés sont mis à pied, la caisse retourne au propriétaire et la dette est radiée.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Annuler')),
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                ctrl.sim.removeFirm(f.id);
                ctrl.select(const Selection('M'));
              },
              child: const Text('Fermer')),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------------ employés, organigramme, négociations

/// Ancienneté lisible : jours, puis mois, puis années.
String tenureLabel(int days) {
  if (days < 60) return '$days j';
  if (days < 730) return '${(days / 30.44).floor()} mois';
  return '${fmtNum(days / 365, 1)} ans';
}

/// Qualification exigée par un rôle : classe, seuil, et ancienneté pour les postes de promotion.
String roleRequirement(Role r) {
  final s = '${classLabels[r.level]} (${fmtNum(r.minSkill, 1)})';
  return r.internal ? '$s · ${tenureLabel(r.minTenure)} d’ancienneté' : s;
}

/// Tous les employés d'une entreprise : rôle, qualification, salaire, ancienneté.
class _StaffSection extends StatelessWidget {
  final SimController ctrl;
  final Firm f;
  const _StaffSection(this.ctrl, this.f);

  static const int _shown = 80;

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final jobs = sim.modules.jobs;
    final rs = roles[f.type]!;
    final team = [for (final id in f.workers) sim.citizen(id)].whereType<Citizen>().toList();
    double pay(Citizen c) => jobs ? c.wage : f.wage;
    double rel(Citizen c) => jobs && c.role >= 0 ? roleRel(f.type, c.role) : 0;
    team.sort((a, b) {
      final r = rel(b).compareTo(rel(a));
      if (r != 0) return r;
      final w = pay(b).compareTo(pay(a));
      return w != 0 ? w : sim.tenure(b).compareTo(sim.tenure(a));
    });
    var bill = 0.0, lo = double.infinity, hi = 0.0, ten = 0.0;
    for (final c in team) {
      bill += pay(c);
      lo = math.min(lo, pay(c));
      hi = math.max(hi, pay(c));
      ten += sim.tenure(c);
    }
    return Section('Employés (${team.length})', [
      if (!jobs) ...[
        Text(
            'Salaire unique : tous les employés reçoivent le salaire de l’entreprise. Le module « rôles, contrats et '
            'négociation » donne à chacun un rôle de l’organigramme et un salaire négocié.',
            style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
        SwitchListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(Modules.labels['jobs']!, style: const TextStyle(fontSize: 13)),
          subtitle: const Text('Prend effet au prochain jour : chacun garde son salaire et reçoit un rôle.',
              style: TextStyle(fontSize: 11)),
          value: false,
          onChanged: (v) {
            sim.modules.jobs = v;
            ctrl.touch();
          },
        ),
      ],
      if (team.isNotEmpty) ...[
        KV('Masse salariale / jour', money0(bill)),
        KV('Salaire le plus bas – le plus haut', '${money0(lo)} – ${money0(hi)}'),
        KV('Ancienneté moyenne', tenureLabel((ten / team.length).round())),
        const SizedBox(height: 6),
        Row(children: [
          Expanded(child: Text(jobs ? 'Nom · rôle · qualification' : 'Nom · qualification',
              style: TextStyle(color: pal.ink3, fontSize: 10.5, fontWeight: FontWeight.w700))),
          Text('salaire · ancienneté', style: TextStyle(color: pal.ink3, fontSize: 10.5, fontWeight: FontWeight.w700)),
        ]),
        Divider(height: 8, color: pal.rule2),
      ] else
        Text('Aucun employé.', style: TextStyle(color: pal.ink3, fontSize: 12)),
      for (final c in team.take(_shown))
        InkWell(
          onTap: () => ctrl.select(Selection('citizen', c.id)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(c.name, style: TextStyle(color: pal.ink, fontSize: 13, fontWeight: FontWeight.w600)),
                  Text(
                      [
                        if (jobs && c.role >= 0 && c.role < rs.length) rs[c.role].label,
                        '${classLabels[c.level].toLowerCase()} ${fmtNum(c.skill, 2)}',
                      ].join(' · '),
                      style: TextStyle(color: pal.ink3, fontSize: 11)),
                ]),
              ),
              const SizedBox(width: 8),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(money0(pay(c)), style: mono(pal.ink, 12.5, weight: FontWeight.w600)),
                Text(tenureLabel(sim.tenure(c)), style: mono(pal.ink3, 11)),
              ]),
            ]),
          ),
        ),
      if (team.length > _shown)
        Text('… et ${team.length - _shown} autres', style: TextStyle(color: pal.ink3, fontSize: 12)),
    ]);
  }
}

/// Organigramme : chaque rôle, sa qualification, ses effectifs (actuels et visés) et le salaire offert aujourd'hui.
Widget _orgChart(BuildContext context, SimController ctrl, Firm f) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final rs = roles[f.type]!;
  final counts = sim.roleCounts(f);
  final target = List<int>.filled(rs.length, 0);
  for (final r in seatOrder(f.type, f.workers.length + f.vacancies)) {
    target[r]++;
  }
  final next = f.vacancies > 0 ? sim.nextRole(f) : -1;
  return Section('Organigramme', [
    Text(
        'Le salaire offert pour un rôle est le salaire affiché de l’entreprise ajusté à la classe et aux '
        'responsabilités du rôle. Les postes d’encadrement se pourvoient par promotion interne.',
        style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
    const SizedBox(height: 6),
    for (var i = 0; i < rs.length; i++)
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('${rs[i].label}${i == next ? '  · poste ouvert' : ''}',
                  style: TextStyle(color: i == next ? pal.accent : pal.ink, fontSize: 12.5, fontWeight: FontWeight.w600)),
              Text(roleRequirement(rs[i]), style: TextStyle(color: pal.ink3, fontSize: 11)),
            ]),
          ),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(money0(sim.roleOffer(f, i)), style: mono(pal.ink, 12.5, weight: FontWeight.w600)),
            Text('${counts[i]} / ${target[i]}',
                style: mono(counts[i] < target[i] ? pal.warn : pal.ink3, 11)),
          ]),
        ]),
      ),
  ]);
}

const Map<String, String> _talkVerbs = {
  'embauche': 'embauche',
  'refus': 'refuse',
  'contre_offre': 'retenu par contre-offre',
  'depart': 'part chez un concurrent',
  'promotion': 'promotion',
  'revision': 'renouvellement à la hausse',
  'baisse': 'renouvellement à la baisse',
};

/// Dernières négociations : qui, quel rôle, le salaire convenu, le salaire de réserve et le plafond de l'employeur.
Widget _talksSection(BuildContext context, SimController ctrl, Firm f) {
  final pal = Pal.of(context);
  final rs = roles[f.type]!;
  return Section('Négociations récentes', [
    for (final t in f.talks.reversed)
      InkWell(
        onTap: ctrl.sim.citizen(t.citizen) == null ? null : () => ctrl.select(Selection('citizen', t.citizen)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('j${t.day} · ${t.name} · ${_talkVerbs[t.kind]}${t.role >= 0 && t.role < rs.length ? ' · ${rs[t.role].label}' : ''}',
                style: TextStyle(
                    color: t.kind == 'refus' || t.kind == 'depart' || t.kind == 'baisse' ? pal.warn : pal.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
            Text(_talkDetail(t), style: mono(pal.ink3, 11)),
          ]),
        ),
      ),
  ]);
}

String _talkDetail(Talk t) {
  switch (t.kind) {
    case 'refus':
      return 'demande ${money0(t.reservation)} > plafond ${money0(t.cap)} (offre ${money0(t.offer)})';
    case 'promotion':
      return 'nouveau salaire ${money0(t.wage)} (offre du rôle ${money0(t.offer)})';
    case 'revision':
    case 'baisse':
      return '${money0(t.reservation)} → ${money0(t.wage)} (offre du rôle ${money0(t.offer)}, ancienneté comprise)';
    case 'contre_offre':
      return 'offre concurrente ${money0(t.wage)} égalée (plafond ${money0(t.cap)}, avant ${money0(t.offer)})';
    case 'depart':
      return 'offre concurrente ${money0(t.wage)} > ce que l’employeur peut égaler ${money0(t.cap)} '
          '(salaire ${money0(t.offer)})';
    default:
      return '${money0(t.wage)} (réserve ${money0(t.reservation)}, offre ${money0(t.offer)}, plafond ${money0(t.cap)})';
  }
}

class _Lock extends StatelessWidget {
  final String label;
  final bool value;
  final void Function(bool) onChanged;
  const _Lock(this.label, this.value, this.onChanged);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text(label, style: TextStyle(color: pal.ink3, fontSize: 10)),
      Switch(value: value, onChanged: onChanged),
    ]);
  }
}

class _FirmMoney extends StatefulWidget {
  final SimController ctrl;
  final Firm f;
  const _FirmMoney(this.ctrl, this.f);
  @override
  State<_FirmMoney> createState() => _FirmMoneyState();
}

class _FirmMoneyState extends State<_FirmMoney> {
  double amount = 5000;
  double goodQty = 20;
  String good = '';

  @override
  Widget build(BuildContext context) {
    final f = widget.f;
    final sim = widget.ctrl.sim;
    final list = [...f.outputs.keys, ...f.inputs.keys];
    if (!list.contains(good)) good = list.first;
    return Section('Intervention directe', [
      Row(children: [
        Expanded(
            child: NumField(
                label: 'Montant', value: amount, suffix: '\$', decimals: 0, onSubmit: (v) => setState(() => amount = v.abs()))),
        const SizedBox(width: 8),
        Btn('Donner', () {
          sim.godMoney(Target('firm', f.id), amount);
          widget.ctrl.touch();
        }, primary: true),
        const SizedBox(width: 6),
        Btn('Retirer', () {
          sim.godMoney(Target('firm', f.id), -amount);
          widget.ctrl.touch();
        }),
      ]),
      const SizedBox(height: 8),
      Row(children: [
        DropdownButton<String>(
          value: good,
          items: [for (final g in list) DropdownMenuItem(value: g, child: Text(goods[g]!.label))],
          onChanged: (v) => setState(() => good = v ?? good),
        ),
        const SizedBox(width: 8),
        Expanded(
            child: NumField(
                label: 'Quantité', value: goodQty, decimals: 0, onSubmit: (v) => setState(() => goodQty = v.abs()))),
        const SizedBox(width: 8),
        Btn('+', () {
          sim.godGoods(f.id, good, goodQty);
          widget.ctrl.touch();
        }, primary: true),
        const SizedBox(width: 6),
        Btn('−', () {
          sim.godGoods(f.id, good, -goodQty);
          widget.ctrl.touch();
        }),
      ]),
    ]);
  }
}

// ------------------------------------------------------------------ ménages

class _HomesView extends StatelessWidget {
  final SimController ctrl;
  const _HomesView(this.ctrl);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final cs = sim.citizens;
    final n = cs.length;
    final unemployed = cs.where((c) => c.employer == null).length;
    final hungry = cs.where((c) => c.hungerDays >= 1).length;
    final homeless = cs.where((c) => c.homeless).length;
    var total = 0.0;
    for (final c in cs) {
      total += c.money;
    }
    final sorted = List<Citizen>.from(cs)..sort((a, b) => b.money.compareTo(a.money));
    final max = n == 0 ? 0.0 : sorted.first.money;
    final h = sim.history;
    final last = h.isEmpty ? null : h.last;
    final median = sim.medianWealth();

    // histogramme de richesse : 8 tranches linéaires de 0 à max
    const bins = 8;
    final counts = List<double>.filled(bins, 0);
    final labels = <String>[];
    final top = max <= 0 ? 1.0 : max;
    for (final c in cs) {
      final idx = ((c.money <= 0 ? 0.0 : c.money) / top * bins).floor().clamp(0, bins - 1).toInt();
      counts[idx] += 1;
    }
    for (var i = 0; i < bins; i++) {
      labels.add(kmoney(top * (i + 1) / bins).replaceAll(' ', ''));
    }
    final desireColors = {
      'faim': pal.warn,
      'logement': pal.transfo,
      'sante': pal.bad,
      'divertissement': pal.conso,
      'luxe': pal.primaire,
    };

    return ListView(padding: const EdgeInsets.all(12), children: [
      _title(context, 'Ménages'),
      const SizedBox(height: 10),
      Section('Population', [
        KV('Citoyens', '$n'),
        KV('Sans emploi', '$unemployed  (${pct(n > 0 ? unemployed / n : 0.0)})'),
        KV('Affamés', '$hungry', color: hungry > 0 ? pal.bad : null),
        KV('Sans logis', '$homeless', color: homeless > 0 ? pal.bad : null),
        if (last != null) KV('Bonheur moyen', pct(last.happiness)),
        KV('Richesse totale', money0(total)),
        KV('Médiane', '${money0(median)}  (${fmtNum(sim.needCost > 0 ? median / sim.needCost : 0, 0)} j de besoins)'),
        KV('Gini', fmtNum(sim.gini(), 3)),
        KV('Panier de survie', '${money(sim.needCost)} / jour'),
      ]),
      if (sim.modules.jobs) _labourSection(context, sim),
      if (last != null)
        Section('Qualifications et désirs', [
          for (var i = 0; i < 3; i++) KV(classLabels[i], '${last.classes[i]}'),
          const SizedBox(height: 6),
          for (final d in desires) KV('Satisfaction · ${desireLabels[d]}', pct(last.sat[d] ?? 0.0)),
        ]),
      HistogramCard(title: 'Répartition de la richesse (nb de citoyens)', values: counts, labels: labels, color: pal.accent),
      if (h.length > 2)
        ChartCard(
          title: 'Satisfaction moyenne',
          unit: '%',
          minY: 0,
          series: [
            for (final d in desires)
              Series(desireLabels[d]!, desireColors[d]!, downsample(h.map((p) => p.sat[d] ?? 0.0).toList())),
          ],
        ),
      Section('Citoyens (les plus riches d’abord)', [
        for (final c in sorted.take(40))
          InkWell(
            onTap: () => ctrl.select(Selection('citizen', c.id)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(children: [
                Expanded(child: Text(c.name, style: TextStyle(color: pal.ink, fontSize: 13))),
                Text('${classLabels[c.level]}  ', style: TextStyle(color: pal.ink3, fontSize: 11)),
                if (c.employer == null) Text('chômeur  ', style: TextStyle(color: pal.warn, fontSize: 11)),
                Text(money0(c.money), style: mono(pal.ink2, 12)),
              ]),
            ),
          ),
        if (n > 40) Text('… et ${n - 40} autres', style: TextStyle(color: pal.ink3, fontSize: 12)),
      ]),
      const SizedBox(height: 24),
    ]);
  }
}

/// Marché du travail du module jobs : négociations du jour et depuis le début, salaires par classe.
Widget _labourSection(BuildContext context, Sim sim) {
  final pal = Pal.of(context);
  final l = sim.labour;
  final hires = l.total['embauche']!;
  final byClass = [<double>[], <double>[], <double>[]];
  final unemployed = [0, 0, 0];
  for (final c in sim.citizens) {
    if (c.employer == null) {
      unemployed[c.level]++;
    } else {
      byClass[c.level].add(c.wage);
    }
  }
  String median(List<double> v) {
    if (v.isEmpty) return '—';
    v.sort();
    return money0(v[v.length ~/ 2]);
  }

  return Section('Marché du travail', [
    Row(children: [
      Expanded(child: Text('', style: TextStyle(color: pal.ink3, fontSize: 10.5))),
      SizedBox(width: 70, child: Text('aujourd’hui', textAlign: TextAlign.right, style: TextStyle(color: pal.ink3, fontSize: 10.5))),
      SizedBox(width: 70, child: Text('total', textAlign: TextAlign.right, style: TextStyle(color: pal.ink3, fontSize: 10.5))),
    ]),
    for (final k in LabourStats.kinds)
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(children: [
          Expanded(child: Text(LabourStats.labels[k]!, style: TextStyle(color: pal.ink2, fontSize: 12.5))),
          SizedBox(width: 70, child: Text('${l.today[k]}', textAlign: TextAlign.right, style: mono(pal.ink, 12.5))),
          SizedBox(width: 70, child: Text('${l.total[k]}', textAlign: TextAlign.right, style: mono(pal.ink2, 12.5))),
        ]),
      ),
    const SizedBox(height: 4),
    KV('Écart moyen du salaire convenu sur l’offre', hires > 0 ? pct(l.premium / hires) : '—'),
    const SizedBox(height: 4),
    for (var i = 0; i < 3; i++)
      KV('${classLabels[i]} : salaire médian · sans emploi', '${median(byClass[i])} · ${unemployed[i]}'),
  ]);
}

class _CitizenView extends StatefulWidget {
  final SimController ctrl;
  final Citizen c;
  const _CitizenView(this.ctrl, this.c);
  @override
  State<_CitizenView> createState() => _CitizenViewState();
}

class _CitizenViewState extends State<_CitizenView> {
  double amount = 1000;

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final c = widget.c;
    final sim = widget.ctrl.sim;
    final job = c.employer != null ? sim.firm(c.employer!) : null;
    final role = sim.roleOf(c);
    final owned = sim.firms.where((f) => f.ownerId == c.id).toList();
    final home = c.homeId != null ? sim.building(c.homeId!) : null;
    final aids = (sim.nets.byAgent['famine']?[c.name] ?? 0) + (sim.nets.byAgent['shelter']?[c.name] ?? 0);
    return ListView(padding: const EdgeInsets.all(12), children: [
      _title(context, c.name),
      const SizedBox(height: 10),
      Section('Citoyen', [
        KV('Argent', money0(c.money)),
        KV('Revenu hier', money(c.income)),
        KV('Dépenses hier', money(c.spend)),
        KV('Qualification', '${classLabels[c.level]} (${fmtNum(c.skill, 2)})'),
        KV('Ambition (envie de se former)', pct(c.ambition)),
        if (sim.modules.entrepreneurship) ..._founderTraits(context, widget.ctrl, c),
        KV('Bonheur', pct(c.happiness)),
        KV('Jours de faim', '${c.hungerDays}', color: c.hungerDays > 0 ? pal.bad : null),
        KV('Logement', c.homeless ? 'sans logis (${c.homelessDays} j)' : 'logé', color: c.homeless ? pal.bad : null),
        if (sim.modules.buildings && home != null)
          Row(children: [
            Text('Propriétaire de son logement', style: TextStyle(color: pal.ink2, fontSize: 12.5)),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () => widget.ctrl.select(Selection('building', home.id)),
                    child: Text('n° ${home.id}${home.listedDay != null ? ' · en vente' : ''}', overflow: TextOverflow.ellipsis)),
              ),
            ),
          ]),
        if (sim.modules.buildings && home == null) KV('Statut', c.wantsToOwn ? 'locataire, voudrait acheter' : 'locataire'),
        KV('Ordinateur', c.computerDays > 0 ? 'oui (${c.computerDays} j)' : 'non'),
        if (aids > 0) KV('Aides d’urgence reçues (filets)', '$aids', color: pal.warn),
        if (job == null) KV('Emploi', 'sans emploi (${c.daysUnemployed} j)', color: pal.warn),
        if (job != null)
          Row(children: [
            Text('Employeur', style: TextStyle(color: pal.ink2, fontSize: 12.5)),
            const Spacer(),
            Flexible(
              child: TextButton(
                  onPressed: () => widget.ctrl.select(Selection('firm', job.id)),
                  child: Text('${job.name} · ${money0(sim.modules.jobs ? c.wage : job.wage)}', overflow: TextOverflow.ellipsis)),
            ),
          ]),
        if (job != null && role != null) ...[
          KV('Rôle', role.label),
          KV('Qualification du rôle', roleRequirement(role)),
          KV('Salaire du contrat', '${money0(c.wage)} / jour'),
          KV('Offre actuelle pour ce rôle', money0(sim.roleOffer(job, c.role))),
        ],
        if (job != null) KV('Ancienneté', tenureLabel(sim.tenure(c))),
        if (job != null && sim.modules.jobs && sim.params.reviewDays > 0)
          KV('Prochaine révision salariale',
              'dans ${sim.params.reviewDays - sim.tenure(c) % sim.params.reviewDays} j'),
        if (sim.modules.jobs) ...[
          KV(job == null ? 'Salaire de réserve' : 'Salaire pour changer d’emploi', money0(sim.reservationWage(c))),
          if (job == null && c.wage > 0) KV('Dernier salaire', money0(c.wage)),
          KV('Aplomb en négociation', pct(c.aplomb)),
        ],
        for (final f in owned)
          Row(children: [
            Expanded(child: Text('Propriétaire de', style: TextStyle(color: pal.ink2, fontSize: 12.5))),
            TextButton(onPressed: () => widget.ctrl.select(Selection('firm', f.id)), child: Text(f.name)),
          ]),
      ]),
      if (sim.modules.products) _citizenVarieties(context, widget.ctrl, c),
      if (sim.modules.banking || sim.consumerLent > 0) _citizenCreditSection(context, widget.ctrl, c),
      Section('Satisfaction des désirs', [
        for (final d in desires) _Bar(desireLabels[d]!, c.sat[d] ?? 0.0),
      ]),
      Section('Intervention directe', [
        Row(children: [
          Expanded(
              child: NumField(
                  label: 'Montant', value: amount, suffix: '\$', decimals: 0, onSubmit: (v) => setState(() => amount = v.abs()))),
          const SizedBox(width: 8),
          Btn('Donner', () {
            sim.godMoney(Target('citizen', c.id), amount);
            widget.ctrl.touch();
          }, primary: true),
          const SizedBox(width: 6),
          Btn('Retirer', () {
            sim.godMoney(Target('citizen', c.id), -amount);
            widget.ctrl.touch();
          }),
        ]),
        const SizedBox(height: 8),
        if (c.skill < 3)
          Btn('Former (classe suivante)', () {
            sim.godTrain(c.id);
            widget.ctrl.touch();
          }, icon: Icons.school_outlined),
      ]),
      const SizedBox(height: 24),
    ]);
  }
}

/// Barre de satisfaction de 0 à 100 %.
class _Bar extends StatelessWidget {
  final String label;
  final double value;
  const _Bar(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final v = value.clamp(0.0, 1.0).toDouble();
    final col = v < 0.4 ? pal.bad : (v < 0.75 ? pal.warn : pal.ok);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(children: [
        SizedBox(width: 110, child: Text(label, style: TextStyle(color: pal.ink2, fontSize: 12.5))),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: v, minHeight: 8, color: col, backgroundColor: pal.rule2),
          ),
        ),
        SizedBox(width: 50, child: Text(pct(v), textAlign: TextAlign.right, style: mono(pal.ink2, 11))),
      ]),
    );
  }
}

/// Établissement public (institution I2) : financé par une enveloppe de l'État, il sert une file d'attente.
Widget _publicSection(BuildContext context, SimController ctrl, Firm f) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final g = f.outputs.keys.firstWhere(sim.publicGood);
  final st = sim.services[g]!;
  final who = g == 'soins' ? 'patient(s)' : 'élève(s)';
  return Section('Établissement public', [
    const KV('Financement', 'enveloppe de l’État ; service gratuit'),
    KV('Enveloppe aujourd’hui', money0(st.envelopeToday)),
    if (st.wantedToday > st.envelopeToday + 1) KV('Enveloppe voulue', money0(st.wantedToday), color: pal.warn),
    KV('File d’attente', '${st.queue} $who'),
    KV('Attente moyenne', '${fmtNum(st.wait, 1)} j', color: st.wait > sim.monitor.cfg.waitLong ? pal.bad : null),
    KV('Servis aujourd’hui', '${st.servedToday}'),
    if (st.shortDays > 0) KV('Jours d’enveloppe incomplète', '${st.shortDays}', color: pal.warn),
  ]);
}

// ------------------------------------------------------------------ État, Caisse, extérieur

class _StateView extends StatelessWidget {
  final SimController ctrl;
  const _StateView(this.ctrl);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final p = sim.params;
    final m = sim.modules;
    final st = sim.state;
    final h = sim.history;
    return ListView(padding: const EdgeInsets.all(12), children: [
      _title(context, 'État'),
      const SizedBox(height: 10),
      Section('Finances publiques', [
        KV('Trésor', money0(st.money)),
        KV('Impôts perçus (total)', money0(st.taxes)),
        KV('Versements (total)', money0(st.paid)),
        KV('dont soins payés', money0(st.healthPaid)),
        KV('dont cours payés', money0(st.educationPaid)),
        KV('Impôts aujourd’hui', money0(st.taxesToday)),
        KV('Versements aujourd’hui', money0(st.paidToday)),
      ]),
      if (m.insurance)
        Section('Assurance-emploi et aide sociale', [
          KV('Cotisations perçues (total)', money0(st.eiPremiums)),
          KV('Prestations versées (total)', money0(st.eiPaid)),
          KV('Solde du compte (cotisations − prestations)', money0(st.eiPremiums - st.eiPaid),
              color: st.eiPremiums < st.eiPaid ? pal.warn : null),
          KV('Aide sociale versée (total)', money0(st.assistPaid)),
          KV('Prestataires aujourd’hui', '${st.eiClaimants}'),
          KV('Aide sociale aujourd’hui', '${st.assistRecipients} personne(s) · ${money0(sim.needCost)} chacune'),
          KV('Part des prestations versée', pct(st.benefitCut), color: st.benefitCut < 1 ? pal.bad : null),
        ]),
      if (sim.publicGood('soins') || sim.publicGood('cours'))
        Section('Services publics gratuits', [
          for (final g in const ['soins', 'cours'])
            if (sim.publicGood(g)) ...[
              KV('${g == 'soins' ? 'Hôpital' : 'École'} : enveloppe du jour', money0(sim.services[g]!.envelopeToday)),
              KV('${g == 'soins' ? 'Hôpital' : 'École'} : file d’attente',
                  '${sim.services[g]!.queue} · attente ${fmtNum(sim.services[g]!.wait, 1)} j',
                  color: sim.services[g]!.wait > sim.monitor.cfg.waitLong ? pal.bad : null),
            ],
        ]),
      Section('Politique', [
        ParamSlider(
            label: 'Taux d’impôt (salaires, dividendes)',
            value: p.taxRate,
            min: 0,
            max: 0.6,
            format: (v) => pct(v),
            onChanged: (v) {
              p.taxRate = v;
              ctrl.touch();
            }),
        if (!m.insurance)
          ParamSlider(
            label: 'Prestation de chômage / jour',
            value: p.benefit,
            min: 0,
            max: 300,
            format: money0,
            onChanged: (v) {
              p.benefit = v.roundToDouble();
              ctrl.touch();
            }),
        ParamSlider(
            label: 'Redistribution du trésor (par jour)',
            value: p.stateRebate,
            min: 0,
            max: 0.3,
            format: pct,
            hint: 'Part du trésor redistribuée aux ménages chaque jour.',
            onChanged: (v) {
              p.stateRebate = v;
              ctrl.touch();
            }),
        ParamSlider(
            label: 'Salaire minimum',
            value: p.minWage,
            min: 0,
            max: 400,
            format: money0,
            onChanged: (v) {
              p.minWage = v.roundToDouble();
              ctrl.touch();
            }),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Santé publique'),
          subtitle: Text(m.publicBudget
              ? 'Soins gratuits : l’hôpital reçoit une enveloppe de l’État et sert une file d’attente.'
              : 'L’État paie les soins tant que le trésor le permet.'),
          value: m.publicHealth,
          onChanged: (v) {
            m.publicHealth = v;
            ctrl.touch();
          },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Éducation publique'),
          subtitle: Text(m.publicBudget
              ? 'Cours gratuits : l’école reçoit une enveloppe de l’État et sert une file d’attente.'
              : 'L’État paie les cours tant que le trésor le permet.'),
          value: m.publicEducation,
          onChanged: (v) {
            m.publicEducation = v;
            ctrl.touch();
          },
        ),
      ]),
      if (h.length > 2)
        ChartCard(
          title: 'Où est l’argent',
          stacked: true,
          unit: '\$',
          series: [
            Series('ménages', pal.accent, downsample(h.map((p) => p.mH).toList())),
            Series('entreprises', pal.primaire, downsample(h.map((p) => p.mF).toList())),
            Series('État', pal.conso, downsample(h.map((p) => p.mE).toList())),
            Series('Caisse', pal.money, downsample(h.map((p) => p.mB).toList())),
          ],
        ),
      const SizedBox(height: 24),
    ]);
  }
}

class _BankView extends StatelessWidget {
  final SimController ctrl;
  const _BankView(this.ctrl);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final b = sim.bank;
    final p = sim.params;
    final loans = sim.totalDebt();
    final dep = sim.deposits();
    final ratio = loans > 0 ? b.equity / loans : double.nan;
    final debtors = sim.firms.where((f) => f.debt > 0).toList()..sort((a, c) => c.debt.compareTo(a.debt));
    final h = sim.history;
    return ListView(padding: const EdgeInsets.all(12), children: [
      _title(context, 'Caisse populaire'),
      const SizedBox(height: 4),
      Text(
          'Elle prête aux entreprises pour acheter des machines : chaque prêt crée de la monnaie, '
          'chaque remboursement de capital en détruit. Au-delà d’une réserve, ses intérêts sont ristournés aux citoyens.',
          style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
      const SizedBox(height: 10),
      Section('Bilan', [
        KV('Réserves (monnaie extérieure)', money0(b.reserves)),
        KV('+ Prêts en cours', money0(loans)),
        KV('= Dépôts du public', money0(dep)),
        KV('+ Fonds propres', money0(b.equity), color: b.equity < 0 ? pal.bad : null),
        KV('dont capital de départ (parts sociales)', money0(b.capital)),
        KV('Fonds propres visés', money0(math.max(b.capital, p.bankTargetRatio * loans))),
        KV('Écart du bilan', sim.inv.bank == 0 ? '0 (exact)' : sim.inv.bank.toStringAsExponential(2),
            color: sim.inv.bank == 0 ? pal.ok : pal.bad),
        KV('Ratio fonds propres / prêts', ratio.isNaN ? '—' : pct(ratio),
            color: !ratio.isNaN && ratio < sim.safeguards.minCapitalRatio ? pal.bad : null),
      ]),
      Section('Activité (depuis le début)', [
        KV('Prêté', money0(b.lent)),
        KV('Capital remboursé (monnaie détruite)', money0(b.repaid)),
        KV('Intérêts encaissés', money0(b.interest)),
        KV('Intérêts impayés capitalisés', money0(b.capitalized)),
        KV('Créances radiées', money0(b.writtenOff), color: b.writtenOff > 0 ? pal.warn : null),
        KV('Ristournes versées', money0(b.rebates)),
        KV('Prêts refusés (règles prudentielles)', '${b.refusals}'),
        KV('Encaisse de la Caisse', money0(b.money)),
      ]),
      Section('Politique de crédit', [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('La Caisse prête'),
          value: sim.modules.credit,
          onChanged: (v) {
            sim.modules.credit = v;
            ctrl.touch();
          },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Règles prudentielles'),
          subtitle: Text('Fonds propres d’au moins ${pct(sim.safeguards.minCapitalRatio)} des prêts ; paiements d’un '
              'emprunteur au plus ${pct(sim.safeguards.maxPaymentRatio)} de sa valeur ajoutée.'),
          value: sim.modules.bankRegulation,
          onChanged: (v) {
            sim.modules.bankRegulation = v;
            ctrl.touch();
          },
        ),
        ParamSlider(
            label: 'Taux d’intérêt annuel',
            value: p.interestRate,
            min: 0,
            max: 0.3,
            format: pct,
            hint: 'Un jour de jeu = un jour : à ces taux, les intérêts quotidiens sont faibles.',
            onChanged: (v) {
              p.interestRate = v;
              ctrl.touch();
            }),
        ParamSlider(
            label: 'Prime de risque (à pleine garantie)',
            value: p.riskSpread,
            min: 0,
            max: 0.2,
            format: pct,
            hint: 'Ajoutée au taux de base en proportion de la dette rapportée à la valeur des machines.',
            onChanged: (v) {
              p.riskSpread = v;
              ctrl.touch();
            }),
        ParamSlider(
            label: 'Fonds propres visés (part des prêts)',
            value: p.bankTargetRatio,
            min: 0,
            max: 0.5,
            format: pct,
            hint: 'La Caisse retient ses bénéfices jusqu’à cette part de l’encours avant toute ristourne.',
            onChanged: (v) {
              p.bankTargetRatio = v;
              ctrl.touch();
            }),
        ParamSlider(
            label: 'Ristourne du surplus (par jour)',
            value: p.bankRebate,
            min: 0,
            max: 0.2,
            format: pct,
            onChanged: (v) {
              p.bankRebate = v;
              ctrl.touch();
            }),
      ]),
      if (h.length > 2)
        ChartCard(title: 'Dette des entreprises et crédit net', unit: '\$', minY: 0, series: [
          Series('dette', pal.bad, downsample(h.map((x) => x.debt).toList())),
          Series('crédit net', pal.money, downsample(h.map((x) => x.credit).toList())),
        ]),
      if (debtors.isNotEmpty)
        Section('Emprunteurs', [
          for (final f in debtors.take(15))
            InkWell(
              onTap: () => ctrl.select(Selection('firm', f.id)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(children: [
                  Expanded(child: Text(f.name, style: TextStyle(color: pal.ink, fontSize: 13))),
                  if (f.missedPayments > 0)
                    Text('${f.missedPayments} j de retard  ', style: TextStyle(color: pal.bad, fontSize: 11)),
                  Text(money0(f.debt), style: mono(pal.ink2, 12)),
                ]),
              ),
            ),
        ]),
      const SizedBox(height: 24),
    ]);
  }
}

class _WorldView extends StatelessWidget {
  final SimController ctrl;
  const _WorldView(this.ctrl);

  @override
  Widget build(BuildContext context) {
    final sim = ctrl.sim;
    final p = sim.params;
    return ListView(padding: const EdgeInsets.all(12), children: [
      _title(context, 'Extérieur'),
      const SizedBox(height: 10),
      Section('Commerce', [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Frontières ouvertes'),
          subtitle:
              const Text('Importer et exporter aux prix mondiaux (les biens périssables et les services ne voyagent pas).'),
          value: p.trade,
          onChanged: (v) {
            sim.setTrade(v);
            ctrl.touch();
          },
        ),
        ParamSlider(
            label: 'Majoration à l’import',
            value: p.importMarkup,
            min: 1,
            max: 3,
            format: (v) => '×${fmtNum(v, 2)}',
            onChanged: (v) {
              p.importMarkup = v;
              ctrl.touch();
            }),
        ParamSlider(
            label: 'Prix à l’export (part du prix mondial)',
            value: p.exportDiscount,
            min: 0.2,
            max: 1,
            format: pct,
            onChanged: (v) {
              p.exportDiscount = v;
              ctrl.touch();
            }),
        KV('Importé (total)', money0(sim.ledgerImports)),
        KV('Exporté (total)', money0(sim.ledgerExports)),
      ]),
      Section('Prix mondiaux', [
        for (final e in goods.entries) KV(e.value.label, '${money(sim.worldPrice[e.key] ?? 0.0)} / ${e.value.unit}'),
      ]),
      const SizedBox(height: 24),
    ]);
  }
}


/// Fondation d'une entreprise : qui l'a fondée, quand, avec quel capital ; les compteurs de l'année.
Widget _foundingSection(BuildContext context, SimController ctrl, Firm f) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final founder = f.founderId != null ? sim.citizen(f.founderId!) : null;
  final year = sim.day ~/ 365;
  return Section('Fondation', [
    if (f.founderId == null)
      Text('Entreprise du départ de la partie : aucun fondateur.', style: TextStyle(color: pal.ink3, fontSize: 12))
    else ...[
      Row(children: [
        Expanded(child: Text('Fondateur', style: TextStyle(color: pal.ink2, fontSize: 12.5))),
        if (founder != null)
          TextButton(onPressed: () => ctrl.select(Selection('citizen', founder.id)), child: Text(founder.name))
        else
          Text('a quitté la région', style: TextStyle(color: pal.ink3, fontSize: 12.5)),
      ]),
      KV('Fondée le jour', '${f.foundedDay}  (il y a ${sim.day - f.foundedDay} j)'),
      KV('Capital de départ', money0(f.startCapital)),
      KV('Dette envers la Caisse', money0(f.debt), color: f.debt > 0 ? pal.warn : null),
    ],
    KV('Fondations · fermetures cette année', '${sim.foundedIn(year)} · ${sim.closedIn(year)}'),
  ]);
}

/// Traits d'entrepreneur d'un citoyen : désir de posséder, tolérance au risque, secteurs connus, et ce qui l'empêche de fonder.
List<Widget> _founderTraits(BuildContext context, SimController ctrl, Citizen c) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final blocker = sim.foundingBlocker(c);
  final sectors = sim.knownSectors(c);
  return [
    KV('Veut posséder', sim.wantsToFound(c) ? 'oui' : 'non'),
    KV('Tolérance au risque', pct(sim.riskTolerance(c))),
    KV('Peut fonder une entreprise', blocker == null ? 'oui, candidat' : 'non : $blocker',
        color: blocker == null ? pal.ok : null),
    if (sectors.isEmpty)
      const KV('Connaissance des secteurs', 'aucune')
    else
      for (final s in sectors.take(4)) KV('Connaît : ${templates[s.$1]?.label ?? s.$1}', '${s.$2} j · ${pct(s.$3)}'),
    if (sectors.length > 4) KV('… et d’autres secteurs', '${sectors.length - 4}'),
  ];
}


/// La variété d'une entreprise, sa catégorie (parts de marché), et pour une acheteuse de machines, ses modèles installés.
Widget _productSection(BuildContext context, SimController ctrl, Firm f) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final pr = sim.productOf(f);
  final buysMachines = f.template.capital > 0 && sim.modules.capital;
  if (pr == null && !buysMachines) return const SizedBox.shrink();
  final rivals = pr == null ? const <Product>[] : sim.varietiesOf(pr.category);
  return Section('Produit', [
    if (pr != null) ...[
      KV('Variété', '« ${pr.name} »'),
      KV('Catégorie', goods[pr.category]!.label),
      KV('Qualité', '${fmtNum(pr.quality * 100, 0)} %  (productivité ×${fmtNum(sim.qualityRate(f), 2)})'),
      KV('Lancée le jour', '${pr.launched}'),
      KV('Part de marché', pct(sim.marketShare(pr))),
      if (equipmentVarieties.contains(pr.category)) ...[
        KV('Gain de productivité du modèle', '×${fmtNum(pr.gain, 2)}'),
        KV('Durabilité', '×${fmtNum(pr.durability, 2)}'),
      ],
      const SizedBox(height: 4),
      Text('Variétés de la catégorie (${rivals.length}) : part · prix · qualité',
          style: TextStyle(color: pal.ink3, fontSize: 10.5, fontWeight: FontWeight.w700)),
      for (final r in rivals)
        InkWell(
          onTap: () => ctrl.select(Selection('firm', r.firmId)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(children: [
              Expanded(
                  child: Text('« ${r.name} »', overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: identical(r, pr) ? pal.accent : pal.ink2, fontSize: 11.5))),
              Text('${pct(sim.marketShare(r))} · ${money(sim.firm(r.firmId)?.price[r.category] ?? 0)} · '
                  '${fmtNum(r.quality * 100, 0)} %', style: mono(pal.ink, 11)),
            ]),
          ),
        ),
    ],
    if (buysMachines) ...[
      const SizedBox(height: 6),
      KV('Machines installées : gain moyen', f.machineGain > 0 ? '×${fmtNum(f.machineGain, 2)}' : 'modèle standard'),
      KV('Durabilité moyenne', f.machineLife > 0 ? '×${fmtNum(f.machineLife, 2)}' : 'standard'),
      KV('Fournisseur habituel', f.supplier != null ? '« ${sim.products[f.supplier!]?.name ?? '?'} »' : 'aucun'),
      KV('Fabricants connus', f.knownMakers.isEmpty
          ? 'aucun'
          : [for (final id in f.knownMakers) sim.products[id]?.maker ?? '?'].join(', ')),
    ],
  ]);
}

/// Variétés qu'un citoyen connaît, par catégorie ; celle qu'il achète d'habitude est marquée.
Widget _citizenVarieties(BuildContext context, SimController ctrl, Citizen c) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final known = sim.knownVarieties(c);
  return Section('Variétés connues', [
    if (known.isEmpty)
      Text('Aucune pour l’instant.', style: TextStyle(color: pal.ink3, fontSize: 12))
    else
      for (final e in known.entries) ...[
        Text(goods[e.key]!.label, style: TextStyle(color: pal.ink3, fontSize: 10.5, fontWeight: FontWeight.w700)),
        for (final (pr, d) in e.value)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.5),
            child: Row(children: [
              Expanded(
                  child: Text('${c.lastChoice[e.key] == pr.id ? '★ ' : ''}« ${pr.name} »', overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: c.lastChoice[e.key] == pr.id ? pal.accent : pal.ink2, fontSize: 11.5))),
              Text('goût ${sim.tasteOf(c, pr.id) >= 0 ? '+' : ''}${fmtNum(sim.tasteOf(c, pr.id), 2)} · vue j$d',
                  style: mono(pal.ink3, 10.5)),
            ]),
          ),
      ],
    KV('Sensibilité au prix', '×${fmtNum(sim.priceSensitivity(c), 2)}'),
    Text('★ : la variété qu’il achète d’habitude.', style: TextStyle(color: pal.ink3, fontSize: 10.5)),
  ]);
}


/// Crédit d'un citoyen : banque, cote, carte, prêts, retards, faillites.
Widget _citizenCreditSection(BuildContext context, SimController ctrl, Citizen c) {
  final pal = Pal.of(context);
  final sim = ctrl.sim;
  final blocker = sim.creditBlocker(c);
  return Section('Crédit', [
    KV('Banque', sim.bankName(c.bankId)),
    KV('Cote de crédit', '${sim.creditScore(c)} / 900'),
    KV('Accès au crédit', blocker == null ? 'ouvert' : 'fermé : $blocker', color: blocker == null ? pal.ok : pal.warn),
    KV('Carte : solde · limite', c.cardLimit > 0 ? '${money0(c.card)} · ${money0(c.cardLimit)}' : 'pas de carte'),
    if (c.cardLimit > 0) KV('Taux de la carte', pct(sim.cardRateOf(c))),
    for (final l in c.loans)
      KV('Prêt (${l.reason})', '${money0(l.balance)} · ${money0(l.payment)}/mois · ${pct(l.rate)}'),
    KV('Service de la dette par mois', money0(sim.monthlyDebtService(c))),
    if (c.arrears > 0) KV('En retard', '${money0(c.arrears)} depuis le jour ${c.arrearsSince}', color: pal.bad),
    if (c.latePayments > 0) KV('Retards récents', '${c.latePayments}', color: pal.warn),
    if (c.bankruptcies > 0)
      KV('Faillites', '${c.bankruptcies} — dernière ${c.lastBankruptcy}', color: pal.bad),
  ]);
}

/// La banque d'une entreprise et sa dette.
Widget _firmBankSection(BuildContext context, SimController ctrl, Firm f) {
  final sim = ctrl.sim;
  return Section('Banque', [
    KV('Banque', sim.bankName(f.bankId)),
    KV('Dette', money0(f.debt)),
    if (f.workingDebt > 0) KV('dont fonds de roulement', money0(f.workingDebt)),
  ]);
}
