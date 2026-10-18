# Test de contrôle : k = 0 contre k > 0 (3 000 citoyens, k = 20)

- A : `c3000-k0.json` ; B : `c3000-k20.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 3000, sellerSample: 0}, B {population: 3000, sellerSample: 20}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 14,9 % | 13,8 % | +0,7 pt | [−4,0 pt ; +3,4 pt] | 6/10 | non |
| Faim moyenne | 2,6 % | 1,5 % | +0,0 pt | [−3,5 pt ; +2,3 pt] | 5/10 | non |
| Chômage moyen | 33,1 % | 32,8 % | −0,1 pt | [−3,9 pt ; +2,1 pt] | 5/10 | non |
| Demande non servie (unités non achetées / demandées) | 26,35 % | 24,73 % | +0,12 pt | [−2,20 pt ; +1,80 pt] | 6/10 | non |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,279 | 1,314 | +0,165 | [−0,163 ; +0,366] | 7/10 | non |
| Inflation moyenne par jour | 0,03 % | 0,03 % | +0,01 pt | [−0,01 pt ; +0,04 pt] | 7/10 | non |
| Gini moyen | 0,781 | 0,770 | +0,001 | [−0,020 ; +0,015] | 5/10 | non |
| Santé moyenne | 0,384 | 0,413 | −0,002 | [−0,011 ; +0,028] | 3/10 | non |
| Parc moyen d’entreprises | 123,5 | 123,1 | −0,0 | [−1,7 ; +1,5] | 5/10 | non |
| Naissances d’entreprises (toute la partie) | 28,0 | 38,0 | −4,5 | [−8,5 ; +16,0] | 4/10 | non |
| Fermetures d’entreprises (toute la partie) | 353,0 | 359,5 | +1,5 | [−5,0 ; +13,0] | 5/10 | non |
| Morts par an, en % du parc moyen | 104,7 | 106,0 | +1,1 | [−0,9 ; +3,0] | 7/10 | non |
| Part de la plus grande entreprise (médiane des biens) | 95,4 % | 95,2 % | −0,1 pt | [−0,5 pt ; +0,1 pt] | 4/10 | non |
| Herfindahl des ventes (médiane des biens) | 0,939 | 0,940 | +0,000 | [−0,006 ; +0,002] | 6/10 | non |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 16,1 % | 15,1 % | −0,1 pt | [−3,2 pt ; +0,4 pt] | 5/10 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 21,49 % | 27,33 % | +2,70 pt | [−1,05 pt ; +9,31 pt] | 8/10 | non |
| Bétail | 3,82 % | 3,68 % | +0,00 pt | [−0,71 pt ; +1,03 pt] | 2/10 | non |
| Poisson | 51,51 % | 44,60 % | −1,65 pt | [−19,15 pt ; +17,90 pt] | 5/10 | non |
| Pétrole | 0,00 % | 0,00 % | −0,00 pt | [−0,10 pt ; +0,00 pt] | 1/10 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,95 % | 0,81 % | +0,23 pt | [−0,42 pt ; +9,11 pt] | 6/10 | non |
| Or | 0,00 % | 0,00 % | +0,00 pt | [−0,01 pt ; +0,00 pt] | 0/10 | non |
| Bauxite | 1,46 % | 2,21 % | −0,40 pt | [−5,16 pt ; +4,65 pt] | 3/10 | non |
| Cuivre | 15,35 % | 23,51 % | −5,68 pt | [−10,54 pt ; +23,34 pt] | 4/10 | non |
| Viande | 4,71 % | 2,56 % | −0,07 pt | [−1,18 pt ; +0,33 pt] | 4/10 | non |
| Pain | 0,01 % | 0,00 % | +0,00 pt | [−0,03 pt ; +0,10 pt] | 3/10 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Plastique | 45,21 % | 51,66 % | +3,36 pt | [−11,95 pt ; +15,86 pt] | 5/10 | non |
| Acier | 0,05 % | 0,40 % | +0,01 pt | [−0,05 pt ; +1,17 pt] | 5/10 | non |
| Aluminium | 3,03 % | 4,70 % | −0,53 pt | [−5,42 pt ; +3,82 pt] | 4/10 | non |
| Électronique | 17,95 % | 20,98 % | +0,08 pt | [−12,11 pt ; +13,86 pt] | 5/10 | non |
| Processeurs | 91,50 % | 94,18 % | +0,66 pt | [+0,20 pt ; +4,84 pt] | 8/10 | oui |
| Ordinateurs | 99,76 % | 99,71 % | −0,01 pt | [−0,21 pt ; +0,46 pt] | 4/10 | non |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [−0,00 pt ; +0,00 pt] | 0/10 | non |
| Machines | 0,15 % | 0,13 % | +0,00 pt | [−0,43 pt ; +0,12 pt] | 4/10 | non |
| Réparations | 9,37 % | 6,97 % | −1,16 pt | [−2,31 pt ; +1,41 pt] | 3/10 | non |
| Ingénierie | 2,69 % | 2,32 % | +0,01 pt | [−1,26 pt ; +1,23 pt] | 5/10 | non |
| Conception de puces | 60,94 % | 52,94 % | −1,03 pt | [−12,53 pt ; +10,53 pt] | 4/10 | non |
| Publicité | 0,34 % | 0,32 % | +0,02 pt | [−0,11 pt ; +0,14 pt] | 6/10 | non |
| Comptabilité | 0,19 % | 0,16 % | −0,01 pt | [−0,02 pt ; +0,01 pt] | 4/10 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 2/10 | non |
| Télévision | 0,08 % | 0,06 % | −0,02 pt | [−0,06 pt ; −0,01 pt] | 0/10 | oui |
| Loisirs | 0,00 % | 0,00 % | −0,00 pt | [−0,01 pt ; +0,01 pt] | 4/10 | non |
| Hôtel | 4,52 % | 3,62 % | −0,49 pt | [−3,13 pt ; +0,23 pt] | 4/10 | non |
| Voyages | 4,41 % | 3,85 % | −0,29 pt | [−0,84 pt ; +0,24 pt] | 4/10 | non |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 1,42 % | 1,49 % | +0,07 pt | [−0,31 pt ; +0,61 pt] | 6/10 | non |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 97,1 % | 97,2 % | +0,0 pt | [−0,3 pt ; +0,2 pt] | 6/10 | non |
| primaire : Herfindahl | 0,962 | 0,964 | +0,000 | [−0,004 ; +0,003] | 5/10 | non |
| primaire : vendeurs actifs par bien | 1,1 | 1,1 | −0,0 | [−0,0 ; +0,0] | 5/10 | non |
| primaire : dispersion des prix | 15,4 % | 15,3 % | +0,0 pt | [−1,1 pt ; +0,7 pt] | 5/10 | non |
| secondaire : part de la plus grande entreprise | 92,3 % | 92,5 % | +0,0 pt | [−0,7 pt ; +0,5 pt] | 5/10 | non |
| secondaire : Herfindahl | 0,908 | 0,910 | +0,000 | [−0,008 ; +0,007] | 5/10 | non |
| secondaire : vendeurs actifs par bien | 1,5 | 1,4 | +0,0 | [−0,1 ; +0,1] | 5/10 | non |
| secondaire : dispersion des prix | 25,6 % | 25,4 % | +0,8 pt | [−1,2 pt ; +2,0 pt] | 7/10 | non |
| tertiaire : part de la plus grande entreprise | 53,8 % | 55,8 % | +0,5 pt | [−0,9 pt ; +1,3 pt] | 7/10 | non |
| tertiaire : Herfindahl | 0,494 | 0,513 | +0,004 | [−0,007 ; +0,008] | 7/10 | non |
| tertiaire : vendeurs actifs par bien | 5,1 | 5,1 | −0,0 | [−0,1 ; +0,1] | 4/10 | non |
| tertiaire : dispersion des prix | 20,5 % | 20,6 % | +0,7 pt | [−1,0 pt ; +1,2 pt] | 6/10 | non |

