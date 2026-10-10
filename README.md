# ÉcoNodes

Bac à sable d'économie locale et de logistique : des citoyens avec des désirs et un portefeuille, des entreprises
reliées en chaînes d'approvisionnement (nodes) sur trois secteurs, une caisse qui prête, des prix qui s'ajustent,
et un « god mode » pour injecter de l'argent ou des matériaux et voir ce qui se passe.

Ce dépôt contient la version **Flutter (Android en mode paysage, et web)**. La version web autonome en JavaScript
(`version web/`) est restée au modèle v0 (10 entreprises, 80 citoyens).

## Le modèle (v2)

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
- **Protocole** sans interface : 5 graines × 1 500 jours sans puis avec filets, chocs standard, critères de sortie.
- Plan et journal des corrections : [`rapports/stabilisation.md`](rapports/stabilisation.md) ; état des lieux du
  10 octobre : [`rapports/etat-des-lieux.md`](rapports/etat-des-lieux.md).

```bash
dart run tool/stabilite.dart --out rapports/stabilite.md --save rapports/stabilite.json
```

```bash
dart run tool/stabilite.dart --compare rapports/stabilite-avant.json --out rapports/stabilite-apres.md
```

Options : `--seeds 1,2,3`, `--days 1500`, `--phases base,nets,chocs`, `--noyau` (modules économiques coupés,
institutions actives), `--modules credit=0,marketing=0`, `--sauf bailout` (série avec filets sauf celui-là),
`--key raffinerie`.

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
- `rapports/` : rapports du protocole et plan de stabilisation.
- `test/engine_test.dart` : déterminisme, invariants exacts à chaque jour, filets et détecteurs provoqués.

## État

`flutter analyze` ne signale rien et `flutter test` passe (11 tests). Tâches 1, 2, 3, 4, 5, 7 et 8 du plan de
stabilisation faites (coût de revient réel, intrants secondaires non bloquants, prix et salaires limités à 1,5 %/j,
consommation stock-flux, entrée et sortie d'entreprises, fonds de roulement, Caisse capitalisée et prudente). Avec
filets, la partie est jouable (chômage 3 à 5 %, faim ≤ 0,2 %), mais grâce aux renflouements. Sans filets, le modèle
complet ne s'effondre plus au démarrage (chômage moyen 9 %, contre 87 % à l'origine), mais la santé de la population
s'effondre et trois graines sur cinq s'effondrent en fin de partie : voir l'état des lieux du 10 octobre dans
[`rapports/etat-des-lieux.md`](rapports/etat-des-lieux.md). La version Android n'a pas encore été lancée sur un appareil.

## À faire

- Stabilisation, dans l'ordre de [`rapports/etat-des-lieux.md`](rapports/etat-des-lieux.md) : hôpital ; ferme ; puis
  les tâches 6, 9 et 10 du plan (détecteurs de santé, de pénurie de main-d'œuvre et de prix aberrants : faits).
- Ensuite, dans l'ordre : cohortes d'âge, services publics avec files d'attente, naissances et décès, logement détaillé.
- Sauvegarde locale de la partie.
