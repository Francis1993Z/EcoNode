# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 19:18
- A : `g30-ouvert-regle.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1, revival = 1
- B : `g30-ouvert-plan.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1, revival = 1, revivalPlannedDemand = 1
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 14,4 % | 15,1 % | 25 → 26 | +0,3 pt | [−0,6 pt ; +3,7 pt] | 15 / 15 / 0 sur 30 | non concluant |
| Chômage max | 46,3 % | 41,5 % | — | +3,5 pt | [−4,8 pt ; +6,0 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,0 % | 5 → 2 | 0,0 pt | [−0,2 pt ; +0,01 pt] | 13 / 11 / 6 sur 30 | non concluant |
| Faim max | 3,5 % | 0,6 % | — | 0,0 pt | [−7,1 pt ; +2,1 pt] | 12 / 12 / 6 sur 30 | non concluant |
| Sans-abri moyen | 1,6 % | 1,5 % | 12 → 11 | +0,2 pt | [−0,5 pt ; +0,8 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Sans-abri max | 56,7 % | 57,3 % | — | +2,9 pt | [−4,8 pt ; +12,9 pt] | 12 / 17 / 1 sur 30 | non concluant |
| Gini moyen | 0,32 | 0,32 | 2 → 2 | +0,002 | [−0,02 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,30 | 0,31 | — | +0,002 | [−0,06 ; +0,03] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,031 % | -0,030 % | 0 → 0 | −0,002 pt | [−0,024 pt ; +0,007 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 27,3 % | 21,8 % | — | +0,6 pt | [−6,3 pt ; +4,8 pt] | 14 / 15 / 1 sur 30 | non concluant |
| |Inflation sur 100 j| max | 115,5 % | 105,0 % | — | 0,0 pt | [−8,1 pt ; +0,4 pt] | 11 / 10 / 9 sur 30 | non concluant |
| Alertes critiques ouvertes | 20,5 | 24 | 30 → 30 | +3 | [−3 ; +6,5] | 12 / 18 / 0 sur 30 | non concluant |
| … dont après la chauffe | 19 | 23 | — | +3 | [−3,5 ; +6,5] | 12 / 18 / 0 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 220,5 | 183 | — | +31,5 | [−94,5 ; +90,5] | 12 / 18 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 377,5 | 295,5 | — | −77,5 | [−112 ; −46,5] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |
| Santé moyenne | 0,87 | 0,87 | — | −0,0001 | [−0,01 ; +0,01] | 13 / 17 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 15,7 | 9,6 | — | −7,1 | [−9,4 ; −4,9] | — / — / 0 | **B plus bas** |
| Naissances / an, en % du parc moyen | 58,1 | 38,6 | — | −23,1 | [−27,9 ; −16,3] | — / — / 0 | **B plus bas** |
| Morts / an, en % du parc moyen | 62,8 | 45,3 | — | −19,2 | [−24,3 ; −15,3] | — / — / 0 | **B plus bas** |
| Parc moyen d’entreprises (après la chauffe) | 27,5 | 24,6 | — | −2,6 | [−3,3 ; −1,6] | — / — / 0 | **B plus bas** |
| Demande non servie (part des unités demandées) | 1,1 % | 1,5 % | — | +0,1 pt | [−0,4 pt ; +0,8 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 9,5 % | 10,5 % | — | +0,3 pt | [−1,4 pt ; +5,2 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 4 | 5 | — | +1,5 | [−0,5 ; +3] | — / — / 1 | non concluant |
| Fermetures : faillite (salaires impayables) | 53 | 26,5 | — | −24 | [−31 ; −19,5] | — / — / 0 | **B plus bas** |
| Fermetures : demande perdue | 13 | 11 | — | −3 | [−4 ; 0] | — / — / 2 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 1 | — | 0 | [−1 ; +1] | — / — / 8 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 16,7 | 10,8 | — | −6,3 | [−8,0 ; −4,6] | — / — / 0 | **B plus bas** |
| Entonnoir : projets envisagés | 8281,5 | 5857 | — | −2173,5 | [−3047 ; −1907] | — / — / 0 | **B plus bas** |
| Entonnoir : créations | 64,5 | 39,5 | — | −29 | [−38,5 ; −20] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, une création déjà ce jour | 243 | 142 | — | −119,5 | [−154,5 ; −85,5] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, délai entre deux créations du type | 781 | 485,5 | — | −397,5 | [−528 ; −281] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, concurrence | 1324,5 | 1323,5 | — | −6,5 | [−90 ; +89,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1444 | 1592 | — | +167,5 | [−36 ; +287,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 509 | 378,5 | — | −161 | [−211,5 ; −64] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, viabilité | 3525 | 1780,5 | — | −1522 | [−1897 ; −1255,5] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, aucun fondateur assez riche | 10,5 | 0 | — | 0 | [−19 ; 0] | — / — / 8 | non concluant |
| Types d’entreprise actifs en fin | 25 | 23 | — | −1,5 | [−3 ; −1] | 6 / 21 / 3 sur 30 | **B plus bas (moins bien)** |
| Machines en fin | 296,9 | 288,1 | — | +0,3 | [−38,4 ; +45,9] | 15 / 15 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 3 | — | 0 | [−1 ; +1] | 13 / 14 / 3 sur 30 | non concluant |
| Bonheur moyen | 0,96 | 0,96 | — | −0,001 | [−0,01 ; +0,01] | 15 / 15 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 2,2 | 2,8 | — | +0,04 | [−1,1 ; +1,8] | 13 / 17 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 65,5 | 49 | — | 0 | [−25,5 ; +38] | 13 / 13 / 4 sur 30 | non concluant |
| Trésor de l’État le plus bas | 3 415 $ | 3 512 $ | — | −255 $ | [−2 685 $ ; +517 $] | 12 / 18 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 24 | non concluant |
| Créances radiées | 9 967 $ | 8 192 $ | — | +556 $ | [−3 251 $ ; +4 526 $] | — / — / 0 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 2 | 1 | 22 → 23 | 0 | [−0,5 ; +1] | 10 / 13 / 7 sur 30 | non concluant |
| … jours-alerte | 80 | 67,5 | — | −1 | [−61,5 ; +9] | 15 / 12 / 3 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 14 → 8 | 0 | [−1 ; 0] | 12 / 5 / 13 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [−18,5 ; 0] | 11 / 6 / 13 sur 30 | non concluant |
| Sans-abri nombreux | 5 | 5 | 30 → 30 | −1 | [−1 ; +1] | 17 / 12 / 1 sur 30 | non concluant |
| … jours-alerte | 78 | 78 | — | +14,5 | [−12,5 ; +25,5] | 11 / 19 / 0 sur 30 | non concluant |
| Inflation quotidienne | 13 | 15 | 30 → 30 | +3 | [+0,5 ; +5] | 9 / 20 / 1 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 14 | 17,5 | — | +3,5 | [+1 ; +7,5] | 9 / 20 / 1 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 0,5 | 18 → 15 | 0 | [0 ; 0] | 8 / 7 / 15 sur 30 | non concluant |
| … jours-alerte | 12,5 | 4 | — | 0 | [0 ; +0,5] | 9 / 10 / 11 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 8 → 7 | 0 | [0 ; 0] | 6 / 4 / 20 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 6 / 6 / 18 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 14,3 % | 13,9 % | 25 → 29 | +0,4 pt | [−0,6 pt ; +3,5 pt] | 15 / 15 / 0 sur 30 | non concluant |
| Chômage max | 39,6 % | 42,1 % | — | +2,9 pt | [−2,1 pt ; +6,7 pt] | 12 / 17 / 1 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 3 → 3 | 0,0 pt | [0,0 pt ; +0,02 pt] | 9 / 12 / 9 sur 30 | non concluant |
| Faim max | 0,8 % | 0,4 % | — | 0,0 pt | [−0,2 pt ; +0,2 pt] | 10 / 10 / 10 sur 30 | non concluant |
| Sans-abri moyen | 1,4 % | 1,3 % | 5 → 8 | +0,2 pt | [−0,5 pt ; +0,5 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Sans-abri max | 39,8 % | 44,0 % | — | 0,0 pt | [−4,2 pt ; +7,1 pt] | 14 / 13 / 3 sur 30 | non concluant |
| Gini moyen | 0,30 | 0,30 | 2 → 2 | +0,01 | [−0,01 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,32 | 0,35 | — | +0,03 | [−0,01 ; +0,05] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,028 % | -0,039 % | 0 → 0 | −0,006 pt | [−0,011 pt ; +0,001 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 19,1 % | 19,6 % | — | +0,5 pt | [−1,1 pt ; +2,6 pt] | 11 / 16 / 3 sur 30 | non concluant |
| |Inflation sur 100 j| max | 91,9 % | 95,8 % | — | 0,0 pt | [0,0 pt ; +4,3 pt] | 8 / 12 / 10 sur 30 | non concluant |
| Alertes critiques ouvertes | 21,5 | 23 | 30 → 30 | −1 | [−4 ; +6,5] | 15 / 14 / 1 sur 30 | non concluant |
| … dont après la chauffe | 20 | 21,5 | — | 0 | [−4 ; +6,5] | 14 / 14 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 166 | 128,5 | — | +4 | [−69,5 ; +65,5] | 14 / 16 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 368,5 | 282,5 | — | −81 | [−104,5 ; −73] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Santé moyenne | 0,87 | 0,87 | — | +0,0001 | [−0,004 ; +0,01] | 15 / 15 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 14,5 | 8,3 | — | −6,4 | [−7,4 ; −5,4] | — / — / 0 | **B plus bas** |
| Naissances / an, en % du parc moyen | 52,1 | 33,3 | — | −19,3 | [−23,4 ; −16,4] | — / — / 0 | **B plus bas** |
| Morts / an, en % du parc moyen | 55,4 | 39,4 | — | −16,2 | [−18,8 ; −14,3] | — / — / 0 | **B plus bas** |
| Parc moyen d’entreprises (après la chauffe) | 27,8 | 25,6 | — | −2,7 | [−3,3 ; −2,4] | — / — / 0 | **B plus bas** |
| Demande non servie (part des unités demandées) | 1,4 % | 1,1 % | — | −0,1 pt | [−0,3 pt ; +0,1 pt] | 17 / 13 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 11,0 % | 7,9 % | — | −4,0 pt | [−5,6 pt ; −0,6 pt] | — / — / 1 | **B plus bas** |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 6 | 5 | — | 0 | [−2,5 ; 0] | — / — / 8 | non concluant |
| Fermetures : faillite (salaires impayables) | 43,5 | 23,5 | — | −19 | [−28 ; −15,5] | — / — / 0 | **B plus bas** |
| Fermetures : demande perdue | 13 | 9,5 | — | −3 | [−4 ; −1] | — / — / 2 | **B plus bas** |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 1 | — | −1 | [−1 ; 0] | — / — / 6 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 15,2 | 9,9 | — | −5,6 | [−6,8 ; −4,9] | — / — / 0 | **B plus bas** |
| Entonnoir : projets envisagés | 7722 | 5470,5 | — | −2147 | [−2720 ; −1628,5] | — / — / 0 | **B plus bas** |
| Entonnoir : créations | 59,5 | 34 | — | −26,5 | [−30,5 ; −22] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, une création déjà ce jour | 224 | 117,5 | — | −115 | [−131,5 ; −103,5] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, délai entre deux créations du type | 350,5 | 217,5 | — | −128 | [−230,5 ; −76] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, concurrence | 1404 | 1390 | — | −3 | [−181 ; +73] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1515 | 1614,5 | — | +74,5 | [−63,5 ; +239,4] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 521,5 | 361 | — | −130 | [−211 ; −86] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, viabilité | 3324 | 1823,5 | — | −1615 | [−2068,5 ; −1226] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, aucun fondateur assez riche | 4 | 0 | — | −1 | [−5 ; 0] | — / — / 6 | non concluant |
| Types d’entreprise actifs en fin | 25 | 22 | — | −3 | [−3,5 ; −1,5] | 6 / 23 / 1 sur 30 | **B plus bas (moins bien)** |
| Machines en fin | 305,3 | 280,1 | — | −24,3 | [−55,5 ; +10,0] | 11 / 19 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 3 | — | −0,5 | [−1 ; +1] | 15 / 11 / 4 sur 30 | non concluant |
| Bonheur moyen | 0,96 | 0,96 | — | −0,002 | [−0,01 ; +0,01] | 14 / 16 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 3,3 | 1,9 | — | −0,04 | [−2,1 ; +0,7] | 16 / 14 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 69,5 | 45 | — | 0 | [−26 ; +15,5] | 13 / 13 / 4 sur 30 | non concluant |
| Trésor de l’État le plus bas | 3 410 $ | 3 598 $ | — | −241 $ | [−955 $ ; +687 $] | 12 / 17 / 1 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 2 740 $ | 2 935 $ | — | +765 $ | [−436 $ ; +3 310 $] | — / — / 1 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,04 | 9 → 9 | 0,00 | [0,00 ; +0,13] | 7 / 11 / 12 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 1,88 | 1,11 | 27 → 17 | −0,79 | [−0,84 ; −0,46] | 26 / 4 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 18,48 | 19,73 | 30 → 29 | −0,25 | [−11,45 ; +10,93] | 16 / 14 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 1,5 | 1 | 23 → 23 | 0 | [−0,5 ; +1] | 10 / 14 / 6 sur 30 | non concluant |
| … jours-alerte | 78 | 47 | — | 0 | [−32,5 ; +40] | 14 / 14 / 2 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 9 → 8 | 0 | [0 ; 0] | 4 / 6 / 20 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 4 / 7 / 19 sur 30 | non concluant |
| Sans-abri nombreux | 5 | 5 | 30 → 30 | −0,5 | [−1,5 ; +2] | 15 / 12 / 3 sur 30 | non concluant |
| … jours-alerte | 79 | 54,5 | — | +8,5 | [−32 ; +15,5] | 13 / 17 / 0 sur 30 | non concluant |
| Inflation quotidienne | 11 | 13,5 | 30 → 30 | +0,5 | [−1,5 ; +3,5] | 11 / 15 / 4 sur 30 | non concluant |
| … jours-alerte | 12 | 15 | — | +1 | [−1,5 ; +3,5] | 12 / 17 / 1 sur 30 | non concluant |
| Inflation sur 100 jours | 0 | 0 | 12 → 14 | 0 | [0 ; 0] | 4 / 6 / 20 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 6 / 7 / 17 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 11 → 7 | 0 | [0 ; 0] | 7 / 3 / 20 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 8 / 6 / 16 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Alertes ouvertes (toutes) : −77,5 [−112 ; −46,5], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Sans filets — Naissances d’entreprises / an : −7,1 [−9,4 ; −4,9] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Naissances / an, en % du parc moyen : −23,1 [−27,9 ; −16,3] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts / an, en % du parc moyen : −19,2 [−24,3 ; −15,3] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Parc moyen d’entreprises (après la chauffe) : −2,6 [−3,3 ; −1,6] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : faillite (salaires impayables) : −24 [−31 ; −19,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts d’entreprises / an : −6,3 [−8,0 ; −4,6] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : projets envisagés : −2173,5 [−3047 ; −1907] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : créations : −29 [−38,5 ; −20] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, une création déjà ce jour : −119,5 [−154,5 ; −85,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, délai entre deux créations du type : −397,5 [−528 ; −281] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, pas assez de chômeurs qualifiés : −161 [−211,5 ; −64] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, viabilité : −1522 [−1897 ; −1255,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Types d’entreprise actifs en fin : −1,5 [−3 ; −1], B moins bien (6 graines mieux, 21 moins bien, 3 égales)
- Sans filets — Inflation quotidienne : +3 [+0,5 ; +5], B moins bien (9 graines mieux, 20 moins bien, 1 égales)
- Sans filets — Inflation quotidienne : jours-alerte : +3,5 [+1 ; +7,5], B moins bien (9 graines mieux, 20 moins bien, 1 égales)
- Avec filets — Alertes ouvertes (toutes) : −81 [−104,5 ; −73], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Avec filets — Naissances d’entreprises / an : −6,4 [−7,4 ; −5,4] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Naissances / an, en % du parc moyen : −19,3 [−23,4 ; −16,4] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts / an, en % du parc moyen : −16,2 [−18,8 ; −14,3] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Parc moyen d’entreprises (après la chauffe) : −2,7 [−3,3 ; −2,4] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) : −4,0 pt [−5,6 pt ; −0,6 pt] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Fermetures : faillite (salaires impayables) : −19 [−28 ; −15,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : demande perdue : −3 [−4 ; −1] (0 graines mieux, 0 moins bien, 2 égales)
- Avec filets — Morts d’entreprises / an : −5,6 [−6,8 ; −4,9] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : projets envisagés : −2147 [−2720 ; −1628,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : créations : −26,5 [−30,5 ; −22] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, une création déjà ce jour : −115 [−131,5 ; −103,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, délai entre deux créations du type : −128 [−230,5 ; −76] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, pas assez de chômeurs qualifiés : −130 [−211 ; −86] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : −1615 [−2068,5 ; −1226] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Types d’entreprise actifs en fin : −3 [−3,5 ; −1,5], B moins bien (6 graines mieux, 23 moins bien, 1 égales)
- Avec filets — Filet : Renflouement d’entreprise / 50 j : −0,79 [−0,84 ; −0,46], B mieux (26 graines mieux, 4 moins bien, 0 égales)

