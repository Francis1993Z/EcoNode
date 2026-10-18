// Mesure de performance d'une partie : temps par jour (médiane et moyenne des jours depuis --depuis, 100 par défaut) et
// mémoire maximale du processus.
//
//   dart run tool/perf.dart --population 3000 [--graine 1] [--jours 300] [--filets 1] [--echantillon k] [--depuis 100]
//
// Une taille par processus : la mémoire maximale (ProcessInfo.maxRss) est celle de toute la vie du processus.

import 'dart:io';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

void main(List<String> args) {
  var pop = 240, seed = 1, days = 300, from = 100, sample = Params().sellerSample;
  var nets = true;
  for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--population':
        pop = int.parse(args[++i]);
      case '--graine':
        seed = int.parse(args[++i]);
      case '--jours':
        days = int.parse(args[++i]);
      case '--depuis':
        from = int.parse(args[++i]);
      case '--echantillon':
        sample = int.parse(args[++i]);
      case '--filets':
        nets = args[++i] != '0';
    }
  }
  final sw = Stopwatch()..start();
  final s = Sim(seed: seed, params: Params()
        ..population = pop
        ..sellerSample = sample, safeguards: nets ? Safeguards() : Safeguards.none());
  final init = sw.elapsedMicroseconds / 1000;
  final times = <double>[], consume = <double>[], buys = <int>[];
  var h = 0;
  for (var d = 1; d <= days; d++) {
    final t0 = sw.elapsedMicroseconds, c0 = s.consumeClock.elapsedMicroseconds, b0 = s.consumeBuys;
    s.step();
    if (d >= from) {
      times.add((sw.elapsedMicroseconds - t0) / 1000);
      consume.add((s.consumeClock.elapsedMicroseconds - c0) / 1000);
      buys.add(s.consumeBuys - b0);
    }
    final x = s.history.last;
    h = hash32(hash32(h, (x.total * 1024).round() & 0xFFFFFFFF), (x.unemp * 1e6).round());
  }
  final mean = times.isEmpty ? double.nan : times.fold(0.0, (a, b) => a + b) / times.length;
  times.sort();
  final med = times.isEmpty ? double.nan : times[times.length ~/ 2];
  consume.sort();
  buys.sort();
  final medC = consume.isEmpty ? double.nan : consume[consume.length ~/ 2];
  final medB = buys.isEmpty ? 0 : buys[buys.length ~/ 2];
  stdout.writeln('population $pop, échantillon $sample, graine $seed, filets ${nets ? 1 : 0} : init ${init.toStringAsFixed(0)} ms, '
      'médiane jours $from–$days ${med.toStringAsFixed(2)} ms/j, moyenne ${mean.toStringAsFixed(2)} ms/j, total ${(sw.elapsedMilliseconds / 1000).toStringAsFixed(1)} s, '
      'mémoire max ${(ProcessInfo.maxRss / 1048576).toStringAsFixed(0)} Mo, entreprises ${s.firms.length}, empreinte $h');
  // coût par achat : phase de consommation / achats des ménages du jour (médianes des jours $from à $days)
  stdout.writeln('  consommation ${medC.toStringAsFixed(2)} ms/j, achats des ménages $medB /j, '
      '${medB > 0 ? (medC * 1000 / medB).toStringAsFixed(2) : '-'} µs par achat');
}
