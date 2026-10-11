# Comparaison appariée ÉcoNodes

- Date : 2026-10-11 14:38
- A : `complet-i1-i2.json`
- A — Modules coupés : Assurance-emploi indexée et aide sociale, Caisse : règles prudentielles, Faillite ordonnée
- B : `complet-i1-i3.json`
- B — Modules coupés : Caisse : règles prudentielles, Faillite ordonnée
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,0 % | 7,9 % | 6 → 3 | +0,1 pt | [−0,7 pt ; +0,8 pt] | 15 / 15 / 0 sur 30 | non concluant |
| Chômage max | 26,0 % | 27,1 % | — | +0,8 pt | [−1,3 pt ; +4,2 pt] | 12 / 17 / 1 sur 30 | non concluant |
| Faim moyenne | 6,6 % | 7,3 % | 29 → 29 | +0,8 pt | [−1,4 pt ; +2,0 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Faim max | 94,8 % | 95,4 % | — | +0,8 pt | [−0,2 pt ; +1,7 pt] | 10 / 18 / 2 sur 30 | non concluant |
| Sans-abri moyen | 1,6 % | 2,6 % | 11 → 21 | +1,1 pt | [+0,1 pt ; +1,5 pt] | 10 / 20 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 45,4 % | 43,1 % | — | 0,0 pt | [−3,1 pt ; +4,2 pt] | 12 / 14 / 4 sur 30 | non concluant |
| Gini moyen | 0,35 | 0,35 | 4 → 0 | −0,02 | [−0,08 ; +0,03] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,33 | 0,27 | — | −0,13 | [−0,27 ; +0,06] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,059 % | 0,072 % | 0 → 0 | +0,010 pt | [−0,002 pt ; +0,025 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 38,7 % | 31,8 % | — | +1,9 pt | [−7,7 pt ; +13,2 pt] | 14 / 16 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,3 % | 136,2 % | — | −6,4 pt | [−11,7 pt ; +1,1 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 26 | 28 | 30 → 30 | +0,5 | [−2,5 ; +4,5] | 12 / 15 / 3 sur 30 | non concluant |
| … dont après la chauffe | 23,5 | 25,5 | — | +1 | [−3 ; +4,5] | 14 / 16 / 0 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 1509 | 1528 | — | −1,5 | [−40 ; +80,5] | 15 / 15 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 574,5 | 595 | — | −11 | [−116 ; +72,5] | 16 / 14 / 0 sur 30 | non concluant |
| Santé moyenne | 0,18 | 0,17 | — | +0,01 | [−0,02 ; +0,03] | 16 / 14 / 0 sur 30 | non concluant |
| Bonheur moyen | 0,82 | 0,81 | — | −0,002 | [−0,01 ; +0,004] | 13 / 17 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 471,8 | 482,3 | — | −0,9 | [−70,2 ; +73,3] | 15 / 15 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 8 / 2 / 20 sur 30 | non concluant |
| Trésor de l’État le plus bas | 64 946 $ | 94 272 $ | — | +23 709 $ | [+19 364 $ ; +42 784 $] | 26 / 4 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 7 / 6 / 17 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 21 226 $ | 20 219 $ | — | −5 077 $ | [−8 032 $ ; +3 446 $] | — / — / 0 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 6 → 3 | 0 | [0 ; 0] | 6 / 3 / 21 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 6 / 3 / 21 sur 30 | non concluant |
| Faim répandue | 6 | 5,5 | 30 → 30 | 0 | [−1 ; +1] | 12 / 11 / 7 sur 30 | non concluant |
| … jours-alerte | 135 | 152,5 | — | +18,5 | [−28,5 ; +36] | 13 / 17 / 0 sur 30 | non concluant |
| Sans-abri nombreux | 10 | 10 | 30 → 30 | +0,5 | [−1 ; +3,5] | 10 / 15 / 5 sur 30 | non concluant |
| … jours-alerte | 96,5 | 143 | — | +35,5 | [+20 ; +88,5] | 6 / 24 / 0 sur 30 | **B plus haut (moins bien)** |
| Inflation quotidienne | 7 | 7,5 | 30 → 30 | −0,5 | [−2 ; +1] | 15 / 13 / 2 sur 30 | non concluant |
| … jours-alerte | 7 | 7,5 | — | −0,5 | [−2 ; +1] | 15 / 13 / 2 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 27 → 30 | 0 | [−1 ; +1] | 12 / 12 / 6 sur 30 | non concluant |
| … jours-alerte | 36 | 31,5 | — | −4 | [−15 ; +23,5] | 18 / 12 / 0 sur 30 | non concluant |
| Santé de la population effondrée | 1 | 1 | 30 → 30 | 0 | [0 ; 0] | 1 / 1 / 28 sur 30 | non concluant |
| … jours-alerte | 1203 | 1201 | — | −9 | [−46 ; +8] | 17 / 13 / 0 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 7,0 % | 8 → 5 | −0,6 pt | [−2,0 pt ; −0,4 pt] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 18,3 % | 19,0 % | — | +0,8 pt | [−2,9 pt ; +4,4 pt] | 13 / 15 / 2 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 0 | −0,03 pt | [−0,2 pt ; +0,02 pt] | 18 / 11 / 1 sur 30 | non concluant |
| Faim max | 47,3 % | 45,0 % | — | −8,3 pt | [−23,8 pt ; +15,0 pt] | 16 / 13 / 1 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,2 % | 0 → 0 | +0,1 pt | [+0,02 pt ; +0,3 pt] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 13,1 % | 18,3 % | — | 0,0 pt | [−0,2 pt ; +1,3 pt] | 10 / 14 / 6 sur 30 | non concluant |
| Gini moyen | 0,19 | 0,20 | 18 → 13 | +0,01 | [−0,01 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,20 | 0,15 | — | +0,001 | [−0,07 ; +0,05] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,033 % | 0,040 % | 0 → 0 | +0,013 pt | [−0,006 pt ; +0,032 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 29,6 % | 47,8 % | — | +11,2 pt | [+1,2 pt ; +20,1 pt] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| |Inflation sur 100 j| max | 140,3 % | 141,0 % | — | −1,7 pt | [−5,0 pt ; +5,3 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 9,5 | 10 | 30 → 30 | +1,5 | [−1 ; +3,5] | 11 / 16 / 3 sur 30 | non concluant |
| … dont après la chauffe | 7 | 8 | — | +1 | [−1,5 ; +3,5] | 12 / 16 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 91,5 | 78,5 | — | +7 | [−66 ; +35] | 13 / 16 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 146 | 139,5 | — | −3,5 | [−40,5 ; +5,5] | 18 / 12 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,00001 | [−0,0001 ; +0,002] | 15 / 15 / 0 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,97 | — | −0,002 | [−0,004 ; +0,001] | 10 / 20 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,3 | — | −0,01 | [−0,4 ; +0,003] | 19 / 11 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 7 / 2 / 21 sur 30 | non concluant |
| Trésor de l’État le plus bas | 27 275 $ | 52 260 $ | — | +18 297 $ | [+7 043 $ ; +37 711 $] | 23 / 7 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 2 / 1 / 27 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 27 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [−706 $ ; 0 $] | — / — / 14 | non concluant |
| Filet : Anti-famine / 50 j | 0,75 | 0,18 | 14 → 10 | −0,18 | [−2,86 ; +0,05] | 15 / 10 / 5 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 16,86 | 13,05 | 30 → 30 | −1,84 | [−3,79 ; −0,84] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 0,00 | 2,11 | 6 → 17 | +1,95 | [+0,05 ; +12,64] | 5 / 21 / 4 sur 30 | **B plus haut (moins bien)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 2 / 1 / 27 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 8 → 2 | 0 | [0 ; 0] | 7 / 2 / 21 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 8 / 1 / 21 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 21 → 17 | 0 | [−0,5 ; 0] | 10 / 5 / 15 sur 30 | non concluant |
| … jours-alerte | 3,5 | 1 | — | 0 | [−6 ; +1] | 14 / 11 / 5 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 16 → 19 | 0 | [0 ; +1] | 8 / 13 / 9 sur 30 | non concluant |
| … jours-alerte | 2,5 | 8 | — | 0 | [0 ; +2] | 8 / 13 / 9 sur 30 | non concluant |
| Inflation quotidienne | 5 | 7 | 30 → 30 | +1 | [−1 ; +3] | 11 / 16 / 3 sur 30 | non concluant |
| … jours-alerte | 5 | 7 | — | +1 | [−1 ; +3] | 11 / 16 / 3 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 28 → 30 | +0,5 | [0 ; +1] | 6 / 15 / 9 sur 30 | non concluant |
| … jours-alerte | 39 | 46 | — | +11,5 | [+0,5 ; +37] | 10 / 20 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 8 → 3 | 0 | [0 ; 0] | 7 / 1 / 22 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 2 / 21 sur 30 | non concluant |

## Avec filets, sauf « Anti-famine »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 7,1 % | 5 → 4 | −0,6 pt | [−1,5 pt ; −0,1 pt] | 20 / 10 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 18,3 % | 19,0 % | — | +2,1 pt | [−2,3 pt ; +5,2 pt] | 12 / 16 / 2 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 4 → 1 | −0,02 pt | [−0,2 pt ; +0,04 pt] | 17 / 12 / 1 sur 30 | non concluant |
| Faim max | 45,2 % | 45,0 % | — | −8,5 pt | [−34,0 pt ; +16,5 pt] | 17 / 12 / 1 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,2 % | 1 → 0 | +0,1 pt | [−0,01 pt ; +0,3 pt] | 11 / 19 / 0 sur 30 | non concluant |
| Sans-abri max | 21,3 % | 17,9 % | — | 0,0 pt | [−1,0 pt ; +0,8 pt] | 11 / 11 / 8 sur 30 | non concluant |
| Gini moyen | 0,19 | 0,20 | 17 → 13 | +0,01 | [−0,02 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,22 | 0,18 | — | −0,02 | [−0,08 ; +0,03] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,035 % | 0,040 % | 0 → 0 | +0,010 pt | [−0,009 pt ; +0,035 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 33,0 % | 45,8 % | — | +5,5 pt | [−0,1 pt ; +19,1 pt] | 10 / 20 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 141,0 % | — | −1,7 pt | [−5,0 pt ; +5,3 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 10 | 30 → 30 | +1,5 | [−2,5 ; +4] | 12 / 16 / 2 sur 30 | non concluant |
| … dont après la chauffe | 7 | 8 | — | +0,5 | [−2,5 ; +4] | 13 / 15 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 95 | 79 | — | +6,5 | [−65 ; +39,5] | 13 / 16 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 145,5 | 139 | — | −8 | [−52 ; +4,5] | 17 / 13 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | −0,000003 | [−0,0001 ; +0,0001] | 14 / 16 / 0 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,97 | — | −0,003 | [−0,004 ; −0,0002] | 9 / 21 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,3 | 0,3 | — | −0,01 | [−0,01 ; +0,001] | 20 / 10 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 7 / 1 / 22 sur 30 | non concluant |
| Trésor de l’État le plus bas | 27 275 $ | 57 414 $ | — | +15 966 $ | [+1 172 $ ; +38 976 $] | 22 / 8 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 2 / 0 / 28 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 26 | non concluant |
| Créances radiées | 706 $ | 0 $ | — | 0 $ | [−1 279 $ ; 0 $] | — / — / 12 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 16,41 | 11,95 | 30 → 30 | −2,04 | [−4,88 ; −0,80] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 0,00 | 2,11 | 6 → 17 | +1,96 | [+0,04 ; +6,45] | 5 / 20 / 5 sur 30 | **B plus haut (moins bien)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 3 → 0 | 0,00 | [0,00 ; 0,00] | 4 / 0 / 26 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 6 → 2 | 0 | [0 ; 0] | 5 / 1 / 24 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 6 / 1 / 23 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 21 → 17 | 0 | [−1 ; 0] | 11 / 6 / 13 sur 30 | non concluant |
| … jours-alerte | 3 | 1 | — | 0 | [−6 ; +1] | 14 / 11 / 5 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 18 → 19 | 0 | [−0,5 ; +0,5] | 10 / 10 / 10 sur 30 | non concluant |
| … jours-alerte | 2,5 | 8,5 | — | 0 | [0 ; +2] | 8 / 13 / 9 sur 30 | non concluant |
| Inflation quotidienne | 5 | 6 | 30 → 30 | +1 | [−1 ; +2,5] | 11 / 17 / 2 sur 30 | non concluant |
| … jours-alerte | 5 | 6 | — | +1 | [−1 ; +2,5] | 11 / 17 / 2 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 28 → 30 | 0 | [0 ; +1] | 7 / 14 / 9 sur 30 | non concluant |
| … jours-alerte | 39 | 46 | — | +11,5 | [−2 ; +37] | 11 / 19 / 0 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 8 → 3 | 0 | [0 ; 0] | 7 / 2 / 21 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 3 / 20 sur 30 | non concluant |

## Avec filets, sauf « Renflouement d’entreprise »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,8 % | 8,0 % | 7 → 5 | +0,3 pt | [−0,5 pt ; +1,2 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Chômage max | 25,0 % | 25,4 % | — | +0,4 pt | [−4,0 pt ; +2,7 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Faim moyenne | 3,5 % | 3,5 % | 29 → 27 | −0,2 pt | [−0,8 pt ; +0,4 pt] | 17 / 13 / 0 sur 30 | non concluant |
| Faim max | 94,8 % | 95,0 % | — | +0,2 pt | [−0,8 pt ; +0,8 pt] | 13 / 15 / 2 sur 30 | non concluant |
| Sans-abri moyen | 0,7 % | 1,2 % | 2 → 3 | +0,4 pt | [+0,04 pt ; +0,7 pt] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 33,8 % | 35,8 % | — | 0,0 pt | [−3,1 pt ; +4,8 pt] | 13 / 12 / 5 sur 30 | non concluant |
| Gini moyen | 0,36 | 0,34 | 2 → 1 | −0,01 | [−0,02 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,35 | 0,35 | — | +0,02 | [−0,03 ; +0,07] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,063 % | 0,060 % | 0 → 0 | −0,003 pt | [−0,015 pt ; +0,007 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 30,3 % | 35,5 % | — | +3,8 pt | [−4,7 pt ; +17,6 pt] | 12 / 18 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 140,7 % | 132,5 % | — | −6,4 pt | [−11,7 pt ; +0,2 pt] | 20 / 10 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 21 | 20 | 30 → 30 | −0,5 | [−4 ; +2] | 15 / 12 / 3 sur 30 | non concluant |
| … dont après la chauffe | 18,5 | 17,5 | — | 0 | [−4 ; +2,5] | 14 / 13 / 3 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 1418 | 1383,5 | — | −65 | [−108,5 ; −8] | 20 / 10 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 524,5 | 519 | — | −9,5 | [−98,5 ; +73,5] | 15 / 15 / 0 sur 30 | non concluant |
| Santé moyenne | 0,17 | 0,17 | — | +0,005 | [−0,02 ; +0,03] | 18 / 12 / 0 sur 30 | non concluant |
| Bonheur moyen | 0,82 | 0,82 | — | +0,001 | [−0,01 ; +0,01] | 17 / 13 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 503,5 | 511,7 | — | +33,2 | [−76,6 ; +112,8] | 13 / 17 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 7 / 1 / 22 sur 30 | non concluant |
| Trésor de l’État le plus bas | 64 904 $ | 98 210 $ | — | +34 944 $ | [+24 457 $ ; +48 271 $] | 22 / 8 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [−103,5 ; 0] | 12 / 8 / 10 sur 30 | non concluant |
| Prêts refusés | 3,5 | 2,5 | — | 0 | [−15,5 ; +23] | — / — / 5 | non concluant |
| Créances radiées | 24 484 $ | 24 472 $ | — | +957 $ | [−6 808 $ ; +7 135 $] | — / — / 0 | non concluant |
| Filet : Anti-famine / 50 j | 109,54 | 112,75 | 30 → 30 | −6,11 | [−26,66 ; +26,75] | 18 / 12 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 5,75 | 28,46 | 25 → 30 | +18,91 | [+6,20 ; +30,84] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,13 | 0,09 | 8 → 12 | 0,00 | [−0,55 ; +0,82] | 13 / 12 / 5 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 5 → 3 | 0 | [0 ; 0] | 5 / 3 / 22 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 5 / 3 / 22 sur 30 | non concluant |
| Faim répandue | 6 | 6 | 30 → 30 | 0 | [−1,5 ; +1] | 13 / 11 / 6 sur 30 | non concluant |
| … jours-alerte | 100,5 | 108 | — | −7 | [−22 ; +15] | 17 / 12 / 1 sur 30 | non concluant |
| Sans-abri nombreux | 3 | 4 | 28 → 29 | 0 | [−2 ; +2] | 14 / 14 / 2 sur 30 | non concluant |
| … jours-alerte | 32 | 25,5 | — | −10 | [−17,5 ; +9] | 17 / 13 / 0 sur 30 | non concluant |
| Inflation quotidienne | 8 | 8 | 30 → 30 | 0 | [−2 ; +0,5] | 14 / 10 / 6 sur 30 | non concluant |
| … jours-alerte | 8 | 8 | — | 0 | [−2 ; 0] | 14 / 9 / 7 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 29 → 30 | 0 | [−1 ; +1] | 13 / 11 / 6 sur 30 | non concluant |
| … jours-alerte | 37 | 32 | — | −4 | [−16 ; +13] | 17 / 12 / 1 sur 30 | non concluant |
| Santé de la population effondrée | 1 | 1 | 30 → 30 | 0 | [0 ; 0] | 3 / 2 / 25 sur 30 | non concluant |
| … jours-alerte | 1209,5 | 1205,5 | — | −8,5 | [−68 ; +6] | 17 / 12 / 1 sur 30 | non concluant |

## Avec filets, sauf « Plancher de logement »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,1 % | 7,0 % | 4 → 7 | −0,6 pt | [−1,4 pt ; +0,5 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Chômage max | 19,2 % | 18,8 % | — | −0,8 pt | [−3,3 pt ; +2,7 pt] | 15 / 13 / 2 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,0 % | 0 → 0 | −0,1 pt | [−0,2 pt ; +0,003 pt] | 19 / 10 / 1 sur 30 | non concluant |
| Faim max | 49,2 % | 16,7 % | — | −28,7 pt | [−41,7 pt ; −5,2 pt] | 21 / 8 / 1 sur 30 | **B plus bas (mieux)** |
| Sans-abri moyen | 0,0 % | 0,3 % | 0 → 4 | +0,3 pt | [+0,1 pt ; +0,5 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 16,5 % | 17,1 % | — | 0,0 pt | [−1,5 pt ; +1,3 pt] | 10 / 13 / 7 sur 30 | non concluant |
| Gini moyen | 0,19 | 0,21 | 17 → 12 | +0,01 | [−0,01 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,19 | 0,19 | — | +0,01 | [−0,02 ; +0,04] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,035 % | 0,041 % | 0 → 0 | +0,001 pt | [−0,011 pt ; +0,030 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 38,1 % | 40,8 % | — | +5,5 pt | [−3,5 pt ; +14,2 pt] | 13 / 17 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 139,7 % | — | −3,3 pt | [−7,0 pt ; +0,7 pt] | 20 / 10 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 10,5 | 11,5 | 30 → 30 | +2 | [+0,5 ; +3] | 8 / 20 / 2 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 7,5 | 10 | — | +1,5 | [0 ; +4] | 9 / 19 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 106,5 | 102 | — | −24,5 | [−92,5 ; +15,5] | 16 / 14 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 147 | 138,5 | — | −1 | [−11 ; +10,5] | 15 / 13 / 2 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,00003 | [−0,00002 ; +0,001] | 18 / 12 / 0 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,97 | — | −0,002 | [−0,004 ; +0,001] | 10 / 20 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,3 | — | −0,01 | [−0,2 ; +0,003] | 19 / 11 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 8 / 3 / 19 sur 30 | non concluant |
| Trésor de l’État le plus bas | 20 159 $ | 56 168 $ | — | +24 181 $ | [+12 543 $ ; +44 584 $] | 23 / 7 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 895 $ | 0 $ | — | 0 $ | [−895 $ ; 0 $] | — / — / 10 | non concluant |
| Filet : Anti-famine / 50 j | 1,04 | 0,00 | 15 → 9 | −0,38 | [−2,91 ; 0,00] | 17 / 8 / 5 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 16,21 | 16,59 | 30 → 30 | +0,39 | [−2,43 ; +5,23] | 15 / 15 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 1 | 0,00 | [0,00 ; 0,00] | 0 / 1 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 7 → 3 | 0 | [0 ; 0] | 7 / 3 / 20 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 3 / 20 sur 30 | non concluant |
| Faim répandue | 1 | 0 | 22 → 14 | 0 | [−1 ; 0] | 12 / 6 / 12 sur 30 | non concluant |
| … jours-alerte | 4,5 | 0 | — | −2,5 | [−7,5 ; 0] | 16 / 8 / 6 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 16 → 23 | +1 | [0 ; +1] | 4 / 18 / 8 sur 30 | non concluant |
| … jours-alerte | 2,5 | 8,5 | — | +1,5 | [0 ; +34,5] | 7 / 19 / 4 sur 30 | non concluant |
| Inflation quotidienne | 5,5 | 7 | 30 → 30 | +1 | [0 ; +2] | 9 / 18 / 3 sur 30 | non concluant |
| … jours-alerte | 5,5 | 7 | — | +1 | [0 ; +2] | 9 / 18 / 3 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 28 → 30 | 0 | [−0,5 ; +1] | 10 / 14 / 6 sur 30 | non concluant |
| … jours-alerte | 48 | 41 | — | +2,5 | [−17,5 ; +11,5] | 13 / 17 / 0 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 9 → 4 | 0 | [0 ; 0] | 7 / 2 / 21 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 9 / 2 / 19 sur 30 | non concluant |

## Avec filets, sauf « Plafond de dérive des prix et salaires »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 7,0 % | 8 → 5 | −0,6 pt | [−2,0 pt ; −0,4 pt] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 18,3 % | 19,0 % | — | +0,8 pt | [−2,9 pt ; +4,4 pt] | 13 / 15 / 2 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 0 | −0,03 pt | [−0,2 pt ; +0,02 pt] | 18 / 11 / 1 sur 30 | non concluant |
| Faim max | 47,3 % | 45,0 % | — | −8,3 pt | [−23,8 pt ; +15,0 pt] | 16 / 13 / 1 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,2 % | 0 → 0 | +0,1 pt | [+0,02 pt ; +0,3 pt] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 13,1 % | 18,3 % | — | 0,0 pt | [−0,2 pt ; +1,3 pt] | 10 / 14 / 6 sur 30 | non concluant |
| Gini moyen | 0,19 | 0,20 | 18 → 13 | +0,01 | [−0,01 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,20 | 0,15 | — | +0,001 | [−0,07 ; +0,05] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,033 % | 0,040 % | 0 → 0 | +0,013 pt | [−0,006 pt ; +0,032 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 29,6 % | 47,8 % | — | +11,2 pt | [+1,2 pt ; +20,1 pt] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| |Inflation sur 100 j| max | 140,3 % | 141,0 % | — | −1,7 pt | [−5,0 pt ; +5,3 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 9,5 | 10 | 30 → 30 | +1,5 | [−1 ; +3,5] | 11 / 16 / 3 sur 30 | non concluant |
| … dont après la chauffe | 7 | 8 | — | +1 | [−1,5 ; +3,5] | 12 / 16 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 91,5 | 78,5 | — | +7 | [−66 ; +35] | 13 / 16 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 146 | 139,5 | — | −3,5 | [−40,5 ; +5,5] | 18 / 12 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,00001 | [−0,0001 ; +0,002] | 15 / 15 / 0 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,97 | — | −0,002 | [−0,004 ; +0,001] | 10 / 20 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,3 | — | −0,01 | [−0,4 ; +0,003] | 19 / 11 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 7 / 2 / 21 sur 30 | non concluant |
| Trésor de l’État le plus bas | 27 275 $ | 52 260 $ | — | +18 297 $ | [+7 043 $ ; +37 711 $] | 23 / 7 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 2 / 1 / 27 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 27 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [−706 $ ; 0 $] | — / — / 14 | non concluant |
| Filet : Anti-famine / 50 j | 0,75 | 0,18 | 14 → 10 | −0,18 | [−2,86 ; +0,05] | 15 / 10 / 5 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 16,86 | 13,05 | 30 → 30 | −1,84 | [−3,79 ; −0,84] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 0,00 | 2,11 | 6 → 17 | +1,95 | [+0,05 ; +12,64] | 5 / 21 / 4 sur 30 | **B plus haut (moins bien)** |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 2 / 1 / 27 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 8 → 2 | 0 | [0 ; 0] | 7 / 2 / 21 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 8 / 1 / 21 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 21 → 17 | 0 | [−0,5 ; 0] | 10 / 5 / 15 sur 30 | non concluant |
| … jours-alerte | 3,5 | 1 | — | 0 | [−6 ; +1] | 14 / 11 / 5 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 16 → 19 | 0 | [0 ; +1] | 8 / 13 / 9 sur 30 | non concluant |
| … jours-alerte | 2,5 | 8 | — | 0 | [0 ; +2] | 8 / 13 / 9 sur 30 | non concluant |
| Inflation quotidienne | 5 | 7 | 30 → 30 | +1 | [−1 ; +3] | 11 / 16 / 3 sur 30 | non concluant |
| … jours-alerte | 5 | 7 | — | +1 | [−1 ; +3] | 11 / 16 / 3 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 28 → 30 | +0,5 | [0 ; +1] | 6 / 15 / 9 sur 30 | non concluant |
| … jours-alerte | 39 | 46 | — | +11,5 | [+0,5 ; +37] | 10 / 20 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 8 → 3 | 0 | [0 ; 0] | 7 / 1 / 22 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 2 / 21 sur 30 | non concluant |

## Avec filets, sauf « Anti-crédit-fou »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 7,0 % | 8 → 5 | −0,6 pt | [−2,0 pt ; −0,4 pt] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 18,3 % | 19,0 % | — | +0,8 pt | [−2,9 pt ; +4,4 pt] | 13 / 15 / 2 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 0 | −0,03 pt | [−0,2 pt ; +0,02 pt] | 18 / 11 / 1 sur 30 | non concluant |
| Faim max | 47,3 % | 45,0 % | — | −8,3 pt | [−23,8 pt ; +15,0 pt] | 16 / 13 / 1 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,2 % | 0 → 0 | +0,1 pt | [+0,02 pt ; +0,3 pt] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 13,1 % | 18,3 % | — | 0,0 pt | [−0,2 pt ; +1,3 pt] | 10 / 14 / 6 sur 30 | non concluant |
| Gini moyen | 0,19 | 0,20 | 18 → 13 | +0,01 | [−0,01 ; +0,02] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,20 | 0,15 | — | +0,001 | [−0,08 ; +0,05] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,033 % | 0,040 % | 0 → 0 | +0,013 pt | [−0,006 pt ; +0,034 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 29,8 % | 47,8 % | — | +10,8 pt | [+1,2 pt ; +20,1 pt] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| |Inflation sur 100 j| max | 140,3 % | 141,0 % | — | −1,7 pt | [−5,0 pt ; +5,3 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 9,5 | 10 | 30 → 30 | +1,5 | [−1 ; +3,5] | 11 / 16 / 3 sur 30 | non concluant |
| … dont après la chauffe | 7 | 8 | — | +1 | [−1,5 ; +3,5] | 12 / 16 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 91,5 | 78,5 | — | +7 | [−66 ; +35] | 13 / 16 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 146 | 139,5 | — | −3,5 | [−38 ; +5,5] | 18 / 12 / 0 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,00001 | [−0,0001 ; +0,002] | 15 / 15 / 0 sur 30 | non concluant |
| Bonheur moyen | 0,98 | 0,97 | — | −0,002 | [−0,004 ; +0,001] | 10 / 20 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,3 | — | −0,01 | [−0,4 ; +0,003] | 19 / 11 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 7 / 2 / 21 sur 30 | non concluant |
| Trésor de l’État le plus bas | 27 275 $ | 52 260 $ | — | +18 297 $ | [+7 043 $ ; +37 711 $] | 23 / 7 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 2 / 1 / 27 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [−706 $ ; 0 $] | — / — / 14 | non concluant |
| Filet : Anti-famine / 50 j | 0,75 | 0,18 | 14 → 10 | −0,18 | [−2,86 ; +0,05] | 15 / 10 / 5 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 16,86 | 13,05 | 30 → 30 | −1,84 | [−3,79 ; −0,84] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 0,00 | 2,11 | 6 → 17 | +1,95 | [+0,05 ; +12,64] | 5 / 21 / 4 sur 30 | **B plus haut (moins bien)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 7 → 2 | 0 | [0 ; 0] | 6 / 2 / 22 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 1 / 22 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 21 → 17 | 0 | [−0,5 ; 0] | 10 / 5 / 15 sur 30 | non concluant |
| … jours-alerte | 3,5 | 1 | — | 0 | [−6 ; +1] | 14 / 11 / 5 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 16 → 19 | 0 | [0 ; +1] | 8 / 13 / 9 sur 30 | non concluant |
| … jours-alerte | 2,5 | 8 | — | 0 | [0 ; +2] | 8 / 13 / 9 sur 30 | non concluant |
| Inflation quotidienne | 5 | 7 | 30 → 30 | +1 | [−1 ; +3] | 11 / 16 / 3 sur 30 | non concluant |
| … jours-alerte | 5 | 7 | — | +1 | [−1 ; +3] | 11 / 16 / 3 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 28 → 30 | +1 | [0 ; +1] | 6 / 16 / 8 sur 30 | non concluant |
| … jours-alerte | 39 | 50,5 | — | +11,5 | [+0,5 ; +37] | 10 / 20 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 8 → 3 | 0 | [0 ; 0] | 7 / 1 / 22 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 2 / 21 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Sans-abri moyen : +1,1 pt [+0,1 pt ; +1,5 pt], B moins bien (10 graines mieux, 20 moins bien, 0 égales)
- Sans filets — Trésor de l’État le plus bas : +23 709 $ [+19 364 $ ; +42 784 $], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Sans filets — Sans-abri nombreux : jours-alerte : +35,5 [+20 ; +88,5], B moins bien (6 graines mieux, 24 moins bien, 0 égales)
- Avec filets — Chômage moyen : −0,6 pt [−2,0 pt ; −0,4 pt], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Sans-abri moyen : +0,1 pt [+0,02 pt ; +0,3 pt], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets — |Inflation| max / j : +11,2 pt [+1,2 pt ; +20,1 pt], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets — Trésor de l’État le plus bas : +18 297 $ [+7 043 $ ; +37 711 $], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets — Filet : Renflouement d’entreprise / 50 j : −1,84 [−3,79 ; −0,84], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets — Filet : Plancher de logement / 50 j : +1,95 [+0,05 ; +12,64], B moins bien (5 graines mieux, 21 moins bien, 4 égales)
- Avec filets — Inflation sur 100 jours : jours-alerte : +11,5 [+0,5 ; +37], B moins bien (10 graines mieux, 20 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Chômage moyen : −0,6 pt [−1,5 pt ; −0,1 pt], B mieux (20 graines mieux, 10 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Bonheur moyen : −0,003 [−0,004 ; −0,0002], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Trésor de l’État le plus bas : +15 966 $ [+1 172 $ ; +38 976 $], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Filet : Renflouement d’entreprise / 50 j : −2,04 [−4,88 ; −0,80], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Filet : Plancher de logement / 50 j : +1,96 [+0,04 ; +6,45], B moins bien (5 graines mieux, 20 moins bien, 5 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Sans-abri moyen : +0,4 pt [+0,04 pt ; +0,7 pt], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Jours-alerte critiques (somme des types) : −65 [−108,5 ; −8], B mieux (20 graines mieux, 10 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Trésor de l’État le plus bas : +34 944 $ [+24 457 $ ; +48 271 $], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Filet : Plancher de logement / 50 j : +18,91 [+6,20 ; +30,84], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Faim max : −28,7 pt [−41,7 pt ; −5,2 pt], B mieux (21 graines mieux, 8 moins bien, 1 égales)
- Avec filets, sauf « Plancher de logement » — Sans-abri moyen : +0,3 pt [+0,1 pt ; +0,5 pt], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Alertes critiques ouvertes : +2 [+0,5 ; +3], B moins bien (8 graines mieux, 20 moins bien, 2 égales)
- Avec filets, sauf « Plancher de logement » — Trésor de l’État le plus bas : +24 181 $ [+12 543 $ ; +44 584 $], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Chômage moyen : −0,6 pt [−2,0 pt ; −0,4 pt], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Sans-abri moyen : +0,1 pt [+0,02 pt ; +0,3 pt], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — |Inflation| max / j : +11,2 pt [+1,2 pt ; +20,1 pt], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Trésor de l’État le plus bas : +18 297 $ [+7 043 $ ; +37 711 $], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Filet : Renflouement d’entreprise / 50 j : −1,84 [−3,79 ; −0,84], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Filet : Plancher de logement / 50 j : +1,95 [+0,05 ; +12,64], B moins bien (5 graines mieux, 21 moins bien, 4 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Inflation sur 100 jours : jours-alerte : +11,5 [+0,5 ; +37], B moins bien (10 graines mieux, 20 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Chômage moyen : −0,6 pt [−2,0 pt ; −0,4 pt], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Sans-abri moyen : +0,1 pt [+0,02 pt ; +0,3 pt], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — |Inflation| max / j : +10,8 pt [+1,2 pt ; +20,1 pt], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Trésor de l’État le plus bas : +18 297 $ [+7 043 $ ; +37 711 $], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Filet : Renflouement d’entreprise / 50 j : −1,84 [−3,79 ; −0,84], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Filet : Plancher de logement / 50 j : +1,95 [+0,05 ; +12,64], B moins bien (5 graines mieux, 21 moins bien, 4 égales)
- Avec filets, sauf « Anti-crédit-fou » — Inflation sur 100 jours : jours-alerte : +11,5 [+0,5 ; +37], B moins bien (10 graines mieux, 20 moins bien, 0 égales)

