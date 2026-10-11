# Comparaison appariée ÉcoNodes

- Date : 2026-10-11 14:42
- A : `complet-i1-i4.json`
- A — Modules coupés : Faillite ordonnée
- B : `complet-i1-i5.json`
- B — Modules coupés : aucun
- Graines appariées : 1 à 30 (30) · 1500 jours
- Période de chauffe : jours 1 à 100 (100 jours sur 1500), exclus des moyennes, des taux de filets et des renflouements (« après chauffe », jours 101 à 1500). Les maxima, les alertes ouvertes, les prêts refusés et l’écart comptable portent sur toute la partie (« toute la partie ») ; une ligne donne les alertes critiques ouvertes après la chauffe.
- Temps total : 0 s (synthèses relues, aucune partie lancée)

Pour chaque graine, d = B − A (même graine, même hasard). « Différence médiane » : médiane des d. « IC 95 % » : intervalle de confiance de cette médiane par bootstrap percentile (10 000 tirages des graines avec remise, graine du bootstrap fixe). Un effet n’est conclu que si l’intervalle exclut 0. « B mieux / moins bien / égal » : nombre de graines où B fait mieux, moins bien, ou exactement pareil, selon le sens de l’indicateur (chômage, faim, alertes, filets : plus bas est mieux ; santé, bonheur, trésor : plus haut est mieux ; Gini, inflation moyenne, prêts refusés, créances radiées : sans sens). Chaque ligne a environ 5 % de chances de sortir « concluante » sans effet réel : sur 40 lignes, une ou deux conclusions peuvent venir du hasard.

## Sans filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,9 % | 8,0 % | 4 → 4 | −0,02 pt | [−0,8 pt ; +0,7 pt] | 16 / 13 / 1 sur 30 | non concluant |
| Chômage max | 26,5 % | 27,1 % | — | +0,6 pt | [−0,8 pt ; +2,5 pt] | 11 / 17 / 2 sur 30 | non concluant |
| Faim moyenne | 7,1 % | 6,1 % | 30 → 29 | −0,04 pt | [−1,0 pt ; +0,5 pt] | 15 / 13 / 2 sur 30 | non concluant |
| Faim max | 95,2 % | 95,4 % | — | 0,0 pt | [−0,8 pt ; +0,6 pt] | 12 / 11 / 7 sur 30 | non concluant |
| Sans-abri moyen | 2,4 % | 2,6 % | 22 → 19 | +0,2 pt | [−0,4 pt ; +0,8 pt] | 12 / 17 / 1 sur 30 | non concluant |
| Sans-abri max | 42,7 % | 42,9 % | — | 0,0 pt | [−1,0 pt ; +2,1 pt] | 11 / 11 / 8 sur 30 | non concluant |
| Gini moyen | 0,34 | 0,35 | 1 → 3 | −0,001 | [−0,01 ; +0,02] | — / — / 1 | non concluant |
| Gini en fin de partie | 0,28 | 0,43 | — | +0,05 | [+0,001 ; +0,23] | — / — / 1 | **B plus haut** |
| Inflation moyenne / j | 0,069 % | 0,071 % | 0 → 0 | −0,002 pt | [−0,007 pt ; +0,002 pt] | — / — / 1 | non concluant |
| |Inflation| max / j | 31,8 % | 36,6 % | — | 0,0 pt | [−2,4 pt ; +2,9 pt] | 14 / 14 / 2 sur 30 | non concluant |
| |Inflation sur 100 j| max | 136,2 % | 136,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 6 / 8 / 16 sur 30 | non concluant |
| Alertes critiques ouvertes | 29 | 27,5 | 30 → 30 | −1 | [−4,5 ; +1,5] | 16 / 10 / 4 sur 30 | non concluant |
| … dont après la chauffe | 26,5 | 24,5 | — | −1 | [−4,5 ; +1,5] | 16 / 10 / 4 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 1525,5 | 1524,5 | — | +7 | [−74,5 ; +61] | 13 / 15 / 2 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 588 | 509 | — | −43 | [−122,5 ; 0] | 19 / 8 / 3 sur 30 | non concluant |
| Santé moyenne | 0,17 | 0,18 | — | −0,001 | [−0,01 ; +0,0005] | 10 / 18 / 2 sur 30 | non concluant |
| Bonheur moyen | 0,81 | 0,81 | — | −0,000001 | [−0,01 ; +0,01] | 14 / 15 / 1 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 454,7 | 512,9 | — | +3,1 | [−6,3 ; +35,2] | 10 / 18 / 2 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 2 / 4 / 24 sur 30 | non concluant |
| Trésor de l’État le plus bas | 94 272 $ | 90 804 $ | — | +13 $ | [−1 606 $ ; +2 445 $] | 15 / 12 / 3 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 5 / 2 / 23 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 20 | non concluant |
| Créances radiées | 20 219 $ | 18 445 $ | — | −695 $ | [−4 139 $ ; +1 778 $] | — / — / 1 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 3 → 6 | 0 | [0 ; 0] | 2 / 5 / 23 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 2 / 6 / 22 sur 30 | non concluant |
| Faim répandue | 6 | 5 | 30 → 30 | 0 | [−1,5 ; 0] | 14 / 9 / 7 sur 30 | non concluant |
| … jours-alerte | 150 | 130,5 | — | −3,5 | [−21,5 ; +15] | 16 / 11 / 3 sur 30 | non concluant |
| Sans-abri nombreux | 10,5 | 11 | 30 → 30 | 0 | [−1 ; +1,5] | 13 / 12 / 5 sur 30 | non concluant |
| … jours-alerte | 141 | 159 | — | +13 | [−21 ; +64,5] | 12 / 16 / 2 sur 30 | non concluant |
| Inflation quotidienne | 7,5 | 7 | 30 → 30 | −1 | [−2 ; +0,5] | 16 / 10 / 4 sur 30 | non concluant |
| … jours-alerte | 7,5 | 7 | — | −1 | [−2 ; +0,5] | 16 / 10 / 4 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 30 → 30 | 0 | [0 ; 0] | 6 / 5 / 19 sur 30 | non concluant |
| … jours-alerte | 31,5 | 37,5 | — | 0 | [0 ; 0] | 7 / 9 / 14 sur 30 | non concluant |
| Santé de la population effondrée | 1 | 1 | 30 → 30 | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| … jours-alerte | 1201 | 1207 | — | 0 | [0 ; 0] | 8 / 8 / 14 sur 30 | non concluant |

## Avec filets

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 7,0 % | 5 → 5 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 2 / 28 sur 30 | non concluant |
| Chômage max | 19,0 % | 19,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 2 / 28 sur 30 | non concluant |
| Faim max | 45,0 % | 45,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Sans-abri moyen | 0,2 % | 0,2 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 1 / 28 sur 30 | non concluant |
| Sans-abri max | 18,3 % | 18,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Gini moyen | 0,20 | 0,20 | 13 → 13 | 0,00 | [0,00 ; 0,00] | — / — / 28 | non concluant |
| Gini en fin de partie | 0,15 | 0,15 | — | 0,00 | [0,00 ; 0,00] | — / — / 28 | non concluant |
| Inflation moyenne / j | 0,040 % | 0,040 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 28 | non concluant |
| |Inflation| max / j | 47,8 % | 47,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 141,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 10 | 30 → 30 | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| … dont après la chauffe | 8 | 8 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 78,5 | 78,5 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 139,5 | 139,5 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 0 / 2 / 28 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [0,00 ; 0,00] | 0 / 2 / 28 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,3 | 0,3 | — | 0,0 | [0,0 ; 0,0] | 0 / 2 / 28 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 52 260 $ | 52 260 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 28 | non concluant |
| Filet : Anti-famine / 50 j | 0,18 | 0,18 | 10 → 10 | 0,00 | [0,00 ; 0,00] | 0 / 1 / 29 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,05 | 13,05 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 2 / 28 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 2,11 | 2,11 | 17 → 17 | 0,00 | [0,00 ; 0,00] | 1 / 1 / 28 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 2 → 2 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 17 → 17 | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| … jours-alerte | 1 | 1 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 19 → 19 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 8 | 8 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Inflation quotidienne | 7 | 7 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 7 | 7 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 46 | 50,5 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 3 → 3 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |

## Avec filets, sauf « Anti-famine »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,1 % | 7,1 % | 4 → 4 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Chômage max | 19,0 % | 19,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 1 → 1 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Faim max | 45,0 % | 45,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri moyen | 0,2 % | 0,2 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Sans-abri max | 17,9 % | 17,9 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Gini moyen | 0,20 | 0,20 | 13 → 13 | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Gini en fin de partie | 0,18 | 0,18 | — | 0,00 | [0,00 ; 0,00] | — / — / 30 | non concluant |
| Inflation moyenne / j | 0,040 % | 0,040 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 30 | non concluant |
| |Inflation| max / j | 45,8 % | 45,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 141,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 10 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … dont après la chauffe | 8 | 8 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 79 | 79 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 139 | 139 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,3 | 0,3 | — | 0,0 | [0,0 ; 0,0] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 57 414 $ | 57 414 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 30 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 11,95 | 11,95 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 2,11 | 2,11 | 17 → 17 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
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
| … jours-alerte | 8,5 | 8,5 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Inflation quotidienne | 6 | 6 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 6 | 6 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 46 | 46 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 3 → 3 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |

## Avec filets, sauf « Renflouement d’entreprise »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 8,0 % | 8,1 % | 5 → 4 | −0,5 pt | [−0,9 pt ; +0,3 pt] | 18 / 11 / 1 sur 30 | non concluant |
| Chômage max | 25,4 % | 25,8 % | — | 0,0 pt | [−2,1 pt ; +0,4 pt] | 14 / 12 / 4 sur 30 | non concluant |
| Faim moyenne | 3,5 % | 4,2 % | 27 → 25 | −0,1 pt | [−1,0 pt ; +0,8 pt] | 16 / 13 / 1 sur 30 | non concluant |
| Faim max | 95,0 % | 95,0 % | — | 0,0 pt | [−0,4 pt ; +0,2 pt] | 13 / 10 / 7 sur 30 | non concluant |
| Sans-abri moyen | 1,2 % | 1,2 % | 3 → 2 | −0,02 pt | [−0,1 pt ; +0,2 pt] | 15 / 14 / 1 sur 30 | non concluant |
| Sans-abri max | 35,8 % | 32,7 % | — | 0,0 pt | [−6,0 pt ; 0,0 pt] | 14 / 4 / 12 sur 30 | non concluant |
| Gini moyen | 0,34 | 0,36 | 1 → 1 | −0,0001 | [−0,01 ; +0,02] | — / — / 1 | non concluant |
| Gini en fin de partie | 0,35 | 0,37 | — | −0,005 | [−0,11 ; +0,07] | — / — / 1 | non concluant |
| Inflation moyenne / j | 0,060 % | 0,067 % | 0 → 0 | +0,004 pt | [−0,005 pt ; +0,020 pt] | — / — / 1 | non concluant |
| |Inflation| max / j | 35,5 % | 40,7 % | — | 0,0 pt | [−3,2 pt ; +6,4 pt] | 13 / 13 / 4 sur 30 | non concluant |
| |Inflation sur 100 j| max | 132,5 % | 134,6 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 6 / 5 / 19 sur 30 | non concluant |
| Alertes critiques ouvertes | 20 | 19 | 30 → 30 | −1 | [−2 ; +1,5] | 16 / 13 / 1 sur 30 | non concluant |
| … dont après la chauffe | 17,5 | 18 | — | −1 | [−2 ; +1,5] | 16 / 13 / 1 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 1383,5 | 1403,5 | — | −11,5 | [−40,5 ; +21,5] | 17 / 12 / 1 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 519 | 488 | — | −22,5 | [−54 ; +11] | 18 / 11 / 1 sur 30 | non concluant |
| Santé moyenne | 0,17 | 0,17 | — | +0,0003 | [−0,01 ; +0,01] | 15 / 14 / 1 sur 30 | non concluant |
| Bonheur moyen | 0,82 | 0,82 | — | +0,001 | [−0,001 ; +0,01] | 18 / 11 / 1 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 511,7 | 519,0 | — | +1,2 | [−15,9 ; +10,2] | 14 / 15 / 1 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 1 / 1 / 28 sur 30 | non concluant |
| Trésor de l’État le plus bas | 98 210 $ | 104 983 $ | — | 0 $ | [−1 106 $ ; +2 133 $] | 12 / 13 / 5 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 7 / 3 / 20 sur 30 | non concluant |
| Prêts refusés | 2,5 | 0 | — | 0 | [−2,5 ; 0] | — / — / 17 | non concluant |
| Créances radiées | 24 472 $ | 24 539 $ | — | −870 $ | [−3 470 $ ; +1 079 $] | — / — / 1 | non concluant |
| Filet : Anti-famine / 50 j | 112,75 | 131,54 | 30 → 28 | −2,54 | [−36,27 ; +24,43] | 15 / 14 / 1 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 28,46 | 31,95 | 30 → 30 | +0,04 | [−6,20 ; +3,25] | 14 / 15 / 1 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,09 | 0,00 | 12 → 9 | 0,00 | [−0,09 ; 0,00] | 10 / 3 / 17 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 3 → 3 | 0 | [0 ; 0] | 1 / 1 / 28 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 2 / 2 / 26 sur 30 | non concluant |
| Faim répandue | 6 | 6 | 30 → 29 | 0 | [−1 ; +1] | 12 / 11 / 7 sur 30 | non concluant |
| … jours-alerte | 108 | 121 | — | −4,5 | [−26 ; +23,5] | 16 / 13 / 1 sur 30 | non concluant |
| Sans-abri nombreux | 4 | 3 | 29 → 30 | 0 | [−1 ; +1] | 12 / 13 / 5 sur 30 | non concluant |
| … jours-alerte | 25,5 | 30 | — | +1 | [−1,5 ; +10,5] | 10 / 15 / 5 sur 30 | non concluant |
| Inflation quotidienne | 8 | 7 | 30 → 30 | −0,5 | [−1 ; +1] | 15 / 11 / 4 sur 30 | non concluant |
| … jours-alerte | 8 | 7 | — | −0,5 | [−1 ; +1] | 15 / 11 / 4 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 30 → 30 | 0 | [0 ; 0] | 8 / 2 / 20 sur 30 | non concluant |
| … jours-alerte | 32 | 30 | — | 0 | [0 ; 0] | 8 / 5 / 17 sur 30 | non concluant |
| Santé de la population effondrée | 1 | 1 | 30 → 29 | 0 | [0 ; 0] | 3 / 0 / 27 sur 30 | non concluant |
| … jours-alerte | 1205,5 | 1207,5 | — | 0 | [−0,5 ; 0] | 10 / 8 / 12 sur 30 | non concluant |

## Avec filets, sauf « Plancher de logement »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 7,0 % | 7 → 7 | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 2 / 27 sur 30 | non concluant |
| Chômage max | 18,8 % | 18,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Faim moyenne | 0,0 % | 0,0 % | 0 → 1 | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 1 / 27 sur 30 | non concluant |
| Faim max | 16,7 % | 16,7 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 2 / 27 sur 30 | non concluant |
| Sans-abri moyen | 0,3 % | 0,3 % | 4 → 4 | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 1 / 27 sur 30 | non concluant |
| Sans-abri max | 17,1 % | 17,1 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 2 / 0 / 28 sur 30 | non concluant |
| Gini moyen | 0,21 | 0,21 | 12 → 12 | 0,00 | [0,00 ; 0,00] | — / — / 27 | non concluant |
| Gini en fin de partie | 0,19 | 0,18 | — | 0,00 | [0,00 ; 0,00] | — / — / 27 | non concluant |
| Inflation moyenne / j | 0,041 % | 0,042 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 27 | non concluant |
| |Inflation| max / j | 40,8 % | 41,4 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 1 / 28 sur 30 | non concluant |
| |Inflation sur 100 j| max | 139,7 % | 139,7 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 11,5 | 11,5 | 30 → 30 | 0 | [0 ; 0] | 2 / 1 / 27 sur 30 | non concluant |
| … dont après la chauffe | 10 | 10 | — | 0 | [0 ; 0] | 2 / 1 / 27 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 102 | 102 | — | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 138,5 | 138,5 | — | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 1 / 2 / 27 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [0,00 ; 0,00] | 1 / 2 / 27 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,3 | 0,3 | — | 0,0 | [0,0 ; 0,0] | 1 / 2 / 27 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Trésor de l’État le plus bas | 56 168 $ | 56 168 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 1 / 29 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 27 | non concluant |
| Filet : Anti-famine / 50 j | 0,00 | 0,00 | 9 → 9 | 0,00 | [0,00 ; 0,00] | 1 / 2 / 27 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 16,59 | 17,20 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 1 / 2 / 27 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 0 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 3 → 3 | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Faim répandue | 0 | 0 | 14 → 14 | 0 | [0 ; 0] | 2 / 0 / 28 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 2 / 1 / 27 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 23 → 23 | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| … jours-alerte | 8,5 | 8,5 | — | 0 | [0 ; 0] | 1 / 2 / 27 sur 30 | non concluant |
| Inflation quotidienne | 7 | 6 | 30 → 30 | 0 | [0 ; 0] | 3 / 0 / 27 sur 30 | non concluant |
| … jours-alerte | 7 | 6 | — | 0 | [0 ; 0] | 3 / 0 / 27 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 30 → 30 | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| … jours-alerte | 41 | 41 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 4 → 4 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |

## Avec filets, sauf « Plafond de dérive des prix et salaires »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 7,0 % | 5 → 5 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 2 / 28 sur 30 | non concluant |
| Chômage max | 19,0 % | 19,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 2 / 28 sur 30 | non concluant |
| Faim max | 45,0 % | 45,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Sans-abri moyen | 0,2 % | 0,2 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 1 / 28 sur 30 | non concluant |
| Sans-abri max | 18,3 % | 18,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Gini moyen | 0,20 | 0,20 | 13 → 13 | 0,00 | [0,00 ; 0,00] | — / — / 28 | non concluant |
| Gini en fin de partie | 0,15 | 0,15 | — | 0,00 | [0,00 ; 0,00] | — / — / 28 | non concluant |
| Inflation moyenne / j | 0,040 % | 0,040 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 28 | non concluant |
| |Inflation| max / j | 47,8 % | 47,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 141,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 10 | 30 → 30 | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| … dont après la chauffe | 8 | 8 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 78,5 | 78,5 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 139,5 | 139,5 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 0 / 2 / 28 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [0,00 ; 0,00] | 0 / 2 / 28 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,3 | 0,3 | — | 0,0 | [0,0 ; 0,0] | 0 / 2 / 28 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 52 260 $ | 52 260 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 28 | non concluant |
| Filet : Anti-famine / 50 j | 0,18 | 0,18 | 10 → 10 | 0,00 | [0,00 ; 0,00] | 0 / 1 / 29 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,05 | 13,05 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 2 / 28 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 2,11 | 2,11 | 17 → 17 | 0,00 | [0,00 ; 0,00] | 1 / 1 / 28 sur 30 | non concluant |
| Filet : Anti-crédit-fou / 50 j | 0,00 | 0,00 | 1 → 1 | 0,00 | [0,00 ; 0,00] | 1 / 0 / 29 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 2 → 2 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 17 → 17 | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| … jours-alerte | 1 | 1 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 19 → 19 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 8 | 8 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Inflation quotidienne | 7 | 7 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 7 | 7 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 46 | 50,5 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 3 → 3 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |

## Avec filets, sauf « Anti-crédit-fou »

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage moyen | 7,0 % | 7,0 % | 5 → 5 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 2 / 28 sur 30 | non concluant |
| Chômage max | 19,0 % | 19,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Faim moyenne | 0,1 % | 0,1 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 2 / 28 sur 30 | non concluant |
| Faim max | 45,0 % | 45,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Sans-abri moyen | 0,2 % | 0,2 % | 0 → 0 | 0,0 pt | [0,0 pt ; 0,0 pt] | 1 / 1 / 28 sur 30 | non concluant |
| Sans-abri max | 18,3 % | 18,3 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 1 / 29 sur 30 | non concluant |
| Gini moyen | 0,20 | 0,20 | 13 → 13 | 0,00 | [0,00 ; 0,00] | — / — / 28 | non concluant |
| Gini en fin de partie | 0,15 | 0,15 | — | 0,00 | [0,00 ; 0,00] | — / — / 28 | non concluant |
| Inflation moyenne / j | 0,040 % | 0,040 % | 0 → 0 | 0,000 pt | [0,000 pt ; 0,000 pt] | — / — / 28 | non concluant |
| |Inflation| max / j | 47,8 % | 47,8 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| |Inflation sur 100 j| max | 141,0 % | 141,0 % | — | 0,0 pt | [0,0 pt ; 0,0 pt] | 0 / 0 / 30 sur 30 | non concluant |
| Alertes critiques ouvertes | 10 | 10 | 30 → 30 | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| … dont après la chauffe | 8 | 8 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Jours-alerte critiques (somme des types) | 78,5 | 78,5 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Alertes ouvertes (toutes) | 139,5 | 139,5 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Santé moyenne | 0,88 | 0,88 | — | 0,00 | [0,00 ; 0,00] | 0 / 2 / 28 sur 30 | non concluant |
| Bonheur moyen | 0,97 | 0,97 | — | 0,00 | [0,00 ; 0,00] | 0 / 2 / 28 sur 30 | non concluant |
| Hôpital public : attente moyenne (j) | 0,3 | 0,3 | — | 0,0 | [0,0 ; 0,0] | 0 / 2 / 28 sur 30 | non concluant |
| Jours de prestations réduites | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Trésor de l’État le plus bas | 52 260 $ | 52 260 $ | — | 0 $ | [0 $ ; 0 $] | 0 / 0 / 30 sur 30 | non concluant |
| Jours de Caisse insolvable | 0 | 0 | — | 0 | [0 ; 0] | 1 / 0 / 29 sur 30 | non concluant |
| Prêts refusés | 0 | 0 | — | 0 | [0 ; 0] | — / — / 29 | non concluant |
| Créances radiées | 0 $ | 0 $ | — | 0 $ | [0 $ ; 0 $] | — / — / 28 | non concluant |
| Filet : Anti-famine / 50 j | 0,18 | 0,18 | 10 → 10 | 0,00 | [0,00 ; 0,00] | 0 / 1 / 29 sur 30 | non concluant |
| Filet : Renflouement d’entreprise / 50 j | 13,05 | 13,05 | 30 → 30 | 0,00 | [0,00 ; 0,00] | 0 / 2 / 28 sur 30 | non concluant |
| Filet : Plancher de logement / 50 j | 2,11 | 2,11 | 17 → 17 | 0,00 | [0,00 ; 0,00] | 1 / 1 / 28 sur 30 | non concluant |
| Filet : Plafond de dérive des prix et salaires / 50 j | 0,00 | 0,00 | 0 → 0 | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| … dont renflouements de l’hôpital / 50 j | 0,00 | 0,00 | — | 0,00 | [0,00 ; 0,00] | 0 / 0 / 30 sur 30 | non concluant |
| Écart comptable max ($) | 0.0e+0 | 0.0e+0 | 0 → 0 | 0.0e+0 | [0.0e+0 ; 0.0e+0] | 0 / 0 / 30 sur 30 | non concluant |

### Alertes critiques, par type (ouvertures et jours-alerte, sur toute la partie)

| Indicateur | Médiane A | Médiane B | Hors bande A → B | Différence médiane (B − A) | IC 95 % | B mieux / moins bien / égal | Conclusion |
|---|---|---|---|---|---|---|---|
| Chômage très élevé | 0 | 0 | 2 → 2 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Faim répandue | 1 | 1 | 17 → 17 | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| … jours-alerte | 1 | 1 | — | 0 | [0 ; 0] | 0 / 2 / 28 sur 30 | non concluant |
| Sans-abri nombreux | 1 | 1 | 19 → 19 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 8 | 8 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Inflation quotidienne | 7 | 7 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 7 | 7 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| Inflation sur 100 jours | 2 | 2 | 30 → 30 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 46 | 50,5 | — | 0 | [0 ; 0] | 0 / 1 / 29 sur 30 | non concluant |
| Santé de la population effondrée | 0 | 0 | 3 → 3 | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |
| … jours-alerte | 0 | 0 | — | 0 | [0 ; 0] | 0 / 0 / 30 sur 30 | non concluant |

## Effets concluants (intervalle excluant 0)

- Sans filets — Gini en fin de partie : +0,05 [+0,001 ; +0,23] (0 graines mieux, 0 moins bien, 1 égales)

