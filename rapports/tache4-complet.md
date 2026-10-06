# Protocole de stabilité ÉcoNodes

- Date : 2026-10-04 19:32
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : aucun

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 85,5 % | 94,6 % | 78,6 % | 98,8 % | 95,9 % | 100,0 % | 0,57 | 0,40 | -0,003 % | 40,0 % | 41380,0 % | 151 (12) | 0.0e+0 |
| 2 | 31,4 % | 80,4 % | 41,8 % | 98,3 % | 55,4 % | 100,0 % | 0,67 | 0,29 | -0,001 % | 37,4 % | 20669,5 % | 170 (19) | 0.0e+0 |
| 3 | 29,0 % | 97,5 % | 21,3 % | 98,3 % | 88,4 % | 100,0 % | 0,79 | 0,55 | 0,135 % | 30,4 % | 3633,3 % | 158 (17) | 0.0e+0 |
| 4 | 37,8 % | 62,9 % | 65,2 % | 95,4 % | 39,9 % | 66,3 % | 0,83 | 0,73 | 0,000 % | 41,1 % | 22411,7 % | 168 (15) | 0.0e+0 |
| 5 | 76,9 % | 98,3 % | 87,3 % | 98,8 % | 96,7 % | 100,0 % | 0,47 | 0,13 | -0,004 % | 39,4 % | 50057,3 % | 150 (12) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 1 · 1431 j | 3 · 538 j | 1 · 379 j | 5 · 948 j | 1 · 1433 j |
| Faim répandue | critique | 6 · 1244 j | 7 · 812 j | 3 · 406 j | 1 · 1007 j | 5 · 1316 j |
| Sans-abri nombreux | critique | 2 · 1444 j | 5 · 1229 j | 3 · 1261 j | 5 · 1221 j | 2 · 1451 j |
| Inégalités hors bornes | attention | 2 · 531 j | 2 · 864 j | 2 · 1155 j | 2 · 1366 j | 1 · 536 j |
| Richesse médiane hors bornes | attention | 2 · 454 j | 4 · 458 j | 1 · 1238 j | 4 · 1073 j | 1 · 483 j |
| Inflation quotidienne | critique | 2 · 43 j | 3 · 44 j | 8 · 53 j | 3 · 38 j | 3 · 42 j |
| Inflation sur 100 jours | critique | 1 · 53 j | 1 · 49 j | 2 · 146 j | 1 · 49 j | 1 · 52 j |
| Rupture de stock prolongée | attention | 17 · 8129 j | 22 · 5135 j | 18 · 2719 j | 35 · 5694 j | 14 · 7892 j |
| Surstock | attention | 25 · 19727 j | 24 · 17852 j | 33 · 19416 j | 21 · 16521 j | 21 · 21598 j |
| Entreprise sans employé | attention | 32 · 37784 j | 32 · 29820 j | 38 · 31282 j | 26 · 26036 j | 33 · 40857 j |
| Entreprise sans client | attention | 61 · 33103 j | 67 · 28252 j | 49 · 28011 j | 65 · 23076 j | 68 · 37391 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 26,3 % | 0,0 % | 73,7 % | 29 | 0 $ | 63 377 $ | 28 042 $ |
| 2 | 9,0 % | 3,6 % | 87,4 % | 25 | 0 $ | 1 132 269 $ | 158 279 $ |
| 3 | 91,0 % | 6,3 % | 2,7 % | 25 | 4 562 $ | 559 058 $ | 88 052 $ |
| 4 | 11,8 % | 6,5 % | 81,7 % | 19 | 0 $ | 944 660 $ | 7 287 $ |
| 5 | 0,0 % | 6,5 % | 93,5 % | 30 | 0 $ | 50 476 $ | 13 530 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 3,4 % | 20,4 % | 0,0 % | 52,5 % | 0,2 % | 30,0 % | 0,20 | 0,12 | 0,081 % | 2,0 % | 141,7 % | 230 (5) | 0.0e+0 |
| 2 | 3,8 % | 21,3 % | 0,0 % | 23,3 % | 0,2 % | 85,0 % | 0,20 | 0,16 | 0,049 % | 1,9 % | 159,2 % | 207 (5) | 0.0e+0 |
| 3 | 3,3 % | 18,8 % | 0,0 % | 16,7 % | 0,2 % | 21,3 % | 0,20 | 0,13 | 0,064 % | 1,8 % | 116,1 % | 212 (5) | 0.0e+0 |
| 4 | 4,5 % | 15,0 % | 0,0 % | 26,3 % | 0,4 % | 100,0 % | 0,19 | 0,12 | 0,077 % | 2,2 % | 118,5 % | 208 (5) | 0.0e+0 |
| 5 | 11,5 % | 45,8 % | 2,9 % | 95,8 % | 3,1 % | 100,0 % | 0,49 | 0,36 | 0,052 % | 2,6 % | 147,4 % | 276 (21) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 75 · 0,00 | 15 · 0,00 | 3 · 0,00 | 5 · 0,00 | 1767 · 62,96 | 12,59 ❌ | pas de producteur (100 %) ; prix trop élevé (0 %) |
| Renflouement d’entreprise | 685 · 22,61 | 617 · 20,04 | 618 · 20,04 | 721 · 23,68 | 515 · 16,79 | 20,63 ❌ | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 80 · 0,75 | 87 · 0,29 | 19 · 0,57 | 397 · 14,18 | 1960 · 70,00 | 17,16 ❌ | parc plein (60 %) ; prix trop élevé (40 %) |
| Plafond de dérive des prix et salaires | 7905 · 221,36 | 7757 · 217,36 | 8500 · 250,50 | 8883 · 257,07 | 12092 · 377,36 | 264,73 ❌ | hausse de prix (64 %) ; baisse de prix (34 %) |
| Anti-crédit-fou | 4462 · 151,79 | 5579 · 195,68 | 3989 · 136,86 | 3778 · 128,18 | 2622 · 89,82 | 140,46 ❌ | fonds propres de la Caisse insuffisants (100 %) ; paiements > 35 % de la valeur ajoutée (0 %) |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 75 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g1 85,5 %, g2 31,4 %, g3 29,0 %, g4 37,8 %, g5 76,9 % |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ❌ | g1 0,57, g2 0,67, g3 0,79, g4 0,83, g5 0,47 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Anti-famine 12,59/50 j, Renflouement d’entreprise 20,63/50 j, Plancher de logement 17,16/50 j, Plafond de dérive des prix et salaires 264,73/50 j, Anti-crédit-fou 140,46/50 j |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 86,9 % | 52,1 % |
| Faim moyenne | 87,0 % | 58,9 % |
| Sans-abri moyen | 95,9 % | 75,3 % |
| Gini moyen | 0,59 | 0,67 |
| Inflation moyenne / jour | 0,042 % | 0,026 % |
| Alertes critiques (total) | 55 | 75 |
| Alertes (total) | 666 | 797 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 12,59 |
| Renflouements / 50 j | 66,05 | 20,63 |
| Plancher de logement / 50 j | 12,66 | 17,16 |
| Plafond de dérive / 50 j | 226,54 | 264,73 |
| Anti-crédit-fou / 50 j | 67,14 | 140,46 |

