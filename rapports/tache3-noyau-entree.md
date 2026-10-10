# Protocole de stabilité ÉcoNodes

- Date : 2026-10-10 13:06
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie)

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 3,6 % | 16,7 % | 0,0 % | 0,0 % | 0,0 % | 33,8 % | 0,23 | 0,21 | 0,008 % | 6,5 % | 15,6 % | 788 (2) | 0.0e+0 |
| 2 | 2,9 % | 15,0 % | 0,0 % | 0,0 % | 0,0 % | 34,2 % | 0,15 | 0,16 | 0,025 % | 5,5 % | 20,8 % | 623 (2) | 0.0e+0 |
| 3 | 5,9 % | 14,6 % | 0,0 % | 0,0 % | 0,0 % | 25,8 % | 0,28 | 0,29 | 0,015 % | 3,4 % | 23,5 % | 652 (1) | 0.0e+0 |
| 4 | 2,6 % | 14,2 % | 0,0 % | 0,0 % | 0,0 % | 23,8 % | 0,17 | 0,16 | 0,035 % | 6,3 % | 18,9 % | 659 (2) | 0.0e+0 |
| 5 | 3,0 % | 11,3 % | 0,0 % | 0,0 % | 0,0 % | 30,0 % | 0,18 | 0,15 | 0,021 % | 4,2 % | 13,3 % | 742 (1) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Sans-abri nombreux | critique | 1 · 13 j | 1 · 11 j | 1 · 9 j | 1 · 9 j | 1 · 7 j |
| Inflation quotidienne | critique | 1 · 1 j | 1 · 1 j | · | 1 · 1 j | · |
| Rupture de stock prolongée | attention | 119 · 3371 j | 101 · 2572 j | 109 · 2631 j | 107 · 2600 j | 111 · 3247 j |
| Surstock | attention | 153 · 2158 j | 111 · 1548 j | 117 · 1508 j | 111 · 1388 j | 129 · 1839 j |
| Entreprise sans employé | attention | 264 · 3688 j | 208 · 2852 j | 219 · 3030 j | 225 · 3053 j | 247 · 3421 j |
| Entreprise sans client | attention | 250 · 5965 j | 201 · 4374 j | 206 · 3979 j | 214 · 4485 j | 254 · 5200 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 5,2 % | 11,2 % | 83,7 % | 2 | 0 $ | 0 $ | 0 $ |
| 2 | 4,7 % | 10,8 % | 84,5 % | 3 | 0 $ | 0 $ | 0 $ |
| 3 | 7,1 % | 10,2 % | 82,7 % | 4 | 0 $ | 0 $ | 0 $ |
| 4 | 4,3 % | 11,2 % | 84,5 % | 10 | 0 $ | 0 $ | 0 $ |
| 5 | 5,6 % | 12,4 % | 82,1 % | 3 | 0 $ | 0 $ | 0 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 3,7 % | 13,3 % | 0,0 % | 0,0 % | 0,0 % | 31,7 % | 0,11 | 0,10 | 0,028 % | 6,8 % | 27,5 % | 180 (2) | 0.0e+0 |
| 2 | 2,2 % | 12,5 % | 0,0 % | 0,0 % | 0,0 % | 34,6 % | 0,11 | 0,10 | 0,047 % | 15,3 % | 47,5 % | 118 (3) | 0.0e+0 |
| 3 | 1,6 % | 12,1 % | 0,0 % | 0,0 % | 0,0 % | 37,5 % | 0,13 | 0,13 | 0,040 % | 8,8 % | 39,3 % | 101 (3) | 0.0e+0 |
| 4 | 3,4 % | 12,1 % | 0,0 % | 0,0 % | 0,0 % | 34,6 % | 0,13 | 0,13 | 0,037 % | 4,7 % | 30,2 % | 122 (2) | 0.0e+0 |
| 5 | 2,9 % | 10,0 % | 0,0 % | 0,0 % | 0,0 % | 13,8 % | 0,16 | 0,14 | 0,027 % | 1,2 % | 19,3 % | 83 (1) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 854 · 28,32 | 944 · 31,82 | 674 · 22,07 | 613 · 19,64 | 547 · 17,46 | 23,86 ❌ | par le propriétaire (98 %) ; après rachat (2 %) |
| Plancher de logement | 25 · 0,00 | 25 · 0,00 | 52 · 0,00 | 33 · 0,00 | 2 · 0,00 | 0,00 ✅ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## 3. Chocs standard (choc au jour 300, observé 500 jours)

Retour à l’équilibre : 30 jours de suite avec chômage 3–10 %, faim et sans-abri < 2 %, inflation moyenne < 0,5 %/j et aucune alerte critique. Retour au niveau d’avant : chômage à ±2σ (au moins ±2 points) de sa moyenne d’avant le choc, faim et sans-abri à +2 points au plus.

« s. o. » : l’économie était déjà effondrée avant le choc (chômage moyen > 50 %), l’évaluation n’a pas de sens.

### Sans filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 22,1 % | 92,1 % | 74,6 % | non (> 470) | 166 | Rupture de stock prolongée ×31, Sans-abri nombreux ×1, Surstock ×21, Entreprise sans client ×45, Entreprise sans employé ×44, Faim répandue ×2, Inflation quotidienne ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 16,3 % | 82,1 % | 83,8 % | 238 ❌ | 134 | Sans-abri nombreux ×2, Rupture de stock prolongée ×26, Surstock ×7, Entreprise sans employé ×30, Entreprise sans client ×27, Faim répandue ×2 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 9,6 % | 47,1 % | 89,2 % | 233 ❌ | 116 | Rupture de stock prolongée ×28, Sans-abri nombreux ×1, Surstock ×16, Entreprise sans employé ×33, Entreprise sans client ×34, Faim répandue ×2 |
| +25 immigrants | 1 | non | 17,7 % | 0,0 % | 4,9 % | non (> 470) | non | Rupture de stock prolongée ×46, Surstock ×53, Entreprise sans client ×90, Entreprise sans employé ×88, Inflation quotidienne ×1, Inégalités hors bornes ×1 |
| +25 immigrants | 2 | non | 12,5 % | 4,5 % | 4,9 % | non (> 470) | non | Rupture de stock prolongée ×30, Surstock ×44, Entreprise sans employé ×74, Entreprise sans client ×69, Inflation quotidienne ×1 |
| +25 immigrants | 3 | non | 15,8 % | 0,0 % | 6,4 % | non (> 470) | non | Rupture de stock prolongée ×25, Surstock ×58, Entreprise sans employé ×82, Entreprise sans client ×74, Inégalités hors bornes ×1 |
| Salaire minimum 220 $/j | 1 | non | 15,4 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×47, Surstock ×48, Entreprise sans client ×83, Entreprise sans employé ×86 |
| Salaire minimum 220 $/j | 2 | non | 14,6 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×30, Surstock ×29, Entreprise sans employé ×63, Entreprise sans client ×50 |
| Salaire minimum 220 $/j | 3 | non | 16,7 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×35, Surstock ×39, Entreprise sans employé ×74, Entreprise sans client ×73 |
| Fermeture de la ferme | 1 | non | 11,7 % | 72,1 % | 22,5 % | 66 | non | Rupture de stock prolongée ×59, Surstock ×38, Entreprise sans client ×73, Entreprise sans employé ×79, Faim répandue ×1, Inflation quotidienne ×1 |
| Fermeture de la ferme | 2 | non | 7,1 % | 0,0 % | 0,0 % | 99 | 201 | Rupture de stock prolongée ×40, Surstock ×35, Entreprise sans employé ×73, Entreprise sans client ×68 |
| Fermeture de la ferme | 3 | non | 10,4 % | 59,6 % | 12,1 % | 48 | non | Rupture de stock prolongée ×55, Sans-abri nombreux ×1, Surstock ×42, Entreprise sans employé ×92, Entreprise sans client ×88, Faim répandue ×1 |
| Faillite d’une firme clé (Raffinerie Côté) | 1 | non | 6,7 % | 0,0 % | 0,0 % | 10 | 1 | Rupture de stock prolongée ×38, Surstock ×53, Entreprise sans client ×83, Entreprise sans employé ×87, Inflation quotidienne ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 6,3 % | 0,0 % | 0,0 % | 42 | 265 | Rupture de stock prolongée ×43, Surstock ×48, Entreprise sans employé ×90, Entreprise sans client ×90 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 8,3 % | 0,0 % | 0,0 % | 16 | 175 | Rupture de stock prolongée ×42, Surstock ×35, Entreprise sans employé ×76, Entreprise sans client ×73 |

### Avec filets

| Choc | Graine | Équilibre avant ? | Pic chômage | Pic faim | Pic sans-abri | Retour équilibre (j) | Retour niveau d’avant (j) | Alertes déclenchées |
|---|---|---|---|---|---|---|---|---|
| Hélicoptère 5 000 $/citoyen | 1 | non | 6,3 % | 49,2 % | 43,3 % | 284 ❌ | 453 | Rupture de stock prolongée ×16, Sans-abri nombreux ×2, Surstock ×12, Entreprise sans client ×19, Entreprise sans employé ×13, Faim répandue ×1 |
| Hélicoptère 5 000 $/citoyen | 2 | non | 9,6 % | 75,0 % | 65,0 % | 311 ❌ | 113 | Sans-abri nombreux ×1, Rupture de stock prolongée ×21, Surstock ×4, Entreprise sans employé ×18, Entreprise sans client ×19, Inflation quotidienne ×2, Faim répandue ×1, Inflation sur 100 jours ×2 |
| Hélicoptère 5 000 $/citoyen | 3 | non | 5,4 % | 52,9 % | 59,6 % | 262 ❌ | 106 | Rupture de stock prolongée ×16, Sans-abri nombreux ×1, Surstock ×2, Entreprise sans employé ×6, Entreprise sans client ×7, Faim répandue ×1 |
| +25 immigrants | 1 | non | 12,8 % | 0,0 % | 4,9 % | non (> 470) | non | Rupture de stock prolongée ×15, Surstock ×34, Entreprise sans client ×44, Entreprise sans employé ×32, Inflation quotidienne ×1 |
| +25 immigrants | 2 | non | 12,8 % | 0,0 % | 6,4 % | non (> 470) | non | Rupture de stock prolongée ×14, Surstock ×23, Entreprise sans employé ×23, Entreprise sans client ×36, Inflation quotidienne ×4 |
| +25 immigrants | 3 | non | 11,3 % | 0,0 % | 4,9 % | non (> 470) | non | Rupture de stock prolongée ×3, Surstock ×3, Entreprise sans employé ×6, Entreprise sans client ×3, Inflation quotidienne ×1 |
| Salaire minimum 220 $/j | 1 | non | 12,1 % | 0,0 % | 0,0 % | 12 | non | Surstock ×8, Entreprise sans client ×9, Entreprise sans employé ×6 |
| Salaire minimum 220 $/j | 2 | non | 14,2 % | 0,0 % | 0,0 % | non (> 470) | non | Rupture de stock prolongée ×11, Surstock ×11, Entreprise sans employé ×21, Entreprise sans client ×19, Inflation quotidienne ×3 |
| Salaire minimum 220 $/j | 3 | non | 12,1 % | 0,0 % | 0,0 % | 8 | non | Surstock ×3, Entreprise sans employé ×6, Entreprise sans client ×4, Inflation quotidienne ×1 |
| Fermeture de la ferme | 1 | non | 12,5 % | 71,3 % | 17,9 % | 192 | non | Rupture de stock prolongée ×21, Sans-abri nombreux ×1, Surstock ×32, Entreprise sans client ×44, Entreprise sans employé ×31, Faim répandue ×1, Inflation quotidienne ×2 |
| Fermeture de la ferme | 2 | non | 9,2 % | 68,3 % | 16,3 % | 47 | non | Sans-abri nombreux ×2, Rupture de stock prolongée ×20, Surstock ×17, Entreprise sans employé ×19, Entreprise sans client ×23, Faim répandue ×1, Inflation quotidienne ×2 |
| Fermeture de la ferme | 3 | non | 10,4 % | 70,4 % | 10,4 % | 41 | non | Rupture de stock prolongée ×14, Surstock ×5, Entreprise sans employé ×14, Entreprise sans client ×12, Faim répandue ×1 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 1 | non | 7,1 % | 0,0 % | 0,0 % | 58 | 1 | Rupture de stock prolongée ×8, Surstock ×7, Entreprise sans client ×15, Entreprise sans employé ×14 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 2 | non | 4,2 % | 0,0 % | 0,0 % | 331 ❌ | 25 | Rupture de stock prolongée ×7, Surstock ×4, Entreprise sans employé ×10, Entreprise sans client ×11, Inflation quotidienne ×2 |
| Faillite d’une firme clé (Raffinerie Saint-Laurent) | 3 | non | 4,6 % | 0,0 % | 0,0 % | non (> 470) | 26 | Rupture de stock prolongée ×10, Surstock ×6, Entreprise sans employé ×10, Entreprise sans client ×15, Inflation quotidienne ×1 |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 8 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g2 2,9 %, g4 2,6 % |
| Faim et sans-abri < 2 % | ✅ | toutes les graines |
| Gini 0,2–0,45 | ❌ | g2 0,15, g4 0,17, g5 0,18 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 23,86/50 j |
| Chaque choc revient à l’équilibre en < 200 j (sans filets) | ❌ | 9/15 échecs |
| Chaque choc revient à l’équilibre en < 200 j (avec filets) | ❌ | 9/15 échecs |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 3,3 % | 3,6 % |
| Faim moyenne | 0,0 % | 0,0 % |
| Sans-abri moyen | 0,1 % | 0,0 % |
| Gini moyen | 0,23 | 0,20 |
| Inflation moyenne / jour | 0,004 % | 0,021 % |
| Alertes critiques (total) | 33 | 8 |
| Alertes (total) | 2840 | 3464 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 0,00 |
| Renflouements / 50 j | 21,76 | 23,86 |
| Plancher de logement / 50 j | 0,04 | 0,00 |
| Plafond de dérive / 50 j | 95,67 | 0,00 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |

