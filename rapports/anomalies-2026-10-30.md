# ÉcoNodes : liste des anomalies, mise à jour du 30 octobre 2026

Remplace la liste du 20 octobre (`econodes-anomalies.md`). État du dépôt : `main` à `c0df858`. Fusionnés depuis le
20 octobre : distribution de l'excédent de trésorerie (`fix/stabilisation`), explorateur de citoyens, banque centrale,
temps partiel par défaut, douane (prix mondiaux en vagues, droit de douane, taux de change flottant, demande étrangère),
renaissance des filières (`revival` + variantes), importations de secours de l'hôpital et dette publique (`fix/importations-secours`, 30 octobre). Branches encore à part : `mesure-concentration`, `tests-produits`.
Rien n'est poussé.

Sources : code actuel, MODELE.md (§ 6.17 à 6.22), `rapports/stabilisation.md`, `rapports/renaissance-filieres.md` et
`rapports/renaissance/`, mesures de la session douane (240 citoyens, 3 à 5 graines, 600 à 1 500 j). « Non revérifié » =
repris de la liste précédente sans nouvelle mesure.

Réglages par défaut aujourd'hui :

| Règle | Moteur | Interface |
|---|---|---|
| `partTime` (temps partiel) | **actif** | actif (interrupteur à l'écran de départ) |
| `revival` + `revivalPlannedDemand` (renaissance des filières) | coupée | **active** (onglet Modèle) |
| `tradeWaves`, `floatingFx`, `foreignDemand` (douane) | coupés | **actifs** ; frontières fermées, seules les vagues jouent, sur le prix des importations de secours |
| `trade` (frontières ouvertes) | coupé | coupé (écran de départ, nœud Douane en jeu) |
| `policyPassThrough` (banque centrale) | coupée | **active** |
| `excessCashReturn` (excédent de trésorerie) | coupée | **active** depuis le 30 octobre (onglet Modèle) |
| `publicImports` (importations de secours de l'hôpital) | coupées | **actives** depuis le 30 octobre (fiche Douane) |
| `stateBorrowing` (dette publique) | coupée | **active** depuis le 30 octobre (fiche de l'État) |
| `leases` (baux) | coupés | **actifs** depuis le 1er novembre (onglet Modèle, section « Logement ») |
| `equalBanks`, `purchaseLoans` (banques à égalité, prêt d'achat fidèle) ; `reservePerCitizen` | coupés ; 100 000 $ | **actifs** depuis le 1er novembre ; **2 000 $** (onglet Modèle, sections Banques et Crédit) |
| `healthWearIfDeprived` | coupée | coupée |

## 1. Anomalies d'origine (A1 à A9)

| Code | Anomalie | État au 30 octobre |
|---|---|---|
| A1 | La santé s'effondre (hôpital arrêté) | **Cause trouvée, corrigée (fusionné le 30 octobre, actif dans l'interface).** Chaîne : à 240 citoyens, le cuivre et le pétrole ont une demande d'un quart d'employé, par à-coups ; la mine perd son employé faute de trésorerie et fait faillite (cuivre éteint dans 19 parties sur 20, jour médian 28), l'électronique puis le plastique s'arrêtent, l'hôpital ne soigne plus, la santé tombe à 0,05 ; sans filets, l'économie s'écroule ensuite (chômage 95 %). Réglages de l'interface, 10 graines × 1 500 j : effondrements 7/10 sans filets, 4/10 avec. Correctif `publicImports` (importations de secours des établissements publics, frontières fermées) : 0/20, santé 0,83 à 0,88, 3 000 à 85 000 $ importés. Les arrêts restants (30 j et plus dans 11 parties sur 20 : trésor vidé par une récession, enveloppe de l'hôpital coupée) sont réglés par la dette publique (`stateBorrowing`) : 0 à 8 jours sans soins, dette au plus 254 000 $ (< 2,5 % du PIB annuel), remboursée dans 19 parties sur 20 ; chômage des jours 1100-1500 : 66 % → 5 % sans filets, 20 % → 7 % avec. `healthWearIfDeprived` reste coupée |
| A2 | Travail indivisible : les filières disparaissent dans un petit marché | **Largement traité.** `partTime` actif par défaut (moteur compris) depuis le 21 octobre. Cause du non-retour trouvée : la création d'entreprises ne lisait que la demande non servie, que l'importation et la chute de l'aval font disparaître. `revival` + `revivalPlannedDemand` (interface) : frontières ouvertes, chômage −4,0 à −4,4 pt contre l'économie sans règle (30 graines), 25 types actifs en fin au lieu de 14 avec `revival` seul ; économie fermée : non concluant |
| A3 | La ferme perd de l'argent (coproduit bétail sans acheteur) | **Ouvert.** `extremes_test.dart` toujours sauté pour cette raison. Répartition des coûts des coproduits à décider |
| A4 | Effondrement de fin de partie, trésor de l'État vide | Réglé par I3 (non revérifié) |
| A5 | Démarrage en sur-emploi | **Cause trouvée, corrigée dans l'interface (démarrage à l'équilibre, voir N6).** Le plan promettait 94 % d'emploi mais la règle d'embauche en voulait ≈ 104 % (efficacité des employés < 1, arrondi des équipes), plus une demande excédentaire (épargne de départ au-dessus de la cible, panier du plan différent des achats réels) |
| A6 | Le logement manque (sans-abri nombreux) | **Causes trouvées et traitées le 1er novembre** (branche `fix/immobilier`). (1) Pointe au jour 1 avec Bâtiments (214 à 286 sans-abri à 2 500 citoyens, 800 à 1 086 avec les Banques) : le plan de départ (`planFromHouseholds`, N6) comptait moins d'une nuitée par personne ; corrigé, le logement reste un besoin fixe : aucun sans-abri au jour 1. (2) Vagues de 100 à 300 sans-abri (jours 20 à 60, et durables dans la spirale salaires-prix Bâtiments × Banques) : se loger, c'était acheter chaque jour une nuitée produite par un employé ; quand le marché du travail est saturé, les bailleurs perdent leurs employés et des ménages solvables dorment dehors à côté de logements vides. **Baux** (`leases`, actifs dans l'interface) : pointe de sans-abri 188 → 16 sans Bâtiments, 274 → 0,2 avec (2 500 citoyens, 10 graines, 1 500 j), chômage inchangé à la précision de la mesure ; avec le coût du capital dans le loyer, l'accession à la propriété demeure (466 propriétaires sur 2 500 au lieu de 1 757) et la vague d'hypothèques (N4) est plus petite (indice des prix final 4,31 → 1,67). Reste : sans Bâtiments, quelques chômeurs sans le sou perdent leur bail quand le personnel des nouveaux baux manque (pointes de 0 à 61) |
| A7 | Prix aberrants, sauts de l'indice des prix | **Cause trouvée, corrigée dans l'interface (`normalUtil` = 0,5, branche `fix/prix-aberrants`).** Une entreprise à 5-15 % d'utilisation répartit frais fixes et heures minimales sur une production minuscule : coût réel 7-8 fois la référence, prix qui suit malgré une marge au plancher, clients qui fuient. Les sauts de l'indice (jusqu'à +63 % en un jour) viennent d'un bien vendu à l'unité (bijoux) à prix aberrant. Prix au coût normal (Godley-Lavoie), 240 citoyens, 10 graines : prix > 3× la référence 14,6 → 1,3 % des jours-entreprises, fermetures 17 → 5, indice final 0,75-2,63 → 1,04-1,28, chômage 7,6 → 5,4 %. **Paradoxe à 2 500 citoyens résolu le 31 octobre : c'était l'échantillon.** Sur 10 graines, réglages actuels (démarrage à l'équilibre compris), jours 1 001 à 1 500 : chômage 9,2 → 6,4 % avec le coût normal (écart-type 3,2 → 2,0, mieux dans 8 graines sur 10), employés 2 241 → 2 314, entreprises 115 → 183. Les entreprises en plus sont de petites entreprises d'amont (1 à 2 employés, souvent à perte : « zombies ») qui n'enlèvent pas d'emplois. Le 4,4 → 8,3 % venait de 5 graines favorables au coût réel ; sur 10 graines sans démarrage à l'équilibre, 6,3-7,2 % contre 7,1 %, écart non significatif. Sortie pour pertes persistantes essayée et retirée |
| A8 | Services vendus sous leur coût | Hôpital et école : I2. Pétrochimie et électronique : non revérifiées. Lié à A1 (plastique vendu sous son coût) |
| A9 | Caisse insolvable sans filets | I4 appliqué ; effet des faillites de banques (module Banques) non vérifié |

## 2. Anomalies trouvées avant le 13 octobre

| Anomalie | État |
|---|---|
| Effondrement à grande échelle (k = 0) | Contourné : k = 5 par défaut. Effet de k sur le chômage non confirmé à 30 graines |
| Chômage du défaut à grande échelle | 2 500 citoyens : 25 % sans filets / 18 % avec ; 240 : 8 % / 7 % (mesures du 19 octobre, avant `partTime` par défaut : **à remesurer**) |
| Renouvellement des entreprises irréaliste | **Ouvert, aggravé en jeu.** 240 citoyens : 147 % de naissances et 165 % de morts par an (repère canadien : 10,8 % et 9,0 %). La renaissance ajoute des relances qui échouent : frontières ouvertes, naissances 9,6/an et morts 10,8/an avec `revivalPlannedDemand` (15,7 et 16,7 avec `revival` seul) |
| Monnaie non neutre (seuils en dollars) | Non revérifié |
| Trésorerie bloquée (I1) | Réglée par `excessCashReturn`, active dans l'interface depuis le 30 octobre (forme aiguë chez le bailleur : N3 ; forme générale : N16) |
| Comportement pauvre (pas de négociation salariale) | Module Rôles et négociation actif dans l'interface ; entrepreneuriat fusionné |

## 3. Anomalies du 13 au 20 octobre

| Code | Anomalie | État |
|---|---|---|
| N1 | Module Produits : l'économie s'effondre à 2 500 citoyens | **Ne se produit plus avec le temps partiel (actif par défaut).** Mesure du 30 octobre (2 500 citoyens, 3 graines × 1 500 j, chômage moyen des jours 1000-1500, Produits coupé → actif) : sans temps partiel, 2,6 % → 48,1 % (rôles coupés) et 17,4 % → 37,0 % (rôles actifs) ; avec, 11,9 % → 5,2 % et 26,8 % → 7,2 %. Sans temps partiel, crise vers le jour 500-700 : hôpital et école éteints, prix ×10, chômage 71 %, fabricants de machines disparus (même mécanisme que A2, aggravé par la division de la demande entre variétés). Confirmation, réglages de l'interface, 10 graines × 3 000 j (jours 2501-3000) : Produits coupé 26,5 %, actif 13,2 % (meilleur dans 8 graines sur 10). Reste ouvert : N16 |
| N2 | Produits : l'émergence est faible | Ouvert. Seuil de marge d'entrée (15 %) au-dessus de la marge d'équilibre (13,04 %) ; 99,6 % des achats par habitude |
| N3 | Bâtiments × Banques : effondrement à 240 citoyens | **Correctif fusionné** (`excessCashReturn` + plafond du fonds de reconstruction : chômage 75 % → 11 %, 30 graines, 3 000 j), coupé dans le moteur, **actif dans l'interface depuis le 30 octobre** (inflation en plus : N6). Le 1er novembre, avec les baux et sans les correctifs de N4, les prix étaient encore multipliés par 73 à 105 dans 3 graines sur 5 ; avec les correctifs de N4, chômage 6,2 % sur 10 graines × 3 000 j, prix au plus haut × 7,4 |
| N4 | Dérive lente à 2 500 citoyens avec Bâtiments | **Traité le 1er novembre** (branche `fix/n4`). Remesuré avec les réglages actuels (baux compris, 10 graines × 3 000 j) : sans Banques, plus de dérive (chômage 6-7 %, prix stables) ; avec les Banques, effondrements (chômage des jours 2 001-3 000 13,9 %, pire graine 46,5 %, prix jusqu'à × 59). Trois causes, trois règles actives dans l'interface : (1) les intérêts des hypothèques n'entraient dans le revenu d'aucune banque (la Caisse paraissait déficitaire, ne versait jamais de dividende, ≈ 4 M$/an restaient dans les banques) et les banques commerciales, sans hypothèques, faisaient faillite : **banques à égalité** (`equalBanks` : la Caisse est une banque comme les autres, hypothèques chez la banque de l'emprunteur) ; (2) dotation des banques de 100 000 $ par citoyen : **2 000 $ dans l'interface** (≈ 3 fois le capital exigé) ; (3) le prêt « ordinateur » prêtait deux fois un prix de référence absurde, même sans ordinateur en vente, et l'argent était dépensé : **prêt d'achat fidèle** (`purchaseLoans`). Ensemble : chômage 7,1 % (pire graine 10,1 %, mieux dans 9 graines sur 10), prix au plus haut × 4,7 ; à 240 citoyens 6,2 % (pire 7,5 %). Reste la vague d'achats du démarrage (prix × 4,7 à 2 500 citoyens, × 7,4 à 240) puis une baisse lente des prix |
| N5 | Les filets semblent aggraver le chômage à 2 500 citoyens et 3 000 j | Non expliqué |
| N6 | Inflation de base élevée | **Cause trouvée, corrigée dans l'interface (« Démarrage à l'équilibre », branche `fix/inflation-depart`).** Avec les réglages du 30 octobre, l'inflation n'était plus continue : un choc de démarrage (prix et salaires +35 à 55 % en 100 jours, marché du travail saturé) puis des prix stables. Quatre causes, quatre réglages (MODELE.md § 5) : épargne de départ 17 % au-dessus de la cible des ménages, panier du plan différent des achats réels (bijoux 49/j prévus, 2 achetés), santé de départ uniforme à 1, plan qui ignore l'efficacité des employés et l'arrondi des équipes. Indice au jour 100 : 1,44 → 1,05 à 240 citoyens, 1,52 → 1,16 à 2 500. Reste : un creux de déflation entre les jours 500 et 1 500 (−8,9 %/an en moyenne à 240 citoyens), qui existait déjà |
| N7 | Concentration extrême à 2 500 tous modules (Herfindahl 0,94) | Non réconcilié avec `tests-produits` ; la branche `mesure-concentration` (non fusionnée) mesure concentration et mortalité selon k |
| N8 | Gini hors bande : 0,45 à 2 500, 0,57-0,60 à 10 000 | Ouvert |
| N9 | Alertes critiques ouvertes dans 10/10 parties à 2 500 | Ouvert |
| N10 | Retour à l'équilibre après un choc : échoue presque toujours à 240 | Ouvert |
| N11 | Offre de logements : nombre de bailleurs, 2 chantiers simultanés | **Vérifié le 1er novembre : ce n'était pas la cause des sans-abri.** À 2 500 citoyens avec Bâtiments, le parc passe de 2 650 à ≈ 3 240 logements en 1 500 j, dont plus de 600 en liquidation (vides) ; les sans-abri avaient de l'argent et des logements vides à côté d'eux (voir A6). Le plafond de 2 chantiers par bailleur n'a pas été en cause dans les mesures |

## 4. Anomalies nouvelles (20-30 octobre)

| Code | Anomalie | État |
|---|---|---|
| N12 | **Frontières ouvertes, l'économie se vide de sa monnaie** : importations ≈ 1,5 M$ contre exportations ≈ 0,15 M$ (seuls les surplus partaient), masse 1,6 → 0,2 M$, chômage 97 % (2 graines sur 3, 600 j) | **Traité** : taux de change flottant (`floatingFx`, 5 %/j) et demande étrangère (`foreignDemand`), actifs dans l'interface. Chômage moyen des jours 1000-1500 (5 graines) : fermé 23 %, change seul 38 %, change + demande 30 % (15-20 % dans 4 graines, une graine s'effondre : intrants importés, filières éteintes). La renaissance vise ce cas ; **non remesuré avec les réglages actuels de l'interface réunis** |
| N13 | Frontières ouvertes : un droit de douane seul ne suffit pas (50 % : chômage 26 à 48 %) | Constat ; les réglages restent disponibles dans la fiche Douane |
| N14 | **L'économie fermée dérive sur 1 500 jours** : chômage 8 à 31 % selon la graine (240 citoyens, jobs + entrepreneuriat + produits ; moyenne des jours 1000-1500 : 23 %) | Ouvert. Rappel de méthode (§ 5) : à 600 j, la même configuration donnait 10 à 20 % |
| N15 | Les relances de filières échouent souvent : 150 relances sur 174 viennent de la demande dérivée, elles vendent 11 % de ce signal sur leurs 60 premiers jours, 114 meurent | En partie traité par `revivalPlannedDemand` (faillites divisées par deux) ; voir le renouvellement des entreprises (§ 2) |
| N16 | **Dérive longue à 2 500 citoyens, réglages de l'interface** (3 000 j, 10 graines) : Produits actif, le chômage passe de ≈ 7 % (jours 1000-1500) à 13,2 % (jours 2501-3000, de 0,1 à 36,8 % selon la graine), avec déflation (indice des prix 0,42 à 1,31, salaire de ≈ 250 à 62-194 $) ; Produits coupé, 26,5 % et le parc de machines s'éteint presque (2 à 1 627 machines contre ≈ 4 500 au départ) | **Cause trouvée : trésorerie accumulée par les entreprises (forme générale d'I1).** Graine 10 : ménages 5,6 → 1,9 M$ (médiane 2 010 → 494 $), entreprises 9,2 → 14,3 M$ entre les jours 250 et 3 000 ; même pente plus douce dans les graines saines. `excessCashReturn` : chômage 13,2 → 6,9 % (10 graines, jours 2501-3000 ; pire graine 27,7 → 12,2 %) ; réserve ramenée à 30 j : 7,9 %, sans gain (l'argent restant est dans la réserve de 60 j de coûts, pas en excédent). À 240 citoyens : 14,1 → 12,3 %, effet mêlé (5 graines sur 10), indice des prix médian ≈ 2,3 → 3,3 en 3 000 j. **Règle activée dans l'interface le 30 octobre.** La renaissance n'a eu aucun effet mesurable à 2 500 citoyens (chiffres identiques avec ou sans) : à vérifier si elle s'y déclenche |
| N17 | **Les voyages emploient 30 à 40 % des travailleurs** (2 500 citoyens, réglages de l'interface, jours 1 001 à 1 500) : 0,67 voyage par personne et par jour, 41 % des achats des ménages ; la productivité est normale (2 forfaits par employé et par jour) | **Cause trouvée le 31 octobre ; laissé tel quel (choix de jeu, décision de Francis).** La qualification ne redescend jamais (ni vieillissement, ni retraite, ni relève) : qualification moyenne 0,84 → 2,68 et professionnels 9 → 85 % de la population en 1 500 j. Les professionnels ont le goût du voyage (goût 1,5 contre 0,3 pour un manœuvre ; poids du luxe 1,2 contre 0,15), le luxe garde environ 65 % de leur budget de loisirs même comblé (plancher de 0,25 dans la répartition, satisfaction 0,98), et le voyage est le luxe qui apporte le plus par dollar (quantité « normale » : un par jour). Sans éducation (`eduRate` = 0), voyages 2 à 6 % des emplois, mais sorties 45 % : le travail se concentre toujours sur le loisir préféré de la classe majoritaire, car se nourrir et se loger ne coûte que 23 $/j pour 210 $ de revenu (11 %). Pendant la bascule des sorties vers les voyages (jours 400 à 700), chômage 12 à 15 % ; sans éducation, pas de bosse |

## 5. Remarques de méthode

- Les parties de 1 000 à 1 500 jours cachent des dérives (N1, N3, N4, N14) : valider sur 3 000 jours au moins.
- Comparer à horizon égal : la mesure du commerce extérieur à 600 j laissait croire que le change seul aggravait le
  chômage par rapport à l'économie fermée ; à 1 500 j, l'économie fermée dérive aussi (N14).
- `tool/reference.sh` joue les exécutables de `build/outils/` : les recompiler (`bash tool/compiler.sh`) avant de
  vérifier, sinon la référence diverge à tort.
- À 2 500 citoyens, 5 graines ne suffisent pas : l'économie est chaotique (un changement minime, comme le prix des
  importations de secours, fait passer une graine de 6,1 à 14,4 % de chômage) et une graine sur cinq environ part vers
  11 à 19 % au coût réel. Comparer par paires sur 10 graines au moins (A7).

## 6. Décisions de Francis en attente

1. Module Produits : N1 ne se produit plus avec le temps partiel ; reste N2 (émergence faible) et la dérive longue N16.
2. Creux de déflation des jours 500 à 1 500 (N6). (Le paradoxe A7 à 2 500 citoyens est résolu : c'était l'échantillon.)
3. N4 (Bâtiments × Banques) : traité (banques à égalité, dotation réaliste, prêt d'achat fidèle) ; reste la vague d'achats du démarrage (pistes : propriétaires au départ, règle de banque centrale) et, sans baux, l'hyperinflation (prix × 40).
4. `healthWearIfDeprived` (A1) et répartition des coûts des coproduits (A3).
5. Bâtiments : les sans-abri sont traités (baux, A6) ; reste le calibrage (prix d'un logement ≈ 90 jours de salaire).
6. Branches `mesure-concentration` et `tests-produits` : fusionner, garder ou supprimer.
