// Petits graphiques dessinés au canevas : lignes, aires empilées, histogramme.

import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'format.dart';
import 'palette.dart';

class Series {
  final String label;
  final Color color;
  final List<double> values;
  const Series(this.label, this.color, this.values);
}

/// Réduit une liste à au plus [max] points (on garde le dernier).
List<double> downsample(List<double> v, [int max = 160]) {
  if (v.length <= max) return v;
  final out = <double>[];
  final step = (v.length - 1) / (max - 1);
  for (var i = 0; i < max; i++) {
    out.add(v[(i * step).round()]);
  }
  return out;
}

String _axis(double v, String unit) {
  if (unit == '%') return '${fmtNum(v * 100, v.abs() < 0.1 ? 1 : 0)} %';
  if (unit == '\$') return v.abs() >= 1000 ? kmoney(v) : fmtNum(v, v.abs() < 10 ? 1 : 0);
  return fmtNum(v, v.abs() < 10 ? 1 : 0);
}

class ChartCard extends StatelessWidget {
  final String title;
  final List<Series> series;
  final bool stacked;
  final String unit; // '%', '$' ou ''
  final double height;
  final double? minY;
  const ChartCard({
    super.key,
    required this.title,
    required this.series,
    this.stacked = false,
    this.unit = '',
    this.height = 110,
    this.minY,
  });

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: pal.sheet,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pal.rule2),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: pal.ink, fontSize: 12, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Wrap(spacing: 10, runSpacing: 2, children: [
          for (final s in series)
            Row(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: s.color, shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Text(s.label, style: TextStyle(color: pal.ink2, fontSize: 10.5)),
            ]),
        ]),
        const SizedBox(height: 6),
        SizedBox(
          height: height,
          width: double.infinity,
          child: CustomPaint(painter: _LinePainter(series, stacked, unit, pal, minY)),
        ),
      ]),
    );
  }
}

class _LinePainter extends CustomPainter {
  final List<Series> series;
  final bool stacked;
  final String unit;
  final Pal pal;
  final double? minY;
  _LinePainter(this.series, this.stacked, this.unit, this.pal, this.minY);

  @override
  bool shouldRepaint(covariant _LinePainter old) => true;

  void _text(Canvas c, String t, Offset o, {bool right = false}) {
    final tp = TextPainter(
      text: TextSpan(text: t, style: mono(pal.ink3, 9)),
      textDirection: ui.TextDirection.ltr,
    )..layout();
    c.drawText(tp, right ? Offset(o.dx - tp.width, o.dy) : o);
  }

  @override
  void paint(Canvas canvas, Size size) {
    const left = 44.0, bottom = 4.0, top = 4.0;
    final plot = Rect.fromLTRB(left, top, size.width - 4, size.height - bottom);
    if (series.isEmpty || series.first.values.length < 2) {
      _text(canvas, 'en attente de données…', Offset(left, size.height / 2 - 6));
      return;
    }
    final n = series.first.values.length;
    final stacks = <List<double>>[];
    if (stacked) {
      var acc = List<double>.filled(n, 0.0);
      for (final s in series) {
        final next = List<double>.generate(n, (i) => acc[i] + (i < s.values.length ? s.values[i] : 0.0));
        stacks.add(next);
        acc = next;
      }
    }
    var lo = double.infinity, hi = -double.infinity;
    if (stacked) {
      lo = 0;
      for (final v in stacks.last) {
        if (v > hi) hi = v;
      }
    } else {
      for (final s in series) {
        for (final v in s.values) {
          if (v < lo) lo = v;
          if (v > hi) hi = v;
        }
      }
      if (minY != null) lo = minY!;
      if (lo > 0 && lo < hi * 0.5) lo = 0;
    }
    if (hi - lo < 1e-9) {
      hi = lo + 1;
    }
    final pad = stacked ? 0.0 : (hi - lo) * 0.06;
    hi += pad;
    if (minY == null && !stacked && lo != 0) lo -= pad;

    double px(int i) => plot.left + plot.width * i / (n - 1);
    double py(double v) => plot.bottom - plot.height * (v - lo) / (hi - lo);

    final grid = Paint()
      ..color = pal.rule2
      ..strokeWidth = 1;
    for (var k = 0; k <= 2; k++) {
      final v = lo + (hi - lo) * k / 2;
      final y = py(v);
      canvas.drawLine(Offset(plot.left, y), Offset(plot.right, y), grid);
      _text(canvas, _axis(v, unit), Offset(plot.left - 4, y - 5), right: true);
    }

    if (stacked) {
      for (var si = series.length - 1; si >= 0; si--) {
        final upper = stacks[si];
        final lower = si == 0 ? List<double>.filled(n, 0.0) : stacks[si - 1];
        final path = Path()..moveTo(px(0), py(upper[0]));
        for (var i = 1; i < n; i++) {
          path.lineTo(px(i), py(upper[i]));
        }
        for (var i = n - 1; i >= 0; i--) {
          path.lineTo(px(i), py(lower[i]));
        }
        path.close();
        canvas.drawPath(path, Paint()..color = series[si].color.withOpacity(0.55));
      }
    } else {
      for (final s in series) {
        final path = Path();
        for (var i = 0; i < s.values.length; i++) {
          final x = px(i), y = py(s.values[i]);
          if (i == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }
        canvas.drawPath(
            path,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.8
              ..strokeJoin = StrokeJoin.round
              ..color = s.color);
      }
    }
  }
}

extension on Canvas {
  void drawText(TextPainter tp, Offset o) => tp.paint(this, o);
}

/// Histogramme simple (barres verticales).
class HistogramCard extends StatelessWidget {
  final String title;
  final List<double> values;
  final List<String> labels;
  final Color color;
  const HistogramCard({super.key, required this.title, required this.values, required this.labels, required this.color});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        color: pal.sheet,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: pal.rule2),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: pal.ink, fontSize: 12, fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        SizedBox(
          height: 90,
          width: double.infinity,
          child: CustomPaint(painter: _HistPainter(values, labels, color, pal)),
        ),
      ]),
    );
  }
}

class _HistPainter extends CustomPainter {
  final List<double> values;
  final List<String> labels;
  final Color color;
  final Pal pal;
  _HistPainter(this.values, this.labels, this.color, this.pal);

  @override
  bool shouldRepaint(covariant _HistPainter old) => true;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    var hi = 1.0;
    for (final v in values) {
      if (v > hi) hi = v;
    }
    final w = size.width / values.length;
    const labH = 12.0;
    for (var i = 0; i < values.length; i++) {
      final h = (size.height - labH - 12) * values[i] / hi;
      final r = Rect.fromLTWH(i * w + 2, size.height - labH - h, w - 4, h);
      canvas.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(2)), Paint()..color = color.withOpacity(0.75));
      final t = TextPainter(
        text: TextSpan(text: '${values[i].round()}', style: mono(pal.ink2, 9)),
        textDirection: ui.TextDirection.ltr,
      )..layout();
      t.paint(canvas, Offset(i * w + (w - t.width) / 2, r.top - 12));
      if (i < labels.length) {
        final l = TextPainter(
          text: TextSpan(text: labels[i], style: mono(pal.ink3, 8)),
          textDirection: ui.TextDirection.ltr,
          maxLines: 1,
        )..layout(maxWidth: w);
        l.paint(canvas, Offset(i * w + (w - l.width) / 2, size.height - labH + 1));
      }
    }
  }
}
