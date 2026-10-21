# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 19:17
- A : `g30-ouvert-sans.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- A — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1, revival = 0
- B : `g30-ouvert-cout.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : trade = 1, tradeWaves = 1, floatingFx = 1, foreignDemand = 1, revival = 1, revivalFullCost = 1
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 17,9 % | 13,9 % | 29 → 27 | −2,6 pt | [−5,1 pt ; −1,2 pt] | 24 / 6 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 52,3 % | 42,5 % | — | −3,7 pt | [−9,8 pt ; −1,2 pt] | 23 / 7 / 0 sur 30 | **B plus bas (mieux)** |
| Faim moyenne | 0,1 % | 0,0 % | 6 → 4 | −0,001 pt | [−0,2 pt ; 0,0 pt] | 15 / 8 / 7 sur 30 | non concluant |
| Faim max | 6,5 % | 1,0 % | — | 0,0 pt | [−3,8 pt ; 0,0 pt] | 14 / 9 / 7 sur 30 | non concluant |
| Sans-abri moyen | 1,5 % | 1,7 % | 13 → 11 | −0,1 pt | [−1,2 pt ; +0,5 pt] | 16 / 14 / 0 sur 30 | non concluant |
| Sans-abri max | 47,1 % | 56,0 % | — | 0,0 pt | [−2,7 pt ; +7,5 pt] | 11 / 13 / 6 sur 30 | non concluant |
| Gini moyen | 0,34 | 0,31 | 4 → 1 | −0,02 | [−0,04 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,37 | 0,31 | — | −0,01 | [−0,14 ; +0,05] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,023 % | -0,037 % | 0 → 0 | −0,011 pt | [−0,024 pt ; −0,005 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 30,3 % | 20,9 % | — | 0,0 pt | [−11,2 pt ; +3,4 pt] | 14 / 12 / 4 sur 30 | non concluant |
| |Inflation sur 100 j| max | 130,7 % | 97,9 % | — | −15,9 pt | [−28,0 pt ; −1,4 pt] | 21 / 5 / 4 sur 30 | **B plus bas (mieux)** |
| Alertes critiques ouvertes | 26,5 | 22,5 | 30 → 30 | −3,5 | [−8,5 ; +3] | 18 / 12 / 0 sur 30 | non concluant |
| … dont après la chauffe | 23,5 | 21 | — | −3,5 | [−8,5 ; +3] | 18 / 12 / 0 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 335,5 | 224 | — | −75,5 | [−276 ; −2] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 184 | 349,5 | — | +169 | [+160 ; +187,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,85 | 0,87 | — | +0,01 | [−0,00001 ; +0,03] | 20 / 10 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 1,5 | 15,2 | — | +13,4 | [+11,6 ; +15,1] | — / — / 0 | **B plus haut** |
| Naissances / an, en % du parc moyen | 7,5 | 57,0 | — | +48,5 | [+41,8 ; +51,8] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 26,9 | 60,3 | — | +31,1 | [+27,4 ; +41,4] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 20,0 | 27,0 | — | +7,2 | [+6,6 ; +7,7] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 2,3 % | 1,4 % | — | −0,5 pt | [−1,7 pt ; −0,1 pt] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 9,4 % | 10,5 % | — | +2,6 pt | [−2,8 pt ; +5,2 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 2 | 4 | — | +1 | [+0,5 ; +2,5] | — / — / 5 | **B plus haut** |
| Fermetures : faillite (salaires impayables) | 13 | 47 | — | +33,5 | [+29 ; +39,5] | — / — / 0 | **B plus haut** |
| Fermetures : demande perdue | 4 | 12 | — | +7 | [+5,5 ; +9,5] | — / — / 0 | **B plus haut** |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 2 | — | 0 | [0 ; +1] | — / — / 10 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 5,4 | 16,1 | — | +10,2 | [+9,0 ; +12,8] | — / — / 0 | **B plus haut** |
| Entonnoir : projets envisagés | 3276 | 8433,5 | — | +5207,5 | [+4848,5 ; +5519] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 6 | 62,5 | — | +55 | [+47,5 ; +62] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 4,5 | 238 | — | +229 | [+195 ; +260] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, délai entre deux créations du type | 322 | 738,5 | — | +401 | [+302 ; +510,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, concurrence | 1162,5 | 1251 | — | +115,5 | [−14,5 ; +277,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1509 | 1480 | — | +44 | [−134,5 ; +255,5] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 23 | 562,5 | — | +545 | [+483 ; +650] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 88,5 | 3849,5 | — | +3655,5 | [+3088,5 ; +4164,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 8,5 | 18,5 | — | +4,5 | [0 ; +16,5] | — / — / 4 | non concluant |
| Types d’entreprise actifs en fin | 14 | 25 | — | +10 | [+9 ; +11] | 30 / 0 / 0 sur 30 | **B plus haut (mieux)** |
| Machines en fin | 192,0 | 301,3 | — | +67,3 | [+39,4 ; +125,0] | 26 / 4 / 0 sur 30 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 0 | 4 | — | +2,5 | [+1 ; +4] | 3 / 24 / 3 sur 30 | **B plus haut (moins bien)** |
| Bonheur moyen | 0,95 | 0,96 | — | +0,01 | [−0,0002 ; +0,02] | 19 / 11 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 5,6 | 2,6 | — | −1,6 | [−5,4 ; −0,01] | 21 / 9 / 0 sur 30 | **B plus bas (mieux)** |
| Jours de prestations réduites | 120,5 | 56,5 | — | −56 | [−83,5 ; 0] | 18 / 8 / 4 sur 30 | non concluant |
| Trésor de l’État le plus bas | 2 793 $ | 3 495 $ | — | +300 $ | [−377 $ ; +1 777 $] | 18 / 12 / 0 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 26 | non concluant |
| Créances radiées | 4 980 $ | 4 888 $ | — | +252 $ | [−4 111 $ ; +3 886 $] | — / — / 1 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 3 | 2 | 25 → 22 | 0 | [−2 ; 0] | 14 / 4 / 12 sur 30 | non concluant |
| … jours-alerte | 164 | 97,5 | — | −38,5 | [−93 ; 0] | 19 / 7 / 4 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 14 → 11 | 0 | [0 ; 0] | 9 / 5 / 16 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [−9,5 ; 0] | 10 / 7 / 13 sur 30 | non concluant |
| Sans-abri nombreux | 4 | 5 | 30 → 30 | +1 | [−0,5 ; +1,5] | 10 / 16 / 4 sur 30 | non concluant |
| … jours-alerte | 88 | 73,5 | — | −10,5 | [−65,5 ; +17] | 18 / 12 / 0 sur 30 | non concluant |
| Inflation quotidienne | 15 | 12 | 30 → 30 | +0,5 | [−4,5 ; +2] | 14 / 15 / 1 sur 30 | non concluant |
| … jours-alerte | 16 | 14 | — | +1,5 | [−5,5 ; +3,5] | 13 / 16 / 1 sur 30 | non concluant |
| Inflation sur 100 jours | 1 | 0 | 22 → 14 | −1 | [−1 ; 0] | 16 / 1 / 13 sur 30 | non concluant |
| … jours-alerte | 28 | 0 | — | −2 | [−22,5 ; 0] | 17 / 4 / 9 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 13 → 8 | 0 | [0 ; 0] | 9 / 5 / 16 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [−3 ; 0] | 10 / 6 / 14 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 19,4 % | 15,5 % | 29 → 26 | −2,2 pt | [−5,3 pt ; −1,0 pt] | 22 / 8 / 0 sur 30 | **B plus bas (mieux)** |
| Chômage max | 55,8 % | 44,8 % | — | −2,5 pt | [−17,9 pt ; +2,3 pt] | 17 / 12 / 1 sur 30 | non concluant |
| Faim moyenne | 0,2 % | 0,0 % | 8 → 7 | 0,0 pt | [−0,2 pt ; +0,01 pt] | 14 / 11 / 5 sur 30 | non concluant |
| Faim max | 9,8 % | 4,4 % | — | 0,0 pt | [−10,6 pt ; +0,4 pt] | 14 / 10 / 6 sur 30 | non concluant |
| Sans-abri moyen | 1,9 % | 1,2 % | 13 → 11 | −0,5 pt | [−0,9 pt ; +0,2 pt] | 19 / 11 / 0 sur 30 | non concluant |
| Sans-abri max | 42,3 % | 40,6 % | — | −1,9 pt | [−12,5 pt ; 0,0 pt] | 16 / 9 / 5 sur 30 | non concluant |
| Gini moyen | 0,34 | 0,32 | 5 → 4 | −0,01 | [−0,03 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,33 | 0,34 | — | −0,02 | [−0,08 ; +0,08] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,010 % | -0,031 % | 0 → 0 | −0,020 pt | [−0,038 pt ; −0,013 pt] | — / — / 0 | **B plus bas** |
| |Inflation| max / j | 32,4 % | 22,9 % | — | −4,1 pt | [−12,1 pt ; +0,5 pt] | 17 / 10 / 3 sur 30 | non concluant |
| |Inflation sur 100 j| max | 132,9 % | 115,6 % | — | −6,0 pt | [−24,2 pt ; 0,0 pt] | 18 / 6 / 6 sur 30 | non concluant |
| Alertes critiques ouvertes | 28,5 | 25 | 30 → 30 | 0 | [−7 ; +5] | 14 / 12 / 4 sur 30 | non concluant |
| … dont après la chauffe | 26,5 | 23,5 | — | 0 | [−7 ; +5] | 14 / 12 / 4 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 436 | 234 | — | −27,5 | [−244 ; +27,5] | 16 / 14 / 0 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 182,5 | 361,5 | — | +168,5 | [+135 ; +193,5] | 0 / 30 / 0 sur 30 | **B plus haut (moins bien)** |
| Santé moyenne | 0,84 | 0,87 | — | +0,01 | [−0,003 ; +0,03] | 17 / 13 / 0 sur 30 | non concluant |
| Naissances d’entreprises / an | 0,7 | 12,9 | — | +12,0 | [+11,0 ; +14,4] | — / — / 0 | **B plus haut** |
| Naissances / an, en % du parc moyen | 3,3 | 46,7 | — | +43,5 | [+41,1 ; +48,8] | — / — / 0 | **B plus haut** |
| Morts / an, en % du parc moyen | 19,5 | 51,9 | — | +31,1 | [+27,3 ; +36,7] | — / — / 0 | **B plus haut** |
| Parc moyen d’entreprises (après la chauffe) | 20,6 | 27,6 | — | +6,9 | [+6,3 ; +7,6] | — / — / 0 | **B plus haut** |
| Demande non servie (part des unités demandées) | 2,8 % | 1,5 % | — | −0,5 pt | [−1,5 pt ; +0,2 pt] | 19 / 11 / 0 sur 30 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 9,6 % | 10,2 % | — | +0,5 pt | [−4,6 pt ; +6,7 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 3 | 5 | — | +2 | [+1 ; +3] | — / — / 4 | **B plus haut** |
| Fermetures : faillite (salaires impayables) | 8 | 39,5 | — | +32 | [+26,5 ; +34] | — / — / 0 | **B plus haut** |
| Fermetures : demande perdue | 4 | 12,5 | — | +8,5 | [+5,5 ; +11] | — / — / 0 | **B plus haut** |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 2 | — | 0 | [0 ; +1] | — / — / 10 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 3,9 | 14,0 | — | +9,6 | [+8,8 ; +11,6] | — / — / 0 | **B plus haut** |
| Entonnoir : projets envisagés | 3324 | 8195,5 | — | +4895,5 | [+4505 ; +5200,5] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 3 | 53 | — | +49,5 | [+45 ; +59] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, une création déjà ce jour | 2 | 201,5 | — | +198 | [+185,5 ; +253,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, délai entre deux créations du type | 118,5 | 278 | — | +176,5 | [+93 ; +231] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, concurrence | 1476,5 | 1381,5 | — | −36,5 | [−177,5 ; +126,5] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 1503 | 1534 | — | +22 | [−227 ; +229] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 10,5 | 557,5 | — | +522,5 | [+450,5 ; +602] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, viabilité | 16 | 3605,5 | — | +3411,5 | [+3178 ; +3853,5] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 0 | 0,5 | — | 0 | [0 ; +5] | — / — / 12 | non concluant |
| Types d’entreprise actifs en fin | 15 | 25 | — | +9 | [+8 ; +10,5] | 29 / 1 / 0 sur 30 | **B plus haut (mieux)** |
| Machines en fin | 182,1 | 298,6 | — | +107,0 | [+38,2 ; +172,0] | 25 / 5 / 0 sur 30 | **B plus haut (mieux)** |
| Équipes utilisées à moins de 15 % (fin) | 1 | 3 | — | +2 | [+1 ; +3] | 4 / 22 / 4 sur 30 | **B plus haut (moins bien)** |
| Bonheur moyen | 0,94 | 0,95 | — | +0,01 | [−0,005 ; +0,02] | 18 / 12 / 0 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 7,3 | 2,7 | — | −1,4 | [−5,2 ; +0,6] | 17 / 13 / 0 sur 30 | non concluant |
| Jours de prestations réduites | 129,5 | 87,5 | — | −20,5 | [−81,5 ; 0] | 17 / 9 / 4 sur 30 | non concluant |
| Trésor de l’État le plus bas | 2 463 $ | 3 013 $ | — | +86 $ | [−47 $ ; +2 323 $] | 17 / 12 / 1 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 3 339 $ | — | +2 716 $ | [+1 896 $ ; +4 553 $] | — / — / 3 | **B plus haut** |
| Filet : Anti-famine / 50 j | 3,30 | 0,05 | 19 → 13 | 0,00 | [−6,96 ; 0,00] | 14 / 8 / 8 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 1,52 | 1,59 | 17 → 25 | +0,41 | [−0,50 ; +0,96] | 12 / 18 / 0 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 32,82 | 16,05 | 29 → 28 | −4,55 | [−28,38 ; +7,45] | 19 / 11 / 0 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 2 | 2 | 28 → 22 | −1 | [−1 ; 0] | 17 / 8 / 5 sur 30 | non concluant |
| … jours-alerte | 166,5 | 87,5 | — | −21 | [−98,5 ; +21] | 18 / 12 / 0 sur 30 | non concluant |
| Faim répandue | 1 | 0 | 16 → 13 | 0 | [−1 ; 0] | 11 / 8 / 11 sur 30 | non concluant |
| … jours-alerte | 1,5 | 0 | — | 0 | [−11 ; 0] | 12 / 7 / 11 sur 30 | non concluant |
| Sans-abri nombreux | 5 | 5 | 30 → 30 | +1 | [−0,5 ; +2,5] | 10 / 17 / 3 sur 30 | non concluant |
| … jours-alerte | 120,5 | 86,5 | — | −19,5 | [−58,0 ; +20] | 19 / 11 / 0 sur 30 | non concluant |
| Inflation quotidienne | 15 | 13 | 30 → 30 | −0,5 | [−3 ; +1,5] | 15 / 12 / 3 sur 30 | non concluant |
| … jours-alerte | 16 | 14,5 | — | 0 | [−3,5 ; +2,5] | 14 / 14 / 2 sur 30 | non concluant |
| Inflation sur 100 jours | 1,5 | 1 | 20 → 17 | 0 | [−1 ; 0] | 13 / 5 / 12 sur 30 | non concluant |
| … jours-alerte | 23,5 | 9,5 | — | 0 | [−14,5 ; 0] | 13 / 8 / 9 sur 30 | non concluant |
| Santé de la population effondrée | 1 | 0 | 17 → 11 | 0 | [0 ; 0] | 9 / 3 / 18 sur 30 | non concluant |
| … jours-alerte | 16,5 | 0 | — | 0 | [−12 ; 0] | 11 / 8 / 11 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Chômage moyen : −2,6 pt [−5,1 pt ; −1,2 pt], B mieux (24 graines mieux, 6 moins bien, 0 égales)
- Sans filets — Chômage max : −3,7 pt [−9,8 pt ; −1,2 pt], B mieux (23 graines mieux, 7 moins bien, 0 égales)
- Sans filets — Inflation moyenne / j : −0,011 pt [−0,024 pt ; −0,005 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — |Inflation sur 100 j| max : −15,9 pt [−28,0 pt ; −1,4 pt], B mieux (21 graines mieux, 5 moins bien, 4 égales)
- Sans filets — Jours-alerte critiques (somme des types) : −75,5 [−276 ; −2], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Sans filets — Alertes ouvertes (toutes) : +169 [+160 ; +187,5], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Sans filets — Naissances d’entreprises / an : +13,4 [+11,6 ; +15,1] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Naissances / an, en % du parc moyen : +48,5 [+41,8 ; +51,8] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts / an, en % du parc moyen : +31,1 [+27,4 ; +41,4] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Parc moyen d’entreprises (après la chauffe) : +7,2 [+6,6 ; +7,7] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Demande non servie (part des unités demandées) : −0,5 pt [−1,7 pt ; −0,1 pt], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Sans filets — Fermetures : prix aberrant : +1 [+0,5 ; +2,5] (0 graines mieux, 0 moins bien, 5 égales)
- Sans filets — Fermetures : faillite (salaires impayables) : +33,5 [+29 ; +39,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Fermetures : demande perdue : +7 [+5,5 ; +9,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Morts d’entreprises / an : +10,2 [+9,0 ; +12,8] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : projets envisagés : +5207,5 [+4848,5 ; +5519] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : créations : +55 [+47,5 ; +62] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, une création déjà ce jour : +229 [+195 ; +260] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, délai entre deux créations du type : +401 [+302 ; +510,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +545 [+483 ; +650] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Entonnoir : refus, viabilité : +3655,5 [+3088,5 ; +4164,5] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Types d’entreprise actifs en fin : +10 [+9 ; +11], B mieux (30 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Machines en fin : +67,3 [+39,4 ; +125,0], B mieux (26 graines mieux, 4 moins bien, 0 égales)
- Sans filets — Équipes utilisées à moins de 15 % (fin) : +2,5 [+1 ; +4], B moins bien (3 graines mieux, 24 moins bien, 3 égales)
- Sans filets — Hôpital public : attente moyenne (j) : −1,6 [−5,4 ; −0,01], B mieux (21 graines mieux, 9 moins bien, 0 égales)
- Avec filets — Chômage moyen : −2,2 pt [−5,3 pt ; −1,0 pt], B mieux (22 graines mieux, 8 moins bien, 0 égales)
- Avec filets — Inflation moyenne / j : −0,020 pt [−0,038 pt ; −0,013 pt] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Alertes ouvertes (toutes) : +168,5 [+135 ; +193,5], B moins bien (0 graines mieux, 30 moins bien, 0 égales)
- Avec filets — Naissances d’entreprises / an : +12,0 [+11,0 ; +14,4] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Naissances / an, en % du parc moyen : +43,5 [+41,1 ; +48,8] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts / an, en % du parc moyen : +31,1 [+27,3 ; +36,7] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Parc moyen d’entreprises (après la chauffe) : +6,9 [+6,3 ; +7,6] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : prix aberrant : +2 [+1 ; +3] (0 graines mieux, 0 moins bien, 4 égales)
- Avec filets — Fermetures : faillite (salaires impayables) : +32 [+26,5 ; +34] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Fermetures : demande perdue : +8,5 [+5,5 ; +11] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Morts d’entreprises / an : +9,6 [+8,8 ; +11,6] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : projets envisagés : +4895,5 [+4505 ; +5200,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : créations : +49,5 [+45 ; +59] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, une création déjà ce jour : +198 [+185,5 ; +253,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, délai entre deux créations du type : +176,5 [+93 ; +231] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, pas assez de chômeurs qualifiés : +522,5 [+450,5 ; +602] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : +3411,5 [+3178 ; +3853,5] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Types d’entreprise actifs en fin : +9 [+8 ; +10,5], B mieux (29 graines mieux, 1 moins bien, 0 égales)
- Avec filets — Machines en fin : +107,0 [+38,2 ; +172,0], B mieux (25 graines mieux, 5 moins bien, 0 égales)
- Avec filets — Équipes utilisées à moins de 15 % (fin) : +2 [+1 ; +3], B moins bien (4 graines mieux, 22 moins bien, 4 égales)
- Avec filets — Créances radiées : +2 716 $ [+1 896 $ ; +4 553 $] (0 graines mieux, 0 moins bien, 3 égales)

