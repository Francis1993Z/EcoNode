# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 15:06
- Graines : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie), Entrée et sortie d’entreprises, Caisse : règles prudentielles, Faillite ordonnée
- Temps total : 4 min 44 s pour 210 parties, au plus 16 à la fois (un isolat par partie)
- Statistiques sur les graines : médiane, écart interquartile (EIQ = Q3 − Q1 ; quantiles de type 7, interpolés), min–max, et nombre de graines hors de la zone d’équilibre. Aucune moyenne entre graines.

## 1. Sans filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 5,7 % | 3,8 pt (3,2 % – 7,0 %) | 2,4 % – 7,3 % | 0/30 |
| Chômage max | toute la partie | — | 13,3 % | 1,7 pt (12,5 % – 14,2 %) | 10,8 % – 16,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,1 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 31,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,2 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 36,3 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,34 | 0,16 (0,26 – 0,41) | 0,18 – 0,46 | 2/30 |
| Gini en fin de partie | dernier jour | — | 0,35 | 0,18 (0,27 – 0,45) | 0,18 – 0,52 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,022 % | 0,011 pt (0,016 % – 0,027 %) | 0,010 % – 0,056 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 2,1 % | 2,3 pt (1,4 % – 3,7 %) | 0,7 % – 21,3 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 22,1 % | 13,8 pt (18,2 % – 31,9 %) | 13,0 % – 65,2 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 0 | 1 (0 – 1) | 0 – 3 | 11/30 |
| … dont après la chauffe | après chauffe | — | 0 | 1 (0 – 1) | 0 – 3 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 0 | 1,8 (0 – 1,8) | 0 – 13 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 59,5 | 16 (53,3 – 69,3) | 46 – 90 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,002 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 151 392 $ | 13 717 $ (145 879 $ – 159 596 $) | 138 960 $ – 165 241 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Alertes ouvertes, par type (ouvertures par partie, sur toute la partie)

| Type | Gravité | Graines touchées | Ouvertures : médiane | EIQ (Q1–Q3) | Min–max | Jours-alerte : médiane |
|---|---|---|---|---|---|---|
| Faim répandue | critique | 4/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Sans-abri nombreux | critique | 3/30 | 0 | 0 – 0 | 0 – 1 | 0 j |
| Inflation quotidienne | critique | 7/30 | 0 | 0 – 0 | 0 – 3 | 0 j |
| Rupture de stock prolongée | attention | 30/30 | 11 | 10 – 14 | 5 – 25 | 9336 j |
| Surstock | attention | 30/30 | 10 | 9 – 14,8 | 5 – 23 | 4828 j |
| Entreprise sans employé | attention | 30/30 | 13 | 12 – 15 | 11 – 16 | 15383,5 j |
| Entreprise sans client | attention | 30/30 | 19 | 17 – 23 | 13 – 33 | 15127 j |
| Embauches bloquées faute de moyens | attention | 23/30 | 1 | 1 – 2 | 0 – 8 | 10 j |
| Prix aberrant | attention | 30/30 | 2 | 1 – 3,8 | 1 – 6 | 836 j |

<details><summary>Détail par graine (sans filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 6,2 % | 15,0 % | 0,0 % | 0,0 % | 0,41 | 0,029 % | 71 (1) | 1,00 | 5 % / 11 % / 84 % | 13 | 0 $ |
| 2 | 5,4 % | 14,6 % | 0,0 % | 0,2 % | 0,22 | 0,056 % | 82 (2) | 1,00 | 4 % / 10 % / 86 % | 12 | 0 $ |
| 3 | 4,8 % | 16,7 % | 0,0 % | 0,1 % | 0,20 | 0,024 % | 58 (1) | 1,00 | 8 % / 14 % / 78 % | 11 | 0 $ |
| 4 | 2,7 % | 11,3 % | 0,0 % | 0,0 % | 0,26 | 0,014 % | 53 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 5 | 2,4 % | 12,5 % | 0,0 % | 0,0 % | 0,25 | 0,017 % | 46 (0) | 1,00 | 6 % / 11 % / 84 % | 11 | 0 $ |
| 6 | 2,5 % | 13,3 % | 0,0 % | 0,0 % | 0,18 | 0,013 % | 49 (0) | 1,00 | 6 % / 12 % / 81 % | 11 | 0 $ |
| 7 | 7,2 % | 13,3 % | 0,0 % | 0,0 % | 0,40 | 0,018 % | 63 (0) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 8 | 3,0 % | 11,7 % | 0,1 % | 0,0 % | 0,25 | 0,023 % | 90 (2) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 9 | 6,2 % | 13,8 % | 0,0 % | 0,0 % | 0,45 | 0,019 % | 73 (2) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 10 | 3,2 % | 12,1 % | 0,0 % | 0,0 % | 0,26 | 0,017 % | 48 (0) | 1,00 | 6 % / 12 % / 83 % | 11 | 0 $ |
| 11 | 7,0 % | 11,7 % | 0,0 % | 0,0 % | 0,41 | 0,021 % | 60 (1) | 1,00 | 6 % / 11 % / 82 % | 11 | 0 $ |
| 12 | 7,2 % | 14,2 % | 0,0 % | 0,0 % | 0,41 | 0,029 % | 88 (2) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 13 | 3,5 % | 13,3 % | 0,0 % | 0,0 % | 0,27 | 0,013 % | 52 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 14 | 6,5 % | 12,9 % | 0,1 % | 0,0 % | 0,42 | 0,010 % | 63 (1) | 1,00 | 5 % / 10 % / 84 % | 11 | 0 $ |
| 15 | 7,0 % | 13,3 % | 0,0 % | 0,0 % | 0,41 | 0,024 % | 51 (0) | 1,00 | 6 % / 10 % / 84 % | 11 | 0 $ |
| 16 | 2,6 % | 14,6 % | 0,0 % | 0,0 % | 0,26 | 0,024 % | 65 (0) | 1,00 | 6 % / 10 % / 84 % | 11 | 0 $ |
| 17 | 7,0 % | 14,2 % | 0,0 % | 0,0 % | 0,42 | 0,015 % | 54 (0) | 1,00 | 5 % / 12 % / 83 % | 11 | 0 $ |
| 18 | 4,5 % | 14,6 % | 0,0 % | 0,0 % | 0,26 | 0,016 % | 55 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 19 | 3,4 % | 12,1 % | 0,0 % | 0,0 % | 0,27 | 0,023 % | 70 (1) | 1,00 | 6 % / 12 % / 83 % | 11 | 0 $ |
| 20 | 6,0 % | 15,0 % | 0,0 % | 0,0 % | 0,41 | 0,056 % | 73 (3) | 1,00 | 5 % / 9 % / 85 % | 13 | 0 $ |
| 21 | 7,0 % | 11,7 % | 0,0 % | 0,0 % | 0,46 | 0,020 % | 67 (0) | 1,00 | 5 % / 10 % / 84 % | 13 | 0 $ |
| 22 | 7,1 % | 15,8 % | 0,0 % | 0,0 % | 0,41 | 0,025 % | 55 (0) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 23 | 6,3 % | 13,3 % | 0,0 % | 0,0 % | 0,43 | 0,029 % | 55 (0) | 1,00 | 5 % / 13 % / 82 % | 11 | 0 $ |
| 24 | 7,2 % | 12,5 % | 0,0 % | 0,0 % | 0,41 | 0,012 % | 52 (0) | 1,00 | 5 % / 12 % / 83 % | 11 | 0 $ |
| 25 | 7,3 % | 12,9 % | 0,0 % | 0,0 % | 0,42 | 0,050 % | 73 (3) | 1,00 | 5 % / 11 % / 84 % | 13 | 0 $ |
| 26 | 2,9 % | 12,9 % | 0,0 % | 0,0 % | 0,26 | 0,015 % | 59 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 27 | 6,8 % | 13,8 % | 0,0 % | 0,0 % | 0,42 | 0,027 % | 61 (0) | 1,00 | 6 % / 11 % / 82 % | 11 | 0 $ |
| 28 | 2,6 % | 13,8 % | 0,0 % | 0,0 % | 0,21 | 0,035 % | 62 (0) | 1,00 | 6 % / 10 % / 84 % | 11 | 0 $ |
| 29 | 3,5 % | 10,8 % | 0,0 % | 0,0 % | 0,26 | 0,016 % | 56 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 30 | 4,8 % | 13,3 % | 0,0 % | 0,0 % | 0,27 | 0,022 % | 50 (0) | 1,00 | 6 % / 12 % / 82 % | 11 | 0 $ |

</details>

## 2. Avec filets

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 2,9 % | 1,2 pt (2,6 % – 3,8 %) | 1,5 % – 4,9 % | 0/30 |
| Chômage max | toute la partie | — | 11,7 % | 0,8 pt (11,3 % – 12,1 %) | 10,0 % – 13,8 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,04 pt (0,0 % – 0,0 %) | 0,0 % – 0,4 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 10,8 pt (0,0 % – 10,8 %) | 0,0 % – 51,7 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,16 | 0,07 (0,14 – 0,21) | 0,12 – 0,28 | 22/30 |
| Gini en fin de partie | dernier jour | — | 0,17 | 0,11 (0,14 – 0,24) | 0,10 – 0,27 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,065 % | 0,017 pt (0,059 % – 0,075 %) | 0,042 % – 0,083 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 16,1 % | 14,5 pt (12,3 % – 26,8 %) | 6,0 % – 51,2 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 55,3 % | 24,3 pt (43,7 % – 68,0 %) | 29,4 % – 100,2 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 3 | 2 (3 – 5) | 1 – 7 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3 | 2 (3 – 5) | 1 – 7 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 4 | 3,8 (3 – 6,8) | 1 – 20 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 173,5 | 33,5 (156,5 – 190) | 123 – 254 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,001 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 166 965 $ | 7 170 $ (162 456 $ – 169 626 $) | 155 521 $ – 174 712 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 13,43 | 4,13 (11,46 – 15,58) | 7,04 – 21,46 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,04 (0,00 – 0,04) | 0,00 – 6,46 | 2/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Renflouement d’entreprise | 13,43 | 11,46 – 15,58 | 7,04 – 21,46 | 30/30 | 12759 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0,00 | 0,00 – 0,04 | 0,00 – 6,46 | 2/30 | 272 | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Tourisme 3400 · 30, Ferme 2703 · 30, Ordinateurs 1421 · 30, Aluminerie 835 · 30, Puits de pétrole 755 · 30, Électronique 538 · 30, Raffinerie 453 · 29, Pétrochimie 364 · 30.

<details><summary>Détail par graine (avec filets)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,9 % | 12,1 % | 0,0 % | 0,1 % | 0,13 | 0,072 % | 144 (7) | 1,00 | 7 % / 10 % / 84 % | 10 | 0 $ |
| 2 | 3,8 % | 12,1 % | 0,0 % | 0,0 % | 0,12 | 0,081 % | 153 (3) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |
| 3 | 2,4 % | 11,7 % | 0,0 % | 0,0 % | 0,13 | 0,046 % | 138 (2) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 4 | 2,0 % | 10,0 % | 0,0 % | 0,0 % | 0,15 | 0,075 % | 169 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 5 | 2,0 % | 12,1 % | 0,0 % | 0,0 % | 0,19 | 0,050 % | 156 (1) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 6 | 2,1 % | 12,1 % | 0,0 % | 0,0 % | 0,13 | 0,046 % | 123 (3) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 7 | 3,1 % | 12,5 % | 0,0 % | 0,0 % | 0,20 | 0,076 % | 168 (5) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 8 | 4,5 % | 10,4 % | 0,0 % | 0,0 % | 0,13 | 0,064 % | 206 (3) | 1,00 | 6 % / 10 % / 85 % | 11 | 0 $ |
| 9 | 2,7 % | 13,3 % | 0,0 % | 0,0 % | 0,23 | 0,057 % | 179 (4) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 10 | 3,6 % | 11,3 % | 0,0 % | 0,0 % | 0,14 | 0,083 % | 184 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 11 | 3,6 % | 10,8 % | 0,0 % | 0,3 % | 0,28 | 0,067 % | 179 (3) | 1,00 | 5 % / 10 % / 84 % | 12 | 0 $ |
| 12 | 3,9 % | 11,7 % | 0,0 % | 0,1 % | 0,14 | 0,074 % | 164 (5) | 1,00 | 6 % / 10 % / 85 % | 10 | 0 $ |
| 13 | 3,4 % | 12,9 % | 0,0 % | 0,4 % | 0,18 | 0,042 % | 171 (5) | 1,00 | 5 % / 12 % / 83 % | 12 | 0 $ |
| 14 | 4,3 % | 11,3 % | 0,0 % | 0,0 % | 0,24 | 0,054 % | 197 (4) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 15 | 4,1 % | 11,3 % | 0,0 % | 0,0 % | 0,17 | 0,060 % | 176 (4) | 1,00 | 5 % / 9 % / 85 % | 14 | 0 $ |
| 16 | 2,7 % | 13,8 % | 0,0 % | 0,0 % | 0,14 | 0,062 % | 190 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 17 | 2,9 % | 11,7 % | 0,0 % | 0,0 % | 0,18 | 0,078 % | 254 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 18 | 2,7 % | 12,1 % | 0,0 % | 0,1 % | 0,16 | 0,073 % | 177 (6) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 19 | 1,9 % | 11,7 % | 0,0 % | 0,0 % | 0,12 | 0,073 % | 198 (4) | 1,00 | 6 % / 9 % / 86 % | 13 | 0 $ |
| 20 | 4,5 % | 11,3 % | 0,0 % | 0,0 % | 0,16 | 0,063 % | 202 (6) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 21 | 3,4 % | 11,7 % | 0,0 % | 0,0 % | 0,27 | 0,074 % | 158 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 22 | 4,5 % | 12,5 % | 0,0 % | 0,2 % | 0,16 | 0,062 % | 165 (6) | 1,00 | 5 % / 11 % / 84 % | 10 | 0 $ |
| 23 | 3,2 % | 11,7 % | 0,0 % | 0,0 % | 0,26 | 0,058 % | 178 (2) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 24 | 2,6 % | 10,0 % | 0,0 % | 0,0 % | 0,21 | 0,078 % | 144 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 25 | 2,7 % | 10,8 % | 0,0 % | 0,0 % | 0,24 | 0,059 % | 141 (3) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 26 | 2,6 % | 12,1 % | 0,0 % | 0,0 % | 0,14 | 0,064 % | 205 (2) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 27 | 2,9 % | 10,8 % | 0,0 % | 0,0 % | 0,24 | 0,068 % | 196 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 28 | 2,1 % | 12,9 % | 0,0 % | 0,0 % | 0,13 | 0,055 % | 132 (3) | 1,00 | 6 % / 9 % / 85 % | 10 | 0 $ |
| 29 | 1,5 % | 10,0 % | 0,0 % | 0,0 % | 0,16 | 0,075 % | 167 (3) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 30 | 2,7 % | 12,1 % | 0,0 % | 0,0 % | 0,15 | 0,076 % | 190 (4) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |

</details>

## 2 bis (1). Avec filets, sauf « Anti-famine »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 2,9 % | 1,2 pt (2,6 % – 3,8 %) | 1,5 % – 4,9 % | 0/30 |
| Chômage max | toute la partie | — | 11,7 % | 0,8 pt (11,3 % – 12,1 %) | 10,0 % – 13,8 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,04 pt (0,0 % – 0,0 %) | 0,0 % – 0,4 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 10,8 pt (0,0 % – 10,8 %) | 0,0 % – 51,7 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,16 | 0,07 (0,14 – 0,21) | 0,12 – 0,28 | 22/30 |
| Gini en fin de partie | dernier jour | — | 0,17 | 0,11 (0,14 – 0,24) | 0,10 – 0,27 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,065 % | 0,017 pt (0,059 % – 0,075 %) | 0,042 % – 0,083 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 16,1 % | 14,5 pt (12,3 % – 26,8 %) | 6,0 % – 51,2 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 55,3 % | 24,3 pt (43,7 % – 68,0 %) | 29,4 % – 100,2 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 3 | 2 (3 – 5) | 1 – 7 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3 | 2 (3 – 5) | 1 – 7 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 4 | 3,8 (3 – 6,8) | 1 – 20 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 173,5 | 33,5 (156,5 – 190) | 123 – 254 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,001 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 166 965 $ | 7 170 $ (162 456 $ – 169 626 $) | 155 521 $ – 174 712 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 13,43 | 4,13 (11,46 – 15,58) | 7,04 – 21,46 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,04 (0,00 – 0,04) | 0,00 – 6,46 | 2/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | coupé | — | — | — | — | — |
| Renflouement d’entreprise | 13,43 | 11,46 – 15,58 | 7,04 – 21,46 | 30/30 | 12759 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0,00 | 0,00 – 0,04 | 0,00 – 6,46 | 2/30 | 272 | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Tourisme 3400 · 30, Ferme 2703 · 30, Ordinateurs 1421 · 30, Aluminerie 835 · 30, Puits de pétrole 755 · 30, Électronique 538 · 30, Raffinerie 453 · 29, Pétrochimie 364 · 30.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-famine »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 2,9 % | 2,9 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 11,7 % | 11,7 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,16 | 22 → 22 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,17 | 0,17 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,065 % | 0,065 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 16,1 % | 16,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 55,3 % | 55,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 3 | 3 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 3 | 3 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 4 | 4 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 173,5 | 173,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 166 965 $ | 166 965 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,43 | 13,43 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 2 → 2 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-famine »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,9 % | 12,1 % | 0,0 % | 0,1 % | 0,13 | 0,072 % | 144 (7) | 1,00 | 7 % / 10 % / 84 % | 10 | 0 $ |
| 2 | 3,8 % | 12,1 % | 0,0 % | 0,0 % | 0,12 | 0,081 % | 153 (3) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |
| 3 | 2,4 % | 11,7 % | 0,0 % | 0,0 % | 0,13 | 0,046 % | 138 (2) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 4 | 2,0 % | 10,0 % | 0,0 % | 0,0 % | 0,15 | 0,075 % | 169 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 5 | 2,0 % | 12,1 % | 0,0 % | 0,0 % | 0,19 | 0,050 % | 156 (1) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 6 | 2,1 % | 12,1 % | 0,0 % | 0,0 % | 0,13 | 0,046 % | 123 (3) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 7 | 3,1 % | 12,5 % | 0,0 % | 0,0 % | 0,20 | 0,076 % | 168 (5) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 8 | 4,5 % | 10,4 % | 0,0 % | 0,0 % | 0,13 | 0,064 % | 206 (3) | 1,00 | 6 % / 10 % / 85 % | 11 | 0 $ |
| 9 | 2,7 % | 13,3 % | 0,0 % | 0,0 % | 0,23 | 0,057 % | 179 (4) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 10 | 3,6 % | 11,3 % | 0,0 % | 0,0 % | 0,14 | 0,083 % | 184 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 11 | 3,6 % | 10,8 % | 0,0 % | 0,3 % | 0,28 | 0,067 % | 179 (3) | 1,00 | 5 % / 10 % / 84 % | 12 | 0 $ |
| 12 | 3,9 % | 11,7 % | 0,0 % | 0,1 % | 0,14 | 0,074 % | 164 (5) | 1,00 | 6 % / 10 % / 85 % | 10 | 0 $ |
| 13 | 3,4 % | 12,9 % | 0,0 % | 0,4 % | 0,18 | 0,042 % | 171 (5) | 1,00 | 5 % / 12 % / 83 % | 12 | 0 $ |
| 14 | 4,3 % | 11,3 % | 0,0 % | 0,0 % | 0,24 | 0,054 % | 197 (4) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 15 | 4,1 % | 11,3 % | 0,0 % | 0,0 % | 0,17 | 0,060 % | 176 (4) | 1,00 | 5 % / 9 % / 85 % | 14 | 0 $ |
| 16 | 2,7 % | 13,8 % | 0,0 % | 0,0 % | 0,14 | 0,062 % | 190 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 17 | 2,9 % | 11,7 % | 0,0 % | 0,0 % | 0,18 | 0,078 % | 254 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 18 | 2,7 % | 12,1 % | 0,0 % | 0,1 % | 0,16 | 0,073 % | 177 (6) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 19 | 1,9 % | 11,7 % | 0,0 % | 0,0 % | 0,12 | 0,073 % | 198 (4) | 1,00 | 6 % / 9 % / 86 % | 13 | 0 $ |
| 20 | 4,5 % | 11,3 % | 0,0 % | 0,0 % | 0,16 | 0,063 % | 202 (6) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 21 | 3,4 % | 11,7 % | 0,0 % | 0,0 % | 0,27 | 0,074 % | 158 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 22 | 4,5 % | 12,5 % | 0,0 % | 0,2 % | 0,16 | 0,062 % | 165 (6) | 1,00 | 5 % / 11 % / 84 % | 10 | 0 $ |
| 23 | 3,2 % | 11,7 % | 0,0 % | 0,0 % | 0,26 | 0,058 % | 178 (2) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 24 | 2,6 % | 10,0 % | 0,0 % | 0,0 % | 0,21 | 0,078 % | 144 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 25 | 2,7 % | 10,8 % | 0,0 % | 0,0 % | 0,24 | 0,059 % | 141 (3) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 26 | 2,6 % | 12,1 % | 0,0 % | 0,0 % | 0,14 | 0,064 % | 205 (2) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 27 | 2,9 % | 10,8 % | 0,0 % | 0,0 % | 0,24 | 0,068 % | 196 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 28 | 2,1 % | 12,9 % | 0,0 % | 0,0 % | 0,13 | 0,055 % | 132 (3) | 1,00 | 6 % / 9 % / 85 % | 10 | 0 $ |
| 29 | 1,5 % | 10,0 % | 0,0 % | 0,0 % | 0,16 | 0,075 % | 167 (3) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 30 | 2,7 % | 12,1 % | 0,0 % | 0,0 % | 0,15 | 0,076 % | 190 (4) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |

</details>

## 2 bis (2). Avec filets, sauf « Renflouement d’entreprise »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 6,0 % | 3,8 pt (3,2 % – 7,0 %) | 2,4 % – 7,3 % | 0/30 |
| Chômage max | toute la partie | — | 13,3 % | 1,6 pt (12,5 % – 14,1 %) | 10,8 % – 16,7 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,1 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 31,3 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,2 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 33,8 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,34 | 0,16 (0,26 – 0,41) | 0,18 – 0,46 | 2/30 |
| Gini en fin de partie | dernier jour | — | 0,35 | 0,18 (0,27 – 0,45) | 0,18 – 0,52 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,022 % | 0,011 pt (0,016 % – 0,027 %) | 0,012 % – 0,056 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 2,1 % | 1,1 pt (1,4 % – 2,5 %) | 0,7 % – 21,3 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 22,1 % | 13,3 pt (18,6 % – 31,9 %) | 13,0 % – 65,2 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 0 | 1 (0 – 1) | 0 – 3 | 11/30 |
| … dont après la chauffe | après chauffe | — | 0 | 1 (0 – 1) | 0 – 3 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 0 | 1,8 (0 – 1,8) | 0 – 10 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 59,5 | 13,8 (53,3 – 67) | 46 – 88 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,002 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 151 060 $ | 13 717 $ (145 879 $ – 159 596 $) | 138 960 $ – 165 241 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,29 | 0/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,79 | 0/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 0,29 | 0/30 | 12 | pas de producteur (100 %) |
| Renflouement d’entreprise | coupé | — | — | — | — | — |
| Plancher de logement | 0,00 | 0,00 – 0,00 | 0,00 – 0,79 | 0/30 | 32 | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « renflouement d’entreprise »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 2,9 % | 6,0 % | 0 → 0 | +2,1 pt | [+1,4 pt ; +3,0 pt] | 3 / 27 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 11,7 % | 13,3 % | — | +1,2 pt | [+0,8 pt ; +2,1 pt] | 0 / 29 / 1 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 3 / 27 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 3 / 27 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [−0,03 pt ; 0,0 pt] | 12 / 3 / 15 sur 30 | non concluant |
| Sans-abri max | 0,0 % | 0,0 % | — | 0,0 pt | [−7,7 pt ; 0,0 pt] | 12 / 3 / 15 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,34 | 22 → 2 | +0,14 | [+0,11 ; +0,19] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,17 | 0,35 | — | +0,17 | [+0,10 ; +0,21] | — / — / 0 | **B plus haut** |
| Inflation moyenne / j | 0,065 % | 0,022 % | 0 → 0 | −0,041 pt | [−0,050 pt ; −0,037 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 16,1 % | 2,1 % | — | −14,5 pt | [−21,1 pt ; −10,2 pt] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |
| |Inflation sur 100 j| max | 55,3 % | 22,1 % | — | −30,5 pt | [−40,9 pt ; −17,0 pt] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes critiques ouvertes | 3 | 0 | 30 → 11 | −3 | [−3 ; −3] | 29 / 0 / 1 sur 30 | **B plus bas (mieux)** |
| … dont après la chauffe | 3 | 0 | — | −3 | [−3 ; −3] | 29 / 0 / 1 sur 30 | **B plus bas (mieux)** |
| Jours-alerte critiques (somme des types) | 4 | 0 | — | −3 | [−5 ; −3] | 27 / 2 / 1 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 173,5 | 59,5 | — | −117 | [−124 ; −105,5] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Santé moyenne | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 1,00 | 1,00 | — | −0,001 | [−0,001 ; −0,0002] | 6 / 24 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 166 965 $ | 151 060 $ | — | −13 870 $ | [−17 057 $ ; −9 650 $] | 1 / 29 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 3 / 27 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 2 → 0 | 0,00 | [0,00 ; 0,00] | 8 / 2 / 20 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « renflouement d’entreprise »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 6,2 % | 15,0 % | 0,0 % | 0,0 % | 0,41 | 0,029 % | 71 (1) | 1,00 | 5 % / 11 % / 84 % | 13 | 0 $ |
| 2 | 6,0 % | 13,8 % | 0,0 % | 0,2 % | 0,22 | 0,045 % | 67 (1) | 1,00 | 6 % / 10 % / 84 % | 11 | 0 $ |
| 3 | 4,7 % | 16,7 % | 0,0 % | 0,1 % | 0,20 | 0,022 % | 59 (1) | 1,00 | 7 % / 13 % / 81 % | 11 | 0 $ |
| 4 | 2,7 % | 11,3 % | 0,0 % | 0,0 % | 0,26 | 0,014 % | 53 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 5 | 2,4 % | 12,5 % | 0,0 % | 0,0 % | 0,25 | 0,017 % | 46 (0) | 1,00 | 6 % / 11 % / 84 % | 11 | 0 $ |
| 6 | 2,5 % | 13,3 % | 0,0 % | 0,0 % | 0,18 | 0,013 % | 49 (0) | 1,00 | 6 % / 12 % / 81 % | 11 | 0 $ |
| 7 | 7,2 % | 13,3 % | 0,0 % | 0,0 % | 0,40 | 0,018 % | 63 (0) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 8 | 3,1 % | 11,7 % | 0,1 % | 0,0 % | 0,25 | 0,022 % | 88 (2) | 1,00 | 7 % / 10 % / 83 % | 11 | 0 $ |
| 9 | 6,2 % | 13,8 % | 0,0 % | 0,0 % | 0,45 | 0,019 % | 73 (2) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 10 | 3,2 % | 12,1 % | 0,0 % | 0,0 % | 0,26 | 0,017 % | 48 (0) | 1,00 | 6 % / 12 % / 83 % | 11 | 0 $ |
| 11 | 7,0 % | 11,7 % | 0,0 % | 0,0 % | 0,41 | 0,021 % | 60 (1) | 1,00 | 6 % / 11 % / 82 % | 11 | 0 $ |
| 12 | 7,2 % | 14,2 % | 0,0 % | 0,0 % | 0,41 | 0,029 % | 88 (2) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 13 | 3,5 % | 13,3 % | 0,0 % | 0,0 % | 0,27 | 0,013 % | 52 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 14 | 6,6 % | 12,9 % | 0,1 % | 0,0 % | 0,42 | 0,015 % | 63 (1) | 1,00 | 4 % / 12 % / 84 % | 11 | 0 $ |
| 15 | 7,0 % | 13,3 % | 0,0 % | 0,0 % | 0,41 | 0,024 % | 51 (0) | 1,00 | 6 % / 10 % / 84 % | 11 | 0 $ |
| 16 | 2,6 % | 14,6 % | 0,0 % | 0,0 % | 0,26 | 0,024 % | 65 (0) | 1,00 | 6 % / 10 % / 84 % | 11 | 0 $ |
| 17 | 7,0 % | 14,2 % | 0,0 % | 0,0 % | 0,42 | 0,015 % | 54 (0) | 1,00 | 5 % / 12 % / 83 % | 11 | 0 $ |
| 18 | 4,5 % | 14,6 % | 0,0 % | 0,0 % | 0,26 | 0,016 % | 55 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 19 | 3,4 % | 12,1 % | 0,0 % | 0,0 % | 0,27 | 0,023 % | 70 (1) | 1,00 | 6 % / 12 % / 83 % | 11 | 0 $ |
| 20 | 6,0 % | 15,0 % | 0,0 % | 0,0 % | 0,41 | 0,056 % | 73 (3) | 1,00 | 5 % / 9 % / 85 % | 13 | 0 $ |
| 21 | 7,0 % | 11,7 % | 0,0 % | 0,0 % | 0,46 | 0,020 % | 67 (0) | 1,00 | 5 % / 10 % / 84 % | 13 | 0 $ |
| 22 | 7,1 % | 15,8 % | 0,0 % | 0,0 % | 0,41 | 0,025 % | 55 (0) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 23 | 6,3 % | 13,3 % | 0,0 % | 0,0 % | 0,43 | 0,029 % | 55 (0) | 1,00 | 5 % / 13 % / 82 % | 11 | 0 $ |
| 24 | 7,2 % | 12,5 % | 0,0 % | 0,0 % | 0,41 | 0,012 % | 52 (0) | 1,00 | 5 % / 12 % / 83 % | 11 | 0 $ |
| 25 | 7,3 % | 12,9 % | 0,0 % | 0,0 % | 0,42 | 0,050 % | 73 (3) | 1,00 | 5 % / 11 % / 84 % | 13 | 0 $ |
| 26 | 2,9 % | 12,9 % | 0,0 % | 0,0 % | 0,26 | 0,015 % | 59 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 27 | 6,8 % | 13,8 % | 0,0 % | 0,0 % | 0,42 | 0,027 % | 61 (0) | 1,00 | 6 % / 11 % / 82 % | 11 | 0 $ |
| 28 | 2,6 % | 13,8 % | 0,0 % | 0,0 % | 0,21 | 0,035 % | 62 (0) | 1,00 | 6 % / 10 % / 84 % | 11 | 0 $ |
| 29 | 3,5 % | 10,8 % | 0,0 % | 0,0 % | 0,26 | 0,016 % | 56 (0) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 30 | 4,8 % | 13,3 % | 0,0 % | 0,0 % | 0,27 | 0,022 % | 50 (0) | 1,00 | 6 % / 12 % / 82 % | 11 | 0 $ |

</details>

## 2 bis (3). Avec filets, sauf « Plancher de logement »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 2,8 % | 1,1 pt (2,4 % – 3,5 %) | 1,5 % – 4,3 % | 0/30 |
| Chômage max | toute la partie | — | 11,7 % | 0,8 pt (11,3 % – 12,1 %) | 10,0 % – 13,8 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,04 pt (0,0 % – 0,0 %) | 0,0 % – 0,5 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 10,8 pt (0,0 % – 10,8 %) | 0,0 % – 56,7 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,16 | 0,07 (0,14 – 0,21) | 0,12 – 0,28 | 22/30 |
| Gini en fin de partie | dernier jour | — | 0,18 | 0,10 (0,14 – 0,24) | 0,08 – 0,27 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,067 % | 0,017 pt (0,059 % – 0,075 %) | 0,037 % – 0,083 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 16,1 % | 14,5 pt (12,3 % – 26,8 %) | 6,0 % – 51,2 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 55,3 % | 24,3 pt (43,7 % – 68,0 %) | 29,4 % – 100,3 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 3 | 2 (3 – 5) | 1 – 6 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3 | 2 (3 – 5) | 1 – 6 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 4 | 3,8 (3 – 6,8) | 1 – 21 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 174 | 28,3 (156,5 – 184,8) | 123 – 254 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,001 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 167 208 $ | 6 035 $ (162 727 $ – 168 762 $) | 158 706 $ – 174 712 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 13,43 | 4,70 (11,13 – 15,83) | 7,04 – 20,21 | 30/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Renflouement d’entreprise | 13,43 | 11,13 – 15,83 | 7,04 – 20,21 | 30/30 | 12590 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | coupé | — | — | — | — | — |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Tourisme 3177 · 30, Ferme 2648 · 30, Ordinateurs 1497 · 30, Aluminerie 904 · 30, Puits de pétrole 742 · 30, Électronique 556 · 30, Raffinerie 397 · 28, Pétrochimie 372 · 30.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plancher de logement »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 2,9 % | 2,8 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 7 / 1 / 22 sur 30 | non concluant |
| Chômage max | 11,7 % | 11,7 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 7 / 21 sur 30 | non concluant |
| Sans-abri max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 3 / 27 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,16 | 22 → 22 | 0,00 | [0,00 ; 0,00] | — / — / 22 | non concluant |
| Gini en fin de partie | 0,17 | 0,18 | — | 0,00 | [0,00 ; 0,00] | — / — / 22 | non concluant |
| Inflation moyenne / j | 0,065 % | 0,067 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 22 | non concluant |
| |Inflation| max / j | 16,1 % | 16,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 1 / 27 sur 30 | non concluant |
| |Inflation sur 100 j| max | 55,3 % | 55,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 2 / 28 sur 30 | non concluant |
| Alertes critiques ouvertes | 3 | 3 | 30 → 30 | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| … dont après la chauffe | 3 | 3 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 4 | 4 | — | 0 | [0 ; 0] | 2 / 1 / 27 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 173,5 | 174 | — | 0 | [0 ; 0] | 4 / 3 / 23 sur 30 | non concluant |
| Santé moyenne | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 6 / 2 / 22 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 166 965 $ | 167 208 $ | — | 0 $ | [0 $ ; 0 $] | 4 / 1 / 25 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,43 | 13,43 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 3 / 5 / 22 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plancher de logement »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 3,3 % | 12,1 % | 0,0 % | 0,0 % | 0,13 | 0,074 % | 140 (6) | 1,00 | 5 % / 10 % / 84 % | 10 | 0 $ |
| 2 | 3,8 % | 12,1 % | 0,0 % | 0,0 % | 0,12 | 0,081 % | 153 (3) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |
| 3 | 2,4 % | 11,7 % | 0,0 % | 0,0 % | 0,13 | 0,037 % | 139 (2) | 1,00 | 6 % / 11 % / 83 % | 13 | 0 $ |
| 4 | 2,0 % | 10,0 % | 0,0 % | 0,0 % | 0,15 | 0,075 % | 169 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 5 | 2,0 % | 12,1 % | 0,0 % | 0,0 % | 0,19 | 0,050 % | 156 (1) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 6 | 2,1 % | 12,1 % | 0,0 % | 0,0 % | 0,13 | 0,044 % | 123 (3) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 7 | 3,1 % | 12,5 % | 0,0 % | 0,0 % | 0,20 | 0,076 % | 168 (5) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 8 | 4,2 % | 10,4 % | 0,0 % | 0,0 % | 0,15 | 0,067 % | 178 (3) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 9 | 2,7 % | 13,3 % | 0,0 % | 0,0 % | 0,23 | 0,057 % | 179 (4) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 10 | 3,6 % | 11,3 % | 0,0 % | 0,0 % | 0,14 | 0,083 % | 184 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 11 | 3,6 % | 10,8 % | 0,0 % | 0,3 % | 0,28 | 0,067 % | 180 (3) | 1,00 | 5 % / 10 % / 84 % | 13 | 0 $ |
| 12 | 3,9 % | 11,7 % | 0,0 % | 0,1 % | 0,14 | 0,074 % | 164 (5) | 1,00 | 6 % / 10 % / 85 % | 10 | 0 $ |
| 13 | 3,4 % | 12,9 % | 0,0 % | 0,5 % | 0,18 | 0,044 % | 169 (5) | 1,00 | 6 % / 11 % / 84 % | 12 | 0 $ |
| 14 | 4,3 % | 11,3 % | 0,0 % | 0,0 % | 0,24 | 0,054 % | 197 (4) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 15 | 4,1 % | 11,3 % | 0,0 % | 0,0 % | 0,17 | 0,060 % | 176 (4) | 1,00 | 5 % / 9 % / 85 % | 14 | 0 $ |
| 16 | 2,7 % | 13,8 % | 0,0 % | 0,0 % | 0,14 | 0,062 % | 190 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 17 | 2,9 % | 11,7 % | 0,0 % | 0,0 % | 0,18 | 0,078 % | 254 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 18 | 2,7 % | 12,1 % | 0,0 % | 0,1 % | 0,16 | 0,073 % | 177 (6) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 19 | 1,9 % | 11,7 % | 0,0 % | 0,0 % | 0,12 | 0,073 % | 198 (4) | 1,00 | 6 % / 9 % / 86 % | 13 | 0 $ |
| 20 | 2,3 % | 11,3 % | 0,0 % | 0,0 % | 0,17 | 0,064 % | 185 (6) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 21 | 3,4 % | 11,7 % | 0,0 % | 0,0 % | 0,27 | 0,074 % | 158 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 22 | 3,9 % | 12,9 % | 0,0 % | 0,2 % | 0,13 | 0,063 % | 172 (6) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |
| 23 | 3,2 % | 11,7 % | 0,0 % | 0,0 % | 0,26 | 0,058 % | 178 (2) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 24 | 2,6 % | 10,0 % | 0,0 % | 0,0 % | 0,21 | 0,078 % | 144 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 25 | 2,7 % | 10,8 % | 0,0 % | 0,0 % | 0,24 | 0,059 % | 141 (3) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 26 | 2,6 % | 12,1 % | 0,0 % | 0,0 % | 0,14 | 0,064 % | 205 (2) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 27 | 2,9 % | 10,8 % | 0,0 % | 0,0 % | 0,24 | 0,068 % | 196 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 28 | 2,1 % | 12,9 % | 0,0 % | 0,0 % | 0,13 | 0,055 % | 132 (3) | 1,00 | 6 % / 9 % / 85 % | 10 | 0 $ |
| 29 | 1,5 % | 10,0 % | 0,0 % | 0,0 % | 0,16 | 0,075 % | 167 (3) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 30 | 2,7 % | 12,1 % | 0,0 % | 0,0 % | 0,15 | 0,076 % | 190 (4) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |

</details>

## 2 bis (4). Avec filets, sauf « Plafond de dérive des prix et salaires »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 2,9 % | 1,2 pt (2,6 % – 3,8 %) | 1,5 % – 4,9 % | 0/30 |
| Chômage max | toute la partie | — | 11,7 % | 0,8 pt (11,3 % – 12,1 %) | 10,0 % – 13,8 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,04 pt (0,0 % – 0,0 %) | 0,0 % – 0,4 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 10,8 pt (0,0 % – 10,8 %) | 0,0 % – 51,7 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,16 | 0,07 (0,14 – 0,21) | 0,12 – 0,28 | 22/30 |
| Gini en fin de partie | dernier jour | — | 0,17 | 0,11 (0,14 – 0,24) | 0,10 – 0,27 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,065 % | 0,017 pt (0,059 % – 0,075 %) | 0,042 % – 0,083 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 16,1 % | 14,5 pt (12,3 % – 26,8 %) | 6,0 % – 51,2 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 55,3 % | 24,3 pt (43,7 % – 68,0 %) | 29,4 % – 100,2 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 3 | 2 (3 – 5) | 1 – 7 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3 | 2 (3 – 5) | 1 – 7 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 4 | 3,8 (3 – 6,8) | 1 – 20 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 173,5 | 33,5 (156,5 – 190) | 123 – 254 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,001 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 166 965 $ | 7 170 $ (162 456 $ – 169 626 $) | 155 521 $ – 174 712 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 13,43 | 4,13 (11,46 – 15,58) | 7,04 – 21,46 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,04 (0,00 – 0,04) | 0,00 – 6,46 | 2/30 |
| Filet : Anti-crédit-fou / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Renflouement d’entreprise | 13,43 | 11,46 – 15,58 | 7,04 – 21,46 | 30/30 | 12759 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0,00 | 0,00 – 0,04 | 0,00 – 6,46 | 2/30 | 272 | parc plein (100 %) |
| Plafond de dérive des prix et salaires | coupé | — | — | — | — | — |
| Anti-crédit-fou | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Tourisme 3400 · 30, Ferme 2703 · 30, Ordinateurs 1421 · 30, Aluminerie 835 · 30, Puits de pétrole 755 · 30, Électronique 538 · 30, Raffinerie 453 · 29, Pétrochimie 364 · 30.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « plafond de dérive des prix et salaires »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 2,9 % | 2,9 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 11,7 % | 11,7 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,16 | 22 → 22 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,17 | 0,17 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,065 % | 0,065 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 16,1 % | 16,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 55,3 % | 55,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 3 | 3 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 3 | 3 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 4 | 4 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 173,5 | 173,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 166 965 $ | 166 965 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,43 | 13,43 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 2 → 2 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « plafond de dérive des prix et salaires »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,9 % | 12,1 % | 0,0 % | 0,1 % | 0,13 | 0,072 % | 144 (7) | 1,00 | 7 % / 10 % / 84 % | 10 | 0 $ |
| 2 | 3,8 % | 12,1 % | 0,0 % | 0,0 % | 0,12 | 0,081 % | 153 (3) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |
| 3 | 2,4 % | 11,7 % | 0,0 % | 0,0 % | 0,13 | 0,046 % | 138 (2) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 4 | 2,0 % | 10,0 % | 0,0 % | 0,0 % | 0,15 | 0,075 % | 169 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 5 | 2,0 % | 12,1 % | 0,0 % | 0,0 % | 0,19 | 0,050 % | 156 (1) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 6 | 2,1 % | 12,1 % | 0,0 % | 0,0 % | 0,13 | 0,046 % | 123 (3) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 7 | 3,1 % | 12,5 % | 0,0 % | 0,0 % | 0,20 | 0,076 % | 168 (5) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 8 | 4,5 % | 10,4 % | 0,0 % | 0,0 % | 0,13 | 0,064 % | 206 (3) | 1,00 | 6 % / 10 % / 85 % | 11 | 0 $ |
| 9 | 2,7 % | 13,3 % | 0,0 % | 0,0 % | 0,23 | 0,057 % | 179 (4) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 10 | 3,6 % | 11,3 % | 0,0 % | 0,0 % | 0,14 | 0,083 % | 184 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 11 | 3,6 % | 10,8 % | 0,0 % | 0,3 % | 0,28 | 0,067 % | 179 (3) | 1,00 | 5 % / 10 % / 84 % | 12 | 0 $ |
| 12 | 3,9 % | 11,7 % | 0,0 % | 0,1 % | 0,14 | 0,074 % | 164 (5) | 1,00 | 6 % / 10 % / 85 % | 10 | 0 $ |
| 13 | 3,4 % | 12,9 % | 0,0 % | 0,4 % | 0,18 | 0,042 % | 171 (5) | 1,00 | 5 % / 12 % / 83 % | 12 | 0 $ |
| 14 | 4,3 % | 11,3 % | 0,0 % | 0,0 % | 0,24 | 0,054 % | 197 (4) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 15 | 4,1 % | 11,3 % | 0,0 % | 0,0 % | 0,17 | 0,060 % | 176 (4) | 1,00 | 5 % / 9 % / 85 % | 14 | 0 $ |
| 16 | 2,7 % | 13,8 % | 0,0 % | 0,0 % | 0,14 | 0,062 % | 190 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 17 | 2,9 % | 11,7 % | 0,0 % | 0,0 % | 0,18 | 0,078 % | 254 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 18 | 2,7 % | 12,1 % | 0,0 % | 0,1 % | 0,16 | 0,073 % | 177 (6) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 19 | 1,9 % | 11,7 % | 0,0 % | 0,0 % | 0,12 | 0,073 % | 198 (4) | 1,00 | 6 % / 9 % / 86 % | 13 | 0 $ |
| 20 | 4,5 % | 11,3 % | 0,0 % | 0,0 % | 0,16 | 0,063 % | 202 (6) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 21 | 3,4 % | 11,7 % | 0,0 % | 0,0 % | 0,27 | 0,074 % | 158 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 22 | 4,5 % | 12,5 % | 0,0 % | 0,2 % | 0,16 | 0,062 % | 165 (6) | 1,00 | 5 % / 11 % / 84 % | 10 | 0 $ |
| 23 | 3,2 % | 11,7 % | 0,0 % | 0,0 % | 0,26 | 0,058 % | 178 (2) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 24 | 2,6 % | 10,0 % | 0,0 % | 0,0 % | 0,21 | 0,078 % | 144 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 25 | 2,7 % | 10,8 % | 0,0 % | 0,0 % | 0,24 | 0,059 % | 141 (3) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 26 | 2,6 % | 12,1 % | 0,0 % | 0,0 % | 0,14 | 0,064 % | 205 (2) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 27 | 2,9 % | 10,8 % | 0,0 % | 0,0 % | 0,24 | 0,068 % | 196 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 28 | 2,1 % | 12,9 % | 0,0 % | 0,0 % | 0,13 | 0,055 % | 132 (3) | 1,00 | 6 % / 9 % / 85 % | 10 | 0 $ |
| 29 | 1,5 % | 10,0 % | 0,0 % | 0,0 % | 0,16 | 0,075 % | 167 (3) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 30 | 2,7 % | 12,1 % | 0,0 % | 0,0 % | 0,15 | 0,076 % | 190 (4) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |

</details>

## 2 bis (5). Avec filets, sauf « Anti-crédit-fou »

| Indicateur | Mesuré sur | Bande | Médiane | EIQ (Q1–Q3) | Min–max | Graines hors bande |
|---|---|---|---|---|---|---|
| Chômage moyen | après chauffe | ≤ 10 % | 2,9 % | 1,2 pt (2,6 % – 3,8 %) | 1,5 % – 4,9 % | 0/30 |
| Chômage max | toute la partie | — | 11,7 % | 0,8 pt (11,3 % – 12,1 %) | 10,0 % – 13,8 % | — |
| Faim moyenne | après chauffe | < 2 % | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | 0/30 |
| Faim max | toute la partie | — | 0,0 % | 0,0 pt (0,0 % – 0,0 %) | 0,0 % – 0,0 % | — |
| Sans-abri moyen | après chauffe | < 2 % | 0,0 % | 0,04 pt (0,0 % – 0,0 %) | 0,0 % – 0,4 % | 0/30 |
| Sans-abri max | toute la partie | — | 0,0 % | 10,8 pt (0,0 % – 10,8 %) | 0,0 % – 51,7 % | — |
| Gini moyen | après chauffe | 0,2–0,45 | 0,16 | 0,07 (0,14 – 0,21) | 0,12 – 0,28 | 22/30 |
| Gini en fin de partie | dernier jour | — | 0,17 | 0,11 (0,14 – 0,24) | 0,10 – 0,27 | — |
| Inflation moyenne / j | après chauffe | < ±0,5 %/j | 0,065 % | 0,017 pt (0,059 % – 0,075 %) | 0,042 % – 0,083 % | 0/30 |
| |Inflation| max / j | toute la partie | — | 16,1 % | 14,5 pt (12,3 % – 26,8 %) | 6,0 % – 51,2 % | — |
| |Inflation sur 100 j| max | toute la partie | — | 55,3 % | 24,3 pt (43,7 % – 68,0 %) | 29,4 % – 100,2 % | — |
| Alertes critiques ouvertes | toute la partie | 0 | 3 | 2 (3 – 5) | 1 – 7 | 30/30 |
| … dont après la chauffe | après chauffe | — | 3 | 2 (3 – 5) | 1 – 7 | — |
| Jours-alerte critiques (somme des types) | toute la partie | — | 4 | 3,8 (3 – 6,8) | 1 – 20 | — |
| Alertes ouvertes (toutes) | toute la partie | — | 173,5 | 33,5 (156,5 – 190) | 123 – 254 | — |
| Santé moyenne | après chauffe | — | 1,00 | 0,00 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Bonheur moyen | après chauffe | — | 1,00 | 0,001 (1,00 – 1,00) | 1,00 – 1,00 | — |
| Hôpital public : attente moyenne (j) | après chauffe | — | 0,0 | 0,0 (0,0 – 0,0) | 0,0 – 0,0 | — |
| Jours de prestations réduites | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Trésor de l’État le plus bas | après chauffe | — | 166 965 $ | 7 170 $ (162 456 $ – 169 626 $) | 155 521 $ – 174 712 $ | — |
| Jours de Caisse insolvable | après chauffe | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Prêts refusés | toute la partie | — | 0 | 0 (0 – 0) | 0 – 0 | — |
| Créances radiées | toute la partie | — | 0 $ | 0 $ (0 $ – 0 $) | 0 $ – 0 $ | — |
| Filet : Anti-famine / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| Filet : Renflouement d’entreprise / 50 j | après chauffe | < 1 | 13,43 | 4,13 (11,46 – 15,58) | 7,04 – 21,46 | 30/30 |
| Filet : Plancher de logement / 50 j | après chauffe | < 1 | 0,00 | 0,04 (0,00 – 0,04) | 0,00 – 6,46 | 2/30 |
| Filet : Plafond de dérive des prix et salaires / 50 j | après chauffe | < 1 | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | 0/30 |
| … dont renflouements de l’hôpital / 50 j | après chauffe | — | 0,00 | 0,00 (0,00 – 0,00) | 0,00 – 0,00 | — |
| Écart comptable max ($) | toute la partie | ≤ 1e-8 | 0.0e+0 | 0.0e+0 (0.0e+0 – 0.0e+0) | 0.0e+0 – 0.0e+0 | 0/30 |

### Filets : déclenchements en régime, par 50 jours, et causes (toutes graines)

| Filet | Médiane / 50 j | EIQ (Q1–Q3) | Min–max | Graines ≥ 1 / 50 j | Déclenchements (total) | Causes principales |
|---|---|---|---|---|---|---|
| Anti-famine | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Renflouement d’entreprise | 13,43 | 11,46 – 15,58 | 7,04 – 21,46 | 30/30 | 12759 | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0,00 | 0,00 – 0,04 | 0,00 – 6,46 | 2/30 | 272 | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0,00 | 0,00 – 0,00 | 0,00 – 0,00 | 0/30 | 0 | — |
| Anti-crédit-fou | coupé | — | — | — | — | — |

Renflouements en régime, par type d’entreprise (total sur 30 graines · graines touchées) : Tourisme 3400 · 30, Ferme 2703 · 30, Ordinateurs 1421 · 30, Aluminerie 835 · 30, Puits de pétrole 755 · 30, Électronique 538 · 30, Raffinerie 453 · 29, Pétrochimie 364 · 30.

### Effet de la coupure, apparié : A = avec filets, B = avec filets, sauf « anti-crédit-fou »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 2,9 % | 2,9 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 11,7 % | 11,7 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,16 | 22 → 22 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,17 | 0,17 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,065 % | 0,065 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 16,1 % | 16,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 55,3 % | 55,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 3 | 3 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 3 | 3 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 4 | 4 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 173,5 | 173,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 166 965 $ | 166 965 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,43 | 13,43 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 2 → 2 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

<details><summary>Détail par graine (avec filets, sauf « anti-crédit-fou »)</summary>

| Graine | Chômage moy. | Chômage max | Faim moy. | Sans-abri moy. | Gini moy. | Inflation moy./j | Alertes (crit.) | Santé | Primaire / secondaire / tertiaire | Sans employé | Dette finale |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,9 % | 12,1 % | 0,0 % | 0,1 % | 0,13 | 0,072 % | 144 (7) | 1,00 | 7 % / 10 % / 84 % | 10 | 0 $ |
| 2 | 3,8 % | 12,1 % | 0,0 % | 0,0 % | 0,12 | 0,081 % | 153 (3) | 1,00 | 6 % / 10 % / 84 % | 10 | 0 $ |
| 3 | 2,4 % | 11,7 % | 0,0 % | 0,0 % | 0,13 | 0,046 % | 138 (2) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 4 | 2,0 % | 10,0 % | 0,0 % | 0,0 % | 0,15 | 0,075 % | 169 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 5 | 2,0 % | 12,1 % | 0,0 % | 0,0 % | 0,19 | 0,050 % | 156 (1) | 1,00 | 6 % / 10 % / 84 % | 13 | 0 $ |
| 6 | 2,1 % | 12,1 % | 0,0 % | 0,0 % | 0,13 | 0,046 % | 123 (3) | 1,00 | 6 % / 11 % / 83 % | 11 | 0 $ |
| 7 | 3,1 % | 12,5 % | 0,0 % | 0,0 % | 0,20 | 0,076 % | 168 (5) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 8 | 4,5 % | 10,4 % | 0,0 % | 0,0 % | 0,13 | 0,064 % | 206 (3) | 1,00 | 6 % / 10 % / 85 % | 11 | 0 $ |
| 9 | 2,7 % | 13,3 % | 0,0 % | 0,0 % | 0,23 | 0,057 % | 179 (4) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 10 | 3,6 % | 11,3 % | 0,0 % | 0,0 % | 0,14 | 0,083 % | 184 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 11 | 3,6 % | 10,8 % | 0,0 % | 0,3 % | 0,28 | 0,067 % | 179 (3) | 1,00 | 5 % / 10 % / 84 % | 12 | 0 $ |
| 12 | 3,9 % | 11,7 % | 0,0 % | 0,1 % | 0,14 | 0,074 % | 164 (5) | 1,00 | 6 % / 10 % / 85 % | 10 | 0 $ |
| 13 | 3,4 % | 12,9 % | 0,0 % | 0,4 % | 0,18 | 0,042 % | 171 (5) | 1,00 | 5 % / 12 % / 83 % | 12 | 0 $ |
| 14 | 4,3 % | 11,3 % | 0,0 % | 0,0 % | 0,24 | 0,054 % | 197 (4) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 15 | 4,1 % | 11,3 % | 0,0 % | 0,0 % | 0,17 | 0,060 % | 176 (4) | 1,00 | 5 % / 9 % / 85 % | 14 | 0 $ |
| 16 | 2,7 % | 13,8 % | 0,0 % | 0,0 % | 0,14 | 0,062 % | 190 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 17 | 2,9 % | 11,7 % | 0,0 % | 0,0 % | 0,18 | 0,078 % | 254 (3) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 18 | 2,7 % | 12,1 % | 0,0 % | 0,1 % | 0,16 | 0,073 % | 177 (6) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 19 | 1,9 % | 11,7 % | 0,0 % | 0,0 % | 0,12 | 0,073 % | 198 (4) | 1,00 | 6 % / 9 % / 86 % | 13 | 0 $ |
| 20 | 4,5 % | 11,3 % | 0,0 % | 0,0 % | 0,16 | 0,063 % | 202 (6) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 21 | 3,4 % | 11,7 % | 0,0 % | 0,0 % | 0,27 | 0,074 % | 158 (3) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 22 | 4,5 % | 12,5 % | 0,0 % | 0,2 % | 0,16 | 0,062 % | 165 (6) | 1,00 | 5 % / 11 % / 84 % | 10 | 0 $ |
| 23 | 3,2 % | 11,7 % | 0,0 % | 0,0 % | 0,26 | 0,058 % | 178 (2) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 24 | 2,6 % | 10,0 % | 0,0 % | 0,0 % | 0,21 | 0,078 % | 144 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 25 | 2,7 % | 10,8 % | 0,0 % | 0,0 % | 0,24 | 0,059 % | 141 (3) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |
| 26 | 2,6 % | 12,1 % | 0,0 % | 0,0 % | 0,14 | 0,064 % | 205 (2) | 1,00 | 5 % / 9 % / 86 % | 14 | 0 $ |
| 27 | 2,9 % | 10,8 % | 0,0 % | 0,0 % | 0,24 | 0,068 % | 196 (5) | 1,00 | 5 % / 10 % / 85 % | 13 | 0 $ |
| 28 | 2,1 % | 12,9 % | 0,0 % | 0,0 % | 0,13 | 0,055 % | 132 (3) | 1,00 | 6 % / 9 % / 85 % | 10 | 0 $ |
| 29 | 1,5 % | 10,0 % | 0,0 % | 0,0 % | 0,16 | 0,075 % | 167 (3) | 1,00 | 5 % / 9 % / 86 % | 15 | 0 $ |
| 30 | 2,7 % | 12,1 % | 0,0 % | 0,0 % | 0,15 | 0,076 % | 190 (4) | 1,00 | 5 % / 10 % / 85 % | 12 | 0 $ |

</details>

## Critères de sortie

Un critère est rempli si aucune graine n’est hors bande.

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 11/30 : g1 1, g2 2, g3 1, g8 2, g9 2, g11 1, g12 2, g14 1, … |
| Chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Gini 0,2–0,45 | ❌ | 2/30 : g6 0,18, g21 0,46 |
| Inflation moyenne < ±0,5 %/j | ✅ | aucune graine sur 30 |
| Invariant comptable à 1e-8 près | ✅ | aucune graine sur 30 |
| Filets : < 1 déclenchement / 50 j en régime, dans chaque graine | ❌ | Renflouement d’entreprise : 30/30 graines ; Plancher de logement : 2/30 graines |

### Critère de l’institution : avec filets, sauf « anti-famine »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-famine » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Anti-famine » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Anti-famine » : aucune alerte critique | ❌ | 30/30 : g1 7, g2 3, g3 2, g4 3, g5 1, g6 3, g7 5, g8 3, … |

### Critère de l’institution : avec filets, sauf « renflouement d’entreprise »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Renflouement d’entreprise » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Renflouement d’entreprise » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Renflouement d’entreprise » : aucune alerte critique | ❌ | 11/30 : g1 1, g2 1, g3 1, g8 2, g9 2, g11 1, g12 2, g14 1, … |

### Critère de l’institution : avec filets, sauf « plancher de logement »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plancher de logement » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Plancher de logement » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Plancher de logement » : aucune alerte critique | ❌ | 30/30 : g1 6, g2 3, g3 2, g4 3, g5 1, g6 3, g7 5, g8 3, … |

### Critère de l’institution : avec filets, sauf « plafond de dérive des prix et salaires »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Plafond de dérive des prix et salaires » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Plafond de dérive des prix et salaires » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Plafond de dérive des prix et salaires » : aucune alerte critique | ❌ | 30/30 : g1 7, g2 3, g3 2, g4 3, g5 1, g6 3, g7 5, g8 3, … |

### Critère de l’institution : avec filets, sauf « anti-crédit-fou »

| Critère | Résultat | Graines hors bande |
|---|---|---|
| Sans « Anti-crédit-fou » : chômage moyen ≤ 10 % | ✅ | aucune graine sur 30 |
| Sans « Anti-crédit-fou » : faim et sans-abri < 2 % | ✅ | aucune graine sur 30 |
| Sans « Anti-crédit-fou » : aucune alerte critique | ❌ | 30/30 : g1 7, g2 3, g3 2, g4 3, g5 1, g6 3, g7 5, g8 3, … |

