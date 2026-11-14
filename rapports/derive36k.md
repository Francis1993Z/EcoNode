# Dérive sur 36 000 jours : 2 500 citoyens, tous les modules, sans et avec filets

Lot demandé par Francis le 11 novembre (« 20 graines sur 36000 jours avec tout les modules activés sans filet et avec
filet »). Serveur de calcul, révision `4b7a13272921` (`main`), du 12 novembre 00:09 à 07:29 UTC (7 h 20, 8 parties à la fois,
≈ 1 h 25 par partie). Avant le lot : référence identique (32 éléments) sur le serveur, parité PC ↔ serveur identique.

Réglages : `tool/derive.dart`, `parametresInterface(2500)` (réglages de l'interface), Produits, Bâtiments et Banques actifs
en plus des rôles, de l'entrepreneuriat et des modules par défaut ; frontières fermées. Filets tous coupés (`--filets 0`)
ou tous actifs (`--filets 1`), 20 graines chacun. Un relevé tous les 250 jours. Données : `rapports/donnees/derive36k/`
(`releves.csv`, une ligne par relevé ; `agg36k.txt`, toutes les tranches ; `agg36k.py`).

39 parties sur 40 sont allées au bout. La graine 10 sans filets s'arrête au jour ≈ 35 300 (voir § 4).

## 1. Résumé

- **Pendant ≈ 60 ans, l'économie tient** : chômage 2,7 % les 3 000 premiers jours, puis 4,5 à 6,5 % jusqu'au jour 24 000,
  sans affamés ni sans-abri jusqu'au jour ≈ 15 000, avec ou sans filets.
- **Mais les prix et les salaires baissent lentement** : indice médian 2,4-2,5 (jours 3 001-6 000) → 1,5-1,6 (jours
  18 001-24 000), salaire 550-560 → 305-325 $. La monnaie se contracte avec les hypothèques qu'on rembourse
  (22-24 M$ → 5-8 M$) sans nouvelles hypothèques pour les remplacer.
- **Vers 60-70 ans, les bâtiments du départ tombent en ruine tous en même temps** (§ 2). Les locataires se retrouvent à la
  rue (≈ 450 à 690 sans-abri), puis le chômage monte dans presque toutes les graines vers le jour 24 000 à 26 000.
- **Ensuite, les filets font la différence** : sans eux, chômage médian 10 à 22 % et hyperinflation dans 6 graines sur 20
  (indice > 10 ; jusqu'à des millions, graines 10, 12 et 18) ; avec eux, chômage médian 6 à 9 %, 4 graines sur 20
  au-dessus de 10.

## 2. Cause probable de la crise : le parc de départ vieillit d'un bloc

Un bâtiment est habitable tant que son état reste au moins à 0,3 (`Building.minCond`). L'usure est de 4 %/an, dont
l'entretien complet compense 75 % : 1 %/an au mieux. Il n'y a ni rénovation ni reconstruction d'un bâtiment usé. Le parc
de départ naît à un état tiré entre 0,7 et 1 (`buildings.dart`). Avec un entretien complet, il passe donc sous 0,3 entre
40 et 70 ans, soit les jours 14 600 à 25 550 ; plus tôt si l'entretien manque.

Ce que montrent les relevés :

| | Filets coupés | Filets actifs |
|---|---|---|
| Premier sans-abri (médiane des 20 graines) | jour 16 750 | jour 16 750 |
| Plus de 200 sans-abri (médiane) | jour 19 500 | jour 20 625 |
| Chômage au-dessus de 12 % (médiane) | jour 24 750 (20 graines) | jour 25 250 (17 graines) |
| Sans-abri > 200 avant chômage > 12 % | 20 graines sur 20 | 14 sur 17 |
| Bâtiments construits en 36 000 j (médiane) | 62 (pour ≈ 1 900 au départ) | 49 |

Le chômage décroche au moment où les bâtiments les mieux partis (état 1 au départ, entretien complet) atteignent 0,3 :
jour 25 550. Le nombre de sans-abri plafonne à ≈ 690 (≈ 450-490 avec les filets) parce qu'un propriétaire-occupant reste
toujours logé chez lui, même dans une ruine (`sim.dart`, « se loger » : `c.homeId != null` suffit). Seuls les locataires
perdent leur toit, et ils sont ≈ 30 % de la population avec `ownersAtStart`. Les bailleurs perdent leurs logements
habitables, donc leur capacité et leurs ventes ; presque rien n'est reconstruit.

Ce n'est pas encore une preuve : il faudrait rejouer quelques graines sans usure (`--param buildingWearYear=0`) et voir
la crise disparaître (§ 5).

## 3. Chiffres par tranche de 3 000 jours

Moyenne des 20 graines (médiane entre parenthèses quand une graine extrême la tire).

| Jours | Chômage, sans filets | Chômage, avec filets | Indice médian, sans / avec | Sans-abri, sans / avec | Affamés, sans / avec |
|---|---|---|---|---|---|
| 1-3 000 | 2,7 % | 2,7 % | 2,13 / 2,19 | 0 / 0 | 0 / 0 |
| 3 001-6 000 | 4,5 % | 4,5 % | 2,41 / 2,53 | 0 / 0 | 0 / 0 |
| 9 001-12 000 | 5,3 % | 5,5 % | 1,93 / 1,99 | 0 / 0 | 0 / 0 |
| 15 001-18 000 | 5,5 % | 6,0 % | 1,55 / 1,61 | 28 / 15 | 0 / 0 |
| 18 001-21 000 | 5,6 % | 5,8 % | 1,51 / 1,58 | 229 / 144 | 0 / 0 |
| 21 001-24 000 | 6,5 % (6,2) | 5,9 % (5,7) | 1,50 / 1,62 | 482 / 309 | 0 / 0 |
| 24 001-27 000 | 22,2 % (21,6) | 8,1 % (7,7) | 2,07 / 1,65 | 676 / 460 | 17 / 0 |
| 27 001-30 000 | 28,2 % (13,3) | 12,3 % (9,2) | 2,69 / 2,33 | 688 / 486 | 132 / 3 |
| 30 001-33 000 | 23,7 % (12,6) | 15,8 % (6,5) | 2,64 / 2,47 | 687 / 469 | 144 / 56 |
| 33 001-36 000 | 21,9 % (10,1) | 13,4 % (6,3) | 2,80 / 2,69 | 688 / 454 | 154 / 36 |

Épisodes de crise (relevés de 250 jours avec plus de 20 % de chômage) : sans filets 338 relevés sur 2 877 (11,7 %), dans
18 parties sur 20 ; avec filets 121 sur 2 880 (4,2 %), dans 13 parties. Pic du chômage : sans filets de 16 à 96 % selon la
graine, avec filets de 8 à 86 %. Bonheur moyen : 97,8 % jusqu'au jour 15 000, 83 à 90 % à la fin.

Hyperinflation (indice moyen d'une tranche de 6 000 jours au-dessus de 10) :
- sans filets : graines 5 (13), 8 (25), 9 (34), 10 (3,9 millions), 12 (118 000), 18 (34 000) ;
- avec filets : graines 4 (25), 6 (33), 9 (70), 19 (18).

Sans filets, le crédit (monnaie prêtée) suit les prix : 15-25 M$ avant la crise, jusqu'à 8 × 10¹³ $ dans la graine 10. Avec les filets, le
crédit moyen des 20 graines reste sous 25 M$ par tranche.

## 4. Plantage de la graine 10 sans filets

« Transfert à découvert » dans le versement de l'assurance-emploi (`Sim._insurance`), au jour ≈ 35 300. À ce moment, l'indice
des prix vaut 45 millions et la monnaie totale 8 × 10¹³ $. Au-delà de ≈ 9 × 10¹² $ (2⁵³ unités de 2⁻¹⁰ $), les montants ne
sont plus des multiples exacts de 2⁻¹⁰ $ et la répartition des prestations au prorata de la caisse de l'État peut dépasser
la caisse d'un arrondi. C'est une conséquence de l'hyperinflation, pas une erreur dans les plages normales du jeu.

## 5. À décider ou à vérifier

1. **Confirmer la cause** : rejouer 10 graines × 30 000 j avec `--param buildingWearYear=0`, filets actifs (≈ 2 h 30 sur
   le serveur, ≈ 1 $, au-delà des 30 min habituelles) ; ou d'abord à 240 citoyens, beaucoup plus court, si la crise s'y
   produit aussi.
2. **Renouvellement du parc** (choix de modèle) : rénovation d'un bâtiment usé par son propriétaire ; démolition et
   reconstruction d'une ruine ; un propriétaire-occupant dont la maison devient inhabitable qui déménage ou rénove ; un
   parc de départ d'âges plus étalés (aujourd'hui, tout le parc naît entre 0,7 et 1). À rapprocher du cycle de vie
   (naissances, morts, ménages), qui doit se servir des types de bâtiments.
3. **Déflation lente sur 60 ans** : indice −37 %, salaires −40 à −46 %, monnaie −24 à −32 %, avec le remboursement des
   hypothèques. À suivre une fois le parc renouvelé, car les achats de logements en dépendent.
4. **Hyperinflation sans filets** : le crédit des banques n'a plus de frein une fois les filets coupés. Les règles
   prudentielles (I4) ne suffisent pas.
5. **Plantage numérique** : protéger le versement des prestations (ne jamais verser plus que la caisse) ; secondaire.
