# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 18:46
- A : `g30-ferme-ref.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B : `g30-ferme-revival.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : revival = 1
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,6 % | 9,0 % | 11 → 11 | −0,4 pt | [−1,5 pt ; +1,6 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Chômage max | 24,6 % | 26,7 % | — | −1,7 pt | [−4,6 pt ; +3,8 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,2 % | 0 → 3 | 0,0 pt | [−0,001 pt ; +0,1 pt] | 10 / 13 / 7 sur 30 | non concluant |
| Faim max | 33,1 % | 46,3 % | — | 0,0 pt | [0,0 pt ; +21,7 pt] | 8 / 14 / 8 sur 30 | non concluant |
| Sans-abri moyen | 0,4 % | 0,4 % | 3 → 4 | −0,03 pt | [−0,2 pt ; +0,3 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Sans-abri max | 31,7 % | 33,5 % | — | 0,0 pt | [−5,4 pt ; +5,8 pt] | 13 / 13 / 4 sur 30 | non concluant |
| Gini moyen | 0,28 | 0,29 | 0 → 0 | +0,003 | [−0,004 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,29 | 0,32 | — | +0,03 | [+0,001 ; +0,05] | — / — / 0 | **B plus haut** |
| Inflation moyenne / j | -0,052 % | -0,053 % | 0 → 0 | +0,001 pt | [−0,010 pt ; +0,011 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 34,4 % | 29,2 % | — | 0,0 pt | [−5,6 pt ; +5,7 pt] | 12 / 13 / 5 sur 30 | non concluant |
| |Inflation sur 100 j| max | 108,7 % | 106,4 % | — | 0,0 pt | [−0,8 pt ; +0,1 pt] | 12 / 10 / 8 sur 30 | non concluant |
| Alertes critiques ouvertes | 16,5 | 15 | 30 → 30 | −2 | [−4 ; +0,5] | 19 / 10 / 1 sur 30 | non concluant |
| … dont après la chauffe | 14 | 13 | — | −2 | [−3 ; +0,5] | 19 / 10 / 1 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 71 | 64,5 | — | +1,5 | [−12,5 ; +30] | 14 / 16 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 381,5 | 413 | — | +44,5 | [−12,5 ; +74] | 11 / 19 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,0002 | [+0,0001 ; +0,0003] | 23 / 7 / 0 sur 30 | **B plus haut (mieux)** |
| Naissances d’entreprises / an | 10,0 | 13,1 | — | +4,6 | [+2,1 ; +5,8] | — / — / 0 | **B plus haut** |
| Naissances / an, en % du parc moyen | 32,7 | 38,6 | — | +13,8 | [+4,6 ; +16,0] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 30,9 | 36,7 | — | +10,6 | [+5,7 ; +14,2] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 31,8 | 32,9 | — | +1,2 | [+0,1 ; +1,6] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 1,6 % | 1,4 % | — | −0,2 pt | [−0,4 pt ; +0,3 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 15,1 % | 19,4 % | — | +2,3 pt | [+0,2 pt ; +7,2 pt] | — / — / 0 | **B plus haut** |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 21 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 21 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | 0 | [−0,5 ; 0] | — / — / 14 | non concluant |
| Fermetures : faillite (salaires impayables) | 33,5 | 44 | — | +15 | [+9,5 ; +20,5] | — / — / 1 | **B plus haut** |
| Fermetures : demande perdue | 2 | 3 | — | +2 | [+1 ; +3] | — / — / 3 | **B plus haut** |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 2 | — | 0 | [−1 ; +1,5] | — / — / 5 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 10,2 | 12,8 | — | +4,1 | [+2,1 ; +5,6] | — / — / 1 | **B plus haut** |
| Entonnoir : projets envisagés | 9238,5 | 9093 | — | −33,5 | [−784,5 ; +350] | — / — / 0 | non concluant |
| Entonnoir : créations | 41 | 54 | — | +19 | [+8,5 ; +24] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 249,5 | 249 | — | +26,5 | [−11 ; +74] | — / — / 0 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 1547,5 | 1427 | — | −241,5 | [−508,1 ; +282,2] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 2440,5 | 2371 | — | −94 | [−211 ; −18] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, demande insuffisante | 3464 | 3486,5 | — | +37,5 | [−292,5 ; +289] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 168,5 | 158,5 | — | −4,5 | [−91 ; +63,5] | — / — / 0 | non concluant |
| Entonnoir : refus, viabilité | 775 | 1122 | — | +311 | [+172 ; +502] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 422,5 | 131,5 | — | −189,5 | [−263,5 ; −89,5] | — / — / 1 | **B plus bas** |
| Types d’entreprise actifs en fin | 28 | 29,5 | — | +1,5 | [0 ; +2] | 19 / 7 / 4 sur 30 | non concluant |
| Machines en fin | 366,3 | 380,2 | — | −8,5 | [−54,9 ; +81,7] | 13 / 17 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 2,5 | 3 | — | 0 | [−2 ; +1] | 14 / 14 / 2 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | −0,0002 | [−0,005 ; +0,002] | 14 / 16 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | −0,04 | [−0,1 ; −0,01] | 20 / 10 / 0 sur 30 | **B plus bas (mieux)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| Trésor de l’État le plus bas | 79 907 $ | 83 769 $ | — | +5 085 $ | [−5 680 $ ; +20 752 $] | 19 / 11 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 7 / 3 / 20 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 17 | non concluant |
| Créances radiées | 16 402 $ | 15 919 $ | — | −292 $ | [−5 536 $ ; +5 323 $] | — / — / 0 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 6 → 4 | 0 | [0 ; 0] | 6 / 3 / 21 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 6 / 3 / 21 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 18 → 19 | 0 | [0 ; 0] | 7 / 8 / 15 sur 30 | non concluant |
| … jours-alerte | 2 | 4,5 | — | 0 | [0 ; +2] | 8 / 12 / 10 sur 30 | non concluant |
| Sans-abri nombreux | 3 | 4 | 28 → 28 | 0 | [−1 ; +1] | 11 / 14 / 5 sur 30 | non concluant |
| … jours-alerte | 36 | 28 | — | −2 | [−16 ; +10] | 16 / 13 / 1 sur 30 | non concluant |
| Inflation quotidienne | 11 | 9 | 29 → 30 | −2 | [−3 ; 0] | 19 / 7 / 4 sur 30 | non concluant |
| … jours-alerte | 11 | 9 | — | −2 | [−3,5 ; 0] | 19 / 7 / 4 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 1 | 28 → 28 | 0 | [−0,5 ; 0] | 10 / 5 / 15 sur 30 | non concluant |
| … jours-alerte | 10 | 7,5 | — | 0 | [−2 ; 0] | 14 / 8 / 8 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 1 → 0 | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,4 % | 8,1 % | 9 → 11 | −0,5 pt | [−1,5 pt ; +1,9 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Chômage max | 24,8 % | 21,7 % | — | −2,9 pt | [−6,3 pt ; +1,3 pt] | 16 / 12 / 2 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 8 / 6 / 16 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 8 / 6 / 16 sur 30 | non concluant |
| Sans-abri moyen | 0,4 % | 0,1 % | 2 → 3 | −0,1 pt | [−0,3 pt ; +0,1 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Sans-abri max | 30,4 % | 21,0 % | — | −4,2 pt | [−8,7 pt ; 0,0 pt] | 17 / 4 / 9 sur 30 | non concluant |
| Gini moyen | 0,25 | 0,25 | 1 → 0 | +0,01 | [−0,01 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,28 | 0,27 | — | +0,00003 | [−0,03 ; +0,03] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,043 % | -0,061 % | 0 → 0 | −0,014 pt | [−0,022 pt ; +0,002 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 34,6 % | 30,2 % | — | +0,1 pt | [−1,3 pt ; +2,6 pt] | 12 / 15 / 3 sur 30 | non concluant |
| |Inflation sur 100 j| max | 106,0 % | 106,7 % | — | 0,0 pt | [−0,6 pt ; 0,0 pt] | 10 / 9 / 11 sur 30 | non concluant |
| Alertes critiques ouvertes | 15,5 | 13,5 | 30 → 30 | −1,5 | [−3,5 ; +1] | 18 / 11 / 1 sur 30 | non concluant |
| … dont après la chauffe | 14 | 12 | — | −1,5 | [−3,5 ; +1] | 18 / 11 / 1 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 56 | 39,5 | — | −9,5 | [−56 ; +0,5] | 19 / 10 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 303 | 309 | — | −13,5 | [−26 ; +57] | 17 / 13 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,0003 | [+0,0001 ; +0,001] | 23 / 7 / 0 sur 30 | **B plus haut (mieux)** |
| Naissances d’entreprises / an | 5,6 | 7,1 | — | +1,9 | [+1,2 ; +3,6] | — / — / 2 | **B plus haut** |
| Naissances / an, en % du parc moyen | 17,6 | 22,1 | — | +5,5 | [+3,2 ; +10,3] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 16,5 | 22,2 | — | +5,3 | [+2,6 ; +7,9] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 31,3 | 32,3 | — | +1,0 | [+0,5 ; +2,2] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 1,1 % | 0,9 % | — | −0,3 pt | [−0,5 pt ; −0,2 pt] | 25 / 5 / 0 sur 30 | **B plus bas (mieux)** |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 22,0 % | 21,4 % | — | +0,7 pt | [−1,4 pt ; +2,8 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 27 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 27 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | −0,5 | [−1 ; 0] | — / — / 9 | non concluant |
| Fermetures : faillite (salaires impayables) | 17 | 23 | — | +4,5 | [+4 ; +11] | — / — / 1 | **B plus haut** |
| Fermetures : demande perdue | 1 | 2 | — | +1 | [0 ; +2] | — / — / 6 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | 0 | [−0,5 ; +1] | — / — / 9 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 5,1 | 7,1 | — | +1,9 | [+1,1 ; +2,8] | — / — / 2 | **B plus haut** |
| Entonnoir : projets envisagés | 8279 | 8271 | — | +24 | [−681,5 ; +641] | — / — / 0 | non concluant |
| Entonnoir : créations | 23 | 29 | — | +8 | [+5 ; +15] | — / — / 2 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 131,5 | 155 | — | +0,5 | [−20,5 ; +33,5] | — / — / 0 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 808,5 | 534 | — | −136 | [−357 ; −52] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, concurrence | 2620 | 2272,5 | — | −332 | [−459 ; −121] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, demande insuffisante | 3571 | 3599,5 | — | −47 | [−424,5 ; +313] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 81,5 | 50,5 | — | −16 | [−31 ; +18,5] | — / — / 0 | non concluant |
| Entonnoir : refus, viabilité | 607,5 | 1364 | — | +607 | [+411,5 ; +869,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 254 | 14 | — | −207,5 | [−447,5 ; −56,5] | — / — / 0 | **B plus bas** |
| Types d’entreprise actifs en fin | 29 | 30 | — | +1 | [0 ; +2] | 19 / 6 / 5 sur 30 | non concluant |
| Machines en fin | 341,5 | 368,4 | — | +0,7 | [−46,8 ; +43,8] | 15 / 15 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 3 | — | 0 | [−0,5 ; +1,5] | 10 / 13 / 7 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | +0,001 | [−0,001 ; +0,002] | 18 / 12 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | −0,1 | [−0,2 ; −0,01] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 5 / 1 / 24 sur 30 | non concluant |
| Trésor de l’État le plus bas | 63 159 $ | 83 393 $ | — | +8 072 $ | [+1 467 $ ; +23 710 $] | 21 / 9 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 28 | non concluant |
| Créances radiées | 5 123 $ | 1 272 $ | — | −3 651 $ | [−4 802 $ ; −1 322 $] | — / — / 0 | **B plus bas** |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 5 → 3 | 0,00 | [0,00 ; 0,00] | 7 / 5 / 18 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 5,16 | 4,80 | 30 → 30 | −0,16 | [−0,57 ; +0,95] | 15 / 15 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 3,80 | 1,34 | 21 → 18 | −0,43 | [−4,41 ; +1,16] | 16 / 13 / 1 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 2 / 28 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 9 → 7 | 0 | [0 ; 0] | 9 / 4 / 17 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 8 / 5 / 17 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 8 → 5 | 0 | [0 ; 0] | 7 / 5 / 18 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 5 / 18 sur 30 | non concluant |
| Sans-abri nombreux | 2 | 2 | 29 → 21 | −1 | [−1 ; 0] | 16 / 9 / 5 sur 30 | non concluant |
| … jours-alerte | 26,5 | 20 | — | −4,5 | [−15,5 ; −0,5] | 20 / 9 / 1 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 11 | 10 | 30 → 30 | −1 | [−3 ; 0] | 19 / 8 / 3 sur 30 | non concluant |
| … jours-alerte | 11 | 10 | — | −1 | [−3 ; 0] | 19 / 8 / 3 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 2 | 24 → 27 | 0 | [0 ; 0] | 7 / 8 / 15 sur 30 | non concluant |
| … jours-alerte | 9 | 9 | — | 0 | [0 ; +1] | 8 / 11 / 11 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 5 → 0 | 0 | [0 ; 0] | 5 / 0 / 25 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 5 / 0 / 25 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Gini en fin de partie : +0,03 [+0,001 ; +0,05] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Santé moyenne : +0,0002 [+0,0001 ; +0,0003], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Sans filets — Naissances d’entreprises / an : +4,6 [+2,1 ; +5,8] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Naissances / an, en % du parc moyen : +13,8 [+4,6 ; +16,0] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts / an, en % du parc moyen : +10,6 [+5,7 ; +14,2] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Parc moyen d’entreprises (après la chauffe) : +1,2 [+0,1 ; +1,6] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) : +2,3 pt [+0,2 pt ; +7,2 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : faillite (salaires impayables) : +15 [+9,5 ; +20,5] (0 graines mieux, 0 moins bien, 1 égales)
- Sans filets — Fermetures : demande perdue : +2 [+1 ; +3] (0 graines mieux, 0 moins bien, 3 égales)
- Sans filets — Morts d’entreprises / an : +4,1 [+2,1 ; +5,6] (0 graines mieux, 0 moins bien, 1 égales)
- Sans filets — Entonnoir : créations : +19 [+8,5 ; +24] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, concurrence : −94 [−211 ; −18] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, viabilité : +311 [+172 ; +502] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, aucun fondateur assez riche : −189,5 [−263,5 ; −89,5] (0 graines mieux, 0 moins bien, 1 égales)
- Sans filets — Hôpital public : attente moyenne (j) : −0,04 [−0,1 ; −0,01], B mieux (20 graines mieux, 10 moins bien, 0 égales)
- Avec filets — Santé moyenne : +0,0003 [+0,0001 ; +0,001], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets — Naissances d’entreprises / an : +1,9 [+1,2 ; +3,6] (0 graines mieux, 0 moins bien, 2 égales)
- Avec filets — Naissances / an, en % du parc moyen : +5,5 [+3,2 ; +10,3] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts / an, en % du parc moyen : +5,3 [+2,6 ; +7,9] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Parc moyen d’entreprises (après la chauffe) : +1,0 [+0,5 ; +2,2] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Demande non servie (part des unités demandées) : −0,3 pt [−0,5 pt ; −0,2 pt], B mieux (25 graines mieux, 5 moins bien, 0 égales)
- Avec filets — Fermetures : faillite (salaires impayables) : +4,5 [+4 ; +11] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Morts d’entreprises / an : +1,9 [+1,1 ; +2,8] (0 graines mieux, 0 moins bien, 2 égales)
- Avec filets — Entonnoir : créations : +8 [+5 ; +15] (0 graines mieux, 0 moins bien, 2 égales)
- Avec filets — Entonnoir : refus, délai entre deux créations du type : −136 [−357 ; −52] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, concurrence : −332 [−459 ; −121] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : +607 [+411,5 ; +869,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, aucun fondateur assez riche : −207,5 [−447,5 ; −56,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Hôpital public : attente moyenne (j) : −0,1 [−0,2 ; −0,01], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets — Trésor de l’État le plus bas : +8 072 $ [+1 467 $ ; +23 710 $], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Créances radiées : −3 651 $ [−4 802 $ ; −1 322 $] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Sans-abri nombreux : jours-alerte : −4,5 [−15,5 ; −0,5], B mieux (20 graines mieux, 9 moins bien, 1 égales)

