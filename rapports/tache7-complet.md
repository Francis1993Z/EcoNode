# Protocole de stabilité ÉcoNodes

- Date : 2026-10-05 21:34
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : aucun

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 12,7 % | 58,8 % | 7,6 % | 91,7 % | 10,5 % | 64,2 % | 0,75 | 0,75 | -0,001 % | 33,6 % | 24672,0 % | 183 (32) | 0.0e+0 |
| 2 | 28,0 % | 69,6 % | 30,1 % | 99,2 % | 21,0 % | 90,8 % | 0,72 | 0,32 | 0,001 % | 38,5 % | 39777,2 % | 140 (20) | 0.0e+0 |
| 3 | 22,2 % | 80,0 % | 18,3 % | 97,5 % | 56,2 % | 97,1 % | 0,95 | 0,88 | -0,006 % | 37,2 % | 42980,3 % | 140 (14) | 0.0e+0 |
| 4 | 13,8 % | 54,6 % | 9,3 % | 95,4 % | 10,4 % | 74,6 % | 0,75 | 0,51 | -0,000 % | 34,7 % | 26616,4 % | 154 (19) | 0.0e+0 |
| 5 | 73,0 % | 90,4 % | 81,9 % | 99,2 % | 47,4 % | 95,4 % | 0,93 | 0,50 | -0,000 % | 35,1 % | 66367,8 % | 178 (14) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 1 · 180 j | 2 · 538 j | 1 · 442 j | 2 · 250 j | 2 · 1265 j |
| Faim répandue | critique | 12 · 331 j | 5 · 529 j | 2 · 371 j | 6 · 288 j | 2 · 1270 j |
| Sans-abri nombreux | critique | 15 · 693 j | 11 · 782 j | 8 · 1373 j | 9 · 599 j | 7 · 1341 j |
| Inégalités hors bornes | attention | 5 · 1022 j | 2 · 931 j | 1 · 1432 j | 3 · 977 j | 2 · 1384 j |
| Richesse médiane hors bornes | attention | 4 · 584 j | 2 · 571 j | 1 · 1418 j | 3 · 589 j | 1 · 1314 j |
| Inflation quotidienne | critique | 3 · 45 j | 1 · 45 j | 2 · 43 j | 1 · 45 j | 2 · 45 j |
| Inflation sur 100 jours | critique | 1 · 49 j | 1 · 49 j | 1 · 53 j | 1 · 48 j | 1 · 50 j |
| Rupture de stock prolongée | attention | 20 · 2544 j | 10 · 1523 j | 14 · 2052 j | 17 · 2089 j | 11 · 2355 j |
| Surstock | attention | 30 · 21043 j | 19 · 22243 j | 24 · 22116 j | 26 · 21618 j | 26 · 25065 j |
| Entreprise sans employé | attention | 28 · 26724 j | 25 · 28325 j | 28 · 31304 j | 24 · 26488 j | 29 · 34334 j |
| Entreprise sans client | attention | 63 · 26385 j | 60 · 25605 j | 57 · 29859 j | 60 · 25378 j | 93 · 28801 j |
| Caisse insolvable | attention | 1 · 1412 j | 2 · 1334 j | 1 · 1383 j | 2 · 1145 j | 2 · 992 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 22,1 % | 17,0 % | 60,9 % | 20 | 80 852 $ | 693 372 $ | 42 737 $ |
| 2 | 3,7 % | 3,7 % | 92,6 % | 24 | 0 $ | 620 222 $ | 59 178 $ |
| 3 | 81,1 % | 6,8 % | 12,2 % | 23 | 24 848 $ | 325 970 $ | 32 266 $ |
| 4 | 10,7 % | 20,1 % | 69,2 % | 17 | 116 352 $ | 724 802 $ | 115 053 $ |
| 5 | 4,9 % | 1,4 % | 93,8 % | 25 | 223 $ | 443 077 $ | 54 998 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 3,7 % | 23,8 % | 0,0 % | 25,0 % | 0,6 % | 41,3 % | 0,19 | 0,17 | 0,095 % | 2,3 % | 266,4 % | 243 (7) | 0.0e+0 |
| 2 | 4,6 % | 18,8 % | 0,0 % | 32,5 % | 0,4 % | 25,4 % | 0,21 | 0,31 | 0,048 % | 1,9 % | 154,9 % | 271 (6) | 0.0e+0 |
| 3 | 4,5 % | 25,4 % | 0,0 % | 17,5 % | 0,5 % | 50,8 % | 0,20 | 0,12 | 0,032 % | 2,1 % | 280,9 % | 279 (6) | 0.0e+0 |
| 4 | 4,9 % | 23,8 % | 0,5 % | 62,9 % | 0,4 % | 64,2 % | 0,21 | 0,08 | 0,069 % | 1,9 % | 182,1 % | 267 (7) | 0.0e+0 |
| 5 | 4,3 % | 21,3 % | 0,0 % | 15,8 % | 0,2 % | 28,3 % | 0,20 | 0,10 | 0,080 % | 2,2 % | 218,2 % | 248 (6) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 21 · 0,00 | 30 · 0,00 | 12 · 0,00 | 483 · 16,93 | 1 · 0,00 | 3,39 ❌ | pas de producteur (100 %) |
| Renflouement d’entreprise | 714 · 23,18 | 771 · 25,43 | 764 · 24,54 | 768 · 25,29 | 739 · 23,86 | 24,46 ❌ | par le propriétaire (95 %) ; après rachat (5 %) |
| Plancher de logement | 189 · 6,68 | 30 · 0,93 | 620 · 3,61 | 836 · 0,79 | 15 · 0,50 | 2,50 ❌ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 7746 · 216,07 | 8468 · 244,46 | 7888 · 214,89 | 8307 · 233,54 | 7697 · 215,54 | 224,90 ❌ | hausse de prix (66 %) ; baisse de prix (31 %) |
| Anti-crédit-fou | 1855 · 66,25 | 399 · 14,25 | 1948 · 69,57 | 1254 · 44,79 | 1707 · 60,96 | 51,16 ❌ | fonds propres de la Caisse insuffisants (99 %) ; paiements > 35 % de la valeur ajoutée (1 %) |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 99 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g1 12,7 %, g2 28,0 %, g3 22,2 %, g4 13,8 %, g5 73,0 % |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ❌ | g1 0,75, g2 0,72, g3 0,95, g4 0,75, g5 0,93 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Anti-famine 3,39/50 j, Renflouement d’entreprise 24,46/50 j, Plancher de logement 2,50/50 j, Plafond de dérive des prix et salaires 224,90/50 j, Anti-crédit-fou 51,16/50 j |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 37,9 % | 30,0 % |
| Faim moyenne | 35,2 % | 29,4 % |
| Sans-abri moyen | 25,2 % | 29,1 % |
| Gini moyen | 0,74 | 0,82 |
| Inflation moyenne / jour | -0,005 % | -0,001 % |
| Alertes critiques (total) | 94 | 99 |
| Alertes (total) | 787 | 795 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 11,61 | 3,39 |
| Renflouements / 50 j | 23,70 | 24,46 |
| Plancher de logement / 50 j | 8,04 | 2,50 |
| Plafond de dérive / 50 j | 290,36 | 224,90 |
| Anti-crédit-fou / 50 j | 19,51 | 51,16 |

