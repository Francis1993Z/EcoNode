# Test de contrôle : k = 0 contre k > 0 (13 240 citoyens, k = 5, graines 1 à 5)

- A : `c13240-k0.json` ; B : `c13240-k5s5.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 13240, sellerSample: 0}, B {population: 13240, sellerSample: 5}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 27,7 % | 3,0 % | −24,7 pt | [−30,8 pt ; −17,9 pt] | 0/5 | oui |
| Faim moyenne | 50,7 % | 0,2 % | −50,4 pt | [−50,9 pt ; −47,7 pt] | 0/5 | oui |
| Chômage moyen | 62,2 % | 24,4 % | −36,1 pt | [−38,5 pt ; −32,0 pt] | 0/5 | oui |
| Demande non servie (unités non achetées / demandées) | 42,43 % | 0,33 % | −40,00 pt | [−42,20 pt ; −37,44 pt] | 0/5 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,926 | 0,688 | −1,238 | [−1,996 ; −0,832] | 0/5 | oui |
| Inflation moyenne par jour | 0,07 % | -0,04 % | −0,11 pt | [−0,18 pt ; −0,08 pt] | 0/5 | oui |
| Gini moyen | 0,881 | 0,689 | −0,192 | [−0,199 ; −0,160] | 0/5 | oui |
| Santé moyenne | 0,288 | 0,882 | +0,563 | [+0,495 ; +0,593] | 5/5 | oui |
| Parc moyen d’entreprises | 447,2 | 584,1 | +136,9 | [+131,1 ; +154,6] | 5/5 | oui |
| Naissances d’entreprises (toute la partie) | 8,0 | 15,0 | +1,0 | [−4,0 ; +13,0] | 3/5 | non |
| Fermetures d’entreprises (toute la partie) | 1487,0 | 1262,0 | −218,0 | [−253,0 ; −195,0] | 0/5 | oui |
| Morts par an, en % du parc moyen | 119,8 | 78,9 | −41,0 | [−47,7 ; −39,5] | 0/5 | oui |
| Part de la plus grande entreprise (médiane des biens) | 81,0 % | 86,1 % | +5,7 pt | [+4,1 pt ; +6,4 pt] | 5/5 | oui |
| Herfindahl des ventes (médiane des biens) | 0,765 | 0,834 | +0,071 | [+0,060 ; +0,098] | 5/5 | oui |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 21,3 % | 23,3 % | +1,3 pt | [−4,7 pt ; +6,9 pt] | 4/5 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 0,00 % | 0,24 % | +0,24 pt | [+0,00 pt ; +1,79 pt] | 4/5 | non |
| Bétail | 28,22 % | 0,00 % | −28,22 pt | [−44,04 pt ; −26,67 pt] | 0/5 | oui |
| Poisson | 53,25 % | 15,16 % | −43,21 pt | [−75,04 pt ; +1,13 pt] | 1/5 | non |
| Pétrole | 0,00 % | 0,00 % | +0,00 pt | [−0,01 pt ; +0,00 pt] | 0/5 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Minerai de fer | 0,00 % | 0,21 % | +0,20 pt | [−0,00 pt ; +0,37 pt] | 4/5 | non |
| Or | 0,00 % | 0,40 % | +0,40 pt | [+0,21 pt ; +1,72 pt] | 5/5 | oui |
| Bauxite | 0,19 % | 0,72 % | +0,20 pt | [−0,62 pt ; +1,38 pt] | 4/5 | non |
| Cuivre | 0,16 % | 0,33 % | −0,00 pt | [−0,42 pt ; +0,34 pt] | 2/5 | non |
| Viande | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Pain | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Plastique | 30,26 % | 14,97 % | −15,09 pt | [−20,71 pt ; −2,35 pt] | 0/5 | oui |
| Acier | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Aluminium | 0,47 % | 0,19 % | −0,23 pt | [−1,32 pt ; +0,20 pt] | 2/5 | non |
| Électronique | 0,06 % | 0,06 % | +0,00 pt | [−1,33 pt ; +0,04 pt] | 2/5 | non |
| Processeurs | 78,42 % | 77,00 % | −8,61 pt | [−65,01 pt ; +44,04 pt] | 2/5 | non |
| Ordinateurs | 99,51 % | 87,53 % | −12,31 pt | [−90,73 pt ; +75,39 pt] | 1/5 | non |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Machines | 0,00 % | 0,00 % | +0,00 pt | [−0,30 pt ; +0,00 pt] | 0/5 | non |
| Réparations | 0,35 % | 0,00 % | −0,33 pt | [−0,57 pt ; −0,09 pt] | 0/5 | oui |
| Ingénierie | 3,17 % | 1,10 % | −1,78 pt | [−2,57 pt ; −1,49 pt] | 0/5 | oui |
| Conception de puces | 0,14 % | 0,47 % | +0,32 pt | [−2,59 pt ; +2,00 pt] | 4/5 | non |
| Publicité | 0,06 % | 0,00 % | −0,06 pt | [−0,08 pt ; −0,03 pt] | 0/5 | oui |
| Comptabilité | 0,04 % | 0,19 % | +0,09 pt | [+0,03 pt ; +0,35 pt] | 5/5 | oui |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Télévision | 0,08 % | 0,01 % | −0,07 pt | [−0,13 pt ; −0,02 pt] | 0/5 | oui |
| Loisirs | 0,00 % | 0,00 % | −0,00 pt | [−0,03 pt ; +0,00 pt] | 1/5 | non |
| Hôtel | 3,26 % | 1,81 % | −1,50 pt | [−2,18 pt ; +0,68 pt] | 1/5 | non |
| Voyages | 4,22 % | 1,85 % | −2,22 pt | [−3,78 pt ; −2,07 pt] | 0/5 | oui |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Logement | 0,22 % | 0,88 % | +0,66 pt | [+0,38 pt ; +0,69 pt] | 5/5 | oui |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 88,0 % | 87,9 % | +0,4 pt | [−0,4 pt ; +1,2 pt] | 3/5 | non |
| primaire : Herfindahl | 0,857 | 0,857 | +0,006 | [−0,004 ; +0,014] | 3/5 | non |
| primaire : vendeurs actifs par bien | 1,8 | 1,8 | −0,0 | [−0,1 ; +0,0] | 1/5 | non |
| primaire : dispersion des prix | 33,0 % | 22,6 % | −10,4 pt | [−18,6 pt ; +1,9 pt] | 1/5 | non |
| secondaire : part de la plus grande entreprise | 81,5 % | 74,4 % | −7,1 pt | [−7,6 pt ; −2,0 pt] | 0/5 | oui |
| secondaire : Herfindahl | 0,785 | 0,715 | −0,070 | [−0,079 ; −0,016] | 0/5 | oui |
| secondaire : vendeurs actifs par bien | 2,7 | 5,4 | +2,7 | [+2,0 ; +2,9] | 5/5 | oui |
| secondaire : dispersion des prix | 20,6 % | 33,6 % | +12,8 pt | [+12,6 pt ; +14,2 pt] | 5/5 | oui |
| tertiaire : part de la plus grande entreprise | 43,3 % | 29,5 % | −13,3 pt | [−16,6 pt ; −11,5 pt] | 0/5 | oui |
| tertiaire : Herfindahl | 0,388 | 0,264 | −0,119 | [−0,148 ; −0,107] | 0/5 | oui |
| tertiaire : vendeurs actifs par bien | 16,1 | 24,8 | +8,7 | [+8,3 ; +10,2] | 5/5 | oui |
| tertiaire : dispersion des prix | 26,9 % | 31,5 % | +4,6 pt | [−0,3 pt ; +13,9 pt] | 4/5 | non |

## Avec filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 37,4 % | 5,1 % | −31,2 pt | [−34,8 pt ; −30,4 pt] | 0/5 | oui |
| Faim moyenne | 35,4 % | 0,5 % | −34,6 pt | [−35,7 pt ; −34,1 pt] | 0/5 | oui |
| Chômage moyen | 63,4 % | 28,1 % | −35,1 pt | [−42,3 pt ; −33,7 pt] | 0/5 | oui |
| Demande non servie (unités non achetées / demandées) | 41,77 % | 1,39 % | −38,41 pt | [−41,05 pt ; −36,14 pt] | 0/5 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,864 | 0,662 | −1,272 | [−1,526 ; −0,830] | 0/5 | oui |
| Inflation moyenne par jour | 0,07 % | -0,05 % | −0,13 pt | [−0,15 pt ; −0,08 pt] | 0/5 | oui |
| Gini moyen | 0,869 | 0,708 | −0,157 | [−0,208 ; −0,149] | 0/5 | oui |
| Santé moyenne | 0,310 | 0,861 | +0,545 | [+0,476 ; +0,565] | 5/5 | oui |
| Parc moyen d’entreprises | 472,5 | 630,2 | +159,2 | [+147,8 ; +164,3] | 5/5 | oui |
| Naissances d’entreprises (toute la partie) | 4,0 | 10,0 | +8,0 | [+1,0 ; +9,0] | 5/5 | oui |
| Fermetures d’entreprises (toute la partie) | 1482,0 | 1239,0 | −239,0 | [−263,0 ; −230,0] | 0/5 | oui |
| Morts par an, en % du parc moyen | 114,5 | 71,8 | −42,9 | [−45,4 ; −39,9] | 0/5 | oui |
| Part de la plus grande entreprise (médiane des biens) | 80,8 % | 86,4 % | +5,5 pt | [+1,5 pt ; +11,5 pt] | 5/5 | oui |
| Herfindahl des ventes (médiane des biens) | 0,769 | 0,834 | +0,065 | [+0,033 ; +0,143] | 5/5 | oui |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 24,6 % | 30,5 % | +5,9 pt | [+1,8 pt ; +14,6 pt] | 5/5 | oui |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 0,00 % | 1,81 % | +1,81 pt | [+0,38 pt ; +3,53 pt] | 5/5 | oui |
| Bétail | 22,04 % | 0,00 % | −22,04 pt | [−27,92 pt ; +0,00 pt] | 0/5 | non |
| Poisson | 36,69 % | 7,80 % | −34,27 pt | [−41,97 pt ; −3,06 pt] | 0/5 | oui |
| Pétrole | 0,00 % | 0,00 % | +0,00 pt | [−0,10 pt ; +0,00 pt] | 0/5 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Minerai de fer | 0,00 % | 0,25 % | +0,25 pt | [+0,05 pt ; +0,56 pt] | 5/5 | oui |
| Or | 0,00 % | 0,33 % | +0,23 pt | [+0,11 pt ; +0,87 pt] | 5/5 | oui |
| Bauxite | 0,00 % | 0,39 % | +0,39 pt | [+0,20 pt ; +1,04 pt] | 5/5 | oui |
| Cuivre | 0,44 % | 0,12 % | −0,22 pt | [−1,18 pt ; +0,85 pt] | 1/5 | non |
| Viande | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Pain | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Plastique | 10,68 % | 4,69 % | −4,60 pt | [−18,36 pt ; +0,56 pt] | 1/5 | non |
| Acier | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,12 pt] | 2/5 | non |
| Aluminium | 0,00 % | 0,07 % | +0,07 pt | [−1,32 pt ; +0,24 pt] | 3/5 | non |
| Électronique | 0,11 % | 0,00 % | −0,06 pt | [−0,67 pt ; +0,39 pt] | 1/5 | non |
| Processeurs | 63,90 % | 23,49 % | −9,44 pt | [−52,67 pt ; +2,88 pt] | 1/5 | non |
| Ordinateurs | 99,37 % | 12,96 % | −42,22 pt | [−91,14 pt ; −15,57 pt] | 0/5 | oui |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Machines | 0,00 % | 0,00 % | +0,00 pt | [−0,04 pt ; +0,00 pt] | 0/5 | non |
| Réparations | 0,10 % | 0,00 % | −0,05 pt | [−0,17 pt ; +0,09 pt] | 1/5 | non |
| Ingénierie | 2,85 % | 1,75 % | −1,64 pt | [−1,96 pt ; −0,89 pt] | 0/5 | oui |
| Conception de puces | 0,06 % | 0,00 % | −0,06 pt | [−1,86 pt ; −0,01 pt] | 0/5 | oui |
| Publicité | 0,02 % | 0,00 % | −0,02 pt | [−0,03 pt ; −0,00 pt] | 0/5 | oui |
| Comptabilité | 0,01 % | 0,05 % | +0,04 pt | [+0,01 pt ; +0,07 pt] | 5/5 | oui |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Télévision | 0,04 % | 0,01 % | −0,03 pt | [−0,10 pt ; −0,01 pt] | 0/5 | oui |
| Loisirs | 0,01 % | 0,00 % | −0,01 pt | [−0,03 pt ; −0,00 pt] | 0/5 | oui |
| Hôtel | 2,12 % | 1,92 % | +0,06 pt | [−1,76 pt ; +0,73 pt] | 3/5 | non |
| Voyages | 4,28 % | 2,36 % | −2,00 pt | [−4,07 pt ; −0,04 pt] | 0/5 | oui |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |
| Logement | 0,65 % | 0,81 % | +0,09 pt | [−0,02 pt ; +0,37 pt] | 4/5 | non |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/5 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 87,3 % | 88,3 % | +0,8 pt | [−0,5 pt ; +4,9 pt] | 3/5 | non |
| primaire : Herfindahl | 0,848 | 0,862 | +0,012 | [−0,005 ; +0,061] | 3/5 | non |
| primaire : vendeurs actifs par bien | 1,8 | 1,7 | −0,1 | [−0,3 ; −0,0] | 0/5 | oui |
| primaire : dispersion des prix | 31,7 % | 34,3 % | +1,3 pt | [−2,9 pt ; +9,3 pt] | 3/5 | non |
| secondaire : part de la plus grande entreprise | 81,7 % | 74,1 % | −7,7 pt | [−8,3 pt ; −5,4 pt] | 0/5 | oui |
| secondaire : Herfindahl | 0,786 | 0,710 | −0,078 | [−0,089 ; −0,056] | 0/5 | oui |
| secondaire : vendeurs actifs par bien | 2,8 | 5,8 | +2,9 | [+2,6 ; +3,4] | 5/5 | oui |
| secondaire : dispersion des prix | 21,6 % | 36,4 % | +13,7 pt | [+8,3 pt ; +17,3 pt] | 5/5 | oui |
| tertiaire : part de la plus grande entreprise | 43,9 % | 28,6 % | −14,9 pt | [−17,9 pt ; −12,4 pt] | 0/5 | oui |
| tertiaire : Herfindahl | 0,392 | 0,257 | −0,139 | [−0,163 ; −0,113] | 0/5 | oui |
| tertiaire : vendeurs actifs par bien | 16,2 | 26,7 | +10,3 | [+10,2 ; +11,2] | 5/5 | oui |
| tertiaire : dispersion des prix | 30,3 % | 35,9 % | +3,2 pt | [+3,0 pt ; +10,3 pt] | 5/5 | oui |

