# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 19:15
- A : `g30-ferme-regle.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : revival = 1
- B : `g30-ferme-cout.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : revival = 1, revivalFullCost = 1
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 9,1 % | 9,6 % | 11 → 13 | +0,6 pt | [−0,6 pt ; +2,9 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Chômage max | 24,6 % | 26,9 % | — | +0,4 pt | [−1,2 pt ; +6,3 pt] | 12 / 15 / 3 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,2 % | 1 → 2 | 0,0 pt | [0,0 pt ; +0,03 pt] | 6 / 12 / 12 sur 30 | non concluant |
| Faim max | 36,3 % | 47,7 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 7 / 9 / 14 sur 30 | non concluant |
| Sans-abri moyen | 0,5 % | 0,6 % | 1 → 2 | +0,1 pt | [−0,2 pt ; +0,7 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Sans-abri max | 30,0 % | 42,9 % | — | +5,4 pt | [0,0 pt ; +16,5 pt] | 9 / 15 / 6 sur 30 | non concluant |
| Gini moyen | 0,29 | 0,28 | 0 → 0 | +0,01 | [−0,02 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,29 | 0,29 | — | +0,02 | [−0,02 ; +0,05] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,050 % | -0,051 % | 0 → 0 | −0,004 pt | [−0,016 pt ; +0,009 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 37,2 % | 37,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 5 / 6 / 19 sur 30 | non concluant |
| |Inflation sur 100 j| max | 108,8 % | 108,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Alertes critiques ouvertes | 16 | 18 | 30 → 30 | +0,5 | [−2 ; +6,5] | 13 / 15 / 2 sur 30 | non concluant |
| … dont après la chauffe | 14 | 16 | — | +0,5 | [−2 ; +6,5] | 13 / 15 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 67 | 79 | — | +4,5 | [−14,5 ; +49] | 14 / 16 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 353,5 | 411 | — | +23,5 | [−22,5 ; +90,5] | 13 / 17 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,00002 | [−0,0001 ; +0,0001] | 16 / 14 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 10,2 | 10,5 | — | +1,1 | [−1,2 ; +3,3] | — / — / 0 | non concluant |
| Naissances / an, en % du parc moyen | 32,1 | 33,3 | — | +3,6 | [−2,4 ; +8,2] | — / — / 0 | non concluant |
| Morts / an, en % du parc moyen | 30,7 | 32,6 | — | +2,5 | [−1,1 ; +6,7] | — / — / 0 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 31,9 | 32,5 | — | +0,2 | [−0,3 ; +1,1] | — / — / 0 | non concluant |
| Demande non servie (part des unités demandées) | 1,6 % | 1,6 % | — | +0,03 pt | [−0,2 pt ; +0,4 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 18,5 % | 16,8 % | — | −2,0 pt | [−3,6 pt ; +1,5 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 24 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 24 | non concluant |
| Fermetures : prix aberrant | 1 | 1,5 | — | 0 | [0 ; +1] | — / — / 11 | non concluant |
| Fermetures : faillite (salaires impayables) | 33,5 | 34,5 | — | +4,5 | [−2 ; +8] | — / — / 1 | non concluant |
| Fermetures : demande perdue | 2 | 2 | — | 0 | [−1 ; +0,5] | — / — / 7 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 3 | — | 0 | [−2 ; +1] | — / — / 5 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 9,9 | 10,2 | — | +0,9 | [−0,1 ; +1,9] | — / — / 4 | non concluant |
| Entonnoir : projets envisagés | 10167,5 | 10383,5 | — | +268,5 | [−97,5 ; +667,5] | — / — / 0 | non concluant |
| Entonnoir : créations | 42 | 43 | — | +4,5 | [−5 ; +13,5] | — / — / 0 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 230 | 260 | — | +33 | [−33,5 ; +77,5] | — / — / 2 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 1365,5 | 1463 | — | +134,5 | [−177 ; +354,5] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 2392,5 | 2378 | — | −22 | [−97,5 ; +121,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 3620,5 | 3605 | — | −11 | [−216,5 ; +137] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 225,5 | 189 | — | −13,5 | [−94 ; +12] | — / — / 0 | non concluant |
| Entonnoir : refus, viabilité | 1799 | 1939 | — | +81,5 | [−89,5 ; +180] | — / — / 0 | non concluant |
| Entonnoir : refus, aucun fondateur assez riche | 562,5 | 535 | — | −4,5 | [−56 ; +76,5] | — / — / 1 | non concluant |
| Types d’entreprise actifs en fin | 28 | 29 | — | 0 | [−1 ; +1,5] | 14 / 11 / 5 sur 30 | non concluant |
| Machines en fin | 393,3 | 373,2 | — | +2,3 | [−92,6 ; +42,6] | 16 / 14 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 2,5 | 2 | — | +0,5 | [−1 ; +1,5] | 11 / 15 / 4 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | −0,0004 | [−0,01 ; +0,001] | 14 / 16 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | −0,001 | [−0,02 ; +0,04] | 16 / 14 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 3 / 25 sur 30 | non concluant |
| Trésor de l’État le plus bas | 69 662 $ | 61 584 $ | — | −74 $ | [−15 477 $ ; +1 569 $] | 12 / 17 / 1 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 2 / 9 / 19 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 17 | non concluant |
| Créances radiées | 20 191 $ | 19 672 $ | — | −1 237 $ | [−3 983 $ ; +2 036 $] | — / — / 1 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 7 → 9 | 0 | [0 ; 0] | 5 / 8 / 17 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 5 / 9 / 16 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 17 → 18 | 0 | [0 ; 0] | 3 / 9 / 18 sur 30 | non concluant |
| … jours-alerte | 3 | 6 | — | 0 | [0 ; +0,5] | 4 / 10 / 16 sur 30 | non concluant |
| Sans-abri nombreux | 3 | 3 | 29 → 29 | 0 | [−1 ; +2,5] | 11 / 13 / 6 sur 30 | non concluant |
| … jours-alerte | 32 | 39,5 | — | +1 | [−16,5 ; +34,5] | 15 / 15 / 0 sur 30 | non concluant |
| Inflation quotidienne | 10 | 10 | 30 → 30 | 0 | [−1 ; +1,5] | 14 / 11 / 5 sur 30 | non concluant |
| … jours-alerte | 10 | 10 | — | 0 | [−1 ; +1,5] | 13 / 11 / 6 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 27 → 27 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 10 | 10 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 8,0 % | 8 → 7 | +0,5 pt | [−0,7 pt ; +1,4 pt] | 12 / 16 / 2 sur 30 | non concluant |
| Chômage max | 22,1 % | 22,3 % | — | +0,4 pt | [0,0 pt ; +2,9 pt] | 9 / 16 / 5 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 1 | 0,0 pt | [0,0 pt ; 0,0 pt] | 5 / 7 / 18 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 4 / 7 / 19 sur 30 | non concluant |
| Sans-abri moyen | 0,1 % | 0,2 % | 2 → 2 | 0,0 pt | [−0,03 pt ; +0,1 pt] | 13 / 14 / 3 sur 30 | non concluant |
| Sans-abri max | 35,6 % | 26,9 % | — | 0,0 pt | [−4,8 pt ; +0,4 pt] | 13 / 10 / 7 sur 30 | non concluant |
| Gini moyen | 0,25 | 0,24 | 0 → 0 | +0,00004 | [−0,01 ; +0,01] | — / — / 2 | non concluant |
| Gini en fin de partie | 0,26 | 0,26 | — | +0,003 | [−0,01 ; +0,03] | — / — / 2 | non concluant |
| Inflation moyenne / j | -0,044 % | -0,044 % | 0 → 0 | +0,0005 pt | [−0,007 pt ; +0,013 pt] | — / — / 2 | non concluant |
| |Inflation| max / j | 32,7 % | 33,4 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 5 / 6 / 19 sur 30 | non concluant |
| |Inflation sur 100 j| max | 107,6 % | 107,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Alertes critiques ouvertes | 12 | 14 | 30 → 30 | +1 | [0 ; +2,5] | 7 / 16 / 7 sur 30 | non concluant |
| … dont après la chauffe | 11 | 13 | — | +1 | [0 ; +2,5] | 7 / 17 / 6 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 37,5 | 43,5 | — | +5 | [+1 ; +10,5] | 7 / 20 / 3 sur 30 | **B plus haut (moins bien)** |
| Alertes ouvertes (toutes) | 286,5 | 292,5 | — | −2,5 | [−15 ; +19] | 15 / 13 / 2 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | −0,00002 | [−0,0001 ; +0,00005] | 11 / 16 / 3 sur 30 | non concluant |
| Naissances d’entreprises / an | 6,6 | 5,8 | — | −0,2 | [−1,0 ; +0,5] | — / — / 2 | non concluant |
| Naissances / an, en % du parc moyen | 20,5 | 19,6 | — | 0,0 | [−3,0 ; +2,7] | — / — / 2 | non concluant |
| Morts / an, en % du parc moyen | 19,2 | 18,4 | — | +0,7 | [−1,5 ; +2,0] | — / — / 2 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 31,4 | 31,5 | — | −0,03 | [−0,5 ; +0,3] | — / — / 2 | non concluant |
| Demande non servie (part des unités demandées) | 1,0 % | 1,0 % | — | 0,0 pt | [−0,02 pt ; +0,1 pt] | 14 / 14 / 2 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 20,6 % | 20,2 % | — | 0,0 pt | [−1,1 pt ; +1,4 pt] | — / — / 2 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 28 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 28 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | 0 | [0 ; 0] | — / — / 18 | non concluant |
| Fermetures : faillite (salaires impayables) | 20 | 19,5 | — | −1,5 | [−3,5 ; +2] | — / — / 2 | non concluant |
| Fermetures : demande perdue | 1,5 | 2 | — | 0 | [−1 ; +1] | — / — / 7 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | 0 | [0 ; 0] | — / — / 16 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 6,2 | 5,7 | — | +0,1 | [−0,6 ; +0,7] | — / — / 2 | non concluant |
| Entonnoir : projets envisagés | 9126,5 | 9520,5 | — | +284,5 | [+70,5 ; +719,5] | — / — / 2 | **B plus haut** |
| Entonnoir : créations | 27 | 24 | — | −1 | [−4 ; +2] | — / — / 2 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 133,5 | 136,5 | — | +7,5 | [−14 ; +33] | — / — / 2 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 640 | 730,5 | — | +52,5 | [−81,5 ; +224] | — / — / 2 | non concluant |
| Entonnoir : refus, concurrence | 2384,5 | 2523 | — | +36,5 | [−16,5 ; +136] | — / — / 2 | non concluant |
| Entonnoir : refus, demande insuffisante | 3509 | 3575,5 | — | +49,5 | [−24 ; +185] | — / — / 2 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 152 | 159,5 | — | +1,5 | [−33,5 ; +27] | — / — / 2 | non concluant |
| Entonnoir : refus, viabilité | 1955 | 1979 | — | +56,5 | [−21 ; +251,5] | — / — / 1 | non concluant |
| Entonnoir : refus, aucun fondateur assez riche | 211,5 | 155 | — | +2 | [−88 ; +16,5] | — / — / 2 | non concluant |
| Types d’entreprise actifs en fin | 29 | 29 | — | 0 | [0 ; 0] | 9 / 9 / 12 sur 30 | non concluant |
| Machines en fin | 346,4 | 370,2 | — | −3,7 | [−27,8 ; +55,5] | 13 / 15 / 2 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 2 | 2,5 | — | 0 | [−1 ; 0] | 13 / 9 / 8 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | −0,0002 | [−0,001 ; +0,001] | 11 / 17 / 2 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | +0,002 | [−0,004 ; +0,02] | 12 / 15 / 3 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 3 / 1 / 26 sur 30 | non concluant |
| Trésor de l’État le plus bas | 87 603 $ | 74 039 $ | — | −12 024 $ | [−18 303 $ ; −3 065 $] | 5 / 22 / 3 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 3 876 $ | 2 907 $ | — | −441 $ | [−1 707 $ ; 0 $] | — / — / 4 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 5 → 5 | 0,00 | [0,00 ; 0,00] | 5 / 5 / 20 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 4,77 | 4,63 | 30 → 30 | 0,00 | [−0,21 ; +0,54] | 14 / 14 / 2 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,84 | 0,55 | 14 → 14 | 0,00 | [−0,23 ; +0,14] | 13 / 13 / 4 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 1 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 4 → 3 | 0 | [0 ; 0] | 3 / 2 / 25 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 4 / 1 / 25 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 10 → 9 | 0 | [0 ; 0] | 3 / 5 / 22 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 5 / 5 / 20 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 2 | 24 → 27 | +0,5 | [0 ; +1] | 5 / 15 / 10 sur 30 | non concluant |
| … jours-alerte | 19 | 21,5 | — | +2 | [0 ; +9] | 7 / 16 / 7 sur 30 | non concluant |
| Inflation quotidienne | 10 | 10 | 30 → 30 | 0 | [−0,5 ; +2] | 10 / 13 / 7 sur 30 | non concluant |
| … jours-alerte | 10 | 10 | — | 0 | [−0,5 ; +2] | 10 / 14 / 6 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 1 | 24 → 24 | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| … jours-alerte | 9 | 9 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 1 → 0 | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Avec filets — Jours-alerte critiques (somme des types) : +5 [+1 ; +10,5], B moins bien (7 graines mieux, 20 moins bien, 3 égales)
- Avec filets — Entonnoir : projets envisagés : +284,5 [+70,5 ; +719,5] (0 graines mieux, 0 moins bien, 2 égales)
- Avec filets — Trésor de l’État le plus bas : −12 024 $ [−18 303 $ ; −3 065 $], B moins bien (5 graines mieux, 22 moins bien, 3 égales)

