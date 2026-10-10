# Protocole de stabilité ÉcoNodes

- Date : 2026-10-10 14:19
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : aucun

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 9,4 % | 18,8 % | 0,4 % | 50,4 % | 0,7 % | 15,0 % | 0,28 | 0,36 | -0,011 % | 49,1 % | 138,6 % | 313 (11) | 0.0e+0 |
| 2 | 9,5 % | 25,8 % | 8,5 % | 96,3 % | 3,7 % | 53,8 % | 0,38 | 0,92 | 0,058 % | 26,9 % | 163,9 % | 586 (33) | 0.0e+0 |
| 3 | 8,3 % | 26,3 % | 8,2 % | 95,0 % | 2,6 % | 55,8 % | 0,34 | 0,27 | 0,077 % | 61,1 % | 136,7 % | 660 (41) | 0.0e+0 |
| 4 | 11,9 % | 40,0 % | 7,5 % | 95,0 % | 4,5 % | 80,0 % | 0,41 | 0,31 | 0,078 % | 44,7 % | 134,6 % | 580 (39) | 0.0e+0 |
| 5 | 6,8 % | 21,7 % | 9,1 % | 95,0 % | 5,1 % | 70,0 % | 0,43 | 0,78 | 0,071 % | 19,7 % | 128,8 % | 457 (30) | 0.0e+0 |

Santé moyenne de la population : g1 0,88, g2 0,18, g3 0,14, g4 0,19, g5 0,24.

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Faim répandue | critique | 3 · 12 j | 9 · 181 j | 5 · 163 j | 7 · 156 j | 9 · 208 j |
| Sans-abri nombreux | critique | 2 · 92 j | 10 · 156 j | 20 · 128 j | 21 · 352 j | 13 · 214 j |
| Inégalités hors bornes | attention | · | 4 · 145 j | 5 · 138 j | 2 · 264 j | 6 · 374 j |
| Richesse médiane hors bornes | attention | · | 1 · 1 j | · | 1 · 30 j | · |
| Inflation quotidienne | critique | 4 · 4 j | 9 · 9 j | 12 · 12 j | 8 · 8 j | 6 · 6 j |
| Inflation sur 100 jours | critique | 2 · 44 j | 4 · 73 j | 3 · 43 j | 2 · 25 j | 1 · 20 j |
| Rupture de stock prolongée | attention | 74 · 1663 j | 145 · 5644 j | 167 · 6303 j | 143 · 5478 j | 113 · 4582 j |
| Surstock | attention | 44 · 2084 j | 42 · 1285 j | 52 · 1312 j | 40 · 975 j | 25 · 770 j |
| Entreprise sans employé | attention | 76 · 1024 j | 153 · 2064 j | 170 · 2326 j | 158 · 2150 j | 122 · 1680 j |
| Entreprise sans client | attention | 88 · 2566 j | 171 · 5030 j | 199 · 6120 j | 173 · 5150 j | 131 · 4524 j |
| Caisse insolvable | attention | · | · | · | · | 1 · 1303 j |
| Santé de la population effondrée | critique | · | 1 · 1221 j | 1 · 1248 j | 1 · 1194 j | 1 · 1107 j |
| Productivité du travail effondrée | attention | · | 1 · 1216 j | 1 · 1246 j | 1 · 1193 j | 1 · 1106 j |
| Pénurie de main-d’œuvre | attention | · | 1 · 15 j | · | · | · |
| Embauches bloquées faute de moyens | attention | 5 · 19 j | 9 · 296 j | 10 · 304 j | 7 · 297 j | 6 · 260 j |
| Prix aberrant | attention | 14 · 5123 j | 25 · 1385 j | 14 · 2399 j | 15 · 1373 j | 21 · 1487 j |
| Attente trop longue (service public) | attention | 1 · 2 j | 1 · 1380 j | 1 · 1380 j | 1 · 1380 j | 1 · 1201 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 2,6 % | 19,7 % | 77,6 % | 0 | 683 $ | 121 511 $ | 12 559 $ |
| 2 | 3,0 % | 35,5 % | 61,6 % | 5 | 14 303 $ | 148 282 $ | 14 485 $ |
| 3 | 11,8 % | 24,0 % | 64,2 % | 5 | 11 879 $ | 123 086 $ | 9 160 $ |
| 4 | 8,6 % | 21,7 % | 69,7 % | 1 | 0 $ | 170 834 $ | 14 942 $ |
| 5 | 8,8 % | 25,4 % | 65,8 % | 2 | 0 $ | 65 867 $ | 29 141 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 10,4 % | 31,7 % | 0,0 % | 0,0 % | 0,7 % | 16,3 % | 0,22 | 0,21 | -0,047 % | 60,2 % | 159,1 % | 235 (13) | 0.0e+0 |
| 2 | 8,5 % | 14,6 % | 0,1 % | 50,0 % | 0,1 % | 2,5 % | 0,27 | 0,46 | -0,043 % | 46,7 % | 109,5 % | 115 (10) | 0.0e+0 |
| 3 | 5,9 % | 19,6 % | 0,0 % | 0,0 % | 0,0 % | 29,6 % | 0,18 | 0,11 | 0,057 % | 17,4 % | 127,7 % | 187 (9) | 0.0e+0 |
| 4 | 10,1 % | 26,7 % | 0,0 % | 0,0 % | 0,3 % | 44,2 % | 0,22 | 0,18 | 0,003 % | 15,8 % | 138,2 % | 143 (11) | 0.0e+0 |
| 5 | 4,9 % | 16,3 % | 0,1 % | 44,2 % | 0,3 % | 4,6 % | 0,19 | 0,14 | 0,015 % | 33,4 % | 126,7 % | 149 (8) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 9 · 0,32 | 0 · 0,00 | 0 · 0,00 | 11 · 0,39 | 0,14 ✅ | pas de producteur (100 %) |
| Renflouement d’entreprise | 342 · 10,68 | 265 · 8,18 | 607 · 20,07 | 470 · 15,39 | 388 · 12,64 | 13,39 ❌ | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 856 · 30,57 | 37 · 1,32 | 20 · 0,00 | 489 · 11,89 | 165 · 5,89 | 9,94 ❌ | prix trop élevé (89 %) ; parc plein (11 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

Renflouements en régime, par type d’entreprise (toutes graines) : Tourisme 406, Ferme 333, Bijouterie 267, Fonderie 141, Garage 127, Pêcherie 114, Mine de fer 111, Puits de pétrole 100.

Santé moyenne de la population : g1 0,83, g2 0,88, g3 0,88, g4 0,88, g5 0,88.

## 2 bis. Avec filets, sauf : Anti-crédit-fou

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 10,4 % | 31,7 % | 0,0 % | 0,0 % | 0,7 % | 16,3 % | 0,22 | 0,21 | -0,047 % | 60,2 % | 159,1 % | 235 (13) | 0.0e+0 |
| 2 | 8,5 % | 14,6 % | 0,1 % | 50,0 % | 0,1 % | 2,5 % | 0,27 | 0,46 | -0,043 % | 46,7 % | 109,5 % | 115 (10) | 0.0e+0 |
| 3 | 5,9 % | 19,6 % | 0,0 % | 0,0 % | 0,0 % | 29,6 % | 0,18 | 0,11 | 0,057 % | 17,4 % | 127,7 % | 187 (9) | 0.0e+0 |
| 4 | 10,1 % | 26,7 % | 0,0 % | 0,0 % | 0,3 % | 44,2 % | 0,22 | 0,18 | 0,003 % | 15,8 % | 138,2 % | 143 (11) | 0.0e+0 |
| 5 | 4,9 % | 16,3 % | 0,1 % | 44,2 % | 0,3 % | 4,6 % | 0,19 | 0,14 | 0,015 % | 33,4 % | 126,7 % | 149 (8) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 9 · 0,32 | 0 · 0,00 | 0 · 0,00 | 11 · 0,39 | 0,14 ✅ | pas de producteur (100 %) |
| Renflouement d’entreprise | 342 · 10,68 | 265 · 8,18 | 607 · 20,07 | 470 · 15,39 | 388 · 12,64 | 13,39 ❌ | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 856 · 30,57 | 37 · 1,32 | 20 · 0,00 | 489 · 11,89 | 165 · 5,89 | 9,94 ❌ | prix trop élevé (89 %) ; parc plein (11 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | — | — | — | — | — | coupé | — |

Renflouements en régime, par type d’entreprise (toutes graines) : Tourisme 406, Ferme 333, Bijouterie 267, Fonderie 141, Garage 127, Pêcherie 114, Mine de fer 111, Puits de pétrole 100.

Santé moyenne de la population : g1 0,83, g2 0,88, g3 0,88, g4 0,88, g5 0,88.

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 96,3 % | 100,0 % | 89,2 % | non (> 470) | non | Rupture de stock prolongée ×44, Surstock ×2, Entreprise sans employé ×66, Entreprise sans client ×69, Attente trop longue (service public) ×2, Prix aberrant ×4, Inflation quotidienne ×5, Sans-abri nombreux ×4, Faim répandue ×2, Pénurie de main-d’œuvre ×1, Embauches bloquées faute de moyens ×1, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 96,7 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×54, Surstock ×5, Entreprise sans employé ×86, Entreprise sans client ×90, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×1, Attente trop longue (service public) ×1, Prix aberrant ×4, Faim répandue ×2, Sans-abri nombreux ×2, Pénurie de main-d’œuvre ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 99,6 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×58, Sans-abri nombreux ×1, Entreprise sans employé ×92, Entreprise sans client ×94, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×3, Attente trop longue (service public) ×1, Prix aberrant ×2, Faim répandue ×1, Pénurie de main-d’œuvre ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×2 |
| +25 immigrants | 1 | non | 30,6 % | 0,0 % | 8,7 % | non (> 470) | non | Rupture de stock prolongée ×15, Surstock ×9, Entreprise sans employé ×14, Entreprise sans client ×20, Prix aberrant ×7, Inflation quotidienne ×4, Sans-abri nombreux ×6, Inégalités hors bornes ×1 |
| +25 immigrants | 2 | non | 48,3 % | 92,5 % | 35,5 % | non (> 470) | non | Rupture de stock prolongée ×66, Surstock ×22, Entreprise sans employé ×68, Entreprise sans client ×75, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×1, Prix aberrant ×4, Faim répandue ×1, Sans-abri nombreux ×3, Chômage très élevé ×1, Inégalités hors bornes ×1, Prestations réduites faute de trésor ×1 |
| +25 immigrants | 3 | non | 27,5 % | 95,1 % | 39,2 % | non (> 470) | 4 | Rupture de stock prolongée ×68, Surstock ×17, Sans-abri nombreux ×7, Entreprise sans employé ×66, Entreprise sans client ×68, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×5, Prix aberrant ×7, Faim répandue ×2, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | non | 34,6 % | 0,0 % | 20,8 % | non (> 470) | non | Rupture de stock prolongée ×7, Surstock ×14, Entreprise sans employé ×14, Entreprise sans client ×19, Prix aberrant ×1, Inflation quotidienne ×3, Sans-abri nombreux ×18 |
| Salaire minimum 220 $/j | 2 | non | 36,3 % | 75,0 % | 20,0 % | non (> 470) | 1 | Rupture de stock prolongée ×53, Surstock ×12, Entreprise sans employé ×33, Entreprise sans client ×44, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×2, Prix aberrant ×3, Faim répandue ×2, Sans-abri nombreux ×8, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 3 | non | 27,5 % | 94,6 % | 35,8 % | non (> 470) | 293 | Rupture de stock prolongée ×54, Surstock ×5, Sans-abri nombreux ×4, Entreprise sans employé ×39, Entreprise sans client ×44, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×2, Inflation sur 100 jours ×2, Prix aberrant ×4, Faim répandue ×2, Inégalités hors bornes ×3 |
| Fermeture de la ferme | 1 | non | 21,3 % | 67,5 % | 20,4 % | 314 ❌ | 169 | Rupture de stock prolongée ×17, Surstock ×12, Entreprise sans employé ×15, Entreprise sans client ×23, Prix aberrant ×6, Inflation quotidienne ×6, Sans-abri nombreux ×2, Faim répandue ×2, Embauches bloquées faute de moyens ×2 |
| Fermeture de la ferme | 2 | non | 82,5 % | 99,6 % | 70,8 % | non (> 470) | non | Rupture de stock prolongée ×103, Surstock ×7, Entreprise sans employé ×118, Entreprise sans client ×149, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×15, Attente trop longue (service public) ×1, Prix aberrant ×11, Faim répandue ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1, Sans-abri nombreux ×2, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| Fermeture de la ferme | 3 | non | 98,8 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×64, Surstock ×6, Sans-abri nombreux ×1, Entreprise sans employé ×95, Entreprise sans client ×96, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×1, Attente trop longue (service public) ×1, Prix aberrant ×3, Faim répandue ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé (Raffinerie Caron) | 1 | non | 19,2 % | 0,0 % | 7,9 % | 271 ❌ | 157 | Rupture de stock prolongée ×11, Surstock ×6, Entreprise sans employé ×9, Entreprise sans client ×17, Prix aberrant ×4, Inflation quotidienne ×5, Sans-abri nombreux ×1 |
| Faillite d’une firme clé | 2 | non | 25,0 % | 93,3 % | 25,4 % | non (> 470) | 1 | Rupture de stock prolongée ×66, Surstock ×9, Entreprise sans employé ×52, Entreprise sans client ×64, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×2, Prix aberrant ×14, Faim répandue ×4, Sans-abri nombreux ×2 |
| Faillite d’une firme clé | 3 | non | 19,2 % | 94,2 % | 36,7 % | non (> 470) | non | Rupture de stock prolongée ×51, Surstock ×8, Sans-abri nombreux ×3, Entreprise sans employé ×43, Entreprise sans client ×45, Embauches bloquées faute de moyens ×4, Inflation quotidienne ×3, Prix aberrant ×4, Faim répandue ×2 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 22,5 % | 74,2 % | 49,6 % | non (> 470) | non | Rupture de stock prolongée ×19, Entreprise sans client ×15, Entreprise sans employé ×15, Inflation quotidienne ×3, Prix aberrant ×1, Faim répandue ×2, Sans-abri nombreux ×3, Embauches bloquées faute de moyens ×3, Pénurie de main-d’œuvre ×1, Attente trop longue (service public) ×2, Productivité du travail effondrée ×1, Santé de la population effondrée ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 14,2 % | 77,9 % | 63,3 % | 83 | 160 | Rupture de stock prolongée ×21, Surstock ×5, Entreprise sans employé ×19, Inflation quotidienne ×3, Entreprise sans client ×20, Prix aberrant ×6, Sans-abri nombreux ×2, Pénurie de main-d’œuvre ×1, Faim répandue ×1, Embauches bloquées faute de moyens ×1, Attente trop longue (service public) ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 18,3 % | 72,1 % | 69,6 % | 117 | non | Rupture de stock prolongée ×21, Surstock ×11, Sans-abri nombreux ×3, Embauches bloquées faute de moyens ×1, Entreprise sans client ×24, Entreprise sans employé ×22, Inflation quotidienne ×4, Prix aberrant ×7, Faim répandue ×1, Pénurie de main-d’œuvre ×1, Attente trop longue (service public) ×1, Santé de la population effondrée ×1, Productivité du travail effondrée ×1 |
| +25 immigrants | 1 | non | 29,8 % | 0,0 % | 6,8 % | non (> 470) | 161 | Rupture de stock prolongée ×19, Surstock ×12, Entreprise sans client ×20, Entreprise sans employé ×10, Inflation quotidienne ×6, Prix aberrant ×4 |
| +25 immigrants | 2 | non | 27,2 % | 0,0 % | 7,2 % | non (> 470) | non | Rupture de stock prolongée ×5, Surstock ×1, Entreprise sans employé ×2, Inflation quotidienne ×1, Entreprise sans client ×4, Prix aberrant ×5 |
| +25 immigrants | 3 | non | 26,0 % | 0,0 % | 6,0 % | non (> 470) | non | Rupture de stock prolongée ×10, Surstock ×1, Entreprise sans client ×6, Entreprise sans employé ×4, Prix aberrant ×5 |
| Salaire minimum 220 $/j | 1 | non | 39,6 % | 74,2 % | 17,5 % | non (> 470) | non | Rupture de stock prolongée ×11, Surstock ×9, Entreprise sans client ×13, Entreprise sans employé ×8, Inflation quotidienne ×2, Prix aberrant ×4, Chômage très élevé ×4, Embauches bloquées faute de moyens ×3, Attente trop longue (service public) ×1, Faim répandue ×2, Sans-abri nombreux ×10 |
| Salaire minimum 220 $/j | 2 | non | 25,8 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×3, Surstock ×7, Entreprise sans employé ×5, Inflation quotidienne ×4, Entreprise sans client ×11, Prix aberrant ×7 |
| Salaire minimum 220 $/j | 3 | non | 29,6 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×11, Surstock ×10, Entreprise sans client ×10, Entreprise sans employé ×9, Inflation quotidienne ×2, Inflation sur 100 jours ×2, Prix aberrant ×6 |
| Fermeture de la ferme | 1 | non | 27,1 % | 0,0 % | 8,3 % | 317 ❌ | 15 | Rupture de stock prolongée ×9, Surstock ×7, Entreprise sans client ×8, Entreprise sans employé ×4, Inflation quotidienne ×3, Prix aberrant ×7, Sans-abri nombreux ×3 |
| Fermeture de la ferme | 2 | non | 17,9 % | 29,2 % | 8,3 % | 268 ❌ | 181 | Rupture de stock prolongée ×5, Surstock ×3, Entreprise sans employé ×2, Entreprise sans client ×2, Prix aberrant ×4, Faim répandue ×1 |
| Fermeture de la ferme | 3 | non | 22,9 % | 32,9 % | 3,3 % | 271 ❌ | 95 | Rupture de stock prolongée ×9, Surstock ×5, Entreprise sans client ×7, Entreprise sans employé ×4, Inflation quotidienne ×4, Prix aberrant ×4, Faim répandue ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 23,8 % | 0,0 % | 6,7 % | 311 ❌ | 133 | Rupture de stock prolongée ×11, Surstock ×1, Entreprise sans client ×8, Entreprise sans employé ×4, Inflation quotidienne ×2, Prix aberrant ×2 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 17,5 % | 39,2 % | 20,8 % | 122 | 1 | Rupture de stock prolongée ×24, Surstock ×10, Entreprise sans employé ×21, Inflation quotidienne ×2, Entreprise sans client ×24, Prix aberrant ×6, Attente trop longue (service public) ×1, Sans-abri nombreux ×3, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Pénurie de main-d’œuvre ×1, Faim répandue ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 23,3 % | 44,6 % | 20,8 % | 162 | 1 | Rupture de stock prolongée ×20, Surstock ×7, Sans-abri nombreux ×2, Embauches bloquées faute de moyens ×1, Entreprise sans client ×24, Entreprise sans employé ×16, Inflation quotidienne ×2, Prix aberrant ×10, Attente trop longue (service public) ×1, Faim répandue ×2, Santé de la population effondrée ×1, Productivité du travail effondrée ×1 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 154 ouverture(s) critique(s) |
| Chômage moyen ≤ 10 % | ❌ | g4 11,9 % |
| Faim et sans-abri < 2 % | ❌ | g2, g3, g4, g5 |
| Gini 0,2–0,45 | ✅ | toutes les graines |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 13,39/50 j, Plancher de logement 9,94/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 15/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 11/15 échecs |

### Critère de l’institution (étape 2 bis)

| Critère | Résultat | Détail |
|---|---|---|
| Sans « Anti-crédit-fou » : chômage moyen ≤ 10 % | ❌ | g1 10,4 %, g4 10,1 % |
| Sans « Anti-crédit-fou » : faim et sans-abri < 2 % | ✅ | toutes les graines |
| Sans « Anti-crédit-fou » : aucune alerte critique | ❌ | 51 ouverture(s) critique(s) |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 8,7 % | 9,2 % |
| Faim moyenne | 5,0 % | 6,7 % |
| Sans-abri moyen | 2,4 % | 3,3 % |
| Gini moyen | 0,33 | 0,37 |
| Inflation moyenne / jour | 0,058 % | 0,055 % |
| Santé moyenne (sans filets) | 0,33 | 0,33 |
| Jours de prestations réduites (sans filets, toutes graines) | 0 | 0 |
| Trésor de l’État le plus bas (sans filets, $) | 66148 | 66148 |
| Caisse insolvable : jours (sans filets, toutes graines) | 1303 | 1303 |
| Fonds propres de la Caisse les plus bas (sans filets, $) | -13814 | -4285 |
| Prêts refusés (sans filets, toutes graines) | 0 | 235 |
| Créances radiées (sans filets, moyenne, $) | 18076 | 16057 |
| Hôpital public : attente moyenne (j, sans filets) | 315,32 | 336,92 |
| Alertes critiques (total) | 137 | 154 |
| Alertes (total) | 2381 | 2596 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,14 | 0,14 |
| Renflouements / 50 j | 13,39 | 13,39 |
| Plancher de logement / 50 j | 9,94 | 9,94 |
| Plafond de dérive / 50 j | 0,00 | 0,00 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |
| Avec filets : chômage moyen | 8,0 % | 8,0 % |
| Avec filets : faim moyenne | 0,0 % | 0,0 % |
| Avec filets : sans-abri moyen | 0,3 % | 0,3 % |
| Avec filets : Gini moyen | 0,22 | 0,22 |
| Avec filets : santé moyenne | 0,87 | 0,87 |
| Avec filets : jours de prestations réduites | 0 | 0 |
| Renflouements de l’hôpital / 50 j | 0,00 | 0,00 |
| Filets sauf --sauf : chômage moyen | 8,0 % | 8,0 % |
| Filets sauf --sauf : faim moyenne | 0,0 % | 0,0 % |
| Filets sauf --sauf : sans-abri moyen | 0,3 % | 0,3 % |
| Filets sauf --sauf : Gini moyen | 0,22 | 0,22 |
| Filets sauf --sauf : alertes critiques | 51 | 51 |
| Filets sauf --sauf : santé moyenne | 0,87 | 0,87 |
| Filets sauf --sauf : renflouements de l’hôpital / 50 j | 0,00 | 0,00 |
| Filets sauf --sauf : anti-famine / 50 j | 0,14 | 0,14 |
| Filets sauf --sauf : renflouements / 50 j | 13,39 | 13,39 |
| Filets sauf --sauf : plancher de logement / 50 j | 9,94 | 9,94 |
| Filets sauf --sauf : plafond de dérive / 50 j | 0,00 | 0,00 |
| Chocs revenus à l’équilibre en < 200 j (sans filets) | 0 | 0 |
| Chocs revenus à l’équilibre en < 200 j (avec filets) | 4 | 4 |

