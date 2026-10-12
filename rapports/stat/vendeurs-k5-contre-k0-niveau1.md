# Comparaison appariée ÉcoNodes

- Date : 2026-10-12 15:16
- A : `ref`
- A — Modules coupés : Bâtiments, construction et hypothèques
- A — Paramètres changés : population = 240
- B : `param:sellerSample=5`
- B — Modules coupés : Bâtiments, construction et hypothèques
- B — Paramètres changés : population = 240, sellerSample = 5
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 2 min 6 s pour 120 parties, au plus 16 à la fois (un isolat par partie)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,0 % | 8,0 % | 4 → 4 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 27,1 % | 27,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 6,1 % | 6,1 % | 29 → 29 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 95,4 % | 95,4 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 2,6 % | 2,6 % | 19 → 19 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 42,9 % | 42,9 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,35 | 0,35 | 3 → 3 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,43 | 0,43 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,071 % | 0,071 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 36,6 % | 36,6 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 136,1 % | 136,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 27,5 | 27,5 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 24,5 | 24,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 1524,5 | 1524,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 509 | 509 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 0,18 | 0,18 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Naissances d’entreprises / an | 27,1 | 27,1 | — | 0,0 | [0,0 ; 0,0] | — / — / 30 | non concluant |
| Naissances / an, en % du parc moyen | 147,3 | 147,3 | — | 0,0 | [0,0 ; 0,0] | — / — / 30 | non concluant |
| Morts / an, en % du parc moyen | 165,4 | 165,4 | — | 0,0 | [0,0 ; 0,0] | — / — / 30 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 17,8 | 17,8 | — | 0,0 | [0,0 ; 0,0] | — / — / 30 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 7 | 7 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Fermetures : faillite (salaires impayables) | 116 | 116 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Fermetures : demande perdue | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 30,9 | 30,9 | — | 0,0 | [0,0 ; 0,0] | — / — / 30 | non concluant |
| Entonnoir : projets envisagés | 16947 | 16947 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : créations | 111,5 | 111,5 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 693,5 | 693,5 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 5542,5 | 5542,5 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, concurrence | 1534,5 | 1534,5 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, demande insuffisante | 1278 | 1278 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 812 | 812 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, viabilité | 5641,5 | 5641,5 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, aucun fondateur assez riche | 1021 | 1021 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Types d’entreprise actifs en fin | 13 | 13 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Machines en fin | 0,2 | 0,2 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 1 | 1 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 0,81 | 0,81 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 512,9 | 512,9 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 90 804 $ | 90 804 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 18 445 $ | 18 445 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 6 → 6 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Faim répandue | 5 | 5 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 130,5 | 130,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri nombreux | 11 | 11 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 159 | 159 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Inflation quotidienne | 7 | 7 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 7 | 7 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 37,5 | 37,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé de la population effondrée | 1 | 1 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 1207 | 1207 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 7,0 % | 5 → 5 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 19,0 % | 19,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 45,0 % | 45,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,2 % | 0,2 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 18,3 % | 18,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,20 | 0,20 | 13 → 13 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,15 | 0,15 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,040 % | 0,040 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 47,8 % | 47,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 141,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 10 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 8 | 8 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 78,5 | 78,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 139,5 | 139,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Naissances d’entreprises / an | 3,4 | 3,4 | — | 0,0 | [0,0 ; 0,0] | — / — / 30 | non concluant |
| Naissances / an, en % du parc moyen | 15,1 | 15,1 | — | 0,0 | [0,0 ; 0,0] | — / — / 30 | non concluant |
| Morts / an, en % du parc moyen | 25,9 | 25,9 | — | 0,0 | [0,0 ; 0,0] | — / — / 30 | non concluant |
| Parc moyen d’entreprises (après la chauffe) | 22,3 | 22,3 | — | 0,0 | [0,0 ; 0,0] | — / — / 30 | non concluant |
| Part de la plus grande entreprise (médiane des biens) | 100,0 % | 100,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | — / — / 30 | non concluant |
| Herfindahl des ventes (médiane des biens) | 1,00 | 1,00 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Fermetures : prix aberrant | 10,5 | 10,5 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Fermetures : faillite (salaires impayables) | 12,5 | 12,5 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Fermetures : demande perdue | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Fermetures : sans employé (départs, postes non pourvus) | 1 | 1 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Fermetures : autre | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Morts d’entreprises / an | 5,8 | 5,8 | — | 0,0 | [0,0 ; 0,0] | — / — / 30 | non concluant |
| Entonnoir : projets envisagés | 8102,5 | 8102,5 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : créations | 14 | 14 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, une création déjà ce jour | 48 | 48 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, délai entre deux créations du type | 566,5 | 566,5 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, concurrence | 1521,5 | 1521,5 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, demande insuffisante | 1779 | 1779 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, pas assez de chômeurs qualifiés | 418,5 | 418,5 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, viabilité | 3812 | 3812 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Entonnoir : refus, aucun fondateur assez riche | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Types d’entreprise actifs en fin | 20 | 20 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Machines en fin | 2,6 | 2,6 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Équipes utilisées à moins de 15 % (fin) | 3 | 3 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,3 | 0,3 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 52 260 $ | 52 260 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Anti-famine / 50 j | 0,18 | 0,18 | 10 → 10 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,05 | 13,05 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 2,11 | 2,11 | 17 → 17 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 2 → 2 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 17 → 17 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 1 | 1 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 19 → 19 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 8 | 8 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Inflation quotidienne | 7 | 7 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 7 | 7 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 50,5 | 50,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 3 → 3 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

Aucun.

