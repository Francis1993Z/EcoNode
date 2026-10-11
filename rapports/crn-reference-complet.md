# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 12:48
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : aucun

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 10,9 % | 35,0 % | 5,6 % | 87,9 % | 1,1 % | 31,7 % | 0,33 | 0,46 | 0,090 % | 56,4 % | 201,0 % | 564 (32) | 0.0e+0 |
| 2 | 7,2 % | 26,7 % | 11,1 % | 95,4 % | 3,2 % | 42,9 % | 0,44 | 0,89 | 0,066 % | 32,6 % | 115,2 % | 516 (31) | 0.0e+0 |
| 3 | 7,9 % | 27,5 % | 7,3 % | 96,7 % | 1,6 % | 35,8 % | 0,35 | 0,19 | 0,052 % | 55,5 % | 156,9 % | 629 (26) | 0.0e+0 |
| 4 | 8,9 % | 28,7 % | 7,8 % | 96,3 % | 1,5 % | 80,0 % | 0,34 | 0,54 | 0,057 % | 27,7 % | 125,7 % | 618 (32) | 0.0e+0 |
| 5 | 16,3 % | 62,1 % | 11,3 % | 95,4 % | 6,7 % | 58,3 % | 0,40 | 0,78 | 0,062 % | 29,9 % | 141,1 % | 572 (24) | 0.0e+0 |

Santé moyenne de la population : g1 0,24, g2 0,15, g3 0,14, g4 0,17, g5 0,20.

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 1 · 66 j | · | · | · | 1 · 222 j |
| Faim répandue | critique | 9 · 123 j | 9 · 227 j | 6 · 159 j | 7 · 169 j | 8 · 376 j |
| Sans-abri nombreux | critique | 12 · 65 j | 11 · 151 j | 10 · 81 j | 11 · 115 j | 9 · 327 j |
| Inégalités hors bornes | attention | 2 · 30 j | 5 · 346 j | 3 · 202 j | 4 · 90 j | 3 · 331 j |
| Richesse médiane hors bornes | attention | · | 1 · 9 j | 2 · 2 j | · | 2 · 62 j |
| Inflation quotidienne | critique | 7 · 7 j | 9 · 9 j | 7 · 7 j | 12 · 12 j | 4 · 4 j |
| Inflation sur 100 jours | critique | 2 · 54 j | 1 · 14 j | 2 · 115 j | 1 · 23 j | 1 · 20 j |
| Rupture de stock prolongée | attention | 158 · 5374 j | 130 · 4871 j | 163 · 6411 j | 167 · 5832 j | 141 · 5555 j |
| Surstock | attention | 45 · 1520 j | 33 · 1228 j | 47 · 1748 j | 43 · 1063 j | 38 · 1292 j |
| Entreprise sans employé | attention | 135 · 1848 j | 137 · 1835 j | 160 · 2218 j | 164 · 2211 j | 156 · 2511 j |
| Entreprise sans client | attention | 159 · 4990 j | 145 · 5691 j | 195 · 6353 j | 181 · 5668 j | 177 · 5687 j |
| Santé de la population effondrée | critique | 1 · 1061 j | 1 · 1222 j | 1 · 1230 j | 1 · 1189 j | 1 · 1168 j |
| Productivité du travail effondrée | attention | 1 · 1060 j | 1 · 1241 j | 1 · 1229 j | 1 · 1186 j | 1 · 1169 j |
| Pénurie de main-d’œuvre | attention | · | · | · | 1 · 14 j | · |
| Embauches bloquées faute de moyens | attention | 8 · 301 j | 9 · 203 j | 6 · 311 j | 8 · 510 j | 8 · 552 j |
| Prix aberrant | attention | 23 · 3009 j | 23 · 1499 j | 25 · 3923 j | 16 · 2439 j | 19 · 1901 j |
| Attente trop longue (service public) | attention | 1 · 1289 j | 1 · 1307 j | 1 · 1380 j | 1 · 1284 j | 2 · 1462 j |
| Prestations réduites faute de trésor | attention | · | · | · | · | 1 · 219 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 9,6 % | 25,7 % | 64,7 % | 4 | 0 $ | 95 579 $ | 15 629 $ |
| 2 | 5,0 % | 30,7 % | 64,4 % | 4 | 9 770 $ | 200 216 $ | 25 367 $ |
| 3 | 9,4 % | 20,5 % | 70,1 % | 1 | 239 $ | 131 810 $ | 15 162 $ |
| 4 | 10,2 % | 23,8 % | 66,0 % | 6 | 1 088 $ | 141 127 $ | 18 346 $ |
| 5 | 15,2 % | 27,2 % | 57,6 % | 3 | 17 106 $ | 169 463 $ | 18 395 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,4 % | 26,7 % | 0,1 % | 65,0 % | 0,2 % | 17,5 % | 0,36 | 0,39 | 0,032 % | 48,2 % | 129,6 % | 154 (13) | 0.0e+0 |
| 2 | 7,9 % | 24,2 % | 0,1 % | 59,6 % | 0,0 % | 10,4 % | 0,20 | 0,23 | 0,001 % | 36,6 % | 138,3 % | 125 (7) | 0.0e+0 |
| 3 | 7,4 % | 17,1 % | 0,1 % | 47,1 % | 0,2 % | 4,2 % | 0,21 | 0,20 | 0,024 % | 28,6 % | 154,4 % | 131 (7) | 0.0e+0 |
| 4 | 10,5 % | 29,6 % | 0,6 % | 79,2 % | 1,4 % | 64,6 % | 0,22 | 0,26 | 0,058 % | 47,5 % | 124,2 % | 269 (20) | 0.0e+0 |
| 5 | 7,7 % | 22,1 % | 0,0 % | 0,0 % | 0,0 % | 39,2 % | 0,17 | 0,14 | 0,102 % | 90,4 % | 228,1 % | 118 (7) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 34 · 1,21 | 26 · 0,93 | 4 · 0,14 | 250 · 8,86 | 0 · 0,00 | 2,23 ❌ | pas de producteur (100 %) |
| Renflouement d’entreprise | 340 · 10,61 | 264 · 7,96 | 293 · 9,18 | 530 · 17,14 | 655 · 21,79 | 13,34 ❌ | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 30 · 1,07 | 0 · 0,00 | 201 · 7,18 | 1790 · 39,89 | 93 · 0,00 | 9,63 ❌ | parc plein (57 %) ; prix trop élevé (43 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

Renflouements en régime, par type d’entreprise (toutes graines) : Ferme 688, Bijouterie 365, Mine de fer 156, Tourisme 131, Fonderie 117, Pêcherie 85, Mine de bauxite 38, Mine de cuivre 36.

Santé moyenne de la population : g1 0,88, g2 0,88, g3 0,88, g4 0,71, g5 0,88.

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 32,9 % | 72,9 % | 95,8 % | non (> 470) | 220 | Rupture de stock prolongée ×43, Surstock ×5, Entreprise sans client ×36, Entreprise sans employé ×31, Embauches bloquées faute de moyens ×2, Prix aberrant ×12, Faim répandue ×4, Sans-abri nombreux ×2, Pénurie de main-d’œuvre ×2, Productivité du travail effondrée ×1, Santé de la population effondrée ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 46,7 % | 97,1 % | 84,6 % | non (> 470) | non | Rupture de stock prolongée ×48, Surstock ×4, Entreprise sans employé ×67, Entreprise sans client ×72, Embauches bloquées faute de moyens ×1, Prix aberrant ×8, Attente trop longue (service public) ×1, Faim répandue ×3, Sans-abri nombreux ×4, Pénurie de main-d’œuvre ×1, Prestations réduites faute de trésor ×2, Chômage très élevé ×2, Inégalités hors bornes ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 97,1 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×54, Surstock ×4, Entreprise sans employé ×84, Entreprise sans client ×88, Attente trop longue (service public) ×1, Prix aberrant ×4, Inflation quotidienne ×2, Faim répandue ×1, Sans-abri nombreux ×1, Pénurie de main-d’œuvre ×1, Embauches bloquées faute de moyens ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1, Richesse médiane hors bornes ×4 |
| +25 immigrants | 1 | non | 39,6 % | 78,5 % | 22,6 % | non (> 470) | non | Rupture de stock prolongée ×53, Surstock ×27, Entreprise sans client ×64, Entreprise sans employé ×62, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×1, Prix aberrant ×6, Faim répandue ×1, Sans-abri nombreux ×6, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Caisse insolvable ×1, Inégalités hors bornes ×1 |
| +25 immigrants | 2 | non | 37,7 % | 79,6 % | 25,3 % | non (> 470) | non | Rupture de stock prolongée ×73, Surstock ×34, Entreprise sans employé ×85, Entreprise sans client ×95, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×2, Prix aberrant ×10, Faim répandue ×1, Sans-abri nombreux ×11, Inégalités hors bornes ×1 |
| +25 immigrants | 3 | non | 27,9 % | 94,7 % | 55,8 % | non (> 470) | non | Rupture de stock prolongée ×76, Surstock ×12, Entreprise sans employé ×73, Entreprise sans client ×82, Prix aberrant ×13, Inflation quotidienne ×3, Faim répandue ×2, Sans-abri nombreux ×8, Embauches bloquées faute de moyens ×3, Inégalités hors bornes ×2, Richesse médiane hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | non | 41,3 % | 92,9 % | 36,3 % | non (> 470) | 1 | Rupture de stock prolongée ×36, Surstock ×8, Entreprise sans client ×33, Entreprise sans employé ×27, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×3, Prix aberrant ×4, Faim répandue ×3, Sans-abri nombreux ×6, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Inégalités hors bornes ×2 |
| Salaire minimum 220 $/j | 2 | non | 26,3 % | 0,0 % | 14,6 % | non (> 470) | 23 | Rupture de stock prolongée ×16, Surstock ×4, Entreprise sans employé ×17, Entreprise sans client ×13, Prix aberrant ×5, Sans-abri nombreux ×18 |
| Salaire minimum 220 $/j | 3 | non | 14,2 % | 0,0 % | 3,3 % | non (> 470) | 209 | Rupture de stock prolongée ×25, Entreprise sans employé ×18, Entreprise sans client ×20, Prix aberrant ×5, Inflation quotidienne ×3 |
| Fermeture de la ferme | 1 | non | 37,1 % | 91,7 % | 27,1 % | non (> 470) | non | Rupture de stock prolongée ×52, Surstock ×14, Entreprise sans client ×58, Entreprise sans employé ×51, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×3, Prix aberrant ×7, Faim répandue ×2, Sans-abri nombreux ×11, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Inégalités hors bornes ×1 |
| Fermeture de la ferme | 2 | non | 98,3 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×29, Surstock ×3, Entreprise sans employé ×54, Entreprise sans client ×57, Embauches bloquées faute de moyens ×1, Prix aberrant ×5, Attente trop longue (service public) ×1, Faim répandue ×1, Sans-abri nombreux ×4, Prestations réduites faute de trésor ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 3 | non | 97,9 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×64, Surstock ×2, Entreprise sans employé ×98, Entreprise sans client ×107, Attente trop longue (service public) ×1, Prix aberrant ×4, Inflation quotidienne ×2, Faim répandue ×1, Sans-abri nombreux ×2, Embauches bloquées faute de moyens ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 33,3 % | 90,0 % | 29,2 % | non (> 470) | 1 | Rupture de stock prolongée ×62, Surstock ×12, Entreprise sans client ×64, Entreprise sans employé ×52, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×1, Prix aberrant ×8, Faim répandue ×3, Sans-abri nombreux ×5, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Inégalités hors bornes ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 21,3 % | 94,2 % | 35,4 % | non (> 470) | 1 | Rupture de stock prolongée ×52, Surstock ×13, Entreprise sans employé ×67, Entreprise sans client ×65, Embauches bloquées faute de moyens ×2, Inflation quotidienne ×1, Prix aberrant ×4, Faim répandue ×2, Sans-abri nombreux ×5, Pénurie de main-d’œuvre ×1, Inégalités hors bornes ×1 |
| Faillite d’une firme clé | 3 | non | 27,5 % | 96,7 % | 35,8 % | non (> 470) | 196 | Rupture de stock prolongée ×56, Surstock ×8, Entreprise sans employé ×44, Entreprise sans client ×59, Prix aberrant ×10, Inflation quotidienne ×5, Faim répandue ×2, Embauches bloquées faute de moyens ×2, Sans-abri nombreux ×5, Inégalités hors bornes ×1, Richesse médiane hors bornes ×2 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 22,1 % | 66,7 % | 66,7 % | 77 | non | Rupture de stock prolongée ×25, Surstock ×7, Entreprise sans client ×22, Entreprise sans employé ×18, Inflation quotidienne ×19, Prix aberrant ×3, Sans-abri nombreux ×2, Faim répandue ×1, Pénurie de main-d’œuvre ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 22,5 % | 77,1 % | 59,2 % | non (> 470) | 461 | Rupture de stock prolongée ×37, Surstock ×11, Entreprise sans employé ×22, Embauches bloquées faute de moyens ×1, Entreprise sans client ×37, Inflation quotidienne ×3, Prix aberrant ×11, Sans-abri nombreux ×2, Pénurie de main-d’œuvre ×1, Faim répandue ×2, Productivité du travail effondrée ×2, Attente trop longue (service public) ×1, Santé de la population effondrée ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 13,3 % | 69,6 % | 68,8 % | 163 | non | Rupture de stock prolongée ×30, Surstock ×8, Entreprise sans employé ×21, Entreprise sans client ×25, Inflation quotidienne ×6, Prix aberrant ×2, Sans-abri nombreux ×2, Faim répandue ×3, Pénurie de main-d’œuvre ×2, Attente trop longue (service public) ×2, Embauches bloquées faute de moyens ×1 |
| +25 immigrants | 1 | non | 34,0 % | 0,0 % | 15,5 % | non (> 470) | non | Rupture de stock prolongée ×11, Surstock ×10, Entreprise sans client ×15, Entreprise sans employé ×8, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×2, Prix aberrant ×8, Chômage très élevé ×1, Attente trop longue (service public) ×2, Inégalités hors bornes ×2, Sans-abri nombreux ×1 |
| +25 immigrants | 2 | non | 26,8 % | 0,0 % | 9,4 % | non (> 470) | non | Rupture de stock prolongée ×12, Surstock ×6, Entreprise sans employé ×6, Entreprise sans client ×11, Inflation quotidienne ×4, Prix aberrant ×6 |
| +25 immigrants | 3 | non | 24,5 % | 0,0 % | 7,5 % | non (> 470) | non | Rupture de stock prolongée ×15, Surstock ×2, Entreprise sans employé ×6, Entreprise sans client ×6, Inflation quotidienne ×3, Prix aberrant ×4 |
| Salaire minimum 220 $/j | 1 | non | 35,0 % | 76,7 % | 17,9 % | non (> 470) | non | Rupture de stock prolongée ×11, Surstock ×13, Entreprise sans client ×15, Entreprise sans employé ×8, Embauches bloquées faute de moyens ×3, Inflation quotidienne ×3, Prix aberrant ×2, Faim répandue ×1, Chômage très élevé ×4, Sans-abri nombreux ×3 |
| Salaire minimum 220 $/j | 2 | non | 28,7 % | 0,0 % | 8,3 % | non (> 470) | 169 | Rupture de stock prolongée ×6, Surstock ×8, Entreprise sans employé ×12, Entreprise sans client ×21, Inflation quotidienne ×1, Prix aberrant ×5, Attente trop longue (service public) ×1, Santé de la population effondrée ×1, Productivité du travail effondrée ×1, Sans-abri nombreux ×2 |
| Salaire minimum 220 $/j | 3 | non | 26,7 % | 0,0 % | 7,5 % | non (> 470) | non | Rupture de stock prolongée ×4, Surstock ×4, Entreprise sans employé ×7, Entreprise sans client ×8, Prix aberrant ×6, Sans-abri nombreux ×2 |
| Fermeture de la ferme | 1 | non | 29,2 % | 46,3 % | 7,9 % | non (> 470) | 155 | Rupture de stock prolongée ×10, Surstock ×7, Entreprise sans client ×7, Entreprise sans employé ×6, Inflation quotidienne ×1, Prix aberrant ×5, Faim répandue ×1, Sans-abri nombreux ×1 |
| Fermeture de la ferme | 2 | non | 23,3 % | 33,8 % | 0,0 % | 250 ❌ | 58 | Rupture de stock prolongée ×12, Surstock ×4, Entreprise sans employé ×6, Entreprise sans client ×9, Inflation quotidienne ×2, Prix aberrant ×1, Faim répandue ×1 |
| Fermeture de la ferme | 3 | non | 15,0 % | 0,0 % | 2,9 % | 98 | non | Rupture de stock prolongée ×8, Surstock ×2, Entreprise sans employé ×8, Entreprise sans client ×10, Inflation quotidienne ×2, Prix aberrant ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 23,3 % | 0,0 % | 0,0 % | 338 ❌ | 1 | Rupture de stock prolongée ×10, Surstock ×5, Entreprise sans client ×14, Entreprise sans employé ×7, Inflation quotidienne ×4, Prix aberrant ×2 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 19,6 % | 0,0 % | 0,0 % | 167 | 1 | Rupture de stock prolongée ×6, Surstock ×2, Entreprise sans employé ×6, Entreprise sans client ×8, Prix aberrant ×2 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 15,4 % | 0,0 % | 2,9 % | 12 | non | Rupture de stock prolongée ×10, Surstock ×5, Entreprise sans employé ×9, Entreprise sans client ×13, Inflation quotidienne ×1, Prix aberrant ×3 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 145 ouverture(s) critique(s) |
| Chômage moyen ≤ 10 % | ❌ | g1 10,9 %, g5 16,3 % |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ✅ | toutes les graines |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Anti-famine 2,23/50 j, Renflouement d’entreprise 13,34/50 j, Plancher de logement 9,63/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 15/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 10/15 échecs |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 8,0 % | 10,2 % |
| Faim moyenne | 5,5 % | 8,6 % |
| Sans-abri moyen | 2,0 % | 2,8 % |
| Gini moyen | 0,32 | 0,37 |
| Inflation moyenne / jour | 0,058 % | 0,065 % |
| Santé moyenne (sans filets) | 0,31 | 0,18 |
| Jours de prestations réduites (sans filets, toutes graines) | 0 | 219 |
| Trésor de l’État le plus bas (sans filets, $) | 12931 | 2931 |
| Caisse insolvable : jours (sans filets, toutes graines) | 1277 | 0 |
| Fonds propres de la Caisse les plus bas (sans filets, $) | -2177 | 2186 |
| Prêts refusés (sans filets, toutes graines) | 212 | 8 |
| Créances radiées (sans filets, moyenne, $) | 18668 | 18580 |
| Hôpital public : attente moyenne (j, sans filets) | 409,71 | 496,06 |
| Alertes critiques (total) | 135 | 145 |
| Alertes (total) | 2616 | 2899 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,14 | 2,23 |
| Renflouements / 50 j | 13,39 | 13,34 |
| Plancher de logement / 50 j | 9,94 | 9,63 |
| Plafond de dérive / 50 j | 0,00 | 0,00 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |
| Avec filets : chômage moyen | 8,0 % | 9,0 % |
| Avec filets : faim moyenne | 0,0 % | 0,2 % |
| Avec filets : sans-abri moyen | 0,3 % | 0,4 % |
| Avec filets : Gini moyen | 0,22 | 0,23 |
| Avec filets : santé moyenne | 0,87 | 0,85 |
| Avec filets : jours de prestations réduites | 0 | 0 |
| Renflouements de l’hôpital / 50 j | 0,00 | 0,00 |
| Chocs revenus à l’équilibre en < 200 j (sans filets) | 3 | 0 |
| Chocs revenus à l’équilibre en < 200 j (avec filets) | 4 | 5 |

