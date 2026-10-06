# Protocole de stabilité ÉcoNodes

- Date : 2026-10-04 19:07
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : aucun

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 67,5 % | 94,2 % | 61,0 % | 100,0 % | 84,9 % | 100,0 % | 0,98 | 0,99 | -0,404 % | 58,4 % | 173286,9 % | 247 (17) | 0.0e+0 |
| 2 | 46,2 % | 98,3 % | 36,9 % | 100,0 % | 100,0 % | 100,0 % | 0,95 | 0,98 | -0,511 % | 48,9 % | 1266827,9 % | 205 (27) | 0.0e+0 |
| 3 | 76,9 % | 98,8 % | 71,8 % | 100,0 % | 89,7 % | 100,0 % | 0,92 | 0,99 | -0,454 % | 55,2 % | 268527,6 % | 269 (48) | 0.0e+0 |
| 4 | 87,7 % | 97,5 % | 91,9 % | 100,0 % | 90,0 % | 100,0 % | 0,91 | 0,81 | -0,454 % | 49,0 % | 658977,6 % | 274 (21) | 0.0e+0 |
| 5 | 75,3 % | 96,7 % | 70,1 % | 100,0 % | 94,5 % | 100,0 % | 0,94 | 0,79 | -0,376 % | 70,7 % | 234066,5 % | 203 (13) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 3 · 1253 j | 1 · 748 j | 1 · 1437 j | 1 · 1435 j | 1 · 1438 j |
| Faim répandue | critique | 7 · 1285 j | 15 · 699 j | 25 · 1335 j | 3 · 1409 j | 1 · 1450 j |
| Sans-abri nombreux | critique | 1 · 1454 j | 4 · 1472 j | 1 · 1456 j | 1 · 1453 j | 2 · 1460 j |
| Inégalités hors bornes | attention | 3 · 1414 j | 2 · 1357 j | 5 · 1262 j | 3 · 1346 j | 2 · 1399 j |
| Richesse médiane hors bornes | attention | 1 · 1451 j | 1 · 1452 j | 3 · 1388 j | 1 · 1374 j | 1 · 1452 j |
| Inflation quotidienne | critique | 4 · 54 j | 6 · 112 j | 18 · 209 j | 14 · 150 j | 8 · 55 j |
| Inflation sur 100 jours | critique | 2 · 116 j | 1 · 44 j | 3 · 205 j | 2 · 127 j | 1 · 41 j |
| Rupture de stock prolongée | attention | 22 · 8425 j | 17 · 5097 j | 19 · 5792 j | 38 · 9530 j | 18 · 6252 j |
| Surstock | attention | 54 · 13692 j | 33 · 19762 j | 49 · 17886 j | 50 · 16037 j | 34 · 18669 j |
| Entreprise sans employé | attention | 53 · 31614 j | 43 · 39122 j | 53 · 34968 j | 50 · 36443 j | 42 · 35827 j |
| Entreprise sans client | attention | 97 · 28892 j | 82 · 37309 j | 92 · 31283 j | 111 · 33689 j | 93 · 33726 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 86,7 % | 9,4 % | 3,9 % | 25 | 0 $ | 352 701 $ | 90 383 $ |
| 2 | 89,1 % | 10,9 % | 0,0 % | 27 | 0 $ | 153 898 $ | 16 464 $ |
| 3 | 88,7 % | 9,3 % | 2,1 % | 26 | 0 $ | 481 884 $ | 217 847 $ |
| 4 | 30,8 % | 61,5 % | 7,7 % | 29 | 0 $ | 434 884 $ | 112 236 $ |
| 5 | 21,7 % | 65,2 % | 13,0 % | 28 | 0 $ | 87 110 $ | 32 443 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 23,7 % | 40,0 % | 0,0 % | 0,0 % | 0,0 % | 5,0 % | 0,87 | 0,96 | -0,073 % | 3,2 % | 205,3 % | 162 (4) | 0.0e+0 |
| 2 | 21,0 % | 32,9 % | 0,0 % | 0,0 % | 0,0 % | 41,3 % | 0,84 | 0,95 | -0,095 % | 3,4 % | 193,1 % | 192 (5) | 0.0e+0 |
| 3 | 13,8 % | 26,3 % | 0,0 % | 0,0 % | 0,0 % | 2,5 % | 0,81 | 0,92 | -0,040 % | 2,7 % | 184,0 % | 174 (3) | 0.0e+0 |
| 4 | 20,5 % | 41,3 % | 0,0 % | 0,0 % | 0,0 % | 5,0 % | 0,82 | 0,95 | -0,046 % | 3,1 % | 339,9 % | 172 (2) | 0.0e+0 |
| 5 | 32,1 % | 45,4 % | 0,0 % | 0,0 % | 0,0 % | 1,7 % | 0,89 | 0,96 | -0,104 % | 3,3 % | 218,3 % | 153 (4) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 478 · 14,71 | 431 · 13,25 | 512 · 15,89 | 553 · 17,29 | 381 · 11,32 | 14,49 ❌ | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0 · 0,00 | 104 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 7775 · 214,82 | 7311 · 203,00 | 8506 · 247,86 | 8100 · 226,68 | 8448 · 240,93 | 226,66 ❌ | hausse de prix (60 %) ; baisse de prix (39 %) |
| Anti-crédit-fou | 4433 · 154,14 | 4193 · 143,96 | 4303 · 146,07 | 2736 · 90,46 | 5201 · 179,21 | 142,77 ❌ | fonds propres de la Caisse insuffisants (100 %) ; paiements > 35 % de la valeur ajoutée (0 %) |

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage 3–10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non (effondrée) | 88,8 % | 94,2 % | 95,8 % | s. o. | s. o. | Inflation quotidienne ×2, Rupture de stock prolongée ×11, Surstock ×29, Entreprise sans client ×45, Entreprise sans employé ×16, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Faim répandue ×1, Chômage très élevé ×1, Inflation sur 100 jours ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non (effondrée) | 93,8 % | 95,0 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×15, Inflation quotidienne ×2, Surstock ×13, Entreprise sans employé ×15, Entreprise sans client ×38, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×2 |
| Hélicoptère 5 000 $/citoyen | 3 | non (effondrée) | 99,2 % | 100,0 % | 100,0 % | s. o. | s. o. | Inflation quotidienne ×11, Rupture de stock prolongée ×17, Surstock ×29, Entreprise sans client ×57, Entreprise sans employé ×29, Faim répandue ×6, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×1, Inflation sur 100 jours ×2 |
| +25 immigrants | 1 | non (effondrée) | 90,9 % | 97,0 % | 97,4 % | s. o. | s. o. | Inflation quotidienne ×1, Rupture de stock prolongée ×10, Surstock ×15, Entreprise sans client ×34, Entreprise sans employé ×12, Faim répandue ×2 |
| +25 immigrants | 2 | non (effondrée) | 94,3 % | 97,0 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×9, Inflation quotidienne ×1, Surstock ×11, Entreprise sans employé ×12, Entreprise sans client ×30, Faim répandue ×4 |
| +25 immigrants | 3 | non (effondrée) | 91,3 % | 98,9 % | 98,1 % | s. o. | s. o. | Inflation quotidienne ×8, Rupture de stock prolongée ×12, Surstock ×19, Entreprise sans client ×38, Entreprise sans employé ×14, Faim répandue ×1, Inflation sur 100 jours ×1 |
| Salaire minimum 220 $/j | 1 | non (effondrée) | 92,5 % | 97,1 % | 95,8 % | s. o. | s. o. | Rupture de stock prolongée ×12, Surstock ×18, Entreprise sans client ×45, Entreprise sans employé ×15, Faim répandue ×1 |
| Salaire minimum 220 $/j | 2 | non (effondrée) | 95,8 % | 97,9 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×8, Surstock ×4, Entreprise sans employé ×9, Entreprise sans client ×24, Faim répandue ×19, Inflation sur 100 jours ×1 |
| Salaire minimum 220 $/j | 3 | non (effondrée) | 91,7 % | 91,3 % | 96,3 % | s. o. | s. o. | Rupture de stock prolongée ×11, Surstock ×21, Entreprise sans client ×44, Entreprise sans employé ×13, Faim répandue ×2, Chômage très élevé ×1 |
| Fermeture de la ferme | 1 | non (effondrée) | 92,5 % | 99,6 % | 95,8 % | s. o. | s. o. | Inflation quotidienne ×4, Rupture de stock prolongée ×12, Surstock ×22, Entreprise sans client ×37, Entreprise sans employé ×17, Faim répandue ×6, Chômage très élevé ×2, Inflation sur 100 jours ×1 |
| Fermeture de la ferme | 2 | non (effondrée) | 94,2 % | 93,3 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×6, Surstock ×4, Entreprise sans employé ×7, Entreprise sans client ×24, Faim répandue ×3 |
| Fermeture de la ferme | 3 | non (effondrée) | 92,5 % | 95,4 % | 97,1 % | s. o. | s. o. | Rupture de stock prolongée ×6, Surstock ×26, Entreprise sans client ×42, Entreprise sans employé ×17, Faim répandue ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non (effondrée) | 98,8 % | 100,0 % | 100,0 % | s. o. | s. o. | Inflation quotidienne ×2, Rupture de stock prolongée ×9, Surstock ×4, Entreprise sans client ×32, Entreprise sans employé ×11, Inflation sur 100 jours ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non (effondrée) | 99,2 % | 100,0 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×11, Inflation quotidienne ×2, Surstock ×6, Entreprise sans employé ×10, Entreprise sans client ×29, Faim répandue ×7 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non (effondrée) | 99,2 % | 100,0 % | 100,0 % | s. o. | s. o. | Inflation quotidienne ×1, Rupture de stock prolongée ×11, Surstock ×4, Entreprise sans client ×35, Entreprise sans employé ×13, Inflation sur 100 jours ×1 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 34,2 % | 0,0 % | 25,8 % | non (> 470) | non | Rupture de stock prolongée ×18, Surstock ×19, Entreprise sans client ×17, Entreprise sans employé ×8, Inégalités hors bornes ×1, Sans-abri nombreux ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 43,8 % | 62,5 % | 35,0 % | non (> 470) | non | Rupture de stock prolongée ×22, Sans-abri nombreux ×1, Entreprise sans client ×25, Surstock ×20, Entreprise sans employé ×13, Inflation sur 100 jours ×3, Inégalités hors bornes ×1, Faim répandue ×1, Chômage très élevé ×2 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 40,0 % | 53,8 % | 48,3 % | non (> 470) | 393 | Rupture de stock prolongée ×23, Surstock ×28, Entreprise sans client ×32, Entreprise sans employé ×14, Inégalités hors bornes ×1, Sans-abri nombreux ×1, Faim répandue ×1, Chômage très élevé ×1 |
| +25 immigrants | 1 | non | 46,8 % | 0,0 % | 14,7 % | non (> 470) | non | Rupture de stock prolongée ×10, Surstock ×17, Entreprise sans client ×19, Entreprise sans employé ×5, Sans-abri nombreux ×5 |
| +25 immigrants | 2 | non | 47,5 % | 0,0 % | 18,5 % | non (> 470) | non | Rupture de stock prolongée ×21, Sans-abri nombreux ×10, Entreprise sans client ×28, Surstock ×17, Entreprise sans employé ×10, Chômage très élevé ×1 |
| +25 immigrants | 3 | non | 47,9 % | 0,0 % | 20,4 % | non (> 470) | non | Rupture de stock prolongée ×10, Surstock ×16, Entreprise sans client ×21, Entreprise sans employé ×8, Inflation sur 100 jours ×1, Chômage très élevé ×1, Sans-abri nombreux ×8 |
| Salaire minimum 220 $/j | 1 | non | 39,6 % | 0,0 % | 0,0 % | non (> 470) | 10 | Rupture de stock prolongée ×5, Surstock ×13, Entreprise sans client ×15, Entreprise sans employé ×4, Inflation sur 100 jours ×1, Chômage très élevé ×1 |
| Salaire minimum 220 $/j | 2 | non | 32,5 % | 0,0 % | 0,0 % | non (> 470) | 3 | Rupture de stock prolongée ×13, Entreprise sans client ×26, Surstock ×19, Entreprise sans employé ×9 |
| Salaire minimum 220 $/j | 3 | non | 30,8 % | 0,0 % | 0,0 % | non (> 470) | 253 | Rupture de stock prolongée ×11, Surstock ×12, Entreprise sans client ×10, Entreprise sans employé ×4 |
| Fermeture de la ferme | 1 | non | 76,7 % | 98,3 % | 56,7 % | non (> 470) | non | Rupture de stock prolongée ×13, Surstock ×17, Entreprise sans client ×32, Entreprise sans employé ×21, Faim répandue ×1, Richesse médiane hors bornes ×1, Sans-abri nombreux ×3 |
| Fermeture de la ferme | 2 | non | 63,7 % | 96,3 % | 46,7 % | non (> 470) | non | Rupture de stock prolongée ×12, Sans-abri nombreux ×3, Entreprise sans client ×23, Surstock ×17, Entreprise sans employé ×15, Faim répandue ×3, Chômage très élevé ×1, Richesse médiane hors bornes ×1 |
| Fermeture de la ferme | 3 | non | 64,6 % | 77,1 % | 49,6 % | non (> 470) | non | Rupture de stock prolongée ×10, Surstock ×20, Entreprise sans client ×18, Entreprise sans employé ×13, Inflation sur 100 jours ×1, Faim répandue ×7, Sans-abri nombreux ×6, Richesse médiane hors bornes ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 35,8 % | 0,0 % | 0,0 % | 462 ❌ | 21 | Rupture de stock prolongée ×11, Surstock ×17, Entreprise sans client ×18, Entreprise sans employé ×5 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 29,2 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×17, Entreprise sans client ×31, Surstock ×15, Entreprise sans employé ×11 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 21,7 % | 0,0 % | 0,0 % | 306 ❌ | non | Rupture de stock prolongée ×5, Surstock ×20, Entreprise sans client ×17, Entreprise sans employé ×7 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 126 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g1 67,5 %, g2 46,2 %, g3 76,9 %, g4 87,7 %, g5 75,3 % |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ❌ | g1 0,98, g2 0,95, g3 0,92, g4 0,91, g5 0,94 |
| Inflation moyenne < ±0,5 %/j | ❌ | g2 -0,511 %/j |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 14,49/50 j, Plafond de dérive des prix et salaires 226,66/50 j, Anti-crédit-fou 142,77/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 15/15 échecs (dont 15 sur économie déjà effondrée) |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 15/15 échecs |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 86,9 % | 70,7 % |
| Faim moyenne | 87,0 % | 66,3 % |
| Sans-abri moyen | 95,9 % | 91,8 % |
| Gini moyen | 0,59 | 0,94 |
| Inflation moyenne / jour | 0,042 % | -0,440 % |
| Alertes critiques (total) | 55 | 126 |
| Alertes (total) | 666 | 1198 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 0,00 |
| Renflouements / 50 j | 66,05 | 14,49 |
| Plancher de logement / 50 j | 12,66 | 0,00 |
| Plafond de dérive / 50 j | 226,54 | 226,66 |
| Anti-crédit-fou / 50 j | 67,14 | 142,77 |
| Chocs revenus à l’équilibre en < 200 j (sans filets) | 0 | 0 |
| Chocs revenus à l’équilibre en < 200 j (avec filets) | 5 | 0 |

