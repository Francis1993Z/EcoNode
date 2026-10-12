# Protocole de stabilité ÉcoNodes

- Date : 2026-10-12 10:28
- Graines : 1 à 6 (6) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Bâtiments, construction et hypothèques
- Paramètres changés : population = 240
- Temps total : 15 s pour 12 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,4 % | 3,0 pt (7,4 % – 10,4 %) | 6,7 % – 16,3 % | 2/6 |
| Chômage max | toute la partie | — | 28,1 % | 6,6 pt (26,9 % – 33,4 %) | 20,8 % – 62,1 % | — |
| Faim moyenne | après chauffe | < 2 % | 7,5 % | 4,3 pt (6,0 % – 10,3 %) | 1,3 % – 11,3 % | 5/6 |
| Faim max | toute la partie | — | 95,4 % | 0,9 pt (95,1 % – 96,0 %) | 87,9 % – 96,7 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 1,7 % | 1,3 pt (1,5 % – 2,8 %) | 1,1 % – 6,7 % | 2/6 |
| Sans-abri max | toute la partie | — | 41,3 % | 17,7 pt (36,8 % – 54,5 %) | 31,7 % – 80,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,36 | 0,05 (0,34 – 0,39) | 0,33 – 0,44 | 0/6 |
| Gini en fin de partie | dernier jour | — | 0,50 | 0,34 (0,38 – 0,72) | 0,19 – 0,89 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,064 % | 0,021 pt (0,058 % – 0,079 %) | 0,052 % – 0,090 % | 0/6 |
| |Inflation| max / j | toute la partie | — | 31,3 % | 21,5 pt (28,2 % – 49,8 %) | 12,9 % – 56,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 142,1 % | 23,9 pt (129,6 % – 153,5 %) | 115,2 % – 201,0 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 28,5 | 7,3 (24,5 – 31,8) | 12 – 32 | 6/6 |
| … dont après la chauffe | après chauffe | — | 26,5 | 6 (22,8 – 28,8) | 11 – 31 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 1550 | 206,3 (1409 – 1615,3) | 1261 – 2117 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 568 | 78,5 (528 – 606,5) | 216 – 629 | — |
| Santé moyenne | après chauffe | — | 0,18 | 0,04 (0,16 – 0,20) | 0,14 – 0,24 | — |
| Naissances d’entreprises / an | toute la partie | — | 30,4 | 6,8 (27,9 – 34,6) | 7,8 – 35,5 | — |
| Morts d’entreprises / an | toute la partie | — | 33,8 | 6,1 (31,2 – 37,4) | 12,4 – 37,7 | — |
| Entonnoir : projets envisagés | toute la partie | — | 17724,5 | 1824 (16403 – 18227) | 12915 – 19141 | — |
| Entonnoir : créations | toute la partie | — | 125 | 27,8 (114,5 – 142,3) | 32 – 146 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 832 | 205,8 (723,5 – 929,3) | 178 – 996 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 6215 | 1134,8 (5617,3 – 6752) | 1692 – 6921 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 1771 | 592,5 (1230,3 – 1822,8) | 1051 – 1924 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 1581,5 | 202,5 (1489,3 – 1691,8) | 1111 – 1823 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 565 | 495 (375,3 – 870,3) | 329 – 1241 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 5985,5 | 1468,3 (5075,5 – 6543,8) | 4395 – 6803 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 844,5 | 776 (628,3 – 1404,3) | 487 – 1627 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 13,5 | 3,3 (12,3 – 15,5) | 11 – 20 | — |
| Machines en fin | dernier jour | — | 0,3 | 0,4 (0,1 – 0,5) | 0,1 – 0,6 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 1 | 0 (1 – 1) | 0 – 2 | — |
| Bonheur moyen | après chauffe | — | 0,81 | 0,03 (0,80 – 0,83) | 0,76 – 0,84 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 533,4 | 137,6 (424,5 – 562,0) | 383,1 – 580,8 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 219 | — |
| Trésor de l’État le plus bas | après chauffe | — | 52 861 $ | 73 835 $ (18 688 $ – 92 523 $) | 2 931 $ – 100 260 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 8 | — |
| Créances radiées | toute la partie | — | 17 963 $ | 2 266 $ (16 117 $ – 18 382 $) | 15 162 $ – 25 367 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/6 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 2/6 | 0 | 0 – 0,8 | 0 – 1 | 0 j |
| Faim répandue | critique | 6/6 | 7,5 | 6,3 – 8,8 | 1 – 9 | 164 j |
| Sans-abri nombreux | critique | 6/6 | 10,5 | 9,3 – 11 | 3 – 12 | 98 j |
| Inégalités hors bornes | attention | 6/6 | 3,5 | 3 – 4 | 2 – 5 | 150 j |
| Richesse médiane hors bornes | attention | 3/6 | 0,5 | 0 – 1,8 | 0 – 2 | 1 j |
| Inflation quotidienne | critique | 6/6 | 7 | 4,8 – 8,5 | 4 – 12 | 7 j |
| Inflation sur 100 jours | critique | 6/6 | 1,5 | 1 – 2 | 1 – 3 | 32,5 j |
| Rupture de stock prolongée | attention | 6/6 | 149,5 | 132,8 – 161,8 | 46 – 167 | 5464,5 j |
| Surstock | attention | 6/6 | 40,5 | 34,3 – 44,5 | 24 – 47 | 1260 j |
| Entreprise sans employé | attention | 6/6 | 146,5 | 135,5 – 159 | 53 – 164 | 2029,5 j |
| Entreprise sans client | attention | 6/6 | 168 | 148,5 – 180 | 58 – 195 | 5677,5 j |
| Santé de la population effondrée | critique | 6/6 | 1 | 1 – 1 | 1 – 1 | 1178,5 j |
| Productivité du travail effondrée | attention | 6/6 | 1 | 1 – 1 | 1 – 1 | 1177,5 j |
| Pénurie de main-d’œuvre | attention | 1/6 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Embauches bloquées faute de moyens | attention | 6/6 | 8 | 6,5 – 8 | 4 – 9 | 306 j |
| Prix aberrant | attention | 6/6 | 21 | 16,8 – 23 | 13 – 25 | 2206 j |
| Attente trop longue (service public) | attention | 6/6 | 1 | 1 – 1 | 1 – 2 | 1298 j |
| Prestations réduites faute de trésor | attention | 1/6 | 0 | 0 – 0 | 0 – 1 | 0 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 10,9 % | 35,0 % | 5,6 % | 1,1 % | 0,33 | 0,090 % | 564 (32) | 0,24 | 10 % / 26 % / 65 % | 4 | 0 $ |
| 2 | 7,2 % | 26,7 % | 11,1 % | 3,2 % | 0,44 | 0,066 % | 516 (31) | 0,15 | 5 % / 31 % / 64 % | 4 | 9 770 $ |
| 3 | 7,9 % | 27,5 % | 7,3 % | 1,6 % | 0,35 | 0,052 % | 629 (26) | 0,14 | 9 % / 21 % / 70 % | 1 | 239 $ |
| 4 | 8,9 % | 28,7 % | 7,8 % | 1,5 % | 0,34 | 0,057 % | 618 (32) | 0,17 | 10 % / 24 % / 66 % | 6 | 1 088 $ |
| 5 | 16,3 % | 62,1 % | 11,3 % | 6,7 % | 0,40 | 0,062 % | 572 (24) | 0,20 | 15 % / 27 % / 58 % | 3 | 17 106 $ |
| 6 | 6,7 % | 20,8 % | 1,3 % | 1,8 % | 0,37 | 0,083 % | 216 (12) | 0,19 | 8 % / 22 % / 70 % | 1 | 46 178 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 7,8 % | 2,4 pt (7,5 % – 9,9 %) | 4,8 % – 11,4 % | 2/6 |
| Chômage max | toute la partie | — | 23,1 % | 7,7 pt (18,3 % – 26,0 %) | 16,3 % – 29,6 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 0,6 % | 0/6 |
| Faim max | toute la partie | — | 53,3 % | 51,9 pt (11,8 % – 63,6 %) | 0,0 % – 79,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,1 % | 0,2 pt (0,0 % – 0,2 %) | 0,0 % – 1,4 % | 0/6 |
| Sans-abri max | toute la partie | — | 14,0 % | 28,0 pt (5,7 % – 33,8 %) | 3,8 % – 64,6 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,21 | 0,04 (0,18 – 0,22) | 0,15 – 0,36 | 2/6 |
| Gini en fin de partie | dernier jour | — | 0,22 | 0,10 (0,16 – 0,25) | 0,13 – 0,39 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,029 % | 0,027 pt (0,025 % – 0,052 %) | 0,001 % – 0,102 % | 0/6 |
| |Inflation| max / j | toute la partie | — | 45,5 % | 9,8 pt (38,3 % – 48,1 %) | 28,6 % – 90,4 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 141,0 % | 19,9 pt (131,8 % – 151,7 %) | 124,2 % – 228,1 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 9,5 | 5,8 (7 – 12,8) | 7 – 20 | 6/6 |
| … dont après la chauffe | après chauffe | — | 8 | 5,5 (5,3 – 10,8) | 5 – 16 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 85 | 87,8 (49,8 – 137,5) | 29 – 436 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 131 | 21,8 (126,5 – 148,3) | 118 – 269 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,0001 (0,88 – 0,88) | 0,71 – 0,88 | — |
| Naissances d’entreprises / an | toute la partie | — | 3,3 | 1,3 (2,6 – 3,8) | 2,2 – 6,6 | — |
| Morts d’entreprises / an | toute la partie | — | 5,6 | 0,7 (5,2 – 5,8) | 4,4 – 9,2 | — |
| Entonnoir : projets envisagés | toute la partie | — | 8179,5 | 896,5 (7792,8 – 8689,3) | 7491 – 10829 | — |
| Entonnoir : créations | toute la partie | — | 13,5 | 5,3 (10,5 – 15,8) | 9 – 27 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 44 | 20,5 (33,8 – 54,3) | 24 – 140 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 591 | 294,5 (387,5 – 682) | 301 – 1147 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 1403 | 592,5 (1055 – 1647,5) | 862 – 2256 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 2296 | 891,3 (1649 – 2540,3) | 1090 – 2563 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 281,5 | 374,8 (82,5 – 457,3) | 13 – 587 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 4175,5 | 1087,5 (3460 – 4547,5) | 3232 – 4698 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 350 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 20 | 2,8 (18,3 – 21) | 18 – 22 | — |
| Machines en fin | dernier jour | — | 4,1 | 1,4 (2,9 – 4,3) | 0,8 – 4,4 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 3 | 0,8 (3 – 3,8) | 1 – 4 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,004 (0,97 – 0,97) | 0,93 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,3 | 0,02 (0,3 – 0,3) | 0,3 – 46,1 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 37 917 $ | 40 117 $ (18 081 $ – 58 198 $) | 15 282 $ – 87 776 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,54 | 1,11 (0,04 – 1,14) | 0,00 – 8,86 | 2/6 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 13,88 | 10,53 (9,54 – 20,06) | 7,96 – 21,79 | 6/6 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,54 | 5,65 (0,00 – 5,65) | 0,00 – 39,89 | 3/6 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/6 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/6 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/6 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,54 | 0,04 – 1,14 | 0,00 – 8,86 | 2/6 | 314 | pas de producteur (100 %) |
| Renflouement d’entreprise | 13,88 | 9,54 – 20,06 | 7,96 – 21,79 | 6/6 | 2716 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0,54 | 0,00 – 5,65 | 0,00 – 39,89 | 3/6 | 2114 | parc plein (57 %) ; prix trop élevé (43 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/6 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/6 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 6 graines · graines touchées) : Ferme 1136 · 6, Bijouterie 398 · 6, Mine de fer 182 · 6, Fonderie 131 · 6, Tourisme 131 · 3, Pêcherie 108 · 6, Mine de bauxite 44 · 6, Mine de cuivre 43 · 6.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,4 % | 26,7 % | 0,1 % | 0,2 % | 0,36 | 0,032 % | 154 (13) | 0,88 | 7 % / 12 % / 81 % | 2 | 0 $ |
| 2 | 7,9 % | 24,2 % | 0,1 % | 0,0 % | 0,20 | 0,001 % | 125 (7) | 0,88 | 4 % / 19 % / 78 % | 0 | 6 001 $ |
| 3 | 7,4 % | 17,1 % | 0,1 % | 0,2 % | 0,21 | 0,024 % | 131 (7) | 0,88 | 7 % / 15 % / 78 % | 1 | 3 202 $ |
| 4 | 10,5 % | 29,6 % | 0,6 % | 1,4 % | 0,22 | 0,058 % | 269 (20) | 0,71 | 17 % / 21 % / 63 % | 0 | 21 154 $ |
| 5 | 7,7 % | 22,1 % | 0,0 % | 0,0 % | 0,17 | 0,102 % | 118 (7) | 0,88 | 6 % / 13 % / 81 % | 1 | 11 142 $ |
| 6 | 4,8 % | 16,3 % | 0,0 % | 0,0 % | 0,15 | 0,026 % | 131 (12) | 0,88 | 7 % / 13 % / 80 % | 0 | 12 657 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 6/6 : g1 32, g2 31, g3 26, g4 32, g5 24, g6 12 |
| Chômage moyen ≤ 10 % | ❌ | 2/6 : g1 10,9 %, g5 16,3 % |
| Faim et sans-abri < 2 % | ❌ | 5/6 : g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ✅ | aucune graine sur 6 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 6 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 6 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 2/6 graines ; Renflouement d’entreprise : 6/6 graines ; Plancher de logement : 3/6 graines |

