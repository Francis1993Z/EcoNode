# Bâtiments, construction et hypothèques (module `buildings`)

Branche `feature/batiments-hypotheques` (base : `main` au commit 7b6c5dc).

> **Rien de ce code n'a été compilé ni exécuté.** Le SDK Dart/Flutter était inaccessible à l'environnement de rédaction
> (téléchargement refusé). Le module est coupé par défaut (`Modules.buildings = false`), donc une partie ordinaire n'est pas
> censée changer ; mais il faut lancer les vérifications ci-dessous avant de fusionner.

## Ce que le module ajoute

- **Bâtiments** (`Building`) : un logement = 10 modules de construction ; état de 0 à 1 qui s'use de 4 %/an, entretenu par
  des heures de réparation (compensent 75 % de l'usure) ; sous 0,3 d'état, inhabitable.
- **Bailleurs** : l'entreprise « Immobilier » possède son parc, loue des nuitées (sa capacité = nombre de logements
  habitables), met quelques logements en vente et fait construire quand la demande dépasse le parc.
- **Construction** : nouvelle entreprise `construction` (bien non échangeable `batiment`, vendu en modules, un module par
  jour et par chantier, ce qui lui donne un revenu continu).
- **Hypothèques** (`Mortgage`) : prêt de la Caisse populaire garanti par le bâtiment. L'octroi crée de la monnaie,
  chaque remboursement de capital la détruit, les intérêts vont aux fonds propres, les intérêts impayés sont capitalisés.
  Taux = taux de base + prime croissante avec le LTV.
- **Ménages propriétaires** : un locataire en emploi qui « veut posséder » regarde le marché de temps en temps, achète si
  mise de fonds + coussin de 10 jours, service de la dette sous 35 % du revenu (filet I4) et sous 1,2 × le loyer,
  fonds propres de la Caisse suffisants. Un propriétaire-occupant ne paie plus de nuitée, entretient, peut revendre
  (gain ou perte comptés).
- **Saisie** : après 60 jours de retard, le bâtiment passe en liquidation ; la dette reste inscrite jusqu'à la vente
  (aucune radiation avant). Le produit de la vente rembourse le capital, le surplus revient à l'ancien propriétaire (ou à
  l'État), le solde non couvert est radié des fonds propres.
- **Nettoyage** : fermeture d'un bailleur ou départ d'un citoyen → ses bâtiments passent en liquidation ; les chantiers
  inachevés sont abandonnés.

## Choix de comptabilité

- Tous les flux passent par `transfer()` et les compteurs de la Caisse existants (`lent`, `repaid`, `interest`,
  `capitalized`, `writtenOff`) ; aucun nouveau champ de `DayFlows`.
- `totalDebt()` est maintenant **pondérée par le risque** (hypothèques à 35 %, comme Bâle III standard) : sans cela
  la Caisse ne pourrait financer qu'une poignée de logements. `totalLoans()` donne le nominal et sert à l'invariant `inv.loans`.
- Convention du moteur conservée : taux annuel / 365, durées en jours réels (pas de « année financière » raccourcie).
- Désactivé : aucune entreprise de construction, aucun bâtiment ; `f.carry` = 0 et `f.reinvest` = 0 ajoutent exactement 0.

## Fichiers

| Fichier | Changement |
|---|---|
| `lib/engine/buildings.dart` | **nouveau** : toute la logique (marché, hypothèques, saisie, chantiers) |
| `lib/engine/model.dart` | `Good.tradable`, bien `batiment`, gabarit `construction`, `Params` (voir ci-dessous), `Modules.buildings`, `Building`, `Mortgage`, champs `Citizen.homeId/wantsToOwn`, `Firm.carry/reinvest` |
| `lib/engine/sim.dart` | état, flux `logement`, crochets dans `step()`, `totalDebt/totalLoans`, biens non échangeables, nettoyage à la fermeture |
| `lib/engine/snapshot.dart` | sérialisation (rétrocompatible : anciennes sauvegardes lisibles), empreinte `batiments` seulement si le parc existe |
| `test/batiments_test.dart` | **nouveau** : 18 tests |

## Paramètres ajoutés (`Params`)

| Paramètre | Défaut | Rôle |
|---|---|---|
| `dwellingModules` | 10 | modules par logement |
| `buildingWearYear` / `buildingMaintShare` | 4 % / 75 % | usure annuelle / part compensée par l'entretien |
| `maintHoursPerDwelling` | 0,012 | heures de réparation par logement et par jour |
| `ltvHousehold` / `ltvFirm` | 95 % / 70 % | prêt max. ménage / bailleur |
| `mortgageSpreadMax` | 2 % | prime max. au-dessus du taux de base |
| `mortgageTermHousehold` / `mortgageTermFirm` | 9125 j (25 ans) / 3650 j | amortissement |
| `mortgageRiskWeight` | 0,35 | pondération des hypothèques dans les fonds propres exigés |
| `foreclosureDays` | 60 | jours de retard avant saisie |
| `ownerShare` | 0,7 | part des citoyens qui veulent posséder |
| `buyLookChance` / `relocateChance` | 0,02 / 0,0005 | regard sur le marché / mise en vente par jour |
| `listingMargin` / `listingDecay` / `listingFloor` | 5 % / 0,5 %/j / 0,7 | prix demandé |
| `landlordBuildAbove` | 0,96 | seuil d'occupation qui déclenche un chantier |
| `buyRentRatio` | 1,2 | versement max. en multiple du loyer |

## À lancer (obligatoire)

```
dart analyze
flutter test test/batiments_test.dart
flutter test                      # surtout proprietes_test (tire tous les modules au hasard) et instantane_test
dart run tool/stabilite.dart --compare          # référence, module coupé : doit être identique à main
dart run tool/stabilite.dart --compare buildings=1
```

Attendre : erreurs de compilation possibles n'importe où ; si `proprietes_test` ou la stabilité divergent module coupé,
c'est un défaut des crochets de `sim.dart`, pas du module.

## Hypothèses de calibration à valider

1. **Prix du module** : une seule entreprise de construction, un employé : l'échelle minimale (`_minScale`) peut
   gonfler le prix du module et donc celui du logement (visé : 5 à 8 ans de loyer).
2. **Capacité de la Caisse** : ~20 hypothèques au départ avec la pondération à 35 % ; si le marché reste vide, ajuster
   `mortgageRiskWeight` ou `ltvHousehold`.
3. **Loyer vs achat** : `buyRentRatio` = 1,2 ; si personne n'achète (`bstats.sales` = 0), le relever.
4. **Bailleurs** : la trésorerie qu'ils accumulent par les ventes (`reinvest` la retient des dividendes) peut creuser le Gini.
5. **Demande de construction par rafales** : alertes `stockVide` possibles pour l'entreprise de construction (bien non périssable).
6. Le test « calibration » peut échouer sans que le moteur soit faux.

## Limites connues

- Le god mode `godFirm` sur la capacité d'un bailleur est écrasé chaque matin (la capacité suit le parc) ;
  un bailleur ajouté par le god mode démarre à capacité 0.
- Avec le module actif, `_entryExit` ne fonde plus de nouveaux bailleurs (une ligne dans `sim.dart`) : à reconcilier avec
  le travail en cours sur la création d'entreprise réaliste (conflit possible sur `_entryExit`/`_found`).
- Pas de cartes ni d'écran Flutter pour le parc : seules `bstats` et la trace (`credit`, `compta`) rendent compte du marché.
