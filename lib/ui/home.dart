// Écran principal en paysage : graphe à gauche, panneau à droite repliable, barre du haut.

import 'package:flutter/material.dart';

import 'controller.dart';
import 'eco_tab.dart';
import 'format.dart';
import 'god_tab.dart';
import 'graph.dart';
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
            const SizedBox(width: 14),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  if (h != null) ...[
                    _Kpi('Masse', kmoney(h.total)),
                    _Kpi('Chômage', pct(h.unemp), warn: h.unemp > 0.15),
                    _Kpi('Salaire', money0(h.wage)),
                    _Kpi('Panier', money0(h.need)),
                    _Kpi('Affamés', '${h.hungry}', warn: h.hungry > 0),
                    _Kpi('Sans logis', '${h.homeless}', warn: h.homeless > 0),
                    _Kpi('Gini', fmtNum(h.gini, 2)),
                  ],
                ]),
              ),
            ),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Text('Flux \$', style: TextStyle(color: pal.ink2, fontSize: 11)),
              Switch(value: ctrl.showMoneyFlows, onChanged: ctrl.toggleMoneyFlows),
            ]),
            IconButton(
              tooltip: ctrl.panelOpen ? 'Masquer le panneau' : 'Afficher le panneau',
              onPressed: ctrl.togglePanel,
              icon: Icon(ctrl.panelOpen ? Icons.right_panel_close : Icons.right_panel_open),
            ),
          ]);
        },
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

  static const tabs = ['Inspecteur', 'God mode', 'Économie', 'Journal', 'Modèle'];

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    Widget body;
    switch (ctrl.panelTab) {
      case 1:
        body = GodTab(ctrl);
        break;
      case 2:
        body = EconomyTab(ctrl);
        break;
      case 3:
        body = JournalTab(ctrl);
        break;
      case 4:
        body = ModelTab(ctrl);
        break;
      default:
        body = InspectorTab(ctrl);
    }
    return Column(children: [
      SizedBox(
        height: 46,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          children: [
            for (var i = 0; i < tabs.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: ChoiceChip(
                  label: Text(tabs[i], style: const TextStyle(fontSize: 12.5)),
                  selected: ctrl.panelTab == i,
                  selectedColor: pal.accentSoft,
                  onSelected: (_) => ctrl.setTab(i),
                ),
              ),
          ],
        ),
      ),
      Divider(height: 1, color: pal.rule),
      Expanded(child: body),
    ]);
  }
}
