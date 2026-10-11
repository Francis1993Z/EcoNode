# Comparaison appariée ÉcoNodes

- Date : 2026-10-11 14:42
- A : `complet-sans-institutions.json`
- A — Modules coupés : Dividendes : test de solvabilité, Hôpital et école publics : enveloppe et file d’attente, Assurance-emploi indexée et aide sociale, Caisse : règles prudentielles, Faillite ordonnée
- B : `complet-i1-i5.json`
- B — Modules coupés : aucun
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 28,5 % | 8,0 % | 23 → 4 | −19,7 pt | [−47,5 pt ; −2,2 pt] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 74,4 % | 27,1 % | — | −50,6 pt | [−65,6 pt ; −22,3 pt] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Faim moyenne | 16,9 % | 6,1 % | 26 → 29 | −10,0 pt | [−53,3 pt ; −3,0 pt] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Faim max | 96,5 % | 95,4 % | — | −4,0 pt | [−4,2 pt ; +3,1 pt] | 18 / 12 / 0 sur 30 | non concluant |
| Sans-abri moyen | 16,8 % | 2,6 % | 24 → 19 | −12,7 pt | [−46,3 pt ; −2,8 pt] | 24 / 6 / 0 sur 30 | **B plus bas (mieux)** |
| Sans-abri max | 69,2 % | 42,9 % | — | −25,6 pt | [−34,8 pt ; −18,5 pt] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,47 | 0,35 | 16 → 3 | −0,14 | [−0,24 ; −0,06] | — / — / 0 | **B plus bas** |
| Gini en fin de partie | 0,67 | 0,43 | — | −0,25 | [−0,41 ; −0,03] | — / — / 0 | **B plus bas** |
| Inflation moyenne / j | 0,027 % | 0,071 % | 0 → 0 | +0,050 pt | [+0,038 pt ; +0,054 pt] | — / — / 0 | **B plus haut** |
| |Inflation| max / j | 9,6 % | 36,6 % | — | +28,7 pt | [+17,5 pt ; +34,6 pt] | 4 / 26 / 0 sur 30 | **B plus haut (moins bien)** |
| |Inflation sur 100 j| max | 126,5 % | 136,1 % | — | +10,5 pt | [−0,4 pt ; +24,6 pt] | 10 / 20 / 0 sur 30 | non concluant |
| Alertes critiques ouvertes | 19 | 27,5 | 30 → 30 | +10,5 | [+4,5 ; +14] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 15,5 | 24,5 | — | +12 | [+6 ; +15] | 7 / 22 / 1 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 3030,5 | 1524,5 | — | −1533,5 | [−2746 ; −406,5] | 24 / 6 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 671 | 509 | — | −157,5 | [−295 ; −4] | 20 / 10 / 0 sur 30 | **B plus bas (mieux)** |
| Santé moyenne | 0,11 | 0,18 | — | +0,07 | [+0,05 ; +0,10] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,64 | 0,81 | — | +0,17 | [+0,06 ; +0,43] | 25 / 5 / 0 sur 30 | **B plus haut (mieux)** |
| Hôpital public : attente moyenne (j) | 0,0 | 512,9 | — | +512,9 | [+430,0 ; +568,2] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 521,5 | 0 | — | −510,5 | [−955,5 ; −27,5] | 20 / 3 / 7 sur 30 | **B plus bas (mieux)** |
| Trésor de l’État le plus bas | 2 012 $ | 90 804 $ | — | +51 479 $ | [+10 722 $ ; +90 884 $] | 23 / 7 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 1122,5 | 0 | — | −862,5 | [−1201,5 ; −460] | 22 / 2 / 6 sur 30 | **B plus bas (mieux)** |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 23 | non concluant |
| Créances radiées | 46 144 $ | 18 445 $ | — | −26 794 $ | [−32 413 $ ; −18 726 $] | — / — / 0 | **B plus bas** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 1 | 0 | 22 → 6 | −1 | [−1 ; −0,5] | 20 / 3 / 7 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 532 | 0 | — | −527 | [−908,5 ; −38] | 21 / 4 / 5 sur 30 | **B plus bas (mieux)** |
| Faim répandue | 4 | 5 | 30 → 30 | +2 | [−2,5 ; +3] | 13 / 17 / 0 sur 30 | non concluant |
| … jours-alerte | 453,5 | 130,5 | — | −342 | [−805 ; −112] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Sans-abri nombreux | 9 | 11 | 30 → 30 | +3,5 | [−1 ; +5,5] | 10 / 19 / 1 sur 30 | non concluant |
| … jours-alerte | 680,5 | 159 | — | −525 | [−886,5 ; −181] | 25 / 5 / 0 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 1 | 7 | 18 → 30 | +5 | [+4 ; +6,5] | 2 / 28 / 0 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 1 | 7 | — | +4,5 | [+4 ; +6,5] | 2 / 28 / 0 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 26 → 30 | +1 | [+0,5 ; +1,5] | 1 / 20 / 9 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 17,5 | 37,5 | — | +21 | [+7,5 ; +42,5] | 7 / 21 / 2 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 1 | 1 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 1332 | 1207 | — | −126 | [−209,5 ; −103] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 7,0 % | 0 → 5 | +2,5 pt | [+1,7 pt ; +3,2 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 14,8 % | 19,0 % | — | +3,5 pt | [+0,4 pt ; +7,9 pt] | 7 / 22 / 1 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 0,1 % | 0 → 0 | +0,03 pt | [0,0 pt ; +0,1 pt] | 6 / 19 / 5 sur 30 | non concluant |
| Faim max | 36,9 % | 45,0 % | — | +6,5 pt | [−12,7 pt ; +15,2 pt] | 12 / 17 / 1 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,2 % | 2 → 0 | +0,1 pt | [−0,02 pt ; +0,2 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Sans-abri max | 35,6 % | 18,3 % | — | −14,2 pt | [−20,6 pt ; −9,6 pt] | 24 / 4 / 2 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,17 | 0,20 | 22 → 13 | +0,02 | [+0,003 ; +0,04] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,19 | 0,15 | — | −0,02 | [−0,05 ; +0,01] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,045 % | 0,040 % | 0 → 0 | −0,0004 pt | [−0,018 pt ; +0,020 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 15,3 % | 47,8 % | — | +22,7 pt | [+5,0 pt ; +32,1 pt] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| |Inflation sur 100 j| max | 113,2 % | 141,0 % | — | +40,0 pt | [+25,1 pt ; +45,5 pt] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 7 | 10 | 30 → 30 | +3,5 | [+3 ; +4,5] | 6 / 23 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 3,5 | 8 | — | +5 | [+3 ; +5,5] | 5 / 23 / 2 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 48 | 78,5 | — | +7,5 | [−24 ; +39] | 13 / 17 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 119,5 | 139,5 | — | +24,5 | [+4,5 ; +35,5] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,88 | — | +0,004 | [+0,004 ; +0,004] | 28 / 2 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,98 | 0,97 | — | −0,002 | [−0,004 ; +0,0001] | 10 / 20 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,3 | — | +0,3 | [+0,3 ; +0,4] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 295 $ | 52 260 $ | — | −90 294 $ | [−119 793 $ ; −67 672 $] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 4 / 1 / 25 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 24 | non concluant |
| Créances radiées | 9 049 $ | 0 $ | — | −9 049 $ | [−11 133 $ ; −4 883 $] | — / — / 1 | **B plus bas** |
| Filet : Anti-famine / 50 j | 0,00 | 0,18 | 5 → 10 | +0,09 | [0,00 ; +0,75] | 5 / 17 / 8 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 26,66 | 13,05 | 30 → 30 | −12,96 | [−17,39 ; −8,61] | 26 / 4 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 0,00 | 2,11 | 7 → 17 | +0,98 | [0,00 ; +5,25] | 8 / 18 / 4 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 5 → 1 | 0,00 | [0,00 ; 0,00] | 5 / 1 / 24 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,27 | 0,00 | — | −8,27 | [−8,57 ; −7,96] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 0 → 2 | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 24 → 17 | −1 | [−1 ; 0] | 16 / 3 / 11 sur 30 | non concluant |
| … jours-alerte | 9 | 1 | — | −5,5 | [−12 ; −3] | 23 / 3 / 4 sur 30 | **B plus bas (mieux)** |
| Sans-abri nombreux | 2 | 1 | 30 → 19 | −1 | [−1 ; −1] | 21 / 4 / 5 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 29 | 8 | — | −20,5 | [−24,5 ; −11,5] | 26 / 3 / 1 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 2 | 7 | 27 → 30 | +4 | [+3 ; +4,5] | 1 / 28 / 1 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 2 | 7 | — | +4 | [+3 ; +4] | 1 / 28 / 1 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 20 → 30 | +1,5 | [+1 ; +2] | 1 / 25 / 4 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 8,5 | 50,5 | — | +43,5 | [+26 ; +75,5] | 2 / 28 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 7 → 3 | 0 | [0 ; 0] | 6 / 2 / 22 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 2 / 21 sur 30 | non concluant |

## Avec filets, sauf « Anti-famine »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 7,1 % | 0 → 4 | +2,9 pt | [+2,5 pt ; +3,6 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 14,6 % | 19,0 % | — | +5,6 pt | [+3,5 pt ; +9,4 pt] | 4 / 25 / 1 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 0,1 % | 0 → 1 | +0,02 pt | [−0,0004 pt ; +0,1 pt] | 10 / 16 / 4 sur 30 | non concluant |
| Faim max | 35,4 % | 45,0 % | — | +3,3 pt | [−16,5 pt ; +17,1 pt] | 14 / 15 / 1 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,2 % | 0 → 0 | +0,1 pt | [+0,02 pt ; +0,3 pt] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 39,2 % | 17,9 % | — | −15,4 pt | [−20,6 pt ; −9,4 pt] | 26 / 2 / 2 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,17 | 0,20 | 25 → 13 | +0,03 | [+0,02 ; +0,04] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,19 | 0,18 | — | −0,02 | [−0,05 ; +0,04] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,019 % | 0,040 % | 0 → 0 | +0,022 pt | [+0,003 pt ; +0,036 pt] | — / — / 0 | **B plus haut** |
| |Inflation| max / j | 44,1 % | 45,8 % | — | +3,7 pt | [−8,3 pt ; +24,7 pt] | 15 / 15 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 113,3 % | 141,0 % | — | +35,6 pt | [+24,3 pt ; +40,4 pt] | 6 / 24 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 6,5 | 10 | 30 → 30 | +4 | [+3 ; +5] | 6 / 23 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 3,5 | 8 | — | +4,5 | [+3 ; +6] | 3 / 25 / 2 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 60 | 79 | — | +20,5 | [−18 ; +43] | 12 / 18 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 124,5 | 139 | — | +21,5 | [+3,5 ; +33] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,88 | — | +0,004 | [+0,004 ; +0,004] | 27 / 3 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,98 | 0,97 | — | −0,002 | [−0,004 ; −0,001] | 6 / 24 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,0 | 0,3 | — | +0,3 | [+0,3 ; +0,4] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 040 $ | 57 414 $ | — | −90 294 $ | [−121 770 $ ; −67 836 $] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 4 318 $ | 0 $ | — | −4 084 $ | [−7 579 $ ; −2 520 $] | — / — / 1 | **B plus bas** |
| Filet : Renflouement d’entreprise / 50 j | 26,77 | 11,95 | 30 → 30 | −12,84 | [−16,82 ; −8,43] | 28 / 2 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 0,00 | 2,11 | 5 → 17 | +1,25 | [0,00 ; +5,13] | 5 / 19 / 6 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,48 | 0,00 | — | −8,48 | [−8,73 ; −8,14] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 0 → 2 | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Faim répandue | 1,5 | 1 | 24 → 17 | −1 | [−1 ; 0] | 19 / 2 / 9 sur 30 | non concluant |
| … jours-alerte | 14 | 1 | — | −6 | [−15 ; −3] | 22 / 4 / 4 sur 30 | **B plus bas (mieux)** |
| Sans-abri nombreux | 2 | 1 | 30 → 19 | −1 | [−1 ; 0] | 18 / 7 / 5 sur 30 | non concluant |
| … jours-alerte | 29,5 | 8,5 | — | −19 | [−23 ; −8,5] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 2 | 6 | 27 → 30 | +4 | [+3 ; +4,5] | 1 / 26 / 3 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 2 | 6 | — | +3,5 | [+3 ; +4] | 1 / 26 / 3 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 20 → 30 | +1,5 | [+1 ; +2] | 2 / 24 / 4 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 11,5 | 46 | — | +35,5 | [+20 ; +76] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 3 → 3 | 0 | [0 ; 0] | 3 / 3 / 24 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 3 / 3 / 24 sur 30 | non concluant |

## Avec filets, sauf « Renflouement d’entreprise »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 6,6 % | 8,1 % | 3 → 4 | +1,2 pt | [+0,7 pt ; +2,4 pt] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 22,3 % | 25,8 % | — | +2,7 pt | [−1,7 pt ; +6,7 pt] | 12 / 16 / 2 sur 30 | non concluant |
| Faim moyenne | 3,1 % | 4,2 % | 21 → 25 | −0,4 pt | [−0,9 pt ; +1,3 pt] | 17 / 13 / 0 sur 30 | non concluant |
| Faim max | 93,5 % | 95,0 % | — | −0,2 pt | [−1,0 pt ; +12,3 pt] | 15 / 14 / 1 sur 30 | non concluant |
| Sans-abri moyen | 1,3 % | 1,2 % | 6 → 2 | −0,2 pt | [−0,7 pt ; +0,2 pt] | 17 / 13 / 0 sur 30 | non concluant |
| Sans-abri max | 41,5 % | 32,7 % | — | −7,5 pt | [−14,4 pt ; −1,7 pt] | 22 / 7 / 1 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,39 | 0,36 | 6 → 1 | −0,04 | [−0,09 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,52 | 0,37 | — | −0,07 | [−0,20 ; +0,07] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,055 % | 0,067 % | 0 → 0 | +0,017 pt | [−0,003 pt ; +0,030 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 4,5 % | 40,7 % | — | +35,3 pt | [+22,6 pt ; +48,2 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| |Inflation sur 100 j| max | 115,8 % | 134,6 % | — | +15,4 pt | [+4,0 pt ; +32,2 pt] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 16 | 19 | 30 → 30 | +5 | [+2 ; +10,5] | 8 / 21 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 12,5 | 18 | — | +7 | [+3 ; +10,5] | 5 / 24 / 1 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 1531 | 1403,5 | — | −179 | [−291,5 ; −79,5] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 352,5 | 488 | — | +108,5 | [−24 ; +194] | 12 / 17 / 1 sur 30 | non concluant |
| Santé moyenne | 0,12 | 0,17 | — | +0,05 | [+0,04 ; +0,09] | 28 / 2 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,81 | 0,82 | — | +0,02 | [+0,01 ; +0,03] | 23 / 7 / 0 sur 30 | **B plus haut (mieux)** |
| Hôpital public : attente moyenne (j) | 0,0 | 519,0 | — | +519,0 | [+399,5 ; +557,8] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 1 / 27 sur 30 | non concluant |
| Trésor de l’État le plus bas | 136 248 $ | 104 983 $ | — | −31 515 $ | [−46 212 $ ; −15 257 $] | 5 / 25 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 48 | 0 | — | 0 | [−436 ; 0] | 13 / 8 / 9 sur 30 | non concluant |
| Prêts refusés | 141 | 0 | — | −69,5 | [−190,5 ; 0] | — / — / 3 | non concluant |
| Créances radiées | 29 831 $ | 24 539 $ | — | −5 070 $ | [−9 713 $ ; −3 593 $] | — / — / 0 | **B plus bas** |
| Filet : Anti-famine / 50 j | 84,13 | 131,54 | 27 → 28 | −6,54 | [−52,87 ; +67,86] | 17 / 13 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 22,66 | 31,95 | 30 → 30 | +1,95 | [−9,95 ; +18,64] | 14 / 16 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 5,04 | 0,00 | 20 → 9 | −2,48 | [−6,80 ; 0,00] | 19 / 8 / 3 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 2 → 3 | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| Faim répandue | 6 | 6 | 30 → 29 | −0,5 | [−1 ; +1] | 15 / 11 / 4 sur 30 | non concluant |
| … jours-alerte | 129,5 | 121 | — | −28 | [−40 ; +22] | 19 / 11 / 0 sur 30 | non concluant |
| Sans-abri nombreux | 6 | 3 | 30 → 30 | −1,5 | [−4 ; +0,5] | 17 / 10 / 3 sur 30 | non concluant |
| … jours-alerte | 67 | 30 | — | −40,5 | [−73 ; −15] | 23 / 6 / 1 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 0 | 7 | 10 → 30 | +6 | [+5 ; +7,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 0 | 7 | — | +6 | [+5 ; +7,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 26 → 30 | +1 | [0 ; +1] | 1 / 19 / 10 sur 30 | non concluant |
| … jours-alerte | 12 | 30 | — | +21,5 | [+7 ; +34,5] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 1 | 1 | 30 → 29 | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| … jours-alerte | 1332,5 | 1207,5 | — | −126,5 | [−154 ; −112,5] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |

## Avec filets, sauf « Plancher de logement »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 7,0 % | 0 → 7 | +3,0 pt | [+2,0 pt ; +4,1 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 15,8 % | 18,8 % | — | +3,5 pt | [+1,7 pt ; +5,6 pt] | 7 / 23 / 0 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 0,0 % | 1 → 1 | 0,0 pt | [0,0 pt ; +0,1 pt] | 8 / 14 / 8 sur 30 | non concluant |
| Faim max | 44,2 % | 16,7 % | — | −15,4 pt | [−30,6 pt ; +1,3 pt] | 18 / 10 / 2 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,3 % | 0 → 4 | +0,3 pt | [+0,1 pt ; +0,4 pt] | 7 / 22 / 1 sur 30 | **B plus haut (moins bien)** |
| Sans-abri max | 41,9 % | 17,1 % | — | −20,0 pt | [−27,1 pt ; −10,6 pt] | 29 / 1 / 0 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,17 | 0,21 | 23 → 12 | +0,03 | [+0,02 ; +0,04] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,17 | 0,18 | — | +0,002 | [−0,02 ; +0,05] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,022 % | 0,042 % | 0 → 0 | +0,024 pt | [−0,024 pt ; +0,041 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 45,0 % | 41,4 % | — | −3,8 pt | [−8,1 pt ; +19,6 pt] | 17 / 13 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 116,7 % | 139,7 % | — | +30,1 pt | [+3,3 pt ; +37,9 pt] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 7 | 11,5 | 30 → 30 | +5 | [+1 ; +6] | 6 / 21 / 3 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 4 | 10 | — | +7 | [+2,5 ; +8,5] | 6 / 22 / 2 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 74,5 | 102 | — | +17 | [−26 ; +53] | 11 / 19 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 117,5 | 138,5 | — | +28,5 | [+6,5 ; +44] | 7 / 22 / 1 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,88 | — | +0,004 | [+0,003 ; +0,01] | 26 / 4 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,98 | 0,97 | — | −0,003 | [−0,004 ; −0,001] | 6 / 24 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,0 | 0,3 | — | +0,3 | [+0,3 ; +0,4] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 3 / 27 sur 30 | non concluant |
| Trésor de l’État le plus bas | 147 036 $ | 56 168 $ | — | −87 626 $ | [−112 918 $ ; −69 244 $] | 1 / 29 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 8 338 $ | 0 $ | — | −7 105 $ | [−9 794 $ ; −5 034 $] | — / — / 2 | **B plus bas** |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 7 → 9 | 0,00 | [0,00 ; +0,89] | 8 / 11 / 11 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 27,82 | 17,20 | 30 → 30 | −12,02 | [−16,79 ; −6,02] | 26 / 3 / 1 sur 30 | **B plus bas (mieux)** |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 0 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,68 | 0,00 | — | −8,68 | [−9,36 ; −8,27] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 0 → 3 | 0 | [0 ; 0] | 0 / 3 / 27 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 3 / 27 sur 30 | non concluant |
| Faim répandue | 2 | 0 | 28 → 14 | −1 | [−2 ; −1] | 22 / 1 / 7 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 11 | 0 | — | −8 | [−15,5 ; −5] | 24 / 4 / 2 sur 30 | **B plus bas (mieux)** |
| Sans-abri nombreux | 2 | 1 | 30 → 23 | −1 | [−1 ; +0,5] | 16 / 10 / 4 sur 30 | non concluant |
| … jours-alerte | 34,5 | 8,5 | — | −18 | [−28 ; +5] | 20 / 10 / 0 sur 30 | non concluant |
| Inflation quotidienne | 3 | 6 | 28 → 30 | +3,5 | [+2 ; +4] | 2 / 25 / 3 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 3 | 6 | — | +3,5 | [+2 ; +4] | 2 / 24 / 4 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 23 → 30 | +1,5 | [+1 ; +2] | 1 / 25 / 4 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 12,5 | 41 | — | +29 | [+24 ; +37,5] | 6 / 23 / 1 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 4 → 4 | 0 | [0 ; 0] | 3 / 4 / 23 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 4 / 3 / 23 sur 30 | non concluant |

## Avec filets, sauf « Plafond de dérive des prix et salaires »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 7,0 % | 0 → 5 | +2,5 pt | [+1,7 pt ; +3,2 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 14,8 % | 19,0 % | — | +3,5 pt | [+0,4 pt ; +7,9 pt] | 7 / 22 / 1 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 0,1 % | 0 → 0 | +0,03 pt | [0,0 pt ; +0,1 pt] | 6 / 19 / 5 sur 30 | non concluant |
| Faim max | 36,9 % | 45,0 % | — | +6,5 pt | [−12,7 pt ; +15,2 pt] | 12 / 17 / 1 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,2 % | 2 → 0 | +0,1 pt | [−0,02 pt ; +0,2 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Sans-abri max | 35,6 % | 18,3 % | — | −14,2 pt | [−20,6 pt ; −9,6 pt] | 24 / 4 / 2 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,17 | 0,20 | 22 → 13 | +0,02 | [+0,003 ; +0,04] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,19 | 0,15 | — | −0,02 | [−0,05 ; +0,01] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,045 % | 0,040 % | 0 → 0 | −0,0004 pt | [−0,018 pt ; +0,020 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 15,3 % | 47,8 % | — | +22,7 pt | [+5,0 pt ; +32,1 pt] | 8 / 22 / 0 sur 30 | **B plus haut (moins bien)** |
| |Inflation sur 100 j| max | 113,2 % | 141,0 % | — | +40,0 pt | [+25,1 pt ; +45,5 pt] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 7 | 10 | 30 → 30 | +3,5 | [+3 ; +4,5] | 6 / 23 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 3,5 | 8 | — | +5 | [+3 ; +5,5] | 5 / 23 / 2 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 48 | 78,5 | — | +7,5 | [−24 ; +39] | 13 / 17 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 119,5 | 139,5 | — | +24,5 | [+4,5 ; +35,5] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,88 | — | +0,004 | [+0,004 ; +0,004] | 28 / 2 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,98 | 0,97 | — | −0,002 | [−0,004 ; +0,0001] | 10 / 20 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,0 | 0,3 | — | +0,3 | [+0,3 ; +0,4] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 295 $ | 52 260 $ | — | −90 294 $ | [−119 793 $ ; −67 672 $] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 4 / 1 / 25 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 24 | non concluant |
| Créances radiées | 9 049 $ | 0 $ | — | −9 049 $ | [−11 133 $ ; −4 883 $] | — / — / 1 | **B plus bas** |
| Filet : Anti-famine / 50 j | 0,00 | 0,18 | 5 → 10 | +0,09 | [0,00 ; +0,75] | 5 / 17 / 8 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 26,66 | 13,05 | 30 → 30 | −12,96 | [−17,39 ; −8,61] | 26 / 4 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 0,00 | 2,11 | 7 → 17 | +0,98 | [0,00 ; +5,25] | 8 / 18 / 4 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 5 → 1 | 0,00 | [0,00 ; 0,00] | 5 / 1 / 24 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,27 | 0,00 | — | −8,27 | [−8,57 ; −7,96] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 0 → 2 | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 24 → 17 | −1 | [−1 ; 0] | 16 / 3 / 11 sur 30 | non concluant |
| … jours-alerte | 9 | 1 | — | −5,5 | [−12 ; −3] | 23 / 3 / 4 sur 30 | **B plus bas (mieux)** |
| Sans-abri nombreux | 2 | 1 | 30 → 19 | −1 | [−1 ; −1] | 21 / 4 / 5 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 29 | 8 | — | −20,5 | [−24,5 ; −11,5] | 26 / 3 / 1 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 2 | 7 | 27 → 30 | +4 | [+3 ; +4,5] | 1 / 28 / 1 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 2 | 7 | — | +4 | [+3 ; +4] | 1 / 28 / 1 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 20 → 30 | +1,5 | [+1 ; +2] | 1 / 25 / 4 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 8,5 | 50,5 | — | +43,5 | [+26 ; +75,5] | 2 / 28 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 7 → 3 | 0 | [0 ; 0] | 6 / 2 / 22 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 7 / 2 / 21 sur 30 | non concluant |

## Avec filets, sauf « Anti-crédit-fou »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 4,3 % | 7,0 % | 0 → 5 | +2,5 pt | [+1,7 pt ; +3,5 pt] | 1 / 29 / 0 sur 30 | **B plus haut (moins bien)** |
| Chômage max | 14,6 % | 19,0 % | — | +3,7 pt | [+1,7 pt ; +7,9 pt] | 6 / 23 / 1 sur 30 | **B plus haut (moins bien)** |
| Faim moyenne | 0,0 % | 0,1 % | 0 → 0 | +0,03 pt | [0,0 pt ; +0,1 pt] | 6 / 19 / 5 sur 30 | non concluant |
| Faim max | 35,4 % | 45,0 % | — | +6,5 pt | [−9,8 pt ; +15,8 pt] | 12 / 17 / 1 sur 30 | non concluant |
| Sans-abri moyen | 0,0 % | 0,2 % | 2 → 0 | +0,1 pt | [−0,02 pt ; +0,2 pt] | 13 / 17 / 0 sur 30 | non concluant |
| Sans-abri max | 35,6 % | 18,3 % | — | −14,2 pt | [−20,6 pt ; −9,6 pt] | 24 / 4 / 2 sur 30 | **B plus bas (mieux)** |
| Gini moyen | 0,17 | 0,20 | 23 → 13 | +0,02 | [+0,01 ; +0,04] | — / — / 0 | **B plus haut** |
| Gini en fin de partie | 0,18 | 0,15 | — | −0,02 | [−0,04 ; +0,02] | — / — / 0 | non concluant |
| Inflation moyenne / j | 0,043 % | 0,040 % | 0 → 0 | +0,001 pt | [−0,013 pt ; +0,025 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 17,1 % | 47,8 % | — | +17,8 pt | [−5,5 pt ; +32,1 pt] | 10 / 20 / 0 sur 30 | non concluant |
| |Inflation sur 100 j| max | 113,2 % | 141,0 % | — | +40,0 pt | [+25,1 pt ; +45,5 pt] | 5 / 25 / 0 sur 30 | **B plus haut (moins bien)** |
| Alertes critiques ouvertes | 7 | 10 | 30 → 30 | +3,5 | [+3 ; +4,5] | 7 / 22 / 1 sur 30 | **B plus haut (moins bien)** |
| … dont après la chauffe | 3,5 | 8 | — | +5 | [+3 ; +5,5] | 6 / 22 / 2 sur 30 | **B plus haut (moins bien)** |
| Jours-alerte critiques (somme des types) | 48 | 78,5 | — | +7,5 | [−18 ; +39] | 13 / 17 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 123 | 139,5 | — | +24,5 | [+4,5 ; +34,5] | 9 / 21 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,88 | 0,88 | — | +0,004 | [+0,004 ; +0,004] | 28 / 2 / 0 sur 30 | **B plus haut (mieux)** |
| Bonheur moyen | 0,98 | 0,97 | — | −0,002 | [−0,004 ; −0,0003] | 9 / 21 / 0 sur 30 | **B plus bas (moins bien)** |
| Hôpital public : attente moyenne (j) | 0,0 | 0,3 | — | +0,3 | [+0,3 ; +0,4] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Trésor de l’État le plus bas | 146 295 $ | 52 260 $ | — | −90 294 $ | [−116 527 $ ; −67 672 $] | 0 / 30 / 0 sur 30 | **B plus bas (moins bien)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 4 / 1 / 25 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 9 049 $ | 0 $ | — | −9 049 $ | [−11 133 $ ; −4 883 $] | — / — / 1 | **B plus bas** |
| Filet : Anti-famine / 50 j | 0,00 | 0,18 | 5 → 10 | +0,09 | [0,00 ; +0,75] | 5 / 17 / 8 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 26,66 | 13,05 | 30 → 30 | −12,93 | [−15,52 ; −9,00] | 27 / 3 / 0 sur 30 | **B plus bas (mieux)** |
| Filet : Plancher de logement / 50 j | 0,00 | 2,11 | 6 → 17 | +0,80 | [0,00 ; +5,25] | 9 / 17 / 4 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 8,27 | 0,00 | — | −8,27 | [−8,57 ; −8,13] | 30 / 0 / 0 sur 30 | **B plus bas (mieux)** |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 0 → 2 | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 24 → 17 | −0,5 | [−1 ; 0] | 15 / 3 / 12 sur 30 | non concluant |
| … jours-alerte | 9 | 1 | — | −5 | [−12 ; −3] | 23 / 3 / 4 sur 30 | **B plus bas (mieux)** |
| Sans-abri nombreux | 2 | 1 | 30 → 19 | −1 | [−1 ; −0,5] | 20 / 5 / 5 sur 30 | **B plus bas (mieux)** |
| … jours-alerte | 28 | 8 | — | −19,5 | [−26,5 ; −11] | 26 / 3 / 1 sur 30 | **B plus bas (mieux)** |
| Inflation quotidienne | 2,5 | 7 | 27 → 30 | +3 | [+3 ; +4] | 3 / 26 / 1 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 2,5 | 7 | — | +3 | [+3 ; +4] | 3 / 26 / 1 sur 30 | **B plus haut (moins bien)** |
| Inflation sur 100 jours | 1 | 2 | 20 → 30 | +1,5 | [+1 ; +2] | 1 / 25 / 4 sur 30 | **B plus haut (moins bien)** |
| … jours-alerte | 8,5 | 50,5 | — | +43,5 | [+26 ; +75] | 2 / 28 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé de la population effondrée | 0 | 0 | 6 → 3 | 0 | [0 ; 0] | 5 / 2 / 23 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 6 / 2 / 22 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Chômage moyen : −19,7 pt [−47,5 pt ; −2,2 pt], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Sans filets — Chômage max : −50,6 pt [−65,6 pt ; −22,3 pt], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Sans filets — Faim moyenne : −10,0 pt [−53,3 pt ; −3,0 pt], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Sans filets — Sans-abri moyen : −12,7 pt [−46,3 pt ; −2,8 pt], B mieux (24 graines mieux, 6 moins bien, 0 égales)
- Sans filets — Sans-abri max : −25,6 pt [−34,8 pt ; −18,5 pt], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Sans filets — Gini moyen : −0,14 [−0,24 ; −0,06] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Gini en fin de partie : −0,25 [−0,41 ; −0,03] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Inflation moyenne / j : +0,050 pt [+0,038 pt ; +0,054 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — |Inflation| max / j : +28,7 pt [+17,5 pt ; +34,6 pt], B moins bien (4 graines mieux, 26 moins bien, 0 égales)
- Sans filets — Alertes critiques ouvertes : +10,5 [+4,5 ; +14], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Sans filets — dont après la chauffe (criticalSteady) : +12 [+6 ; +15], B moins bien (7 graines mieux, 22 moins bien, 1 égales)
- Sans filets — Jours-alerte critiques (somme des types) : −1533,5 [−2746 ; −406,5], B mieux (24 graines mieux, 6 moins bien, 0 égales)
- Sans filets — Alertes ouvertes (toutes) : −157,5 [−295 ; −4], B mieux (20 graines mieux, 10 moins bien, 0 égales)
- Sans filets — Santé moyenne : +0,07 [+0,05 ; +0,10], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Bonheur moyen : +0,17 [+0,06 ; +0,43], B mieux (25 graines mieux, 5 moins bien, 0 égales)
- Sans filets — Hôpital public : attente moyenne (j) : +512,9 [+430,0 ; +568,2], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Sans filets — Jours de prestations réduites : −510,5 [−955,5 ; −27,5], B mieux (20 graines mieux, 3 moins bien, 7 égales)
- Sans filets — Trésor de l’État le plus bas : +51 479 $ [+10 722 $ ; +90 884 $], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Sans filets — Jours de Caisse insolvable : −862,5 [−1201,5 ; −460], B mieux (22 graines mieux, 2 moins bien, 6 égales)
- Sans filets — Créances radiées : −26 794 $ [−32 413 $ ; −18 726 $] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Chômage très élevé : −1 [−1 ; −0,5], B mieux (20 graines mieux, 3 moins bien, 7 égales)
- Sans filets — Chômage très élevé : jours-alerte : −527 [−908,5 ; −38], B mieux (21 graines mieux, 4 moins bien, 5 égales)
- Sans filets — Faim répandue : jours-alerte : −342 [−805 ; −112], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Sans filets — Sans-abri nombreux : jours-alerte : −525 [−886,5 ; −181], B mieux (25 graines mieux, 5 moins bien, 0 égales)
- Sans filets — Inflation quotidienne : +5 [+4 ; +6,5], B moins bien (2 graines mieux, 28 moins bien, 0 égales)
- Sans filets — Inflation quotidienne : jours-alerte : +4,5 [+4 ; +6,5], B moins bien (2 graines mieux, 28 moins bien, 0 égales)
- Sans filets — Inflation sur 100 jours : +1 [+0,5 ; +1,5], B moins bien (1 graines mieux, 20 moins bien, 9 égales)
- Sans filets — Inflation sur 100 jours : jours-alerte : +21 [+7,5 ; +42,5], B moins bien (7 graines mieux, 21 moins bien, 2 égales)
- Sans filets — Santé de la population effondrée : jours-alerte : −126 [−209,5 ; −103], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Chômage moyen : +2,5 pt [+1,7 pt ; +3,2 pt], B moins bien (1 graines mieux, 29 moins bien, 0 égales)
- Avec filets — Chômage max : +3,5 pt [+0,4 pt ; +7,9 pt], B moins bien (7 graines mieux, 22 moins bien, 1 égales)
- Avec filets — Sans-abri max : −14,2 pt [−20,6 pt ; −9,6 pt], B mieux (24 graines mieux, 4 moins bien, 2 égales)
- Avec filets — Gini moyen : +0,02 [+0,003 ; +0,04] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — |Inflation| max / j : +22,7 pt [+5,0 pt ; +32,1 pt], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets — |Inflation sur 100 j| max : +40,0 pt [+25,1 pt ; +45,5 pt], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets — Alertes critiques ouvertes : +3,5 [+3 ; +4,5], B moins bien (6 graines mieux, 23 moins bien, 1 égales)
- Avec filets — dont après la chauffe (criticalSteady) : +5 [+3 ; +5,5], B moins bien (5 graines mieux, 23 moins bien, 2 égales)
- Avec filets — Alertes ouvertes (toutes) : +24,5 [+4,5 ; +35,5], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets — Santé moyenne : +0,004 [+0,004 ; +0,004], B mieux (28 graines mieux, 2 moins bien, 0 égales)
- Avec filets — Hôpital public : attente moyenne (j) : +0,3 [+0,3 ; +0,4], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets — Trésor de l’État le plus bas : −90 294 $ [−119 793 $ ; −67 672 $], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets — Créances radiées : −9 049 $ [−11 133 $ ; −4 883 $] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets — Filet : Renflouement d’entreprise / 50 j : −12,96 [−17,39 ; −8,61], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Avec filets — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : −8,27 [−8,57 ; −7,96], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Faim répandue : jours-alerte : −5,5 [−12 ; −3], B mieux (23 graines mieux, 3 moins bien, 4 égales)
- Avec filets — Sans-abri nombreux : −1 [−1 ; −1], B mieux (21 graines mieux, 4 moins bien, 5 égales)
- Avec filets — Sans-abri nombreux : jours-alerte : −20,5 [−24,5 ; −11,5], B mieux (26 graines mieux, 3 moins bien, 1 égales)
- Avec filets — Inflation quotidienne : +4 [+3 ; +4,5], B moins bien (1 graines mieux, 28 moins bien, 1 égales)
- Avec filets — Inflation quotidienne : jours-alerte : +4 [+3 ; +4], B moins bien (1 graines mieux, 28 moins bien, 1 égales)
- Avec filets — Inflation sur 100 jours : +1,5 [+1 ; +2], B moins bien (1 graines mieux, 25 moins bien, 4 égales)
- Avec filets — Inflation sur 100 jours : jours-alerte : +43,5 [+26 ; +75,5], B moins bien (2 graines mieux, 28 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Chômage moyen : +2,9 pt [+2,5 pt ; +3,6 pt], B moins bien (1 graines mieux, 29 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Chômage max : +5,6 pt [+3,5 pt ; +9,4 pt], B moins bien (4 graines mieux, 25 moins bien, 1 égales)
- Avec filets, sauf « Anti-famine » — Sans-abri moyen : +0,1 pt [+0,02 pt ; +0,3 pt], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Sans-abri max : −15,4 pt [−20,6 pt ; −9,4 pt], B mieux (26 graines mieux, 2 moins bien, 2 égales)
- Avec filets, sauf « Anti-famine » — Gini moyen : +0,03 [+0,02 ; +0,04] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Inflation moyenne / j : +0,022 pt [+0,003 pt ; +0,036 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — |Inflation sur 100 j| max : +35,6 pt [+24,3 pt ; +40,4 pt], B moins bien (6 graines mieux, 24 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Alertes critiques ouvertes : +4 [+3 ; +5], B moins bien (6 graines mieux, 23 moins bien, 1 égales)
- Avec filets, sauf « Anti-famine » — dont après la chauffe (criticalSteady) : +4,5 [+3 ; +6], B moins bien (3 graines mieux, 25 moins bien, 2 égales)
- Avec filets, sauf « Anti-famine » — Alertes ouvertes (toutes) : +21,5 [+3,5 ; +33], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Santé moyenne : +0,004 [+0,004 ; +0,004], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Bonheur moyen : −0,002 [−0,004 ; −0,001], B moins bien (6 graines mieux, 24 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Hôpital public : attente moyenne (j) : +0,3 [+0,3 ; +0,4], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Trésor de l’État le plus bas : −90 294 $ [−121 770 $ ; −67 836 $], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Créances radiées : −4 084 $ [−7 579 $ ; −2 520 $] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets, sauf « Anti-famine » — Filet : Renflouement d’entreprise / 50 j : −12,84 [−16,82 ; −8,43], B mieux (28 graines mieux, 2 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : −8,48 [−8,73 ; −8,14], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Faim répandue : jours-alerte : −6 [−15 ; −3], B mieux (22 graines mieux, 4 moins bien, 4 égales)
- Avec filets, sauf « Anti-famine » — Sans-abri nombreux : jours-alerte : −19 [−23 ; −8,5], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Avec filets, sauf « Anti-famine » — Inflation quotidienne : +4 [+3 ; +4,5], B moins bien (1 graines mieux, 26 moins bien, 3 égales)
- Avec filets, sauf « Anti-famine » — Inflation quotidienne : jours-alerte : +3,5 [+3 ; +4], B moins bien (1 graines mieux, 26 moins bien, 3 égales)
- Avec filets, sauf « Anti-famine » — Inflation sur 100 jours : +1,5 [+1 ; +2], B moins bien (2 graines mieux, 24 moins bien, 4 égales)
- Avec filets, sauf « Anti-famine » — Inflation sur 100 jours : jours-alerte : +35,5 [+20 ; +76], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Chômage moyen : +1,2 pt [+0,7 pt ; +2,4 pt], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Sans-abri max : −7,5 pt [−14,4 pt ; −1,7 pt], B mieux (22 graines mieux, 7 moins bien, 1 égales)
- Avec filets, sauf « Renflouement d’entreprise » — |Inflation| max / j : +35,3 pt [+22,6 pt ; +48,2 pt], B moins bien (1 graines mieux, 29 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — |Inflation sur 100 j| max : +15,4 pt [+4,0 pt ; +32,2 pt], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Alertes critiques ouvertes : +5 [+2 ; +10,5], B moins bien (8 graines mieux, 21 moins bien, 1 égales)
- Avec filets, sauf « Renflouement d’entreprise » — dont après la chauffe (criticalSteady) : +7 [+3 ; +10,5], B moins bien (5 graines mieux, 24 moins bien, 1 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Jours-alerte critiques (somme des types) : −179 [−291,5 ; −79,5], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Santé moyenne : +0,05 [+0,04 ; +0,09], B mieux (28 graines mieux, 2 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Bonheur moyen : +0,02 [+0,01 ; +0,03], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Hôpital public : attente moyenne (j) : +519,0 [+399,5 ; +557,8], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Trésor de l’État le plus bas : −31 515 $ [−46 212 $ ; −15 257 $], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Créances radiées : −5 070 $ [−9 713 $ ; −3 593 $] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Sans-abri nombreux : jours-alerte : −40,5 [−73 ; −15], B mieux (23 graines mieux, 6 moins bien, 1 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Inflation quotidienne : +6 [+5 ; +7,5], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Inflation quotidienne : jours-alerte : +6 [+5 ; +7,5], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Inflation sur 100 jours : jours-alerte : +21,5 [+7 ; +34,5], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets, sauf « Renflouement d’entreprise » — Santé de la population effondrée : jours-alerte : −126,5 [−154 ; −112,5], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Chômage moyen : +3,0 pt [+2,0 pt ; +4,1 pt], B moins bien (1 graines mieux, 29 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Chômage max : +3,5 pt [+1,7 pt ; +5,6 pt], B moins bien (7 graines mieux, 23 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Sans-abri moyen : +0,3 pt [+0,1 pt ; +0,4 pt], B moins bien (7 graines mieux, 22 moins bien, 1 égales)
- Avec filets, sauf « Plancher de logement » — Sans-abri max : −20,0 pt [−27,1 pt ; −10,6 pt], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Gini moyen : +0,03 [+0,02 ; +0,04] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — |Inflation sur 100 j| max : +30,1 pt [+3,3 pt ; +37,9 pt], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Alertes critiques ouvertes : +5 [+1 ; +6], B moins bien (6 graines mieux, 21 moins bien, 3 égales)
- Avec filets, sauf « Plancher de logement » — dont après la chauffe (criticalSteady) : +7 [+2,5 ; +8,5], B moins bien (6 graines mieux, 22 moins bien, 2 égales)
- Avec filets, sauf « Plancher de logement » — Alertes ouvertes (toutes) : +28,5 [+6,5 ; +44], B moins bien (7 graines mieux, 22 moins bien, 1 égales)
- Avec filets, sauf « Plancher de logement » — Santé moyenne : +0,004 [+0,003 ; +0,01], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Bonheur moyen : −0,003 [−0,004 ; −0,001], B moins bien (6 graines mieux, 24 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Hôpital public : attente moyenne (j) : +0,3 [+0,3 ; +0,4], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Trésor de l’État le plus bas : −87 626 $ [−112 918 $ ; −69 244 $], B moins bien (1 graines mieux, 29 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Créances radiées : −7 105 $ [−9 794 $ ; −5 034 $] (0 graines mieux, 0 moins bien, 2 égales)
- Avec filets, sauf « Plancher de logement » — Filet : Renflouement d’entreprise / 50 j : −12,02 [−16,79 ; −6,02], B mieux (26 graines mieux, 3 moins bien, 1 égales)
- Avec filets, sauf « Plancher de logement » — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : −8,68 [−9,36 ; −8,27], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Plancher de logement » — Faim répandue : −1 [−2 ; −1], B mieux (22 graines mieux, 1 moins bien, 7 égales)
- Avec filets, sauf « Plancher de logement » — Faim répandue : jours-alerte : −8 [−15,5 ; −5], B mieux (24 graines mieux, 4 moins bien, 2 égales)
- Avec filets, sauf « Plancher de logement » — Inflation quotidienne : +3,5 [+2 ; +4], B moins bien (2 graines mieux, 25 moins bien, 3 égales)
- Avec filets, sauf « Plancher de logement » — Inflation quotidienne : jours-alerte : +3,5 [+2 ; +4], B moins bien (2 graines mieux, 24 moins bien, 4 égales)
- Avec filets, sauf « Plancher de logement » — Inflation sur 100 jours : +1,5 [+1 ; +2], B moins bien (1 graines mieux, 25 moins bien, 4 égales)
- Avec filets, sauf « Plancher de logement » — Inflation sur 100 jours : jours-alerte : +29 [+24 ; +37,5], B moins bien (6 graines mieux, 23 moins bien, 1 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Chômage moyen : +2,5 pt [+1,7 pt ; +3,2 pt], B moins bien (1 graines mieux, 29 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Chômage max : +3,5 pt [+0,4 pt ; +7,9 pt], B moins bien (7 graines mieux, 22 moins bien, 1 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Sans-abri max : −14,2 pt [−20,6 pt ; −9,6 pt], B mieux (24 graines mieux, 4 moins bien, 2 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Gini moyen : +0,02 [+0,003 ; +0,04] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — |Inflation| max / j : +22,7 pt [+5,0 pt ; +32,1 pt], B moins bien (8 graines mieux, 22 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — |Inflation sur 100 j| max : +40,0 pt [+25,1 pt ; +45,5 pt], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Alertes critiques ouvertes : +3,5 [+3 ; +4,5], B moins bien (6 graines mieux, 23 moins bien, 1 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — dont après la chauffe (criticalSteady) : +5 [+3 ; +5,5], B moins bien (5 graines mieux, 23 moins bien, 2 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Alertes ouvertes (toutes) : +24,5 [+4,5 ; +35,5], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Santé moyenne : +0,004 [+0,004 ; +0,004], B mieux (28 graines mieux, 2 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Hôpital public : attente moyenne (j) : +0,3 [+0,3 ; +0,4], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Trésor de l’État le plus bas : −90 294 $ [−119 793 $ ; −67 672 $], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Créances radiées : −9 049 $ [−11 133 $ ; −4 883 $] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Filet : Renflouement d’entreprise / 50 j : −12,96 [−17,39 ; −8,61], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : −8,27 [−8,57 ; −7,96], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Faim répandue : jours-alerte : −5,5 [−12 ; −3], B mieux (23 graines mieux, 3 moins bien, 4 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Sans-abri nombreux : −1 [−1 ; −1], B mieux (21 graines mieux, 4 moins bien, 5 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Sans-abri nombreux : jours-alerte : −20,5 [−24,5 ; −11,5], B mieux (26 graines mieux, 3 moins bien, 1 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Inflation quotidienne : +4 [+3 ; +4,5], B moins bien (1 graines mieux, 28 moins bien, 1 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Inflation quotidienne : jours-alerte : +4 [+3 ; +4], B moins bien (1 graines mieux, 28 moins bien, 1 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Inflation sur 100 jours : +1,5 [+1 ; +2], B moins bien (1 graines mieux, 25 moins bien, 4 égales)
- Avec filets, sauf « Plafond de dérive des prix et salaires » — Inflation sur 100 jours : jours-alerte : +43,5 [+26 ; +75,5], B moins bien (2 graines mieux, 28 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Chômage moyen : +2,5 pt [+1,7 pt ; +3,5 pt], B moins bien (1 graines mieux, 29 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Chômage max : +3,7 pt [+1,7 pt ; +7,9 pt], B moins bien (6 graines mieux, 23 moins bien, 1 égales)
- Avec filets, sauf « Anti-crédit-fou » — Sans-abri max : −14,2 pt [−20,6 pt ; −9,6 pt], B mieux (24 graines mieux, 4 moins bien, 2 égales)
- Avec filets, sauf « Anti-crédit-fou » — Gini moyen : +0,02 [+0,01 ; +0,04] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — |Inflation sur 100 j| max : +40,0 pt [+25,1 pt ; +45,5 pt], B moins bien (5 graines mieux, 25 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Alertes critiques ouvertes : +3,5 [+3 ; +4,5], B moins bien (7 graines mieux, 22 moins bien, 1 égales)
- Avec filets, sauf « Anti-crédit-fou » — dont après la chauffe (criticalSteady) : +5 [+3 ; +5,5], B moins bien (6 graines mieux, 22 moins bien, 2 égales)
- Avec filets, sauf « Anti-crédit-fou » — Alertes ouvertes (toutes) : +24,5 [+4,5 ; +34,5], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Santé moyenne : +0,004 [+0,004 ; +0,004], B mieux (28 graines mieux, 2 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Bonheur moyen : −0,002 [−0,004 ; −0,0003], B moins bien (9 graines mieux, 21 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Hôpital public : attente moyenne (j) : +0,3 [+0,3 ; +0,4], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Trésor de l’État le plus bas : −90 294 $ [−116 527 $ ; −67 672 $], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Créances radiées : −9 049 $ [−11 133 $ ; −4 883 $] (0 graines mieux, 0 moins bien, 1 égales)
- Avec filets, sauf « Anti-crédit-fou » — Filet : Renflouement d’entreprise / 50 j : −12,93 [−15,52 ; −9,00], B mieux (27 graines mieux, 3 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — dont renflouements de l’hôpital / 50 j (bailoutRates.hopital) : −8,27 [−8,57 ; −8,13], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets, sauf « Anti-crédit-fou » — Faim répandue : jours-alerte : −5 [−12 ; −3], B mieux (23 graines mieux, 3 moins bien, 4 égales)
- Avec filets, sauf « Anti-crédit-fou » — Sans-abri nombreux : −1 [−1 ; −0,5], B mieux (20 graines mieux, 5 moins bien, 5 égales)
- Avec filets, sauf « Anti-crédit-fou » — Sans-abri nombreux : jours-alerte : −19,5 [−26,5 ; −11], B mieux (26 graines mieux, 3 moins bien, 1 égales)
- Avec filets, sauf « Anti-crédit-fou » — Inflation quotidienne : +3 [+3 ; +4], B moins bien (3 graines mieux, 26 moins bien, 1 égales)
- Avec filets, sauf « Anti-crédit-fou » — Inflation quotidienne : jours-alerte : +3 [+3 ; +4], B moins bien (3 graines mieux, 26 moins bien, 1 égales)
- Avec filets, sauf « Anti-crédit-fou » — Inflation sur 100 jours : +1,5 [+1 ; +2], B moins bien (1 graines mieux, 25 moins bien, 4 égales)
- Avec filets, sauf « Anti-crédit-fou » — Inflation sur 100 jours : jours-alerte : +43,5 [+26 ; +75], B moins bien (2 graines mieux, 28 moins bien, 0 égales)

