# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 21:08
- Graines : 1 à 10 (10) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : aucun
- Paramètres changés : population = 3000
- Temps total : 2 min 29 s pour 20 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 90,6 % | 0,8 pt (90,2 % – 91,0 %) | 82,1 % – 92,9 % | 10/10 |
| Chômage max | toute la partie | — | 97,9 % | 0,6 pt (97,6 % – 98,2 %) | 96,7 % – 99,1 % | — |
| Faim moyenne | après chauffe | < 2 % | 87,3 % | 4,4 pt (83,2 % – 87,6 %) | 66,8 % – 89,5 % | 10/10 |
| Faim max | toute la partie | — | 100,0 % | 0,0 pt (100,0 % – 100,0 %) | 99,8 % – 100,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 84,4 % | 2,3 pt (83,2 % – 85,6 %) | 74,7 % – 87,3 % | 10/10 |
| Sans-abri max | toute la partie | — | 99,3 % | 0,4 pt (99,1 % – 99,5 %) | 98,8 % – 99,7 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,89 | 0,03 (0,88 – 0,91) | 0,86 – 0,92 | 10/10 |
| Gini en fin de partie | dernier jour | — | 0,99 | 0,01 (0,98 – 0,99) | 0,96 – 0,99 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,282 % | 0,055 pt (0,241 % – 0,296 %) | 0,009 % – 0,369 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 187,3 % | 49,0 pt (156,1 % – 205,1 %) | 119,8 % – 486,8 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 849,3 % | 235,5 pt (800,0 % – 1035,5 %) | 635,5 % – 1323,9 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 20,5 | 10,8 (18,3 – 29) | 15 – 53 | 10/10 |
| … dont après la chauffe | après chauffe | — | 19,5 | 11,5 (16,5 – 28) | 14 – 52 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 5689 | 54 (5662,8 – 5716,8) | 5602 – 5729 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 362 | 79,5 (340,5 – 420) | 264 – 527 | — |
| Santé moyenne | après chauffe | — | 0,14 | 0,02 (0,13 – 0,15) | 0,12 – 0,15 | — |
| Naissances d’entreprises / an | toute la partie | — | 19,0 | 4,7 (18,1 – 22,8) | 13,1 – 25,8 | — |
| Morts d’entreprises / an | toute la partie | — | 21,0 | 3,8 (18,9 – 22,7) | 14,8 – 26,0 | — |
| Entonnoir : projets envisagés | toute la partie | — | 11666,5 | 313,3 (11495 – 11808,3) | 9318 – 12920 | — |
| Entonnoir : créations | toute la partie | — | 78 | 19,3 (74,5 – 93,8) | 54 – 106 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 272,5 | 166 (232,5 – 398,5) | 136 – 475 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 4234 | 838,8 (3999 – 4837,8) | 3007 – 5471 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 1603,5 | 271,8 (1442 – 1713,8) | 1095 – 2053 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 1417 | 375,5 (1224,8 – 1600,3) | 918 – 1993 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 3947,5 | 1205 (3245 – 4450) | 2734 – 4856 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 33 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 17,5 | 2 (16 – 18) | 13 – 21 | — |
| Machines en fin | dernier jour | — | 22,3 | 8,7 (15,9 – 24,6) | 5,7 – 30,3 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 11 | 3,8 (9 – 12,8) | 6 – 15 | — |
| Bonheur moyen | après chauffe | — | 0,13 | 0,01 (0,12 – 0,13) | 0,11 – 0,21 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 619,6 | 27,2 (608,9 – 636,1) | 604,4 – 645,0 | — |
| Jours de prestations réduites | après chauffe | — | 1334,5 | 9,3 (1330,8 – 1340) | 1319 – 1345 | — |
| Trésor de l’État le plus bas | après chauffe | — | 868 $ | 291 $ (697 $ – 988 $) | 368 $ – 1 888 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 3 099 $ | 6 465 $ (1 552 $ – 8 016 $) | 0 $ – 14 543 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 10/10 | 1 | 1 – 1 | 1 – 1 | 1422 j |
| Faim répandue | critique | 10/10 | 1 | 1 – 2 | 1 – 7 | 1305,5 j |
| Sans-abri nombreux | critique | 10/10 | 3 | 2 – 3,8 | 1 – 5 | 1355,5 j |
| Inégalités hors bornes | attention | 10/10 | 2 | 2 – 2 | 2 – 3 | 1304 j |
| Richesse médiane hors bornes | attention | 10/10 | 2 | 2 – 3 | 1 – 4 | 1256 j |
| Inflation quotidienne | critique | 10/10 | 11 | 10 – 18 | 7 – 31 | 11 j |
| Inflation sur 100 jours | critique | 10/10 | 3 | 2 – 3 | 2 – 10 | 373 j |
| Rupture de stock prolongée | attention | 10/10 | 54 | 41,3 – 68,5 | 34 – 94 | 6132,5 j |
| Surstock | attention | 10/10 | 29 | 25,5 – 34,3 | 18 – 45 | 3845,5 j |
| Entreprise sans employé | attention | 10/10 | 90,5 | 81,8 – 97,5 | 66 – 115 | 3826,5 j |
| Entreprise sans client | attention | 10/10 | 130,5 | 120 – 136,3 | 82 – 197 | 8938,5 j |
| Santé de la population effondrée | critique | 10/10 | 1 | 1 – 1 | 1 – 1 | 1238 j |
| Productivité du travail effondrée | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 1238 j |
| Embauches bloquées faute de moyens | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 1292,5 j |
| Prix aberrant | attention | 10/10 | 31,5 | 30,3 – 33 | 28 – 44 | 22802 j |
| Attente trop longue (service public) | attention | 10/10 | 2 | 2 – 2 | 2 – 2 | 2614 j |
| Prestations réduites faute de trésor | attention | 10/10 | 1 | 1 – 1 | 1 – 1 | 1334,5 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 90,4 % | 96,9 % | 87,4 % | 83,2 % | 0,91 | 0,260 % | 264 (15) | 0,15 | 36 % / 6 % / 58 % | 5 | 828 $ |
| 2 | 90,2 % | 99,1 % | 81,9 % | 85,7 % | 0,87 | 0,234 % | 527 (30) | 0,13 | 21 % / 30 % / 49 % | 11 | 0 $ |
| 3 | 90,7 % | 98,0 % | 87,3 % | 84,1 % | 0,90 | 0,292 % | 432 (20) | 0,12 | 31 % / 8 % / 60 % | 6 | 0 $ |
| 4 | 91,7 % | 97,6 % | 88,2 % | 86,2 % | 0,92 | 0,298 % | 338 (18) | 0,14 | 34 % / 10 % / 56 % | 6 | 0 $ |
| 5 | 90,4 % | 97,9 % | 87,1 % | 83,3 % | 0,89 | 0,282 % | 358 (18) | 0,13 | 30 % / 12 % / 58 % | 4 | 0 $ |
| 6 | 82,1 % | 98,2 % | 66,8 % | 74,7 % | 0,86 | 0,009 % | 443 (53) | 0,13 | 17 % / 28 % / 55 % | 8 | 0 $ |
| 7 | 92,9 % | 99,1 % | 89,5 % | 87,3 % | 0,89 | 0,369 % | 348 (19) | 0,15 | 6 % / 25 % / 69 % | 6 | 0 $ |
| 8 | 90,8 % | 98,1 % | 87,6 % | 84,7 % | 0,88 | 0,282 % | 366 (26) | 0,13 | 28 % / 9 % / 63 % | 6 | 604 $ |
| 9 | 91,1 % | 97,7 % | 87,6 % | 85,0 % | 0,90 | 0,308 % | 294 (21) | 0,15 | 34 % / 9 % / 57 % | 3 | 0 $ |
| 10 | 85,8 % | 96,7 % | 74,4 % | 80,3 % | 0,92 | 0,126 % | 384 (31) | 0,15 | 16 % / 30 % / 54 % | 6 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 66,7 % | 5,4 pt (63,1 % – 68,5 %) | 61,0 % – 74,5 % | 10/10 |
| Chômage max | toute la partie | — | 96,8 % | 0,2 pt (96,7 % – 96,9 %) | 96,5 % – 98,3 % | — |
| Faim moyenne | après chauffe | < 2 % | 30,5 % | 5,5 pt (27,6 % – 33,0 %) | 25,0 % – 44,8 % | 10/10 |
| Faim max | toute la partie | — | 84,7 % | 3,9 pt (81,8 % – 85,7 %) | 76,2 % – 87,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 40,4 % | 6,6 pt (35,8 % – 42,4 %) | 31,5 % – 45,6 % | 10/10 |
| Sans-abri max | toute la partie | — | 84,9 % | 6,8 pt (81,5 % – 88,3 %) | 77,9 % – 89,9 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,83 | 0,04 (0,82 – 0,87) | 0,77 – 0,88 | 10/10 |
| Gini en fin de partie | dernier jour | — | 0,79 | 0,10 (0,74 – 0,85) | 0,64 – 0,92 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,057 % | 0,065 pt (0,007 % – 0,072 %) | -0,038 % – 0,089 % | 0/10 |
| |Inflation| max / j | toute la partie | — | 198,2 % | 52,2 pt (172,8 % – 224,9 %) | 111,7 % – 302,8 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 504,8 % | 119,2 pt (452,4 % – 571,5 %) | 360,1 % – 803,4 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 20 | 2 (19 – 21) | 14 – 35 | 10/10 |
| … dont après la chauffe | après chauffe | — | 18,5 | 1,8 (18 – 19,8) | 12 – 34 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 5162 | 476,8 (4810,8 – 5287,5) | 4406 – 5499 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 252,5 | 60,3 (221,3 – 281,5) | 188 – 324 | — |
| Santé moyenne | après chauffe | — | 0,15 | 0,01 (0,15 – 0,16) | 0,14 – 0,23 | — |
| Naissances d’entreprises / an | toute la partie | — | 5,8 | 2,4 (4,5 – 6,9) | 4,4 – 7,8 | — |
| Morts d’entreprises / an | toute la partie | — | 5,5 | 0,7 (5,2 – 5,8) | 4,6 – 6,3 | — |
| Entonnoir : projets envisagés | toute la partie | — | 8469,5 | 1376 (7985,3 – 9361,3) | 7902 – 10943 | — |
| Entonnoir : créations | toute la partie | — | 24 | 9,8 (18,5 – 28,3) | 18 – 32 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 99,5 | 34,8 (82,8 – 117,5) | 69 – 170 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 1222,5 | 346,8 (1020,8 – 1367,5) | 982 – 1460 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 3510,5 | 306,8 (3411,5 – 3718,3) | 3187 – 3880 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 1374,5 | 400,3 (1133,3 – 1533,5) | 946 – 2371 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 2403,5 | 309,5 (2269,8 – 2579,3) | 1989 – 2830 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 7,5 (0 – 7,5) | 0 – 417 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 22 | 2,5 (22 – 24,5) | 22 – 27 | — |
| Machines en fin | dernier jour | — | 35,4 | 7,5 (29,6 – 37,1) | 11,9 – 37,6 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 9 | 2 (8 – 10) | 7 – 11 | — |
| Bonheur moyen | après chauffe | — | 0,36 | 0,07 (0,34 – 0,41) | 0,28 – 0,46 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 610,1 | 9,0 (603,2 – 612,2) | 502,2 – 615,3 | — |
| Jours de prestations réduites | après chauffe | — | 1322 | 190,8 (1144,5 – 1335,3) | 981 – 1348 | — |
| Trésor de l’État le plus bas | après chauffe | — | 68 $ | 13 $ (61 $ – 74 $) | 56 $ – 99 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 4 194 $ (0 $ – 4 194 $) | 0 $ – 10 669 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 19459,25 | 3577,57 (18124,25 – 21701,82) | 16203,96 – 32400,07 | 10/10 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 12,70 | 2,60 (10,78 – 13,38) | 8,14 – 17,82 | 10/10 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 27429,00 | 5293,52 (23570,13 – 28863,65) | 18472,21 – 30288,71 | 10/10 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/10 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/10 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 19459,25 | 18124,25 – 21701,82 | 16203,96 – 32400,07 | 10/10 | 5811458 | prix trop élevé (100 %) ; pas de producteur (0 %) |
| Renflouement d’entreprise | 12,70 | 10,78 – 13,38 | 8,14 – 17,82 | 10/10 | 3966 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 27429,00 | 23570,13 – 28863,65 | 18472,21 – 30288,71 | 10/10 | 7263519 | prix trop élevé (90 %) ; parc plein (10 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/10 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 10 graines · graines touchées) : Ingénierie pétrolière 874 · 10, Hôtel 490 · 10, Ferme 392 · 10, Ingénierie de CPU 381 · 10, Immobilier 212 · 10, Tourisme 209 · 5, Pêcherie 172 · 7, Mine d’or 152 · 10.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 62,4 % | 96,8 % | 26,6 % | 34,4 % | 0,78 | 0,038 % | 247 (23) | 0,17 | 13 % / 24 % / 62 % | 0 | 7 023 $ |
| 2 | 61,4 % | 96,5 % | 27,1 % | 33,6 % | 0,77 | -0,038 % | 324 (35) | 0,16 | 13 % / 22 % / 65 % | 2 | 14 159 $ |
| 3 | 65,1 % | 96,7 % | 29,0 % | 39,8 % | 0,85 | -0,004 % | 287 (16) | 0,14 | 15 % / 31 % / 54 % | 5 | 4 485 $ |
| 4 | 61,0 % | 98,3 % | 25,0 % | 31,5 % | 0,83 | 0,072 % | 265 (14) | 0,23 | 10 % / 24 % / 66 % | 1 | 7 753 $ |
| 5 | 66,6 % | 96,8 % | 29,8 % | 40,8 % | 0,84 | 0,077 % | 221 (20) | 0,14 | 15 % / 31 % / 54 % | 2 | 4 358 $ |
| 6 | 74,5 % | 96,7 % | 44,8 % | 45,6 % | 0,87 | 0,089 % | 290 (19) | 0,15 | 17 % / 30 % / 53 % | 2 | 5 134 $ |
| 7 | 66,7 % | 97,0 % | 32,4 % | 40,0 % | 0,83 | 0,044 % | 258 (19) | 0,15 | 15 % / 28 % / 56 % | 2 | 7 587 $ |
| 8 | 70,2 % | 96,7 % | 33,6 % | 43,7 % | 0,88 | -0,017 % | 188 (20) | 0,15 | 16 % / 30 % / 53 % | 2 | 2 490 $ |
| 9 | 68,1 % | 96,9 % | 31,2 % | 42,3 % | 0,82 | 0,070 % | 219 (21) | 0,15 | 14 % / 29 % / 56 % | 2 | 2 761 $ |
| 10 | 68,7 % | 96,6 % | 33,2 % | 42,4 % | 0,87 | 0,071 % | 222 (21) | 0,15 | 16 % / 30 % / 54 % | 2 | 4 965 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 10/10 : g1 15, g2 30, g3 20, g4 18, g5 18, g6 53, g7 19, g8 26, … |
| Chômage moyen ≤ 10 % | ❌ | 10/10 : g1 90,4 %, g2 90,2 %, g3 90,7 %, g4 91,7 %, g5 90,4 %, g6 82,1 %, g7 92,9 %, g8 90,8 %, … |
| Faim et sans-abri < 2 % | ❌ | 10/10 : g1, g2, g3, g4, g5, g6, g7, g8, g9, g10 |
| Gini 0,2–0,45 | ❌ | 10/10 : g1 0,91, g2 0,87, g3 0,90, g4 0,92, g5 0,89, g6 0,86, g7 0,89, g8 0,88, … |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 10 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 10 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 10/10 graines ; Renflouement d’entreprise : 10/10 graines ; Plancher de logement : 10/10 graines |

