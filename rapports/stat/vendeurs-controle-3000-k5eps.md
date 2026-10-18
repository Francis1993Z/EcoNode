# Test de contrôle : k = 0 contre k > 0 (3 000 citoyens, k = 5eps)

- A : `c3000-k0.json` ; B : `c3000-k5eps.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 3000, sellerSample: 0}, B {population: 3000, sellerSample: 5, availThreshold: eps}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 14,9 % | 47,6 % | +32,0 pt | [+25,5 pt ; +42,8 pt] | 10/10 | oui |
| Faim moyenne | 2,6 % | 18,0 % | +14,4 pt | [+3,4 pt ; +21,2 pt] | 9/10 | oui |
| Chômage moyen | 33,1 % | 52,2 % | +16,0 pt | [+12,7 pt ; +22,8 pt] | 10/10 | oui |
| Demande non servie (unités non achetées / demandées) | 26,35 % | 47,38 % | +23,30 pt | [+17,52 pt ; +30,66 pt] | 10/10 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,279 | 1,365 | +0,087 | [−0,136 ; +0,417] | 5/10 | non |
| Inflation moyenne par jour | 0,03 % | 0,03 % | +0,01 pt | [−0,01 pt ; +0,03 pt] | 5/10 | non |
| Gini moyen | 0,781 | 0,910 | +0,128 | [+0,112 ; +0,160] | 10/10 | oui |
| Santé moyenne | 0,384 | 0,240 | −0,151 | [−0,330 ; −0,113] | 0/10 | oui |
| Parc moyen d’entreprises | 123,5 | 136,5 | +12,6 | [+7,2 ; +16,2] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 28,0 | 44,0 | +11,0 | [−1,0 ; +30,0] | 7/10 | non |
| Fermetures d’entreprises (toute la partie) | 353,0 | 342,5 | −5,0 | [−34,0 ; +13,5] | 5/10 | non |
| Morts par an, en % du parc moyen | 104,7 | 92,0 | −10,5 | [−22,0 ; −3,9] | 1/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 95,4 % | 91,9 % | −2,7 pt | [−3,7 pt ; −2,4 pt] | 0/10 | oui |
| Herfindahl des ventes (médiane des biens) | 0,939 | 0,898 | −0,035 | [−0,045 ; −0,022] | 0/10 | oui |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 16,1 % | 12,8 % | −3,8 pt | [−6,4 pt ; −1,1 pt] | 2/10 | oui |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 21,49 % | 27,67 % | +7,90 pt | [−14,12 pt ; +13,56 pt] | 7/10 | non |
| Bétail | 3,82 % | 31,47 % | +17,59 pt | [−0,90 pt ; +27,64 pt] | 7/10 | non |
| Poisson | 51,51 % | 20,55 % | −32,26 pt | [−48,03 pt ; −14,55 pt] | 1/10 | oui |
| Pétrole | 0,00 % | 0,11 % | +0,04 pt | [−0,26 pt ; +0,27 pt] | 5/10 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,95 % | 9,66 % | +2,89 pt | [+1,70 pt ; +25,64 pt] | 10/10 | oui |
| Or | 0,00 % | 4,82 % | +4,64 pt | [+4,04 pt ; +6,63 pt] | 10/10 | oui |
| Bauxite | 1,46 % | 27,53 % | +22,31 pt | [+0,77 pt ; +35,74 pt] | 8/10 | oui |
| Cuivre | 15,35 % | 46,17 % | +33,08 pt | [+5,00 pt ; +44,50 pt] | 9/10 | oui |
| Viande | 4,71 % | 8,87 % | +3,94 pt | [−0,57 pt ; +9,85 pt] | 7/10 | non |
| Pain | 0,01 % | 0,02 % | +0,00 pt | [−0,22 pt ; +0,10 pt] | 4/10 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 1/10 | non |
| Plastique | 45,21 % | 71,57 % | +24,91 pt | [+4,22 pt ; +49,43 pt] | 9/10 | oui |
| Acier | 0,05 % | 1,92 % | +1,43 pt | [+0,57 pt ; +9,87 pt] | 10/10 | oui |
| Aluminium | 3,03 % | 47,07 % | +37,61 pt | [+14,83 pt ; +54,97 pt] | 10/10 | oui |
| Électronique | 17,95 % | 62,91 % | +41,25 pt | [+27,54 pt ; +61,05 pt] | 10/10 | oui |
| Processeurs | 91,50 % | 96,04 % | +4,42 pt | [−1,15 pt ; +10,42 pt] | 6/10 | non |
| Ordinateurs | 99,76 % | 99,91 % | +0,18 pt | [−0,13 pt ; +1,14 pt] | 7/10 | non |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [−0,01 pt ; +0,00 pt] | 0/10 | non |
| Machines | 0,15 % | 20,52 % | +18,79 pt | [+14,26 pt ; +29,03 pt] | 10/10 | oui |
| Réparations | 9,37 % | 16,36 % | +7,42 pt | [+4,28 pt ; +12,69 pt] | 10/10 | oui |
| Ingénierie | 2,69 % | 1,10 % | −1,57 pt | [−3,31 pt ; −0,20 pt] | 2/10 | oui |
| Conception de puces | 60,94 % | 69,65 % | +13,90 pt | [−9,73 pt ; +55,66 pt] | 6/10 | non |
| Publicité | 0,34 % | 0,20 % | −0,08 pt | [−0,36 pt ; +0,22 pt] | 5/10 | non |
| Comptabilité | 0,19 % | 0,17 % | −0,05 pt | [−0,18 pt ; +0,07 pt] | 4/10 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [−0,25 pt ; +0,00 pt] | 1/10 | non |
| Télévision | 0,08 % | 0,41 % | +0,31 pt | [+0,21 pt ; +0,48 pt] | 10/10 | oui |
| Loisirs | 0,00 % | 0,43 % | +0,42 pt | [+0,37 pt ; +0,49 pt] | 10/10 | oui |
| Hôtel | 4,52 % | 3,67 % | −0,60 pt | [−3,98 pt ; +0,98 pt] | 5/10 | non |
| Voyages | 4,41 % | 6,03 % | +1,84 pt | [+0,47 pt ; +4,19 pt] | 9/10 | oui |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 1,42 % | 1,60 % | +0,50 pt | [+0,16 pt ; +0,93 pt] | 9/10 | oui |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 97,1 % | 96,1 % | −0,6 pt | [−2,6 pt ; +0,1 pt] | 2/10 | non |
| primaire : Herfindahl | 0,962 | 0,950 | −0,008 | [−0,029 ; +0,001] | 2/10 | non |
| primaire : vendeurs actifs par bien | 1,1 | 1,2 | +0,1 | [+0,0 ; +0,1] | 9/10 | oui |
| primaire : dispersion des prix | 15,4 % | 15,3 % | −4,5 pt | [−6,5 pt ; +4,4 pt] | 4/10 | non |
| secondaire : part de la plus grande entreprise | 92,3 % | 90,5 % | −2,0 pt | [−3,3 pt ; −0,6 pt] | 2/10 | oui |
| secondaire : Herfindahl | 0,908 | 0,890 | −0,020 | [−0,041 ; −0,005] | 2/10 | oui |
| secondaire : vendeurs actifs par bien | 1,5 | 1,6 | +0,1 | [−0,0 ; +0,2] | 8/10 | non |
| secondaire : dispersion des prix | 25,6 % | 21,5 % | −1,4 pt | [−6,4 pt ; +0,1 pt] | 3/10 | non |
| tertiaire : part de la plus grande entreprise | 53,8 % | 52,6 % | −0,6 pt | [−4,7 pt ; +1,0 pt] | 3/10 | non |
| tertiaire : Herfindahl | 0,494 | 0,473 | −0,020 | [−0,059 ; +0,001] | 3/10 | non |
| tertiaire : vendeurs actifs par bien | 5,1 | 5,9 | +0,6 | [+0,4 ; +0,9] | 10/10 | oui |
| tertiaire : dispersion des prix | 20,5 % | 17,4 % | −4,5 pt | [−7,6 pt ; −0,4 pt] | 2/10 | oui |

## Avec filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 10,3 % | 29,8 % | +21,9 pt | [+11,4 pt ; +28,1 pt] | 10/10 | oui |
| Faim moyenne | 0,0 % | 16,4 % | +14,2 pt | [+6,0 pt ; +17,9 pt] | 10/10 | oui |
| Chômage moyen | 31,7 % | 52,2 % | +19,5 pt | [+12,1 pt ; +31,4 pt] | 10/10 | oui |
| Demande non servie (unités non achetées / demandées) | 22,72 % | 44,29 % | +21,72 pt | [+16,68 pt ; +40,43 pt] | 10/10 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,528 | 1,109 | −0,287 | [−1,562 ; +0,161] | 5/10 | non |
| Inflation moyenne par jour | 0,05 % | 0,01 % | −0,02 pt | [−0,11 pt ; +0,02 pt] | 5/10 | non |
| Gini moyen | 0,714 | 0,882 | +0,151 | [+0,127 ; +0,288] | 10/10 | oui |
| Santé moyenne | 0,414 | 0,238 | −0,194 | [−0,594 ; −0,125] | 0/10 | oui |
| Parc moyen d’entreprises | 136,1 | 148,9 | +10,8 | [+6,3 ; +13,4] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 12,0 | 9,0 | −5,0 | [−7,0 ; +1,0] | 2/10 | non |
| Fermetures d’entreprises (toute la partie) | 324,5 | 292,5 | −32,0 | [−40,5 ; −14,5] | 0/10 | oui |
| Morts par an, en % du parc moyen | 87,4 | 71,9 | −13,6 | [−17,6 ; −8,0] | 0/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 96,3 % | 92,3 % | −3,6 pt | [−5,3 pt ; −3,0 pt] | 0/10 | oui |
| Herfindahl des ventes (médiane des biens) | 0,951 | 0,902 | −0,045 | [−0,065 ; −0,040] | 0/10 | oui |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 22,0 % | 20,5 % | −1,2 pt | [−3,3 pt ; +2,4 pt] | 3/10 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 18,46 % | 2,34 % | −11,15 pt | [−18,86 pt ; −2,22 pt] | 2/10 | oui |
| Bétail | 0,00 % | 18,30 % | +18,27 pt | [+0,00 pt ; +31,07 pt] | 7/10 | non |
| Poisson | 17,31 % | 15,42 % | −1,36 pt | [−18,11 pt ; +8,46 pt] | 5/10 | non |
| Pétrole | 0,00 % | 0,41 % | +0,41 pt | [+0,09 pt ; +1,02 pt] | 8/10 | oui |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,20 % | 0,00 % | −0,05 pt | [−0,58 pt ; +0,00 pt] | 1/10 | non |
| Or | 0,01 % | 6,77 % | +6,76 pt | [+6,02 pt ; +8,40 pt] | 10/10 | oui |
| Bauxite | 0,52 % | 1,01 % | +0,53 pt | [−1,00 pt ; +0,96 pt] | 6/10 | non |
| Cuivre | 7,60 % | 19,13 % | +10,17 pt | [−2,08 pt ; +20,39 pt] | 7/10 | non |
| Viande | 3,86 % | 0,59 % | −2,02 pt | [−6,02 pt ; +0,35 pt] | 4/10 | non |
| Pain | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Carburant | 0,00 % | 0,01 % | +0,01 pt | [+0,00 pt ; +0,17 pt] | 5/10 | non |
| Plastique | 17,17 % | 18,71 % | −2,61 pt | [−22,34 pt ; +17,55 pt] | 5/10 | non |
| Acier | 0,00 % | 0,00 % | +0,00 pt | [−0,07 pt ; +0,04 pt] | 2/10 | non |
| Aluminium | 0,18 % | 0,00 % | −0,08 pt | [−0,41 pt ; +4,11 pt] | 4/10 | non |
| Électronique | 2,03 % | 1,27 % | −1,16 pt | [−5,37 pt ; +2,37 pt] | 4/10 | non |
| Processeurs | 91,99 % | 0,00 % | −56,23 pt | [−94,46 pt ; +12,89 pt] | 3/10 | non |
| Ordinateurs | 99,78 % | 99,95 % | +0,13 pt | [+0,06 pt ; +28,15 pt] | 10/10 | oui |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Machines | 0,09 % | 7,97 % | +7,84 pt | [+3,86 pt ; +10,22 pt] | 9/10 | oui |
| Réparations | 0,85 % | 0,37 % | −0,44 pt | [−2,36 pt ; +0,15 pt] | 3/10 | non |
| Ingénierie | 4,10 % | 2,84 % | −0,65 pt | [−3,22 pt ; +0,66 pt] | 4/10 | non |
| Conception de puces | 1,06 % | 0,83 % | −0,56 pt | [−15,02 pt ; +0,50 pt] | 3/10 | non |
| Publicité | 0,09 % | 0,02 % | −0,06 pt | [−0,08 pt ; −0,01 pt] | 2/10 | oui |
| Comptabilité | 0,14 % | 0,02 % | −0,13 pt | [−0,21 pt ; −0,05 pt] | 1/10 | oui |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [−1,69 pt ; +0,00 pt] | 1/10 | non |
| Télévision | 0,02 % | 0,33 % | +0,32 pt | [+0,24 pt ; +0,39 pt] | 10/10 | oui |
| Loisirs | 0,00 % | 0,58 % | +0,58 pt | [+0,56 pt ; +0,61 pt] | 10/10 | oui |
| Hôtel | 3,58 % | 4,35 % | +0,42 pt | [−2,42 pt ; +1,47 pt] | 6/10 | non |
| Voyages | 3,54 % | 9,04 % | +5,59 pt | [+2,51 pt ; +8,93 pt] | 10/10 | oui |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 0,86 % | 1,08 % | +0,33 pt | [−0,12 pt ; +0,83 pt] | 6/10 | non |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 97,2 % | 97,1 % | −0,1 pt | [−0,8 pt ; +1,2 pt] | 5/10 | non |
| primaire : Herfindahl | 0,965 | 0,963 | −0,003 | [−0,010 ; +0,012] | 4/10 | non |
| primaire : vendeurs actifs par bien | 1,1 | 1,1 | −0,0 | [−0,0 ; +0,0] | 5/10 | non |
| primaire : dispersion des prix | 21,3 % | 22,3 % | +3,3 pt | [−2,2 pt ; +6,0 pt] | 6/10 | non |
| secondaire : part de la plus grande entreprise | 92,7 % | 91,2 % | −2,0 pt | [−2,5 pt ; −1,1 pt] | 0/10 | oui |
| secondaire : Herfindahl | 0,915 | 0,897 | −0,025 | [−0,029 ; −0,010] | 1/10 | oui |
| secondaire : vendeurs actifs par bien | 1,4 | 1,5 | +0,1 | [+0,1 ; +0,2] | 10/10 | oui |
| secondaire : dispersion des prix | 27,5 % | 27,6 % | +0,3 pt | [−3,4 pt ; +2,9 pt] | 5/10 | non |
| tertiaire : part de la plus grande entreprise | 54,0 % | 49,5 % | −5,6 pt | [−8,5 pt ; +2,5 pt] | 3/10 | non |
| tertiaire : Herfindahl | 0,496 | 0,438 | −0,065 | [−0,103 ; +0,006] | 3/10 | non |
| tertiaire : vendeurs actifs par bien | 5,4 | 6,4 | +1,0 | [+0,0 ; +1,1] | 8/10 | oui |
| tertiaire : dispersion des prix | 28,3 % | 26,9 % | −0,3 pt | [−3,7 pt ; +0,8 pt] | 5/10 | non |

