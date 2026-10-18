# Serveur de calcul : mise en service, parité et débit

Branches `tests/serveur-calcul` (fusionnée dans main) puis `tests/serveur-revisions` (un dossier par révision,
§ 5.1), 17–18 octobre 2026, révision du moteur `e723f5c`. Serveur `econodes-calc` (SSH par Tailscale). Moteur non
modifié ; ajouts : `tool/envoyer_serveur.sh`, `tool/lot_serveur.sh`, `tool/mesure_debit.sh`, `tool/etat_serveur.sh`,
`tool/parite_plateformes.sh`, `tool/parite_serveur.sh`, `tool/parite_comparer.dart`.

## En bref

- **Parité PC ↔ serveur : identique.** Mêmes états au bit près sur 9 300 jours d'empreintes quotidiennes (16 parties
  de l'état par jour), 21 instantanés complets (jours 100, 500 et 1 500 ; 3 graines ; filets actifs et coupés ;
  10 000 habitants au jour 100), la synthèse du protocole niveau 0 (2 881 valeurs) et la sortie de `parite.exe`. Sous
  charge (8 parties à la fois), l'état du jour 100 est le même qu'avec une partie seule, et que sur le PC.
- **Débit à 10 000 habitants** : 1 062 ms par jour pour une partie seule ; 16 198 jours de partie par heure avec
  8 parties à la fois, soit 4,8 fois une partie seule et 24 % de plus qu'avec 4. Aucun temps volé par l'hyperviseur
  (st = 0 % à tous les paliers). Mémoire : environ 80 à 90 Mo par partie, sans contrainte.
- **Protocole de stabilité à 10 000 habitants** (30 graines × 1 500 jours, sans et avec filets, 60 parties) :
  **≈ 5 h 40 et 2,02 $** avec `tool/lot_serveur.sh` (8 à la fois) ; **≈ 7 h et 2,5 $** avec
  `stabilite.exe --isolats 8`, qui donne le rapport habituel mais prend 26 % de temps en plus (voir § 3.3).
  Estimation prudente : les jours 100 à 300 coûtent 10 % de moins que les 100 premiers.
- **Recommandation : 8 parties en parallèle** (jamais 6). Une nuit de 10 h fait tenir un protocole complet de 60 parties
  à 10 000 habitants, avec de la marge (jusqu'à environ 104 parties de 1 500 jours par `lot_serveur.sh`).

## 1. Configuration

| | Serveur | PC (référence) |
|---|---|---|
| Machine | AWS c7i.2xlarge, us-east-2c (Ohio), à la demande | — |
| Processeur | Intel Xeon Platinum 8488C : 4 cœurs physiques × 2 fils = 8 vCPU (le vCPU k et le vCPU k+4 partagent le cœur k) | AMD Ryzen 7 5800X, 8 cœurs, 16 fils |
| Mémoire, disque | 15,3 Gio, pas d'échange ; 48 Go (2,7 Go occupés) | 32 Go |
| Système | Ubuntu 26.04.1 LTS, noyau 7.0.0-1014-aws, x86_64 | Windows 11 |
| Dart | 3.10.4 (stable), linux_x64 | 3.10.4 (stable), windows_x64 (Flutter 3.38.5) |
| Outils | tmux 3.6 (déjà installé), `/usr/bin/time`, `vmstat` | Git Bash |

- **Dart** : archive officielle `dartsdk-linux-x64-release.zip` 3.10.4, somme SHA-256 vérifiée contre celle publiée
  (`60a9a34e…`), installée dans `~/dart-sdk` (ajoutée au `PATH` dans `~/.bashrc`). Paquet installé par apt : `unzip`.
- **Pas de Flutter** : `lib/engine/` est du Dart pur (il n'importe que `dart:math` et `dart:convert`) ; les outils
  n'importent que `dart:` et `package:econodes`. Voir § 6 pour la résolution des paquets.
- **Aucun secret sur le serveur** : `~/.ssh` ne contient que `authorized_keys` (une clé), pas de `~/.aws`, pas de clé
  GitHub. Le code y va par `git archive` (fichiers suivis seulement, sans `.git`) ; les résultats reviennent par
  `ssh … tar` ou `scp`. Tailscale y était déjà installé et connecté (pas de jeton ajouté).
- **Compilation** : `bash tool/compiler.sh`, 11 s, 5 exécutables natifs (6 depuis `tool/fusion_syntheses.dart`) dans
  `build/outils/`, aucune erreur de compilation (deux problèmes d'environnement réglés, § 6).
- **Envoi d'une nouvelle révision** : `bash tool/envoyer_serveur.sh` depuis le PC (archive en LF, configuration des
  paquets, compilation). Chaque révision a son dossier, `~/econodes/<révision>/` (§ 5.1). Testé à `e723f5c`, `772e874`
  et `19ae708` ; la parité des exécutables recompilés a été revérifiée à chaque fois.

## 2. Parité PC ↔ serveur

Mêmes exécutables natifs des deux côtés, compilés de la même révision, mêmes commandes
(`tool/parite_plateformes.sh`, lancé sur les deux machines en même temps), sorties comparées par
`tool/parite_comparer.dart`. Verdict : **PARITÉ : IDENTIQUE**, deux fois : à la révision `e723f5c`, puis à `772e874`
(ces outils ajoutés, moteur inchangé) après le redémarrage du serveur, par `bash tool/parite_serveur.sh` en une
commande.

| Vérification | Étendue | Résultat |
|---|---|---|
| `parite.exe` : `hash32`, tirage des 19 flux de hasard, empreintes des graines 1 et 42 jusqu'au jour 400 | 10 lignes | identique (à la fin de ligne près : `print` écrit CRLF sous Windows) |
| Empreintes quotidiennes de `partie.exe --empreintes` (16 parties de l'état : citoyens, entreprises, marchés, caisse, flux, comptes, services, filets, moniteur, historiques…), 240 habitants | 3 graines × 1 500 jours × filets actifs et coupés = 9 000 jours | identiques chaque jour |
| Instantanés complets (`--snapshot-at 100,500,1500`), SHA-256 du fichier | 18 instantanés | identiques |
| Protocole niveau 0 (`stabilite.exe --niveau 0` : 5 graines × 500 jours, sans et avec filets), synthèse `--save` | 2 881 valeurs (sans la date, la durée et le nombre d'isolats : 16 sur le PC, 8 ici) | identiques |
| 10 000 habitants : empreintes quotidiennes et instantané du jour 100 | 3 graines × 100 jours | identiques |
| Sous charge, sur le serveur : instantané du jour 100 à 10 000 habitants | graine 1 à N = 1, 2, 4, 6 et 8 ; graines 2 à 6 à plusieurs N | identiques entre eux et au PC |

Empreintes des instantanés (16 premiers chiffres du SHA-256, les mêmes sur les deux machines) :

| Graine | Filets | Jour 100 | Jour 500 | Jour 1 500 |
|---|---|---|---|---|
| 1 | actifs | `88d1448b46f35ab8` | `ecb14db3709b61b2` | `a1e9e67b1d45d596` |
| 2 | actifs | `a27aee9aea934b89` | `fd38939742fe20b5` | `d29af6c8953573ed` |
| 3 | actifs | `1b40a4a6640cd474` | `681abe89640aa8c5` | `39010a33e1bd0e7b` |
| 1 | coupés | `6d25eb791ed575c7` | `457f3f2833130300` | `9874918ea9f8d557` |
| 2 | coupés | `356f7e7588bad45d` | `4f95a7395aa7c1f7` | `0739ef58b985ac92` |
| 3 | coupés | `4d309ab5c906c59e` | `90d27ec0c05177cf` | `c50d707e879c4ec1` |
| 1, 2, 3 à 10 000 hab. | actifs | `f7b4da49424caff7`, `2ce49dd5fc665654`, `c8e56c84f74427c5` | — | — |

**Pourquoi c'est solide.** Les suspects habituels sont absents du moteur : aucun appel à `exp`, `log`, `pow`, `sqrt`
ni aux fonctions trigonométriques (la bibliothèque mathématique du système diffère entre Windows et Linux) ; seulement
`+ − × ÷`, `min` et `max`, arrondis de la même façon par toute unité IEEE 754 x86-64. Les tables et ensembles de Dart
gardent l'ordre d'insertion : l'ordre d'itération ne dépend pas du hachage. **Ce qui reste à surveiller** : un
changement du moteur qui ajouterait une de ces fonctions. `bash tool/parite_serveur.sh` refait toute la batterie en
3 minutes environ, à relancer après chaque changement du moteur, avant un lot. En cas de divergence, il donne le
premier jour et les parties de l'état qui diffèrent. Pour trouver la première quantité qui diffère : un instantané à ce
jour sur chaque machine (`tool/partie.dart --snapshot-at <jour>`), puis la comparaison des deux fichiers.

Le comparateur a été vérifié sur une copie altérée (une empreinte changée au jour 700) : il signale bien le jour 700,
la partie `marches`, et rend le code de sortie 1.

## 3. Débit à 10 000 habitants

Mesure : `bash tool/mesure_debit.sh` (graines 1 à N, 100 jours, filets actifs, réglages par défaut, instantané du jour
100 pour l'empreinte ; graine de base 1 comme dans `tool/perf.dart`). Chaque partie est un processus `partie.exe`,
mesuré par `/usr/bin/time -v` ; `vmstat 5` pendant chaque palier. Les paliers ont tourné l'un après l'autre, la
machine sans autre charge.

### 3.1 Paliers

| N | Durée du palier | ms par jour, moyenne par partie | Pire partie | Mémoire totale (RSS max.) | Jours de partie par heure (machine) | st moyen / max | us moyen |
|---|---|---|---|---|---|---|---|
| 1 | 106,2 s | 1 062 | 1 062 | 206 Mo | 3 390 | 0 % / 0 % | 13 % |
| 2 | 107,6 s | 1 075 | 1 076 | 410 Mo | 6 691 | 0 % / 0 % | 26 % |
| 4 | 110,2 s | 1 100 | 1 102 | 867 Mo | 13 067 | 0 % / 0 % | 52 % |
| 6 | 156,0 s | 1 449 | 1 559 | 1 272 Mo | 13 846 | 0 % / 0 % | 72 % |
| 8 | 177,8 s | 1 774 | 1 778 | 1 739 Mo | **16 198** | 0 % / 0 % | 99 % |

- **Jusqu'à 4 parties** (une par cœur physique), chaque partie garde presque sa vitesse : +3,6 % à N = 4.
- **Au-delà, l'hyperthreading** fait partager un cœur à deux parties : chacune prend 61 % de temps en plus
  (1 774 contre 1 100 ms par jour), mais la machine produit 24 % de plus. À **N = 6**, deux cœurs portent deux parties et deux
  n'en portent qu'une : les parties vont de 1 343 à 1 559 ms par jour, le débit ne gagne que 6 % sur N = 4. À éviter.
- **Mémoire.** Les 200 à 250 Mo par partie de ce tableau comptent l'écriture de l'instantané du jour 100 (23 Mo de
  JSON). Une partie sans instantané monte à 81 Mo (`perf.exe`, 300 jours) ; `stabilite.exe`, à 88 à 91 Mo par
  partie. 8 parties tiennent dans moins de 2 Go sur 15 : la mémoire ne limite pas.
- **Temps volé (st) : 0 % à chaque échantillon, à tous les paliers.** L'instance c7i.2xlarge est une instance à
  performances fixes (pas de crédits CPU) ; rien n'indique de voisin bruyant pendant la mesure (une demi-heure).
  `lot_serveur.sh` enregistre `vmstat` toutes les minutes pendant un lot et rapporte le st moyen et maximal à la fin.
- **Indépendance à la charge** : la graine 1 donne le même état au jour 100 (`f7b4da49…`) à N = 1, 2, 4, 6 et 8,
  comme sur le PC ; de même pour les graines 2 à 6 à chaque palier où elles figurent.

### 3.2 Mesures complémentaires (une partie seule, 10 000 habitants)

| Mesure | Résultat |
|---|---|
| Même partie sur le PC (Ryzen 7 5800X, exécutable natif) | 98,8 s, soit 988 ms par jour, même empreinte : un cœur du serveur est 7 % plus lent qu'un cœur du PC |
| Profil sur 300 jours (`perf.exe`) | initialisation 1,5 s ; médiane des jours 100 à 300 : **951 ms par jour** ; 1 001 entreprises au jour 100, 452 au jour 300 ; 81 Mo |
| Sans filets (`--filets 0`), 100 jours | 1 058 ms par jour (avec filets : 1 062) : même coût |
| `stabilite.exe`, une graine, un isolat, 100 jours | 117,9 s (+11 % sur `partie.exe`) : le protocole calcule ses indicateurs chaque jour |

À 240 habitants, la population ne change pas sur 1 500 jours et le nombre d'entreprises baisse d'un quart avant le jour
500, puis se stabilise (instantanés de la parité). À 10 000 habitants, il baisse de moitié entre les jours 100 et 300.
Une journée coûte donc plutôt moins après les 100 premiers jours : environ −10 % aux jours 100 à 300. Les jours 300 à
1 500 n'ont pas été mesurés à cette taille (une partie complète prend environ 25 minutes) : l'extrapolation prend le
coût des 100 premiers jours, ce qui est prudent.

### 3.3 Le protocole lui-même : isolats ou processus

`stabilite.exe --isolats N` fait tourner ses parties dans un seul processus, une par isolat (`Isolate.run`). Ces
isolats partagent le même tas, donc le même ramasse-miettes. Mesuré avec 8 parties de 100 jours :

| Manière | Durée | Jours de partie par heure |
|---|---|---|
| 8 × `partie.exe` (processus séparés) | 177,8 s | 16 198 |
| 8 × `stabilite.exe --isolats 1` (processus séparés) | 194,6 s | 14 799 |
| 1 × `stabilite.exe --isolats 8` (un processus, 8 isolats ; 728 % de CPU, 392 Mo) | 223,2 s | 12 903 |

Le protocole coûte 9 à 11 % de plus que `partie.exe` (ses indicateurs), et les 8 isolats d'un même processus encore
15 % de plus que 8 processus. `tool/stabilite.dart` n'a pas été modifié : hors du périmètre de la tâche. Gagner ces
15 % demanderait de lancer une graine par processus, puis de fusionner les synthèses (`--save`). Cet outil de fusion
n'existe pas (voir § 7).

## 4. Extrapolation : protocole de stabilité, 60 parties

30 graines × 1 500 jours, sans et avec filets, à 10 000 habitants : 60 parties, 90 000 jours de partie. Prix vérifié
par l'API de tarification AWS (en vigueur au 1er octobre 2026, us-east-2, Linux, à la demande) : **c7i.2xlarge
0,357 $/h**, c7i.4xlarge 0,714 $/h. Les parties ont toutes la même longueur : elles partent par vagues
(`xargs -P` ou les isolats de `stabilite`) ; 60 parties à 8 font 7 vagues pleines et une demi-vague de 4.

| Manière (c7i.2xlarge) | À la fois | Durée d'une partie de 1 500 jours | Durée totale (prudente) | Coût |
|---|---|---|---|---|
| `lot_serveur.sh` (`partie.exe`) | **8** | 44 min 27 s (1 778 ms/j) ; demi-vague finale : 27 min 33 s | **5 h 39** | **2,02 $** |
| `lot_serveur.sh` | 6 | 34 à 39 min | 6 h 30 | 2,32 $ |
| `lot_serveur.sh` | 4 | 27 min 33 s (1 102 ms/j) | 6 h 53 | 2,46 $ |
| `stabilite.exe --isolats 8` (le rapport habituel) | 8 | 55 min 48 s (2 232 ms/j) ; demi-vague : ≈ 34 min (non mesuré) | ≈ 7 h 05 | ≈ 2,53 $ |
| `stabilite.exe`, un processus par graine et par étape (outil de fusion à écrire) | 8 | 48 min 39 s (1 946 ms/j) | ≈ 6 h 10 | ≈ 2,21 $ |

- **Nombre optimal de parties à la fois : 8**, une par vCPU.
- **Estimation probable** : environ 10 % de moins (le coût des jours 100 à 300), soit ≈ 5 h 05 et 1,81 $ par
  `lot_serveur.sh`, ≈ 6 h 20 et 2,28 $ par `stabilite.exe --isolats 8`.
- **À ajouter** : l'adresse IPv4 publique de l'instance, 0,005 $/h (0,03 $ pour 6 h) ; le disque de 48 Go, environ
  3,84 $ par mois s'il est en gp3 (0,08 $/Go-mois), facturé tant que l'instance existe, arrêtée ou non.
- **À 240 habitants** (le protocole niveau 1 habituel), le serveur n'apporte rien : le niveau 0 y prend 8 s, et le
  niveau 1 prend 2 min 45 sur le PC.

**c7i.4xlarge (16 vCPU = 8 cœurs physiques, 0,714 $/h), extrapolation non mesurée.** Au mieux, deux fois la
c7i.2xlarge : 16 parties à 1 778 ms par jour, 60 parties en 4 vagues (16, 16, 16, 12), soit **≈ 3 h et 2,12 $**.
Prudemment, chaque partie ralentit de 10 à 20 % : 8 cœurs actifs se partagent le cache L3 et la bande passante
mémoire, et la fréquence turbo baisse quand plus de cœurs travaillent. Cela donne **3 h 15 à 3 h 35, 2,3 à 2,5 $**.
Le prix double et le débit double au plus : **on gagne du temps, pas d'argent**. Elle ne vaut que pour faire tenir
deux protocoles dans une nuit. Avec 16 isolats dans un même processus, la contention du ramasse-miettes y serait
probablement plus forte : préférer des processus séparés.

**Piste non mesurée : c7a.2xlarge** (AMD EPYC, 8 vCPU = 8 cœurs physiques, sans hyperthreading ; 0,411 $/h). Si un
de ses cœurs joue une partie à la vitesse d'un cœur du PC (≈ 1 s par jour), 8 parties sans partage de cœur
donneraient environ 28 000 jours par heure : le protocole en ≈ 3 h 20 pour ≈ 1,4 $, plus vite et moins cher qu'ici.
C'est une hypothèse : à vérifier par `bash tool/mesure_debit.sh` (15 min, environ 0,10 $) avant tout changement
d'instance, une décision qui t'appartient.

## 5. Outillage

### 5.1 Plusieurs branches sur le serveur : un dossier par révision

Chaque LLM travaille sur sa branche, et deux branches peuvent avoir des moteurs différents. Au départ, le serveur
n'avait qu'un emplacement, `~/econodes`, remplacé à chaque envoi. Un envoi depuis une branche changeait donc en silence
le moteur que jouait le `stabilite.exe` suivant d'une autre branche. Depuis la branche `tests/serveur-revisions` :

- **Un dossier par révision** : `tool/envoyer_serveur.sh` installe le dernier commit dans
  `~/econodes/<12 premiers caractères de la révision>/`. Ce dossier contient le code, les exécutables, `.revision`
  (empreinte complète), `.branche` et `.envoi` (date). Un envoi ne touche jamais aux autres révisions. Une révision
  déjà installée n'est ni renvoyée ni recompilée (`--force` pour la réinstaller). L'installation se fait dans un
  dossier provisoire, mis en place d'un coup quand la compilation a réussi. L'ancienne disposition (un seul
  `~/econodes`) est rangée automatiquement dans le dossier de sa révision au premier envoi.
- **On joue la révision du dossier d'où l'on lance** : `bash ~/econodes/<révision>/tool/lot_serveur.sh …` et
  `mesure_debit.sh` jouent les exécutables de ce dossier (`lot_serveur.sh --revision R` en choisit une autre).
  `tool/parite_serveur.sh` (PC) compare la révision HEAD du PC à son dossier sur le serveur, et refuse si elle n'y est
  pas installée.
- **Un lot ne change jamais de révision** : son dossier, `~/resultats/<date>-<tâches>-<révision>/`, garde la révision,
  la branche et une copie figée de `partie.exe`. Reprendre ce lot avec une autre révision est refusé.
- **Un seul lot à la fois** : `lot_serveur.sh` et `mesure_debit.sh` refusent de partir si des parties tournent déjà
  (`--force` pour passer outre). Deux lots se partageraient les 8 vCPU, iraient chacun moins vite et fausseraient
  leurs durées. Les parties sont reconnues par leur exécutable (`/proc/<pid>/exe`), car Dart renomme ses processus
  (« dart:partie.exe ») et les coquilles qui les lancent ont le même chemin dans leur ligne de commande.
- **Journal des lancements** : `~/resultats/JOURNAL`, une ligne par événement (date, événement, révision, branche,
  détail) pour chaque envoi, parité (avec son verdict), début et fin de lot, mesure et suppression.
- **`tool/etat_serveur.sh`** (PC) : révisions installées (branche, date d'envoi, taille, parties lancées depuis
  chaque dossier, celle de HEAD marquée), parties et sessions tmux en cours, fin du journal. `--supprimer <révision>`
  retire un dossier, sauf si une partie en utilise les exécutables. Les lots n'en dépendent pas, puisqu'ils gardent
  leur copie. Une révision occupe 41 à 48 Mo.
- **Testé** sur le serveur :
  - rangement de l'ancienne disposition (`772e87459809`), installation de `19ae708722d0` à côté, second envoi sauté,
    réinstallation par `--force` ;
  - lot et mesure refusés pendant qu'une partie tourne, avec la liste des seules vraies parties ;
  - lot forcé (`--force`) joué, son dossier portant la révision et la branche ; reprise par une autre révision
    refusée ; `--revision` inconnue refusée ;
  - suppression refusée pour une révision en cours d'usage, acceptée pour une révision inutilisée ;
  - parité refaite en une commande sur le dossier de `19ae708722d0` (`main` à cette date) : **identique**.

Ce travail a aussi corrigé un défaut de `parite_serveur.sh`. Il envoyait au serveur la copie de
`parite_plateformes.sh` du PC, en CRLF dans tout dépôt extrait avec `core.autocrlf=true`, et bash la refusait sous
Linux. La copie part maintenant sans retours chariot.

### 5.2 Les scripts

- **`tool/lot_serveur.sh`** (sur le serveur) :
  `bash ~/econodes/<révision>/tool/lot_serveur.sh [-j 8] [--eteindre-a-la-fin] taches.txt`.
  - Une tâche par ligne : `graine niveau population jours [options de partie.exe]`. Le lot part dans une session tmux,
    qui survit à la fermeture du SSH.
  - Il joue N parties à la fois, 8 par défaut (le nombre de vCPU), et écrit un journal par partie dans
    `~/resultats/<date>-<nom du fichier de tâches>-<révision>/`. Chaque journal contient la commande, la sortie, le
    code de sortie, la durée et la mémoire. Le lot écrit aussi `resume.csv` et `vmstat.log`.
  - L'exécutable est copié dans le dossier du lot : ni un nouvel envoi du code ni la suppression de la révision ne
    changent le lot en cours ou sa reprise.
  - **Reprise** : relancer la même commande. Les parties finies (marque `.fini`) sont sautées ; une partie
    interrompue ou échouée est rejouée depuis le jour 1. Un verrou empêche deux lots de tourner sur le même dossier.
  - **`--eteindre-a-la-fin`** (désactivé par défaut) : `sudo shutdown -h +5` une fois toutes les parties jouées,
    annulable par `sudo shutdown -c`. Le script vérifie au départ que sudo n'exige pas de mot de passe ; c'est le cas.
  - **Testé** sur de petits lots :
    - 4 parties dont une volontairement fausse : 3 réussies, l'échec n'arrête pas les autres, résumé correct ;
    - relance : les 3 réussies sont sautées, la fausse est retentée ;
    - lot de 5 parties coupé au milieu (`tmux kill-session`, ce qui arrête aussi les parties en cours), puis relancé :
      les 2 parties finies sont sautées, les 3 autres jouées, 5 / 5 à la fin ;
    - `{dossier}` remplacé par le dossier propre à la partie, pour `--trace`.
  - **La colonne `niveau`** : `partie.exe` n'a pas de niveau. Pour une partie seule, un niveau du protocole ne fixe
    que la graine, la durée et la population, déjà données sur la ligne ; la colonne sert donc d'étiquette (nom des
    journaux). Les filets et les modules passent par les options (`--filets 0`, `--modules …`).
- **`tool/mesure_debit.sh`** (sur le serveur) : les paliers du § 3, à refaire tels quels sur une autre instance.
- **`tool/envoyer_serveur.sh`** (sur le PC) : installe la révision HEAD dans son dossier et la compile (§ 1, § 5.1).
- **`tool/parite_serveur.sh`** (sur le PC) : la parité du § 2 en une commande, environ 3 minutes ; s'appuie sur
  `tool/parite_plateformes.sh` et `tool/parite_comparer.dart`.
- **`tool/etat_serveur.sh`** (sur le PC) : ce qui est installé et ce qui tourne (§ 5.1).

Exemple, le protocole de stabilité à 10 000 habitants par `lot_serveur.sh`, sur la révision `19ae708722d0` :

```bash
for g in $(seq 1 30); do for f in 0 1; do echo "$g 1 10000 1500 --filets $f"; done; done > stabilite10k.txt
bash ~/econodes/19ae708722d0/tool/lot_serveur.sh -j 8 --eteindre-a-la-fin stabilite10k.txt
```

Le même protocole, avec le rapport habituel (pas de reprise possible : une coupure fait tout recommencer ; retirer
`; sudo shutdown -h +5` pour garder la machine allumée). Ce lancement direct ne passe ni par le refus « un seul lot à
la fois » ni par le journal : regarder d'abord `tool/etat_serveur.sh`, et garder la révision dans le nom des fichiers.

```bash
tmux new -d -s stab "R=19ae708722d0; ~/econodes/\$R/build/outils/stabilite.exe --population 10000 --graines 30 --days 1500 --phases base,nets --isolats 8 --save ~/resultats/stab10k-\$R.json --out ~/resultats/stab10k-\$R.md 2> ~/resultats/stab10k-\$R.log; sudo shutdown -h +5"
```

## 6. Problèmes rencontrés

1. **Fins de ligne.** Sur le PC, `core.autocrlf=true` (configuration système de Git) : `git archive` écrivait les
   fichiers en CRLF, et bash refusait `tool/compiler.sh` (`set: -: invalid option`). Correction : l'archive est faite
   avec `git -c core.autocrlf=false`, donc en LF, comme dans le dépôt. Sans effet sur le programme : il n'y a aucune
   chaîne multiligne dans `lib/engine/` ni `tool/`. La parité le confirme, alors que le PC compile depuis des
   fichiers en CRLF.
2. **Flutter dans `pubspec.yaml`.** `dart compile` lance d'abord une résolution des paquets, qui échoue sans le SDK
   Flutter (`flutter_test from sdk which doesn't exist`), puis ne trouve plus `package:econodes`. Ce n'est pas une
   erreur de compilation du code. Réglage : un `.dart_tool/package_config.json` limité au paquet `econodes`, avec la
   même `languageVersion` (3.4) que celui du PC. Dart affiche toujours l'échec de la résolution, puis compile ;
   `envoyer_serveur.sh` masque ce message. Une autre voie serait de donner au moteur et aux outils un paquet Dart pur,
   distinct de l'application Flutter : à décider par toi, rien n'a été changé.
3. **Sorties texte.** `print` écrit CRLF sous Windows, et `partie.exe` affiche le chemin absolu du dossier des
   instantanés. Les sorties texte diffèrent donc sans que les parties diffèrent ; le comparateur en tient compte.
4. **Mesure de mémoire.** Le RSS des paliers compte l'encodage de l'instantané du jour 100 (≈ 120 Mo de plus par
   partie). La mémoire d'une partie sans instantané vient de `perf.exe` et de `stabilite.exe`.
5. **Arrêt de l'instance pendant une vérification.** Le 18 octobre à 02 h 08 min 47 s UTC (22 h 08, heure du PC), le
   serveur s'est éteint proprement pendant la batterie de parité lancée par `tool/parite_serveur.sh`, alors dans sa
   phase à 10 000 habitants. Le journal système dit `systemd-logind: Power key pressed short`, puis `System is powering
   down` : c'est le signal qu'EC2 envoie quand l'instance est arrêtée de l'extérieur (console, API, ou pause par une
   limite de dépenses). Rien sur la machine ne l'a déclenché : ni commande `shutdown` ni `sudo` hormis l'installation,
   ni manque de mémoire, ni erreur du noyau. Le disque a tout gardé (Dart, code, résultats). L'instance a été relancée
   à 02 h 49 UTC. La vérification a ensuite été refaite en entier (§ 2) : identique. **Leçon pour les lots** : un arrêt
   imprévu fait tout recommencer à `stabilite.exe`, alors que `lot_serveur.sh` ne rejoue que les parties en cours.

## 7. Recommandation

- **8 parties en parallèle** sur la c7i.2xlarge : 16 198 jours de partie par heure à 10 000 habitants, 24 % de plus
  qu'à 4. Jamais 6.
- **Une nuit de 10 h** (3,57 $ de calcul, plus 0,05 $ d'IPv4) fait tenir :
  - avec `lot_serveur.sh`, **13 vagues de 8, soit 104 parties de 1 500 jours à 10 000 habitants** en estimation
    prudente (14 vagues, 112 parties, si les jours 100 à 1 500 coûtent 10 % de moins). C'est le protocole complet de
    60 parties (≈ 5 h 40) plus 44 parties, par exemple une variante sur 22 graines sans et avec filets ;
  - avec `stabilite.exe --isolats 8` (le rapport habituel), **80 parties**, donc le protocole complet (≈ 7 h, ≈ 2,5 $)
    avec 3 h de marge. Une comparaison appariée complète (`--compare A B`, 120 parties) ne tient pas en une nuit ;
    elle tient si on la limite à l'étape avec filets (60 parties).
- **Premier lot proposé, à valider** : le protocole de stabilité à 10 000 habitants (60 parties), par
  `stabilite.exe --isolats 8` dans tmux, suivi de l'arrêt de la machine. Environ 7 h et 2,5 $. Un arrêt de l'instance
  pendant ces 7 h ferait tout perdre (§ 6, point 5) : si une limite de dépenses ou un arrêt programmé peut tomber
  pendant la nuit, vérifier la marge avant de lancer. Avant chaque lot : `bash tool/etat_serveur.sh` (rien ne tourne ?),
  puis, si le moteur a changé, `bash tool/envoyer_serveur.sh` et `bash tool/parite_serveur.sh` (3 min).
- **Pistes** :
  - un outil de fusion des synthèses de `stabilite` (une graine par processus) : −13 % sur la durée du protocole et
    une reprise après coupure. Écrit depuis dans une autre session (`tool/fusion_syntheses.dart`, branche
    `claude/trusting-elbakyan-e28442`, commit `8a94490`), pas encore relu ni fusionné ;
  - une mesure de 15 minutes sur une c7a.2xlarge, qui pourrait diviser le coût d'un protocole par 1,4.
