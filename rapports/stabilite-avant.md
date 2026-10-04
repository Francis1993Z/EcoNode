# Protocole de stabilité ÉcoNodes

- Date : 2026-10-03 22:14
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : aucun

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 93,8 % | 100,0 % | 94,6 % | 100,0 % | 96,9 % | 100,0 % | 0,54 | 0,54 | 0,047 % | 51,0 % | 774,3 % | 119 (11) | 0.0e+0 |
| 2 | 87,0 % | 100,0 % | 83,3 % | 100,0 % | 96,4 % | 100,0 % | 0,91 | 0,97 | 0,047 % | 51,4 % | 802,1 % | 150 (12) | 0.0e+0 |
| 3 | 87,7 % | 100,0 % | 93,0 % | 100,0 % | 96,5 % | 100,0 % | 0,44 | 0,44 | 0,041 % | 11,7 % | 1084,4 % | 123 (10) | 0.0e+0 |
| 4 | 93,3 % | 100,0 % | 93,8 % | 100,0 % | 95,0 % | 100,0 % | 0,56 | 0,57 | 0,038 % | 86,8 % | 1032,1 % | 122 (9) | 0.0e+0 |
| 5 | 72,6 % | 100,0 % | 70,5 % | 100,0 % | 94,9 % | 100,0 % | 0,50 | 0,45 | 0,035 % | 8,2 % | 183,9 % | 152 (13) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 1 · 1279 j | 1 · 1240 j | 2 · 1219 j | 1 · 1283 j | 1 · 931 j |
| Faim répandue | critique | 1 · 1326 j | 4 · 1256 j | 2 · 1323 j | 1 · 1318 j | 5 · 1024 j |
| Sans-abri nombreux | critique | 3 · 1386 j | 3 · 1370 j | 2 · 1356 j | 2 · 1337 j | 3 · 1348 j |
| Inégalités hors bornes | attention | 1 · 28 j | 1 · 1250 j | · | 1 · 8 j | 2 · 214 j |
| Richesse médiane hors bornes | attention | · | 1 · 1195 j | · | · | · |
| Inflation quotidienne | critique | 5 · 16 j | 3 · 14 j | 3 · 17 j | 4 · 19 j | 2 · 12 j |
| Inflation sur 100 jours | critique | 1 · 106 j | 1 · 128 j | 1 · 103 j | 1 · 106 j | 2 · 43 j |
| Rupture de stock prolongée | attention | 23 · 20754 j | 36 · 18168 j | 29 · 20646 j | 22 · 19327 j | 36 · 17609 j |
| Surstock | attention | 13 · 8365 j | 21 · 10094 j | 11 · 8256 j | 15 · 9558 j | 18 · 9717 j |
| Entreprise sans employé | attention | 35 · 43720 j | 36 · 41996 j | 36 · 43130 j | 36 · 43250 j | 37 · 40373 j |
| Entreprise sans client | attention | 36 · 43844 j | 43 · 41713 j | 37 · 43038 j | 39 · 43306 j | 46 · 40270 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 0,0 % | 0,0 % | 0,0 % | 32 | 0 $ | 45 964 $ | 10 945 $ |
| 2 | 0,0 % | 0,0 % | 0,0 % | 32 | 0 $ | 62 910 $ | 17 971 $ |
| 3 | 0,0 % | 0,0 % | 0,0 % | 32 | 0 $ | 73 625 $ | 17 877 $ |
| 4 | 0,0 % | 0,0 % | 0,0 % | 32 | 0 $ | 67 908 $ | 21 616 $ |
| 5 | 0,0 % | 0,0 % | 0,0 % | 32 | 0 $ | 75 605 $ | 24 932 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 3,7 % | 15,8 % | 0,0 % | 0,0 % | 0,2 % | 24,6 % | 0,28 | 0,30 | -0,011 % | 1,4 % | 48,8 % | 103 (2) | 0.0e+0 |
| 2 | 4,0 % | 20,8 % | 0,0 % | 11,3 % | 0,3 % | 43,8 % | 0,33 | 0,38 | -0,023 % | 1,4 % | 63,9 % | 112 (2) | 0.0e+0 |
| 3 | 5,0 % | 19,2 % | 0,0 % | 0,0 % | 0,4 % | 100,0 % | 0,37 | 0,47 | -0,019 % | 1,4 % | 47,0 % | 130 (3) | 0.0e+0 |
| 4 | 6,2 % | 20,0 % | 0,0 % | 60,8 % | 1,3 % | 100,0 % | 0,45 | 0,51 | -0,020 % | 1,4 % | 44,5 % | 186 (4) | 0.0e+0 |
| 5 | 5,9 % | 27,1 % | 0,0 % | 21,7 % | 0,8 % | 100,0 % | 0,42 | 0,64 | -0,039 % | 1,5 % | 40,8 % | 126 (5) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 26 · 0,00 | 1 · 0,00 | 0,00 ✅ | pas de producteur (100 %) |
| Renflouement d’entreprise | 1929 · 65,64 | 2006 · 67,68 | 1929 · 65,21 | 1932 · 65,32 | 1962 · 66,39 | 66,05 ❌ | par le propriétaire (98 %) ; après rachat (2 %) |
| Plancher de logement | 11 · 0,21 | 185 · 1,75 | 94 · 3,36 | 1445 · 51,61 | 797 · 6,36 | 12,66 ❌ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 7088 · 214,82 | 7035 · 207,29 | 7505 · 227,25 | 8686 · 265,36 | 7503 · 217,96 | 226,54 ❌ | hausse de prix (57 %) ; baisse de prix (41 %) |
| Anti-crédit-fou | 2200 · 74,46 | 1932 · 64,71 | 1780 · 58,61 | 2080 · 69,07 | 2012 · 68,82 | 67,14 ❌ | fonds propres de la Caisse insuffisants (100 %) ; paiements > 35 % de la valeur ajoutée (0 %) |

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage 3–10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non (effondrée) | 100,0 % | 100,0 % | 100,0 % | s. o. | s. o. | — |
| Hélicoptère 5 000 $/citoyen | 2 | non | 100,0 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×5, Entreprise sans client ×8, Inflation quotidienne ×1, Entreprise sans employé ×8, Faim répandue ×1, Inégalités hors bornes ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 100,0 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×3, Entreprise sans employé ×6, Entreprise sans client ×7, Surstock ×1, Faim répandue ×1, Chômage très élevé ×1 |
| +25 immigrants | 1 | non (effondrée) | 100,0 % | 100,0 % | 100,0 % | s. o. | s. o. | — |
| +25 immigrants | 2 | non | 100,0 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×8, Entreprise sans client ×9, Inflation quotidienne ×1, Surstock ×2, Entreprise sans employé ×8, Richesse médiane hors bornes ×1 |
| +25 immigrants | 3 | non | 100,0 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×4, Entreprise sans employé ×6, Entreprise sans client ×7, Faim répandue ×1, Chômage très élevé ×1 |
| Salaire minimum 220 $/j | 1 | non (effondrée) | 100,0 % | 100,0 % | 100,0 % | s. o. | s. o. | Inflation quotidienne ×1 |
| Salaire minimum 220 $/j | 2 | non | 100,0 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×9, Entreprise sans client ×9, Inflation quotidienne ×1, Surstock ×4, Entreprise sans employé ×10, Richesse médiane hors bornes ×1 |
| Salaire minimum 220 $/j | 3 | non | 100,0 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×3, Entreprise sans employé ×6, Entreprise sans client ×7, Surstock ×1, Faim répandue ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 1 | non (effondrée) | 100,0 % | 100,0 % | 100,0 % | s. o. | s. o. | — |
| Fermeture de la ferme | 2 | non | 100,0 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×5, Entreprise sans client ×7, Inflation quotidienne ×1, Entreprise sans employé ×7, Richesse médiane hors bornes ×2 |
| Fermeture de la ferme | 3 | non | 100,0 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×3, Entreprise sans employé ×5, Entreprise sans client ×6, Surstock ×1, Faim répandue ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non (effondrée) | 100,0 % | 100,0 % | 100,0 % | s. o. | s. o. | — |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 99,6 % | 97,9 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×14, Entreprise sans client ×8, Inflation quotidienne ×1, Surstock ×4, Entreprise sans employé ×5, Richesse médiane hors bornes ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 100,0 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×4, Entreprise sans employé ×6, Entreprise sans client ×7, Faim répandue ×1, Chômage très élevé ×1 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 67,1 % | 64,6 % | 95,0 % | 464 ❌ | non | Rupture de stock prolongée ×24, Sans-abri nombreux ×7, Surstock ×27, Entreprise sans employé ×13, Entreprise sans client ×21, Faim répandue ×4, Inflation sur 100 jours ×1, Inégalités hors bornes ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 67,1 % | 48,8 % | 76,7 % | 405 ❌ | non | Rupture de stock prolongée ×27, Sans-abri nombreux ×3, Surstock ×29, Entreprise sans client ×26, Entreprise sans employé ×18, Faim répandue ×3, Inflation sur 100 jours ×1, Inégalités hors bornes ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 67,9 % | 73,8 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×28, Surstock ×27, Entreprise sans client ×23, Entreprise sans employé ×17, Sans-abri nombreux ×6, Faim répandue ×2, Inflation sur 100 jours ×1, Inégalités hors bornes ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×1 |
| +25 immigrants | 1 | non | 46,8 % | 0,0 % | 14,0 % | non (> 470) | non | Rupture de stock prolongée ×3, Sans-abri nombreux ×3, Surstock ×13, Entreprise sans employé ×5, Entreprise sans client ×7, Inégalités hors bornes ×1, Chômage très élevé ×1 |
| +25 immigrants | 2 | non | 44,2 % | 0,0 % | 14,7 % | non (> 470) | non | Rupture de stock prolongée ×12, Sans-abri nombreux ×7, Surstock ×14, Entreprise sans client ×6, Entreprise sans employé ×2, Inégalités hors bornes ×1, Chômage très élevé ×1 |
| +25 immigrants | 3 | non | 46,4 % | 0,0 % | 16,2 % | non (> 470) | non | Rupture de stock prolongée ×12, Surstock ×14, Entreprise sans client ×12, Entreprise sans employé ×6, Sans-abri nombreux ×2, Inégalités hors bornes ×1, Chômage très élevé ×1 |
| Salaire minimum 220 $/j | 1 | non | 5,8 % | 0,0 % | 0,0 % | 148 | 1 | Rupture de stock prolongée ×7, Surstock ×12, Entreprise sans employé ×1, Entreprise sans client ×9 |
| Salaire minimum 220 $/j | 2 | non | 8,3 % | 0,0 % | 0,0 % | 144 | 25 | Rupture de stock prolongée ×8, Surstock ×8, Entreprise sans client ×9, Entreprise sans employé ×4 |
| Salaire minimum 220 $/j | 3 | non | 9,6 % | 0,0 % | 0,0 % | 159 | 22 | Rupture de stock prolongée ×8, Surstock ×10, Entreprise sans client ×9, Entreprise sans employé ×3 |
| Fermeture de la ferme | 1 | non | 41,3 % | 90,0 % | 14,2 % | non (> 470) | non | Rupture de stock prolongée ×16, Sans-abri nombreux ×1, Surstock ×12, Entreprise sans employé ×14, Entreprise sans client ×20, Faim répandue ×1, Inflation sur 100 jours ×1, Inégalités hors bornes ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 2 | non | 27,1 % | 87,9 % | 16,3 % | non (> 470) | non | Rupture de stock prolongée ×11, Surstock ×11, Entreprise sans client ×12, Entreprise sans employé ×17, Faim répandue ×1, Inflation sur 100 jours ×1, Inégalités hors bornes ×1 |
| Fermeture de la ferme | 3 | non | 35,4 % | 87,9 % | 27,5 % | non (> 470) | non | Rupture de stock prolongée ×9, Surstock ×10, Entreprise sans client ×12, Entreprise sans employé ×15, Faim répandue ×1, Inflation sur 100 jours ×1, Inégalités hors bornes ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 11,3 % | 0,0 % | 0,0 % | 58 | 1 | Rupture de stock prolongée ×7, Surstock ×6, Entreprise sans employé ×3, Entreprise sans client ×6 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 8,3 % | 0,0 % | 0,0 % | 250 ❌ | 8 | Rupture de stock prolongée ×10, Surstock ×10, Entreprise sans client ×6, Entreprise sans employé ×3 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 22,1 % | 0,0 % | 42,1 % | 131 | 199 | Rupture de stock prolongée ×13, Surstock ×11, Entreprise sans client ×8, Entreprise sans employé ×4, Sans-abri nombreux ×1 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 55 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g1 93,8 %, g2 87,0 %, g3 87,7 %, g4 93,3 %, g5 72,6 % |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ❌ | g1 0,54, g2 0,91, g4 0,56, g5 0,50 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 66,05/50 j, Plancher de logement 12,66/50 j, Plafond de dérive des prix et salaires 226,54/50 j, Anti-crédit-fou 67,14/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 15/15 échecs (dont 5 sur économie déjà effondrée) |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 10/15 échecs |

