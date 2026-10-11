# Comparaison appariée ÉcoNodes

- Date : 2026-10-11 14:37
- A : `complet-sans-institutions.json`
- A — Modules coupés : Dividendes : test de solvabilité, Hôpital et école publics : enveloppe et file d’attente, Assurance-emploi indexée et aide sociale, Caisse : règles prudentielles, Faillite ordonnée
- B : `complet-i1.json`
- B — Modules coupés : Hôpital et école publics : enveloppe et file d’attente, Assurance-emploi indexée et aide sociale, Caisse : règles prudentielles, Faillite ordonnée
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 28,5 % | 8,2 % | 23 → 3 | −20,8 pt | [−46,7 pt ; −3,4 pt] | 24 / 6 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 74,4 % | 26,5 % | — | −49,8 pt | [−62,7 pt ; −18,3 pt] | 23 / 6 / 1 sur 30 | **B plus bas (mieux)** |
| Faim moyenne | 16,9 % | 7,0 % | 26 → 28 | −9,1 pt | [−52,0 pt ; −3,5 pt] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Faim max | 96,5 % | 95,2 % | — | −2,1 pt | [−4,8 pt ; +4,2 pt] | 16 / 13 / 1 sur 30 | non concluant |
| Sans-abri moyen | 16,8 % | 1,7 % | 24 → 12 | −15,3 pt | [−46,8 pt ; −4,3 pt] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Sans-abri max | 69,2 % | 42,1 % | — | −27,1 pt | [−40,2 pt ; −18,7 pt] | 26 / 4 / 0 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,47 | 0,34 | 16 → 3 | −0,10 | [−0,25 ; −0,04] | — / — / 0 | **B plus bas** |
| Gini en fin de partie | 0,67 | 0,48 | — | −0,22 | [−0,38 ; −0,003] | — / — / 0 | **B plus bas** |
| Inflation moyenne / j | 0,027 % | 0,060 % | 0 → 0 | +0,042 pt | [+0,026 pt ; +0,054 pt] | — / — / 0 | **B plus haut** |
| |Inflation| max / j | 9,6 % | 37,5 % | — | +18,5 pt | [+17,1 pt ; +44,1 pt] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| |Inflation sur 100 j| max | 126,5 % | 138,8 % | — | +7,9 pt | [−3,4 pt ; +20,2 pt] | 11 / 19 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 19 | 26 | 30 → 30 | +6,5 | [+4 ; +10,5] | 5 / 24 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 15,5 | 24 | — | +8,5 | [+6 ; +12] | 4 / 26 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 3030,5 | 1611 | — | −1496 | [−2565 ; −459,5] | 25 / 5 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 671 | 600 | — | −102,5 | [−198,5 ; −2,5] | 20 / 10 / 0 sur 30 | **B plus bas (mieux)** |
| Santé moyenne | 0,11 | 0,11 | — | +0,01 | [−0,004 ; +0,03] | 18 / 12 / 0 sur 30 | non concluant |
| Bonheur moyen | 0,64 | 0,80 | — | +0,17 | [+0,05 ; +0,41] | 23 / 7 / 0 sur 30 | **B plus haut (mieux)** |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 521,5 | 0 | — | −521,5 | [−955,5 ; 0] | 19 / 3 / 8 sur 30 | non concluant |
| Trésor de l’État le plus bas | 2 012 $ | 76 796 $ | — | +68 072 $ | [+20 562 $ ; +75 334 $] | 22 / 8 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 1122,5 | 0 | — | −1001 | [−1207 ; −94] | 20 / 4 / 6 sur 30 | **B plus bas (mieux)** |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 46 144 $ | 21 094 $ | — | −22 614 $ | [−29 436 $ ; −11 108 $] | — / — / 0 | **B plus bas** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 1 | 0 | 22 → 3 | −1 | [−1 ; −1] | 21 / 2 / 7 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 532 | 0 | — | −532 | [−908,5 ; −33,5] | 21 / 3 / 6 sur 30 | **B plus bas (mieux)** |
| Faim répandue | 4 | 5 | 30 → 30 | +1 | [−1 ; +2] | 13 / 16 / 1 sur 30 | non concluant |
| … jours-alerte | 453,5 | 143,5 | — | −275,5 | [−774,5 ; −109] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Sans-abri nombreux | 9 | 9,5 | 30 → 30 | +1,5 | [−2 ; +3,5] | 12 / 17 / 1 sur 30 | non concluant |
| … jours-alerte | 680,5 | 104,5 | — | −633 | [−918,5 ; −259] | 26 / 4 / 0 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 1 | 7 | 18 → 30 | +6 | [+5 ; +8,5] | 2 / 27 / 1 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 1 | 7 | — | +6 | [+4,5 ; +9] | 2 / 26 / 2 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 26 → 29 | +1 | [0 ; +1,5] | 2 / 19 / 9 sur 30 | non concluant |
| … jours-alerte | 17,5 | 44,5 | — | +30 | [+13,5 ; +38] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 1 | 1 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 1332 | 1305,5 | — | −20 | [−38,5 ; −8] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 8,4 % | 0 → 6 | +3,4 pt | [+2,4 pt ; +5,4 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 14,8 % | 22,5 % | — | +6,9 pt | [+2,7 pt ; +10,8 pt] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 4 | +0,04 pt | [0,0 pt ; +0,3 pt] | 4 / 16 / 10 sur 30 | non concluant |
| Faim max | 36,9 % | 13,5 % | — | −1,5 pt | [−15,6 pt ; +11,5 pt] | 16 / 12 / 2 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 2 → 1 | 0,0 pt | [−0,04 pt ; +0,01 pt] | 13 / 13 / 4 sur 30 | non concluant |
| Sans-abri max | 35,6 % | 26,0 % | — | −15,0 pt | [−18,3 pt ; −6,5 pt] | 23 / 6 / 1 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,17 | 0,16 | 22 → 23 | −0,02 | [−0,04 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,19 | 0,15 | — | −0,02 | [−0,05 ; +0,01] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,045 % | 0,038 % | 0 → 0 | +0,002 pt | [−0,014 pt ; +0,024 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 15,3 % | 33,1 % | — | +13,0 pt | [−13,9 pt ; +22,3 pt] | 12 / 18 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 113,2 % | 136,4 % | — | +24,1 pt | [+2,6 pt ; +35,4 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 7 | 10,5 | 30 → 30 | +3 | [+1 ; +6,5] | 8 / 21 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 3,5 | 8,5 | — | +4,5 | [+1 ; +7,5] | 6 / 21 / 3 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 48 | 77 | — | +17 | [−24,5 ; +75,5] | 12 / 17 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 119,5 | 181 | — | +54,5 | [+27 ; +89] | 4 / 26 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,87 | — | −0,002 | [−0,01 ; −0,0004] | 9 / 21 / 0 sur 30 | **B plus bas (moins bien)** |
| Bonheur moyen | 0,98 | 0,97 | — | −0,0004 | [−0,001 ; +0,001] | 13 / 17 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 8 / 22 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 295 $ | 21 277 $ | — | −124 458 $ | [−131 590 $ ; −70 081 $] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 4 / 0 / 26 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 24 | non concluant |
| Créances radiées | 9 049 $ | 0 $ | — | −8 234 $ | [−11 133 $ ; −3 509 $] | — / — / 0 | **B plus bas** |
| Filet : Anti-famine / 50 j | 0,00 | 0,02 | 5 → 12 | +0,02 | [0,00 ; +3,23] | 4 / 15 / 11 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 26,66 | 32,55 | 30 → 30 | +4,89 | [+1,27 ; +8,32] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 7 → 7 | 0,00 | [−0,04 ; 0,00] | 10 / 6 / 14 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 5 → 0 | 0,00 | [0,00 ; 0,00] | 5 / 1 / 24 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,27 | 10,36 | — | +1,71 | [+0,73 ; +2,61] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 0 → 3 | 0 | [0 ; 0] | 0 / 3 / 27 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 3 / 27 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 24 → 16 | 0 | [−1 ; 0] | 14 / 6 / 10 sur 30 | non concluant |
| … jours-alerte | 9 | 2,5 | — | −2,5 | [−7,5 ; 0] | 17 / 8 / 5 sur 30 | non concluant |
| Sans-abri nombreux | 2 | 1 | 30 → 19 | −1 | [−1 ; 0] | 19 / 9 / 2 sur 30 | non concluant |
| … jours-alerte | 29 | 14 | — | −13 | [−21,5 ; −8,5] | 23 / 6 / 1 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 2 | 6 | 27 → 30 | +3 | [+2 ; +5] | 3 / 27 / 0 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 2 | 6 | — | +3 | [+2 ; +5] | 3 / 27 / 0 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 20 → 28 | +1 | [+1 ; +2] | 3 / 22 / 5 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 8,5 | 33 | — | +23 | [+19 ; +40] | 3 / 26 / 1 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 7 → 9 | 0 | [0 ; 0] | 5 / 7 / 18 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 7 / 16 sur 30 | non concluant |

## Avec filets, sauf « Anti-famine »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 8,2 % | 0 → 7 | +4,2 pt | [+2,9 pt ; +5,5 pt] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 14,6 % | 23,3 % | — | +9,2 pt | [+4,6 pt ; +13,5 pt] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 0,1 % | 0 → 6 | +0,1 pt | [0,0 pt ; +0,3 pt] | 4 / 17 / 9 sur 30 | non concluant |
| Faim max | 35,4 % | 22,5 % | — | −0,8 pt | [−20,4 pt ; +17,1 pt] | 15 / 13 / 2 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 4 | +0,005 pt | [0,0 pt ; +0,2 pt] | 8 / 17 / 5 sur 30 | non concluant |
| Sans-abri max | 39,2 % | 28,3 % | — | −10,4 pt | [−17,3 pt ; −4,2 pt] | 21 / 8 / 1 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,17 | 0,17 | 25 → 22 | +0,002 | [−0,02 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,19 | 0,15 | — | −0,03 | [−0,07 ; +0,003] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,019 % | 0,041 % | 0 → 0 | +0,023 pt | [−0,012 pt ; +0,029 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 44,1 % | 33,6 % | — | −1,0 pt | [−19,9 pt ; +16,8 pt] | 15 / 15 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 113,3 % | 137,3 % | — | +17,8 pt | [+5,7 pt ; +36,3 pt] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 6,5 | 12,5 | 30 → 30 | +4,5 | [+1,5 ; +9,5] | 5 / 24 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 3,5 | 10 | — | +6,5 | [+2 ; +10] | 3 / 24 / 3 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 60 | 91,5 | — | +35 | [+3,5 ; +99,5] | 10 / 20 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes ouvertes (toutes) | 124,5 | 181 | — | +58,5 | [+13 ; +121] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,87 | — | −0,01 | [−0,04 ; −0,001] | 8 / 22 / 0 sur 30 | **B plus bas (moins bien)** |
| Bonheur moyen | 0,98 | 0,97 | — | −0,001 | [−0,02 ; −0,00002] | 10 / 20 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 9 / 21 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 040 $ | 19 017 $ | — | −126 493 $ | [−133 587 $ ; −80 817 $] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 4 318 $ | 0 $ | — | −2 957 $ | [−5 889 $ ; −1 465 $] | — / — / 0 | **B plus bas** |
| Filet : Renflouement d’entreprise / 50 j | 26,77 | 32,20 | 30 → 30 | +5,59 | [+3,91 ; +8,80] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 5 → 10 | 0,00 | [0,00 ; +0,13] | 6 / 10 / 14 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,48 | 10,11 | — | +1,50 | [+0,43 ; +2,52] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 0 → 7 | 0 | [0 ; 0] | 0 / 7 / 23 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 7 / 23 sur 30 | non concluant |
| Faim répandue | 1,5 | 1 | 24 → 16 | −1 | [−1 ; 0] | 17 / 4 / 9 sur 30 | non concluant |
| … jours-alerte | 14 | 1 | — | −2 | [−10 ; +1] | 16 / 10 / 4 sur 30 | non concluant |
| Sans-abri nombreux | 2 | 2 | 30 → 21 | −0,5 | [−1 ; +1] | 15 / 11 / 4 sur 30 | non concluant |
| … jours-alerte | 29,5 | 19 | — | −15,5 | [−19 ; −7] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 2 | 6 | 27 → 30 | +3 | [+2 ; +6] | 2 / 25 / 3 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 2 | 6 | — | +3 | [+2 ; +6] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 20 → 28 | +1 | [+1 ; +1,5] | 3 / 23 / 4 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 11,5 | 33 | — | +28 | [+17 ; +40] | 3 / 26 / 1 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 3 → 12 | 0 | [0 ; +0,5] | 1 / 10 / 19 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; +16] | 3 / 10 / 17 sur 30 | non concluant |

## Avec filets, sauf « Renflouement d’entreprise »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 6,6 % | 7,7 % | 3 → 0 | +0,9 pt | [+0,3 pt ; +1,5 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 22,3 % | 24,8 % | — | +2,9 pt | [0,0 pt ; +4,0 pt] | 10 / 20 / 0 sur 30 | non concluant |
| Faim moyenne | 3,1 % | 3,9 % | 21 → 24 | +0,4 pt | [−1,2 pt ; +2,0 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Faim max | 93,5 % | 94,4 % | — | +1,0 pt | [−0,2 pt ; +11,3 pt] | 10 / 18 / 2 sur 30 | non concluant |
| Sans-abri moyen | 1,3 % | 0,6 % | 6 → 0 | −0,6 pt | [−0,8 pt ; −0,1 pt] | 24 / 6 / 0 sur 30 | **B plus bas (mieux)** |
| Sans-abri max | 41,5 % | 35,2 % | — | −5,4 pt | [−13,1 pt ; −1,0 pt] | 23 / 6 / 1 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,39 | 0,35 | 6 → 1 | −0,02 | [−0,06 ; +0,003] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,52 | 0,42 | — | −0,03 | [−0,11 ; +0,03] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,055 % | 0,056 % | 0 → 0 | +0,005 pt | [−0,003 pt ; +0,015 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 4,5 % | 35,7 % | — | +30,3 pt | [+23,0 pt ; +36,1 pt] | 2 / 28 / 0 sur 30 | **B plus haut (moins bien)** |
| |Inflation sur 100 j| max | 115,8 % | 135,0 % | — | +15,1 pt | [+1,5 pt ; +35,9 pt] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 16 | 18 | 30 → 30 | +5,5 | [−1 ; +10,5] | 12 / 18 / 0 sur 30 | non concluant |
| … dont après la chauffe | 12,5 | 15,5 | — | +7,5 | [+1,5 ; +11,5] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 1531 | 1491 | — | −32,5 | [−95,5 ; +9,5] | 19 / 11 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 352,5 | 523 | — | +132,5 | [+53 ; +255,5] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,12 | 0,11 | — | +0,001 | [−0,01 ; +0,01] | 15 / 15 / 0 sur 30 | non concluant |
| Bonheur moyen | 0,81 | 0,81 | — | +0,004 | [−0,002 ; +0,01] | 18 / 12 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 0 / 28 sur 30 | non concluant |
| Trésor de l’État le plus bas | 136 248 $ | 83 716 $ | — | −55 705 $ | [−63 989 $ ; −39 808 $] | 3 / 27 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 48 | 0 | — | 0 | [−373,5 ; 0] | 12 / 9 / 9 sur 30 | non concluant |
| Prêts refusés | 141 | 0 | — | −34,5 | [−148 ; 0] | — / — / 4 | non concluant |
| Créances radiées | 29 831 $ | 24 976 $ | — | −5 058 $ | [−9 283 $ ; +376 $] | — / — / 0 | non concluant |
| Filet : Anti-famine / 50 j | 84,13 | 118,91 | 27 → 30 | +22,30 | [−33,50 ; +82,34] | 12 / 18 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 22,66 | 8,59 | 30 → 30 | −10,82 | [−14,68 ; −5,23] | 26 / 4 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 5,04 | 0,00 | 20 → 14 | −1,23 | [−5,29 ; 0,00] | 18 / 8 / 4 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 2 → 0 | 0 | [0 ; 0] | 2 / 0 / 28 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 2 / 0 / 28 sur 30 | non concluant |
| Faim répandue | 6 | 5 | 30 → 30 | −0,5 | [−1 ; +0,5] | 15 / 10 / 5 sur 30 | non concluant |
| … jours-alerte | 129,5 | 112,5 | — | −1,5 | [−49,5 ; +23] | 15 / 15 / 0 sur 30 | non concluant |
| Sans-abri nombreux | 6 | 3 | 30 → 29 | −1 | [−3,5 ; −0,5] | 20 / 9 / 1 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 67 | 26,5 | — | −26 | [−63 ; −11,5] | 24 / 6 / 0 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 0 | 7 | 10 → 28 | +6 | [+4,5 ; +8] | 1 / 28 / 1 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 0 | 7 | — | +6 | [+4,5 ; +8] | 1 / 28 / 1 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 26 → 29 | +1 | [0 ; +1,5] | 1 / 18 / 11 sur 30 | non concluant |
| … jours-alerte | 12 | 37,5 | — | +32,5 | [+10,5 ; +44,5] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 1 | 1 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 1332,5 | 1304,5 | — | −16 | [−49 ; −11] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |

## Avec filets, sauf « Plancher de logement »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 7,5 % | 0 → 7 | +3,1 pt | [+2,2 pt ; +4,8 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 15,8 % | 23,3 % | — | +7,5 pt | [+2,3 pt ; +11,5 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 0,1 % | 1 → 3 | +0,01 pt | [0,0 pt ; +0,3 pt] | 7 / 15 / 8 sur 30 | non concluant |
| Faim max | 44,2 % | 42,7 % | — | −6,9 pt | [−25,6 pt ; +13,3 pt] | 16 / 13 / 1 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 0 → 2 | 0,0 pt | [−0,002 pt ; +0,02 pt] | 13 / 12 / 5 sur 30 | non concluant |
| Sans-abri max | 41,9 % | 23,3 % | — | −17,5 pt | [−27,5 pt ; −8,5 pt] | 24 / 5 / 1 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,17 | 0,16 | 23 → 23 | −0,02 | [−0,03 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,17 | 0,14 | — | −0,02 | [−0,06 ; +0,02] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,022 % | 0,036 % | 0 → 0 | +0,007 pt | [−0,012 pt ; +0,030 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 45,0 % | 33,1 % | — | −2,6 pt | [−14,9 pt ; +11,2 pt] | 16 / 14 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 116,7 % | 137,7 % | — | +16,3 pt | [+5,1 pt ; +30,4 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 7 | 13 | 30 → 30 | +4 | [+1,5 ; +7] | 7 / 20 / 3 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 4 | 10,5 | — | +6 | [+2 ; +8] | 6 / 23 / 1 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 74,5 | 107,5 | — | +24 | [−8 ; +141,5] | 12 / 18 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 117,5 | 185,5 | — | +75,5 | [+29 ; +94] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,87 | — | −0,002 | [−0,01 ; −0,0003] | 9 / 21 / 0 sur 30 | **B plus bas (moins bien)** |
| Bonheur moyen | 0,98 | 0,97 | — | −0,0004 | [−0,003 ; +0,001] | 14 / 16 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 7 / 23 sur 30 | non concluant |
| Trésor de l’État le plus bas | 147 036 $ | 51 190 $ | — | −97 967 $ | [−119 606 $ ; −73 187 $] | 1 / 29 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 1 / 28 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 8 338 $ | 0 $ | — | −6 103 $ | [−8 350 $ ; −3 349 $] | — / — / 0 | **B plus bas** |
| Filet : Anti-famine / 50 j | 0,00 | 0,59 | 7 → 14 | 0,00 | [0,00 ; +3,82] | 8 / 13 / 9 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 27,82 | 30,75 | 30 → 30 | +4,18 | [+1,25 ; +7,12] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 0 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,68 | 9,71 | — | +0,66 | [−0,07 ; +1,84] | 10 / 20 / 0 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 0 → 4 | 0 | [0 ; 0] | 0 / 4 / 26 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 4 / 26 sur 30 | non concluant |
| Faim répandue | 2 | 1 | 28 → 20 | −1 | [−1 ; 0] | 18 / 8 / 4 sur 30 | non concluant |
| … jours-alerte | 11 | 4,5 | — | −5,5 | [−10 ; −0,5] | 20 / 8 / 2 sur 30 | **B plus bas (mieux)** |
| Sans-abri nombreux | 2 | 1,5 | 30 → 19 | −1 | [−1 ; 0] | 19 / 9 / 2 sur 30 | non concluant |
| … jours-alerte | 34,5 | 11 | — | −21,5 | [−29 ; −11,5] | 25 / 4 / 1 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 3 | 6,5 | 28 → 30 | +3,5 | [+2 ; +5] | 3 / 24 / 3 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 3 | 6,5 | — | +3,5 | [+1,5 ; +5] | 5 / 24 / 1 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 23 → 29 | +1 | [0 ; +1] | 2 / 19 / 9 sur 30 | non concluant |
| … jours-alerte | 12,5 | 40 | — | +28 | [+19 ; +42,5] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 4 → 10 | 0 | [0 ; 0] | 3 / 9 / 18 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 4 / 9 / 17 sur 30 | non concluant |

## Avec filets, sauf « Plafond de dérive des prix et salaires »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 8,4 % | 0 → 6 | +3,4 pt | [+2,4 pt ; +5,4 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 14,8 % | 22,5 % | — | +6,9 pt | [+2,7 pt ; +10,8 pt] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 4 | +0,04 pt | [0,0 pt ; +0,3 pt] | 4 / 16 / 10 sur 30 | non concluant |
| Faim max | 36,9 % | 13,5 % | — | −1,5 pt | [−15,6 pt ; +11,5 pt] | 16 / 12 / 2 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 2 → 1 | 0,0 pt | [−0,04 pt ; +0,01 pt] | 13 / 13 / 4 sur 30 | non concluant |
| Sans-abri max | 35,6 % | 26,0 % | — | −15,0 pt | [−18,3 pt ; −6,5 pt] | 23 / 6 / 1 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,17 | 0,16 | 22 → 23 | −0,02 | [−0,04 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,19 | 0,15 | — | −0,02 | [−0,05 ; +0,01] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,045 % | 0,038 % | 0 → 0 | +0,002 pt | [−0,014 pt ; +0,024 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 15,3 % | 33,1 % | — | +13,0 pt | [−13,9 pt ; +22,3 pt] | 12 / 18 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 113,2 % | 136,4 % | — | +24,1 pt | [+2,6 pt ; +35,4 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 7 | 10,5 | 30 → 30 | +3 | [+1 ; +6,5] | 8 / 21 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 3,5 | 8,5 | — | +4,5 | [+1 ; +7,5] | 6 / 21 / 3 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 48 | 77 | — | +17 | [−24,5 ; +75,5] | 12 / 17 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 119,5 | 181 | — | +54,5 | [+27 ; +89] | 4 / 26 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,87 | — | −0,002 | [−0,01 ; −0,0004] | 9 / 21 / 0 sur 30 | **B plus bas (moins bien)** |
| Bonheur moyen | 0,98 | 0,97 | — | −0,0004 | [−0,001 ; +0,001] | 13 / 17 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 8 / 22 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 295 $ | 21 277 $ | — | −124 458 $ | [−131 590 $ ; −70 081 $] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 4 / 0 / 26 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 24 | non concluant |
| Créances radiées | 9 049 $ | 0 $ | — | −8 234 $ | [−11 133 $ ; −3 509 $] | — / — / 0 | **B plus bas** |
| Filet : Anti-famine / 50 j | 0,00 | 0,02 | 5 → 12 | +0,02 | [0,00 ; +3,23] | 4 / 15 / 11 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 26,66 | 32,55 | 30 → 30 | +4,89 | [+1,27 ; +8,32] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 7 → 7 | 0,00 | [−0,04 ; 0,00] | 10 / 6 / 14 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 5 → 0 | 0,00 | [0,00 ; 0,00] | 5 / 1 / 24 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,27 | 10,36 | — | +1,71 | [+0,73 ; +2,61] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 0 → 3 | 0 | [0 ; 0] | 0 / 3 / 27 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 3 / 27 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 24 → 16 | 0 | [−1 ; 0] | 14 / 6 / 10 sur 30 | non concluant |
| … jours-alerte | 9 | 2,5 | — | −2,5 | [−7,5 ; 0] | 17 / 8 / 5 sur 30 | non concluant |
| Sans-abri nombreux | 2 | 1 | 30 → 19 | −1 | [−1 ; 0] | 19 / 9 / 2 sur 30 | non concluant |
| … jours-alerte | 29 | 14 | — | −13 | [−21,5 ; −8,5] | 23 / 6 / 1 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 2 | 6 | 27 → 30 | +3 | [+2 ; +5] | 3 / 27 / 0 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 2 | 6 | — | +3 | [+2 ; +5] | 3 / 27 / 0 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 20 → 28 | +1 | [+1 ; +2] | 3 / 22 / 5 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 8,5 | 33 | — | +23 | [+19 ; +40] | 3 / 26 / 1 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 7 → 9 | 0 | [0 ; 0] | 5 / 7 / 18 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 7 / 16 sur 30 | non concluant |

## Avec filets, sauf « Anti-crédit-fou »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 8,4 % | 0 → 6 | +3,4 pt | [+2,4 pt ; +5,9 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 14,6 % | 22,5 % | — | +7,9 pt | [+2,7 pt ; +12,5 pt] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 4 | +0,04 pt | [0,0 pt ; +0,3 pt] | 5 / 16 / 9 sur 30 | non concluant |
| Faim max | 35,4 % | 13,5 % | — | −1,5 pt | [−15,6 pt ; +12,3 pt] | 16 / 12 / 2 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 2 → 1 | 0,0 pt | [−0,04 pt ; +0,01 pt] | 13 / 13 / 4 sur 30 | non concluant |
| Sans-abri max | 35,6 % | 26,0 % | — | −15,0 pt | [−18,3 pt ; −6,5 pt] | 23 / 6 / 1 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,17 | 0,16 | 23 → 23 | −0,02 | [−0,03 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,18 | 0,15 | — | −0,02 | [−0,05 ; +0,02] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,043 % | 0,035 % | 0 → 0 | +0,002 pt | [−0,018 pt ; +0,023 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 17,1 % | 33,1 % | — | +9,2 pt | [−17,1 pt ; +18,7 pt] | 13 / 17 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 113,2 % | 136,4 % | — | +24,1 pt | [+2,6 pt ; +35,4 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 7 | 10,5 | 30 → 30 | +3 | [+1 ; +6,5] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 3,5 | 8,5 | — | +5,5 | [+0,5 ; +7,5] | 7 / 20 / 3 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 48 | 77 | — | +22,5 | [−14 ; +88] | 11 / 18 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 123 | 181 | — | +54,5 | [+23,5 ; +91,5] | 4 / 26 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,87 | — | −0,003 | [−0,01 ; −0,001] | 8 / 22 / 0 sur 30 | **B plus bas (moins bien)** |
| Bonheur moyen | 0,98 | 0,97 | — | −0,001 | [−0,002 ; +0,001] | 12 / 18 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,0 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 8 / 22 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 295 $ | 21 277 $ | — | −123 755 $ | [−131 495 $ ; −70 081 $] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 4 / 1 / 25 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 9 049 $ | 0 $ | — | −8 234 $ | [−11 133 $ ; −3 509 $] | — / — / 0 | **B plus bas** |
| Filet : Anti-famine / 50 j | 0,00 | 0,02 | 5 → 12 | +0,02 | [0,00 ; +3,23] | 5 / 15 / 10 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 26,66 | 32,55 | 30 → 30 | +4,59 | [−0,68 ; +7,95] | 11 / 19 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 6 → 7 | 0,00 | [0,00 ; 0,00] | 9 / 7 / 14 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,27 | 10,20 | — | +1,61 | [+0,73 ; +2,39] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 0 → 3 | 0 | [0 ; 0] | 0 / 3 / 27 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 3 / 27 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 24 → 16 | 0 | [−1 ; 0] | 14 / 7 / 9 sur 30 | non concluant |
| … jours-alerte | 9 | 2,5 | — | −2,5 | [−7,5 ; 0] | 17 / 9 / 4 sur 30 | non concluant |
| Sans-abri nombreux | 2 | 1 | 30 → 19 | −1 | [−1 ; 0] | 19 / 8 / 3 sur 30 | non concluant |
| … jours-alerte | 28 | 14 | — | −16 | [−22 ; −8,5] | 23 / 6 / 1 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 2,5 | 6 | 27 → 30 | +3 | [+2 ; +5] | 4 / 26 / 0 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 2,5 | 6 | — | +3 | [+2 ; +5] | 4 / 26 / 0 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 20 → 28 | +1 | [+1 ; +2] | 3 / 21 / 6 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 8,5 | 33 | — | +23 | [+17 ; +40] | 3 / 26 / 1 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 6 → 9 | 0 | [0 ; 0] | 5 / 8 / 17 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 6 / 8 / 16 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Chômage moyen : −20,8 pt [−46,7 pt ; −3,4 pt], B mieux (24 graines mieux, 6 moins bien, 0 égales)
- Sans filets — Chômage max : −49,8 pt [−62,7 pt ; −18,3 pt], B mieux (23 graines mieux, 6 moins bien, 1 égales)
- Sans filets — Faim moyenne : −9,1 pt [−52,0 pt ; −3,5 pt], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Sans filets — Sans-abri moyen : −15,3 pt [−46,8 pt ; −4,3 pt], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Sans filets — Sans-abri max : −27,1 pt [−40,2 pt ; −18,7 pt], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Sans filets — Gini moyen : −0,10 [−0,25 ; −0,04] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Gini en fin de partie : −0,22 [−0,38 ; −0,003] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Inflation moyenne / j : +0,042 pt [+0,026 pt ; +0,054 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — |Inflation| max / j : +18,5 pt [+17,1 pt ; +44,1 pt], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Sans filets — Alertes critiques ouvertes : +6,5 [+4 ; +10,5], B moins bien (5 graines mieux, 24 moins bien, 1 égales)
- Sans filets — dont après la chauffe (criticalSteady) : +8,5 [+6 ; +12], B moins bien (4 graines mieux, 26 moins bien, 0 égales)
- Sans filets — Jours-alerte critiques (somme des types) : −1496 [−2565 ; −459,5], B mieux (25 graines mieux, 5 moins bien, 0 égales)
- Sans filets — Alertes ouvertes (toutes) : −102,5 [−198,5 ; −2,5], B mieux (20 graines mieux, 10 moins bien, 0 égales)
- Sans filets — Bonheur moyen : +0,17 [+0,05 ; +0,41], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Sans filets — Trésor de l’État le plus bas : +68 072 $ [+20 562 $ ; +75 334 $], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Sans filets — Jours de Caisse insolvable : −1001 [−1207 ; −94], B mieux (20 graines mieux, 4 moins bien, 6 égales)
- Sans filets — Créances radiées : −22 614 $ [−29 436 $ ; −11 108 $] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Chômage très élevé : −1 [−1 ; −1], B mieux (21 graines mieux, 2 moins bien, 7 égales)
- Sans filets — Chômage très élevé : jours-alerte : −532 [−908,5 ; −33,5], B mieux (21 graines mieux, 3 moins bien, 6 égales)
- Sans filets — Faim répandue : jours-alerte : −275,5 [−774,5 ; −109], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Sans filets — Sans-abri nombreux : jours-alerte : −633 [−918,5 ; −259], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Sans filets — Inflation quotidienne : +6 [+5 ; +8,5], B moins bien (2 graines mieux, 27 moins bien, 1 égales)
- Sans filets — Inflation quotidienne : jours-alerte : +6 [+4,5 ; +9], B moins bien (2 graines mieux, 26 moins bien, 2 égales)
- Sans filets — Inflation sur 100 jours : jours-alerte : +30 [+13,5 ; +38], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Sans filets — Santé de la population effondrée : jours-alerte : −20 [−38,5 ; −8], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Chômage moyen : +3,4 pt [+2,4 pt ; +5,4 pt], B moins bien (1 graines mieux, 29 moins bien, 0 égales)
- Avec filets — Chômage max : +6,9 pt [+2,7 pt ; +10,8 pt], B moins bien (4 graines mieux, 25 moins bien, 1 égales)
- Avec filets — Sans-abri max : −15,0 pt [−18,3 pt ; −6,5 pt], B mieux (23 graines mieux, 6 moins bien, 1 égales)
- Avec filets — |Inflation sur 100 j| max : +24,1 pt [+2,6 pt ; +35,4 pt], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets — Alertes critiques ouvertes : +3 [+1 ; +6,5], B moins bien (8 graines mieux, 21 moins bien, 1 égales)
- Avec filets — dont après la chauffe (criticalSteady) : +4,5 [+1 ; +7,5], B moins bien (6 graines mieux, 21 moins bien, 3 égales)
- Avec filets — Alertes ouvertes (toutes) : +54,5 [+27 ; +89], B moins bien (4 graines mieux, 26 moins bien, 0 égales)
- Avec filets — Santé moyenne : −0,002 [−0,01 ; −0,0004], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets — Trésor de l’État le plus bas : −124 458 $ [−131 590 $ ; −70 081 $], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets — Créances radiées : −8 234 $ [−11 133 $ ; −3 509 $] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Filet : Renflouement d’entreprise / 50 j : +4,89 [+1,27 ; +8,32], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : +1,71 [+0,73 ; +2,61], B moins bien (4 graines mieux, 25 moins bien, 1 égales)
- Avec filets — Sans-abri nombreux : jours-alerte : −13 [−21,5 ; −8,5], B mieux (23 graines mieux, 6 moins bien, 1 égales)
- Avec filets — Inflation quotidienne : +3 [+2 ; +5], B moins bien (3 graines mieux, 27 moins bien, 0 égales)
- Avec filets — Inflation quotidienne : jours-alerte : +3 [+2 ; +5], B moins bien (3 graines mieux, 27 moins bien, 0 égales)
- Avec filets — Inflation sur 100 jours : +1 [+1 ; +2], B moins bien (3 graines mieux, 22 moins bien, 5 égales)
- Avec filets — Inflation sur 100 jours : jours-alerte : +23 [+19 ; +40], B moins bien (3 graines mieux, 26 moins bien, 1 égales)
- Avec filets, sauf « Anti-famine » — Chômage moyen : +4,2 pt [+2,9 pt ; +5,5 pt], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Chômage max : +9,2 pt [+4,6 pt ; +13,5 pt], B moins bien (4 graines mieux, 25 moins bien, 1 égales)
- Avec filets, sauf « Anti-famine » — Sans-abri max : −10,4 pt [−17,3 pt ; −4,2 pt], B mieux (21 graines mieux, 8 moins bien, 1 égales)
- Avec filets, sauf « Anti-famine » — |Inflation sur 100 j| max : +17,8 pt [+5,7 pt ; +36,3 pt], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Alertes critiques ouvertes : +4,5 [+1,5 ; +9,5], B moins bien (5 graines mieux, 24 moins bien, 1 égales)
- Avec filets, sauf « Anti-famine » — dont après la chauffe (criticalSteady) : +6,5 [+2 ; +10], B moins bien (3 graines mieux, 24 moins bien, 3 égales)
- Avec filets, sauf « Anti-famine » — Jours-alerte critiques (somme des types) : +35 [+3,5 ; +99,5], B moins bien (10 graines mieux, 20 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Alertes ouvertes (toutes) : +58,5 [+13 ; +121], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Santé moyenne : −0,01 [−0,04 ; −0,001], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Bonheur moyen : −0,001 [−0,02 ; −0,00002], B moins bien (10 graines mieux, 20 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Trésor de l’État le plus bas : −126 493 $ [−133 587 $ ; −80 817 $], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Créances radiées : −2 957 $ [−5 889 $ ; −1 465 $] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Filet : Renflouement d’entreprise / 50 j : +5,59 [+3,91 ; +8,80], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : +1,50 [+0,43 ; +2,52], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Sans-abri nombreux : jours-alerte : −15,5 [−19 ; −7], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Inflation quotidienne : +3 [+2 ; +6], B moins bien (2 graines mieux, 25 moins bien, 3 égales)
- Avec filets, sauf « Anti-famine » — Inflation quotidienne : jours-alerte : +3 [+2 ; +6], B moins bien (4 graines mieux, 25 moins bien, 1 égales)
- Avec filets, sauf « Anti-famine » — Inflation sur 100 jours : +1 [+1 ; +1,5], B moins bien (3 graines mieux, 23 moins bien, 4 égales)
- Avec filets, sauf « Anti-famine » — Inflation sur 100 jours : jours-alerte : +28 [+17 ; +40], B moins bien (3 graines mieux, 26 moins bien, 1 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Chômage moyen : +0,9 pt [+0,3 pt ; +1,5 pt], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Sans-abri moyen : −0,6 pt [−0,8 pt ; −0,1 pt], B mieux (24 graines mieux, 6 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Sans-abri max : −5,4 pt [−13,1 pt ; −1,0 pt], B mieux (23 graines mieux, 6 moins bien, 1 égales)
- Avec filets, sauf « Renflouement d’entreprise » — |Inflation| max / j : +30,3 pt [+23,0 pt ; +36,1 pt], B moins bien (2 graines mieux, 28 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — |Inflation sur 100 j| max : +15,1 pt [+1,5 pt ; +35,9 pt], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — dont après la chauffe (criticalSteady) : +7,5 [+1,5 ; +11,5], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Alertes ouvertes (toutes) : +132,5 [+53 ; +255,5], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Trésor de l’État le plus bas : −55 705 $ [−63 989 $ ; −39 808 $], B moins bien (3 graines mieux, 27 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Filet : Plancher de logement / 50 j : −10,82 [−14,68 ; −5,23], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Sans-abri nombreux : −1 [−3,5 ; −0,5], B mieux (20 graines mieux, 9 moins bien, 1 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Sans-abri nombreux : jours-alerte : −26 [−63 ; −11,5], B mieux (24 graines mieux, 6 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Inflation quotidienne : +6 [+4,5 ; +8], B moins bien (1 graines mieux, 28 moins bien, 1 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Inflation quotidienne : jours-alerte : +6 [+4,5 ; +8], B moins bien (1 graines mieux, 28 moins bien, 1 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Inflation sur 100 jours : jours-alerte : +32,5 [+10,5 ; +44,5], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Santé de la population effondrée : jours-alerte : −16 [−49 ; −11], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Chômage moyen : +3,1 pt [+2,2 pt ; +4,8 pt], B moins bien (1 graines mieux, 29 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Chômage max : +7,5 pt [+2,3 pt ; +11,5 pt], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Sans-abri max : −17,5 pt [−27,5 pt ; −8,5 pt], B mieux (24 graines mieux, 5 moins bien, 1 égales)
- Avec filets, sauf « Plancher de logement » — |Inflation sur 100 j| max : +16,3 pt [+5,1 pt ; +30,4 pt], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Alertes critiques ouvertes : +4 [+1,5 ; +7], B moins bien (7 graines mieux, 20 moins bien, 3 égales)
- Avec filets, sauf « Plancher de logement » — dont après la chauffe (criticalSteady) : +6 [+2 ; +8], B moins bien (6 graines mieux, 23 moins bien, 1 égales)
- Avec filets, sauf « Plancher de logement » — Alertes ouvertes (toutes) : +75,5 [+29 ; +94], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Santé moyenne : −0,002 [−0,01 ; −0,0003], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Trésor de l’État le plus bas : −97 967 $ [−119 606 $ ; −73 187 $], B moins bien (1 graines mieux, 29 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Créances radiées : −6 103 $ [−8 350 $ ; −3 349 $] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Filet : Renflouement d’entreprise / 50 j : +4,18 [+1,25 ; +7,12], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Faim répandue : jours-alerte : −5,5 [−10 ; −0,5], B mieux (20 graines mieux, 8 moins bien, 2 égales)
- Avec filets, sauf « Plancher de logement » — Sans-abri nombreux : jours-alerte : −21,5 [−29 ; −11,5], B mieux (25 graines mieux, 4 moins bien, 1 égales)
- Avec filets, sauf « Plancher de logement » — Inflation quotidienne : +3,5 [+2 ; +5], B moins bien (3 graines mieux, 24 moins bien, 3 égales)
- Avec filets, sauf « Plancher de logement » — Inflation quotidienne : jours-alerte : +3,5 [+1,5 ; +5], B moins bien (5 graines mieux, 24 moins bien, 1 égales)
- Avec filets, sauf « Plancher de logement » — Inflation sur 100 jours : jours-alerte : +28 [+19 ; +42,5], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Chômage moyen : +3,4 pt [+2,4 pt ; +5,4 pt], B moins bien (1 graines mieux, 29 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Chômage max : +6,9 pt [+2,7 pt ; +10,8 pt], B moins bien (4 graines mieux, 25 moins bien, 1 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Sans-abri max : −15,0 pt [−18,3 pt ; −6,5 pt], B mieux (23 graines mieux, 6 moins bien, 1 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — |Inflation sur 100 j| max : +24,1 pt [+2,6 pt ; +35,4 pt], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Alertes critiques ouvertes : +3 [+1 ; +6,5], B moins bien (8 graines mieux, 21 moins bien, 1 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — dont après la chauffe (criticalSteady) : +4,5 [+1 ; +7,5], B moins bien (6 graines mieux, 21 moins bien, 3 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Alertes ouvertes (toutes) : +54,5 [+27 ; +89], B moins bien (4 graines mieux, 26 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Santé moyenne : −0,002 [−0,01 ; −0,0004], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Trésor de l’État le plus bas : −124 458 $ [−131 590 $ ; −70 081 $], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Créances radiées : −8 234 $ [−11 133 $ ; −3 509 $] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Filet : Renflouement d’entreprise / 50 j : +4,89 [+1,27 ; +8,32], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : +1,71 [+0,73 ; +2,61], B moins bien (4 graines mieux, 25 moins bien, 1 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Sans-abri nombreux : jours-alerte : −13 [−21,5 ; −8,5], B mieux (23 graines mieux, 6 moins bien, 1 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Inflation quotidienne : +3 [+2 ; +5], B moins bien (3 graines mieux, 27 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Inflation quotidienne : jours-alerte : +3 [+2 ; +5], B moins bien (3 graines mieux, 27 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Inflation sur 100 jours : +1 [+1 ; +2], B moins bien (3 graines mieux, 22 moins bien, 5 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Inflation sur 100 jours : jours-alerte : +23 [+19 ; +40], B moins bien (3 graines mieux, 26 moins bien, 1 égales)
- Avec filets, sauf « Anti-crédit-fou » — Chômage moyen : +3,4 pt [+2,4 pt ; +5,9 pt], B moins bien (1 graines mieux, 29 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Chômage max : +7,9 pt [+2,7 pt ; +12,5 pt], B moins bien (4 graines mieux, 25 moins bien, 1 égales)
- Avec filets, sauf « Anti-crédit-fou » — Sans-abri max : −15,0 pt [−18,3 pt ; −6,5 pt], B mieux (23 graines mieux, 6 moins bien, 1 égales)
- Avec filets, sauf « Anti-crédit-fou » — |Inflation sur 100 j| max : +24,1 pt [+2,6 pt ; +35,4 pt], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Alertes critiques ouvertes : +3 [+1 ; +6,5], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — dont après la chauffe (criticalSteady) : +5,5 [+0,5 ; +7,5], B moins bien (7 graines mieux, 20 moins bien, 3 égales)
- Avec filets, sauf « Anti-crédit-fou » — Alertes ouvertes (toutes) : +54,5 [+23,5 ; +91,5], B moins bien (4 graines mieux, 26 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Santé moyenne : −0,003 [−0,01 ; −0,001], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Trésor de l’État le plus bas : −123 755 $ [−131 495 $ ; −70 081 $], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Créances radiées : −8 234 $ [−11 133 $ ; −3 509 $] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : +1,61 [+0,73 ; +2,39], B moins bien (4 graines mieux, 25 moins bien, 1 égales)
- Avec filets, sauf « Anti-crédit-fou » — Sans-abri nombreux : jours-alerte : −16 [−22 ; −8,5], B mieux (23 graines mieux, 6 moins bien, 1 égales)
- Avec filets, sauf « Anti-crédit-fou » — Inflation quotidienne : +3 [+2 ; +5], B moins bien (4 graines mieux, 26 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Inflation quotidienne : jours-alerte : +3 [+2 ; +5], B moins bien (4 graines mieux, 26 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Inflation sur 100 jours : +1 [+1 ; +2], B moins bien (3 graines mieux, 21 moins bien, 6 égales)
- Avec filets, sauf « Anti-crédit-fou » — Inflation sur 100 jours : jours-alerte : +23 [+17 ; +40], B moins bien (3 graines mieux, 26 moins bien, 1 égales)

