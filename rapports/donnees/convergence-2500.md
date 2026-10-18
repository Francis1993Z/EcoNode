# Protocole de stabilité ÉcoNodes

- Date : 2026-10-18 12:29
- Graines : 1 à 10 (10) · 1000 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1000), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1000). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- Paramètres changés : population = 2500
- Temps total : 3 min 42 s pour 20 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 24,6 % | 13,7 pt (16,5 % – 30,2 %) | 10,7 % – 39,5 % | 10/10 |
| Chômage max | toute la partie | — | 48,3 % | 22,4 pt (40,3 % – 62,7 %) | 26,4 % – 66,0 % | — |
| Faim moyenne | après chauffe | < 2 % | 1,0 % | 4,5 pt (0,1 % – 4,7 %) | 0,0 % – 11,2 % | 4/10 |
| Faim max | toute la partie | — | 36,2 % | 34,2 pt (17,8 % – 51,9 %) | 10,5 % – 69,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 6,2 % | 10,1 pt (0,9 % – 11,1 %) | 0,4 % – 21,2 % | 6/10 |
| Sans-abri max | toute la partie | — | 54,6 % | 9,4 pt (52,3 % – 61,7 %) | 47,7 % – 67,1 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,69 | 0,16 (0,58 – 0,74) | 0,51 – 0,80 | 10/10 |
| Gini en fin de partie | dernier jour | — | 0,88 | 0,15 (0,80 – 0,95) | 0,49 – 1,00 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,012 % | 0,052 pt (-0,035 % – 0,017 %) | -0,122 % – 0,060 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 80,6 % | 73,0 pt (28,3 % – 101,3 %) | 17,4 % – 179,3 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,1 % | 5,8 pt (140,7 % – 146,5 %) | 94,5 % – 247,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 48 | 17,3 (40 – 57,3) | 22 – 77 | 10/10 |
| … dont après la chauffe | après chauffe | — | 45 | 17,8 (34,5 – 52,3) | 20 – 69 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 732 | 1041,8 (255 – 1296,8) | 90 – 2050 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 1455 | 56,3 (1437 – 1493,3) | 1346 – 1548 | — |
| Santé moyenne | après chauffe | — | 0,68 | 0,25 (0,62 – 0,87) | 0,44 – 0,88 | — |
| Naissances d’entreprises / an | toute la partie | — | 9,1 | 1,9 (7,9 – 9,9) | 6,6 – 12,8 | — |
| Naissances / an, en % du parc moyen | toute la partie | — | 8,5 | 2,1 (7,0 – 9,0) | 5,7 – 11,4 | — |
| Morts / an, en % du parc moyen | toute la partie | — | 82,3 | 9,1 (77,0 – 86,1) | 72,9 – 96,5 | — |
| Parc moyen d’entreprises (après la chauffe) | après chauffe | — | 112,2 | 3,4 (111,2 – 114,6) | 103,3 – 116,2 | — |
| Demande non servie (part des unités demandées) | après chauffe | — | 9,8 % | 11,4 pt (1,8 % – 13,1 %) | 0,6 % – 23,7 % | — |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | après chauffe | — | 14,4 % | 3,7 pt (12,3 % – 16,0 %) | 10,5 % – 20,7 % | — |
| Part de la plus grande entreprise (médiane des biens) | après chauffe | — | 97,1 % | 1,2 pt (96,3 % – 97,6 %) | 94,7 % – 98,0 % | — |
| Herfindahl des ventes (médiane des biens) | après chauffe | — | 0,96 | 0,01 (0,95 – 0,97) | 0,93 – 0,97 | — |
| Fermetures : prix aberrant | toute la partie | — | 27,5 | 11,8 (21,3 – 33) | 20 – 36 | — |
| Fermetures : faillite (salaires impayables) | toute la partie | — | 206,5 | 17,5 (193,3 – 210,8) | 182 – 218 | — |
| Fermetures : demande perdue | toute la partie | — | 4 | 1,8 (3 – 4,8) | 2 – 7 | — |
| Fermetures : sans employé (départs, postes non pourvus) | toute la partie | — | 16,5 | 4,8 (16 – 20,8) | 13 – 27 | — |
| Fermetures : autre | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Morts d’entreprises / an | toute la partie | — | 92,9 | 6,8 (87,7 – 94,5) | 84,7 – 99,6 | — |
| Entonnoir : projets envisagés | toute la partie | — | 6333,5 | 432,3 (6218,8 – 6651) | 5408 – 7751 | — |
| Entonnoir : créations | toute la partie | — | 25 | 5,3 (21,8 – 27) | 18 – 35 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 123,5 | 39,3 (94,8 – 134) | 83 – 210 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 1169,5 | 370,5 (970,3 – 1340,8) | 833 – 1535 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 3768,5 | 186 (3744,5 – 3930,5) | 3398 – 4221 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 874,5 | 138 (823,8 – 961,8) | 679 – 1433 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 311 | 171,3 (226 – 397,3) | 142 – 972 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 27,5 | 5,8 (24 – 29,8) | 20 – 30 | — |
| Machines en fin | dernier jour | — | 686,4 | 1052,8 (513,6 – 1566,4) | 102,5 – 2686,0 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 19 | 8,8 (13,5 – 22,3) | 7 – 33 | — |
| Bonheur moyen | après chauffe | — | 0,89 | 0,13 (0,82 – 0,95) | 0,70 – 0,97 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 55,0 | 71,9 (3,0 – 74,9) | 0,1 – 169,4 | — |
| Jours de prestations réduites | après chauffe | — | 179,5 | 343,5 (19 – 362,5) | 0 – 583 | — |
| Trésor de l’État le plus bas | après chauffe | — | 31 928 $ | 13 823 $ (25 122 $ – 38 945 $) | 20 291 $ – 739 669 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 182 910 $ | 32 846 $ (165 011 $ – 197 857 $) | 109 020 $ – 244 412 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 7/10 | 1 | 0,3 – 2 | 0 – 3 | 206,5 j |
| Faim répandue | critique | 10/10 | 3 | 2,3 – 4 | 1 – 6 | 38,5 j |
| Sans-abri nombreux | critique | 10/10 | 6 | 3,3 – 12,8 | 1 – 14 | 298 j |
| Inégalités hors bornes | attention | 10/10 | 1 | 1 – 1,8 | 1 – 2 | 639,5 j |
| Richesse médiane hors bornes | attention | 6/10 | 1 | 0 – 1 | 0 – 3 | 11,5 j |
| Inflation quotidienne | critique | 10/10 | 34,5 | 28,3 – 41,3 | 7 – 55 | 42 j |
| Inflation sur 100 jours | critique | 9/10 | 1,5 | 1 – 2,8 | 0 – 6 | 24,5 j |
| Rupture de stock prolongée | attention | 10/10 | 203,5 | 200,5 – 209,8 | 196 – 226 | 4670,5 j |
| Surstock | attention | 10/10 | 248,5 | 246,3 – 252 | 237 – 265 | 13831,5 j |
| Entreprise sans employé | attention | 10/10 | 336,5 | 311 – 339,8 | 271 – 350 | 9169 j |
| Entreprise sans client | attention | 10/10 | 568,5 | 548,8 – 591,5 | 523 – 630 | 29537,5 j |
| Santé de la population effondrée | critique | 6/10 | 1 | 0 – 1 | 0 – 2 | 205,5 j |
| Productivité du travail effondrée | attention | 6/10 | 1 | 0 – 1 | 0 – 2 | 208,5 j |
| Pénurie de main-d’œuvre | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 16,5 j |
| Embauches bloquées faute de moyens | attention | 9/10 | 2 | 1,3 – 2 | 0 – 3 | 302,5 j |
| Prix aberrant | attention | 10/10 | 52 | 43,5 – 67 | 28 – 81 | 9830,5 j |
| Attente trop longue (service public) | attention | 8/10 | 2 | 2 – 2 | 0 – 3 | 566 j |
| Prestations réduites faute de trésor | attention | 8/10 | 1 | 1 – 1,8 | 0 – 3 | 179,5 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 26,1 % | 46,1 % | 0,0 % | 8,2 % | 0,69 | -0,035 % | 1548 (47) | 0,64 | 11 % / 26 % / 62 % | 23 | 0 $ |
| 2 | 39,5 % | 61,7 % | 6,6 % | 21,2 % | 0,80 | -0,001 % | 1446 (29) | 0,44 | 17 % / 33 % / 49 % | 22 | 5 070 $ |
| 3 | 10,7 % | 26,4 % | 0,1 % | 0,4 % | 0,54 | -0,052 % | 1434 (46) | 0,88 | 4 % / 10 % / 85 % | 1 | 2 566 $ |
| 4 | 37,0 % | 63,4 % | 11,2 % | 14,2 % | 0,76 | 0,022 % | 1419 (49) | 0,55 | 7 % / 31 % / 62 % | 22 | 0 $ |
| 5 | 30,5 % | 63,0 % | 2,1 % | 11,3 % | 0,74 | 0,023 % | 1536 (77) | 0,62 | 14 % / 30 % / 56 % | 3 | 0 $ |
| 6 | 22,7 % | 41,2 % | 0,2 % | 4,3 % | 0,69 | -0,122 % | 1461 (58) | 0,87 | 5 % / 22 % / 73 % | 1 | 0 $ |
| 7 | 14,4 % | 50,6 % | 1,7 % | 0,7 % | 0,51 | -0,022 % | 1504 (66) | 0,87 | 10 % / 27 % / 63 % | 23 | 51 147 $ |
| 8 | 23,1 % | 40,0 % | 0,2 % | 1,6 % | 0,67 | 0,002 % | 1454 (22) | 0,73 | 8 % / 17 % / 75 % | 1 | 0 $ |
| 9 | 29,4 % | 66,0 % | 5,5 % | 10,5 % | 0,73 | 0,060 % | 1456 (55) | 0,64 | 9 % / 36 % / 56 % | 23 | 1 775 $ |
| 10 | 11,9 % | 30,4 % | 0,1 % | 0,6 % | 0,54 | -0,034 % | 1346 (38) | 0,88 | 6 % / 13 % / 81 % | 1 | 33 662 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 18,2 % | 11,3 pt (11,0 % – 22,3 %) | 8,5 % – 25,2 % | 8/10 |
| Chômage max | toute la partie | — | 36,7 % | 12,2 pt (26,8 % – 39,1 %) | 19,9 % – 54,2 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,01 pt (0,0 % – 0,0 %) | 0,0 % – 1,2 % | 0/10 |
| Faim max | toute la partie | — | 12,4 % | 4,3 pt (10,7 % – 14,9 %) | 2,2 % – 36,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 1,0 % | 1,6 pt (0,6 % – 2,2 %) | 0,2 % – 3,0 % | 3/10 |
| Sans-abri max | toute la partie | — | 47,2 % | 5,4 pt (45,8 % – 51,2 %) | 41,9 % – 53,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,55 | 0,17 (0,45 – 0,61) | 0,32 – 0,64 | 7/10 |
| Gini en fin de partie | dernier jour | — | 0,59 | 0,24 (0,44 – 0,68) | 0,11 – 0,83 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,058 % | 0,036 pt (-0,069 % – -0,033 %) | -0,109 % – 0,029 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 24,8 % | 30,8 pt (19,9 % – 50,7 %) | 11,6 % – 82,5 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 142,6 % | 5,0 pt (142,0 % – 147,0 %) | 123,6 % – 396,6 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 38,5 | 15,5 (30,3 – 45,8) | 19 – 68 | 10/10 |
| … dont après la chauffe | après chauffe | — | 33,5 | 15,8 (26 – 41,8) | 16 – 62 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 211,5 | 294,5 (168,3 – 462,8) | 114 – 610 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 1329 | 59,8 (1316,8 – 1376,5) | 1293 – 1398 | — |
| Santé moyenne | après chauffe | — | 0,86 | 0,11 (0,78 – 0,88) | 0,71 – 0,88 | — |
| Naissances d’entreprises / an | toute la partie | — | 4,6 | 2,3 (3,5 – 5,7) | 2,6 – 6,6 | — |
| Naissances / an, en % du parc moyen | toute la partie | — | 3,7 | 1,9 (2,8 – 4,7) | 2,2 – 5,5 | — |
| Morts / an, en % du parc moyen | toute la partie | — | 69,2 | 2,3 (67,5 – 69,8) | 65,5 – 73,6 | — |
| Parc moyen d’entreprises (après la chauffe) | après chauffe | — | 122,0 | 2,2 (120,8 – 122,9) | 117,7 – 123,8 | — |
| Demande non servie (part des unités demandées) | après chauffe | — | 1,6 % | 5,1 pt (0,4 % – 5,5 %) | 0,2 % – 8,3 % | — |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | après chauffe | — | 22,3 % | 2,4 pt (21,6 % – 24,0 %) | 19,9 % – 24,7 % | — |
| Part de la plus grande entreprise (médiane des biens) | après chauffe | — | 97,3 % | 0,8 pt (97,0 % – 97,8 %) | 96,5 % – 98,0 % | — |
| Herfindahl des ventes (médiane des biens) | après chauffe | — | 0,96 | 0,01 (0,96 – 0,97) | 0,95 – 0,97 | — |
| Fermetures : prix aberrant | toute la partie | — | 36,5 | 3,8 (34 – 37,8) | 31 – 45 | — |
| Fermetures : faillite (salaires impayables) | toute la partie | — | 153 | 5 (151 – 156) | 143 – 174 | — |
| Fermetures : demande perdue | toute la partie | — | 12 | 4,3 (9,5 – 13,8) | 6 – 20 | — |
| Fermetures : sans employé (départs, postes non pourvus) | toute la partie | — | 27 | 4,3 (23,8 – 28) | 17 – 36 | — |
| Fermetures : autre | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Morts d’entreprises / an | toute la partie | — | 84,1 | 2,6 (82,6 – 85,1) | 81,0 – 87,6 | — |
| Entonnoir : projets envisagés | toute la partie | — | 5335 | 599 (5115,5 – 5714,5) | 4717 – 6018 | — |
| Entonnoir : créations | toute la partie | — | 12,5 | 6,3 (9,5 – 15,8) | 7 – 18 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 54,5 | 24,3 (49,8 – 74) | 29 – 87 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 580 | 283,3 (406 – 689,3) | 320 – 864 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 3972 | 436,3 (3787 – 4223,3) | 3663 – 4311 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 582,5 | 287,5 (311,3 – 598,8) | 189 – 882 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 230,5 | 143,3 (169 – 312,3) | 128 – 377 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 29 | 2 (28 – 30) | 25 – 30 | — |
| Machines en fin | dernier jour | — | 1438,2 | 1071,3 (1012,1 – 2083,4) | 432,8 – 2953,7 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 21 | 6,8 (20 – 26,8) | 11 – 29 | — |
| Bonheur moyen | après chauffe | — | 0,95 | 0,05 (0,92 – 0,97) | 0,90 – 0,97 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 5,2 | 28,1 (0,1 – 28,2) | 0,1 – 49,8 | — |
| Jours de prestations réduites | après chauffe | — | 35,5 | 125,8 (0 – 125,8) | 0 – 174 | — |
| Trésor de l’État le plus bas | après chauffe | — | 41 480 $ | 639 321 $ (39 902 $ – 679 223 $) | 15 302 $ – 981 777 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 112 363 $ | 41 506 $ (102 484 $ – 143 991 $) | 93 825 $ – 154 886 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 179,56 | 2/10 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 38,14 | 10,39 (35,72 – 46,11) | 32,61 – 47,28 | 10/10 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 198,53 | 360,08 (118,90 – 478,99) | 75,67 – 771,61 | 10/10 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 179,56 | 2/10 | 3534 | prix trop élevé (92 %) ; pas de producteur (8 %) |
| Renflouement d’entreprise | 38,14 | 35,72 – 46,11 | 32,61 – 47,28 | 10/10 | 13426 | par le propriétaire (86 %) ; après rachat (14 %) |
| Plancher de logement | 198,53 | 118,90 – 478,99 | 75,67 – 771,61 | 10/10 | 100414 | prix trop élevé (54 %) ; parc plein (46 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 10 graines · graines touchées) : Ingénierie pétrolière 1750 · 10, Hôtel 992 · 10, Ferme 694 · 10, Marketing 338 · 10, Pêcherie 323 · 10, Boulangerie 322 · 10, Garage 320 · 10, Comptabilité 316 · 10.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 25,2 % | 39,6 % | 0,0 % | 3,0 % | 0,64 | -0,058 % | 1334 (31) | 0,71 | 6 % / 17 % / 77 % | 3 | 994 $ |
| 2 | 10,6 % | 19,9 % | 0,0 % | 0,9 % | 0,50 | -0,057 % | 1387 (30) | 0,88 | 4 % / 10 % / 86 % | 6 | 0 $ |
| 3 | 23,7 % | 36,8 % | 0,0 % | 1,5 % | 0,60 | 0,001 % | 1310 (19) | 0,75 | 7 % / 14 % / 79 % | 6 | 0 $ |
| 4 | 23,5 % | 43,9 % | 0,0 % | 2,6 % | 0,63 | -0,094 % | 1345 (20) | 0,76 | 5 % / 17 % / 78 % | 2 | 1 635 $ |
| 5 | 8,5 % | 24,8 % | 0,0 % | 0,3 % | 0,32 | -0,042 % | 1388 (58) | 0,88 | 4 % / 10 % / 86 % | 2 | 38 416 $ |
| 6 | 9,9 % | 21,7 % | 0,0 % | 0,5 % | 0,48 | -0,058 % | 1293 (42) | 0,88 | 5 % / 12 % / 84 % | 2 | 0 $ |
| 7 | 12,4 % | 36,5 % | 0,2 % | 0,2 % | 0,36 | -0,030 % | 1316 (68) | 0,88 | 10 % / 12 % / 78 % | 21 | 52 526 $ |
| 8 | 18,7 % | 54,2 % | 1,2 % | 2,4 % | 0,44 | 0,029 % | 1319 (47) | 0,81 | 12 % / 27 % / 62 % | 21 | 0 $ |
| 9 | 17,8 % | 33,0 % | 0,0 % | 0,8 % | 0,62 | -0,109 % | 1324 (41) | 0,88 | 4 % / 10 % / 86 % | 2 | 5 090 $ |
| 10 | 18,6 % | 37,5 % | 0,0 % | 1,1 % | 0,61 | -0,073 % | 1398 (36) | 0,84 | 5 % / 17 % / 78 % | 0 | 29 007 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 10/10 : g1 47, g2 29, g3 46, g4 49, g5 77, g6 58, g7 66, g8 22, … |
| Chômage moyen ≤ 10 % | ❌ | 10/10 : g1 26,1 %, g2 39,5 %, g3 10,7 %, g4 37,0 %, g5 30,5 %, g6 22,7 %, g7 14,4 %, g8 23,1 %, … |
| Faim et sans-abri < 2 % | ❌ | 6/10 : g1, g2, g4, g5, g6, g9 |
| Gini 0,2–0,45 | ❌ | 10/10 : g1 0,69, g2 0,80, g3 0,54, g4 0,76, g5 0,74, g6 0,69, g7 0,51, g8 0,67, … |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 10 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 10 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 2/10 graines ; Renflouement d’entreprise : 10/10 graines ; Plancher de logement : 10/10 graines |

