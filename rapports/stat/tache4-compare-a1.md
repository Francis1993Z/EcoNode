# Comparaison appariée ÉcoNodes

- Date : 2026-10-11 20:34
- A : `tache4-ref.json`
- A — Modules coupés : aucun
- B : `tache4-a1.json`
- B — Modules coupés : aucun
- B — Paramètres changés : healthWearIfDeprived = 1
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,0 % | 9,5 % | 4 → 13 | +0,9 pt | [−0,4 pt ; +4,1 pt] | 11 / 19 / 0 sur 30 | non concluant |
| Chômage max | 27,1 % | 25,4 % | — | −2,3 pt | [−6,5 pt ; +3,7 pt] | 16 / 13 / 1 sur 30 | non concluant |
| Faim moyenne | 6,1 % | 1,6 % | 29 → 13 | −4,0 pt | [−5,2 pt ; −2,8 pt] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Faim max | 95,4 % | 79,0 % | — | −13,1 pt | [−20,0 pt ; −6,9 pt] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Sans-abri moyen | 2,6 % | 1,1 % | 19 → 9 | −1,3 pt | [−1,9 pt ; −0,5 pt] | 24 / 6 / 0 sur 30 | **B plus bas (mieux)** |
| Sans-abri max | 42,9 % | 53,3 % | — | +0,6 pt | [−2,3 pt ; +1,9 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Gini moyen | 0,35 | 0,26 | 3 → 0 | −0,09 | [−0,14 ; −0,06] | — / — / 0 | **B plus bas** |
| Gini en fin de partie | 0,43 | 0,25 | — | −0,12 | [−0,25 ; +0,005] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,071 % | 0,046 % | 0 → 0 | −0,018 pt | [−0,052 pt ; −0,006 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 36,6 % | 40,8 % | — | +0,1 pt | [−7,3 pt ; +8,0 pt] | 15 / 15 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 136,1 % | 113,2 % | — | −23,4 pt | [−26,3 pt ; −10,9 pt] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes critiques ouvertes | 27,5 | 25 | 30 → 30 | −4 | [−6,5 ; −0,5] | 20 / 9 / 1 sur 30 | **B plus bas (mieux)** |
| … dont après la chauffe | 24,5 | 22 | — | −3,5 | [−6,5 ; +1,5] | 19 / 10 / 1 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 1524,5 | 903,5 | — | −615,5 | [−807 ; −464,5] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 509 | 551,5 | — | +69 | [−23 ; +111] | 11 / 19 / 0 sur 30 | non concluant |
| Santé moyenne | 0,18 | 0,56 | — | +0,36 | [+0,30 ; +0,48] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Types d’entreprise actifs en fin | 13 | 17 | — | +3,5 | [+1,5 ; +6,5] | 22 / 8 / 0 sur 30 | **B plus haut (mieux)** |
| Machines en fin | 0,2 | 0,5 | — | +0,4 | [+0,2 ; +2,1] | 25 / 5 / 0 sur 30 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 1 | 1,5 | — | +1 | [0 ; +1] | 3 / 16 / 11 sur 30 | non concluant |
| Bonheur moyen | 0,81 | 0,90 | — | +0,09 | [+0,07 ; +0,10] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Hôpital public : attente moyenne (j) | 512,9 | 263,8 | — | −221,7 | [−319,4 ; −159,4] | 26 / 4 / 0 sur 30 | **B plus bas (mieux)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 3 / 6 / 21 sur 30 | non concluant |
| Trésor de l’État le plus bas | 90 804 $ | 69 905 $ | — | −12 140 $ | [−22 567 $ ; +14 116 $] | 12 / 18 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 5 / 7 / 18 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; +21,5] | — / — / 13 | non concluant |
| Créances radiées | 18 445 $ | 20 941 $ | — | −2 911 $ | [−7 486 $ ; +5 344 $] | — / — / 0 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 6 → 8 | 0 | [0 ; 0] | 4 / 8 / 18 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 4 / 8 / 18 sur 30 | non concluant |
| Faim répandue | 5 | 3 | 30 → 29 | −2 | [−4 ; −1] | 21 / 4 / 5 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 130,5 | 37,5 | — | −74,5 | [−110,5 ; −58] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Sans-abri nombreux | 11 | 6,5 | 30 → 30 | −4 | [−5,5 ; −2,5] | 25 / 5 / 0 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 159 | 72 | — | −56 | [−86 ; +12] | 20 / 10 / 0 sur 30 | non concluant |
| Inflation quotidienne | 7 | 8,5 | 30 → 30 | +2 | [0 ; +4] | 9 / 20 / 1 sur 30 | non concluant |
| … jours-alerte | 7 | 8,5 | — | +2 | [0 ; +4] | 9 / 20 / 1 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 30 → 28 | 0 | [−1 ; +0,5] | 11 / 10 / 9 sur 30 | non concluant |
| … jours-alerte | 37,5 | 17,5 | — | −21 | [−31 ; −9] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Santé de la population effondrée | 1 | 1 | 30 → 26 | 0 | [0 ; 0] | 4 / 2 / 24 sur 30 | non concluant |
| … jours-alerte | 1207 | 673,5 | — | −487 | [−783,5 ; −397,5] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 7,1 % | 5 → 7 | +0,1 pt | [−1,4 pt ; +0,9 pt] | 15 / 15 / 0 sur 30 | non concluant |
| Chômage max | 19,0 % | 16,3 % | — | −2,1 pt | [−4,2 pt ; +0,8 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,0 % | 0 → 0 | −0,04 pt | [−0,1 pt ; 0,0 pt] | 18 / 8 / 4 sur 30 | non concluant |
| Faim max | 45,0 % | 2,7 % | — | −23,3 pt | [−47,1 pt ; 0,0 pt] | 17 / 9 / 4 sur 30 | non concluant |
| Sans-abri moyen | 0,2 % | 0,0 % | 0 → 1 | −0,1 pt | [−0,2 pt ; −0,01 pt] | 21 / 8 / 1 sur 30 | **B plus bas (mieux)** |
| Sans-abri max | 18,3 % | 39,4 % | — | +21,3 pt | [+6,0 pt ; +26,0 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Gini moyen | 0,20 | 0,21 | 13 → 7 | +0,02 | [+0,01 ; +0,03] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,15 | 0,22 | — | +0,05 | [+0,02 ; +0,08] | — / — / 0 | **B plus haut** |
| Inflation moyenne / j | 0,040 % | 0,036 % | 0 → 0 | −0,014 pt | [−0,023 pt ; +0,008 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 47,8 % | 38,5 % | — | −4,9 pt | [−21,3 pt ; +5,6 pt] | 18 / 12 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 119,5 % | — | −24,2 pt | [−32,8 pt ; −15,4 pt] | 26 / 4 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes critiques ouvertes | 10 | 9,5 | 30 → 30 | −2,5 | [−4 ; +0,5] | 19 / 10 / 1 sur 30 | non concluant |
| … dont après la chauffe | 8 | 8 | — | −2 | [−4 ; +0,5] | 18 / 10 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 78,5 | 63,5 | — | −27 | [−43 ; +5,5] | 20 / 10 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 139,5 | 130 | — | −14,5 | [−26 ; −2] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Santé moyenne | 0,88 | 0,94 | — | +0,07 | [+0,06 ; +0,07] | 27 / 3 / 0 sur 30 | **B plus haut (mieux)** |
| Types d’entreprise actifs en fin | 20 | 20 | — | 0 | [0 ; +1] | 14 / 9 / 7 sur 30 | non concluant |
| Machines en fin | 2,6 | 3,7 | — | +0,2 | [−0,5 ; +1,6] | 17 / 13 / 0 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 4 | — | 0 | [−1 ; +1] | 11 / 13 / 6 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,99 | — | +0,01 | [+0,01 ; +0,01] | 26 / 4 / 0 sur 30 | **B plus haut (mieux)** |
| Hôpital public : attente moyenne (j) | 0,3 | 0,7 | — | +0,3 | [+0,3 ; +0,3] | 3 / 27 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 1 / 27 sur 30 | non concluant |
| Trésor de l’État le plus bas | 52 260 $ | 102 621 $ | — | +43 121 $ | [+11 455 $ ; +64 352 $] | 24 / 6 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 17 | non concluant |
| Filet : Anti-famine / 50 j | 0,18 | 0,00 | 10 → 5 | −0,12 | [−0,91 ; 0,00] | 16 / 5 / 9 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,05 | 12,20 | 30 → 30 | −0,27 | [−5,73 ; +2,80] | 17 / 13 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 2,11 | 0,00 | 17 → 10 | −0,57 | [−4,82 ; 0,00] | 17 / 7 / 6 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 0 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 2 → 2 | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| Faim répandue | 1 | 0 | 17 → 7 | 0 | [−1 ; 0] | 14 / 3 / 13 sur 30 | non concluant |
| … jours-alerte | 1 | 0 | — | −0,5 | [−3 ; 0] | 15 / 5 / 10 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 19 → 30 | 0 | [0 ; +1] | 8 / 13 / 9 sur 30 | non concluant |
| … jours-alerte | 8 | 19 | — | +9,5 | [−0,5 ; +14,5] | 10 / 19 / 1 sur 30 | non concluant |
| Inflation quotidienne | 7 | 6 | 30 → 30 | −1 | [−2 ; +1] | 16 / 11 / 3 sur 30 | non concluant |
| … jours-alerte | 7 | 6 | — | −1 | [−2 ; +1] | 16 / 11 / 3 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 30 → 27 | −0,5 | [−1,5 ; +0,5] | 15 / 10 / 5 sur 30 | non concluant |
| … jours-alerte | 50,5 | 36 | — | −28 | [−39 ; −12] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Santé de la population effondrée | 0 | 0 | 3 → 3 | 0 | [0 ; 0] | 3 / 3 / 24 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 3 / 24 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Faim moyenne : −4,0 pt [−5,2 pt ; −2,8 pt], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Faim max : −13,1 pt [−20,0 pt ; −6,9 pt], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Sans filets — Sans-abri moyen : −1,3 pt [−1,9 pt ; −0,5 pt], B mieux (24 graines mieux, 6 moins bien, 0 égales)
- Sans filets — Gini moyen : −0,09 [−0,14 ; −0,06] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Inflation moyenne / j : −0,018 pt [−0,052 pt ; −0,006 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — |Inflation sur 100 j| max : −23,4 pt [−26,3 pt ; −10,9 pt], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Sans filets — Alertes critiques ouvertes : −4 [−6,5 ; −0,5], B mieux (20 graines mieux, 9 moins bien, 1 égales)
- Sans filets — Jours-alerte critiques (somme des types) : −615,5 [−807 ; −464,5], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Sans filets — Santé moyenne : +0,36 [+0,30 ; +0,48], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Types d’entreprise actifs en fin : +3,5 [+1,5 ; +6,5], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Sans filets — Machines en fin : +0,4 [+0,2 ; +2,1], B mieux (25 graines mieux, 5 moins bien, 0 égales)
- Sans filets — Bonheur moyen : +0,09 [+0,07 ; +0,10], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Hôpital public : attente moyenne (j) : −221,7 [−319,4 ; −159,4], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Sans filets — Faim répandue : −2 [−4 ; −1], B mieux (21 graines mieux, 4 moins bien, 5 égales)
- Sans filets — Faim répandue : jours-alerte : −74,5 [−110,5 ; −58], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Sans-abri nombreux : −4 [−5,5 ; −2,5], B mieux (25 graines mieux, 5 moins bien, 0 égales)
- Sans filets — Inflation sur 100 jours : jours-alerte : −21 [−31 ; −9], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Sans filets — Santé de la population effondrée : jours-alerte : −487 [−783,5 ; −397,5], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Sans-abri moyen : −0,1 pt [−0,2 pt ; −0,01 pt], B mieux (21 graines mieux, 8 moins bien, 1 égales)
- Avec filets — Sans-abri max : +21,3 pt [+6,0 pt ; +26,0 pt], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets — Gini moyen : +0,02 [+0,01 ; +0,03] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Gini en fin de partie : +0,05 [+0,02 ; +0,08] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — |Inflation sur 100 j| max : −24,2 pt [−32,8 pt ; −15,4 pt], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Avec filets — Alertes ouvertes (toutes) : −14,5 [−26 ; −2], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets — Santé moyenne : +0,07 [+0,06 ; +0,07], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Avec filets — Bonheur moyen : +0,01 [+0,01 ; +0,01], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Avec filets — Hôpital public : attente moyenne (j) : +0,3 [+0,3 ; +0,3], B moins bien (3 graines mieux, 27 moins bien, 0 égales)
- Avec filets — Trésor de l’État le plus bas : +43 121 $ [+11 455 $ ; +64 352 $], B mieux (24 graines mieux, 6 moins bien, 0 égales)
- Avec filets — Inflation sur 100 jours : jours-alerte : −28 [−39 ; −12], B mieux (23 graines mieux, 7 moins bien, 0 égales)

