# Protocole de stabilité ÉcoNodes

- Date : 2026-10-10 13:59
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Assurance-emploi indexée et aide sociale

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,0 % | 39,6 % | 7,2 % | 94,6 % | 2,2 % | 41,7 % | 0,35 | 0,46 | 0,051 % | 32,2 % | 141,6 % | 631 (32) | 0.0e+0 |
| 2 | 8,1 % | 22,5 % | 6,5 % | 88,3 % | 3,6 % | 50,0 % | 0,40 | 0,55 | 0,063 % | 48,5 % | 153,8 % | 436 (42) | 0.0e+0 |
| 3 | 9,5 % | 27,5 % | 8,1 % | 95,0 % | 1,6 % | 75,8 % | 0,36 | 0,25 | 0,044 % | 95,0 % | 104,7 % | 571 (27) | 0.0e+0 |
| 4 | 75,8 % | 99,6 % | 79,1 % | 100,0 % | 77,0 % | 100,0 % | 0,30 | 0,34 | 0,065 % | 16,0 % | 136,5 % | 553 (14) | 0.0e+0 |
| 5 | 6,4 % | 23,3 % | 0,1 % | 30,0 % | 0,3 % | 27,9 % | 0,22 | 0,36 | 0,079 % | 29,0 % | 126,9 % | 313 (14) | 0.0e+0 |

Santé moyenne de la population : g1 0,20, g2 0,28, g3 0,16, g4 0,15, g5 0,22.

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 1 · 99 j | · | · | 1 · 1053 j | · |
| Faim répandue | critique | 6 · 146 j | 8 · 148 j | 5 · 158 j | 2 · 1117 j | 1 · 5 j |
| Sans-abri nombreux | critique | 8 · 176 j | 17 · 206 j | 12 · 104 j | 3 · 1127 j | 3 · 18 j |
| Inégalités hors bornes | attention | 2 · 127 j | 4 · 269 j | 4 · 197 j | · | · |
| Richesse médiane hors bornes | attention | · | 2 · 6 j | · | 4 · 107 j | · |
| Inflation quotidienne | critique | 13 · 13 j | 12 · 12 j | 8 · 8 j | 5 · 5 j | 7 · 7 j |
| Inflation sur 100 jours | critique | 3 · 80 j | 4 · 64 j | 1 · 80 j | 2 · 27 j | 2 · 28 j |
| Rupture de stock prolongée | attention | 163 · 5513 j | 106 · 4381 j | 156 · 5447 j | 104 · 6406 j | 75 · 3039 j |
| Surstock | attention | 44 · 1846 j | 33 · 1193 j | 38 · 1171 j | 23 · 853 j | 22 · 1031 j |
| Entreprise sans employé | attention | 166 · 2627 j | 101 · 1367 j | 149 · 2081 j | 183 · 4584 j | 88 · 1221 j |
| Entreprise sans client | attention | 189 · 5778 j | 117 · 5033 j | 157 · 5536 j | 206 · 8758 j | 97 · 3501 j |
| Caisse insolvable | attention | · | · | · | 1 · 1070 j | · |
| Santé de la population effondrée | critique | 1 · 1151 j | 1 · 1005 j | 1 · 1213 j | 1 · 1218 j | 1 · 1110 j |
| Productivité du travail effondrée | attention | 1 · 1151 j | 1 · 1005 j | 1 · 1212 j | 1 · 1218 j | 1 · 1106 j |
| Pénurie de main-d’œuvre | attention | 1 · 1 j | 1 · 7 j | · | 1 · 4 j | · |
| Embauches bloquées faute de moyens | attention | 8 · 542 j | 7 · 244 j | 12 · 369 j | 3 · 1141 j | 3 · 60 j |
| Prix aberrant | attention | 22 · 2974 j | 20 · 1878 j | 23 · 2741 j | 10 · 1990 j | 12 · 2146 j |
| Attente trop longue (service public) | attention | 2 · 1413 j | 2 · 1207 j | 2 · 1323 j | 2 · 2312 j | 1 · 1284 j |
| Prestations réduites faute de trésor | attention | 1 · 188 j | · | 2 · 25 j | 1 · 1070 j | · |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 9,5 % | 23,8 % | 66,7 % | 6 | 4 234 $ | 97 701 $ | 18 317 $ |
| 2 | 15,9 % | 24,7 % | 59,4 % | 1 | 19 836 $ | 198 027 $ | 26 143 $ |
| 3 | 8,4 % | 29,9 % | 61,7 % | 4 | 13 500 $ | 117 264 $ | 13 042 $ |
| 4 | 0,0 % | 0,0 % | 100,0 % | 8 | 0 $ | 74 174 $ | 32 097 $ |
| 5 | 10,3 % | 20,1 % | 69,6 % | 1 | 23 798 $ | 139 442 $ | 14 318 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,4 % | 17,5 % | 0,1 % | 54,2 % | 0,0 % | 11,7 % | 0,17 | 0,13 | 0,028 % | 34,9 % | 145,7 % | 126 (16) | 0.0e+0 |
| 2 | 8,2 % | 16,3 % | 0,0 % | 0,0 % | 0,0 % | 5,0 % | 0,22 | 0,18 | 0,048 % | 56,9 % | 174,8 % | 108 (4) | 0.0e+0 |
| 3 | 8,8 % | 32,1 % | 0,9 % | 77,5 % | 0,0 % | 55,4 % | 0,25 | 0,25 | 0,068 % | 26,1 % | 146,7 % | 238 (11) | 0.0e+0 |
| 4 | 6,3 % | 17,9 % | 0,2 % | 63,7 % | 0,0 % | 34,2 % | 0,18 | 0,17 | -0,003 % | 65,5 % | 80,8 % | 157 (9) | 0.0e+0 |
| 5 | 7,5 % | 16,7 % | 0,0 % | 0,0 % | 0,0 % | 9,6 % | 0,18 | 0,18 | 0,049 % | 54,9 % | 144,7 % | 234 (11) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 27 · 0,96 | 0 · 0,00 | 764 · 27,18 | 57 · 2,04 | 0 · 0,00 | 6,04 ❌ | pas de producteur (100 %) |
| Renflouement d’entreprise | 380 · 12,11 | 473 · 15,43 | 645 · 21,64 | 464 · 15,36 | 593 · 19,46 | 16,80 ❌ | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 1 · 0,00 | 0 · 0,00 | 254 · 0,00 | 81 · 0,04 | 0 · 0,00 | 0,01 ✅ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

Renflouements en régime, par type d’entreprise (toutes graines) : Tourisme 387, Fonderie 296, Garage 290, Ferme 255, Bijouterie 252, Pêcherie 206, Aluminerie 116, Hôtel 87.

Santé moyenne de la population : g1 0,88, g2 0,88, g3 0,19, g4 0,88, g5 0,81.

## 2 bis. Avec filets, sauf : Anti-famine

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,6 % | 17,5 % | 0,2 % | 54,2 % | 0,0 % | 11,7 % | 0,17 | 0,12 | 0,035 % | 34,9 % | 145,7 % | 128 (16) | 0.0e+0 |
| 2 | 8,2 % | 16,3 % | 0,0 % | 0,0 % | 0,0 % | 5,0 % | 0,22 | 0,18 | 0,048 % | 56,9 % | 174,8 % | 108 (4) | 0.0e+0 |
| 3 | 8,3 % | 30,8 % | 1,9 % | 92,9 % | 0,3 % | 55,4 % | 0,26 | 0,28 | 0,046 % | 9,4 % | 101,3 % | 279 (10) | 0.0e+0 |
| 4 | 6,2 % | 17,9 % | 0,2 % | 63,7 % | 0,0 % | 34,2 % | 0,18 | 0,11 | -0,011 % | 65,5 % | 80,8 % | 153 (10) | 0.0e+0 |
| 5 | 7,5 % | 16,7 % | 0,0 % | 0,0 % | 0,0 % | 9,6 % | 0,18 | 0,18 | 0,049 % | 54,9 % | 144,7 % | 234 (11) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | — | — | — | — | — | coupé | — |
| Renflouement d’entreprise | 384 · 12,25 | 473 · 15,43 | 548 · 17,96 | 552 · 18,50 | 593 · 19,46 | 16,72 ❌ | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 1 · 0,00 | 0 · 0,00 | 229 · 1,86 | 81 · 0,04 | 0 · 0,00 | 0,38 ✅ | parc plein (93 %) ; prix trop élevé (7 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

Renflouements en régime, par type d’entreprise (toutes graines) : Ferme 358, Fonderie 299, Garage 283, Tourisme 276, Bijouterie 236, Pêcherie 192, Machinerie 178, Hôtel 87.

Santé moyenne de la population : g1 0,88, g2 0,88, g3 0,19, g4 0,88, g5 0,81.

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 99,2 % | 100,0 % | 100,0 % | non (> 470) | non | Surstock ×1, Rupture de stock prolongée ×32, Sans-abri nombreux ×2, Pénurie de main-d’œuvre ×1, Entreprise sans employé ×59, Entreprise sans client ×64, Embauches bloquées faute de moyens ×1, Prix aberrant ×3, Inflation quotidienne ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1, Attente trop longue (service public) ×1, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Faim répandue ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 97,5 % | 100,0 % | 100,0 % | 81 | non | Rupture de stock prolongée ×43, Surstock ×1, Entreprise sans employé ×67, Entreprise sans client ×71, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×4, Prix aberrant ×2, Attente trop longue (service public) ×2, Sans-abri nombreux ×2, Faim répandue ×2, Pénurie de main-d’œuvre ×2, Productivité du travail effondrée ×1, Santé de la population effondrée ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 55,8 % | 98,3 % | 71,3 % | non (> 470) | non | Rupture de stock prolongée ×50, Sans-abri nombreux ×4, Surstock ×5, Entreprise sans employé ×59, Entreprise sans client ×60, Embauches bloquées faute de moyens ×1, Attente trop longue (service public) ×1, Inflation quotidienne ×1, Prix aberrant ×3, Prestations réduites faute de trésor ×4, Inflation sur 100 jours ×1, Pénurie de main-d’œuvre ×1, Faim répandue ×4, Chômage très élevé ×3, Inégalités hors bornes ×1 |
| +25 immigrants | 1 | non | 41,9 % | 0,0 % | 17,0 % | non (> 470) | non | Surstock ×12, Rupture de stock prolongée ×64, Sans-abri nombreux ×8, Entreprise sans employé ×65, Entreprise sans client ×75, Embauches bloquées faute de moyens ×1, Prix aberrant ×3, Inflation quotidienne ×5, Prestations réduites faute de trésor ×7, Attente trop longue (service public) ×2, Productivité du travail effondrée ×1, Santé de la population effondrée ×1, Inégalités hors bornes ×1 |
| +25 immigrants | 2 | non | 35,8 % | 92,1 % | 27,2 % | non (> 470) | non | Rupture de stock prolongée ×61, Surstock ×26, Entreprise sans employé ×66, Entreprise sans client ×77, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×3, Prix aberrant ×9, Attente trop longue (service public) ×3, Productivité du travail effondrée ×1, Santé de la population effondrée ×1, Prestations réduites faute de trésor ×2, Faim répandue ×2, Sans-abri nombreux ×2, Inégalités hors bornes ×2 |
| +25 immigrants | 3 | non | 29,8 % | 95,1 % | 38,5 % | non (> 470) | non | Rupture de stock prolongée ×73, Sans-abri nombreux ×8, Surstock ×17, Entreprise sans employé ×71, Entreprise sans client ×84, Embauches bloquées faute de moyens ×4, Inflation quotidienne ×5, Prix aberrant ×10, Inflation sur 100 jours ×3, Faim répandue ×2, Inégalités hors bornes ×2, Richesse médiane hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | non | 35,8 % | 95,4 % | 25,8 % | non (> 470) | 5 | Surstock ×5, Rupture de stock prolongée ×35, Sans-abri nombreux ×8, Entreprise sans employé ×26, Entreprise sans client ×35, Embauches bloquées faute de moyens ×1, Prix aberrant ×5, Inflation quotidienne ×5, Productivité du travail effondrée ×1, Santé de la population effondrée ×1, Faim répandue ×3, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 2 | non | 27,5 % | 0,0 % | 1,7 % | non (> 470) | non | Rupture de stock prolongée ×9, Surstock ×9, Entreprise sans employé ×13, Entreprise sans client ×22, Inflation quotidienne ×5, Prix aberrant ×2, Attente trop longue (service public) ×1, Santé de la population effondrée ×1, Productivité du travail effondrée ×1 |
| Salaire minimum 220 $/j | 3 | non | 25,8 % | 95,4 % | 34,6 % | non (> 470) | non | Rupture de stock prolongée ×40, Sans-abri nombreux ×9, Surstock ×6, Entreprise sans employé ×30, Entreprise sans client ×37, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×2, Prix aberrant ×4, Inflation sur 100 jours ×1, Faim répandue ×3, Inégalités hors bornes ×2 |
| Fermeture de la ferme | 1 | non | 97,9 % | 100,0 % | 100,0 % | non (> 470) | non | Surstock ×2, Rupture de stock prolongée ×62, Sans-abri nombreux ×1, Entreprise sans employé ×79, Entreprise sans client ×88, Embauches bloquées faute de moyens ×1, Prix aberrant ×5, Inflation quotidienne ×3, Prestations réduites faute de trésor ×1, Chômage très élevé ×1, Attente trop longue (service public) ×1, Faim répandue ×1, Productivité du travail effondrée ×1, Santé de la population effondrée ×1 |
| Fermeture de la ferme | 2 | non | 31,7 % | 94,2 % | 17,5 % | 149 | non | Rupture de stock prolongée ×38, Surstock ×4, Entreprise sans employé ×25, Entreprise sans client ×28, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×6, Prix aberrant ×8, Attente trop longue (service public) ×1, Faim répandue ×1, Productivité du travail effondrée ×2, Santé de la population effondrée ×1, Sans-abri nombreux ×8 |
| Fermeture de la ferme | 3 | non | 98,3 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×55, Sans-abri nombreux ×2, Surstock ×2, Entreprise sans employé ×78, Entreprise sans client ×88, Embauches bloquées faute de moyens ×1, Attente trop longue (service public) ×1, Inflation quotidienne ×3, Prix aberrant ×7, Prestations réduites faute de trésor ×1, Inflation sur 100 jours ×1, Faim répandue ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé | 1 | non | 36,7 % | 93,8 % | 23,3 % | non (> 470) | non | Surstock ×3, Rupture de stock prolongée ×46, Sans-abri nombreux ×1, Entreprise sans employé ×38, Entreprise sans client ×47, Embauches bloquées faute de moyens ×1, Prix aberrant ×7, Inflation quotidienne ×5, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Faim répandue ×1, Inégalités hors bornes ×1 |
| Faillite d’une firme clé | 2 | non | 16,7 % | 86,7 % | 50,0 % | 160 | 20 | Rupture de stock prolongée ×38, Surstock ×6, Entreprise sans employé ×33, Entreprise sans client ×44, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×4, Prix aberrant ×4, Attente trop longue (service public) ×1, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Faim répandue ×4, Sans-abri nombreux ×4, Pénurie de main-d’œuvre ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 20,4 % | 95,0 % | 32,5 % | non (> 470) | non | Rupture de stock prolongée ×48, Sans-abri nombreux ×2, Surstock ×7, Entreprise sans employé ×35, Entreprise sans client ×39, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×1, Prix aberrant ×5, Faim répandue ×2, Inégalités hors bornes ×1 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 19,6 % | 89,2 % | 70,4 % | 91 | non | Surstock ×16, Rupture de stock prolongée ×50, Sans-abri nombreux ×5, Pénurie de main-d’œuvre ×2, Entreprise sans employé ×28, Entreprise sans client ×45, Inflation quotidienne ×4, Prix aberrant ×5, Faim répandue ×1, Embauches bloquées faute de moyens ×1, Attente trop longue (service public) ×1, Santé de la population effondrée ×1, Productivité du travail effondrée ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 15,4 % | 92,5 % | 62,5 % | 134 | non | Rupture de stock prolongée ×23, Surstock ×7, Entreprise sans employé ×15, Entreprise sans client ×15, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×11, Prix aberrant ×5, Sans-abri nombreux ×2, Faim répandue ×2, Pénurie de main-d’œuvre ×1, Attente trop longue (service public) ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 24,2 % | 73,8 % | 51,7 % | non (> 470) | non | Rupture de stock prolongée ×23, Sans-abri nombreux ×3, Surstock ×5, Faim répandue ×1, Embauches bloquées faute de moyens ×3, Entreprise sans employé ×20, Entreprise sans client ×21, Inflation quotidienne ×4, Prix aberrant ×7, Pénurie de main-d’œuvre ×2, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Inégalités hors bornes ×1 |
| +25 immigrants | 1 | non | 21,1 % | 0,0 % | 6,4 % | non (> 470) | non | Surstock ×3, Rupture de stock prolongée ×8, Entreprise sans employé ×3, Entreprise sans client ×7, Inflation quotidienne ×2, Prix aberrant ×2, Attente trop longue (service public) ×1 |
| +25 immigrants | 2 | non | 28,3 % | 0,0 % | 7,2 % | non (> 470) | non | Rupture de stock prolongée ×12, Surstock ×17, Entreprise sans employé ×20, Entreprise sans client ×25, Embauches bloquées faute de moyens ×2, Prix aberrant ×6, Sans-abri nombreux ×1, Prestations réduites faute de trésor ×2, Attente trop longue (service public) ×3, Productivité du travail effondrée ×2, Santé de la population effondrée ×2 |
| +25 immigrants | 3 | non | 44,9 % | 0,0 % | 9,1 % | non (> 470) | non | Rupture de stock prolongée ×14, Surstock ×17, Embauches bloquées faute de moyens ×1, Entreprise sans employé ×19, Entreprise sans client ×24, Inflation quotidienne ×2, Prix aberrant ×9, Prestations réduites faute de trésor ×1, Attente trop longue (service public) ×1, Productivité du travail effondrée ×1, Santé de la population effondrée ×1, Chômage très élevé ×1 |
| Salaire minimum 220 $/j | 1 | non | 23,3 % | 27,1 % | 0,0 % | non (> 470) | non | Surstock ×16, Rupture de stock prolongée ×8, Entreprise sans employé ×10, Entreprise sans client ×19, Inflation quotidienne ×5, Prix aberrant ×2, Faim répandue ×1, Embauches bloquées faute de moyens ×2 |
| Salaire minimum 220 $/j | 2 | non | 31,3 % | 76,3 % | 8,8 % | non (> 470) | non | Rupture de stock prolongée ×12, Surstock ×12, Entreprise sans employé ×8, Entreprise sans client ×15, Embauches bloquées faute de moyens ×4, Inflation quotidienne ×2, Prix aberrant ×9, Attente trop longue (service public) ×2, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Faim répandue ×1 |
| Salaire minimum 220 $/j | 3 | non | 29,2 % | 71,7 % | 16,3 % | non (> 470) | 1 | Rupture de stock prolongée ×17, Surstock ×10, Faim répandue ×1, Embauches bloquées faute de moyens ×1, Entreprise sans employé ×10, Entreprise sans client ×14, Inflation quotidienne ×1, Prix aberrant ×9, Santé de la population effondrée ×1, Productivité du travail effondrée ×1 |
| Fermeture de la ferme | 1 | non | 16,3 % | 40,0 % | 0,0 % | 213 ❌ | 58 | Surstock ×10, Rupture de stock prolongée ×13, Entreprise sans employé ×9, Entreprise sans client ×13, Inflation quotidienne ×2, Prix aberrant ×2, Faim répandue ×1 |
| Fermeture de la ferme | 2 | non | 15,4 % | 0,0 % | 0,0 % | 287 ❌ | 92 | Rupture de stock prolongée ×6, Surstock ×11, Entreprise sans employé ×6, Entreprise sans client ×8, Prix aberrant ×7 |
| Fermeture de la ferme | 3 | non | 64,6 % | 94,2 % | 27,5 % | non (> 470) | 447 | Rupture de stock prolongée ×34, Sans-abri nombreux ×5, Surstock ×16, Faim répandue ×2, Embauches bloquées faute de moyens ×1, Entreprise sans employé ×26, Entreprise sans client ×32, Inflation quotidienne ×4, Prix aberrant ×17, Prestations réduites faute de trésor ×4, Attente trop longue (service public) ×2, Productivité du travail effondrée ×1, Chômage très élevé ×2, Santé de la population effondrée ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 13,3 % | 0,0 % | 0,0 % | 9 | non | Surstock ×3, Rupture de stock prolongée ×4, Entreprise sans employé ×2, Entreprise sans client ×3, Inflation quotidienne ×1, Prix aberrant ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 16,3 % | 26,3 % | 1,3 % | 436 ❌ | 1 | Rupture de stock prolongée ×11, Surstock ×3, Entreprise sans employé ×4, Entreprise sans client ×5, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×1, Prix aberrant ×6, Faim répandue ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 24,6 % | 0,0 % | 2,1 % | non (> 470) | 1 | Rupture de stock prolongée ×14, Surstock ×9, Entreprise sans employé ×10, Entreprise sans client ×15, Inflation quotidienne ×2, Prix aberrant ×6, Santé de la population effondrée ×1, Productivité du travail effondrée ×1 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 129 ouverture(s) critique(s) |
| Chômage moyen ≤ 10 % | ❌ | g1 11,0 %, g4 75,8 % |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4 |
| Gini 0,2–0,45 | ✅ | toutes les graines |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Anti-famine 6,04/50 j, Renflouement d’entreprise 16,80/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 12/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 12/15 échecs |

### Critère de l’institution (étape 2 bis)

| Critère | Résultat | Détail |
|---|---|---|
| Sans « Anti-famine » : chômage moyen ≤ 10 % | ✅ | toutes les graines |
| Sans « Anti-famine » : faim et sans-abri < 2 % | ✅ | toutes les graines |
| Sans « Anti-famine » : aucune alerte critique | ❌ | 51 ouverture(s) critique(s) |

