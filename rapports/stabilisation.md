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
