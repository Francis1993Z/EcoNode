# Test de contrôle : k = 0 contre k > 0 (3 000 citoyens, k = 8)

- A : `c3000-k0.json` ; B : `c3000-k8.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 3000, sellerSample: 0}, B {population: 3000, sellerSample: 8}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 14,9 % | 10,7 % | −4,1 pt | [−11,4 pt ; +3,1 pt] | 3/10 | non |
| Faim moyenne | 2,6 % | 1,8 % | −0,5 pt | [−6,6 pt ; +6,9 pt] | 5/10 | non |
| Chômage moyen | 33,1 % | 30,1 % | −4,1 pt | [−13,5 pt ; +2,4 pt] | 4/10 | non |
| Demande non servie (unités non achetées / demandées) | 26,35 % | 15,20 % | −6,26 pt | [−17,49 pt ; −1,10 pt] | 2/10 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,279 | 1,249 | +0,012 | [−0,575 ; +0,437] | 5/10 | non |
| Inflation moyenne par jour | 0,03 % | 0,02 % | +0,00 pt | [−0,06 pt ; +0,04 pt] | 5/10 | non |
| Gini moyen | 0,781 | 0,741 | −0,044 | [−0,108 ; +0,017] | 3/10 | non |
| Santé moyenne | 0,384 | 0,597 | +0,142 | [+0,019 ; +0,346] | 8/10 | oui |
| Parc moyen d’entreprises | 123,5 | 132,8 | +8,9 | [+2,6 ; +13,7] | 8/10 | oui |
| Naissances d’entreprises (toute la partie) | 28,0 | 29,0 | −4,5 | [−7,5 ; +9,0] | 3/10 | non |
| Fermetures d’entreprises (toute la partie) | 353,0 | 351,5 | −13,0 | [−20,0 ; +7,5] | 2/10 | non |
| Morts par an, en % du parc moyen | 104,7 | 97,6 | −9,7 | [−16,5 ; −2,1] | 2/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 95,4 % | 95,7 % | +0,1 pt | [−1,1 pt ; +1,3 pt] | 5/10 | non |
| Herfindahl des ventes (médiane des biens) | 0,939 | 0,944 | +0,004 | [−0,014 ; +0,019] | 6/10 | non |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 16,1 % | 15,3 % | −0,3 pt | [−6,1 pt ; +1,8 pt] | 5/10 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 21,49 % | 30,60 % | +6,20 pt | [−1,76 pt ; +15,64 pt] | 6/10 | non |
| Bétail | 3,82 % | 0,00 % | −3,82 pt | [−29,57 pt ; +7,56 pt] | 3/10 | non |
| Poisson | 51,51 % | 42,09 % | −13,10 pt | [−31,22 pt ; +14,84 pt] | 3/10 | non |
| Pétrole | 0,00 % | 0,00 % | −0,00 pt | [−0,28 pt ; +0,00 pt] | 0/10 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,95 % | 0,31 % | −0,46 pt | [−1,51 pt ; +0,17 pt] | 3/10 | non |
| Or | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,05 pt] | 3/10 | non |
| Bauxite | 1,46 % | 2,46 % | −0,47 pt | [−4,49 pt ; +3,05 pt] | 3/10 | non |
| Cuivre | 15,35 % | 8,96 % | −5,52 pt | [−24,47 pt ; +9,17 pt] | 4/10 | non |
| Viande | 4,71 % | 0,11 % | −1,09 pt | [−5,28 pt ; −0,27 pt] | 1/10 | oui |
| Pain | 0,01 % | 0,02 % | +0,01 pt | [−0,18 pt ; +0,42 pt] | 5/10 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Plastique | 45,21 % | 23,90 % | −13,25 pt | [−36,80 pt ; +0,99 pt] | 2/10 | non |
| Acier | 0,05 % | 0,06 % | +0,02 pt | [−0,44 pt ; +0,71 pt] | 5/10 | non |
| Aluminium | 3,03 % | 0,43 % | −0,74 pt | [−10,68 pt ; +0,00 pt] | 2/10 | non |
| Électronique | 17,95 % | 3,69 % | −7,44 pt | [−18,55 pt ; +0,76 pt] | 3/10 | non |
| Processeurs | 91,50 % | 82,93 % | −11,62 pt | [−40,29 pt ; −2,53 pt] | 1/10 | oui |
| Ordinateurs | 99,76 % | 95,71 % | −3,01 pt | [−17,60 pt ; −0,80 pt] | 1/10 | oui |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,02 pt] | 5/10 | non |
| Machines | 0,15 % | 0,08 % | −0,13 pt | [−1,34 pt ; +0,08 pt] | 3/10 | non |
| Réparations | 9,37 % | 4,11 % | −2,65 pt | [−7,57 pt ; −0,38 pt] | 1/10 | oui |
| Ingénierie | 2,69 % | 2,85 % | +0,22 pt | [−1,95 pt ; +2,59 pt] | 5/10 | non |
| Conception de puces | 60,94 % | 56,81 % | −2,52 pt | [−40,27 pt ; +19,12 pt] | 3/10 | non |
| Publicité | 0,34 % | 0,23 % | −0,09 pt | [−0,20 pt ; +0,05 pt] | 3/10 | non |
| Comptabilité | 0,19 % | 0,20 % | −0,04 pt | [−0,15 pt ; +0,16 pt] | 5/10 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [−0,25 pt ; +0,15 pt] | 2/10 | non |
| Télévision | 0,08 % | 0,04 % | −0,04 pt | [−0,14 pt ; +0,05 pt] | 4/10 | non |
| Loisirs | 0,00 % | 0,00 % | −0,00 pt | [−0,01 pt ; +0,01 pt] | 3/10 | non |
| Hôtel | 4,52 % | 3,12 % | −1,38 pt | [−3,46 pt ; +0,50 pt] | 3/10 | non |
| Voyages | 4,41 % | 2,41 % | −1,15 pt | [−2,51 pt ; −0,05 pt] | 2/10 | oui |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 1,42 % | 0,81 % | −0,45 pt | [−0,98 pt ; +0,29 pt] | 4/10 | non |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 97,1 % | 97,7 % | +0,7 pt | [−0,0 pt ; +1,0 pt] | 8/10 | non |
| primaire : Herfindahl | 0,962 | 0,971 | +0,009 | [−0,001 ; +0,012] | 7/10 | non |
| primaire : vendeurs actifs par bien | 1,1 | 1,1 | −0,0 | [−0,0 ; +0,0] | 3/10 | non |
| primaire : dispersion des prix | 15,4 % | 15,3 % | −1,7 pt | [−5,8 pt ; +3,8 pt] | 4/10 | non |
| secondaire : part de la plus grande entreprise | 92,3 % | 92,2 % | −0,4 pt | [−1,3 pt ; +1,6 pt] | 3/10 | non |
| secondaire : Herfindahl | 0,908 | 0,910 | −0,003 | [−0,014 ; +0,020] | 4/10 | non |
| secondaire : vendeurs actifs par bien | 1,5 | 1,4 | −0,0 | [−0,1 ; +0,1] | 5/10 | non |
| secondaire : dispersion des prix | 25,6 % | 25,8 % | −0,3 pt | [−2,5 pt ; +7,0 pt] | 4/10 | non |
| tertiaire : part de la plus grande entreprise | 53,8 % | 53,7 % | +0,6 pt | [−4,4 pt ; +4,6 pt] | 5/10 | non |
| tertiaire : Herfindahl | 0,494 | 0,495 | −0,001 | [−0,046 ; +0,052] | 5/10 | non |
| tertiaire : vendeurs actifs par bien | 5,1 | 5,4 | +0,2 | [−0,1 ; +0,7] | 6/10 | non |
| tertiaire : dispersion des prix | 20,5 % | 24,7 % | +0,5 pt | [−2,8 pt ; +8,4 pt] | 5/10 | non |

