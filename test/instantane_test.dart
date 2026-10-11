// Instantanés et journaux complets : reprendre une partie depuis un instantané donne exactement la même suite qu'une
// partie jouée d'une traite ; le traceur ne change rien à la partie.

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:econodes/engine/trace.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tool/partie.dart' show treeDiff;

String snap(Sim s) => jsonEncode(s.toSnapshot());

Sim reload(Sim s) => simFromSnapshot((jsonDecode(snap(s)) as Map).cast<String, dynamic>());

/// Joue [days] jours d'une traite, puis la même partie coupée en deux au jour [cut] par un instantané écrit et relu.
void sameContinuation(Sim Function() make, int cut, int days, {void Function(Sim)? before}) {
  final full = make();
  final half = make();
  for (var d = 1; d <= cut; d++) {
    full.step();
    half.step();
  }
  before?.call(full);
  before?.call(half);
  final resumed = reload(half);
  expect(snap(resumed), snap(half), reason: 'relecture immédiate');
  for (var d = cut + 1; d <= days; d++) {
    full.step();
    resumed.step();
  }
  final a = snap(full), b = snap(resumed);
  if (a != b) {
    final diffs = <String>[];
    treeDiff(jsonDecode(a), jsonDecode(b), '', diffs, max: 10);
    fail('l’état diverge au jour $days :\n${diffs.join('\n')}');
  }
  expect(resumed.day, days);
}

void main() {
  test('reprise depuis un instantané : même suite, au bit près (modèle complet, filets actifs)', () {
    sameContinuation(() => Sim(seed: 11), 160, 320);
  });

  test('reprise : sans filets, frontières ouvertes, après une épidémie et des immigrants', () {
    sameContinuation(() => Sim(seed: 5, params: Params()..trade = true, safeguards: Safeguards.none()), 140, 300,
        before: (s) {
      s.godEpidemic(0.3);
      s.godAddCitizens(5, 2000);
    });
  });

  test('reprise : noyau (modules économiques coupés), en pleine période d’alertes', () {
    sameContinuation(() => Sim(seed: 3, modules: Modules.noyau(), safeguards: Safeguards.none()), 400, 520,
        before: (s) => expect(s.monitor.active, isNotEmpty));
  });

  test('le traceur ne change rien à la partie ; chaque filet déclenché est journalisé avec son montant', () {
    final plain = Sim(seed: 8);
    final traced = Sim(seed: 8);
    final events = StringBuffer(), series = StringBuffer();
    final tr = Tracer(traced, events: events, series: series);
    for (var d = 1; d <= 250; d++) {
      plain.step();
      traced.step();
      tr.afterStep();
    }
    tr.detach();
    expect(snap(traced), snap(plain));
    final lines = [for (final l in events.toString().split('\n')) if (l.isNotEmpty) jsonDecode(l) as Map];
    expect(lines.length, tr.eventsWritten);
    final nets = lines.where((e) => e['categorie'] == 'filets').toList();
    expect(nets.length, traced.nets.total());
    for (final e in nets) {
      expect(e['montant'], isA<num>());
      expect((e['cause'] as String).isNotEmpty, isTrue);
    }
    expect(lines.map((e) => e['categorie']).toSet().difference(traceCategories.toSet()), isEmpty);
    expect(series.toString().split('\n').where((l) => l.isNotEmpty).length, 251); // en-tête + 250 jours
    final header = series.toString().split('\n').first.split(',');
    expect(header.length, Tracer.seriesColumns.length);
    expect(tr.agentsCsv().split('\n').where((l) => l.isNotEmpty).length, traced.citizens.length + 1);
  });

  test('empreintes : identiques pour la même partie, différentes dès qu’un paramètre change', () {
    final a = Sim(seed: 2), b = Sim(seed: 2), c = Sim(seed: 2, params: Params()..taxRate = 0.13);
    int? first;
    for (var d = 1; d <= 30; d++) {
      a.step();
      b.step();
      c.step();
      expect(b.digest(), a.digest());
      if (first == null && jsonEncode(c.digest()) != jsonEncode(a.digest())) first = d;
    }
    expect(first, 1); // les impôts du premier jour diffèrent déjà
  });

  test('une alerte par entreprise désigne l’entreprise concernée', () {
    final s = Sim(seed: 4, safeguards: Safeguards.none());
    for (var d = 1; d <= 200; d++) {
      s.step();
    }
    final firmAlerts = [for (final a in s.monitor.active.values) if (a.subject != null) a];
    expect(firmAlerts, isNotEmpty);
    for (final a in firmAlerts) {
      expect(a.subject!.kind, 'firm');
      expect(a.key, endsWith(':${a.subject!.id}'));
    }
    for (final a in s.monitor.active.values) {
      expect(a.refs.length, a.agents.length);
    }
  });
}
