# Protocole de stabilité ÉcoNodes

- Date : 2026-10-05 21:31
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : aucun

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 20,5 % | 72,9 % | 14,1 % | 95,8 % | 17,4 % | 95,0 % | 0,77 | 0,46 | -0,002 % | 33,0 % | 29539,8 % | 178 (22) | 0.0e+0 |
| 2 | 86,6 % | 95,0 % | 97,4 % | 98,8 % | 57,8 % | 99,6 % | 0,84 | 0,78 | -0,007 % | 40,1 % | 111917,4 % | 153 (6) | 0.0e+0 |
| 3 | 21,5 % | 67,1 % | 29,7 % | 98,8 % | 16,7 % | 74,6 % | 0,69 | 0,94 | -0,000 % | 34,4 % | 32074,1 % | 146 (19) | 0.0e+0 |
| 4 | 41,2 % | 79,2 % | 23,5 % | 97,9 % | 21,0 % | 78,3 % | 0,71 | 0,98 | -0,015 % | 57,8 % | 27425,0 % | 142 (19) | 0.0e+0 |
| 5 | 19,7 % | 73,3 % | 11,6 % | 93,3 % | 13,1 % | 89,6 % | 0,71 | 0,95 | 0,000 % | 35,7 % | 35436,6 % | 168 (28) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 2 · 339 j | 1 · 1435 j | 3 · 478 j | 2 · 812 j | 2 · 360 j |
| Chômage nul prolongé | attention | 1 · 10 j | · | · | · | · |
| Faim répandue | critique | 7 · 318 j | 1 · 1445 j | 4 · 553 j | 5 · 415 j | 6 · 344 j |
| Sans-abri nombreux | critique | 9 · 759 j | 2 · 1452 j | 9 · 842 j | 8 · 814 j | 17 · 633 j |
| Inégalités hors bornes | attention | 3 · 997 j | 4 · 1281 j | 5 · 862 j | 3 · 951 j | 4 · 941 j |
| Richesse médiane hors bornes | attention | 3 · 620 j | 1 · 1440 j | 5 · 410 j | 4 · 568 j | 5 · 517 j |
| Inflation quotidienne | critique | 3 · 45 j | 1 · 45 j | 2 · 46 j | 3 · 42 j | 2 · 43 j |
| Inflation sur 100 jours | critique | 1 · 50 j | 1 · 51 j | 1 · 52 j | 1 · 50 j | 1 · 52 j |
| Rupture de stock prolongée | attention | 21 · 2352 j | 4 · 519 j | 13 · 4235 j | 15 · 3964 j | 17 · 2010 j |
| Surstock | attention | 33 · 23092 j | 22 · 27316 j | 18 · 20156 j | 21 · 21535 j | 24 · 23273 j |
| Entreprise sans employé | attention | 25 · 29735 j | 28 · 35606 j | 26 · 29282 j | 29 · 30845 j | 25 · 30587 j |
| Entreprise sans client | attention | 70 · 28497 j | 87 · 30429 j | 60 · 28260 j | 51 · 28678 j | 65 · 29844 j |
| Caisse insolvable | attention | · | 1 · 289 j | · | · | · |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 11,6 % | 20,8 % | 67,6 % | 21 | 0 $ | 186 651 $ | 23 213 $ |
| 2 | 0,0 % | 7,1 % | 92,9 % | 26 | 0 $ | 414 850 $ | 376 514 $ |
| 3 | 42,7 % | 2,6 % | 54,7 % | 23 | 10 004 $ | 461 415 $ | 17 901 $ |
| 4 | 23,4 % | 12,5 % | 64,1 % | 26 | 0 $ | 240 341 $ | 19 448 $ |
| 5 | 0,7 % | 17,2 % | 82,1 % | 24 | 3 057 $ | 345 446 $ | 21 929 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 6,2 % | 32,1 % | 1,9 % | 65,4 % | 1,2 % | 24,2 % | 0,34 | 0,16 | 0,030 % | 2,7 % | 257,5 % | 279 (12) | 0.0e+0 |
| 2 | 4,1 % | 19,6 % | 0,0 % | 23,3 % | 0,4 % | 27,1 % | 0,22 | 0,14 | 0,107 % | 2,2 % | 191,1 % | 350 (6) | 0.0e+0 |
| 3 | 6,0 % | 20,0 % | 0,2 % | 31,7 % | 0,3 % | 32,1 % | 0,23 | 0,41 | 0,022 % | 2,1 % | 253,2 % | 301 (6) | 0.0e+0 |
| 4 | 5,4 % | 27,5 % | 0,0 % | 22,1 % | 1,2 % | 57,1 % | 0,32 | 0,13 | 0,049 % | 2,1 % | 250,3 % | 234 (7) | 0.0e+0 |
| 5 | 7,2 % | 27,9 % | 0,7 % | 49,2 % | 0,7 % | 36,7 % | 0,24 | 0,45 | 0,099 % | 2,6 % | 190,5 % | 293 (7) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 1366 · 48,79 | 6 · 0,00 | 21 · 0,50 | 10 · 0,00 | 246 · 8,79 | 11,61 ❌ | pas de producteur (100 %) |
| Renflouement d’entreprise | 638 · 20,18 | 840 · 27,71 | 756 · 24,71 | 588 · 18,54 | 834 · 27,36 | 23,70 ❌ | par le propriétaire (95 %) ; après rachat (5 %) |
| Plancher de logement | 277 · 9,89 | 31 · 1,07 | 91 · 1,71 | 984 · 22,93 | 129 · 4,61 | 8,04 ❌ | parc plein (86 %) ; prix trop élevé (14 %) |
| Plafond de dérive des prix et salaires | 12074 · 370,96 | 8650 · 247,50 | 9466 · 276,43 | 9405 · 268,68 | 9686 · 288,25 | 290,36 ❌ | hausse de prix (63 %) ; baisse de prix (34 %) |
| Anti-crédit-fou | 1 · 0,04 | 842 · 30,07 | 13 · 0,46 | 1854 · 66,21 | 21 · 0,75 | 19,51 ❌ | fonds propres de la Caisse insuffisants (100 %) ; paiements > 35 % de la valeur ajoutée (0 %) |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 94 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g1 20,5 %, g2 86,6 %, g3 21,5 %, g4 41,2 %, g5 19,7 % |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ❌ | g1 0,77, g2 0,84, g3 0,69, g4 0,71, g5 0,71 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Anti-famine 11,61/50 j, Renflouement d’entreprise 23,70/50 j, Plancher de logement 8,04/50 j, Plafond de dérive des prix et salaires 290,36/50 j, Anti-crédit-fou 19,51/50 j |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 86,9 % | 37,9 % |
| Faim moyenne | 87,0 % | 35,2 % |
| Sans-abri moyen | 95,9 % | 25,2 % |
| Gini moyen | 0,59 | 0,74 |
| Inflation moyenne / jour | 0,042 % | -0,005 % |
| Alertes critiques (total) | 55 | 94 |
| Alertes (total) | 666 | 787 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 11,61 |
| Renflouements / 50 j | 66,05 | 23,70 |
| Plancher de logement / 50 j | 12,66 | 8,04 |
| Plafond de dérive / 50 j | 226,54 | 290,36 |
| Anti-crédit-fou / 50 j | 67,14 | 19,51 |

