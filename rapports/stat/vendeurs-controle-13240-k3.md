# Test de contrôle : k = 0 contre k > 0 (13 240 citoyens, k = 3)

- A : `c13240-k0.json` ; B : `c13240-k3.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 13240, sellerSample: 0}, B {population: 13240, sellerSample: 3}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 27,7 % | 0,8 % | −27,2 pt | [−33,0 pt ; −25,1 pt] | 0/5 | oui |
| Faim moyenne | 50,7 % | 0,0 % | −50,6 pt | [−51,2 pt ; −47,8 pt] | 0/5 | oui |
| Chômage moyen | 62,2 % | 13,2 % | −48,8 pt | [−50,4 pt ; −46,9 pt] | 0/5 | oui |
| Demande non servie (unités non achetées / demandées) | 42,43 % | 0,16 % | −42,28 pt | [−43,05 pt ; −40,17 pt] | 0/5 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,926 | 0,447 | −1,518 | [−1,984 ; −1,005] | 0/5 | oui |
| Inflation moyenne par jour | 0,07 % | -0,09 % | −0,17 pt | [−0,18 pt ; −0,10 pt] | 0/5 | oui |
| Gini moyen | 0,881 | 0,552 | −0,327 | [−0,346 ; −0,287] | 0/5 | oui |
| Santé moyenne | 0,288 | 0,882 | +0,594 | [+0,563 ; +0,604] | 5/5 | oui |
| Parc moyen d’entreprises | 447,2 | 630,6 | +178,0 | [+176,5 ; +190,5] | 5/5 | oui |
| Naissances d’entreprises (toute la partie) | 8,0 | 6,0 | −3,0 | [−10,0 ; +5,0] | 1/5 | non |
| Fermetures d’entreprises (toute la partie) | 1487,0 | 1216,0 | −261,0 | [−283,0 ; −243,0] | 0/5 | oui |
| Morts par an, en % du parc moyen | 119,8 | 70,2 | −50,1 | [−53,8 ; −47,6] | 0/5 | oui |
| Part de la plus grande entreprise (médiane des biens) | 81,0 % | 81,8 % | +0,0 pt | [−2,0 pt ; +5,3 pt] | 3/5 | non |
| Herfindahl des ventes (médiane des biens) | 0,765 | 0,783 | +0,015 | [−0,022 ; +0,073] | 4/5 | non |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 21,3 % | 17,2 % | −5,0 pt | [−7,8 pt ; +7,7 pt] | 1/5 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 0,00 % | 0,00 % | +0,00 pt | [−0,07 pt ; +0,00 pt] | 0/5 | non |
| Bétail | 28,22 % | 0,00 % | −28,22 pt | [−44,04 pt ; −26,67 pt] | 0/5 | oui |
| Poisson | 53,25 % | 0,00 % | −53,25 pt | [−76,68 pt ; −14,03 pt] | 0/5 | oui |
| Pétrole | 0,00 % | 0,00 % | +0,00 pt | [−0,01 pt ; +0,00 pt] | 0/5 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Minerai de fer | 0,00 % | 0,00 % | −0,00 pt | [−0,01 pt ; +0,03 pt] | 1/5 | non |
| Or | 0,00 % | 0,14 % | +0,14 pt | [+0,10 pt ; +0,35 pt] | 5/5 | oui |
| Bauxite | 0,19 % | 0,00 % | −0,19 pt | [−0,72 pt ; +0,00 pt] | 0/5 | non |
| Cuivre | 0,16 % | 0,00 % | −0,16 pt | [−0,72 pt ; −0,00 pt] | 0/5 | oui |
| Viande | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Pain | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Plastique | 30,26 % | 10,03 % | −17,98 pt | [−27,53 pt ; −7,10 pt] | 0/5 | oui |
| Acier | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Aluminium | 0,47 % | 0,00 % | −0,47 pt | [−1,52 pt ; +0,00 pt] | 0/5 | non |
| Électronique | 0,06 % | 0,00 % | −0,03 pt | [−1,49 pt ; +0,00 pt] | 0/5 | non |
| Processeurs | 78,42 % | 14,23 % | −66,15 pt | [−72,63 pt ; −33,82 pt] | 0/5 | oui |
| Ordinateurs | 99,51 % | 28,10 % | −58,41 pt | [−87,39 pt ; −12,84 pt] | 0/5 | oui |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Machines | 0,00 % | 0,00 % | +0,00 pt | [−0,30 pt ; +0,00 pt] | 0/5 | non |
| Réparations | 0,35 % | 0,00 % | −0,35 pt | [−0,62 pt ; −0,09 pt] | 0/5 | oui |
| Ingénierie | 3,17 % | 0,88 % | −2,15 pt | [−2,79 pt ; −1,95 pt] | 0/5 | oui |
| Conception de puces | 0,14 % | 0,36 % | −0,08 pt | [−2,45 pt ; +0,44 pt] | 2/5 | non |
| Publicité | 0,06 % | 0,00 % | −0,06 pt | [−0,08 pt ; −0,03 pt] | 0/5 | oui |
| Comptabilité | 0,04 % | 0,10 % | +0,03 pt | [+0,02 pt ; +0,11 pt] | 5/5 | oui |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Télévision | 0,08 % | 0,00 % | −0,08 pt | [−0,13 pt ; −0,04 pt] | 0/5 | oui |
| Loisirs | 0,00 % | 0,00 % | −0,00 pt | [−0,04 pt ; −0,00 pt] | 0/5 | oui |
| Hôtel | 3,26 % | 0,83 % | −2,48 pt | [−3,10 pt ; −0,90 pt] | 0/5 | oui |
| Voyages | 4,22 % | 2,93 % | −1,22 pt | [−2,62 pt ; −0,66 pt] | 0/5 | oui |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Logement | 0,22 % | 0,05 % | −0,18 pt | [−0,28 pt ; −0,05 pt] | 0/5 | oui |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 88,0 % | 87,3 % | −0,1 pt | [−1,2 pt ; +2,1 pt] | 2/5 | non |
| primaire : Herfindahl | 0,857 | 0,850 | +0,000 | [−0,013 ; +0,024] | 3/5 | non |
| primaire : vendeurs actifs par bien | 1,8 | 1,7 | −0,1 | [−0,1 ; −0,0] | 0/5 | oui |
| primaire : dispersion des prix | 33,0 % | 26,3 % | −6,7 pt | [−13,0 pt ; −3,7 pt] | 0/5 | oui |
| secondaire : part de la plus grande entreprise | 81,5 % | 73,3 % | −7,9 pt | [−10,3 pt ; −4,3 pt] | 0/5 | oui |
| secondaire : Herfindahl | 0,785 | 0,705 | −0,081 | [−0,105 ; −0,032] | 0/5 | oui |
| secondaire : vendeurs actifs par bien | 2,7 | 6,7 | +4,0 | [+3,2 ; +4,2] | 5/5 | oui |
| secondaire : dispersion des prix | 20,6 % | 35,5 % | +16,1 pt | [+11,6 pt ; +22,8 pt] | 5/5 | oui |
| tertiaire : part de la plus grande entreprise | 43,3 % | 27,9 % | −14,9 pt | [−16,8 pt ; −13,7 pt] | 0/5 | oui |
| tertiaire : Herfindahl | 0,388 | 0,255 | −0,133 | [−0,155 ; −0,118] | 0/5 | oui |
| tertiaire : vendeurs actifs par bien | 16,1 | 28,6 | +12,7 | [+12,3 ; +13,1] | 5/5 | oui |
| tertiaire : dispersion des prix | 26,9 % | 32,0 % | +5,0 pt | [+2,8 pt ; +11,3 pt] | 5/5 | oui |

