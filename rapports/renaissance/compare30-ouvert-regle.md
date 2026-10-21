# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 18:46
- A : `g30-ouvert-ref.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1
- B : `g30-ouvert-signal.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1, revival = 1, revivalHours = 0
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 17,9 % | 14,4 % | 29 → 25 | −4,6 pt | [−6,0 pt ; −2,9 pt] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 52,3 % | 46,3 % | — | −7,5 pt | [−12,9 pt ; −1,7 pt] | 20 / 10 / 0 sur 30 | **B plus bas (mieux)** |
| Faim moyenne | 0,1 % | 0,1 % | 6 → 5 | 0,0 pt | [−0,1 pt ; 0,0 pt] | 14 / 9 / 7 sur 30 | non concluant |
| Faim max | 6,5 % | 3,5 % | — | 0,0 pt | [−5,2 pt ; 0,0 pt] | 14 / 9 / 7 sur 30 | non concluant |
| Sans-abri moyen | 1,5 % | 1,6 % | 13 → 12 | −0,1 pt | [−0,7 pt ; +0,7 pt] | 15 / 15 / 0 sur 30 | non concluant |
| Sans-abri max | 47,1 % | 56,7 % | — | 0,0 pt | [−1,3 pt ; +12,5 pt] | 14 / 14 / 2 sur 30 | non concluant |
| Gini moyen | 0,34 | 0,32 | 4 → 2 | −0,03 | [−0,04 ; −0,01] | — / — / 0 | **B plus bas** |
| Gini en fin de partie | 0,37 | 0,30 | — | −0,01 | [−0,07 ; +0,03] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,023 % | -0,031 % | 0 → 0 | −0,004 pt | [−0,019 pt ; +0,011 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 30,3 % | 27,3 % | — | 0,0 pt | [−10,0 pt ; +4,9 pt] | 14 / 13 / 3 sur 30 | non concluant |
| |Inflation sur 100 j| max | 130,7 % | 115,5 % | — | −3,3 pt | [−31,1 pt ; +11,8 pt] | 16 / 10 / 4 sur 30 | non concluant |
| Alertes critiques ouvertes | 26,5 | 20,5 | 30 → 30 | −3,5 | [−9 ; +1] | 18 / 11 / 1 sur 30 | non concluant |
| … dont après la chauffe | 23,5 | 19 | — | −3,5 | [−8 ; +0,5] | 18 / 10 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 335,5 | 220,5 | — | −84,5 | [−223,5 ; −21,5] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 184 | 377,5 | — | +185,5 | [+159,5 ; +230] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,85 | 0,87 | — | +0,01 | [−0,0003 ; +0,02] | 19 / 11 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 1,5 | 15,7 | — | +14,4 | [+12,9 ; +16,4] | — / — / 0 | **B plus haut** |
| Naissances / an, en % du parc moyen | 7,5 | 58,1 | — | +50,1 | [+44,9 ; +55,0] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 26,9 | 62,8 | — | +36,1 | [+30,1 ; +40,1] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 20,0 | 27,5 | — | +7,7 | [+6,7 ; +8,3] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 2,3 % | 1,1 % | — | −0,5 pt | [−1,5 pt ; −0,1 pt] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 9,4 % | 9,5 % | — | −1,1 pt | [−2,6 pt ; +0,6 pt] | — / — / 1 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 2 | 4 | — | +1 | [0 ; +2] | — / — / 7 | non concluant |
| Fermetures : faillite (salaires impayables) | 13 | 53 | — | +39,5 | [+34 ; +44,5] | — / — / 0 | **B plus haut** |
| Fermetures : demande perdue | 4 | 13 | — | +8 | [+5 ; +8,5] | — / — / 0 | **B plus haut** |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 2 | — | +1 | [0 ; +2] | — / — / 8 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 5,4 | 16,7 | — | +11,7 | [+10,5 ; +13,1] | — / — / 0 | **B plus haut** |
| Entonnoir : projets envisagés | 3276 | 8281,5 | — | +5051,5 | [+4486,5 ; +5355] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 6 | 64,5 | — | +59 | [+53 ; +67,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 4,5 | 243 | — | +236,5 | [+212,5 ; +299] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, délai entre deux créations du type | 322 | 781 | — | +453 | [+334,5 ; +646,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, concurrence | 1162,5 | 1324,5 | — | +94 | [−1 ; +278,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1509 | 1444 | — | −80 | [−240,5 ; +7,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 23 | 509 | — | +487,5 | [+406,5 ; +569] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 88,5 | 3525 | — | +3379 | [+3075 ; +3845] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 8,5 | 10,5 | — | 0 | [−18,5 ; +15] | — / — / 5 | non concluant |
| Types d’entreprise actifs en fin | 14 | 25 | — | +10,5 | [+9 ; +11] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Machines en fin | 192,0 | 296,9 | — | +55,3 | [+40,2 ; +101,7] | 23 / 7 / 0 sur 30 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 0 | 3 | — | +3 | [+2 ; +4] | 3 / 24 / 3 sur 30 | **B plus haut (moins bien)** |
| Bonheur moyen | 0,95 | 0,96 | — | +0,01 | [−0,001 ; +0,02] | 19 / 11 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 5,6 | 2,2 | — | −2,1 | [−4,1 ; +0,05] | 19 / 11 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 120,5 | 65,5 | — | −38,5 | [−65 ; 0] | 18 / 9 / 3 sur 30 | non concluant |
| Trésor de l’État le plus bas | 2 793 $ | 3 415 $ | — | +930 $ | [+14 $ ; +5 884 $] | 20 / 10 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 24 | non concluant |
| Créances radiées | 4 980 $ | 9 967 $ | — | +5 374 $ | [−31 $ ; +8 900 $] | — / — / 0 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 3 | 2 | 25 → 22 | −1 | [−2 ; 0] | 17 / 7 / 6 sur 30 | non concluant |
| … jours-alerte | 164 | 80 | — | −32 | [−118,5 ; 0] | 19 / 8 / 3 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 14 → 14 | 0 | [0 ; 0] | 9 / 9 / 12 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [−9,5 ; 0] | 11 / 9 / 10 sur 30 | non concluant |
| Sans-abri nombreux | 4 | 5 | 30 → 30 | 0 | [−1 ; +1] | 12 / 13 / 5 sur 30 | non concluant |
| … jours-alerte | 88 | 78 | — | +6 | [−25 ; +34,5] | 13 / 16 / 1 sur 30 | non concluant |
| Inflation quotidienne | 15 | 13 | 30 → 30 | 0 | [−3,5 ; +2] | 14 / 12 / 4 sur 30 | non concluant |
| … jours-alerte | 16 | 14 | — | +1 | [−4 ; +3] | 13 / 16 / 1 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 1 | 22 → 18 | −1 | [−1 ; 0] | 18 / 5 / 7 sur 30 | non concluant |
| … jours-alerte | 28 | 12,5 | — | −9 | [−31,5 ; 0] | 19 / 6 / 5 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 13 → 8 | 0 | [0 ; 0] | 7 / 4 / 19 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 9 / 6 / 15 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 19,4 % | 14,3 % | 29 → 25 | −5,7 pt | [−8,4 pt ; −2,0 pt] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 55,8 % | 39,6 % | — | −12,7 pt | [−21,9 pt ; −1,7 pt] | 22 / 7 / 1 sur 30 | **B plus bas (mieux)** |
| Faim moyenne | 0,2 % | 0,0 % | 8 → 3 | −0,1 pt | [−0,5 pt ; 0,0 pt] | 19 / 6 / 5 sur 30 | non concluant |
| Faim max | 9,8 % | 0,8 % | — | −1,2 pt | [−12,7 pt ; 0,0 pt] | 18 / 5 / 7 sur 30 | non concluant |
| Sans-abri moyen | 1,9 % | 1,4 % | 13 → 5 | −0,4 pt | [−1,4 pt ; +0,2 pt] | 17 / 13 / 0 sur 30 | non concluant |
| Sans-abri max | 42,3 % | 39,8 % | — | 0,0 pt | [−5,4 pt ; +0,6 pt] | 14 / 12 / 4 sur 30 | non concluant |
| Gini moyen | 0,34 | 0,30 | 5 → 2 | −0,03 | [−0,07 ; −0,01] | — / — / 0 | **B plus bas** |
| Gini en fin de partie | 0,33 | 0,32 | — | −0,02 | [−0,06 ; +0,03] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,010 % | -0,028 % | 0 → 0 | −0,018 pt | [−0,039 pt ; −0,010 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 32,4 % | 19,1 % | — | −4,4 pt | [−12,2 pt ; −2,9 pt] | 22 / 5 / 3 sur 30 | **B plus bas (mieux)** |
| |Inflation sur 100 j| max | 132,9 % | 91,9 % | — | −12,0 pt | [−28,0 pt ; 0,0 pt] | 19 / 3 / 8 sur 30 | non concluant |
| Alertes critiques ouvertes | 28,5 | 21,5 | 30 → 30 | −2 | [−10 ; +0,5] | 18 / 10 / 2 sur 30 | non concluant |
| … dont après la chauffe | 26,5 | 20 | — | −2,5 | [−9 ; +0,5] | 18 / 10 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 436 | 166 | — | −120 | [−318,5 ; −36,5] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 182,5 | 368,5 | — | +178,5 | [+161,5 ; +205,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,84 | 0,87 | — | +0,02 | [+0,004 ; +0,03] | 22 / 8 / 0 sur 30 | **B plus haut (mieux)** |
| Naissances d’entreprises / an | 0,7 | 14,5 | — | +13,6 | [+12,5 ; +15,1] | — / — / 0 | **B plus haut** |
| Naissances / an, en % du parc moyen | 3,3 | 52,1 | — | +47,9 | [+44,4 ; +53,0] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 19,5 | 55,4 | — | +35,7 | [+32,6 ; +38,8] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 20,6 | 27,8 | — | +7,5 | [+6,7 ; +8,4] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 2,8 % | 1,4 % | — | −1,1 pt | [−2,1 pt ; −0,4 pt] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 9,6 % | 11,0 % | — | +0,6 pt | [−2,7 pt ; +4,3 pt] | — / — / 1 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 3 | 6 | — | +2,5 | [+1,5 ; +4,5] | — / — / 2 | **B plus haut** |
| Fermetures : faillite (salaires impayables) | 8 | 43,5 | — | +35,5 | [+32 ; +44,5] | — / — / 0 | **B plus haut** |
| Fermetures : demande perdue | 4 | 13 | — | +9 | [+6 ; +11] | — / — / 1 | **B plus haut** |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 2 | — | +1 | [0 ; +1] | — / — / 9 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 3,9 | 15,2 | — | +10,9 | [+10,6 ; +13,0] | — / — / 0 | **B plus haut** |
| Entonnoir : projets envisagés | 3324 | 7722 | — | +4407 | [+3949,5 ; +4735,5] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 3 | 59,5 | — | +56 | [+51,5 ; +62] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 2 | 224 | — | +222 | [+204 ; +248] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, délai entre deux créations du type | 118,5 | 350,5 | — | +210 | [+117 ; +275] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, concurrence | 1476,5 | 1404 | — | −47 | [−141,5 ; +184] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1503 | 1515 | — | +17,5 | [−331,5 ; +257] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 10,5 | 521,5 | — | +519,5 | [+432,5 ; +600,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 16 | 3324 | — | +3255,5 | [+2821 ; +3943] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 0 | 4 | — | +4 | [0 ; +19,5] | — / — / 9 | non concluant |
| Types d’entreprise actifs en fin | 15 | 25 | — | +10 | [+9 ; +11] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Machines en fin | 182,1 | 305,3 | — | +132,3 | [+87,8 ; +147,9] | 28 / 2 / 0 sur 30 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 1 | 3 | — | +2,5 | [+1,5 ; +3,5] | 5 / 24 / 1 sur 30 | **B plus haut (moins bien)** |
| Bonheur moyen | 0,94 | 0,96 | — | +0,01 | [+0,01 ; +0,02] | 21 / 9 / 0 sur 30 | **B plus haut (mieux)** |
| Hôpital public : attente moyenne (j) | 7,3 | 3,3 | — | −3,3 | [−6,2 ; −1,0] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Jours de prestations réduites | 129,5 | 69,5 | — | −76,5 | [−118,5 ; −12,5] | 22 / 5 / 3 sur 30 | **B plus bas (mieux)** |
| Trésor de l’État le plus bas | 2 463 $ | 3 410 $ | — | +1 020 $ | [+77 $ ; +3 118 $] | 21 / 8 / 1 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 2 740 $ | — | +2 288 $ | [+588 $ ; +5 665 $] | — / — / 3 | **B plus haut** |
| Filet : Anti-famine / 50 j | 3,30 | 0,00 | 19 → 9 | −1,98 | [−9,86 ; 0,00] | 17 / 5 / 8 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 1,52 | 1,88 | 17 → 27 | +0,79 | [−0,39 ; +0,96] | 12 / 18 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 32,82 | 18,48 | 29 → 30 | −15,25 | [−36,64 ; +4,21] | 18 / 12 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 2 | 1,5 | 28 → 23 | −0,5 | [−1 ; 0] | 15 / 2 / 13 sur 30 | non concluant |
| … jours-alerte | 166,5 | 78 | — | −61 | [−149 ; −7] | 20 / 8 / 2 sur 30 | **B plus bas (mieux)** |
| Faim répandue | 1 | 0 | 16 → 9 | 0 | [−1 ; 0] | 13 / 2 / 15 sur 30 | non concluant |
| … jours-alerte | 1,5 | 0 | — | −0,5 | [−27 ; 0] | 15 / 2 / 13 sur 30 | non concluant |
| Sans-abri nombreux | 5 | 5 | 30 → 30 | +1 | [−0,5 ; +1,5] | 10 / 16 / 4 sur 30 | non concluant |
| … jours-alerte | 120,5 | 79 | — | −19,5 | [−52 ; +9,5] | 19 / 11 / 0 sur 30 | non concluant |
| Inflation quotidienne | 15 | 11 | 30 → 30 | −0,5 | [−4 ; +2] | 15 / 12 / 3 sur 30 | non concluant |
| … jours-alerte | 16 | 12 | — | 0 | [−4 ; +2] | 14 / 14 / 2 sur 30 | non concluant |
| Inflation sur 100 jours | 1,5 | 0 | 20 → 12 | −0,5 | [−1,5 ; 0] | 15 / 1 / 14 sur 30 | non concluant |
| … jours-alerte | 23,5 | 0 | — | −1 | [−25,5 ; 0] | 15 / 4 / 11 sur 30 | non concluant |
| Santé de la population effondrée | 1 | 0 | 17 → 11 | 0 | [0 ; 0] | 9 / 3 / 18 sur 30 | non concluant |
| … jours-alerte | 16,5 | 0 | — | −2,5 | [−29,5 ; 0] | 15 / 5 / 10 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Chômage moyen : −4,6 pt [−6,0 pt ; −2,9 pt], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Sans filets — Chômage max : −7,5 pt [−12,9 pt ; −1,7 pt], B mieux (20 graines mieux, 10 moins bien, 0 égales)
- Sans filets — Gini moyen : −0,03 [−0,04 ; −0,01] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Jours-alerte critiques (somme des types) : −84,5 [−223,5 ; −21,5], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Sans filets — Alertes ouvertes (toutes) : +185,5 [+159,5 ; +230], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Sans filets — Naissances d’entreprises / an : +14,4 [+12,9 ; +16,4] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Naissances / an, en % du parc moyen : +50,1 [+44,9 ; +55,0] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts / an, en % du parc moyen : +36,1 [+30,1 ; +40,1] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Parc moyen d’entreprises (après la chauffe) : +7,7 [+6,7 ; +8,3] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Demande non servie (part des unités demandées) : −0,5 pt [−1,5 pt ; −0,1 pt], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Sans filets — Fermetures : faillite (salaires impayables) : +39,5 [+34 ; +44,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : demande perdue : +8 [+5 ; +8,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts d’entreprises / an : +11,7 [+10,5 ; +13,1] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : projets envisagés : +5051,5 [+4486,5 ; +5355] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : créations : +59 [+53 ; +67,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, une création déjà ce jour : +236,5 [+212,5 ; +299] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, délai entre deux créations du type : +453 [+334,5 ; +646,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +487,5 [+406,5 ; +569] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, viabilité : +3379 [+3075 ; +3845] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Types d’entreprise actifs en fin : +10,5 [+9 ; +11], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Machines en fin : +55,3 [+40,2 ; +101,7], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Sans filets — Équipes utilisées à moins de 15 % (fin) : +3 [+2 ; +4], B moins bien (3 graines mieux, 24 moins bien, 3 égales)
- Sans filets — Trésor de l’État le plus bas : +930 $ [+14 $ ; +5 884 $], B mieux (20 graines mieux, 10 moins bien, 0 égales)
- Avec filets — Chômage moyen : −5,7 pt [−8,4 pt ; −2,0 pt], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets — Chômage max : −12,7 pt [−21,9 pt ; −1,7 pt], B mieux (22 graines mieux, 7 moins bien, 1 égales)
- Avec filets — Gini moyen : −0,03 [−0,07 ; −0,01] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Inflation moyenne / j : −0,018 pt [−0,039 pt ; −0,010 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — |Inflation| max / j : −4,4 pt [−12,2 pt ; −2,9 pt], B mieux (22 graines mieux, 5 moins bien, 3 égales)
- Avec filets — Jours-alerte critiques (somme des types) : −120 [−318,5 ; −36,5], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets — Alertes ouvertes (toutes) : +178,5 [+161,5 ; +205,5], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets — Santé moyenne : +0,02 [+0,004 ; +0,03], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets — Naissances d’entreprises / an : +13,6 [+12,5 ; +15,1] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Naissances / an, en % du parc moyen : +47,9 [+44,4 ; +53,0] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts / an, en % du parc moyen : +35,7 [+32,6 ; +38,8] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Parc moyen d’entreprises (après la chauffe) : +7,5 [+6,7 ; +8,4] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Demande non servie (part des unités demandées) : −1,1 pt [−2,1 pt ; −0,4 pt], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets — Fermetures : prix aberrant : +2,5 [+1,5 ; +4,5] (0 graines mieux, 0 moins bien, 2 égales)
- Avec filets — Fermetures : faillite (salaires impayables) : +35,5 [+32 ; +44,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : demande perdue : +9 [+6 ; +11] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Morts d’entreprises / an : +10,9 [+10,6 ; +13,0] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : projets envisagés : +4407 [+3949,5 ; +4735,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : créations : +56 [+51,5 ; +62] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, une création déjà ce jour : +222 [+204 ; +248] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, délai entre deux créations du type : +210 [+117 ; +275] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +519,5 [+432,5 ; +600,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : +3255,5 [+2821 ; +3943] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Types d’entreprise actifs en fin : +10 [+9 ; +11], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Machines en fin : +132,3 [+87,8 ; +147,9], B mieux (28 graines mieux, 2 moins bien, 0 égales)
- Avec filets — Équipes utilisées à moins de 15 % (fin) : +2,5 [+1,5 ; +3,5], B moins bien (5 graines mieux, 24 moins bien, 1 égales)
- Avec filets — Bonheur moyen : +0,01 [+0,01 ; +0,02], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Hôpital public : attente moyenne (j) : −3,3 [−6,2 ; −1,0], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets — Jours de prestations réduites : −76,5 [−118,5 ; −12,5], B mieux (22 graines mieux, 5 moins bien, 3 égales)
- Avec filets — Trésor de l’État le plus bas : +1 020 $ [+77 $ ; +3 118 $], B mieux (21 graines mieux, 8 moins bien, 1 égales)
- Avec filets — Créances radiées : +2 288 $ [+588 $ ; +5 665 $] (0 graines mieux, 0 moins bien, 3 égales)
- Avec filets — Chômage très élevé : jours-alerte : −61 [−149 ; −7], B mieux (20 graines mieux, 8 moins bien, 2 égales)

