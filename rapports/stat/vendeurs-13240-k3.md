# Protocole de stabilité ÉcoNodes

- Date : 2026-10-12 15:25
- Graines : 1 à 3 (3) · 1000 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1000), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1000). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Bâtiments, construction et hypothèques
- Paramètres changés : population = 13240, sellerSample = 3
- Temps total : 8 min 38 s pour 6 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 53,8 % | 1,5 pt (53,7 % – 55,3 %) | 53,7 % – 56,7 % | 3/3 |
| Chômage max | toute la partie | — | 66,6 % | 4,1 pt (66,4 % – 70,5 %) | 66,2 % – 74,4 % | — |
| Faim moyenne | après chauffe | < 2 % | 21,3 % | 2,8 pt (20,4 % – 23,2 %) | 19,5 % – 25,1 % | 3/3 |
| Faim max | toute la partie | — | 54,9 % | 5,0 pt (52,8 % – 57,8 %) | 50,8 % – 60,8 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 57,8 % | 0,5 pt (57,6 % – 58,1 %) | 57,3 % – 58,4 % | 3/3 |
| Sans-abri max | toute la partie | — | 94,1 % | 1,1 pt (93,8 % – 94,9 %) | 93,5 % – 95,6 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,91 | 0,001 (0,91 – 0,91) | 0,91 – 0,91 | 3/3 |
| Gini en fin de partie | dernier jour | — | 0,99 | 0,001 (0,99 – 0,99) | 0,99 – 0,99 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,079 % | 0,015 pt (0,066 % – 0,080 %) | 0,053 % – 0,082 % | 0/3 |
| |Inflation| max / j | toute la partie | — | 4,5 % | 2,5 pt (4,4 % – 6,9 %) | 4,2 % – 9,2 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 103,1 % | 3,9 pt (102,0 % – 105,9 %) | 100,9 % – 108,7 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 7 | 1,5 (6,5 – 8) | 6 – 9 | 3/3 |
| … dont après la chauffe | après chauffe | — | 7 | 1 (6 – 7) | 5 – 7 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 2862 | 15,5 (2856 – 2871,5) | 2850 – 2881 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 7494 | 103,5 (7489,5 – 7593) | 7485 – 7692 | — |
| Santé moyenne | après chauffe | — | 0,24 | 0,003 (0,24 – 0,24) | 0,24 – 0,25 | — |
| Naissances d’entreprises / an | toute la partie | — | 2,6 | 1,3 (2,4 – 3,7) | 2,2 – 4,7 | — |
| Naissances / an, en % du parc moyen | toute la partie | — | 0,4 | 0,2 (0,4 – 0,6) | 0,3 – 0,7 | — |
| Morts / an, en % du parc moyen | toute la partie | — | 67,0 | 1,0 (66,8 – 67,9) | 66,7 – 68,8 | — |
| Parc moyen d’entreprises (après la chauffe) | après chauffe | — | 640,4 | 6,6 (634,0 – 640,6) | 627,6 – 640,8 | — |
| Part de la plus grande entreprise (médiane des biens) | après chauffe | — | 80,4 % | 2,2 pt (78,9 % – 81,1 %) | 77,4 % – 81,7 % | — |
| Herfindahl des ventes (médiane des biens) | après chauffe | — | 0,76 | 0,02 (0,75 – 0,76) | 0,74 – 0,77 | — |
| Fermetures : prix aberrant | toute la partie | — | 65 | 4 (62,5 – 66,5) | 60 – 68 | — |
| Fermetures : faillite (salaires impayables) | toute la partie | — | 1101 | 6,5 (1096 – 1102,5) | 1091 – 1104 | — |
| Fermetures : demande perdue | toute la partie | — | 4 | 1 (3 – 4) | 2 – 4 | — |
| Fermetures : sans employé (départs, postes non pourvus) | toute la partie | — | 5 | 7,5 (5 – 12,5) | 5 – 20 | — |
| Fermetures : autre | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Morts d’entreprises / an | toute la partie | — | 428,9 | 2,2 (428,1 – 430,3) | 427,4 – 431,8 | — |
| Entonnoir : projets envisagés | toute la partie | — | 7527 | 152 (7485,5 – 7637,5) | 7444 – 7748 | — |
| Entonnoir : créations | toute la partie | — | 7 | 3,5 (6,5 – 10) | 6 – 13 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 59 | 23 (52 – 75) | 45 – 91 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 279 | 208 (267,5 – 475,5) | 256 – 672 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 6219 | 141,5 (6082 – 6223,5) | 5945 – 6228 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 314 | 95,5 (223 – 318,5) | 132 – 323 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 640 | 150 (617,5 – 767,5) | 595 – 895 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 26 | 1,5 (25 – 26,5) | 24 – 27 | — |
| Machines en fin | dernier jour | — | 1168,4 | 100,1 (1099,7 – 1199,8) | 1030,9 – 1231,2 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 159 | 10 (155,5 – 165,5) | 152 – 172 | — |
| Bonheur moyen | après chauffe | — | 0,45 | 0,004 (0,45 – 0,46) | 0,45 – 0,46 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 321,3 | 2,6 (319,1 – 321,7) | 316,8 – 322,1 | — |
| Jours de prestations réduites | après chauffe | — | 806 | 6,5 (801 – 807,5) | 796 – 809 | — |
| Trésor de l’État le plus bas | après chauffe | — | 84 186 $ | 12 239 $ (75 756 $ – 87 996 $) | 67 327 $ – 91 806 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 270 979 $ | 28 702 $ (255 891 $ – 284 592 $) | 240 802 $ – 298 206 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/3 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 3/3 | 1 | 1 – 1 | 1 – 1 | 869 j |
| Faim répandue | critique | 3/3 | 1 | 1 – 2 | 1 – 3 | 461 j |
| Sans-abri nombreux | critique | 3/3 | 2 | 1,5 – 2,5 | 1 – 3 | 851 j |
| Inégalités hors bornes | attention | 3/3 | 1 | 1 – 1 | 1 – 1 | 863 j |
| Richesse médiane hors bornes | attention | 3/3 | 1 | 1 – 1 | 1 – 1 | 586 j |
| Inflation quotidienne | critique | 1/3 | 0 | 0 – 1 | 0 – 2 | 0 j |
| Inflation sur 100 jours | critique | 3/3 | 1 | 1 – 1 | 1 – 1 | 4 j |
| Rupture de stock prolongée | attention | 3/3 | 624 | 614 – 647 | 604 – 670 | 13947 j |
| Surstock | attention | 3/3 | 1842 | 1828,5 – 1884,5 | 1815 – 1927 | 100212 j |
| Entreprise sans employé | attention | 3/3 | 1743 | 1731 – 1761,5 | 1719 – 1780 | 107072 j |
| Entreprise sans client | attention | 3/3 | 2816 | 2789,5 – 2823 | 2763 – 2830 | 203478 j |
| Santé de la population effondrée | critique | 3/3 | 1 | 1 – 1 | 1 – 1 | 683 j |
| Productivité du travail effondrée | attention | 3/3 | 1 | 1 – 1 | 1 – 1 | 683 j |
| Embauches bloquées faute de moyens | attention | 3/3 | 1 | 1 – 1 | 1 – 1 | 761 j |
| Prix aberrant | attention | 3/3 | 483 | 479 – 510 | 475 – 537 | 215644 j |
| Attente trop longue (service public) | attention | 3/3 | 2 | 2 – 2 | 2 – 2 | 1540 j |
| Prestations réduites faute de trésor | attention | 3/3 | 1 | 1 – 1 | 1 – 1 | 806 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 56,7 % | 74,4 % | 25,1 % | 57,3 % | 0,91 | 0,079 % | 7692 (7) | 0,25 | 16 % / 35 % / 49 % | 115 | 0 $ |
| 2 | 53,7 % | 66,2 % | 21,3 % | 57,8 % | 0,91 | 0,082 % | 7485 (9) | 0,24 | 16 % / 33 % / 51 % | 114 | 0 $ |
| 3 | 53,8 % | 66,6 % | 19,5 % | 58,4 % | 0,91 | 0,053 % | 7494 (6) | 0,24 | 16 % / 34 % / 50 % | 113 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 53,8 % | 2,1 pt (52,4 % – 54,5 %) | 51,0 % – 55,3 % | 3/3 |
| Chômage max | toute la partie | — | 68,0 % | 4,4 pt (64,2 % – 68,7 %) | 60,5 % – 69,3 % | — |
| Faim moyenne | après chauffe | < 2 % | 21,0 % | 2,2 pt (19,8 % – 22,0 %) | 18,5 % – 22,9 % | 3/3 |
| Faim max | toute la partie | — | 44,1 % | 9,6 pt (40,3 % – 49,9 %) | 36,5 % – 55,8 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 39,2 % | 0,8 pt (39,0 % – 39,8 %) | 38,8 % – 40,4 % | 3/3 |
| Sans-abri max | toute la partie | — | 65,1 % | 1,1 pt (64,8 % – 66,0 %) | 64,5 % – 66,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,90 | 0,004 (0,90 – 0,91) | 0,90 – 0,91 | 3/3 |
| Gini en fin de partie | dernier jour | — | 0,99 | 0,001 (0,99 – 0,99) | 0,99 – 0,99 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,060 % | 0,001 pt (0,059 % – 0,060 %) | 0,059 % – 0,060 % | 0/3 |
| |Inflation| max / j | toute la partie | — | 4,3 % | 4,6 pt (3,8 % – 8,5 %) | 3,4 % – 12,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 120,2 % | 7,6 pt (116,1 % – 123,8 %) | 112,1 % – 127,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 7 | 2,5 (6,5 – 9) | 6 – 11 | 3/3 |
| … dont après la chauffe | après chauffe | — | 5 | 2,5 (4,5 – 7) | 4 – 9 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 2963 | 42,5 (2933,5 – 2976) | 2904 – 2989 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 6175 | 74 (6124,5 – 6198,5) | 6074 – 6222 | — |
| Santé moyenne | après chauffe | — | 0,22 | 0,01 (0,22 – 0,23) | 0,21 – 0,24 | — |
| Naissances d’entreprises / an | toute la partie | — | 2,2 | 0,2 (2,2 – 2,4) | 2,2 – 2,6 | — |
| Naissances / an, en % du parc moyen | toute la partie | — | 0,3 | 0,03 (0,3 – 0,4) | 0,3 – 0,4 | — |
| Morts / an, en % du parc moyen | toute la partie | — | 62,1 | 1,8 (61,1 – 62,9) | 60,1 – 63,7 | — |
| Parc moyen d’entreprises (après la chauffe) | après chauffe | — | 664,1 | 11,7 (659,0 – 670,7) | 654,0 – 677,4 | — |
| Part de la plus grande entreprise (médiane des biens) | après chauffe | — | 76,7 % | 2,6 pt (74,8 % – 77,5 %) | 73,0 % – 78,3 % | — |
| Herfindahl des ventes (médiane des biens) | après chauffe | — | 0,70 | 0,04 (0,67 – 0,71) | 0,64 – 0,73 | — |
| Fermetures : prix aberrant | toute la partie | — | 69 | 5 (67,5 – 72,5) | 66 – 76 | — |
| Fermetures : faillite (salaires impayables) | toute la partie | — | 1024 | 5,5 (1020 – 1025,5) | 1016 – 1027 | — |
| Fermetures : demande perdue | toute la partie | — | 13 | 7 (11 – 18) | 9 – 23 | — |
| Fermetures : sans employé (départs, postes non pourvus) | toute la partie | — | 24 | 6 (19 – 25) | 14 – 26 | — |
| Fermetures : autre | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Morts d’entreprises / an | toute la partie | — | 412,4 | 4,9 (409,7 – 414,6) | 407,0 – 416,8 | — |
| Entonnoir : projets envisagés | toute la partie | — | 7845 | 449 (7418,5 – 7867,5) | 6992 – 7890 | — |
| Entonnoir : créations | toute la partie | — | 6 | 0,5 (6 – 6,5) | 6 – 7 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 47 | 12,5 (43 – 55,5) | 39 – 64 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 279 | 16 (273,5 – 289,5) | 268 – 300 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 6156 | 326,5 (6130 – 6456,5) | 6104 – 6757 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 339 | 89,5 (289 – 378,5) | 239 – 418 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 317 | 506,5 (250,5 – 757) | 184 – 1197 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 27 | 0,5 (26,5 – 27) | 26 – 27 | — |
| Machines en fin | dernier jour | — | 1273,7 | 64,2 (1229,8 – 1293,9) | 1185,8 – 1314,1 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 171 | 46 (140 – 186) | 109 – 201 | — |
| Bonheur moyen | après chauffe | — | 0,45 | 0,003 (0,45 – 0,45) | 0,44 – 0,45 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 339,5 | 14,4 (331,3 – 345,7) | 323,2 – 352,0 | — |
| Jours de prestations réduites | après chauffe | — | 814 | 5 (811 – 816) | 808 – 818 | — |
| Trésor de l’État le plus bas | après chauffe | — | 33 650 $ | 6 886 $ (31 301 $ – 38 187 $) | 28 952 $ – 42 724 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 157 443 $ | 24 326 $ (135 125 $ – 159 452 $) | 112 808 $ – 161 460 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 38956,56 | 3574,17 (37428,53 – 41002,69) | 35900,50 – 43048,83 | 3/3 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 133,33 | 11,17 (131,47 – 142,64) | 129,61 – 151,94 | 3/3 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 106352,00 | 1364,81 (105819,25 – 107184,06) | 105286,50 – 108016,11 | 3/3 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/3 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/3 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/3 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 38956,56 | 37428,53 – 41002,69 | 35900,50 – 43048,83 | 3/3 | 2122307 | prix trop élevé (100 %) ; pas de revenu (0 %) |
| Renflouement d’entreprise | 133,33 | 131,47 – 142,64 | 129,61 – 151,94 | 3/3 | 19482 | par le propriétaire (86 %) ; après rachat (14 %) |
| Plancher de logement | 106352,00 | 105819,25 – 107184,06 | 105286,50 – 108016,11 | 3/3 | 5754826 | prix trop élevé (99 %) ; parc plein (1 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/3 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/3 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 3 graines · graines touchées) : Hôtel 1278 · 3, Production télé 821 · 3, Garage 767 · 3, Boulangerie 627 · 3, Comptabilité 569 · 3, Marketing 537 · 3, Ferme 529 · 3, Ingénierie pétrolière 449 · 3.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 53,8 % | 69,3 % | 21,0 % | 39,2 % | 0,90 | 0,060 % | 6074 (6) | 0,24 | 15 % / 30 % / 55 % | 111 | 0 $ |
| 2 | 51,0 % | 60,5 % | 18,5 % | 40,4 % | 0,90 | 0,059 % | 6175 (11) | 0,21 | 16 % / 36 % / 48 % | 111 | 2 353 $ |
| 3 | 55,3 % | 68,0 % | 22,9 % | 38,8 % | 0,91 | 0,060 % | 6222 (7) | 0,22 | 12 % / 36 % / 52 % | 112 | 0 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 3/3 : g1 7, g2 9, g3 6 |
| Chômage moyen ≤ 10 % | ❌ | 3/3 : g1 56,7 %, g2 53,7 %, g3 53,8 % |
| Faim et sans-abri < 2 % | ❌ | 3/3 : g1, g2, g3 |
| Gini 0,2–0,45 | ❌ | 3/3 : g1 0,91, g2 0,91, g3 0,91 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 3 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 3 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 3/3 graines ; Renflouement d’entreprise : 3/3 graines ; Plancher de logement : 3/3 graines |

