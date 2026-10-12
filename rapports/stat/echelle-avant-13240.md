# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 21:18
- Graines : 1 à 10 (10) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : aucun
- Paramètres changés : population = 13240
- Temps total : 10 min 36 s pour 20 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 94,3 % | 0,2 pt (94,3 % – 94,5 %) | 94,2 % – 95,5 % | 10/10 |
| Chômage max | toute la partie | — | 98,4 % | 0,4 pt (98,1 % – 98,5 %) | 97,8 % – 99,4 % | — |
| Faim moyenne | après chauffe | < 2 % | 94,6 % | 0,3 pt (94,5 % – 94,8 %) | 93,9 % – 95,3 % | 10/10 |
| Faim max | toute la partie | — | 100,0 % | 0,01 pt (100,0 % – 100,0 %) | 99,9 % – 100,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 86,1 % | 0,7 pt (85,8 % – 86,5 %) | 85,1 % – 89,4 % | 10/10 |
| Sans-abri max | toute la partie | — | 99,2 % | 1,5 pt (98,3 % – 99,8 %) | 98,0 % – 100,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,95 | 0,01 (0,94 – 0,95) | 0,93 – 0,97 | 10/10 |
| Gini en fin de partie | dernier jour | — | 0,99 | 0,003 (0,99 – 0,99) | 0,98 – 0,99 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,245 % | 0,037 pt (0,237 % – 0,274 %) | 0,193 % – 0,427 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 22,2 % | 9,0 pt (16,8 % – 25,7 %) | 15,4 % – 39,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 345,6 % | 25,5 pt (343,6 % – 369,1 %) | 332,9 % – 499,6 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 11,5 | 3,5 (10,3 – 13,8) | 8 – 19 | 10/10 |
| … dont après la chauffe | après chauffe | — | 8,5 | 3,5 (7,3 – 10,8) | 5 – 16 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 6025,5 | 31,5 (6010,5 – 6042) | 5987 – 6059 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 496 | 47 (467,5 – 514,5) | 351 – 570 | — |
| Santé moyenne | après chauffe | — | 0,11 | 0,003 (0,11 – 0,12) | 0,11 – 0,12 | — |
| Naissances d’entreprises / an | toute la partie | — | 30,7 | 1,7 (29,2 – 30,9) | 20,7 – 32,9 | — |
| Morts d’entreprises / an | toute la partie | — | 30,3 | 0,9 (29,6 – 30,4) | 21,9 – 31,6 | — |
| Entonnoir : projets envisagés | toute la partie | — | 15396 | 928 (15120,3 – 16048,3) | 13974 – 16491 | — |
| Entonnoir : créations | toute la partie | — | 126 | 7 (120 – 127) | 85 – 135 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 639,5 | 77,3 (592 – 669,3) | 341 – 738 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 6646,5 | 537,3 (6284 – 6821,3) | 4588 – 7100 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 2265,5 | 244,3 (2107 – 2351,3) | 1883 – 2666 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 2390 | 266,3 (2222 – 2488,3) | 2136 – 2649 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 3664,5 | 293 (3556,5 – 3849,5) | 3516 – 4043 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 24 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 21 | 1,5 (20,3 – 21,8) | 19 – 23 | — |
| Machines en fin | dernier jour | — | 86,1 | 5,2 (82,8 – 87,9) | 74,5 – 90,5 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 13,5 | 2 (12 – 14) | 9 – 16 | — |
| Bonheur moyen | après chauffe | — | 0,09 | 0,003 (0,08 – 0,09) | 0,07 – 0,09 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 662,9 | 7,0 (657,3 – 664,4) | 653,9 – 669,7 | — |
| Jours de prestations réduites | après chauffe | — | 1390 | 1 (1389 – 1390) | 1387 – 1391 | — |
| Trésor de l’État le plus bas | après chauffe | — | 6 611 $ | 886 $ (6 314 $ – 7 201 $) | 1 418 $ – 10 480 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 7 409 $ | 5 123 $ (2 488 $ – 7 611 $) | 0 $ – 7 946 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 10/10 | 1 | 1 – 1 | 1 – 1 | 1431,5 j |
| Faim répandue | critique | 10/10 | 2 | 2 – 2 | 2 – 2 | 1380 j |
| Sans-abri nombreux | critique | 10/10 | 1 | 1 – 1 | 1 – 1 | 1372 j |
| Inégalités hors bornes | attention | 10/10 | 1 | 1 – 1 | 1 – 2 | 1432 j |
| Richesse médiane hors bornes | attention | 10/10 | 8 | 7,3 – 9 | 3 – 9 | 1254,5 j |
| Inflation quotidienne | critique | 10/10 | 5,5 | 4,3 – 7,8 | 2 – 12 | 6 j |
| Inflation sur 100 jours | critique | 10/10 | 1 | 1 – 1 | 1 – 2 | 553,5 j |
| Rupture de stock prolongée | attention | 10/10 | 99,5 | 83 – 105,8 | 56 – 112 | 6348 j |
| Surstock | attention | 10/10 | 35,5 | 29,3 – 39,3 | 23 – 53 | 5342 j |
| Entreprise sans employé | attention | 10/10 | 127 | 124,8 – 130 | 94 – 135 | 4390,5 j |
| Entreprise sans client | attention | 10/10 | 174,5 | 163,5 – 185,8 | 120 – 204 | 8888 j |
| Santé de la population effondrée | critique | 10/10 | 1 | 1 – 1 | 1 – 1 | 1283 j |
| Productivité du travail effondrée | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 1282,5 j |
| Embauches bloquées faute de moyens | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 1327 j |
| Prix aberrant | attention | 10/10 | 34 | 33 – 34,8 | 32 – 38 | 28851 j |
| Attente trop longue (service public) | attention | 10/10 | 2 | 2 – 2 | 2 – 2 | 2699 j |
| Prestations réduites faute de trésor | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 1390 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 94,4 % | 97,8 % | 95,0 % | 85,9 % | 0,97 | 0,279 % | 442 (11) | 0,11 | 7 % / 4 % / 89 % | 4 | 0 $ |
| 2 | 95,5 % | 99,4 % | 95,3 % | 89,4 % | 0,94 | 0,427 % | 475 (19) | 0,11 | 8 % / 19 % / 74 % | 5 | 0 $ |
| 3 | 94,9 % | 98,5 % | 94,8 % | 87,1 % | 0,96 | 0,241 % | 465 (10) | 0,11 | 18 % / 4 % / 78 % | 5 | 0 $ |
| 4 | 94,3 % | 98,2 % | 94,5 % | 86,4 % | 0,94 | 0,237 % | 570 (13) | 0,12 | 24 % / 5 % / 71 % | 7 | 0 $ |
| 5 | 94,2 % | 98,1 % | 94,6 % | 85,8 % | 0,94 | 0,231 % | 516 (12) | 0,11 | 20 % / 4 % / 76 % | 7 | 0 $ |
| 6 | 94,5 % | 98,0 % | 94,6 % | 86,5 % | 0,95 | 0,262 % | 510 (15) | 0,12 | 19 % / 2 % / 79 % | 6 | 0 $ |
| 7 | 94,3 % | 98,4 % | 93,9 % | 86,1 % | 0,93 | 0,193 % | 504 (14) | 0,11 | 18 % / 36 % / 46 % | 4 | 1 437 $ |
| 8 | 94,2 % | 98,5 % | 93,9 % | 86,0 % | 0,95 | 0,311 % | 351 (11) | 0,12 | 7 % / 5 % / 88 % | 5 | 0 $ |
| 9 | 94,3 % | 98,5 % | 94,8 % | 85,1 % | 0,95 | 0,249 % | 527 (8) | 0,12 | 25 % / 3 % / 71 % | 8 | 0 $ |
| 10 | 94,4 % | 98,5 % | 94,6 % | 85,5 % | 0,94 | 0,238 % | 488 (9) | 0,11 | 19 % / 5 % / 75 % | 6 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 86,7 % | 2,7 pt (84,7 % – 87,4 %) | 83,3 % – 88,1 % | 10/10 |
| Chômage max | toute la partie | — | 96,9 % | 0,4 pt (96,8 % – 97,2 %) | 96,6 % – 97,9 % | — |
| Faim moyenne | après chauffe | < 2 % | 58,4 % | 1,5 pt (57,6 % – 59,1 %) | 54,6 % – 60,1 % | 10/10 |
| Faim max | toute la partie | — | 69,0 % | 0,6 pt (68,8 % – 69,4 %) | 67,2 % – 70,4 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 55,3 % | 1,8 pt (54,3 % – 56,1 %) | 52,7 % – 56,3 % | 10/10 |
| Sans-abri max | toute la partie | — | 67,8 % | 1,0 pt (67,2 % – 68,2 %) | 66,8 % – 71,3 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,98 | 0,01 (0,97 – 0,98) | 0,97 – 0,98 | 10/10 |
| Gini en fin de partie | dernier jour | — | 1,00 | 0,01 (0,99 – 1,00) | 0,98 – 1,00 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,050 % | 0,041 pt (0,045 % – 0,086 %) | -0,057 % – 0,379 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 56,2 % | 26,4 pt (43,5 % – 69,9 %) | 22,9 % – 98,3 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 371,3 % | 30,0 pt (363,0 % – 393,0 %) | 334,8 % – 501,9 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 16,5 | 8,3 (15,3 – 23,5) | 12 – 27 | 10/10 |
| … dont après la chauffe | après chauffe | — | 13,5 | 8,3 (12,3 – 20,5) | 9 – 24 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 5943,5 | 20,3 (5936,3 – 5956,5) | 5902 – 5970 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 309 | 82,5 (248,5 – 331) | 195 – 465 | — |
| Santé moyenne | après chauffe | — | 0,12 | 0,004 (0,12 – 0,12) | 0,11 – 0,13 | — |
| Naissances d’entreprises / an | toute la partie | — | 7,3 | 2,4 (6,0 – 8,4) | 3,6 – 8,8 | — |
| Morts d’entreprises / an | toute la partie | — | 4,9 | 0,7 (4,4 – 5,1) | 3,6 – 5,8 | — |
| Entonnoir : projets envisagés | toute la partie | — | 10339,5 | 1701 (9166,3 – 10867,3) | 8218 – 11610 | — |
| Entonnoir : créations | toute la partie | — | 30 | 10 (24,5 – 34,5) | 15 – 36 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 139 | 80,5 (102 – 182,5) | 54 – 214 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 1615 | 451,3 (1280 – 1731,3) | 871 – 1875 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 4394 | 575 (3951,8 – 4526,8) | 3549 – 4815 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 2155 | 324,8 (1864,3 – 2189) | 1631 – 2678 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 2057 | 293,5 (1928,3 – 2221,8) | 1583 – 2672 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 24 | 1 (24 – 25) | 22 – 26 | — |
| Machines en fin | dernier jour | — | 173,8 | 35,8 (152,8 – 188,6) | 141,5 – 217,2 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 15 | 6,5 (10,5 – 17) | 8 – 19 | — |
| Bonheur moyen | après chauffe | — | 0,14 | 0,01 (0,13 – 0,14) | 0,12 – 0,18 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 652,6 | 7,8 (646,6 – 654,4) | 639,1 – 663,0 | — |
| Jours de prestations réduites | après chauffe | — | 1390 | 1,8 (1389 – 1390,8) | 1387 – 1392 | — |
| Trésor de l’État le plus bas | après chauffe | — | 204 $ | 196 $ (161 $ – 356 $) | 14 $ – 520 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 3 002 $ (0 $ – 3 002 $) | 0 $ – 9 280 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 187243,50 | 6883,03 (181802,74 – 188685,77) | 177447,54 – 189171,89 | 10/10 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 9,29 | 3,16 (7,25 – 10,41) | 4,39 – 17,89 | 10/10 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 138284,88 | 17604,02 (130205,03 – 147809,04) | 127470,57 – 159298,50 | 10/10 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 187243,50 | 181802,74 – 188685,77 | 177447,54 – 189171,89 | 10/10 | 51910144 | prix trop élevé (100 %) ; pas de producteur (0 %) |
| Renflouement d’entreprise | 9,29 | 7,25 – 10,41 | 4,39 – 17,89 | 10/10 | 3409 | par le propriétaire (98 %) ; après rachat (2 %) |
| Plancher de logement | 138284,88 | 130205,03 – 147809,04 | 127470,57 – 159298,50 | 10/10 | 39343533 | prix trop élevé (87 %) ; parc plein (13 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 10 graines · graines touchées) : Ingénierie pétrolière 442 · 10, Ingénierie de CPU 372 · 10, Ferme 234 · 10, Mine de cuivre 232 · 10, Immobilier 213 · 10, Mine d’or 197 · 10, Production télé 173 · 10, Pêcherie 171 · 9.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 87,4 % | 97,9 % | 60,1 % | 55,5 % | 0,97 | 0,045 % | 316 (12) | 0,13 | 13 % / 30 % / 57 % | 3 | 1 237 $ |
| 2 | 87,8 % | 96,6 % | 58,0 % | 56,1 % | 0,98 | 0,047 % | 465 (26) | 0,12 | 16 % / 34 % / 49 % | 3 | 6 973 $ |
| 3 | 87,1 % | 97,2 % | 59,2 % | 56,2 % | 0,98 | 0,045 % | 306 (22) | 0,12 | 16 % / 31 % / 53 % | 2 | 5 137 $ |
| 4 | 83,3 % | 96,9 % | 54,6 % | 52,7 % | 0,98 | 0,065 % | 336 (24) | 0,12 | 15 % / 27 % / 57 % | 2 | 4 583 $ |
| 5 | 87,4 % | 97,0 % | 59,9 % | 54,9 % | 0,97 | 0,053 % | 341 (17) | 0,11 | 13 % / 32 % / 55 % | 7 | 9 089 $ |
| 6 | 85,6 % | 96,9 % | 58,8 % | 55,2 % | 0,98 | 0,093 % | 232 (16) | 0,12 | 13 % / 37 % / 51 % | 2 | 15 787 $ |
| 7 | 88,1 % | 97,6 % | 57,5 % | 56,3 % | 0,97 | -0,057 % | 298 (27) | 0,12 | 16 % / 27 % / 57 % | 2 | 7 274 $ |
| 8 | 83,9 % | 96,7 % | 58,0 % | 54,1 % | 0,98 | 0,111 % | 195 (16) | 0,12 | 34 % / 17 % / 49 % | 2 | 20 521 $ |
| 9 | 84,4 % | 96,8 % | 55,2 % | 53,6 % | 0,97 | -0,045 % | 312 (15) | 0,12 | 15 % / 26 % / 59 % | 3 | 7 568 $ |
| 10 | 86,4 % | 96,8 % | 58,9 % | 56,1 % | 0,98 | 0,379 % | 198 (12) | 0,12 | 45 % / 9 % / 46 % | 2 | 4 177 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 10/10 : g1 11, g2 19, g3 10, g4 13, g5 12, g6 15, g7 14, g8 11, … |
| Chômage moyen ≤ 10 % | ❌ | 10/10 : g1 94,4 %, g2 95,5 %, g3 94,9 %, g4 94,3 %, g5 94,2 %, g6 94,5 %, g7 94,3 %, g8 94,2 %, … |
| Faim et sans-abri < 2 % | ❌ | 10/10 : g1, g2, g3, g4, g5, g6, g7, g8, g9, g10 |
| Gini 0,2–0,45 | ❌ | 10/10 : g1 0,97, g2 0,94, g3 0,96, g4 0,94, g5 0,94, g6 0,95, g7 0,93, g8 0,95, … |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 10 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 10 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 10/10 graines ; Renflouement d’entreprise : 10/10 graines ; Plancher de logement : 10/10 graines |

