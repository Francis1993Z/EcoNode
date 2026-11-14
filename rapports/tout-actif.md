# Tous les modules et le commerce extérieur actifs par défaut

Demande de Francis le 14 novembre 2026 : commerce extérieur ouvert et tous les modules actifs par défaut, dans l'interface
et sans elle ; la rénovation à toutes les tailles. Branche `feature/tout-actif`, partie de `feature/renovation`
(commit 34f967a).

## 1. Ce qui change

- `Modules()` : bâtiments, rôles, entrepreneuriat, produits, banques et rénovation actifs par défaut ; `Params().trade`
  aussi. L'interface reprend ces défauts (écran de départ, `SimController`), sans le seuil de 1 000 citoyens de la
  rénovation. `tool/derive.dart` aussi (`--param trade=0` pour fermer les frontières).
- `Modules.historique()` et `Params.historique()` rendent les anciens défauts. La batterie de parité les rejoue (option
  `--historique` de `partie` et `stabilite`, `parite.dart`) : **référence identique (32 éléments)**.
- Un instantané écrit avant le changement se relit avec ses modules récents coupés.
- Tests : ceux écrits pour les anciens défauts les épinglent ; `test/defauts_test.dart` vérifie les nouveaux défauts, une
  partie de 300 jours sans écart comptable et la relecture d'un ancien instantané. 112 tests passent.

## 2. Mesure

Sur le PC, 10 graines appariées × 3 000 jours, à 240, 1 000 et 2 500 citoyens, réglages de l'interface, filets actifs.
Trois configurations :

- **A**, les anciens défauts de l'interface : rôles, entrepreneuriat et produits, sans bâtiments, banques ni
  rénovation, frontières fermées ;
- **B**, les nouveaux défauts : tous les modules, frontières ouvertes ;
- **C**, tous les modules, frontières fermées, pour séparer l'effet des modules de celui du commerce.

Les 90 parties sont allées au bout. Données : `rapports/donnees/tout-actif/` (`releves.csv`, `agg.txt`, `agg.py`).

Moyennes des 10 graines sur les jours 1 001-3 000 :

| Citoyens | Config. | Chômage | Indice | Salaire | Gini | Graines en crise (chômage > 20 %) | Affamés |
|---|---|---|---|---|---|---|---|
| 240 | A | 4,7 % | 1,09 | 202 | 0,32 | 0 | 0 |
| 240 | B | 15,4 % | 4,04 | 642 | 0,43 | 9 | 3,1 |
| 240 | C | 4,0 % | 3,42 | 622 | 0,28 | 0 | 0 |
| 1 000 | A | 5,6 % | 1,17 | 215 | 0,43 | 0 | 0 |
| 1 000 | B | 11,6 % | 3,09 | 666 | 0,43 | 4 | 0,4 |
| 1 000 | C | 3,2 % | 2,64 | 532 | 0,32 | 0 | 0 |
| 2 500 | A | 6,1 % | 1,20 | 226 | 0,53 | 0 | 0 |
| 2 500 | B | 10,1 % | 1,76 | 389 | 0,59 | 4 | 0,4 |
| 2 500 | C | 3,0 % | 2,26 | 473 | 0,35 | 0 | 0 |

Écarts appariés :

- **Les modules aident (C − A)** : chômage − 0,7 point à 240 (plus bas dans 7 graines sur 10), − 2,4 à 1 000 et − 3,2 à
  2 500 (10 sur 10) ; Gini − 0,03 à − 0,17 ; aucune crise. Prix et salaires nominaux plus hauts (indice × 2 à 3) : la
  monnaie des hypothèques et du crédit.
- **Les frontières ouvertes nuisent (B − C)** : chômage + 11,4 points à 240, + 8,4 à 1 000, + 7,1 à 2 500, plus haut
  dans les 10 graines à chaque taille ; Gini + 0,11 à + 0,24 ; des crises (9 graines sur 10 à 240) et des affamés.
- **Entrepreneur général actif au jour 3 000** : 0 et 1 sur 10 à 240 (C, B), 6 et 7 sur 10 à 1 000, 10 et 9 sur 10 à
  2 500, comme attendu sans le seuil.

## 3. À décider

Les nouveaux défauts doublent ou triplent le chômage de l'ancienne partie par défaut, et c'est le commerce extérieur qui
en est la cause : les modules seuls l'améliorent. Le commerce a été réglé comme un « choix de jeu » (import au prix mondial
× 1,3, export × 0,7) et n'a jamais été calibré pour une partie ordinaire. Avant de fusionner, il faudrait soit garder les
frontières fermées par défaut, soit comprendre pourquoi l'ouverture détruit autant d'emplois (quelles filières perdent
face à l'import) et le corriger.
