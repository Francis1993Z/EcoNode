# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 19:17
- A : `g30-ferme-sans.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : revival = 0
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
| Chômage moyen | 8,6 % | 9,6 % | 11 → 13 | +0,1 pt | [−0,4 pt ; +2,4 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Chômage max | 24,6 % | 26,9 % | — | +1,3 pt | [0,0 pt ; +5,4 pt] | 9 / 19 / 2 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,2 % | 0 → 2 | +0,001 pt | [0,0 pt ; +0,1 pt] | 7 / 16 / 7 sur 30 | non concluant |
| Faim max | 33,1 % | 47,7 % | — | +4,2 pt | [0,0 pt ; +13,5 pt] | 5 / 17 / 8 sur 30 | non concluant |
| Sans-abri moyen | 0,4 % | 0,6 % | 3 → 2 | +0,1 pt | [−0,02 pt ; +0,3 pt] | 10 / 20 / 0 sur 30 | non concluant |
| Sans-abri max | 31,7 % | 42,9 % | — | +1,0 pt | [−0,4 pt ; +17,1 pt] | 10 / 15 / 5 sur 30 | non concluant |
| Gini moyen | 0,28 | 0,28 | 0 → 0 | +0,0002 | [−0,01 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,29 | 0,29 | — | +0,01 | [−0,02 ; +0,03] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,052 % | -0,051 % | 0 → 0 | +0,003 pt | [−0,011 pt ; +0,010 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 34,4 % | 37,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 3 / 9 / 18 sur 30 | non concluant |
| |Inflation sur 100 j| max | 108,7 % | 108,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 3 / 4 / 23 sur 30 | non concluant |
| Alertes critiques ouvertes | 16,5 | 18 | 30 → 30 | +0,5 | [−2,5 ; +4,5] | 14 / 15 / 1 sur 30 | non concluant |
| … dont après la chauffe | 14 | 16 | — | 0 | [−2,5 ; +4,5] | 14 / 14 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 71 | 79 | — | +8,5 | [−6,5 ; +41,5] | 12 / 17 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 381,5 | 411 | — | +47,5 | [−8,5 ; +69,5] | 10 / 20 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | −0,00003 | [−0,0002 ; +0,0001] | 12 / 18 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 10,0 | 10,5 | — | +1,7 | [+0,5 ; +2,9] | — / — / 0 | **B plus haut** |
| Naissances / an, en % du parc moyen | 32,7 | 33,3 | — | +4,3 | [+1,9 ; +8,0] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 30,9 | 32,6 | — | +2,6 | [+0,9 ; +6,5] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 31,8 | 32,5 | — | +0,5 | [−0,3 ; +0,8] | — / — / 0 | non concluant |
| Demande non servie (part des unités demandées) | 1,6 % | 1,6 % | — | +0,1 pt | [−0,1 pt ; +0,2 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 15,1 % | 16,8 % | — | +0,6 pt | [−0,3 pt ; +2,8 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 23 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 23 | non concluant |
| Fermetures : prix aberrant | 1 | 1,5 | — | +0,5 | [0 ; +1] | — / — / 7 | non concluant |
| Fermetures : faillite (salaires impayables) | 33,5 | 34,5 | — | +3 | [+1 ; +6,5] | — / — / 0 | **B plus haut** |
| Fermetures : demande perdue | 2 | 2 | — | 0 | [−1 ; +1] | — / — / 8 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 3 | — | +1 | [−0,5 ; +2] | — / — / 4 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 10,2 | 10,2 | — | +1,3 | [+0,4 ; +2,1] | — / — / 0 | **B plus haut** |
| Entonnoir : projets envisagés | 9238,5 | 10383,5 | — | +1106 | [+853 ; +1715] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 41 | 43 | — | +7 | [+2 ; +12] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 249,5 | 260 | — | +39,5 | [−19,5 ; +97] | — / — / 0 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 1547,5 | 1463 | — | +132 | [−84 ; +243,4] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 2440,5 | 2378 | — | −58 | [−136,5 ; +69,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 3464 | 3605 | — | +57 | [−135 ; +136] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 168,5 | 189 | — | +19,5 | [−51 ; +92] | — / — / 0 | non concluant |
| Entonnoir : refus, viabilité | 775 | 1939 | — | +1040 | [+903,5 ; +1208] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 422,5 | 535 | — | +3,5 | [−64 ; +125,5] | — / — / 2 | non concluant |
| Types d’entreprise actifs en fin | 28 | 29 | — | +1 | [0 ; +1] | 17 / 8 / 5 sur 30 | non concluant |
| Machines en fin | 366,3 | 373,2 | — | +1,6 | [−47,8 ; +47,6] | 15 / 15 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 2,5 | 2 | — | 0 | [−1 ; +1] | 13 / 11 / 6 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | −0,001 | [−0,01 ; +0,001] | 12 / 18 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | +0,02 | [−0,01 ; +0,05] | 13 / 17 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 3 / 25 sur 30 | non concluant |
| Trésor de l’État le plus bas | 79 907 $ | 61 584 $ | — | −2 899 $ | [−21 825 $ ; +1 354 $] | 11 / 19 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 4 / 8 / 18 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 17 | non concluant |
| Créances radiées | 16 402 $ | 19 672 $ | — | +941 $ | [−2 094 $ ; +6 208 $] | — / — / 1 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 6 → 9 | 0 | [0 ; 0] | 6 / 8 / 16 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 6 / 8 / 16 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 18 → 18 | 0 | [0 ; 0] | 8 / 9 / 13 sur 30 | non concluant |
| … jours-alerte | 2 | 6 | — | 0 | [0 ; +3,5] | 7 / 13 / 10 sur 30 | non concluant |
| Sans-abri nombreux | 3 | 3 | 28 → 29 | +1 | [−0,5 ; +2,5] | 10 / 18 / 2 sur 30 | non concluant |
| … jours-alerte | 36 | 39,5 | — | +1,5 | [−10 ; +14,5] | 13 / 16 / 1 sur 30 | non concluant |
| Inflation quotidienne | 11 | 10 | 29 → 30 | 0 | [−2 ; +1] | 14 / 13 / 3 sur 30 | non concluant |
| … jours-alerte | 11 | 10 | — | 0 | [−2 ; +1] | 14 / 14 / 2 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 28 → 27 | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| … jours-alerte | 10 | 10 | — | 0 | [0 ; 0] | 3 / 2 / 25 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 1 → 0 | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,4 % | 8,0 % | 9 → 7 | +0,04 pt | [−1,3 pt ; +0,8 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Chômage max | 24,8 % | 22,3 % | — | −1,7 pt | [−3,3 pt ; 0,0 pt] | 20 / 9 / 1 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 1 | 0,0 pt | [0,0 pt ; 0,0 pt] | 5 / 8 / 17 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 6 / 7 / 17 sur 30 | non concluant |
| Sans-abri moyen | 0,4 % | 0,2 % | 2 → 2 | −0,02 pt | [−0,2 pt ; +0,1 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Sans-abri max | 30,4 % | 26,9 % | — | 0,0 pt | [−4,4 pt ; +3,3 pt] | 10 / 11 / 9 sur 30 | non concluant |
| Gini moyen | 0,25 | 0,24 | 1 → 0 | −0,01 | [−0,02 ; +0,004] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,28 | 0,26 | — | −0,02 | [−0,05 ; +0,02] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,043 % | -0,044 % | 0 → 0 | +0,005 pt | [−0,010 pt ; +0,016 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 34,6 % | 33,4 % | — | 0,0 pt | [−0,8 pt ; 0,0 pt] | 10 / 9 / 11 sur 30 | non concluant |
| |Inflation sur 100 j| max | 106,0 % | 107,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 7 / 21 sur 30 | non concluant |
| Alertes critiques ouvertes | 15,5 | 14 | 30 → 30 | −1 | [−3 ; +1] | 16 / 12 / 2 sur 30 | non concluant |
| … dont après la chauffe | 14 | 13 | — | −1 | [−3 ; +2] | 16 / 11 / 3 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 56 | 43,5 | — | −14 | [−21 ; −4,5] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 303 | 292,5 | — | −3 | [−28 ; +29] | 15 / 15 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,0001 | [+0,00004 ; +0,001] | 21 / 9 / 0 sur 30 | **B plus haut (mieux)** |
| Naissances d’entreprises / an | 5,6 | 5,8 | — | +1,2 | [+0,2 ; +1,5] | — / — / 1 | **B plus haut** |
| Naissances / an, en % du parc moyen | 17,6 | 19,6 | — | +3,7 | [−0,2 ; +5,1] | — / — / 0 | non concluant |
| Morts / an, en % du parc moyen | 16,5 | 18,4 | — | +2,6 | [+0,6 ; +4,3] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 31,3 | 31,5 | — | +0,3 | [−0,3 ; +0,8] | — / — / 0 | non concluant |
| Demande non servie (part des unités demandées) | 1,1 % | 1,0 % | — | −0,1 pt | [−0,5 pt ; +0,04 pt] | 19 / 11 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 22,0 % | 20,2 % | — | +0,6 pt | [−4,1 pt ; +2,2 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | 0 | [−1 ; 0] | — / — / 15 | non concluant |
| Fermetures : faillite (salaires impayables) | 17 | 19,5 | — | +2,5 | [−0,5 ; +5] | — / — / 2 | non concluant |
| Fermetures : demande perdue | 1 | 2 | — | +1 | [0 ; +2] | — / — / 5 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | 0 | [0 ; +0,5] | — / — / 13 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 5,1 | 5,7 | — | +0,7 | [+0,4 ; +1,7] | — / — / 0 | **B plus haut** |
| Entonnoir : projets envisagés | 8279 | 9520,5 | — | +1271 | [+441,5 ; +1885,5] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 23 | 24 | — | +5 | [+1 ; +6] | — / — / 1 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 131,5 | 136,5 | — | +13 | [−7 ; +49,5] | — / — / 0 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 808,5 | 730,5 | — | −74,5 | [−152 ; +97,5] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 2620 | 2523 | — | −3,5 | [−143,5 ; +137] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 3571 | 3575,5 | — | +155 | [−261,5 ; +390,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 81,5 | 159,5 | — | +59,5 | [+32 ; +126,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 607,5 | 1979 | — | +1383 | [+1007,5 ; +1583,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 254 | 155 | — | −103,5 | [−211,5 ; +42,5] | — / — / 0 | non concluant |
| Types d’entreprise actifs en fin | 29 | 29 | — | +1 | [0 ; +2] | 16 / 9 / 5 sur 30 | non concluant |
| Machines en fin | 341,5 | 370,2 | — | +42,9 | [−26,9 ; +115,2] | 17 / 13 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 2,5 | — | 0 | [−1,5 ; +1] | 14 / 12 / 4 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | +0,001 | [−0,0002 ; +0,003] | 19 / 11 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | −0,02 | [−0,1 ; +0,0003] | 20 / 10 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 4 / 1 / 25 sur 30 | non concluant |
| Trésor de l’État le plus bas | 63 159 $ | 74 039 $ | — | +3 844 $ | [−10 092 $ ; +18 539 $] | 16 / 13 / 1 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 5 123 $ | 2 907 $ | — | −1 947 $ | [−3 559 $ ; −82 $] | — / — / 0 | **B plus bas** |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 5 → 5 | 0,00 | [0,00 ; 0,00] | 4 / 6 / 20 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 5,16 | 4,63 | 30 → 30 | −0,43 | [−1,14 ; +0,18] | 18 / 11 / 1 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 3,80 | 0,55 | 21 → 14 | −0,27 | [−3,43 ; +0,38] | 16 / 13 / 1 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 1 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 9 → 3 | 0 | [0 ; 0] | 8 / 3 / 19 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 9 / 2 / 19 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 8 → 9 | 0 | [0 ; 0] | 3 / 5 / 22 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 4 / 7 / 19 sur 30 | non concluant |
| Sans-abri nombreux | 2 | 2 | 29 → 27 | −0,5 | [−1 ; 0] | 15 / 8 / 7 sur 30 | non concluant |
| … jours-alerte | 26,5 | 21,5 | — | −3 | [−12,5 ; +5] | 16 / 13 / 1 sur 30 | non concluant |
| Inflation quotidienne | 11 | 10 | 30 → 30 | 0 | [−2,5 ; +1,5] | 14 / 14 / 2 sur 30 | non concluant |
| … jours-alerte | 11 | 10 | — | 0 | [−2,5 ; +1,5] | 14 / 14 / 2 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 1 | 24 → 24 | 0 | [0 ; 0] | 4 / 1 / 25 sur 30 | non concluant |
| … jours-alerte | 9 | 9 | — | 0 | [0 ; 0] | 4 / 2 / 24 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 5 → 0 | 0 | [0 ; 0] | 5 / 0 / 25 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 5 / 0 / 25 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Naissances d’entreprises / an : +1,7 [+0,5 ; +2,9] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Naissances / an, en % du parc moyen : +4,3 [+1,9 ; +8,0] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts / an, en % du parc moyen : +2,6 [+0,9 ; +6,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : faillite (salaires impayables) : +3 [+1 ; +6,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts d’entreprises / an : +1,3 [+0,4 ; +2,1] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : projets envisagés : +1106 [+853 ; +1715] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : créations : +7 [+2 ; +12] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, viabilité : +1040 [+903,5 ; +1208] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Jours-alerte critiques (somme des types) : −14 [−21 ; −4,5], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Santé moyenne : +0,0001 [+0,00004 ; +0,001], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Naissances d’entreprises / an : +1,2 [+0,2 ; +1,5] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Morts / an, en % du parc moyen : +2,6 [+0,6 ; +4,3] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts d’entreprises / an : +0,7 [+0,4 ; +1,7] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : projets envisagés : +1271 [+441,5 ; +1885,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : créations : +5 [+1 ; +6] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +59,5 [+32 ; +126,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : +1383 [+1007,5 ; +1583,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Créances radiées : −1 947 $ [−3 559 $ ; −82 $] (0 graines mieux, 0 moins bien, 0 égales)

