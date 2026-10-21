# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 18:46
- A : `g30-ouvert-ref.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1
- B : `g30-ouvert-revival.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1, revival = 1
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 17,9 % | 13,3 % | 29 → 26 | −4,2 pt | [−7,2 pt ; −1,5 pt] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 52,3 % | 42,9 % | — | −6,0 pt | [−14,2 pt ; −1,6 pt] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Faim moyenne | 0,1 % | 0,0 % | 6 → 3 | −0,004 pt | [−0,1 pt ; 0,0 pt] | 16 / 9 / 5 sur 30 | non concluant |
| Faim max | 6,5 % | 2,1 % | — | 0,0 pt | [−4,2 pt ; +1,3 pt] | 14 / 10 / 6 sur 30 | non concluant |
| Sans-abri moyen | 1,5 % | 1,6 % | 13 → 12 | −0,1 pt | [−0,5 pt ; +0,6 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Sans-abri max | 47,1 % | 55,2 % | — | +0,4 pt | [−4,6 pt ; +11,0 pt] | 12 / 16 / 2 sur 30 | non concluant |
| Gini moyen | 0,34 | 0,31 | 4 → 0 | −0,03 | [−0,05 ; +0,002] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,37 | 0,31 | — | −0,04 | [−0,10 ; +0,04] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,023 % | -0,038 % | 0 → 0 | −0,018 pt | [−0,025 pt ; −0,003 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 30,3 % | 25,5 % | — | +1,2 pt | [−7,4 pt ; +6,4 pt] | 13 / 16 / 1 sur 30 | non concluant |
| |Inflation sur 100 j| max | 130,7 % | 108,7 % | — | −22,0 pt | [−44,3 pt ; 0,0 pt] | 19 / 9 / 2 sur 30 | non concluant |
| Alertes critiques ouvertes | 26,5 | 26 | 30 → 30 | −1,5 | [−6,5 ; +3] | 16 / 12 / 2 sur 30 | non concluant |
| … dont après la chauffe | 23,5 | 25,5 | — | −1,5 | [−6,5 ; +3] | 16 / 12 / 2 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 335,5 | 178,5 | — | −143,5 | [−199 ; +26,5] | 19 / 11 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 184 | 559,5 | — | +379 | [+332,5 ; +402] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,85 | 0,87 | — | +0,01 | [+0,0002 ; +0,02] | 21 / 9 / 0 sur 30 | **B plus haut (mieux)** |
| Naissances d’entreprises / an | 1,5 | 30,2 | — | +28,8 | [+27,7 ; +30,3] | — / — / 0 | **B plus haut** |
| Naissances / an, en % du parc moyen | 7,5 | 94,4 | — | +88,3 | [+85,1 ; +93,0] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 26,9 | 96,0 | — | +71,7 | [+64,5 ; +74,2] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 20,0 | 31,7 | — | +11,3 | [+11,1 ; +12,4] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 2,3 % | 1,4 % | — | −0,7 pt | [−1,6 pt ; +0,1 pt] | 20 / 10 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 9,4 % | 12,0 % | — | +3,0 pt | [−1,6 pt ; +4,9 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 2 | 3 | — | +1 | [0 ; +2] | — / — / 4 | non concluant |
| Fermetures : faillite (salaires impayables) | 13 | 99 | — | +86,5 | [+80 ; +90,5] | — / — / 0 | **B plus haut** |
| Fermetures : demande perdue | 4 | 18,5 | — | +13,5 | [+11 ; +18] | — / — / 1 | **B plus haut** |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 2 | — | +2 | [+1 ; +3] | — / — / 5 | **B plus haut** |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 5,4 | 30,5 | — | +25,3 | [+24,1 ; +26,5] | — / — / 0 | **B plus haut** |
| Entonnoir : projets envisagés | 3276 | 5361,5 | — | +2239 | [+1808,5 ; +2467,5] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 6 | 124 | — | +118,5 | [+114 ; +124,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 4,5 | 381,5 | — | +375 | [+330,5 ; +408,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, délai entre deux créations du type | 322 | 1360,5 | — | +974 | [+834,5 ; +1180,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, concurrence | 1162,5 | 1281,5 | — | +165,5 | [−60 ; +276,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1509 | 1431,5 | — | −77 | [−226 ; +72,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 23 | 274,5 | — | +258 | [+167,5 ; +305] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 88,5 | 461 | — | +303 | [+190 ; +465] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 8,5 | 12 | — | +3 | [0 ; +24] | — / — / 4 | non concluant |
| Types d’entreprise actifs en fin | 14 | 27 | — | +13 | [+10,5 ; +15] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Machines en fin | 192,0 | 302,4 | — | +76,3 | [+37,8 ; +142,6] | 24 / 6 / 0 sur 30 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 0 | 4 | — | +3 | [+2 ; +5] | 1 / 25 / 4 sur 30 | **B plus haut (moins bien)** |
| Bonheur moyen | 0,95 | 0,96 | — | +0,01 | [−0,001 ; +0,02] | 19 / 11 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 5,6 | 3,2 | — | −1,5 | [−4,1 ; −0,1] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Jours de prestations réduites | 120,5 | 48,5 | — | −55 | [−72,6 ; −4] | 20 / 7 / 3 sur 30 | **B plus bas (mieux)** |
| Trésor de l’État le plus bas | 2 793 $ | 3 398 $ | — | +1 449 $ | [+150 $ ; +2 459 $] | 23 / 7 / 0 sur 30 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 2 / 0 / 28 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 27 | non concluant |
| Créances radiées | 4 980 $ | 6 451 $ | — | +604 $ | [−2 734 $ ; +4 035 $] | — / — / 0 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 3 | 1 | 25 → 23 | −1 | [−2 ; 0] | 19 / 4 / 7 sur 30 | non concluant |
| … jours-alerte | 164 | 57,5 | — | −43 | [−144,5 ; 0] | 19 / 8 / 3 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 14 → 10 | 0 | [−0,5 ; 0] | 10 / 6 / 14 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [−7,5 ; 0] | 11 / 7 / 12 sur 30 | non concluant |
| Sans-abri nombreux | 4 | 6 | 30 → 30 | 0 | [−1 ; +1,5] | 13 / 14 / 3 sur 30 | non concluant |
| … jours-alerte | 88 | 89 | — | −14,5 | [−39,5 ; +24,5] | 18 / 12 / 0 sur 30 | non concluant |
| Inflation quotidienne | 15 | 15 | 30 → 30 | +2 | [−1,5 ; +3] | 12 / 17 / 1 sur 30 | non concluant |
| … jours-alerte | 16 | 19,5 | — | +2,5 | [−4 ; +5] | 14 / 16 / 0 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 1 | 22 → 16 | −1 | [−2 ; 0] | 16 / 5 / 9 sur 30 | non concluant |
| … jours-alerte | 28 | 12,5 | — | −12,5 | [−34 ; 0] | 19 / 5 / 6 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 13 → 8 | 0 | [0 ; 0] | 9 / 4 / 17 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [−5,5 ; 0] | 11 / 5 / 14 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 19,4 % | 15,4 % | 29 → 28 | −3,1 pt | [−5,7 pt ; +0,5 pt] | 19 / 11 / 0 sur 30 | non concluant |
| Chômage max | 55,8 % | 48,1 % | — | −2,9 pt | [−14,8 pt ; +1,2 pt] | 17 / 12 / 1 sur 30 | non concluant |
| Faim moyenne | 0,2 % | 0,1 % | 8 → 7 | 0,0 pt | [−0,2 pt ; +0,1 pt] | 13 / 13 / 4 sur 30 | non concluant |
| Faim max | 9,8 % | 5,4 % | — | 0,0 pt | [−4,8 pt ; +4,4 pt] | 13 / 13 / 4 sur 30 | non concluant |
| Sans-abri moyen | 1,9 % | 1,9 % | 13 → 14 | +0,1 pt | [−0,5 pt ; +0,8 pt] | 14 / 16 / 0 sur 30 | non concluant |
| Sans-abri max | 42,3 % | 47,3 % | — | +5,6 pt | [−5,2 pt ; +13,8 pt] | 13 / 16 / 1 sur 30 | non concluant |
| Gini moyen | 0,34 | 0,33 | 5 → 2 | −0,004 | [−0,02 ; +0,05] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,33 | 0,36 | — | +0,03 | [−0,03 ; +0,11] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,010 % | -0,034 % | 0 → 0 | −0,023 pt | [−0,034 pt ; −0,008 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 32,4 % | 23,0 % | — | −3,3 pt | [−11,5 pt ; +1,4 pt] | 16 / 11 / 3 sur 30 | non concluant |
| |Inflation sur 100 j| max | 132,9 % | 101,4 % | — | −8,3 pt | [−26,6 pt ; 0,0 pt] | 18 / 9 / 3 sur 30 | non concluant |
| Alertes critiques ouvertes | 28,5 | 30,5 | 30 → 30 | +1 | [−2 ; +5] | 11 / 17 / 2 sur 30 | non concluant |
| … dont après la chauffe | 26,5 | 30 | — | +1 | [−1,5 ; +5] | 11 / 16 / 3 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 436 | 256,5 | — | −68,5 | [−238 ; +126,5] | 16 / 14 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 182,5 | 557 | — | +359,5 | [+339,5 ; +380] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,84 | 0,86 | — | +0,01 | [−0,01 ; +0,03] | 19 / 11 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 0,7 | 27,4 | — | +26,6 | [+25,4 ; +28,0] | — / — / 0 | **B plus haut** |
| Naissances / an, en % du parc moyen | 3,3 | 84,5 | — | +79,8 | [+75,8 ; +85,6] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 19,5 | 85,3 | — | +61,4 | [+57,8 ; +69,7] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 20,6 | 32,0 | — | +11,3 | [+10,7 ; +12,4] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 2,8 % | 1,8 % | — | −0,6 pt | [−1,6 pt ; +0,5 pt] | 17 / 13 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 9,6 % | 12,7 % | — | +1,8 pt | [−3,2 pt ; +4,0 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 3 | 5,5 | — | +2 | [+1 ; +3] | — / — / 4 | **B plus haut** |
| Fermetures : faillite (salaires impayables) | 8 | 81,5 | — | +74 | [+67 ; +82,5] | — / — / 0 | **B plus haut** |
| Fermetures : demande perdue | 4 | 19,5 | — | +15 | [+12 ; +16,5] | — / — / 0 | **B plus haut** |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 2 | — | +1 | [+1 ; +2] | — / — / 5 | **B plus haut** |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 3,9 | 27,4 | — | +23,5 | [+21,0 ; +24,5] | — / — / 0 | **B plus haut** |
| Entonnoir : projets envisagés | 3324 | 4945,5 | — | +1713,5 | [+1428 ; +1990] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 3 | 112,5 | — | +109,5 | [+104,5 ; +115] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 2 | 324 | — | +319,5 | [+307 ; +388] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, délai entre deux créations du type | 118,5 | 835 | — | +640,5 | [+591 ; +769,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, concurrence | 1476,5 | 1327,5 | — | −152 | [−274 ; +95,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1503 | 1536 | — | −58 | [−284 ; +159] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 10,5 | 252,5 | — | +229,5 | [+194,5 ; +280] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 16 | 556 | — | +423 | [+333 ; +587] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 0 | 12,5 | — | +11,5 | [+6 ; +18] | — / — / 4 | **B plus haut** |
| Types d’entreprise actifs en fin | 15 | 28 | — | +13 | [+11 ; +14] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Machines en fin | 182,1 | 277,0 | — | +83,7 | [+55,0 ; +133,3] | 24 / 6 / 0 sur 30 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 1 | 6 | — | +5 | [+2,5 ; +6] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Bonheur moyen | 0,94 | 0,95 | — | −0,002 | [−0,01 ; +0,02] | 14 / 16 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 7,3 | 4,1 | — | −1,8 | [−4,6 ; +1,1] | 17 / 13 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 129,5 | 90,5 | — | −25 | [−95 ; +30] | 17 / 11 / 2 sur 30 | non concluant |
| Trésor de l’État le plus bas | 2 463 $ | 2 654 $ | — | −6 $ | [−316 $ ; +1 386 $] | 14 / 16 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 2 288 $ | — | +1 872 $ | [+737 $ ; +3 324 $] | — / — / 5 | **B plus haut** |
| Filet : Anti-famine / 50 j | 3,30 | 1,39 | 19 → 15 | 0,00 | [−7,45 ; +1,34] | 14 / 11 / 5 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 1,52 | 3,13 | 17 → 30 | +1,71 | [+0,95 ; +2,57] | 6 / 24 / 0 sur 30 | **B plus haut (moins bien)** |
| Filet : Plancher de logement / 50 j | 32,82 | 34,46 | 29 → 28 | +6,41 | [−12,36 ; +17,23] | 13 / 17 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 2 | 2 | 28 → 20 | −1 | [−1 ; 0] | 16 / 8 / 6 sur 30 | non concluant |
| … jours-alerte | 166,5 | 94,5 | — | −36 | [−132,5 ; +45] | 17 / 11 / 2 sur 30 | non concluant |
| Faim répandue | 1 | 0 | 16 → 12 | 0 | [0 ; 0] | 9 / 7 / 14 sur 30 | non concluant |
| … jours-alerte | 1,5 | 0 | — | 0 | [−11 ; 0] | 11 / 9 / 10 sur 30 | non concluant |
| Sans-abri nombreux | 5 | 6,5 | 30 → 30 | +1,5 | [0 ; +2,5] | 8 / 19 / 3 sur 30 | non concluant |
| … jours-alerte | 120,5 | 116 | — | +0,5 | [−23 ; +55,5] | 14 / 15 / 1 sur 30 | non concluant |
| Inflation quotidienne | 15 | 16,5 | 30 → 30 | +2,5 | [−2 ; +5] | 11 / 18 / 1 sur 30 | non concluant |
| … jours-alerte | 16 | 20,5 | — | +3,5 | [−1,5 ; +8] | 12 / 18 / 0 sur 30 | non concluant |
| Inflation sur 100 jours | 1,5 | 0,5 | 20 → 15 | 0 | [−1 ; 0] | 14 / 5 / 11 sur 30 | non concluant |
| … jours-alerte | 23,5 | 1 | — | −1 | [−19,5 ; 0] | 15 / 7 / 8 sur 30 | non concluant |
| Santé de la population effondrée | 1 | 0 | 17 → 11 | 0 | [0 ; 0] | 9 / 4 / 17 sur 30 | non concluant |
| … jours-alerte | 16,5 | 0 | — | 0 | [−16,5 ; 0] | 14 / 6 / 10 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Chômage moyen : −4,2 pt [−7,2 pt ; −1,5 pt], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Sans filets — Chômage max : −6,0 pt [−14,2 pt ; −1,6 pt], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Sans filets — Inflation moyenne / j : −0,018 pt [−0,025 pt ; −0,003 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Alertes ouvertes (toutes) : +379 [+332,5 ; +402], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Sans filets — Santé moyenne : +0,01 [+0,0002 ; +0,02], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Sans filets — Naissances d’entreprises / an : +28,8 [+27,7 ; +30,3] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Naissances / an, en % du parc moyen : +88,3 [+85,1 ; +93,0] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts / an, en % du parc moyen : +71,7 [+64,5 ; +74,2] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Parc moyen d’entreprises (après la chauffe) : +11,3 [+11,1 ; +12,4] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : faillite (salaires impayables) : +86,5 [+80 ; +90,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : demande perdue : +13,5 [+11 ; +18] (0 graines mieux, 0 moins bien, 1 égales)
- Sans filets — Fermetures : sans employé (départs, postes non pourvus) : +2 [+1 ; +3] (0 graines mieux, 0 moins bien, 5 égales)
- Sans filets — Morts d’entreprises / an : +25,3 [+24,1 ; +26,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : projets envisagés : +2239 [+1808,5 ; +2467,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : créations : +118,5 [+114 ; +124,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, une création déjà ce jour : +375 [+330,5 ; +408,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, délai entre deux créations du type : +974 [+834,5 ; +1180,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +258 [+167,5 ; +305] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, viabilité : +303 [+190 ; +465] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Types d’entreprise actifs en fin : +13 [+10,5 ; +15], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Machines en fin : +76,3 [+37,8 ; +142,6], B mieux (24 graines mieux, 6 moins bien, 0 égales)
- Sans filets — Équipes utilisées à moins de 15 % (fin) : +3 [+2 ; +5], B moins bien (1 graines mieux, 25 moins bien, 4 égales)
- Sans filets — Hôpital public : attente moyenne (j) : −1,5 [−4,1 ; −0,1], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Sans filets — Jours de prestations réduites : −55 [−72,6 ; −4], B mieux (20 graines mieux, 7 moins bien, 3 égales)
- Sans filets — Trésor de l’État le plus bas : +1 449 $ [+150 $ ; +2 459 $], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Avec filets — Inflation moyenne / j : −0,023 pt [−0,034 pt ; −0,008 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Alertes ouvertes (toutes) : +359,5 [+339,5 ; +380], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets — Naissances d’entreprises / an : +26,6 [+25,4 ; +28,0] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Naissances / an, en % du parc moyen : +79,8 [+75,8 ; +85,6] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts / an, en % du parc moyen : +61,4 [+57,8 ; +69,7] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Parc moyen d’entreprises (après la chauffe) : +11,3 [+10,7 ; +12,4] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : prix aberrant : +2 [+1 ; +3] (0 graines mieux, 0 moins bien, 4 égales)
- Avec filets — Fermetures : faillite (salaires impayables) : +74 [+67 ; +82,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : demande perdue : +15 [+12 ; +16,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : sans employé (départs, postes non pourvus) : +1 [+1 ; +2] (0 graines mieux, 0 moins bien, 5 égales)
- Avec filets — Morts d’entreprises / an : +23,5 [+21,0 ; +24,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : projets envisagés : +1713,5 [+1428 ; +1990] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : créations : +109,5 [+104,5 ; +115] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, une création déjà ce jour : +319,5 [+307 ; +388] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, délai entre deux créations du type : +640,5 [+591 ; +769,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +229,5 [+194,5 ; +280] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : +423 [+333 ; +587] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, aucun fondateur assez riche : +11,5 [+6 ; +18] (0 graines mieux, 0 moins bien, 4 égales)
- Avec filets — Types d’entreprise actifs en fin : +13 [+11 ; +14], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Machines en fin : +83,7 [+55,0 ; +133,3], B mieux (24 graines mieux, 6 moins bien, 0 égales)
- Avec filets — Équipes utilisées à moins de 15 % (fin) : +5 [+2,5 ; +6], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets — Créances radiées : +1 872 $ [+737 $ ; +3 324 $] (0 graines mieux, 0 moins bien, 5 égales)
- Avec filets — Filet : Renflouement d’entreprise / 50 j : +1,71 [+0,95 ; +2,57], B moins bien (6 graines mieux, 24 moins bien, 0 égales)

