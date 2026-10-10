# Protocole de stabilité ÉcoNodes

- Date : 2026-10-10 14:29
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : aucun

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,8 % | 17,9 % | 0,0 % | 0,0 % | 0,1 % | 4,6 % | 0,21 | 0,17 | 0,045 % | 41,6 % | 138,6 % | 209 (11) | 0.0e+0 |
| 2 | 8,8 % | 25,8 % | 8,2 % | 96,3 % | 4,1 % | 71,7 % | 0,37 | 0,23 | 0,055 % | 26,9 % | 163,9 % | 569 (35) | 0.0e+0 |
| 3 | 8,1 % | 26,7 % | 6,5 % | 94,6 % | 2,6 % | 64,2 % | 0,36 | 0,49 | 0,063 % | 23,2 % | 137,0 % | 613 (29) | 0.0e+0 |
| 4 | 10,5 % | 33,8 % | 5,1 % | 88,8 % | 1,4 % | 80,0 % | 0,33 | 0,32 | 0,079 % | 20,9 % | 134,6 % | 600 (37) | 0.0e+0 |
| 5 | 7,0 % | 22,1 % | 7,7 % | 95,0 % | 1,6 % | 34,6 % | 0,33 | 0,27 | 0,048 % | 31,2 % | 124,5 % | 625 (23) | 0.0e+0 |

Santé moyenne de la population : g1 0,88, g2 0,18, g3 0,13, g4 0,20, g5 0,14.

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Faim répandue | critique | · | 9 · 181 j | 5 · 136 j | 7 · 110 j | 6 · 151 j |
| Sans-abri nombreux | critique | · | 12 · 163 j | 10 · 106 j | 19 · 116 j | 7 · 79 j |
| Inégalités hors bornes | attention | · | 3 · 109 j | 4 · 209 j | 2 · 27 j | 5 · 141 j |
| Inflation quotidienne | critique | 10 · 10 j | 9 · 9 j | 11 · 11 j | 9 · 9 j | 7 · 7 j |
| Inflation sur 100 jours | critique | 1 · 28 j | 4 · 73 j | 2 · 27 j | 1 · 23 j | 2 · 28 j |
| Rupture de stock prolongée | attention | 39 · 1961 j | 148 · 5911 j | 157 · 5948 j | 171 · 5822 j | 159 · 5774 j |
| Surstock | attention | 24 · 1214 j | 37 · 1255 j | 52 · 1602 j | 47 · 1258 j | 47 · 1234 j |
| Entreprise sans employé | attention | 53 · 729 j | 146 · 2006 j | 155 · 2110 j | 144 · 1976 j | 168 · 2276 j |
| Entreprise sans client | attention | 69 · 2990 j | 166 · 4772 j | 182 · 6103 j | 168 · 5176 j | 191 · 5814 j |
| Caisse insolvable | attention | · | · | · | · | 1 · 1277 j |
| Santé de la population effondrée | critique | · | 1 · 1221 j | 1 · 1251 j | 1 · 1144 j | 1 · 1237 j |
| Productivité du travail effondrée | attention | · | 1 · 1216 j | 1 · 1252 j | 1 · 1147 j | 1 · 1237 j |
| Pénurie de main-d’œuvre | attention | · | 1 · 14 j | · | 1 · 5 j | · |
| Embauches bloquées faute de moyens | attention | · | 9 · 335 j | 9 · 313 j | 11 · 267 j | 7 · 348 j |
| Prix aberrant | attention | 12 · 4792 j | 22 · 1344 j | 23 · 2416 j | 16 · 1636 j | 22 · 2836 j |
| Attente trop longue (service public) | attention | 1 · 2 j | 1 · 1380 j | 1 · 1380 j | 2 · 1383 j | 1 · 1380 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 6,4 % | 12,3 % | 81,3 % | 2 | 0 $ | 44 001 $ | 7 370 $ |
| 2 | 8,2 % | 26,9 % | 64,8 % | 5 | 12 074 $ | 139 893 $ | 21 264 $ |
| 3 | 10,0 % | 20,5 % | 69,5 % | 4 | 0 $ | 114 283 $ | 17 149 $ |
| 4 | 9,3 % | 27,4 % | 63,3 % | 4 | 17 789 $ | 185 827 $ | 20 659 $ |
| 5 | 9,3 % | 20,4 % | 70,4 % | 4 | 0 $ | 62 667 $ | 26 900 $ |

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

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 13,8 % | 82,5 % | 74,6 % | 119 | 269 | Rupture de stock prolongée ×26, Surstock ×2, Entreprise sans employé ×30, Entreprise sans client ×30, Attente trop longue (service public) ×1, Prix aberrant ×5, Sans-abri nombreux ×1, Faim répandue ×1, Pénurie de main-d’œuvre ×1, Productivité du travail effondrée ×2, Embauches bloquées faute de moyens ×1, Santé de la population effondrée ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 96,7 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×54, Surstock ×5, Entreprise sans employé ×86, Entreprise sans client ×90, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×1, Attente trop longue (service public) ×1, Prix aberrant ×4, Faim répandue ×2, Sans-abri nombreux ×2, Pénurie de main-d’œuvre ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 99,6 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×53, Sans-abri nombreux ×1, Entreprise sans employé ×78, Entreprise sans client ×79, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×4, Attente trop longue (service public) ×1, Prix aberrant ×1, Faim répandue ×2, Pénurie de main-d’œuvre ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×1 |
| +25 immigrants | 1 | non | 30,2 % | 0,0 % | 12,1 % | non (> 470) | non | Rupture de stock prolongée ×13, Surstock ×3, Entreprise sans employé ×16, Entreprise sans client ×23, Prix aberrant ×4, Inflation quotidienne ×4, Inégalités hors bornes ×2, Sans-abri nombreux ×10 |
| +25 immigrants | 2 | non | 48,3 % | 92,1 % | 35,5 % | non (> 470) | non | Rupture de stock prolongée ×65, Surstock ×23, Entreprise sans employé ×67, Entreprise sans client ×73, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×1, Prix aberrant ×4, Faim répandue ×1, Sans-abri nombreux ×3, Chômage très élevé ×1, Inégalités hors bornes ×1, Prestations réduites faute de trésor ×1 |
| +25 immigrants | 3 | non | 29,1 % | 87,5 % | 31,7 % | non (> 470) | 46 | Rupture de stock prolongée ×84, Surstock ×21, Sans-abri nombreux ×6, Entreprise sans employé ×70, Entreprise sans client ×81, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×7, Prix aberrant ×6, Faim répandue ×3, Inégalités hors bornes ×2, Richesse médiane hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | non | 30,0 % | 0,0 % | 10,8 % | non (> 470) | non | Rupture de stock prolongée ×10, Surstock ×13, Entreprise sans employé ×13, Entreprise sans client ×14, Prix aberrant ×1, Inflation quotidienne ×2, Sans-abri nombreux ×12, Embauches bloquées faute de moyens ×1 |
| Salaire minimum 220 $/j | 2 | non | 36,3 % | 75,0 % | 20,0 % | non (> 470) | 1 | Rupture de stock prolongée ×53, Surstock ×12, Entreprise sans employé ×33, Entreprise sans client ×44, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×2, Prix aberrant ×3, Faim répandue ×2, Sans-abri nombreux ×8, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 3 | non | 33,3 % | 94,6 % | 34,6 % | non (> 470) | non | Rupture de stock prolongée ×53, Surstock ×6, Sans-abri nombreux ×8, Entreprise sans employé ×38, Entreprise sans client ×47, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×1, Prix aberrant ×6, Faim répandue ×3, Inégalités hors bornes ×2 |
| Fermeture de la ferme | 1 | non | 14,2 % | 0,0 % | 2,9 % | 109 | 37 | Rupture de stock prolongée ×8, Surstock ×3, Entreprise sans employé ×9, Entreprise sans client ×18, Prix aberrant ×4, Inflation quotidienne ×6 |
| Fermeture de la ferme | 2 | non | 85,4 % | 100,0 % | 77,9 % | non (> 470) | non | Rupture de stock prolongée ×104, Surstock ×6, Entreprise sans employé ×116, Entreprise sans client ×138, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×13, Attente trop longue (service public) ×1, Prix aberrant ×11, Faim répandue ×1, Sans-abri nombreux ×5, Prestations réduites faute de trésor ×1, Chômage très élevé ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| Fermeture de la ferme | 3 | non | 96,3 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×62, Surstock ×2, Sans-abri nombreux ×2, Entreprise sans employé ×88, Entreprise sans client ×94, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×2, Attente trop longue (service public) ×1, Prix aberrant ×7, Faim répandue ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé | 1 | non | 10,4 % | 0,0 % | 2,1 % | 21 | 1 | Rupture de stock prolongée ×8, Surstock ×4, Entreprise sans employé ×11, Entreprise sans client ×21, Prix aberrant ×4, Inflation quotidienne ×5 |
| Faillite d’une firme clé | 2 | non | 25,0 % | 93,3 % | 25,4 % | non (> 470) | 1 | Rupture de stock prolongée ×66, Surstock ×9, Entreprise sans employé ×52, Entreprise sans client ×64, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×2, Prix aberrant ×14, Faim répandue ×4, Sans-abri nombreux ×2 |
| Faillite d’une firme clé | 3 | non | 26,7 % | 94,6 % | 32,1 % | non (> 470) | non | Rupture de stock prolongée ×44, Surstock ×5, Sans-abri nombreux ×2, Entreprise sans employé ×31, Entreprise sans client ×34, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×3, Prix aberrant ×7, Faim répandue ×1, Inégalités hors bornes ×1 |

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
| Fermeture de la ferme | 1 | non | 27,1 % | 0,0 % | 6,3 % | 380 ❌ | 45 | Rupture de stock prolongée ×6, Surstock ×2, Entreprise sans client ×9, Entreprise sans employé ×7, Inflation quotidienne ×3, Prix aberrant ×3 |
| Fermeture de la ferme | 2 | non | 18,3 % | 32,5 % | 2,1 % | 285 ❌ | 143 | Rupture de stock prolongée ×10, Surstock ×1, Entreprise sans employé ×5, Entreprise sans client ×6, Prix aberrant ×5, Faim répandue ×1 |
| Fermeture de la ferme | 3 | non | 23,8 % | 35,8 % | 5,4 % | 348 ❌ | 21 | Rupture de stock prolongée ×6, Surstock ×5, Entreprise sans client ×6, Entreprise sans employé ×6, Prix aberrant ×7, Faim répandue ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 23,8 % | 0,0 % | 6,7 % | 311 ❌ | 133 | Rupture de stock prolongée ×11, Surstock ×1, Entreprise sans client ×8, Entreprise sans employé ×4, Inflation quotidienne ×2, Prix aberrant ×2 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 17,5 % | 39,2 % | 20,8 % | 122 | 1 | Rupture de stock prolongée ×24, Surstock ×10, Entreprise sans employé ×21, Inflation quotidienne ×2, Entreprise sans client ×24, Prix aberrant ×6, Attente trop longue (service public) ×1, Sans-abri nombreux ×3, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Pénurie de main-d’œuvre ×1, Faim répandue ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 23,3 % | 44,6 % | 20,8 % | 162 | 1 | Rupture de stock prolongée ×20, Surstock ×7, Sans-abri nombreux ×2, Embauches bloquées faute de moyens ×1, Entreprise sans client ×24, Entreprise sans employé ×16, Inflation quotidienne ×2, Prix aberrant ×10, Attente trop longue (service public) ×1, Faim répandue ×2, Santé de la population effondrée ×1, Productivité du travail effondrée ×1 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 135 ouverture(s) critique(s) |
| Chômage moyen ≤ 10 % | ❌ | g4 10,5 % |
| Faim et sans-abri < 2 % | ❌ | g2, g3, g4, g5 |
| Gini 0,2–0,45 | ✅ | toutes les graines |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 13,39/50 j, Plancher de logement 9,94/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 12/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 11/15 échecs |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 9,2 % | 8,0 % |
| Faim moyenne | 6,7 % | 5,5 % |
| Sans-abri moyen | 3,3 % | 2,0 % |
| Gini moyen | 0,37 | 0,32 |
| Inflation moyenne / jour | 0,055 % | 0,058 % |
| Santé moyenne (sans filets) | 0,33 | 0,31 |
| Jours de prestations réduites (sans filets, toutes graines) | 0 | 0 |
| Trésor de l’État le plus bas (sans filets, $) | 66148 | 12931 |
| Caisse insolvable : jours (sans filets, toutes graines) | 1303 | 1277 |
| Fonds propres de la Caisse les plus bas (sans filets, $) | -4285 | -2177 |
| Prêts refusés (sans filets, toutes graines) | 235 | 212 |
| Créances radiées (sans filets, moyenne, $) | 16057 | 18668 |
| Hôpital public : attente moyenne (j, sans filets) | 336,92 | 409,71 |
| Alertes critiques (total) | 154 | 135 |
| Alertes (total) | 2596 | 2616 |
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
| Chocs revenus à l’équilibre en < 200 j (sans filets) | 0 | 3 |
| Chocs revenus à l’équilibre en < 200 j (avec filets) | 4 | 4 |

