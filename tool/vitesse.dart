// Vitesse du moteur selon les modules, lecture seule : réglages de l'interface, une population, des jours ; pour chaque
// configuration (modules de l'interface, puis Bâtiments, Banques, Rénovation ajoutés un à un), temps médian d'un jour
// après le jour 100, part de la consommation des ménages, nombre d'entreprises et de bâtiments.
//
//   dart run tool/vitesse.dart [population] [jours] [graine]
//
// À lancer seul sur la machine : d'autres parties en même temps faussent les durées.

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface;

void main(List<String> a) {
  final pop = a.isNotEmpty ? int.parse(a[0]) : 1000;
  final days = a.length > 1 ? int.parse(a[1]) : 400;
  final seed = a.length > 2 ? int.parse(a[2]) : 1;
  final configs = <String, Modules Function()>{
    'interface (rôles, entrepreneuriat, produits)': () => Modules()
      ..jobs = true
      ..entrepreneurship = true
      ..products = true,
    '+ bâtiments': () => Modules()
      ..jobs = true
      ..entrepreneurship = true
      ..products = true
      ..buildings = true,
    '+ bâtiments + banques': () => Modules()
      ..jobs = true
      ..entrepreneurship = true
      ..products = true
      ..buildings = true
      ..banking = true,
    '+ bâtiments + banques + rénovation': () => Modules()
      ..jobs = true
      ..entrepreneurship = true
      ..products = true
      ..buildings = true
      ..banking = true
      ..renovation = true,
    'aucun module de l’interface': () => Modules(),
  };
  for (final e in configs.entries) {
    final sw = Stopwatch()..start();
    final s = Sim(seed: seed, params: parametresInterface(pop), modules: e.value());
    final init = sw.elapsedMilliseconds;
    final times = <double>[];
    var consume = 0.0, total = 0.0;
    for (var d = 1; d <= days; d++) {
      final t0 = sw.elapsedMicroseconds, c0 = s.consumeClock.elapsedMicroseconds;
      s.step();
      final dt = (sw.elapsedMicroseconds - t0) / 1000;
      if (d > 100) {
        times.add(dt);
        total += dt;
        consume += (s.consumeClock.elapsedMicroseconds - c0) / 1000;
      }
    }
    times.sort();
    print('${e.key.padRight(44)} départ ${init.toString().padLeft(6)} ms ; jour : médiane '
        '${times[times.length ~/ 2].toStringAsFixed(1)} ms, moyenne ${(total / times.length).toStringAsFixed(1)} ms '
        '(consommation ${(consume / total * 100).toStringAsFixed(0)} %) ; entreprises ${s.firms.length}, '
        'bâtiments ${s.buildings.length}');
  }
}
