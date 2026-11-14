# Rénovation des bâtiments et métiers du bâtiment (module `renovation`)

Branche `feature/renovation`, partie de `main` à `4b7a132`. Demande de Francis (12 novembre) : un système de rénovation
des bâtiments où les propriétaires achètent des services de construction à des entreprises du bâtiment (entrepreneur
général, charpentiers, électriciens, plombiers), alimentées par une chaîne de matériaux (planches, briques, tuyaux, fils
électriques, fusibles). Motivation : le lot de 36 000 jours (`rapports/derive36k.md`), où le parc de départ, jamais
rénové, tombe en ruine d'un bloc vers 65-70 ans et entraîne une crise dans presque toutes les graines.

Module coupé dans le moteur, réglé au départ d'une partie ; l'écran de départ l'active avec le marché immobilier à partir
de 1 000 citoyens (décision de Francis). Coupé, rien ne change : `tool/reference.sh --verifier` dit « RÉFÉRENCE :
IDENTIQUE (32 éléments) » sur le serveur à chaque révision, la parité PC ↔ serveur est identique, `flutter test` passe
(109 tests, dont 8 nouveaux dans `test/renovation_test.dart`). Documentation du modèle : MODELE.md § 6.6.

## 1. Choix de Francis

- L'entrepreneur général vend les modules de chantier, pour le neuf comme pour la rénovation ; il sous-traite aux
  métiers et achète les briques.
- L'entretien courant passe aux métiers (heures de charpente, de plomberie et d'électricité) au lieu des garages.
- Un propriétaire-occupant rénove avec son épargne et peut emprunter sur sa maison ; si elle devient inhabitable, il
  loue ailleurs en attendant.
- Une entreprise par matériau.
- À moins de 1 000 citoyens, le module est coupé par défaut (à 240, ses neuf entreprises se partagent environ un employé
  de travail et la chaîne s'éteint).

## 2. Règles

Voir MODELE.md § 6.6 (« Rénovation et métiers du bâtiment ») : chaîne de neuf entreprises, entretien par les métiers,
rénovation sous l'état 0,6 (modules de l'entrepreneur général, ⌈(1 − état) × 0,6 × modules⌉), financement par la
trésorerie ou l'épargne puis un prêt pour le manque (seulement pour des modules en stock, l'excédent remboursé le jour
même), occupant d'une ruine qui loue ailleurs, ruines hors du parc des bailleurs, valeur des bâtiments au prix de départ
du module (fixe), importations de secours des matériaux, demande non servie notée sans stock, projets de fondation de
la chaîne plafonnés à leur équipe et au prix de départ indexé quand plus personne ne vend, parc de départ entre 0,6 et 1.

## 3. Comment on y est arrivé (serveur de calcul, réglages de l'interface avec Produits, Bâtiments et Banques)

Chaque ligne compare des graines appariées sur 3 000 jours, module coupé → actif (le moteur coupé est identique au bit
près d'une révision à l'autre). Indice des prix et hypothèques au jour 3 000, 2 500 citoyens sauf mention.

| Révision | Changement | Indice des prix | Hypothèques (M$) | Rénovations | Ce qu'on a appris |
|---|---|---|---|---|---|
| 5261aaa | première version, valeur au prix offert | 2,56 → 4,85 | 21,8 → 57,8 | 386 | la briqueterie (un seul client) meurt dans 10 graines sur 10 ; module × 3,5 |
| 000a317 | valeur au prix de départ indexé | 2,56 → 6,54 | 21,8 → 83,6 | 342 | pire : occupants qui réempruntaient chaque jour sans pouvoir acheter |
| 1a58605 | importations de secours, prêts corrigés | 2,54 → 5,43 | 21,2 → 67,7 | 234 | l'entrepreneur général meurt dans 7 graines sur 8 (8 graines) |
| 88e463d | demande non servie notée ; essais de valeur (4 graines) | prix offert 3,14 ; indexé 5,74 ; **fixe 2,54** | 30,3 ; 73,0 ; **20,1** | ≈ 380 | `tool/credit.dart` : le crédit en trop vient des hypothèques d'achat, la valeur d'une maison passe de 40 600 à 141 300 $ si elle suit les salaires |
| 726208a | valeur fixe, projets plafonnés | 2,56 → 2,49 | 21,8 → 20,0 | 387 | à 1 000 citoyens, l'entrepreneur meurt dans 8 graines sur 10 et n'est jamais refondé |
| bbd6abc | prix attendu indexé, métiers allégés | **2,56 → 2,38** | **21,8 → 19,1** | **386** | chaîne complète dans 9 graines sur 10 ; à 1 000, entrepreneur vivant dans 6 sur 10 |

Essayé et retiré : les « artisans à temps partiel » (la chaîne garde la productivité de son type au lieu de l'échelle
minimale : la chaîne s'éteint quand même à 240 citoyens et les prix montent) ; une limite de fondation dans les marchés
de la chaîne (l'entrepreneur général se retrouve seul et cher, ou meurt sans remplaçant : indice 4,42 avec la valeur au
prix offert).

## 4. Mesure de la version actuelle (bbd6abc, 10 graines appariées × 3 000 j)

| | 2 500 citoyens | 1 000 citoyens |
|---|---|---|
| Chômage, jours 2 501-3 000 | 3,30 → 3,65 % (écart non significatif, 4/10) | 3,16 → 3,27 % (6/10) |
| Indice des prix final | 2,56 → 2,38 (8/10) | 2,73 → 2,87 (5/10) |
| Salaire réel final | 219 → 218 | 202 → 208 (7/10) |
| État moyen du parc | 0,771 → 0,804 (10/10) | 0,770 → 0,790 (8/10) |
| Rénovations terminées | 386 | 127 |
| Hypothèques | 21,8 → 19,1 M$ | 8,7 → 10,1 M$ |
| Prix du module | 3 846 → 4 135 $ | 3 541 → 8 373 $ (jusqu'à 25 792) |
| Chaîne complète au jour 3 000 | 9 graines sur 10 (l'entrepreneur dans 10) | entrepreneur dans 6 graines sur 10 |
| Entreprises actives | 162 → 178 | 100 → 109 |

À 240 citoyens (5261aaa, 10 graines) : la chaîne s'éteint, indice des prix 2,81 → 7,69 ; d'où le seuil de 1 000
citoyens dans l'interface. Vitesse (`tool/vitesse.dart`, 1 000 citoyens, seul sur le serveur) : 34,4 ms par jour avec
le module contre 33,7 sans ; la lenteur de la version web vient du dessin (session séparée).

## 5. Ce qui reste

1. **Lot long de 36 000 jours** (approuvé avec le plan) : vérifier que la crise des 65-70 ans du lot `derive36k`
   disparaît (20 graines × 2, filets coupés et actifs, ≈ 8 h).
2. À 1 000 citoyens, l'entrepreneur général manque encore dans 4 graines sur 10 au jour 3 000, et le module y est cher
   (jusqu'à 25 792 $) ; le parc reste mieux tenu que sans le module.
3. Fusion dans `main` : à demander à Francis.
