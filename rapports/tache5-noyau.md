# Protocole de stabilité ÉcoNodes

- Date : 2026-10-05 22:23
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie)

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 3,0 % | 17,5 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,31 | 0,30 | -0,004 % | 21,1 % | 35,3 % | 614 (9) | 0.0e+0 |
| 2 | 2,6 % | 15,4 % | 0,0 % | 0,0 % | 0,2 % | 23,8 % | 0,16 | 0,12 | 0,007 % | 21,6 % | 42,1 % | 483 (8) | 0.0e+0 |
| 3 | 4,3 % | 20,4 % | 0,0 % | 0,0 % | 0,0 % | 11,7 % | 0,32 | 0,34 | -0,006 % | 23,0 % | 27,0 % | 599 (3) | 0.0e+0 |
| 4 | 3,2 % | 17,5 % | 0,0 % | 0,0 % | 0,2 % | 25,0 % | 0,16 | 0,13 | 0,012 % | 27,9 % | 39,9 % | 505 (7) | 0.0e+0 |
| 5 | 3,3 % | 15,8 % | 0,0 % | 0,0 % | 0,1 % | 11,7 % | 0,18 | 0,15 | 0,010 % | 8,9 % | 54,4 % | 639 (6) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Sans-abri nombreux | critique | · | 1 · 11 j | 1 · 2 j | 2 · 18 j | 2 · 10 j |
| Inflation quotidienne | critique | 9 · 9 j | 7 · 7 j | 2 · 2 j | 5 · 5 j | 4 · 4 j |
| Rupture de stock prolongée | attention | 109 · 2970 j | 86 · 2266 j | 106 · 3232 j | 87 · 2198 j | 102 · 2543 j |
| Surstock | attention | 102 · 1404 j | 91 · 1068 j | 96 · 1204 j | 102 · 1264 j | 119 · 1594 j |
| Entreprise sans employé | attention | 202 · 2800 j | 146 · 2040 j | 200 · 2750 j | 153 · 2126 j | 208 · 2863 j |
| Entreprise sans client | attention | 192 · 4695 j | 152 · 2962 j | 194 · 4786 j | 156 · 3086 j | 204 · 4304 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 5,7 % | 11,3 % | 83,0 % | 6 | 0 $ | 0 $ | 0 $ |
| 2 | 5,6 % | 10,8 % | 83,5 % | 2 | 0 $ | 0 $ | 0 $ |
| 3 | 5,7 % | 10,5 % | 83,8 % | 8 | 0 $ | 0 $ | 0 $ |
| 4 | 5,6 % | 10,7 % | 83,7 % | 4 | 0 $ | 0 $ | 0 $ |
| 5 | 7,3 % | 11,2 % | 81,5 % | 8 | 0 $ | 0 $ | 0 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 1,6 % | 15,8 % | 0,0 % | 0,0 % | 0,1 % | 10,8 % | 0,14 | 0,12 | 0,038 % | 30,0 % | 74,5 % | 133 (18) | 0.0e+0 |
| 2 | 2,9 % | 14,6 % | 0,0 % | 0,0 % | 0,1 % | 11,3 % | 0,11 | 0,08 | 0,036 % | 32,3 % | 71,9 % | 87 (6) | 0.0e+0 |
| 3 | 2,6 % | 14,6 % | 0,0 % | 0,0 % | 0,1 % | 12,9 % | 0,11 | 0,09 | 0,011 % | 18,4 % | 80,1 % | 121 (7) | 0.0e+0 |
| 4 | 2,0 % | 16,3 % | 0,0 % | 0,0 % | 0,1 % | 12,9 % | 0,11 | 0,09 | 0,047 % | 24,6 % | 73,5 % | 73 (4) | 0.0e+0 |
| 5 | 1,5 % | 11,3 % | 0,0 % | 0,0 % | 0,1 % | 11,7 % | 0,19 | 0,19 | 0,023 % | 20,6 % | 54,5 % | 96 (10) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 663 · 21,43 | 775 · 25,86 | 758 · 25,25 | 604 · 19,89 | 519 · 16,36 | 21,76 ❌ | par le propriétaire (97 %) ; après rachat (3 %) |
| Plancher de logement | 2 · 0,04 | 1 · 0,00 | 3 · 0,07 | 2 · 0,04 | 1 · 0,04 | 0,04 ✅ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 2726 · 68,32 | 4435 · 128,68 | 4199 · 123,21 | 3071 · 82,79 | 2988 · 75,36 | 95,67 ❌ | hausse de prix (71 %) ; baisse de prix (28 %) |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 33 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ❌ | g2 2,6 % |
| Faim et sans-abri < 2 % | ✅ | toutes les graines |
| Gini 0,2–0,45 | ❌ | g2 0,16, g4 0,16, g5 0,18 |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 21,76/50 j, Plafond de dérive des prix et salaires 95,67/50 j |

## Avant / après

| Indicateur (moyenne des graines) | Avant | Après |
|---|---|---|
| Chômage moyen | 4,4 % | 3,3 % |
| Faim moyenne | 0,0 % | 0,0 % |
| Sans-abri moyen | 0,1 % | 0,1 % |
| Gini moyen | 0,35 | 0,23 |
| Inflation moyenne / jour | 0,022 % | 0,004 % |
| Alertes critiques (total) | 11 | 33 |
| Alertes (total) | 316 | 2840 |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 |
| Anti-famine / 50 j | 0,00 | 0,00 |
| Renflouements / 50 j | 15,05 | 21,76 |
| Plancher de logement / 50 j | 0,26 | 0,04 |
| Plafond de dérive / 50 j | 71,85 | 95,67 |
| Anti-crédit-fou / 50 j | 0,00 | 0,00 |

