# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 21:05
- Graines : 1 à 10 (10) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : aucun
- Paramètres changés : population = 1000
- Temps total : 81 s pour 20 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 38,0 % | 18,4 pt (27,3 % – 45,6 %) | 19,2 % – 79,7 % | 10/10 |
| Chômage max | toute la partie | — | 68,3 % | 36,0 pt (45,7 % – 81,7 %) | 36,9 % – 95,4 % | — |
| Faim moyenne | après chauffe | < 2 % | 9,7 % | 16,9 pt (2,0 % – 18,9 %) | 0,0 % – 71,1 % | 7/10 |
| Faim max | toute la partie | — | 94,0 % | 19,4 pt (80,3 % – 99,7 %) | 0,0 % – 100,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 19,6 % | 17,0 pt (11,5 % – 28,5 %) | 4,1 % – 70,0 % | 10/10 |
| Sans-abri max | toute la partie | — | 65,6 % | 42,7 pt (37,3 % – 79,9 %) | 20,5 % – 94,4 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,63 | 0,13 (0,53 – 0,67) | 0,42 – 0,84 | 9/10 |
| Gini en fin de partie | dernier jour | — | 0,66 | 0,43 (0,52 – 0,95) | 0,29 – 0,98 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,040 % | 0,054 pt (-0,076 % – -0,022 %) | -0,128 % – 0,051 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 40,1 % | 24,3 pt (26,3 % – 50,7 %) | 19,8 % – 72,1 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 191,4 % | 32,7 pt (173,6 % – 206,3 %) | 148,3 % – 223,0 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 36 | 8,3 (31 – 39,3) | 16 – 42 | 10/10 |
| … dont après la chauffe | après chauffe | — | 35 | 7,5 (31 – 38,5) | 16 – 41 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 3125,5 | 1317,8 (2494,3 – 3812) | 1952 – 4916 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 581 | 115,8 (563,5 – 679,3) | 479 – 783 | — |
| Santé moyenne | après chauffe | — | 0,20 | 0,04 (0,19 – 0,24) | 0,16 – 0,38 | — |
| Naissances d’entreprises / an | toute la partie | — | 27,3 | 11,3 (26,2 – 37,4) | 22,6 – 40,1 | — |
| Morts d’entreprises / an | toute la partie | — | 26,5 | 13,1 (25,1 – 38,1) | 22,1 – 40,4 | — |
| Entonnoir : projets envisagés | toute la partie | — | 13342,5 | 943,3 (13062,5 – 14005,8) | 11763 – 16980 | — |
| Entonnoir : créations | toute la partie | — | 112 | 46,3 (107,5 – 153,8) | 93 – 165 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 770 | 362,8 (638,3 – 1001) | 521 – 1324 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 5139,5 | 2033,8 (4729,5 – 6763,3) | 3965 – 7499 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 1914,5 | 303 (1852 – 2155) | 1631 – 2237 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 2997,5 | 896 (2515,5 – 3411,5) | 2223 – 3922 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 2 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 2159 | 541 (1779,3 – 2320,3) | 1585 – 2667 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 84,5 | 130,5 (30 – 160,5) | 0 – 324 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 22,5 | 3,5 (20,3 – 23,8) | 18 – 31 | — |
| Machines en fin | dernier jour | — | 4,3 | 9,0 (1,8 – 10,8) | 1,1 – 386,8 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 5,5 | 3,8 (3,3 – 7) | 2 – 13 | — |
| Bonheur moyen | après chauffe | — | 0,68 | 0,16 (0,59 – 0,75) | 0,25 – 0,81 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 526,1 | 57,5 (486,5 – 544,1) | 314,5 – 597,3 | — |
| Jours de prestations réduites | après chauffe | — | 694 | 379,8 (399,3 – 779) | 30 – 1241 | — |
| Trésor de l’État le plus bas | après chauffe | — | 5 301 $ | 5 810 $ (2 974 $ – 8 784 $) | 457 $ – 13 494 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 22 577 $ | 16 487 $ (17 942 $ – 34 430 $) | 11 528 $ – 66 624 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 10/10 | 2 | 1 – 2 | 1 – 4 | 763 j |
| Faim répandue | critique | 9/10 | 5 | 2,3 – 6,8 | 0 – 15 | 280,5 j |
| Sans-abri nombreux | critique | 10/10 | 12 | 7,8 – 14,8 | 4 – 21 | 962 j |
| Inégalités hors bornes | attention | 9/10 | 1 | 1 – 2 | 0 – 3 | 709,5 j |
| Richesse médiane hors bornes | attention | 8/10 | 2 | 1 – 3 | 0 – 3 | 318 j |
| Inflation quotidienne | critique | 10/10 | 13 | 9,3 – 14 | 4 – 23 | 14 j |
| Inflation sur 100 jours | critique | 10/10 | 1 | 1 – 1 | 1 – 3 | 116,5 j |
| Rupture de stock prolongée | attention | 10/10 | 119 | 105 – 146,8 | 65 – 189 | 5744 j |
| Surstock | attention | 10/10 | 69,5 | 62 – 74 | 42 – 87 | 4614 j |
| Entreprise sans employé | attention | 10/10 | 121,5 | 112,8 – 163,8 | 97 – 170 | 3032 j |
| Entreprise sans client | attention | 10/10 | 191 | 181,3 – 238,5 | 154 – 258 | 9695,5 j |
| Santé de la population effondrée | critique | 10/10 | 1 | 1 – 1 | 1 – 1 | 1135 j |
| Productivité du travail effondrée | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 1140,5 j |
| Embauches bloquées faute de moyens | attention | 10/10 | 3 | 3 – 4 | 2 – 5 | 719 j |
| Prix aberrant | attention | 10/10 | 34,5 | 30,3 – 40,5 | 23 – 45 | 10366 j |
| Attente trop longue (service public) | attention | 10/10 | 2 | 2 – 2 | 2 – 3 | 1807,5 j |
| Prestations réduites faute de trésor | attention | 10/10 | 1 | 1 – 1 | 1 – 8 | 694 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 50,5 % | 84,3 % | 21,4 % | 31,9 % | 0,76 | -0,050 % | 593 (37) | 0,20 | 10 % / 30 % / 61 % | 5 | 2 158 $ |
| 2 | 79,7 % | 95,4 % | 71,1 % | 70,0 % | 0,84 | 0,051 % | 682 (16) | 0,20 | 4 % / 25 % / 71 % | 9 | 295 $ |
| 3 | 25,6 % | 40,3 % | 0,8 % | 6,4 % | 0,45 | -0,085 % | 569 (34) | 0,34 | 8 % / 20 % / 72 % | 3 | 12 961 $ |
| 4 | 24,1 % | 43,0 % | 0,0 % | 10,2 % | 0,42 | -0,027 % | 671 (30) | 0,16 | 9 % / 21 % / 70 % | 5 | 19 734 $ |
| 5 | 45,3 % | 77,1 % | 16,9 % | 27,8 % | 0,65 | -0,047 % | 479 (36) | 0,20 | 8 % / 12 % / 80 % | 3 | 770 $ |
| 6 | 35,7 % | 59,4 % | 3,5 % | 18,4 % | 0,65 | -0,128 % | 504 (36) | 0,38 | 7 % / 21 % / 73 % | 0 | 6 569 $ |
| 7 | 19,2 % | 36,9 % | 1,9 % | 4,1 % | 0,53 | -0,020 % | 783 (40) | 0,16 | 8 % / 32 % / 59 % | 3 | 0 $ |
| 8 | 40,3 % | 79,6 % | 16,0 % | 20,9 % | 0,62 | 0,020 % | 685 (24) | 0,19 | 10 % / 18 % / 72 % | 6 | 0 $ |
| 9 | 45,7 % | 82,4 % | 19,6 % | 28,8 % | 0,67 | -0,091 % | 568 (42) | 0,21 | 11 % / 22 % / 67 % | 6 | 0 $ |
| 10 | 32,3 % | 53,7 % | 2,5 % | 15,7 % | 0,54 | -0,033 % | 562 (40) | 0,25 | 13 % / 30 % / 57 % | 6 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 42,1 % | 4,4 pt (40,4 % – 44,8 %) | 39,1 % – 50,6 % | 10/10 |
| Chômage max | toute la partie | — | 90,5 % | 3,4 pt (87,5 % – 90,9 %) | 86,1 % – 91,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 11,0 % | 3,0 pt (10,1 % – 13,1 %) | 9,7 % – 17,6 % | 10/10 |
| Faim max | toute la partie | — | 66,0 % | 9,0 pt (62,5 % – 71,5 %) | 59,3 % – 80,9 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 20,5 % | 5,4 pt (18,5 % – 23,9 %) | 17,1 % – 25,6 % | 10/10 |
| Sans-abri max | toute la partie | — | 62,9 % | 4,4 pt (60,5 % – 65,0 %) | 57,4 % – 68,2 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,64 | 0,03 (0,63 – 0,66) | 0,61 – 0,67 | 10/10 |
| Gini en fin de partie | dernier jour | — | 0,74 | 0,15 (0,63 – 0,79) | 0,47 – 0,85 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,027 % | 0,070 pt (-0,079 % – -0,010 %) | -0,098 % – 0,007 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 210,1 % | 99,3 pt (154,3 % – 253,6 %) | 77,1 % – 367,7 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 310,0 % | 136,0 pt (239,2 % – 375,3 %) | 157,5 % – 477,8 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 38 | 6,5 (35,3 – 41,8) | 32 – 51 | 10/10 |
| … dont après la chauffe | après chauffe | — | 38 | 5,8 (35 – 40,8) | 32 – 50 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 3340 | 328,5 (3153,5 – 3482) | 3041 – 3978 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 267 | 27,3 (245,5 – 272,8) | 229 – 306 | — |
| Santé moyenne | après chauffe | — | 0,20 | 0,04 (0,19 – 0,23) | 0,18 – 0,28 | — |
| Naissances d’entreprises / an | toute la partie | — | 5,8 | 1,9 (4,8 – 6,8) | 3,4 – 8,3 | — |
| Morts d’entreprises / an | toute la partie | — | 4,6 | 0,4 (4,4 – 4,9) | 4,1 – 5,4 | — |
| Entonnoir : projets envisagés | toute la partie | — | 9790 | 966,8 (9520,5 – 10487,3) | 9108 – 10908 | — |
| Entonnoir : créations | toute la partie | — | 24 | 8 (19,8 – 27,8) | 14 – 34 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 116 | 52,3 (84 – 136,3) | 49 – 201 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 1039 | 375 (850,8 – 1225,8) | 673 – 1496 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 2520 | 452 (2343,5 – 2795,5) | 1498 – 3086 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 3388,5 | 302 (3312,8 – 3614,8) | 3157 – 4147 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 1 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 2653,5 | 537,8 (2419,8 – 2957,5) | 2253 – 3079 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 128,5 | 79,8 (87,3 – 167) | 35 – 394 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 26,5 | 4,8 (23 – 27,8) | 22 – 31 | — |
| Machines en fin | dernier jour | — | 3,0 | 16,1 (2,6 – 18,6) | 2,4 – 360,9 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 6 | 3 (4 – 7) | 2 – 8 | — |
| Bonheur moyen | après chauffe | — | 0,61 | 0,05 (0,58 – 0,63) | 0,56 – 0,64 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 527,7 | 51,3 (489,3 – 540,6) | 424,9 – 554,8 | — |
| Jours de prestations réduites | après chauffe | — | 653,5 | 115,5 (624,5 – 740) | 567 – 920 | — |
| Trésor de l’État le plus bas | après chauffe | — | 232 $ | 16 $ (224 $ – 240 $) | 210 $ – 268 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 6 499 $ | 5 480 $ (2 678 $ – 8 158 $) | 0 $ – 22 524 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 2220,66 | 726,09 (1978,14 – 2704,23) | 1783,64 – 3865,89 | 10/10 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 14,36 | 3,94 (13,35 – 17,29) | 11,21 – 22,04 | 10/10 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 4440,54 | 1470,07 (3720,60 – 5190,67) | 3344,29 – 5684,71 | 10/10 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 2220,66 | 1978,14 – 2704,23 | 1783,64 – 3865,89 | 10/10 | 681283 | prix trop élevé (100 %) ; pas de revenu (0 %) |
| Renflouement d’entreprise | 14,36 | 13,35 – 17,29 | 11,21 – 22,04 | 10/10 | 4729 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 4440,54 | 3720,60 – 5190,67 | 3344,29 – 5684,71 | 10/10 | 1249805 | prix trop élevé (91 %) ; parc plein (9 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 10 graines · graines touchées) : Tourisme 1222 · 10, Pétrochimie 726 · 10, Ingénierie pétrolière 548 · 9, Ferme 343 · 10, Hôtel 318 · 9, Immobilier 278 · 9, Pêcherie 181 · 10, Mine de cuivre 128 · 10.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 42,1 % | 91,0 % | 11,7 % | 21,9 % | 0,64 | -0,033 % | 229 (39) | 0,20 | 10 % / 16 % / 75 % | 0 | 6 380 $ |
| 2 | 49,6 % | 86,1 % | 15,5 % | 25,6 % | 0,64 | -0,087 % | 267 (37) | 0,23 | 14 % / 24 % / 61 % | 2 | 324 $ |
| 3 | 50,6 % | 91,6 % | 17,6 % | 24,6 % | 0,66 | -0,006 % | 281 (33) | 0,28 | 12 % / 23 % / 65 % | 2 | 16 587 $ |
| 4 | 43,6 % | 91,7 % | 10,5 % | 18,2 % | 0,67 | -0,098 % | 273 (41) | 0,23 | 16 % / 26 % / 57 % | 0 | 7 373 $ |
| 5 | 39,5 % | 89,7 % | 10,9 % | 19,4 % | 0,64 | -0,021 % | 267 (42) | 0,18 | 11 % / 28 % / 61 % | 0 | 9 995 $ |
| 6 | 41,8 % | 86,7 % | 10,0 % | 19,9 % | 0,61 | -0,020 % | 272 (36) | 0,24 | 11 % / 22 % / 66 % | 1 | 5 002 $ |
| 7 | 42,2 % | 90,6 % | 11,1 % | 21,1 % | 0,66 | -0,085 % | 306 (46) | 0,20 | 9 % / 33 % / 57 % | 0 | 8 017 $ |
| 8 | 45,2 % | 90,6 % | 13,6 % | 24,7 % | 0,67 | 0,004 % | 235 (32) | 0,19 | 7 % / 34 % / 59 % | 0 | 0 $ |
| 9 | 39,1 % | 86,5 % | 9,8 % | 17,3 % | 0,62 | -0,062 % | 265 (51) | 0,20 | 11 % / 30 % / 59 % | 1 | 5 988 $ |
| 10 | 39,9 % | 90,3 % | 9,7 % | 17,1 % | 0,63 | 0,007 % | 239 (35) | 0,19 | 15 % / 23 % / 62 % | 1 | 13 475 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 10/10 : g1 37, g2 16, g3 34, g4 30, g5 36, g6 36, g7 40, g8 24, … |
| Chômage moyen ≤ 10 % | ❌ | 10/10 : g1 50,5 %, g2 79,7 %, g3 25,6 %, g4 24,1 %, g5 45,3 %, g6 35,7 %, g7 19,2 %, g8 40,3 %, … |
| Faim et sans-abri < 2 % | ❌ | 10/10 : g1, g2, g3, g4, g5, g6, g7, g8, g9, g10 |
| Gini 0,2–0,45 | ❌ | 9/10 : g1 0,76, g2 0,84, g3 0,45, g5 0,65, g6 0,65, g7 0,53, g8 0,62, g9 0,67, … |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 10 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 10 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 10/10 graines ; Renflouement d’entreprise : 10/10 graines ; Plancher de logement : 10/10 graines |

