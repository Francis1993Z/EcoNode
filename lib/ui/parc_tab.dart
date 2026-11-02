// Onglet « Parc » (module Bâtiments) : explorer le parc immobilier, bâtiment par bâtiment, sans disposition spatiale.
// Totaux par type de bâtiment (Params.buildingTypes), filtres, grille de sprites ; toucher un bâtiment ouvre sa fiche
// (logements, propriétaire, locataires ou occupants, valeur, hypothèque). L'interface ne modifie rien dans le moteur, sauf
// l'interrupteur des types de bâtiments.

import 'package:flutter/material.dart';

import '../engine/model.dart';
import '../engine/sim.dart';
import 'controller.dart';
import 'format.dart';
import 'housing.dart';
import 'palette.dart';
import 'widgets.dart';

/// Clé d'un bâtiment pour les filtres et les totaux : celle de son type, « standard » sans type.
String kindKey(Building b) => b.type == null ? 'standard' : buildingKinds[b.type!].key;

/// Nom d'un type de bâtiment (« Logement standard » sans type).
String kindName(Building b) => b.type == null ? 'Logement standard' : buildingKinds[b.type!].name;

/// Sprite d'un bâtiment : le chantier tant qu'il n'est pas terminé ; un logement standard a celui de la maison moyenne.
String spriteOf(Building b) =>
    'assets/batiments/${!b.done ? 'chantier' : (b.type == null ? buildingKinds[1].key : buildingKinds[b.type!].key)}.png';

const List<double> _grey = [
  0.33, 0.33, 0.33, 0, 0, //
  0.33, 0.33, 0.33, 0, 0, //
  0.33, 0.33, 0.33, 0, 0, //
  0, 0, 0, 1, 0,
];

/// Sprite en pixels nets ; grisé si le bâtiment est inhabitable.
Widget buildingSprite(Building b, double size) {
  final img = Image.asset(spriteOf(b), width: size, height: size, filterQuality: FilterQuality.none, gaplessPlayback: true);
  return b.done && !b.habitable ? ColorFiltered(colorFilter: const ColorFilter.matrix(_grey), child: img) : img;
}

/// Occupation du parc : logements occupés de chaque bâtiment et, quand les locataires sont rattachés à un logement
/// (types de bâtiments avec les baux), leurs noms. Sinon les locataires de chaque bailleur sont répartis sur ses
/// bâtiments habitables dans l'ordre du parc (estimation d'affichage).
class Occupancy {
  final Map<int, int> used = {}; // bâtiment → logements occupés
  final Map<int, List<Citizen>> tenants = {}; // bâtiment → locataires rattachés
  late final bool exact;

  Occupancy(Sim sim) {
    final p = sim.params;
    exact = p.buildingTypes && p.leases;
    for (final b in sim.buildings) {
      if (b.done && b.ownerKind == 1) used[b.id] = 1;
    }
    if (exact) {
      for (final c in sim.citizens) {
        final b = sim.dwellingOf(c);
        if (b == null) continue;
        (tenants[b.id] ??= <Citizen>[]).add(c);
        used[b.id] = (used[b.id] ?? 0) + 1;
      }
      return;
    }
    // estimation : locataires de chaque bailleur (baux, sinon nuitées vendues aujourd'hui), dans l'ordre du parc
    final left = <int, int>{};
    if (p.leases) {
      for (final c in sim.citizens) {
        if (c.leaseFirm != null && c.homeId == null) left[c.leaseFirm!] = (left[c.leaseFirm!] ?? 0) + 1;
      }
    } else {
      for (final f in sim.firms) {
        if (f.type == 'immobilier') left[f.id] = (f.sold['logement'] ?? 0).round();
      }
    }
    for (final b in sim.buildings) {
      if (b.ownerKind != 0 || !b.habitable) continue;
      final n = left[b.ownerId] ?? 0;
      if (n <= 0) continue;
      final k = n < b.units ? n : b.units;
      used[b.id] = k;
      left[b.ownerId!] = n - k;
    }
  }

  int of(Building b) => used[b.id] ?? 0;
}

/// Totaux d'un type de bâtiment.
class _Row {
  final String key, name;
  final Building sample;
  int count = 0, units = 0, used = 0, vacant = 0, sites = 0, ruined = 0;
  _Row(this.key, this.name, this.sample);
}

class ParcTab extends StatefulWidget {
  final SimController ctrl;
  const ParcTab(this.ctrl, {super.key});

  @override
  State<ParcTab> createState() => _ParcTabState();
}

/// Filtres d'état de la grille.
const Map<String, String> _status = {
  'tous': 'Tous',
  'habites': 'Habités',
  'vacants': 'Avec logements vacants',
  'menages': 'Propriétaires-occupants',
  'vente': 'En vente',
  'saisis': 'Saisis',
  'chantiers': 'Chantiers',
  'inhabitables': 'Inhabitables',
};

class _ParcTabState extends State<ParcTab> {
  String? kind; // null : tous les types
  String status = 'tous';

  bool _keep(Building b, Occupancy occ) {
    if (kind != null && kindKey(b) != kind) return false;
    switch (status) {
      case 'habites':
        return b.done && occ.of(b) > 0;
      case 'vacants':
        return b.habitable && b.ownerKind != 1 && occ.of(b) < b.units;
      case 'menages':
        return b.done && b.ownerKind == 1;
      case 'vente':
        return b.done && b.listedDay != null;
      case 'saisis':
        return b.done && b.ownerKind == 2;
      case 'chantiers':
        return !b.done;
      case 'inhabitables':
        return b.done && !b.habitable;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final ctrl = widget.ctrl;
    final sim = ctrl.sim;
    final p = sim.params;
    if (!sim.modules.buildings) {
      return ListView(padding: const EdgeInsets.all(12), children: [
        Section('Parc immobilier', [
          Text(
              'Le module Bâtiments n’est pas actif dans cette partie : il n’y a pas de parc à explorer. On peut l’activer dans '
              'l’onglet Immobilier (il prend effet au prochain jour) ou à la création d’une partie (« Marché immobilier »).',
              style: TextStyle(color: pal.ink2, fontSize: 12.5)),
        ]),
      ]);
    }
    final occ = Occupancy(sim);
    // totaux par type, dans l'ordre des types (le logement standard d'abord)
    final rows = <String, _Row>{};
    for (final b in sim.buildings) {
      final r = rows[kindKey(b)] ??= _Row(kindKey(b), kindName(b), b);
      r.count++;
      if (!b.done) {
        r.sites++;
        continue;
      }
      r.units += b.units;
      if (!b.habitable) {
        r.ruined += b.units;
        continue;
      }
      final u = occ.of(b);
      r.used += u;
      r.vacant += b.units - u;
    }
    final order = ['standard', for (final k in buildingKinds) k.key];
    final list = [for (final k in order) if (rows[k] != null) rows[k]!];
    final all = _Row('tous', 'Total', sim.buildings.isEmpty ? Building(0, 0, null, 0) : sim.buildings.first);
    for (final r in list) {
      all
        ..count += r.count
        ..units += r.units
        ..used += r.used
        ..vacant += r.vacant
        ..sites += r.sites
        ..ruined += r.ruined;
    }
    final homeless = sim.citizens.where((c) => c.homeless).length;
    final homelessWorking = sim.citizens.where((c) => c.homeless && c.employer != null).length;
    if (kind != null && rows[kind] == null) kind = null;
    final shown = [for (final b in sim.buildings) if (_keep(b, occ)) b];

    Widget cell(String t, {bool head = false, int flex = 2, TextAlign align = TextAlign.right, Color? color}) => Expanded(
        flex: flex,
        child: Text(t,
            textAlign: align,
            overflow: TextOverflow.ellipsis,
            style: head
                ? TextStyle(color: pal.ink3, fontSize: 10.5, fontWeight: FontWeight.w600)
                : mono(color ?? pal.ink, 11.5)));

    Widget line(_Row r, {bool total = false}) => InkWell(
          onTap: total ? () => setState(() => kind = null) : () => setState(() => kind = kind == r.key ? null : r.key),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(children: [
              SizedBox(width: 24, child: total ? null : buildingSprite(r.sample.done ? r.sample : (Building(0, 0, null, 0, r.sample.type)..done = true), 22)),
              cell(r.name, flex: 5, align: TextAlign.left, color: kind == r.key ? pal.accent : null),
              cell('${r.count}'),
              cell('${r.units}'),
              cell(r.units - r.ruined > 0 ? pct(r.used / (r.units - r.ruined)) : '—'),
              cell('${r.vacant}', color: r.vacant > 0 ? pal.ink2 : null),
              cell('${r.sites}', color: r.sites > 0 ? pal.primaire : null),
            ]),
          ),
        );

    return CustomScrollView(slivers: [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            Section('Parc immobilier', [
              Text(
                  'Chaque bâtiment du parc, sans carte : maisons (achetées par les ménages ou louées), duplex et immeubles '
                  '(loués par les bailleurs). Toucher une ligne filtre la grille ; toucher un bâtiment ouvre sa fiche.',
                  style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
              SwitchListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: const Text('Types de bâtiments', style: TextStyle(fontSize: 13)),
                subtitle: const Text(
                    'Maisons, duplex et immeubles, chacun avec ses logements, son coût, sa durée de chantier et sa valeur. '
                    'En cours de partie, les nouveaux chantiers et les achats suivent la règle ; le parc existant garde ses '
                    'bâtiments. Coupé : chaque bâtiment est un logement standard.',
                    style: TextStyle(fontSize: 11)),
                value: p.buildingTypes,
                onChanged: (v) {
                  p.buildingTypes = v;
                  ctrl.touch();
                },
              ),
            ]),
            Section('Totaux par type', [
              Row(children: [
                const SizedBox(width: 24),
                cell('Type', head: true, flex: 5, align: TextAlign.left),
                cell('Bât.', head: true),
                cell('Log.', head: true),
                cell('Occupés', head: true),
                cell('Vacants', head: true),
                cell('Chant.', head: true),
              ]),
              for (final r in list) line(r),
              Divider(height: 10, color: pal.rule),
              line(all, total: true),
              const SizedBox(height: 6),
              KV('Logements habitables', '${sim.dwellings}  (inhabitables : ${all.ruined})',
                  color: all.ruined > 0 ? pal.warn : null),
              KV('Propriétaires-occupants', '${sim.homeOwners}'),
              KV('Sans-abri', '$homeless  (dont $homelessWorking avec un emploi)', color: homeless > 0 ? pal.bad : null),
              if (!occ.exact)
                Text(
                    p.buildingTypes
                        ? 'Les baux sont coupés : l’occupation des bâtiments des bailleurs est estimée (nuitées vendues).'
                        : 'Les locataires ne sont rattachés à un logement qu’avec les types de bâtiments : l’occupation des '
                            'bâtiments des bailleurs est estimée.',
                    style: TextStyle(color: pal.ink3, fontSize: 11)),
            ]),
            Wrap(spacing: 6, runSpacing: 4, children: [
              for (final e in _status.entries)
                ChoiceChip(
                  label: Text(e.value, style: const TextStyle(fontSize: 11.5)),
                  visualDensity: VisualDensity.compact,
                  selected: status == e.key,
                  selectedColor: pal.accentSoft,
                  onSelected: (_) => setState(() => status = e.key),
                ),
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 8, 2, 6),
              child: Text(
                  '${shown.length} bâtiment${shown.length > 1 ? 's' : ''}'
                  '${kind != null ? ' · ${rows[kind]!.name}' : ''}${status != 'tous' ? ' · ${_status[status]!.toLowerCase()}' : ''}',
                  style: TextStyle(color: pal.ink2, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ]),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 92, mainAxisSpacing: 6, crossAxisSpacing: 6, childAspectRatio: 0.74),
          delegate: SliverChildBuilderDelegate((context, i) => _Tile(ctrl, shown[i], occ.of(shown[i])),
              childCount: shown.length),
        ),
      ),
    ]);
  }
}

/// Une case de la grille : sprite, numéro, occupation (ou avancement du chantier), état.
class _Tile extends StatelessWidget {
  final SimController ctrl;
  final Building b;
  final int used;
  const _Tile(this.ctrl, this.b, this.used);

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final st = buildingStatus(pal, b);
    final frac = !b.done ? b.modules / sim.modulesOf(b) : (b.units > 0 ? used / b.units : 0.0);
    return Tooltip(
      message: '${kindName(b)} n° ${b.id} · ${st.label}',
      waitDuration: const Duration(milliseconds: 500),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => showBuilding(context, ctrl, b.id),
        child: Container(
          padding: const EdgeInsets.fromLTRB(4, 4, 4, 5),
          decoration: BoxDecoration(
            color: pal.sheet,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: b.listedDay != null || b.ownerKind == 2 ? st.color : pal.rule2),
          ),
          child: Column(children: [
            Expanded(
              child: Stack(children: [
                Center(child: buildingSprite(b, 64)),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                      width: 8, height: 8, decoration: BoxDecoration(color: st.color, shape: BoxShape.circle)),
                ),
                if (b.listedDay != null)
                  Positioned(left: 0, top: 0, child: Icon(Icons.sell_outlined, size: 12, color: st.color)),
              ]),
            ),
            Text('n° ${b.id}', style: mono(pal.ink2, 10)),
            const SizedBox(height: 2),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                  value: frac.clamp(0.0, 1.0).toDouble(),
                  minHeight: 4,
                  color: !b.done ? pal.primaire : (b.habitable ? pal.ok : pal.bad),
                  backgroundColor: pal.rule2),
            ),
            const SizedBox(height: 1),
            Text(!b.done ? '${b.modules}/${sim.modulesOf(b)} mod.' : '$used/${b.units} occ.',
                style: TextStyle(color: pal.ink3, fontSize: 9.5)),
          ]),
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------ fiche d'un bâtiment

/// Ouvre la fiche d'un bâtiment par-dessus l'onglet ; elle suit la simulation tant qu'elle est ouverte.
void showBuilding(BuildContext context, SimController ctrl, int id) {
  showDialog<void>(
    context: context,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440, maxHeight: 640),
        child: AnimatedBuilder(animation: ctrl, builder: (context, _) => _BuildingCard(ctrl, id)),
      ),
    ),
  );
}

class _BuildingCard extends StatelessWidget {
  final SimController ctrl;
  final int id;
  const _BuildingCard(this.ctrl, this.id);

  void _open(BuildContext context, Selection s) {
    Navigator.of(context).pop();
    ctrl.select(s);
  }

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final b = sim.building(id);
    if (b == null) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('Ce bâtiment n’existe plus (chantier abandonné).', style: TextStyle(color: pal.ink2)),
          const SizedBox(height: 12),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Fermer')),
        ]),
      );
    }
    final st = buildingStatus(pal, b);
    final occ = Occupancy(sim);
    final used = occ.of(b);
    final tenants = occ.tenants[b.id] ?? const <Citizen>[];
    final m = sim.mortgageOf(b);
    final fair = b.done ? sim.fairValue(b) : 0.0;
    final landlord = b.ownerKind == 0 ? sim.firm(b.ownerId ?? -1) : null;
    final owner = b.ownerKind == 1 ? sim.citizen(b.ownerId ?? -1) : null;
    final rent = landlord?.price['logement'];
    final kindInfo = b.type == null ? null : buildingKinds[b.type!];

    Widget unitChip(int i, Citizen? c, String text) => InkWell(
          onTap: c == null ? null : () => _open(context, Selection('citizen', c.id)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: c != null ? pal.ok.withValues(alpha: 0.12) : pal.rule2.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('${i + 1} · $text',
                style: TextStyle(color: c != null ? pal.ink : pal.ink3, fontSize: 11.5, fontWeight: FontWeight.w600)),
          ),
        );

    final units = <Widget>[];
    if (!b.done) {
      units.add(Text('En construction : aucun logement habitable.', style: TextStyle(color: pal.ink2, fontSize: 12.5)));
    } else if (b.ownerKind == 1) {
      units.add(unitChip(0, owner, owner != null ? '${owner.name} (propriétaire)' : 'ménage disparu'));
    } else if (b.ownerKind == 2) {
      units.add(Text('Saisi : vide jusqu’à sa vente.', style: TextStyle(color: pal.ink2, fontSize: 12.5)));
    } else if (!b.habitable) {
      units.add(Text('Inhabitable : personne n’y loge.', style: TextStyle(color: pal.bad, fontSize: 12.5)));
    } else if (occ.exact) {
      units.add(Wrap(spacing: 5, runSpacing: 5, children: [
        for (var i = 0; i < b.units; i++)
          i < tenants.length ? unitChip(i, tenants[i], tenants[i].name) : unitChip(i, null, 'vacant'),
      ]));
    } else {
      units.add(Text(
          '$used logement${used > 1 ? 's' : ''} sur ${b.units} occupé${used > 1 ? 's' : ''} (estimation) : les locataires ne sont '
          'rattachés à un logement précis qu’avec les types de bâtiments et les baux.',
          style: TextStyle(color: pal.ink2, fontSize: 12.5)));
    }

    return ListView(padding: const EdgeInsets.all(16), shrinkWrap: true, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        buildingSprite(b, 112),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(kindName(b), style: TextStyle(color: pal.ink, fontSize: 17, fontWeight: FontWeight.w800)),
            Text('n° ${b.id} · construit le jour ${b.builtDay}', style: TextStyle(color: pal.ink3, fontSize: 12)),
            const SizedBox(height: 6),
            Pill(st.label, st.color),
            const SizedBox(height: 6),
            Text(
                '${b.units} logement${b.units > 1 ? 's' : ''} · ${sim.modulesOf(b)} modules'
                '${kindInfo != null ? ' · ${kindInfo.crew} par jour de chantier' : ''}',
                style: TextStyle(color: pal.ink2, fontSize: 12)),
          ]),
        ),
        IconButton(
            tooltip: 'Fermer', onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close, size: 18)),
      ]),
      const SizedBox(height: 12),
      Section('Logements (${b.done ? '$used / ${b.units} occupés' : 'chantier'})', units),
      Section('Propriétaire', [
        KV(b.ownerKind == 0 ? 'Bailleur' : (b.ownerKind == 1 ? 'Ménage' : 'Liquidation'), ownerLabel(sim, b)),
        if (landlord != null && rent != null) KV('Loyer du bailleur', '${money(rent)} / jour par logement'),
        if (owner != null) KV('Argent du ménage', money0(owner.money)),
        if (landlord != null || owner != null)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
                onPressed: () => _open(context, Selection(landlord != null ? 'firm' : 'citizen', landlord?.id ?? owner!.id)),
                child: Text(landlord != null ? 'Voir le bailleur' : 'Voir le ménage')),
          ),
      ]),
      Section('Valeur', [
        if (!b.done) KV('Avancement', '${b.modules} / ${sim.modulesOf(b)} modules  (${pct(b.modules / sim.modulesOf(b))})'),
        if (!b.done) KV('Dépensé jusqu’ici', money0(b.basis)),
        if (b.done) ...[
          KV('État', pct(b.cond), color: b.habitable ? null : pal.bad),
          KV('Valeur courante', money0(fair)),
          KV('Coût de remplacement (neuf)', money0(sim.buildingCost(b))),
          KV('Payé ou dépensé par le propriétaire', money0(b.basis)),
          if (b.listedDay != null) KV('Prix demandé aujourd’hui', money0(sim.askPrice(b)), color: pal.accent),
          if (landlord != null && rent != null && fair > 0)
            KV('Rendement brut annuel (plein)', pct(rent * b.units * 365 / fair)),
        ],
      ]),
      Section('Hypothèque', [
        if (m == null) Text('Aucune hypothèque sur ce bien.', style: TextStyle(color: pal.ink2, fontSize: 12.5)),
        if (m != null) ...[
          KV('Capital dû', money0(m.principal)),
          if (fair > 0) KV('Rapport dette / valeur', pct(m.principal / fair), color: m.principal > fair ? pal.bad : null),
          KV('Taux annuel', pct(m.rate)),
          KV('Versement quotidien', money(m.payment)),
          KV('Jours restants', '${m.termLeft}'),
          KV('Jours de retard', '${m.missed}', color: m.missed > 0 ? pal.bad : null),
        ],
      ]),
      Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
            onPressed: () => _open(context, Selection('building', b.id)),
            icon: const Icon(Icons.open_in_new, size: 16),
            label: const Text('Fiche complète dans l’inspecteur')),
      ),
    ]);
  }
}
