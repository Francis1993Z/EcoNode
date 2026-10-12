# Comparaison appariée ÉcoNodes

- Date : 2026-10-11 20:35
- A : `tache4-ref.json`
- A — Modules coupés : aucun
- B : `tache4-a2.json`
- B — Modules coupés : aucun
- B — Paramètres changés : partTime = 1
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,0 % | 8,6 % | 4 → 11 | +0,3 pt | [−0,4 pt ; +2,3 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Chômage max | 27,1 % | 24,6 % | — | −1,5 pt | [−5,6 pt ; +1,9 pt] | 16 / 11 / 3 sur 30 | non concluant |
| Faim moyenne | 6,1 % | 0,1 % | 29 → 0 | −6,0 pt | [−7,5 pt ; −4,9 pt] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Faim max | 95,4 % | 31,7 % | — | −60,8 pt | [−94,0 pt ; −48,1 pt] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Sans-abri moyen | 2,6 % | 0,4 % | 19 → 3 | −1,7 pt | [−2,5 pt ; −1,3 pt] | 28 / 2 / 0 sur 30 | **B plus bas (mieux)** |
| Sans-abri max | 42,9 % | 30,4 % | — | −10,6 pt | [−26,0 pt ; 0,0 pt] | 19 / 8 / 3 sur 30 | non concluant |
| Gini moyen | 0,35 | 0,28 | 3 → 0 | −0,07 | [−0,12 ; −0,04] | — / — / 0 | **B plus bas** |
| Gini en fin de partie | 0,43 | 0,29 | — | −0,09 | [−0,22 ; +0,01] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,071 % | -0,054 % | 0 → 0 | −0,124 pt | [−0,129 pt ; −0,115 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 36,6 % | 34,4 % | — | −10,0 pt | [−18,2 pt ; +2,8 pt] | 17 / 13 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 136,1 % | 108,7 % | — | −28,3 pt | [−34,0 pt ; −21,6 pt] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes critiques ouvertes | 27,5 | 16,5 | 30 → 30 | −10,5 | [−13 ; −3,5] | 24 / 6 / 0 sur 30 | **B plus bas (mieux)** |
| … dont après la chauffe | 24,5 | 14,5 | — | −9,5 | [−13 ; −3] | 22 / 7 / 1 sur 30 | **B plus bas (mieux)** |
| Jours-alerte critiques (somme des types) | 1524,5 | 71 | — | −1440 | [−1488,5 ; −1368,5] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 509 | 381,5 | — | −82 | [−199 ; −17,5] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Santé moyenne | 0,18 | 0,88 | — | +0,70 | [+0,67 ; +0,73] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Types d’entreprise actifs en fin | 13 | 28 | — | +15 | [+13,5 ; +15,5] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Machines en fin | 0,2 | 362,4 | — | +362,3 | [+303,2 ; +394,1] | 29 / 1 / 0 sur 30 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 1 | 3 | — | +2 | [+1 ; +3,5] | 3 / 23 / 4 sur 30 | **B plus haut (moins bien)** |
| Bonheur moyen | 0,81 | 0,97 | — | +0,15 | [+0,15 ; +0,16] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Hôpital public : attente moyenne (j) | 512,9 | 0,4 | — | −512,5 | [−567,9 ; −427,6] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 4 / 1 / 25 sur 30 | non concluant |
| Trésor de l’État le plus bas | 90 804 $ | 79 907 $ | — | −2 181 $ | [−27 703 $ ; +6 480 $] | 14 / 16 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 4 / 7 / 19 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 16 | non concluant |
| Créances radiées | 18 445 $ | 16 078 $ | — | −3 686 $ | [−9 567 $ ; +3 649 $] | — / — / 0 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 6 → 6 | 0 | [0 ; 0] | 4 / 6 / 20 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 5 / 5 / 20 sur 30 | non concluant |
| Faim répandue | 5 | 1 | 30 → 18 | −4 | [−5 ; −4] | 29 / 0 / 1 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 130,5 | 2 | — | −127,5 | [−151,5 ; −100] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Sans-abri nombreux | 11 | 3 | 30 → 28 | −8 | [−9 ; −4] | 26 / 3 / 1 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 159 | 36 | — | −98,5 | [−128,5 ; −60,5] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 7 | 10,5 | 30 → 29 | +4,5 | [+3 ; +5,5] | 6 / 23 / 1 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 7 | 10,5 | — | +5 | [+3 ; +6] | 6 / 23 / 1 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 2 | 2 | 30 → 28 | 0 | [−0,5 ; 0] | 10 / 9 / 11 sur 30 | non concluant |
| … jours-alerte | 37,5 | 10 | — | −24 | [−47,5 ; −15,5] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |
| Santé de la population effondrée | 1 | 0 | 30 → 1 | −1 | [−1 ; −1] | 29 / 0 / 1 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 1207 | 0 | — | −1207 | [−1228,5 ; −1136,5] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 8,6 % | 5 → 10 | +1,5 pt | [+0,6 pt ; +3,6 pt] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 19,0 % | 24,8 % | — | +6,0 pt | [+1,5 pt ; +10,8 pt] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,1 % | 0,0 % | 0 → 0 | −0,05 pt | [−0,1 pt ; −0,01 pt] | 20 / 5 / 5 sur 30 | **B plus bas (mieux)** |
| Faim max | 45,0 % | 0,0 % | — | −26,7 pt | [−49,0 pt ; −11,0 pt] | 22 / 4 / 4 sur 30 | **B plus bas (mieux)** |
| Sans-abri moyen | 0,2 % | 0,4 % | 0 → 3 | +0,1 pt | [−0,1 pt ; +0,3 pt] | 11 / 19 / 0 sur 30 | non concluant |
| Sans-abri max | 18,3 % | 30,6 % | — | +5,2 pt | [0,0 pt ; +14,6 pt] | 7 / 19 / 4 sur 30 | non concluant |
| Gini moyen | 0,20 | 0,25 | 13 → 1 | +0,04 | [+0,03 ; +0,07] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,15 | 0,29 | — | +0,11 | [+0,08 ; +0,15] | — / — / 0 | **B plus haut** |
| Inflation moyenne / j | 0,040 % | -0,043 % | 0 → 0 | −0,069 pt | [−0,101 pt ; −0,061 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 47,8 % | 34,6 % | — | −13,2 pt | [−19,7 pt ; −3,7 pt] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| |Inflation sur 100 j| max | 141,0 % | 106,0 % | — | −34,6 pt | [−40,3 pt ; −32,1 pt] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes critiques ouvertes | 10 | 16 | 30 → 30 | +5,5 | [+1 ; +9] | 8 / 20 / 2 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 8 | 14 | — | +6 | [+2 ; +9] | 6 / 22 / 2 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 78,5 | 56 | — | +1 | [−36 ; +42] | 15 / 15 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 139,5 | 303 | — | +156,5 | [+113,5 ; +183,5] | 2 / 28 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,88 | — | −0,0002 | [−0,001 ; −0,00004] | 10 / 20 / 0 sur 30 | **B plus bas (moins bien)** |
| Types d’entreprise actifs en fin | 20 | 29 | — | +9 | [+7,5 ; +10] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Machines en fin | 2,6 | 363,8 | — | +355,4 | [+299,4 ; +393,9] | 28 / 2 / 0 sur 30 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 3 | 3,5 | — | +1 | [−1,5 ; +3] | 12 / 16 / 2 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | −0,002 | [−0,01 ; +0,00003] | 11 / 19 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,3 | 0,4 | — | +0,1 | [+0,02 ; +0,2] | 6 / 24 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 6 / 22 sur 30 | non concluant |
| Trésor de l’État le plus bas | 52 260 $ | 63 159 $ | — | −1 366 $ | [−12 912 $ ; +16 853 $] | 14 / 16 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 1 / 28 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 28 | non concluant |
| Créances radiées | 0 $ | 5 123 $ | — | +4 050 $ | [+1 488 $ ; +6 292 $] | — / — / 2 | **B plus haut** |
| Filet : Anti-famine / 50 j | 0,18 | 0,00 | 10 → 5 | −0,11 | [−0,89 ; 0,00] | 17 / 5 / 8 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,05 | 5,16 | 30 → 30 | −7,84 | [−9,59 ; −6,43] | 28 / 2 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 2,11 | 3,80 | 17 → 21 | −0,20 | [−5,21 ; +2,13] | 17 / 13 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 1 / 1 / 28 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 2 → 10 | 0 | [0 ; +0,5] | 2 / 10 / 18 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; +5] | 2 / 10 / 18 sur 30 | non concluant |
| Faim répandue | 1 | 0 | 17 → 8 | 0 | [−1 ; 0] | 14 / 4 / 12 sur 30 | non concluant |
| … jours-alerte | 1 | 0 | — | −0,5 | [−3 ; 0] | 15 / 5 / 10 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 2 | 19 → 29 | +1,5 | [0 ; +2] | 7 / 19 / 4 sur 30 | non concluant |
| … jours-alerte | 8 | 26,5 | — | +14,5 | [+6,5 ; +22] | 5 / 23 / 2 sur 30 | **B plus haut (moins bien)** |
| Inflation quotidienne | 7 | 11 | 30 → 30 | +5,5 | [+3 ; +6] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 7 | 11 | — | +5,5 | [+3 ; +6] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 2 | 1 | 30 → 24 | −1 | [−1 ; −1] | 23 / 4 / 3 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 50,5 | 9 | — | −38 | [−75 ; −31] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Santé de la population effondrée | 0 | 0 | 3 → 5 | 0 | [0 ; 0] | 3 / 5 / 22 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 5 / 22 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Faim moyenne : −6,0 pt [−7,5 pt ; −4,9 pt], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Faim max : −60,8 pt [−94,0 pt ; −48,1 pt], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Sans-abri moyen : −1,7 pt [−2,5 pt ; −1,3 pt], B mieux (28 graines mieux, 2 moins bien, 0 égales)
- Sans filets — Gini moyen : −0,07 [−0,12 ; −0,04] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Inflation moyenne / j : −0,124 pt [−0,129 pt ; −0,115 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — |Inflation sur 100 j| max : −28,3 pt [−34,0 pt ; −21,6 pt], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Sans filets — Alertes critiques ouvertes : −10,5 [−13 ; −3,5], B mieux (24 graines mieux, 6 moins bien, 0 égales)
- Sans filets — dont après la chauffe (criticalSteady) : −9,5 [−13 ; −3], B mieux (22 graines mieux, 7 moins bien, 1 égales)
- Sans filets — Jours-alerte critiques (somme des types) : −1440 [−1488,5 ; −1368,5], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Alertes ouvertes (toutes) : −82 [−199 ; −17,5], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Sans filets — Santé moyenne : +0,70 [+0,67 ; +0,73], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Types d’entreprise actifs en fin : +15 [+13,5 ; +15,5], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Machines en fin : +362,3 [+303,2 ; +394,1], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Sans filets — Équipes utilisées à moins de 15 % (fin) : +2 [+1 ; +3,5], B moins bien (3 graines mieux, 23 moins bien, 4 égales)
- Sans filets — Bonheur moyen : +0,15 [+0,15 ; +0,16], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Hôpital public : attente moyenne (j) : −512,5 [−567,9 ; −427,6], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Faim répandue : −4 [−5 ; −4], B mieux (29 graines mieux, 0 moins bien, 1 égales)
- Sans filets — Faim répandue : jours-alerte : −127,5 [−151,5 ; −100], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Sans-abri nombreux : −8 [−9 ; −4], B mieux (26 graines mieux, 3 moins bien, 1 égales)
- Sans filets — Sans-abri nombreux : jours-alerte : −98,5 [−128,5 ; −60,5], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Sans filets — Inflation quotidienne : +4,5 [+3 ; +5,5], B moins bien (6 graines mieux, 23 moins bien, 1 égales)
- Sans filets — Inflation quotidienne : jours-alerte : +5 [+3 ; +6], B moins bien (6 graines mieux, 23 moins bien, 1 égales)
- Sans filets — Inflation sur 100 jours : jours-alerte : −24 [−47,5 ; −15,5], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Sans filets — Santé de la population effondrée : −1 [−1 ; −1], B mieux (29 graines mieux, 0 moins bien, 1 égales)
- Sans filets — Santé de la population effondrée : jours-alerte : −1207 [−1228,5 ; −1136,5], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Chômage moyen : +1,5 pt [+0,6 pt ; +3,6 pt], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets — Chômage max : +6,0 pt [+1,5 pt ; +10,8 pt], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets — Faim moyenne : −0,05 pt [−0,1 pt ; −0,01 pt], B mieux (20 graines mieux, 5 moins bien, 5 égales)
- Avec filets — Faim max : −26,7 pt [−49,0 pt ; −11,0 pt], B mieux (22 graines mieux, 4 moins bien, 4 égales)
- Avec filets — Gini moyen : +0,04 [+0,03 ; +0,07] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Gini en fin de partie : +0,11 [+0,08 ; +0,15] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Inflation moyenne / j : −0,069 pt [−0,101 pt ; −0,061 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — |Inflation| max / j : −13,2 pt [−19,7 pt ; −3,7 pt], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets — |Inflation sur 100 j| max : −34,6 pt [−40,3 pt ; −32,1 pt], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Alertes critiques ouvertes : +5,5 [+1 ; +9], B moins bien (8 graines mieux, 20 moins bien, 2 égales)
- Avec filets — dont après la chauffe (criticalSteady) : +6 [+2 ; +9], B moins bien (6 graines mieux, 22 moins bien, 2 égales)
- Avec filets — Alertes ouvertes (toutes) : +156,5 [+113,5 ; +183,5], B moins bien (2 graines mieux, 28 moins bien, 0 égales)
- Avec filets — Santé moyenne : −0,0002 [−0,001 ; −0,00004], B moins bien (10 graines mieux, 20 moins bien, 0 égales)
- Avec filets — Types d’entreprise actifs en fin : +9 [+7,5 ; +10], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Machines en fin : +355,4 [+299,4 ; +393,9], B mieux (28 graines mieux, 2 moins bien, 0 égales)
- Avec filets — Hôpital public : attente moyenne (j) : +0,1 [+0,02 ; +0,2], B moins bien (6 graines mieux, 24 moins bien, 0 égales)
- Avec filets — Créances radiées : +4 050 $ [+1 488 $ ; +6 292 $] (0 graines mieux, 0 moins bien, 2 égales)
- Avec filets — Filet : Renflouement d’entreprise / 50 j : −7,84 [−9,59 ; −6,43], B mieux (28 graines mieux, 2 moins bien, 0 égales)
- Avec filets — Sans-abri nombreux : jours-alerte : +14,5 [+6,5 ; +22], B moins bien (5 graines mieux, 23 moins bien, 2 égales)
- Avec filets — Inflation quotidienne : +5,5 [+3 ; +6], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets — Inflation quotidienne : jours-alerte : +5,5 [+3 ; +6], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets — Inflation sur 100 jours : −1 [−1 ; −1], B mieux (23 graines mieux, 4 moins bien, 3 égales)
- Avec filets — Inflation sur 100 jours : jours-alerte : −38 [−75 ; −31], B mieux (29 graines mieux, 1 moins bien, 0 égales)

