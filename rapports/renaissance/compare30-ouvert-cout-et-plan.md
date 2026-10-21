# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 19:18
- A : `g30-ouvert-regle.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1, revival = 1
- B : `g30-ouvert-both.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1, revival = 1, revivalFullCost = 1, revivalPlannedDemand = 1
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 14,4 % | 15,1 % | 25 → 27 | +1,7 pt | [−1,7 pt ; +3,6 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Chômage max | 46,3 % | 44,8 % | — | +2,9 pt | [−2,9 pt ; +8,7 pt] | 11 / 18 / 1 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,0 % | 5 → 3 | 0,0 pt | [−0,1 pt ; +0,03 pt] | 12 / 12 / 6 sur 30 | non concluant |
| Faim max | 3,5 % | 2,3 % | — | 0,0 pt | [−2,7 pt ; +2,3 pt] | 11 / 12 / 7 sur 30 | non concluant |
| Sans-abri moyen | 1,6 % | 1,7 % | 12 → 13 | +0,6 pt | [−0,1 pt ; +0,9 pt] | 10 / 20 / 0 sur 30 | non concluant |
| Sans-abri max | 56,7 % | 48,3 % | — | −0,6 pt | [−13,5 pt ; +16,2 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Gini moyen | 0,32 | 0,31 | 2 → 2 | +0,0004 | [−0,02 ; +0,03] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,30 | 0,32 | — | +0,01 | [−0,07 ; +0,06] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,031 % | -0,033 % | 0 → 0 | −0,002 pt | [−0,012 pt ; +0,007 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 27,3 % | 23,0 % | — | 0,0 pt | [−4,2 pt ; +4,1 pt] | 14 / 12 / 4 sur 30 | non concluant |
| |Inflation sur 100 j| max | 115,5 % | 123,8 % | — | 0,0 pt | [−5,4 pt ; +5,0 pt] | 11 / 13 / 6 sur 30 | non concluant |
| Alertes critiques ouvertes | 20,5 | 25,5 | 30 → 30 | +1,5 | [−4 ; +4,5] | 12 / 16 / 2 sur 30 | non concluant |
| … dont après la chauffe | 19 | 25,5 | — | +1,5 | [−4 ; +4] | 12 / 16 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 220,5 | 275 | — | +37,5 | [−59,5 ; +186] | 12 / 18 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 377,5 | 279,5 | — | −97 | [−119 ; −64] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Santé moyenne | 0,87 | 0,87 | — | −0,002 | [−0,02 ; +0,01] | 12 / 18 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 15,7 | 8,0 | — | −7,8 | [−10,0 ; −6,8] | — / — / 0 | **B plus bas** |
| Naissances / an, en % du parc moyen | 58,1 | 32,6 | — | −25,7 | [−31,8 ; −21,1] | — / — / 0 | **B plus bas** |
| Morts / an, en % du parc moyen | 62,8 | 39,3 | — | −20,0 | [−27,7 ; −17,9] | — / — / 0 | **B plus bas** |
| Parc moyen d’entreprises (après la chauffe) | 27,5 | 24,4 | — | −2,7 | [−3,5 ; −2,5] | — / — / 0 | **B plus bas** |
| Demande non servie (part des unités demandées) | 1,1 % | 1,7 % | — | +0,3 pt | [−0,4 pt ; +1,1 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 9,5 % | 9,4 % | — | −0,01 pt | [−1,8 pt ; +3,1 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 4 | 4 | — | 0 | [−1 ; +1] | — / — / 6 | non concluant |
| Fermetures : faillite (salaires impayables) | 53 | 24 | — | −27,5 | [−30,5 ; −23] | — / — / 0 | **B plus bas** |
| Fermetures : demande perdue | 13 | 9 | — | −2,5 | [−6 ; +0,5] | — / — / 1 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 1 | — | 0 | [−1 ; 0] | — / — / 11 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 16,7 | 9,6 | — | −6,6 | [−8,9 ; −6,1] | — / — / 0 | **B plus bas** |
| Entonnoir : projets envisagés | 8281,5 | 5828 | — | −2407,5 | [−2765 ; −2068,5] | — / — / 0 | **B plus bas** |
| Entonnoir : créations | 64,5 | 33 | — | −32 | [−41 ; −28] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, une création déjà ce jour | 243 | 111 | — | −137 | [−186,5 ; −110] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, délai entre deux créations du type | 781 | 330 | — | −442,5 | [−588,5 ; −336,5] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, concurrence | 1324,5 | 1318 | — | −56 | [−109,5 ; +55] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1444 | 1605 | — | +203,5 | [−69,5 ; +334,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 509 | 414 | — | −102,5 | [−166,5 ; −18] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, viabilité | 3525 | 2006,5 | — | −1549 | [−1800 ; −1335,5] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, aucun fondateur assez riche | 10,5 | 0 | — | 0 | [−16 ; +2] | — / — / 7 | non concluant |
| Types d’entreprise actifs en fin | 25 | 22,5 | — | −1,5 | [−3 ; 0] | 10 / 20 / 0 sur 30 | non concluant |
| Machines en fin | 296,9 | 254,9 | — | −26,8 | [−70,7 ; +13,8] | 13 / 17 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 4 | — | +0,5 | [−1 ; +1] | 11 / 15 / 4 sur 30 | non concluant |
| Bonheur moyen | 0,96 | 0,95 | — | −0,004 | [−0,01 ; +0,01] | 14 / 16 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 2,2 | 3,9 | — | +0,3 | [−0,9 ; +3,9] | 12 / 18 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 65,5 | 53 | — | 0 | [−46,5 ; +64] | 12 / 13 / 5 sur 30 | non concluant |
| Trésor de l’État le plus bas | 3 415 $ | 2 925 $ | — | −453 $ | [−2 194 $ ; +642 $] | 13 / 16 / 1 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 25 | non concluant |
| Créances radiées | 9 967 $ | 8 779 $ | — | −494 $ | [−4 723 $ ; +5 477 $] | — / — / 0 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 2 | 1,5 | 22 → 23 | 0 | [−1 ; +1] | 11 / 14 / 5 sur 30 | non concluant |
| … jours-alerte | 80 | 109 | — | +11,5 | [−52 ; +97,5] | 12 / 16 / 2 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 14 → 11 | 0 | [−1 ; 0] | 11 / 5 / 14 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 9 / 8 / 13 sur 30 | non concluant |
| Sans-abri nombreux | 5 | 4 | 30 → 30 | −0,5 | [−2 ; +1] | 15 / 11 / 4 sur 30 | non concluant |
| … jours-alerte | 78 | 77,5 | — | +8 | [−24,5 ; +38] | 12 / 18 / 0 sur 30 | non concluant |
| Inflation quotidienne | 13 | 15,5 | 30 → 30 | +3 | [0 ; +4] | 9 / 19 / 2 sur 30 | non concluant |
| … jours-alerte | 14 | 20 | — | +3 | [−0,5 ; +5,5] | 10 / 19 / 1 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 1 | 18 → 17 | 0 | [0 ; 0] | 5 / 9 / 16 sur 30 | non concluant |
| … jours-alerte | 12,5 | 17,5 | — | 0 | [0 ; +9] | 8 / 12 / 10 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 8 → 8 | 0 | [0 ; 0] | 7 / 5 / 18 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 6 / 7 / 17 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 14,3 % | 14,9 % | 25 → 26 | +0,5 pt | [−1,0 pt ; +1,9 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Chômage max | 39,6 % | 40,6 % | — | +1,0 pt | [−1,5 pt ; +4,4 pt] | 12 / 16 / 2 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 3 → 3 | 0,0 pt | [0,0 pt ; +0,01 pt] | 9 / 12 / 9 sur 30 | non concluant |
| Faim max | 0,8 % | 0,4 % | — | 0,0 pt | [0,0 pt ; +0,4 pt] | 9 / 11 / 10 sur 30 | non concluant |
| Sans-abri moyen | 1,4 % | 1,4 % | 5 → 10 | −0,1 pt | [−0,5 pt ; +0,5 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Sans-abri max | 39,8 % | 42,7 % | — | +0,6 pt | [−4,2 pt ; +7,9 pt] | 12 / 15 / 3 sur 30 | non concluant |
| Gini moyen | 0,30 | 0,32 | 2 → 2 | +0,003 | [−0,002 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,32 | 0,35 | — | +0,03 | [−0,01 ; +0,06] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,028 % | -0,037 % | 0 → 0 | −0,004 pt | [−0,014 pt ; +0,008 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 19,1 % | 25,1 % | — | +3,1 pt | [0,0 pt ; +8,5 pt] | 9 / 18 / 3 sur 30 | non concluant |
| |Inflation sur 100 j| max | 91,9 % | 106,4 % | — | 0,0 pt | [0,0 pt ; +9,2 pt] | 7 / 14 / 9 sur 30 | non concluant |
| Alertes critiques ouvertes | 21,5 | 22 | 30 → 30 | +0,5 | [−5,5 ; +5] | 14 / 15 / 1 sur 30 | non concluant |
| … dont après la chauffe | 20 | 21 | — | +0,5 | [−5,5 ; +5] | 14 / 15 / 1 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 166 | 182 | — | +8 | [−113 ; +71,5] | 14 / 16 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 368,5 | 263 | — | −111 | [−124,5 ; −93] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Santé moyenne | 0,87 | 0,87 | — | +0,001 | [−0,003 ; +0,01] | 16 / 14 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 14,5 | 7,4 | — | −8,3 | [−9,1 ; −6,2] | — / — / 0 | **B plus bas** |
| Naissances / an, en % du parc moyen | 52,1 | 29,5 | — | −25,2 | [−29,0 ; −19,1] | — / — / 0 | **B plus bas** |
| Morts / an, en % du parc moyen | 55,4 | 35,4 | — | −21,3 | [−25,2 ; −18,1] | — / — / 0 | **B plus bas** |
| Parc moyen d’entreprises (après la chauffe) | 27,8 | 24,9 | — | −3,2 | [−3,8 ; −2,7] | — / — / 0 | **B plus bas** |
| Demande non servie (part des unités demandées) | 1,4 % | 1,1 % | — | −0,04 pt | [−0,4 pt ; +0,2 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 11,0 % | 9,3 % | — | −2,3 pt | [−4,6 pt ; +1,4 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 6 | 5 | — | −0,5 | [−3 ; 0] | — / — / 6 | non concluant |
| Fermetures : faillite (salaires impayables) | 43,5 | 20,5 | — | −24 | [−31,5 ; −20] | — / — / 0 | **B plus bas** |
| Fermetures : demande perdue | 13 | 9,5 | — | −2,5 | [−4,5 ; −0,5] | — / — / 1 | **B plus bas** |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 1 | — | −1 | [−1 ; 0] | — / — / 6 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 15,2 | 8,6 | — | −7,3 | [−8,0 ; −5,8] | — / — / 0 | **B plus bas** |
| Entonnoir : projets envisagés | 7722 | 6048 | — | −1984 | [−2291,2 ; −1430] | — / — / 0 | **B plus bas** |
| Entonnoir : créations | 59,5 | 30,5 | — | −34 | [−37,5 ; −25,5] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, une création déjà ce jour | 224 | 102 | — | −146 | [−151 ; −125,5] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, délai entre deux créations du type | 350,5 | 185 | — | −130,5 | [−197,5 ; −79,5] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, concurrence | 1404 | 1429 | — | +14,5 | [−81,5 ; +99,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1515 | 1652 | — | +76 | [−115 ; +170,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 521,5 | 387 | — | −126,5 | [−222,5 ; −17] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, viabilité | 3324 | 1830 | — | −1385 | [−2094,5 ; −997,5] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, aucun fondateur assez riche | 4 | 0 | — | −0,5 | [−4 ; 0] | — / — / 9 | non concluant |
| Types d’entreprise actifs en fin | 25 | 23 | — | −2 | [−3 ; −1] | 5 / 23 / 2 sur 30 | **B plus bas (moins bien)** |
| Machines en fin | 305,3 | 281,8 | — | −16,0 | [−47,7 ; +19,3] | 13 / 17 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 3 | — | 0 | [−1 ; +1] | 13 / 11 / 6 sur 30 | non concluant |
| Bonheur moyen | 0,96 | 0,95 | — | +0,001 | [−0,01 ; +0,01] | 15 / 15 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 3,3 | 2,2 | — | −0,2 | [−2,1 ; +0,5] | 17 / 13 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 69,5 | 52 | — | 0 | [−20,5 ; +9,5] | 14 / 12 / 4 sur 30 | non concluant |
| Trésor de l’État le plus bas | 3 410 $ | 3 253 $ | — | −22 $ | [−671 $ ; +1 126 $] | 14 / 15 / 1 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 2 740 $ | 1 976 $ | — | −186 $ | [−1 502 $ ; +1 039 $] | — / — / 0 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 9 → 9 | 0,00 | [0,00 ; 0,00] | 7 / 9 / 14 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 1,88 | 0,77 | 27 → 12 | −0,95 | [−1,38 ; −0,48] | 28 / 1 / 1 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 18,48 | 17,21 | 30 → 30 | −2,75 | [−13,57 ; +7,50] | 16 / 14 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 1,5 | 1 | 23 → 21 | 0 | [−1 ; 0] | 12 / 8 / 10 sur 30 | non concluant |
| … jours-alerte | 78 | 65 | — | −2,5 | [−27 ; +21] | 16 / 11 / 3 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 9 → 8 | 0 | [0 ; 0] | 4 / 5 / 21 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 7 / 20 sur 30 | non concluant |
| Sans-abri nombreux | 5 | 4,5 | 30 → 29 | −1 | [−3 ; +0,5] | 16 / 10 / 4 sur 30 | non concluant |
| … jours-alerte | 79 | 55 | — | −7,5 | [−35 ; +15] | 17 / 13 / 0 sur 30 | non concluant |
| Inflation quotidienne | 11 | 14 | 30 → 30 | −0,5 | [−2,5 ; +3] | 15 / 14 / 1 sur 30 | non concluant |
| … jours-alerte | 12 | 15 | — | −0,5 | [−2,5 ; +3] | 15 / 14 / 1 sur 30 | non concluant |
| Inflation sur 100 jours | 0 | 1 | 12 → 16 | 0 | [0 ; 0] | 4 / 9 / 17 sur 30 | non concluant |
| … jours-alerte | 0 | 1 | — | 0 | [0 ; 0] | 6 / 9 / 15 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 11 → 8 | 0 | [0 ; 0] | 7 / 4 / 19 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 8 / 15 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Alertes ouvertes (toutes) : −97 [−119 ; −64], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Sans filets — Naissances d’entreprises / an : −7,8 [−10,0 ; −6,8] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Naissances / an, en % du parc moyen : −25,7 [−31,8 ; −21,1] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts / an, en % du parc moyen : −20,0 [−27,7 ; −17,9] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Parc moyen d’entreprises (après la chauffe) : −2,7 [−3,5 ; −2,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : faillite (salaires impayables) : −27,5 [−30,5 ; −23] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts d’entreprises / an : −6,6 [−8,9 ; −6,1] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : projets envisagés : −2407,5 [−2765 ; −2068,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : créations : −32 [−41 ; −28] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, une création déjà ce jour : −137 [−186,5 ; −110] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, délai entre deux créations du type : −442,5 [−588,5 ; −336,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, pas assez de chômeurs qualifiés : −102,5 [−166,5 ; −18] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, viabilité : −1549 [−1800 ; −1335,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Alertes ouvertes (toutes) : −111 [−124,5 ; −93], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Naissances d’entreprises / an : −8,3 [−9,1 ; −6,2] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Naissances / an, en % du parc moyen : −25,2 [−29,0 ; −19,1] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts / an, en % du parc moyen : −21,3 [−25,2 ; −18,1] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Parc moyen d’entreprises (après la chauffe) : −3,2 [−3,8 ; −2,7] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : faillite (salaires impayables) : −24 [−31,5 ; −20] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : demande perdue : −2,5 [−4,5 ; −0,5] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Morts d’entreprises / an : −7,3 [−8,0 ; −5,8] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : projets envisagés : −1984 [−2291,2 ; −1430] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : créations : −34 [−37,5 ; −25,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, une création déjà ce jour : −146 [−151 ; −125,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, délai entre deux créations du type : −130,5 [−197,5 ; −79,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, pas assez de chômeurs qualifiés : −126,5 [−222,5 ; −17] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : −1385 [−2094,5 ; −997,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Types d’entreprise actifs en fin : −2 [−3 ; −1], B moins bien (5 graines mieux, 23 moins bien, 2 égales)
- Avec filets — Filet : Renflouement d’entreprise / 50 j : −0,95 [−1,38 ; −0,48], B mieux (28 graines mieux, 1 moins bien, 1 égales)

