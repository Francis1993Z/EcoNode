# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 18:36
- A : `g5-ouvert-ref.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1
- B : `g5-ouvert-signal.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1, revival = 1, revivalHours = 0
- Graines appariées : 1 à 5 (5) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 17,6 % | 11,4 % | 5 → 3 | −6,1 pt | [−7,1 pt ; −4,0 pt] | 5 / 0 / 0 sur 5 | **B plus bas (mieux)** |
| Chômage max | 62,1 % | 28,7 % | — | −12,9 pt | [−33,3 pt ; −7,1 pt] | 5 / 0 / 0 sur 5 | **B plus bas (mieux)** |
| Faim moyenne | 0,2 % | 0,0 % | 1 → 0 | −0,1 pt | [−7,3 pt ; 0,0 pt] | 3 / 0 / 2 sur 5 | non concluant |
| Faim max | 8,3 % | 0,0 % | — | −3,3 pt | [−50,4 pt ; 0,0 pt] | 3 / 0 / 2 sur 5 | non concluant |
| Sans-abri moyen | 2,5 % | 1,3 % | 3 → 2 | −1,4 pt | [−10,7 pt ; +3,2 pt] | 3 / 2 / 0 sur 5 | non concluant |
| Sans-abri max | 89,6 % | 61,7 % | — | −29,6 pt | [−52,9 pt ; +49,6 pt] | 3 / 2 / 0 sur 5 | non concluant |
| Gini moyen | 0,31 | 0,28 | 1 → 0 | −0,03 | [−0,26 ; +0,003] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,38 | 0,29 | — | +0,04 | [−0,17 ; +0,09] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,025 % | -0,022 % | 0 → 0 | +0,003 pt | [−0,023 pt ; +0,041 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 34,5 % | 13,3 % | — | −12,6 pt | [−22,9 pt ; 0,0 pt] | 3 / 0 / 2 sur 5 | non concluant |
| |Inflation sur 100 j| max | 152,4 % | 85,9 % | — | −21,7 pt | [−192,2 pt ; 0,0 pt] | 3 / 0 / 2 sur 5 | non concluant |
| Alertes critiques ouvertes | 29 | 22 | 5 → 5 | −4 | [−9 ; −1] | 5 / 0 / 0 sur 5 | **B plus bas (mieux)** |
| … dont après la chauffe | 23 | 20 | — | −4 | [−9 ; −1] | 5 / 0 / 0 sur 5 | **B plus bas (mieux)** |
| Jours-alerte critiques (somme des types) | 457 | 99 | — | −291 | [−1216 ; −53] | 5 / 0 / 0 sur 5 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 170 | 386 | — | +234 | [+137 ; +298] | 0 / 5 / 0 sur 5 | **B plus haut (moins bien)** |
| Santé moyenne | 0,84 | 0,88 | — | +0,03 | [−0,0003 ; +0,16] | 4 / 1 / 0 sur 5 | non concluant |
| Naissances d’entreprises / an | 1,2 | 16,8 | — | +15,3 | [+9,7 ; +22,6] | — / — / 0 | **B plus haut** |
| Naissances / an, en % du parc moyen | 6,1 | 61,0 | — | +52,2 | [+35,1 ; +79,3] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 25,8 | 64,5 | — | +31,4 | [+19,2 ; +61,8] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 19,9 | 27,9 | — | +8,1 | [+6,7 ; +11,0] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 3,7 % | 1,1 % | — | −2,6 pt | [−6,7 pt ; −0,2 pt] | 5 / 0 / 0 sur 5 | **B plus bas (mieux)** |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 11,2 % | 10,9 % | — | +0,1 pt | [−10,5 pt ; +7,5 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 5 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 5 | non concluant |
| Fermetures : prix aberrant | 4 | 5 | — | +1 | [0 ; +4] | — / — / 1 | non concluant |
| Fermetures : faillite (salaires impayables) | 14 | 60 | — | +45 | [+27 ; +62] | — / — / 0 | **B plus haut** |
| Fermetures : demande perdue | 4 | 13 | — | +8 | [+2 ; +14] | — / — / 0 | **B plus haut** |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | 0 | [−2 ; +6] | — / — / 1 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 5 | non concluant |
| Morts d’entreprises / an | 5,1 | 17,8 | — | +11,9 | [+6,8 ; +20,9] | — / — / 0 | **B plus haut** |
| Entonnoir : projets envisagés | 3402 | 8302 | — | +4900 | [+4047 ; +5684] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 5 | 69 | — | +63 | [+40 ; +93] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 5 | 246 | — | +241 | [+140 ; +448] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, délai entre deux créations du type | 294 | 663 | — | +310 | [+92 ; +1328] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, concurrence | 1200 | 1233 | — | +28 | [−189 ; +437] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1587 | 1493 | — | +19 | [−444 ; +349] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 29 | 412 | — | +376 | [+333 ; +644] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 114 | 3496 | — | +3470 | [+2119 ; +5211] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 50 | 0 | — | −36 | [−95 ; +64] | — / — / 1 | non concluant |
| Types d’entreprise actifs en fin | 15 | 25 | — | +11 | [+8 ; +13] | 5 / 0 / 0 sur 5 | **B plus haut (mieux)** |
| Machines en fin | 252,5 | 311,5 | — | +76,8 | [+40,0 ; +188,1] | 5 / 0 / 0 sur 5 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 0 | 4 | — | +4 | [0 ; +6] | 0 / 4 / 1 sur 5 | non concluant |
| Bonheur moyen | 0,95 | 0,96 | — | +0,01 | [+0,01 ; +0,12] | 5 / 0 / 0 sur 5 | **B plus haut (mieux)** |
| Hôpital public : attente moyenne (j) | 8,4 | 1,1 | — | −5,7 | [−55,5 ; +0,1] | 4 / 1 / 0 sur 5 | non concluant |
| Jours de prestations réduites | 137 | 0 | — | −59 | [−316 ; 0] | 4 / 0 / 1 sur 5 | non concluant |
| Trésor de l’État le plus bas | 3 111 $ | 34 795 $ | — | +33 402 $ | [+162 $ ; +100 570 $] | 5 / 0 / 0 sur 5 | **B plus haut (mieux)** |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [−690 ; 0] | 1 / 0 / 4 sur 5 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [−250 ; 0] | — / — / 4 | non concluant |
| Créances radiées | 8 676 $ | 3 187 $ | — | −2 546 $ | [−43 148 $ ; +9 339 $] | — / — / 0 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 5 sur 5 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 2 | 0 | 4 → 2 | −1 | [−3 ; 0] | 3 / 0 / 2 sur 5 | non concluant |
| … jours-alerte | 137 | 0 | — | −59 | [−209 ; 0] | 4 / 0 / 1 sur 5 | non concluant |
| Faim répandue | 1 | 0 | 3 → 1 | 0 | [−3 ; +1] | 2 / 1 / 2 sur 5 | non concluant |
| … jours-alerte | 19 | 0 | — | −19 | [−229 ; 0] | 3 / 0 / 2 sur 5 | non concluant |
| Sans-abri nombreux | 4 | 5 | 5 → 5 | −1 | [−6 ; +3] | 3 / 2 / 0 sur 5 | non concluant |
| … jours-alerte | 91 | 70 | — | −39 | [−483 ; −6] | 5 / 0 / 0 sur 5 | **B plus bas (mieux)** |
| Inflation quotidienne | 16 | 14 | 5 → 5 | −1 | [−3 ; +4] | 4 / 1 / 0 sur 5 | non concluant |
| … jours-alerte | 17 | 18 | — | +1 | [−2 ; +5] | 2 / 3 / 0 sur 5 | non concluant |
| Inflation sur 100 jours | 2 | 0 | 4 → 2 | −1 | [−2 ; 0] | 4 / 0 / 1 sur 5 | non concluant |
| … jours-alerte | 36 | 0 | — | −15 | [−124 ; 0] | 4 / 0 / 1 sur 5 | non concluant |
| Santé de la population effondrée | 1 | 0 | 3 → 0 | −1 | [−1 ; 0] | 3 / 0 / 2 sur 5 | non concluant |
| … jours-alerte | 40 | 0 | — | −40 | [−332 ; 0] | 3 / 0 / 2 sur 5 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 21,7 % | 16,2 % | 5 → 4 | −5,4 pt | [−11,4 pt ; +2,8 pt] | 4 / 1 / 0 sur 5 | non concluant |
| Chômage max | 55,8 % | 54,6 % | — | +2,1 pt | [−20,4 pt ; +12,5 pt] | 2 / 3 / 0 sur 5 | non concluant |
| Faim moyenne | 0,1 % | 0,3 % | 2 → 1 | +0,2 pt | [−1,1 pt ; +0,4 pt] | 1 / 3 / 1 sur 5 | non concluant |
| Faim max | 5,8 % | 11,7 % | — | +3,7 pt | [−20,4 pt ; +8,8 pt] | 1 / 3 / 1 sur 5 | non concluant |
| Sans-abri moyen | 2,0 % | 1,8 % | 3 → 1 | +0,9 pt | [−1,4 pt ; +2,0 pt] | 2 / 3 / 0 sur 5 | non concluant |
| Sans-abri max | 42,5 % | 44,6 % | — | −0,8 pt | [−9,2 pt ; +5,0 pt] | 3 / 2 / 0 sur 5 | non concluant |
| Gini moyen | 0,32 | 0,42 | 1 → 1 | −0,02 | [−0,05 ; +0,14] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,31 | 0,58 | — | +0,06 | [−0,08 ; +0,42] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,025 % | -0,049 % | 0 → 0 | −0,028 pt | [−0,060 pt ; +0,043 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 29,4 % | 15,2 % | — | 0,0 pt | [−59,5 pt ; 0,0 pt] | 2 / 0 / 3 sur 5 | non concluant |
| |Inflation sur 100 j| max | 172,4 % | 85,9 % | — | 0,0 pt | [−109,5 pt ; 0,0 pt] | 2 / 0 / 3 sur 5 | non concluant |
| Alertes critiques ouvertes | 31 | 28 | 5 → 5 | +4 | [−10 ; +7] | 2 / 3 / 0 sur 5 | non concluant |
| … dont après la chauffe | 29 | 26 | — | +4 | [−8 ; +7] | 2 / 3 / 0 sur 5 | non concluant |
| Jours-alerte critiques (somme des types) | 671 | 283 | — | −72 | [−608 ; +193] | 3 / 2 / 0 sur 5 | non concluant |
| Alertes ouvertes (toutes) | 201 | 378 | — | +174 | [+94 ; +217] | 0 / 5 / 0 sur 5 | **B plus haut (moins bien)** |
| Santé moyenne | 0,84 | 0,85 | — | +0,01 | [−0,02 ; +0,06] | 3 / 2 / 0 sur 5 | non concluant |
| Naissances d’entreprises / an | 0,7 | 13,9 | — | +12,7 | [+9,5 ; +14,4] | — / — / 0 | **B plus haut** |
| Naissances / an, en % du parc moyen | 3,6 | 49,4 | — | +43,0 | [+35,9 ; +48,3] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 21,6 | 51,1 | — | +29,9 | [+20,6 ; +35,0] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 20,3 | 27,8 | — | +8,5 | [+4,5 ; +10,3] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 3,4 % | 2,4 % | — | −1,0 pt | [−4,2 pt ; +2,2 pt] | 3 / 2 / 0 sur 5 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 9,1 % | 11,7 % | — | +0,7 pt | [−8,6 pt ; +8,5 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 5 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 5 | non concluant |
| Fermetures : prix aberrant | 3 | 6 | — | +2 | [+1 ; +11] | — / — / 0 | **B plus haut** |
| Fermetures : faillite (salaires impayables) | 9 | 42 | — | +31 | [+14 ; +36] | — / — / 0 | **B plus haut** |
| Fermetures : demande perdue | 4 | 12 | — | +6 | [−2 ; +13] | — / — / 0 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 1 | — | −1 | [−1 ; +4] | — / — / 0 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 5 | non concluant |
| Morts d’entreprises / an | 4,4 | 15,1 | — | +9,2 | [+7,1 ; +11,4] | — / — / 0 | **B plus haut** |
| Entonnoir : projets envisagés | 3643 | 7827 | — | +4251 | [+3550 ; +4668] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 3 | 57 | — | +52 | [+39 ; +59] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 5 | 219 | — | +218 | [+139 ; +281] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, délai entre deux créations du type | 118 | 285 | — | +209 | [−9 ; +222] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 1298 | 1578 | — | +192 | [−350 ; +686] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1925 | 1347 | — | −157 | [−808 ; +296] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 8 | 493 | — | +406 | [+392 ; +690] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 105 | 3275 | — | +3265 | [+2490 ; +4719] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 10 | 1 | — | +1 | [−15 ; +185] | — / — / 1 | non concluant |
| Types d’entreprise actifs en fin | 14 | 25 | — | +11 | [+11 ; +12] | 5 / 0 / 0 sur 5 | **B plus haut (mieux)** |
| Machines en fin | 179,7 | 322,3 | — | +108,5 | [+63,5 ; +148,6] | 5 / 0 / 0 sur 5 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 1 | 3 | — | +2 | [+1 ; +5] | 0 / 5 / 0 sur 5 | **B plus haut (moins bien)** |
| Bonheur moyen | 0,94 | 0,95 | — | +0,01 | [−0,02 ; +0,04] | 3 / 2 / 0 sur 5 | non concluant |
| Hôpital public : attente moyenne (j) | 8,8 | 6,1 | — | −2,1 | [−12,3 ; +4,5] | 3 / 2 / 0 sur 5 | non concluant |
| Jours de prestations réduites | 123 | 111 | — | −12 | [−239 ; +76] | 4 / 1 / 0 sur 5 | non concluant |
| Trésor de l’État le plus bas | 2 671 $ | 1 777 $ | — | −4 $ | [−1 062 $ ; +100 576 $] | 2 / 3 / 0 sur 5 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 5 sur 5 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 5 | non concluant |
| Créances radiées | 106 $ | 3 687 $ | — | +1 523 $ | [−2 049 $ ; +11 360 $] | — / — / 1 | non concluant |
| Filet : Anti-famine / 50 j | 3,75 | 11,96 | 3 → 4 | +1,93 | [−85,21 ; +9,21] | 1 / 3 / 1 sur 5 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 2,25 | 1,93 | 4 → 4 | −1,07 | [−2,75 ; +3,29] | 4 / 1 / 0 sur 5 | non concluant |
| Filet : Plancher de logement / 50 j | 44,96 | 35,21 | 5 → 5 | +14,71 | [−69,43 ; +172,50] | 2 / 3 / 0 sur 5 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 5 sur 5 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 5 sur 5 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 5 sur 5 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 5 sur 5 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 2 | 2 | 5 → 4 | −1 | [−3 ; 0] | 3 / 0 / 2 sur 5 | non concluant |
| … jours-alerte | 371 | 116 | — | −36 | [−359 ; +92] | 3 / 2 / 0 sur 5 | non concluant |
| Faim répandue | 0 | 1 | 2 → 3 | 0 | [−3 ; +2] | 1 / 1 / 3 sur 5 | non concluant |
| … jours-alerte | 0 | 29 | — | 0 | [−34 ; +29] | 2 / 1 / 2 sur 5 | non concluant |
| Sans-abri nombreux | 3 | 8 | 5 → 5 | +3 | [+1 ; +7] | 0 / 5 / 0 sur 5 | **B plus haut (moins bien)** |
| … jours-alerte | 63 | 112 | — | +26 | [−34 ; +76] | 2 / 3 / 0 sur 5 | non concluant |
| Inflation quotidienne | 18 | 18 | 5 → 5 | 0 | [−9 ; +4] | 2 / 2 / 1 sur 5 | non concluant |
| … jours-alerte | 19 | 19 | — | 0 | [−8 ; +4] | 2 / 2 / 1 sur 5 | non concluant |
| Inflation sur 100 jours | 2 | 0 | 3 → 2 | 0 | [−3 ; +5] | 1 / 1 / 3 sur 5 | non concluant |
| … jours-alerte | 15 | 0 | — | 0 | [−150 ; +47] | 2 / 1 / 2 sur 5 | non concluant |
| Santé de la population effondrée | 1 | 1 | 3 → 3 | 0 | [−2 ; +1] | 1 / 1 / 3 sur 5 | non concluant |
| … jours-alerte | 29 | 24 | — | −5 | [−67 ; +25] | 3 / 1 / 1 sur 5 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Chômage moyen : −6,1 pt [−7,1 pt ; −4,0 pt], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Chômage max : −12,9 pt [−33,3 pt ; −7,1 pt], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Alertes critiques ouvertes : −4 [−9 ; −1], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Sans filets — dont après la chauffe (criticalSteady) : −4 [−9 ; −1], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Jours-alerte critiques (somme des types) : −291 [−1216 ; −53], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Alertes ouvertes (toutes) : +234 [+137 ; +298], B moins bien (0 graines mieux, 5 moins bien, 0 égales)
- Sans filets — Naissances d’entreprises / an : +15,3 [+9,7 ; +22,6] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Naissances / an, en % du parc moyen : +52,2 [+35,1 ; +79,3] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts / an, en % du parc moyen : +31,4 [+19,2 ; +61,8] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Parc moyen d’entreprises (après la chauffe) : +8,1 [+6,7 ; +11,0] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Demande non servie (part des unités demandées) : −2,6 pt [−6,7 pt ; −0,2 pt], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : faillite (salaires impayables) : +45 [+27 ; +62] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : demande perdue : +8 [+2 ; +14] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts d’entreprises / an : +11,9 [+6,8 ; +20,9] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : projets envisagés : +4900 [+4047 ; +5684] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : créations : +63 [+40 ; +93] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, une création déjà ce jour : +241 [+140 ; +448] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, délai entre deux créations du type : +310 [+92 ; +1328] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +376 [+333 ; +644] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, viabilité : +3470 [+2119 ; +5211] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Types d’entreprise actifs en fin : +11 [+8 ; +13], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Machines en fin : +76,8 [+40,0 ; +188,1], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Bonheur moyen : +0,01 [+0,01 ; +0,12], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Trésor de l’État le plus bas : +33 402 $ [+162 $ ; +100 570 $], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Sans-abri nombreux : jours-alerte : −39 [−483 ; −6], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Alertes ouvertes (toutes) : +174 [+94 ; +217], B moins bien (0 graines mieux, 5 moins bien, 0 égales)
- Avec filets — Naissances d’entreprises / an : +12,7 [+9,5 ; +14,4] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Naissances / an, en % du parc moyen : +43,0 [+35,9 ; +48,3] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts / an, en % du parc moyen : +29,9 [+20,6 ; +35,0] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Parc moyen d’entreprises (après la chauffe) : +8,5 [+4,5 ; +10,3] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : prix aberrant : +2 [+1 ; +11] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : faillite (salaires impayables) : +31 [+14 ; +36] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts d’entreprises / an : +9,2 [+7,1 ; +11,4] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : projets envisagés : +4251 [+3550 ; +4668] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : créations : +52 [+39 ; +59] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, une création déjà ce jour : +218 [+139 ; +281] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +406 [+392 ; +690] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : +3265 [+2490 ; +4719] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Types d’entreprise actifs en fin : +11 [+11 ; +12], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Machines en fin : +108,5 [+63,5 ; +148,6], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Équipes utilisées à moins de 15 % (fin) : +2 [+1 ; +5], B moins bien (0 graines mieux, 5 moins bien, 0 égales)
- Avec filets — Sans-abri nombreux : +3 [+1 ; +7], B moins bien (0 graines mieux, 5 moins bien, 0 égales)

