# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 19:19
- A : `g30-ferme-sans.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : revival = 0
- B : `g30-ferme-plan.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : revival = 1, revivalPlannedDemand = 1
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,6 % | 9,4 % | 11 → 13 | +0,01 pt | [−0,4 pt ; +0,5 pt] | 13 / 15 / 2 sur 30 | non concluant |
| Chômage max | 24,6 % | 26,7 % | — | 0,0 pt | [0,0 pt ; +1,2 pt] | 7 / 12 / 11 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 1 | 0,0 pt | [0,0 pt ; 0,0 pt] | 8 / 7 / 15 sur 30 | non concluant |
| Faim max | 33,1 % | 35,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 7 / 7 / 16 sur 30 | non concluant |
| Sans-abri moyen | 0,4 % | 0,6 % | 3 → 4 | 0,0 pt | [−0,1 pt ; +0,3 pt] | 14 / 14 / 2 sur 30 | non concluant |
| Sans-abri max | 31,7 % | 39,4 % | — | 0,0 pt | [0,0 pt ; +9,4 pt] | 8 / 13 / 9 sur 30 | non concluant |
| Gini moyen | 0,28 | 0,28 | 0 → 0 | +0,001 | [−0,003 ; +0,01] | — / — / 2 | non concluant |
| Gini en fin de partie | 0,29 | 0,29 | — | +0,01 | [−0,01 ; +0,01] | — / — / 2 | non concluant |
| Inflation moyenne / j | -0,052 % | -0,057 % | 0 → 0 | −0,0001 pt | [−0,008 pt ; +0,004 pt] | — / — / 2 | non concluant |
| |Inflation| max / j | 34,4 % | 36,5 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 3 / 4 / 23 sur 30 | non concluant |
| |Inflation sur 100 j| max | 108,7 % | 108,7 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 3 / 27 sur 30 | non concluant |
| Alertes critiques ouvertes | 16,5 | 18 | 30 → 30 | 0 | [−1,5 ; +1] | 14 / 13 / 3 sur 30 | non concluant |
| … dont après la chauffe | 14 | 15 | — | 0 | [−1,5 ; +1] | 14 / 13 / 3 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 71 | 93,5 | — | +3,5 | [−4,5 ; +13] | 12 / 16 / 2 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 381,5 | 395 | — | 0 | [−36 ; +4,5] | 14 / 13 / 3 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,00002 | [−0,00003 ; +0,0001] | 16 / 11 / 3 sur 30 | non concluant |
| Naissances d’entreprises / an | 10,0 | 9,9 | — | 0,0 | [−1,0 ; +0,9] | — / — / 4 | non concluant |
| Naissances / an, en % du parc moyen | 32,7 | 29,7 | — | 0,0 | [−3,0 ; +2,4] | — / — / 2 | non concluant |
| Morts / an, en % du parc moyen | 30,9 | 28,0 | — | 0,0 | [−3,2 ; +1,3] | — / — / 2 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 31,8 | 32,0 | — | 0,0 | [−0,2 ; +0,1] | — / — / 2 | non concluant |
| Demande non servie (part des unités demandées) | 1,6 % | 1,6 % | — | −0,02 pt | [−0,1 pt ; +0,1 pt] | 16 / 12 / 2 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 15,1 % | 16,1 % | — | −0,2 pt | [−1,0 pt ; +1,5 pt] | — / — / 2 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 24 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 24 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | 0 | [0 ; +1] | — / — / 12 | non concluant |
| Fermetures : faillite (salaires impayables) | 33,5 | 30,5 | — | 0 | [−2,5 ; +2] | — / — / 6 | non concluant |
| Fermetures : demande perdue | 2 | 2 | — | 0 | [−0,5 ; +0,5] | — / — / 10 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 2 | — | 0 | [−1 ; +0,5] | — / — / 7 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 10,2 | 9,1 | — | 0,0 | [−1,0 ; +0,5] | — / — / 2 | non concluant |
| Entonnoir : projets envisagés | 9238,5 | 8983,5 | — | −2,5 | [−526,5 ; +266] | — / — / 0 | non concluant |
| Entonnoir : créations | 41 | 40,5 | — | 0 | [−4 ; +3,5] | — / — / 4 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 249,5 | 236,5 | — | −9 | [−19,5 ; +11] | — / — / 1 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 1547,5 | 1502,5 | — | −10,5 | [−245 ; +58] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 2440,5 | 2395,5 | — | −13,5 | [−91 ; +52] | — / — / 2 | non concluant |
| Entonnoir : refus, demande insuffisante | 3464 | 3451,5 | — | −20,5 | [−209,5 ; +116,6] | — / — / 2 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 168,5 | 163 | — | −7,5 | [−25,5 ; +23,5] | — / — / 0 | non concluant |
| Entonnoir : refus, viabilité | 775 | 714 | — | +85 | [−14 ; +110] | — / — / 0 | non concluant |
| Entonnoir : refus, aucun fondateur assez riche | 422,5 | 494,5 | — | +1 | [−15,5 ; +128] | — / — / 3 | non concluant |
| Types d’entreprise actifs en fin | 28 | 28 | — | 0 | [−1 ; +1] | 13 / 11 / 6 sur 30 | non concluant |
| Machines en fin | 366,3 | 367,7 | — | +11,4 | [−1,2 ; +43,9] | 17 / 11 / 2 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 2,5 | 2 | — | 0 | [−1 ; +1] | 11 / 13 / 6 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | −0,00005 | [−0,002 ; +0,0004] | 13 / 15 / 2 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | −0,002 | [−0,01 ; +0,001] | 17 / 10 / 3 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| Trésor de l’État le plus bas | 79 907 $ | 67 924 $ | — | 0 $ | [−1 102 $ ; 0 $] | 7 / 12 / 11 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 4 / 3 / 23 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 23 | non concluant |
| Créances radiées | 16 402 $ | 15 346 $ | — | 0 $ | [−2 686 $ ; +1 995 $] | — / — / 2 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 6 → 7 | 0 | [0 ; 0] | 1 / 4 / 25 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 1 / 6 / 23 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 18 → 17 | 0 | [0 ; 0] | 7 / 4 / 19 sur 30 | non concluant |
| … jours-alerte | 2 | 2,5 | — | 0 | [0 ; 0] | 7 / 6 / 17 sur 30 | non concluant |
| Sans-abri nombreux | 3 | 3 | 28 → 29 | 0 | [−1 ; +0,5] | 14 / 10 / 6 sur 30 | non concluant |
| … jours-alerte | 36 | 32,5 | — | 0 | [−9 ; +9,5] | 13 / 14 / 3 sur 30 | non concluant |
| Inflation quotidienne | 11 | 10 | 29 → 29 | 0 | [−0,5 ; 0] | 10 / 9 / 11 sur 30 | non concluant |
| … jours-alerte | 11 | 10,5 | — | 0 | [−0,5 ; 0] | 10 / 9 / 11 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 28 → 28 | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| … jours-alerte | 10 | 10 | — | 0 | [0 ; 0] | 0 / 3 / 27 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 1 → 1 | 0 | [0 ; 0] | 1 / 1 / 28 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 1 / 1 / 28 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,4 % | 8,3 % | 9 → 9 | −0,1 pt | [−0,8 pt ; +1,0 pt] | 17 / 13 / 0 sur 30 | non concluant |
| Chômage max | 24,8 % | 22,7 % | — | 0,0 pt | [−0,8 pt ; 0,0 pt] | 12 / 9 / 9 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 1 | 0,0 pt | [0,0 pt ; 0,0 pt] | 3 / 6 / 21 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 3 / 5 / 22 sur 30 | non concluant |
| Sans-abri moyen | 0,4 % | 0,4 % | 2 → 2 | +0,1 pt | [−0,1 pt ; +0,2 pt] | 12 / 17 / 1 sur 30 | non concluant |
| Sans-abri max | 30,4 % | 37,9 % | — | +3,3 pt | [0,0 pt ; +10,8 pt] | 6 / 15 / 9 sur 30 | non concluant |
| Gini moyen | 0,25 | 0,24 | 1 → 0 | −0,002 | [−0,01 ; +0,003] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,28 | 0,26 | — | −0,01 | [−0,03 ; +0,01] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,043 % | -0,040 % | 0 → 0 | +0,002 pt | [−0,002 pt ; +0,008 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 34,6 % | 35,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 3 / 8 / 19 sur 30 | non concluant |
| |Inflation sur 100 j| max | 106,0 % | 106,9 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 2 / 26 sur 30 | non concluant |
| Alertes critiques ouvertes | 15,5 | 14,5 | 30 → 30 | 0 | [−1 ; +1] | 11 / 14 / 5 sur 30 | non concluant |
| … dont après la chauffe | 14 | 13,5 | — | 0 | [−1 ; +1] | 11 / 14 / 5 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 56 | 59 | — | −0,5 | [−8,5 ; +6] | 15 / 13 / 2 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 303 | 301 | — | +12 | [−11,5 ; +56] | 12 / 17 / 1 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,00001 | [−0,00003 ; +0,0001] | 16 / 13 / 1 sur 30 | non concluant |
| Naissances d’entreprises / an | 5,6 | 5,6 | — | +0,7 | [+0,2 ; +1,7] | — / — / 1 | **B plus haut** |
| Naissances / an, en % du parc moyen | 17,6 | 18,2 | — | +2,3 | [+0,5 ; +5,6] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 16,5 | 17,6 | — | +2,5 | [+0,3 ; +4,0] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 31,3 | 31,8 | — | +0,2 | [+0,01 ; +0,6] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 1,1 % | 1,1 % | — | −0,02 pt | [−0,1 pt ; +0,1 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 22,0 % | 19,6 % | — | −2,8 pt | [−3,9 pt ; +0,7 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 25 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 25 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | 0 | [−1 ; 0] | — / — / 9 | non concluant |
| Fermetures : faillite (salaires impayables) | 17 | 18,5 | — | +3 | [−0,5 ; +4] | — / — / 1 | non concluant |
| Fermetures : demande perdue | 1 | 2 | — | +0,5 | [0 ; +1] | — / — / 9 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | 0 | [0 ; +1,5] | — / — / 9 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 5,1 | 5,7 | — | +0,9 | [+0,1 ; +1,3] | — / — / 1 | **B plus haut** |
| Entonnoir : projets envisagés | 8279 | 8621,5 | — | +334,5 | [+141 ; +696] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 23 | 23 | — | +3 | [+1 ; +7] | — / — / 1 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 131,5 | 135 | — | +21 | [+0,5 ; +59] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, délai entre deux créations du type | 808,5 | 822 | — | +71,5 | [−40,5 ; +231,5] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 2620 | 2687,5 | — | +68 | [+23,5 ; +91] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, demande insuffisante | 3571 | 3508,5 | — | −74 | [−207 ; +172] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 81,5 | 127,5 | — | +22 | [+7 ; +54,5] | — / — / 1 | **B plus haut** |
| Entonnoir : refus, viabilité | 607,5 | 827,5 | — | +110,5 | [+28,5 ; +265,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 254 | 373 | — | −0,5 | [−46 ; +9,1] | — / — / 4 | non concluant |
| Types d’entreprise actifs en fin | 29 | 29 | — | 0 | [0 ; +1] | 14 / 7 / 9 sur 30 | non concluant |
| Machines en fin | 341,5 | 398,6 | — | +20,9 | [−18,4 ; +67,1] | 17 / 13 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 2 | — | 0 | [−2,5 ; 0] | 13 / 9 / 8 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | −0,0002 | [−0,001 ; +0,001] | 14 / 16 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | −0,003 | [−0,03 ; +0,004] | 16 / 13 / 1 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 1 / 27 sur 30 | non concluant |
| Trésor de l’État le plus bas | 63 159 $ | 70 192 $ | — | 0 $ | [−340 $ ; +368 $] | 12 / 10 / 8 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 5 123 $ | 5 491 $ | — | +246 $ | [−248 $ ; +2 069 $] | — / — / 1 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 5 → 6 | 0,00 | [0,00 ; 0,00] | 3 / 5 / 22 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 5,16 | 4,95 | 30 → 30 | +0,02 | [−0,70 ; +0,54] | 15 / 15 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 3,80 | 4,50 | 21 → 21 | +0,25 | [−1,27 ; +4,07] | 13 / 16 / 1 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 1 | 0,00 | [0,00 ; 0,00] | 0 / 1 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 9 → 7 | 0 | [0 ; 0] | 4 / 3 / 23 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 6 / 4 / 20 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 8 → 10 | 0 | [0 ; 0] | 3 / 4 / 23 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 5 / 22 sur 30 | non concluant |
| Sans-abri nombreux | 2 | 2 | 29 → 30 | 0 | [0 ; +0,5] | 9 / 10 / 11 sur 30 | non concluant |
| … jours-alerte | 26,5 | 31 | — | +3 | [−1,5 ; +9] | 11 / 16 / 3 sur 30 | non concluant |
| Inflation quotidienne | 11 | 11 | 30 → 30 | 0 | [0 ; +1] | 6 / 14 / 10 sur 30 | non concluant |
| … jours-alerte | 11 | 11 | — | 0 | [0 ; +1] | 6 / 14 / 10 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 1 | 24 → 25 | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| … jours-alerte | 9 | 9 | — | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 5 → 3 | 0 | [0 ; 0] | 2 / 0 / 28 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 2 / 1 / 27 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Avec filets — Naissances d’entreprises / an : +0,7 [+0,2 ; +1,7] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Naissances / an, en % du parc moyen : +2,3 [+0,5 ; +5,6] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts / an, en % du parc moyen : +2,5 [+0,3 ; +4,0] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Parc moyen d’entreprises (après la chauffe) : +0,2 [+0,01 ; +0,6] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts d’entreprises / an : +0,9 [+0,1 ; +1,3] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Entonnoir : projets envisagés : +334,5 [+141 ; +696] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : créations : +3 [+1 ; +7] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Entonnoir : refus, une création déjà ce jour : +21 [+0,5 ; +59] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, concurrence : +68 [+23,5 ; +91] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +22 [+7 ; +54,5] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Entonnoir : refus, viabilité : +110,5 [+28,5 ; +265,5] (0 graines mieux, 0 moins bien, 0 égales)

