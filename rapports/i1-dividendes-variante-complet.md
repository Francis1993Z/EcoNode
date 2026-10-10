# Protocole de stabilité ÉcoNodes

- Date : 2026-10-10 13:29
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : aucun
- Paramètres changés : dividendFromRetained = 1

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 7,5 % | 28,3 % | 7,7 % | 96,7 % | 3,2 % | 40,8 % | 0,41 | 0,74 | 0,082 % | 17,3 % | 127,5 % | 477 (37) | 0.0e+0 |
| 2 | 6,4 % | 25,0 % | 6,1 % | 95,4 % | 1,6 % | 41,3 % | 0,33 | 0,50 | 0,065 % | 41,7 % | 152,6 % | 409 (24) | 0.0e+0 |
| 3 | 8,7 % | 30,8 % | 7,8 % | 95,4 % | 3,7 % | 69,6 % | 0,42 | 0,12 | 0,077 % | 46,2 % | 109,6 % | 506 (33) | 0.0e+0 |
| 4 | 15,5 % | 35,0 % | 4,6 % | 89,2 % | 1,6 % | 79,6 % | 0,39 | 0,67 | 0,003 % | 15,1 % | 135,9 % | 769 (33) | 0.0e+0 |
| 5 | 6,5 % | 21,3 % | 6,3 % | 96,3 % | 3,0 % | 44,2 % | 0,42 | 0,81 | 0,054 % | 11,7 % | 149,1 % | 317 (29) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Faim répandue | critique | 7 · 162 j | 4 · 125 j | 8 · 157 j | 5 · 98 j | 4 · 128 j |
| Sans-abri nombreux | critique | 17 · 188 j | 7 · 97 j | 20 · 276 j | 15 · 130 j | 15 · 159 j |
| Inégalités hors bornes | attention | 5 · 294 j | 3 · 166 j | 5 · 357 j | 4 · 240 j | 4 · 243 j |
| Richesse médiane hors bornes | attention | 2 · 4 j | 1 · 7 j | 3 · 13 j | 6 · 36 j | 4 · 12 j |
| Inflation quotidienne | critique | 8 · 8 j | 9 · 9 j | 3 · 3 j | 10 · 11 j | 3 · 3 j |
| Inflation sur 100 jours | critique | 4 · 78 j | 3 · 85 j | 1 · 13 j | 2 · 53 j | 6 · 61 j |
| Rupture de stock prolongée | attention | 106 · 4331 j | 86 · 3382 j | 105 · 4101 j | 189 · 6749 j | 70 · 2691 j |
| Surstock | attention | 29 · 915 j | 41 · 1744 j | 38 · 840 j | 69 · 2433 j | 17 · 582 j |
| Entreprise sans employé | attention | 129 · 1778 j | 102 · 1402 j | 139 · 1890 j | 202 · 2763 j | 84 · 1169 j |
| Entreprise sans client | attention | 139 · 4204 j | 132 · 3791 j | 154 · 4550 j | 227 · 6738 j | 87 · 2775 j |
| Caisse insolvable | attention | · | 1 · 191 j | 1 · 1264 j | 1 · 1357 j | · |
| Santé de la population effondrée | critique | 1 · 1288 j | 1 · 1350 j | 1 · 1268 j | 1 · 1223 j | 1 · 1336 j |
| Productivité du travail effondrée | attention | 1 · 1289 j | 1 · 1350 j | 1 · 1270 j | 1 · 1223 j | 1 · 1334 j |
| Pénurie de main-d’œuvre | attention | 1 · 6 j | · | 1 · 15 j | 1 · 7 j | · |
| Embauches bloquées faute de moyens | attention | 10 · 297 j | 5 · 164 j | 9 · 372 j | 13 · 588 j | 6 · 191 j |
| Prix aberrant | attention | 18 · 1895 j | 13 · 3230 j | 17 · 1827 j | 23 · 4907 j | 15 · 1387 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 2,8 % | 32,4 % | 64,8 % | 1 | 0 $ | 195 811 $ | 20 974 $ |
| 2 | 5,3 % | 32,6 % | 62,1 % | 1 | 9 887 $ | 168 132 $ | 29 469 $ |
| 3 | 3,6 % | 18,0 % | 78,4 % | 4 | 5 755 $ | 158 680 $ | 26 322 $ |
| 4 | 2,6 % | 34,2 % | 63,2 % | 9 | 0 $ | 148 305 $ | 48 720 $ |
| 5 | 8,5 % | 24,7 % | 66,8 % | 3 | 16 635 $ | 216 018 $ | 13 685 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 3,5 % | 17,5 % | 0,4 % | 51,2 % | 0,0 % | 5,0 % | 0,13 | 0,12 | 0,098 % | 52,4 % | 215,3 % | 159 (4) | 0.0e+0 |
| 2 | 4,3 % | 13,3 % | 0,0 % | 0,0 % | 0,0 % | 8,3 % | 0,13 | 0,25 | 0,049 % | 52,0 % | 119,2 % | 143 (9) | 0.0e+0 |
| 3 | 7,9 % | 28,7 % | 0,5 % | 83,3 % | 0,0 % | 56,7 % | 0,16 | 0,26 | 0,030 % | 57,3 % | 116,8 % | 180 (8) | 0.0e+0 |
| 4 | 6,9 % | 16,3 % | 0,0 % | 0,0 % | 0,0 % | 33,3 % | 0,17 | 0,15 | -0,002 % | 53,0 % | 138,3 % | 146 (9) | 0.0e+0 |
| 5 | 8,3 % | 24,6 % | 0,0 % | 25,0 % | 1,1 % | 35,8 % | 0,22 | 0,16 | 0,087 % | 73,4 % | 125,1 % | 239 (19) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 158 · 5,64 | 0 · 0,00 | 340 · 11,93 | 0 · 0,00 | 3 · 0,11 | 3,54 ❌ | pas de producteur (100 %) |
| Renflouement d’entreprise | 1040 · 35,21 | 1245 · 42,71 | 886 · 29,96 | 1049 · 35,21 | 830 · 28,04 | 34,23 ❌ | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0 · 0,00 | 0 · 0,00 | 427 · 0,00 | 96 · 0,00 | 1465 · 50,46 | 10,09 ❌ | prix trop élevé (71 %) ; parc plein (29 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## 2 bis. Avec filets, sauf : Renflouement d’entreprise

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,3 % | 30,0 % | 4,1 % | 94,6 % | 0,7 % | 26,7 % | 0,32 | 0,19 | 0,076 % | 16,0 % | 127,5 % | 531 (26) | 0.0e+0 |
| 2 | 12,4 % | 32,5 % | 3,7 % | 94,6 % | 0,4 % | 35,0 % | 0,34 | 0,21 | 0,068 % | 19,1 % | 147,9 % | 728 (18) | 0.0e+0 |
| 3 | 7,0 % | 22,9 % | 2,6 % | 93,3 % | 0,4 % | 56,7 % | 0,30 | 0,49 | 0,046 % | 8,2 % | 111,9 % | 552 (13) | 0.0e+0 |
| 4 | 6,9 % | 23,3 % | 6,4 % | 95,4 % | 1,1 % | 60,0 % | 0,45 | 0,59 | 0,079 % | 56,1 % | 139,9 % | 553 (26) | 0.0e+0 |
| 5 | 6,2 % | 23,3 % | 4,1 % | 94,6 % | 1,2 % | 33,3 % | 0,42 | 0,23 | 0,056 % | 11,7 % | 149,1 % | 307 (18) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 3417 · 122,04 | 3370 · 120,36 | 2374 · 84,79 | 6418 · 229,21 | 3686 · 131,64 | 137,61 ❌ | pas de producteur (100 %) |
| Renflouement d’entreprise | — | — | — | — | — | coupé | — |
| Plancher de logement | 161 · 5,75 | 130 · 2,89 | 889 · 1,14 | 869 · 17,71 | 455 · 16,25 | 8,75 ❌ | parc plein (53 %) ; prix trop élevé (47 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 103 · 3,68 | 0 · 0,00 | 199 · 7,11 | 0 · 0,00 | 2,16 ❌ | fonds propres de la Caisse insuffisants (100 %) |

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 24,6 % | 94,2 % | 50,8 % | non (> 470) | 126 | Rupture de stock prolongée ×40, Entreprise sans employé ×48, Entreprise sans client ×52, Embauches bloquées faute de moyens ×6, Inflation quotidienne ×2, Prix aberrant ×8, Sans-abri nombreux ×6, Faim répandue ×3, Inégalités hors bornes ×2 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 19,6 % | 95,8 % | 53,3 % | non (> 470) | non | Rupture de stock prolongée ×43, Entreprise sans employé ×46, Entreprise sans client ×46, Embauches bloquées faute de moyens ×3, Sans-abri nombreux ×4, Inflation quotidienne ×1, Prix aberrant ×7, Faim répandue ×3, Inégalités hors bornes ×2 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 89,2 % | 100,0 % | 80,0 % | non (> 470) | non | Rupture de stock prolongée ×38, Entreprise sans client ×63, Surstock ×1, Sans-abri nombreux ×3, Entreprise sans employé ×58, Embauches bloquées faute de moyens ×7, Prix aberrant ×7, Inflation quotidienne ×2, Faim répandue ×4, Inflation sur 100 jours ×2, Chômage très élevé ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| +25 immigrants | 1 | non | 39,6 % | 94,0 % | 34,3 % | non (> 470) | 54 | Rupture de stock prolongée ×72, Surstock ×16, Entreprise sans employé ×63, Entreprise sans client ×79, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×5, Prix aberrant ×9, Sans-abri nombreux ×5, Faim répandue ×2, Inégalités hors bornes ×2, Richesse médiane hors bornes ×2 |
| +25 immigrants | 2 | non | 43,8 % | 82,6 % | 35,1 % | non (> 470) | non | Rupture de stock prolongée ×74, Surstock ×20, Entreprise sans employé ×63, Entreprise sans client ×80, Embauches bloquées faute de moyens ×4, Sans-abri nombreux ×12, Inflation quotidienne ×1, Prix aberrant ×10, Faim répandue ×2, Inégalités hors bornes ×2, Richesse médiane hors bornes ×1 |
| +25 immigrants | 3 | non | 34,3 % | 92,8 % | 36,6 % | non (> 470) | non | Rupture de stock prolongée ×62, Entreprise sans client ×77, Surstock ×19, Sans-abri nombreux ×4, Entreprise sans employé ×62, Embauches bloquées faute de moyens ×3, Prix aberrant ×9, Inflation quotidienne ×3, Inflation sur 100 jours ×2, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | non | 22,5 % | 93,8 % | 38,3 % | non (> 470) | 8 | Rupture de stock prolongée ×40, Surstock ×2, Entreprise sans employé ×39, Entreprise sans client ×42, Embauches bloquées faute de moyens ×4, Inflation quotidienne ×3, Prix aberrant ×2, Sans-abri nombreux ×6, Faim répandue ×3, Inégalités hors bornes ×2 |
| Salaire minimum 220 $/j | 2 | non | 28,3 % | 90,4 % | 28,7 % | non (> 470) | 1 | Rupture de stock prolongée ×30, Surstock ×8, Entreprise sans employé ×23, Entreprise sans client ×34, Embauches bloquées faute de moyens ×2, Sans-abri nombreux ×4, Inflation quotidienne ×3, Prix aberrant ×3, Faim répandue ×1, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 3 | non | 27,5 % | 93,3 % | 40,4 % | non (> 470) | 198 | Rupture de stock prolongée ×33, Entreprise sans client ×36, Surstock ×11, Sans-abri nombreux ×3, Entreprise sans employé ×28, Embauches bloquées faute de moyens ×2, Prix aberrant ×2, Inflation quotidienne ×7, Inflation sur 100 jours ×2, Faim répandue ×2 |
| Fermeture de la ferme | 1 | non | 95,4 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×72, Surstock ×1, Entreprise sans employé ×109, Entreprise sans client ×120, Embauches bloquées faute de moyens ×5, Inflation quotidienne ×3, Prix aberrant ×2, Sans-abri nombreux ×1, Faim répandue ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 2 | non | 97,9 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×45, Surstock ×4, Entreprise sans employé ×79, Entreprise sans client ×83, Embauches bloquées faute de moyens ×6, Sans-abri nombreux ×1, Prix aberrant ×2, Faim répandue ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 3 | non | 98,8 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×51, Entreprise sans client ×89, Surstock ×1, Sans-abri nombreux ×1, Entreprise sans employé ×82, Embauches bloquées faute de moyens ×7, Prix aberrant ×2, Inflation quotidienne ×2, Faim répandue ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé | 1 | non | 25,8 % | 96,7 % | 40,8 % | non (> 470) | 9 | Rupture de stock prolongée ×31, Surstock ×2, Entreprise sans employé ×27, Entreprise sans client ×28, Embauches bloquées faute de moyens ×4, Inflation quotidienne ×2, Prix aberrant ×4, Sans-abri nombreux ×4, Faim répandue ×3, Inégalités hors bornes ×1 |
| Faillite d’une firme clé | 2 | non | 12,5 % | 0,0 % | 2,5 % | non (> 470) | 1 | Rupture de stock prolongée ×15, Surstock ×9, Entreprise sans employé ×13, Entreprise sans client ×24, Inflation quotidienne ×3, Prix aberrant ×1 |
| Faillite d’une firme clé | 3 | non | 21,7 % | 95,0 % | 37,9 % | non (> 470) | 399 | Rupture de stock prolongée ×22, Entreprise sans client ×23, Surstock ×2, Sans-abri nombreux ×7, Entreprise sans employé ×23, Embauches bloquées faute de moyens ×3, Prix aberrant ×2, Inflation quotidienne ×1, Inflation sur 100 jours ×1, Faim répandue ×2, Inégalités hors bornes ×2 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 9,2 % | 73,8 % | 61,3 % | 67 | 227 | Rupture de stock prolongée ×28, Surstock ×8, Entreprise sans client ×18, Embauches bloquées faute de moyens ×3, Entreprise sans employé ×22, Prix aberrant ×8, Inflation quotidienne ×2, Sans-abri nombreux ×2, Faim répandue ×3, Pénurie de main-d’œuvre ×1, Santé de la population effondrée ×1, Productivité du travail effondrée ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 20,0 % | 62,5 % | 60,0 % | 81 | non | Rupture de stock prolongée ×21, Surstock ×8, Entreprise sans client ×22, Sans-abri nombreux ×8, Entreprise sans employé ×16, Inflation quotidienne ×2, Prix aberrant ×6, Pénurie de main-d’œuvre ×1, Faim répandue ×1, Santé de la population effondrée ×1, Productivité du travail effondrée ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | oui | 17,5 % | 76,7 % | 66,7 % | non (> 470) | non | Rupture de stock prolongée ×32, Sans-abri nombreux ×6, Entreprise sans client ×26, Surstock ×7, Faim répandue ×3, Pénurie de main-d’œuvre ×1, Entreprise sans employé ×22, Embauches bloquées faute de moyens ×1, Prix aberrant ×10, Productivité du travail effondrée ×1, Santé de la population effondrée ×1, Inflation quotidienne ×3, Inflation sur 100 jours ×2 |
| +25 immigrants | 1 | non | 19,6 % | 0,0 % | 8,3 % | non (> 470) | non | Rupture de stock prolongée ×7, Surstock ×6, Entreprise sans client ×11, Entreprise sans employé ×7, Prix aberrant ×5, Inflation quotidienne ×2 |
| +25 immigrants | 2 | non | 14,7 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×9, Surstock ×4, Entreprise sans client ×6, Entreprise sans employé ×5, Prix aberrant ×9 |
| +25 immigrants | 3 | oui | 19,2 % | 0,0 % | 6,4 % | non (> 470) | non | Rupture de stock prolongée ×7, Entreprise sans client ×3, Entreprise sans employé ×3, Prix aberrant ×8 |
| Salaire minimum 220 $/j | 1 | non | 9,2 % | 24,6 % | 5,0 % | 1 | 1 | Rupture de stock prolongée ×10, Surstock ×8, Entreprise sans client ×13, Embauches bloquées faute de moyens ×1, Entreprise sans employé ×9, Prix aberrant ×5, Inflation quotidienne ×2, Faim répandue ×1 |
| Salaire minimum 220 $/j | 2 | non | 12,9 % | 0,0 % | 0,0 % | 1 | 341 | Rupture de stock prolongée ×9, Surstock ×8, Entreprise sans client ×14, Entreprise sans employé ×7, Inflation sur 100 jours ×1, Inflation quotidienne ×4, Prix aberrant ×8 |
| Salaire minimum 220 $/j | 3 | oui | 17,1 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×5, Entreprise sans client ×10, Surstock ×10, Entreprise sans employé ×6, Prix aberrant ×12, Inflation quotidienne ×2 |
| Fermeture de la ferme | 1 | non | 8,8 % | 0,0 % | 0,0 % | 23 | 41 | Rupture de stock prolongée ×7, Surstock ×8, Entreprise sans client ×11, Embauches bloquées faute de moyens ×1, Entreprise sans employé ×9, Prix aberrant ×5, Inflation quotidienne ×3 |
| Fermeture de la ferme | 2 | non | 12,5 % | 29,2 % | 0,0 % | 22 | 85 | Rupture de stock prolongée ×12, Surstock ×12, Entreprise sans client ×16, Entreprise sans employé ×11, Inflation quotidienne ×1, Prix aberrant ×11, Faim répandue ×1, Embauches bloquées faute de moyens ×1 |
| Fermeture de la ferme | 3 | oui | 11,3 % | 0,0 % | 0,0 % | 1 | 86 | Rupture de stock prolongée ×16, Entreprise sans client ×14, Surstock ×6, Entreprise sans employé ×9, Prix aberrant ×9, Inflation quotidienne ×2 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 8,8 % | 37,5 % | 2,5 % | 1 | 50 | Rupture de stock prolongée ×13, Surstock ×12, Entreprise sans client ×16, Embauches bloquées faute de moyens ×1, Entreprise sans employé ×11, Prix aberrant ×6, Inflation quotidienne ×2, Faim répandue ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 10,0 % | 0,0 % | 0,0 % | 1 | 21 | Rupture de stock prolongée ×8, Surstock ×9, Entreprise sans client ×13, Entreprise sans employé ×8, Inflation sur 100 jours ×1, Inflation quotidienne ×2, Prix aberrant ×10, Embauches bloquées faute de moyens ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | oui | 11,3 % | 0,0 % | 0,0 % | 1 | 1 | Rupture de stock prolongée ×6, Entreprise sans client ×8, Surstock ×7, Entreprise sans employé ×5, Prix aberrant ×7, Inflation quotidienne ×2, Inflation sur 100 jours ×1 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 156 ouverture(s) critique(s) |
| Chômage moyen ≤ 10 % | ❌ | g4 15,5 % |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ✅ | toutes les graines |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Anti-famine 3,54/50 j, Renflouement d’entreprise 34,23/50 j, Plancher de logement 10,09/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 15/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 5/15 échecs |

### Critère de l’institution (étape 2 bis)

| Critère | Résultat | Détail |
|---|---|---|
| Sans « Renflouement d’entreprise » : chômage moyen ≤ 10 % | ❌ | g2 12,4 % |
| Sans « Renflouement d’entreprise » : faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Sans « Renflouement d’entreprise » : aucune alerte critique | ❌ | 101 ouverture(s) critique(s) |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 9,2 % | 8,9 % |
| Faim moyenne | 5,7 % | 6,5 % |
| Sans-abri moyen | 2,9 % | 2,6 % |
| Gini moyen | 0,37 | 0,39 |
| Inflation moyenne / jour | 0,048 % | 0,056 % |
| Alertes critiques (total) | 104 | 156 |
| Alertes (total) | 2280 | 2478 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,48 | 3,54 |
| Renflouements / 50 j | 25,69 | 34,23 |
| Plancher de logement / 50 j | 5,56 | 10,09 |
| Plafond de dérive / 50 j | 0,00 | 0,00 |
| Anti-crédit-fou / 50 j | 0,19 | 0,00 |
| Avec filets : chômage moyen | 4,0 % | 6,2 % |
| Avec filets : faim moyenne | 0,1 % | 0,2 % |
| Avec filets : sans-abri moyen | 0,2 % | 0,2 % |
| Avec filets : Gini moyen | 0,19 | 0,16 |
| Filets sauf --sauf : chômage moyen | 7,3 % | 8,2 % |
| Filets sauf --sauf : faim moyenne | 3,4 % | 4,2 % |
| Filets sauf --sauf : sans-abri moyen | 1,1 % | 0,8 % |
| Filets sauf --sauf : Gini moyen | 0,30 | 0,37 |
| Filets sauf --sauf : alertes critiques | 72 | 101 |
| Filets sauf --sauf : anti-famine / 50 j | 100,78 | 137,61 |
| Filets sauf --sauf : plancher de logement / 50 j | 15,70 | 8,75 |
| Filets sauf --sauf : plafond de dérive / 50 j | 0,00 | 0,00 |
| Filets sauf --sauf : anti-crédit-fou / 50 j | 4,79 | 2,16 |
| Chocs revenus à l’équilibre en < 200 j (sans filets) | 0 | 0 |
| Chocs revenus à l’équilibre en < 200 j (avec filets) | 11 | 10 |

