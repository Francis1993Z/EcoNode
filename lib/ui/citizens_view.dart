// Explorateur de citoyens : chaque citoyen est un rond (en emploi) ou un carré (sans emploi), coloré selon un indicateur
// choisi ; un clic ouvre sa fiche dans l'inspecteur. Remplace le graphe quand la vue « Citoyens » est choisie.

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../engine/model.dart';
import '../engine/sim.dart';
import 'controller.dart';
import 'format.dart';
import 'palette.dart';

/// Ce qui colore les citoyens.
enum CitizenColor { bonheur, argent, sante, qualification, secteur, detresse }

/// L'ordre des citoyens dans la grille.
enum CitizenSort { identifiant, argent, bonheur, employeur, qualification }

const Map<CitizenColor, String> _colorLabels = {
  CitizenColor.bonheur: 'Bonheur',
  CitizenColor.argent: 'Argent',
  CitizenColor.sante: 'Santé',
  CitizenColor.qualification: 'Qualification',
  CitizenColor.secteur: 'Secteur de l’emploi',
  CitizenColor.detresse: 'Faim et logement',
};

const Map<CitizenSort, String> _sortLabels = {
  CitizenSort.identifiant: 'Arrivée',
  CitizenSort.argent: 'Argent',
  CitizenSort.bonheur: 'Bonheur',
  CitizenSort.employeur: 'Employeur',
  CitizenSort.qualification: 'Qualification',
};

class CitizenExplorer extends StatefulWidget {
  final SimController ctrl;
  const CitizenExplorer(this.ctrl, {super.key});
  @override
  State<CitizenExplorer> createState() => _CitizenExplorerState();
}

class _CitizenExplorerState extends State<CitizenExplorer> {
  CitizenColor colorBy = CitizenColor.bonheur;
  CitizenSort sortBy = CitizenSort.identifiant;
  int? hovered; // identifiant du citoyen sous la souris

  SimController get ctrl => widget.ctrl;

  List<Citizen> _ordered(Sim sim) {
    final l = List<Citizen>.of(sim.citizens);
    switch (sortBy) {
      case CitizenSort.identifiant:
        break;
      case CitizenSort.argent:
        l.sort((a, b) => b.money.compareTo(a.money));
      case CitizenSort.bonheur:
        l.sort((a, b) => b.happiness.compareTo(a.happiness));
      case CitizenSort.employeur:
        l.sort((a, b) => (a.employer ?? 1000000000).compareTo(b.employer ?? 1000000000)); // sans emploi à la fin (pas de décalage de bits : sur le web il est pris modulo 32)
      case CitizenSort.qualification:
        l.sort((a, b) => b.skill.compareTo(a.skill));
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return AnimatedBuilder(
      animation: ctrl,
      builder: (context, _) {
        final sim = ctrl.sim;
        final list = _ordered(sim);
        final employed = list.where((c) => c.employer != null).length;
        final colors = _CitizenColors(pal, sim, colorBy, list);
        final hov = hovered != null ? sim.citizen(hovered!) : null;
        return Container(
          color: pal.paper,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: Wrap(spacing: 14, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.center, children: [
                Text('${list.length} citoyens · $employed en emploi (●) · ${list.length - employed} sans emploi (■)',
                    style: TextStyle(color: pal.ink, fontSize: 12.5, fontWeight: FontWeight.w600)),
                _Picker<CitizenColor>('Couleur', colorBy, _colorLabels, (v) => setState(() => colorBy = v)),
                _Picker<CitizenSort>('Ordre', sortBy, _sortLabels, (v) => setState(() => sortBy = v)),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
              child: Wrap(spacing: 10, runSpacing: 2, children: [
                for (final (label, col) in colors.legend)
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    Container(width: 10, height: 10, decoration: BoxDecoration(color: col, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    Text(label, style: TextStyle(color: pal.ink2, fontSize: 11)),
                  ]),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 6),
              child: Text(
                  hov == null
                      ? 'Survolez un citoyen pour un aperçu ; cliquez pour ouvrir sa fiche.'
                      : '${hov.name} · ${hov.employer != null ? (sim.firm(hov.employer!)?.name ?? 'en emploi') : 'sans emploi'} · '
                          '${money0(hov.money)} · bonheur ${pct(hov.happiness)} · santé ${pct(hov.health)} · '
                          '${classLabels[hov.level].toLowerCase()}${hov.hungerDays > 0 ? ' · a faim' : ''}'
                          '${hov.homeless ? ' · sans logis' : ''}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: hov == null ? pal.ink3 : pal.ink, fontSize: 12)),
            ),
            Divider(height: 1, color: pal.rule),
            Expanded(
              child: LayoutBuilder(builder: (context, box) {
                final n = math.max(1, list.length);
                // taille des cases : tout tient à l'écran si possible, sans descendre sous 6 px (on fait alors défiler)
                final cell = math.sqrt(box.maxWidth * box.maxHeight / n).clamp(6.0, 30.0).toDouble();
                final cols = math.max(1, (box.maxWidth - 16) ~/ cell);
                final rows = (list.length + cols - 1) ~/ cols;
                final height = math.max(box.maxHeight, rows * cell + 16);
                final selected = ctrl.selection.kind == 'citizen' ? ctrl.selection.id : null;
                int? at(Offset p) {
                  final c = ((p.dx - 8) / cell).floor(), r = ((p.dy - 8) / cell).floor();
                  if (c < 0 || c >= cols || r < 0) return null;
                  final i = r * cols + c;
                  return i < list.length ? list[i].id : null;
                }

                return SingleChildScrollView(
                  child: MouseRegion(
                    onHover: (e) {
                      final id = at(e.localPosition);
                      if (id != hovered) setState(() => hovered = id);
                    },
                    onExit: (_) => setState(() => hovered = null),
                    child: GestureDetector(
                      onTapUp: (e) {
                        final id = at(e.localPosition);
                        if (id != null) ctrl.select(Selection('citizen', id));
                      },
                      child: CustomPaint(
                        size: Size(box.maxWidth, height),
                        painter: _CitizenPainter(list, colors, cell, cols, selected, hovered, pal),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ]),
        );
      },
    );
  }
}

/// Un menu compact. Un menu contextuel plutôt qu'un DropdownButton : celui-ci se referme à chaque reconstruction, et la
/// vue se reconstruit plusieurs fois par seconde pendant la lecture.
class _Picker<T> extends StatelessWidget {
  final String label;
  final T value;
  final Map<T, String> labels;
  final void Function(T) onChanged;
  const _Picker(this.label, this.value, this.labels, this.onChanged);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return PopupMenuButton<T>(
      tooltip: label,
      initialValue: value,
      onSelected: onChanged,
      itemBuilder: (_) => [for (final e in labels.entries) PopupMenuItem(value: e.key, child: Text(e.value))],
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text('$label : ', style: TextStyle(color: pal.ink2, fontSize: 12)),
        Text(labels[value]!, style: TextStyle(color: pal.ink, fontSize: 12.5, fontWeight: FontWeight.w600)),
        Icon(Icons.arrow_drop_down, size: 18, color: pal.ink2),
      ]),
    );
  }
}

/// Couleur de chaque citoyen et légende, selon l'indicateur choisi.
class _CitizenColors {
  final Pal pal;
  final Sim sim;
  final CitizenColor by;
  final List<(String, Color)> legend = [];
  late final Map<int, double> _moneyRank; // rang de l'argent, de 0 (le plus pauvre) à 1 (le plus riche)

  _CitizenColors(this.pal, this.sim, this.by, List<Citizen> list) {
    switch (by) {
      case CitizenColor.bonheur:
      case CitizenColor.sante:
        legend.addAll([('bas', pal.bad), ('moyen', pal.warn), ('haut', pal.ok)]);
      case CitizenColor.argent:
        final sorted = List<Citizen>.of(list)..sort((a, b) => a.money.compareTo(b.money));
        _moneyRank = {
          for (var i = 0; i < sorted.length; i++) sorted[i].id: sorted.length > 1 ? i / (sorted.length - 1) : 1.0
        };
        legend.addAll([('les plus pauvres', _ramp(0)), ('médiane', _ramp(0.5)), ('les plus riches', _ramp(1))]);
      case CitizenColor.qualification:
        for (var l = 0; l < 3; l++) {
          legend.add((classLabels[l], _classColor(l)));
        }
      case CitizenColor.secteur:
        for (final s in sectors) {
          legend.add((sectorLabels[s]!, pal.sector(s)));
        }
        legend.add(('sans emploi', pal.ink3));
      case CitizenColor.detresse:
        legend.addAll([('nourri et logé', pal.ok), ('a faim', pal.bad), ('sans logis', pal.warn)]);
    }
  }

  Color _ramp(double t) => Color.lerp(const Color(0xFFB9C7D8), pal.accent, t)!;

  Color _classColor(int l) => [pal.primaire, pal.transfo, pal.conso][l];

  Color _scale(double v) =>
      v < 0.5 ? Color.lerp(pal.bad, pal.warn, (v / 0.5).clamp(0.0, 1.0))! : Color.lerp(pal.warn, pal.ok, ((v - 0.5) / 0.5).clamp(0.0, 1.0))!;

  Color of(Citizen c) {
    switch (by) {
      case CitizenColor.bonheur:
        return _scale(c.happiness);
      case CitizenColor.sante:
        return _scale(c.health);
      case CitizenColor.argent:
        return _ramp(_moneyRank[c.id] ?? 0);
      case CitizenColor.qualification:
        return _classColor(c.level);
      case CitizenColor.secteur:
        final f = c.employer != null ? sim.firm(c.employer!) : null;
        return f == null ? pal.ink3 : pal.sector(f.template.sector);
      case CitizenColor.detresse:
        if (c.hungerDays > 0) return pal.bad;
        if (c.homeless) return pal.warn;
        return pal.ok;
    }
  }
}

class _CitizenPainter extends CustomPainter {
  final List<Citizen> list;
  final _CitizenColors colors;
  final double cell;
  final int cols;
  final int? selected, hovered;
  final Pal pal;
  _CitizenPainter(this.list, this.colors, this.cell, this.cols, this.selected, this.hovered, this.pal);

  @override
  void paint(Canvas canvas, Size size) {
    final fill = Paint();
    final r = cell * 0.38;
    Offset centre(int i) => Offset(8 + (i % cols + 0.5) * cell, 8 + (i ~/ cols + 0.5) * cell);
    for (var i = 0; i < list.length; i++) {
      final c = list[i];
      fill.color = colors.of(c);
      final o = centre(i);
      if (c.employer != null) {
        canvas.drawCircle(o, r, fill);
      } else {
        canvas.drawRect(Rect.fromCenter(center: o, width: 2 * r * 0.9, height: 2 * r * 0.9), fill);
      }
    }
    // citoyen choisi (dans l'inspecteur) et citoyen survolé : un anneau
    for (var i = 0; i < list.length; i++) {
      final id = list[i].id;
      if (id != selected && id != hovered) continue;
      canvas.drawCircle(
          centre(i),
          r + 2.5,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = id == selected ? 2.2 : 1.2
            ..color = id == selected ? pal.ink : pal.ink2);
    }
  }

  @override
  bool shouldRepaint(covariant _CitizenPainter old) => true;
}
