part of 'sim.dart';

// Renaissance des filières (Params.revival). Voir MODELE.md § 6.22.
//
// La création automatique (`_entryExit`) et le module entrepreneurship ne lisent qu'un signal : la demande non servie
// (`unmetEma`), notée quand un acheteur ne trouve aucune offre. Un bien qui n'a plus de producteur actif cesse vite de
// l'envoyer :
// - frontières ouvertes, l'importation est une offre sans limite : rien n'est jamais « non servi », même quand les
//   transformateurs paient leurs intrants 1,3 fois le prix mondial ;
// - en économie fermée, un transformateur privé d'intrant ne produit plus, son plan de production tombe à zéro et il
//   n'achète plus rien : la demande dérivée disparaît avec lui, puis il ferme (fonderie de puces → or, cuivre,
//   conception ; ordinateurs → processeurs…).
// Avec la règle, le signal d'entrée d'un bien sans producteur actif est le plus grand de trois mesures, en unités par jour :
// la demande non servie, les importations lissées (même lissage, ~10 jours) et la demande dérivée (ce que les équipes,
// postes ouverts compris, des entreprises qui utilisent le bien comme intrant pourraient transformer par jour). Rien
// d'autre ne change : le projet passe ensuite par les mêmes conditions que toute création (main-d'œuvre, viabilité au
// prix du marché — l'importation frontières ouvertes —, capital, délai entre deux créations d'un même type).

extension SimRevival on Sim {
  /// Le bien a-t-il au moins un producteur actif (une entreprise qui le produit et qui a au moins un employé) ?
  bool hasActiveProducer(String g) => sellersOf(g).any((f) => f.workers.isNotEmpty);

  /// Demande dérivée d'un bien : ce que les équipes (employés et postes ouverts) des entreprises qui l'utilisent comme
  /// intrant transformeraient par jour, à leur productivité du moment.
  double derivedWant(String g) {
    var w = 0.0;
    for (final f in firms) {
      final per = f.inputs[g];
      if (per == null) continue;
      final crew = f.workers.length + f.vacancies;
      if (crew <= 0) continue;
      w += _capBatches(f, crew * perWorker(f)) * per;
    }
    return w;
  }

  /// Relance à temps partiel (Params.revivalHours, variante coupée par défaut) : la création de ce bien en est-elle une ?
  bool revivesByHours(String g) => params.revival && params.revivalHours && params.partTime && !hasActiveProducer(g);

  /// Coût quotidien du travail d'une création, pour sa viabilité : [team] employés entiers, ou, pour une relance à temps
  /// partiel, les heures nécessaires à [w] employés de productivité nominale (au moins Sim.minHours, au plus l'équipe).
  double entryLabour(String g, double w, int team, double wage) =>
      revivesByHours(g) ? wage * w.clamp(Sim.minHours, team.toDouble()) : team * wage;

  /// Signal d'entrée d'un bien sans producteur actif (0 si le bien a un producteur actif, ou sans la règle).
  double revivalWant(String g) {
    if (!params.revival || hasActiveProducer(g)) return 0;
    return math.max(unmetEma[g] ?? 0, math.max(importEma[g] ?? 0, derivedWant(g)));
  }

  /// Fin de journée : importations du jour, par bien, lissées comme la demande non servie (α = 0,1). Lues dans les flux
  /// du jour (l'étranger est le nœud « X »).
  void _revivalEvening() {
    final today = <String, double>{};
    for (final e in flows.values) {
      if (e.from == 'X' && goods.containsKey(e.good)) today[e.good] = (today[e.good] ?? 0) + e.qty;
    }
    for (final g in {...importEma.keys, ...today.keys}) {
      final v = 0.9 * (importEma[g] ?? 0) + 0.1 * (today[g] ?? 0);
      if (v < 1e-9) {
        importEma.remove(g);
      } else {
        importEma[g] = v;
      }
    }
  }
}
