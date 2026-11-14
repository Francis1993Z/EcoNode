// Onglet « Entreprises » : démographie des entreprises privées (naissances, morts, rachats, survie, âge, concentration),
// comparée à des repères réels (États-Unis, France, Canada) dans les infobulles.
//
// L'interface ne modifie rien dans le moteur : elle tient son propre journal (FirmLog), relevé après chaque jour simulé,
// comme le journal du marché immobilier (HousingLog). Les établissements publics (hôpital, école…) ne naissent ni ne meurent :
// ils sont exclus. Une entreprise disparaît quand elle ferme (`Sim._close`) ; la cause est lue par `Sim.closeCause` sur
// l'entreprise le jour où elle disparaît. Un rachat est un changement de propriétaire (filet de renflouement) : l'entreprise
// continue, ce n'est pas une disparition.

import 'package:flutter/material.dart';

import '../engine/model.dart';
import '../engine/sim.dart';
import 'charts.dart';
import 'controller.dart';
import 'format.dart';
import 'palette.dart';
import 'widgets.dart';

// ------------------------------------------------------------------ journal

/// Vie d'une entreprise privée vue par l'interface.
class FirmLife {
  final String type;
  /// Jour de naissance ; null : déjà là quand le suivi a commencé (partie reprise en cours de route), âge inconnu.
  final int? born;
  int? died;
  String? cause; // closeCause du moteur : faillite, demande_perdue, sans_employe, prix_aberrant, autre
  int takeovers = 0;
  FirmLife(this.type, this.born);

  /// Née pendant la partie (pas une entreprise du plan de départ).
  bool get newborn => born != null && born! > 0;
}

/// Journal quotidien de la démographie des entreprises, tenu par l'interface (rien n'est écrit dans le moteur).
class FirmLog {
  static const int _cap = 8000;
  static const int year = 365;

  final Map<int, FirmLife> lives = {};
  final Map<int, int?> _owner = {};
  int _lastDay = -1;

  // une valeur par jour simulé
  final List<int> days = [];
  final List<double> firms = []; // entreprises privées
  final List<double> active = []; // dont au moins un employé
  final List<int> births = [];
  final List<int> deaths = [];
  final List<int> deathsCash = []; // dont trésorerie à sec (faillite)
  final List<int> takeovers = [];
  final List<double> birthRate = []; // taux annuels sur l'année glissante, à partir de la première année complète
  final List<double> deathRate = [];

  void clear() {
    lives.clear();
    _owner.clear();
    _lastDay = -1;
    for (final l in [days, births, deaths, deathsCash, takeovers]) {
      l.clear();
    }
    for (final l in [firms, active, birthRate, deathRate]) {
      l.clear();
    }
  }

  void sample(Sim s) {
    if (s.day == _lastDay) return;
    if (s.day < _lastDay) clear(); // la partie a été remise à zéro
    final first = _lastDay < 0;
    _lastDay = s.day;
    var nb = 0, nd = 0, ndc = 0, nt = 0, nf = 0, na = 0;
    final present = <int>{};
    for (final f in s.firms) {
      if (s.publicService(f)) continue;
      present.add(f.id);
      nf++;
      if (f.workers.isNotEmpty) na++;
      final life = lives[f.id];
      if (life == null) {
        // au premier relevé : le plan de départ (jour 0) ou une partie déjà commencée (âge connu pour une fondation)
        final born = !first ? s.day : (s.day == 0 ? 0 : (f.founderId != null ? f.foundedDay : null));
        lives[f.id] = FirmLife(f.type, born);
        _owner[f.id] = f.ownerId;
        if (!first) nb++;
        continue;
      }
      if (f.ownerId != _owner[f.id]) {
        life.takeovers++;
        _owner[f.id] = f.ownerId;
        nt++;
      }
    }
    for (final e in lives.entries) {
      final life = e.value;
      if (life.died != null || present.contains(e.key)) continue;
      life.died = s.day;
      nd++;
      _owner.remove(e.key);
    }
    // cause : lue sur l'objet de l'entreprise disparue (le moteur ne le réutilise pas)
    if (nd > 0) {
      for (final f in _gone(s, present)) {
        final life = lives[f.id]!;
        life.cause = s.closeCause(f);
        if (life.cause == 'faillite') ndc++;
      }
    }
    if (days.length >= _cap) {
      const drop = 1000;
      for (final l in [births, deaths, deathsCash, takeovers]) {
        l.removeRange(0, drop);
      }
      for (final l in [firms, active]) {
        l.removeRange(0, drop);
      }
      for (final l in [birthRate, deathRate]) {
        l.removeRange(0, l.length < drop ? l.length : drop);
      }
      days.removeRange(0, drop);
    }
    days.add(s.day);
    firms.add(nf.toDouble());
    active.add(na.toDouble());
    births.add(nb);
    deaths.add(nd);
    deathsCash.add(ndc);
    takeovers.add(nt);
    // courbes des taux : seulement sur une année complète (annualisés sur quelques jours, les taux font des pics trompeurs)
    if (days.length >= year) {
      final w = window();
      birthRate.add(w.birthRate);
      deathRate.add(w.deathRate);
    }
    _known = {for (final f in s.firms) f.id: f};
  }

  Map<int, Firm> _known = {};

  /// Entreprises vues hier et absentes aujourd'hui (objets gardés depuis le relevé précédent).
  Iterable<Firm> _gone(Sim s, Set<int> present) sync* {
    for (final e in _known.entries) {
      if (!present.contains(e.key) && lives[e.key]?.died == s.day) yield e.value;
    }
  }

  /// Comptes de l'année glissante (au plus 365 derniers jours relevés).
  FirmWindow window([int span = year]) {
    final n = days.length < span ? days.length : span;
    if (n == 0) return const FirmWindow(0, 0, 0, 0, 0, 0, 0);
    var b = 0, d = 0, dc = 0, t = 0;
    var mean = 0.0;
    for (var i = days.length - n; i < days.length; i++) {
      b += births[i];
      d += deaths[i];
      dc += deathsCash[i];
      t += takeovers[i];
      mean += firms[i];
    }
    mean /= n;
    return FirmWindow(n, b, d, dc, t, mean, mean > 0 ? year / n / mean : 0);
  }

  /// Survie à [years] ans des entreprises nées pendant la partie, par l'estimateur de Kaplan-Meier : à chaque âge où une
  /// entreprise meurt, la survie est multipliée par (1 − morts à cet âge ÷ entreprises encore suivies à cet âge). Les
  /// entreprises encore vivantes comptent jusqu'à leur âge d'aujourd'hui (censure). Toutes les cohortes servent, et la
  /// survie ne peut que baisser avec l'âge. [atRisk] : entreprises suivies jusqu'à cet âge. Null tant qu'aucune entreprise
  /// née n'a pu être suivie aussi longtemps.
  ({double rate, int atRisk})? survival(int today, int years) {
    final age = years * year;
    final obs = <(int, bool)>[]; // (durée suivie en jours, morte)
    var longEnough = false;
    for (final l in lives.values) {
      if (!l.newborn) continue;
      final end = l.died ?? today;
      obs.add((end - l.born!, l.died != null));
      if (today - l.born! >= age) longEnough = true;
    }
    if (!longEnough) return null;
    obs.sort((a, b) => a.$1.compareTo(b.$1));
    var surv = 1.0;
    var atRisk = obs.length;
    var i = 0;
    while (i < obs.length && obs[i].$1 < age) {
      final t = obs[i].$1;
      var dead = 0, gone = 0;
      while (i < obs.length && obs[i].$1 == t) {
        if (obs[i].$2) dead++;
        gone++;
        i++;
      }
      if (atRisk > 0 && dead > 0) surv *= 1 - dead / atRisk;
      atRisk -= gone;
    }
    return (rate: surv, atRisk: atRisk);
  }
}

/// Comptes d'une fenêtre de jours : naissances, morts (dont trésorerie à sec), rachats, nombre moyen d'entreprises.
class FirmWindow {
  final int days, births, deaths, deathsCash, takeovers;
  final double meanFirms;
  final double _k; // facteur d'annualisation rapporté au nombre moyen d'entreprises
  const FirmWindow(this.days, this.births, this.deaths, this.deathsCash, this.takeovers, this.meanFirms, this._k);
  double get birthRate => births * _k;
  double get deathRate => deaths * _k;
  double get takeoverRate => takeovers * _k;
}

// ------------------------------------------------------------------ repères réels

/// Un chiffre réel et sa source.
class RefValue {
  final double value;
  final String source;
  const RefValue(this.value, this.source);
}

/// Repères réels par pays (vérifiés à la source le 14 novembre 2026). Les définitions diffèrent d'un pays à l'autre :
/// établissements aux États-Unis, entreprises économiquement actives (micro-entrepreneurs compris) ou créées hors
/// micro-entrepreneurs en France, entreprises employeuses au Canada.
class FirmRefs {
  static const usa = 'États-Unis', france = 'France', canada = 'Canada';

  static const Map<String, Map<String, RefValue>> values = {
    'naissance': {
      usa: RefValue(0.106, 'Census Bureau, Business Dynamics Statistics 2023 : taux d’entrée des établissements'),
      france: RefValue(0.158, 'Insee Première n° 2097 (2026) : taux d’entrée 2023, entreprises économiquement actives'),
      canada: RefValue(0.123, 'Statistique Canada, Le Quotidien du 12 février 2026 : taux d’entrée 2023, secteur privé'),
    },
    'mort': {
      usa: RefValue(0.094, 'Census Bureau, Business Dynamics Statistics 2023 : taux de sortie des établissements'),
      france: RefValue(0.117, 'Insee Première n° 2097 (2026) : taux de sortie 2022, entreprises économiquement actives'),
      canada: RefValue(0.119, 'Statistique Canada, Le Quotidien du 12 février 2026 : taux de sortie 2023, secteur privé'),
    },
    'survie1': {
      usa: RefValue(0.809, 'BLS, Business Employment Dynamics, table 7 : établissements ouverts d’avril 2019 à mars 2020'),
      france: RefValue(0.946, 'Insee Première n° 2070 (2025) : entreprises créées en 2018, hors micro-entrepreneurs'),
      canada: RefValue(0.831, 'Statistique Canada, Le Quotidien du 12 novembre 2025 : entreprises employeuses créées en 2022'),
    },
    'survie3': {
      usa: RefValue(0.636, 'BLS, Business Employment Dynamics, table 7 : établissements ouverts d’avril 2019 à mars 2020'),
      france: RefValue(0.813, 'Insee Première n° 2070 (2025) : entreprises créées en 2018, hors micro-entrepreneurs'),
    },
    'survie5': {
      usa: RefValue(0.513, 'BLS, Business Employment Dynamics, table 7 : établissements ouverts d’avril 2019 à mars 2020'),
      france: RefValue(0.690, 'Insee Première n° 2070 (2025) : entreprises créées en 2018, hors micro-entrepreneurs'),
      canada: RefValue(0.68, 'ISDE, Principales statistiques relatives aux petites entreprises 2025, données de Statistique '
          'Canada : 69,7 % (biens) et 67,5 % (services), entreprises de 1 à 99 employés, cohortes 2001 à 2022'),
    },
  };

  /// Texte de l'infobulle : la simulation, puis chaque pays avec sa source.
  static String tooltip(String key, String simLabel, String simValue, {String? note}) {
    final b = StringBuffer('$simLabel\nSimulation : $simValue');
    final m = values[key];
    if (m != null) {
      b.write('\n');
      for (final c in const [usa, france, canada]) {
        final r = m[c];
        b.write('\n$c : ${r == null ? 'pas de chiffre publié comparable' : pct(r.value)}');
        if (r != null) b.write('\n   ${r.source}');
      }
    }
    if (note != null) b.write('\n\n$note');
    return b.toString();
  }
}

// ------------------------------------------------------------------ onglet

class FirmsTab extends StatelessWidget {
  final SimController ctrl;
  const FirmsTab(this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final log = ctrl.firmLog;
    final w = log.window();
    final today = sim.day;
    final partial = w.days < FirmLog.year;
    final span = partial ? ' (annualisé sur ${w.days} j)' : '';

    // entreprises actives : aujourd'hui et il y a un an
    final nAct = log.active.isEmpty ? 0.0 : log.active.last;
    final nAll = log.firms.isEmpty ? 0.0 : log.firms.last;
    final ago = log.active.length > FirmLog.year ? log.active[log.active.length - 1 - FirmLog.year] : null;

    // âge moyen des entreprises vivantes (âge connu)
    var ageSum = 0.0, ageN = 0, youngN = 0;
    for (final l in log.lives.values) {
      if (l.died != null || l.born == null) continue;
      ageSum += (today - l.born!) / FirmLog.year;
      ageN++;
      if (l.newborn) youngN++;
    }

    // causes de disparition depuis le début du suivi
    final causes = <String, int>{};
    var deadAll = 0, takeAll = 0;
    for (final l in log.lives.values) {
      takeAll += l.takeovers;
      if (l.died == null) continue;
      deadAll++;
      final c = l.cause ?? 'autre';
      causes[c] = (causes[c] ?? 0) + 1;
    }
    final cash = causes['faillite'] ?? 0;

    Widget ref(String label, String value, String key, {String? note, Color? color}) => Tooltip(
          message: FirmRefs.tooltip(key, label, value, note: note),
          waitDuration: const Duration(milliseconds: 250),
          showDuration: const Duration(seconds: 30),
          textStyle: const TextStyle(fontSize: 11.5, color: Colors.white, height: 1.35),
          child: Row(children: [
            Expanded(child: KV(label, value, color: color)),
            const SizedBox(width: 4),
            Icon(Icons.info_outline, size: 14, color: pal.ink3),
          ]),
        );

    String surv(int k) {
      final r = log.survival(today, k);
      return r == null ? '—' : '${pct(r.rate)} (${r.atRisk})';
    }

    const survNote = 'Simulation : entreprises nées pendant la partie, estimateur de Kaplan-Meier (toutes les cohortes '
        'servent ; une entreprise encore vivante compte jusqu’à son âge d’aujourd’hui). Entre parenthèses, le nombre '
        'd’entreprises suivies jusqu’à cet âge : en dessous d’une vingtaine, le chiffre est fragile. Les entreprises du plan '
        'de départ ne comptent pas. « — » : aucune entreprise née n’a encore pu être suivie aussi longtemps.';

    // concentration par secteur : producteurs actifs et part du premier dans les recettes lissées
    final bySector = <String, List<Firm>>{};
    for (final f in sim.firms) {
      if (sim.publicService(f) || f.workers.isEmpty) continue;
      (bySector[f.type] ??= []).add(f);
    }
    final sectors = [
      for (final e in bySector.entries)
        () {
          final tot = e.value.fold(0.0, (a, f) => a + (f.revenueEma > 0 ? f.revenueEma : 0));
          var top = 0.0, hhi = 0.0;
          for (final f in e.value) {
            final sh = tot > 0 ? (f.revenueEma > 0 ? f.revenueEma : 0) / tot : 1 / e.value.length;
            if (sh > top) top = sh;
            hhi += sh * sh;
          }
          return (type: e.key, n: e.value.length, top: top, hhi: hhi);
        }()
    ]..sort((a, b) => a.n != b.n ? a.n.compareTo(b.n) : b.top.compareTo(a.top));
    final monopolies = sectors.where((x) => x.n == 1).length;

    Widget row(List<String> cells, {bool head = false}) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.5),
          child: Row(children: [
            for (var k = 0; k < cells.length; k++)
              Expanded(
                  flex: k == 0 ? 4 : 2,
                  child: Text(cells[k],
                      textAlign: k == 0 ? TextAlign.left : TextAlign.right,
                      style: head
                          ? TextStyle(color: pal.ink3, fontSize: 11, fontWeight: FontWeight.w600)
                          : mono(pal.ink, 11.5))),
          ]),
        );

    return ListView(padding: const EdgeInsets.all(12), children: [
      Text(
          'Entreprises privées seulement (les établissements publics ne naissent ni ne meurent). Un an = 365 jours de '
          'simulation. Survolez une ligne marquée ⓘ pour comparer aux États-Unis, à la France et au Canada.',
          style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
      const SizedBox(height: 8),
      Section('Naissances et morts (année glissante)', [
        ref('Taux de naissance annuel$span', pct(w.birthRate), 'naissance',
            note: 'Simulation : naissances des 365 derniers jours rapportées au nombre moyen d’entreprises privées '
                '(${w.births} naissances, ${fmtNum(w.meanFirms, 0)} entreprises en moyenne). Les définitions réelles '
                'diffèrent : établissements aux États-Unis, entreprises économiquement actives en France '
                '(micro-entrepreneurs compris), entreprises employeuses au Canada.'),
        ref('Taux de mort annuel$span', pct(w.deathRate), 'mort',
            note: 'Simulation : fermetures des 365 derniers jours (${w.deaths}) rapportées au nombre moyen d’entreprises '
                'privées.'),
        Tooltip(
          message: 'Un rachat est un changement de propriétaire : quand le propriétaire n’a plus les moyens de renflouer '
              'son entreprise, un autre citoyen la rachète (filet de renflouement). L’entreprise continue : ce n’est pas '
              'une disparition. Pas de repère réel comparable (les statistiques officielles excluent les fusions et '
              'les reprises des naissances et des morts).',
          waitDuration: const Duration(milliseconds: 250),
          showDuration: const Duration(seconds: 30),
          child: Row(children: [
            Expanded(child: KV('Rachats par an$span', '${pct(w.takeoverRate)} (${w.takeovers})')),
            const SizedBox(width: 4),
            Icon(Icons.info_outline, size: 14, color: pal.ink3),
          ]),
        ),
        KV('Entreprises actives (au moins un employé)', '${fmtNum(nAct, 0)} sur ${fmtNum(nAll, 0)}'),
        KV('Variation sur un an',
            ago == null ? '—' : '${nAct - ago >= 0 ? '+' : ''}${fmtNum(nAct - ago, 0)} (${pct(ago > 0 ? (nAct - ago) / ago : 0)})'),
      ]),
      ChartCard(
          title: 'Taux annuels sur l’année glissante (à partir du jour 365)',
          unit: '%',
          minY: 0,
          series: [
            Series('naissances', pal.ok, downsample(log.birthRate)),
            Series('morts', pal.bad, downsample(log.deathRate)),
          ]),
      ChartCard(title: 'Entreprises privées', minY: 0, series: [
        Series('toutes', pal.ink3, downsample(log.firms)),
        Series('actives', pal.accent, downsample(log.active)),
      ]),
      Section('Survie et âge', [
        ref('Survie à 1 an', surv(1), 'survie1', note: survNote),
        ref('Survie à 3 ans', surv(3), 'survie3', note: survNote),
        ref('Survie à 5 ans', surv(5), 'survie5', note: survNote),
        Tooltip(
          message: 'Âge moyen des entreprises privées vivantes aujourd’hui. Les entreprises du plan de départ ont l’âge '
              'de la partie : au début, l’âge moyen ne fait que monter. Pas de repère réel comparable dans les sources '
              'retenues.',
          waitDuration: const Duration(milliseconds: 250),
          showDuration: const Duration(seconds: 30),
          child: Row(children: [
            Expanded(
                child: KV('Âge moyen des entreprises vivantes', ageN == 0 ? '—' : '${fmtNum(ageSum / ageN, 1)} ans')),
            const SizedBox(width: 4),
            Icon(Icons.info_outline, size: 14, color: pal.ink3),
          ]),
        ),
        KV('Vivantes nées pendant la partie', ageN == 0 ? '—' : '$youngN sur $ageN (${pct(youngN / ageN)})'),
      ]),
      Section('Causes de disparition (depuis le début)', [
        Text(
            'Une entreprise ferme après ${sim.params.exitIdleDays} jours sans employé. La cause est ce qui l’y a menée : '
            'trésorerie à sec (elle ne pouvait plus payer ses salaires) ou fermeture faute d’activité (demande perdue, '
            'plus d’employé, prix aberrant).',
            style: TextStyle(color: pal.ink3, fontSize: 11, height: 1.35)),
        const SizedBox(height: 4),
        KV('Disparitions', '$deadAll'),
        KV('Trésorerie à sec', deadAll == 0 ? '—' : '$cash (${pct(cash / deadAll)})'),
        KV('Fermeture faute d’activité', deadAll == 0 ? '—' : '${deadAll - cash} (${pct((deadAll - cash) / deadAll)})'),
        for (final c in const ['demande_perdue', 'sans_employe', 'prix_aberrant', 'autre'])
          if ((causes[c] ?? 0) > 0) KV('   dont ${SimEntrepreneurship.closeReasons[c] ?? c}', '${causes[c]}'),
        KV('Rachats (changements de propriétaire)', '$takeAll'),
      ]),
      Section('Concentration par secteur', [
        KV('Secteurs avec un seul producteur actif', '$monopolies sur ${sectors.length}'),
        const SizedBox(height: 4),
        row(['Secteur', 'Actives', 'Part du 1er', 'HHI'], head: true),
        for (final x in sectors)
          row([
            templates[x.type]?.label ?? x.type,
            '${x.n}',
            pct(x.top),
            fmtNum(x.hhi * 10000, 0),
          ]),
        const SizedBox(height: 4),
        Text(
            'Part du premier : part des recettes lissées du secteur faites par son plus gros producteur. HHI : indice de '
            'Herfindahl-Hirschman (somme des carrés des parts, sur 10 000 ; 10 000 pour un monopole). Les lignes directrices '
            'américaines sur les fusions disent très concentré un marché au-delà de 1 800 (2023 ; 2 500 en 2010).',
            style: TextStyle(color: pal.ink3, fontSize: 11, height: 1.35)),
      ]),
    ]);
  }
}
