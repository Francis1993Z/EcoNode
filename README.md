# ÉcoNodes

Bac à sable d'économie locale et de logistique : des citoyens avec des désirs et un portefeuille, des entreprises
reliées en chaînes d'approvisionnement (nodes) sur trois secteurs, une caisse qui prête, des prix qui s'ajustent,
et un « god mode » pour injecter de l'argent ou des matériaux et voir ce qui se passe.

Ce dépôt contient la version **Flutter (Android en mode paysage, et web)**. La version web autonome en JavaScript
(`version web/`) est restée au modèle v0 (10 entreprises, 80 citoyens).

## Le modèle (v2)

Description complète, règle par règle, avec justifications et renvois au code : [`MODELE.md`](MODELE.md) (protocole
ODD). Ci-dessous, un résumé.

- **Trois secteurs** : primaire (ferme, pêche, pétrole, bois, fer, or, bauxite, cuivre, ressources illimitées),
  secondaire (boucherie, boulangerie, raffinerie, pétrochimie, fonderie, aluminerie, électronique, puces, ordinateurs,
  bijouterie, garage, machinerie), tertiaire (ingénierie pétrolière et de CPU, marketing, comptabilité, restaurant,
  télé, hôtel, tourisme, hôpital, école, immobilier, divertissement). 33 biens, 32 entreprises, 240 citoyens.
- **Citoyens** : désirs (faim, logement, santé, divertissement, luxe) dont la satisfaction s'use ; goûts selon la
  qualification (manœuvre, technicien, professionnel), qui monte avec la formation. Bonheur, maladies, ordinateur.
- **Entreprises** : recette, employés de la qualification exigée, stock, prix (coût de revient × marge, corrigé selon
  stocks et demande non servie). Elles achètent comptabilité, entretien, publicité et R-D, et s'endettent pour acheter
  des machines (rendements décroissants, usure).
- **Caisse populaire** : chaque prêt crée de la monnaie, chaque remboursement de capital en détruit ; intérêts ristournés.
- **État** : impôt sur salaires et dividendes, assurance-emploi, santé et éducation publiques, redistribution du trésor.
- **Monnaie** : comptée en multiples de 2⁻¹⁰ $. Les invariants comptables (masse, prêts, bilan de la Caisse, variation
  des dépôts expliquée) sont exacts et vérifiés chaque jour.

Chaque module ajouté depuis la v0 (crédit, machines, R-D, publicité, comptabilité, santé, formation, services publics)
se coupe : onglet Diagnostic → Modules.

## Rôles, contrats et négociation salariale (module `jobs`)

- **Organigrammes** : chaque type d'entreprise a 3 à 5 rôles (aide agricole, machiniste, agronome, responsable de la
  ferme ; préposé aux bénéficiaires, infirmier, médecin, médecin-chef ; etc.) avec une qualification minimale, une part
  de l'effectif et, pour l'encadrement, une ancienneté minimale (promotion interne seulement).
- **Contrats** : chaque employé a un rôle, un salaire négocié et une date d'embauche (ancienneté).
- **Négociation** : salaire de réserve du candidat (dernier salaire qui baisse avec le chômage, prestation), fourchette
  et plafond de l'employeur (postes vacants, valeur ajoutée), partage du surplus selon l'aplomb et la tension du marché ;
  refus possibles. Contre-offres quand un concurrent débauche, promotions, renouvellement annuel au taux du marché
  (ancienneté comprise).
- **Inspecteur** : la liste des employés d'une entreprise (rôle, qualification, salaire, ancienneté), l'organigramme
  (effectifs actuels et visés, salaire offert par rôle) et les négociations récentes ; fiche citoyen (contrat, salaire
  de réserve) ; marché du travail dans la vue Ménages.
- Coupé par défaut dans le moteur et le protocole ; l'interface lance ses parties avec le module (écran de départ).
  Description : [`MODELE.md`](MODELE.md) § 6.16 ; mesures et choix : [`rapports/emplois-negociation.md`](rapports/emplois-negociation.md).

## Stabilisation : filets, détecteurs, protocole

- **Filets de sécurité** (anti-famine, renflouement, plancher de logement, plafond de dérive des prix et salaires,
  anti-crédit-fou) : interrupteurs nommés, chaque déclenchement compté et journalisé. Ce sont des instruments
  de diagnostic : un compteur élevé signale une fuite dans le modèle.
- **Détecteurs d'anomalies** (chômage, faim, sans-abri, santé, productivité du travail, pénurie de main-d'œuvre,
  embauches bloquées faute de moyens, Gini, richesse médiane, inflation, prix aberrants, stocks, entreprises sans
  employé ou sans client, Caisse, invariant comptable) : alertes avec valeur, seuil, durée et agents impliqués.
- **Institutions** qui remplacent les filets, chacune derrière un interrupteur (Diagnostic → Modules) : test de
  solvabilité des dividendes (I1), hôpital et école publics avec enveloppe et file d'attente (I2), assurance-emploi
  indexée et aide sociale (I3), règles prudentielles de la Caisse (I4), faillite ordonnée (I5).
- **Protocole** sans interface : 30 graines × 1 500 jours sans puis avec filets, chocs standard, critères de sortie ;
  chaque partie dans son propre isolat. Chaque indicateur est donné par sa distribution sur les graines (médiane, écart
  interquartile, min–max, graines hors bande) ; les comparaisons sont appariées graine par graine, avec un intervalle
  de confiance bootstrap.
- Plan et journal des corrections : [`rapports/stabilisation.md`](rapports/stabilisation.md) ; état des lieux du
  10 octobre : [`rapports/etat-des-lieux.md`](rapports/etat-des-lieux.md).

```bash
dart run tool/stabilite.dart --out rapports/stabilite.md --save rapports/stabilite.json
```

Comparaison appariée (même graine, configuration A contre B ; A et B sont des synthèses enregistrées par `--save` ou
des configurations lancées sur place) :

```bash
dart run tool/stabilite.dart --compare institutions=0 ref --out rapports/comparaison.md
```

```bash
dart run tool/stabilite.dart --compare rapports/stat/complet-sans-institutions.json rapports/stat/complet-i1-i5.json
```

Options : `--graines 30`, `--seeds 1,2,3`, `--isolats 16`, `--days 1500`, `--warmup 100`, `--phases base,nets,chocs`,
`--noyau` (modules économiques coupés, institutions actives), `--modules credit=0,marketing=0`, `--sauf bailout`
(série avec filets sauf celui-là ; `--sauf chacun` : une série par filet), `--param nom=valeur`, `--key raffinerie`,
`--relire synthese.json` (refait un rapport sans relancer de partie).

Lot réparti sur des processus séparés (une graine et une étape par processus : plus rapide que les isolats d'un même
processus, et une coupure ne perd que les parties en cours) : chaque processus enregistre sa synthèse, puis
`tool/fusion_syntheses.dart` les fusionne en celle qu'aurait enregistrée un seul lancement sur toutes les graines
(mêmes valeurs, même ordre ; relisible par `--relire`, opérande de `--compare`). Un dossier vaut tous ses `.json` ; une
graine relancée à l'identique n'est comptée qu'une fois ; un lot incomplet est refusé, sauf avec `--partiel`.

```bash
dart run tool/stabilite.dart --population 10000 --seeds 7 --phases nets --isolats 1 --save lot/g07-nets.json --out lot/g07-nets.md
```

```bash
dart run tool/fusion_syntheses.dart --graines 30 --save rapports/stabilite-10000.json --out rapports/stabilite-10000.md lot
```

Options de la fusion : `--seeds 3,1,2` (ordre des graines du lancement unique), `--shock-seeds` (chocs sur d'autres
graines), `--secondes 7200 --isolats 8` (durée réelle du lot, pour la ligne « Temps total » du rapport), `--partiel`.

Une partie avec ses journaux complets (`evenements.jsonl`, `series.csv`, `agents_fin.csv`, `entreprises.csv`) et un
instantané tous les 500 jours, puis la reprise depuis un instantané, puis la comparaison de deux versions du moteur :

```bash
dart run tool/partie.dart --graine 7 --filets 0 --trace traces/g7 --snapshot-every 500
```

```bash
dart run tool/partie.dart --from-snapshot traces/g7/instantane-j00500.json --jours 1500
```

```bash
dart run tool/partie.dart --diff travail ../econodes-autre --graine 7 --jours 600
```

```bash
dart run tool/detresse.dart traces/g7/agents_fin.csv
```

## Utilisation

- Un doigt sur le vide : déplacer la vue. Pincement : zoom. Un doigt sur un node : le déplacer. Toucher : inspecter.
- Barre du haut : lecture/pause, un jour, vitesse, indicateurs, badge d'alertes (ouvre le Diagnostic), flux d'argent.
- Quatrième bouton en bas du graphe (réseau) : afficher les flux de services aux entreprises (pointillés fins).
- Panneau : Inspecteur · Diagnostic · God mode · Économie · Journal · Modèle.

## Lancer

```bash
flutter pub get
```

```bash
flutter test
```

```bash
flutter run
```

Version web Flutter :

```bash
flutter run -d chrome
```

```bash
flutter build web
```

## Structure

- `lib/engine/` : moteur sans dépendance à Flutter. `model.dart` (biens, recettes, désirs, rôles, paramètres, modules,
  filets), `sim.dart` (simulation, filets, invariants), `jobs.dart` (rôles, contrats, négociation), `buildings.dart`
  (bâtiments, hypothèques), `monitor.dart` (détecteurs d'anomalies).
- `lib/ui/` : contrôleur, disposition et dessin du graphe, inspecteurs, onglets Diagnostic, God mode, Économie, Modèle.
- `tool/stabilite.dart` : protocole de stabilité en ligne de commande.
- `tool/stabilite.dart --niveau 0|1|2` : protocole en trois niveaux (fumée, décision, échelle) ; `tool/perf.dart` :
  temps par jour et mémoire d'une partie ; `tool/echelle.dart` : ratios du jour 1 selon la population ;
  `bash tool/compiler.sh` : exécutables natifs des outils dans `build/outils/`.
- `bash tool/reference.sh --verifier` : rejoue la batterie de parité (3 minutes) et la compare à
  `rapports/reference/reference.txt` (empreintes de 9 000 jours, 21 instantanés complets, protocole niveau 0, 10 000
  habitants). À lancer après tout changement qui ne doit rien changer au moteur (optimisation, outil, interface), sur
  le PC et sur le serveur ; `--ecrire` n'est pour un changement de comportement voulu, avec son commit.
- `tool/fusion_syntheses.dart` : fusionne les synthèses `--save` de lancements séparés (une graine et une étape par
  processus) en celle d'un lancement unique.
- `tool/vendeurs_controle.dart A.json B.json` : comparaison appariée de deux synthèses (k = 0 contre k > 0) avec
  intervalles ; `tool/vendeurs_cout.dart` : coût d'un achat selon le nombre de vendeurs ; `tool/vendeurs_verif.dart` :
  liste des vendeurs disponibles vérifiée à grande échelle (rapport : `rapports/vendeurs-correction.md`).
- Calibration (rapport : `rapports/vitesse-calibration.md`) : `tool/sequentiel.dart` : comparaison appariée à arrêt
  séquentiel par lots de graines (le nombre de graines devient un résultat) ; `tool/convergence.dart` : deux tailles de
  population, mêmes indicateurs, avec intervalles ; `tool/criblage.dart morris|lhs` : criblage de Morris puis hypercube
  latin sur les paramètres de `tool/parametres.dart` (13 paramètres et leurs plages d'exploration) ; `tool/profil.dart` :
  profil CPU d'une partie ; `tool/comparer_moteurs.sh` : deux moteurs, mêmes parties, empreintes comparées.
- `tool/partie.dart` : une partie en ligne de commande, avec ses journaux complets, ses instantanés et `--diff` ;
  `--sans-hasard` joue une partie où tous les tirages valent 0,5, lisible à la main.
- `tool/detresse.dart` : ce qui distingue les citoyens en détresse des autres (à partir d'`agents_fin.csv`).
- `tool/parite.dart` : empreinte d'une partie, à comparer entre la VM et la version JavaScript.
- `rapports/` : rapports du protocole et plan de stabilisation.
- `test/engine_test.dart` : déterminisme, invariants exacts à chaque jour, filets, détecteurs et institutions provoqués.
- `test/hasard_test.dart` : flux de hasard (valeurs de référence VM / web, indépendance, ordre du jour stable).
- `test/protocole_test.dart` : statistiques du protocole (quantiles, bootstrap, appariement) et parties en isolat.
- `test/instantane_test.dart` : reprise exacte depuis un instantané, traceur sans effet sur la partie, empreintes.
- `test/proprietes_test.dart` : propriétés vérifiées chaque jour sur des parties tirées au hasard (dividendes et fonds
  propres, plafonds quotidiens des prix et salaires, emplois, plancher de la Caisse, admissibilité à l'assurance-emploi).
- `test/emplois_test.dart` : module rôles et négociation (contrats cohérents chaque jour, bornes de la négociation,
  renouvellements, salaire minimum, activation en cours de partie, instantanés).
- `test/inspecteur_test.dart` : l'inspecteur montre chaque employé (rôle, salaire, ancienneté), l'organigramme, les
  négociations et la fiche citoyen ; sans le module, le salaire unique et l'interrupteur.
- `test/extremes_test.dart` : cas extrêmes au résultat connu d'avance (zéro citoyen, une entreprise par secteur,
  salaires figés, monnaie × 100, aucun hasard) ; deux attendus non obtenus sont sautés, avec ce qui a été mesuré.

## État

`flutter analyze` ne signale rien et `flutter test` passe (71 tests réussis, 2 sautés volontairement). Le hasard est en flux indépendants (nombres
aléatoires communs) : une même graine donne la même partie sur la VM et en JavaScript (`tool/parite.dart`). Tâches 1, 2, 3, 4, 5, 7 et 8 du plan de
stabilisation faites (coût de revient réel, intrants secondaires non bloquants, prix et salaires limités à 1,5 %/j,
consommation stock-flux, entrée et sortie d'entreprises, fonds de roulement, Caisse capitalisée et prudente). Avec
filets, la partie est jouable (chômage médian 7 %, faim ≈ 0 %, sur 30 graines). Les institutions I1 à I5 sont en
place : sans filets, le modèle complet s'effondre dans 3 graines sur 30 au lieu de 18 (chômage médian 8 %, faim 6 %,
sans-abri 2,6 %) et les renflouements ont baissé de moitié ; restent la santé sans filets (l'hôpital manque d'intrants), la trésorerie bloquée dans les
entreprises et une aide sociale qui laisse des sans-logis. Voir l'état des lieux
([`rapports/etat-des-lieux.md`](rapports/etat-des-lieux.md)) et le bilan des institutions dans le journal de
[`rapports/stabilisation.md`](rapports/stabilisation.md). La version Android n'a pas encore été lancée sur un appareil.

## À faire

- Décisions en attente : importations de dépannage (A2), usure de la santé sans maladie (variantes de test A1 et A2
  mesurées : journal, tâche 4) ; jour assurable sans cotisation (I3) ; non-neutralité d'un choc monétaire ; suites des institutions
  (trésorerie bloquée par I1, aide sociale de I3, recapitalisation de la Caisse) ; institutions au-delà de I5 (douane,
  dette publique, migration).
- Stabilisation : la ferme (coproduit, A3), puis les tâches 6, 9 et 10 du plan.
- Ensuite, dans l'ordre : cohortes d'âge, services publics avec files d'attente, naissances et décès, logement détaillé.
- Sauvegarde locale de la partie.
