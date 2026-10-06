# Protocole de stabilité ÉcoNodes

- Date : 2026-10-04 19:29
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie)

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 9,5 % | 36,7 % | 5,2 % | 96,3 % | 96,6 % | 100,0 % | 0,46 | 0,87 | 0,018 % | 2,2 % | 37,7 % | 97 (9) | 0.0e+0 |
| 2 | 13,8 % | 57,9 % | 5,2 % | 92,5 % | 63,2 % | 100,0 % | 0,43 | 0,69 | 0,050 % | 2,8 % | 42,4 % | 98 (10) | 0.0e+0 |
| 3 | 2,2 % | 17,1 % | 0,0 % | 0,0 % | 96,3 % | 100,0 % | 0,15 | 0,14 | 0,029 % | 3,5 % | 44,4 % | 79 (1) | 0.0e+0 |
| 4 | 5,4 % | 16,7 % | 0,0 % | 0,0 % | 90,9 % | 100,0 % | 0,22 | 0,21 | 0,027 % | 2,5 % | 47,8 % | 68 (2) | 0.0e+0 |
| 5 | 7,7 % | 17,1 % | 0,3 % | 60,8 % | 97,3 % | 100,0 % | 0,39 | 0,59 | 0,008 % | 1,8 % | 52,2 % | 77 (2) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 1 · 52 j | 2 · 150 j | · | · | · |
| Faim répandue | critique | 7 · 122 j | 6 · 107 j | · | · | 1 · 9 j |
| Sans-abri nombreux | critique | 1 · 1351 j | 2 · 885 j | 1 · 1346 j | 2 · 1273 j | 1 · 1360 j |
| Inégalités hors bornes | attention | 3 · 297 j | 3 · 226 j | · | · | 1 · 42 j |
| Richesse médiane hors bornes | attention | 1 · 16 j | · | · | · | · |
| Rupture de stock prolongée | attention | 31 · 14089 j | 30 · 14903 j | 16 · 11998 j | 17 · 14731 j | 20 · 11211 j |
| Surstock | attention | 11 · 9987 j | 12 · 4410 j | 15 · 10751 j | 8 · 8197 j | 12 · 9858 j |
| Entreprise sans employé | attention | 20 · 27543 j | 20 · 23396 j | 21 · 26588 j | 21 · 26495 j | 19 · 24747 j |
| Entreprise sans client | attention | 22 · 27763 j | 23 · 23457 j | 26 · 26730 j | 20 · 26664 j | 23 · 24964 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 8,3 % | 20,2 % | 71,4 % | 20 | 0 $ | 0 $ | 0 $ |
| 2 | 0,7 % | 29,5 % | 69,9 % | 20 | 0 $ | 0 $ | 0 $ |
| 3 | 5,1 % | 11,1 % | 83,8 % | 20 | 0 $ | 0 $ | 0 $ |
| 4 | 5,3 % | 11,5 % | 83,3 % | 20 | 0 $ | 0 $ | 0 $ |
| 5 | 1,8 % | 20,2 % | 78,0 % | 18 | 0 $ | 0 $ | 0 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 1,5 % | 17,9 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,15 | 0,11 | 0,050 % | 1,5 % | 32,7 % | 108 (0) | 0.0e+0 |
| 2 | 2,2 % | 16,3 % | 0,0 % | 0,0 % | 0,0 % | 11,3 % | 0,14 | 0,10 | 0,057 % | 1,7 % | 46,8 % | 107 (1) | 0.0e+0 |
| 3 | 2,8 % | 13,8 % | 0,0 % | 0,0 % | 0,2 % | 23,3 % | 0,11 | 0,10 | 0,055 % | 1,0 % | 40,2 % | 117 (1) | 0.0e+0 |
| 4 | 2,6 % | 18,3 % | 0,0 % | 0,0 % | 0,0 % | 17,5 % | 0,12 | 0,10 | 0,042 % | 1,3 % | 40,2 % | 94 (1) | 0.0e+0 |
| 5 | 2,8 % | 12,9 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,33 | 0,29 | 0,037 % | 1,7 % | 23,6 % | 96 (0) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 393 · 13,00 | 393 · 12,75 | 515 · 16,96 | 549 · 17,75 | 357 · 11,39 | 14,37 ❌ | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 0 · 0,00 | 0 · 0,00 | 12 · 0,43 | 0 · 0,00 | 0 · 0,00 | 0,09 ✅ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 2018 · 47,86 | 2726 · 72,68 | 2998 · 80,93 | 3240 · 85,39 | 2407 · 60,54 | 69,48 ❌ | hausse de prix (65 %) ; baisse de prix (34 %) |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 24 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g2 13,8 %, g3 2,2 % |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ❌ | g1 0,46, g3 0,15 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 14,37/50 j, Plafond de dérive des prix et salaires 69,48/50 j |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 24,7 % | 7,7 % |
| Faim moyenne | 0,0 % | 2,2 % |
| Sans-abri moyen | 18,8 % | 88,9 % |
| Gini moyen | 0,82 | 0,33 |
| Inflation moyenne / jour | 0,007 % | 0,027 % |
| Alertes critiques (total) | 11 | 24 |
| Alertes (total) | 390 | 419 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 0,00 |
| Renflouements / 50 j | 6,42 | 14,37 |
| Plancher de logement / 50 j | 0,00 | 0,09 |
| Plafond de dérive / 50 j | 62,91 | 69,48 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |

