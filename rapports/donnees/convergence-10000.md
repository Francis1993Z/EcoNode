# Protocole de stabilité ÉcoNodes

- Date : 2026-10-18 15:13
- Graines : 1 à 10 (10) · 1000 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1000), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1000). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- Paramètres changés : population = 10000
- Temps total : 15 min 8 s pour 20 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 21,6 % | 6,0 pt (20,6 % – 26,6 %) | 12,5 % – 27,5 % | 10/10 |
| Chômage max | toute la partie | — | 32,7 % | 11,8 pt (29,5 % – 41,4 %) | 24,5 % – 42,4 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,2 % | 0,1 pt (0,2 % – 0,3 %) | 0,1 % – 0,4 % | 0/10 |
| Faim max | toute la partie | — | 8,0 % | 3,1 pt (6,6 % – 9,7 %) | 4,2 % – 10,8 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 3,7 % | 1,6 pt (3,3 % – 4,9 %) | 1,1 % – 8,1 % | 9/10 |
| Sans-abri max | toute la partie | — | 42,3 % | 4,8 pt (39,6 % – 44,4 %) | 35,1 % – 49,1 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,68 | 0,03 (0,66 – 0,69) | 0,57 – 0,72 | 10/10 |
| Gini en fin de partie | dernier jour | — | 0,89 | 0,07 (0,86 – 0,93) | 0,57 – 0,98 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,048 % | 0,017 pt (-0,057 % – -0,041 %) | -0,080 % – -0,017 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 10,9 % | 1,4 pt (9,7 % – 11,1 %) | 8,8 % – 23,2 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 139,2 % | 6,1 pt (133,5 % – 139,6 %) | 124,6 % – 140,2 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 25,5 | 5,5 (23 – 28,5) | 12 – 34 | 10/10 |
| … dont après la chauffe | après chauffe | — | 23 | 5 (20,3 – 25,3) | 9 – 30 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 325 | 314,5 (218 – 532,5) | 105 – 808 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 5672 | 192,3 (5602,8 – 5795) | 5584 – 5845 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,01 (0,87 – 0,88) | 0,80 – 0,88 | — |
| Naissances d’entreprises / an | toute la partie | — | 4,6 | 1,6 (3,8 – 5,4) | 2,6 – 6,9 | — |
| Naissances / an, en % du parc moyen | toute la partie | — | 1,0 | 0,3 (0,8 – 1,2) | 0,6 – 1,6 | — |
| Morts / an, en % du parc moyen | toute la partie | — | 76,1 | 2,4 (75,5 – 78,0) | 75,3 – 80,2 | — |
| Parc moyen d’entreprises (après la chauffe) | après chauffe | — | 458,6 | 9,1 (451,4 – 460,4) | 443,0 – 461,1 | — |
| Demande non servie (part des unités demandées) | après chauffe | — | 0,4 % | 0,5 pt (0,3 % – 0,8 %) | 0,2 % – 4,4 % | — |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | après chauffe | — | 19,0 % | 6,1 pt (15,5 % – 21,5 %) | 12,8 % – 27,9 % | — |
| Part de la plus grande entreprise (médiane des biens) | après chauffe | — | 89,3 % | 1,2 pt (88,7 % – 89,8 %) | 87,8 % – 90,8 % | — |
| Herfindahl des ventes (médiane des biens) | après chauffe | — | 0,87 | 0,02 (0,86 – 0,88) | 0,85 – 0,89 | — |
| Fermetures : prix aberrant | toute la partie | — | 64,5 | 7,8 (59,3 – 67) | 50 – 76 | — |
| Fermetures : faillite (salaires impayables) | toute la partie | — | 800 | 21 (786,8 – 807,8) | 784 – 812 | — |
| Fermetures : demande perdue | toute la partie | — | 17 | 3,8 (14,3 – 18) | 10 – 23 | — |
| Fermetures : sans employé (départs, postes non pourvus) | toute la partie | — | 80,5 | 7,3 (77,5 – 84,8) | 73 – 98 | — |
| Fermetures : autre | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Morts d’entreprises / an | toute la partie | — | 350,4 | 4,2 (347,7 – 351,9) | 345,7 – 355,5 | — |
| Entonnoir : projets envisagés | toute la partie | — | 5892,5 | 395,3 (5650,3 – 6045,5) | 5027 – 6639 | — |
| Entonnoir : créations | toute la partie | — | 12,5 | 4,3 (10,5 – 14,8) | 7 – 19 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 60 | 18,5 (46,5 – 65) | 32 – 110 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 520 | 220 (452,3 – 672,3) | 343 – 864 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 4889,5 | 341,5 (4641 – 4982,5) | 4145 – 5156 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 274,5 | 111,8 (234,3 – 346) | 148 – 613 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 103,5 | 40 (75,8 – 115,8) | 33 – 270 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 30 | 0,8 (29,3 – 30) | 28 – 31 | — |
| Machines en fin | dernier jour | — | 12576,2 | 4948,5 (9224,3 – 14172,9) | 6515,8 – 15976,6 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 127 | 67 (70,8 – 137,8) | 56 – 142 | — |
| Bonheur moyen | après chauffe | — | 0,94 | 0,02 (0,92 – 0,94) | 0,89 – 0,96 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,1 | 1,0 (0,1 – 1,1) | 0,0 – 13,5 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 22 (0 – 22) | 0 – 188 | — |
| Trésor de l’État le plus bas | après chauffe | — | 2 261 311 $ | 2 603 162 $ (138 775 $ – 2 741 936 $) | 132 188 $ – 3 252 651 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 665 619 $ | 93 813 $ (653 004 $ – 746 817 $) | 612 020 $ – 983 025 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 4/10 | 0 | 0 – 1 | 0 – 1 | 0 j |
| Faim répandue | critique | 7/10 | 1 | 0,3 – 1 | 0 – 1 | 3,5 j |
| Sans-abri nombreux | critique | 10/10 | 7 | 6 – 10,8 | 5 – 12 | 219,5 j |
| Inégalités hors bornes | attention | 10/10 | 1 | 1 – 1 | 1 – 5 | 646,5 j |
| Richesse médiane hors bornes | attention | 1/10 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Inflation quotidienne | critique | 10/10 | 15,5 | 14 – 17,8 | 3 – 20 | 20,5 j |
| Inflation sur 100 jours | critique | 10/10 | 1 | 1 – 1,8 | 1 – 2 | 26 j |
| Rupture de stock prolongée | attention | 10/10 | 919 | 906,3 – 940,3 | 877 – 1016 | 19890 j |
| Surstock | attention | 10/10 | 1037 | 1029,3 – 1077,8 | 1014 – 1116 | 54715 j |
| Entreprise sans employé | attention | 10/10 | 1227 | 1216,3 – 1272,8 | 1188 – 1302 | 18626,5 j |
| Entreprise sans client | attention | 10/10 | 2319,5 | 2263,3 – 2347 | 2147 – 2471 | 123323,5 j |
| Santé de la population effondrée | critique | 2/10 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Productivité du travail effondrée | attention | 2/10 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Pénurie de main-d’œuvre | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 19 j |
| Embauches bloquées faute de moyens | attention | 3/10 | 0 | 0 – 0,8 | 0 – 1 | 0 j |
| Prix aberrant | attention | 10/10 | 138,5 | 131,3 – 144,8 | 120 – 188 | 34919 j |
| Attente trop longue (service public) | attention | 3/10 | 0 | 0 – 1,5 | 0 – 2 | 0 j |
| Prestations réduites faute de trésor | attention | 4/10 | 0 | 0 – 1 | 0 – 1 | 0 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 21,2 % | 27,6 % | 0,2 % | 3,2 % | 0,66 | -0,057 % | 5671 (32) | 0,88 | 5 % / 21 % / 73 % | 5 | 0 $ |
| 2 | 21,5 % | 29,8 % | 0,4 % | 6,0 % | 0,69 | -0,080 % | 5584 (23) | 0,88 | 6 % / 19 % / 76 % | 4 | 1 210 $ |
| 3 | 12,5 % | 24,5 % | 0,1 % | 1,1 % | 0,57 | -0,057 % | 5845 (25) | 0,88 | 4 % / 14 % / 82 % | 5 | 0 $ |
| 4 | 26,7 % | 42,4 % | 0,2 % | 5,0 % | 0,69 | -0,035 % | 5584 (23) | 0,84 | 7 % / 20 % / 73 % | 89 | 7 380 $ |
| 5 | 20,4 % | 29,5 % | 0,3 % | 3,5 % | 0,66 | -0,043 % | 5673 (29) | 0,88 | 5 % / 19 % / 76 % | 7 | 0 $ |
| 6 | 20,4 % | 29,7 % | 0,2 % | 2,0 % | 0,68 | -0,040 % | 5802 (26) | 0,88 | 5 % / 19 % / 76 % | 2 | 0 $ |
| 7 | 27,5 % | 41,6 % | 0,3 % | 8,1 % | 0,72 | -0,017 % | 5823 (27) | 0,80 | 9 % / 27 % / 63 % | 90 | 6 953 $ |
| 8 | 26,0 % | 42,1 % | 0,2 % | 3,8 % | 0,69 | -0,042 % | 5620 (12) | 0,88 | 6 % / 19 % / 75 % | 80 | 20 030 $ |
| 9 | 26,7 % | 40,6 % | 0,2 % | 4,3 % | 0,71 | -0,052 % | 5597 (34) | 0,87 | 6 % / 18 % / 75 % | 88 | 6 649 $ |
| 10 | 21,7 % | 35,6 % | 0,2 % | 3,6 % | 0,67 | -0,072 % | 5774 (18) | 0,88 | 6 % / 24 % / 70 % | 10 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 26,0 % | 4,1 pt (23,9 % – 27,9 %) | 19,7 % – 28,6 % | 10/10 |
| Chômage max | toute la partie | — | 39,3 % | 3,2 pt (37,7 % – 40,9 %) | 35,1 % – 51,4 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,4 % | 0,1 pt (0,4 % – 0,4 %) | 0,3 % – 0,6 % | 0/10 |
| Faim max | toute la partie | — | 8,1 % | 2,3 pt (7,4 % – 9,6 %) | 5,8 % – 10,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 4,8 % | 1,6 pt (4,3 % – 5,9 %) | 2,7 % – 6,6 % | 10/10 |
| Sans-abri max | toute la partie | — | 40,7 % | 3,8 pt (38,9 % – 42,6 %) | 35,6 % – 44,1 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,70 | 0,05 (0,66 – 0,71) | 0,63 – 0,72 | 10/10 |
| Gini en fin de partie | dernier jour | — | 0,93 | 0,04 (0,91 – 0,96) | 0,85 – 0,98 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,061 % | 0,030 pt (-0,068 % – -0,038 %) | -0,075 % – -0,029 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 16,8 % | 8,6 pt (13,6 % – 22,2 %) | 8,9 % – 38,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 146,5 % | 3,3 pt (144,9 % – 148,3 %) | 141,5 % – 153,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 44 | 10,8 (39 – 49,8) | 34 – 51 | 10/10 |
| … dont après la chauffe | après chauffe | — | 41 | 12,5 (34,3 – 46,8) | 31 – 48 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 599 | 462,5 (438,8 – 901,3) | 252 – 1152 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 5532 | 150,8 (5447,5 – 5598,3) | 5399 – 5641 | — |
| Santé moyenne | après chauffe | — | 0,86 | 0,05 (0,83 – 0,88) | 0,76 – 0,88 | — |
| Naissances d’entreprises / an | toute la partie | — | 2,9 | 0,9 (2,3 – 3,2) | 2,2 – 5,1 | — |
| Naissances / an, en % du parc moyen | toute la partie | — | 0,6 | 0,2 (0,5 – 0,7) | 0,4 – 1,1 | — |
| Morts / an, en % du parc moyen | toute la partie | — | 72,1 | 1,6 (70,9 – 72,5) | 68,5 – 75,1 | — |
| Parc moyen d’entreprises (après la chauffe) | après chauffe | — | 481,7 | 6,7 (478,9 – 485,6) | 473,1 – 496,3 | — |
| Demande non servie (part des unités demandées) | après chauffe | — | 1,4 % | 2,4 pt (0,3 % – 2,8 %) | 0,3 % – 6,0 % | — |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | après chauffe | — | 26,0 % | 4,7 pt (24,5 % – 29,2 %) | 21,8 % – 36,8 % | — |
| Part de la plus grande entreprise (médiane des biens) | après chauffe | — | 87,7 % | 1,5 pt (87,3 % – 88,8 %) | 86,6 % – 90,0 % | — |
| Herfindahl des ventes (médiane des biens) | après chauffe | — | 0,85 | 0,02 (0,85 – 0,87) | 0,84 – 0,88 | — |
| Fermetures : prix aberrant | toute la partie | — | 101,5 | 15,8 (92 – 107,8) | 90 – 119 | — |
| Fermetures : faillite (salaires impayables) | toute la partie | — | 698,5 | 10 (694 – 704) | 678 – 713 | — |
| Fermetures : demande perdue | toute la partie | — | 44,5 | 9 (41,3 – 50,3) | 36 – 55 | — |
| Fermetures : sans employé (départs, postes non pourvus) | toute la partie | — | 104,5 | 6,5 (103 – 109,5) | 90 – 120 | — |
| Fermetures : autre | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Morts d’entreprises / an | toute la partie | — | 346,0 | 5,9 (344,0 – 349,9) | 339,8 – 355,5 | — |
| Entonnoir : projets envisagés | toute la partie | — | 5790,5 | 410,8 (5480 – 5890,8) | 5346 – 6009 | — |
| Entonnoir : créations | toute la partie | — | 8 | 2,5 (6,3 – 8,8) | 6 – 14 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 35,5 | 16,3 (25,3 – 41,5) | 21 – 55 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 409,5 | 111,3 (320,5 – 431,8) | 257 – 567 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 4855,5 | 372 (4681,5 – 5053,5) | 4559 – 5109 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 317 | 101,8 (232,5 – 334,3) | 130 – 380 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 130 | 22,5 (122,8 – 145,3) | 73 – 200 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 28 | 1,8 (28 – 29,8) | 28 – 31 | — |
| Machines en fin | dernier jour | — | 8590,3 | 2465,1 (8144,6 – 10609,6) | 4907,6 – 12331,0 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 81 | 51,3 (73,5 – 124,8) | 62 – 149 | — |
| Bonheur moyen | après chauffe | — | 0,92 | 0,02 (0,91 – 0,93) | 0,88 – 0,95 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 2,3 | 6,6 (0,1 – 6,7) | 0,0 – 25,0 | — |
| Jours de prestations réduites | après chauffe | — | 57 | 64 (6,3 – 70,3) | 0 – 146 | — |
| Trésor de l’État le plus bas | après chauffe | — | 134 051 $ | 379 499 $ (125 362 $ – 504 861 $) | 100 382 $ – 1 965 167 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 700 298 $ | 102 702 $ (662 474 $ – 765 176 $) | 550 604 $ – 887 535 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,58 | 1,42 (0,22 – 1,64) | 0,00 – 3,67 | 3/10 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 147,31 | 15,38 (136,42 – 151,79) | 117,67 – 163,22 | 10/10 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 4221,25 | 2060,53 (2618,40 – 4678,93) | 1298,50 – 6405,33 | 10/10 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,58 | 0,22 – 1,64 | 0,00 – 3,67 | 3/10 | 505 | pas de producteur (62 %) ; pas de revenu (29 %) |
| Renflouement d’entreprise | 147,31 | 136,42 – 151,79 | 117,67 – 163,22 | 10/10 | 53169 | par le propriétaire (84 %) ; après rachat (16 %) |
| Plancher de logement | 4221,25 | 2618,40 – 4678,93 | 1298,50 – 6405,33 | 10/10 | 797859 | prix trop élevé (73 %) ; parc plein (27 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 10 graines · graines touchées) : Ingénierie pétrolière 5695 · 10, Ferme 2245 · 10, Hôtel 1972 · 10, Comptabilité 1828 · 10, Pétrochimie 1484 · 10, Boulangerie 1310 · 10, Garage 1277 · 10, Boucherie 1261 · 10.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 20,7 % | 35,1 % | 0,3 % | 2,7 % | 0,65 | -0,069 % | 5543 (36) | 0,88 | 6 % / 17 % / 77 % | 3 | 0 $ |
| 2 | 26,1 % | 37,6 % | 0,5 % | 4,3 % | 0,72 | -0,075 % | 5399 (51) | 0,88 | 7 % / 20 % / 74 % | 9 | 0 $ |
| 3 | 28,0 % | 38,1 % | 0,3 % | 5,1 % | 0,71 | -0,031 % | 5604 (43) | 0,83 | 9 % / 22 % / 69 % | 88 | 0 $ |
| 4 | 24,4 % | 40,7 % | 0,4 % | 4,5 % | 0,66 | -0,030 % | 5581 (45) | 0,83 | 9 % / 23 % / 68 % | 91 | 0 $ |
| 5 | 25,9 % | 51,4 % | 0,6 % | 6,4 % | 0,69 | -0,063 % | 5470 (50) | 0,86 | 7 % / 19 % / 74 % | 87 | 1 075 $ |
| 6 | 19,7 % | 37,7 % | 0,4 % | 2,9 % | 0,63 | -0,059 % | 5432 (49) | 0,88 | 6 % / 22 % / 72 % | 5 | 10 447 $ |
| 7 | 27,8 % | 40,4 % | 0,4 % | 5,7 % | 0,71 | -0,074 % | 5440 (42) | 0,88 | 7 % / 21 % / 72 % | 89 | 0 $ |
| 8 | 23,7 % | 43,8 % | 0,4 % | 4,5 % | 0,66 | -0,061 % | 5622 (34) | 0,87 | 7 % / 23 % / 70 % | 90 | 0 $ |
| 9 | 28,0 % | 41,0 % | 0,6 % | 6,0 % | 0,71 | -0,061 % | 5521 (38) | 0,85 | 7 % / 22 % / 71 % | 85 | 0 $ |
| 10 | 28,6 % | 38,0 % | 0,4 % | 6,6 % | 0,72 | -0,029 % | 5641 (51) | 0,76 | 10 % / 30 % / 60 % | 88 | 8 635 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 10/10 : g1 32, g2 23, g3 25, g4 23, g5 29, g6 26, g7 27, g8 12, … |
| Chômage moyen ≤ 10 % | ❌ | 10/10 : g1 21,2 %, g2 21,5 %, g3 12,5 %, g4 26,7 %, g5 20,4 %, g6 20,4 %, g7 27,5 %, g8 26,0 %, … |
| Faim et sans-abri < 2 % | ❌ | 9/10 : g1, g2, g4, g5, g6, g7, g8, g9, g10 |
| Gini 0,2–0,45 | ❌ | 10/10 : g1 0,66, g2 0,69, g3 0,57, g4 0,69, g5 0,66, g6 0,68, g7 0,72, g8 0,69, … |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 10 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 10 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 3/10 graines ; Renflouement d’entreprise : 10/10 graines ; Plancher de logement : 10/10 graines |

