# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 13:31
- Graines : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Assurance-emploi indexée et aide sociale, Caisse : règles prudentielles, Faillite ordonnée
- Temps total : 4 min 8 s pour 210 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,0 % | 2,5 pt (7,0 % – 9,5 %) | 6,3 % – 67,4 % | 6/30 |
| Chômage max | toute la partie | — | 26,0 % | 7,3 pt (23,9 % – 31,1 %) | 18,8 % – 93,3 % | — |
| Faim moyenne | après chauffe | < 2 % | 6,6 % | 3,2 pt (4,5 % – 7,6 %) | 0,2 % – 75,6 % | 29/30 |
| Faim max | toute la partie | — | 94,8 % | 2,7 pt (93,0 % – 95,7 %) | 47,1 % – 100,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 1,6 % | 1,6 pt (1,1 % – 2,7 %) | 0,3 % – 57,9 % | 11/30 |
| Sans-abri max | toute la partie | — | 45,4 % | 14,7 pt (37,3 % – 52,0 %) | 20,4 % – 88,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,35 | 0,09 (0,32 – 0,41) | 0,27 – 0,72 | 4/30 |
| Gini en fin de partie | dernier jour | — | 0,33 | 0,42 (0,21 – 0,63) | 0,14 – 0,97 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,059 % | 0,032 pt (0,044 % – 0,076 %) | -0,042 % – 0,105 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 38,7 % | 22,1 pt (25,1 % – 47,1 %) | 12,2 % – 98,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,3 % | 16,3 pt (132,0 % – 148,3 %) | 68,6 % – 188,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 26 | 5,8 (24 – 29,8) | 12 – 40 | 30/30 |
| … dont après la chauffe | après chauffe | — | 23,5 | 7,8 (21 – 28,8) | 10 – 39 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 1509 | 194 (1392 – 1586) | 838 – 4400 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 574,5 | 200,5 (453 – 653,5) | 248 – 864 | — |
| Santé moyenne | après chauffe | — | 0,18 | 0,03 (0,16 – 0,20) | 0,11 – 0,48 | — |
| Bonheur moyen | après chauffe | — | 0,82 | 0,02 (0,81 – 0,82) | 0,30 – 0,88 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 471,8 | 187,3 (348,8 – 536,1) | 188,7 – 650,8 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 21 (0 – 21) | 0 – 1026 | — |
| Trésor de l’État le plus bas | après chauffe | — | 64 946 $ | 73 983 $ (4 830 $ – 78 812 $) | 333 $ – 94 814 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 211,5 (0 – 211,5) | 0 – 1336 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 21 226 $ | 9 659 $ (18 579 $ – 28 238 $) | 8 624 $ – 102 195 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 6/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Chômage nul prolongé | attention | 1/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Faim répandue | critique | 30/30 | 6 | 4,3 – 7 | 1 – 14 | 135 j |
| Sans-abri nombreux | critique | 30/30 | 10 | 8 – 12 | 2 – 15 | 96,5 j |
| Inégalités hors bornes | attention | 30/30 | 4 | 2,3 – 4 | 1 – 10 | 138 j |
| Richesse médiane hors bornes | attention | 9/30 | 0 | 0 – 1 | 0 – 2 | 0 j |
| Inflation quotidienne | critique | 30/30 | 7 | 6 – 9 | 3 – 29 | 7 j |
| Inflation sur 100 jours | critique | 27/30 | 2 | 1 – 2 | 0 – 6 | 36 j |
| Rupture de stock prolongée | attention | 30/30 | 142 | 113,3 – 170,5 | 57 – 208 | 5308 j |
| Surstock | attention | 30/30 | 42 | 33 – 48,8 | 24 – 115 | 1398,5 j |
| Entreprise sans employé | attention | 30/30 | 147 | 114,3 – 169,5 | 63 – 254 | 2016,5 j |
| Entreprise sans client | attention | 30/30 | 170,5 | 128,5 – 187,5 | 70 – 265 | 5418 j |
| Caisse insolvable | attention | 8/30 | 0 | 0 – 0,8 | 0 – 2 | 0 j |
| Santé de la population effondrée | critique | 30/30 | 1 | 1 – 1 | 1 – 2 | 1203 j |
| Productivité du travail effondrée | attention | 30/30 | 1 | 1 – 1 | 1 – 2 | 1202 j |
| Pénurie de main-d’œuvre | attention | 10/30 | 0 | 0 – 1 | 0 – 1 | 0 j |
| Embauches bloquées faute de moyens | attention | 30/30 | 7,5 | 6 – 8 | 2 – 13 | 313,5 j |
| Prix aberrant | attention | 30/30 | 17 | 15,3 – 20,8 | 9 – 36 | 2420 j |
| Attente trop longue (service public) | attention | 30/30 | 1 | 1 – 2 | 1 – 4 | 1315 j |
| Prestations réduites faute de trésor | attention | 8/30 | 0 | 0 – 0,8 | 0 – 2 | 0 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 7,8 % | 27,5 % | 4,5 % | 0,7 % | 0,34 | 0,085 % | 654 (35) | 0,20 | 9 % / 25 % / 66 % | 2 | 2 557 $ |
| 2 | 11,7 % | 35,4 % | 4,4 % | 0,5 % | 0,36 | -0,042 % | 864 (40) | 0,48 | 8 % / 15 % / 77 % | 2 | 29 590 $ |
| 3 | 8,4 % | 30,8 % | 6,8 % | 3,0 % | 0,47 | 0,053 % | 396 (24) | 0,16 | 8 % / 25 % / 67 % | 3 | 2 585 $ |
| 4 | 9,0 % | 24,2 % | 5,6 % | 1,3 % | 0,33 | 0,084 % | 563 (26) | 0,18 | 5 % / 29 % / 66 % | 6 | 0 $ |
| 5 | 31,8 % | 76,3 % | 20,7 % | 18,5 % | 0,50 | 0,025 % | 586 (35) | 0,21 | 11 % / 34 % / 56 % | 9 | 4 270 $ |
| 6 | 10,5 % | 36,7 % | 6,8 % | 1,6 % | 0,32 | 0,043 % | 687 (35) | 0,21 | 9 % / 29 % / 62 % | 11 | 8 322 $ |
| 7 | 7,1 % | 25,4 % | 3,2 % | 1,0 % | 0,40 | 0,105 % | 413 (25) | 0,17 | 7 % / 28 % / 64 % | 2 | 9 887 $ |
| 8 | 9,6 % | 31,7 % | 4,4 % | 1,5 % | 0,39 | 0,054 % | 685 (28) | 0,16 | 12 % / 20 % / 68 % | 6 | 0 $ |
| 9 | 8,3 % | 31,3 % | 5,8 % | 3,2 % | 0,51 | 0,061 % | 462 (24) | 0,19 | 11 % / 22 % / 67 % | 4 | 0 $ |
| 10 | 7,4 % | 25,0 % | 6,6 % | 2,9 % | 0,38 | 0,048 % | 459 (26) | 0,17 | 3 % / 30 % / 67 % | 4 | 9 062 $ |
| 11 | 8,1 % | 28,7 % | 7,9 % | 3,1 % | 0,42 | 0,093 % | 451 (31) | 0,22 | 3 % / 15 % / 82 % | 3 | 24 827 $ |
| 12 | 6,7 % | 18,8 % | 5,6 % | 1,6 % | 0,28 | 0,056 % | 549 (20) | 0,16 | 11 % / 25 % / 64 % | 3 | 8 067 $ |
| 13 | 7,9 % | 21,7 % | 8,8 % | 1,5 % | 0,35 | 0,011 % | 600 (25) | 0,11 | 10 % / 20 % / 70 % | 3 | 1 256 $ |
| 14 | 7,6 % | 25,0 % | 7,9 % | 1,4 % | 0,34 | 0,075 % | 693 (30) | 0,12 | 1 % / 13 % / 86 % | 2 | 2 772 $ |
| 15 | 9,0 % | 25,8 % | 8,1 % | 1,6 % | 0,32 | 0,037 % | 658 (21) | 0,19 | 13 % / 26 % / 61 % | 5 | 9 422 $ |
| 16 | 6,7 % | 22,5 % | 7,2 % | 1,2 % | 0,32 | 0,055 % | 518 (24) | 0,11 | 6 % / 30 % / 64 % | 5 | 2 203 $ |
| 17 | 6,9 % | 27,1 % | 6,4 % | 3,1 % | 0,42 | 0,062 % | 409 (27) | 0,20 | 9 % / 25 % / 66 % | 5 | 2 175 $ |
| 18 | 6,7 % | 20,8 % | 7,8 % | 1,7 % | 0,33 | 0,070 % | 641 (24) | 0,12 | 14 % / 26 % / 60 % | 5 | 8 658 $ |
| 19 | 6,7 % | 24,6 % | 0,2 % | 0,3 % | 0,37 | 0,097 % | 248 (12) | 0,18 | 12 % / 20 % / 69 % | 0 | 0 $ |
| 20 | 9,8 % | 28,7 % | 6,6 % | 1,3 % | 0,32 | 0,042 % | 611 (25) | 0,20 | 5 % / 16 % / 78 % | 6 | 5 311 $ |
| 21 | 6,3 % | 22,1 % | 8,5 % | 2,6 % | 0,43 | 0,095 % | 414 (34) | 0,15 | 9 % / 24 % / 67 % | 2 | 23 472 $ |
| 22 | 11,4 % | 32,9 % | 4,4 % | 1,8 % | 0,32 | 0,052 % | 657 (29) | 0,43 | 5 % / 17 % / 78 % | 2 | 153 $ |
| 23 | 8,2 % | 23,8 % | 4,3 % | 0,6 % | 0,39 | 0,063 % | 608 (22) | 0,14 | 12 % / 19 % / 69 % | 4 | 15 576 $ |
| 24 | 6,6 % | 24,2 % | 6,7 % | 2,7 % | 0,39 | 0,089 % | 477 (29) | 0,17 | 10 % / 19 % / 70 % | 5 | 16 902 $ |
| 25 | 9,2 % | 23,3 % | 7,2 % | 2,3 % | 0,31 | 0,070 % | 597 (24) | 0,19 | 12 % / 18 % / 70 % | 2 | 0 $ |
| 26 | 7,2 % | 23,3 % | 6,7 % | 2,6 % | 0,43 | 0,064 % | 415 (27) | 0,20 | 9 % / 22 % / 69 % | 1 | 14 584 $ |
| 27 | 8,0 % | 26,7 % | 2,9 % | 0,4 % | 0,27 | 0,035 % | 429 (14) | 0,17 | 10 % / 23 % / 67 % | 0 | 23 526 $ |
| 28 | 7,0 % | 26,3 % | 3,9 % | 0,9 % | 0,32 | 0,076 % | 508 (27) | 0,20 | 4 % / 14 % / 83 % | 1 | 12 194 $ |
| 29 | 67,4 % | 93,3 % | 75,6 % | 57,9 % | 0,72 | 0,036 % | 770 (18) | 0,16 | 9 % / 22 % / 70 % | 11 | 0 $ |
| 30 | 10,6 % | 31,3 % | 7,1 % | 1,1 % | 0,33 | 0,046 % | 652 (33) | 0,18 | 3 % / 12 % / 85 % | 6 | 5 543 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,9 % | 3,6 pt (6,6 % – 10,2 %) | 5,4 % – 13,7 % | 8/30 |
| Chômage max | toute la partie | — | 18,3 % | 12,9 pt (16,5 % – 29,4 %) | 12,9 % – 46,3 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,7 pt (0,0 % – 0,7 %) | 0,0 % – 1,6 % | 0/30 |
| Faim max | toute la partie | — | 47,3 % | 63,7 pt (9,4 % – 73,1 %) | 0,0 % – 94,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,04 pt (0,0 % – 0,0 %) | 0,0 % – 1,5 % | 0/30 |
| Sans-abri max | toute la partie | — | 13,1 % | 32,1 pt (5,4 % – 37,5 %) | 0,8 % – 65,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,19 | 0,03 (0,19 – 0,22) | 0,16 – 0,31 | 18/30 |
| Gini en fin de partie | dernier jour | — | 0,20 | 0,09 (0,14 – 0,23) | 0,12 – 0,32 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,033 % | 0,032 pt (0,016 % – 0,048 %) | -0,062 % – 0,078 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 29,6 % | 26,4 pt (20,3 % – 46,7 %) | 8,6 % – 104,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 140,3 % | 13,9 pt (135,2 % – 149,1 %) | 86,8 % – 207,7 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 9,5 | 4,8 (7,3 – 12) | 4 – 23 | 30/30 |
| … dont après la chauffe | après chauffe | — | 7 | 4,5 (6 – 10,5) | 2 – 22 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 91,5 | 138,5 (46,8 – 185,3) | 12 – 1263 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 146 | 77 (134,3 – 211,3) | 108 – 447 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,09 (0,79 – 0,88) | 0,20 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,98 | 0,02 (0,96 – 0,98) | 0,84 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,4 | 27,7 (0,3 – 28,0) | 0,3 – 529,7 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 39,8 (0 – 39,8) | 0 – 225 | — |
| Trésor de l’État le plus bas | après chauffe | — | 27 275 $ | 43 744 $ (4 919 $ – 48 663 $) | 2 919 $ – 59 167 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 739 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 38 | — |
| Créances radiées | toute la partie | — | 0 $ | 3 212 $ (0 $ – 3 212 $) | 0 $ – 43 177 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,75 | 14,24 (0,00 – 14,24) | 0,00 – 59,29 | 14/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 16,86 | 7,07 (13,91 – 20,98) | 8,64 – 32,54 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,05 (0,00 – 0,05) | 0,00 – 18,71 | 6/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 1,36 | 1/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,75 | 0,00 – 14,24 | 0,00 – 59,29 | 14/30 | 7886 | pas de producteur (100 %) ; pas de revenu (0 %) |
| Renflouement d’entreprise | 16,86 | 13,91 – 20,98 | 8,64 – 32,54 | 30/30 | 15925 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 0,05 | 0,00 – 18,71 | 6/30 | 3670 | parc plein (68 %) ; prix trop élevé (32 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 1,36 | 1/30 | 53 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 2892 · 30, Tourisme 2288 · 26, Bijouterie 1510 · 28, Garage 1423 · 20, Fonderie 1389 · 30, Pêcherie 927 · 29, Mine de fer 599 · 30, Puits de pétrole 469 · 18.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,7 % | 17,9 % | 0,0 % | 0,0 % | 0,25 | -0,029 % | 140 (9) | 0,88 | 6 % / 14 % / 80 % | 0 | 0 $ |
| 2 | 10,5 % | 42,9 % | 1,1 % | 0,1 % | 0,27 | 0,020 % | 247 (14) | 0,20 | 12 % / 19 % / 69 % | 2 | 1 450 $ |
| 3 | 8,0 % | 18,3 % | 0,0 % | 0,0 % | 0,16 | 0,047 % | 115 (4) | 0,88 | 6 % / 13 % / 80 % | 1 | 2 394 $ |
| 4 | 11,5 % | 35,0 % | 0,8 % | 0,1 % | 0,26 | 0,015 % | 187 (12) | 0,61 | 5 % / 8 % / 86 % | 1 | 0 $ |
| 5 | 8,0 % | 17,5 % | 0,0 % | 0,0 % | 0,20 | 0,034 % | 197 (10) | 0,88 | 8 % / 13 % / 79 % | 1 | 0 $ |
| 6 | 13,7 % | 46,3 % | 1,6 % | 0,8 % | 0,30 | -0,062 % | 447 (23) | 0,53 | 7 % / 15 % / 79 % | 1 | 21 887 $ |
| 7 | 6,6 % | 12,9 % | 0,1 % | 0,0 % | 0,19 | 0,073 % | 132 (7) | 0,88 | 7 % / 13 % / 79 % | 1 | 5 530 $ |
| 8 | 9,8 % | 23,8 % | 0,5 % | 0,0 % | 0,19 | 0,032 % | 200 (10) | 0,86 | 7 % / 18 % / 75 % | 0 | 3 899 $ |
| 9 | 10,9 % | 31,3 % | 1,2 % | 0,1 % | 0,26 | 0,016 % | 278 (8) | 0,31 | 3 % / 30 % / 67 % | 1 | 0 $ |
| 10 | 6,6 % | 15,8 % | 0,0 % | 0,0 % | 0,20 | 0,024 % | 112 (6) | 0,88 | 5 % / 9 % / 85 % | 0 | 6 896 $ |
| 11 | 9,6 % | 35,4 % | 0,9 % | 0,0 % | 0,19 | 0,039 % | 244 (14) | 0,78 | 3 % / 18 % / 80 % | 0 | 7 245 $ |
| 12 | 8,5 % | 17,5 % | 0,2 % | 0,0 % | 0,19 | 0,048 % | 126 (9) | 0,88 | 7 % / 13 % / 80 % | 1 | 161 $ |
| 13 | 5,7 % | 17,9 % | 0,0 % | 0,0 % | 0,18 | 0,046 % | 146 (8) | 0,88 | 3 % / 18 % / 79 % | 0 | 12 729 $ |
| 14 | 7,9 % | 15,0 % | 0,0 % | 0,0 % | 0,19 | 0,066 % | 146 (4) | 0,88 | 6 % / 13 % / 81 % | 1 | 0 $ |
| 15 | 6,7 % | 15,0 % | 0,0 % | 0,0 % | 0,17 | 0,078 % | 179 (9) | 0,88 | 4 % / 18 % / 79 % | 1 | 0 $ |
| 16 | 11,4 % | 33,8 % | 0,9 % | 1,3 % | 0,31 | 0,018 % | 243 (19) | 0,31 | 8 % / 15 % / 77 % | 0 | 0 $ |
| 17 | 5,7 % | 13,8 % | 0,0 % | 0,0 % | 0,16 | 0,037 % | 145 (10) | 0,88 | 6 % / 12 % / 82 % | 0 | 21 208 $ |
| 18 | 8,1 % | 20,4 % | 0,0 % | 0,0 % | 0,20 | 0,063 % | 159 (12) | 0,88 | 7 % / 12 % / 81 % | 0 | 0 $ |
| 19 | 7,8 % | 22,9 % | 0,2 % | 0,0 % | 0,19 | 0,041 % | 132 (9) | 0,88 | 7 % / 13 % / 80 % | 1 | 26 239 $ |
| 20 | 6,4 % | 16,3 % | 0,1 % | 0,0 % | 0,17 | 0,013 % | 131 (6) | 0,88 | 7 % / 14 % / 80 % | 0 | 3 288 $ |
| 21 | 10,9 % | 21,7 % | 0,0 % | 0,0 % | 0,22 | -0,047 % | 223 (13) | 0,82 | 8 % / 13 % / 79 % | 0 | 5 337 $ |
| 22 | 10,3 % | 36,3 % | 1,1 % | 0,0 % | 0,22 | 0,017 % | 215 (7) | 0,26 | 6 % / 30 % / 63 % | 2 | 0 $ |
| 23 | 6,6 % | 14,6 % | 0,2 % | 0,0 % | 0,19 | 0,031 % | 143 (10) | 0,88 | 6 % / 13 % / 80 % | 0 | 9 541 $ |
| 24 | 7,0 % | 13,3 % | 0,0 % | 0,0 % | 0,19 | 0,050 % | 139 (11) | 0,88 | 6 % / 16 % / 78 % | 0 | 12 145 $ |
| 25 | 7,3 % | 17,1 % | 0,2 % | 0,4 % | 0,21 | 0,002 % | 176 (10) | 0,88 | 3 % / 20 % / 78 % | 1 | 5 152 $ |
| 26 | 5,4 % | 17,5 % | 0,1 % | 0,0 % | 0,17 | 0,040 % | 138 (12) | 0,88 | 7 % / 13 % / 81 % | 1 | 7 385 $ |
| 27 | 6,3 % | 18,3 % | 0,1 % | 0,0 % | 0,18 | -0,011 % | 133 (4) | 0,88 | 3 % / 18 % / 79 % | 1 | 1 292 $ |
| 28 | 6,9 % | 19,6 % | 0,0 % | 0,0 % | 0,18 | 0,077 % | 108 (6) | 0,88 | 5 % / 17 % / 78 % | 0 | 0 $ |
| 29 | 5,8 % | 18,8 % | 0,1 % | 0,0 % | 0,19 | 0,051 % | 141 (8) | 0,88 | 7 % / 13 % / 80 % | 0 | 21 837 $ |
| 30 | 13,5 % | 34,6 % | 1,0 % | 1,5 % | 0,28 | 0,017 % | 414 (19) | 0,35 | 6 % / 23 % / 71 % | 1 | 0 $ |

</details>

## 2 bis (1). Avec filets, sauf « Anti-famine »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,9 % | 2,1 pt (6,7 % – 8,8 %) | 5,6 % – 14,6 % | 5/30 |
| Chômage max | toute la partie | — | 18,3 % | 10,0 pt (16,6 % – 26,6 %) | 12,9 % – 46,3 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 1,0 pt (0,0 % – 1,0 %) | 0,0 % – 4,1 % | 4/30 |
| Faim max | toute la partie | — | 45,2 % | 74,2 pt (9,4 % – 83,5 %) | 0,0 % – 95,4 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,2 pt (0,0 % – 0,2 %) | 0,0 % – 2,1 % | 1/30 |
| Sans-abri max | toute la partie | — | 21,3 % | 34,1 pt (5,4 % – 39,5 %) | 0,8 % – 65,4 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,19 | 0,05 (0,19 – 0,24) | 0,16 – 0,37 | 17/30 |
| Gini en fin de partie | dernier jour | — | 0,22 | 0,13 (0,16 – 0,29) | 0,13 – 0,64 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,035 % | 0,042 pt (0,011 % – 0,053 %) | -0,047 % – 0,078 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 33,0 % | 26,2 pt (21,1 % – 47,4 %) | 8,6 % – 104,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,0 % | 13,3 pt (135,8 % – 149,1 %) | 87,3 % – 207,7 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10 | 4,8 (8 – 12,8) | 4 – 20 | 30/30 |
| … dont après la chauffe | après chauffe | — | 7 | 5 (6 – 11) | 2 – 18 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 95 | 236,3 (55,5 – 291,8) | 7 – 1338 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 145,5 | 87,5 (137 – 224,5) | 108 – 398 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,14 (0,74 – 0,88) | 0,22 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,98 | 0,04 (0,94 – 0,98) | 0,84 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,3 | 35,1 (0,3 – 35,4) | 0,3 – 463,6 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 163 | — |
| Trésor de l’État le plus bas | après chauffe | — | 27 275 $ | 41 994 $ (6 669 $ – 48 663 $) | 2 919 $ – 59 167 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 739 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 160 | — |
| Créances radiées | toute la partie | — | 706 $ | 3 581 $ (0 $ – 3 581 $) | 0 $ – 99 818 $ | — |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 16,41 | 7,79 (13,09 – 20,88) | 8,57 – 33,14 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,46 (0,00 – 0,46) | 0,00 – 43,68 | 6/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 5,71 | 3/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | coupé | — | — | — | — | — |
| Renflouement d’entreprise | 16,41 | 13,09 – 20,88 | 8,57 – 33,14 | 30/30 | 15844 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 0,46 | 0,00 – 43,68 | 6/30 | 5368 | parc plein (70 %) ; prix trop élevé (30 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 5,71 | 3/30 | 318 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 2635 · 30, Tourisme 2251 · 24, Bijouterie 1506 · 26, Fonderie 1397 · 30, Garage 1364 · 21, Pêcherie 1005 · 29, Machinerie 638 · 21, Mine de fer 582 · 29.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-famine »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 7,9 % | 8 → 5 | 0,0 pt | [0,0 pt ; +0,01 pt] | 9 / 10 / 11 sur 30 | non concluant |
| Chômage max | 18,3 % | 18,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 2 / 26 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 4 | +0,01 pt | [0,0 pt ; +0,1 pt] | 1 / 18 / 11 sur 30 | non concluant |
| Faim max | 47,3 % | 45,2 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 9 / 20 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 1 | 0,0 pt | [0,0 pt ; +0,003 pt] | 5 / 11 / 14 sur 30 | non concluant |
| Sans-abri max | 13,1 % | 21,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 7 / 21 sur 30 | non concluant |
| Gini moyen | 0,19 | 0,19 | 18 → 17 | 0,00 | [0,00 ; +0,001] | — / — / 11 | non concluant |
| Gini en fin de partie | 0,20 | 0,22 | — | +0,002 | [0,00 ; +0,03] | — / — / 11 | non concluant |
| Inflation moyenne / j | 0,033 % | 0,035 % | 0 → 0 | 0,000 pt | [−0,004 pt ; 0,000 pt] | — / — / 11 | non concluant |
| |Inflation| max / j | 29,6 % | 33,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 4 / 5 / 21 sur 30 | non concluant |
| |Inflation sur 100 j| max | 140,3 % | 141,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 2 / 28 sur 30 | non concluant |
| Alertes critiques ouvertes | 9,5 | 10 | 30 → 30 | 0 | [0 ; 0] | 3 / 8 / 19 sur 30 | non concluant |
| … dont après la chauffe | 7 | 7 | — | 0 | [0 ; 0] | 3 / 8 / 19 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 91,5 | 95 | — | 0 | [0 ; 0] | 4 / 8 / 18 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 146 | 145,5 | — | 0 | [−1,5 ; 0] | 10 / 9 / 11 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 6 / 5 / 19 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,98 | — | 0,00 | [−0,000000 ; 0,00] | 9 / 10 / 11 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,3 | — | 0,0 | [0,0 ; 0,0] | 6 / 5 / 19 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 5 / 1 / 24 sur 30 | non concluant |
| Trésor de l’État le plus bas | 27 275 $ | 27 275 $ | — | 0 $ | [0 $ ; 0 $] | 1 / 1 / 28 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 1 / 28 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 26 | non concluant |
| Créances radiées | 0 $ | 706 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 24 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 16,86 | 16,41 | 30 → 30 | 0,00 | [−0,29 ; 0,00] | 13 / 6 / 11 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 6 → 6 | 0,00 | [0,00 ; 0,00] | 4 / 7 / 19 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 3 | 0,00 | [0,00 ; 0,00] | 1 / 3 / 26 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-famine »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,7 % | 17,9 % | 0,1 % | 0,0 % | 0,25 | -0,031 % | 135 (9) | 0,88 | 6 % / 15 % / 79 % | 0 | 0 $ |
| 2 | 10,5 % | 42,9 % | 4,1 % | 1,2 % | 0,28 | -0,015 % | 392 (20) | 0,55 | 6 % / 8 % / 86 % | 0 | 19 248 $ |
| 3 | 8,0 % | 18,3 % | 0,0 % | 0,0 % | 0,16 | 0,047 % | 115 (4) | 0,88 | 6 % / 13 % / 80 % | 1 | 2 394 $ |
| 4 | 8,1 % | 23,8 % | 0,0 % | 0,1 % | 0,18 | 0,056 % | 143 (10) | 0,88 | 3 % / 18 % / 80 % | 1 | 24 013 $ |
| 5 | 8,0 % | 17,5 % | 0,0 % | 0,0 % | 0,20 | 0,034 % | 197 (10) | 0,88 | 8 % / 13 % / 79 % | 1 | 0 $ |
| 6 | 8,6 % | 46,3 % | 2,1 % | 0,2 % | 0,24 | 0,054 % | 288 (15) | 0,22 | 8 % / 21 % / 72 % | 1 | 0 $ |
| 7 | 6,6 % | 12,9 % | 0,1 % | 0,0 % | 0,19 | 0,070 % | 134 (7) | 0,88 | 6 % / 13 % / 81 % | 1 | 15 184 $ |
| 8 | 14,6 % | 33,8 % | 2,6 % | 0,6 % | 0,25 | 0,027 % | 394 (16) | 0,71 | 7 % / 9 % / 84 % | 3 | 7 594 $ |
| 9 | 9,8 % | 31,3 % | 3,0 % | 1,1 % | 0,24 | 0,038 % | 273 (15) | 0,38 | 3 % / 27 % / 70 % | 2 | 0 $ |
| 10 | 6,6 % | 15,8 % | 0,0 % | 0,0 % | 0,20 | 0,024 % | 112 (6) | 0,88 | 5 % / 9 % / 85 % | 0 | 6 896 $ |
| 11 | 8,8 % | 35,4 % | 1,2 % | 0,4 % | 0,33 | 0,061 % | 253 (16) | 0,24 | 12 % / 19 % / 69 % | 0 | 10 975 $ |
| 12 | 8,6 % | 17,5 % | 0,2 % | 0,0 % | 0,19 | 0,036 % | 123 (9) | 0,88 | 6 % / 14 % / 80 % | 1 | 10 009 $ |
| 13 | 5,7 % | 17,9 % | 0,0 % | 0,0 % | 0,18 | 0,046 % | 146 (8) | 0,88 | 3 % / 18 % / 79 % | 0 | 12 729 $ |
| 14 | 7,9 % | 15,0 % | 0,0 % | 0,0 % | 0,19 | 0,066 % | 146 (4) | 0,88 | 6 % / 13 % / 81 % | 1 | 0 $ |
| 15 | 6,7 % | 15,0 % | 0,0 % | 0,0 % | 0,17 | 0,078 % | 179 (9) | 0,88 | 4 % / 18 % / 79 % | 1 | 0 $ |
| 16 | 11,6 % | 27,5 % | 1,9 % | 2,1 % | 0,37 | 0,002 % | 225 (20) | 0,28 | 6 % / 15 % / 79 % | 1 | 0 $ |
| 17 | 5,7 % | 13,8 % | 0,0 % | 0,0 % | 0,16 | 0,037 % | 145 (10) | 0,88 | 6 % / 12 % / 82 % | 0 | 21 208 $ |
| 18 | 8,1 % | 20,4 % | 0,0 % | 0,0 % | 0,20 | 0,063 % | 159 (12) | 0,88 | 7 % / 12 % / 81 % | 0 | 0 $ |
| 19 | 7,9 % | 22,9 % | 0,3 % | 0,0 % | 0,19 | 0,033 % | 140 (9) | 0,88 | 6 % / 13 % / 81 % | 0 | 18 982 $ |
| 20 | 6,9 % | 16,3 % | 0,1 % | 0,0 % | 0,18 | 0,011 % | 137 (7) | 0,88 | 6 % / 14 % / 80 % | 0 | 854 $ |
| 21 | 10,9 % | 21,7 % | 0,0 % | 0,0 % | 0,22 | -0,047 % | 223 (13) | 0,82 | 8 % / 13 % / 79 % | 0 | 5 337 $ |
| 22 | 9,9 % | 36,3 % | 1,4 % | 0,0 % | 0,20 | 0,027 % | 250 (8) | 0,29 | 4 % / 32 % / 64 % | 0 | 868 $ |
| 23 | 6,5 % | 14,6 % | 0,2 % | 0,0 % | 0,19 | 0,011 % | 138 (10) | 0,88 | 7 % / 13 % / 80 % | 0 | 12 942 $ |
| 24 | 7,0 % | 13,3 % | 0,0 % | 0,0 % | 0,19 | 0,050 % | 139 (11) | 0,88 | 6 % / 16 % / 78 % | 0 | 12 145 $ |
| 25 | 7,7 % | 17,5 % | 0,4 % | 0,3 % | 0,22 | -0,007 % | 159 (12) | 0,88 | 5 % / 9 % / 86 % | 0 | 22 438 $ |
| 26 | 5,6 % | 17,5 % | 0,2 % | 0,0 % | 0,17 | 0,034 % | 134 (12) | 0,88 | 7 % / 15 % / 78 % | 0 | 10 233 $ |
| 27 | 6,7 % | 18,3 % | 0,1 % | 0,0 % | 0,19 | -0,020 % | 137 (4) | 0,88 | 5 % / 9 % / 86 % | 0 | 18 859 $ |
| 28 | 6,9 % | 19,6 % | 0,0 % | 0,0 % | 0,18 | 0,077 % | 108 (6) | 0,88 | 5 % / 17 % / 78 % | 0 | 0 $ |
| 29 | 5,9 % | 18,8 % | 0,1 % | 0,0 % | 0,19 | 0,052 % | 144 (8) | 0,88 | 6 % / 14 % / 80 % | 0 | 24 816 $ |
| 30 | 11,0 % | 34,6 % | 1,3 % | 1,3 % | 0,29 | -0,033 % | 398 (15) | 0,57 | 7 % / 13 % / 80 % | 0 | 4 920 $ |

</details>

## 2 bis (2). Avec filets, sauf « Renflouement d’entreprise »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,8 % | 1,9 pt (7,5 % – 9,4 %) | 5,9 % – 12,4 % | 7/30 |
| Chômage max | toute la partie | — | 25,0 % | 7,1 pt (23,8 % – 30,8 %) | 22,1 % – 42,9 % | — |
| Faim moyenne | après chauffe | < 2 % | 3,5 % | 1,1 pt (3,1 % – 4,2 %) | 1,5 % – 7,7 % | 29/30 |
| Faim max | toute la partie | — | 94,8 % | 2,9 pt (92,5 % – 95,4 %) | 75,8 % – 96,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,7 % | 0,6 pt (0,5 % – 1,1 %) | 0,3 % – 2,6 % | 2/30 |
| Sans-abri max | toute la partie | — | 33,8 % | 11,2 pt (29,8 % – 41,0 %) | 25,0 % – 64,6 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,36 | 0,06 (0,34 – 0,40) | 0,31 – 0,49 | 2/30 |
| Gini en fin de partie | dernier jour | — | 0,35 | 0,17 (0,27 – 0,44) | 0,11 – 0,73 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,063 % | 0,023 pt (0,050 % – 0,073 %) | 0,011 % – 0,094 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 30,3 % | 23,9 pt (22,8 % – 46,8 %) | 10,9 % – 98,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 140,7 % | 14,1 pt (130,1 % – 144,2 %) | 68,6 % – 188,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 21 | 5,8 (18 – 23,8) | 14 – 27 | 30/30 |
| … dont après la chauffe | après chauffe | — | 18,5 | 5,8 (16 – 21,8) | 13 – 26 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 1418 | 90 (1369,8 – 1459,8) | 1199 – 1561 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 524,5 | 212,8 (415,3 – 628) | 279 – 732 | — |
| Santé moyenne | après chauffe | — | 0,17 | 0,05 (0,14 – 0,20) | 0,11 – 0,26 | — |
| Bonheur moyen | après chauffe | — | 0,82 | 0,01 (0,82 – 0,83) | 0,81 – 0,85 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 503,5 | 188,8 (348,4 – 537,3) | 249,1 – 668,1 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 152 | — |
| Trésor de l’État le plus bas | après chauffe | — | 64 904 $ | 70 857 $ (6 764 $ – 77 621 $) | 2 935 $ – 88 799 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 172,5 (0 – 172,5) | 0 – 1336 | — |
| Prêts refusés | toute la partie | — | 3,5 | 27,5 (0 – 27,5) | 0 – 251 | — |
| Créances radiées | toute la partie | — | 24 484 $ | 9 552 $ (17 512 $ – 27 065 $) | 2 086 $ – 36 562 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 109,54 | 47,91 (89,39 – 137,30) | 27,68 – 269,64 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 5,75 | 15,97 (2,23 – 18,21) | 0,18 – 72,11 | 25/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,13 | 0,98 (0,00 – 0,98) | 0,00 – 8,96 | 8/30 |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 109,54 | 89,39 – 137,30 | 27,68 – 269,64 | 30/30 | 98492 | pas de producteur (100 %) |
| Renflouement d’entreprise | coupé | — | — | — | — | — |
| Plancher de logement | 5,75 | 2,23 – 18,21 | 0,18 – 72,11 | 25/30 | 13302 | prix trop élevé (74 %) ; parc plein (26 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,13 | 0,00 – 0,98 | 0,00 – 8,96 | 8/30 | 1319 | fonds propres de la Caisse insuffisants (100 %) |

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « renflouement d’entreprise »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 7,8 % | 8 → 7 | −0,04 pt | [−0,8 pt ; +0,6 pt] | 15 / 15 / 0 sur 30 | non concluant |
| Chômage max | 18,3 % | 25,0 % | — | +6,3 pt | [+4,0 pt ; +9,2 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,1 % | 3,5 % | 0 → 29 | +3,4 pt | [+2,9 pt ; +3,6 pt] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Faim max | 47,3 % | 94,8 % | — | +47,7 pt | [+23,3 pt ; +70,8 pt] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri moyen | 0,0 % | 0,7 % | 0 → 2 | +0,6 pt | [+0,5 pt ; +0,7 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 13,1 % | 33,8 % | — | +19,4 pt | [+5,4 pt ; +25,0 pt] | 5 / 21 / 4 sur 30 | **B plus haut (moins bien)** |
| Gini moyen | 0,19 | 0,36 | 18 → 2 | +0,17 | [+0,16 ; +0,19] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,20 | 0,35 | — | +0,16 | [+0,09 ; +0,24] | — / — / 0 | **B plus haut** |
| Inflation moyenne / j | 0,033 % | 0,063 % | 0 → 0 | +0,026 pt | [+0,014 pt ; +0,039 pt] | — / — / 0 | **B plus haut** |
| |Inflation| max / j | 29,6 % | 30,3 % | — | −3,6 pt | [−9,0 pt ; +10,8 pt] | 16 / 14 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 140,3 % | 140,7 % | — | −4,4 pt | [−9,7 pt ; −0,1 pt] | 20 / 10 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes critiques ouvertes | 9,5 | 21 | 30 → 30 | +11 | [+8,5 ; +14] | 0 / 29 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 7 | 18,5 | — | +11,5 | [+8,5 ; +13,5] | 0 / 29 / 1 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 91,5 | 1418 | — | +1306 | [+1248 ; +1349,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes ouvertes (toutes) | 146 | 524,5 | — | +322 | [+278,5 ; +400] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,17 | — | −0,69 | [−0,71 ; −0,64] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Bonheur moyen | 0,98 | 0,82 | — | −0,15 | [−0,15 ; −0,14] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,4 | 503,5 | — | +437,1 | [+308,9 ; +515,3] | 2 / 28 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 7 / 5 / 18 sur 30 | non concluant |
| Trésor de l’État le plus bas | 27 275 $ | 64 904 $ | — | +20 477 $ | [+6 822 $ ; +39 424 $] | 24 / 6 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; +165,5] | 1 / 13 / 16 sur 30 | non concluant |
| Prêts refusés | 0 | 3,5 | — | +3,5 | [0 ; +19] | — / — / 13 | non concluant |
| Créances radiées | 0 $ | 24 484 $ | — | +20 621 $ | [+17 836 $ ; +25 499 $] | — / — / 0 | **B plus haut** |
| Filet : Anti-famine / 50 j | 0,75 | 109,54 | 14 → 30 | +103,46 | [+83,66 ; +119,80] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plancher de logement / 50 j | 0,00 | 5,75 | 6 → 25 | +5,45 | [+2,98 ; +10,73] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,13 | 1 → 8 | +0,13 | [0,00 ; +0,68] | 1 / 16 / 13 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « renflouement d’entreprise »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 7,5 % | 24,2 % | 4,2 % | 1,2 % | 0,34 | 0,079 % | 639 (20) | 0,17 | 8 % / 19 % / 73 % | 4 | 0 $ |
| 2 | 8,8 % | 30,8 % | 3,4 % | 0,7 % | 0,31 | 0,062 % | 702 (17) | 0,16 | 13 % / 17 % / 70 % | 2 | 0 $ |
| 3 | 7,6 % | 23,8 % | 3,0 % | 1,1 % | 0,42 | 0,057 % | 319 (15) | 0,17 | 10 % / 18 % / 72 % | 0 | 0 $ |
| 4 | 10,1 % | 27,5 % | 4,2 % | 0,5 % | 0,34 | 0,051 % | 584 (23) | 0,13 | 4 % / 20 % / 76 % | 1 | 0 $ |
| 5 | 8,4 % | 25,4 % | 2,6 % | 0,6 % | 0,38 | 0,078 % | 415 (16) | 0,18 | 8 % / 23 % / 69 % | 3 | 0 $ |
| 6 | 11,5 % | 36,7 % | 3,3 % | 0,9 % | 0,37 | 0,039 % | 680 (27) | 0,20 | 10 % / 28 % / 62 % | 5 | 0 $ |
| 7 | 6,1 % | 23,8 % | 2,6 % | 0,5 % | 0,39 | 0,094 % | 458 (18) | 0,17 | 6 % / 29 % / 65 % | 6 | 0 $ |
| 8 | 10,2 % | 30,8 % | 4,2 % | 0,7 % | 0,32 | 0,037 % | 532 (18) | 0,24 | 1 % / 14 % / 85 % | 4 | 0 $ |
| 9 | 10,9 % | 35,8 % | 2,9 % | 2,6 % | 0,49 | 0,050 % | 508 (23) | 0,19 | 9 % / 20 % / 71 % | 6 | 0 $ |
| 10 | 9,6 % | 35,8 % | 3,8 % | 0,3 % | 0,36 | 0,043 % | 515 (20) | 0,20 | 11 % / 22 % / 66 % | 3 | 0 $ |
| 11 | 7,8 % | 22,9 % | 7,7 % | 0,3 % | 0,35 | 0,054 % | 653 (23) | 0,15 | 6 % / 31 % / 63 % | 10 | 0 $ |
| 12 | 7,1 % | 23,8 % | 3,3 % | 1,6 % | 0,44 | 0,063 % | 376 (21) | 0,17 | 8 % / 27 % / 65 % | 1 | 0 $ |
| 13 | 7,9 % | 24,2 % | 3,5 % | 0,3 % | 0,33 | 0,049 % | 454 (16) | 0,11 | 10 % / 19 % / 71 % | 1 | 0 $ |
| 14 | 6,9 % | 26,3 % | 2,9 % | 0,6 % | 0,36 | 0,082 % | 517 (21) | 0,12 | 10 % / 21 % / 69 % | 2 | 675 $ |
| 15 | 11,5 % | 37,1 % | 4,5 % | 0,6 % | 0,33 | 0,054 % | 633 (26) | 0,26 | 4 % / 22 % / 74 % | 3 | 0 $ |
| 16 | 8,0 % | 24,6 % | 3,3 % | 1,7 % | 0,49 | 0,072 % | 387 (19) | 0,13 | 6 % / 19 % / 75 % | 4 | 0 $ |
| 17 | 7,2 % | 23,3 % | 2,3 % | 1,8 % | 0,40 | 0,050 % | 279 (19) | 0,17 | 12 % / 20 % / 68 % | 2 | 0 $ |
| 18 | 7,7 % | 24,2 % | 3,4 % | 0,4 % | 0,36 | 0,062 % | 580 (18) | 0,11 | 9 % / 24 % / 67 % | 4 | 7 821 $ |
| 19 | 12,4 % | 42,9 % | 3,2 % | 0,7 % | 0,36 | 0,011 % | 732 (26) | 0,19 | 12 % / 21 % / 67 % | 9 | 0 $ |
| 20 | 8,5 % | 25,8 % | 5,0 % | 0,7 % | 0,35 | 0,065 % | 613 (25) | 0,14 | 17 % / 18 % / 65 % | 4 | 17 526 $ |
| 21 | 7,7 % | 23,8 % | 3,5 % | 0,5 % | 0,33 | 0,074 % | 541 (21) | 0,14 | 8 % / 27 % / 65 % | 4 | 0 $ |
| 22 | 10,7 % | 32,9 % | 4,0 % | 0,7 % | 0,32 | 0,068 % | 590 (24) | 0,20 | 6 % / 25 % / 68 % | 4 | 5 609 $ |
| 23 | 7,7 % | 23,3 % | 2,4 % | 0,3 % | 0,40 | 0,064 % | 669 (17) | 0,14 | 4 % / 20 % / 76 % | 3 | 0 $ |
| 24 | 7,4 % | 24,2 % | 3,6 % | 1,1 % | 0,37 | 0,082 % | 416 (25) | 0,18 | 10 % / 18 % / 72 % | 4 | 0 $ |
| 25 | 7,2 % | 22,9 % | 6,1 % | 0,9 % | 0,39 | 0,079 % | 456 (27) | 0,19 | 6 % / 19 % / 75 % | 3 | 0 $ |
| 26 | 8,8 % | 36,7 % | 3,5 % | 2,1 % | 0,42 | 0,036 % | 365 (27) | 0,23 | 6 % / 28 % / 66 % | 2 | 1 515 $ |
| 27 | 5,9 % | 22,5 % | 4,8 % | 0,4 % | 0,37 | 0,078 % | 414 (14) | 0,17 | 5 % / 19 % / 76 % | 0 | 0 $ |
| 28 | 7,7 % | 29,6 % | 4,2 % | 0,6 % | 0,34 | 0,072 % | 551 (17) | 0,20 | 12 % / 28 % / 60 % | 2 | 0 $ |
| 29 | 7,6 % | 22,1 % | 6,1 % | 1,5 % | 0,43 | 0,064 % | 386 (22) | 0,17 | 9 % / 26 % / 65 % | 2 | 5 943 $ |
| 30 | 8,4 % | 28,3 % | 1,5 % | 0,3 % | 0,33 | 0,053 % | 725 (21) | 0,25 | 10 % / 22 % / 68 % | 1 | 0 $ |

</details>

## 2 bis (3). Avec filets, sauf « Plancher de logement »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,1 % | 2,5 pt (6,7 % – 9,2 %) | 5,1 % – 11,3 % | 4/30 |
| Chômage max | toute la partie | — | 19,2 % | 9,5 pt (17,5 % – 27,0 %) | 12,9 % – 46,3 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,7 pt (0,0 % – 0,8 %) | 0,0 % – 1,9 % | 0/30 |
| Faim max | toute la partie | — | 49,2 % | 53,5 pt (21,1 % – 74,7 %) | 0,0 % – 94,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,03 pt (0,0 % – 0,0 %) | 0,0 % – 0,7 % | 0/30 |
| Sans-abri max | toute la partie | — | 16,5 % | 34,8 pt (5,4 % – 40,2 %) | 0,8 % – 80,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,19 | 0,06 (0,18 – 0,24) | 0,16 – 0,32 | 17/30 |
| Gini en fin de partie | dernier jour | — | 0,19 | 0,11 (0,13 – 0,24) | 0,11 – 0,53 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,035 % | 0,032 pt (0,014 % – 0,046 %) | -0,035 % – 0,077 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 38,1 % | 30,5 pt (18,3 % – 48,8 %) | 8,6 % – 104,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,0 % | 17,5 pt (136,0 % – 153,5 %) | 81,6 % – 207,7 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10,5 | 5,3 (7,5 – 12,8) | 4 – 22 | 30/30 |
| … dont après la chauffe | après chauffe | — | 7,5 | 5 (6 – 11) | 2 – 21 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 106,5 | 831,5 (57,5 – 889) | 9 – 1387 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 147 | 98,5 (138,3 – 236,8) | 108 – 325 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,42 (0,47 – 0,88) | 0,21 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,98 | 0,09 (0,89 – 0,98) | 0,84 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,4 | 150,5 (0,3 – 150,8) | 0,3 – 527,7 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 12 (0 – 12) | 0 – 216 | — |
| Trésor de l’État le plus bas | après chauffe | — | 20 159 $ | 42 667 $ (4 454 $ – 47 121 $) | 2 919 $ – 61 704 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 895 $ | 2 661 $ (0 $ – 2 661 $) | 0 $ – 9 014 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 1,04 | 17,38 (0,00 – 17,38) | 0,00 – 61,64 | 15/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 16,21 | 6,35 (13,16 – 19,51) | 8,64 – 35,68 | 30/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 1,04 | 0,00 – 17,38 | 0,00 – 61,64 | 15/30 | 8766 | pas de producteur (100 %) |
| Renflouement d’entreprise | 16,21 | 13,16 – 19,51 | 8,64 – 35,68 | 30/30 | 15430 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | coupé | — | — | — | — | — |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 2953 · 30, Tourisme 1884 · 26, Bijouterie 1422 · 25, Fonderie 1190 · 30, Garage 1162 · 17, Pêcherie 1110 · 29, Mine de fer 623 · 30, Pétrochimie 606 · 30.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plancher de logement »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 8,1 % | 8 → 4 | 0,0 pt | [−0,4 pt ; 0,0 pt] | 12 / 4 / 14 sur 30 | non concluant |
| Chômage max | 18,3 % | 19,2 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 9 / 19 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 7 / 7 / 16 sur 30 | non concluant |
| Faim max | 47,3 % | 49,2 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 6 / 6 / 18 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 8 / 8 / 14 sur 30 | non concluant |
| Sans-abri max | 13,1 % | 16,5 % | — | 0,0 pt | [0,0 pt ; +1,7 pt] | 0 / 13 / 17 sur 30 | non concluant |
| Gini moyen | 0,19 | 0,19 | 18 → 17 | 0,00 | [0,00 ; 0,00] | — / — / 14 | non concluant |
| Gini en fin de partie | 0,20 | 0,19 | — | 0,00 | [−0,01 ; 0,00] | — / — / 14 | non concluant |
| Inflation moyenne / j | 0,033 % | 0,035 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 14 | non concluant |
| |Inflation| max / j | 29,6 % | 38,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 9 / 6 / 15 sur 30 | non concluant |
| |Inflation sur 100 j| max | 140,3 % | 141,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 5 / 7 / 18 sur 30 | non concluant |
| Alertes critiques ouvertes | 9,5 | 10,5 | 30 → 30 | 0 | [0 ; 0] | 5 / 8 / 17 sur 30 | non concluant |
| … dont après la chauffe | 7 | 7,5 | — | 0 | [0 ; 0] | 5 / 9 / 16 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 91,5 | 106,5 | — | 0 | [0 ; +10,5] | 3 / 13 / 14 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 146 | 147 | — | 0 | [0 ; 0] | 7 / 9 / 14 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 8 / 7 / 15 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,98 | — | 0,00 | [0,00 ; 0,00] | 9 / 7 / 14 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | 0,0 | [0,0 ; 0,0] | 7 / 8 / 15 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 4 / 3 / 23 sur 30 | non concluant |
| Trésor de l’État le plus bas | 27 275 $ | 20 159 $ | — | 0 $ | [0 $ ; 0 $] | 5 / 8 / 17 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 2 / 0 / 28 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 28 | non concluant |
| Créances radiées | 0 $ | 895 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 17 | non concluant |
| Filet : Anti-famine / 50 j | 0,75 | 1,04 | 14 → 15 | 0,00 | [0,00 ; 0,00] | 6 / 6 / 18 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 16,86 | 16,21 | 30 → 30 | 0,00 | [−0,88 ; 0,00] | 11 / 5 / 14 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 0 | 0,00 | [0,00 ; 0,00] | 2 / 0 / 28 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plancher de logement »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,7 % | 17,9 % | 0,0 % | 0,0 % | 0,25 | -0,029 % | 140 (9) | 0,88 | 6 % / 14 % / 80 % | 0 | 0 $ |
| 2 | 9,1 % | 42,9 % | 1,3 % | 0,3 % | 0,30 | 0,036 % | 263 (14) | 0,21 | 8 % / 9 % / 83 % | 1 | 32 093 $ |
| 3 | 8,0 % | 18,3 % | 0,0 % | 0,0 % | 0,16 | 0,047 % | 115 (4) | 0,88 | 6 % / 13 % / 80 % | 1 | 2 394 $ |
| 4 | 8,8 % | 25,8 % | 0,3 % | 0,0 % | 0,21 | 0,043 % | 191 (11) | 0,88 | 6 % / 13 % / 81 % | 0 | 44 029 $ |
| 5 | 9,3 % | 27,1 % | 0,6 % | 0,6 % | 0,32 | 0,028 % | 325 (19) | 0,23 | 12 % / 22 % / 66 % | 2 | 0 $ |
| 6 | 11,3 % | 46,3 % | 1,2 % | 0,7 % | 0,27 | -0,035 % | 246 (22) | 0,24 | 11 % / 22 % / 68 % | 1 | 16 757 $ |
| 7 | 6,6 % | 12,9 % | 0,1 % | 0,0 % | 0,19 | 0,073 % | 132 (7) | 0,88 | 7 % / 13 % / 79 % | 1 | 5 530 $ |
| 8 | 8,9 % | 26,7 % | 0,8 % | 0,1 % | 0,24 | 0,028 % | 265 (11) | 0,25 | 9 % / 23 % / 68 % | 2 | 11 788 $ |
| 9 | 10,8 % | 31,3 % | 0,9 % | 0,2 % | 0,24 | 0,013 % | 308 (9) | 0,31 | 12 % / 19 % / 69 % | 1 | 0 $ |
| 10 | 8,2 % | 25,4 % | 0,0 % | 0,0 % | 0,21 | 0,040 % | 160 (11) | 0,88 | 6 % / 12 % / 81 % | 0 | 5 292 $ |
| 11 | 9,6 % | 35,4 % | 0,9 % | 0,0 % | 0,19 | 0,039 % | 244 (14) | 0,78 | 3 % / 18 % / 80 % | 0 | 7 245 $ |
| 12 | 8,5 % | 17,5 % | 0,2 % | 0,0 % | 0,19 | 0,048 % | 126 (9) | 0,88 | 7 % / 13 % / 80 % | 1 | 161 $ |
| 13 | 5,1 % | 18,3 % | 0,1 % | 0,0 % | 0,17 | 0,026 % | 145 (15) | 0,88 | 7 % / 13 % / 81 % | 0 | 23 852 $ |
| 14 | 7,9 % | 15,0 % | 0,0 % | 0,0 % | 0,19 | 0,066 % | 146 (4) | 0,88 | 6 % / 13 % / 81 % | 1 | 0 $ |
| 15 | 5,2 % | 15,4 % | 0,0 % | 0,0 % | 0,17 | -0,010 % | 163 (9) | 0,88 | 7 % / 12 % / 81 % | 0 | 13 732 $ |
| 16 | 9,8 % | 35,0 % | 1,9 % | 0,4 % | 0,27 | -0,031 % | 269 (17) | 0,36 | 12 % / 15 % / 73 % | 0 | 10 917 $ |
| 17 | 5,7 % | 13,8 % | 0,0 % | 0,0 % | 0,16 | 0,037 % | 145 (10) | 0,88 | 6 % / 12 % / 82 % | 0 | 21 208 $ |
| 18 | 8,1 % | 20,4 % | 0,0 % | 0,0 % | 0,20 | 0,063 % | 159 (12) | 0,88 | 7 % / 12 % / 81 % | 0 | 0 $ |
| 19 | 6,9 % | 24,2 % | 0,1 % | 0,0 % | 0,18 | 0,033 % | 134 (11) | 0,88 | 7 % / 13 % / 81 % | 0 | 24 770 $ |
| 20 | 6,4 % | 16,3 % | 0,1 % | 0,0 % | 0,17 | 0,013 % | 131 (6) | 0,88 | 7 % / 14 % / 80 % | 0 | 3 288 $ |
| 21 | 9,3 % | 20,0 % | 1,0 % | 0,0 % | 0,23 | 0,010 % | 152 (17) | 0,88 | 8 % / 21 % / 71 % | 1 | 12 211 $ |
| 22 | 10,3 % | 36,3 % | 1,1 % | 0,0 % | 0,22 | 0,017 % | 215 (7) | 0,26 | 6 % / 30 % / 63 % | 2 | 0 $ |
| 23 | 6,6 % | 14,6 % | 0,2 % | 0,0 % | 0,19 | 0,031 % | 143 (10) | 0,88 | 6 % / 13 % / 80 % | 0 | 9 541 $ |
| 24 | 7,0 % | 13,3 % | 0,0 % | 0,0 % | 0,19 | 0,050 % | 139 (11) | 0,88 | 6 % / 16 % / 78 % | 0 | 12 145 $ |
| 25 | 8,0 % | 17,5 % | 0,0 % | 0,0 % | 0,18 | 0,045 % | 148 (7) | 0,88 | 3 % / 20 % / 77 % | 0 | 0 $ |
| 26 | 5,4 % | 17,5 % | 0,1 % | 0,0 % | 0,17 | 0,040 % | 138 (12) | 0,88 | 7 % / 13 % / 81 % | 1 | 7 385 $ |
| 27 | 6,3 % | 18,3 % | 0,1 % | 0,0 % | 0,18 | 0,006 % | 132 (4) | 0,88 | 2 % / 18 % / 79 % | 1 | 13 247 $ |
| 28 | 6,9 % | 19,6 % | 0,0 % | 0,0 % | 0,18 | 0,077 % | 108 (6) | 0,88 | 5 % / 17 % / 78 % | 0 | 0 $ |
| 29 | 7,3 % | 18,8 % | 0,0 % | 0,0 % | 0,20 | 0,057 % | 143 (9) | 0,88 | 3 % / 19 % / 78 % | 0 | 17 035 $ |
| 30 | 10,7 % | 35,8 % | 0,7 % | 0,1 % | 0,25 | 0,017 % | 264 (13) | 0,22 | 8 % / 19 % / 73 % | 0 | 0 $ |

</details>

## 2 bis (4). Avec filets, sauf « Plafond de dérive des prix et salaires »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,9 % | 3,6 pt (6,6 % – 10,2 %) | 5,4 % – 13,7 % | 8/30 |
| Chômage max | toute la partie | — | 18,3 % | 12,9 pt (16,5 % – 29,4 %) | 12,9 % – 46,3 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,7 pt (0,0 % – 0,7 %) | 0,0 % – 1,6 % | 0/30 |
| Faim max | toute la partie | — | 47,3 % | 63,7 pt (9,4 % – 73,1 %) | 0,0 % – 94,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,04 pt (0,0 % – 0,0 %) | 0,0 % – 1,5 % | 0/30 |
| Sans-abri max | toute la partie | — | 13,1 % | 32,1 pt (5,4 % – 37,5 %) | 0,8 % – 65,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,19 | 0,03 (0,19 – 0,22) | 0,16 – 0,31 | 18/30 |
| Gini en fin de partie | dernier jour | — | 0,20 | 0,09 (0,14 – 0,23) | 0,12 – 0,32 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,033 % | 0,032 pt (0,016 % – 0,048 %) | -0,062 % – 0,078 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 29,6 % | 26,4 pt (20,3 % – 46,7 %) | 8,6 % – 104,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 140,3 % | 13,9 pt (135,2 % – 149,1 %) | 86,8 % – 207,7 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 9,5 | 4,8 (7,3 – 12) | 4 – 23 | 30/30 |
| … dont après la chauffe | après chauffe | — | 7 | 4,5 (6 – 10,5) | 2 – 22 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 91,5 | 138,5 (46,8 – 185,3) | 12 – 1263 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 146 | 77 (134,3 – 211,3) | 108 – 447 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,09 (0,79 – 0,88) | 0,20 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,98 | 0,02 (0,96 – 0,98) | 0,84 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,4 | 27,7 (0,3 – 28,0) | 0,3 – 529,7 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 39,8 (0 – 39,8) | 0 – 225 | — |
| Trésor de l’État le plus bas | après chauffe | — | 27 275 $ | 43 744 $ (4 919 $ – 48 663 $) | 2 919 $ – 59 167 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 739 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 38 | — |
| Créances radiées | toute la partie | — | 0 $ | 3 212 $ (0 $ – 3 212 $) | 0 $ – 43 177 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,75 | 14,24 (0,00 – 14,24) | 0,00 – 59,29 | 14/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 16,86 | 7,07 (13,91 – 20,98) | 8,64 – 32,54 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,05 (0,00 – 0,05) | 0,00 – 18,71 | 6/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 1,36 | 1/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,75 | 0,00 – 14,24 | 0,00 – 59,29 | 14/30 | 7886 | pas de producteur (100 %) ; pas de revenu (0 %) |
| Renflouement d’entreprise | 16,86 | 13,91 – 20,98 | 8,64 – 32,54 | 30/30 | 15925 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 0,05 | 0,00 – 18,71 | 6/30 | 3670 | parc plein (68 %) ; prix trop élevé (32 %) |
| Plafond de dérive des prix et salaires | coupé | — | — | — | — | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 1,36 | 1/30 | 53 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 2892 · 30, Tourisme 2288 · 26, Bijouterie 1510 · 28, Garage 1423 · 20, Fonderie 1389 · 30, Pêcherie 927 · 29, Mine de fer 599 · 30, Puits de pétrole 469 · 18.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plafond de dérive des prix et salaires »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 7,9 % | 8 → 8 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 18,3 % | 18,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 47,3 % | 47,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 13,1 % | 13,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,19 | 0,19 | 18 → 18 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,20 | 0,20 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,033 % | 0,033 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 29,6 % | 29,6 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 140,3 % | 140,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 9,5 | 9,5 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 7 | 7 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 91,5 | 91,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 146 | 146 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,98 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 27 275 $ | 27 275 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,75 | 0,75 | 14 → 14 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 16,86 | 16,86 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 6 → 6 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plafond de dérive des prix et salaires »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,7 % | 17,9 % | 0,0 % | 0,0 % | 0,25 | -0,029 % | 140 (9) | 0,88 | 6 % / 14 % / 80 % | 0 | 0 $ |
| 2 | 10,5 % | 42,9 % | 1,1 % | 0,1 % | 0,27 | 0,020 % | 247 (14) | 0,20 | 12 % / 19 % / 69 % | 2 | 1 450 $ |
| 3 | 8,0 % | 18,3 % | 0,0 % | 0,0 % | 0,16 | 0,047 % | 115 (4) | 0,88 | 6 % / 13 % / 80 % | 1 | 2 394 $ |
| 4 | 11,5 % | 35,0 % | 0,8 % | 0,1 % | 0,26 | 0,015 % | 187 (12) | 0,61 | 5 % / 8 % / 86 % | 1 | 0 $ |
| 5 | 8,0 % | 17,5 % | 0,0 % | 0,0 % | 0,20 | 0,034 % | 197 (10) | 0,88 | 8 % / 13 % / 79 % | 1 | 0 $ |
| 6 | 13,7 % | 46,3 % | 1,6 % | 0,8 % | 0,30 | -0,062 % | 447 (23) | 0,53 | 7 % / 15 % / 79 % | 1 | 21 887 $ |
| 7 | 6,6 % | 12,9 % | 0,1 % | 0,0 % | 0,19 | 0,073 % | 132 (7) | 0,88 | 7 % / 13 % / 79 % | 1 | 5 530 $ |
| 8 | 9,8 % | 23,8 % | 0,5 % | 0,0 % | 0,19 | 0,032 % | 200 (10) | 0,86 | 7 % / 18 % / 75 % | 0 | 3 899 $ |
| 9 | 10,9 % | 31,3 % | 1,2 % | 0,1 % | 0,26 | 0,016 % | 278 (8) | 0,31 | 3 % / 30 % / 67 % | 1 | 0 $ |
| 10 | 6,6 % | 15,8 % | 0,0 % | 0,0 % | 0,20 | 0,024 % | 112 (6) | 0,88 | 5 % / 9 % / 85 % | 0 | 6 896 $ |
| 11 | 9,6 % | 35,4 % | 0,9 % | 0,0 % | 0,19 | 0,039 % | 244 (14) | 0,78 | 3 % / 18 % / 80 % | 0 | 7 245 $ |
| 12 | 8,5 % | 17,5 % | 0,2 % | 0,0 % | 0,19 | 0,048 % | 126 (9) | 0,88 | 7 % / 13 % / 80 % | 1 | 161 $ |
| 13 | 5,7 % | 17,9 % | 0,0 % | 0,0 % | 0,18 | 0,046 % | 146 (8) | 0,88 | 3 % / 18 % / 79 % | 0 | 12 729 $ |
| 14 | 7,9 % | 15,0 % | 0,0 % | 0,0 % | 0,19 | 0,066 % | 146 (4) | 0,88 | 6 % / 13 % / 81 % | 1 | 0 $ |
| 15 | 6,7 % | 15,0 % | 0,0 % | 0,0 % | 0,17 | 0,078 % | 179 (9) | 0,88 | 4 % / 18 % / 79 % | 1 | 0 $ |
| 16 | 11,4 % | 33,8 % | 0,9 % | 1,3 % | 0,31 | 0,018 % | 243 (19) | 0,31 | 8 % / 15 % / 77 % | 0 | 0 $ |
| 17 | 5,7 % | 13,8 % | 0,0 % | 0,0 % | 0,16 | 0,037 % | 145 (10) | 0,88 | 6 % / 12 % / 82 % | 0 | 21 208 $ |
| 18 | 8,1 % | 20,4 % | 0,0 % | 0,0 % | 0,20 | 0,063 % | 159 (12) | 0,88 | 7 % / 12 % / 81 % | 0 | 0 $ |
| 19 | 7,8 % | 22,9 % | 0,2 % | 0,0 % | 0,19 | 0,041 % | 132 (9) | 0,88 | 7 % / 13 % / 80 % | 1 | 26 239 $ |
| 20 | 6,4 % | 16,3 % | 0,1 % | 0,0 % | 0,17 | 0,013 % | 131 (6) | 0,88 | 7 % / 14 % / 80 % | 0 | 3 288 $ |
| 21 | 10,9 % | 21,7 % | 0,0 % | 0,0 % | 0,22 | -0,047 % | 223 (13) | 0,82 | 8 % / 13 % / 79 % | 0 | 5 337 $ |
| 22 | 10,3 % | 36,3 % | 1,1 % | 0,0 % | 0,22 | 0,017 % | 215 (7) | 0,26 | 6 % / 30 % / 63 % | 2 | 0 $ |
| 23 | 6,6 % | 14,6 % | 0,2 % | 0,0 % | 0,19 | 0,031 % | 143 (10) | 0,88 | 6 % / 13 % / 80 % | 0 | 9 541 $ |
| 24 | 7,0 % | 13,3 % | 0,0 % | 0,0 % | 0,19 | 0,050 % | 139 (11) | 0,88 | 6 % / 16 % / 78 % | 0 | 12 145 $ |
| 25 | 7,3 % | 17,1 % | 0,2 % | 0,4 % | 0,21 | 0,002 % | 176 (10) | 0,88 | 3 % / 20 % / 78 % | 1 | 5 152 $ |
| 26 | 5,4 % | 17,5 % | 0,1 % | 0,0 % | 0,17 | 0,040 % | 138 (12) | 0,88 | 7 % / 13 % / 81 % | 1 | 7 385 $ |
| 27 | 6,3 % | 18,3 % | 0,1 % | 0,0 % | 0,18 | -0,011 % | 133 (4) | 0,88 | 3 % / 18 % / 79 % | 1 | 1 292 $ |
| 28 | 6,9 % | 19,6 % | 0,0 % | 0,0 % | 0,18 | 0,077 % | 108 (6) | 0,88 | 5 % / 17 % / 78 % | 0 | 0 $ |
| 29 | 5,8 % | 18,8 % | 0,1 % | 0,0 % | 0,19 | 0,051 % | 141 (8) | 0,88 | 7 % / 13 % / 80 % | 0 | 21 837 $ |
| 30 | 13,5 % | 34,6 % | 1,0 % | 1,5 % | 0,28 | 0,017 % | 414 (19) | 0,35 | 6 % / 23 % / 71 % | 1 | 0 $ |

</details>

## 2 bis (5). Avec filets, sauf « Anti-crédit-fou »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,9 % | 3,6 pt (6,6 % – 10,2 %) | 5,4 % – 13,7 % | 8/30 |
| Chômage max | toute la partie | — | 18,3 % | 12,9 pt (16,5 % – 29,4 %) | 12,9 % – 46,3 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,7 pt (0,0 % – 0,7 %) | 0,0 % – 1,6 % | 0/30 |
| Faim max | toute la partie | — | 47,3 % | 63,7 pt (9,4 % – 73,1 %) | 0,0 % – 94,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,04 pt (0,0 % – 0,0 %) | 0,0 % – 1,5 % | 0/30 |
| Sans-abri max | toute la partie | — | 13,1 % | 32,1 pt (5,4 % – 37,5 %) | 0,8 % – 65,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,19 | 0,03 (0,19 – 0,22) | 0,16 – 0,31 | 18/30 |
| Gini en fin de partie | dernier jour | — | 0,20 | 0,09 (0,14 – 0,23) | 0,12 – 0,39 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,033 % | 0,032 pt (0,015 % – 0,048 %) | -0,062 % – 0,078 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 29,8 % | 26,4 pt (20,3 % – 46,7 %) | 8,6 % – 104,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 140,3 % | 13,9 pt (135,2 % – 149,1 %) | 86,8 % – 207,7 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 9,5 | 4,8 (7,3 – 12) | 4 – 23 | 30/30 |
| … dont après la chauffe | après chauffe | — | 7 | 4,5 (6 – 10,5) | 2 – 22 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 91,5 | 138,5 (46,8 – 185,3) | 12 – 1263 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 146 | 77 (134,3 – 211,3) | 108 – 447 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,09 (0,79 – 0,88) | 0,20 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,98 | 0,02 (0,96 – 0,98) | 0,84 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,4 | 27,7 (0,3 – 28,0) | 0,3 – 529,7 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 39,8 (0 – 39,8) | 0 – 225 | — |
| Trésor de l’État le plus bas | après chauffe | — | 27 275 $ | 43 744 $ (4 919 $ – 48 663 $) | 2 919 $ – 59 167 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 739 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 3 212 $ (0 $ – 3 212 $) | 0 $ – 43 177 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,75 | 14,24 (0,00 – 14,24) | 0,00 – 59,29 | 14/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 16,86 | 7,07 (13,91 – 20,98) | 8,64 – 32,54 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,05 (0,00 – 0,05) | 0,00 – 18,50 | 6/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,75 | 0,00 – 14,24 | 0,00 – 59,29 | 14/30 | 7883 | pas de producteur (100 %) ; pas de revenu (0 %) |
| Renflouement d’entreprise | 16,86 | 13,91 – 20,98 | 8,64 – 32,54 | 30/30 | 15897 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 0,05 | 0,00 – 18,50 | 6/30 | 3664 | parc plein (68 %) ; prix trop élevé (32 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | coupé | — | — | — | — | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 2888 · 30, Tourisme 2281 · 26, Bijouterie 1514 · 28, Garage 1423 · 20, Fonderie 1389 · 30, Pêcherie 928 · 29, Mine de fer 599 · 30, Puits de pétrole 469 · 18.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-crédit-fou »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 7,9 % | 8 → 8 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 2 / 28 sur 30 | non concluant |
| Chômage max | 18,3 % | 18,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 0 / 29 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 0 / 29 sur 30 | non concluant |
| Faim max | 47,3 % | 47,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 0 / 29 sur 30 | non concluant |
| Sans-abri max | 13,1 % | 13,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,19 | 0,19 | 18 → 18 | 0,00 | [0,00 ; 0,00] | — / — / 28 | non concluant |
| Gini en fin de partie | 0,20 | 0,20 | — | 0,00 | [0,00 ; 0,00] | — / — / 28 | non concluant |
| Inflation moyenne / j | 0,033 % | 0,033 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 28 | non concluant |
| |Inflation| max / j | 29,6 % | 29,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| |Inflation sur 100 j| max | 140,3 % | 140,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 9,5 | 9,5 | 30 → 30 | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| … dont après la chauffe | 7 | 7 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 91,5 | 91,5 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 146 | 146 | — | 0 | [0 ; 0] | 2 / 0 / 28 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 2 / 0 / 28 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,98 | — | 0,00 | [0,00 ; 0,00] | 2 / 0 / 28 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | 0,0 | [0,0 ; 0,0] | 0 / 2 / 28 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 27 275 $ | 27 275 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 28 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,75 | 0,75 | 14 → 14 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 16,86 | 16,86 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 2 / 0 / 28 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 6 → 6 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-crédit-fou »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,7 % | 17,9 % | 0,0 % | 0,0 % | 0,25 | -0,029 % | 140 (9) | 0,88 | 6 % / 14 % / 80 % | 0 | 0 $ |
| 2 | 10,5 % | 42,9 % | 1,1 % | 0,1 % | 0,27 | 0,020 % | 247 (14) | 0,20 | 12 % / 19 % / 69 % | 2 | 1 450 $ |
| 3 | 8,0 % | 18,3 % | 0,0 % | 0,0 % | 0,16 | 0,047 % | 115 (4) | 0,88 | 6 % / 13 % / 80 % | 1 | 2 394 $ |
| 4 | 11,5 % | 35,0 % | 0,8 % | 0,1 % | 0,26 | 0,015 % | 187 (12) | 0,61 | 5 % / 8 % / 86 % | 1 | 0 $ |
| 5 | 8,0 % | 17,5 % | 0,0 % | 0,0 % | 0,20 | 0,034 % | 197 (10) | 0,88 | 8 % / 13 % / 79 % | 1 | 0 $ |
| 6 | 13,7 % | 46,3 % | 1,6 % | 0,8 % | 0,30 | -0,062 % | 447 (23) | 0,53 | 7 % / 15 % / 79 % | 1 | 21 887 $ |
| 7 | 6,6 % | 12,9 % | 0,1 % | 0,0 % | 0,19 | 0,073 % | 132 (7) | 0,88 | 7 % / 13 % / 79 % | 1 | 5 530 $ |
| 8 | 9,8 % | 23,8 % | 0,5 % | 0,0 % | 0,19 | 0,032 % | 200 (10) | 0,86 | 7 % / 18 % / 75 % | 0 | 3 899 $ |
| 9 | 10,9 % | 31,3 % | 1,2 % | 0,1 % | 0,26 | 0,016 % | 278 (8) | 0,31 | 3 % / 30 % / 67 % | 1 | 0 $ |
| 10 | 6,6 % | 15,8 % | 0,0 % | 0,0 % | 0,20 | 0,024 % | 112 (6) | 0,88 | 5 % / 9 % / 85 % | 0 | 6 896 $ |
| 11 | 9,6 % | 35,4 % | 0,9 % | 0,0 % | 0,19 | 0,039 % | 244 (14) | 0,78 | 3 % / 18 % / 80 % | 0 | 7 245 $ |
| 12 | 8,5 % | 17,5 % | 0,2 % | 0,0 % | 0,19 | 0,048 % | 126 (9) | 0,88 | 7 % / 13 % / 80 % | 1 | 161 $ |
| 13 | 5,7 % | 17,9 % | 0,0 % | 0,0 % | 0,18 | 0,046 % | 146 (8) | 0,88 | 3 % / 18 % / 79 % | 0 | 12 729 $ |
| 14 | 7,9 % | 15,0 % | 0,0 % | 0,0 % | 0,19 | 0,066 % | 146 (4) | 0,88 | 6 % / 13 % / 81 % | 1 | 0 $ |
| 15 | 6,7 % | 15,0 % | 0,0 % | 0,0 % | 0,17 | 0,078 % | 179 (9) | 0,88 | 4 % / 18 % / 79 % | 1 | 0 $ |
| 16 | 11,6 % | 31,7 % | 0,9 % | 1,3 % | 0,31 | -0,003 % | 231 (14) | 0,33 | 5 % / 15 % / 80 % | 0 | 0 $ |
| 17 | 5,7 % | 13,8 % | 0,0 % | 0,0 % | 0,16 | 0,037 % | 145 (10) | 0,88 | 6 % / 12 % / 82 % | 0 | 21 208 $ |
| 18 | 8,1 % | 20,4 % | 0,0 % | 0,0 % | 0,20 | 0,063 % | 159 (12) | 0,88 | 7 % / 12 % / 81 % | 0 | 0 $ |
| 19 | 7,8 % | 22,9 % | 0,2 % | 0,0 % | 0,19 | 0,041 % | 132 (9) | 0,88 | 7 % / 13 % / 80 % | 1 | 26 239 $ |
| 20 | 6,4 % | 16,3 % | 0,1 % | 0,0 % | 0,17 | 0,013 % | 131 (6) | 0,88 | 7 % / 14 % / 80 % | 0 | 3 288 $ |
| 21 | 10,9 % | 21,7 % | 0,0 % | 0,0 % | 0,22 | -0,047 % | 223 (13) | 0,82 | 8 % / 13 % / 79 % | 0 | 5 337 $ |
| 22 | 10,3 % | 36,3 % | 1,1 % | 0,0 % | 0,22 | 0,017 % | 215 (7) | 0,26 | 6 % / 30 % / 63 % | 2 | 0 $ |
| 23 | 6,6 % | 14,6 % | 0,2 % | 0,0 % | 0,19 | 0,031 % | 143 (10) | 0,88 | 6 % / 13 % / 80 % | 0 | 9 541 $ |
| 24 | 7,0 % | 13,3 % | 0,0 % | 0,0 % | 0,19 | 0,050 % | 139 (11) | 0,88 | 6 % / 16 % / 78 % | 0 | 12 145 $ |
| 25 | 7,3 % | 17,1 % | 0,2 % | 0,4 % | 0,21 | 0,002 % | 176 (10) | 0,88 | 3 % / 20 % / 78 % | 1 | 5 152 $ |
| 26 | 5,4 % | 17,5 % | 0,1 % | 0,0 % | 0,17 | 0,040 % | 138 (12) | 0,88 | 7 % / 13 % / 81 % | 1 | 7 385 $ |
| 27 | 6,3 % | 18,3 % | 0,1 % | 0,0 % | 0,18 | -0,011 % | 133 (4) | 0,88 | 3 % / 18 % / 79 % | 1 | 1 292 $ |
| 28 | 6,9 % | 19,6 % | 0,0 % | 0,0 % | 0,18 | 0,077 % | 108 (6) | 0,88 | 5 % / 17 % / 78 % | 0 | 0 $ |
| 29 | 5,8 % | 18,8 % | 0,1 % | 0,0 % | 0,19 | 0,051 % | 141 (8) | 0,88 | 7 % / 13 % / 80 % | 0 | 21 837 $ |
| 30 | 13,6 % | 34,6 % | 1,0 % | 1,5 % | 0,28 | 0,020 % | 409 (19) | 0,35 | 10 % / 19 % / 71 % | 1 | 4 960 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 30/30 : g1 35, g2 40, g3 24, g4 26, g5 35, g6 35, g7 25, g8 28, … |
| Chômage moyen ≤ 10 % | ❌ | 6/30 : g2 11,7 %, g5 31,8 %, g6 10,5 %, g22 11,4 %, g29 67,4 %, g30 10,6 % |
| Faim et sans-abri < 2 % | ❌ | 29/30 : g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, … |
| Gini 0,2–0,45 | ❌ | 4/30 : g3 0,47, g5 0,50, g9 0,51, g29 0,72 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 30 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 30 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 14/30 graines ; Renflouement d’entreprise : 30/30 graines ; Plancher de logement : 6/30 graines ; Anti-crédit-fou : 1/30 graines |

### Critère de l’institution : avec filets, sauf « anti-famine »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-famine » : chômage moyen ≤ 10 % | ❌ | 5/30 : g2 10,5 %, g8 14,6 %, g16 11,6 %, g21 10,9 %, g30 11,0 % |
| Sans « Anti-famine » : faim et sans-abri < 2 % | ❌ | 5/30 : g2, g6, g8, g9, g16 |
| Sans « Anti-famine » : aucune alerte critique | ❌ | 30/30 : g1 9, g2 20, g3 4, g4 10, g5 10, g6 15, g7 7, g8 16, … |

### Critère de l’institution : avec filets, sauf « renflouement d’entreprise »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Renflouement d’entreprise » : chômage moyen ≤ 10 % | ❌ | 7/30 : g4 10,1 %, g6 11,5 %, g8 10,2 %, g9 10,9 %, g15 11,5 %, g19 12,4 %, g22 10,7 % |
| Sans « Renflouement d’entreprise » : faim et sans-abri < 2 % | ❌ | 29/30 : g1, g2, g3, g4, g5, g6, g7, g8, g9, g10, … |
| Sans « Renflouement d’entreprise » : aucune alerte critique | ❌ | 30/30 : g1 20, g2 17, g3 15, g4 23, g5 16, g6 27, g7 18, g8 18, … |

### Critère de l’institution : avec filets, sauf « plancher de logement »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plancher de logement » : chômage moyen ≤ 10 % | ❌ | 4/30 : g6 11,3 %, g9 10,8 %, g22 10,3 %, g30 10,7 % |
| Sans « Plancher de logement » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Plancher de logement » : aucune alerte critique | ❌ | 30/30 : g1 9, g2 14, g3 4, g4 11, g5 19, g6 22, g7 7, g8 11, … |

### Critère de l’institution : avec filets, sauf « plafond de dérive des prix et salaires »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plafond de dérive des prix et salaires » : chômage moyen ≤ 10 % | ❌ | 8/30 : g2 10,5 %, g4 11,5 %, g6 13,7 %, g9 10,9 %, g16 11,4 %, g21 10,9 %, g22 10,3 %, g30 13,5 % |
| Sans « Plafond de dérive des prix et salaires » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Plafond de dérive des prix et salaires » : aucune alerte critique | ❌ | 30/30 : g1 9, g2 14, g3 4, g4 12, g5 10, g6 23, g7 7, g8 10, … |

### Critère de l’institution : avec filets, sauf « anti-crédit-fou »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-crédit-fou » : chômage moyen ≤ 10 % | ❌ | 8/30 : g2 10,5 %, g4 11,5 %, g6 13,7 %, g9 10,9 %, g16 11,6 %, g21 10,9 %, g22 10,3 %, g30 13,6 % |
| Sans « Anti-crédit-fou » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Anti-crédit-fou » : aucune alerte critique | ❌ | 30/30 : g1 9, g2 14, g3 4, g4 12, g5 10, g6 23, g7 7, g8 10, … |

