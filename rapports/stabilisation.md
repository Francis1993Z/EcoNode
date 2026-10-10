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
