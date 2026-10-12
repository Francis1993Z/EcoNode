// Protocole de stabilité d'ÉcoNodes, sans interface (moteur seul).
//
//   dart run tool/stabilite.dart [options]
//
//   --graines 30             nombre de graines : 1 à N (défaut : 30)
//   --seeds 1,2,3            liste explicite de graines (remplace --graines)
//   --isolats 16             parties simultanées, chacune dans son propre isolat (défaut : nombre de processeurs)
//   --days 1500              durée de chaque partie
//   --warmup 100             période de chauffe : jours exclus des moyennes et des taux
//   --phases base,nets,chocs étapes à exécuter (défaut : les trois ; avec --compare : base,nets)
//   --sauf bailout           ajoute une étape « avec filets sauf ceux-là » (critère de réussite d'une institution :
//                            le filet qu'elle remplace coupé, l'économie doit tenir). Répétable : une étape par --sauf.
//                            --sauf chacun : une étape par filet, chaque filet coupé seul.
//   --shock-seeds 1,2,3      graines des chocs (défaut : les mêmes que les parties)
//   --shock-day 300          jour du choc ; on observe ensuite 500 jours
//   --shock-nets both        chocs sans filets (off), avec filets (on) ou les deux (both)
//   --modules credit=0,...   coupe (0) ou active (1) des modules
//   --noyau                  coupe tous les modules ajoutés au modèle de base (les institutions restent actives)
//   --param nom=valeur       change un paramètre (variantes mesurées ; voir applyParam)
//   --population 1000        taille de la population (comme --param population=1000)
//   --key raffinerie         type de la « firme clé » mise en faillite
//   --out rapport.md         écrit le rapport Markdown (sinon : sortie standard)
//   --save synthese.json     enregistre les résultats de chaque graine (relus par --compare et --relire)
//   --relire synthese.json   refait le rapport d'une synthèse enregistrée, sans relancer de partie
//   --compare A B            comparaison appariée, graine par graine, de la configuration A contre B. A et B sont des
//                            fichiers .json enregistrés par --save, ou des configurations lancées ici sur les mêmes
//                            graines (voir Config.apply : « ref », « institutions=0 », « bankruptcy=0,param:x=1 »…).
//                            Un seul opérande : B est la configuration de cette exécution (« ref »).
//
// Étapes : 1) filets coupés ; 2) filets actifs (déclenchements comptés) ; 2 bis) filets actifs sauf ceux de --sauf ;
// 3) chocs standard, sans puis avec filets.
//
// Statistiques (Fagiolo et al. 2017 ; Lee et al. 2015) : chaque indicateur est donné par sa distribution sur les
// graines (médiane, écart interquartile, min–max) et par le nombre de graines hors de la zone d'équilibre, jamais par
// une moyenne seule. Une comparaison est appariée (même graine, même hasard : les flux de hasard sont indépendants) ;
// on rapporte la différence médiane par graine, son intervalle de confiance à 95 % (bootstrap) et la part des graines
// où B fait mieux. On ne conclut qu'un effet dont l'intervalle exclut 0.

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math' as math;

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/monitor.dart';
import 'package:econodes/engine/sim.dart';

// ------------------------------------------------------------------ configurations et options

/// Une configuration du modèle : modules et paramètres. Les filets dépendent de l'étape (sans, avec, avec sauf).
class Config {
  final String label;
  Modules modules;
  final Map<String, String> params;
  Config(this.label, this.modules, this.params);

  Params newParams() {
    final p = Params();
    for (final e in params.entries) {
      applyParam(p, e.key, e.value);
    }
    return p;
  }

  List<String> get modulesOff => Modules.keys.where((k) => !modules.get(k)).toList();

  /// Cette configuration modifiée par [spec] : « ref » (aucun changement) ou une liste « jeton,jeton,… » de
  ///   noyau | complet         modules ajoutés coupés (institutions actives) | tous les modules actifs
  ///   institutions=0|1        les cinq institutions (Modules.institutions)
  ///   <module>=0|1            un module (Modules.keys)
  ///   param:<nom>=<valeur>    un paramètre (applyParam)
  Config apply(String spec) {
    final c = Config(spec, modules.copy(), Map.of(params));
    if (spec == 'ref') return c;
    for (final t in spec.split(',')) {
      if (t == 'noyau') {
        c.modules = Modules.noyau();
        continue;
      }
      if (t == 'complet') {
        c.modules = Modules();
        continue;
      }
      final i = t.indexOf('=');
      if (i < 0) throw ArgumentError('Configuration illisible : $t (attendu : clé=valeur, noyau, complet ou ref)');
      final k = t.substring(0, i), v = t.substring(i + 1);
      if (k.startsWith('param:')) {
        applyParam(Params(), k.substring(6), v); // nom inconnu : erreur tout de suite
        c.params[k.substring(6)] = v;
      } else if (k == 'institutions') {
        for (final m in Modules.institutions) {
          c.modules.set(m, v != '0');
        }
      } else {
        c.modules.set(k, v != '0'); // module inconnu : erreur
      }
    }
    return c;
  }
}

class Options {
  List<int> seeds = [for (var i = 1; i <= 30; i++) i];
  List<int>? shockSeeds; // défaut : les graines des parties
  int days = 1500;
  int warmup = 100;
  Set<String> phases = {'base', 'nets', 'chocs'};
  bool phasesGiven = false;
  int shockDay = 300;
  int shockHorizon = 500;
  Set<String> shockNets = {'off', 'on'};
  List<Set<String>> sauf = []; // une étape 2 bis par ensemble de filets coupés
  Config config = Config('ref', Modules(), {});
  int isolates = Platform.numberOfProcessors;
  String keyFirm = 'raffinerie';
  String? out;
  String? save;
  String? reread;
  List<String>? compare;

  Options(List<String> args) {
    for (var i = 0; i < args.length; i++) {
      final a = args[i];
      String next() {
        if (i + 1 >= args.length) throw ArgumentError('Valeur manquante après $a');
        return args[++i];
      }

      switch (a) {
        case '--graines':
          final n = int.parse(next());
          if (n < 1) throw ArgumentError('--graines : au moins 1');
          seeds = [for (var k = 1; k <= n; k++) k];
        case '--population':
          final v = next();
          applyParam(Params(), 'population', v);
          config.params['population'] = v;
        case '--seeds':
          seeds = next().split(',').map(int.parse).toList();
        case '--isolats':
          isolates = math.max(1, int.parse(next()));
        case '--days':
          days = int.parse(next());
        case '--warmup':
          warmup = int.parse(next());
        case '--phases':
          phases = next().split(',').toSet();
          phasesGiven = true;
        case '--shock-seeds':
          shockSeeds = next().split(',').map(int.parse).toList();
        case '--shock-day':
          shockDay = int.parse(next());
        case '--shock-nets':
          final v = next();
          shockNets = v == 'both' ? {'off', 'on'} : {v};
        case '--noyau':
          config.modules = Modules.noyau();
        case '--sauf':
          final v = next();
          if (v == 'chacun') {
            sauf.addAll([for (final k in Safeguards.keys) {k}]);
          } else {
            final s = v.split(',').toSet();
            for (final k in s) {
              Safeguards().get(k); // filet inconnu : erreur tout de suite
            }
            sauf.add(s);
          }
        case '--modules':
          for (final kv in next().split(',')) {
            final p = kv.split('=');
            config.modules.set(p[0], p.length < 2 || p[1] != '0');
          }
        case '--param':
          for (final kv in next().split(',')) {
            final i = kv.indexOf('=');
            if (i < 0) throw ArgumentError('Paramètre sans valeur : $kv');
            applyParam(Params(), kv.substring(0, i), kv.substring(i + 1)); // nom inconnu : erreur tout de suite
            config.params[kv.substring(0, i)] = kv.substring(i + 1);
          }
        case '--key':
          keyFirm = next();
        case '--out':
          out = next();
        case '--save':
          save = next();
        case '--relire':
          reread = next();
        case '--compare':
          final x = next();
          compare = [x];
          if (i + 1 < args.length && !args[i + 1].startsWith('--')) compare!.add(args[++i]);
        default:
          throw ArgumentError('Option inconnue : $a');
      }
    }
    if (compare != null && !phasesGiven) phases = {'base', 'nets'};
  }

  List<int> get shocksOn => shockSeeds ?? seeds;
}

/// Paramètres modifiables en ligne de commande, pour mesurer une variante.
/// Étapes de l'entonnoir de création (Sim.entryFunnel), dans l'ordre du rapport.
const List<String> funnelSteps = [
  'projet', 'creation', 'plafond_quotidien', 'delai', 'concurrence', 'demande', 'main_oeuvre', 'viabilite', 'capital',
];
const Map<String, String> funnelLabels = {
  'projet': 'projets envisagés',
  'creation': 'créations',
  'plafond_quotidien': 'refus, une création déjà ce jour',
  'delai': 'refus, délai entre deux créations du type',
  'concurrence': 'refus, concurrence',
  'demande': 'refus, demande insuffisante',
  'main_oeuvre': 'refus, pas assez de chômeurs qualifiés',
  'viabilite': 'refus, viabilité',
  'capital': 'refus, aucun fondateur assez riche',
};

void applyParam(Params p, String k, String v) {
  bool b() => v == '1' || v == 'true';
  switch (k) {
    case 'population': // taille de la population (tâche 1 de l'entrepreneuriat : passage à l'échelle)
      p.population = int.parse(v);
    case 'scenarioPopulation': // population du scénario par défaut (au-delà, il est répété)
      p.scenarioPopulation = int.parse(v);
    case 'dividendFromRetained':
      p.dividendFromRetained = b();
    case 'healthWearIfDeprived': // variante de test A1 (tâche 4)
      p.healthWearIfDeprived = b();
    case 'partTime': // variante de test A2 (tâche 4)
      p.partTime = b();
    default:
      throw ArgumentError('Paramètre inconnu : $k');
  }
}

/// Clé d'une étape « avec filets sauf … » : « sauf:bailout+famine », dans l'ordre de Safeguards.keys.
String saufKey(Set<String> cut) => 'sauf:${Safeguards.keys.where(cut.contains).join('+')}';

Set<String> phaseCut(String phase) => phase.startsWith('sauf:') ? phase.substring(5).split('+').toSet() : const {};

String phaseLabel(String phase) => switch (phase) {
      'base' => 'Sans filets',
      'nets' => 'Avec filets',
      _ => 'Avec filets, sauf ${phaseCut(phase).map((k) => '« ${Safeguards.labels[k]} »').join(', ')}',
    };

int phaseOrder(String p) => p == 'base' ? 0 : (p == 'nets' ? 1 : 2);

// ------------------------------------------------------------------ mesures d'une partie

class RunStats {
  final int seed;
  final bool nets;
  int steady = 0; // jours comptés dans les moyennes (après la chauffe)
  double unempSum = 0, unempMax = 0, unempMin = 1;
  double hungerSum = 0, hungerMax = 0;
  double homelessSum = 0, homelessMax = 0;
  double giniSum = 0, giniEnd = 0;
  double happySum = 0;
  double healthSum = 0; // santé moyenne de la population
  double waitSum = 0, queueSum = 0; // hôpital public : attente moyenne et file
  Map<String, int> bailoutByType = {}; // renflouements en régime, par type d'entreprise
  int benefitCutDays = 0; // jours où les prestations aux sans-emploi n'ont été versées qu'en partie
  double treasuryMin = double.infinity; // trésor de l'État le plus bas (régime)
  int bankNegDays = 0; // jours où les fonds propres de la Caisse sont négatifs (insolvable)
  double bankEquityMin = double.infinity;
  int refusals = 0; // prêts refusés (règles prudentielles ou filet), sur toute la partie
  double inflMaxAbs = 0, infl100MaxAbs = 0;
  double cpiAtWarmup = 1, cpiEnd = 1;
  double invMax = 0;
  Map<String, int> alertsOpened = {}; // sur toute la partie
  Map<String, int> alertsAtWarmup = {}; // ouvertures pendant la chauffe (référence, soustraite à la fin)
  Map<String, int> alertsSteady = {}; // ouvertures après la chauffe
  Map<String, int> alertDays = {};
  Map<String, int> netsTotal = {};
  Map<String, int> netsSteady = {};
  Map<String, String> netsTopCause = {};
  Map<String, Map<String, int>> netsCauses = {};
  List<double> sectorShare = [0, 0, 0];
  double debtEnd = 0, lent = 0, writtenOff = 0;
  int firmsWithoutStaff = 0;
  // filière (anomalie A2) : types d'entreprise qui ont au moins un employé, machines, équipes peu utilisées, en fin
  int typesActiveEnd = 0;
  double machinesEnd = 0;
  int lowUtilEnd = 0; // entreprises avec employés qui utilisent moins de 15 % de la capacité de leur équipe
  // création et fermeture d'entreprises (passage à l'échelle)
  int days = 0, population = 0, firmsStart = 0, firmsCreated = 0, firmsClosed = 0;
  Map<String, int> funnel = {}; // entonnoir de création, cumulé sur la partie (Sim.entryFunnel)
  Map<String, Map<String, num>> samples = {}; // jours 500 et 1 000 : postes vacants, chômeurs, entonnoir
  String? crash;

  RunStats(this.seed, this.nets);

  double get unempMean => steady > 0 ? unempSum / steady : 0;
  double get hungerMean => steady > 0 ? hungerSum / steady : 0;
  double get homelessMean => steady > 0 ? homelessSum / steady : 0;
  double get giniMean => steady > 0 ? giniSum / steady : 0;
  double get happyMean => steady > 0 ? happySum / steady : 0;
  double get healthMean => steady > 0 ? healthSum / steady : 0;
  double get waitMean => steady > 0 ? waitSum / steady : 0;
  double get queueMean => steady > 0 ? queueSum / steady : 0;

  /// Renflouements d'un type d'entreprise par 50 jours en régime normal.
  double bailoutRate(String type) => steady > 0 ? (bailoutByType[type] ?? 0) * 50 / steady : 0;
  double get inflMean => steady > 0 && cpiAtWarmup > 0 ? math.pow(cpiEnd / cpiAtWarmup, 1 / steady) - 1 : 0;
  int _critical(Map<String, int> m) => m.entries.where((e) => criticalAlerts.contains(e.key)).fold(0, (a, e) => a + e.value);
  int get criticalOpened => _critical(alertsOpened);
  int get criticalSteady => _critical(alertsSteady);
  int get alertsTotal => alertsOpened.values.fold(0, (a, b) => a + b);

  /// Déclenchements par 50 jours en régime normal.
  double netRate(String k) => steady > 0 ? (netsSteady[k] ?? 0) * 50 / steady : 0;

  Map<String, dynamic> toJson() => {
        'seed': seed,
        'nets': nets,
        'steady': steady,
        'unempMean': unempMean,
        'unempMax': unempMax,
        'unempMin': unempMin,
        'hungerMean': hungerMean,
        'hungerMax': hungerMax,
        'homelessMean': homelessMean,
        'homelessMax': homelessMax,
        'giniMean': giniMean,
        'giniEnd': giniEnd,
        'happyMean': happyMean,
        'healthMean': healthMean,
        'waitMean': waitMean,
        'queueMean': queueMean,
        'bailoutByType': bailoutByType,
        'bailoutRates': {for (final k in bailoutByType.keys) k: bailoutRate(k)},
        'benefitCutDays': benefitCutDays,
        'treasuryMin': treasuryMin.isFinite ? treasuryMin : null,
        'bankNegDays': bankNegDays,
        'bankEquityMin': bankEquityMin.isFinite ? bankEquityMin : null,
        'refusals': refusals,
        'inflMean': inflMean,
        'inflMaxAbs': inflMaxAbs,
        'infl100MaxAbs': infl100MaxAbs,
        'invMax': invMax,
        'criticalOpened': criticalOpened,
        'criticalSteady': criticalSteady,
        'alertsTotal': alertsTotal,
        'alertsOpened': alertsOpened,
        'alertsSteady': alertsSteady,
        'alertDays': alertDays,
        'netsSteady': netsSteady,
        'netsTotal': netsTotal,
        'netsCauses': netsCauses,
        'netsTopCause': netsTopCause,
        'netRates': {for (final k in Safeguards.keys) k: netRate(k)},
        'sectorShare': sectorShare,
        'firmsWithoutStaff': firmsWithoutStaff,
        'typesActiveEnd': typesActiveEnd,
        'machinesEnd': machinesEnd,
        'lowUtilEnd': lowUtilEnd,
        'days': days,
        'population': population,
        'firmsStart': firmsStart,
        'firmsCreated': firmsCreated,
        'firmsClosed': firmsClosed,
        'birthsPerYear': days > 0 ? firmsCreated * 365 / days : 0,
        'deathsPerYear': days > 0 ? firmsClosed * 365 / days : 0,
        'funnel': funnel,
        'samples': samples,
        'debtEnd': debtEnd,
        'lent': lent,
        'writtenOff': writtenOff,
        'crash': crash,
      };
}

void observe(Sim s, RunStats r, int warmup) {
  final h = s.history.last;
  final n = math.max(1, s.citizens.length);
  final hs = h.hungry / n, ss = h.homeless / n;
  r.unempMax = math.max(r.unempMax, h.unemp);
  r.hungerMax = math.max(r.hungerMax, hs);
  r.homelessMax = math.max(r.homelessMax, ss);
  r.invMax = math.max(r.invMax, s.inv.worst);
  final hist = s.history;
  if (hist.length >= 2) {
    final prev = hist[hist.length - 2];
    if (prev.cpi > 0) r.inflMaxAbs = math.max(r.inflMaxAbs, (h.cpi / prev.cpi - 1).abs());
  }
  if (hist.length > 100) {
    final old = hist[hist.length - 101];
    if (old.cpi > 0) r.infl100MaxAbs = math.max(r.infl100MaxAbs, (h.cpi / old.cpi - 1).abs());
  }
  if (h.day == warmup) {
    r.cpiAtWarmup = h.cpi;
    r.netsSteady = Map<String, int>.from(s.nets.count); // référence, soustraite à la fin
    r.alertsAtWarmup = Map<String, int>.from(s.monitor.opened);
  }
  if (h.day > warmup) {
    r.steady++;
    r.unempSum += h.unemp;
    r.unempMin = math.min(r.unempMin, h.unemp);
    r.hungerSum += hs;
    r.homelessSum += ss;
    r.giniSum += h.gini;
    r.happySum += h.happiness;
    var health = 0.0;
    for (final c in s.citizens) {
      health += c.health;
    }
    r.healthSum += s.citizens.isEmpty ? 0 : health / s.citizens.length;
    if (s.state.benefitCut < 1 - 1e-9) r.benefitCutDays++;
    r.treasuryMin = math.min(r.treasuryMin, s.state.money);
    if (s.bank.equity < 0) r.bankNegDays++;
    r.bankEquityMin = math.min(r.bankEquityMin, s.bank.equity);
    final care = s.services['soins']!;
    r.waitSum += care.wait;
    r.queueSum += care.queue;
    final log = s.nets.log;
    for (var i = log.length - 1; i >= 0 && log[i].day == h.day; i--) {
      if (log[i].net != 'bailout') continue;
      final f = s.firms.where((f) => f.name == log[i].agent).toList();
      final t = f.isEmpty ? '?' : f.first.type;
      r.bailoutByType[t] = (r.bailoutByType[t] ?? 0) + 1;
    }
  }
  r.cpiEnd = h.cpi;
  r.giniEnd = h.gini;
}

void finish(Sim s, RunStats r) {
  r.alertsOpened = Map<String, int>.from(s.monitor.opened);
  r.alertsSteady = {
    for (final e in s.monitor.opened.entries)
      if (e.value - (r.alertsAtWarmup[e.key] ?? 0) > 0) e.key: e.value - (r.alertsAtWarmup[e.key] ?? 0),
  };
  r.alertDays = Map<String, int>.from(s.monitor.alertDays);
  r.netsTotal = Map<String, int>.from(s.nets.count);
  final base = r.netsSteady;
  r.netsSteady = {for (final k in Safeguards.keys) k: (s.nets.count[k] ?? 0) - (base[k] ?? 0)};
  r.netsCauses = {for (final e in s.nets.causes.entries) e.key: Map<String, int>.from(e.value)};
  for (final k in Safeguards.keys) {
    final by = s.nets.causes[k];
    if (by != null && by.isNotEmpty) {
      final top = by.entries.reduce((a, b) => a.value >= b.value ? a : b);
      r.netsTopCause[k] = '${top.key} (${(100 * top.value / s.nets.total(k)).round()} %)';
    }
  }
  final emp = [0, 0, 0];
  for (final f in s.firms) {
    emp[sectors.indexOf(f.template.sector)] += f.workers.length;
    if (f.workers.isEmpty) r.firmsWithoutStaff++;
    r.machinesEnd += f.machines;
    if (f.workers.isNotEmpty && f.outputEma < 0.15 * f.workers.length * s.perWorker(f)) r.lowUtilEnd++;
  }
  r.days = s.day;
  r.firmsCreated = s.firmsCreated;
  r.firmsClosed = s.firmsClosed;
  r.funnel = Map.of(s.entryFunnel);
  r.typesActiveEnd = {for (final f in s.firms) if (f.workers.isNotEmpty) f.type}.length;
  final tot = emp.fold(0, (a, b) => a + b);
  r.sectorShare = [for (final e in emp) tot > 0 ? e / tot : 0.0];
  r.debtEnd = s.totalDebt();
  r.refusals = s.bank.refusals;
  r.lent = s.bank.lent;
  r.writtenOff = s.bank.writtenOff;
}

/// État du marché du travail et de la création, un jour donné. Tout chômeur cherche un emploi : le modèle n'a pas
/// d'inactifs par choix (le marché du travail examine chaque jour tous les sans-emploi).
Map<String, num> sample(Sim s) {
  final unemployed = s.citizens.where((c) => c.employer == null).length;
  final vacancies = s.firms.fold(0, (a, f) => a + f.vacancies);
  return {
    'population': s.citizens.length,
    'unemployed': unemployed,
    'vacancies': vacancies,
    'vacPerUnemp': unemployed > 0 ? vacancies / unemployed : 0,
    'firms': s.firms.length,
    'created': s.firmsCreated,
    'closed': s.firmsClosed,
    for (final e in s.entryFunnel.entries) 'funnel.${e.key}': e.value,
  };
}

Map<String, dynamic> runBase(int seed, Config c, int days, int warmup, bool nets, Set<String> except) {
  final sg = nets ? Safeguards() : Safeguards.none();
  for (final k in except) {
    sg.set(k, false);
  }
  final s = Sim(seed: seed, params: c.newParams(), modules: c.modules.copy(), safeguards: sg);
  final r = RunStats(seed, nets)
    ..population = s.citizens.length
    ..firmsStart = s.firms.length;
  try {
    for (var d = 1; d <= days; d++) {
      s.step();
      observe(s, r, warmup);
      if (d == 500 || d == 1000) r.samples['$d'] = sample(s);
    }
  } catch (e) {
    r.crash = 'j${s.day} : $e';
  }
  finish(s, r);
  return r.toJson();
}

// ------------------------------------------------------------------ chocs

const Map<String, String> shockLabels = {
  'helico': 'Hélicoptère 5 000 \$/citoyen',
  'immigrants': '+25 immigrants',
  'salaireMin': 'Salaire minimum 220 \$/j',
  'ferme': 'Fermeture de la ferme',
  'faillite': 'Faillite d’une firme clé',
};

class ShockStats {
  final String kind;
  final int seed;
  final bool nets;
  bool collapsedBefore = false; // chômage moyen > 50 % avant le choc : l'évaluation est sans objet
  String detail = '';
  Map<String, int> alerts = {};
  int? recoverAbs; // jours après le choc pour revenir dans la zone d'équilibre (critères de sortie)
  int? recoverRel; // jours pour revenir au niveau d'avant le choc
  bool preInBand = false; // l'économie était-elle dans la zone d'équilibre avant le choc ?
  double peakUnemp = 0, peakHunger = 0, peakHomeless = 0;
  String? crash;
  ShockStats(this.kind, this.seed, this.nets);

  Map<String, dynamic> toJson() => {
        'kind': kind,
        'seed': seed,
        'nets': nets,
        'detail': detail,
        'collapsedBefore': collapsedBefore,
        'alerts': alerts,
        'recoverAbs': recoverAbs,
        'recoverRel': recoverRel,
        'preInBand': preInBand,
        'peakUnemp': peakUnemp,
        'peakHunger': peakHunger,
        'peakHomeless': peakHomeless,
        'crash': crash,
      };
}

class _Day {
  final double unemp, hunger, homeless, infl;
  final bool critical;
  _Day(this.unemp, this.hunger, this.homeless, this.infl, this.critical);
}

_Day _snap(Sim s) {
  final h = s.history.last;
  final n = math.max(1, s.citizens.length);
  final hist = s.history;
  final prev = hist.length >= 2 ? hist[hist.length - 2] : h;
  return _Day(h.unemp, h.hungry / n, h.homeless / n, prev.cpi > 0 ? h.cpi / prev.cpi - 1 : 0, s.monitor.criticalCount > 0);
}

bool _inBand(List<_Day> w) {
  final infl = w.fold(0.0, (a, d) => a + d.infl) / w.length;
  return w.every((d) => d.unemp <= 0.10 && d.hunger < 0.02 && d.homeless < 0.02 && !d.critical) &&
      infl.abs() < 0.005;
}

Map<String, dynamic> runShock(String kind, int seed, Config c, int shockDay, int horizon, String keyFirm, bool nets) {
  final s = Sim(seed: seed, params: c.newParams(), modules: c.modules.copy(), safeguards: nets ? Safeguards() : Safeguards.none());
  final r = ShockStats(kind, seed, nets);
  const window = 30;
  try {
    final pre = <_Day>[];
    for (var d = 1; d <= shockDay; d++) {
      s.step();
      if (d > shockDay - 100) pre.add(_snap(s));
    }
    r.preInBand = _inBand(pre.sublist(pre.length - window));
    final uMean = pre.fold(0.0, (a, d) => a + d.unemp) / pre.length;
    r.collapsedBefore = uMean > 0.5;
    final uSd = math.sqrt(pre.fold(0.0, (a, d) => a + (d.unemp - uMean) * (d.unemp - uMean)) / pre.length);
    final hPre = pre.fold(0.0, (a, d) => a + d.hunger) / pre.length;
    final sPre = pre.fold(0.0, (a, d) => a + d.homeless) / pre.length;
    final before = Map<String, int>.from(s.monitor.opened);
    switch (kind) {
      case 'helico':
        s.godMoney(const Target('allCitizens'), 5000);
      case 'immigrants':
        s.godAddCitizens(25, s.params.startWallet);
      case 'salaireMin':
        s.params.minWage = 220;
      case 'ferme':
        final f = s.firms.where((f) => f.type == 'ferme').toList();
        if (f.isNotEmpty) s.removeFirm(f.first.id);
      case 'faillite':
        final f = s.firms.where((f) => f.type == keyFirm).toList();
        if (f.isNotEmpty) {
          r.detail = f.first.name;
          s.godBankrupt(f.first.id);
        }
    }
    final post = <_Day>[];
    for (var d = 1; d <= horizon; d++) {
      s.step();
      final x = _snap(s);
      post.add(x);
      r.peakUnemp = math.max(r.peakUnemp, x.unemp);
      r.peakHunger = math.max(r.peakHunger, x.hunger);
      r.peakHomeless = math.max(r.peakHomeless, x.homeless);
    }
    for (final e in s.monitor.opened.entries) {
      final dlt = e.value - (before[e.key] ?? 0);
      if (dlt > 0) r.alerts[e.key] = dlt;
    }
    final tolU = math.max(0.02, 2 * uSd);
    bool rel(List<_Day> w) {
      final infl = w.fold(0.0, (a, d) => a + d.infl) / w.length;
      return w.every((d) =>
              (d.unemp - uMean).abs() <= tolU && d.hunger <= hPre + 0.02 && d.homeless <= sPre + 0.02) &&
          infl.abs() < 0.005;
    }

    for (var t = 0; t + window <= post.length; t++) {
      final w = post.sublist(t, t + window);
      if (r.recoverAbs == null && _inBand(w)) r.recoverAbs = t + 1;
      if (r.recoverRel == null && rel(w)) r.recoverRel = t + 1;
      if (r.recoverAbs != null && r.recoverRel != null) break;
    }
  } catch (e) {
    r.crash = 'j${s.day} : $e';
  }
  return r.toJson();
}

// ------------------------------------------------------------------ exécution : une partie par isolat

typedef Job = Map<String, dynamic> Function();

// Fabriques de tâches : une fonction de premier niveau, pour que la fermeture envoyée à l'isolat ne capture que ses
// arguments.
Job baseJob(int seed, Config c, int days, int warmup, bool nets, Set<String> except) =>
    () => runBase(seed, c, days, warmup, nets, except);

Job shockJob(String kind, int seed, Config c, int day, int horizon, String key, bool nets) =>
    () => runShock(kind, seed, c, day, horizon, key, nets);

class Task {
  final int config; // rang de la configuration (0, ou 0 et 1 en comparaison)
  final String phase; // 'base', 'nets', 'sauf:…' ou 'chocs'
  final String name;
  final Job job;
  Task(this.config, this.phase, this.name, this.job);
}

List<Task> tasksFor(int ci, Config c, Options o, {required bool shocks, String tag = ''}) {
  final t = <Task>[];
  void add(String phase, bool nets, Set<String> except) {
    for (final seed in o.seeds) {
      t.add(Task(ci, phase, '$tag${phaseLabel(phase).toLowerCase()}, graine $seed',
          baseJob(seed, c, o.days, o.warmup, nets, except)));
    }
  }

  if (o.phases.contains('base')) add('base', false, const {});
  if (o.phases.contains('nets')) add('nets', true, const {});
  for (final s in o.sauf) {
    add(saufKey(s), true, s);
  }
  if (shocks) {
    for (final nets in [false, true]) {
      if (!o.shockNets.contains(nets ? 'on' : 'off')) continue;
      for (final kind in shockLabels.keys) {
        for (final seed in o.shocksOn) {
          t.add(Task(ci, 'chocs', '${tag}choc $kind, graine $seed, ${nets ? 'avec' : 'sans'} filets',
              shockJob(kind, seed, c, o.shockDay, o.shockHorizon, o.keyFirm, nets)));
        }
      }
    }
  }
  return t;
}

/// Exécute les tâches, au plus [width] à la fois, chacune dans son propre isolat (Isolate.run). L'ordre des résultats
/// est celui des tâches : il ne dépend pas de l'ordre d'achèvement.
Future<List<Map<String, dynamic>>> runAll(List<Task> tasks, int width, void Function(String) progress) async {
  final out = List<Map<String, dynamic>?>.filled(tasks.length, null);
  var next = 0, done = 0;
  Future<void> worker() async {
    while (next < tasks.length) {
      final i = next++;
      out[i] = await Isolate.run(tasks[i].job);
      progress('${++done}/${tasks.length} ${tasks[i].name}');
    }
  }

  await Future.wait([for (var w = 0; w < math.min(width, tasks.length); w++) worker()]);
  return [for (final r in out) r!];
}

typedef Json = Map<String, dynamic>;

/// Synthèse d'une configuration : les résultats de chaque graine, par étape.
Json summaryOf(Config c, Options o, List<Task> tasks, List<Json> results, int ci, double seconds) {
  final phases = <String, List<Json>>{};
  final shocks = <Json>[];
  for (var i = 0; i < tasks.length; i++) {
    if (tasks[i].config != ci) continue;
    if (tasks[i].phase == 'chocs') {
      shocks.add(results[i]);
    } else {
      (phases[tasks[i].phase] ??= []).add(results[i]);
    }
  }
  return {
    'version': 2,
    'date': DateTime.now().toIso8601String(),
    'label': c.label,
    'seeds': o.seeds,
    'days': o.days,
    'warmup': o.warmup,
    'shockDay': o.shockDay,
    'shockHorizon': o.shockHorizon,
    'modulesOff': c.modulesOff,
    'params': c.params,
    'seconds': seconds,
    'runs': tasks.where((t) => t.config == ci).length,
    'isolates': o.isolates,
    'phases': phases,
    'shocks': shocks,
    'distributions': {for (final e in phases.entries) e.key: distributionsJson(e.key, e.value)},
  };
}

/// Relit une synthèse enregistrée par --save, y compris l'ancien format (« base », « nets », « saufRuns »).
Json loadSummary(String path) {
  final m = (jsonDecode(File(path).readAsStringSync()) as Map).cast<String, dynamic>();
  m['label'] = path.split(RegExp(r'[\\/]')).last;
  if (m['phases'] == null) {
    final phases = <String, List<Json>>{};
    List<Json> list(String k) => [for (final r in (m[k] as List? ?? const [])) (r as Map).cast<String, dynamic>()];
    if (list('base').isNotEmpty) phases['base'] = list('base');
    if (list('nets').isNotEmpty) phases['nets'] = list('nets');
    if (list('saufRuns').isNotEmpty) phases[saufKey((m['sauf'] as List).cast<String>().toSet())] = list('saufRuns');
    m['phases'] = phases;
    m['warmup'] ??= 100; // valeur par défaut de l'époque, non enregistrée
  } else {
    m['phases'] = {
      for (final e in (m['phases'] as Map).entries)
        e.key as String: [for (final r in e.value as List) (r as Map).cast<String, dynamic>()],
    };
  }
  return m;
}

Map<String, List<Json>> phasesOf(Json sum) => (sum['phases'] as Map).cast<String, List<Json>>();

// ------------------------------------------------------------------ statistiques

/// Quantile par interpolation linéaire entre rangs (type 7 de Hyndman et Fan, celui de R et de NumPy).
/// [xs] est trié. Les valeurs infinies (choc non résorbé) sont acceptées.
double quantile(List<double> xs, double p) {
  final h = (xs.length - 1) * p;
  final lo = h.floor();
  if (lo + 1 >= xs.length) return xs.last;
  final f = h - lo;
  if (f == 0 || xs[lo] == xs[lo + 1]) return xs[lo];
  return xs[lo] + f * (xs[lo + 1] - xs[lo]);
}

class Dist {
  final List<double> xs; // triées
  Dist(Iterable<double> v) : xs = v.toList()..sort();
  int get n => xs.length;
  double get median => quantile(xs, 0.5);
  double get q1 => quantile(xs, 0.25);
  double get q3 => quantile(xs, 0.75);
  double get min => xs.first;
  double get max => xs.last;
}

/// Intervalle de confiance à 95 % de la médiane de [d], par bootstrap percentile : [reps] tirages des graines avec
/// remise. Le générateur a une graine fixe : le rapport est reproductible.
(double, double) bootstrapMedian(List<double> d, {int reps = 10000}) {
  final rng = Mulberry32(20261011);
  final meds = List<double>.filled(reps, 0);
  final buf = List<double>.filled(d.length, 0);
  for (var r = 0; r < reps; r++) {
    for (var i = 0; i < d.length; i++) {
      buf[i] = d[(rng.next() * d.length).floor()];
    }
    buf.sort();
    meds[r] = quantile(buf, 0.5);
  }
  meds.sort();
  return (quantile(meds, 0.025), quantile(meds, 0.975));
}

/// Un indicateur par partie : clé dans la synthèse d'une graine (« netRates.famine » pour une clé imbriquée), sens
/// (−1 : plus bas est mieux, +1 : plus haut est mieux, 0 : sans sens), bande d'équilibre éventuelle.
class Ind {
  final String key, label, kind, band;
  final int better;
  final bool Function(double v)? inBand;
  final String period; // 'régime' (après la chauffe), 'partie' (toute la partie) ou 'fin'
  final double? Function(Json run)? fn; // valeur calculée, quand elle n'est pas une clé de la synthèse
  Ind(this.key, this.label, this.kind, this.better, this.period, {this.band = '', this.inBand, this.fn});

  double? of(Json run) {
    if (fn != null) return fn!(run);
    Object? v = run;
    final parts = key.split('.');
    for (var i = 0; i < parts.length; i++) {
      if (v is! Map) return null;
      final m = v;
      // une clé absente d'une table présente (alertes, renflouements par type) vaut 0
      v = m.containsKey(parts[i]) ? m[parts[i]] : (i > 0 ? 0 : null);
    }
    return v is num ? v.toDouble() : null;
  }

  /// Les valeurs présentes, une par graine.
  List<double> values(List<Json> runs) => [
        for (final r in runs)
          if (of(r) case final v?) v,
      ];
}

List<Ind> runIndicators(String phase) {
  final cut = phaseCut(phase);
  return [
    Ind('unempMean', 'Chômage moyen', 'pc', -1, 'régime', band: '≤ 10 %', inBand: (v) => v <= 0.10),
    Ind('unempMax', 'Chômage max', 'pc', -1, 'partie'),
    Ind('hungerMean', 'Faim moyenne', 'pc', -1, 'régime', band: '< 2 %', inBand: (v) => v < 0.02),
    Ind('hungerMax', 'Faim max', 'pc', -1, 'partie'),
    Ind('homelessMean', 'Sans-abri moyen', 'pc', -1, 'régime', band: '< 2 %', inBand: (v) => v < 0.02),
    Ind('homelessMax', 'Sans-abri max', 'pc', -1, 'partie'),
    Ind('giniMean', 'Gini moyen', 'dec', 0, 'régime', band: '0,2–0,45', inBand: (v) => v >= 0.2 && v <= 0.45),
    Ind('giniEnd', 'Gini en fin de partie', 'dec', 0, 'fin'),
    Ind('inflMean', 'Inflation moyenne / j', 'pc3', 0, 'régime', band: '< ±0,5 %/j', inBand: (v) => v.abs() < 0.005),
    Ind('inflMaxAbs', '|Inflation| max / j', 'pc', -1, 'partie'),
    Ind('infl100MaxAbs', '|Inflation sur 100 j| max', 'pc', -1, 'partie'),
    Ind('criticalOpened', 'Alertes critiques ouvertes', 'count', -1, 'partie', band: '0', inBand: (v) => v == 0),
    Ind('criticalSteady', '… dont après la chauffe', 'count', -1, 'régime'),
    Ind('criticalDays', 'Jours-alerte critiques (somme des types)', 'count', -1, 'partie', fn: criticalDays),
    Ind('alertsTotal', 'Alertes ouvertes (toutes)', 'count', -1, 'partie'),
    Ind('healthMean', 'Santé moyenne', 'dec', 1, 'régime'),
    Ind('birthsPerYear', 'Naissances d’entreprises / an', 'dec1', 0, 'partie'),
    Ind('deathsPerYear', 'Morts d’entreprises / an', 'dec1', 0, 'partie'),
    for (final k in funnelSteps) Ind('funnel.$k', 'Entonnoir : ${funnelLabels[k]}', 'count', 0, 'partie'),
    Ind('typesActiveEnd', 'Types d’entreprise actifs en fin', 'count', 1, 'fin'),
    Ind('machinesEnd', 'Machines en fin', 'dec1', 1, 'fin'),
    Ind('lowUtilEnd', 'Équipes utilisées à moins de 15 % (fin)', 'count', -1, 'fin'),
    Ind('happyMean', 'Bonheur moyen', 'dec', 1, 'régime'),
    Ind('waitMean', 'Hôpital public : attente moyenne (j)', 'dec1', -1, 'régime'),
    Ind('benefitCutDays', 'Jours de prestations réduites', 'count', -1, 'régime'),
    Ind('treasuryMin', 'Trésor de l’État le plus bas', 'money', 1, 'régime'),
    Ind('bankNegDays', 'Jours de Caisse insolvable', 'count', -1, 'régime'),
    Ind('refusals', 'Prêts refusés', 'count', 0, 'partie'),
    Ind('writtenOff', 'Créances radiées', 'money', 0, 'partie'),
    if (phase != 'base')
      for (final k in Safeguards.keys.where((k) => !cut.contains(k)))
        Ind('netRates.$k', 'Filet : ${Safeguards.labels[k]} / 50 j', 'dec', -1, 'régime',
            band: '< 1', inBand: (v) => v < 1),
    if (phase != 'base' && !cut.contains('bailout'))
      Ind('bailoutRates.hopital', '… dont renflouements de l’hôpital / 50 j', 'dec', -1, 'régime'),
    Ind('invMax', 'Écart comptable max (\$)', 'exp', -1, 'partie', band: '≤ 1e-8', inBand: (v) => v <= 1e-8),
  ];
}

/// Jours-alerte critiques : pour chaque type critique, les jours où l'alerte est ouverte, additionnés. Une détresse
/// durable compte une ouverture mais beaucoup de jours ; une alerte d'un jour qui revient souvent, l'inverse.
double? criticalDays(Json run) {
  final m = run['alertDays'] as Map?;
  if (m == null) return null;
  return criticalAlerts.fold<double>(0, (a, t) => a + ((m[t] as num?) ?? 0));
}

/// Une ligne par type d'alerte présent dans au moins une partie (ouvertures sur toute la partie) ; avec [days], une
/// ligne de plus pour ses jours-alerte.
List<Ind> alertIndicators(Iterable<Json> runs, {bool criticalOnly = false, bool days = false}) => [
      for (final t in alertLabels.keys)
        if ((!criticalOnly || criticalAlerts.contains(t)) &&
            runs.any((r) => ((r['alertsOpened'] as Map?)?[t] ?? 0) > 0)) ...[
          criticalAlerts.contains(t)
              ? Ind('alertsOpened.$t', alertLabels[t]!, 'count', -1, 'partie', band: '0', inBand: (v) => v == 0)
              : Ind('alertsOpened.$t', alertLabels[t]!, 'count', -1, 'partie'),
          if (days) Ind('alertDays.$t', '… jours-alerte', 'count', -1, 'partie'),
        ],
    ];

Json distributionsJson(String phase, List<Json> runs) => {
      for (final ind in runIndicators(phase))
        if (runs.any((r) => ind.of(r) != null))
          ind.key: () {
            final d = Dist(ind.values(runs));
            return {
              'n': d.n,
              'median': d.median,
              'q1': d.q1,
              'q3': d.q3,
              'min': d.min,
              'max': d.max,
              if (ind.inBand != null) 'outOfBand': d.xs.where((v) => !ind.inBand!(v)).length,
            };
          }(),
    };

class Paired {
  final Ind ind;
  final int n, better, worse, ties;
  final double medA, medB, medD, lo, hi;
  final int outA, outB;
  Paired(this.ind, this.n, this.medA, this.medB, this.medD, this.lo, this.hi, this.better, this.worse, this.ties,
      this.outA, this.outB);

  bool get conclusive => lo > 0 || hi < 0;

  Json toJson() => {
        'n': n,
        'medianA': medA,
        'medianB': medB,
        'medianDiff': medD,
        'ci95': [lo, hi],
        'bBetter': better,
        'bWorse': worse,
        'ties': ties,
        'outOfBandA': outA,
        'outOfBandB': outB,
        'conclusive': conclusive,
      };
}

/// Comparaison appariée de l'indicateur [ind] : les graines présentes des deux côtés, différence B − A par graine.
Paired? pairUp(Ind ind, List<Json> a, List<Json> b) {
  final byA = {for (final r in a) r['seed'] as int: ind.of(r)};
  final xa = <double>[], xb = <double>[], d = <double>[];
  for (final r in b) {
    final va = byA[r['seed'] as int], vb = ind.of(r);
    if (va == null || vb == null) continue;
    xa.add(va);
    xb.add(vb);
    d.add(vb - va);
  }
  if (d.isEmpty) return null;
  final (lo, hi) = bootstrapMedian(d);
  final better = ind.better == 0 ? 0 : d.where((x) => x * ind.better > 0).length;
  final worse = ind.better == 0 ? 0 : d.where((x) => x * ind.better < 0).length;
  int out(List<double> x) => ind.inBand == null ? 0 : x.where((v) => !ind.inBand!(v)).length;
  return Paired(ind, d.length, Dist(xa).median, Dist(xb).median, Dist(d).median, lo, hi, better, worse,
      d.where((x) => x == 0).length, out(xa), out(xb));
}

// ------------------------------------------------------------------ mise en forme

String pc(double v, [int d = 1]) => '${(v * 100).toStringAsFixed(d).replaceAll('.', ',')} %';
String dec(double v, [int d = 2]) => v.toStringAsFixed(d).replaceAll('.', ',');
String ok(bool b) => b ? '✅' : '❌';

String row(List<Object?> cells) => '| ${cells.map((c) => c ?? '').join(' | ')} |';
String sep(int n) => '|${List.filled(n, '---').join('|')}|';

String fmtV(String kind, double v) {
  if (v.isInfinite) return v > 0 ? '+∞' : '−∞';
  return switch (kind) {
    'pc' => pc(v),
    'pc3' => pc(v, 3),
    'count' => v == v.roundToDouble() ? v.round().toString() : dec(v, 1),
    'money' => fmtMoney0(v),
    'exp' => v.toStringAsExponential(1),
    'dec1' => dec(v, 1),
    _ => dec(v),
  };
}

/// Une différence, signée ; en points pour un pourcentage. Une différence non nulle n'est jamais écrite « 0 » : on
/// ajoute des décimales (une borne d'intervalle à −0,003 ne doit pas se lire −0,00).
String fmtD(String kind, double d) {
  if (d.isInfinite) return d > 0 ? '+∞' : '−∞';
  final s = d > 0 ? '+' : (d < 0 ? '−' : '');
  final a = d.abs();
  String nz(double x, int places) {
    var p = places;
    while (x != 0 && p < places + 4 && double.parse(x.toStringAsFixed(p)) == 0) {
      p++;
    }
    return dec(x, p);
  }

  return s +
      switch (kind) {
        'pc' => '${nz(a * 100, 1)} pt',
        'pc3' => '${nz(a * 100, 3)} pt',
        'count' => a == a.roundToDouble() ? a.round().toString() : dec(a, 1),
        'money' => fmtMoney0(a),
        'exp' => a.toStringAsExponential(1),
        'dec1' => nz(a, 1),
        _ => nz(a, 2),
      };
}

const Map<String, String> periodLabels = {'régime': 'après chauffe', 'partie': 'toute la partie', 'fin': 'dernier jour'};

/// Graines hors bande, avec leur valeur : « 3/30 : g4 12,1 %, g9 11,0 %, … ».
String seedsOut(Ind ind, List<Json> runs, {int show = 8}) {
  final bad = [
    for (final r in runs)
      if (ind.of(r) != null && !ind.inBand!(ind.of(r)!)) 'g${r['seed']} ${fmtV(ind.kind, ind.of(r)!)}',
  ];
  if (bad.isEmpty) return 'aucune graine sur ${runs.length}';
  return '${bad.length}/${runs.length} : ${bad.take(show).join(', ')}${bad.length > show ? ', …' : ''}';
}

void distTable(StringBuffer b, List<Ind> inds, List<Json> runs) {
  b.writeln(row(['Indicateur', 'Mesuré sur', 'Bande', 'Médiane', 'EIQ (Q1–Q3)', 'Min–max', 'Graines hors bande']));
  b.writeln(sep(7));
  for (final ind in inds) {
    final xs = ind.values(runs);
    if (xs.isEmpty) continue;
    final d = Dist(xs);
    final out = ind.inBand == null ? '—' : '${d.xs.where((v) => !ind.inBand!(v)).length}/${d.n}';
    b.writeln(row([
      ind.label, periodLabels[ind.period], ind.band.isEmpty ? '—' : ind.band, fmtV(ind.kind, d.median),
      '${fmtD(ind.kind, d.q3 - d.q1).replaceFirst(RegExp(r'^\+'), '')} (${fmtV(ind.kind, d.q1)} – ${fmtV(ind.kind, d.q3)})',
      '${fmtV(ind.kind, d.min)} – ${fmtV(ind.kind, d.max)}', out,
    ]));
  }
  b.writeln();
}

void pairedTable(StringBuffer b, List<Ind> inds, List<Json> a, List<Json> c, Json? store) {
  b.writeln(row(['Indicateur', 'Médiane A', 'Médiane B', 'Hors bande A → B', 'Différence médiane (B − A)',
    'IC 95 %', 'B mieux / moins bien / égal', 'Conclusion']));
  b.writeln(sep(8));
  for (final ind in inds) {
    final p = pairUp(ind, a, c);
    if (p == null) continue;
    store?[ind.key] = p.toJson();
    final dir = p.medD > 0 ? 'B plus haut' : 'B plus bas';
    final verdict = !p.conclusive
        ? 'non concluant'
        : '**$dir${ind.better == 0 ? '' : ((p.medD * ind.better > 0) ? ' (mieux)' : ' (moins bien)')}**';
    b.writeln(row([
      ind.label, fmtV(ind.kind, p.medA), fmtV(ind.kind, p.medB),
      ind.inBand == null ? '—' : '${p.outA} → ${p.outB}',
      fmtD(ind.kind, p.medD), '[${fmtD(ind.kind, p.lo)} ; ${fmtD(ind.kind, p.hi)}]',
      ind.better == 0 ? '— / — / ${p.ties}' : '${p.better} / ${p.worse} / ${p.ties} sur ${p.n}', verdict,
    ]));
  }
  b.writeln();
}

const String pairedMethod =
    'Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : '
    'intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine '
    'du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre '
    'de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, '
    'filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, '
    'créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur '
    '40 lignes, une ou deux conclusions peuvent venir du hasard.';

// ------------------------------------------------------------------ critères de sortie

class Exit {
  final String label;
  final bool pass;
  final String detail;
  Exit(this.label, this.pass, this.detail);
}

Ind _ind(String phase, String key) => runIndicators(phase).firstWhere((i) => i.key == key);

/// Critère de réussite d'une institution : avec le filet qu'elle remplace coupé, l'économie tient.
List<Exit> saufCriteria(String phase, List<Json> runs) {
  final what = phaseCut(phase).map((k) => Safeguards.labels[k]).join(', ');
  final hunger = _ind(phase, 'hungerMean'), homeless = _ind(phase, 'homelessMean');
  final hh = runs.where((r) => !hunger.inBand!(hunger.of(r)!) || !homeless.inBand!(homeless.of(r)!)).map((r) => 'g${r['seed']}');
  return [
    Exit('Sans « $what » : chômage moyen ≤ 10 %', _allIn(phase, 'unempMean', runs), seedsOut(_ind(phase, 'unempMean'), runs)),
    Exit('Sans « $what » : faim et sans-abri < 2 %', hh.isEmpty,
        hh.isEmpty ? 'aucune graine sur ${runs.length}' : '${hh.length}/${runs.length} : ${hh.take(10).join(', ')}${hh.length > 10 ? ', …' : ''}'),
    Exit('Sans « $what » : aucune alerte critique', _allIn(phase, 'criticalOpened', runs),
        seedsOut(_ind(phase, 'criticalOpened'), runs)),
  ];
}

bool _allIn(String phase, String key, List<Json> runs) {
  final ind = _ind(phase, key);
  return runs.every((r) => ind.of(r) == null || ind.inBand!(ind.of(r)!));
}

List<Exit> exitCriteria(Map<String, List<Json>> phases, List<Json> shocks) {
  final out = <Exit>[];
  final base = phases['base'] ?? const <Json>[];
  if (base.isNotEmpty) {
    Exit e(String label, String key) => Exit(label, _allIn('base', key, base), seedsOut(_ind('base', key), base));
    out.add(e('Aucune alerte critique (sans filets)', 'criticalOpened'));
    out.add(e('Chômage moyen ≤ 10 %', 'unempMean'));
    final hunger = _ind('base', 'hungerMean'), homeless = _ind('base', 'homelessMean');
    final hh = base.where((r) => !hunger.inBand!(hunger.of(r)!) || !homeless.inBand!(homeless.of(r)!)).map((r) => 'g${r['seed']}').toList();
    out.add(Exit('Faim et sans-abri < 2 %', hh.isEmpty,
        hh.isEmpty ? 'aucune graine sur ${base.length}' : '${hh.length}/${base.length} : ${hh.take(10).join(', ')}${hh.length > 10 ? ', …' : ''}'));
    out.add(e('Gini 0,2–0,45', 'giniMean'));
    out.add(e('Inflation moyenne < ±0,5 %/j', 'inflMean'));
    out.add(e('Invariant comptable à 1e-8 près', 'invMax'));
    final crashed = base.where((r) => r['crash'] != null).map((r) => 'g${r['seed']}');
    if (crashed.isNotEmpty) out.add(Exit('Aucune exception', false, crashed.join(', ')));
  }
  final nets = phases['nets'] ?? const <Json>[];
  if (nets.isNotEmpty) {
    final bad = <String>[];
    for (final k in Safeguards.keys) {
      final ind = _ind('nets', 'netRates.$k');
      final n = nets.where((r) => !ind.inBand!(ind.of(r)!)).length;
      if (n > 0) bad.add('${Safeguards.labels[k]} : $n/${nets.length} graines');
    }
    out.add(Exit('Filets : < 1 déclenchement / 50 j en régime, dans chaque graine', bad.isEmpty,
        bad.isEmpty ? 'tous les filets, toutes les graines' : bad.join(' ; ')));
  }
  for (final withNets in [false, true]) {
    final list = shocks.where((s) => s['nets'] == withNets).toList();
    if (list.isEmpty) continue;
    final fail = list.where((s) => s['recoverAbs'] == null || (s['recoverAbs'] as int) > 200).toList();
    final so = fail.where((s) => s['collapsedBefore'] == true).length;
    out.add(Exit('Chaque choc revient à l’équilibre en < 200 j (${withNets ? 'avec' : 'sans'} filets)', fail.isEmpty,
        fail.isEmpty
            ? 'tous (${list.length})'
            : '${fail.length}/${list.length} échecs${so > 0 ? ' (dont $so sur économie déjà effondrée)' : ''}'));
  }
  return out;
}

// ------------------------------------------------------------------ rapport d'une configuration

String seedList(List<int> s) {
  final sorted = [...s]..sort();
  final contiguous = sorted.length > 2 && sorted.last - sorted.first == sorted.length - 1;
  return contiguous ? '${sorted.first} à ${sorted.last} (${sorted.length})' : '${sorted.join(', ')} (${sorted.length})';
}

String duration(double s) => s < 120 ? '${s.round()} s' : '${(s / 60).floor()} min ${(s % 60).round()} s';

void headerLines(StringBuffer b, Json sum, {String prefix = ''}) {
  final off = (sum['modulesOff'] as List).cast<String>();
  final params = (sum['params'] as Map? ?? const {}).cast<String, dynamic>();
  b.writeln('- ${prefix}Modules coupés : ${off.isEmpty ? 'aucun' : off.map((k) => Modules.labels[k] ?? k).join(', ')}');
  if (params.isNotEmpty) {
    b.writeln('- ${prefix}Paramètres changés : ${params.entries.map((e) => '${e.key} = ${e.value}').join(', ')}');
  }
}

void warmupLine(StringBuffer b, int days, int warmup) {
  b.writeln('- Période de chauffe : jours 1 à $warmup ($warmup jours sur $days), exclus des moyennes, des taux de '
      'filets et des renflouements (« après chauffe », jours ${warmup + 1} à $days). Les maxima, les alertes ouvertes, '
      'les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les '
      'alertes critiques ouvertes après la chauffe.');
}

String report(Json sum) {
  final b = StringBuffer();
  final phases = phasesOf(sum);
  final shocks = [for (final s in sum['shocks'] as List) (s as Map).cast<String, dynamic>()];
  b.writeln('# Protocole de stabilité ÉcoNodes');
  b.writeln();
  b.writeln('- Date : ${DateTime.now().toIso8601String().substring(0, 16).replaceAll('T', ' ')}');
  final days = sum['days'] as int;
  b.writeln('- Graines : ${seedList((sum['seeds'] as List).cast<int>())} · $days jours');
  warmupLine(b, days, sum['warmup'] as int);
  headerLines(b, sum);
  if (sum['seconds'] != null) {
    b.writeln('- Temps total : ${duration((sum['seconds'] as num).toDouble())} pour ${sum['runs']} parties, au plus '
        '${sum['isolates']} à la fois (un isolat par partie)');
  }
  b.writeln('- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, '
      'interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.');
  b.writeln();

  final ordered = phases.keys.toList()..sort((x, y) => phaseOrder(x).compareTo(phaseOrder(y)));
  var bis = 0;
  final saufCount = ordered.where((p) => p.startsWith('sauf:')).length;
  for (final phase in ordered) {
    final runsP = phases[phase]!;
    final title = switch (phase) {
      'base' => '## 1. Sans filets',
      'nets' => '## 2. Avec filets',
      _ => '## 2 bis${saufCount > 1 ? ' (${++bis})' : ''}. ${phaseLabel(phase)}',
    };
    b.writeln(title);
    b.writeln();
    distTable(b, runIndicators(phase), runsP);
    for (final r in runsP.where((r) => r['crash'] != null)) {
      b.writeln('⚠ Graine ${r['seed']} interrompue : ${r['crash']}');
      b.writeln();
    }
    if (phase == 'base') {
      b.writeln('### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)');
      b.writeln();
      alertTable(b, runsP);
    }
    if (phase != 'base') netsTable(b, runsP, phaseCut(phase));
    if (phase.startsWith('sauf:') && phases['nets'] != null) {
      b.writeln('### Effet de la coupure, apparié : A = avec filets, B = ${phaseLabel(phase).toLowerCase()}');
      b.writeln();
      pairedTable(b, runIndicators(phase), phases['nets']!, runsP, null);
    }
    seedDetails(b, runsP, phase);
  }

  if (shocks.isNotEmpty) shockSection(b, sum, shocks);

  b.writeln('## Critères de sortie');
  b.writeln();
  b.writeln('Un critère est rempli si aucune graine n’est hors bande.');
  b.writeln();
  b.writeln(row(['Critère', 'Résultat', 'Graines hors bande']));
  b.writeln(sep(3));
  for (final e in exitCriteria(phases, shocks)) {
    b.writeln(row([e.label, ok(e.pass), e.detail]));
  }
  b.writeln();
  for (final phase in ordered.where((p) => p.startsWith('sauf:'))) {
    b.writeln('### Critère de l’institution : ${phaseLabel(phase).toLowerCase()}');
    b.writeln();
    b.writeln(row(['Critère', 'Résultat', 'Graines hors bande']));
    b.writeln(sep(3));
    for (final e in saufCriteria(phase, phases[phase]!)) {
      b.writeln(row([e.label, ok(e.pass), e.detail]));
    }
    b.writeln();
  }
  return b.toString();
}

void alertTable(StringBuffer b, List<Json> runs) {
  final inds = alertIndicators(runs);
  if (inds.isEmpty) {
    b.writeln('Aucune alerte.');
    b.writeln();
    return;
  }
  b.writeln(row(['Type', 'Gravité', 'Graines touchées', 'Ouvertures : médiane', 'EIQ (Q1–Q3)', 'Min–max',
    'Jours-alerte : médiane']));
  b.writeln(sep(7));
  for (final ind in inds) {
    final t = ind.key.substring('alertsOpened.'.length);
    final d = Dist(ind.values(runs));
    final days = Dist(Ind('alertDays.$t', '', 'count', 0, 'partie').values(runs));
    b.writeln(row([
      ind.label, criticalAlerts.contains(t) ? 'critique' : 'attention', '${d.xs.where((v) => v > 0).length}/${d.n}',
      fmtV('count', d.median), '${fmtV('count', d.q1)} – ${fmtV('count', d.q3)}',
      '${fmtV('count', d.min)} – ${fmtV('count', d.max)}', days.n == 0 ? '—' : '${fmtV('count', days.median)} j',
    ]));
  }
  b.writeln();
}

void netsTable(StringBuffer b, List<Json> runs, Set<String> cut) {
  b.writeln('### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)');
  b.writeln();
  b.writeln(row(['Filet', 'Médiane / 50 j', 'EIQ (Q1–Q3)', 'Min–max', 'Graines ≥ 1 / 50 j', 'Déclenchements (total)',
    'Causes principales']));
  b.writeln(sep(7));
  for (final k in Safeguards.keys) {
    if (cut.contains(k)) {
      b.writeln(row([Safeguards.labels[k], 'coupé', '—', '—', '—', '—', '—']));
      continue;
    }
    final ind = Ind('netRates.$k', '', 'dec', -1, 'régime');
    final d = Dist(ind.values(runs));
    final causes = <String, int>{};
    var total = 0;
    for (final r in runs) {
      total += ((r['netsTotal'] as Map?)?[k] as int?) ?? 0;
      for (final e in (((r['netsCauses'] as Map?)?[k] as Map?) ?? const {}).entries) {
        causes[e.key as String] = (causes[e.key] ?? 0) + (e.value as int);
      }
    }
    final all = causes.values.fold(0, (a, c) => a + c);
    final sorted = causes.entries.toList()..sort((x, y) => y.value.compareTo(x.value));
    b.writeln(row([
      Safeguards.labels[k], fmtV('dec', d.median), '${fmtV('dec', d.q1)} – ${fmtV('dec', d.q3)}',
      '${fmtV('dec', d.min)} – ${fmtV('dec', d.max)}', '${d.xs.where((v) => v >= 1).length}/${d.n}', total,
      sorted.isEmpty ? '—' : sorted.take(2).map((e) => '${e.key} (${(100 * e.value / all).round()} %)').join(' ; '),
    ]));
  }
  b.writeln();
  final types = <String, int>{};
  final seedsHit = <String, int>{};
  for (final r in runs) {
    for (final e in ((r['bailoutByType'] as Map?) ?? const {}).entries) {
      types[e.key as String] = (types[e.key] ?? 0) + (e.value as int);
      seedsHit[e.key as String] = (seedsHit[e.key] ?? 0) + 1;
    }
  }
  if (types.isNotEmpty) {
    final l = types.entries.toList()..sort((x, y) => y.value.compareTo(x.value));
    b.writeln('Renflouements en régime, par type d’entreprise (total sur ${runs.length} graines · graines touchées) : '
        '${l.take(8).map((e) => '${templates[e.key]?.label ?? e.key} ${e.value} · ${seedsHit[e.key]}').join(', ')}.');
    b.writeln();
  }
}

void seedDetails(StringBuffer b, List<Json> runs, String phase) {
  double v(Json r, String k) => (r[k] as num?)?.toDouble() ?? double.nan;
  b.writeln('<details><summary>Détail par graine (${phaseLabel(phase).toLowerCase()})</summary>');
  b.writeln();
  b.writeln(row(['Graine', 'Chômage moy.', 'Chômage max', 'Faim moy.', 'Sans-abri moy.', 'Gini moy.',
    'Inflation moy./j', 'Alertes (crit.)', 'Santé', 'Primaire / secondaire / tertiaire', 'Sans employé', 'Dette finale']));
  b.writeln(sep(12));
  for (final r in runs) {
    final sh = [for (final x in (r['sectorShare'] as List? ?? const [])) (x as num).toDouble()];
    b.writeln(row([
      r['crash'] == null ? r['seed'] : '${r['seed']} ⚠', pc(v(r, 'unempMean')), pc(v(r, 'unempMax')),
      pc(v(r, 'hungerMean')), pc(v(r, 'homelessMean')), dec(v(r, 'giniMean')), pc(v(r, 'inflMean'), 3),
      '${r['alertsTotal']} (${r['criticalOpened']})', dec(v(r, 'healthMean')),
      sh.length == 3 ? sh.map((x) => pc(x, 0)).join(' / ') : '—', r['firmsWithoutStaff'] ?? '—',
      r['debtEnd'] == null ? '—' : fmtMoney0(v(r, 'debtEnd')),
    ]));
  }
  b.writeln();
  b.writeln('</details>');
  b.writeln();
}

void shockSection(StringBuffer b, Json sum, List<Json> shocks) {
  b.writeln('## 3. Chocs standard (choc au jour ${sum['shockDay'] ?? 300}, observé ${sum['shockHorizon'] ?? 500} jours)');
  b.writeln();
  b.writeln('Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, '
      'inflation moyenne < 0,5 %/j et aucune alerte critique. « Effondrée » : chômage moyen > 50 % avant le choc, '
      'l’évaluation n’a pas de sens. Un choc non résorbé compte comme une durée infinie dans la médiane.');
  b.writeln();
  for (final withNets in [false, true]) {
    final list = shocks.where((s) => s['nets'] == withNets).toList();
    if (list.isEmpty) continue;
    b.writeln('### ${withNets ? 'Avec filets' : 'Sans filets'}');
    b.writeln();
    b.writeln(row(['Choc', 'Graines', 'Effondrée avant', 'Équilibre avant', 'Résorbé < 200 j', 'Retour (j) : médiane',
      'EIQ (Q1–Q3)', 'Pic de chômage : médiane (Q1–Q3)', 'Alertes déclenchées (total, les plus fréquentes)']));
    b.writeln(sep(9));
    String days(double v) => v.isInfinite ? 'non résorbé' : v.round().toString();
    for (final kind in shockLabels.keys) {
      final k = list.where((s) => s['kind'] == kind).toList();
      if (k.isEmpty) continue;
      final rec = Dist([for (final s in k) (s['recoverAbs'] as num?)?.toDouble() ?? double.infinity]);
      final peak = Dist([for (final s in k) (s['peakUnemp'] as num).toDouble()]);
      final al = <String, int>{};
      for (final s in k) {
        for (final e in (s['alerts'] as Map).entries) {
          al[e.key as String] = (al[e.key] ?? 0) + (e.value as int);
        }
      }
      final top = al.entries.toList()..sort((x, y) => y.value.compareTo(x.value));
      final crashed = k.where((s) => s['crash'] != null).length;
      b.writeln(row([
        shockLabels[kind], k.length, k.where((s) => s['collapsedBefore'] == true).length,
        k.where((s) => s['preInBand'] == true).length,
        k.where((s) => s['recoverAbs'] != null && (s['recoverAbs'] as int) <= 200).length,
        days(rec.median), '${days(rec.q1)} – ${days(rec.q3)}',
        '${pc(peak.median)} (${pc(peak.q1)} – ${pc(peak.q3)})',
        '${crashed > 0 ? '⚠ $crashed interrompue(s) ; ' : ''}'
            '${top.take(4).map((e) => '${alertLabels[e.key] ?? e.key} ×${e.value}').join(', ')}',
      ]));
    }
    b.writeln();
  }
}

// ------------------------------------------------------------------ rapport de comparaison appariée

String compareReport(Options o, Json a, Json c, double seconds, int runs, Json store) {
  final b = StringBuffer();
  final pa = phasesOf(a), pb = phasesOf(c);
  final common = pa.keys.where(pb.containsKey).toList()..sort((x, y) => phaseOrder(x).compareTo(phaseOrder(y)));
  final seedsA = {for (final l in pa.values) for (final r in l) r['seed'] as int};
  final seedsB = {for (final l in pb.values) for (final r in l) r['seed'] as int};
  final both = seedsA.intersection(seedsB).toList()..sort();
  b.writeln('# Comparaison appariée ÉcoNodes');
  b.writeln();
  b.writeln('- Date : ${DateTime.now().toIso8601String().substring(0, 16).replaceAll('T', ' ')}');
  b.writeln('- A : `${a['label']}`');
  headerLines(b, a, prefix: 'A — ');
  b.writeln('- B : `${c['label']}`');
  headerLines(b, c, prefix: 'B — ');
  b.writeln('- Graines appariées : ${seedList(both)} · ${a['days']} jours');
  warmupLine(b, a['days'] as int, a['warmup'] as int);
  b.writeln('- Temps total : ${duration(seconds)}${runs > 0 ? ' pour $runs parties, au plus ${o.isolates} à la fois (un isolat par partie)' : ' (synthèses relues, aucune partie lancée)'}');
  b.writeln();
  b.writeln(pairedMethod);
  b.writeln();
  final conclusions = <String>[];
  for (final phase in common) {
    final st = store[phase] = <String, dynamic>{};
    b.writeln('## ${phaseLabel(phase)}');
    b.writeln();
    pairedTable(b, runIndicators(phase), pa[phase]!, pb[phase]!, st);
    final crit = alertIndicators([...pa[phase]!, ...pb[phase]!], criticalOnly: true, days: true);
    if (crit.isNotEmpty) {
      b.writeln('### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)');
      b.writeln();
      pairedTable(b, crit, pa[phase]!, pb[phase]!, st);
    }
    for (final ind in [...runIndicators(phase), ...crit]) {
      final p = st[ind.key] as Json?;
      final label = ind.key.startsWith('alertDays.')
          ? '${alertLabels[ind.key.substring(10)]} : jours-alerte'
          : (ind.label.startsWith('…') ? '${ind.label.substring(2)} (${ind.key})' : ind.label);
      if (p == null || p['conclusive'] != true) continue;
      final d = (p['medianDiff'] as num).toDouble();
      final ci = (p['ci95'] as List).cast<num>();
      conclusions.add('${phaseLabel(phase)} — $label : ${fmtD(ind.kind, d)} '
          '[${fmtD(ind.kind, ci[0].toDouble())} ; ${fmtD(ind.kind, ci[1].toDouble())}]'
          '${ind.better == 0 ? '' : (d * ind.better > 0 ? ', B mieux' : ', B moins bien')} '
          '(${p['bBetter']} graines mieux, ${p['bWorse']} moins bien, ${p['ties']} égales)');
    }
  }
  b.writeln('## Effets concluants (intervalle excluant 0)');
  b.writeln();
  if (conclusions.isEmpty) {
    b.writeln('Aucun.');
  } else {
    for (final l in conclusions) {
      b.writeln('- $l');
    }
  }
  b.writeln();
  return b.toString();
}

// ------------------------------------------------------------------ point d'entrée

Future<void> main(List<String> args) async {
  final o = Options(args);
  final sw = Stopwatch()..start();
  void progress(String m) => stderr.writeln('[${(sw.elapsedMilliseconds / 1000).toStringAsFixed(0).padLeft(4)} s] $m');
  void write(String? path, String content, String what) {
    if (path == null) return;
    File(path).parent.createSync(recursive: true);
    File(path).writeAsStringSync(content);
    progress('$what : $path');
  }

  if (o.reread != null) {
    final md = report(loadSummary(o.reread!));
    if (o.out != null) {
      write(o.out, md, 'rapport écrit');
    } else {
      stdout.write(md);
    }
    return;
  }

  if (o.compare == null) {
    final tasks = tasksFor(0, o.config, o, shocks: o.phases.contains('chocs'));
    final results = await runAll(tasks, o.isolates, progress);
    final seconds = sw.elapsedMilliseconds / 1000;
    final sum = summaryOf(o.config, o, tasks, results, 0, seconds);
    final md = report(sum);
    if (o.out != null) {
      write(o.out, md, 'rapport écrit');
    } else {
      stdout.write(md);
    }
    write(o.save, jsonEncode(sum), 'synthèse enregistrée');
    progress('terminé : ${tasks.length} parties en ${duration(seconds)}');
    return;
  }

  // comparaison appariée : chaque opérande est une synthèse enregistrée ou une configuration lancée ici
  final ops = [...o.compare!, if (o.compare!.length == 1) 'ref'];
  final tasks = <Task>[];
  final configs = <Config?>[];
  for (var i = 0; i < 2; i++) {
    if (ops[i].endsWith('.json')) {
      configs.add(null);
    } else {
      final c = o.config.apply(ops[i]);
      configs.add(c);
      tasks.addAll(tasksFor(i, c, o, shocks: false, tag: '${i == 0 ? 'A' : 'B'} · '));
    }
  }
  final results = await runAll(tasks, o.isolates, progress);
  final seconds = sw.elapsedMilliseconds / 1000;
  final sums = [
    for (var i = 0; i < 2; i++)
      configs[i] == null ? loadSummary(ops[i]) : summaryOf(configs[i]!, o, tasks, results, i, seconds),
  ];
  if (sums[0]['days'] != sums[1]['days'] || sums[0]['warmup'] != sums[1]['warmup']) {
    throw StateError('A et B n’ont pas la même durée ou la même chauffe : '
        '${sums[0]['days']}/${sums[0]['warmup']} contre ${sums[1]['days']}/${sums[1]['warmup']} jours');
  }
  final store = <String, dynamic>{};
  final md = compareReport(o, sums[0], sums[1], seconds, tasks.length, store);
  if (o.out != null) {
    write(o.out, md, 'rapport écrit');
  } else {
    stdout.write(md);
  }
  write(
      o.save,
      const JsonEncoder.withIndent('  ').convert({
        'mode': 'compare',
        'A': configs[0] == null ? ops[0] : sums[0],
        'B': configs[1] == null ? ops[1] : sums[1],
        'comparison': store,
      }),
      'comparaison enregistrée');
  progress('terminé : ${tasks.length} parties en ${duration(seconds)}');
}
