# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 18:46
- A : `g30-ferme-ref.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B : `g30-ferme-signal.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : revival = 1, revivalHours = 0
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,6 % | 9,1 % | 11 → 11 | −0,6 pt | [−1,7 pt ; +1,0 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Chômage max | 24,6 % | 24,6 % | — | −1,9 pt | [−4,8 pt ; +0,2 pt] | 17 / 10 / 3 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 1 | 0,0 pt | [−0,001 pt ; +0,0003 pt] | 10 / 10 / 10 sur 30 | non concluant |
| Faim max | 33,1 % | 36,3 % | — | 0,0 pt | [0,0 pt ; +2,7 pt] | 8 / 12 / 10 sur 30 | non concluant |
| Sans-abri moyen | 0,4 % | 0,5 % | 3 → 1 | −0,02 pt | [−0,3 pt ; +0,4 pt] | 15 / 15 / 0 sur 30 | non concluant |
| Sans-abri max | 31,7 % | 30,0 % | — | 0,0 pt | [−1,5 pt ; +5,6 pt] | 10 / 12 / 8 sur 30 | non concluant |
| Gini moyen | 0,28 | 0,29 | 0 → 0 | +0,002 | [−0,01 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,29 | 0,29 | — | +0,02 | [−0,01 ; +0,03] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,052 % | -0,050 % | 0 → 0 | +0,006 pt | [−0,006 pt ; +0,013 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 34,4 % | 37,2 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 3 / 7 / 20 sur 30 | non concluant |
| |Inflation sur 100 j| max | 108,7 % | 108,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 3 / 4 / 23 sur 30 | non concluant |
| Alertes critiques ouvertes | 16,5 | 16 | 30 → 30 | −1 | [−2,5 ; +1,5] | 17 / 13 / 0 sur 30 | non concluant |
| … dont après la chauffe | 14 | 14 | — | −1 | [−2,5 ; +1,5] | 17 / 13 / 0 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 71 | 67 | — | +4 | [−16 ; +32] | 14 / 16 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 381,5 | 353,5 | — | −2 | [−60,5 ; +40,5] | 15 / 15 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,00005 | [−0,0001 ; +0,0002] | 17 / 13 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 10,0 | 10,2 | — | +0,6 | [−1,7 ; +2,6] | — / — / 0 | non concluant |
| Naissances / an, en % du parc moyen | 32,7 | 32,1 | — | +0,9 | [−4,5 ; +6,7] | — / — / 0 | non concluant |
| Morts / an, en % du parc moyen | 30,9 | 30,7 | — | +0,4 | [−2,0 ; +5,3] | — / — / 0 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 31,8 | 31,9 | — | −0,01 | [−0,7 ; +0,6] | — / — / 0 | non concluant |
| Demande non servie (part des unités demandées) | 1,6 % | 1,6 % | — | +0,1 pt | [−0,3 pt ; +0,2 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 15,1 % | 18,5 % | — | +3,2 pt | [−0,003 pt ; +6,3 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 26 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 26 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | 0 | [0 ; 0] | — / — / 14 | non concluant |
| Fermetures : faillite (salaires impayables) | 33,5 | 33,5 | — | +0,5 | [−3 ; +6,5] | — / — / 1 | non concluant |
| Fermetures : demande perdue | 2 | 2 | — | +0,5 | [0 ; +1,5] | — / — / 6 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 2 | — | 0 | [−1,5 ; +1] | — / — / 5 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 10,2 | 9,9 | — | −0,1 | [−0,9 ; +1,8] | — / — / 1 | non concluant |
| Entonnoir : projets envisagés | 9238,5 | 10167,5 | — | +946 | [+738,5 ; +1164] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 41 | 42 | — | +2,5 | [−7 ; +10,5] | — / — / 0 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 249,5 | 230 | — | +15 | [−64,5 ; +49] | — / — / 0 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 1547,5 | 1365,5 | — | −112 | [−450,5 ; +184] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 2440,5 | 2392,5 | — | −54,5 | [−162 ; +33] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 3464 | 3620,5 | — | +99 | [−73,5 ; +286,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 168,5 | 225,5 | — | +39,5 | [+9 ; +72] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 775 | 1799 | — | +977,5 | [+828 ; +1122] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 422,5 | 562,5 | — | −7 | [−69 ; +119] | — / — / 1 | non concluant |
| Types d’entreprise actifs en fin | 28 | 28 | — | 0 | [−1,5 ; +1] | 12 / 11 / 7 sur 30 | non concluant |
| Machines en fin | 366,3 | 393,3 | — | +12,3 | [−36,5 ; +72,8] | 17 / 13 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 2,5 | 2,5 | — | −0,5 | [−2 ; 0] | 15 / 9 / 6 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | −0,0002 | [−0,003 ; +0,002] | 14 / 16 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | −0,01 | [−0,04 ; +0,03] | 18 / 12 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 3 / 25 sur 30 | non concluant |
| Trésor de l’État le plus bas | 79 907 $ | 69 662 $ | — | +5 594 $ | [−16 423 $ ; +18 774 $] | 18 / 11 / 1 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 6 / 2 / 22 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 20 | non concluant |
| Créances radiées | 16 402 $ | 20 191 $ | — | −73 $ | [−1 997 $ ; +4 604 $] | — / — / 1 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 6 → 7 | 0 | [0 ; 0] | 5 / 6 / 19 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 5 / 6 / 19 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 18 → 17 | 0 | [0 ; 0] | 6 / 4 / 20 sur 30 | non concluant |
| … jours-alerte | 2 | 3 | — | 0 | [0 ; 0] | 8 / 7 / 15 sur 30 | non concluant |
| Sans-abri nombreux | 3 | 3 | 28 → 29 | 0 | [−1,5 ; +1] | 12 / 12 / 6 sur 30 | non concluant |
| … jours-alerte | 36 | 32 | — | −4 | [−27,5 ; +13] | 16 / 14 / 0 sur 30 | non concluant |
| Inflation quotidienne | 11 | 10 | 29 → 30 | 0 | [−1 ; +0,5] | 14 / 10 / 6 sur 30 | non concluant |
| … jours-alerte | 11 | 10 | — | −0,5 | [−1,5 ; +0,5] | 15 / 10 / 5 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 28 → 27 | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| … jours-alerte | 10 | 10 | — | 0 | [0 ; 0] | 3 / 2 / 25 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 1 → 0 | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,4 % | 7,9 % | 9 → 8 | −1,3 pt | [−2,5 pt ; +0,8 pt] | 19 / 11 / 0 sur 30 | non concluant |
| Chômage max | 24,8 % | 22,1 % | — | −2,5 pt | [−6,0 pt ; +0,4 pt] | 19 / 10 / 1 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 7 / 7 / 16 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 7 / 6 / 17 sur 30 | non concluant |
| Sans-abri moyen | 0,4 % | 0,1 % | 2 → 2 | −0,2 pt | [−0,4 pt ; −0,03 pt] | 21 / 8 / 1 sur 30 | **B plus bas (mieux)** |
| Sans-abri max | 30,4 % | 35,6 % | — | 0,0 pt | [−5,2 pt ; +3,7 pt] | 12 / 11 / 7 sur 30 | non concluant |
| Gini moyen | 0,25 | 0,25 | 1 → 0 | −0,004 | [−0,02 ; +0,004] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,28 | 0,26 | — | −0,03 | [−0,07 ; +0,01] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,043 % | -0,044 % | 0 → 0 | +0,002 pt | [−0,010 pt ; +0,009 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 34,6 % | 32,7 % | — | 0,0 pt | [−1,5 pt ; 0,0 pt] | 11 / 6 / 13 sur 30 | non concluant |
| |Inflation sur 100 j| max | 106,0 % | 107,6 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 3 / 6 / 21 sur 30 | non concluant |
| Alertes critiques ouvertes | 15,5 | 12 | 30 → 30 | −2 | [−4 ; 0] | 19 / 9 / 2 sur 30 | non concluant |
| … dont après la chauffe | 14 | 11 | — | −2 | [−4,5 ; 0] | 18 / 9 / 3 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 56 | 37,5 | — | −21,5 | [−87 ; −4] | 21 / 8 / 1 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 303 | 286,5 | — | −0,5 | [−37 ; +32] | 15 / 15 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,0002 | [+0,00003 ; +0,001] | 21 / 9 / 0 sur 30 | **B plus haut (mieux)** |
| Naissances d’entreprises / an | 5,6 | 6,6 | — | +1,0 | [+0,6 ; +1,7] | — / — / 3 | **B plus haut** |
| Naissances / an, en % du parc moyen | 17,6 | 20,5 | — | +3,3 | [+2,1 ; +5,4] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 16,5 | 19,2 | — | +2,7 | [−1,0 ; +5,3] | — / — / 0 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 31,3 | 31,4 | — | +0,2 | [−0,3 ; +0,6] | — / — / 0 | non concluant |
| Demande non servie (part des unités demandées) | 1,1 % | 1,0 % | — | −0,2 pt | [−0,5 pt ; +0,01 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 22,0 % | 20,6 % | — | +0,6 pt | [−3,6 pt ; +2,2 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 28 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 28 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | 0 | [−1 ; 0] | — / — / 11 | non concluant |
| Fermetures : faillite (salaires impayables) | 17 | 20 | — | +2,5 | [−0,5 ; +6] | — / — / 2 | non concluant |
| Fermetures : demande perdue | 1 | 1,5 | — | +1 | [0 ; +1,5] | — / — / 6 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | 0 | [0 ; +1] | — / — / 12 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 5,1 | 6,2 | — | +0,7 | [−0,1 ; +1,7] | — / — / 1 | non concluant |
| Entonnoir : projets envisagés | 8279 | 9126,5 | — | +954,5 | [+528 ; +1366,5] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 23 | 27 | — | +4 | [+2,5 ; +7] | — / — / 3 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 131,5 | 133,5 | — | +16 | [−20 ; +36,5] | — / — / 0 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 808,5 | 640 | — | −103 | [−265 ; +74] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 2620 | 2384,5 | — | −134 | [−269 ; +21,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 3571 | 3509 | — | −74,5 | [−131 ; +73] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 81,5 | 152 | — | +51 | [+20,5 ; +125,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 607,5 | 1955 | — | +1098,5 | [+936,5 ; +1550,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 254 | 211,5 | — | −26,5 | [−140 ; +7] | — / — / 1 | non concluant |
| Types d’entreprise actifs en fin | 29 | 29 | — | +1 | [−0,5 ; +2] | 16 / 10 / 4 sur 30 | non concluant |
| Machines en fin | 341,5 | 346,4 | — | +2,5 | [−69,4 ; +74,2] | 15 / 15 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 2 | — | −1 | [−3 ; +1] | 16 / 11 / 3 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | +0,001 | [−0,0002 ; +0,01] | 19 / 11 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | −0,04 | [−0,2 ; −0,01] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 4 / 3 / 23 sur 30 | non concluant |
| Trésor de l’État le plus bas | 63 159 $ | 87 603 $ | — | +14 454 $ | [+910 $ ; +42 945 $] | 20 / 8 / 2 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 5 123 $ | 3 876 $ | — | −548 $ | [−3 070 $ ; +15 $] | — / — / 2 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 5 → 5 | 0,00 | [0,00 ; 0,00] | 7 / 5 / 18 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 5,16 | 4,77 | 30 → 30 | −0,43 | [−1,25 ; +0,30] | 16 / 13 / 1 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 3,80 | 0,84 | 21 → 14 | −2,52 | [−5,05 ; −0,09] | 21 / 8 / 1 sur 30 | **B plus bas (mieux)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 9 → 4 | 0 | [0 ; 0] | 8 / 4 / 18 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 9 / 3 / 18 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 8 → 10 | 0 | [0 ; 0] | 5 / 6 / 19 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 5 / 8 / 17 sur 30 | non concluant |
| Sans-abri nombreux | 2 | 1 | 29 → 24 | −1 | [−2 ; 0] | 19 / 5 / 6 sur 30 | non concluant |
| … jours-alerte | 26,5 | 19 | — | −8,5 | [−19 ; −4] | 22 / 7 / 1 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 11 | 10 | 30 → 30 | 0 | [−2 ; +1] | 14 / 11 / 5 sur 30 | non concluant |
| … jours-alerte | 11 | 10 | — | 0 | [−2 ; +0,5] | 14 / 10 / 6 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 1 | 24 → 24 | 0 | [0 ; 0] | 5 / 1 / 24 sur 30 | non concluant |
| … jours-alerte | 9 | 9 | — | 0 | [0 ; 0] | 5 / 2 / 23 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 5 → 1 | 0 | [0 ; 0] | 5 / 1 / 24 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 5 / 1 / 24 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Entonnoir : projets envisagés : +946 [+738,5 ; +1164] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +39,5 [+9 ; +72] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, viabilité : +977,5 [+828 ; +1122] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Sans-abri moyen : −0,2 pt [−0,4 pt ; −0,03 pt], B mieux (21 graines mieux, 8 moins bien, 1 égales)
- Avec filets — Jours-alerte critiques (somme des types) : −21,5 [−87 ; −4], B mieux (21 graines mieux, 8 moins bien, 1 égales)
- Avec filets — Santé moyenne : +0,0002 [+0,00003 ; +0,001], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Naissances d’entreprises / an : +1,0 [+0,6 ; +1,7] (0 graines mieux, 0 moins bien, 3 égales)
- Avec filets — Naissances / an, en % du parc moyen : +3,3 [+2,1 ; +5,4] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : projets envisagés : +954,5 [+528 ; +1366,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : créations : +4 [+2,5 ; +7] (0 graines mieux, 0 moins bien, 3 égales)
- Avec filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +51 [+20,5 ; +125,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : +1098,5 [+936,5 ; +1550,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Hôpital public : attente moyenne (j) : −0,04 [−0,2 ; −0,01], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets — Trésor de l’État le plus bas : +14 454 $ [+910 $ ; +42 945 $], B mieux (20 graines mieux, 8 moins bien, 2 égales)
- Avec filets — Filet : Plancher de logement / 50 j : −2,52 [−5,05 ; −0,09], B mieux (21 graines mieux, 8 moins bien, 1 égales)
- Avec filets — Sans-abri nombreux : jours-alerte : −8,5 [−19 ; −4], B mieux (22 graines mieux, 7 moins bien, 1 égales)

