# Protocole de stabilité ÉcoNodes

- Date : 2026-10-04 18:36
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie)

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 78,4 % | 98,8 % | 71,4 % | 100,0 % | 90,3 % | 100,0 % | 0,90 | 0,75 | -0,040 % | 48,6 % | 386,2 % | 182 (15) | 0.0e+0 |
| 2 | 71,4 % | 90,4 % | 74,8 % | 100,0 % | 98,5 % | 100,0 % | 0,78 | 0,59 | -0,016 % | 63,4 % | 294,7 % | 181 (17) | 0.0e+0 |
| 3 | 77,1 % | 92,9 % | 89,5 % | 100,0 % | 99,5 % | 100,0 % | 0,68 | 0,57 | -0,019 % | 46,2 % | 368,9 % | 147 (9) | 0.0e+0 |
| 4 | 78,5 % | 90,8 % | 45,3 % | 80,4 % | 95,5 % | 100,0 % | 0,95 | 0,96 | -0,054 % | 34,7 % | 427,6 % | 230 (25) | 0.0e+0 |
| 5 | 77,4 % | 91,3 % | 88,3 % | 100,0 % | 99,4 % | 100,0 % | 0,75 | 0,58 | -0,018 % | 37,7 % | 318,8 % | 156 (13) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | 2 · 1383 j | 3 · 1312 j | 1 · 1427 j | 1 · 1410 j | 1 · 1419 j |
| Faim répandue | critique | 5 · 1253 j | 2 · 1229 j | 2 · 1302 j | 16 · 1249 j | 1 · 1343 j |
| Sans-abri nombreux | critique | 3 · 1265 j | 2 · 1381 j | 1 · 1409 j | 2 · 1343 j | 2 · 1391 j |
| Inégalités hors bornes | attention | 1 · 1414 j | 2 · 1204 j | 1 · 833 j | 1 · 1399 j | 1 · 1090 j |
| Richesse médiane hors bornes | attention | 1 · 853 j | 1 · 588 j | 2 · 189 j | 1 · 1324 j | 1 · 489 j |
| Inflation quotidienne | critique | 4 · 13 j | 9 · 22 j | 3 · 13 j | 5 · 14 j | 7 · 24 j |
| Inflation sur 100 jours | critique | 1 · 11 j | 1 · 11 j | 2 · 64 j | 1 · 12 j | 2 · 66 j |
| Rupture de stock prolongée | attention | 28 · 10740 j | 28 · 10638 j | 13 · 12174 j | 36 · 7579 j | 16 · 11866 j |
| Surstock | attention | 34 · 14062 j | 35 · 14465 j | 26 · 14261 j | 48 · 15435 j | 27 · 14726 j |
| Entreprise sans employé | attention | 38 · 38384 j | 38 · 38814 j | 38 · 40975 j | 42 · 36741 j | 36 · 41286 j |
| Entreprise sans client | attention | 65 · 38349 j | 60 · 38763 j | 58 · 40910 j | 77 · 36622 j | 62 · 41254 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 35,1 % | 64,9 % | 0,0 % | 30 | 0 $ | 0 $ | 0 $ |
| 2 | 34,6 % | 65,4 % | 0,0 % | 30 | 0 $ | 0 $ | 0 $ |
| 3 | 35,6 % | 64,4 % | 0,0 % | 30 | 0 $ | 0 $ | 0 $ |
| 4 | 33,3 % | 66,7 % | 0,0 % | 28 | 0 $ | 0 $ | 0 $ |
| 5 | 34,0 % | 66,0 % | 0,0 % | 30 | 0 $ | 0 $ | 0 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 8,5 % | 32,9 % | 0,0 % | 0,0 % | 0,6 % | 100,0 % | 0,65 | 0,81 | -0,056 % | 1,8 % | 54,4 % | 207 (3) | 0.0e+0 |
| 2 | 9,7 % | 24,6 % | 0,0 % | 0,0 % | 0,0 % | 32,9 % | 0,76 | 0,88 | -0,076 % | 1,6 % | 25,7 % | 182 (1) | 0.0e+0 |
| 3 | 8,7 % | 32,5 % | 0,0 % | 0,0 % | 0,0 % | 20,8 % | 0,67 | 0,84 | -0,064 % | 1,5 % | 31,7 % | 185 (1) | 0.0e+0 |
| 4 | 8,3 % | 32,9 % | 0,0 % | 0,0 % | 0,1 % | 94,6 % | 0,68 | 0,81 | -0,058 % | 1,8 % | 35,5 % | 174 (1) | 0.0e+0 |
| 5 | 19,8 % | 37,5 % | 0,0 % | 0,0 % | 2,3 % | 100,0 % | 0,82 | 0,94 | -0,108 % | 1,8 % | 68,0 % | 187 (8) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 702 · 23,32 | 631 · 20,68 | 681 · 22,71 | 676 · 22,50 | 584 · 18,89 | 21,62 ❌ | par le propriétaire (98 %) ; après rachat (2 %) |
| Plancher de logement | 653 · 23,32 | 6 · 0,00 | 4 · 0,00 | 18 · 0,00 | 2135 · 76,25 | 19,91 ❌ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 9637 · 266,04 | 10362 · 294,50 | 9039 · 244,39 | 9110 · 249,07 | 12036 · 354,04 | 281,61 ❌ | hausse de prix (61 %) ; baisse de prix (39 %) |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 79 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g1 78,4 %, g2 71,4 %, g3 77,1 %, g4 78,5 %, g5 77,4 % |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ❌ | g1 0,90, g2 0,78, g3 0,68, g4 0,95, g5 0,75 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 21,62/50 j, Plancher de logement 19,91/50 j, Plafond de dérive des prix et salaires 281,61/50 j |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 4,1 % | 76,6 % |
| Faim moyenne | 0,0 % | 73,8 % |
| Sans-abri moyen | 100,0 % | 96,7 % |
| Gini moyen | 0,25 | 0,81 |
| Inflation moyenne / jour | 0,010 % | -0,029 % |
| Alertes critiques (total) | 9 | 79 |
| Alertes (total) | 467 | 896 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 0,00 |
| Renflouements / 50 j | 63,76 | 21,62 |
| Plancher de logement / 50 j | 0,00 | 19,91 |
| Plafond de dérive / 50 j | 113,39 | 281,61 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |

