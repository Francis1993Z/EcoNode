# Protocole de stabilité ÉcoNodes

- Date : 2026-10-05 21:44
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie)

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 5,3 % | 18,3 % | 0,1 % | 20,8 % | 0,0 % | 0,0 % | 0,46 | 0,51 | 0,007 % | 4,2 % | 31,9 % | 53 (1) | 0.0e+0 |
| 2 | 5,2 % | 16,3 % | 0,0 % | 0,0 % | 0,2 % | 25,8 % | 0,27 | 0,27 | 0,024 % | 2,6 % | 37,3 % | 67 (1) | 0.0e+0 |
| 3 | 4,5 % | 20,4 % | 0,0 % | 20,4 % | 0,0 % | 11,7 % | 0,42 | 0,45 | 0,050 % | 7,1 % | 54,3 % | 77 (4) | 0.0e+0 |
| 4 | 3,2 % | 17,5 % | 0,0 % | 0,0 % | 0,2 % | 23,8 % | 0,27 | 0,25 | 0,016 % | 2,7 % | 41,1 % | 63 (3) | 0.0e+0 |
| 5 | 3,9 % | 17,5 % | 0,0 % | 13,3 % | 0,1 % | 11,7 % | 0,31 | 0,31 | 0,011 % | 4,1 % | 34,5 % | 56 (2) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Faim répandue | critique | 1 · 3 j | · | 1 · 2 j | · | · |
| Sans-abri nombreux | critique | · | 1 · 15 j | 2 · 4 j | 3 · 16 j | 2 · 8 j |
| Inflation quotidienne | critique | · | · | 1 · 2 j | · | · |
| Rupture de stock prolongée | attention | 17 · 10955 j | 19 · 11767 j | 22 · 8646 j | 21 · 8651 j | 17 · 7400 j |
| Surstock | attention | 8 · 4338 j | 11 · 2330 j | 12 · 5473 j | 10 · 4336 j | 9 · 7191 j |
| Entreprise sans employé | attention | 14 · 17671 j | 11 · 15242 j | 15 · 15661 j | 12 · 15472 j | 12 · 15840 j |
| Entreprise sans client | attention | 13 · 17677 j | 25 · 14129 j | 24 · 14608 j | 17 · 15392 j | 16 · 14418 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 4,7 % | 10,7 % | 84,6 % | 13 | 0 $ | 0 $ | 0 $ |
| 2 | 7,1 % | 10,6 % | 82,3 % | 11 | 0 $ | 0 $ | 0 $ |
| 3 | 5,6 % | 10,7 % | 83,8 % | 11 | 0 $ | 0 $ | 0 $ |
| 4 | 6,0 % | 10,3 % | 83,7 % | 11 | 0 $ | 0 $ | 0 $ |
| 5 | 6,5 % | 12,5 % | 81,0 % | 11 | 0 $ | 0 $ | 0 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 2,4 % | 15,8 % | 0,0 % | 0,0 % | 0,1 % | 11,3 % | 0,12 | 0,12 | 0,069 % | 1,6 % | 65,0 % | 121 (2) | 0.0e+0 |
| 2 | 4,0 % | 14,6 % | 0,0 % | 0,0 % | 0,1 % | 11,3 % | 0,14 | 0,12 | 0,065 % | 1,5 % | 67,6 % | 130 (2) | 0.0e+0 |
| 3 | 3,3 % | 14,6 % | 0,0 % | 0,0 % | 0,1 % | 12,9 % | 0,15 | 0,21 | 0,103 % | 1,9 % | 91,4 % | 196 (2) | 0.0e+0 |
| 4 | 2,8 % | 16,3 % | 0,0 % | 0,0 % | 0,3 % | 24,2 % | 0,12 | 0,09 | 0,051 % | 1,6 % | 38,3 % | 182 (3) | 0.0e+0 |
| 5 | 4,1 % | 11,3 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,19 | 0,20 | 0,065 % | 1,0 % | 42,6 % | 131 (0) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 716 · 23,32 | 290 · 8,57 | 602 · 19,50 | 455 · 14,18 | 332 · 9,68 | 15,05 ❌ | par le propriétaire (96 %) ; après rachat (4 %) |
| Plancher de logement | 1 · 0,00 | 2 · 0,04 | 3 · 0,07 | 35 · 1,21 | 0 · 0,00 | 0,26 ✅ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 3244 · 86,82 | 2302 · 53,64 | 3042 · 83,82 | 3082 · 82,61 | 2344 · 52,36 | 71,85 ❌ | hausse de prix (69 %) ; baisse de prix (30 %) |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 11 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ✅ | toutes les graines |
| Faim et sans-abri < 2 % | ✅ | toutes les graines |
| Gini 0,2–0,45 | ❌ | g1 0,46 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 15,05/50 j, Plafond de dérive des prix et salaires 71,85/50 j |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 4,1 % | 4,4 % |
| Faim moyenne | 0,0 % | 0,0 % |
| Sans-abri moyen | 100,0 % | 0,1 % |
| Gini moyen | 0,25 | 0,35 |
| Inflation moyenne / jour | 0,010 % | 0,022 % |
| Alertes critiques (total) | 9 | 11 |
| Alertes (total) | 467 | 316 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 0,00 |
| Renflouements / 50 j | 63,76 | 15,05 |
| Plancher de logement / 50 j | 0,00 | 0,26 |
| Plafond de dérive / 50 j | 113,39 | 71,85 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |

