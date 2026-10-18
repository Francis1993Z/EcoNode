// Écran principal en paysage : graphe à gauche, panneau à droite repliable, barre du haut.

import 'package:flutter/material.dart';

import '../engine/model.dart';

import 'controller.dart';
import 'diag_tab.dart';
import 'eco_tab.dart';
import 'format.dart';
import 'god_tab.dart';
import 'graph.dart';
import 'housing.dart';
import 'inspector.dart';
import 'palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final SimController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = SimController(seed: 42)..attach(this);
    // la partie attend que le joueur choisisse la taille de la population
    ctrl.playing = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _askStart();
    });
  }

  /// Écran de départ : taille de la population et graine, avant de lancer la simulation.
  Future<void> _askStart() async {
    var pop = 240.0;
    var housing = ctrl.sim.modules.buildings;
    var jobs = ctrl.sim.modules.jobs;
    var founders = ctrl.sim.modules.entrepreneurship;
    final seedCtl = TextEditingController(text: '42');
    final go = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, set) => AlertDialog(
          title: const Text('Nouvelle partie'),
          content: SizedBox(
            width: 360,
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Population : ${pop.round()} citoyens', style: const TextStyle(fontWeight: FontWeight.w600)),
              Slider(
                value: pop,
                min: 40,
                max: 1000,
                divisions: 96,
                label: '${pop.round()}',
                onChanged: (v) => set(() => pop = v),
              ),
              const Text('Les entreprises et leurs effectifs sont dimensionnés pour cette population. '
                  'Au-delà de 500 citoyens, la simulation ralentit.', style: TextStyle(fontSize: 12)),
              const SizedBox(height: 4),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: housing,
                onChanged: (v) => set(() => housing = v),
                title: const Text('Marché immobilier', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                subtitle: const Text('Bâtiments construits, loués, achetés et revendus ; hypothèques de la Caisse.',
                    style: TextStyle(fontSize: 12)),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: jobs,
                onChanged: (v) => set(() => jobs = v),
                title: const Text('Rôles et négociation salariale',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                subtitle: const Text('Organigrammes, salaires négociés à l’embauche, contre-offres, promotions et '
                    'révisions annuelles.', style: TextStyle(fontSize: 12)),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: founders,
                onChanged: (v) => set(() => founders = v),
                title: const Text('Entrepreneuriat des citoyens',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                subtitle: const Text('Des citoyens ambitieux fondent des entreprises avec leur épargne et un prêt de la '
                    'Caisse, au lieu de créations automatiques. Réglable dans l’onglet Modèle.',
                    style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: seedCtl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Graine', isDense: true),
              ),
            ]),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Partie par défaut')),
            FilledButton.icon(
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Lancer'),
            ),
          ],
        ),
      ),
    );
    if (!mounted) return;
    if (go == true) {
      final seed = int.tryParse(seedCtl.text.trim())?.abs() ?? 42;
      // la nouvelle partie reprend les modules en cours : on y règle le marché immobilier avant de la créer
      ctrl.sim.modules.buildings = housing;
      ctrl.sim.modules.jobs = jobs;
      ctrl.sim.modules.entrepreneurship = founders;
      ctrl.newGame(seed, params: Params()..population = pop.round());
    }
    seedCtl.dispose();
    ctrl.playing = true;
    ctrl.touch();
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return Scaffold(
      backgroundColor: pal.paper,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
          TopBar(ctrl),
          Divider(height: 1, color: pal.rule),
          Expanded(
            child: AnimatedBuilder(
              animation: ctrl,
              builder: (context, _) {
                final w = MediaQuery.of(context).size.width;
                final panelW = (w * 0.38).clamp(300.0, 460.0).toDouble();
                final kb = MediaQuery.of(context).viewInsets.bottom;
                return Row(children: [
                  Expanded(child: GraphView(ctrl: ctrl)),
                  if (ctrl.panelOpen) ...[
                    VerticalDivider(width: 1, color: pal.rule),
                    SizedBox(
                      width: panelW,
                      child: Container(
                        color: pal.paper,
                        padding: EdgeInsets.only(bottom: kb),
                        child: SidePanel(ctrl),
                      ),
                    ),
                  ],
                ]);
              },
            ),
          ),
        ]),
      ),
    );
  }
}

// ------------------------------------------------------------------ barre du haut

class TopBar extends StatelessWidget {
  final SimController ctrl;
  const TopBar(this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return Container(
      color: pal.sheet,
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AnimatedBuilder(
        animation: ctrl,
        builder: (context, _) {
          final sim = ctrl.sim;
          final h = sim.history.isEmpty ? null : sim.history.last;
          return Row(children: [
            IconButton(
              tooltip: ctrl.playing ? 'Pause' : 'Lecture',
              onPressed: ctrl.togglePlay,
              icon: Icon(ctrl.playing ? Icons.pause : Icons.play_arrow),
            ),
            IconButton(tooltip: 'Un jour', onPressed: ctrl.stepOnce, icon: const Icon(Icons.skip_next)),
            for (final s in const [1.0, 4.0, 16.0, 64.0])
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: ChoiceChip(
                  label: Text('×${s.round()}', style: const TextStyle(fontSize: 12)),
                  visualDensity: VisualDensity.compact,
                  selected: ctrl.playing && ctrl.speed == s,
                  onSelected: (_) => ctrl.setSpeed(s),
                ),
              ),
            const SizedBox(width: 8),
            Text('Jour ${sim.day}', style: mono(pal.ink, 14, weight: FontWeight.w800)),
            // l'appareil ne tient pas la vitesse demandée : on affiche celle qu'il tient
            if (ctrl.playing && ctrl.speed >= 16 && ctrl.realSpeed > 0 && ctrl.realSpeed < ctrl.speed * 0.85)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Tooltip(
                  message: 'Vitesse réellement tenue par cet appareil',
                  child: Text('réel ×${ctrl.realSpeed.round()}', style: mono(pal.warn, 11, weight: FontWeight.w700)),
                ),
              ),
            const SizedBox(width: 14),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  if (h != null) ...[
                    _Kpi('Masse', kmoney(h.total)),
                    _Kpi('Chômage', pct(h.unemp), warn: h.unemp > 0.15),
                    _Kpi('Salaire', money0(h.wage)),
                    _Kpi('Bonheur', pct(h.happiness), warn: h.happiness < 0.6),
                    _Kpi('Prix', fmtNum(h.cpi * 100, 0)),
                    _Kpi('Panier', money0(h.need)),
                    _Kpi('Affamés', '${h.hungry}', warn: h.hungry > 0),
                    _Kpi('Sans logis', '${h.homeless}', warn: h.homeless > 0),
                    _Kpi('Dette', kmoney(h.debt)),
                    _Kpi('Gini', fmtNum(h.gini, 2)),
                  ],
                ]),
              ),
            ),
            _AlertBadge(ctrl),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Text('Flux \$', style: TextStyle(color: pal.ink2, fontSize: 11)),
              Switch(value: ctrl.showMoneyFlows, onChanged: ctrl.toggleMoneyFlows),
            ]),
            IconButton(
              tooltip: ctrl.panelOpen ? 'Masquer le panneau' : 'Afficher le panneau',
              onPressed: ctrl.togglePanel,
              icon: Icon(ctrl.panelOpen ? Icons.chevron_right : Icons.view_sidebar),
            ),
          ]);
        },
      ),
    );
  }
}

/// Nombre d'alertes actives (rouge s'il y en a une critique) ; ouvre l'onglet Diagnostic.
class _AlertBadge extends StatelessWidget {
  final SimController ctrl;
  const _AlertBadge(this.ctrl);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final mon = ctrl.sim.monitor;
    final n = mon.active.length;
    final crit = mon.criticalCount;
    final col = crit > 0 ? pal.bad : (n > 0 ? pal.warn : pal.ok);
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Tooltip(
        message: n == 0 ? 'Aucune anomalie' : '$n alerte(s) active(s), dont $crit critique(s)',
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => ctrl.setTab(Tabs.diagnostic),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: col.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: col.withValues(alpha: 0.6)),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(n == 0 ? Icons.check_circle_outline : Icons.warning_amber_rounded, size: 16, color: col),
              const SizedBox(width: 4),
              Text('$n', style: mono(col, 12.5, weight: FontWeight.w800)),
            ]),
          ),
        ),
      ),
    );
  }
}

class _Kpi extends StatelessWidget {
  final String label;
  final String value;
  final bool warn;
  const _Kpi(this.label, this.value, {this.warn = false});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label.toUpperCase(), style: TextStyle(color: pal.ink3, fontSize: 9.5, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
        Text(value, style: mono(warn ? pal.bad : pal.ink, 13.5, weight: FontWeight.w700)),
      ]),
    );
  }
}

// ------------------------------------------------------------------ panneau latéral

class SidePanel extends StatelessWidget {
  final SimController ctrl;
  const SidePanel(this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    Widget body;
    switch (ctrl.panelTab) {
      case Tabs.diagnostic:
        body = DiagnosticTab(ctrl);
        break;
      case Tabs.god:
        body = GodTab(ctrl);
        break;
      case Tabs.economy:
        body = EconomyTab(ctrl);
        break;
      case Tabs.journal:
        body = JournalTab(ctrl);
        break;
      case Tabs.model:
        body = ModelTab(ctrl);
        break;
      case Tabs.housing:
        body = HousingTab(ctrl);
        break;
      default:
        body = InspectorTab(ctrl);
    }
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 6, 8, 2),
        // tous les onglets restent visibles, sur deux lignes si le panneau est étroit (la souris ne fait pas défiler une liste)
        child: Wrap(
          spacing: 6,
          runSpacing: 0,
          children: [
            for (var i = 0; i < Tabs.labels.length; i++)
              ChoiceChip(
                label: Text(
                    i == Tabs.diagnostic && ctrl.sim.monitor.active.isNotEmpty
                        ? '${Tabs.labels[i]} (${ctrl.sim.monitor.active.length})'
                        : Tabs.labels[i],
                    style: const TextStyle(fontSize: 12.5)),
                visualDensity: VisualDensity.compact,
                selected: ctrl.panelTab == i,
                selectedColor: pal.accentSoft,
                onSelected: (_) => ctrl.setTab(i),
              ),
          ],
        ),
      ),
      Divider(height: 1, color: pal.rule),
      Expanded(child: body),
    ]);
  }
}
