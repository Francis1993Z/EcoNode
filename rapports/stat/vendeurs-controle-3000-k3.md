# Test de contrôle : k = 0 contre k > 0 (3 000 citoyens, k = 3)

- A : `c3000-k0.json` ; B : `c3000-k3.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 3000, sellerSample: 0}, B {population: 3000, sellerSample: 3}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 14,9 % | 0,4 % | −13,2 pt | [−19,0 pt ; −6,9 pt] | 0/10 | oui |
| Faim moyenne | 2,6 % | 0,0 % | −2,5 pt | [−6,2 pt ; −0,1 pt] | 2/10 | oui |
| Chômage moyen | 33,1 % | 9,9 % | −21,6 pt | [−28,2 pt ; −18,4 pt] | 0/10 | oui |
| Demande non servie (unités non achetées / demandées) | 26,35 % | 0,70 % | −24,13 pt | [−26,23 pt ; −14,98 pt] | 0/10 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,279 | 0,800 | −0,200 | [−0,723 ; +0,136] | 3/10 | non |
| Inflation moyenne par jour | 0,03 % | -0,03 % | −0,02 pt | [−0,08 pt ; +0,01 pt] | 3/10 | non |
| Gini moyen | 0,781 | 0,374 | −0,381 | [−0,434 ; −0,360] | 0/10 | oui |
| Santé moyenne | 0,384 | 0,882 | +0,458 | [+0,285 ; +0,527] | 10/10 | oui |
| Parc moyen d’entreprises | 123,5 | 150,7 | +27,4 | [+23,6 ; +30,9] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 28,0 | 18,5 | −12,5 | [−25,0 ; −4,5] | 0/10 | oui |
| Fermetures d’entreprises (toute la partie) | 353,0 | 306,5 | −51,0 | [−62,0 ; −28,0] | 0/10 | oui |
| Morts par an, en % du parc moyen | 104,7 | 73,8 | −33,1 | [−38,0 ; −20,3] | 0/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 95,4 % | 95,9 % | +0,6 pt | [−1,3 pt ; +1,6 pt] | 6/10 | non |
| Herfindahl des ventes (médiane des biens) | 0,939 | 0,949 | +0,009 | [−0,018 ; +0,024] | 6/10 | non |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 16,1 % | 12,1 % | −4,0 pt | [−5,3 pt ; −2,5 pt] | 1/10 | oui |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 21,49 % | 6,32 % | −19,96 pt | [−25,55 pt ; +2,40 pt] | 3/10 | non |
| Bétail | 3,82 % | 5,01 % | +0,00 pt | [−8,93 pt ; +15,86 pt] | 3/10 | non |
| Poisson | 51,51 % | 0,03 % | −48,12 pt | [−58,74 pt ; −29,64 pt] | 0/10 | oui |
| Pétrole | 0,00 % | 0,00 % | −0,00 pt | [−0,28 pt ; +0,00 pt] | 0/10 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,95 % | 0,08 % | −0,60 pt | [−3,53 pt ; +0,06 pt] | 3/10 | non |
| Or | 0,00 % | 0,93 % | +0,74 pt | [+0,39 pt ; +1,62 pt] | 10/10 | oui |
| Bauxite | 1,46 % | 0,21 % | −1,11 pt | [−6,31 pt ; +0,16 pt] | 3/10 | non |
| Cuivre | 15,35 % | 0,08 % | −15,04 pt | [−31,53 pt ; −5,76 pt] | 0/10 | oui |
| Viande | 4,71 % | 6,79 % | +2,43 pt | [+1,46 pt ; +5,78 pt] | 9/10 | oui |
| Pain | 0,01 % | 0,00 % | −0,01 pt | [−0,23 pt ; +0,09 pt] | 3/10 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Plastique | 45,21 % | 8,27 % | −37,54 pt | [−53,58 pt ; −15,33 pt] | 1/10 | oui |
| Acier | 0,05 % | 0,00 % | −0,05 pt | [−0,89 pt ; +0,00 pt] | 1/10 | non |
| Aluminium | 3,03 % | 0,07 % | −2,95 pt | [−11,28 pt ; −0,35 pt] | 2/10 | oui |
| Électronique | 17,95 % | 0,00 % | −17,89 pt | [−24,43 pt ; −5,63 pt] | 0/10 | oui |
| Processeurs | 91,50 % | 69,36 % | −17,42 pt | [−44,31 pt ; −4,73 pt] | 2/10 | oui |
| Ordinateurs | 99,76 % | 92,61 % | −6,74 pt | [−23,63 pt ; −0,12 pt] | 2/10 | oui |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [−0,01 pt ; +0,00 pt] | 0/10 | non |
| Machines | 0,15 % | 0,03 % | −0,11 pt | [−1,33 pt ; +0,02 pt] | 3/10 | non |
| Réparations | 9,37 % | 0,06 % | −9,12 pt | [−11,46 pt ; −0,93 pt] | 0/10 | oui |
| Ingénierie | 2,69 % | 3,33 % | +0,45 pt | [−1,43 pt ; +2,80 pt] | 5/10 | non |
| Conception de puces | 60,94 % | 3,57 % | −58,03 pt | [−82,09 pt ; −17,86 pt] | 1/10 | oui |
| Publicité | 0,34 % | 0,04 % | −0,24 pt | [−0,37 pt ; −0,12 pt] | 0/10 | oui |
| Comptabilité | 0,19 % | 0,21 % | −0,04 pt | [−0,16 pt ; +0,17 pt] | 4/10 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [−0,25 pt ; +0,00 pt] | 0/10 | non |
| Télévision | 0,08 % | 0,00 % | −0,08 pt | [−0,16 pt ; −0,01 pt] | 0/10 | oui |
| Loisirs | 0,00 % | 0,00 % | −0,00 pt | [−0,01 pt ; −0,00 pt] | 0/10 | oui |
| Hôtel | 4,52 % | 0,64 % | −2,95 pt | [−6,32 pt ; −2,24 pt] | 0/10 | oui |
| Voyages | 4,41 % | 1,91 % | −2,32 pt | [−3,54 pt ; −0,06 pt] | 2/10 | oui |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 1,42 % | 0,00 % | −1,27 pt | [−1,51 pt ; −0,66 pt] | 0/10 | oui |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 97,1 % | 98,7 % | +1,7 pt | [+0,5 pt ; +2,1 pt] | 10/10 | oui |
| primaire : Herfindahl | 0,962 | 0,984 | +0,022 | [+0,007 ; +0,027] | 10/10 | oui |
| primaire : vendeurs actifs par bien | 1,1 | 1,1 | −0,1 | [−0,1 ; −0,0] | 0/10 | oui |
| primaire : dispersion des prix | 15,4 % | 10,1 % | −5,6 pt | [−7,2 pt ; −2,6 pt] | 1/10 | oui |
| secondaire : part de la plus grande entreprise | 92,3 % | 87,7 % | −4,3 pt | [−5,2 pt ; −3,0 pt] | 0/10 | oui |
| secondaire : Herfindahl | 0,908 | 0,854 | −0,048 | [−0,061 ; −0,038] | 0/10 | oui |
| secondaire : vendeurs actifs par bien | 1,5 | 1,8 | +0,3 | [+0,3 ; +0,4] | 10/10 | oui |
| secondaire : dispersion des prix | 25,6 % | 24,1 % | −0,6 pt | [−3,0 pt ; +3,1 pt] | 4/10 | non |
| tertiaire : part de la plus grande entreprise | 53,8 % | 45,8 % | −7,2 pt | [−10,1 pt ; −6,0 pt] | 0/10 | oui |
| tertiaire : Herfindahl | 0,494 | 0,406 | −0,078 | [−0,100 ; −0,061] | 0/10 | oui |
| tertiaire : vendeurs actifs par bien | 5,1 | 6,7 | +1,4 | [+1,2 ; +1,6] | 10/10 | oui |
| tertiaire : dispersion des prix | 20,5 % | 24,1 % | +3,3 pt | [−0,3 pt ; +8,0 pt] | 7/10 | non |

