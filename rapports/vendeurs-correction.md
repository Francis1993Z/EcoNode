# Échantillonnage des vendeurs : liste des vendeurs disponibles (12 octobre 2026)

Mission : corriger `sellerSample` (recherche limitée des vendeurs). Aucune règle de jeu ne change ; `sellerSample`
reste à 0 par défaut. Ce rapport décrit le correctif, ses tests, les mesures, et dit ce qui reste non résolu.
Les chiffres viennent des fichiers `rapports/stat/vendeurs-controle-*.md` (tableaux complets, avec intervalles).

## Résumé

- **Le correctif est livré et vérifié.** La liste des vendeurs qui ont du stock est tenue à jour en O(1) par un seul point
  d'entrée (`_setStock`) ; les achats à k > 0 tirent dedans. Un achat d'une unité ne peut plus échouer pour « pas d'offre »
  tant qu'un autre vendeur a une unité en stock : le moteur le vérifie (parties aléatoires avec chocs), et le détecteur
  quotidien n'a jamais parlé dans 150 parties à k > 0 (150 000 jours, jusqu'à 13 240 citoyens).
- **À k = 0, rien ne change** : les 22 516 valeurs du protocole par défaut (dont les 300 chocs) sont identiques à l'état
  précédent, les empreintes de parité de performance aussi, les instantanés sont identiques octet pour octet, et la
  parité VM / JavaScript tient (cas k = 5 compris).
- **« Vendeur disponible » veut dire une unité entière en stock, pas « stock > 0 ».** Les ménages achètent des unités entières.
  Avec la lecture littérale (stock > 0), le sans-logis à 3 000 citoyens monte de plus de 30 points : c'est la fausse pénurie
  qui revient sous une autre forme (§ 1).
- **Critère d'acceptation : rempli à 3 000 citoyens, non rempli à 13 240.** Le sans-logis à k = 5 ne dépasse plus celui de k = 0.
  À 3 000 citoyens il est indistinguable ; à 13 240 il est **28 points plus bas**, pas au même niveau. Je ne force pas ce
  résultat : ce n'est ni une fausse pénurie ni une erreur d'implémentation (avec k plus grand que tous les vendeurs, le
  chemin de l'échantillonnage redonne exactement k = 0). **k = 5 est une autre règle de marché**, et l'écart croît quand k
  diminue (§ 5).
- **Temps** : à 13 240 citoyens, un jour passe de 1 511 ms (k = 0) à 455 ms (k = 5), 3,3 fois plus vite. Le coût d'un achat
  reste plat quand le nombre de vendeurs croît (×1,3 pour ×500 vendeurs, contre ×380 à k = 0).
- **Biais résiduel : pas négligeable pour k petit.** Il disparaît à partir de k ≈ 12 à 3 000 citoyens et k ≈ 20 à 13 240, c'est-à-dire
  quand k couvre à peu près tous les vendeurs des gros marchés et que le gain de temps s'amenuise (§ 7).
- **Décision à Francis** : `sellerSample` reste à 0. À grande échelle, il change qualitativement l'économie (faim 51 % contre
  0,2 % à 13 240 citoyens) ; il faut le prendre pour un choix de jeu, pas pour une accélération neutre (§ 8).

## 1. Ce qui était faux, et ce qui change

**Avant.** Avec `sellerSample = k`, un achat de ménage tirait des places au hasard dans la liste de *tous* les vendeurs
du bien et ne gardait que ceux qui avaient du stock. Quand presque tous les vendeurs d'un bien étaient en rupture, les
tirages tombaient sur des vendeurs sans stock et l'acheteur voyait « aucune offre » alors qu'il en existait une :
fausse pénurie. Les anciens résultats à k = 5 ne sont donc pas fiables.

**Maintenant.** Le moteur tient, pour chaque bien, la **liste des vendeurs qui ont du stock vendable**. Un achat tire
ses k vendeurs dans cette liste (plus le vendeur habituel s'il y figure encore). Une liste vide veut dire qu'aucune
offre n'existe : seulement alors la demande reste non servie.

- **Structure** (`sim.dart`, classe `_Avail`) : un tableau de vendeurs et la place de chacun par identifiant. Entrée
  en fin de tableau, retrait par échange avec le dernier élément : O(1) dans les deux cas.
- **Tirage** (`_AllOffers.sampled`) : le vendeur habituel (`lastSeller`) d'abord, puis jusqu'à k vendeurs de la liste
  par le flux `vendeurs` (code 18) et le sous-tirage (bien, n-ième achat, essai), sans doublon, sans l'acheteur. Si la
  liste a k vendeurs ou moins, tous sont examinés.
- **À k = 0**, rien ne change : la liste n'est ni construite ni tenue (un seul test de drapeau par changement de stock).

### Définition de « vendeur disponible » : une unité entière, pas « stock > 0 »

Les ménages achètent des **unités entières** (`buy(..., integer: true)` : la quantité est arrondie vers le bas, avec
une tolérance de 1e-7). Un vendeur qui a 0,4 unité en stock a « du stock » mais ne peut rien vendre à un ménage. Si la
liste contient ces vendeurs, le tirage retombe sur la même fausse pénurie, en plus discret : par exemple, l'acheteur
tire cinq vendeurs à 0,4 unité et repart sans rien, alors qu'un autre a 12 unités.

La liste contient donc les vendeurs dont le stock est d'**au moins une unité** (`Sim.availThreshold = 1 − 1e-7`). Les
achats non entiers d'un ménage (les réparations du module Bâtiments) gardent la recherche complète : un stock
fractionnaire leur suffit, et ils sont rares.

Mesure de l'écart entre les deux définitions (3 000 citoyens, 10 graines, k = 5, sans filets, écart à k = 0, apparié) :

| Définition de la liste | Sans-abri | Faim | Chômage | Demande non servie |
|---|---|---|---|---|
| Une unité (retenue) | −4,6 pt [−14,9 pt ; +4,4 pt] | −0,1 pt [−5,4 pt ; +4,1 pt] | −4,3 pt [−16,7 pt ; +2,5 pt] | −15,34 pt [−22,13 pt ; +1,49 pt] |
| Stock > 0 (lecture littérale de la consigne) | +32,0 pt [+25,5 pt ; +42,8 pt] | +14,4 pt [+3,4 pt ; +21,2 pt] | +16,0 pt [+12,7 pt ; +22,8 pt] | +23,30 pt [+17,52 pt ; +30,66 pt] |

## 2. Tous les endroits où le stock d'un vendeur change

Un seul point d'entrée met la liste à jour : `Sim._setStock(firme, bien, quantité)`. Tout changement de stock d'une
entreprise passe par lui. Une recherche de toutes les écritures (`inv[...] =`, `+=`, `-=`, `.inv.` dans `lib/`, `tool/`,
`test/`) donne les endroits suivants. Les lignes sont celles de `lib/engine/sim.dart`.

| # | Où | Ce qui arrive | Effet sur la liste |
|---|---|---|---|
| 1 | Départ de la partie (l. 618) | stock initial de chaque extrant (0 si périssable, sinon la demande × jours de stock visés) | crochet ; la liste est de toute façon reconstruite au premier matin |
| 2 | `addFirm` (création, l. 3261) | stock d'extrant à 0, stock d'intrant à 0 | pas de crochet : une entreprise sans stock n'est pas dans la liste ; `_rebuildSellers` la reconstruit |
| 3 | `Sim.buy`, vente (l. 1240) | le vendeur perd la quantité vendue | retrait quand le stock tombe sous une unité |
| 4 | `_produce`, consommation d'intrants (l. 1547) | le stock d'intrant baisse | crochet (sans effet si l'intrant n'est pas un extrant de l'entreprise) |
| 5 | `_produce`, production (l. 1551) | le stock d'extrant monte | entrée quand le stock atteint une unité |
| 6 | `_takePublic` (l. 1713) | une unité de service public produite le jour est prise | retrait si le stock tombe sous une unité |
| 7 | `_buyInputs` (l. 1846) | l'entreprise achète ses intrants | crochet (sans effet : un intrant n'est pas vendu) |
| 8 | `_export` (l. 2239) | l'excédent exportable part à l'étranger | retrait si le stock tombe sous une unité |
| 9 | `_expire` (l. 2253) | les biens périssables invendus sont perdus en fin de journée | retrait |
| 10 | `godGoods` (l. 3123) | ajout ou retrait de stock par le god mode | entrée ou retrait |
| 11 | `godDestroy` (l. 3136) | destruction d'une part des stocks d'un bien | retrait si le stock tombe sous une unité |
| 12 | `godBankrupt` (l. 3331) | tous les stocks de l'entreprise tombent à 0 ; elle reste en place | retrait |
| 13 | Fermeture d'une entreprise (`_close`, l. 2646 ; `godClose`, l. 3316) | l'entreprise sort de `firms` | `_rebuildSellers` reconstruit la liste (sans elle) |
| 14 | Restauration d'un instantané (`snapshot.dart`, l. 836) | les stocks sont relus | `_rebuildSellers` reconstruit la liste |
| 15 | Chaque matin (`step`, l. 1339) | — | reconstruction complète de la liste, en identifiant croissant |

Cas vérifiés à part :

- **Marché noir et imports de dépannage** : il n'y a pas de stock. Une importation est une offre `Firm? = null` (le monde
  extérieur), ajoutée à la fin des offres, jamais dans la liste. Aucune importation ne touche `inv`.
- **Module Bâtiments** (`buildings.dart`) : aucun accès direct à `inv`. Ses achats (matériaux, réparations) passent par
  `buy`, donc par le point n° 3 ; sa production passe par `_produce`.
- **Interface et outils** : `lib/ui/`, `tool/` et `test/` n'écrivent jamais dans `inv`.
- **Autre accès** : `Firm.inv` est une table publique. Le détecteur (§ 3) vérifierait un oubli futur.

## 3. Déterminisme et instantanés

- **Reconstruction chaque matin.** Au début de `step`, la liste de chaque bien est refaite de zéro, en ordre d'identifiant
  croissant. Les entrées et retraits du jour se font ensuite dans l'ordre (déterministe) des événements du jour. Une
  partie continue et une partie reprise d'un instantané partent donc de la même liste le matin, et font les mêmes
  opérations. La liste est aussi refaite à chaque changement du parc (création ou fermeture d'une entreprise).
- **Rien n'est sérialisé.** L'instantané n'a pas de champ pour la liste (test : aucune clé du fichier ne la nomme).
  Les instantanés restent inchangés octet pour octet à k = 0 ; à k > 0 seul le paramètre et la mémoire d'habitude
  (`lastSeller`, déjà présents) s'y trouvent.
- **Mesures.** La reprise depuis un instantané à k = 5 (1 000 citoyens, coupure au jour 40, suite jusqu'au jour 80)
  donne exactement le même état final qu'une partie continue (`test/vendeurs_test.dart`).

## 4. Tests de contrôle

| Contrôle | Où | Ce qu'il vérifie |
|---|---|---|
| Liste exacte, avant chaque achat | `Sim.verifyFastPaths` (moteur) | avant chaque achat de ménage à k > 0, la liste de chaque bien est exactement l'ensemble des entreprises actives avec une unité en stock, et les places sont cohérentes |
| Liste exacte, après chaque jour | `proprietes_test.dart`, « vendeurs disponibles » | 12 parties aléatoires de 150 jours (k = 3, 5 ou 8, modules et filets tirés, chocs du god mode : stocks détruits, faillites, arrivées, départs) |
| Pas de fausse pénurie (propriété) | même test, via `verifyFastPaths` | un achat d'une unité qui échoue pour « pas d'offre » n'a lieu que si aucun autre vendeur n'a une unité en stock ; sinon le moteur lève une exception |
| Plus grande échelle | `tool/vendeurs_verif.dart` | les deux contrôles précédents avant chaque achat, 3 000 citoyens (k = 3, 150 jours) et 1 500 citoyens (k = 5, 200 jours), 2 graines, avec et sans filets : aucune exception |
| Détecteur en continu | moniteur, alerte critique `listeVendeurs` | vérifie la liste chaque jour dans toute simulation à k > 0 (parties de l'interface comprises) |
| Reprise d'un instantané | `vendeurs_test.dart` | même suite qu'une partie continue ; l'instantané ne contient pas la liste |
| 240 citoyens | `vendeurs_test.dart` | k = 5 donne exactement la partie de k = 0 (instantanés identiques, hors le paramètre et l'habitude) |

Le détecteur n'a jamais ouvert d'alerte dans les 150 parties des mesures (jusqu'à 13 240 citoyens, 1 000 jours), et
l'écart comptable est resté nul.

Les tests savent détecter une erreur : en retirant à la main le crochet de la vente (point 3), puis celui de la
péremption (point 9), le test des parties aléatoires échoue dès le premier jour (« 1 en trop »).

**Exécution.** `dart analyze` : aucun problème. `flutter test` : 65 réussis, 2 ignorés (les deux cas extrêmes déjà
documentés). Protocole à k = 0, configuration par défaut, comparé à l'état précédent (`7e8029a`) : 22 516 valeurs, dont
les 300 chocs, toutes identiques (seules la date et la durée de l'exécution changent ; 304 clés de mesure s'ajoutent : demande non servie, dispersion des prix, rapport des prix). Empreintes de parité de
performance (`tool/perf.dart`, graine 1) identiques à k = 0 à 240, 1 000, 3 000 et 13 240 citoyens.

## 5. Test de contrôle principal : k = 0 contre k = 5

Conditions : 1 000 jours, chauffe de 100 jours, 10 graines (les mêmes pour k = 0 et k = 5), sans filets puis avec
filets, module Bâtiments coupé, `sellerSample` = 0 contre 5. Chaque écart est la différence k = 5 − k = 0 **graine
par graine** ; on donne sa médiane et l'intervalle à 95 % de cette médiane (bootstrap percentile des graines, 10 000
tirages, comme `stabilite --compare`). Un écart n'est conclu que si l'intervalle exclut 0. Avec 10 graines, un
intervalle large veut dire que l'on ne sait pas, pas que l'écart est nul. Tableaux complets (dont la demande non
servie par bien et la concentration par secteur) :
`rapports/stat/vendeurs-controle-3000-k5.md` et `rapports/stat/vendeurs-controle-13240-k5.md`.

### 5.1 Verdict sur le critère d'acceptation

> « Le sans-logis à k = 5 revient au niveau de k = 0, dans l'intervalle de confiance entre graines. »

| Taille | Sans-abri, k = 0 | Sans-abri, k = 5 | Écart médian apparié [intervalle à 95 %] | Critère |
|---|---|---|---|---|
| 3 000, sans filets | 14,9 % | 10,2 % | −4,6 pt [−14,9 pt ; +4,4 pt] | rempli : l'intervalle contient 0 |
| 3 000, avec filets | 10,3 % | 4,5 % | −1,1 pt [−9,2 pt ; +2,3 pt] | rempli : l'intervalle contient 0 |
| 13 240, sans filets | 31,3 % | 3,0 % | −27,7 pt [−29,8 pt ; −24,5 pt] | **non rempli : bien en dessous de k = 0** |
| 13 240, avec filets | 37,4 % | 4,4 % | −33,3 pt [−34,6 pt ; −31,2 pt] | **non rempli : bien en dessous de k = 0** |

- **Le défaut décrit est corrigé.** L'ancien k = 5 donnait +8 à +40 points de sans-abri (par exemple 66,0 % contre 32,8 %
  à 13 240 citoyens, 3 graines, journal § 8). Le nouveau ne donne plus de hausse : le sans-abri est plus bas, ou
  indistinguable.
- **Mais k = 5 ne « revient » pas à k = 0 à 13 240 citoyens : il en est très loin, du bon côté.** Le critère littéral
  (même niveau) n'est donc pas rempli. Je ne le force pas. Ce n'est pas un reste de fausse pénurie (le moteur la
  vérifie, § 4) ni une erreur de la liste (§ 5.3) : c'est que k = 5 est une autre règle de marché (§ 5.4).

### 5.2 Résultats d'ensemble

**3 000 citoyens, sans filets** (écart k = 5 − k = 0, `*` : intervalle excluant 0)

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 14,9 % | 10,2 % | −4,6 pt | [−14,9 pt ; +4,4 pt] | 3/10 | non |
| Faim moyenne | 2,6 % | 1,4 % | −0,1 pt | [−5,4 pt ; +4,1 pt] | 5/10 | non |
| Chômage moyen | 33,1 % | 28,4 % | −4,3 pt | [−16,7 pt ; +2,5 pt] | 3/10 | non |
| Demande non servie (unités non achetées / demandées) | 26,35 % | 11,27 % | −15,34 pt | [−22,13 pt ; +1,49 pt] | 3/10 | non |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,279 | 1,380 | +0,207 | [−0,412 ; +1,063] | 5/10 | non |
| Inflation moyenne par jour | 0,03 % | 0,04 % | +0,02 pt | [−0,05 pt ; +0,09 pt] | 5/10 | non |
| Gini moyen | 0,781 | 0,722 | −0,048 | [−0,135 ; −0,016] | 2/10 | oui |
| Santé moyenne | 0,384 | 0,667 | +0,300 | [−0,013 ; +0,419] | 7/10 | non |
| Parc moyen d’entreprises | 123,5 | 141,1 | +18,0 | [+8,4 ; +23,8] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 28,0 | 24,0 | −7,5 | [−17,0 ; +0,0] | 2/10 | non |
| Fermetures d’entreprises (toute la partie) | 353,0 | 325,5 | −30,5 | [−41,0 ; +3,0] | 3/10 | non |
| Morts par an, en % du parc moyen | 104,7 | 83,9 | −21,7 | [−27,3 ; −4,3] | 0/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 95,4 % | 95,5 % | +0,6 pt | [−1,6 pt ; +1,6 pt] | 6/10 | non |
| Herfindahl des ventes (médiane des biens) | 0,939 | 0,942 | +0,007 | [−0,020 ; +0,024] | 6/10 | non |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 16,1 % | 14,9 % | −0,9 pt | [−3,8 pt ; +1,6 pt] | 4/10 | non |

**3 000 citoyens, avec filets**

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 10,3 % | 4,5 % | −1,1 pt | [−9,2 pt ; +2,3 pt] | 4/10 | non |
| Faim moyenne | 0,0 % | 0,1 % | +0,1 pt | [−4,7 pt ; +2,5 pt] | 8/10 | non |
| Chômage moyen | 31,7 % | 25,5 % | −4,0 pt | [−12,7 pt ; +4,4 pt] | 4/10 | non |
| Demande non servie (unités non achetées / demandées) | 22,72 % | 6,19 % | −12,75 pt | [−18,09 pt ; −2,59 pt] | 2/10 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,528 | 0,807 | −0,489 | [−1,124 ; −0,046] | 2/10 | oui |
| Inflation moyenne par jour | 0,05 % | -0,02 % | −0,05 pt | [−0,12 pt ; +0,01 pt] | 2/10 | non |
| Gini moyen | 0,714 | 0,683 | −0,008 | [−0,103 ; +0,049] | 5/10 | non |
| Santé moyenne | 0,414 | 0,754 | +0,266 | [+0,045 ; +0,397] | 8/10 | oui |
| Parc moyen d’entreprises | 136,1 | 153,1 | +16,5 | [+11,3 ; +18,5] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 12,0 | 12,5 | +3,0 | [−3,0 ; +5,5] | 6/10 | non |
| Fermetures d’entreprises (toute la partie) | 324,5 | 302,5 | −20,0 | [−29,0 ; −10,0] | 1/10 | oui |
| Morts par an, en % du parc moyen | 87,4 | 72,0 | −14,7 | [−16,7 ; −9,2] | 0/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 96,3 % | 95,4 % | −1,0 pt | [−1,4 pt ; +0,2 pt] | 3/10 | non |
| Herfindahl des ventes (médiane des biens) | 0,951 | 0,941 | −0,009 | [−0,017 ; −0,004] | 1/10 | oui |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 22,0 % | 23,0 % | +0,5 pt | [−2,2 pt ; +5,9 pt] | 5/10 | non |

**13 240 citoyens, sans filets**

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 31,3 % | 3,0 % | −27,7 pt | [−29,8 pt ; −24,5 pt] | 0/10 | oui |
| Faim moyenne | 50,7 % | 0,2 % | −50,4 pt | [−50,6 pt ; −49,7 pt] | 0/10 | oui |
| Chômage moyen | 62,2 % | 24,0 % | −38,4 pt | [−42,4 pt ; −34,4 pt] | 0/10 | oui |
| Demande non servie (unités non achetées / demandées) | 41,48 % | 0,34 % | −40,11 pt | [−41,76 pt ; −39,83 pt] | 0/10 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,988 | 0,585 | −1,355 | [−1,759 ; −1,221] | 0/10 | oui |
| Inflation moyenne par jour | 0,08 % | -0,06 % | −0,13 pt | [−0,17 pt ; −0,11 pt] | 0/10 | oui |
| Gini moyen | 0,879 | 0,683 | −0,196 | [−0,217 ; −0,185] | 0/10 | oui |
| Santé moyenne | 0,306 | 0,882 | +0,568 | [+0,553 ; +0,582] | 10/10 | oui |
| Parc moyen d’entreprises | 448,4 | 590,9 | +143,4 | [+131,8 ; +154,6] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 8,5 | 13,5 | +2,0 | [+0,0 ; +11,0] | 7/10 | non |
| Fermetures d’entreprises (toute la partie) | 1486,0 | 1250,5 | −239,0 | [−249,0 ; −218,0] | 0/10 | oui |
| Morts par an, en % du parc moyen | 121,1 | 77,2 | −44,7 | [−46,4 ; −41,0] | 0/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 83,0 % | 86,2 % | +3,8 pt | [+1,3 pt ; +5,8 pt] | 9/10 | oui |
| Herfindahl des ventes (médiane des biens) | 0,798 | 0,833 | +0,045 | [+0,011 ; +0,075] | 8/10 | oui |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 21,2 % | 21,8 % | +0,6 pt | [−3,6 pt ; +4,1 pt] | 6/10 | non |

**13 240 citoyens, avec filets**

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| Sans-abri moyen | 37,4 % | 4,4 % | −33,3 pt | [−34,6 pt ; −31,2 pt] | 0/10 | oui |
| Faim moyenne | 35,8 % | 0,6 % | −35,0 pt | [−35,6 pt ; −34,3 pt] | 0/10 | oui |
| Chômage moyen | 63,8 % | 27,1 % | −37,0 pt | [−41,9 pt ; −34,4 pt] | 0/10 | oui |
| Demande non servie (unités non achetées / demandées) | 41,80 % | 1,72 % | −40,09 pt | [−41,32 pt ; −38,20 pt] | 0/10 | oui |
| Indice des prix en fin de partie (1 = fin de chauffe) | 1,953 | 0,571 | −1,448 | [−1,506 ; −1,117] | 0/10 | oui |
| Inflation moyenne par jour | 0,07 % | -0,06 % | −0,14 pt | [−0,16 pt ; −0,10 pt] | 0/10 | oui |
| Gini moyen | 0,874 | 0,710 | −0,159 | [−0,206 ; −0,149] | 0/10 | oui |
| Santé moyenne | 0,306 | 0,859 | +0,548 | [+0,518 ; +0,568] | 10/10 | oui |
| Parc moyen d’entreprises | 468,4 | 634,1 | +163,7 | [+159,2 ; +172,7] | 10/10 | oui |
| Naissances d’entreprises (toute la partie) | 3,5 | 6,5 | +2,0 | [+0,0 ; +8,0] | 7/10 | non |
| Fermetures d’entreprises (toute la partie) | 1486,5 | 1235,5 | −254,5 | [−263,0 ; −239,0] | 0/10 | oui |
| Morts par an, en % du parc moyen | 115,8 | 71,2 | −44,4 | [−47,0 ; −42,9] | 0/10 | oui |
| Part de la plus grande entreprise (médiane des biens) | 80,8 % | 85,7 % | +4,9 pt | [+2,5 pt ; +7,4 pt] | 10/10 | oui |
| Herfindahl des ventes (médiane des biens) | 0,770 | 0,827 | +0,056 | [+0,039 ; +0,095] | 10/10 | oui |
| Dispersion des prix entre vendeurs (coefficient de variation, médiane des biens) | 24,3 % | 31,7 % | +7,2 pt | [+4,4 pt ; +10,3 pt] | 10/10 | oui |

Lecture :

- **La demande non servie s'effondre** à 13 240 citoyens (41,48 % de la demande contre
  0,34 %), et la faim, le chômage et le sans-abri avec elle. À 3 000 citoyens, les
  écarts vont dans le même sens mais les intervalles contiennent 0 pour le sans-abri, la faim et le chômage.
- **Le parc d'entreprises est plus grand et meurt moins** : +143,4 [+131,8 ; +154,6] entreprises de plus
  à 13 240 citoyens ; 10 graines sur 10 dans le même sens à 3 000 et à 13 240 citoyens. Les naissances ne changent pas de
  façon conclue (les plafonds de création restent le frein, voir le journal § 6) ; c'est la mortalité qui baisse (morts par
  an en % du parc : conclue dans les quatre cas).
- **Les invariants comptables restent exacts** (écart max 0) et le détecteur de liste n'a jamais parlé (§ 4).

### 5.3 Ce n'est pas une erreur de l'implémentation

- Avec un échantillon plus grand que le nombre de vendeurs (k = 100 000), le chemin de l'échantillonnage donne **exactement**
  la partie de k = 0 (3 000 citoyens, 50 jours, instantanés identiques à l'habitude et au paramètre près :
  `vendeurs_test.dart`). Rien de ce que la liste, le tirage et la construction des offres font ne change le résultat
  tant que tous les vendeurs sont examinés.
- À 240 citoyens, et à 1 000 pour k ≥ 5, les empreintes de k > 0 sont identiques à k = 0 (jamais plus de k + 1 vendeurs
  d'un bien : l'échantillon les couvre tous). `tool/perf.dart`, § 6.
- L'écart apparaît quand k est plus petit que le nombre de vendeurs et grandit quand k diminue (§ 5.4, § 7).

### 5.4 Pourquoi k = 5 donne une autre économie : la dépendance à k

Les mêmes graines, jouées avec des k différents (sans filets ; `*` : intervalle excluant 0 ; entre parenthèses, l'écart
médian apparié à k = 0).

**3 000 citoyens, 10 graines**

| Indicateur | k = 0 | k = 2 | k = 3 | k = 5 | k = 8 | k = 12 | k = 20 |
|---|---|---|---|---|---|---|---|
| Sans-abri | 14,9 % | 1,6 % (−11,2 pt *) | 0,4 % (−13,2 pt *) | 10,2 % (−4,6 pt) | 10,7 % (−4,1 pt) | 10,9 % (−1,5 pt) | 13,8 % (+0,7 pt) |
| Faim | 2,6 % | 0,1 % (−1,9 pt *) | 0,0 % (−2,5 pt *) | 1,4 % (−0,1 pt) | 1,8 % (−0,5 pt) | 1,0 % (−1,3 pt) | 1,5 % (+0,0 pt) |
| Chômage | 33,1 % | 13,8 % (−19,4 pt *) | 9,9 % (−21,6 pt *) | 28,4 % (−4,3 pt) | 30,1 % (−4,1 pt) | 30,9 % (−1,1 pt) | 32,8 % (−0,1 pt) |
| Demande non servie | 26,35 % | 1,76 % (−23,51 pt *) | 0,70 % (−24,13 pt *) | 11,27 % (−15,34 pt) | 15,20 % (−6,26 pt *) | 20,05 % (−4,50 pt) | 24,73 % (+0,12 pt) |
| Parc moyen | 123,5 | 155,8 (+34,0 *) | 150,7 (+27,4 *) | 141,1 (+18,0 *) | 132,8 (+8,9 *) | 126,9 (+4,2) | 123,1 (−0,0) |
| Morts / an (% parc) | 104,7 | 69,6 (−35,6 *) | 73,8 (−33,1 *) | 83,9 (−21,7 *) | 97,6 (−9,7 *) | 101,6 (−1,3) | 106,0 (+1,1) |
| Part du plus gros | 95,4 % | 94,8 % (−0,3 pt) | 95,9 % (+0,6 pt) | 95,5 % (+0,6 pt) | 95,7 % (+0,1 pt) | 96,1 % (+0,9 pt) | 95,2 % (−0,1 pt) |
| Herfindahl | 0,939 | 0,932 (−0,001) | 0,949 (+0,009) | 0,942 (+0,007) | 0,944 (+0,004) | 0,949 (+0,013) | 0,940 (+0,000) |
| Dispersion des prix | 16,1 % | 11,4 % (−4,2 pt *) | 12,1 % (−4,0 pt *) | 14,9 % (−0,9 pt) | 15,3 % (−0,3 pt) | 15,4 % (−1,4 pt) | 15,1 % (−0,1 pt) |

**13 240 citoyens, 5 graines** (k = 3, 8, 12 et 20 : graines 1 à 5, sans filets ; k = 5 : mêmes 5 graines que les autres)

| Indicateur | k = 0 | k = 3 | k = 5 | k = 8 | k = 12 | k = 20 |
|---|---|---|---|---|---|---|
| Sans-abri | 27,7 % | 0,8 % (−27,2 pt *) | 3,0 % (−24,7 pt *) | 16,5 % (−11,2 pt *) | 25,0 % (−4,2 pt *) | 27,2 % (−2,8 pt) |
| Faim | 50,7 % | 0,0 % (−50,6 pt *) | 0,2 % (−50,4 pt *) | 24,2 % (−26,5 pt *) | 41,9 % (−8,6 pt *) | 48,2 % (−2,2 pt) |
| Chômage | 62,2 % | 13,2 % (−48,8 pt *) | 24,4 % (−36,1 pt *) | 45,3 % (−16,9 pt *) | 56,5 % (−5,6 pt *) | 60,7 % (−1,2 pt) |
| Demande non servie | 42,43 % | 0,16 % (−42,28 pt *) | 0,33 % (−40,00 pt *) | 31,53 % (−11,36 pt *) | 36,84 % (−5,65 pt *) | 40,34 % (−2,23 pt) |
| Parc moyen | 447,2 | 630,6 (+178,0 *) | 584,1 (+136,9 *) | 522,7 (+75,4 *) | 485,0 (+40,0 *) | 462,3 (+20,7 *) |
| Morts / an (% parc) | 119,8 | 70,2 (−50,1 *) | 78,9 (−41,0 *) | 99,6 (−20,1 *) | 110,0 (−10,6 *) | 116,9 (−4,8 *) |
| Part du plus gros | 81,0 % | 81,8 % (+0,0 pt) | 86,1 % (+5,7 pt *) | 75,0 % (−6,9 pt *) | 69,4 % (−11,0 pt *) | 80,8 % (+0,1 pt) |
| Herfindahl | 0,765 | 0,783 (+0,015) | 0,834 (+0,071 *) | 0,692 (−0,068 *) | 0,623 (−0,113 *) | 0,761 (−0,005) |
| Dispersion des prix | 21,3 % | 17,2 % (−5,0 pt) | 23,3 % (+1,3 pt) | 18,7 % (−3,5 pt) | 20,2 % (−2,7 pt) | 21,1 % (−2,8 pt) |

La réponse monte avec la quantité d'information : plus k est petit, plus l'économie est « saine » (moins de faim, de
chômage, de sans-abri, plus d'entreprises). À 13 240 citoyens, les résultats de k = 20 sont indistinguables de k = 0
pour le sans-abri, la faim, le chômage et la demande non servie ; seul le parc d'entreprises (+21 sur 447) reste
conclu. Le même comportement apparaît à 3 000 citoyens avec k = 12 à 20.

**Hypothèse (non vérifiée).** Quand chaque ménage compare tous les vendeurs, tous choisissent le même (le moins cher,
au bruit de 3 % près) : la demande se concentre sur quelques vendeurs, les autres perdent leurs clients et ferment
(taux de mort de 105 à 120 % du parc par an à k = 0, contre 70 à 85 % à k = 3 à 5). Une information limitée disperse
la demande et garde plus de vendeurs en vie. Ce qui parle pour cette lecture : la dépendance monotone à k, le parc plus
grand, le nombre de vendeurs actifs par bien en hausse (tertiaire : 16 contre 25 à 13 240 citoyens). Ce qui ne la
confirme pas : la part de la plus grande entreprise ne baisse pas partout (§ 7). Je ne l'ai pas testée par une
expérience dédiée.

**Habitude du dernier vendeur.** Ce n'est pas elle qui porte l'effet : à 3 000 citoyens, k = 5 sans habitude donne
−7,1 pt [−15,3 pt ; +6,6 pt] de sans-abri, −16,06 pt [−22,45 pt ; −0,29 pt] de demande non servie et
+18,3 [+11,0 ; +21,8] entreprises, comme avec l'habitude (rapport `vendeurs-controle-3000-k5nohabit.md`).

**Définition « stock > 0 ».** Voir § 1 : sans le seuil d'une unité, le sans-abri dépasse celui de
k = 0 de +32,0 pt [+25,5 pt ; +42,8 pt] à 3 000 citoyens (10 graines sur 10 au-dessus), ce qui est exactement le défaut
décrit dans la mission.

## 6. Temps

`tool/perf.dart`, exécutable natif (`bash tool/compiler.sh`), graine 1, avec filets, médiane des jours 100 à 300, une
mesure à la fois sur une machine sans autre charge lourde. Le bruit entre deux passages est de l'ordre de ±8 %
(à 13 240 citoyens, k = 0 : 1 340 ms dans un passage, 1 511 ms dans l'autre).

**Temps par jour (ms)**

| Population | k = 0 | k = 3 | k = 5 | k = 8 | k = 12 | k = 20 |
|---|---|---|---|---|---|---|
| 240 | 5,07 | 5,25 | 5,34 | 5,37 | 5,33 | 5,34 |
| 1 000 | 25,54 | 26,61 | 25,71 | 25,98 | 25,58 | 25,49 |
| 3 000 | 109 | 83,78 | 91,90 | 98,83 | 94,33 | 91,39 |
| 13 240 | 1511 | 419 | 455 | 530 | 595 | 691 |
| Temps par citoyen à 13 240 (µs) | 114 | 31,63 | 34,36 | 40,03 | 44,92 | 52,20 |

**Exposant b** (temps ∝ N^b), par tranche de population

| Tranche | k = 0 | k = 3 | k = 5 | k = 8 | k = 12 | k = 20 |
|---|---|---|---|---|---|---|
| 240 → 1 000 | 1,13 | 1,14 | 1,10 | 1,10 | 1,10 | 1,10 |
| 1 000 → 3 000 | 1,32 | 1,04 | 1,16 | 1,22 | 1,19 | 1,16 |
| 3 000 → 13 240 | 1,77 | 1,08 | 1,08 | 1,13 | 1,24 | 1,36 |
| Ajustement sur les 4 tailles | 1,42 | 1,09 | 1,11 | 1,15 | 1,18 | 1,21 |

**Coût de la phase de consommation par achat de ménage (µs)**

| Population (achats de ménages par jour) | k = 0 | k = 3 | k = 5 | k = 8 | k = 12 | k = 20 |
|---|---|---|---|---|---|---|
| 240 (2 873) | 1,53 | 1,58 | 1,59 | 1,62 | 1,61 | 1,61 |
| 1 000 (13 349) | 1,74 | 1,83 | 1,76 | 1,77 | 1,75 | 1,74 |
| 3 000 (36 530) | 2,75 | 2,02 | 2,25 | 2,46 | 2,40 | 2,25 |
| 13 240 (154 456) | 9,41 | 2,19 | 2,47 | 2,91 | 3,33 | 4,06 |

**Entreprises au jour 300**

| Population | k = 0 | k = 3 | k = 5 | k = 8 | k = 12 | k = 20 |
|---|---|---|---|---|---|---|
| 240 | 22 | 22 | 22 | 22 | 22 | 22 |
| 1 000 | 62 | 61 | 62 | 62 | 62 | 62 |
| 3 000 | 151 | 177 | 162 | 152 | 154 | 151 |
| 13 240 | 589 | 701 | 655 | 643 | 619 | 598 |

- **k = 0 n'est pas ralenti** : même empreinte qu'avant la correction à 240, 1 000, 3 000 et 13 240 citoyens, temps dans
  le bruit (1 511 ms contre 1 451 ms pour l'exécutable précédent à 13 240 ; 5,07 contre 5,32 ms à 240).
- **À 13 240 citoyens, k = 5 va 3,3 fois plus vite que k = 0** (455 ms contre 1 511 ms). Avant la correction, k = 5
  prenait 408 ms : le coût de la liste est de l'ordre de 10 %, dans le bruit des mesures (un crochet par changement de stock, le tirage dans la liste).
- **Le coût d'un achat reste plat avec k > 0.** Microbenchmark `tool/vendeurs_cout.dart` (achats d'une unité de pain, nombre
  de boulangeries croissant, un même ménage sans contrainte de budget) :

| Vendeurs de pain | k = 0 | k = 3 | k = 5 | k = 8 | k = 20 |
|---|---|---|---|---|---|
| 10 | 0,99 | 0,60 | 0,89 | 1,48 | 0,90 |
| 50 | 3,35 | 0,57 | 0,81 | 1,21 | 2,59 |
| 200 | 11,98 | 0,66 | 0,92 | 1,20 | 2,49 |
| 1 000 | 70,79 | 0,70 | 0,97 | 1,35 | 2,77 |
| 5 000 | 380,80 | 0,91 | 1,18 | 1,65 | 3,43 |

  À k = 0, le coût par achat est proportionnel au nombre de vendeurs (×380 de 10 à 5 000 vendeurs). À k = 5, il passe de
  0,89 à 1,18 µs (×1,3, dû au cache mémoire et au coût de l'indirection dans de gros tableaux), pour ×500 vendeurs. À
  k = 20, le coût monte à 2,5–3,4 µs : la déduplication des tirages est quadratique en k et le tirage fait plus d'essais.
- **Dans les parties**, le coût de la phase de consommation par achat de ménage passe de 1,6 µs (240 citoyens) à
  2,47 µs (13 240 citoyens, k = 5), contre 9,4 µs à k = 0 (voir le tableau précédent ; la phase comprend aussi le calcul
  des prix de référence et les services publics).
- **Exposant b** (temps ∝ N^b) sur les quatre tailles : k = 0 : 1,42 ; k = 3 : 1,09 ; k = 5 : 1,11 ; k = 8 : 1,15 ; k = 12 : 1,18 ; k = 20 : 1,21.
- **Mémoire** : 90 à 96 Mo à 13 240 citoyens pour toutes les valeurs de k (la liste est de l'ordre du nombre de vendeurs).

## 7. Biais résiduel : quand tirer k vendeurs ne revient plus à tous les comparer

Même sans fausse pénurie, un acheteur qui ne regarde que k vendeurs ne choisit pas toujours le moins cher. Ses
conséquences sur le marché sont mesurées par la concentration des ventes (part de la plus grande entreprise, indice de
Herfindahl-Hirschman, par secteur) et par la dispersion des prix entre vendeurs d'un même bien (écart-type divisé par la
moyenne des prix des vendeurs actifs, moyenné sur les jours).

**k = 5 contre k = 0, sans filets, par secteur** (moyenne des biens du secteur ; `rapports/stat/vendeurs-controle-*.md` pour les
autres)

3 000 citoyens :

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 97,1 % | 98,1 % | +0,9 pt | [−0,0 pt ; +1,5 pt] | 7/10 | non |
| primaire : Herfindahl | 0,962 | 0,975 | +0,012 | [−0,000 ; +0,018] | 7/10 | non |
| primaire : vendeurs actifs par bien | 1,1 | 1,1 | −0,0 | [−0,0 ; −0,0] | 2/10 | oui |
| primaire : dispersion des prix | 15,4 % | 13,5 % | −1,4 pt | [−4,7 pt ; +5,5 pt] | 5/10 | non |
| secondaire : part de la plus grande entreprise | 92,3 % | 91,4 % | −0,7 pt | [−2,3 pt ; +0,7 pt] | 4/10 | non |
| secondaire : Herfindahl | 0,908 | 0,898 | −0,008 | [−0,026 ; +0,005] | 3/10 | non |
| secondaire : vendeurs actifs par bien | 1,5 | 1,5 | +0,0 | [−0,1 ; +0,1] | 5/10 | non |
| secondaire : dispersion des prix | 25,6 % | 25,1 % | −0,7 pt | [−2,4 pt ; +4,4 pt] | 4/10 | non |
| tertiaire : part de la plus grande entreprise | 53,8 % | 52,3 % | −0,9 pt | [−3,0 pt ; +0,7 pt] | 4/10 | non |
| tertiaire : Herfindahl | 0,494 | 0,475 | −0,014 | [−0,032 ; +0,005] | 4/10 | non |
| tertiaire : vendeurs actifs par bien | 5,1 | 5,6 | +0,5 | [−0,1 ; +0,9] | 7/10 | non |
| tertiaire : dispersion des prix | 20,5 % | 28,2 % | +6,0 pt | [+1,0 pt ; +9,4 pt] | 9/10 | oui |

13 240 citoyens :

| Indicateur | k = 0 | k > 0 | Écart médian apparié | Intervalle à 95 % | Graines où B > A | Écart conclu |
|---|---|---|---|---|---|---|
| primaire : part de la plus grande entreprise | 88,2 % | 87,6 % | −0,2 pt | [−0,9 pt ; +0,6 pt] | 4/10 | non |
| primaire : Herfindahl | 0,858 | 0,853 | −0,002 | [−0,010 ; +0,009] | 4/10 | non |
| primaire : vendeurs actifs par bien | 1,8 | 1,8 | −0,0 | [−0,1 ; +0,0] | 2/10 | non |
| primaire : dispersion des prix | 32,4 % | 23,0 % | −6,3 pt | [−11,7 pt ; +0,1 pt] | 2/10 | non |
| secondaire : part de la plus grande entreprise | 81,3 % | 74,2 % | −7,1 pt | [−7,5 pt ; −6,0 pt] | 0/10 | oui |
| secondaire : Herfindahl | 0,784 | 0,712 | −0,070 | [−0,079 ; −0,059] | 0/10 | oui |
| secondaire : vendeurs actifs par bien | 2,8 | 5,6 | +2,8 | [+2,4 ; +3,1] | 10/10 | oui |
| secondaire : dispersion des prix | 20,8 % | 34,4 % | +13,0 pt | [+12,7 pt ; +15,5 pt] | 10/10 | oui |
| tertiaire : part de la plus grande entreprise | 43,4 % | 29,8 % | −13,1 pt | [−14,5 pt ; −11,2 pt] | 0/10 | oui |
| tertiaire : Herfindahl | 0,391 | 0,266 | −0,121 | [−0,134 ; −0,107] | 0/10 | oui |
| tertiaire : vendeurs actifs par bien | 16,2 | 25,4 | +9,0 | [+8,7 ; +9,6] | 10/10 | oui |
| tertiaire : dispersion des prix | 25,6 % | 28,8 % | +2,4 pt | [+0,5 pt ; +6,0 pt] | 9/10 | oui |

- **À 3 000 citoyens**, la concentration ne change pas de façon conclue sans filets (le secteur tertiaire est le seul qui a
  plusieurs vendeurs par bien : 5 à 6) ; avec filets elle baisse dans les secteurs secondaire et tertiaire. La dispersion des
  prix **monte** dans le tertiaire (+6 points sans filets).
- **À 13 240 citoyens**, k = 5 fait baisser nettement la concentration dans les secteurs secondaire et tertiaire (part de
  la plus grande entreprise −7 et −13 points, Herfindahl −0,07 et −0,12) et **monte** le nombre de vendeurs actifs par
  bien. La dispersion des prix monte dans le secondaire (+13 points). Le secteur primaire a 1,8 vendeur par bien : k ne
  change rien pour lui.
- **La médiane des biens** (indicateur `topShareMed` du protocole) peut aller dans le sens contraire (+3,8 points à
  13 240 citoyens) parce que la médiane est prise sur tous les biens et que la composition du parc change. Les tableaux
  par secteur sont plus parlants.

**À partir de quel k le biais est-il négligeable ?** Le tableau du § 5.4 répond : quand k couvre à peu près tous les
vendeurs du bien.

- À **3 000 citoyens**, les indicateurs d'ensemble (sans-abri, faim, chômage, demande non servie, mortalité, dispersion
  des prix) sont indistinguables de k = 0 à partir de **k = 12**, et le parc d'entreprises aussi (+4 sur 124). À k = 8, la
  demande non servie et le parc diffèrent encore de façon conclue ; à k ≤ 5, presque tout diffère.
- À **13 240 citoyens**, à partir de **k = 20** pour le sans-abri, la faim, le chômage et la demande non servie. Le parc
  (+21 entreprises sur 447) et la mortalité restent conclus, faiblement. À k = 12, tout diffère encore (sans-abri −4 points,
  demande non servie −6 points, tous conclus).
- **Conséquence pratique : le biais n'est négligeable que là où le gain de temps disparaît.** À 13 240 citoyens, k = 20 coûte
  691 ms par jour contre 1 511 ms pour k = 0 : 2,2 fois plus rapide, avec encore +21 entreprises. Pour avoir des résultats
  équivalents à k = 0, il faut k ≳ le nombre de vendeurs des gros marchés, et le gain est alors modeste.

Dit sans fard : **`sellerSample` n'est pas une approximation numérique de la règle complète. C'est une autre règle de
marché** (information limitée des ménages), qui change qualitativement les résultats aux tailles où certains biens ont
plus de k + 1 vendeurs. À utiliser comme un choix de jeu, pas comme une accélération neutre.

## 8. Points non résolus

1. **La valeur par défaut reste 0.** Aucun changement. L'adoption de `sellerSample` comme règle de jeu est la décision de
   Francis. Ce rapport la documente ; il ne la recommande pas à ce stade (voir 2).
2. **Quelle économie est la bonne à grande échelle ?** À 13 240 citoyens, k = 0 donne une économie en panne (faim 51 %,
   chômage 62 %, demande non servie 41 %, parc d'entreprises tombé de 1 705 à environ 450) et k = 5 une économie qui tient
   (faim 0,2 %, chômage 24 %, parc de 590). Ce n'est pas une preuve que k = 0 est faux ni que k = 5 est juste. Mais cela montre que la panne observée à
   grande échelle au journal § 6 dépend de la règle « chaque ménage compare tous les vendeurs ». Choix à faire par Francis,
   avec l'hypothèse du § 5.4 à tester (par exemple une version de k = 0 où le bruit sur les prix est plus grand).
3. **Hypothèse du § 5.4 non testée** (la demande se concentre sur le moins cher et fait fermer les autres).
4. **Achats non entiers des ménages** (réparations du module Bâtiments) : ils ne passent pas par la liste (recherche
   complète, un stock fractionnaire leur suffit). Seul le coût de ces achats reste en O(vendeurs).
5. **Achats sans moyens.** Si le ménage ne peut pas payer le moins cher de son échantillon, l'achat s'arrête (`broke`) alors
   qu'un vendeur moins cher hors échantillon aurait pu le servir. Ce n'est pas une fausse pénurie (aucune demande non servie
   n'est comptée), mais c'est un effet de l'échantillonnage. Je ne l'ai pas isolé : il fait partie du biais résiduel du § 7.
6. **Nombre de graines.** Contrôle principal : 10 graines (k = 0 et 5). Les balayages à 13 240 citoyens (k = 3, 8, 12, 20)
   n'ont que 5 graines et une étape (sans filets). Les intervalles sont larges ; les tendances sont monotones mais les
   limites exactes (k = 12 contre k = 20) sont à confirmer avec 30 graines.
7. **Drapeaux de test statiques.** `Sim.availThreshold` (stock minimal de la liste) et `Sim.sellerHabit` (habitude du dernier
   vendeur) sont des variables statiques de classe, réglées par `stabilite --param`. Leur valeur par défaut est celle du
   jeu (une unité ; habitude active) ; elles ne sont ni dans les instantanés ni dans l'interface.
8. **Anciens rapports.** Les rapports `rapports/stat/vendeurs-*.md` et le journal § 8 (Tâche 3) décrivent l'ancien tirage :
   ils sont à considérer comme remplacés par ce rapport pour tout k > 0. Ceux de k = 0 restent valables.
9. **Ordre des offres.** Les offres retenues gardent l'ordre du tirage (et non plus l'ordre des vendeurs) : à égalité
   exacte de clé, la première tirée l'emporte. Les égalités sont exceptionnelles (la clé porte un bruit aléatoire
   continu) ; elles ne le sont qu'en mode `sansHasard`. Les parties à k > 0 de l'ancienne version ne se rejouent donc pas
   à l'identique.
10. **Logement.** Le sans-abri de l'ancien tirage avait été attribué au logement (journal § 8). Après correction, le logement
    n'est plus un problème majeur : sa demande non servie passe de 0,25 % à 0,84 % à 13 240 citoyens (écart conclu mais
    petit, 10 graines sur 10). L'exclure de l'échantillonnage (un bien dont on cherche une place libre, pas un prix)
    reste une décision de règle réservée à Francis.
11. **Contrôle de la propriété à grande échelle.** Le moteur la vérifie avant chaque achat dans les tests (populations
    jusqu'à 300 citoyens) et, par `tool/vendeurs_verif.dart`, à 3 000 citoyens (k = 3, 150 jours) et à 1 500 citoyens
    (k = 5, 200 jours), 2 graines, avec et sans filets : aucune exception. À 13 240 citoyens, le détecteur quotidien de
    liste a été actif dans toutes les parties, mais la vérification avant chaque achat (trop coûteuse) ne l'a pas été.

## 9. Fichiers et reproduction

- Moteur : `lib/engine/sim.dart` (`_Avail`, `_setStock`, `_rebuildAvail`, `availMismatches`, `_AllOffers.sampled`,
  `buy`), `lib/engine/monitor.dart` (alerte critique `listeVendeurs`).
- Tests : `test/proprietes_test.dart` (liste exacte, pas de fausse pénurie), `test/vendeurs_test.dart` (reprise, instantané,
  240 citoyens, k plus grand que tous les vendeurs).
- Outils : `tool/vendeurs_controle.dart` (comparaisons appariées avec intervalles), `tool/vendeurs_cout.dart` (coût par
  achat), `tool/vendeurs_verif.dart` (propriété et liste à grande échelle), `tool/perf.dart` (consommation et achats par jour), `tool/stabilite.dart` (nouveaux indicateurs : demande non
  servie, dispersion des prix, rapport des prix ; paramètres de test `sellerHabit` et `availThreshold`),
  `tool/parite.dart` (cas k = 5 ajouté : VM et JavaScript identiques).
- Reproduction du contrôle principal :

```bash
bash tool/compiler.sh
build/outils/stabilite.exe --population 13240 --graines 10 --days 1000 --phases base,nets --param sellerSample=0 --save k0.json
build/outils/stabilite.exe --population 13240 --graines 10 --days 1000 --phases base,nets --param sellerSample=5 --save k5.json
dart run tool/vendeurs_controle.dart k0.json k5.json --titre "13 240 citoyens, k = 5"
```
