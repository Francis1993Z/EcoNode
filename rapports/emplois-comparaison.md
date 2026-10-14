# Comparaison appariée ÉcoNodes

- Date : 2026-10-13 21:25
- A : `jobs=1`
- A — Modules coupés : Bâtiments, construction et hypothèques
- B : `ref`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 3 min 27 s pour 120 parties, au plus 16 à la fois (un isolat par partie)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 10,8 % | 8,0 % | 22 → 4 | −2,2 pt | [−3,7 pt ; −1,1 pt] | 26 / 4 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 29,8 % | 27,1 % | — | −1,2 pt | [−4,2 pt ; +1,2 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Faim moyenne | 6,5 % | 6,1 % | 28 → 29 | +0,7 pt | [−0,5 pt ; +2,1 pt] | 11 / 19 / 0 sur 30 | non concluant |
| Faim max | 93,5 % | 95,4 % | — | +1,7 pt | [+0,4 pt ; +3,3 pt] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri moyen | 2,2 % | 2,6 % | 18 → 19 | +0,4 pt | [+0,2 pt ; +1,0 pt] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 41,5 % | 42,9 % | — | +2,7 pt | [−4,6 pt ; +12,7 pt] | 12 / 18 / 0 sur 30 | non concluant |
| Gini moyen | 0,39 | 0,35 | 3 → 3 | −0,03 | [−0,05 ; +0,03] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,42 | 0,43 | — | −0,04 | [−0,14 ; +0,10] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,054 % | 0,071 % | 0 → 0 | +0,019 pt | [+0,011 pt ; +0,031 pt] | — / — / 0 | **B plus haut** |
| |Inflation| max / j | 41,4 % | 36,6 % | — | +3,7 pt | [−8,0 pt ; +14,4 pt] | 14 / 16 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 114,5 % | 136,1 % | — | +12,5 pt | [+5,0 pt ; +43,1 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 30 | 27,5 | 30 → 30 | −1,5 | [−6,5 ; +2] | 18 / 11 / 1 sur 30 | non concluant |
| … dont après la chauffe | 29 | 24,5 | — | −2 | [−6,5 ; +0,5] | 18 / 10 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 1519,5 | 1524,5 | — | +25 | [−15 ; +75] | 11 / 18 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 685 | 509 | — | −204,5 | [−259 ; −117] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |
| Santé moyenne | 0,17 | 0,18 | — | +0,01 | [−0,02 ; +0,04] | 18 / 12 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 41,1 | 27,1 | — | −14,5 | [−18,9 ; −11,1] | — / — / 0 | **B plus bas** |
| Naissances / an, en % du parc moyen | 202,4 | 147,3 | — | −60,6 | [−63,6 ; −26,7] | — / — / 0 | **B plus bas** |
| Morts / an, en % du parc moyen | 214,5 | 165,4 | — | −46,4 | [−57,7 ; −19,8] | — / — / 0 | **B plus bas** |
| Parc moyen d’entreprises (après la chauffe) | 20,5 | 17,8 | — | −3,0 | [−4,1 ; −1,4] | — / — / 0 | **B plus bas** |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 6 | 7 | — | +0,5 | [0 ; +1,5] | — / — / 8 | non concluant |
| Fermetures : faillite (salaires impayables) | 167,5 | 116 | — | −52 | [−67,5 ; −38] | — / — / 0 | **B plus bas** |
| Fermetures : demande perdue | 0 | 0 | — | 0 | [−1 ; 0] | — / — / 14 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 4 | 1 | — | −2,5 | [−4 ; −1] | — / — / 7 | **B plus bas** |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 42,8 | 30,9 | — | −12,4 | [−17,4 ; −10,1] | — / — / 0 | **B plus bas** |
| Entonnoir : projets envisagés | 18346,5 | 16947 | — | −1589 | [−2227,5 ; −481,5] | — / — / 0 | **B plus bas** |
| Entonnoir : créations | 169 | 111,5 | — | −59,5 | [−77,5 ; −45,5] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, une création déjà ce jour | 1164 | 693,5 | — | −521 | [−675,5 ; −380] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, délai entre deux créations du type | 7905,5 | 5542,5 | — | −2411,5 | [−3384,5 ; −1845] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, concurrence | 1705,5 | 1534,5 | — | −232,5 | [−346,5 ; +34,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1377 | 1278 | — | +8 | [−270 ; +311,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 269 | 812 | — | +486,5 | [+217,5 ; +697] | — / — / 1 | **B plus haut** |
| Entonnoir : refus, viabilité | 4683,5 | 5641,5 | — | +1227,5 | [+563,5 ; +2016,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 989,5 | 1021 | — | −84,5 | [−167 ; +376] | — / — / 0 | non concluant |
| Types d’entreprise actifs en fin | 16 | 13 | — | −2,5 | [−3,5 ; −1] | 5 / 24 / 1 sur 30 | **B plus bas (moins bien)** |
| Machines en fin | 0,4 | 0,2 | — | −0,1 | [−0,3 ; −0,02] | 8 / 22 / 0 sur 30 | **B plus bas (moins bien)** |
| Équipes utilisées à moins de 15 % (fin) | 1 | 1 | — | 0 | [−1 ; 0] | 12 / 5 / 13 sur 30 | non concluant |
| Bonheur moyen | 0,81 | 0,81 | — | +0,0002 | [−0,01 ; +0,01] | 15 / 15 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 481,2 | 512,9 | — | +28,9 | [−47,4 ; +76,8] | 14 / 16 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 1 / 4 / 25 sur 30 | non concluant |
| Trésor de l’État le plus bas | 81 301 $ | 90 804 $ | — | +8 074 $ | [−16 281 $ ; +19 848 $] | 16 / 14 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 5 / 25 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 23 | non concluant |
| Créances radiées | 10 450 $ | 18 445 $ | — | +8 352 $ | [+5 471 $ ; +12 140 $] | — / — / 0 | **B plus haut** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 3 → 6 | 0 | [0 ; 0] | 3 / 5 / 22 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 2 / 6 / 22 sur 30 | non concluant |
| Faim répandue | 6 | 5 | 29 → 30 | −1 | [−2 ; +1] | 16 / 13 / 1 sur 30 | non concluant |
| … jours-alerte | 138,5 | 130,5 | — | +7 | [−25,5 ; +32] | 14 / 16 / 0 sur 30 | non concluant |
| Sans-abri nombreux | 12,5 | 11 | 30 → 30 | −2 | [−4 ; +2] | 17 / 11 / 2 sur 30 | non concluant |
| … jours-alerte | 114 | 159 | — | +55 | [−11,5 ; +103] | 10 / 20 / 0 sur 30 | non concluant |
| Inflation quotidienne | 8 | 7 | 30 → 30 | −1 | [−3 ; +1] | 17 / 11 / 2 sur 30 | non concluant |
| … jours-alerte | 8 | 7 | — | −1 | [−3 ; +1] | 17 / 11 / 2 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 2 | 19 → 30 | +1 | [+0,5 ; +1,5] | 5 / 20 / 5 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 13,5 | 37,5 | — | +20,5 | [−9 ; +38,5] | 10 / 20 / 0 sur 30 | non concluant |
| Santé de la population effondrée | 1 | 1 | 30 → 30 | 0 | [0 ; 0] | 2 / 0 / 28 sur 30 | non concluant |
| … jours-alerte | 1232,5 | 1207 | — | −38,5 | [−87,5 ; −12,0] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 10,2 % | 7,0 % | 16 → 5 | −3,7 pt | [−4,5 pt ; −1,5 pt] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 25,0 % | 19,0 % | — | −5,8 pt | [−7,9 pt ; −2,1 pt] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Faim moyenne | 0,3 % | 0,1 % | 0 → 0 | −0,2 pt | [−0,4 pt ; −0,04 pt] | 20 / 9 / 1 sur 30 | **B plus bas (mieux)** |
| Faim max | 59,2 % | 45,0 % | — | −19,8 pt | [−36,3 pt ; −1,3 pt] | 20 / 9 / 1 sur 30 | **B plus bas (mieux)** |
| Sans-abri moyen | 0,5 % | 0,2 % | 0 → 0 | −0,2 pt | [−0,5 pt ; −0,1 pt] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Sans-abri max | 26,3 % | 18,3 % | — | −5,8 pt | [−16,9 pt ; +2,1 pt] | 20 / 10 / 0 sur 30 | non concluant |
| Gini moyen | 0,26 | 0,20 | 0 → 13 | −0,05 | [−0,07 ; −0,04] | — / — / 0 | **B plus bas** |
| Gini en fin de partie | 0,26 | 0,15 | — | −0,09 | [−0,12 ; −0,05] | — / — / 0 | **B plus bas** |
| Inflation moyenne / j | 0,026 % | 0,040 % | 0 → 0 | +0,008 pt | [−0,003 pt ; +0,027 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 39,9 % | 47,8 % | — | −2,0 pt | [−5,9 pt ; +15,9 pt] | 16 / 14 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 107,0 % | 141,0 % | — | +34,0 pt | [+13,6 pt ; +44,5 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 11 | 10 | 30 → 30 | −1 | [−1,5 ; +3] | 16 / 13 / 1 sur 30 | non concluant |
| … dont après la chauffe | 9 | 8 | — | −0,5 | [−2,5 ; +1] | 15 / 10 / 5 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 70 | 78,5 | — | +3,5 | [−48 ; +37,5] | 15 / 15 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 158 | 139,5 | — | −16 | [−28 ; +3,5] | 19 / 10 / 1 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,0001 | [+0,00001 ; +0,0001] | 21 / 9 / 0 sur 30 | **B plus haut (mieux)** |
| Naissances d’entreprises / an | 4,1 | 3,4 | — | −0,6 | [−1,5 ; 0,0] | — / — / 2 | non concluant |
| Naissances / an, en % du parc moyen | 18,5 | 15,1 | — | −2,5 | [−6,2 ; +0,2] | — / — / 0 | non concluant |
| Morts / an, en % du parc moyen | 27,2 | 25,9 | — | −1,2 | [−3,9 ; +1,3] | — / — / 0 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 22,4 | 22,3 | — | −0,2 | [−0,7 ; +0,2] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 28 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 28 | non concluant |
| Fermetures : prix aberrant | 9 | 10,5 | — | +1 | [−0,5 ; +3] | — / — / 3 | non concluant |
| Fermetures : faillite (salaires impayables) | 15 | 12,5 | — | −3 | [−5 ; 0] | — / — / 2 | non concluant |
| Fermetures : demande perdue | 0 | 0 | — | 0 | [0 ; 0] | — / — / 15 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | −1 | [−1 ; 0] | — / — / 6 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 6,1 | 5,8 | — | −0,2 | [−0,9 ; +0,2] | — / — / 2 | non concluant |
| Entonnoir : projets envisagés | 8844,5 | 8102,5 | — | −530 | [−1049,5 ; −159,5] | — / — / 0 | **B plus bas** |
| Entonnoir : créations | 17 | 14 | — | −2,5 | [−6 ; 0] | — / — / 2 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 66 | 48 | — | −18 | [−37,5 ; +1] | — / — / 1 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 685,5 | 566,5 | — | −91,5 | [−352 ; +29] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 1851 | 1521,5 | — | −303,5 | [−491,5 ; −166] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, demande insuffisante | 1955 | 1779 | — | −30 | [−307 ; +169,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 318,5 | 418,5 | — | +105,5 | [−9,5 ; +185] | — / — / 0 | non concluant |
| Entonnoir : refus, viabilité | 3922 | 3812 | — | +119,5 | [−422,5 ; +349,5] | — / — / 0 | non concluant |
| Entonnoir : refus, aucun fondateur assez riche | 0 | 0 | — | 0 | [0 ; 0] | — / — / 19 | non concluant |
| Types d’entreprise actifs en fin | 20 | 20 | — | 0 | [−2 ; +1] | 12 / 13 / 5 sur 30 | non concluant |
| Machines en fin | 1,2 | 2,6 | — | +1,2 | [−0,2 ; +2,2] | 19 / 11 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 3 | — | 0 | [−0,5 ; +0,5] | 10 / 10 / 10 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | +0,01 | [+0,004 ; +0,01] | 25 / 5 / 0 sur 30 | **B plus haut (mieux)** |
| Hôpital public : attente moyenne (j) | 0,3 | 0,3 | — | −0,01 | [−0,01 ; +0,0004] | 20 / 10 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| Trésor de l’État le plus bas | 42 654 $ | 52 260 $ | — | +9 029 $ | [−10 585 $ ; +29 683 $] | 17 / 13 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 1 / 28 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 27 | non concluant |
| Créances radiées | 523 $ | 0 $ | — | −154 $ | [−2 895 $ ; 0 $] | — / — / 10 | non concluant |
| Filet : Anti-famine / 50 j | 4,00 | 0,18 | 20 → 10 | −2,50 | [−7,50 ; −0,21] | 20 / 8 / 2 sur 30 | **B plus bas (mieux)** |
| Filet : Renflouement d’entreprise / 50 j | 12,71 | 13,05 | 30 → 30 | +1,57 | [−0,59 ; +3,07] | 12 / 18 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 16,38 | 2,11 | 22 → 17 | −4,48 | [−23,36 ; +1,41] | 18 / 12 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 2 / 1 / 27 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 3 → 2 | 0 | [0 ; 0] | 3 / 2 / 25 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 2 / 25 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 23 → 17 | 0 | [−0,5 ; 0] | 10 / 6 / 14 sur 30 | non concluant |
| … jours-alerte | 9 | 1 | — | −6,5 | [−11 ; −0,5] | 20 / 7 / 3 sur 30 | **B plus bas (mieux)** |
| Sans-abri nombreux | 2 | 1 | 28 → 19 | −1 | [−2 ; −0,5] | 20 / 7 / 3 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 22 | 8 | — | −12,5 | [−18,5 ; −2] | 20 / 9 / 1 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 6 | 7 | 30 → 30 | 0 | [−1 ; +1] | 14 / 12 / 4 sur 30 | non concluant |
| … jours-alerte | 6 | 7 | — | 0 | [−1,5 ; +1] | 14 / 12 / 4 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 2 | 18 → 30 | +1,5 | [+1 ; +2,5] | 3 / 24 / 3 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 8 | 50,5 | — | +35,5 | [+18,5 ; +50] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 5 → 3 | 0 | [0 ; 0] | 4 / 2 / 24 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 5 / 2 / 23 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Chômage moyen : −2,2 pt [−3,7 pt ; −1,1 pt], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Sans filets — Faim max : +1,7 pt [+0,4 pt ; +3,3 pt], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Sans filets — Sans-abri moyen : +0,4 pt [+0,2 pt ; +1,0 pt], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Sans filets — Inflation moyenne / j : +0,019 pt [+0,011 pt ; +0,031 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — |Inflation sur 100 j| max : +12,5 pt [+5,0 pt ; +43,1 pt], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Sans filets — Alertes ouvertes (toutes) : −204,5 [−259 ; −117], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Sans filets — Naissances d’entreprises / an : −14,5 [−18,9 ; −11,1] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Naissances / an, en % du parc moyen : −60,6 [−63,6 ; −26,7] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts / an, en % du parc moyen : −46,4 [−57,7 ; −19,8] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Parc moyen d’entreprises (après la chauffe) : −3,0 [−4,1 ; −1,4] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : faillite (salaires impayables) : −52 [−67,5 ; −38] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : sans employé (départs, postes non pourvus) : −2,5 [−4 ; −1] (0 graines mieux, 0 moins bien, 7 égales)
- Sans filets — Morts d’entreprises / an : −12,4 [−17,4 ; −10,1] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : projets envisagés : −1589 [−2227,5 ; −481,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : créations : −59,5 [−77,5 ; −45,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, une création déjà ce jour : −521 [−675,5 ; −380] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, délai entre deux créations du type : −2411,5 [−3384,5 ; −1845] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +486,5 [+217,5 ; +697] (0 graines mieux, 0 moins bien, 1 égales)
- Sans filets — Entonnoir : refus, viabilité : +1227,5 [+563,5 ; +2016,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Types d’entreprise actifs en fin : −2,5 [−3,5 ; −1], B moins bien (5 graines mieux, 24 moins bien, 1 égales)
- Sans filets — Machines en fin : −0,1 [−0,3 ; −0,02], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Sans filets — Créances radiées : +8 352 $ [+5 471 $ ; +12 140 $] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Inflation sur 100 jours : +1 [+0,5 ; +1,5], B moins bien (5 graines mieux, 20 moins bien, 5 égales)
- Sans filets — Santé de la population effondrée : jours-alerte : −38,5 [−87,5 ; −12,0], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Chômage moyen : −3,7 pt [−4,5 pt ; −1,5 pt], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Avec filets — Chômage max : −5,8 pt [−7,9 pt ; −2,1 pt], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets — Faim moyenne : −0,2 pt [−0,4 pt ; −0,04 pt], B mieux (20 graines mieux, 9 moins bien, 1 égales)
- Avec filets — Faim max : −19,8 pt [−36,3 pt ; −1,3 pt], B mieux (20 graines mieux, 9 moins bien, 1 égales)
- Avec filets — Sans-abri moyen : −0,2 pt [−0,5 pt ; −0,1 pt], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Gini moyen : −0,05 [−0,07 ; −0,04] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Gini en fin de partie : −0,09 [−0,12 ; −0,05] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — |Inflation sur 100 j| max : +34,0 pt [+13,6 pt ; +44,5 pt], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets — Santé moyenne : +0,0001 [+0,00001 ; +0,0001], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Entonnoir : projets envisagés : −530 [−1049,5 ; −159,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, concurrence : −303,5 [−491,5 ; −166] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Bonheur moyen : +0,01 [+0,004 ; +0,01], B mieux (25 graines mieux, 5 moins bien, 0 égales)
- Avec filets — Filet : Anti-famine / 50 j : −2,50 [−7,50 ; −0,21], B mieux (20 graines mieux, 8 moins bien, 2 égales)
- Avec filets — Faim répandue : jours-alerte : −6,5 [−11 ; −0,5], B mieux (20 graines mieux, 7 moins bien, 3 égales)
- Avec filets — Sans-abri nombreux : −1 [−2 ; −0,5], B mieux (20 graines mieux, 7 moins bien, 3 égales)
- Avec filets — Sans-abri nombreux : jours-alerte : −12,5 [−18,5 ; −2], B mieux (20 graines mieux, 9 moins bien, 1 égales)
- Avec filets — Inflation sur 100 jours : +1,5 [+1 ; +2,5], B moins bien (3 graines mieux, 24 moins bien, 3 égales)
- Avec filets — Inflation sur 100 jours : jours-alerte : +35,5 [+18,5 ; +50], B moins bien (5 graines mieux, 25 moins bien, 0 égales)

