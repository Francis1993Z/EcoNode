# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 19:15
- A : `g30-ouvert-regle.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1, revival = 1
- B : `g30-ouvert-cout.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1, revival = 1, revivalFullCost = 1
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 14,4 % | 13,9 % | 25 → 27 | +1,1 pt | [−1,1 pt ; +3,1 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Chômage max | 46,3 % | 42,5 % | — | +0,8 pt | [−3,7 pt ; +5,6 pt] | 12 / 15 / 3 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,0 % | 5 → 4 | 0,0 pt | [−0,01 pt ; +0,01 pt] | 10 / 12 / 8 sur 30 | non concluant |
| Faim max | 3,5 % | 1,0 % | — | 0,0 pt | [0,0 pt ; +0,6 pt] | 9 / 12 / 9 sur 30 | non concluant |
| Sans-abri moyen | 1,6 % | 1,7 % | 12 → 11 | −0,2 pt | [−0,9 pt ; +0,2 pt] | 17 / 13 / 0 sur 30 | non concluant |
| Sans-abri max | 56,7 % | 56,0 % | — | 0,0 pt | [−8,3 pt ; +2,7 pt] | 14 / 12 / 4 sur 30 | non concluant |
| Gini moyen | 0,32 | 0,31 | 2 → 1 | +0,003 | [−0,01 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,30 | 0,31 | — | −0,02 | [−0,07 ; +0,04] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,031 % | -0,037 % | 0 → 0 | −0,006 pt | [−0,017 pt ; +0,006 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 27,3 % | 20,9 % | — | 0,0 pt | [−7,7 pt ; 0,0 pt] | 14 / 9 / 7 sur 30 | non concluant |
| |Inflation sur 100 j| max | 115,5 % | 97,9 % | — | 0,0 pt | [−1,4 pt ; 0,0 pt] | 11 / 6 / 13 sur 30 | non concluant |
| Alertes critiques ouvertes | 20,5 | 22,5 | 30 → 30 | +0,5 | [−3,5 ; +2,5] | 12 / 15 / 3 sur 30 | non concluant |
| … dont après la chauffe | 19 | 21 | — | +0,5 | [−3 ; +2,5] | 12 / 15 / 3 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 220,5 | 224 | — | +1,5 | [−125,5 ; +61,5] | 14 / 15 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 377,5 | 349,5 | — | −22,5 | [−56,5 ; −7] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Santé moyenne | 0,87 | 0,87 | — | +0,00002 | [−0,002 ; +0,01] | 16 / 14 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 15,7 | 15,2 | — | −1,6 | [−2,3 ; +0,1] | — / — / 1 | non concluant |
| Naissances / an, en % du parc moyen | 58,1 | 57,0 | — | −3,6 | [−7,5 ; +0,9] | — / — / 0 | non concluant |
| Morts / an, en % du parc moyen | 62,8 | 60,3 | — | −3,3 | [−6,0 ; −0,4] | — / — / 0 | **B plus bas** |
| Parc moyen d’entreprises (après la chauffe) | 27,5 | 27,0 | — | −0,3 | [−0,7 ; +0,1] | — / — / 0 | non concluant |
| Demande non servie (part des unités demandées) | 1,1 % | 1,4 % | — | −0,03 pt | [−0,5 pt ; +0,3 pt] | 17 / 13 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 9,5 % | 10,5 % | — | +1,9 pt | [+0,5 pt ; +5,2 pt] | — / — / 0 | **B plus haut** |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 4 | 4 | — | 0 | [−1 ; +1] | — / — / 5 | non concluant |
| Fermetures : faillite (salaires impayables) | 53 | 47 | — | −2,5 | [−6,5 ; +1,5] | — / — / 1 | non concluant |
| Fermetures : demande perdue | 13 | 12 | — | −0,5 | [−2,5 ; +1,5] | — / — / 1 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 2 | — | 0 | [−1 ; 0] | — / — / 11 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 16,7 | 16,1 | — | −1,3 | [−2,2 ; +0,1] | — / — / 0 | non concluant |
| Entonnoir : projets envisagés | 8281,5 | 8433,5 | — | +126 | [−333,5 ; +411,5] | — / — / 0 | non concluant |
| Entonnoir : créations | 64,5 | 62,5 | — | −6,5 | [−9,5 ; +0,5] | — / — / 1 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 243 | 238 | — | −16 | [−38 ; −5] | — / — / 1 | **B plus bas** |
| Entonnoir : refus, délai entre deux créations du type | 781 | 738,5 | — | −50 | [−262 ; +22,5] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 1324,5 | 1251 | — | −48 | [−121,5 ; +67,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1444 | 1480 | — | +80 | [−14 ; +124,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 509 | 562,5 | — | +99 | [+37 ; +146,0] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 3525 | 3849,5 | — | +163 | [−121,5 ; +379,5] | — / — / 0 | non concluant |
| Entonnoir : refus, aucun fondateur assez riche | 10,5 | 18,5 | — | 0 | [−8 ; +25] | — / — / 6 | non concluant |
| Types d’entreprise actifs en fin | 25 | 25 | — | 0 | [−1 ; +1] | 13 / 12 / 5 sur 30 | non concluant |
| Machines en fin | 296,9 | 301,3 | — | +12,5 | [−27,6 ; +44,5] | 17 / 13 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 4 | — | −0,5 | [−1 ; +1,5] | 15 / 12 / 3 sur 30 | non concluant |
| Bonheur moyen | 0,96 | 0,96 | — | +0,001 | [−0,01 ; +0,005] | 16 / 14 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 2,2 | 2,6 | — | −0,1 | [−1,8 ; +0,2] | 17 / 13 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 65,5 | 56,5 | — | 0 | [−27 ; +11,5] | 11 / 12 / 7 sur 30 | non concluant |
| Trésor de l’État le plus bas | 3 415 $ | 3 495 $ | — | −63 $ | [−655 $ ; +97 $] | 10 / 16 / 4 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 25 | non concluant |
| Créances radiées | 9 967 $ | 4 888 $ | — | −656 $ | [−7 374 $ ; +1 299 $] | — / — / 0 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 2 | 2 | 22 → 22 | 0 | [−0,5 ; +0,5] | 10 / 10 / 10 sur 30 | non concluant |
| … jours-alerte | 80 | 97,5 | — | 0 | [−56,5 ; +13,5] | 11 / 13 / 6 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 14 → 11 | 0 | [0 ; 0] | 9 / 4 / 17 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [−2,5 ; 0] | 10 / 5 / 15 sur 30 | non concluant |
| Sans-abri nombreux | 5 | 5 | 30 → 30 | 0 | [−1 ; +1] | 12 / 11 / 7 sur 30 | non concluant |
| … jours-alerte | 78 | 73,5 | — | −0,5 | [−40,5 ; +8,5] | 15 / 15 / 0 sur 30 | non concluant |
| Inflation quotidienne | 13 | 12 | 30 → 30 | 0 | [−1 ; +1,5] | 12 / 12 / 6 sur 30 | non concluant |
| … jours-alerte | 14 | 14 | — | +0,5 | [−1 ; +2] | 11 / 15 / 4 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 0 | 18 → 14 | 0 | [0 ; 0] | 9 / 5 / 16 sur 30 | non concluant |
| … jours-alerte | 12,5 | 0 | — | 0 | [−4 ; 0] | 11 / 6 / 13 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 8 → 8 | 0 | [0 ; 0] | 6 / 4 / 20 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 5 / 18 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 14,3 % | 15,5 % | 25 → 26 | +0,5 pt | [−0,4 pt ; +2,7 pt] | 12 / 18 / 0 sur 30 | non concluant |
| Chômage max | 39,6 % | 44,8 % | — | +2,7 pt | [−0,6 pt ; +9,0 pt] | 10 / 16 / 4 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 3 → 7 | +0,01 pt | [0,0 pt ; +0,03 pt] | 6 / 17 / 7 sur 30 | non concluant |
| Faim max | 0,8 % | 4,4 % | — | 0,0 pt | [0,0 pt ; +1,7 pt] | 6 / 14 / 10 sur 30 | non concluant |
| Sans-abri moyen | 1,4 % | 1,2 % | 5 → 11 | −0,1 pt | [−0,4 pt ; +0,4 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Sans-abri max | 39,8 % | 40,6 % | — | 0,0 pt | [−7,3 pt ; 0,0 pt] | 14 / 9 / 7 sur 30 | non concluant |
| Gini moyen | 0,30 | 0,32 | 2 → 4 | +0,01 | [−0,01 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,32 | 0,34 | — | +0,02 | [−0,04 ; +0,07] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,028 % | -0,031 % | 0 → 0 | −0,005 pt | [−0,009 pt ; +0,010 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 19,1 % | 22,9 % | — | 0,0 pt | [−0,3 pt ; +2,2 pt] | 10 / 13 / 7 sur 30 | non concluant |
| |Inflation sur 100 j| max | 91,9 % | 115,6 % | — | 0,0 pt | [0,0 pt ; +2,1 pt] | 5 / 11 / 14 sur 30 | non concluant |
| Alertes critiques ouvertes | 21,5 | 25 | 30 → 30 | +2 | [−3,5 ; +8] | 14 / 16 / 0 sur 30 | non concluant |
| … dont après la chauffe | 20 | 23,5 | — | +2 | [−3,5 ; +8] | 14 / 16 / 0 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 166 | 234 | — | +2,5 | [−38,5 ; +96] | 15 / 15 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 368,5 | 361,5 | — | −28,5 | [−43,5 ; +4,5] | 18 / 11 / 1 sur 30 | non concluant |
| Santé moyenne | 0,87 | 0,87 | — | +0,0004 | [−0,01 ; +0,005] | 16 / 14 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 14,5 | 12,9 | — | −1,8 | [−2,4 ; −0,4] | — / — / 2 | **B plus bas** |
| Naissances / an, en % du parc moyen | 52,1 | 46,7 | — | −5,2 | [−8,0 ; +0,5] | — / — / 0 | non concluant |
| Morts / an, en % du parc moyen | 55,4 | 51,9 | — | −3,3 | [−7,9 ; −0,1] | — / — / 0 | **B plus bas** |
| Parc moyen d’entreprises (après la chauffe) | 27,8 | 27,6 | — | −0,4 | [−1,1 ; +0,1] | — / — / 0 | non concluant |
| Demande non servie (part des unités demandées) | 1,4 % | 1,5 % | — | −0,04 pt | [−0,2 pt ; +0,4 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 11,0 % | 10,2 % | — | −0,3 pt | [−4,3 pt ; +1,8 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 6 | 5 | — | 0 | [−2 ; +1] | — / — / 5 | non concluant |
| Fermetures : faillite (salaires impayables) | 43,5 | 39,5 | — | −6,5 | [−10,5 ; −0,5] | — / — / 1 | **B plus bas** |
| Fermetures : demande perdue | 13 | 12,5 | — | +1 | [−0,5 ; +2,5] | — / — / 2 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 2 | — | 0 | [−0,5 ; 0] | — / — / 12 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 15,2 | 14,0 | — | −1,6 | [−2,4 ; −0,1] | — / — / 1 | **B plus bas** |
| Entonnoir : projets envisagés | 7722 | 8195,5 | — | +316 | [−57,5 ; +693] | — / — / 0 | non concluant |
| Entonnoir : créations | 59,5 | 53 | — | −7,5 | [−10 ; −1,5] | — / — / 2 | **B plus bas** |
| Entonnoir : refus, une création déjà ce jour | 224 | 201,5 | — | −19 | [−46,5 ; −9,5] | — / — / 2 | **B plus bas** |
| Entonnoir : refus, délai entre deux créations du type | 350,5 | 278 | — | −34,5 | [−108,5 ; −1,5] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, concurrence | 1404 | 1381,5 | — | +5,5 | [−57 ; +58,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1515 | 1534 | — | +1,5 | [−87,5 ; +135,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 521,5 | 557,5 | — | +35,5 | [−89 ; +129,5] | — / — / 0 | non concluant |
| Entonnoir : refus, viabilité | 3324 | 3605,5 | — | +328 | [−38 ; +540,5] | — / — / 0 | non concluant |
| Entonnoir : refus, aucun fondateur assez riche | 4 | 0,5 | — | −0,5 | [−3 ; 0] | — / — / 6 | non concluant |
| Types d’entreprise actifs en fin | 25 | 25 | — | 0 | [−1 ; +1] | 11 / 13 / 6 sur 30 | non concluant |
| Machines en fin | 305,3 | 298,6 | — | −9,3 | [−43,1 ; +24,4] | 13 / 17 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 3 | — | −0,5 | [−1 ; +1,5] | 15 / 12 / 3 sur 30 | non concluant |
| Bonheur moyen | 0,96 | 0,95 | — | +0,001 | [−0,01 ; +0,003] | 16 / 14 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 3,3 | 2,7 | — | −0,1 | [−1,1 ; +2,4] | 15 / 15 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 69,5 | 87,5 | — | 0 | [−13 ; +40,5] | 12 / 12 / 6 sur 30 | non concluant |
| Trésor de l’État le plus bas | 3 410 $ | 3 013 $ | — | 0 $ | [−1 241 $ ; +67 $] | 11 / 14 / 5 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 2 740 $ | 3 339 $ | — | 0 $ | [−1 155 $ ; +1 276 $] | — / — / 3 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,05 | 9 → 13 | 0,00 | [0,00 ; +0,29] | 5 / 11 / 14 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 1,88 | 1,59 | 27 → 25 | −0,34 | [−0,71 ; +0,25] | 17 / 12 / 1 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 18,48 | 16,05 | 30 → 28 | −0,11 | [−9,57 ; +9,68] | 15 / 15 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 1,5 | 2 | 23 → 22 | 0 | [0 ; +1] | 9 / 13 / 8 sur 30 | non concluant |
| … jours-alerte | 78 | 87,5 | — | +4 | [−23,5 ; +36] | 12 / 15 / 3 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 9 → 13 | 0 | [0 ; 0] | 2 / 9 / 19 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 9 / 18 sur 30 | non concluant |
| Sans-abri nombreux | 5 | 5 | 30 → 30 | 0 | [−1 ; +1] | 12 / 12 / 6 sur 30 | non concluant |
| … jours-alerte | 79 | 86,5 | — | −0,5 | [−13,5 ; +19,5] | 15 / 15 / 0 sur 30 | non concluant |
| Inflation quotidienne | 11 | 13 | 30 → 30 | +1 | [−1,5 ; +3,5] | 13 / 16 / 1 sur 30 | non concluant |
| … jours-alerte | 12 | 14,5 | — | +1,5 | [−2 ; +4] | 14 / 16 / 0 sur 30 | non concluant |
| Inflation sur 100 jours | 0 | 1 | 12 → 17 | 0 | [0 ; 0] | 2 / 8 / 20 sur 30 | non concluant |
| … jours-alerte | 0 | 9,5 | — | 0 | [0 ; 0] | 4 / 9 / 17 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 11 → 11 | 0 | [0 ; 0] | 6 / 7 / 17 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; +2] | 7 / 10 / 13 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Alertes ouvertes (toutes) : −22,5 [−56,5 ; −7], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Sans filets — Morts / an, en % du parc moyen : −3,3 [−6,0 ; −0,4] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) : +1,9 pt [+0,5 pt ; +5,2 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, une création déjà ce jour : −16 [−38 ; −5] (0 graines mieux, 0 moins bien, 1 égales)
- Sans filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +99 [+37 ; +146,0] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Naissances d’entreprises / an : −1,8 [−2,4 ; −0,4] (0 graines mieux, 0 moins bien, 2 égales)
- Avec filets — Morts / an, en % du parc moyen : −3,3 [−7,9 ; −0,1] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : faillite (salaires impayables) : −6,5 [−10,5 ; −0,5] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Morts d’entreprises / an : −1,6 [−2,4 ; −0,1] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Entonnoir : créations : −7,5 [−10 ; −1,5] (0 graines mieux, 0 moins bien, 2 égales)
- Avec filets — Entonnoir : refus, une création déjà ce jour : −19 [−46,5 ; −9,5] (0 graines mieux, 0 moins bien, 2 égales)
- Avec filets — Entonnoir : refus, délai entre deux créations du type : −34,5 [−108,5 ; −1,5] (0 graines mieux, 0 moins bien, 0 égales)

