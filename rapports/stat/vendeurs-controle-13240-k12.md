# Test de contrôle : k = 0 contre k > 0 (13 240 citoyens, k = 12)

- A : `c13240-k0.json` ; B : `c13240-k12.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 13240, sellerSample: 0}, B {population: 13240, sellerSample: 12}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 27,7 % | 25,0 % | −4,2 pt | [−12,7 pt ; −0,8 pt] | 0/5 | oui |
| Faim moyenne | 50,7 % | 41,9 % | −8,6 pt | [−12,8 pt ; −4,9 pt] | 0/5 | oui |
| Chômage moyen | 62,2 % | 56,5 % | −5,6 pt | [−9,2 pt ; −3,2 pt] | 0/5 | oui |
| Demande non servie (unités non achetées / demandées) | 42,43 % | 36,84 % | −5,65 pt | [−6,38 pt ; −2,95 pt] | 0/5 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,926 | 2,478 | +0,583 | [−0,322 ; +0,762] | 4/5 | non |
| Inflation moyenne par jour | 0,07 % | 0,10 % | +0,03 pt | [−0,02 pt ; +0,04 pt] | 4/5 | non |
| Gini moyen | 0,881 | 0,860 | −0,025 | [−0,031 ; −0,015] | 0/5 | oui |
| Santé moyenne | 0,288 | 0,326 | +0,041 | [+0,015 ; +0,047] | 5/5 | oui |
| Parc moyen d’entreprises | 447,2 | 485,0 | +40,0 | [+31,4 ; +44,9] | 5/5 | oui |
| Naissances d’entreprises (toute la partie) | 8,0 | 5,0 | −3,0 | [−12,0 ; +4,0] | 1/5 | non |
| Fermetures d’entreprises (toute la partie) | 1487,0 | 1461,0 | −21,0 | [−33,0 ; −10,0] | 0/5 | oui |
| Morts par an, en % du parc moyen | 119,8 | 110,0 | −10,6 | [−13,9 ; −9,8] | 0/5 | oui |
| Part de la plus grande entreprise (médiane des biens) | 81,0 % | 69,4 % | −11,0 pt | [−16,5 pt ; −5,1 pt] | 0/5 | oui |
| Herfindahl des ventes (médiane des biens) | 0,765 | 0,623 | −0,113 | [−0,199 ; −0,054] | 0/5 | oui |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 21,3 % | 20,2 % | −2,7 pt | [−4,1 pt ; +3,6 pt] | 1/5 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 0,00 % | 0,00 % | +0,00 pt | [−0,07 pt ; +0,13 pt] | 1/5 | non |
| Bétail | 28,22 % | 17,10 % | −11,94 pt | [−38,67 pt ; −4,46 pt] | 0/5 | oui |
| Poisson | 53,25 % | 37,09 % | −10,13 pt | [−69,91 pt ; +15,78 pt] | 1/5 | non |
| Pétrole | 0,00 % | 0,00 % | +0,00 pt | [−0,01 pt ; +0,00 pt] | 0/5 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Minerai de fer | 0,00 % | 0,01 % | +0,01 pt | [−0,01 pt ; +0,20 pt] | 4/5 | non |
| Or | 0,00 % | 0,07 % | +0,07 pt | [+0,00 pt ; +0,23 pt] | 4/5 | non |
| Bauxite | 0,19 % | 0,06 % | +0,06 pt | [−2,25 pt ; +1,17 pt] | 3/5 | non |
| Cuivre | 0,16 % | 0,00 % | −0,16 pt | [−0,75 pt ; +0,01 pt] | 1/5 | non |
| Viande | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,32 pt] | 1/5 | non |
| Pain | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Plastique | 30,26 % | 34,13 % | +6,94 pt | [−11,80 pt ; +16,20 pt] | 3/5 | non |
| Acier | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Aluminium | 0,47 % | 0,00 % | −0,47 pt | [−1,52 pt ; +0,00 pt] | 0/5 | non |
| Électronique | 0,06 % | 0,00 % | −0,06 pt | [−1,49 pt ; +0,00 pt] | 0/5 | non |
| Processeurs | 78,42 % | 64,71 % | −15,67 pt | [−29,67 pt ; +41,33 pt] | 2/5 | non |
| Ordinateurs | 99,51 % | 99,78 % | +0,39 pt | [−0,15 pt ; +80,77 pt] | 3/5 | non |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Machines | 0,00 % | 0,00 % | +0,00 pt | [−0,30 pt ; +0,00 pt] | 0/5 | non |
| Réparations | 0,35 % | 0,16 % | −0,26 pt | [−0,34 pt ; +0,44 pt] | 1/5 | non |
| Ingénierie | 3,17 % | 2,38 % | −0,57 pt | [−1,46 pt ; −0,21 pt] | 0/5 | oui |
| Conception de puces | 0,14 % | 0,02 % | −0,14 pt | [−2,65 pt ; +0,04 pt] | 1/5 | non |
| Publicité | 0,06 % | 0,02 % | −0,04 pt | [−0,07 pt ; −0,01 pt] | 0/5 | oui |
| Comptabilité | 0,04 % | 0,06 % | +0,05 pt | [−0,02 pt ; +0,06 pt] | 4/5 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Télévision | 0,08 % | 0,02 % | −0,06 pt | [−0,10 pt ; −0,01 pt] | 0/5 | oui |
| Loisirs | 0,00 % | 0,00 % | −0,00 pt | [−0,03 pt ; +0,01 pt] | 1/5 | non |
| Hôtel | 3,26 % | 2,79 % | −0,17 pt | [−1,58 pt ; +0,92 pt] | 1/5 | non |
| Voyages | 4,22 % | 4,74 % | +0,56 pt | [−1,01 pt ; +1,15 pt] | 4/5 | non |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Logement | 0,22 % | 0,31 % | +0,12 pt | [+0,00 pt ; +0,25 pt] | 5/5 | oui |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 88,0 % | 87,4 % | +0,3 pt | [−2,2 pt ; +1,7 pt] | 3/5 | non |
| primaire : Herfindahl | 0,857 | 0,850 | +0,001 | [−0,025 ; +0,018] | 3/5 | non |
| primaire : vendeurs actifs par bien | 1,8 | 1,7 | −0,1 | [−0,1 ; +0,1] | 1/5 | non |
| primaire : dispersion des prix | 33,0 % | 30,8 % | −1,4 pt | [−9,6 pt ; +0,5 pt] | 1/5 | non |
| secondaire : part de la plus grande entreprise | 81,5 % | 76,1 % | −4,4 pt | [−5,9 pt ; −1,5 pt] | 0/5 | oui |
| secondaire : Herfindahl | 0,785 | 0,723 | −0,049 | [−0,065 ; −0,014] | 0/5 | oui |
| secondaire : vendeurs actifs par bien | 2,7 | 3,2 | +0,5 | [+0,2 ; +0,6] | 5/5 | oui |
| secondaire : dispersion des prix | 20,6 % | 24,1 % | +3,6 pt | [+1,1 pt ; +5,6 pt] | 5/5 | oui |
| tertiaire : part de la plus grande entreprise | 43,3 % | 36,7 % | −6,2 pt | [−7,9 pt ; −1,9 pt] | 0/5 | oui |
| tertiaire : Herfindahl | 0,388 | 0,322 | −0,066 | [−0,086 ; −0,035] | 0/5 | oui |
| tertiaire : vendeurs actifs par bien | 16,1 | 17,9 | +2,0 | [+1,4 ; +2,3] | 5/5 | oui |
| tertiaire : dispersion des prix | 26,9 % | 26,1 % | −1,1 pt | [−3,6 pt ; +6,6 pt] | 2/5 | non |

