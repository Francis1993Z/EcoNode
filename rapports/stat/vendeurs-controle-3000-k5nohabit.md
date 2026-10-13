# Test de contrôle : k = 0 contre k > 0 (3 000 citoyens, k = 5 sans habitude)

- A : `c3000-k0.json` ; B : `c3000-k5nohabit.json`.
- Graines (communes à A et B) : voir les « x/n » ci-dessous · 1000 jours · chauffe 100 jours · paramètres A {population: 3000, sellerSample: 0}, B {population: 3000, sellerSample: 5, sellerHabit: 0}.

## Sans filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 14,9 % | 10,1 % | −7,1 pt | [−15,3 pt ; +6,6 pt] | 4/10 | non |
| Faim moyenne | 2,6 % | 1,2 % | +0,1 pt | [−5,2 pt ; +6,2 pt] | 6/10 | non |
| Chômage moyen | 33,1 % | 29,1 % | −4,7 pt | [−16,3 pt ; +1,8 pt] | 4/10 | non |
| Demande non servie (unités non achetées / demandées) | 26,35 % | 11,85 % | −16,06 pt | [−22,45 pt ; −0,29 pt] | 2/10 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,279 | 1,365 | +0,104 | [−0,436 ; +0,837] | 5/10 | non |
| Inflation moyenne par jour | 0,03 % | 0,03 % | +0,01 pt | [−0,04 pt ; +0,06 pt] | 5/10 | non |
| Gini moyen | 0,781 | 0,723 | −0,071 | [−0,150 ; −0,003] | 2/10 | oui |
| Santé moyenne | 0,384 | 0,660 | +0,314 | [+0,036 ; +0,448] | 8/10 | oui |
| Parc moyen d’entreprises | 123,5 | 140,8 | +18,3 | [+11,0 ; +21,8] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 28,0 | 24,5 | −4,0 | [−18,0 ; +2,0] | 3/10 | non |
| Fermetures d’entreprises (toute la partie) | 353,0 | 330,0 | −27,5 | [−42,0 ; +1,0] | 3/10 | non |
| Morts par an, en % du parc moyen | 104,7 | 85,2 | −22,1 | [−26,2 ; −8,1] | 1/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 95,4 % | 96,3 % | +0,5 pt | [−1,2 pt ; +2,1 pt] | 6/10 | non |
| Herfindahl des ventes (médiane des biens) | 0,939 | 0,949 | +0,007 | [−0,018 ; +0,027] | 6/10 | non |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 16,1 % | 15,1 % | −0,9 pt | [−5,4 pt ; +1,4 pt] | 4/10 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 21,49 % | 29,29 % | +4,56 pt | [−3,86 pt ; +14,51 pt] | 7/10 | non |
| Bétail | 3,82 % | 0,00 % | +0,00 pt | [−18,95 pt ; +0,36 pt] | 2/10 | non |
| Poisson | 51,51 % | 45,50 % | −11,63 pt | [−26,38 pt ; +7,94 pt] | 4/10 | non |
| Pétrole | 0,00 % | 0,00 % | −0,00 pt | [−0,28 pt ; +0,00 pt] | 1/10 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,95 % | 0,35 % | +0,03 pt | [−3,02 pt ; +1,04 pt] | 6/10 | non |
| Or | 0,00 % | 0,16 % | +0,05 pt | [+0,00 pt ; +0,35 pt] | 6/10 | non |
| Bauxite | 1,46 % | 0,63 % | −1,02 pt | [−5,34 pt ; +0,22 pt] | 3/10 | non |
| Cuivre | 15,35 % | 0,55 % | −12,81 pt | [−31,20 pt ; −5,85 pt] | 0/10 | oui |
| Viande | 4,71 % | 4,80 % | +0,50 pt | [−2,67 pt ; +4,33 pt] | 5/10 | non |
| Pain | 0,01 % | 0,00 % | +0,00 pt | [−0,21 pt ; +0,37 pt] | 2/10 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Plastique | 45,21 % | 10,77 % | −32,52 pt | [−48,90 pt ; −17,89 pt] | 1/10 | oui |
| Acier | 0,05 % | 0,04 % | +0,00 pt | [−0,77 pt ; +0,13 pt] | 2/10 | non |
| Aluminium | 3,03 % | 0,27 % | −2,58 pt | [−10,95 pt ; −0,30 pt] | 0/10 | oui |
| Électronique | 17,95 % | 0,05 % | −17,91 pt | [−24,42 pt ; −5,78 pt] | 0/10 | oui |
| Processeurs | 91,50 % | 50,93 % | −23,84 pt | [−58,89 pt ; −6,99 pt] | 0/10 | oui |
| Ordinateurs | 99,76 % | 95,68 % | −4,15 pt | [−22,76 pt ; −0,30 pt] | 2/10 | oui |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 1/10 | non |
| Machines | 0,15 % | 0,05 % | −0,09 pt | [−1,24 pt ; +0,01 pt] | 2/10 | non |
| Réparations | 9,37 % | 0,07 % | −8,26 pt | [−11,40 pt ; −0,32 pt] | 1/10 | oui |
| Ingénierie | 2,69 % | 3,78 % | +0,98 pt | [+0,30 pt ; +2,61 pt] | 9/10 | oui |
| Conception de puces | 60,94 % | 6,85 % | −27,08 pt | [−71,97 pt ; +3,53 pt] | 3/10 | non |
| Publicité | 0,34 % | 0,13 % | −0,24 pt | [−0,33 pt ; +0,01 pt] | 2/10 | non |
| Comptabilité | 0,19 % | 0,21 % | +0,03 pt | [−0,16 pt ; +0,15 pt] | 6/10 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [−0,25 pt ; +0,00 pt] | 1/10 | non |
| Télévision | 0,08 % | 0,04 % | −0,05 pt | [−0,16 pt ; +0,03 pt] | 4/10 | non |
| Loisirs | 0,00 % | 0,01 % | −0,00 pt | [−0,01 pt ; +0,01 pt] | 4/10 | non |
| Hôtel | 4,52 % | 2,35 % | −1,92 pt | [−4,90 pt ; −0,15 pt] | 2/10 | oui |
| Voyages | 4,41 % | 1,67 % | −2,71 pt | [−3,92 pt ; +0,16 pt] | 3/10 | non |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 1,42 % | 0,86 % | −0,41 pt | [−1,15 pt ; +0,29 pt] | 3/10 | non |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 97,1 % | 98,1 % | +0,9 pt | [+0,4 pt ; +1,5 pt] | 9/10 | oui |
| primaire : Herfindahl | 0,962 | 0,976 | +0,011 | [+0,005 ; +0,019] | 9/10 | oui |
| primaire : vendeurs actifs par bien | 1,1 | 1,1 | −0,0 | [−0,0 ; −0,0] | 1/10 | oui |
| primaire : dispersion des prix | 15,4 % | 13,9 % | −0,8 pt | [−4,6 pt ; +2,8 pt] | 4/10 | non |
| secondaire : part de la plus grande entreprise | 92,3 % | 91,5 % | −1,2 pt | [−2,1 pt ; +1,4 pt] | 3/10 | non |
| secondaire : Herfindahl | 0,908 | 0,900 | −0,012 | [−0,024 ; +0,015] | 3/10 | non |
| secondaire : vendeurs actifs par bien | 1,5 | 1,5 | +0,0 | [−0,1 ; +0,1] | 7/10 | non |
| secondaire : dispersion des prix | 25,6 % | 26,2 % | −0,2 pt | [−2,2 pt ; +1,3 pt] | 3/10 | non |
| tertiaire : part de la plus grande entreprise | 53,8 % | 53,1 % | −1,0 pt | [−2,2 pt ; +2,1 pt] | 4/10 | non |
| tertiaire : Herfindahl | 0,494 | 0,483 | −0,013 | [−0,033 ; +0,018] | 4/10 | non |
| tertiaire : vendeurs actifs par bien | 5,1 | 5,6 | +0,5 | [−0,1 ; +0,8] | 8/10 | non |
| tertiaire : dispersion des prix | 20,5 % | 26,4 % | +3,5 pt | [+0,3 pt ; +8,4 pt] | 8/10 | oui |

## Avec filets

### Indicateurs d’ensemble (après la chauffe, sauf mention)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 10,3 % | 8,3 % | −1,7 pt | [−8,2 pt ; +6,6 pt] | 4/10 | non |
| Faim moyenne | 0,0 % | 0,6 % | +0,1 pt | [−3,9 pt ; +2,6 pt] | 7/10 | non |
| Chômage moyen | 31,7 % | 27,5 % | −3,1 pt | [−10,8 pt ; +9,2 pt] | 3/10 | non |
| Demande non servie (unités non achetées / demandées) | 22,72 % | 7,69 % | −10,64 pt | [−20,25 pt ; +4,27 pt] | 3/10 | non |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,528 | 1,211 | −0,475 | [−1,669 ; +0,547] | 4/10 | non |
| Inflation moyenne par jour | 0,05 % | 0,02 % | −0,04 pt | [−0,13 pt ; +0,06 pt] | 4/10 | non |
| Gini moyen | 0,714 | 0,688 | −0,023 | [−0,071 ; +0,089] | 4/10 | non |
| Santé moyenne | 0,414 | 0,733 | +0,223 | [−0,101 ; +0,406] | 7/10 | non |
| Parc moyen d’entreprises | 136,1 | 152,5 | +16,3 | [+9,5 ; +19,1] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 12,0 | 12,0 | +1,5 | [−5,0 ; +7,0] | 6/10 | non |
| Fermetures d’entreprises (toute la partie) | 324,5 | 303,0 | −20,5 | [−31,0 ; −10,0] | 0/10 | oui |
| Morts par an, en % du parc moyen | 87,4 | 72,4 | −13,4 | [−18,5 ; −8,9] | 0/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 96,3 % | 96,2 % | −0,5 pt | [−1,3 pt ; +0,4 pt] | 2/10 | non |
| Herfindahl des ventes (médiane des biens) | 0,951 | 0,949 | −0,009 | [−0,014 ; +0,006] | 2/10 | non |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 22,0 % | 22,9 % | +1,2 pt | [−2,3 pt ; +3,3 pt] | 7/10 | non |

### Demande non servie par bien

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Céréales | 18,46 % | 10,00 % | −0,90 pt | [−16,74 pt ; +7,60 pt] | 4/10 | non |
| Bétail | 0,00 % | 0,00 % | +0,00 pt | [−5,87 pt ; +8,99 pt] | 2/10 | non |
| Poisson | 17,31 % | 25,06 % | +6,99 pt | [−10,05 pt ; +25,81 pt] | 6/10 | non |
| Pétrole | 0,00 % | 0,00 % | +0,00 pt | [−0,00 pt ; +0,00 pt] | 1/10 | non |
| Bois | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Minerai de fer | 0,20 % | 0,21 % | +0,09 pt | [−0,63 pt ; +0,43 pt] | 6/10 | non |
| Or | 0,01 % | 0,29 % | +0,29 pt | [+0,01 pt ; +0,33 pt] | 9/10 | oui |
| Bauxite | 0,52 % | 1,02 % | +0,42 pt | [−0,15 pt ; +2,12 pt] | 6/10 | non |
| Cuivre | 7,60 % | 1,48 % | −4,18 pt | [−11,75 pt ; −0,28 pt] | 2/10 | oui |
| Viande | 3,86 % | 2,21 % | −1,98 pt | [−5,47 pt ; +1,12 pt] | 3/10 | non |
| Pain | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Carburant | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Plastique | 17,17 % | 11,35 % | −4,21 pt | [−14,06 pt ; +0,67 pt] | 3/10 | non |
| Acier | 0,00 % | 0,01 % | +0,00 pt | [−0,27 pt ; +0,13 pt] | 3/10 | non |
| Aluminium | 0,18 % | 0,40 % | +0,15 pt | [−0,11 pt ; +0,76 pt] | 7/10 | non |
| Électronique | 2,03 % | 0,19 % | −1,43 pt | [−6,38 pt ; +0,07 pt] | 3/10 | non |
| Processeurs | 91,99 % | 76,80 % | −4,04 pt | [−29,97 pt ; +54,75 pt] | 4/10 | non |
| Ordinateurs | 99,78 % | 99,17 % | −0,23 pt | [−3,12 pt ; +27,31 pt] | 4/10 | non |
| Bijoux | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Machines | 0,09 % | 0,03 % | −0,05 pt | [−1,97 pt ; +0,03 pt] | 3/10 | non |
| Réparations | 0,85 % | 0,08 % | −0,67 pt | [−2,50 pt ; −0,23 pt] | 1/10 | oui |
| Ingénierie | 4,10 % | 3,25 % | −0,93 pt | [−3,51 pt ; +1,49 pt] | 5/10 | non |
| Conception de puces | 1,06 % | 4,70 % | +3,19 pt | [+0,07 pt ; +5,82 pt] | 8/10 | oui |
| Publicité | 0,09 % | 0,05 % | −0,03 pt | [−0,11 pt ; +0,00 pt] | 3/10 | non |
| Comptabilité | 0,14 % | 0,17 % | +0,07 pt | [−0,09 pt ; +0,12 pt] | 7/10 | non |
| Repas | 0,00 % | 0,00 % | +0,00 pt | [−1,69 pt ; +0,00 pt] | 0/10 | non |
| Télévision | 0,02 % | 0,01 % | −0,01 pt | [−0,02 pt ; −0,00 pt] | 2/10 | oui |
| Loisirs | 0,00 % | 0,00 % | +0,00 pt | [−0,00 pt ; +0,01 pt] | 5/10 | non |
| Hôtel | 3,58 % | 2,30 % | −1,66 pt | [−3,17 pt ; +0,26 pt] | 2/10 | non |
| Voyages | 3,54 % | 1,80 % | −1,49 pt | [−3,16 pt ; +0,46 pt] | 3/10 | non |
| Soins de santé | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Formation | 100,00 % | 100,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |
| Logement | 0,86 % | 0,54 % | −0,17 pt | [−0,58 pt ; +0,29 pt] | 4/10 | non |
| Construction (module) | 0,00 % | 0,00 % | +0,00 pt | [+0,00 pt ; +0,00 pt] | 0/10 | non |

### Concentration et dispersion des prix par secteur (moyenne des biens du secteur)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 97,2 % | 97,7 % | +0,5 pt | [−0,5 pt ; +1,7 pt] | 6/10 | non |
| primaire : Herfindahl | 0,965 | 0,971 | +0,007 | [−0,008 ; +0,020] | 6/10 | non |
| primaire : vendeurs actifs par bien | 1,1 | 1,1 | −0,0 | [−0,0 ; +0,0] | 4/10 | non |
| primaire : dispersion des prix | 21,3 % | 23,7 % | +2,1 pt | [−0,4 pt ; +6,0 pt] | 8/10 | non |
| secondaire : part de la plus grande entreprise | 92,7 % | 90,7 % | −2,4 pt | [−2,6 pt ; −1,6 pt] | 0/10 | oui |
| secondaire : Herfindahl | 0,915 | 0,890 | −0,028 | [−0,032 ; −0,018] | 0/10 | oui |
| secondaire : vendeurs actifs par bien | 1,4 | 1,5 | +0,1 | [+0,1 ; +0,2] | 10/10 | oui |
| secondaire : dispersion des prix | 27,5 % | 26,6 % | −1,9 pt | [−3,5 pt ; +4,9 pt] | 3/10 | non |
| tertiaire : part de la plus grande entreprise | 54,0 % | 50,9 % | −2,7 pt | [−8,4 pt ; +0,3 pt] | 2/10 | non |
| tertiaire : Herfindahl | 0,496 | 0,456 | −0,032 | [−0,088 ; −0,002] | 2/10 | oui |
| tertiaire : vendeurs actifs par bien | 5,4 | 6,0 | +0,5 | [−0,4 ; +0,8] | 7/10 | non |
| tertiaire : dispersion des prix | 28,3 % | 32,0 % | +2,5 pt | [+1,3 pt ; +4,5 pt] | 9/10 | oui |

