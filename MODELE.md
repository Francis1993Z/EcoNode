# ÉcoNodes — description du modèle (protocole ODD)

Ce document décrit le modèle tel qu'il est codé (moteur v2, octobre 2026), selon le protocole ODD (Grimm et al. 2020,
« The ODD Protocol for Describing Agent-Based and Other Simulation Models: A Second Update », *JASSS* 23(2) 7). Il est
distinct du journal ([`rapports/stabilisation.md`](rapports/stabilisation.md)), qui raconte pourquoi et comment le
modèle a changé. C'est ce document qu'on donne à un nouveau lecteur, humain ou LLM, à la place d'un résumé refait.

Conventions :

- **Renvois** : `fichier:fonction` (par exemple `sim.dart:_laborMarket`). Les fichiers sont dans `lib/engine/`.
  `model.dart` contient les données et les paramètres, `sim.dart` le moteur, `monitor.dart` les détecteurs.
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
- **Filets** (`model.dart:Safeguards`), actifs par défaut dans le jeu : anti-famine, renflouement, plancher de logement,
  plafond de dérive, anti-crédit-fou. Ce sont des instruments de diagnostic : chaque déclenchement est compté et
  journalisé.
- **« Noyau »** (`Modules.noyau`) : les modules économiques sont coupés, les institutions restent actives.

---

## 3. Ordre exact des étapes d'une journée (`sim.dart:step`)

| # | Étape | Fonction | Condition |
|---|---|---|---|
| 0 | Jour + 1 ; remise à zéro des compteurs du jour (ventes, production, recettes, coûts, flux, demande non servie) ; `incomeEma` ← 0,9 × `incomeEma` + 0,1 × revenu de la veille | `step` | toujours |
| 0 bis | Revenu de base du god mode (création monétaire) | `step`, `_godIn` | `ubi` > 0 |
| 1 | Marché du travail : embauches, mobilité, jours de chômage, prestations | `_laborMarket`, `_insurance` | toujours |
| 2 | Enveloppes des établissements publics | `_publicBudget` | I2 |
| 3 | Production | `_produce` | toujours |
| 4 | Paie : salaires, impôt, cotisations ; mise à pied si la paie est impossible | `_payWages` | toujours |
| 5 | Achats des entreprises (ordre `achats`) : intrants, puis services | `_buyInputs`, `_buyServices` | toujours |
| 6 | Ménages (ordre `consommation`) : usure des désirs, manger, se loger, santé, ordinateur, études, loisirs, bonheur ; puis files des services publics | `_consume`, `_serveQueues` | files : I2 |
| 7 | Filets anti-famine et plancher de logement | `_safetyNets` | filets actifs |
| 8 | Exportations | `_export` | `trade` |
| 9 | Péremption des biens périssables | `_expire` | toujours |
| 10 | Capital (ordre `capital`) : usure, service de la dette, investissement ; ristourne de la Caisse | `_capital`, `_invest` | toujours |
| 11 | Décisions des entreprises : prix, plan d'embauche, salaires, profits, dividendes ; flux lissés pour l'affichage | `_decide` | toujours |
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

### Les 18 flux

| Code | Flux | Usage | Fonction |
|---|---|---|---|
| 1 | `traits` | traits d'un citoyen à sa naissance : qualification, argent, ambition, ordinateur, nom | `_newCitizen` |
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
| 18 | `vendeurs` | recherche limitée : vendeurs examinés par un achat de ménage (`sellerSample` > 0) | `_AllOffers.sampled` |

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
   (choix de jeu).
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
   postes qui les exigent.
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
| `sellerSample` | 0 | recherche limitée : un achat de ménage n'examine que k vendeurs tirés (plus celui de son dernier achat) ; 0 = tous | choix de jeu, coupé par défaut (journal, § 8) |
| `startWallet` | 3 000 $ | argent de départ de référence | choix de jeu |
| `startWage` | 150 $/j | salaire de base d'un manœuvre | choix de jeu |
| `markup` | 1,15 | majoration normale du coût | choix de jeu |
| `bufferDays` | 12 | coussin d'épargne, en jours de survie | choix de jeu |
| `mpcIncome` | 0,6 | propension à consommer le revenu discrétionnaire (α₁) | modèle SIM de Godley et Lavoie |
| `wealthTargetDays` | 20 | richesse visée T, en jours de revenu discrétionnaire ; α₂ = (1 − α₁)/T | calibration interne : reproduit la richesse de départ (2 750 $ ≈ 21 jours) |
| `trade`, `importMarkup`, `exportDiscount` | non, 1,3, 0,7 | commerce extérieur : import au prix mondial × 1,3, export × 0,7 | choix de jeu |
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
| `partTime` | non | variante de test A2 (§ 6.15) | jamais active par défaut |

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
| `Params.partTime` (A2) | travail divisible : l'équipe est payée pour la part de sa capacité produite ce jour, au moins 20 % ; le coût de revient ne compte plus les heures oisives | `hoursToday`, `_payWages`, `unitCost` | variante du travail indivisible (décision réservée à Francis) |

Les résultats de ces variantes sont au journal (tâche 4). Les règles prudentielles fondées sur le salaire contractuel
(embauche, réserve des dividendes, mise à pied sous 2 jours de salaires) ne sont pas modifiées par A2.

---

## 7. Vérification

- **Tests** (`test/`) :
  - `engine_test.dart` : déterminisme, invariants exacts chaque jour, filets et détecteurs provoqués, institutions ;
  - `hasard_test.dart` : flux de hasard ;
  - `protocole_test.dart` : statistiques du protocole ;
  - `instantane_test.dart` : reprise exacte depuis un instantané ;
  - `proprietes_test.dart` : propriétés sur des parties tirées au hasard ;
  - `extremes_test.dart` : cas extrêmes au résultat connu d'avance.
- **Protocole** (`tool/stabilite.dart`) : 30 graines × 1 500 jours, sans puis avec filets, chocs standard, comparaisons
  appariées avec intervalles bootstrap.
- **Parité** (`tool/parite.dart`) : empreinte identique sur la VM et en JavaScript.
