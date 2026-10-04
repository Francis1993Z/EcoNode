// Détecteurs d'anomalies : vérifiés chaque jour, ouverts après une durée de persistance,
// fermés dès que la condition cesse. Chaque alerte dit quoi, depuis quand, la valeur, le seuil
// et les agents impliqués ; ouverture et fermeture sont inscrites au journal.

import 'dart:math' as math;

import 'model.dart';
import 'sim.dart';

/// Seuils des détecteurs (valeurs du cahier des charges de stabilisation).
class MonitorConfig {
  double unempHigh = 0.30; // chômage > 30 %…
  int unempDays = 30; // … pendant 30 jours consécutifs
  int fullEmploymentDays = 30; // chômage nul pendant 30 jours consécutifs
  double distressShare = 0.05; // plus de 5 % des citoyens affamés (ou sans logis)…
  int distressDays = 3; // … pendant 3 jours
  double giniHigh = 0.6;
  double giniLow = 0.05;
  int giniDays = 7;
  double medianLowDays = 3; // richesse médiane < 3 jours de besoins…
  double medianHighDays = 365; // … ou > 365 jours
  int medianDays = 7;
  double inflationDaily = 0.05; // indice des prix ±5 % en un jour
  double inflation100 = 1.0; // ±100 % sur 100 jours
  int stockEmptyDays = 10; // stock vide pendant plus de 10 jours
  double stockFullDays = 30; // plus de 30 jours de ventes en stock…
  int stockFullPersist = 10; // … pendant 10 jours
  int noStaffDays = 15; // sans employé pendant plus de 15 jours
  int noClientDays = 15; // sans client pendant plus de 15 jours
  double invariantTol = 1e-6; // écart comptable toléré ($)
}

const Map<String, String> alertLabels = {
  'chomageHaut': 'Chômage très élevé',
  'pleinEmploi': 'Chômage nul prolongé',
  'faim': 'Faim répandue',
  'sansAbri': 'Sans-abri nombreux',
  'gini': 'Inégalités hors bornes',
  'mediane': 'Richesse médiane hors bornes',
  'inflationJour': 'Inflation quotidienne',
  'inflation100': 'Inflation sur 100 jours',
  'stockVide': 'Rupture de stock prolongée',
  'stockPlein': 'Surstock',
  'sansEmploye': 'Entreprise sans employé',
  'sansClient': 'Entreprise sans client',
  'invariant': 'Invariant comptable rompu',
};

/// Alertes critiques : aucune ne doit apparaître dans une partie stable.
const Set<String> criticalAlerts = {'chomageHaut', 'faim', 'sansAbri', 'inflationJour', 'inflation100', 'invariant'};

class Monitor {
  MonitorConfig cfg = MonitorConfig();
  final Map<String, Alert> active = {};
  final List<Alert> closed = [];
  final Map<String, int> opened = {}; // ouvertures par type
  final Map<String, int> alertDays = {}; // jours-alerte par type
  final Map<String, int> _streak = {};

  void clear() {
    active.clear();
    closed.clear();
    opened.clear();
    alertDays.clear();
    _streak.clear();
  }

  int get criticalCount => active.values.where((a) => a.critical).length;

  /// Alertes actives, les critiques d'abord, puis les plus anciennes.
  List<Alert> get sorted => active.values.toList()
    ..sort((a, b) => a.critical != b.critical ? (a.critical ? -1 : 1) : a.since.compareTo(b.since));

  void check(Sim s) {
    final c = cfg;
    final seen = <String>{};

    void cond(String key, String type, bool on, int persist, double value, double threshold, String Function() what,
        List<String> Function() agents) {
      if (!on) return;
      seen.add(key);
      final st = (_streak[key] ?? 0) + 1;
      _streak[key] = st;
      if (st < persist) return;
      final a = active[key];
      if (a == null) {
        final na = Alert(key, type, criticalAlerts.contains(type), s.day - st + 1, what(), value, threshold, agents());
        active[key] = na;
        opened[type] = (opened[type] ?? 0) + 1;
        s.logAlert(na, opened: true);
      } else {
        a.what = what();
        a.value = value;
        a.threshold = threshold;
        if (s.day % 5 == 0) a.agents = agents();
      }
      alertDays[type] = (alertDays[type] ?? 0) + 1;
    }

    final h = s.history.last;
    final n = s.citizens.length;

    // ---- chômage
    cond('chomageHaut', 'chomageHaut', h.unemp > c.unempHigh, c.unempDays, h.unemp, c.unempHigh,
        () => 'chômage à ${fmtPct(h.unemp)} (seuil ${fmtPct(c.unempHigh, 0)}, ${c.unempDays} j de suite)',
        () => _shrinking(s));
    cond('pleinEmploi', 'pleinEmploi', n > 0 && h.unemp <= 0, c.fullEmploymentDays, h.unemp, 0,
        () => 'aucun chômeur depuis ${c.fullEmploymentDays} j ; ${_vacancies(s)} postes vacants', () => _hiring(s));

    // ---- détresse
    if (n > 0) {
      final hungry = s.citizens.where((x) => x.hungerDays >= 1).toList();
      final hs = hungry.length / n;
      cond('faim', 'faim', hs > c.distressShare, c.distressDays, hs, c.distressShare,
          () => '${hungry.length} citoyens ont faim (${fmtPct(hs)}, seuil ${fmtPct(c.distressShare, 0)})',
          () => _people(hungry, (x) => x.hungerDays, s.famineCause));
      final homeless = s.citizens.where((x) => x.homeless).toList();
      final ss = homeless.length / n;
      cond('sansAbri', 'sansAbri', ss > c.distressShare, c.distressDays, ss, c.distressShare,
          () => '${homeless.length} citoyens sans logis (${fmtPct(ss)}, seuil ${fmtPct(c.distressShare, 0)})',
          () => _people(homeless, (x) => x.homelessDays, s.shelterCause));
    }

    // ---- inégalités et richesse médiane
    cond('gini', 'gini', h.gini > c.giniHigh || h.gini < c.giniLow, c.giniDays, h.gini,
        h.gini > c.giniHigh ? c.giniHigh : c.giniLow,
        () => 'Gini ${_dec(h.gini, 3)} (bornes ${_dec(c.giniLow, 2)}–${_dec(c.giniHigh, 2)})', () => _richest(s));
    if (n > 0 && s.needCost > 0) {
      final days = s.medianWealth() / s.needCost;
      final low = days < c.medianLowDays;
      cond('mediane', 'mediane', low || days > c.medianHighDays, c.medianDays, days,
          low ? c.medianLowDays : c.medianHighDays,
          () => 'richesse médiane = ${_dec(days, 1)} jours de besoins '
              '(bornes ${_dec(c.medianLowDays, 0)}–${_dec(c.medianHighDays, 0)})',
          () => const []);
    }

    // ---- inflation (indice des prix du panier des ménages)
    final hist = s.history;
    if (hist.length >= 2) {
      final prev = hist[hist.length - 2];
      final d1 = prev.cpi > 0 ? h.cpi / prev.cpi - 1 : 0.0;
      cond('inflationJour', 'inflationJour', d1.abs() > c.inflationDaily, 1, d1, c.inflationDaily,
          () => 'indice des prix ${_signed(d1)} en un jour (seuil ±${fmtPct(c.inflationDaily, 0)})',
          () => _movers(s, prev, h));
    }
    if (hist.length > 100) {
      final old = hist[hist.length - 101];
      final d100 = old.cpi > 0 ? h.cpi / old.cpi - 1 : 0.0;
      cond('inflation100', 'inflation100', d100.abs() > c.inflation100, 1, d100, c.inflation100,
          () => 'indice des prix ${_signed(d100)} en 100 jours (seuil ±${fmtPct(c.inflation100, 0)})',
          () => _movers(s, old, h));
    }

    // ---- entreprises
    for (final f in s.firms) {
      final g = f.g0;
      if (!goods[g]!.perish) {
        final stock = f.inv[g] ?? 0;
        cond('stockVide:${f.id}', 'stockVide', stock < 1, c.stockEmptyDays + 1, stock, 1,
            () => '${f.name} : stock de ${goods[g]!.label.toLowerCase()} vide depuis plus de ${c.stockEmptyDays} j',
            () => [f.name]);
        final days = stock / math.max(f.demandEma[g] ?? 0, 0.05);
        cond('stockPlein:${f.id}', 'stockPlein', days > c.stockFullDays, c.stockFullPersist, days, c.stockFullDays,
            () => '${f.name} : ${_dec(days, 0)} jours de ventes en stock (seuil ${_dec(c.stockFullDays, 0)})',
            () => [f.name]);
      }
      cond('sansEmploye:${f.id}', 'sansEmploye', f.workers.isEmpty, c.noStaffDays + 1, 0, 0,
          () => '${f.name} n’a plus d’employé depuis plus de ${c.noStaffDays} j', () => [f.name]);
      var sold = 0.0;
      for (final v in f.sold.values) {
        sold += v;
      }
      cond('sansClient:${f.id}', 'sansClient', sold <= eps, c.noClientDays + 1, 0, 0,
          () => '${f.name} n’a rien vendu depuis plus de ${c.noClientDays} j', () => [f.name]);
    }

    // ---- invariant comptable
    final inv = s.inv;
    final w = inv.worst;
    cond('invariant', 'invariant', w > c.invariantTol, 1, w, c.invariantTol,
        () => 'écart de ${w.toStringAsExponential(2)} \$ (seuil ${c.invariantTol.toStringAsExponential(0)} \$)',
        () => [
              'masse ${inv.money.toStringAsExponential(2)}',
              'prêts ${inv.loans.toStringAsExponential(2)}',
              'bilan ${inv.bank.toStringAsExponential(2)}',
              'ΔM ${inv.flows.toStringAsExponential(2)}',
            ]);

    // fermer les alertes dont la condition ne tient plus
    for (final k in active.keys.toList()) {
      if (seen.contains(k)) continue;
      final a = active.remove(k)!;
      a.until = s.day;
      closed.add(a);
      if (closed.length > 300) closed.removeAt(0);
      s.logAlert(a, opened: false);
    }
    _streak.removeWhere((k, v) => !seen.contains(k));
  }

  // ---------------------------------------------------------------- agents impliqués

  static String _dec(double v, int d) => v.toStringAsFixed(d).replaceAll('.', ',');
  static String _signed(double v) => '${v >= 0 ? '+' : ''}${fmtPct(v)}';

  static int _vacancies(Sim s) => s.firms.fold(0, (a, f) => a + f.vacancies);

  /// Entreprises qui ont le plus réduit leurs effectifs en 30 jours.
  static List<String> _shrinking(Sim s) {
    final drops = <Firm, int>{};
    for (final f in s.firms) {
      if (f.hist.length < 31) continue;
      final d = f.hist[f.hist.length - 31].workers - f.workers.length;
      if (d > 0) drops[f] = d;
    }
    final l = drops.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return [for (final e in l.take(4)) '${e.key.name} (−${e.value} empl. en 30 j)'];
  }

  /// Entreprises qui cherchent à embaucher.
  static List<String> _hiring(Sim s) {
    final l = s.firms.where((f) => f.vacancies > 0).toList()..sort((a, b) => b.vacancies.compareTo(a.vacancies));
    return [for (final f in l.take(4)) '${f.name} (${f.vacancies} poste(s), ${f.unfilledDays} j)'];
  }

  /// Citoyens en détresse : résumé des causes, puis les cas les plus anciens.
  static List<String> _people(List<Citizen> list, int Function(Citizen) days, String Function(Citizen) cause) {
    final causes = <String, int>{};
    for (final c in list) {
      final k = cause(c);
      causes[k] = (causes[k] ?? 0) + 1;
    }
    final cs = causes.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final sorted = List<Citizen>.from(list)..sort((a, b) => days(b).compareTo(days(a)));
    return [
      'causes : ${cs.map((e) => '${e.key} ×${e.value}').join(', ')}',
      for (final c in sorted.take(5)) '${c.name} (${days(c)} j, ${cause(c)})',
    ];
  }

  /// Citoyens les plus riches et leur part de la richesse.
  static List<String> _richest(Sim s) {
    var total = 0.0;
    for (final c in s.citizens) {
      total += math.max(0.0, c.money);
    }
    final l = List<Citizen>.from(s.citizens)..sort((a, b) => b.money.compareTo(a.money));
    return [for (final c in l.take(3)) '${c.name} (${fmtPct(total > 0 ? c.money / total : 0.0)} de la richesse)'];
  }

  /// Biens du panier dont le prix a le plus varié entre deux relevés.
  static List<String> _movers(Sim s, HistPoint a, HistPoint b) {
    final ch = <String, double>{};
    for (final g in s.cpiWeights.keys) {
      final pa = a.prices[g] ?? 0, pb = b.prices[g] ?? 0;
      if (pa > 0) ch[g] = pb / pa - 1;
    }
    final l = ch.entries.toList()..sort((x, y) => y.value.abs().compareTo(x.value.abs()));
    return [for (final e in l.take(4)) '${goods[e.key]!.label} ${_signed(e.value)}'];
  }
}
