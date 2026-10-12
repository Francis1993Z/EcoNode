# Protocole de stabilité ÉcoNodes

- Date : 2026-10-12 10:35
- Graines : 1 à 6 (6) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Bâtiments, construction et hypothèques
- Paramètres changés : population = 3000
- Temps total : 5 min 50 s pour 12 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 36,1 % | 5,0 pt (31,8 % – 36,8 %) | 28,2 % – 38,0 % | 6/6 |
| Chômage max | toute la partie | — | 59,3 % | 4,2 pt (57,3 % – 61,6 %) | 46,0 % – 66,1 % | — |
| Faim moyenne | après chauffe | < 2 % | 4,5 % | 1,2 pt (3,7 % – 4,8 %) | 0,1 % – 6,2 % | 5/6 |
| Faim max | toute la partie | — | 40,6 % | 18,4 pt (36,4 % – 54,7 %) | 18,6 % – 59,7 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 18,3 % | 5,4 pt (16,1 % – 21,6 %) | 10,2 % – 23,5 % | 6/6 |
| Sans-abri max | toute la partie | — | 60,2 % | 6,6 pt (57,0 % – 63,6 %) | 52,3 % – 67,5 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,82 | 0,04 (0,80 – 0,84) | 0,79 – 0,86 | 6/6 |
| Gini en fin de partie | dernier jour | — | 0,94 | 0,10 (0,86 – 0,96) | 0,76 – 0,97 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,003 % | 0,050 pt (-0,049 % – 0,001 %) | -0,082 % – 0,001 % | 0/6 |
| |Inflation| max / j | toute la partie | — | 48,5 % | 28,0 pt (31,9 % – 59,9 %) | 18,2 % – 104,5 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 137,0 % | 43,7 pt (111,2 % – 154,9 %) | 100,0 % – 178,8 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 51,5 | 11,3 (46,3 – 57,5) | 44 – 62 | 6/6 |
| … dont après la chauffe | après chauffe | — | 48,5 | 12,5 (43 – 55,5) | 40 – 60 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 2721,5 | 623 (2428 – 3051) | 2067 – 3355 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 2237,5 | 77,8 (2186,3 – 2264) | 2143 – 2348 | — |
| Santé moyenne | après chauffe | — | 0,47 | 0,13 (0,37 – 0,50) | 0,24 – 0,57 | — |
| Naissances d’entreprises / an | toute la partie | — | 16,8 | 2,6 (16,1 – 18,6) | 10,5 – 19,0 | — |
| Morts d’entreprises / an | toute la partie | — | 95,6 | 2,6 (94,5 – 97,1) | 88,6 – 99,5 | — |
| Entonnoir : projets envisagés | toute la partie | — | 13354 | 1850,5 (12302,8 – 14153,3) | 10904 – 14896 | — |
| Entonnoir : créations | toute la partie | — | 69 | 10,5 (66 – 76,5) | 43 – 78 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 504 | 85,8 (466,8 – 552,5) | 236 – 576 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 3250,5 | 709 (2939,5 – 3648,5) | 2017 – 3902 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 6349,5 | 743,3 (6138,8 – 6882) | 5868 – 7136 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 1768 | 102 (1676,5 – 1778,5) | 1322 – 2048 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 1011 | 485 (850,3 – 1335,3) | 750 – 2420 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 23,5 | 6,3 (22,3 – 28,5) | 20 – 30 | — |
| Machines en fin | dernier jour | — | 134,5 | 1085,7 (57,4 – 1143,1) | 15,7 – 1586,3 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 21,5 | 2,5 (21 – 23,5) | 9 – 34 | — |
| Bonheur moyen | après chauffe | — | 0,73 | 0,07 (0,68 – 0,75) | 0,64 – 0,81 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 205,8 | 155,2 (184,3 – 339,6) | 122,6 – 469,2 | — |
| Jours de prestations réduites | après chauffe | — | 682,5 | 222,3 (561,3 – 783,5) | 532 – 860 | — |
| Trésor de l’État le plus bas | après chauffe | — | 29 836 $ | 13 950 $ (22 980 $ – 36 930 $) | 21 380 $ – 39 571 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 51 | 521,3 (0 – 521,3) | 0 – 953 | — |
| Prêts refusés | toute la partie | — | 40 | 131,8 (5,3 – 137) | 0 – 468 | — |
| Créances radiées | toute la partie | — | 308 648 $ | 16 950 $ (294 693 $ – 311 643 $) | 247 840 $ – 312 889 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/6 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 6/6 | 2,5 | 2 – 3 | 1 – 3 | 763,5 j |
| Faim répandue | critique | 6/6 | 7,5 | 4 – 8 | 1 – 9 | 294,5 j |
| Sans-abri nombreux | critique | 6/6 | 5,5 | 4,3 – 7,5 | 3 – 9 | 943 j |
| Inégalités hors bornes | attention | 6/6 | 1 | 1 – 1 | 1 – 1 | 1228,5 j |
| Richesse médiane hors bornes | attention | 6/6 | 2,5 | 1,3 – 3 | 1 – 4 | 439 j |
| Inflation quotidienne | critique | 6/6 | 34,5 | 27,5 – 40,8 | 25 – 45 | 46 j |
| Inflation sur 100 jours | critique | 5/6 | 2 | 2 – 2,8 | 0 – 5 | 11 j |
| Rupture de stock prolongée | attention | 6/6 | 366 | 361,3 – 370,8 | 330 – 373 | 9313 j |
| Surstock | attention | 6/6 | 357,5 | 352,3 – 365 | 345 – 366 | 17596,5 j |
| Entreprise sans employé | attention | 6/6 | 512 | 494 – 523,3 | 478 – 532 | 24581 j |
| Entreprise sans client | attention | 6/6 | 825 | 819,5 – 841,8 | 765 – 927 | 56740,5 j |
| Caisse insolvable | attention | 3/6 | 0,5 | 0 – 1 | 0 – 1 | 51 j |
| Santé de la population effondrée | critique | 6/6 | 1 | 1 – 1 | 1 – 2 | 677 j |
| Productivité du travail effondrée | attention | 6/6 | 1 | 1 – 1 | 1 – 2 | 679,5 j |
| Pénurie de main-d’œuvre | attention | 6/6 | 1 | 1 – 1 | 1 – 1 | 18,5 j |
| Embauches bloquées faute de moyens | attention | 6/6 | 4 | 3,3 – 4 | 1 – 4 | 748,5 j |
| Prix aberrant | attention | 6/6 | 105 | 102 – 105,8 | 79 – 133 | 21148,5 j |
| Attente trop longue (service public) | attention | 6/6 | 3,5 | 3 – 4 | 2 – 5 | 1437 j |
| Prestations réduites faute de trésor | attention | 6/6 | 4 | 2,3 – 5 | 1 – 6 | 682,5 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 36,7 % | 58,6 % | 4,9 % | 22,2 % | 0,86 | 0,001 % | 2143 (46) | 0,24 | 15 % / 35 % / 51 % | 28 | 0 $ |
| 2 | 36,8 % | 62,1 % | 4,8 % | 15,8 % | 0,82 | -0,007 % | 2217 (47) | 0,48 | 12 % / 31 % / 57 % | 28 | 82 930 $ |
| 3 | 30,6 % | 56,9 % | 4,2 % | 19,6 % | 0,80 | -0,063 % | 2258 (58) | 0,47 | 4 % / 21 % / 76 % | 2 | 3 742 $ |
| 4 | 28,2 % | 46,0 % | 0,1 % | 10,2 % | 0,79 | -0,082 % | 2348 (56) | 0,51 | 4 % / 15 % / 82 % | 1 | 0 $ |
| 5 | 35,5 % | 59,9 % | 3,5 % | 17,0 % | 0,82 | 0,001 % | 2176 (62) | 0,57 | 15 % / 33 % / 52 % | 28 | 0 $ |
| 6 | 38,0 % | 66,1 % | 6,2 % | 23,5 % | 0,85 | 0,001 % | 2266 (44) | 0,33 | 10 % / 34 % / 55 % | 3 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 33,0 % | 18,7 pt (17,5 % – 36,2 %) | 11,9 % – 41,2 % | 6/6 |
| Chômage max | toute la partie | — | 53,5 % | 24,7 pt (37,5 % – 62,2 %) | 33,1 % – 65,1 % | — |
| Faim moyenne | après chauffe | < 2 % | 2,3 % | 6,0 pt (0,0 % – 6,0 %) | 0,0 % – 11,5 % | 3/6 |
| Faim max | toute la partie | — | 29,6 % | 28,1 pt (14,6 % – 42,7 %) | 12,9 % – 45,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 11,9 % | 15,4 pt (2,7 % – 18,0 %) | 0,6 % – 21,4 % | 4/6 |
| Sans-abri max | toute la partie | — | 47,8 % | 7,6 pt (45,7 % – 53,2 %) | 44,8 % – 58,4 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,77 | 0,22 (0,56 – 0,78) | 0,38 – 0,79 | 5/6 |
| Gini en fin de partie | dernier jour | — | 0,75 | 0,45 (0,36 – 0,81) | 0,10 – 0,94 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,008 % | 0,077 pt (-0,020 % – 0,057 %) | -0,026 % – 0,076 % | 0/6 |
| |Inflation| max / j | toute la partie | — | 26,7 % | 10,5 pt (22,7 % – 33,2 %) | 20,7 % – 53,5 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 108,1 % | 6,8 pt (104,7 % – 111,5 %) | 103,9 % – 148,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 51,5 | 19,3 (38,5 – 57,8) | 28 – 59 | 6/6 |
| … dont après la chauffe | après chauffe | — | 49 | 19,8 (35,8 – 55,5) | 25 – 56 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 2610 | 2378 (757,3 – 3135,3) | 159 – 3714 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 1922 | 72,3 (1894,5 – 1966,8) | 1734 – 2070 | — |
| Santé moyenne | après chauffe | — | 0,38 | 0,48 (0,28 – 0,75) | 0,23 – 0,88 | — |
| Naissances d’entreprises / an | toute la partie | — | 4,6 | 2,1 (3,5 – 5,6) | 2,4 – 6,3 | — |
| Morts d’entreprises / an | toute la partie | — | 82,9 | 0,7 (82,5 – 83,2) | 80,5 – 83,7 | — |
| Entonnoir : projets envisagés | toute la partie | — | 9200 | 1063 (8778,8 – 9841,8) | 8215 – 10856 | — |
| Entonnoir : créations | toute la partie | — | 19 | 8,8 (14,3 – 23) | 10 – 26 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 96 | 60 (69 – 129) | 45 – 145 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 853 | 477,3 (644,8 – 1122) | 498 – 1345 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 5926 | 283,3 (5832,8 – 6116) | 5442 – 7174 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 1291,5 | 266,3 (1196,3 – 1462,5) | 637 – 1784 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 3 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 1220 | 1086,8 (329,8 – 1416,5) | 39 – 1917 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 24,8 (0 – 24,8) | 0 – 52 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 24,5 | 6 (21,5 – 27,5) | 21 – 29 | — |
| Machines en fin | dernier jour | — | 46,3 | 1279,1 (17,3 – 1296,4) | 14,8 – 2537,8 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 13 | 5 (9,8 – 14,8) | 8 – 24 | — |
| Bonheur moyen | après chauffe | — | 0,73 | 0,23 (0,67 – 0,90) | 0,62 – 0,96 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 325,3 | 351,0 (67,9 – 419,0) | 0,6 – 484,2 | — |
| Jours de prestations réduites | après chauffe | — | 676,5 | 699 (156,8 – 855,8) | 0 – 1057 | — |
| Trésor de l’État le plus bas | après chauffe | — | 17 509 $ | 80 715 $ (7 314 $ – 88 029 $) | 6 954 $ – 155 382 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 225 106 $ | 43 802 $ (206 087 $ – 249 890 $) | 197 930 $ – 261 947 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 1266,95 | 3229,87 (0,00 – 3229,87) | 0,00 – 5934,82 | 3/6 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 55,48 | 15,19 (46,40 – 61,59) | 42,25 – 70,46 | 6/6 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 4255,88 | 6453,32 (809,68 – 7263,00) | 33,11 – 11323,29 | 6/6 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/6 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/6 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/6 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 1266,95 | 0,00 – 3229,87 | 0,00 – 5934,82 | 3/6 | 334639 | prix trop élevé (100 %) ; pas de producteur (0 %) |
| Renflouement d’entreprise | 55,48 | 46,40 – 61,59 | 42,25 – 70,46 | 6/6 | 13908 | par le propriétaire (89 %) ; après rachat (11 %) |
| Plancher de logement | 4255,88 | 809,68 – 7263,00 | 33,11 – 11323,29 | 6/6 | 815497 | prix trop élevé (84 %) ; parc plein (16 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/6 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/6 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 6 graines · graines touchées) : Tourisme 1594 · 6, Hôtel 1445 · 6, Ingénierie pétrolière 1234 · 6, Ferme 796 · 6, Garage 551 · 6, Production télé 384 · 6, Pétrochimie 321 · 6, Boulangerie 307 · 6.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 36,6 % | 58,2 % | 4,5 % | 19,0 % | 0,79 | 0,002 % | 1976 (36) | 0,28 | 15 % / 33 % / 53 % | 28 | 19 895 $ |
| 2 | 11,9 % | 33,8 % | 0,0 % | 0,6 % | 0,49 | -0,018 % | 2070 (59) | 0,85 | 4 % / 9 % / 87 % | 10 | 50 163 $ |
| 3 | 35,0 % | 63,5 % | 6,5 % | 15,2 % | 0,78 | -0,026 % | 1891 (58) | 0,47 | 6 % / 22 % / 73 % | 0 | 10 712 $ |
| 4 | 41,2 % | 65,1 % | 11,5 % | 21,4 % | 0,77 | 0,075 % | 1905 (46) | 0,29 | 15 % / 24 % / 61 % | 27 | 19 635 $ |
| 5 | 13,0 % | 33,1 % | 0,0 % | 0,7 % | 0,38 | -0,020 % | 1939 (57) | 0,88 | 5 % / 10 % / 85 % | 11 | 9 369 $ |
| 6 | 31,0 % | 48,8 % | 0,0 % | 8,6 % | 0,76 | 0,076 % | 1734 (28) | 0,23 | 12 % / 21 % / 67 % | 0 | 10 409 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 6/6 : g1 46, g2 47, g3 58, g4 56, g5 62, g6 44 |
| Chômage moyen ≤ 10 % | ❌ | 6/6 : g1 36,7 %, g2 36,8 %, g3 30,6 %, g4 28,2 %, g5 35,5 %, g6 38,0 % |
| Faim et sans-abri < 2 % | ❌ | 6/6 : g1, g2, g3, g4, g5, g6 |
| Gini 0,2–0,45 | ❌ | 6/6 : g1 0,86, g2 0,82, g3 0,80, g4 0,79, g5 0,82, g6 0,85 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 6 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 6 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 3/6 graines ; Renflouement d’entreprise : 6/6 graines ; Plancher de logement : 6/6 graines |

