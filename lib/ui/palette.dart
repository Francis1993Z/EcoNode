import 'dart:ui' show FontFeature;

import 'package:flutter/material.dart';

/// Jetons de couleur de l'interface (clair / sombre), reprenant la version web.
class Pal {
  final Color paper, sheet, node, ink, ink2, ink3, rule, rule2, gridMinor, gridMajor, accent, accentSoft;
  final Color primaire, transfo, conso, money, warn, bad, ok;

  const Pal({
    required this.paper,
    required this.sheet,
    required this.node,
    required this.ink,
    required this.ink2,
    required this.ink3,
    required this.rule,
    required this.rule2,
    required this.gridMinor,
    required this.gridMajor,
    required this.accent,
    required this.accentSoft,
    required this.primaire,
    required this.transfo,
    required this.conso,
    required this.money,
    required this.warn,
    required this.bad,
    required this.ok,
  });

  static const Pal light = Pal(
    paper: Color(0xFFE9EDEF),
    sheet: Color(0xFFF7F9FA),
    node: Color(0xFFFFFFFF),
    ink: Color(0xFF172027),
    ink2: Color(0xFF51606C),
    ink3: Color(0xFF7D8A95),
    rule: Color(0xFFC6CFD5),
    rule2: Color(0xFFDFE5E9),
    gridMinor: Color(0xFFDFE4E7),
    gridMajor: Color(0xFFCFD6DB),
    accent: Color(0xFF0A7C8A),
    accentSoft: Color(0xFFD3EEF1),
    primaire: Color(0xFFA87410),
    transfo: Color(0xFF2B67AA),
    conso: Color(0xFFAD2F74),
    money: Color(0xFF23804A),
    warn: Color(0xFFB85410),
    bad: Color(0xFFC22B2B),
    ok: Color(0xFF23804A),
  );

  static const Pal dark = Pal(
    paper: Color(0xFF1A2027),
    sheet: Color(0xFF212932),
    node: Color(0xFF27303A),
    ink: Color(0xFFDFE6EB),
    ink2: Color(0xFF9EACB8),
    ink3: Color(0xFF74828E),
    rule: Color(0xFF38444F),
    rule2: Color(0xFF2D3741),
    gridMinor: Color(0xFF222A33),
    gridMajor: Color(0xFF2A333D),
    accent: Color(0xFF3CC3D0),
    accentSoft: Color(0xFF1D3B42),
    primaire: Color(0xFFE2B545),
    transfo: Color(0xFF64A8EE),
    conso: Color(0xFFE870B2),
    money: Color(0xFF5CC47E),
    warn: Color(0xFFF0904F),
    bad: Color(0xFFF26A6A),
    ok: Color(0xFF5CC47E),
  );

  static Pal of(BuildContext context) => Theme.of(context).brightness == Brightness.dark ? dark : light;

  Color sector(String s) {
    switch (s) {
      case 'primaire':
        return primaire;
      case 'transfo':
        return transfo;
      default:
        return conso;
    }
  }
}

const String monoFamily = 'monospace';

TextStyle mono(Color c, double size, {FontWeight weight = FontWeight.w400}) => TextStyle(
      fontFamily: monoFamily,
      fontSize: size,
      fontWeight: weight,
      color: c,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
