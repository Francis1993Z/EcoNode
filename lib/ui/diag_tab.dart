// Onglet Diagnostic : anomalies détectées, filets de sécurité (interrupteurs, compteurs, journal),
// invariants comptables et modules du modèle.

import 'package:flutter/material.dart';

import '../engine/model.dart';
import '../engine/monitor.dart';
import 'controller.dart';
import 'format.dart';
import 'palette.dart';
import 'widgets.dart';

class DiagnosticTab extends StatefulWidget {
  final SimController ctrl;
  const DiagnosticTab(this.ctrl, {super.key});
  @override
  State<DiagnosticTab> createState() => _DiagnosticTabState();
}

class _DiagnosticTabState extends State<DiagnosticTab> {
  String netFilter = 'all';

  SimController get ctrl => widget.ctrl;

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final mon = sim.monitor;
    final alerts = mon.sorted;
    final sg = sim.safeguards;
    final inv = sim.inv;
    final fl = sim.lastFlows;
    final log = sim.nets.log.reversed.where((e) => netFilter == 'all' || e.net == netFilter).take(40).toList();

    return ListView(padding: const EdgeInsets.all(12), children: [
      Section('Alertes actives (${alerts.length})', [
        if (alerts.isEmpty) Text('Aucune anomalie détectée.', style: TextStyle(color: pal.ok, fontSize: 12.5)),
        for (final a in alerts) _AlertCard(a, sim.day, ctrl),
      ]),
      Section('Filets de sécurité', [
        Text(
            'Ce sont des instruments de diagnostic : un filet qui se déclenche souvent signale une fuite dans le modèle, '
            'à corriger à la source. Couper un filet montre ce qui se passe sans lui.',
            style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
        const SizedBox(height: 6),
        for (final k in Safeguards.keys) _netRow(context, k),
        const SizedBox(height: 4),
        Row(children: [
          Expanded(
              child: NumField(
                  label: 'Faim avant aide (j)',
                  value: sg.famineDays.toDouble(),
                  decimals: 0,
                  onSubmit: (v) {
                    sg.famineDays = v.round().clamp(1, 60);
                    ctrl.touch();
                  })),
          const SizedBox(width: 8),
          Expanded(
              child: NumField(
                  label: 'Sans logis avant abri (j)',
                  value: sg.shelterDays.toDouble(),
                  decimals: 0,
                  onSubmit: (v) {
                    sg.shelterDays = v.round().clamp(1, 60);
                    ctrl.touch();
                  })),
        ]),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
              child: NumField(
                  label: 'Dérive max / jour (%)',
                  value: sg.maxDailyChange * 100,
                  decimals: 1,
                  onSubmit: (v) {
                    sg.maxDailyChange = (v / 100).clamp(0.001, 1.0);
                    ctrl.touch();
                  })),
          const SizedBox(width: 8),
          Expanded(
              child: NumField(
                  label: 'Paiements / valeur ajoutée (%)',
                  value: sg.maxPaymentRatio * 100,
                  decimals: 0,
                  onSubmit: (v) {
                    sg.maxPaymentRatio = (v / 100).clamp(0.01, 1.0);
                    ctrl.touch();
                  })),
          const SizedBox(width: 8),
          Expanded(
              child: NumField(
                  label: 'Fonds propres min. (%)',
                  value: sg.minCapitalRatio * 100,
                  decimals: 1,
                  onSubmit: (v) {
                    sg.minCapitalRatio = (v / 100).clamp(0.0, 1.0);
                    ctrl.touch();
                  })),
        ]),
      ]),
      Section('Derniers déclenchements', [
        SizedBox(
          height: 40,
          child: ListView(scrollDirection: Axis.horizontal, children: [
            for (final k in ['all', ...Safeguards.keys])
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: ChoiceChip(
                  label: Text(k == 'all' ? 'Tous' : Safeguards.labels[k]!, style: const TextStyle(fontSize: 11.5)),
                  selected: netFilter == k,
                  onSelected: (_) => setState(() => netFilter = k),
                ),
              ),
          ]),
        ),
        if (log.isEmpty) Text('Aucun déclenchement.', style: TextStyle(color: pal.ink3, fontSize: 12)),
        for (final e in log)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(width: 44, child: Text('j${e.day}', style: mono(pal.ink3, 11))),
              Expanded(
                child: Text('${Safeguards.labels[e.net]} · ${e.agent}${e.amount > 0 ? ' · ${money0(e.amount)}' : ''} — ${e.reason}',
                    style: TextStyle(color: pal.ink2, fontSize: 12)),
              ),
            ]),
          ),
      ]),
      Section('Invariants comptables', [
        Text(
            'La monnaie est comptée en multiples de 2⁻¹⁰ \$ : les écarts doivent être exactement nuls. '
            'Tout écart non nul est un bogue.',
            style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
        const SizedBox(height: 4),
        _gap(context, 'Masse réelle − attendue', inv.money),
        _gap(context, 'Prêts en cours − (prêté + capitalisé − remboursé − radié)', inv.loans),
        _gap(context, 'Bilan : réserves + prêts − dépôts − fonds propres', inv.bank),
        _gap(context, 'Variation des dépôts non expliquée (jour)', inv.flows),
        const SizedBox(height: 8),
        Text('Variation des dépôts du dernier jour', style: TextStyle(color: pal.ink, fontSize: 12.5, fontWeight: FontWeight.w700)),
        KV('+ nouveaux prêts', money(fl.loans)),
        KV('− capital remboursé', money(-fl.repaid)),
        KV('− intérêts encaissés par la Caisse', money(-fl.interest)),
        KV('+ ristournes de la Caisse', money(fl.rebates)),
        KV('± god mode (public)', money(fl.godPublic)),
        KV('+ exportations', money(fl.exports)),
        KV('− importations', money(-fl.imports)),
        KV('= variation expliquée', money(fl.explained)),
      ]),
      Section('Modules du modèle', [
        Text(
            'Chaque module ajouté depuis la v0 peut être coupé ; l’effet est immédiat, et une nouvelle partie '
            'est dimensionnée sans lui.',
            style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
        if (sim.modules.entry || sim.firmsCreated + sim.firmsClosed > 0)
          KV('Entreprises créées / fermées', '${sim.firmsCreated} / ${sim.firmsClosed}'),
        for (final k in Modules.keys)
          SwitchListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(Modules.labels[k]!, style: const TextStyle(fontSize: 13)),
            value: sim.modules.get(k),
            onChanged: (v) {
              sim.modules.set(k, v);
              ctrl.touch();
            },
          ),
      ]),
      if (mon.closed.isNotEmpty)
        Section('Alertes terminées', [
          for (final a in mon.closed.reversed.take(20))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Text('j${a.since}–j${a.until} · ${alertLabels[a.type]} : ${a.what}',
                  style: TextStyle(color: pal.ink3, fontSize: 11.5)),
            ),
        ]),
      const SizedBox(height: 24),
    ]);
  }

  Widget _netRow(BuildContext context, String k) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final n = sim.nets.total(k);
    final rate = sim.day > 0 ? n * 50 / sim.day : 0.0;
    final causes = (sim.nets.causes[k] ?? const <String, int>{}).entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final agents = (sim.nets.byAgent[k] ?? const <String, int>{}).entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final hot = rate >= 1;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(Safeguards.labels[k]!, style: TextStyle(color: pal.ink, fontSize: 13, fontWeight: FontWeight.w700))),
          Text('$n · ${fmtNum(rate, 1)} / 50 j', style: mono(hot ? pal.bad : pal.ink2, 11.5)),
          Switch(
            value: sim.safeguards.get(k),
            onChanged: (v) {
              sim.safeguards.set(k, v);
              ctrl.touch();
            },
          ),
        ]),
        if (causes.isNotEmpty)
          Text('Causes : ${causes.take(3).map((e) => '${e.key} (${(100 * e.value / n).round()} %)').join(', ')}',
              style: TextStyle(color: pal.ink3, fontSize: 11.5)),
        if (agents.isNotEmpty)
          Text('Surtout : ${agents.take(3).map((e) => '${e.key} ×${e.value}').join(', ')}',
              style: TextStyle(color: pal.ink3, fontSize: 11.5)),
      ]),
    );
  }

  Widget _gap(BuildContext context, String label, double v) {
    final pal = Pal.of(context);
    return KV(label, v == 0 ? '0 (exact)' : v.toStringAsExponential(2), color: v.abs() > 1e-6 ? pal.bad : pal.ok);
  }
}

/// Une alerte. Toucher la carte ouvre l'inspecteur de l'entreprise qu'elle concerne ; toucher une ligne soulignée
/// ouvre celui de l'entreprise ou du citoyen cité.
class _AlertCard extends StatelessWidget {
  final Alert a;
  final int day;
  final SimController ctrl;
  const _AlertCard(this.a, this.day, this.ctrl);

  /// L'agent existe encore (une entreprise fermée n'a plus d'inspecteur).
  bool _exists(AgentRef r) => r.kind == 'firm' ? ctrl.sim.firm(r.id) != null : ctrl.sim.citizen(r.id) != null;

  void _open(AgentRef r) => ctrl.select(Selection(r.kind, r.id));

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final col = a.critical ? pal.bad : pal.warn;
    final subject = a.subject != null && _exists(a.subject!) ? a.subject : null;
    final card = Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: col.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: col.withValues(alpha: 0.5)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Pill(a.critical ? 'critique' : 'attention', col),
          const SizedBox(width: 8),
          Expanded(
              child: Text(alertLabels[a.type] ?? a.type, style: TextStyle(color: pal.ink, fontSize: 13, fontWeight: FontWeight.w700))),
          Text('depuis j${a.since} (${day - a.since + 1} j)', style: mono(pal.ink3, 11)),
        ]),
        const SizedBox(height: 4),
        Text(a.what, style: TextStyle(color: pal.ink2, fontSize: 12.5)),
        if (a.agents.isNotEmpty) ...[
          const SizedBox(height: 4),
          for (var i = 0; i < a.agents.length && i < 6; i++) _line(pal, a.agents[i], i < a.refs.length ? a.refs[i] : null),
        ],
      ]),
    );
    if (subject == null) return card;
    return InkWell(onTap: () => _open(subject), borderRadius: BorderRadius.circular(8), child: card);
  }

  Widget _line(Pal pal, String text, AgentRef? r) {
    if (r == null || !_exists(r)) return Text('· $text', style: TextStyle(color: pal.ink3, fontSize: 11.5));
    return InkWell(
      onTap: () => _open(r),
      child: Text('· $text',
          style: TextStyle(color: pal.accent, fontSize: 11.5, decoration: TextDecoration.underline, decorationColor: pal.accent)),
    );
  }
}
