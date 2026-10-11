# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 14:36
- Graines : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Caisse : règles prudentielles, Faillite ordonnée
- Temps total : 4 min 19 s pour 210 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,9 % | 1,6 pt (7,4 % – 8,9 %) | 6,0 % – 72,9 % | 3/30 |
| Chômage max | toute la partie | — | 27,1 % | 6,3 pt (24,4 % – 30,6 %) | 20,8 % – 97,9 % | — |
| Faim moyenne | après chauffe | < 2 % | 7,3 % | 3,0 pt (5,5 % – 8,5 %) | 1,4 % – 77,3 % | 29/30 |
| Faim max | toute la partie | — | 95,4 % | 1,5 pt (94,3 % – 95,7 %) | 88,3 % – 100,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 2,6 % | 0,8 pt (1,9 % – 2,8 %) | 0,7 % – 75,4 % | 21/30 |
| Sans-abri max | toute la partie | — | 43,1 % | 16,2 pt (39,3 % – 55,5 %) | 31,3 % – 100,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,35 | 0,05 (0,32 – 0,37) | 0,26 – 0,45 | 0/30 |
| Gini en fin de partie | dernier jour | — | 0,27 | 0,28 (0,18 – 0,46) | 0,11 – 0,89 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,072 % | 0,032 pt (0,056 % – 0,087 %) | 0,024 % – 0,099 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 31,8 % | 32,5 pt (22,7 % – 55,3 %) | 14,6 % – 89,3 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 136,2 % | 18,0 pt (126,1 % – 144,1 %) | 103,9 % – 164,0 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 28 | 6,5 (24,3 – 30,8) | 13 – 35 | 30/30 |
| … dont après la chauffe | après chauffe | — | 25,5 | 6,8 (22,3 – 29) | 8 – 34 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 1528 | 148,8 (1447,8 – 1596,5) | 1208 – 4470 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 595 | 180 (445 – 625) | 281 – 688 | — |
| Santé moyenne | après chauffe | — | 0,17 | 0,08 (0,15 – 0,23) | 0,12 – 0,39 | — |
| Bonheur moyen | après chauffe | — | 0,81 | 0,01 (0,81 – 0,82) | 0,24 – 0,85 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 482,3 | 207,5 (373,0 – 580,5) | 185,1 – 622,8 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 1049 | — |
| Trésor de l’État le plus bas | après chauffe | — | 94 272 $ | 48 816 $ (59 981 $ – 108 797 $) | 129 $ – 121 426 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 1392 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 20 219 $ | 9 318 $ (14 783 $ – 24 101 $) | 5 306 $ – 54 516 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 3/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Chômage nul prolongé | attention | 1/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Faim répandue | critique | 30/30 | 5,5 | 4,3 – 7 | 1 – 9 | 152,5 j |
| Sans-abri nombreux | critique | 30/30 | 10 | 9 – 12 | 2 – 17 | 143 j |
| Inégalités hors bornes | attention | 28/30 | 3 | 2 – 4 | 0 – 7 | 150 j |
| Richesse médiane hors bornes | attention | 9/30 | 0 | 0 – 1 | 0 – 2 | 0 j |
| Inflation quotidienne | critique | 30/30 | 7,5 | 5,3 – 9 | 2 – 13 | 7,5 j |
| Inflation sur 100 jours | critique | 30/30 | 2 | 1 – 3 | 1 – 5 | 31,5 j |
| Rupture de stock prolongée | attention | 30/30 | 151 | 108,3 – 164,5 | 60 – 188 | 5665,5 j |
| Surstock | attention | 30/30 | 40 | 30,3 – 46,8 | 19 – 65 | 1351 j |
| Entreprise sans employé | attention | 30/30 | 157 | 115,3 – 162 | 70 – 198 | 2174,5 j |
| Entreprise sans client | attention | 30/30 | 181,5 | 132,3 – 187,8 | 82 – 209 | 5518,5 j |
| Caisse insolvable | attention | 6/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Santé de la population effondrée | critique | 30/30 | 1 | 1 – 1 | 1 – 2 | 1201 j |
| Productivité du travail effondrée | attention | 30/30 | 1 | 1 – 1 | 1 – 2 | 1201,5 j |
| Pénurie de main-d’œuvre | attention | 4/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Embauches bloquées faute de moyens | attention | 30/30 | 7 | 5 – 8,8 | 2 – 12 | 297 j |
| Prix aberrant | attention | 30/30 | 19,5 | 15 – 23 | 9 – 27 | 2555,5 j |
| Attente trop longue (service public) | attention | 30/30 | 1 | 1 – 1 | 1 – 4 | 1293,5 j |
| Prestations réduites faute de trésor | attention | 2/30 | 0 | 0 – 0 | 0 – 1 | 0 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 10,1 % | 34,6 % | 9,6 % | 2,6 % | 0,32 | 0,098 % | 645 (35) | 0,25 | 10 % / 26 % / 64 % | 5 | 10 653 $ |
| 2 | 6,9 % | 25,8 % | 6,1 % | 1,4 % | 0,29 | 0,075 % | 569 (18) | 0,15 | 10 % / 18 % / 72 % | 0 | 9 244 $ |
| 3 | 7,9 % | 27,5 % | 7,3 % | 1,6 % | 0,35 | 0,052 % | 629 (26) | 0,14 | 9 % / 21 % / 70 % | 1 | 239 $ |
| 4 | 9,6 % | 30,0 % | 8,2 % | 2,0 % | 0,35 | 0,059 % | 615 (28) | 0,17 | 6 % / 19 % / 75 % | 0 | 0 $ |
| 5 | 7,6 % | 26,3 % | 9,5 % | 2,8 % | 0,37 | 0,068 % | 605 (29) | 0,20 | 4 % / 19 % / 78 % | 4 | 15 479 $ |
| 6 | 7,9 % | 31,7 % | 9,6 % | 4,1 % | 0,43 | 0,086 % | 506 (30) | 0,21 | 6 % / 25 % / 68 % | 4 | 41 158 $ |
| 7 | 7,0 % | 24,2 % | 8,4 % | 2,3 % | 0,32 | 0,067 % | 592 (30) | 0,13 | 5 % / 22 % / 73 % | 5 | 12 711 $ |
| 8 | 6,0 % | 25,0 % | 1,4 % | 1,4 % | 0,30 | 0,088 % | 290 (26) | 0,23 | 1 % / 13 % / 86 % | 2 | 15 460 $ |
| 9 | 7,1 % | 36,3 % | 5,5 % | 2,9 % | 0,43 | 0,099 % | 388 (21) | 0,17 | 9 % / 18 % / 73 % | 2 | 0 $ |
| 10 | 9,9 % | 26,7 % | 5,3 % | 1,3 % | 0,30 | 0,045 % | 688 (35) | 0,23 | 10 % / 26 % / 64 % | 7 | 0 $ |
| 11 | 9,6 % | 35,8 % | 6,5 % | 2,6 % | 0,31 | 0,069 % | 671 (32) | 0,19 | 3 % / 29 % / 68 % | 6 | 5 578 $ |
| 12 | 7,8 % | 22,9 % | 8,8 % | 1,8 % | 0,32 | 0,085 % | 622 (30) | 0,23 | 10 % / 22 % / 68 % | 6 | 11 675 $ |
| 13 | 6,7 % | 21,3 % | 5,2 % | 2,7 % | 0,37 | 0,089 % | 281 (25) | 0,14 | 5 % / 23 % / 72 % | 3 | 18 607 $ |
| 14 | 7,5 % | 22,1 % | 5,6 % | 2,7 % | 0,43 | 0,055 % | 345 (18) | 0,14 | 4 % / 19 % / 77 % | 2 | 8 264 $ |
| 15 | 8,7 % | 26,3 % | 5,2 % | 1,2 % | 0,35 | 0,051 % | 627 (26) | 0,16 | 8 % / 20 % / 72 % | 5 | 0 $ |
| 16 | 7,6 % | 23,8 % | 8,8 % | 3,0 % | 0,34 | 0,036 % | 598 (32) | 0,13 | 3 % / 12 % / 85 % | 4 | 11 838 $ |
| 17 | 7,3 % | 22,1 % | 7,6 % | 4,4 % | 0,34 | 0,068 % | 481 (26) | 0,21 | 8 % / 29 % / 63 % | 2 | 25 167 $ |
| 18 | 8,0 % | 28,7 % | 5,5 % | 2,6 % | 0,43 | 0,089 % | 344 (28) | 0,16 | 8 % / 20 % / 72 % | 2 | 0 $ |
| 19 | 8,6 % | 27,9 % | 7,9 % | 1,9 % | 0,36 | 0,067 % | 626 (23) | 0,12 | 11 % / 24 % / 65 % | 6 | 25 996 $ |
| 20 | 8,9 % | 28,7 % | 2,1 % | 2,0 % | 0,36 | 0,062 % | 448 (31) | 0,25 | 10 % / 20 % / 69 % | 1 | 0 $ |
| 21 | 8,9 % | 28,7 % | 7,2 % | 2,3 % | 0,33 | 0,090 % | 640 (24) | 0,24 | 11 % / 27 % / 62 % | 7 | 2 660 $ |
| 22 | 7,2 % | 20,8 % | 5,6 % | 3,5 % | 0,45 | 0,098 % | 394 (29) | 0,15 | 9 % / 18 % / 73 % | 1 | 9 436 $ |
| 23 | 7,6 % | 26,7 % | 6,7 % | 2,7 % | 0,30 | 0,093 % | 513 (30) | 0,30 | 12 % / 21 % / 67 % | 1 | 438 $ |
| 24 | 19,8 % | 84,2 % | 17,6 % | 7,0 % | 0,35 | 0,084 % | 622 (32) | 0,39 | 13 % / 13 % / 74 % | 3 | 263 $ |
| 25 | 72,9 % | 97,9 % | 77,3 % | 75,4 % | 0,35 | 0,024 % | 584 (13) | 0,14 | 0 % / 36 % / 64 % | 9 | 0 $ |
| 26 | 7,9 % | 27,5 % | 3,2 % | 0,7 % | 0,26 | 0,077 % | 444 (17) | 0,25 | 10 % / 23 % / 68 % | 2 | 0 $ |
| 27 | 8,7 % | 25,4 % | 8,5 % | 2,1 % | 0,35 | 0,041 % | 643 (32) | 0,16 | 6 % / 31 % / 64 % | 5 | 15 113 $ |
| 28 | 7,2 % | 30,8 % | 4,5 % | 2,6 % | 0,42 | 0,076 % | 371 (24) | 0,16 | 9 % / 24 % / 67 % | 5 | 0 $ |
| 29 | 7,4 % | 21,3 % | 8,2 % | 2,4 % | 0,33 | 0,036 % | 622 (33) | 0,15 | 11 % / 20 % / 69 % | 5 | 0 $ |
| 30 | 9,6 % | 31,7 % | 8,1 % | 2,6 % | 0,32 | 0,087 % | 613 (26) | 0,20 | 4 % / 24 % / 71 % | 7 | 14 778 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,0 % | 2,0 pt (6,0 % – 8,0 %) | 4,8 % – 12,9 % | 5/30 |
| Chômage max | toute la partie | — | 19,0 % | 9,5 pt (16,3 % – 25,7 %) | 14,6 % – 41,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 1,5 % | 0/30 |
| Faim max | toute la partie | — | 45,0 % | 52,0 pt (6,7 % – 58,6 %) | 0,0 % – 83,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,2 % | 0,5 pt (0,0 % – 0,5 %) | 0,0 % – 1,6 % | 0/30 |
| Sans-abri max | toute la partie | — | 18,3 % | 27,0 pt (6,1 % – 33,1 %) | 3,8 % – 64,6 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,20 | 0,02 (0,19 – 0,21) | 0,15 – 0,36 | 13/30 |
| Gini en fin de partie | dernier jour | — | 0,15 | 0,09 (0,14 – 0,23) | 0,12 – 0,46 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,040 % | 0,032 pt (0,024 % – 0,057 %) | -0,033 % – 0,102 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 47,8 % | 23,9 pt (34,0 % – 57,9 %) | 10,7 % – 90,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,0 % | 14,8 pt (134,4 % – 149,2 %) | 114,7 % – 228,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10 | 4 (9 – 13) | 4 – 23 | 30/30 |
| … dont après la chauffe | après chauffe | — | 8 | 4,8 (6,3 – 11) | 3 – 20 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 78,5 | 76,3 (44,8 – 121) | 29 – 1397 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 139,5 | 26 (131,3 – 157,3) | 112 – 531 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,0003 (0,88 – 0,88) | 0,20 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,004 (0,97 – 0,97) | 0,83 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,3 | 0,03 (0,3 – 0,4) | 0,3 – 313,7 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 126 | — |
| Trésor de l’État le plus bas | après chauffe | — | 52 260 $ | 66 278 $ (15 715 $ – 81 993 $) | 3 882 $ – 109 550 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 66 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 323 | — |
| Créances radiées | toute la partie | — | 0 $ | 37 $ (0 $ – 37 $) | 0 $ – 53 800 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,18 | 1,35 (0,00 – 1,35) | 0,00 – 37,29 | 10/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 13,05 | 6,75 (11,22 – 17,97) | 7,96 – 28,61 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 2,11 | 22,79 (0,04 – 22,83) | 0,00 – 60,07 | 17/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 11,54 | 1/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,18 | 0,00 – 1,35 | 0,00 – 37,29 | 10/30 | 1764 | pas de producteur (100 %) |
| Renflouement d’entreprise | 13,05 | 11,22 – 17,97 | 7,96 – 28,61 | 30/30 | 13540 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 2,11 | 0,04 – 22,83 | 0,00 – 60,07 | 17/30 | 11920 | prix trop élevé (81 %) ; parc plein (19 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 11,54 | 1/30 | 323 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 3359 · 30, Bijouterie 1865 · 29, Tourisme 1470 · 24, Fonderie 944 · 30, Mine de fer 899 · 30, Pêcherie 828 · 30, Garage 619 · 14, Machinerie 301 · 12.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,4 % | 26,7 % | 0,1 % | 0,2 % | 0,36 | 0,032 % | 154 (13) | 0,88 | 7 % / 12 % / 81 % | 2 | 0 $ |
| 2 | 7,9 % | 24,2 % | 0,1 % | 0,0 % | 0,20 | 0,001 % | 125 (7) | 0,88 | 4 % / 19 % / 78 % | 0 | 6 001 $ |
| 3 | 7,4 % | 17,1 % | 0,1 % | 0,2 % | 0,21 | 0,024 % | 131 (7) | 0,88 | 7 % / 15 % / 78 % | 1 | 3 202 $ |
| 4 | 10,1 % | 27,9 % | 0,4 % | 1,6 % | 0,23 | 0,047 % | 252 (19) | 0,72 | 8 % / 10 % / 82 % | 1 | 10 207 $ |
| 5 | 7,7 % | 22,1 % | 0,0 % | 0,0 % | 0,17 | 0,102 % | 118 (7) | 0,88 | 6 % / 13 % / 81 % | 1 | 11 142 $ |
| 6 | 4,8 % | 16,3 % | 0,0 % | 0,0 % | 0,15 | 0,026 % | 131 (12) | 0,88 | 7 % / 13 % / 80 % | 0 | 12 657 $ |
| 7 | 6,0 % | 17,1 % | 0,0 % | 0,3 % | 0,19 | 0,003 % | 158 (10) | 0,88 | 6 % / 16 % / 78 % | 1 | 15 938 $ |
| 8 | 6,8 % | 18,3 % | 0,2 % | 0,0 % | 0,19 | 0,056 % | 128 (10) | 0,88 | 7 % / 12 % / 81 % | 1 | 1 882 $ |
| 9 | 7,0 % | 23,3 % | 0,1 % | 0,7 % | 0,21 | 0,024 % | 155 (19) | 0,88 | 7 % / 13 % / 80 % | 0 | 18 172 $ |
| 10 | 7,9 % | 27,1 % | 0,1 % | 0,0 % | 0,19 | 0,035 % | 122 (8) | 0,88 | 6 % / 12 % / 82 % | 0 | 19 257 $ |
| 11 | 6,4 % | 17,9 % | 0,1 % | 0,0 % | 0,20 | 0,055 % | 140 (7) | 0,88 | 6 % / 13 % / 81 % | 1 | 14 474 $ |
| 12 | 8,0 % | 15,8 % | 0,1 % | 0,3 % | 0,25 | -0,030 % | 121 (9) | 0,88 | 8 % / 18 % / 74 % | 0 | 0 $ |
| 13 | 6,4 % | 23,8 % | 0,0 % | 0,7 % | 0,19 | 0,053 % | 149 (13) | 0,88 | 7 % / 12 % / 81 % | 1 | 21 061 $ |
| 14 | 6,3 % | 17,9 % | 0,1 % | 0,1 % | 0,20 | 0,066 % | 132 (12) | 0,88 | 7 % / 14 % / 79 % | 1 | 26 864 $ |
| 15 | 10,9 % | 27,9 % | 0,0 % | 1,0 % | 0,22 | -0,014 % | 199 (23) | 0,88 | 3 % / 22 % / 75 % | 0 | 0 $ |
| 16 | 5,9 % | 15,4 % | 0,0 % | 0,0 % | 0,19 | 0,040 % | 145 (10) | 0,88 | 5 % / 16 % / 79 % | 1 | 34 615 $ |
| 17 | 5,2 % | 16,3 % | 0,0 % | 0,0 % | 0,17 | 0,065 % | 165 (11) | 0,88 | 4 % / 14 % / 82 % | 0 | 0 $ |
| 18 | 5,8 % | 14,6 % | 0,0 % | 0,2 % | 0,20 | 0,063 % | 164 (9) | 0,88 | 6 % / 13 % / 81 % | 0 | 10 510 $ |
| 19 | 9,0 % | 29,6 % | 0,0 % | 0,5 % | 0,21 | 0,029 % | 138 (14) | 0,88 | 5 % / 17 % / 78 % | 0 | 2 212 $ |
| 20 | 5,9 % | 16,3 % | 0,0 % | 0,1 % | 0,19 | 0,045 % | 112 (4) | 0,88 | 6 % / 12 % / 82 % | 0 | 7 949 $ |
| 21 | 8,0 % | 18,3 % | 0,2 % | 0,0 % | 0,20 | 0,038 % | 142 (11) | 0,88 | 3 % / 19 % / 79 % | 0 | 19 524 $ |
| 22 | 6,8 % | 15,4 % | 0,0 % | 0,5 % | 0,26 | 0,079 % | 171 (9) | 0,88 | 4 % / 17 % / 79 % | 0 | 20 751 $ |
| 23 | 7,0 % | 22,5 % | 0,0 % | 0,4 % | 0,21 | 0,081 % | 139 (10) | 0,88 | 7 % / 14 % / 78 % | 1 | 257 $ |
| 24 | 5,2 % | 15,0 % | 0,2 % | 0,1 % | 0,18 | 0,025 % | 136 (10) | 0,88 | 7 % / 12 % / 81 % | 2 | 29 867 $ |
| 25 | 6,2 % | 14,6 % | 0,2 % | 0,1 % | 0,20 | 0,042 % | 137 (9) | 0,88 | 7 % / 13 % / 81 % | 0 | 8 497 $ |
| 26 | 5,0 % | 20,4 % | 0,0 % | 0,0 % | 0,17 | 0,073 % | 135 (9) | 0,88 | 6 % / 13 % / 81 % | 0 | 0 $ |
| 27 | 8,5 % | 26,3 % | 0,1 % | 0,0 % | 0,20 | 0,057 % | 132 (13) | 0,88 | 6 % / 12 % / 81 % | 1 | 7 587 $ |
| 28 | 7,8 % | 19,6 % | 0,0 % | 0,6 % | 0,20 | 0,039 % | 148 (10) | 0,88 | 6 % / 13 % / 81 % | 0 | 0 $ |
| 29 | 12,9 % | 36,3 % | 0,2 % | 1,5 % | 0,28 | -0,033 % | 531 (21) | 0,52 | 6 % / 16 % / 78 % | 4 | 43 426 $ |
| 30 | 11,2 % | 41,7 % | 1,5 % | 1,0 % | 0,27 | 0,001 % | 372 (21) | 0,20 | 7 % / 25 % / 68 % | 1 | 0 $ |

</details>

## 2 bis (1). Avec filets, sauf « Anti-famine »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,1 % | 2,1 pt (6,1 % – 8,2 %) | 4,8 % – 13,7 % | 4/30 |
| Chômage max | toute la partie | — | 19,0 % | 9,5 pt (16,3 % – 25,7 %) | 14,6 % – 41,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,2 pt (0,0 % – 0,2 %) | 0,0 % – 3,2 % | 1/30 |
| Faim max | toute la partie | — | 45,0 % | 54,2 pt (6,7 % – 60,8 %) | 0,0 % – 88,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,2 % | 0,5 pt (0,0 % – 0,5 %) | 0,0 % – 1,3 % | 0/30 |
| Sans-abri max | toute la partie | — | 17,9 % | 25,7 pt (6,1 % – 31,9 %) | 3,8 % – 65,4 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,20 | 0,02 (0,19 – 0,21) | 0,15 – 0,37 | 13/30 |
| Gini en fin de partie | dernier jour | — | 0,18 | 0,09 (0,14 – 0,23) | 0,12 – 0,43 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,040 % | 0,035 pt (0,025 % – 0,060 %) | -0,064 % – 0,102 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 45,8 % | 24,5 pt (32,7 % – 57,2 %) | 10,7 % – 90,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,0 % | 14,8 pt (134,4 % – 149,2 %) | 114,7 % – 228,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10 | 3,8 (9 – 12,8) | 4 – 23 | 30/30 |
| … dont après la chauffe | après chauffe | — | 8 | 3,8 (7 – 10,8) | 3 – 20 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 79 | 76,5 (44,5 – 121) | 31 – 1438 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 139 | 26 (131,3 – 157,3) | 110 – 297 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,0003 (0,88 – 0,88) | 0,22 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,004 (0,97 – 0,97) | 0,84 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,3 | 0,03 (0,3 – 0,4) | 0,3 – 523,3 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 126 | — |
| Trésor de l’État le plus bas | après chauffe | — | 57 414 $ | 67 041 $ (15 668 $ – 82 709 $) | 3 882 $ – 109 550 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 49 $ (0 $ – 49 $) | 0 $ – 10 116 $ | — |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 11,95 | 8,21 (10,56 – 18,78) | 8,61 – 26,29 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 2,11 | 22,79 (0,04 – 22,83) | 0,00 – 60,39 | 17/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | coupé | — | — | — | — | — |
| Renflouement d’entreprise | 11,95 | 10,56 – 18,78 | 8,61 – 26,29 | 30/30 | 13176 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 2,11 | 0,04 – 22,83 | 0,00 – 60,39 | 17/30 | 11485 | prix trop élevé (84 %) ; parc plein (16 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 3021 · 30, Bijouterie 1793 · 28, Tourisme 1579 · 24, Fonderie 966 · 30, Pêcherie 899 · 30, Mine de fer 831 · 30, Garage 679 · 15, Machinerie 393 · 12.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-famine »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 7,1 % | 5 → 4 | 0,0 pt | [0,0 pt ; +0,1 pt] | 8 / 11 / 11 sur 30 | non concluant |
| Chômage max | 19,0 % | 19,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 1 | +0,002 pt | [0,0 pt ; +0,01 pt] | 0 / 19 / 11 sur 30 | non concluant |
| Faim max | 45,0 % | 45,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 3 / 27 sur 30 | non concluant |
| Sans-abri moyen | 0,2 % | 0,2 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 5 / 7 / 18 sur 30 | non concluant |
| Sans-abri max | 18,3 % | 17,9 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 2 / 27 sur 30 | non concluant |
| Gini moyen | 0,20 | 0,20 | 13 → 13 | 0,00 | [0,00 ; +0,001] | — / — / 11 | non concluant |
| Gini en fin de partie | 0,15 | 0,18 | — | 0,00 | [−0,004 ; 0,00] | — / — / 11 | non concluant |
| Inflation moyenne / j | 0,040 % | 0,040 % | 0 → 0 | 0,000 pt | [0,000 pt ; +0,00001 pt] | — / — / 11 | non concluant |
| |Inflation| max / j | 47,8 % | 45,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 5 / 2 / 23 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 141,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 0 / 29 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 10 | 30 → 30 | 0 | [0 ; 0] | 5 / 3 / 22 sur 30 | non concluant |
| … dont après la chauffe | 8 | 8 | — | 0 | [0 ; 0] | 5 / 3 / 22 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 78,5 | 79 | — | 0 | [0 ; 0] | 2 / 8 / 20 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 139,5 | 139 | — | 0 | [0 ; 0] | 8 / 8 / 14 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 4 / 7 / 19 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [−0,0001 ; 0,00] | 5 / 14 / 11 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,3 | 0,3 | — | 0,0 | [0,0 ; 0,0] | 7 / 4 / 19 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Trésor de l’État le plus bas | 52 260 $ | 57 414 $ | — | 0 $ | [0 $ ; 0 $] | 1 / 1 / 28 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 26 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,05 | 11,95 | 30 → 30 | 0,00 | [−0,34 ; 0,00] | 11 / 7 / 12 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 2,11 | 2,11 | 17 → 17 | 0,00 | [0,00 ; 0,00] | 2 / 3 / 25 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 0 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-famine »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,4 % | 26,7 % | 0,1 % | 0,3 % | 0,37 | 0,034 % | 162 (13) | 0,88 | 11 % / 13 % / 75 % | 5 | 3 672 $ |
| 2 | 7,2 % | 24,2 % | 0,1 % | 0,0 % | 0,20 | 0,016 % | 139 (8) | 0,88 | 7 % / 14 % / 80 % | 2 | 19 262 $ |
| 3 | 7,4 % | 17,1 % | 0,1 % | 0,2 % | 0,21 | 0,029 % | 130 (7) | 0,88 | 6 % / 17 % / 77 % | 1 | 1 381 $ |
| 4 | 8,2 % | 30,8 % | 3,2 % | 1,2 % | 0,23 | 0,042 % | 297 (14) | 0,22 | 12 % / 18 % / 71 % | 2 | 0 $ |
| 5 | 7,7 % | 22,1 % | 0,0 % | 0,0 % | 0,17 | 0,102 % | 118 (7) | 0,88 | 6 % / 13 % / 81 % | 1 | 11 142 $ |
| 6 | 4,8 % | 16,3 % | 0,0 % | 0,0 % | 0,15 | 0,026 % | 131 (12) | 0,88 | 7 % / 13 % / 80 % | 0 | 12 657 $ |
| 7 | 6,0 % | 17,1 % | 0,0 % | 0,3 % | 0,19 | 0,003 % | 158 (10) | 0,88 | 6 % / 16 % / 78 % | 1 | 15 938 $ |
| 8 | 7,2 % | 18,3 % | 0,2 % | 0,0 % | 0,19 | 0,056 % | 128 (10) | 0,88 | 6 % / 15 % / 80 % | 0 | 4 537 $ |
| 9 | 7,1 % | 23,3 % | 0,1 % | 0,7 % | 0,21 | 0,024 % | 155 (19) | 0,88 | 7 % / 14 % / 79 % | 0 | 14 311 $ |
| 10 | 8,5 % | 27,1 % | 0,1 % | 0,0 % | 0,20 | 0,037 % | 129 (10) | 0,88 | 9 % / 15 % / 76 % | 0 | 27 018 $ |
| 11 | 6,8 % | 17,9 % | 0,2 % | 0,0 % | 0,20 | 0,059 % | 141 (7) | 0,88 | 6 % / 12 % / 82 % | 1 | 2 611 $ |
| 12 | 7,7 % | 15,8 % | 0,1 % | 0,3 % | 0,24 | -0,031 % | 113 (9) | 0,88 | 7 % / 17 % / 75 % | 0 | 0 $ |
| 13 | 6,3 % | 23,8 % | 0,0 % | 0,7 % | 0,19 | 0,053 % | 150 (13) | 0,88 | 7 % / 12 % / 81 % | 1 | 21 302 $ |
| 14 | 6,5 % | 17,9 % | 0,1 % | 0,1 % | 0,21 | 0,066 % | 132 (12) | 0,88 | 6 % / 14 % / 80 % | 1 | 15 092 $ |
| 15 | 10,9 % | 27,9 % | 0,0 % | 1,0 % | 0,22 | -0,014 % | 199 (23) | 0,88 | 3 % / 22 % / 75 % | 0 | 0 $ |
| 16 | 5,9 % | 15,4 % | 0,0 % | 0,0 % | 0,19 | 0,040 % | 145 (10) | 0,88 | 5 % / 16 % / 79 % | 1 | 34 615 $ |
| 17 | 5,2 % | 16,3 % | 0,0 % | 0,0 % | 0,17 | 0,065 % | 165 (11) | 0,88 | 4 % / 14 % / 82 % | 0 | 0 $ |
| 18 | 5,8 % | 14,6 % | 0,0 % | 0,2 % | 0,20 | 0,063 % | 164 (9) | 0,88 | 6 % / 13 % / 81 % | 0 | 10 510 $ |
| 19 | 9,0 % | 29,6 % | 0,0 % | 0,5 % | 0,21 | 0,029 % | 138 (14) | 0,88 | 5 % / 17 % / 78 % | 0 | 2 212 $ |
| 20 | 6,0 % | 16,3 % | 0,0 % | 0,1 % | 0,19 | 0,044 % | 110 (4) | 0,88 | 6 % / 13 % / 81 % | 0 | 5 910 $ |
| 21 | 8,2 % | 18,3 % | 0,3 % | 0,0 % | 0,20 | 0,024 % | 146 (11) | 0,88 | 6 % / 15 % / 80 % | 2 | 8 126 $ |
| 22 | 6,6 % | 15,4 % | 0,0 % | 0,3 % | 0,27 | 0,079 % | 133 (10) | 0,88 | 8 % / 18 % / 74 % | 0 | 21 582 $ |
| 23 | 7,0 % | 22,5 % | 0,0 % | 0,4 % | 0,21 | 0,081 % | 139 (10) | 0,88 | 7 % / 14 % / 78 % | 1 | 257 $ |
| 24 | 5,6 % | 15,0 % | 0,2 % | 0,1 % | 0,18 | 0,004 % | 133 (9) | 0,88 | 7 % / 14 % / 79 % | 0 | 16 030 $ |
| 25 | 6,1 % | 14,6 % | 0,3 % | 0,1 % | 0,20 | 0,045 % | 139 (9) | 0,88 | 7 % / 13 % / 81 % | 0 | 9 375 $ |
| 26 | 5,0 % | 20,4 % | 0,0 % | 0,0 % | 0,17 | 0,073 % | 135 (9) | 0,88 | 6 % / 13 % / 81 % | 0 | 0 $ |
| 27 | 8,8 % | 26,3 % | 0,2 % | 0,0 % | 0,21 | 0,060 % | 126 (11) | 0,88 | 6 % / 13 % / 81 % | 0 | 9 050 $ |
| 28 | 7,8 % | 19,6 % | 0,0 % | 0,6 % | 0,20 | 0,039 % | 148 (10) | 0,88 | 6 % / 13 % / 81 % | 0 | 0 $ |
| 29 | 13,7 % | 36,3 % | 0,3 % | 1,3 % | 0,27 | -0,064 % | 274 (18) | 0,48 | 6 % / 11 % / 83 % | 1 | 1 462 $ |
| 30 | 10,6 % | 41,7 % | 1,6 % | 0,8 % | 0,26 | 0,034 % | 254 (18) | 0,24 | 11 % / 20 % / 69 % | 0 | 0 $ |

</details>

## 2 bis (2). Avec filets, sauf « Renflouement d’entreprise »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,0 % | 1,6 pt (7,6 % – 9,2 %) | 6,0 % – 11,7 % | 5/30 |
| Chômage max | toute la partie | — | 25,4 % | 4,9 pt (24,3 % – 29,2 %) | 21,7 % – 39,2 % | — |
| Faim moyenne | après chauffe | < 2 % | 3,5 % | 2,0 pt (3,0 % – 5,0 %) | 0,7 % – 7,4 % | 27/30 |
| Faim max | toute la partie | — | 95,0 % | 2,0 pt (93,4 % – 95,4 %) | 86,7 % – 96,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 1,2 % | 1,0 pt (0,7 % – 1,7 %) | 0,4 % – 2,3 % | 3/30 |
| Sans-abri max | toute la partie | — | 35,8 % | 8,1 pt (31,8 % – 39,9 %) | 21,3 % – 65,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,34 | 0,09 (0,33 – 0,41) | 0,27 – 0,47 | 1/30 |
| Gini en fin de partie | dernier jour | — | 0,35 | 0,34 (0,26 – 0,61) | 0,18 – 0,76 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,060 % | 0,023 pt (0,047 % – 0,070 %) | -0,015 % – 0,096 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 35,5 % | 26,0 pt (23,6 % – 49,6 %) | 10,9 % – 62,7 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 132,5 % | 17,9 pt (125,5 % – 143,4 %) | 100,9 % – 160,5 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 20 | 6 (17 – 23) | 9 – 27 | 30/30 |
| … dont après la chauffe | après chauffe | — | 17,5 | 4 (16 – 20) | 8 – 25 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 1383,5 | 184,3 (1271 – 1455,3) | 1176 – 1518 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 519 | 189,8 (420,3 – 610) | 219 – 715 | — |
| Santé moyenne | après chauffe | — | 0,17 | 0,08 (0,15 – 0,23) | 0,11 – 0,33 | — |
| Bonheur moyen | après chauffe | — | 0,82 | 0,02 (0,81 – 0,83) | 0,80 – 0,84 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 511,7 | 153,6 (419,8 – 573,4) | 215,2 – 608,9 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 69 | — |
| Trésor de l’État le plus bas | après chauffe | — | 98 210 $ | 47 219 $ (63 392 $ – 110 611 $) | 4 911 $ – 120 026 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 511,5 (0 – 511,5) | 0 – 1345 | — |
| Prêts refusés | toute la partie | — | 2,5 | 96,8 (0 – 96,8) | 0 – 205 | — |
| Créances radiées | toute la partie | — | 24 472 $ | 8 796 $ (18 674 $ – 27 470 $) | 7 268 $ – 49 204 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 112,75 | 82,82 (85,08 – 167,90) | 21,25 – 282,79 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 28,46 | 28,97 (11,96 – 40,94) | 4,64 – 75,21 | 30/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,09 | 3,46 (0,00 – 3,46) | 0,00 – 7,32 | 12/30 |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 112,75 | 85,08 – 167,90 | 21,25 – 282,79 | 30/30 | 106863 | pas de producteur (100 %) |
| Renflouement d’entreprise | coupé | — | — | — | — | — |
| Plancher de logement | 28,46 | 11,96 – 40,94 | 4,64 – 75,21 | 30/30 | 25647 | prix trop élevé (91 %) ; parc plein (9 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,09 | 0,00 – 3,46 | 0,00 – 7,32 | 12/30 | 1491 | fonds propres de la Caisse insuffisants (100 %) |

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « renflouement d’entreprise »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 8,0 % | 5 → 5 | +1,2 pt | [+0,2 pt ; +1,8 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 19,0 % | 25,4 % | — | +6,7 pt | [+4,0 pt ; +8,3 pt] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,1 % | 3,5 % | 0 → 27 | +3,4 pt | [+3,0 pt ; +4,5 pt] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Faim max | 45,0 % | 95,0 % | — | +47,5 pt | [+40,8 pt ; +74,6 pt] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri moyen | 0,2 % | 1,2 % | 0 → 3 | +0,8 pt | [+0,5 pt ; +1,1 pt] | 4 / 26 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 18,3 % | 35,8 % | — | +12,1 pt | [+6,2 pt ; +20,8 pt] | 1 / 23 / 6 sur 30 | **B plus haut (moins bien)** |
| Gini moyen | 0,20 | 0,34 | 13 → 1 | +0,14 | [+0,13 ; +0,17] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,15 | 0,35 | — | +0,20 | [+0,12 ; +0,35] | — / — / 0 | **B plus haut** |
| Inflation moyenne / j | 0,040 % | 0,060 % | 0 → 0 | +0,014 pt | [+0,003 pt ; +0,041 pt] | — / — / 0 | **B plus haut** |
| |Inflation| max / j | 47,8 % | 35,5 % | — | −7,4 pt | [−17,5 pt ; +1,1 pt] | 19 / 11 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 132,5 % | — | −2,5 pt | [−13,1 pt ; +1,6 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 20 | 30 → 30 | +10 | [+6 ; +12,5] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 8 | 17,5 | — | +10 | [+7 ; +12] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 78,5 | 1383,5 | — | +1263,5 | [+1205,5 ; +1313,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes ouvertes (toutes) | 139,5 | 519 | — | +362,5 | [+275 ; +410,5] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,17 | — | −0,70 | [−0,72 ; −0,65] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Bonheur moyen | 0,97 | 0,82 | — | −0,15 | [−0,15 ; −0,14] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,3 | 511,7 | — | +456,3 | [+432,8 ; +549,8] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 1 / 27 sur 30 | non concluant |
| Trésor de l’État le plus bas | 52 260 $ | 98 210 $ | — | +36 407 $ | [+10 837 $ ; +54 914 $] | 24 / 6 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; +47] | 1 / 10 / 19 sur 30 | non concluant |
| Prêts refusés | 0 | 2,5 | — | 0 | [0 ; +32] | — / — / 15 | non concluant |
| Créances radiées | 0 $ | 24 472 $ | — | +21 760 $ | [+18 250 $ ; +25 621 $] | — / — / 0 | **B plus haut** |
| Filet : Anti-famine / 50 j | 0,18 | 112,75 | 10 → 30 | +112,39 | [+90,30 ; +148,21] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plancher de logement / 50 j | 2,11 | 28,46 | 17 → 30 | +16,13 | [+8,27 ; +28,93] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,09 | 1 → 12 | 0,00 | [0,00 ; +1,14] | 1 / 14 / 15 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « renflouement d’entreprise »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,2 % | 33,8 % | 2,9 % | 1,3 % | 0,31 | 0,096 % | 644 (25) | 0,27 | 11 % / 20 % / 69 % | 4 | 0 $ |
| 2 | 7,9 % | 25,8 % | 3,2 % | 0,4 % | 0,31 | 0,071 % | 491 (16) | 0,16 | 7 % / 24 % / 69 % | 6 | 0 $ |
| 3 | 8,5 % | 26,3 % | 5,2 % | 0,7 % | 0,34 | 0,022 % | 682 (22) | 0,14 | 6 % / 19 % / 74 % | 6 | 0 $ |
| 4 | 11,7 % | 34,6 % | 3,3 % | 1,2 % | 0,32 | 0,034 % | 663 (23) | 0,28 | 4 % / 14 % / 83 % | 4 | 0 $ |
| 5 | 7,9 % | 24,6 % | 6,4 % | 0,6 % | 0,36 | 0,040 % | 715 (18) | 0,16 | 3 % / 21 % / 75 % | 4 | 0 $ |
| 6 | 8,0 % | 22,5 % | 1,8 % | 1,8 % | 0,42 | 0,069 % | 306 (17) | 0,20 | 9 % / 23 % / 68 % | 1 | 0 $ |
| 7 | 7,6 % | 29,2 % | 4,7 % | 1,8 % | 0,43 | 0,052 % | 417 (16) | 0,14 | 11 % / 20 % / 69 % | 4 | 23 086 $ |
| 8 | 7,8 % | 24,6 % | 3,3 % | 0,6 % | 0,34 | 0,060 % | 508 (23) | 0,11 | 3 % / 28 % / 69 % | 8 | 0 $ |
| 9 | 7,2 % | 23,3 % | 4,1 % | 0,5 % | 0,30 | 0,072 % | 514 (16) | 0,17 | 11 % / 21 % / 68 % | 2 | 0 $ |
| 10 | 11,2 % | 30,0 % | 3,5 % | 0,8 % | 0,33 | 0,040 % | 612 (20) | 0,24 | 2 % / 19 % / 79 % | 2 | 0 $ |
| 11 | 9,3 % | 25,4 % | 4,2 % | 0,9 % | 0,34 | 0,060 % | 543 (20) | 0,15 | 7 % / 25 % / 68 % | 2 | 0 $ |
| 12 | 7,0 % | 23,3 % | 3,5 % | 2,3 % | 0,40 | 0,056 % | 392 (22) | 0,24 | 9 % / 28 % / 63 % | 0 | 0 $ |
| 13 | 10,7 % | 39,2 % | 3,3 % | 1,2 % | 0,36 | -0,015 % | 559 (20) | 0,21 | 4 % / 23 % / 73 % | 7 | 2 743 $ |
| 14 | 7,3 % | 24,2 % | 3,4 % | 1,6 % | 0,43 | 0,062 % | 350 (17) | 0,13 | 5 % / 18 % / 78 % | 1 | 7 886 $ |
| 15 | 9,5 % | 29,6 % | 3,0 % | 0,7 % | 0,33 | 0,051 % | 546 (22) | 0,18 | 7 % / 28 % / 65 % | 3 | 0 $ |
| 16 | 7,7 % | 27,5 % | 2,7 % | 2,2 % | 0,41 | 0,085 % | 341 (23) | 0,16 | 6 % / 25 % / 69 % | 4 | 0 $ |
| 17 | 7,2 % | 24,2 % | 2,1 % | 0,5 % | 0,29 | 0,068 % | 453 (15) | 0,18 | 11 % / 20 % / 69 % | 3 | 0 $ |
| 18 | 8,7 % | 38,8 % | 4,8 % | 2,2 % | 0,47 | 0,042 % | 449 (20) | 0,15 | 4 % / 25 % / 71 % | 5 | 0 $ |
| 19 | 9,1 % | 24,6 % | 5,9 % | 0,6 % | 0,34 | 0,041 % | 610 (11) | 0,20 | 9 % / 23 % / 68 % | 4 | 0 $ |
| 20 | 10,1 % | 28,7 % | 5,1 % | 1,1 % | 0,32 | 0,045 % | 537 (17) | 0,24 | 6 % / 27 % / 67 % | 2 | 0 $ |
| 21 | 9,5 % | 27,5 % | 4,8 % | 0,8 % | 0,33 | 0,061 % | 670 (25) | 0,21 | 9 % / 24 % / 67 % | 2 | 7 306 $ |
| 22 | 7,7 % | 24,6 % | 4,4 % | 1,7 % | 0,44 | 0,060 % | 427 (17) | 0,15 | 3 % / 21 % / 76 % | 2 | 0 $ |
| 23 | 8,8 % | 29,2 % | 7,4 % | 1,9 % | 0,41 | 0,060 % | 418 (23) | 0,33 | 5 % / 22 % / 72 % | 1 | 12 225 $ |
| 24 | 8,9 % | 30,4 % | 1,8 % | 1,1 % | 0,27 | 0,055 % | 610 (25) | 0,24 | 6 % / 21 % / 73 % | 4 | 0 $ |
| 25 | 7,5 % | 23,3 % | 5,5 % | 0,4 % | 0,33 | 0,062 % | 524 (20) | 0,15 | 9 % / 24 % / 67 % | 5 | 0 $ |
| 26 | 7,8 % | 25,4 % | 2,7 % | 1,7 % | 0,42 | 0,082 % | 405 (17) | 0,25 | 12 % / 22 % / 67 % | 1 | 0 $ |
| 27 | 8,0 % | 24,6 % | 3,1 % | 1,1 % | 0,35 | 0,073 % | 576 (27) | 0,16 | 3 % / 17 % / 80 % | 2 | 0 $ |
| 28 | 6,0 % | 21,7 % | 0,7 % | 1,5 % | 0,37 | 0,078 % | 219 (9) | 0,15 | 5 % / 30 % / 65 % | 3 | 21 206 $ |
| 29 | 7,0 % | 22,5 % | 5,9 % | 1,3 % | 0,43 | 0,084 % | 495 (21) | 0,14 | 10 % / 25 % / 65 % | 4 | 0 $ |
| 30 | 8,6 % | 25,4 % | 5,9 % | 1,2 % | 0,34 | 0,059 % | 615 (27) | 0,18 | 10 % / 24 % / 66 % | 7 | 0 $ |

</details>

## 2 bis (3). Avec filets, sauf « Plancher de logement »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,0 % | 3,3 pt (6,2 % – 9,5 %) | 4,7 % – 14,1 % | 7/30 |
| Chômage max | toute la partie | — | 18,8 % | 7,9 pt (16,3 % – 24,2 %) | 14,2 % – 41,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,2 pt (0,0 % – 0,2 %) | 0,0 % – 1,5 % | 0/30 |
| Faim max | toute la partie | — | 16,7 % | 52,9 pt (0,0 % – 52,9 %) | 0,0 % – 90,8 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,3 % | 0,7 pt (0,0 % – 0,8 %) | 0,0 % – 3,1 % | 4/30 |
| Sans-abri max | toute la partie | — | 17,1 % | 33,8 pt (6,8 % – 40,5 %) | 3,8 % – 80,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,21 | 0,03 (0,19 – 0,22) | 0,15 – 0,37 | 12/30 |
| Gini en fin de partie | dernier jour | — | 0,19 | 0,10 (0,15 – 0,24) | 0,12 – 0,45 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,041 % | 0,033 pt (0,023 % – 0,056 %) | -0,048 % – 0,080 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 40,8 % | 17,5 pt (32,2 % – 49,7 %) | 10,7 % – 76,8 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 139,7 % | 10,0 pt (133,8 % – 143,8 %) | 114,6 % – 166,9 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 11,5 | 3,8 (9,3 – 13) | 6 – 35 | 30/30 |
| … dont après la chauffe | après chauffe | — | 10 | 5 (7 – 12) | 4 – 33 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 102 | 87,3 (49,8 – 137) | 26 – 1487 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 138,5 | 28,3 (131,3 – 159,5) | 118 – 421 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,0003 (0,88 – 0,88) | 0,28 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,01 (0,97 – 0,97) | 0,84 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,3 | 0,03 (0,3 – 0,4) | 0,3 – 334,1 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 172 | — |
| Trésor de l’État le plus bas | après chauffe | — | 56 168 $ | 65 812 $ (18 174 $ – 83 986 $) | 3 574 $ – 96 592 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 113 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 85 | — |
| Créances radiées | toute la partie | — | 0 $ | 1 734 $ (0 $ – 1 734 $) | 0 $ – 50 872 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 1,03 (0,00 – 1,03) | 0,00 – 33,46 | 9/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 16,59 | 9,68 (10,69 – 20,37) | 7,96 – 35,39 | 30/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 3,04 | 1/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 1,03 | 0,00 – 33,46 | 9/30 | 2014 | pas de producteur (100 %) |
| Renflouement d’entreprise | 16,59 | 10,69 – 20,37 | 7,96 – 35,39 | 30/30 | 15140 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | coupé | — | — | — | — | — |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 3,04 | 1/30 | 85 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 3701 · 30, Tourisme 2330 · 23, Bijouterie 1797 · 29, Fonderie 875 · 30, Mine de fer 774 · 30, Pêcherie 711 · 30, Garage 708 · 13, Puits de pétrole 486 · 14.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plancher de logement »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 7,0 % | 5 → 7 | 0,0 pt | [−0,2 pt ; +0,4 pt] | 11 / 14 / 5 sur 30 | non concluant |
| Chômage max | 19,0 % | 18,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 9 / 9 / 12 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,0 % | 0 → 0 | 0,0 pt | [−0,02 pt ; 0,0 pt] | 13 / 7 / 10 sur 30 | non concluant |
| Faim max | 45,0 % | 16,7 % | — | 0,0 pt | [−13,8 pt ; 0,0 pt] | 13 / 7 / 10 sur 30 | non concluant |
| Sans-abri moyen | 0,2 % | 0,3 % | 0 → 4 | +0,02 pt | [0,0 pt ; +0,1 pt] | 8 / 17 / 5 sur 30 | non concluant |
| Sans-abri max | 18,3 % | 17,1 % | — | +0,8 pt | [0,0 pt ; +2,5 pt] | 5 / 16 / 9 sur 30 | non concluant |
| Gini moyen | 0,20 | 0,21 | 13 → 12 | 0,00 | [−0,005 ; +0,004] | — / — / 5 | non concluant |
| Gini en fin de partie | 0,15 | 0,19 | — | 0,00 | [−0,005 ; +0,03] | — / — / 5 | non concluant |
| Inflation moyenne / j | 0,040 % | 0,041 % | 0 → 0 | 0,000 pt | [−0,003 pt ; +0,006 pt] | — / — / 5 | non concluant |
| |Inflation| max / j | 47,8 % | 40,8 % | — | 0,0 pt | [−2,2 pt ; 0,0 pt] | 14 / 6 / 10 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 139,7 % | — | 0,0 pt | [−0,1 pt ; 0,0 pt] | 10 / 4 / 16 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 11,5 | 30 → 30 | 0 | [0 ; +1] | 9 / 12 / 9 sur 30 | non concluant |
| … dont après la chauffe | 8 | 10 | — | 0 | [0 ; +1] | 7 / 12 / 11 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 78,5 | 102 | — | 0 | [0 ; +10] | 9 / 14 / 7 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 139,5 | 138,5 | — | −2 | [−7,5 ; 0] | 16 / 9 / 5 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,000001 | [0,00 ; +0,00003] | 15 / 9 / 6 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [−0,0002 ; +0,0002] | 14 / 11 / 5 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,3 | 0,3 | — | 0,0 | [−0,004 ; +0,0004] | 12 / 12 / 6 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 1 / 3 / 26 sur 30 | non concluant |
| Trésor de l’État le plus bas | 52 260 $ | 56 168 $ | — | 0 $ | [−186 $ ; +4 $] | 11 / 12 / 7 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 1 / 28 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 28 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 18 | non concluant |
| Filet : Anti-famine / 50 j | 0,18 | 0,00 | 10 → 9 | 0,00 | [−0,13 ; 0,00] | 12 / 6 / 12 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,05 | 16,59 | 30 → 30 | 0,00 | [−0,11 ; +0,80] | 11 / 13 / 6 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 1 / 1 / 28 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plancher de logement »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,5 % | 26,7 % | 0,1 % | 0,2 % | 0,37 | 0,032 % | 152 (13) | 0,88 | 6 % / 14 % / 80 % | 1 | 0 $ |
| 2 | 7,9 % | 24,2 % | 0,1 % | 0,0 % | 0,20 | 0,001 % | 125 (7) | 0,88 | 4 % / 19 % / 78 % | 0 | 6 001 $ |
| 3 | 6,7 % | 16,7 % | 0,0 % | 0,3 % | 0,21 | 0,029 % | 124 (6) | 0,88 | 3 % / 18 % / 79 % | 0 | 0 $ |
| 4 | 12,1 % | 24,2 % | 0,0 % | 0,0 % | 0,26 | -0,048 % | 162 (8) | 0,88 | 7 % / 21 % / 71 % | 1 | 0 $ |
| 5 | 14,1 % | 41,3 % | 1,5 % | 3,1 % | 0,33 | -0,009 % | 421 (35) | 0,47 | 7 % / 12 % / 82 % | 0 | 43 003 $ |
| 6 | 4,8 % | 16,3 % | 0,0 % | 0,0 % | 0,15 | 0,026 % | 131 (12) | 0,88 | 7 % / 13 % / 80 % | 0 | 12 657 $ |
| 7 | 5,4 % | 17,1 % | 0,0 % | 0,4 % | 0,19 | 0,040 % | 135 (8) | 0,88 | 6 % / 12 % / 82 % | 0 | 7 380 $ |
| 8 | 9,8 % | 23,8 % | 0,0 % | 1,4 % | 0,21 | 0,006 % | 146 (11) | 0,88 | 6 % / 12 % / 81 % | 1 | 0 $ |
| 9 | 6,9 % | 23,8 % | 0,2 % | 1,0 % | 0,22 | 0,080 % | 130 (19) | 0,88 | 7 % / 17 % / 76 % | 0 | 24 695 $ |
| 10 | 13,5 % | 37,5 % | 1,0 % | 2,1 % | 0,25 | -0,012 % | 333 (28) | 0,65 | 9 % / 13 % / 77 % | 0 | 4 129 $ |
| 11 | 6,0 % | 16,3 % | 0,0 % | 0,4 % | 0,19 | 0,039 % | 138 (17) | 0,88 | 3 % / 20 % / 77 % | 0 | 10 590 $ |
| 12 | 6,8 % | 14,6 % | 0,0 % | 0,3 % | 0,22 | 0,058 % | 139 (10) | 0,88 | 6 % / 13 % / 81 % | 0 | 1 836 $ |
| 13 | 12,0 % | 34,2 % | 0,3 % | 3,0 % | 0,25 | 0,023 % | 152 (17) | 0,87 | 4 % / 22 % / 74 % | 2 | 88 $ |
| 14 | 8,0 % | 17,9 % | 0,1 % | 0,1 % | 0,22 | 0,064 % | 144 (13) | 0,88 | 6 % / 13 % / 81 % | 0 | 4 239 $ |
| 15 | 7,7 % | 17,9 % | 0,0 % | 0,5 % | 0,19 | 0,046 % | 194 (17) | 0,88 | 6 % / 13 % / 81 % | 2 | 8 901 $ |
| 16 | 6,2 % | 16,3 % | 0,0 % | 0,0 % | 0,19 | 0,042 % | 137 (12) | 0,88 | 6 % / 14 % / 81 % | 0 | 0 $ |
| 17 | 5,2 % | 16,3 % | 0,0 % | 0,0 % | 0,17 | 0,065 % | 165 (11) | 0,88 | 4 % / 14 % / 82 % | 0 | 0 $ |
| 18 | 6,8 % | 15,0 % | 0,0 % | 0,2 % | 0,21 | 0,063 % | 148 (7) | 0,88 | 7 % / 11 % / 82 % | 1 | 0 $ |
| 19 | 6,2 % | 20,4 % | 0,0 % | 0,3 % | 0,17 | 0,042 % | 134 (13) | 0,88 | 7 % / 13 % / 81 % | 0 | 24 567 $ |
| 20 | 4,7 % | 16,3 % | 0,0 % | 0,1 % | 0,17 | 0,055 % | 118 (6) | 0,88 | 7 % / 12 % / 81 % | 1 | 4 694 $ |
| 21 | 6,7 % | 16,7 % | 0,1 % | 0,0 % | 0,19 | 0,052 % | 147 (11) | 0,88 | 6 % / 13 % / 81 % | 0 | 12 542 $ |
| 22 | 7,3 % | 15,8 % | 0,4 % | 0,3 % | 0,21 | 0,038 % | 236 (10) | 0,88 | 3 % / 14 % / 82 % | 8 | 3 959 $ |
| 23 | 7,3 % | 22,5 % | 0,0 % | 0,6 % | 0,22 | 0,062 % | 137 (12) | 0,88 | 8 % / 17 % / 76 % | 0 | 0 $ |
| 24 | 5,5 % | 15,0 % | 0,2 % | 0,1 % | 0,18 | 0,010 % | 128 (10) | 0,88 | 5 % / 16 % / 79 % | 0 | 14 922 $ |
| 25 | 6,6 % | 14,2 % | 0,0 % | 0,2 % | 0,21 | 0,047 % | 125 (8) | 0,88 | 3 % / 18 % / 79 % | 1 | 2 511 $ |
| 26 | 5,0 % | 20,4 % | 0,0 % | 0,0 % | 0,17 | 0,073 % | 135 (9) | 0,88 | 6 % / 13 % / 81 % | 0 | 0 $ |
| 27 | 8,5 % | 26,3 % | 0,1 % | 0,0 % | 0,20 | 0,057 % | 132 (13) | 0,88 | 6 % / 12 % / 81 % | 1 | 7 587 $ |
| 28 | 7,1 % | 19,6 % | 0,0 % | 0,8 % | 0,20 | 0,046 % | 129 (11) | 0,88 | 6 % / 13 % / 81 % | 0 | 0 $ |
| 29 | 13,8 % | 41,7 % | 1,0 % | 2,4 % | 0,26 | 0,024 % | 306 (12) | 0,28 | 5 % / 30 % / 65 % | 2 | 2 126 $ |
| 30 | 10,6 % | 28,7 % | 0,2 % | 0,9 % | 0,23 | 0,015 % | 298 (18) | 0,78 | 8 % / 12 % / 81 % | 1 | 0 $ |

</details>

## 2 bis (4). Avec filets, sauf « Plafond de dérive des prix et salaires »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,0 % | 2,0 pt (6,0 % – 8,0 %) | 4,8 % – 12,9 % | 5/30 |
| Chômage max | toute la partie | — | 19,0 % | 9,5 pt (16,3 % – 25,7 %) | 14,6 % – 41,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 1,5 % | 0/30 |
| Faim max | toute la partie | — | 45,0 % | 52,0 pt (6,7 % – 58,6 %) | 0,0 % – 83,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,2 % | 0,5 pt (0,0 % – 0,5 %) | 0,0 % – 1,6 % | 0/30 |
| Sans-abri max | toute la partie | — | 18,3 % | 27,0 pt (6,1 % – 33,1 %) | 3,8 % – 64,6 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,20 | 0,02 (0,19 – 0,21) | 0,15 – 0,36 | 13/30 |
| Gini en fin de partie | dernier jour | — | 0,15 | 0,09 (0,14 – 0,23) | 0,12 – 0,46 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,040 % | 0,032 pt (0,024 % – 0,057 %) | -0,033 % – 0,102 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 47,8 % | 23,9 pt (34,0 % – 57,9 %) | 10,7 % – 90,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,0 % | 14,8 pt (134,4 % – 149,2 %) | 114,7 % – 228,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10 | 4 (9 – 13) | 4 – 23 | 30/30 |
| … dont après la chauffe | après chauffe | — | 8 | 4,8 (6,3 – 11) | 3 – 20 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 78,5 | 76,3 (44,8 – 121) | 29 – 1397 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 139,5 | 26 (131,3 – 157,3) | 112 – 531 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,0003 (0,88 – 0,88) | 0,20 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,004 (0,97 – 0,97) | 0,83 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,3 | 0,03 (0,3 – 0,4) | 0,3 – 313,7 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 126 | — |
| Trésor de l’État le plus bas | après chauffe | — | 52 260 $ | 66 278 $ (15 715 $ – 81 993 $) | 3 882 $ – 109 550 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 66 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 323 | — |
| Créances radiées | toute la partie | — | 0 $ | 37 $ (0 $ – 37 $) | 0 $ – 53 800 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,18 | 1,35 (0,00 – 1,35) | 0,00 – 37,29 | 10/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 13,05 | 6,75 (11,22 – 17,97) | 7,96 – 28,61 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 2,11 | 22,79 (0,04 – 22,83) | 0,00 – 60,07 | 17/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 11,54 | 1/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,18 | 0,00 – 1,35 | 0,00 – 37,29 | 10/30 | 1764 | pas de producteur (100 %) |
| Renflouement d’entreprise | 13,05 | 11,22 – 17,97 | 7,96 – 28,61 | 30/30 | 13540 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 2,11 | 0,04 – 22,83 | 0,00 – 60,07 | 17/30 | 11920 | prix trop élevé (81 %) ; parc plein (19 %) |
| Plafond de dérive des prix et salaires | coupé | — | — | — | — | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 11,54 | 1/30 | 323 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 3359 · 30, Bijouterie 1865 · 29, Tourisme 1470 · 24, Fonderie 944 · 30, Mine de fer 899 · 30, Pêcherie 828 · 30, Garage 619 · 14, Machinerie 301 · 12.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plafond de dérive des prix et salaires »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 7,0 % | 5 → 5 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 19,0 % | 19,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 45,0 % | 45,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,2 % | 0,2 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 18,3 % | 18,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,20 | 0,20 | 13 → 13 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,15 | 0,15 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,040 % | 0,040 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 47,8 % | 47,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 141,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 10 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 8 | 8 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 78,5 | 78,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 139,5 | 139,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,3 | 0,3 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 52 260 $ | 52 260 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,18 | 0,18 | 10 → 10 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,05 | 13,05 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 2,11 | 2,11 | 17 → 17 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plafond de dérive des prix et salaires »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,4 % | 26,7 % | 0,1 % | 0,2 % | 0,36 | 0,032 % | 154 (13) | 0,88 | 7 % / 12 % / 81 % | 2 | 0 $ |
| 2 | 7,9 % | 24,2 % | 0,1 % | 0,0 % | 0,20 | 0,001 % | 125 (7) | 0,88 | 4 % / 19 % / 78 % | 0 | 6 001 $ |
| 3 | 7,4 % | 17,1 % | 0,1 % | 0,2 % | 0,21 | 0,024 % | 131 (7) | 0,88 | 7 % / 15 % / 78 % | 1 | 3 202 $ |
| 4 | 10,1 % | 27,9 % | 0,4 % | 1,6 % | 0,23 | 0,047 % | 252 (19) | 0,72 | 8 % / 10 % / 82 % | 1 | 10 207 $ |
| 5 | 7,7 % | 22,1 % | 0,0 % | 0,0 % | 0,17 | 0,102 % | 118 (7) | 0,88 | 6 % / 13 % / 81 % | 1 | 11 142 $ |
| 6 | 4,8 % | 16,3 % | 0,0 % | 0,0 % | 0,15 | 0,026 % | 131 (12) | 0,88 | 7 % / 13 % / 80 % | 0 | 12 657 $ |
| 7 | 6,0 % | 17,1 % | 0,0 % | 0,3 % | 0,19 | 0,003 % | 158 (10) | 0,88 | 6 % / 16 % / 78 % | 1 | 15 938 $ |
| 8 | 6,8 % | 18,3 % | 0,2 % | 0,0 % | 0,19 | 0,056 % | 128 (10) | 0,88 | 7 % / 12 % / 81 % | 1 | 1 882 $ |
| 9 | 7,0 % | 23,3 % | 0,1 % | 0,7 % | 0,21 | 0,024 % | 155 (19) | 0,88 | 7 % / 13 % / 80 % | 0 | 18 172 $ |
| 10 | 7,9 % | 27,1 % | 0,1 % | 0,0 % | 0,19 | 0,035 % | 122 (8) | 0,88 | 6 % / 12 % / 82 % | 0 | 19 257 $ |
| 11 | 6,4 % | 17,9 % | 0,1 % | 0,0 % | 0,20 | 0,055 % | 140 (7) | 0,88 | 6 % / 13 % / 81 % | 1 | 14 474 $ |
| 12 | 8,0 % | 15,8 % | 0,1 % | 0,3 % | 0,25 | -0,030 % | 121 (9) | 0,88 | 8 % / 18 % / 74 % | 0 | 0 $ |
| 13 | 6,4 % | 23,8 % | 0,0 % | 0,7 % | 0,19 | 0,053 % | 149 (13) | 0,88 | 7 % / 12 % / 81 % | 1 | 21 061 $ |
| 14 | 6,3 % | 17,9 % | 0,1 % | 0,1 % | 0,20 | 0,066 % | 132 (12) | 0,88 | 7 % / 14 % / 79 % | 1 | 26 864 $ |
| 15 | 10,9 % | 27,9 % | 0,0 % | 1,0 % | 0,22 | -0,014 % | 199 (23) | 0,88 | 3 % / 22 % / 75 % | 0 | 0 $ |
| 16 | 5,9 % | 15,4 % | 0,0 % | 0,0 % | 0,19 | 0,040 % | 145 (10) | 0,88 | 5 % / 16 % / 79 % | 1 | 34 615 $ |
| 17 | 5,2 % | 16,3 % | 0,0 % | 0,0 % | 0,17 | 0,065 % | 165 (11) | 0,88 | 4 % / 14 % / 82 % | 0 | 0 $ |
| 18 | 5,8 % | 14,6 % | 0,0 % | 0,2 % | 0,20 | 0,063 % | 164 (9) | 0,88 | 6 % / 13 % / 81 % | 0 | 10 510 $ |
| 19 | 9,0 % | 29,6 % | 0,0 % | 0,5 % | 0,21 | 0,029 % | 138 (14) | 0,88 | 5 % / 17 % / 78 % | 0 | 2 212 $ |
| 20 | 5,9 % | 16,3 % | 0,0 % | 0,1 % | 0,19 | 0,045 % | 112 (4) | 0,88 | 6 % / 12 % / 82 % | 0 | 7 949 $ |
| 21 | 8,0 % | 18,3 % | 0,2 % | 0,0 % | 0,20 | 0,038 % | 142 (11) | 0,88 | 3 % / 19 % / 79 % | 0 | 19 524 $ |
| 22 | 6,8 % | 15,4 % | 0,0 % | 0,5 % | 0,26 | 0,079 % | 171 (9) | 0,88 | 4 % / 17 % / 79 % | 0 | 20 751 $ |
| 23 | 7,0 % | 22,5 % | 0,0 % | 0,4 % | 0,21 | 0,081 % | 139 (10) | 0,88 | 7 % / 14 % / 78 % | 1 | 257 $ |
| 24 | 5,2 % | 15,0 % | 0,2 % | 0,1 % | 0,18 | 0,025 % | 136 (10) | 0,88 | 7 % / 12 % / 81 % | 2 | 29 867 $ |
| 25 | 6,2 % | 14,6 % | 0,2 % | 0,1 % | 0,20 | 0,042 % | 137 (9) | 0,88 | 7 % / 13 % / 81 % | 0 | 8 497 $ |
| 26 | 5,0 % | 20,4 % | 0,0 % | 0,0 % | 0,17 | 0,073 % | 135 (9) | 0,88 | 6 % / 13 % / 81 % | 0 | 0 $ |
| 27 | 8,5 % | 26,3 % | 0,1 % | 0,0 % | 0,20 | 0,057 % | 132 (13) | 0,88 | 6 % / 12 % / 81 % | 1 | 7 587 $ |
| 28 | 7,8 % | 19,6 % | 0,0 % | 0,6 % | 0,20 | 0,039 % | 148 (10) | 0,88 | 6 % / 13 % / 81 % | 0 | 0 $ |
| 29 | 12,9 % | 36,3 % | 0,2 % | 1,5 % | 0,28 | -0,033 % | 531 (21) | 0,52 | 6 % / 16 % / 78 % | 4 | 43 426 $ |
| 30 | 11,2 % | 41,7 % | 1,5 % | 1,0 % | 0,27 | 0,001 % | 372 (21) | 0,20 | 7 % / 25 % / 68 % | 1 | 0 $ |

</details>

## 2 bis (5). Avec filets, sauf « Anti-crédit-fou »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,0 % | 2,0 pt (6,0 % – 8,0 %) | 4,8 % – 13,3 % | 5/30 |
| Chômage max | toute la partie | — | 19,0 % | 9,5 pt (16,3 % – 25,7 %) | 14,6 % – 41,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 1,5 % | 0/30 |
| Faim max | toute la partie | — | 45,0 % | 52,0 pt (6,7 % – 58,6 %) | 0,0 % – 83,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,2 % | 0,5 pt (0,0 % – 0,5 %) | 0,0 % – 1,6 % | 0/30 |
| Sans-abri max | toute la partie | — | 18,3 % | 27,0 pt (6,1 % – 33,1 %) | 3,8 % – 64,6 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,20 | 0,02 (0,19 – 0,21) | 0,15 – 0,36 | 13/30 |
| Gini en fin de partie | dernier jour | — | 0,15 | 0,09 (0,14 – 0,23) | 0,12 – 0,46 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,040 % | 0,032 pt (0,024 % – 0,057 %) | -0,030 % – 0,102 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 47,8 % | 23,9 pt (34,0 % – 57,9 %) | 10,7 % – 90,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,0 % | 14,8 pt (134,4 % – 149,2 %) | 114,7 % – 228,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10 | 4 (9 – 13) | 4 – 23 | 30/30 |
| … dont après la chauffe | après chauffe | — | 8 | 4,8 (6,3 – 11) | 3 – 20 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 78,5 | 76,3 (44,8 – 121) | 29 – 1397 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 139,5 | 26 (131,3 – 157,3) | 112 – 553 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,0003 (0,88 – 0,88) | 0,20 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,004 (0,97 – 0,97) | 0,83 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,3 | 0,03 (0,3 – 0,4) | 0,3 – 313,7 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 126 | — |
| Trésor de l’État le plus bas | après chauffe | — | 52 260 $ | 66 278 $ (15 715 $ – 81 993 $) | 3 882 $ – 109 550 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 61 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 37 $ (0 $ – 37 $) | 0 $ – 59 718 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,18 | 1,35 (0,00 – 1,35) | 0,00 – 37,29 | 10/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 13,05 | 6,75 (11,22 – 17,97) | 7,96 – 28,61 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 2,11 | 22,79 (0,04 – 22,83) | 0,00 – 59,89 | 17/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,18 | 0,00 – 1,35 | 0,00 – 37,29 | 10/30 | 1764 | pas de producteur (100 %) |
| Renflouement d’entreprise | 13,05 | 11,22 – 17,97 | 7,96 – 28,61 | 30/30 | 13567 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 2,11 | 0,04 – 22,83 | 0,00 – 59,89 | 17/30 | 11915 | prix trop élevé (81 %) ; parc plein (19 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | coupé | — | — | — | — | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 3359 · 30, Bijouterie 1865 · 29, Tourisme 1473 · 24, Fonderie 946 · 30, Mine de fer 906 · 30, Pêcherie 831 · 30, Garage 618 · 14, Machinerie 301 · 12.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-crédit-fou »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 7,0 % | 5 → 5 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Chômage max | 19,0 % | 19,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 45,0 % | 45,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,2 % | 0,2 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 0 / 29 sur 30 | non concluant |
| Sans-abri max | 18,3 % | 18,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,20 | 0,20 | 13 → 13 | 0,00 | [0,00 ; 0,00] | — / — / 29 | non concluant |
| Gini en fin de partie | 0,15 | 0,15 | — | 0,00 | [0,00 ; 0,00] | — / — / 29 | non concluant |
| Inflation moyenne / j | 0,040 % | 0,040 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 29 | non concluant |
| |Inflation| max / j | 47,8 % | 47,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 141,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 10 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 8 | 8 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 78,5 | 78,5 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 139,5 | 139,5 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 0 / 1 / 29 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,3 | 0,3 | — | 0,0 | [0,0 ; 0,0] | 0 / 1 / 29 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 52 260 $ | 52 260 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 29 | non concluant |
| Filet : Anti-famine / 50 j | 0,18 | 0,18 | 10 → 10 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,05 | 13,05 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 1 / 29 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 2,11 | 2,11 | 17 → 17 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-crédit-fou »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,4 % | 26,7 % | 0,1 % | 0,2 % | 0,36 | 0,032 % | 154 (13) | 0,88 | 7 % / 12 % / 81 % | 2 | 0 $ |
| 2 | 7,9 % | 24,2 % | 0,1 % | 0,0 % | 0,20 | 0,001 % | 125 (7) | 0,88 | 4 % / 19 % / 78 % | 0 | 6 001 $ |
| 3 | 7,4 % | 17,1 % | 0,1 % | 0,2 % | 0,21 | 0,024 % | 131 (7) | 0,88 | 7 % / 15 % / 78 % | 1 | 3 202 $ |
| 4 | 10,1 % | 27,9 % | 0,4 % | 1,6 % | 0,23 | 0,047 % | 252 (19) | 0,72 | 8 % / 10 % / 82 % | 1 | 10 207 $ |
| 5 | 7,7 % | 22,1 % | 0,0 % | 0,0 % | 0,17 | 0,102 % | 118 (7) | 0,88 | 6 % / 13 % / 81 % | 1 | 11 142 $ |
| 6 | 4,8 % | 16,3 % | 0,0 % | 0,0 % | 0,15 | 0,026 % | 131 (12) | 0,88 | 7 % / 13 % / 80 % | 0 | 12 657 $ |
| 7 | 6,0 % | 17,1 % | 0,0 % | 0,3 % | 0,19 | 0,003 % | 158 (10) | 0,88 | 6 % / 16 % / 78 % | 1 | 15 938 $ |
| 8 | 6,8 % | 18,3 % | 0,2 % | 0,0 % | 0,19 | 0,056 % | 128 (10) | 0,88 | 7 % / 12 % / 81 % | 1 | 1 882 $ |
| 9 | 7,0 % | 23,3 % | 0,1 % | 0,7 % | 0,21 | 0,024 % | 155 (19) | 0,88 | 7 % / 13 % / 80 % | 0 | 18 172 $ |
| 10 | 7,9 % | 27,1 % | 0,1 % | 0,0 % | 0,19 | 0,035 % | 122 (8) | 0,88 | 6 % / 12 % / 82 % | 0 | 19 257 $ |
| 11 | 6,4 % | 17,9 % | 0,1 % | 0,0 % | 0,20 | 0,055 % | 140 (7) | 0,88 | 6 % / 13 % / 81 % | 1 | 14 474 $ |
| 12 | 8,0 % | 15,8 % | 0,1 % | 0,3 % | 0,25 | -0,030 % | 121 (9) | 0,88 | 8 % / 18 % / 74 % | 0 | 0 $ |
| 13 | 6,4 % | 23,8 % | 0,0 % | 0,7 % | 0,19 | 0,053 % | 149 (13) | 0,88 | 7 % / 12 % / 81 % | 1 | 21 061 $ |
| 14 | 6,3 % | 17,9 % | 0,1 % | 0,1 % | 0,20 | 0,066 % | 132 (12) | 0,88 | 7 % / 14 % / 79 % | 1 | 26 864 $ |
| 15 | 10,9 % | 27,9 % | 0,0 % | 1,0 % | 0,22 | -0,014 % | 199 (23) | 0,88 | 3 % / 22 % / 75 % | 0 | 0 $ |
| 16 | 5,9 % | 15,4 % | 0,0 % | 0,0 % | 0,19 | 0,040 % | 145 (10) | 0,88 | 5 % / 16 % / 79 % | 1 | 34 615 $ |
| 17 | 5,2 % | 16,3 % | 0,0 % | 0,0 % | 0,17 | 0,065 % | 165 (11) | 0,88 | 4 % / 14 % / 82 % | 0 | 0 $ |
| 18 | 5,8 % | 14,6 % | 0,0 % | 0,2 % | 0,20 | 0,063 % | 164 (9) | 0,88 | 6 % / 13 % / 81 % | 0 | 10 510 $ |
| 19 | 9,0 % | 29,6 % | 0,0 % | 0,5 % | 0,21 | 0,029 % | 138 (14) | 0,88 | 5 % / 17 % / 78 % | 0 | 2 212 $ |
| 20 | 5,9 % | 16,3 % | 0,0 % | 0,1 % | 0,19 | 0,045 % | 112 (4) | 0,88 | 6 % / 12 % / 82 % | 0 | 7 949 $ |
| 21 | 8,0 % | 18,3 % | 0,2 % | 0,0 % | 0,20 | 0,038 % | 142 (11) | 0,88 | 3 % / 19 % / 79 % | 0 | 19 524 $ |
| 22 | 6,8 % | 15,4 % | 0,0 % | 0,5 % | 0,26 | 0,079 % | 171 (9) | 0,88 | 4 % / 17 % / 79 % | 0 | 20 751 $ |
| 23 | 7,0 % | 22,5 % | 0,0 % | 0,4 % | 0,21 | 0,081 % | 139 (10) | 0,88 | 7 % / 14 % / 78 % | 1 | 257 $ |
| 24 | 5,2 % | 15,0 % | 0,2 % | 0,1 % | 0,18 | 0,025 % | 136 (10) | 0,88 | 7 % / 12 % / 81 % | 2 | 29 867 $ |
| 25 | 6,2 % | 14,6 % | 0,2 % | 0,1 % | 0,20 | 0,042 % | 137 (9) | 0,88 | 7 % / 13 % / 81 % | 0 | 8 497 $ |
| 26 | 5,0 % | 20,4 % | 0,0 % | 0,0 % | 0,17 | 0,073 % | 135 (9) | 0,88 | 6 % / 13 % / 81 % | 0 | 0 $ |
| 27 | 8,5 % | 26,3 % | 0,1 % | 0,0 % | 0,20 | 0,057 % | 132 (13) | 0,88 | 6 % / 12 % / 81 % | 1 | 7 587 $ |
| 28 | 7,8 % | 19,6 % | 0,0 % | 0,6 % | 0,20 | 0,039 % | 148 (10) | 0,88 | 6 % / 13 % / 81 % | 0 | 0 $ |
| 29 | 13,3 % | 36,3 % | 0,2 % | 1,5 % | 0,28 | -0,030 % | 553 (21) | 0,52 | 5 % / 15 % / 79 % | 4 | 70 625 $ |
| 30 | 11,2 % | 41,7 % | 1,5 % | 1,0 % | 0,27 | 0,001 % | 372 (21) | 0,20 | 7 % / 25 % / 68 % | 1 | 0 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 30/30 : g1 35, g2 18, g3 26, g4 28, g5 29, g6 30, g7 30, g8 26, … |
| Chômage moyen ≤ 10 % | ❌ | 3/30 : g1 10,1 %, g24 19,8 %, g25 72,9 % |
| Faim et sans-abri < 2 % | ❌ | 29/30 : g1, g2, g3, g4, g5, g6, g7, g9, g10, g11, … |
| Gini 0,2–0,45 | ✅ | aucune graine sur 30 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 30 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 30 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 10/30 graines ; Renflouement d’entreprise : 30/30 graines ; Plancher de logement : 17/30 graines ; Anti-crédit-fou : 1/30 graines |

### Critère de l’institution : avec filets, sauf « anti-famine »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-famine » : chômage moyen ≤ 10 % | ❌ | 4/30 : g1 11,4 %, g15 10,9 %, g29 13,7 %, g30 10,6 % |
| Sans « Anti-famine » : faim et sans-abri < 2 % | ❌ | 1/30 : g4 |
| Sans « Anti-famine » : aucune alerte critique | ❌ | 30/30 : g1 13, g2 8, g3 7, g4 14, g5 7, g6 12, g7 10, g8 10, … |

### Critère de l’institution : avec filets, sauf « renflouement d’entreprise »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Renflouement d’entreprise » : chômage moyen ≤ 10 % | ❌ | 5/30 : g1 11,2 %, g4 11,7 %, g10 11,2 %, g13 10,7 %, g20 10,1 % |
| Sans « Renflouement d’entreprise » : faim et sans-abri < 2 % | ❌ | 27/30 : g1, g2, g3, g4, g5, g7, g8, g9, g10, g11, … |
| Sans « Renflouement d’entreprise » : aucune alerte critique | ❌ | 30/30 : g1 25, g2 16, g3 22, g4 23, g5 18, g6 17, g7 16, g8 23, … |

### Critère de l’institution : avec filets, sauf « plancher de logement »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plancher de logement » : chômage moyen ≤ 10 % | ❌ | 7/30 : g1 11,5 %, g4 12,1 %, g5 14,1 %, g10 13,5 %, g13 12,0 %, g29 13,8 %, g30 10,6 % |
| Sans « Plancher de logement » : faim et sans-abri < 2 % | ❌ | 4/30 : g5, g10, g13, g29 |
| Sans « Plancher de logement » : aucune alerte critique | ❌ | 30/30 : g1 13, g2 7, g3 6, g4 8, g5 35, g6 12, g7 8, g8 11, … |

### Critère de l’institution : avec filets, sauf « plafond de dérive des prix et salaires »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plafond de dérive des prix et salaires » : chômage moyen ≤ 10 % | ❌ | 5/30 : g1 11,4 %, g4 10,1 %, g15 10,9 %, g29 12,9 %, g30 11,2 % |
| Sans « Plafond de dérive des prix et salaires » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Plafond de dérive des prix et salaires » : aucune alerte critique | ❌ | 30/30 : g1 13, g2 7, g3 7, g4 19, g5 7, g6 12, g7 10, g8 10, … |

### Critère de l’institution : avec filets, sauf « anti-crédit-fou »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-crédit-fou » : chômage moyen ≤ 10 % | ❌ | 5/30 : g1 11,4 %, g4 10,1 %, g15 10,9 %, g29 13,3 %, g30 11,2 % |
| Sans « Anti-crédit-fou » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Anti-crédit-fou » : aucune alerte critique | ❌ | 30/30 : g1 13, g2 7, g3 7, g4 19, g5 7, g6 12, g7 10, g8 10, … |

