# Calibration à 10 000 citoyens : vitesse et économie de graines

18 octobre 2026, branche `vitesse`. Mission : rendre la calibration à 10 000 citoyens rapide et statistiquement économe,
sans changer un résultat du moteur (hors le seul changement voulu : `sellerSample` = 5 par défaut). Mesures sur le PC
(Ryzen 7 5800X, parties natives, une partie à la fois sauf mention). **Le serveur de calcul était éteint** (arrêt voulu
par Francis quand il ne sert pas) : rien de ce rapport n'a été mesuré dessus ; ce qui s'y rapporte est marqué
« non vérifié » ou « estimé ».

## En bref

- **Valeur de k : 5**, règle de marché du jeu (information limitée sur les vendeurs), pas une optimisation neutre. À
  10 000 citoyens, une journée coûte 255 ms au lieu de 909 ms (k = 0, avant les optimisations).
- **Le moteur est 28 à 35 % plus rapide à k = 5 qu'au début de la mission**, sans qu'aucun résultat change : 327 → 235-255
  ms par jour à 10 000 citoyens, 1 101 → 717-756 ms à 30 000 (14 optimisations exactes, § 3). Empreintes de la batterie
  de référence identiques (`reference.sh --verifier`, 32 éléments), moteurs comparés octet pour octet à 3 000 et 10 000
  citoyens.
- **Passage à l'échelle presque linéaire jusqu'à 30 000 (exposant 0,99), un peu au-dessus ensuite (1,22 de 30 000 à
  100 000)** : pas de problème algorithmique en puissance 2, mais un coût par achat qui monte avec la taille
  (1,69 → 2,27 µs, effet de mémoire cache probable, non démontré). 100 000 citoyens : 3,3 s par jour, 324 Mo. Un million :
  ≈ 45 à 55 s par jour, ≈ 2,8 Go (extrapolé).
- **Graines : beaucoup plus que 30 pour le chômage à 2 500 citoyens.** Pour trancher une comparaison appariée à ±2 points
  de chômage, il en faudrait environ 190 (estimé) ; ±1 point de faim, environ 45 ; ±1 point de sans-abri, environ 60 ;
  ±5 % d'entreprises, 5. Le chômage est l'indicateur coûteux.
- **2 500 citoyens ne remplace pas 10 000 pour les niveaux** : sur 16 comparaisons, 8 différences conclues (concentration
  des ventes 97 % contre 89 %, demande non servie 9,8 % contre 0,4 % sans filets ; avec filets : chômage 18 % contre
  26 %, sans-abri 1,0 % contre 4,8 %, Gini 0,55 contre 0,70). Il sert au criblage et au réglage des outils, pas à lire
  des valeurs absolues.
- **Réserve sur k = 5 à 2 500 citoyens** : l'effet « conclu » à 10 graines (chômage 13,2 → 24,6 %) n'est plus conclu à 30
  graines appariées (§ 1.2). À rapporter tel quel.
- **Outil de calibration livré, rien calibré** : `tool/criblage.dart` (Morris puis hypercube latin). Exemple sur 13
  paramètres : `markup`, `dividendRate`, `taxRate`, `wageStep` comptent le plus ; `entryMinShare` n'a aucun effet
  mesurable (§ 5).
- **Non fait : première nuit de référence (T5), en attente de l'accord de Francis ; parité PC ↔ serveur et débit
  N = 1 et N = 8 à k = 5, en attente que le serveur soit rallumé.**

## 1. k = 5 par défaut (tâche 0)

### 1.1 Ce qui change dans le moteur

`Params.sellerSample` vaut 5 (commit `f627257`) : chaque ménage compare cinq vendeurs tirés au hasard au lieu de tous.
`partie.exe`, `stabilite.dart`, l'interface et `lot_serveur.sh` lisent cette valeur ; le protocole historique se rejoue
avec `--param sellerSample=0`. C'est le seul changement de comportement de la mission. Nouvelle référence : `rapports/
reference/reference.txt` (`tool/reference.sh --verifier`). MODELE.md dit que c'est une règle de marché, à réexaminer avec
les variétés de produits.

### 1.2 Avant / après (médianes sur les graines, k = 0 contre k = 5, même version du moteur)

| Mesure | Avant (k = 0) | Après (k = 5) |
|---|---|---|
| 240 habitants, 30 graines × 1 500 j, sans filets : chômage | 8,0 % | 8,1 % |
| … faim | 6,1 % | 6,4 % |
| … sans-abri | 2,6 % | 2,7 % |
| … parc d'entreprises | 17,8 | 17,9 |
| 240 habitants, avec filets : mêmes quatre indicateurs | identiques | identiques |
| 2 500 habitants, 10 graines × 1 000 j, sans filets : chômage | 13,2 % | 24,6 % |
| … faim | 0,1 % | 1,0 % |
| … sans-abri | 0,6 % | 6,2 % |
| … parc d'entreprises | 109,3 | 112,2 |
| 2 500 habitants, avec filets : chômage / faim / sans-abri / entreprises | 13,8 % / 0,0 % / 0,8 % / 117,5 | 18,2 % / 0,0 % / 1,0 % / 122,0 |
| Temps par jour, 240 habitants (jours 100-300) | 5,09 ms | 4,77 ms |
| … 2 500 habitants | 83,9 ms | 68,6 ms |
| … 10 000 habitants (jours 100-150) | 908,5 ms | 340,2 ms |

**Réserve importante.** Les 10 graines de 2 500 habitants donnaient un chômage et un sans-abri plus hauts à k = 5. Le
test apparié à arrêt séquentiel sur 30 graines (§ 2) ne le confirme pas : sans filets, différence médiane B − A de
+4,1 points de chômage [−3,3 ; +6,9] et de +0,4 point de sans-abri [−0,2 ; +2,6] ; avec filets, +0,2 [−6,0 ; +6,0] et
+0,0 [−0,4 ; +0,6]. Seul le parc d'entreprises est plus haut à k = 5 (+3,6 % [+2,6 ; +6,4] sans filets, +2,3 % [+1,4 ;
+3,5] avec filets). **L'effet de k = 5 sur le chômage à 2 500 citoyens n'est pas établi** (ni dans un sens ni dans
l'autre) : le chômage est trop dispersé entre graines. À 3 000 et 13 240 citoyens, k = 5 était meilleur que k = 0 dans
les mesures précédentes (rapports `vendeurs-*`).

### 1.3 Parité PC ↔ serveur et débit à k = 5 : non vérifiés

Serveur éteint. Commandes prêtes, à lancer dès qu'il est rallumé (voir `rapports/serveur-calcul.md`, § 8) :

```bash
bash tool/envoyer_serveur.sh && bash tool/parite_serveur.sh   # doit finir par « PARITÉ : IDENTIQUE »
ssh ubuntu@econodes-calc 'cd ~/econodes/<révision> && bash tool/reference.sh --verifier'
bash tool/mesure_debit.sh --paliers 1,8                        # environ 5 minutes
```

`rapports/serveur-calcul.md` porte maintenant un avertissement (chiffres mesurés à k = 0, donc bornes hautes) et un § 8
d'estimation à k = 5 : protocole de 60 parties à 10 000 habitants ≈ 1 h 35 à 1 h 45 et ≈ 0,6 $ (contre 5 h 39 et 2,02 $),
une nuit de 10 h ≈ 300 parties (contre 104). Estimation tirée du rapport 255/909 mesuré sur le PC aux jours 11-50, à ±30 %.

## 2. Échelle (tâche 1)

Une partie à la fois, k = 5, filets actifs, graine 1, 50 jours, temps médian des jours 11 à 50, exécutable natif.
Mesure finale, après toutes les optimisations.

| Citoyens | Initialisation | ms par jour | Mémoire pic | Entreprises | Exposant (ms/j) |
|---|---|---|---|---|---|
| 1 000 | 0,09 s | 18,5 | 49 Mo | 122 | — |
| 10 000 | 1,06 s | 255,5 | 80 Mo | 1 266 | 1,14 (depuis 1 000) |
| 30 000 | 3,4 s | 756,3 | 138 Mo | 3 322 | 0,99 |
| 100 000 | 14,1 s | 3 269 | 324 Mo | 11 039 | 1,22 |

Exposant entre 10 000 et 100 000 : 1,11. Initialisation : 1,07 puis 1,17. Mémoire : ≈ 2,7 Ko par citoyen au-delà de
30 000 (stable).

**Lecture.** L'exposant du coût d'une journée dépasse un peu 1,2 sur le dernier palier (1,22). Ce n'est pas un coût en
puissance 2 : il faudrait un exposant proche de 2. Les achats des ménages par jour croissent moins vite que la
population (122 mille à 10 000, 1,04 million à 100 000, soit ×8,5), mais le coût d'un achat passe de 1,69 à 2,27 µs, et
les 25 % de temps passés dans les lectures de tables par chaînes (§ 3) sont typiquement sensibles à la mémoire cache.
Ce que je ne peux pas affirmer : que ce soit bien la cause ; je n'ai pas de compteur de défauts de cache. Le coût hors
achats des ménages (49 ms à 10 000, 898 ms à 100 000) croît plus vite (exposant 1,26) ; il vaut un profil séparé.

**Extrapolation à 1 000 000 de citoyens** (exposant de 1,11 à 1,22 depuis 100 000) : 42 à 54 s par jour, soit une
cinquantaine de jours en 35 à 45 minutes et 1 500 jours en 18 à 23 heures ; initialisation ≈ 3,5 minutes ; mémoire ≈ 2,8
Go. Tient en mémoire sur le PC (32 Go) comme sur le serveur (15 Go) ; ne tient pas en temps pour un protocole de
plusieurs graines sans un travail algorithmique de plus.

**Trois fonctions dominantes à 100 000** (profil CPU de 150 s, temps exclusif, en JIT : les proportions comptent, pas les
durées) :

1. lecture dans une table à chaînes (`LinkedHashMap[]`) : **24,9 %** de l'exclusif, dont près de la moitié depuis
   `_AllOffers.sampled` (prix et stock d'un vendeur par `f.price[bien]`, `f.inv[bien]`), puis `Sim.buy` (loisirs),
   `_LazyOffers.next`, `_setStock`, `_BestOffers.quote` ;
2. `hash32` (tirage de hasard par couple) : **4,7 %** ;
3. `_AllOffers.sampled` (tirage des cinq vendeurs) : **4,5 %**.

Piste suivante, non faite : remplacer les tables `price` et `inv` de l'entreprise par des tableaux indexés par un numéro
de bien (le gain est limité à ces lectures, mais elles pèsent le quart du temps).

## 3. Optimisations exactes (tâche 2)

14 changements, deux commits (`f475202`, `4f8dfe5`). Après chacun : empreintes et instantanés identiques (batterie
`reference.sh`, comparaison de deux exécutables `tool/comparer_moteurs.sh` à 3 000 et 10 000 citoyens, 2 500 avec
jobs + buildings), parité VM / JavaScript, `verifyFastPaths` (chaque chemin rapide est recoupé avec l'ancien), 86 tests.
Gains en ms par jour, 10 000 / 30 000 citoyens :

| Optimisation | 10 000 | 30 000 |
|---|---|---|
| Prix et stocks des vendeurs relevés une fois pendant les achats d'intrants | 0 % | −4 % (−8 % à 100 000) |
| Meilleur prix : prix lu avant le stock ; liste des vendeurs disponibles refaite à la demande | — | −2 % |
| Flux lissés des entreprises fermées retirés en une passe ; prix triés gardés dans le cache | −6 % | −1 % |
| Produit de deux entiers 32 bits en un seul produit sur la VM (la voie JavaScript reste) | −5 % | −7 % |
| Premier tirage de Mulberry32 sans créer d'objet | −3 % | −3 % |
| `_choose` : meilleur prix lu une fois | −6 % | −4 % |
| Loisirs : attrait de base et meilleures offres calculés une fois par jour | −6 % | −5 % |
| Offres d'entreprise servies paresseusement (même ordre que `_AllOffers`) | −3 % | −12 % |
| Cache des meilleurs prix couvrant l'investissement | −2 % | — |
| Vendeurs en tableaux (prix, « a du stock ») tenus à jour | −3 % | −5 % |
| Initialisation par ensembles disjoints (candidats triés par qualification) | — | 6,1 → 3,3 s ; à 100 000 : 52 → 14 s |

Cumul : 327 → 235 ms par jour à 10 000 (−28 %) et 1 101 → 717 ms à 30 000 (−35 %) sur les mesures de tout début et de
fin d'optimisation sur machine calme ; la série finale ci-dessus donne 255 et 756 ms (autres processus Dart actifs sur le
PC pendant la série). Les gains marqués « — » n'ont pas été isolés à cette taille. Une optimisation (tirage commun de
`sampled` hissé) n'a rien donné de mesurable et a été annulée.

## 4. Nombre de graines : arrêt séquentiel (tâche 3)

### 4.1 Les trois niveaux

| Niveau | Citoyens | Usage | Coût indicatif (PC) |
|---|---|---|---|
| Non-régression | 240 | `stabilite --niveau 0` ou `1` : le moteur n'a pas changé de comportement | 8 s à 3 min |
| Exploration | 2 500 | criblage, réglage des outils, choix du nombre de graines | 20 parties de 1 000 jours : 3 min 42 |
| Validation de nuit | 10 000 | protocole de stabilité, calibration finale | 20 parties de 1 000 jours : 15 min 8 (16 à la fois) |

### 4.2 Combien de graines

`tool/sequentiel.dart` ajoute des graines par lots de 5 (30 au plus) et s'arrête quand la demi-largeur de l'intervalle à
95 % de la différence médiane appariée (bootstrap) passe sous un seuil par indicateur. Essai : k = 0 contre k = 5 à 2 500
citoyens, 1 000 jours, 30 graines sans arrêt anticipé (21 minutes), pour tracer la courbe. Données :
`rapports/donnees/sequentiel-k0-k5-2500.md`.

| Indicateur (seuil) | Demi-largeur à 30 graines, sans filets | Graines nécessaires sans filets | Demi-largeur à 30 graines, avec filets | Graines nécessaires avec filets |
|---|---|---|---|---|
| Chômage (±2 pt) | 5,1 pt | **≈ 190** (extrapolé) | 6,0 pt | **≈ 270** (extrapolé) |
| Faim (±1 pt) | 1,2 pt | ≈ 45 (extrapolé) | 0,00 pt | 10 |
| Sans-abri (±1 pt) | 1,4 pt | ≈ 60 (extrapolé) | 0,48 pt | 10 |
| Parc d'entreprises (±5 %) | 1,9 % | 5 | 1,1 % | 5 |

Les extrapolations supposent une demi-largeur proportionnelle à 1/√n à partir de 30 graines ; la courbe mesurée
(chômage sans filets : 15,6 → 9,3 → 7,2 → 5,3 → 6,2 → 5,1 pt à 5, 10, 15, 20, 25, 30 graines) n'est pas régulière :
traiter ces nombres comme des ordres de grandeur. **Le seuil de ±2 points sur le chômage n'est pas atteint en 30 graines** ;
le plafond de 30 est celui de la mission, il est donc atteint sans arrêt anticipé pour le chômage.

Pourquoi : à 2 500 citoyens, le chômage moyen d'une graine va de 10,7 à 39,5 % (écart interquartile 13,7 points). À
10 000 citoyens l'écart interquartile tombe à 6,0 points (sans filets) : la dispersion entre graines diminue avec la
taille, ce qui joue en faveur de 10 000 pour réduire le nombre de graines (à vérifier sur 30 graines).

### 4.3 2 500 contre 10 000 citoyens

`tool/convergence.dart`, protocole de stabilité (10 graines, 1 000 jours, k = 5), médiane et intervalle à 95 % par
taille, différence des médianes avec son intervalle (bootstrap indépendant : les hasards diffèrent d'une taille à
l'autre). Données : `rapports/donnees/convergence-2500-10000.md`.

| Indicateur | Sans filets 2 500 | Sans filets 10 000 | Avec filets 2 500 | Avec filets 10 000 |
|---|---|---|---|---|
| Chômage | 24,6 % | 21,6 % (non distinguable) | 18,2 % | 26,0 % (**différent**, +7,8 pt) |
| Faim | 1,0 % | 0,2 % (non distinguable) | 0,0 % | 0,4 % (**différent**) |
| Sans-abri | 6,2 % | 3,7 % (non distinguable) | 1,0 % | 4,8 % (**différent**, +3,8 pt) |
| Demande non servie | 9,8 % | 0,4 % (**différent**) | 1,6 % | 1,4 % (non distinguable) |
| Gini | 0,69 | 0,68 (non distinguable) | 0,55 | 0,70 (**différent**) |
| Entreprises pour 1 000 hab. | 44,9 | 45,9 (non distinguable) | 48,8 | 48,2 (non distinguable) |
| Part de la plus grande entreprise | 97,1 % | 89,3 % (**différent**) | 97,3 % | 87,7 % (**différent**) |

Bilan : 8 différences conclues sur 16, 8 non distinguables. **Ma réponse : 2 500 n'est pas un bon substitut de 10 000.**
« Non distinguable » ne veut pas dire « équivalent » : avec 10 graines, la demi-largeur de l'intervalle dépasse souvent
l'écart interquartile (colonne « Demi-largeur / EIQ » du fichier de données), et le test n'aurait pas vu un écart de
l'ordre de la dispersion entre graines. Les différences conclues portent sur le fonctionnement du marché (concentration
des ventes plus forte à 2 500) et sur les filets ; je n'ai pas cherché la cause. Usages sûrs de
2 500 : criblage des paramètres (§ 5), vérifications d'outil, nombre de graines pour le parc d'entreprises. Usages à
éviter : lire le niveau de chômage, de faim ou de sans-abri comme une prédiction pour 10 000.

## 5. Méthode de calibration (tâche 4)

`tool/criblage.dart` (aucune calibration faite). Deux étapes :

1. **Criblage de Morris** (`criblage.exe morris`) : 4 niveaux par paramètre, pas de 2/3, r trajectoires de k + 1 parties,
   effets élémentaires, μ* (importance), μ (sens), σ (non-linéarité ou interactions). 13 paramètres
   (`tool/parametres.dart`, plages de ≈ ×0,5 à ×2, d'exploration seulement) et r = 8 : 112 parties à 2 500 citoyens,
   600 jours, 10 min 33 s sur le PC. Une graine de partie par trajectoire.
2. **Hypercube latin** (`criblage.exe lhs --params a,b,c`) sur les paramètres retenus : N points, un par strate, strates
   permutées ; corrélations de rang avec chaque indicateur ; points dans les bandes de stabilité. Exemple : `markup`,
   `taxRate`, `wageStep`, 30 points, 2 min 47.

Le modèle de substitution de Lamperti, Roventini et Sani (2018) n'est pas écrit : une centaine de parties à 2 500
citoyens (11 minutes) n'en a pas besoin. Il le deviendrait au-delà de quelques milliers d'évaluations.

**Résultat du criblage** (`rapports/donnees/morris-2500.md`, importance μ* en points de pourcentage pour une traversée
de la plage) :

| Indicateur | Paramètres qui comptent le plus |
|---|---|
| Chômage | `markup` 24,7 ; `dividendRate` 12,3 ; `wageStep` 7,6 ; `mpcIncome` 7,4 ; `priceStep` 6,7 |
| Faim | `wageStep` 3,6 ; `taxRate` 3,2 ; `markup` 2,9 ; `benefit` 2,4 |
| Sans-abri | `taxRate` 7,8 ; `markup` 6,7 ; `wageStep` 5,8 ; `dividendRate` 4,2 |
| Parc d'entreprises | `markup` 17,5 ; `priceStep` 9,8 ; `priceMaxDaily` 8,6 |
| Gini | `markup` 0,38 ; `mpcIncome` 0,18 ; `taxRate` 0,17 |

Presque tous les σ / μ* dépassent 1 : les effets dépendent des autres paramètres ou changent de sens, et le chaos
d'une partie (un même changement de paramètre déplace toute la trajectoire de hasard) y contribue sans qu'on puisse le
séparer ici. Avec r = 8, c'est un classement, pas une mesure. **`entryMinShare` : μ* = 0,00 sur tous les indicateurs**,
et `entryCooldown` presque rien : soit ces paramètres n'agissent pas dans cette configuration (module non actif), soit
ils ne sont pas branchés comme on le croit ; à vérifier avant de les calibrer. Hypercube latin (3 paramètres, 30
points, `rapports/donnees/lhs-2500.md`) : corrélations de rang `markup`–chômage +0,82, `markup`–Gini +0,79,
`taxRate`–sans-abri −0,83, `taxRate`–faim −0,71, `wageStep`–inflation −0,64 (seuil de signification ≈ 0,37 avec 30
points) ; 11 points sur 30 tiennent les bandes (chômage ≤ 10 %, faim < 2 %, sans-abri < 2 %). Ce sont des corrélations
à 2 500 citoyens : à confirmer à 10 000 avant d'y fixer des valeurs.

## 6. Première nuit de référence (tâche 5) : en attente de l'accord de Francis

Non lancée. Proposition : protocole de stabilité à 10 000 citoyens, 30 graines, filets actifs et coupés, k = 5,
1 500 jours (60 parties), par `lot_serveur.sh --eteindre-a-la-fin` sur le serveur. Estimation (non mesurée sur le
serveur) : 1 h 35 à 1 h 45, ≈ 0,6 $, soit un seul lot de moins de 2 h. La règle « aucun lot de plus de 30 minutes sans
accord » s'applique : il faut votre accord, et le rallumage du serveur par vos soins. Deux points à décider avec cet
accord : (a) la parité PC ↔ serveur et la mesure de débit à k = 5 passent d'abord (≈ 10 minutes) ; (b) le plafond de
30 graines suffit à 10 000 citoyens pour la faim, le sans-abri et les entreprises, pas démontré pour le chômage.

## 7. Reproduire

```bash
bash tool/compiler.sh                                   # exécutables natifs dans build/outils/
bash tool/reference.sh --verifier                       # IDENTIQUE (32 éléments)
build/outils/perf.exe --population 100000 --jours 50 --depuis 11
build/outils/sequentiel.exe --population 2500 --days 1000 --a param:sellerSample=0 --b ref --max 30 --sans-arret
build/outils/stabilite.exe --population 10000 --graines 10 --days 1000 --phases base,nets --save a.json
dart run tool/convergence.dart rapports/donnees/convergence-2500.json a.json
build/outils/criblage.exe morris --population 2500 --days 600 --trajectoires 8
build/outils/criblage.exe lhs --params markup,taxRate,wageStep --points 30
```

Données dans `rapports/donnees/` (`convergence-2500.*`, `convergence-10000.*`, `convergence-2500-10000.md`,
`sequentiel-k0-k5-2500.*`, `morris-2500.*`, `lhs-2500.*`).
