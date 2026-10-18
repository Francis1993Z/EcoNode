// Le produit de deux entiers de 32 bits, modulo 2³², a deux voies : par moitiés de 16 bits (JavaScript, où un produit de
// 64 bits dépasse les 53 bits des entiers) et un seul produit (VM, entiers de 64 bits). Elles doivent donner le même
// résultat pour toute paire : c'est ce qui garde les tirages identiques sur la VM et sur le web.

import 'package:econodes/engine/sim.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('imul : les deux voies donnent le même produit modulo 2³²', () {
    final edges = [0, 1, 2, 5, 0x7FFF, 0x8000, 0xFFFF, 0x10000, 0x7FFFFFFF, 0x80000000, 0xFFFFFFFE, 0xFFFFFFFF, 0xCC9E2D51, 0x1B873593, 0x85EBCA6B];
    for (final a in edges) {
      for (final b in edges) {
        expect(Mulberry32.imulWide(a, b), Mulberry32.imulHalves(a, b), reason: '$a × $b');
      }
    }
    final r = Mulberry32(12345);
    for (var i = 0; i < 300000; i++) {
      final a = (r.next() * 4294967296).floor(), b = (r.next() * 4294967296).floor();
      if (Mulberry32.imulWide(a, b) != Mulberry32.imulHalves(a, b)) fail('$a × $b');
    }
  });

  test('Mulberry32.first(graine) est le premier tirage de Mulberry32(graine)', () {
    final r = Mulberry32(777);
    for (var i = 0; i < 100000; i++) {
      final seed = (r.next() * 4294967296).floor();
      if (Mulberry32.first(seed) != Mulberry32(seed).next()) fail('graine $seed');
    }
  });

  test('hash32 et Mulberry32 : valeurs fixes (les mêmes sur la VM et en JavaScript)', () {
    // tool/parite.dart écrit ces valeurs ; elles ne doivent jamais changer
    expect([hash32(0, 0), hash32(42, 1), hash32(0xFFFFFFFF, 0x7FFFFFFF), hash32(123456789, 987654321)],
        [4279838538, 2416545486, 4141235960, 890124905]);
  });
}
