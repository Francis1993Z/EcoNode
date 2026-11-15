// Tableau de l'éducation : une ligne par citoyen (emploi, diplômes, formation en cours), filtres par filière, niveau et
// « en formation seulement », tri par colonne ; un clic ouvre la fiche du citoyen dans l'inspecteur. Remplace le graphe
// quand la vue « Éducation » est choisie. Lecture seule : rien n'y change la partie.
//
// Fluidité à 2 500 citoyens : les lignes sont recalculées (filtre et tri) au plus deux fois par seconde de temps réel, et
// seulement si le jour, les filtres ou le tri ont changé ; la liste est paresseuse (ListView.builder à hauteur fixe) : seules
// les lignes visibles sont construites.

import 'dart:async';

import 'package:flutter/material.dart';

import '../engine/model.dart';
import '../engine/sim.dart';
import 'controller.dart';
import 'format.dart';
import 'palette.dart';

/// Colonnes triables.
enum EduColumn { citoyen, emploi, education, formation, mode, restants, progression }

const Map<EduColumn, String> _headers = {
  EduColumn.citoyen: 'Citoyen',
  EduColumn.emploi: 'Emploi',
  EduColumn.education: 'Éducation',
  EduColumn.formation: 'En formation',
  EduColumn.mode: 'Rythme',
  EduColumn.restants: 'Jours restants',
  EduColumn.progression: 'Progression',
};

const Map<EduColumn, int> _flex = {
  EduColumn.citoyen: 16,
  EduColumn.emploi: 22,
  EduColumn.education: 22,
  EduColumn.formation: 20,
  EduColumn.mode: 10,
  EduColumn.restants: 8,
  EduColumn.progression: 12,
};

/// Une ligne du tableau, calculée une fois par rafraîchissement.
class EduRow {
  final int id;
  final String name;
  final String job; // entreprise · rôle, « sans emploi » ou « étudiant à temps plein »
  final bool employed;
  final int level; // meilleur diplôme (0 aucun, 1 technicien, 2 professionnel) ; module coupé : la classe
  final int field; // filière du meilleur diplôme, -1 : aucune (ou module coupé)
  final int others; // autres filières où il a un diplôme
  final int studyField; // -1 : pas en formation
  final int studyLevel;
  final String mode; // temps plein, cours du soir, cherche un emploi
  final double remaining; // jours de calendrier restants au rythme d'aujourd'hui
  final double progress; // 0 à 1
  const EduRow(this.id, this.name, this.job, this.employed, this.level, this.field, this.others, this.studyField,
      this.studyLevel, this.mode, this.remaining, this.progress);

  bool get studying => studyField >= 0;
}

/// Les lignes de tous les citoyens (lecture seule de l'état du moteur).
List<EduRow> educationRows(Sim sim) {
  final p = sim.params;
  final withDegrees = p.formation && sim.formationReady;
  final rows = <EduRow>[];
  for (final c in sim.citizens) {
    final f = c.employer == null ? null : sim.firm(c.employer!);
    var level = c.level, field = -1, others = 0;
    if (withDegrees && c.degrees.isNotEmpty) {
      level = 0;
      for (var i = 0; i < c.degrees.length; i++) {
        final d = c.degrees[i];
        if (d == 0) continue;
        if (d > level) {
          if (field >= 0) others++;
          level = d;
          field = i;
        } else {
          others++;
        }
      }
    }
    final studying = c.studyField >= 0;
    String job;
    if (f != null) {
      final role = sim.modules.jobs && c.role >= 0 && c.role < roles[f.type]!.length ? roles[f.type]![c.role].label : null;
      job = role == null ? f.name : '${f.name} · $role';
    } else {
      job = studying && sim.studiesFullTime(c) ? 'étudiant à temps plein' : 'sans emploi';
    }
    var mode = '', remaining = 0.0, progress = 0.0;
    if (studying) {
      final pace = c.employer != null ? 1 / p.eduNightFactor : 1.0;
      mode = c.employer != null ? 'cours du soir' : (c.studySeeksWork ? 'cherche un emploi' : 'temps plein');
      remaining = (c.studyNeed - c.studyDone).clamp(0, double.infinity) / pace;
      progress = c.studyNeed > 0 ? (c.studyDone / c.studyNeed).clamp(0.0, 1.0).toDouble() : 0.0;
    }
    rows.add(EduRow(c.id, c.name, job, f != null, level, field, others, c.studyField, c.studyLevel, mode, remaining,
        progress));
  }
  return rows;
}

class EducationView extends StatefulWidget {
  final SimController ctrl;
  const EducationView(this.ctrl, {super.key});
  @override
  State<EducationView> createState() => _EducationViewState();
}

class _EducationViewState extends State<EducationView> {
  int fieldFilter = -1; // -1 : toutes les filières
  int levelFilter = -1; // -1 : tous les niveaux
  bool studyingOnly = false;
  EduColumn sortBy = EduColumn.citoyen;
  bool ascending = true;

  // cache des lignes : recalculées au plus deux fois par seconde, si le jour, les filtres ou le tri ont changé
  List<EduRow> _all = const [];
  List<EduRow> _shown = const [];
  int _day = -1;
  Sim? _sim;
  String _key = '';
  final Stopwatch _since = Stopwatch()..start();
  final ScrollController _scroll = ScrollController();
  Timer? _later; // rafraîchissement différé : le dernier jour joué s'affiche même si la partie s'arrête aussitôt

  SimController get ctrl => widget.ctrl;

  @override
  void dispose() {
    _later?.cancel();
    _scroll.dispose();
    super.dispose();
  }

  String get _filterKey => '$fieldFilter/$levelFilter/$studyingOnly/$sortBy/$ascending';

  void _refresh({bool force = false}) {
    final sim = ctrl.sim;
    final key = _filterKey;
    final stale = !identical(sim, _sim) || sim.day != _day;
    if (!force && key == _key && !stale) return;
    if (!force && key == _key && _since.elapsedMilliseconds < 500) {
      _later ??= Timer(Duration(milliseconds: 500 - _since.elapsedMilliseconds), () {
        _later = null;
        if (mounted) setState(() {});
      });
      return;
    }
    if (stale || force || !identical(sim, _sim)) {
      _all = educationRows(sim);
      _sim = sim;
      _day = sim.day;
    }
    _key = key;
    _since.reset();
    final l = [
      for (final r in _all)
        if ((!studyingOnly || r.studying) &&
            (levelFilter < 0 || r.level == levelFilter) &&
            (fieldFilter < 0 || r.field == fieldFilter || r.studyField == fieldFilter ||
                (r.others > 0 && _holds(sim, r.id, fieldFilter))))
          r,
    ];
    int cmp(EduRow a, EduRow b) {
      int c;
      switch (sortBy) {
        case EduColumn.citoyen:
          c = a.name.compareTo(b.name);
        case EduColumn.emploi:
          c = (a.employed ? 0 : 1) - (b.employed ? 0 : 1);
          if (c == 0) c = a.job.compareTo(b.job);
        case EduColumn.education:
          c = a.level - b.level;
          if (c == 0) c = a.field - b.field;
        case EduColumn.formation:
          c = (a.studying ? a.studyLevel : -1) - (b.studying ? b.studyLevel : -1);
          if (c == 0) c = a.studyField - b.studyField;
        case EduColumn.mode:
          c = a.mode.compareTo(b.mode);
        case EduColumn.restants:
          c = (a.studying ? a.remaining : double.infinity).compareTo(b.studying ? b.remaining : double.infinity);
        case EduColumn.progression:
          c = (a.studying ? a.progress : -1.0).compareTo(b.studying ? b.progress : -1.0);
      }
      if (!ascending) c = -c;
      return c != 0 ? c : a.id - b.id;
    }

    l.sort(cmp);
    _shown = l;
  }

  static bool _holds(Sim sim, int id, int field) {
    final c = sim.citizen(id);
    return c != null && sim.degreeIn(c, field) > 0;
  }

  void _set(void Function() f) => setState(() {
        f();
        _refresh(force: true);
      });

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    return AnimatedBuilder(
      animation: ctrl,
      builder: (context, _) {
        _refresh();
        final sim = ctrl.sim;
        final withDegrees = sim.params.formation && sim.formationReady;
        final selected = ctrl.selection.kind == 'citizen' ? ctrl.selection.id : null;
        return Container(
          color: pal.paper,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _Summary(rows: _all, withDegrees: withDegrees, pal: pal),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 2, 12, 6),
              child: Wrap(spacing: 16, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.center, children: [
                _Picker<int>('Filière', fieldFilter, {
                  -1: 'toutes',
                  for (var f = 0; f < fieldKeys.length; f++) f: fieldLabels[fieldKeys[f]]!,
                }, (v) => _set(() => fieldFilter = v)),
                _Picker<int>('Niveau', levelFilter, const {
                  -1: 'tous',
                  0: 'sans diplôme',
                  1: 'technicien',
                  2: 'professionnel',
                }, (v) => _set(() => levelFilter = v)),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Checkbox(
                      value: studyingOnly,
                      visualDensity: VisualDensity.compact,
                      onChanged: (v) => _set(() => studyingOnly = v ?? false)),
                  Text('en formation seulement', style: TextStyle(color: pal.ink, fontSize: 12)),
                ]),
                Text('${_shown.length} ligne${_shown.length > 1 ? 's' : ''}', style: TextStyle(color: pal.ink3, fontSize: 12)),
              ]),
            ),
            Divider(height: 1, color: pal.rule),
            _HeaderRow(sortBy: sortBy, ascending: ascending, pal: pal, onTap: (col) {
              _set(() {
                if (sortBy == col) {
                  ascending = !ascending;
                } else {
                  sortBy = col;
                  ascending = col == EduColumn.citoyen || col == EduColumn.restants || col == EduColumn.mode;
                }
              });
            }),
            Divider(height: 1, color: pal.rule),
            Expanded(
              child: _shown.isEmpty
                  ? Center(child: Text('Aucun citoyen ne correspond aux filtres.', style: TextStyle(color: pal.ink3)))
                  : Scrollbar(
                      controller: _scroll,
                      child: ListView.builder(
                        controller: _scroll,
                        itemCount: _shown.length,
                        itemExtent: 30,
                        itemBuilder: (context, i) => _Line(
                          row: _shown[i],
                          selected: _shown[i].id == selected,
                          withDegrees: withDegrees,
                          pal: pal,
                          onTap: () => ctrl.select(Selection('citizen', _shown[i].id)),
                        ),
                      ),
                    ),
            ),
          ]),
        );
      },
    );
  }
}

/// Résumé : répartition du niveau d'éducation (barres) et personnes en formation.
class _Summary extends StatelessWidget {
  final List<EduRow> rows;
  final bool withDegrees;
  final Pal pal;
  const _Summary({required this.rows, required this.withDegrees, required this.pal});

  @override
  Widget build(BuildContext context) {
    final n = rows.length;
    final byLevel = [0, 0, 0];
    var full = 0, night = 0, seeking = 0;
    final studyLevel = [0, 0, 0];
    for (final r in rows) {
      byLevel[r.level]++;
      if (!r.studying) continue;
      studyLevel[r.studyLevel]++;
      if (r.mode == 'cours du soir') {
        night++;
      } else if (r.mode == 'temps plein') {
        full++;
      } else {
        seeking++;
      }
    }
    final students = full + night + seeking;
    final labels = withDegrees ? const ['Sans diplôme', 'Technicien', 'Professionnel'] : classLabels;
    final colors = [pal.ink3, pal.accent, pal.ok];
    Widget bar(int k) {
      final share = n == 0 ? 0.0 : byLevel[k] / n;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(children: [
          SizedBox(width: 104, child: Text(labels[k], style: TextStyle(color: pal.ink2, fontSize: 12))),
          Expanded(
            child: LayoutBuilder(
              builder: (context, box) => Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: box.maxWidth * share,
                  height: 12,
                  decoration: BoxDecoration(color: colors[k], borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ),
          ),
          SizedBox(
              width: 110,
              child: Text('${byLevel[k]} · ${pct(share)}', textAlign: TextAlign.right, style: mono(pal.ink, 12))),
        ]),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          flex: 3,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Niveau d’éducation · $n citoyens',
                style: TextStyle(color: pal.ink, fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            for (var k = 0; k < 3; k++) bar(k),
            if (!withDegrees)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                    'Module Formation coupé : classe de qualification, sans diplôme ni filière (onglet Formation pour l’activer).',
                    style: TextStyle(color: pal.ink3, fontSize: 11)),
              ),
          ]),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 2,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('En formation : $students (${pct(n == 0 ? 0 : students / n)})',
                style: TextStyle(color: pal.ink, fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text('Temps plein : $full · cours du soir : $night${seeking > 0 ? ' · cherchent un emploi : $seeking' : ''}',
                style: TextStyle(color: pal.ink2, fontSize: 12)),
            Text('Vers technicien : ${studyLevel[1]} · vers professionnel : ${studyLevel[2]}',
                style: TextStyle(color: pal.ink2, fontSize: 12)),
          ]),
        ),
      ]),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  final EduColumn sortBy;
  final bool ascending;
  final Pal pal;
  final void Function(EduColumn) onTap;
  const _HeaderRow({required this.sortBy, required this.ascending, required this.pal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(children: [
        for (final col in EduColumn.values)
          Expanded(
            flex: _flex[col]!,
            child: InkWell(
              onTap: () => onTap(col),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(children: [
                  Flexible(
                    child: Text(_headers[col]!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: sortBy == col ? pal.ink : pal.ink3, fontSize: 11.5, fontWeight: FontWeight.w600)),
                  ),
                  if (sortBy == col)
                    Icon(ascending ? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 16, color: pal.ink),
                ]),
              ),
            ),
          ),
      ]),
    );
  }
}

class _Line extends StatelessWidget {
  final EduRow row;
  final bool selected;
  final bool withDegrees;
  final Pal pal;
  final VoidCallback onTap;
  const _Line(
      {required this.row, required this.selected, required this.withDegrees, required this.pal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final r = row;
    Widget cell(EduColumn col, Widget child) => Expanded(
        flex: _flex[col]!, child: Padding(padding: const EdgeInsets.only(right: 8), child: child));
    Text t(String s, {Color? color}) =>
        Text(s, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(color: color ?? pal.ink, fontSize: 12));
    final edu = r.level == 0
        ? (withDegrees ? 'sans diplôme' : classLabels[0].toLowerCase())
        : (withDegrees && r.field >= 0
            ? '${classLabels[r.level]} · ${fieldLabels[fieldKeys[r.field]]}${r.others > 0 ? ' (+${r.others})' : ''}'
            : classLabels[r.level]);
    return Material(
      color: selected ? pal.accentSoft : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: pal.rule, width: 0.5))),
          child: Row(children: [
            cell(EduColumn.citoyen, t('${r.name} #${r.id}')),
            cell(EduColumn.emploi, t(r.job, color: r.employed ? pal.ink : pal.ink3)),
            cell(EduColumn.education, t(edu, color: r.level == 0 ? pal.ink3 : pal.ink)),
            cell(
                EduColumn.formation,
                r.studying
                    ? t('${classLabels[r.studyLevel]} · ${fieldLabels[fieldKeys[r.studyField]]}', color: pal.accent)
                    : t('—', color: pal.ink3)),
            cell(EduColumn.mode, t(r.mode, color: r.mode == 'cherche un emploi' ? pal.warn : pal.ink2)),
            cell(EduColumn.restants,
                Text(r.studying ? fmtNum(r.remaining, 0) : '', textAlign: TextAlign.right, style: mono(pal.ink, 12))),
            cell(
                EduColumn.progression,
                r.studying
                    ? Row(children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: LinearProgressIndicator(
                                value: r.progress, minHeight: 6, color: pal.accent, backgroundColor: pal.rule),
                          ),
                        ),
                        SizedBox(
                            width: 40,
                            child: Text(pct(r.progress).replaceAll(',0 ', ' '),
                                textAlign: TextAlign.right, style: mono(pal.ink2, 11))),
                      ])
                    : const SizedBox.shrink()),
          ]),
        ),
      ),
    );
  }
}

/// Un menu compact (menu contextuel : un DropdownButton se refermerait à chaque reconstruction pendant la lecture).
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
