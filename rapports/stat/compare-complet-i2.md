# Comparaison appariée ÉcoNodes

- Date : 2026-10-11 14:38
- A : `complet-i1.json`
- A — Modules coupés : Hôpital et école publics : enveloppe et file d’attente, Assurance-emploi indexée et aide sociale, Caisse : règles prudentielles, Faillite ordonnée
- B : `complet-i1-i2.json`
- B — Modules coupés : Assurance-emploi indexée et aide sociale, Caisse : règles prudentielles, Faillite ordonnée
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,2 % | 8,0 % | 3 → 6 | +0,00000 pt | [−0,9 pt ; +1,3 pt] | 15 / 15 / 0 sur 30 | non concluant |
| Chômage max | 26,5 % | 26,0 % | — | +0,2 pt | [−3,5 pt ; +2,7 pt] | 14 / 15 / 1 sur 30 | non concluant |
| Faim moyenne | 7,0 % | 6,6 % | 28 → 29 | −0,2 pt | [−2,9 pt ; +1,3 pt] | 15 / 15 / 0 sur 30 | non concluant |
| Faim max | 95,2 % | 94,8 % | — | −0,4 pt | [−1,7 pt ; +0,4 pt] | 17 / 12 / 1 sur 30 | non concluant |
| Sans-abri moyen | 1,7 % | 1,6 % | 12 → 11 | −0,1 pt | [−0,8 pt ; +0,6 pt] | 17 / 13 / 0 sur 30 | non concluant |
| Sans-abri max | 42,1 % | 45,4 % | — | 0,0 pt | [−2,1 pt ; +3,3 pt] | 14 / 14 / 2 sur 30 | non concluant |
| Gini moyen | 0,34 | 0,35 | 3 → 4 | −0,003 | [−0,02 ; +0,05] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,48 | 0,33 | — | −0,03 | [−0,20 ; +0,20] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,060 % | 0,059 % | 0 → 0 | −0,006 pt | [−0,013 pt ; +0,009 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 37,5 % | 38,7 % | — | −10,2 pt | [−17,0 pt ; +8,5 pt] | 19 / 11 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 138,8 % | 141,3 % | — | +2,7 pt | [−6,3 pt ; +6,8 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 26 | 26 | 30 → 30 | +0,5 | [−4 ; +5] | 14 / 15 / 1 sur 30 | non concluant |
| … dont après la chauffe | 24 | 23,5 | — | +1 | [−4 ; +5] | 14 / 16 / 0 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 1611 | 1509 | — | −96 | [−223 ; −30] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 600 | 574,5 | — | −53 | [−104,5 ; +44] | 17 / 13 / 0 sur 30 | non concluant |
| Santé moyenne | 0,11 | 0,18 | — | +0,06 | [+0,04 ; +0,08] | 27 / 3 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,80 | 0,82 | — | +0,02 | [+0,01 ; +0,02] | 22 / 8 / 0 sur 30 | **B plus haut (mieux)** |
| Hôpital public : attente moyenne (j) | 0,0 | 471,8 | — | +471,8 | [+375,2 ; +519,6] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 3 / 7 / 20 sur 30 | non concluant |
| Trésor de l’État le plus bas | 76 796 $ | 64 946 $ | — | −19 507 $ | [−47 969 $ ; −4 182 $] | 9 / 21 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 7 / 8 / 15 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 21 094 $ | 21 226 $ | — | +2 028 $ | [−4 461 $ ; +8 641 $] | — / — / 0 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 3 → 6 | 0 | [0 ; 0] | 2 / 5 / 23 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 5 / 22 sur 30 | non concluant |
| Faim répandue | 5 | 6 | 30 → 30 | +1 | [0 ; +2] | 9 / 16 / 5 sur 30 | non concluant |
| … jours-alerte | 143,5 | 135 | — | −6 | [−54,5 ; +22,5] | 17 / 13 / 0 sur 30 | non concluant |
| Sans-abri nombreux | 9,5 | 10 | 30 → 30 | −1 | [−3 ; +2] | 16 / 13 / 1 sur 30 | non concluant |
| … jours-alerte | 104,5 | 96,5 | — | −8,5 | [−52 ; +29,5] | 16 / 13 / 1 sur 30 | non concluant |
| Inflation quotidienne | 7 | 7 | 30 → 30 | 0 | [−3 ; +2] | 14 / 14 / 2 sur 30 | non concluant |
| … jours-alerte | 7 | 7 | — | 0 | [−3 ; +2] | 14 / 14 / 2 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 29 → 27 | 0 | [−1 ; 0] | 13 / 8 / 9 sur 30 | non concluant |
| … jours-alerte | 44,5 | 36 | — | −6 | [−20,5 ; +1] | 19 / 11 / 0 sur 30 | non concluant |
| Santé de la population effondrée | 1 | 1 | 30 → 30 | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| … jours-alerte | 1305,5 | 1203 | — | −97 | [−121 ; −74] | 28 / 2 / 0 sur 30 | **B plus bas (mieux)** |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,4 % | 7,9 % | 6 → 8 | −0,4 pt | [−1,6 pt ; +0,6 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Chômage max | 22,5 % | 18,3 % | — | −3,1 pt | [−9,8 pt ; +0,8 pt] | 17 / 11 / 2 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,1 % | 4 → 0 | +0,004 pt | [−0,03 pt ; +0,1 pt] | 12 / 15 / 3 sur 30 | non concluant |
| Faim max | 13,5 % | 47,3 % | — | +10,8 pt | [0,0 pt ; +37,7 pt] | 9 / 19 / 2 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 1 → 0 | 0,0 pt | [−0,01 pt ; +0,01 pt] | 14 / 13 / 3 sur 30 | non concluant |
| Sans-abri max | 26,0 % | 13,1 % | — | −0,4 pt | [−7,3 pt ; +2,3 pt] | 16 / 12 / 2 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,19 | 23 → 18 | +0,04 | [+0,03 ; +0,05] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,15 | 0,20 | — | +0,04 | [−0,01 ; +0,07] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,038 % | 0,033 % | 0 → 0 | −0,003 pt | [−0,028 pt ; +0,007 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 33,1 % | 29,6 % | — | −0,6 pt | [−16,8 pt ; +9,2 pt] | 16 / 14 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 136,4 % | 140,3 % | — | +4,1 pt | [−2,2 pt ; +11,3 pt] | 12 / 18 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 10,5 | 9,5 | 30 → 30 | −0,5 | [−3,5 ; +1,5] | 15 / 13 / 2 sur 30 | non concluant |
| … dont après la chauffe | 8,5 | 7 | — | −1 | [−4,5 ; +1,5] | 16 / 12 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 77 | 91,5 | — | +1,5 | [−63,5 ; +41] | 15 / 15 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 181 | 146 | — | −11,5 | [−44,5 ; +14] | 19 / 11 / 0 sur 30 | non concluant |
| Santé moyenne | 0,87 | 0,88 | — | +0,01 | [+0,004 ; +0,01] | 21 / 9 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,97 | 0,98 | — | +0,001 | [−0,001 ; +0,003] | 17 / 13 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,4 | — | +0,4 | [+0,3 ; +5,9] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 7 / 7 / 16 sur 30 | non concluant |
| Trésor de l’État le plus bas | 21 277 $ | 27 275 $ | — | −2 193 $ | [−34 266 $ ; +12 890 $] | 14 / 16 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 27 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; +46 $] | — / — / 11 | non concluant |
| Filet : Anti-famine / 50 j | 0,02 | 0,75 | 12 → 14 | +0,02 | [−0,07 ; +2,02] | 10 / 15 / 5 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 32,55 | 16,86 | 30 → 30 | −16,00 | [−20,09 ; −10,82] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 7 → 6 | 0,00 | [0,00 ; 0,00] | 8 / 7 / 15 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 1 | 0,00 | [0,00 ; 0,00] | 1 / 2 / 27 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 10,36 | 0,00 | — | −10,36 | [−10,93 ; −9,71] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 3 → 8 | 0 | [0 ; 0] | 2 / 7 / 21 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 7 / 20 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 16 → 21 | 0 | [−1 ; +1] | 12 / 12 / 6 sur 30 | non concluant |
| … jours-alerte | 2,5 | 3,5 | — | 0 | [−3,5 ; +4,5] | 12 / 14 / 4 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 19 → 16 | 0 | [−0,5 ; 0] | 10 / 7 / 13 sur 30 | non concluant |
| … jours-alerte | 14 | 2,5 | — | 0 | [−4 ; +1] | 12 / 11 / 7 sur 30 | non concluant |
| Inflation quotidienne | 6 | 5 | 30 → 30 | −0,5 | [−2 ; +0,5] | 15 / 10 / 5 sur 30 | non concluant |
| … jours-alerte | 6 | 5 | — | −0,5 | [−2 ; +0,5] | 15 / 10 / 5 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 28 → 28 | 0 | [−1 ; +0,5] | 11 / 10 / 9 sur 30 | non concluant |
| … jours-alerte | 33 | 39 | — | −1 | [−7 ; +20] | 15 / 14 / 1 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 9 → 8 | 0 | [0 ; 0] | 7 / 7 / 16 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 8 / 7 / 15 sur 30 | non concluant |

## Avec filets, sauf « Anti-famine »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,2 % | 7,9 % | 7 → 5 | −0,9 pt | [−1,6 pt ; +0,3 pt] | 19 / 11 / 0 sur 30 | non concluant |
| Chômage max | 23,3 % | 18,3 % | — | −4,4 pt | [−9,6 pt ; 0,0 pt] | 19 / 9 / 2 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 6 → 4 | +0,004 pt | [−0,03 pt ; +0,1 pt] | 12 / 15 / 3 sur 30 | non concluant |
| Faim max | 22,5 % | 45,2 % | — | +5,6 pt | [−3,5 pt ; +35,8 pt] | 11 / 17 / 2 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 4 → 1 | 0,0 pt | [−0,2 pt ; +0,02 pt] | 14 / 12 / 4 sur 30 | non concluant |
| Sans-abri max | 28,3 % | 21,3 % | — | −0,6 pt | [−14,2 pt ; +1,7 pt] | 16 / 11 / 3 sur 30 | non concluant |
| Gini moyen | 0,17 | 0,19 | 22 → 17 | +0,03 | [+0,02 ; +0,05] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,15 | 0,22 | — | +0,04 | [−0,001 ; +0,12] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,041 % | 0,035 % | 0 → 0 | −0,005 pt | [−0,027 pt ; +0,009 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 33,6 % | 33,0 % | — | −1,1 pt | [−12,2 pt ; +13,1 pt] | 17 / 13 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 137,3 % | 141,0 % | — | +4,1 pt | [−2,2 pt ; +11,3 pt] | 12 / 18 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 12,5 | 10 | 30 → 30 | −1 | [−5,5 ; +2] | 16 / 13 / 1 sur 30 | non concluant |
| … dont après la chauffe | 10 | 7 | — | −1,5 | [−5 ; +1,5] | 17 / 12 / 1 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 91,5 | 95 | — | +1,5 | [−70,5 ; +60,5] | 15 / 15 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 181 | 145,5 | — | −22,5 | [−78,5 ; +20,5] | 19 / 11 / 0 sur 30 | non concluant |
| Santé moyenne | 0,87 | 0,88 | — | +0,01 | [+0,004 ; +0,05] | 22 / 8 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,97 | 0,98 | — | +0,001 | [−0,0003 ; +0,01] | 19 / 11 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,3 | — | +0,3 | [+0,3 ; +0,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 8 / 6 / 16 sur 30 | non concluant |
| Trésor de l’État le plus bas | 19 017 $ | 27 275 $ | — | +142 $ | [−26 680 $ ; +14 309 $] | 15 / 15 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 26 | non concluant |
| Créances radiées | 0 $ | 706 $ | — | 0 $ | [0 $ ; +1 557 $] | — / — / 9 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 32,20 | 16,41 | 30 → 30 | −15,71 | [−19,29 ; −11,34] | 28 / 2 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 10 → 6 | 0,00 | [−0,32 ; 0,00] | 11 / 9 / 10 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 3 | 0,00 | [0,00 ; 0,00] | 0 / 4 / 26 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 10,11 | 0,00 | — | −10,11 | [−10,64 ; −9,71] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 7 → 6 | 0 | [0 ; 0] | 6 / 5 / 19 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 5 / 18 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 16 → 21 | 0 | [0 ; +1] | 9 / 11 / 10 sur 30 | non concluant |
| … jours-alerte | 1 | 3 | — | +0,5 | [−2 ; +4] | 11 / 15 / 4 sur 30 | non concluant |
| Sans-abri nombreux | 2 | 1 | 21 → 18 | 0 | [−1,5 ; 0] | 11 / 8 / 11 sur 30 | non concluant |
| … jours-alerte | 19 | 2,5 | — | 0 | [−16 ; +0,5] | 14 / 10 / 6 sur 30 | non concluant |
| Inflation quotidienne | 6 | 5 | 30 → 30 | −1 | [−3,5 ; 0] | 17 / 9 / 4 sur 30 | non concluant |
| … jours-alerte | 6 | 5 | — | −1 | [−3,5 ; 0] | 17 / 9 / 4 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 28 → 28 | 0 | [−0,5 ; +0,5] | 10 / 10 / 10 sur 30 | non concluant |
| … jours-alerte | 33 | 39 | — | −1 | [−8 ; +20] | 15 / 14 / 1 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 12 → 8 | 0 | [−0,5 ; 0] | 10 / 6 / 14 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [−24 ; 0] | 10 / 8 / 12 sur 30 | non concluant |

## Avec filets, sauf « Renflouement d’entreprise »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,7 % | 7,8 % | 0 → 7 | +0,3 pt | [−0,4 pt ; +1,5 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Chômage max | 24,8 % | 25,0 % | — | +0,8 pt | [−0,6 pt ; +2,7 pt] | 10 / 18 / 2 sur 30 | non concluant |
| Faim moyenne | 3,9 % | 3,5 % | 24 → 29 | −0,4 pt | [−0,9 pt ; +0,6 pt] | 19 / 11 / 0 sur 30 | non concluant |
| Faim max | 94,4 % | 94,8 % | — | 0,0 pt | [−0,2 pt ; +1,3 pt] | 10 / 14 / 6 sur 30 | non concluant |
| Sans-abri moyen | 0,6 % | 0,7 % | 0 → 2 | −0,003 pt | [−0,3 pt ; +0,3 pt] | 15 / 15 / 0 sur 30 | non concluant |
| Sans-abri max | 35,2 % | 33,8 % | — | 0,0 pt | [−3,7 pt ; +4,2 pt] | 14 / 13 / 3 sur 30 | non concluant |
| Gini moyen | 0,35 | 0,36 | 1 → 2 | +0,01 | [−0,03 ; +0,04] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,42 | 0,35 | — | −0,04 | [−0,16 ; +0,02] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,056 % | 0,063 % | 0 → 0 | +0,002 pt | [−0,002 pt ; +0,013 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 35,7 % | 30,3 % | — | −3,5 pt | [−16,9 pt ; +11,5 pt] | 17 / 13 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 135,0 % | 140,7 % | — | +1,9 pt | [−4,1 pt ; +6,0 pt] | 12 / 18 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 18 | 21 | 30 → 30 | +2,5 | [0 ; +4,5] | 10 / 20 / 0 sur 30 | non concluant |
| … dont après la chauffe | 15,5 | 18,5 | — | +2 | [−0,5 ; +4,5] | 10 / 19 / 1 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 1491 | 1418 | — | −68,5 | [−116,5 ; −33] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 523 | 524,5 | — | −3,5 | [−56 ; +52,5] | 16 / 14 / 0 sur 30 | non concluant |
| Santé moyenne | 0,11 | 0,17 | — | +0,06 | [+0,03 ; +0,07] | 26 / 4 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,81 | 0,82 | — | +0,01 | [+0,004 ; +0,01] | 23 / 7 / 0 sur 30 | **B plus haut (mieux)** |
| Hôpital public : attente moyenne (j) | 0,0 | 503,5 | — | +503,5 | [+435,7 ; +529,2] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 7 / 23 sur 30 | non concluant |
| Trésor de l’État le plus bas | 83 716 $ | 64 904 $ | — | −19 051 $ | [−24 429 $ ; −12 087 $] | 4 / 26 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [−337,5 ; 0] | 11 / 9 / 10 sur 30 | non concluant |
| Prêts refusés | 0 | 3,5 | — | 0 | [−100 ; +3,5] | — / — / 6 | non concluant |
| Créances radiées | 24 976 $ | 24 484 $ | — | −2 302 $ | [−4 163 $ ; +3 486 $] | — / — / 0 | non concluant |
| Filet : Anti-famine / 50 j | 118,91 | 109,54 | 30 → 30 | −6,21 | [−33,52 ; +22,63] | 16 / 14 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 8,59 | 5,75 | 30 → 25 | −2,79 | [−6,04 ; +2,91] | 17 / 13 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,13 | 14 → 8 | 0,00 | [−3,57 ; +0,13] | 13 / 11 / 6 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 0 → 5 | 0 | [0 ; 0] | 0 / 5 / 25 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 5 / 25 sur 30 | non concluant |
| Faim répandue | 5 | 6 | 30 → 30 | +1 | [0 ; +1,5] | 7 / 18 / 5 sur 30 | non concluant |
| … jours-alerte | 112,5 | 100,5 | — | −5,5 | [−24,5 ; +15,5] | 19 / 11 / 0 sur 30 | non concluant |
| Sans-abri nombreux | 3 | 3 | 29 → 28 | −1 | [−2 ; +2,5] | 16 / 12 / 2 sur 30 | non concluant |
| … jours-alerte | 26,5 | 32 | — | +3 | [−16 ; +23] | 14 / 15 / 1 sur 30 | non concluant |
| Inflation quotidienne | 7 | 8 | 28 → 30 | +1 | [−1 ; +2] | 11 / 17 / 2 sur 30 | non concluant |
| … jours-alerte | 7 | 8 | — | +1 | [−1 ; +2] | 11 / 17 / 2 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 29 → 29 | 0 | [−0,5 ; +1] | 10 / 13 / 7 sur 30 | non concluant |
| … jours-alerte | 37,5 | 37 | — | −0,5 | [−25,5 ; +14] | 15 / 15 / 0 sur 30 | non concluant |
| Santé de la population effondrée | 1 | 1 | 30 → 30 | 0 | [0 ; 0] | 0 / 3 / 27 sur 30 | non concluant |
| … jours-alerte | 1304,5 | 1209,5 | — | −84,5 | [−118,5 ; −70,5] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |

## Avec filets, sauf « Plancher de logement »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,5 % | 8,1 % | 7 → 4 | −0,5 pt | [−2,2 pt ; +0,9 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Chômage max | 23,3 % | 19,2 % | — | −1,9 pt | [−6,9 pt ; +2,7 pt] | 15 / 13 / 2 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 3 → 0 | +0,01 pt | [−0,1 pt ; +0,1 pt] | 13 / 15 / 2 sur 30 | non concluant |
| Faim max | 42,7 % | 49,2 % | — | +7,3 pt | [−4,0 pt ; +33,3 pt] | 12 / 17 / 1 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 2 → 0 | −0,002 pt | [−0,04 pt ; 0,0 pt] | 16 / 9 / 5 sur 30 | non concluant |
| Sans-abri max | 23,3 % | 16,5 % | — | −0,2 pt | [−4,8 pt ; +0,6 pt] | 15 / 11 / 4 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,19 | 23 → 17 | +0,03 | [+0,02 ; +0,05] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,14 | 0,19 | — | +0,03 | [−0,02 ; +0,07] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,036 % | 0,035 % | 0 → 0 | +0,002 pt | [−0,025 pt ; +0,017 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 33,1 % | 38,1 % | — | −0,6 pt | [−12,3 pt ; +9,0 pt] | 16 / 14 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 137,7 % | 141,0 % | — | +3,5 pt | [−2,3 pt ; +9,6 pt] | 12 / 18 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 13 | 10,5 | 30 → 30 | −3 | [−4,5 ; +1,5] | 17 / 12 / 1 sur 30 | non concluant |
| … dont après la chauffe | 10,5 | 7,5 | — | −1 | [−5 ; +1,5] | 17 / 12 / 1 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 107,5 | 106,5 | — | +7 | [−51 ; +83] | 15 / 15 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 185,5 | 147 | — | −13 | [−53,5 ; +11] | 19 / 11 / 0 sur 30 | non concluant |
| Santé moyenne | 0,87 | 0,88 | — | +0,01 | [+0,004 ; +0,02] | 22 / 8 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,97 | 0,98 | — | +0,0002 | [−0,001 ; +0,003] | 16 / 14 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,4 | — | +0,4 | [+0,3 ; +0,6] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 6 / 8 / 16 sur 30 | non concluant |
| Trésor de l’État le plus bas | 51 190 $ | 20 159 $ | — | −32 598 $ | [−38 468 $ ; +6 153 $] | 11 / 19 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 895 $ | — | 0 $ | [−327 $ ; +369 $] | — / — / 8 | non concluant |
| Filet : Anti-famine / 50 j | 0,59 | 1,04 | 14 → 15 | +0,05 | [−0,20 ; +2,16] | 11 / 16 / 3 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 30,75 | 16,21 | 30 → 30 | −16,00 | [−20,50 ; −11,66] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 9,71 | 0,00 | — | −9,71 | [−10,36 ; −9,11] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 4 → 7 | 0 | [0 ; 0] | 3 / 6 / 21 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 7 / 20 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 20 → 22 | 0 | [−1 ; 0] | 13 / 8 / 9 sur 30 | non concluant |
| … jours-alerte | 4,5 | 4,5 | — | 0 | [−3,5 ; +7] | 13 / 13 / 4 sur 30 | non concluant |
| Sans-abri nombreux | 1,5 | 1 | 19 → 16 | 0 | [−1 ; 0] | 12 / 6 / 12 sur 30 | non concluant |
| … jours-alerte | 11 | 2,5 | — | −0,5 | [−5 ; 0] | 15 / 7 / 8 sur 30 | non concluant |
| Inflation quotidienne | 6,5 | 5,5 | 30 → 30 | −1 | [−2,5 ; 0] | 17 / 8 / 5 sur 30 | non concluant |
| … jours-alerte | 6,5 | 5,5 | — | −1 | [−2,5 ; 0] | 17 / 9 / 4 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 29 → 28 | 0 | [0 ; +1] | 9 / 11 / 10 sur 30 | non concluant |
| … jours-alerte | 40 | 48 | — | −2,5 | [−11 ; +16,5] | 16 / 14 / 0 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 10 → 9 | 0 | [0 ; 0] | 8 / 7 / 15 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 9 / 8 / 13 sur 30 | non concluant |

## Avec filets, sauf « Plafond de dérive des prix et salaires »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,4 % | 7,9 % | 6 → 8 | −0,4 pt | [−1,6 pt ; +0,6 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Chômage max | 22,5 % | 18,3 % | — | −3,1 pt | [−9,8 pt ; +0,8 pt] | 17 / 11 / 2 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,1 % | 4 → 0 | +0,004 pt | [−0,03 pt ; +0,1 pt] | 12 / 15 / 3 sur 30 | non concluant |
| Faim max | 13,5 % | 47,3 % | — | +10,8 pt | [0,0 pt ; +37,7 pt] | 9 / 19 / 2 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 1 → 0 | 0,0 pt | [−0,01 pt ; +0,01 pt] | 14 / 13 / 3 sur 30 | non concluant |
| Sans-abri max | 26,0 % | 13,1 % | — | −0,4 pt | [−7,3 pt ; +2,3 pt] | 16 / 12 / 2 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,19 | 23 → 18 | +0,04 | [+0,03 ; +0,05] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,15 | 0,20 | — | +0,04 | [−0,01 ; +0,07] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,038 % | 0,033 % | 0 → 0 | −0,003 pt | [−0,028 pt ; +0,007 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 33,1 % | 29,6 % | — | −0,6 pt | [−16,8 pt ; +9,2 pt] | 16 / 14 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 136,4 % | 140,3 % | — | +4,1 pt | [−2,2 pt ; +11,3 pt] | 12 / 18 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 10,5 | 9,5 | 30 → 30 | −0,5 | [−3,5 ; +1,5] | 15 / 13 / 2 sur 30 | non concluant |
| … dont après la chauffe | 8,5 | 7 | — | −1 | [−4,5 ; +1,5] | 16 / 12 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 77 | 91,5 | — | +1,5 | [−63,5 ; +41] | 15 / 15 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 181 | 146 | — | −11,5 | [−44,5 ; +14] | 19 / 11 / 0 sur 30 | non concluant |
| Santé moyenne | 0,87 | 0,88 | — | +0,01 | [+0,004 ; +0,01] | 21 / 9 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,97 | 0,98 | — | +0,001 | [−0,001 ; +0,003] | 17 / 13 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,4 | — | +0,4 | [+0,3 ; +5,9] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 7 / 7 / 16 sur 30 | non concluant |
| Trésor de l’État le plus bas | 21 277 $ | 27 275 $ | — | −2 193 $ | [−34 266 $ ; +12 890 $] | 14 / 16 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 27 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; +46 $] | — / — / 11 | non concluant |
| Filet : Anti-famine / 50 j | 0,02 | 0,75 | 12 → 14 | +0,02 | [−0,07 ; +2,02] | 10 / 15 / 5 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 32,55 | 16,86 | 30 → 30 | −16,00 | [−20,09 ; −10,82] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 7 → 6 | 0,00 | [0,00 ; 0,00] | 8 / 7 / 15 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 1 | 0,00 | [0,00 ; 0,00] | 1 / 2 / 27 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 10,36 | 0,00 | — | −10,36 | [−10,93 ; −9,71] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 3 → 8 | 0 | [0 ; 0] | 2 / 7 / 21 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 7 / 20 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 16 → 21 | 0 | [−1 ; +1] | 12 / 12 / 6 sur 30 | non concluant |
| … jours-alerte | 2,5 | 3,5 | — | 0 | [−3,5 ; +4,5] | 12 / 14 / 4 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 19 → 16 | 0 | [−0,5 ; 0] | 10 / 7 / 13 sur 30 | non concluant |
| … jours-alerte | 14 | 2,5 | — | 0 | [−4 ; +1] | 12 / 11 / 7 sur 30 | non concluant |
| Inflation quotidienne | 6 | 5 | 30 → 30 | −0,5 | [−2 ; +0,5] | 15 / 10 / 5 sur 30 | non concluant |
| … jours-alerte | 6 | 5 | — | −0,5 | [−2 ; +0,5] | 15 / 10 / 5 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 28 → 28 | 0 | [−1 ; +0,5] | 11 / 10 / 9 sur 30 | non concluant |
| … jours-alerte | 33 | 39 | — | −1 | [−7 ; +20] | 15 / 14 / 1 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 9 → 8 | 0 | [0 ; 0] | 7 / 7 / 16 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 8 / 7 / 15 sur 30 | non concluant |

## Avec filets, sauf « Anti-crédit-fou »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,4 % | 7,9 % | 6 → 8 | −0,4 pt | [−1,7 pt ; +0,7 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Chômage max | 22,5 % | 18,3 % | — | −3,1 pt | [−9,8 pt ; +0,8 pt] | 18 / 10 / 2 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,1 % | 4 → 0 | +0,004 pt | [−0,03 pt ; +0,1 pt] | 12 / 15 / 3 sur 30 | non concluant |
| Faim max | 13,5 % | 47,3 % | — | +10,8 pt | [0,0 pt ; +37,7 pt] | 9 / 19 / 2 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,0 % | 1 → 0 | 0,0 pt | [−0,01 pt ; +0,01 pt] | 14 / 13 / 3 sur 30 | non concluant |
| Sans-abri max | 26,0 % | 13,1 % | — | −0,4 pt | [−7,3 pt ; +2,3 pt] | 16 / 12 / 2 sur 30 | non concluant |
| Gini moyen | 0,16 | 0,19 | 23 → 18 | +0,04 | [+0,03 ; +0,05] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,15 | 0,20 | — | +0,07 | [−0,01 ; +0,08] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,035 % | 0,033 % | 0 → 0 | −0,006 pt | [−0,028 pt ; +0,007 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 33,1 % | 29,8 % | — | −0,6 pt | [−16,8 pt ; +9,2 pt] | 16 / 14 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 136,4 % | 140,3 % | — | +4,1 pt | [−2,2 pt ; +11,3 pt] | 12 / 18 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 10,5 | 9,5 | 30 → 30 | −0,5 | [−3,5 ; +1] | 15 / 12 / 3 sur 30 | non concluant |
| … dont après la chauffe | 8,5 | 7 | — | −1 | [−4,5 ; +1,5] | 16 / 12 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 77 | 91,5 | — | +1,5 | [−63,5 ; +41] | 15 / 15 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 181 | 146 | — | −11,5 | [−44,5 ; +14] | 19 / 11 / 0 sur 30 | non concluant |
| Santé moyenne | 0,87 | 0,88 | — | +0,01 | [+0,004 ; +0,01] | 21 / 9 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,97 | 0,98 | — | +0,001 | [−0,001 ; +0,003] | 17 / 13 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,4 | — | +0,4 | [+0,3 ; +5,9] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 7 / 7 / 16 sur 30 | non concluant |
| Trésor de l’État le plus bas | 21 277 $ | 27 275 $ | — | −2 193 $ | [−34 266 $ ; +12 890 $] | 14 / 16 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; +46 $] | — / — / 11 | non concluant |
| Filet : Anti-famine / 50 j | 0,02 | 0,75 | 12 → 14 | +0,02 | [−0,07 ; +2,02] | 10 / 15 / 5 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 32,55 | 16,86 | 30 → 30 | −16,00 | [−19,84 ; −11,05] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 0,00 | 0,00 | 7 → 6 | 0,00 | [0,00 ; 0,00] | 8 / 7 / 15 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 10,20 | 0,00 | — | −10,20 | [−10,75 ; −9,71] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 3 → 7 | 0 | [0 ; 0] | 2 / 6 / 22 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 6 / 21 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 16 → 21 | 0 | [−1 ; +1] | 12 / 12 / 6 sur 30 | non concluant |
| … jours-alerte | 2,5 | 3,5 | — | 0 | [−3,5 ; +4,5] | 12 / 14 / 4 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 19 → 16 | 0 | [−0,5 ; 0] | 10 / 7 / 13 sur 30 | non concluant |
| … jours-alerte | 14 | 2,5 | — | 0 | [−4 ; +1] | 12 / 11 / 7 sur 30 | non concluant |
| Inflation quotidienne | 6 | 5 | 30 → 30 | −0,5 | [−2 ; 0] | 15 / 9 / 6 sur 30 | non concluant |
| … jours-alerte | 6 | 5 | — | −0,5 | [−2 ; 0] | 15 / 9 / 6 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 28 → 28 | 0 | [−1 ; +0,5] | 11 / 10 / 9 sur 30 | non concluant |
| … jours-alerte | 33 | 39 | — | −1 | [−7 ; +20] | 15 / 14 / 1 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 9 → 8 | 0 | [0 ; 0] | 7 / 7 / 16 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 8 / 7 / 15 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Jours-alerte critiques (somme des types) : −96 [−223 ; −30], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Sans filets — Santé moyenne : +0,06 [+0,04 ; +0,08], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Sans filets — Bonheur moyen : +0,02 [+0,01 ; +0,02], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Sans filets — Hôpital public : attente moyenne (j) : +471,8 [+375,2 ; +519,6], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Sans filets — Trésor de l’État le plus bas : −19 507 $ [−47 969 $ ; −4 182 $], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Sans filets — Santé de la population effondrée : jours-alerte : −97 [−121 ; −74], B mieux (28 graines mieux, 2 moins bien, 0 égales)
- Avec filets — Gini moyen : +0,04 [+0,03 ; +0,05] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Santé moyenne : +0,01 [+0,004 ; +0,01], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Hôpital public : attente moyenne (j) : +0,4 [+0,3 ; +5,9], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets — Filet : Renflouement d’entreprise / 50 j : −16,00 [−20,09 ; −10,82], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Avec filets — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : −10,36 [−10,93 ; −9,71], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Gini moyen : +0,03 [+0,02 ; +0,05] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Santé moyenne : +0,01 [+0,004 ; +0,05], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Hôpital public : attente moyenne (j) : +0,3 [+0,3 ; +0,5], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Filet : Renflouement d’entreprise / 50 j : −15,71 [−19,29 ; −11,34], B mieux (28 graines mieux, 2 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : −10,11 [−10,64 ; −9,71], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Jours-alerte critiques (somme des types) : −68,5 [−116,5 ; −33], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Santé moyenne : +0,06 [+0,03 ; +0,07], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Bonheur moyen : +0,01 [+0,004 ; +0,01], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Hôpital public : attente moyenne (j) : +503,5 [+435,7 ; +529,2], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Trésor de l’État le plus bas : −19 051 $ [−24 429 $ ; −12 087 $], B moins bien (4 graines mieux, 26 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Santé de la population effondrée : jours-alerte : −84,5 [−118,5 ; −70,5], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Gini moyen : +0,03 [+0,02 ; +0,05] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Santé moyenne : +0,01 [+0,004 ; +0,02], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Hôpital public : attente moyenne (j) : +0,4 [+0,3 ; +0,6], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Filet : Renflouement d’entreprise / 50 j : −16,00 [−20,50 ; −11,66], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : −9,71 [−10,36 ; −9,11], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Gini moyen : +0,04 [+0,03 ; +0,05] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Santé moyenne : +0,01 [+0,004 ; +0,01], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Hôpital public : attente moyenne (j) : +0,4 [+0,3 ; +5,9], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Filet : Renflouement d’entreprise / 50 j : −16,00 [−20,09 ; −10,82], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : −10,36 [−10,93 ; −9,71], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Gini moyen : +0,04 [+0,03 ; +0,05] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Santé moyenne : +0,01 [+0,004 ; +0,01], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Hôpital public : attente moyenne (j) : +0,4 [+0,3 ; +5,9], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Filet : Renflouement d’entreprise / 50 j : −16,00 [−19,84 ; −11,05], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : −10,20 [−10,75 ; −9,71], B mieux (30 graines mieux, 0 moins bien, 0 égales)

