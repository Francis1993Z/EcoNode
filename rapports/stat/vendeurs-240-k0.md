# Protocole de stabilité ÉcoNodes

- Date : 2026-10-12 15:17
- Graines : 1 à 6 (6) · 1000 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1000), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1000). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Bâtiments, construction et hypothèques
- Paramètres changés : population = 240
- Temps total : 9 s pour 12 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,7 % | 1,8 pt (7,8 % – 9,6 %) | 6,8 % – 12,7 % | 1/6 |
| Chômage max | toute la partie | — | 27,1 % | 2,1 pt (26,4 % – 28,4 %) | 20,8 % – 35,0 % | — |
| Faim moyenne | après chauffe | < 2 % | 7,1 % | 1,6 pt (6,1 % – 7,7 %) | 2,0 % – 11,6 % | 6/6 |
| Faim max | toute la partie | — | 95,2 % | 1,4 pt (94,7 % – 96,0 %) | 87,9 % – 96,7 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 1,7 % | 1,0 pt (1,3 % – 2,3 %) | 1,2 % – 2,6 % | 2/6 |
| Sans-abri max | toute la partie | — | 38,5 % | 17,4 pt (36,3 % – 53,6 %) | 21,7 % – 80,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,33 | 0,04 (0,31 – 0,35) | 0,31 – 0,37 | 0/6 |
| Gini en fin de partie | dernier jour | — | 0,46 | 0,28 (0,38 – 0,65) | 0,22 – 0,75 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,104 % | 0,022 pt (0,102 % – 0,124 %) | 0,092 % – 0,147 % | 0/6 |
| |Inflation| max / j | toute la partie | — | 31,3 % | 21,5 pt (28,2 % – 49,8 %) | 12,9 % – 56,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 142,1 % | 23,9 pt (129,6 % – 153,5 %) | 115,2 % – 201,0 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 22 | 8 (16,5 – 24,5) | 12 – 25 | 6/6 |
| … dont après la chauffe | après chauffe | — | 19,5 | 7,8 (14,5 – 22,3) | 11 – 24 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 896,5 | 127,5 (839,5 – 967) | 761 – 996 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 369,5 | 32,5 (351,8 – 384,3) | 198 – 402 | — |
| Santé moyenne | après chauffe | — | 0,25 | 0,06 (0,21 – 0,27) | 0,19 – 0,35 | — |
| Naissances d’entreprises / an | toute la partie | — | 26,8 | 4,7 (25,3 – 30,0) | 10,6 – 31,4 | — |
| Naissances / an, en % du parc moyen | toute la partie | — | 140,0 | 17,3 (130,8 – 148,1) | 62,0 – 153,5 | — |
| Morts / an, en % du parc moyen | toute la partie | — | 165,0 | 15,9 (150,6 – 166,6) | 102,6 – 182,0 | — |
| Parc moyen d’entreprises (après la chauffe) | après chauffe | — | 19,5 | 1,4 (18,9 – 20,3) | 17,1 – 20,6 | — |
| Part de la plus grande entreprise (médiane des biens) | après chauffe | — | 100,0 % | 0,0 pt (100,0 % – 100,0 %) | 100,0 % – 100,0 % | — |
| Herfindahl des ventes (médiane des biens) | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Fermetures : prix aberrant | toute la partie | — | 6,5 | 1,8 (6 – 7,8) | 4 – 10 | — |
| Fermetures : faillite (salaires impayables) | toute la partie | — | 76 | 16,3 (70,5 – 86,8) | 42 – 93 | — |
| Fermetures : demande perdue | toute la partie | — | 0 | 0 (0 – 0) | 0 – 1 | — |
| Fermetures : sans employé (départs, postes non pourvus) | toute la partie | — | 1 | 2 (0 – 2) | 0 – 3 | — |
| Fermetures : autre | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Morts d’entreprises / an | toute la partie | — | 31,4 | 4,5 (29,3 – 33,8) | 17,5 – 37,2 | — |
| Entonnoir : projets envisagés | toute la partie | — | 10975,5 | 931,3 (10401,5 – 11332,8) | 9425 – 11696 | — |
| Entonnoir : créations | toute la partie | — | 73,5 | 13 (69,3 – 82,3) | 29 – 86 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 488 | 74,3 (447,5 – 521,8) | 160 – 570 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 3495,5 | 556,8 (3289,5 – 3846,3) | 1545 – 4201 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 1222,5 | 246,3 (1061,5 – 1307,8) | 967 – 1339 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 1254 | 192,8 (1116 – 1308,8) | 1053 – 1414 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 350,5 | 489,5 (258,8 – 748,3) | 180 – 900 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 3315,5 | 506 (3204,3 – 3710,3) | 2823 – 4156 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 563 | 160,3 (555,3 – 715,5) | 439 – 865 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 14,5 | 2,5 (14 – 16,5) | 12 – 18 | — |
| Machines en fin | dernier jour | — | 4,1 | 3,9 (2,4 – 6,2) | 1,8 – 7,3 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 1 | 1,5 (0,3 – 1,8) | 0 – 2 | — |
| Bonheur moyen | après chauffe | — | 0,83 | 0,03 (0,82 – 0,84) | 0,81 – 0,85 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 298,5 | 76,0 (250,9 – 327,0) | 202,7 – 355,1 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 77 387 $ | 52 361 $ (40 162 $ – 92 523 $) | 15 618 $ – 100 260 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 14 955 $ | 4 370 $ (12 723 $ – 17 093 $) | 9 199 $ – 18 346 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/6 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 1/6 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Faim répandue | critique | 6/6 | 5 | 4,3 – 5 | 1 – 6 | 99 j |
| Sans-abri nombreux | critique | 6/6 | 7,5 | 4,8 – 8,8 | 3 – 9 | 70,5 j |
| Inégalités hors bornes | attention | 6/6 | 2 | 2 – 2 | 1 – 4 | 88,5 j |
| Richesse médiane hors bornes | attention | 1/6 | 0 | 0 – 0 | 0 – 2 | 0 j |
| Inflation quotidienne | critique | 6/6 | 7 | 4,8 – 7 | 4 – 9 | 7 j |
| Inflation sur 100 jours | critique | 6/6 | 1,5 | 1 – 2 | 1 – 3 | 32,5 j |
| Rupture de stock prolongée | attention | 6/6 | 96,5 | 89,3 – 97,8 | 39 – 98 | 3135,5 j |
| Surstock | attention | 6/6 | 31 | 26,5 – 34 | 24 – 36 | 1143,5 j |
| Entreprise sans employé | attention | 6/6 | 91 | 85,8 – 97,8 | 49 – 106 | 1230 j |
| Entreprise sans client | attention | 6/6 | 103,5 | 98,3 – 115,5 | 56 – 125 | 3263,5 j |
| Santé de la population effondrée | critique | 6/6 | 1 | 1 – 1 | 1 – 1 | 678,5 j |
| Productivité du travail effondrée | attention | 6/6 | 1 | 1 – 1 | 1 – 1 | 677,5 j |
| Pénurie de main-d’œuvre | attention | 1/6 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Embauches bloquées faute de moyens | attention | 6/6 | 4 | 3,3 – 4,8 | 3 – 7 | 190 j |
| Prix aberrant | attention | 6/6 | 13 | 11,5 – 14,5 | 9 – 16 | 1573 j |
| Attente trop longue (service public) | attention | 6/6 | 1 | 1 – 1 | 1 – 1 | 790 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 12,7 % | 35,0 % | 5,9 % | 1,3 % | 0,31 | 0,147 % | 370 (25) | 0,35 | 3 % / 28 % / 69 % | 5 | 0 $ |
| 2 | 7,5 % | 26,7 % | 11,6 % | 2,5 % | 0,35 | 0,105 % | 346 (25) | 0,21 | 5 % / 26 % / 69 % | 2 | 29 589 $ |
| 3 | 8,7 % | 27,5 % | 6,7 % | 1,5 % | 0,35 | 0,092 % | 402 (21) | 0,19 | 9 % / 25 % / 66 % | 3 | 2 089 $ |
| 4 | 9,9 % | 28,7 % | 7,5 % | 1,2 % | 0,32 | 0,104 % | 369 (23) | 0,24 | 6 % / 26 % / 67 % | 3 | 0 $ |
| 5 | 8,6 % | 26,3 % | 7,8 % | 2,6 % | 0,31 | 0,101 % | 389 (15) | 0,27 | 6 % / 18 % / 76 % | 1 | 0 $ |
| 6 | 6,8 % | 20,8 % | 2,0 % | 2,0 % | 0,37 | 0,130 % | 198 (12) | 0,27 | 9 % / 20 % / 71 % | 0 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 9,7 % | 3,8 pt (8,3 % – 12,1 %) | 5,9 % – 14,7 % | 3/6 |
| Chômage max | toute la partie | — | 23,1 % | 7,7 pt (18,3 % – 26,0 %) | 16,3 % – 27,9 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | 0/6 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 13,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,2 pt (0,0 % – 0,2 %) | 0,0 % – 0,7 % | 0/6 |
| Sans-abri max | toute la partie | — | 5,8 % | 27,4 pt (3,9 % – 31,3 %) | 3,3 % – 64,6 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,20 | 0,02 (0,19 – 0,21) | 0,16 – 0,28 | 3/6 |
| Gini en fin de partie | dernier jour | — | 0,20 | 0,08 (0,15 – 0,23) | 0,14 – 0,53 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,071 % | 0,053 pt (0,043 % – 0,096 %) | 0,039 % – 0,158 % | 0/6 |
| |Inflation| max / j | toute la partie | — | 36,0 % | 25,5 pt (21,5 % – 47,0 %) | 5,6 % – 90,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,0 % | 19,9 pt (131,8 % – 151,7 %) | 124,2 % – 228,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 8 | 2,8 (6,3 – 9) | 4 – 14 | 6/6 |
| … dont après la chauffe | après chauffe | — | 5,5 | 2,5 (5 – 7,5) | 2 – 10 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 61 | 60,8 (46 – 106,8) | 24 – 144 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 112 | 18,5 (102,8 – 121,3) | 98 – 145 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,0002 (0,88 – 0,88) | 0,88 – 0,88 | — |
| Naissances d’entreprises / an | toute la partie | — | 2,9 | 1,0 (2,3 – 3,3) | 2,2 – 3,6 | — |
| Naissances / an, en % du parc moyen | toute la partie | — | 12,7 | 4,0 (10,2 – 14,2) | 9,8 – 16,1 | — |
| Morts / an, en % du parc moyen | toute la partie | — | 29,4 | 4,0 (27,2 – 31,1) | 26,1 – 32,2 | — |
| Parc moyen d’entreprises (après la chauffe) | après chauffe | — | 22,5 | 0,6 (22,3 – 22,9) | 22,3 – 23,5 | — |
| Part de la plus grande entreprise (médiane des biens) | après chauffe | — | 100,0 % | 0,0 pt (100,0 % – 100,0 %) | 100,0 % – 100,0 % | — |
| Herfindahl des ventes (médiane des biens) | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Fermetures : prix aberrant | toute la partie | — | 7 | 1,5 (6,3 – 7,8) | 5 – 10 | — |
| Fermetures : faillite (salaires impayables) | toute la partie | — | 10,5 | 2,5 (9,3 – 11,8) | 7 – 12 | — |
| Fermetures : demande perdue | toute la partie | — | 0 | 0 (0 – 0) | 0 – 1 | — |
| Fermetures : sans employé (départs, postes non pourvus) | toute la partie | — | 1 | 0,8 (0,3 – 1) | 0 – 1 | — |
| Fermetures : autre | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Morts d’entreprises / an | toute la partie | — | 6,6 | 0,8 (6,3 – 7,1) | 5,8 – 7,3 | — |
| Entonnoir : projets envisagés | toute la partie | — | 5625,5 | 200,8 (5530,8 – 5731,5) | 5157 – 6446 | — |
| Entonnoir : créations | toute la partie | — | 8 | 2,8 (6,3 – 9) | 6 – 10 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 23,5 | 9,5 (21 – 30,5) | 19 – 40 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 357 | 103 (266,5 – 369,5) | 154 – 427 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 1068,5 | 384,5 (891,3 – 1275,8) | 658 – 1296 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 1556 | 353 (1447,8 – 1800,8) | 995 – 1950 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 36 | 213,8 (1,5 – 215,3) | 1 – 472 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 2605 | 370 (2440,3 – 2810,3) | 1978 – 3128 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 20,5 | 1,8 (19,3 – 21) | 19 – 22 | — |
| Machines en fin | dernier jour | — | 19,3 | 4,0 (16,2 – 20,2) | 11,3 – 23,3 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 3 | 0 (3 – 3) | 2 – 5 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,004 (0,97 – 0,97) | 0,96 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,4 | 0,01 (0,4 – 0,4) | 0,3 – 0,4 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 37 917 $ | 40 117 $ (18 081 $ – 58 198 $) | 15 282 $ – 87 776 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/6 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 10,83 | 2,81 (10,22 – 13,03) | 9,72 – 15,11 | 6/6 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,17 | 8,13 (0,00 – 8,13) | 0,00 – 36,67 | 2/6 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/6 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/6 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/6 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/6 | 2 | pas de producteur (100 %) |
| Renflouement d’entreprise | 10,83 | 10,22 – 13,03 | 9,72 – 15,11 | 6/6 | 1525 | par le propriétaire (95 %) ; après rachat (5 %) |
| Plancher de logement | 0,17 | 0,00 – 8,13 | 0,00 – 36,67 | 2/6 | 1625 | prix trop élevé (53 %) ; parc plein (47 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/6 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/6 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 6 graines · graines touchées) : Ferme 295 · 6, Bijouterie 279 · 6, Mine de fer 182 · 6, Tourisme 131 · 3, Fonderie 124 · 6, Pêcherie 70 · 6, Mine de bauxite 44 · 6, Mine de cuivre 43 · 6.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 14,7 % | 26,7 % | 0,0 % | 0,0 % | 0,28 | 0,093 % | 124 (9) | 0,88 | 3 % / 18 % / 79 % | 0 | 0 $ |
| 2 | 9,1 % | 24,2 % | 0,0 % | 0,0 % | 0,20 | 0,048 % | 98 (4) | 0,88 | 3 % / 17 % / 80 % | 0 | 0 $ |
| 3 | 8,0 % | 17,1 % | 0,0 % | 0,3 % | 0,20 | 0,042 % | 111 (6) | 0,88 | 6 % / 15 % / 79 % | 0 | 5 639 $ |
| 4 | 12,7 % | 27,9 % | 0,0 % | 0,7 % | 0,21 | 0,097 % | 145 (14) | 0,88 | 6 % / 13 % / 81 % | 0 | 4 311 $ |
| 5 | 10,3 % | 22,1 % | 0,0 % | 0,0 % | 0,19 | 0,158 % | 100 (7) | 0,88 | 6 % / 12 % / 82 % | 1 | 1 720 $ |
| 6 | 5,9 % | 16,3 % | 0,0 % | 0,0 % | 0,16 | 0,039 % | 113 (9) | 0,88 | 6 % / 12 % / 81 % | 0 | 12 534 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 6/6 : g1 25, g2 25, g3 21, g4 23, g5 15, g6 12 |
| Chômage moyen ≤ 10 % | ❌ | 1/6 : g1 12,7 % |
| Faim et sans-abri < 2 % | ❌ | 6/6 : g1, g2, g3, g4, g5, g6 |
| Gini 0,2–0,45 | ✅ | aucune graine sur 6 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 6 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 6 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Renflouement d’entreprise : 6/6 graines ; Plancher de logement : 2/6 graines |

