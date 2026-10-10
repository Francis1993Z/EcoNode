# Protocole de stabilité ÉcoNodes

- Date : 2026-10-10 13:24
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie), Entrée et sortie d’entreprises

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 6,8 % | 12,1 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,39 | 0,43 | 0,023 % | 2,0 % | 37,0 % | 62 (0) | 0.0e+0 |
| 2 | 3,8 % | 11,3 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,27 | 0,29 | 0,017 % | 1,7 % | 15,6 % | 58 (0) | 0.0e+0 |
| 3 | 7,2 % | 11,3 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,38 | 0,41 | 0,022 % | 1,8 % | 32,3 % | 50 (0) | 0.0e+0 |
| 4 | 3,1 % | 12,5 % | 0,0 % | 0,0 % | 0,0 % | 9,2 % | 0,25 | 0,25 | 0,018 % | 1,6 % | 12,6 % | 53 (1) | 0.0e+0 |
| 5 | 5,2 % | 14,2 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,31 | 0,31 | 0,006 % | 0,8 % | 7,5 % | 66 (0) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Sans-abri nombreux | critique | · | · | · | 1 · 3 j | · |
| Rupture de stock prolongée | attention | 13 · 9980 j | 7 · 4752 j | 8 · 7093 j | 6 · 4972 j | 12 · 6361 j |
| Surstock | attention | 12 · 3007 j | 15 · 8131 j | 11 · 7322 j | 13 · 9361 j | 15 · 7972 j |
| Entreprise sans employé | attention | 13 · 15191 j | 14 · 15425 j | 13 · 15247 j | 14 · 15412 j | 15 · 15404 j |
| Entreprise sans client | attention | 20 · 15471 j | 21 · 14643 j | 16 · 15570 j | 17 · 14814 j | 18 · 14770 j |
| Embauches bloquées faute de moyens | attention | 2 · 7 j | · | · | 1 · 1 j | 5 · 60 j |
| Prix aberrant | attention | 2 · 1338 j | 1 · 86 j | 2 · 1327 j | 1 · 103 j | 1 · 97 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 4,9 % | 10,2 % | 84,9 % | 11 | 0 $ | 0 $ | 0 $ |
| 2 | 5,7 % | 11,8 % | 82,5 % | 11 | 0 $ | 0 $ | 0 $ |
| 3 | 5,4 % | 10,8 % | 83,8 % | 11 | 0 $ | 0 $ | 0 $ |
| 4 | 6,9 % | 10,0 % | 83,1 % | 11 | 0 $ | 0 $ | 0 $ |
| 5 | 6,1 % | 11,8 % | 82,0 % | 11 | 0 $ | 0 $ | 0 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,3 % | 9,6 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,34 | 0,33 | 0,080 % | 31,9 % | 87,2 % | 151 (4) | 0.0e+0 |
| 2 | 2,9 % | 8,8 % | 0,0 % | 0,0 % | 0,2 % | 35,4 % | 0,19 | 0,16 | 0,051 % | 15,1 % | 37,4 % | 157 (2) | 0.0e+0 |
| 3 | 3,0 % | 9,2 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,13 | 0,11 | 0,056 % | 14,9 % | 59,2 % | 211 (5) | 0.0e+0 |
| 4 | 2,3 % | 10,4 % | 0,0 % | 0,0 % | 0,0 % | 11,3 % | 0,16 | 0,16 | 0,075 % | 19,3 % | 56,0 % | 171 (5) | 0.0e+0 |
| 5 | 2,4 % | 10,8 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,19 | 0,23 | 0,036 % | 13,5 % | 25,7 % | 133 (1) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 472 · 15,00 | 287 · 8,71 | 601 · 19,71 | 497 · 16,00 | 257 · 7,68 | 13,42 ❌ | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0 · 0,00 | 30 · 1,07 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,21 ✅ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## 2 bis. Avec filets, sauf : Renflouement d’entreprise

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 6,8 % | 12,1 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,39 | 0,43 | 0,023 % | 2,0 % | 37,0 % | 62 (0) | 0.0e+0 |
| 2 | 3,8 % | 11,3 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,27 | 0,29 | 0,017 % | 1,7 % | 15,6 % | 58 (0) | 0.0e+0 |
| 3 | 7,2 % | 11,3 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,38 | 0,41 | 0,022 % | 1,8 % | 32,3 % | 50 (0) | 0.0e+0 |
| 4 | 3,1 % | 12,5 % | 0,0 % | 0,0 % | 0,0 % | 9,2 % | 0,25 | 0,25 | 0,018 % | 1,6 % | 12,6 % | 53 (1) | 0.0e+0 |
| 5 | 5,2 % | 14,2 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,31 | 0,31 | 0,006 % | 0,8 % | 7,5 % | 66 (0) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | — | — | — | — | — | coupé | — |
| Plancher de logement | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | oui | 7,5 % | 94,6 % | 70,0 % | 55 | 353 | Rupture de stock prolongée ×11, Entreprise sans client ×7, Surstock ×2, Entreprise sans employé ×4, Prix aberrant ×3, Sans-abri nombreux ×1, Faim répandue ×2, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×2 |
| Hélicoptère 5 000 $/citoyen | 2 | oui | 9,6 % | 57,5 % | 89,2 % | 73 | 98 | Rupture de stock prolongée ×17, Surstock ×1, Entreprise sans client ×2, Entreprise sans employé ×1, Sans-abri nombreux ×2, Faim répandue ×2, Pénurie de main-d’œuvre ×1, Embauches bloquées faute de moyens ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | oui | 7,9 % | 74,2 % | 52,1 % | 134 | 369 | Rupture de stock prolongée ×13, Entreprise sans client ×4, Surstock ×5, Entreprise sans employé ×4, Prix aberrant ×2, Sans-abri nombreux ×2, Faim répandue ×1, Embauches bloquées faute de moyens ×1 |
| +25 immigrants | 1 | oui | 18,1 % | 0,0 % | 4,9 % | non (> 470) | non | Rupture de stock prolongée ×5, Entreprise sans client ×2, Entreprise sans employé ×2, Prix aberrant ×1, Inégalités hors bornes ×1, Embauches bloquées faute de moyens ×1 |
| +25 immigrants | 2 | oui | 15,8 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×2, Entreprise sans client ×1, Entreprise sans employé ×1, Embauches bloquées faute de moyens ×1 |
| +25 immigrants | 3 | oui | 18,1 % | 38,9 % | 9,8 % | non (> 470) | non | Rupture de stock prolongée ×6, Entreprise sans client ×2, Entreprise sans employé ×2, Prix aberrant ×1, Faim répandue ×1, Embauches bloquées faute de moyens ×1, Inflation sur 100 jours ×1, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | oui | 24,6 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×1, Entreprise sans client ×5, Surstock ×3, Entreprise sans employé ×3, Prix aberrant ×2, Inflation quotidienne ×3 |
| Salaire minimum 220 $/j | 2 | oui | 19,6 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×3, Entreprise sans client ×3, Entreprise sans employé ×3, Prix aberrant ×1, Embauches bloquées faute de moyens ×1 |
| Salaire minimum 220 $/j | 3 | oui | 24,6 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×2, Entreprise sans client ×3, Surstock ×1, Entreprise sans employé ×3, Prix aberrant ×2, Inflation quotidienne ×2, Embauches bloquées faute de moyens ×1 |
| Fermeture de la ferme | 1 | oui | 67,1 % | 100,0 % | 22,9 % | non (> 470) | non | Rupture de stock prolongée ×5, Entreprise sans client ×10, Entreprise sans employé ×6, Prix aberrant ×3, Faim répandue ×1, Sans-abri nombreux ×1, Productivité du travail effondrée ×1, Chômage très élevé ×1, Inflation quotidienne ×2, Embauches bloquées faute de moyens ×1 |
| Fermeture de la ferme | 2 | oui | 51,2 % | 95,8 % | 43,3 % | 383 ❌ | non | Rupture de stock prolongée ×7, Entreprise sans client ×4, Entreprise sans employé ×4, Prix aberrant ×4, Faim répandue ×3, Sans-abri nombreux ×8, Productivité du travail effondrée ×1, Embauches bloquées faute de moyens ×2, Inégalités hors bornes ×1, Richesse médiane hors bornes ×3, Chômage très élevé ×1 |
| Fermeture de la ferme | 3 | oui | 62,9 % | 100,0 % | 23,3 % | non (> 470) | non | Rupture de stock prolongée ×5, Entreprise sans client ×8, Entreprise sans employé ×6, Prix aberrant ×2, Faim répandue ×1, Sans-abri nombreux ×1, Productivité du travail effondrée ×1, Embauches bloquées faute de moyens ×2, Inflation sur 100 jours ×2, Chômage très élevé ×1, Inflation quotidienne ×2 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | oui | 10,4 % | 0,0 % | 0,0 % | 1 | 1 | Rupture de stock prolongée ×1, Entreprise sans employé ×1, Embauches bloquées faute de moyens ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | oui | 5,8 % | 0,0 % | 0,0 % | 1 | 1 | Rupture de stock prolongée ×1, Entreprise sans client ×1, Entreprise sans employé ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | oui | 9,6 % | 0,0 % | 0,0 % | 1 | 1 | Entreprise sans employé ×1 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | oui | 10,0 % | 65,8 % | 54,2 % | 69 | 209 | Rupture de stock prolongée ×21, Entreprise sans client ×26, Surstock ×13, Entreprise sans employé ×18, Inflation quotidienne ×1, Embauches bloquées faute de moyens ×1, Prix aberrant ×5, Sans-abri nombreux ×1, Faim répandue ×2, Pénurie de main-d’œuvre ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | oui | 9,2 % | 62,5 % | 52,5 % | 70 | 145 | Rupture de stock prolongée ×18, Surstock ×19, Entreprise sans client ×30, Entreprise sans employé ×17, Sans-abri nombreux ×1, Faim répandue ×1, Pénurie de main-d’œuvre ×1, Prix aberrant ×1, Embauches bloquées faute de moyens ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | oui | 7,1 % | 53,3 % | 45,4 % | 77 | 113 | Rupture de stock prolongée ×10, Entreprise sans client ×26, Surstock ×16, Entreprise sans employé ×12, Prix aberrant ×3, Sans-abri nombreux ×2, Embauches bloquées faute de moyens ×1, Faim répandue ×1 |
| +25 immigrants | 1 | oui | 19,2 % | 0,0 % | 4,9 % | non (> 470) | non | Rupture de stock prolongée ×15, Entreprise sans client ×28, Surstock ×9, Entreprise sans employé ×18, Inflation quotidienne ×2, Prix aberrant ×4, Inégalités hors bornes ×1 |
| +25 immigrants | 2 | oui | 11,3 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×4, Surstock ×14, Entreprise sans client ×22, Entreprise sans employé ×9, Prix aberrant ×3 |
| +25 immigrants | 3 | oui | 16,6 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×2, Entreprise sans client ×15, Surstock ×8, Entreprise sans employé ×8, Prix aberrant ×2 |
| Salaire minimum 220 $/j | 1 | oui | 23,3 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×11, Entreprise sans client ×27, Surstock ×11, Entreprise sans employé ×18, Inflation quotidienne ×1, Prix aberrant ×6 |
| Salaire minimum 220 $/j | 2 | oui | 19,6 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×5, Surstock ×13, Entreprise sans client ×31, Entreprise sans employé ×10, Inflation quotidienne ×4, Prix aberrant ×3 |
| Salaire minimum 220 $/j | 3 | oui | 24,6 % | 67,1 % | 10,4 % | non (> 470) | non | Rupture de stock prolongée ×15, Entreprise sans client ×25, Surstock ×8, Entreprise sans employé ×9, Inflation quotidienne ×1, Prix aberrant ×7, Faim répandue ×1, Embauches bloquées faute de moyens ×1 |
| Fermeture de la ferme | 1 | oui | 59,6 % | 75,0 % | 53,8 % | 348 ❌ | 365 | Rupture de stock prolongée ×7, Entreprise sans client ×23, Surstock ×12, Entreprise sans employé ×15, Inflation quotidienne ×1, Prix aberrant ×6, Faim répandue ×2, Inflation sur 100 jours ×1, Inégalités hors bornes ×1, Sans-abri nombreux ×4, Richesse médiane hors bornes ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 2 | oui | 57,5 % | 80,4 % | 31,7 % | 349 ❌ | non | Rupture de stock prolongée ×10, Surstock ×12, Entreprise sans client ×27, Entreprise sans employé ×14, Faim répandue ×2, Inégalités hors bornes ×1, Sans-abri nombreux ×9, Richesse médiane hors bornes ×1, Chômage très élevé ×1, Prix aberrant ×4 |
| Fermeture de la ferme | 3 | oui | 55,8 % | 73,3 % | 55,8 % | 278 ❌ | 320 | Rupture de stock prolongée ×10, Entreprise sans client ×33, Surstock ×18, Entreprise sans employé ×19, Prix aberrant ×7, Faim répandue ×2, Inégalités hors bornes ×1, Chômage très élevé ×1, Sans-abri nombreux ×5 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | oui | 9,6 % | 0,0 % | 0,0 % | 1 | non | Rupture de stock prolongée ×9, Entreprise sans client ×21, Surstock ×8, Entreprise sans employé ×14, Inflation quotidienne ×1, Prix aberrant ×8 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | oui | 5,0 % | 0,0 % | 0,0 % | 1 | 1 | Rupture de stock prolongée ×5, Surstock ×13, Entreprise sans client ×22, Entreprise sans employé ×12, Inflation quotidienne ×2, Prix aberrant ×6 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | oui | 5,4 % | 0,0 % | 0,0 % | 1 | 1 | Rupture de stock prolongée ×6, Entreprise sans client ×17, Surstock ×7, Entreprise sans employé ×8, Prix aberrant ×3 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 1 ouverture(s) critique(s) |
| Chômage moyen ≤ 10 % | ✅ | toutes les graines |
| Faim et sans-abri < 2 % | ✅ | toutes les graines |
| Gini 0,2–0,45 | ✅ | toutes les graines |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 13,42/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 9/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 9/15 échecs |

### Critère de l’institution (étape 2 bis)

| Critère | Résultat | Détail |
|---|---|---|
| Sans « Renflouement d’entreprise » : chômage moyen ≤ 10 % | ✅ | toutes les graines |
| Sans « Renflouement d’entreprise » : faim et sans-abri < 2 % | ✅ | toutes les graines |
| Sans « Renflouement d’entreprise » : aucune alerte critique | ❌ | 1 ouverture(s) critique(s) |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 5,0 % | 5,2 % |
| Faim moyenne | 0,0 % | 0,0 % |
| Sans-abri moyen | 0,0 % | 0,0 % |
| Gini moyen | 0,33 | 0,32 |
| Inflation moyenne / jour | 0,009 % | 0,017 % |
| Alertes critiques (total) | 5 | 1 |
| Alertes (total) | 277 | 289 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 0,00 |
| Renflouements / 50 j | 19,79 | 13,42 |
| Plancher de logement / 50 j | 0,45 | 0,21 |
| Plafond de dérive / 50 j | 0,00 | 0,00 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |
| Avec filets : chômage moyen | 3,6 % | 3,0 % |
| Avec filets : faim moyenne | 0,0 % | 0,0 % |
| Avec filets : sans-abri moyen | 0,1 % | 0,0 % |
| Avec filets : Gini moyen | 0,14 | 0,20 |
| Filets sauf --sauf : chômage moyen | 5,8 % | 5,2 % |
| Filets sauf --sauf : faim moyenne | 0,0 % | 0,0 % |
| Filets sauf --sauf : sans-abri moyen | 0,0 % | 0,0 % |
| Filets sauf --sauf : Gini moyen | 0,34 | 0,32 |
| Filets sauf --sauf : alertes critiques | 7 | 1 |
| Filets sauf --sauf : anti-famine / 50 j | 0,00 | 0,00 |
| Filets sauf --sauf : plancher de logement / 50 j | 0,01 | 0,00 |
| Filets sauf --sauf : plafond de dérive / 50 j | 0,00 | 0,00 |
| Filets sauf --sauf : anti-crédit-fou / 50 j | 0,00 | 0,00 |
| Chocs revenus à l’équilibre en < 200 j (sans filets) | 6 | 6 |
| Chocs revenus à l’équilibre en < 200 j (avec filets) | 8 | 6 |

