# Convergence 2500 contre 10000 habitants

- Petit : `rapports/donnees/convergence-2500.json` (2500 habitants, 10 graines, 1000 jours) ; grand : `rapports/donnees/convergence-10000.json` (10000 habitants, 10 graines, 1000 jours).
- Hasards différents d'une taille à l'autre : comparaison non appariée. Intervalles à 95 % (bootstrap percentile, 10000 tirages). Verdict : voir l'en-tête de `tool/convergence.dart`.

## Sans filets

| Indicateur | Médiane 2500 [intervalle] | EIQ 2500 | Médiane 10000 [intervalle] | EIQ 10000 | Différence des médianes [intervalle] | Demi-largeur / EIQ | Verdict |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 24,6 % [14,4 % ; 31,6 %] | 13,7 pt | 21,6 % [20,4 % ; 26,7 %] | 6,0 pt | -3,0 pt [-10,1 pt ; 8,5 pt] | 1,6 | non distinguable |
| Faim moyenne | 1,0 % [0,1 % ; 5,5 %] | 4,5 pt | 0,2 % [0,2 % ; 0,3 %] | 0,1 pt | -0,8 pt [-5,3 pt ; 0,1 pt] | 33,4 | non distinguable |
| Sans-abri moyen | 6,2 % [0,7 % ; 11,3 %] | 10,1 pt | 3,7 % [2,7 % ; 5,2 %] | 1,6 pt | -2,5 pt [-8,4 pt ; 3,4 pt] | 3,7 | non distinguable |
| Demande non servie | 9,8 % [1,6 % ; 14,7 %] | 11,4 pt | 0,4 % [0,3 % ; 1,5 %] | 0,5 pt | -9,4 pt [-14,2 pt ; -1,0 pt] | 12,7 | différent |
| Gini moyen | 0,69 [0,54 ; 0,75] | 0,16 | 0,68 [0,66 ; 0,70] | 0,03 | -0,01 [-0,07 ; 0,14] | 3,6 | non distinguable |
| Parc moyen d’entreprises (pour 1 000 hab.) | 44,9 [44,0 ; 45,9] | 1,4 | 45,9 [45,0 ; 46,1] | 0,9 | 1,0 [-0,5 ; 1,7] | 1,2 | non distinguable |
| Part de la plus grande entreprise (médiane des biens) | 97,1 % [96,2 % ; 97,6 %] | 1,2 pt | 89,3 % [88,5 % ; 90,2 %] | 1,2 pt | -7,8 pt [-8,8 pt ; -6,5 pt] | 1,0 | différent |
| Dispersion des prix entre vendeurs | 14,4 % [12,0 % ; 16,2 %] | 3,7 pt | 19,0 % [14,7 % ; 23,7 %] | 6,1 pt | 4,6 pt [-0,2 pt ; 9,7 pt] | 0,8 | non distinguable |

## Avec filets

| Indicateur | Médiane 2500 [intervalle] | EIQ 2500 | Médiane 10000 [intervalle] | EIQ 10000 | Différence des médianes [intervalle] | Demi-largeur / EIQ | Verdict |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 18,2 % [10,6 % ; 23,5 %] | 11,3 pt | 26,0 % [22,6 % ; 28,0 %] | 4,1 pt | 7,8 pt [2,3 pt ; 15,9 pt] | 1,7 | différent |
| Faim moyenne | 0,0 % [0,0 % ; 0,1 %] | 0,0 pt | 0,4 % [0,3 % ; 0,5 %] | 0,1 pt | 0,4 pt [0,3 pt ; 0,5 pt] | 1,2 | différent |
| Sans-abri moyen | 1,0 % [0,5 % ; 2,4 %] | 1,6 pt | 4,8 % [3,7 % ; 6,1 %] | 1,6 pt | 3,8 pt [2,1 pt ; 5,2 pt] | 1,0 | différent |
| Demande non servie | 1,6 % [0,3 % ; 6,0 %] | 5,1 pt | 1,4 % [0,3 % ; 2,9 %] | 2,4 pt | -0,2 pt [-4,6 pt ; 2,2 pt] | 1,4 | non distinguable |
| Gini moyen | 0,55 [0,42 ; 0,62] | 0,17 | 0,70 [0,66 ; 0,71] | 0,05 | 0,15 [0,06 ; 0,27] | 2,3 | différent |
| Parc moyen d’entreprises (pour 1 000 hab.) | 48,8 [48,0 ; 49,2] | 0,9 | 48,2 [47,8 ; 48,6] | 0,7 | -0,6 [-1,2 ; 0,3] | 1,1 | non distinguable |
| Part de la plus grande entreprise (médiane des biens) | 97,3 % [97,0 % ; 97,8 %] | 0,8 pt | 87,7 % [87,2 % ; 88,9 %] | 1,5 pt | -9,6 pt [-10,4 pt ; -8,3 pt] | 0,7 | différent |
| Dispersion des prix entre vendeurs | 22,3 % [21,5 % ; 24,2 %] | 2,4 pt | 26,0 % [24,2 % ; 31,7 %] | 4,7 pt | 3,7 pt [1,3 pt ; 9,6 pt] | 0,9 | différent |

Bilan : 8 différences conclues, 8 non distinguables (sur 16 comparaisons).
