// Contrôle de la liste des vendeurs disponibles à plus grande échelle que les tests : parties complètes avec
// `verifyFastPaths` (avant chaque achat de ménage : la liste de chaque bien est exactement l'ensemble des entreprises
// actives avec une unité en stock, et un achat d'une unité sans offre n'a lieu que si aucun autre vendeur n'a une unité),
// plus la liste vérifiée après chaque jour. Lent : le contrôle avant chaque achat parcourt toutes les entreprises.
//
//   dart run tool/vendeurs_verif.dart 3000 150 3     (population, jours, k)

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

void main(List<String> a) {
  final pop = int.parse(a[0]), days = int.parse(a[1]), k = int.parse(a[2]);
  for (final seed in [1, 2]) {
    for (final nets in [false, true]) {
      final s = Sim(
          seed: seed,
          params: Params()
            ..population = pop
            ..sellerSample = k,
          safeguards: nets ? Safeguards() : Safeguards.none(),
          devChecks: true)
        ..verifyFastPaths = true;
      for (var d = 0; d < days; d++) {
        s.step();
        final bad = s.availMismatches();
        if (bad.isNotEmpty) throw StateError('jour ${s.day} : $bad');
      }
      print('population $pop, k $k, graine $seed, filets $nets : $days jours, liste exacte avant chaque achat et chaque '
          'jour, aucune fausse pénurie');
    }
  }
}
