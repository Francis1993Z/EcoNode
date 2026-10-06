# ÉcoNodes : état des lieux et plan de stabilisation

Date : 3 octobre 2026. Moteur : Dart (`lib/engine/`), modèle v2. Les chiffres viennent de
[`stabilite-avant.md`](stabilite-avant.md) (modèle complet) et [`stabilite-noyau.md`](stabilite-noyau.md)
(tous les modules coupés), produits par `tool/stabilite.dart`.

## 1. État des lieux

### Ce qui a été ajouté depuis la v0

La v0 (dernier commit `2b85e40`) compte 10 entreprises, 11 biens et 80 citoyens, avec des besoins à seuils
(faim, logement, souliers). La v2, dans l'arbre de travail et pas encore commitée, a remplacé ce moteur.

| Ajout v2 | Interrupteur | Ordre du cahier des charges |
|---|---|---|
| Caisse populaire : prêts aux entreprises pour acheter des machines ; le prêt crée la monnaie, le remboursement la détruit ; intérêts, radiations, ristournes | `credit` | n° 1, mais simplifié : pas de banque centrale ni de taux directeur, pas d'intérêt sur les dépôts, aucun prêt de fonds de roulement ni aux ménages, **fonds propres de départ nuls** |
| Hôpital et école achetés par les citoyens, payés par l'État s'il le peut | `health`, `education`, `publicHealth`, `publicEducation` | n° 3, **ajouté avant le n° 2** (cohortes d'âge, absent) et **sans file d'attente** |
| Trois secteurs, 33 biens, 32 types d'entreprises, 240 citoyens, dimensionnement automatique au départ | — (c'est le scénario) | hors liste (rapport, § 5) |
| Désirs à satisfaction qui s'use (faim, logement, santé, divertissement, luxe), goûts par classe, bonheur | — (remplace les seuils v0) | hors liste (rapport, v1.3 « consommation ») |
| Qualifications (manœuvre, technicien, professionnel), poste exigeant une qualification | `education` pour la progression | hors liste |
| Machines (rendements décroissants), usure, entretien (garage, ingénierie), cadence de l'industrie lourde | `capital` | hors liste |
| Niveaux technologiques par R-D | `rnd` | hors liste |
| Publicité (notoriété, hausse de la dépense des ménages) | `marketing` | hors liste |
| Comptabilité obligatoire | `accounting` | hors liste |

Les naissances et décès, les cohortes d'âge et le logement détaillé ne sont pas implémentés.
Comme demandé, chaque module hors ordre est isolé derrière un interrupteur : onglet Diagnostic → Modules,
`Modules` en code, `--modules credit=0,…` ou `--noyau` en ligne de commande.

### Ce qui a été ajouté dans cette étape (instruments de stabilisation)

- **Filets de sécurité** (`Safeguards`, `lib/engine/model.dart`), chacun interrupteur nommé, compté et journalisé
  (jour, agent, montant, raison) : anti-famine, renflouement d'entreprise (déjà présent, désormais compté par entreprise),
  plancher de logement, plafond de dérive des prix et salaires (±2 %/j), anti-crédit-fou (paiements ≤ 35 % de la valeur
  ajoutée, fonds propres de la Caisse ≥ 11,5 % des prêts).
- **Détecteurs d'anomalies** (`lib/engine/monitor.dart`), vérifiés chaque jour, avec ce qui se passe, depuis quand,
  la valeur, le seuil et les agents en cause, visibles dans l'onglet Diagnostic, le badge de la barre du haut et le journal.
- **Invariants comptables** vérifiés chaque jour, qui lèvent une exception en mode développement (`devChecks`) :
  la masse monétaire, le portefeuille de prêts (prêté + capitalisé − remboursé − radié = encours),
  le bilan de la Caisse (réserves + prêts = dépôts + fonds propres) et la variation quotidienne des dépôts
  expliquée par les flux. La monnaie est comptée en multiples de 2⁻¹⁰ $ : les additions sont exactes,
  donc tout écart non nul est un bogue. L'écart mesuré est de **0 exactement** sur 1 500 jours.
- **Protocole** `tool/stabilite.dart`, l'équivalent Dart du script Node demandé. Il couvre 5 graines × 1 500 jours,
  sans puis avec filets, et 5 chocs × 3 graines, sans puis avec filets. Il produit un rapport Markdown
  et une synthèse JSON (`--save`), et un tableau AVANT/APRÈS (`--compare`). Durée : environ 85 secondes.
- **Interface v2** : graphe des 32 entreprises, de la Caisse et des flux de services ; inspecteurs (entreprise :
  capital, technologie, dette, filets reçus ; citoyen : désirs, qualification) ; onglet Diagnostic.

### Ce qui est testé, et ce qui ne l'est pas

| Testé | Comment |
|---|---|
| Déterminisme (même graine, même partie) | `flutter test` |
| Invariants exacts à chaque jour : 2 graines × 1 500 j avec filets, 1 graine × 800 j sans | `flutter test` (mode développement) |
| Grand livre avec god mode, crédit, effacement de dette, faillite, fermeture | `flutter test` |
| Anti-famine et plancher de logement provoqués, avec la bonne cause | `flutter test` |
| Comptage des filets cohérent ; un filet coupé ne se déclenche plus | `flutter test` |
| Détecteurs provoqués : argent hors grand livre, entreprise sans employé, chômage > 30 % | `flutter test` |
| Tous les modules coupés : ni machines, ni dette, ni publicité | `flutter test` |
| Comportement économique sur plusieurs graines, et chocs | `tool/stabilite.dart` |

Pas encore testé :

- la plausibilité de chaque module pris isolément (investissement, R-D, publicité, formation) ;
- l'interface, vérifiée seulement à la main dans la version web ;
- l'application Android sur un appareil ;
- la version JavaScript v0 : elle est figée, et le test de parité JS a été retiré car il ne s'applique plus au modèle v2 ;
- le calibrage des seuils des détecteurs.

### Diagnostic de départ (AVANT)

| | Sans filets, modèle complet | Avec filets, modèle complet | Sans filets, noyau seul |
|---|---|---|---|
| Chômage moyen | 72,6–93,8 % ❌ | 3,7–6,2 % ✅ | 3,8–4,4 % ✅ |
| Faim moyenne | 70,5–94,6 % ❌ | 0,0 % ✅ | 0,0 % ✅ |
| Sans-abri moyen | 94,9–96,9 % ❌ | 0,2–1,3 % (pics à 100 %) | **100 %** ❌ |
| Gini moyen | 0,44–0,91 | 0,28–0,45 | 0,20–0,31 ✅ |
| Inflation moyenne / jour | +0,04 % ✅ | −0,01 à −0,04 % ✅ | +0,01 % ✅ |
| Alertes critiques | 55 | 16 | 9 |
| Écart comptable max | 0 exact ✅ | 0 exact ✅ | 0 exact ✅ |

Déclenchements des filets en régime normal (moyenne des 5 graines, par 50 jours ; l'objectif est moins de 1) :

| Filet | Modèle complet | Noyau | Cause principale |
|---|---|---|---|
| Renflouement d'entreprise | 66,1 ❌ | 63,8 ❌ | par le propriétaire (98 %) |
| Plafond de dérive | 226,5 ❌ | 113,4 ❌ | hausses (57 %) et baisses (41 %) de prix |
| Anti-crédit-fou | 67,1 ❌ | 0 (crédit coupé) | fonds propres de la Caisse insuffisants (100 %) |
| Plancher de logement | 12,7 ❌ | 0,0 ✅ | parc plein (100 %) |
| Anti-famine | 0,0 ✅ | 0,0 ✅ | — |

Chocs standard avec filets : le **salaire minimum à 220 $** se résorbe en 144 à 159 jours ✅, et la **faillite de la
raffinerie** en 58, 131 et 250 jours (2 graines sur 3 ✅). L'**hélicoptère de 5 000 $** fait s'effondrer l'économie
(chômage à 67 %, faim jusqu'à 74 %, retour au mieux en 405 jours). Les **+25 immigrants** (chômage à environ 45 %,
sans-abri autour de 15 %) et la **fermeture de la ferme** (faim à 88–90 %) ne se résorbent jamais.
Sans filets, les chocs sont sans objet : l'économie s'effondre déjà avant le jour 300.

### Mécanismes de l'effondrement, observés sur une trace

Trace jour par jour des premières faillites : graine 1, sans filets.

1. **Travail indivisible.** Une douzaine d'entreprises en amont (cuivre, bauxite, plastique, conception,
   comptabilité, hôpital, cégep…) ont 1 employé pour une demande qui n'en justifie qu'une fraction. Leur coût de revient
   suppose pourtant un employé pleinement occupé : elles vendent sous leur coût réel et meurent entre le jour 9 et le jour 50.
   C'est la fuite que le renflouement colmate 64 à 66 fois par 50 jours.
2. **Chaînes à fournisseur unique, sans substitution** (recettes de Leontief). La mort du plastique bloque l'électronique,
   et avec elle la télé, les ordinateurs, l'hôpital, le garage et la machinerie. Celle de la raffinerie bloque la pêche,
   la fonderie, l'aluminerie et le tourisme. Dans le noyau, l'immobilier meurt faute d'**acier**, un intrant de 0,005 lingot
   par nuitée : 100 % de sans-abri.
3. **L'argent s'accumule chez les ménages.** Il passe de 840 k$ à 1,46 M$ au jour 200, pendant que la trésorerie
   des entreprises fond de 625 k$ à 55 k$. Les ménages dépensent moins que leur revenu.
4. **Des prix trop nerveux.** L'ajustement de 25 % de l'écart par jour et les sauts de marge font dépasser ±2 %/j
   environ 4 fois par jour.
5. **Une Caisse sans fonds propres** : son capital de départ est nul et elle ristourne tout son surplus.
   Sous le ratio de 11,5 %, elle ne peut prêter à personne.
6. **Un parc de logements fixe** (1,06 nuitée par habitant), sans construction : le choc migratoire produit des sans-abri.

## 2. Plan de stabilisation

Chaque tâche est une seule correction à la source, mesurée par le protocole. Je relance
`dart run tool/stabilite.dart --compare rapports/stabilite-avant.json` pour obtenir le tableau AVANT/APRÈS.
Pour chaque paramètre de calibration modifié, j'indique la raison. On stabilise d'abord le **noyau** (`--noyau`),
puis on réactive les modules un à un.

| # | Tâche | Cause visée | Mesure de réussite |
|---|---|---|---|
| 1 | Coût de revient fondé sur le travail réellement payé : masse salariale ÷ production effective quand l'équipe est sous-employée | mécanisme 1 | renflouements < 5 / 50 j dans le noyau |
| 2 | Intrants mineurs non bloquants : un intrant de moins de 5 % du coût qui manque réduit la cadence au lieu de l'arrêter ; achat de dépannage à l'extérieur (×1,3) si l'option commerce est active | mécanisme 2 | 0 % de sans-abri dans le noyau, moins d'alertes « rupture » |
| 3 | Prix et salaires lissés à la source : convergence plus lente vers la cible, pas de marge plus petits | mécanisme 4 | plafond de dérive < 1 / 50 j, inflation stable |
| 4 | Consommation de type stock-flux : C = α₁·revenu disponible + α₂·richesse, avec α décroissant avec la richesse (rapport, Carroll 2017) | mécanisme 3 | répartition de la monnaie stable, plus d'assèchement des entreprises |
| 5 | Entrée et sortie d'entreprises : un bien sans producteur, ou très rentable, attire une nouvelle firme financée par un citoyen riche ; une firme vide finit par fermer (avec interrupteur) | chocs ferme et faillite | retour à l'équilibre en < 200 j sans intervention |
| 6 | Logement : construction à partir de bois et d'acier quand l'occupation dépasse 95 %, impôt foncier en option | mécanisme 6, rente | choc +25 immigrants résorbé, Gini < 0,45 |
| 7 | Pénurie de main-d'œuvre : salaires qui montent plus vite quand des postes critiques restent vacants (dans la limite du plafond) | problème connu n° 3 | choc salaire minimum et immigrants résorbés plus vite |
| 8 | Caisse : capital initial ≥ 11,5 % de l'encours prévu, bénéfices retenus jusqu'au ratio cible avant toute ristourne, prime de risque selon l'endettement | mécanisme 5 | anti-crédit-fou < 1 / 50 j |
| 9 | Hélicoptère : nouvelle analyse après les tâches 1 à 4 (canal prix et capacité) | problème connu n° 1 | inflation < 100 % sur 100 j, pas d'effondrement |
| 10 | Noyau conforme aux critères de sortie, puis réactivation des modules un à un : crédit d'abord ; capital, comptabilité, publicité, R-D et formation ensuite, chacun devant conserver les critères | ordre du cahier des charges | critères de sortie verts pour chaque configuration |

Les cohortes d'âge, les services publics avec files d'attente, les naissances et décès et le logement détaillé
viendront dans cet ordre, une fois ces critères atteints.

## 3. Choix d'interprétation

- **Script « Node » :** le moteur de référence est désormais en Dart. Le script s'exécute avec
  `dart run tool/stabilite.dart`, sans interface. La version JS (`version web/`) est figée au modèle v0.
- **Invariant « à 1e-8 près » :** avec des montants quantifiés au 2⁻¹⁰ $, l'invariant est exact (0). Le détecteur s'alarme
  au-delà de 1e-6 $. En virgule flottante classique, 1e-8 $ absolu serait hors de portée sur une masse de 1,5 M$.
- **Chômage :** les deux conditions (> 30 % et = 0 %) doivent tenir 30 jours consécutifs.
- **Faim et sans-abri :** alerte au-delà de 5 % pendant 3 jours. Le critère de sortie vérifie à part que la moyenne
  reste sous 2 %.
- **Seuils des entreprises :** stock vide plus de 10 jours ; surstock au-delà de 30 jours de ventes pendant 10 jours ;
  sans employé ou sans client plus de 15 jours.
- **Gravité :** sont critiques le chômage > 30 %, la faim, les sans-abri, l'inflation et l'invariant.
  Les autres alertes sont des avertissements.
- **Faillite d'une firme clé :** la Raffinerie perd sa trésorerie et ses stocks, sa dette est radiée,
  et elle reste en place. Le type se change avec `--key`.
- **Retour à l'équilibre :** 30 jours de suite avec chômage de 3 à 10 %, faim et sans-abri sous 2 %, inflation sous 0,5 %/j
  et aucune alerte critique. Le choc a lieu au jour 300 et on observe ensuite 500 jours.
- **Filets dans le jeu :** ils sont actifs par défaut pour que la partie reste jouable, et coupés à l'étape 1 du protocole.

**Calibration.** Aucun paramètre économique n'a été modifié dans cette étape. Trois changements de mécanique,
sans effet notable :
- les montants sont arrondis au 2⁻¹⁰ $ inférieur, soit moins de 0,001 $ par transfert ;
- un transfert ne peut plus passer sous zéro ;
- `recapitalize`, `lending`, `publicHealth` et `publicEducation` sont passés dans `Safeguards` et `Modules`.

## 4. Journal des corrections

### Tâche 1 — Coût de revient fondé sur le travail réellement payé (4 octobre 2026)

Rapports : [`tache1-noyau.md`](tache1-noyau.md) (comparé à `stabilite-noyau.json`) et
[`tache1-complet.md`](tache1-complet.md) (comparé à `stabilite-avant.json`).

**Ce qui a changé** (aucun paramètre de calibration modifié) :

- **1a — coût du travail réel.** Le salaire par lot est divisé par l'utilisation de l'équipe lissée sur ~20 jours
  (plancher 5 %). Une première version qui suivait la production prévue du jour faisait exploser les prix
  (×8 en 5 jours, effondrement du noyau) : les clients achètent par lots, la demande quotidienne a des creux.
- **1b — production au plan.** Une entreprise produit la demande prévue et le réassort de son stock visé, au lieu de
  produire à pleine capacité jusqu'à 8 jours de stock (seuil qui déclenchait aussitôt ses baisses de prix).
- **1c — dimensionnement à l'échelle minimale.** Au départ, une entreprise dont la demande n'occupe pas un employé à
  plein temps a une productivité réduite d'autant (une petite production est moins efficace), ce qui rend ses prix de
  départ cohérents avec son coût réel. Une entreprise dont le produit n'a aucune demande (module coupé) n'est pas créée.

**Résultats** (moyenne ou plage des 5 graines) :

| Indicateur | Noyau avant | Noyau après | Complet avant | Complet après |
|---|---|---|---|---|
| Renflouements / 50 j (avec filets) | 63,8 | **6,4** | 66,1 | **14,5** |
| Plafond de dérive / 50 j | 113,4 | 62,9 | 226,5 | 226,7 |
| Anti-crédit-fou / 50 j | — | — | 67,1 | 142,8 |
| Plancher de logement / 50 j | 0,0 | 0,0 | 12,7 | 0,0 |
| Sans filets : chômage moyen | 4,1 % | 24,7 % | 86,9 % | 70,7 % |
| Sans filets : faim moyenne | 0,0 % | 0,0 % | 87,0 % | 66,3 % |
| Sans filets : sans-abri moyen | 100 % | 18,8 % | 95,9 % | 91,8 % |
| Sans filets : Gini moyen | 0,25 | 0,82 | 0,59 | 0,94 |
| Avec filets : chômage moyen | 4,9–7,7 % | 9,5–17,4 % | 3,7–6,2 % | 13,8–32,1 % |
| Avec filets : Gini moyen | 0,46–0,63 | 0,71–0,84 | 0,28–0,45 | 0,81–0,89 |
| Chocs résorbés en < 200 j (avec filets) | — | — | 5 / 15 | 0 / 15 |
| Écart comptable max | 0 exact | 0 exact | 0 exact | 0 exact |

**Correctif.** Une première mesure du modèle complet était faussée : la pénalité de petite taille (1c) bouclait sur le
calcul des équipements de départ (machines chères → aucune demande de machines → Machinerie et Garage non créés).
Les chiffres ci-dessus sont ceux d'après le correctif (équipements calculés d'abord, pénalité ensuite). Avec filets,
la Caisse ne prête toujours rien : ses fonds propres sont nuls et l'anti-crédit-fou refuse tout (tâche 8).

**Lecture.** La fuite visée est presque refermée : les entreprises sous-employées ne vendent plus sous leur coût
(renflouements ÷ 4,5 à ÷ 10, plus d'abri d'urgence), et le noyau ne perd plus son parc de logements. Mais sur le
modèle complet, le bilan est négatif : la partie jouable (avec filets) passe à 14–32 % de chômage et aucun choc ne se résorbe. Mais elle en révèle une autre, qui
domine maintenant : **les propriétaires d'entreprises rentables thésaurisent**. Exemple (noyau, graine 1, jour 800) :
la propriétaire du bar touche ~730 $ de dividendes par jour et en dépense 354 ; elle détient 560 000 $. Les plafonds
d'achats quotidiens empêchent les riches de dépenser, la monnaie sort du circuit, les salaires baissent de 175 $ à
55 $ et le Gini dépasse 0,8. Avant la tâche 1, les pertes des entreprises servaient malgré elles de canal de
recirculation. Le salaire minimum à 220 $, qui représente maintenant +120 % sur des salaires tombés vers 100 $, ne se
résorbe plus.

**Renflouements restants** : la filière informatique (puces, aluminium, bauxite, conception, ordinateurs), qui tourne à
5–14 % de sa capacité en autarcie à 240 habitants ; la ferme (deux produits liés, dont un s'écoule mal) ; l'hôpital,
dont la demande tombe quand le trésor passe sous son plancher (modèle complet).

**Suite proposée** : avancer la tâche 4 (consommation : dépense de la richesse décroissante mais sans plafonds durs
pour les riches, budget à étages ; cf. phase 1 de la feuille de route), qui est désormais la fuite principale.

### Tâche 4 — Consommation stock-flux (4 octobre 2026)

Rapports : [`tache4-8-noyau.md`](tache4-8-noyau.md) (comparé à `stabilite-noyau.json`), [`tache4-8-complet.md`](tache4-8-complet.md)
(comparé à `stabilite-avant.json`), [`tache4-8-graine42.md`](tache4-8-graine42.md) (la graine jouée par défaut).

**Ce qui a changé :**

- **Fonction de consommation** (`leisureBudget`) : budget discrétionnaire du jour
  C = α₁ · (revenu lissé − besoins) + α₂ · (richesse − coussin), à la Godley-Lavoie. Chaque ménage converge vers
  T jours de revenu discrétionnaire au-delà du coussin ; personne n'accumule sans fin. Le revenu est lissé sur
  ~10 jours (`incomeEma`, dividendes compris).
- **Calibration, avec la raison.** α₁ = 0,6 (valeur du modèle SIM de Godley & Lavoie citée dans le rapport).
  `propensity` (0,05/j) est remplacé par α₂ = (1 − α₁) / T avec T = 20 jours : c'est la richesse de départ de la
  calibration v2 (2 750 $ ≈ 21 jours de revenu discrétionnaire), pour que le capital initial soit cohérent avec la
  fonction de consommation. Deux essais l'ont imposé : α₁ = 0,95 (PMC « des pauvres », Carroll) donnait une richesse
  visée de 1 jour, les ménages vidaient 20 jours d'épargne d'un coup, l'indice des prix faisait ×12. La variante
  « α décroissant avec la richesse » n'est pas retenue pour l'instant : à T égal, elle ne change que la vitesse
  d'ajustement ; à T croissant avec la richesse, elle recrée la concentration. À revoir avec l'aspiration de luxe
  de la feuille de route (phase 7).
- **Plafonds d'achat remplacés par des normes souples** (`dailyNorm`, lassitude en 1 + (n/normale)²). Sans eux, les
  riches ne pouvaient pas dépenser (c'était la fuite) ; sans lassitude, tout le budget allait aux biens les moins chers
  (6 abonnements télé par personne et par jour, hôtels et voyages vidés, chômage à 25 %).
- **Publicité** : elle n'accélère plus que la dépense de l'épargne (richesse visée T / adsBoost). Appliquée au budget
  entier, elle faisait dépenser 160 % du revenu : c'est elle qui faisait exploser le modèle complet (indice ×90).
- **Prix des entreprises inactives** (deux bogues révélés par la dépense libérée) : une entreprise qui ne produit
  rien ne monte plus son prix sur la demande non servie ; sans employés, son prix est figé et son coût calculé à
  l'utilisation nominale. Avant, les prix fantômes des entreprises mortes montaient sans fin (voyage à 2 600 $) et
  empoisonnaient les coûts en aval et l'indice des prix.

**Résultats (5 graines × 1 500 jours) :**

| Indicateur | Noyau, origine | Noyau, après | Complet, origine | Complet, après |
|---|---|---|---|---|
| Sans filets : chômage moyen | 4,1 % | 7,7 % | 86,9 % | 62,3 % |
| Sans filets : faim moyenne | 0,0 % | 2,2 % | 87,0 % | 60,7 % |
| Sans filets : sans-abri moyen | 100 % | 88,9 % | 95,9 % | 84,9 % |
| Sans filets : Gini moyen | 0,25 | 0,33 | 0,59 | 0,70 |
| Avec filets : chômage moyen | 4,9–7,7 % | **1,5–2,8 %** | 3,7–6,2 % | 3,1–8,4 % |
| Avec filets : faim moyenne | 0 % | 0 % | 0 % | 0–1,8 % |
| Avec filets : sans-abri moyen | 0 % | 0–0,2 % | 0,2–1,3 % | 0,6–4,9 % |
| Avec filets : Gini moyen | 0,46–0,63 | **0,11–0,33** | 0,28–0,45 | **0,20–0,37** |
| Renflouements / 50 j | 63,8 | 14,4 | 66,1 | 19,7 |
| Plancher de logement / 50 j | 0,0 | 0,1 | 12,7 | 85,9 |
| Anti-famine / 50 j | 0,0 | 0,0 | 0,0 | 11,9 |
| Chocs résorbés en < 200 j (avec filets) | — | — | 5 / 15 | 5 / 15 |
| Écart comptable max | 0 exact | 0 exact | 0 exact | 0 exact |

**Lecture.** La fuite visée est refermée : dans le noyau sans filets, le Gini reste à 0,33 (0,82 après la tâche 1
seule), les propriétaires détiennent 40 % de la richesse au lieu de 85 %, et la partie avec filets est meilleure
qu'à l'origine sur tous les indicateurs. Dans le modèle complet, le Gini s'améliore et les renflouements sont divisés
par 3, mais la faim et les sans-abri sont plus fréquents (graine 1 : 1 469 aides alimentaires, cause « pas de
producteur » ; plancher de logement « parc plein » à 95 %). Ce qui reste casse l'économie est la **fragilité des
chaînes à fournisseur unique** (tâche 2) : à 240 habitants, puits, mines, raffinerie, plastique, électronique et
machinerie tournent à 5–15 % de la capacité d'un seul employé ; avec leur coût désormais honnête (tâche 1), elles
vendent très cher ou meurent, et tout l'aval suit (tourisme, pêche, télé, logement). Le parc de machines fond
(429 → 231 en 200 jours dans la graine 42) parce que la Machinerie, dont les intrants viennent de ces entreprises,
vend 7 000 à 14 600 $ l'unité au lieu de 1 259 $ : plus personne n'investit. Les chocs « hélicoptère » et
« immigrants » ne se résorbent toujours pas.

### Tâche 8 — Caisse populaire (4 octobre 2026)

**Ce qui a changé :**

- **Capital de départ** : 100 $ par citoyen (`bankCapitalPerCitizen`, 24 000 $ pour 240 habitants, compté dans la
  masse de départ). Il couvre 11,5 % d'un encours de 870 $ par citoyen, bien au-delà des pointes observées
  (≈ 300 $ par citoyen). Avant, la Caisse n'avait aucun fonds propre et l'anti-crédit-fou refusait tout : c'est
  pourquoi elle ne prêtait rien dans le jeu.
- **Bénéfices retenus** : plus de ristourne tant que les fonds propres sont sous max(capital de départ,
  15 % de l'encours) (`bankTargetRatio` = 0,15, le niveau observé des grandes banques canadiennes, au-dessus du
  plancher de 11,5 % du filet).
- **Prime de risque** (`loanRate`) : taux = taux de base + 6 % × (dette / valeur des machines), soit jusqu'à +4,8 %
  à pleine garantie (`riskSpread` = 0,06). Elle entre dans les intérêts, le coût de revient et le calcul
  d'investissement.
- **Alerte « Caisse insolvable »** (fonds propres négatifs) dans le moniteur ; capital et fonds propres visés
  dans l'inspecteur de la Caisse.

**Résultats :** dans la partie par défaut (graine 42, filets actifs), la Caisse prête 55 000 $ en 100 jours sans
aucun refus, ses fonds propres restent à 24 000 $. Sur 5 graines avec filets, l'anti-crédit-fou passe de 67 à 17,5
déclenchements par 50 jours (presque tous sur les graines 3 à 5, où les radiations des entreprises mortes
consomment le capital). Sans filets, la Caisse se vide par radiations (16 500 → 200 $ en 300 jours) : l'alerte
« Caisse insolvable » suit cet état.

**Suite proposée** : tâche 2 (intrants mineurs non bloquants, achat de dépannage à l'extérieur), désormais la cause
dominante, puis tâche 5 (entrée et sortie d'entreprises) et tâche 3 (lissage des prix).

### Tâche 2 — Intrants mineurs non bloquants (5 octobre 2026)

Rapports : [`tache2-7-noyau.md`](tache2-7-noyau.md) et [`tache2-7-complet.md`](tache2-7-complet.md) (état final des tâches 2
et 7) ; étapes intermédiaires dans `tache2-complet.md` et `tache7-complet.md`.

**Ce qui a changé :**

- **Recettes : l'équipement sort des intrants par unité.** Un intrant par unité produite est ce que cette unité consomme
  vraiment. Les ordinateurs d'un bureau (ingénierie de CPU, marketing, école), le matériel d'un studio (télé :
  électronique) et les matériaux du parc immobilier (bois, acier par nuitée) étaient comptés comme consommés à chaque
  unité. C'est ce qui faisait dépendre le logement de toute la filière de l'acier : le noyau finissait à 100 % de
  sans-abri faute de 0,005 lingot par nuitée. L'équipement relève des machines et de leur entretien ; le bois et l'acier
  serviront à la construction (tâche 6).
- **Intrants secondaires non bloquants** (`softInputShare` = 15 %, avec la raison dans `model.dart`). Un intrant qui pèse
  moins de 15 % du coût d'un lot ralentit la cadence en proportion de son poids au lieu de l'arrêter : une pêcherie sans
  carburant pêche moins, elle ne ferme pas. Au-dessus, la recette reste stricte (farine du pain, pétrole du carburant).
- **Pas fait :** l'achat de dépannage à l'extérieur. Le commerce est coupé par défaut ; à reprendre avec la balance
  commerciale de la feuille de route (phase 4).
- **Fausse piste mesurée et annulée :** arrondir les effectifs de départ au supérieur. La population ne suffisait plus
  au recrutement initial (modèle complet sans filets : 59 % de chômage contre 38 %).

### Tâche 7 — Pénurie de main-d'œuvre : fonds de roulement (5 octobre 2026)

**Diagnostic** (graine 1) : quand le chômage tombe à 0 %, les employés de la ferme partent pour mieux payé. La ferme a des
clients qui attendent et vend au-dessus de son coût, mais la règle d'embauche exige 8 jours de salaires en caisse par
employé : sans poste ouvert, elle ne monte pas non plus son salaire. Les céréales manquent, la boulangerie s'arrête, et
l'anti-famine se déclenche. Le blocage n'est pas la vitesse des salaires, c'est la trésorerie.

**Ce qui a changé :**

- **Fonds de roulement** (rapport, v1.0). Une entreprise dont des clients repartent les mains vides peut emprunter à la
  Caisse 8 jours de salaires par poste qu'elle veut ouvrir, dans la limite de 15 jours de chiffre d'affaires
  (`workingCapitalDays`). À 30 jours, la Caisse devenait insolvable dans 4 graines sur 5.
- **Prudence de la Caisse.** Elle ne prête qu'à une entreprise rentable en moyenne, dont les ventes couvrent déjà les
  salaires. Avant, la règle d'achat de machines tolérait de petites pertes.
- **Bogue d'investissement corrigé.** Une entreprise dont l'équipe tourne sous 80 % de sa capacité n'achète plus de
  machine, et une machine « qui remplace du travail » ne compte plus quand il n'y a qu'un employé. Avant, des
  entreprises d'un employé à 10 % de leur capacité s'endettaient pour de la capacité inutile, puis faisaient défaut :
  90 % des pertes de la Caisse venaient de ces prêts pour machines.

**Comptes de la Caisse** (5 graines, 1 500 jours, filets actifs) : radiations de 30 000–70 000 $ avant ces corrections,
600–13 000 $ après ; les fonds propres ne descendent jamais sous 13 000 $ ; les intérêts couvrent les pertes.

**Résultats des tâches 2 et 7** (5 graines × 1 500 jours) :

| Indicateur | Noyau, origine | Noyau, après | Complet, origine | Complet, après |
|---|---|---|---|---|
| Sans filets : chômage moyen | 4,1 % | 4,4 % | 86,9 % | **8,1 %** |
| Sans filets : faim moyenne | 0,0 % | 0,0 % | 87,0 % | **6,4 %** |
| Sans filets : sans-abri moyen | 100 % | **0,1 %** | 95,9 % | **10,1 %** |
| Sans filets : Gini moyen | 0,25 | 0,35 | 0,59 | 0,63 |
| Avec filets : chômage moyen | 4,9–7,7 % | 2,4–4,1 % | 3,7–6,2 % | 4,0–10,0 % |
| Avec filets : faim moyenne | 0 % | 0 % | 0 % | 0–2,1 % ❌ |
| Avec filets : sans-abri moyen (pics) | 0 % | 0–0,3 % | 0,2–1,3 % (25–100 %) | 0,1–1,9 % (22–58 %) |
| Avec filets : Gini moyen | 0,46–0,63 | 0,12–0,19 | 0,28–0,45 | 0,17–0,40 |
| Renflouements / 50 j | 63,8 | 15,1 | 66,1 | 22,9 |
| Plancher de logement / 50 j | 0,0 | 0,3 | 12,7 | 3,0 |
| Anti-crédit-fou / 50 j | — | — | 67,1 | 0,0 |
| Anti-famine / 50 j | 0,0 | 0,0 | 0,0 | 14,4 ❌ |
| Chocs résorbés en < 200 j (sans / avec filets) | — | — | 0 / 5 | 1 / 7 |
| Écart comptable max | 0 exact | 0 exact | 0 exact | 0 exact |

**Lecture.** Le modèle complet ne s'effondre plus sans filets, et le noyau sans filets est presque aux critères de sortie
(chômage 3,2–5,3 %, faim et sans-abri sous 0,2 %, Gini 0,27–0,46). Avec filets, le logement est revenu au niveau
d'origine (pics divisés par deux, plancher de logement ÷ 4). Le nombre d'alertes critiques monte (142 contre 55) parce
qu'une économie qui ne s'effondre plus ouvre et ferme ses alertes au lieu de les garder ouvertes 1 300 jours.

**Régression restante : la faim avec filets** dans les graines 2 et 4 (1 373 et 567 aides alimentaires, cause « pas de
producteur »). Graine 2 : la pêcherie et le restaurant meurent vers le jour 350 et ne renaissent jamais ; au jour 800, à
0 % de chômage, la ferme perd des employés et le pain manque. Trois causes, pour les prochaines tâches :

1. **Pas d'entrée d'entreprises** : une entreprise morte ne renaît jamais (tâche 5).
2. **Usure des machines comptée au prix de remplacement actuel**, qui a explosé (1 300 $ → 7 000–14 600 $, la Machinerie
   étant sous-dimensionnée) : le coût de revient de toutes les petites entreprises équipées gonfle.
3. **Concurrence pour la main-d'œuvre au plein emploi** : les secteurs vitaux perdent leurs employés au profit de ceux qui
   paient mieux (problème connu n° 3 ; le fonds de roulement ne suffit pas quand l'entreprise n'est plus rentable).

### Tâche 5 — Entrée et sortie d'entreprises (5 octobre 2026)

Rapports : [`tache5-complet.md`](tache5-complet.md) (comparé à `tache2-7-complet.json`) et [`tache5-noyau.md`](tache5-noyau.md)
(noyau avec le module actif, comparé à `tache2-7-noyau.json`).

**Ce qui a changé** (module « Entrée et sortie d'entreprises », actif par défaut, coupé dans `--noyau`) :

- **Sortie.** Une entreprise sans employé depuis 30 jours (`exitIdleDays`) ferme : sa trésorerie revient au
  propriétaire, sa dette est radiée, sa place dans le graphe est libérée. Avant, elle restait en « zombie » avec un prix
  figé qui bloquait le marché (17 à 24 entreprises zombies en fin de partie sans filets ; 0 à 3 maintenant).
- **Entrée.** Un bien qui n'a plus de producteur et dont la demande non servie dépasse 10 % de la production d'un
  employé (`entryMinShare`) attire une nouvelle entreprise. Après le jour 100, une concurrente peut aussi naître quand
  les entreprises en place vendent à plus de 1,4 fois leur coût (`entryMarginRatio`) et laissent assez de demande
  non servie pour occuper un employé. Le fondateur est le citoyen le plus riche qui dispose de 1,5 fois le capital
  au-delà de son coussin ; le capital couvre 10 jours de salaires et 5 jours d'intrants ; au plus une création par
  jour, 60 jours entre deux créations d'un même type (`entryCooldown`).
- **Deux conditions ajoutées après mesure.** (1) Il faut assez de chômeurs ayant la qualification demandée : au plein
  emploi, une nouvelle entreprise ne fait que débaucher ses voisines (première version : 55 à 86 créations par partie,
  et les entreprises en place fermaient). (2) Viabilité : au prix que paie le marché (borné au double du prix mondial),
  les ventes attendues doivent couvrir l'équipe et ses intrants. Sans cette règle, les marchés trop petits pour un
  employé (cuivre, bauxite, or, puces) étaient recréés sans fin à petite échelle et à prix énormes : 317 créations et
  304 fermetures dans la graine 1, et l'effondrement des graines 1 et 3 sans filets.
- **Deux essais sur les intrants secondaires (tâche 2), mesurés puis abandonnés.** Les classer aux prix de référence
  (pain, viande et poisson devenaient tous secondaires : anti-famine 20,7 / 50 j) ; les déclarer dans chaque recette
  (anti-famine 72,9 / 50 j, effondrement des graines 2 et 3 sans filets). La règle d'origine (part du coût au prix du
  jour) reste la meilleure ; son défaut (le prix figé d'une entreprise morte rendait bloquant un intrant manquant) ne
  dure plus que 30 jours, puisque les entreprises mortes ferment.
- **Tests adaptés** : le test du god mode met en faillite une entreprise active (la raffinerie a pu fermer et
  renaître) ; le test des détecteurs coupe ce module (il teste les détecteurs, pas la résorption du chômage).

**Résultats** (5 graines × 1 500 jours) :

| Indicateur | Origine | Tâches 2 et 7 | Tâche 5 |
|---|---|---|---|
| Sans filets : chômage moyen | 86,9 % | 8,1 % | **5,3 %** (4,3–5,9 %) |
| Sans filets : faim moyenne | 87,0 % | 6,4 % | **1,2 %** |
| Sans filets : sans-abri moyen | 95,9 % | 10,1 % | **2,6 %** |
| Sans filets : Gini moyen | 0,59 | 0,63 | **0,38** |
| Avec filets : chômage moyen | 3,7–6,2 % | 4,0–10,0 % | 2,4–4,6 % |
| Avec filets : faim moyenne | 0 % | 0–2,1 % | 0–1,6 % |
| Avec filets : sans-abri moyen (pics) | 0,2–1,3 % (25–100 %) | 0,1–1,9 % (22–58 %) | 0,2–0,6 % (24–58 %) |
| Avec filets : Gini moyen | 0,28–0,45 | 0,17–0,40 | 0,15–0,29 |
| Anti-famine / 50 j | 0,0 | 14,4 | 4,8 |
| Renflouements / 50 j | 66,1 | 22,9 | 27,6 |
| Plancher de logement / 50 j | 12,7 | 3,0 | 2,7 |
| Plafond de dérive / 50 j | 226,5 | 303,0 | 262,3 |
| Chocs résorbés en < 200 j (sans / avec filets) | 0 / 5 | 1 / 7 | 3 / 6 |
| Écart comptable max | 0 exact | 0 exact | 0 exact |

Noyau avec le module actif, sans filets : chômage 2,6–4,3 %, faim 0 %, sans-abri ≤ 0,2 %, inflation 0,004 %/j.
Critères encore manqués : 33 alertes critiques (sauts d'inflation d'un jour, brefs épisodes de sans-abri), Gini trop
**bas** dans 3 graines (0,16–0,18, sous la borne de 0,2), chômage à 2,6 % dans une graine, renflouements (21,8 / 50 j)
et plafond de dérive (95,7 / 50 j).

**Restent à traiter :**

1. **Sauts d'inflation quotidienne** (alerte critique la plus fréquente) : quand le seul producteur d'un bien ferme ou
   qu'un nouveau arrive, le prix de référence du panier saute (tâche 3, lissage des prix).
2. **Renflouements en hausse** : le roulement des entreprises demande du capital ; à surveiller avec la tâche 3.
3. **Caisse insolvable sans filets** (graine 5, 839 jours) : le plancher de fonds propres n'est appliqué que par le
   filet anti-crédit-fou ; il devrait faire partie de la politique normale de la Caisse.
4. **Famine avec filets dans la graine 3** (575 aides) : concurrence pour la main-d'œuvre au plein emploi.
