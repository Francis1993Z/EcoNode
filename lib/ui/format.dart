// Formats à la québécoise : espace insécable pour les milliers, virgule décimale.

String fmtNum(double v, int decimals) {
  if (v.isNaN || v.isInfinite) return '—';
  final neg = v < 0;
  final a = v.abs();
  final s = a.toStringAsFixed(decimals);
  final parts = s.split('.');
  final ip = parts[0];
  final b = StringBuffer();
  for (var i = 0; i < ip.length; i++) {
    if (i > 0 && (ip.length - i) % 3 == 0) b.write(' ');
    b.write(ip[i]);
  }
  var out = b.toString();
  if (decimals > 0) out += ',${parts[1]}';
  final isZero = double.tryParse(s) == 0;
  return neg && !isZero ? '-$out' : out;
}

String money(double v) => '${fmtNum(v, v.abs() < 100 ? 1 : 0)} \$';
String money0(double v) => '${fmtNum(v, 0)} \$';
String qty(double v) => fmtNum(v, v.abs() < 10 ? 1 : 0);
String pct(double v) => '${fmtNum(v * 100, 1)} %';
String kmoney(double v) {
  final a = v.abs();
  if (a >= 1e6) return '${fmtNum(v / 1e6, 2)} M\$';
  if (a >= 1e4) return '${fmtNum(v / 1e3, 1)} k\$';
  return money0(v);
}

/// Parse un champ numérique saisi au clavier (virgule ou point).
double? parseNum(String s) => double.tryParse(s.trim().replaceAll(',', '.').replaceAll(' ', '').replaceAll(' ', ''));
