# Test de contrôle : k = 0 contre k > 0 (3 000 citoyens, k = 12)

- A : `c3000-k0.json` ; B : `c3000-k12.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 3000, sellerSample: 0}, B {population: 3000, sellerSample: 12}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 14,9 % | 10,9 % | −1,5 pt | [−12,8 pt ; +4,6 pt] | 4/10 | non |
| Faim moyenne | 2,6 % | 1,0 % | −1,3 pt | [−5,0 pt ; +1,1 pt] | 4/10 | non |
| Chômage moyen | 33,1 % | 30,9 % | −1,1 pt | [−8,3 pt ; +1,3 pt] | 3/10 | non |
| Demande non servie (unités non achetées / demandées) | 26,35 % | 20,05 % | −4,50 pt | [−6,62 pt ; +6,91 pt] | 3/10 | non |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,279 | 1,161 | −0,018 | [−0,258 ; +0,152] | 4/10 | non |
| Inflation moyenne par jour | 0,03 % | 0,02 % | −0,00 pt | [−0,02 pt ; +0,01 pt] | 4/10 | non |
| Gini moyen | 0,781 | 0,758 | −0,004 | [−0,079 ; +0,018] | 4/10 | non |
| Santé moyenne | 0,384 | 0,482 | +0,074 | [−0,173 ; +0,114] | 7/10 | non |
| Parc moyen d’entreprises | 123,5 | 126,9 | +4,2 | [−1,6 ; +6,3] | 7/10 | non |
| Naissances d’entreprises (toute la partie) | 28,0 | 32,0 | +5,0 | [−11,5 ; +18,0] | 6/10 | non |
| Fermetures d’entreprises (toute la partie) | 353,0 | 353,5 | +6,0 | [−15,0 ; +19,0] | 6/10 | non |
| Morts par an, en % du parc moyen | 104,7 | 101,6 | −1,3 | [−9,4 ; +5,6] | 4/10 | non |
| Part de la plus grande entreprise (médiane des biens) | 95,4 % | 96,1 % | +0,9 pt | [−1,2 pt ; +1,8 pt] | 6/10 | non |
| Herfindahl des ventes (médiane des biens) | 0,939 | 0,949 | +0,013 | [−0,017 ; +0,021] | 6/10 | non |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 16,1 % | 15,4 % | −1,4 pt | [−2,5 pt ; +1,5 pt] | 3/10 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 21,49 % | 27,50 % | +5,33 pt | [−10,52 pt ; +10,41 pt] | 6/10 | non |
| Bétail | 3,82 % | 16,21 % | +2,51 pt | [−15,43 pt ; +28,10 pt] | 6/10 | non |
| Poisson | 51,51 % | 43,61 % | −2,15 pt | [−39,96 pt ; +29,77 pt] | 5/10 | non |
| Pétrole | 0,00 % | 0,00 % | −0,00 pt | [−0,28 pt ; +0,00 pt] | 0/10 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,95 % | 0,73 % | +0,17 pt | [−1,70 pt ; +11,50 pt] | 5/10 | non |
| Or | 0,00 % | 0,00 % | +0,00 pt | [−0,11 pt ; +0,00 pt] | 0/10 | non |
| Bauxite | 1,46 % | 4,42 % | +2,22 pt | [−4,89 pt ; +8,45 pt] | 5/10 | non |
| Cuivre | 15,35 % | 25,63 % | +10,86 pt | [−22,58 pt ; +22,78 pt] | 7/10 | non |
| Viande | 4,71 % | 1,37 % | −3,60 pt | [−4,89 pt ; +0,84 pt] | 3/10 | non |
| Pain | 0,01 % | 0,01 % | +0,00 pt | [−0,23 pt ; +0,18 pt] | 4/10 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Plastique | 45,21 % | 26,97 % | −4,17 pt | [−34,08 pt ; +11,06 pt] | 4/10 | non |
| Acier | 0,05 % | 0,04 % | +0,00 pt | [−0,33 pt ; +1,65 pt] | 4/10 | non |
| Aluminium | 3,03 % | 3,67 % | +0,05 pt | [−5,83 pt ; +5,17 pt] | 5/10 | non |
| Électronique | 17,95 % | 10,35 % | −4,43 pt | [−19,39 pt ; +9,79 pt] | 5/10 | non |
| Processeurs | 91,50 % | 90,35 % | −0,04 pt | [−7,67 pt ; +7,76 pt] | 5/10 | non |
| Ordinateurs | 99,76 % | 99,59 % | −0,04 pt | [−2,12 pt ; +0,57 pt] | 5/10 | non |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [−0,01 pt ; +0,00 pt] | 1/10 | non |
| Machines | 0,15 % | 0,02 % | −0,00 pt | [−0,52 pt ; +1,10 pt] | 5/10 | non |
| Réparations | 9,37 % | 5,67 % | −2,81 pt | [−7,03 pt ; +2,42 pt] | 4/10 | non |
| Ingénierie | 2,69 % | 2,09 % | −0,81 pt | [−1,55 pt ; +0,63 pt] | 4/10 | non |
| Conception de puces | 60,94 % | 54,53 % | −2,71 pt | [−40,40 pt ; +43,38 pt] | 5/10 | non |
| Publicité | 0,34 % | 0,26 % | −0,01 pt | [−0,18 pt ; +0,03 pt] | 5/10 | non |
| Comptabilité | 0,19 % | 0,18 % | −0,03 pt | [−0,18 pt ; +0,14 pt] | 4/10 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [−0,13 pt ; +1,76 pt] | 4/10 | non |
| Télévision | 0,08 % | 0,03 % | −0,05 pt | [−0,12 pt ; +0,00 pt] | 4/10 | non |
| Loisirs | 0,00 % | 0,00 % | +0,00 pt | [−0,01 pt ; +0,01 pt] | 5/10 | non |
| Hôtel | 4,52 % | 3,17 % | −1,31 pt | [−4,59 pt ; +3,52 pt] | 4/10 | non |
| Voyages | 4,41 % | 3,60 % | −0,13 pt | [−1,25 pt ; +1,34 pt] | 3/10 | non |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 1,42 % | 0,98 % | −0,25 pt | [−1,07 pt ; +0,17 pt] | 3/10 | non |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 97,1 % | 97,3 % | +0,0 pt | [−1,1 pt ; +0,8 pt] | 5/10 | non |
| primaire : Herfindahl | 0,962 | 0,966 | +0,001 | [−0,013 ; +0,009] | 6/10 | non |
| primaire : vendeurs actifs par bien | 1,1 | 1,1 | +0,0 | [−0,0 ; +0,0] | 6/10 | non |
| primaire : dispersion des prix | 15,4 % | 15,1 % | +1,5 pt | [−3,7 pt ; +4,7 pt] | 5/10 | non |
| secondaire : part de la plus grande entreprise | 92,3 % | 92,1 % | −0,6 pt | [−1,2 pt ; +0,8 pt] | 3/10 | non |
| secondaire : Herfindahl | 0,908 | 0,907 | −0,006 | [−0,013 ; +0,011] | 4/10 | non |
| secondaire : vendeurs actifs par bien | 1,5 | 1,5 | −0,0 | [−0,2 ; +0,1] | 4/10 | non |
| secondaire : dispersion des prix | 25,6 % | 25,8 % | +1,6 pt | [−1,7 pt ; +3,8 pt] | 6/10 | non |
| tertiaire : part de la plus grande entreprise | 53,8 % | 54,0 % | +0,2 pt | [−5,2 pt ; +3,1 pt] | 5/10 | non |
| tertiaire : Herfindahl | 0,494 | 0,495 | +0,004 | [−0,049 ; +0,031] | 5/10 | non |
| tertiaire : vendeurs actifs par bien | 5,1 | 5,5 | +0,2 | [−0,0 ; +0,8] | 7/10 | non |
| tertiaire : dispersion des prix | 20,5 % | 23,0 % | +1,9 pt | [−2,4 pt ; +4,0 pt] | 7/10 | non |

