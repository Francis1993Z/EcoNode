// Disposition des nodes : une colonne par secteur (le secondaire selon sa profondeur dans la chaîne),
// les nodes empilés selon leur hauteur. Les dimensions servent aussi au dessin (graph.dart).

import 'dart:math' as math;

import '../engine/model.dart';
import '../engine/sim.dart';

const double kNodeW = 222;
const double kHeaderH = 40;
const double kRowH = 20;
const double kSepH = 7;
const double kFooterH = 30;
const double kGapY = 26;
const double kColW = 300;
const double kSmallH = kHeaderH + kFooterH;

/// Hauteur d'un node d'entreprise : extrants, intrants, ligne capital et services, pied.
double firmHeight(Firm f) {
  var h = kHeaderH + f.outputs.length * kRowH;
  if (f.inputs.isNotEmpty) h += kSepH + f.inputs.length * kRowH;
  return h + kRowH + kFooterH;
}

double homesHeight() => kHeaderH + householdGoods.length * kRowH + kFooterH;

final Map<String, int> _depth = {};

/// Profondeur d'un type secondaire : 0 s'il ne transforme que des matières premières.
int _secDepth(String type) {
  final cached = _depth[type];
  if (cached != null) return cached;
  _depth[type] = 0; // garde contre les cycles
  var d = 0;
  for (final g in templates[type]!.inputs.keys) {
    final pt = producerOf[g];
    if (pt != null && templates[pt]!.sector == 'secondaire') d = math.max(d, _secDepth(pt) + 1);
  }
  return _depth[type] = d;
}

/// Colonne : primaire (0), secondaire (1 à 3), services aux entreprises (4), services aux ménages (5).
int columnOf(String type) {
  final t = templates[type]!;
  switch (t.sector) {
    case 'primaire':
      return 0;
    case 'secondaire':
      return 1 + math.min(2, _secDepth(type));
    default:
      return t.outputs.keys.any(businessServices.contains) ? 4 : 5;
  }
}

/// Range toutes les entreprises et les nodes spéciaux (État, ménages, Caisse, extérieur).
void autoLayout(Sim sim) {
  final cols = <int, List<Firm>>{};
  for (final f in sim.firms) {
    (cols[columnOf(f.type)] ??= []).add(f);
  }
  for (final e in cols.entries) {
    var y = 0.0;
    for (final f in e.value) {
      f.x = e.key * kColW;
      f.y = y;
      y += firmHeight(f) + kGapY;
    }
  }
  const x = 6 * kColW + 30;
  var y = 0.0;
  sim.nodePos['E'] = [x, y];
  y += kSmallH + kGapY;
  sim.nodePos['M'] = [x, y];
  y += homesHeight() + kGapY;
  sim.nodePos['B'] = [x, y];
  y += kSmallH + kGapY;
  sim.nodePos['X'] = [x, y];
}
