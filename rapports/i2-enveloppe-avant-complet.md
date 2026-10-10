# Protocole de stabilité ÉcoNodes

- Date : 2026-10-10 13:43
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Hôpital et école publics : enveloppe et file d’attente

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 7,3 % | 25,0 % | 1,1 % | 88,8 % | 0,3 % | 25,0 % | 0,23 | 0,18 | 0,046 % | 7,4 % | 78,5 % | 327 (11) | 0.0e+0 |
| 2 | 7,6 % | 24,2 % | 3,9 % | 95,0 % | 1,6 % | 33,8 % | 0,36 | 0,33 | 0,083 % | 22,2 % | 129,7 % | 395 (31) | 0.0e+0 |
| 3 | 9,4 % | 25,4 % | 6,9 % | 94,2 % | 1,3 % | 50,4 % | 0,34 | 0,19 | 0,053 % | 43,2 % | 137,9 % | 625 (19) | 0.0e+0 |
| 4 | 8,6 % | 26,3 % | 8,1 % | 95,0 % | 2,3 % | 50,4 % | 0,36 | 0,23 | 0,037 % | 57,4 % | 156,0 % | 677 (32) | 0.0e+0 |
| 5 | 8,1 % | 26,3 % | 5,3 % | 95,0 % | 1,7 % | 39,2 % | 0,34 | 0,31 | 0,064 % | 66,8 % | 130,3 % | 627 (24) | 0.0e+0 |

Santé moyenne de la population : g1 0,14, g2 0,12, g3 0,15, g4 0,09, g5 0,15.

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Faim répandue | critique | 1 · 23 j | 4 · 90 j | 5 · 135 j | 8 · 163 j | 4 · 112 j |
| Sans-abri nombreux | critique | 5 · 24 j | 10 · 137 j | 7 · 92 j | 12 · 184 j | 10 · 91 j |
| Inégalités hors bornes | attention | · | 4 · 205 j | 4 · 135 j | 5 · 168 j | 4 · 128 j |
| Richesse médiane hors bornes | attention | · | · | · | · | 1 · 1 j |
| Inflation quotidienne | critique | 4 · 5 j | 12 · 12 j | 5 · 5 j | 8 · 8 j | 5 · 5 j |
| Inflation sur 100 jours | critique | · | 4 · 75 j | 1 · 36 j | 3 · 104 j | 4 · 34 j |
| Rupture de stock prolongée | attention | 87 · 2693 j | 83 · 3359 j | 153 · 5675 j | 165 · 6491 j | 159 · 5390 j |
| Surstock | attention | 26 · 832 j | 29 · 1377 j | 36 · 987 j | 45 · 1343 j | 46 · 1485 j |
| Entreprise sans employé | attention | 93 · 1275 j | 107 · 1473 j | 180 · 2488 j | 187 · 2618 j | 177 · 2428 j |
| Entreprise sans client | attention | 94 · 2302 j | 118 · 3613 j | 202 · 5174 j | 214 · 5840 j | 188 · 5040 j |
| Caisse insolvable | attention | · | · | 1 · 1363 j | · | 1 · 1334 j |
| Santé de la population effondrée | critique | 1 · 1236 j | 1 · 1324 j | 1 · 1233 j | 1 · 1353 j | 1 · 1254 j |
| Productivité du travail effondrée | attention | 1 · 1237 j | 1 · 1325 j | 1 · 1234 j | 1 · 1354 j | 1 · 1252 j |
| Embauches bloquées faute de moyens | attention | 4 · 182 j | 9 · 214 j | 11 · 501 j | 12 · 689 j | 7 · 352 j |
| Prix aberrant | attention | 11 · 2349 j | 13 · 1661 j | 18 · 3028 j | 16 · 3422 j | 19 · 2594 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 10,5 % | 20,6 % | 68,9 % | 1 | 15 662 $ | 141 467 $ | 22 917 $ |
| 2 | 9,6 % | 18,9 % | 71,5 % | 2 | 0 $ | 166 093 $ | 25 932 $ |
| 3 | 1,5 % | 19,1 % | 79,4 % | 7 | 0 $ | 147 687 $ | 52 537 $ |
| 4 | 1,8 % | 11,1 % | 87,1 % | 1 | 3 575 $ | 173 753 $ | 22 014 $ |
| 5 | 11,8 % | 19,7 % | 68,5 % | 4 | 3 884 $ | 239 099 $ | 37 864 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 7,6 % | 16,7 % | 0,2 % | 43,8 % | 0,0 % | 5,4 % | 0,16 | 0,15 | 0,034 % | 29,3 % | 138,9 % | 170 (9) | 0.0e+0 |
| 2 | 8,7 % | 27,1 % | 0,0 % | 3,3 % | 0,0 % | 19,6 % | 0,16 | 0,10 | 0,055 % | 17,8 % | 151,4 % | 186 (8) | 0.0e+0 |
| 3 | 7,6 % | 23,3 % | 0,0 % | 0,0 % | 0,0 % | 42,5 % | 0,16 | 0,14 | 0,059 % | 34,1 % | 126,7 % | 177 (13) | 0.0e+0 |
| 4 | 8,1 % | 31,7 % | 0,5 % | 53,8 % | 0,2 % | 62,1 % | 0,23 | 0,13 | 0,045 % | 41,7 % | 135,0 % | 311 (13) | 0.0e+0 |
| 5 | 7,0 % | 26,7 % | 0,0 % | 0,0 % | 0,0 % | 10,4 % | 0,15 | 0,12 | -0,010 % | 56,0 % | 78,7 % | 140 (7) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 50 · 1,79 | 0 · 0,00 | 0 · 0,00 | 155 · 5,54 | 0 · 0,00 | 1,46 ❌ | pas de producteur (100 %) |
| Renflouement d’entreprise | 769 · 25,57 | 869 · 29,21 | 725 · 24,14 | 1022 · 35,14 | 846 · 28,07 | 28,43 ❌ | par le propriétaire (95 %) ; après rachat (5 %) |
| Plancher de logement | 0 · 0,00 | 0 · 0,00 | 153 · 0,00 | 612 · 4,89 | 0 · 0,00 | 0,98 ✅ | parc plein (82 %) ; prix trop élevé (18 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

Renflouements en régime, par type d’entreprise (toutes graines) : Hôpital 1138, Ferme 539, Tourisme 533, École 255, Pêcherie 243, Pétrochimie 162, Machinerie 150, Mine de fer 147.

Santé moyenne de la population : g1 0,88, g2 0,85, g3 0,87, g4 0,19, g5 0,87.

## 2 bis. Avec filets, sauf : Renflouement d’entreprise

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 6,8 % | 22,5 % | 4,1 % | 95,8 % | 0,6 % | 34,2 % | 0,39 | 0,35 | 0,060 % | 68,2 % | 92,1 % | 487 (17) | 0.0e+0 |
| 2 | 8,4 % | 25,8 % | 4,7 % | 94,6 % | 0,7 % | 40,8 % | 0,35 | 0,44 | 0,072 % | 22,5 % | 129,7 % | 597 (27) | 0.0e+0 |
| 3 | 9,9 % | 24,2 % | 6,1 % | 93,8 % | 0,5 % | 60,4 % | 0,36 | 0,37 | 0,034 % | 82,5 % | 112,8 % | 674 (18) | 0.0e+0 |
| 4 | 8,3 % | 24,6 % | 3,6 % | 92,5 % | 0,5 % | 58,3 % | 0,32 | 0,25 | 0,059 % | 29,4 % | 150,2 % | 614 (29) | 0.0e+0 |
| 5 | 9,6 % | 23,8 % | 6,7 % | 95,4 % | 0,6 % | 28,3 % | 0,35 | 0,20 | 0,031 % | 13,6 % | 169,8 % | 689 (19) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 3339 · 119,25 | 3826 · 136,64 | 6124 · 218,46 | 2745 · 98,04 | 6943 · 247,96 | 164,07 ❌ | pas de producteur (100 %) |
| Renflouement d’entreprise | — | — | — | — | — | coupé | — |
| Plancher de logement | 199 · 6,11 | 208 · 7,43 | 416 · 0,32 | 770 · 8,00 | 155 · 5,50 | 5,47 ❌ | parc plein (62 %) ; prix trop élevé (38 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 174 · 6,21 | 112 · 4,00 | 204 · 7,29 | 3,50 ❌ | fonds propres de la Caisse insuffisants (100 %) |

Santé moyenne de la population : g1 0,10, g2 0,09, g3 0,15, g4 0,09, g5 0,15.

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 25,0 % | 57,9 % | 45,0 % | non (> 470) | 270 | Rupture de stock prolongée ×54, Surstock ×3, Entreprise sans employé ×52, Entreprise sans client ×56, Sans-abri nombreux ×5, Embauches bloquées faute de moyens ×6, Faim répandue ×3, Inflation sur 100 jours ×2, Prix aberrant ×9 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 22,1 % | 89,2 % | 23,3 % | non (> 470) | 390 | Rupture de stock prolongée ×47, Entreprise sans employé ×45, Entreprise sans client ×43, Sans-abri nombreux ×4, Embauches bloquées faute de moyens ×4, Inflation quotidienne ×1, Prix aberrant ×4, Faim répandue ×4, Pénurie de main-d’œuvre ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 97,9 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×43, Surstock ×1, Entreprise sans client ×87, Sans-abri nombreux ×1, Entreprise sans employé ×80, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×2, Prix aberrant ×4, Faim répandue ×1, Pénurie de main-d’œuvre ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×4 |
| +25 immigrants | 1 | non | 41,9 % | 62,6 % | 34,3 % | non (> 470) | non | Rupture de stock prolongée ×87, Surstock ×27, Entreprise sans employé ×77, Entreprise sans client ×95, Sans-abri nombreux ×7, Embauches bloquées faute de moyens ×5, Inflation quotidienne ×4, Faim répandue ×2, Prix aberrant ×14, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| +25 immigrants | 2 | non | 38,9 % | 90,6 % | 47,5 % | non (> 470) | non | Rupture de stock prolongée ×73, Surstock ×17, Entreprise sans employé ×74, Entreprise sans client ×85, Sans-abri nombreux ×6, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×4, Prix aberrant ×7, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×2 |
| +25 immigrants | 3 | non | 31,7 % | 92,5 % | 41,5 % | non (> 470) | non | Rupture de stock prolongée ×62, Surstock ×14, Entreprise sans client ×72, Sans-abri nombreux ×5, Entreprise sans employé ×64, Embauches bloquées faute de moyens ×5, Inflation quotidienne ×3, Prix aberrant ×3, Faim répandue ×2, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | non | 35,4 % | 90,0 % | 28,7 % | non (> 470) | 1 | Rupture de stock prolongée ×57, Surstock ×10, Entreprise sans employé ×50, Entreprise sans client ×58, Sans-abri nombreux ×4, Embauches bloquées faute de moyens ×3, Faim répandue ×2, Prix aberrant ×6, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 2 | non | 26,7 % | 0,0 % | 10,4 % | non (> 470) | 165 | Rupture de stock prolongée ×24, Surstock ×3, Entreprise sans employé ×29, Entreprise sans client ×28, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×1, Inflation sur 100 jours ×1, Prix aberrant ×4 |
| Salaire minimum 220 $/j | 3 | non | 29,6 % | 94,6 % | 22,9 % | non (> 470) | 198 | Rupture de stock prolongée ×40, Surstock ×8, Entreprise sans client ×45, Sans-abri nombreux ×11, Entreprise sans employé ×37, Embauches bloquées faute de moyens ×4, Inflation quotidienne ×3, Prix aberrant ×4, Faim répandue ×1 |
| Fermeture de la ferme | 1 | non | 93,3 % | 100,0 % | 87,5 % | non (> 470) | non | Rupture de stock prolongée ×74, Surstock ×4, Entreprise sans employé ×96, Entreprise sans client ×114, Sans-abri nombreux ×2, Embauches bloquées faute de moyens ×6, Inflation quotidienne ×10, Faim répandue ×1, Caisse insolvable ×1, Prix aberrant ×8, Chômage très élevé ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| Fermeture de la ferme | 2 | non | 86,3 % | 99,6 % | 77,5 % | non (> 470) | non | Rupture de stock prolongée ×92, Surstock ×4, Entreprise sans employé ×125, Entreprise sans client ×152, Sans-abri nombreux ×2, Embauches bloquées faute de moyens ×4, Inflation quotidienne ×14, Prix aberrant ×9, Faim répandue ×1, Caisse insolvable ×1, Chômage très élevé ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| Fermeture de la ferme | 3 | non | 95,0 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×53, Surstock ×3, Entreprise sans client ×88, Sans-abri nombreux ×2, Entreprise sans employé ×79, Embauches bloquées faute de moyens ×4, Inflation quotidienne ×1, Prix aberrant ×5, Faim répandue ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé | 1 | non | 17,9 % | 0,0 % | 17,9 % | non (> 470) | 1 | Rupture de stock prolongée ×32, Surstock ×4, Entreprise sans employé ×29, Entreprise sans client ×31, Sans-abri nombreux ×3, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×1, Prix aberrant ×5 |
| Faillite d’une firme clé | 2 | non | 18,3 % | 0,0 % | 14,2 % | non (> 470) | 2 | Rupture de stock prolongée ×29, Surstock ×8, Entreprise sans employé ×31, Entreprise sans client ×37, Sans-abri nombreux ×1, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×3, Prix aberrant ×4 |
| Faillite d’une firme clé | 3 | non | 23,3 % | 93,3 % | 28,7 % | non (> 470) | non | Rupture de stock prolongée ×42, Surstock ×2, Entreprise sans client ×31, Sans-abri nombreux ×2, Entreprise sans employé ×29, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×2, Prix aberrant ×2, Faim répandue ×2, Inégalités hors bornes ×2 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 18,8 % | 76,3 % | 65,4 % | non (> 470) | non | Rupture de stock prolongée ×36, Surstock ×14, Entreprise sans employé ×21, Pénurie de main-d’œuvre ×1, Entreprise sans client ×29, Inflation quotidienne ×1, Prix aberrant ×2, Faim répandue ×1, Sans-abri nombreux ×10, Embauches bloquées faute de moyens ×1, Santé de la population effondrée ×1, Productivité du travail effondrée ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 23,8 % | 70,8 % | 63,3 % | 81 | non | Rupture de stock prolongée ×15, Surstock ×9, Entreprise sans employé ×17, Embauches bloquées faute de moyens ×1, Entreprise sans client ×28, Inflation quotidienne ×5, Prix aberrant ×7, Sans-abri nombreux ×2, Faim répandue ×1, Pénurie de main-d’œuvre ×1, Productivité du travail effondrée ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 20,4 % | 70,4 % | 65,8 % | non (> 470) | non | Rupture de stock prolongée ×26, Surstock ×9, Sans-abri nombreux ×2, Entreprise sans client ×22, Entreprise sans employé ×22, Inflation quotidienne ×4, Prix aberrant ×6, Embauches bloquées faute de moyens ×3, Faim répandue ×1, Pénurie de main-d’œuvre ×1, Chômage nul prolongé ×1, Productivité du travail effondrée ×2, Santé de la population effondrée ×1, Caisse insolvable ×1 |
| +25 immigrants | 1 | non | 23,8 % | 0,0 % | 7,5 % | non (> 470) | non | Rupture de stock prolongée ×13, Surstock ×8, Entreprise sans employé ×11, Entreprise sans client ×17, Inflation quotidienne ×3, Prix aberrant ×11, Sans-abri nombreux ×1, Productivité du travail effondrée ×1, Santé de la population effondrée ×1 |
| +25 immigrants | 2 | non | 34,0 % | 0,0 % | 7,2 % | non (> 470) | non | Rupture de stock prolongée ×12, Surstock ×8, Entreprise sans employé ×10, Entreprise sans client ×19, Inflation quotidienne ×2, Prix aberrant ×11, Chômage très élevé ×2 |
| +25 immigrants | 3 | non | 27,9 % | 0,0 % | 8,3 % | non (> 470) | non | Rupture de stock prolongée ×13, Surstock ×6, Entreprise sans client ×15, Entreprise sans employé ×9, Inflation quotidienne ×3, Prix aberrant ×8, Productivité du travail effondrée ×1, Santé de la population effondrée ×1 |
| Salaire minimum 220 $/j | 1 | non | 21,3 % | 0,0 % | 0,0 % | non (> 470) | 213 | Rupture de stock prolongée ×7, Surstock ×15, Entreprise sans employé ×11, Entreprise sans client ×19, Inflation quotidienne ×3, Prix aberrant ×8, Embauches bloquées faute de moyens ×1 |
| Salaire minimum 220 $/j | 2 | non | 35,4 % | 0,0 % | 0,4 % | non (> 470) | 1 | Rupture de stock prolongée ×8, Surstock ×7, Entreprise sans employé ×7, Embauches bloquées faute de moyens ×2, Entreprise sans client ×13, Inflation quotidienne ×5, Prix aberrant ×5, Chômage très élevé ×3 |
| Salaire minimum 220 $/j | 3 | non | 28,3 % | 0,0 % | 0,0 % | non (> 470) | 1 | Rupture de stock prolongée ×8, Surstock ×14, Entreprise sans client ×14, Entreprise sans employé ×6, Inflation quotidienne ×3, Prix aberrant ×6, Embauches bloquées faute de moyens ×3 |
| Fermeture de la ferme | 1 | non | 19,2 % | 71,7 % | 14,2 % | 140 | 29 | Rupture de stock prolongée ×20, Surstock ×10, Entreprise sans employé ×13, Entreprise sans client ×19, Inflation quotidienne ×1, Prix aberrant ×9, Faim répandue ×1 |
| Fermeture de la ferme | 2 | non | 26,7 % | 0,0 % | 0,0 % | 409 ❌ | 1 | Rupture de stock prolongée ×16, Surstock ×7, Entreprise sans employé ×8, Entreprise sans client ×15, Inflation quotidienne ×3, Prix aberrant ×6 |
| Fermeture de la ferme | 3 | non | 23,3 % | 0,0 % | 0,0 % | 431 ❌ | 1 | Rupture de stock prolongée ×11, Surstock ×9, Entreprise sans client ×12, Entreprise sans employé ×11, Prix aberrant ×9 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 11,3 % | 0,0 % | 3,8 % | 1 | non | Rupture de stock prolongée ×10, Surstock ×12, Entreprise sans employé ×12, Entreprise sans client ×15, Inflation quotidienne ×1, Prix aberrant ×6 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 24,2 % | 0,0 % | 0,0 % | 347 ❌ | 1 | Rupture de stock prolongée ×13, Surstock ×17, Entreprise sans employé ×12, Entreprise sans client ×31, Inflation quotidienne ×4, Prix aberrant ×9 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 21,3 % | 0,0 % | 0,0 % | 377 ❌ | 1 | Rupture de stock prolongée ×16, Surstock ×9, Entreprise sans client ×23, Entreprise sans employé ×12, Inflation quotidienne ×4, Prix aberrant ×10 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 117 ouverture(s) critique(s) |
| Chômage moyen ≤ 10 % | ✅ | toutes les graines |
| Faim et sans-abri < 2 % | ❌ | g2, g3, g4, g5 |
| Gini 0,2–0,45 | ✅ | toutes les graines |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Anti-famine 1,46/50 j, Renflouement d’entreprise 28,43/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 15/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 12/15 échecs |

### Critère de l’institution (étape 2 bis)

| Critère | Résultat | Détail |
|---|---|---|
| Sans « Renflouement d’entreprise » : chômage moyen ≤ 10 % | ✅ | toutes les graines |
| Sans « Renflouement d’entreprise » : faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Sans « Renflouement d’entreprise » : aucune alerte critique | ❌ | 110 ouverture(s) critique(s) |

