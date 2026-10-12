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

- `lib/engine/` : moteur sans dépendance à Flutter. `model.dart` (biens, recettes, désirs, paramètres, modules, filets),
  `sim.dart` (simulation, filets, invariants), `monitor.dart` (détecteurs d'anomalies).
- `lib/ui/` : contrôleur, disposition et dessin du graphe, inspecteurs, onglets Diagnostic, God mode, Économie, Modèle.
- `tool/stabilite.dart` : protocole de stabilité en ligne de commande.
- `tool/stabilite.dart --niveau 0|1|2` : protocole en trois niveaux (fumée, décision, échelle) ; `tool/perf.dart` :
  temps par jour et mémoire d'une partie ; `tool/echelle.dart` : ratios du jour 1 selon la population ;
  `bash tool/compiler.sh` : exécutables natifs des outils dans `build/outils/`.
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
- `test/extremes_test.dart` : cas extrêmes au résultat connu d'avance (zéro citoyen, une entreprise par secteur,
  salaires figés, monnaie × 100, aucun hasard) ; deux attendus non obtenus sont sautés, avec ce qui a été mesuré.

## État

`flutter analyze` ne signale rien et `flutter test` passe (42 tests, 2 sautés volontairement). Le hasard est en flux indépendants (nombres
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
