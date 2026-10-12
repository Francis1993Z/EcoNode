# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 21:37
- Graines : 1 à 10 (10) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : aucun
- Paramètres changés : population = 3000
- Temps total : 11 min 41 s pour 20 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 33,7 % | 5,7 pt (30,8 % – 36,4 %) | 26,6 % – 38,0 % | 10/10 |
| Chômage max | toute la partie | — | 57,7 % | 5,8 pt (53,8 % – 59,6 %) | 46,0 % – 66,1 % | — |
| Faim moyenne | après chauffe | < 2 % | 3,4 % | 3,8 pt (0,8 % – 4,6 %) | 0,1 % – 6,2 % | 7/10 |
| Faim max | toute la partie | — | 37,3 % | 32,0 pt (22,7 % – 54,7 %) | 16,9 % – 78,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 16,4 % | 9,2 pt (12,3 % – 21,6 %) | 9,6 % – 23,5 % | 10/10 |
| Sans-abri max | toute la partie | — | 60,2 % | 7,2 pt (56,7 % – 63,9 %) | 52,3 % – 69,9 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,82 | 0,04 (0,79 – 0,83) | 0,76 – 0,86 | 10/10 |
| Gini en fin de partie | dernier jour | — | 0,90 | 0,12 (0,84 – 0,96) | 0,69 – 1,00 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,023 % | 0,065 pt (-0,064 % – 0,001 %) | -0,082 % – 0,017 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 43,2 % | 35,6 pt (24,3 % – 59,9 %) | 14,8 % – 172,7 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 121,6 % | 54,2 pt (100,7 % – 154,9 %) | 96,5 % – 415,2 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 53 | 14,8 (46,3 – 61) | 34 – 68 | 10/10 |
| … dont après la chauffe | après chauffe | — | 51 | 16 (43 – 59) | 32 – 66 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 2592,5 | 705,5 (2345,5 – 3051) | 1970 – 3379 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 2224 | 87,3 (2176,8 – 2264) | 2136 – 2373 | — |
| Santé moyenne | après chauffe | — | 0,47 | 0,13 (0,37 – 0,49) | 0,24 – 0,57 | — |
| Naissances d’entreprises / an | toute la partie | — | 16,1 | 3,9 (14,7 – 18,6) | 10,5 – 22,6 | — |
| Morts d’entreprises / an | toute la partie | — | 94,9 | 4,5 (92,6 – 97,1) | 88,3 – 100,0 | — |
| Entonnoir : projets envisagés | toute la partie | — | 13255 | 1984,8 (12168,5 – 14153,3) | 10551 – 14896 | — |
| Entonnoir : créations | toute la partie | — | 66 | 16 (60,5 – 76,5) | 43 – 93 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 475,5 | 155,8 (396,8 – 552,5) | 236 – 723 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 2963 | 851,5 (2797 – 3648,5) | 2017 – 4373 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 6349,5 | 521 (6135 – 6656) | 5193 – 7136 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 1720 | 323,5 (1455 – 1778,5) | 1230 – 2048 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 1215 | 607,3 (850,3 – 1457,5) | 587 – 2420 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 27 | 7,8 (22,3 – 30) | 20 – 30 | — |
| Machines en fin | dernier jour | — | 134,5 | 1513,0 (44,9 – 1557,9) | 12,2 – 1712,0 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 21 | 9,5 (13,3 – 22,8) | 9 – 34 | — |
| Bonheur moyen | après chauffe | — | 0,75 | 0,11 (0,68 – 0,78) | 0,64 – 0,81 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 213,8 | 156,5 (188,4 – 344,9) | 122,6 – 469,2 | — |
| Jours de prestations réduites | après chauffe | — | 638 | 223,5 (560 – 783,5) | 532 – 1026 | — |
| Trésor de l’État le plus bas | après chauffe | — | 32 847 $ | 11 867 $ (27 423 $ – 39 290 $) | 21 380 $ – 45 362 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 20,5 | 521,3 (0 – 521,3) | 0 – 1269 | — |
| Prêts refusés | toute la partie | — | 39 | 135 (2 – 137) | 0 – 561 | — |
| Créances radiées | toute la partie | — | 309 606 $ | 17 528 $ (294 693 $ – 312 221 $) | 247 840 $ – 318 222 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 10/10 | 3 | 2,3 – 3 | 1 – 4 | 732 j |
| Faim répandue | critique | 10/10 | 5,5 | 1,5 – 8 | 1 – 9 | 267,5 j |
| Sans-abri nombreux | critique | 10/10 | 6,5 | 5 – 8,8 | 3 – 16 | 943 j |
| Inégalités hors bornes | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 1233 j |
| Richesse médiane hors bornes | attention | 10/10 | 2 | 1,3 – 3 | 1 – 4 | 400 j |
| Inflation quotidienne | critique | 10/10 | 33,5 | 27,5 – 40,8 | 21 – 54 | 46 j |
| Inflation sur 100 jours | critique | 7/10 | 2 | 0,3 – 2,8 | 0 – 5 | 11 j |
| Rupture de stock prolongée | attention | 10/10 | 362,5 | 336,5 – 370,8 | 312 – 384 | 9116,5 j |
| Surstock | attention | 10/10 | 352 | 342,8 – 359,8 | 336 – 366 | 17864 j |
| Entreprise sans employé | attention | 10/10 | 523 | 509 – 530,3 | 478 – 581 | 23602,5 j |
| Entreprise sans client | attention | 10/10 | 821 | 802,3 – 841,8 | 765 – 927 | 54887 j |
| Caisse insolvable | attention | 5/10 | 0,5 | 0 – 1 | 0 – 1 | 20,5 j |
| Santé de la population effondrée | critique | 10/10 | 1 | 1 – 1 | 1 – 3 | 688,5 j |
| Productivité du travail effondrée | attention | 10/10 | 1 | 1 – 1 | 1 – 3 | 690 j |
| Pénurie de main-d’œuvre | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 19 j |
| Embauches bloquées faute de moyens | attention | 10/10 | 4 | 3 – 4 | 1 – 4 | 768,5 j |
| Prix aberrant | attention | 10/10 | 105 | 95 – 109,8 | 79 – 133 | 21148,5 j |
| Attente trop longue (service public) | attention | 10/10 | 4 | 3,3 – 4 | 2 – 5 | 1478 j |
| Prestations réduites faute de trésor | attention | 10/10 | 4,5 | 3 – 5 | 1 – 6 | 638 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 36,7 % | 58,6 % | 4,9 % | 22,2 % | 0,86 | 0,001 % | 2143 (46) | 0,24 | 15 % / 35 % / 51 % | 28 | 0 $ |
| 2 | 36,8 % | 62,1 % | 4,8 % | 15,8 % | 0,82 | -0,007 % | 2217 (47) | 0,48 | 12 % / 31 % / 57 % | 28 | 82 930 $ |
| 3 | 30,6 % | 56,9 % | 4,2 % | 19,6 % | 0,80 | -0,063 % | 2258 (58) | 0,47 | 4 % / 21 % / 76 % | 2 | 3 742 $ |
| 4 | 28,2 % | 46,0 % | 0,1 % | 10,2 % | 0,79 | -0,082 % | 2348 (56) | 0,51 | 4 % / 15 % / 82 % | 1 | 0 $ |
| 5 | 35,5 % | 59,9 % | 3,5 % | 17,0 % | 0,82 | 0,001 % | 2176 (62) | 0,57 | 15 % / 33 % / 52 % | 28 | 0 $ |
| 6 | 38,0 % | 66,1 % | 6,2 % | 23,5 % | 0,85 | 0,001 % | 2266 (44) | 0,33 | 10 % / 34 % / 55 % | 3 | 0 $ |
| 7 | 35,6 % | 58,5 % | 3,0 % | 22,9 % | 0,84 | 0,017 % | 2231 (50) | 0,24 | 13 % / 38 % / 49 % | 27 | 0 $ |
| 8 | 31,9 % | 55,8 % | 3,4 % | 9,6 % | 0,76 | -0,038 % | 2179 (68) | 0,50 | 6 % / 20 % / 74 % | 1 | 4 265 $ |
| 9 | 26,6 % | 49,5 % | 0,1 % | 14,9 % | 0,79 | -0,064 % | 2373 (65) | 0,47 | 4 % / 16 % / 80 % | 11 | 0 $ |
| 10 | 31,3 % | 53,1 % | 0,1 % | 11,5 % | 0,82 | -0,073 % | 2136 (34) | 0,47 | 5 % / 17 % / 77 % | 0 | 772 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 30,1 % | 17,7 pt (16,8 % – 34,5 %) | 9,4 % – 41,2 % | 9/10 |
| Chômage max | toute la partie | — | 46,0 % | 23,8 pt (34,4 % – 58,2 %) | 31,4 % – 65,1 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 3,7 pt (0,0 % – 3,7 %) | 0,0 % – 11,5 % | 3/10 |
| Faim max | toute la partie | — | 18,5 % | 24,6 pt (16,2 % – 40,8 %) | 12,9 % – 45,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 8,0 % | 12,2 pt (2,2 % – 14,4 %) | 0,4 % – 21,4 % | 7/10 |
| Sans-abri max | toute la partie | — | 48,8 % | 5,1 pt (46,3 % – 51,4 %) | 44,8 % – 58,4 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,75 | 0,22 (0,55 – 0,77) | 0,38 – 0,79 | 8/10 |
| Gini en fin de partie | dernier jour | — | 0,79 | 0,45 (0,36 – 0,81) | 0,10 – 0,94 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,006 % | 0,081 pt (-0,020 % – 0,062 %) | -0,051 % – 0,076 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 22,3 % | 6,1 pt (21,0 % – 27,1 %) | 16,5 % – 53,5 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 108,2 % | 7,2 pt (104,7 % – 111,9 %) | 102,8 % – 207,5 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 52 | 16,5 (42,3 – 58,8) | 28 – 81 | 10/10 |
| … dont après la chauffe | après chauffe | — | 49 | 16,5 (39,5 – 56) | 25 – 79 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 2314 | 2217,3 (552 – 2769,3) | 152 – 3714 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 1930,5 | 95,8 (1894,5 – 1990,3) | 1734 – 2093 | — |
| Santé moyenne | après chauffe | — | 0,38 | 0,51 (0,27 – 0,78) | 0,23 – 0,88 | — |
| Naissances d’entreprises / an | toute la partie | — | 4,6 | 2,4 (3,2 – 5,6) | 1,2 – 7,3 | — |
| Morts d’entreprises / an | toute la partie | — | 82,5 | 2,1 (81,2 – 83,2) | 78,8 – 83,7 | — |
| Entonnoir : projets envisagés | toute la partie | — | 9546,5 | 1114,8 (8778,8 – 9893,5) | 8013 – 11710 | — |
| Entonnoir : créations | toute la partie | — | 19 | 9,8 (13,3 – 23) | 5 – 30 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 96 | 69,8 (62,3 – 132) | 26 – 149 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 853 | 505,8 (632,3 – 1138) | 239 – 1350 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 6068 | 744,3 (5843,3 – 6587,5) | 5442 – 7174 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 1227 | 248,5 (1128,5 – 1377) | 637 – 1784 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 3 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 1244 | 1143,8 (374 – 1517,8) | 39 – 2138 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 52 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 26 | 6,3 (21,5 – 27,8) | 20 – 29 | — |
| Machines en fin | dernier jour | — | 40,4 | 1281,1 (15,3 – 1296,4) | 12,6 – 2947,4 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 11,5 | 5,5 (9,3 – 14,8) | 8 – 24 | — |
| Bonheur moyen | après chauffe | — | 0,75 | 0,20 (0,72 – 0,92) | 0,62 – 0,97 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 325,3 | 390,6 (46,3 – 436,9) | 0,4 – 484,2 | — |
| Jours de prestations réduites | après chauffe | — | 676,5 | 677,8 (128,3 – 806) | 0 – 1057 | — |
| Trésor de l’État le plus bas | après chauffe | — | 30 185 $ | 79 577 $ (10 234 $ – 89 811 $) | 6 954 $ – 170 735 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 242 781 $ | 58 482 $ (206 087 $ – 264 570 $) | 188 433 $ – 283 759 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,09 | 1903,80 (0,00 – 1903,80) | 0,00 – 5934,82 | 4/10 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 60,14 | 18,11 (50,85 – 68,96) | 42,25 – 81,93 | 10/10 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 2978,68 | 6296,44 (147,64 – 6444,08) | 33,11 – 11323,29 | 10/10 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,09 | 0,00 – 1903,80 | 0,00 – 5934,82 | 4/10 | 335686 | prix trop élevé (100 %) ; pas de producteur (0 %) |
| Renflouement d’entreprise | 60,14 | 50,85 – 68,96 | 42,25 – 81,93 | 10/10 | 24538 | par le propriétaire (89 %) ; après rachat (11 %) |
| Plancher de logement | 2978,68 | 147,64 – 6444,08 | 33,11 – 11323,29 | 10/10 | 1124974 | prix trop élevé (82 %) ; parc plein (18 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 10 graines · graines touchées) : Tourisme 3704 · 9, Ingénierie pétrolière 2418 · 10, Hôtel 2344 · 10, Ferme 1301 · 10, Garage 987 · 10, Boulangerie 561 · 10, Pétrochimie 561 · 10, Pêcherie 547 · 10.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 36,6 % | 58,2 % | 4,5 % | 19,0 % | 0,79 | 0,002 % | 1976 (36) | 0,28 | 15 % / 33 % / 53 % | 28 | 19 895 $ |
| 2 | 11,9 % | 33,8 % | 0,0 % | 0,6 % | 0,49 | -0,018 % | 2070 (59) | 0,85 | 4 % / 9 % / 87 % | 10 | 50 163 $ |
| 3 | 35,0 % | 63,5 % | 6,5 % | 15,2 % | 0,78 | -0,026 % | 1891 (58) | 0,47 | 6 % / 22 % / 73 % | 0 | 10 712 $ |
| 4 | 41,2 % | 65,1 % | 11,5 % | 21,4 % | 0,77 | 0,075 % | 1905 (46) | 0,29 | 15 % / 24 % / 61 % | 27 | 19 635 $ |
| 5 | 13,0 % | 33,1 % | 0,0 % | 0,7 % | 0,38 | -0,020 % | 1939 (57) | 0,88 | 5 % / 10 % / 85 % | 11 | 9 369 $ |
| 6 | 31,0 % | 48,8 % | 0,0 % | 8,6 % | 0,76 | 0,076 % | 1734 (28) | 0,23 | 12 % / 21 % / 67 % | 0 | 10 409 $ |
| 7 | 9,4 % | 31,4 % | 0,0 % | 0,4 % | 0,43 | 0,010 % | 1995 (47) | 0,88 | 4 % / 9 % / 86 % | 8 | 9 243 $ |
| 8 | 29,1 % | 43,3 % | 0,0 % | 7,3 % | 0,76 | -0,051 % | 2093 (74) | 0,55 | 5 % / 16 % / 79 % | 1 | 11 600 $ |
| 9 | 33,1 % | 58,0 % | 1,2 % | 12,0 % | 0,73 | 0,068 % | 1922 (41) | 0,26 | 9 % / 16 % / 75 % | 27 | 1 916 $ |
| 10 | 28,3 % | 36,2 % | 0,0 % | 6,9 % | 0,74 | 0,042 % | 1888 (81) | 0,25 | 13 % / 23 % / 64 % | 26 | 9 979 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 10/10 : g1 46, g2 47, g3 58, g4 56, g5 62, g6 44, g7 50, g8 68, … |
| Chômage moyen ≤ 10 % | ❌ | 10/10 : g1 36,7 %, g2 36,8 %, g3 30,6 %, g4 28,2 %, g5 35,5 %, g6 38,0 %, g7 35,6 %, g8 31,9 %, … |
| Faim et sans-abri < 2 % | ❌ | 10/10 : g1, g2, g3, g4, g5, g6, g7, g8, g9, g10 |
| Gini 0,2–0,45 | ❌ | 10/10 : g1 0,86, g2 0,82, g3 0,80, g4 0,79, g5 0,82, g6 0,85, g7 0,84, g8 0,76, … |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 10 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 10 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 4/10 graines ; Renflouement d’entreprise : 10/10 graines ; Plancher de logement : 10/10 graines |

