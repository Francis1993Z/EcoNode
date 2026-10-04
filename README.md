# ÉcoNodes

Bac à sable d'économie locale et de logistique : des citoyens avec un portefeuille, des entreprises reliées
en chaîne d'approvisionnement (nodes), des prix qui s'ajustent, et un « god mode » pour injecter de l'argent
ou des matériaux et voir ce qui se passe.

Ce dépôt contient la version **Flutter / Android (mode paysage)**. Une version web existe aussi (même modèle).

## Le modèle

- **Biens** : primaires (viande, cuir, bois, minerai), transformés (planches, acier, boulons), finaux
  (repas, logement, souliers, loisirs).
- **Entreprises** (10 au départ) : ferme, bûcheron, mine, scierie, aciérie, boulonnerie, restaurant,
  cordonnerie, immobilier, divertissement. Chacune a une recette, des employés, un stock, un prix.
- **Ménages** : ils achètent toujours le moins cher d'abord (repas, logement, souliers, loisirs), cherchent un emploi,
  peuvent avoir faim ou perdre leur logis.
- **Prix** : coût de revient × marge, corrigé selon les stocks et la demande non servie.
- **Salaires** : relevés quand l'embauche est difficile, baissés très lentement sinon.
- **État** : impôt sur salaires et dividendes (12 %), prestation de chômage (80 $), redistribution du trésor.
- **Propriétaires** : renflouent ou rachètent leur entreprise en difficulté.
- **Commerce extérieur** (optionnel) : import/export aux prix mondiaux.
- **Monnaie** : toute la monnaie passe par une seule fonction de transfert. Masse attendue =
  masse de départ + god mode + exports − imports, vérifiée par le grand livre et par les tests.

## Utilisation

- Un doigt sur le vide : déplacer la vue. Pincement : zoom. Un doigt sur un node : le déplacer. Toucher : inspecter.
- Barre du haut : lecture/pause, un jour, vitesse, indicateurs, flux d'argent (pointillés), panneau latéral.
- Panneau : Inspecteur · God mode · Économie · Journal · Modèle.

## Lancer

```bash
flutter create . --platforms=android --project-name econodes   # génère android/ sans toucher à lib/
flutter pub get
flutter test    # parité avec le moteur JS (graine 42), conservation de la monnaie, grand livre du god mode
flutter run     # téléphone en débogage USB ou émulateur
```

## Structure

- `lib/engine/` : moteur sans dépendance à Flutter (`model.dart`, `sim.dart`), port fidèle du JS
  (même générateur mulberry32, même ordre d'appels, tri stable).
- `lib/ui/` : contrôleur (boucle de temps), graphe dessiné au canevas, panneaux, graphiques.
- `test/engine_test.dart` : tests du moteur.

## État

Le code Dart n'a **pas encore été compilé** (écrit sans SDK Flutter) : attendre d'éventuelles petites
erreurs au premier `flutter run`.

## À faire

- Sauvegarde locale de la partie.
- Construction de logements à partir de planches et de boulons.
