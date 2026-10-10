# Protocole de stabilité ÉcoNodes

- Date : 2026-10-10 14:26
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie), Entrée et sortie d’entreprises, Faillite ordonnée

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 7,2 % | 12,9 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,42 | 0,47 | 0,010 % | 1,1 % | 24,0 % | 60 (0) | 0.0e+0 |
| 2 | 2,2 % | 13,8 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,24 | 0,23 | 0,039 % | 2,0 % | 53,3 % | 60 (0) | 0.0e+0 |
| 3 | 6,5 % | 12,1 % | 0,1 % | 18,3 % | 0,0 % | 0,0 % | 0,46 | 0,53 | 0,025 % | 1,8 % | 47,4 % | 62 (1) | 0.0e+0 |
| 4 | 2,7 % | 13,3 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,26 | 0,27 | 0,022 % | 8,6 % | 21,2 % | 53 (1) | 0.0e+0 |
| 5 | 3,0 % | 15,0 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,29 | 0,30 | 0,014 % | 0,7 % | 18,4 % | 57 (0) | 0.0e+0 |

Santé moyenne de la population : g1 1,00, g2 1,00, g3 1,00, g4 1,00, g5 1,00.

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Faim répandue | critique | · | · | 1 · 4 j | · | · |
| Inflation quotidienne | critique | · | · | · | 1 · 1 j | · |
| Rupture de stock prolongée | attention | 10 · 9157 j | 20 · 10226 j | 15 · 15283 j | 10 · 9790 j | 11 · 8508 j |
| Surstock | attention | 13 · 5222 j | 15 · 4329 j | 9 · 1552 j | 9 · 2934 j | 12 · 5743 j |
| Entreprise sans employé | attention | 12 · 15425 j | 12 · 15118 j | 14 · 16730 j | 12 · 15181 j | 13 · 15277 j |
| Entreprise sans client | attention | 21 · 14751 j | 11 · 15176 j | 18 · 17693 j | 19 · 15353 j | 18 · 15415 j |
| Embauches bloquées faute de moyens | attention | 2 · 8 j | · | 3 · 37 j | · | 1 · 11 j |
| Prix aberrant | attention | 2 · 185 j | 2 · 1199 j | 2 · 831 j | 2 · 110 j | 2 · 1349 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 5,8 % | 11,2 % | 83,0 % | 11 | 0 $ | 0 $ | 0 $ |
| 2 | 5,5 % | 10,5 % | 84,0 % | 11 | 0 $ | 0 $ | 0 $ |
| 3 | 4,4 % | 12,8 % | 82,8 % | 13 | 0 $ | 0 $ | 0 $ |
| 4 | 6,4 % | 11,6 % | 82,0 % | 11 | 0 $ | 0 $ | 0 $ |
| 5 | 5,6 % | 12,8 % | 81,6 % | 11 | 0 $ | 0 $ | 0 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,9 % | 10,0 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,36 | 0,34 | 0,079 % | 39,5 % | 103,6 % | 148 (6) | 0.0e+0 |
| 2 | 3,2 % | 10,8 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,15 | 0,18 | 0,075 % | 29,4 % | 53,1 % | 200 (8) | 0.0e+0 |
| 3 | 3,9 % | 10,4 % | 0,0 % | 0,0 % | 0,0 % | 9,2 % | 0,14 | 0,15 | 0,075 % | 40,5 % | 70,6 % | 164 (3) | 0.0e+0 |
| 4 | 3,7 % | 11,7 % | 0,0 % | 0,0 % | 0,1 % | 21,3 % | 0,20 | 0,20 | 0,047 % | 12,2 % | 39,5 % | 162 (2) | 0.0e+0 |
| 5 | 4,7 % | 14,6 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,17 | 0,22 | 0,039 % | 8,8 % | 21,8 % | 151 (1) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 256 · 7,29 | 376 · 11,64 | 340 · 10,21 | 220 · 6,57 | 300 · 8,93 | 8,93 ❌ | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0 · 0,00 | 0 · 0,00 | 1 · 0,04 | 4 · 0,14 | 0 · 0,00 | 0,04 ✅ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

Renflouements en régime, par type d’entreprise (toutes graines) : Tourisme 418, Ferme 258, Puits de pétrole 126, Ordinateurs 113, Électronique 60, Fonderie de puces 48, Raffinerie 47, Mine d’or 43.

Santé moyenne de la population : g1 1,00, g2 1,00, g3 1,00, g4 1,00, g5 1,00.

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage ≤ 10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | oui | 8,3 % | 60,8 % | 53,3 % | 77 | 241 | Rupture de stock prolongée ×11, Surstock ×1, Entreprise sans employé ×3, Entreprise sans client ×3, Embauches bloquées faute de moyens ×1, Prix aberrant ×1, Sans-abri nombreux ×1, Pénurie de main-d’œuvre ×1, Faim répandue ×1, Inflation quotidienne ×3 |
| Hélicoptère 5 000 $/citoyen | 2 | oui | 15,0 % | 89,2 % | 79,6 % | 56 | 107 | Rupture de stock prolongée ×10, Entreprise sans employé ×2, Entreprise sans client ×2, Prix aberrant ×1, Sans-abri nombreux ×3, Faim répandue ×1, Embauches bloquées faute de moyens ×1, Inflation quotidienne ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | oui | 15,8 % | 77,9 % | 81,7 % | 53 | 410 | Rupture de stock prolongée ×8, Entreprise sans client ×2, Entreprise sans employé ×3, Sans-abri nombreux ×3, Faim répandue ×3, Embauches bloquées faute de moyens ×1, Chômage nul prolongé ×1 |
| +25 immigrants | 1 | oui | 26,4 % | 29,1 % | 6,0 % | non (> 470) | non | Rupture de stock prolongée ×7, Surstock ×2, Entreprise sans employé ×1, Entreprise sans client ×1, Embauches bloquées faute de moyens ×1, Faim répandue ×1, Inégalités hors bornes ×1 |
| +25 immigrants | 2 | oui | 12,8 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×5, Entreprise sans employé ×1, Entreprise sans client ×3, Prix aberrant ×2, Inflation sur 100 jours ×1, Embauches bloquées faute de moyens ×1 |
| +25 immigrants | 3 | oui | 31,3 % | 69,8 % | 16,2 % | non (> 470) | non | Rupture de stock prolongée ×7, Entreprise sans client ×2, Entreprise sans employé ×2, Prix aberrant ×1, Faim répandue ×2, Embauches bloquées faute de moyens ×2, Inégalités hors bornes ×1, Sans-abri nombreux ×1 |
| Salaire minimum 220 $/j | 1 | oui | 26,7 % | 26,3 % | 6,7 % | non (> 470) | non | Rupture de stock prolongée ×5, Surstock ×2, Entreprise sans employé ×3, Entreprise sans client ×5, Embauches bloquées faute de moyens ×1, Prix aberrant ×2, Faim répandue ×1, Sans-abri nombreux ×1 |
| Salaire minimum 220 $/j | 2 | oui | 26,7 % | 12,9 % | 7,1 % | non (> 470) | non | Rupture de stock prolongée ×6, Entreprise sans employé ×3, Entreprise sans client ×3, Prix aberrant ×2, Embauches bloquées faute de moyens ×1 |
| Salaire minimum 220 $/j | 3 | oui | 32,5 % | 75,8 % | 43,3 % | non (> 470) | non | Rupture de stock prolongée ×5, Entreprise sans client ×5, Surstock ×1, Entreprise sans employé ×5, Prix aberrant ×2, Faim répandue ×1, Sans-abri nombreux ×7, Embauches bloquées faute de moyens ×1 |
| Fermeture de la ferme | 1 | oui | 25,0 % | 94,6 % | 22,9 % | 280 ❌ | non | Rupture de stock prolongée ×6, Entreprise sans employé ×5, Entreprise sans client ×4, Embauches bloquées faute de moyens ×1, Prix aberrant ×3, Faim répandue ×1, Sans-abri nombreux ×4, Inégalités hors bornes ×1 |
| Fermeture de la ferme | 2 | oui | 68,3 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×6, Entreprise sans employé ×7, Entreprise sans client ×8, Prix aberrant ×4, Faim répandue ×1, Sans-abri nombreux ×1, Productivité du travail effondrée ×1, Embauches bloquées faute de moyens ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1, Inflation sur 100 jours ×1 |
| Fermeture de la ferme | 3 | oui | 96,3 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×4, Entreprise sans client ×8, Entreprise sans employé ×8, Prix aberrant ×2, Faim répandue ×1, Sans-abri nombreux ×1, Productivité du travail effondrée ×1, Embauches bloquées faute de moyens ×1, Prestations réduites faute de trésor ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | oui | 10,8 % | 0,0 % | 0,0 % | 1 | non | Rupture de stock prolongée ×4, Entreprise sans employé ×1, Entreprise sans client ×1, Embauches bloquées faute de moyens ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | oui | 3,8 % | 0,0 % | 0,0 % | 1 | 35 | Rupture de stock prolongée ×5, Entreprise sans employé ×1, Entreprise sans client ×1, Prix aberrant ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | oui | 10,8 % | 0,0 % | 0,0 % | 1 | 1 | Rupture de stock prolongée ×1, Entreprise sans client ×2, Entreprise sans employé ×2, Prix aberrant ×1, Embauches bloquées faute de moyens ×1 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | oui | 9,6 % | 60,4 % | 48,3 % | 101 | 222 | Rupture de stock prolongée ×14, Surstock ×17, Entreprise sans client ×36, Entreprise sans employé ×15, Prix aberrant ×2, Inflation quotidienne ×3, Inflation sur 100 jours ×1, Sans-abri nombreux ×1, Faim répandue ×2, Embauches bloquées faute de moyens ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | oui | 10,4 % | 62,5 % | 66,3 % | 142 | 163 | Rupture de stock prolongée ×19, Surstock ×21, Entreprise sans client ×33, Entreprise sans employé ×13, Inflation quotidienne ×3, Sans-abri nombreux ×1, Faim répandue ×1, Pénurie de main-d’œuvre ×1, Embauches bloquées faute de moyens ×1, Inflation sur 100 jours ×1, Prix aberrant ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | oui | 6,3 % | 52,9 % | 50,4 % | 64 | 64 | Rupture de stock prolongée ×17, Entreprise sans client ×39, Surstock ×20, Entreprise sans employé ×22, Inflation quotidienne ×3, Sans-abri nombreux ×3, Faim répandue ×1, Embauches bloquées faute de moyens ×1, Inflation sur 100 jours ×1 |
| +25 immigrants | 1 | oui | 14,3 % | 0,0 % | 4,9 % | non (> 470) | non | Rupture de stock prolongée ×4, Surstock ×9, Entreprise sans client ×15, Entreprise sans employé ×8, Prix aberrant ×4, Inflation quotidienne ×2, Inflation sur 100 jours ×2 |
| +25 immigrants | 2 | oui | 11,7 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×3, Surstock ×13, Entreprise sans client ×19, Entreprise sans employé ×5, Inflation quotidienne ×2, Prix aberrant ×1 |
| +25 immigrants | 3 | oui | 14,0 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×4, Entreprise sans client ×18, Surstock ×4, Entreprise sans employé ×5, Inflation quotidienne ×3, Prix aberrant ×2 |
| Salaire minimum 220 $/j | 1 | oui | 24,6 % | 0,0 % | 2,5 % | non (> 470) | non | Rupture de stock prolongée ×14, Surstock ×11, Entreprise sans client ×31, Entreprise sans employé ×16, Prix aberrant ×6, Inflation quotidienne ×3, Inflation sur 100 jours ×1 |
| Salaire minimum 220 $/j | 2 | oui | 22,5 % | 71,7 % | 24,6 % | non (> 470) | non | Rupture de stock prolongée ×7, Surstock ×19, Entreprise sans client ×37, Entreprise sans employé ×8, Inflation quotidienne ×4, Faim répandue ×1, Embauches bloquées faute de moyens ×1, Prix aberrant ×1 |
| Salaire minimum 220 $/j | 3 | oui | 24,2 % | 0,0 % | 1,7 % | non (> 470) | non | Rupture de stock prolongée ×4, Entreprise sans client ×11, Surstock ×4, Entreprise sans employé ×6, Inflation quotidienne ×3, Prix aberrant ×4, Embauches bloquées faute de moyens ×1 |
| Fermeture de la ferme | 1 | oui | 76,3 % | 77,5 % | 43,3 % | 460 ❌ | non | Rupture de stock prolongée ×7, Surstock ×7, Entreprise sans client ×23, Entreprise sans employé ×12, Prix aberrant ×6, Inflation quotidienne ×2, Faim répandue ×3, Inflation sur 100 jours ×2, Inégalités hors bornes ×1, Sans-abri nombreux ×3, Chômage très élevé ×1, Richesse médiane hors bornes ×1, Prestations réduites faute de trésor ×1 |
| Fermeture de la ferme | 2 | oui | 45,8 % | 74,6 % | 22,1 % | 357 ❌ | 394 | Rupture de stock prolongée ×7, Surstock ×11, Entreprise sans client ×20, Entreprise sans employé ×9, Inflation quotidienne ×2, Faim répandue ×1, Inégalités hors bornes ×1, Sans-abri nombreux ×5, Richesse médiane hors bornes ×1, Chômage très élevé ×1, Prix aberrant ×3, Prestations réduites faute de trésor ×1 |
| Fermeture de la ferme | 3 | oui | 38,8 % | 73,8 % | 28,7 % | 249 ❌ | 263 | Rupture de stock prolongée ×9, Entreprise sans client ×16, Surstock ×7, Entreprise sans employé ×16, Faim répandue ×1, Inégalités hors bornes ×1, Sans-abri nombreux ×4, Richesse médiane hors bornes ×1, Chômage très élevé ×1, Prix aberrant ×4 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | oui | 10,4 % | 0,0 % | 0,0 % | 52 | 23 | Rupture de stock prolongée ×5, Surstock ×6, Entreprise sans client ×20, Entreprise sans employé ×8, Prix aberrant ×4, Inflation quotidienne ×2, Inflation sur 100 jours ×2 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | oui | 5,4 % | 0,0 % | 0,0 % | 19 | 19 | Rupture de stock prolongée ×8, Surstock ×18, Entreprise sans client ×28, Entreprise sans employé ×14, Inflation quotidienne ×2, Prix aberrant ×3 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | oui | 7,9 % | 0,0 % | 0,0 % | 1 | 1 | Rupture de stock prolongée ×4, Entreprise sans client ×15, Surstock ×5, Entreprise sans employé ×6, Inflation quotidienne ×2, Prix aberrant ×2 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 2 ouverture(s) critique(s) |
| Chômage moyen ≤ 10 % | ✅ | toutes les graines |
| Faim et sans-abri < 2 % | ✅ | toutes les graines |
| Gini 0,2–0,45 | ❌ | g3 0,46 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 8,93/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 9/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 9/15 échecs |

