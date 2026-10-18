# Test de contrôle : k = 0 contre k > 0 (3 000 citoyens, k = 2)

- A : `c3000-k0.json` ; B : `c3000-k2.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 3000, sellerSample: 0}, B {population: 3000, sellerSample: 2}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 14,9 % | 1,6 % | −11,2 pt | [−16,6 pt ; −7,0 pt] | 0/10 | oui |
| Faim moyenne | 2,6 % | 0,1 % | −1,9 pt | [−5,0 pt ; −0,2 pt] | 2/10 | oui |
| Chômage moyen | 33,1 % | 13,8 % | −19,4 pt | [−26,9 pt ; −16,8 pt] | 0/10 | oui |
| Demande non servie (unités non achetées / demandées) | 26,35 % | 1,76 % | −23,51 pt | [−25,70 pt ; −15,42 pt] | 0/10 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,279 | 0,949 | −0,369 | [−0,610 ; +0,103] | 2/10 | non |
| Inflation moyenne par jour | 0,03 % | -0,01 % | −0,04 pt | [−0,08 pt ; +0,02 pt] | 2/10 | non |
| Gini moyen | 0,781 | 0,321 | −0,447 | [−0,474 ; −0,416] | 0/10 | oui |
| Santé moyenne | 0,384 | 0,857 | +0,461 | [+0,289 ; +0,495] | 9/10 | oui |
| Parc moyen d’entreprises | 123,5 | 155,8 | +34,0 | [+26,2 ; +36,6] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 28,0 | 18,5 | −13,5 | [−21,0 ; −6,5] | 0/10 | oui |
| Fermetures d’entreprises (toute la partie) | 353,0 | 298,0 | −58,0 | [−63,0 ; −41,5] | 0/10 | oui |
| Morts par an, en % du parc moyen | 104,7 | 69,6 | −35,6 | [−40,4 ; −26,6] | 0/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 95,4 % | 94,8 % | −0,3 pt | [−2,3 pt ; +0,6 pt] | 4/10 | non |
| Herfindahl des ventes (médiane des biens) | 0,939 | 0,932 | −0,001 | [−0,030 ; +0,010] | 5/10 | non |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 16,1 % | 11,4 % | −4,2 pt | [−6,2 pt ; −1,8 pt] | 0/10 | oui |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 21,49 % | 0,08 % | −20,59 pt | [−26,03 pt ; −12,88 pt] | 1/10 | oui |
| Bétail | 3,82 % | 27,22 % | +10,59 pt | [−5,52 pt ; +30,39 pt] | 7/10 | non |
| Poisson | 51,51 % | 0,00 % | −51,51 pt | [−64,61 pt ; −39,31 pt] | 0/10 | oui |
| Pétrole | 0,00 % | 0,00 % | −0,00 pt | [−0,28 pt ; +0,00 pt] | 1/10 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,95 % | 0,00 % | −0,93 pt | [−3,73 pt ; +0,00 pt] | 1/10 | non |
| Or | 0,00 % | 2,41 % | +2,41 pt | [+0,98 pt ; +52,62 pt] | 10/10 | oui |
| Bauxite | 1,46 % | 0,29 % | −1,46 pt | [−4,51 pt ; +0,00 pt] | 2/10 | non |
| Cuivre | 15,35 % | 0,03 % | −15,27 pt | [−31,06 pt ; −5,85 pt] | 0/10 | oui |
| Viande | 4,71 % | 4,67 % | +1,16 pt | [−1,30 pt ; +2,69 pt] | 8/10 | non |
| Pain | 0,01 % | 0,00 % | −0,01 pt | [−0,23 pt ; +0,00 pt] | 1/10 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Plastique | 45,21 % | 7,98 % | −41,93 pt | [−52,94 pt ; −17,05 pt] | 1/10 | oui |
| Acier | 0,05 % | 0,00 % | −0,05 pt | [−0,89 pt ; +0,00 pt] | 1/10 | non |
| Aluminium | 3,03 % | 0,08 % | −2,92 pt | [−11,02 pt ; −0,38 pt] | 1/10 | oui |
| Électronique | 17,95 % | 0,00 % | −17,95 pt | [−24,28 pt ; −5,73 pt] | 0/10 | oui |
| Processeurs | 91,50 % | 91,62 % | +1,84 pt | [−4,20 pt ; +7,75 pt] | 5/10 | non |
| Ordinateurs | 99,76 % | 98,74 % | −1,02 pt | [−3,94 pt ; +0,63 pt] | 4/10 | non |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [−0,01 pt ; +43,71 pt] | 2/10 | non |
| Machines | 0,15 % | 0,03 % | −0,15 pt | [−1,36 pt ; +0,03 pt] | 3/10 | non |
| Réparations | 9,37 % | 0,03 % | −9,32 pt | [−11,52 pt ; −0,97 pt] | 1/10 | oui |
| Ingénierie | 2,69 % | 4,02 % | +2,52 pt | [−1,14 pt ; +4,14 pt] | 6/10 | non |
| Conception de puces | 60,94 % | 8,73 % | −45,61 pt | [−78,87 pt ; −4,96 pt] | 2/10 | oui |
| Publicité | 0,34 % | 0,05 % | −0,30 pt | [−0,36 pt ; −0,12 pt] | 0/10 | oui |
| Comptabilité | 0,19 % | 0,14 % | −0,11 pt | [−0,22 pt ; +0,05 pt] | 3/10 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [−0,25 pt ; +0,00 pt] | 0/10 | non |
| Télévision | 0,08 % | 0,02 % | −0,07 pt | [−0,13 pt ; −0,01 pt] | 2/10 | oui |
| Loisirs | 0,00 % | 0,00 % | −0,00 pt | [−0,01 pt ; −0,00 pt] | 0/10 | oui |
| Hôtel | 4,52 % | 0,89 % | −3,63 pt | [−6,09 pt ; −1,93 pt] | 0/10 | oui |
| Voyages | 4,41 % | 1,78 % | −2,33 pt | [−3,48 pt ; −0,26 pt] | 2/10 | oui |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 1,42 % | 0,00 % | −1,39 pt | [−1,55 pt ; −0,64 pt] | 0/10 | oui |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 97,1 % | 98,6 % | +1,3 pt | [+1,1 pt ; +2,0 pt] | 9/10 | oui |
| primaire : Herfindahl | 0,962 | 0,983 | +0,018 | [+0,015 ; +0,026] | 9/10 | oui |
| primaire : vendeurs actifs par bien | 1,1 | 1,1 | −0,1 | [−0,1 ; −0,0] | 0/10 | oui |
| primaire : dispersion des prix | 15,4 % | 9,8 % | −5,7 pt | [−8,5 pt ; −2,5 pt] | 1/10 | oui |
| secondaire : part de la plus grande entreprise | 92,3 % | 86,9 % | −5,9 pt | [−8,1 pt ; −3,2 pt] | 0/10 | oui |
| secondaire : Herfindahl | 0,908 | 0,844 | −0,066 | [−0,095 ; −0,042] | 0/10 | oui |
| secondaire : vendeurs actifs par bien | 1,5 | 2,1 | +0,7 | [+0,5 ; +0,8] | 10/10 | oui |
| secondaire : dispersion des prix | 25,6 % | 26,3 % | +1,0 pt | [−1,8 pt ; +4,0 pt] | 6/10 | non |
| tertiaire : part de la plus grande entreprise | 53,8 % | 42,7 % | −10,9 pt | [−13,3 pt ; −9,6 pt] | 0/10 | oui |
| tertiaire : Herfindahl | 0,494 | 0,385 | −0,110 | [−0,131 ; −0,089] | 0/10 | oui |
| tertiaire : vendeurs actifs par bien | 5,1 | 7,1 | +2,0 | [+1,6 ; +2,2] | 10/10 | oui |
| tertiaire : dispersion des prix | 20,5 % | 22,1 % | +0,9 pt | [−2,5 pt ; +4,2 pt] | 5/10 | non |

