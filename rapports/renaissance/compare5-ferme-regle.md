# Comparaison appariée ÉcoNodes

- Date : 2026-10-21 18:36
- A : `g5-ferme-ref.json`
- A — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B : `g5-ferme-signal.json`
- B — Modules coupés : Bâtiments, construction et hypothèques, Rôles, contrats et négociation salariale
- B — Paramètres changés : revival = 1, revivalHours = 0
- Graines appariées : 1 à 5 (5) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,3 % | 7,9 % | 0 → 1 | −0,4 pt | [−1,1 pt ; +2,1 pt] | 3 / 2 / 0 sur 5 | non concluant |
| Chômage max | 24,2 % | 24,2 % | — | 0,0 pt | [−3,3 pt ; +0,8 pt] | 2 / 2 / 1 sur 5 | non concluant |
| Faim moyenne | 0,2 % | 0,2 % | 0 → 0 | +0,0003 pt | [−0,03 pt ; +0,2 pt] | 1 / 3 / 1 sur 5 | non concluant |
| Faim max | 47,9 % | 51,2 % | — | +0,4 pt | [−34,2 pt ; +25,0 pt] | 1 / 3 / 1 sur 5 | non concluant |
| Sans-abri moyen | 0,4 % | 0,2 % | 0 → 0 | +0,001 pt | [−0,6 pt ; +1,0 pt] | 2 / 3 / 0 sur 5 | non concluant |
| Sans-abri max | 47,5 % | 42,1 % | — | 0,0 pt | [−23,8 pt ; +0,8 pt] | 2 / 1 / 2 sur 5 | non concluant |
| Gini moyen | 0,28 | 0,27 | 0 → 0 | +0,01 | [−0,02 ; +0,03] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,29 | 0,29 | — | +0,02 | [−0,10 ; +0,12] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,050 % | -0,051 % | 0 → 0 | +0,002 pt | [−0,034 pt ; +0,008 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 20,9 % | 19,5 % | — | 0,0 pt | [−14,8 pt ; 0,0 pt] | 1 / 0 / 4 sur 5 | non concluant |
| |Inflation sur 100 j| max | 109,8 % | 109,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 5 sur 5 | non concluant |
| Alertes critiques ouvertes | 18 | 19 | 5 → 5 | −2 | [−3 ; +4] | 3 / 2 / 0 sur 5 | non concluant |
| … dont après la chauffe | 17 | 15 | — | −2 | [−3 ; +4] | 3 / 2 / 0 sur 5 | non concluant |
| Jours-alerte critiques (somme des types) | 69 | 67 | — | −5 | [−31 ; +50] | 4 / 1 / 0 sur 5 | non concluant |
| Alertes ouvertes (toutes) | 397 | 354 | — | +14 | [−121 ; +61] | 2 / 3 / 0 sur 5 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,00004 | [−0,001 ; +0,001] | 3 / 2 / 0 sur 5 | non concluant |
| Naissances d’entreprises / an | 10,5 | 9,5 | — | −1,0 | [−3,9 ; +4,1] | — / — / 0 | non concluant |
| Naissances / an, en % du parc moyen | 34,0 | 29,5 | — | −4,5 | [−11,5 ; +12,5] | — / — / 0 | non concluant |
| Morts / an, en % du parc moyen | 26,5 | 28,9 | — | −3,4 | [−7,6 ; +12,5] | — / — / 0 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 32,7 | 32,1 | — | +0,2 | [−1,4 ; +1,4] | — / — / 0 | non concluant |
| Demande non servie (part des unités demandées) | 1,7 % | 1,6 % | — | −0,05 pt | [−0,6 pt ; +0,2 pt] | 3 / 2 / 0 sur 5 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 12,8 % | 18,7 % | — | +6,2 pt | [−1,2 pt ; +8,1 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; +0,02 pt] | — / — / 3 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; +0,0003] | — / — / 3 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | 0 | [−1 ; +1] | — / — / 3 | non concluant |
| Fermetures : faillite (salaires impayables) | 28 | 32 | — | −1 | [−6 ; +13] | — / — / 0 | non concluant |
| Fermetures : demande perdue | 3 | 4 | — | +1 | [−2 ; +3] | — / — / 0 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 5 | 2 | — | −2 | [−5 ; +2] | — / — / 1 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 5 | non concluant |
| Morts d’entreprises / an | 8,8 | 9,5 | — | −1,2 | [−2,9 ; +4,1] | — / — / 0 | non concluant |
| Entonnoir : projets envisagés | 9476 | 10189 | — | +764 | [−326 ; +1722] | — / — / 0 | non concluant |
| Entonnoir : créations | 43 | 39 | — | −4 | [−16 ; +17] | — / — / 0 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 250 | 229 | — | −1 | [−145 ; +131] | — / — / 0 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 1605 | 1286 | — | −219 | [−978 ; +281] | — / — / 0 | non concluant |
| Entonnoir : refus, concurrence | 2577 | 2497 | — | −36 | [−202 ; +203] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 3707 | 3378 | — | +10 | [−554 ; +420] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 243 | 270 | — | −26 | [−127 ; +161] | — / — / 0 | non concluant |
| Entonnoir : refus, viabilité | 715 | 1644 | — | +937 | [+675 ; +1160] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 296 | 650 | — | +115 | [−62 ; +369] | — / — / 1 | non concluant |
| Types d’entreprise actifs en fin | 29 | 29 | — | +1 | [−5 ; +1] | 3 / 1 / 1 sur 5 | non concluant |
| Machines en fin | 409,0 | 430,0 | — | +5,2 | [−148,5 ; +158,3] | 3 / 2 / 0 sur 5 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 2 | — | −1 | [−2 ; −1] | 5 / 0 / 0 sur 5 | **B plus bas (mieux)** |
| Bonheur moyen | 0,97 | 0,97 | — | −0,0001 | [−0,005 ; +0,003] | 2 / 3 / 0 sur 5 | non concluant |
| Hôpital public : attente moyenne (j) | 0,5 | 0,5 | — | −0,002 | [−0,1 ; +0,2] | 3 / 2 / 0 sur 5 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 5 sur 5 | non concluant |
| Trésor de l’État le plus bas | 83 783 $ | 77 287 $ | — | 0 $ | [−55 519 $ ; +37 093 $] | 2 / 2 / 1 sur 5 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [−453 ; 0] | 1 / 0 / 4 sur 5 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [−235 ; +319] | — / — / 3 | non concluant |
| Créances radiées | 15 978 $ | 22 191 $ | — | 0 $ | [−11 455 $ ; +6 213 $] | — / — / 1 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 5 sur 5 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Faim répandue | 1 | 1 | 5 → 4 | 0 | [−1 ; 0] | 1 / 0 / 4 sur 5 | non concluant |
| … jours-alerte | 9 | 9 | — | 0 | [−1 ; +4] | 1 / 1 / 3 sur 5 | non concluant |
| Sans-abri nombreux | 3 | 3 | 5 → 5 | 0 | [−2 ; +4] | 2 / 1 / 2 sur 5 | non concluant |
| … jours-alerte | 37 | 20 | — | −5 | [−26 ; +50] | 4 / 1 / 0 sur 5 | non concluant |
| Inflation quotidienne | 12 | 11 | 5 → 5 | 0 | [−2 ; +1] | 1 / 1 / 3 sur 5 | non concluant |
| … jours-alerte | 12 | 11 | — | 0 | [−4 ; +1] | 2 / 1 / 2 sur 5 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 5 → 5 | 0 | [0 ; 0] | 0 / 0 / 5 sur 5 | non concluant |
| … jours-alerte | 19 | 19 | — | 0 | [0 ; 0] | 0 / 0 / 5 sur 5 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,8 % | 7,3 % | 1 → 1 | −0,5 pt | [−14,4 pt ; +5,9 pt] | 3 / 2 / 0 sur 5 | non concluant |
| Chômage max | 20,8 % | 20,0 % | — | −0,8 pt | [−20,0 pt ; +14,2 pt] | 3 / 2 / 0 sur 5 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 5 sur 5 | non concluant |
| Faim max | 0,0 % | 0,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 5 sur 5 | non concluant |
| Sans-abri moyen | 0,3 % | 0,0 % | 0 → 0 | −0,3 pt | [−0,9 pt ; +0,02 pt] | 4 / 1 / 0 sur 5 | non concluant |
| Sans-abri max | 31,7 % | 31,7 % | — | 0,0 pt | [−17,5 pt ; +16,2 pt] | 2 / 1 / 2 sur 5 | non concluant |
| Gini moyen | 0,25 | 0,23 | 0 → 0 | −0,01 | [−0,07 ; +0,01] | — / — / 0 | non concluant |
| Gini en fin de partie | 0,28 | 0,25 | — | −0,03 | [−0,16 ; +0,04] | — / — / 0 | non concluant |
| Inflation moyenne / j | -0,048 % | -0,043 % | 0 → 0 | +0,005 pt | [−0,013 pt ; +0,032 pt] | — / — / 0 | non concluant |
| |Inflation| max / j | 21,3 % | 34,8 % | — | 0,0 pt | [0,0 pt ; +13,5 pt] | 0 / 2 / 3 sur 5 | non concluant |
| |Inflation sur 100 j| max | 108,3 % | 105,7 % | — | 0,0 pt | [−26,5 pt ; 0,0 pt] | 1 / 0 / 4 sur 5 | non concluant |
| Alertes critiques ouvertes | 16 | 13 | 5 → 5 | −3 | [−11 ; 0] | 4 / 0 / 1 sur 5 | non concluant |
| … dont après la chauffe | 14 | 10 | — | −3 | [−11 ; 0] | 4 / 0 / 1 sur 5 | non concluant |
| Jours-alerte critiques (somme des types) | 99 | 37 | — | −24 | [−235 ; −8] | 5 / 0 / 0 sur 5 | **B plus bas (mieux)** |
| Alertes ouvertes (toutes) | 297 | 268 | — | −28 | [−91 ; +64] | 3 / 2 / 0 sur 5 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | +0,0001 | [−0,01 ; +0,03] | 4 / 1 / 0 sur 5 | non concluant |
| Naissances d’entreprises / an | 5,6 | 4,4 | — | 0,0 | [−2,2 ; +0,7] | — / — / 2 | non concluant |
| Naissances / an, en % du parc moyen | 20,1 | 14,6 | — | −0,5 | [−6,4 ; +3,4] | — / — / 0 | non concluant |
| Morts / an, en % du parc moyen | 18,7 | 16,8 | — | −1,2 | [−4,9 ; +3,3] | — / — / 0 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 31,2 | 31,8 | — | +0,4 | [−2,0 ; +1,2] | — / — / 0 | non concluant |
| Demande non servie (part des unités demandées) | 1,2 % | 0,9 % | — | −0,5 pt | [−1,3 pt ; +0,3 pt] | 3 / 2 / 0 sur 5 | non concluant |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 26,3 % | 17,7 % | — | +1,1 pt | [−9,7 pt ; +4,7 pt] | — / — / 0 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 5 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 5 | non concluant |
| Fermetures : prix aberrant | 1 | 1 | — | −1 | [−2 ; 0] | — / — / 2 | non concluant |
| Fermetures : faillite (salaires impayables) | 17 | 18 | — | 0 | [−3 ; +6] | — / — / 1 | non concluant |
| Fermetures : demande perdue | 2 | 1 | — | −1 | [−1 ; +2] | — / — / 1 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 2 | 1 | — | 0 | [−3 ; 0] | — / — / 3 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 5 | non concluant |
| Morts d’entreprises / an | 5,8 | 5,1 | — | −0,2 | [−1,7 ; +0,7] | — / — / 0 | non concluant |
| Entonnoir : projets envisagés | 8013 | 9289 | — | +946 | [+118 ; +2073] | — / — / 0 | **B plus haut** |
| Entonnoir : créations | 23 | 18 | — | 0 | [−9 ; +3] | — / — / 2 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 155 | 102 | — | −44 | [−90 ; +14] | — / — / 0 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 757 | 487 | — | −330 | [−417 ; −160] | — / — / 0 | **B plus bas** |
| Entonnoir : refus, concurrence | 2604 | 2391 | — | −114 | [−381 ; +382] | — / — / 0 | non concluant |
| Entonnoir : refus, demande insuffisante | 3171 | 3157 | — | −273 | [−446 ; +564] | — / — / 0 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 180 | 163 | — | −17 | [−271 ; +255] | — / — / 0 | non concluant |
| Entonnoir : refus, viabilité | 521 | 2216 | — | +1830 | [+655 ; +2040] | — / — / 0 | **B plus haut** |
| Entonnoir : refus, aucun fondateur assez riche | 63 | 485 | — | +9 | [−464 ; +500] | — / — / 0 | non concluant |
| Types d’entreprise actifs en fin | 29 | 29 | — | 0 | [−1 ; +2] | 2 / 2 / 1 sur 5 | non concluant |
| Machines en fin | 429,6 | 345,7 | — | −84,0 | [−110,8 ; +214,5] | 1 / 4 / 0 sur 5 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 2 | 2 | — | 0 | [−5 ; +2] | 2 / 2 / 1 sur 5 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | +0,001 | [−0,01 ; +0,04] | 3 / 2 / 0 sur 5 | non concluant |
| Hôpital public : attente moyenne (j) | 0,4 | 0,4 | — | −0,02 | [−7,6 ; +1,2] | 4 / 1 / 0 sur 5 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; +14] | 0 / 1 / 4 sur 5 | non concluant |
| Trésor de l’État le plus bas | 77 930 $ | 98 651 $ | — | +1 820 $ | [−74 952 $ ; +87 689 $] | 3 / 2 / 0 sur 5 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 5 sur 5 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 5 | non concluant |
| Créances radiées | 5 419 $ | 2 399 $ | — | −900 $ | [−11 759 $ ; +263 $] | — / — / 0 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 5 sur 5 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 5,75 | 4,25 | 5 → 5 | +0,21 | [−6,18 ; +2,11] | 2 / 3 / 0 sur 5 | non concluant |
| Filet : Plancher de logement / 50 j | 3,14 | 0,07 | 4 → 1 | −2,32 | [−17,96 ; +2,75] | 4 / 1 / 0 sur 5 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 5 sur 5 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 5 sur 5 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 5 sur 5 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 5 sur 5 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 1 → 1 | 0 | [−5 ; +1] | 1 / 1 / 3 sur 5 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [−226 ; +25] | 1 / 1 / 3 sur 5 | non concluant |
| Faim répandue | 0 | 0 | 1 → 1 | 0 | [0 ; 0] | 0 / 0 / 5 sur 5 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 5 sur 5 | non concluant |
| Sans-abri nombreux | 2 | 1 | 5 → 4 | −2 | [−3 ; 0] | 4 / 0 / 1 sur 5 | non concluant |
| … jours-alerte | 34 | 10 | — | −22 | [−28 ; −5] | 5 / 0 / 0 sur 5 | **B plus bas (mieux)** |
| Inflation quotidienne | 11 | 10 | 5 → 5 | −2 | [−4 ; +1] | 3 / 2 / 0 sur 5 | non concluant |
| … jours-alerte | 11 | 10 | — | −2 | [−4 ; +1] | 3 / 2 / 0 sur 5 | non concluant |
| Inflation sur 100 jours | 1 | 1 | 4 → 4 | 0 | [−1 ; 0] | 1 / 0 / 4 sur 5 | non concluant |
| … jours-alerte | 9 | 9 | — | 0 | [−65 ; 0] | 1 / 0 / 4 sur 5 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Entonnoir : refus, viabilité : +937 [+675 ; +1160] (0 graines mieux, 0 moins bien, 0 égales)
- Sans filets — Équipes utilisées à moins de 15 % (fin) : −1 [−2 ; −1], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Jours-alerte critiques (somme des types) : −24 [−235 ; −8], B mieux (5 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : projets envisagés : +946 [+118 ; +2073] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, délai entre deux créations du type : −330 [−417 ; −160] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Entonnoir : refus, viabilité : +1830 [+655 ; +2040] (0 graines mieux, 0 moins bien, 0 égales)
- Avec filets — Sans-abri nombreux : jours-alerte : −22 [−28 ; −5], B mieux (5 graines mieux, 0 moins bien, 0 égales)

