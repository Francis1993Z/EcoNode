# Protocole de stabilité ÉcoNodes

- Date : 2026-10-10 13:19
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Dividendes : test de solvabilité

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 9,9 % | 59,6 % | 5,0 % | 88,8 % | 1,9 % | 34,2 % | 0,26 | 0,86 | 0,061 % | 15,1 % | 155,4 % | 474 (26) | 0.0e+0 |
| 2 | 5,3 % | 12,1 % | 0,0 % | 30,4 % | 0,6 % | 40,0 % | 0,39 | 0,33 | 0,072 % | 4,8 % | 108,6 % | 160 (6) | 0.0e+0 |
| 3 | 10,0 % | 77,1 % | 7,6 % | 95,4 % | 3,8 % | 49,6 % | 0,40 | 0,90 | 0,035 % | 2,4 % | 103,7 % | 332 (24) | 0.0e+0 |
| 4 | 10,6 % | 29,6 % | 3,9 % | 87,9 % | 4,1 % | 66,3 % | 0,40 | 0,24 | 0,024 % | 5,0 % | 121,3 % | 587 (23) | 0.0e+0 |
| 5 | 10,2 % | 54,6 % | 12,0 % | 97,9 % | 4,1 % | 71,7 % | 0,41 | 0,85 | 0,050 % | 4,4 % | 177,8 % | 727 (25) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 1 · 51 j | · | 1 · 44 j | · | 1 · 35 j |
| Faim répandue | critique | 5 · 135 j | 2 · 24 j | 9 · 195 j | 9 · 115 j | 8 · 331 j |
| Sans-abri nombreux | critique | 12 · 138 j | 2 · 38 j | 12 · 246 j | 12 · 341 j | 14 · 302 j |
| Inégalités hors bornes | attention | 1 · 35 j | · | 4 · 270 j | 2 · 312 j | 5 · 264 j |
| Richesse médiane hors bornes | attention | · | · | 1 · 6 j | 1 · 23 j | · |
| Inflation quotidienne | critique | 4 · 4 j | · | · | · | · |
| Inflation sur 100 jours | critique | 3 · 48 j | 1 · 9 j | 1 · 6 j | 1 · 15 j | 1 · 44 j |
| Rupture de stock prolongée | attention | 116 · 3577 j | 36 · 891 j | 64 · 2146 j | 132 · 4629 j | 179 · 6847 j |
| Surstock | attention | 17 · 359 j | 9 · 120 j | 16 · 227 j | 22 · 251 j | 32 · 450 j |
| Entreprise sans employé | attention | 142 · 1949 j | 51 · 693 j | 101 · 1407 j | 188 · 2567 j | 223 · 3104 j |
| Entreprise sans client | attention | 137 · 2635 j | 47 · 659 j | 98 · 2208 j | 186 · 3925 j | 230 · 4681 j |
| Caisse insolvable | attention | 2 · 990 j | · | 1 · 1361 j | · | 1 · 1151 j |
| Santé de la population effondrée | critique | 1 · 1329 j | 1 · 1343 j | 1 · 1280 j | 1 · 1331 j | 1 · 1354 j |
| Productivité du travail effondrée | attention | 1 · 1328 j | 1 · 1343 j | 1 · 1280 j | 1 · 1331 j | 1 · 1418 j |
| Pénurie de main-d’œuvre | attention | 1 · 2 j | 1 · 10 j | 1 · 7 j | 1 · 7 j | · |
| Embauches bloquées faute de moyens | attention | 10 · 344 j | 2 · 87 j | 10 · 356 j | 12 · 394 j | 7 · 965 j |
| Prix aberrant | attention | 21 · 2830 j | 7 · 796 j | 11 · 987 j | 19 · 1986 j | 24 · 2626 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 3,1 % | 45,9 % | 51,0 % | 6 | 5 881 $ | 309 991 $ | 36 856 $ |
| 2 | 8,5 % | 18,8 % | 72,6 % | 0 | 13 661 $ | 221 127 $ | 25 792 $ |
| 3 | 3,6 % | 23,6 % | 72,7 % | 6 | 8 627 $ | 330 041 $ | 54 285 $ |
| 4 | 11,4 % | 18,0 % | 70,6 % | 4 | 3 407 $ | 405 129 $ | 27 379 $ |
| 5 | 12,9 % | 34,7 % | 52,4 % | 1 | 16 772 $ | 474 059 $ | 61 158 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 3,1 % | 11,3 % | 0,0 % | 10,0 % | 0,0 % | 23,8 % | 0,14 | 0,15 | 0,004 % | 59,0 % | 112,0 % | 88 (6) | 0.0e+0 |
| 2 | 3,4 % | 13,8 % | 0,2 % | 62,5 % | 0,0 % | 21,3 % | 0,16 | 0,16 | 0,020 % | 73,9 % | 86,3 % | 106 (4) | 0.0e+0 |
| 3 | 3,7 % | 22,5 % | 0,0 % | 20,8 % | 0,0 % | 43,8 % | 0,17 | 0,15 | -0,006 % | 52,7 % | 136,0 % | 123 (9) | 0.0e+0 |
| 4 | 5,3 % | 14,6 % | 0,0 % | 33,8 % | 0,9 % | 57,1 % | 0,31 | 0,31 | 0,037 % | 3,9 % | 100,7 % | 77 (4) | 0.0e+0 |
| 5 | 4,6 % | 16,7 % | 0,1 % | 46,7 % | 0,1 % | 35,4 % | 0,16 | 0,10 | 0,040 % | 58,5 % | 154,2 % | 155 (12) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 53 · 1,89 | 4 · 0,00 | 45 · 0,00 | 19 · 0,50 | 0,48 ✅ | pas de producteur (100 %) |
| Renflouement d’entreprise | 695 · 23,21 | 912 · 30,39 | 782 · 24,68 | 652 · 20,93 | 872 · 29,25 | 25,69 ❌ | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 18 · 0,00 | 15 · 0,00 | 260 · 0,00 | 1801 · 27,61 | 63 · 0,21 | 5,56 ❌ | parc plein (64 %) ; prix trop élevé (36 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 26 · 0,93 | 0,19 ✅ | fonds propres de la Caisse insuffisants (100 %) |

## 2 bis. Avec filets, sauf : Renflouement d’entreprise

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 9,0 % | 26,7 % | 7,6 % | 95,8 % | 2,5 % | 49,6 % | 0,39 | 0,31 | 0,078 % | 18,6 % | 150,6 % | 613 (23) | 0.0e+0 |
| 2 | 7,0 % | 25,8 % | 5,4 % | 95,0 % | 1,3 % | 32,5 % | 0,34 | 0,37 | 0,077 % | 2,3 % | 108,4 % | 514 (20) | 0.0e+0 |
| 3 | 6,3 % | 23,8 % | 0,2 % | 35,8 % | 0,9 % | 45,8 % | 0,28 | 0,29 | 0,049 % | 5,5 % | 154,6 % | 303 (10) | 0.0e+0 |
| 4 | 6,6 % | 20,8 % | 0,3 % | 42,1 % | 0,5 % | 45,8 % | 0,24 | 0,28 | 0,042 % | 4,8 % | 109,8 % | 288 (9) | 0.0e+0 |
| 5 | 7,9 % | 32,1 % | 3,4 % | 85,0 % | 0,6 % | 55,8 % | 0,27 | 0,29 | 0,029 % | 5,3 % | 123,3 % | 384 (10) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 6880 · 245,71 | 4562 · 162,71 | 27 · 0,29 | 85 · 2,54 | 2969 · 92,64 | 100,78 ❌ | pas de producteur (100 %) |
| Renflouement d’entreprise | — | — | — | — | — | coupé | — |
| Plancher de logement | 1189 · 42,25 | 365 · 12,75 | 542 · 8,82 | 457 · 6,32 | 876 · 8,36 | 15,70 ❌ | parc plein (53 %) ; prix trop élevé (47 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 323 · 11,54 | 142 · 5,07 | 115 · 4,11 | 0 · 0,00 | 91 · 3,25 | 4,79 ❌ | fonds propres de la Caisse insuffisants (100 %) |

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 21,7 % | 90,8 % | 40,0 % | non (> 470) | 42 | Rupture de stock prolongée ×36, Entreprise sans client ×59, Entreprise sans employé ×57, Sans-abri nombreux ×5, Embauches bloquées faute de moyens ×6, Inflation quotidienne ×2, Prix aberrant ×6, Caisse insolvable ×1, Faim répandue ×2, Inégalités hors bornes ×2 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 17,1 % | 84,6 % | 37,9 % | non (> 470) | non | Rupture de stock prolongée ×24, Faim répandue ×1, Sans-abri nombreux ×2, Entreprise sans employé ×36, Entreprise sans client ×35, Embauches bloquées faute de moyens ×3, Prix aberrant ×2, Inflation quotidienne ×1, Inégalités hors bornes ×3 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 21,3 % | 26,3 % | 70,4 % | non (> 470) | 377 | Rupture de stock prolongée ×15, Sans-abri nombreux ×1, Entreprise sans employé ×36, Entreprise sans client ×37, Faim répandue ×1, Embauches bloquées faute de moyens ×3, Prix aberrant ×5, Inflation quotidienne ×1, Inégalités hors bornes ×1 |
| +25 immigrants | 1 | non | 78,5 % | 95,8 % | 72,1 % | non (> 470) | non | Rupture de stock prolongée ×61, Surstock ×5, Entreprise sans client ×89, Entreprise sans employé ×81, Sans-abri nombreux ×5, Embauches bloquées faute de moyens ×5, Prix aberrant ×9, Caisse insolvable ×1, Faim répandue ×2, Chômage très élevé ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| +25 immigrants | 2 | non | 32,5 % | 88,7 % | 28,7 % | non (> 470) | non | Rupture de stock prolongée ×49, Surstock ×6, Faim répandue ×2, Sans-abri nombreux ×10, Entreprise sans employé ×47, Entreprise sans client ×49, Embauches bloquées faute de moyens ×4, Prix aberrant ×11, Inégalités hors bornes ×1 |
| +25 immigrants | 3 | non | 22,6 % | 0,0 % | 11,3 % | non (> 470) | non | Rupture de stock prolongée ×26, Sans-abri nombreux ×5, Surstock ×1, Entreprise sans employé ×47, Entreprise sans client ×47, Embauches bloquées faute de moyens ×7, Prix aberrant ×5, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | non | 31,3 % | 85,8 % | 27,1 % | non (> 470) | 372 | Rupture de stock prolongée ×40, Surstock ×2, Entreprise sans client ×50, Entreprise sans employé ×49, Sans-abri nombreux ×8, Embauches bloquées faute de moyens ×4, Prix aberrant ×7, Caisse insolvable ×1, Faim répandue ×1 |
| Salaire minimum 220 $/j | 2 | non | 11,3 % | 0,0 % | 7,1 % | non (> 470) | 208 | Rupture de stock prolongée ×2, Surstock ×2, Entreprise sans employé ×10, Entreprise sans client ×10, Prix aberrant ×2 |
| Salaire minimum 220 $/j | 3 | non | 10,0 % | 0,0 % | 6,3 % | non (> 470) | 1 | Rupture de stock prolongée ×1, Entreprise sans employé ×11, Entreprise sans client ×11, Prix aberrant ×3 |
| Fermeture de la ferme | 1 | non | 98,3 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×45, Entreprise sans client ×86, Entreprise sans employé ×81, Sans-abri nombreux ×1, Embauches bloquées faute de moyens ×7, Inflation quotidienne ×1, Prix aberrant ×3, Caisse insolvable ×1, Faim répandue ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 2 | non | 100,0 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×36, Faim répandue ×1, Sans-abri nombreux ×1, Entreprise sans employé ×60, Entreprise sans client ×62, Embauches bloquées faute de moyens ×7, Productivité du travail effondrée ×1, Prix aberrant ×1, Caisse insolvable ×1, Chômage très élevé ×1, Inflation quotidienne ×2 |
| Fermeture de la ferme | 3 | non | 100,0 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×36, Sans-abri nombreux ×1, Entreprise sans employé ×62, Entreprise sans client ×62, Faim répandue ×1, Embauches bloquées faute de moyens ×2, Productivité du travail effondrée ×1, Chômage très élevé ×1, Inflation quotidienne ×2 |
| Faillite d’une firme clé | 1 | non | 31,3 % | 85,8 % | 27,1 % | non (> 470) | 304 | Rupture de stock prolongée ×45, Surstock ×5, Entreprise sans client ×53, Entreprise sans employé ×56, Sans-abri nombreux ×8, Embauches bloquées faute de moyens ×4, Prix aberrant ×8, Caisse insolvable ×1, Faim répandue ×1 |
| Faillite d’une firme clé | 2 | non | 11,3 % | 0,0 % | 7,1 % | non (> 470) | 208 | Rupture de stock prolongée ×2, Surstock ×2, Entreprise sans employé ×10, Entreprise sans client ×10, Prix aberrant ×2 |
| Faillite d’une firme clé | 3 | non | 10,0 % | 0,0 % | 6,3 % | non (> 470) | 1 | Rupture de stock prolongée ×1, Entreprise sans employé ×11, Entreprise sans client ×11, Prix aberrant ×3 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | oui | 11,3 % | 57,9 % | 61,7 % | 107 | non | Rupture de stock prolongée ×24, Surstock ×6, Faim répandue ×1, Sans-abri nombreux ×1, Entreprise sans client ×16, Pénurie de main-d’œuvre ×2, Entreprise sans employé ×12, Embauches bloquées faute de moyens ×1, Prix aberrant ×6, Inflation sur 100 jours ×1, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Caisse insolvable ×2, Inflation quotidienne ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | oui | 29,6 % | 69,2 % | 64,2 % | non (> 470) | non | Rupture de stock prolongée ×39, Surstock ×11, Sans-abri nombreux ×3, Entreprise sans client ×31, Entreprise sans employé ×22, Pénurie de main-d’œuvre ×2, Embauches bloquées faute de moyens ×3, Prix aberrant ×8, Faim répandue ×3, Inflation quotidienne ×7, Productivité du travail effondrée ×1, Santé de la population effondrée ×1, Caisse insolvable ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | oui | 25,0 % | 44,2 % | 60,8 % | 106 | 95 | Rupture de stock prolongée ×30, Sans-abri nombreux ×5, Surstock ×6, Entreprise sans client ×18, Faim répandue ×3, Pénurie de main-d’œuvre ×1, Entreprise sans employé ×14, Embauches bloquées faute de moyens ×2, Inflation sur 100 jours ×1, Prix aberrant ×5, Chômage nul prolongé ×1, Santé de la population effondrée ×1, Productivité du travail effondrée ×1 |
| +25 immigrants | 1 | oui | 14,0 % | 0,0 % | 6,0 % | non (> 470) | non | Rupture de stock prolongée ×8, Surstock ×1, Entreprise sans client ×3, Entreprise sans employé ×2, Prix aberrant ×6 |
| +25 immigrants | 2 | oui | 15,8 % | 0,0 % | 6,4 % | non (> 470) | non | Rupture de stock prolongée ×2, Surstock ×1, Entreprise sans client ×1, Entreprise sans employé ×1, Prix aberrant ×2 |
| +25 immigrants | 3 | oui | 12,5 % | 0,0 % | 6,4 % | non (> 470) | non | Entreprise sans employé ×1, Prix aberrant ×4 |
| Salaire minimum 220 $/j | 1 | oui | 5,4 % | 0,0 % | 0,0 % | 1 | non | Rupture de stock prolongée ×6, Surstock ×2, Entreprise sans client ×5, Entreprise sans employé ×4, Prix aberrant ×5, Inflation sur 100 jours ×2 |
| Salaire minimum 220 $/j | 2 | oui | 7,1 % | 0,0 % | 0,0 % | 1 | non | Rupture de stock prolongée ×5, Surstock ×4, Entreprise sans client ×5, Entreprise sans employé ×5, Prix aberrant ×3 |
| Salaire minimum 220 $/j | 3 | oui | 8,3 % | 0,0 % | 0,0 % | 1 | 1 | Rupture de stock prolongée ×7, Surstock ×5, Entreprise sans client ×4, Entreprise sans employé ×3, Prix aberrant ×5, Inflation quotidienne ×2 |
| Fermeture de la ferme | 1 | oui | 8,3 % | 0,0 % | 1,3 % | 1 | non | Rupture de stock prolongée ×10, Surstock ×8, Entreprise sans client ×11, Entreprise sans employé ×7, Embauches bloquées faute de moyens ×1, Prix aberrant ×8, Inflation quotidienne ×2 |
| Fermeture de la ferme | 2 | oui | 10,4 % | 0,0 % | 0,0 % | 4 | 401 | Rupture de stock prolongée ×10, Surstock ×5, Entreprise sans client ×8, Entreprise sans employé ×6, Embauches bloquées faute de moyens ×1, Prix aberrant ×5, Inflation sur 100 jours ×1 |
| Fermeture de la ferme | 3 | oui | 13,8 % | 69,2 % | 20,0 % | 93 | 46 | Rupture de stock prolongée ×8, Surstock ×5, Entreprise sans client ×7, Faim répandue ×1, Entreprise sans employé ×5, Embauches bloquées faute de moyens ×1, Prix aberrant ×1, Caisse insolvable ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | oui | 6,3 % | 0,0 % | 0,8 % | 1 | non | Rupture de stock prolongée ×5, Surstock ×5, Entreprise sans client ×7, Entreprise sans employé ×6, Prix aberrant ×7, Inflation quotidienne ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | oui | 7,9 % | 0,0 % | 0,0 % | 1 | 79 | Rupture de stock prolongée ×3, Surstock ×6, Entreprise sans client ×3, Entreprise sans employé ×1, Embauches bloquées faute de moyens ×2, Prix aberrant ×4 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | oui | 9,6 % | 0,0 % | 1,3 % | 1 | 1 | Rupture de stock prolongée ×8, Surstock ×3, Entreprise sans client ×3, Entreprise sans employé ×3, Prix aberrant ×4 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 104 ouverture(s) critique(s) |
| Chômage moyen ≤ 10 % | ❌ | g3 10,0 %, g4 10,6 %, g5 10,2 % |
| Faim et sans-abri < 2 % | ❌ | g1, g3, g4, g5 |
| Gini 0,2–0,45 | ✅ | toutes les graines |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 25,69/50 j, Plancher de logement 5,56/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 15/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 4/15 échecs |

### Critère de l’institution (étape 2 bis)

| Critère | Résultat | Détail |
|---|---|---|
| Sans « Renflouement d’entreprise » : chômage moyen ≤ 10 % | ✅ | toutes les graines |
| Sans « Renflouement d’entreprise » : faim et sans-abri < 2 % | ❌ | g1, g2, g5 |
| Sans « Renflouement d’entreprise » : aucune alerte critique | ❌ | 72 ouverture(s) critique(s) |

