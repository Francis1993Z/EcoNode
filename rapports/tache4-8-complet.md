# Protocole de stabilité ÉcoNodes

- Date : 2026-10-04 19:37
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : aucun

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 70,6 % | 85,8 % | 65,9 % | 98,8 % | 97,8 % | 100,0 % | 0,47 | 0,88 | -0,000 % | 38,4 % | 35295,2 % | 131 (11) | 0.0e+0 |
| 2 | 50,8 % | 77,1 % | 50,3 % | 99,6 % | 73,8 % | 100,0 % | 0,62 | 0,17 | -0,009 % | 38,4 % | 24355,9 % | 165 (11) | 0.0e+0 |
| 3 | 77,0 % | 94,6 % | 92,9 % | 100,0 % | 80,2 % | 100,0 % | 0,94 | 0,77 | 0,029 % | 40,2 % | 2658,6 % | 188 (14) | 0.0e+0 |
| 4 | 24,2 % | 75,8 % | 8,2 % | 97,5 % | 83,8 % | 100,0 % | 0,88 | 0,51 | -0,007 % | 42,8 % | 34418,1 % | 158 (15) | 0.0e+0 |
| 5 | 89,0 % | 97,9 % | 86,3 % | 98,3 % | 89,0 % | 100,0 % | 0,62 | 0,20 | 0,014 % | 40,9 % | 48809,5 % | 165 (11) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 1 · 1407 j | 3 · 1085 j | 2 · 1206 j | 1 · 468 j | 1 · 1433 j |
| Faim répandue | critique | 5 · 1092 j | 2 · 759 j | 2 · 1375 j | 7 · 316 j | 4 · 1322 j |
| Sans-abri nombreux | critique | 2 · 1445 j | 3 · 1365 j | 3 · 1348 j | 3 · 1418 j | 2 · 1450 j |
| Inégalités hors bornes | attention | 3 · 487 j | 2 · 802 j | 1 · 1370 j | 5 · 1267 j | 1 · 843 j |
| Richesse médiane hors bornes | attention | 1 · 331 j | 2 · 727 j | 1 · 1000 j | 2 · 1122 j | 1 · 835 j |
| Inflation quotidienne | critique | 2 · 43 j | 2 · 46 j | 5 · 40 j | 3 · 40 j | 3 · 42 j |
| Inflation sur 100 jours | critique | 1 · 52 j | 1 · 49 j | 2 · 74 j | 1 · 50 j | 1 · 52 j |
| Rupture de stock prolongée | attention | 13 · 7348 j | 30 · 7987 j | 42 · 13492 j | 25 · 4297 j | 28 · 7599 j |
| Surstock | attention | 18 · 21207 j | 29 · 16900 j | 31 · 9125 j | 27 · 19808 j | 22 · 20035 j |
| Entreprise sans employé | attention | 31 · 37189 j | 35 · 30762 j | 46 · 30833 j | 33 · 29845 j | 36 · 37866 j |
| Entreprise sans client | attention | 53 · 33002 j | 55 · 25999 j | 52 · 29174 j | 51 · 26019 j | 65 · 33262 j |
| Caisse insolvable | attention | 1 · 1380 j | 1 · 560 j | 1 · 1067 j | · | 1 · 562 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 0,0 % | 50,3 % | 49,7 % | 29 | 0 $ | 62 639 $ | 27 650 $ |
| 2 | 2,4 % | 3,5 % | 94,1 % | 27 | 0 $ | 434 444 $ | 226 006 $ |
| 3 | 2,5 % | 2,5 % | 94,9 % | 28 | 0 $ | 436 079 $ | 50 250 $ |
| 4 | 20,4 % | 41,2 % | 38,4 % | 24 | 248 350 $ | 377 860 $ | 18 055 $ |
| 5 | 0,0 % | 100,0 % | 0,0 % | 31 | 0 $ | 403 003 $ | 134 969 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,4 % | 36,3 % | 1,8 % | 95,0 % | 3,2 % | 100,0 % | 0,36 | 0,21 | 0,077 % | 2,2 % | 189,3 % | 313 (16) | 0.0e+0 |
| 2 | 3,1 % | 21,3 % | 0,2 % | 39,2 % | 0,6 % | 100,0 % | 0,20 | 0,13 | 0,062 % | 2,0 % | 159,1 % | 200 (6) | 0.0e+0 |
| 3 | 7,0 % | 23,8 % | 0,3 % | 43,3 % | 4,9 % | 100,0 % | 0,37 | 0,40 | -0,010 % | 2,2 % | 173,8 % | 293 (15) | 0.0e+0 |
| 4 | 7,4 % | 41,7 % | 0,4 % | 52,1 % | 2,8 % | 100,0 % | 0,34 | 0,22 | 0,044 % | 2,2 % | 150,9 % | 260 (10) | 0.0e+0 |
| 5 | 4,9 % | 31,3 % | 0,0 % | 32,1 % | 1,8 % | 97,1 % | 0,28 | 0,15 | 0,025 % | 2,7 % | 178,1 % | 237 (9) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 1469 · 51,61 | 74 · 1,25 | 61 · 1,93 | 174 · 4,89 | 1 · 0,00 | 11,94 ❌ | pas de producteur (100 %) |
| Renflouement d’entreprise | 628 · 20,36 | 689 · 22,82 | 605 · 19,50 | 624 · 20,07 | 504 · 15,89 | 19,73 ❌ | par le propriétaire (95 %) ; après rachat (5 %) |
| Plancher de logement | 2521 · 87,79 | 348 · 12,43 | 4557 · 162,71 | 3150 · 96,61 | 2362 · 69,71 | 85,85 ❌ | parc plein (95 %) ; prix trop élevé (5 %) |
| Plafond de dérive des prix et salaires | 12658 · 387,71 | 9697 · 287,79 | 12355 · 381,79 | 11076 · 324,64 | 8091 · 220,89 | 320,56 ❌ | hausse de prix (63 %) ; baisse de prix (34 %) |
| Anti-crédit-fou | 31 · 1,11 | 2 · 0,07 | 1195 · 42,68 | 414 · 14,79 | 811 · 28,96 | 17,52 ❌ | fonds propres de la Caisse insuffisants (99 %) ; paiements > 35 % de la valeur ajoutée (1 %) |

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage 3–10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non (effondrée) | 67,5 % | 95,0 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×18, Sans-abri nombreux ×4, Surstock ×9, Entreprise sans employé ×13, Entreprise sans client ×29, Inégalités hors bornes ×1, Richesse médiane hors bornes ×2, Chômage très élevé ×2, Faim répandue ×2, Caisse insolvable ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non (effondrée) | 50,0 % | 89,2 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×19, Surstock ×14, Entreprise sans client ×38, Entreprise sans employé ×13, Sans-abri nombreux ×2, Inégalités hors bornes ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×1, Faim répandue ×5, Caisse insolvable ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 53,3 % | 90,4 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×24, Faim répandue ×7, Surstock ×18, Entreprise sans client ×33, Entreprise sans employé ×26, Inflation sur 100 jours ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×2, Chômage très élevé ×2, Caisse insolvable ×1 |
| +25 immigrants | 1 | non (effondrée) | 85,7 % | 98,5 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×8, Surstock ×2, Entreprise sans employé ×10, Entreprise sans client ×26, Inégalités hors bornes ×1, Faim répandue ×2 |
| +25 immigrants | 2 | non (effondrée) | 75,1 % | 98,1 % | 76,6 % | s. o. | s. o. | Rupture de stock prolongée ×16, Surstock ×1, Entreprise sans client ×7, Entreprise sans employé ×2, Sans-abri nombreux ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×1, Faim répandue ×1 |
| +25 immigrants | 3 | non | 79,6 % | 96,2 % | 96,2 % | non (> 470) | non | Inflation quotidienne ×1, Rupture de stock prolongée ×9, Surstock ×17, Entreprise sans client ×16, Entreprise sans employé ×13, Inflation sur 100 jours ×1, Caisse insolvable ×1 |
| Salaire minimum 220 $/j | 1 | non (effondrée) | 96,7 % | 98,3 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×8, Surstock ×3, Entreprise sans employé ×10, Entreprise sans client ×32, Inégalités hors bornes ×3, Richesse médiane hors bornes ×4, Faim répandue ×8 |
| Salaire minimum 220 $/j | 2 | non (effondrée) | 95,4 % | 97,5 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×8, Surstock ×3, Entreprise sans client ×27, Entreprise sans employé ×12, Faim répandue ×1, Caisse insolvable ×1 |
| Salaire minimum 220 $/j | 3 | non | 82,5 % | 96,3 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×12, Surstock ×3, Entreprise sans client ×25, Entreprise sans employé ×19, Inflation sur 100 jours ×1, Caisse insolvable ×1 |
| Fermeture de la ferme | 1 | non (effondrée) | 95,8 % | 98,8 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×7, Surstock ×1, Entreprise sans employé ×10, Entreprise sans client ×24, Inégalités hors bornes ×1, Faim répandue ×1 |
| Fermeture de la ferme | 2 | non (effondrée) | 98,3 % | 100,0 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×10, Surstock ×3, Entreprise sans client ×27, Entreprise sans employé ×12, Faim répandue ×1, Caisse insolvable ×1 |
| Fermeture de la ferme | 3 | non | 88,8 % | 98,3 % | 92,9 % | non (> 470) | non | Inflation quotidienne ×2, Rupture de stock prolongée ×16, Surstock ×1, Entreprise sans client ×17, Entreprise sans employé ×13, Inflation sur 100 jours ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non (effondrée) | 90,4 % | 98,8 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×8, Surstock ×4, Entreprise sans employé ×10, Entreprise sans client ×27, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×2, Faim répandue ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non (effondrée) | 63,3 % | 92,1 % | 100,0 % | s. o. | s. o. | Rupture de stock prolongée ×9, Surstock ×7, Entreprise sans client ×21, Entreprise sans employé ×11, Inégalités hors bornes ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×1, Faim répandue ×3 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 98,8 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×11, Surstock ×7, Entreprise sans client ×29, Entreprise sans employé ×23, Inflation sur 100 jours ×1, Richesse médiane hors bornes ×1, Caisse insolvable ×1 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 27,5 % | 71,3 % | 100,0 % | non (> 470) | 411 | Rupture de stock prolongée ×31, Surstock ×18, Faim répandue ×2, Sans-abri nombreux ×8, Entreprise sans employé ×22, Entreprise sans client ×29, Inégalités hors bornes ×2 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 32,9 % | 65,4 % | 85,8 % | non (> 470) | 122 | Rupture de stock prolongée ×45, Faim répandue ×4, Sans-abri nombreux ×7, Surstock ×30, Entreprise sans employé ×24, Entreprise sans client ×44, Inflation sur 100 jours ×1, Inégalités hors bornes ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 40,4 % | 77,1 % | 97,5 % | non (> 470) | 455 | Rupture de stock prolongée ×42, Surstock ×30, Faim répandue ×5, Sans-abri nombreux ×4, Entreprise sans employé ×25, Entreprise sans client ×51, Inflation sur 100 jours ×1, Inégalités hors bornes ×2, Chômage très élevé ×1, Richesse médiane hors bornes ×1, Caisse insolvable ×1 |
| +25 immigrants | 1 | non | 31,7 % | 0,0 % | 27,2 % | non (> 470) | non | Rupture de stock prolongée ×9, Surstock ×29, Sans-abri nombreux ×1, Entreprise sans employé ×15, Entreprise sans client ×37 |
| +25 immigrants | 2 | non | 20,4 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×6, Sans-abri nombreux ×1, Surstock ×22, Entreprise sans employé ×7, Entreprise sans client ×24 |
| +25 immigrants | 3 | non | 35,8 % | 36,2 % | 97,7 % | non (> 470) | non | Rupture de stock prolongée ×23, Surstock ×26, Faim répandue ×2, Sans-abri nombreux ×5, Entreprise sans employé ×12, Entreprise sans client ×33, Inégalités hors bornes ×1, Chômage très élevé ×2 |
| Salaire minimum 220 $/j | 1 | non | 22,5 % | 0,0 % | 10,8 % | 201 ❌ | non | Rupture de stock prolongée ×11, Surstock ×28, Sans-abri nombreux ×1, Entreprise sans employé ×17, Entreprise sans client ×37, Inflation sur 100 jours ×2 |
| Salaire minimum 220 $/j | 2 | non | 12,1 % | 0,0 % | 0,4 % | 31 | 3 | Rupture de stock prolongée ×4, Surstock ×17, Entreprise sans employé ×7, Entreprise sans client ×22 |
| Salaire minimum 220 $/j | 3 | non | 22,9 % | 0,0 % | 33,8 % | 15 | 336 | Rupture de stock prolongée ×18, Surstock ×29, Sans-abri nombreux ×1, Entreprise sans employé ×15, Entreprise sans client ×35, Inflation sur 100 jours ×1 |
| Fermeture de la ferme | 1 | non | 32,9 % | 82,9 % | 100,0 % | 181 | 216 | Rupture de stock prolongée ×18, Surstock ×26, Faim répandue ×1, Sans-abri nombreux ×4, Entreprise sans employé ×19, Entreprise sans client ×30, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| Fermeture de la ferme | 2 | non | 17,9 % | 75,8 % | 18,3 % | 175 | 175 | Rupture de stock prolongée ×17, Faim répandue ×1, Sans-abri nombreux ×2, Surstock ×20, Entreprise sans employé ×17, Entreprise sans client ×29, Caisse insolvable ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| Fermeture de la ferme | 3 | non | 36,3 % | 79,2 % | 75,4 % | non (> 470) | 278 | Rupture de stock prolongée ×27, Surstock ×19, Faim répandue ×1, Sans-abri nombreux ×4, Entreprise sans employé ×18, Entreprise sans client ×32, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Caisse insolvable ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 24,2 % | 0,0 % | 8,8 % | 149 | 212 | Rupture de stock prolongée ×12, Surstock ×24, Entreprise sans employé ×14, Entreprise sans client ×31, Inflation sur 100 jours ×2 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 14,2 % | 0,0 % | 3,8 % | non (> 470) | 8 | Rupture de stock prolongée ×7, Surstock ×15, Entreprise sans employé ×8, Entreprise sans client ×21 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 21,7 % | 59,6 % | 10,8 % | 360 ❌ | 36 | Rupture de stock prolongée ×28, Surstock ×22, Faim répandue ×2, Sans-abri nombreux ×1, Entreprise sans employé ×9, Entreprise sans client ×28 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 62 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g1 70,6 %, g2 50,8 %, g3 77,0 %, g4 24,2 %, g5 89,0 % |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ❌ | g1 0,47, g2 0,62, g3 0,94, g4 0,88, g5 0,62 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Anti-famine 11,94/50 j, Renflouement d’entreprise 19,73/50 j, Plancher de logement 85,85/50 j, Plafond de dérive des prix et salaires 320,56/50 j, Anti-crédit-fou 17,52/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 15/15 échecs (dont 10 sur économie déjà effondrée) |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 10/15 échecs |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 86,9 % | 62,3 % |
| Faim moyenne | 87,0 % | 60,7 % |
| Sans-abri moyen | 95,9 % | 84,9 % |
| Gini moyen | 0,59 | 0,70 |
| Inflation moyenne / jour | 0,042 % | 0,005 % |
| Alertes critiques (total) | 55 | 62 |
| Alertes (total) | 666 | 807 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 11,94 |
| Renflouements / 50 j | 66,05 | 19,73 |
| Plancher de logement / 50 j | 12,66 | 85,85 |
| Plafond de dérive / 50 j | 226,54 | 320,56 |
| Anti-crédit-fou / 50 j | 67,14 | 17,52 |
| Chocs revenus à l’équilibre en < 200 j (sans filets) | 0 | 0 |
| Chocs revenus à l’équilibre en < 200 j (avec filets) | 5 | 5 |

