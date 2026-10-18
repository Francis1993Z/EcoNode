// Recherche limitée des vendeurs (Params.sellerSample = k) : la liste des vendeurs qui ont du stock, tenue à jour,
// ne change ni la reprise depuis un instantané ni la partie à k = 0. La liste et la propriété « pas de fausse
// pénurie » sont vérifiées sur des parties aléatoires dans proprietes_test.dart.

import 'dart:convert';

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

import 'instantane_test.dart' show sameContinuation, snap;

void main() {
  test('k = 5, 1 000 citoyens : la reprise depuis un instantané donne la même suite qu’une partie continue', () {
    sameContinuation(() => Sim(seed: 21, params: Params()..population = 1000..sellerSample = 5), 40, 80);
  });

  test('l’instantané ne contient pas la liste des vendeurs et ne dépend pas de la façon d’y arriver', () {
    // même partie continue ou reprise au jour 30 : instantanés identiques octet pour octet au jour 60 (couvert par
    // sameContinuation) ; ici, le contenu : aucune clé de liste dans le texte
    final s = Sim(seed: 22, params: Params()..population = 600..sellerSample = 5);
    for (var d = 1; d <= 20; d++) {
      s.step();
    }
    final text = snap(s);
    final keys = <String>{};
    void walk(Object? x) {
      if (x is Map) {
        for (final e in x.entries) {
          keys.add(e.key as String);
          walk(e.value);
        }
      } else if (x is List) {
        x.forEach(walk);
      }
    }

    final j = jsonDecode(text) as Map;
    walk(j);
    expect(keys.where((k) => RegExp(r'(^|[^r])avail|dispon', caseSensitive: false).hasMatch(k)), isEmpty);
    expect((j['params'] as Map)['sellerSample'], 5);
  });

  test('3 000 citoyens : un échantillon plus grand que tous les vendeurs (k = 100 000) donne la partie de k = 0', () {
    // le chemin de l'échantillonnage (liste des vendeurs disponibles, tirage, offres) examine alors tous les vendeurs
    // qui ont une unité en stock : il doit redonner exactement la recherche complète
    final a = Sim(seed: 9, params: Params()..population = 3000..sellerSample = 0);
    final b = Sim(seed: 9, params: Params()..population = 3000..sellerSample = 100000);
    for (var d = 1; d <= 50; d++) {
      a.step();
      b.step();
    }
    final ja = jsonDecode(snap(a)) as Map<String, dynamic>, jb = jsonDecode(snap(b)) as Map<String, dynamic>;
    for (final j in [ja, jb]) {
      (j['params'] as Map).remove('sellerSample');
      j.remove('lastSeller');
    }
    expect(jsonEncode(jb), jsonEncode(ja));
  });

  test('240 citoyens : k = 5 donne exactement la même partie que k = 0', () {
    final a = Sim(seed: 7, params: Params()..sellerSample = 0);
    final b = Sim(seed: 7, params: Params()..sellerSample = 5);
    for (var d = 1; d <= 200; d++) {
      a.step();
      b.step();
    }
    // l'instantané de b ne diffère que par le paramètre et la mémoire d'habitude des ménages
    final ja = jsonDecode(snap(a)) as Map<String, dynamic>, jb = jsonDecode(snap(b)) as Map<String, dynamic>;
    for (final j in [ja, jb]) {
      (j['params'] as Map).remove('sellerSample');
      j.remove('lastSeller');
    }
    expect(jsonEncode(jb), jsonEncode(ja));
  });
}
