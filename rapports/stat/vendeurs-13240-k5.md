# Protocole de stabilité ÉcoNodes

- Date : 2026-10-12 15:34
- Graines : 1 à 3 (3) · 1000 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1000), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1000). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Bâtiments, construction et hypothèques
- Paramètres changés : population = 13240, sellerSample = 5
- Temps total : 9 min 12 s pour 6 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 58,2 % | 1,4 pt (57,7 % – 59,1 %) | 57,2 % – 60,0 % | 3/3 |
| Chômage max | toute la partie | — | 73,4 % | 0,6 pt (73,0 % – 73,6 %) | 72,7 % – 73,9 % | — |
| Faim moyenne | après chauffe | < 2 % | 30,1 % | 2,8 pt (28,8 % – 31,6 %) | 27,6 % – 33,2 % | 3/3 |
| Faim max | toute la partie | — | 68,8 % | 1,7 pt (67,2 % – 68,9 %) | 65,6 % – 69,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 66,0 % | 1,0 pt (65,3 % – 66,3 %) | 64,6 % – 66,6 % | 3/3 |
| Sans-abri max | toute la partie | — | 97,2 % | 0,5 pt (96,8 % – 97,3 %) | 96,5 % – 97,5 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,93 | 0,002 (0,93 – 0,93) | 0,93 – 0,93 | 3/3 |
| Gini en fin de partie | dernier jour | — | 0,99 | 0,001 (0,99 – 0,99) | 0,99 – 0,99 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,098 % | 0,023 pt (0,096 % – 0,119 %) | 0,094 % – 0,140 % | 0/3 |
| |Inflation| max / j | toute la partie | — | 5,9 % | 1,3 pt (4,9 % – 6,3 %) | 4,0 % – 6,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 98,9 % | 2,2 pt (98,4 % – 100,6 %) | 98,0 % – 102,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 7 | 2 (6 – 8) | 5 – 9 | 3/3 |
| … dont après la chauffe | après chauffe | — | 6 | 2 (5 – 7) | 4 – 8 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 2999 | 28,5 (2983,5 – 3012) | 2968 – 3025 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 7860 | 76 (7844,5 – 7920,5) | 7829 – 7981 | — |
| Santé moyenne | après chauffe | — | 0,22 | 0,01 (0,22 – 0,23) | 0,22 – 0,23 | — |
| Naissances d’entreprises / an | toute la partie | — | 8,4 | 6,0 (5,1 – 11,1) | 1,8 – 13,9 | — |
| Naissances / an, en % du parc moyen | toute la partie | — | 1,4 | 1,0 (0,9 – 1,9) | 0,3 – 2,3 | — |
| Morts / an, en % du parc moyen | toute la partie | — | 80,8 | 1,1 (79,9 – 81,0) | 79,1 – 81,2 | — |
| Parc moyen d’entreprises (après la chauffe) | après chauffe | — | 582,2 | 7,1 (580,6 – 587,7) | 579,0 – 593,2 | — |
| Part de la plus grande entreprise (médiane des biens) | après chauffe | — | 68,4 % | 5,1 pt (67,7 % – 72,8 %) | 66,9 % – 77,1 % | — |
| Herfindahl des ventes (médiane des biens) | après chauffe | — | 0,61 | 0,05 (0,60 – 0,65) | 0,58 – 0,69 | — |
| Fermetures : prix aberrant | toute la partie | — | 137 | 19,5 (131,5 – 151) | 126 – 165 | — |
| Fermetures : faillite (salaires impayables) | toute la partie | — | 1119 | 18,5 (1102,5 – 1121) | 1086 – 1123 | — |
| Fermetures : demande perdue | toute la partie | — | 12 | 2,5 (11 – 13,5) | 10 – 15 | — |
| Fermetures : sans employé (départs, postes non pourvus) | toute la partie | — | 21 | 4 (20,5 – 24,5) | 20 – 28 | — |
| Fermetures : autre | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Morts d’entreprises / an | toute la partie | — | 469,0 | 2,7 (468,3 – 471,0) | 467,6 – 473,0 | — |
| Entonnoir : projets envisagés | toute la partie | — | 8258 | 1319 (7557 – 8876) | 6856 – 9494 | — |
| Entonnoir : créations | toute la partie | — | 23 | 16,5 (14 – 30,5) | 5 – 38 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 171 | 156 (101 – 257) | 31 – 343 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 1055 | 838 (657,5 – 1495,5) | 260 – 1936 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 6053 | 367 (5946,5 – 6313,5) | 5840 – 6574 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 184 | 104 (182,5 – 286,5) | 181 – 389 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 539 | 279 (376,5 – 655,5) | 214 – 772 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 25 | 1 (24,5 – 25,5) | 24 – 26 | — |
| Machines en fin | dernier jour | — | 837,5 | 97,0 (744,7 – 841,7) | 651,9 – 846,0 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 131 | 12 (128,5 – 140,5) | 126 – 150 | — |
| Bonheur moyen | après chauffe | — | 0,37 | 0,01 (0,37 – 0,38) | 0,36 – 0,39 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 341,4 | 9,0 (335,1 – 344,1) | 328,7 – 346,7 | — |
| Jours de prestations réduites | après chauffe | — | 816 | 2,5 (814 – 816,5) | 812 – 817 | — |
| Trésor de l’État le plus bas | après chauffe | — | 102 694 $ | 2 481 $ (101 128 $ – 103 608 $) | 99 561 $ – 104 522 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 251 969 $ | 41 179 $ (241 767 $ – 282 946 $) | 231 565 $ – 313 922 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/3 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 3/3 | 1 | 1 – 1 | 1 – 1 | 870 j |
| Faim répandue | critique | 3/3 | 1 | 1 – 1,5 | 1 – 2 | 550 j |
| Sans-abri nombreux | critique | 3/3 | 2 | 2 – 2 | 2 – 2 | 870 j |
| Inégalités hors bornes | attention | 3/3 | 1 | 1 – 1 | 1 – 1 | 864 j |
| Richesse médiane hors bornes | attention | 3/3 | 1 | 1 – 1 | 1 – 1 | 673 j |
| Inflation quotidienne | critique | 2/3 | 1 | 0,5 – 2 | 0 – 3 | 1 j |
| Inflation sur 100 jours | critique | 1/3 | 0 | 0 – 0,5 | 0 – 1 | 0 j |
| Rupture de stock prolongée | attention | 3/3 | 1027 | 998,5 – 1030,5 | 970 – 1034 | 14666 j |
| Surstock | attention | 3/3 | 1725 | 1723,5 – 1752,5 | 1722 – 1780 | 100011 j |
| Entreprise sans employé | attention | 3/3 | 1808 | 1807 – 1818 | 1806 – 1828 | 109254 j |
| Entreprise sans client | attention | 3/3 | 2889 | 2863 – 2892 | 2837 – 2895 | 222177 j |
| Santé de la population effondrée | critique | 3/3 | 1 | 1 – 1 | 1 – 1 | 704 j |
| Productivité du travail effondrée | attention | 3/3 | 1 | 1 – 1 | 1 – 1 | 704 j |
| Embauches bloquées faute de moyens | attention | 3/3 | 1 | 1 – 1 | 1 – 1 | 781 j |
| Prix aberrant | attention | 3/3 | 425 | 425 – 441 | 425 – 457 | 210344 j |
| Attente trop longue (service public) | attention | 3/3 | 2 | 2 – 2 | 2 – 2 | 1570 j |
| Prestations réduites faute de trésor | attention | 3/3 | 1 | 1 – 1 | 1 – 1 | 816 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 57,2 % | 72,7 % | 27,6 % | 64,6 % | 0,93 | 0,098 % | 7981 (9) | 0,23 | 15 % / 41 % / 45 % | 113 | 0 $ |
| 2 | 58,2 % | 73,9 % | 30,1 % | 66,0 % | 0,93 | 0,140 % | 7860 (7) | 0,22 | 14 % / 38 % / 49 % | 120 | 6 069 $ |
| 3 | 60,0 % | 73,4 % | 33,2 % | 66,6 % | 0,93 | 0,094 % | 7829 (5) | 0,22 | 13 % / 36 % / 51 % | 114 | 1 655 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 58,8 % | 2,0 pt (57,4 % – 59,4 %) | 56,0 % – 59,9 % | 3/3 |
| Chômage max | toute la partie | — | 71,9 % | 2,7 pt (70,7 % – 73,3 %) | 69,4 % – 74,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 28,3 % | 1,8 pt (26,8 % – 28,6 %) | 25,3 % – 28,8 % | 3/3 |
| Faim max | toute la partie | — | 47,2 % | 2,0 pt (46,5 % – 48,4 %) | 45,7 % – 49,6 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 46,5 % | 0,2 pt (46,5 % – 46,7 %) | 46,4 % – 46,8 % | 3/3 |
| Sans-abri max | toute la partie | — | 67,2 % | 0,5 pt (66,9 % – 67,3 %) | 66,6 % – 67,5 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,92 | 0,002 (0,92 – 0,92) | 0,92 – 0,92 | 3/3 |
| Gini en fin de partie | dernier jour | — | 0,99 | 0,0004 (0,99 – 0,99) | 0,99 – 0,99 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,101 % | 0,010 pt (0,098 % – 0,107 %) | 0,094 % – 0,113 % | 0/3 |
| |Inflation| max / j | toute la partie | — | 3,8 % | 1,3 pt (3,7 % – 4,9 %) | 3,5 % – 6,0 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 113,3 % | 4,6 pt (112,4 % – 117,0 %) | 111,5 % – 120,8 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 6 | 0,5 (6 – 6,5) | 6 – 7 | 3/3 |
| … dont après la chauffe | après chauffe | — | 4 | 0,5 (4 – 4,5) | 4 – 5 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 3065 | 13,5 (3055,5 – 3069) | 3046 – 3073 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 6663 | 77 (6623 – 6700) | 6583 – 6737 | — |
| Santé moyenne | après chauffe | — | 0,20 | 0,002 (0,20 – 0,20) | 0,20 – 0,20 | — |
| Naissances d’entreprises / an | toute la partie | — | 2,2 | 0,2 (2,2 – 2,4) | 2,2 – 2,6 | — |
| Naissances / an, en % du parc moyen | toute la partie | — | 0,3 | 0,03 (0,3 – 0,4) | 0,3 – 0,4 | — |
| Morts / an, en % du parc moyen | toute la partie | — | 67,8 | 0,8 (67,7 – 68,5) | 67,5 – 69,1 | — |
| Parc moyen d’entreprises (après la chauffe) | après chauffe | — | 632,8 | 4,1 (628,7 – 632,8) | 624,6 – 632,9 | — |
| Part de la plus grande entreprise (médiane des biens) | après chauffe | — | 65,3 % | 5,2 pt (64,4 % – 69,5 %) | 63,4 % – 73,8 % | — |
| Herfindahl des ventes (médiane des biens) | après chauffe | — | 0,58 | 0,04 (0,57 – 0,61) | 0,57 – 0,65 | — |
| Fermetures : prix aberrant | toute la partie | — | 129 | 10 (119,5 – 129,5) | 110 – 130 | — |
| Fermetures : faillite (salaires impayables) | toute la partie | — | 996 | 4,5 (995,5 – 1000) | 995 – 1004 | — |
| Fermetures : demande perdue | toute la partie | — | 28 | 3 (27 – 30) | 26 – 32 | — |
| Fermetures : sans employé (départs, postes non pourvus) | toute la partie | — | 30 | 6,5 (24 – 30,5) | 18 – 31 | — |
| Fermetures : autre | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Morts d’entreprises / an | toute la partie | — | 428,9 | 2,2 (428,1 – 430,3) | 427,4 – 431,8 | — |
| Entonnoir : projets envisagés | toute la partie | — | 7689 | 59,5 (7666,5 – 7726) | 7644 – 7763 | — |
| Entonnoir : créations | toute la partie | — | 6 | 0,5 (6 – 6,5) | 6 – 7 | — |
| Entonnoir : refus, une création déjà ce jour | toute la partie | — | 51 | 4,5 (51 – 55,5) | 51 – 60 | — |
| Entonnoir : refus, délai entre deux créations du type | toute la partie | — | 218 | 6,5 (212 – 218,5) | 206 – 219 | — |
| Entonnoir : refus, concurrence | toute la partie | — | 6185 | 102,5 (6121,5 – 6224) | 6058 – 6263 | — |
| Entonnoir : refus, demande insuffisante | toute la partie | — | 170 | 21 (159 – 180) | 148 – 190 | — |
| Entonnoir : refus, pas assez de chômeurs qualifiés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Entonnoir : refus, viabilité | toute la partie | — | 1093 | 147,5 (1014 – 1161,5) | 935 – 1230 | — |
| Entonnoir : refus, aucun fondateur assez riche | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Types d’entreprise actifs en fin | dernier jour | — | 25 | 1 (25 – 26) | 25 – 27 | — |
| Machines en fin | dernier jour | — | 1066,9 | 7,8 (1064,4 – 1072,1) | 1061,9 – 1077,4 | — |
| Équipes utilisées à moins de 15 % (fin) | dernier jour | — | 168 | 22,5 (156 – 178,5) | 144 – 189 | — |
| Bonheur moyen | après chauffe | — | 0,35 | 0,01 (0,35 – 0,36) | 0,35 – 0,36 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 363,2 | 1,5 (362,5 – 364,0) | 361,7 – 364,8 | — |
| Jours de prestations réduites | après chauffe | — | 828 | 3 (826,5 – 829,5) | 825 – 831 | — |
| Trésor de l’État le plus bas | après chauffe | — | 44 371 $ | 3 664 $ (42 191 $ – 45 855 $) | 40 012 $ – 47 340 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 161 928 $ | 7 153 $ (156 908 $ – 164 061 $) | 151 889 $ – 166 194 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 70045,56 | 5345,11 (65337,25 – 70682,36) | 60628,94 – 71319,17 | 3/3 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 307,06 | 22,89 (289,81 – 312,69) | 272,56 – 318,33 | 3/3 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 134259,89 | 2437,47 (132535,31 – 134972,78) | 130810,72 – 135685,67 | 3/3 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/3 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/3 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/3 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 70045,56 | 65337,25 – 70682,36 | 60628,94 – 71319,17 | 3/3 | 3635887 | prix trop élevé (100 %) ; pas de revenu (0 %) |
| Renflouement d’entreprise | 307,06 | 289,81 – 312,69 | 272,56 – 318,33 | 3/3 | 28994 | par le propriétaire (90 %) ; après rachat (10 %) |
| Plancher de logement | 134259,89 | 132535,31 – 134972,78 | 130810,72 – 135685,67 | 3/3 | 7218404 | prix trop élevé (99 %) ; parc plein (1 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/3 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/3 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 3 graines · graines touchées) : Hôtel 6666 · 3, Production télé 1815 · 3, Divertissement 1703 · 3, Tourisme 1273 · 3, Garage 731 · 3, Comptabilité 529 · 3, Marketing 513 · 3, Ferme 432 · 3.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 59,9 % | 74,7 % | 28,8 % | 46,5 % | 0,92 | 0,094 % | 6583 (7) | 0,20 | 12 % / 37 % / 51 % | 110 | 1 651 $ |
| 2 | 56,0 % | 69,4 % | 25,3 % | 46,4 % | 0,92 | 0,101 % | 6663 (6) | 0,20 | 12 % / 38 % / 50 % | 110 | 1 341 $ |
| 3 | 58,8 % | 71,9 % | 28,3 % | 46,8 % | 0,92 | 0,113 % | 6737 (6) | 0,20 | 10 % / 38 % / 52 % | 113 | 2 740 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 3/3 : g1 9, g2 7, g3 5 |
| Chômage moyen ≤ 10 % | ❌ | 3/3 : g1 57,2 %, g2 58,2 %, g3 60,0 % |
| Faim et sans-abri < 2 % | ❌ | 3/3 : g1, g2, g3 |
| Gini 0,2–0,45 | ❌ | 3/3 : g1 0,93, g2 0,93, g3 0,93 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 3 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 3 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Anti-famine : 3/3 graines ; Renflouement d’entreprise : 3/3 graines ; Plancher de logement : 3/3 graines |

