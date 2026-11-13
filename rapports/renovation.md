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
même), occupant d'une ruine qui loue ailleurs, ruines hors du parc des bailleurs, valeur des bâtiments au prix de
référence du module, importations de secours des matériaux, parc de départ entre 0,6 et 1.

Essayé et retiré : les « artisans à temps partiel » (les entreprises de la chaîne gardent la productivité de leur type
au lieu de l'échelle minimale). Prix de départ du module à 240 citoyens : 4 006 $ au lieu de 11 776 $, mais la chaîne
s'éteint quand même et l'indice des prix finit plus haut (3,8 contre 2,8 à 2 500 citoyens, 18 à 240 ; 4 graines ×
2 000-3 000 j).

## 3. Mesures (serveur de calcul, réglages de l'interface avec Produits, Bâtiments et Banques, 3 000 j, graines appariées)

« Coupé » : le module coupé (identique au bit près d'une révision à l'autre, référence vérifiée). Chômage : moyenne des
jours 2 501-3 000 ; autres : jour 3 000.

| Révision | Pop. | Graines | Chômage coupé → actif | Indice final | Module ($) | Hypothèques (M$) | Rénovations | État du parc |
|---|---|---|---|---|---|---|---|---|
| 5261aaa (valeur au prix offert) | 2 500 | 10 | 3,30 → 1,97 % (9/10) | 2,56 → 4,85 | 3 846 → 13 331 | 21,8 → 57,8 | 386 | 0,771 → 0,803 |
| 5261aaa | 1 000 | 10 | 3,16 → 3,13 % | 2,73 → 4,93 | 3 541 → 8 212 | 8,7 → 22,4 | 80 | 0,770 → 0,761 |
| 5261aaa | 240 | 10 | 3,52 → 3,01 % | 2,81 → 7,69 | 4 920 → 11 791 | 2,1 → 8,0 | 8 | 0,768 → 0,680 |
| 000a317 (valeur au prix de référence) | 2 500 | 10 | 3,30 → 1,56 % (9/10) | 2,56 → 6,54 | 3 846 → 15 913 | 21,8 → 83,6 | 342 | 0,771 → 0,794 |
| 000a317 | 1 000 | 10 | 3,16 → 1,84 % (8/10) | 2,73 → 9,48 | 3 541 → 4 334 | 8,7 → 50,0 | 61 | 0,770 → 0,751 |
| 1a58605 (importations de secours, prêts corrigés) | 2 500 | 8 | 3,08 → 2,08 % (8/8) | 2,54 → 5,43 | 3 892 → 4 252 | 21,2 → 67,7 | 234 | 0,771 → 0,770 |

Le lot de 1a58605 a été coupé à 14 parties sur 30 (graines 1-8 à 2 500 citoyens finies), à la demande de Francis.

Ce que ces lots montrent :
- **Le chômage baisse** avec le module à 2 500 citoyens dans toutes les variantes (≈ −1 à −1,7 pt sur les 500
  derniers jours), le salaire réel ne change pas.
- **La briqueterie** (un seul client, l'entrepreneur général, aux commandes irrégulières) meurt dans 10 graines sur 10 ;
  sans briques, le module devient rare et cher (5261aaa : × 3,5). Les importations de secours ramènent le prix du module
  au niveau d'avant (4 252 $ contre 3 892 $).
- **L'entrepreneuriat inonde ces petits marchés** (sonde `tool/chaine.dart`, graine 1 : 2 briqueteries, 1 câblerie, 5
  entrepreneurs généraux et 4 charpentiers fondés en 400 jours) ; les entreprises fondées gardent à vie la productivité
  de leur petite demande de départ (échelle minimale), puis font faillite.
- **L'entrepreneur général meurt encore** dans 7 graines sur 8 avec les importations de secours (cause pas encore
  identifiée) : les rénovations s'arrêtent (234 contre 342-386), et l'état du parc n'est pas meilleur que sans le module.
- **Le crédit hypothécaire triple** dans toutes les variantes, et l'indice des prix final double (× 1,8 à × 3,5). Une
  pompe à monnaie a été corrigée en 1a58605 (l'occupant empruntait chaque jour où l'entrepreneur n'avait rien à vendre,
  dépensait une partie de l'argent et réempruntait) ; le crédit reste pourtant × 3,2.

## 4. Ce qui reste

1. **Trouver d'où vient le crédit en trop** (achats de logements, rénovations, chantiers) : ajouter la part de chaque
   source à la sonde. Piste : la valeur des logements suit un prix nominal qui monte (le prix offert du module, puis le
   prix de référence indexé sur les salaires), d'où des hypothèques d'achat plus grosses, de la monnaie et des salaires
   plus hauts, qui relèvent encore la valeur. Sans le module, la Construction meurt dans 9 graines sur 10 et le module
   garde son prix de départ : la valeur des logements reste fixe en dollars, ce qui ancre le crédit sans le vouloir.
2. **Comprendre la mort de l'entrepreneur général** avec les importations de secours (`tool/chaine.dart`).
3. **Lot long de 36 000 jours** (approuvé avec le plan), seulement quand les points 1 et 2 seront réglés.
4. Fusion dans `main` : pas avant ; à demander à Francis.
