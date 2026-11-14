# Rénovation sur 18 000 jours : 20 graines, 2 500 citoyens, filets coupés

Lot demandé par Francis le 14 novembre (« lances un test de 20 graines sans filets seulement sur 18 000 jours sur mon
pc »). Sur le PC, révision `93033b5` (`feature/renovation`), du 14 novembre 12:59 à 14:15 (heure locale, 1 h 16, 12 parties
à la fois, ≈ 36 s par 250 jours). Les 20 parties sont allées au bout.

Réglages : ceux du lot `derive36k` (`rapports/derive36k.md`) plus le module Rénovation : `tool/derive.dart`,
`parametresInterface(2500)`, Produits, Bâtiments, Banques et Rénovation actifs, filets tous coupés (`--filets 0`),
graines 1 à 20. Comparaison : les mêmes graines de `derive36k` sans filets (sans Rénovation, révision `4b7a132`, ancêtre de
la branche), jours ≤ 18 000. Données : `rapports/donnees/reno18k/` (`releves.csv`, une ligne par relevé de 250 jours, avec
l'état du parc et les entreprises actives de chaque métier ; `agg18k.txt` et `agg18k.py`).

## 1. Résumé

- **Le parc de départ ne vieillit plus d'un bloc** : sans rénovation, les premiers sans-abri arrivent vers le jour 16 750 et
  toutes les graines en ont au jour 18 000 (10 à 160). Avec la rénovation, aucun sans-abri au jour 18 000 dans 19 graines
  sur 20, aucun bâtiment terminé inhabitable avant le jour 15 000.
- **La lente déflation disparaît** : sans rénovation, l'indice passe de 2,4 à 1,6 et le salaire de 560 à 360 $, parce que
  les hypothèques remboursées ne sont pas remplacées (24 → 11 M$). Avec la rénovation, les prêts de rénovation les
  remplacent : hypothèques 21-25 M$, indice 2,2-2,4, salaire 490-550 $.
- **Le chômage ne change pas** : 5,5 % contre 5,5 % sur les jours 15 001-18 000 (plus haut dans 10 graines sur 20).
- **Mais l'entrepreneur général n'est pas stable** : actif dans 86 % des relevés les 3 000 premiers jours, puis 37 à 44 %
  après le jour 6 000 ; la briqueterie, 20 à 22 %. Sans lui, les chantiers attendent (jusqu'à 1 355 bâtiments) et l'état du
  parc baisse d'environ 1 % par an. Quand un entrepreneur revient après une longue absence, une vague de prêts et
  d'inflation suit (§ 3).

## 2. Chiffres par tranche de 3 000 jours

Moyenne des 20 graines, sans rénovation / avec ; indice : médiane des relevés.

| Jours | Chômage | Indice | Salaire | Sans-abri | Hypothèques (M$) | Bâtiments |
|---|---|---|---|---|---|---|
| 1-3 000 | 2,7 / 2,8 % | 2,17 / 2,04 | 455 / 418 | 0 / 0 | 16,8 / 14,0 | 1 896 / 1 900 |
| 3 001-6 000 | 4,5 / 4,6 % | 2,41 / 2,36 | 561 / 550 | 0 / 0 | 24,2 / 23,4 | 1 903 / 1 912 |
| 6 001-9 000 | 5,2 / 5,0 % | 2,20 / 2,32 | 505 / 542 | 0 / 0 | 22,0 / 24,5 | 1 907 / 1 918 |
| 9 001-12 000 | 5,3 / 5,3 % | 1,92 / 2,29 | 437 / 519 | 0 / 0 | 17,1 / 22,8 | 1 911 / 1 922 |
| 12 001-15 000 | 5,4 / 5,5 % | 1,73 / 2,18 | 392 / 494 | 0 / 0 | 13,6 / 21,5 | 1 916 / 1 926 |
| 15 001-18 000 | 5,5 / 5,5 % | 1,59 / 2,32 | 357 / 549 | 28 / 2 | 10,9 / 25,1 | 1 921 / 1 937 |

Avec la rénovation seulement :

| Jours | État moyen du parc | Bâtiments en attente de rénovation | Rénovations faites (cumul) | Bâtiments neufs (cumul) |
|---|---|---|---|---|
| 1-3 000 | 0,802 | 7 | 200 | 39 |
| 3 001-6 000 | 0,797 | 37 | 556 | 52 |
| 6 001-9 000 | 0,779 | 121 | 854 | 56 |
| 9 001-12 000 | 0,759 | 225 | 1 136 | 60 |
| 12 001-15 000 | 0,740 | 333 | 1 409 | 63 |
| 15 001-18 000 | 0,775 | 275 | 1 879 | 73 |

Écarts appariés par graine (avec − sans), jours 15 001-18 000 : indice + 0,93 (plus haut dans 19 graines sur 20), salaire
+ 192 $ (19 sur 20), hypothèques + 14,2 M$ (19 sur 20), sans-abri − 26 (plus haut dans 1 graine sur 20), chômage − 0,1 point
(10 sur 20). Ni hyperinflation (indice > 10) ni affamés, avec ou sans rénovation, avant le jour 18 000.

## 3. L'entrepreneur général meurt et revient par vagues

Par graine : 3 à 9 périodes d'activité de l'entrepreneur général, actif dans 28 à 72 % des relevés, plus longue absence de
1 750 à 10 500 jours. Pendant une absence, les métiers continuent l'entretien, mais personne ne vend de module : les
bâtiments sous le seuil de rénovation s'accumulent (graines 6, 8 et 10 au jour 18 000 : ≈ 1 000 en attente, parc à 0,59-0,62
et en baisse de 0,04 tous les 1 500 jours).

Les trois graines aux plus longues absences (1 : 9 750 j, 9 : 9 250 j, 11 : 10 500 j) sont les seules où des sans-abri
apparaissent (au plus 153, 44 et 127 ; un seul, un relevé, dans la graine 9 au jour 6 750) et celles où le parc descend le
plus bas (0,52 à 0,55). Ce n'est pas la ruine qui les met à la rue : dans les trois, ils apparaissent après le retour de
l'entrepreneur, pendant la vague de rattrapage, quand 11 à 16 entrepreneurs sont fondés d'un coup (graine 9 au jour
15 000, graine 11 au jour 15 500, graine 1 au jour 16 000). Graine 11 :

- jour 15 500 : 16 entrepreneurs généraux fondés d'un coup devant 1 351 bâtiments en attente ;
- en 500 jours : hypothèques 9,8 → 43,9 M$, indice 1,44 → 4,09, salaire 324 → 894 $, attente 1 351 → 548 ;
- jusqu'au jour 18 000 : indice 5,66, hypothèques 52 M$, parc 0,90, chômage 4 à 6 %, sans-abri par intermittence (127 au
  jour 17 000, 93 au jour 18 000). Cause de ces sans-abri non vérifiée (loyers qui suivent l'inflation ?).

Graine 1 : jour 15 750 → 16 500, hypothèques 12,6 → 44,6 M$, indice 1,68 → 3,92, attente 1 238 → 268, 12 charpentiers ;
153 sans-abri au jour 17 250. Graine 9 : jour 15 000 → 15 500, hypothèques 16,7 → 39,8 M$, indice 1,32 → 3,71, attente
928 → 176 ; 44 sans-abri au jour 16 000.

## 4. À faire

- Comprendre pourquoi l'entrepreneur général meurt une fois la première vague passée (demande qui retombe, prix, capital)
  et le garder en vie, ou faire revenir plus tôt un seul fondateur plutôt que seize d'un coup.
- Prolonger au-delà de 18 000 jours (le lot de 36 000 jours sans rénovation décroche vers 24 000-26 000) une fois
  l'entrepreneur stabilisé.
