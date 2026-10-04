// Graphe de la chaîne d'approvisionnement : nodes dessinés au canevas, déplaçables,
// avec panoramique (1 doigt sur le vide) et zoom (pincement ou molette).

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../engine/model.dart';
import '../engine/sim.dart';
import 'controller.dart';
import 'format.dart';
import 'layout.dart';
import 'palette.dart';

/// Port d'entrée des services aux entreprises et des machines (ligne « Capital »).
const String kSvcPort = '@svc';

/// Boîte d'un node dans le repère du monde.
class NodeBox {
  final Selection sel;
  final Rect rect;
  final Map<String, double> outY; // bien → y du port de sortie (côté droit)
  final Map<String, double> inY; // bien → y du port d'entrée (côté gauche)
  NodeBox(this.sel, this.rect, this.outY, this.inY);

  Offset outPort(String good) => Offset(rect.right, outY[good] ?? rect.top + kHeaderH / 2);
  Offset inPort(String good) => Offset(rect.left, inY[good] ?? inY[kSvcPort] ?? rect.top + kHeaderH / 2);
  Offset get headRight => Offset(rect.right, rect.top + kHeaderH / 2);
  Offset get headLeft => Offset(rect.left, rect.top + kHeaderH / 2);
}

String keyOf(Selection s) => s.kind == 'firm' ? s.id.toString() : s.kind;

NodeBox firmBox(Firm f) {
  final outY = <String, double>{};
  final inY = <String, double>{};
  var y = f.y + kHeaderH;
  for (final g in f.outputs.keys) {
    outY[g] = y + kRowH / 2;
    y += kRowH;
  }
  if (f.inputs.isNotEmpty) y += kSepH;
  for (final g in f.inputs.keys) {
    inY[g] = y + kRowH / 2;
    y += kRowH;
  }
  inY[kSvcPort] = y + kRowH / 2;
  return NodeBox(Selection('firm', f.id), Rect.fromLTWH(f.x, f.y, kNodeW, firmHeight(f)), outY, inY);
}

List<NodeBox> allBoxes(Sim sim) {
  final out = <NodeBox>[];
  for (final f in sim.firms) {
    out.add(firmBox(f));
  }
  // ménages : un port d'entrée par bien qu'ils achètent
  final m = sim.nodePos['M']!;
  final inY = <String, double>{};
  var y = m[1] + kHeaderH;
  for (final g in householdGoods) {
    inY[g] = y + kRowH / 2;
    y += kRowH;
  }
  out.add(NodeBox(const Selection('M'), Rect.fromLTWH(m[0], m[1], kNodeW, homesHeight()), {}, inY));
  for (final k in const ['E', 'B']) {
    final p = sim.nodePos[k]!;
    out.add(NodeBox(Selection(k), Rect.fromLTWH(p[0], p[1], kNodeW, kSmallH), {}, {}));
  }
  if (showsExterior(sim)) {
    final x = sim.nodePos['X']!;
    out.add(NodeBox(const Selection('X'), Rect.fromLTWH(x[0], x[1], kNodeW, kSmallH), {}, {}));
  }
  return out;
}

bool showsExterior(Sim sim) {
  if (sim.params.trade) return true;
  for (final e in sim.flowsEma.values) {
    if ((e.from == 'X' || e.to == 'X') && e.value > 1) return true;
  }
  return false;
}

class GraphView extends StatefulWidget {
  final SimController ctrl;
  const GraphView({super.key, required this.ctrl});

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  double scale = 0.5;
  Offset offset = const Offset(20, 20);
  bool _fitted = false;
  Size _size = Size.zero;
  Sim? _fittedSim;

  // état du geste en cours
  NodeBox? _dragBox;
  Offset _startFocal = Offset.zero;
  Offset _startOffset = Offset.zero;
  double _startScale = 1;
  bool _moved = false;

  Offset toWorld(Offset p) => (p - offset) / scale;

  NodeBox? hit(Offset screen) {
    final w = toWorld(screen);
    final boxes = allBoxes(widget.ctrl.sim);
    for (var i = boxes.length - 1; i >= 0; i--) {
      if (boxes[i].rect.inflate(4).contains(w)) return boxes[i];
    }
    return null;
  }

  void fit() {
    final boxes = allBoxes(widget.ctrl.sim);
    if (boxes.isEmpty || _size.isEmpty) return;
    var r = boxes.first.rect;
    for (final b in boxes) {
      r = r.expandToInclude(b.rect);
    }
    r = r.inflate(24);
    final s = math.min(_size.width / r.width, _size.height / r.height).clamp(0.15, 1.5).toDouble();
    setState(() {
      scale = s;
      offset = Offset((_size.width - r.width * s) / 2 - r.left * s, (_size.height - r.height * s) / 2 - r.top * s);
    });
  }

  void zoomAt(Offset focal, double factor) {
    final ns = (scale * factor).clamp(0.15, 2.5).toDouble();
    final w = toWorld(focal);
    setState(() {
      scale = ns;
      offset = focal - w * ns;
    });
  }

  void _onScaleStart(ScaleStartDetails d) {
    _startFocal = d.localFocalPoint;
    _startOffset = offset;
    _startScale = scale;
    _moved = false;
    _dragBox = d.pointerCount == 1 ? hit(d.localFocalPoint) : null;
  }

  void _onScaleUpdate(ScaleUpdateDetails d) {
    if (!_moved && (d.localFocalPoint - _startFocal).distance < 6 && d.pointerCount == 1) return;
    _moved = true;
    if (d.pointerCount >= 2) {
      _dragBox = null;
      final ns = (_startScale * d.scale).clamp(0.15, 2.5).toDouble();
      final w = (_startFocal - _startOffset) / _startScale;
      setState(() {
        scale = ns;
        offset = d.localFocalPoint - w * ns;
      });
      return;
    }
    final b = _dragBox;
    if (b != null) {
      final delta = d.focalPointDelta / scale;
      final sim = widget.ctrl.sim;
      if (b.sel.kind == 'firm') {
        final f = sim.firm(b.sel.id!);
        if (f != null) {
          f.x += delta.dx;
          f.y += delta.dy;
        }
      } else {
        final p = sim.nodePos[b.sel.kind];
        if (p != null) {
          p[0] += delta.dx;
          p[1] += delta.dy;
        }
      }
      widget.ctrl.touch();
    } else {
      setState(() => offset = _startOffset + (d.localFocalPoint - _startFocal));
    }
  }

  void _onScaleEnd(ScaleEndDetails d) {
    if (!_moved) {
      final b = hit(_startFocal);
      if (b != null) widget.ctrl.select(b.sel);
    }
    _dragBox = null;
  }

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return LayoutBuilder(builder: (context, c) {
      _size = Size(c.maxWidth, c.maxHeight);
      final sim = widget.ctrl.sim;
      if ((!_fitted || !identical(_fittedSim, sim)) && !_size.isEmpty) {
        _fitted = true;
        _fittedSim = sim;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) fit();
        });
      }
      return Stack(children: [
        Positioned.fill(
          child: Listener(
            onPointerSignal: (e) {
              if (e is PointerScrollEvent) {
                zoomAt(e.localPosition, e.scrollDelta.dy > 0 ? 0.9 : 1.1);
              }
            },
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: _onScaleStart,
              onScaleUpdate: _onScaleUpdate,
              onScaleEnd: _onScaleEnd,
              child: ClipRect(
                child: AnimatedBuilder(
                  animation: widget.ctrl,
                  builder: (context, _) => CustomPaint(
                    size: Size.infinite,
                    painter: GraphPainter(
                      sim: widget.ctrl.sim,
                      selection: widget.ctrl.selection,
                      showMoney: widget.ctrl.showMoneyFlows,
                      showServices: widget.ctrl.showServices,
                      pal: pal,
                      scale: scale,
                      offset: offset,
                      stamp: widget.ctrl.sim.day,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 8,
          bottom: 8,
          child: AnimatedBuilder(
            animation: widget.ctrl,
            builder: (context, _) => Row(children: [
              _MiniBtn(icon: Icons.add, onTap: () => zoomAt(Offset(_size.width / 2, _size.height / 2), 1.25)),
              const SizedBox(width: 6),
              _MiniBtn(icon: Icons.remove, onTap: () => zoomAt(Offset(_size.width / 2, _size.height / 2), 0.8)),
              const SizedBox(width: 6),
              _MiniBtn(icon: Icons.fit_screen, onTap: fit),
              const SizedBox(width: 6),
              _MiniBtn(
                icon: Icons.hub_outlined,
                tooltip: 'Flux de services aux entreprises',
                active: widget.ctrl.showServices,
                onTap: widget.ctrl.toggleServices,
              ),
            ]),
          ),
        ),
      ]);
    });
  }
}

class _MiniBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;
  final bool active;
  const _MiniBtn({required this.icon, required this.onTap, this.tooltip, this.active = false});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final btn = Material(
      color: active ? pal.accentSoft : pal.sheet,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), side: BorderSide(color: active ? pal.accent : pal.rule)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: SizedBox(width: 40, height: 40, child: Icon(icon, size: 20, color: active ? pal.accent : pal.ink)),
      ),
    );
    return tooltip == null ? btn : Tooltip(message: tooltip!, child: btn);
  }
}

// ---------------------------------------------------------------- dessin

class GraphPainter extends CustomPainter {
  final Sim sim;
  final Selection selection;
  final bool showMoney;
  final bool showServices;
  final Pal pal;
  final double scale;
  final Offset offset;
  final int stamp;

  GraphPainter({
    required this.sim,
    required this.selection,
    required this.showMoney,
    required this.showServices,
    required this.pal,
    required this.scale,
    required this.offset,
    required this.stamp,
  });

  @override
  bool shouldRepaint(covariant GraphPainter old) => true; // l'état de sim est mutable

  TextPainter _tp(String text, TextStyle style, {double? maxWidth, TextAlign align = TextAlign.left}) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: ui.TextDirection.ltr,
      maxLines: 1,
      ellipsis: '…',
      textAlign: align,
    );
    tp.layout(maxWidth: maxWidth ?? double.infinity);
    return tp;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = pal.paper);
    _grid(canvas, size);
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(scale);

    final boxes = allBoxes(sim);
    final byKey = <String, NodeBox>{for (final b in boxes) keyOf(b.sel): b};
    _edges(canvas, byKey);
    for (final b in boxes) {
      _node(canvas, b);
    }
    canvas.restore();
  }

  void _grid(Canvas canvas, Size size) {
    final step = 24 * scale;
    if (step < 6) return;
    final minor = Paint()
      ..color = pal.gridMinor
      ..strokeWidth = 1;
    final major = Paint()
      ..color = pal.gridMajor
      ..strokeWidth = 1;
    final ox = offset.dx % step;
    final oy = offset.dy % step;
    for (var x = ox; x < size.width; x += step) {
      final wx = ((x - offset.dx) / step).round();
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), wx % 5 == 0 ? major : minor);
    }
    for (var y = oy; y < size.height; y += step) {
      final wy = ((y - offset.dy) / step).round();
      canvas.drawLine(Offset(0, y), Offset(size.width, y), wy % 5 == 0 ? major : minor);
    }
  }

  // ---- arêtes

  /// Service ou machine acheté hors recette : il arrive sur la ligne « Capital ».
  bool _isService(FlowEdge e) {
    if (e.isMoney) return false;
    final id = int.tryParse(e.to);
    if (id == null) return false;
    final f = sim.firm(id);
    return f != null && !f.inputs.containsKey(e.good);
  }

  bool _hot(FlowEdge e) {
    final k = keyOf(selection);
    return e.from == k || e.to == k;
  }

  void _edges(Canvas canvas, Map<String, NodeBox> byKey) {
    final list = <FlowEdge>[];
    var maxGood = 1.0, maxMoney = 1.0;
    for (final e in sim.flowsEma.values) {
      if (e.value < 0.5) continue;
      if (e.isMoney) {
        if (!showMoney) continue;
        maxMoney = math.max(maxMoney, e.value);
      } else {
        if (!showServices && _isService(e) && !_hot(e)) continue;
        maxGood = math.max(maxGood, e.value);
      }
      list.add(e);
    }
    for (final e in list) {
      final a = byKey[e.from];
      final b = byKey[e.to];
      if (a == null || b == null) continue;
      Offset p0, p1;
      Color col;
      if (e.isMoney) {
        // l'argent : de bord à bord, côté qui regarde l'autre node
        final right = a.rect.center.dx <= b.rect.center.dx;
        p0 = right ? a.headRight : a.headLeft;
        p1 = right ? b.headLeft : b.headRight;
        col = pal.money;
      } else {
        p0 = e.from == 'X' ? a.headLeft : a.outPort(e.good);
        p1 = e.to == 'X' ? b.headLeft : b.inPort(e.good);
        col = pal.sector(goods[e.good]?.sector ?? 'tertiaire');
      }
      final hot = _hot(e);
      final service = _isService(e);
      final ref = e.isMoney ? maxMoney : maxGood;
      final w = (1.2 + 4.0 * math.sqrt(e.value / ref)).clamp(1.2, 5.2).toDouble();
      final dx = math.max(40.0, (p1.dx - p0.dx).abs() * 0.5);
      final path = Path()
        ..moveTo(p0.dx, p0.dy)
        ..cubicTo(p0.dx + dx, p0.dy, p1.dx - dx, p1.dy, p1.dx, p1.dy);
      final alpha = hot ? 0.95 : (service ? 0.3 : 0.55);
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = service && !hot ? math.min(w, 2.0) : w
        ..strokeCap = StrokeCap.round
        ..color = col.withValues(alpha: alpha);
      if (e.isMoney) {
        _dashed(canvas, path, paint, 7, 5);
      } else if (service) {
        _dashed(canvas, path, paint, 3, 4);
      } else {
        canvas.drawPath(path, paint);
      }
      _arrow(canvas, p1, col.withValues(alpha: hot ? 0.95 : 0.7));
    }
  }

  void _arrow(Canvas canvas, Offset tip, Color c) {
    final p = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(tip.dx - 8, tip.dy - 4)
      ..lineTo(tip.dx - 8, tip.dy + 4)
      ..close();
    canvas.drawPath(p, Paint()..color = c);
  }

  void _dashed(Canvas canvas, Path path, Paint paint, double on, double off) {
    for (final m in path.computeMetrics()) {
      var d = 0.0;
      while (d < m.length) {
        canvas.drawPath(m.extractPath(d, math.min(d + on, m.length)), paint);
        d += on + off;
      }
    }
  }

  // ---- nodes

  void _node(Canvas canvas, NodeBox b) {
    final r = b.rect;
    final selected = b.sel == selection;
    final rr = RRect.fromRectAndRadius(r, const Radius.circular(10));
    canvas.drawRRect(rr.shift(const Offset(0, 2)), Paint()..color = const Color(0x22000000));
    canvas.drawRRect(rr, Paint()..color = pal.node);
    canvas.drawRRect(
        rr,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = selected ? 2.5 : 1
          ..color = selected ? pal.accent : pal.rule);

    switch (b.sel.kind) {
      case 'firm':
        _firmNode(canvas, b);
        break;
      case 'M':
        _homesNode(canvas, b);
        break;
      case 'E':
        _stateNode(canvas, b);
        break;
      case 'B':
        _bankNode(canvas, b);
        break;
      default:
        _worldNode(canvas, b);
    }
  }

  void _header(Canvas canvas, Rect r, Color accent, String code, String title, String sub) {
    canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromLTWH(r.left, r.top, 5, kHeaderH), topLeft: const Radius.circular(10)),
        Paint()..color = accent);
    final badge = RRect.fromRectAndRadius(Rect.fromLTWH(r.left + 12, r.top + 9, 24, 22), const Radius.circular(5));
    canvas.drawRRect(badge, Paint()..color = accent.withValues(alpha: 0.16));
    final c = _tp(code, mono(accent, 11, weight: FontWeight.w700));
    c.paint(canvas, Offset(badge.left + (24 - c.width) / 2, badge.top + (22 - c.height) / 2));
    _tp(title, TextStyle(color: pal.ink, fontSize: 13, fontWeight: FontWeight.w700), maxWidth: kNodeW - 60)
        .paint(canvas, Offset(r.left + 44, r.top + 5));
    _tp(sub, mono(pal.ink3, 10), maxWidth: kNodeW - 56).paint(canvas, Offset(r.left + 44, r.top + 22));
    canvas.drawLine(Offset(r.left, r.top + kHeaderH), Offset(r.right, r.top + kHeaderH), Paint()..color = pal.rule2);
  }

  void _row(Canvas canvas, Rect r, double y, Color dot, String label, String right, {Color? rightColor}) {
    canvas.drawCircle(Offset(r.left + 14, y + kRowH / 2), 3.5, Paint()..color = dot);
    _tp(label, TextStyle(color: pal.ink, fontSize: 11.5), maxWidth: 90).paint(canvas, Offset(r.left + 24, y + 3));
    final t = _tp(right, mono(rightColor ?? pal.ink2, 10.5), maxWidth: kNodeW - 120);
    t.paint(canvas, Offset(r.right - 10 - t.width, y + 4));
  }

  void _port(Canvas canvas, Offset p, Color c) {
    canvas.drawCircle(p, 4.5, Paint()..color = pal.node);
    canvas.drawCircle(
        p,
        4.5,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.8
          ..color = c);
  }

  void _footer(Canvas canvas, Rect r, String left, String right, {Color? rightColor}) {
    final y = r.bottom - kFooterH;
    canvas.drawLine(Offset(r.left, y), Offset(r.right, y), Paint()..color = pal.rule2);
    _tp(left, mono(pal.ink2, 11, weight: FontWeight.w600), maxWidth: 110).paint(canvas, Offset(r.left + 12, y + 8));
    final t = _tp(right, mono(rightColor ?? pal.ink3, 10.5), maxWidth: 95);
    t.paint(canvas, Offset(r.right - 10 - t.width, y + 9));
  }

  void _firmNode(Canvas canvas, NodeBox b) {
    final f = sim.firm(b.sel.id!);
    if (f == null) return;
    final r = b.rect;
    final tpl = f.template;
    final sec = pal.sector(tpl.sector);
    _header(canvas, r, sec, tpl.code, f.name, '${tpl.label} · ${f.workers.length} empl. · ${money0(f.wage)}');
    var y = r.top + kHeaderH;
    for (final g in f.outputs.keys) {
      final gd = goods[g]!;
      _row(canvas, r, y, pal.sector(gd.sector), gd.label, '${qty(f.inv[g] ?? 0.0)} · ${money(f.price[g] ?? 0.0)}');
      _port(canvas, b.outPort(g), pal.sector(gd.sector));
      y += kRowH;
    }
    if (f.inputs.isNotEmpty) y += kSepH;
    for (final g in f.inputs.keys) {
      final gd = goods[g]!;
      final stock = f.inv[g] ?? 0.0;
      _row(canvas, r, y, pal.sector(gd.sector), gd.label, '${qty(stock)} ← ${money(sim.bestPrice(g))}',
          rightColor: f.inputLimited && stock < 1 ? pal.bad : null);
      _port(canvas, b.inPort(g), pal.sector(gd.sector));
      y += kRowH;
    }
    // capital : machines, niveau technologique, dette ; port des services aux entreprises
    final weak = f.maintCover < 0.7 || f.adminCover < 0.7;
    final cap = <String>[
      'M ${fmtNum(f.machines, 1)}',
      'T${f.techLevel}',
      if (f.debt > 0) 'D ${kmoney(f.debt)}',
    ].join(' · ');
    _row(canvas, r, y, pal.ink3, 'Capital', cap, rightColor: weak ? pal.warn : null);
    _port(canvas, b.inPort(kSvcPort), pal.ink3);
    final profit = f.profitEma;
    _footer(canvas, r, kmoney(f.money), '${profit >= 0 ? '+' : ''}${fmtNum(profit, 0)} \$/j',
        rightColor: profit >= 0 ? pal.ok : pal.bad);
    // pastille d'état, et triangle si une alerte concerne l'entreprise
    Color? st;
    if (f.workers.isEmpty) {
      st = pal.bad;
    } else if (f.inputLimited || f.vacancies > 0 && f.unfilledDays > 10) {
      st = pal.warn;
    }
    if (st != null) canvas.drawCircle(Offset(r.right - 12, r.top + 12), 4.5, Paint()..color = st);
    final suffix = ':${f.id}';
    if (sim.monitor.active.keys.any((k) => k.endsWith(suffix))) {
      final x = r.right - (st != null ? 30 : 16), top = r.top + 6;
      final tri = Path()
        ..moveTo(x, top)
        ..lineTo(x + 7, top + 12)
        ..lineTo(x - 7, top + 12)
        ..close();
      canvas.drawPath(tri, Paint()..color = pal.warn);
      final t = _tp('!', TextStyle(color: pal.node, fontSize: 9, fontWeight: FontWeight.w900));
      t.paint(canvas, Offset(x - t.width / 2, top + 2));
    }
  }

  void _homesNode(Canvas canvas, NodeBox b) {
    final r = b.rect;
    final n = sim.citizens.length;
    final unemployed = sim.citizens.where((c) => c.employer == null).length;
    var total = 0.0, happy = 0.0;
    for (final c in sim.citizens) {
      total += c.money;
      happy += c.happiness;
    }
    _header(canvas, r, pal.ink2, 'M', 'Ménages',
        '$n citoyens · ${pct(n > 0 ? unemployed / n : 0.0)} chôm. · bonheur ${pct(n > 0 ? happy / n : 0.0)}');
    var y = r.top + kHeaderH;
    for (final g in householdGoods) {
      final gd = goods[g]!;
      final un = sim.unmet[g] ?? 0.0;
      _row(canvas, r, y, pal.sector(gd.sector), gd.label, money(sim.bestPrice(g)), rightColor: un > 0.5 ? pal.bad : null);
      _port(canvas, b.inPort(g), pal.sector(gd.sector));
      y += kRowH;
    }
    _footer(canvas, r, kmoney(total), 'moy. ${kmoney(n > 0 ? total / n : 0.0)}');
  }

  void _stateNode(Canvas canvas, NodeBox b) {
    final r = b.rect;
    _header(canvas, r, pal.accent, 'É', 'État', 'impôt ${pct(sim.params.taxRate)} · aide ${money0(sim.params.benefit)}');
    _footer(canvas, r, kmoney(sim.state.money), 'perçu ${kmoney(sim.state.taxes)}');
  }

  void _bankNode(Canvas canvas, NodeBox b) {
    final r = b.rect;
    final loans = sim.totalDebt();
    final ratio = loans > 0 ? sim.bank.equity / loans : double.nan;
    _header(canvas, r, pal.money, 'C', 'Caisse populaire',
        'taux ${pct(sim.params.interestRate)} · ${sim.modules.credit ? 'prête' : 'crédit coupé'}');
    _footer(canvas, r, 'prêts ${kmoney(loans)}', ratio.isNaN ? 'fonds ${kmoney(sim.bank.equity)}' : 'ratio ${pct(ratio)}',
        rightColor: !ratio.isNaN && ratio < sim.safeguards.minCapitalRatio ? pal.bad : null);
  }

  void _worldNode(Canvas canvas, NodeBox b) {
    final r = b.rect;
    _header(canvas, r, pal.ink3, 'X', 'Extérieur', sim.params.trade ? 'frontières ouvertes' : 'frontières fermées');
    _footer(canvas, r, 'import ${kmoney(sim.ledgerImports)}', 'export ${kmoney(sim.ledgerExports)}');
  }
}
