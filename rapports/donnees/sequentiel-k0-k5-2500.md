# Comparaison à arrêt séquentiel

- A : `param:sellerSample=0` ; B : `ref` ; 2500 habitants, 1000 jours (chauffe 100) ; lots de 5 graines, 30 graines jouées (plafond 30), sans arrêt anticipé.
- Temps : 1283 s. Intervalle : bootstrap percentile de la médiane des différences par graine (B − A), 95 %.

## Sans filets

| Indicateur | Seuil (demi-largeur) | Différence médiane B − A [intervalle] | Demi-largeur à 30 graines | Graines nécessaires |
|---|---|---|---|---|
| Chômage moyen | 2,00 pt | 4,06 pt [-3,29 pt ; 6,89 pt] | 5,09 pt | plus de 30 |
| Faim moyenne | 1,00 pt | 0,17 pt [-1,01 pt ; 1,38 pt] | 1,20 pt | plus de 30 |
| Sans-abri moyen | 1,00 pt | 0,42 pt [-0,22 pt ; 2,59 pt] | 1,41 pt | plus de 30 |
| Parc moyen d’entreprises | 5,0 % | 3,6 % [2,6 % ; 6,4 %] | 1,9 % | 5 |

Demi-largeur selon le nombre de graines :

| Graines | Chômage moyen | Faim moyenne | Sans-abri moyen | Parc moyen d’entreprises |
|---|---|---|---|---|
| 5 | 15,57 pt | 5,02 pt | 10,30 pt | 4,1 % |
| 10 | 9,33 pt | 2,30 pt | 3,76 pt | 2,9 % |
| 15 | 7,16 pt | 1,04 pt | 2,08 pt | 2,3 % |
| 20 | 5,34 pt | 1,41 pt | 2,12 pt | 1,9 % |
| 25 | 6,22 pt | 1,46 pt | 2,57 pt | 2,2 % |
| 30 | 5,09 pt | 1,20 pt | 1,41 pt | 1,9 % |

## Avec filets

| Indicateur | Seuil (demi-largeur) | Différence médiane B − A [intervalle] | Demi-largeur à 30 graines | Graines nécessaires |
|---|---|---|---|---|
| Chômage moyen | 2,00 pt | 0,19 pt [-6,02 pt ; 6,04 pt] | 6,03 pt | plus de 30 |
| Faim moyenne | 1,00 pt | 0,00 pt [0,00 pt ; 0,01 pt] | 0,00 pt | 10 |
| Sans-abri moyen | 1,00 pt | 0,02 pt [-0,41 pt ; 0,56 pt] | 0,48 pt | 10 |
| Parc moyen d’entreprises | 5,0 % | 2,3 % [1,4 % ; 3,5 %] | 1,1 % | 5 |

Demi-largeur selon le nombre de graines :

| Graines | Chômage moyen | Faim moyenne | Sans-abri moyen | Parc moyen d’entreprises |
|---|---|---|---|---|
| 5 | 19,47 pt | 1,30 pt | 6,94 pt | 4,3 % |
| 10 | 8,43 pt | 0,31 pt | 0,92 pt | 1,9 % |
| 15 | 8,35 pt | 0,01 pt | 0,68 pt | 1,5 % |
| 20 | 6,22 pt | 0,01 pt | 0,61 pt | 1,3 % |
| 25 | 7,05 pt | 0,01 pt | 0,63 pt | 1,5 % |
| 30 | 6,03 pt | 0,00 pt | 0,48 pt | 1,1 % |

