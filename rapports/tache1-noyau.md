# Protocole de stabilité ÉcoNodes

- Date : 2026-10-04 18:40
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie)

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 12,7 % | 34,2 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,82 | 0,93 | -0,007 % | 2,6 % | 162,9 % | 67 (1) | 0.0e+0 |
| 2 | 22,8 % | 37,9 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,86 | 0,95 | 0,009 % | 3,0 % | 331,6 % | 81 (3) | 0.0e+0 |
| 3 | 46,5 % | 76,3 % | 0,0 % | 1,7 % | 94,1 % | 100,0 % | 0,71 | 0,70 | 0,058 % | 3,1 % | 241,3 % | 107 (4) | 0.0e+0 |
| 4 | 20,0 % | 35,8 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,84 | 0,95 | -0,013 % | 2,6 % | 254,2 % | 72 (1) | 0.0e+0 |
| 5 | 21,7 % | 33,8 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,85 | 0,95 | -0,013 % | 2,6 % | 157,0 % | 63 (2) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Chômage très élevé | critique | · | 1 · 136 j | 1 · 1124 j | · | · |
| Sans-abri nombreux | critique | · | · | 1 · 1315 j | · | · |
| Inégalités hors bornes | attention | 1 · 1397 j | 1 · 1396 j | 2 · 1326 j | 1 · 1390 j | 1 · 1396 j |
| Inflation sur 100 jours | critique | 1 · 76 j | 2 · 97 j | 2 · 154 j | 1 · 98 j | 2 · 134 j |
| Rupture de stock prolongée | attention | 9 · 3975 j | 12 · 4213 j | 17 · 10543 j | 12 · 5446 j | 7 · 4935 j |
| Surstock | attention | 18 · 6414 j | 20 · 7340 j | 20 · 7415 j | 19 · 6415 j | 13 · 6553 j |
| Entreprise sans employé | attention | 13 · 12781 j | 17 · 14626 j | 24 · 25578 j | 15 · 14564 j | 12 · 12877 j |
| Entreprise sans client | attention | 25 · 12661 j | 28 · 14163 j | 40 · 25613 j | 24 · 14225 j | 28 · 12644 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 11,2 % | 15,4 % | 73,4 % | 9 | 0 $ | 0 $ | 0 $ |
| 2 | 11,1 % | 18,9 % | 70,0 % | 10 | 0 $ | 0 $ | 0 $ |
| 3 | 14,9 % | 33,1 % | 51,9 % | 19 | 0 $ | 0 $ | 0 $ |
| 4 | 11,4 % | 16,6 % | 72,0 % | 10 | 0 $ | 0 $ | 0 $ |
| 5 | 12,2 % | 16,4 % | 71,4 % | 9 | 0 $ | 0 $ | 0 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 11,2 % | 25,4 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,80 | 0,91 | -0,060 % | 3,1 % | 99,2 % | 149 (0) | 0.0e+0 |
| 2 | 10,3 % | 23,3 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,78 | 0,88 | -0,053 % | 2,6 % | 49,7 % | 141 (0) | 0.0e+0 |
| 3 | 9,9 % | 24,2 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,73 | 0,82 | -0,023 % | 1,7 % | 39,7 % | 124 (0) | 0.0e+0 |
| 4 | 9,5 % | 26,3 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,71 | 0,78 | -0,029 % | 2,2 % | 65,9 % | 128 (0) | 0.0e+0 |
| 5 | 17,4 % | 26,7 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,84 | 0,94 | -0,085 % | 2,4 % | 41,9 % | 102 (0) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 238 · 6,50 | 253 · 6,89 | 260 · 6,96 | 229 · 6,57 | 201 · 5,18 | 6,42 ❌ | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Plafond de dérive des prix et salaires | 3330 · 84,64 | 2731 · 64,86 | 2662 · 62,29 | 2514 · 51,71 | 2448 · 51,04 | 62,91 ❌ | hausse de prix (66 %) ; baisse de prix (34 %) |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 11 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g1 12,7 %, g2 22,8 %, g3 46,5 %, g4 20,0 %, g5 21,7 % |
| Faim et sans-abri < 2 % | ❌ | g3 |
| Gini 0,2–0,45 | ❌ | g1 0,82, g2 0,86, g3 0,71, g4 0,84, g5 0,85 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 6,42/50 j, Plafond de dérive des prix et salaires 62,91/50 j |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 4,1 % | 24,7 % |
| Faim moyenne | 0,0 % | 0,0 % |
| Sans-abri moyen | 100,0 % | 18,8 % |
| Gini moyen | 0,25 | 0,82 |
| Inflation moyenne / jour | 0,010 % | 0,007 % |
| Alertes critiques (total) | 9 | 11 |
| Alertes (total) | 467 | 390 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 0,00 |
| Renflouements / 50 j | 63,76 | 6,42 |
| Plancher de logement / 50 j | 0,00 | 0,00 |
| Plafond de dérive / 50 j | 113,39 | 62,91 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |

