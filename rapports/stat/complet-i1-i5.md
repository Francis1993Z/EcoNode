# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 13:25
- Graines : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : aucun
- Temps total : 7 min 20 s pour 510 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,0 % | 2,1 pt (7,2 % – 9,3 %) | 5,7 % – 64,3 % | 4/30 |
| Chômage max | toute la partie | — | 27,1 % | 5,9 pt (24,3 % – 30,2 %) | 20,8 % – 100,0 % | — |
| Faim moyenne | après chauffe | < 2 % | 6,1 % | 3,5 pt (4,5 % – 8,0 %) | 1,3 % – 67,4 % | 29/30 |
| Faim max | toute la partie | — | 95,4 % | 1,8 pt (94,1 % – 95,8 %) | 85,4 % – 100,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 2,6 % | 1,5 pt (1,8 % – 3,3 %) | 0,9 % – 63,5 % | 19/30 |
| Sans-abri max | toute la partie | — | 42,9 % | 15,1 pt (39,3 % – 54,4 %) | 29,2 % – 100,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,35 | 0,10 (0,32 – 0,42) | 0,14 – 0,46 | 3/30 |
| Gini en fin de partie | dernier jour | — | 0,43 | 0,28 (0,28 – 0,56) | 0,09 – 0,94 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,071 % | 0,026 pt (0,057 % – 0,083 %) | 0,031 % – 0,098 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 36,6 % | 28,9 pt (26,6 % – 55,5 %) | 12,9 % – 89,3 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 136,1 % | 18,0 pt (126,1 % – 144,1 %) | 103,9 % – 201,0 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 27,5 | 9,5 (22,3 – 31,8) | 12 – 42 | 30/30 |
| … dont après la chauffe | après chauffe | — | 24,5 | 8,8 (20,3 – 29) | 9 – 39 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 1524,5 | 227,5 (1439,5 – 1667) | 1261 – 3823 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 509 | 197 (396,5 – 593,5) | 216 – 708 | — |
| Santé moyenne | après chauffe | — | 0,18 | 0,09 (0,15 – 0,23) | 0,12 – 0,29 | — |
| Bonheur moyen | après chauffe | — | 0,81 | 0,03 (0,80 – 0,83) | 0,33 – 0,84 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 512,9 | 180,5 (398,6 – 579,1) | 272,8 – 605,3 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 876 | — |
| Trésor de l’État le plus bas | après chauffe | — | 90 804 $ | 84 999 $ (19 877 $ – 104 876 $) | 0 $ – 137 221 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 1392 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 160 | — |
| Créances radiées | toute la partie | — | 18 445 $ | 8 700 $ (16 286 $ – 24 986 $) | 10 309 $ – 33 146 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 6/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Faim répandue | critique | 30/30 | 5 | 4 – 7 | 1 – 10 | 130,5 j |
| Sans-abri nombreux | critique | 30/30 | 11 | 9 – 13,5 | 2 – 20 | 159 j |
| Inégalités hors bornes | attention | 28/30 | 3 | 2 – 4 | 0 – 8 | 145 j |
| Richesse médiane hors bornes | attention | 14/30 | 0 | 0 – 1 | 0 – 4 | 0 j |
| Inflation quotidienne | critique | 30/30 | 7 | 4 – 7,8 | 3 – 13 | 7 j |
| Inflation sur 100 jours | critique | 30/30 | 2 | 1 – 2,8 | 1 – 6 | 37,5 j |
| Rupture de stock prolongée | attention | 30/30 | 123 | 90,5 – 157,5 | 43 – 180 | 4501,5 j |
| Surstock | attention | 30/30 | 35 | 26,5 – 44,5 | 17 – 67 | 1337,5 j |
| Entreprise sans employé | attention | 30/30 | 132,5 | 106,8 – 154,8 | 53 – 183 | 1827 j |
| Entreprise sans client | attention | 30/30 | 152 | 115,3 – 176,3 | 58 – 210 | 5010 j |
| Caisse insolvable | attention | 5/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Santé de la population effondrée | critique | 30/30 | 1 | 1 – 1 | 1 – 1 | 1207 j |
| Productivité du travail effondrée | attention | 30/30 | 1 | 1 – 1 | 1 – 8 | 1206 j |
| Pénurie de main-d’œuvre | attention | 3/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Embauches bloquées faute de moyens | attention | 30/30 | 7 | 5 – 8 | 2 – 10 | 249,5 j |
| Prix aberrant | attention | 30/30 | 17,5 | 14 – 20,8 | 6 – 25 | 1943,5 j |
| Attente trop longue (service public) | attention | 30/30 | 1 | 1 – 1 | 1 – 4 | 1296 j |
| Prestations réduites faute de trésor | attention | 4/30 | 0 | 0 – 0 | 0 – 1 | 0 j |

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
| 11 | 8,9 % | 24,2 % | 4,5 % | 1,8 % | 0,33 | 0,069 % | 708 (32) | 0,25 | 12 % / 18 % / 70 % | 1 | 0 $ |
| 12 | 64,3 % | 100,0 % | 67,4 % | 63,5 % | 0,21 | 0,059 % | 499 (17) | 0,24 | 0 % / 25 % / 75 % | 5 | 0 $ |
| 13 | 7,7 % | 26,7 % | 5,3 % | 3,8 % | 0,41 | 0,090 % | 375 (34) | 0,13 | 4 % / 31 % / 65 % | 4 | 0 $ |
| 14 | 9,5 % | 38,3 % | 8,1 % | 4,8 % | 0,45 | 0,045 % | 505 (30) | 0,14 | 11 % / 21 % / 69 % | 3 | 2 416 $ |
| 15 | 7,4 % | 23,3 % | 4,1 % | 0,9 % | 0,30 | 0,069 % | 456 (18) | 0,15 | 5 % / 28 % / 67 % | 3 | 4 984 $ |
| 16 | 7,2 % | 25,0 % | 6,1 % | 1,7 % | 0,33 | 0,040 % | 626 (21) | 0,14 | 9 % / 24 % / 67 % | 4 | 0 $ |
| 17 | 8,2 % | 24,6 % | 6,8 % | 1,9 % | 0,29 | 0,075 % | 604 (25) | 0,19 | 10 % / 21 % / 68 % | 5 | 13 699 $ |
| 18 | 7,6 % | 28,3 % | 5,6 % | 3,0 % | 0,44 | 0,075 % | 404 (21) | 0,14 | 9 % / 29 % / 62 % | 3 | 16 441 $ |
| 19 | 7,3 % | 27,1 % | 7,7 % | 4,1 % | 0,45 | 0,087 % | 513 (29) | 0,12 | 11 % / 20 % / 69 % | 4 | 0 $ |
| 20 | 10,0 % | 32,1 % | 7,1 % | 2,3 % | 0,36 | 0,031 % | 633 (37) | 0,23 | 2 % / 14 % / 84 % | 3 | 0 $ |
| 21 | 8,9 % | 29,2 % | 7,5 % | 3,0 % | 0,39 | 0,072 % | 514 (27) | 0,24 | 10 % / 19 % / 71 % | 3 | 0 $ |
| 22 | 7,2 % | 20,8 % | 5,6 % | 3,5 % | 0,45 | 0,098 % | 394 (29) | 0,15 | 9 % / 18 % / 73 % | 1 | 9 436 $ |
| 23 | 63,5 % | 100,0 % | 64,3 % | 63,5 % | 0,14 | 0,035 % | 324 (12) | 0,29 | 23 % / 15 % / 62 % | 3 | 0 $ |
| 24 | 9,6 % | 30,4 % | 4,3 % | 2,7 % | 0,33 | 0,082 % | 542 (28) | 0,25 | 11 % / 18 % / 71 % | 0 | 30 925 $ |
| 25 | 7,0 % | 22,9 % | 9,3 % | 2,8 % | 0,46 | 0,074 % | 440 (28) | 0,16 | 4 % / 15 % / 82 % | 5 | 16 963 $ |
| 26 | 7,2 % | 24,2 % | 5,3 % | 2,6 % | 0,35 | 0,083 % | 364 (36) | 0,29 | 10 % / 27 % / 62 % | 3 | 45 623 $ |
| 27 | 7,6 % | 26,7 % | 4,2 % | 0,9 % | 0,28 | 0,056 % | 411 (23) | 0,16 | 10 % / 27 % / 63 % | 0 | 20 639 $ |
| 28 | 6,4 % | 23,3 % | 4,6 % | 2,6 % | 0,39 | 0,073 % | 348 (22) | 0,20 | 10 % / 24 % / 66 % | 5 | 11 502 $ |
| 29 | 8,2 % | 27,1 % | 9,3 % | 3,2 % | 0,42 | 0,058 % | 600 (36) | 0,14 | 9 % / 18 % / 73 % | 2 | 0 $ |
| 30 | 8,1 % | 31,3 % | 3,2 % | 2,2 % | 0,32 | 0,090 % | 321 (25) | 0,20 | 11 % / 21 % / 68 % | 2 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,0 % | 2,0 pt (6,0 % – 8,0 %) | 4,8 % – 13,4 % | 5/30 |
| Chômage max | toute la partie | — | 19,0 % | 9,5 pt (16,3 % – 25,7 %) | 14,6 % – 41,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 1,5 % | 0/30 |
| Faim max | toute la partie | — | 45,0 % | 52,0 pt (6,7 % – 58,6 %) | 0,0 % – 83,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,2 % | 0,5 pt (0,0 % – 0,5 %) | 0,0 % – 1,7 % | 0/30 |
| Sans-abri max | toute la partie | — | 18,3 % | 27,0 pt (6,1 % – 33,1 %) | 3,8 % – 64,6 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,20 | 0,02 (0,19 – 0,21) | 0,15 – 0,36 | 13/30 |
| Gini en fin de partie | dernier jour | — | 0,15 | 0,09 (0,14 – 0,23) | 0,12 – 0,40 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,040 % | 0,033 pt (0,024 % – 0,058 %) | -0,030 % – 0,102 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 47,8 % | 23,9 pt (34,0 % – 57,9 %) | 10,7 % – 90,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,0 % | 14,8 pt (134,4 % – 149,2 %) | 114,7 % – 228,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10 | 4 (9 – 13) | 4 – 23 | 30/30 |
| … dont après la chauffe | après chauffe | — | 8 | 4,8 (6,3 – 11) | 3 – 21 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 78,5 | 76,3 (44,8 – 121) | 29 – 1397 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 139,5 | 26 (131,3 – 157,3) | 112 – 556 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,0003 (0,88 – 0,88) | 0,20 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,004 (0,97 – 0,97) | 0,83 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,3 | 0,03 (0,3 – 0,4) | 0,3 – 313,7 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 126 | — |
| Trésor de l’État le plus bas | après chauffe | — | 52 260 $ | 66 278 $ (15 715 $ – 81 993 $) | 3 882 $ – 109 550 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 60 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 146 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 71 194 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,18 | 1,35 (0,00 – 1,35) | 0,00 – 37,29 | 10/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 13,05 | 6,75 (11,22 – 17,97) | 7,96 – 28,61 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 2,11 | 22,79 (0,04 – 22,83) | 0,00 – 60,82 | 17/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 5,21 | 1/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,18 | 0,00 – 1,35 | 0,00 – 37,29 | 10/30 | 1813 | pas de producteur (100 %) |
| Renflouement d’entreprise | 13,05 | 11,22 – 17,97 | 7,96 – 28,61 | 30/30 | 13646 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 2,11 | 0,04 – 22,83 | 0,00 – 60,82 | 17/30 | 11814 | prix trop élevé (81 %) ; parc plein (19 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 5,21 | 1/30 | 146 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 3405 · 30, Bijouterie 1870 · 29, Tourisme 1470 · 24, Fonderie 948 · 30, Mine de fer 900 · 30, Pêcherie 840 · 30, Garage 618 · 14, Machinerie 305 · 12.

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
| 29 | 13,4 % | 36,3 % | 0,2 % | 1,7 % | 0,28 | -0,013 % | 556 (22) | 0,52 | 7 % / 13 % / 81 % | 1 | 29 171 $ |
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
| Sans-abri max | 18,3 % | 17,9 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 1 / 27 sur 30 | non concluant |
| Gini moyen | 0,20 | 0,20 | 13 → 13 | 0,00 | [0,00 ; +0,001] | — / — / 11 | non concluant |
| Gini en fin de partie | 0,15 | 0,18 | — | 0,00 | [−0,002 ; 0,00] | — / — / 11 | non concluant |
| Inflation moyenne / j | 0,040 % | 0,040 % | 0 → 0 | 0,000 pt | [0,000 pt ; +0,00001 pt] | — / — / 11 | non concluant |
| |Inflation| max / j | 47,8 % | 45,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 5 / 2 / 23 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 141,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 0 / 29 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 10 | 30 → 30 | 0 | [0 ; 0] | 5 / 3 / 22 sur 30 | non concluant |
| … dont après la chauffe | 8 | 8 | — | 0 | [0 ; 0] | 5 / 3 / 22 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 78,5 | 79 | — | 0 | [0 ; 0] | 3 / 8 / 19 sur 30 | non concluant |
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
| Filet : Plancher de logement / 50 j | 2,11 | 2,11 | 17 → 17 | 0,00 | [0,00 ; 0,00] | 3 / 2 / 25 sur 30 | non concluant |
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
| Chômage moyen | après chauffe | ≤ 10 % | 8,1 % | 1,5 pt (7,3 % – 8,8 %) | 5,9 % – 13,5 % | 4/30 |
| Chômage max | toute la partie | — | 25,8 % | 3,5 pt (24,2 % – 27,7 %) | 15,0 % – 36,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 4,2 % | 2,1 pt (3,0 % – 5,1 %) | 0,0 % – 6,3 % | 25/30 |
| Faim max | toute la partie | — | 95,0 % | 1,7 pt (93,8 % – 95,4 %) | 0,0 % – 96,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 1,2 % | 0,8 pt (0,9 % – 1,7 %) | 0,5 % – 2,3 % | 2/30 |
| Sans-abri max | toute la partie | — | 32,7 % | 11,5 pt (28,0 % – 39,5 %) | 14,6 % – 65,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,36 | 0,06 (0,33 – 0,39) | 0,28 – 0,46 | 1/30 |
| Gini en fin de partie | dernier jour | — | 0,37 | 0,20 (0,28 – 0,48) | 0,16 – 0,82 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,067 % | 0,025 pt (0,055 % – 0,079 %) | 0,002 % – 0,097 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 40,7 % | 27,1 pt (26,4 % – 53,5 %) | 12,4 % – 79,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 134,6 % | 18,7 pt (125,9 % – 144,7 %) | 100,0 % – 160,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 19 | 5 (17 – 22) | 9 – 28 | 30/30 |
| … dont après la chauffe | après chauffe | — | 18 | 5,5 (15 – 20,5) | 6 – 25 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 1403,5 | 164,8 (1277,5 – 1442,3) | 140 – 1520 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 488 | 203,5 (392,5 – 596) | 176 – 682 | — |
| Santé moyenne | après chauffe | — | 0,17 | 0,08 (0,15 – 0,23) | 0,11 – 0,85 | — |
| Bonheur moyen | après chauffe | — | 0,82 | 0,02 (0,81 – 0,83) | 0,80 – 0,95 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 519,0 | 242,7 (327,8 – 570,5) | 10,1 – 666,2 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 58 | — |
| Trésor de l’État le plus bas | après chauffe | — | 104 983 $ | 35 619 $ (77 130 $ – 112 748 $) | 4 594 $ – 122 807 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 91,8 (0 – 91,8) | 0 – 1344 | — |
| Prêts refusés | toute la partie | — | 0 | 49,3 (0 – 49,3) | 0 – 186 | — |
| Créances radiées | toute la partie | — | 24 539 $ | 7 579 $ (19 256 $ – 26 836 $) | 11 578 $ – 54 767 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 131,54 | 81,93 (86,18 – 168,11) | 0,00 – 213,25 | 28/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 31,95 | 26,47 (14,34 – 40,81) | 3,68 – 64,29 | 30/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 1,76 (0,00 – 1,76) | 0,00 – 6,64 | 9/30 |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 131,54 | 86,18 – 168,11 | 0,00 – 213,25 | 28/30 | 102460 | pas de producteur (100 %) |
| Renflouement d’entreprise | coupé | — | — | — | — | — |
| Plancher de logement | 31,95 | 14,34 – 40,81 | 3,68 – 64,29 | 30/30 | 26386 | prix trop élevé (89 %) ; parc plein (11 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 1,76 | 0,00 – 6,64 | 9/30 | 1073 | fonds propres de la Caisse insuffisants (100 %) |

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « renflouement d’entreprise »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 8,1 % | 5 → 4 | +1,0 pt | [+0,2 pt ; +1,6 pt] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 19,0 % | 25,8 % | — | +4,4 pt | [+2,5 pt ; +7,1 pt] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,1 % | 4,2 % | 0 → 25 | +4,0 pt | [+3,4 pt ; +4,8 pt] | 1 / 28 / 1 sur 30 | **B plus haut (moins bien)** |
| Faim max | 45,0 % | 95,0 % | — | +46,7 pt | [+39,6 pt ; +74,0 pt] | 2 / 27 / 1 sur 30 | **B plus haut (moins bien)** |
| Sans-abri moyen | 0,2 % | 1,2 % | 0 → 2 | +1,1 pt | [+0,6 pt ; +1,2 pt] | 3 / 27 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 18,3 % | 32,7 % | — | +10,0 pt | [+1,5 pt ; +20,6 pt] | 3 / 21 / 6 sur 30 | **B plus haut (moins bien)** |
| Gini moyen | 0,20 | 0,36 | 13 → 1 | +0,15 | [+0,13 ; +0,19] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,15 | 0,37 | — | +0,17 | [+0,12 ; +0,23] | — / — / 0 | **B plus haut** |
| Inflation moyenne / j | 0,040 % | 0,067 % | 0 → 0 | +0,022 pt | [+0,008 pt ; +0,033 pt] | — / — / 0 | **B plus haut** |
| |Inflation| max / j | 47,8 % | 40,7 % | — | −0,8 pt | [−11,9 pt ; +4,1 pt] | 17 / 13 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 134,6 % | — | −2,5 pt | [−12,0 pt ; +1,7 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 19 | 30 → 30 | +8 | [+5,5 ; +10] | 2 / 26 / 2 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 8 | 18 | — | +8,5 | [+6 ; +10] | 2 / 27 / 1 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 78,5 | 1403,5 | — | +1293 | [+1192 ; +1343,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes ouvertes (toutes) | 139,5 | 488 | — | +292 | [+244 ; +394,5] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,17 | — | −0,71 | [−0,73 ; −0,65] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Bonheur moyen | 0,97 | 0,82 | — | −0,15 | [−0,16 ; −0,14] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,3 | 519,0 | — | +492,5 | [+340,9 ; +557,4] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| Trésor de l’État le plus bas | 52 260 $ | 104 983 $ | — | +47 805 $ | [+24 303 $ ; +69 183 $] | 25 / 5 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 9 / 20 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; +4,5] | — / — / 19 | non concluant |
| Créances radiées | 0 $ | 24 539 $ | — | +23 404 $ | [+19 338 $ ; +25 129 $] | — / — / 0 | **B plus haut** |
| Filet : Anti-famine / 50 j | 0,18 | 131,54 | 10 → 28 | +131,04 | [+106,13 ; +160,29] | 1 / 28 / 1 sur 30 | **B plus haut (moins bien)** |
| Filet : Plancher de logement / 50 j | 2,11 | 31,95 | 17 → 30 | +12,96 | [+8,86 ; +27,73] | 6 / 24 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 9 | 0,00 | [0,00 ; +0,16] | 1 / 10 / 19 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « renflouement d’entreprise »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 10,6 % | 36,7 % | 4,6 % | 0,7 % | 0,33 | 0,086 % | 664 (19) | 0,24 | 6 % / 30 % / 63 % | 9 | 6 400 $ |
| 2 | 9,8 % | 26,7 % | 4,6 % | 0,5 % | 0,34 | 0,054 % | 601 (17) | 0,15 | 6 % / 29 % / 65 % | 3 | 3 077 $ |
| 3 | 8,5 % | 26,3 % | 5,2 % | 0,7 % | 0,34 | 0,022 % | 682 (22) | 0,14 | 6 % / 19 % / 74 % | 6 | 0 $ |
| 4 | 10,9 % | 32,1 % | 2,3 % | 1,1 % | 0,35 | 0,066 % | 596 (22) | 0,21 | 4 % / 19 % / 78 % | 2 | 0 $ |
| 5 | 8,3 % | 26,7 % | 4,8 % | 0,7 % | 0,36 | 0,067 % | 661 (16) | 0,15 | 10 % / 25 % / 65 % | 1 | 0 $ |
| 6 | 6,4 % | 20,8 % | 0,0 % | 1,1 % | 0,30 | 0,079 % | 176 (10) | 0,23 | 9 % / 19 % / 72 % | 0 | 51 461 $ |
| 7 | 7,1 % | 25,8 % | 3,7 % | 1,7 % | 0,44 | 0,084 % | 372 (18) | 0,13 | 10 % / 19 % / 71 % | 6 | 1 791 $ |
| 8 | 7,4 % | 24,6 % | 3,3 % | 0,9 % | 0,35 | 0,064 % | 523 (27) | 0,11 | 8 % / 22 % / 70 % | 4 | 28 273 $ |
| 9 | 9,4 % | 29,2 % | 4,0 % | 1,9 % | 0,45 | 0,076 % | 502 (25) | 0,16 | 14 % / 27 % / 59 % | 7 | 15 778 $ |
| 10 | 8,3 % | 25,8 % | 5,2 % | 0,5 % | 0,32 | 0,065 % | 561 (22) | 0,16 | 3 % / 15 % / 81 % | 2 | 2 696 $ |
| 11 | 8,1 % | 25,8 % | 5,2 % | 1,1 % | 0,37 | 0,041 % | 427 (21) | 0,16 | 3 % / 32 % / 65 % | 0 | 1 271 $ |
| 12 | 7,5 % | 21,7 % | 6,3 % | 1,1 % | 0,35 | 0,083 % | 495 (20) | 0,30 | 9 % / 26 % / 65 % | 3 | 0 $ |
| 13 | 8,4 % | 24,2 % | 4,0 % | 1,1 % | 0,35 | 0,047 % | 437 (13) | 0,11 | 11 % / 20 % / 69 % | 1 | 3 310 $ |
| 14 | 6,4 % | 21,7 % | 2,2 % | 1,5 % | 0,39 | 0,083 % | 296 (13) | 0,14 | 11 % / 19 % / 69 % | 2 | 0 $ |
| 15 | 8,2 % | 25,0 % | 5,1 % | 2,3 % | 0,37 | 0,097 % | 422 (28) | 0,29 | 10 % / 26 % / 64 % | 1 | 0 $ |
| 16 | 7,1 % | 19,6 % | 3,9 % | 1,8 % | 0,44 | 0,066 % | 392 (22) | 0,20 | 1 % / 17 % / 82 % | 1 | 0 $ |
| 17 | 8,3 % | 25,8 % | 4,8 % | 0,8 % | 0,31 | 0,056 % | 559 (17) | 0,18 | 10 % / 24 % / 66 % | 2 | 6 499 $ |
| 18 | 8,0 % | 28,3 % | 5,5 % | 1,7 % | 0,46 | 0,078 % | 394 (15) | 0,14 | 11 % / 25 % / 64 % | 3 | 0 $ |
| 19 | 7,5 % | 25,0 % | 4,8 % | 0,5 % | 0,32 | 0,040 % | 623 (19) | 0,17 | 11 % / 20 % / 69 % | 5 | 0 $ |
| 20 | 9,0 % | 32,1 % | 3,7 % | 1,8 % | 0,40 | 0,077 % | 508 (25) | 0,23 | 11 % / 26 % / 64 % | 2 | 0 $ |
| 21 | 10,5 % | 27,9 % | 3,2 % | 1,1 % | 0,28 | 0,067 % | 605 (24) | 0,25 | 4 % / 31 % / 65 % | 1 | 2 819 $ |
| 22 | 7,7 % | 24,6 % | 4,3 % | 1,7 % | 0,44 | 0,055 % | 439 (18) | 0,15 | 7 % / 20 % / 73 % | 4 | 0 $ |
| 23 | 8,1 % | 24,6 % | 2,9 % | 1,7 % | 0,40 | 0,048 % | 402 (18) | 0,32 | 10 % / 20 % / 70 % | 1 | 0 $ |
| 24 | 13,5 % | 30,4 % | 0,9 % | 1,3 % | 0,33 | 0,002 % | 280 (24) | 0,85 | 9 % / 20 % / 71 % | 1 | 2 687 $ |
| 25 | 5,9 % | 15,0 % | 0,0 % | 1,4 % | 0,39 | 0,074 % | 182 (9) | 0,15 | 7 % / 26 % / 67 % | 0 | 0 $ |
| 26 | 6,6 % | 24,2 % | 1,9 % | 1,6 % | 0,38 | 0,080 % | 376 (19) | 0,26 | 12 % / 18 % / 70 % | 0 | 20 213 $ |
| 27 | 8,5 % | 27,1 % | 4,9 % | 0,5 % | 0,37 | 0,075 % | 596 (21) | 0,16 | 0 % / 13 % / 87 % | 7 | 0 $ |
| 28 | 6,3 % | 22,1 % | 1,9 % | 2,3 % | 0,33 | 0,097 % | 229 (15) | 0,20 | 2 % / 35 % / 63 % | 1 | 0 $ |
| 29 | 7,3 % | 20,8 % | 5,3 % | 1,4 % | 0,39 | 0,071 % | 481 (19) | 0,16 | 3 % / 20 % / 77 % | 2 | 0 $ |
| 30 | 8,9 % | 28,3 % | 5,6 % | 1,3 % | 0,34 | 0,035 % | 668 (23) | 0,18 | 10 % / 20 % / 70 % | 1 | 0 $ |

</details>

## 2 bis (3). Avec filets, sauf « Plancher de logement »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,0 % | 3,3 pt (6,2 % – 9,5 %) | 4,7 % – 15,4 % | 7/30 |
| Chômage max | toute la partie | — | 18,8 % | 7,9 pt (16,3 % – 24,2 %) | 14,2 % – 47,9 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,2 pt (0,0 % – 0,2 %) | 0,0 % – 5,5 % | 1/30 |
| Faim max | toute la partie | — | 16,7 % | 53,6 pt (0,0 % – 53,6 %) | 0,0 % – 90,8 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,3 % | 0,7 pt (0,0 % – 0,8 %) | 0,0 % – 3,3 % | 4/30 |
| Sans-abri max | toute la partie | — | 17,1 % | 33,1 pt (6,8 % – 39,9 %) | 3,8 % – 80,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,21 | 0,02 (0,19 – 0,22) | 0,15 – 0,37 | 12/30 |
| Gini en fin de partie | dernier jour | — | 0,18 | 0,10 (0,14 – 0,24) | 0,12 – 0,97 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,042 % | 0,031 pt (0,025 % – 0,056 %) | -0,060 % – 0,080 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 41,4 % | 17,8 pt (32,2 % – 50,0 %) | 10,7 % – 76,8 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 139,7 % | 10,0 pt (133,8 % – 143,8 %) | 114,6 % – 166,9 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 11,5 | 3,8 (9,3 – 13) | 6 – 32 | 30/30 |
| … dont après la chauffe | après chauffe | — | 10 | 5 (7 – 12) | 4 – 30 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 102 | 87,3 (49,8 – 137) | 26 – 1487 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 138,5 | 30,8 (131,3 – 162) | 118 – 347 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,0003 (0,88 – 0,88) | 0,28 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,01 (0,97 – 0,97) | 0,84 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,3 | 0,03 (0,3 – 0,4) | 0,3 – 334,1 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 172 | — |
| Trésor de l’État le plus bas | après chauffe | — | 56 168 $ | 65 812 $ (18 174 $ – 83 986 $) | 3 574 $ – 96 592 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 1 734 $ (0 $ – 1 734 $) | 0 $ – 9 208 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 1,03 (0,00 – 1,03) | 0,00 – 181,25 | 9/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 17,20 | 10,20 (10,69 – 20,88) | 7,96 – 33,00 | 30/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 1,03 | 0,00 – 181,25 | 9/30 | 6611 | pas de producteur (99 %) ; prix trop élevé (1 %) |
| Renflouement d’entreprise | 17,20 | 10,69 – 20,88 | 7,96 – 33,00 | 30/30 | 15449 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | coupé | — | — | — | — | — |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 3691 · 30, Tourisme 2533 · 23, Bijouterie 1814 · 29, Fonderie 898 · 30, Garage 776 · 13, Mine de fer 759 · 30, Pêcherie 724 · 30, Puits de pétrole 499 · 14.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plancher de logement »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 7,0 % | 5 → 7 | 0,0 pt | [−0,2 pt ; +0,3 pt] | 11 / 14 / 5 sur 30 | non concluant |
| Chômage max | 19,0 % | 18,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 9 / 9 / 12 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,0 % | 0 → 1 | 0,0 pt | [−0,02 pt ; 0,0 pt] | 13 / 7 / 10 sur 30 | non concluant |
| Faim max | 45,0 % | 16,7 % | — | 0,0 pt | [−13,8 pt ; 0,0 pt] | 13 / 7 / 10 sur 30 | non concluant |
| Sans-abri moyen | 0,2 % | 0,3 % | 0 → 4 | +0,02 pt | [0,0 pt ; +0,1 pt] | 8 / 17 / 5 sur 30 | non concluant |
| Sans-abri max | 18,3 % | 17,1 % | — | +0,2 pt | [0,0 pt ; +1,5 pt] | 6 / 15 / 9 sur 30 | non concluant |
| Gini moyen | 0,20 | 0,21 | 13 → 12 | 0,00 | [−0,005 ; +0,004] | — / — / 5 | non concluant |
| Gini en fin de partie | 0,15 | 0,18 | — | 0,00 | [−0,005 ; +0,03] | — / — / 5 | non concluant |
| Inflation moyenne / j | 0,040 % | 0,042 % | 0 → 0 | 0,000 pt | [−0,0001 pt ; +0,007 pt] | — / — / 5 | non concluant |
| |Inflation| max / j | 47,8 % | 41,4 % | — | 0,0 pt | [−2,2 pt ; 0,0 pt] | 14 / 6 / 10 sur 30 | non concluant |
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
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 20 | non concluant |
| Filet : Anti-famine / 50 j | 0,18 | 0,00 | 10 → 9 | 0,00 | [−0,13 ; 0,00] | 12 / 6 / 12 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,05 | 17,20 | 30 → 30 | 0,00 | [−0,05 ; +1,18] | 10 / 14 / 6 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 0 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plancher de logement »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,5 % | 26,7 % | 0,1 % | 0,2 % | 0,37 | 0,032 % | 152 (13) | 0,88 | 6 % / 14 % / 80 % | 1 | 0 $ |
| 2 | 7,9 % | 24,2 % | 0,1 % | 0,0 % | 0,20 | 0,001 % | 125 (7) | 0,88 | 4 % / 19 % / 78 % | 0 | 6 001 $ |
| 3 | 6,7 % | 16,7 % | 0,0 % | 0,3 % | 0,21 | 0,029 % | 124 (6) | 0,88 | 3 % / 18 % / 79 % | 0 | 0 $ |
| 4 | 12,1 % | 24,2 % | 0,0 % | 0,0 % | 0,26 | -0,048 % | 162 (8) | 0,88 | 7 % / 21 % / 71 % | 1 | 0 $ |
| 5 | 15,4 % | 41,3 % | 0,6 % | 2,7 % | 0,35 | -0,060 % | 286 (32) | 0,38 | 7 % / 10 % / 83 % | 0 | 2 729 $ |
| 6 | 4,8 % | 16,3 % | 0,0 % | 0,0 % | 0,15 | 0,026 % | 131 (12) | 0,88 | 7 % / 13 % / 80 % | 0 | 12 657 $ |
| 7 | 5,4 % | 17,1 % | 0,0 % | 0,4 % | 0,19 | 0,040 % | 135 (8) | 0,88 | 6 % / 12 % / 82 % | 0 | 7 380 $ |
| 8 | 9,8 % | 23,8 % | 0,0 % | 1,4 % | 0,21 | 0,006 % | 146 (11) | 0,88 | 6 % / 12 % / 81 % | 1 | 0 $ |
| 9 | 6,9 % | 23,8 % | 0,2 % | 1,0 % | 0,22 | 0,080 % | 130 (19) | 0,88 | 7 % / 17 % / 76 % | 0 | 24 695 $ |
| 10 | 15,0 % | 47,9 % | 5,5 % | 3,3 % | 0,26 | 0,042 % | 347 (29) | 0,57 | 14 % / 25 % / 61 % | 0 | 0 $ |
| 11 | 6,0 % | 16,3 % | 0,0 % | 0,4 % | 0,19 | 0,039 % | 138 (17) | 0,88 | 3 % / 20 % / 77 % | 0 | 10 590 $ |
| 12 | 6,8 % | 14,6 % | 0,0 % | 0,3 % | 0,22 | 0,058 % | 139 (10) | 0,88 | 6 % / 13 % / 81 % | 0 | 1 836 $ |
| 13 | 11,6 % | 34,2 % | 0,3 % | 2,5 % | 0,22 | 0,025 % | 162 (16) | 0,87 | 6 % / 14 % / 80 % | 0 | 0 $ |
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
| Chômage moyen | après chauffe | ≤ 10 % | 7,0 % | 2,0 pt (6,0 % – 8,0 %) | 4,8 % – 13,4 % | 5/30 |
| Chômage max | toute la partie | — | 19,0 % | 9,5 pt (16,3 % – 25,7 %) | 14,6 % – 41,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 1,5 % | 0/30 |
| Faim max | toute la partie | — | 45,0 % | 52,0 pt (6,7 % – 58,6 %) | 0,0 % – 83,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,2 % | 0,5 pt (0,0 % – 0,5 %) | 0,0 % – 1,7 % | 0/30 |
| Sans-abri max | toute la partie | — | 18,3 % | 27,0 pt (6,1 % – 33,1 %) | 3,8 % – 64,6 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,20 | 0,02 (0,19 – 0,21) | 0,15 – 0,36 | 13/30 |
| Gini en fin de partie | dernier jour | — | 0,15 | 0,09 (0,14 – 0,23) | 0,12 – 0,40 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,040 % | 0,033 pt (0,024 % – 0,058 %) | -0,030 % – 0,102 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 47,8 % | 23,9 pt (34,0 % – 57,9 %) | 10,7 % – 90,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,0 % | 14,8 pt (134,4 % – 149,2 %) | 114,7 % – 228,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10 | 4 (9 – 13) | 4 – 23 | 30/30 |
| … dont après la chauffe | après chauffe | — | 8 | 4,8 (6,3 – 11) | 3 – 21 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 78,5 | 76,3 (44,8 – 121) | 29 – 1397 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 139,5 | 26 (131,3 – 157,3) | 112 – 556 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,0003 (0,88 – 0,88) | 0,20 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,004 (0,97 – 0,97) | 0,83 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,3 | 0,03 (0,3 – 0,4) | 0,3 – 313,7 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 126 | — |
| Trésor de l’État le plus bas | après chauffe | — | 52 260 $ | 66 278 $ (15 715 $ – 81 993 $) | 3 882 $ – 109 550 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 60 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 146 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 71 194 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,18 | 1,35 (0,00 – 1,35) | 0,00 – 37,29 | 10/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 13,05 | 6,75 (11,22 – 17,97) | 7,96 – 28,61 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 2,11 | 22,79 (0,04 – 22,83) | 0,00 – 60,82 | 17/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 5,21 | 1/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,18 | 0,00 – 1,35 | 0,00 – 37,29 | 10/30 | 1813 | pas de producteur (100 %) |
| Renflouement d’entreprise | 13,05 | 11,22 – 17,97 | 7,96 – 28,61 | 30/30 | 13646 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 2,11 | 0,04 – 22,83 | 0,00 – 60,82 | 17/30 | 11814 | prix trop élevé (81 %) ; parc plein (19 %) |
| Plafond de dérive des prix et salaires | coupé | — | — | — | — | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 5,21 | 1/30 | 146 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 3405 · 30, Bijouterie 1870 · 29, Tourisme 1470 · 24, Fonderie 948 · 30, Mine de fer 900 · 30, Pêcherie 840 · 30, Garage 618 · 14, Machinerie 305 · 12.

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
| 4 | 10,5 % | 29,6 % | 0,6 % | 1,4 % | 0,22 | 0,058 % | 269 (20) | 0,71 | 17 % / 21 % / 63 % | 0 | 21 154 $ |
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
| 29 | 13,4 % | 36,3 % | 0,2 % | 1,7 % | 0,28 | -0,013 % | 556 (22) | 0,52 | 7 % / 13 % / 81 % | 1 | 29 171 $ |
| 30 | 11,2 % | 41,7 % | 1,5 % | 1,0 % | 0,27 | 0,001 % | 372 (21) | 0,20 | 7 % / 25 % / 68 % | 1 | 0 $ |

</details>

## 2 bis (5). Avec filets, sauf « Anti-crédit-fou »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,0 % | 2,0 pt (6,0 % – 8,0 %) | 4,8 % – 13,4 % | 5/30 |
| Chômage max | toute la partie | — | 19,0 % | 9,5 pt (16,3 % – 25,7 %) | 14,6 % – 41,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 1,5 % | 0/30 |
| Faim max | toute la partie | — | 45,0 % | 52,0 pt (6,7 % – 58,6 %) | 0,0 % – 83,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,2 % | 0,5 pt (0,0 % – 0,5 %) | 0,0 % – 1,7 % | 0/30 |
| Sans-abri max | toute la partie | — | 18,3 % | 27,0 pt (6,1 % – 33,1 %) | 3,8 % – 64,6 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,20 | 0,02 (0,19 – 0,21) | 0,15 – 0,36 | 13/30 |
| Gini en fin de partie | dernier jour | — | 0,15 | 0,09 (0,14 – 0,23) | 0,12 – 0,40 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,040 % | 0,033 pt (0,024 % – 0,058 %) | -0,030 % – 0,102 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 47,8 % | 23,9 pt (34,0 % – 57,9 %) | 10,7 % – 90,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,0 % | 14,8 pt (134,4 % – 149,2 %) | 114,7 % – 228,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10 | 4 (9 – 13) | 4 – 23 | 30/30 |
| … dont après la chauffe | après chauffe | — | 8 | 4,8 (6,3 – 11) | 3 – 21 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 78,5 | 76,3 (44,8 – 121) | 29 – 1397 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 139,5 | 26 (131,3 – 157,3) | 112 – 556 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,0003 (0,88 – 0,88) | 0,20 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,004 (0,97 – 0,97) | 0,83 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,3 | 0,03 (0,3 – 0,4) | 0,3 – 313,7 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 126 | — |
| Trésor de l’État le plus bas | après chauffe | — | 52 260 $ | 66 278 $ (15 715 $ – 81 993 $) | 3 882 $ – 109 550 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 60 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 146 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 71 194 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,18 | 1,35 (0,00 – 1,35) | 0,00 – 37,29 | 10/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 13,05 | 6,75 (11,22 – 17,97) | 7,96 – 28,61 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 2,11 | 22,79 (0,04 – 22,83) | 0,00 – 60,82 | 17/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,18 | 0,00 – 1,35 | 0,00 – 37,29 | 10/30 | 1813 | pas de producteur (100 %) |
| Renflouement d’entreprise | 13,05 | 11,22 – 17,97 | 7,96 – 28,61 | 30/30 | 13646 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 2,11 | 0,04 – 22,83 | 0,00 – 60,82 | 17/30 | 11814 | prix trop élevé (81 %) ; parc plein (19 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | coupé | — | — | — | — | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 3405 · 30, Bijouterie 1870 · 29, Tourisme 1470 · 24, Fonderie 948 · 30, Mine de fer 900 · 30, Pêcherie 840 · 30, Garage 618 · 14, Machinerie 305 · 12.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-crédit-fou »

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
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-crédit-fou »)</summary>

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
| 29 | 13,4 % | 36,3 % | 0,2 % | 1,7 % | 0,28 | -0,013 % | 556 (22) | 0,52 | 7 % / 13 % / 81 % | 1 | 29 171 $ |
| 30 | 11,2 % | 41,7 % | 1,5 % | 1,0 % | 0,27 | 0,001 % | 372 (21) | 0,20 | 7 % / 25 % / 68 % | 1 | 0 $ |

</details>

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. « Effondrée » : chômage moyen > 50 % avant le choc, l’évaluation n’a pas de sens. Un choc non résorbé compte comme une durée infinie dans la médiane.

### Sans filets

| Choc | Graines | Effondrée avant | Équilibre avant | Résorbé < 200 j | Retour (j) : médiane | EIQ (Q1–Q3) | Pic de chômage : médiane (Q1–Q3) | Alertes déclenchées (total, les plus fréquentes) |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 30 | 0 | 1 | 3 | non résorbé | non résorbé – non résorbé | 91,7 % (32,9 % – 97,4 %) | Entreprise sans client ×1984, Entreprise sans employé ×1891, Rupture de stock prolongée ×1374, Prix aberrant ×150 |
| +25 immigrants | 30 | 0 | 1 | 0 | non résorbé | non résorbé – non résorbé | 36,8 % (34,0 % – 39,5 %) | Entreprise sans client ×2161, Rupture de stock prolongée ×1935, Entreprise sans employé ×1852, Surstock ×599 |
| Salaire minimum 220 $/j | 30 | 0 | 1 | 1 | non résorbé | non résorbé – non résorbé | 26,7 % (21,9 % – 30,0 %) | Rupture de stock prolongée ×1101, Entreprise sans client ×1093, Entreprise sans employé ×912, Surstock ×221 |
| Fermeture de la ferme | 30 | 0 | 1 | 2 | non résorbé | non résorbé – non résorbé | 97,9 % (94,3 % – 98,3 %) | Entreprise sans client ×2444, Entreprise sans employé ×2209, Rupture de stock prolongée ×1594, Prix aberrant ×168 |
| Faillite d’une firme clé | 30 | 0 | 1 | 2 | non résorbé | non résorbé – non résorbé | 21,5 % (18,8 % – 26,6 %) | Entreprise sans client ×1276, Rupture de stock prolongée ×1184, Entreprise sans employé ×1083, Surstock ×220 |

### Avec filets

| Choc | Graines | Effondrée avant | Équilibre avant | Résorbé < 200 j | Retour (j) : médiane | EIQ (Q1–Q3) | Pic de chômage : médiane (Q1–Q3) | Alertes déclenchées (total, les plus fréquentes) |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 30 | 0 | 0 | 21 | 123 | 98 – non résorbé | 20,2 % (15,2 % – 22,4 %) | Rupture de stock prolongée ×738, Entreprise sans client ×698, Entreprise sans employé ×584, Surstock ×208 |
| +25 immigrants | 30 | 0 | 0 | 0 | non résorbé | non résorbé – non résorbé | 27,2 % (24,0 % – 30,3 %) | Rupture de stock prolongée ×319, Entreprise sans client ×297, Entreprise sans employé ×169, Prix aberrant ×161 |
| Salaire minimum 220 $/j | 30 | 0 | 0 | 0 | non résorbé | non résorbé – non résorbé | 31,0 % (28,4 % – 33,5 %) | Entreprise sans client ×426, Surstock ×290, Rupture de stock prolongée ×273, Entreprise sans employé ×258 |
| Fermeture de la ferme | 30 | 0 | 0 | 8 | 261 | 207 – 351 | 21,9 % (16,8 % – 24,6 %) | Rupture de stock prolongée ×353, Entreprise sans client ×315, Entreprise sans employé ×194, Surstock ×174 |
| Faillite d’une firme clé | 30 | 0 | 0 | 18 | 172 | 104 – 274 | 19,0 % (15,7 % – 23,3 %) | Entreprise sans client ×541, Rupture de stock prolongée ×408, Entreprise sans employé ×321, Surstock ×237 |

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 30/30 : g1 32, g2 31, g3 26, g4 32, g5 24, g6 12, g7 23, g8 42, … |
| Chômage moyen ≤ 10 % | ❌ | 4/30 : g1 10,9 %, g5 16,3 %, g12 64,3 %, g23 63,5 % |
| Faim et sans-abri < 2 % | ❌ | 29/30 : g1, g2, g3, g4, g5, g7, g8, g9, g10, g11, … |
| Gini 0,2–0,45 | ❌ | 3/30 : g14 0,45, g23 0,14, g25 0,46 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 30 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 30 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 10/30 graines ; Renflouement d’entreprise : 30/30 graines ; Plancher de logement : 17/30 graines ; Anti-crédit-fou : 1/30 graines |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 142/150 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 103/150 échecs |

### Critère de l’institution : avec filets, sauf « anti-famine »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-famine » : chômage moyen ≤ 10 % | ❌ | 4/30 : g1 11,4 %, g15 10,9 %, g29 13,7 %, g30 10,6 % |
| Sans « Anti-famine » : faim et sans-abri < 2 % | ❌ | 1/30 : g4 |
| Sans « Anti-famine » : aucune alerte critique | ❌ | 30/30 : g1 13, g2 8, g3 7, g4 14, g5 7, g6 12, g7 10, g8 10, … |

### Critère de l’institution : avec filets, sauf « renflouement d’entreprise »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Renflouement d’entreprise » : chômage moyen ≤ 10 % | ❌ | 4/30 : g1 10,6 %, g4 10,9 %, g21 10,5 %, g24 13,5 % |
| Sans « Renflouement d’entreprise » : faim et sans-abri < 2 % | ❌ | 26/30 : g1, g2, g3, g4, g5, g7, g8, g9, g10, g11, … |
| Sans « Renflouement d’entreprise » : aucune alerte critique | ❌ | 30/30 : g1 19, g2 17, g3 22, g4 22, g5 16, g6 10, g7 18, g8 27, … |

### Critère de l’institution : avec filets, sauf « plancher de logement »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plancher de logement » : chômage moyen ≤ 10 % | ❌ | 7/30 : g1 11,5 %, g4 12,1 %, g5 15,4 %, g10 15,0 %, g13 11,6 %, g29 13,8 %, g30 10,6 % |
| Sans « Plancher de logement » : faim et sans-abri < 2 % | ❌ | 4/30 : g5, g10, g13, g29 |
| Sans « Plancher de logement » : aucune alerte critique | ❌ | 30/30 : g1 13, g2 7, g3 6, g4 8, g5 32, g6 12, g7 8, g8 11, … |

### Critère de l’institution : avec filets, sauf « plafond de dérive des prix et salaires »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plafond de dérive des prix et salaires » : chômage moyen ≤ 10 % | ❌ | 5/30 : g1 11,4 %, g4 10,5 %, g15 10,9 %, g29 13,4 %, g30 11,2 % |
| Sans « Plafond de dérive des prix et salaires » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Plafond de dérive des prix et salaires » : aucune alerte critique | ❌ | 30/30 : g1 13, g2 7, g3 7, g4 20, g5 7, g6 12, g7 10, g8 10, … |

### Critère de l’institution : avec filets, sauf « anti-crédit-fou »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-crédit-fou » : chômage moyen ≤ 10 % | ❌ | 5/30 : g1 11,4 %, g4 10,5 %, g15 10,9 %, g29 13,4 %, g30 11,2 % |
| Sans « Anti-crédit-fou » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Anti-crédit-fou » : aucune alerte critique | ❌ | 30/30 : g1 13, g2 7, g3 7, g4 20, g5 7, g6 12, g7 10, g8 10, … |

