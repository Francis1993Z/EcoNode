# ÉcoNodes — description du modèle (protocole ODD)

Ce document décrit le modèle tel qu'il est codé (moteur v2, octobre 2026), selon le protocole ODD (Grimm et al. 2020,
« The ODD Protocol for Describing Agent-Based and Other Simulation Models: A Second Update », *JASSS* 23(2) 7). Il est
distinct du journal ([`rapports/stabilisation.md`](rapports/stabilisation.md)), qui raconte pourquoi et comment le
modèle a changé. C'est ce document qu'on donne à un nouveau lecteur, humain ou LLM, à la place d'un résumé refait.

Conventions :

- **Renvois** : `fichier:fonction` (par exemple `sim.dart:_laborMarket`). Les fichiers sont dans `lib/engine/`.
  `model.dart` contient les données et les paramètres, `sim.dart` le moteur, `monitor.dart` les détecteurs ;
  `buildings.dart`, `jobs.dart` et `entrepreneuriat.dart` sont les modules bâtiments, rôles et entrepreneuriat (parties de `sim.dart`).
- **Justification** : chaque règle en a une. La source est citée quand le code en donne une. Sinon, c'est écrit
  « choix de jeu » : une valeur raisonnable, ni calibrée ni tirée d'une source.
- **Paramètres** : leur nom de code et leur valeur par défaut sont donnés entre parenthèses, par exemple
  (`taxRate` = 0,12).
- **Mise à jour** : quand une règle change, ce document change dans le même commit.

---

## 1. Objectif et faits stylisés visés

### Objectif

ÉcoNodes est un bac à sable d'économie locale, jouable sur Android et sur le web. Il met en scène :

- 240 citoyens qui travaillent, consomment et épargnent ;
- 32 types d'entreprises reliées en chaînes d'approvisionnement sur trois secteurs ;
- une Caisse populaire qui crée la monnaie qu'elle prête ;
- un État qui prélève et redistribue.

Le joueur observe l'économie et intervient (« god mode ») pour en voir les effets. Le modèle doit donc être :

1. **Comptablement exact**, pour que toute anomalie soit une propriété du modèle et non une fuite d'argent ;
2. **Stable sans béquille** : l'économie tient sans les filets de sécurité, qui ne servent qu'au diagnostic ;
3. **Lisible** : chaque règle est simple, justifiée et journalisée ;
4. **Reproductible** : même graine, même partie, sur la VM (Android, ordinateur) comme en JavaScript (web).

### Faits stylisés visés

Ce sont les critères de sortie du protocole (`tool/stabilite.dart:exitCriteria`). Ce sont des cibles de plausibilité,
pas une calibration sur des données. Chacun est vérifié graine par graine, sur 30 graines × 1 500 jours, sans filets.

| Fait visé | Critère | Raison |
|---|---|---|
| Chômage modéré | moyenne ≤ 10 % | ordre de grandeur des économies développées ; décision de Francis du 10 octobre 2026 (journal) |
| Pas de détresse de masse | faim et sans-abri < 2 % en moyenne | une économie qui fonctionne nourrit et loge sa population |
| Inégalités plausibles | Gini de la richesse entre 0,2 et 0,45 | plage choisie pour le jeu (cahier des charges) |
| Prix stables | inflation moyenne < ±0,5 %/j | sans choc, les prix ne dérivent pas |
| Exactitude comptable | écart ≤ 1e-8 $ (en pratique 0) | monnaie en multiples de 2⁻¹⁰ $ (§ 6.1) |
| Pas de crise | aucune alerte critique (`monitor.dart:criticalAlerts`) | chômage > 30 %, faim, sans-abri, santé, inflation, invariant |
| Résilience | retour à l'équilibre en < 200 j après chacun des chocs standard | cahier des charges |
| Filets inutiles | < 1 déclenchement par 50 jours, chaque filet, chaque graine | un filet qui sert signale une fuite du modèle |

Mécanismes que le modèle doit faire apparaître, sans les imposer :

- **Monnaie endogène** : un prêt crée la monnaie, un remboursement la détruit (§ 6.10).
- **Prix au coût de revient majoré, ajustés par la rareté** (§ 6.4).
- **Consommation stock-flux à la Godley-Lavoie** (§ 6.6).
- **Entrée et sortie d'entreprises** guidées par la demande non servie (§ 6.12).

---

## 2. Entités, variables d'état et échelles

### Échelles

- **Temps :** discret. Un pas (`sim.dart:step`) vaut un jour. Le protocole joue 1 500 jours ; l'interface joue sans fin.
- **Espace :** aucun. Les positions des nodes (`Firm.x`, `Firm.y`, `Sim.nodePos`) ne servent qu'à l'affichage.
- **Monnaie :** dollars, en multiples de 2⁻¹⁰ $ (`sim.dart:quantize`).

### Biens (`model.dart:goods`)

| Champ | Contenu |
|---|---|
| `label`, `unit` | nom et unité |
| `sector` | primaire, secondaire ou tertiaire |
| `perish` | périssable ou service : l'invendu est perdu chaque soir (`sim.dart:_expire`) |
| `guess` | prix de départ de la résolution du plan initial (§ 5.2) |

On compte 33 biens :

- 9 primaires, à ressources illimitées ;
- 12 secondaires ;
- 12 tertiaires ;
- dont 13 achetés par les ménages (`householdGoods`), et 6 services et biens d'équipement achetés par les entreprises
  hors recette (`businessServices`).

Ce que chaque bien apporte aux désirs, et le goût de chaque classe pour lui, sont dans `model.dart:uses`.

### Types d'entreprises (`model.dart:templates`, classe `Template`)

| Champ | Contenu |
|---|---|
| `inputs`, `outputs` | recette fixe, par lot |
| `rate` | lots par employé et par jour, sans machines |
| `capacity` | plafond de lots par jour, éventuel |
| `skill` | qualification exigée : 0 manœuvre, 1 technicien, 2 professionnel |
| `capital` | gain maximal de productivité apporté par les machines (× 1 + `capital`) |
| `maint` | service d'entretien : réparations, ou ingénierie pour l'industrie « lourde » (`heavy`) |
| `rnd` | service acheté pour la R-D |
| `ads` | vend aux ménages, donc achète de la publicité |

Il y a 32 types. Le scénario par défaut (`model.dart:defaultScenario`) prévoit une entreprise de chaque type. Le
chantier forestier n'est pas créé : son plan de départ ne lui trouve aucune demande, car le bois n'a pas d'acheteur.

### Citoyen (`model.dart:Citizen`)

- **Identité et traits :** `id` stable, à partir de 1 ; `name`.
- **Qualification :** `skill`, de 0 à 3. La partie entière, plafonnée à 2, donne la classe (`level`).
- **Formation :** `ambition`, de 0 à 1, l'envie de se former.
- **Argent :** `money`.
- **Emploi :** `employer`, au plus un.
- **Désirs :** `sat`, une satisfaction de 0 à 1 pour chacun des 5 désirs (faim, logement, santé, divertissement,
  luxe). La santé est `sat['sante']`.
- **Détresse :** `hungerDays`, `homeless`, `homelessDays`.
- **Équipement :** `computerDays`, les jours d'usage restants de l'ordinateur.
- **Revenus :** `income` (du jour), `incomeEma` (lissé), `spend`, `happiness`.
- **Chômage et assurance-emploi :** `daysUnemployed`, `lastWage`, `insuredDays`, `eiDaysLeft`, `eiBenefit`.
- **Files des services publics :** `careSince`, `schoolSince`.
- **Emploi :** `hiredDay`, le jour d'embauche chez l'employeur actuel (l'ancienneté, tenue dans tous les cas ; négatif
  pour les employés du départ). Avec le module `jobs` (§ 6.16) : `role`, le rang du rôle dans l'organigramme de
  l'employeur ; `wage`, le salaire du contrat (gardé après une fin d'emploi : base du salaire de réserve) ; `aplomb`,
  de 0 à 1, un trait de négociation tiré à la naissance.

### Entreprise (`model.dart:Firm`)

- **Identité :** `id` stable, égal à 100 000 + 10 000 × rang du type + rang de création (`sim.dart:_newFirmId`) ;
  `type` ; `ownerId`, un citoyen, ou rien pour un établissement public.
- **Production :** `rate`, `capacity`, `prodMult` ; `workers`, `vacancies`, `unfilledDays`, `desired`.
- **Stocks et prix :** `inv`, `price` et `markup` par bien ; `demandEma`, `sold`, `produced`, `unmetShare`.
- **Comptes :** `money`, `revenue`, `costs`, `profitEma`, `retained` (bénéfices non répartis), `revenueEma`,
  `inputSpendEma`, `overheadEma`, `wagesPaid`, `dividends`.
- **Utilisation de l'équipe :** `outputEma`, `effWorkers`, `lastBatches`, `inputLimited`, `urgency` (part de la
  demande non servie).
- **Capital et technologie :** `machines`, `techLevel`, `rndProgress`, `maintCover`, `adminCover`, `brand`
  (notoriété).
- **Dette :** `debt`, `workingDebt`, `missedPayments`, `creditBanUntil`.
- **Cycle de vie :** `idleDays` (jours sans employé).
- **Verrous du god mode :** `lockPrice`, `lockWage`.
- **Salaires (module `jobs`, § 6.16) :** `offer`, le salaire affiché pour la qualification du gabarit ; `wage` est alors
  le salaire moyen des contrats de l'équipe ; `talks`, les dernières négociations (affichage).

### État (`model.dart:StateAccount`)

`money` (le trésor) ; impôts et versements (`taxes`, `paid`) ; dépenses de santé et d'éducation ; compte de
l'assurance-emploi (`eiPremiums`, `eiPaid`, `assistPaid`) ; `benefitCut`, la part des prestations versée aujourd'hui.

### Caisse populaire (`model.dart:BankAccount`)

`money`, l'encaisse. Bilan tenu par les flux : `reserves`, la monnaie « extérieure », et `equity`, les fonds propres ;
`capital`, les parts sociales de départ. Cumuls : prêté, remboursé, intérêts, intérêts capitalisés, radiations,
ristournes, refus. Identité de bilan : réserves + prêts = dépôts + fonds propres.

### Économie (`sim.dart:Sim`)

- **Paramètres et interrupteurs :** `params` (`Params`), `modules` (`Modules`), `safeguards` (`Safeguards`).
- **Marchés du jour :** flux, demande non servie (`unmet`, et `unmetEma` lissée), statistiques de marché, prix
  mondiaux (`worldPrice`, les prix du plan initial).
- **Indicateurs :** `needCost`, le coût quotidien de la survie ; `avgWage` ; `wage0` ; `cpiWeights`.
- **Registres :** `ledgerGod`, `ledgerImports`, `ledgerExports`, `ledgerCredit` ; `m0`, la monnaie de départ.
- **Services publics :** files d'attente des soins et des cours.
- **Contrôle :** historique quotidien (`history`), filets (`nets`), moniteur (`monitor`), invariants (`inv`).

### Interrupteurs

- **Modules** (`model.dart:Modules`), tous actifs par défaut :
  - modules économiques : crédit, machines, R-D, publicité, comptabilité, santé, éducation, santé publique,
    éducation publique, entrée et sortie d'entreprises ;
  - institutions I1 à I5 : test de solvabilité, enveloppe des services publics, assurance-emploi, règles prudentielles,
    faillite ordonnée.
- **Modules coupés par défaut :** bâtiments et hypothèques (`buildings`) ; rôles, contrats et négociation salariale
  (`jobs`, § 6.16), que l'interface active pour ses parties (`ui/controller.dart`) mais que le protocole et les tests
  laissent coupé sauf mention.
- **Filets** (`model.dart:Safeguards`), actifs par défaut dans le jeu : anti-famine, renflouement, plancher de logement,
  plafond de dérive, anti-crédit-fou. Ce sont des instruments de diagnostic : chaque déclenchement est compté et
  journalisé.
- **« Noyau »** (`Modules.noyau`) : les modules économiques sont coupés, les institutions restent actives.

---

## 3. Ordre exact des étapes d'une journée (`sim.dart:step`)

| # | Étape | Fonction | Condition |
|---|---|---|---|
| 0 | Jour + 1 ; remise à zéro des compteurs du jour (ventes, production, recettes, coûts, flux, demande non servie) ; `incomeEma` ← 0,9 × `incomeEma` + 0,1 × revenu de la veille ; module `jobs` activé ou coupé depuis la veille : contrats créés ou mis de côté | `step`, `_jobsSwitch` | toujours |
| 0 bis | Revenu de base du god mode (création monétaire) | `step`, `_godIn` | `ubi` > 0 |
| 1 | Marché du travail : embauches, mobilité, jours de chômage, prestations. Module `jobs` : salaire minimum, promotions, entrevues et négociation, contre-offres, renouvellements des contrats (§ 6.16) | `_laborMarket`, `_insurance`, `jobs.dart:_jobMarket` | toujours |
| 2 | Enveloppes des établissements publics | `_publicBudget` | I2 |
| 3 | Production | `_produce` | toujours |
| 4 | Paie : salaires, impôt, cotisations ; mise à pied si la paie est impossible. Module `jobs` : le salaire de chaque contrat | `_payWages`, `_payContracts` | toujours |
| 5 | Achats des entreprises (ordre `achats`) : intrants, puis services | `_buyInputs`, `_buyServices` | toujours |
| 6 | Ménages (ordre `consommation`) : usure des désirs, manger, se loger, santé, ordinateur, études, loisirs, bonheur ; puis files des services publics | `_consume`, `_serveQueues` | files : I2 |
| 7 | Filets anti-famine et plancher de logement | `_safetyNets` | filets actifs |
| 8 | Exportations | `_export` | `trade` |
| 9 | Péremption des biens périssables | `_expire` | toujours |
| 10 | Capital (ordre `capital`) : usure, service de la dette, investissement ; ristourne de la Caisse | `_capital`, `_invest` | toujours |
| 11 | Décisions des entreprises : prix, plan d'embauche, salaires (module `jobs` : le salaire affiché seulement), profits, dividendes ; flux lissés pour l'affichage | `_decide`, `jobs.dart:_adjustOffer` | toujours |
| 12 | Renflouement (filet) ; redistribution du surplus de l'État | `_finance` | renflouement : filet actif |
| 13 | `unmetEma` ← 0,9 × `unmetEma` + 0,1 × demande non servie du jour | `step` | toujours |
| 14 | Sorties puis entrées d'entreprises | `_entryExit` | module entrée |
| 15 | Enregistrement du jour (historique, indice des prix) | `_record` | toujours |
| 16 | Résumé des filets ; invariants comptables ; détecteurs | `_netSummary`, `_checkInvariants`, `monitor.dart:Monitor.check` | toujours |

**Justification de l'ordre :** on embauche avant de produire ; on produit avant de payer et de vendre ; les ménages
achètent après la paie ; les filets passent après la consommation, pour voir qui n'a pas pu manger ; les décisions se
prennent sur les ventes du jour ; on mesure en dernier. L'ordre des agents à l'intérieur d'une étape vient d'un flux de
hasard propre à l'étape (§ 4), sauf deux exceptions :

- au marché du travail, les entreprises sont rangées par salaire décroissant ;
- les entreprises sont parcourues dans l'ordre de leur liste (ordre de création) pour la production, la paie, les
  décisions et le renflouement. Cet ordre compte peu pour la production et la paie, où chacune ne touche que ses
  comptes et ceux de ses employés. Il compte pour les décisions : un fonds de roulement accordé à une entreprise réduit
  la marge prudentielle de la Caisse pour les suivantes.

---

## 4. Usage du hasard

### Principe

Chaque décision aléatoire a son **flux** (`sim.dart:Flux`). Un tirage ne dépend que de (graine, flux, jour, agent,
sous-tirage), jamais de l'ordre des appels (`sim.dart:draw`) :

- clé du jour = `hash32(hash32(graine, code du flux), jour)` (`sim.dart:_dayKey`) ;
- tirage = `Mulberry32(hash32(hash32(clé du jour, agent), sous-tirage)).next()`, uniforme dans [0, 1).

**Justification : nombres aléatoires communs** (Klein et al. 2024, arXiv 2409.02086). Deux parties qui ne diffèrent que
par une règle gardent les mêmes tirages partout ailleurs. Une comparaison appariée ne mesure donc que la règle. Chaque
flux a un code fixe : en ajouter un ne change pas les tirages des autres.

### Ordres du jour (`sim.dart:_ordered`)

Les agents sont rangés selon `orderKey` = `hash32(clé du jour, identifiant)`, avec l'identifiant pour départager.
Retirer un agent ne change pas l'ordre relatif des autres. Avant, un mélange de Fisher-Yates consommait un nombre
variable de tirages et décalait toute la suite de la partie.

### Les 19 flux

| Code | Flux | Usage | Fonction |
|---|---|---|---|
| 1 | `traits` | traits d'un citoyen à sa naissance : qualification, argent, ambition, ordinateur, nom, aplomb en négociation (sous-tirage 7) | `_newCitizen` |
| 2 | `classes` | répartition des qualifications au départ | `reset` |
| 3 | `recrutement` | ordre du premier recrutement | `reset` |
| 4 | `proprietaire` | propriétaire d'une entreprise | `reset`, `addFirm` |
| 5 | `embauche` | ordre des chômeurs sur le marché du travail | `_laborMarket` |
| 6 | `depart` | un employé part pour un meilleur salaire (probabilité `jobSwitch`) | `_laborMarket` |
| 7 | `maladie` | maladie (probabilité `illness`) et sa gravité | `_health` |
| 8 | `ordinateur` | envie d'acheter un ordinateur | `_computer` |
| 9 | `etudes` | envie de suivre un cours | `_study` |
| 10 | `loisirs` | s'offrir un loisir plus cher que le budget du jour | `_leisure` |
| 11 | `consommation` | ordre de passage des ménages | `_consume` |
| 12 | `achats` | ordre des entreprises pour leurs intrants et services | `_buyInputs` |
| 13 | `capital` | ordre des entreprises pour l'usure, la dette et l'investissement | `_capital` |
| 14 | `offres` | départage des offres à prix voisins : un tirage par (acheteur, bien, n-ième achat du jour, vendeur) | `buy` |
| 15 | `prix` | pas d'ajustement de la marge | `_decide` |
| 16 | `divin` | actions du god mode (épidémie) | `godEpidemic` |
| 17 | `logement` | bâtiments : état à la naissance, déménagement, regard sur le marché (module `buildings`) | `buildings.dart` |
| 18 | `vendeurs` | recherche limitée : tirage des vendeurs examinés par un achat de ménage dans la liste des vendeurs avec stock (`sellerSample` > 0) | `_AllOffers.sampled` |
| 19 | `anciennete` | ancienneté des employés du départ (0 à 4 ans ; l'encadrement, au moins celle qu'il exige) | `reset` |
| 20 | `entrepreneuriat` | un citoyen examine-t-il aujourd'hui la possibilité de fonder (module `entrepreneurship`, § 6.17) | `entrepreneuriat.dart:_entrepreneurship` |
| 21 | `qualite` | qualité d'une variété à son lancement ; gain et durabilité d'un modèle de machine (§ 6.18) | `produits.dart:_launchProduct` |
| 22 | `gouts` | goût personnel durable (citoyen, variété), tiré au jour 0 : rien à stocker | `produits.dart:tasteOf` |
| 23 | `connaissance` | découvertes du jour : vitrine et publicité, bouche-à-oreille, fabricants de machines | `produits.dart:_productsDay` |
| 24 | `noms` | générateur de noms de variétés, de marques et d'entreprises (tiré au jour 0) | `produits.dart:_uniqueName` |
| 25 | `credit` | achat important à crédit d'un citoyen (module `banking`, § 6.19) | `banques.dart:_citizenCredit` |
| 26 | `banques` | banque d'un nouveau client, comparaison de banques, projet de banque d'un citoyen | `banques.dart` |
| 27 | `commerce` | bruit quotidien du prix mondial de chaque bien (`Params.tradeWaves`, § 6.21) | `douane.dart` |

La création d'entreprise ne tire rien : le fondateur est le citoyen le plus riche.

### Parité VM / web

Les entiers sont manipulés en 32 bits, la multiplication découpée en moitiés de 16 bits (`sim.dart:Mulberry32._imul`,
`sim.dart:hash32`). Le multiplicateur technologique est un produit de multiplications successives, pas `math.pow`
(`sim.dart:techMult`). `tool/parite.dart` produit une empreinte qui doit être identique sur la VM et sous `node`.

### Drapeau de test `sansHasard` (jamais actif dans le jeu)

`Sim.sansHasard` fixe tous les tirages à 0,5, les ordres du jour aux identifiants, et les départages d'offres à 0,5. La
graine ne compte plus. Il sert aux cas extrêmes (`test/extremes_test.dart`) et à `tool/partie.dart --sans-hasard`.

---

## 5. Initialisation et paramètres

### 5.1 Initialisation (`sim.dart:reset`)

1. **Comptes publics.** Trésor de l'État = 250 $ × population (choix de jeu). Caisse : capital =
   `bankCapitalPerCitizen` × population, en parts sociales (justification § 5.3).
2. **Plan de départ** (`sim.dart:_plan`, § 5.2) : prix, effectifs, lots et machines par type, qui équilibrent l'offre et
   une demande estimée. Une entreprise dont le produit n'a aucune demande n'est pas créée. Le scénario par défaut (une
   entreprise de chaque type) est réglé pour `scenarioPopulation` = 240 habitants. Une population N le reçoit répété
   round(N ÷ 240) fois : mêmes équipes et même nombre d'entreprises par habitant à toutes les tailles. Sans cela, une
   partie de 13 240 habitants gardait 31 entreprises, avec des équipes de plus de 2 400 personnes (journal, § 6,
   tâche 1).
3. **Indice des prix.** Les poids (`cpiWeights`) sont la demande par citoyen du plan, pour les biens des ménages. Les
   modules coupés et les services publics gratuits en sont exclus.
4. **Qualifications.** Les besoins par classe découlent des effectifs du plan :
   - professionnels = ⌈1,15 × besoin⌉ + 1 ;
   - techniciens = ⌈1,1 × besoin⌉ + 1 ;
   - manœuvres : le reste.

   Les rangs sont attribués selon le flux `classes`. La marge de 10 à 15 % laisse des candidats aux postes qualifiés
   (choix de jeu). Avec le module `jobs`, le besoin d'une classe compte les postes de l'organigramme de chaque équipe
   qui l'exigent (méthode D'Hondt, § 6.16), pas la qualification du gabarit.
5. **Citoyens** (`sim.dart:_newCitizen`, flux `traits`, tirages t₁ à t₅) :
   - qualification = niveau + 0,9 t₁ ;
   - argent = `startWallet` × (0,6 + 0,8 t₂) × [1 ; 1,3 ; 1,8] selon le niveau ;
   - ambition = t₃ ;
   - ordinateur si t₄ < [0,2 ; 0,6 ; 0,7], pour ⌊t₅ × `computerLife`⌋ jours ;
   - un nom unique tiré des listes.

   Toutes ces valeurs sont des choix de jeu. Un immigrant du god mode a une qualification de 1,6 t₁ et l'argent donné.
6. **Entreprises** (`sim.dart:_newFirm`) :
   - salaire = `startWage` × [1 ; 1,4 ; 1,9] selon la qualification exigée (`classWage`, choix de jeu) ;
   - prix du plan ;
   - cadence réduite si la demande n'occupe pas un employé (`_minScale` = effectif prévu, borné à [0,001 ; 1]). Une très
     petite production est moins productive : c'est l'« échelle minimale ».
7. **Premier recrutement.** Les postes les plus qualifiés sont pourvus d'abord, chacun par le candidat admissible le
   moins surqualifié (`_pickWorker`), dans l'ordre du flux `recrutement`. On garde ainsi les plus qualifiés pour les
   postes qui les exigent. Avec le module `jobs`, ce sont les postes de l'organigramme de chaque équipe, les plus
   exigeants d'abord, chacun à l'offre de son rôle. Ancienneté de départ (flux `anciennete`) : de 0 à 4 ans, et pour
   un poste d'encadrement au moins l'ancienneté qu'il exige ; elle ne change aucun calcul sans le module.
8. **Stocks et comptes de départ :**
   - parc de l'immobilier = ⌈1,06 × population / nombre d'entreprises du type⌉ nuitées par jour (choix de jeu : 6 % de
     logements libres) ;
   - stocks d'extrants non périssables : `invTargetDays` jours ; intrants : 5 jours ;
   - machines = arrondi(machines par employé du plan × effectif) ;
   - trésorerie = max(6 000 $ ; 12 × (salaires + intrants) du jour) (choix de jeu) ;
   - propriétaire tiré au sort (flux `proprietaire`). Pas de propriétaire pour un établissement public, ni quand il n'y
     a aucun citoyen.
9. **Revenus et comptabilité.** Revenu lissé initial : salaire net, ou `benefit` pour un sans-emploi. m₀ = toute la
   monnaie. Réserves de la Caisse = m₀ et fonds propres = son encaisse. Premier enregistrement ; `wage0` = salaire
   moyen ; vérification des invariants.

### 5.2 Plan de départ (`sim.dart:_plan`)

- **Demande des ménages par citoyen.** Besoins de base (`_basicDemand`) + λ × demande discrétionnaire (`_extraDemand`).
- **Remontée des chaînes.** La demande remonte d'aval en amont : intrants des recettes, comptabilité (0,1 par entreprise
  + 0,03 par employé), entretien, usure des machines, publicité (`adsShare` des recettes), R-D (0,3 par entreprise).
  Les lots de chaque type couvrent la demande de ses extrants.
- **Prix.** Coût unitaire (salaire ÷ productivité, intrants, frais fixes) × `markup`, divisé par 1 − `adsShare` si le
  type fait de la publicité. Le prix est réparti entre les coproduits selon leur valeur ; 80 itérations.
- **Machines par employé.** Le point où une machine de plus ne rapporte plus 1,3 fois son coût (intérêts + usure +
  0,1 %). Même règle que l'investissement (§ 6.10).
- **λ.** Choisi par dichotomie pour que les effectifs fassent 94 % de la population. Si les besoins de base suffisent à
  occuper ce monde-là, l'échelle est réduite.
- **Seconde passe.** Avec la pénalité d'échelle minimale, machines figées. Sinon, des machines chères font disparaître
  la demande de machines, et la machinerie avec.

Justification : partir d'un état cohérent, où l'offre égale la demande estimée et où presque tout le monde travaille,
pour que la dynamique observée soit celle des règles et non un artefact de démarrage.

### 5.3 Paramètres (`model.dart:Params`)

| Paramètre | Défaut | Rôle | Source ou justification |
|---|---|---|---|
| `population` | 240 | citoyens au départ (`--population N` dans les outils) | choix de jeu |
| `scenarioPopulation` | 240 | population pour laquelle le scénario par défaut a été réglé ; au-delà, il est répété | taille de réglage du modèle (journal, § 6, tâche 1) |
| `sellerSample` | 5 | recherche limitée : un achat de ménage (une unité) n'examine que k vendeurs tirés dans la liste de ceux qui ont une unité en stock (plus celui de son dernier achat) ; 0 = tous | règle de marché, actif par défaut depuis le 18 octobre 2026 (journal, §§ 9 et 11) |
| `startWallet` | 3 000 $ | argent de départ de référence | choix de jeu |
| `startWage` | 150 $/j | salaire de base d'un manœuvre | choix de jeu |
| `markup` | 1,15 | majoration normale du coût | choix de jeu |
| `bufferDays` | 12 | coussin d'épargne, en jours de survie | choix de jeu |
| `mpcIncome` | 0,6 | propension à consommer le revenu discrétionnaire (α₁) | modèle SIM de Godley et Lavoie |
| `wealthTargetDays` | 20 | richesse visée T, en jours de revenu discrétionnaire ; α₂ = (1 − α₁)/T | calibration interne : reproduit la richesse de départ (2 750 $ ≈ 21 jours) |
| `trade`, `importMarkup`, `exportDiscount` | non, 1,3, 0,7 | commerce extérieur : import au prix mondial × 1,3, export × 0,7 | choix de jeu |
| `tradeWaves`, `tradeWaveAmp`, `tradeWavePeriod`, `tradeNoise`, `tariff` | non, 0,3, 365 j, 0,02, 0 | douane (§ 6.21) : prix mondiaux en vagues, droit sur les importations | choix de jeu |
| `floatingFx`, `fxSpeed` | non, 0,05 | douane (§ 6.21) : taux de change flottant et sa vitesse d'ajustement par jour | mesure § 6.21 |
| `foreignDemand`, `fdGrowth`, `fdMinMargin`, `fdStart`, `fdMaxCap` | non, 0,02, 0,05, 0,1, 1 | douane (§ 6.21) : commandes de l'étranger | mesure § 6.21 |
| `ubi` | 0 | revenu de base créé par le god mode | outil du joueur |
| `priceStep`, `wageStep` | 0,02, 0,015 | pas d'ajustement de la marge et du salaire | choix de jeu (tâche 3 du plan : lissage) |
| `priceMaxDaily`, `wageMaxDaily` | 1,5 %/j | variation quotidienne maximale décidée par l'entreprise | coûts d'étiquetage, contrats, réputation ; sous le plafond de 2 %/j du filet |
| `dividendRate` | 0,08 | part de la trésorerie au-delà de la réserve versée chaque jour | choix de jeu |
| `invTargetDays` | 4 | stock visé, en jours de demande | choix de jeu |
| `jobSwitch` | 0,03 | chance quotidienne de chercher un meilleur emploi | choix de jeu |
| `taxRate` | 0,12 | impôt sur salaires et dividendes | choix de jeu |
| `benefit` | 80 $/j | prestation forfaitaire (sans I3) ; unité des seuils de l'État | choix de jeu |
| `minWage` | 0 | salaire minimum | outil du joueur |
| `stateRebate` | 0,05 | part du surplus de l'État redistribuée chaque jour | choix de jeu |
| `interestRate` | 6 %/an | taux de base de la Caisse | choix de jeu |
| `loanTermDays` | 365 | durée de référence du remboursement | choix de jeu |
| `workingCapitalDays` | 15 | plafond du fonds de roulement, en jours de chiffre d'affaires | mesuré : à 30, la Caisse devenait insolvable dans 4 graines sur 5 |
| `exitIdleDays` | 30 | sans employé pendant 30 jours : fermeture | choix de jeu (tâche 5 du plan) |
| `entryCooldown` | 60 | jours entre deux créations d'un même type | choix de jeu |
| `entryMinShare` | 0,1 | demande non servie minimale pour une création, en part de la production d'un employé | choix de jeu |
| `entryMarginRatio` | 1,4 | une concurrente naît si les prix dépassent 1,4 × le coût | choix de jeu |
| `depreciation` | 0,003/j | usure des machines entretenues | choix de jeu |
| `maintNeed` | 0,05 | heures d'entretien par machine et par jour | choix de jeu |
| `softInputShare` | 0,15 | sous cette part du coût d'un lot, un intrant manquant ralentit au lieu de bloquer | mesuré : 5 % ne concernait presque aucun intrant ; 15 % couvre ingrédients et fournitures |
| `rndShare` | 0,02 | part de la trésorerie excédentaire consacrée à la R-D | choix de jeu |
| `bankRebate` | 0,05 | part du surplus de la Caisse ristournée chaque jour | choix de jeu |
| `bankCapitalPerCitizen` | 100 $ | capital de départ de la Caisse | couvre 11,5 % d'un encours de 870 $ par citoyen, bien au-delà des pointes observées |
| `bankTargetRatio` | 0,15 | fonds propres visés avant toute ristourne | grandes banques canadiennes (13,6 % observé), au-dessus du plancher de 11,5 % |
| `riskSpread` | 6 %/an | prime de risque à pleine garantie | choix de jeu |
| `adsShare`, `adsEffect` | 0,03, 0,6 | budget publicitaire ; hausse maximale de la dépense des ménages | choix de jeu |
| `illness` | 0,004/j | chance de tomber malade | choix de jeu |
| `eduRate`, `learnRate` | 0,25, 0,02 | chance de suivre un cours (× ambition) ; qualification gagnée par cours | choix de jeu |
| `computerLife` | 365 j | durée d'un ordinateur | choix de jeu |
| `dividendFromRetained` | non | I1 : plafond = bénéfice lissé (non) ou bénéfices non répartis (oui) | lecture de la LCSA, art. 42 b ; variante mesurée au journal |
| `publicCashDays` | 10 | I2 : trésorerie visée d'un établissement public, en jours de coût | règle d'embauche (8 jours) + 2 jours de marge |
| `eiReplacement` | 0,55 | I3 : prestation = 55 % de la rémunération assurable | régime canadien de 2025 (canada.ca) |
| `eiInsurableCap` | 1,0 | I3 : rémunération assurable plafonnée au salaire moyen | maximum 2025 (65 700 $/an, ≈ la rémunération hebdomadaire moyenne, Statistique Canada) |
| `eiRate` | 0,0394 | I3 : cotisation (employé 1,64 % + employeur 2,296 %) | taux 2025 ; part de l'employeur supportée par le salaire (incidence usuelle) |
| `eiDaysLow`, `eiDaysHigh` | 252, 315 | I3 : 36 semaines (chômage ≤ 6 %) à 45 semaines (≥ 16 %) | Loi sur l'assurance-emploi, annexe I, emploi à plein temps |
| `eiQualifyingDays` | 84 | I3 : jours d'emploi assurable pour être admissible | minimum de 420 heures = 12 semaines à 35 h |
| `healthWearIfDeprived` | non | variante de test A1 (§ 6.15) | jamais active par défaut |
| `partTime` | **oui** (depuis le 2026-10-21) | travail divisible (§ 6.15, A2) | décision de Francis : sans lui, les petites filières meurent à 240 citoyens et l'hôpital, sans plastique, ne soigne plus (A1) ; `--param partTime=0` rejoue l'ancien comportement |
| `reservationDecay`, `reservationFloor` | 0,01/j, 0 | module `jobs` : le salaire demandé par un chômeur baisse de 1 % de son dernier salaire par jour, jusqu'à la prestation | Krueger et Mueller 2016 (le salaire de réserve baisse avec la durée du chômage, beaucoup plus lentement) ; plancher à 0 mesuré (§ 6.16) |
| `switchPremium` | 0,08 | `jobs` : hausse exigée pour changer d'emploi, plus 1 % par année d'ancienneté (au plus 10 %) | règle de mobilité sans le module (8 %) |
| `bargainBase`, `bargainTrait`, `bargainTight` | 0,1, 0,3, 0,3 | `jobs` : pouvoir de négociation β = base + trait × aplomb + tension × θ/(1+θ), borné à [0,05 ; 0,7] | Pissarides 2000 (partage du surplus) ; valeurs : choix de jeu |
| `hireRange` | 0,10 | `jobs` : fourchette salariale ± 10 % autour de l'offre du rôle | choix de jeu ; mesuré (§ 6.16) |
| `hireFlexBase`, `hireFlexMax` | 0,05, 0,25 | `jobs` : souplesse du plafond de l'employeur, selon les postes vacants et la demande non servie | choix de jeu |
| `maxInterviews` | 3 | `jobs` : candidats reçus par poste et par jour | choix de jeu |
| `reviewDays`, `reviewCutMax` | 90 j, 1 | `jobs` : renouvellement du contrat tous les 90 jours depuis l'embauche ; baisse permise jusqu'au taux du marché | contrats échelonnés (Taylor 1980) ; 90 jours : choix de jeu mesuré (§ 6.16) ; `reviewCutMax` = 0 : rigidité à la baisse (Bewley 1999) |
| `seniorityStep`, `seniorityCap` | 1,5 %/an, 15 % | `jobs` : majoration d'ancienneté au renouvellement | choix de jeu |
| `promotionRaise` | 0,05 | `jobs` : hausse minimale d'une promotion | choix de jeu |

Seuils des filets (`model.dart:Safeguards`) :

| Seuil | Valeur | Justification |
|---|---|---|
| `famineDays`, `shelterDays` | 3 | choix de jeu |
| `maxDailyChange` | 2 %/j | choix de jeu |
| `maxPaymentRatio` | 0,35 (paiements de la dette ÷ valeur ajoutée) | choix de jeu |
| `minCapitalRatio` | 0,115 | ratio de fonds propres (CET1) attendu des grandes banques |

Les seuils des détecteurs sont dans `monitor.dart:MonitorConfig`, chacun avec sa raison.

Constantes de règles codées hors de `Params` : 8 jours de salaire en caisse par employé pour embaucher
(`Sim.hireCashDays`) et 3 postes au plus par jour (`Sim.maxPostsPerDay`). Les autres constantes sont citées avec leur
règle au § 6.

---

## 6. Sous-modèles

### 6.1 Monnaie et comptabilité

- **Transfert unique** (`sim.dart:transfer`). Tout mouvement d'argent passe par lui. Le montant est quantifié au
  2⁻¹⁰ $ inférieur (`quantize`) et un découvert lève une erreur. Justification : avec des multiples de 2⁻¹⁰ $, additions
  et soustractions sont exactes en virgule flottante, et les invariants tiennent au bit près.
- **D'où vient la monnaie.** La masse ne change que par le god mode, le commerce extérieur et le crédit : un prêt crée
  la monnaie, un remboursement de capital la détruit.
- **Quatre invariants** (`sim.dart:_checkInvariants`, chaque jour ; en mode développement, un écart lève une exception) :
  1. masse = m₀ + god mode + exportations − importations + crédit net ;
  2. dette en cours = prêté + intérêts capitalisés − remboursé − radié ;
  3. réserves + prêts = dépôts + fonds propres ;
  4. variation des dépôts = flux du jour (`DayFlows.explained`).

### 6.2 Marché des biens (`sim.dart:buy`, `quote`, `bestPrice`)

- **Offres.** L'acheteur trie les offres en stock par prix × (1 + 0,03 r) × attrait :
  - r départage les prix voisins (flux `offres`) ;
  - pour les ménages, l'attrait vaut 1 / (1 + 0,3 × notoriété / (notoriété + 20)) (`brandPull`) : ils préfèrent un peu
    les marques connues.

  Il achète au moins cher d'abord, dans la limite de son budget. Avec le commerce, l'extérieur offre sans limite les
  biens non périssables au prix mondial × `importMarkup`.
- **Recherche limitée des vendeurs (`sellerSample` = k, 5 par défaut).** Un achat de ménage ne compare pas tous les
  vendeurs du bien : il examine le vendeur de son dernier achat (habitude) et au plus k vendeurs tirés au hasard dans la
  liste de ceux qui ont une unité en stock (flux `vendeurs`), et prend le meilleur de cet échantillon. **C'est une règle
  de marché** (information imparfaite des ménages sur les prix), **pas une optimisation neutre** : à grande échelle elle
  change l'économie. À 13 240 citoyens, k = 5 évite l'effondrement de la comparaison complète (k = 0 : faim 51 %, chômage
  62 % ; k = 5 : faim 0,2 %, chômage 24 %, jours 100 à 1 000). Les résultats croissent avec k jusqu'à rejoindre ceux de k = 0 quand k couvre
  tous les vendeurs (k ≈ 20) ; avec un échantillon plus grand que tous les vendeurs, le chemin redonne exactement k = 0.
  À 240 et 1 000 citoyens (jamais plus de k + 1 vendeurs d'un même bien), k = 5 donne la partie de k = 0. Les achats non
  entiers d'un ménage (réparations du module Bâtiments) gardent la recherche complète. **Cette valeur sera à réexaminer
  avec les variétés de produits** : plus de vendeurs par bien ferait jouer k autrement. Mesures et limites :
  `rapports/vendeurs-correction.md`, journal § 9.
- **Demande non servie.** La quantité qui n'a pas trouvé de vendeur, faute de stock et non faute d'argent, est notée
  `unmet`. C'est le signal d'embauche, de prix et d'entrée.
- **Prix de référence** (`bestPrice`) : la meilleure offre disponible, sinon le plus bas prix affiché, sinon le prix
  mondial.

### 6.3 Production (`sim.dart:_produce`, `perWorker`, `efficiency`, `_plannedBatches`)

- **Cadence par employé :**

  `perWorker` = `rate` × `prodMult` × machines × technologie × entretien × comptabilité, avec :
  - machines : 1 + a·k/(k + 1), où k = machines par employé et a = `capital`, à rendements décroissants
    (`machineMult`) ;
  - technologie : ×1,15 par niveau (`techMult`) ;
  - industrie lourde : 0,5 + 0,5 × couverture de l'entretien (`uptime`) ;
  - comptabilité : 0,88 + 0,12 × couverture comptable (`adminMult`).

  Choix de jeu : chaque service a un effet visible et borné.
- **Efficacité d'un employé** (`efficiencyFactors`) : produit de quatre facteurs, et d'un bonus.
  - faim : 0,85 après 1 jour, 0,5 dès 2 jours ;
  - sans-abri : 0,8 ;
  - santé : 0,4 + 0,6 × santé ;
  - moral : 0,85 + 0,15 × min(1 ; divertissement + 0,5 × luxe) ;
  - bonus de 5 % par niveau au-dessus du poste, au plus 3.

  Choix de jeu.
- **Intrants.**
  - Un intrant qui pèse au moins `softInputShare` du coût d'un lot est **strict** : recette de Leontief.
  - En dessous, il est **secondaire** : son manque réduit la cadence en proportion de son poids. Une pêcherie sans
    carburant pêche moins, elle ne ferme pas.
  - Le poids se mesure au prix du jour. Deux autres essais ont été moins bons, voir le journal : aux prix de référence,
    et avec une liste explicite par recette.
- **Plan de production.** On produit la demande prévue, pas toute la capacité :
  - périssable : 1,05 × demande lissée ;
  - sinon : demande + (`invTargetDays` × demande − stock)/10.
- **Limite par les intrants.** `inputLimited` est vrai quand les intrants limitent la production.

### 6.4 Coût de revient et prix (`sim.dart:unitCost`, `_decide`)

- **Coût d'un lot :**
  - salaire ÷ (cadence × utilisation), où utilisation = production lissée ÷ capacité de l'équipe, bornée à [0,05 ; 1] ;
  - intrants au prix de référence ;
  - frais fixes : services lissés, intérêts, usure des machines. Ils sont répartis sur la production prévue, au moins
    5 % de la capacité.

  Le coût est réparti entre coproduits selon les prix mondiaux. Justification : un employé ne se divise pas. Si l'équipe
  est sous-employée, ses salaires se répartissent sur ce qu'elle produit vraiment (tâche 1 du plan : coût honnête).
- **Signal de rareté** (`dir`) :
  - périssable : hausse si des clients sont refusés et plus de 97 % de la production est vendue ; baisse sous 85 %
    vendus ;
  - non périssable : hausse si le stock tombe sous 2 jours de demande et que l'entreprise a de quoi vendre ; baisse
    au-delà de 8 jours.
- **Marge** (choix de jeu) :
  - pas = `priceStep` × (0,5 + tirage `prix`) ;
  - en hausse, le pas est multiplié par une pression de 1 + 2 × min(1 ; refusés ÷ vendus) ;
  - sans signal, la marge revient de 3 % vers la normale : c'est la concurrence ;
  - marge bornée à [−40 % ; +300 %].
- **Prix :**
  - le prix se rapproche de 25 % par jour de coût × (1 + marge) ;
  - il est borné à ±`priceMaxDaily` de la veille ;
  - **anti-emballement** : tant que le prix est bridé dans un sens, la marge cesse d'aller dans ce sens. Sinon, elle
    continuerait de monter pendant une pénurie et ferait grimper les prix des semaines durant ;
  - plancher : 0,01 $.

  Pas de mise à jour pour une entreprise sans employé, un prix verrouillé ou un service public gratuit.
- **Indice des prix** (`sim.dart:_record`) :
  - panier de départ (poids `cpiWeights`) aux prix moyens payés ce jour ;
  - sans transaction, le dernier prix observé est repris, comme le font les instituts statistiques ;
  - rapporté au coût du panier aux prix du plan.

### 6.5 Travail : embauche, mobilité, salaires (`sim.dart:_laborMarket`, `_decide`, `_payWages`)

- **Embauche.**
  - Les entreprises qui ont des postes ouverts embauchent par salaire décroissant.
  - Chaque poste va au chômeur admissible le moins surqualifié, dans l'ordre du flux `embauche`.
  - `unfilledDays` compte les jours de postes non pourvus.
- **Mobilité.**
  - Chaque employé a une chance `jobSwitch` par jour de regarder les postes ouverts (flux `depart`).
  - Il part si le meilleur salaire auquel il a droit dépasse le sien de plus de 8 % (choix de jeu).
- **Plan d'embauche** (`_decide`) :
  - effectif voulu = ⌈lots prévus ÷ (cadence × efficacité moyenne, au moins 0,3) − 0,2⌉ ;
  - pas d'embauche si les intrants manquent ;
  - si la trésorerie est sous 2 jours de salaires, le dernier embauché est mis à pied ;
  - sinon on ouvre au plus 3 postes par jour, et seulement si la caisse couvre 8 jours de salaire pour chaque employé,
    nouveaux compris. Si elle ne suffit pas, l'entreprise peut demander un fonds de roulement (§ 6.10) ;
  - au-delà de l'effectif voulu plus 1, licenciement d'au plus 8 % de l'équipe par jour.

  Justification : ne pas embaucher ce qu'on ne peut pas payer, ajuster l'équipe sans à-coups.
- **Salaires** :
  - postes vacants depuis 2 jours : hausse de `wageStep` × (1 + 3 × part de demande non servie) par jour ;
  - aucun poste vacant et chômage > 8 % : baisse de 0,1 × `wageStep` ;
  - convergence de 1 % par jour vers la norme du marché pour la qualification (moyenne pondérée par les effectifs) ;
  - bornes : ±`wageMaxDaily` par jour, plancher max(1 $ ; `minWage`). Le salaire minimum est une loi : le plafond de
    dérive ne s'y applique pas.

  Choix de jeu.
- **Paie :**
  - salaire brut ; l'impôt (`taxRate`) et la cotisation d'assurance-emploi sont prélevés ;
  - si la caisse ne suffit pas, tous sont payés au prorata et le dernier embauché est mis à pied.

Avec le module `jobs`, l'embauche, la mobilité, les salaires et la paie suivent le § 6.16 ; le plan d'embauche, les
mises à pied et toutes les règles comptées en jours de salaires restent celles-ci, avec pour salaire le salaire moyen
des contrats.

### 6.6 Ménages : consommation et désirs (`sim.dart:_consume`, `_choose`, `leisureBudget`, `_leisure`)

1. **Usure.** Chaque désir sauf la santé perd `desireDecay` par jour : faim et logement 1 (à refaire chaque jour),
   divertissement 0,12, luxe 0,03 (choix de jeu).
2. **Manger.** Jusqu'à 5 achats, tant que la faim n'est pas comblée. Le citoyen prend l'aliment qui apporte le plus de
   satisfaction par dollar, selon le goût de sa classe et la notoriété du bien. Si son favori manque, la demande non
   servie est notée. Il a faim (`hungerDays`) si sa satisfaction de faim reste sous 0,5.
3. **Se loger.** Une nuitée par jour ; sans nuitée, il est sans logis.
4. **Santé, ordinateur, études** : §§ 6.7 à 6.9.
5. **Loisirs.**
   - **Budget du jour, à la Godley-Lavoie :** C = α₁ × max(0 ; revenu lissé − coût de survie) + α₂ × `adsBoost` ×
     max(0 ; argent − coussin), avec α₁ = `mpcIncome`, α₂ = (1 − α₁)/`wealthTargetDays` et coussin = `bufferDays` ×
     coût de survie. Chaque ménage converge vers T jours de revenu discrétionnaire : personne n'accumule sans fin.
   - **Publicité.** Elle accélère la dépense de l'épargne, pas du revenu ; dépenser plus que le revenu viderait les
     ménages puis ferait monter les prix.
   - **Partage.** Le budget est partagé entre divertissement et luxe selon le poids de la classe × (0,25 + manque).
   - **Choix des biens.** Bien par bien, celui qui apporte le plus par dollar. Le n-ième achat du même bien a un attrait
     divisé par 1 + (n / normale)² (lassitude, `dailyNorm`).
   - **Achat occasionnel.** Si rien n'est abordable, le favori est acheté avec une probabilité budget ÷ prix (flux
     `loisirs`) : en moyenne, le budget.
6. **Bonheur.** Moyenne des satisfactions pondérée selon la classe (`happinessWeight`, choix de jeu).

**Coût de survie** (`_needCost`) : le point de faim le moins cher + une nuitée.

### 6.7 Santé (`sim.dart:_health`, `_serveQueues`)

- **Usure et maladies.**
  - La santé s'use de 0,003 par jour.
  - Un tirage `maladie` inférieur à `illness` retire 0,2 + 0,3 × tirage.
  - La santé est bornée à [0,05 ; 1].
- **Soins publics (I2).** Sous 0,75, le citoyen s'inscrit dans la file de l'hôpital public. La file est servie par ordre
  d'arrivée avec la production du jour : jusqu'à 3 visites de +0,3, jusqu'à 0,95. Ce qui reste à servir est noté comme
  demande non servie.
- **Soins sans I2.** Sous 0,75, il achète jusqu'à 3 visites, payées par l'État si la santé publique est active et que
  le trésor dépasse son plancher.
- **Module coupé.** Santé 1.

Justification : choix de jeu ; la file d'attente rend visible une capacité insuffisante. L'anomalie A1 (effondrement de
la santé quand l'hôpital ne tient pas) a une variante de test (§ 6.15).

### 6.8 Éducation (`sim.dart:_study`, `_serveQueues`)

- **Envie.** Un citoyen de qualification < 3 veut un cours si le tirage `etudes` < ambition × `eduRate`.
- **Accès.**
  - Cours publics (I2) : inscription dans la file de l'école.
  - Sinon, l'État paie si l'éducation publique est active et que le trésor dépasse son plancher.
  - Sinon, le citoyen paie, s'il lui reste 10 cours au-delà de son coussin.
- **Effet.** Chaque cours ajoute `learnRate` à la qualification : la classe monte tous les 50 cours.

Choix de jeu.

### 6.9 Ordinateurs (`sim.dart:_computer`)

- **Usage.** Un ordinateur dure `computerLife` jours et ajoute 0,08 de divertissement par jour.
- **Achat.** Sans ordinateur, l'envie se tire chaque jour (flux `ordinateur`) avec une probabilité
  [1 % ; 5 % ; 4 %] selon la classe, multipliée par la hausse de dépense due à la publicité. L'achat se fait s'il reste
  2 prix au-delà du coussin.

Choix de jeu : c'est le débouché de la filière informatique.

### 6.10 Capital, crédit et Caisse (`sim.dart:_capital`, `_invest`, `_workingCapital`, `_creditOk`, `_lend`, `loanRate`)

- **Usure.** `depreciation` par jour, multipliée par 1 + 1,5 × (1 − couverture de l'entretien) : sans entretien, les
  machines s'usent 2,5 fois plus vite. L'amortissement est un coût sans mouvement d'argent.
- **Taux d'intérêt** = `interestRate` + `riskSpread` × endettement, où endettement = dette ÷ valeur des machines, borné
  à 1.
- **Service de la dette :**
  - intérêts du jour ;
  - remboursement de max(dette ÷ `loanTermDays` ; 5 $), plus 5 % de la trésorerie au-delà de 2 × 6 jours de coûts
    (remboursement anticipé), en laissant 2 jours de salaires. Le remboursement détruit la monnaie ;
  - si l'entreprise ne peut pas payer les intérêts, ils s'ajoutent à la dette ;
  - après 60 jours de retard : radiation et interdiction de crédit pendant 180 jours.
- **Investissement** (`_invest`) — une machine de plus si elle rapporte au moins 1,3 fois son coût quotidien
  (intérêts + usure + 0,1 %) :
  - ce qu'elle rapporte : le gain de lots × marge unitaire si la demande attend ; sinon, le travail qu'elle remplace
    (au moins 2 employés) ;
  - conditions : au plus une machine tous les 3 jours, moins de 4 machines par employé, et pas d'investissement si
    l'équipe utilise moins de 80 % de sa capacité ;
  - financement à crédit si la trésorerie ne couvre pas la machine au-delà de 6 jours de coûts. Le crédit exige une
    entreprise rentable, privée, sans interdiction, et une dette d'au plus 80 % de la valeur des machines (garantie).
- **Fonds de roulement** (`_workingCapital`) :
  - pour une entreprise rentable dont les ventes couvrent les salaires et dont des clients repartent les mains vides ;
  - de quoi payer 8 jours de salaires aux postes voulus ;
  - jusqu'à `workingCapitalDays` jours de chiffre d'affaires, dette comprise.
- **Règles prudentielles** (I4, `_creditOk` ; appliquées si I4 ou le filet anti-crédit-fou est actif) :
  - paiements quotidiens de la dette, prêt compris, ≤ `maxPaymentRatio` × valeur ajoutée ;
  - fonds propres de la Caisse ≥ `minCapitalRatio` × encours, prêt compris.

  Un refus est compté (`refusals`).
- **Ristourne.** La Caisse ristourne chaque jour `bankRebate` de son surplus au-delà de max(capital ;
  `bankTargetRatio` × encours), à parts égales entre tous les citoyens (membres). Justification : modèle coopératif
  (Caisse populaire) qui garde les fonds propres visés.

### 6.11 Profits, dividendes, renflouement (`sim.dart:_decide`, `solventDividend`, `_finance`)

- **Profit et dividende.**
  - Profit du jour = recettes − coûts ; il s'ajoute aux bénéfices non répartis.
  - Réserve = 8 × (salaires + intrants lissés + services lissés) + 10 % de la dette.
  - Dividende voulu = `dividendRate` × (trésorerie − réserve), versé au propriétaire et imposé.
  - Pas de dividende pour un établissement public.
- **Test de solvabilité (I1).**
  - Pas de dividende sans bénéfice lissé.
  - Pas de dividende qui laisserait moins que le seuil d'embauche des postes voulus.
  - Jamais plus que le bénéfice lissé du jour, ou que les bénéfices non répartis avec `dividendFromRetained`.
  - Repère : Loi canadienne sur les sociétés par actions, art. 42.
- **Renflouement (filet).** Une entreprise privée qui a des clients et moins de 4 jours de salaires de l'équipe voulue
  reçoit de son propriétaire jusqu'à la moitié de son surplus, pour revenir à 10 jours. Un propriétaire sans moyens est
  remplacé par le citoyen le plus riche (rachat).
- **Redistribution de l'État.** Au-delà d'une réserve de 30 × `benefit` × max(4 ; population/10), `stateRebate` du
  surplus est versé chaque jour à parts égales.

### 6.12 Entrée et sortie d'entreprises (`sim.dart:_entryExit`, `_found`, `_close`)

- **Sortie.**
  - Une entreprise privée sans employé depuis `exitIdleDays` jours ferme.
  - Faillite ordonnée (I5) : la trésorerie rembourse d'abord la Caisse, ce qui détruit la monnaie ; le solde de la dette
    est radié ; le reste va au propriétaire, à défaut à l'État.
  - Sans I5, la dette est radiée avant que la trésorerie revienne au propriétaire.
- **Entrée** — au plus une par jour, à partir du jour 30, et pas pour un bien public gratuit :
  - type éligible si son bien a une demande non servie lissée d'au moins `entryMinShare` × production d'un employé ;
  - **sans producteur actif**, l'entrée est possible tout de suite ;
  - **concurrente**, il faut en plus : jour 100 ou après ; moins de 3 producteurs actifs ; une demande qui occupe un
    employé ; des producteurs tous rentables et vendant à au moins `entryMarginRatio` × leur coût ;
  - délai : `entryCooldown` jours entre deux créations d'un même type.
- **Fondation** (`_found`) :
  - équipe de 1 à 3 personnes, au salaire du marché ;
  - il faut assez de chômeurs qualifiés : au plein emploi, une nouvelle entreprise ne fait que débaucher ses voisines ;
  - viabilité : aux prix du marché, bornés au double du prix mondial, les ventes attendues couvrent 1,1 × salaires +
    intrants ;
  - capital = 10 jours de salaires + 5 jours d'intrants, apporté par le citoyen le plus riche qui en a 1,5 fois au-delà
    de son coussin ;
  - prix de départ = min(coût × `markup` ; plus bas prix des concurrents).
- **Entonnoir de création (mesure seulement)** (`Sim.entryFunnel`, `sim.dart:_funnel`).
  - **Ce qu'il compte :** chaque jour, chaque type dont le bien a une demande suffisante est un projet. Le premier refus
    est nommé : `plafond_quotidien`, `delai`, `concurrence`, `demande`, `main_oeuvre`, `viabilite` ou `capital`.
  - **Où le lire :** dans le journal complet, chaque refus est un événement `projet_refuse`.
  - **Effet :** aucun sur les décisions.
- **Causes de fermeture (mesure)** (`sim.dart:closeCause`). Une entreprise ferme toujours après `exitIdleDays` jours
  sans employé. La cause enregistrée est ce qui l'y a menée, lue dans cet ordre : prix aberrant (plus de 5 fois le prix
  de référence), faillite (dernière fin d'emploi faute de pouvoir payer), demande perdue, sans employé, autre. Elle est
  lue dans `Firm.lastLoss`, et comptée dans `fermeture_<cause>`.
- **Ne passe pas à l'échelle** (mesuré, non corrigé). Une création par jour pour toute l'économie, le délai par type et
  le plafond de 3 producteurs sont des nombres absolus : à 13 240 habitants, il y a environ 7 naissances par an pour
  370 morts (journal, § 6, tâche 1).

### 6.13 État et institutions publiques

- **Recettes.** Impôt sur salaires et dividendes (`taxRate`).
- **Prestations sans I3.** Un forfait `benefit` par sans-emploi, au prorata si le trésor ne suffit pas.
- **Assurance-emploi et aide sociale (I3,** `sim.dart:_insurance`**) :**
  - **demande :** au premier jour sans emploi, avec au moins `eiQualifyingDays` jours assurables depuis la dernière
    demande et un dernier salaire ;
  - **prestation :** `eiReplacement` × min(dernier salaire ; plafond assurable), où plafond = `eiInsurableCap` ×
    salaire moyen ;
  - **durée :** de `eiDaysLow` à `eiDaysHigh` jours, interpolée selon le chômage du jour de la demande (`eiDuration`) ;
  - **aide sociale :** sinon, ou une fois les droits épuisés, le coût de survie ;
  - **trésor insuffisant :** toutes les prestations baissent dans la même proportion (`benefitCut`) ;
  - **financement :** une cotisation `eiRate` sur la paie, plafonnée.
- **Enveloppe des services publics (I2,** `sim.dart:_publicBudget`, `serviceBudget`**) :**
  - l'hôpital et l'école sont publics et gratuits ;
  - l'État porte la trésorerie de chacun à `publicCashDays` jours du coût de l'équipe nécessaire : l'effectif, plus les
    postes que la règle d'embauche ouvrirait aujourd'hui, avec leurs intrants et leurs services ;
  - au-delà de 1,5 fois cette cible, l'excédent revient au trésor ;
  - si le trésor, au-dessus de son plancher, ne suffit pas, toutes les enveloppes baissent dans la même proportion ;
  - repère : budget global des hôpitaux canadiens (Fraser Institute, 2021).
- **Plancher du trésor** (`_stateFloor`) = 5 × `benefit` × max(4 ; population/10). En dessous, l'État cesse de payer les
  soins et les cours (sans I2) et ne finance plus les enveloppes (choix de jeu).

### 6.14 Filets de sécurité, détecteurs, god mode

- **Filets** (`sim.dart:_safetyNets`, `_famineAid`, `_shelterAid`, `_capDrift`, `_finance`, `_refuse`) :
  - **anti-famine :** après `famineDays` jours de faim, l'État achète à manger ; à défaut, une ration « magique » ;
  - **plancher de logement :** après `shelterDays` jours sans logis, l'État paie une nuitée ; à défaut, un abri
    magique ;
  - **plafond de dérive :** ±`maxDailyChange` par jour sur les prix et les salaires ;
  - **renflouement :** § 6.11 ;
  - **anti-crédit-fou :** § 6.10 (avec I4, il ne fait plus que compter les refus).

  Chaque déclenchement est compté et journalisé avec sa cause. Justification : un filet est un instrument de
  diagnostic ; un compteur élevé signale une fuite du modèle.
- **Détecteurs** (`monitor.dart:Monitor.check`). Ils sont vérifiés chaque jour. Une alerte s'ouvre après une durée de
  persistance et se ferme dès que la condition cesse. Elle dit quoi, depuis quand, la valeur, le seuil et les agents en
  cause. Les seuils et leurs raisons sont dans `MonitorConfig`. Les détecteurs observent seulement : ils ne changent
  aucun calcul.
- **God mode** (`sim.dart:godMoney`, `godGoods`, `godDestroy`, `godEpidemic`, `godTrain`, `godAddCitizens`,
  `godRemoveCitizens`, `godFirm`, `godBankrupt`, `setUBI`, `setTrade`, `addFirm`, `removeFirm`). Ce sont les
  interventions du joueur : la monnaie créée ou détruite est inscrite au registre du god mode, les invariants tiennent.
- **Journal complet** (`Sim.trace`, `trace.dart`). Il est réservé aux outils en ligne de commande ; chaque appel est
  gardé, et le journal ne change aucun calcul.

### 6.15 Drapeaux et variantes de test (jamais actifs par défaut)

| Drapeau | Effet | Fonction | Usage |
|---|---|---|---|
| `Sim.sansHasard` | tirages à 0,5, ordres par identifiant | `draw`, `orderKey`, `buy` | cas extrêmes (§ 4) |
| `Sim.verifyFastPaths` | recalcule chaque meilleur prix mis en cache pendant la consommation par le parcours complet et lève une erreur à la moindre différence | `quote`, `bestPrice` | vérification des optimisations (journal, § 7) |
| `Params.healthWearIfDeprived` (A1) | la santé ne s'use que les jours de faim ou sans logis ; les maladies restent | `_health` | variante de l'usure de la santé (décision réservée à Francis) |
| `Params.partTime` (A2) | travail divisible : l'équipe est payée pour la part de sa capacité produite ce jour, au moins 20 % ; le coût de revient ne compte plus les heures oisives | `hoursToday`, `_payWages`, `unitCost` | **actif par défaut depuis le 2026-10-21** (décision de Francis) |

Les résultats de ces variantes sont au journal (tâche 4). Les règles prudentielles fondées sur le salaire contractuel
(embauche, réserve des dividendes, mise à pied sous 2 jours de salaires) ne sont pas modifiées par A2.

### 6.16 Rôles, contrats et négociation salariale (module `jobs`, `jobs.dart`)

Coupé par défaut dans le moteur (empreinte de parité identique au bit près quand il est coupé) ; l'interface l'active
pour ses parties. Mesures et choix : [`rapports/emplois-negociation.md`](rapports/emplois-negociation.md).

- **Organigrammes** (`model.dart:roles`). Chaque type d'entreprise a 3 à 5 rôles. Un rôle a une qualification minimale
  (0 à 3 ; sa partie entière, plafonnée à 2, donne sa classe), une prime à l'intérieur de sa classe, une part visée de
  l'effectif et, pour l'encadrement, une ancienneté minimale (6 mois ou 1 an) : ces postes ne se pourvoient que par
  promotion interne (marché interne du travail, Doeringer et Piore 1971). Chaque type a un rôle d'entrée à la portée
  de la qualification de son gabarit. Choix de jeu.
- **Postes** (`model.dart:nextSeat`, `seatOrder`). Le k-ième poste d'une équipe va au rôle de plus forte moyenne
  part ÷ (effectif + 1) (méthode D'Hondt) ; à égalité, le premier rôle de la liste.
- **Salaire offert.** L'entreprise affiche un salaire pour la qualification de son gabarit (`offer`). L'offre d'un
  rôle = `offer` × classWage[classe du rôle] ÷ classWage[classe du gabarit] × prime (`roleRel`), jamais sous le
  salaire minimum : un technicien d'hôpital se paie comme un technicien. `offer` s'ajuste comme le salaire unique sans
  le module (§ 6.5 : postes vacants, chômage, rappel vers la norme des salaires affichés de la même classe, bornes) ;
  les contrats en cours n'en dépendent pas. Le salaire de l'entreprise (`wage`) devient la moyenne des contrats.
- **Salaire de réserve** (`reservationWage`). En emploi : le salaire du contrat × (1 + `switchPremium` + 1 % par année
  d'ancienneté, au plus 10 %). Sans emploi : le dernier salaire × max(`reservationFloor` ; 1 − `reservationDecay` ×
  jours de chômage), et au moins de quoi toucher, après impôt et cotisation, 1,1 × la prestation du jour
  (assurance-emploi, aide sociale ou forfait), et au moins le salaire minimum.
- **Plafond de l'employeur** (`wageCap`). Offre × (1 + `hireRange`) × (1 + souplesse) × (1 + 0,05 × surqualification
  du candidat, au plus 3), où souplesse = `hireFlexBase` + `hireFlexMax` × (0,6 × min(1 ; jours de postes vacants ÷
  10) + 0,4 × min(1 ; part de demande non servie)) ; jamais plus que l'offre × valeur ajoutée par employé ÷ salaire
  moyen (`valueAddedPerWorker` : production aux prix affichés moins intrants, sauf pour un établissement public),
  jamais moins que le bas de la fourchette. Salaire verrouillé : l'offre, sans négociation.
- **Négociation** (`bargain`). Plancher = max(offre × (1 − `hireRange`) ; salaire de réserve). Si le plancher dépasse
  le plafond, le candidat refuse. Sinon, salaire = plancher + β × (plafond − plancher), β = `bargainBase` +
  `bargainTrait` × aplomb + `bargainTight` × θ/(1 + θ), borné à [0,05 ; 0,7], où θ = postes ouverts de la classe du
  rôle ÷ chômeurs admissibles (partage du surplus, Pissarides 2000).
- **Marché du travail** (`_jobMarket`, étape 1) :
  1. le salaire minimum relève les contrats qui sont dessous ;
  2. tension θ par classe ;
  3. rondes d'embauche : à chaque ronde, chaque entreprise qui a des postes ouverts pourvoit le prochain poste de son
     organigramme, la mieux payante d'abord. Promotion interne d'abord (`_promote`, au plus 3 par jour) : l'employé
     le plus ancien d'un rôle moins payé qui a la qualification et l'ancienneté voulues ; il obtient max(+`promotionRaise`
     ; l'offre du rôle) et le poste qu'il libère se pourvoit à la ronde suivante. Sinon, entrevues (`_interview`) :
     les chômeurs admissibles, le moins surqualifié d'abord, dans l'ordre du flux `embauche`, au plus `maxInterviews`.
     Un rôle sans preneur est laissé pour la journée ; un rôle d'encadrement sans candidat interne aussi ;
  4. mobilité : un employé qui regarde ailleurs (flux `depart`, chance `jobSwitch`) reçoit la meilleure offre négociée
     d'un concurrent qui a un poste ouvert à sa portée (hors encadrement). Son employeur, s'il est rentable et a encore
     besoin de lui, égale l'offre tant qu'elle reste sous son propre plafond (contre-offre, enchères successives de
     Postel-Vinay et Robin 2002) ; sinon l'employé part ;
  5. renouvellement tous les `reviewDays` jours depuis l'embauche (contrats échelonnés, Taylor 1980) : le salaire est
     renégocié à l'offre du rôle × (1 + `seniorityStep` par année, au plus `seniorityCap`). Hausse gelée si
     l'entreprise perd de l'argent ; baisse d'au plus `reviewCutMax` du salaire (1 : retour au taux du marché).
- **Paie** (`_payContracts`, étape 4) : chacun reçoit le salaire de son contrat ; si la caisse ne suffit pas, tous sont
  payés dans la même proportion et le dernier embauché est mis à pied.
- **Mises à pied** : inchangées (dernier embauché, premier parti : l'ancienneté protège).
- **Rendement** (`efficiency`) : la surqualification se mesure par rapport au rôle tenu.
- **Création d'entreprise** (`_found`) : salaire affiché = la norme des salaires affichés de la classe ; coût d'un employé
  = cette norme × le rapport moyen de l'organigramme (`avgRoleRel`). Plan de départ : même correction du coût du travail.
- **Activation en cours de partie** (`_jobsSwitch`) : chacun garde son salaire et reçoit le rôle le plus exigeant à sa
  portée parmi les postes de l'organigramme de son équipe (qualification et ancienneté comprises) ; le salaire affiché
  est fixé pour que l'offre moyenne de l'organigramme égale le salaire actuel. Coupure : le salaire moyen devient le
  salaire unique.
- **Aucun argent n'est créé** : la paie reste le seul transfert du module ; les invariants tiennent au bit près.

Justification des choix mesurés (10 graines × 1 000 jours, avec filets ; chômage médian 9,4 % sans le module) :
avec l'offre pour plancher de la négociation au lieu du bas d'une fourchette, chaque embauche se concluait au-dessus
de l'offre (24 %) ; sans renouvellement à la baisse, les contrats ne descendent jamais quand le chômage fait baisser
les offres, alors que le modèle de base ne retrouve l'emploi qu'en baissant tous les salaires, d'environ 40 % par an
(21 %) ; renouvellement annuel, 15 % ; trimestriel, 12 %. Résultat de décision (30 graines × 1 500 jours, avec
filets) : chômage médian 10,2 % contre 7,0 % sans le module ; sans filets, 10,8 % contre 8,0 %.

### 6.17 Entrepreneuriat des citoyens (module `entrepreneurship`, `entrepreneuriat.dart`)

Coupé par défaut (le moteur, le protocole et `reference.sh` ne changent pas ; l'interface le lance actif). Avec le module,
`_entryExit` ne crée plus de « clone » mécanique (`_found`) : les fermetures restent celles de l'inactivité (I5 inchangée),
la fondation devient une décision de citoyen. Il suppose le module `entry`.
- **Candidat** : pas déjà propriétaire, veut posséder (trait `wantsToOwn` avec les bâtiments, sinon même tirage de part `ownerShare`),
  ambition ≥ `entMinAmbition` (0,3), tolérance au risque ≥ `entMinTolerance` (0,25), épargne au-delà du coussin. La tolérance
  = `entRiskMean` ± `entRiskSpread` × (2u − 1), u tiré à la naissance. Traits tirés dans `Flux.traits`, sous-indices 70 (risque)
  et 71 (posséder), **au jour 0** : pure fonction de (graine, id), rien à sérialiser (`traitDraw`).
- **Décision** : chaque jour, tirage `Flux.entrepreneuriat` sous `entConsiderRate × entFoundRate` (0,1 %/j × 1). Alors le
  candidat évalue chaque secteur où la demande non servie (`unmetEma`) occuperait une équipe (même dimensionnement et même test
  de viabilité que `_found`) et prend celui qui maximise : p·(salaire + profit net d'impôt) + (1 − p)·prestation − aversion·(1 − p)·mise/365 − revenu
  actuel (salaire ou prestation), avec p = `entSurviveBase` + `entSurviveKnowledge` × connaissance du secteur, aversion = 2(1 − tolérance).
  Connaissance = 1 − exp(−jours travaillés dans ce type / `entKnowledgeDays`) ; compteur `Citizen.sectorDays`, tenu avec le module.
- **Capital** = `entCapitalMult` × (10 j de salaires + 5 j d'intrants). Le fondateur met son épargne au-delà du coussin (au moins
  `entMinOwnShare` = 30 %) ; le reste est un prêt de la Caisse soumis aux règles I4 (paiements ≤ 35 % de la valeur ajoutée, fonds propres ≥ 11,5 %)
  appliquées par `_loanRefusal` ; tout passe par `transfer()` et `_lend()`. Le fondateur quitte son emploi, est le **premier employé** (jamais débauché)
  et le propriétaire (dividendes I1). À la fermeture : I5 inchangée, il perd sa mise, la Caisse radie le solde (pas de dette personnelle).
- Valeurs : ordres de grandeur a priori, **non ajustées** sur le repère canadien (≈ 10 % d'entrées, 9 % de sorties par an). Limites : une seule
  fondation par citoyen à la fois, au plus une par type et par `entryCooldown` ; la qualité du produit viendra avec le module Produits (compteur de secteur).

### 6.18 Variétés de produits et marques (module `products`, `produits.dart`)

Coupé par défaut (l'interface le lance actif). Une **catégorie** est un bien ; une **variété**, le produit d'une entreprise (une par
entreprise) dans les catégories différenciées : consommation (`consumerVarieties` : pain, viande, repas, télé, loisirs, hôtel, voyages,
bijoux, ordinateurs) et équipement (`machines`). Les matières premières et biens intermédiaires ne changent pas. Aucune catégorie ajoutée,
aucune variété créée d'avance : une entreprise lance la sienne à sa création (ou à l'activation), l'abandonne à sa fermeture.
- **Variété** (`Product`) : id jamais réutilisé, nom généré (`_uniqueName`, unique, sans marque réelle : `realBrands`), qualité 0,6–1,4
  tirée au lancement (`Flux.qualite`, tirée vers le haut par la connaissance du secteur du propriétaire). La qualité coûte : productivité
  ÷ (1 + `prodQualityCost` × (q − 1)). Machine : gain 1,01 + 0,99u³ (×1,01 à ×2, espérance 1,2575 = `machineGainRef`), durabilité 0,7–1,3.
- **Ménages** : au plus `prodKnownMax` variétés connues par catégorie (vitrine/publicité pondérée par la notoriété, bouche-à-oreille entre
  collègues, habitude ; oubli après `prodForgetDays` jours). Utilité = `prodQualityWeight` × q × goût de classe − sensibilité × prix / prix
  mondial + notoriété + habitude + goût personnel (hachage graine × citoyen × variété, ± `prodTasteSpread`) ; sensibilité = trait
  (`Flux.traits` 72). Choix : la meilleure utilité parmi les connues en stock (le goût durable tient lieu de terme logit) ; sinon la
  recherche dans les vendeurs disponibles (qui remplace `sellerSample` pour ces biens), et la demande non servie seulement si tout est vide.
- **Machines** (`_investBuy`) : parmi au plus `prodMakersMax` fabricants connus, le meilleur gain / gain standard × durabilité / prix,
  +`prodLoyalty` pour le fournisseur habituel ; `machineMult` utilise le gain moyen installé (moyenne pondérée, jamais un produit : plafond ×2).
- **Entrée** (`entryWant`) : pour une catégorie différenciée, plus de plafond de 3 producteurs ni de test de marge par vendeur : demande non
  servie + demande faiblement servie (achat d'une variété mal aimée ou trouvée faute d'en connaître) ÷ (1 + variétés actives), si la marge
  moyenne en place ≥ `prodEntryMargin` ; seule limite dure : un employé entier (pas d'échelle minimale fractionnaire) et la viabilité.

### 6.19 Crédit aux citoyens et banques (module `banking`, `banques.dart`)

Coupé par défaut (l'interface le lance actif). **Crédit aux particuliers** : carte de crédit quand l'argent ne couvre pas les besoins
du jour (limite `cardLimitDays` jours de revenu selon la cote, paiement minimum `cardMinPct` par mois, taux `cardRate` + marge de la
banque + prime de cote), prêt personnel à mensualités constantes (`loanTermMonths`) pour un creux de chômage ou un achat important ;
remboursement de la carte quand le revenu arrive. Cote 300–900 (retards récents, dette / revenu, emploi, faillite) ; service de la
dette ≤ `dsrMax` du revenu ; I4 à chaque crédit. Comptes : comme les prêts aux entreprises (création de dépôts, remboursement qui
détruit la monnaie, intérêts aux fonds propres, impayés capitalisés). **Faillite personnelle** : retards depuis `bkArrearsDays` jours,
ou dette sans emploi > `bkDebtIncome` ans de revenu → radiation (perte de la banque), crédit fermé `bkBanDays` jours.
**Plusieurs banques** (`nBanks` ≥ 2) : toute la monnaie passe par le compte consolidé `Sim.bank` (invariants inchangés) ; chaque banque
(`Bank`) en est une répartition : fonds propres (la Caisse, banque 0, a le reste et n'est jamais résolue), prêts et dépôts de ses
clients, réserves = solde de son bilan (règlement net), position interbancaire au taux directeur `policyRate` sous les réserves
minimales `reserveRatio`. Dotation `reservePerCitizen` × population par banque de départ : monnaie extérieure, contrepartie capital
plancher d'un actionnaire institutionnel ; dividendes au-delà du plancher → citoyens (fondateur pour une banque de citoyen). Coûts : le
travail de `bankStaff` employés de services comptables acheté au marché, un loyer. Taux revus tous les 30 jours (stress → marges en
hausse ; réserves inactives → marges en baisse, dépôts mieux payés). Clients : comparaison rare (`bankLookChance`), changement si
l'avantage dépasse `bankSwitchGain`, jamais avec une dette. Faillite (fonds propres négatifs, ratio sous I4, pertes `bankLossDays`
jours) : reprise par la banque la plus solide, actionnaires effacés, déposants intacts. **Fondation par un citoyen** : décision de
l'entrepreneuriat (connaissance du secteur : jours dans un cabinet comptable) sur le profit espéré à la part de marché restante
1/(n+1) moins le coût fixe ; capital minimum absolu `bankMinCapital` versé par `transfer()`, frais irrécupérables `bankEntryCost`.

### 6.20 Banque centrale : taux directeur (`Params.policyPassThrough`)

Coupée par défaut dans le moteur ; l'interface l'active (nœud « Banque centrale » du graphe). Avec elle, le taux de base de
tous les prêts (`Sim.baseRate`) est le taux directeur `policyRate` + `policySpread` au lieu du taux fixe `interestRate` :
prêts aux entreprises (`loanRate`), hypothèques, prêts personnels, test de paiement des fondateurs et plan de départ. Aux
valeurs par défaut, 3 % + 3 % = 6 % = `interestRate` exactement : l'activer ne change rien tant que le taux ne bouge pas.
Le taux directeur garde ses autres rôles (marché interbancaire, plafond des taux de dépôt). Pas de bilan propre ni de
création de monnaie : c'est un levier de prix du crédit.

### 6.21 Douane : prix mondiaux en vagues et droit de douane (`douane.dart`)

Le nœud « Douane » (X) est toujours affiché ; sa fiche ouvre ou ferme les frontières (`trade`) en cours de partie. Deux
réglages s'ajoutent, neutres par défaut dans le moteur. `tradeWaves` (activé par l'interface) multiplie les prix d'import
et d'export de chaque bien par un facteur (1 + a · sin 2π(jour / T + φ)) · (1 + bruit), où φ, T (`tradeWavePeriod` ± 30 %)
et a (`tradeWaveAmp` ± 30 %) sont tirés de la graine et le bruit suit un AR(1) quotidien (0,97 · bruit + `tradeNoise` · u,
borné à ±0,6 ; flux 27) ; le facteur est borné à [0,25 ; 4]. Le sinus est l'approximation de Bhaskara (parité VM/web).
`worldPrice` lui-même ne bouge pas (coûts de remplacement, sensibilité aux prix). `tariff` majore le prix de tout bien
importé ; la part t / (1 + t) du prix payé va à l'État (`state.taxes`, `ledgerTariffs`), le reste sort de l'économie.
Constat (240 citoyens, 600 j, 3 graines) : frontières ouvertes sans droit, les importations (~1,5 M$) dépassent de loin
les exportations (~0,15 M$, surplus de stock seulement) et la masse monétaire fond ; un droit de 50 % limite la fuite.

Taux de change flottant (`floatingFx`, activé par l'interface) : `fxRate` ($ d'ici pour une unité étrangère, 1 au départ)
multiplie les prix d'import et d'export. Chaque soir, frontières ouvertes, les importations sorties de l'économie (droit
exclu) et les exportations du jour sont lissées (α = 0,05), puis `fxRate` × (1 + `fxSpeed` · (I − X) / (I + X)), borné à
[0,1 ; 10]. Mesure (240 citoyens, 1 500 j, 3 graines, vagues actives) : avec `fxSpeed` = 5 %/j, importations ≈
exportations (1,4 M$ contre 1,3 M$), masse monétaire 1,36 à 1,52 M$ au lieu de 0,2 M$, chômage 28 à 38 % ; à 1 %/j le
taux arrive trop tard (2 graines sur 3 au plafond de 10, économie effondrée).

Demande étrangère active (`foreignDemand`, activée par l'interface) : chaque entreprise d'un bien exportable a une commande
quotidienne de l'étranger (`Sim.foreignOrders`). Après les ventes du jour, elle livre au prix à l'export ce qui dépasse
deux jours de sa demande d'ici, jusqu'à la commande ; les livraisons comptent dans `sold` (production et embauche les
suivent). Si l'export est rentable (prix ≥ coût unitaire × (1 + `fdMinMargin`)) et paie au moins 95 % du prix d'ici, la
commande grossit de `fdGrowth` par jour quand elle a été livrée à 90 % ; sinon elle fond de 10 % par jour. Elle démarre à
`fdStart` et plafonne à `fdMaxCap` fois la demande d'ici (10 % de la production de l'équipe pour une entreprise presque
sans clients ici). Les deux bornes sont nécessaires : sans la condition de prix, l'export fait monter le prix d'ici au-dessus
du prix d'import et les clients d'ici importent ce qui est exporté (aller-retour perdant, taux au plafond) ; sans plafond
lié à la demande d'ici, une entreprise de transformation (restaurant : intrants importés, repas exportés) grossit sans fin.
Mesure (240 citoyens, 5 graines, chômage moyen des jours 1000 à 1500) : frontières fermées 23 %, change seul 38 %,
change + demande étrangère 30 % (15 à 20 % dans 4 graines ; la cinquième s'effondre vers le jour 900 : des filières
d'intrants disparaissent, les intrants importés rendent l'export non rentable, et le taux au plafond n'y peut rien).

---

## 7. Vérification

- **Tests** (`test/`) :
  - `engine_test.dart` : déterminisme, invariants exacts chaque jour, filets et détecteurs provoqués, institutions ;
  - `hasard_test.dart` : flux de hasard ;
  - `protocole_test.dart` : statistiques du protocole ;
  - `instantane_test.dart` : reprise exacte depuis un instantané ;
  - `proprietes_test.dart` : propriétés sur des parties tirées au hasard ;
  - `extremes_test.dart` : cas extrêmes au résultat connu d'avance ;
  - `batiments_test.dart` : module bâtiments et hypothèques ;
  - `emplois_test.dart` : module rôles et négociation (organigrammes, contrats cohérents chaque jour, bornes de la
    négociation, renouvellements, salaire minimum, activation en cours de partie, instantanés).
- **Protocole** (`tool/stabilite.dart`) : 30 graines × 1 500 jours, sans puis avec filets, chocs standard, comparaisons
  appariées avec intervalles bootstrap.
- **Parité** (`tool/parite.dart`) : empreinte identique sur la VM et en JavaScript.
