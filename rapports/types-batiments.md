# Types de bâtiments et onglet Parc (`Params.buildingTypes`)

Branche `feature/types-batiments`, partie de `main` à `f55bcca`. Règle coupée par défaut dans le moteur, active dans
l'interface. Coupée, rien ne change : `bash tool/reference.sh --verifier` dit « RÉFÉRENCE : IDENTIQUE (32 éléments) » (sur
le serveur de calcul), la parité PC ↔ serveur (`tool/parite_serveur.sh`) aussi (40 fichiers sur 40, 0 différence au
niveau 0). Documentation du modèle : MODELE.md § 6.6 (« Types de bâtiments »).

Demande de Francis : un panneau pour voir les bâtiments construits, plusieurs sortes de bâtiments (petite, moyenne et
grande maison, immeubles d'un, deux et trois étages, multilogement, duplex), un sprite par type, sans distance physique
entre les bâtiments : une façon d'explorer le parc. Choix : de vrais types dans le modèle, pas des étiquettes.

## 1. Règle

Huit types (`model.dart:buildingKinds`), avec leur nombre de logements, leur taille en logements standards (qui fixe les
modules de construction, donc le coût et la durée du chantier, la valeur, l'entretien et la provision pour l'usure) et
leur cadence de chantier :

| Type | Logements | Taille | Modules | Modules / jour | Chantier |
|---|---|---|---|---|---|
| Petite maison | 1 | 0,8 | 8 | 1 | 8 j |
| Maison moyenne | 1 | 1 | 10 | 1 | 10 j |
| Grande maison | 1 | 1,5 | 15 | 1 | 15 j |
| Duplex | 2 | 1,8 | 18 | 1 | 18 j |
| Immeuble d'un étage | 4 | 3,4 | 34 | 2 | 17 j |
| Immeuble de deux étages | 8 | 6,4 | 64 | 2 | 32 j |
| Immeuble de trois étages | 12 | 9 | 90 | 3 | 30 j |
| Multilogement | 24 | 16,8 | 168 | 4 | 42 j |

Ces valeurs sont des choix de jeu (économies d'échelle : 8 à 15 modules par logement pour une maison, 7 à 8,5 pour un
immeuble), pas une calibration.

- **Logements et baux.** Les logements des bâtiments habitables d'un bailleur font sa capacité, donc la limite de ses
  baux. La valeur d'un immeuble garantit son hypothèque et entre dans le coût du capital du loyer.
- **Achats.** Les ménages n'achètent que des maisons, la plus chère que leurs moyens permettent ; ils comparent la
  mensualité au loyer d'un logement de même taille. Un bailleur ne met en vente que des maisons.
- **Immeubles saisis.** Un duplex ou un immeuble en liquidation est racheté par le bailleur qui manque le plus de
  logements (mise de fonds de 30 %, le reste prêté par la Caisse). Sans cette règle, il resterait vide et sans entretien :
  aucun ménage ne l'achète.
- **Construction.** Le bailleur à qui il manque n logements lance le plus grand duplex ou immeuble d'au plus n logements
  dont il peut payer sa part ; à défaut, une maison (petite, moyenne ou grande au hasard).
- **Parc de départ.** Assez de maisons pour les ménages qui veulent posséder et ont un emploi, plus 5 % ; le reste en
  duplex et en immeubles. À 2 500 citoyens (graine 3) : 1 728 maisons et 118 duplex ou immeubles, dont 12 multilogements,
  pour 2 650 logements ; à 240 citoyens : 179 maisons et 13 duplex ou immeubles.
- **Locataires rattachés.** Avec les baux, chaque locataire est rattaché chaque soir à un logement de son bailleur
  (gardé tant qu'il tient, sinon le premier logement libre). Affichage seulement : rien d'autre dans le moteur ne le lit.

Coupée, un bâtiment n'a pas de type : un logement standard de `dwellingModules` modules. Toutes les formules gardent
exactement les mêmes opérations dans ce cas (la taille vaut 1,0 et un bâtiment compte 1 logement), d'où la référence
identique.

## 2. Onglet Parc

Nouvel onglet du panneau latéral (`lib/ui/parc_tab.dart`) :

- interrupteur des types de bâtiments ;
- totaux par type : bâtiments, logements, part occupée, logements vacants, chantiers ; logements habitables,
  propriétaires-occupants, sans-abri (dont avec un emploi) ; toucher une ligne filtre la grille ;
- filtres d'état : habités, avec logements vacants, propriétaires-occupants, en vente, saisis, chantiers, inhabitables ;
- grille de bâtiments, sans carte : sprite, numéro, occupation (ou avancement du chantier), pastille d'état ; un bâtiment
  inhabitable est grisé ;
- fiche au toucher : logements avec le nom de chaque locataire ou de l'occupant (toucher un nom ouvre le citoyen),
  propriétaire, loyer, valeur courante, coût de remplacement, rendement, hypothèque, lien vers la fiche de l'inspecteur.

Sans locataires rattachés (types ou baux coupés), l'occupation des bâtiments des bailleurs est estimée et l'onglet le dit.
La fiche d'un bâtiment de l'inspecteur, la section du bailleur et la fiche d'un citoyen (« Loue un logement dans… »)
tiennent aussi compte des types. Captures : `rapports/donnees/types-batiments/`.

**Sprites** (`assets/batiments/`, déclarés dans `pubspec.yaml`) : générés avec le MCP Sprite-AI, isométriques, 128 × 128,
même description de matériaux pour tous (murs beiges, toit gris foncé, cadres blancs, socle d'herbe), plus un chantier
(charpente et échafaudage sur terre battue). L'immeuble d'un étage est sorti avec deux rangées de fenêtres ; une deuxième
génération était moins bonne (une maison), la première est gardée. 10 jetons dépensés sur 100.

## 3. Mesure

Serveur de calcul, révision `6bf94cf79a90`, sonde `tool/parc.dart` (lecture seule) : réglages de l'interface
(`parametresInterface`) avec le module Bâtiments, Banques coupées, 10 graines appariées × 3 000 jours, types coupés
(`--param buildingTypes=0`) contre types actifs. Moyennes des jours 101 à 3 000, médianes sur les graines, écart médian
par graine avec son intervalle de confiance bootstrap à 95 % (* : l'intervalle exclut 0). Sept parties (graines 9 et 10)
ont été tuées à la fermeture de la session tmux du lot et rejouées à l'identique. Données : `rapports/donnees/types-batiments/`.

| 2 500 citoyens | sans types | avec types | écart médian par graine [IC 95 %] | mieux avec types |
|---|---|---|---|---|
| Sans-abri moyen | 0,00 | 0,00 | 0,00 [−0,02 ; 0,00] | — |
| Sans-abri au plus haut | 0 | 0 | 0 [−4 ; 0] | — |
| Chômage moyen | 6,0 % | 4,2 % | **−1,7 pt** * [−2,5 ; −1,0] | 10 / 10 |
| Indice des prix au jour 250 (départ = 1) | 1,50 | 1,65 | +0,14 * [0,09 ; 0,23] | |
| Indice des prix au plus haut | 1,86 | 2,40 | +0,50 * [0,33 ; 0,63] | |
| Indice des prix final | 1,71 | 2,28 | **+0,50** * [0,36 ; 0,77] | |
| Salaire moyen | 313 $ | 419 $ | +100 $ * | |
| Prix de vente d'une maison (lissé, final) | 17 142 $ | 36 532 $ | +19 764 $ * | |
| Maison en jours de salaire (final) | 50 | 72 | +25 * | |
| Ventes de logements (3 000 j) | 710 | 1 104 | | |
| Part de propriétaires | 69 % | 70 % | 0 | |
| Chantiers terminés | 22 | 44 | +20 * | |

| 240 citoyens | sans types | avec types | écart médian par graine [IC 95 %] | mieux avec types |
|---|---|---|---|---|
| Sans-abri moyen | 0,00 | 0,01 | 0,00 [−0,01 ; 0,01] | — |
| Sans-abri au plus haut | 1 | 1 | 0 [−1 ; 1] | — |
| Chômage moyen | 5,2 % | 3,7 % | **−1,3 pt** * [−1,8 ; −0,8] | 9 / 10 |
| Indice des prix au jour 250 | 1,53 | 1,72 | +0,27 * [0,06 ; 0,39] | |
| Indice des prix final | 1,58 | 2,62 | **+1,13** * [0,65 ; 1,78] | |
| Salaire moyen | 264 $ | 441 $ | +142 $ * | |
| Prix de vente d'une maison (lissé, final) | 24 089 $ | 38 178 $ | +13 722 $ * | |
| Maison en jours de salaire (final) | 91 | 70 | −19 [−27 ; 15] | |
| Ventes de logements (3 000 j) | 50 | 117 | | |
| Chantiers terminés | 2 | 2 | 0 | |

- **Sans-abri** : aucun, avec ou sans types (les baux avaient déjà réglé A6).
- **Chômage** : plus bas avec les types, concluant aux deux tailles.
- **Prix** : plus hauts avec les types, concluant aux deux tailles, dès le démarrage (la hausse des 250 premiers jours,
  reste de N4, passe d'≈ 50 % à 65-72 %), puis jusqu'à la fin.
- **Mécanisme** (à confirmer par une variante) : à part de propriétaires égale, il y a 1,6 à 2,3 fois plus de ventes de
  maisons. Sans types, un acheteur ne regarde que la maison en vente la moins chère et il est souvent refusé ; avec les
  types, il prend la plus chère qu'il peut payer, donc il en trouve presque toujours une. Chaque revente d'une maison de
  départ (payée, sans dette) est financée à 95 % par une hypothèque, c'est-à-dire par de la monnaie nouvelle, et les
  hypothèques sont plus grosses (maison vendue 17 000 → 37 000 $ à 2 500 citoyens). Plus de monnaie, plus de dépense :
  moins de chômage, plus d'inflation.
- **Parc final** (2 500 citoyens, médiane) : 620 petites, 792 moyennes et 356 grandes maisons, 30 duplex, 34, 34 et
  20 immeubles d'un, deux et trois étages, 10 multilogements ; 99,7 à 100 % des locataires rattachés à un logement
  (98,6 à 100 % à 240 citoyens). À 240 citoyens, les bailleurs ne construisent presque rien (2 chantiers en 3 000 j,
  avec ou sans types) : l'entreprise de construction peut disparaître faute de commandes.
- **Immeubles saisis rachetés, saisies** : aucun dans les 40 parties ; la règle n'est exercée que par le test
  `types_batiments_test.dart`.
- **Aller-retour d'instantané** (`tool/allerretour.dart`, 400 citoyens, 200 + 150 j) : IDENTIQUE sans Bâtiments, avec
  Bâtiments sans types, avec Bâtiments et types (121 baux, tous rattachés).
- **Non mesuré** : avec les Banques (retiré pour garder le lot sous 30 minutes).

### Variante : la maison la moins chère (`cheapestHouse`)

Demandée par Francis, jouée sur son PC (16 processeurs logiques, 12 parties à la fois, 6 minutes ; la parité PC ↔
serveur étant identique au bit près, ces parties se comparent graine par graine à celles du serveur). Avec les types, un
ménage tente la maison en vente la moins chère, comme sans les types. Mêmes réglages, mêmes 10 graines × 3 000 j.
Données : `rapports/donnees/types-batiments/variante/`, tableau complet : `analyse-variante.md`.

| 2 500 citoyens | sans types | types, plus chère | types, moins chère | moins chère − sans types | moins chère − plus chère |
|---|---|---|---|---|---|
| Chômage moyen | 6,0 % | 4,2 % | 5,6 % | −0,8 pt [−1,2 ; 0,1] (7 / 10) | **+1,0 pt** * [0,6 ; 2,0] |
| Indice des prix au jour 250 | 1,50 | 1,65 | 1,47 | −0,04 [−0,07 ; 0,03] | −0,16 * |
| Indice des prix final | 1,71 | 2,28 | 1,78 | +0,04 [−0,26 ; 0,21] | **−0,56** * [−0,80 ; −0,35] |
| Salaire moyen | 313 $ | 419 $ | 334 $ | +10 $ | −84 $ * |
| Prix d'une maison (final) | 17 142 $ | 36 532 $ | 14 715 $ | −2 477 $ * | −21 502 $ * |
| Maison en jours de salaire | 50 | 72 | 42 | −12 * | −30 * |
| Ventes de logements | 710 | 1 104 | 894 | | |
| Chantiers terminés | 22 | 44 | 54 | +30 * | +10 |
| Achats refusés | 0 | 18 | 121 | | |

| 240 citoyens | sans types | types, plus chère | types, moins chère | moins chère − sans types | moins chère − plus chère |
|---|---|---|---|---|---|
| Chômage moyen | 5,2 % | 3,7 % | 4,4 % | **−0,8 pt** * [−1,7 ; −0,3] (10 / 10) | +0,1 pt [−0,5 ; 1,0] |
| Indice des prix au plus haut | 1,93 | 2,96 | 2,20 | +0,41 * | −0,57 * |
| Indice des prix final | 1,58 | 2,62 | 2,01 | **+0,53** * [0,19 ; 0,90] | −0,53 [−1,05 ; 0,25] |
| Prix d'une maison (final) | 24 089 $ | 38 178 $ | 22 286 $ | −1 514 $ * | −15 949 $ * |
| Ventes de logements | 50 | 116 | 88 | +40 * | |

- **À 2 500 citoyens, la règle d'achat explique tout.** Avec « la moins chère », les types ne changent ni le chômage
  ni les prix de façon concluante ; avec « la plus chère abordable », le chômage baisse d'un point de plus et les prix
  montent d'un tiers. La baisse du chômage et l'inflation viennent ensemble des reventes à crédit plus nombreuses et
  plus grosses (la monnaie créée par les hypothèques).
- **À 240 citoyens, les types eux-mêmes jouent un peu** : même avec « la moins chère », chômage −0,8 pt et indice final
  +0,5 (les petites maisons, moins chères, se revendent plus souvent : 50 → 88 ventes). La règle « la plus chère » ajoute
  de l'inflation sans baisser davantage le chômage.
- Les maisons coûtent moins cher en jours de salaire avec « la moins chère » (42 à 2 500 citoyens, 60 à 240), plus loin
  de la cible de ≈ 90 jours.

## 4. À décider

1. Règle d'achat dans l'interface : « la plus chère abordable » (actuelle : chômage −1,7 pt, prix +33 % à 2 500
   citoyens) ou « la moins chère » (`cheapestHouse` : les types ne changent presque rien à l'économie à 2 500 citoyens).
2. Mesurer Bâtiments × Banques avec les types (la combinaison qui faisait exploser les prix avant N4).
3. Calibration ouverte : une maison vaut 50 à 90 jours de salaire selon la taille et la partie ; les valeurs des types
   (tailles, cadences) sont des choix de jeu.
