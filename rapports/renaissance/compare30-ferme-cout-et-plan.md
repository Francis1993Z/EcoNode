# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 19:21
- A : `g30-ferme-regle.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : revival = 1
- B : `g30-ferme-both.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : revival = 1, revivalFullCost = 1, revivalPlannedDemand = 1
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 9,1 % | 9,1 % | 11 → 13 | +0,4 pt | [−1,2 pt ; +1,7 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Chômage max | 24,6 % | 26,3 % | — | 0,0 pt | [−1,7 pt ; +4,4 pt] | 14 / 14 / 2 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,2 % | 1 → 1 | +0,001 pt | [−0,0003 pt ; +0,03 pt] | 10 / 15 / 5 sur 30 | non concluant |
| Faim max | 36,3 % | 45,6 % | — | 0,0 pt | [−3,3 pt ; +10,0 pt] | 12 / 13 / 5 sur 30 | non concluant |
| Sans-abri moyen | 0,5 % | 0,6 % | 1 → 2 | +0,04 pt | [−0,2 pt ; +0,4 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Sans-abri max | 30,0 % | 40,2 % | — | 0,0 pt | [−0,8 pt ; +10,2 pt] | 10 / 12 / 8 sur 30 | non concluant |
| Gini moyen | 0,29 | 0,29 | 0 → 0 | +0,01 | [−0,01 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,29 | 0,29 | — | +0,01 | [−0,02 ; +0,03] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,050 % | -0,049 % | 0 → 0 | −0,003 pt | [−0,011 pt ; +0,005 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 37,2 % | 36,2 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 6 / 5 / 19 sur 30 | non concluant |
| |Inflation sur 100 j| max | 108,8 % | 109,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 4 / 4 / 22 sur 30 | non concluant |
| Alertes critiques ouvertes | 16 | 17 | 30 → 30 | +0,5 | [−1,5 ; +3] | 12 / 15 / 3 sur 30 | non concluant |
| … dont après la chauffe | 14 | 15,5 | — | +0,5 | [−1,5 ; +3] | 12 / 15 / 3 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 67 | 71,5 | — | −1,5 | [−14 ; +39,5] | 15 / 14 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 353,5 | 405 | — | +10 | [−20 ; +73] | 13 / 17 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | −0,0001 | [−0,0003 ; +0,00004] | 12 / 18 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 10,2 | 9,6 | — | 0,0 | [−2,1 ; +2,2] | — / — / 0 | non concluant |
| Naissances / an, en % du parc moyen | 32,1 | 30,1 | — | −0,5 | [−5,7 ; +5,9] | — / — / 0 | non concluant |
| Morts / an, en % du parc moyen | 30,7 | 28,0 | — | −2,2 | [−4,7 ; +1,7] | — / — / 0 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 31,9 | 32,4 | — | +0,5 | [+0,1 ; +0,9] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 1,6 % | 1,5 % | — | −0,002 pt | [−0,3 pt ; +0,2 pt] | 15 / 15 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 18,5 % | 16,4 % | — | −2,1 pt | [−5,1 pt ; −0,5 pt] | — / — / 0 | **B plus bas** |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 23 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 23 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | 0 | [−1 ; +1] | — / — / 7 | non concluant |
| Fermetures : faillite (salaires impayables) | 33,5 | 31,5 | — | −1,5 | [−4,5 ; +2] | — / — / 2 | non concluant |
| Fermetures : demande perdue | 2 | 2 | — | 0 | [−1 ; 0] | — / — / 9 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 2,5 | — | 0 | [−1,5 ; +1] | — / — / 5 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 9,9 | 9,2 | — | −0,4 | [−1,6 ; +0,6] | — / — / 3 | non concluant |
| Entonnoir : projets envisagés | 10167,5 | 9155 | — | −808 | [−1075,5 ; −451,5] | — / — / 0 | **B plus bas** |
| Entonnoir : créations | 42 | 39,5 | — | 0 | [−8,5 ; +9] | — / — / 0 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 230 | 238 | — | +30 | [−33,5 ; +87,5] | — / — / 0 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 1365,5 | 1392 | — | +150 | [−38 ; +432,5] | — / — / 1 | non concluant |
| Entonnoir : refus, concurrence | 2392,5 | 2457,5 | — | +43,5 | [−62,5 ; +193,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 3620,5 | 3544 | — | +13 | [−149 ; +244] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 225,5 | 220,5 | — | −43 | [−95,5 ; +37,5] | — / — / 0 | non concluant |
| Entonnoir : refus, viabilité | 1799 | 781,5 | — | −1044 | [−1171,5 ; −947] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, aucun fondateur assez riche | 562,5 | 502,5 | — | −6,5 | [−131,5 ; +49] | — / — / 1 | non concluant |
| Types d’entreprise actifs en fin | 28 | 28 | — | +1 | [0 ; +1,5] | 17 / 9 / 4 sur 30 | non concluant |
| Machines en fin | 393,3 | 395,7 | — | +1,1 | [−31,2 ; +38,0] | 15 / 15 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 2,5 | 2,5 | — | +1 | [−1 ; +2] | 11 / 18 / 1 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | +0,001 | [−0,01 ; +0,002] | 16 / 14 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | +0,01 | [−0,01 ; +0,1] | 11 / 19 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 3 / 2 / 25 sur 30 | non concluant |
| Trésor de l’État le plus bas | 69 662 $ | 66 754 $ | — | +4 401 $ | [−15 336 $ ; +15 536 $] | 16 / 14 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 2 / 5 / 23 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 20 | non concluant |
| Créances radiées | 20 191 $ | 19 906 $ | — | +1 522 $ | [−5 416 $ ; +3 579 $] | — / — / 1 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 7 → 7 | 0 | [0 ; 0] | 5 / 6 / 19 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 5 / 6 / 19 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 17 → 19 | 0 | [0 ; +1] | 4 / 11 / 15 sur 30 | non concluant |
| … jours-alerte | 3 | 4 | — | 0 | [0 ; +1] | 8 / 11 / 11 sur 30 | non concluant |
| Sans-abri nombreux | 3 | 4 | 29 → 29 | +1 | [−1 ; +1] | 11 / 16 / 3 sur 30 | non concluant |
| … jours-alerte | 32 | 39 | — | +1 | [−11,5 ; +21] | 15 / 15 / 0 sur 30 | non concluant |
| Inflation quotidienne | 10 | 10 | 30 → 29 | 0 | [−1 ; +1] | 14 / 13 / 3 sur 30 | non concluant |
| … jours-alerte | 10 | 10 | — | −0,5 | [−1 ; +1] | 15 / 13 / 2 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 27 → 28 | 0 | [0 ; 0] | 1 / 5 / 24 sur 30 | non concluant |
| … jours-alerte | 10 | 10 | — | 0 | [0 ; 0] | 2 / 4 / 24 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 8,6 % | 8 → 9 | +1,0 pt | [−1,4 pt ; +2,0 pt] | 12 / 18 / 0 sur 30 | non concluant |
| Chômage max | 22,1 % | 23,3 % | — | +1,7 pt | [−0,8 pt ; +6,3 pt] | 10 / 19 / 1 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; +0,02 pt] | 6 / 10 / 14 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; +26,5 pt] | 5 / 11 / 14 sur 30 | non concluant |
| Sans-abri moyen | 0,1 % | 0,4 % | 2 → 4 | +0,3 pt | [+0,01 pt ; +0,4 pt] | 10 / 20 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 35,6 % | 39,0 % | — | +1,9 pt | [−0,6 pt ; +16,0 pt] | 10 / 15 / 5 sur 30 | non concluant |
| Gini moyen | 0,25 | 0,25 | 0 → 0 | +0,01 | [−0,004 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,26 | 0,29 | — | +0,02 | [−0,02 ; +0,06] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,044 % | -0,037 % | 0 → 0 | +0,002 pt | [−0,009 pt ; +0,015 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 32,7 % | 35,8 % | — | 0,0 pt | [0,0 pt ; +3,7 pt] | 6 / 13 / 11 sur 30 | non concluant |
| |Inflation sur 100 j| max | 107,6 % | 106,9 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 6 / 4 / 20 sur 30 | non concluant |
| Alertes critiques ouvertes | 12 | 15 | 30 → 30 | +3 | [+1,5 ; +5] | 6 / 22 / 2 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 11 | 14 | — | +3 | [+2 ; +5] | 6 / 22 / 2 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 37,5 | 58 | — | +19 | [+6 ; +39] | 5 / 23 / 2 sur 30 | **B plus haut (moins bien)** |
| Alertes ouvertes (toutes) | 286,5 | 308 | — | +5 | [−16 ; +38] | 12 / 18 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | −0,0001 | [−0,001 ; +0,00002] | 12 / 18 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 6,6 | 6,2 | — | −0,2 | [−1,1 ; +0,5] | — / — / 1 | non concluant |
| Naissances / an, en % du parc moyen | 20,5 | 20,2 | — | −0,04 | [−3,4 ; +1,9] | — / — / 0 | non concluant |
| Morts / an, en % du parc moyen | 19,2 | 19,6 | — | −0,2 | [−1,8 ; +3,4] | — / — / 0 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 31,4 | 31,2 | — | +0,2 | [−0,9 ; +0,9] | — / — / 0 | non concluant |
| Demande non servie (part des unités demandées) | 1,0 % | 1,3 % | — | +0,2 pt | [+0,01 pt ; +0,5 pt] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 20,6 % | 17,7 % | — | −4,2 pt | [−5,9 pt ; +1,4 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 28 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 28 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | 0 | [0 ; +0,5] | — / — / 16 | non concluant |
| Fermetures : faillite (salaires impayables) | 20 | 19 | — | −2,5 | [−6 ; +2,5] | — / — / 1 | non concluant |
| Fermetures : demande perdue | 1,5 | 2 | — | +1 | [0 ; +2] | — / — / 7 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | +0,5 | [−1 ; +1] | — / — / 4 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 6,2 | 6,2 | — | 0,0 | [−0,5 ; +1,0] | — / — / 2 | non concluant |
| Entonnoir : projets envisagés | 9126,5 | 8952 | — | −573 | [−943 ; +18] | — / — / 0 | non concluant |
| Entonnoir : créations | 27 | 25,5 | — | −1 | [−4,5 ; +2] | — / — / 1 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 133,5 | 170,5 | — | +21 | [−12,5 ; +48,5] | — / — / 0 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 640 | 877,5 | — | +214 | [+142 ; +444,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, concurrence | 2384,5 | 2619 | — | +120,5 | [+68,5 ; +303] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, demande insuffisante | 3509 | 3572 | — | −12 | [−239 ; +202,1] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 152 | 180,5 | — | +22 | [−53 ; +101,5] | — / — / 0 | non concluant |
| Entonnoir : refus, viabilité | 1955 | 737,5 | — | −1035 | [−1474,5 ; −646] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, aucun fondateur assez riche | 211,5 | 335,5 | — | +99 | [−35 ; +253] | — / — / 0 | non concluant |
| Types d’entreprise actifs en fin | 29 | 29,5 | — | 0 | [−1 ; +0,5] | 10 / 14 / 6 sur 30 | non concluant |
| Machines en fin | 346,4 | 414,8 | — | +6,3 | [−40,9 ; +70,1] | 16 / 14 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 2 | 3 | — | +0,5 | [−1 ; +2] | 11 / 15 / 4 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | −0,002 | [−0,004 ; −0,0004] | 7 / 23 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | +0,01 | [+0,002 ; +0,1] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 3 / 25 sur 30 | non concluant |
| Trésor de l’État le plus bas | 87 603 $ | 68 260 $ | — | −12 059 $ | [−26 212 $ ; +296 $] | 10 / 19 / 1 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 3 876 $ | 6 482 $ | — | +1 378 $ | [−820 $ ; +4 212 $] | — / — / 0 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 5 → 9 | 0,00 | [0,00 ; +0,04] | 4 / 10 / 16 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 4,77 | 4,82 | 30 → 30 | +0,29 | [−0,16 ; +1,09] | 11 / 19 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,84 | 4,43 | 14 → 24 | +1,73 | [+0,34 ; +4,43] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 1 | 0,00 | [0,00 ; 0,00] | 0 / 1 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 4 → 5 | 0 | [0 ; 0] | 3 / 4 / 23 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 4 / 23 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 10 → 13 | 0 | [0 ; 0] | 5 / 9 / 16 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; +0,5] | 6 / 10 / 14 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 3 | 24 → 29 | +1,5 | [+0,5 ; +2] | 3 / 20 / 7 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 19 | 33 | — | +14 | [+5 ; +23,5] | 6 / 23 / 1 sur 30 | **B plus haut (moins bien)** |
| Inflation quotidienne | 10 | 10 | 30 → 30 | +1 | [−0,5 ; +2] | 10 / 17 / 3 sur 30 | non concluant |
| … jours-alerte | 10 | 10,5 | — | +1 | [−0,5 ; +2] | 10 / 18 / 2 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 1 | 24 → 25 | 0 | [0 ; 0] | 1 / 7 / 22 sur 30 | non concluant |
| … jours-alerte | 9 | 9 | — | 0 | [0 ; 0] | 1 / 7 / 22 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 1 → 2 | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Parc moyen d’entreprises (après la chauffe) : +0,5 [+0,1 ; +0,9] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) : −2,1 pt [−5,1 pt ; −0,5 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : projets envisagés : −808 [−1075,5 ; −451,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, viabilité : −1044 [−1171,5 ; −947] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Sans-abri moyen : +0,3 pt [+0,01 pt ; +0,4 pt], B moins bien (10 graines mieux, 20 moins bien, 0 égales)
- Avec filets — Alertes critiques ouvertes : +3 [+1,5 ; +5], B moins bien (6 graines mieux, 22 moins bien, 2 égales)
- Avec filets — dont après la chauffe (criticalSteady) : +3 [+2 ; +5], B moins bien (6 graines mieux, 22 moins bien, 2 égales)
- Avec filets — Jours-alerte critiques (somme des types) : +19 [+6 ; +39], B moins bien (5 graines mieux, 23 moins bien, 2 égales)
- Avec filets — Demande non servie (part des unités demandées) : +0,2 pt [+0,01 pt ; +0,5 pt], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, délai entre deux créations du type : +214 [+142 ; +444,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, concurrence : +120,5 [+68,5 ; +303] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : −1035 [−1474,5 ; −646] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Bonheur moyen : −0,002 [−0,004 ; −0,0004], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets — Hôpital public : attente moyenne (j) : +0,01 [+0,002 ; +0,1], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets — Filet : Plancher de logement / 50 j : +1,73 [+0,34 ; +4,43], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets — Sans-abri nombreux : +1,5 [+0,5 ; +2], B moins bien (3 graines mieux, 20 moins bien, 7 égales)
- Avec filets — Sans-abri nombreux : jours-alerte : +14 [+5 ; +23,5], B moins bien (6 graines mieux, 23 moins bien, 1 égales)

