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
  /// intrant transformeraient par jour, à leur productivité du moment. Params.revivalPlannedDemand : au plus leur plan de
  /// production (`_plannedBatches`, tiré de la demande de leurs propres produits), ce qu'elles achèteraient vraiment.
  double derivedWant(String g) {
    var w = 0.0;
    for (final f in firms) {
      final per = f.inputs[g];
      if (per == null) continue;
      final crew = f.workers.length + f.vacancies;
      if (crew <= 0) continue;
      var b = _capBatches(f, crew * perWorker(f));
      if (params.revivalPlannedDemand) b = math.min(b, _plannedBatches(f));
      w += b * per;
    }
    return w;
  }

  /// Relance à temps partiel (Params.revivalHours, variante coupée par défaut) : la création de ce bien en est-elle une ?
  bool revivesByHours(String g) => params.revival && params.revivalHours && params.partTime && !hasActiveProducer(g);

  /// Coût quotidien du travail d'une création, pour sa viabilité : [team] employés entiers, ou, pour une relance à temps
  /// partiel, les heures nécessaires à [w] employés de productivité nominale (au moins Sim.minHours, au plus l'équipe).
  double entryLabour(String g, double w, int team, double wage) =>
      revivesByHours(g) ? wage * w.clamp(Sim.minHours, team.toDouble()) : team * wage;

  /// Frais fixes quotidiens attendus d'une entreprise de type [ty] qui démarre avec [team] employés et un prêt [loan] :
  /// comptabilité et entretien des opérations, aux quantités qu'achète `_buyServices`, et intérêts du prêt au taux de
  /// base. Une entreprise neuve n'a pas de machines : ni entretien de machines ni usure.
  double entryFixedCost(String ty, int team, double loan) {
    final t = templates[ty]!;
    var fixed = loan * baseRate() / 365;
    if (modules.accounting && !t.outputs.containsKey('compta')) fixed += (0.1 + 0.03 * team) * bestPrice('compta');
    final mt = t.maint;
    if (modules.capital && mt != null && t.heavy && !t.outputs.containsKey(mt)) fixed += 0.06 * team * bestPrice(mt);
    return fixed;
  }

  /// Params.revivalFullCost : cause du refus d'une relance au coût complet, ou null (relance acceptée, bien qui a un
  /// producteur actif, ou variante coupée). [w] : employés nécessaires à productivité nominale ; [labour] : coût du
  /// travail du test de viabilité ordinaire ; [revenue0] : ventes attendues au prix du marché.
  /// - viabilite : les ventes attendues ne paient pas 1,1 fois l'équipe, ses intrants et ses frais fixes ;
  /// - prix_import : frontières ouvertes, le prix de départ d'un extrant importable (coût complet par unité × markup,
  ///   coût du travail compté comme le fera `unitCost`) dépasse son prix d'import.
  String? revivalCostRefusal(String ty, double w, int team, double wage, double labour, double inputCost,
      double revenue0, double loan) {
    final p = params;
    final t = templates[ty]!;
    if (!p.revival || !p.revivalFullCost || hasActiveProducer(t.outputs.keys.first)) return null;
    final fixed = entryFixedCost(ty, team, loan);
    if (revenue0 < 1.1 * (labour + inputCost + fixed)) return 'viabilite';
    if (!p.trade) return null;
    // unitCost, à temps partiel, ne compte que les heures nécessaires (au moins un employé : échelle minimale) ; sans
    // temps partiel, l'équipe entière
    final pay = p.partTime ? wage * math.max(w, math.max(1.0, team * Sim.minHours)) : team * wage;
    final batches = w * t.rate;
    final perBatch = (pay + inputCost + fixed) / batches;
    var tot = 0.0;
    for (final e in t.outputs.entries) {
      tot += e.value * worldPrice[e.key]!;
    }
    for (final e in t.outputs.entries) {
      final g = goods[e.key]!;
      if (g.perish || !g.tradable) continue;
      final share = tot > 0 ? e.value * worldPrice[e.key]! / tot : 1 / t.outputs.length;
      if (perBatch * share / e.value * p.markup > importPrice(e.key)) return 'prix_import';
    }
    return null;
  }

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
