# Test de contrôle : k = 0 contre k > 0 (3 000 citoyens, k = 5)

- A : `c3000-k0.json` ; B : `c3000-k5.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 3000, sellerSample: 0}, B {population: 3000, sellerSample: 5}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 14,9 % | 10,2 % | −4,6 pt | [−14,9 pt ; +4,4 pt] | 3/10 | non |
| Faim moyenne | 2,6 % | 1,4 % | −0,1 pt | [−5,4 pt ; +4,1 pt] | 5/10 | non |
| Chômage moyen | 33,1 % | 28,4 % | −4,3 pt | [−16,7 pt ; +2,5 pt] | 3/10 | non |
| Demande non servie (unités non achetées / demandées) | 26,35 % | 11,27 % | −15,34 pt | [−22,13 pt ; +1,49 pt] | 3/10 | non |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,279 | 1,380 | +0,207 | [−0,412 ; +1,063] | 5/10 | non |
| Inflation moyenne par jour | 0,03 % | 0,04 % | +0,02 pt | [−0,05 pt ; +0,09 pt] | 5/10 | non |
| Gini moyen | 0,781 | 0,722 | −0,048 | [−0,135 ; −0,016] | 2/10 | oui |
| Santé moyenne | 0,384 | 0,667 | +0,300 | [−0,013 ; +0,419] | 7/10 | non |
| Parc moyen d’entreprises | 123,5 | 141,1 | +18,0 | [+8,4 ; +23,8] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 28,0 | 24,0 | −7,5 | [−17,0 ; +0,0] | 2/10 | non |
| Fermetures d’entreprises (toute la partie) | 353,0 | 325,5 | −30,5 | [−41,0 ; +3,0] | 3/10 | non |
| Morts par an, en % du parc moyen | 104,7 | 83,9 | −21,7 | [−27,3 ; −4,3] | 0/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 95,4 % | 95,5 % | +0,6 pt | [−1,6 pt ; +1,6 pt] | 6/10 | non |
| Herfindahl des ventes (médiane des biens) | 0,939 | 0,942 | +0,007 | [−0,020 ; +0,024] | 6/10 | non |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 16,1 % | 14,9 % | −0,9 pt | [−3,8 pt ; +1,6 pt] | 4/10 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 21,49 % | 25,40 % | +5,15 pt | [−8,97 pt ; +10,07 pt] | 6/10 | non |
| Bétail | 3,82 % | 0,00 % | −3,82 pt | [−29,57 pt ; +0,00 pt] | 1/10 | non |
| Poisson | 51,51 % | 32,36 % | −11,62 pt | [−30,09 pt ; +6,75 pt] | 3/10 | non |
| Pétrole | 0,00 % | 0,00 % | −0,00 pt | [−0,28 pt ; +0,00 pt] | 0/10 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,95 % | 0,26 % | −0,20 pt | [−2,94 pt ; +0,53 pt] | 5/10 | non |
| Or | 0,00 % | 0,18 % | +0,09 pt | [+0,00 pt ; +0,34 pt] | 7/10 | non |
| Bauxite | 1,46 % | 0,69 % | +0,17 pt | [−6,44 pt ; +1,52 pt] | 6/10 | non |
| Cuivre | 15,35 % | 0,63 % | −13,48 pt | [−30,59 pt ; −5,37 pt] | 0/10 | oui |
| Viande | 4,71 % | 4,67 % | +1,20 pt | [−2,86 pt ; +5,26 pt] | 6/10 | non |
| Pain | 0,01 % | 0,01 % | +0,00 pt | [−0,03 pt ; +0,25 pt] | 5/10 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Plastique | 45,21 % | 10,44 % | −34,99 pt | [−50,69 pt ; −16,51 pt] | 1/10 | oui |
| Acier | 0,05 % | 0,05 % | −0,00 pt | [−0,80 pt ; +0,04 pt] | 5/10 | non |
| Aluminium | 3,03 % | 0,23 % | −2,09 pt | [−11,26 pt ; −0,22 pt] | 2/10 | oui |
| Électronique | 17,95 % | 0,03 % | −17,95 pt | [−24,25 pt ; −5,78 pt] | 0/10 | oui |
| Processeurs | 91,50 % | 72,85 % | −15,18 pt | [−52,47 pt ; −7,36 pt] | 0/10 | oui |
| Ordinateurs | 99,76 % | 94,07 % | −5,77 pt | [−17,36 pt ; +0,48 pt] | 3/10 | non |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,01 pt] | 3/10 | non |
| Machines | 0,15 % | 0,04 % | −0,10 pt | [−1,37 pt ; +0,07 pt] | 3/10 | non |
| Réparations | 9,37 % | 0,07 % | −9,04 pt | [−11,24 pt ; −0,87 pt] | 1/10 | oui |
| Ingénierie | 2,69 % | 4,46 % | +2,08 pt | [+0,28 pt ; +2,98 pt] | 8/10 | oui |
| Conception de puces | 60,94 % | 10,48 % | −29,79 pt | [−73,59 pt ; −16,00 pt] | 1/10 | oui |
| Publicité | 0,34 % | 0,10 % | −0,22 pt | [−0,28 pt ; −0,04 pt] | 1/10 | oui |
| Comptabilité | 0,19 % | 0,26 % | +0,05 pt | [−0,13 pt ; +0,21 pt] | 6/10 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [−0,25 pt ; +0,00 pt] | 1/10 | non |
| Télévision | 0,08 % | 0,01 % | −0,07 pt | [−0,15 pt ; +0,00 pt] | 3/10 | non |
| Loisirs | 0,00 % | 0,00 % | −0,00 pt | [−0,01 pt ; +0,01 pt] | 4/10 | non |
| Hôtel | 4,52 % | 2,36 % | −2,07 pt | [−4,90 pt ; −0,50 pt] | 2/10 | oui |
| Voyages | 4,41 % | 1,76 % | −2,63 pt | [−3,83 pt ; +0,15 pt] | 3/10 | non |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 1,42 % | 0,66 % | −0,55 pt | [−1,16 pt ; +0,01 pt] | 2/10 | non |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 97,1 % | 98,1 % | +0,9 pt | [−0,0 pt ; +1,5 pt] | 7/10 | non |
| primaire : Herfindahl | 0,962 | 0,975 | +0,012 | [−0,000 ; +0,018] | 7/10 | non |
| primaire : vendeurs actifs par bien | 1,1 | 1,1 | −0,0 | [−0,0 ; −0,0] | 2/10 | oui |
| primaire : dispersion des prix | 15,4 % | 13,5 % | −1,4 pt | [−4,7 pt ; +5,5 pt] | 5/10 | non |
| secondaire : part de la plus grande entreprise | 92,3 % | 91,4 % | −0,7 pt | [−2,3 pt ; +0,7 pt] | 4/10 | non |
| secondaire : Herfindahl | 0,908 | 0,898 | −0,008 | [−0,026 ; +0,005] | 3/10 | non |
| secondaire : vendeurs actifs par bien | 1,5 | 1,5 | +0,0 | [−0,1 ; +0,1] | 5/10 | non |
| secondaire : dispersion des prix | 25,6 % | 25,1 % | −0,7 pt | [−2,4 pt ; +4,4 pt] | 4/10 | non |
| tertiaire : part de la plus grande entreprise | 53,8 % | 52,3 % | −0,9 pt | [−3,0 pt ; +0,7 pt] | 4/10 | non |
| tertiaire : Herfindahl | 0,494 | 0,475 | −0,014 | [−0,032 ; +0,005] | 4/10 | non |
| tertiaire : vendeurs actifs par bien | 5,1 | 5,6 | +0,5 | [−0,1 ; +0,9] | 7/10 | non |
| tertiaire : dispersion des prix | 20,5 % | 28,2 % | +6,0 pt | [+1,0 pt ; +9,4 pt] | 9/10 | oui |

## Avec filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 10,3 % | 4,5 % | −1,1 pt | [−9,2 pt ; +2,3 pt] | 4/10 | non |
| Faim moyenne | 0,0 % | 0,1 % | +0,1 pt | [−4,7 pt ; +2,5 pt] | 8/10 | non |
| Chômage moyen | 31,7 % | 25,5 % | −4,0 pt | [−12,7 pt ; +4,4 pt] | 4/10 | non |
| Demande non servie (unités non achetées / demandées) | 22,72 % | 6,19 % | −12,75 pt | [−18,09 pt ; −2,59 pt] | 2/10 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,528 | 0,807 | −0,489 | [−1,124 ; −0,046] | 2/10 | oui |
| Inflation moyenne par jour | 0,05 % | -0,02 % | −0,05 pt | [−0,12 pt ; +0,01 pt] | 2/10 | non |
| Gini moyen | 0,714 | 0,683 | −0,008 | [−0,103 ; +0,049] | 5/10 | non |
| Santé moyenne | 0,414 | 0,754 | +0,266 | [+0,045 ; +0,397] | 8/10 | oui |
| Parc moyen d’entreprises | 136,1 | 153,1 | +16,5 | [+11,3 ; +18,5] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 12,0 | 12,5 | +3,0 | [−3,0 ; +5,5] | 6/10 | non |
| Fermetures d’entreprises (toute la partie) | 324,5 | 302,5 | −20,0 | [−29,0 ; −10,0] | 1/10 | oui |
| Morts par an, en % du parc moyen | 87,4 | 72,0 | −14,7 | [−16,7 ; −9,2] | 0/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 96,3 % | 95,4 % | −1,0 pt | [−1,4 pt ; +0,2 pt] | 3/10 | non |
| Herfindahl des ventes (médiane des biens) | 0,951 | 0,941 | −0,009 | [−0,017 ; −0,004] | 1/10 | oui |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 22,0 % | 23,0 % | +0,5 pt | [−2,2 pt ; +5,9 pt] | 5/10 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 18,46 % | 12,66 % | −0,19 pt | [−13,02 pt ; +3,67 pt] | 5/10 | non |
| Bétail | 0,00 % | 0,00 % | +0,00 pt | [−5,87 pt ; +8,55 pt] | 2/10 | non |
| Poisson | 17,31 % | 20,12 % | +4,15 pt | [−9,56 pt ; +9,87 pt] | 7/10 | non |
| Pétrole | 0,00 % | 0,00 % | +0,00 pt | [−0,00 pt ; +0,00 pt] | 1/10 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,20 % | 0,42 % | −0,03 pt | [−0,56 pt ; +0,60 pt] | 5/10 | non |
| Or | 0,01 % | 0,26 % | +0,25 pt | [+0,01 pt ; +0,34 pt] | 9/10 | oui |
| Bauxite | 0,52 % | 0,68 % | −0,06 pt | [−0,43 pt ; +0,60 pt] | 4/10 | non |
| Cuivre | 7,60 % | 0,56 % | −4,22 pt | [−11,25 pt ; −1,11 pt] | 0/10 | oui |
| Viande | 3,86 % | 2,72 % | −0,84 pt | [−4,25 pt ; +2,57 pt] | 5/10 | non |
| Pain | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Plastique | 17,17 % | 11,66 % | −6,86 pt | [−14,57 pt ; +0,76 pt] | 4/10 | non |
| Acier | 0,00 % | 0,06 % | +0,02 pt | [−0,30 pt ; +0,13 pt] | 5/10 | non |
| Aluminium | 0,18 % | 0,25 % | +0,01 pt | [−0,09 pt ; +0,36 pt] | 6/10 | non |
| Électronique | 2,03 % | 0,03 % | −1,65 pt | [−6,21 pt ; −0,23 pt] | 1/10 | oui |
| Processeurs | 91,99 % | 74,61 % | −10,63 pt | [−30,36 pt ; +24,53 pt] | 3/10 | non |
| Ordinateurs | 99,78 % | 98,70 % | −0,55 pt | [−6,42 pt ; −0,14 pt] | 1/10 | oui |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 2/10 | non |
| Machines | 0,09 % | 0,06 % | +0,00 pt | [−1,88 pt ; +0,06 pt] | 4/10 | non |
| Réparations | 0,85 % | 0,09 % | −0,71 pt | [−2,41 pt ; −0,20 pt] | 0/10 | oui |
| Ingénierie | 4,10 % | 3,61 % | +0,08 pt | [−2,82 pt ; +1,25 pt] | 5/10 | non |
| Conception de puces | 1,06 % | 3,40 % | +2,05 pt | [−8,00 pt ; +3,26 pt] | 7/10 | non |
| Publicité | 0,09 % | 0,06 % | −0,04 pt | [−0,08 pt ; −0,01 pt] | 2/10 | oui |
| Comptabilité | 0,14 % | 0,19 % | +0,06 pt | [−0,06 pt ; +0,10 pt] | 8/10 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [−1,69 pt ; +0,00 pt] | 0/10 | non |
| Télévision | 0,02 % | 0,01 % | −0,01 pt | [−0,03 pt ; +0,02 pt] | 3/10 | non |
| Loisirs | 0,00 % | 0,00 % | +0,00 pt | [−0,00 pt ; +0,00 pt] | 4/10 | non |
| Hôtel | 3,58 % | 2,18 % | −1,51 pt | [−3,42 pt ; −0,40 pt] | 2/10 | oui |
| Voyages | 3,54 % | 1,35 % | −1,38 pt | [−2,69 pt ; +0,00 pt] | 3/10 | non |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 0,86 % | 0,57 % | −0,24 pt | [−0,52 pt ; +0,11 pt] | 2/10 | non |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 97,2 % | 97,5 % | +0,6 pt | [−0,2 pt ; +1,5 pt] | 6/10 | non |
| primaire : Herfindahl | 0,965 | 0,969 | +0,007 | [−0,003 ; +0,018] | 6/10 | non |
| primaire : vendeurs actifs par bien | 1,1 | 1,1 | −0,0 | [−0,0 ; +0,0] | 4/10 | non |
| primaire : dispersion des prix | 21,3 % | 20,9 % | +0,4 pt | [−2,4 pt ; +6,4 pt] | 6/10 | non |
| secondaire : part de la plus grande entreprise | 92,7 % | 90,8 % | −2,2 pt | [−3,0 pt ; −1,0 pt] | 0/10 | oui |
| secondaire : Herfindahl | 0,915 | 0,893 | −0,025 | [−0,036 ; −0,012] | 0/10 | oui |
| secondaire : vendeurs actifs par bien | 1,4 | 1,5 | +0,1 | [+0,1 ; +0,2] | 10/10 | oui |
| secondaire : dispersion des prix | 27,5 % | 27,7 % | +0,4 pt | [−3,5 pt ; +4,0 pt] | 6/10 | non |
| tertiaire : part de la plus grande entreprise | 54,0 % | 48,7 % | −4,3 pt | [−8,3 pt ; −1,6 pt] | 1/10 | oui |
| tertiaire : Herfindahl | 0,496 | 0,436 | −0,047 | [−0,085 ; −0,016] | 1/10 | oui |
| tertiaire : vendeurs actifs par bien | 5,4 | 6,0 | +0,5 | [−0,1 ; +0,9] | 8/10 | non |
| tertiaire : dispersion des prix | 28,3 % | 31,1 % | +3,2 pt | [+0,6 pt ; +5,1 pt] | 9/10 | oui |

