# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 13:27
- Graines : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Hôpital et école publics : enveloppe et file d’attente, Assurance-emploi indexée et aide sociale, Caisse : règles prudentielles, Faillite ordonnée
- Temps total : 4 min 7 s pour 210 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,2 % | 1,6 pt (7,5 % – 9,1 %) | 4,6 % – 72,6 % | 3/30 |
| Chômage max | toute la partie | — | 26,5 % | 7,8 pt (23,4 % – 31,3 %) | 18,8 % – 91,3 % | — |
| Faim moyenne | après chauffe | < 2 % | 7,0 % | 2,0 pt (5,7 % – 7,7 %) | 1,2 % – 85,1 % | 28/30 |
| Faim max | toute la partie | — | 95,2 % | 1,7 pt (94,2 % – 95,8 %) | 68,8 % – 100,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 1,7 % | 1,1 pt (1,3 % – 2,4 %) | 0,3 % – 61,5 % | 12/30 |
| Sans-abri max | toute la partie | — | 42,1 % | 14,3 pt (37,6 % – 51,9 %) | 20,4 % – 86,7 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,34 | 0,05 (0,33 – 0,38) | 0,26 – 0,79 | 3/30 |
| Gini en fin de partie | dernier jour | — | 0,48 | 0,35 (0,26 – 0,61) | 0,21 – 0,96 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,060 % | 0,020 pt (0,052 % – 0,072 %) | 0,033 % – 0,102 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 37,5 % | 42,2 pt (22,7 % – 64,9 %) | 9,2 % – 203,9 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 138,8 % | 20,3 pt (130,0 % – 150,3 %) | 96,9 % – 228,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 26 | 9 (22 – 31) | 16 – 39 | 30/30 |
| … dont après la chauffe | après chauffe | — | 24 | 9,8 (19,3 – 29) | 15 – 35 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 600 | 167 (509,8 – 676,8) | 196 – 968 | — |
| Santé moyenne | après chauffe | — | 0,11 | 0,03 (0,10 – 0,13) | 0,09 – 0,17 | — |
| Bonheur moyen | après chauffe | — | 0,80 | 0,01 (0,80 – 0,81) | 0,23 – 0,82 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 1160 | — |
| Trésor de l’État le plus bas | après chauffe | — | 76 796 $ | 28 231 $ (66 129 $ – 94 360 $) | 300 $ – 104 836 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 105,8 (0 – 105,8) | 0 – 1326 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 21 094 $ | 11 207 $ (15 979 $ – 27 186 $) | 3 659 $ – 44 852 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 3/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Chômage nul prolongé | attention | 2/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Faim répandue | critique | 30/30 | 5 | 4 – 6 | 1 – 12 | 143,5 j |
| Sans-abri nombreux | critique | 30/30 | 9,5 | 7 – 12,8 | 2 – 19 | 104,5 j |
| Inégalités hors bornes | attention | 30/30 | 4 | 2,3 – 5 | 1 – 7 | 122 j |
| Richesse médiane hors bornes | attention | 8/30 | 0 | 0 – 0,8 | 0 – 3 | 0 j |
| Inflation quotidienne | critique | 30/30 | 7 | 5,3 – 10,8 | 2 – 17 | 7 j |
| Inflation sur 100 jours | critique | 29/30 | 2 | 1 – 3 | 0 – 6 | 44,5 j |
| Rupture de stock prolongée | attention | 30/30 | 148,5 | 118,3 – 164 | 27 – 213 | 5785,5 j |
| Surstock | attention | 30/30 | 41 | 32,5 – 47 | 17 – 62 | 1255,5 j |
| Entreprise sans employé | attention | 30/30 | 170 | 141 – 186,8 | 56 – 310 | 2327,5 j |
| Entreprise sans client | attention | 30/30 | 190,5 | 154,8 – 207,8 | 57 – 359 | 5196 j |
| Caisse insolvable | attention | 8/30 | 0 | 0 – 0,8 | 0 – 3 | 0 j |
| Santé de la population effondrée | critique | 30/30 | 1 | 1 – 1 | 1 – 1 | 1305,5 j |
| Productivité du travail effondrée | attention | 30/30 | 1 | 1 – 1 | 1 – 1 | 1308 j |
| Pénurie de main-d’œuvre | attention | 9/30 | 0 | 0 – 1 | 0 – 1 | 0 j |
| Embauches bloquées faute de moyens | attention | 30/30 | 12 | 10 – 13 | 6 – 14 | 432,5 j |
| Prix aberrant | attention | 30/30 | 16,5 | 12,3 – 19 | 7 – 24 | 2550 j |
| Prestations réduites faute de trésor | attention | 3/30 | 0 | 0 – 0 | 0 – 1 | 0 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,6 % | 25,8 % | 1,2 % | 1,1 % | 0,35 | 0,090 % | 196 (17) | 0,12 | 10 % / 19 % / 71 % | 0 | 67 320 $ |
| 2 | 72,6 % | 91,3 % | 85,1 % | 61,5 % | 0,79 | 0,053 % | 968 (23) | 0,09 | 0 % / 9 % / 91 % | 12 | 0 $ |
| 3 | 6,4 % | 18,8 % | 2,3 % | 0,3 % | 0,26 | 0,060 % | 366 (18) | 0,11 | 10 % / 22 % / 69 % | 3 | 0 $ |
| 4 | 9,0 % | 27,9 % | 8,3 % | 2,6 % | 0,34 | 0,057 % | 637 (21) | 0,10 | 16 % / 25 % / 59 % | 11 | 18 033 $ |
| 5 | 8,4 % | 27,9 % | 6,5 % | 2,5 % | 0,42 | 0,061 % | 385 (30) | 0,17 | 6 % / 26 % / 68 % | 5 | 27 906 $ |
| 6 | 9,2 % | 34,2 % | 10,6 % | 3,7 % | 0,42 | 0,070 % | 583 (33) | 0,17 | 5 % / 28 % / 67 % | 5 | 7 787 $ |
| 7 | 5,6 % | 22,5 % | 6,3 % | 1,7 % | 0,43 | 0,056 % | 405 (17) | 0,10 | 9 % / 23 % / 69 % | 2 | 2 210 $ |
| 8 | 7,1 % | 22,1 % | 7,2 % | 1,5 % | 0,35 | 0,043 % | 627 (32) | 0,10 | 10 % / 20 % / 71 % | 4 | 3 216 $ |
| 9 | 8,4 % | 31,3 % | 7,9 % | 1,8 % | 0,31 | 0,052 % | 567 (29) | 0,10 | 10 % / 24 % / 65 % | 3 | 0 $ |
| 10 | 10,0 % | 32,9 % | 3,9 % | 1,3 % | 0,38 | 0,044 % | 643 (27) | 0,13 | 1 % / 16 % / 83 % | 5 | 0 $ |
| 11 | 7,3 % | 21,3 % | 8,7 % | 2,0 % | 0,33 | 0,060 % | 664 (31) | 0,12 | 9 % / 24 % / 68 % | 4 | 17 119 $ |
| 12 | 22,2 % | 70,4 % | 11,4 % | 10,5 % | 0,45 | 0,066 % | 593 (34) | 0,12 | 21 % / 24 % / 55 % | 5 | 14 771 $ |
| 13 | 6,7 % | 22,5 % | 3,4 % | 1,6 % | 0,39 | 0,094 % | 319 (16) | 0,13 | 2 % / 16 % / 83 % | 1 | 0 $ |
| 14 | 7,7 % | 23,8 % | 1,4 % | 0,6 % | 0,28 | 0,034 % | 492 (19) | 0,10 | 5 % / 17 % / 79 % | 1 | 7 527 $ |
| 15 | 7,9 % | 31,3 % | 6,8 % | 1,2 % | 0,31 | 0,050 % | 600 (22) | 0,11 | 11 % / 28 % / 61 % | 4 | 15 666 $ |
| 16 | 8,4 % | 25,8 % | 5,8 % | 1,9 % | 0,33 | 0,070 % | 679 (35) | 0,15 | 11 % / 21 % / 68 % | 2 | 0 $ |
| 17 | 8,2 % | 23,3 % | 5,0 % | 0,7 % | 0,31 | 0,077 % | 679 (18) | 0,15 | 12 % / 27 % / 61 % | 6 | 15 806 $ |
| 18 | 7,9 % | 22,5 % | 5,7 % | 1,2 % | 0,33 | 0,064 % | 743 (31) | 0,12 | 5 % / 22 % / 74 % | 4 | 0 $ |
| 19 | 8,0 % | 23,8 % | 5,0 % | 0,8 % | 0,33 | 0,078 % | 686 (26) | 0,10 | 9 % / 20 % / 71 % | 4 | 526 $ |
| 20 | 7,8 % | 23,8 % | 6,3 % | 1,5 % | 0,34 | 0,058 % | 536 (29) | 0,11 | 10 % / 25 % / 65 % | 7 | 2 366 $ |
| 21 | 9,1 % | 31,3 % | 7,7 % | 2,3 % | 0,35 | 0,087 % | 670 (23) | 0,13 | 10 % / 28 % / 62 % | 6 | 0 $ |
| 22 | 7,1 % | 20,8 % | 7,6 % | 2,4 % | 0,38 | 0,076 % | 483 (32) | 0,12 | 10 % / 21 % / 68 % | 7 | 4 884 $ |
| 23 | 8,9 % | 32,1 % | 7,2 % | 2,1 % | 0,33 | 0,056 % | 735 (30) | 0,10 | 13 % / 22 % / 65 % | 3 | 3 194 $ |
| 24 | 23,2 % | 81,3 % | 20,3 % | 12,1 % | 0,49 | 0,102 % | 501 (22) | 0,11 | 19 % / 33 % / 48 % | 3 | 7 616 $ |
| 25 | 8,1 % | 27,9 % | 7,0 % | 1,7 % | 0,34 | 0,038 % | 591 (22) | 0,13 | 11 % / 25 % / 65 % | 3 | 7 524 $ |
| 26 | 7,4 % | 24,6 % | 7,3 % | 1,7 % | 0,33 | 0,073 % | 646 (26) | 0,14 | 10 % / 25 % / 65 % | 8 | 0 $ |
| 27 | 9,8 % | 26,3 % | 6,9 % | 1,8 % | 0,37 | 0,044 % | 600 (25) | 0,13 | 11 % / 33 % / 56 % | 7 | 20 745 $ |
| 28 | 7,6 % | 30,0 % | 7,7 % | 2,0 % | 0,34 | 0,058 % | 598 (23) | 0,11 | 2 % / 32 % / 65 % | 6 | 1 042 $ |
| 29 | 8,3 % | 31,3 % | 7,2 % | 1,5 % | 0,32 | 0,064 % | 699 (32) | 0,11 | 11 % / 25 % / 65 % | 1 | 0 $ |
| 30 | 9,1 % | 26,7 % | 6,6 % | 2,6 % | 0,35 | 0,033 % | 714 (39) | 0,09 | 7 % / 21 % / 72 % | 7 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,4 % | 3,4 pt (6,4 % – 9,8 %) | 4,8 % – 15,5 % | 6/30 |
| Chômage max | toute la partie | — | 22,5 % | 12,9 pt (18,3 % – 31,3 %) | 14,2 % – 40,4 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,4 pt (0,0 % – 0,4 %) | 0,0 % – 5,3 % | 4/30 |
| Faim max | toute la partie | — | 13,5 % | 60,7 pt (0,0 % – 60,7 %) | 0,0 % – 80,8 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 2,1 % | 1/30 |
| Sans-abri max | toute la partie | — | 26,0 % | 33,8 pt (7,9 % – 41,7 %) | 1,3 % – 58,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,16 | 0,04 (0,15 – 0,19) | 0,12 – 0,24 | 23/30 |
| Gini en fin de partie | dernier jour | — | 0,15 | 0,11 (0,12 – 0,23) | 0,09 – 0,49 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,038 % | 0,039 pt (0,021 % – 0,060 %) | -0,013 % – 0,085 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 33,1 % | 20,1 pt (24,8 % – 44,9 %) | 12,1 % – 86,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 136,4 % | 12,3 pt (130,1 % – 142,4 %) | 94,9 % – 155,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10,5 | 7,8 (7 – 14,8) | 3 – 29 | 30/30 |
| … dont après la chauffe | après chauffe | — | 8,5 | 7,8 (5,3 – 13) | 1 – 25 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 181 | 102 (147,3 – 249,3) | 87 – 423 | — |
| Santé moyenne | après chauffe | — | 0,87 | 0,09 (0,79 – 0,88) | 0,32 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,04 (0,94 – 0,98) | 0,87 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 2,3 (0 – 2,3) | 0 – 467 | — |
| Trésor de l’État le plus bas | après chauffe | — | 21 277 $ | 64 028 $ (6 458 $ – 70 486 $) | 2 732 $ – 98 212 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 13 | — |
| Créances radiées | toute la partie | — | 0 $ | 3 107 $ (0 $ – 3 107 $) | 0 $ – 24 357 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,02 | 6,88 (0,00 – 6,88) | 0,00 – 179,96 | 12/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 32,55 | 5,29 (29,53 – 34,82) | 21,43 – 46,07 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,31 (0,00 – 0,31) | 0,00 – 45,39 | 7/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,46 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 10,36 | 1,96 (9,44 – 11,39) | 7,71 – 13,96 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,02 | 0,00 – 6,88 | 0,00 – 179,96 | 12/30 | 15326 | pas de producteur (100 %) |
| Renflouement d’entreprise | 32,55 | 29,53 – 34,82 | 21,43 – 46,07 | 30/30 | 28757 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 0,31 | 0,00 – 45,39 | 7/30 | 5020 | parc plein (89 %) ; prix trop élevé (11 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,46 | 0/30 | 13 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Hôpital 8684 · 30, Ferme 4407 · 30, Tourisme 2604 · 26, École 1465 · 30, Garage 1290 · 18, Fonderie 1280 · 30, Pétrochimie 1218 · 30, Bijouterie 976 · 25.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,4 % | 18,8 % | 0,1 % | 0,8 % | 0,19 | 0,075 % | 250 (12) | 0,42 | 10 % / 20 % / 70 % | 5 | 0 $ |
| 2 | 8,0 % | 26,3 % | 0,3 % | 0,0 % | 0,17 | 0,059 % | 233 (14) | 0,86 | 6 % / 12 % / 82 % | 0 | 6 939 $ |
| 3 | 8,8 % | 30,0 % | 2,2 % | 0,6 % | 0,21 | 0,057 % | 254 (15) | 0,66 | 10 % / 20 % / 70 % | 0 | 2 758 $ |
| 4 | 8,5 % | 20,0 % | 0,0 % | 0,0 % | 0,16 | 0,034 % | 158 (10) | 0,88 | 3 % / 18 % / 80 % | 1 | 9 211 $ |
| 5 | 9,5 % | 21,7 % | 0,0 % | 0,0 % | 0,18 | 0,060 % | 140 (8) | 0,84 | 6 % / 10 % / 84 % | 0 | 16 512 $ |
| 6 | 6,4 % | 16,7 % | 0,0 % | 0,0 % | 0,13 | 0,079 % | 124 (8) | 0,88 | 3 % / 17 % / 79 % | 1 | 11 356 $ |
| 7 | 7,1 % | 23,3 % | 0,1 % | 0,0 % | 0,15 | 0,018 % | 187 (7) | 0,88 | 5 % / 16 % / 79 % | 0 | 1 813 $ |
| 8 | 5,9 % | 18,3 % | 0,0 % | 0,0 % | 0,12 | 0,085 % | 130 (7) | 0,88 | 6 % / 15 % / 79 % | 0 | 12 058 $ |
| 9 | 6,4 % | 17,5 % | 0,0 % | 0,0 % | 0,15 | 0,079 % | 135 (6) | 0,88 | 3 % / 18 % / 79 % | 0 | 5 029 $ |
| 10 | 9,4 % | 26,7 % | 0,0 % | 0,0 % | 0,16 | 0,029 % | 149 (7) | 0,87 | 8 % / 14 % / 78 % | 2 | 2 098 $ |
| 11 | 9,0 % | 21,3 % | 0,0 % | 0,0 % | 0,16 | 0,033 % | 179 (13) | 0,87 | 6 % / 13 % / 81 % | 1 | 22 538 $ |
| 12 | 10,2 % | 32,5 % | 1,9 % | 2,1 % | 0,24 | 0,045 % | 423 (16) | 0,61 | 10 % / 14 % / 76 % | 0 | 27 922 $ |
| 13 | 7,0 % | 23,3 % | 0,0 % | 0,0 % | 0,15 | 0,034 % | 147 (6) | 0,87 | 7 % / 12 % / 81 % | 0 | 8 122 $ |
| 14 | 7,6 % | 15,0 % | 0,1 % | 0,0 % | 0,16 | 0,032 % | 148 (5) | 0,88 | 6 % / 14 % / 80 % | 0 | 0 $ |
| 15 | 10,2 % | 25,0 % | 0,3 % | 0,6 % | 0,21 | 0,075 % | 295 (24) | 0,46 | 12 % / 24 % / 65 % | 0 | 5 479 $ |
| 16 | 10,7 % | 33,3 % | 0,8 % | 0,0 % | 0,24 | 0,004 % | 261 (14) | 0,35 | 8 % / 19 % / 72 % | 0 | 0 $ |
| 17 | 7,9 % | 19,2 % | 0,0 % | 0,0 % | 0,16 | 0,037 % | 151 (6) | 0,86 | 6 % / 14 % / 81 % | 4 | 0 $ |
| 18 | 12,8 % | 36,3 % | 0,3 % | 0,0 % | 0,19 | 0,010 % | 211 (18) | 0,87 | 6 % / 13 % / 81 % | 0 | 1 464 $ |
| 19 | 11,6 % | 35,8 % | 0,6 % | 0,0 % | 0,20 | 0,001 % | 188 (11) | 0,86 | 7 % / 14 % / 80 % | 1 | 1 979 $ |
| 20 | 9,5 % | 31,7 % | 0,3 % | 0,1 % | 0,22 | 0,030 % | 327 (10) | 0,32 | 6 % / 18 % / 76 % | 4 | 29 098 $ |
| 21 | 9,9 % | 32,1 % | 2,3 % | 0,6 % | 0,18 | -0,007 % | 291 (21) | 0,80 | 6 % / 19 % / 75 % | 2 | 143 693 $ |
| 22 | 4,8 % | 14,2 % | 0,4 % | 0,0 % | 0,15 | 0,059 % | 184 (17) | 0,87 | 8 % / 12 % / 80 % | 2 | 29 837 $ |
| 23 | 5,5 % | 17,5 % | 0,0 % | 0,0 % | 0,14 | 0,061 % | 159 (9) | 0,87 | 7 % / 14 % / 79 % | 1 | 11 432 $ |
| 24 | 9,9 % | 40,4 % | 5,3 % | 1,6 % | 0,18 | 0,043 % | 247 (14) | 0,73 | 9 % / 13 % / 78 % | 2 | 23 273 $ |
| 25 | 9,6 % | 26,7 % | 0,0 % | 0,0 % | 0,17 | -0,013 % | 183 (8) | 0,84 | 6 % / 17 % / 77 % | 1 | 24 800 $ |
| 26 | 6,3 % | 14,2 % | 0,0 % | 0,0 % | 0,14 | 0,014 % | 87 (3) | 0,88 | 3 % / 19 % / 78 % | 0 | 27 957 $ |
| 27 | 6,2 % | 18,3 % | 0,0 % | 0,1 % | 0,14 | 0,042 % | 157 (14) | 0,87 | 7 % / 13 % / 81 % | 0 | 13 348 $ |
| 28 | 6,1 % | 18,8 % | 0,0 % | 0,0 % | 0,14 | 0,039 % | 139 (15) | 0,88 | 6 % / 13 % / 81 % | 0 | 4 046 $ |
| 29 | 6,2 % | 15,8 % | 0,0 % | 0,0 % | 0,15 | 0,081 % | 132 (7) | 0,88 | 6 % / 14 % / 80 % | 1 | 44 633 $ |
| 30 | 15,5 % | 37,9 % | 3,7 % | 0,9 % | 0,23 | 0,018 % | 250 (29) | 0,79 | 18 % / 21 % / 61 % | 0 | 23 244 $ |

</details>

## 2 bis (1). Avec filets, sauf « Anti-famine »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,2 % | 3,3 pt (6,4 % – 9,8 %) | 5,1 % – 18,1 % | 7/30 |
| Chômage max | toute la partie | — | 23,3 % | 14,4 pt (18,3 % – 32,7 %) | 14,2 % – 80,4 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 1,2 pt (0,0 % – 1,2 %) | 0,0 % – 16,8 % | 6/30 |
| Faim max | toute la partie | — | 22,5 % | 76,0 pt (0,0 % – 76,0 %) | 0,0 % – 100,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,5 pt (0,0 % – 0,5 %) | 0,0 % – 4,0 % | 4/30 |
| Sans-abri max | toute la partie | — | 28,3 % | 37,7 pt (10,8 % – 48,5 %) | 1,3 % – 65,4 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,17 | 0,05 (0,15 – 0,20) | 0,12 – 0,30 | 22/30 |
| Gini en fin de partie | dernier jour | — | 0,15 | 0,08 (0,12 – 0,20) | 0,07 – 0,88 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,041 % | 0,032 pt (0,033 % – 0,065 %) | -0,018 % – 0,085 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 33,6 % | 16,8 pt (24,8 % – 41,6 %) | 9,1 % – 86,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 137,3 % | 13,1 pt (130,1 % – 143,3 %) | 94,9 % – 155,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 12,5 | 9,8 (7 – 16,8) | 3 – 27 | 30/30 |
| … dont après la chauffe | après chauffe | — | 10 | 7,8 (5,3 – 13) | 1 – 26 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 181 | 120 (141,8 – 261,8) | 87 – 421 | — |
| Santé moyenne | après chauffe | — | 0,87 | 0,29 (0,58 – 0,88) | 0,26 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,08 (0,89 – 0,98) | 0,77 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 42,8 (0 – 42,8) | 0 – 335 | — |
| Trésor de l’État le plus bas | après chauffe | — | 19 017 $ | 66 533 $ (3 953 $ – 70 486 $) | 730 $ – 98 212 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 2 177 $ (0 $ – 2 177 $) | 0 $ – 16 155 $ | — |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 32,20 | 5,46 (29,16 – 34,62) | 23,18 – 48,50 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 2,63 (0,00 – 2,63) | 0,00 – 110,18 | 10/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 10,11 | 1,97 (9,29 – 11,27) | 4,54 – 13,96 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | coupé | — | — | — | — | — |
| Renflouement d’entreprise | 32,20 | 29,16 – 34,62 | 23,18 – 48,50 | 30/30 | 28914 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 2,63 | 0,00 – 110,18 | 10/30 | 12748 | parc plein (60 %) ; prix trop élevé (40 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Hôpital 8421 · 30, Ferme 4215 · 30, Tourisme 2664 · 26, École 1511 · 30, Pétrochimie 1254 · 30, Fonderie 1242 · 29, Garage 1170 · 19, Bijouterie 1045 · 27.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-famine »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,4 % | 8,2 % | 6 → 7 | 0,0 pt | [0,0 pt ; 0,0 pt] | 7 / 8 / 15 sur 30 | non concluant |
| Chômage max | 22,5 % | 23,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 6 / 22 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,1 % | 4 → 6 | 0,0 pt | [0,0 pt ; +0,01 pt] | 4 / 12 / 14 sur 30 | non concluant |
| Faim max | 13,5 % | 22,5 % | — | 0,0 pt | [0,0 pt ; +0,6 pt] | 2 / 10 / 18 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 1 → 4 | 0,0 pt | [0,0 pt ; 0,0 pt] | 5 / 8 / 17 sur 30 | non concluant |
| Sans-abri max | 26,0 % | 28,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 8 / 21 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,17 | 23 → 22 | 0,00 | [0,00 ; +0,003] | — / — / 15 | non concluant |
| Gini en fin de partie | 0,15 | 0,15 | — | 0,00 | [0,00 ; 0,00] | — / — / 15 | non concluant |
| Inflation moyenne / j | 0,038 % | 0,041 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 15 | non concluant |
| |Inflation| max / j | 33,1 % | 33,6 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 7 / 21 sur 30 | non concluant |
| |Inflation sur 100 j| max | 136,4 % | 137,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Alertes critiques ouvertes | 10,5 | 12,5 | 30 → 30 | 0 | [0 ; 0] | 4 / 8 / 18 sur 30 | non concluant |
| … dont après la chauffe | 8,5 | 10 | — | 0 | [0 ; 0] | 4 / 8 / 18 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 181 | 181 | — | 0 | [0 ; 0] | 6 / 9 / 15 sur 30 | non concluant |
| Santé moyenne | 0,87 | 0,87 | — | 0,00 | [0,00 ; 0,00] | 7 / 8 / 15 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [0,00 ; 0,00] | 6 / 9 / 15 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 6 / 22 sur 30 | non concluant |
| Trésor de l’État le plus bas | 21 277 $ | 19 017 $ | — | 0 $ | [0 $ ; 0 $] | 1 / 7 / 22 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 21 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 32,55 | 32,20 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 8 / 7 / 15 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 7 → 10 | 0,00 | [0,00 ; 0,00] | 2 / 9 / 19 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 10,36 | 10,11 | — | 0,00 | [−0,02 ; 0,00] | 10 / 5 / 15 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-famine »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,4 % | 18,8 % | 0,1 % | 0,8 % | 0,19 | 0,075 % | 250 (12) | 0,42 | 10 % / 20 % / 70 % | 5 | 0 $ |
| 2 | 7,6 % | 26,3 % | 0,3 % | 0,0 % | 0,17 | 0,065 % | 203 (16) | 0,87 | 5 % / 13 % / 81 % | 1 | 5 850 $ |
| 3 | 15,8 % | 48,8 % | 3,8 % | 2,7 % | 0,25 | 0,039 % | 290 (25) | 0,68 | 13 % / 18 % / 69 % | 2 | 14 951 $ |
| 4 | 9,0 % | 28,3 % | 2,1 % | 0,5 % | 0,18 | 0,046 % | 275 (17) | 0,83 | 1 % / 5 % / 95 % | 2 | 15 929 $ |
| 5 | 9,5 % | 21,7 % | 0,0 % | 0,0 % | 0,18 | 0,060 % | 140 (8) | 0,84 | 6 % / 10 % / 84 % | 0 | 16 512 $ |
| 6 | 6,4 % | 16,7 % | 0,0 % | 0,0 % | 0,13 | 0,079 % | 124 (8) | 0,88 | 3 % / 17 % / 79 % | 1 | 11 356 $ |
| 7 | 8,2 % | 23,3 % | 0,1 % | 0,0 % | 0,18 | -0,015 % | 160 (7) | 0,88 | 6 % / 9 % / 85 % | 0 | 0 $ |
| 8 | 5,9 % | 18,3 % | 0,0 % | 0,0 % | 0,12 | 0,085 % | 130 (7) | 0,88 | 6 % / 15 % / 79 % | 0 | 12 058 $ |
| 9 | 6,4 % | 17,5 % | 0,0 % | 0,0 % | 0,15 | 0,079 % | 135 (6) | 0,88 | 3 % / 18 % / 79 % | 0 | 5 029 $ |
| 10 | 9,4 % | 26,7 % | 0,0 % | 0,0 % | 0,16 | 0,029 % | 149 (7) | 0,87 | 8 % / 14 % / 78 % | 2 | 2 098 $ |
| 11 | 9,0 % | 21,3 % | 0,0 % | 0,0 % | 0,16 | 0,033 % | 179 (13) | 0,87 | 6 % / 13 % / 81 % | 1 | 22 538 $ |
| 12 | 13,3 % | 70,4 % | 2,4 % | 3,7 % | 0,26 | 0,056 % | 359 (27) | 0,55 | 7 % / 17 % / 77 % | 0 | 22 591 $ |
| 13 | 7,0 % | 23,3 % | 0,0 % | 0,0 % | 0,15 | 0,034 % | 147 (6) | 0,87 | 7 % / 12 % / 81 % | 0 | 8 122 $ |
| 14 | 7,5 % | 15,0 % | 0,1 % | 0,0 % | 0,15 | 0,047 % | 124 (5) | 0,88 | 7 % / 13 % / 80 % | 1 | 4 211 $ |
| 15 | 8,3 % | 25,0 % | 0,4 % | 0,2 % | 0,25 | 0,063 % | 261 (13) | 0,36 | 9 % / 23 % / 69 % | 0 | 1 043 $ |
| 16 | 9,8 % | 33,3 % | 1,7 % | 0,2 % | 0,29 | -0,006 % | 300 (17) | 0,40 | 7 % / 9 % / 84 % | 0 | 14 608 $ |
| 17 | 7,9 % | 19,2 % | 0,0 % | 0,0 % | 0,16 | 0,037 % | 151 (6) | 0,86 | 6 % / 14 % / 81 % | 4 | 0 $ |
| 18 | 12,6 % | 36,3 % | 0,7 % | 0,5 % | 0,23 | 0,020 % | 261 (24) | 0,50 | 7 % / 11 % / 82 % | 0 | 3 779 $ |
| 19 | 18,1 % | 80,4 % | 16,8 % | 4,0 % | 0,30 | 0,077 % | 315 (20) | 0,26 | 0 % / 11 % / 89 % | 2 | 0 $ |
| 20 | 8,1 % | 30,8 % | 0,1 % | 0,2 % | 0,20 | 0,073 % | 278 (10) | 0,27 | 7 % / 15 % / 77 % | 0 | 1 237 $ |
| 21 | 11,8 % | 43,3 % | 4,4 % | 2,2 % | 0,19 | 0,033 % | 421 (23) | 0,55 | 9 % / 23 % / 68 % | 0 | 4 617 $ |
| 22 | 5,1 % | 14,2 % | 0,2 % | 0,0 % | 0,15 | 0,033 % | 200 (15) | 0,88 | 7 % / 14 % / 78 % | 0 | 38 706 $ |
| 23 | 5,5 % | 17,5 % | 0,0 % | 0,0 % | 0,14 | 0,061 % | 159 (9) | 0,87 | 7 % / 14 % / 79 % | 1 | 11 432 $ |
| 24 | 10,9 % | 40,8 % | 2,8 % | 1,3 % | 0,18 | 0,033 % | 262 (13) | 0,73 | 6 % / 12 % / 82 % | 8 | 3 946 $ |
| 25 | 9,6 % | 26,7 % | 0,0 % | 0,0 % | 0,17 | -0,013 % | 183 (8) | 0,84 | 6 % / 17 % / 77 % | 1 | 24 800 $ |
| 26 | 6,3 % | 14,2 % | 0,0 % | 0,0 % | 0,14 | 0,014 % | 87 (3) | 0,88 | 3 % / 19 % / 78 % | 0 | 27 957 $ |
| 27 | 6,2 % | 18,3 % | 0,0 % | 0,1 % | 0,14 | 0,042 % | 157 (14) | 0,87 | 7 % / 13 % / 81 % | 0 | 13 348 $ |
| 28 | 6,1 % | 18,8 % | 0,0 % | 0,0 % | 0,14 | 0,039 % | 139 (15) | 0,88 | 6 % / 13 % / 81 % | 0 | 4 046 $ |
| 29 | 6,2 % | 15,8 % | 0,0 % | 0,0 % | 0,15 | 0,081 % | 132 (7) | 0,88 | 6 % / 14 % / 80 % | 1 | 44 633 $ |
| 30 | 14,6 % | 35,8 % | 1,4 % | 0,3 % | 0,23 | -0,018 % | 255 (22) | 0,82 | 10 % / 18 % / 73 % | 0 | 12 086 $ |

</details>

## 2 bis (2). Avec filets, sauf « Renflouement d’entreprise »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,7 % | 1,3 pt (7,2 % – 8,5 %) | 5,9 % – 9,5 % | 0/30 |
| Chômage max | toute la partie | — | 24,8 % | 5,2 pt (23,3 % – 28,5 %) | 18,8 % – 33,8 % | — |
| Faim moyenne | après chauffe | < 2 % | 3,9 % | 2,4 pt (2,7 % – 5,1 %) | 0,8 % – 6,1 % | 24/30 |
| Faim max | toute la partie | — | 94,4 % | 2,8 pt (92,5 % – 95,3 %) | 77,5 % – 96,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,6 % | 0,3 pt (0,5 % – 0,9 %) | 0,2 % – 1,7 % | 0/30 |
| Sans-abri max | toute la partie | — | 35,2 % | 11,5 pt (28,5 % – 40,0 %) | 19,2 % – 64,6 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,35 | 0,04 (0,34 – 0,38) | 0,23 – 0,48 | 1/30 |
| Gini en fin de partie | dernier jour | — | 0,42 | 0,39 (0,27 – 0,66) | 0,18 – 0,86 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,056 % | 0,026 pt (0,043 % – 0,069 %) | 0,004 % – 0,094 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 35,7 % | 28,0 pt (23,6 % – 51,6 %) | 4,2 % – 172,7 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 135,0 % | 19,7 pt (127,7 % – 147,4 %) | 90,5 % – 206,5 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 18 | 10,3 (15 – 25,3) | 9 – 52 | 30/30 |
| … dont après la chauffe | après chauffe | — | 15,5 | 10 (12,5 – 22,5) | 7 – 50 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 523 | 195,8 (428,8 – 624,5) | 257 – 752 | — |
| Santé moyenne | après chauffe | — | 0,11 | 0,04 (0,11 – 0,15) | 0,09 – 0,17 | — |
| Bonheur moyen | après chauffe | — | 0,81 | 0,01 (0,81 – 0,82) | 0,80 – 0,83 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 83 716 $ | 19 115 $ (74 044 $ – 93 159 $) | 9 903 $ – 110 747 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 1312,8 (0 – 1312,8) | 0 – 1380 | — |
| Prêts refusés | toute la partie | — | 0 | 163,5 (0 – 163,5) | 0 – 251 | — |
| Créances radiées | toute la partie | — | 24 976 $ | 9 827 $ (18 307 $ – 28 134 $) | 7 394 $ – 60 093 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 118,91 | 90,95 (78,13 – 169,08) | 23,39 – 212,64 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 8,59 | 8,24 (5,92 – 14,16) | 1,93 – 44,43 | 30/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 5,84 (0,00 – 5,84) | 0,00 – 8,96 | 14/30 |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 118,91 | 78,13 – 169,08 | 23,39 – 212,64 | 30/30 | 100986 | pas de producteur (100 %) ; prix trop élevé (0 %) |
| Renflouement d’entreprise | coupé | — | — | — | — | — |
| Plancher de logement | 8,59 | 5,92 – 14,16 | 1,93 – 44,43 | 30/30 | 12212 | prix trop élevé (68 %) ; parc plein (32 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 5,84 | 0,00 – 8,96 | 14/30 | 2416 | fonds propres de la Caisse insuffisants (100 %) |

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « renflouement d’entreprise »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,4 % | 7,7 % | 6 → 0 | −0,9 pt | [−1,9 pt ; +0,6 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Chômage max | 22,5 % | 24,8 % | — | +3,5 pt | [−1,9 pt ; +5,4 pt] | 12 / 18 / 0 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 3,9 % | 4 → 24 | +3,4 pt | [+2,9 pt ; +4,4 pt] | 3 / 27 / 0 sur 30 | **B plus haut (moins bien)** |
| Faim max | 13,5 % | 94,4 % | — | +77,7 pt | [+35,2 pt ; +83,3 pt] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri moyen | 0,0 % | 0,6 % | 1 → 0 | +0,6 pt | [+0,5 pt ; +0,7 pt] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 26,0 % | 35,2 % | — | +7,5 pt | [+0,6 pt ; +17,3 pt] | 6 / 20 / 4 sur 30 | **B plus haut (moins bien)** |
| Gini moyen | 0,16 | 0,35 | 23 → 1 | +0,18 | [+0,17 ; +0,22] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,15 | 0,42 | — | +0,28 | [+0,11 ; +0,46] | — / — / 0 | **B plus haut** |
| Inflation moyenne / j | 0,038 % | 0,056 % | 0 → 0 | +0,015 pt | [+0,006 pt ; +0,027 pt] | — / — / 0 | **B plus haut** |
| |Inflation| max / j | 33,1 % | 35,7 % | — | +4,2 pt | [−15,3 pt ; +13,0 pt] | 13 / 17 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 136,4 % | 135,0 % | — | +0,8 pt | [−7,7 pt ; +5,6 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 10,5 | 18 | 30 → 30 | +8 | [+4,5 ; +9] | 3 / 26 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 8,5 | 15,5 | — | +8 | [+4,5 ; +9,5] | 2 / 27 / 1 sur 30 | **B plus haut (moins bien)** |
| Alertes ouvertes (toutes) | 181 | 523 | — | +334,5 | [+271 ; +401,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,87 | 0,11 | — | −0,72 | [−0,75 ; −0,70] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Bonheur moyen | 0,97 | 0,81 | — | −0,16 | [−0,16 ; −0,15] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 8 / 0 / 22 sur 30 | non concluant |
| Trésor de l’État le plus bas | 21 277 $ | 83 716 $ | — | +49 687 $ | [+15 173 $ ; +70 114 $] | 24 / 6 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; +638] | 0 / 11 / 19 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; +155,5] | — / — / 15 | non concluant |
| Créances radiées | 0 $ | 24 976 $ | — | +22 380 $ | [+18 623 $ ; +25 703 $] | — / — / 0 | **B plus haut** |
| Filet : Anti-famine / 50 j | 0,02 | 118,91 | 12 → 30 | +112,04 | [+84,71 ; +140,93] | 3 / 27 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plancher de logement / 50 j | 0,00 | 8,59 | 7 → 30 | +7,64 | [+5,77 ; +9,34] | 3 / 27 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 14 | 0,00 | [0,00 ; +5,55] | 1 / 14 / 15 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « renflouement d’entreprise »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,9 % | 23,3 % | 2,8 % | 0,9 % | 0,38 | 0,088 % | 257 (16) | 0,12 | 4 % / 29 % / 68 % | 2 | 0 $ |
| 2 | 8,7 % | 30,0 % | 3,5 % | 0,6 % | 0,35 | 0,068 % | 679 (23) | 0,15 | 3 % / 19 % / 78 % | 4 | 0 $ |
| 3 | 6,3 % | 18,8 % | 1,5 % | 0,2 % | 0,26 | 0,056 % | 360 (14) | 0,11 | 10 % / 26 % / 64 % | 3 | 0 $ |
| 4 | 7,7 % | 24,2 % | 3,2 % | 1,0 % | 0,39 | 0,045 % | 396 (18) | 0,17 | 4 % / 29 % / 68 % | 3 | 0 $ |
| 5 | 8,8 % | 25,0 % | 5,1 % | 1,5 % | 0,48 | 0,057 % | 473 (31) | 0,12 | 10 % / 21 % / 68 % | 3 | 0 $ |
| 6 | 9,2 % | 27,1 % | 4,2 % | 1,6 % | 0,36 | 0,036 % | 685 (26) | 0,16 | 10 % / 21 % / 69 % | 5 | 0 $ |
| 7 | 6,1 % | 22,5 % | 3,5 % | 0,6 % | 0,43 | 0,053 % | 411 (12) | 0,10 | 7 % / 24 % / 69 % | 1 | 0 $ |
| 8 | 6,7 % | 28,7 % | 3,6 % | 1,5 % | 0,40 | 0,067 % | 388 (16) | 0,11 | 3 % / 32 % / 65 % | 2 | 0 $ |
| 9 | 7,4 % | 22,1 % | 3,2 % | 0,5 % | 0,28 | 0,048 % | 464 (18) | 0,11 | 5 % / 22 % / 73 % | 1 | 0 $ |
| 10 | 7,4 % | 24,2 % | 5,7 % | 0,5 % | 0,35 | 0,043 % | 608 (17) | 0,12 | 3 % / 29 % / 67 % | 7 | 0 $ |
| 11 | 7,9 % | 28,7 % | 4,0 % | 0,6 % | 0,33 | 0,083 % | 595 (26) | 0,09 | 11 % / 20 % / 69 % | 2 | 0 $ |
| 12 | 7,5 % | 23,3 % | 5,1 % | 0,7 % | 0,35 | 0,064 % | 437 (18) | 0,11 | 11 % / 26 % / 63 % | 4 | 21 564 $ |
| 13 | 6,5 % | 21,7 % | 1,9 % | 0,7 % | 0,41 | 0,094 % | 367 (12) | 0,13 | 12 % / 18 % / 71 % | 1 | 0 $ |
| 14 | 7,7 % | 23,3 % | 1,5 % | 0,6 % | 0,30 | 0,018 % | 503 (13) | 0,10 | 9 % / 21 % / 70 % | 1 | 0 $ |
| 15 | 8,4 % | 27,9 % | 6,1 % | 1,7 % | 0,44 | 0,081 % | 521 (27) | 0,16 | 3 % / 26 % / 71 % | 2 | 0 $ |
| 16 | 8,4 % | 24,6 % | 5,8 % | 0,4 % | 0,35 | 0,039 % | 648 (27) | 0,16 | 11 % / 18 % / 71 % | 2 | 0 $ |
| 17 | 8,4 % | 25,4 % | 2,7 % | 0,6 % | 0,39 | 0,004 % | 752 (52) | 0,14 | 8 % / 16 % / 76 % | 4 | 0 $ |
| 18 | 8,8 % | 26,3 % | 3,8 % | 0,7 % | 0,35 | 0,061 % | 703 (26) | 0,12 | 4 % / 15 % / 81 % | 1 | 0 $ |
| 19 | 9,5 % | 33,8 % | 5,4 % | 1,1 % | 0,35 | 0,080 % | 647 (19) | 0,17 | 12 % / 24 % / 64 % | 4 | 0 $ |
| 20 | 7,2 % | 23,8 % | 5,3 % | 0,5 % | 0,35 | 0,048 % | 525 (13) | 0,11 | 10 % / 23 % / 67 % | 3 | 0 $ |
| 21 | 8,6 % | 33,3 % | 2,5 % | 0,6 % | 0,35 | 0,061 % | 595 (27) | 0,11 | 11 % / 19 % / 69 % | 4 | 22 415 $ |
| 22 | 6,7 % | 23,3 % | 4,4 % | 0,4 % | 0,37 | 0,075 % | 502 (16) | 0,13 | 7 % / 25 % / 68 % | 1 | 0 $ |
| 23 | 8,8 % | 30,4 % | 4,7 % | 0,8 % | 0,36 | 0,068 % | 671 (21) | 0,11 | 12 % / 21 % / 66 % | 4 | 0 $ |
| 24 | 6,9 % | 27,5 % | 4,0 % | 0,5 % | 0,32 | 0,069 % | 583 (22) | 0,11 | 5 % / 29 % / 67 % | 6 | 18 799 $ |
| 25 | 8,3 % | 24,6 % | 2,0 % | 0,3 % | 0,36 | 0,019 % | 630 (9) | 0,09 | 11 % / 21 % / 69 % | 3 | 0 $ |
| 26 | 7,3 % | 22,5 % | 6,1 % | 0,7 % | 0,39 | 0,041 % | 371 (10) | 0,17 | 2 % / 27 % / 71 % | 5 | 0 $ |
| 27 | 7,3 % | 22,5 % | 5,9 % | 0,9 % | 0,34 | 0,074 % | 533 (16) | 0,15 | 12 % / 18 % / 70 % | 5 | 0 $ |
| 28 | 8,0 % | 30,8 % | 4,7 % | 0,6 % | 0,36 | 0,044 % | 574 (15) | 0,11 | 10 % / 31 % / 59 % | 8 | 0 $ |
| 29 | 8,5 % | 25,0 % | 1,3 % | 0,6 % | 0,32 | 0,028 % | 495 (21) | 0,11 | 12 % / 22 % / 66 % | 4 | 0 $ |
| 30 | 7,6 % | 32,9 % | 0,8 % | 0,3 % | 0,23 | 0,044 % | 426 (15) | 0,11 | 11 % / 20 % / 69 % | 4 | 16 476 $ |

</details>

## 2 bis (3). Avec filets, sauf « Plancher de logement »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,5 % | 3,3 pt (6,5 % – 9,8 %) | 4,8 % – 14,7 % | 7/30 |
| Chômage max | toute la partie | — | 23,3 % | 9,5 pt (18,4 % – 27,9 %) | 14,2 % – 42,1 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,4 pt (0,0 % – 0,4 %) | 0,0 % – 4,9 % | 3/30 |
| Faim max | toute la partie | — | 42,7 % | 63,2 pt (0,0 % – 63,2 %) | 0,0 % – 90,4 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 2,5 % | 2/30 |
| Sans-abri max | toute la partie | — | 23,3 % | 37,6 pt (7,9 % – 45,5 %) | 1,3 % – 80,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,16 | 0,04 (0,15 – 0,19) | 0,13 – 0,33 | 23/30 |
| Gini en fin de partie | dernier jour | — | 0,14 | 0,10 (0,12 – 0,22) | 0,09 – 0,69 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,036 % | 0,040 pt (0,019 % – 0,059 %) | -0,034 % – 0,081 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 33,1 % | 25,2 pt (27,7 % – 52,9 %) | 6,9 % – 86,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 137,7 % | 11,8 pt (133,2 % – 145,0 %) | 99,0 % – 155,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 13 | 8,8 (7,3 – 16) | 3 – 21 | 30/30 |
| … dont après la chauffe | après chauffe | — | 10,5 | 7 (6 – 13) | 1 – 19 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 185,5 | 104,5 (147,3 – 251,8) | 87 – 345 | — |
| Santé moyenne | après chauffe | — | 0,87 | 0,15 (0,73 – 0,88) | 0,23 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,04 (0,94 – 0,98) | 0,85 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 324 | — |
| Trésor de l’État le plus bas | après chauffe | — | 51 190 $ | 71 734 $ (10 252 $ – 81 986 $) | 2 883 $ – 93 662 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 3 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 2 852 $ (0 $ – 2 852 $) | 0 $ – 24 361 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,59 | 7,26 (0,00 – 7,26) | 0,00 – 187,89 | 14/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 30,75 | 7,40 (27,63 – 35,04) | 19,21 – 44,07 | 30/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 9,71 | 1,97 (8,86 – 10,83) | 7,57 – 15,61 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,59 | 0,00 – 7,26 | 0,00 – 187,89 | 14/30 | 11574 | pas de producteur (100 %) |
| Renflouement d’entreprise | 30,75 | 27,63 – 35,04 | 19,21 – 44,07 | 30/30 | 28097 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | coupé | — | — | — | — | — |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Hôpital 8411 · 30, Ferme 3906 · 30, Tourisme 2539 · 26, École 1493 · 30, Bijouterie 1253 · 27, Fonderie 1200 · 30, Pêcherie 1156 · 30, Garage 1083 · 16.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plancher de logement »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,4 % | 7,5 % | 6 → 7 | 0,0 pt | [−0,4 pt ; 0,0 pt] | 11 / 8 / 11 sur 30 | non concluant |
| Chômage max | 22,5 % | 23,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 9 / 8 / 13 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,1 % | 4 → 3 | 0,0 pt | [0,0 pt ; +0,01 pt] | 6 / 10 / 14 sur 30 | non concluant |
| Faim max | 13,5 % | 42,7 % | — | 0,0 pt | [0,0 pt ; +2,1 pt] | 6 / 10 / 14 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 1 → 2 | 0,0 pt | [0,0 pt ; +0,0001 pt] | 8 / 10 / 12 sur 30 | non concluant |
| Sans-abri max | 26,0 % | 23,3 % | — | +0,4 pt | [0,0 pt ; +4,0 pt] | 1 / 16 / 13 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,16 | 23 → 23 | 0,00 | [0,00 ; +0,003] | — / — / 11 | non concluant |
| Gini en fin de partie | 0,15 | 0,14 | — | 0,00 | [0,00 ; +0,01] | — / — / 11 | non concluant |
| Inflation moyenne / j | 0,038 % | 0,036 % | 0 → 0 | 0,000 pt | [−0,006 pt ; 0,000 pt] | — / — / 11 | non concluant |
| |Inflation| max / j | 33,1 % | 33,1 % | — | 0,0 pt | [0,0 pt ; +0,002 pt] | 5 / 10 / 15 sur 30 | non concluant |
| |Inflation sur 100 j| max | 136,4 % | 137,7 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 5 / 8 / 17 sur 30 | non concluant |
| Alertes critiques ouvertes | 10,5 | 13 | 30 → 30 | 0 | [0 ; +1] | 6 / 12 / 12 sur 30 | non concluant |
| … dont après la chauffe | 8,5 | 10,5 | — | 0 | [0 ; +1] | 6 / 12 / 12 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 181 | 185,5 | — | 0 | [0 ; +8] | 7 / 12 / 11 sur 30 | non concluant |
| Santé moyenne | 0,87 | 0,87 | — | 0,00 | [0,00 ; +0,0001] | 11 / 7 / 12 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [0,00 ; +0,0002] | 11 / 8 / 11 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 5 / 1 / 24 sur 30 | non concluant |
| Trésor de l’État le plus bas | 21 277 $ | 51 190 $ | — | 0 $ | [0 $ ; +70 $] | 10 / 6 / 14 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 16 | non concluant |
| Filet : Anti-famine / 50 j | 0,02 | 0,59 | 12 → 14 | 0,00 | [0,00 ; 0,00] | 6 / 9 / 15 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 32,55 | 30,75 | 30 → 30 | 0,00 | [0,00 ; +0,20] | 7 / 12 / 11 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 10,36 | 9,71 | — | 0,00 | [−0,29 ; 0,00] | 12 / 7 / 11 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plancher de logement »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,8 % | 31,3 % | 2,2 % | 2,3 % | 0,31 | 0,039 % | 271 (14) | 0,44 | 5 % / 22 % / 72 % | 2 | 0 $ |
| 2 | 6,2 % | 15,4 % | 0,0 % | 0,0 % | 0,17 | 0,032 % | 134 (13) | 0,88 | 6 % / 14 % / 80 % | 0 | 8 569 $ |
| 3 | 10,6 % | 32,1 % | 4,9 % | 1,2 % | 0,22 | 0,069 % | 269 (16) | 0,66 | 13 % / 26 % / 62 % | 0 | 11 566 $ |
| 4 | 8,1 % | 23,8 % | 0,2 % | 0,0 % | 0,16 | 0,070 % | 169 (17) | 0,88 | 8 % / 12 % / 80 % | 0 | 19 665 $ |
| 5 | 5,2 % | 19,6 % | 0,0 % | 0,0 % | 0,14 | 0,023 % | 187 (13) | 0,88 | 6 % / 12 % / 83 % | 0 | 39 066 $ |
| 6 | 6,4 % | 16,7 % | 0,0 % | 0,0 % | 0,13 | 0,079 % | 124 (8) | 0,88 | 3 % / 17 % / 79 % | 1 | 11 356 $ |
| 7 | 7,1 % | 23,3 % | 0,1 % | 0,0 % | 0,15 | 0,018 % | 187 (7) | 0,88 | 5 % / 16 % / 79 % | 0 | 1 813 $ |
| 8 | 6,7 % | 20,8 % | 0,3 % | 0,0 % | 0,17 | 0,058 % | 203 (15) | 0,87 | 7 % / 12 % / 80 % | 0 | 37 525 $ |
| 9 | 6,4 % | 17,5 % | 0,0 % | 0,0 % | 0,15 | 0,079 % | 135 (6) | 0,88 | 3 % / 18 % / 79 % | 0 | 5 029 $ |
| 10 | 8,1 % | 24,6 % | 0,1 % | 0,0 % | 0,15 | 0,029 % | 154 (8) | 0,87 | 8 % / 13 % / 80 % | 0 | 21 085 $ |
| 11 | 7,4 % | 21,3 % | 0,3 % | 0,0 % | 0,17 | 0,036 % | 211 (17) | 0,87 | 3 % / 17 % / 80 % | 0 | 13 725 $ |
| 12 | 13,9 % | 34,6 % | 1,9 % | 2,5 % | 0,33 | 0,006 % | 299 (20) | 0,65 | 9 % / 19 % / 72 % | 2 | 856 $ |
| 13 | 7,0 % | 23,3 % | 0,0 % | 0,0 % | 0,15 | 0,034 % | 147 (6) | 0,87 | 7 % / 12 % / 81 % | 0 | 8 122 $ |
| 14 | 7,6 % | 15,0 % | 0,1 % | 0,0 % | 0,16 | 0,032 % | 148 (5) | 0,88 | 6 % / 14 % / 80 % | 0 | 0 $ |
| 15 | 8,4 % | 25,4 % | 0,2 % | 0,5 % | 0,16 | 0,056 % | 252 (17) | 0,74 | 11 % / 20 % / 69 % | 2 | 387 $ |
| 16 | 6,7 % | 27,9 % | 0,4 % | 0,1 % | 0,23 | 0,052 % | 286 (16) | 0,23 | 5 % / 25 % / 69 % | 0 | 0 $ |
| 17 | 7,9 % | 19,2 % | 0,0 % | 0,0 % | 0,16 | 0,037 % | 151 (6) | 0,86 | 6 % / 14 % / 81 % | 4 | 0 $ |
| 18 | 12,8 % | 36,3 % | 0,3 % | 0,0 % | 0,19 | 0,010 % | 211 (18) | 0,87 | 6 % / 13 % / 81 % | 0 | 1 464 $ |
| 19 | 11,4 % | 33,8 % | 0,8 % | 0,1 % | 0,23 | -0,011 % | 301 (14) | 0,24 | 11 % / 30 % / 59 % | 2 | 625 $ |
| 20 | 9,6 % | 31,3 % | 0,3 % | 0,1 % | 0,22 | 0,031 % | 318 (10) | 0,32 | 5 % / 15 % / 80 % | 2 | 32 867 $ |
| 21 | 7,4 % | 23,8 % | 0,0 % | 0,1 % | 0,15 | 0,064 % | 179 (11) | 0,86 | 6 % / 12 % / 82 % | 0 | 9 882 $ |
| 22 | 4,8 % | 14,2 % | 0,4 % | 0,0 % | 0,15 | 0,059 % | 184 (17) | 0,87 | 8 % / 12 % / 80 % | 2 | 29 837 $ |
| 23 | 9,8 % | 27,9 % | 0,3 % | 0,0 % | 0,18 | 0,008 % | 219 (13) | 0,68 | 8 % / 15 % / 77 % | 0 | 28 553 $ |
| 24 | 8,3 % | 18,8 % | 2,7 % | 1,6 % | 0,17 | 0,045 % | 251 (15) | 0,73 | 12 % / 20 % / 68 % | 2 | 16 001 $ |
| 25 | 10,2 % | 25,0 % | 0,0 % | 0,0 % | 0,19 | -0,029 % | 175 (3) | 0,88 | 5 % / 14 % / 80 % | 2 | 0 $ |
| 26 | 6,3 % | 14,2 % | 0,0 % | 0,0 % | 0,14 | 0,014 % | 87 (3) | 0,88 | 3 % / 19 % / 78 % | 0 | 27 957 $ |
| 27 | 6,8 % | 18,3 % | 0,0 % | 0,1 % | 0,15 | 0,061 % | 141 (12) | 0,87 | 6 % / 13 % / 81 % | 0 | 29 480 $ |
| 28 | 6,1 % | 18,8 % | 0,0 % | 0,0 % | 0,14 | 0,039 % | 139 (15) | 0,88 | 6 % / 13 % / 81 % | 0 | 4 046 $ |
| 29 | 6,2 % | 15,8 % | 0,0 % | 0,0 % | 0,15 | 0,081 % | 132 (7) | 0,88 | 6 % / 14 % / 80 % | 1 | 44 633 $ |
| 30 | 14,7 % | 42,1 % | 0,8 % | 0,6 % | 0,25 | -0,034 % | 345 (21) | 0,77 | 5 % / 10 % / 85 % | 0 | 3 941 $ |

</details>

## 2 bis (4). Avec filets, sauf « Plafond de dérive des prix et salaires »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,4 % | 3,4 pt (6,4 % – 9,8 %) | 4,8 % – 15,5 % | 6/30 |
| Chômage max | toute la partie | — | 22,5 % | 12,9 pt (18,3 % – 31,3 %) | 14,2 % – 40,4 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,4 pt (0,0 % – 0,4 %) | 0,0 % – 5,3 % | 4/30 |
| Faim max | toute la partie | — | 13,5 % | 60,7 pt (0,0 % – 60,7 %) | 0,0 % – 80,8 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 2,1 % | 1/30 |
| Sans-abri max | toute la partie | — | 26,0 % | 33,8 pt (7,9 % – 41,7 %) | 1,3 % – 58,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,16 | 0,04 (0,15 – 0,19) | 0,12 – 0,24 | 23/30 |
| Gini en fin de partie | dernier jour | — | 0,15 | 0,11 (0,12 – 0,23) | 0,09 – 0,49 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,038 % | 0,039 pt (0,021 % – 0,060 %) | -0,013 % – 0,085 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 33,1 % | 20,1 pt (24,8 % – 44,9 %) | 12,1 % – 86,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 136,4 % | 12,3 pt (130,1 % – 142,4 %) | 94,9 % – 155,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10,5 | 7,8 (7 – 14,8) | 3 – 29 | 30/30 |
| … dont après la chauffe | après chauffe | — | 8,5 | 7,8 (5,3 – 13) | 1 – 25 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 181 | 102 (147,3 – 249,3) | 87 – 423 | — |
| Santé moyenne | après chauffe | — | 0,87 | 0,09 (0,79 – 0,88) | 0,32 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,04 (0,94 – 0,98) | 0,87 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 2,3 (0 – 2,3) | 0 – 467 | — |
| Trésor de l’État le plus bas | après chauffe | — | 21 277 $ | 64 028 $ (6 458 $ – 70 486 $) | 2 732 $ – 98 212 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 13 | — |
| Créances radiées | toute la partie | — | 0 $ | 3 107 $ (0 $ – 3 107 $) | 0 $ – 24 357 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,02 | 6,88 (0,00 – 6,88) | 0,00 – 179,96 | 12/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 32,55 | 5,29 (29,53 – 34,82) | 21,43 – 46,07 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,31 (0,00 – 0,31) | 0,00 – 45,39 | 7/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,46 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 10,36 | 1,96 (9,44 – 11,39) | 7,71 – 13,96 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,02 | 0,00 – 6,88 | 0,00 – 179,96 | 12/30 | 15326 | pas de producteur (100 %) |
| Renflouement d’entreprise | 32,55 | 29,53 – 34,82 | 21,43 – 46,07 | 30/30 | 28757 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 0,31 | 0,00 – 45,39 | 7/30 | 5020 | parc plein (89 %) ; prix trop élevé (11 %) |
| Plafond de dérive des prix et salaires | coupé | — | — | — | — | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,46 | 0/30 | 13 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Hôpital 8684 · 30, Ferme 4407 · 30, Tourisme 2604 · 26, École 1465 · 30, Garage 1290 · 18, Fonderie 1280 · 30, Pétrochimie 1218 · 30, Bijouterie 976 · 25.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plafond de dérive des prix et salaires »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,4 % | 8,4 % | 6 → 6 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 22,5 % | 22,5 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 4 → 4 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 13,5 % | 13,5 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 1 → 1 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 26,0 % | 26,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,16 | 23 → 23 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,15 | 0,15 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,038 % | 0,038 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 33,1 % | 33,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 136,4 % | 136,4 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 10,5 | 10,5 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 8,5 | 8,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 181 | 181 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 0,87 | 0,87 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 21 277 $ | 21 277 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,02 | 0,02 | 12 → 12 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 32,55 | 32,55 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 7 → 7 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 10,36 | 10,36 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plafond de dérive des prix et salaires »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,4 % | 18,8 % | 0,1 % | 0,8 % | 0,19 | 0,075 % | 250 (12) | 0,42 | 10 % / 20 % / 70 % | 5 | 0 $ |
| 2 | 8,0 % | 26,3 % | 0,3 % | 0,0 % | 0,17 | 0,059 % | 233 (14) | 0,86 | 6 % / 12 % / 82 % | 0 | 6 939 $ |
| 3 | 8,8 % | 30,0 % | 2,2 % | 0,6 % | 0,21 | 0,057 % | 254 (15) | 0,66 | 10 % / 20 % / 70 % | 0 | 2 758 $ |
| 4 | 8,5 % | 20,0 % | 0,0 % | 0,0 % | 0,16 | 0,034 % | 158 (10) | 0,88 | 3 % / 18 % / 80 % | 1 | 9 211 $ |
| 5 | 9,5 % | 21,7 % | 0,0 % | 0,0 % | 0,18 | 0,060 % | 140 (8) | 0,84 | 6 % / 10 % / 84 % | 0 | 16 512 $ |
| 6 | 6,4 % | 16,7 % | 0,0 % | 0,0 % | 0,13 | 0,079 % | 124 (8) | 0,88 | 3 % / 17 % / 79 % | 1 | 11 356 $ |
| 7 | 7,1 % | 23,3 % | 0,1 % | 0,0 % | 0,15 | 0,018 % | 187 (7) | 0,88 | 5 % / 16 % / 79 % | 0 | 1 813 $ |
| 8 | 5,9 % | 18,3 % | 0,0 % | 0,0 % | 0,12 | 0,085 % | 130 (7) | 0,88 | 6 % / 15 % / 79 % | 0 | 12 058 $ |
| 9 | 6,4 % | 17,5 % | 0,0 % | 0,0 % | 0,15 | 0,079 % | 135 (6) | 0,88 | 3 % / 18 % / 79 % | 0 | 5 029 $ |
| 10 | 9,4 % | 26,7 % | 0,0 % | 0,0 % | 0,16 | 0,029 % | 149 (7) | 0,87 | 8 % / 14 % / 78 % | 2 | 2 098 $ |
| 11 | 9,0 % | 21,3 % | 0,0 % | 0,0 % | 0,16 | 0,033 % | 179 (13) | 0,87 | 6 % / 13 % / 81 % | 1 | 22 538 $ |
| 12 | 10,2 % | 32,5 % | 1,9 % | 2,1 % | 0,24 | 0,045 % | 423 (16) | 0,61 | 10 % / 14 % / 76 % | 0 | 27 922 $ |
| 13 | 7,0 % | 23,3 % | 0,0 % | 0,0 % | 0,15 | 0,034 % | 147 (6) | 0,87 | 7 % / 12 % / 81 % | 0 | 8 122 $ |
| 14 | 7,6 % | 15,0 % | 0,1 % | 0,0 % | 0,16 | 0,032 % | 148 (5) | 0,88 | 6 % / 14 % / 80 % | 0 | 0 $ |
| 15 | 10,2 % | 25,0 % | 0,3 % | 0,6 % | 0,21 | 0,075 % | 295 (24) | 0,46 | 12 % / 24 % / 65 % | 0 | 5 479 $ |
| 16 | 10,7 % | 33,3 % | 0,8 % | 0,0 % | 0,24 | 0,004 % | 261 (14) | 0,35 | 8 % / 19 % / 72 % | 0 | 0 $ |
| 17 | 7,9 % | 19,2 % | 0,0 % | 0,0 % | 0,16 | 0,037 % | 151 (6) | 0,86 | 6 % / 14 % / 81 % | 4 | 0 $ |
| 18 | 12,8 % | 36,3 % | 0,3 % | 0,0 % | 0,19 | 0,010 % | 211 (18) | 0,87 | 6 % / 13 % / 81 % | 0 | 1 464 $ |
| 19 | 11,6 % | 35,8 % | 0,6 % | 0,0 % | 0,20 | 0,001 % | 188 (11) | 0,86 | 7 % / 14 % / 80 % | 1 | 1 979 $ |
| 20 | 9,5 % | 31,7 % | 0,3 % | 0,1 % | 0,22 | 0,030 % | 327 (10) | 0,32 | 6 % / 18 % / 76 % | 4 | 29 098 $ |
| 21 | 9,9 % | 32,1 % | 2,3 % | 0,6 % | 0,18 | -0,007 % | 291 (21) | 0,80 | 6 % / 19 % / 75 % | 2 | 143 693 $ |
| 22 | 4,8 % | 14,2 % | 0,4 % | 0,0 % | 0,15 | 0,059 % | 184 (17) | 0,87 | 8 % / 12 % / 80 % | 2 | 29 837 $ |
| 23 | 5,5 % | 17,5 % | 0,0 % | 0,0 % | 0,14 | 0,061 % | 159 (9) | 0,87 | 7 % / 14 % / 79 % | 1 | 11 432 $ |
| 24 | 9,9 % | 40,4 % | 5,3 % | 1,6 % | 0,18 | 0,043 % | 247 (14) | 0,73 | 9 % / 13 % / 78 % | 2 | 23 273 $ |
| 25 | 9,6 % | 26,7 % | 0,0 % | 0,0 % | 0,17 | -0,013 % | 183 (8) | 0,84 | 6 % / 17 % / 77 % | 1 | 24 800 $ |
| 26 | 6,3 % | 14,2 % | 0,0 % | 0,0 % | 0,14 | 0,014 % | 87 (3) | 0,88 | 3 % / 19 % / 78 % | 0 | 27 957 $ |
| 27 | 6,2 % | 18,3 % | 0,0 % | 0,1 % | 0,14 | 0,042 % | 157 (14) | 0,87 | 7 % / 13 % / 81 % | 0 | 13 348 $ |
| 28 | 6,1 % | 18,8 % | 0,0 % | 0,0 % | 0,14 | 0,039 % | 139 (15) | 0,88 | 6 % / 13 % / 81 % | 0 | 4 046 $ |
| 29 | 6,2 % | 15,8 % | 0,0 % | 0,0 % | 0,15 | 0,081 % | 132 (7) | 0,88 | 6 % / 14 % / 80 % | 1 | 44 633 $ |
| 30 | 15,5 % | 37,9 % | 3,7 % | 0,9 % | 0,23 | 0,018 % | 250 (29) | 0,79 | 18 % / 21 % / 61 % | 0 | 23 244 $ |

</details>

## 2 bis (5). Avec filets, sauf « Anti-crédit-fou »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,4 % | 3,4 pt (6,4 % – 9,8 %) | 4,8 % – 15,5 % | 6/30 |
| Chômage max | toute la partie | — | 22,5 % | 12,9 pt (18,3 % – 31,3 %) | 14,2 % – 40,4 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,4 pt (0,0 % – 0,4 %) | 0,0 % – 5,3 % | 4/30 |
| Faim max | toute la partie | — | 13,5 % | 60,7 pt (0,0 % – 60,7 %) | 0,0 % – 80,8 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 2,1 % | 1/30 |
| Sans-abri max | toute la partie | — | 26,0 % | 33,8 pt (7,9 % – 41,7 %) | 1,3 % – 58,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,16 | 0,04 (0,15 – 0,19) | 0,12 – 0,26 | 23/30 |
| Gini en fin de partie | dernier jour | — | 0,15 | 0,11 (0,12 – 0,23) | 0,09 – 0,49 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,035 % | 0,039 pt (0,021 % – 0,060 %) | -0,013 % – 0,085 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 33,1 % | 20,1 pt (24,8 % – 44,9 %) | 12,1 % – 86,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 136,4 % | 12,3 pt (130,1 % – 142,4 %) | 94,9 % – 155,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 10,5 | 7,8 (7 – 14,8) | 3 – 29 | 30/30 |
| … dont après la chauffe | après chauffe | — | 8,5 | 7,8 (5,3 – 13) | 1 – 25 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 181 | 102 (147,3 – 249,3) | 87 – 444 | — |
| Santé moyenne | après chauffe | — | 0,87 | 0,09 (0,79 – 0,88) | 0,32 – 0,88 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,04 (0,94 – 0,98) | 0,87 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 2,3 (0 – 2,3) | 0 – 467 | — |
| Trésor de l’État le plus bas | après chauffe | — | 21 277 $ | 64 028 $ (6 458 $ – 70 486 $) | 2 732 $ – 98 212 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 177 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 3 107 $ (0 $ – 3 107 $) | 0 $ – 54 879 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,02 | 6,88 (0,00 – 6,88) | 0,00 – 179,96 | 12/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 32,55 | 5,29 (29,53 – 34,82) | 21,43 – 46,07 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,31 (0,00 – 0,31) | 0,00 – 45,96 | 7/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 10,20 | 1,86 (9,44 – 11,29) | 7,71 – 13,96 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,02 | 0,00 – 6,88 | 0,00 – 179,96 | 12/30 | 15326 | pas de producteur (100 %) |
| Renflouement d’entreprise | 32,55 | 29,53 – 34,82 | 21,43 – 46,07 | 30/30 | 28679 | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0,00 | 0,00 – 0,31 | 0,00 – 45,96 | 7/30 | 5036 | parc plein (89 %) ; prix trop élevé (11 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | coupé | — | — | — | — | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Hôpital 8642 · 30, Ferme 4409 · 30, Tourisme 2618 · 26, École 1465 · 30, Garage 1290 · 18, Fonderie 1276 · 30, Pétrochimie 1189 · 30, Bijouterie 976 · 25.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-crédit-fou »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,4 % | 8,4 % | 6 → 6 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Chômage max | 22,5 % | 22,5 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 4 → 4 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 13,5 % | 13,5 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 1 → 1 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Sans-abri max | 26,0 % | 26,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,16 | 23 → 23 | 0,00 | [0,00 ; 0,00] | — / — / 29 | non concluant |
| Gini en fin de partie | 0,15 | 0,15 | — | 0,00 | [0,00 ; 0,00] | — / — / 29 | non concluant |
| Inflation moyenne / j | 0,038 % | 0,035 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 29 | non concluant |
| |Inflation| max / j | 33,1 % | 33,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 136,4 % | 136,4 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 10,5 | 10,5 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 8,5 | 8,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 181 | 181 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Santé moyenne | 0,87 | 0,87 | — | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 21 277 $ | 21 277 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 1 / 29 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 29 | non concluant |
| Filet : Anti-famine / 50 j | 0,02 | 0,02 | 12 → 12 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 32,55 | 32,55 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 7 → 7 | 0,00 | [0,00 ; 0,00] | 0 / 1 / 29 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 10,36 | 10,20 | — | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-crédit-fou »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,4 % | 18,8 % | 0,1 % | 0,8 % | 0,19 | 0,075 % | 250 (12) | 0,42 | 10 % / 20 % / 70 % | 5 | 0 $ |
| 2 | 8,0 % | 26,3 % | 0,3 % | 0,0 % | 0,17 | 0,059 % | 233 (14) | 0,86 | 6 % / 12 % / 82 % | 0 | 6 939 $ |
| 3 | 8,8 % | 30,0 % | 2,2 % | 0,6 % | 0,21 | 0,057 % | 254 (15) | 0,66 | 10 % / 20 % / 70 % | 0 | 2 758 $ |
| 4 | 8,5 % | 20,0 % | 0,0 % | 0,0 % | 0,16 | 0,034 % | 158 (10) | 0,88 | 3 % / 18 % / 80 % | 1 | 9 211 $ |
| 5 | 9,5 % | 21,7 % | 0,0 % | 0,0 % | 0,18 | 0,060 % | 140 (8) | 0,84 | 6 % / 10 % / 84 % | 0 | 16 512 $ |
| 6 | 6,4 % | 16,7 % | 0,0 % | 0,0 % | 0,13 | 0,079 % | 124 (8) | 0,88 | 3 % / 17 % / 79 % | 1 | 11 356 $ |
| 7 | 7,1 % | 23,3 % | 0,1 % | 0,0 % | 0,15 | 0,018 % | 187 (7) | 0,88 | 5 % / 16 % / 79 % | 0 | 1 813 $ |
| 8 | 5,9 % | 18,3 % | 0,0 % | 0,0 % | 0,12 | 0,085 % | 130 (7) | 0,88 | 6 % / 15 % / 79 % | 0 | 12 058 $ |
| 9 | 6,4 % | 17,5 % | 0,0 % | 0,0 % | 0,15 | 0,079 % | 135 (6) | 0,88 | 3 % / 18 % / 79 % | 0 | 5 029 $ |
| 10 | 9,4 % | 26,7 % | 0,0 % | 0,0 % | 0,16 | 0,029 % | 149 (7) | 0,87 | 8 % / 14 % / 78 % | 2 | 2 098 $ |
| 11 | 9,0 % | 21,3 % | 0,0 % | 0,0 % | 0,16 | 0,033 % | 179 (13) | 0,87 | 6 % / 13 % / 81 % | 1 | 22 538 $ |
| 12 | 11,6 % | 32,5 % | 1,9 % | 2,1 % | 0,26 | 0,032 % | 444 (16) | 0,66 | 5 % / 11 % / 84 % | 0 | 2 193 $ |
| 13 | 7,0 % | 23,3 % | 0,0 % | 0,0 % | 0,15 | 0,034 % | 147 (6) | 0,87 | 7 % / 12 % / 81 % | 0 | 8 122 $ |
| 14 | 7,6 % | 15,0 % | 0,1 % | 0,0 % | 0,16 | 0,032 % | 148 (5) | 0,88 | 6 % / 14 % / 80 % | 0 | 0 $ |
| 15 | 10,2 % | 25,0 % | 0,3 % | 0,6 % | 0,21 | 0,075 % | 295 (24) | 0,46 | 12 % / 24 % / 65 % | 0 | 5 479 $ |
| 16 | 10,7 % | 33,3 % | 0,8 % | 0,0 % | 0,24 | 0,004 % | 261 (14) | 0,35 | 8 % / 19 % / 72 % | 0 | 0 $ |
| 17 | 7,9 % | 19,2 % | 0,0 % | 0,0 % | 0,16 | 0,037 % | 151 (6) | 0,86 | 6 % / 14 % / 81 % | 4 | 0 $ |
| 18 | 12,8 % | 36,3 % | 0,3 % | 0,0 % | 0,19 | 0,010 % | 211 (18) | 0,87 | 6 % / 13 % / 81 % | 0 | 1 464 $ |
| 19 | 11,6 % | 35,8 % | 0,6 % | 0,0 % | 0,20 | 0,001 % | 188 (11) | 0,86 | 7 % / 14 % / 80 % | 1 | 1 979 $ |
| 20 | 9,5 % | 31,7 % | 0,3 % | 0,1 % | 0,22 | 0,030 % | 327 (10) | 0,32 | 6 % / 18 % / 76 % | 4 | 29 098 $ |
| 21 | 9,9 % | 32,1 % | 2,3 % | 0,6 % | 0,18 | -0,007 % | 291 (21) | 0,80 | 6 % / 19 % / 75 % | 2 | 143 693 $ |
| 22 | 4,8 % | 14,2 % | 0,4 % | 0,0 % | 0,15 | 0,059 % | 184 (17) | 0,87 | 8 % / 12 % / 80 % | 2 | 29 837 $ |
| 23 | 5,5 % | 17,5 % | 0,0 % | 0,0 % | 0,14 | 0,061 % | 159 (9) | 0,87 | 7 % / 14 % / 79 % | 1 | 11 432 $ |
| 24 | 9,9 % | 40,4 % | 5,3 % | 1,6 % | 0,18 | 0,043 % | 247 (14) | 0,73 | 9 % / 13 % / 78 % | 2 | 23 273 $ |
| 25 | 9,6 % | 26,7 % | 0,0 % | 0,0 % | 0,17 | -0,013 % | 183 (8) | 0,84 | 6 % / 17 % / 77 % | 1 | 24 800 $ |
| 26 | 6,3 % | 14,2 % | 0,0 % | 0,0 % | 0,14 | 0,014 % | 87 (3) | 0,88 | 3 % / 19 % / 78 % | 0 | 27 957 $ |
| 27 | 6,2 % | 18,3 % | 0,0 % | 0,1 % | 0,14 | 0,042 % | 157 (14) | 0,87 | 7 % / 13 % / 81 % | 0 | 13 348 $ |
| 28 | 6,1 % | 18,8 % | 0,0 % | 0,0 % | 0,14 | 0,039 % | 139 (15) | 0,88 | 6 % / 13 % / 81 % | 0 | 4 046 $ |
| 29 | 6,2 % | 15,8 % | 0,0 % | 0,0 % | 0,15 | 0,081 % | 132 (7) | 0,88 | 6 % / 14 % / 80 % | 1 | 44 633 $ |
| 30 | 15,5 % | 37,9 % | 3,7 % | 0,9 % | 0,23 | 0,018 % | 250 (29) | 0,79 | 18 % / 21 % / 61 % | 0 | 23 244 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 30/30 : g1 17, g2 23, g3 18, g4 21, g5 30, g6 33, g7 17, g8 32, … |
| Chômage moyen ≤ 10 % | ❌ | 3/30 : g2 72,6 %, g12 22,2 %, g24 23,2 % |
| Faim et sans-abri < 2 % | ❌ | 28/30 : g2, g3, g4, g5, g6, g7, g8, g9, g10, g11, … |
| Gini 0,2–0,45 | ❌ | 3/30 : g2 0,79, g12 0,45, g24 0,49 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 30 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 30 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 12/30 graines ; Renflouement d’entreprise : 30/30 graines ; Plancher de logement : 7/30 graines |

### Critère de l’institution : avec filets, sauf « anti-famine »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-famine » : chômage moyen ≤ 10 % | ❌ | 7/30 : g3 15,8 %, g12 13,3 %, g18 12,6 %, g19 18,1 %, g21 11,8 %, g24 10,9 %, g30 14,6 % |
| Sans « Anti-famine » : faim et sans-abri < 2 % | ❌ | 6/30 : g3, g4, g12, g19, g21, g24 |
| Sans « Anti-famine » : aucune alerte critique | ❌ | 30/30 : g1 12, g2 16, g3 25, g4 17, g5 8, g6 8, g7 7, g8 7, … |

### Critère de l’institution : avec filets, sauf « renflouement d’entreprise »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Renflouement d’entreprise » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Renflouement d’entreprise » : faim et sans-abri < 2 % | ❌ | 24/30 : g1, g2, g4, g5, g6, g7, g8, g9, g10, g11, … |
| Sans « Renflouement d’entreprise » : aucune alerte critique | ❌ | 30/30 : g1 16, g2 23, g3 14, g4 18, g5 31, g6 26, g7 12, g8 16, … |

### Critère de l’institution : avec filets, sauf « plancher de logement »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plancher de logement » : chômage moyen ≤ 10 % | ❌ | 7/30 : g1 11,8 %, g3 10,6 %, g12 13,9 %, g18 12,8 %, g19 11,4 %, g25 10,2 %, g30 14,7 % |
| Sans « Plancher de logement » : faim et sans-abri < 2 % | ❌ | 4/30 : g1, g3, g12, g24 |
| Sans « Plancher de logement » : aucune alerte critique | ❌ | 30/30 : g1 14, g2 13, g3 16, g4 17, g5 13, g6 8, g7 7, g8 15, … |

### Critère de l’institution : avec filets, sauf « plafond de dérive des prix et salaires »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plafond de dérive des prix et salaires » : chômage moyen ≤ 10 % | ❌ | 6/30 : g12 10,2 %, g15 10,2 %, g16 10,7 %, g18 12,8 %, g19 11,6 %, g30 15,5 % |
| Sans « Plafond de dérive des prix et salaires » : faim et sans-abri < 2 % | ❌ | 5/30 : g3, g12, g21, g24, g30 |
| Sans « Plafond de dérive des prix et salaires » : aucune alerte critique | ❌ | 30/30 : g1 12, g2 14, g3 15, g4 10, g5 8, g6 8, g7 7, g8 7, … |

### Critère de l’institution : avec filets, sauf « anti-crédit-fou »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-crédit-fou » : chômage moyen ≤ 10 % | ❌ | 6/30 : g12 11,6 %, g15 10,2 %, g16 10,7 %, g18 12,8 %, g19 11,6 %, g30 15,5 % |
| Sans « Anti-crédit-fou » : faim et sans-abri < 2 % | ❌ | 5/30 : g3, g12, g21, g24, g30 |
| Sans « Anti-crédit-fou » : aucune alerte critique | ❌ | 30/30 : g1 12, g2 14, g3 15, g4 10, g5 8, g6 8, g7 7, g8 7, … |

