// Passage à l'échelle : ratios de l'économie au jour 1, pour plusieurs tailles de population.
//
//   dart run tool/echelle.dart [--tailles 240,1000,3000,13240] [--graine 1]
//
// Si l'initialisation suit la population, chaque ratio est le même à toutes les tailles.

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

String f2(double v) => v.toStringAsFixed(v.abs() >= 100 ? 0 : (v.abs() >= 1 ? 2 : 4)).replaceAll('.', ',');

void main(List<String> args) {
  var sizes = [240, 1000, 3000, 13240];
  var seed = 1;
  for (var i = 0; i < args.length; i++) {
    if (args[i] == '--tailles') sizes = args[++i].split(',').map(int.parse).toList();
    if (args[i] == '--graine') seed = int.parse(args[++i]);
  }
  final rows = <String, List<String>>{};
  void put(String k, String v) => (rows[k] ??= []).add(v);
  for (final n in sizes) {
    final s = Sim(seed: seed, params: Params()..population = n);
    s.step(); // jour 1
    final pop = s.citizens.length;
    final posts = s.firms.fold(0, (a, f) => a + f.workers.length + f.vacancies);
    var housing = 0.0;
    for (final f in s.sellersOf('logement')) {
      housing += f.capacity ?? double.infinity;
    }
    var envelopes = 0.0;
    for (final st in s.services.values) {
      envelopes += st.envelopeToday;
    }
    final bySector = {for (final sec in sectors) sec: s.firms.where((f) => f.template.sector == sec).length};
    final sizesOf = [for (final f in s.firms) f.workers.length]..sort();
    put('Population', '$pop');
    put('Postes offerts (pourvus + vacants) ÷ population active', f2(posts / pop));
    put('Logements (nuitées par jour) ÷ ménages', f2(housing / pop));
    put('Argent par habitant (\$)', f2(s.totalMoney() / pop));
    put('… dont ménages (\$)', f2(s.citizens.fold(0.0, (a, c) => a + c.money) / pop));
    put('Fonds propres de la Caisse par habitant (\$)', f2(s.bank.equity / pop));
    put('Enveloppes publiques du jour par habitant (\$)', f2(envelopes / pop));
    put('Trésor de l’État par habitant (\$)', f2(s.state.money / pop));
    for (final sec in sectors) {
      put('Entreprises, secteur $sec', '${bySector[sec]}');
      put('… $sec pour 1 000 habitants', f2(bySector[sec]! * 1000 / pop));
    }
    put('Taille médiane d’une équipe', '${sizesOf[sizesOf.length ~/ 2]}');
    put('Plus grande équipe', '${sizesOf.last}');
    // les établissements publics démarrent au-dessus de leur cible : l'enveloppe se mesure sur 30 jours
    var env30 = envelopes;
    for (var d = 2; d <= 30; d++) {
      s.step();
      for (final st in s.services.values) {
        env30 += st.envelopeToday;
      }
    }
    put('Enveloppes publiques par habitant et par jour, jours 1 à 30 (\$)', f2(env30 / 30 / pop));
  }
  print('| Jour 1, graine $seed | ${sizes.join(' | ')} |');
  print('|---|${[for (final _ in sizes) '---'].join('|')}|');
  for (final e in rows.entries) {
    print('| ${e.key} | ${e.value.join(' | ')} |');
  }
}
