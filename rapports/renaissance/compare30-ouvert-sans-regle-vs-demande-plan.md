# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 19:18
- A : `g30-ouvert-sans.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1, revival = 0
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
| Chômage moyen | 17,9 % | 15,1 % | 29 → 26 | −4,0 pt | [−5,4 pt ; −0,3 pt] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 52,3 % | 41,5 % | — | −3,8 pt | [−8,1 pt ; −0,2 pt] | 20 / 8 / 2 sur 30 | **B plus bas (mieux)** |
| Faim moyenne | 0,1 % | 0,0 % | 6 → 2 | −0,003 pt | [−0,1 pt ; 0,0 pt] | 15 / 7 / 8 sur 30 | non concluant |
| Faim max | 6,5 % | 0,6 % | — | 0,0 pt | [−4,0 pt ; 0,0 pt] | 14 / 7 / 9 sur 30 | non concluant |
| Sans-abri moyen | 1,5 % | 1,5 % | 13 → 11 | +0,1 pt | [−1,4 pt ; +0,6 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Sans-abri max | 47,1 % | 57,3 % | — | +2,7 pt | [0,0 pt ; +13,5 pt] | 9 / 17 / 4 sur 30 | non concluant |
| Gini moyen | 0,34 | 0,32 | 4 → 2 | −0,02 | [−0,07 ; −0,002] | — / — / 0 | **B plus bas** |
| Gini en fin de partie | 0,37 | 0,31 | — | −0,03 | [−0,11 ; +0,02] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,023 % | -0,030 % | 0 → 0 | −0,011 pt | [−0,018 pt ; +0,003 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 30,3 % | 21,8 % | — | 0,0 pt | [−3,7 pt ; +1,8 pt] | 13 / 12 / 5 sur 30 | non concluant |
| |Inflation sur 100 j| max | 130,7 % | 105,0 % | — | −0,2 pt | [−11,6 pt ; 0,0 pt] | 16 / 6 / 8 sur 30 | non concluant |
| Alertes critiques ouvertes | 26,5 | 24 | 30 → 30 | −1,5 | [−6 ; +4,5] | 15 / 13 / 2 sur 30 | non concluant |
| … dont après la chauffe | 23,5 | 23 | — | −1,5 | [−6 ; +4,5] | 15 / 13 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 335,5 | 183 | — | −53,5 | [−304 ; −16,5] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 184 | 295,5 | — | +110 | [+91,5 ; +142] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,85 | 0,87 | — | +0,003 | [−0,0003 ; +0,03] | 19 / 11 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 1,5 | 9,6 | — | +8,3 | [+6,8 ; +8,8] | — / — / 0 | **B plus haut** |
| Naissances / an, en % du parc moyen | 7,5 | 38,6 | — | +31,1 | [+26,6 ; +34,0] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 26,9 | 45,3 | — | +18,8 | [+14,7 ; +22,0] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 20,0 | 24,6 | — | +4,7 | [+3,9 ; +5,5] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 2,3 % | 1,5 % | — | −0,2 pt | [−1,8 pt ; +0,2 pt] | 19 / 11 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 9,4 % | 10,5 % | — | +1,1 pt | [−2,6 pt ; +3,4 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 2 | 5 | — | +2 | [+1,5 ; +3,5] | — / — / 1 | **B plus haut** |
| Fermetures : faillite (salaires impayables) | 13 | 26,5 | — | +13,5 | [+11,5 ; +16] | — / — / 0 | **B plus haut** |
| Fermetures : demande perdue | 4 | 11 | — | +6,5 | [+4,5 ; +8] | — / — / 1 | **B plus haut** |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | +0,5 | [0 ; +1,5] | — / — / 10 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 5,4 | 10,8 | — | +6,2 | [+4,7 ; +6,8] | — / — / 0 | **B plus haut** |
| Entonnoir : projets envisagés | 3276 | 5857 | — | +2422 | [+2078 ; +2789,5] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 6 | 39,5 | — | +34 | [+28 ; +36] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 4,5 | 142 | — | +129,5 | [+117 ; +156] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, délai entre deux créations du type | 322 | 485,5 | — | +127,5 | [+50,5 ; +250] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, concurrence | 1162,5 | 1323,5 | — | +16 | [−57,5 ; +219,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1509 | 1592 | — | +60 | [−104,5 ; +416] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 23 | 378,5 | — | +346 | [+277,5 ; +383,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 88,5 | 1780,5 | — | +1742 | [+1415,5 ; +1988,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 8,5 | 0 | — | 0 | [−15 ; 0] | — / — / 10 | non concluant |
| Types d’entreprise actifs en fin | 14 | 23 | — | +8 | [+8 ; +9] | 29 / 1 / 0 sur 30 | **B plus haut (mieux)** |
| Machines en fin | 192,0 | 288,1 | — | +92,9 | [+27,7 ; +147,2] | 22 / 8 / 0 sur 30 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 0 | 3 | — | +2 | [+1 ; +3] | 4 / 23 / 3 sur 30 | **B plus haut (moins bien)** |
| Bonheur moyen | 0,95 | 0,96 | — | +0,01 | [−0,003 ; +0,02] | 18 / 12 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 5,6 | 2,8 | — | −0,3 | [−5,0 ; +0,2] | 16 / 14 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 120,5 | 49 | — | −28,5 | [−86,5 ; 0] | 17 / 7 / 6 sur 30 | non concluant |
| Trésor de l’État le plus bas | 2 793 $ | 3 512 $ | — | +523 $ | [+115 $ ; +1 114 $] | 23 / 5 / 2 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 25 | non concluant |
| Créances radiées | 4 980 $ | 8 192 $ | — | +4 992 $ | [+744 $ ; +7 618 $] | — / — / 0 | **B plus haut** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 3 | 1 | 25 → 23 | −1 | [−2 ; 0] | 16 / 5 / 9 sur 30 | non concluant |
| … jours-alerte | 164 | 67,5 | — | −52 | [−115,5 ; 0] | 19 / 7 / 4 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 14 → 8 | 0 | [−0,5 ; 0] | 10 / 2 / 18 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [−9,5 ; 0] | 11 / 3 / 16 sur 30 | non concluant |
| Sans-abri nombreux | 4 | 5 | 30 → 30 | +1 | [0 ; +1] | 8 / 16 / 6 sur 30 | non concluant |
| … jours-alerte | 88 | 78 | — | +1,5 | [−46 ; +24] | 14 / 15 / 1 sur 30 | non concluant |
| Inflation quotidienne | 15 | 15 | 30 → 30 | +1 | [−2 ; +6] | 13 / 16 / 1 sur 30 | non concluant |
| … jours-alerte | 16 | 17,5 | — | +1 | [−4 ; +7] | 13 / 16 / 1 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 0,5 | 22 → 15 | −0,5 | [−1,5 ; 0] | 15 / 3 / 12 sur 30 | non concluant |
| … jours-alerte | 28 | 4 | — | −1,5 | [−13,5 ; 0] | 15 / 5 / 10 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 13 → 7 | 0 | [0 ; 0] | 8 / 3 / 19 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [−3 ; 0] | 10 / 3 / 17 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 19,4 % | 13,9 % | 29 → 29 | −4,4 pt | [−6,1 pt ; −2,4 pt] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 55,8 % | 42,1 % | — | −6,5 pt | [−24,8 pt ; −0,4 pt] | 20 / 6 / 4 sur 30 | **B plus bas (mieux)** |
| Faim moyenne | 0,2 % | 0,0 % | 8 → 3 | −0,05 pt | [−0,5 pt ; 0,0 pt] | 17 / 6 / 7 sur 30 | non concluant |
| Faim max | 9,8 % | 0,4 % | — | −0,6 pt | [−14,8 pt ; 0,0 pt] | 16 / 5 / 9 sur 30 | non concluant |
| Sans-abri moyen | 1,9 % | 1,3 % | 13 → 8 | −0,3 pt | [−1,0 pt ; +0,5 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Sans-abri max | 42,3 % | 44,0 % | — | 0,0 pt | [−2,1 pt ; +5,6 pt] | 11 / 13 / 6 sur 30 | non concluant |
| Gini moyen | 0,34 | 0,30 | 5 → 2 | −0,03 | [−0,03 ; −0,005] | — / — / 0 | **B plus bas** |
| Gini en fin de partie | 0,33 | 0,35 | — | −0,003 | [−0,04 ; +0,06] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,010 % | -0,039 % | 0 → 0 | −0,024 pt | [−0,043 pt ; −0,012 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 32,4 % | 19,6 % | — | −1,0 pt | [−10,5 pt ; 0,0 pt] | 16 / 8 / 6 sur 30 | non concluant |
| |Inflation sur 100 j| max | 132,9 % | 95,8 % | — | −0,5 pt | [−22,5 pt ; 0,0 pt] | 15 / 4 / 11 sur 30 | non concluant |
| Alertes critiques ouvertes | 28,5 | 23 | 30 → 30 | −4 | [−9,5 ; +3] | 16 / 14 / 0 sur 30 | non concluant |
| … dont après la chauffe | 26,5 | 21,5 | — | −4 | [−9,5 ; +3] | 16 / 14 / 0 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 436 | 128,5 | — | −133 | [−379 ; −21,5] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 182,5 | 282,5 | — | +106 | [+95,5 ; +117,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,84 | 0,87 | — | +0,02 | [+0,002 ; +0,04] | 22 / 8 / 0 sur 30 | **B plus haut (mieux)** |
| Naissances d’entreprises / an | 0,7 | 8,3 | — | +7,8 | [+6,8 ; +8,4] | — / — / 0 | **B plus haut** |
| Naissances / an, en % du parc moyen | 3,3 | 33,3 | — | +29,6 | [+27,1 ; +32,5] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 19,5 | 39,4 | — | +18,5 | [+16,1 ; +21,9] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 20,6 | 25,6 | — | +4,7 | [+4,1 ; +5,2] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 2,8 % | 1,1 % | — | −1,5 pt | [−2,5 pt ; −0,2 pt] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 9,6 % | 7,9 % | — | −0,7 pt | [−4,0 pt ; +0,3 pt] | — / — / 1 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 3 | 5 | — | +2 | [+0,5 ; +3] | — / — / 6 | **B plus haut** |
| Fermetures : faillite (salaires impayables) | 8 | 23,5 | — | +15,5 | [+14,5 ; +17] | — / — / 0 | **B plus haut** |
| Fermetures : demande perdue | 4 | 9,5 | — | +5,5 | [+4 ; +8] | — / — / 2 | **B plus haut** |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | 0 | [0 ; +1] | — / — / 12 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 3,9 | 9,9 | — | +5,6 | [+5,0 ; +6,8] | — / — / 0 | **B plus haut** |
| Entonnoir : projets envisagés | 3324 | 5470,5 | — | +2220,5 | [+1891,5 ; +2374] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 3 | 34 | — | +32 | [+28 ; +34,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 2 | 117,5 | — | +114,5 | [+103 ; +133] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, délai entre deux créations du type | 118,5 | 217,5 | — | +101 | [+35,5 ; +132] | — / — / 1 | **B plus haut** |
| Entonnoir : refus, concurrence | 1476,5 | 1390 | — | −31,5 | [−214 ; +103,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1503 | 1614,5 | — | +26,5 | [−194 ; +199,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 10,5 | 361 | — | +341 | [+236,5 ; +390] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 16 | 1823,5 | — | +1701,5 | [+1501,5 ; +1888] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 0 | 0 | — | 0 | [0 ; +0,5] | — / — / 15 | non concluant |
| Types d’entreprise actifs en fin | 15 | 22 | — | +7 | [+6 ; +9] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Machines en fin | 182,1 | 280,1 | — | +82,9 | [+44,5 ; +127,1] | 24 / 6 / 0 sur 30 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 1 | 3 | — | +2 | [+2 ; +3] | 3 / 24 / 3 sur 30 | **B plus haut (moins bien)** |
| Bonheur moyen | 0,94 | 0,96 | — | +0,01 | [+0,002 ; +0,03] | 21 / 9 / 0 sur 30 | **B plus haut (mieux)** |
| Hôpital public : attente moyenne (j) | 7,3 | 1,9 | — | −4,2 | [−7,8 ; −0,7] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Jours de prestations réduites | 129,5 | 45 | — | −99 | [−137 ; −11] | 21 / 6 / 3 sur 30 | **B plus bas (mieux)** |
| Trésor de l’État le plus bas | 2 463 $ | 3 598 $ | — | +71 $ | [0 $ ; +3 045 $] | 18 / 9 / 3 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 2 935 $ | — | +2 448 $ | [+463 $ ; +5 079 $] | — / — / 3 | **B plus haut** |
| Filet : Anti-famine / 50 j | 3,30 | 0,04 | 19 → 9 | −0,93 | [−8,21 ; 0,00] | 15 / 7 / 8 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 1,52 | 1,11 | 17 → 17 | −0,02 | [−1,14 ; +0,45] | 15 / 15 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 32,82 | 19,73 | 29 → 29 | −4,12 | [−27,30 ; +5,18] | 16 / 14 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 2 | 1 | 28 → 23 | −1 | [−2 ; 0] | 17 / 6 / 7 sur 30 | non concluant |
| … jours-alerte | 166,5 | 47 | — | −79 | [−140 ; −10] | 21 / 7 / 2 sur 30 | **B plus bas (mieux)** |
| Faim répandue | 1 | 0 | 16 → 8 | 0 | [−1 ; 0] | 11 / 3 / 16 sur 30 | non concluant |
| … jours-alerte | 1,5 | 0 | — | 0 | [−20 ; 0] | 11 / 4 / 15 sur 30 | non concluant |
| Sans-abri nombreux | 5 | 5 | 30 → 30 | 0 | [−1 ; +2,5] | 13 / 13 / 4 sur 30 | non concluant |
| … jours-alerte | 120,5 | 54,5 | — | −20 | [−71,5 ; +15,5] | 18 / 12 / 0 sur 30 | non concluant |
| Inflation quotidienne | 15 | 13,5 | 30 → 30 | +1,5 | [−4 ; +2,5] | 13 / 16 / 1 sur 30 | non concluant |
| … jours-alerte | 16 | 15 | — | +1,5 | [−3,5 ; +4] | 13 / 16 / 1 sur 30 | non concluant |
| Inflation sur 100 jours | 1,5 | 0 | 20 → 14 | 0 | [−1 ; 0] | 14 / 3 / 13 sur 30 | non concluant |
| … jours-alerte | 23,5 | 0 | — | 0 | [−23,5 ; 0] | 14 / 4 / 12 sur 30 | non concluant |
| Santé de la population effondrée | 1 | 0 | 17 → 7 | 0 | [−1 ; 0] | 12 / 2 / 16 sur 30 | non concluant |
| … jours-alerte | 16,5 | 0 | — | −2 | [−31,5 ; 0] | 16 / 2 / 12 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Chômage moyen : −4,0 pt [−5,4 pt ; −0,3 pt], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Sans filets — Chômage max : −3,8 pt [−8,1 pt ; −0,2 pt], B mieux (20 graines mieux, 8 moins bien, 2 égales)
- Sans filets — Gini moyen : −0,02 [−0,07 ; −0,002] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Jours-alerte critiques (somme des types) : −53,5 [−304 ; −16,5], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Sans filets — Alertes ouvertes (toutes) : +110 [+91,5 ; +142], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Sans filets — Naissances d’entreprises / an : +8,3 [+6,8 ; +8,8] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Naissances / an, en % du parc moyen : +31,1 [+26,6 ; +34,0] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts / an, en % du parc moyen : +18,8 [+14,7 ; +22,0] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Parc moyen d’entreprises (après la chauffe) : +4,7 [+3,9 ; +5,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : prix aberrant : +2 [+1,5 ; +3,5] (0 graines mieux, 0 moins bien, 1 égales)
- Sans filets — Fermetures : faillite (salaires impayables) : +13,5 [+11,5 ; +16] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : demande perdue : +6,5 [+4,5 ; +8] (0 graines mieux, 0 moins bien, 1 égales)
- Sans filets — Morts d’entreprises / an : +6,2 [+4,7 ; +6,8] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : projets envisagés : +2422 [+2078 ; +2789,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : créations : +34 [+28 ; +36] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, une création déjà ce jour : +129,5 [+117 ; +156] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, délai entre deux créations du type : +127,5 [+50,5 ; +250] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +346 [+277,5 ; +383,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, viabilité : +1742 [+1415,5 ; +1988,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Types d’entreprise actifs en fin : +8 [+8 ; +9], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Sans filets — Machines en fin : +92,9 [+27,7 ; +147,2], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Sans filets — Équipes utilisées à moins de 15 % (fin) : +2 [+1 ; +3], B moins bien (4 graines mieux, 23 moins bien, 3 égales)
- Sans filets — Trésor de l’État le plus bas : +523 $ [+115 $ ; +1 114 $], B mieux (23 graines mieux, 5 moins bien, 2 égales)
- Sans filets — Créances radiées : +4 992 $ [+744 $ ; +7 618 $] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Chômage moyen : −4,4 pt [−6,1 pt ; −2,4 pt], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets — Chômage max : −6,5 pt [−24,8 pt ; −0,4 pt], B mieux (20 graines mieux, 6 moins bien, 4 égales)
- Avec filets — Gini moyen : −0,03 [−0,03 ; −0,005] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Inflation moyenne / j : −0,024 pt [−0,043 pt ; −0,012 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Jours-alerte critiques (somme des types) : −133 [−379 ; −21,5], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets — Alertes ouvertes (toutes) : +106 [+95,5 ; +117,5], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets — Santé moyenne : +0,02 [+0,002 ; +0,04], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets — Naissances d’entreprises / an : +7,8 [+6,8 ; +8,4] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Naissances / an, en % du parc moyen : +29,6 [+27,1 ; +32,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts / an, en % du parc moyen : +18,5 [+16,1 ; +21,9] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Parc moyen d’entreprises (après la chauffe) : +4,7 [+4,1 ; +5,2] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Demande non servie (part des unités demandées) : −1,5 pt [−2,5 pt ; −0,2 pt], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Fermetures : prix aberrant : +2 [+0,5 ; +3] (0 graines mieux, 0 moins bien, 6 égales)
- Avec filets — Fermetures : faillite (salaires impayables) : +15,5 [+14,5 ; +17] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : demande perdue : +5,5 [+4 ; +8] (0 graines mieux, 0 moins bien, 2 égales)
- Avec filets — Morts d’entreprises / an : +5,6 [+5,0 ; +6,8] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : projets envisagés : +2220,5 [+1891,5 ; +2374] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : créations : +32 [+28 ; +34,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, une création déjà ce jour : +114,5 [+103 ; +133] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, délai entre deux créations du type : +101 [+35,5 ; +132] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +341 [+236,5 ; +390] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : +1701,5 [+1501,5 ; +1888] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Types d’entreprise actifs en fin : +7 [+6 ; +9], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Machines en fin : +82,9 [+44,5 ; +127,1], B mieux (24 graines mieux, 6 moins bien, 0 égales)
- Avec filets — Équipes utilisées à moins de 15 % (fin) : +2 [+2 ; +3], B moins bien (3 graines mieux, 24 moins bien, 3 égales)
- Avec filets — Bonheur moyen : +0,01 [+0,002 ; +0,03], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Hôpital public : attente moyenne (j) : −4,2 [−7,8 ; −0,7], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets — Jours de prestations réduites : −99 [−137 ; −11], B mieux (21 graines mieux, 6 moins bien, 3 égales)
- Avec filets — Créances radiées : +2 448 $ [+463 $ ; +5 079 $] (0 graines mieux, 0 moins bien, 3 égales)
- Avec filets — Chômage très élevé : jours-alerte : −79 [−140 ; −10], B mieux (21 graines mieux, 7 moins bien, 2 égales)

