// Coût d'un achat de ménage selon le nombre de vendeurs du bien : recherche complète (k = 0) contre recherche limitée
// (k > 0). On ajoute m boulangeries bien approvisionnées à une petite partie, puis on chronomètre des achats d'une unité
// de pain par un même ménage (très riche : le budget ne limite pas). Ce n'est pas une partie : seul le coût de `buy` compte.
//
//   dart run tool/vendeurs_cout.dart [--achats 20000] [--k 0,3,5,8]
//
// Résultat attendu : le coût par achat croît avec m à k = 0 (toutes les offres sont construites) et reste plat à k > 0.

import 'dart:io';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

void main(List<String> args) {
  var purchases = 20000;
  var ks = [0, 3, 5, 8];
  for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--achats':
        purchases = int.parse(args[++i]);
      case '--k':
        ks = [for (final x in args[++i].split(',')) int.parse(x)];
    }
  }
  final sizes = [10, 50, 200, 1000, 5000];
  stdout.writeln('Coût par achat (µs), $purchases achats d’une unité de pain, médiane de 5 passages :');
  stdout.writeln('| Vendeurs de pain | ${ks.map((k) => 'k = $k').join(' | ')} |');
  stdout.writeln('|---|${ks.map((_) => '---').join('|')}|');
  for (final m in sizes) {
    final cells = <String>[];
    for (final k in ks) {
      final s = Sim(seed: 1, params: Params()..sellerSample = k);
      for (var i = 0; i < m; i++) {
        final f = s.addFirm('boulangerie', 'B$i', 1e6, null, 0, 0);
        s.godGoods(f.id, 'pain', 1e6);
      }
      final c = s.citizens.first;
      final runs = <double>[];
      for (var r = 0; r < 5; r++) {
        c.money = 1e12; // budget illimité : seule la recherche des offres est mesurée
        final sw = Stopwatch()..start();
        for (var i = 0; i < purchases; i++) {
          s.buy(c, 'M', 'pain', 1, 1e9, true);
        }
        runs.add(sw.elapsedMicroseconds / purchases);
      }
      runs.sort();
      cells.add(runs[2].toStringAsFixed(2));
    }
    stdout.writeln('| $m | ${cells.join(' | ')} |');
  }
}
