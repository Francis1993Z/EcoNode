// Journaux complets d'une partie, pour l'outil en ligne de commande (tool/partie.dart) : chaque événement, une ligne
// d'indicateurs par jour, chaque citoyen et chaque entreprise en fin de partie. L'interface garde ses listes
// plafonnées ; le traceur ne fait que lire l'état et recevoir les événements : il ne change aucun calcul.

import 'dart:convert';
import 'dart:math' as math;

import 'model.dart';
import 'monitor.dart';
import 'sim.dart';

/// Catégories du journal d'événements (filtrables).
const List<String> traceCategories = [
  'compta', 'travail', 'credit', 'filets', 'institutions', 'entrees_sorties', 'alertes',
];

class _CitizenLog {
  final int arrived;
  final double skill0, money0;
  double lastSkill;
  int days = 0, hunger = 0, homeless = 0, unemployed = 0, courses = 0;
  double income = 0;
  final Map<String, int> distress = {}; // cause de détresse → jours
  _CitizenLog(this.arrived, this.skill0, this.money0) : lastSkill = skill0;
}

class _FirmLog {
  final int id;
  final String name, type;
  final int created;
  int? closed;
  String cause = '';
  int days = 0;
  double cash = 0, workers = 0, dividends = 0, writtenOff = 0, bailouts = 0, loans = 0;
  _FirmLog(this.id, this.name, this.type, this.created);
}

/// Écrit le journal d'événements au fil de la partie et accumule de quoi décrire citoyens et entreprises à la fin.
/// Appeler [afterStep] après chaque `sim.step()`.
class Tracer {
  final Sim sim;
  final StringSink? events; // evenements.jsonl
  final StringSink? series; // series.csv
  final Set<String>? only; // catégories retenues dans le journal (null : toutes)
  int eventsWritten = 0;
  final Map<int, _CitizenLog> _cit = {};
  final Map<int, _FirmLog> _firms = {};
  Map<String, int> _netsBefore = {};

  Tracer(this.sim, {this.events, this.series, this.only}) {
    sim.trace = _event;
    for (final c in sim.citizens) {
      _cit[c.id] = _CitizenLog(sim.day, c.skill, c.money);
    }
    for (final f in sim.firms) {
      _firms[f.id] = _FirmLog(f.id, f.name, f.type, sim.day);
    }
    _netsBefore = Map.of(sim.nets.count);
    series?.writeln(seriesColumns.map(_csv).join(','));
  }

  /// Détache le traceur de la partie.
  void detach() {
    if (identical(sim.trace, _event)) sim.trace = null;
  }

  void _event(TraceEvent e) {
    // une entreprise créée aujourd'hui : connue dès son premier événement (son prêt de départ, par exemple)
    if (e.id != null && !_firms.containsKey(e.id)) {
      final x = sim.firm(e.id!);
      if (x != null) _firms[x.id] = _FirmLog(x.id, x.name, x.type, sim.day);
    }
    final f = e.id == null || e.category == 'alertes' ? null : _firms[e.id];
    if (f != null) {
      switch (e.type) {
        case 'radiation':
          f.writtenOff += e.amount;
        case 'pret':
          f.loans += e.amount;
        case 'bailout':
          f.bailouts += e.amount;
        case 'fermeture':
        case 'retrait':
          f.closed = e.day;
          f.cause = e.cause;
      }
    }
    if (events != null && (only == null || only!.contains(e.category))) {
      events!.writeln(jsonEncode(e.toJson()));
      eventsWritten++;
    }
  }

  // ---------------------------------------------------------------- séries quotidiennes

  /// Colonnes de series.csv : les indicateurs que regardent les détecteurs, puis le détail par alerte, filet, bien,
  /// désir et classe.
  static final List<String> seriesColumns = [
    'jour', 'population', 'chomage', 'salaire_moyen', 'pib', 'indice_prix', 'inflation_jour', 'inflation_100j', 'gini',
    'richesse_mediane', 'besoins_jour', 'richesse_mediane_jours', 'bonheur', 'part_affames', 'part_sans_abri',
    'sante_moyenne', 'efficacite_moyenne', 'postes_non_pourvus', 'part_postes_non_pourvus', 'postes_bloques',
    'part_postes_bloques', 'masse_menages', 'masse_entreprises', 'tresor', 'caisse', 'masse_totale', 'dette',
    'credit_net', 'machines', 'technologie', 'entreprises', 'fonds_propres_caisse', 'prets_refuses', 'part_prestations',
    'prestataires_ae', 'beneficiaires_aide', 'file_soins', 'attente_soins', 'file_cours', 'attente_cours',
    'ecart_compta', 'alertes_actives', 'alertes_critiques',
    for (final t in alertLabels.keys) 'alerte_$t',
    for (final k in Safeguards.keys) 'filet_${k}_jour',
    for (final g in goods.keys) 'prix_$g',
    for (final d in desires) 'satisfaction_$d',
    'classe_manoeuvre', 'classe_technicien', 'classe_professionnel',
  ];

  List<Object> _seriesRow() {
    final s = sim;
    final h = s.history.last;
    final hist = s.history;
    final n = s.citizens.length;
    final prev = hist.length >= 2 ? hist[hist.length - 2] : null;
    final old = hist.length > 100 ? hist[hist.length - 101] : null;
    var health = 0.0, eff = 0.0;
    var employed = 0;
    for (final c in s.citizens) {
      health += c.health;
      if (c.employer != null) {
        employed++;
        final k = s.efficiencyFactors(c);
        eff += k.faim * k.logement * k.sante * k.moral;
      }
    }
    var unfilled = 0, blocked = 0;
    for (final f in s.firms) {
      if (f.vacancies > 0 && f.unfilledDays >= 1) unfilled += f.vacancies;
      final gap = f.desired - f.workers.length;
      if (gap > f.vacancies && s.affordablePosts(f) < math.min(gap, 3)) blocked += gap - f.vacancies;
    }
    final median = s.medianWealth();
    final active = <String, int>{};
    for (final a in s.monitor.active.values) {
      active[a.type] = (active[a.type] ?? 0) + 1;
    }
    final nets = s.nets.count;
    final care = s.services['soins']!, school = s.services['cours']!;
    final row = <Object>[
      h.day, n, h.unemp, h.wage, h.gdp, h.cpi,
      prev != null && prev.cpi > 0 ? h.cpi / prev.cpi - 1 : 0.0,
      old != null && old.cpi > 0 ? h.cpi / old.cpi - 1 : 0.0,
      h.gini, median, s.needCost, s.needCost > 0 ? median / s.needCost : 0.0, h.happiness,
      n > 0 ? h.hungry / n : 0.0, n > 0 ? h.homeless / n : 0.0, n > 0 ? health / n : 0.0,
      employed > 0 ? eff / employed : 0.0, unfilled, unfilled > 0 ? unfilled / (employed + unfilled) : 0.0, blocked,
      n > 0 ? blocked / n : 0.0, h.mH, h.mF, h.mE, h.mB, h.total, h.debt, h.credit, h.machines, h.tech,
      s.firms.length, s.bank.equity, s.bank.refusals, s.state.benefitCut, s.state.eiClaimants,
      s.state.assistRecipients, care.queue, care.wait, school.queue, school.wait, s.inv.worst,
      s.monitor.active.length, s.monitor.criticalCount,
      for (final t in alertLabels.keys) active[t] ?? 0,
      for (final k in Safeguards.keys) (nets[k] ?? 0) - (_netsBefore[k] ?? 0),
      for (final g in goods.keys) h.prices[g] ?? 0.0,
      for (final d in desires) h.sat[d] ?? 0.0,
      ...h.classes,
    ];
    _netsBefore = Map.of(nets);
    return row;
  }

  // ---------------------------------------------------------------- après chaque jour

  void afterStep() {
    final s = sim;
    if (series != null) series!.writeln(_seriesRow().map(_csv).join(','));
    for (final c in s.citizens) {
      final l = _cit[c.id] ??= _CitizenLog(s.day, c.skill, c.money);
      l.days++;
      l.income += c.income;
      if (c.employer == null) l.unemployed++;
      if (c.skill > l.lastSkill + 1e-12) {
        l.courses += math.max(1, ((c.skill - l.lastSkill) / s.params.learnRate).round());
      }
      l.lastSkill = c.skill;
      if (c.hungerDays >= 1) {
        l.hunger++;
        final k = 'faim : ${s.famineCause(c)}';
        l.distress[k] = (l.distress[k] ?? 0) + 1;
      }
      if (c.homeless) {
        l.homeless++;
        final k = 'logis : ${s.shelterCause(c)}';
        l.distress[k] = (l.distress[k] ?? 0) + 1;
      }
    }
    final alive = <int>{};
    for (final f in s.firms) {
      alive.add(f.id);
      final l = _firms[f.id] ??= _FirmLog(f.id, f.name, f.type, s.day);
      l.days++;
      l.cash += f.money;
      l.workers += f.workers.length;
      l.dividends += f.dividends;
    }
    for (final l in _firms.values) {
      if (l.closed == null && !alive.contains(l.id)) {
        l.closed = s.day;
        if (l.cause.isEmpty) l.cause = 'disparue';
      }
    }
  }

  // ---------------------------------------------------------------- fin de partie

  static const List<String> agentColumns = [
    'id', 'nom', 'arrivee', 'qualification', 'classe', 'qualification_initiale', 'cours_suivis', 'ambition',
    'ordinateur', 'argent_initial', 'epargne', 'revenu_moyen', 'jours_observes', 'jours_faim', 'jours_sans_logis',
    'jours_sans_emploi', 'employeur_id', 'employeur', 'secteur_employeur', 'entreprises_possedees', 'sante', 'bonheur',
    'prestations_ae_restantes', 'cause_detresse_dominante', 'jours_cause_dominante',
  ];

  String agentsCsv() {
    final s = sim;
    final b = StringBuffer()..writeln(agentColumns.map(_csv).join(','));
    final owned = <int, int>{};
    for (final f in s.firms) {
      if (f.ownerId != null) owned[f.ownerId!] = (owned[f.ownerId!] ?? 0) + 1;
    }
    for (final c in s.citizens) {
      final l = _cit[c.id] ?? _CitizenLog(s.day, c.skill, c.money);
      final emp = c.employer == null ? null : s.firm(c.employer!);
      final top = l.distress.entries.isEmpty
          ? null
          : l.distress.entries.reduce((a, x) => x.value > a.value ? x : a);
      b.writeln([
        c.id, c.name, l.arrived, c.skill, classLabels[c.level], l.skill0, l.courses, c.ambition,
        c.computerDays > 0 ? 1 : 0, l.money0, c.money, l.days > 0 ? l.income / l.days : 0.0, l.days, l.hunger,
        l.homeless, l.unemployed, emp?.id ?? '', emp?.name ?? '', emp?.template.sector ?? '', owned[c.id] ?? 0,
        c.health, c.happiness, c.eiDaysLeft, top?.key ?? '', top?.value ?? 0,
      ].map(_csv).join(','));
    }
    return b.toString();
  }

  static const List<String> firmColumns = [
    'id', 'nom', 'type', 'secteur', 'creation', 'fermeture', 'cause_fermeture', 'jours_actifs', 'tresorerie_moyenne',
    'employes_moyens', 'dividendes_verses', 'dette_radiee', 'prets_recus', 'renflouements_recus', 'dette_fin',
    'tresorerie_fin',
  ];

  String firmsCsv() {
    final s = sim;
    final b = StringBuffer()..writeln(firmColumns.map(_csv).join(','));
    for (final l in _firms.values) {
      final f = s.firm(l.id);
      b.writeln([
        l.id, l.name, l.type, templates[l.type]?.sector ?? '', l.created, l.closed ?? '', l.cause, l.days,
        l.days > 0 ? l.cash / l.days : 0.0, l.days > 0 ? l.workers / l.days : 0.0, l.dividends, l.writtenOff, l.loans,
        l.bailouts, f?.debt ?? '', f?.money ?? '',
      ].map(_csv).join(','));
    }
    return b.toString();
  }
}

/// Une cellule CSV : nombres en notation anglaise à pleine précision, texte entre guillemets s'il le faut.
String _csv(Object? v) {
  if (v == null) return '';
  if (v is double) return v.isFinite ? v.toString() : '';
  final t = v.toString();
  if (t.contains(',') || t.contains('"') || t.contains('\n')) return '"${t.replaceAll('"', '""')}"';
  return t;
}
