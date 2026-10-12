# Protocole de stabilité ÉcoNodes

- Date : 2026-10-12 16:00
- Graines : 1 à 6 (6) · 1000 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1000), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1000). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Bâtiments, construction et hypothèques
- Paramètres changés : population = 13240
- Temps total : 25 min 16 s pour 12 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 62,1 % | 0,3 pt (61,9 % – 62,2 %) | 60,1 % – 63,0 % | 6/6 |
| Chômage max | toute la partie | — | 82,7 % | 3,1 pt (80,7 % – 83,9 %) | 79,8 % – 85,4 % | — |
| Faim moyenne | après chauffe | < 2 % | 50,4 % | 0,9 pt (50,0 % – 50,8 %) | 47,9 % – 51,2 % | 6/6 |
| Faim max | toute la partie | — | 82,1 % | 3,3 pt (80,1 % – 83,4 %) | 79,2 % – 85,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 27,9 % | 4,1 pt (27,5 % – 31,6 %) | 26,5 % – 33,8 % | 6/6 |
| Sans-abri max | toute la partie | — | 61,1 % | 7,3 pt (59,7 % – 67,0 %) | 56,3 % – 75,7 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,88 | 0,01 (0,88 – 0,88) | 0,88 – 0,89 | 6/6 |
| Gini en fin de partie | dernier jour | — | 1,00 | 0,0002 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,073 % | 0,011 pt (0,069 % – 0,080 %) | 0,056 % – 0,101 % | 0/6 |
| |Inflation| max / j | toute la partie | — | 13,0 % | 4,0 pt (12,2 % – 16,2 %) | 11,2 % – 23,1 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 107,7 % | 2,1 pt (106,5 % – 108,6 %) | 105,9 % – 110,5 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 20,5 | 3,8 (19 – 22,8) | 18 – 23 | 6/6 |
| … dont après la chauffe | après chauffe | — | 17 | 3,5 (16 – 19,5) | 15 – 20 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 2830,5 | 65 (2804 – 2869) | 2801 – 2914 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 7387 | 87 (7338,3 – 7425,3) | 7269 – 7549 | — |
| Santé moyenne | après chauffe | — | 0,30 | 0,03 (0,28 – 0,31) | 0,28 – 0,32 | — |
| Naissances d’entreprises / an | toute la partie | — | 2,6 | 2,9 (1,6 – 4,6) | 0,7 – 5,8 | — |
| Naissances / an, en % du parc moyen | toute la partie | — | 0,6 | 0,7 (0,4 – 1,0) | 0,2 – 1,3 | — |
| Morts / an, en % du parc moyen | toute la partie | — | 120,5 | 3,5 (119,7 – 123,2) | 118,7 – 124,6 | — |
| Parc moyen d’entreprises (après la chauffe) | après chauffe | — | 446,4 | 9,9 (441,4 – 451,3) | 436,3 – 452,9 | — |
| Part de la plus grande entreprise (médiane des biens) | après chauffe | — | 81,4 % | 2,0 pt (80,6 % – 82,6 %) | 79,8 % – 85,0 % | — |
| Herfindahl des ventes (médiane des biens) | après chauffe | — | 0,77 | 0,03 (0,76 – 0,79) | 0,74 – 0,83 | — |
| Fermetures : prix aberrant | toute la partie | — | 258,5 | 7,8 (255 – 262,8) | 251 – 269 | — |
| Fermetures : faillite (salaires impayables) | toute la partie | — | 1065,5 | 4,5 (1062,5 – 1067) | 1061 – 1069 | — |
| Fermetures : demande perdue | toute la partie | — | 86,5 | 16,5 (74,5 – 91) | 67 – 92 | — |
| Fermetures : sans employé (départs, postes non pourvus) | toute la partie | — | 73 | 13,3 (67,5 – 80,8) | 66 – 86 | — |
| Fermetures : autre | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Morts d’entreprises / an | toute la partie | — | 541,1 | 5,5 (537,8 – 543,3) | 535,5 – 545,3 | — |
| Entonnoir : projets envisagés | toute la partie | — | 5652 | 848 (5163,5 – 6011,5) | 4813 – 6191 | — |
| Entonnoir : créations | toute la partie | — | 7 | 8 (4,5 – 12,5) | 2 – 16 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 30,5 | 26,5 (18,8 – 45,3) | 8 – 60 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 370,5 | 435,8 (230,3 – 666) | 118 – 820 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 4436,5 | 279 (4256,5 – 4535,5) | 4184 – 4732 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 190 | 119,8 (177,8 – 297,5) | 157 – 334 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 454 | 304,3 (300,8 – 605) | 69 – 755 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 25 | 0,8 (24,3 – 25) | 24 – 25 | — |
| Machines en fin | dernier jour | — | 391,2 | 33,9 (362,6 – 396,4) | 321,5 – 409,4 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 57,5 | 6 (53,8 – 59,8) | 52 – 61 | — |
| Bonheur moyen | après chauffe | — | 0,45 | 0,02 (0,45 – 0,46) | 0,44 – 0,47 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 272,3 | 24,4 (261,1 – 285,6) | 255,2 – 291,4 | — |
| Jours de prestations réduites | après chauffe | — | 735,5 | 14,3 (730,3 – 744,5) | 729 – 756 | — |
| Trésor de l’État le plus bas | après chauffe | — | 65 113 $ | 9 748 $ (63 888 $ – 73 637 $) | 60 125 $ – 83 625 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 952 209 $ | 69 912 $ (921 193 $ – 991 105 $) | 903 250 $ – 1 023 738 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/6 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 6/6 | 1 | 1 – 1 | 1 – 1 | 737,5 j |
| Faim répandue | critique | 6/6 | 3 | 3 – 3 | 2 – 3 | 686 j |
| Sans-abri nombreux | critique | 6/6 | 3 | 2,3 – 3 | 2 – 4 | 768 j |
| Inégalités hors bornes | attention | 6/6 | 1 | 1 – 1 | 1 – 1 | 770 j |
| Richesse médiane hors bornes | attention | 6/6 | 1 | 1 – 1 | 1 – 1 | 654,5 j |
| Inflation quotidienne | critique | 6/6 | 12,5 | 10,3 – 14 | 9 – 14 | 14,5 j |
| Inflation sur 100 jours | critique | 6/6 | 1 | 1 – 1 | 1 – 1 | 11,5 j |
| Rupture de stock prolongée | attention | 6/6 | 1355,5 | 1351,5 – 1361 | 1345 – 1376 | 30727 j |
| Surstock | attention | 6/6 | 1255,5 | 1244,8 – 1264 | 1209 – 1270 | 65676,5 j |
| Entreprise sans employé | attention | 6/6 | 1886,5 | 1877 – 1911 | 1863 – 1947 | 102722,5 j |
| Entreprise sans client | attention | 6/6 | 2577,5 | 2518,5 – 2611 | 2493 – 2635 | 207928,5 j |
| Santé de la population effondrée | critique | 6/6 | 1 | 1 – 1 | 1 – 1 | 619,5 j |
| Productivité du travail effondrée | attention | 6/6 | 1 | 1 – 1 | 1 – 1 | 619,5 j |
| Pénurie de main-d’œuvre | attention | 6/6 | 1 | 1 – 1 | 1 – 1 | 19,5 j |
| Embauches bloquées faute de moyens | attention | 6/6 | 2 | 2 – 2 | 2 – 2 | 709 j |
| Prix aberrant | attention | 6/6 | 292,5 | 279,3 – 306,5 | 266 – 314 | 59236 j |
| Attente trop longue (service public) | attention | 6/6 | 2 | 2 – 2 | 2 – 2 | 1398 j |
| Prestations réduites faute de trésor | attention | 6/6 | 1 | 1 – 1 | 1 – 1 | 735,5 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 63,0 % | 84,2 % | 51,2 % | 33,8 % | 0,88 | 0,073 % | 7384 (23) | 0,32 | 12 % / 31 % / 57 % | 115 | 0 $ |
| 2 | 62,2 % | 82,8 % | 50,7 % | 26,5 % | 0,89 | 0,082 % | 7323 (19) | 0,28 | 10 % / 31 % / 60 % | 111 | 0 $ |
| 3 | 62,2 % | 85,4 % | 50,8 % | 32,8 % | 0,88 | 0,101 % | 7549 (18) | 0,29 | 12 % / 31 % / 57 % | 112 | 1 930 $ |
| 4 | 61,9 % | 79,8 % | 50,1 % | 27,7 % | 0,89 | 0,056 % | 7269 (23) | 0,28 | 11 % / 28 % / 61 % | 111 | 0 $ |
| 5 | 60,1 % | 80,1 % | 47,9 % | 27,5 % | 0,88 | 0,073 % | 7390 (22) | 0,31 | 10 % / 30 % / 60 % | 110 | 0 $ |
| 6 | 62,0 % | 82,7 % | 49,9 % | 28,1 % | 0,88 | 0,068 % | 7437 (19) | 0,31 | 7 % / 27 % / 67 % | 110 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 63,6 % | 0,4 pt (63,4 % – 63,8 %) | 63,2 % – 64,5 % | 6/6 |
| Chômage max | toute la partie | — | 85,7 % | 1,2 pt (85,3 % – 86,5 %) | 84,0 % – 86,9 % | — |
| Faim moyenne | après chauffe | < 2 % | 35,2 % | 0,6 pt (35,0 % – 35,6 %) | 34,7 % – 36,3 % | 6/6 |
| Faim max | toute la partie | — | 60,8 % | 1,7 pt (60,6 % – 62,3 %) | 58,5 % – 69,8 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 37,2 % | 0,7 pt (36,8 % – 37,5 %) | 36,3 % – 38,6 % | 6/6 |
| Sans-abri max | toute la partie | — | 63,5 % | 0,4 pt (63,3 % – 63,7 %) | 63,0 % – 65,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,87 | 0,01 (0,87 – 0,87) | 0,86 – 0,88 | 6/6 |
| Gini en fin de partie | dernier jour | — | 1,00 | 0,0004 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,073 % | 0,015 pt (0,069 % – 0,084 %) | 0,055 % – 0,100 % | 0/6 |
| |Inflation| max / j | toute la partie | — | 11,9 % | 7,5 pt (9,0 % – 16,5 %) | 7,7 % – 34,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 112,0 % | 0,7 pt (111,4 % – 112,1 %) | 110,1 % – 113,2 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 17,5 | 6,5 (15 – 21,5) | 15 – 22 | 6/6 |
| … dont après la chauffe | après chauffe | — | 14,5 | 5,8 (12 – 17,8) | 12 – 18 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 2799,5 | 61,3 (2755,8 – 2817) | 2744 – 2838 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 7124 | 77,3 (7072,3 – 7149,5) | 7054 – 7316 | — |
| Santé moyenne | après chauffe | — | 0,31 | 0,01 (0,30 – 0,31) | 0,29 – 0,33 | — |
| Naissances d’entreprises / an | toute la partie | — | 1,5 | 0,5 (1,2 – 1,7) | 0,7 – 2,2 | — |
| Naissances / an, en % du parc moyen | toute la partie | — | 0,3 | 0,1 (0,2 – 0,4) | 0,2 – 0,5 | — |
| Morts / an, en % du parc moyen | toute la partie | — | 114,3 | 0,7 (114,2 – 114,8) | 111,7 – 116,6 | — |
| Parc moyen d’entreprises (après la chauffe) | après chauffe | — | 473,2 | 3,9 (471,4 – 475,3) | 464,8 – 482,3 | — |
| Part de la plus grande entreprise (médiane des biens) | après chauffe | — | 80,8 % | 1,4 pt (80,2 % – 81,6 %) | 77,0 % – 82,7 % | — |
| Herfindahl des ventes (médiane des biens) | après chauffe | — | 0,77 | 0,01 (0,76 – 0,78) | 0,72 – 0,78 | — |
| Fermetures : prix aberrant | toute la partie | — | 329 | 17,8 (322 – 339,8) | 313 – 343 | — |
| Fermetures : faillite (salaires impayables) | toute la partie | — | 901,5 | 9,8 (899,3 – 909) | 876 – 921 | — |
| Fermetures : demande perdue | toute la partie | — | 127 | 15,3 (122,8 – 138) | 112 – 142 | — |
| Fermetures : sans employé (départs, postes non pourvus) | toute la partie | — | 121,5 | 1,8 (121 – 122,8) | 121 – 130 | — |
| Fermetures : autre | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Morts d’entreprises / an | toute la partie | — | 541,1 | 0,9 (540,9 – 541,8) | 538,7 – 543,1 | — |
| Entonnoir : projets envisagés | toute la partie | — | 5160 | 139,8 (5049,3 – 5189) | 4843 – 5260 | — |
| Entonnoir : créations | toute la partie | — | 4 | 1,5 (3,3 – 4,8) | 2 – 6 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 12,5 | 5,3 (10,3 – 15,5) | 9 – 30 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 223,5 | 85 (185,5 – 270,5) | 118 – 328 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 4413,5 | 200 (4348 – 4548) | 4266 – 4590 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 153 | 50,3 (120 – 170,3) | 108 – 221 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 338,5 | 197,5 (161,8 – 359,3) | 59 – 441 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 25 | 0,8 (24,3 – 25) | 22 – 26 | — |
| Machines en fin | dernier jour | — | 362,0 | 31,7 (349,1 – 380,8) | 333,6 – 440,5 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 58,5 | 3,3 (57,3 – 60,5) | 46 – 62 | — |
| Bonheur moyen | après chauffe | — | 0,41 | 0,01 (0,40 – 0,41) | 0,39 – 0,42 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 263,2 | 9,3 (258,0 – 267,4) | 249,4 – 277,9 | — |
| Jours de prestations réduites | après chauffe | — | 731 | 3,5 (729,3 – 732,8) | 715 – 738 | — |
| Trésor de l’État le plus bas | après chauffe | — | 21 483 $ | 3 893 $ (20 120 $ – 24 013 $) | 16 520 $ – 25 377 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 936 484 $ | 64 369 $ (908 707 $ – 973 076 $) | 870 500 $ – 1 046 870 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 113021,39 | 1594,88 (111855,72 – 113450,60) | 110777,61 – 116782,61 | 6/6 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 230,67 | 24,35 (228,47 – 252,82) | 218,89 – 290,00 | 6/6 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 69245,11 | 2492,86 (68675,22 – 71168,08) | 68546,67 – 78283,44 | 6/6 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/6 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/6 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/6 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 113021,39 | 111855,72 – 113450,60 | 110777,61 – 116782,61 | 6/6 | 12218700 | prix trop élevé (100 %) ; pas de producteur (0 %) |
| Renflouement d’entreprise | 230,67 | 228,47 – 252,82 | 218,89 – 290,00 | 6/6 | 47978 | par le propriétaire (84 %) ; après rachat (16 %) |
| Plancher de logement | 69245,11 | 68675,22 – 71168,08 | 68546,67 – 78283,44 | 6/6 | 7830876 | prix trop élevé (86 %) ; parc plein (14 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/6 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/6 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 6 graines · graines touchées) : Immobilier 3531 · 6, Ingénierie pétrolière 2937 · 6, Production télé 1941 · 6, Ferme 1825 · 6, Boulangerie 1712 · 6, Hôtel 1589 · 6, Tourisme 1303 · 6, Garage 1195 · 6.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 64,5 % | 85,8 % | 36,3 % | 38,6 % | 0,87 | 0,087 % | 7054 (22) | 0,31 | 10 % / 30 % / 59 % | 115 | 0 $ |
| 2 | 63,2 % | 86,9 % | 35,1 % | 36,3 % | 0,86 | 0,077 % | 7316 (15) | 0,33 | 16 % / 35 % / 50 % | 114 | 3 153 $ |
| 3 | 63,8 % | 84,0 % | 35,7 % | 36,7 % | 0,87 | 0,069 % | 7150 (15) | 0,32 | 16 % / 29 % / 56 % | 112 | 0 $ |
| 4 | 63,4 % | 85,1 % | 35,4 % | 37,4 % | 0,88 | 0,055 % | 7100 (15) | 0,30 | 12 % / 36 % / 52 % | 114 | 0 $ |
| 5 | 63,4 % | 85,7 % | 35,0 % | 37,5 % | 0,87 | 0,069 % | 7148 (22) | 0,29 | 12 % / 30 % / 58 % | 112 | 0 $ |
| 6 | 63,7 % | 86,7 % | 34,7 % | 37,0 % | 0,87 | 0,100 % | 7063 (20) | 0,31 | 13 % / 31 % / 56 % | 112 | 0 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 6/6 : g1 23, g2 19, g3 18, g4 23, g5 22, g6 19 |
| Chômage moyen ≤ 10 % | ❌ | 6/6 : g1 63,0 %, g2 62,2 %, g3 62,2 %, g4 61,9 %, g5 60,1 %, g6 62,0 % |
| Faim et sans-abri < 2 % | ❌ | 6/6 : g1, g2, g3, g4, g5, g6 |
| Gini 0,2–0,45 | ❌ | 6/6 : g1 0,88, g2 0,89, g3 0,88, g4 0,89, g5 0,88, g6 0,88 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 6 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 6 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 6/6 graines ; Renflouement d’entreprise : 6/6 graines ; Plancher de logement : 6/6 graines |

