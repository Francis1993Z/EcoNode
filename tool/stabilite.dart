// Protocole de stabilité d'ÉcoNodes, sans interface (moteur seul).
//
//   dart run tool/stabilite.dart [options]
//
//   --seeds 1,2,3,4,5        graines (défaut : 1 à 5)
//   --days 1500              durée de chaque partie
//   --warmup 100             jours de régime transitoire exclus des moyennes
//   --phases base,nets,chocs étapes à exécuter (défaut : les trois)
//   --sauf bailout           ajoute une étape « avec filets sauf ceux-là » (critère de réussite d'une institution :
//                            le filet qu'elle remplace coupé, l'économie doit tenir)
//   --shock-seeds 1,2,3      graines des chocs (défaut : 1, 2, 3)
//   --shock-day 300          jour du choc ; on observe ensuite 500 jours
//   --shock-nets both        chocs sans filets (off), avec filets (on) ou les deux (both)
//   --modules credit=0,...   coupe (0) ou active (1) des modules
//   --noyau                  coupe tous les modules ajoutés au modèle de base (les institutions restent actives)
//   --param nom=valeur       change un paramètre (variantes mesurées ; voir applyParam)
//   --key raffinerie         type de la « firme clé » mise en faillite
//   --out rapport.md         écrit le rapport Markdown (sinon : sortie standard)
//   --save synthese.json     enregistre la synthèse chiffrée
//   --compare avant.json     ajoute un tableau AVANT / APRÈS
//
// Étapes : 1) filets coupés ; 2) filets actifs (déclenchements comptés) ; 2 bis) filets actifs sauf ceux de --sauf ;
// 3) chocs standard, sans puis avec filets.

import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/monitor.dart';
import 'package:econodes/engine/sim.dart';

// ------------------------------------------------------------------ options

class Options {
  List<int> seeds = [1, 2, 3, 4, 5];
  int days = 1500;
  int warmup = 100;
  Set<String> phases = {'base', 'nets', 'chocs'};
  List<int> shockSeeds = [1, 2, 3];
  int shockDay = 300;
  int shockHorizon = 500;
  Set<String> shockNets = {'off', 'on'};
  Set<String> sauf = {}; // filets coupés à l'étape 2 bis
  Map<String, String> params = {}; // paramètres changés (--param)
  Modules modules = Modules();

  Params newParams() {
    final p = Params();
    for (final e in params.entries) {
      applyParam(p, e.key, e.value);
    }
    return p;
  }
  String keyFirm = 'raffinerie';
  String? out;
  String? save;
  String? compare;

  Options(List<String> args) {
    for (var i = 0; i < args.length; i++) {
      final a = args[i];
      String next() {
        if (i + 1 >= args.length) throw ArgumentError('Valeur manquante après $a');
        return args[++i];
      }

      switch (a) {
        case '--seeds':
          seeds = next().split(',').map(int.parse).toList();
        case '--days':
          days = int.parse(next());
        case '--warmup':
          warmup = int.parse(next());
        case '--phases':
          phases = next().split(',').toSet();
        case '--shock-seeds':
          shockSeeds = next().split(',').map(int.parse).toList();
        case '--shock-day':
          shockDay = int.parse(next());
        case '--shock-nets':
          final v = next();
          shockNets = v == 'both' ? {'off', 'on'} : {v};
        case '--noyau':
          modules = Modules.noyau();
        case '--sauf':
          sauf = next().split(',').toSet();
          for (final k in sauf) {
            Safeguards().get(k); // filet inconnu : erreur tout de suite
          }
        case '--modules':
          for (final kv in next().split(',')) {
            final p = kv.split('=');
            modules.set(p[0], p.length < 2 || p[1] != '0');
          }
        case '--param':
          for (final kv in next().split(',')) {
            final i = kv.indexOf('=');
            if (i < 0) throw ArgumentError('Paramètre sans valeur : $kv');
            params[kv.substring(0, i)] = kv.substring(i + 1);
            applyParam(Params(), kv.substring(0, i), kv.substring(i + 1)); // nom inconnu : erreur tout de suite
          }
        case '--key':
          keyFirm = next();
        case '--out':
          out = next();
        case '--save':
          save = next();
        case '--compare':
          compare = next();
        default:
          throw ArgumentError('Option inconnue : $a');
      }
    }
  }
}

/// Paramètres modifiables en ligne de commande, pour mesurer une variante.
void applyParam(Params p, String k, String v) {
  bool b() => v == '1' || v == 'true';
  switch (k) {
    case 'dividendFromRetained':
      p.dividendFromRetained = b();
    default:
      throw ArgumentError('Paramètre inconnu : $k');
  }
}

// ------------------------------------------------------------------ mesures d'une partie

class RunStats {
  final int seed;
  final bool nets;
  int steady = 0; // jours comptés dans les moyennes
  double unempSum = 0, unempMax = 0, unempMin = 1;
  double hungerSum = 0, hungerMax = 0;
  double homelessSum = 0, homelessMax = 0;
  double giniSum = 0, giniEnd = 0;
  double happySum = 0;
  double healthSum = 0; // santé moyenne de la population
  double waitSum = 0, queueSum = 0; // hôpital public : attente moyenne et file
  Map<String, int> bailoutByType = {}; // renflouements en régime, par type d'entreprise
  double inflMaxAbs = 0, infl100MaxAbs = 0;
  double cpiAtWarmup = 1, cpiEnd = 1;
  double invMax = 0;
  Map<String, int> alertsOpened = {};
  Map<String, int> alertDays = {};
  Map<String, int> netsTotal = {};
  Map<String, int> netsSteady = {};
  Map<String, String> netsTopCause = {};
  Map<String, Map<String, int>> netsCauses = {};
  List<double> sectorShare = [0, 0, 0];
  double debtEnd = 0, lent = 0, writtenOff = 0;
  int firmsWithoutStaff = 0;
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
  int get criticalOpened =>
      alertsOpened.entries.where((e) => criticalAlerts.contains(e.key)).fold(0, (a, e) => a + e.value);
  int get alertsTotal => alertsOpened.values.fold(0, (a, b) => a + b);

  /// Déclenchements par 50 jours en régime normal.
  double netRate(String k) => steady > 0 ? (netsSteady[k] ?? 0) * 50 / steady : 0;

  Map<String, dynamic> toJson() => {
        'seed': seed,
        'nets': nets,
        'unempMean': unempMean,
        'unempMax': unempMax,
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
        'inflMean': inflMean,
        'inflMaxAbs': inflMaxAbs,
        'infl100MaxAbs': infl100MaxAbs,
        'invMax': invMax,
        'criticalOpened': criticalOpened,
        'alertsTotal': alertsTotal,
        'alertsOpened': alertsOpened,
        'netsSteady': netsSteady,
        'netsTotal': netsTotal,
        'netsCauses': netsCauses,
        'netRates': {for (final k in Safeguards.keys) k: netRate(k)},
        'sectorShare': sectorShare,
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
  }
  final tot = emp.fold(0, (a, b) => a + b);
  r.sectorShare = [for (final e in emp) tot > 0 ? e / tot : 0.0];
  r.debtEnd = s.totalDebt();
  r.lent = s.bank.lent;
  r.writtenOff = s.bank.writtenOff;
}

RunStats runBase(int seed, Options o, bool nets, {Set<String> except = const {}}) {
  final sg = nets ? Safeguards() : Safeguards.none();
  for (final k in except) {
    sg.set(k, false);
  }
  final s = Sim(seed: seed, params: o.newParams(), modules: o.modules.copy(), safeguards: sg);
  final r = RunStats(seed, nets);
  try {
    for (var d = 1; d <= o.days; d++) {
      s.step();
      observe(s, r, o.warmup);
    }
  } catch (e) {
    r.crash = 'j${s.day} : $e';
  }
  finish(s, r);
  return r;
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

ShockStats runShock(String kind, int seed, Options o, bool nets) {
  final s = Sim(seed: seed, params: o.newParams(), modules: o.modules.copy(), safeguards: nets ? Safeguards() : Safeguards.none());
  final r = ShockStats(kind, seed, nets);
  const window = 30;
  try {
    final pre = <_Day>[];
    for (var d = 1; d <= o.shockDay; d++) {
      s.step();
      if (d > o.shockDay - 100) pre.add(_snap(s));
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
        final f = s.firms.where((f) => f.type == o.keyFirm).toList();
        if (f.isNotEmpty) {
          r.detail = f.first.name;
          s.godBankrupt(f.first.id);
        }
    }
    final post = <_Day>[];
    for (var d = 1; d <= o.shockHorizon; d++) {
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
  return r;
}

// ------------------------------------------------------------------ rapport

String pc(double v, [int d = 1]) => '${(v * 100).toStringAsFixed(d).replaceAll('.', ',')} %';
String dec(double v, [int d = 2]) => v.toStringAsFixed(d).replaceAll('.', ',');
String ok(bool b) => b ? '✅' : '❌';

String row(List<Object?> cells) => '| ${cells.map((c) => c ?? '').join(' | ')} |';
String sep(int n) => '|${List.filled(n, '---').join('|')}|';

class Exit {
  final String label;
  final bool pass;
  final String detail;
  Exit(this.label, this.pass, this.detail);
}

/// Critère de réussite d'une institution : avec le filet qu'elle remplace coupé, l'économie tient.
List<Exit> saufCriteria(List<RunStats> sauf, Options o) {
  final out = <Exit>[];
  if (sauf.isEmpty) return out;
  final what = o.sauf.map((k) => Safeguards.labels[k]).join(', ');
  final u = sauf.where((r) => r.unempMean > 0.10).map((r) => 'g${r.seed} ${pc(r.unempMean)}');
  out.add(Exit('Sans « $what » : chômage moyen ≤ 10 %', u.isEmpty, u.isEmpty ? 'toutes les graines' : u.join(', ')));
  final hh = sauf.where((r) => r.hungerMean >= 0.02 || r.homelessMean >= 0.02).map((r) => 'g${r.seed}');
  out.add(Exit('Sans « $what » : faim et sans-abri < 2 %', hh.isEmpty, hh.isEmpty ? 'toutes les graines' : hh.join(', ')));
  final crit = sauf.fold(0, (a, r) => a + r.criticalOpened);
  out.add(Exit('Sans « $what » : aucune alerte critique', crit == 0, '$crit ouverture(s) critique(s)'));
  return out;
}

List<Exit> exitCriteria(List<RunStats> base, List<RunStats> withNets, List<ShockStats> shocks, Options o) {
  final out = <Exit>[];
  if (base.isNotEmpty) {
    final crit = base.fold(0, (a, r) => a + r.criticalOpened);
    out.add(Exit('Aucune alerte critique (sans filets)', crit == 0, '$crit ouverture(s) critique(s)'));
    final u = base.where((r) => r.unempMean > 0.10).map((r) => 'g${r.seed} ${pc(r.unempMean)}');
    out.add(Exit('Chômage moyen ≤ 10 %', u.isEmpty, u.isEmpty ? 'toutes les graines' : u.join(', ')));
    final hh = base.where((r) => r.hungerMean >= 0.02 || r.homelessMean >= 0.02).map((r) => 'g${r.seed}');
    out.add(Exit('Faim et sans-abri < 2 %', hh.isEmpty, hh.isEmpty ? 'toutes les graines' : hh.join(', ')));
    final g = base.where((r) => r.giniMean < 0.2 || r.giniMean > 0.45).map((r) => 'g${r.seed} ${dec(r.giniMean)}');
    out.add(Exit('Gini 0,2–0,45', g.isEmpty, g.isEmpty ? 'toutes les graines' : g.join(', ')));
    final inf = base.where((r) => r.inflMean.abs() >= 0.005).map((r) => 'g${r.seed} ${pc(r.inflMean, 3)}/j');
    out.add(Exit('Inflation moyenne < ±0,5 %/j', inf.isEmpty, inf.isEmpty ? 'toutes les graines' : inf.join(', ')));
    final inv = base.fold(0.0, (a, r) => math.max(a, r.invMax));
    out.add(Exit('Invariant comptable à 1e-8 près', inv <= 1e-8, 'écart max ${inv.toStringAsExponential(2)} \$'));
    final crashed = base.where((r) => r.crash != null).map((r) => 'g${r.seed}');
    if (crashed.isNotEmpty) out.add(Exit('Aucune exception', false, crashed.join(', ')));
  }
  if (withNets.isNotEmpty) {
    final bad = <String>[];
    for (final k in Safeguards.keys) {
      final rate = withNets.fold(0.0, (a, r) => a + r.netRate(k)) / withNets.length;
      if (rate >= 1) bad.add('${Safeguards.labels[k]} ${dec(rate)}/50 j');
    }
    out.add(Exit('Filets : < 1 déclenchement / 50 j en régime', bad.isEmpty, bad.isEmpty ? 'tous les filets' : bad.join(', ')));
  }
  for (final nets in [false, true]) {
    final list = shocks.where((s) => s.nets == nets).toList();
    if (list.isEmpty) continue;
    final fail = list.where((s) => s.recoverAbs == null || s.recoverAbs! > 200).toList();
    final so = fail.where((s) => s.collapsedBefore).length;
    out.add(Exit('Chaque choc revient à l’équilibre en < 200 j (${nets ? 'avec' : 'sans'} filets)', fail.isEmpty,
        fail.isEmpty
            ? 'tous'
            : '${fail.length}/${list.length} échecs${so > 0 ? ' (dont $so sur économie déjà effondrée)' : ''}'));
  }
  return out;
}

String report(Options o, List<RunStats> base, List<RunStats> withNets, List<RunStats> sauf, List<ShockStats> shocks,
    Map<String, dynamic>? prev, Map<String, dynamic> summary) {
  final b = StringBuffer();
  final off = Modules.keys.where((k) => !o.modules.get(k)).toList();
  b.writeln('# Protocole de stabilité ÉcoNodes');
  b.writeln();
  b.writeln('- Date : ${DateTime.now().toIso8601String().substring(0, 16).replaceAll('T', ' ')}');
  b.writeln('- Graines : ${o.seeds.join(', ')} · ${o.days} jours · régime mesuré après le jour ${o.warmup}');
  b.writeln('- Modules coupés : ${off.isEmpty ? 'aucun' : off.map((k) => Modules.labels[k]).join(', ')}');
  if (o.params.isNotEmpty) {
    b.writeln('- Paramètres changés : ${o.params.entries.map((e) => '${e.key} = ${e.value}').join(', ')}');
  }
  b.writeln();

  void indicators(List<RunStats> rs) {
    b.writeln(row(['Graine', 'Chômage moy.', 'Chômage max', 'Faim moy.', 'Faim max', 'Sans-abri moy.', 'Sans-abri max',
      'Gini moy.', 'Gini fin', 'Inflation moy./j', '|Infl.| max/j', '|Infl. 100 j| max', 'Alertes (crit.)', 'Écart compta max']));
    b.writeln(sep(14));
    for (final r in rs) {
      b.writeln(row([
        r.crash == null ? r.seed : '${r.seed} ⚠',
        pc(r.unempMean), pc(r.unempMax), pc(r.hungerMean), pc(r.hungerMax), pc(r.homelessMean), pc(r.homelessMax),
        dec(r.giniMean), dec(r.giniEnd), pc(r.inflMean, 3), pc(r.inflMaxAbs), pc(r.infl100MaxAbs),
        '${r.alertsTotal} (${r.criticalOpened})', r.invMax.toStringAsExponential(1),
      ]));
    }
    for (final r in rs.where((r) => r.crash != null)) {
      b.writeln();
      b.writeln('⚠ Graine ${r.seed} interrompue : ${r.crash}');
    }
    b.writeln();
  }

  if (base.isNotEmpty) {
    b.writeln('## 1. Sans filets');
    b.writeln();
    indicators(base);
    b.writeln('Santé moyenne de la population : ${base.map((r) => 'g${r.seed} ${dec(r.healthMean)}').join(', ')}.');
    b.writeln();
    b.writeln('### Alertes ouvertes, par type (ouvertures · jours-alerte)');
    b.writeln();
    final types = alertLabels.keys.where((t) => base.any((r) => (r.alertsOpened[t] ?? 0) > 0)).toList();
    if (types.isEmpty) {
      b.writeln('Aucune alerte.');
    } else {
      b.writeln(row(['Type', 'Gravité', for (final r in base) 'g${r.seed}']));
      b.writeln(sep(2 + base.length));
      for (final t in types) {
        b.writeln(row([
          alertLabels[t], criticalAlerts.contains(t) ? 'critique' : 'attention',
          for (final r in base) (r.alertsOpened[t] ?? 0) == 0 ? '·' : '${r.alertsOpened[t]} · ${r.alertDays[t] ?? 0} j',
        ]));
      }
    }
    b.writeln();
    b.writeln('### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)');
    b.writeln();
    b.writeln(row(['Graine', 'Primaire', 'Secondaire', 'Tertiaire', 'Entreprises sans employé', 'Dette finale', 'Prêté', 'Radié']));
    b.writeln(sep(8));
    for (final r in base) {
      b.writeln(row([r.seed, pc(r.sectorShare[0]), pc(r.sectorShare[1]), pc(r.sectorShare[2]), r.firmsWithoutStaff,
        fmtMoney0(r.debtEnd), fmtMoney0(r.lent), fmtMoney0(r.writtenOff)]));
    }
    b.writeln();
  }

  void netsTable(List<RunStats> rs, Set<String> cut) {
    b.writeln('### Déclenchements par filet (total · régime par 50 jours · cause principale)');
    b.writeln();
    b.writeln(row(['Filet', for (final r in rs) 'g${r.seed}', 'Moyenne / 50 j', 'Cause principale']));
    b.writeln(sep(3 + rs.length));
    for (final k in Safeguards.keys) {
      if (cut.contains(k)) {
        b.writeln(row([Safeguards.labels[k], for (final _ in rs) '—', 'coupé', '—']));
        continue;
      }
      final rate = rs.fold(0.0, (a, r) => a + r.netRate(k)) / rs.length;
      final causes = <String, int>{};
      for (final r in rs) {
        for (final e in (r.netsCauses[k] ?? const <String, int>{}).entries) {
          causes[e.key] = (causes[e.key] ?? 0) + e.value;
        }
      }
      final all = causes.values.fold(0, (a, b) => a + b);
      final sortedCauses = causes.entries.toList()..sort((a, c) => c.value.compareTo(a.value));
      final top = sortedCauses.isEmpty
          ? '—'
          : sortedCauses.take(2).map((e) => '${e.key} (${(100 * e.value / all).round()} %)').join(' ; ');
      b.writeln(row([
        Safeguards.labels[k],
        for (final r in rs) '${r.netsTotal[k] ?? 0} · ${dec(r.netRate(k))}',
        '${dec(rate)} ${rate >= 1 ? '❌' : '✅'}', top,
      ]));
    }
    b.writeln();
    final types = <String, int>{};
    for (final r in rs) {
      for (final e in r.bailoutByType.entries) {
        types[e.key] = (types[e.key] ?? 0) + e.value;
      }
    }
    if (types.isNotEmpty) {
      final l = types.entries.toList()..sort((a, c) => c.value.compareTo(a.value));
      b.writeln('Renflouements en régime, par type d’entreprise (toutes graines) : '
          '${l.take(8).map((e) => '${templates[e.key]?.label ?? e.key} ${e.value}').join(', ')}.');
      b.writeln();
    }
    b.writeln('Santé moyenne de la population : ${rs.map((r) => 'g${r.seed} ${dec(r.healthMean)}').join(', ')}.');
    b.writeln();
  }

  if (withNets.isNotEmpty) {
    b.writeln('## 2. Avec filets');
    b.writeln();
    indicators(withNets);
    netsTable(withNets, const {});
  }

  if (sauf.isNotEmpty) {
    b.writeln('## 2 bis. Avec filets, sauf : ${o.sauf.map((k) => Safeguards.labels[k]).join(', ')}');
    b.writeln();
    indicators(sauf);
    netsTable(sauf, o.sauf);
  }

  if (shocks.isNotEmpty) {
    b.writeln('## 3. Chocs standard (choc au jour ${o.shockDay}, observé ${o.shockHorizon} jours)');
    b.writeln();
    b.writeln('Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, '
        'inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ '
        '(au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.');
    b.writeln();
    b.writeln('« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.');
    b.writeln();
    for (final nets in [false, true]) {
      final list = shocks.where((s) => s.nets == nets).toList();
      if (list.isEmpty) continue;
      b.writeln('### ${nets ? 'Avec filets' : 'Sans filets'}');
      b.writeln();
      b.writeln(row(['Choc', 'Graine', 'Équilibre avant ?', 'Pic chômage', 'Pic faim', 'Pic sans-abri',
        'Retour équilibre (j)', 'Retour niveau d’avant (j)', 'Alertes déclenchées']));
      b.writeln(sep(9));
      for (final s in list) {
        final al = s.alerts.entries.map((e) => '${alertLabels[e.key]} ×${e.value}').join(', ');
        final so = s.collapsedBefore;
        b.writeln(row([
          '${shockLabels[s.kind]}${s.detail.isEmpty ? '' : ' (${s.detail})'}', s.seed,
          so ? 'non (effondrée)' : (s.preInBand ? 'oui' : 'non'),
          pc(s.peakUnemp), pc(s.peakHunger), pc(s.peakHomeless),
          so
              ? 's. o.'
              : (s.recoverAbs == null
                  ? 'non (> ${o.shockHorizon - 30})'
                  : '${s.recoverAbs}${s.recoverAbs! > 200 ? ' ❌' : ''}'),
          so ? 's. o.' : (s.recoverRel == null ? 'non' : '${s.recoverRel}'),
          s.crash != null ? '⚠ ${s.crash}' : (al.isEmpty ? '—' : al),
        ]));
      }
      b.writeln();
    }
  }

  b.writeln('## Critères de sortie');
  b.writeln();
  b.writeln(row(['Critère', 'Résultat', 'Détail']));
  b.writeln(sep(3));
  for (final e in exitCriteria(base, withNets, shocks, o)) {
    b.writeln(row([e.label, ok(e.pass), e.detail]));
  }
  b.writeln();
  final sc = saufCriteria(sauf, o);
  if (sc.isNotEmpty) {
    b.writeln('### Critère de l’institution (étape 2 bis)');
    b.writeln();
    b.writeln(row(['Critère', 'Résultat', 'Détail']));
    b.writeln(sep(3));
    for (final e in sc) {
      b.writeln(row([e.label, ok(e.pass), e.detail]));
    }
    b.writeln();
  }

  if (prev != null) {
    b.writeln('## Avant / après');
    b.writeln();
    b.writeln(row(['Indicateur (moyenne des graines)', 'Avant', 'Après']));
    b.writeln(sep(3));
    final a = (prev['aggregate'] as Map).cast<String, dynamic>();
    final n = (summary['aggregate'] as Map).cast<String, dynamic>();
    for (final k in n.keys) {
      if (!a.containsKey(k)) continue;
      b.writeln(row([_aggLabels[k] ?? k, _fmtAgg(k, a[k]), _fmtAgg(k, n[k])]));
    }
    b.writeln();
  }
  return b.toString();
}

const Map<String, String> _aggLabels = {
  'unempMean': 'Chômage moyen',
  'hungerMean': 'Faim moyenne',
  'homelessMean': 'Sans-abri moyen',
  'giniMean': 'Gini moyen',
  'inflMean': 'Inflation moyenne / jour',
  'criticalOpened': 'Alertes critiques (total)',
  'alertsTotal': 'Alertes (total)',
  'invMax': 'Écart comptable max (\$)',
  'net_famine': 'Anti-famine / 50 j',
  'net_bailout': 'Renflouements / 50 j',
  'net_shelter': 'Plancher de logement / 50 j',
  'net_drift': 'Plafond de dérive / 50 j',
  'net_credit': 'Anti-crédit-fou / 50 j',
  'shocksRecovered': 'Chocs revenus à l’équilibre en < 200 j (sans filets)',
  'shocksRecoveredNets': 'Chocs revenus à l’équilibre en < 200 j (avec filets)',
  'sauf_unempMean': 'Filets sauf --sauf : chômage moyen',
  'sauf_hungerMean': 'Filets sauf --sauf : faim moyenne',
  'sauf_homelessMean': 'Filets sauf --sauf : sans-abri moyen',
  'sauf_giniMean': 'Filets sauf --sauf : Gini moyen',
  'sauf_criticalOpened': 'Filets sauf --sauf : alertes critiques',
  'sauf_net_famine': 'Filets sauf --sauf : anti-famine / 50 j',
  'sauf_net_bailout': 'Filets sauf --sauf : renflouements / 50 j',
  'sauf_net_shelter': 'Filets sauf --sauf : plancher de logement / 50 j',
  'sauf_net_drift': 'Filets sauf --sauf : plafond de dérive / 50 j',
  'sauf_net_credit': 'Filets sauf --sauf : anti-crédit-fou / 50 j',
  'withNets_unempMean': 'Avec filets : chômage moyen',
  'withNets_hungerMean': 'Avec filets : faim moyenne',
  'withNets_homelessMean': 'Avec filets : sans-abri moyen',
  'withNets_giniMean': 'Avec filets : Gini moyen',
  'healthMean': 'Santé moyenne (sans filets)',
  'withNets_healthMean': 'Avec filets : santé moyenne',
  'sauf_healthMean': 'Filets sauf --sauf : santé moyenne',
  'waitMean': 'Hôpital public : attente moyenne (j, sans filets)',
  'net_bailout_hopital': 'Renflouements de l’hôpital / 50 j',
  'sauf_net_bailout_hopital': 'Filets sauf --sauf : renflouements de l’hôpital / 50 j',
};

String _fmtAgg(String k, dynamic v) {
  if (v == null) return '—';
  final d = (v as num).toDouble();
  switch (k) {
    case 'unempMean':
    case 'hungerMean':
    case 'homelessMean':
    case 'sauf_unempMean':
    case 'sauf_hungerMean':
    case 'sauf_homelessMean':
    case 'withNets_unempMean':
    case 'withNets_hungerMean':
    case 'withNets_homelessMean':
      return pc(d);
    case 'inflMean':
      return pc(d, 3);
    case 'invMax':
      return d.toStringAsExponential(1);
    case 'criticalOpened':
    case 'sauf_criticalOpened':
    case 'alertsTotal':
    case 'shocksRecovered':
    case 'shocksRecoveredNets':
      return d.round().toString();
    default:
      return dec(d);
  }
}

Map<String, dynamic> buildSummary(
    Options o, List<RunStats> base, List<RunStats> withNets, List<RunStats> sauf, List<ShockStats> shocks) {
  double mean(List<RunStats> rs, double Function(RunStats) f) =>
      rs.isEmpty ? double.nan : rs.fold(0.0, (a, r) => a + f(r)) / rs.length;
  final agg = <String, dynamic>{};
  if (base.isNotEmpty) {
    agg['unempMean'] = mean(base, (r) => r.unempMean);
    agg['hungerMean'] = mean(base, (r) => r.hungerMean);
    agg['homelessMean'] = mean(base, (r) => r.homelessMean);
    agg['giniMean'] = mean(base, (r) => r.giniMean);
    agg['inflMean'] = mean(base, (r) => r.inflMean);
    agg['healthMean'] = mean(base, (r) => r.healthMean);
    agg['waitMean'] = mean(base, (r) => r.waitMean);
    agg['criticalOpened'] = base.fold(0, (a, r) => a + r.criticalOpened);
    agg['alertsTotal'] = base.fold(0, (a, r) => a + r.alertsTotal);
    agg['invMax'] = base.fold(0.0, (a, r) => math.max(a, r.invMax));
  }
  if (withNets.isNotEmpty) {
    for (final k in Safeguards.keys) {
      agg['net_$k'] = mean(withNets, (r) => r.netRate(k));
    }
    agg['withNets_unempMean'] = mean(withNets, (r) => r.unempMean);
    agg['withNets_hungerMean'] = mean(withNets, (r) => r.hungerMean);
    agg['withNets_homelessMean'] = mean(withNets, (r) => r.homelessMean);
    agg['withNets_giniMean'] = mean(withNets, (r) => r.giniMean);
    agg['withNets_healthMean'] = mean(withNets, (r) => r.healthMean);
    agg['net_bailout_hopital'] = mean(withNets, (r) => r.bailoutRate('hopital'));
  }
  if (sauf.isNotEmpty) {
    agg['sauf_unempMean'] = mean(sauf, (r) => r.unempMean);
    agg['sauf_hungerMean'] = mean(sauf, (r) => r.hungerMean);
    agg['sauf_homelessMean'] = mean(sauf, (r) => r.homelessMean);
    agg['sauf_giniMean'] = mean(sauf, (r) => r.giniMean);
    agg['sauf_criticalOpened'] = sauf.fold(0, (a, r) => a + r.criticalOpened);
    agg['sauf_healthMean'] = mean(sauf, (r) => r.healthMean);
    if (!o.sauf.contains('bailout')) agg['sauf_net_bailout_hopital'] = mean(sauf, (r) => r.bailoutRate('hopital'));
    for (final k in Safeguards.keys.where((k) => !o.sauf.contains(k))) {
      agg['sauf_net_$k'] = mean(sauf, (r) => r.netRate(k));
    }
  }
  if (shocks.isNotEmpty) {
    agg['shocksRecovered'] = shocks.where((s) => !s.nets && s.recoverAbs != null && s.recoverAbs! <= 200).length;
    agg['shocksRecoveredNets'] = shocks.where((s) => s.nets && s.recoverAbs != null && s.recoverAbs! <= 200).length;
  }
  return {
    'date': DateTime.now().toIso8601String(),
    'seeds': o.seeds,
    'days': o.days,
    'modulesOff': Modules.keys.where((k) => !o.modules.get(k)).toList(),
    'sauf': o.sauf.toList(),
    'aggregate': agg,
    'base': [for (final r in base) r.toJson()],
    'nets': [for (final r in withNets) r.toJson()],
    'saufRuns': [for (final r in sauf) r.toJson()],
    'shocks': [for (final s in shocks) s.toJson()],
  };
}

// ------------------------------------------------------------------ point d'entrée

void main(List<String> args) {
  final o = Options(args);
  final sw = Stopwatch()..start();
  void progress(String m) => stderr.writeln('[${(sw.elapsedMilliseconds / 1000).toStringAsFixed(0).padLeft(4)} s] $m');

  final base = <RunStats>[];
  final withNets = <RunStats>[];
  final sauf = <RunStats>[];
  final shocks = <ShockStats>[];
  if (o.phases.contains('base')) {
    for (final seed in o.seeds) {
      progress('sans filets, graine $seed');
      base.add(runBase(seed, o, false));
    }
  }
  if (o.phases.contains('nets')) {
    for (final seed in o.seeds) {
      progress('avec filets, graine $seed');
      withNets.add(runBase(seed, o, true));
    }
  }
  if (o.sauf.isNotEmpty) {
    for (final seed in o.seeds) {
      progress('avec filets sauf ${o.sauf.join(', ')}, graine $seed');
      sauf.add(runBase(seed, o, true, except: o.sauf));
    }
  }
  if (o.phases.contains('chocs')) {
    for (final nets in [false, true]) {
      if (!o.shockNets.contains(nets ? 'on' : 'off')) continue;
      for (final kind in shockLabels.keys) {
        for (final seed in o.shockSeeds) {
          progress('choc $kind, graine $seed, ${nets ? 'avec' : 'sans'} filets');
          shocks.add(runShock(kind, seed, o, nets));
        }
      }
    }
  }
  final summary = buildSummary(o, base, withNets, sauf, shocks);
  Map<String, dynamic>? prev;
  if (o.compare != null) prev = (jsonDecode(File(o.compare!).readAsStringSync()) as Map).cast<String, dynamic>();
  final md = report(o, base, withNets, sauf, shocks, prev, summary);
  if (o.out != null) {
    File(o.out!).parent.createSync(recursive: true);
    File(o.out!).writeAsStringSync(md);
    progress('rapport écrit : ${o.out}');
  } else {
    stdout.write(md);
  }
  if (o.save != null) {
    File(o.save!).parent.createSync(recursive: true);
    File(o.save!).writeAsStringSync(const JsonEncoder.withIndent('  ').convert(summary));
    progress('synthèse enregistrée : ${o.save}');
  }
  progress('terminé');
}
