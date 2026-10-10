# Protocole de stabilité ÉcoNodes

- Date : 2026-10-10 12:08
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie), Entrée et sortie d’entreprises

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 6,9 % | 17,1 % | 0,0 % | 0,0 % | 0,0 % | 33,8 % | 0,41 | 0,44 | -0,000 % | 0,8 % | 18,9 % | 58 (1) | 0.0e+0 |
| 2 | 4,3 % | 15,0 % | 0,0 % | 0,0 % | 0,0 % | 34,2 % | 0,27 | 0,27 | 0,010 % | 0,8 % | 13,6 % | 43 (1) | 0.0e+0 |
| 3 | 7,3 % | 15,0 % | 0,0 % | 0,0 % | 0,0 % | 25,8 % | 0,42 | 0,45 | 0,009 % | 0,9 % | 19,3 % | 46 (1) | 0.0e+0 |
| 4 | 2,4 % | 14,2 % | 0,0 % | 0,0 % | 0,0 % | 23,8 % | 0,25 | 0,25 | 0,020 % | 0,9 % | 30,1 % | 62 (1) | 0.0e+0 |
| 5 | 4,0 % | 11,7 % | 0,0 % | 0,0 % | 0,0 % | 30,0 % | 0,30 | 0,31 | 0,007 % | 0,7 % | 14,7 % | 47 (1) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Sans-abri nombreux | critique | 1 · 13 j | 1 · 11 j | 1 · 9 j | 1 · 9 j | 1 · 7 j |
| Rupture de stock prolongée | attention | 10 · 8868 j | 11 · 10551 j | 9 · 7666 j | 18 · 9115 j | 12 · 10161 j |
| Surstock | attention | 12 · 8325 j | 5 · 3972 j | 9 · 6850 j | 12 · 5840 j | 8 · 4362 j |
| Entreprise sans employé | attention | 14 · 18514 j | 13 · 15838 j | 12 · 15856 j | 12 · 15708 j | 11 · 15748 j |
| Entreprise sans client | attention | 21 · 17380 j | 13 · 14706 j | 15 · 14739 j | 19 · 15602 j | 15 · 15718 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 4,9 % | 10,3 % | 84,8 % | 13 | 0 $ | 0 $ | 0 $ |
| 2 | 5,7 % | 10,6 % | 83,7 % | 11 | 0 $ | 0 $ | 0 $ |
| 3 | 5,8 % | 11,1 % | 83,1 % | 11 | 0 $ | 0 $ | 0 $ |
| 4 | 4,7 % | 12,0 % | 83,3 % | 11 | 0 $ | 0 $ | 0 $ |
| 5 | 5,7 % | 12,6 % | 81,7 % | 11 | 0 $ | 0 $ | 0 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,7 % | 13,3 % | 0,0 % | 0,0 % | 0,0 % | 31,7 % | 0,12 | 0,11 | 0,048 % | 6,8 % | 32,8 % | 186 (5) | 0.0e+0 |
| 2 | 2,3 % | 12,5 % | 0,0 % | 0,0 % | 0,0 % | 34,6 % | 0,13 | 0,10 | 0,079 % | 16,0 % | 28,0 % | 216 (6) | 0.0e+0 |
| 3 | 2,7 % | 12,1 % | 0,0 % | 0,0 % | 0,0 % | 37,5 % | 0,15 | 0,11 | 0,069 % | 6,4 % | 39,4 % | 237 (2) | 0.0e+0 |
| 4 | 2,8 % | 12,1 % | 0,0 % | 0,0 % | 0,0 % | 34,6 % | 0,12 | 0,12 | 0,059 % | 6,8 % | 31,1 % | 195 (3) | 0.0e+0 |
| 5 | 5,7 % | 10,0 % | 0,0 % | 0,0 % | 0,3 % | 35,4 % | 0,19 | 0,18 | 0,032 % | 3,8 % | 16,5 % | 149 (2) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 730 · 24,14 | 767 · 25,18 | 753 · 24,89 | 514 · 16,11 | 304 · 8,64 | 19,79 ❌ | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 25 · 0,00 | 25 · 0,00 | 52 · 0,00 | 33 · 0,00 | 65 · 2,25 | 0,45 ✅ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage 3–10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | oui | 8,3 % | 73,3 % | 68,8 % | 87 | 358 | Rupture de stock prolongée ×7, Sans-abri nombreux ×1, Surstock ×1, Entreprise sans client ×2, Faim répandue ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 13,3 % | 50,0 % | 67,9 % | 332 ❌ | 116 | Sans-abri nombreux ×1, Rupture de stock prolongée ×10, Surstock ×1, Entreprise sans employé ×1, Entreprise sans client ×1, Faim répandue ×3, Inflation sur 100 jours ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | oui | 17,5 % | 25,8 % | 75,8 % | 141 | 141 | Rupture de stock prolongée ×13, Sans-abri nombreux ×1, Surstock ×2, Entreprise sans employé ×3, Entreprise sans client ×5, Faim répandue ×1, Inflation sur 100 jours ×1 |
| +25 immigrants | 1 | oui | 18,1 % | 0,0 % | 4,9 % | non (> 470) | non | Inégalités hors bornes ×1 |
| +25 immigrants | 2 | non | 14,0 % | 51,7 % | 6,4 % | non (> 470) | non | Rupture de stock prolongée ×6, Surstock ×1, Entreprise sans client ×1, Faim répandue ×1 |
| +25 immigrants | 3 | oui | 18,1 % | 0,0 % | 6,4 % | non (> 470) | non | Rupture de stock prolongée ×1, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | oui | 24,2 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×2, Entreprise sans client ×2, Entreprise sans employé ×2 |
| Salaire minimum 220 $/j | 2 | non | 19,2 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×4, Entreprise sans employé ×4, Entreprise sans client ×5 |
| Salaire minimum 220 $/j | 3 | oui | 28,3 % | 53,3 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×7, Entreprise sans employé ×4, Entreprise sans client ×6, Faim répandue ×1 |
| Fermeture de la ferme | 1 | oui | 68,8 % | 98,8 % | 45,8 % | non (> 470) | non | Rupture de stock prolongée ×5, Sans-abri nombreux ×1, Entreprise sans client ×5, Entreprise sans employé ×4, Faim répandue ×1, Chômage très élevé ×1, Inflation sur 100 jours ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1 |
| Fermeture de la ferme | 2 | non | 94,2 % | 98,8 % | 100,0 % | non (> 470) | non | Sans-abri nombreux ×1, Rupture de stock prolongée ×7, Entreprise sans employé ×7, Entreprise sans client ×8, Faim répandue ×1, Chômage très élevé ×1, Inégalités hors bornes ×1 |
| Fermeture de la ferme | 3 | oui | 92,5 % | 99,2 % | 100,0 % | non (> 470) | non | Rupture de stock prolongée ×7, Sans-abri nombreux ×1, Entreprise sans employé ×7, Entreprise sans client ×8, Faim répandue ×1, Chômage très élevé ×1, Inégalités hors bornes ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | oui | 9,6 % | 0,0 % | 0,0 % | 1 | 1 | Rupture de stock prolongée ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 6,3 % | 0,0 % | 0,0 % | 43 | 1 | Rupture de stock prolongée ×1, Entreprise sans client ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | oui | 9,6 % | 0,0 % | 0,0 % | 1 | 1 | Rupture de stock prolongée ×1, Entreprise sans client ×1 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 8,8 % | 41,7 % | 62,1 % | non (> 470) | 122 | Rupture de stock prolongée ×22, Sans-abri nombreux ×1, Surstock ×19, Entreprise sans client ×46, Entreprise sans employé ×19, Inflation quotidienne ×5, Faim répandue ×1, Inflation sur 100 jours ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 15,0 % | 56,3 % | 66,3 % | non (> 470) | 157 | Sans-abri nombreux ×1, Rupture de stock prolongée ×20, Surstock ×16, Entreprise sans employé ×15, Entreprise sans client ×27, Faim répandue ×1, Inflation quotidienne ×1, Inflation sur 100 jours ×1 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 11,7 % | 74,6 % | 68,3 % | non (> 470) | 191 | Rupture de stock prolongée ×20, Sans-abri nombreux ×2, Surstock ×20, Entreprise sans employé ×13, Entreprise sans client ×31, Faim répandue ×1, Inflation quotidienne ×1 |
| +25 immigrants | 1 | non | 19,2 % | 0,0 % | 5,7 % | non (> 470) | non | Rupture de stock prolongée ×4, Surstock ×14, Entreprise sans client ×21, Entreprise sans employé ×11, Inflation quotidienne ×3, Inégalités hors bornes ×1 |
| +25 immigrants | 2 | non | 10,6 % | 0,0 % | 6,4 % | non (> 470) | non | Rupture de stock prolongée ×6, Surstock ×7, Entreprise sans employé ×7, Entreprise sans client ×18 |
| +25 immigrants | 3 | non | 15,5 % | 0,0 % | 5,7 % | non (> 470) | non | Rupture de stock prolongée ×18, Surstock ×14, Entreprise sans employé ×19, Entreprise sans client ×35, Inflation quotidienne ×1, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | non | 15,0 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×8, Surstock ×13, Entreprise sans client ×25, Entreprise sans employé ×10, Inflation quotidienne ×4 |
| Salaire minimum 220 $/j | 2 | non | 14,6 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×8, Surstock ×22, Entreprise sans employé ×11, Entreprise sans client ×36, Inflation quotidienne ×1 |
| Salaire minimum 220 $/j | 3 | non | 12,9 % | 0,0 % | 0,0 % | 376 ❌ | non | Rupture de stock prolongée ×17, Surstock ×12, Entreprise sans employé ×17, Entreprise sans client ×32, Inflation quotidienne ×1 |
| Fermeture de la ferme | 1 | non | 57,5 % | 71,7 % | 36,3 % | 380 ❌ | 420 | Rupture de stock prolongée ×9, Sans-abri nombreux ×7, Surstock ×15, Entreprise sans client ×25, Entreprise sans employé ×15, Faim répandue ×2, Inflation quotidienne ×2, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 2 | non | 45,0 % | 77,9 % | 30,4 % | non (> 470) | 392 | Sans-abri nombreux ×7, Rupture de stock prolongée ×6, Surstock ×13, Entreprise sans employé ×15, Entreprise sans client ×29, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×1 |
| Fermeture de la ferme | 3 | non | 40,0 % | 77,9 % | 30,8 % | 272 ❌ | 444 | Rupture de stock prolongée ×11, Sans-abri nombreux ×5, Surstock ×12, Entreprise sans employé ×16, Entreprise sans client ×27, Faim répandue ×1, Inégalités hors bornes ×1, Richesse médiane hors bornes ×1, Chômage très élevé ×1, Inflation quotidienne ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 7,1 % | 0,0 % | 0,0 % | 78 | 146 | Rupture de stock prolongée ×5, Surstock ×20, Entreprise sans client ×29, Entreprise sans employé ×14, Inflation quotidienne ×3 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 4,6 % | 0,0 % | 11,3 % | 280 ❌ | 1 | Sans-abri nombreux ×1, Rupture de stock prolongée ×6, Surstock ×14, Entreprise sans employé ×8, Entreprise sans client ×32, Inflation quotidienne ×2 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 2,9 % | 0,0 % | 0,0 % | non (> 470) | 1 | Rupture de stock prolongée ×17, Surstock ×11, Entreprise sans employé ×14, Entreprise sans client ×33, Inflation quotidienne ×3 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 5 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g4 2,4 % |
| Faim et sans-abri < 2 % | ✅ | toutes les graines |
| Gini 0,2–0,45 | ✅ | toutes les graines |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 19,79/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 10/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 14/15 échecs |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 3,3 % | 5,0 % |
| Faim moyenne | 0,0 % | 0,0 % |
| Sans-abri moyen | 0,1 % | 0,0 % |
| Gini moyen | 0,23 | 0,33 |
| Inflation moyenne / jour | 0,004 % | 0,009 % |
| Alertes critiques (total) | 33 | 5 |
| Alertes (total) | 2840 | 256 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 0,00 |
| Renflouements / 50 j | 21,76 | 19,79 |
| Plancher de logement / 50 j | 0,04 | 0,45 |
| Plafond de dérive / 50 j | 95,67 | 0,00 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |

