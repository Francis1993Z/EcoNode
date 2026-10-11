// Parité VM / web : une même graine doit donner la même partie sur la VM (Android, ordinateur) et en JavaScript
// (version web, compilée par dart2js), où les entiers sont des nombres JavaScript.
//
//   dart run tool/parite.dart > vm.txt
//   dart compile js -o parite.js tool/parite.dart
//   node -e "globalThis.self = globalThis; require('./parite.js')" > web.txt
//
// Les deux sorties doivent être identiques. Les nombres sont écrits bit à bit (IEEE 754), car le web n'écrit pas les
// décimaux comme la VM (1.0 s'y écrit 1).

import 'dart:typed_data';

import 'package:econodes/engine/sim.dart';

String bits(double v) {
  final b = ByteData(8)..setFloat64(0, v);
  return '${b.getUint32(0).toRadixString(16).padLeft(8, '0')}${b.getUint32(4).toRadixString(16).padLeft(8, '0')}';
}

int fold(int h, double v) {
  final b = ByteData(8)..setFloat64(0, v);
  return hash32(hash32(h, b.getUint32(0)), b.getUint32(4));
}

void main() {
  print('hash32 ${[hash32(0, 0), hash32(42, 1), hash32(0xFFFFFFFF, 0x7FFFFFFF), hash32(123456789, 987654321)]}');
  final s0 = Sim(seed: 42);
  print('tirages ${[for (final f in Flux.values) bits(s0.draw(f, 17))].join(' ')}');
  for (final seed in [1, 42]) {
    final s = Sim(seed: seed);
    var h = 0;
    for (var d = 1; d <= 400; d++) {
      s.step();
      final x = s.history.last;
      for (final v in [x.total, x.mH, x.mF, x.mE, x.mB, x.unemp, x.cpi, x.gini, x.wage, x.gdp, x.happiness, x.debt,
        x.machines]) {
        h = fold(h, v);
      }
      h = hash32(hash32(h, x.hungry), x.homeless);
      if (d % 100 == 0) print('graine $seed, jour $d : empreinte $h, total ${bits(x.total)}, indice ${bits(x.cpi)}');
    }
  }
}
