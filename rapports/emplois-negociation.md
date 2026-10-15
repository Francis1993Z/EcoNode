# Rôles, contrats et négociation salariale (module `jobs`)

Branche `feature/emplois-negociation`, 13 octobre 2026. Description règle par règle : [`MODELE.md`](../MODELE.md)
§ 6.16. Comparaison de décision complète : [`emplois-comparaison.md`](emplois-comparaison.md).

## En bref

- Chaque type d'entreprise a un **organigramme** de 3 à 5 rôles, avec une qualification minimale, une part visée de
  l'effectif, un salaire relatif et, pour l'encadrement, une ancienneté minimale (promotion interne seulement).
- Chaque employé a un **contrat** : rôle, salaire, date d'embauche. Les salaires d'une même équipe diffèrent.
- **Négociation à l'embauche** : salaire de réserve du candidat contre plafond de l'employeur, à l'intérieur d'une
  fourchette autour de l'offre du rôle ; refus possibles. **Contre-offres** quand un concurrent débauche,
  **promotions**, **renouvellement** du contrat tous les 90 jours au taux du marché (ancienneté comprise).
- **Inspecteur** : section « Employés » de chaque entreprise (nom, rôle, qualification, salaire, ancienneté), son
  organigramme (effectifs actuels et visés, salaire offert par rôle) et ses négociations récentes ; fiche citoyen
  (rôle, contrat, ancienneté, prochaine révision, salaire de réserve, aplomb) ; vue Ménages : marché du travail.
- Module **coupé par défaut** dans le moteur, le protocole et les tests existants : avec le module coupé, l'empreinte de
  `tool/parite.dart` est identique au bit près (deux graines × 400 jours) ; seule s'ajoute la ligne du nouveau flux de
  hasard `anciennete`. **L'interface lance ses parties avec le module** (interrupteur sur l'écran de départ, dans
  Diagnostic → Modules et dans la section « Employés » de l'inspecteur).
- **Coût mesuré** (30 graines × 1 500 jours, avec filets) : chômage médian 10,2 % au lieu de 7,0 %, Gini 0,26 au lieu
  de 0,20 ; alertes critiques, santé, attente à l'hôpital et diversité des entreprises inchangées. Sans filets : 10,8 %
  au lieu de 8,0 %, moins de sans-abri et plus de types d'entreprises actifs en fin de partie.

## Organigrammes

Qualification minimale : de 0 à 3 (la partie entière, plafonnée à 2, donne la classe). « Salaire ÷ salaire affiché » :
l'offre du rôle rapportée au salaire affiché de l'entreprise (celui de la qualification de son gabarit) ; un rôle se
paie selon sa classe, pas selon celle de l'entreprise. Les postes se répartissent entre les rôles à la plus forte
moyenne (méthode D'Hondt) : une équipe d'une personne a son rôle principal, l'encadrement apparaît vers 6 à 10
employés.

| Entreprise | Rôle | Qualification minimale | Ancienneté exigée | Part visée | Salaire ÷ salaire affiché |
|---|---|---|---|---|---|
| Ferme (manœuvre) | Aide agricole | Manœuvre (0,0) | — | 55 % | ×1,00 |
|  | Machiniste agricole | Manœuvre (0,5) | — | 30 % | ×1,08 |
|  | Agronome | Professionnel (2,0) | — | 5 % | ×1,71 |
|  | Responsable de la ferme | Technicien (1,0) | 1 an | 10 % | ×1,54 |
| Pêcherie (manœuvre) | Matelot | Manœuvre (0,0) | — | 60 % | ×1,00 |
|  | Machiniste de bord | Manœuvre (0,6) | — | 25 % | ×1,10 |
|  | Capitaine | Technicien (1,0) | 1 an | 15 % | ×1,54 |
| Puits de pétrole (technicien) | Manœuvre de plancher | Manœuvre (0,0) | — | 30 % | ×0,79 |
|  | Spécialiste du forage | Technicien (1,0) | — | 45 % | ×1,00 |
|  | Géologue | Professionnel (2,0) | — | 10 % | ×1,36 |
|  | Chef de chantier | Technicien (1,5) | 1 an | 15 % | ×1,15 |
| Chantier forestier (manœuvre) | Manœuvre d’abattage | Manœuvre (0,0) | — | 60 % | ×1,00 |
|  | Machiniste en foresterie | Manœuvre (0,5) | — | 30 % | ×1,10 |
|  | Chef d’équipe | Technicien (1,0) | 1 an | 10 % | ×1,47 |
| Mine de fer (manœuvre) | Manœuvre de mine | Manœuvre (0,0) | — | 50 % | ×1,00 |
|  | Machiniste de mine | Manœuvre (0,4) | — | 20 % | ×1,06 |
|  | Boutefeu | Manœuvre (0,6) | — | 15 % | ×1,12 |
|  | Géologue | Professionnel (2,0) | — | 5 % | ×1,61 |
|  | Chef de quart | Technicien (1,0) | 1 an | 10 % | ×1,54 |
| Mine d’or (manœuvre) | Manœuvre de mine | Manœuvre (0,0) | — | 50 % | ×1,00 |
|  | Machiniste de mine | Manœuvre (0,4) | — | 20 % | ×1,06 |
|  | Boutefeu | Manœuvre (0,6) | — | 15 % | ×1,12 |
|  | Géologue | Professionnel (2,0) | — | 5 % | ×1,61 |
|  | Chef de quart | Technicien (1,0) | 1 an | 10 % | ×1,54 |
| Mine de bauxite (manœuvre) | Manœuvre de mine | Manœuvre (0,0) | — | 50 % | ×1,00 |
|  | Machiniste de mine | Manœuvre (0,4) | — | 20 % | ×1,06 |
|  | Boutefeu | Manœuvre (0,6) | — | 15 % | ×1,12 |
|  | Géologue | Professionnel (2,0) | — | 5 % | ×1,61 |
|  | Chef de quart | Technicien (1,0) | 1 an | 10 % | ×1,54 |
| Mine de cuivre (manœuvre) | Manœuvre de mine | Manœuvre (0,0) | — | 50 % | ×1,00 |
|  | Machiniste de mine | Manœuvre (0,4) | — | 20 % | ×1,06 |
|  | Boutefeu | Manœuvre (0,6) | — | 15 % | ×1,12 |
|  | Géologue | Professionnel (2,0) | — | 5 % | ×1,61 |
|  | Chef de quart | Technicien (1,0) | 1 an | 10 % | ×1,54 |
| Boucherie (manœuvre) | Aide en boucherie | Manœuvre (0,0) | — | 50 % | ×1,00 |
|  | Spécialiste de la coupe | Manœuvre (0,5) | — | 35 % | ×1,10 |
|  | Responsable du comptoir | Technicien (1,0) | 6 mois | 15 % | ×1,40 |
| Boulangerie (manœuvre) | Aide en boulangerie | Manœuvre (0,0) | — | 45 % | ×1,00 |
|  | Spécialiste de la cuisson | Manœuvre (0,5) | — | 35 % | ×1,10 |
|  | Commis de comptoir | Manœuvre (0,0) | — | 10 % | ×0,95 |
|  | Responsable de la boulangerie | Technicien (1,0) | 6 mois | 10 % | ×1,40 |
| Raffinerie (technicien) | Manœuvre de raffinerie | Manœuvre (0,0) | — | 20 % | ×0,79 |
|  | Technologue en procédés | Technicien (1,0) | — | 50 % | ×1,00 |
|  | Chimiste | Professionnel (2,0) | — | 15 % | ×1,36 |
|  | Chef de quart | Technicien (1,5) | 1 an | 15 % | ×1,15 |
| Pétrochimie (technicien) | Manœuvre d’usine | Manœuvre (0,0) | — | 25 % | ×0,79 |
|  | Technologue en plasturgie | Technicien (1,0) | — | 50 % | ×1,00 |
|  | Chimiste | Professionnel (2,0) | — | 10 % | ×1,36 |
|  | Chef de production | Technicien (1,5) | 1 an | 15 % | ×1,15 |
| Fonderie (manœuvre) | Manœuvre de fonderie | Manœuvre (0,0) | — | 45 % | ×1,00 |
|  | Machiniste de coulée | Manœuvre (0,5) | — | 30 % | ×1,10 |
|  | Métallurgiste | Technicien (1,0) | — | 15 % | ×1,40 |
|  | Chef d’équipe | Technicien (1,0) | 1 an | 10 % | ×1,47 |
| Aluminerie (technicien) | Manœuvre de salle de cuves | Manœuvre (0,0) | — | 25 % | ×0,79 |
|  | Technologue en électrolyse | Technicien (1,0) | — | 50 % | ×1,00 |
|  | Métallurgiste | Professionnel (2,0) | — | 10 % | ×1,29 |
|  | Chef de secteur | Technicien (1,5) | 1 an | 15 % | ×1,15 |
| Électronique (technicien) | Commis d’assemblage | Manœuvre (0,0) | — | 30 % | ×0,79 |
|  | Technologue en électronique | Technicien (1,0) | — | 50 % | ×1,00 |
|  | Spécialiste du contrôle de qualité | Technicien (1,5) | — | 10 % | ×1,05 |
|  | Chef de ligne | Technicien (1,5) | 1 an | 10 % | ×1,15 |
| Fonderie de puces (professionnel) | Technologue en salle blanche | Technicien (1,0) | — | 40 % | ×0,74 |
|  | Spécialiste en lithographie | Professionnel (2,0) | — | 40 % | ×1,00 |
|  | Scientifique des matériaux | Professionnel (2,5) | — | 10 % | ×1,10 |
|  | Responsable de l’usine | Professionnel (2,0) | 1 an | 10 % | ×1,25 |
| Ordinateurs (technicien) | Commis d’assemblage | Manœuvre (0,0) | — | 30 % | ×0,79 |
|  | Technologue en informatique | Technicien (1,0) | — | 45 % | ×1,00 |
|  | Spécialiste des essais | Technicien (1,5) | — | 15 % | ×1,05 |
|  | Chef de production | Technicien (1,5) | 1 an | 10 % | ×1,15 |
| Bijouterie (technicien) | Commis de boutique | Manœuvre (0,0) | — | 30 % | ×0,79 |
|  | Spécialiste en joaillerie | Technicien (1,0) | — | 55 % | ×1,00 |
|  | Responsable de l’atelier | Technicien (1,5) | 1 an | 15 % | ×1,15 |
| Garage (technicien) | Commis aux pièces | Manœuvre (0,0) | — | 25 % | ×0,79 |
|  | Spécialiste en mécanique | Technicien (1,0) | — | 60 % | ×1,00 |
|  | Chef d’atelier | Technicien (1,5) | 1 an | 15 % | ×1,15 |
| Machinerie (professionnel) | Machiniste | Technicien (1,0) | — | 40 % | ×0,74 |
|  | Spécialiste en conception mécanique | Professionnel (2,0) | — | 45 % | ×1,00 |
|  | Responsable de l’usine | Professionnel (2,0) | 1 an | 15 % | ×1,25 |
| Ingénierie pétrolière (professionnel) | Technologue en génie | Technicien (1,0) | — | 25 % | ×0,74 |
|  | Spécialiste en génie pétrolier | Professionnel (2,0) | — | 60 % | ×1,00 |
|  | Responsable de projets | Professionnel (2,5) | 1 an | 15 % | ×1,15 |
| Ingénierie de CPU (professionnel) | Technologue en conception | Technicien (1,0) | — | 25 % | ×0,74 |
|  | Architecte de puces | Professionnel (2,0) | — | 60 % | ×1,00 |
|  | Responsable de projets | Professionnel (2,5) | 1 an | 15 % | ×1,15 |
| Marketing (professionnel) | Commis de bureau | Manœuvre (0,0) | — | 15 % | ×0,63 |
|  | Graphiste | Technicien (1,0) | — | 25 % | ×0,74 |
|  | Stratège en marketing | Professionnel (2,0) | — | 45 % | ×1,00 |
|  | Responsable de la création | Professionnel (2,0) | 1 an | 15 % | ×1,25 |
| Comptabilité (professionnel) | Commis comptable | Technicien (1,0) | — | 30 % | ×0,74 |
|  | Comptable | Professionnel (2,0) | — | 55 % | ×1,00 |
|  | Responsable de mission | Professionnel (2,5) | 1 an | 15 % | ×1,20 |
| Restaurant (manœuvre) | Commis de cuisine | Manœuvre (0,0) | — | 40 % | ×1,00 |
|  | Service aux tables | Manœuvre (0,0) | — | 35 % | ×1,00 |
|  | Chef de partie | Manœuvre (0,5) | — | 15 % | ×1,10 |
|  | Responsable de salle | Technicien (1,0) | 6 mois | 10 % | ×1,40 |
| Production télé (technicien) | Commis de production | Manœuvre (0,0) | — | 20 % | ×0,79 |
|  | Spécialiste du son et de l’image | Technicien (1,0) | — | 45 % | ×1,00 |
|  | Journaliste | Professionnel (2,0) | — | 20 % | ×1,29 |
|  | Responsable de la programmation | Professionnel (2,0) | 1 an | 15 % | ×1,56 |
| Hôtel (manœuvre) | Commis à l’entretien | Manœuvre (0,0) | — | 45 % | ×1,00 |
|  | Réceptionniste | Manœuvre (0,5) | — | 30 % | ×1,05 |
|  | Concierge | Technicien (1,0) | — | 15 % | ×1,33 |
|  | Responsable de l’hôtel | Technicien (1,0) | 1 an | 10 % | ×1,68 |
| Tourisme (technicien) | Commis de bureau | Manœuvre (0,0) | — | 20 % | ×0,79 |
|  | Guide touristique | Technicien (1,0) | — | 50 % | ×1,00 |
|  | Spécialiste des voyages | Technicien (1,0) | — | 20 % | ×1,05 |
|  | Responsable de l’agence | Technicien (1,5) | 1 an | 10 % | ×1,15 |
| Hôpital (professionnel) | Préposé(e) aux bénéficiaires | Manœuvre (0,0) | — | 20 % | ×0,53 |
|  | Infirmier(ère) | Technicien (1,0) | — | 40 % | ×0,74 |
|  | Médecin | Professionnel (2,0) | — | 30 % | ×1,00 |
|  | Médecin-chef | Professionnel (2,5) | 1 an | 10 % | ×1,20 |
| École (professionnel) | Concierge | Manœuvre (0,0) | — | 10 % | ×0,53 |
|  | Aide pédagogique | Technicien (1,0) | — | 25 % | ×0,74 |
|  | Enseignant(e) | Professionnel (2,0) | — | 55 % | ×1,00 |
|  | Direction d’école | Professionnel (2,5) | 1 an | 10 % | ×1,20 |
| Immobilier (manœuvre) | Concierge | Manœuvre (0,0) | — | 50 % | ×1,00 |
|  | Commis à l’entretien | Manœuvre (0,3) | — | 30 % | ×1,05 |
|  | Responsable des locations | Technicien (1,0) | — | 10 % | ×1,33 |
|  | Gestionnaire d’immeubles | Technicien (1,0) | 1 an | 10 % | ×1,61 |
| Divertissement (manœuvre) | Commis de bar | Manœuvre (0,0) | — | 45 % | ×1,00 |
|  | Garde de sécurité | Manœuvre (0,0) | — | 20 % | ×1,05 |
|  | DJ | Manœuvre (0,5) | — | 20 % | ×1,10 |
|  | Responsable du bar | Technicien (1,0) | 6 mois | 15 % | ×1,40 |
| Construction (manœuvre) | Manœuvre de chantier | Manœuvre (0,0) | — | 50 % | ×1,00 |
|  | Spécialiste en charpente | Manœuvre (0,5) | — | 35 % | ×1,12 |
|  | Chef de chantier | Technicien (1,0) | 1 an | 15 % | ×1,54 |

## Calibrage : ce qui a été mesuré, et pourquoi les règles sont celles-là

Toutes les mesures : comparaison appariée (`tool/stabilite.dart --compare`), avec filets, chômage médian sur les
graines, jours 101 à la fin. Sans le module : 9,4 % (10 graines × 1 000 jours). Avec 10 graines, l'intervalle de
confiance d'une différence fait environ ± 3 points : deux variantes à moins de 2 points l'une de l'autre ne se
distinguent pas.

| Version | Chômage médian |
|---|---|
| v1 : offre du rôle = plancher de la négociation, contrats jamais baissés, salaire de réserve plancher 60 % du dernier salaire | 24,3 % |
| v2 : + concessions des entreprises en pertes à court de trésorerie, contre-offres des seules entreprises rentables | 24,3 % |
| v3 : v2, pouvoir de négociation et souplesse réduits | 25,8 % |
| v4 : v2, offre = milieu d'une fourchette ± 10 % | 20,8 % |
| v4, contrats ramenés à l'offre du rôle de 20 %/j (ablation : salaires flexibles) | 13,3 % |
| v4, rattrapage de 1 %/j dans les deux sens | 14,4 % |
| v4, rattrapage de 1 %/j à la baisse seulement | 14,1 % |
| v4, rattrapage de 1 %/j à la hausse seulement | 25,4 % |
| v4, concessions dès que l'entreprise perd de l'argent (5 %/30 j ; 3 %/20 j) | 25,7 % ; 26,5 % |
| v4, renouvellement au taux du marché : annuel ; semestriel ; trimestriel | 14,3 % ; 14,4 % ; 13,2 % |
| annuel, sans surplus de négociation (fourchette nulle, β = 0) | 18,3 % |
| annuel, sans aspiration salariale des chômeurs | 12,5 % |
| annuel, sans mobilité d'un emploi à l'autre | 14,0 % |
| annuel, bonus de surqualification mesuré au gabarit au lieu du rôle | 15,0 % |
| annuel, même salaire pour tous les rôles | 15,7 % |
| annuel, classes de la population de départ selon les gabarits | 15,6 % |
| annuel, concessions retirées, plancher d'aspiration à 0 | 15,1 % |
| … sans plancher lié à la prestation ; fourchette ± 20 % ; organigrammes normalisés à 1 | 15,0 % ; 14,2 % ; 15,0 % |
| **… renouvellement trimestriel (règle retenue)** | **12,3 %** |
| … trimestriel, organigrammes normalisés ; et sans prime d'ancienneté | 12,8 % ; 12,6 % |

Ce que ces mesures montrent :

1. **La rigidité à la baisse était la cause principale.** Le modèle de base ne retrouve l'emploi qu'en baissant les
   salaires : chômage au-dessus de 8 % et aucun poste vacant, le salaire unique baisse de 0,15 %/j pour tous. Dans la
   graine 1, le salaire moyen passe de 213 $ à 103 $ en 600 jours, soit environ 40 % par an. Des contrats qui ne
   baissent jamais laissaient les entreprises sans trésorerie : en moyenne 11,7 postes voulus non ouverts faute des
   8 jours de salaires exigés, contre 0,85 sans le module (graines 1 à 6, jours 150 à 700). C'est la baisse qui compte,
   pas la hausse, et elle doit toucher toutes les entreprises : des concessions limitées aux entreprises en pertes ne
   changeaient rien.
2. **Le renouvellement au taux du marché (contrats échelonnés, Taylor 1980)** est le canal réaliste retenu. Annuel, il
   laisse les contrats 15 à 37 % au-dessus de l'offre de leur rôle, parce que l'offre baisse de 40 % par an ;
   trimestriel, il suit. Le trimestriel est un choix de jeu, plus fréquent que les révisions annuelles usuelles.
   `reviewCutMax` = 0 rétablit la rigidité stricte à la baisse (Bewley 1999).
3. **L'offre est le milieu d'une fourchette, pas un plancher.** Avec l'offre pour plancher, chaque embauche se concluait
   au-dessus de l'offre (+8 à 10 % en moyenne).
4. **Le salaire de réserve des chômeurs descend jusqu'à la prestation.** Un plancher à 60 % du dernier salaire faisait
   refuser aux chômeurs de longue durée des offres qu'ils auraient prises.
5. **La structure des rôles n'est pas en cause** : ni le bonus de surqualification, ni les écarts de salaire entre rôles,
   ni la composition de la population de départ ne changent le chômage de plus que le bruit.

## Résultat de décision (30 graines × 1 500 jours)

| Indicateur | Avec le module | Sans | Différence, sans − avec (IC 95 %) |
|---|---|---|---|
| **Avec filets** : chômage moyen | 10,2 % | 7,0 % | −3,7 pt [−4,5 ; −1,5] |
| chômage max | 25,0 % | 19,0 % | −5,8 pt [−7,9 ; −2,1] |
| faim moyenne ; sans-abri moyen | 0,3 % ; 0,5 % | 0,1 % ; 0,2 % | −0,2 pt ; −0,2 pt |
| Gini moyen | 0,26 | 0,20 | −0,05 |
| jours-alerte critiques | 70 | 78,5 | non concluant |
| santé ; bonheur | 0,88 ; 0,97 | 0,88 ; 0,97 | écarts sous 0,01 |
| types d'entreprises actifs en fin | 20 | 20 | non concluant |
| **Sans filets** : chômage moyen | 10,8 % | 8,0 % | −2,2 pt [−3,7 ; −1,1] |
| sans-abri moyen | 2,2 % | 2,6 % | +0,4 pt (le module fait mieux) |
| faim ; santé ; jours-alerte critiques | 6,5 % ; 0,17 ; 1 520 | 6,1 % ; 0,18 ; 1 525 | non concluants |
| types d'entreprises actifs en fin | 16 | 13 | le module fait mieux |
| fermetures pour faillite | 167,5 | 116 | le module fait moins bien |

Les différences sont calculées graine par graine (convention du rapport complet). Le Gini plus élevé vient en partie
de la dispersion voulue des salaires (rôles, négociation, ancienneté).

## Vérification

- `test/emplois_test.dart` (9 tests) : organigrammes cohérents (rôle d'entrée pour chaque type, D'Hondt proportionnel) ;
  contrats cohérents chaque jour pendant 500 jours (rôle de l'organigramme, qualification et ancienneté suffisantes,
  salaire au moins le minimum, salaire de l'entreprise = moyenne des contrats) avec les invariants comptables exacts ;
  chaque embauche entre le plancher et le plafond, chaque refus au-dessus du plafond ; baisses seulement au
  renouvellement, jamais sous l'offre du rôle ; aucune baisse avec `reviewCutMax` = 0 ; salaire minimum ; activation
  puis coupure en cours de partie ; reprise exacte depuis un instantané ; partie sans filets.
- `test/inspecteur_test.dart` (2 tests) : l'inspecteur d'une entreprise montre chaque employé avec son rôle, son
  salaire et son ancienneté, chaque rôle de l'organigramme avec sa qualification, les négociations ; la fiche citoyen
  montre le contrat ; sans le module, le salaire unique et l'interrupteur. Ce test a trouvé un débordement des lignes
  clé-valeur à valeur longue (corrigé dans `ui/widgets.dart:KV`).
- `test/proprietes_test.dart` : les 24 parties tirées au hasard activent maintenant le module 3 fois sur 4 ; la
  propriété des plafonds quotidiens porte alors sur le salaire affiché.
- Suite complète : 71 tests réussis, 2 sautés volontairement (comme avant). `flutter analyze` : rien.
- Parité : empreinte de `tool/parite.dart` identique au bit près avec le module coupé.
- Résultats graine par graine de la comparaison de décision : `rapports/stat/emplois-contre-ref.json` (local :
  `rapports/stat/` est ignoré par git ; `--relire` refait le rapport sans relancer de partie).

## Décisions pour Francis

1. **Le module dans l'interface** : actif par défaut pour les nouvelles parties (c'était la demande), au prix de
   3,7 points de chômage avec filets. À garder, ou à laisser au choix sur l'écran de départ avec le défaut coupé.
2. **Fréquence du renouvellement** (`reviewDays` = 90) : annuel serait plus réaliste mais suppose une économie sans
   déflation de 40 % par an. La vraie question est celle du modèle de base : sa seule façon de retrouver l'emploi est
   de baisser tous les salaires, ce qui rejoint l'anomalie « monnaie non neutre » de l'état des lieux.
3. **Assurance-emploi** : le salaire de réserve d'un prestataire reste au-dessus de 1,1 × sa prestation (environ 72 %
   de son ancien salaire) pendant toute sa période de prestations. L'obligation d'accepter un « emploi convenable »
   n'est pas modélisée ; retirer ce plancher n'a rien changé (15,0 % contre 15,1 %).
4. **Rôles et production** : un rôle ne change pas ce que produit un employé (sauf le bonus de surqualification,
   mesuré au rôle). Des rendements par rôle (un médecin produit plus de soins qu'un préposé) seraient l'étape suivante.

## Limites

- Pas de syndicat ni de négociation collective ; la négociation est individuelle.
- L'aplomb est le seul trait de négociation ; aucune caractéristique personnelle autre que la qualification et
  l'ancienneté n'entre dans le salaire.
- Les rôles d'encadrement ne se pourvoient que de l'intérieur : une petite entreprise sans employé assez qualifié
  n'aura pas de responsable (le poste est sauté et un autre rôle est pourvu).
