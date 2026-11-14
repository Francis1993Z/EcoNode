# Tous les modules et le commerce extérieur actifs par défaut

Demande de Francis le 14 novembre 2026 : commerce extérieur ouvert et tous les modules actifs par défaut, dans l'interface
et sans elle ; la rénovation à toutes les tailles. Branche `feature/tout-actif`, partie de `feature/renovation`
(commit 34f967a).

## 1. Ce qui change

- `Modules()` : bâtiments, rôles, entrepreneuriat, produits, banques et rénovation actifs par défaut ; `Params().trade`
  aussi. L'interface reprend ces défauts (écran de départ, `SimController`), sans le seuil de 1 000 citoyens de la
  rénovation. `tool/derive.dart` aussi (`--param trade=0` pour fermer les frontières).
- `Modules.historique()` et `Params.historique()` rendent les anciens défauts. La batterie de parité les rejoue (option
  `--historique` de `partie` et `stabilite`, `parite.dart`) : **référence identique (32 éléments)**.
- Un instantané écrit avant le changement se relit avec ses modules récents coupés.
- Tests : ceux écrits pour les anciens défauts les épinglent ; `test/defauts_test.dart` vérifie les nouveaux défauts, une
  partie de 300 jours sans écart comptable et la relecture d'un ancien instantané. 112 tests passent.

## 2. Mesure

Sur le PC, 10 graines appariées × 3 000 jours, à 240, 1 000 et 2 500 citoyens, réglages de l'interface, filets actifs.
Trois configurations :

- **A**, les anciens défauts de l'interface : rôles, entrepreneuriat et produits, sans bâtiments, banques ni
  rénovation, frontières fermées ;
- **B**, les nouveaux défauts : tous les modules, frontières ouvertes ;
- **C**, tous les modules, frontières fermées, pour séparer l'effet des modules de celui du commerce.

Les 90 parties sont allées au bout. Données : `rapports/donnees/tout-actif/` (`releves.csv`, `agg.txt`, `agg.py`).

Moyennes des 10 graines sur les jours 1 001-3 000 :

| Citoyens | Config. | Chômage | Indice | Salaire | Gini | Graines en crise (chômage > 20 %) | Affamés |
|---|---|---|---|---|---|---|---|
| 240 | A | 4,7 % | 1,09 | 202 | 0,32 | 0 | 0 |
| 240 | B | 15,4 % | 4,04 | 642 | 0,43 | 9 | 3,1 |
| 240 | C | 4,0 % | 3,42 | 622 | 0,28 | 0 | 0 |
| 1 000 | A | 5,6 % | 1,17 | 215 | 0,43 | 0 | 0 |
| 1 000 | B | 11,6 % | 3,09 | 666 | 0,43 | 4 | 0,4 |
| 1 000 | C | 3,2 % | 2,64 | 532 | 0,32 | 0 | 0 |
| 2 500 | A | 6,1 % | 1,20 | 226 | 0,53 | 0 | 0 |
| 2 500 | B | 10,1 % | 1,76 | 389 | 0,59 | 4 | 0,4 |
| 2 500 | C | 3,0 % | 2,26 | 473 | 0,35 | 0 | 0 |

Écarts appariés :

- **Les modules aident (C − A)** : chômage − 0,7 point à 240 (plus bas dans 7 graines sur 10), − 2,4 à 1 000 et − 3,2 à
  2 500 (10 sur 10) ; Gini − 0,03 à − 0,17 ; aucune crise. Prix et salaires nominaux plus hauts (indice × 2 à 3) : la
  monnaie des hypothèques et du crédit.
- **Les frontières ouvertes nuisent (B − C)** : chômage + 11,4 points à 240, + 8,4 à 1 000, + 7,1 à 2 500, plus haut
  dans les 10 graines à chaque taille ; Gini + 0,11 à + 0,24 ; des crises (9 graines sur 10 à 240) et des affamés.
- **Entrepreneur général actif au jour 3 000** : 0 et 1 sur 10 à 240 (C, B), 6 et 7 sur 10 à 1 000, 10 et 9 sur 10 à
  2 500, comme attendu sans le seuil.

## 3. Diagnostic : qui perd face aux importations, et pourquoi

Francis garde les frontières ouvertes par défaut (14 novembre) et demande le diagnostic. Sonde `tool/commerce.dart` :
mêmes réglages que B et C, 4 graines à 240 et 1 000 citoyens, 2 à 2 500, 3 000 jours, frontières ouvertes et fermées ;
moyennes des jours 1 001-3 000. Sorties et agrégation : `rapports/donnees/tout-actif/commerce/` (`agg_c.txt`).

**Ce qui fixe le prix à l'import.** Prix mondial × 1,3 (`importMarkup`) × facteur des vagues (0,7 à 1,3) × taux de change
(× droit de douane, nul). Le prix mondial est celui du plan de départ et ne bouge jamais. L'export est payé prix mondial ×
0,7 × vagues × change. L'importation est une offre sans limite de quantité, à côté des vendeurs d'ici.

**1. Les prix relatifs d'ici s'éloignent des prix mondiaux, même frontières fermées.** Avec tous les modules, la monnaie du
crédit et des hypothèques fait monter les salaires et les prix (indice × 2 à 3), mais pas partout pareil : les biens faits
surtout de travail montent, ceux que les machines et la technologie rendent moins chers baissent. Prix d'ici rapporté au
prix mondial, frontières fermées :

| | Repas | Pain | Viande | Poisson | Céréales | Or | Bijoux | Pétrole | Carburant | Machines |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 000 citoyens | 2,73 | 2,91 | 2,53 | 2,47 | 2,75 | 0,46 | 0,56 | 1,15 | 1,13 | 1,25 |
| 2 500 citoyens | 2,45 | 2,44 | 2,19 | 2,09 | 2,28 | 0,27 | 0,41 | 0,56 | 0,77 | 0,98 |

Le pain coûte ici 6 à 9 fois plus que l'or, comparé au reste du monde. Dans la réalité, les mêmes gains de productivité se
font ailleurs aussi et les prix mondiaux suivent ; ici, ils restent ceux du jour 0.

**2. À 1 000 et 2 500 citoyens : un « syndrome hollandais ».** Frontières ouvertes, l'or, les bijoux, le pétrole et le
carburant, très bon marché ici, s'exportent en masse (à 2 500 : bijoux 45 000 $/j, carburant 43 000, pétrole 40 000, or
31 000 ; à 1 000 : bijoux 64 000, or 46 000). Ces recettes gardent le taux de change bas (0,7 à 1,6 en moyenne selon la
graine) alors qu'il faudrait environ 2,5 pour compenser l'écart de prix de la nourriture : elle s'importe :

| Bien (1 000 citoyens) | Part importée | Production par jour, ouvert (fermé) | Emplois, ouvert (fermé) |
|---|---|---|---|
| Repas | 97 % | 80 (999) | 8 (84) |
| Pain | 96 % | 37 (831) | 2 (20) |
| Viande | 99 % | 4 (281) | 0,5 (16) |
| Poisson | 100 % | 2,5 (100) | 0,6 (10) |
| Céréales | 88 % | 0,8 (83) | 0,2 (10) |
| Bétail | 81 % | 0,1 (5) | 0,2 (10) |

Environ 140 emplois de la filière alimentaire disparaissent à 1 000 citoyens (14 % des travailleurs) ; les secteurs qui
exportent n'en créent qu'une soixantaine (bijoux + 70, or + 16, pétrole et carburant − 14). À 2 500, même chose pour le
pain (94 % importé), la viande, le poisson et les céréales (100 %, 95 %), et la moitié des repas. Les fermetures suivent :
restaurants 34 contre 9, boulangeries 29 contre 5, boucheries 27 contre 7, pêche 33 contre 16 (2 graines). Les repas du
restaurant, qu'on ne peut pas importer dans la réalité, sont le premier poste d'importation (86 000 $/j à 1 000 et à
2 500 citoyens).

**3. À 240 citoyens : l'inverse.** Le taux de change monte (3 à 7,5 ; la monnaie d'ici se déprécie) mais pas assez vite
pour l'inflation (indice ≈ 3,5) : machines, ordinateurs, électronique, acier, fils, fusibles et tuyaux viennent à 100 % de
l'étranger, leurs petites entreprises ferment, et la viande est importée à moitié.

## 4. Corrections possibles (à décider par Francis)

1. **Prix mondiaux qui vivent** : chaque prix mondial suit lentement le coût normal du bien ici (le reste du monde a les
   mêmes techniques), vagues en plus. La cause est traitée à la racine ; le commerce ne vient plus que des vagues, du
   change et des écarts de coût du moment.
2. **Services non échangeables** : les repas du restaurant (et peut-être le pain frais) ne s'importent ni ne s'exportent,
   comme l'hôtel ou les loisirs.
3. **Préférence pour ce qui est fait ici** : une importation n'est choisie que si elle est moins chère d'une marge (transport,
   fraîcheur, habitudes), par exemple 20 %.
4. **Change ancré sur les prix** : le taux de change suit aussi l'écart entre l'indice des prix d'ici et celui du monde,
   pas seulement le solde des échanges (traite surtout le cas des 240 citoyens).

## 5. Mesure des corrections 1 à 3

Francis a choisi les corrections 1, 2 et 3 (pas la 4). Chacune a son interrupteur `Params`, coupé dans le moteur et
actif dans l'interface : `worldPriceDrift` (prix mondiaux qui suivent le prix normal d'ici, délai `worldPriceDays` =
365 j), `localMeals` (repas du restaurant non échangeables ; le pain reste échangeable), `homePreference` (une
importation n'est choisie que si elle est au moins `homeMargin` = 20 % moins chère qu'une offre d'ici). Commit beb542b ;
référence identique (32 éléments) ; corrections coupées, une partie B est identique au bit près.

Sur le PC, 10 graines appariées × 3 000 jours, mêmes réglages que B (tous les modules, frontières ouvertes, filets
actifs). B1, B2 et B3 : chaque correction seule ; B123 : les trois. Les 120 parties sont allées au bout. Données :
`rapports/donnees/tout-actif/corrections/` (`releves.csv`, `agg.txt`, `agg.py`).

Chômage moyen des jours 1 001-3 000 ; entre parenthèses, graines en crise (un relevé de 250 jours au-dessus de 20 %) :

| Citoyens | A | C | B | B1 | B2 | B3 | B123 |
|---|---|---|---|---|---|---|---|
| 240 | 4,7 % | 4,0 % | 15,4 % (9) | 12,4 % (8) | 9,7 % (6) | 11,8 % (9) | **8,9 %** (4) |
| 1 000 | 5,6 % | 3,2 % | 11,6 % (4) | 9,9 % (3) | 16,2 % (6) | 9,2 % (2) | **8,1 %** (4) |
| 2 500 | 6,1 % | 3,0 % | 10,1 % (4) | 10,2 % (5) | 10,2 % (5) | 9,2 % (3) | **7,5 %** (2) |

- **Les trois ensemble (B123) font mieux que B partout** : chômage − 6,5 points à 240, − 3,5 à 1 000, − 2,6 à 2 500 ;
  moins de crises ; entreprises actives + 1, + 9 et + 24 ; Gini − 0,04 à − 0,18 ; affamés 0,1 à 0,6 en moyenne.
- **Mais pas aussi bien que les frontières fermées (C)** : + 4,6 à + 4,9 points de chômage, plus haut dans les 10 graines à
  chaque taille, et 12 à 27 entreprises actives de moins. Les prix montent plus (indice 6,2 à 240, 3,8 à 1 000, 2,6 à
  2 500) : les prix mondiaux suivent ceux d'ici, l'importation ne plafonne plus les prix.
- **Seules, les corrections ont des effets inégaux** : B1 aide à 240 et 1 000 mais pas à 2 500, où les affamés montent
  (9 en moyenne, 9 graines sur 10) ; B2 aide à 240 mais nuit à 1 000 (16,2 % en moyenne, médiane 10,1 % ; affamés 17,9 en
  moyenne, tirés par quelques graines) ; B3 aide un peu partout (− 0,9 à − 3,6 points). Ensemble, ces écarts
  disparaissent : les trois restent actives.
- Francis juge acceptable un chômage jusqu'à 13 %, « comme en Espagne » : B123 y est à toutes les tailles. Pas d'autre
  correction pour l'instant.
