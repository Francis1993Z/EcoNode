// Paramètres numériques du modèle qu'on peut faire varier par nom (criblage de Morris, hypercube latin, --param), avec leur
// plage d'exploration. Les plages sont de l'ordre de ×0,5 à ×2 autour de la valeur par défaut : elles servent à repérer les
// paramètres qui comptent, pas à dire quelles valeurs sont réalistes. Un paramètre entier est arrondi.

import 'package:econodes/engine/model.dart';

class ParamDef {
  final String nom;
  final String label;
  final double bas, haut; // plage d'exploration
  final double Function(Params) lire;
  final void Function(Params, double) ecrire;
  final bool entier;
  const ParamDef(this.nom, this.label, this.bas, this.haut, this.lire, this.ecrire, {this.entier = false});

  /// Valeur à la position u de la plage (0 : bas, 1 : haut).
  double valeur(double u) {
    final v = bas + (haut - bas) * u;
    return entier ? v.roundToDouble() : v;
  }
}

final List<ParamDef> parametresCalibrables = [
  ParamDef('markup', 'Marge visée sur le coût de revient', 0.9, 1.5, (p) => p.markup, (p, v) => p.markup = v),
  ParamDef('mpcIncome', 'Propension à consommer le revenu', 0.3, 0.9, (p) => p.mpcIncome, (p, v) => p.mpcIncome = v),
  ParamDef('priceStep', 'Pas d’ajustement des prix', 0.01, 0.04, (p) => p.priceStep, (p, v) => p.priceStep = v),
  ParamDef('wageStep', 'Pas d’ajustement des salaires', 0.0075, 0.03, (p) => p.wageStep, (p, v) => p.wageStep = v),
  ParamDef('priceMaxDaily', 'Variation maximale des prix par jour', 0.0075, 0.03, (p) => p.priceMaxDaily,
      (p, v) => p.priceMaxDaily = v),
  ParamDef('wageMaxDaily', 'Variation maximale des salaires par jour', 0.0075, 0.03, (p) => p.wageMaxDaily,
      (p, v) => p.wageMaxDaily = v),
  ParamDef('dividendRate', 'Part de la trésorerie versée en dividendes', 0.04, 0.16, (p) => p.dividendRate,
      (p, v) => p.dividendRate = v),
  ParamDef('jobSwitch', 'Chance quotidienne de changer d’emploi', 0.015, 0.06, (p) => p.jobSwitch, (p, v) => p.jobSwitch = v),
  ParamDef('taxRate', 'Taux d’imposition', 0.06, 0.24, (p) => p.taxRate, (p, v) => p.taxRate = v),
  ParamDef('benefit', 'Prestation de base (\$ par jour)', 40, 160, (p) => p.benefit, (p, v) => p.benefit = v),
  ParamDef('interestRate', 'Taux d’intérêt annuel', 0.03, 0.12, (p) => p.interestRate, (p, v) => p.interestRate = v),
  ParamDef('entryCooldown', 'Délai entre deux créations d’un même type (jours)', 30, 120, (p) => p.entryCooldown.toDouble(),
      (p, v) => p.entryCooldown = v.round(),
      entier: true),
  ParamDef('entryMinShare', 'Demande non servie qui déclenche une création', 0.05, 0.2, (p) => p.entryMinShare,
      (p, v) => p.entryMinShare = v),
];

/// Applique « nom=valeur » si le nom est un paramètre calibrable ; rend faux sinon.
bool appliquerParametre(Params p, String nom, String valeur) {
  for (final d in parametresCalibrables) {
    if (d.nom == nom) {
      d.ecrire(p, double.parse(valeur));
      return true;
    }
  }
  return false;
}
