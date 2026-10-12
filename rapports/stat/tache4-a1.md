# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 20:30
- Graines : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : aucun
- Paramètres changés : healthWearIfDeprived = 1
- Temps total : 4 min 29 s pour 360 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 9,5 % | 4,9 pt (7,5 % – 12,4 %) | 5,8 % – 20,8 % | 13/30 |
| Chômage max | toute la partie | — | 25,4 % | 16,3 pt (21,0 % – 37,3 %) | 18,3 % – 44,6 % | — |
| Faim moyenne | après chauffe | < 2 % | 1,6 % | 2,5 pt (0,6 % – 3,1 %) | 0,0 % – 5,6 % | 13/30 |
| Faim max | toute la partie | — | 79,0 % | 23,3 pt (67,4 % – 90,7 %) | 15,0 % – 94,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 1,1 % | 1,5 pt (0,7 % – 2,1 %) | 0,1 % – 4,5 % | 9/30 |
| Sans-abri max | toute la partie | — | 53,3 % | 24,0 pt (38,5 % – 62,5 %) | 17,9 % – 95,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,26 | 0,06 (0,23 – 0,29) | 0,21 – 0,40 | 0/30 |
| Gini en fin de partie | dernier jour | — | 0,25 | 0,15 (0,20 – 0,35) | 0,12 – 0,62 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,046 % | 0,057 pt (0,008 % – 0,065 %) | -0,083 % – 0,104 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 40,8 % | 24,8 pt (29,1 % – 53,9 %) | 14,2 % – 81,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 113,2 % | 17,6 pt (107,5 % – 125,1 %) | 91,1 % – 145,7 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 25 | 10 (18 – 28) | 13 – 38 | 30/30 |
| … dont après la chauffe | après chauffe | — | 22 | 10,8 (16 – 26,8) | 10 – 36 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 903,5 | 457,8 (619,3 – 1077) | 34 – 1567 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 551,5 | 193,8 (466,8 – 660,5) | 288 – 766 | — |
| Santé moyenne | après chauffe | — | 0,56 | 0,31 (0,44 – 0,74) | 0,36 – 0,93 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 17 | 5,8 (14,3 – 20) | 10 – 31 | — |
| Machines en fin | dernier jour | — | 0,5 | 36,5 (0,3 – 36,8) | 0,2 – 244,9 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 1,5 | 1 (1 – 2) | 0 – 4 | — |
| Bonheur moyen | après chauffe | — | 0,90 | 0,05 (0,88 – 0,93) | 0,85 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 263,8 | 259,6 (112,6 – 372,2) | 6,9 – 452,8 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 231 | — |
| Trésor de l’État le plus bas | après chauffe | — | 69 905 $ | 83 002 $ (13 516 $ – 96 518 $) | 3 097 $ – 130 388 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 207,3 (0 – 207,3) | 0 – 665 | — |
| Prêts refusés | toute la partie | — | 0 | 102,5 (0 – 102,5) | 0 – 906 | — |
| Créances radiées | toute la partie | — | 20 941 $ | 13 800 $ (13 016 $ – 26 816 $) | 3 940 $ – 56 762 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 8/30 | 0 | 0 – 0,8 | 0 – 4 | 0 j |
| Faim répandue | critique | 29/30 | 3 | 2 – 4 | 0 – 8 | 37,5 j |
| Sans-abri nombreux | critique | 30/30 | 6,5 | 4,3 – 10 | 1 – 22 | 72 j |
| Inégalités hors bornes | attention | 6/30 | 0 | 0 – 0 | 0 – 2 | 0 j |
| Inflation quotidienne | critique | 30/30 | 8,5 | 7 – 11 | 4 – 28 | 8,5 j |
| Inflation sur 100 jours | critique | 28/30 | 2 | 1 – 3 | 0 – 6 | 17,5 j |
| Rupture de stock prolongée | attention | 30/30 | 130,5 | 114,5 – 153,5 | 56 – 175 | 3676,5 j |
| Surstock | attention | 30/30 | 70 | 51 – 88,8 | 32 – 121 | 2400,5 j |
| Entreprise sans employé | attention | 30/30 | 145,5 | 117 – 170,8 | 75 – 199 | 1991 j |
| Entreprise sans client | attention | 30/30 | 160 | 134,5 – 191 | 86 – 234 | 4976 j |
| Caisse insolvable | attention | 10/30 | 0 | 0 – 1 | 0 – 1 | 0 j |
| Santé de la population effondrée | critique | 26/30 | 1 | 1 – 1 | 0 – 2 | 673,5 j |
| Productivité du travail effondrée | attention | 26/30 | 1 | 1 – 1 | 0 – 3 | 659,5 j |
| Pénurie de main-d’œuvre | attention | 10/30 | 0 | 0 – 1 | 0 – 2 | 0 j |
| Embauches bloquées faute de moyens | attention | 30/30 | 5,5 | 4 – 7 | 2 – 10 | 116,5 j |
| Prix aberrant | attention | 30/30 | 13,5 | 10,3 – 15,8 | 5 – 23 | 2360 j |
| Attente trop longue (service public) | attention | 30/30 | 1,5 | 1 – 3 | 1 – 7 | 1230 j |
| Prestations réduites faute de trésor | attention | 6/30 | 0 | 0 – 0 | 0 – 3 | 0 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,1 % | 25,4 % | 0,6 % | 0,4 % | 0,35 | -0,028 % | 621 (20) | 0,77 | 7 % / 18 % / 75 % | 3 | 0 $ |
| 2 | 8,2 % | 29,6 % | 0,7 % | 0,7 % | 0,22 | 0,069 % | 440 (22) | 0,48 | 8 % / 18 % / 74 % | 2 | 1 685 $ |
| 3 | 6,0 % | 18,3 % | 0,1 % | 0,1 % | 0,21 | 0,090 % | 316 (13) | 0,47 | 11 % / 17 % / 72 % | 2 | 18 175 $ |
| 4 | 15,4 % | 38,3 % | 1,4 % | 2,6 % | 0,35 | 0,037 % | 699 (35) | 0,57 | 6 % / 13 % / 81 % | 7 | 42 539 $ |
| 5 | 10,9 % | 35,4 % | 3,8 % | 2,8 % | 0,26 | 0,047 % | 638 (28) | 0,50 | 8 % / 18 % / 74 % | 2 | 0 $ |
| 6 | 11,9 % | 43,8 % | 0,9 % | 1,3 % | 0,27 | -0,057 % | 520 (36) | 0,67 | 5 % / 9 % / 86 % | 0 | 1 119 $ |
| 7 | 12,0 % | 37,9 % | 5,6 % | 2,0 % | 0,30 | 0,067 % | 664 (27) | 0,36 | 14 % / 23 % / 64 % | 7 | 1 865 $ |
| 8 | 8,2 % | 23,8 % | 1,1 % | 0,6 % | 0,29 | 0,028 % | 491 (18) | 0,82 | 5 % / 15 % / 79 % | 5 | 0 $ |
| 9 | 8,1 % | 20,8 % | 0,3 % | 0,4 % | 0,26 | 0,054 % | 549 (13) | 0,42 | 8 % / 20 % / 73 % | 1 | 0 $ |
| 10 | 7,4 % | 18,3 % | 1,1 % | 0,5 % | 0,21 | 0,059 % | 540 (38) | 0,50 | 10 % / 20 % / 71 % | 2 | 25 311 $ |
| 11 | 7,4 % | 19,6 % | 3,6 % | 0,8 % | 0,25 | 0,104 % | 426 (21) | 0,43 | 8 % / 24 % / 68 % | 0 | 0 $ |
| 12 | 10,0 % | 26,3 % | 0,2 % | 1,7 % | 0,30 | 0,044 % | 694 (13) | 0,88 | 6 % / 13 % / 82 % | 1 | 0 $ |
| 13 | 5,8 % | 19,2 % | 2,5 % | 1,0 % | 0,21 | 0,088 % | 316 (26) | 0,43 | 10 % / 25 % / 65 % | 1 | 15 035 $ |
| 14 | 18,1 % | 42,9 % | 1,0 % | 4,4 % | 0,31 | -0,011 % | 597 (25) | 0,55 | 8 % / 23 % / 69 % | 0 | 48 922 $ |
| 15 | 7,9 % | 19,6 % | 2,4 % | 0,8 % | 0,22 | 0,059 % | 497 (17) | 0,42 | 10 % / 19 % / 71 % | 4 | 11 011 $ |
| 16 | 7,2 % | 22,5 % | 3,1 % | 0,9 % | 0,24 | 0,071 % | 431 (26) | 0,37 | 10 % / 25 % / 66 % | 3 | 0 $ |
| 17 | 7,2 % | 22,5 % | 2,4 % | 0,7 % | 0,23 | 0,076 % | 462 (16) | 0,43 | 5 % / 21 % / 75 % | 3 | 0 $ |
| 18 | 7,6 % | 21,7 % | 0,0 % | 0,4 % | 0,23 | 0,025 % | 337 (13) | 0,93 | 7 % / 12 % / 81 % | 1 | 3 707 $ |
| 19 | 12,5 % | 32,1 % | 3,0 % | 1,8 % | 0,29 | 0,027 % | 585 (25) | 0,75 | 7 % / 12 % / 82 % | 0 | 0 $ |
| 20 | 16,8 % | 44,6 % | 3,9 % | 3,1 % | 0,34 | 0,021 % | 706 (32) | 0,44 | 11 % / 14 % / 74 % | 3 | 0 $ |
| 21 | 6,0 % | 18,3 % | 3,8 % | 1,3 % | 0,23 | 0,078 % | 502 (23) | 0,61 | 8 % / 23 % / 69 % | 2 | 11 122 $ |
| 22 | 9,1 % | 22,5 % | 0,6 % | 1,3 % | 0,28 | -0,015 % | 682 (25) | 0,80 | 6 % / 15 % / 79 % | 1 | 1 778 $ |
| 23 | 7,5 % | 20,8 % | 0,1 % | 0,1 % | 0,23 | 0,004 % | 288 (18) | 0,86 | 7 % / 16 % / 77 % | 2 | 757 $ |
| 24 | 17,1 % | 40,0 % | 2,7 % | 4,0 % | 0,29 | 0,050 % | 653 (30) | 0,57 | 4 % / 17 % / 80 % | 1 | 0 $ |
| 25 | 9,5 % | 25,4 % | 4,0 % | 0,8 % | 0,26 | 0,061 % | 481 (28) | 0,41 | 6 % / 12 % / 82 % | 4 | 8 733 $ |
| 26 | 12,6 % | 28,7 % | 3,2 % | 4,5 % | 0,26 | 0,024 % | 766 (25) | 0,68 | 6 % / 14 % / 80 % | 1 | 0 $ |
| 27 | 10,6 % | 26,7 % | 1,8 % | 1,5 % | 0,25 | 0,060 % | 663 (21) | 0,52 | 9 % / 18 % / 73 % | 5 | 5 345 $ |
| 28 | 17,9 % | 42,5 % | 2,0 % | 2,2 % | 0,28 | -0,014 % | 627 (32) | 0,72 | 12 % / 17 % / 71 % | 2 | 0 $ |
| 29 | 20,8 % | 41,7 % | 0,4 % | 3,7 % | 0,40 | -0,083 % | 677 (34) | 0,77 | 9 % / 24 % / 67 % | 2 | 0 $ |
| 30 | 9,6 % | 22,9 % | 0,7 % | 0,8 % | 0,24 | -0,009 % | 554 (17) | 0,69 | 6 % / 13 % / 81 % | 5 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,1 % | 3,9 pt (5,7 % – 9,5 %) | 3,8 % – 15,8 % | 7/30 |
| Chômage max | toute la partie | — | 16,3 % | 11,9 pt (14,6 % – 26,5 %) | 12,1 % – 40,4 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,04 pt (0,0 % – 0,0 %) | 0,0 % – 1,6 % | 0/30 |
| Faim max | toute la partie | — | 2,7 % | 34,9 pt (0,0 % – 34,9 %) | 0,0 % – 76,7 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,3 pt (0,0 % – 0,3 %) | 0,0 % – 2,5 % | 1/30 |
| Sans-abri max | toute la partie | — | 39,4 % | 18,2 pt (30,5 % – 48,8 %) | 14,2 % – 65,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,21 | 0,04 (0,20 – 0,25) | 0,18 – 0,39 | 7/30 |
| Gini en fin de partie | dernier jour | — | 0,22 | 0,11 (0,17 – 0,28) | 0,13 – 0,59 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,036 % | 0,043 pt (0,004 % – 0,047 %) | -0,059 % – 0,085 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 38,5 % | 36,0 pt (26,5 % – 62,5 %) | 14,1 % – 83,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 119,5 % | 27,8 pt (108,6 % – 136,5 %) | 92,2 % – 213,2 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 9,5 | 5,8 (6,3 – 12) | 4 – 27 | 30/30 |
| … dont après la chauffe | après chauffe | — | 8 | 5,8 (5 – 10,8) | 2 – 25 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 63,5 | 84,3 (33,5 – 117,8) | 22 – 462 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 130 | 25,5 (120 – 145,5) | 103 – 367 | — |
| Santé moyenne | après chauffe | — | 0,94 | 0,01 (0,94 – 0,95) | 0,81 – 0,95 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 20 | 1 (20 – 21) | 17 – 26 | — |
| Machines en fin | dernier jour | — | 3,7 | 3,8 (1,2 – 5,0) | 0,3 – 112,7 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 4 | 1 (3 – 4) | 2 – 7 | — |
| Bonheur moyen | après chauffe | — | 0,99 | 0,01 (0,98 – 0,99) | 0,94 – 0,99 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,7 | 0,1 (0,6 – 0,7) | 0,6 – 69,1 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 169 | — |
| Trésor de l’État le plus bas | après chauffe | — | 102 621 $ | 58 659 $ (59 068 $ – 117 727 $) | 4 209 $ – 129 903 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 752 $ (0 $ – 752 $) | 0 $ – 19 762 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 73,89 | 5/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 12,20 | 7,32 (9,76 – 17,08) | 6,39 – 32,64 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 12,66 (0,00 – 12,66) | 0,00 – 71,86 | 10/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 73,89 | 5/30 | 2722 | pas de producteur (100 %) |
| Renflouement d’entreprise | 12,20 | 9,76 – 17,08 | 6,39 – 32,64 | 30/30 | 13193 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 12,66 | 0,00 – 71,86 | 10/30 | 13784 | prix trop élevé (57 %) ; parc plein (43 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Bijouterie 1715 · 27, Tourisme 1635 · 16, Ferme 1536 · 30, Fonderie 1079 · 30, Pétrochimie 943 · 30, Garage 892 · 16, Électronique 877 · 29, Mine de fer 777 · 29.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,1 % | 12,1 % | 0,0 % | 0,0 % | 0,39 | 0,040 % | 121 (9) | 0,94 | 5 % / 18 % / 77 % | 0 | 0 $ |
| 2 | 5,8 % | 13,8 % | 0,0 % | 0,0 % | 0,20 | 0,060 % | 114 (10) | 0,94 | 6 % / 13 % / 81 % | 1 | 0 $ |
| 3 | 6,1 % | 15,8 % | 0,0 % | 0,0 % | 0,21 | 0,035 % | 103 (9) | 0,95 | 3 % / 19 % / 78 % | 0 | 0 $ |
| 4 | 6,7 % | 18,3 % | 0,1 % | 0,0 % | 0,21 | 0,058 % | 149 (7) | 0,95 | 7 % / 13 % / 81 % | 0 | 18 484 $ |
| 5 | 9,6 % | 27,9 % | 0,0 % | 0,0 % | 0,19 | 0,039 % | 122 (10) | 0,95 | 6 % / 14 % / 79 % | 0 | 0 $ |
| 6 | 5,1 % | 14,2 % | 0,0 % | 0,1 % | 0,20 | 0,038 % | 130 (8) | 0,95 | 6 % / 11 % / 83 % | 0 | 28 205 $ |
| 7 | 5,1 % | 14,2 % | 0,1 % | 0,0 % | 0,21 | 0,048 % | 162 (18) | 0,95 | 7 % / 14 % / 78 % | 0 | 7 583 $ |
| 8 | 4,7 % | 14,2 % | 0,0 % | 0,0 % | 0,18 | 0,039 % | 104 (6) | 0,94 | 6 % / 12 % / 81 % | 0 | 0 $ |
| 9 | 5,2 % | 15,4 % | 0,0 % | 0,0 % | 0,20 | 0,058 % | 123 (12) | 0,95 | 6 % / 12 % / 82 % | 0 | 0 $ |
| 10 | 5,3 % | 16,3 % | 0,0 % | 0,0 % | 0,20 | 0,044 % | 131 (6) | 0,95 | 3 % / 19 % / 79 % | 0 | 0 $ |
| 11 | 9,1 % | 20,8 % | 0,0 % | 0,5 % | 0,36 | 0,034 % | 127 (7) | 0,94 | 5 % / 11 % / 84 % | 0 | 1 991 $ |
| 12 | 9,1 % | 16,7 % | 0,0 % | 0,2 % | 0,31 | -0,059 % | 116 (10) | 0,94 | 8 % / 16 % / 76 % | 0 | 7 520 $ |
| 13 | 6,1 % | 17,1 % | 0,2 % | 0,0 % | 0,20 | 0,071 % | 135 (19) | 0,94 | 7 % / 12 % / 81 % | 0 | 3 204 $ |
| 14 | 6,8 % | 15,8 % | 0,1 % | 0,0 % | 0,22 | 0,071 % | 130 (11) | 0,95 | 6 % / 13 % / 81 % | 0 | 7 778 $ |
| 15 | 13,6 % | 30,8 % | 1,6 % | 2,5 % | 0,24 | -0,025 % | 268 (24) | 0,92 | 7 % / 13 % / 80 % | 0 | 12 144 $ |
| 16 | 6,5 % | 16,3 % | 0,0 % | 0,0 % | 0,21 | 0,014 % | 130 (4) | 0,95 | 6 % / 11 % / 82 % | 1 | 15 671 $ |
| 17 | 3,8 % | 14,6 % | 0,0 % | 0,0 % | 0,19 | 0,073 % | 120 (5) | 0,95 | 3 % / 19 % / 79 % | 0 | 0 $ |
| 18 | 8,0 % | 18,3 % | 0,0 % | 0,0 % | 0,25 | 0,003 % | 135 (8) | 0,94 | 8 % / 12 % / 81 % | 1 | 2 083 $ |
| 19 | 10,5 % | 32,9 % | 0,0 % | 0,8 % | 0,23 | -0,029 % | 119 (11) | 0,94 | 8 % / 14 % / 78 % | 0 | 0 $ |
| 20 | 15,8 % | 40,4 % | 0,7 % | 2,0 % | 0,26 | -0,018 % | 367 (27) | 0,81 | 7 % / 17 % / 76 % | 0 | 5 427 $ |
| 21 | 8,0 % | 14,6 % | 0,2 % | 0,0 % | 0,24 | 0,012 % | 126 (5) | 0,95 | 7 % / 14 % / 79 % | 0 | 3 150 $ |
| 22 | 7,5 % | 13,3 % | 0,0 % | 0,0 % | 0,33 | -0,041 % | 132 (5) | 0,95 | 5 % / 10 % / 85 % | 0 | 0 $ |
| 23 | 12,5 % | 25,8 % | 0,0 % | 0,3 % | 0,26 | -0,052 % | 120 (9) | 0,95 | 4 % / 24 % / 72 % | 0 | 0 $ |
| 24 | 12,3 % | 30,4 % | 0,0 % | 0,9 % | 0,22 | 0,009 % | 194 (17) | 0,81 | 7 % / 17 % / 76 % | 0 | 221 $ |
| 25 | 6,7 % | 15,0 % | 0,0 % | 0,0 % | 0,22 | 0,085 % | 170 (5) | 0,91 | 7 % / 15 % / 78 % | 1 | 3 105 $ |
| 26 | 15,5 % | 33,3 % | 0,0 % | 1,4 % | 0,23 | 0,018 % | 324 (14) | 0,82 | 6 % / 14 % / 80 % | 0 | 0 $ |
| 27 | 4,8 % | 12,1 % | 0,0 % | 0,0 % | 0,19 | 0,038 % | 130 (10) | 0,94 | 7 % / 13 % / 80 % | 0 | 2 952 $ |
| 28 | 5,6 % | 15,8 % | 0,0 % | 0,0 % | 0,19 | 0,041 % | 110 (5) | 0,95 | 3 % / 17 % / 79 % | 0 | 13 887 $ |
| 29 | 12,3 % | 27,1 % | 0,0 % | 0,2 % | 0,30 | 0,033 % | 114 (12) | 0,95 | 7 % / 13 % / 80 % | 0 | 0 $ |
| 30 | 8,7 % | 26,7 % | 0,0 % | 0,4 % | 0,21 | -0,019 % | 196 (14) | 0,90 | 6 % / 12 % / 81 % | 0 | 16 350 $ |

</details>

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. « Effondrée » : chômage moyen > 50 % avant le choc, l’évaluation n’a pas de sens. Un choc non résorbé compte comme une durée infinie dans la médiane.

### Sans filets

| Choc | Graines | Effondrée avant | Équilibre avant | Résorbé < 200 j | Retour (j) : médiane | EIQ (Q1–Q3) | Pic de chômage : médiane (Q1–Q3) | Alertes déclenchées (total, les plus fréquentes) |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 30 | 0 | 0 | 19 | 109 | 87 – non résorbé | 30,6 % (24,2 % – 96,6 %) | Entreprise sans client ×1438, Entreprise sans employé ×1376, Rupture de stock prolongée ×1032, Surstock ×182 |
| +25 immigrants | 30 | 0 | 0 | 0 | non résorbé | non résorbé – non résorbé | 32,5 % (29,2 % – 36,8 %) | Entreprise sans client ×1578, Entreprise sans employé ×1342, Rupture de stock prolongée ×1143, Surstock ×676 |
| Salaire minimum 220 $/j | 30 | 0 | 0 | 0 | non résorbé | non résorbé – non résorbé | 33,5 % (29,3 % – 37,7 %) | Entreprise sans client ×740, Entreprise sans employé ×552, Rupture de stock prolongée ×493, Surstock ×416 |
| Fermeture de la ferme | 30 | 0 | 0 | 7 | non résorbé | 216 – non résorbé | 29,0 % (20,1 % – 36,9 %) | Entreprise sans client ×1617, Entreprise sans employé ×1391, Rupture de stock prolongée ×1181, Surstock ×542 |
| Faillite d’une firme clé | 30 | 0 | 0 | 9 | non résorbé | 138 – non résorbé | 24,4 % (17,6 % – 29,0 %) | Entreprise sans client ×1509, Entreprise sans employé ×1275, Rupture de stock prolongée ×1070, Surstock ×594 |

### Avec filets

| Choc | Graines | Effondrée avant | Équilibre avant | Résorbé < 200 j | Retour (j) : médiane | EIQ (Q1–Q3) | Pic de chômage : médiane (Q1–Q3) | Alertes déclenchées (total, les plus fréquentes) |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 30 | 0 | 5 | 30 | 109 | 98 – 130 | 20,4 % (14,4 % – 22,8 %) | Rupture de stock prolongée ×681, Entreprise sans client ×657, Entreprise sans employé ×507, Surstock ×200 |
| +25 immigrants | 30 | 0 | 5 | 0 | non résorbé | non résorbé – non résorbé | 25,3 % (19,2 % – 30,2 %) | Entreprise sans client ×250, Rupture de stock prolongée ×233, Entreprise sans employé ×158, Prix aberrant ×132 |
| Salaire minimum 220 $/j | 30 | 0 | 5 | 0 | non résorbé | non résorbé – non résorbé | 31,0 % (27,5 % – 35,4 %) | Entreprise sans client ×428, Surstock ×281, Entreprise sans employé ×268, Rupture de stock prolongée ×241 |
| Fermeture de la ferme | 30 | 0 | 5 | 14 | 217 | 22 – 404 | 16,9 % (13,3 % – 24,8 %) | Rupture de stock prolongée ×379, Entreprise sans client ×365, Entreprise sans employé ×242, Surstock ×156 |
| Faillite d’une firme clé | 30 | 0 | 5 | 18 | 120 | 9 – 405 | 13,5 % (11,8 % – 23,0 %) | Entreprise sans client ×366, Rupture de stock prolongée ×305, Entreprise sans employé ×236, Surstock ×149 |

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 30/30 : g1 20, g2 22, g3 13, g4 35, g5 28, g6 36, g7 27, g8 18, … |
| Chômage moyen ≤ 10 % | ❌ | 13/30 : g1 11,1 %, g4 15,4 %, g5 10,9 %, g6 11,9 %, g7 12,0 %, g14 18,1 %, g19 12,5 %, g20 16,8 %, … |
| Faim et sans-abri < 2 % | ❌ | 17/30 : g4, g5, g7, g11, g13, g14, g15, g16, g17, g19, … |
| Gini 0,2–0,45 | ✅ | aucune graine sur 30 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 30 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 30 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 5/30 graines ; Renflouement d’entreprise : 30/30 graines ; Plancher de logement : 10/30 graines |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 115/150 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 88/150 échecs |

