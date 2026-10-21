# Renaissance des filières (`Params.revival`)

Branche `feature/renaissance-filieres`, partie de `main` après la fusion de `feature/douane` (2371f5a). Règle coupée par
défaut dans le moteur : `bash tool/reference.sh --verifier` dit IDENTIQUE (32 éléments), et la parité PC ↔ serveur
(`tool/parite_serveur.sh`) aussi. Documentation du modèle : MODELE.md § 6.22.

## 1. Diagnostic : pourquoi une filière éteinte ne renaît pas

Outil : `tool/filieres.dart --causes` (nouvelle option). Pour chaque bien, il compte les jours sans producteur actif, les
renaissances (passage de « aucun producteur actif » à « au moins un ») et, chaque jour sans producteur, la première
condition de la création automatique (`_entryExit`, `_found`) qui manque. 240 citoyens, 5 graines × 1 500 jours, filets
actifs.

| Situation | Jours-biens sans producteur, pour 100 jours | Biens importables qui renaissent |
|---|---|---|
| Fermée | 262 | la plupart, lentement (processeurs : 22 renaissances, ordinateurs : 1) |
| Ouverte (trade + tradeWaves + floatingFx + foreignDemand) | 1 177 | **aucun** (0 renaissance en 5 graines pour cuivre, or, plastique, acier, machines…) |

Trois blocages, du plus fort au plus faible :

1. **Frontières ouvertes, l'importation efface le signal.** La création automatique et le module entrepreneurship ne
   lisent qu'un signal : la demande non servie (`unmetEma`), notée quand un acheteur ne trouve aucune offre. L'import est
   une offre sans limite, donc rien n'est jamais « non servi ». Pour le plastique, 86 % des jours sans producteur sont
   « tout est importé » ; pour l'acier, 94 %. Le reste du temps, personne n'en achète plus du tout : les clients du bien
   se fournissent à l'étranger ou ont disparu.
2. **En économie fermée, la demande dérivée disparaît avec les transformateurs.** Une fonderie de puces sans or ne produit
   plus. Son plan de production tombe à zéro, elle n'achète plus d'or, puis elle ferme. Or, processeurs, conception de
   puces, bauxite : 60 à 90 % des jours sans producteur n'ont aucun signal.
3. **Viabilité d'une petite filière.** Quand le signal existe, une demande de moins d'un employé (or : 0,7 employé ;
   poisson : 0,2) échoue au test de viabilité. La création se fait à productivité réduite (« échelle minimale ») et doit
   payer un employé entier. Ordinateurs : capital insuffisant 30 à 60 % des jours.

Le module entrepreneurship partage le même signal, avec en plus ses propres conditions (ambition, risque, épargne) :
549 jours-biens pour 100 jours en économie fermée, 1 119 en économie ouverte.

## 2. Règle

Avec `Params.revival`, le signal d'entrée d'un bien **sans producteur actif** est le plus grand de trois mesures, en
unités par jour :

- la demande non servie lissée (comme avant) ;
- les importations lissées (`Sim.importEma`, α = 0,1, lues dans les flux venant de l'étranger) ;
- la demande dérivée (`Sim.derivedWant`) : ce que les équipes (employés et postes ouverts) des entreprises qui utilisent le
  bien comme intrant transformeraient par jour.

Le reste est inchangé : main-d'œuvre, viabilité aux prix du marché bornés au double du prix mondial (frontières ouvertes,
c'est le prix d'import : on ne relance que si produire ici coûte moins cher qu'importer), capital, délai de 60 jours entre
deux créations d'un même type, une création par jour. Le signal vaut pour la création automatique et pour le module
entrepreneurship. Aucun nouveau flux de hasard. L'instantané n'écrit `importEma` que si la règle est active.

Une variante, `revivalHours`, est coupée par défaut. Avec elle (et avec `partTime`), l'entreprise qui relance un bien
garde la productivité nominale de son type et travaille à temps partiel ; sa viabilité compte les heures nécessaires.
Elle visait le blocage 3. Mesurée, elle double les créations vouées à la faillite (§ 3.3) : je l'ai laissée coupée.

## 3. Mesure

Comparaisons appariées (`tool/stabilite.dart --compare`, même graine et même hasard), 240 citoyens, 1 500 jours, chauffe
de 100 jours, sans et avec filets. Jouées sur le serveur de calcul (révision 0db617dee1fd, 420 parties en 11 minutes ;
synthèses JSON dans `~/resultats/renaissance-0db617dee1fd`). « Ouverte » = trade + tradeWaves + floatingFx +
foreignDemand. Rapports complets dans `rapports/renaissance/`.

### 3.1 Économie ouverte, 30 graines (règle : `revival=1`)

| Indicateur | Sans filets : avant → après (différence médiane, IC 95 %) | Avec filets : avant → après |
|---|---|---|
| Chômage moyen | 17,9 % → 14,4 % (**−4,6 pt** [−6,0 ; −2,9], 21 graines mieux sur 30) | 19,4 % → 14,3 % (**−5,7 pt** [−8,4 ; −2,0], 23/30) |
| Chômage max | 52,3 % → 46,3 % (**−7,5 pt**) | 55,8 % → 39,6 % (**−12,7 pt**) |
| Graines au chômage moyen > 30 % | 1 → 2 | 3 → 0 |
| Pire graine (chômage moyen ; santé moyenne) | 65 % ; 0,18 → 33 % ; 0,65 | 64 % ; 0,18 → 28 % ; 0,58 |
| Santé moyenne | 0,85 → 0,87 (non concluant) | 0,84 → 0,87 (**+0,02** [+0,004 ; +0,03]) |
| Hôpital public : attente moyenne | 5,6 → 2,2 j (non concluant) | 7,3 → 3,3 j (**−3,3 j**) |
| Jours-alerte critiques | 336 → 221 (**−85**) | 436 → 166 (**−120**) |
| Types d'entreprise actifs en fin | 14 → 25 (30/30 mieux) | 15 → 25 (30/30 mieux) |
| Naissances / morts d'entreprises par an | 1,5 / 5,4 → 15,7 / 16,7 | 0,7 / 3,9 → 14,5 / 15,2 |

### 3.2 Économie fermée, 30 graines

| Indicateur | Sans filets | Avec filets |
|---|---|---|
| Chômage moyen | 8,6 % → 9,1 % (−0,6 pt [−1,7 ; +1,0], non concluant) | 8,4 % → 7,9 % (−1,3 pt [−2,5 ; +0,8], non concluant) |
| Chômage, pire graine | 19,7 % → 18,8 % | 28,8 % → 21,5 % |
| Sans-abri moyen | non concluant | **−0,2 pt** |
| Santé moyenne ; attente à l'hôpital | non concluant | **+0,0002** ; **−0,04 j** |
| Jours-alerte critiques | non concluant | **−21,5** |
| Trésor de l'État le plus bas | non concluant | **+14 454 $** |
| Naissances d'entreprises / an | 10,0 → 10,2 | 5,6 → 6,6 (**+1,0**) |

En économie fermée, la règle change peu de chose : la création automatique y relançait déjà la plupart des filières.
Elle ne dégrade rien de façon concluante, et donne de petits gains avec filets.

### 3.3 Variante `revivalHours` (temps partiel), 30 graines

- **Économie ouverte.** Chômage −4,2 pt sans filets (concluant) et −3,1 pt avec filets (non concluant) : moins bien que la
  règle seule. Environ 28 naissances et 28 morts d'entreprises par an au lieu de 15. Pire graine sans filets : 70 % de
  chômage.
- **Économie fermée.** Rien de concluant sur le chômage. Morts d'entreprises +4 par an. Sur 5 graines sans filets, le
  chômage monte de 3,5 pt (4 graines sur 5 moins bien).

Les entreprises relancées sont surtout des mines et leurs transformateurs. Avec ou sans la variante, elles vivent 50 à
100 jours. Leur prix (coût unitaire × marge, frais fixes compris) dépasse souvent le prix d'import, alors que le test de
viabilité ne compte que les salaires et les intrants : elles ne vendent presque rien et font faillite. La variante rend
ces relances plus faciles, donc plus nombreuses à échouer.

### 3.4 Demande requise : 5 graines

- Jours-biens sans producteur, pour 100 jours (`tool/filieres.dart --causes`, avant → après) :
  - fermée : 228 → 216 sans filets, 262 → 243 avec ;
  - ouverte : 1 189 → 528 sans filets, 1 177 → 549 avec ;
  - module entrepreneurship, avec filets : fermée 549 → 510, ouverte 1 119 → 781.
- Ouverte, avec filets :

  | Bien | Jours sans producteur, avant → après | Renaissances, avant → après |
  |---|---|---|
  | plastique | 80 % → 21 % | 0 → 30 |
  | machines | 61 % → 7 % | 0 → 9 |
  | bijoux | 25 % → 1 % | 0 → 3 |
  | bétail | 17 % → 2 % | 0 → 4 |

- Les processeurs, la conception de puces, le cuivre et les ordinateurs restent souvent éteints (54 à 84 %) : la
  relance échoue à la viabilité, faute de pouvoir battre le prix d'import.
- Comparaisons appariées sur 5 graines (`rapports/renaissance/compare5-*.md`). Ouverte : chômage −6,1 pt sans filets
  (5/5 graines mieux) et −5,4 pt avec filets (non concluant, 4/5 mieux). Fermée : rien de concluant.

## 4. Coûts et limites

- **Roulement.** Frontières ouvertes, environ 15 naissances et autant de morts d'entreprises par an, au lieu de 1 à 5 :
  beaucoup de relances échouent en 2 à 3 mois. Chaque échec coûte au fondateur son capital et met l'équipe au chômage.
  Le compteur « Alertes ouvertes (toutes) » double frontières ouvertes (+179 à +186 sur 30 graines, 30 graines sur 30) :
  surtout des alertes non critiques par entreprise ; les jours-alerte critiques, eux, baissent.
- **Test de viabilité optimiste.** Il ne compte ni les frais fixes (entretien, comptabilité, usure) ni le prix d'entrée
  réel face à l'import. La variante `revivalFullCost` (§ 5) ajoute les deux : elle retient peu de relances, car le
  vrai défaut est ailleurs (le signal de demande dérivée surestime les ventes).
- **Chaînes longues.** Ordinateurs → processeurs → or, cuivre, conception : la relance ne remonte une chaîne que si le
  maillon d'aval existe encore (demande dérivée). Une chaîne entièrement éteinte attend un signal des ménages pour son
  dernier maillon.
- Chocs (`--phases chocs`) et 1 000 habitants ou plus : non mesurés.

## 5. Variantes contre les relances vouées à l'échec

Branche `feature/renaissance-viabilite`, partie de `feature/renaissance-filieres` (85efdf2). Deux interrupteurs, coupés
par défaut, qui n'agissent qu'avec `revival` et seulement pour un bien sans producteur actif. Coupés :
`bash tool/reference.sh --verifier` dit IDENTIQUE (32 éléments).

### 5.1 Les deux variantes

- **`revivalFullCost` (coût complet), la piste demandée.** La viabilité d'une relance (`Sim._found`, et
  `_bestProject` du module entrepreneurship) compte aussi les frais fixes attendus (`Sim.entryFixedCost`) :
  - comptabilité, aux quantités de `_buyServices` (0,1 + 0,03 × équipe) ;
  - entretien des opérations de l'industrie lourde (0,06 × équipe) ;
  - intérêts du prêt de fondation (module entrepreneurship).
  Une entreprise neuve n'a pas de machines, donc ni entretien de machines ni usure. Frontières ouvertes, le prix de
  départ de chaque extrant importable (coût complet par unité × `markup`, travail compté comme le fera `unitCost`) ne
  doit pas dépasser son prix d'import. Refus : `viabilite` ou `prix_import` (`Sim.revivalCostRefusal`). Le gain espéré
  du fondateur (module entrepreneurship) déduit aussi les frais fixes.
- **`revivalPlannedDemand` (demande au plan), ajoutée après le diagnostic du § 5.2.** La demande dérivée
  (`Sim.derivedWant`) est comptée, pour chaque entreprise qui utilise le bien comme intrant, au plus à son plan de
  production (`_plannedBatches`, tiré de la demande de ses propres produits), et non plus à la seule capacité de son
  équipe.

### 5.2 Diagnostic : ce qui tue les relances

Relevé ad hoc (script jetable, non gardé dans le dépôt). 5 graines × 1 500 jours, frontières ouvertes, filets par
défaut, règle `revival` seule. Une relance est une création dont le bien n'avait pas de producteur actif la veille.

- **Le prix de départ n'est pas en cause.** Il est déjà sous le prix d'import (médiane 0,79 × l'import, maximum 1,05).
  Avec `revivalFullCost` : 172 relances au lieu de 174, 125 mortes au lieu de 126.
- **Les relances meurent de faillite** (trésorerie, 97 morts sur 126). Elles ont du stock, mais ne vendent rien 40 %
  des jours.
- **La demande dérivée fait la plupart des relances, et elle surestime les ventes.** 150 relances sur 174 viennent de ce
  signal. Sur leurs 60 premiers jours, elles vendent 11 % du signal (médiane) ; 114 meurent, à 106 jours (médiane). Les
  20 relances lancées par les importations vendent 78 % du signal et vivent 191 jours. La demande dérivée compte ce que
  les équipes d'aval *pourraient* transformer, pas ce qu'elles achèteront.
- Avec `revivalPlannedDemand` : 94 relances par la demande dérivée (23 % du signal vendu, 82 mortes) et 56 par les
  importations (51 %, 32 mortes). La surestimation baisse, sans disparaître.

### 5.3 Mesure : 30 graines, contre `revival=1` seul

Comparaisons appariées, 240 citoyens, 1 500 jours, chauffe de 100 jours. Jouées sur le PC (16 isolats, une minute
par configuration ; pas de serveur). Médianes ; différence médiane par graine et IC 95 % entre crochets ; « nc » : non
concluant. Rapports : `rapports/renaissance/compare30-{ouvert,ferme}-{coutcomplet,demande-plan,cout-et-plan}.md`
(contre la règle seule) et `compare30-*-sans-regle-vs-*.md` (contre l'économie sans règle).

**Frontières ouvertes, sans filets.**

| Indicateur | Règle seule | + coût complet | + demande au plan | + les deux |
|---|---|---|---|---|
| Chômage moyen | 14,4 % | 13,9 % (+1,1 pt, nc) | 15,1 % (+0,3 pt, nc) | 15,1 % (+1,7 pt, nc) |
| Chômage, contre l'économie sans règle | **−4,6 pt** [−6,0 ; −2,9] | **−2,6 pt** [−5,1 ; −1,2] | **−4,0 pt** [−5,4 ; −0,3] | **−3,3 pt** [−6,5 ; −0,3] |
| Naissances d'entreprises / an | 15,7 | 15,2 (−1,6, nc) | 9,6 (**−7,1** [−9,4 ; −4,9]) | 8,0 (**−7,8**) |
| Morts d'entreprises / an | 16,7 | 16,1 (−1,3, nc) | 10,8 (**−6,3** [−8,0 ; −4,6]) | 9,6 (**−6,6**) |
| Fermetures par faillite (partie) | 53 | 47 (nc) | 26,5 (**−24**) | 24 (**−27,5**) |
| Types d'entreprise actifs en fin | 25 | 25 (nc) | 23 (**−1,5** [−3 ; −1]) | 22,5 (nc) |

**Frontières ouvertes, avec filets.**

| Indicateur | Règle seule | + coût complet | + demande au plan | + les deux |
|---|---|---|---|---|
| Chômage moyen | 14,3 % | 15,5 % (+0,5 pt, nc) | 13,9 % (+0,4 pt, nc) | 14,9 % (+0,5 pt, nc) |
| Chômage, contre l'économie sans règle | **−5,7 pt** [−8,4 ; −2,0] | **−2,2 pt** [−5,3 ; −1,0] | **−4,4 pt** [−6,1 ; −2,4] | **−3,5 pt** [−7,5 ; −0,7] |
| Naissances d'entreprises / an | 14,5 | 12,9 (**−1,8** [−2,4 ; −0,4]) | 8,3 (**−6,4** [−7,4 ; −5,4]) | 7,4 (**−8,3**) |
| Morts d'entreprises / an | 15,2 | 14,0 (**−1,6** [−2,4 ; −0,1]) | 9,9 (**−5,6** [−6,8 ; −4,9]) | 8,6 (**−7,3**) |
| Fermetures par faillite (partie) | 43,5 | 39,5 (**−6,5**) | 23,5 (**−19**) | 20,5 (**−24**) |
| Types d'entreprise actifs en fin | 25 | 25 (nc) | 22 (**−3** [−3,5 ; −1,5]) | 23 (**−2** [−3 ; −1]) |

Avec la demande au plan, contre l'économie sans règle : jours-alerte critiques −133 et santé +0,02 avec filets
(concluants), comme la règle seule (−120 ; +0,02).

**Économie fermée.** Contre la règle seule, aucune variante ne change de façon concluante le chômage (+0,4 à +1,0 pt),
les naissances, les morts ni les types actifs en fin (28 à 29). Avec filets, les jours-alerte critiques montent de façon
concluante : +5 [+1 ; +10,5] avec le coût complet, +9,5 [+6,5 ; +24,5] avec la demande au plan, +19 [+6 ; +39] avec les
deux. Les petits gains de la règle en économie fermée (§ 3.2) se perdent : la demande dérivée y servait à relancer les
maillons amont, et la demande au plan l'éteint en grande partie.

**Filières** (`tool/filieres.dart --causes`, 5 graines, avec filets ; `rapports/renaissance/filieres-*-coutcomplet.txt`,
`filieres-*-demande-plan.txt`). Jours-biens sans producteur, pour 100 jours :

| | Règle seule | + coût complet | + demande au plan | + les deux |
|---|---|---|---|---|
| Ouverte | 549 | 570 | 706 | 780 |
| Fermée | 243 | 248 | 266 | 234 |

Avec le coût complet, frontières ouvertes, les deux nouveaux refus pèsent peu : 0 à 8 % des jours sans producteur
d'un bien (`frais_fixes`), 0 à 6 % (`prix_import`). Le refus ordinaire `viabilite` et l'absence de signal restent les
causes principales.

### 5.4 Bilan

- **Coût complet (piste demandée) : à garder coupé.** Il vise un défaut qui n'est pas celui qui tue les relances. Il ne
  retire que 1,6 à 1,8 naissance et autant de morts par an. Il perd une partie du gain de chômage : contre l'économie sans
  règle, −2,6 et −2,2 pt au lieu de −4,6 et −5,7 pt.
- **Demande au plan : réduit le roulement, frontières ouvertes.** Les naissances et les morts d'entreprises baissent de
  35 à 43 %, et les faillites de moitié. L'essentiel du gain de chômage reste (−4,0 et −4,4 pt contre −4,6 et −5,7 pt ;
  la différence avec la règle seule n'est pas concluante). Prix : 1,5 à 3 types actifs en moins en fin, et les petits gains en
  économie fermée disparaissent. Laissée coupée. La garder, et sous quelle forme (par exemple seulement frontières
  ouvertes), est une décision de modèle pour Francis.
- **Les deux ensemble** ne font pas mieux que la demande au plan seule.
- **Reste :** même au plan, une relance par la demande dérivée ne vend qu'environ un quart de son signal. Une
  prochaine étape pourrait compter la demande dérivée aux achats réels d'intrants de l'aval (lissés), comme `importEma`
  le fait pour l'import. Non essayée.

## 6. Reproduire

```
dart run tool/filieres.dart --graines 5 --filets 1 --causes --param trade=1,tradeWaves=1,floatingFx=1,foreignDemand=1,revival=1
dart run tool/stabilite.dart --graines 30 --days 1500 --param trade=1,tradeWaves=1,floatingFx=1,foreignDemand=1 --compare ref param:revival=1
```

Variantes du § 5 (chaque synthèse enregistrée, puis comparée) :

```
bash tool/compiler.sh
build/outils/stabilite.exe --graines 30 --days 1500 --phases base,nets --param trade=1,tradeWaves=1,floatingFx=1,foreignDemand=1,revival=1 --save g30-ouvert-regle.json
build/outils/stabilite.exe --graines 30 --days 1500 --phases base,nets --param trade=1,tradeWaves=1,floatingFx=1,foreignDemand=1,revival=1,revivalPlannedDemand=1 --save g30-ouvert-plan.json
build/outils/stabilite.exe --compare g30-ouvert-regle.json g30-ouvert-plan.json
build/outils/filieres.exe --graines 5 --filets 1 --causes --param trade=1,tradeWaves=1,floatingFx=1,foreignDemand=1,revival=1,revivalFullCost=1
```
