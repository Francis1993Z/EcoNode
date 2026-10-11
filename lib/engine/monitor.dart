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
  // causes plutôt que conséquences (état des lieux du 10 octobre 2026)
  double healthLow = 0.5; // santé moyenne de la population < 0,5…
  int healthDays = 30; // … pendant 30 jours
  double efficiencyLow = 0.7; // efficacité moyenne des employés < 0,7…
  int efficiencyDays = 30; // … pendant 30 jours
  // Postes ouverts restés non pourvus > 5 % de la demande de travail (employés + postes non pourvus)… Repère : le taux
  // de postes vacants record au Canada, 5,7 % au 2e trimestre 2022, période décrite comme une pénurie (Statistique Canada).
  double laborShortage = 0.05;
  int laborShortageDays = 30; // … pendant 30 jours
  // Postes voulus mais non ouverts faute de trésorerie > 10 % de la population (le seuil de départ du détecteur de
  // pénurie, qui mesurait surtout ce cas : dans le noyau, des entreprises sans employé ni argent)…
  double blockedHiring = 0.10;
  int blockedHiringDays = 30; // … pendant 30 jours
  // Attente moyenne d'un service public (hôpital, école) > 7 jours… Raison : les maladies et les envies de cours
  // arrivent au hasard, une file d'un ou deux jours est normale ; au-delà d'une semaine en moyenne, la capacité ou
  // l'enveloppe est durablement insuffisante.
  double waitLong = 7;
  int waitDays = 30; // … pendant 30 jours
  double priceAberrant = 5; // prix > 5 fois le prix de référence corrigé des salaires…
  int priceAberrantDays = 30; // … pendant 30 jours (entreprise active)
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
  'caisse': 'Caisse insolvable',
  'sante': 'Santé de la population effondrée',
  'efficacite': 'Productivité du travail effondrée',
  'penurieTravail': 'Pénurie de main-d’œuvre',
  'embaucheBloquee': 'Embauches bloquées faute de moyens',
  'prixAberrant': 'Prix aberrant',
  'attente': 'Attente trop longue (service public)',
  'prestations': 'Prestations réduites faute de trésor',
};

/// Alertes critiques : aucune ne doit apparaître dans une partie stable.
/// La santé effondrée est une détresse de la population, comme la faim : elle est critique.
const Set<String> criticalAlerts = {
  'chomageHaut', 'faim', 'sansAbri', 'sante', 'inflationJour', 'inflation100', 'invariant',
};

/// Une ligne de la liste des agents impliqués : le texte, et l'agent qu'il cite (pour ouvrir son inspecteur).
typedef AgentLine = (String, AgentRef?);

AgentRef _firm(Firm f) => AgentRef('firm', f.id);
AgentRef _citizen(Citizen c) => AgentRef('citizen', c.id);
List<AgentLine> _plain(List<String> l) => [for (final t in l) (t, null)];

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

  /// État du moniteur pour un instantané (snapshot.dart) : seuils, alertes, compteurs, séries de jours en cours.
  Map<String, dynamic> toJson() => {
        'cfg': _cfgJson(cfg),
        'active': [for (final a in active.values) _alertJson(a)],
        'closed': [for (final a in closed) _alertJson(a)],
        'opened': opened,
        'alertDays': alertDays,
        'streak': _streak,
      };

  void loadJson(Map j) {
    clear();
    cfg = _cfgFrom(j['cfg'] as Map);
    for (final a in j['active'] as List) {
      final x = _alertFrom(a as Map);
      active[x.key] = x;
    }
    closed.addAll([for (final a in j['closed'] as List) _alertFrom(a as Map)]);
    for (final e in (j['opened'] as Map).entries) {
      opened[e.key as String] = e.value as int;
    }
    for (final e in (j['alertDays'] as Map).entries) {
      alertDays[e.key as String] = e.value as int;
    }
    for (final e in (j['streak'] as Map).entries) {
      _streak[e.key as String] = e.value as int;
    }
  }

  int get criticalCount => active.values.where((a) => a.critical).length;

  /// Alertes actives, les critiques d'abord, puis les plus anciennes.
  List<Alert> get sorted => active.values.toList()
    ..sort((a, b) => a.critical != b.critical ? (a.critical ? -1 : 1) : a.since.compareTo(b.since));

  void check(Sim s) {
    final c = cfg;
    final seen = <String>{};

    void cond(String key, String type, bool on, int persist, double value, double threshold, String Function() what,
        List<AgentLine> Function() agents, {AgentRef? subject}) {
      if (!on) return;
      seen.add(key);
      final st = (_streak[key] ?? 0) + 1;
      _streak[key] = st;
      if (st < persist) return;
      final a = active[key];
      if (a == null) {
        final l = agents();
        final na = Alert(key, type, criticalAlerts.contains(type), s.day - st + 1, what(), value, threshold,
            [for (final x in l) x.$1], refs: [for (final x in l) x.$2], subject: subject);
        active[key] = na;
        opened[type] = (opened[type] ?? 0) + 1;
        s.logAlert(na, opened: true);
      } else {
        a.what = what();
        a.value = value;
        a.threshold = threshold;
        if (s.day % 5 == 0) {
          final l = agents();
          a.agents = [for (final x in l) x.$1];
          a.refs = [for (final x in l) x.$2];
        }
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

    // ---- santé et productivité du travail
    if (n > 0 && s.modules.health) {
      var sum = 0.0;
      var low = 0;
      for (final x in s.citizens) {
        sum += x.health;
        if (x.health < 0.75) low++;
      }
      final avg = sum / n;
      cond('sante', 'sante', avg < c.healthLow, c.healthDays, avg, c.healthLow,
          () => 'santé moyenne ${_dec(avg, 2)} (seuil ${_dec(c.healthLow, 2)}, ${c.healthDays} j de suite) ; '
              '${fmtPct(low / n, 0)} des citoyens ont besoin de soins',
          () => _hospitals(s));
    }
    final employed = s.citizens.where((x) => x.employer != null).toList();
    if (employed.isNotEmpty) {
      var eff = 0.0, faim = 0.0, logement = 0.0, sante = 0.0, moral = 0.0;
      for (final x in employed) {
        final k = s.efficiencyFactors(x);
        eff += k.faim * k.logement * k.sante * k.moral;
        faim += k.faim;
        logement += k.logement;
        sante += k.sante;
        moral += k.moral;
      }
      final m = employed.length;
      final avg = eff / m;
      cond('efficacite', 'efficacite', avg < c.efficiencyLow, c.efficiencyDays, avg, c.efficiencyLow,
          () => 'efficacité moyenne des employés ${_dec(avg, 2)} (seuil ${_dec(c.efficiencyLow, 2)}, '
              '${c.efficiencyDays} j de suite) : un poste demande ${_dec(1 / avg, 1)} employé(s)',
          () => _plain(_factors({'santé': sante / m, 'faim': faim / m, 'logement': logement / m, 'moral': moral / m})));
    }

    // ---- marché du travail : postes ouverts que personne ne vient pourvoir (pénurie), et postes voulus que les
    // entreprises n'ont pas les moyens d'ouvrir (problème de financement, pas de main-d'œuvre)
    if (n > 0) {
      var unfilled = 0, blocked = 0;
      for (final f in s.firms) {
        if (f.vacancies > 0 && f.unfilledDays >= 1) unfilled += f.vacancies;
        final gap = f.desired - f.workers.length;
        if (gap > f.vacancies && s.affordablePosts(f) < math.min(gap, 3)) blocked += gap - f.vacancies;
      }
      final employed = s.citizens.where((x) => x.employer != null).length;
      final rate = unfilled > 0 ? unfilled / (employed + unfilled) : 0.0;
      final idle = n - employed;
      cond('penurieTravail', 'penurieTravail', rate > c.laborShortage, c.laborShortageDays, rate, c.laborShortage,
          () => '$unfilled postes ouverts restent non pourvus : ${fmtPct(rate)} de la demande de travail '
              '(seuil ${fmtPct(c.laborShortage, 0)}) ; $idle chômeur(s)',
          () => _unfilled(s));
      final share = blocked / n;
      cond('embaucheBloquee', 'embaucheBloquee', share > c.blockedHiring, c.blockedHiringDays, share, c.blockedHiring,
          () => 'les entreprises voudraient $blocked employés de plus sans avoir en caisse de quoi ouvrir les postes '
              '(${fmtPct(share, 0)} de la population, seuil ${fmtPct(c.blockedHiring, 0)})',
          () => _blocked(s));
    }

    // ---- prestations aux sans-emploi versées en partie seulement : le trésor ne suffit plus
    final cut = s.state.benefitCut;
    cond('prestations', 'prestations', cut < 1 - 1e-9, 1, cut, 1,
        () => 'le trésor ne verse que ${fmtPct(cut)} des prestations dues aux sans-emploi '
            '(trésor ${fmtMoney0(s.state.money)})',
        () => _plain([
              if (s.modules.insurance) '${s.state.eiClaimants} prestataires de l’assurance-emploi',
              if (s.modules.insurance) '${s.state.assistRecipients} bénéficiaires de l’aide sociale',
            ]));

    // ---- services publics : attente
    for (final g in const ['soins', 'cours']) {
      if (!s.publicGood(g)) continue;
      final st = s.services[g]!;
      final who = g == 'soins' ? 'Hôpital public' : 'École publique';
      cond('attente:$g', 'attente', st.wait > c.waitLong, c.waitDays, st.wait, c.waitLong,
          () => '$who : attente moyenne ${_dec(st.wait, 1)} j (seuil ${_dec(c.waitLong, 0)} j) ; ${st.queue} personne(s) '
              'en file ; enveloppe du jour ${fmtMoney0(st.envelopeToday)}'
              '${st.envelopeToday + 1 < st.wantedToday ? ' sur ${fmtMoney0(st.wantedToday)} voulus (trésor insuffisant)' : ''}',
          () => _providers(s, g));
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
          () => _plain(_movers(s, prev, h)));
    }
    if (hist.length > 100) {
      final old = hist[hist.length - 101];
      final d100 = old.cpi > 0 ? h.cpi / old.cpi - 1 : 0.0;
      cond('inflation100', 'inflation100', d100.abs() > c.inflation100, 1, d100, c.inflation100,
          () => 'indice des prix ${_signed(d100)} en 100 jours (seuil ±${fmtPct(c.inflation100, 0)})',
          () => _plain(_movers(s, old, h)));
    }

    // ---- entreprises
    for (final f in s.firms) {
      final g = f.g0;
      if (!goods[g]!.perish) {
        final stock = f.inv[g] ?? 0;
        cond('stockVide:${f.id}', 'stockVide', stock < 1, c.stockEmptyDays + 1, stock, 1,
            () => '${f.name} : stock de ${goods[g]!.label.toLowerCase()} vide depuis plus de ${c.stockEmptyDays} j',
            () => [(f.name, _firm(f))], subject: _firm(f));
        final days = stock / math.max(f.demandEma[g] ?? 0, 0.05);
        cond('stockPlein:${f.id}', 'stockPlein', days > c.stockFullDays, c.stockFullPersist, days, c.stockFullDays,
            () => '${f.name} : ${_dec(days, 0)} jours de ventes en stock (seuil ${_dec(c.stockFullDays, 0)})',
            () => [(f.name, _firm(f))], subject: _firm(f));
      }
      cond('sansEmploye:${f.id}', 'sansEmploye', f.workers.isEmpty, c.noStaffDays + 1, 0, 0,
          () => '${f.name} n’a plus d’employé depuis plus de ${c.noStaffDays} j', () => [(f.name, _firm(f))],
          subject: _firm(f));
      var sold = 0.0;
      for (final v in f.sold.values) {
        sold += v;
      }
      cond('sansClient:${f.id}', 'sansClient', sold <= eps, c.noClientDays + 1, 0, 0,
          () => '${f.name} n’a rien vendu depuis plus de ${c.noClientDays} j', () => [(f.name, _firm(f))],
          subject: _firm(f));
      // prix aberrant : bien au-dessus du prix d'équilibre du départ, corrigé de la hausse des salaires
      if (f.workers.isNotEmpty) {
        final ref = s.referencePrice(g);
        final ratio = ref > 0 ? f.price[g]! / ref : 0.0;
        cond('prixAberrant:${f.id}', 'prixAberrant', ratio > c.priceAberrant, c.priceAberrantDays, ratio,
            c.priceAberrant, () {
          final cap = math.max(1, f.workers.length) * s.perWorker(f);
          final util = cap > 0 ? f.outputEma / cap : 0.0;
          return '${f.name} : ${goods[g]!.label.toLowerCase()} à ${_money(f.price[g]!)}, ${_dec(ratio, 1)} fois la '
              'référence (${_money(ref)}, corrigée des salaires) depuis ${c.priceAberrantDays} j ; coût de revient '
              '${_money(f.unitCostCache[g] ?? 0)}, équipe utilisée à ${fmtPct(math.min(util, 9.99), 0)}'
              '${f.inputLimited ? ', limitée par ses intrants' : ''}';
        }, () => [(f.name, _firm(f))], subject: _firm(f));
      }
    }

    // ---- Caisse : fonds propres négatifs (radiations supérieures au capital et aux intérêts retenus)
    cond('caisse', 'caisse', s.bank.equity < 0, 1, s.bank.equity, 0,
        () => 'fonds propres de ${fmtMoney0(s.bank.equity)} pour ${fmtMoney0(s.totalDebt())} de prêts',
        () => [
              for (final f in s.firms.where((f) => f.missedPayments > 0).take(4))
                ('${f.name} (${f.missedPayments} j de retard)', _firm(f))
            ]);

    // ---- invariant comptable
    final inv = s.inv;
    final w = inv.worst;
    cond('invariant', 'invariant', w > c.invariantTol, 1, w, c.invariantTol,
        () => 'écart de ${w.toStringAsExponential(2)} \$ (seuil ${c.invariantTol.toStringAsExponential(0)} \$)',
        () => _plain([
              'masse ${inv.money.toStringAsExponential(2)}',
              'prêts ${inv.loans.toStringAsExponential(2)}',
              'bilan ${inv.bank.toStringAsExponential(2)}',
              'ΔM ${inv.flows.toStringAsExponential(2)}',
            ]));

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
  static List<AgentLine> _shrinking(Sim s) {
    final drops = <Firm, int>{};
    for (final f in s.firms) {
      if (f.hist.length < 31) continue;
      final d = f.hist[f.hist.length - 31].workers - f.workers.length;
      if (d > 0) drops[f] = d;
    }
    final l = drops.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    return [for (final e in l.take(4)) ('${e.key.name} (−${e.value} empl. en 30 j)', _firm(e.key))];
  }

  static String _money(double v) => v < 100 ? '${_dec(v, 1)} \$' : fmtMoney0(v);

  /// Hôpitaux : effectifs, visites produites et demandées, intrants qui manquent ; file d'attente si public.
  static List<AgentLine> _hospitals(Sim s) {
    final hs = s.firms.where((f) => f.outputs.containsKey('soins')).toList();
    if (hs.isEmpty) return const [('aucun hôpital', null)];
    final st = s.services['soins']!;
    return [
      ..._providers(s, 'soins'),
      if (s.publicGood('soins')) ('file : ${st.queue} personne(s), attente moyenne ${_dec(st.wait, 1)} j', null),
    ];
  }

  /// Établissements qui produisent un service : effectifs, production et demande, intrants qui manquent.
  static List<AgentLine> _providers(Sim s, String g) {
    final l = s.firms.where((f) => f.outputs.containsKey(g)).toList();
    if (l.isEmpty) return [(g == 'soins' ? 'aucun hôpital' : 'aucune école', null)];
    final unit = g == 'soins' ? 'visite(s)' : 'cours';
    return [
      for (final f in l.take(3))
        (
          '${f.name} : ${f.workers.length} employé(s) pour ${f.desired} voulus, '
              '${_dec(f.produced[g] ?? 0, 1)} $unit/j pour ${_dec(f.demandEma[g] ?? 0, 0)} demandés'
              '${f.inputLimited ? ' ; limité par ses intrants${_short(s, f)}' : ''}',
          _firm(f)
        ),
    ];
  }

  /// Intrants dont le stock ne couvre pas une journée du plan de production.
  static String _short(Sim s, Firm f) {
    final need = math.max(1.0, s.plannedBatches(f));
    final l = [
      for (final e in f.inputs.entries)
        if ((f.inv[e.key] ?? 0) < e.value * need) goods[e.key]!.label.toLowerCase(),
    ];
    return l.isEmpty ? '' : ' (${l.join(', ')})';
  }

  /// Facteurs d'efficacité, du plus pénalisant au moins pénalisant.
  static List<String> _factors(Map<String, double> k) {
    final l = k.entries.toList()..sort((a, b) => a.value.compareTo(b.value));
    return [for (final e in l) '${e.key} ×${_dec(e.value, 2)}'];
  }

  /// Entreprises dont des postes ouverts restent non pourvus, les plus anciens d'abord.
  static List<AgentLine> _unfilled(Sim s) {
    final l = s.firms.where((f) => f.vacancies > 0 && f.unfilledDays >= 1).toList()
      ..sort((a, b) => b.unfilledDays.compareTo(a.unfilledDays));
    return [
      for (final f in l.take(4))
        (
          '${f.name} : ${f.vacancies} poste(s) de ${classLabels[f.template.skill].toLowerCase()} ouvert(s) depuis '
              '${f.unfilledDays} j',
          _firm(f)
        ),
    ];
  }

  /// Entreprises qui voudraient embaucher sans en avoir les moyens.
  static List<AgentLine> _blocked(Sim s) {
    final l = s.firms.where((f) {
      final gap = f.desired - f.workers.length;
      return gap > f.vacancies && s.affordablePosts(f) < math.min(gap, 3);
    }).toList()
      ..sort((a, b) => (b.desired - b.workers.length).compareTo(a.desired - a.workers.length));
    return [
      for (final f in l.take(4))
        (
          '${f.name} : ${f.workers.length} employé(s), ${f.desired} voulus, caisse de '
              '${_dec(f.money / math.max(1.0, f.wage * math.max(1, f.workers.length)), 1)} j de salaires '
              '(il en faut ${Sim.hireCashDays} par employé, nouveaux compris)',
          _firm(f)
        ),
    ];
  }

  /// Entreprises qui cherchent à embaucher.
  static List<AgentLine> _hiring(Sim s) {
    final l = s.firms.where((f) => f.vacancies > 0).toList()..sort((a, b) => b.vacancies.compareTo(a.vacancies));
    return [for (final f in l.take(4)) ('${f.name} (${f.vacancies} poste(s), ${f.unfilledDays} j)', _firm(f))];
  }

  /// Citoyens en détresse : résumé des causes, puis les cas les plus anciens.
  static List<AgentLine> _people(List<Citizen> list, int Function(Citizen) days, String Function(Citizen) cause) {
    final causes = <String, int>{};
    for (final c in list) {
      final k = cause(c);
      causes[k] = (causes[k] ?? 0) + 1;
    }
    final cs = causes.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final sorted = List<Citizen>.from(list)..sort((a, b) => days(b).compareTo(days(a)));
    return [
      ('causes : ${cs.map((e) => '${e.key} ×${e.value}').join(', ')}', null),
      for (final c in sorted.take(5)) ('${c.name} (${days(c)} j, ${cause(c)})', _citizen(c)),
    ];
  }

  /// Citoyens les plus riches et leur part de la richesse.
  static List<AgentLine> _richest(Sim s) {
    var total = 0.0;
    for (final c in s.citizens) {
      total += math.max(0.0, c.money);
    }
    final l = List<Citizen>.from(s.citizens)..sort((a, b) => b.money.compareTo(a.money));
    return [
      for (final c in l.take(3)) ('${c.name} (${fmtPct(total > 0 ? c.money / total : 0.0)} de la richesse)', _citizen(c))
    ];
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

// ------------------------------------------------------------------ instantanés

Object? _jd(double v) => v.isFinite ? v : (v.isNaN ? 'NaN' : (v > 0 ? 'Infinity' : '-Infinity'));

double _jr(Object? v) {
  if (v is num) return v.toDouble();
  switch (v) {
    case 'NaN':
      return double.nan;
    case 'Infinity':
      return double.infinity;
    case '-Infinity':
      return double.negativeInfinity;
  }
  throw FormatException('Instantané : nombre attendu, lu $v');
}

Object? _refJson(AgentRef? r) => r == null ? null : [r.kind, r.id];
AgentRef? _refFrom(Object? v) => v == null ? null : AgentRef((v as List)[0] as String, v[1] as int);

Map<String, Object?> _alertJson(Alert a) => {
      'key': a.key,
      'type': a.type,
      'critical': a.critical,
      'since': a.since,
      'until': a.until,
      'what': a.what,
      'value': _jd(a.value),
      'threshold': _jd(a.threshold),
      'agents': a.agents,
      'refs': [for (final r in a.refs) _refJson(r)],
      'subject': _refJson(a.subject),
    };

Alert _alertFrom(Map j) => Alert(j['key'] as String, j['type'] as String, j['critical'] as bool, j['since'] as int,
    j['what'] as String, _jr(j['value']), _jr(j['threshold']), (j['agents'] as List).cast<String>(),
    refs: [for (final r in j['refs'] as List) _refFrom(r)], subject: _refFrom(j['subject']))
  ..until = j['until'] as int?;

Map<String, Object?> _cfgJson(MonitorConfig c) => {
      'unempHigh': _jd(c.unempHigh),
      'unempDays': c.unempDays,
      'fullEmploymentDays': c.fullEmploymentDays,
      'distressShare': _jd(c.distressShare),
      'distressDays': c.distressDays,
      'giniHigh': _jd(c.giniHigh),
      'giniLow': _jd(c.giniLow),
      'giniDays': c.giniDays,
      'medianLowDays': _jd(c.medianLowDays),
      'medianHighDays': _jd(c.medianHighDays),
      'medianDays': c.medianDays,
      'inflationDaily': _jd(c.inflationDaily),
      'inflation100': _jd(c.inflation100),
      'stockEmptyDays': c.stockEmptyDays,
      'stockFullDays': _jd(c.stockFullDays),
      'stockFullPersist': c.stockFullPersist,
      'noStaffDays': c.noStaffDays,
      'noClientDays': c.noClientDays,
      'invariantTol': _jd(c.invariantTol),
      'healthLow': _jd(c.healthLow),
      'healthDays': c.healthDays,
      'efficiencyLow': _jd(c.efficiencyLow),
      'efficiencyDays': c.efficiencyDays,
      'laborShortage': _jd(c.laborShortage),
      'laborShortageDays': c.laborShortageDays,
      'blockedHiring': _jd(c.blockedHiring),
      'blockedHiringDays': c.blockedHiringDays,
      'waitLong': _jd(c.waitLong),
      'waitDays': c.waitDays,
      'priceAberrant': _jd(c.priceAberrant),
      'priceAberrantDays': c.priceAberrantDays,
    };

MonitorConfig _cfgFrom(Map j) => MonitorConfig()
  ..unempHigh = _jr(j['unempHigh'])
  ..unempDays = j['unempDays'] as int
  ..fullEmploymentDays = j['fullEmploymentDays'] as int
  ..distressShare = _jr(j['distressShare'])
  ..distressDays = j['distressDays'] as int
  ..giniHigh = _jr(j['giniHigh'])
  ..giniLow = _jr(j['giniLow'])
  ..giniDays = j['giniDays'] as int
  ..medianLowDays = _jr(j['medianLowDays'])
  ..medianHighDays = _jr(j['medianHighDays'])
  ..medianDays = j['medianDays'] as int
  ..inflationDaily = _jr(j['inflationDaily'])
  ..inflation100 = _jr(j['inflation100'])
  ..stockEmptyDays = j['stockEmptyDays'] as int
  ..stockFullDays = _jr(j['stockFullDays'])
  ..stockFullPersist = j['stockFullPersist'] as int
  ..noStaffDays = j['noStaffDays'] as int
  ..noClientDays = j['noClientDays'] as int
  ..invariantTol = _jr(j['invariantTol'])
  ..healthLow = _jr(j['healthLow'])
  ..healthDays = j['healthDays'] as int
  ..efficiencyLow = _jr(j['efficiencyLow'])
  ..efficiencyDays = j['efficiencyDays'] as int
  ..laborShortage = _jr(j['laborShortage'])
  ..laborShortageDays = j['laborShortageDays'] as int
  ..blockedHiring = _jr(j['blockedHiring'])
  ..blockedHiringDays = j['blockedHiringDays'] as int
  ..waitLong = _jr(j['waitLong'])
  ..waitDays = j['waitDays'] as int
  ..priceAberrant = _jr(j['priceAberrant'])
  ..priceAberrantDays = j['priceAberrantDays'] as int;
