# ÉcoNodes : état des lieux du modèle, des filets et des anomalies

Date : 10 octobre 2026. État mesuré : commit `ff43758` (tâche 5) plus la tâche 3, pas encore commitée.

Sources :

- [`tache3-complet.md`](tache3-complet.md) : modèle complet, 5 graines × 1 500 jours, sans puis avec filets, chocs.
- [`tache3-noyau.md`](tache3-noyau.md) : le même protocole, tous modules coupés (mesuré pour cet état des lieux).
- Des traces jour par jour des 5 graines, sans et avec filets : épisodes, état des entreprises en cause, filets par
  bénéficiaire. Elles viennent de sondes temporaires, non versionnées.
- Trois variantes sans chocs : « Maladies et soins » coupé, « Machines » coupé, les deux coupés.

Aucun code ni paramètre n'a été modifié pour cet état des lieux.

## En bref

1. **La comptabilité est exacte.** L'écart est de 0 sur toutes les parties, avec et sans filets.
2. **Avec filets, l'économie paraît saine, mais c'est le renflouement qui la tient.** Chômage 3–5 %, faim ≤ 0,2 %.
   On compte 652 à 912 renflouements par partie, à plus de 99 % pour des entreprises en perte. L'hôpital en reçoit
   20 à 37 % : dans 4 graines, il vend sous son coût de revient 1 397 à 1 399 jours sur 1 400.
3. **Sans filets, la population tombe malade et n'est plus soignée.** Dans les 5 graines, la santé moyenne tombe à
   0,05–0,14 dès le jour 500 et les travailleurs ne rendent plus que 45 % de leur efficacité. Aucun détecteur ne le
   signale. Trois graines sur cinq s'effondrent en fin de partie (chômage de 48 à 77 % au jour 1 500). Le problème
   existait déjà à la tâche 5.
4. **Couper le seul module « Maladies et soins » remet l'économie sans filets d'aplomb :** chômage 3–5 %, faim et
   sans-abri ≈ 0 %, Gini 0,24–0,28. C'est le levier principal.
5. **Cause racine commune : le travail est indivisible dans une économie de 240 habitants.** 11 entreprises sur 31
   démarrent avec un employé ou moins. La filière métaux, informatique et machines (11 types) disparaît dans toutes
   les graines, même avec filets. L'hôpital perd son électronique, et le parc de machines fond de ~400 à 0–5.
6. **La ferme perd de l'argent par construction.** Son coproduit, le bétail, se vend mal, à 60 % de son coût. Et les
   dividendes vident sa caisse avant qu'elle puisse embaucher.
7. **Critères de sortie : 3 sur 9 pour le modèle complet, 4 sur 9 pour le noyau.**

## 1. Le modèle aujourd'hui

### Agents et biens

| Agent | Nombre | Rôle |
|---|---|---|
| Citoyens | 240 | Travaillent selon leur qualification (manœuvre, technicien, professionnel), consomment, épargnent, possèdent les entreprises |
| Entreprises | 31 au départ (une par type) | Produisent selon une recette fixe. Le 32ᵉ type, le chantier forestier, n'est pas créé : depuis la tâche 2, le bois n'a plus d'acheteur (il servira à la construction, tâche 6) |
| État | 1 | Impôt de 12 % sur salaires et dividendes ; assurance-emploi de 80 $/j ; paie soins et cours tant que son trésor dépasse 9 600 $ ; redistribue 5 %/j de ce qui dépasse 57 600 $ |
| Caisse populaire | 1 | Prête aux entreprises en créant la monnaie ; capital de 24 000 $ (100 $ par habitant) ; ne ristourne rien sous 15 % de fonds propres |

33 biens : 9 primaires, 12 secondaires, 12 tertiaires, dont 13 achetés par les ménages et 6 que les entreprises achètent hors recette (services et machines).

### Une journée

1. Marché du travail : les entreprises qui paient le plus embauchent d'abord. Un employé change d'emploi (3 % de chance
   par jour) pour au moins 8 % de plus. Les chômeurs touchent l'assurance-emploi.
2. Production : recette fixe. Un intrant qui pèse moins de 15 % du coût d'un lot ralentit la production au lieu de
   l'arrêter. On produit la demande prévue et de quoi revenir à 4 jours de stock.
3. Salaires (impôt prélevé), puis achats d'intrants et de services : comptabilité, entretien, publicité, R-D.
4. Ménages, dans l'ordre : manger, se loger, se soigner, s'équiper, se former, puis se divertir.
5. Filets anti-famine et plancher de logement.
6. Capital : usure des machines, service de la dette, investissement, ristournes de la Caisse.
7. Décisions des entreprises : prix, embauche, salaires, dividendes.
8. Finance : renflouement (filet), redistribution de l'État.
9. Entrées et sorties d'entreprises, puis enregistrement, invariants et détecteurs.

### Règles de comportement

| Domaine | Règle | Valeurs |
|---|---|---|
| Coût de revient | Salaire ÷ (productivité × utilisation de l'équipe lissée sur 20 j), plus les intrants au meilleur prix et les frais fixes (services, intérêts, usure au prix des machines). Coproduits : coût réparti selon les prix mondiaux | Utilisation plancher 5 % |
| Prix | Cible = coût × (1 + marge). La marge monte en cas de rareté : stock < 2 j, ou service vendu à plus de 97 % avec des clients refusés. Elle baisse en cas de surstock : stock > 8 j, ou service vendu à moins de 85 %. Sinon elle revient vers 15 % | Pas de 1 à 3 %, × 1 à 3 selon les clients refusés ; marge de −40 % à +300 % ; le prix fait 25 % du chemin par jour, au plus 1,5 %/j |
| Embauche | Vise l'effectif qui produit le plan. Ouvre au plus 3 postes si elle a en caisse 8 jours de salaire pour chaque employé, nouveaux compris. Licencie sous 2 jours de salaires en caisse. N'embauche pas si elle manque d'intrants | — |
| Salaires | Montent si des postes sont vacants depuis 2 jours ; baissent légèrement si rien n'est ouvert et que le chômage dépasse 8 % ; convergent de 1 %/j vers la norme de la qualification | Hausse voulue de 1,5 à 6 %/j, limitée à 1,5 %/j |
| Dividendes | 8 %/j de la trésorerie au-delà de la réserve : 8 jours de coûts (salaires, intrants, services) plus 10 % de la dette | — |
| Ménages | Budget loisirs = α₁ × (revenu lissé − besoins) + α₂ × (richesse − coussin), réparti selon les goûts de la classe, avec lassitude | α₁ = 0,6 ; α₂ = 0,02/j ; coussin de 12 jours de besoins |
| Efficacité au travail | Faim depuis 2 jours : × 0,5 ; sans logis : × 0,8 ; × (0,4 + 0,6 × santé) ; × (0,85 + 0,15 × loisirs) | Santé 0,05 : × 0,43 |
| Santé | S'use lentement ; maladies au hasard ; on consulte sous 0,75 | −0,003/j ; 0,4 %/j de chance de tomber malade |
| Crédit | Machines : garantie de 80 %, entreprise rentable. Fonds de roulement : des clients repartent les mains vides, entreprise rentable, ventes ≥ salaires. Créance radiée après 60 jours sans paiement | 6 %/an + prime ≤ 6 % ; fonds de roulement ≤ 15 jours de chiffre d'affaires |
| Entrée et sortie | Fermeture après 30 jours sans employé. Création si un bien n'a plus de producteur (ou, après le jour 100, si les marges dépassent 1,4 × le coût), qu'il y a des chômeurs qualifiés et que le marché fait vivre l'équipe | 60 jours entre deux créations d'un même type |

Modules actifs par défaut : tous (crédit, machines, R-D, publicité, comptabilité, maladies et soins, formation, santé
et éducation publiques, entrée et sortie). Le commerce extérieur est coupé.

Instruments de diagnostic : 5 filets (nommés, coupables, comptés, journalisés), 14 détecteurs, 4 invariants comptables
vérifiés chaque jour.

### Le modèle complet en chiffres (tâche 3)

| | Sans filets | Avec filets |
|---|---|---|
| Chômage moyen | 5,3–10,6 % (moyenne 9,2 %) | 3,1–5,3 % |
| Faim moyenne | 0,0–12,0 % (moyenne 5,7 %) | 0,0–0,2 % |
| Sans-abri moyen | 0,6–4,1 % (moyenne 2,9 %) | 0,0–0,9 % |
| Gini moyen (fin de partie) | 0,26–0,41 (0,24–0,90) | 0,14–0,31 (0,10–0,31) |
| Alertes critiques | 99 | 34 |
| Entreprises actives en fin de partie | 6–15 types | 18–20 types |
| Chocs résorbés en moins de 200 jours | 0 / 15 | 6 / 15 |
| Écart comptable | 0 exact | 0 exact |

## 2. Bilan des filets

Avec filets, régime mesuré après le jour 100, 5 graines × 1 500 jours.

| Filet | Par 50 jours | Qui en bénéficie, pourquoi | Lecture |
|---|---|---|---|
| Anti-famine | 0,48 ✅ | 0 à 53 aides par partie, presque toutes au démarrage (jours 23–57) et dans deux épisodes tardifs (graine 2, jour 1 486 ; graine 5, jour 1 335). Cause : aucun aliment en stock | Résiduel |
| Renflouement d'entreprise | 25,7 ❌ | 652 à 912 par partie, à plus de 99 % pour des entreprises en perte. 59 à 81 % vendent sous leur coût ; 38 à 76 % ont une équipe utilisée à moins de 50 %. 48 à 69 % ont lieu après le jour 500 : c'est chronique. Bénéficiaires : hôpital (20–37 %), ferme, école, garage, pétrochimie, fonderie, mines, électronique, tourisme | **Cache une fuite.** Seulement 1 à 4 renflouements par partie vont à une entreprise rentable qui veut embaucher |
| Plancher de logement | 5,6 ❌ | Au démarrage (jours 16–77) dans toutes les graines. En continu dans la graine 4 (1 801 fois), où la santé s'effondre même avec filets. Cause : parc plein (64 %), prix trop élevé (36 %) | Démarrage + A1 |
| Plafond de dérive | 0,0 ✅ | Plus rien depuis la tâche 3 (262 par 50 jours avant) | Réglé |
| Anti-crédit-fou | 0,19 ✅ | Graine 5 seulement : les fonds propres de la Caisse tombent à ~0 après 28 000 $ de radiations | Résiduel |

**Ce que montrent les filets.** Avec filets, la santé moyenne reste à 0,85–0,89 ; sans filets, elle tombe à 0,05–0,12.
L'écart vient du renflouement : il garde en vie, à perte, l'hôpital (131 à 295 renflouements par partie) et ses
fournisseurs (électronique, pétrochimie). Le filet ne se contente pas de mesurer une fuite : il fait tourner une
branche de l'économie qui ne tient pas seule. C'est le « cache-misère » que le cahier des charges interdit.

## 3. Critères de sortie

| Critère | Complet | Noyau (tous modules coupés) | Complet sans « Maladies et soins » |
|---|---|---|---|
| Aucune alerte critique (sans filets) | ❌ 99 | ❌ 5 | ❌ 12 |
| Chômage moyen 3–10 % | ❌ g3 10,0 %, g4 10,6 %, g5 10,2 % | ❌ g4 2,4 % | ✅ 3,2–5,0 % |
| Faim et sans-abri < 2 % | ❌ g1, g3, g4, g5 | ✅ | ✅ |
| Gini 0,2–0,45 | ✅ en moyenne (0,85–0,90 en fin de partie dans 3 graines) | ✅ | ✅ |
| Inflation moyenne < ±0,5 %/j | ✅ | ✅ | ✅ |
| Invariant comptable | ✅ 0 exact | ✅ | ✅ |
| Filets < 1 déclenchement / 50 j | ❌ renflouements 25,7, logement 5,6 | ❌ renflouements 19,8 | ❌ renflouements 15,0 |
| Chocs résorbés < 200 j, sans filets | ❌ 0 / 15 | ❌ 5 / 15 | non mesuré |
| Chocs résorbés < 200 j, avec filets | ❌ 6 / 15 | ❌ 1 / 15 | non mesuré |
| **Total** | **3 / 9** | **4 / 9** | **5 / 7** |

Dans la variante sans « Maladies et soins », les 12 alertes critiques restantes sont surtout une vague de sans-abri au
démarrage (une par graine, 28 à 53 jours : anomalie A5). Pour le noyau, la tâche 3 a fait passer les alertes critiques
de 33 à 5.

## 4. Anomalies, de la plus lourde à la plus légère

### A1. La santé de la population s'effondre (aucun détecteur ne la voit)

**Symptôme.** Sans filets, la santé moyenne tombe à 0,05–0,14 dès le jour 500 dans les 5 graines, et à 0,08–0,17 dans
la graine 4 même avec filets. L'efficacité moyenne des travailleurs tombe à 0,43–0,49 (0,25 au plus fort d'une famine). Les entreprises voudraient
jusqu'à 280 employés de plus que ceux qu'elles ont. Le problème existait déjà à la tâche 5 (santé 0,07–0,08 au
jour 500 dans les graines 1, 3 et 5) : il ne vient pas de la tâche 3.

**Mécanisme.** L'hôpital ne tient pas seul, pour trois raisons :

1. **Ses intrants viennent d'une filière qui n'existe presque pas.** Chaque visite consomme 0,1 composant
   électronique et 0,2 kg de plastique. Leurs producteurs n'ont qu'un employé pour une fraction de la demande. Ils vendent
   à 274–570 $ le composant au lieu de ~36 $, si bien que ces intrants dépassent 15 % du coût d'une visite et deviennent
   bloquants. Quand ces producteurs ferment, les intrants manquants ralentissent encore la production. Or une
   entreprise limitée par ses intrants n'embauche pas.
2. **Ses visites sont un service périssable, et la règle de prix des services le pousse sous son coût.** La marge
   baisse dès que moins de 85 % des visites prévues sont vendues. Elle ne monte que si plus de 97 % sont vendues et que
   des clients sont refusés. Les maladies arrivent au hasard et la production est prévue à 1,05 fois la demande
   moyenne : on passe souvent sous 85 %. La marge reste donc collée à −40 %. Baisser le prix n'attire personne, puisque
   l'État paie les soins.
3. **Sans filets, il meurt et renaît sans cesse.** L'hôpital est créé puis fermé 16 à 22 fois par partie. Entre les
   jours 200 et 1 500 (graines 1, 3 et 5), il est fermé 17 à 40 % du temps, sans employé 35 à 46 % et limité par ses
   intrants 25 à 37 %. Pendant ce temps, tout le monde est malade : la demande lissée monte à ~240 visites par jour, pour
   0 à 2 visites produites.

**Effet.** Avec une santé de 0,05, un travailleur rend 43 % de sa capacité : chaque poste demande à peu près deux
employés. Cette pénurie de main-d'œuvre alimente les anomalies A3, A5 et A6.

**Preuve.** Couper le module « Maladies et soins », sans filets : chômage 3,2–5,0 %, faim et sans-abri moyens 0 %, Gini
0,24–0,28 (contre 9,2 %, 5,7 %, 2,9 % et 0,37 pour le modèle complet).

### A2. La filière métaux, informatique et machines disparaît (toutes les graines, filets compris)

- **Au départ**, 11 types sur 31 n'ont qu'un employé ou moins : mines de fer, de bauxite et de cuivre, raffinerie,
  pétrochimie, fonderie, aluminerie, ingénierie pétrolière, conception de puces, comptabilité, hôpital.
- **Avec filets, 11 types disparaissent dans les 5 graines** : mines de fer, d'or, de bauxite et de cuivre, fonderie,
  aluminerie, puces, conception, ordinateurs, bijouterie, machinerie. Il reste 18 à 20 types actifs.
- **Les survivants à un employé vendent à plus de 5 fois le prix de référence** 865 à 1 349 jours sur 1 400 :
  pétrochimie, électronique, garage, ingénierie pétrolière.
- **Les machines disparaissent.** Le parc passe de 336–464 machines au jour 100 à 0–5 au jour 1 500. Le prix des
  machines est figé à 1 372 $, faute de vendeur. Les modules Machines, Entretien et R-D ne font plus rien après le jour
  ~300, et on ne trouve plus ni bijoux ni ordinateurs.
- **Mécanisme.** Le coût de revient honnête (tâche 1) d'une équipe utilisée à 5–15 % est 7 à 20 fois le coût normal. Le
  prix devient aberrant, la demande disparaît, l'entreprise ferme, et la règle de viabilité empêche, à raison, de la
  recréer.
- **Ce n'est pas un bogue :** à 240 habitants, ces marchés ne font pas vivre un employé à temps plein. Il y a un
  choix de modélisation à faire (§ 7). Couper le module Machines aggrave la situation (deux graines s'effondrent) :
  la disparition des machines est un symptôme, pas la cause.

### A3. Les famines sans filets : le piège de la ferme

**Symptôme.** Dans les graines 1, 3, 4 et 5, on compte 3 à 5 famines hors démarrage, de 7 à 63 jours, avec des pics de
55 à 95 % d'affamés. Cause : aucun aliment en stock. La graine 2 n'en connaît qu'au démarrage. En crise, la ferme a 1 à 5
employés pour 75 à 300 désirés.

**Trois causes empilées :**

1. **La ferme perd de l'argent par construction, à cause de son coproduit.** Elle produit céréales et bétail ensemble.
   45 % de son coût est imputé au bétail (parts aux prix mondiaux), mais le bétail se vend mal. Graine 1 avec filets :
   2,9 têtes produites par jour, 1,1 vendue, 1 931 têtes en stock en moyenne (jusqu'à 2 868). Il se vend à 60 % de son
   coût, la marge collée à −40 %. La ferme vend ses céréales 20 % au-dessus de leur coût et perd quand même ~475 $
   par jour (recettes 1 564 $/j, coûts 2 039 $/j). C'est la 2ᵉ bénéficiaire des renflouements.
2. **Les dividendes vident la caisse avant qu'elle puisse embaucher.** Pour ouvrir un poste, il faut en caisse 8 jours de
   salaire pour chaque employé, nouveau compris. Or les dividendes versent tout ce qui dépasse 8 jours de coûts. Pour
   une entreprise sans intrants (ferme, mines, services), les deux seuils sont presque égaux : le surplus part en
   dividendes avant d'atteindre le seuil d'embauche. Elle ne peut grandir qu'à crédit, et la Caisse ne prête qu'aux
   entreprises rentables.
3. **L'efficacité à 0,45 (A1) double le nombre d'employés nécessaires.**

Pendant ce temps, la boulangerie garde 17 à 22 employés sans céréales, avec 24 à 30 jours de trésorerie et 3 300 à
5 300 $ de profit par jour. La main-d'œuvre et l'argent sont là où ils ne servent pas.

**Correction de ma proposition précédente.** L'« apport en capital du propriétaire à une entreprise rentable qui veut
embaucher » vise un cas qui se présente 1 à 4 fois par partie. La ferme n'est pas rentable : je retire cette
proposition.

### A4. Effondrement de fin de partie sans filets (graines 1, 3 et 5)

- À partir des jours 1 389 à 1 419, une longue famine fait monter le chômage : 48 à 77 % au jour 1 500.
- L'État verse 80 $ par jour et par chômeur. Son trésor passe de 146–205 k$ à ~4 500 $, et l'assurance-emploi s'arrête.
- La faim change alors de cause : « prix trop élevé ». Les stocks s'accumulent (1 291 kg de viande, 874 miches) à des prix
  très au-dessus du départ (viande à 64–146 $ le kg, pain à 39–67 $ la miche), et ces prix ne peuvent baisser que de
  1,5 % par jour.
- Gini en fin de partie : 0,85 à 0,90. 7 ou 8 propriétaires détiennent 67 à 71 % de l'argent des ménages. On voit des
  pics semblables au jour 1 000 des graines 3 et 4 (Gini 0,92–0,93).
- **Mécanisme.** Rien ne stabilise l'économie au-delà du trésor de l'État, qui ne peut pas emprunter. La limite
  quotidienne des prix ralentit aussi la baisse des prix.

### A5. Démarrage en sur-emploi (toutes les graines, avec et sans filets)

- **Symptôme.** Entre les jours 10 et 60, le chômage est de 0 à 1 %, et les entreprises veulent jusqu'à 280 employés de
  plus que la population n'en offre. Une vague de sans-abri (21 à 72 %, entre les jours 16 et 98) et de faim (10 à 98 %)
  s'ensuit, et l'indice des prix double en 100 jours (1,9 à 2,7 au jour 100).
- **Mécanisme.** Le plan de départ dimensionne l'économie pour 94 % d'emploi avec une efficacité de 1. L'efficacité
  réelle tombe à ~0,9 en 30 jours (santé, loisirs). Le logement est dimensionné à une nuitée par habitant exactement,
  sans aucune marge. Au plein emploi, l'immobilier ne trouve pas les 1 à 3 employés qui lui manquent.

### A6. Le logement manque dès que l'efficacité baisse

- Tous les jours sans logis ont la même cause : parc plein. Une nuitée est produite par du travail (24 par employé et
  par jour).
- À efficacité 0,45, l'immobilier a besoin de 21 à 26 employés au lieu de 10. Sans filets, chaque famine (efficacité
  × 0,5) déclenche une vague de sans-abri de 25 à 48 %.
- Il n'y a pas de construction (tâche 6).

### A7. Prix aberrants et indice des prix

- Avec filets, l'indice chute de 52 à 74 % en un jour dans les graines 1, 2, 3 et 5 : le repas passe de 273–584 $ à
  40–46 $ quand un restaurant normal remplace un restaurant privé d'intrants. Sur la partie, l'indice varie de 1,9 à 7,1
  fois sa valeur de départ.
- Sans filets, la filière alimentaire (ferme, boulangerie, boucherie, restaurant, pêche) vend à plus de 5 fois le prix
  de référence 550 à 1 400 jours sur 1 400.
- **Trois mécanismes :**
  1. Une entreprise limitée par ses intrants a toujours un stock bas : sa marge monte jusqu'au plafond de +300 %, sans
     lui apporter un lot de plus.
  2. Son coût monte en même temps, parce que son équipe est sous-utilisée.
  3. L'indice valorise un panier fixé au jour 0 aux prix des transactions du jour : un bien que presque plus personne
     n'achète garde son poids de départ.

### A8. Services vendus sous leur coût (avec filets)

- Jours sous le coût de revient, sur 1 400 : hôpital 1 397 à 1 399 (838 dans la graine 4), pétrochimie 1 041 à 1 160,
  électronique 645 à 1 135, école 646 à 773, puis hôtel et tourisme.
- **Mécanisme.** C'est la règle de prix des services périssables décrite en A1 (point 2) : baisse dès que moins de 85 %
  des services prévus sont vendus, hausse seulement au-delà de 97 % avec des clients refusés.
- C'est la première source de renflouements.

### A9. Caisse insolvable sans filets (graines 1, 3 et 5)

- Fonds propres négatifs dès les jours 140 à 350, et pendant plus de 1 000 jours (minimum de −6 000 à −26 000 $).
- Radiations de 37 000 à 61 000 $. 96 à 98 % des prêts sont du fonds de roulement.
- **Mécanisme.** Le plancher de fonds propres n'existe que dans le filet anti-crédit-fou, pas dans la politique normale
  de la Caisse (déjà noté à la tâche 5).

### A10. Roulement d'entreprises sans filets

- 28 à 204 créations et 49 à 219 fermetures par partie : hôpital 16 à 22 fois, machinerie jusqu'à 22 fois, marketing
  jusqu'à 21, pêche jusqu'à 19, ordinateurs jusqu'à 18.
- **Mécanisme.** Une entreprise créée sans pouvoir embaucher (pénurie de main-d'œuvre, A1 et A5) ferme 30 jours plus
  tard.
- C'est l'origine de la plupart des alertes « sans employé » (51 à 223 par partie) et « sans client » (47 à 230).

### A11. Gini trop bas avec filets

- Gini moyen de 0,14 à 0,17 dans 4 graines sur 5, sous la borne de 0,2.
- **Mécanisme.** Chaque ménage vise la même richesse, comptée en jours de revenu (fonction de consommation), et les
  ristournes de l'État et de la Caisse sont égales pour tous.
- Secondaire.

## 5. Ce que les détecteurs ne voient pas

Les détecteurs actuels voient les conséquences (faim, sans-abri, chômage), pas les causes. Les détecteurs proposés
ci-dessous sont des instruments de diagnostic, sans effet sur l'économie ; leurs seuils sont indicatifs.

| Anomalie | Détecteur proposé |
|---|---|
| A1 | Santé moyenne < 0,5, ou efficacité moyenne < 0,7, pendant 30 jours |
| A3, A5 | Pénurie de main-d'œuvre : postes désirés non pourvus > 10 % de la population pendant 30 jours |
| A2 | Filière rompue : un bien sans producteur, dont une entreprise active a besoin |
| A7 | Prix aberrant : prix > 5 × le prix de référence pendant 30 jours |
| A8 | Entreprise qui vend sous son coût de revient pendant 60 jours |
| A4 | Trésor de l'État sous sa réserve de redistribution (57 600 $) |

## 6. La chaîne causale

```
240 habitants, travail indivisible
  → filières amont non viables (A2) : électronique et plastique rares ou hors de prix
  → hôpital bloqué par ses intrants et vendu sous son coût (A1, A8)
       ├─ avec filets : renfloué 131 à 295 fois par partie → santé 0,85 → économie correcte, filets ❌
       └─ sans filets : fermé ou à l'arrêt → santé 0,05 → efficacité 0,45
             → pénurie de main-d'œuvre
             → ferme sous-dotée (+ coproduit déficitaire, dividendes) → famines (A3)
             → immobilier à court d'employés → sans-abri (A6)
             → chômage → trésor de l'État vide → effondrement de fin de partie (A4)
```

## 7. Conséquences pour la suite

**Tâche 3.** Elle a atteint sa cible : plafond de dérive de 262 à 0, anti-famine de 4,8 à 0,5, et dans le noyau, alertes
critiques de 33 à 5. La dégradation sans filets passe par A1 et A3, qui existaient déjà.

**Ordre proposé** (une correction à la fois, mesurée par le protocole) :

1. **Détecteurs manquants (§ 5).** Aucun effet sur l'économie ; ils rendent visibles les causes.
2. **Hôpital (A1, A8).** La règle de prix des services : une capacité inutilisée devrait réduire l'équipe, pas faire
   passer le prix sous le coût. Puis sa dépendance à l'électronique et au plastique (voir la décision ci-dessous).
3. **Ferme (A3).** Imputer le coût des coproduits selon ce qui se vend vraiment. Retenir les bénéfices quand
   l'entreprise veut embaucher, au lieu de les verser en dividendes.
4. **Démarrage (A5).** Dimensionner le plan de départ avec l'efficacité attendue et une marge de logement.
5. **Caisse (A9).** Mettre le plancher de fonds propres dans sa politique normale.

L'État qui ne peut pas emprunter (A4) et la formule de l'indice des prix (A7, point 3) sont à noter, mais pas
prioritaires.

**Décision à prendre : la filière métaux, informatique et machines (A2).** À 240 habitants, elle ne peut pas vivre.
Trois voies :

- **(a) Importations de dépannage** des biens qui n'ont pas de producteur local, au prix mondial × 1,3. C'était prévu à
  la tâche 2 et pas fait. C'est cohérent avec ta décision « produits chimiques importés » de la feuille de route, mais
  il faut activer le commerce extérieur (aujourd'hui coupé).
- **(b) Laisser la filière disparaître** et retirer les dépendances qui n'en valent pas la peine, comme l'électronique
  de l'hôpital. Cela modifie des recettes, donc la calibration.
- **(c) Agrandir la population.** C'est un paramètre de calibration, et les simulations deviennent plus lentes.

Je recommande (a) : c'est la correction prévue et elle ne retire rien au modèle.
