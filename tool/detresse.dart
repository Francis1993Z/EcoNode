// Débogage statistique : qu'est-ce qui distingue les citoyens qui finissent en détresse des autres ?
//
//   dart run tool/detresse.dart dossier/agents_fin.csv [--seuil 0.10]
//
// Lit agents_fin.csv (écrit par tool/partie.dart --trace). Un citoyen est « en détresse » si ses jours de faim ou sans
// logis dépassent cette part de ses jours observés (défaut : 10 %). Chaque variable est classée selon ce qu'elle
// distingue les deux groupes :
//   - variable numérique : aire sous la courbe ROC (probabilité qu'un citoyen en détresse ait une valeur plus haute
//     qu'un autre ; 0,5 = aucune différence), classée par |AUC − 0,5| ;
//   - variable qualitative : écart des proportions de chaque modalité entre les deux groupes.
//
// Le script ne déduit aucune cause : une variable peut distinguer les groupes parce qu'elle est une conséquence de la
// détresse (épargne, santé, bonheur) ou parce qu'elle suit une autre variable. Il sert à choisir où regarder ensuite.

import 'dart:io';
import 'dart:math' as math;

/// Variables exclues : identifiants, et celles qui définissent la détresse.
const Set<String> excluded = {
  'id', 'nom', 'employeur_id', 'employeur', 'jours_observes', 'jours_faim', 'jours_sans_logis',
  'cause_detresse_dominante', 'jours_cause_dominante',
};
const Set<String> categorical = {'classe', 'secteur_employeur'};

List<String> parseCsvLine(String line) {
  final out = <String>[];
  final b = StringBuffer();
  var quoted = false;
  for (var i = 0; i < line.length; i++) {
    final ch = line[i];
    if (quoted) {
      if (ch == '"' && i + 1 < line.length && line[i + 1] == '"') {
        b.write('"');
        i++;
      } else if (ch == '"') {
        quoted = false;
      } else {
        b.write(ch);
      }
    } else if (ch == '"') {
      quoted = true;
    } else if (ch == ',') {
      out.add(b.toString());
      b.clear();
    } else {
      b.write(ch);
    }
  }
  out.add(b.toString());
  return out;
}

/// Aire sous la courbe ROC par les rangs (statistique de Mann-Whitney), égalités comptées pour moitié.
double auc(List<double> pos, List<double> neg) {
  final all = [for (final x in pos) (x, 1), for (final x in neg) (x, 0)]..sort((a, b) => a.$1.compareTo(b.$1));
  var rankSum = 0.0;
  var i = 0;
  while (i < all.length) {
    var j = i;
    while (j + 1 < all.length && all[j + 1].$1 == all[i].$1) {
      j++;
    }
    final rank = (i + j) / 2 + 1; // rang moyen des ex aequo
    for (var k = i; k <= j; k++) {
      if (all[k].$2 == 1) rankSum += rank;
    }
    i = j + 1;
  }
  final n1 = pos.length, n0 = neg.length;
  return (rankSum - n1 * (n1 + 1) / 2) / (n1 * n0);
}

double median(List<double> x) {
  final s = [...x]..sort();
  if (s.isEmpty) return double.nan;
  final m = s.length ~/ 2;
  return s.length.isOdd ? s[m] : (s[m - 1] + s[m]) / 2;
}

String num(double v) {
  if (v.isNaN) return '—';
  final a = v.abs();
  final t = a >= 1000 ? v.toStringAsFixed(0) : (a >= 10 ? v.toStringAsFixed(1) : v.toStringAsFixed(3));
  return t.replaceAll('.', ',');
}

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('Usage : dart run tool/detresse.dart dossier/agents_fin.csv [--seuil 0.10]');
    exitCode = 64;
    return;
  }
  var threshold = 0.10;
  String? path;
  for (var i = 0; i < args.length; i++) {
    if (args[i] == '--seuil') {
      threshold = double.parse(args[++i]);
    } else {
      path = args[i];
    }
  }
  final lines = File(path!).readAsLinesSync().where((l) => l.isNotEmpty).toList();
  final head = parseCsvLine(lines.first);
  final rows = [for (final l in lines.skip(1)) parseCsvLine(l)];
  int col(String n) {
    final i = head.indexOf(n);
    if (i < 0) throw FormatException('Colonne absente de $path : $n');
    return i;
  }

  final cDays = col('jours_observes'), cHunger = col('jours_faim'), cHome = col('jours_sans_logis');
  final cCause = col('cause_detresse_dominante');
  bool distressed(List<String> r) {
    final d = double.parse(r[cDays]);
    return d > 0 && (double.parse(r[cHunger]) + double.parse(r[cHome])) / d >= threshold;
  }

  final pos = rows.where(distressed).toList();
  final neg = rows.where((r) => !distressed(r)).toList();
  stdout.writeln('# Détresse : ce qui distingue les citoyens en détresse des autres');
  stdout.writeln();
  stdout.writeln('- Fichier : $path');
  stdout.writeln('- En détresse : jours de faim + jours sans logis ≥ ${(threshold * 100).toStringAsFixed(0)} % des jours '
      'observés. ${pos.length} citoyen(s) en détresse, ${neg.length} autre(s).');
  stdout.writeln('- Classement par pouvoir discriminant. Ce ne sont pas des causes : une variable peut être une '
      'conséquence de la détresse (épargne, santé, bonheur) ou suivre une autre variable. À utiliser pour choisir '
      'les sondes.');
  stdout.writeln();
  if (pos.isEmpty || neg.isEmpty) {
    stdout.writeln('Un des deux groupes est vide : rien à comparer.');
    return;
  }

  final causes = <String, int>{};
  for (final r in pos) {
    final k = r[cCause].isEmpty ? '(aucune)' : r[cCause];
    causes[k] = (causes[k] ?? 0) + 1;
  }
  final cs = causes.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  stdout.writeln('Cause dominante de détresse (citoyens en détresse) : '
      '${cs.map((e) => '${e.key} ×${e.value}').join(', ')}.');
  stdout.writeln();

  final numeric = <(String, double, double, double)>[]; // nom, AUC, médiane détresse, médiane autres
  final cats = <(String, String, double, double)>[]; // variable, modalité, part détresse, part autres
  for (var i = 0; i < head.length; i++) {
    final n = head[i];
    if (excluded.contains(n)) continue;
    if (categorical.contains(n)) {
      String level(List<String> r) => r[i].isEmpty ? '(aucun)' : r[i];
      final levels = {for (final r in rows) level(r)};
      for (final l in levels) {
        final p1 = pos.where((r) => level(r) == l).length / pos.length;
        final p0 = neg.where((r) => level(r) == l).length / neg.length;
        cats.add((n, l, p1, p0));
      }
      continue;
    }
    double? v(List<String> r) => double.tryParse(r[i]);
    final x1 = [for (final r in pos) if (v(r) != null) v(r)!];
    final x0 = [for (final r in neg) if (v(r) != null) v(r)!];
    if (x1.isEmpty || x0.isEmpty) continue;
    // les jours sans emploi se comparent en part des jours observés
    if (n == 'jours_sans_emploi') {
      final d1 = [for (final r in pos) double.parse(r[cDays])], d0 = [for (final r in neg) double.parse(r[cDays])];
      for (var k = 0; k < x1.length; k++) {
        x1[k] = d1[k] > 0 ? x1[k] / d1[k] : 0;
      }
      for (var k = 0; k < x0.length; k++) {
        x0[k] = d0[k] > 0 ? x0[k] / d0[k] : 0;
      }
    }
    numeric.add((n == 'jours_sans_emploi' ? 'part_jours_sans_emploi' : n, auc(x1, x0), median(x1), median(x0)));
  }
  numeric.sort((a, b) => (b.$2 - 0.5).abs().compareTo((a.$2 - 0.5).abs()));
  stdout.writeln('## Variables numériques');
  stdout.writeln();
  stdout.writeln('| Variable | AUC | Sens | Médiane (détresse) | Médiane (autres) |');
  stdout.writeln('|---|---|---|---|---|');
  for (final x in numeric) {
    final sens = (x.$2 - 0.5).abs() < 0.05 ? '≈' : (x.$2 > 0.5 ? 'plus haut en détresse' : 'plus bas en détresse');
    stdout.writeln('| ${x.$1} | ${num(x.$2)} | $sens | ${num(x.$3)} | ${num(x.$4)} |');
  }
  stdout.writeln();
  cats.sort((a, b) => (b.$3 - b.$4).abs().compareTo((a.$3 - a.$4).abs()));
  stdout.writeln('## Variables qualitatives');
  stdout.writeln();
  stdout.writeln('| Variable | Modalité | Part (détresse) | Part (autres) | Écart |');
  stdout.writeln('|---|---|---|---|---|');
  for (final x in cats.take(12)) {
    String pc(double v) => '${(v * 100).toStringAsFixed(0)} %';
    stdout.writeln('| ${x.$1} | ${x.$2} | ${pc(x.$3)} | ${pc(x.$4)} | '
        '${x.$3 >= x.$4 ? '+' : '−'}${(math.max(x.$3, x.$4) - math.min(x.$3, x.$4)) * 100 ~/ 1} pt |');
  }
}
