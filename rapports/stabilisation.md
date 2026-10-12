# ÉcoNodes : état des lieux et plan de stabilisation

> Mise à jour du 10 octobre 2026 : nouvel état des lieux du modèle, des filets et des anomalies dans
> [`etat-des-lieux.md`](etat-des-lieux.md).

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

### Tâche 3 — Prix et salaires limités à la source (6 octobre 2026)

Rapport : [`tache3-complet.md`](tache3-complet.md) (comparé à `tache5-complet.json`).

**Diagnostic.** Dans l'état de la tâche 5, les entreprises voulaient changer leur prix de 5,5 % par jour en médiane
(27 % au 90e centile), surtout à la hausse et dans tous les secteurs : l'économie absorbait ses pénuries par des sauts
de prix, que le plafond de dérive (filet) bridait 262 fois par 50 jours. Par ailleurs, les sauts d'« inflation
quotidienne » (l'alerte critique la plus fréquente) venaient surtout des ordinateurs, qui ne se vendaient pas :
sans transaction, l'indice prenait le prix affiché, qui sautait quand le producteur fermait (5 039 → 1 560 $).

**Ce qui a changé :**

- **Limite quotidienne dans le comportement des entreprises** (`priceMaxDaily`, `wageMaxDaily` = 1,5 %/j, sous le
  plafond de 2 % du filet, qui devient un garde-fou). C'est la correction demandée par le cahier des charges
  (« les hausses de prix/salaires doivent être limitées par jour »).
- **Anti-emballement de la marge** (intégration conditionnelle). Sans lui, la limite faisait s'effondrer 3 graines
  sans filets : pendant que le prix était bridé, la marge visée continuait de monter (jusqu'à +300 %) et les prix
  grimpaient à la limite pendant des semaines (indice ×3,6 en 220 jours). Désormais, tant que le prix est bridé dans un
  sens, la marge visée cesse d'aller dans ce sens ; les hausses de coût continuent de se répercuter. Un premier essai
  (recaler la marge sur le prix affiché à chaque jour) était pire : il effaçait la répercussion des coûts.
- **Salaires : hausse quotidienne** tant que des postes restent vacants depuis 2 jours, dans la limite de 1,5 %/j
  (avant : un jour sur deux, par à-coups de 1,5 à 6 %). Mesuré : avec l'ancienne règle et les limites, chômage moyen
  sans filets de 43 % (effondrements) contre 9 %.
- **Indice des prix : sans transaction, on reprend le dernier prix observé** (pratique des instituts statistiques).

**Résultats** (5 graines × 1 500 jours) :

| Indicateur | Tâche 5 | Tâche 3 |
|---|---|---|
| Plafond de dérive / 50 j | 262,3 ❌ | **0,0** ✅ |
| Anti-famine / 50 j | 4,8 ❌ | **0,5** ✅ |
| Anti-crédit-fou / 50 j | 0,0 ✅ | 0,2 ✅ |
| Renflouements / 50 j | 27,6 ❌ | 25,7 ❌ |
| Plancher de logement / 50 j | 2,7 ❌ | 5,6 ❌ |
| Avec filets : chômage | 2,4–4,6 % | 3,1–5,3 % |
| Avec filets : faim moyenne | 0–1,6 % | **0–0,2 %** |
| Avec filets : sans-abri moyen | 0,2–0,6 % | 0–0,9 % |
| Sans filets : chômage moyen | **5,3 %** | 9,2 % (5,3–10,6 %) |
| Sans filets : faim moyenne | **1,2 %** | 5,7 % |
| Sans filets : sans-abri moyen | 2,6 % | 2,9 % |
| Sans filets : Gini moyen | 0,38 | 0,37 |
| Alertes critiques (sans filets) | 135 | 99 |
| Chocs résorbés en < 200 j (sans / avec filets) | 3 / 6 | 0 / 6 |
| Écart comptable max | 0 exact | 0 exact |

**Lecture.** Dans la partie avec filets, trois filets sur cinq sont désormais sous un déclenchement par 50 jours et la
faim a presque disparu. Sans filets, l'économie ne s'effondre plus nulle part, mais elle est moins bonne qu'à la tâche 5 :
des prix plus lents absorbent moins vite les pénuries. La faim sans filets est presque entièrement physique (« pas de
producteur ») : au départ, au plein emploi, la ferme ne trouve pas d'employés et ses prix montent trop lentement pour
surenchérir sur les salaires ; plus tard, la ferme a des clients qui attendent mais pas de trésorerie, et la Caisse ne
prête qu'aux entreprises rentables en moyenne. Avec filets, c'est le renflouement par le propriétaire qui débloque la
situation, d'où ses 25 déclenchements par 50 jours.

**Suite proposée :** un **apport en capital du propriétaire** comme comportement normal (et non comme filet) quand
une entreprise a des clients qui attendent, vend au-dessus de son coût et manque de trésorerie pour embaucher. C'est
la part « investissement » de ce que fait aujourd'hui le filet de renflouement ; elle devrait réduire à la fois la faim
sans filets et les renflouements.

*Mise à jour du 10 octobre :* l'état des lieux ([`etat-des-lieux.md`](etat-des-lieux.md)) montre que cet apport viserait
1 à 4 cas par partie ; la proposition est retirée. Ordre retenu : détecteurs de causes, hôpital, ferme.

### Détecteurs de causes (10 octobre 2026)

Rapports : [`detecteurs-complet.md`](detecteurs-complet.md) (comparé à `tache3-complet.json`) et
[`detecteurs-noyau.md`](detecteurs-noyau.md) (comparé à `tache3-noyau.json`).

Les détecteurs existants voyaient les conséquences (faim, sans-abri, chômage), pas les causes. Quatre détecteurs
ajoutés (`lib/engine/monitor.dart`), sans effet sur l'économie : les chiffres économiques des deux rapports sont
identiques à ceux de la tâche 3.

| Détecteur | Gravité | Condition | Agents indiqués |
|---|---|---|---|
| Santé de la population effondrée | critique | santé moyenne < 0,5 pendant 30 jours | chaque hôpital : employés et effectif voulu, visites produites et demandées, intrants qui manquent |
| Productivité du travail effondrée | attention | efficacité moyenne des employés < 0,7 pendant 30 jours | les facteurs (santé, faim, logement, moral), du plus pénalisant au moins pénalisant |
| Pénurie de main-d'œuvre | attention | postes voulus non pourvus > 10 % de la population pendant 30 jours | les entreprises auxquelles il manque le plus d'employés, avec leurs postes ouverts ou leur trésorerie |
| Prix aberrant | attention, par entreprise | prix > 5 fois le prix de référence pendant 30 jours | l'entreprise, son coût de revient, l'utilisation de son équipe, le manque d'intrants |

- **Santé classée critique** : c'est une détresse de la population, comme la faim. Conséquence : les alertes critiques
  sans filets passent de 99 à 104 (une par graine).
- **Prix de référence** : le prix d'équilibre du départ, corrigé de la hausse du salaire moyen (le travail est le
  principal coût). L'indice des prix ne convient pas : les prix aberrants le faussent eux-mêmes (anomalie A7).
- Le calcul de l'efficacité est découpé en facteurs (`efficiencyFactors`), avec le même résultat au bit près.
- Un test provoque les quatre détecteurs (11 tests).
- *Revu le jour même :* la pénurie de main-d'œuvre est scindée en deux détecteurs (voir « Corrections de mesure avant les
  institutions »). Le tableau ci-dessous donne la première définition.

**Ce qu'ils montrent** (modèle complet, sans filets ; ouvertures · jours-alerte) :

| Détecteur | g1 | g2 | g3 | g4 | g5 |
|---|---|---|---|---|---|
| Santé de la population effondrée | 1 · 1 329 j | 1 · 1 343 j | 1 · 1 280 j | 1 · 1 331 j | 1 · 1 354 j |
| Productivité du travail effondrée | 1 · 1 328 j | 1 · 1 343 j | 1 · 1 280 j | 1 · 1 331 j | 1 · 1 418 j |
| Pénurie de main-d'œuvre (première définition) | 14 · 433 j | 2 · 134 j | 10 · 385 j | 13 · 427 j | 7 · 1 017 j |
| Prix aberrant (jours-entreprise) | 21 · 2 830 j | 7 · 796 j | 11 · 987 j | 19 · 1 986 j | 24 · 2 626 j |

La santé passe sous 0,5 entre les jours 117 et 191 selon la graine et ne remonte jamais. La pénurie de main-d'œuvre s'ouvre
au démarrage dans toutes les graines (dès le jour 3 : les entreprises veulent environ 120 à 150 employés de plus) puis à chaque
famine. Dans le noyau (santé coupée), la graine 2 est en pénurie de main-d'œuvre presque toute la partie (1 469 jours) :
à examiner.

**Constat nouveau, en lisant les alertes : les dividendes sont versés même en perte.** Graine 5, sans filets : un
hôpital fondé au jour 280 avec 18 500 $ embauche 3 professionnels, mais ne peut presque rien produire (plus de
plastique). Il ne vend rien et verse pourtant ~1 000 $/j de dividendes à son fondateur : la règle verse 8 % par jour de
la trésorerie au-delà de 8 jours de coûts, sans condition de profit. Son capital lui revient en trois semaines ;
l'hôpital licencie, puis ferme au jour 310. Le scénario se répète à chaque création. C'est le même mécanisme que le
point 2 de l'anomalie A3 (la ferme) : à traiter à l'étape de l'hôpital ou de la ferme.

### Corrections de mesure avant les institutions (10 octobre 2026)

Rapports de référence : [`institutions-avant-complet.md`](institutions-avant-complet.md) (comparé à
`detecteurs-complet.json`) et [`institutions-avant-noyau.md`](institutions-avant-noyau.md) (comparé à
`detecteurs-noyau.json`). Aucune de ces corrections ne touche au modèle : les chiffres économiques sont identiques.

1. **Critère de chômage : « ≤ 10 % » au lieu de « 3–10 % »** (décision de Francis), dans les critères de sortie et
   dans la zone d'équilibre des chocs (`_inBand`). Un chômage bas n'est plus compté comme un déséquilibre. Effet : les
   chocs résorbés en moins de 200 jours avec filets passent de 6 à 11 sur 15 (complet) et de 1 à 8 (noyau) ; sans filets,
   de 0 à 0 (complet) et de 5 à 6 (noyau).
2. **Noyau de la tâche 3, même configuration que la tâche 5.** L'état des lieux comparait un noyau avec entrée et sortie
   d'entreprises actives (tâche 5) à un noyau sans (tâche 3). Relancé avec l'entrée active
   ([`tache3-noyau-entree.md`](tache3-noyau-entree.md)) : alertes critiques de 33 à **8**, et non 5. Texte corrigé dans
   `etat-des-lieux.md`.
3. **Pénurie de main-d'œuvre : deux comptes séparés.** Vérification dans le noyau, graine 2 : l'écart de 48 à 58 postes
   venait à 86–100 % d'entreprises sans employé ni trésorerie, qui ne ferment pas puisque l'entrée et la sortie sont
   coupées : Tourisme (41 à 43 postes voulus) et Ordinateurs (2 à 10). Aucun poste ouvert n'y restait non pourvu. Le
   détecteur est donc scindé :
   - **Pénurie de main-d'œuvre** : postes ouverts restés non pourvus au-delà de 5 % de la demande de travail (employés +
     postes non pourvus), pendant 30 jours. Repère : 5,7 %, le taux de postes vacants record au Canada (2ᵉ trimestre
     2022), période décrite comme une pénurie par Statistique Canada.
   - **Embauches bloquées faute de moyens** (nouveau) : postes voulus que l'entreprise n'ouvre pas faute d'avoir en caisse
     8 jours de salaire par employé (nouveaux compris), au-delà de 10 % de la population pendant 30 jours (le seuil de
     départ du détecteur de pénurie, qui mesurait surtout ce cas).

   Résultat, sans filets : la vraie pénurie n'apparaît qu'au démarrage (dans 4 graines sur 5, une alerte qui dure 2 à
   10 jours au-delà des 30 jours de persistance) ; les embauches bloquées s'ouvrent 2 à 12 fois par partie dans le modèle complet, et toute la
   partie dans la graine 2 du noyau (1 461 jours).

**Protocole : étape 2 bis.** `--sauf <filet>` ajoute une série « avec filets, sauf celui-là », pour le critère de réussite
des institutions (le filet que l'institution remplace coupé, l'économie doit tenir), avec ses propres critères dans le
rapport et ses moyennes dans le tableau avant/après. `--noyau` coupe les modules économiques ajoutés au modèle de base,
mais laisse actives les institutions (`Modules.noyau()`) : chacune est ainsi mesurée dans le noyau aussi.

**Méthode pour chaque institution.** Même code, interrupteur coupé (« avant ») puis actif (« après »), modèle complet et
noyau, avec l'étape 2 bis sur le filet visé. L'interrupteur coupé reproduit exactement le commit précédent.

### I1. Test de solvabilité des dividendes (10 octobre 2026)

Rapports : [`i1-dividendes-complet.md`](i1-dividendes-complet.md) et [`i1-dividendes-noyau.md`](i1-dividendes-noyau.md),
comparés au même code interrupteur coupé ([`i1-dividendes-avant-complet.md`](i1-dividendes-avant-complet.md),
[`i1-dividendes-avant-noyau.md`](i1-dividendes-avant-noyau.md)), avec l'étape « sauf renflouement ». L'interrupteur
coupé reproduit exactement la référence d'avant les institutions (mêmes chiffres).

**Ce qui a changé** (module `dividendTest`, actif par défaut). Avant, une entreprise versait chaque jour 8 % de sa
trésorerie au-delà de sa réserve, même en perte : un hôpital fondé avec 18 500 $ rendait son capital à son fondateur en
trois semaines. Désormais :

- pas de dividende si le bénéfice lissé est nul ou négatif ;
- pas de dividende qui laisserait en caisse moins que le seuil d'embauche des postes voulus (8 jours de salaire par
  employé, nouveaux compris, pour les postes que la règle d'embauche ouvrirait aujourd'hui, au plus 3) ;
- le dividende du jour ne dépasse pas le bénéfice lissé : min(8 % × excédent de trésorerie, bénéfice lissé).

**Paramètres.** Aucun nouveau : le taux de 8 % et le seuil de 8 jours existaient. Repère juridique vérifié : LCSA,
art. 42 (pas de dividende s'il y a des motifs raisonnables de croire que la société ne pourrait plus acquitter son passif
à échéance, ou que la valeur de réalisation de son actif deviendrait inférieure à son passif et à son capital déclaré).
Une variante est disponible, `dividendFromRetained` (faux par défaut), pour mesurer l'autre lecture de l'art. 42 b
(dividende ≤ bénéfices non répartis) ; elle demande de suivre les bénéfices non répartis (`Firm.retained`). Rapports de
la variante : [`i1-dividendes-variante-complet.md`](i1-dividendes-variante-complet.md) et
[`i1-dividendes-variante-noyau.md`](i1-dividendes-variante-noyau.md).

**Résultats** (5 graines × 1 500 jours) :

| Indicateur | Avant | I1 | Variante « bénéfices non répartis » |
|---|---|---|---|
| Sans filets : chômage moyen | 9,2 % | **8,2 %** | 8,9 % |
| Sans filets : faim moyenne | 5,7 % | **5,0 %** | 6,5 % |
| Sans filets : sans-abri moyen | 2,9 % | **1,5 %** | 2,6 % |
| Sans filets : Gini moyen | 0,37 | 0,33 | 0,39 |
| Sans filets : alertes critiques | 104 | 117 | 156 |
| Avec filets : chômage moyen | **4,0 %** | 7,8 % | 6,2 % |
| Renflouements / 50 j | **25,7** | 28,4 | 34,2 |
| Plancher de logement / 50 j | 5,6 | **1,0** | 10,1 |
| Anti-famine / 50 j | **0,5** | 1,5 | 3,5 |
| Sauf renflouement : chômage moyen | **7,3 %** | 8,6 % | 8,2 % |
| Sauf renflouement : faim moyenne | **3,4 %** | 5,0 % | 4,2 % |
| Chocs résorbés < 200 j (sans / avec filets) | 0 / **11** | 0 / 3 | 0 / 10 |
| Noyau : renflouements / 50 j | 19,8 | 13,4 | **10,9** |
| Noyau : alertes critiques (sans filets) | 5 | **1** | 5 |
| Noyau : chômage moyen (sans filets) | **5,0 %** | 5,2 % | 6,1 % |
| Écart comptable max | 0 exact | 0 exact | 0 exact |

Mesures ciblées (sonde, 5 graines) : sans filets, les dividendes versés par des entreprises en perte passent de 0,5 à
1,5 M$ par partie à 0, et les hôpitaux créés de 16–22 à 8–17 par partie. Avec filets, l'hôpital est renfloué autant
qu'avant (131–295 fois par partie avant, 54–337 après) : il perd de l'argent pour d'autres raisons (A8), que vise I2.

**Lecture.**

- **Sans filets, I1 réduit la détresse** : plus d'alerte « chômage très élevé » (3 graines avant), jours de faim
  répandue de 800 à 523, jours de sans-abri nombreux de 1 065 à 528. Les alertes critiques augmentent quand même, à
  cause de sauts d'inflation d'un jour (4 → 34) : à revoir avec les prix aberrants (A7).
- **Avec filets, l'économie se dégrade, parce que l'argent reste coincé dans les entreprises.** Graines 1 à 3 :
  1,0 à 1,17 M$ dans les entreprises au lieu de 0,64 à 0,76, et 0,30 à 0,45 M$ chez les ménages au lieu de 0,67 à 0,77.
  La règle « dividende ≤ bénéfice lissé » empêche de distribuer une trésorerie accumulée en période faste. Exemple : le
  bar garde 300 000 $ pour un bénéfice de ~1 000 $/j, alors que l'ancienne règle aurait versé 8 % de l'excédent par jour.
  Moins de revenus de dividendes, c'est moins de dépenses de loisirs, donc plus de chômage.
- **La variante « bénéfices non répartis » ne règle pas le problème** : elle libère cette trésorerie et garde les chocs
  résorbés avec filets (10 sur 15), mais elle est la pire sans filets. Aucune des deux lectures ne domine ; la règle du
  cahier des charges reste celle par défaut.

**Critère de réussite.**

- Renflouement coupé : chômage ≤ 10 % dans toutes les graines ✅, mais faim > 2 % dans toutes les graines ❌ (c'était
  déjà le cas avant ; 3,4 % → 5,0 %).
- Avec filets, renflouements sous 1 par 50 jours : ❌ (25,7 → 28,4).
- Indicateurs sans filets non dégradés : ✅ pour le chômage, la faim, les sans-abri et le Gini ; ❌ pour le nombre
  d'alertes critiques (sauts d'inflation).

I1 supprime les dividendes versés en perte (la boucle des hôpitaux) et retient la trésorerie des entreprises qui veulent
embaucher (point 2 de A3). Il ne suffit pas à remplacer le renflouement, et il fait apparaître un nouveau défaut : la
trésorerie accumulée des entreprises ne recircule plus.

### I2. Enveloppe budgétaire de l'hôpital et de l'école (10 octobre 2026)

Rapports : [`i2-enveloppe-complet.md`](i2-enveloppe-complet.md) et [`i2-enveloppe-noyau.md`](i2-enveloppe-noyau.md),
comparés au même code interrupteur coupé (`i2-enveloppe-avant-*.md`), étape « sauf renflouement ».

**Ce qui a changé** (module `publicBudget`, actif par défaut ; ne joue que si la santé, ou l'éducation, publique est
active) :

- **Établissements publics.** L'hôpital et l'école appartiennent à l'État : pas de propriétaire, pas de dividende, pas de
  renflouement par un citoyen, pas d'emprunt à la Caisse, pas de fermeture faute d'employés, pas de concurrent privé.
- **Enveloppe.** Chaque jour, l'État porte leur trésorerie à 10 jours du coût de l'équipe nécessaire (salaires, intrants
  au prix du marché, services). Il rembourse ainsi ce qu'ils ont dépensé, dans la limite de ce coût. Un budget non dépensé
  (plus de 1,5 fois cette trésorerie) revient au trésor. Si le trésor ne suffit pas (au-dessus de son plancher de
  9 600 $), toutes les enveloppes baissent dans la même proportion.
- **Gratuité et file d'attente.** Soins et cours publics sont gratuits et n'ont plus de prix (ils sortent de l'indice
  des prix des ménages). Un malade (santé < 0,75) ou un citoyen qui veut un cours s'inscrit dans la file ; chaque jour,
  la capacité produite sert la file par ordre d'arrivée (jusqu'à 3 visites par malade). Ce qui reste à servir est la
  demande non servie de l'établissement : c'est son signal d'embauche.
- **Mesure et affichage.** Attente moyenne (des derniers servis, ou des personnes en file si elle est plus longue),
  longueur de la file, enveloppe du jour et jours d'enveloppe incomplète, dans l'inspecteur de l'établissement et dans
  celui de l'État. Nouveau détecteur « Attente trop longue (service public) » : attente moyenne > 7 jours pendant 30 jours.

**Paramètres et raisons.**

- `publicCashDays` = 10 jours. La règle d'embauche exige 8 jours de salaire par employé en caisse ; 2 jours de plus
  laissent une marge pour les intrants et les services.
- Seuil d'attente : 7 jours. Les maladies et les envies de cours arrivent au hasard, une file d'un ou deux jours est
  normale ; au-delà d'une semaine en moyenne, la capacité ou l'enveloppe est durablement insuffisante.
- Repère : au Canada, les hôpitaux sont surtout financés par un budget global de la province (Fraser Institute, 2021),
  et non à la visite.

**Correction pendant la mise au point.** La première version finançait l'équipe théorique de toute la demande (jusqu'à
225 employés pour 670 visites demandées). Un hôpital qui ne pouvait pas embaucher, faute d'électronique et de
plastique, accumulait l'argent du trésor : 500 000 $ dans la graine 5, et le trésor de l'État vidé. L'enveloppe couvre
désormais l'équipe que la règle d'embauche permet de constituer (effectif actuel plus les postes ouverts aujourd'hui) et
les intrants de ce qu'elle peut produire.

**Résultats** (modèle complet, 5 graines × 1 500 jours ; le noyau est inchangé, la santé et l'éducation y étant coupées) :

| Indicateur | Avant (I1) | I2 |
|---|---|---|
| Avec filets : renflouements de l'hôpital / 50 j | 8,1 | **0** ✅ |
| Avec filets : renflouements / 50 j (toutes entreprises) | 28,4 | **16,8** |
| Avec filets : chômage moyen | 7,8 % | 7,2 % |
| Avec filets : santé moyenne | 0,73 | 0,73 |
| Avec filets : anti-famine / 50 j | 1,5 | 6,0 |
| Sauf renflouement : faim moyenne | 5,0 % | **2,6 %** |
| Sauf renflouement : santé moyenne | 0,12 | **0,28** |
| Sauf renflouement : chômage moyen | 8,6 % | 9,4 % (g1 12,1 %, g3 12,3 %) |
| Sans filets : chômage moyen | 8,2 % | 22,2 % ❌ |
| Sans filets : faim moyenne | 5,0 % | 20,2 % ❌ |
| Sans filets : sans-abri moyen | 1,5 % | 16,9 % ❌ |
| Sans filets : santé moyenne | 0,13 | 0,20 |
| Sans filets : attente moyenne à l'hôpital | — | 497 jours |
| Chocs résorbés < 200 j (sans / avec filets) | 0 / 3 | 3 / 3 |
| Écart comptable max | 0 exact | 0 exact |

**Lecture.**

- **Avec filets, I2 fait ce qui était visé.** L'hôpital n'est plus renfloué (8,1 → 0 par 50 jours). Les renflouements
  totaux baissent de 41 %, la santé moyenne reste à 0,73. Dans la graine 1 (sonde), la file compte 0 à 3 personnes et
  l'attente reste sous un jour.
- **Sans filets, l'économie est plus mauvaise, surtout à cause de la graine 4.** Elle s'effondre définitivement après
  une famine au jour 384 : 76 % de chômage, faim et sans-abri à près de 80 %. Les autres graines se partagent : la
  graine 5 s'améliore nettement (faim 5,3 → 0,1 %), la graine 1 se dégrade (chômage 7,3 → 11,0 %).
- **Huit graines de plus (6 à 13), sans filets** : aucun effondrement, mais chômage 6,9 → 8,7 % et faim 4,7 → 6,6 % en
  moyenne ; la santé passe de 0,12 à 0,19. En séparant les deux moitiés, c'est l'hôpital qui coûte : chômage 8,2 →
  11,2 %, contre 7,9 → 8,0 % pour l'école.
- **Le mécanisme mesuré : l'argent se déplace vers les entreprises.** Avec I2 (graines 6 à 13, sans filets), la dépense
  des ménages baisse de 11 % (57 800 → 51 500 $/j). Les entreprises gagnent 74 000 $ de trésorerie, l'État en perd 30 000
  et les ménages 40 000. Sans filets, l'hôpital reste privé d'électronique et de plastique (anomalie A2) : il produit 0 à 2
  visites par jour pour une file de 240 personnes. L'enveloppe paie donc surtout des professionnels qui ne peuvent pas
  soigner (graine 4 : 9 embauchés et 130 000 $ en 50 jours, puis licenciés), et des intrants vendus à des prix aberrants.
  Cet argent public finit dans des entreprises qui, depuis I1, ne le redistribuent plus.

**Critère de réussite.**

- Renflouement coupé : chômage ≤ 10 % ❌ (g1, g3), faim < 2 % ❌ (g1 à g4), même si la faim passe de 5,0 à 2,6 %.
- Avec filets, l'hôpital n'est plus renfloué ✅ ; les renflouements, toutes entreprises confondues, restent au-dessus
  de 1 par 50 jours ❌ (16,8).
- Indicateurs sans filets non dégradés : ❌.

I2 remplace le renflouement de l'hôpital là où l'hôpital peut fonctionner. Sans filets, il bute sur A2 : un hôpital
financé mais privé d'intrants ne soigne pas, et son enveloppe nourrit la trésorerie bloquée relevée en I1. Les deux
suites possibles relèvent de décisions réservées : importations de dépannage (A2) et usure de la santé sans maladie.

### I3. Assurance-emploi indexée, puis aide sociale (10 octobre 2026)

Rapports : [`i3-assurance-complet.md`](i3-assurance-complet.md) et [`i3-assurance-noyau.md`](i3-assurance-noyau.md),
comparés au même code interrupteur coupé (`i3-assurance-avant-*.md`), étape « sauf anti-famine » (I3 vise la part
« pas de revenu » de ce filet).

**Ce qui a changé** (module `insurance`, actif par défaut ; il remplace la prestation fixe de 80 $/j) :

- **Cotisation** prélevée avec l'impôt sur chaque salaire : 3,94 % de la rémunération assurable, plafonnée au salaire
  moyen. Le salaire étant le coût total du travail dans le modèle, la part de l'employeur est supportée par le salaire.
- **Demande de prestations** au premier jour sans emploi, si le citoyen a au moins 84 jours d'emploi assurable depuis
  sa dernière demande : 55 % de son dernier salaire, plafonné à 55 % du salaire moyen.
- **Durée** fixée à la demande selon le chômage du jour : 252 jours (36 semaines) à 6 % ou moins, jusqu'à 315 jours
  (45 semaines) à 16 % et plus, en ligne droite entre les deux.
- **Aide sociale** ensuite, ou sans emploi assurable suffisant : le panier de survie du jour (`needCost` : l'aliment le
  moins cher par point de faim et une nuitée).
- **Trésor insuffisant** : toutes les prestations baissent dans la même proportion. Nouveau détecteur « Prestations
  réduites faute de trésor » (dans les deux régimes, pour comparer). Compte des opérations (cotisations, prestations,
  aide sociale) dans l'inspecteur de l'État, comme le compte notionnel canadien de l'assurance-emploi.

**Paramètres et sources** (régime canadien de 2025, canada.ca ; un jour de jeu = un jour) :

- `eiReplacement` = 0,55 : taux de base des prestations régulières, 55 % de la rémunération assurable.
- `eiInsurableCap` = 1,0 × le salaire moyen : maximum de la rémunération assurable de 65 700 $ par an, soit ~1 263 $ par
  semaine, à peu près la rémunération hebdomadaire moyenne (1 293 $ en mai 2025, Statistique Canada).
- `eiRate` = 3,94 % : 1,64 $ par 100 $ pour l'employé, 1,4 fois plus pour l'employeur (2,296 $).
- `eiDaysLow` = 252 et `eiDaysHigh` = 315 : 36 semaines à 6 % de chômage ou moins, 45 semaines à 16 % et plus, pour un
  emploi à plein temps toute l'année (1 820 heures et plus ; Loi sur l'assurance-emploi, annexe I).
- `eiQualifyingDays` = 84 : 420 heures d'emploi assurable au minimum, soit 12 semaines à 35 heures.

**Résultats** (5 graines × 1 500 jours) :

| Indicateur | Avant (I1 + I2) | I3 |
|---|---|---|
| Sans filets : chômage moyen | 22,2 % | **8,7 %** |
| Sans filets : faim moyenne | 20,2 % | **5,0 %** |
| Sans filets : sans-abri moyen | 16,9 % | **2,4 %** |
| Sans filets : santé moyenne | 0,20 | 0,33 |
| Sans filets : jours de prestations réduites (5 graines) | 1 283 | **0** |
| Sans filets : trésor de l'État le plus bas | 6 $ | **66 148 $** |
| Sans filets : jours de faim répandue / de sans-abri nombreux | 1 574 / 1 631 | 520 / 745 |
| Sans filets : alertes critiques | 129 | 137 |
| Avec filets : anti-famine / 50 j | 6,0 | **0,14** ✅ |
| Avec filets : renflouements / 50 j | 16,8 | 13,4 |
| Avec filets : plancher de logement / 50 j | 0,01 | 9,9 ❌ |
| Avec filets : chômage moyen | 7,2 % | 8,0 % |
| Avec filets : santé moyenne | 0,73 | **0,87** |
| Sauf anti-famine : faim moyenne | 0,4 % | **0,0 %** |
| Sauf anti-famine : chômage moyen | 7,2 % | 8,0 % (g1 10,4 %, g4 10,1 %) |
| Chocs résorbés < 200 j (sans / avec filets) | 3 / 3 | 0 / 4 |
| Noyau, sans filets : chômage moyen | 5,2 % | 4,3 % |
| Noyau : renflouements / 50 j | 13,4 | 8,9 |
| Écart comptable max | 0 exact | 0 exact |

**Lecture.**

- **I3 règle l'effondrement de fin de partie (A4).** Le trésor ne se vide plus (66 000 $ au plus bas, contre 6 $) et
  les prestations ne sont plus jamais réduites (1 283 jours avant). La graine 4, qui s'effondrait définitivement depuis
  I2, tient : sonde, chômage de 8 à 19 %, trésor jamais sous 83 000 $. Les cotisations dépassent les prestations
  (graine 4 : 2,75 M$ contre 1,96 M$), et l'excédent rejoint le trésor général.
- **L'anti-famine passe sous 1 déclenchement par 50 jours** (6,0 → 0,14), et la faim disparaît quand on coupe ce filet.
- **Effet secondaire : des sans-logis à l'aide sociale.** Le plancher de logement passe de 0,01 à 9,9 déclenchements par
  50 jours (89 % « prix trop élevé » ; graines 1 et 4 surtout). Ces sans-logis touchent l'aide sociale (graine 1 : 1 882
  jours-sans-logis sur 2 208). Le panier de survie (14 à 63 $/j selon la graine et le moment) est plus bas que l'ancienne prestation fixe
  (80 $/j), et
  il suppose l'aliment le moins cher par point de faim. Or un ménage choisit ses aliments selon ses goûts, et il mange
  avant de se loger. Exemple, graine 1 : un bénéficiaire reçoit 36 à 49 $/j, en dépense 38 à 42 en nourriture, et ne peut
  plus payer la nuitée à 9,60 $, alors que 12 nuitées restent invendues.

**Critère de réussite.**

- Anti-famine coupé : faim et sans-abri < 2 % ✅ ; chômage ≤ 10 % ❌ de justesse (g1 10,4 %, g4 10,1 %).
- Avec filets, anti-famine sous 1 par 50 jours ✅ (0,14).
- Indicateurs sans filets non dégradés : ✅ (chômage, faim, sans-abri, santé, trésor), sauf le nombre d'alertes
  critiques (129 → 137 : plus d'épisodes, beaucoup plus courts).

Suite possible, hors de ce mandat : une aide sociale qui couvre le panier tel que les ménages le composent, ou un choix
des aliments qui tienne compte du loyer quand l'argent manque.

### I4. Règles prudentielles dans la politique de la Caisse (10 octobre 2026)

Rapports : [`i4-caisse-complet.md`](i4-caisse-complet.md) et [`i4-caisse-noyau.md`](i4-caisse-noyau.md), comparés au
même code interrupteur coupé (`i4-caisse-avant-*.md`), étape « sauf anti-crédit-fou ».

**Ce qui a changé** (module `bankRegulation`, actif par défaut) :

- Les deux règles de l'anti-crédit-fou s'appliquent toujours, avec ou sans filet. Fonds propres de la Caisse d'au moins
  11,5 % des prêts (prêt demandé compris) ; paiements de la dette d'un emprunteur d'au plus 35 % de sa valeur ajoutée.
- Le filet devient un détecteur : quand il est actif, il compte les refus (le même nombre qu'avant) mais n'a plus d'effet
  propre. La Caisse compte ses refus (`BankAccount.refusals`), affichés dans son inspecteur, avec un interrupteur.
- Aucun paramètre nouveau : les seuils de 11,5 % et 35 % existaient (11,5 % : ratio de fonds propres attendu des grandes
  banques).

**Résultats** (modèle complet ; le noyau est inchangé, le crédit y étant coupé) :

| Indicateur | Avant (I1 à I3) | I4 |
|---|---|---|
| Avec filets : tous les indicateurs | — | identiques (le filet appliquait déjà ces règles) |
| Sauf anti-crédit-fou : chômage / faim / sans-abri | 8,0 % / 0,0 % / 0,3 % | identiques |
| Sans filets : jours de Caisse insolvable (5 graines) | 1 303 | 1 303 ❌ |
| Sans filets : fonds propres les plus bas | −13 814 $ | **−4 285 $** |
| Sans filets : prêts refusés | 0 | 235 |
| Sans filets : créances radiées (moyenne par partie) | 18 076 $ | 16 057 $ |
| Sans filets : chômage / faim / sans-abri, graine 5 | 4,4 % / 0,5 % / 0,5 % | 6,8 % / 9,1 % / 5,1 % |
| Sans filets : graines 1 à 4 | — | identiques (aucun refus) |
| Écart comptable max | 0 exact | 0 exact |

**Lecture.**

- **Avec filets, rien ne change** : les règles sont celles que le filet appliquait. Coupé, le filet ne manque plus.
- **Sans filets, une seule graine est concernée, la 5, et la Caisse y reste insolvable.** Pendant la crise du
  démarrage, elle perd 26 600 $ sur 65 900 $ prêtés, alors que ses fonds propres respectent encore le plancher. Au jour
  198, une radiation de 5 910 $ les fait passer sous zéro. Les règles bloquent alors tout nouveau prêt (235 refus).
  Sans prêts, la Caisse ne touche plus d'intérêts et ne peut pas reconstituer ses fonds propres : elle reste à −4 267 $
  jusqu'à la fin. Sans les règles, elle continuait de prêter : ses pertes se creusaient (−13 814 $), mais le crédit
  soutenait l'économie. Avec les règles, la graine 5 perd ce soutien (faim 0,5 → 9,1 %).

**Critère de réussite.**

- Anti-crédit-fou coupé, l'économie tient comme avec filets ✅ ; chômage ≤ 10 % ❌ (g1 10,4 %, g4 10,1 %, comme avant).
- Avec filets, l'anti-crédit-fou reste à 0 déclenchement par 50 jours ✅.
- Indicateurs sans filets non dégradés : ❌ dans la graine 5 ; Caisse jamais insolvable : ❌.

Un plancher de fonds propres limite les pertes ; il n'empêche pas l'insolvabilité quand les défauts arrivent dans les
limites permises, et il ne dit pas comment une Caisse insolvable se recapitalise. Il manque une provision pour pertes ou
une procédure de résolution (recapitalisation par les membres, assurance-dépôts), hors du mandat de I1 à I5. La faillite
ordonnée (I5) vise une partie de ces radiations : la dette remboursée par la trésorerie des entreprises qui ferment.

### I5. Faillite ordonnée (10 octobre 2026)

Rapports : [`i5-faillite-complet.md`](i5-faillite-complet.md) et [`i5-faillite-noyau.md`](i5-faillite-noyau.md),
comparés au même code interrupteur coupé (`i5-faillite-avant-*.md`). I5 ne remplace pas de filet : pas d'étape « sauf ».

**Ce qui a changé** (module `bankruptcy`, actif par défaut) : quand une entreprise ferme (`_close`, faute d'employés
depuis 30 jours) ou est supprimée par le god mode (`removeFirm`), sa trésorerie rembourse d'abord sa dette envers la
Caisse. C'est un remboursement de capital ordinaire : la monnaie est détruite, et `ledgerCredit`, `bank.repaid` et
`dayFlows.repaid` sont mis à jour. Seul le solde impayé est radié. Le reste de la trésorerie va au propriétaire ou, s'il
n'y en a pas, à l'État (avant, `removeFirm` détruisait cet argent par le god mode). Le bogue corrigé : la dette était
radiée avant que la trésorerie revienne au propriétaire, si bien que l'argent d'un prêt finissait chez lui et que la
Caisse encaissait la perte. Aucun paramètre. Test ajouté : fermeture d'une entreprise endettée, remboursement et
radiation exacts, invariants à 0 au bit près.

**Résultats** (modèle complet ; avec filets et dans le noyau, tous les indicateurs sont identiques) :

| Indicateur, sans filets | Avant (I1 à I4) | I5 |
|---|---|---|
| Chômage moyen | 9,2 % | 8,0 % |
| Faim moyenne | 6,7 % | 5,5 % |
| Sans-abri moyen | 3,3 % | 2,0 % |
| Gini moyen | 0,37 | 0,32 |
| Alertes critiques | 154 | 135 |
| Chocs résorbés < 200 j | 0 | 3 |
| Jours de Caisse insolvable | 1 303 | 1 277 |
| Fonds propres les plus bas | −4 285 $ | −2 177 $ |
| Créances radiées (moyenne par partie) | 16 057 $ | 18 668 $ |
| Trésor de l'État le plus bas | 66 148 $ | 12 931 $ |
| Écart comptable max | 0 exact | 0 exact |

Mesure ciblée (sonde, 5 graines sans filets) : les entreprises qui ferment endettées (2 à 9 par partie) n'ont plus que
0,3 à 5,5 k$ de trésorerie pour 7,8 à 29 k$ de dette. La faillite ordonnée rembourse donc 0,3 à 4,8 k$ par partie.

**Lecture.**

- **I5 corrige l'ordre des comptes, mais son effet direct est petit.** Une entreprise ne ferme qu'après 30 jours sans
  employé, et sa trésorerie est presque vide à ce moment-là. Ce que la Caisse récupère est faible devant ce qu'elle
  radie : environ 7 % de la dette des entreprises qui ferment (1 à 19 % selon la graine).
- **Les écarts des indicateurs viennent surtout de trajectoires qui divergent.** Quelques milliers de dollars détruits
  au lieu d'être versés à un propriétaire suffisent à changer la suite de la partie (graine 1 : chômage 9,4 → 5,8 % ;
  graines 2 à 4 : davantage de fermetures endettées, d'où des radiations plus élevées). Avec I4, seule la graine où la
  règle mordait avait bougé. Il faut donc lire les petits effets de toutes les institutions avec prudence : sur 5
  graines, la sensibilité de l'économie aux perturbations pèse autant que l'effet mesuré. Plus de graines
  départageraient.

**Critère de réussite.** Pas de filet remplacé. Indicateurs sans filets non dégradés ✅ (tous meilleurs, sauf le trésor
le plus bas, dans une graine, et les radiations) ; invariants exacts ✅ ; Caisse toujours insolvable dans la graine 5 ❌
(voir I4).

**Interface** (vérifiée dans la version web : liste des modules, fiche de l'hôpital public, vues de l'État et de la
Caisse). Deux retouches : un service public affiche « gratuit » au lieu d'un prix ; la confirmation de fermeture d'une
entreprise décrit la faillite ordonnée.

### Bilan des institutions I1 à I5 (10 octobre 2026)

Référence avant les institutions ([`institutions-avant-complet.md`](institutions-avant-complet.md)) comparée à l'état
après I5 ([`i5-faillite-complet.md`](i5-faillite-complet.md)), 5 graines × 1 500 jours :

| Indicateur | Avant les institutions | Après I5 |
|---|---|---|
| Sans filets : chômage moyen | 9,2 % | 8,0 % |
| Sans filets : faim moyenne | 5,7 % | 5,5 % |
| Sans filets : sans-abri moyen | 2,9 % | 2,0 % |
| Sans filets : Gini moyen | 0,37 | 0,32 |
| Sans filets : alertes critiques | 104 | 135 |
| Avec filets : chômage moyen | 4,0 % | 8,0 % |
| Avec filets : renflouements / 50 j | 25,7 | 13,4 |
| Avec filets : anti-famine / 50 j | 0,48 | 0,14 |
| Avec filets : plancher de logement / 50 j | 5,6 | 9,9 |
| Avec filets : anti-crédit-fou / 50 j | 0,19 | 0 |
| Chocs résorbés < 200 j (sans / avec filets) | 0 / 11 | 3 / 4 |
| Noyau : chômage moyen (sans filets) | 5,0 % | 4,3 % |
| Noyau : renflouements / 50 j | 19,8 | 8,9 |
| Noyau : alertes critiques (sans filets) | 5 | 2 |
| Écart comptable max | 0 exact | 0 exact |

**Ce qui marche.** L'assurance-emploi (I3) est la seule institution qui transforme l'économie sans filets : plus
d'effondrement de fin de partie, trésor jamais vide, anti-famine sous 1 par 50 jours. L'enveloppe (I2) supprime les
renflouements de l'hôpital là où il peut soigner. Les renflouements baissent de moitié dans le modèle complet et dans le
noyau. L'anti-crédit-fou ne sert plus (I4).

**Ce que les institutions ont fait apparaître** (à décider avant d'aller plus loin) :

1. **Trésorerie bloquée dans les entreprises** (I1). La règle « dividende ≤ bénéfice lissé » empêche de distribuer une
   trésorerie accumulée. Avec filets, le chômage double (4,0 → 8,0 %) et les chocs résorbés passent de 11 à 4. La
   variante « bénéfices non répartis » libère cet argent mais dégrade l'économie sans filets.
2. **L'hôpital sans intrants** (I2, anomalie A2). Sans filets, il reste privé d'électronique et de plastique : la file
   d'attente atteint 240 personnes, et l'enveloppe paie des professionnels qui ne peuvent pas soigner. Décision réservée :
   importations de dépannage.
3. **L'aide sociale au panier de survie laisse des sans-logis** (I3) : plancher de logement à 9,9 par 50 jours.
4. **La Caisse ne se recapitalise pas** (I4) : une fois insolvable, elle ne prête plus, ne touche plus d'intérêts et reste
   insolvable (graine 5).
5. **Mesure.** Sur 5 graines, la sensibilité de l'économie aux petites perturbations pèse autant que l'effet des petites
   institutions (I5) : plus de graines départageraient.

## 5. Outils de mesure

### Tâche 1 — Flux de hasard indépendants (11 octobre 2026)

Aucune règle économique ne change. Référence : Klein et al. 2024, « Noise-free comparison of stochastic agent-based
simulations using common random numbers » (arXiv 2409.02086).

**Pourquoi.** Avec un seul générateur tiré dans l'ordre des appels, toute différence dans le nombre de tirages (une
entreprise qui ferme, une épidémie sans effet) décalait tous les tirages suivants. Comparer deux règles sur une même
graine revenait donc à comparer deux parties différentes.

**Ce qui a changé.**

- **Tirages.** `draw(flux, id, sous-tirage)` ne dépend que de (graine, flux, jour, agent, sous-tirage), jamais de l'ordre
  des appels : Mulberry32 initialisé par `hash32(hash32(hash32(hash32(graine, code du flux), jour), id), sous-tirage)`.
  `hash32` est une étape de MurmurHash3 suivie de son brassage final, avec la même arithmétique 32 bits que Mulberry32
  (masques, multiplication en deux moitiés de 16 bits).
- **16 flux** (`enum Flux`) : traits, classes, recrutement, propriétaire, embauche, départ, maladie, ordinateur, études,
  loisirs, consommation, achats, capital, offres, prix, divin. Chacun a un code fixe : en ajouter un ne change pas les
  tirages des autres. La création d'entreprise n'a pas de flux, car elle ne tire rien (le fondateur est le citoyen le
  plus riche).
- **Sous-tirages**, quand une même décision tire plusieurs fois pour un même agent le même jour :
  - traits : qualification, argent, ambition, ordinateur, nom ;
  - gravité de la maladie ;
  - loisirs : désir × 64 + rang de l'achat ;
  - prix : rang du bien ;
  - offres : (acheteur, bien, n-ième achat de ce bien dans la journée, vendeur) ;
  - god mode : numéro de l'action.

  Quand l'État achète pour un citoyen (aide alimentaire, abri, soins, cours), les tirages sont ceux de ce citoyen.
- **Ordres du jour.** Les 5 mélanges de Fisher-Yates (premier recrutement, chômeurs, achats des entreprises, passage des
  ménages, phase du capital) et la répartition des qualifications au départ sont remplacés par un tri selon une clé
  hachée (graine, flux, jour, id). Retirer un agent ne change pas l'ordre relatif des autres.
- **Identifiants stables, jamais réutilisés.** Les citoyens sont numérotés à partir de 1. Une entreprise reçoit
  100 000 + 10 000 × (rang de son type) + (rang de création dans ce type). Avant, citoyens et entreprises partageaient
  un compteur : une entreprise créée en plus décalait les identifiants, donc les tirages, de tous les agents créés
  ensuite.
- **`math.pow` retiré du gain technologique.** Il est remplacé par des multiplications successives. Mesuré :
  `math.pow(1,15, 3)` diffère d'un bit entre la VM et JavaScript (…dd2d contre …dd2e). Une entreprise au niveau
  technologique 4 aurait fait diverger le web et Android.

**Tests** (23, tous verts sur la VM ; les 16 tests existants passent sans modification) :

- valeurs de référence de `hash32` et des tirages, et empreinte d'une partie de 150 jours (`test/hasard_test.dart`) ;
- 10⁵ tirages par flux : moyenne à moins de 0,005 de 0,5, variance à moins de 0,002 de 1/12 ; corrélation entre deux
  flux et entre agents voisins sous 0,015 (écart type attendu : 0,003) ;
- ordre du jour : retirer un agent ne change pas l'ordre des 299 autres ;
- les tirages d'un agent ne dépendent pas de la taille de la population ;
- une institution qui ne mord jamais (I4 sans crédit, I2 sans santé ni éducation) : partie identique au tirage près sur
  600 jours ;
- une épidémie qui ne frappe personne : partie identique sur 300 jours. Avec l'ancien générateur, ses 240 tirages
  décalaient toute la suite.

**Parité VM / web.** `tool/parite.dart` affiche des hachages, 16 tirages, et l'empreinte jour par jour de deux parties
de 400 jours, les nombres écrits bit à bit. Les sorties sont identiques sur la VM et en JavaScript (dart2js, en `-O2` et
en `-O4` comme `flutter build web`, exécuté par Node 25). `flutter test --platform chrome` n'a pas pu tourner : ce poste
n'a pas Chrome, et le lanceur de tests ne se connecte pas à Edge. Android (Dart compilé à l'avance) n'a pas été lancé
sur un appareil ; il a la même arithmétique que la VM.

**Ce que les flux indépendants changent aux comparaisons, mesuré.** 10 graines, sans filets, 1 500 jours : chaque partie
avec, puis sans une institution.

| | Ancien générateur | Flux indépendants |
|---|---|---|
| I5 : jour de la première divergence | 77 à 1 018 (une graine identique) | 78 à 166 (une graine identique) |
| I5 : écart moyen du chômage entre les deux parties | 4,5 points | 4,9 points |
| I5 : écart type de l'effet estimé entre graines | 1,4 point | 3,0 points (1,2 sans la graine 5, qui s'effondre d'un côté) |
| I1 : jour de la première divergence | 2 ou 3 | 2 ou 3 |
| I1 : écart moyen du chômage entre les deux parties | 28,4 points | 30,2 points |
| I1 : écart type de l'effet estimé entre graines | 27,3 points | 22,1 points |

Les flux indépendants suppriment le décalage artificiel des tirages : les tests le prouvent. Ils ne suppriment pas la
divergence des parties. Celle-ci commence le jour où l'institution mord pour la première fois, puis grandit par
l'économie elle-même : quelques milliers de dollars en plus ou en moins changent des achats, puis des prix, puis des
embauches. En 100 à 300 jours, les deux parties sont aussi différentes que deux graines distinctes. Le bruit des
comparaisons est donc surtout endogène : il faudra plus de graines et des comparaisons appariées (tâche 2).

**Nouvelle référence. Les anciennes références ne sont plus comparables** (`stabilite-avant.json`, `tache*`,
`institutions-*`, `i1-*` à `i5-*`) : mêmes règles, autres tirages. Nouvelle référence :
[`crn-reference-complet.md`](crn-reference-complet.md) et [`crn-reference-noyau.md`](crn-reference-noyau.md).
Comparée au dernier rapport (I5), qui avait exactement le même modèle, elle mesure le bruit d'un protocole à 5 graines :

| Indicateur (5 graines) | Anciens tirages | Nouveaux tirages |
|---|---|---|
| Sans filets : chômage moyen | 8,0 % | 10,2 % |
| Sans filets : faim moyenne | 5,5 % | 8,6 % |
| Sans filets : sans-abri moyen | 2,0 % | 2,8 % |
| Sans filets : jours de Caisse insolvable | 1 277 | 0 |
| Sans filets : jours de prestations réduites | 0 | 219 |
| Avec filets : chômage moyen | 8,0 % | 9,0 % |
| Avec filets : anti-famine / 50 j | 0,14 | 2,2 |
| Noyau : renflouements / 50 j | 8,9 | 13,4 |
| Noyau, avec filets : Gini moyen | 0,20 | 0,14 |

Rien n'a changé dans l'économie : ces écarts sont du bruit. Ils sont du même ordre que plusieurs effets attribués aux
institutions I1 à I5 (par exemple I5 : chômage sans filets 9,2 → 8,0 %). Ces effets sont à revoir avec le protocole
statistique de la tâche 2.

**Coût.** Le protocole complet passe de ~155 s à 164 s, le noyau de ~166 s à 184 s.

**Limites.**

- Les tests statistiques sont simples (moyenne, variance, corrélations), pas une batterie complète comme TestU01 ou
  PractRand.
- Au plus 9 999 entreprises d'un même type par partie, pour garder des identifiants stables.
- Un agent qui n'existe que dans une des deux parties a forcément un identifiant à lui ; la comparaison reste appariée
  pour tous les autres.

### Tâche 2 — Protocole statistique (11 octobre 2026)

Aucune règle économique ne change. Références : Fagiolo et al. 2017 (validation des modèles multi-agents en économie) ;
Lee et al. 2015 (analyse des sorties de simulation).

**Pourquoi.** Cinq graines et des moyennes ne séparent pas un effet du bruit. La tâche 1 l'a montré : en changeant
seulement les tirages, le chômage moyen sans filets passait de 8,0 à 10,2 %, autant que l'effet attribué à plusieurs
institutions.

**Ce qui a changé dans `tool/stabilite.dart`.**

- **`--graines N`, défaut 30** (graines 1 à N ; `--seeds` garde une liste explicite). Les chocs prennent les mêmes
  graines par défaut.
- **Un isolat par partie** (`Isolate.run`), au plus `--isolats P` à la fois (défaut : nombre de processeurs, 16 ici).
  Les résultats sont rangés dans l'ordre des tâches, pas dans l'ordre d'achèvement. Le rapport affiche le temps total.
- **Distributions, jamais de moyenne seule.** Pour chaque indicateur : médiane, écart interquartile (quantiles de type 7,
  comme R et NumPy), min–max, et nombre de graines hors de la zone d'équilibre. Le tableau « avant / après » en moyennes
  est supprimé. Les filets ont la même forme (médiane des déclenchements par 50 jours, graines ≥ 1 / 50 j).
- **Nouvel indicateur : jours-alerte critiques** (pour chaque type critique, les jours où l'alerte est ouverte,
  additionnés). Une détresse durable ne compte qu'une ouverture ; il fallait aussi sa durée (voir la question
  prioritaire).
- **Critères de sortie graine par graine.** Un critère est rempli si aucune graine n'est hors bande ; le rapport donne
  les graines hors bande. Le critère des filets (« < 1 déclenchement / 50 j ») porte désormais sur chaque graine ; il
  portait sur la moyenne des graines. Il est donc plus strict.
- **`--compare A B`, apparié.** A et B sont des synthèses enregistrées par `--save` (l'ancien format est relu) ou des
  configurations lancées sur place sur les mêmes graines (`ref`, `institutions=0`, `bankruptcy=0`,
  `param:dividendFromRetained=1`, `noyau`…). Pour chaque étape présente des deux côtés et chaque indicateur :
  - les médianes de A et de B et leurs graines hors bande ;
  - la différence médiane par graine (médiane de B − A) et son intervalle de confiance à 95 %, par bootstrap
    percentile (10 000 tirages des graines avec remise, générateur à graine fixe) ;
  - le nombre de graines où B fait mieux, moins bien ou pareil.

  Un effet n'est conclu que si l'intervalle exclut 0. Un second tableau compare chaque type d'alerte critique
  (ouvertures et jours-alerte), et le rapport finit par la liste des effets concluants.
- **Chaque étape « sauf » est comparée, graine par graine, à l'étape « avec filets »** de la même exécution.
  `--sauf chacun` ajoute une étape par filet ; `--sauf` peut aussi se répéter.
- **Période de chauffe.** Toujours exclue (jours 1 à 100, `--warmup`). Le rapport dit sa durée et, pour chaque
  indicateur, s'il est mesuré après la chauffe, sur toute la partie (maxima, alertes ouvertes, prêts refusés, écart
  comptable) ou le dernier jour (Gini final). Une ligne compte les alertes critiques ouvertes après la chauffe.
- **`--relire synthese.json`** refait un rapport sans relancer de partie.

**Vérifications.**

- **Isolats.** Avec les graines 1 à 5, les 10 parties lancées en isolats sont identiques, champ par champ, à la
  référence séquentielle de la tâche 1 (`crn-reference-complet.json`).
- **Tests.** `test/protocole_test.dart` (4 tests) vérifie :
  - les quantiles (valeurs de R) ;
  - le bootstrap : reproductible, l'intervalle exclut 0 pour un décalage net, pas pour une distribution centrée ;
  - l'appariement par numéro de graine, pas par rang ;
  - une partie lancée en isolat, identique à la même partie lancée directement.
- **Coût.** Le protocole complet à 30 graines, avec `--sauf chacun` et les 300 chocs, fait 510 parties : 7 min 20 s
  pour le modèle complet, 7 min 55 s pour le noyau, 16 parties à la fois.

**Bilan des institutions refait** ([`stat/`](stat/)). 30 graines × 1 500 jours, chauffe de 100 jours, modèle complet.
Six configurations : aucune institution (`complet-sans-institutions`), puis I1, I1–I2… jusqu'à I1–I5
(`complet-i1-i5`, la référence actuelle). Chaque institution est comparée à la configuration d'avant (`compare-complet-i1`
à `-i5`), et toutes ensemble à aucune (`compare-complet-institutions`).

Chaque case donne la différence médiane par graine et son intervalle à 95 %. Entre parenthèses : graines où l'institution
fait mieux / moins bien, sur 30. Seuls les effets dont l'intervalle exclut 0 sont listés.

| Étape | Sans filets | Avec filets | Filet qu'elle remplace coupé |
|---|---|---|---|
| I1 dividendes | chômage −20,8 pt [−46,7 ; −3,4] (24/6) ; faim −9,1 pt [−52,0 ; −3,5] ; sans-abri −15,3 pt [−46,8 ; −4,3] ; jours-alerte critiques −1 496 [−2 565 ; −460] ; mais alertes critiques ouvertes +6,5 [+4 ; +10,5] (5/24) | chômage +3,4 pt [+2,4 ; +5,4] (1/29) ; renflouements +4,9 / 50 j [+1,3 ; +8,3] | sans renflouement : chômage +0,9 pt [+0,3 ; +1,5] ; sans-abri −0,6 pt ; plancher de logement −10,8 / 50 j |
| I2 enveloppe | jours-alerte critiques −96 [−223 ; −30] | renflouements −16,0 / 50 j [−20,1 ; −10,8] (29/1) | sans renflouement : jours-alerte critiques −68,5 [−116 ; −33] |
| I3 assurance-emploi | sans-abri +1,1 pt [+0,1 ; +1,5] (10/20) | chômage −0,6 pt [−2,0 ; −0,4] ; renflouements −1,8 / 50 j ; plancher de logement +1,9 / 50 j | sans anti-famine : chômage −0,6 pt ; renflouements −2,0 / 50 j ; plancher +2,0 / 50 j |
| I4 Caisse | aucun effet concluant ; chômage identique dans 22 graines sur 30 | aucun : chômage identique dans les 30 graines | aucun : identique |
| I5 faillite | aucun effet concluant | aucun : chômage identique dans 28 graines | sans renflouement : aucun effet concluant |
| Les cinq | chômage 28,5 → 8,0 % (médianes), −19,7 pt [−47,5 ; −2,2] (22/8) ; graines au chômage moyen > 10 % : 23 → 4 ; jours-alerte critiques −1 534 [−2 746 ; −406] ; alertes critiques ouvertes +10,5 [+4,5 ; +14] | chômage +2,5 pt [+1,7 ; +3,2] (1/29) ; renflouements −13,0 / 50 j [−17,4 ; −8,6] (26/4) | — |

Chocs revenus à l'équilibre en moins de 200 jours : sans filets, 0 sur 150 sans institutions et 8 sur 150 avec ; avec
filets, 107 sur 150 sans institutions et 47 sur 150 avec.

**Ce que 30 graines changent au bilan à 5 graines.**

- **Sans filets, les institutions comptent beaucoup plus qu'on ne le croyait.** Sans elles, 18 graines sur 30
  s'effondrent (chômage moyen ≥ 15 %). Avec les anciens tirages, les 5 graines du bilan d'hier n'en comptaient
  aucune. Ce bilan donnait 9,2 → 8,0 % ; la médiane sur 30 graines passe de 28,5 à 8,0 %.
- **I1 fait presque tout.** Il sauve l'économie sans filets, et il est aussi la seule institution qui dégrade le
  chômage avec filets (+3,4 pt, 29 graines sur 30). I2 et I3 ont des effets nets mais petits ; I4 et I5 ne mordent
  presque jamais.
- **Les chocs avec filets se résorbent moins bien avec les institutions** (107 → 47 sur 150), comme à 5 graines
  (11 → 4 sur 15).

**Filets coupés un par un** (référence I1–I5, chaque coupure comparée aux filets complets) :

- **Seul le renflouement compte encore.** Le couper fait passer la faim médiane de 0,1 à 4,2 % (+4,0 pt [+3,4 ; +4,8],
  28 graines sur 30). Il fait aussi monter :
  - le chômage, de 1,0 pt [+0,2 ; +1,6] ;
  - les sans-abri, de 1,1 pt ;
  - l'anti-famine, de 0,18 à 131,5 déclenchements par 50 jours ;
  - les jours-alerte critiques, de 1 293 par graine.

  La santé moyenne tombe de 0,88 à 0,17.
- **Couper l'anti-famine ou le plancher de logement ne change rien de concluant.**
- **Le plafond de dérive et l'anti-crédit-fou ne servent plus : les 30 parties restent identiques sans eux.** Le
  plafond de dérive ne se déclenche jamais. Avec I4, l'anti-crédit-fou ne fait plus que compter les refus de la Caisse :
  ses 146 « déclenchements » de la graine 29 sont ces refus. La règle reste appliquée sans lui.

**Question prioritaire : les alertes critiques sans filets passées de 104 à 135.**

1. **Ce ne sont pas les nouveaux détecteurs.**
   - Depuis la référence à 104 (`a4e3b73`), la liste des alertes critiques et le code de leurs détecteurs n'ont pas
     changé. Les seuls détecteurs ajoutés depuis (attente, prestations réduites) sont de niveau « attention ».
   - Vérifié : le code d'I5 (`3ad2070`), anciens tirages, les cinq institutions coupées, redonne graine par graine les
     alertes critiques de la référence (26, 6, 24, 23, 25 : 104). Seules les alertes non critiques diffèrent.
2. **Ce n'est pas du bruit.** Sur 30 graines appariées, les institutions ajoutent 10,5 ouvertures d'alertes critiques
   par graine [+4,5 ; +14] ; 21 graines sur 30 en ont plus. L'effet vient d'I1 (+6,5 [+4 ; +10,5]) ; pour I2 à I5,
   rien de concluant.
3. **Ce n'est pas une dégradation de la détresse.**
   - Les ouvertures en plus sont des alertes d'indice des prix : « inflation quotidienne » +5 par graine
     [+4 ; +6,5] (28 graines sur 30), « inflation sur 100 jours » +1 [+0,5 ; +1,5].
   - La faim et les sans-abri n'ouvrent pas plus d'alertes (non concluant), et « chômage très élevé » en ouvre une de
     moins.
   - En durée, les jours-alerte critiques sont divisés par deux : 3 030 → 1 524 par graine (médianes), −1 534
     [−2 746 ; −406]. Dont la faim −342 jours, les sans-abri −525 et le chômage très élevé −527.
   - Sans institutions, l'économie s'effondre et reste dans une longue alerte : peu d'ouvertures, beaucoup de jours.
   - Dans les 9 graines qui ne s'effondrent ni avec ni sans I1, I1 ajoute encore des alertes d'inflation quotidienne
     dans les 9 (médiane +8). L'effet sur l'indice est donc propre à I1.
4. **D'où viennent ces sauts de l'indice** (traces de partie, voir la tâche 3).
   - Sur 10 graines sans filets, l'indice saute de plus de 5 % en un jour 31 fois sans institutions, 68 fois avec.
     Avec institutions, ces sauts viennent surtout des bijoux, des repas et des ordinateurs.
   - Le mécanisme : un bien sans vente garde dans l'indice son dernier prix de transaction. Pendant ce temps, son prix
     affiché suit le coût de revient, jusqu'à 1,5 % par jour. À la vente suivante, l'indice rattrape tout d'un coup.
     Exemple, graine 4 : un ordinateur vendu 980,6 $ au jour 1 020, puis 3 324,3 $ au jour 1 102 ; l'indice prend
     +5,6 % ce jour-là.
   - Le panier est fixe en quantités : un bien dont le prix a triplé pèse plus. Au jour 147, les bijoux font 43,8 % de
     sa valeur.
   - Hypothèse compatible avec ces traces, non démontrée : en retenant les dividendes, I1 réduit le revenu des
     propriétaires, donc leurs achats de luxe ; ces marchés deviennent plus rares en transactions.

   **Réponse : une hausse réelle due à I1, mais des alertes d'indice, pas de détresse ; la détresse, elle, baisse de
   moitié.** Deux choix de mesure sont à trancher, je n'ai rien changé :
   - le prix d'un bien sans vente dans l'indice (prix affiché, ou indice chaîné) ;
   - le critère de sortie « aucune alerte critique », qui compte des ouvertures et non des durées.

**Noyau : seule la référence est mesurée** (`noyau-i1-i5`). Chômage médian 5,7 % (Q1–Q3 : 3,2–7,0 %), aucune graine
au-dessus de 10 %, faim nulle, alertes critiques ouvertes : médiane 0, au moins une dans 11 graines sur 30. Le calcul
des autres configurations du noyau a été arrêté avant la fin ; le bilan du noyau n'est pas refait. Pour le refaire :
`dart run tool/stabilite.dart --noyau --modules dividendTest=0,publicBudget=0,insurance=0,bankRegulation=0,bankruptcy=0
--phases base,nets,chocs --sauf chacun --save rapports/stat/noyau-sans-institutions.json`, et de même pour I1 à I4.

**Limites.**

- **Intervalles grossiers.** Le bootstrap percentile d'une médiane sur 30 graines donne des intervalles approximatifs.
  Pour des comptages souvent égaux, l'intervalle [0 ; 0] veut dire « identique dans la plupart des graines ».
- **Pas de correction pour comparaisons multiples.** Chaque rapport compte une quarantaine de lignes par étape ; à 5 %
  chacune, une ou deux conclusions par tableau peuvent venir du hasard.
- **L'appariement réduit peu le bruit** (tâche 1) : les effets qui passent par un effondrement ont des intervalles
  très larges (−47,5 à −2,2 pt).
- **Les chocs ne sont pas comparés en mode apparié**, seulement décrits par leurs distributions.
- **L'attente à l'hôpital public est « moins bonne » avec les institutions par construction** : sans I2, il n'y a pas
  de file publique.
- **Taille.** Une synthèse pèse de 0,5 à 0,65 Mo.

### Tâche 3 — Journaux exportables (11 octobre 2026)

Aucune règle économique ne change. L'interface garde ses listes plafonnées (300 événements, 1 000 déclenchements de
filets, 1 500 jours d'historique) ; l'outil en ligne de commande écrit des fichiers complets.

**Ce qui a changé.**

- **`tool/partie.dart`** joue une partie (`--graine`, `--jours`, `--filets 0|1`, `--sauf`, `--modules`, `--noyau`,
  `--param`). Ses options de journal sont décrites ci-dessous.
- **`--trace dossier/`** écrit quatre fichiers :
  - `evenements.jsonl` : une ligne par événement (jour, catégorie, type, agent et identifiant, règle déclenchée, cause,
    montant, détail). Catégories : compta, travail, credit, filets, institutions, entrees_sorties, et alertes (ajoutée :
    ouverture et fermeture). `--categories` n'écrit que celles demandées. Chaque déclenchement de filet porte le montant
    injecté et sa cause, les mêmes que les compteurs de filets.
  - `series.csv` : une ligne par jour, 110 colonnes. On y trouve les indicateurs que lisent les détecteurs :
    - chômage, parts d'affamés et de sans-abri, santé, efficacité, postes non pourvus et bloqués ;
    - prestations, attentes, Gini, richesse médiane, inflation sur un jour et sur 100 jours, fonds propres de la
      Caisse, écart comptable ;
    - les alertes actives par type, les filets du jour, les prix, les satisfactions et les classes.
  - `agents_fin.csv` : une ligne par citoyen en fin de partie : traits, qualification de départ et de fin, cours suivis,
    revenu moyen, épargne, jours de faim, sans logis et sans emploi, employeur et son secteur, cause dominante de
    détresse. La cause est jugée chaque jour de détresse par `famineCause` / `shelterCause`.
  - `entreprises.csv` : une ligne par entreprise ayant existé : secteur, jours de création et de fermeture, cause,
    trésorerie et effectif moyens, dividendes versés, dette radiée, prêts et renflouements reçus.
- **Dans le moteur.** Un crochet `Sim.trace` reçoit des `TraceEvent`. Chaque appel est gardé par `trace != null` : sans
  traceur, rien n'est calculé de plus. `lib/engine/trace.dart` écrit les fichiers ; il ne fait que lire l'état.
- **`tool/detresse.dart agents_fin.csv`** compare les citoyens en détresse (jours de faim ou sans logis ≥ 10 % des jours,
  `--seuil`) aux autres. Il classe :
  - les variables numériques par leur aire sous la courbe ROC ;
  - les variables qualitatives par l'écart de leurs proportions.

  Il ne déduit aucune cause et le dit en tête de son rapport.
- **Instantanés** (`lib/engine/snapshot.dart`) :
  - `--snapshot-every N` et `--snapshot-at J` écrivent l'état complet en JSON ; `--from-snapshot` reprend la partie.
  - L'instantané enregistre tout, champs privés compris. Les nombres sont écrits au plus court qui se relit à
    l'identique, et l'ordre des clés est gardé (il fixe l'ordre des sommes).
  - Ne sont pas enregistrés les caches recalculés : clés de hasard du jour, numéros d'achat du jour, index par
    identifiant.
- **`--diff vA vB`** fait tourner deux versions du moteur sur la même partie. vA et vB : un dossier, « travail », ou une
  révision git extraite dans un dossier temporaire. L'outil procède en trois temps :
  1. chaque version écrit chaque jour une empreinte de chaque partie de son état ;
  2. au premier jour qui diffère, les deux parties sont rejouées jusque-là et leurs instantanés comparés, variable par
     variable ;
  3. il affiche les réglages qui diffèrent, puis le premier jour où la partie diverge et les premières variables d'état
     qui diffèrent. Citoyens, entreprises et alertes y sont appariés par identifiant.
- **Interface.** Toucher une alerte d'entreprise ouvre l'inspecteur de cette entreprise. Toucher une ligne soulignée
  ouvre celui de l'entreprise ou du citoyen qu'elle cite. Les alertes gardent pour cela l'agent de chaque ligne et
  l'entreprise concernée. Rien d'autre ne change.

**Vérifications.**

- **Rien ne change sans traceur.** Les 27 tests d'avant passent, dont l'empreinte exacte d'une partie de 150 jours. La
  parité VM / JavaScript de `tool/parite.dart` (dart2js `-O2`) est toujours identique au bit près.
- **`test/instantane_test.dart`** (6 tests) vérifie :
  - la reprise depuis un instantané écrit puis relu, identique au bit près à la partie jouée d'une traite. Testé sur
    trois configurations : modèle complet avec filets ; sans filets, frontières ouvertes, après une épidémie et des
    immigrants ; noyau sans filets, avec des alertes ouvertes ;
  - la partie avec traceur, identique à la partie sans traceur ; un événement par déclenchement de filet, avec montant
    et cause ;
  - les empreintes : identiques pour la même partie, différentes dès le premier jour si le taux d'impôt change ;
  - chaque alerte d'entreprise, qui désigne son entreprise.
- **En ligne de commande** (graine 7, sans filets) :
  - reprendre depuis l'instantané du jour 500 et jouer jusqu'au jour 1 500 donne un fichier identique octet pour
    octet à celui de la partie complète ;
  - `--diff travail travail` : aucune divergence en 300 jours ;
  - contre une copie où une entreprise sans employé ferme après 31 jours au lieu de 30 : réglage `exitIdleDays` 30
    contre 31, première divergence au jour 46. Les variables listées : la mine d'or fermée dans A, encore là dans B ;
    l'argent rendu à son propriétaire ; ses alertes.
- **Dans le navigateur** (version web) : toucher l'alerte « Surstock » d'Ordinateurs Pelletier ouvre son inspecteur.

**Exemple, graine 7, sans filets, 1 500 jours.**

- **Journal d'événements : 67 869 événements (15,7 Mo).**
  - salaires : 22 636 ;
  - dividendes retenus par I1 : 16 493 ; dividendes versés : 11 274 ;
  - enveloppes d'I2 : 2 907 ;
  - embauches : 2 629 ; fins d'emploi : 2 623.
- **Entreprises : 126 ont existé**, dont 95 créées en cours de partie et 109 fermées.
- **Détresse.** `tool/detresse.dart` trouve 224 citoyens sur 240 en détresse au moins 10 % des jours. Cause dominante :
  « faim : pas de producteur » (217). Variables qui les distinguent le plus :
  - l'argent de départ, plus haut en détresse (AUC 0,65) ;
  - la part de jours sans emploi (0,64) ;
  - le revenu moyen, plus bas en détresse (0,35) ;
  - l'emploi dans le secondaire : 21 % des citoyens en détresse contre 44 % des autres.
- **Même graine avec filets.** 678 déclenchements : 324 renflouements (511 101 $) et 354 nuitées d'urgence (2 849 $) ;
  aucun citoyen en détresse.
- **Coût.** 1 500 jours en 9,1 s sans trace, 9,7 s avec la trace complète. Un instantané pèse de 1,3 à 2,8 Mo, selon la
  longueur de l'historique.

**Limites.**

- **`--diff` ne remonte pas avant cette tâche.** Il faut que les deux versions connaissent `tool/partie.dart`. La
  révision actuelle `3ad2070` ne le connaît pas : l'outil le dit et s'arrête.
- **Empreintes.** Elles sont des hachages FNV de 32 bits par partie de l'état : une collision est possible mais
  improbable. Ce qui fait foi est la comparaison complète des instantanés du jour trouvé.
- **Cause de détresse approchée.** Elle est jugée en fin de journée, aux prix du soir.
- **`cours_suivis` approché.** Il se déduit des hausses de qualification : une formation du god mode y compte comme des
  cours.
- **Ancien format illisible.** Un instantané porte un numéro de version : si l'état gagne un champ, les instantanés
  d'avant ne se relisent plus.
- **Agents disparus.** Une entreprise fermée ou un citoyen parti n'ont plus d'inspecteur ; leurs lignes ne sont pas
  cliquables.

### Tâche 4 — Tests de propriétés et cas extrêmes (11 octobre 2026)

Repères : Thaler et Siebers (tests par propriétés en simulation à agents) ; Galán et al. 2009 (erreurs et artefacts).
Aucune règle économique ne change, à une correction de robustesse près (zéro citoyen, ci-dessous). Tous les
nouveaux drapeaux sont coupés par défaut.

**Ce qui a changé.**

- **`test/proprietes_test.dart`** (générateur maison, reproductible). 24 parties de 250 jours sont tirées au hasard :
  - graine, population de 40 à 300 ;
  - chaque module actif à 75 %, chaque filet à 50 % ;
  - impôt, prestation, taux d'intérêt, plafonds quotidiens des prix et des salaires, taux de dividende, mobilité,
    maladies, admissibilité à l'assurance-emploi, plafond des dividendes, commerce ;
  - capital de la Caisse : nul dans 30 % des cas, sinon de 0 à 200 $ par citoyen ;
  - 0 à 4 chocs du god mode : argent, destruction de stocks, épidémie, arrivées, départs, faillite.

  Les parties tournent en mode développement : un invariant rompu lève une exception. Les propriétés sont vérifiées
  chaque jour, ou au moment même de l'événement grâce au journal complet (`Sim.trace`) :
  - **I1 :** pas de dividende versé par une entreprise à fonds propres négatifs. Fonds propres = trésorerie + stocks
    (extrants au prix affiché, intrants au meilleur prix) + machines au prix du marché − dette, avant le versement ;
  - **prix et salaire du jour** dans ±`priceMaxDaily` / ±`wageMaxDaily` de la veille (sauf plancher) ;
  - **postes pourvus ≤ population ;** un citoyen a au plus un employeur, et les registres des citoyens et des
    entreprises concordent ;
  - **I4 :** à chaque prêt accordé, fonds propres de la Caisse ≥ 11,5 % de l'encours, prêt compris ;
  - **I3 :** toute demande admise a au moins `eiQualifyingDays` jours assurables et un dernier salaire ; aucune
    prestation hors d'une demande admise pendant le chômage en cours ; aucune prestation si le module est coupé ; un
    jour assurable n'est compté qu'avec une paie versée.

  La conservation des flux du jour n'est pas retestée : les invariants exacts la couvrent déjà.
- **`test/extremes_test.dart`.** Chaque test énonce son résultat attendu avant de jouer : zéro citoyen ; une seule
  entreprise par secteur ; salaires figés ; toute la monnaie × 100 ; aucun hasard.
- **`Sim.sansHasard`** (drapeau de test). Tous les tirages valent 0,5, les ordres du jour suivent les identifiants, les
  offres sont départagées à 0,5. Il est aussi dans `tool/partie.dart --sans-hasard` et dans les instantanés.
- **Variantes d'artefacts** (paramètres de test, coupés par défaut, lisibles par `--param` et les instantanés) :
  - **A1 (`healthWearIfDeprived`) :** la santé ne s'use que les jours de faim ou sans logis ; les maladies restent ;
  - **A2 (`partTime`) :** travail divisible. L'équipe est payée pour la part de sa capacité du jour qu'elle a produite,
    au moins 20 %, et le coût de revient ne compte plus les heures oisives. Les règles fondées sur le salaire
    contractuel ne changent pas : seuil d'embauche, réserve des dividendes, mise à pied sous 2 jours de salaires.
- **Protocole.** Trois indicateurs de filière en fin de partie : types d'entreprise actifs, machines, équipes utilisées
  à moins de 15 % de leur capacité.
- **Correction de robustesse.** Avec zéro citoyen, `reset` tirait un propriétaire dans une liste vide (`RangeError`).
  Sans citoyen, il n'y a plus de propriétaire ; la trésorerie d'une fermeture revient alors à l'État, comme pour un
  établissement public.

**Vérifications.**

- **Rien ne change par défaut.**
  - L'empreinte de `tool/parite.dart` est identique, au bit près, avant et après, sur la VM et en JavaScript (dart2js
    `-O2`, `node`).
  - La référence du protocole, relancée (`rapports/stat/tache4-ref.md`), reproduit exactement
    `rapports/stat/complet-i1-i5.json` : 2 640 valeurs sur 30 graines, sans et avec filets, et les 300 chocs.
  - Les 44 tests (33 d'avant, 11 nouveaux) : 42 passent, 2 sont sautés volontairement (ci-dessous).
- **Couverture des propriétés.** Sur les 24 parties, on a vérifié 32 400 dividendes, 138 prêts accordés (189 refusés),
  1 332 demandes d'assurance-emploi, 131 493 prix et 125 997 salaires.
- **Les tests attrapent les fautes.** Chaque mutation a été faite sur une copie de `sim.dart`, puis annulée :
  - **plafond des prix retiré :** attrapé dès le jour 2 du cas 1 ;
  - **admissibilité à l'assurance-emploi retirée :** attrapé (cas 1, jour 83 : demande admise avec 14 jours sur 22) ;
  - **plancher de fonds propres de la Caisse retiré :** d'abord *non attrapé*, car le plancher ne mordait dans aucun
    cas tiré. Une fois ajoutées les Caisses sans capital, il est attrapé (cas 2, jour 7 : fonds propres 155 $ pour un
    plancher de 285 $) ;
  - **test de solvabilité I1 retiré :** des dividendes à fonds propres négatifs apparaissent (cas 2, la ferme au
    jour 124 : fonds propres −417 $, trésorerie 330 $, dette 761 $). Avec I1, il n'y en a aucun sur 32 400. La propriété
    distingue donc bien le moteur avec I1 du moteur sans.

**Résultats : propriétés.**

- **Toutes tiennent, sauf un écart, rapporté et non corrigé.**
  - **Le cas.** Le jour d'une faillite du god mode, l'entreprise n'a plus rien en caisse à la paie : ses employés ne
    sont pas payés et ne cotisent pas, mais le jour compte quand même comme emploi assurable. Exemple : cas 13,
    jour 126, Château Simard, au moins 20 employés (la liste des échecs est plafonnée à 20).
  - **Pourquoi seulement ce jour-là.** Une paie partielle cotise toujours. Une caisse à exactement 0 $ avec des
    employés ne s'observe qu'après `godBankrupt` dans ces 24 parties.
  - **Le test.** Il épingle l'écart : il échoue si un jour assurable sans cotisation apparaît un autre jour.
  - **La décision reste à Francis.** Faut-il un jour cotisé pour compter un jour assurable ?
- **Un faux positif corrigé dans le test, pas dans le moteur.** Un citoyen mis à pied pendant la paie finit la journée
  sans emploi, avec les jours restants d'une ancienne demande. Il n'est pas payé ce jour-là : son dossier est revu le
  lendemain.

**Résultats : cas extrêmes.**

| Cas | Attendu | Obtenu |
|---|---|---|
| Zéro citoyen | rien ne se produit ; masse monétaire constante ; entreprises sans employé fermées | ✅ après la correction de robustesse : 3 entreprises de services naissent sans employé, ferment au jour 30, l'État récupère leurs 18 000 $ |
| Une entreprise par secteur (ferme, boulangerie, immobilier ; modules et filets coupés) | personne n'a faim ni ne dort dehors après le jour 100 | ❌ **sauté.** La ferme vend toutes ses céréales mais perd de l'argent dès le jour 5 : son bétail (≈ 45 % de la valeur d'un lot) n'a aucun acheteur. Elle licencie à partir du jour 20 et n'a plus d'employé au jour 30 ; 240 affamés dès le jour 36. C'est l'anomalie A3 |
| Salaires figés | aucun salaire ne bouge en 300 jours ; salaire moyen dans les bornes de départ ; invariants exacts | ✅ |
| Monnaie × 100 : les prix suivent | indice des prix × > 10 au jour 500 | ✅ graine 1 : ×18. Graines 1 à 8 : ×16 à ×55 au jour 500, ×15 à ×85 au jour 1 500 |
| Monnaie × 100 : économie réelle inchangée | jours 1 001 à 1 500 : dépense réelle à ±20 %, chômage à ±3 points | ❌ **sauté.** Salaires ×72 à ×244 au jour 1 500, plus que les prix ; dépense réelle des ménages ×2 à ×23 environ ; chômage de −3,1 à +6,5 points ; graine 8 : 153 affamés en moyenne contre 1 |
| Aucun hasard | traits, argent et propriétaire se calculent à la main ; en 30 jours, aucune maladie (santé = 1 − 0,003 × jour), aucun changement d'emploi, aucun cours, aucun achat d'ordinateur ; la graine ne compte plus | ✅ |

- **Les deux attendus non obtenus restent écrits.** Les tests sont sautés, avec ce qui a été mesuré ; `flutter test
  --run-skipped` les fait échouer sur ces valeurs.
- **Partie sans hasard, lisible à la main** (`tool/partie.dart --sans-hasard --jours 30 --trace`) : 2 244 événements,
  dont 930 paies et 917 dividendes versés ou retenus. Au jour 30 : chômage 2,1 %, aucun affamé ni sans logis, indice
  des prix 1,266, écart comptable 0.
- **Choc monétaire avec les filets.** Il a été mesuré avec les filets actifs, comme dans le jeu (`Sim` par défaut).

**Résultats : artefacts.** Protocole complet : 30 graines × 1 500 jours, comparaisons appariées contre la référence
(`rapports/stat/tache4-compare-a1.md`, `rapports/stat/tache4-compare-a2.md`). Différences médianes par graine et IC 95 %
bootstrap.

| Sans filets | Référence | A1 : usure si privation | A2 : temps partiel |
|---|---|---|---|
| Santé moyenne | 0,18 | 0,56 (+0,36 [+0,30 ; +0,48]) | 0,88 (+0,70 [+0,67 ; +0,73]) |
| Graines où la santé moyenne reste < 0,5 | 30/30 | 12/30 | — |
| Alerte « santé effondrée » ouverte | 30/30 | 26/30 | — |
| Faim moyenne | 6,1 % | 1,6 % (−4,0 pt [−5,2 ; −2,8]) | 0,1 % (−6,0 pt [−7,5 ; −4,9]) |
| Sans-abri moyen | 2,6 % | 1,1 % (−1,3 pt [−1,9 ; −0,5]) | 0,4 % (−1,7 pt [−2,5 ; −1,3]) |
| Chômage moyen | 8,0 % | 9,5 % (non concluant) | 8,6 % (non concluant) |
| Types d'entreprise actifs en fin | 13 | 17 (+3,5 [+1,5 ; +6,5]) | 28 (+15 [+13,5 ; +15,5]) |
| Machines en fin | 0,2 | 0,5 | 362 (+362 [+303 ; +394]) |
| Attente à l'hôpital public | 513 j | 264 j | 0,4 j |
| Jours-alerte critiques | 1 525 | 904 (−616 [−807 ; −465]) | 71 (−1 440 [−1 489 ; −1 369]) |
| Chocs résolus en < 200 j | 8/150 | 35/150 | 70/150 |
| Critère « faim et sans-abri < 2 % » | 29/30 graines hors bande | 17/30 | 3/30 |
| Critère « chômage ≤ 10 % » | 4/30 hors bande | 13/30 | 11/30 |

- **A1, l'usure de la santé.**
  - **Le phénomène s'atténue mais survit en partie :** la santé moyenne reste sous 0,5 dans 12 graines sur 30, et
    l'alerte s'ouvre dans 26.
  - **La cause amont est toujours là :** l'hôpital public a toujours 264 jours d'attente médiane.
  - **Avec filets :** santé 0,88 → 0,94 ; mais pire sans-abri maximal (+21 pt [+6 ; +26]).
- **A2, le travail indivisible.**
  - **Le phénomène ne survit pas :** la filière se maintient (28 types actifs au lieu de 13, 362 machines au lieu de
    0), et la santé avec elle.
  - **Avec filets :** les renflouements passent de 13,1 à 5,2 par 50 jours (−7,8 [−9,6 ; −6,4]). Mais le chômage
    augmente de +1,5 pt [+0,6 ; +3,6] et les alertes critiques ouvertes de +5,5 [+1 ; +9].
  - **Sans filets :** l'inflation moyenne devient légèrement négative (−0,054 %/j).
- **Je ne propose pas d'adopter l'une ou l'autre.** La décision reste à Francis (importations de dépannage et usure de
  la santé : décisions réservées).

**Limites.**

- **Rigueur.** Une première série A1 / A2 a été jetée : mes tests de mutation modifiaient `sim.dart` pendant qu'elle
  tournait, et chaque `dart run` compile le moteur à son démarrage. Les trois séries rapportées ont été relancées avec
  le moteur figé.
- **Propriétés.**
  - 24 parties de 250 jours (≈ 40 s) : un défaut rare peut échapper. Le générateur cite le cas, le jour et l'agent ;
    on peut en ajouter.
  - **Fonds propres (I1) :** leur valeur dépend de la valorisation choisie des stocks et des machines.
  - **Cotisations (I3) :** elles ne s'observent pas par citoyen. Le test se fonde sur la paie versée par l'entreprise
    (`wagesPaid`).
- **A2 et le chômage.** Le chômage compte les personnes, pas les heures : un employé à 20 % du temps compte comme
  employé. Le sous-emploi n'est pas mesuré.
- **Cas extrêmes.**
  - Une seule graine pour la plupart, 8 graines pour le choc monétaire.
  - « Une entreprise par secteur » est lu au sens strict (une entreprise par secteur primaire, secondaire et
    tertiaire), avec la chaîne alimentaire la plus courte.
  - Le choc monétaire multiplie l'argent détenu, pas les prix ni les paramètres nominaux (`benefit`, seuils en dollars) :
    ceux-ci sont des points d'ancrage nominaux, une cause possible, non vérifiée, de la non-neutralité.
- **Instantanés.** Les nouveaux champs se relisent avec une valeur par défaut. La version de format n'a pas changé : les
  instantanés d'avant se relisent. Les trois nouveaux réglages sont écrits même coupés : un `--diff` contre une
  révision antérieure à cette tâche les signale comme réglages différents.

### Tâche 5 — Description stable du modèle (format ODD) (11 octobre 2026)

Référence : Grimm et al. 2020, « The ODD Protocol for Describing Agent-Based and Other Simulation Models: A Second
Update », *JASSS* 23(2) 7.

**Ce qui a changé.** [`MODELE.md`](../MODELE.md), à la racine et distinct de ce journal. C'est le document à donner aux
prochains lecteurs (humains ou LLM) à la place d'un résumé refait. Il compte sept sections :

1. objectif et faits stylisés visés (les critères de sortie, présentés comme des cibles de plausibilité, pas comme une
   calibration) ;
2. entités et variables d'état ;
3. ordre exact des étapes d'une journée ;
4. usage du hasard : les 16 flux de la tâche 1, leurs codes et leurs fonctions ;
5. initialisation, plan de départ, et chaque paramètre avec sa source ou la mention « choix de jeu » ;
6. sous-modèles ;
7. vérification.

Chaque règle porte sa justification et un renvoi `fichier:fonction`.

**Vérifications.**

- Les 49 renvois `fichier:fonction` et tous les identifiants cités existent dans le code (vérification automatique).
- Les comptes du document sont recomptés dans `model.dart` : 33 biens (9, 12, 12), 32 types.
- Les règles ont été relues dans le code, pas recopiées du journal.

**Limites.**

- **Beaucoup de « choix de jeu ».** Le document le dit au lieu d'inventer une source ; ce sont les valeurs les plus
  exposées aux artefacts.
- **Maintenance manuelle.** Le document doit changer avec le code, dans le même commit. Aucun test ne vérifie que les
  règles décrites sont celles du code : seule l'existence des renvois est contrôlée.

## 6. Entrepreneuriat, échelle et création d'entreprise

### Tâche 1 — Diagnostic du passage à l'échelle (11 et 12 octobre 2026)

**Constat de départ (Francis, dans l'application).** Avec 13 240 citoyens au jour 1 000 : chômage 75 %, 6 300 affamés,
6 330 sans logis. Avec un revenu de base de 10 $/j et 30 000 $ donnés à chacun, la faim et le logement se résorbent,
mais le chômage reste à 35 %. Deux hypothèses : (1) l'initialisation ne suit pas la population ; (2) la création
d'entreprise ne passe pas à l'échelle.

**Ce qui a changé.** Aucune règle de comportement ne change.

- **`--population N`** dans `tool/stabilite.dart` et `tool/partie.dart`. On peut aussi l'écrire
  `--param population=N`.
- **`tool/echelle.dart`** affiche les ratios du jour 1 à plusieurs tailles.
- **Entonnoir de création (mesure).**
  - **Compteurs :** `Sim.entryFunnel` les tient, enregistrés dans les instantanés. Dans le journal complet, chaque
    refus est un événement `entrees_sorties` / `projet_refuse`, avec sa cause.
  - **Un projet,** c'est un type d'entreprise dont le bien a, ce jour-là, une demande non servie suffisante.
  - **Causes de refus,** dans l'ordre où la règle les lit : une création déjà ce jour (`plafond_quotidien`), délai de
    60 jours entre deux créations du type (`delai`), concurrence (avant le jour 100, 3 producteurs actifs ou plus,
    marges des producteurs en place trop faibles), demande qui n'occupe pas un employé (`demande`), pas assez de
    chômeurs qualifiés (`main_oeuvre`), viabilité (`viabilite`), aucun fondateur assez riche (`capital`).
  - **Décision inchangée :** les conditions sont relues dans un ordre qui nomme la première qui manque. L'empreinte de
    parité est identique au bit près, et les 42 tests passent.
- **Protocole.** Naissances et morts d'entreprises par an, entonnoir sur la partie. Aux jours 500 et 1 000 : postes
  vacants, chômeurs, entonnoir, nombre d'entreprises.
- **Correction de l'initialisation (point 7).**
  - **Nouveau paramètre :** `scenarioPopulation` = 240, la population pour laquelle le scénario par défaut (une
    entreprise de chaque type) a été réglé. Une population N reçoit ce scénario répété round(N ÷ 240) fois.
  - **À 240 habitants, rien ne change :** une seule copie, partie identique au bit près.

**Ce que le modèle n'a pas : quatre causes demandées valent zéro par construction.**

- **Crédit, motivation, connaissance.** Aucun citoyen n'« envisage » de créer : chaque jour, l'économie examine chaque
  type de bien, et le fondateur est le citoyen le plus riche. Le crédit (le fondateur n'emprunte jamais), la
  motivation et la connaissance ne sont pas des conditions de la règle.
- **Créations par des entreprises existantes :** il n'y en a pas.
- **Inactifs par choix :** il n'y en a pas. Chaque jour, le marché du travail examine tous les sans-emploi.

**Résultats : ratios du jour 1** (graine 1, `tool/echelle.dart`).

| Jour 1 | 240 | 1 000 | 3 000 | 13 240 |
|---|---|---|---|---|
| **Avant la correction** | | | | |
| Postes offerts ÷ population | 0,99 | 0,95 | 0,93 | 0,92 |
| Logements ÷ ménages | 1,06 | 1,06 | 1,06 | 1,06 |
| Argent par habitant | 6 457 $ | 6 274 $ | 6 283 $ | 6 289 $ |
| Fonds propres de la Caisse par habitant | 100 $ | 100 $ | 100 $ | 100 $ |
| Enveloppes publiques par habitant et par jour (jours 1 à 30) | 5,15 $ | 3,57 $ | 2,81 $ | 2,67 $ |
| Entreprises (primaire / secondaire / tertiaire) | 7 / 12 / 12 | 7 / 12 / 12 | 7 / 12 / 12 | 7 / 12 / 12 |
| … secondaire pour 1 000 habitants | 50,0 | 12,0 | 4,0 | 0,91 |
| Taille médiane d'une équipe ; plus grande | 3 ; 43 | 12 ; 182 | 34 ; 546 | 155 ; 2 409 |
| **Après la correction** | | | | |
| Postes offerts ÷ population | 0,99 | 1,00 | 1,01 | 1,00 |
| Enveloppes publiques par habitant et par jour (jours 1 à 30) | 5,15 $ | 5,45 $ | 4,98 $ | 5,34 $ |
| Entreprises (primaire / secondaire / tertiaire) | 7 / 12 / 12 | 28 / 48 / 48 | 91 / 156 / 156 | 385 / 660 / 660 |
| … secondaire pour 1 000 habitants | 50,0 | 48,0 | 52,0 | 49,9 |
| Taille médiane d'une équipe ; plus grande | 3 ; 43 | 3 ; 45 | 3 ; 42 | 3 ; 44 |

Après la correction, les ratios ne diffèrent plus que par l'arrondi du nombre de copies (1 000 ÷ 240 = 4,17 → 4).

**Résultats : avant et après la correction.**

- **Protocole.** 1 500 jours, sans et avec filets, sans chocs. Avant : 10 graines. Après : 6 graines ; la série à
  10 graines a été arrêtée pendant la taille 13 240, trop longue.
- **Vérification.** À 240 habitants, la série d'après reproduit exactement celle d'avant sur les graines 1 à 6. La
  branche bâtiments, fusionnée et coupée, ne change donc pas les parties ordinaires.

Valeurs médianes [écart interquartile] :

| Sans filets | 240 | 1 000 | 3 000 | 13 240 |
|---|---|---|---|---|
| Chômage, avant | 8,1 % [7,2–9,3] | 38,0 % [27,3–45,6] | 90,6 % [90,2–91,0] | 94,4 % [94,3–94,5] |
| Chômage, après | 8,4 % [7,4–10,4] | 17,6 % [15,4–19,6] | 36,1 % [31,8–36,8] | 65,4 % [63,6–67,4] |
| Faim, avant → après | 6,7 % → 7,5 % | 9,7 % → 0,7 % | 87,4 % → 4,5 % | 94,6 % → 54,7 % |
| Sans-abri, avant → après | 1,8 % → 1,7 % | 19,6 % → 3,1 % | 84,4 % → 18,3 % | 86,1 % → 37,7 % |
| Gini, avant → après | 0,36 → 0,36 | 0,63 → 0,46 | 0,89 → 0,82 | 0,95 → 0,92 |
| Naissances d'entreprises / an, après | 30,4 | 18,0 | 16,8 | 6,9 |
| Morts d'entreprises / an, après | 33,8 | 36,1 | 95,6 | 369,5 |
| Entreprises au départ ; jour 500 ; jour 1 000 (après) | 31 ; — ; — | 124 ; — ; — | 403 ; 125 ; 78 | 1 705 ; 447 ; 232 |
| Postes vacants ÷ chômeurs au jour 1 000 (après) | — | — | 0,016 | 0,003 |

| Avec filets | 240 | 1 000 | 3 000 | 13 240 |
|---|---|---|---|---|
| Chômage, avant | 7,5 % | 42,1 % | 66,7 % | 86,7 % |
| Chômage, après | 7,8 % [7,5–9,9] | 22,5 % [21,0–23,4] | 33,0 % [17,5–36,2] | 68,6 % [66,9–69,9] |
| Naissances / morts d'entreprises par an, après | 3,3 / 5,6 | 6,2 / 25,1 | 4,6 / 82,9 | 1,7 / 364,0 |

*Les cases « — » ne sont pas extraites ici ; les valeurs sont dans `rapports/stat/echelle-apres6-*.json`.*

**Entonnoir après la correction** (sans filets, médianes sur la partie) :

| Projets et refus | 240 | 1 000 | 3 000 | 13 240 |
|---|---|---|---|---|
| Projets envisagés | 17 725 | 11 844 | 13 354 | 9 662 |
| Créations | 125 | 74 | 69 | 29 |
| Refus : concurrence | 1 771 | 4 395 | 6 350 | 6 378 |
| Refus : délai du type | 6 215 | 3 188 | 3 251 | 1 328 |
| Refus : viabilité | 5 986 | 1 380 | 1 011 | 1 262 |
| Refus : demande | 1 582 | 2 784 | 1 768 | 541 |
| Refus : une création déjà ce jour | 832 | 456 | 504 | 111 |
| Refus : capital | 845 | 58 | 0 | 0 |
| Refus : main-d'œuvre | 565 | 2 | 0 | 0 |

**Lecture.**

1. **L'initialisation expliquait la majeure partie de l'écart.** Avec 31 entreprises quelle que soit la population, une
   équipe atteignait 2 409 personnes et le secteur secondaire comptait 0,91 entreprise pour 1 000 habitants. Avec la
   correction, sans filets, le chômage à 3 000 habitants passe de 90,6 % à 36,1 %, et à 13 240 de 94,4 % à 65,4 %.
2. **Le reste vient de la création d'entreprise, qui ne passe pas à l'échelle** (mécanisme rapporté, non corrigé) :
   - **Les fermetures croissent avec le nombre d'entreprises,** de 34 par an à 240 habitants à 370 par an à 13 240.
   - **Les naissances, elles, baissent :** de 30 à 7 par an. Elles sont plafonnées en nombre absolu : une création par
     jour dans toute l'économie, 60 jours entre deux créations d'un même type, aucun nouvel arrivant dès que 3
     producteurs sont actifs.
   - **Le parc fond :** à 13 240 habitants, de 1 705 entreprises au départ à 232 au jour 1 000. Il reste 0,003 poste
     vacant par chômeur.
3. **La cause de refus qui domine est la concurrence,** dès 1 000 habitants et de plus en plus avec la taille. C'est
   surtout le plafond de 3 producteurs actifs : avec la correction, il y en a déjà 4 à 55 par type au départ. Viennent
   ensuite le délai par type et la viabilité. Le capital et la main-d'œuvre ne bloquent plus au-delà de 1 000
   habitants.

**Seuils absolus qui devraient être par habitant ou en proportion** (relevés dans le code ; aucun n'est corrigé).

| Domaine | Seuil | Où |
|---|---|---|
| Initialisation | une entreprise par type, quelle que soit la population (corrigé : `scenarioPopulation`) | `sim.dart:reset` |
| Initialisation | trésorerie de départ au moins 6 000 $ par entreprise | `sim.dart:reset` |
| Création | une création par jour pour toute l'économie | `sim.dart:_entryExit` |
| Création | 60 jours entre deux créations d'un même type (`entryCooldown`) | `sim.dart:_entryExit` |
| Création | pas de concurrent dès 3 producteurs actifs | `sim.dart:_entryExit` |
| Création | équipe de départ de 1 à 3 personnes | `sim.dart:_found` |
| Création | un seul fondateur possible : le citoyen le plus riche | `sim.dart:_found` |
| Embauche | 3 postes ouverts au plus par entreprise et par jour (`maxPostsPerDay`) ; repris par I1 et l'enveloppe I2 | `sim.dart:_decide`, `solventDividend`, `serviceBudget` |
| Filet de renflouement | équipe voulue bornée à l'effectif + 3 ; montant minimal d'un salaire | `sim.dart:_finance` |
| Dette | remboursement minimal de 5 $ par jour | `sim.dart:_capital` |
| Publicité | notoriété saturant à 20 unités (`brandPull`) et 10 unités (attrait d'un bien) | `sim.dart:brandPull`, `_choose` |
| R-D | coût d'un niveau : 40 × niveau², quel que soit l'effectif | `sim.dart:rndCost` |
| Détecteurs | écart comptable toléré de 1e-6 $ | `monitor.dart:MonitorConfig` |
| Protocole | choc « +25 immigrants » | `tool/stabilite.dart` |

Déjà proportionnels : trésor de départ (250 $ par habitant), capital de la Caisse (100 $ par habitant), parc de
logements (1,06 par habitant), plancher et réserve de l'État (en multiple de max(4 ; population ÷ 10)), seuils des
détecteurs (parts de la population), mises à pied (8 % de l'équipe), effet de la publicité sur la dépense (rapporté à
la population).

**Limites.**

- **Taille des séries.** 6 graines par taille après la correction au lieu de 10. À 13 240 habitants, les deux séries
  (sans et avec filets) ont pris une heure.
- **Coût d'une journée.** Il croît à peu près comme le carré de la taille : chaque achat compare toutes les offres du
  bien. Il faut l'optimiser avant de mesurer plus de graines à grande taille, ce qui doit se vérifier au bit près.
- **L'entonnoir compte des projets par type, pas des citoyens.** Les causes « crédit », « motivation » et
  « connaissance » n'existeront qu'avec la tâche 2.
- **Arrondi du nombre de copies.** Entre 1,5 et 2,5 fois 240 habitants, on obtient 2 copies ; le nombre d'entreprises par
  habitant va de +33 % (360 habitants) à −20 % (599 habitants) de celui de 240.

**Critère de sortie.**

- L'écart venait d'abord de l'initialisation, corrigée.
- Ce qui reste vient de la création d'entreprise, plafonnée en nombre absolu.
- La cause de refus dominante est la concurrence (plafond de 3 producteurs), suivie du délai par type.
- La tâche 2 se justifie : la création est trop rare à grande taille, et bloquée par des conditions fixes.

## 7. Performance du protocole à grande population (12 octobre 2026)

Aucune règle économique ne change. Chaque optimisation laisse identiques, au bit près :

- l'empreinte de `tool/parite.dart` sur la VM ;
- les résultats du protocole (valeurs comparées ci-dessous) ;
- les parties vérifiées pas à pas.

Machine : AMD Ryzen 7 5800X (8 cœurs, 16 fils), 32 Go.

### Tâche 1 — Mesurer

- **`tool/perf.dart`** : temps par jour (médiane des jours 100 à 300, graine 1, avec filets), mémoire maximale du
  processus, empreinte de la partie. L'option `--population` existait déjà dans `stabilite.dart` et `partie.dart`.
- **Profil à 3 000 habitants** (échantillonneur du service VM, 60 s). La consommation des ménages prend 97 % du temps,
  dont 82 % pour les loisirs (`_leisure`). Fonctions les plus coûteuses, en part du temps total (inclusif) :

| Fonction | Part |
|---|---|
| `Sim.quote` | 50,1 % |
| `Sim.buy` | 33,0 % |
| `Sim.bestPrice` | 31,0 % |
| tri stable des offres (`stableSort`) | 9,3 % |
| recherches dans les tables par nom de bien (`Map.[]`) | 37,2 % |

- **Cause.** Pour chaque bien envisagé, et chaque achat d'un ménage, `quote` et `bestPrice` parcourent tous les vendeurs
  du bien, et `buy` tire puis trie toutes leurs offres. Le nombre de vendeurs croît avec la population (scénario répété,
  § 6) : le coût d'une journée croît à peu près comme N².

### Tâche 2 — Corriger les goulots (fonctions modifiées : `Sim.quote`, `Sim.bestPrice`, `Sim._consume`, `Sim.buy`)

| Étape | 3 000 habitants (ms par jour) |
|---|---|
| Départ | 211 |
| 1. Meilleurs prix en cache pendant la consommation (`_BestOffers`) | 111 |
| 2. Ordre des offres sans tri complet (`_AllOffers`) | 102 |
| Essai rejeté : vendeurs élagués par une borne de la clé | 128 |
| 3. Prix et attraits lus une fois par bien et par jour | 94 |

1. **Meilleurs prix en cache.** Pendant la consommation, aucun prix ne change et les stocks ne font que baisser. Une
   liste des vendeurs triée par prix, avec un pointeur qui saute ceux passés sous une unité, donne donc les mêmes
   minima. Gain : 211 → 111 ms par jour.
2. **Ordre des offres.** Un achat s'arrête presque toujours après une ou deux offres. Les quatre premières sont prises
   par sélection de la plus petite clé (la première à égalité, comme le tri stable) ; le reste n'est trié que s'il en
   faut plus. Gain : 111 → 102 ms.
3. **Essai rejeté : élagage par une borne.** La clé d'une offre n'est jamais sous prix × attrait. Mais les entreprises
   répétées ont des prix voisins, presque tous dans la bande de 3 %, et le surcoût des tables d'appoint l'emporte :
   102 → 128 ms. Retiré.
4. **Prix et attraits lus une fois.** Pendant la consommation, prix et attrait des vendeurs sont lus une fois par bien
   et par jour ; seuls les stocks sont relus à chaque achat. Gain : 102 → 94 ms, moins de 10 %. Arrêt, selon la règle de
   la mission.

**Preuve d'identité.**

- **Parité.** L'empreinte de `tool/parite.dart` est identique (VM, puis exécutable natif). Une seule ligne diffère de
  l'ancienne référence : le tirage du 17ᵉ flux de hasard (`logement`), ajouté par la branche bâtiments, et non par ces
  optimisations.
- **Vérification pas à pas.** Le drapeau de test `Sim.verifyFastPaths` recalcule chaque meilleur prix par le chemin
  complet et lève une erreur à la moindre différence. Pendant l'essai d'élagage, il comparait aussi l'ordre des offres.
  Résultat : 0 différence sur 3 600 jours (1 000 habitants, graines 1 à 3, 400 jours ; 3 000 habitants, graines 1 à 3,
  200 jours ; sans et avec filets ; invariants exacts).
- **Protocole.** Les résultats sont identiques avant et après (voir la tâche 5). Au niveau 1, ils reproduisent
  `rapports/stat/complet-i1-i5.json`, la référence de la tâche 2 : 2 640 valeurs et 300 chocs, 0 différence.

**Temps par jour et mémoire** (graine 1, avec filets ; JIT par `dart run`) :

| Population | Avant | Après | Mémoire maximale (JIT ; natif) |
|---|---|---|---|
| 240 | 4,55 ms | 4,10 ms | 250 Mo ; 24 Mo |
| 1 000 | 32,6 ms | 21,2 ms | 254 Mo ; 51 Mo |
| 3 000 | 211 ms | 93,9 ms | 268 Mo ; 79 Mo |
| 13 240 | 3 937 ms | 1 372 ms | 287 Mo ; — |
| Exposant b (temps ≈ a·N^b, moindres carrés sur les 4 tailles) | 1,69 | 1,44 | |

La mesure « après » à 13 240 habitants a tourné en même temps qu'une autre exécution : le temps est peut-être un peu
surestimé.

**Ce qui reste superlinéaire, et pourquoi on s'arrête.** Chaque achat d'un ménage tire et compare les offres de tous
les vendeurs du bien : c'est la règle du marché, pas un détail d'implémentation. Rapprocher b de 1 demanderait de
changer cette règle, par exemple en tirant au hasard un échantillon de vendeurs par achat. C'est hors mission. Le GPU,
un port natif ou le SIMD ne sont pas justifiés tant que ce choix de modèle n'est pas tranché.

### Tâche 3 — Compilation native des outils

- **`tool/compiler.sh`** compile `stabilite`, `partie`, `perf`, `parite` et `echelle` dans `build/outils/` (16 s). Le
  moteur est figé dans chaque exécutable : modifier `lib/` pendant qu'un protocole tourne ne change plus la partie en
  cours.
- **Identité.** L'empreinte de parité de l'exécutable est identique à celle de la VM. Au niveau 1, l'exécutable et
  `dart run` donnent les mêmes 3 360 valeurs et 300 chocs ; au niveau 0, 16 isolats et 1 isolat les mêmes 560 valeurs.
- **Gain.**
  - **Durée :** aucun. Au niveau 1 : 2 min 45 s pour l'exécutable, 2 min 49 s pour `dart run`. À 3 000 habitants,
    105 ms par jour en natif contre 94 ms en JIT, machine chargée pendant la mesure native.
  - **Mémoire :** divisée par 3 à 10.
  - **Démarrage :** plus rapide (pas de compilation au lancement).

### Tâche 4 — Chocs depuis un instantané

- **Ce qui change.** Une tâche de chocs couvre désormais une graine et un réglage des filets. Les jours 1 à 300 sont
  joués une fois et l'instantané du jour du choc est enregistré. Les cinq chocs repartent de cet instantané
  (`runShockGroup`). Les résultats sont remis dans l'ordre d'avant (filets, choc, graine). `runShock`, la partie d'une
  traite, est gardé comme référence.
- **Vérification.** Graines 1 à 4, sans et avec filets, les cinq chocs : les 40 résultats branchés sont identiques,
  octet pour octet en JSON, aux parties jouées d'une traite.
- **Temps économisé.** 122 s d'une traite contre 85 s branchés sur cet échantillon, soit −30 %. C'est attendu : 300 +
  5 × 500 jours au lieu de 5 × 800.

### Tâche 5 — Niveaux du protocole (`--niveau 0|1|2`)

- **Les trois niveaux :**
  - **0, fumée :** 240 habitants, 5 graines × 500 jours, sans chocs ;
  - **1, décision :** 240 habitants, 30 graines × 1 500 jours, chocs compris ;
  - **2, échelle :** 240 / 1 000 / 3 000 / 13 240 habitants, 10 / 10 / 5 / 3 graines × 600 jours, sans chocs. Il donne
    les indicateurs par habitant (médiane [min–max]) et leur écart à 240 habitants.
- **Chaque rapport dit son niveau** et ce qu'il peut conclure. Le niveau 2 rappelle qu'il ne remplace pas le niveau 1.
  240 habitants y est ajouté comme référence, pour calculer les écarts.

**Durées du protocole** (exécutables natifs, 16 isolats) :

| Niveau | Avant (moteur sans les optimisations de la tâche 2) | Après | Résultats identiques |
|---|---|---|---|
| 0, fumée (10 parties) | 5 s | 4 s | 560 valeurs, 0 différence |
| 1, décision (120 parties, chocs branchés) | 3 min 17 s | 2 min 45 s | 3 360 valeurs et 300 chocs, 0 différence |
| 2, échelle (56 parties) | 48 min 33 s | 20 min 46 s | 3 136 valeurs, 0 différence |

La colonne « avant » utilise déjà les chocs branchés (tâche 4) et la compilation native (tâche 3). Elle ne mesure que
l'effet de la tâche 2. Le gain des chocs branchés est celui de l'échantillon de la tâche 4.

**Premier rapport de niveau 2** (`rapports/stat/niveau2.md`). Sans filets, le chômage passe de 9,9 % (240 habitants) à
48,0 % (13 240), et les naissances d'entreprises de 78,6 à 0,2 par an pour 1 000 habitants. C'est le défaut de passage
à l'échelle de la création d'entreprise (§ 6, tâche 1), mesuré ici sur 600 jours.

**Limites.**

- **Exposant b.** Il est estimé sur une graine et une durée de 200 jours ; il dépend de l'état de l'économie (nombre de
  vendeurs actifs).
- **Durée « avant ».** Elle est mesurée avec une copie du moteur où seul le cache des meilleurs prix est coupé ; la
  sélection des premières offres y reste. L'écart réel avec le moteur d'origine est donc un peu plus grand.
- **Vérification pas à pas.** `verifyFastPaths` couvre les meilleurs prix. L'ordre des offres et les attraits lus une
  fois ne sont vérifiés que par les empreintes, la parité et les protocoles identiques.

## 8. Recherche limitée des vendeurs et causes de fermeture (12 octobre 2026)

Aucune règle de comportement ne change par défaut. Le nouveau paramètre `sellerSample` est coupé (0) ; les causes de
fermeture et la concentration sont des mesures.

### Tâche 1 — Profil à 13 240 habitants

- **Conditions.** `sellerSample` coupé, une graine, 140 s d'échantillonnage. L'échantillonnage commence après
  170 s de partie, vers le jour 120 : au-delà de la chauffe.
- **Ce qui domine.** La consommation des ménages prend 95,5 % du temps, dont 79,7 % pour les loisirs. Parts inclusives :
  - `Sim.buy` : 82,5 % ;
  - choix de l'offre (`_AllOffers.pick`) : 37,5 % ;
  - construction de toutes les offres d'un achat (`_AllOffers`, un tirage par vendeur) : 32,1 % ;
  - tri stable des offres restantes : 29,7 %. Beaucoup d'achats demandent plus de 4 offres, faute de stock chez les
    premiers vendeurs.
- **Ce qui ne domine pas.** Le marché du travail et les ordres du jour ne figurent pas parmi les 20 premières
  fonctions.
- **Conclusion.** La boucle d'achat est bien la source du terme quadratique.

### Tâche 2 — Causes de fermeture et concentration (mesure)

- **Causes de fermeture** (`sim.dart:closeCause`).
  - Une entreprise ferme toujours après `exitIdleDays` jours sans employé. La cause est ce qui l'y a menée, lue dans cet
    ordre :
    1. **prix aberrant :** plus de 5 fois le prix de référence corrigé des salaires ;
    2. **faillite :** dernière fin d'emploi faute de pouvoir payer (salaires impayables, ou trésorerie sous 2 jours de
       salaires) ;
    3. **demande perdue :** effectif au-dessus du plan de production, ou demande lissée quasi nulle ;
    4. **sans employé :** départs volontaires, ou postes jamais pourvus ;
    5. **autre.**
  - **Où le lire :** dans le journal complet, l'événement `fermeture` porte la cause. Dans l'entonnoir, le compteur est
    `fermeture_<cause>`.
  - **Comment c'est su :** chaque entreprise garde la raison de sa dernière fin d'emploi (`Firm.lastLoss`, dans les
    instantanés).
- **Concentration** (protocole). Elle est calculée chaque jour, par bien, sur les ventes de chaque entreprise : part de
  la plus grande et indice de Herfindahl, puis moyennées après la chauffe. Le rapport donne leur médiane sur les biens.
- **Parc.** Parc moyen après la chauffe, naissances et morts par an en % de ce parc.

### Tâche 3 — `sellerSample`

- **Règle** (`sim.dart:_AllOffers.sampled`). Avec k > 0, chaque achat d'un ménage examine au plus k vendeurs, plus le
  vendeur de son dernier achat du même bien (habitude, `Sim.lastSeller`, dans les instantanés). Il prend le meilleur de
  cet échantillon selon la règle habituelle (prix, notoriété).
  - **Les vendeurs examinés** sont tirés par leur place dans la liste. Le tirage vient du flux `vendeurs` (code 18) et
    dépend de (graine, jour, acheteur), avec un sous-tirage (bien, rang de l'achat, essai). On fait au plus 4k essais,
    et on ne garde que les vendeurs qui ont du stock.
  - **Coût :** O(k) par achat. S'il y a k vendeurs ou moins, tous sont examinés.
  - **Choix du meilleur :** les offres retenues gardent l'ordre des vendeurs, pour départager les égalités comme
    d'habitude.
- **k = 0 ne change rien.**
  - L'empreinte de parité est identique au bit près, sur la VM et en JavaScript (dart2js `-O2`, `node`). Seule s'ajoute
    la ligne du tirage du nouveau flux.
  - Le niveau 1 relancé reproduit le précédent : 3 360 valeurs et 300 chocs identiques. Seuls changent les nouveaux
    compteurs de fermeture, ajoutés à l'entonnoir et aux relevés des jours 500 et 1 000.
- **k > 0** (1 000 habitants, k = 5) : la partie est déterministe, les invariants sont exacts en mode développement, et
  la reprise depuis un instantané est exacte.

**Temps par jour** (`tool/perf.dart`, exécutable natif, graine 1, avec filets, médiane des jours 100 à 300 ; machine au
repos, une mesure à la fois) :

| Population | k = 0 | k = 3 | k = 5 | k = 8 |
|---|---|---|---|---|
| 240 | 4,72 ms | 5,09 ms | 5,16 ms | 5,40 ms |
| 1 000 | 24,2 ms | 28,5 ms | 28,5 ms | 30,7 ms |
| 3 000 | 101 ms | 66,0 ms | 96,8 ms | 108 ms |
| 13 240 | 1 322 ms | 344 ms | 408 ms | 484 ms |
| Temps par habitant à 13 240 | 99,8 µs | 26,0 µs | 30,8 µs | 36,5 µs |

**Exposant b**, par tranche, log(t₂ / t₁) ÷ log(N₂ / N₁) :

| Tranche | k = 0 | k = 3 | k = 5 | k = 8 |
|---|---|---|---|---|
| 240 → 1 000 | 1,15 | 1,21 | 1,20 | 1,22 |
| 1 000 → 3 000 | 1,30 | 0,76 | 1,11 | 1,14 |
| 3 000 → 13 240 | 1,73 | 1,11 | 0,97 | 1,01 |
| Ajustement sur les 4 tailles | 1,40 | 1,03 | 1,09 | 1,12 |

- **À 240 et 1 000 habitants, k = 5 et k = 8 donnent la même partie que k = 0** (même empreinte). Il n'y a jamais plus
  de k + 1 vendeurs d'un même bien : l'échantillon les couvre tous. Le léger surcoût vient de la tenue de l'habitude.
- **Le temps dépend aussi de la partie.** Le parc varie avec k (589, 706, 682 et 647 entreprises au jour 300 à 13 240
  habitants). C'est pourquoi k = 3 est plus rapide que k = 5 à 3 000 habitants.

**À 13 240 habitants, 1 000 jours, 3 graines appariées** (graines 1 à 3). Pour k = 0, les valeurs sur les graines 1 à 3
sont celles des 6 graines à ±1 point près. Médianes :

| Sans filets | k = 0 | k = 3 | k = 5 |
|---|---|---|---|
| Chômage moyen | 62,2 % | 53,8 % | 58,3 % |
| Faim moyenne | 50,9 % | 21,3 % | 30,1 % |
| Sans-abri moyen | 32,8 % | 57,8 % | 66,0 % |
| Gini moyen | 0,88 | 0,91 | 0,93 |
| Parc : départ ; jour 500 ; jour 1 000 | 1 705 ; 441 ; 230 | 1 705 ; 605 ; 540 | 1 705 ; 556 ; 432 |
| Naissances / an, en % du parc moyen | 0,66 % | 0,41 % | 1,44 % |
| Morts / an, en % du parc moyen | 124 % | 67 % | 81 % |
| Naissances ; morts (en 1 000 jours) | 8 ; 1 489 | 7 ; 1 175 | 23 ; 1 285 |
| Fermetures : faillite | 1 067 | 1 101 | 1 119 |
| Fermetures : prix aberrant | 264 | 65 | 137 |
| Fermetures : demande perdue | 91 | 4 | 12 |
| Fermetures : sans employé | 69 | 5 | 21 |
| Part de la plus grande entreprise (médiane des biens) | 81 % | 80 % | 68 % |
| Herfindahl (médiane des biens) | 0,77 | 0,76 | 0,61 |

| Avec filets | k = 0 | k = 3 | k = 5 |
|---|---|---|---|
| Chômage moyen | 63,8 % | 53,8 % | 58,8 % |
| Faim moyenne | 35,7 % | 21,0 % | 28,3 % |
| Sans-abri moyen | 36,7 % | 39,2 % | 46,5 % |
| Parc : jour 500 ; jour 1 000 | 488 ; 228 | 630 ; 581 | 592 ; 536 |
| Naissances ; morts par an, en % du parc moyen | 0,23 % ; 114 % | 0,33 % ; 62 % | 0,35 % ; 68 % |
| Fermetures : faillite ; prix aberrant | 900 ; 325 | 1 024 ; 69 | 996 ; 129 |

- **Sens des effets, k = 5 contre k = 0, graine par graine.** Les 3 graines vont dans le même sens, sans et avec filets :
  - chômage : −2 à −7 points ;
  - faim : −7 à −24 points ;
  - sans-abri : +8 à +40 points ;
  - morts en % du parc : −40 à −47 points ;
  - parc moyen : +139 à +160 entreprises.

  Avec 3 graines, il n'y a pas d'intervalle de confiance : ce sont des tendances, pas des conclusions.
- **Concentration par bien** (13 240 habitants, sans filets ; part de la plus grande / Herfindahl / vendeurs actifs) :

| Bien | k = 0 | k = 3 | k = 5 |
|---|---|---|---|
| Pain | 57 % / 0,51 / 4,2 | 13 % / 0,07 / 29,2 | 22 % / 0,13 / 17,6 |
| Repas | 86 % / 0,82 / 1,8 | 11 % / 0,06 / 35,3 | 26 % / 0,17 / 16,5 |
| Télé | 51 % / 0,49 / 19,1 | 11 % / 0,06 / 43,0 | 17 % / 0,10 / 28,6 |
| Logement | 3 % / 0,03 / 44,1 | 11 % / 0,05 / 46,0 | 9 % / 0,05 / 46,0 |
| Électronique | 95 % / 0,94 / 1,3 | 99 % / 0,99 / 1,0 | 99 % / 0,99 / 1,1 |
| Carburant | 87 % / 0,84 / 2,2 | 90 % / 0,88 / 1,7 | 90 % / 0,88 / 1,8 |

**Niveau 1 à 240 habitants, k = 5 contre k = 0, apparié (30 graines)**
(`rapports/stat/vendeurs-k5-contre-k0-niveau1.md`).

- **Aucune différence**, sur aucun indicateur, sans et avec filets : intervalles [0 ; 0], 30 graines égales sur 30.
- **C'est attendu.** À 240 habitants, un bien n'a jamais plus de k + 1 vendeurs : la recherche limitée examine tous les
  vendeurs, comme k = 0.
- **Ce que cela dit :** k = 5 ne change rien à la taille de réglage du modèle. Ce n'est pas une preuve d'innocuité aux
  autres tailles.

**À 240 habitants** (k = 0, 6 graines, 1 000 jours) :

- **Sans filets.** Naissances 140 % et morts 165 % du parc par an (parc moyen de 19,5) ; la plupart des fermetures sont
  des faillites (76 sur 86).
- **Avec filets.** Naissances 12,7 % et morts 29,4 % du parc par an.
- **Concentration.** Elle vaut 100 % (Herfindahl 1,00) : un seul vendeur actif par bien.

### Conclusion

1. **L'échantillonnage répare le coût de calcul.** À 13 240 habitants, la journée passe de 1 322 à 408 ms avec k = 5,
   et l'exposant b de 1,40 à 1,09.
2. **Il ralentit la mortalité, sans la réparer.**
   - Les morts passent de 124 % à 81 % du parc par an (k = 5, sans filets), et le parc au jour 1 000 de 230 à 432.
   - Mais la cause dominante reste la faillite, et non la demande perdue : 1 119 fermetures sur 1 285 avec k = 5 (87 %),
     1 067 sur 1 489 avec k = 0 (72 %).
   - L'information imparfaite répartit mieux la demande des biens de consommation (pain : 57 % → 22 % pour la plus
     grande entreprise). Mais elle ne change ni la filière amont (électronique, carburant restent à un vendeur), ni la
     cause des faillites.
3. **Le plafond de naissances reste le blocage principal.** Avec k = 5, les naissances valent 1,4 % du parc par an
   contre 81 % de morts. Le parc ne peut que fondre tant que la création est plafondée en nombre absolu : une par jour,
   un délai par type, 3 producteurs au plus (§ 6, tâche 1).
4. **Effet de bord : le logement.** Avec k > 0, un ménage qui n'examine que quelques bailleurs peut dormir dehors alors
   qu'un autre a de la place. Sans-abri : +8 à +40 points selon la graine et les filets. Si `sellerSample` devient actif,
   il faudrait sans doute exclure le logement (un bien dont on cherche une place libre, pas un prix), ou prendre un k
   plus grand pour lui. C'est une décision de règle, réservée à Francis.

**Recommandation** (la décision reste à Francis).

- **Pour les protocoles à grande taille :** k = 5 est un bon compromis de coût. Le temps est quasi linéaire, et à
  240 habitants il ne change rien.
- **Comme règle du jeu :** ne pas l'activer avant d'avoir décidé du cas du logement, puis repris la création
  d'entreprise. Sans cela, le chômage reste au-dessus de 50 % à 13 240 habitants, quel que soit k.

**Limites.**

- **Peu de graines à 13 240 habitants** (3 par valeur de k) : des tendances, pas des conclusions.
- **Faillite ou demande perdue ?** La cause « faillite » ne dit pas pourquoi l'entreprise manquait d'argent : ventes
  insuffisantes, prix trop bas ou intrants trop chers. La distinguer de « demande perdue » demanderait de suivre le
  chiffre d'affaires des derniers jours.
- **Concentration.** Elle est calculée sur les ventes aux ménages comme aux entreprises, y compris les services publics
  distribués gratuitement.
- **Tests.** La suite Flutter n'a pas été relancée pour cette tâche ; la vérification passe par la parité, le niveau 1
  et les contrôles ci-dessus.
