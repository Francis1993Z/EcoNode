# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 19:19
- A : `g30-ferme-regle.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : revival = 1
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
| Chômage moyen | 9,1 % | 9,4 % | 11 → 13 | +0,6 pt | [−0,8 pt ; +1,5 pt] | 12 / 18 / 0 sur 30 | non concluant |
| Chômage max | 24,6 % | 26,7 % | — | +2,7 pt | [−0,2 pt ; +4,6 pt] | 10 / 19 / 1 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 1 → 1 | 0,0 pt | [−0,0001 pt ; +0,002 pt] | 10 / 10 / 10 sur 30 | non concluant |
| Faim max | 36,3 % | 35,8 % | — | 0,0 pt | [−2,7 pt ; 0,0 pt] | 13 / 6 / 11 sur 30 | non concluant |
| Sans-abri moyen | 0,5 % | 0,6 % | 1 → 4 | +0,1 pt | [−0,2 pt ; +0,4 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Sans-abri max | 30,0 % | 39,4 % | — | 0,0 pt | [−0,6 pt ; +1,5 pt] | 12 / 11 / 7 sur 30 | non concluant |
| Gini moyen | 0,29 | 0,28 | 0 → 0 | +0,004 | [−0,01 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,29 | 0,29 | — | −0,01 | [−0,04 ; +0,02] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,050 % | -0,057 % | 0 → 0 | −0,006 pt | [−0,012 pt ; −0,002 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 37,2 % | 36,5 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 7 / 4 / 19 sur 30 | non concluant |
| |Inflation sur 100 j| max | 108,8 % | 108,7 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 4 / 3 / 23 sur 30 | non concluant |
| Alertes critiques ouvertes | 16 | 18 | 30 → 30 | +1 | [−1 ; +3] | 12 / 16 / 2 sur 30 | non concluant |
| … dont après la chauffe | 14 | 15 | — | +1 | [−1 ; +3] | 12 / 16 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 67 | 93,5 | — | 0 | [−22 ; +38] | 15 / 15 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 353,5 | 395 | — | +32,5 | [−27,5 ; +61] | 13 / 17 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | −0,00004 | [−0,0002 ; +0,0001] | 12 / 18 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 10,2 | 9,9 | — | +0,1 | [−1,7 ; +1,2] | — / — / 1 | non concluant |
| Naissances / an, en % du parc moyen | 32,1 | 29,7 | — | +0,5 | [−5,5 ; +3,4] | — / — / 0 | non concluant |
| Morts / an, en % du parc moyen | 30,7 | 28,0 | — | +0,2 | [−4,4 ; +3,3] | — / — / 0 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 31,9 | 32,0 | — | +0,3 | [−0,2 ; +0,7] | — / — / 0 | non concluant |
| Demande non servie (part des unités demandées) | 1,6 % | 1,6 % | — | +0,1 pt | [−0,1 pt ; +0,2 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 18,5 % | 16,1 % | — | −1,6 pt | [−4,0 pt ; +0,4 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 25 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 25 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | 0 | [−1 ; +0,5] | — / — / 9 | non concluant |
| Fermetures : faillite (salaires impayables) | 33,5 | 30,5 | — | +0,5 | [−3,5 ; +2,5] | — / — / 1 | non concluant |
| Fermetures : demande perdue | 2 | 2 | — | 0 | [−1 ; +1] | — / — / 8 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 2 | — | 0 | [−2 ; 0] | — / — / 7 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 9,9 | 9,1 | — | 0,0 | [−1,8 ; +1,2] | — / — / 0 | non concluant |
| Entonnoir : projets envisagés | 10167,5 | 8983,5 | — | −1062,5 | [−1558 ; −601,5] | — / — / 0 | **B plus bas** |
| Entonnoir : créations | 42 | 40,5 | — | +0,5 | [−7 ; +5] | — / — / 1 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 230 | 236,5 | — | −8 | [−28 ; +43] | — / — / 0 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 1365,5 | 1502,5 | — | +135,5 | [−164,5 ; +391,5] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 2392,5 | 2395,5 | — | +9,5 | [−73,5 ; +249,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 3620,5 | 3451,5 | — | −168,5 | [−300 ; +69] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 225,5 | 163 | — | −64 | [−108 ; −18] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, viabilité | 1799 | 714 | — | −905 | [−1099,5 ; −776] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, aucun fondateur assez riche | 562,5 | 494,5 | — | +2 | [−118,5 ; +96] | — / — / 0 | non concluant |
| Types d’entreprise actifs en fin | 28 | 28 | — | 0 | [−1 ; +1] | 11 / 12 / 7 sur 30 | non concluant |
| Machines en fin | 393,3 | 367,7 | — | −1,5 | [−49,0 ; +53,7] | 13 / 17 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 2,5 | 2 | — | 0 | [0 ; +2] | 8 / 14 / 8 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | −0,0002 | [−0,004 ; +0,001] | 15 / 15 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | +0,003 | [−0,03 ; +0,03] | 14 / 16 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 3 / 3 / 24 sur 30 | non concluant |
| Trésor de l’État le plus bas | 69 662 $ | 67 924 $ | — | −1 005 $ | [−23 621 $ ; +9 416 $] | 11 / 17 / 2 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 2 / 5 / 23 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 21 | non concluant |
| Créances radiées | 20 191 $ | 15 346 $ | — | −1 098 $ | [−5 537 $ ; +4 017 $] | — / — / 1 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 7 → 7 | 0 | [0 ; 0] | 5 / 5 / 20 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 5 / 6 / 19 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 17 → 17 | 0 | [0 ; 0] | 4 / 5 / 21 sur 30 | non concluant |
| … jours-alerte | 3 | 2,5 | — | 0 | [0 ; 0] | 7 / 8 / 15 sur 30 | non concluant |
| Sans-abri nombreux | 3 | 3 | 29 → 29 | +0,5 | [−1 ; +1] | 12 / 15 / 3 sur 30 | non concluant |
| … jours-alerte | 32 | 32,5 | — | +8 | [−3 ; +16] | 12 / 18 / 0 sur 30 | non concluant |
| Inflation quotidienne | 10 | 10 | 30 → 29 | 0 | [−0,5 ; +2] | 10 / 13 / 7 sur 30 | non concluant |
| … jours-alerte | 10 | 10,5 | — | 0 | [−0,5 ; +2] | 10 / 13 / 7 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 27 → 28 | 0 | [0 ; 0] | 1 / 4 / 25 sur 30 | non concluant |
| … jours-alerte | 10 | 10 | — | 0 | [0 ; 0] | 2 / 3 / 25 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 0 → 1 | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 8,3 % | 8 → 9 | +0,4 pt | [−1,2 pt ; +1,5 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Chômage max | 22,1 % | 22,7 % | — | +1,7 pt | [−0,6 pt ; +4,8 pt] | 11 / 17 / 2 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 1 | 0,0 pt | [0,0 pt ; +0,001 pt] | 6 / 10 / 14 sur 30 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 6 / 9 / 15 sur 30 | non concluant |
| Sans-abri moyen | 0,1 % | 0,4 % | 2 → 2 | +0,2 pt | [−0,03 pt ; +0,3 pt] | 11 / 19 / 0 sur 30 | non concluant |
| Sans-abri max | 35,6 % | 37,9 % | — | 0,0 pt | [0,0 pt ; +12,7 pt] | 9 / 14 / 7 sur 30 | non concluant |
| Gini moyen | 0,25 | 0,24 | 0 → 0 | +0,004 | [−0,01 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,26 | 0,26 | — | −0,01 | [−0,02 ; +0,05] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,044 % | -0,040 % | 0 → 0 | +0,007 pt | [−0,012 pt ; +0,015 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 32,7 % | 35,3 % | — | 0,0 pt | [0,0 pt ; +3,2 pt] | 6 / 12 / 12 sur 30 | non concluant |
| |Inflation sur 100 j| max | 107,6 % | 106,9 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 6 / 4 / 20 sur 30 | non concluant |
| Alertes critiques ouvertes | 12 | 14,5 | 30 → 30 | +2 | [−1 ; +3,5] | 11 / 17 / 2 sur 30 | non concluant |
| … dont après la chauffe | 11 | 13,5 | — | +2 | [−1 ; +4] | 11 / 17 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 37,5 | 59 | — | +9,5 | [+6,5 ; +24,5] | 8 / 21 / 1 sur 30 | **B plus haut (moins bien)** |
| Alertes ouvertes (toutes) | 286,5 | 301 | — | +19,5 | [−27,5 ; +41,5] | 14 / 16 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | −0,0001 | [−0,0005 ; −0,00002] | 8 / 22 / 0 sur 30 | **B plus bas (moins bien)** |
| Naissances d’entreprises / an | 6,6 | 5,6 | — | −0,5 | [−1,5 ; +0,9] | — / — / 2 | non concluant |
| Naissances / an, en % du parc moyen | 20,5 | 18,2 | — | −0,6 | [−4,6 ; +2,6] | — / — / 0 | non concluant |
| Morts / an, en % du parc moyen | 19,2 | 17,6 | — | −0,1 | [−1,8 ; +2,2] | — / — / 0 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 31,4 | 31,8 | — | −0,1 | [−0,4 ; +0,6] | — / — / 0 | non concluant |
| Demande non servie (part des unités demandées) | 1,0 % | 1,1 % | — | +0,1 pt | [−0,1 pt ; +0,4 pt] | 12 / 18 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 20,6 % | 19,6 % | — | −0,4 pt | [−5,0 pt ; +1,5 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 24 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 24 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | 0 | [0 ; +0,5] | — / — / 15 | non concluant |
| Fermetures : faillite (salaires impayables) | 20 | 18,5 | — | 0 | [−3,5 ; +2,5] | — / — / 3 | non concluant |
| Fermetures : demande perdue | 1,5 | 2 | — | +0,5 | [0 ; +1] | — / — / 6 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | 0 | [−1 ; +1,5] | — / — / 5 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 6,2 | 5,7 | — | −0,1 | [−0,7 ; +0,7] | — / — / 4 | non concluant |
| Entonnoir : projets envisagés | 9126,5 | 8621,5 | — | −511 | [−977,5 ; −173] | — / — / 0 | **B plus bas** |
| Entonnoir : créations | 27 | 23 | — | −2 | [−6 ; +3,5] | — / — / 2 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 133,5 | 135 | — | +3 | [−12,5 ; +43] | — / — / 0 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 640 | 822 | — | +145 | [+38,5 ; +379] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, concurrence | 2384,5 | 2687,5 | — | +132,5 | [+45,5 ; +217] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, demande insuffisante | 3509 | 3508,5 | — | +38,5 | [−180 ; +155] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 152 | 127,5 | — | +2,5 | [−92,5 ; +44] | — / — / 0 | non concluant |
| Entonnoir : refus, viabilité | 1955 | 827,5 | — | −1070 | [−1328,5 ; −742,5] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, aucun fondateur assez riche | 211,5 | 373 | — | +122 | [−10,5 ; +266] | — / — / 1 | non concluant |
| Types d’entreprise actifs en fin | 29 | 29 | — | 0 | [−1 ; +1] | 12 / 12 / 6 sur 30 | non concluant |
| Machines en fin | 346,4 | 398,6 | — | +31,3 | [−7,3 ; +97,4] | 18 / 12 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 2 | 2 | — | 0 | [−2 ; +0,5] | 13 / 10 / 7 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | −0,001 | [−0,003 ; +0,0002] | 10 / 20 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | +0,01 | [+0,001 ; +0,1] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 3 / 4 / 23 sur 30 | non concluant |
| Trésor de l’État le plus bas | 87 603 $ | 70 192 $ | — | −10 663 $ | [−28 493 $ ; −887 $] | 8 / 20 / 2 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 3 876 $ | 5 491 $ | — | +1 299 $ | [−16 $ ; +3 586 $] | — / — / 0 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 5 → 6 | 0,00 | [0,00 ; 0,00] | 5 / 8 / 17 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 4,77 | 4,95 | 30 → 30 | +0,36 | [−0,25 ; +1,43] | 11 / 18 / 1 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,84 | 4,50 | 14 → 21 | +0,57 | [−0,27 ; +5,07] | 11 / 19 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 1 | 0,00 | [0,00 ; 0,00] | 0 / 1 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 4 → 7 | 0 | [0 ; 0] | 3 / 7 / 20 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 4 / 6 / 20 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 10 → 10 | 0 | [0 ; 0] | 6 / 7 / 17 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 7 / 16 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 2 | 24 → 30 | +1 | [0 ; +2] | 5 / 18 / 7 sur 30 | non concluant |
| … jours-alerte | 19 | 31 | — | +8 | [+1 ; +15] | 6 / 20 / 4 sur 30 | **B plus haut (moins bien)** |
| Inflation quotidienne | 10 | 11 | 30 → 30 | +1 | [0 ; +1,5] | 9 / 17 / 4 sur 30 | non concluant |
| … jours-alerte | 10 | 11 | — | +1 | [0 ; +2] | 8 / 18 / 4 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 1 | 24 → 25 | 0 | [0 ; 0] | 1 / 6 / 23 sur 30 | non concluant |
| … jours-alerte | 9 | 9 | — | 0 | [0 ; 0] | 2 / 6 / 22 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 1 → 3 | 0 | [0 ; 0] | 1 / 3 / 26 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 1 / 3 / 26 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Inflation moyenne / j : −0,006 pt [−0,012 pt ; −0,002 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : projets envisagés : −1062,5 [−1558 ; −601,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, pas assez de chômeurs qualifiés : −64 [−108 ; −18] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, viabilité : −905 [−1099,5 ; −776] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Jours-alerte critiques (somme des types) : +9,5 [+6,5 ; +24,5], B moins bien (8 graines mieux, 21 moins bien, 1 égales)
- Avec filets — Santé moyenne : −0,0001 [−0,0005 ; −0,00002], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets — Entonnoir : projets envisagés : −511 [−977,5 ; −173] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, délai entre deux créations du type : +145 [+38,5 ; +379] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, concurrence : +132,5 [+45,5 ; +217] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : −1070 [−1328,5 ; −742,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Hôpital public : attente moyenne (j) : +0,01 [+0,001 ; +0,1], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets — Trésor de l’État le plus bas : −10 663 $ [−28 493 $ ; −887 $], B moins bien (8 graines mieux, 20 moins bien, 2 égales)
- Avec filets — Sans-abri nombreux : jours-alerte : +8 [+1 ; +15], B moins bien (6 graines mieux, 20 moins bien, 4 égales)

