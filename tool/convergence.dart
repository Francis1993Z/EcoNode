// Test de convergence entre deux tailles de population : les indicateurs d'un protocole à 2 500 citoyens (niveau
// d'exploration) disent-ils la même chose que le même protocole à 10 000 (niveau de validation) ?
//
//   dart run tool/convergence.dart petit.json grand.json [--out rapport.md]
//
// Les deux fichiers sont des synthèses enregistrées par `stabilite --save` (mêmes durées, même chauffe, mêmes étapes).
// Les graines jouent des hasards différents d'une taille à l'autre : la comparaison n'est donc PAS appariée. Pour chaque
// indicateur et chaque étape (sans filets, avec filets), le rapport donne la médiane de chaque taille avec son intervalle
// (bootstrap percentile de la médiane, 95 %), l'écart interquartile entre graines, la différence des médianes (grand −
// petit) avec son intervalle (bootstrap indépendant des deux échantillons), et le verdict :
//   différent          l'intervalle de la différence exclut 0 ;
//   non distinguable   il contient 0. Ce n'est PAS une preuve d'équivalence : la colonne « demi-largeur / EIQ » dit quel
//                      écart l'échantillon aurait pu voir (au-dessus de 1, un écart de l'ordre de la dispersion entre
//                      graines passerait inaperçu).
// Le parc d'entreprises est ramené à 1 000 habitants.

import 'dart:convert';
import 'dart:io';

import 'package:econodes/engine/sim.dart' show Mulberry32;

import 'stabilite.dart' show Json;

class Ind {
  final String cle, label;
  final bool parMille; // ramené à 1 000 habitants
  final bool pct;
  final int dec;
  const Ind(this.cle, this.label, {this.parMille = false, this.pct = true, this.dec = 1});
}

const inds = [
  Ind('unempMean', 'Chômage moyen'),
  Ind('hungerMean', 'Faim moyenne'),
  Ind('homelessMean', 'Sans-abri moyen'),
  Ind('unmetShare', 'Demande non servie'),
  Ind('giniMean', 'Gini moyen', pct: false, dec: 2),
  Ind('firmsMean', 'Parc moyen d’entreprises (pour 1 000 hab.)', parMille: true, pct: false, dec: 1),
  Ind('topShareMed', 'Part de la plus grande entreprise (médiane des biens)'),
  Ind('priceDispMed', 'Dispersion des prix entre vendeurs'),
];

double quantile(List<double> s, double q) {
  final pos = (s.length - 1) * q;
  final lo = pos.floor(), hi = pos.ceil();
  return s[lo] + (s[hi] - s[lo]) * (pos - lo);
}

double median(List<double> v) => quantile(List<double>.of(v)..sort(), 0.5);

final rng = Mulberry32(20261018);

List<double> bootMedians(List<double> d, int reps) {
  final out = List<double>.filled(reps, 0);
  final buf = List<double>.filled(d.length, 0);
  for (var r = 0; r < reps; r++) {
    for (var i = 0; i < d.length; i++) {
      buf[i] = d[(rng.next() * d.length).floor()];
    }
    buf.sort();
    out[r] = quantile(buf, 0.5);
  }
  return out;
}

String f(double v, Ind i) {
  final s = (i.pct ? v * 100 : v).toStringAsFixed(i.dec).replaceAll('.', ',');
  return i.pct ? '$s %' : s;
}

String fd(double v, Ind i) {
  final s = (i.pct ? v * 100 : v).toStringAsFixed(i.dec).replaceAll('.', ',');
  return i.pct ? '$s pt' : s;
}

Future<void> main(List<String> args) async {
  final files = <String>[];
  String? out;
  for (var i = 0; i < args.length; i++) {
    if (args[i] == '--out') {
      out = args[++i];
    } else {
      files.add(args[i]);
    }
  }
  if (files.length != 2) {
    stderr.writeln('Usage : dart run tool/convergence.dart petit.json grand.json [--out rapport.md]');
    exit(2);
  }
  final a = jsonDecode(File(files[0]).readAsStringSync()) as Json;
  final b = jsonDecode(File(files[1]).readAsStringSync()) as Json;
  const reps = 10000;
  final w = StringBuffer();
  final popA = (a['phases']['base'][0]['population'] as num).toInt();
  final popB = (b['phases']['base'][0]['population'] as num).toInt();
  w.writeln('# Convergence $popA contre $popB habitants\n');
  w.writeln('- Petit : `${files[0]}` ($popA habitants, ${(a['seeds'] as List).length} graines, ${a['days']} jours) ; grand : '
      '`${files[1]}` ($popB habitants, ${(b['seeds'] as List).length} graines, ${b['days']} jours).');
  w.writeln('- Hasards différents d\'une taille à l\'autre : comparaison non appariée. Intervalles à 95 % (bootstrap percentile, '
      '$reps tirages). Verdict : voir l\'en-tête de `tool/convergence.dart`.\n');
  final verdicts = <String, int>{'différent': 0, 'non distinguable': 0};
  for (final phase in ['base', 'nets']) {
    final ra = (a['phases'][phase] as List).cast<Json>(), rb = (b['phases'][phase] as List).cast<Json>();
    w.writeln('## ${phase == 'base' ? 'Sans filets' : 'Avec filets'}\n');
    w.writeln('| Indicateur | Médiane $popA [intervalle] | EIQ $popA | Médiane $popB [intervalle] | EIQ $popB | '
        'Différence des médianes [intervalle] | Demi-largeur / EIQ | Verdict |');
    w.writeln('|---|---|---|---|---|---|---|---|');
    for (final ind in inds) {
      List<double> vals(List<Json> r) => [
            for (final x in r)
              ((x[ind.cle] as num).toDouble()) * (ind.parMille ? 1000 / (x['population'] as num).toDouble() : 1)
          ];
      final va = vals(ra), vb = vals(rb);
      final ma = bootMedians(va, reps)..sort(), mb = bootMedians(vb, reps)..sort();
      final diff = List<double>.filled(reps, 0);
      final da = bootMedians(va, reps), db = bootMedians(vb, reps);
      for (var k = 0; k < reps; k++) {
        diff[k] = db[k] - da[k];
      }
      diff.sort();
      final lo = quantile(diff, 0.025), hi = quantile(diff, 0.975);
      final sa = List<double>.of(va)..sort(), sb = List<double>.of(vb)..sort();
      final eiqA = quantile(sa, 0.75) - quantile(sa, 0.25), eiqB = quantile(sb, 0.75) - quantile(sb, 0.25);
      final verdict = lo > 0 || hi < 0 ? 'différent' : 'non distinguable';
      final ratio = eiqB > 0 ? ((hi - lo) / 2 / eiqB).toStringAsFixed(1).replaceAll('.', ',') : '—';
      verdicts[verdict] = verdicts[verdict]! + 1;
      w.writeln('| ${ind.label} | ${f(median(va), ind)} [${f(quantile(ma, 0.025), ind)} ; ${f(quantile(ma, 0.975), ind)}] | '
          '${fd(eiqA, ind)} | ${f(median(vb), ind)} [${f(quantile(mb, 0.025), ind)} ; ${f(quantile(mb, 0.975), ind)}] | '
          '${fd(eiqB, ind)} | ${fd(median(vb) - median(va), ind)} [${fd(lo, ind)} ; ${fd(hi, ind)}] | $ratio | $verdict |');
    }
    w.writeln();
  }
  w.writeln('Bilan : ${verdicts['différent']} différences conclues, ${verdicts['non distinguable']} non distinguables '
      '(sur ${verdicts.values.fold(0, (x, y) => x + y)} comparaisons).');
  if (out != null) {
    File(out).parent.createSync(recursive: true);
    File(out).writeAsStringSync(w.toString());
  } else {
    stdout.write(w);
  }
}
