# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 20:35
- Graines : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : aucun
- Paramètres changés : partTime = 1
- Temps total : 4 min 53 s pour 360 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,6 % | 3,5 pt (8,1 % – 11,5 %) | 5,2 % – 26,0 % | 11/30 |
| Chômage max | toute la partie | — | 24,6 % | 8,8 pt (22,5 % – 31,3 %) | 17,1 % – 47,9 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,1 % | 0,2 pt (0,0 % – 0,2 %) | 0,0 % – 1,0 % | 0/30 |
| Faim max | toute la partie | — | 31,7 % | 51,1 pt (0,0 % – 51,1 %) | 0,0 % – 73,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,4 % | 0,9 pt (0,2 % – 1,1 %) | 0,0 % – 3,1 % | 3/30 |
| Sans-abri max | toute la partie | — | 30,4 % | 28,7 pt (17,6 % – 46,4 %) | 0,8 % – 81,7 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,28 | 0,04 (0,26 – 0,30) | 0,25 – 0,37 | 0/30 |
| Gini en fin de partie | dernier jour | — | 0,29 | 0,04 (0,27 – 0,31) | 0,21 – 0,56 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,054 % | 0,032 pt (-0,070 % – -0,038 %) | -0,112 % – 0,015 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 34,4 % | 19,8 pt (21,3 % – 41,1 %) | 3,8 % – 82,2 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 108,7 % | 8,5 pt (105,1 % – 113,6 %) | 64,0 % – 134,4 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 16,5 | 6,8 (14 – 20,8) | 3 – 29 | 30/30 |
| … dont après la chauffe | après chauffe | — | 14,5 | 7,5 (11,3 – 18,8) | 2 – 29 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 71 | 81,8 (40,8 – 122,5) | 13 – 628 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 381,5 | 110,3 (331,5 – 441,8) | 246 – 563 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,001 (0,88 – 0,88) | 0,85 – 0,88 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 28 | 4 (26 – 30) | 22 – 31 | — |
| Machines en fin | dernier jour | — | 362,4 | 114,5 (287,2 – 401,7) | 0,5 – 485,3 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 3 | 3,8 (1 – 4,8) | 0 – 9 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,01 (0,96 – 0,97) | 0,92 – 0,97 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,4 | 0,1 (0,4 – 0,5) | 0,3 – 5,9 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 74 | — |
| Trésor de l’État le plus bas | après chauffe | — | 79 907 $ | 39 776 $ (53 467 $ – 93 243 $) | 1 339 $ – 120 846 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 967 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 852 | — |
| Créances radiées | toute la partie | — | 16 078 $ | 16 374 $ (10 022 $ – 26 395 $) | 4 200 $ – 35 941 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 6/30 | 0 | 0 – 0 | 0 – 5 | 0 j |
| Faim répandue | critique | 18/30 | 1 | 0 – 1 | 0 – 6 | 2 j |
| Sans-abri nombreux | critique | 28/30 | 3 | 2 – 4,8 | 0 – 14 | 36 j |
| Inégalités hors bornes | attention | 1/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Inflation quotidienne | critique | 29/30 | 10,5 | 8 – 12,8 | 0 – 15 | 10,5 j |
| Inflation sur 100 jours | critique | 28/30 | 2 | 1 – 2 | 0 – 5 | 10 j |
| Rupture de stock prolongée | attention | 30/30 | 69 | 55,5 – 78,5 | 41 – 105 | 1023 j |
| Surstock | attention | 30/30 | 108 | 90,5 – 123,5 | 71 – 163 | 5204,5 j |
| Entreprise sans employé | attention | 30/30 | 47 | 32,3 – 52,5 | 25 – 60 | 627 j |
| Entreprise sans client | attention | 30/30 | 132,5 | 111 – 157,5 | 89 – 191 | 4753 j |
| Caisse insolvable | attention | 7/30 | 0 | 0 – 0 | 0 – 2 | 0 j |
| Santé de la population effondrée | critique | 1/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Productivité du travail effondrée | attention | 1/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Pénurie de main-d’œuvre | attention | 8/30 | 0 | 0 – 0,8 | 0 – 1 | 0 j |
| Embauches bloquées faute de moyens | attention | 29/30 | 1 | 1 – 2 | 0 – 3 | 14 j |
| Prix aberrant | attention | 30/30 | 6,5 | 5 – 10,8 | 1 – 22 | 979 j |
| Attente trop longue (service public) | attention | 3/30 | 0 | 0 – 0 | 0 – 2 | 0 j |
| Prestations réduites faute de trésor | attention | 2/30 | 0 | 0 – 0 | 0 – 1 | 0 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,5 % | 22,5 % | 0,0 % | 1,3 % | 0,37 | -0,021 % | 406 (17) | 0,88 | 7 % / 19 % / 74 % | 5 | 46 057 $ |
| 2 | 8,1 % | 22,9 % | 0,1 % | 0,2 % | 0,26 | -0,045 % | 397 (18) | 0,88 | 6 % / 16 % / 78 % | 0 | 9 800 $ |
| 3 | 9,1 % | 27,5 % | 0,4 % | 0,4 % | 0,28 | -0,050 % | 474 (20) | 0,88 | 5 % / 18 % / 77 % | 0 | 0 $ |
| 4 | 8,3 % | 24,2 % | 0,2 % | 0,4 % | 0,28 | -0,059 % | 293 (16) | 0,88 | 4 % / 22 % / 74 % | 1 | 0 $ |
| 5 | 7,5 % | 25,8 % | 0,4 % | 0,1 % | 0,26 | -0,059 % | 291 (21) | 0,88 | 5 % / 15 % / 79 % | 0 | 4 954 $ |
| 6 | 6,6 % | 19,2 % | 0,0 % | 0,0 % | 0,25 | -0,032 % | 412 (15) | 0,88 | 4 % / 22 % / 73 % | 2 | 0 $ |
| 7 | 14,0 % | 35,4 % | 0,6 % | 0,9 % | 0,32 | -0,082 % | 563 (28) | 0,88 | 9 % / 23 % / 68 % | 2 | 0 $ |
| 8 | 8,4 % | 23,8 % | 0,1 % | 0,6 % | 0,27 | -0,030 % | 383 (3) | 0,88 | 7 % / 11 % / 83 % | 2 | 7 309 $ |
| 9 | 16,2 % | 37,9 % | 0,0 % | 1,6 % | 0,33 | -0,083 % | 340 (24) | 0,88 | 9 % / 11 % / 80 % | 0 | 1 366 $ |
| 10 | 8,2 % | 23,3 % | 1,0 % | 0,5 % | 0,26 | 0,015 % | 420 (16) | 0,88 | 6 % / 15 % / 80 % | 0 | 1 736 $ |
| 11 | 9,0 % | 27,1 % | 0,4 % | 0,4 % | 0,28 | -0,059 % | 381 (20) | 0,88 | 9 % / 20 % / 71 % | 0 | 3 598 $ |
| 12 | 16,2 % | 39,2 % | 0,1 % | 0,9 % | 0,32 | -0,087 % | 449 (25) | 0,86 | 6 % / 12 % / 82 % | 1 | 2 172 $ |
| 13 | 7,4 % | 21,3 % | 0,0 % | 0,4 % | 0,25 | -0,030 % | 331 (20) | 0,88 | 6 % / 25 % / 69 % | 0 | 8 699 $ |
| 14 | 17,0 % | 42,1 % | 0,4 % | 2,1 % | 0,36 | -0,083 % | 525 (29) | 0,87 | 7 % / 20 % / 73 % | 1 | 0 $ |
| 15 | 5,2 % | 17,1 % | 0,0 % | 0,2 % | 0,25 | -0,050 % | 246 (12) | 0,88 | 6 % / 12 % / 82 % | 0 | 13 085 $ |
| 16 | 7,0 % | 19,2 % | 0,0 % | 0,2 % | 0,26 | -0,016 % | 376 (19) | 0,88 | 7 % / 15 % / 78 % | 2 | 19 171 $ |
| 17 | 7,2 % | 18,8 % | 0,0 % | 0,1 % | 0,26 | -0,053 % | 335 (8) | 0,88 | 5 % / 14 % / 81 % | 5 | 9 358 $ |
| 18 | 8,1 % | 21,3 % | 0,2 % | 0,3 % | 0,26 | -0,052 % | 309 (16) | 0,88 | 8 % / 20 % / 71 % | 1 | 21 274 $ |
| 19 | 11,7 % | 33,8 % | 0,0 % | 1,6 % | 0,30 | -0,062 % | 481 (19) | 0,88 | 7 % / 20 % / 73 % | 0 | 8 793 $ |
| 20 | 8,6 % | 22,5 % | 0,1 % | 0,2 % | 0,27 | -0,060 % | 282 (12) | 0,88 | 6 % / 13 % / 81 % | 1 | 0 $ |
| 21 | 7,1 % | 21,3 % | 0,0 % | 0,3 % | 0,28 | -0,055 % | 270 (14) | 0,88 | 5 % / 14 % / 81 % | 2 | 7 201 $ |
| 22 | 8,1 % | 25,8 % | 0,1 % | 0,1 % | 0,30 | -0,050 % | 403 (16) | 0,88 | 8 % / 18 % / 74 % | 1 | 8 842 $ |
| 23 | 8,4 % | 25,0 % | 0,0 % | 0,2 % | 0,26 | -0,019 % | 351 (11) | 0,88 | 8 % / 16 % / 76 % | 1 | 8 368 $ |
| 24 | 26,0 % | 47,9 % | 0,1 % | 3,1 % | 0,37 | -0,105 % | 473 (29) | 0,85 | 7 % / 16 % / 77 % | 2 | 12 442 $ |
| 25 | 10,4 % | 22,9 % | 0,0 % | 1,1 % | 0,30 | -0,076 % | 382 (16) | 0,88 | 7 % / 13 % / 80 % | 0 | 0 $ |
| 26 | 12,9 % | 31,7 % | 1,0 % | 1,0 % | 0,30 | -0,051 % | 487 (22) | 0,88 | 10 % / 21 % / 69 % | 0 | 0 $ |
| 27 | 10,0 % | 30,0 % | 0,1 % | 0,5 % | 0,29 | -0,059 % | 458 (14) | 0,88 | 6 % / 14 % / 81 % | 1 | 11 376 $ |
| 28 | 8,6 % | 24,2 % | 0,0 % | 0,1 % | 0,26 | -0,036 % | 333 (11) | 0,88 | 6 % / 16 % / 77 % | 0 | 5 358 $ |
| 29 | 11,2 % | 27,1 % | 0,0 % | 1,6 % | 0,30 | -0,073 % | 302 (14) | 0,88 | 11 % / 22 % / 68 % | 3 | 25 973 $ |
| 30 | 19,1 % | 42,1 % | 0,2 % | 2,1 % | 0,35 | -0,112 % | 340 (27) | 0,88 | 7 % / 16 % / 77 % | 0 | 2 860 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 8,6 % | 5,3 pt (7,1 % – 12,4 %) | 5,4 % – 28,7 % | 10/30 |
| Chômage max | toute la partie | — | 24,8 % | 17,4 pt (20,2 % – 37,6 %) | 14,2 % – 46,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0002 pt (0,0 % – 0,0 %) | 0,0 % – 0,5 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 10,1 pt (0,0 % – 10,1 %) | 0,0 % – 88,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,4 % | 0,4 pt (0,2 % – 0,6 %) | 0,0 % – 3,7 % | 3/30 |
| Sans-abri max | toute la partie | — | 30,6 % | 29,7 pt (18,5 % – 48,2 %) | 3,3 % – 65,4 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,25 | 0,04 (0,24 – 0,28) | 0,20 – 0,36 | 1/30 |
| Gini en fin de partie | dernier jour | — | 0,29 | 0,09 (0,26 – 0,34) | 0,20 – 0,53 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | -0,043 % | 0,028 pt (-0,054 % – -0,026 %) | -0,122 % – 0,037 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 34,6 % | 18,6 pt (21,4 % – 39,9 %) | 16,9 % – 80,7 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 106,0 % | 10,3 pt (100,5 % – 110,8 %) | 88,3 % – 132,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 16 | 7,5 (13 – 20,5) | 8 – 35 | 30/30 |
| … dont après la chauffe | après chauffe | — | 14 | 7,8 (11 – 18,8) | 7 – 32 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 56 | 111,3 (39 – 150,3) | 16 – 1124 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 303 | 92,3 (265,3 – 357,5) | 214 – 484 | — |
| Santé moyenne | après chauffe | — | 0,88 | 0,03 (0,85 – 0,88) | 0,75 – 0,88 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 29 | 3 (27 – 30) | 23 – 31 | — |
| Machines en fin | dernier jour | — | 363,8 | 158,3 (252,9 – 411,2) | 1,8 – 470,3 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 3,5 | 5 (2 – 7) | 0 – 10 | — |
| Bonheur moyen | après chauffe | — | 0,97 | 0,02 (0,95 – 0,97) | 0,90 – 0,98 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,4 | 4,2 (0,4 – 4,6) | 0,3 – 33,1 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 109 | — |
| Trésor de l’État le plus bas | après chauffe | — | 63 159 $ | 73 263 $ (10 568 $ – 83 831 $) | 1 628 $ – 115 553 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 708 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 236 | — |
| Créances radiées | toute la partie | — | 5 123 $ | 5 638 $ (2 170 $ – 7 808 $) | 0 $ – 44 890 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 17,79 | 5/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 5,16 | 3,07 (3,90 – 6,97) | 2,82 – 12,07 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 3,80 | 9,14 (0,50 – 9,64) | 0,00 – 154,14 | 21/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 8,43 | 1/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 17,79 | 5/30 | 1110 | pas de producteur (100 %) ; prix trop élevé (0 %) |
| Renflouement d’entreprise | 5,16 | 3,90 – 6,97 | 2,82 – 12,07 | 30/30 | 4967 | par le propriétaire (95 %) ; après rachat (5 %) |
| Plancher de logement | 3,80 | 0,50 – 9,64 | 0,00 – 154,14 | 21/30 | 14510 | prix trop élevé (59 %) ; parc plein (41 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 8,43 | 1/30 | 236 | fonds propres de la Caisse insuffisants (100 %) |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Ferme 2086 · 30, Tourisme 702 · 16, Ordinateurs 422 · 29, Hôtel 244 · 12, Mine de cuivre 238 · 30, Aluminerie 180 · 30, Mine de bauxite 167 · 29, Mine de fer 164 · 29.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,8 % | 17,5 % | 0,0 % | 0,2 % | 0,25 | -0,048 % | 312 (13) | 0,88 | 6 % / 15 % / 79 % | 0 | 10 637 $ |
| 2 | 20,4 % | 38,3 % | 0,0 % | 0,3 % | 0,28 | -0,022 % | 316 (17) | 0,85 | 8 % / 22 % / 70 % | 1 | 12 373 $ |
| 3 | 7,9 % | 20,0 % | 0,0 % | 0,5 % | 0,25 | -0,046 % | 297 (23) | 0,88 | 8 % / 21 % / 71 % | 0 | 11 839 $ |
| 4 | 7,8 % | 21,3 % | 0,0 % | 0,9 % | 0,26 | -0,049 % | 293 (16) | 0,88 | 6 % / 12 % / 81 % | 0 | 1 484 $ |
| 5 | 6,7 % | 20,8 % | 0,0 % | 0,2 % | 0,24 | -0,052 % | 248 (15) | 0,88 | 6 % / 14 % / 80 % | 0 | 2 685 $ |
| 6 | 6,6 % | 17,9 % | 0,0 % | 0,2 % | 0,24 | -0,038 % | 299 (21) | 0,88 | 3 % / 24 % / 73 % | 1 | 453 $ |
| 7 | 8,2 % | 25,4 % | 0,0 % | 0,5 % | 0,23 | -0,033 % | 214 (8) | 0,88 | 6 % / 21 % / 72 % | 0 | 793 $ |
| 8 | 10,8 % | 46,3 % | 0,0 % | 3,7 % | 0,30 | 0,037 % | 484 (19) | 0,75 | 7 % / 15 % / 77 % | 1 | 531 $ |
| 9 | 21,1 % | 35,0 % | 0,0 % | 0,4 % | 0,30 | -0,122 % | 310 (18) | 0,88 | 9 % / 19 % / 72 % | 1 | 0 $ |
| 10 | 11,9 % | 41,3 % | 0,2 % | 1,3 % | 0,27 | -0,033 % | 399 (22) | 0,85 | 8 % / 19 % / 73 % | 1 | 26 748 $ |
| 11 | 7,0 % | 20,0 % | 0,0 % | 0,2 % | 0,26 | -0,053 % | 250 (14) | 0,88 | 5 % / 11 % / 84 % | 0 | 8 404 $ |
| 12 | 17,2 % | 40,0 % | 0,0 % | 0,4 % | 0,29 | -0,092 % | 428 (21) | 0,85 | 6 % / 19 % / 75 % | 0 | 4 855 $ |
| 13 | 5,4 % | 17,5 % | 0,0 % | 0,0 % | 0,20 | -0,001 % | 266 (16) | 0,88 | 7 % / 16 % / 77 % | 0 | 12 817 $ |
| 14 | 7,5 % | 25,0 % | 0,0 % | 0,0 % | 0,23 | -0,069 % | 228 (9) | 0,88 | 6 % / 16 % / 78 % | 1 | 0 $ |
| 15 | 9,2 % | 28,3 % | 0,0 % | 0,4 % | 0,25 | -0,053 % | 280 (10) | 0,88 | 8 % / 16 % / 76 % | 0 | 2 795 $ |
| 16 | 5,7 % | 14,2 % | 0,0 % | 0,0 % | 0,20 | -0,017 % | 255 (15) | 0,88 | 8 % / 18 % / 74 % | 1 | 14 513 $ |
| 17 | 7,1 % | 22,1 % | 0,0 % | 0,1 % | 0,24 | -0,052 % | 290 (13) | 0,88 | 6 % / 23 % / 72 % | 0 | 0 $ |
| 18 | 15,4 % | 46,7 % | 0,4 % | 2,2 % | 0,33 | -0,086 % | 407 (28) | 0,85 | 10 % / 23 % / 67 % | 3 | 8 492 $ |
| 19 | 8,7 % | 24,6 % | 0,0 % | 0,2 % | 0,24 | -0,034 % | 332 (18) | 0,88 | 8 % / 20 % / 73 % | 0 | 7 325 $ |
| 20 | 7,1 % | 19,2 % | 0,0 % | 0,6 % | 0,22 | -0,024 % | 235 (13) | 0,88 | 5 % / 21 % / 74 % | 0 | 3 709 $ |
| 21 | 8,9 % | 24,6 % | 0,0 % | 0,1 % | 0,25 | -0,022 % | 307 (11) | 0,88 | 3 % / 24 % / 73 % | 0 | 0 $ |
| 22 | 9,3 % | 28,3 % | 0,0 % | 0,1 % | 0,27 | -0,040 % | 281 (8) | 0,88 | 9 % / 16 % / 76 % | 1 | 0 $ |
| 23 | 8,0 % | 23,8 % | 0,0 % | 0,1 % | 0,23 | -0,062 % | 229 (14) | 0,88 | 7 % / 16 % / 77 % | 1 | 5 646 $ |
| 24 | 8,5 % | 25,0 % | 0,0 % | 0,6 % | 0,28 | -0,040 % | 312 (19) | 0,88 | 8 % / 18 % / 74 % | 1 | 3 398 $ |
| 25 | 28,7 % | 45,0 % | 0,1 % | 3,6 % | 0,36 | -0,104 % | 397 (35) | 0,85 | 11 % / 18 % / 71 % | 0 | 0 $ |
| 26 | 28,0 % | 43,3 % | 0,5 % | 1,3 % | 0,33 | -0,022 % | 376 (28) | 0,81 | 9 % / 20 % / 71 % | 1 | 0 $ |
| 27 | 12,5 % | 35,4 % | 0,3 % | 0,4 % | 0,25 | -0,035 % | 401 (19) | 0,87 | 4 % / 28 % / 68 % | 3 | 0 $ |
| 28 | 22,0 % | 41,3 % | 0,2 % | 0,9 % | 0,30 | -0,011 % | 366 (27) | 0,85 | 8 % / 20 % / 72 % | 4 | 21 336 $ |
| 29 | 6,5 % | 15,4 % | 0,0 % | 0,6 % | 0,26 | -0,055 % | 311 (10) | 0,88 | 7 % / 19 % / 74 % | 0 | 12 658 $ |
| 30 | 9,9 % | 24,2 % | 0,1 % | 0,3 % | 0,25 | -0,055 % | 265 (14) | 0,88 | 9 % / 18 % / 74 % | 0 | 4 159 $ |

</details>

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. « Effondrée » : chômage moyen > 50 % avant le choc, l’évaluation n’a pas de sens. Un choc non résorbé compte comme une durée infinie dans la médiane.

### Sans filets

| Choc | Graines | Effondrée avant | Équilibre avant | Résorbé < 200 j | Retour (j) : médiane | EIQ (Q1–Q3) | Pic de chômage : médiane (Q1–Q3) | Alertes déclenchées (total, les plus fréquentes) |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 30 | 0 | 5 | 17 | 174 | 109 – non résorbé | 37,5 % (25,9 % – 49,7 %) | Entreprise sans client ×1954, Rupture de stock prolongée ×1660, Entreprise sans employé ×1247, Surstock ×888 |
| +25 immigrants | 30 | 0 | 5 | 0 | non résorbé | non résorbé – non résorbé | 32,3 % (28,4 % – 37,0 %) | Entreprise sans client ×1476, Surstock ×1268, Rupture de stock prolongée ×549, Entreprise sans employé ×406 |
| Salaire minimum 220 $/j | 30 | 0 | 5 | 9 | non résorbé | 33 – non résorbé | 43,5 % (35,1 % – 45,8 %) | Entreprise sans client ×1639, Surstock ×1193, Rupture de stock prolongée ×780, Entreprise sans employé ×525 |
| Fermeture de la ferme | 30 | 0 | 5 | 21 | 85 | 4 – 262 | 24,0 % (18,3 % – 28,6 %) | Entreprise sans client ×1435, Surstock ×1189, Rupture de stock prolongée ×595, Entreprise sans employé ×403 |
| Faillite d’une firme clé | 30 | 0 | 5 | 23 | 19 | 3 – 197 | 23,8 % (18,9 % – 30,5 %) | Entreprise sans client ×1542, Surstock ×1238, Rupture de stock prolongée ×612, Entreprise sans employé ×453 |

### Avec filets

| Choc | Graines | Effondrée avant | Équilibre avant | Résorbé < 200 j | Retour (j) : médiane | EIQ (Q1–Q3) | Pic de chômage : médiane (Q1–Q3) | Alertes déclenchées (total, les plus fréquentes) |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 30 | 0 | 10 | 26 | 101 | 83 – 120 | 21,9 % (14,8 % – 32,1 %) | Entreprise sans client ×1513, Rupture de stock prolongée ×1256, Surstock ×983, Entreprise sans employé ×689 |
| +25 immigrants | 30 | 0 | 10 | 0 | non résorbé | non résorbé – non résorbé | 34,0 % (25,8 % – 37,6 %) | Entreprise sans client ×1425, Surstock ×1234, Entreprise sans employé ×311, Rupture de stock prolongée ×304 |
| Salaire minimum 220 $/j | 30 | 0 | 10 | 8 | non résorbé | non résorbé – non résorbé | 39,2 % (31,7 % – 43,4 %) | Entreprise sans client ×1460, Surstock ×1076, Rupture de stock prolongée ×453, Entreprise sans employé ×342 |
| Fermeture de la ferme | 30 | 0 | 10 | 22 | 106 | 6 – 198 | 17,9 % (15,6 % – 24,2 %) | Entreprise sans client ×1348, Surstock ×1046, Rupture de stock prolongée ×331, Entreprise sans employé ×259 |
| Faillite d’une firme clé | 30 | 0 | 10 | 21 | 56 | 7 – 217 | 20,2 % (17,6 % – 23,5 %) | Entreprise sans client ×1319, Surstock ×987, Entreprise sans employé ×290, Rupture de stock prolongée ×269 |

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 30/30 : g1 17, g2 18, g3 20, g4 16, g5 21, g6 15, g7 28, g8 3, … |
| Chômage moyen ≤ 10 % | ❌ | 11/30 : g7 14,0 %, g9 16,2 %, g12 16,2 %, g14 17,0 %, g19 11,7 %, g24 26,0 %, g25 10,4 %, g26 12,9 %, … |
| Faim et sans-abri < 2 % | ❌ | 3/30 : g14, g24, g30 |
| Gini 0,2–0,45 | ✅ | aucune graine sur 30 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 30 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 30 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 5/30 graines ; Renflouement d’entreprise : 30/30 graines ; Plancher de logement : 21/30 graines ; Anti-crédit-fou : 1/30 graines |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 80/150 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 73/150 échecs |

