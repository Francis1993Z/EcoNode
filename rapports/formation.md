# Formation par filières : diplômes de 2 et 4 ans

Demande de Francis le 14 novembre 2026 : « c'est trop facile de s'éduquer. l'éducation devrait prendre 2 an pour devenir
technicien et 4 an pour devenir professionnel. il faut des diplôme pour chaque secteur. un médecin ne peut pas devenir
ingénieur pétrolier. un comptable ne devient pas charpentier du jour au lendemain. »

Branche `feature/formation`, partie de `main` (61b3744). Règle : `MODELE.md` § 6.23. Interrupteur `Params.formation`,
coupé dans le moteur, actif dans l'interface (`SimController`, constructeur et `newGame`) et dans
`tool/emergence.dart:parametresInterface`. **Référence identique (32 éléments).**

## 1. Avant : à quel point c'était facile

Sonde `tool/formation.dart`, main 61b3744, réglages de l'interface, 10 graines × 2 000 jours
(`rapports/donnees/formation/avant/`). Médianes des 10 graines :

| | 240 | 1 000 | 2 500 |
|---|---|---|---|
| Montées de classe par habitant, 1re année | 0,72 | 0,74 | 0,76 |
| Cours suivis par habitant, 1re année | 42 | 43 | 43 |
| Jours pour monter de manœuvre à technicien | 332 | 324 | 328 |
| Jours pour monter de technicien à professionnel | 419 | 410 | 409 |
| Professionnels parmi les employés : au départ (jour 1), moyenne de la 4e année | 7 → 80 % | 7 → 80 % | 7 → 80 % |
| Changements de filière d'emploi par habitant et par an, 1re année | 1,32 | 1,79 | 2,09 |
| Employés hors de la filière de leur premier emploi (sur la partie) | 44 % | 45 % | 42 % |

Un cours coûtait 25 $ et la classe montait d'un cran tous les 50 cours, en travaillant à plein temps. En trois ans, quatre
employés sur cinq devenaient professionnels (7 % au départ), et n'importe qui passait d'une filière à l'autre à chaque embauche.

## 2. La règle

Les choix de modèle ont été posés à Francis (AskUserQuestion, 15 novembre) :

| Question | Réponse de Francis |
|---|---|
| Granularité des diplômes | 11 filières (recommandé) |
| Qui paie les études | « les étudiants empruntent de l'argent aux banque avec des prêt étudiant à intérêt réduit et reporté a la fin des études. l'état pait les cours à 50%, ce taux est une politique modifiable. les étudiants doivent travailler a temps partiel, ou non selon leur épargnes et pret. » |
| Étudier en gardant son emploi | Les deux, selon sa situation : les chômeurs à temps plein, les employés en cours du soir |
| Poste sans le diplôme de la filière | Seuls les postes de manœuvre restent ouverts (recommandé) |

Ce que fait le moteur (détail dans `MODELE.md` § 6.23, code dans `lib/engine/formation.dart`) :

- **Onze filières** (`fieldKeys`, `typeField`) : agriculture-pêche-forêt ; mines et pétrole ; procédés (chimie,
  métallurgie) ; électronique et informatique ; mécanique et fabrication ; alimentation ; accueil, tourisme et médias ;
  santé ; éducation ; gestion, finance et immobilier ; bâtiment.
- **Diplôme par filière et par niveau** : la qualification d'un citoyen dans une filière = son diplôme de la filière
  + son talent (la partie fractionnaire de sa qualification de départ). Elle remplace la qualification unique dans
  l'embauche, les promotions, la mobilité, le plafond de l'employeur, le rendement et l'entrepreneuriat. Sans le
  diplôme, seulement les postes de manœuvre.
- **Durées** : technicien 730 jours, professionnel 1 460 jours à temps plein ; un technicien de la même filière refait
  la différence (730). En cours du soir (employés), le double. Changer de filière, c'est refaire toute la formation.
- **Financement** : l'État paie 50 % des cours (`eduStateShare`, réglable dans l'onglet Formation) ; l'élève paie le
  reste. Un étudiant sans emploi ne touche ni assurance-emploi ni aide sociale : il vit de son épargne, puis d'un prêt
  étudiant (3 %, intérêts capitalisés, aucune échéance jusqu'à 180 jours après le diplôme). Sans épargne ni prêt, il
  cherche un emploi et continue en cours du soir.
- **Débouchés** : on s'inscrit seulement dans une filière où des postes qualifiés restent vacants faute de diplômés
  (vacants lissés sur 30 jours, moins les diplômés qui cherchent et les étudiants déjà inscrits), si le gain de salaire
  sur 10 ans couvre la durée et le coût des études.
- **Départ** : chaque technicien et professionnel reçoit le diplôme de son niveau dans la filière de son employeur ; un
  sans-emploi qualifié, dans une filière tirée au sort selon les pénuries et le nombre de diplômés ; un nouvel arrivant
  (god mode) de même. L'économie de départ est exactement celle du module coupé (mêmes équipes, test).

Deux corrections faites en cours de mesure (essais de 240 et 1 000 citoyens) :

- **effet de troupeau** : la pénurie n'était recalculée que le lendemain matin, et 42 % des citoyens s'inscrivaient en
  quelques jours à 240 citoyens ; chaque inscription réduit maintenant aussitôt la pénurie vue par les suivants, et les
  postes d'encadrement (pourvus par promotion) ne comptent plus comme débouchés ;
- **école publique** : son prix affiché est celui du plan de départ, figé ; une école dimensionnée pour peu d'élèves y
  paraissait à 542 $ le cours (la quote-part d'un élève aurait été de 27 000 $ par an). Le prix de référence est
  maintenant le coût d'un cours à pleine cadence (salaire moyen de l'école ÷ 12 cours par employé et par jour, ≈ 50 à
  70 $). L'école produisant selon la demande de la veille, un élève tolère 3 cours de retard : les jours d'études
  perdus passent de 3 800 à 265 en 1 500 jours (1 000 citoyens, graine 1).

## 3. Mesure

Sur le PC, 10 graines appariées × 3 000 jours, 240, 1 000 et 2 500 citoyens, réglages de l'interface, filets actifs,
tous les modules ; A = module coupé (`--param formation=0`), B = module actif. Les 60 parties sont allées au bout.
Données : `rapports/donnees/formation/sans3000/` et `avec3000/` ; synthèse :
`python tool/formation_synthese.py rapports/donnees/formation/sans3000 rapports/donnees/formation/avec3000`.

Médianes des 10 graines, et différence appariée B − A (médiane, nombre de graines où B est plus bas) :

| | 240 A | 240 B | B − A | 1 000 A | 1 000 B | B − A | 2 500 A | 2 500 B | B − A |
|---|---|---|---|---|---|---|---|---|---|
| Chômage, jours 1 001-3 000 | 8,2 % | 9,6 % | +1,2 pt (3/10) | 8,0 % | 4,6 % | −3,6 pt (10/10) | 7,2 % | 4,8 % | −2,7 pt (8/10) |
| Sans emploi, étudiants compris | 7,2 % | 10,7 % | +2,5 pt (3/10) | 6,9 % | 4,5 % | −2,7 pt (10/10) | 5,8 % | 4,1 % | −2,0 pt (8/10) |
| Années de crise (chômage annuel > 20 %) | 1 graine | 1 graine | | 3 graines | 0 | | 2 graines | 1 graine | |
| Salaire réel moyen | 173 | 175 | +2 (5/10) | 178 | 188 | +14 (0/10) | 184 | 190 | +1,5 (5/10) |
| Indice des prix final | 6,96 | 6,33 | −1,1 (6/10) | 4,50 | 3,37 | −0,8 (8/10) | 3,07 | 2,89 | −0,2 (7/10) |
| Étudiants (% de la population) | — | 4,8 % | | — | 1,8 % | | — | 1,0 % | |
| dont à temps plein | — | 1,8 % | | — | 0,7 % | | — | 0,3 % | |
| Diplômes décernés en 3 000 jours | — | 16 | | — | 23 | | — | 32,5 | |
| Durée moyenne des études (calendrier) | — | 1 473 j | | — | 1 636 j | | — | 1 606 j | |
| Reconversions (diplôme dans une nouvelle filière) | — | 4,5 | | — | 5 | | — | 6 | |
| Changements de filière d'emploi par habitant et par an | 0,75 | 0,67 | −0,08 (8/10) | 1,15 | 0,74 | −0,45 (10/10) | 1,12 | 0,90 | −0,25 (10/10) |
| Employés hors de la filière de leur premier emploi | 47 % | 35 % | −11 pt (10/10) | 47 % | 36 % | −11 pt (10/10) | 45 % | 34 % | −10 pt (10/10) |
| Employés diplômés qui travaillent hors de leur filière (postes de manœuvre) | — | 8,6 % | | — | 5,6 % | | — | 4,1 % | |
| Employés par classe en fin (manœuvre / technicien / professionnel) | 3 / 6 / 91 | 61 / 28 / 11 | | 2 / 6 / 91 | 67 / 25 / 8 | | 3 / 6 / 92 | 69 / 24 / 7 | |
| Prêts étudiants accordés ($ par habitant, sur la partie) | — | 5 232 | | — | 414 | | — | 236 | |
| Naissances d'entreprises | 19 | 17 | −2 (6/10) | 65,5 | 81 | +8 (1/10) | 98 | 79,5 | −23,5 (10/10) |
| Morts : faillite | 15 | 14,5 | +0,5 (5/10) | 46 | 67 | +22 (0/10) | 107,5 | 98,5 | −7,5 (8/10) |
| Morts : sans employé depuis 30 jours | 3,5 | 2,5 | 0 (4/10) | 12,5 | 12 | −1,5 (5/10) | 25 | 20 | −5,5 (7/10) |

Pénuries par filière (années 2 à 9, médianes) : la pénurie de diplômés (postes qualifiés vacants moins diplômés
disponibles et étudiants) est nulle dans les onze filières aux trois tailles. Les postes qualifiés vacants lissés
restent sous 1,3 par filière à 2 500 citoyens (le plus : accueil, 1,3 ; santé et éducation, 0,1). Les chômeurs dont le
dernier emploi était dans l'accueil passent de 82 à 42 à 2 500 citoyens, et dans les mines de 13 à 4.

Lecture :

- **Ce n'est plus facile.** Les montées de classe disparaissent presque (0,18 par habitant et par an sur la partie →
  0,002 à 0,007) : la structure des qualifications reste proche du départ (employés au jour 1 : 67-70 % de manœuvres,
  24-26 % de techniciens, 7 % de professionnels ; en fin : 61-69 / 24-28 / 7-11 %) au lieu de devenir 91 % de
  professionnels. Un diplôme prend en moyenne 4 à 4,5 ans
  de calendrier, presque toujours en cours du soir. On change moins souvent de filière d'emploi, et seulement pour des
  postes de manœuvre.
- **Pas de rigidité mesurée.** Aucune filière ne manque durablement de diplômés, les morts d'entreprises faute de
  personnel ne montent pas, et le chômage baisse à 1 000 et 2 500 citoyens (10 et 8 graines sur 10), avec moins de
  crises. Raison probable : sans la bascule de toute la population vers les goûts des professionnels (anomalie N17,
  § 6.8 : sorties → voyages, avec une bosse de chômage pendant la bascule), la demande reste celle pour laquelle
  l'économie de départ a été dimensionnée. Tout reste sous le seuil de 13 % que Francis juge acceptable.
- **À 240 citoyens**, le module ne fait pas mieux : chômage +1,2 point (non concluant, 3 graines sur 10 plus bas),
  4,8 % d'étudiants et des prêts étudiants plus lourds (5 200 $ par habitant : quelques chômeurs qualifiés vivent
  longtemps de leurs prêts). À cette taille, une entreprise a un ou deux postes qualifiés par filière : un départ ouvre
  une pénurie que seul un étudiant peut combler, en 4 ans.
- **Moins de créations d'entreprises à 2 500** (−23,5, 10 graines sur 10) : un fondateur doit trouver des chômeurs
  diplômés de la filière de son projet ; à 1 000, plus de naissances et plus de faillites.
- **Très peu de monde étudie** (1 à 2 % de la population, 0,3 à 0,7 % à temps plein ; aucun chômeur ne s'inscrit à
  temps plein à 1 000 et 2 500) : la règle n'inscrit que là où des postes qualifiés restent vacants, et le moteur n'a
  ni vieillissement ni retraite, donc presque aucun besoin de relève. Quand le cycle de vie arrivera (projet noté), les
  départs à la retraite créeront ces débouchés et les jeunes choisiront leur filière par la même règle.

## 4. Points à décider par Francis

- **Le volume d'études** : 1 % de la population à 2 500 citoyens, c'est peu (au Canada, environ 5 à 6 % de la population
  est aux études postsecondaires). Leviers possibles, non appliqués : inscrire aussi pour monter de classe sans pénurie
  (le gain de salaire seul), ou baisser le seuil de chômage avant une reconversion (`eduIdleDays`, 30 jours).
- **Fondateurs** : un fondateur prend le premier poste de l'organigramme de son entreprise, quelle que soit sa
  qualification (`_hire` sans rôle donné, déjà le cas sans le module). Le test du module l'exclut ; une correction
  changerait le moteur hors du module.
- **Temps partiel des étudiants** : un étudiant qui travaille occupe un emploi à plein temps et étudie à mi-temps (le
  travail reste compté par tête dans le moteur).
- **Statistiques** : les étudiants à temps plein sont hors de la population active (comme pour Statistique Canada) ;
  le tableau donne aussi la part sans emploi, étudiants compris.

## 5. Vérification

- `bash tool/compiler.sh` passe ; `bash tool/reference.sh --verifier` : RÉFÉRENCE : IDENTIQUE (32 éléments).
- `flutter test` : tous les tests passent, dont `test/formation_test.dart` (6 tests : coupé par défaut, diplômes de
  départ et même économie de départ, postes qualifiés tenus par des diplômés de la filière chaque jour avec
  `devChecks`, étudiants hors du marché du travail, reprise depuis un instantané avec études en cours et prêts en
  report, activation en cours de partie).
- Instantané : `Params` (12 champs, absents des anciens fichiers → valeurs par défaut), diplômes, talent et programme de
  chaque citoyen, report des prêts étudiants, postes vacants lissés par filière ; `applyParam` de `tool/stabilite.dart`
  connaît les 12 paramètres.
- Interface : onglet **Formation** (interrupteur, durées, part de l'État, cours du soir, taux du prêt, cours par année ;
  diplômés et étudiants par filière et par niveau, pénurie ; compteurs) et diplômes du citoyen dans l'inspecteur.
