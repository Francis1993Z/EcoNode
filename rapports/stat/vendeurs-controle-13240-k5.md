# Test de contrôle : k = 0 contre k > 0 (13 240 citoyens, k = 5)

- A : `c13240-k0.json` ; B : `c13240-k5.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 13240, sellerSample: 0}, B {population: 13240, sellerSample: 5}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 31,3 % | 3,0 % | −27,7 pt | [−29,8 pt ; −24,5 pt] | 0/10 | oui |
| Faim moyenne | 50,7 % | 0,2 % | −50,4 pt | [−50,6 pt ; −49,7 pt] | 0/10 | oui |
| Chômage moyen | 62,2 % | 24,0 % | −38,4 pt | [−42,4 pt ; −34,4 pt] | 0/10 | oui |
| Demande non servie (unités non achetées / demandées) | 41,48 % | 0,34 % | −40,11 pt | [−41,76 pt ; −39,83 pt] | 0/10 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,988 | 0,585 | −1,355 | [−1,759 ; −1,221] | 0/10 | oui |
| Inflation moyenne par jour | 0,08 % | -0,06 % | −0,13 pt | [−0,17 pt ; −0,11 pt] | 0/10 | oui |
| Gini moyen | 0,879 | 0,683 | −0,196 | [−0,217 ; −0,185] | 0/10 | oui |
| Santé moyenne | 0,306 | 0,882 | +0,568 | [+0,553 ; +0,582] | 10/10 | oui |
| Parc moyen d’entreprises | 448,4 | 590,9 | +143,4 | [+131,8 ; +154,6] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 8,5 | 13,5 | +2,0 | [+0,0 ; +11,0] | 7/10 | non |
| Fermetures d’entreprises (toute la partie) | 1486,0 | 1250,5 | −239,0 | [−249,0 ; −218,0] | 0/10 | oui |
| Morts par an, en % du parc moyen | 121,1 | 77,2 | −44,7 | [−46,4 ; −41,0] | 0/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 83,0 % | 86,2 % | +3,8 pt | [+1,3 pt ; +5,8 pt] | 9/10 | oui |
| Herfindahl des ventes (médiane des biens) | 0,798 | 0,833 | +0,045 | [+0,011 ; +0,075] | 8/10 | oui |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 21,2 % | 21,8 % | +0,6 pt | [−3,6 pt ; +4,1 pt] | 6/10 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 0,00 % | 0,30 % | +0,24 pt | [+0,12 pt ; +0,76 pt] | 8/10 | oui |
| Bétail | 33,02 % | 0,00 % | −33,02 pt | [−36,62 pt ; −28,22 pt] | 0/10 | oui |
| Poisson | 49,19 % | 16,41 % | −29,04 pt | [−52,76 pt ; −5,16 pt] | 1/10 | oui |
| Pétrole | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,00 % | 0,06 % | +0,05 pt | [−0,00 pt ; +0,29 pt] | 7/10 | non |
| Or | 0,00 % | 0,43 % | +0,43 pt | [+0,28 pt ; +0,79 pt] | 10/10 | oui |
| Bauxite | 0,03 % | 0,29 % | +0,07 pt | [+0,03 pt ; +0,72 pt] | 9/10 | oui |
| Cuivre | 0,14 % | 0,00 % | −0,01 pt | [−0,24 pt ; +0,14 pt] | 3/10 | non |
| Viande | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Pain | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Plastique | 32,45 % | 14,29 % | −19,17 pt | [−22,60 pt ; −15,09 pt] | 0/10 | oui |
| Acier | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Aluminium | 0,03 % | 0,03 % | −0,02 pt | [−0,45 pt ; +0,10 pt] | 3/10 | non |
| Électronique | 0,07 % | 0,00 % | −0,05 pt | [−1,33 pt ; +0,02 pt] | 2/10 | non |
| Processeurs | 80,17 % | 58,04 % | −14,23 pt | [−61,91 pt ; +3,04 pt] | 3/10 | non |
| Ordinateurs | 99,70 % | 60,04 % | −16,17 pt | [−81,68 pt ; +4,85 pt] | 2/10 | non |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Machines | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Réparations | 0,29 % | 0,00 % | −0,28 pt | [−0,81 pt ; −0,14 pt] | 0/10 | oui |
| Ingénierie | 2,92 % | 1,02 % | −1,79 pt | [−2,21 pt ; −1,63 pt] | 0/10 | oui |
| Conception de puces | 0,09 % | 0,25 % | +0,09 pt | [−0,03 pt ; +0,32 pt] | 8/10 | non |
| Publicité | 0,06 % | 0,00 % | −0,05 pt | [−0,07 pt ; −0,03 pt] | 0/10 | oui |
| Comptabilité | 0,04 % | 0,15 % | +0,09 pt | [+0,05 pt ; +0,13 pt] | 10/10 | oui |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Télévision | 0,08 % | 0,01 % | −0,07 pt | [−0,11 pt ; −0,03 pt] | 0/10 | oui |
| Loisirs | 0,00 % | 0,00 % | −0,00 pt | [−0,02 pt ; −0,00 pt] | 1/10 | oui |
| Hôtel | 3,19 % | 1,89 % | −0,86 pt | [−2,12 pt ; +0,24 pt] | 3/10 | non |
| Voyages | 4,72 % | 1,70 % | −3,13 pt | [−3,66 pt ; −2,22 pt] | 0/10 | oui |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 0,25 % | 0,84 % | +0,63 pt | [+0,30 pt ; +0,74 pt] | 10/10 | oui |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 88,2 % | 87,6 % | −0,2 pt | [−0,9 pt ; +0,6 pt] | 4/10 | non |
| primaire : Herfindahl | 0,858 | 0,853 | −0,002 | [−0,010 ; +0,009] | 4/10 | non |
| primaire : vendeurs actifs par bien | 1,8 | 1,8 | −0,0 | [−0,1 ; +0,0] | 2/10 | non |
| primaire : dispersion des prix | 32,4 % | 23,0 % | −6,3 pt | [−11,7 pt ; +0,1 pt] | 2/10 | non |
| secondaire : part de la plus grande entreprise | 81,3 % | 74,2 % | −7,1 pt | [−7,5 pt ; −6,0 pt] | 0/10 | oui |
| secondaire : Herfindahl | 0,784 | 0,712 | −0,070 | [−0,079 ; −0,059] | 0/10 | oui |
| secondaire : vendeurs actifs par bien | 2,8 | 5,6 | +2,8 | [+2,4 ; +3,1] | 10/10 | oui |
| secondaire : dispersion des prix | 20,8 % | 34,4 % | +13,0 pt | [+12,7 pt ; +15,5 pt] | 10/10 | oui |
| tertiaire : part de la plus grande entreprise | 43,4 % | 29,8 % | −13,1 pt | [−14,5 pt ; −11,2 pt] | 0/10 | oui |
| tertiaire : Herfindahl | 0,391 | 0,266 | −0,121 | [−0,134 ; −0,107] | 0/10 | oui |
| tertiaire : vendeurs actifs par bien | 16,2 | 25,4 | +9,0 | [+8,7 ; +9,6] | 10/10 | oui |
| tertiaire : dispersion des prix | 25,6 % | 28,8 % | +2,4 pt | [+0,5 pt ; +6,0 pt] | 9/10 | oui |

## Avec filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 37,4 % | 4,4 % | −33,3 pt | [−34,6 pt ; −31,2 pt] | 0/10 | oui |
| Faim moyenne | 35,8 % | 0,6 % | −35,0 pt | [−35,6 pt ; −34,3 pt] | 0/10 | oui |
| Chômage moyen | 63,8 % | 27,1 % | −37,0 pt | [−41,9 pt ; −34,4 pt] | 0/10 | oui |
| Demande non servie (unités non achetées / demandées) | 41,80 % | 1,72 % | −40,09 pt | [−41,32 pt ; −38,20 pt] | 0/10 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,953 | 0,571 | −1,448 | [−1,506 ; −1,117] | 0/10 | oui |
| Inflation moyenne par jour | 0,07 % | -0,06 % | −0,14 pt | [−0,16 pt ; −0,10 pt] | 0/10 | oui |
| Gini moyen | 0,874 | 0,710 | −0,159 | [−0,206 ; −0,149] | 0/10 | oui |
| Santé moyenne | 0,306 | 0,859 | +0,548 | [+0,518 ; +0,568] | 10/10 | oui |
| Parc moyen d’entreprises | 468,4 | 634,1 | +163,7 | [+159,2 ; +172,7] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 3,5 | 6,5 | +2,0 | [+0,0 ; +8,0] | 7/10 | non |
| Fermetures d’entreprises (toute la partie) | 1486,5 | 1235,5 | −254,5 | [−263,0 ; −239,0] | 0/10 | oui |
| Morts par an, en % du parc moyen | 115,8 | 71,2 | −44,4 | [−47,0 ; −42,9] | 0/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 80,8 % | 85,7 % | +4,9 pt | [+2,5 pt ; +7,4 pt] | 10/10 | oui |
| Herfindahl des ventes (médiane des biens) | 0,770 | 0,827 | +0,056 | [+0,039 ; +0,095] | 10/10 | oui |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 24,3 % | 31,7 % | +7,2 pt | [+4,4 pt ; +10,3 pt] | 10/10 | oui |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 0,00 % | 1,16 % | +1,16 pt | [+0,22 pt ; +2,67 pt] | 9/10 | oui |
| Bétail | 22,49 % | 0,00 % | −22,49 pt | [−27,75 pt ; −9,20 pt] | 0/10 | oui |
| Poisson | 40,68 % | 7,35 % | −37,27 pt | [−44,21 pt ; −16,91 pt] | 0/10 | oui |
| Pétrole | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,00 % | 0,24 % | +0,24 pt | [+0,05 pt ; +0,34 pt] | 8/10 | oui |
| Or | 0,00 % | 0,28 % | +0,21 pt | [+0,14 pt ; +0,50 pt] | 10/10 | oui |
| Bauxite | 0,00 % | 0,41 % | +0,33 pt | [+0,00 pt ; +0,67 pt] | 8/10 | oui |
| Cuivre | 0,14 % | 0,05 % | −0,06 pt | [−0,36 pt ; +0,04 pt] | 3/10 | non |
| Viande | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Pain | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Plastique | 8,05 % | 4,68 % | −3,48 pt | [−11,17 pt ; +0,56 pt] | 4/10 | non |
| Acier | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,03 pt] | 3/10 | non |
| Aluminium | 0,00 % | 0,06 % | +0,00 pt | [−1,32 pt ; +0,07 pt] | 3/10 | non |
| Électronique | 0,00 % | 0,00 % | +0,00 pt | [−0,16 pt ; +0,00 pt] | 2/10 | non |
| Processeurs | 41,50 % | 17,85 % | −8,98 pt | [−40,41 pt ; +2,88 pt] | 3/10 | non |
| Ordinateurs | 99,45 % | 21,76 % | −59,44 pt | [−88,81 pt ; −29,59 pt] | 0/10 | oui |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Machines | 0,00 % | 0,00 % | +0,00 pt | [−0,02 pt ; +0,00 pt] | 0/10 | non |
| Réparations | 0,08 % | 0,00 % | −0,06 pt | [−0,17 pt ; −0,03 pt] | 1/10 | oui |
| Ingénierie | 2,82 % | 1,41 % | −1,46 pt | [−1,80 pt ; −1,03 pt] | 0/10 | oui |
| Conception de puces | 0,09 % | 0,00 % | −0,08 pt | [−0,99 pt ; −0,04 pt] | 1/10 | oui |
| Publicité | 0,02 % | 0,00 % | −0,02 pt | [−0,03 pt ; −0,01 pt] | 0/10 | oui |
| Comptabilité | 0,01 % | 0,05 % | +0,05 pt | [+0,02 pt ; +0,08 pt] | 10/10 | oui |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Télévision | 0,10 % | 0,00 % | −0,09 pt | [−0,12 pt ; −0,03 pt] | 0/10 | oui |
| Loisirs | 0,02 % | 0,00 % | −0,02 pt | [−0,03 pt ; −0,01 pt] | 0/10 | oui |
| Hôtel | 1,95 % | 1,75 % | −0,12 pt | [−0,63 pt ; +0,57 pt] | 4/10 | non |
| Voyages | 4,98 % | 2,07 % | −2,96 pt | [−3,88 pt ; −1,76 pt] | 0/10 | oui |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 0,63 % | 0,72 % | +0,09 pt | [−0,07 pt ; +0,37 pt] | 6/10 | non |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 87,4 % | 88,2 % | +0,9 pt | [−0,5 pt ; +3,1 pt] | 7/10 | non |
| primaire : Herfindahl | 0,849 | 0,862 | +0,013 | [−0,004 ; +0,041] | 7/10 | non |
| primaire : vendeurs actifs par bien | 1,8 | 1,7 | −0,1 | [−0,2 ; −0,1] | 0/10 | oui |
| primaire : dispersion des prix | 32,9 % | 35,2 % | +2,5 pt | [−1,7 pt ; +6,8 pt] | 6/10 | non |
| secondaire : part de la plus grande entreprise | 80,9 % | 74,2 % | −6,5 pt | [−7,9 pt ; −5,8 pt] | 0/10 | oui |
| secondaire : Herfindahl | 0,779 | 0,710 | −0,068 | [−0,080 ; −0,061] | 0/10 | oui |
| secondaire : vendeurs actifs par bien | 2,8 | 5,8 | +2,9 | [+2,7 ; +3,2] | 10/10 | oui |
| secondaire : dispersion des prix | 22,9 % | 36,2 % | +13,5 pt | [+11,6 pt ; +15,5 pt] | 10/10 | oui |
| tertiaire : part de la plus grande entreprise | 44,4 % | 28,6 % | −14,8 pt | [−16,9 pt ; −13,3 pt] | 0/10 | oui |
| tertiaire : Herfindahl | 0,394 | 0,257 | −0,138 | [−0,152 ; −0,124] | 0/10 | oui |
| tertiaire : vendeurs actifs par bien | 16,2 | 26,9 | +10,8 | [+10,3 ; +11,6] | 10/10 | oui |
| tertiaire : dispersion des prix | 30,2 % | 35,1 % | +4,2 pt | [+3,0 pt ; +10,2 pt] | 9/10 | oui |

