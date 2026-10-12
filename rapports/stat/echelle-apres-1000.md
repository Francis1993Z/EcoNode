# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 21:26
- Graines : 1 à 10 (10) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : aucun
- Paramètres changés : population = 1000
- Temps total : 2 min 16 s pour 20 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 15,8 % | 5,3 pt (14,4 % – 19,6 %) | 9,3 % – 25,5 % | 9/10 |
| Chômage max | toute la partie | — | 38,1 % | 5,2 pt (35,4 % – 40,5 %) | 26,9 % – 54,3 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,3 % | 0,9 pt (0,0 % – 0,9 %) | 0,0 % – 1,7 % | 0/10 |
| Faim max | toute la partie | — | 41,3 % | 51,2 pt (21,7 % – 72,9 %) | 12,0 % – 94,8 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 3,4 % | 1,8 pt (1,9 % – 3,7 %) | 0,9 % – 11,0 % | 7/10 |
| Sans-abri max | toute la partie | — | 61,8 % | 13,6 pt (57,5 % – 71,1 %) | 41,9 % – 78,1 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,44 | 0,06 (0,40 – 0,46) | 0,36 – 0,53 | 4/10 |
| Gini en fin de partie | dernier jour | — | 0,52 | 0,09 (0,48 – 0,57) | 0,39 – 0,63 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,076 % | 0,028 pt (-0,085 % – -0,057 %) | -0,089 % – 0,034 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 36,7 % | 43,4 pt (21,5 % – 65,0 %) | 12,4 % – 79,3 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 149,5 % | 9,0 pt (142,0 % – 151,0 %) | 136,8 % – 153,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 24,5 | 16,5 (18,8 – 35,3) | 15 – 44 | 10/10 |
| … dont après la chauffe | après chauffe | — | 20,5 | 16,8 (14 – 30,8) | 11 – 40 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 731,5 | 726 (442,8 – 1168,8) | 164 – 1805 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 868 | 86,3 (808 – 894,3) | 741 – 962 | — |
| Santé moyenne | après chauffe | — | 0,78 | 0,15 (0,69 – 0,84) | 0,52 – 0,88 | — |
| Naissances d’entreprises / an | toute la partie | — | 17,3 | 4,0 (15,0 – 18,9) | 11,7 – 21,7 | — |
| Morts d’entreprises / an | toute la partie | — | 36,1 | 3,3 (34,6 – 37,8) | 31,4 – 40,1 | — |
| Entonnoir : projets envisagés | toute la partie | — | 11843,5 | 2228,8 (11290,5 – 13519,3) | 10606 – 14733 | — |
| Entonnoir : créations | toute la partie | — | 71 | 16,3 (61,5 – 77,8) | 48 – 89 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 445,5 | 118 (370 – 488) | 303 – 588 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 3117,5 | 767,5 (2604,8 – 3372,3) | 2047 – 4064 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 4264,5 | 488,5 (3980 – 4468,5) | 3559 – 4722 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 2658,5 | 228,8 (2619,3 – 2848) | 2168 – 3208 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 1,5 | 2 (0 – 2) | 0 – 22 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 1505,5 | 1548 (1144 – 2692) | 613 – 2954 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 57,5 | 65 (23,8 – 88,8) | 0 – 672 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 27,5 | 3,8 (25 – 28,8) | 24 – 31 | — |
| Machines en fin | dernier jour | — | 696,2 | 683,0 (161,2 – 844,2) | 5,9 – 1202,0 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 7,5 | 1,8 (7 – 8,8) | 4 – 10 | — |
| Bonheur moyen | après chauffe | — | 0,92 | 0,05 (0,90 – 0,95) | 0,82 – 0,97 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 33,2 | 63,7 (11,2 – 75,0) | 0,2 – 179,1 | — |
| Jours de prestations réduites | après chauffe | — | 58,5 | 97 (13,5 – 110,5) | 0 – 322 | — |
| Trésor de l’État le plus bas | après chauffe | — | 18 800 $ | 3 251 $ (17 313 $ – 20 564 $) | 13 648 $ – 241 853 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 40,5 (0 – 40,5) | 0 – 589 | — |
| Prêts refusés | toute la partie | — | 31,5 | 144,8 (0 – 144,8) | 0 – 460 | — |
| Créances radiées | toute la partie | — | 109 068 $ | 10 296 $ (99 944 $ – 110 239 $) | 66 888 $ – 117 869 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 9/10 | 2,5 | 1 – 3,8 | 0 – 4 | 74,5 j |
| Faim répandue | critique | 10/10 | 2,5 | 1,3 – 3 | 1 – 6 | 30 j |
| Sans-abri nombreux | critique | 10/10 | 9 | 6 – 13,8 | 4 – 19 | 377 j |
| Inégalités hors bornes | attention | 8/10 | 2 | 1 – 3,8 | 0 – 4 | 240 j |
| Richesse médiane hors bornes | attention | 1/10 | 0 | 0 – 0 | 0 – 2 | 0 j |
| Inflation quotidienne | critique | 10/10 | 7,5 | 4,3 – 13,8 | 3 – 16 | 7,5 j |
| Inflation sur 100 jours | critique | 10/10 | 1,5 | 1 – 2 | 1 – 3 | 30,5 j |
| Rupture de stock prolongée | attention | 10/10 | 125,5 | 116,3 – 134 | 92 – 149 | 2868,5 j |
| Surstock | attention | 10/10 | 133 | 130,3 – 141,8 | 128 – 160 | 6181,5 j |
| Entreprise sans employé | attention | 10/10 | 192,5 | 175,3 – 200,8 | 161 – 212 | 3291 j |
| Entreprise sans client | attention | 10/10 | 341,5 | 333 – 348 | 310 – 357 | 10306,5 j |
| Caisse insolvable | attention | 3/10 | 0 | 0 – 0,8 | 0 – 1 | 0 j |
| Santé de la population effondrée | critique | 8/10 | 1 | 1 – 1 | 0 – 2 | 169,5 j |
| Productivité du travail effondrée | attention | 8/10 | 1 | 1 – 1 | 0 – 2 | 172 j |
| Pénurie de main-d’œuvre | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 16 j |
| Embauches bloquées faute de moyens | attention | 10/10 | 4 | 2,3 – 4,8 | 1 – 8 | 151,5 j |
| Prix aberrant | attention | 10/10 | 27,5 | 18,3 – 29,8 | 10 – 46 | 4332 j |
| Attente trop longue (service public) | attention | 8/10 | 2 | 2 – 3,8 | 0 – 5 | 469,5 j |
| Prestations réduites faute de trésor | attention | 8/10 | 1,5 | 1 – 2 | 0 – 4 | 58,5 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 15,0 % | 38,3 % | 0,6 % | 1,3 % | 0,39 | -0,072 % | 880 (27) | 0,82 | 5 % / 15 % / 80 % | 0 | 0 $ |
| 2 | 16,6 % | 43,3 % | 1,7 % | 3,7 % | 0,46 | -0,084 % | 856 (24) | 0,76 | 5 % / 12 % / 83 % | 1 | 18 090 $ |
| 3 | 18,5 % | 38,9 % | 0,0 % | 7,2 % | 0,45 | -0,052 % | 806 (18) | 0,68 | 6 % / 12 % / 82 % | 0 | 3 073 $ |
| 4 | 11,5 % | 32,5 % | 0,0 % | 2,5 % | 0,36 | -0,052 % | 741 (15) | 0,88 | 5 % / 10 % / 85 % | 1 | 9 026 $ |
| 5 | 25,5 % | 54,3 % | 1,3 % | 11,0 % | 0,53 | -0,086 % | 897 (25) | 0,56 | 7 % / 19 % / 74 % | 4 | 0 $ |
| 6 | 20,0 % | 37,9 % | 0,8 % | 1,7 % | 0,48 | -0,089 % | 962 (44) | 0,73 | 7 % / 18 % / 75 % | 3 | 14 799 $ |
| 7 | 14,6 % | 36,2 % | 0,0 % | 3,6 % | 0,45 | -0,076 % | 802 (16) | 0,85 | 3 % / 11 % / 85 % | 6 | 11 109 $ |
| 8 | 20,6 % | 41,1 % | 1,0 % | 3,2 % | 0,41 | -0,076 % | 905 (39) | 0,79 | 7 % / 19 % / 74 % | 3 | 0 $ |
| 9 | 14,3 % | 35,1 % | 0,0 % | 3,6 % | 0,38 | -0,088 % | 886 (38) | 0,52 | 7 % / 15 % / 78 % | 0 | 23 011 $ |
| 10 | 9,3 % | 26,9 % | 0,0 % | 0,9 % | 0,44 | 0,034 % | 814 (21) | 0,88 | 4 % / 8 % / 88 % | 0 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 22,5 % | 3,5 pt (21,0 % – 24,5 %) | 14,7 % – 38,9 % | 10/10 |
| Chômage max | toute la partie | — | 43,3 % | 10,4 pt (39,4 % – 49,8 %) | 33,6 % – 75,8 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,3 % | 0,7 pt (0,0 % – 0,7 %) | 0,0 % – 13,9 % | 2/10 |
| Faim max | toute la partie | — | 37,4 % | 48,4 pt (12,4 % – 60,9 %) | 7,4 % – 88,1 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 2,1 % | 7,4 pt (0,7 % – 8,1 %) | 0,0 % – 17,3 % | 5/10 |
| Sans-abri max | toute la partie | — | 54,2 % | 6,7 pt (51,2 % – 57,9 %) | 44,5 % – 63,1 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,41 | 0,11 (0,36 – 0,47) | 0,35 – 0,62 | 4/10 |
| Gini en fin de partie | dernier jour | — | 0,46 | 0,24 (0,41 – 0,65) | 0,33 – 0,86 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,075 % | 0,067 pt (-0,081 % – -0,014 %) | -0,101 % – 0,047 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 50,2 % | 34,1 pt (37,0 % – 71,1 %) | 22,1 % – 86,3 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 147,3 % | 13,5 pt (146,2 % – 159,6 %) | 140,5 % – 187,9 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 23,5 | 10,5 (22,3 – 32,8) | 17 – 68 | 10/10 |
| … dont après la chauffe | après chauffe | — | 20 | 11,3 (16,5 – 27,8) | 13 – 63 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 1017 | 1233,3 (484 – 1717,3) | 132 – 2605 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 724,5 | 74,5 (685,3 – 759,8) | 633 – 854 | — |
| Santé moyenne | après chauffe | — | 0,68 | 0,22 (0,55 – 0,77) | 0,48 – 0,87 | — |
| Naissances d’entreprises / an | toute la partie | — | 6,4 | 1,8 (5,9 – 7,7) | 4,6 – 9,7 | — |
| Morts d’entreprises / an | toute la partie | — | 25,8 | 1,5 (24,7 – 26,2) | 24,1 – 27,5 | — |
| Entonnoir : projets envisagés | toute la partie | — | 10043 | 1458,3 (9795,3 – 11253,5) | 8651 – 12127 | — |
| Entonnoir : créations | toute la partie | — | 26,5 | 7,3 (24,3 – 31,5) | 19 – 40 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 141 | 41,8 (128,5 – 170,3) | 120 – 245 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 1031,5 | 294,3 (966,3 – 1260,5) | 806 – 1766 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 5021 | 558,3 (4734,3 – 5292,5) | 4409 – 5965 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 2084 | 384 (1832,5 – 2216,5) | 1019 – 3072 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 59 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 2200 | 1291 (1250,3 – 2541,3) | 975 – 2769 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 12 | 42,3 (3,5 – 45,8) | 0 – 137 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 27,5 | 3,8 (25,3 – 29) | 23 – 30 | — |
| Machines en fin | dernier jour | — | 140,2 | 523,7 (23,0 – 546,7) | 11,5 – 1015,6 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 11 | 3,5 (8,3 – 11,8) | 5 – 15 | — |
| Bonheur moyen | après chauffe | — | 0,90 | 0,10 (0,83 – 0,92) | 0,68 – 0,96 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 74,0 | 105,6 (40,1 – 145,6) | 2,6 – 229,1 | — |
| Jours de prestations réduites | après chauffe | — | 203,5 | 472 (65,8 – 537,8) | 1 – 661 | — |
| Trésor de l’État le plus bas | après chauffe | — | 14 317 $ | 3 909 $ (11 706 $ – 15 616 $) | 1 333 $ – 20 423 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 56 653 $ | 21 595 $ (44 468 $ – 66 063 $) | 34 970 $ – 96 440 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 8,89 | 46,72 (0,00 – 46,72) | 0,00 – 3082,75 | 5/10 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 27,77 | 3,29 (25,73 – 29,03) | 16,96 – 32,82 | 10/10 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 152,59 | 1113,45 (51,96 – 1165,41) | 0,11 – 2217,04 | 9/10 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 8,89 | 0,00 – 46,72 | 0,00 – 3082,75 | 5/10 | 129997 | prix trop élevé (94 %) ; pas de producteur (6 %) |
| Renflouement d’entreprise | 27,77 | 25,73 – 29,03 | 16,96 – 32,82 | 10/10 | 10075 | par le propriétaire (92 %) ; après rachat (8 %) |
| Plancher de logement | 152,59 | 51,96 – 1165,41 | 0,11 – 2217,04 | 9/10 | 204018 | prix trop élevé (77 %) ; parc plein (23 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 10 graines · graines touchées) : Tourisme 1748 · 10, Ferme 827 · 10, Ingénierie pétrolière 665 · 10, Hôtel 582 · 10, Bijouterie 510 · 9, Ingénierie de CPU 357 · 10, Marketing 345 · 10, Pétrochimie 340 · 9.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 38,9 % | 75,8 % | 13,9 % | 17,3 % | 0,62 | -0,101 % | 718 (24) | 0,48 | 6 % / 21 % / 74 % | 0 | 13 339 $ |
| 2 | 20,8 % | 38,9 % | 0,0 % | 0,7 % | 0,35 | -0,079 % | 665 (23) | 0,67 | 6 % / 14 % / 80 % | 2 | 17 200 $ |
| 3 | 14,7 % | 42,2 % | 0,0 % | 0,1 % | 0,36 | -0,082 % | 683 (17) | 0,85 | 4 % / 15 % / 81 % | 3 | 22 674 $ |
| 4 | 21,8 % | 51,5 % | 0,5 % | 1,9 % | 0,39 | -0,000 % | 731 (26) | 0,69 | 8 % / 20 % / 72 % | 3 | 2 616 $ |
| 5 | 23,5 % | 44,7 % | 0,6 % | 9,3 % | 0,47 | 0,025 % | 633 (23) | 0,53 | 9 % / 28 % / 63 % | 0 | 4 793 $ |
| 6 | 23,1 % | 44,3 % | 0,7 % | 2,2 % | 0,47 | -0,075 % | 854 (42) | 0,61 | 7 % / 25 % / 69 % | 1 | 6 579 $ |
| 7 | 33,5 % | 74,5 % | 7,3 % | 11,3 % | 0,55 | -0,076 % | 763 (35) | 0,49 | 9 % / 23 % / 69 % | 1 | 6 697 $ |
| 8 | 21,7 % | 33,6 % | 0,0 % | 0,7 % | 0,38 | -0,085 % | 692 (22) | 0,77 | 7 % / 18 % / 75 % | 0 | 28 938 $ |
| 9 | 17,2 % | 35,7 % | 0,0 % | 0,0 % | 0,35 | 0,047 % | 750 (20) | 0,87 | 5 % / 19 % / 76 % | 1 | 19 782 $ |
| 10 | 24,9 % | 40,7 % | 0,0 % | 4,4 % | 0,44 | -0,056 % | 781 (68) | 0,75 | 7 % / 19 % / 73 % | 0 | 2 991 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 10/10 : g1 27, g2 24, g3 18, g4 15, g5 25, g6 44, g7 16, g8 39, … |
| Chômage moyen ≤ 10 % | ❌ | 9/10 : g1 15,0 %, g2 16,6 %, g3 18,5 %, g4 11,5 %, g5 25,5 %, g6 20,0 %, g7 14,6 %, g8 20,6 %, … |
| Faim et sans-abri < 2 % | ❌ | 7/10 : g2, g3, g4, g5, g7, g8, g9 |
| Gini 0,2–0,45 | ❌ | 4/10 : g2 0,46, g3 0,45, g5 0,53, g6 0,48 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 10 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 10 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 5/10 graines ; Renflouement d’entreprise : 10/10 graines ; Plancher de logement : 9/10 graines |

