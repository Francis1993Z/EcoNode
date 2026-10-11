# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 13:26
- Graines : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Dividendes : test de solvabilité, Hôpital et école publics : enveloppe et file d’attente, Assurance-emploi indexée et aide sociale, Caisse : règles prudentielles, Faillite ordonnée
- Temps total : 7 min 1 s pour 510 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 28,5 % | 57,5 pt (10,1 % – 67,5 %) | 6,5 % – 85,0 % | 23/30 |
| Chômage max | toute la partie | — | 74,4 % | 52,4 pt (40,5 % – 92,9 %) | 17,5 % – 100,0 % | — |
| Faim moyenne | après chauffe | < 2 % | 16,9 % | 63,1 pt (8,8 % – 71,9 %) | 0,1 % – 91,2 % | 26/30 |
| Faim max | toute la partie | — | 96,5 % | 9,1 pt (90,9 % – 100,0 %) | 40,8 % – 100,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 16,8 % | 59,3 pt (4,2 % – 63,5 %) | 0,5 % – 91,5 % | 24/30 |
| Sans-abri max | toute la partie | — | 69,2 % | 28,2 pt (60,6 % – 88,9 %) | 37,1 % – 100,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,47 | 0,34 (0,34 – 0,68) | 0,25 – 0,84 | 16/30 |
| Gini en fin de partie | dernier jour | — | 0,67 | 0,64 (0,31 – 0,95) | 0,19 – 0,99 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,027 % | 0,040 pt (-0,003 % – 0,037 %) | -0,038 % – 0,070 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 9,6 % | 17,5 pt (4,3 % – 21,8 %) | 1,5 % – 69,3 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 126,5 % | 30,2 pt (106,9 % – 137,1 %) | 85,3 % – 186,6 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 19 | 12,8 (12 – 24,8) | 8 – 44 | 30/30 |
| … dont après la chauffe | après chauffe | — | 15,5 | 11,8 (9,3 – 21) | 5 – 42 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 3030,5 | 2623,5 (1822,5 – 4446) | 1421 – 5222 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 671 | 396,3 (474,8 – 871) | 240 – 1217 | — |
| Santé moyenne | après chauffe | — | 0,11 | 0,02 (0,10 – 0,12) | 0,09 – 0,16 | — |
| Bonheur moyen | après chauffe | — | 0,64 | 0,51 (0,27 – 0,78) | 0,10 – 0,83 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 521,5 | 1030,8 (0 – 1030,8) | 0 – 1243 | — |
| Trésor de l’État le plus bas | après chauffe | — | 2 012 $ | 67 180 $ (323 $ – 67 503 $) | 0 $ – 149 922 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 1122,5 | 824,8 (412 – 1236,8) | 0 – 1373 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 46 144 $ | 18 848 $ (35 775 $ – 54 623 $) | 14 423 $ – 97 562 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 22/30 | 1 | 0,3 – 1 | 0 – 5 | 532 j |
| Faim répandue | critique | 30/30 | 4 | 2,3 – 8,8 | 1 – 12 | 453,5 j |
| Sans-abri nombreux | critique | 30/30 | 9 | 6 – 11,8 | 2 – 21 | 680,5 j |
| Inégalités hors bornes | attention | 24/30 | 1 | 1 – 2 | 0 – 6 | 350,5 j |
| Richesse médiane hors bornes | attention | 18/30 | 1 | 0 – 2 | 0 – 6 | 44 j |
| Inflation quotidienne | critique | 18/30 | 1 | 0 – 2,8 | 0 – 12 | 1 j |
| Inflation sur 100 jours | critique | 26/30 | 1 | 1 – 1 | 0 – 3 | 17,5 j |
| Rupture de stock prolongée | attention | 30/30 | 148,5 | 100,5 – 206 | 53 – 280 | 5679,5 j |
| Surstock | attention | 30/30 | 21,5 | 12,3 – 36 | 7 – 82 | 315 j |
| Entreprise sans employé | attention | 30/30 | 219 | 145,5 – 294,5 | 76 – 429 | 3034 j |
| Entreprise sans client | attention | 30/30 | 218,5 | 143,8 – 297,5 | 74 – 432 | 4880 j |
| Caisse insolvable | attention | 23/30 | 1 | 1 – 1 | 0 – 2 | 1122,5 j |
| Santé de la population effondrée | critique | 30/30 | 1 | 1 – 1 | 1 – 1 | 1332 j |
| Productivité du travail effondrée | attention | 30/30 | 1 | 1 – 1 | 1 – 13 | 1332,5 j |
| Pénurie de main-d’œuvre | attention | 12/30 | 0 | 0 – 1 | 0 – 1 | 0 j |
| Embauches bloquées faute de moyens | attention | 30/30 | 11 | 6,3 – 13 | 3 – 18 | 542,5 j |
| Prix aberrant | attention | 30/30 | 12,5 | 8 – 15 | 2 – 28 | 2030,5 j |
| Prestations réduites faute de trésor | attention | 20/30 | 1 | 0 – 1 | 0 – 3 | 521,5 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 7,2 % | 25,8 % | 10,9 % | 5,3 % | 0,48 | 0,037 % | 466 (29) | 0,12 | 9 % / 24 % / 67 % | 4 | 20 943 $ |
| 2 | 6,9 % | 18,3 % | 0,2 % | 0,5 % | 0,28 | 0,027 % | 240 (12) | 0,11 | 8 % / 24 % / 69 % | 1 | 3 745 $ |
| 3 | 6,9 % | 17,5 % | 0,2 % | 1,2 % | 0,27 | 0,037 % | 264 (14) | 0,12 | 10 % / 23 % / 67 % | 1 | 9 468 $ |
| 4 | 68,1 % | 97,9 % | 72,7 % | 70,7 % | 0,44 | -0,005 % | 853 (17) | 0,11 | 0 % / 33 % / 67 % | 5 | 0 $ |
| 5 | 12,5 % | 49,2 % | 12,6 % | 7,9 % | 0,52 | 0,042 % | 522 (34) | 0,13 | 8 % / 28 % / 64 % | 4 | 23 768 $ |
| 6 | 25,3 % | 74,6 % | 18,6 % | 8,8 % | 0,52 | 0,044 % | 773 (27) | 0,09 | 17 % / 28 % / 54 % | 8 | 5 552 $ |
| 7 | 33,3 % | 73,8 % | 9,8 % | 17,1 % | 0,69 | -0,026 % | 1047 (44) | 0,11 | 8 % / 25 % / 67 % | 9 | 2 769 $ |
| 8 | 7,3 % | 37,5 % | 1,7 % | 1,4 % | 0,26 | 0,036 % | 347 (13) | 0,12 | 10 % / 20 % / 69 % | 2 | 6 298 $ |
| 9 | 10,2 % | 40,4 % | 5,1 % | 3,4 % | 0,36 | 0,035 % | 596 (19) | 0,10 | 11 % / 22 % / 67 % | 2 | 9 784 $ |
| 10 | 52,9 % | 92,9 % | 56,7 % | 40,4 % | 0,68 | -0,017 % | 639 (24) | 0,11 | 13 % / 8 % / 79 % | 10 | 0 $ |
| 11 | 43,7 % | 74,6 % | 17,3 % | 27,3 % | 0,69 | -0,024 % | 720 (25) | 0,16 | 16 % / 25 % / 59 % | 6 | 1 269 $ |
| 12 | 10,0 % | 40,8 % | 11,4 % | 4,4 % | 0,46 | 0,070 % | 735 (26) | 0,09 | 13 % / 18 % / 69 % | 6 | 13 852 $ |
| 13 | 77,1 % | 92,9 % | 90,6 % | 64,7 % | 0,83 | -0,038 % | 1217 (12) | 0,09 | 12 % / 8 % / 81 % | 17 | 0 $ |
| 14 | 26,3 % | 83,3 % | 20,3 % | 16,4 % | 0,52 | 0,069 % | 501 (22) | 0,13 | 0 % / 10 % / 90 % | 8 | 0 $ |
| 15 | 13,8 % | 74,2 % | 10,3 % | 5,5 % | 0,44 | 0,038 % | 326 (23) | 0,13 | 13 % / 21 % / 66 % | 4 | 16 467 $ |
| 16 | 7,9 % | 28,7 % | 5,2 % | 1,8 % | 0,35 | 0,028 % | 742 (23) | 0,11 | 11 % / 18 % / 72 % | 3 | 17 886 $ |
| 17 | 19,6 % | 88,3 % | 17,3 % | 9,3 % | 0,42 | 0,021 % | 290 (11) | 0,12 | 3 % / 39 % / 58 % | 2 | 0 $ |
| 18 | 72,5 % | 100,0 % | 74,7 % | 73,5 % | 0,25 | 0,022 % | 518 (8) | 0,09 | 0 % / 100 % / 0 % | 3 | 0 $ |
| 19 | 6,5 % | 21,7 % | 0,1 % | 0,6 % | 0,26 | 0,042 % | 313 (12) | 0,11 | 12 % / 23 % / 65 % | 1 | 32 463 $ |
| 20 | 30,7 % | 72,1 % | 16,5 % | 19,4 % | 0,59 | 0,023 % | 877 (24) | 0,11 | 9 % / 36 % / 54 % | 6 | 3 556 $ |
| 21 | 79,1 % | 94,2 % | 90,4 % | 69,7 % | 0,83 | 0,013 % | 994 (12) | 0,10 | 14 % / 14 % / 71 % | 12 | 0 $ |
| 22 | 57,4 % | 100,0 % | 58,7 % | 56,8 % | 0,27 | 0,028 % | 350 (19) | 0,11 | 0 % / 0 % / 100 % | 2 | 0 $ |
| 23 | 7,2 % | 26,3 % | 4,1 % | 1,5 % | 0,32 | 0,032 % | 523 (25) | 0,10 | 7 % / 29 % / 64 % | 4 | 13 106 $ |
| 24 | 11,1 % | 65,0 % | 8,5 % | 4,1 % | 0,34 | 0,067 % | 603 (22) | 0,11 | 1 % / 40 % / 58 % | 9 | 3 741 $ |
| 25 | 72,3 % | 92,1 % | 76,9 % | 59,9 % | 0,78 | -0,035 % | 1074 (14) | 0,12 | 0 % / 15 % / 85 % | 14 | 0 $ |
| 26 | 65,8 % | 97,5 % | 69,6 % | 68,3 % | 0,41 | 0,028 % | 831 (19) | 0,09 | 0 % / 14 % / 86 % | 6 | 0 $ |
| 27 | 81,6 % | 97,1 % | 89,0 % | 71,4 % | 0,84 | 0,020 % | 703 (9) | 0,09 | 18 % / 24 % / 59 % | 6 | 0 $ |
| 28 | 77,6 % | 92,5 % | 90,7 % | 66,9 % | 0,83 | -0,013 % | 1150 (11) | 0,10 | 4 % / 20 % / 76 % | 14 | 0 $ |
| 29 | 85,0 % | 97,5 % | 91,2 % | 91,5 % | 0,49 | 0,005 % | 906 (10) | 0,09 | 0 % / 27 % / 73 % | 3 | 0 $ |
| 30 | 38,4 % | 65,0 % | 10,7 % | 17,8 % | 0,68 | -0,020 % | 996 (36) | 0,13 | 3 % / 35 % / 62 % | 15 | 105 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 4,3 % | 1,1 pt (3,6 % – 4,7 %) | 2,5 % – 8,2 % | 0/30 |
| Chômage max | toute la partie | — | 14,8 % | 4,3 pt (12,7 % – 17,0 %) | 10,0 % – 37,5 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 1,8 % | 0/30 |
| Faim max | toute la partie | — | 36,9 % | 34,2 pt (15,9 % – 50,1 %) | 0,0 % – 80,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 2,9 % | 2/30 |
| Sans-abri max | toute la partie | — | 35,6 % | 20,5 pt (28,7 % – 49,3 %) | 12,1 % – 65,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,17 | 0,05 (0,16 – 0,20) | 0,13 – 0,33 | 22/30 |
| Gini en fin de partie | dernier jour | — | 0,19 | 0,11 (0,15 – 0,26) | 0,10 – 0,55 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,045 % | 0,056 pt (0,010 % – 0,066 %) | -0,015 % – 0,091 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 15,3 % | 47,1 pt (10,0 % – 57,1 %) | 2,8 % – 75,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 113,2 % | 33,0 pt (95,2 % – 128,1 %) | 80,9 % – 159,9 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 7 | 4 (5 – 9) | 2 – 22 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3,5 | 3 (3 – 6) | 0 – 20 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 48 | 85,3 (40,5 – 125,8) | 19 – 1454 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 119,5 | 46,3 (104,5 – 150,8) | 86 – 212 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,003 (0,87 – 0,88) | 0,14 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,98 | 0,002 (0,97 – 0,98) | 0,83 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 146 295 $ | 15 549 $ (138 185 $ – 153 734 $) | 75 920 $ – 160 275 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 1140 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 205 | — |
| Créances radiées | toute la partie | — | 9 049 $ | 9 407 $ (4 268 $ – 13 675 $) | 0 $ – 41 996 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,11 (0,00 – 0,11) | 0,00 – 50,68 | 5/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 26,66 | 8,82 (22,26 – 31,08) | 18,50 – 47,93 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,16 (0,00 – 0,16) | 0,00 – 103,04 | 7/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 7,32 | 5/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 8,27 | 1,75 (7,71 – 9,46) | 4,71 – 11,57 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,11 | 0,00 – 50,68 | 5/30 | 3971 | pas de producteur (100 %) |
| Renflouement d’entreprise | 26,66 | 22,26 – 31,08 | 18,50 – 47,93 | 30/30 | 25614 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 0,16 | 0,00 – 103,04 | 7/30 | 14586 | parc plein (59 %) ; prix trop élevé (41 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 7,32 | 5/30 | 580 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Hôpital 7109 · 30, Ferme 3713 · 30, École 1865 · 30, Garage 1532 · 28, Fonderie 1290 · 28, Pétrochimie 1265 · 29, Électronique 1077 · 30, Pêcherie 972 · 29.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,0 % | 16,7 % | 0,0 % | 0,0 % | 0,16 | 0,045 % | 134 (9) | 0,88 | 7 % / 13 % / 79 % | 0 | 99 070 $ |
| 2 | 7,1 % | 23,8 % | 0,0 % | 2,9 % | 0,30 | 0,036 % | 143 (21) | 0,30 | 9 % / 10 % / 81 % | 0 | 6 430 $ |
| 3 | 5,7 % | 19,2 % | 1,8 % | 1,0 % | 0,33 | 0,062 % | 151 (10) | 0,29 | 15 % / 20 % / 65 % | 1 | 7 391 $ |
| 4 | 8,2 % | 37,5 % | 0,1 % | 1,6 % | 0,31 | 0,045 % | 153 (16) | 0,27 | 11 % / 13 % / 75 % | 1 | 62 607 $ |
| 5 | 2,5 % | 12,5 % | 0,0 % | 0,0 % | 0,14 | 0,076 % | 134 (7) | 0,88 | 7 % / 13 % / 81 % | 0 | 32 538 $ |
| 6 | 4,1 % | 15,8 % | 0,0 % | 0,0 % | 0,15 | 0,000 % | 150 (9) | 0,88 | 3 % / 19 % / 78 % | 0 | 27 680 $ |
| 7 | 3,9 % | 14,2 % | 0,0 % | 0,0 % | 0,15 | 0,008 % | 157 (11) | 0,88 | 5 % / 13 % / 82 % | 0 | 27 564 $ |
| 8 | 4,4 % | 14,6 % | 0,0 % | 0,1 % | 0,18 | 0,042 % | 94 (4) | 0,88 | 7 % / 14 % / 79 % | 0 | 37 763 $ |
| 9 | 4,4 % | 11,3 % | 0,1 % | 0,0 % | 0,18 | 0,046 % | 117 (9) | 0,88 | 6 % / 9 % / 85 % | 0 | 30 400 $ |
| 10 | 4,4 % | 10,0 % | 0,0 % | 0,1 % | 0,17 | 0,005 % | 86 (4) | 0,88 | 6 % / 10 % / 85 % | 0 | 19 650 $ |
| 11 | 2,9 % | 14,6 % | 0,0 % | 0,0 % | 0,13 | 0,068 % | 117 (5) | 0,88 | 7 % / 13 % / 81 % | 0 | 40 268 $ |
| 12 | 2,8 % | 12,5 % | 0,0 % | 0,0 % | 0,16 | 0,089 % | 88 (6) | 0,88 | 6 % / 14 % / 79 % | 0 | 50 890 $ |
| 13 | 3,4 % | 12,5 % | 0,0 % | 0,1 % | 0,17 | 0,044 % | 100 (4) | 0,88 | 5 % / 17 % / 79 % | 0 | 84 086 $ |
| 14 | 4,7 % | 13,8 % | 0,0 % | 0,0 % | 0,20 | 0,010 % | 111 (9) | 0,88 | 7 % / 9 % / 84 % | 0 | 6 620 $ |
| 15 | 3,6 % | 10,8 % | 0,0 % | 0,0 % | 0,16 | 0,054 % | 116 (8) | 0,88 | 6 % / 13 % / 81 % | 0 | 32 399 $ |
| 16 | 4,2 % | 15,0 % | 0,1 % | 0,1 % | 0,16 | 0,090 % | 114 (5) | 0,88 | 6 % / 13 % / 81 % | 0 | 90 373 $ |
| 17 | 5,5 % | 21,7 % | 0,0 % | 0,0 % | 0,18 | 0,010 % | 157 (8) | 0,88 | 7 % / 14 % / 79 % | 0 | 16 040 $ |
| 18 | 4,6 % | 15,8 % | 0,1 % | 0,0 % | 0,20 | -0,004 % | 129 (5) | 0,87 | 5 % / 9 % / 86 % | 0 | 5 536 $ |
| 19 | 3,7 % | 17,1 % | 0,0 % | 0,6 % | 0,28 | 0,036 % | 100 (8) | 0,14 | 8 % / 11 % / 81 % | 0 | 0 $ |
| 20 | 3,4 % | 13,3 % | 0,0 % | 0,0 % | 0,15 | 0,049 % | 119 (5) | 0,88 | 7 % / 13 % / 80 % | 0 | 68 682 $ |
| 21 | 5,1 % | 25,0 % | 1,8 % | 0,5 % | 0,27 | 0,089 % | 212 (12) | 0,40 | 15 % / 20 % / 65 % | 2 | 0 $ |
| 22 | 2,7 % | 15,4 % | 0,0 % | 0,0 % | 0,16 | 0,005 % | 91 (4) | 0,88 | 6 % / 9 % / 85 % | 0 | 32 174 $ |
| 23 | 4,7 % | 11,7 % | 0,0 % | 0,0 % | 0,14 | 0,036 % | 158 (7) | 0,88 | 7 % / 13 % / 80 % | 0 | 35 727 $ |
| 24 | 4,2 % | 10,8 % | 0,0 % | 0,0 % | 0,14 | 0,069 % | 99 (6) | 0,88 | 8 % / 14 % / 77 % | 0 | 43 286 $ |
| 25 | 4,5 % | 16,3 % | 0,0 % | 0,3 % | 0,31 | 0,083 % | 158 (8) | 0,40 | 7 % / 22 % / 71 % | 0 | 0 $ |
| 26 | 4,1 % | 14,2 % | 0,1 % | 0,0 % | 0,17 | 0,040 % | 109 (2) | 0,88 | 7 % / 13 % / 80 % | 0 | 35 372 $ |
| 27 | 7,9 % | 30,0 % | 0,1 % | 2,3 % | 0,31 | 0,054 % | 201 (22) | 0,24 | 9 % / 11 % / 80 % | 1 | 17 269 $ |
| 28 | 4,9 % | 15,8 % | 0,0 % | 0,0 % | 0,18 | -0,007 % | 127 (7) | 0,88 | 7 % / 8 % / 85 % | 1 | 20 849 $ |
| 29 | 3,4 % | 13,3 % | 0,0 % | 0,0 % | 0,17 | 0,091 % | 103 (3) | 0,88 | 6 % / 17 % / 77 % | 0 | 56 588 $ |
| 30 | 4,3 % | 20,8 % | 0,0 % | 0,0 % | 0,21 | -0,015 % | 120 (4) | 0,88 | 6 % / 10 % / 85 % | 0 | 21 209 $ |

</details>

## 2 bis (1). Avec filets, sauf « Anti-famine »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 4,3 % | 1,3 pt (3,4 % – 4,8 %) | 2,5 % – 5,9 % | 0/30 |
| Chômage max | toute la partie | — | 14,6 % | 5,3 pt (12,5 % – 17,8 %) | 10,4 % – 22,5 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 1,5 % | 0/30 |
| Faim max | toute la partie | — | 35,4 % | 38,1 pt (15,5 % – 53,6 %) | 0,0 % – 100,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 1,5 % | 0/30 |
| Sans-abri max | toute la partie | — | 39,2 % | 20,2 pt (27,5 % – 47,7 %) | 20,8 % – 65,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,17 | 0,03 (0,16 – 0,19) | 0,14 – 0,32 | 25/30 |
| Gini en fin de partie | dernier jour | — | 0,19 | 0,05 (0,16 – 0,21) | 0,10 – 0,57 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,019 % | 0,050 pt (0,003 % – 0,053 %) | -0,008 % – 0,089 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 44,1 % | 50,0 pt (8,3 % – 58,2 %) | 2,8 % – 75,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 113,3 % | 31,0 pt (96,9 % – 127,9 %) | 79,3 % – 159,0 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 6,5 | 3,8 (5,3 – 9) | 2 – 13 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3,5 | 3,8 (2,3 – 6) | 0 – 10 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 60 | 50,5 (43 – 93,5) | 22 – 1473 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 124,5 | 38,5 (103,5 – 142) | 88 – 210 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,001 (0,88 – 0,88) | 0,16 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,98 | 0,002 (0,97 – 0,98) | 0,83 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 146 040 $ | 10 957 $ (140 196 $ – 151 153 $) | 121 679 $ – 159 483 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 4 318 $ | 7 628 $ (2 502 $ – 10 129 $) | 0 $ – 25 011 $ | — |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 26,77 | 5,88 (23,29 – 29,17) | 18,14 – 43,21 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,06 (0,00 – 0,06) | 0,00 – 63,07 | 5/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 8,48 | 1,07 (7,99 – 9,06) | 3,75 – 11,57 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | coupé | — | — | — | — | — |
| Renflouement d’entreprise | 26,77 | 23,29 – 29,17 | 18,14 – 43,21 | 30/30 | 24996 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 0,06 | 0,00 – 63,07 | 5/30 | 10811 | parc plein (76 %) ; prix trop élevé (24 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Hôpital 7095 · 30, Ferme 2526 · 30, École 1747 · 30, Fonderie 1709 · 29, Garage 1567 · 29, Pétrochimie 1268 · 29, Électronique 1172 · 30, Machinerie 1149 · 25.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-famine »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 4,3 % | 0 → 0 | 0,0 pt | [−0,1 pt ; +0,03 pt] | 11 / 11 / 8 sur 30 | non concluant |
| Chômage max | 14,8 % | 14,6 % | — | 0,0 pt | [−1,0 pt ; 0,0 pt] | 13 / 7 / 10 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 5 / 8 / 17 sur 30 | non concluant |
| Faim max | 36,9 % | 35,4 % | — | 0,0 pt | [0,0 pt ; +4,2 pt] | 5 / 14 / 11 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 2 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 9 / 8 / 13 sur 30 | non concluant |
| Sans-abri max | 35,6 % | 39,2 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 3 / 6 / 21 sur 30 | non concluant |
| Gini moyen | 0,17 | 0,17 | 22 → 25 | 0,00 | [−0,005 ; +0,0003] | — / — / 8 | non concluant |
| Gini en fin de partie | 0,19 | 0,19 | — | 0,00 | [−0,02 ; +0,01] | — / — / 8 | non concluant |
| Inflation moyenne / j | 0,045 % | 0,019 % | 0 → 0 | 0,000 pt | [−0,011 pt ; 0,000 pt] | — / — / 8 | non concluant |
| |Inflation| max / j | 15,3 % | 44,1 % | — | 0,0 pt | [0,0 pt ; +5,8 pt] | 8 / 12 / 10 sur 30 | non concluant |
| |Inflation sur 100 j| max | 113,2 % | 113,3 % | — | 0,0 pt | [0,0 pt ; +2,2 pt] | 8 / 12 / 10 sur 30 | non concluant |
| Alertes critiques ouvertes | 7 | 6,5 | 30 → 30 | 0 | [−0,5 ; 0] | 10 / 8 / 12 sur 30 | non concluant |
| … dont après la chauffe | 3,5 | 3,5 | — | 0 | [−0,5 ; 0] | 10 / 5 / 15 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 48 | 60 | — | 0 | [−2 ; +0,5] | 12 / 10 / 8 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 119,5 | 124,5 | — | 0 | [−9,5 ; 0] | 13 / 9 / 8 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [−0,0001 ; +0,0001] | 12 / 10 / 8 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,98 | — | 0,00 | [−0,00005 ; +0,0002] | 11 / 11 / 8 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 295 $ | 146 040 $ | — | 0 $ | [0 $ ; +804 $] | 11 / 9 / 10 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 4 / 0 / 26 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 25 | non concluant |
| Créances radiées | 9 049 $ | 4 318 $ | — | 0 $ | [−3 261 $ ; 0 $] | — / — / 11 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 26,66 | 26,77 | 30 → 30 | 0,00 | [−0,02 ; +0,38] | 10 / 12 / 8 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 7 → 5 | 0,00 | [0,00 ; 0,00] | 7 / 3 / 20 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 5 → 0 | 0,00 | [0,00 ; 0,00] | 5 / 0 / 25 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,27 | 8,48 | — | 0,00 | [−0,02 ; +0,07] | 10 / 11 / 9 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-famine »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,8 % | 17,5 % | 0,0 % | 0,0 % | 0,20 | -0,002 % | 92 (6) | 0,88 | 5 % / 9 % / 85 % | 0 | 23 038 $ |
| 2 | 4,3 % | 14,6 % | 0,1 % | 0,0 % | 0,16 | 0,077 % | 144 (11) | 0,88 | 4 % / 18 % / 79 % | 1 | 0 $ |
| 3 | 4,8 % | 18,8 % | 0,0 % | 0,2 % | 0,21 | 0,002 % | 124 (10) | 0,88 | 5 % / 9 % / 86 % | 0 | 9 234 $ |
| 4 | 3,6 % | 22,5 % | 0,0 % | 0,4 % | 0,17 | 0,024 % | 114 (10) | 0,88 | 6 % / 9 % / 85 % | 0 | 31 353 $ |
| 5 | 2,5 % | 12,5 % | 0,0 % | 0,0 % | 0,14 | 0,076 % | 134 (7) | 0,88 | 7 % / 13 % / 81 % | 0 | 32 538 $ |
| 6 | 4,1 % | 15,8 % | 0,0 % | 0,0 % | 0,15 | 0,000 % | 150 (9) | 0,88 | 3 % / 19 % / 78 % | 0 | 27 680 $ |
| 7 | 3,9 % | 14,2 % | 0,0 % | 0,0 % | 0,15 | 0,008 % | 157 (11) | 0,88 | 5 % / 13 % / 82 % | 0 | 27 564 $ |
| 8 | 4,4 % | 14,6 % | 0,0 % | 0,1 % | 0,18 | 0,042 % | 94 (4) | 0,88 | 7 % / 14 % / 79 % | 0 | 37 763 $ |
| 9 | 4,8 % | 17,9 % | 0,0 % | 0,0 % | 0,14 | 0,022 % | 125 (9) | 0,88 | 6 % / 9 % / 85 % | 0 | 39 133 $ |
| 10 | 5,4 % | 12,5 % | 0,7 % | 0,2 % | 0,16 | 0,056 % | 133 (6) | 0,88 | 7 % / 13 % / 80 % | 0 | 26 116 $ |
| 11 | 2,8 % | 12,5 % | 0,0 % | 0,0 % | 0,16 | 0,007 % | 103 (3) | 0,88 | 6 % / 10 % / 85 % | 0 | 79 590 $ |
| 12 | 2,8 % | 12,5 % | 0,0 % | 0,0 % | 0,16 | 0,089 % | 88 (6) | 0,88 | 6 % / 14 % / 79 % | 0 | 50 890 $ |
| 13 | 3,4 % | 12,5 % | 0,0 % | 0,1 % | 0,17 | 0,044 % | 100 (4) | 0,88 | 5 % / 17 % / 79 % | 0 | 84 086 $ |
| 14 | 3,6 % | 10,4 % | 0,0 % | 0,0 % | 0,18 | 0,016 % | 114 (7) | 0,88 | 7 % / 13 % / 80 % | 0 | 132 344 $ |
| 15 | 3,4 % | 15,4 % | 0,0 % | 0,0 % | 0,17 | 0,065 % | 98 (3) | 0,88 | 5 % / 15 % / 80 % | 0 | 86 743 $ |
| 16 | 4,0 % | 14,6 % | 0,1 % | 0,0 % | 0,16 | 0,082 % | 128 (6) | 0,88 | 7 % / 13 % / 80 % | 0 | 99 778 $ |
| 17 | 5,9 % | 20,4 % | 0,4 % | 0,0 % | 0,20 | 0,009 % | 171 (13) | 0,88 | 6 % / 9 % / 85 % | 0 | 7 689 $ |
| 18 | 4,4 % | 15,8 % | 0,2 % | 0,0 % | 0,20 | -0,004 % | 128 (5) | 0,87 | 6 % / 8 % / 86 % | 0 | 2 862 $ |
| 19 | 5,7 % | 18,8 % | 0,0 % | 1,1 % | 0,32 | 0,048 % | 210 (9) | 0,16 | 12 % / 20 % / 68 % | 0 | 37 176 $ |
| 20 | 3,4 % | 12,5 % | 0,0 % | 0,0 % | 0,15 | 0,009 % | 94 (6) | 0,88 | 3 % / 20 % / 77 % | 0 | 23 535 $ |
| 21 | 3,6 % | 12,5 % | 0,0 % | 0,0 % | 0,17 | 0,014 % | 121 (8) | 0,88 | 6 % / 10 % / 84 % | 0 | 15 745 $ |
| 22 | 2,7 % | 15,4 % | 0,0 % | 0,0 % | 0,16 | 0,005 % | 91 (4) | 0,88 | 6 % / 9 % / 85 % | 0 | 32 174 $ |
| 23 | 4,7 % | 11,7 % | 0,0 % | 0,0 % | 0,14 | 0,036 % | 158 (7) | 0,88 | 7 % / 13 % / 80 % | 0 | 35 727 $ |
| 24 | 5,4 % | 20,0 % | 1,5 % | 1,5 % | 0,26 | 0,055 % | 160 (10) | 0,28 | 9 % / 10 % / 81 % | 0 | 4 528 $ |
| 25 | 4,6 % | 13,8 % | 0,0 % | 0,0 % | 0,21 | -0,001 % | 125 (7) | 0,88 | 6 % / 10 % / 85 % | 0 | 6 410 $ |
| 26 | 4,2 % | 14,2 % | 0,2 % | 0,0 % | 0,17 | 0,040 % | 105 (2) | 0,88 | 6 % / 14 % / 80 % | 0 | 44 965 $ |
| 27 | 5,8 % | 15,0 % | 0,7 % | 0,5 % | 0,26 | 0,055 % | 175 (6) | 0,37 | 4 % / 19 % / 77 % | 0 | 15 949 $ |
| 28 | 5,0 % | 14,2 % | 0,0 % | 0,0 % | 0,18 | -0,008 % | 116 (6) | 0,87 | 7 % / 13 % / 80 % | 0 | 6 713 $ |
| 29 | 5,3 % | 17,9 % | 0,0 % | 0,0 % | 0,19 | -0,008 % | 136 (7) | 0,88 | 6 % / 13 % / 81 % | 0 | 0 $ |
| 30 | 3,2 % | 17,9 % | 0,0 % | 0,0 % | 0,19 | -0,005 % | 112 (5) | 0,88 | 5 % / 9 % / 86 % | 0 | 0 $ |

</details>

## 2 bis (2). Avec filets, sauf « Renflouement d’entreprise »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 6,6 % | 2,0 pt (5,7 % – 7,6 %) | 5,0 % – 56,5 % | 3/30 |
| Chômage max | toute la partie | — | 22,3 % | 5,9 pt (20,8 % – 26,8 %) | 12,9 % – 76,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 3,1 % | 3,8 pt (1,6 % – 5,4 %) | 0,0 % – 42,8 % | 21/30 |
| Faim max | toute la partie | — | 93,5 % | 17,6 pt (77,7 % – 95,3 %) | 13,8 % – 96,7 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 1,3 % | 0,7 pt (1,0 % – 1,7 %) | 0,3 % – 25,1 % | 6/30 |
| Sans-abri max | toute la partie | — | 41,5 % | 19,8 pt (33,5 % – 53,3 %) | 14,6 % – 65,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,39 | 0,10 (0,34 – 0,44) | 0,24 – 0,79 | 6/30 |
| Gini en fin de partie | dernier jour | — | 0,52 | 0,37 (0,34 – 0,71) | 0,22 – 0,92 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,055 % | 0,027 pt (0,041 % – 0,068 %) | -0,043 % – 0,083 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 4,5 % | 2,1 pt (3,5 % – 5,6 %) | 1,6 % – 70,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 115,8 % | 27,1 pt (102,7 % – 129,7 %) | 81,8 % – 157,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 16 | 8,8 (8,3 – 17) | 5 – 24 | 30/30 |
| … dont après la chauffe | après chauffe | — | 12,5 | 8,8 (5,3 – 14) | 3 – 21 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 1531 | 92,8 (1485,8 – 1578,5) | 1358 – 4829 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 352,5 | 248,5 (268 – 516,5) | 207 – 1049 | — |
| Santé moyenne | après chauffe | — | 0,12 | 0,02 (0,11 – 0,13) | 0,10 – 0,17 | — |
| Bonheur moyen | après chauffe | — | 0,81 | 0,02 (0,80 – 0,82) | 0,42 – 0,83 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 1201 | — |
| Trésor de l’État le plus bas | après chauffe | — | 136 248 $ | 31 249 $ (116 907 $ – 148 156 $) | 577 $ – 168 853 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 48 | 1074,3 (0 – 1074,3) | 0 – 1376 | — |
| Prêts refusés | toute la partie | — | 141 | 207,8 (8,5 – 216,3) | 0 – 398 | — |
| Créances radiées | toute la partie | — | 29 831 $ | 12 032 $ (21 503 $ – 33 536 $) | 10 191 $ – 44 702 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 84,13 | 139,39 (39,04 – 178,43) | 0,00 – 2270,46 | 27/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 22,66 | 24,17 (15,62 – 39,79) | 3,18 – 682,93 | 30/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 5,04 | 7,42 (0,30 – 7,72) | 0,00 – 14,21 | 20/30 |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 84,13 | 39,04 – 178,43 | 0,00 – 2270,46 | 27/30 | 172795 | pas de producteur (83 %) ; prix trop élevé (17 %) |
| Renflouement d’entreprise | coupé | — | — | — | — | — |
| Plancher de logement | 22,66 | 15,62 – 39,79 | 3,18 – 682,93 | 30/30 | 61557 | prix trop élevé (71 %) ; parc plein (29 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 5,04 | 0,30 – 7,72 | 0,00 – 14,21 | 20/30 | 4134 | fonds propres de la Caisse insuffisants (100 %) |

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « renflouement d’entreprise »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 6,6 % | 0 → 3 | +2,6 pt | [+1,9 pt ; +3,2 pt] | 3 / 27 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 14,8 % | 22,3 % | — | +8,5 pt | [+5,6 pt ; +10,6 pt] | 4 / 26 / 0 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 3,1 % | 0 → 21 | +2,9 pt | [+2,1 pt ; +5,2 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Faim max | 36,9 % | 93,5 % | — | +42,7 pt | [+31,3 pt ; +60,8 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri moyen | 0,0 % | 1,3 % | 2 → 6 | +1,1 pt | [+0,6 pt ; +1,5 pt] | 2 / 28 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 35,6 % | 41,5 % | — | +2,5 pt | [−0,2 pt ; +5,2 pt] | 10 / 17 / 3 sur 30 | non concluant |
| Gini moyen | 0,17 | 0,39 | 22 → 6 | +0,19 | [+0,12 ; +0,22] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,19 | 0,52 | — | +0,29 | [+0,17 ; +0,42] | — / — / 0 | **B plus haut** |
| Inflation moyenne / j | 0,045 % | 0,055 % | 0 → 0 | +0,003 pt | [−0,005 pt ; +0,030 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 15,3 % | 4,5 % | — | −10,6 pt | [−39,9 pt ; −7,8 pt] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |
| |Inflation sur 100 j| max | 113,2 % | 115,8 % | — | +8,2 pt | [−1,2 pt ; +13,2 pt] | 11 / 19 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 7 | 16 | 30 → 30 | +7 | [+3 ; +9] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 3,5 | 12,5 | — | +6,5 | [+2 ; +9] | 3 / 24 / 3 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 48 | 1531 | — | +1410,5 | [+1361 ; +1473,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes ouvertes (toutes) | 119,5 | 352,5 | — | +253 | [+178 ; +323,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,12 | — | −0,76 | [−0,77 ; −0,74] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Bonheur moyen | 0,98 | 0,81 | — | −0,16 | [−0,17 ; −0,15] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 295 $ | 136 248 $ | — | −15 446 $ | [−27 551 $ ; +7 167 $] | 12 / 18 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 48 | — | 0 | [0 ; +751,5] | 4 / 13 / 13 sur 30 | non concluant |
| Prêts refusés | 0 | 141 | — | +141 | [+12 ; +200,5] | — / — / 5 | **B plus haut** |
| Créances radiées | 9 049 $ | 29 831 $ | — | +16 175 $ | [+12 159 $ ; +22 712 $] | — / — / 0 | **B plus haut** |
| Filet : Anti-famine / 50 j | 0,00 | 84,13 | 5 → 27 | +84,05 | [+51,20 ; +174,14] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plancher de logement / 50 j | 0,00 | 22,66 | 7 → 30 | +20,80 | [+15,66 ; +24,98] | 3 / 27 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 5,04 | 5 → 20 | +5,04 | [+0,43 ; +7,16] | 3 / 22 / 5 sur 30 | **B plus haut (moins bien)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « renflouement d’entreprise »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,0 % | 22,5 % | 6,5 % | 1,2 % | 0,44 | 0,072 % | 345 (17) | 0,12 | 7 % / 29 % / 64 % | 3 | 0 $ |
| 2 | 8,5 % | 30,4 % | 4,1 % | 1,3 % | 0,41 | 0,034 % | 601 (24) | 0,11 | 5 % / 28 % / 67 % | 7 | 7 721 $ |
| 3 | 5,4 % | 21,3 % | 7,6 % | 1,4 % | 0,45 | 0,045 % | 457 (17) | 0,11 | 7 % / 26 % / 67 % | 1 | 0 $ |
| 4 | 6,3 % | 21,3 % | 3,1 % | 1,8 % | 0,41 | 0,071 % | 298 (16) | 0,15 | 5 % / 26 % / 69 % | 2 | 3 890 $ |
| 5 | 5,8 % | 22,5 % | 5,4 % | 1,5 % | 0,48 | 0,078 % | 345 (19) | 0,11 | 13 % / 19 % / 68 % | 4 | 1 218 $ |
| 6 | 7,6 % | 23,8 % | 5,9 % | 1,0 % | 0,40 | 0,069 % | 563 (16) | 0,10 | 12 % / 19 % / 69 % | 4 | 0 $ |
| 7 | 7,6 % | 25,8 % | 2,8 % | 1,4 % | 0,34 | 0,038 % | 475 (16) | 0,10 | 8 % / 23 % / 69 % | 1 | 0 $ |
| 8 | 6,4 % | 25,0 % | 5,3 % | 1,6 % | 0,47 | 0,043 % | 360 (17) | 0,14 | 10 % / 17 % / 73 % | 4 | 0 $ |
| 9 | 6,8 % | 21,7 % | 0,0 % | 0,4 % | 0,24 | 0,044 % | 212 (7) | 0,12 | 10 % / 19 % / 70 % | 2 | 8 290 $ |
| 10 | 5,1 % | 16,3 % | 0,4 % | 0,6 % | 0,35 | 0,077 % | 207 (8) | 0,12 | 9 % / 18 % / 73 % | 0 | 22 431 $ |
| 11 | 8,0 % | 25,8 % | 2,6 % | 1,2 % | 0,34 | 0,055 % | 458 (15) | 0,11 | 7 % / 28 % / 65 % | 5 | 0 $ |
| 12 | 5,3 % | 12,9 % | 0,1 % | 1,6 % | 0,39 | 0,056 % | 262 (5) | 0,13 | 6 % / 22 % / 72 % | 2 | 0 $ |
| 13 | 6,5 % | 25,4 % | 7,8 % | 1,0 % | 0,44 | 0,079 % | 595 (17) | 0,10 | 3 % / 26 % / 70 % | 5 | 0 $ |
| 14 | 5,5 % | 19,2 % | 2,8 % | 1,1 % | 0,39 | 0,042 % | 244 (8) | 0,14 | 1 % / 14 % / 86 % | 1 | 5 327 $ |
| 15 | 7,3 % | 30,8 % | 5,2 % | 1,5 % | 0,47 | 0,056 % | 431 (16) | 0,13 | 10 % / 19 % / 70 % | 3 | 494 $ |
| 16 | 5,9 % | 21,7 % | 0,6 % | 0,3 % | 0,26 | 0,036 % | 233 (6) | 0,11 | 6 % / 25 % / 68 % | 2 | 0 $ |
| 17 | 11,2 % | 41,3 % | 5,8 % | 3,7 % | 0,58 | 0,058 % | 482 (17) | 0,11 | 3 % / 16 % / 81 % | 0 | 0 $ |
| 18 | 5,0 % | 19,6 % | 0,6 % | 0,5 % | 0,31 | 0,083 % | 254 (6) | 0,12 | 2 % / 31 % / 67 % | 0 | 17 864 $ |
| 19 | 6,7 % | 22,1 % | 3,1 % | 2,6 % | 0,41 | 0,083 % | 340 (20) | 0,13 | 9 % / 20 % / 71 % | 3 | 182 $ |
| 20 | 48,8 % | 76,7 % | 23,4 % | 24,9 % | 0,79 | 0,015 % | 1017 (23) | 0,10 | 10 % / 30 % / 60 % | 9 | 0 $ |
| 21 | 5,6 % | 21,7 % | 4,1 % | 1,4 % | 0,43 | 0,058 % | 305 (13) | 0,13 | 10 % / 18 % / 71 % | 1 | 1 606 $ |
| 22 | 6,5 % | 16,3 % | 0,1 % | 1,7 % | 0,26 | 0,035 % | 283 (7) | 0,11 | 10 % / 18 % / 72 % | 1 | 19 497 $ |
| 23 | 7,5 % | 20,8 % | 2,1 % | 2,7 % | 0,34 | 0,065 % | 474 (16) | 0,11 | 9 % / 25 % / 66 % | 4 | 482 $ |
| 24 | 6,3 % | 20,8 % | 1,6 % | 0,6 % | 0,27 | 0,062 % | 297 (8) | 0,11 | 8 % / 23 % / 69 % | 2 | 22 454 $ |
| 25 | 6,8 % | 27,1 % | 0,2 % | 1,0 % | 0,27 | 0,041 % | 263 (15) | 0,12 | 10 % / 23 % / 67 % | 3 | 22 274 $ |
| 26 | 8,7 % | 27,5 % | 5,4 % | 2,8 % | 0,36 | 0,044 % | 531 (16) | 0,17 | 13 % / 22 % / 65 % | 4 | 0 $ |
| 27 | 5,6 % | 20,0 % | 1,6 % | 0,9 % | 0,35 | 0,042 % | 215 (10) | 0,13 | 1 % / 32 % / 66 % | 4 | 4 178 $ |
| 28 | 8,2 % | 27,1 % | 4,6 % | 1,2 % | 0,37 | 0,067 % | 613 (17) | 0,10 | 12 % / 22 % / 67 % | 2 | 0 $ |
| 29 | 56,5 % | 75,0 % | 42,8 % | 25,1 % | 0,71 | -0,043 % | 1049 (22) | 0,11 | 4 % / 1 % / 95 % | 16 | 0 $ |
| 30 | 7,2 % | 18,8 % | 2,0 % | 0,3 % | 0,33 | 0,034 % | 528 (9) | 0,12 | 12 % / 20 % / 68 % | 0 | 0 $ |

</details>

## 2 bis (3). Avec filets, sauf « Plancher de logement »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 4,3 % | 1,2 pt (3,7 % – 4,9 %) | 2,3 % – 8,2 % | 0/30 |
| Chômage max | toute la partie | — | 15,8 % | 6,1 pt (12,5 % – 18,6 %) | 8,8 % – 32,1 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 5,3 % | 1/30 |
| Faim max | toute la partie | — | 44,2 % | 27,4 pt (26,7 % – 54,1 %) | 0,0 % – 72,1 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 1,9 % | 0/30 |
| Sans-abri max | toute la partie | — | 41,9 % | 22,9 pt (32,7 % – 55,6 %) | 22,1 % – 81,7 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,17 | 0,03 (0,16 – 0,19) | 0,14 – 0,36 | 23/30 |
| Gini en fin de partie | dernier jour | — | 0,17 | 0,05 (0,14 – 0,20) | 0,10 – 0,44 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,022 % | 0,055 pt (0,003 % – 0,058 %) | -0,011 % – 0,092 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 45,0 % | 43,3 pt (12,8 % – 56,0 %) | 1,6 % – 68,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 116,7 % | 36,3 pt (100,8 % – 137,1 %) | 80,9 % – 157,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 7 | 4,8 (5,3 – 10) | 3 – 25 | 30/30 |
| … dont après la chauffe | après chauffe | — | 4 | 5,8 (2 – 7,8) | 0 – 21 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 74,5 | 73,5 (47 – 120,5) | 25 – 1411 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 117,5 | 31,8 (104 – 135,8) | 82 – 204 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,003 (0,87 – 0,88) | 0,15 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,98 | 0,002 (0,97 – 0,98) | 0,82 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 147 036 $ | 21 927 $ (132 683 $ – 154 610 $) | 71 665 $ – 164 214 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 1344 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 71 | — |
| Créances radiées | toute la partie | — | 8 338 $ | 7 550 $ (3 988 $ – 11 538 $) | 0 $ – 32 652 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,47 (0,00 – 0,47) | 0,00 – 104,61 | 7/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 27,82 | 6,10 (24,21 – 30,30) | 17,93 – 42,04 | 30/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 2,54 | 1/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 8,68 | 1,49 (8,10 – 9,59) | 5,46 – 11,64 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,47 | 0,00 – 104,61 | 7/30 | 6254 | pas de producteur (100 %) |
| Renflouement d’entreprise | 27,82 | 24,21 – 30,30 | 17,93 – 42,04 | 30/30 | 26027 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | coupé | — | — | — | — | — |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 2,54 | 1/30 | 71 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Hôpital 7431 · 30, Ferme 3014 · 30, École 1832 · 30, Garage 1767 · 30, Fonderie 1639 · 29, Électronique 1383 · 30, Pétrochimie 1372 · 29, Pêcherie 972 · 30.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plancher de logement »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 4,3 % | 0 → 0 | +0,2 pt | [−0,3 pt ; +0,6 pt] | 11 / 19 / 0 sur 30 | non concluant |
| Chômage max | 14,8 % | 15,8 % | — | +1,3 pt | [−1,0 pt ; +2,1 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 1 | 0,0 pt | [0,0 pt ; +0,01 pt] | 8 / 11 / 11 sur 30 | non concluant |
| Faim max | 36,9 % | 44,2 % | — | +0,4 pt | [−1,0 pt ; +7,7 pt] | 11 / 15 / 4 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 2 → 0 | −0,003 pt | [−0,03 pt ; +0,001 pt] | 16 / 10 / 4 sur 30 | non concluant |
| Sans-abri max | 35,6 % | 41,9 % | — | +3,7 pt | [+2,1 pt ; +7,9 pt] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Gini moyen | 0,17 | 0,17 | 22 → 23 | −0,0005 | [−0,02 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,19 | 0,17 | — | −0,03 | [−0,06 ; +0,02] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,045 % | 0,022 % | 0 → 0 | −0,013 pt | [−0,029 pt ; −0,005 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 15,3 % | 45,0 % | — | +5,3 pt | [−4,9 pt ; +20,9 pt] | 13 / 17 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 113,2 % | 116,7 % | — | +2,1 pt | [−4,5 pt ; +9,9 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 7 | 7 | 30 → 30 | +0,5 | [−2 ; +4] | 14 / 15 / 1 sur 30 | non concluant |
| … dont après la chauffe | 3,5 | 4 | — | −0,5 | [−2,5 ; +3,5] | 15 / 13 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 48 | 74,5 | — | +3,5 | [−16 ; +17] | 13 / 17 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 119,5 | 117,5 | — | −3,5 | [−14,5 ; +11,5] | 17 / 13 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,0004 | [−0,001 ; +0,001] | 16 / 14 / 0 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,98 | — | −0,0001 | [−0,001 ; +0,0004] | 15 / 15 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 295 $ | 147 036 $ | — | −295 $ | [−4 105 $ ; +4 348 $] | 15 / 15 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 3 / 1 / 26 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 25 | non concluant |
| Créances radiées | 9 049 $ | 8 338 $ | — | −786 $ | [−3 577 $ ; +1 411 $] | — / — / 1 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 5 → 7 | 0,00 | [0,00 ; 0,00] | 8 / 9 / 13 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 26,66 | 27,82 | 30 → 30 | +0,96 | [−3,63 ; +4,84] | 13 / 17 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 5 → 1 | 0,00 | [0,00 ; 0,00] | 5 / 0 / 25 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,27 | 8,68 | — | +0,18 | [−0,07 ; +1,16] | 10 / 19 / 1 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plancher de logement »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,2 % | 18,8 % | 0,0 % | 0,0 % | 0,22 | -0,006 % | 103 (7) | 0,88 | 6 % / 8 % / 86 % | 0 | 6 462 $ |
| 2 | 3,9 % | 10,0 % | 0,0 % | 0,1 % | 0,15 | 0,072 % | 142 (10) | 0,87 | 2 % / 20 % / 78 % | 0 | 7 449 $ |
| 3 | 4,4 % | 18,3 % | 0,0 % | 0,0 % | 0,18 | 0,051 % | 149 (12) | 0,88 | 6 % / 17 % / 76 % | 0 | 9 443 $ |
| 4 | 4,8 % | 20,8 % | 0,0 % | 0,9 % | 0,20 | 0,031 % | 82 (7) | 0,88 | 6 % / 9 % / 85 % | 0 | 15 352 $ |
| 5 | 3,2 % | 8,8 % | 0,1 % | 0,0 % | 0,14 | 0,070 % | 119 (5) | 0,88 | 7 % / 13 % / 80 % | 0 | 35 897 $ |
| 6 | 4,2 % | 17,1 % | 0,0 % | 0,0 % | 0,16 | -0,001 % | 95 (4) | 0,88 | 6 % / 9 % / 84 % | 0 | 14 862 $ |
| 7 | 4,9 % | 14,6 % | 0,1 % | 0,1 % | 0,17 | 0,008 % | 136 (10) | 0,88 | 6 % / 17 % / 77 % | 0 | 20 960 $ |
| 8 | 5,3 % | 19,2 % | 0,7 % | 0,7 % | 0,36 | 0,062 % | 163 (12) | 0,15 | 8 % / 18 % / 74 % | 0 | 13 100 $ |
| 9 | 4,7 % | 16,3 % | 0,0 % | 0,0 % | 0,19 | 0,033 % | 132 (14) | 0,88 | 6 % / 9 % / 85 % | 0 | 33 200 $ |
| 10 | 4,1 % | 16,7 % | 5,3 % | 1,0 % | 0,26 | 0,091 % | 204 (15) | 0,32 | 11 % / 19 % / 70 % | 2 | 14 471 $ |
| 11 | 3,5 % | 12,5 % | 0,0 % | 0,1 % | 0,16 | 0,022 % | 135 (11) | 0,88 | 6 % / 10 % / 85 % | 0 | 138 931 $ |
| 12 | 3,3 % | 14,2 % | 0,2 % | 0,0 % | 0,16 | 0,034 % | 124 (9) | 0,88 | 7 % / 13 % / 80 % | 0 | 45 118 $ |
| 13 | 3,1 % | 11,3 % | 0,1 % | 0,0 % | 0,15 | 0,023 % | 133 (6) | 0,88 | 7 % / 13 % / 80 % | 0 | 48 385 $ |
| 14 | 8,2 % | 32,1 % | 1,7 % | 1,9 % | 0,29 | 0,092 % | 201 (25) | 0,24 | 21 % / 19 % / 60 % | 1 | 20 669 $ |
| 15 | 3,6 % | 12,1 % | 0,0 % | 0,0 % | 0,15 | 0,005 % | 96 (5) | 0,88 | 6 % / 10 % / 84 % | 0 | 52 484 $ |
| 16 | 4,5 % | 14,6 % | 0,0 % | 0,0 % | 0,17 | 0,069 % | 108 (6) | 0,88 | 6 % / 13 % / 81 % | 0 | 116 355 $ |
| 17 | 5,1 % | 24,6 % | 0,0 % | 0,0 % | 0,18 | -0,005 % | 165 (7) | 0,88 | 5 % / 9 % / 86 % | 0 | 2 677 $ |
| 18 | 4,2 % | 12,5 % | 0,0 % | 0,0 % | 0,16 | 0,005 % | 115 (3) | 0,88 | 6 % / 9 % / 85 % | 0 | 26 579 $ |
| 19 | 4,9 % | 22,9 % | 0,0 % | 0,0 % | 0,19 | -0,003 % | 95 (4) | 0,88 | 6 % / 9 % / 85 % | 0 | 0 $ |
| 20 | 3,7 % | 12,1 % | 0,2 % | 0,0 % | 0,14 | 0,039 % | 108 (6) | 0,88 | 7 % / 12 % / 81 % | 1 | 57 117 $ |
| 21 | 2,3 % | 11,3 % | 0,0 % | 0,0 % | 0,17 | 0,011 % | 87 (5) | 0,88 | 6 % / 9 % / 85 % | 0 | 0 $ |
| 22 | 3,3 % | 14,6 % | 0,0 % | 0,0 % | 0,17 | 0,076 % | 107 (10) | 0,88 | 7 % / 14 % / 79 % | 0 | 62 114 $ |
| 23 | 4,8 % | 20,8 % | 0,0 % | 0,0 % | 0,20 | 0,017 % | 85 (7) | 0,88 | 6 % / 9 % / 85 % | 0 | 3 760 $ |
| 24 | 5,3 % | 20,4 % | 1,1 % | 1,6 % | 0,35 | 0,060 % | 176 (20) | 0,33 | 11 % / 20 % / 69 % | 0 | 7 809 $ |
| 25 | 5,0 % | 18,3 % | 0,0 % | 0,0 % | 0,21 | 0,000 % | 97 (3) | 0,87 | 5 % / 9 % / 86 % | 0 | 1 423 $ |
| 26 | 4,1 % | 15,4 % | 0,1 % | 0,0 % | 0,17 | 0,004 % | 134 (9) | 0,88 | 6 % / 10 % / 85 % | 0 | 20 309 $ |
| 27 | 4,4 % | 11,7 % | 0,0 % | 0,1 % | 0,18 | 0,002 % | 112 (8) | 0,87 | 3 % / 19 % / 78 % | 0 | 7 007 $ |
| 28 | 3,6 % | 17,1 % | 0,0 % | 0,0 % | 0,16 | -0,011 % | 116 (5) | 0,87 | 6 % / 9 % / 85 % | 1 | 22 193 $ |
| 29 | 4,4 % | 17,9 % | 0,0 % | 0,0 % | 0,18 | 0,001 % | 109 (7) | 0,88 | 6 % / 9 % / 85 % | 0 | 2 836 $ |
| 30 | 4,0 % | 12,5 % | 0,0 % | 0,1 % | 0,15 | 0,052 % | 126 (9) | 0,88 | 7 % / 13 % / 80 % | 0 | 23 627 $ |

</details>

## 2 bis (4). Avec filets, sauf « Plafond de dérive des prix et salaires »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 4,3 % | 1,1 pt (3,6 % – 4,7 %) | 2,5 % – 8,2 % | 0/30 |
| Chômage max | toute la partie | — | 14,8 % | 4,3 pt (12,7 % – 17,0 %) | 10,0 % – 37,5 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 1,8 % | 0/30 |
| Faim max | toute la partie | — | 36,9 % | 34,2 pt (15,9 % – 50,1 %) | 0,0 % – 80,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 2,9 % | 2/30 |
| Sans-abri max | toute la partie | — | 35,6 % | 20,5 pt (28,7 % – 49,3 %) | 12,1 % – 65,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,17 | 0,05 (0,16 – 0,20) | 0,13 – 0,33 | 22/30 |
| Gini en fin de partie | dernier jour | — | 0,19 | 0,11 (0,15 – 0,26) | 0,10 – 0,55 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,045 % | 0,056 pt (0,010 % – 0,066 %) | -0,015 % – 0,091 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 15,3 % | 47,1 pt (10,0 % – 57,1 %) | 2,8 % – 75,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 113,2 % | 33,0 pt (95,2 % – 128,1 %) | 80,9 % – 159,9 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 7 | 4 (5 – 9) | 2 – 22 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3,5 | 3 (3 – 6) | 0 – 20 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 48 | 85,3 (40,5 – 125,8) | 19 – 1454 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 119,5 | 46,3 (104,5 – 150,8) | 86 – 212 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,003 (0,87 – 0,88) | 0,14 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,98 | 0,002 (0,97 – 0,98) | 0,83 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 146 295 $ | 15 549 $ (138 185 $ – 153 734 $) | 75 920 $ – 160 275 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 1140 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 205 | — |
| Créances radiées | toute la partie | — | 9 049 $ | 9 407 $ (4 268 $ – 13 675 $) | 0 $ – 41 996 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,11 (0,00 – 0,11) | 0,00 – 50,68 | 5/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 26,66 | 8,82 (22,26 – 31,08) | 18,50 – 47,93 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,16 (0,00 – 0,16) | 0,00 – 103,04 | 7/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 7,32 | 5/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 8,27 | 1,75 (7,71 – 9,46) | 4,71 – 11,57 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,11 | 0,00 – 50,68 | 5/30 | 3971 | pas de producteur (100 %) |
| Renflouement d’entreprise | 26,66 | 22,26 – 31,08 | 18,50 – 47,93 | 30/30 | 25614 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 0,16 | 0,00 – 103,04 | 7/30 | 14586 | parc plein (59 %) ; prix trop élevé (41 %) |
| Plafond de dérive des prix et salaires | coupé | — | — | — | — | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 7,32 | 5/30 | 580 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Hôpital 7109 · 30, Ferme 3713 · 30, École 1865 · 30, Garage 1532 · 28, Fonderie 1290 · 28, Pétrochimie 1265 · 29, Électronique 1077 · 30, Pêcherie 972 · 29.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plafond de dérive des prix et salaires »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 4,3 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 14,8 % | 14,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 36,9 % | 36,9 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 2 → 2 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 35,6 % | 35,6 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,17 | 0,17 | 22 → 22 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,19 | 0,19 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,045 % | 0,045 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 15,3 % | 15,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 113,2 % | 113,2 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 7 | 7 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 3,5 | 3,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 48 | 48 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 119,5 | 119,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,98 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 295 $ | 146 295 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 9 049 $ | 9 049 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 5 → 5 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 26,66 | 26,66 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 7 → 7 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 5 → 5 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,27 | 8,27 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plafond de dérive des prix et salaires »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,0 % | 16,7 % | 0,0 % | 0,0 % | 0,16 | 0,045 % | 134 (9) | 0,88 | 7 % / 13 % / 79 % | 0 | 99 070 $ |
| 2 | 7,1 % | 23,8 % | 0,0 % | 2,9 % | 0,30 | 0,036 % | 143 (21) | 0,30 | 9 % / 10 % / 81 % | 0 | 6 430 $ |
| 3 | 5,7 % | 19,2 % | 1,8 % | 1,0 % | 0,33 | 0,062 % | 151 (10) | 0,29 | 15 % / 20 % / 65 % | 1 | 7 391 $ |
| 4 | 8,2 % | 37,5 % | 0,1 % | 1,6 % | 0,31 | 0,045 % | 153 (16) | 0,27 | 11 % / 13 % / 75 % | 1 | 62 607 $ |
| 5 | 2,5 % | 12,5 % | 0,0 % | 0,0 % | 0,14 | 0,076 % | 134 (7) | 0,88 | 7 % / 13 % / 81 % | 0 | 32 538 $ |
| 6 | 4,1 % | 15,8 % | 0,0 % | 0,0 % | 0,15 | 0,000 % | 150 (9) | 0,88 | 3 % / 19 % / 78 % | 0 | 27 680 $ |
| 7 | 3,9 % | 14,2 % | 0,0 % | 0,0 % | 0,15 | 0,008 % | 157 (11) | 0,88 | 5 % / 13 % / 82 % | 0 | 27 564 $ |
| 8 | 4,4 % | 14,6 % | 0,0 % | 0,1 % | 0,18 | 0,042 % | 94 (4) | 0,88 | 7 % / 14 % / 79 % | 0 | 37 763 $ |
| 9 | 4,4 % | 11,3 % | 0,1 % | 0,0 % | 0,18 | 0,046 % | 117 (9) | 0,88 | 6 % / 9 % / 85 % | 0 | 30 400 $ |
| 10 | 4,4 % | 10,0 % | 0,0 % | 0,1 % | 0,17 | 0,005 % | 86 (4) | 0,88 | 6 % / 10 % / 85 % | 0 | 19 650 $ |
| 11 | 2,9 % | 14,6 % | 0,0 % | 0,0 % | 0,13 | 0,068 % | 117 (5) | 0,88 | 7 % / 13 % / 81 % | 0 | 40 268 $ |
| 12 | 2,8 % | 12,5 % | 0,0 % | 0,0 % | 0,16 | 0,089 % | 88 (6) | 0,88 | 6 % / 14 % / 79 % | 0 | 50 890 $ |
| 13 | 3,4 % | 12,5 % | 0,0 % | 0,1 % | 0,17 | 0,044 % | 100 (4) | 0,88 | 5 % / 17 % / 79 % | 0 | 84 086 $ |
| 14 | 4,7 % | 13,8 % | 0,0 % | 0,0 % | 0,20 | 0,010 % | 111 (9) | 0,88 | 7 % / 9 % / 84 % | 0 | 6 620 $ |
| 15 | 3,6 % | 10,8 % | 0,0 % | 0,0 % | 0,16 | 0,054 % | 116 (8) | 0,88 | 6 % / 13 % / 81 % | 0 | 32 399 $ |
| 16 | 4,2 % | 15,0 % | 0,1 % | 0,1 % | 0,16 | 0,090 % | 114 (5) | 0,88 | 6 % / 13 % / 81 % | 0 | 90 373 $ |
| 17 | 5,5 % | 21,7 % | 0,0 % | 0,0 % | 0,18 | 0,010 % | 157 (8) | 0,88 | 7 % / 14 % / 79 % | 0 | 16 040 $ |
| 18 | 4,6 % | 15,8 % | 0,1 % | 0,0 % | 0,20 | -0,004 % | 129 (5) | 0,87 | 5 % / 9 % / 86 % | 0 | 5 536 $ |
| 19 | 3,7 % | 17,1 % | 0,0 % | 0,6 % | 0,28 | 0,036 % | 100 (8) | 0,14 | 8 % / 11 % / 81 % | 0 | 0 $ |
| 20 | 3,4 % | 13,3 % | 0,0 % | 0,0 % | 0,15 | 0,049 % | 119 (5) | 0,88 | 7 % / 13 % / 80 % | 0 | 68 682 $ |
| 21 | 5,1 % | 25,0 % | 1,8 % | 0,5 % | 0,27 | 0,089 % | 212 (12) | 0,40 | 15 % / 20 % / 65 % | 2 | 0 $ |
| 22 | 2,7 % | 15,4 % | 0,0 % | 0,0 % | 0,16 | 0,005 % | 91 (4) | 0,88 | 6 % / 9 % / 85 % | 0 | 32 174 $ |
| 23 | 4,7 % | 11,7 % | 0,0 % | 0,0 % | 0,14 | 0,036 % | 158 (7) | 0,88 | 7 % / 13 % / 80 % | 0 | 35 727 $ |
| 24 | 4,2 % | 10,8 % | 0,0 % | 0,0 % | 0,14 | 0,069 % | 99 (6) | 0,88 | 8 % / 14 % / 77 % | 0 | 43 286 $ |
| 25 | 4,5 % | 16,3 % | 0,0 % | 0,3 % | 0,31 | 0,083 % | 158 (8) | 0,40 | 7 % / 22 % / 71 % | 0 | 0 $ |
| 26 | 4,1 % | 14,2 % | 0,1 % | 0,0 % | 0,17 | 0,040 % | 109 (2) | 0,88 | 7 % / 13 % / 80 % | 0 | 35 372 $ |
| 27 | 7,9 % | 30,0 % | 0,1 % | 2,3 % | 0,31 | 0,054 % | 201 (22) | 0,24 | 9 % / 11 % / 80 % | 1 | 17 269 $ |
| 28 | 4,9 % | 15,8 % | 0,0 % | 0,0 % | 0,18 | -0,007 % | 127 (7) | 0,88 | 7 % / 8 % / 85 % | 1 | 20 849 $ |
| 29 | 3,4 % | 13,3 % | 0,0 % | 0,0 % | 0,17 | 0,091 % | 103 (3) | 0,88 | 6 % / 17 % / 77 % | 0 | 56 588 $ |
| 30 | 4,3 % | 20,8 % | 0,0 % | 0,0 % | 0,21 | -0,015 % | 120 (4) | 0,88 | 6 % / 10 % / 85 % | 0 | 21 209 $ |

</details>

## 2 bis (5). Avec filets, sauf « Anti-crédit-fou »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 4,3 % | 1,3 pt (3,5 % – 4,8 %) | 2,5 % – 8,2 % | 0/30 |
| Chômage max | toute la partie | — | 14,6 % | 3,9 pt (12,6 % – 16,5 %) | 10,0 % – 37,5 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 1,8 % | 0/30 |
| Faim max | toute la partie | — | 35,4 % | 33,3 pt (15,5 % – 48,9 %) | 0,0 % – 80,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 2,9 % | 2/30 |
| Sans-abri max | toute la partie | — | 35,6 % | 20,5 pt (28,7 % – 49,3 %) | 12,1 % – 65,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,17 | 0,04 (0,16 – 0,20) | 0,13 – 0,33 | 23/30 |
| Gini en fin de partie | dernier jour | — | 0,18 | 0,10 (0,15 – 0,25) | 0,10 – 0,37 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,043 % | 0,055 pt (0,010 % – 0,065 %) | -0,007 % – 0,091 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 17,1 % | 48,6 pt (11,2 % – 59,8 %) | 2,8 % – 75,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 113,2 % | 33,0 pt (95,2 % – 128,1 %) | 80,9 % – 159,9 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 7 | 4 (5 – 9) | 2 – 22 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3,5 | 3 (3 – 6) | 0 – 20 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 48 | 81 (40,5 – 121,5) | 19 – 1444 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 123 | 42,5 (108,3 – 150,8) | 86 – 197 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,001 (0,88 – 0,88) | 0,15 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,98 | 0,002 (0,97 – 0,98) | 0,83 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 146 295 $ | 15 549 $ (138 185 $ – 153 734 $) | 75 920 $ – 160 275 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 1084 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 9 049 $ | 9 407 $ (4 268 $ – 13 675 $) | 0 $ – 48 620 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,11 (0,00 – 0,11) | 0,00 – 50,68 | 5/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 26,66 | 9,54 (22,26 – 31,79) | 18,50 – 47,93 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,10 (0,00 – 0,10) | 0,00 – 103,04 | 6/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 8,27 | 1,38 (8,08 – 9,46) | 4,21 – 11,57 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,11 | 0,00 – 50,68 | 5/30 | 3319 | pas de producteur (100 %) |
| Renflouement d’entreprise | 26,66 | 22,26 – 31,79 | 18,50 – 47,93 | 30/30 | 25820 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 0,10 | 0,00 – 103,04 | 6/30 | 15542 | parc plein (55 %) ; prix trop élevé (45 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | coupé | — | — | — | — | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Hôpital 7173 · 30, Ferme 3620 · 30, École 1875 · 30, Garage 1594 · 29, Fonderie 1334 · 28, Pétrochimie 1275 · 29, Électronique 1086 · 30, Pêcherie 996 · 29.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-crédit-fou »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 4,3 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 4 / 25 sur 30 | non concluant |
| Chômage max | 14,8 % | 14,6 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 1 / 27 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 1 / 28 sur 30 | non concluant |
| Faim max | 36,9 % | 35,4 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 1 / 28 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 2 → 2 | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 4 / 25 sur 30 | non concluant |
| Sans-abri max | 35,6 % | 35,6 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,17 | 0,17 | 22 → 23 | 0,00 | [0,00 ; 0,00] | — / — / 25 | non concluant |
| Gini en fin de partie | 0,19 | 0,18 | — | 0,00 | [0,00 ; 0,00] | — / — / 25 | non concluant |
| Inflation moyenne / j | 0,045 % | 0,043 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 25 | non concluant |
| |Inflation| max / j | 15,3 % | 17,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 4 / 26 sur 30 | non concluant |
| |Inflation sur 100 j| max | 113,2 % | 113,2 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 7 | 7 | 30 → 30 | 0 | [0 ; 0] | 1 / 3 / 26 sur 30 | non concluant |
| … dont après la chauffe | 3,5 | 3,5 | — | 0 | [0 ; 0] | 1 / 3 / 26 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 48 | 48 | — | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 119,5 | 123 | — | 0 | [0 ; 0] | 2 / 3 / 25 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 2 / 3 / 25 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,98 | — | 0,00 | [0,00 ; 0,00] | 1 / 4 / 25 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 295 $ | 146 295 $ | — | 0 $ | [0 $ ; 0 $] | 1 / 1 / 28 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 3 / 1 / 26 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 25 | non concluant |
| Créances radiées | 9 049 $ | 9 049 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 28 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 5 → 5 | 0,00 | [0,00 ; 0,00] | 1 / 1 / 28 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 26,66 | 26,66 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 2 / 3 / 25 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 7 → 6 | 0,00 | [0,00 ; 0,00] | 1 / 3 / 26 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,27 | 8,27 | — | 0,00 | [0,00 ; 0,00] | 1 / 4 / 25 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-crédit-fou »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,0 % | 16,7 % | 0,0 % | 0,0 % | 0,16 | 0,045 % | 134 (9) | 0,88 | 7 % / 13 % / 79 % | 0 | 99 070 $ |
| 2 | 7,1 % | 23,8 % | 0,0 % | 2,9 % | 0,30 | 0,036 % | 143 (21) | 0,30 | 9 % / 10 % / 81 % | 0 | 6 430 $ |
| 3 | 5,7 % | 19,2 % | 1,8 % | 1,0 % | 0,33 | 0,062 % | 151 (10) | 0,29 | 15 % / 20 % / 65 % | 1 | 7 391 $ |
| 4 | 8,2 % | 37,5 % | 0,1 % | 1,6 % | 0,31 | 0,045 % | 153 (16) | 0,27 | 11 % / 13 % / 75 % | 1 | 62 607 $ |
| 5 | 2,5 % | 12,5 % | 0,0 % | 0,0 % | 0,14 | 0,076 % | 134 (7) | 0,88 | 7 % / 13 % / 81 % | 0 | 32 538 $ |
| 6 | 4,1 % | 15,8 % | 0,0 % | 0,0 % | 0,15 | 0,000 % | 150 (9) | 0,88 | 3 % / 19 % / 78 % | 0 | 27 680 $ |
| 7 | 3,9 % | 14,2 % | 0,0 % | 0,0 % | 0,15 | 0,008 % | 157 (11) | 0,88 | 5 % / 13 % / 82 % | 0 | 27 564 $ |
| 8 | 4,4 % | 14,6 % | 0,0 % | 0,1 % | 0,18 | 0,042 % | 94 (4) | 0,88 | 7 % / 14 % / 79 % | 0 | 37 763 $ |
| 9 | 4,4 % | 11,3 % | 0,1 % | 0,0 % | 0,18 | 0,046 % | 117 (9) | 0,88 | 6 % / 9 % / 85 % | 0 | 30 400 $ |
| 10 | 4,4 % | 10,0 % | 0,0 % | 0,1 % | 0,17 | 0,005 % | 86 (4) | 0,88 | 6 % / 10 % / 85 % | 0 | 19 650 $ |
| 11 | 2,9 % | 14,6 % | 0,0 % | 0,0 % | 0,13 | 0,068 % | 117 (5) | 0,88 | 7 % / 13 % / 81 % | 0 | 40 268 $ |
| 12 | 2,8 % | 12,5 % | 0,0 % | 0,0 % | 0,16 | 0,089 % | 88 (6) | 0,88 | 6 % / 14 % / 79 % | 0 | 50 890 $ |
| 13 | 3,4 % | 12,5 % | 0,0 % | 0,1 % | 0,17 | 0,044 % | 100 (4) | 0,88 | 5 % / 17 % / 79 % | 0 | 84 086 $ |
| 14 | 4,7 % | 13,8 % | 0,0 % | 0,0 % | 0,20 | 0,010 % | 111 (9) | 0,88 | 7 % / 9 % / 84 % | 0 | 6 620 $ |
| 15 | 3,6 % | 10,8 % | 0,0 % | 0,0 % | 0,16 | 0,054 % | 116 (8) | 0,88 | 6 % / 13 % / 81 % | 0 | 32 399 $ |
| 16 | 4,2 % | 15,0 % | 0,1 % | 0,1 % | 0,16 | 0,090 % | 114 (5) | 0,88 | 6 % / 13 % / 81 % | 0 | 90 373 $ |
| 17 | 5,5 % | 21,7 % | 0,0 % | 0,0 % | 0,18 | 0,010 % | 157 (8) | 0,88 | 7 % / 14 % / 79 % | 0 | 16 040 $ |
| 18 | 4,6 % | 15,8 % | 0,1 % | 0,0 % | 0,20 | -0,004 % | 129 (5) | 0,87 | 5 % / 9 % / 86 % | 0 | 5 536 $ |
| 19 | 5,2 % | 17,5 % | 0,0 % | 1,1 % | 0,27 | 0,035 % | 108 (6) | 0,15 | 9 % / 10 % / 81 % | 0 | 1 053 $ |
| 20 | 3,4 % | 13,3 % | 0,0 % | 0,0 % | 0,15 | 0,049 % | 119 (5) | 0,88 | 7 % / 13 % / 80 % | 0 | 68 682 $ |
| 21 | 3,5 % | 12,9 % | 0,0 % | 0,1 % | 0,17 | 0,014 % | 158 (13) | 0,88 | 5 % / 9 % / 86 % | 0 | 51 155 $ |
| 22 | 2,7 % | 15,4 % | 0,0 % | 0,0 % | 0,16 | 0,005 % | 91 (4) | 0,88 | 6 % / 9 % / 85 % | 0 | 32 174 $ |
| 23 | 4,7 % | 11,7 % | 0,0 % | 0,0 % | 0,14 | 0,036 % | 158 (7) | 0,88 | 7 % / 13 % / 80 % | 0 | 35 727 $ |
| 24 | 4,2 % | 10,8 % | 0,0 % | 0,0 % | 0,14 | 0,069 % | 99 (6) | 0,88 | 8 % / 14 % / 77 % | 0 | 43 286 $ |
| 25 | 4,7 % | 15,8 % | 0,5 % | 0,7 % | 0,32 | 0,082 % | 176 (15) | 0,36 | 9 % / 20 % / 70 % | 0 | 2 085 $ |
| 26 | 4,1 % | 14,2 % | 0,1 % | 0,0 % | 0,17 | 0,040 % | 109 (2) | 0,88 | 7 % / 13 % / 80 % | 0 | 35 372 $ |
| 27 | 8,1 % | 30,0 % | 0,1 % | 2,5 % | 0,31 | 0,066 % | 197 (22) | 0,24 | 11 % / 12 % / 77 % | 0 | 43 020 $ |
| 28 | 4,9 % | 15,8 % | 0,0 % | 0,0 % | 0,18 | -0,007 % | 127 (7) | 0,88 | 7 % / 8 % / 85 % | 1 | 20 849 $ |
| 29 | 3,4 % | 13,3 % | 0,0 % | 0,0 % | 0,17 | 0,091 % | 103 (3) | 0,88 | 6 % / 17 % / 77 % | 0 | 56 588 $ |
| 30 | 4,9 % | 20,8 % | 0,0 % | 0,0 % | 0,20 | -0,005 % | 142 (8) | 0,88 | 5 % / 10 % / 85 % | 0 | 3 513 $ |

</details>

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. « Effondrée » : chômage moyen > 50 % avant le choc, l’évaluation n’a pas de sens. Un choc non résorbé compte comme une durée infinie dans la médiane.

### Sans filets

| Choc | Graines | Effondrée avant | Équilibre avant | Résorbé < 200 j | Retour (j) : médiane | EIQ (Q1–Q3) | Pic de chômage : médiane (Q1–Q3) | Alertes déclenchées (total, les plus fréquentes) |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 30 | 0 | 0 | 0 | non résorbé | non résorbé – non résorbé | 75,8 % (26,1 % – 93,1 %) | Entreprise sans client ×1902, Entreprise sans employé ×1888, Rupture de stock prolongée ×1264, Prix aberrant ×180 |
| +25 immigrants | 30 | 0 | 0 | 0 | non résorbé | non résorbé – non résorbé | 33,4 % (26,9 % – 59,2 %) | Entreprise sans client ×2112, Entreprise sans employé ×2025, Rupture de stock prolongée ×1549, Sans-abri nombreux ×218 |
| Salaire minimum 220 $/j | 30 | 0 | 0 | 0 | non résorbé | non résorbé – non résorbé | 39,4 % (22,3 % – 93,6 %) | Entreprise sans client ×1654, Entreprise sans employé ×1644, Rupture de stock prolongée ×1142, Prix aberrant ×163 |
| Fermeture de la ferme | 30 | 0 | 0 | 0 | non résorbé | non résorbé – non résorbé | 96,7 % (92,3 % – 97,8 %) | Entreprise sans client ×2748, Entreprise sans employé ×2689, Rupture de stock prolongée ×1584, Embauches bloquées faute de moyens ×147 |
| Faillite d’une firme clé | 30 | 0 | 0 | 0 | non résorbé | non résorbé – non résorbé | 41,9 % (24,5 % – 92,7 %) | Entreprise sans client ×1807, Entreprise sans employé ×1774, Rupture de stock prolongée ×1224, Prix aberrant ×172 |

### Avec filets

| Choc | Graines | Effondrée avant | Équilibre avant | Résorbé < 200 j | Retour (j) : médiane | EIQ (Q1–Q3) | Pic de chômage : médiane (Q1–Q3) | Alertes déclenchées (total, les plus fréquentes) |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 30 | 0 | 20 | 21 | 132 | 104 – non résorbé | 16,5 % (13,9 % – 21,3 %) | Rupture de stock prolongée ×835, Entreprise sans client ×638, Entreprise sans employé ×556, Prix aberrant ×253 |
| +25 immigrants | 30 | 0 | 20 | 0 | non résorbé | non résorbé – non résorbé | 13,4 % (12,2 % – 14,7 %) | Prix aberrant ×173, Entreprise sans client ×141, Rupture de stock prolongée ×110, Surstock ×98 |
| Salaire minimum 220 $/j | 30 | 0 | 20 | 29 | 1 | 1 – 14 | 8,5 % (7,2 % – 10,8 %) | Entreprise sans client ×234, Prix aberrant ×229, Entreprise sans employé ×185, Rupture de stock prolongée ×182 |
| Fermeture de la ferme | 30 | 0 | 20 | 28 | 30 | 1 – 101 | 11,0 % (9,6 % – 14,1 %) | Entreprise sans client ×254, Rupture de stock prolongée ×253, Prix aberrant ×210, Entreprise sans employé ×180 |
| Faillite d’une firme clé | 30 | 0 | 20 | 29 | 1 | 1 – 29 | 8,3 % (7,2 % – 12,0 %) | Entreprise sans client ×234, Prix aberrant ×221, Entreprise sans employé ×178, Rupture de stock prolongée ×171 |

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 30/30 : g1 29, g2 12, g3 14, g4 17, g5 34, g6 27, g7 44, g8 13, … |
| Chômage moyen ≤ 10 % | ❌ | 23/30 : g4 68,1 %, g5 12,5 %, g6 25,3 %, g7 33,3 %, g9 10,2 %, g10 52,9 %, g11 43,7 %, g12 10,0 %, … |
| Faim et sans-abri < 2 % | ❌ | 26/30 : g1, g4, g5, g6, g7, g9, g10, g11, g12, g13, … |
| Gini 0,2–0,45 | ❌ | 16/30 : g1 0,48, g5 0,52, g6 0,52, g7 0,69, g10 0,68, g11 0,69, g12 0,46, g13 0,83, … |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 30 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 30 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 5/30 graines ; Renflouement d’entreprise : 30/30 graines ; Plancher de logement : 7/30 graines ; Anti-crédit-fou : 5/30 graines |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 150/150 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 43/150 échecs |

### Critère de l’institution : avec filets, sauf « anti-famine »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-famine » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Anti-famine » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Anti-famine » : aucune alerte critique | ❌ | 30/30 : g1 6, g2 11, g3 10, g4 10, g5 7, g6 9, g7 11, g8 4, … |

### Critère de l’institution : avec filets, sauf « renflouement d’entreprise »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Renflouement d’entreprise » : chômage moyen ≤ 10 % | ❌ | 3/30 : g17 11,2 %, g20 48,8 %, g29 56,5 % |
| Sans « Renflouement d’entreprise » : faim et sans-abri < 2 % | ❌ | 21/30 : g1, g2, g3, g4, g5, g6, g7, g8, g11, g13, … |
| Sans « Renflouement d’entreprise » : aucune alerte critique | ❌ | 30/30 : g1 17, g2 24, g3 17, g4 16, g5 19, g6 16, g7 16, g8 17, … |

### Critère de l’institution : avec filets, sauf « plancher de logement »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plancher de logement » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Plancher de logement » : faim et sans-abri < 2 % | ❌ | 1/30 : g10 |
| Sans « Plancher de logement » : aucune alerte critique | ❌ | 30/30 : g1 7, g2 10, g3 12, g4 7, g5 5, g6 4, g7 10, g8 12, … |

### Critère de l’institution : avec filets, sauf « plafond de dérive des prix et salaires »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plafond de dérive des prix et salaires » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Plafond de dérive des prix et salaires » : faim et sans-abri < 2 % | ❌ | 2/30 : g2, g27 |
| Sans « Plafond de dérive des prix et salaires » : aucune alerte critique | ❌ | 30/30 : g1 9, g2 21, g3 10, g4 16, g5 7, g6 9, g7 11, g8 4, … |

### Critère de l’institution : avec filets, sauf « anti-crédit-fou »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-crédit-fou » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Anti-crédit-fou » : faim et sans-abri < 2 % | ❌ | 2/30 : g2, g27 |
| Sans « Anti-crédit-fou » : aucune alerte critique | ❌ | 30/30 : g1 9, g2 21, g3 10, g4 16, g5 7, g6 9, g7 11, g8 4, … |

