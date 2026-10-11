# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 14:56
- Graines : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie), Entrée et sortie d’entreprises, Hôpital et école publics : enveloppe et file d’attente, Assurance-emploi indexée et aide sociale, Caisse : règles prudentielles, Faillite ordonnée
- Temps total : 4 min 34 s pour 210 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 5,8 % | 3,1 pt (4,0 % – 7,1 %) | 2,6 % – 7,5 % | 0/30 |
| Chômage max | toute la partie | — | 11,9 % | 1,2 pt (11,3 % – 12,5 %) | 9,6 % – 15,0 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,3 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 44,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,1 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 20,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,35 | 0,15 (0,25 – 0,40) | 0,18 – 0,44 | 2/30 |
| Gini en fin de partie | dernier jour | — | 0,37 | 0,18 (0,26 – 0,44) | 0,18 – 0,51 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,020 % | 0,009 pt (0,016 % – 0,024 %) | 0,012 % – 0,044 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 1,9 % | 1,4 pt (1,4 % – 2,8 %) | 0,7 % – 11,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 25,6 % | 13,2 pt (19,3 % – 32,5 %) | 12,1 % – 58,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 0 | 0,8 (0 – 0,8) | 0 – 2 | 8/30 |
| … dont après la chauffe | après chauffe | — | 0 | 0,8 (0 – 0,8) | 0 – 2 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 0 | 0,8 (0 – 0,8) | 0 – 15 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 57,5 | 9,8 (53 – 62,8) | 48 – 86 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,0001 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 110 631 $ | 15 947 $ (107 482 $ – 123 429 $) | 105 168 $ – 128 389 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Faim répandue | critique | 3/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Sans-abri nombreux | critique | 2/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Inflation quotidienne | critique | 6/30 | 0 | 0 – 0 | 0 – 2 | 0 j |
| Rupture de stock prolongée | attention | 30/30 | 11 | 10 – 12 | 6 – 21 | 9108 j |
| Surstock | attention | 30/30 | 11 | 8,5 – 13 | 2 – 20 | 5080,5 j |
| Entreprise sans employé | attention | 30/30 | 13 | 12 – 14 | 11 – 19 | 15373 j |
| Entreprise sans client | attention | 30/30 | 18,5 | 17 – 21 | 13 – 32 | 14925,5 j |
| Embauches bloquées faute de moyens | attention | 20/30 | 1 | 0 – 2 | 0 – 7 | 9 j |
| Prix aberrant | attention | 29/30 | 2 | 2 – 3 | 0 – 6 | 431,5 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 6,4 % | 14,2 % | 0,0 % | 0,0 % | 0,39 | 0,030 % | 86 (1) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 2 | 2,8 % | 12,1 % | 0,0 % | 0,0 % | 0,25 | 0,020 % | 60 (0) | 1,00 | 5 % / 12 % / 83 % | 11 | 0 $ |
| 3 | 4,0 % | 15,0 % | 0,3 % | 0,0 % | 0,19 | 0,032 % | 68 (2) | 1,00 | 5 % / 11 % / 83 % | 11 | 0 $ |
| 4 | 4,6 % | 10,0 % | 0,0 % | 0,0 % | 0,26 | 0,015 % | 54 (0) | 1,00 | 7 % / 12 % / 82 % | 11 | 0 $ |
| 5 | 3,4 % | 11,7 % | 0,0 % | 0,0 % | 0,25 | 0,018 % | 50 (0) | 1,00 | 6 % / 12 % / 82 % | 11 | 0 $ |
| 6 | 4,0 % | 9,6 % | 0,0 % | 0,0 % | 0,18 | 0,023 % | 57 (0) | 1,00 | 6 % / 12 % / 82 % | 11 | 0 $ |
| 7 | 7,3 % | 12,5 % | 0,0 % | 0,0 % | 0,40 | 0,027 % | 62 (1) | 1,00 | 6 % / 10 % / 84 % | 11 | 0 $ |
| 8 | 4,0 % | 10,8 % | 0,0 % | 0,0 % | 0,26 | 0,018 % | 53 (0) | 1,00 | 6 % / 12 % / 82 % | 11 | 0 $ |
| 9 | 7,4 % | 13,3 % | 0,0 % | 0,0 % | 0,40 | 0,021 % | 56 (0) | 1,00 | 6 % / 12 % / 82 % | 11 | 0 $ |
| 10 | 4,2 % | 10,0 % | 0,0 % | 0,0 % | 0,26 | 0,020 % | 48 (0) | 1,00 | 8 % / 11 % / 81 % | 11 | 0 $ |
| 11 | 7,4 % | 12,1 % | 0,0 % | 0,0 % | 0,40 | 0,012 % | 58 (0) | 1,00 | 6 % / 12 % / 83 % | 11 | 0 $ |
| 12 | 7,1 % | 12,9 % | 0,0 % | 0,0 % | 0,41 | 0,017 % | 59 (0) | 1,00 | 5 % / 12 % / 83 % | 11 | 0 $ |
| 13 | 4,4 % | 12,1 % | 0,0 % | 0,0 % | 0,26 | 0,013 % | 53 (0) | 1,00 | 7 % / 11 % / 83 % | 11 | 0 $ |
| 14 | 7,5 % | 13,3 % | 0,0 % | 0,0 % | 0,39 | 0,020 % | 52 (0) | 1,00 | 5 % / 12 % / 83 % | 11 | 0 $ |
| 15 | 7,2 % | 11,7 % | 0,0 % | 0,0 % | 0,40 | 0,024 % | 50 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 16 | 3,7 % | 11,3 % | 0,0 % | 0,0 % | 0,26 | 0,017 % | 53 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 17 | 6,9 % | 12,1 % | 0,0 % | 0,0 % | 0,44 | 0,013 % | 62 (0) | 1,00 | 6 % / 11 % / 83 % | 13 | 0 $ |
| 18 | 5,8 % | 11,7 % | 0,0 % | 0,0 % | 0,25 | 0,020 % | 58 (0) | 1,00 | 7 % / 11 % / 82 % | 11 | 0 $ |
| 19 | 3,7 % | 11,7 % | 0,0 % | 0,0 % | 0,27 | 0,015 % | 59 (0) | 1,00 | 6 % / 12 % / 83 % | 11 | 0 $ |
| 20 | 7,1 % | 12,5 % | 0,0 % | 0,0 % | 0,41 | 0,015 % | 63 (0) | 1,00 | 6 % / 11 % / 82 % | 11 | 0 $ |
| 21 | 7,1 % | 10,8 % | 0,0 % | 0,0 % | 0,39 | 0,016 % | 63 (0) | 1,00 | 7 % / 11 % / 83 % | 11 | 0 $ |
| 22 | 7,3 % | 14,2 % | 0,0 % | 0,0 % | 0,41 | 0,027 % | 50 (1) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 23 | 7,3 % | 12,1 % | 0,0 % | 0,0 % | 0,42 | 0,016 % | 57 (0) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 24 | 5,9 % | 11,7 % | 0,0 % | 0,0 % | 0,37 | 0,038 % | 73 (2) | 1,00 | 5 % / 11 % / 84 % | 13 | 0 $ |
| 25 | 6,5 % | 12,5 % | 0,0 % | 0,0 % | 0,41 | 0,044 % | 66 (2) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 26 | 2,6 % | 11,3 % | 0,0 % | 0,0 % | 0,25 | 0,024 % | 71 (1) | 1,00 | 6 % / 10 % / 84 % | 11 | 0 $ |
| 27 | 7,0 % | 12,5 % | 0,0 % | 0,0 % | 0,40 | 0,028 % | 52 (0) | 1,00 | 5 % / 11 % / 84 % | 11 | 0 $ |
| 28 | 4,6 % | 11,7 % | 0,1 % | 0,1 % | 0,25 | 0,012 % | 57 (2) | 1,00 | 5 % / 11 % / 84 % | 11 | 0 $ |
| 29 | 4,3 % | 10,4 % | 0,0 % | 0,0 % | 0,25 | 0,017 % | 68 (0) | 1,00 | 6 % / 12 % / 82 % | 11 | 0 $ |
| 30 | 3,8 % | 10,8 % | 0,0 % | 0,0 % | 0,33 | 0,025 % | 48 (0) | 1,00 | 5 % / 10 % / 84 % | 13 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 3,3 % | 1,8 pt (2,4 % – 4,2 %) | 1,4 % – 5,4 % | 0/30 |
| Chômage max | toute la partie | — | 10,0 % | 1,1 pt (9,6 % – 10,7 %) | 8,3 % – 11,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 18,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 0,2 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 10,8 pt (0,0 % – 10,8 %) | 0,0 % – 45,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,15 | 0,09 (0,14 – 0,23) | 0,12 – 0,37 | 20/30 |
| Gini en fin de partie | dernier jour | — | 0,18 | 0,14 (0,13 – 0,27) | 0,08 – 0,38 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,066 % | 0,014 pt (0,057 % – 0,072 %) | 0,036 % – 0,077 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 15,5 % | 11,8 pt (13,5 % – 25,3 %) | 7,7 % – 56,1 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 57,2 % | 22,8 pt (46,0 % – 68,8 %) | 27,7 % – 103,5 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 3,5 | 2 (3 – 5) | 1 – 6 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3,5 | 2 (3 – 5) | 1 – 6 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 4,5 | 6,5 (3 – 9,5) | 1 – 14 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 171 | 32,5 (152,5 – 185) | 120 – 222 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,0002 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 133 452 $ | 8 257 $ (128 510 $ – 136 767 $) | 112 714 $ – 143 577 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,04 | 0/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 12,32 | 5,84 (10,26 – 16,10) | 7,36 – 24,54 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 2,07 | 1/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 0,04 | 0/30 | 1 | pas de producteur (100 %) |
| Renflouement d’entreprise | 12,32 | 10,26 – 16,10 | 7,36 – 24,54 | 30/30 | 12604 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0,00 | 0,00 – 0,00 | 0,00 – 2,07 | 1/30 | 81 | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Tourisme 3676 · 30, Ferme 2489 · 30, Ordinateurs 1281 · 30, Puits de pétrole 819 · 30, Aluminerie 673 · 26, Électronique 579 · 30, Raffinerie 411 · 28, Fonderie de puces 341 · 30.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,4 % | 10,4 % | 0,0 % | 0,0 % | 0,37 | 0,061 % | 154 (2) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 2 | 3,1 % | 11,3 % | 0,0 % | 0,1 % | 0,12 | 0,063 % | 222 (5) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |
| 3 | 4,0 % | 11,7 % | 0,0 % | 0,1 % | 0,14 | 0,036 % | 144 (3) | 1,00 | 6 % / 10 % / 83 % | 11 | 0 $ |
| 4 | 2,7 % | 8,3 % | 0,0 % | 0,0 % | 0,16 | 0,063 % | 200 (2) | 1,00 | 5 % / 10 % / 85 % | 10 | 0 $ |
| 5 | 2,0 % | 9,6 % | 0,0 % | 0,0 % | 0,15 | 0,076 % | 166 (5) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 6 | 2,2 % | 9,6 % | 0,0 % | 0,0 % | 0,13 | 0,053 % | 185 (5) | 1,00 | 5 % / 9 % / 85 % | 12 | 0 $ |
| 7 | 2,6 % | 11,7 % | 0,0 % | 0,0 % | 0,18 | 0,073 % | 201 (3) | 1,00 | 5 % / 11 % / 84 % | 11 | 0 $ |
| 8 | 2,7 % | 8,3 % | 0,0 % | 0,0 % | 0,17 | 0,071 % | 152 (6) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 9 | 5,1 % | 10,8 % | 0,0 % | 0,1 % | 0,21 | 0,053 % | 181 (4) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 10 | 2,3 % | 9,6 % | 0,0 % | 0,0 % | 0,14 | 0,071 % | 181 (3) | 1,00 | 6 % / 9 % / 85 % | 10 | 0 $ |
| 11 | 3,7 % | 9,2 % | 0,0 % | 0,0 % | 0,13 | 0,072 % | 156 (5) | 1,00 | 7 % / 10 % / 84 % | 10 | 0 $ |
| 12 | 5,2 % | 9,6 % | 0,0 % | 0,0 % | 0,25 | 0,064 % | 182 (3) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 13 | 2,4 % | 11,3 % | 0,0 % | 0,0 % | 0,15 | 0,074 % | 170 (4) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 14 | 3,8 % | 10,4 % | 0,0 % | 0,0 % | 0,17 | 0,054 % | 162 (3) | 1,00 | 5 % / 9 % / 85 % | 14 | 0 $ |
| 15 | 5,1 % | 10,4 % | 0,0 % | 0,0 % | 0,30 | 0,056 % | 149 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 16 | 4,4 % | 10,0 % | 0,0 % | 0,1 % | 0,13 | 0,072 % | 187 (5) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 17 | 2,3 % | 10,0 % | 0,0 % | 0,0 % | 0,23 | 0,077 % | 159 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 18 | 1,4 % | 10,4 % | 0,0 % | 0,0 % | 0,14 | 0,072 % | 161 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 19 | 5,2 % | 10,0 % | 0,0 % | 0,1 % | 0,15 | 0,071 % | 145 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 20 | 3,5 % | 10,8 % | 0,0 % | 0,0 % | 0,12 | 0,069 % | 185 (4) | 1,00 | 6 % / 9 % / 84 % | 10 | 0 $ |
| 21 | 3,1 % | 9,6 % | 0,0 % | 0,0 % | 0,23 | 0,060 % | 189 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 22 | 5,3 % | 10,4 % | 0,0 % | 0,1 % | 0,24 | 0,068 % | 198 (5) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 23 | 3,9 % | 10,4 % | 0,0 % | 0,0 % | 0,21 | 0,077 % | 184 (5) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 24 | 4,0 % | 11,3 % | 0,0 % | 0,2 % | 0,14 | 0,052 % | 120 (4) | 1,00 | 5 % / 10 % / 85 % | 10 | 0 $ |
| 25 | 4,1 % | 9,6 % | 0,0 % | 0,0 % | 0,35 | 0,054 % | 152 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 26 | 2,2 % | 8,8 % | 0,0 % | 0,0 % | 0,15 | 0,069 % | 183 (4) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 27 | 4,2 % | 10,0 % | 0,0 % | 0,0 % | 0,28 | 0,064 % | 186 (3) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 28 | 1,5 % | 11,7 % | 0,0 % | 0,1 % | 0,15 | 0,073 % | 172 (5) | 1,00 | 5 % / 10 % / 84 % | 13 | 0 $ |
| 29 | 2,4 % | 9,6 % | 0,0 % | 0,0 % | 0,17 | 0,045 % | 149 (1) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 30 | 2,6 % | 9,6 % | 0,0 % | 0,0 % | 0,13 | 0,063 % | 134 (3) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |

</details>

## 2 bis (1). Avec filets, sauf « Anti-famine »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 3,3 % | 1,8 pt (2,4 % – 4,2 %) | 1,4 % – 5,4 % | 0/30 |
| Chômage max | toute la partie | — | 10,0 % | 1,1 pt (9,6 % – 10,7 %) | 8,3 % – 11,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 18,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 0,2 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 10,8 pt (0,0 % – 10,8 %) | 0,0 % – 45,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,15 | 0,09 (0,14 – 0,23) | 0,12 – 0,37 | 20/30 |
| Gini en fin de partie | dernier jour | — | 0,18 | 0,14 (0,13 – 0,27) | 0,08 – 0,38 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,066 % | 0,014 pt (0,057 % – 0,072 %) | 0,036 % – 0,077 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 15,5 % | 11,8 pt (13,5 % – 25,3 %) | 7,7 % – 56,1 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 57,2 % | 22,8 pt (46,0 % – 68,8 %) | 27,7 % – 103,5 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 3,5 | 2 (3 – 5) | 1 – 6 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3,5 | 2 (3 – 5) | 1 – 6 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 4,5 | 6,5 (3 – 9,5) | 1 – 14 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 171 | 32,5 (152,5 – 185) | 120 – 222 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,0002 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 133 452 $ | 8 257 $ (128 510 $ – 136 767 $) | 112 714 $ – 143 577 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 12,32 | 5,84 (10,26 – 16,10) | 7,36 – 24,54 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 2,07 | 1/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | coupé | — | — | — | — | — |
| Renflouement d’entreprise | 12,32 | 10,26 – 16,10 | 7,36 – 24,54 | 30/30 | 12604 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0,00 | 0,00 – 0,00 | 0,00 – 2,07 | 1/30 | 81 | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Tourisme 3676 · 30, Ferme 2489 · 30, Ordinateurs 1281 · 30, Puits de pétrole 819 · 30, Aluminerie 673 · 26, Électronique 579 · 30, Raffinerie 411 · 28, Fonderie de puces 341 · 30.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-famine »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 3,3 % | 3,3 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 10,0 % | 10,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,15 | 0,15 | 20 → 20 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,18 | 0,18 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,066 % | 0,066 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 15,5 % | 15,5 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 57,2 % | 57,2 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 3,5 | 3,5 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 3,5 | 3,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 4,5 | 4,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 171 | 171 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 133 452 $ | 133 452 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 12,32 | 12,32 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-famine »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,4 % | 10,4 % | 0,0 % | 0,0 % | 0,37 | 0,061 % | 154 (2) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 2 | 3,1 % | 11,3 % | 0,0 % | 0,1 % | 0,12 | 0,063 % | 222 (5) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |
| 3 | 4,0 % | 11,7 % | 0,0 % | 0,1 % | 0,14 | 0,036 % | 144 (3) | 1,00 | 6 % / 10 % / 83 % | 11 | 0 $ |
| 4 | 2,7 % | 8,3 % | 0,0 % | 0,0 % | 0,16 | 0,063 % | 200 (2) | 1,00 | 5 % / 10 % / 85 % | 10 | 0 $ |
| 5 | 2,0 % | 9,6 % | 0,0 % | 0,0 % | 0,15 | 0,076 % | 166 (5) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 6 | 2,2 % | 9,6 % | 0,0 % | 0,0 % | 0,13 | 0,053 % | 185 (5) | 1,00 | 5 % / 9 % / 85 % | 12 | 0 $ |
| 7 | 2,6 % | 11,7 % | 0,0 % | 0,0 % | 0,18 | 0,073 % | 201 (3) | 1,00 | 5 % / 11 % / 84 % | 11 | 0 $ |
| 8 | 2,7 % | 8,3 % | 0,0 % | 0,0 % | 0,17 | 0,071 % | 152 (6) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 9 | 5,1 % | 10,8 % | 0,0 % | 0,1 % | 0,21 | 0,053 % | 181 (4) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 10 | 2,3 % | 9,6 % | 0,0 % | 0,0 % | 0,14 | 0,071 % | 181 (3) | 1,00 | 6 % / 9 % / 85 % | 10 | 0 $ |
| 11 | 3,7 % | 9,2 % | 0,0 % | 0,0 % | 0,13 | 0,072 % | 156 (5) | 1,00 | 7 % / 10 % / 84 % | 10 | 0 $ |
| 12 | 5,2 % | 9,6 % | 0,0 % | 0,0 % | 0,25 | 0,064 % | 182 (3) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 13 | 2,4 % | 11,3 % | 0,0 % | 0,0 % | 0,15 | 0,074 % | 170 (4) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 14 | 3,8 % | 10,4 % | 0,0 % | 0,0 % | 0,17 | 0,054 % | 162 (3) | 1,00 | 5 % / 9 % / 85 % | 14 | 0 $ |
| 15 | 5,1 % | 10,4 % | 0,0 % | 0,0 % | 0,30 | 0,056 % | 149 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 16 | 4,4 % | 10,0 % | 0,0 % | 0,1 % | 0,13 | 0,072 % | 187 (5) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 17 | 2,3 % | 10,0 % | 0,0 % | 0,0 % | 0,23 | 0,077 % | 159 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 18 | 1,4 % | 10,4 % | 0,0 % | 0,0 % | 0,14 | 0,072 % | 161 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 19 | 5,2 % | 10,0 % | 0,0 % | 0,1 % | 0,15 | 0,071 % | 145 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 20 | 3,5 % | 10,8 % | 0,0 % | 0,0 % | 0,12 | 0,069 % | 185 (4) | 1,00 | 6 % / 9 % / 84 % | 10 | 0 $ |
| 21 | 3,1 % | 9,6 % | 0,0 % | 0,0 % | 0,23 | 0,060 % | 189 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 22 | 5,3 % | 10,4 % | 0,0 % | 0,1 % | 0,24 | 0,068 % | 198 (5) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 23 | 3,9 % | 10,4 % | 0,0 % | 0,0 % | 0,21 | 0,077 % | 184 (5) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 24 | 4,0 % | 11,3 % | 0,0 % | 0,2 % | 0,14 | 0,052 % | 120 (4) | 1,00 | 5 % / 10 % / 85 % | 10 | 0 $ |
| 25 | 4,1 % | 9,6 % | 0,0 % | 0,0 % | 0,35 | 0,054 % | 152 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 26 | 2,2 % | 8,8 % | 0,0 % | 0,0 % | 0,15 | 0,069 % | 183 (4) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 27 | 4,2 % | 10,0 % | 0,0 % | 0,0 % | 0,28 | 0,064 % | 186 (3) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 28 | 1,5 % | 11,7 % | 0,0 % | 0,1 % | 0,15 | 0,073 % | 172 (5) | 1,00 | 5 % / 10 % / 84 % | 13 | 0 $ |
| 29 | 2,4 % | 9,6 % | 0,0 % | 0,0 % | 0,17 | 0,045 % | 149 (1) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 30 | 2,6 % | 9,6 % | 0,0 % | 0,0 % | 0,13 | 0,063 % | 134 (3) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |

</details>

## 2 bis (2). Avec filets, sauf « Renflouement d’entreprise »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 5,8 % | 3,1 pt (4,0 % – 7,1 %) | 2,6 % – 7,5 % | 0/30 |
| Chômage max | toute la partie | — | 11,9 % | 1,2 pt (11,3 % – 12,5 %) | 9,6 % – 15,0 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,2 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 44,2 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 9,2 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,35 | 0,15 (0,25 – 0,40) | 0,18 – 0,44 | 2/30 |
| Gini en fin de partie | dernier jour | — | 0,37 | 0,18 (0,26 – 0,44) | 0,17 – 0,51 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,020 % | 0,009 pt (0,016 % – 0,024 %) | 0,009 % – 0,044 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 1,9 % | 1,4 pt (1,4 % – 2,8 %) | 0,7 % – 11,6 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 25,6 % | 13,2 pt (19,3 % – 32,5 %) | 12,1 % – 58,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 0 | 0,8 (0 – 0,8) | 0 – 2 | 8/30 |
| … dont après la chauffe | après chauffe | — | 0 | 0,8 (0 – 0,8) | 0 – 2 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 0 | 0,8 (0 – 0,8) | 0 – 15 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 57,5 | 9,8 (53 – 62,8) | 48 – 86 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,0001 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 110 631 $ | 15 947 $ (107 482 $ – 123 429 $) | 105 168 $ – 128 389 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 2,11 | 1/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 2,11 | 1/30 | 64 | pas de producteur (100 %) |
| Renflouement d’entreprise | coupé | — | — | — | — | — |
| Plancher de logement | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « renflouement d’entreprise »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 3,3 % | 5,8 % | 0 → 0 | +2,0 pt | [+1,9 pt ; +2,6 pt] | 4 / 26 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 10,0 % | 11,9 % | — | +1,7 pt | [+1,2 pt ; +2,5 pt] | 0 / 28 / 2 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 3 / 26 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 3 / 26 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [−0,01 pt ; 0,0 pt] | 12 / 0 / 18 sur 30 | non concluant |
| Sans-abri max | 0,0 % | 0,0 % | — | 0,0 pt | [−7,1 pt ; 0,0 pt] | 12 / 0 / 18 sur 30 | non concluant |
| Gini moyen | 0,15 | 0,35 | 20 → 2 | +0,12 | [+0,10 ; +0,17] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,18 | 0,37 | — | +0,13 | [+0,09 ; +0,17] | — / — / 0 | **B plus haut** |
| Inflation moyenne / j | 0,066 % | 0,020 % | 0 → 0 | −0,046 pt | [−0,053 pt ; −0,038 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 15,5 % | 1,9 % | — | −13,9 pt | [−18,4 pt ; −11,2 pt] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| |Inflation sur 100 j| max | 57,2 % | 25,6 % | — | −30,3 pt | [−39,3 pt ; −27,6 pt] | 28 / 2 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes critiques ouvertes | 3,5 | 0 | 30 → 8 | −3 | [−4 ; −3] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| … dont après la chauffe | 3,5 | 0 | — | −3 | [−4 ; −3] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Jours-alerte critiques (somme des types) | 4,5 | 0 | — | −3,5 | [−5,5 ; −3] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 171 | 57,5 | — | −115,5 | [−125,5 ; −99] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Santé moyenne | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 1,00 | 1,00 | — | −0,0001 | [−0,0001 ; −0,0001] | 8 / 22 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 133 452 $ | 110 631 $ | — | −16 206 $ | [−19 095 $ ; −13 506 $] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 0 → 1 | 0,00 | [0,00 ; 0,00] | 1 / 3 / 26 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 1 → 0 | 0,00 | [0,00 ; 0,00] | 7 / 0 / 23 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « renflouement d’entreprise »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 6,4 % | 14,2 % | 0,0 % | 0,0 % | 0,39 | 0,030 % | 86 (1) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 2 | 2,8 % | 12,1 % | 0,0 % | 0,0 % | 0,25 | 0,020 % | 60 (0) | 1,00 | 5 % / 12 % / 83 % | 11 | 0 $ |
| 3 | 3,8 % | 15,0 % | 0,2 % | 0,0 % | 0,19 | 0,033 % | 66 (2) | 1,00 | 5 % / 13 % / 83 % | 11 | 0 $ |
| 4 | 4,6 % | 10,0 % | 0,0 % | 0,0 % | 0,26 | 0,015 % | 54 (0) | 1,00 | 7 % / 12 % / 82 % | 11 | 0 $ |
| 5 | 3,4 % | 11,7 % | 0,0 % | 0,0 % | 0,25 | 0,018 % | 50 (0) | 1,00 | 6 % / 12 % / 82 % | 11 | 0 $ |
| 6 | 4,0 % | 9,6 % | 0,0 % | 0,0 % | 0,18 | 0,023 % | 57 (0) | 1,00 | 6 % / 12 % / 82 % | 11 | 0 $ |
| 7 | 7,3 % | 12,5 % | 0,0 % | 0,0 % | 0,40 | 0,027 % | 62 (1) | 1,00 | 6 % / 10 % / 84 % | 11 | 0 $ |
| 8 | 4,0 % | 10,8 % | 0,0 % | 0,0 % | 0,26 | 0,018 % | 53 (0) | 1,00 | 6 % / 12 % / 82 % | 11 | 0 $ |
| 9 | 7,4 % | 13,3 % | 0,0 % | 0,0 % | 0,40 | 0,021 % | 56 (0) | 1,00 | 6 % / 12 % / 82 % | 11 | 0 $ |
| 10 | 4,2 % | 10,0 % | 0,0 % | 0,0 % | 0,26 | 0,020 % | 48 (0) | 1,00 | 8 % / 11 % / 81 % | 11 | 0 $ |
| 11 | 7,4 % | 12,1 % | 0,0 % | 0,0 % | 0,40 | 0,012 % | 58 (0) | 1,00 | 6 % / 12 % / 83 % | 11 | 0 $ |
| 12 | 7,1 % | 12,9 % | 0,0 % | 0,0 % | 0,41 | 0,017 % | 59 (0) | 1,00 | 5 % / 12 % / 83 % | 11 | 0 $ |
| 13 | 4,4 % | 12,1 % | 0,0 % | 0,0 % | 0,26 | 0,013 % | 53 (0) | 1,00 | 7 % / 11 % / 83 % | 11 | 0 $ |
| 14 | 7,5 % | 13,3 % | 0,0 % | 0,0 % | 0,39 | 0,020 % | 52 (0) | 1,00 | 5 % / 12 % / 83 % | 11 | 0 $ |
| 15 | 7,2 % | 11,7 % | 0,0 % | 0,0 % | 0,40 | 0,024 % | 50 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 16 | 3,7 % | 11,3 % | 0,0 % | 0,0 % | 0,26 | 0,017 % | 53 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 17 | 6,9 % | 12,1 % | 0,0 % | 0,0 % | 0,44 | 0,013 % | 62 (0) | 1,00 | 6 % / 11 % / 83 % | 13 | 0 $ |
| 18 | 5,8 % | 11,7 % | 0,0 % | 0,0 % | 0,25 | 0,020 % | 58 (0) | 1,00 | 7 % / 11 % / 82 % | 11 | 0 $ |
| 19 | 3,7 % | 11,7 % | 0,0 % | 0,0 % | 0,27 | 0,015 % | 59 (0) | 1,00 | 6 % / 12 % / 83 % | 11 | 0 $ |
| 20 | 7,1 % | 12,5 % | 0,0 % | 0,0 % | 0,41 | 0,015 % | 63 (0) | 1,00 | 6 % / 11 % / 82 % | 11 | 0 $ |
| 21 | 7,1 % | 10,8 % | 0,0 % | 0,0 % | 0,39 | 0,016 % | 63 (0) | 1,00 | 7 % / 11 % / 83 % | 11 | 0 $ |
| 22 | 7,3 % | 14,2 % | 0,0 % | 0,0 % | 0,41 | 0,027 % | 50 (1) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 23 | 7,3 % | 12,1 % | 0,0 % | 0,0 % | 0,42 | 0,016 % | 57 (0) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 24 | 5,9 % | 11,7 % | 0,0 % | 0,0 % | 0,37 | 0,038 % | 73 (2) | 1,00 | 5 % / 11 % / 84 % | 13 | 0 $ |
| 25 | 6,5 % | 12,5 % | 0,0 % | 0,0 % | 0,41 | 0,044 % | 66 (2) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 26 | 2,6 % | 11,3 % | 0,0 % | 0,0 % | 0,25 | 0,024 % | 71 (1) | 1,00 | 6 % / 10 % / 84 % | 11 | 0 $ |
| 27 | 7,0 % | 12,5 % | 0,0 % | 0,0 % | 0,40 | 0,028 % | 52 (0) | 1,00 | 5 % / 11 % / 84 % | 11 | 0 $ |
| 28 | 4,5 % | 11,7 % | 0,1 % | 0,0 % | 0,25 | 0,009 % | 57 (2) | 1,00 | 5 % / 11 % / 83 % | 11 | 0 $ |
| 29 | 4,3 % | 10,4 % | 0,0 % | 0,0 % | 0,25 | 0,017 % | 68 (0) | 1,00 | 6 % / 12 % / 82 % | 11 | 0 $ |
| 30 | 3,8 % | 10,8 % | 0,0 % | 0,0 % | 0,33 | 0,025 % | 48 (0) | 1,00 | 5 % / 10 % / 84 % | 13 | 0 $ |

</details>

## 2 bis (3). Avec filets, sauf « Plancher de logement »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 3,3 % | 2,0 pt (2,3 % – 4,3 %) | 1,4 % – 5,4 % | 0/30 |
| Chômage max | toute la partie | — | 10,0 % | 1,1 pt (9,6 % – 10,7 %) | 8,3 % – 11,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 18,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 0,3 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 10,8 pt (0,0 % – 10,8 %) | 0,0 % – 50,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,16 | 0,09 (0,14 – 0,23) | 0,12 – 0,37 | 20/30 |
| Gini en fin de partie | dernier jour | — | 0,17 | 0,14 (0,13 – 0,27) | 0,08 – 0,38 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,067 % | 0,015 pt (0,057 % – 0,072 %) | 0,036 % – 0,078 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 15,8 % | 12,3 pt (14,1 % – 26,3 %) | 7,7 % – 56,1 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 58,1 % | 22,8 pt (46,0 % – 68,8 %) | 27,7 % – 103,5 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 3,5 | 2 (3 – 5) | 1 – 7 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3,5 | 2 (3 – 5) | 1 – 7 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 4,5 | 7 (3 – 10) | 1 – 17 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 171 | 32,3 (152,5 – 184,8) | 115 – 207 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,0002 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 132 900 $ | 8 257 $ (128 510 $ – 136 767 $) | 112 714 $ – 143 577 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,04 | 0/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 12,32 | 5,96 (9,90 – 15,86) | 7,36 – 24,54 | 30/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 0,04 | 0/30 | 1 | pas de producteur (100 %) |
| Renflouement d’entreprise | 12,32 | 9,90 – 15,86 | 7,36 – 24,54 | 30/30 | 12564 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | coupé | — | — | — | — | — |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Tourisme 3702 · 30, Ferme 2383 · 30, Ordinateurs 1345 · 30, Puits de pétrole 803 · 30, Aluminerie 718 · 26, Électronique 578 · 30, Raffinerie 349 · 28, Fonderie de puces 343 · 30.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plancher de logement »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 3,3 % | 3,3 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 3 / 3 / 24 sur 30 | non concluant |
| Chômage max | 10,0 % | 10,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 7 / 23 sur 30 | non concluant |
| Sans-abri max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 3 / 27 sur 30 | non concluant |
| Gini moyen | 0,15 | 0,16 | 20 → 20 | 0,00 | [0,00 ; 0,00] | — / — / 24 | non concluant |
| Gini en fin de partie | 0,18 | 0,17 | — | 0,00 | [0,00 ; 0,00] | — / — / 24 | non concluant |
| Inflation moyenne / j | 0,066 % | 0,067 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 24 | non concluant |
| |Inflation| max / j | 15,5 % | 15,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| |Inflation sur 100 j| max | 57,2 % | 58,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 2 / 28 sur 30 | non concluant |
| Alertes critiques ouvertes | 3,5 | 3,5 | 30 → 30 | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| … dont après la chauffe | 3,5 | 3,5 | — | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 4,5 | 4,5 | — | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 171 | 171 | — | 0 | [0 ; 0] | 5 / 1 / 24 sur 30 | non concluant |
| Santé moyenne | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 2 / 4 / 24 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 133 452 $ | 132 900 $ | — | 0 $ | [0 $ ; 0 $] | 1 / 1 / 28 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 12,32 | 12,32 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 3 / 3 / 24 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plancher de logement »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,4 % | 10,4 % | 0,0 % | 0,0 % | 0,37 | 0,061 % | 154 (2) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 2 | 2,2 % | 11,3 % | 0,0 % | 0,1 % | 0,13 | 0,078 % | 175 (7) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 3 | 4,4 % | 11,7 % | 0,0 % | 0,1 % | 0,16 | 0,036 % | 142 (3) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 4 | 2,7 % | 8,3 % | 0,0 % | 0,0 % | 0,16 | 0,063 % | 200 (2) | 1,00 | 5 % / 10 % / 85 % | 10 | 0 $ |
| 5 | 2,0 % | 9,6 % | 0,0 % | 0,0 % | 0,15 | 0,076 % | 166 (5) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 6 | 2,2 % | 9,6 % | 0,0 % | 0,0 % | 0,13 | 0,053 % | 185 (5) | 1,00 | 5 % / 9 % / 85 % | 12 | 0 $ |
| 7 | 2,6 % | 11,7 % | 0,0 % | 0,0 % | 0,18 | 0,073 % | 201 (3) | 1,00 | 5 % / 11 % / 84 % | 11 | 0 $ |
| 8 | 2,7 % | 8,3 % | 0,0 % | 0,0 % | 0,17 | 0,071 % | 152 (6) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 9 | 5,1 % | 10,8 % | 0,0 % | 0,1 % | 0,21 | 0,052 % | 180 (4) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 10 | 2,3 % | 9,6 % | 0,0 % | 0,0 % | 0,14 | 0,071 % | 181 (3) | 1,00 | 6 % / 9 % / 85 % | 10 | 0 $ |
| 11 | 3,7 % | 9,2 % | 0,0 % | 0,0 % | 0,13 | 0,072 % | 156 (5) | 1,00 | 7 % / 10 % / 84 % | 10 | 0 $ |
| 12 | 5,2 % | 9,6 % | 0,0 % | 0,0 % | 0,25 | 0,064 % | 182 (3) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 13 | 2,4 % | 11,3 % | 0,0 % | 0,0 % | 0,15 | 0,074 % | 170 (4) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 14 | 3,8 % | 10,4 % | 0,0 % | 0,0 % | 0,17 | 0,054 % | 162 (3) | 1,00 | 5 % / 9 % / 85 % | 14 | 0 $ |
| 15 | 5,1 % | 10,4 % | 0,0 % | 0,0 % | 0,30 | 0,056 % | 149 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 16 | 4,4 % | 10,0 % | 0,0 % | 0,1 % | 0,13 | 0,066 % | 207 (4) | 1,00 | 5 % / 11 % / 84 % | 7 | 0 $ |
| 17 | 2,3 % | 10,0 % | 0,0 % | 0,0 % | 0,23 | 0,077 % | 159 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 18 | 1,4 % | 10,4 % | 0,0 % | 0,0 % | 0,14 | 0,072 % | 161 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 19 | 4,2 % | 10,0 % | 0,0 % | 0,1 % | 0,13 | 0,070 % | 128 (3) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |
| 20 | 3,5 % | 10,8 % | 0,0 % | 0,0 % | 0,12 | 0,069 % | 185 (4) | 1,00 | 6 % / 9 % / 84 % | 10 | 0 $ |
| 21 | 3,1 % | 9,6 % | 0,0 % | 0,0 % | 0,23 | 0,060 % | 189 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 22 | 5,3 % | 10,4 % | 0,0 % | 0,1 % | 0,24 | 0,068 % | 198 (5) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 23 | 3,9 % | 10,4 % | 0,0 % | 0,0 % | 0,21 | 0,077 % | 184 (5) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 24 | 5,4 % | 11,3 % | 0,0 % | 0,3 % | 0,14 | 0,056 % | 115 (5) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |
| 25 | 4,1 % | 9,6 % | 0,0 % | 0,0 % | 0,35 | 0,054 % | 152 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 26 | 2,2 % | 8,8 % | 0,0 % | 0,0 % | 0,15 | 0,069 % | 183 (4) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 27 | 4,2 % | 10,0 % | 0,0 % | 0,0 % | 0,28 | 0,064 % | 186 (3) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 28 | 1,5 % | 11,7 % | 0,0 % | 0,1 % | 0,15 | 0,073 % | 172 (5) | 1,00 | 5 % / 10 % / 84 % | 13 | 0 $ |
| 29 | 2,4 % | 9,6 % | 0,0 % | 0,0 % | 0,17 | 0,045 % | 149 (1) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 30 | 2,6 % | 9,6 % | 0,0 % | 0,0 % | 0,13 | 0,063 % | 134 (3) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |

</details>

## 2 bis (4). Avec filets, sauf « Plafond de dérive des prix et salaires »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 3,3 % | 1,8 pt (2,4 % – 4,2 %) | 1,4 % – 5,4 % | 0/30 |
| Chômage max | toute la partie | — | 10,0 % | 1,1 pt (9,6 % – 10,7 %) | 8,3 % – 11,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 18,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 0,2 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 10,8 pt (0,0 % – 10,8 %) | 0,0 % – 45,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,15 | 0,09 (0,14 – 0,23) | 0,12 – 0,37 | 20/30 |
| Gini en fin de partie | dernier jour | — | 0,18 | 0,14 (0,13 – 0,27) | 0,08 – 0,38 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,066 % | 0,014 pt (0,057 % – 0,072 %) | 0,036 % – 0,077 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 15,5 % | 11,8 pt (13,5 % – 25,3 %) | 7,7 % – 56,1 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 57,2 % | 22,8 pt (46,0 % – 68,8 %) | 27,7 % – 103,5 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 3,5 | 2 (3 – 5) | 1 – 6 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3,5 | 2 (3 – 5) | 1 – 6 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 4,5 | 6,5 (3 – 9,5) | 1 – 14 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 171 | 32,5 (152,5 – 185) | 120 – 222 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,0002 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 133 452 $ | 8 257 $ (128 510 $ – 136 767 $) | 112 714 $ – 143 577 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,04 | 0/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 12,32 | 5,84 (10,26 – 16,10) | 7,36 – 24,54 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 2,07 | 1/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 0,04 | 0/30 | 1 | pas de producteur (100 %) |
| Renflouement d’entreprise | 12,32 | 10,26 – 16,10 | 7,36 – 24,54 | 30/30 | 12604 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0,00 | 0,00 – 0,00 | 0,00 – 2,07 | 1/30 | 81 | parc plein (100 %) |
| Plafond de dérive des prix et salaires | coupé | — | — | — | — | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Tourisme 3676 · 30, Ferme 2489 · 30, Ordinateurs 1281 · 30, Puits de pétrole 819 · 30, Aluminerie 673 · 26, Électronique 579 · 30, Raffinerie 411 · 28, Fonderie de puces 341 · 30.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plafond de dérive des prix et salaires »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 3,3 % | 3,3 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 10,0 % | 10,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,15 | 0,15 | 20 → 20 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,18 | 0,18 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,066 % | 0,066 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 15,5 % | 15,5 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 57,2 % | 57,2 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 3,5 | 3,5 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 3,5 | 3,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 4,5 | 4,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 171 | 171 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 133 452 $ | 133 452 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 12,32 | 12,32 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plafond de dérive des prix et salaires »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,4 % | 10,4 % | 0,0 % | 0,0 % | 0,37 | 0,061 % | 154 (2) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 2 | 3,1 % | 11,3 % | 0,0 % | 0,1 % | 0,12 | 0,063 % | 222 (5) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |
| 3 | 4,0 % | 11,7 % | 0,0 % | 0,1 % | 0,14 | 0,036 % | 144 (3) | 1,00 | 6 % / 10 % / 83 % | 11 | 0 $ |
| 4 | 2,7 % | 8,3 % | 0,0 % | 0,0 % | 0,16 | 0,063 % | 200 (2) | 1,00 | 5 % / 10 % / 85 % | 10 | 0 $ |
| 5 | 2,0 % | 9,6 % | 0,0 % | 0,0 % | 0,15 | 0,076 % | 166 (5) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 6 | 2,2 % | 9,6 % | 0,0 % | 0,0 % | 0,13 | 0,053 % | 185 (5) | 1,00 | 5 % / 9 % / 85 % | 12 | 0 $ |
| 7 | 2,6 % | 11,7 % | 0,0 % | 0,0 % | 0,18 | 0,073 % | 201 (3) | 1,00 | 5 % / 11 % / 84 % | 11 | 0 $ |
| 8 | 2,7 % | 8,3 % | 0,0 % | 0,0 % | 0,17 | 0,071 % | 152 (6) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 9 | 5,1 % | 10,8 % | 0,0 % | 0,1 % | 0,21 | 0,053 % | 181 (4) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 10 | 2,3 % | 9,6 % | 0,0 % | 0,0 % | 0,14 | 0,071 % | 181 (3) | 1,00 | 6 % / 9 % / 85 % | 10 | 0 $ |
| 11 | 3,7 % | 9,2 % | 0,0 % | 0,0 % | 0,13 | 0,072 % | 156 (5) | 1,00 | 7 % / 10 % / 84 % | 10 | 0 $ |
| 12 | 5,2 % | 9,6 % | 0,0 % | 0,0 % | 0,25 | 0,064 % | 182 (3) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 13 | 2,4 % | 11,3 % | 0,0 % | 0,0 % | 0,15 | 0,074 % | 170 (4) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 14 | 3,8 % | 10,4 % | 0,0 % | 0,0 % | 0,17 | 0,054 % | 162 (3) | 1,00 | 5 % / 9 % / 85 % | 14 | 0 $ |
| 15 | 5,1 % | 10,4 % | 0,0 % | 0,0 % | 0,30 | 0,056 % | 149 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 16 | 4,4 % | 10,0 % | 0,0 % | 0,1 % | 0,13 | 0,072 % | 187 (5) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 17 | 2,3 % | 10,0 % | 0,0 % | 0,0 % | 0,23 | 0,077 % | 159 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 18 | 1,4 % | 10,4 % | 0,0 % | 0,0 % | 0,14 | 0,072 % | 161 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 19 | 5,2 % | 10,0 % | 0,0 % | 0,1 % | 0,15 | 0,071 % | 145 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 20 | 3,5 % | 10,8 % | 0,0 % | 0,0 % | 0,12 | 0,069 % | 185 (4) | 1,00 | 6 % / 9 % / 84 % | 10 | 0 $ |
| 21 | 3,1 % | 9,6 % | 0,0 % | 0,0 % | 0,23 | 0,060 % | 189 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 22 | 5,3 % | 10,4 % | 0,0 % | 0,1 % | 0,24 | 0,068 % | 198 (5) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 23 | 3,9 % | 10,4 % | 0,0 % | 0,0 % | 0,21 | 0,077 % | 184 (5) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 24 | 4,0 % | 11,3 % | 0,0 % | 0,2 % | 0,14 | 0,052 % | 120 (4) | 1,00 | 5 % / 10 % / 85 % | 10 | 0 $ |
| 25 | 4,1 % | 9,6 % | 0,0 % | 0,0 % | 0,35 | 0,054 % | 152 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 26 | 2,2 % | 8,8 % | 0,0 % | 0,0 % | 0,15 | 0,069 % | 183 (4) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 27 | 4,2 % | 10,0 % | 0,0 % | 0,0 % | 0,28 | 0,064 % | 186 (3) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 28 | 1,5 % | 11,7 % | 0,0 % | 0,1 % | 0,15 | 0,073 % | 172 (5) | 1,00 | 5 % / 10 % / 84 % | 13 | 0 $ |
| 29 | 2,4 % | 9,6 % | 0,0 % | 0,0 % | 0,17 | 0,045 % | 149 (1) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 30 | 2,6 % | 9,6 % | 0,0 % | 0,0 % | 0,13 | 0,063 % | 134 (3) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |

</details>

## 2 bis (5). Avec filets, sauf « Anti-crédit-fou »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 3,3 % | 1,8 pt (2,4 % – 4,2 %) | 1,4 % – 5,4 % | 0/30 |
| Chômage max | toute la partie | — | 10,0 % | 1,1 pt (9,6 % – 10,7 %) | 8,3 % – 11,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 18,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,1 pt (0,0 % – 0,1 %) | 0,0 % – 0,2 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 10,8 pt (0,0 % – 10,8 %) | 0,0 % – 45,0 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,15 | 0,09 (0,14 – 0,23) | 0,12 – 0,37 | 20/30 |
| Gini en fin de partie | dernier jour | — | 0,18 | 0,14 (0,13 – 0,27) | 0,08 – 0,38 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,066 % | 0,014 pt (0,057 % – 0,072 %) | 0,036 % – 0,077 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 15,5 % | 11,8 pt (13,5 % – 25,3 %) | 7,7 % – 56,1 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 57,2 % | 22,8 pt (46,0 % – 68,8 %) | 27,7 % – 103,5 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 3,5 | 2 (3 – 5) | 1 – 6 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3,5 | 2 (3 – 5) | 1 – 6 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 4,5 | 6,5 (3 – 9,5) | 1 – 14 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 171 | 32,5 (152,5 – 185) | 120 – 222 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,0002 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 133 452 $ | 8 257 $ (128 510 $ – 136 767 $) | 112 714 $ – 143 577 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,04 | 0/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 12,32 | 5,84 (10,26 – 16,10) | 7,36 – 24,54 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 2,07 | 1/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 0,04 | 0/30 | 1 | pas de producteur (100 %) |
| Renflouement d’entreprise | 12,32 | 10,26 – 16,10 | 7,36 – 24,54 | 30/30 | 12604 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0,00 | 0,00 – 0,00 | 0,00 – 2,07 | 1/30 | 81 | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | coupé | — | — | — | — | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Tourisme 3676 · 30, Ferme 2489 · 30, Ordinateurs 1281 · 30, Puits de pétrole 819 · 30, Aluminerie 673 · 26, Électronique 579 · 30, Raffinerie 411 · 28, Fonderie de puces 341 · 30.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-crédit-fou »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 3,3 % | 3,3 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 10,0 % | 10,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,15 | 0,15 | 20 → 20 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,18 | 0,18 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,066 % | 0,066 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 15,5 % | 15,5 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 57,2 % | 57,2 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 3,5 | 3,5 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 3,5 | 3,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 4,5 | 4,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 171 | 171 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 133 452 $ | 133 452 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 12,32 | 12,32 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-crédit-fou »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,4 % | 10,4 % | 0,0 % | 0,0 % | 0,37 | 0,061 % | 154 (2) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 2 | 3,1 % | 11,3 % | 0,0 % | 0,1 % | 0,12 | 0,063 % | 222 (5) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |
| 3 | 4,0 % | 11,7 % | 0,0 % | 0,1 % | 0,14 | 0,036 % | 144 (3) | 1,00 | 6 % / 10 % / 83 % | 11 | 0 $ |
| 4 | 2,7 % | 8,3 % | 0,0 % | 0,0 % | 0,16 | 0,063 % | 200 (2) | 1,00 | 5 % / 10 % / 85 % | 10 | 0 $ |
| 5 | 2,0 % | 9,6 % | 0,0 % | 0,0 % | 0,15 | 0,076 % | 166 (5) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 6 | 2,2 % | 9,6 % | 0,0 % | 0,0 % | 0,13 | 0,053 % | 185 (5) | 1,00 | 5 % / 9 % / 85 % | 12 | 0 $ |
| 7 | 2,6 % | 11,7 % | 0,0 % | 0,0 % | 0,18 | 0,073 % | 201 (3) | 1,00 | 5 % / 11 % / 84 % | 11 | 0 $ |
| 8 | 2,7 % | 8,3 % | 0,0 % | 0,0 % | 0,17 | 0,071 % | 152 (6) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 9 | 5,1 % | 10,8 % | 0,0 % | 0,1 % | 0,21 | 0,053 % | 181 (4) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 10 | 2,3 % | 9,6 % | 0,0 % | 0,0 % | 0,14 | 0,071 % | 181 (3) | 1,00 | 6 % / 9 % / 85 % | 10 | 0 $ |
| 11 | 3,7 % | 9,2 % | 0,0 % | 0,0 % | 0,13 | 0,072 % | 156 (5) | 1,00 | 7 % / 10 % / 84 % | 10 | 0 $ |
| 12 | 5,2 % | 9,6 % | 0,0 % | 0,0 % | 0,25 | 0,064 % | 182 (3) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 13 | 2,4 % | 11,3 % | 0,0 % | 0,0 % | 0,15 | 0,074 % | 170 (4) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 14 | 3,8 % | 10,4 % | 0,0 % | 0,0 % | 0,17 | 0,054 % | 162 (3) | 1,00 | 5 % / 9 % / 85 % | 14 | 0 $ |
| 15 | 5,1 % | 10,4 % | 0,0 % | 0,0 % | 0,30 | 0,056 % | 149 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 16 | 4,4 % | 10,0 % | 0,0 % | 0,1 % | 0,13 | 0,072 % | 187 (5) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 17 | 2,3 % | 10,0 % | 0,0 % | 0,0 % | 0,23 | 0,077 % | 159 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 18 | 1,4 % | 10,4 % | 0,0 % | 0,0 % | 0,14 | 0,072 % | 161 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 19 | 5,2 % | 10,0 % | 0,0 % | 0,1 % | 0,15 | 0,071 % | 145 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 20 | 3,5 % | 10,8 % | 0,0 % | 0,0 % | 0,12 | 0,069 % | 185 (4) | 1,00 | 6 % / 9 % / 84 % | 10 | 0 $ |
| 21 | 3,1 % | 9,6 % | 0,0 % | 0,0 % | 0,23 | 0,060 % | 189 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 22 | 5,3 % | 10,4 % | 0,0 % | 0,1 % | 0,24 | 0,068 % | 198 (5) | 1,00 | 5 % / 9 % / 85 % | 15 | 0 $ |
| 23 | 3,9 % | 10,4 % | 0,0 % | 0,0 % | 0,21 | 0,077 % | 184 (5) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 24 | 4,0 % | 11,3 % | 0,0 % | 0,2 % | 0,14 | 0,052 % | 120 (4) | 1,00 | 5 % / 10 % / 85 % | 10 | 0 $ |
| 25 | 4,1 % | 9,6 % | 0,0 % | 0,0 % | 0,35 | 0,054 % | 152 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 26 | 2,2 % | 8,8 % | 0,0 % | 0,0 % | 0,15 | 0,069 % | 183 (4) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 27 | 4,2 % | 10,0 % | 0,0 % | 0,0 % | 0,28 | 0,064 % | 186 (3) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 28 | 1,5 % | 11,7 % | 0,0 % | 0,1 % | 0,15 | 0,073 % | 172 (5) | 1,00 | 5 % / 10 % / 84 % | 13 | 0 $ |
| 29 | 2,4 % | 9,6 % | 0,0 % | 0,0 % | 0,17 | 0,045 % | 149 (1) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 30 | 2,6 % | 9,6 % | 0,0 % | 0,0 % | 0,13 | 0,063 % | 134 (3) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 8/30 : g1 1, g3 2, g7 1, g22 1, g24 2, g25 2, g26 1, g28 2 |
| Chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Gini 0,2–0,45 | ❌ | 2/30 : g3 0,19, g6 0,18 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 30 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 30 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Renflouement d’entreprise : 30/30 graines ; Plancher de logement : 1/30 graines |

### Critère de l’institution : avec filets, sauf « anti-famine »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-famine » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Anti-famine » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Anti-famine » : aucune alerte critique | ❌ | 30/30 : g1 2, g2 5, g3 3, g4 2, g5 5, g6 5, g7 3, g8 6, … |

### Critère de l’institution : avec filets, sauf « renflouement d’entreprise »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Renflouement d’entreprise » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Renflouement d’entreprise » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Renflouement d’entreprise » : aucune alerte critique | ❌ | 8/30 : g1 1, g3 2, g7 1, g22 1, g24 2, g25 2, g26 1, g28 2 |

### Critère de l’institution : avec filets, sauf « plancher de logement »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plancher de logement » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Plancher de logement » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Plancher de logement » : aucune alerte critique | ❌ | 30/30 : g1 2, g2 7, g3 3, g4 2, g5 5, g6 5, g7 3, g8 6, … |

### Critère de l’institution : avec filets, sauf « plafond de dérive des prix et salaires »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plafond de dérive des prix et salaires » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Plafond de dérive des prix et salaires » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Plafond de dérive des prix et salaires » : aucune alerte critique | ❌ | 30/30 : g1 2, g2 5, g3 3, g4 2, g5 5, g6 5, g7 3, g8 6, … |

### Critère de l’institution : avec filets, sauf « anti-crédit-fou »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-crédit-fou » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Anti-crédit-fou » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Anti-crédit-fou » : aucune alerte critique | ❌ | 30/30 : g1 2, g2 5, g3 3, g4 2, g5 5, g6 5, g7 3, g8 6, … |

