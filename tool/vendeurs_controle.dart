// Test de contrôle de l'échantillonnage des vendeurs (Params.sellerSample = k) : compare deux synthèses enregistrées par
// `tool/stabilite.dart --save` (A : k = 0, B : k > 0), graine par graine, et écrit des tableaux avec intervalles.
//
//   dart run tool/vendeurs_controle.dart A.json B.json [--titre "3 000 citoyens"] [--out rapport.md]
//
// Pour chaque étape (sans filets, avec filets) : indicateurs d'ensemble, demande non servie par bien, concentration et
// dispersion des prix par secteur. Chaque écart est la différence B − A par graine ; on donne sa médiane, l'intervalle de
// confiance à 95 % de cette médiane (bootstrap percentile des graines, comme `--compare`) et le nombre de graines où B > A.

import 'dart:convert';
import 'dart:io';

import 'package:econodes/engine/model.dart';

import 'stabilite.dart' show Dist, bootstrapMedian;

typedef Json = Map<String, dynamic>;

String fmt(double v, String kind) {
  switch (kind) {
    case 'pc':
      return '${(v * 100).toStringAsFixed(1).replaceAll('.', ',')} %';
    case 'pc2':
      return '${(v * 100).toStringAsFixed(2).replaceAll('.', ',')} %';
    case 'dec':
      return v.toStringAsFixed(3).replaceAll('.', ',');
    default:
      return v.toStringAsFixed(1).replaceAll('.', ',');
  }
}

String fmtDiff(double v, String kind) {
  final pt = kind == 'pc' || kind == 'pc2';
  final x = pt ? v * 100 : v;
  final d = kind == 'dec' ? 3 : (kind == 'pc2' ? 2 : 1);
  final t = '${x >= 0 ? '+' : '−'}${x.abs().toStringAsFixed(d).replaceAll('.', ',')}';
  return pt ? '$t pt' : t;
}

/// Une ligne : A, B, écart médian apparié, intervalle, graines où B > A.
String row(String label, List<double> a, List<double> b, String kind) {
  final n = a.length;
  final d = [for (var i = 0; i < n; i++) b[i] - a[i]];
  final (lo, hi) = bootstrapMedian(d);
  final med = Dist(d).median;
  final up = d.where((x) => x > 0).length;
  final concl = lo > 0 || hi < 0 ? 'oui' : 'non';
  return '| $label | ${fmt(Dist(a).median, kind)} | ${fmt(Dist(b).median, kind)} | ${fmtDiff(med, kind)} | '
      '[${fmtDiff(lo, kind)} ; ${fmtDiff(hi, kind)}] | $up/$n | $concl |';
}

const head = '| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |\n'
    '|---|---|---|---|---|---|---|';

double? asNum(Object? v) => v is num ? v.toDouble() : null;

Object? lookup(Json r, String key) {
  Object? v = r;
  for (final p in key.split('.')) {
    if (v is! Map) return null;
    v = v[p];
  }
  return v;
}

void main(List<String> args) {
  final files = <String>[];
  var title = '', out = '';
  for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--titre':
        title = args[++i];
      case '--out':
        out = args[++i];
      default:
        files.add(args[i]);
    }
  }
  final ja = jsonDecode(File(files[0]).readAsStringSync()) as Json;
  final jb = jsonDecode(File(files[1]).readAsStringSync()) as Json;
  final b = StringBuffer();
  b.writeln('# Test de contrôle : k = 0 contre k > 0${title.isEmpty ? '' : ' ($title)'}\n');
  b.writeln('- A : `${files[0].split(RegExp(r'[/\\]')).last}` ; B : `${files[1].split(RegExp(r'[/\\]')).last}`.');
  b.writeln('- Graines (communes à A et B) : voir les « x/n » ci-dessous · ${ja['days']} jours · chauffe ${ja['warmup']} jours · '
      'paramètres A ${ja['params']}, B ${jb['params']}.\n');
  for (final phase in ['base', 'nets']) {
    if (ja['phases'][phase] == null || jb['phases'][phase] == null) continue;
    final ra = (ja['phases'][phase] as List).cast<Json>(), rb = (jb['phases'][phase] as List).cast<Json>();
    // appariement par graine
    final idsB = {for (final r in rb) r['seed'] as int};
    final ids = [for (final r in ra) if (idsB.contains(r['seed'] as int)) r['seed'] as int]..sort(); // graines communes
    Json by(List<Json> rs, int id) => rs.firstWhere((r) => r['seed'] == id);
    final A = [for (final id in ids) by(ra, id)], B = [for (final id in ids) by(rb, id)];
    final crashes = [for (final r in [...A, ...B]) if (r['crash'] != null) '${r['seed']} : ${r['crash']}'];
    b.writeln('## ${phase == 'base' ? 'Sans filets' : 'Avec filets'}\n');
    if (crashes.isNotEmpty) b.writeln('Parties interrompues : ${crashes.join(' ; ')}\n');

    List<double> col(List<Json> rs, String key) => [for (final r in rs) asNum(lookup(r, key)) ?? 0];
    b.writeln('### Indicateurs d’ensemble (après la chauffe, sauf mention)\n');
    b.writeln(head);
    for (final (key, label, kind) in const [
      ('homelessMean', 'Sans-abri moyen', 'pc'),
      ('hungerMean', 'Faim moyenne', 'pc'),
      ('unempMean', 'Chômage moyen', 'pc'),
      ('unmetShare', 'Demande non servie (unités non achetées / demandées)', 'pc2'),
      ('cpiRatio', 'Indice des prix en fin de partie (1 = fin de chauffe)', 'dec'),
      ('inflMean', 'Inflation moyenne par jour', 'pc2'),
      ('giniMean', 'Gini moyen', 'dec'),
      ('healthMean', 'Santé moyenne', 'dec'),
      ('firmsMean', 'Parc moyen d’entreprises', 'dec1'),
      ('firmsCreated', 'Naissances d’entreprises (toute la partie)', 'dec1'),
      ('firmsClosed', 'Fermetures d’entreprises (toute la partie)', 'dec1'),
      ('deathsPctPark', 'Morts par an, en % du parc moyen', 'dec1'),
      ('topShareMed', 'Part de la plus grande entreprise (médiane des biens)', 'pc'),
      ('hhiMed', 'Herfindahl des ventes (médiane des biens)', 'dec'),
      ('priceDispMed', 'Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens)', 'pc'),
    ]) {
      b.writeln(row(label, col(A, key), col(B, key), kind));
    }

    final goodsList = [for (final g in goods.keys) if ((A.first['unmetByGood'] as Map?)?.containsKey(g) ?? false) g];
    b.writeln('\n### Demande non servie par bien\n');
    b.writeln(head);
    for (final g in goodsList) {
      b.writeln(row(goods[g]!.label, col(A, 'unmetByGood.$g'), col(B, 'unmetByGood.$g'), 'pc2'));
    }

    b.writeln('\n### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)\n');
    b.writeln(head);
    for (final sec in sectors) {
      final gs = [for (final g in goods.keys) if (goods[g]!.sector == sec) g];
      List<double> agg(List<Json> rs, int idx) => [
            for (final r in rs)
              () {
                final c = r['concentration'] as Map? ?? {};
                final v = [for (final g in gs) if (c[g] != null) (c[g] as List)[idx] as num];
                return v.isEmpty ? 0.0 : v.fold(0.0, (a, x) => a + x) / v.length;
              }()
          ];
      List<double> disp(List<Json> rs) => [
            for (final r in rs)
              () {
                final c = r['priceDispByGood'] as Map? ?? {};
                final v = [for (final g in gs) if (c[g] != null) c[g] as num];
                return v.isEmpty ? 0.0 : v.fold(0.0, (a, x) => a + x) / v.length;
              }()
          ];
      b.writeln(row('$sec : part de la plus grande entreprise', agg(A, 0), agg(B, 0), 'pc'));
      b.writeln(row('$sec : Herfindahl', agg(A, 1), agg(B, 1), 'dec'));
      b.writeln(row('$sec : vendeurs actifs par bien', agg(A, 2), agg(B, 2), 'dec1'));
      b.writeln(row('$sec : dispersion des prix', disp(A), disp(B), 'pc'));
    }
    b.writeln();
  }
  if (out.isEmpty) {
    stdout.write(b);
  } else {
    File(out).writeAsStringSync(b.toString());
    stdout.writeln('rapport écrit : $out');
  }
}
