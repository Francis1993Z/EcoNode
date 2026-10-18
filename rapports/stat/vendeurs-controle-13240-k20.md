# Test de contrôle : k = 0 contre k > 0 (13 240 citoyens, k = 20)

- A : `c13240-k0.json` ; B : `c13240-k20.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 13240, sellerSample: 0}, B {population: 13240, sellerSample: 20}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 27,7 % | 27,2 % | −2,8 pt | [−8,0 pt ; +2,1 pt] | 2/5 | non |
| Faim moyenne | 50,7 % | 48,2 % | −2,2 pt | [−3,9 pt ; +0,3 pt] | 1/5 | non |
| Chômage moyen | 62,2 % | 60,7 % | −1,2 pt | [−3,1 pt ; +0,6 pt] | 1/5 | non |
| Demande non servie (unités non achetées / demandées) | 42,43 % | 40,34 % | −2,23 pt | [−3,97 pt ; +0,88 pt] | 1/5 | non |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,926 | 1,991 | +0,003 | [−0,564 ; +0,333] | 3/5 | non |
| Inflation moyenne par jour | 0,07 % | 0,08 % | +0,00 pt | [−0,03 pt ; +0,02 pt] | 3/5 | non |
| Gini moyen | 0,881 | 0,876 | −0,006 | [−0,021 ; +0,004] | 1/5 | non |
| Santé moyenne | 0,288 | 0,312 | +0,029 | [−0,016 ; +0,039] | 3/5 | non |
| Parc moyen d’entreprises | 447,2 | 462,3 | +20,7 | [+2,4 ; +33,8] | 5/5 | oui |
| Naissances d’entreprises (toute la partie) | 8,0 | 7,0 | −1,0 | [−9,0 ; +3,0] | 2/5 | non |
| Fermetures d’entreprises (toute la partie) | 1487,0 | 1474,0 | −10,0 | [−29,0 ; +8,0] | 2/5 | non |
| Morts par an, en % du parc moyen | 119,8 | 116,9 | −4,8 | [−11,1 ; −1,8] | 0/5 | oui |
| Part de la plus grande entreprise (médiane des biens) | 81,0 % | 80,8 % | +0,1 pt | [−5,9 pt ; +4,4 pt] | 3/5 | non |
| Herfindahl des ventes (médiane des biens) | 0,765 | 0,761 | −0,005 | [−0,074 ; +0,077] | 2/5 | non |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 21,3 % | 21,1 % | −2,8 pt | [−5,4 pt ; +0,1 pt] | 1/5 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 0,00 % | 0,00 % | +0,00 pt | [−0,07 pt ; +0,60 pt] | 1/5 | non |
| Bétail | 28,22 % | 24,58 % | −3,60 pt | [−19,46 pt ; +7,48 pt] | 1/5 | non |
| Poisson | 53,25 % | 31,08 % | +2,93 pt | [−34,65 pt ; +11,52 pt] | 3/5 | non |
| Pétrole | 0,00 % | 0,00 % | +0,00 pt | [−0,01 pt ; +0,00 pt] | 0/5 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Minerai de fer | 0,00 % | 0,00 % | −0,00 pt | [−0,01 pt ; +0,00 pt] | 1/5 | non |
| Or | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Bauxite | 0,19 % | 0,00 % | +0,00 pt | [−2,26 pt ; +2,85 pt] | 2/5 | non |
| Cuivre | 0,16 % | 0,28 % | +0,27 pt | [−0,75 pt ; +1,00 pt] | 3/5 | non |
| Viande | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Pain | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Plastique | 30,26 % | 27,46 % | +0,65 pt | [−3,41 pt ; +12,00 pt] | 3/5 | non |
| Acier | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Aluminium | 0,47 % | 0,00 % | +0,00 pt | [−1,52 pt ; +0,41 pt] | 2/5 | non |
| Électronique | 0,06 % | 0,04 % | +0,04 pt | [−1,49 pt ; +4,63 pt] | 3/5 | non |
| Processeurs | 78,42 % | 83,59 % | +6,54 pt | [−31,62 pt ; +23,67 pt] | 4/5 | non |
| Ordinateurs | 99,51 % | 99,73 % | +0,28 pt | [−0,22 pt ; +80,59 pt] | 3/5 | non |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Machines | 0,00 % | 0,00 % | +0,00 pt | [−0,28 pt ; +0,00 pt] | 0/5 | non |
| Réparations | 0,35 % | 0,09 % | −0,05 pt | [−0,59 pt ; +3,86 pt] | 2/5 | non |
| Ingénierie | 3,17 % | 3,53 % | −0,14 pt | [−0,86 pt ; +0,73 pt] | 2/5 | non |
| Conception de puces | 0,14 % | 0,12 % | −0,02 pt | [−2,64 pt ; +1,28 pt] | 2/5 | non |
| Publicité | 0,06 % | 0,05 % | −0,01 pt | [−0,03 pt ; +0,02 pt] | 1/5 | non |
| Comptabilité | 0,04 % | 0,06 % | +0,00 pt | [−0,07 pt ; +0,09 pt] | 3/5 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Télévision | 0,08 % | 0,04 % | −0,02 pt | [−0,10 pt ; +0,11 pt] | 2/5 | non |
| Loisirs | 0,00 % | 0,00 % | −0,00 pt | [−0,03 pt ; +0,01 pt] | 2/5 | non |
| Hôtel | 3,26 % | 1,69 % | −0,92 pt | [−2,83 pt ; −0,18 pt] | 0/5 | oui |
| Voyages | 4,22 % | 4,08 % | −0,13 pt | [−1,76 pt ; +1,49 pt] | 2/5 | non |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Logement | 0,22 % | 0,29 % | +0,06 pt | [−0,03 pt ; +0,15 pt] | 3/5 | non |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 88,0 % | 88,8 % | +1,4 pt | [−0,3 pt ; +2,7 pt] | 4/5 | non |
| primaire : Herfindahl | 0,857 | 0,867 | +0,017 | [−0,005 ; +0,031] | 4/5 | non |
| primaire : vendeurs actifs par bien | 1,8 | 1,7 | −0,0 | [−0,1 ; +0,0] | 1/5 | non |
| primaire : dispersion des prix | 33,0 % | 30,9 % | −1,5 pt | [−14,5 pt ; −0,4 pt] | 0/5 | oui |
| secondaire : part de la plus grande entreprise | 81,5 % | 78,9 % | −2,4 pt | [−4,1 pt ; +2,8 pt] | 1/5 | non |
| secondaire : Herfindahl | 0,785 | 0,754 | −0,027 | [−0,043 ; +0,032] | 1/5 | non |
| secondaire : vendeurs actifs par bien | 2,7 | 2,9 | +0,2 | [−0,2 ; +0,4] | 4/5 | non |
| secondaire : dispersion des prix | 20,6 % | 22,3 % | +1,0 pt | [−2,1 pt ; +2,8 pt] | 4/5 | non |
| tertiaire : part de la plus grande entreprise | 43,3 % | 40,9 % | −2,4 pt | [−5,2 pt ; −1,3 pt] | 0/5 | oui |
| tertiaire : Herfindahl | 0,388 | 0,364 | −0,023 | [−0,053 ; −0,019] | 0/5 | oui |
| tertiaire : vendeurs actifs par bien | 16,1 | 16,8 | +1,2 | [−0,1 ; +1,4] | 4/5 | non |
| tertiaire : dispersion des prix | 26,9 % | 24,6 % | +0,1 pt | [−2,9 pt ; +3,7 pt] | 3/5 | non |

