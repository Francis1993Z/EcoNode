# Protocole de stabilité ÉcoNodes

- Date : 2026-10-05 22:22
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : aucun

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,3 % | 24,6 % | 0,2 % | 38,8 % | 1,3 % | 33,8 % | 0,38 | 0,31 | -0,068 % | 37,1 % | 500,8 % | 309 (23) | 0.0e+0 |
| 2 | 5,2 % | 42,1 % | 1,5 % | 87,9 % | 2,7 % | 48,3 % | 0,38 | 0,34 | -0,085 % | 41,7 % | 705,8 % | 338 (30) | 0.0e+0 |
| 3 | 5,1 % | 34,2 % | 0,3 % | 62,1 % | 0,4 % | 23,3 % | 0,27 | 0,22 | -0,050 % | 46,1 % | 540,0 % | 320 (24) | 0.0e+0 |
| 4 | 5,9 % | 45,0 % | 1,6 % | 82,5 % | 4,3 % | 60,0 % | 0,39 | 0,32 | -0,061 % | 36,7 % | 496,2 % | 313 (22) | 0.0e+0 |
| 5 | 5,9 % | 26,3 % | 2,5 % | 85,4 % | 4,5 % | 62,1 % | 0,47 | 0,30 | -0,069 % | 46,7 % | 659,1 % | 474 (36) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage nul prolongé | attention | · | · | · | · | 1 · 3 j |
| Faim répandue | critique | 2 · 11 j | 1 · 30 j | 2 · 7 j | 1 · 35 j | 4 · 64 j |
| Sans-abri nombreux | critique | 6 · 39 j | 4 · 127 j | 2 · 27 j | 5 · 174 j | 8 · 216 j |
| Inégalités hors bornes | attention | 2 · 111 j | 2 · 134 j | 1 · 75 j | 2 · 134 j | 3 · 266 j |
| Richesse médiane hors bornes | attention | · | 1 · 58 j | · | 1 · 63 j | 2 · 159 j |
| Inflation quotidienne | critique | 14 · 51 j | 24 · 63 j | 18 · 89 j | 15 · 53 j | 22 · 71 j |
| Inflation sur 100 jours | critique | 1 · 17 j | 1 · 18 j | 2 · 54 j | 1 · 17 j | 2 · 26 j |
| Rupture de stock prolongée | attention | 65 · 1802 j | 61 · 1947 j | 86 · 1871 j | 50 · 1700 j | 107 · 3350 j |
| Surstock | attention | 28 · 942 j | 29 · 954 j | 29 · 1060 j | 28 · 687 j | 34 · 946 j |
| Entreprise sans employé | attention | 95 · 1312 j | 110 · 1540 j | 89 · 1246 j | 106 · 1468 j | 141 · 1919 j |
| Entreprise sans client | attention | 96 · 2274 j | 105 · 2655 j | 91 · 2066 j | 104 · 2299 j | 149 · 3463 j |
| Caisse insolvable | attention | · | · | · | · | 1 · 839 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 9,2 % | 10,0 % | 80,8 % | 0 | 0 $ | 140 990 $ | 14 870 $ |
| 2 | 8,7 % | 9,6 % | 81,7 % | 1 | 13 887 $ | 161 279 $ | 18 246 $ |
| 3 | 2,2 % | 14,3 % | 83,5 % | 2 | 55 865 $ | 257 456 $ | 18 029 $ |
| 4 | 8,7 % | 10,0 % | 81,2 % | 0 | 17 935 $ | 150 417 $ | 13 788 $ |
| 5 | 9,6 % | 10,0 % | 80,4 % | 3 | 602 $ | 140 250 $ | 29 140 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 2,4 % | 17,9 % | 0,0 % | 0,0 % | 0,2 % | 24,2 % | 0,15 | 0,14 | 0,029 % | 80,6 % | 175,2 % | 107 (11) | 0.0e+0 |
| 2 | 3,6 % | 12,9 % | 0,0 % | 6,3 % | 0,4 % | 33,3 % | 0,17 | 0,17 | 0,029 % | 38,9 % | 88,5 % | 105 (4) | 0.0e+0 |
| 3 | 4,6 % | 19,2 % | 1,6 % | 90,4 % | 0,6 % | 57,9 % | 0,29 | 0,21 | -0,001 % | 65,7 % | 185,6 % | 215 (20) | 0.0e+0 |
| 4 | 3,6 % | 17,5 % | 0,0 % | 0,0 % | 0,2 % | 43,3 % | 0,19 | 0,12 | -0,022 % | 65,5 % | 109,1 % | 129 (10) | 0.0e+0 |
| 5 | 4,5 % | 26,3 % | 0,3 % | 66,7 % | 0,6 % | 37,1 % | 0,22 | 0,12 | 0,027 % | 48,0 % | 318,8 % | 137 (9) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 575 · 20,54 | 0 · 0,00 | 95 · 3,39 | 4,79 ❌ | pas de producteur (100 %) |
| Renflouement d’entreprise | 807 · 26,86 | 752 · 24,57 | 1113 · 37,54 | 804 · 26,46 | 692 · 22,39 | 27,56 ❌ | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 17 · 0,61 | 75 · 2,68 | 559 · 5,57 | 145 · 0,64 | 115 · 4,07 | 2,71 ❌ | parc plein (87 %) ; prix trop élevé (13 %) |
| Plafond de dérive des prix et salaires | 7692 · 224,89 | 8561 · 255,07 | 8994 · 264,82 | 8957 · 265,93 | 9882 · 300,57 | 262,26 ❌ | hausse de prix (68 %) ; baisse de prix (31 %) |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage 3–10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 26,3 % | 57,1 % | 69,2 % | non (> 470) | 210 | Inflation quotidienne ×18, Rupture de stock prolongée ×56, Surstock ×13, Entreprise sans client ×57, Entreprise sans employé ×58, Inflation sur 100 jours ×3, Sans-abri nombreux ×7, Faim répandue ×2, Inégalités hors bornes ×2, Richesse médiane hors bornes ×4 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 33,3 % | 17,1 % | 30,8 % | non (> 470) | 238 | Inflation quotidienne ×8, Rupture de stock prolongée ×50, Surstock ×6, Entreprise sans client ×53, Entreprise sans employé ×56, Inflation sur 100 jours ×3, Sans-abri nombreux ×11, Inégalités hors bornes ×3, Faim répandue ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 12,1 % | 0,0 % | 34,2 % | 324 ❌ | 153 | Inflation quotidienne ×13, Rupture de stock prolongée ×36, Surstock ×4, Entreprise sans client ×45, Entreprise sans employé ×46, Inflation sur 100 jours ×1, Sans-abri nombreux ×4, Inégalités hors bornes ×1 |
| +25 immigrants | 1 | non | 18,9 % | 66,4 % | 22,3 % | non (> 470) | non | Inflation quotidienne ×2, Rupture de stock prolongée ×49, Surstock ×21, Entreprise sans client ×67, Entreprise sans employé ×63, Sans-abri nombreux ×5, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| +25 immigrants | 2 | non | 22,6 % | 0,0 % | 31,3 % | non (> 470) | non | Inflation quotidienne ×4, Rupture de stock prolongée ×52, Surstock ×14, Entreprise sans client ×71, Entreprise sans employé ×65, Sans-abri nombreux ×6, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| +25 immigrants | 3 | non | 20,8 % | 0,0 % | 7,5 % | non (> 470) | 3 | Rupture de stock prolongée ×51, Surstock ×13, Entreprise sans client ×75, Entreprise sans employé ×63, Sans-abri nombreux ×2, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | non | 22,1 % | 0,4 % | 11,7 % | non (> 470) | 1 | Inflation quotidienne ×1, Rupture de stock prolongée ×20, Surstock ×5, Entreprise sans client ×27, Entreprise sans employé ×28, Sans-abri nombreux ×3, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 2 | non | 29,6 % | 12,5 % | 23,8 % | 266 ❌ | non | Inflation quotidienne ×5, Rupture de stock prolongée ×22, Surstock ×2, Entreprise sans client ×27, Entreprise sans employé ×29, Inflation sur 100 jours ×1, Sans-abri nombreux ×3, Inégalités hors bornes ×1, Faim répandue ×1, Richesse médiane hors bornes ×1 |
| Salaire minimum 220 $/j | 3 | non | 15,4 % | 0,0 % | 19,2 % | 296 ❌ | 7 | Inflation quotidienne ×11, Rupture de stock prolongée ×33, Surstock ×10, Entreprise sans client ×41, Entreprise sans employé ×34, Inflation sur 100 jours ×1 |
| Fermeture de la ferme | 1 | non | 30,4 % | 85,0 % | 85,0 % | non (> 470) | 67 | Inflation quotidienne ×8, Rupture de stock prolongée ×62, Surstock ×16, Entreprise sans client ×71, Entreprise sans employé ×67, Inflation sur 100 jours ×2, Sans-abri nombreux ×9, Faim répandue ×3, Inégalités hors bornes ×2, Richesse médiane hors bornes ×2, Caisse insolvable ×1 |
| Fermeture de la ferme | 2 | non | 35,8 % | 19,6 % | 84,6 % | 18 | non | Inflation quotidienne ×5, Rupture de stock prolongée ×26, Surstock ×3, Entreprise sans client ×41, Entreprise sans employé ×44, Inflation sur 100 jours ×2, Sans-abri nombreux ×3, Inégalités hors bornes ×1, Faim répandue ×2, Richesse médiane hors bornes ×1 |
| Fermeture de la ferme | 3 | non | 85,8 % | 100,0 % | 76,3 % | non (> 470) | non | Inflation quotidienne ×5, Rupture de stock prolongée ×73, Surstock ×9, Entreprise sans client ×132, Entreprise sans employé ×124, Inflation sur 100 jours ×1, Sans-abri nombreux ×3, Faim répandue ×1, Inégalités hors bornes ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 25,8 % | 70,4 % | 21,3 % | 65 | 1 | Inflation quotidienne ×2, Rupture de stock prolongée ×49, Surstock ×15, Entreprise sans client ×60, Entreprise sans employé ×60, Sans-abri nombreux ×5, Faim répandue ×1, Inégalités hors bornes ×1, Caisse insolvable ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 15,8 % | 0,0 % | 6,7 % | 44 | non | Inflation quotidienne ×8, Rupture de stock prolongée ×32, Surstock ×10, Entreprise sans client ×54, Entreprise sans employé ×56 |
| Faillite d’une firme clé | 3 | non | 12,1 % | 0,0 % | 23,3 % | 321 ❌ | 8 | Inflation quotidienne ×8, Rupture de stock prolongée ×33, Surstock ×6, Entreprise sans client ×37, Entreprise sans employé ×36, Inflation sur 100 jours ×1 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 19,2 % | 81,3 % | 67,9 % | non (> 470) | non | Rupture de stock prolongée ×32, Surstock ×7, Entreprise sans client ×29, Entreprise sans employé ×22, Sans-abri nombreux ×5, Inflation quotidienne ×2, Faim répandue ×4, Inégalités hors bornes ×2 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 16,7 % | 28,3 % | 65,8 % | 399 ❌ | 83 | Rupture de stock prolongée ×36, Surstock ×13, Entreprise sans client ×35, Entreprise sans employé ×26, Sans-abri nombreux ×2, Inflation quotidienne ×2, Faim répandue ×2, Inflation sur 100 jours ×2 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 11,3 % | 27,9 % | 20,0 % | 164 | 18 | Rupture de stock prolongée ×26, Sans-abri nombreux ×2, Surstock ×10, Entreprise sans client ×28, Entreprise sans employé ×15, Inflation sur 100 jours ×2, Inflation quotidienne ×2, Faim répandue ×1 |
| +25 immigrants | 1 | non | 14,3 % | 0,0 % | 7,5 % | non (> 470) | non | Rupture de stock prolongée ×2, Entreprise sans client ×4, Entreprise sans employé ×2, Sans-abri nombreux ×2, Inflation quotidienne ×1 |
| +25 immigrants | 2 | non | 14,3 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×2, Surstock ×2, Entreprise sans client ×5, Entreprise sans employé ×5, Inflation quotidienne ×1 |
| +25 immigrants | 3 | non | 17,0 % | 0,0 % | 7,9 % | non (> 470) | 449 | Rupture de stock prolongée ×9, Surstock ×6, Entreprise sans client ×12, Entreprise sans employé ×9, Inflation quotidienne ×2 |
| Salaire minimum 220 $/j | 1 | non | 4,2 % | 0,0 % | 5,0 % | non (> 470) | 324 | Rupture de stock prolongée ×5, Surstock ×2, Entreprise sans client ×8, Entreprise sans employé ×7, Inflation quotidienne ×3 |
| Salaire minimum 220 $/j | 2 | non | 10,4 % | 0,0 % | 0,8 % | 12 | 1 | Rupture de stock prolongée ×4, Surstock ×4, Entreprise sans client ×10, Entreprise sans employé ×7, Inflation quotidienne ×1 |
| Salaire minimum 220 $/j | 3 | non | 17,5 % | 90,4 % | 17,5 % | 21 | 40 | Rupture de stock prolongée ×27, Sans-abri nombreux ×1, Surstock ×14, Entreprise sans client ×23, Entreprise sans employé ×18, Inflation sur 100 jours ×2, Inflation quotidienne ×3, Faim répandue ×3, Inégalités hors bornes ×1 |
| Fermeture de la ferme | 1 | non | 10,8 % | 21,7 % | 26,3 % | non (> 470) | 87 | Rupture de stock prolongée ×9, Surstock ×6, Entreprise sans client ×8, Entreprise sans employé ×7, Sans-abri nombreux ×1, Inflation quotidienne ×3, Faim répandue ×1 |
| Fermeture de la ferme | 2 | non | 9,6 % | 0,0 % | 13,3 % | 1 | 1 | Rupture de stock prolongée ×5, Surstock ×3, Entreprise sans client ×5, Entreprise sans employé ×4, Sans-abri nombreux ×1, Inflation sur 100 jours ×1 |
| Fermeture de la ferme | 3 | non | 19,6 % | 0,0 % | 0,4 % | 278 ❌ | 62 | Rupture de stock prolongée ×18, Surstock ×14, Entreprise sans client ×18, Entreprise sans employé ×13, Inflation quotidienne ×4 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 10,4 % | 0,0 % | 2,5 % | 37 | 37 | Rupture de stock prolongée ×5, Surstock ×5, Entreprise sans client ×8, Entreprise sans employé ×6, Inflation quotidienne ×4 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 11,3 % | 0,0 % | 36,7 % | non (> 470) | 44 | Rupture de stock prolongée ×7, Surstock ×4, Entreprise sans client ×7, Entreprise sans employé ×6, Sans-abri nombreux ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 27,5 % | 46,3 % | 4,2 % | 40 | 8 | Rupture de stock prolongée ×19, Surstock ×11, Entreprise sans client ×21, Entreprise sans employé ×15, Inflation sur 100 jours ×4, Inflation quotidienne ×2, Faim répandue ×1, Caisse insolvable ×1 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 135 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ✅ | toutes les graines |
| Faim et sans-abri < 2 % | ❌ | g2, g4, g5 |
| Gini 0,2–0,45 | ❌ | g5 0,47 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Anti-famine 4,79/50 j, Renflouement d’entreprise 27,56/50 j, Plancher de logement 2,71/50 j, Plafond de dérive des prix et salaires 262,26/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 12/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 9/15 échecs |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 8,1 % | 5,3 % |
| Faim moyenne | 6,4 % | 1,2 % |
| Sans-abri moyen | 10,1 % | 2,6 % |
| Gini moyen | 0,63 | 0,38 |
| Inflation moyenne / jour | -0,043 % | -0,067 % |
| Alertes critiques (total) | 142 | 135 |
| Alertes (total) | 1035 | 1754 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 14,44 | 4,79 |
| Renflouements / 50 j | 22,89 | 27,56 |
| Plancher de logement / 50 j | 2,99 | 2,71 |
| Plafond de dérive / 50 j | 302,96 | 262,26 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |
| Chocs revenus à l’équilibre en < 200 j (sans filets) | 1 | 3 |
| Chocs revenus à l’équilibre en < 200 j (avec filets) | 7 | 6 |

