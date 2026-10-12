# Protocole de stabilité ÉcoNodes

- Date : 2026-10-12 10:29
- Graines : 1 à 6 (6) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Bâtiments, construction et hypothèques
- Paramètres changés : population = 1000
- Temps total : 73 s pour 12 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 17,5 % | 4,2 pt (15,4 % – 19,6 %) | 11,5 % – 25,5 % | 6/6 |
| Chômage max | toute la partie | — | 38,6 % | 4,2 pt (38,0 % – 42,2 %) | 32,5 % – 54,3 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,7 % | 1,0 pt (0,1 % – 1,2 %) | 0,0 % – 1,7 % | 0/6 |
| Faim max | toute la partie | — | 55,8 % | 35,9 pt (37,0 % – 72,9 %) | 23,0 % – 94,8 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 3,1 % | 4,4 pt (1,9 % – 6,3 %) | 1,3 % – 11,0 % | 4/6 |
| Sans-abri max | toute la partie | — | 66,5 % | 12,9 pt (58,2 % – 71,1 %) | 41,9 % – 78,1 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,46 | 0,07 (0,41 – 0,48) | 0,36 – 0,53 | 4/6 |
| Gini en fin de partie | dernier jour | — | 0,54 | 0,13 (0,47 – 0,60) | 0,39 – 0,63 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,078 % | 0,028 pt (-0,085 % – -0,057 %) | -0,089 % – -0,052 % | 0/6 |
| |Inflation| max / j | toute la partie | — | 43,1 % | 40,4 pt (24,6 % – 65,0 %) | 21,5 % – 79,3 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 142,2 % | 9,6 pt (139,3 % – 148,9 %) | 136,8 % – 153,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 24,5 | 7 (19,5 – 26,5) | 15 – 44 | 6/6 |
| … dont après la chauffe | après chauffe | — | 20,5 | 8,5 (14,8 – 23,3) | 11 – 40 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 832 | 714 (484,8 – 1198,8) | 357 – 1805 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 868 | 74,3 (818,5 – 892,8) | 741 – 962 | — |
| Santé moyenne | après chauffe | — | 0,74 | 0,11 (0,69 – 0,80) | 0,56 – 0,88 | — |
| Naissances d’entreprises / an | toute la partie | — | 18,0 | 3,7 (15,3 – 18,9) | 11,7 – 19,5 | — |
| Morts d’entreprises / an | toute la partie | — | 36,1 | 2,4 (34,7 – 37,2) | 31,4 – 39,4 | — |
| Entonnoir : projets envisagés | toute la partie | — | 11843,5 | 1388 (11741,3 – 13129,3) | 10606 – 14733 | — |
| Entonnoir : créations | toute la partie | — | 74 | 15 (62,8 – 77,8) | 48 – 80 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 455,5 | 90,5 (397,5 – 488) | 303 – 563 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 3188 | 730,8 (2641,5 – 3372,3) | 2047 – 3793 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 4395 | 258,8 (4209,8 – 4468,5) | 3952 – 4660 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 2783,5 | 250,5 (2647,8 – 2898,3) | 2618 – 3208 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 1,5 | 1,8 (0,3 – 2) | 0 – 13 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 1380 | 1141 (1087,8 – 2228,8) | 613 – 2928 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 57,5 | 49,3 (32,5 – 81,8) | 0 – 89 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 28 | 3 (25,8 – 28,8) | 24 – 31 | — |
| Machines en fin | dernier jour | — | 697,4 | 623,1 (221,1 – 844,2) | 5,9 – 1202,0 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 8 | 2,3 (6,5 – 8,8) | 4 – 10 | — |
| Bonheur moyen | après chauffe | — | 0,91 | 0,04 (0,90 – 0,94) | 0,82 – 0,96 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 50,6 | 53,5 (21,5 – 75,0) | 0,6 – 143,2 | — |
| Jours de prestations réduites | après chauffe | — | 44,5 | 97,3 (13,5 – 110,8) | 0 – 322 | — |
| Trésor de l’État le plus bas | après chauffe | — | 17 813 $ | 2 604 $ (16 377 $ – 18 981 $) | 13 648 $ – 223 360 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 186,8 (0 – 186,8) | 0 – 589 | — |
| Prêts refusés | toute la partie | — | 31,5 | 110,5 (3,3 – 113,8) | 0 – 460 | — |
| Créances radiées | toute la partie | — | 109 068 $ | 10 898 $ (100 774 $ – 111 672 $) | 66 888 $ – 117 869 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/6 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 6/6 | 3 | 1,5 – 3,8 | 1 – 4 | 130,5 j |
| Faim répandue | critique | 6/6 | 3 | 2,3 – 3 | 1 – 5 | 37 j |
| Sans-abri nombreux | critique | 6/6 | 6,5 | 6 – 11,5 | 4 – 19 | 377 j |
| Inégalités hors bornes | attention | 5/6 | 3 | 1,3 – 4 | 0 – 4 | 267,5 j |
| Richesse médiane hors bornes | attention | 1/6 | 0 | 0 – 0 | 0 – 2 | 0 j |
| Inflation quotidienne | critique | 6/6 | 7 | 4,3 – 12 | 3 – 16 | 7 j |
| Inflation sur 100 jours | critique | 6/6 | 1,5 | 1 – 2 | 1 – 3 | 29 j |
| Rupture de stock prolongée | attention | 6/6 | 127 | 114 – 134 | 92 – 149 | 2868,5 j |
| Surstock | attention | 6/6 | 131,5 | 128,5 – 150,3 | 128 – 160 | 6295,5 j |
| Entreprise sans employé | attention | 6/6 | 197,5 | 180 – 203 | 161 – 212 | 3344 j |
| Entreprise sans client | attention | 6/6 | 339,5 | 328,8 – 348 | 310 – 357 | 10331 j |
| Caisse insolvable | attention | 2/6 | 0 | 0 – 0,8 | 0 – 1 | 0 j |
| Santé de la population effondrée | critique | 5/6 | 1 | 1 – 1 | 0 – 1 | 275 j |
| Productivité du travail effondrée | attention | 5/6 | 1 | 1 – 1 | 0 – 1 | 274,5 j |
| Pénurie de main-d’œuvre | attention | 6/6 | 1 | 1 – 1 | 1 – 1 | 16 j |
| Embauches bloquées faute de moyens | attention | 6/6 | 3,5 | 2,3 – 6,3 | 1 – 8 | 177,5 j |
| Prix aberrant | attention | 6/6 | 27,5 | 20,3 – 31,8 | 10 – 46 | 4332 j |
| Attente trop longue (service public) | attention | 5/6 | 3 | 2 – 4,8 | 0 – 5 | 529,5 j |
| Prestations réduites faute de trésor | attention | 5/6 | 1,5 | 1 – 2 | 0 – 3 | 44,5 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 15,0 % | 38,3 % | 0,6 % | 1,3 % | 0,39 | -0,072 % | 880 (27) | 0,82 | 5 % / 15 % / 80 % | 0 | 0 $ |
| 2 | 16,6 % | 43,3 % | 1,7 % | 3,7 % | 0,46 | -0,084 % | 856 (24) | 0,76 | 5 % / 12 % / 83 % | 1 | 18 090 $ |
| 3 | 18,5 % | 38,9 % | 0,0 % | 7,2 % | 0,45 | -0,052 % | 806 (18) | 0,68 | 6 % / 12 % / 82 % | 0 | 3 073 $ |
| 4 | 11,5 % | 32,5 % | 0,0 % | 2,5 % | 0,36 | -0,052 % | 741 (15) | 0,88 | 5 % / 10 % / 85 % | 1 | 9 026 $ |
| 5 | 25,5 % | 54,3 % | 1,3 % | 11,0 % | 0,53 | -0,086 % | 897 (25) | 0,56 | 7 % / 19 % / 74 % | 4 | 0 $ |
| 6 | 20,0 % | 37,9 % | 0,8 % | 1,7 % | 0,48 | -0,089 % | 962 (44) | 0,73 | 7 % / 18 % / 75 % | 3 | 14 799 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 22,5 % | 2,3 pt (21,0 % – 23,4 %) | 14,7 % – 38,9 % | 6/6 |
| Chômage max | toute la partie | — | 44,5 % | 7,1 pt (42,7 % – 49,8 %) | 38,9 % – 75,8 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,5 % | 0,6 pt (0,1 % – 0,7 %) | 0,0 % – 13,9 % | 1/6 |
| Faim max | toute la partie | — | 58,4 % | 40,0 pt (20,9 % – 60,9 %) | 7,4 % – 72,4 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 2,1 % | 6,5 pt (1,0 % – 7,5 %) | 0,1 % – 17,3 % | 3/6 |
| Sans-abri max | toute la partie | — | 56,9 % | 5,4 pt (53,6 % – 59,0 %) | 50,7 % – 63,1 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,43 | 0,10 (0,37 – 0,47) | 0,35 – 0,62 | 3/6 |
| Gini en fin de partie | dernier jour | — | 0,54 | 0,24 (0,41 – 0,65) | 0,33 – 0,86 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,077 % | 0,062 pt (-0,081 % – -0,019 %) | -0,101 % – 0,025 % | 0/6 |
| |Inflation| max / j | toute la partie | — | 53,2 % | 40,2 pt (32,2 % – 72,4 %) | 22,1 % – 86,3 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 147,3 % | 4,0 pt (145,7 % – 149,7 %) | 140,5 % – 169,9 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 23,5 | 2,5 (23 – 25,5) | 17 – 42 | 6/6 |
| … dont après la chauffe | après chauffe | — | 20 | 2,8 (18,3 – 21) | 13 – 38 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 1017 | 981 (726,8 – 1707,8) | 132 – 2605 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 700,5 | 58,3 (669,5 – 727,8) | 633 – 854 | — |
| Santé moyenne | après chauffe | — | 0,64 | 0,13 (0,55 – 0,69) | 0,48 – 0,85 | — |
| Naissances d’entreprises / an | toute la partie | — | 6,2 | 2,9 (5,7 – 8,6) | 4,6 – 9,7 | — |
| Morts d’entreprises / an | toute la partie | — | 25,1 | 2,1 (24,4 – 26,5) | 24,1 – 27,5 | — |
| Entonnoir : projets envisagés | toute la partie | — | 10506 | 1241,5 (10012 – 11253,5) | 9742 – 12127 | — |
| Entonnoir : créations | toute la partie | — | 25,5 | 12 (23,3 – 35,3) | 19 – 40 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 136 | 90 (127 – 217) | 120 – 245 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 1052,5 | 536 (906 – 1442) | 806 – 1766 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 4812,5 | 533 (4734,3 – 5267,3) | 4501 – 5965 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 2164,5 | 731,3 (1868,3 – 2599,5) | 1019 – 3072 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0,8 (0 – 0,8) | 0 – 59 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 2275,5 | 789,5 (1751,8 – 2541,3) | 1103 – 2686 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 12 | 32,3 (5,3 – 37,5) | 0 – 117 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 27 | 5,5 (24,3 – 29,8) | 23 – 30 | — |
| Machines en fin | dernier jour | — | 287,0 | 527,4 (25,1 – 552,5) | 22,4 – 1015,6 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 10 | 4,3 (6,8 – 11) | 5 – 13 | — |
| Bonheur moyen | après chauffe | — | 0,89 | 0,08 (0,83 – 0,90) | 0,68 – 0,96 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 99,1 | 73,6 (72,1 – 145,6) | 7,9 – 229,1 | — |
| Jours de prestations réduites | après chauffe | — | 253,5 | 360 (177,8 – 537,8) | 34 – 661 | — |
| Trésor de l’État le plus bas | après chauffe | — | 13 209 $ | 2 832 $ (11 706 $ – 14 538 $) | 1 333 $ – 15 706 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 53 758 $ | 35 428 $ (44 468 $ – 79 896 $) | 34 970 $ – 96 440 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 31,25 | 42,22 (4,50 – 46,72) | 0,00 – 3082,75 | 4/6 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 27,16 | 2,19 (25,73 – 27,92) | 24,50 – 32,29 | 6/6 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 147,20 | 1017,50 (51,96 – 1069,46) | 11,50 – 2217,04 | 6/6 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/6 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/6 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/6 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 31,25 | 4,50 – 46,72 | 0,00 – 3082,75 | 4/6 | 89552 | prix trop élevé (95 %) ; pas de producteur (5 %) |
| Renflouement d’entreprise | 27,16 | 25,73 – 27,92 | 24,50 – 32,29 | 6/6 | 6037 | par le propriétaire (92 %) ; après rachat (8 %) |
| Plancher de logement | 147,20 | 51,96 – 1069,46 | 11,50 – 2217,04 | 6/6 | 123016 | prix trop élevé (74 %) ; parc plein (26 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/6 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/6 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 6 graines · graines touchées) : Tourisme 1105 · 6, Ferme 538 · 6, Ingénierie pétrolière 385 · 6, Hôtel 345 · 6, Bijouterie 317 · 6, Marketing 209 · 6, Ingénierie de CPU 208 · 6, Pétrochimie 205 · 5.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 38,9 % | 75,8 % | 13,9 % | 17,3 % | 0,62 | -0,101 % | 718 (24) | 0,48 | 6 % / 21 % / 74 % | 0 | 13 339 $ |
| 2 | 20,8 % | 38,9 % | 0,0 % | 0,7 % | 0,35 | -0,079 % | 665 (23) | 0,67 | 6 % / 14 % / 80 % | 2 | 17 200 $ |
| 3 | 14,7 % | 42,2 % | 0,0 % | 0,1 % | 0,36 | -0,082 % | 683 (17) | 0,85 | 4 % / 15 % / 81 % | 3 | 22 674 $ |
| 4 | 21,8 % | 51,5 % | 0,5 % | 1,9 % | 0,39 | -0,000 % | 731 (26) | 0,69 | 8 % / 20 % / 72 % | 3 | 2 616 $ |
| 5 | 23,5 % | 44,7 % | 0,6 % | 9,3 % | 0,47 | 0,025 % | 633 (23) | 0,53 | 9 % / 28 % / 63 % | 0 | 4 793 $ |
| 6 | 23,1 % | 44,3 % | 0,7 % | 2,2 % | 0,47 | -0,075 % | 854 (42) | 0,61 | 7 % / 25 % / 69 % | 1 | 6 579 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 6/6 : g1 27, g2 24, g3 18, g4 15, g5 25, g6 44 |
| Chômage moyen ≤ 10 % | ❌ | 6/6 : g1 15,0 %, g2 16,6 %, g3 18,5 %, g4 11,5 %, g5 25,5 %, g6 20,0 % |
| Faim et sans-abri < 2 % | ❌ | 4/6 : g2, g3, g4, g5 |
| Gini 0,2–0,45 | ❌ | 4/6 : g2 0,46, g3 0,45, g5 0,53, g6 0,48 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 6 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 6 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 4/6 graines ; Renflouement d’entreprise : 6/6 graines ; Plancher de logement : 6/6 graines |

