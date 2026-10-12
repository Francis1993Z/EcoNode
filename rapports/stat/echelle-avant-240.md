# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 21:04
- Graines : 1 à 10 (10) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : aucun
- Paramètres changés : population = 240
- Temps total : 29 s pour 20 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,1 % | 2,1 pt (7,2 % – 9,3 %) | 5,7 % – 16,3 % | 2/10 |
| Chômage max | toute la partie | — | 27,3 % | 4,3 pt (25,1 % – 29,4 %) | 20,8 % – 62,1 % | — |
| Faim moyenne | après chauffe | < 2 % | 6,7 % | 4,8 pt (3,9 % – 8,7 %) | 1,3 % – 11,3 % | 9/10 |
| Faim max | toute la partie | — | 95,4 % | 5,7 pt (89,7 % – 95,4 %) | 85,4 % – 96,7 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 1,8 % | 1,5 pt (1,5 % – 3,0 %) | 1,1 % – 6,7 % | 4/10 |
| Sans-abri max | toute la partie | — | 41,0 % | 10,8 pt (35,5 % – 46,4 %) | 31,7 % – 80,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,36 | 0,07 (0,33 – 0,40) | 0,30 – 0,44 | 0/10 |
| Gini en fin de partie | dernier jour | — | 0,49 | 0,35 (0,38 – 0,72) | 0,19 – 0,94 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,064 % | 0,028 pt (0,053 % – 0,081 %) | 0,037 % – 0,090 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 33,3 % | 23,2 pt (28,2 % – 51,4 %) | 12,9 % – 63,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 142,1 % | 26,8 pt (127,1 % – 154,0 %) | 115,2 % – 201,0 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 28 | 8,5 (23,3 – 31,8) | 12 – 42 | 10/10 |
| … dont après la chauffe | après chauffe | — | 26 | 7,5 (21,3 – 28,8) | 11 – 39 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 1513 | 223 (1392,3 – 1615,3) | 1261 – 2117 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 568 | 166,8 (440,3 – 607) | 216 – 632 | — |
| Santé moyenne | après chauffe | — | 0,18 | 0,05 (0,16 – 0,21) | 0,13 – 0,24 | — |
| Naissances d’entreprises / an | toute la partie | — | 28,0 | 8,0 (24,2 – 32,2) | 7,8 – 35,5 | — |
| Morts d’entreprises / an | toute la partie | — | 31,3 | 8,0 (27,7 – 35,6) | 12,4 – 37,7 | — |
| Entonnoir : projets envisagés | toute la partie | — | 17146 | 1707,3 (16074 – 17781,3) | 12915 – 19141 | — |
| Entonnoir : créations | toute la partie | — | 115 | 33 (99,3 – 132,3) | 32 – 146 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 765,5 | 291,5 (571,3 – 862,8) | 178 – 996 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 5735,5 | 1584,5 (4889,3 – 6473,8) | 1692 – 6921 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 1598,5 | 536 (1286,8 – 1822,8) | 1051 – 1924 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 1541 | 487,5 (1204,3 – 1691,8) | 905 – 1833 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 565 | 707,3 (460,5 – 1167,8) | 329 – 1487 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 5985,5 | 1980 (4773 – 6753) | 4395 – 7300 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 1002 | 830,5 (668 – 1498,5) | 487 – 1658 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 14 | 2,8 (12,3 – 15) | 11 – 20 | — |
| Machines en fin | dernier jour | — | 0,3 | 0,4 (0,1 – 0,5) | 0,1 – 0,6 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 1 | 0 (1 – 1) | 0 – 2 | — |
| Bonheur moyen | après chauffe | — | 0,81 | 0,03 (0,80 – 0,83) | 0,76 – 0,84 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 476,6 | 163,5 (398,6 – 562,0) | 364,0 – 580,8 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 219 | — |
| Trésor de l’État le plus bas | après chauffe | — | 87 562 $ | 59 171 $ (40 380 $ – 99 551 $) | 2 931 $ – 109 943 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 1198 | — |
| Prêts refusés | toute la partie | — | 0 | 21,5 (0 – 21,5) | 0 – 160 | — |
| Créances radiées | toute la partie | — | 18 370 $ | 7 177 $ (17 443 $ – 24 620 $) | 15 162 $ – 31 061 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 2/10 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Faim répandue | critique | 10/10 | 7 | 6,3 – 8,8 | 1 – 10 | 149,5 j |
| Sans-abri nombreux | critique | 10/10 | 10 | 9 – 11 | 3 – 12 | 129,5 j |
| Inégalités hors bornes | attention | 10/10 | 3 | 2 – 4 | 2 – 5 | 150 j |
| Richesse médiane hors bornes | attention | 5/10 | 0,5 | 0 – 1,8 | 0 – 4 | 1 j |
| Inflation quotidienne | critique | 10/10 | 7 | 4 – 10,5 | 3 – 13 | 7 j |
| Inflation sur 100 jours | critique | 10/10 | 2 | 1,3 – 2 | 1 – 6 | 51 j |
| Rupture de stock prolongée | attention | 10/10 | 149,5 | 106,8 – 162,3 | 46 – 175 | 5456 j |
| Surstock | attention | 10/10 | 40,5 | 27 – 46,5 | 20 – 54 | 1260 j |
| Entreprise sans employé | attention | 10/10 | 136 | 117 – 154,3 | 53 – 164 | 1841,5 j |
| Entreprise sans client | attention | 10/10 | 165 | 133 – 176,3 | 58 – 195 | 5181,5 j |
| Caisse insolvable | attention | 1/10 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Santé de la population effondrée | critique | 10/10 | 1 | 1 – 1 | 1 – 1 | 1178,5 j |
| Productivité du travail effondrée | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 1177,5 j |
| Pénurie de main-d’œuvre | attention | 1/10 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Embauches bloquées faute de moyens | attention | 10/10 | 8 | 6,3 – 8 | 4 – 10 | 306 j |
| Prix aberrant | attention | 10/10 | 19 | 14,5 – 22,8 | 13 – 25 | 2206 j |
| Attente trop longue (service public) | attention | 10/10 | 1 | 1 – 1 | 1 – 2 | 1291,5 j |
| Prestations réduites faute de trésor | attention | 1/10 | 0 | 0 – 0 | 0 – 1 | 0 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 10,9 % | 35,0 % | 5,6 % | 1,1 % | 0,33 | 0,090 % | 564 (32) | 0,24 | 10 % / 26 % / 65 % | 4 | 0 $ |
| 2 | 7,2 % | 26,7 % | 11,1 % | 3,2 % | 0,44 | 0,066 % | 516 (31) | 0,15 | 5 % / 31 % / 64 % | 4 | 9 770 $ |
| 3 | 7,9 % | 27,5 % | 7,3 % | 1,6 % | 0,35 | 0,052 % | 629 (26) | 0,14 | 9 % / 21 % / 70 % | 1 | 239 $ |
| 4 | 8,9 % | 28,7 % | 7,8 % | 1,5 % | 0,34 | 0,057 % | 618 (32) | 0,17 | 10 % / 24 % / 66 % | 6 | 1 088 $ |
| 5 | 16,3 % | 62,1 % | 11,3 % | 6,7 % | 0,40 | 0,062 % | 572 (24) | 0,20 | 15 % / 27 % / 58 % | 3 | 17 106 $ |
| 6 | 6,7 % | 20,8 % | 1,3 % | 1,8 % | 0,37 | 0,083 % | 216 (12) | 0,19 | 8 % / 22 % / 70 % | 1 | 46 178 $ |
| 7 | 5,7 % | 21,3 % | 9,0 % | 3,3 % | 0,43 | 0,050 % | 415 (23) | 0,13 | 10 % / 24 % / 67 % | 1 | 37 491 $ |
| 8 | 9,5 % | 27,1 % | 6,0 % | 1,8 % | 0,31 | 0,083 % | 632 (42) | 0,23 | 6 % / 31 % / 63 % | 3 | 0 $ |
| 9 | 7,3 % | 29,6 % | 3,2 % | 2,5 % | 0,40 | 0,076 % | 298 (16) | 0,17 | 2 % / 39 % / 60 % | 3 | 0 $ |
| 10 | 8,2 % | 24,6 % | 3,3 % | 1,1 % | 0,30 | 0,037 % | 574 (30) | 0,21 | 10 % / 26 % / 64 % | 2 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,5 % | 1,0 pt (6,9 % – 7,9 %) | 4,8 % – 11,4 % | 2/10 |
| Chômage max | toute la partie | — | 22,7 % | 8,6 pt (17,4 % – 26,0 %) | 16,3 % – 29,6 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 0,6 % | 0/10 |
| Faim max | toute la partie | — | 51,2 % | 44,0 pt (14,3 % – 58,2 %) | 0,0 % – 79,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,1 % | 0,3 pt (0,0 % – 0,3 %) | 0,0 % – 1,4 % | 0/10 |
| Sans-abri max | toute la partie | — | 16,9 % | 25,5 pt (6,4 % – 31,9 %) | 3,8 % – 64,6 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,20 | 0,02 (0,19 – 0,21) | 0,15 – 0,36 | 5/10 |
| Gini en fin de partie | dernier jour | — | 0,19 | 0,10 (0,14 – 0,23) | 0,13 – 0,39 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,029 % | 0,027 pt (0,024 % – 0,051 %) | 0,001 % – 0,102 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 47,8 % | 11,7 pt (38,3 % – 50,0 %) | 28,6 % – 90,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 142,8 % | 12,9 pt (135,9 % – 148,8 %) | 124,2 % – 228,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10 | 5,5 (7,3 – 12,8) | 7 – 20 | 10/10 |
| … dont après la chauffe | après chauffe | — | 7,5 | 5,5 (5,3 – 10,8) | 5 – 18 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 78,5 | 67,3 (49,8 – 117) | 29 – 436 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 131 | 29 (125,8 – 154,8) | 118 – 269 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,0001 (0,88 – 0,88) | 0,71 – 0,88 | — |
| Naissances d’entreprises / an | toute la partie | — | 3,3 | 0,9 (2,9 – 3,8) | 2,2 – 6,6 | — |
| Morts d’entreprises / an | toute la partie | — | 5,8 | 0,9 (5,4 – 6,2) | 4,4 – 9,2 | — |
| Entonnoir : projets envisagés | toute la partie | — | 8179,5 | 1027,8 (7700,8 – 8728,5) | 7475 – 10829 | — |
| Entonnoir : créations | toute la partie | — | 13,5 | 3,8 (12 – 15,8) | 9 – 27 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 48 | 19 (35,3 – 54,3) | 24 – 140 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 591 | 179,8 (508,3 – 688) | 301 – 1147 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 1447 | 399,3 (1317,5 – 1716,8) | 862 – 2256 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 1779 | 855,8 (1532,8 – 2388,5) | 1090 – 2563 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 310 | 314 (151,5 – 465,5) | 13 – 587 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 3896,5 | 1212,5 (3335 – 4547,5) | 3196 – 4926 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 350 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 20 | 2,8 (18,3 – 21) | 17 – 22 | — |
| Machines en fin | dernier jour | — | 4,0 | 2,7 (1,5 – 4,2) | 0,8 – 4,4 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 3 | 0,8 (3 – 3,8) | 1 – 5 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,004 (0,97 – 0,97) | 0,93 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,3 | 0,02 (0,3 – 0,3) | 0,3 – 46,1 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 37 917 $ | 45 203 $ (15 814 $ – 61 016 $) | 15 282 $ – 87 776 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,91 | 1,14 (0,04 – 1,18) | 0,00 – 8,86 | 4/10 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 10,43 | 9,15 (9,84 – 18,99) | 7,96 – 21,79 | 10/10 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,57 | 11,27 (0,01 – 11,28) | 0,00 – 39,89 | 5/10 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,91 | 0,04 – 1,18 | 0,00 – 8,86 | 4/10 | 409 | pas de producteur (100 %) |
| Renflouement d’entreprise | 10,43 | 9,84 – 18,99 | 7,96 – 21,79 | 10/10 | 4262 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0,57 | 0,01 – 11,28 | 0,00 – 39,89 | 5/10 | 3635 | prix trop élevé (64 %) ; parc plein (36 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 10 graines · graines touchées) : Ferme 1583 · 10, Bijouterie 690 · 10, Mine de fer 305 · 10, Tourisme 250 · 7, Fonderie 223 · 10, Pêcherie 202 · 10, Hôtel 83 · 2, Mine de cuivre 73 · 9.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,4 % | 26,7 % | 0,1 % | 0,2 % | 0,36 | 0,032 % | 154 (13) | 0,88 | 7 % / 12 % / 81 % | 2 | 0 $ |
| 2 | 7,9 % | 24,2 % | 0,1 % | 0,0 % | 0,20 | 0,001 % | 125 (7) | 0,88 | 4 % / 19 % / 78 % | 0 | 6 001 $ |
| 3 | 7,4 % | 17,1 % | 0,1 % | 0,2 % | 0,21 | 0,024 % | 131 (7) | 0,88 | 7 % / 15 % / 78 % | 1 | 3 202 $ |
| 4 | 10,5 % | 29,6 % | 0,6 % | 1,4 % | 0,22 | 0,058 % | 269 (20) | 0,71 | 17 % / 21 % / 63 % | 0 | 21 154 $ |
| 5 | 7,7 % | 22,1 % | 0,0 % | 0,0 % | 0,17 | 0,102 % | 118 (7) | 0,88 | 6 % / 13 % / 81 % | 1 | 11 142 $ |
| 6 | 4,8 % | 16,3 % | 0,0 % | 0,0 % | 0,15 | 0,026 % | 131 (12) | 0,88 | 7 % / 13 % / 80 % | 0 | 12 657 $ |
| 7 | 6,0 % | 17,1 % | 0,0 % | 0,3 % | 0,19 | 0,003 % | 158 (10) | 0,88 | 6 % / 16 % / 78 % | 1 | 15 938 $ |
| 8 | 6,8 % | 18,3 % | 0,2 % | 0,0 % | 0,19 | 0,056 % | 128 (10) | 0,88 | 7 % / 12 % / 81 % | 1 | 1 882 $ |
| 9 | 7,0 % | 23,3 % | 0,1 % | 0,7 % | 0,21 | 0,024 % | 155 (19) | 0,88 | 7 % / 13 % / 80 % | 0 | 18 172 $ |
| 10 | 7,9 % | 27,1 % | 0,1 % | 0,0 % | 0,19 | 0,035 % | 122 (8) | 0,88 | 6 % / 12 % / 82 % | 0 | 19 257 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 10/10 : g1 32, g2 31, g3 26, g4 32, g5 24, g6 12, g7 23, g8 42, … |
| Chômage moyen ≤ 10 % | ❌ | 2/10 : g1 10,9 %, g5 16,3 % |
| Faim et sans-abri < 2 % | ❌ | 9/10 : g1, g2, g3, g4, g5, g7, g8, g9, g10 |
| Gini 0,2–0,45 | ✅ | aucune graine sur 10 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 10 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 10 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 4/10 graines ; Renflouement d’entreprise : 10/10 graines ; Plancher de logement : 5/10 graines |

