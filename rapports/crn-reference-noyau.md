# Protocole de stabilité ÉcoNodes

- Date : 2026-10-11 12:48
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie), Entrée et sortie d’entreprises

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 6,2 % | 15,0 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,41 | 0,43 | 0,029 % | 10,6 % | 29,4 % | 71 (1) | 0.0e+0 |
| 2 | 5,4 % | 14,6 % | 0,0 % | 19,6 % | 0,2 % | 36,3 % | 0,22 | 0,20 | 0,056 % | 4,1 % | 47,1 % | 82 (2) | 0.0e+0 |
| 3 | 4,8 % | 16,7 % | 0,0 % | 0,0 % | 0,1 % | 23,8 % | 0,20 | 0,18 | 0,024 % | 1,0 % | 18,1 % | 58 (1) | 0.0e+0 |
| 4 | 2,7 % | 11,3 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,26 | 0,27 | 0,014 % | 1,4 % | 13,6 % | 53 (0) | 0.0e+0 |
| 5 | 2,4 % | 12,5 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,25 | 0,25 | 0,017 % | 2,2 % | 17,8 % | 46 (0) | 0.0e+0 |

Santé moyenne de la population : g1 1,00, g2 1,00, g3 1,00, g4 1,00, g5 1,00.

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Faim répandue | critique | · | 1 · 3 j | · | · | · |
| Sans-abri nombreux | critique | · | 1 · 10 j | 1 · 7 j | · | · |
| Inflation quotidienne | critique | 1 · 1 j | · | · | · | · |
| Rupture de stock prolongée | attention | 14 · 12504 j | 25 · 14497 j | 13 · 8700 j | 10 · 10396 j | 10 · 10829 j |
| Surstock | attention | 13 · 3821 j | 8 · 1477 j | 9 · 5663 j | 9 · 3849 j | 8 · 3476 j |
| Entreprise sans employé | attention | 15 · 17171 j | 16 · 15353 j | 13 · 15412 j | 12 · 15389 j | 11 · 15425 j |
| Entreprise sans client | attention | 23 · 16752 j | 24 · 15656 j | 17 · 14154 j | 20 · 14623 j | 15 · 14957 j |
| Embauches bloquées faute de moyens | attention | 1 · 16 j | 3 · 34 j | 1 · 1103 j | 1 · 8 j | 1 · 16 j |
| Prix aberrant | attention | 4 · 997 j | 4 · 1432 j | 4 · 1001 j | 1 · 106 j | 1 · 115 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 5,3 % | 10,6 % | 84,1 % | 13 | 0 $ | 0 $ | 0 $ |
| 2 | 4,3 % | 10,0 % | 85,7 % | 12 | 0 $ | 0 $ | 0 $ |
| 3 | 8,2 % | 13,8 % | 78,0 % | 11 | 0 $ | 0 $ | 0 $ |
| 4 | 6,4 % | 10,7 % | 82,8 % | 11 | 0 $ | 0 $ | 0 $ |
| 5 | 5,5 % | 10,6 % | 83,9 % | 11 | 0 $ | 0 $ | 0 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,9 % | 12,1 % | 0,0 % | 0,0 % | 0,1 % | 11,7 % | 0,13 | 0,10 | 0,072 % | 49,5 % | 100,2 % | 144 (7) | 0.0e+0 |
| 2 | 3,8 % | 12,1 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,12 | 0,14 | 0,081 % | 34,4 % | 52,4 % | 153 (3) | 0.0e+0 |
| 3 | 2,4 % | 11,7 % | 0,0 % | 0,0 % | 0,0 % | 9,2 % | 0,13 | 0,12 | 0,046 % | 10,8 % | 32,0 % | 138 (2) | 0.0e+0 |
| 4 | 2,0 % | 10,0 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,15 | 0,17 | 0,075 % | 38,7 % | 55,2 % | 169 (3) | 0.0e+0 |
| 5 | 2,0 % | 12,1 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,19 | 0,16 | 0,050 % | 6,0 % | 41,4 % | 156 (1) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 649 · 21,29 | 532 · 17,18 | 263 · 7,50 | 439 · 13,96 | 244 · 7,04 | 13,39 ❌ | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 1 · 0,04 | 0 · 0,00 | 1 · 0,04 | 0 · 0,00 | 0 · 0,00 | 0,01 ✅ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

Renflouements en régime, par type d’entreprise (toutes graines) : Tourisme 735, Ferme 498, Ordinateurs 155, Puits de pétrole 114, Aluminerie 67, Électronique 63, Raffinerie 56, Fonderie de puces 49.

Santé moyenne de la population : g1 1,00, g2 1,00, g3 1,00, g4 1,00, g5 1,00.

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | oui | 9,6 % | 67,5 % | 87,9 % | 90 | 101 | Rupture de stock prolongée ×18, Surstock ×1, Entreprise sans client ×4, Entreprise sans employé ×3, Sans-abri nombreux ×2, Embauches bloquées faute de moyens ×1, Faim répandue ×2, Pénurie de main-d’œuvre ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | oui | 14,6 % | 74,2 % | 79,6 % | 106 | 227 | Rupture de stock prolongée ×12, Entreprise sans employé ×1, Embauches bloquées faute de moyens ×2, Prix aberrant ×1, Sans-abri nombreux ×3, Faim répandue ×2, Inflation sur 100 jours ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | oui | 7,5 % | 52,9 % | 80,8 % | 80 | 105 | Rupture de stock prolongée ×12, Entreprise sans client ×5, Entreprise sans employé ×2, Sans-abri nombreux ×3, Faim répandue ×3, Embauches bloquées faute de moyens ×1 |
| +25 immigrants | 1 | oui | 27,9 % | 43,4 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×8, Entreprise sans client ×1, Entreprise sans employé ×1, Prix aberrant ×2, Inégalités hors bornes ×1, Faim répandue ×1, Embauches bloquées faute de moyens ×1 |
| +25 immigrants | 2 | oui | 19,2 % | 0,0 % | 6,4 % | non (> 470) | non | Rupture de stock prolongée ×4, Entreprise sans client ×2, Entreprise sans employé ×2, Prix aberrant ×1, Inflation sur 100 jours ×1, Inégalités hors bornes ×1 |
| +25 immigrants | 3 | oui | 27,9 % | 0,0 % | 6,4 % | non (> 470) | non | Rupture de stock prolongée ×1, Entreprise sans employé ×1, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | oui | 26,3 % | 72,1 % | 37,1 % | non (> 470) | non | Rupture de stock prolongée ×11, Surstock ×1, Entreprise sans client ×4, Entreprise sans employé ×3, Prix aberrant ×2, Faim répandue ×1, Sans-abri nombreux ×6, Embauches bloquées faute de moyens ×1 |
| Salaire minimum 220 $/j | 2 | oui | 30,8 % | 76,3 % | 43,8 % | non (> 470) | non | Rupture de stock prolongée ×14, Surstock ×3, Entreprise sans client ×3, Entreprise sans employé ×4, Embauches bloquées faute de moyens ×2, Prix aberrant ×1, Faim répandue ×2, Sans-abri nombreux ×3 |
| Salaire minimum 220 $/j | 3 | oui | 20,8 % | 0,0 % | 2,1 % | non (> 470) | non | Rupture de stock prolongée ×4, Entreprise sans client ×3, Surstock ×1, Entreprise sans employé ×4, Prix aberrant ×1, Embauches bloquées faute de moyens ×1 |
| Fermeture de la ferme | 1 | oui | 18,8 % | 97,9 % | 25,0 % | 255 ❌ | 271 | Rupture de stock prolongée ×6, Entreprise sans client ×4, Entreprise sans employé ×4, Prix aberrant ×2, Faim répandue ×1, Sans-abri nombreux ×5, Productivité du travail effondrée ×1, Inégalités hors bornes ×1, Embauches bloquées faute de moyens ×1 |
| Fermeture de la ferme | 2 | oui | 66,7 % | 100,0 % | 41,3 % | non (> 470) | non | Rupture de stock prolongée ×6, Entreprise sans client ×7, Entreprise sans employé ×6, Embauches bloquées faute de moyens ×2, Prix aberrant ×3, Faim répandue ×1, Sans-abri nombreux ×1, Productivité du travail effondrée ×1, Chômage très élevé ×1, Inflation sur 100 jours ×1, Prestations réduites faute de trésor ×1, Inflation quotidienne ×1 |
| Fermeture de la ferme | 3 | oui | 38,3 % | 96,3 % | 46,7 % | 378 ❌ | 426 | Rupture de stock prolongée ×7, Entreprise sans client ×4, Entreprise sans employé ×5, Prix aberrant ×2, Faim répandue ×1, Sans-abri nombreux ×5, Productivité du travail effondrée ×1, Embauches bloquées faute de moyens ×2, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×1, Prestations réduites faute de trésor ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | oui | 11,7 % | 25,8 % | 1,7 % | 1 | non | Rupture de stock prolongée ×5, Entreprise sans client ×1, Entreprise sans employé ×1, Prix aberrant ×1, Faim répandue ×1, Embauches bloquées faute de moyens ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | oui | 14,6 % | 19,6 % | 36,3 % | 1 | 1 | Rupture de stock prolongée ×5, Entreprise sans employé ×1, Embauches bloquées faute de moyens ×1, Prix aberrant ×1, Sans-abri nombreux ×1, Faim répandue ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | oui | 5,4 % | 0,0 % | 23,8 % | 1 | 1 | Rupture de stock prolongée ×2, Entreprise sans client ×1, Entreprise sans employé ×1, Prix aberrant ×1, Sans-abri nombreux ×1, Embauches bloquées faute de moyens ×2 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | oui | 11,3 % | 65,8 % | 63,7 % | 108 | 191 | Rupture de stock prolongée ×18, Surstock ×14, Entreprise sans client ×28, Entreprise sans employé ×15, Prix aberrant ×1, Inflation quotidienne ×1, Sans-abri nombreux ×2, Faim répandue ×2, Pénurie de main-d’œuvre ×1, Inflation sur 100 jours ×1, Embauches bloquées faute de moyens ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | oui | 9,6 % | 28,7 % | 55,8 % | 103 | 132 | Rupture de stock prolongée ×20, Surstock ×20, Entreprise sans client ×33, Entreprise sans employé ×15, Inflation quotidienne ×4, Sans-abri nombreux ×1, Faim répandue ×1, Pénurie de main-d’œuvre ×1, Embauches bloquées faute de moyens ×1, Inflation sur 100 jours ×1, Prix aberrant ×2 |
| Hélicoptère 5 000 $/citoyen | 3 | oui | 5,4 % | 65,0 % | 65,4 % | 76 | 76 | Rupture de stock prolongée ×16, Entreprise sans client ×29, Surstock ×16, Entreprise sans employé ×14, Sans-abri nombreux ×2, Prix aberrant ×1, Pénurie de main-d’œuvre ×1, Faim répandue ×1 |
| +25 immigrants | 1 | oui | 19,6 % | 0,0 % | 4,9 % | non (> 470) | non | Rupture de stock prolongée ×4, Surstock ×10, Entreprise sans client ×13, Entreprise sans employé ×9, Prix aberrant ×1, Inflation quotidienne ×2, Inégalités hors bornes ×1 |
| +25 immigrants | 2 | oui | 19,6 % | 0,0 % | 6,4 % | non (> 470) | non | Rupture de stock prolongée ×4, Surstock ×8, Entreprise sans client ×24, Entreprise sans employé ×5, Inflation quotidienne ×3, Prix aberrant ×1, Inégalités hors bornes ×1 |
| +25 immigrants | 3 | oui | 21,5 % | 0,0 % | 4,9 % | non (> 470) | non | Rupture de stock prolongée ×5, Entreprise sans client ×14, Surstock ×5, Entreprise sans employé ×5, Prix aberrant ×1, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | oui | 22,9 % | 0,0 % | 1,7 % | non (> 470) | non | Rupture de stock prolongée ×2, Surstock ×11, Entreprise sans client ×16, Entreprise sans employé ×9, Prix aberrant ×3, Inflation quotidienne ×2, Inflation sur 100 jours ×1 |
| Salaire minimum 220 $/j | 2 | oui | 21,7 % | 0,0 % | 1,3 % | non (> 470) | non | Rupture de stock prolongée ×1, Surstock ×15, Entreprise sans client ×23, Entreprise sans employé ×10, Inflation quotidienne ×3, Prix aberrant ×3 |
| Salaire minimum 220 $/j | 3 | oui | 27,9 % | 73,8 % | 27,1 % | non (> 470) | non | Rupture de stock prolongée ×12, Entreprise sans client ×21, Surstock ×11, Entreprise sans employé ×10, Prix aberrant ×3, Faim répandue ×1, Embauches bloquées faute de moyens ×1 |
| Fermeture de la ferme | 1 | oui | 36,7 % | 78,8 % | 14,2 % | 367 ❌ | 404 | Rupture de stock prolongée ×8, Surstock ×6, Entreprise sans client ×17, Entreprise sans employé ×7, Prix aberrant ×5, Inflation quotidienne ×2, Sans-abri nombreux ×2, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×1, Prestations réduites faute de trésor ×1 |
| Fermeture de la ferme | 2 | oui | 30,0 % | 75,8 % | 40,0 % | 232 ❌ | 324 | Rupture de stock prolongée ×8, Surstock ×8, Entreprise sans client ×17, Entreprise sans employé ×9, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Sans-abri nombreux ×2, Prix aberrant ×4, Inflation quotidienne ×1 |
| Fermeture de la ferme | 3 | oui | 63,3 % | 78,8 % | 38,8 % | 409 ❌ | non | Rupture de stock prolongée ×8, Entreprise sans client ×9, Surstock ×3, Entreprise sans employé ×4, Sans-abri nombreux ×6, Prix aberrant ×3, Faim répandue ×7, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×1, Prestations réduites faute de trésor ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | oui | 7,9 % | 0,0 % | 0,0 % | 15 | 15 | Rupture de stock prolongée ×3, Surstock ×10, Entreprise sans client ×16, Entreprise sans employé ×7, Prix aberrant ×1, Inflation quotidienne ×2 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | oui | 5,0 % | 0,0 % | 17,5 % | 1 | 1 | Rupture de stock prolongée ×5, Surstock ×7, Entreprise sans client ×20, Entreprise sans employé ×6, Inflation quotidienne ×3, Prix aberrant ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | oui | 5,4 % | 0,0 % | 0,0 % | 1 | 1 | Rupture de stock prolongée ×4, Entreprise sans client ×17, Surstock ×7, Entreprise sans employé ×8, Prix aberrant ×3 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 4 ouverture(s) critique(s) |
| Chômage moyen ≤ 10 % | ✅ | toutes les graines |
| Faim et sans-abri < 2 % | ✅ | toutes les graines |
| Gini 0,2–0,45 | ✅ | toutes les graines |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 13,39/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 9/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 9/15 échecs |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 4,3 % | 4,3 % |
| Faim moyenne | 0,0 % | 0,0 % |
| Sans-abri moyen | 0,0 % | 0,1 % |
| Gini moyen | 0,34 | 0,27 |
| Inflation moyenne / jour | 0,022 % | 0,028 % |
| Santé moyenne (sans filets) | 1,00 | 1,00 |
| Jours de prestations réduites (sans filets, toutes graines) | 0 | 0 |
| Trésor de l’État le plus bas (sans filets, $) | 142225 | 146841 |
| Caisse insolvable : jours (sans filets, toutes graines) | 0 | 0 |
| Fonds propres de la Caisse les plus bas (sans filets, $) | 24000 | 24000 |
| Prêts refusés (sans filets, toutes graines) | 0 | 0 |
| Créances radiées (sans filets, moyenne, $) | 0 | 0 |
| Hôpital public : attente moyenne (j, sans filets) | 0,00 | 0,00 |
| Alertes critiques (total) | 2 | 4 |
| Alertes (total) | 292 | 310 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 0,00 |
| Renflouements / 50 j | 8,93 | 13,39 |
| Plancher de logement / 50 j | 0,04 | 0,01 |
| Plafond de dérive / 50 j | 0,00 | 0,00 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |
| Avec filets : chômage moyen | 4,1 % | 3,0 % |
| Avec filets : faim moyenne | 0,0 % | 0,0 % |
| Avec filets : sans-abri moyen | 0,0 % | 0,0 % |
| Avec filets : Gini moyen | 0,20 | 0,14 |
| Avec filets : santé moyenne | 1,00 | 1,00 |
| Avec filets : jours de prestations réduites | 0 | 0 |
| Renflouements de l’hôpital / 50 j | 0,00 | 0,00 |
| Chocs revenus à l’équilibre en < 200 j (sans filets) | 6 | 6 |
| Chocs revenus à l’équilibre en < 200 j (avec filets) | 6 | 6 |

