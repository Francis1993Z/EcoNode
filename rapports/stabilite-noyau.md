# Protocole de stabilité ÉcoNodes

- Date : 2026-10-03 22:15
- Graines : 1, 2, 3, 4, 5 · 1500 jours · régime mesuré après le jour 100
- Modules coupés : Crédit bancaire (Caisse), Machines et entretien, Recherche et développement, Publicité, Comptabilité obligatoire, Maladies et soins, Formation et qualifications, Santé publique (l’État paie), Éducation publique (l’État paie)

## 1. Sans filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,0 % | 24,2 % | 0,0 % | 0,0 % | 100,0 % | 100,0 % | 0,24 | 0,13 | 0,014 % | 1,5 % | 59,9 % | 98 (1) | 0.0e+0 |
| 2 | 3,8 % | 22,5 % | 0,0 % | 0,0 % | 100,0 % | 100,0 % | 0,20 | 0,14 | 0,012 % | 1,6 % | 68,9 % | 92 (2) | 0.0e+0 |
| 3 | 4,3 % | 23,8 % | 0,0 % | 0,0 % | 100,0 % | 100,0 % | 0,24 | 0,23 | 0,009 % | 1,5 % | 63,9 % | 88 (2) | 0.0e+0 |
| 4 | 4,4 % | 25,8 % | 0,0 % | 0,0 % | 100,0 % | 100,0 % | 0,24 | 0,19 | 0,004 % | 1,7 % | 65,4 % | 92 (2) | 0.0e+0 |
| 5 | 4,0 % | 28,3 % | 0,0 % | 0,0 % | 100,0 % | 100,0 % | 0,31 | 0,18 | 0,010 % | 1,7 % | 56,7 % | 97 (2) | 0.0e+0 |

### Alertes ouvertes, par type (ouvertures · jours-alerte)

| Type | Gravité | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|---|
| Sans-abri nombreux | critique | 1 · 1431 j | 2 · 1447 j | 2 · 1444 j | 2 · 1447 j | 2 · 1439 j |
| Rupture de stock prolongée | attention | 28 · 10688 j | 28 · 10713 j | 21 · 11444 j | 28 · 10879 j | 27 · 10587 j |
| Surstock | attention | 13 · 11913 j | 11 · 11830 j | 14 · 11546 j | 10 · 10318 j | 13 · 11925 j |
| Entreprise sans employé | attention | 26 · 35234 j | 26 · 35272 j | 25 · 35716 j | 25 · 35363 j | 26 · 35226 j |
| Entreprise sans client | attention | 30 · 35142 j | 25 · 35119 j | 26 · 35869 j | 27 · 35274 j | 29 · 35040 j |

### Structure de l’emploi en fin de partie (primaire / secondaire / tertiaire)

| Graine | Primaire | Secondaire | Tertiaire | Entreprises sans employé | Dette finale | Prêté | Radié |
|---|---|---|---|---|---|---|---|
| 1 | 7,2 % | 19,8 % | 73,0 % | 25 | 0 $ | 0 $ | 0 $ |
| 2 | 9,0 % | 17,5 % | 73,5 % | 25 | 0 $ | 0 $ | 0 $ |
| 3 | 8,1 % | 20,9 % | 71,1 % | 25 | 0 $ | 0 $ | 0 $ |
| 4 | 8,0 % | 21,9 % | 70,0 % | 25 | 0 $ | 0 $ | 0 $ |
| 5 | 6,3 % | 21,3 % | 72,5 % | 25 | 0 $ | 0 $ | 0 $ |

## 2. Avec filets

| Graine | Chômage moy. | Chômage max | Faim moy. | Faim max | Sans-abri moy. | Sans-abri max | Gini moy. | Gini fin | Inflation moy./j | |Infl.| max/j | |Infl. 100 j| max | Alertes (crit.) | Écart compta max |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 4,9 % | 17,5 % | 0,0 % | 0,0 % | 0,0 % | 0,0 % | 0,46 | 0,40 | -0,006 % | 0,8 % | 17,9 % | 214 (0) | 0.0e+0 |
| 2 | 5,3 % | 20,4 % | 0,0 % | 0,0 % | 0,0 % | 11,3 % | 0,46 | 0,46 | -0,009 % | 0,5 % | 13,4 % | 234 (1) | 0.0e+0 |
| 3 | 6,6 % | 22,1 % | 0,0 % | 0,0 % | 0,0 % | 11,3 % | 0,51 | 0,52 | -0,012 % | 0,6 % | 15,7 % | 208 (1) | 0.0e+0 |
| 4 | 6,9 % | 22,5 % | 0,0 % | 0,0 % | 0,0 % | 24,2 % | 0,55 | 0,59 | -0,023 % | 0,8 % | 18,0 % | 236 (1) | 0.0e+0 |
| 5 | 7,7 % | 24,2 % | 0,0 % | 0,0 % | 0,0 % | 11,3 % | 0,63 | 0,70 | -0,042 % | 0,7 % | 20,2 % | 252 (1) | 0.0e+0 |

### Déclenchements par filet (total · régime par 50 jours · cause principale)

| Filet | g1 | g2 | g3 | g4 | g5 | Moyenne / 50 j | Cause principale |
|---|---|---|---|---|---|---|---|
| Anti-famine | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |
| Renflouement d’entreprise | 1837 · 62,43 | 1852 · 63,25 | 1876 · 64,29 | 1855 · 62,96 | 1932 · 65,86 | 63,76 ❌ | par le propriétaire (99 %) ; après rachat (1 %) |
| Plancher de logement | 0 · 0,00 | 0 · 0,00 | 1 · 0,00 | 18 · 0,00 | 1 · 0,00 | 0,00 ✅ | parc plein (100 %) |
| Plafond de dérive des prix et salaires | 3438 · 101,57 | 3783 · 116,00 | 3326 · 99,07 | 4143 · 124,36 | 4141 · 125,93 | 113,39 ❌ | hausse de prix (58 %) ; baisse de prix (41 %) |
| Anti-crédit-fou | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0 · 0,00 | 0,00 ✅ | — |

## Critères de sortie

| Critère | Résultat | Détail |
|---|---|---|
| Aucune alerte critique (sans filets) | ❌ | 9 ouverture(s) critique(s) |
| Chômage moyen 3–10 % | ✅ | toutes les graines |
| Faim et sans-abri < 2 % | ❌ | g1, g2, g3, g4, g5 |
| Gini 0,2–0,45 | ✅ | toutes les graines |
| Inflation moyenne < ±0,5 %/j | ✅ | toutes les graines |
| Invariant comptable à 1e-8 près | ✅ | écart max 0.00e+0 $ |
| Filets : < 1 déclenchement / 50 j en régime | ❌ | Renflouement d’entreprise 63,76/50 j, Plafond de dérive des prix et salaires 113,39/50 j |

