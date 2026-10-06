# Protocole de stabilité ÉcoNodes

- Date : 2026-10-05 21:42
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : aucun

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,9 % | 43,8 % | 2,2 % | 77,1 % | 3,7 % | 87,1 % | 0,51 | 0,75 | -0,036 % | 37,0 % | 2637,2 % | 167 (21) | 0.0e+0 |
| 2 | 12,5 % | 49,2 % | 17,7 % | 97,5 % | 16,4 % | 79,2 % | 0,79 | 0,50 | -0,078 % | 41,7 % | 2193,9 % | 243 (48) | 0.0e+0 |
| 3 | 7,3 % | 37,9 % | 5,8 % | 87,1 % | 15,3 % | 79,2 % | 0,72 | 0,61 | 0,000 % | 28,1 % | 5290,4 % | 223 (27) | 0.0e+0 |
| 4 | 6,8 % | 43,8 % | 2,3 % | 80,4 % | 6,5 % | 75,4 % | 0,54 | 0,33 | -0,044 % | 33,4 % | 2577,8 % | 196 (20) | 0.0e+0 |
| 5 | 8,1 % | 32,9 % | 4,2 % | 89,6 % | 8,7 % | 72,5 % | 0,58 | 0,37 | -0,056 % | 46,3 % | 2608,6 % | 206 (26) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | · | 1 · 73 j | · | 1 · 36 j | · |
| Faim répandue | critique | 5 · 82 j | 22 · 507 j | 12 · 186 j | 6 · 101 j | 10 · 125 j |
| Sans-abri nombreux | critique | 10 · 198 j | 17 · 859 j | 11 · 651 j | 7 · 333 j | 10 · 399 j |
| Inégalités hors bornes | attention | 3 · 353 j | 6 · 1021 j | 3 · 1010 j | 2 · 416 j | 4 · 526 j |
| Richesse médiane hors bornes | attention | 2 · 187 j | 6 · 723 j | 2 · 561 j | 2 · 259 j | 2 · 328 j |
| Inflation quotidienne | critique | 5 · 34 j | 7 · 36 j | 3 · 44 j | 5 · 34 j | 5 · 38 j |
| Inflation sur 100 jours | critique | 1 · 41 j | 1 · 37 j | 1 · 41 j | 1 · 35 j | 1 · 51 j |
| Rupture de stock prolongée | attention | 22 · 3235 j | 35 · 7439 j | 22 · 3869 j | 20 · 3562 j | 30 · 4673 j |
| Surstock | attention | 27 · 15739 j | 39 · 14415 j | 37 · 19224 j | 35 · 15841 j | 35 · 15424 j |
| Entreprise sans employé | attention | 26 · 25045 j | 37 · 27527 j | 36 · 28689 j | 28 · 25144 j | 29 · 26510 j |
| Entreprise sans client | attention | 66 · 24290 j | 72 · 26931 j | 96 · 27192 j | 89 · 23911 j | 80 · 25512 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 12,0 % | 23,0 % | 65,0 % | 17 | 2 997 $ | 89 116 $ | 0 $ |
| 2 | 5,0 % | 25,6 % | 69,3 % | 19 | 9 272 $ | 93 708 $ | 3 573 $ |
| 3 | 59,7 % | 3,4 % | 36,9 % | 24 | 0 $ | 65 169 $ | 10 455 $ |
| 4 | 8,7 % | 10,0 % | 81,2 % | 18 | 20 778 $ | 119 658 $ | 3 428 $ |
| 5 | 18,8 % | 15,9 % | 65,2 % | 20 | 23 685 $ | 150 432 $ | 16 570 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,0 % | 17,9 % | 0,1 % | 29,2 % | 0,1 % | 21,7 % | 0,17 | 0,12 | 0,104 % | 2,5 % | 173,2 % | 260 (4) | 0.0e+0 |
| 2 | 10,0 % | 42,1 % | 2,1 % | 83,3 % | 1,9 % | 46,7 % | 0,40 | 0,36 | 0,118 % | 2,4 % | 177,4 % | 343 (23) | 0.0e+0 |
| 3 | 4,7 % | 23,3 % | 0,3 % | 50,0 % | 0,5 % | 57,9 % | 0,21 | 0,12 | 0,075 % | 2,5 % | 187,9 % | 200 (5) | 0.0e+0 |
| 4 | 7,4 % | 25,0 % | 1,3 % | 77,1 % | 0,8 % | 43,3 % | 0,38 | 0,15 | 0,090 % | 2,0 % | 117,9 % | 314 (14) | 0.0e+0 |
| 5 | 4,0 % | 15,0 % | 0,0 % | 0,0 % | 0,4 % | 30,0 % | 0,20 | 0,14 | 0,097 % | 2,1 % | 157,0 % | 181 (3) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 6 · 0,21 | 1373 · 49,04 | 75 · 2,68 | 567 · 20,25 | 0 · 0,00 | 14,44 ❌ | pas de producteur (100 %) |
| Renflouement d’entreprise | 777 · 25,57 | 809 · 26,75 | 663 · 21,11 | 669 · 21,68 | 607 · 19,36 | 22,89 ❌ | par le propriétaire (95 %) ; après rachat (5 %) |
| Plancher de logement | 7 · 0,25 | 206 · 7,36 | 484 · 2,89 | 214 · 3,11 | 39 · 1,36 | 2,99 ❌ | parc plein (82 %) ; prix trop élevé (18 %) |
| Plafond de dérive des prix et salaires | 8167 · 241,79 | 11155 · 349,21 | 9565 · 285,32 | 11953 · 373,04 | 8898 · 265,43 | 302,96 ❌ | hausse de prix (61 %) ; baisse de prix (36 %) |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage 3–10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 63,3 % | 96,3 % | 90,0 % | non (> 470) | non | Inflation quotidienne ×2, Rupture de stock prolongée ×12, Surstock ×8, Entreprise sans client ×26, Entreprise sans employé ×7, Sans-abri nombreux ×4, Faim répandue ×5, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 92,1 % | 100,0 % | 84,6 % | non (> 470) | non | Inflation quotidienne ×2, Rupture de stock prolongée ×9, Surstock ×12, Entreprise sans client ×28, Entreprise sans employé ×13, Sans-abri nombreux ×1, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×2, Chômage très élevé ×2 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 24,2 % | 88,3 % | 73,8 % | non (> 470) | 31 | Rupture de stock prolongée ×17, Surstock ×15, Entreprise sans client ×32, Entreprise sans employé ×7, Sans-abri nombreux ×8, Faim répandue ×4, Inégalités hors bornes ×3, Richesse médiane hors bornes ×2 |
| +25 immigrants | 1 | non | 32,5 % | 87,2 % | 87,2 % | non (> 470) | 1 | Inflation quotidienne ×1, Rupture de stock prolongée ×7, Surstock ×3, Entreprise sans client ×26, Entreprise sans employé ×4, Sans-abri nombreux ×5, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| +25 immigrants | 2 | non | 27,9 % | 97,4 % | 87,5 % | non (> 470) | non | Rupture de stock prolongée ×9, Surstock ×13, Entreprise sans client ×24, Entreprise sans employé ×5, Sans-abri nombreux ×7, Faim répandue ×10, Inégalités hors bornes ×2, Richesse médiane hors bornes ×2 |
| +25 immigrants | 3 | non | 34,3 % | 84,9 % | 91,3 % | non (> 470) | 1 | Rupture de stock prolongée ×15, Surstock ×8, Entreprise sans client ×30, Entreprise sans employé ×5, Sans-abri nombreux ×4, Faim répandue ×6, Inégalités hors bornes ×2, Richesse médiane hors bornes ×2 |
| Salaire minimum 220 $/j | 1 | non | 25,8 % | 82,5 % | 87,1 % | non (> 470) | 1 | Inflation quotidienne ×1, Rupture de stock prolongée ×4, Surstock ×4, Entreprise sans client ×27, Entreprise sans employé ×5, Sans-abri nombreux ×6, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| Salaire minimum 220 $/j | 2 | non | 40,8 % | 98,3 % | 90,0 % | non (> 470) | non | Inflation quotidienne ×1, Rupture de stock prolongée ×9, Surstock ×10, Entreprise sans client ×25, Entreprise sans employé ×8, Sans-abri nombreux ×4, Faim répandue ×5, Inégalités hors bornes ×2, Richesse médiane hors bornes ×2, Chômage très élevé ×1 |
| Salaire minimum 220 $/j | 3 | non | 32,1 % | 80,0 % | 95,0 % | 22 | 1 | Rupture de stock prolongée ×13, Surstock ×11, Entreprise sans client ×33, Entreprise sans employé ×8, Sans-abri nombreux ×5, Faim répandue ×9, Inégalités hors bornes ×1, Richesse médiane hors bornes ×3 |
| Fermeture de la ferme | 1 | non | 31,7 % | 76,3 % | 96,3 % | non (> 470) | non | Inflation quotidienne ×1, Rupture de stock prolongée ×5, Entreprise sans client ×19, Entreprise sans employé ×4, Sans-abri nombreux ×2, Faim répandue ×5, Richesse médiane hors bornes ×1 |
| Fermeture de la ferme | 2 | non | 96,7 % | 100,0 % | 93,3 % | non (> 470) | non | Inflation quotidienne ×2, Rupture de stock prolongée ×8, Surstock ×8, Entreprise sans client ×27, Entreprise sans employé ×11, Faim répandue ×2, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 3 | non | 54,2 % | 95,0 % | 95,0 % | non (> 470) | non | Rupture de stock prolongée ×6, Surstock ×3, Entreprise sans client ×26, Entreprise sans employé ×6, Sans-abri nombreux ×3, Faim répandue ×5, Inégalités hors bornes ×1, Richesse médiane hors bornes ×2, Chômage très élevé ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 44,6 % | 75,4 % | 50,8 % | non (> 470) | 1 | Inflation quotidienne ×1, Rupture de stock prolongée ×8, Surstock ×5, Entreprise sans client ×20, Entreprise sans employé ×5, Sans-abri nombreux ×2, Faim répandue ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 40,8 % | 97,9 % | 65,8 % | non (> 470) | 36 | Rupture de stock prolongée ×10, Surstock ×11, Entreprise sans client ×24, Entreprise sans employé ×8, Sans-abri nombreux ×9, Faim répandue ×7, Inégalités hors bornes ×1, Richesse médiane hors bornes ×2, Chômage très élevé ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 49,2 % | 85,8 % | 80,0 % | non (> 470) | 461 | Inflation quotidienne ×2, Rupture de stock prolongée ×16, Surstock ×9, Entreprise sans client ×20, Entreprise sans employé ×8, Sans-abri nombreux ×7, Faim répandue ×7, Inégalités hors bornes ×2, Richesse médiane hors bornes ×3, Chômage très élevé ×3 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 31,3 % | 95,8 % | 52,9 % | 440 ❌ | 168 | Rupture de stock prolongée ×33, Surstock ×34, Entreprise sans client ×51, Entreprise sans employé ×27, Sans-abri nombreux ×4, Faim répandue ×3 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 45,4 % | 76,7 % | 61,7 % | 427 ❌ | 238 | Rupture de stock prolongée ×36, Surstock ×27, Entreprise sans client ×52, Entreprise sans employé ×28, Sans-abri nombreux ×3, Faim répandue ×3, Inégalités hors bornes ×1, Chômage très élevé ×1, Chômage nul prolongé ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 19,2 % | 33,8 % | 52,5 % | 82 | 76 | Rupture de stock prolongée ×30, Sans-abri nombreux ×5, Surstock ×39, Entreprise sans client ×57, Entreprise sans employé ×33, Faim répandue ×1 |
| +25 immigrants | 1 | non | 15,5 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×13, Surstock ×19, Entreprise sans client ×47, Entreprise sans employé ×18 |
| +25 immigrants | 2 | non | 19,2 % | 0,0 % | 6,0 % | non (> 470) | non | Rupture de stock prolongée ×13, Surstock ×21, Entreprise sans client ×32, Entreprise sans employé ×13 |
| +25 immigrants | 3 | non | 20,4 % | 39,6 % | 23,4 % | non (> 470) | non | Rupture de stock prolongée ×13, Sans-abri nombreux ×2, Surstock ×18, Entreprise sans client ×23, Entreprise sans employé ×10, Faim répandue ×1 |
| Salaire minimum 220 $/j | 1 | non | 10,4 % | 0,0 % | 0,0 % | 51 | 14 | Rupture de stock prolongée ×16, Surstock ×13, Entreprise sans client ×41, Entreprise sans employé ×19 |
| Salaire minimum 220 $/j | 2 | non | 11,7 % | 0,0 % | 0,0 % | 84 | 156 | Rupture de stock prolongée ×10, Surstock ×22, Entreprise sans client ×40, Entreprise sans employé ×14 |
| Salaire minimum 220 $/j | 3 | non | 13,3 % | 0,0 % | 0,0 % | 86 | 1 | Rupture de stock prolongée ×2, Surstock ×20, Entreprise sans client ×29, Entreprise sans employé ×10 |
| Fermeture de la ferme | 1 | non | 62,5 % | 96,7 % | 39,2 % | non (> 470) | non | Rupture de stock prolongée ×15, Surstock ×22, Entreprise sans client ×44, Entreprise sans employé ×18, Faim répandue ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 2 | non | 40,8 % | 95,4 % | 36,3 % | non (> 470) | 265 | Rupture de stock prolongée ×17, Surstock ×22, Entreprise sans client ×37, Entreprise sans employé ×22, Sans-abri nombreux ×4, Inflation sur 100 jours ×1, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 3 | non | 27,1 % | 68,3 % | 37,5 % | 450 ❌ | 450 | Rupture de stock prolongée ×10, Sans-abri nombreux ×2, Surstock ×12, Entreprise sans client ×28, Entreprise sans employé ×15, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 12,9 % | 0,0 % | 17,1 % | 113 | 1 | Rupture de stock prolongée ×18, Surstock ×23, Entreprise sans client ×41, Entreprise sans employé ×19, Sans-abri nombreux ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 14,6 % | 36,3 % | 7,9 % | 130 | 154 | Rupture de stock prolongée ×23, Surstock ×27, Entreprise sans client ×44, Entreprise sans employé ×27, Sans-abri nombreux ×1, Faim répandue ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 20,0 % | 0,0 % | 37,9 % | 111 | 69 | Rupture de stock prolongée ×26, Sans-abri nombreux ×1, Surstock ×32, Entreprise sans client ×56, Entreprise sans employé ×27 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 142 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g2 12,5 % |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ❌ | g1 0,51, g2 0,79, g3 0,72, g4 0,54, g5 0,58 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Anti-famine 14,44/50 j, Renflouement d’entreprise 22,89/50 j, Plancher de logement 2,99/50 j, Plafond de dérive des prix et salaires 302,96/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 14/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 8/15 échecs |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 86,9 % | 8,1 % |
| Faim moyenne | 87,0 % | 6,4 % |
| Sans-abri moyen | 95,9 % | 10,1 % |
| Gini moyen | 0,59 | 0,63 |
| Inflation moyenne / jour | 0,042 % | -0,043 % |
| Alertes critiques (total) | 55 | 142 |
| Alertes (total) | 666 | 1035 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 14,44 |
| Renflouements / 50 j | 66,05 | 22,89 |
| Plancher de logement / 50 j | 12,66 | 2,99 |
| Plafond de dérive / 50 j | 226,54 | 302,96 |
| Anti-crédit-fou / 50 j | 67,14 | 0,00 |
| Chocs revenus à l’équilibre en < 200 j (sans filets) | 0 | 1 |
| Chocs revenus à l’équilibre en < 200 j (avec filets) | 5 | 7 |

