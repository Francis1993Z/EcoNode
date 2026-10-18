// Profileur CPU d'une partie : se connecte au service VM d'un processus lancé avec --observe, relève les échantillons CPU
// par fenêtres de 5 s et cumule, par fonction, le temps exclusif (en haut de la pile) et inclusif (n'importe où dans la
// pile). Les pourcentages sont des parts des échantillons relevés.
//
//   dart run --observe=8181 tool/perf.dart --population 100000 --jours 50 --depuis 11   (une console)
//   dart run tool/profil.dart ws://127.0.0.1:8181/ws 120                                  (une autre : secondes à relever)
//
// Le processus profilé tourne en JIT, plus lent que l'exécutable natif : les proportions comptent, pas les durées.
// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'package:vm_service/vm_service.dart';
import 'package:vm_service/vm_service_io.dart';

Future<void> main(List<String> args) async {
  final uri = args[0];
  final seconds = int.parse(args[1]);
  final vm = await vmServiceConnectUri(uri);
  final v = await vm.getVM();
  final iso = v.isolates!.firstWhere((i) => i.name == 'main');
  final excl = <String, int>{}, incl = <String, int>{};
  final callers = <String, Map<String, int>>{}; // fonction en haut de pile -> appelant direct -> échantillons
  var total = 0;
  var t0 = (await vm.getVMTimelineMicros()).timestamp!;
  for (var k = 0; k < seconds ~/ 5; k++) {
    await Future.delayed(const Duration(seconds: 5));
    final t1 = (await vm.getVMTimelineMicros()).timestamp!;
    final cs = await vm.getCpuSamples(iso.id!, t0, t1 - t0);
    t0 = t1;
    String name(int i) {
      final f = cs.functions![i].function;
      if (f is FuncRef) {
        final o = f.owner;
        final own = o is ClassRef ? '${o.name}.' : (o is FuncRef ? '${o.name}.' : '');
        return '$own${f.name}';
      }
      return f is NativeFunction ? 'natif:${f.name}' : '$f';
    }
    for (final s in cs.samples!) {
      final st = s.stack!;
      if (st.isEmpty) continue;
      total++;
      excl[name(st.first)] = (excl[name(st.first)] ?? 0) + 1;
      // appelants : on remonte la pile jusqu'à la première fonction de Sim ou d'une classe du moteur
      final up = [for (var i = 1; i < st.length && i < 4; i++) name(st[i])].join(' < ');
      final m = callers[name(st.first)] ??= {};
      m[up] = (m[up] ?? 0) + 1;
      for (final n in {for (final i in st) name(i)}) {
        incl[n] = (incl[n] ?? 0) + 1;
      }
    }
  }
  print('échantillons : $total');
  void top(String t, Map<String, int> m) {
    print('== $t');
    final l = m.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    for (final e in l.take(40)) {
      print('${(100 * e.value / total).toStringAsFixed(1).padLeft(5)} %  ${e.key}');
    }
  }
  top('exclusif', excl);
  final ex = excl.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
  for (final e in ex.take(4)) {
    print('== appelants de ${e.key} (${(100 * e.value / total).toStringAsFixed(1)} %)');
    final l = callers[e.key]!.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    for (final c in l.take(8)) {
      print('${(100 * c.value / e.value).toStringAsFixed(1).padLeft(5)} %  ${c.key}');
    }
  }
  top('inclusif', incl);
  await vm.dispose();
}
