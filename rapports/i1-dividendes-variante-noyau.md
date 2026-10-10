# Protocole de stabilité ÉcoNodes

- Date : 2026-10-10 13:29
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie), Entrée et sortie d’entreprises
- Paramètres changés : dividendFromRetained = 1

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 7,1 % | 15,0 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,37 | 0,42 | 0,045 % | 8,3 % | 49,5 % | 94 (3) | 0.0e+0 |
| 2 | 5,8 % | 11,3 % | 0,1 % | 23,3 % | 0,0 % | 0,0 % | 0,32 | 0,34 | 0,008 % | 0,8 % | 17,9 % | 64 (1) | 0.0e+0 |
| 3 | 7,3 % | 12,1 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,39 | 0,43 | 0,022 % | 1,3 % | 27,4 % | 49 (0) | 0.0e+0 |
| 4 | 5,8 % | 14,2 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,25 | 0,25 | 0,026 % | 15,3 % | 45,4 % | 72 (1) | 0.0e+0 |
| 5 | 4,8 % | 12,9 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,29 | 0,29 | 0,014 % | 0,7 % | 18,8 % | 48 (0) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Faim répandue | critique | · | 1 · 4 j | · | · | · |
| Inflation quotidienne | critique | 3 · 3 j | · | · | 1 · 1 j | · |
| Rupture de stock prolongée | attention | 17 · 14867 j | 15 · 15075 j | 10 · 8530 j | 14 · 9673 j | 7 · 5757 j |
| Surstock | attention | 17 · 1299 j | 8 · 1485 j | 9 · 5747 j | 12 · 1886 j | 11 · 7271 j |
| Entreprise sans employé | attention | 21 · 16505 j | 15 · 16590 j | 12 · 15378 j | 14 · 15064 j | 11 · 15497 j |
| Entreprise sans client | attention | 30 · 16997 j | 20 · 17499 j | 15 · 14128 j | 27 · 15120 j | 17 · 14354 j |
| Embauches bloquées faute de moyens | attention | 2 · 9 j | 3 · 24 j | 1 · 3 j | 1 · 4 j | · |
| Prix aberrant | attention | 4 · 1616 j | 2 · 618 j | 2 · 1250 j | 3 · 155 j | 2 · 1251 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 4,9 % | 10,7 % | 84,4 % | 13 | 0 $ | 0 $ | 0 $ |
| 2 | 4,8 % | 12,3 % | 82,9 % | 13 | 0 $ | 0 $ | 0 $ |
| 3 | 6,6 % | 10,6 % | 82,7 % | 11 | 0 $ | 0 $ | 0 $ |
| 4 | 5,8 % | 11,6 % | 82,7 % | 11 | 0 $ | 0 $ | 0 $ |
| 5 | 6,6 % | 12,7 % | 80,8 % | 11 | 0 $ | 0 $ | 0 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,6 % | 10,8 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,29 | 0,29 | 0,061 % | 13,0 % | 62,7 % | 165 (5) | 0.0e+0 |
| 2 | 4,3 % | 9,2 % | 0,0 % | 0,0 % | 0,0 % | 11,3 % | 0,15 | 0,11 | 0,082 % | 28,1 % | 57,3 % | 171 (6) | 0.0e+0 |
| 3 | 4,6 % | 11,7 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,31 | 0,30 | 0,056 % | 6,4 % | 49,9 % | 167 (5) | 0.0e+0 |
| 4 | 2,6 % | 13,3 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,15 | 0,13 | 0,094 % | 46,8 % | 85,3 % | 191 (6) | 0.0e+0 |
| 5 | 5,5 % | 10,8 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,24 | 0,24 | 0,037 % | 8,2 % | 21,7 % | 131 (2) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 292 · 8,71 | 488 · 15,93 | 255 · 7,57 | 458 · 15,00 | 243 · 7,21 | 10,89 ❌ | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## 2 bis. Avec filets, sauf : Renflouement d’entreprise

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 7,1 % | 15,0 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,37 | 0,42 | 0,045 % | 8,3 % | 49,5 % | 94 (3) | 0.0e+0 |
| 2 | 5,8 % | 11,3 % | 0,1 % | 23,3 % | 0,0 % | 0,0 % | 0,32 | 0,34 | 0,008 % | 0,8 % | 17,9 % | 64 (1) | 0.0e+0 |
| 3 | 7,3 % | 12,1 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,39 | 0,43 | 0,022 % | 1,3 % | 27,4 % | 49 (0) | 0.0e+0 |
| 4 | 5,8 % | 14,2 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,25 | 0,25 | 0,026 % | 15,3 % | 45,4 % | 72 (1) | 0.0e+0 |
| 5 | 4,8 % | 12,9 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,29 | 0,29 | 0,014 % | 0,7 % | 18,8 % | 48 (0) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 1 · 0,04 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,01 ✅ | pas de producteur (100 %) |
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
| Hélicoptère 5 000 $/citoyen | 1 | oui | 9,2 % | 89,2 % | 87,5 % | 47 | 302 | Entreprise sans client ×10, Rupture de stock prolongée ×10, Surstock ×4, Entreprise sans employé ×7, Embauches bloquées faute de moyens ×3, Prix aberrant ×3, Sans-abri nombreux ×3, Faim répandue ×1, Inflation quotidienne ×2 |
| Hélicoptère 5 000 $/citoyen | 2 | oui | 36,7 % | 100,0 % | 80,8 % | 270 ❌ | non | Rupture de stock prolongée ×6, Surstock ×1, Entreprise sans employé ×4, Embauches bloquées faute de moyens ×2, Prix aberrant ×1, Sans-abri nombreux ×2, Faim répandue ×2, Pénurie de main-d’œuvre ×1, Productivité du travail effondrée ×1, Chômage très élevé ×1, Inégalités hors bornes ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | oui | 6,7 % | 66,3 % | 71,7 % | 91 | non | Rupture de stock prolongée ×9, Surstock ×6, Entreprise sans client ×9, Entreprise sans employé ×3, Embauches bloquées faute de moyens ×1, Prix aberrant ×1, Sans-abri nombreux ×2, Faim répandue ×1, Pénurie de main-d’œuvre ×1, Inflation quotidienne ×3 |
| +25 immigrants | 1 | oui | 20,4 % | 52,8 % | 8,3 % | non (> 470) | non | Entreprise sans client ×2, Rupture de stock prolongée ×5, Entreprise sans employé ×2, Embauches bloquées faute de moyens ×1, Prix aberrant ×1, Inflation sur 100 jours ×1, Inégalités hors bornes ×1, Faim répandue ×1 |
| +25 immigrants | 2 | oui | 13,6 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×1, Entreprise sans employé ×3, Embauches bloquées faute de moyens ×1, Prix aberrant ×1 |
| +25 immigrants | 3 | oui | 20,0 % | 6,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×2, Entreprise sans employé ×1, Embauches bloquées faute de moyens ×1, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | oui | 23,8 % | 0,0 % | 0,0 % | non (> 470) | non | Entreprise sans client ×9, Rupture de stock prolongée ×1, Surstock ×5, Entreprise sans employé ×3, Prix aberrant ×1, Inflation quotidienne ×5 |
| Salaire minimum 220 $/j | 2 | oui | 23,8 % | 0,0 % | 0,0 % | non (> 470) | non | Surstock ×1, Entreprise sans employé ×3, Prix aberrant ×1 |
| Salaire minimum 220 $/j | 3 | oui | 24,6 % | 52,5 % | 15,0 % | non (> 470) | non | Rupture de stock prolongée ×5, Surstock ×2, Entreprise sans client ×5, Entreprise sans employé ×3, Embauches bloquées faute de moyens ×1, Prix aberrant ×1, Faim répandue ×1, Sans-abri nombreux ×1, Inflation quotidienne ×1 |
| Fermeture de la ferme | 1 | oui | 77,9 % | 100,0 % | 27,9 % | non (> 470) | non | Entreprise sans client ×7, Rupture de stock prolongée ×5, Entreprise sans employé ×6, Embauches bloquées faute de moyens ×2, Prix aberrant ×2, Faim répandue ×1, Sans-abri nombreux ×1, Productivité du travail effondrée ×1, Chômage très élevé ×1, Inflation sur 100 jours ×1, Inégalités hors bornes ×1, Inflation quotidienne ×1 |
| Fermeture de la ferme | 2 | oui | 97,5 % | 100,0 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×5, Entreprise sans employé ×8, Entreprise sans client ×6, Embauches bloquées faute de moyens ×1, Prix aberrant ×2, Faim répandue ×1, Sans-abri nombreux ×1, Productivité du travail effondrée ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 3 | oui | 38,3 % | 97,1 % | 34,2 % | 239 ❌ | non | Rupture de stock prolongée ×5, Entreprise sans client ×4, Entreprise sans employé ×5, Embauches bloquées faute de moyens ×1, Prix aberrant ×3, Faim répandue ×1, Sans-abri nombreux ×10, Productivité du travail effondrée ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | oui | 8,8 % | 0,0 % | 0,0 % | 1 | 1 | Entreprise sans client ×4, Rupture de stock prolongée ×1, Surstock ×3, Entreprise sans employé ×2, Prix aberrant ×2, Inflation quotidienne ×3 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | oui | 10,0 % | 0,0 % | 0,0 % | 1 | 53 | Rupture de stock prolongée ×1, Entreprise sans employé ×2, Embauches bloquées faute de moyens ×1, Prix aberrant ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | oui | 10,0 % | 0,0 % | 0,0 % | 1 | 1 | Rupture de stock prolongée ×2, Entreprise sans client ×1, Entreprise sans employé ×1, Prix aberrant ×1 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 7,1 % | 65,8 % | 56,7 % | 78 | non | Entreprise sans client ×39, Rupture de stock prolongée ×14, Surstock ×20, Entreprise sans employé ×14, Inflation quotidienne ×2, Prix aberrant ×3, Sans-abri nombreux ×2, Faim répandue ×1, Pénurie de main-d’œuvre ×1, Inflation sur 100 jours ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | oui | 6,3 % | 64,6 % | 53,8 % | 65 | 89 | Rupture de stock prolongée ×15, Surstock ×22, Entreprise sans client ×32, Entreprise sans employé ×13, Inflation quotidienne ×1, Sans-abri nombreux ×1, Faim répandue ×2, Pénurie de main-d’œuvre ×1, Embauches bloquées faute de moyens ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 8,3 % | 56,3 % | 73,3 % | 66 | 288 | Rupture de stock prolongée ×20, Surstock ×18, Entreprise sans client ×34, Entreprise sans employé ×17, Inflation quotidienne ×1, Prix aberrant ×2, Sans-abri nombreux ×3, Faim répandue ×1, Pénurie de main-d’œuvre ×1 |
| +25 immigrants | 1 | non | 15,8 % | 0,0 % | 6,4 % | non (> 470) | non | Entreprise sans client ×22, Rupture de stock prolongée ×14, Surstock ×10, Entreprise sans employé ×18, Inflation quotidienne ×2, Prix aberrant ×9, Inégalités hors bornes ×1 |
| +25 immigrants | 2 | oui | 12,8 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×1, Surstock ×14, Entreprise sans client ×22, Entreprise sans employé ×11, Inflation quotidienne ×1, Prix aberrant ×2 |
| +25 immigrants | 3 | non | 15,1 % | 0,0 % | 6,8 % | non (> 470) | non | Rupture de stock prolongée ×16, Surstock ×21, Entreprise sans client ×33, Entreprise sans employé ×21, Inflation quotidienne ×4, Prix aberrant ×11, Inégalités hors bornes ×2 |
| Salaire minimum 220 $/j | 1 | non | 21,7 % | 0,0 % | 0,0 % | non (> 470) | non | Entreprise sans client ×22, Rupture de stock prolongée ×9, Surstock ×7, Entreprise sans employé ×16, Inflation quotidienne ×1, Prix aberrant ×8 |
| Salaire minimum 220 $/j | 2 | oui | 20,4 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×5, Surstock ×18, Entreprise sans client ×35, Entreprise sans employé ×16, Inflation quotidienne ×2, Prix aberrant ×1 |
| Salaire minimum 220 $/j | 3 | non | 21,3 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×10, Surstock ×18, Entreprise sans client ×30, Entreprise sans employé ×19, Prix aberrant ×8 |
| Fermeture de la ferme | 1 | non | 70,4 % | 73,8 % | 40,4 % | 384 ❌ | non | Entreprise sans client ×16, Rupture de stock prolongée ×6, Surstock ×7, Entreprise sans employé ×12, Inflation quotidienne ×1, Prix aberrant ×7, Faim répandue ×2, Inégalités hors bornes ×1, Sans-abri nombreux ×9, Richesse médiane hors bornes ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 2 | oui | 47,5 % | 73,8 % | 64,6 % | 368 ❌ | non | Rupture de stock prolongée ×5, Surstock ×14, Entreprise sans client ×21, Entreprise sans employé ×12, Inflation quotidienne ×1, Faim répandue ×2, Inégalités hors bornes ×1, Sans-abri nombreux ×6, Richesse médiane hors bornes ×2, Chômage très élevé ×1, Prix aberrant ×3 |
| Fermeture de la ferme | 3 | non | 68,3 % | 77,1 % | 58,3 % | 330 ❌ | non | Rupture de stock prolongée ×6, Surstock ×14, Entreprise sans client ×22, Entreprise sans employé ×16, Inflation quotidienne ×1, Prix aberrant ×6, Faim répandue ×2, Inégalités hors bornes ×1, Sans-abri nombreux ×5, Richesse médiane hors bornes ×1, Chômage très élevé ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 8,8 % | 0,0 % | 0,0 % | 1 | 29 | Entreprise sans client ×16, Rupture de stock prolongée ×6, Surstock ×6, Entreprise sans employé ×10, Inflation quotidienne ×1, Prix aberrant ×5 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | oui | 5,0 % | 0,0 % | 0,0 % | 10 | 1 | Rupture de stock prolongée ×3, Surstock ×9, Entreprise sans client ×22, Entreprise sans employé ×7, Inflation quotidienne ×4, Prix aberrant ×3 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 7,9 % | 0,0 % | 0,0 % | 1 | 32 | Rupture de stock prolongée ×3, Surstock ×12, Entreprise sans client ×22, Entreprise sans employé ×13, Prix aberrant ×4 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 5 ouverture(s) critique(s) |
| Chômage moyen ≤ 10 % | ✅ | toutes les graines |
| Faim et sans-abri < 2 % | ✅ | toutes les graines |
| Gini 0,2–0,45 | ✅ | toutes les graines |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 10,89/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 10/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 9/15 échecs |

### Critère de l’institution (étape 2 bis)

| Critère | Résultat | Détail |
|---|---|---|
| Sans « Renflouement d’entreprise » : chômage moyen ≤ 10 % | ✅ | toutes les graines |
| Sans « Renflouement d’entreprise » : faim et sans-abri < 2 % | ✅ | toutes les graines |
| Sans « Renflouement d’entreprise » : aucune alerte critique | ❌ | 5 ouverture(s) critique(s) |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 5,0 % | 6,1 % |
| Faim moyenne | 0,0 % | 0,0 % |
| Sans-abri moyen | 0,0 % | 0,0 % |
| Gini moyen | 0,33 | 0,33 |
| Inflation moyenne / jour | 0,009 % | 0,023 % |
| Alertes critiques (total) | 5 | 5 |
| Alertes (total) | 277 | 327 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 0,00 |
| Renflouements / 50 j | 19,79 | 10,89 |
| Plancher de logement / 50 j | 0,45 | 0,00 |
| Plafond de dérive / 50 j | 0,00 | 0,00 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |
| Avec filets : chômage moyen | 3,6 % | 4,3 % |
| Avec filets : faim moyenne | 0,0 % | 0,0 % |
| Avec filets : sans-abri moyen | 0,1 % | 0,0 % |
| Avec filets : Gini moyen | 0,14 | 0,23 |
| Filets sauf --sauf : chômage moyen | 5,8 % | 6,1 % |
| Filets sauf --sauf : faim moyenne | 0,0 % | 0,0 % |
| Filets sauf --sauf : sans-abri moyen | 0,0 % | 0,0 % |
| Filets sauf --sauf : Gini moyen | 0,34 | 0,33 |
| Filets sauf --sauf : alertes critiques | 7 | 5 |
| Filets sauf --sauf : anti-famine / 50 j | 0,00 | 0,01 |
| Filets sauf --sauf : plancher de logement / 50 j | 0,01 | 0,00 |
| Filets sauf --sauf : plafond de dérive / 50 j | 0,00 | 0,00 |
| Filets sauf --sauf : anti-crédit-fou / 50 j | 0,00 | 0,00 |
| Chocs revenus à l’équilibre en < 200 j (sans filets) | 6 | 5 |
| Chocs revenus à l’équilibre en < 200 j (avec filets) | 8 | 6 |

