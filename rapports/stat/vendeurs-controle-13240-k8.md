# Test de contrôle : k = 0 contre k > 0 (13 240 citoyens, k = 8)

- A : `c13240-k0.json` ; B : `c13240-k8.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 13240, sellerSample: 0}, B {population: 13240, sellerSample: 8}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 27,7 % | 16,5 % | −11,2 pt | [−17,1 pt ; −10,3 pt] | 0/5 | oui |
| Faim moyenne | 50,7 % | 24,2 % | −26,5 pt | [−30,7 pt ; −16,1 pt] | 0/5 | oui |
| Chômage moyen | 62,2 % | 45,3 % | −16,9 pt | [−20,9 pt ; −10,7 pt] | 0/5 | oui |
| Demande non servie (unités non achetées / demandées) | 42,43 % | 31,53 % | −11,36 pt | [−13,02 pt ; −5,81 pt] | 0/5 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,926 | 2,161 | +0,122 | [−0,201 ; +0,590] | 3/5 | non |
| Inflation moyenne par jour | 0,07 % | 0,09 % | +0,01 pt | [−0,01 pt ; +0,03 pt] | 3/5 | non |
| Gini moyen | 0,881 | 0,822 | −0,063 | [−0,075 ; −0,041] | 0/5 | oui |
| Santé moyenne | 0,288 | 0,348 | +0,062 | [+0,017 ; +0,075] | 5/5 | oui |
| Parc moyen d’entreprises | 447,2 | 522,7 | +75,4 | [+52,9 ; +90,1] | 5/5 | oui |
| Naissances d’entreprises (toute la partie) | 8,0 | 9,0 | +0,0 | [−7,0 ; +6,0] | 2/5 | non |
| Fermetures d’entreprises (toute la partie) | 1487,0 | 1433,0 | −44,0 | [−61,0 ; −39,0] | 0/5 | oui |
| Morts par an, en % du parc moyen | 119,8 | 99,6 | −20,1 | [−25,6 ; −16,4] | 0/5 | oui |
| Part de la plus grande entreprise (médiane des biens) | 81,0 % | 75,0 % | −6,9 pt | [−16,8 pt ; −2,5 pt] | 0/5 | oui |
| Herfindahl des ventes (médiane des biens) | 0,765 | 0,692 | −0,068 | [−0,199 ; −0,034] | 0/5 | oui |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 21,3 % | 18,7 % | −3,5 pt | [−5,5 pt ; +8,2 pt] | 1/5 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 0,00 % | 0,00 % | +0,00 pt | [−0,07 pt ; +0,00 pt] | 0/5 | non |
| Bétail | 28,22 % | 0,00 % | −28,22 pt | [−44,04 pt ; −26,67 pt] | 0/5 | oui |
| Poisson | 53,25 % | 47,03 % | −6,21 pt | [−28,07 pt ; +2,55 pt] | 2/5 | non |
| Pétrole | 0,00 % | 0,00 % | +0,00 pt | [−0,01 pt ; +0,00 pt] | 0/5 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Minerai de fer | 0,00 % | 0,13 % | +0,13 pt | [−0,01 pt ; +0,75 pt] | 3/5 | non |
| Or | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +2,42 pt] | 2/5 | non |
| Bauxite | 0,19 % | 0,40 % | +0,04 pt | [−1,38 pt ; +1,45 pt] | 3/5 | non |
| Cuivre | 0,16 % | 0,01 % | −0,00 pt | [−0,23 pt ; +2,91 pt] | 2/5 | non |
| Viande | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Pain | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Plastique | 30,26 % | 34,37 % | +4,57 pt | [−7,37 pt ; +12,38 pt] | 4/5 | non |
| Acier | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Aluminium | 0,47 % | 0,00 % | −0,47 pt | [−1,52 pt ; +0,00 pt] | 0/5 | non |
| Électronique | 0,06 % | 0,00 % | −0,01 pt | [−0,06 pt ; +1,99 pt] | 1/5 | non |
| Processeurs | 78,42 % | 62,37 % | −20,66 pt | [−41,59 pt ; +43,05 pt] | 1/5 | non |
| Ordinateurs | 99,51 % | 99,72 % | +0,37 pt | [−0,12 pt ; +65,16 pt] | 4/5 | non |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Machines | 0,00 % | 0,00 % | +0,00 pt | [−0,30 pt ; +0,00 pt] | 0/5 | non |
| Réparations | 0,35 % | 0,14 % | −0,01 pt | [−0,48 pt ; +0,48 pt] | 2/5 | non |
| Ingénierie | 3,17 % | 1,97 % | −1,20 pt | [−1,38 pt ; −0,77 pt] | 0/5 | oui |
| Conception de puces | 0,14 % | 0,13 % | +0,04 pt | [−2,64 pt ; +3,95 pt] | 4/5 | non |
| Publicité | 0,06 % | 0,00 % | −0,06 pt | [−0,07 pt ; −0,03 pt] | 0/5 | oui |
| Comptabilité | 0,04 % | 0,08 % | +0,02 pt | [−0,04 pt ; +0,11 pt] | 4/5 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Télévision | 0,08 % | 0,02 % | −0,05 pt | [−0,10 pt ; −0,01 pt] | 0/5 | oui |
| Loisirs | 0,00 % | 0,00 % | −0,00 pt | [−0,03 pt ; +0,00 pt] | 2/5 | non |
| Hôtel | 3,26 % | 2,01 % | −0,85 pt | [−2,03 pt ; +0,15 pt] | 1/5 | non |
| Voyages | 4,22 % | 4,39 % | +0,20 pt | [−1,68 pt ; +0,80 pt] | 3/5 | non |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Logement | 0,22 % | 0,29 % | +0,09 pt | [−0,09 pt ; +0,12 pt] | 4/5 | non |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 88,0 % | 87,2 % | −0,1 pt | [−1,4 pt ; +0,7 pt] | 1/5 | non |
| primaire : Herfindahl | 0,857 | 0,848 | −0,002 | [−0,016 ; +0,007] | 1/5 | non |
| primaire : vendeurs actifs par bien | 1,8 | 1,8 | +0,0 | [−0,0 ; +0,1] | 4/5 | non |
| primaire : dispersion des prix | 33,0 % | 21,3 % | −12,4 pt | [−13,7 pt ; −4,3 pt] | 0/5 | oui |
| secondaire : part de la plus grande entreprise | 81,5 % | 72,6 % | −8,1 pt | [−9,3 pt ; −4,9 pt] | 0/5 | oui |
| secondaire : Herfindahl | 0,785 | 0,687 | −0,092 | [−0,106 ; −0,051] | 0/5 | oui |
| secondaire : vendeurs actifs par bien | 2,7 | 4,1 | +1,3 | [+1,0 ; +1,6] | 5/5 | oui |
| secondaire : dispersion des prix | 20,6 % | 26,1 % | +6,0 pt | [+2,4 pt ; +9,3 pt] | 5/5 | oui |
| tertiaire : part de la plus grande entreprise | 43,3 % | 31,5 % | −11,2 pt | [−13,1 pt ; −10,0 pt] | 0/5 | oui |
| tertiaire : Herfindahl | 0,388 | 0,264 | −0,120 | [−0,139 ; −0,115] | 0/5 | oui |
| tertiaire : vendeurs actifs par bien | 16,1 | 20,7 | +4,5 | [+3,1 ; +4,7] | 5/5 | oui |
| tertiaire : dispersion des prix | 26,9 % | 26,8 % | +1,6 pt | [−3,5 pt ; +3,9 pt] | 4/5 | non |

