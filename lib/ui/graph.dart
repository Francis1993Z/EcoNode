// Graphe de la chaîne d'approvisionnement : nodes dessinés au canevas, déplaçables,
// avec panoramique (1 doigt sur le vide) et zoom (pincement ou molette).
//
// Le dessin des nodes et des flux est enregistré une fois par notification de la simulation (WorldCache) : le
// panoramique et le zoom ne font que le transformer. Trois niveaux de zoom : détail, nodes réduits à leur code et à
// leur nom, puis entreprises regroupées par colonne (secteur ou profondeur dans la chaîne). Des particules circulent
// sur les flux, entre le dessin des flux et celui des nodes.

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../engine/model.dart';
import '../engine/sim.dart';
import 'controller.dart';
import 'format.dart';
import 'layout.dart';
import 'palette.dart';

/// Port d'entrée des services aux entreprises et des machines (ligne « Capital »).
const String kSvcPort = '@svc';

/// En dessous de cette échelle, le texte des lignes est illisible : les nodes passent en vue simplifiée.
const double kMacroScale = 0.55;

/// En dessous de cette échelle, les entreprises se regroupent par colonne de la disposition.
const double kClusterScale = 0.3;

/// Largeur d'une tuile de groupe (zoom stratégique) ; sa hauteur suit la taille du texte.
const double kTileW = kNodeW + 56;
const double kTileH = 108;

/// Pas de l'échelle des vues réduites : la taille du texte (et le cache) ne change qu'à chaque pas.
double macroStepOf(double scale) => (scale * 20).round().clamp(1, 20) / 20;

/// Un flux dessiné : son tracé sert aussi aux particules.
class Track {
  final Path path;
  final Color color;
  final double width;
  final double rel; // valeur rapportée au plus gros flux de son type (biens ou argent)
  final bool faded;
  Track(this.path, this.color, this.width, this.rel, this.faded);

  ui.PathMetric? _metric;
  Rect? _bounds;
  ui.PathMetric? get metric {
    if (_metric == null) {
      final it = path.computeMetrics().iterator;
      if (it.moveNext()) _metric = it.current;
    }
    return _metric;
  }

  Rect get bounds => _bounds ??= path.getBounds().inflate(width);
}

/// Dessin du monde gardé tant que rien de ce qu'il montre n'a changé : le fond (flux), le premier plan (nodes) et
/// les tracés des particules.
class WorldCache {
  ui.Picture? back, front;
  List<Track> tracks = const [];
  Object? key;

  void set(ui.Picture b, ui.Picture f, List<Track> t, Object k) {
    dispose();
    back = b;
    front = f;
    tracks = t;
    key = k;
  }

  void dispose() {
    back?.dispose();
    front?.dispose();
    back = null;
    front = null;
    tracks = const [];
    key = null;
  }
}

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
  // banque centrale : sous la Caisse ; un instantané d'avant ce nœud n'a pas sa position, on la crée
  final bc = sim.nodePos['BC'] ??= [sim.nodePos['B']![0], sim.nodePos['B']![1] + kSmallH + kGapY];
  out.add(NodeBox(const Selection('BC'), Rect.fromLTWH(bc[0], bc[1], kNodeW, kSmallH), {}, {}));
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

// ---------------------------------------------------------------- zoom stratégique

const List<String> kClusterLabels = [
  'Extraction',
  'Industrie de base',
  'Industrie avancée',
  'Haute technologie',
  'Services aux entreprises',
  'Services aux ménages',
];

/// Entreprises d'une même colonne de la disposition, réunies en une tuile au zoom stratégique. Les tuiles sont
/// alignées à mi-hauteur de l'ensemble, chacune au-dessus de sa colonne ; ouvrir une tuile zoome sur ses membres.
class ClusterBox {
  final int col;
  final Rect members; // boîte englobant les entreprises du groupe
  final Rect tile;
  final List<Firm> firms;
  ClusterBox(this.col, this.members, this.tile, this.firms);
  String get key => 'c$col';
  String get sector => col == 0 ? 'primaire' : (col <= 3 ? 'secondaire' : 'tertiaire');
}

List<ClusterBox> allClusters(Sim sim, double scale) {
  final by = <int, List<Firm>>{};
  for (final f in sim.firms) {
    (by[columnOf(f.type)] ??= []).add(f);
  }
  if (by.isEmpty) return [];
  final cols = by.keys.toList()..sort();
  final members = {for (final c in cols) c: by[c]!.map((f) => firmBox(f).rect).reduce((a, b) => a.expandToInclude(b))};
  final all = members.values.reduce((a, b) => a.expandToInclude(b));
  final h = kTileH / macroStepOf(scale);
  return [
    for (final c in cols)
      ClusterBox(c, members[c]!,
          Rect.fromCenter(center: Offset(members[c]!.center.dx, all.center.dy), width: kTileW, height: h), by[c]!),
  ];
}

/// Colonne d'un node : celle de son type pour une entreprise, 6 pour les nodes spéciaux (État, ménages…).
int colOfKey(Sim sim, String key) {
  final id = int.tryParse(key);
  if (id == null) return 6;
  final f = sim.firm(id);
  return f == null ? 6 : columnOf(f.type);
}

class GraphView extends StatefulWidget {
  final SimController ctrl;
  const GraphView({super.key, required this.ctrl});

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> with SingleTickerProviderStateMixin {
  double scale = 0.5;
  Offset offset = const Offset(20, 20);
  bool _fitted = false;
  Size _size = Size.zero;
  Sim? _fittedSim;

  // état du geste en cours
  NodeBox? _dragBox;
  final WorldCache _cache = WorldCache();
  final ValueNotifier<double> _clock = ValueNotifier(0); // temps des particules (s)
  late final Ticker _ticker;
  Duration _lastTick = Duration.zero;
  Offset _startFocal = Offset.zero;
  Offset _startOffset = Offset.zero;
  double _startScale = 1;
  bool _moved = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  /// Les particules avancent avec la partie : arrêtées en pause, plus vives quand elle accélère.
  void _onTick(Duration elapsed) {
    final dt = _lastTick == Duration.zero ? 0.0 : (elapsed - _lastTick).inMicroseconds / 1e6;
    _lastTick = elapsed;
    final c = widget.ctrl;
    if (!c.playing || !c.showParticles) return;
    _clock.value += math.min(dt, 0.1) * math.sqrt(c.speed / 4).clamp(0.5, 2.5);
  }

  @override
  void dispose() {
    _ticker.dispose();
    _clock.dispose();
    _cache.dispose();
    super.dispose();
  }

  Offset toWorld(Offset p) => (p - offset) / scale;

  NodeBox? hit(Offset screen) {
    final w = toWorld(screen);
    final sim = widget.ctrl.sim;
    final boxes = allBoxes(sim);
    if (scale < kClusterScale) {
      for (final c in allClusters(sim, scale)) {
        if (c.tile.contains(w)) return NodeBox(Selection('cluster', c.col), c.members, const {}, const {});
      }
      boxes.removeWhere((b) => b.sel.kind == 'firm');
    }
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

  /// Ouvre un groupe : zoom jusqu'à la vue des nodes, centré sur lui.
  void explode(Rect r) {
    final s = math.max(kMacroScale + 0.05, math.min(_size.width / r.width, _size.height / r.height) * 0.9);
    setState(() {
      scale = s.clamp(0.15, 2.5).toDouble();
      offset = Offset(_size.width / 2, _size.height / 2) - r.center * scale;
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
      if (b.sel.kind == 'cluster') {
        for (final f in sim.firms) {
          if (columnOf(f.type) == b.sel.id) {
            f.x += delta.dx;
            f.y += delta.dy;
          }
        }
      } else if (b.sel.kind == 'firm') {
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
      if (b != null && b.sel.kind == 'cluster') {
        explode(b.rect);
      } else if (b != null) {
        widget.ctrl.select(b.sel);
      }
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
                  builder: (context, _) {
                    final ctrl = widget.ctrl;
                    GraphPainter painter(GraphPart part) => GraphPainter(
                          sim: ctrl.sim,
                          selection: ctrl.selection,
                          showMoney: ctrl.showMoneyFlows,
                          showServices: ctrl.showServices,
                          pal: pal,
                          scale: scale,
                          offset: offset,
                          stamp: ctrl.rev,
                          layer: ctrl.layer,
                          cache: _cache,
                          part: part,
                          bundle: ctrl.bundleEdges,
                          particles: ctrl.showParticles,
                        );
                    // fond (flux), particules dans leur propre calque (seul redessiné à chaque image), puis nodes
                    return CustomPaint(
                      painter: painter(GraphPart.back),
                      foregroundPainter: painter(GraphPart.front),
                      child: RepaintBoundary(
                        child: CustomPaint(
                          size: Size.infinite,
                          painter: ParticlePainter(
                              cache: _cache, scale: scale, offset: offset, clock: _clock, on: ctrl.showParticles),
                        ),
                      ),
                    );
                  },
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
              const SizedBox(width: 6),
              _MiniBtn(
                icon: Icons.animation,
                tooltip: 'Particules sur les flux',
                active: widget.ctrl.showParticles,
                onTap: widget.ctrl.toggleParticles,
              ),
              const SizedBox(width: 6),
              _MiniBtn(
                icon: Icons.call_merge,
                tooltip: 'Regrouper les flux en troncs',
                active: widget.ctrl.bundleEdges,
                onTap: widget.ctrl.toggleBundle,
              ),
              const SizedBox(width: 6),
              _LayerBtn(ctrl: widget.ctrl),
              if (widget.ctrl.layer != null) ...[
                const SizedBox(width: 6),
                _LayerChip(ctrl: widget.ctrl),
              ],
            ]),
          ),
        ),
      ]);
    });
  }
}

String layerLabel(String l) => l == kMoneyLayer ? 'Argent' : goods[l]?.label ?? l;

/// Choix du calque : un bien ou l'argent ; les autres flux s'estompent.
class _LayerBtn extends StatelessWidget {
  final SimController ctrl;
  const _LayerBtn({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    // les biens qui circulent en ce moment, dans l'ordre du catalogue
    final live = {for (final e in ctrl.sim.flowsEma.values) if (!e.isMoney && e.value >= 0.5) e.good};
    final items = [for (final g in goods.keys) if (live.contains(g)) g];
    Widget item(String value, Color c, String label) => Row(children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(fontSize: 13, fontWeight: ctrl.layer == value ? FontWeight.w700 : FontWeight.w400)),
        ]);
    return PopupMenuButton<String>(
      tooltip: 'Calque : isoler un bien',
      position: PopupMenuPosition.over,
      onSelected: ctrl.setLayer,
      itemBuilder: (context) => [
        PopupMenuItem(value: kMoneyLayer, height: 36, child: item(kMoneyLayer, pal.money, 'Argent')),
        const PopupMenuDivider(),
        for (final g in items)
          PopupMenuItem(value: g, height: 34, child: item(g, pal.sector(goods[g]!.sector), goods[g]!.label)),
      ],
      child: IgnorePointer(
        child: _MiniBtn(icon: Icons.layers_outlined, active: ctrl.layer != null, onTap: () {}),
      ),
    );
  }
}

/// Calque en cours ; un appui revient à tous les flux.
class _LayerChip extends StatelessWidget {
  final SimController ctrl;
  const _LayerChip({required this.ctrl});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final l = ctrl.layer!;
    final c = l == kMoneyLayer ? pal.money : pal.sector(goods[l]?.sector ?? 'tertiaire');
    return Material(
      color: pal.sheet,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: c)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => ctrl.setLayer(null),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
          child: SizedBox(
            height: 38,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text(layerLabel(l), style: TextStyle(color: pal.ink, fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(width: 4),
              Icon(Icons.close, size: 16, color: pal.ink3),
            ]),
          ),
        ),
      ),
    );
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

enum GraphPart { back, front }

/// Géométrie d'un flux, avant dessin (le regroupement des arêtes peut remplacer son tracé).
class _Geo {
  final FlowEdge e;
  final Offset p0, p1;
  final Color color;
  final double w, rel;
  final bool hot, faded, service;
  Path? path;
  _Geo(this.e, this.p0, this.p1, this.color, this.w, this.rel, this.hot, this.faded, this.service);
}

class GraphPainter extends CustomPainter {
  final Sim sim;
  final Selection selection;
  final bool showMoney;
  final bool showServices;
  final Pal pal;
  final double scale;
  final Offset offset;
  final int stamp; // révision du contrôleur : change à chaque notification
  final String? layer;
  final WorldCache? cache;
  final GraphPart part; // fond (grille et flux) ou premier plan (nodes) ; les particules passent entre les deux
  final bool bundle;
  final bool particles;

  GraphPainter({
    required this.sim,
    required this.selection,
    required this.showMoney,
    required this.showServices,
    required this.pal,
    required this.scale,
    required this.offset,
    required this.stamp,
    this.layer,
    this.cache,
    this.part = GraphPart.back,
    this.bundle = false,
    this.particles = false,
  });

  @override
  bool shouldRepaint(covariant GraphPainter old) => true; // l'état de sim est mutable ; le dessin du monde est en cache

  bool get _macro => scale < kMacroScale;
  bool get _cluster => scale < kClusterScale;

  /// Échelle arrondie de la vue simplifiée : la taille du texte en dépend, le cache aussi.
  double get _macroStep => macroStepOf(scale);

  TextPainter _tp(String text, TextStyle style, {double? maxWidth, TextAlign align = TextAlign.left, int maxLines = 1}) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: ui.TextDirection.ltr,
      maxLines: maxLines,
      ellipsis: '…',
      textAlign: align,
    );
    tp.layout(maxWidth: maxWidth ?? double.infinity);
    return tp;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (part == GraphPart.back) {
      canvas.drawRect(Offset.zero & size, Paint()..color = pal.paper);
      _grid(canvas, size);
    }
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(scale);
    final c = cache;
    if (c == null) {
      // dessin direct, sans cache (mesures)
      if (part == GraphPart.back) {
        _cluster ? _clusterEdges(canvas, []) : _edges(canvas, []);
      } else {
        _cluster ? _clusterNodes(canvas) : _nodes(canvas);
      }
    } else {
      _ensure(c);
      canvas.drawPicture(part == GraphPart.back ? c.back! : c.front!);
    }
    canvas.restore();
  }

  /// Enregistre les deux dessins du monde et les tracés des particules, si ce qu'ils montrent a changé.
  void _ensure(WorldCache c) {
    final lod = _cluster ? -_macroStep : (_macro ? _macroStep : 0.0);
    final key = (stamp, pal, lod, showMoney, showServices, selection, layer, bundle, particles);
    if (c.back != null && c.key == key) return;
    final rb = ui.PictureRecorder(), rf = ui.PictureRecorder();
    final tracks = <Track>[];
    final cb = Canvas(rb), cf = Canvas(rf);
    if (_cluster) {
      _clusterEdges(cb, tracks);
      _clusterNodes(cf);
    } else {
      _edges(cb, tracks);
      _nodes(cf);
    }
    c.set(rb.endRecording(), rf.endRecording(), tracks, key);
  }

  void _fade(Canvas canvas, Rect r) {
    // hors du calque : le node s'estompe (20 % d'opacité)
    canvas.drawRRect(RRect.fromRectAndRadius(r.inflate(1), const Radius.circular(10)),
        Paint()..color = pal.paper.withValues(alpha: 0.8));
  }

  void _nodes(Canvas canvas) {
    final focus = _involved();
    for (final b in allBoxes(sim)) {
      _node(canvas, b);
      if (focus != null && !focus.contains(keyOf(b.sel))) _fade(canvas, b.rect);
    }
  }

  bool _inLayer(FlowEdge e) => layer == kMoneyLayer ? e.isMoney : !e.isMoney && e.good == layer;

  /// Nodes concernés par le calque : extrémités de ses flux, et entreprises qui produisent ou utilisent le bien.
  Set<String>? _involved() {
    final l = layer;
    if (l == null) return null;
    final out = <String>{};
    for (final e in sim.flowsEma.values) {
      if (e.value >= 0.5 && _inLayer(e)) {
        out
          ..add(e.from)
          ..add(e.to);
      }
    }
    if (l != kMoneyLayer) {
      for (final f in sim.firms) {
        if (f.outputs.containsKey(l) || f.inputs.containsKey(l)) out.add(f.id.toString());
      }
    }
    return out;
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

  /// Épaisseur proportionnelle à la valeur du flux ($/j lissés), comme un diagramme de Sankey.
  static double sankey(double value, double ref) => (1.0 + 11.0 * value / ref).clamp(1.0, 12.0).toDouble();

  void _edges(Canvas canvas, List<Track> tracks) {
    final boxes = allBoxes(sim);
    final byKey = <String, NodeBox>{for (final b in boxes) keyOf(b.sel): b};
    final list = <FlowEdge>[];
    var maxGood = 1.0, maxMoney = 1.0;
    for (final e in sim.flowsEma.values) {
      if (e.value < 0.5) continue; // flux insignifiant : pas dessiné
      final inLayer = layer != null && _inLayer(e);
      if (e.isMoney) {
        if (!showMoney && !inLayer) continue;
        maxMoney = math.max(maxMoney, e.value);
      } else {
        if (!showServices && _isService(e) && !_hot(e) && !inLayer) continue;
        maxGood = math.max(maxGood, e.value);
      }
      list.add(e);
    }
    // le calque par-dessus les flux estompés
    if (layer != null) list.sort((a, b) => (_inLayer(a) ? 1 : 0) - (_inLayer(b) ? 1 : 0));
    final geo = <_Geo>[];
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
      final inLayer = layer != null && _inLayer(e);
      final service = _isService(e);
      final hot = _hot(e) || inLayer;
      final ref = e.isMoney ? maxMoney : maxGood;
      var w = sankey(e.value, ref);
      if (service && !hot) w = math.min(w, 2.0);
      if (_macro) w *= math.max(1.0, 0.5 / _macroStep); // reste lisible quand on dézoome
      geo.add(_Geo(e, p0, p1, col, w, e.value / ref, hot, layer != null && !inLayer, service));
    }
    if (bundle) _bundle(geo, boxes);
    for (final g in geo) {
      final dx = math.max(40.0, (g.p1.dx - g.p0.dx).abs() * 0.5);
      final path = g.path ??
          (Path()
            ..moveTo(g.p0.dx, g.p0.dy)
            ..cubicTo(g.p0.dx + dx, g.p0.dy, g.p1.dx - dx, g.p1.dy, g.p1.dx, g.p1.dy));
      final alpha = (g.hot ? 0.95 : (g.service ? 0.3 : 0.55)) * (g.faded ? 0.2 : 1.0);
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = g.w
        ..strokeCap = g.path != null ? StrokeCap.butt : StrokeCap.round
        ..color = g.color.withValues(alpha: alpha);
      if (g.e.isMoney) {
        _dashed(canvas, path, paint, 7, 5);
      } else if (g.service) {
        _dashed(canvas, path, paint, 3, 4);
      } else {
        canvas.drawPath(path, paint);
      }
      // les particules disent le sens du flux ; sans elles, une flèche
      if (!particles) _arrow(canvas, g.p1, g.color.withValues(alpha: (g.hot ? 0.95 : 0.7) * (g.faded ? 0.2 : 1.0)), g.w);
      tracks.add(Track(path, g.color, g.w, g.rel, g.faded));
    }
  }

  /// Regroupement des arêtes : les flux de biens qui vont d'une colonne à une autre plus à droite, à au moins une
  /// colonne d'écart, partagent un tronc. Ils y sont empilés côte à côte (la largeur du tronc est la somme de leurs
  /// largeurs) et ne s'en séparent qu'à l'approche de leurs nodes, dans l'allée qui précède la colonne d'arrivée.
  void _bundle(List<_Geo> geo, List<NodeBox> boxes) {
    final colRect = <int, Rect>{};
    for (final b in boxes) {
      final c = colOfKey(sim, keyOf(b.sel));
      colRect[c] = colRect[c]?.expandToInclude(b.rect) ?? b.rect;
    }
    final groups = <(int, int), List<_Geo>>{};
    for (final g in geo) {
      if (g.e.isMoney || g.e.from == 'X' || g.e.to == 'X') continue;
      final a = colOfKey(sim, g.e.from), b = colOfKey(sim, g.e.to);
      if (b - a < 2) continue;
      (groups[(a, b)] ??= []).add(g);
    }
    // un tronc par paire de colonnes ; les troncs sont écartés verticalement pour ne pas se recouvrir
    final trunks = <(double, double, List<_Geo>, double, double)>[]; // centre, largeur, flux, début, fin
    for (final en in groups.entries) {
      final list = en.value;
      if (list.length < 2) continue;
      final sx = colRect[en.key.$1]!.right + (kColW - kNodeW) / 2;
      final tx = colRect[en.key.$2]!.left - (kColW - kNodeW) / 2;
      if (tx - sx < 60) continue;
      var total = 0.0, cy = 0.0;
      for (final g in list) {
        total += g.w;
        cy += (g.p0.dy + g.p1.dy) / 2 * g.w;
      }
      trunks.add((cy / total, total, list, sx, tx));
    }
    trunks.sort((a, b) => a.$1.compareTo(b.$1));
    var floor = -double.infinity;
    for (var i = 0; i < trunks.length; i++) {
      final t = trunks[i];
      final top = math.max(t.$1 - t.$2 / 2, floor);
      floor = top + t.$2 + 8;
      final list = t.$3..sort((p, q) => (p.p0.dy + p.p1.dy).compareTo(q.p0.dy + q.p1.dy));
      var y = top;
      for (final g in list) {
        final yi = y + g.w / 2;
        y += g.w;
        final d0 = math.max(20.0, (t.$4 - g.p0.dx) * 0.6), d1 = math.max(20.0, (g.p1.dx - t.$5) * 0.6);
        g.path = Path()
          ..moveTo(g.p0.dx, g.p0.dy)
          ..cubicTo(g.p0.dx + d0, g.p0.dy, t.$4 - d0, yi, t.$4, yi)
          ..lineTo(t.$5, yi)
          ..cubicTo(t.$5 + d1, yi, g.p1.dx - d1, g.p1.dy, g.p1.dx, g.p1.dy);
      }
    }
  }

  void _arrow(Canvas canvas, Offset tip, Color c, double w) {
    final half = math.max(4.0, w * 0.75), len = math.max(8.0, w * 1.3);
    final p = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(tip.dx - len, tip.dy - half)
      ..lineTo(tip.dx - len, tip.dy + half)
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

  // ---- zoom stratégique : groupes d'entreprises

  /// Groupe d'un node : la colonne d'une entreprise, ou le node spécial lui-même.
  String _group(String key) {
    final id = int.tryParse(key);
    if (id == null) return key;
    final f = sim.firm(id);
    return f == null ? key : 'c${columnOf(f.type)}';
  }

  /// Flux additionnés entre groupes (et nodes spéciaux), dessinés en arcs : vers la droite sous les tuiles, vers la
  /// gauche au-dessus ; les nodes spéciaux (colonne de droite) sont reliés par leur côté gauche. À chaque extrémité,
  /// les flux sont empilés comme dans un diagramme de Sankey, l'épaisseur restant constante à l'écran.
  void _clusterEdges(Canvas canvas, List<Track> tracks) {
    final k = 1 / _macroStep;
    final rectOf = <String, Rect>{};
    final colOf = <String, int>{};
    for (final c in allClusters(sim, scale)) {
      rectOf[c.key] = c.tile;
      colOf[c.key] = c.col;
    }
    for (final b in allBoxes(sim)) {
      if (b.sel.kind != 'firm') {
        rectOf[keyOf(b.sel)] = b.rect;
        colOf[keyOf(b.sel)] = 6;
      }
    }
    final agg = <(String, String, bool), Map<String, double>>{}; // de, vers, argent → valeur par bien
    final inL = <(String, String, bool), double>{};
    for (final e in sim.flowsEma.values) {
      if (e.value < 0.5) continue;
      final inLayer = layer != null && _inLayer(e);
      if (e.isMoney && !showMoney && !inLayer) continue;
      if (!e.isMoney && !showServices && _isService(e) && !inLayer) continue;
      final a = _group(e.from), b = _group(e.to);
      if (a == b || !rectOf.containsKey(a) || !rectOf.containsKey(b)) continue;
      final key = (a, b, e.isMoney);
      final m = agg[key] ??= {};
      m[e.good] = (m[e.good] ?? 0) + e.value;
      if (inLayer) inL[key] = (inL[key] ?? 0) + e.value;
    }
    var maxGood = 1.0, maxMoney = 1.0;
    final total = <(String, String, bool), double>{};
    for (final en in agg.entries) {
      final v = en.value.values.fold(0.0, (s, x) => s + x);
      total[en.key] = v;
      if (en.key.$3) {
        maxMoney = math.max(maxMoney, v);
      } else {
        maxGood = math.max(maxGood, v);
      }
    }
    double width((String, String, bool) key) => sankey(total[key]!, key.$3 ? maxMoney : maxGood) * k;
    // côté d'accroche : 'b' dessous, 't' dessus, 'l' gauche (nodes spéciaux)
    String side(String node, String other) {
      if (colOf[node] == 6) return 'l';
      return rectOf[node]!.center.dx < rectOf[other]!.center.dx ? 'b' : 't';
    }

    final keys = agg.keys.toList();
    if (layer != null) keys.sort((p, q) => (inL.containsKey(p) ? 1 : 0) - (inL.containsKey(q) ? 1 : 0));
    final sides = <(String, String), List<(String, String, bool)>>{};
    for (final key in keys) {
      (sides[(key.$1, side(key.$1, key.$2))] ??= []).add(key);
      (sides[(key.$2, side(key.$2, key.$1))] ??= []).add(key);
    }
    final ends = <((String, String, bool), String), (Offset, Offset)>{}; // point, normale sortante
    for (final en in sides.entries) {
      final node = en.key.$1, sd = en.key.$2;
      final r = rectOf[node]!;
      Offset otherOf((String, String, bool) key) => rectOf[key.$1 == node ? key.$2 : key.$1]!.center;
      final list = en.value
        ..sort((p, q) => sd == 'l' ? otherOf(p).dy.compareTo(otherOf(q).dy) : otherOf(p).dx.compareTo(otherOf(q).dx));
      final sum = list.fold(0.0, (acc, key) => acc + width(key));
      var at = (sd == 'l' ? r.center.dy : r.center.dx) - sum / 2;
      for (final key in list) {
        final w = width(key);
        final c = at + w / 2;
        at += w;
        ends[(key, node)] = switch (sd) {
          'l' => (Offset(r.left, c), const Offset(-1, 0)),
          'b' => (Offset(c, r.bottom), const Offset(0, 1)),
          _ => (Offset(c, r.top), const Offset(0, -1)),
        };
      }
    }
    for (final key in keys) {
      final (p0, n0) = ends[(key, key.$1)]!;
      final (p1, n1) = ends[(key, key.$2)]!;
      final byGood = agg[key]!;
      final main = byGood.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
      final col = key.$3 ? pal.money : pal.sector(goods[main]?.sector ?? 'tertiaire');
      final faded = layer != null && !inL.containsKey(key);
      final w = width(key);
      final span = ((colOf[key.$1]! - colOf[key.$2]!).abs()).clamp(1, 6);
      final h = (16 + 14 * span) * k;
      final c0 = p0 + n0 * h, c1 = p1 + n1 * h;
      final path = Path()
        ..moveTo(p0.dx, p0.dy)
        ..cubicTo(c0.dx, c0.dy, c1.dx, c1.dy, p1.dx, p1.dy);
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = w
        ..color = col.withValues(alpha: (faded ? 0.2 : 1.0) * (layer != null && !faded ? 0.95 : 0.6));
      if (key.$3) {
        _dashed(canvas, path, paint, 7 * k, 5 * k);
      } else {
        canvas.drawPath(path, paint);
      }
      tracks.add(Track(path, col, w, total[key]! / (key.$3 ? maxMoney : maxGood), faded));
    }
  }

  void _clusterNodes(Canvas canvas) {
    final focus = _involved();
    for (final c in allClusters(sim, scale)) {
      _clusterNode(canvas, c);
      if (focus != null && !c.firms.any((f) => focus.contains(f.id.toString()))) _fade(canvas, c.tile);
    }
    for (final b in allBoxes(sim)) {
      if (b.sel.kind == 'firm') continue;
      _node(canvas, b);
      if (focus != null && !focus.contains(keyOf(b.sel))) _fade(canvas, b.rect);
    }
  }

  /// Un groupe : son nom, le nombre d'entreprises et d'emplois, le profit total, les entreprises à l'arrêt et les
  /// alertes de ses membres.
  void _clusterNode(Canvas canvas, ClusterBox c) {
    final r = c.tile;
    final k = 1 / _macroStep;
    final kk = k.clamp(1.0, 4.0).toDouble();
    final accent = pal.sector(c.sector);
    final rr = RRect.fromRectAndRadius(r, Radius.circular(8 * kk));
    final selected = selection.kind == 'firm' && c.firms.any((f) => f.id == selection.id);
    canvas.drawRRect(rr, Paint()..color = pal.node);
    canvas.drawRRect(rr, Paint()..color = accent.withValues(alpha: 0.10));
    canvas.drawRRect(
        rr,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = (selected ? 2.5 : 1.2) * kk
          ..color = selected ? pal.accent : accent.withValues(alpha: 0.6));
    var workers = 0, idle = 0, alerts = 0;
    var profit = 0.0;
    for (final f in c.firms) {
      workers += f.workers.length;
      if (f.workers.isEmpty) idle++;
      profit += f.profitEma;
      final suffix = ':${f.id}';
      if (sim.monitor.active.keys.any((x) => x.endsWith(suffix))) alerts++;
    }
    final x = r.left + 8 * kk, maxW = r.width - 16 * kk;
    var y = r.top + 8 * kk;
    void line(String t, TextStyle s, {int lines = 1}) {
      final tp = _tp(t, s, maxWidth: maxW, maxLines: lines);
      if (y + tp.height > r.bottom - 4 * kk) return;
      tp.paint(canvas, Offset(x, y));
      y += tp.height + 2 * kk;
    }

    line(kClusterLabels[c.col], TextStyle(color: accent, fontSize: 9 * k, fontWeight: FontWeight.w800, height: 1.1),
        lines: 2);
    line('${c.firms.length} entr.', mono(pal.ink, 9 * k, weight: FontWeight.w700));
    line('$workers empl.', mono(pal.ink2, 9 * k));
    line('${profit >= 0 ? '+' : ''}${fmtNum(profit, 0)} \$/j', mono(profit >= 0 ? pal.ok : pal.bad, 9 * k));
    if (idle > 0) line('$idle à l\'arrêt', mono(pal.bad, 9 * k, weight: FontWeight.w700));
    if (alerts > 0) line('▲ $alerts', mono(pal.warn, 9 * k, weight: FontWeight.w800));
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

    if (_macro) {
      _macroNode(canvas, b);
      return;
    }
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
      case 'BC':
        _centralBankNode(canvas, b);
        break;
      default:
        _worldNode(canvas, b);
    }
  }

  /// Vue dézoomée : le code et le nom en gros, la pastille d'état et l'alerte ; pas de lignes.
  void _macroNode(Canvas canvas, NodeBox b) {
    final r = b.rect;
    final k = 1 / _macroStep; // ramène le texte à une taille lisible à l'écran
    final kk = k.clamp(1.0, 3.0).toDouble();
    Color accent;
    String code, title;
    Color? st;
    var alert = false;
    switch (b.sel.kind) {
      case 'firm':
        final f = sim.firm(b.sel.id!);
        if (f == null) return;
        accent = pal.sector(f.template.sector);
        code = f.template.code;
        title = f.name;
        if (f.workers.isEmpty) {
          st = pal.bad;
        } else if (f.inputLimited || f.vacancies > 0 && f.unfilledDays > 10) {
          st = pal.warn;
        }
        final suffix = ':${f.id}';
        alert = sim.monitor.active.keys.any((x) => x.endsWith(suffix));
        break;
      case 'M':
        (accent, code, title) = (pal.ink2, 'M', 'Ménages');
        break;
      case 'E':
        (accent, code, title) = (pal.accent, 'É', 'État');
        break;
      case 'B':
        (accent, code, title) = (pal.money, 'C', 'Caisse');
        break;
      case 'BC':
        (accent, code, title) = (pal.money, 'BC', 'Banque centrale');
        break;
      default:
        (accent, code, title) = (pal.ink3, 'X', 'Extérieur');
    }
    canvas.drawRRect(RRect.fromRectAndRadius(r.deflate(1), const Radius.circular(10)),
        Paint()..color = accent.withValues(alpha: 0.08));
    canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromLTWH(r.left, r.top, 6 * kk, r.height),
            topLeft: const Radius.circular(10), bottomLeft: const Radius.circular(10)),
        Paint()..color = accent);
    final x = r.left + 6 * kk + 8 * kk;
    final c = _tp(code, mono(accent, 13 * k, weight: FontWeight.w800), maxWidth: r.right - x - 4);
    final t = _tp(title, TextStyle(color: pal.ink, fontSize: 10 * k, fontWeight: FontWeight.w700),
        maxWidth: r.right - x - 4);
    final both = r.height > c.height + t.height + 8;
    var y = r.top + (r.height - c.height - (both ? t.height : 0)) / 2;
    c.paint(canvas, Offset(x, y));
    y += c.height;
    if (both) t.paint(canvas, Offset(x, y));
    final dot = 5 * kk;
    if (st != null) canvas.drawCircle(Offset(r.right - dot - 6, r.top + dot + 6), dot, Paint()..color = st);
    if (alert) {
      final ax = r.right - (st != null ? 3 * dot + 12 : dot * 1.4 + 6), top = r.top + 6;
      final tri = Path()
        ..moveTo(ax, top)
        ..lineTo(ax + dot * 1.4, top + dot * 2.4)
        ..lineTo(ax - dot * 1.4, top + dot * 2.4)
        ..close();
      canvas.drawPath(tri, Paint()..color = pal.warn);
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
    final variety = sim.modules.products ? sim.productOf(f) : null;
    for (final g in f.outputs.keys) {
      final gd = goods[g]!;
      // module products : le nom de la variété à la place de celui de la catégorie
      final label = variety != null && variety.category == g ? '« ${variety.name} »' : gd.label;
      _row(canvas, r, y, pal.sector(gd.sector), label, '${qty(f.inv[g] ?? 0.0)} · ${money(f.price[g] ?? 0.0)}');
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
        'taux ${pct(sim.baseRate())} · ${sim.modules.credit ? 'prête' : 'crédit coupé'}');
    _footer(canvas, r, 'prêts ${kmoney(loans)}', ratio.isNaN ? 'fonds ${kmoney(sim.bank.equity)}' : 'ratio ${pct(ratio)}',
        rightColor: !ratio.isNaN && ratio < sim.safeguards.minCapitalRatio ? pal.bad : null);
  }

  void _centralBankNode(Canvas canvas, NodeBox b) {
    final r = b.rect;
    final p = sim.params;
    _header(canvas, r, pal.money, 'BC', 'Banque centrale',
        'taux directeur ${pct(p.policyRate)}${p.policyPassThrough ? '' : ' · non transmis'}');
    _footer(canvas, r, 'prêts à ${pct(sim.baseRate())}', p.policyPassThrough ? 'transmis aux banques' : 'taux fixe',
        rightColor: p.policyPassThrough ? null : pal.ink3);
  }

  void _worldNode(Canvas canvas, NodeBox b) {
    final r = b.rect;
    _header(canvas, r, pal.ink3, 'X', 'Extérieur', sim.params.trade ? 'frontières ouvertes' : 'frontières fermées');
    _footer(canvas, r, 'import ${kmoney(sim.ledgerImports)}', 'export ${kmoney(sim.ledgerExports)}');
  }
}

/// Particules sur les flux : leur vitesse suit la valeur du flux, leur pas et leur taille restent lisibles à toute
/// échelle. Seuls les flux visibles à l'écran sont parcourus.
class ParticlePainter extends CustomPainter {
  final WorldCache cache;
  final double scale;
  final Offset offset;
  final ValueListenable<double> clock;
  final bool on;
  ParticlePainter({required this.cache, required this.scale, required this.offset, required this.clock, required this.on})
      : super(repaint: clock);

  @override
  bool shouldRepaint(covariant ParticlePainter old) => true;

  @override
  void paint(Canvas canvas, Size size) {
    if (!on || cache.tracks.isEmpty) return;
    final view = Rect.fromLTWH(-offset.dx / scale, -offset.dy / scale, size.width / scale, size.height / scale);
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(scale);
    final t = clock.value;
    final spacing = math.max(40.0, 26 / scale);
    final paint = Paint()..strokeCap = StrokeCap.round;
    for (final tr in cache.tracks) {
      if (tr.faded || !tr.bounds.overlaps(view)) continue;
      final m = tr.metric;
      if (m == null || m.length < 1) continue;
      final speed = (18 + 90 * tr.rel) * math.max(1.0, 0.5 / scale);
      final pts = <Offset>[];
      for (var d = (t * speed) % spacing; d < m.length; d += spacing) {
        final p = m.getTangentForOffset(d);
        if (p != null) pts.add(p.position);
      }
      paint
        ..strokeWidth = math.max(tr.width + 2.5, 4 / scale)
        ..color = tr.color.withValues(alpha: 0.9);
      canvas.drawPoints(ui.PointMode.points, pts, paint);
    }
    canvas.restore();
  }
}
