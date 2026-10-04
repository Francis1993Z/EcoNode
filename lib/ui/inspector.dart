// Onglet Inspecteur : détail de l'élément sélectionné dans le graphe.

import 'package:flutter/material.dart';

import '../engine/model.dart';
import 'charts.dart';
import 'controller.dart';
import 'format.dart';
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
      case 'E':
        return _StateView(ctrl);
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
  Widget build(BuildContext context) =>
      Padding(padding: const EdgeInsets.all(16), child: Text('Cet élément n’existe plus.', style: TextStyle(color: Pal.of(context).ink2)));
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

    return ListView(padding: const EdgeInsets.all(12), children: [
      Row(children: [
        Expanded(
            child: Text(f.name, style: TextStyle(color: pal.ink, fontSize: 17, fontWeight: FontWeight.w800))),
        Pill(tpl.label, pal.sector(tpl.sector)),
      ]),
      const SizedBox(height: 10),
      Section('Situation', [
        KV('Caisse', money0(f.money)),
        KV('Profit moyen / jour', '${profit >= 0 ? '+' : ''}${money0(profit)}', color: profit >= 0 ? pal.ok : pal.bad),
        KV('Employés', '${f.workers.length}  (postes ouverts : ${f.vacancies})'),
        KV('Salaire', money0(f.wage)),
        KV('Productivité', '×${fmtNum(f.prodMult, 2)}'),
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
      Section('Biens', [
        for (final g in [...f.outputs.keys, ...f.inputs.keys]) _goodBlock(context, g),
      ]),
      Section('Réglages divins', [
        Row(children: [
          Expanded(
              child: NumField(
                  label: 'Salaire',
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
      ]),
      _FirmMoney(ctrl, f),
      if (hist.length > 2)
        ChartCard(
          title: 'Caisse',
          unit: '\$',
          series: [Series('caisse', pal.accent, downsample(hist.map((h) => h.money).toList()))],
        ),
      if (hist.length > 2)
        ChartCard(
          title: 'Employés',
          series: [Series('employés', pal.transfo, downsample(hist.map((h) => h.workers.toDouble()).toList()))],
          minY: 0,
        ),
      if (costs.isNotEmpty)
        Section('Coût de revient', [
          for (final e in costs.entries) KV(goods[e.key]!.label, money(e.value)),
        ]),
      const SizedBox(height: 4),
      Btn('Fermer l’entreprise', () => _confirmClose(context), danger: true, icon: Icons.delete_outline),
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
        if (isOut) ...[
          KV('Prix affiché', money(f.price[g] ?? 0.0)),
          KV('Marge visée', pct((f.markup[g] ?? 1.0) - 1)),
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
        content: const Text('Les employés sont mis à pied et la caisse retourne au propriétaire.'),
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
        Expanded(child: NumField(label: 'Montant', value: amount, suffix: '\$', decimals: 0, onSubmit: (v) => setState(() => amount = v.abs()))),
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
        Expanded(child: NumField(label: 'Quantité', value: goodQty, decimals: 0, onSubmit: (v) => setState(() => goodQty = v.abs()))),
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
    final hungry = cs.where((c) => c.hunger >= 1).length;
    final homeless = cs.where((c) => c.homeless).length;
    var total = 0.0;
    for (final c in cs) {
      total += c.money;
    }
    final sorted = List<Citizen>.from(cs)..sort((a, b) => b.money.compareTo(a.money));
    final median = n == 0 ? 0.0 : sorted[n ~/ 2].money;
    final max = n == 0 ? 0.0 : sorted.first.money;

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
    final h = sim.history;

    return ListView(padding: const EdgeInsets.all(12), children: [
      Text('Ménages', style: TextStyle(color: pal.ink, fontSize: 17, fontWeight: FontWeight.w800)),
      const SizedBox(height: 10),
      Section('Population', [
        KV('Citoyens', '$n'),
        KV('Sans emploi', '$unemployed  (${pct(n > 0 ? unemployed / n : 0.0)})'),
        KV('Affamés', '$hungry', color: hungry > 0 ? pal.bad : null),
        KV('Sans logis', '$homeless', color: homeless > 0 ? pal.bad : null),
        KV('Richesse totale', money0(total)),
        KV('Médiane', money0(median)),
        KV('Gini', fmtNum(sim.gini(), 3)),
        KV('Panier de survie', '${money(sim.needCost)} / jour'),
      ]),
      HistogramCard(title: 'Répartition de la richesse (nb de citoyens)', values: counts, labels: labels, color: pal.accent),
      if (h.length > 2)
        ChartCard(
          title: 'Chômage',
          unit: '%',
          minY: 0,
          series: [Series('chômage', pal.bad, downsample(h.map((p) => p.unemp).toList()))],
        ),
      Section('Citoyens (les plus riches d’abord)', [
        for (final c in sorted.take(40))
          InkWell(
            onTap: () => ctrl.select(Selection('citizen', c.id)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(children: [
                Expanded(child: Text(c.name, style: TextStyle(color: pal.ink, fontSize: 13))),
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
    final owned = sim.firms.where((f) => f.ownerId == c.id).toList();
    return ListView(padding: const EdgeInsets.all(12), children: [
      Text(c.name, style: TextStyle(color: pal.ink, fontSize: 17, fontWeight: FontWeight.w800)),
      const SizedBox(height: 10),
      Section('Citoyen', [
        KV('Argent', money0(c.money)),
        KV('Revenu hier', money(c.income)),
        KV('Dépenses hier', money(c.spend)),
        KV('Jours de faim', '${c.hunger}', color: c.hunger > 0 ? pal.bad : null),
        KV('Logement', c.homeless ? 'sans logis' : 'logé', color: c.homeless ? pal.bad : null),
        KV('Souliers', c.shoes > 0 ? 'oui (${c.shoes} j)' : 'non', color: c.shoes > 0 ? null : pal.warn),
        if (job == null) KV('Emploi', 'sans emploi (${c.daysUnemployed} j)', color: pal.warn),
        if (job != null)
          Row(children: [
            Expanded(child: Text('Employeur', style: TextStyle(color: pal.ink2, fontSize: 12.5))),
            TextButton(onPressed: () => widget.ctrl.select(Selection('firm', job.id)), child: Text('${job.name} · ${money0(job.wage)}')),
          ]),
        for (final f in owned)
          Row(children: [
            Expanded(child: Text('Propriétaire de', style: TextStyle(color: pal.ink2, fontSize: 12.5))),
            TextButton(onPressed: () => widget.ctrl.select(Selection('firm', f.id)), child: Text(f.name)),
          ]),
      ]),
      Section('Intervention directe', [
        Row(children: [
          Expanded(child: NumField(label: 'Montant', value: amount, suffix: '\$', decimals: 0, onSubmit: (v) => setState(() => amount = v.abs()))),
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
      ]),
      const SizedBox(height: 24),
    ]);
  }
}

// ------------------------------------------------------------------ État & extérieur

class _StateView extends StatelessWidget {
  final SimController ctrl;
  const _StateView(this.ctrl);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final p = sim.params;
    final st = sim.state;
    final h = sim.history;
    return ListView(padding: const EdgeInsets.all(12), children: [
      Text('État', style: TextStyle(color: pal.ink, fontSize: 17, fontWeight: FontWeight.w800)),
      const SizedBox(height: 10),
      Section('Finances publiques', [
        KV('Trésor', money0(st.money)),
        KV('Impôts perçus (total)', money0(st.taxes)),
        KV('Prestations versées (total)', money0(st.paid)),
        KV('Impôts aujourd’hui', money0(st.taxesToday)),
        KV('Versements aujourd’hui', money0(st.paidToday)),
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
          ],
        ),
      const SizedBox(height: 24),
    ]);
  }
}

class _WorldView extends StatelessWidget {
  final SimController ctrl;
  const _WorldView(this.ctrl);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final p = sim.params;
    return ListView(padding: const EdgeInsets.all(12), children: [
      Text('Extérieur', style: TextStyle(color: pal.ink, fontSize: 17, fontWeight: FontWeight.w800)),
      const SizedBox(height: 10),
      Section('Commerce', [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Frontières ouvertes'),
          subtitle: const Text('Importer et exporter aux prix mondiaux (les biens périssables ne voyagent pas).'),
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
