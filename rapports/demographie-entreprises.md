# Démographie des entreprises : mesure, repères réels et onglet « Entreprises »

2026-11-14, branche `feature/demographie-entreprises`, partie de `main` 4b7a132. Tout a tourné sur le PC de Francis
(consigne du 14 novembre : plus de tests sur le serveur).

**Demande de Francis** : « je cherche à avoir un taux de naissance et mort des entreprises plus réaliste ». Après la
mesure, il a précisé : « en vrai je ne sais pas si je veux que ça ressemble au Canada. J'aimerais juste avoir un
indicateur de naissance et mort d'entreprise dans la GUI, un panneau de statistique sur les entreprises. Je vais prendre
une décision ensuite. » Les infobulles comparent la simulation aux États-Unis, à la France et au Canada.

Ce qui est livré : un onglet « Entreprises » dans l'interface (§ 3) et deux sondes. **Le moteur ne change pas** : la
référence est identique. Les corrections A, B et C (§ 4) ne sont **pas codées**. Elles attendent la décision de Francis.

## 1. Mesure de l'existant

**Outils.**
- `tool/demographie.dart` (lecture seule) tient une fiche par entreprise privée : type, jour de naissance, jour de
  mort, cause (`Sim.closeCause` lue le jour de la fermeture), nombre de rachats et effectif maximal. Il donne aussi les
  comptes par année de 365 jours.
- `tool/demographie_synthese.py` calcule les taux, la survie, la mortalité par âge et les causes. Avec deux dossiers,
  il donne aussi les écarts par graine appariée.
- `tool/demographie_suivi.dart` suit, tous les 10 jours, la vie de chaque entreprise née pendant la partie : effectif,
  caisse, demande, ventes, prix face aux concurrents et propriétaire.

**Réglages.** Ceux de l'interface (`parametresInterface`, Produits actif, Bâtiments et Banques coupés, filets actifs),
12 graines × 3 650 jours (10 ans), à 240 et 2 500 citoyens. Le lot compte 24 parties, 12 à la fois, et a pris 6 min 30
sur le PC. Les données sont dans `rapports/donnees/demographie-entreprises/avant/` et la synthèse dans
`synthese-avant.txt`. Un an vaut 365 jours de simulation (un pas = un jour, MODELE.md § 2).

Les taux sont les naissances (ou les morts) de l'année rapportées au nombre moyen d'entreprises privées de l'année. La
première année (démarrage) est exclue.

| Indicateur | 240 citoyens | 2 500 citoyens |
|---|---|---|
| Entreprises privées (début → fin) | 29 → 42 | 290 → 129 |
| Naissances par an (années 2-5 ; 6-10) | 12,6 % ; 4,6 % | 4,2 % ; 4,5 % |
| Morts par an (années 2-5 ; 6-10) | 8,3 % ; 4,0 % | 15,2 % ; 9,5 % |
| Survie des nées à 1 / 3 / 5 ans | 70 / 62 / 56 % | 84 / 61 / 51 % |
| Mortalité des nées par âge (0-1, 1-2, 2-3, 3-5, 5 ans et plus) | 39, 7, 6, 5, 3 %/an | 17, 16, 14, 10, 4 %/an |
| Mortalité des entreprises du plan de départ (années 2 et suivantes) | 2,4 %/an | 12,9 %/an |
| Âge moyen des vivantes à la fin | 8,4 ans | 8,2 ans |
| Morts « trésorerie à sec » (cause `faillite`) | 93 % | 92 % |
| Rachats par an | 14 % | 14 % |
| Nées rachetées au moins une fois | 411 sur 466 (88 %) | 873 sur 1 032 (85 %) |
| Chômage (années 2 et suivantes) | 4,8 % | 6,0 % |

**Lecture.**
- **2 500 citoyens.** Le plan de départ met environ 10 entreprises par type. En 10 ans, presque toutes celles des
  secteurs homogènes meurent : mines, puces, pétrochimie, raffinerie, machinerie… Il ne reste qu'un producteur par
  secteur, donc un monopole, et personne n'y entre. Avec l'entrepreneuriat, un citoyen ne fonde que là où la demande
  n'est pas servie (ou, pour un bien différencié, là où la marge des variétés est attrayante). Les naissances (4 %)
  restent loin des morts (13 %), et le nombre d'entreprises baisse (constat N16 : de 197 à 130 actives en 5 000 jours).
  La survie des entreprises nées en cours de partie est proche du réel.
- **240 citoyens.** La moitié des nées meurent avant 6 mois, presque toujours sans avoir rien vendu.
  - Une nouvelle entreprise prend pour demande propre toute la demande non servie de sa catégorie, jusqu'à 29 postes
    voulus pour une équipe de 1 à 3 personnes. Elle achète des intrants à cette mesure et brûle son capital
    (10 jours de salaires) en 8 à 10 jours.
  - Une variété nouvelle n'est connue de personne au départ (module Produits) et ne trouve pas de clients.
  - Les entreprises du départ (une par type) ne meurent presque pas : 2,4 % par an. Après 5 ans, l'économie est figée,
    avec environ 4 % de naissances et 4 % de morts.
- **Aux deux tailles.**
  - Aucune fermeture volontaire : une entreprise ne ferme qu'après 30 jours sans employé, et presque toujours parce
    qu'elle ne pouvait plus payer.
  - Le filet de renflouement remet de l'argent dans toute entreprise qui a des clients, même en perte chronique.
  - Le fondateur a déjà mis son épargne dans l'entreprise. Le filet la fait donc racheter par un autre citoyen,
    souvent dès les premiers jours : 85 à 88 % des nées sont rachetées.

## 2. Repères réels

Tous les chiffres ont été vérifiés à la source le 14 novembre 2026. Les champs diffèrent d'un pays à l'autre : à
comparer en ordre de grandeur.

| | États-Unis | France | Canada |
|---|---|---|---|
| Naissances par an | 10,6 % (2023) | 15,8 % (2023) | 12,3 % (2023) |
| Morts par an | 9,4 % (2023) | 11,7 % (2022) | 11,9 % (2023) |
| Survie à 1 an | 80,9 % | 94,6 % | 83,1 % |
| Survie à 3 ans | 63,6 % | 81,3 % | — |
| Survie à 5 ans | 51,3 % | 69,0 % | ≈ 68 % |

**Sources.**
- **États-Unis.**
  - Naissances et morts : Census Bureau, *Business Dynamics Statistics* 2023 (fichier `bds2023.csv`), taux d'entrée et
    de sortie des établissements.
  - Survie : BLS, *Business Employment Dynamics*, table 7 « Survival of private sector establishments by opening year »,
    établissements ouverts d'avril 2019 à mars 2020.
- **France.**
  - Naissances et morts : Insee Première n° 2097 (avril 2026), « Les entreprises économiquement actives en 2023 », taux
    d'entrée 2023 et de sortie 2022. Les micro-entrepreneurs sont compris : ils forment un tiers des entreprises
    actives et survivent nettement moins longtemps.
  - Survie : Insee Première n° 2070 (septembre 2025), « Entreprises créées en 2018 : 69 % sont encore actives cinq ans
    après leur création », enquête Sine 2018, hors micro-entrepreneurs.
- **Canada.**
  - Naissances et morts : Statistique Canada, *Le Quotidien* du 12 février 2026, « Business and employment dynamics
    data, 2023 », secteur privé.
  - Survie à 1 an : *Le Quotidien* du 12 novembre 2025, « Indicateurs d'entrepreneuriat des entreprises canadiennes,
    2023 », entreprises employeuses créées en 2022. Statistique Canada donne aussi 68,0 % à 2 ans pour la cohorte 2021.
  - Survie à 5 ans : ISDE, *Principales statistiques relatives aux petites entreprises 2025*, données de Statistique
    Canada : 69,7 % pour les biens et 67,5 % pour les services, entreprises de 1 à 99 employés, cohortes 2001 à 2022.
  - Pas de chiffre à 3 ans trouvé à la source pour le Canada.

**Faits qualitatifs.**
- La mortalité baisse avec l'âge (BLS, cohorte 2019-2020 : 19 % la première année, puis 11, 12, 10 et 10 %).
- Les entrées et les sorties sont surtout le fait de petites entreprises (Statistique Canada : 84 % des créations et
  des disparitions ont de 1 à 4 employés).
- Une sortie n'est pas forcément une faillite. Pour Statistique Canada, c'est une entreprise qui cesse d'avoir des
  employés, quelle qu'en soit la raison : 88 040 disparitions d'entreprises employeuses en 2022.

**Écarts de la simulation.**
- Naissances trop rares (4 à 5 % contre 11 à 16 %), sauf à 240 citoyens dans les premières années.
- Morts dans la plage réelle à 2 500, mais par consolidation du plan de départ plutôt que par renouvellement.
- Survie à 5 ans comparable à celle des États-Unis (51 % à 56 %), mais avec une mortalité infantile trop concentrée
  dans les premiers mois à 240 citoyens.
- Pas de fermeture volontaire.
- Beaucoup trop de rachats.

## 3. Onglet « Entreprises » (`lib/ui/entreprises_tab.dart`)

**Fonctionnement.**
- L'interface tient son propre journal (`FirmLog`), relevé après chaque jour simulé comme celui du marché immobilier.
  Le moteur n'écrit rien de plus et ne change pas.
- À chaque relevé : une fiche par entreprise privée (naissance, mort, cause, rachats) et une valeur par jour
  (entreprises, actives, naissances, morts, rachats, taux sur l'année glissante).
- La cause d'une disparition est lue par `Sim.closeCause` sur l'objet de l'entreprise disparue.
- Un rachat est un changement de propriétaire.

**Contenu de l'onglet.**
- **Naissances et morts.** Taux annuels sur les 365 derniers jours (annualisés tant que la partie a moins d'un an),
  rachats par an, entreprises actives et leur variation sur un an. Deux courbes : les taux et le nombre d'entreprises.
- **Survie et âge.** Survie à 1, 3 et 5 ans des entreprises nées pendant la partie, âge moyen des vivantes, part des
  vivantes nées pendant la partie.
  - L'onglet estime la survie par Kaplan-Meier : toutes les cohortes servent, une entreprise vivante compte jusqu'à son
    âge d'aujourd'hui, et la survie ne peut que baisser avec l'âge.
  - Une première version prenait, pour chaque âge, les seules cohortes assez anciennes. Dans une partie de 5 ans à
    240 citoyens, elle donnait 47 % à 3 ans et 75 % à 5 ans, sur 4 entreprises.
  - « — » tant qu'aucune entreprise née n'a pu être suivie jusqu'à cet âge. Le nombre d'entreprises suivies est affiché
    entre parenthèses.
  - La sonde (§ 1) garde la méthode par cohortes, celle des statistiques officielles, sur 12 graines × 10 ans.
- **Causes de disparition.** Trésorerie à sec, ou fermeture faute d'activité (demande perdue, plus d'employé, prix
  aberrant), plus les rachats.
- **Concentration par secteur.** Producteurs actifs, part du premier dans les recettes lissées, indice HHI, nombre de
  secteurs en monopole.

**Infobulles.** Les lignes marquées ⓘ montrent côte à côte la valeur de la simulation et les repères du § 2, avec leur
source et leur année, ainsi que la définition retenue dans la simulation.

**Limites.**
- Le journal commence avec la partie et n'est pas sauvegardé.
- Une partie remise à zéro le vide.
- Les entreprises du plan de départ ne comptent pas dans la survie : elles n'ont pas de date de naissance réelle.

## 4. Corrections proposées (non codées, en attente de la décision de Francis)

Chacune irait derrière un interrupteur `Params`, coupé dans le moteur et activé dans l'interface.

- **A. Entrée concurrente (`marginEntry`).** Un citoyen pourrait aussi fonder dans un secteur homogène dont les
  producteurs en place font au moins 15 % de marge, sans attendre une demande non servie. Il viserait une part
  1/(n + 1) de la demande du secteur, au prix du moins cher en place. Effet attendu : plus de naissances, fin des
  monopoles du plan de départ à 2 500 citoyens.
- **B. Fermeture volontaire (`voluntaryExit`).** Le propriétaire cesse de renflouer une entreprise en perte depuis
  180 jours (bénéfice lissé négatif) et la ferme ; ce qui reste de la trésorerie lui revient.
  - Le filet ne ferait plus racheter que des entreprises rentables.
  - Il laisserait vivre une jeune entreprise sur son capital et son prêt pendant sa première année.
  - Effet attendu : des fermetures volontaires, des entreprises du départ mortelles à 240 citoyens, moins de rachats.
- **C. Démarrage à la taille de l'équipe (`startAtTeam`).** Une nouvelle entreprise viserait la production de son
  équipe de 1 à 3 personnes, et non toute la demande non servie de sa catégorie. Effet attendu : moins de morts dans
  les premiers mois à 240 citoyens.

Les seuils (15 %, 180 jours, un an) sont des propositions. Avant fusion, chaque correction serait mesurée avec les
mêmes outils (`tool/demographie.dart`, au moins 10 graines appariées, 240 et 2 500 citoyens), en regardant les taux, la
survie, le chômage et les prix.

## 5. Vérifications

- `bash tool/compiler.sh` passe.
- `bash tool/reference.sh --verifier` : « RÉFÉRENCE : IDENTIQUE (32 éléments) ».
- `flutter test` passe, avec le nouveau test `test/entreprises_test.dart`. Il vérifie que le journal suit exactement
  les entreprises privées du moteur, que naissances − morts = variation, qu'il y a une cause par mort et que la survie
  baisse avec l'âge.
- L'onglet a été vu dans le navigateur intégré (`flutter build web`, servi en local), sur une partie de 240 citoyens
  jouée jusqu'au jour 3 264 (graine 42). Captures dans `rapports/donnees/demographie-entreprises/` :
  - `onglet-entreprises-1.jpg` : taux et courbes ;
  - `onglet-entreprises-2.jpg` : survie, causes et concentration ;
  - `onglet-entreprises-infobulle.jpg` : infobulle de la survie à 5 ans.
  Dans cette partie : 2,7 % de naissances et 2,7 % de morts sur l'année glissante, survie de 61 %, 55 % et 51 % à 1, 3
  et 5 ans, 22 morts sur 23 par trésorerie à sec, 53 rachats, et 18 secteurs sur 24 avec un seul producteur actif.
- Les infobulles s'affichent au survol, de façon fiable quand la partie est en pause. Pendant la partie,
  l'interface se redessine environ 8 fois par seconde.

## 6. Reproduire

```bash
dart compile exe tool/demographie.dart -o build/outils/demographie.exe
build/outils/demographie.exe 1 2500 3650 --sortie avant/g1-p2500.txt   # graines 1 à 12, 240 et 2 500 citoyens
python tool/demographie_synthese.py avant [apres]                        # synthèse, écarts appariés avec un 2e dossier
dart run tool/demographie_suivi.dart 1 240 900                           # vie de chaque nouvelle entreprise
```
