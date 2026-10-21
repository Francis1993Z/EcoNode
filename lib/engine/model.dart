// Données du modèle : biens, recettes, désirs, paramètres, entités.
// Aucune dépendance à Flutter.

const double eps = 1e-9;

// ------------------------------------------------------------------ biens

class Good {
  final String label;
  final String unit;
  final bool perish; // service ou bien périssable : l'invendu est perdu en fin de journée
  final double guess; // point de départ de la résolution des prix
  final String sector; // primaire | secondaire | tertiaire
  final bool tradable; // faux : ne s'importe ni ne s'exporte (module de construction : il reste sur place)
  const Good(this.label, this.unit, this.perish, this.guess, this.sector, {this.tradable = true});
}

// L'ordre d'insertion sert à l'affichage (tableaux, listes).
const Map<String, Good> goods = {
  // primaire : extraction (ressources illimitées)
  'grain': Good('Céréales', 'sac', false, 30, 'primaire'),
  'betail': Good('Bétail', 'tête', false, 400, 'primaire'),
  'poisson': Good('Poisson', 'kg', false, 10, 'primaire'),
  'petrole': Good('Pétrole', 'baril', false, 60, 'primaire'),
  'bois': Good('Bois', 'm³', false, 40, 'primaire'),
  'fer': Good('Minerai de fer', 't', false, 50, 'primaire'),
  'or': Good('Or', 'g', false, 60, 'primaire'),
  'bauxite': Good('Bauxite', 't', false, 50, 'primaire'),
  'cuivre': Good('Cuivre', 't', false, 70, 'primaire'),
  // secondaire : transformation
  'viande': Good('Viande', 'kg', false, 15, 'secondaire'),
  'pain': Good('Pain', 'miche', false, 4, 'secondaire'),
  'carburant': Good('Carburant', 'baril', false, 80, 'secondaire'),
  'plastique': Good('Plastique', 'kg', false, 20, 'secondaire'),
  'acier': Good('Acier', 'lingot', false, 200, 'secondaire'),
  'aluminium': Good('Aluminium', 'lingot', false, 220, 'secondaire'),
  'electronique': Good('Électronique', 'composant', false, 40, 'secondaire'),
  'cpu': Good('Processeurs', 'puce', false, 300, 'secondaire'),
  'ordinateur': Good('Ordinateurs', 'unité', false, 900, 'secondaire'),
  'bijoux': Good('Bijoux', 'pièce', false, 150, 'secondaire'),
  'machines': Good('Machines', 'unité', false, 3000, 'secondaire'),
  'reparation': Good('Réparations', 'heure', true, 60, 'secondaire'),
  // tertiaire : services
  'genie': Good('Ingénierie', 'heure', true, 90, 'tertiaire'),
  'conception': Good('Conception de puces', 'plan', false, 120, 'tertiaire'),
  'pub': Good('Publicité', 'campagne', true, 80, 'tertiaire'),
  'compta': Good('Comptabilité', 'heure', true, 70, 'tertiaire'),
  'repas': Good('Repas', 'repas', false, 18, 'tertiaire'),
  'tele': Good('Télévision', 'abonnement', true, 2, 'tertiaire'),
  'loisirs': Good('Loisirs', 'sortie', true, 20, 'tertiaire'),
  'hotel': Good('Hôtel', 'nuitée', true, 90, 'tertiaire'),
  'voyage': Good('Voyages', 'forfait', true, 300, 'tertiaire'),
  'soins': Good('Soins de santé', 'visite', true, 80, 'tertiaire'),
  'cours': Good('Formation', 'cours', true, 25, 'tertiaire'),
  'logement': Good('Logement', 'nuitée', true, 40, 'tertiaire'),
  // Module de construction (module « buildings ») : un logement en demande Params.dwellingModules. Ni importé ni exporté.
  'batiment': Good('Construction (module)', 'module', false, 1800, 'secondaire', tradable: false),
};

const List<String> sectors = ['primaire', 'secondaire', 'tertiaire'];
const Map<String, String> sectorLabels = {'primaire': 'Primaire', 'secondaire': 'Secondaire', 'tertiaire': 'Tertiaire'};

// ------------------------------------------------------------------ désirs des ménages

/// Désirs (besoins) : chacun a une satisfaction de 0 à 1 qui s'use avec le temps.
const List<String> desires = ['faim', 'logement', 'sante', 'divertissement', 'luxe'];
const Map<String, String> desireLabels = {
  'faim': 'Faim',
  'logement': 'Logement',
  'sante': 'Santé',
  'divertissement': 'Divertissement',
  'luxe': 'Luxe',
};

/// Usure quotidienne de la satisfaction quand le besoin n'est pas comblé.
const Map<String, double> desireDecay = {
  'faim': 1.0,
  'logement': 1.0,
  'sante': 0.003,
  'divertissement': 0.12,
  'luxe': 0.03,
};

/// Classes de qualification : 0 manœuvre, 1 technicien, 2 professionnel.
const List<String> classLabels = ['Manœuvre', 'Technicien', 'Professionnel'];

/// Salaire de départ selon la qualification exigée, en multiple du salaire de base.
const List<double> classWage = [1.0, 1.4, 1.9];

/// Ce qu'un bien apporte aux désirs, et le goût de chaque classe pour ce bien.
class Use {
  final Map<String, double> pts; // désir → points de satisfaction par unité
  final List<double> taste; // [manœuvre, technicien, professionnel]
  const Use(this.pts, this.taste);
}

const Map<String, Use> uses = {
  'pain': Use({'faim': 0.5}, [1.0, 0.9, 0.7]),
  'viande': Use({'faim': 0.8}, [1.0, 1.0, 1.0]),
  'poisson': Use({'faim': 0.8}, [0.9, 1.0, 1.1]),
  'repas': Use({'faim': 1.0, 'divertissement': 0.15}, [0.8, 1.4, 1.4]),
  'tele': Use({'divertissement': 0.25}, [1.3, 1.3, 0.5]),
  'loisirs': Use({'divertissement': 0.4}, [1.2, 0.8, 0.6]),
  'hotel': Use({'luxe': 0.3, 'divertissement': 0.15}, [0.4, 0.8, 1.3]),
  'voyage': Use({'luxe': 0.8, 'divertissement': 0.4}, [0.3, 0.7, 1.5]),
  'bijoux': Use({'luxe': 0.6}, [0.3, 0.6, 1.4]),
};

/// Aliments, du point de vue de la faim.
const List<String> foods = ['pain', 'viande', 'poisson', 'repas'];

/// Biens que chaque désir discrétionnaire peut acheter.
const Map<String, List<String>> desireGoods = {
  'divertissement': ['tele', 'loisirs', 'repas', 'hotel', 'voyage'],
  'luxe': ['bijoux', 'hotel', 'voyage'],
};

/// Variétés de produits (module products). Une catégorie est un bien ; une variété, le produit d'une entreprise dans cette
/// catégorie. Biens de consommation différenciés : choisis par les ménages selon leur goût, la qualité, le prix, la
/// notoriété. Biens d'équipement différenciés : choisis par les entreprises selon le gain de productivité par dollar. Les
/// autres biens (matières premières, biens intermédiaires, services aux entreprises et services publics) ne sont pas
/// différenciés : prix et disponibilité, comme sans le module.
const Set<String> consumerVarieties = {'pain', 'viande', 'repas', 'tele', 'loisirs', 'hotel', 'voyage', 'bijoux', 'ordinateur'};
const Set<String> equipmentVarieties = {'machines'};
bool isDifferentiated(String g) => consumerVarieties.contains(g) || equipmentVarieties.contains(g);

/// Gain moyen d'un modèle de machine (1,01 + 0,99 u³, u uniforme : espérance 1,2575). Un modèle de gain g vaut g / ce gain
/// machine standard : en moyenne, le module ne rend pas les machines plus productives qu'avant.
const double machineGainRef = 1.2575;

/// Une variété : le produit d'une entreprise dans une catégorie. Identifiant jamais réutilisé ; le nom est tiré à sa
/// création et stocké (il reste stable d'un instantané à l'autre).
class Product {
  final int id;
  final String category;
  final int firmId;
  String name;
  final double quality; // 0,6 à 1,4 (1 : la qualité d'avant le module)
  final int launched;
  // équipement : gain de productivité (×1,01 à ×2), durabilité (0,7 à 1,3 : l'usure est divisée d'autant), marque
  double gain;
  double durability;
  String maker;
  bool alive = true;
  int? ended;
  double salesEma = 0; // ventes lissées (~10 jours), base des parts de marché
  bool inStock = true;
  int lastRupture = -1000;
  Product(this.id, this.category, this.firmId, this.name, this.quality, this.launched,
      {this.gain = 1, this.durability = 1, this.maker = ''});
}

/// Quantité « normale » par citoyen et par jour (on ne regarde qu'une télé à la fois). Lassitude : le n-ième achat du
/// même bien dans la journée a un attrait divisé par 1 + (n / normale)². Le budget reste la seule limite :
/// les achats se répartissent entre les biens au lieu d'être plafonnés, et un riche en achète davantage de chacun.
const Map<String, double> dailyNorm = {'tele': 1, 'loisirs': 3, 'repas': 3, 'hotel': 1, 'voyage': 1, 'bijoux': 2};

/// Poids des désirs discrétionnaires dans le budget, par classe.
const Map<String, List<double>> desireWeight = {
  'divertissement': [1.0, 1.1, 0.7],
  'luxe': [0.15, 0.45, 1.2],
};

/// Poids de chaque désir dans le bonheur, par classe.
const Map<String, List<double>> happinessWeight = {
  'faim': [3, 3, 3],
  'logement': [3, 3, 3],
  'sante': [2, 2, 2],
  'divertissement': [1.5, 2, 1.5],
  'luxe': [0.3, 0.8, 2],
};

/// Chance quotidienne d'acheter un ordinateur quand on n'en a pas (s'il reste de l'épargne), par classe.
const List<double> computerWish = [0.01, 0.05, 0.04];

/// Biens achetés par les ménages (ports du node Ménages).
const List<String> householdGoods = [
  'pain', 'viande', 'poisson', 'repas', 'logement', 'soins', 'cours', 'tele', 'loisirs', 'ordinateur', 'bijoux', 'hotel',
  'voyage',
];

/// Services et biens d'équipement achetés par les entreprises hors recette.
const List<String> businessServices = ['compta', 'genie', 'reparation', 'pub', 'conception', 'machines'];

// ------------------------------------------------------------------ entreprises

class Template {
  final String label;
  final String code;
  final String sector;
  final Map<String, double> inputs;
  final Map<String, double> outputs;
  final double rate; // lots par employé par jour, sans machines
  final double? capacity; // lots/jour max
  final int skill; // qualification exigée : 0 manœuvre, 1 technicien, 2 professionnel
  final double capital; // gain maximal de productivité apporté par les machines (×1 + capital)
  final String? maint; // service d'entretien des machines et des opérations
  final String? rnd; // service acheté pour la recherche et développement
  final bool ads; // vend aux ménages : achète de la publicité
  const Template(this.label, this.code, this.sector, this.inputs, this.outputs, this.rate,
      {this.capacity, this.skill = 0, this.capital = 0.6, this.maint = 'reparation', this.rnd, this.ads = false});

  /// Entretien « lourd » : sans ingénierie, les opérations ralentissent (mines, puits, raffinage).
  bool get heavy => maint == 'genie';
}

// Un intrant par unité produite est quelque chose que cette unité consomme vraiment (farine du pain, carburant du
// voyage, fournitures d'une visite). L'équipement (ordinateurs d'un bureau, matériel d'un studio, matériaux du parc
// immobilier) relève des machines et de leur entretien, pas de la recette.
const Map<String, Template> templates = {
  // ---- primaire
  'ferme': Template('Ferme', 'FE', 'primaire', {}, {'grain': 4, 'betail': 0.25}, 1.2, capital: 1.0),
  'peche': Template('Pêcherie', 'PE', 'primaire', {'carburant': 0.05}, {'poisson': 8}, 1, capital: 0.8),
  'puits': Template('Puits de pétrole', 'PU', 'primaire', {}, {'petrole': 4}, 1,
      skill: 1, capital: 1.2, maint: 'genie', rnd: 'genie'),
  'bucheron': Template('Chantier forestier', 'BU', 'primaire', {}, {'bois': 5}, 1, capital: 1.0),
  'mineFer': Template('Mine de fer', 'MF', 'primaire', {}, {'fer': 4}, 1, capital: 1.2, maint: 'genie', rnd: 'genie'),
  'mineOr': Template('Mine d’or', 'MO', 'primaire', {}, {'or': 3}, 1, capital: 1.2, maint: 'genie', rnd: 'genie'),
  'mineBauxite':
      Template('Mine de bauxite', 'MB', 'primaire', {}, {'bauxite': 4}, 1, capital: 1.2, maint: 'genie', rnd: 'genie'),
  'mineCuivre':
      Template('Mine de cuivre', 'MC', 'primaire', {}, {'cuivre': 3}, 1, capital: 1.2, maint: 'genie', rnd: 'genie'),
  // ---- secondaire
  'boucherie': Template('Boucherie', 'BC', 'secondaire', {'betail': 0.1}, {'viande': 5}, 3, capital: 0.5, ads: true),
  'boulangerie': Template('Boulangerie', 'BL', 'secondaire', {'grain': 1}, {'pain': 10}, 3, capital: 0.6, ads: true),
  'raffinerie': Template('Raffinerie', 'RA', 'secondaire', {'petrole': 1}, {'carburant': 1}, 4,
      skill: 1, capital: 1.2, maint: 'genie', rnd: 'genie'),
  'petrochimie': Template('Pétrochimie', 'PL', 'secondaire', {'petrole': 0.5}, {'plastique': 4}, 3,
      skill: 1, capital: 1.0, maint: 'genie', rnd: 'genie'),
  'fonderie': Template('Fonderie', 'FO', 'secondaire', {'fer': 2, 'carburant': 0.2}, {'acier': 1}, 2,
      capital: 1.0, rnd: 'genie'),
  'aluminerie': Template('Aluminerie', 'AL', 'secondaire', {'bauxite': 2, 'carburant': 0.2}, {'aluminium': 1}, 2,
      skill: 1, capital: 1.0, rnd: 'genie'),
  'electronique': Template('Électronique', 'EL', 'secondaire', {'cuivre': 0.1, 'plastique': 0.3}, {'electronique': 2}, 3,
      skill: 1, capital: 1.0, rnd: 'conception'),
  'cpu': Template('Fonderie de puces', 'CP', 'secondaire', {'or': 0.2, 'cuivre': 0.1, 'conception': 0.3}, {'cpu': 1}, 1.5,
      skill: 2, capital: 1.2, rnd: 'conception'),
  'ordinateurs': Template('Ordinateurs', 'OR', 'secondaire',
      {'cpu': 1, 'electronique': 4, 'aluminium': 0.3, 'plastique': 1}, {'ordinateur': 1}, 1,
      skill: 1, capital: 0.8, rnd: 'conception', ads: true),
  'bijouterie': Template('Bijouterie', 'BJ', 'secondaire', {'or': 1}, {'bijoux': 1}, 1.5, skill: 1, capital: 0.4, ads: true),
  'garage': Template('Garage', 'GA', 'secondaire', {'acier': 0.02, 'electronique': 0.05}, {'reparation': 1}, 5,
      skill: 1, capital: 0.4, maint: null),
  'machinerie': Template('Machinerie', 'MA', 'secondaire', {'acier': 2, 'aluminium': 1, 'electronique': 6}, {'machines': 1},
      0.4,
      skill: 2, capital: 0.8, rnd: 'genie'),
  // ---- tertiaire
  'ingPetrole': Template('Ingénierie pétrolière', 'IP', 'tertiaire', {}, {'genie': 1}, 5, skill: 2, capital: 0.3, maint: null),
  'ingCpu': Template('Ingénierie de CPU', 'IC', 'tertiaire', {}, {'conception': 1}, 3, skill: 2, capital: 0.3, maint: null),
  'marketing': Template('Marketing', 'MK', 'tertiaire', {}, {'pub': 1}, 3, skill: 2, capital: 0.3, maint: null),
  'comptable': Template('Comptabilité', 'CA', 'tertiaire', {}, {'compta': 1}, 6, skill: 2, capital: 0.3, maint: null),
  'restaurant': Template('Restaurant', 'RE', 'tertiaire', {'pain': 0.4, 'viande': 0.15, 'poisson': 0.1}, {'repas': 1}, 10,
      capital: 0.4, ads: true),
  'tele': Template('Production télé', 'TV', 'tertiaire', {}, {'tele': 1}, 50, skill: 1, capital: 0.6, ads: true),
  'hotel': Template('Hôtel', 'HO', 'tertiaire', {'pain': 0.5, 'viande': 0.2}, {'hotel': 1}, 4, capital: 0.4, ads: true),
  'tourisme': Template('Tourisme', 'VO', 'tertiaire', {'carburant': 0.3}, {'voyage': 1}, 2,
      skill: 1, capital: 0.3, maint: null, ads: true),
  'hopital':
      Template('Hôpital', 'HP', 'tertiaire', {'electronique': 0.1, 'plastique': 0.2}, {'soins': 1}, 3, skill: 2, capital: 0.8),
  'ecole': Template('École', 'EC', 'tertiaire', {}, {'cours': 1}, 12, skill: 2, capital: 0.3, maint: null),
  // la nuitée ne consomme ni bois ni acier : ils serviront à la construction (plan de stabilisation, tâche 6)
  'immobilier': Template('Immobilier', 'IM', 'tertiaire', {}, {'logement': 1}, 24, capital: 0.4),
  'divertissement': Template('Divertissement', 'DI', 'tertiaire', {}, {'loisirs': 1}, 8, capital: 0.3, ads: true),
  // Module « buildings » : un module = environ 6 jours-personnes de chantier + 5 m³ de bois + 2 lingots d'acier. Un logement
  // en demande Params.dwellingModules (10 par défaut). Créée au départ seulement si le module est actif.
  'construction': Template('Construction', 'CO', 'secondaire', {'bois': 5, 'acier': 2}, {'batiment': 1}, 0.17,
      capital: 0.5, rnd: 'genie'),
};

// ------------------------------------------------------------------ rôles en entreprise (module « jobs »)

/// Un rôle dans l'organigramme d'un type d'entreprise. Le salaire offert pour un rôle est le salaire affiché de
/// l'entreprise (celui de la qualification de son gabarit) × classWage[classe du rôle] ÷ classWage[classe du gabarit]
/// × [premium] : un rôle de technicien dans un hôpital se paie comme un technicien, pas comme un médecin.
class Role {
  final String label;
  final double minSkill; // qualification minimale (0 à 3) ; sa partie entière, plafonnée à 2, donne la classe du rôle
  final double premium; // prime du rôle à l'intérieur de sa classe (responsabilités, spécialisation)
  final double share; // part visée de l'effectif ; les postes se répartissent à la plus forte moyenne (D'Hondt)
  final int minTenure; // ancienneté minimale dans l'entreprise (jours) : poste pourvu par promotion seulement
  const Role(this.label, this.minSkill, this.premium, this.share, {this.minTenure = 0});

  int get level => minSkill >= 2 ? 2 : (minSkill >= 1 ? 1 : 0);
  bool get internal => minTenure > 0;
}

/// Organigramme de chaque type d'entreprise (choix de jeu). Chaque type a au moins un rôle à la portée de la
/// qualification de son gabarit : sans le module, ses employés y ont tous droit. Les rôles d'encadrement exigent de
/// l'ancienneté et ne se pourvoient que par promotion interne (marché interne du travail, Doeringer et Piore 1971).
const Map<String, List<Role>> roles = {
  // ---- primaire
  'ferme': [
    Role('Aide agricole', 0, 1.0, 0.55),
    Role('Machiniste agricole', 0.5, 1.08, 0.30),
    Role('Agronome', 2, 0.9, 0.05),
    Role('Responsable de la ferme', 1, 1.1, 0.10, minTenure: 365),
  ],
  'peche': [
    Role('Matelot', 0, 1.0, 0.60),
    Role('Machiniste de bord', 0.6, 1.1, 0.25),
    Role('Capitaine', 1, 1.1, 0.15, minTenure: 365),
  ],
  'puits': [
    Role('Manœuvre de plancher', 0, 1.1, 0.30),
    Role('Spécialiste du forage', 1, 1.0, 0.45),
    Role('Géologue', 2, 1.0, 0.10),
    Role('Chef de chantier', 1.5, 1.15, 0.15, minTenure: 365),
  ],
  'bucheron': [
    Role('Manœuvre d’abattage', 0, 1.0, 0.60),
    Role('Machiniste en foresterie', 0.5, 1.1, 0.30),
    Role('Chef d’équipe', 1, 1.05, 0.10, minTenure: 365),
  ],
  'mineFer': _mineRoles,
  'mineOr': _mineRoles,
  'mineBauxite': _mineRoles,
  'mineCuivre': _mineRoles,
  // ---- secondaire
  'boucherie': [
    Role('Aide en boucherie', 0, 1.0, 0.50),
    Role('Spécialiste de la coupe', 0.5, 1.1, 0.35),
    Role('Responsable du comptoir', 1, 1.0, 0.15, minTenure: 180),
  ],
  'boulangerie': [
    Role('Aide en boulangerie', 0, 1.0, 0.45),
    Role('Spécialiste de la cuisson', 0.5, 1.1, 0.35),
    Role('Commis de comptoir', 0, 0.95, 0.10),
    Role('Responsable de la boulangerie', 1, 1.0, 0.10, minTenure: 180),
  ],
  'raffinerie': [
    Role('Manœuvre de raffinerie', 0, 1.1, 0.20),
    Role('Technologue en procédés', 1, 1.0, 0.50),
    Role('Chimiste', 2, 1.0, 0.15),
    Role('Chef de quart', 1.5, 1.15, 0.15, minTenure: 365),
  ],
  'petrochimie': [
    Role('Manœuvre d’usine', 0, 1.1, 0.25),
    Role('Technologue en plasturgie', 1, 1.0, 0.50),
    Role('Chimiste', 2, 1.0, 0.10),
    Role('Chef de production', 1.5, 1.15, 0.15, minTenure: 365),
  ],
  'fonderie': [
    Role('Manœuvre de fonderie', 0, 1.0, 0.45),
    Role('Machiniste de coulée', 0.5, 1.1, 0.30),
    Role('Métallurgiste', 1, 1.0, 0.15),
    Role('Chef d’équipe', 1, 1.05, 0.10, minTenure: 365),
  ],
  'aluminerie': [
    Role('Manœuvre de salle de cuves', 0, 1.1, 0.25),
    Role('Technologue en électrolyse', 1, 1.0, 0.50),
    Role('Métallurgiste', 2, 0.95, 0.10),
    Role('Chef de secteur', 1.5, 1.15, 0.15, minTenure: 365),
  ],
  'electronique': [
    Role('Commis d’assemblage', 0, 1.1, 0.30),
    Role('Technologue en électronique', 1, 1.0, 0.50),
    Role('Spécialiste du contrôle de qualité', 1.5, 1.05, 0.10),
    Role('Chef de ligne', 1.5, 1.15, 0.10, minTenure: 365),
  ],
  'cpu': [
    Role('Technologue en salle blanche', 1, 1.0, 0.40),
    Role('Spécialiste en lithographie', 2, 1.0, 0.40),
    Role('Scientifique des matériaux', 2.5, 1.1, 0.10),
    Role('Responsable de l’usine', 2, 1.25, 0.10, minTenure: 365),
  ],
  'ordinateurs': [
    Role('Commis d’assemblage', 0, 1.1, 0.30),
    Role('Technologue en informatique', 1, 1.0, 0.45),
    Role('Spécialiste des essais', 1.5, 1.05, 0.15),
    Role('Chef de production', 1.5, 1.15, 0.10, minTenure: 365),
  ],
  'bijouterie': [
    Role('Commis de boutique', 0, 1.1, 0.30),
    Role('Spécialiste en joaillerie', 1, 1.0, 0.55),
    Role('Responsable de l’atelier', 1.5, 1.15, 0.15, minTenure: 365),
  ],
  'garage': [
    Role('Commis aux pièces', 0, 1.1, 0.25),
    Role('Spécialiste en mécanique', 1, 1.0, 0.60),
    Role('Chef d’atelier', 1.5, 1.15, 0.15, minTenure: 365),
  ],
  'machinerie': [
    Role('Machiniste', 1, 1.0, 0.40),
    Role('Spécialiste en conception mécanique', 2, 1.0, 0.45),
    Role('Responsable de l’usine', 2, 1.25, 0.15, minTenure: 365),
  ],
  // ---- tertiaire
  'ingPetrole': [
    Role('Technologue en génie', 1, 1.0, 0.25),
    Role('Spécialiste en génie pétrolier', 2, 1.0, 0.60),
    Role('Responsable de projets', 2.5, 1.15, 0.15, minTenure: 365),
  ],
  'ingCpu': [
    Role('Technologue en conception', 1, 1.0, 0.25),
    Role('Architecte de puces', 2, 1.0, 0.60),
    Role('Responsable de projets', 2.5, 1.15, 0.15, minTenure: 365),
  ],
  'marketing': [
    Role('Commis de bureau', 0, 1.2, 0.15),
    Role('Graphiste', 1, 1.0, 0.25),
    Role('Stratège en marketing', 2, 1.0, 0.45),
    Role('Responsable de la création', 2, 1.25, 0.15, minTenure: 365),
  ],
  'comptable': [
    Role('Commis comptable', 1, 1.0, 0.30),
    Role('Comptable', 2, 1.0, 0.55),
    Role('Responsable de mission', 2.5, 1.2, 0.15, minTenure: 365),
  ],
  'restaurant': [
    Role('Commis de cuisine', 0, 1.0, 0.40),
    Role('Service aux tables', 0, 1.0, 0.35),
    Role('Chef de partie', 0.5, 1.1, 0.15),
    Role('Responsable de salle', 1, 1.0, 0.10, minTenure: 180),
  ],
  'tele': [
    Role('Commis de production', 0, 1.1, 0.20),
    Role('Spécialiste du son et de l’image', 1, 1.0, 0.45),
    Role('Journaliste', 2, 0.95, 0.20),
    Role('Responsable de la programmation', 2, 1.15, 0.15, minTenure: 365),
  ],
  'hotel': [
    Role('Commis à l’entretien', 0, 1.0, 0.45),
    Role('Réceptionniste', 0.5, 1.05, 0.30),
    Role('Concierge', 1, 0.95, 0.15),
    Role('Responsable de l’hôtel', 1, 1.2, 0.10, minTenure: 365),
  ],
  'tourisme': [
    Role('Commis de bureau', 0, 1.1, 0.20),
    Role('Guide touristique', 1, 1.0, 0.50),
    Role('Spécialiste des voyages', 1, 1.05, 0.20),
    Role('Responsable de l’agence', 1.5, 1.15, 0.10, minTenure: 365),
  ],
  'hopital': [
    Role('Préposé(e) aux bénéficiaires', 0, 1.0, 0.20),
    Role('Infirmier(ère)', 1, 1.0, 0.40),
    Role('Médecin', 2, 1.0, 0.30),
    Role('Médecin-chef', 2.5, 1.2, 0.10, minTenure: 365),
  ],
  'ecole': [
    Role('Concierge', 0, 1.0, 0.10),
    Role('Aide pédagogique', 1, 1.0, 0.25),
    Role('Enseignant(e)', 2, 1.0, 0.55),
    Role('Direction d’école', 2.5, 1.2, 0.10, minTenure: 365),
  ],
  'immobilier': [
    Role('Concierge', 0, 1.0, 0.50),
    Role('Commis à l’entretien', 0.3, 1.05, 0.30),
    Role('Responsable des locations', 1, 0.95, 0.10),
    Role('Gestionnaire d’immeubles', 1, 1.15, 0.10, minTenure: 365),
  ],
  'divertissement': [
    Role('Commis de bar', 0, 1.0, 0.45),
    Role('Garde de sécurité', 0, 1.05, 0.20),
    Role('DJ', 0.5, 1.1, 0.20),
    Role('Responsable du bar', 1, 1.0, 0.15, minTenure: 180),
  ],
  'construction': [
    Role('Manœuvre de chantier', 0, 1.0, 0.50),
    Role('Spécialiste en charpente', 0.5, 1.12, 0.35),
    Role('Chef de chantier', 1, 1.1, 0.15, minTenure: 365),
  ],
};

const List<Role> _mineRoles = [
  Role('Manœuvre de mine', 0, 1.0, 0.50),
  Role('Machiniste de mine', 0.4, 1.06, 0.20),
  Role('Boutefeu', 0.6, 1.12, 0.15),
  Role('Géologue', 2, 0.85, 0.05),
  Role('Chef de quart', 1, 1.1, 0.10, minTenure: 365),
];

/// Salaire d'un rôle rapporté au salaire affiché de l'entreprise (celui de la classe de son gabarit).
double roleRel(String type, int r) {
  final role = roles[type]![r];
  return classWage[role.level] * role.premium / classWage[templates[type]!.skill];
}

/// Salaire moyen par employé d'un type d'entreprise, rapporté à son salaire affiché, quand l'organigramme est complet.
double avgRoleRel(String type) {
  final rs = roles[type]!;
  var s = 0.0, w = 0.0;
  for (var i = 0; i < rs.length; i++) {
    s += rs[i].share * roleRel(type, i);
    w += rs[i].share;
  }
  return w > 0 ? s / w : 1.0;
}

/// Rôle du prochain poste d'une équipe dont les effectifs par rôle sont [counts] : la plus forte moyenne
/// part ÷ (effectif + 1), à égalité le premier rôle de la liste (méthode D'Hondt). [skip] : rôles exclus.
int nextSeat(String type, List<int> counts, [Set<int> skip = const {}]) {
  final rs = roles[type]!;
  var best = -1;
  var bestV = -1.0;
  for (var i = 0; i < rs.length; i++) {
    if (skip.contains(i)) continue;
    final v = rs[i].share / (counts[i] + 1);
    if (v > bestV + 1e-12) {
      best = i;
      bestV = v;
    }
  }
  return best;
}

/// Effectifs par rôle d'une équipe de [n] personnes, dans l'ordre des postes (le k-ième poste va au k-ième rôle).
List<int> seatOrder(String type, int n) {
  final counts = List<int>.filled(roles[type]!.length, 0);
  final out = <int>[];
  for (var k = 0; k < n; k++) {
    final r = nextSeat(type, counts);
    counts[r]++;
    out.add(r);
  }
  return out;
}

/// Le type d'entreprise qui produit chaque bien.
final Map<String, String> producerOf = {
  for (final e in templates.entries)
    for (final g in e.value.outputs.keys) g: e.key,
};

/// Paramètres de la partie. Tout paramètre ajouté doit l'être aussi dans les instantanés (snapshot.dart).
class Params {
  int population = 240;
  double startWallet = 3000;
  double startWage = 150;
  double markup = 1.15;
  double bufferDays = 12;
  // Consommation à la Godley-Lavoie : C = α₁ · (revenu − besoins) + α₂ · (richesse − coussin).
  // α₁ = 0,6 (valeur du modèle SIM). α₂ = (1 − α₁) / T : chaque ménage converge vers T jours de revenu
  // discrétionnaire au-delà du coussin. T = 20 reproduit la richesse de départ de la calibration v2
  // (2 750 $ ≈ 21 jours), pour que le capital initial soit cohérent avec la fonction de consommation.
  double mpcIncome = 0.6;
  double wealthTargetDays = 20;
  double get propensity => (1 - mpcIncome) / wealthTargetDays;
  bool trade = false;
  double importMarkup = 1.3;
  double exportDiscount = 0.7;
  double ubi = 0;
  double priceStep = 0.02;
  double wageStep = 0.015;
  // Variation quotidienne maximale des prix et salaires décidée par les entreprises elles-mêmes (coûts d'étiquetage,
  // contrats, réputation). Elle est sous le plafond de 2 %/j du filet, qui ne sert plus que de garde-fou.
  double priceMaxDaily = 0.015;
  double wageMaxDaily = 0.015;
  double dividendRate = 0.08;
  double invTargetDays = 4;
  double jobSwitch = 0.03;
  double taxRate = 0.12;
  double benefit = 80;
  double minWage = 0;
  double stateRebate = 0.05;
  // capital, technologie, crédit
  double interestRate = 0.06; // annuel
  double loanTermDays = 365;
  // Fonds de roulement : une entreprise rentable dont des clients repartent les mains vides peut emprunter de quoi
  // embaucher (8 jours de salaires par poste), jusqu'à ce plafond de jours de chiffre d'affaires (« prêt/revenu »).
  // À 30 jours, la Caisse devenait insolvable dans 4 graines sur 5 (radiations de 30 à 62 k$) ; 15 jours la garde solvable.
  double workingCapitalDays = 15;
  // Entrée et sortie d'entreprises
  int exitIdleDays = 30; // une entreprise sans employé depuis 30 jours ferme
  int entryCooldown = 60; // délai entre deux créations d'un même type d'entreprise
  double entryMinShare = 0.1; // demande non servie minimale : 10 % de la production d'un employé (sans producteur)
  double entryMarginRatio = 1.4; // concurrence : prix des entreprises en place ≥ 1,4 × leur coût de revient
  double depreciation = 0.003; // usure quotidienne des machines entretenues
  double maintNeed = 0.05; // heures d'entretien par machine et par jour
  // Intrants secondaires : sous cette part du coût d'un lot, un intrant qui manque ralentit la cadence en proportion
  // de son poids au lieu de l'arrêter (une pêcherie sans carburant pêche moins, elle ne ferme pas). Au-dessus,
  // la recette est stricte (Leontief). À 5 %, presque aucun intrant ne serait concerné ; 15 % couvre les
  // ingrédients et fournitures en gardant les matières principales strictes.
  double softInputShare = 0.15;
  double rndShare = 0.02; // part de la trésorerie excédentaire consacrée à la R-D chaque jour
  double bankRebate = 0.05; // part du surplus de la Caisse ristournée chaque jour
  // Caisse : capital de départ (parts sociales) et fonds propres visés avant toute ristourne.
  // 100 $ par citoyen couvre 11,5 % d'un encours de 870 $ par citoyen, bien au-delà des pointes observées ;
  // la cible de 15 % est celle des grandes banques canadiennes (13,6 % observé), au-dessus du plancher de 11,5 %.
  double bankCapitalPerCitizen = 100;
  double bankTargetRatio = 0.15;
  double riskSpread = 0.06; // prime de risque annuelle à pleine garantie (dette = 80 % des machines)
  // marketing
  double adsShare = 0.03; // part du chiffre d'affaires dépensée en publicité
  double adsEffect = 0.6; // hausse maximale de la dépense des ménages due à la publicité
  // santé, éducation
  double illness = 0.004; // chance quotidienne de tomber malade
  double eduRate = 0.25; // chance quotidienne de suivre un cours, × ambition
  double learnRate = 0.02; // qualification gagnée par cours
  int computerLife = 365;
  // Test de solvabilité (I1) : plafond du dividende du jour. Faux : le bénéfice lissé du jour (règle du cahier des
  // charges). Vrai : les bénéfices non répartis (lecture de la LCSA, art. 42 b : le dividende ne doit pas entamer le
  // capital déclaré).
  bool dividendFromRetained = false;
  // Enveloppe des établissements publics : l'État porte leur trésorerie à ce nombre de jours du coût de l'équipe
  // nécessaire. Raison : la règle d'embauche exige 8 jours de salaire par employé en caisse ; 2 jours de plus laissent
  // une marge pour les intrants et les services. Au-delà de 1,5 fois cette trésorerie, l'excédent revient au trésor.
  double publicCashDays = 10;
  // Assurance-emploi (I3), repères du régime canadien en 2025 (canada.ca) ; un jour de jeu = un jour.
  // Prestation : 55 % de la rémunération assurable.
  double eiReplacement = 0.55;
  // Rémunération assurable plafonnée : 65 700 $ par an en 2025, soit ~1 263 $ par semaine, à peu près la rémunération
  // hebdomadaire moyenne (1 293 $ en mai 2025, Statistique Canada). Ici : plafond = 1 × le salaire moyen de l'économie.
  double eiInsurableCap = 1.0;
  // Cotisation : 1,64 $ par 100 $ de rémunération assurable pour l'employé et 1,4 fois plus pour l'employeur (2,296 $),
  // soit 3,94 %. Prélevée avec l'impôt sur le salaire : dans le modèle, le salaire est le coût total du travail, la part
  // de l'employeur est donc supportée par le salaire (hypothèse d'incidence usuelle).
  double eiRate = 0.0394;
  // Durée : pour un emploi à plein temps toute l'année (1 820 heures et plus), 36 semaines quand le chômage est de 6 %
  // ou moins, jusqu'à 45 semaines à 16 % et plus (Loi sur l'assurance-emploi, annexe I) ; interpolation linéaire entre
  // les deux, au taux de chômage du jour de la demande.
  int eiDaysLow = 252;
  int eiDaysHigh = 315;
  // Admissibilité : au moins 420 heures d'emploi assurable (le minimum, exigé dans les régions au chômage le plus élevé),
  // soit 12 semaines à 35 heures : 84 jours employés depuis la dernière demande.
  int eiQualifyingDays = 84;
  // Population pour laquelle le scénario par défaut (une entreprise de chaque type) a été réglé. Une population plus
  // grande reçoit ce scénario répété round(population ÷ scenarioPopulation) fois : mêmes équipes, même nombre
  // d'entreprises par habitant (initialisation seulement ; aucune règle de comportement ne change).
  int scenarioPopulation = 240;
  // Variantes de test (tâche 4, artefacts) : jamais actives par défaut, la décision reste à Francis.
  // A1. La santé ne s'use (desireDecay['sante'] par jour) que les jours de faim ou sans logis ; les maladies restent.
  // Variante aussi plausible que l'usure constante : sans vieillissement, une personne nourrie et logée ne s'use pas.
  bool healthWearIfDeprived = false;
  // A2. Travail divisible : une équipe sous-employée travaille, et est payée, à temps partiel selon la production du
  // jour (au moins 20 % du temps, un jour par semaine) ; le coût de revient ne répartit plus les heures oisives.
  // ACTIF PAR DÉFAUT depuis le 2026-10-21 (décision de Francis) : sans lui, à 240 citoyens, les petites filières
  // (plastique, électronique, bijoux, machines…) font faillite faute de pouvoir payer un employé entier, et l'hôpital sans
  // plastique ne soigne plus personne (anomalies A2 et A1). L'ancien comportement se rejoue avec --param partTime=0.
  bool partTime = true;
  // Recherche limitée des vendeurs : chaque achat d'un ménage n'examine que k vendeurs tirés parmi ceux qui ont une unité
  // en stock, plus celui de son dernier achat de ce bien (habitude), et prend le meilleur de cet échantillon selon la
  // règle habituelle (prix, notoriété). 0 : chaque achat compare tous les vendeurs du bien.
  // RÈGLE DE MARCHÉ, pas une optimisation neutre : c'est une information imparfaite des ménages sur les prix. Valeur par
  // défaut du jeu depuis la décision de Francis (18 octobre 2026) : k = 5, qui ne change rien à 240 et à 1 000 citoyens
  // (jamais plus de k + 1 vendeurs d'un même bien) et qui évite à grande échelle l'effondrement de la comparaison complète
  // (journal, § 9). À réexaminer avec les variétés de produits. Le protocole historique à k = 0 se rejoue avec
  // `--param sellerSample=0`.
  int sellerSample = 5;

  // ---- Rôles, contrats et négociation salariale (module « jobs »). Choix de jeu, sauf mention.
  // Salaire de réserve d'un sans-emploi : son dernier salaire, qui baisse de reservationDecay par jour de chômage
  // jusqu'à reservationFloor × ce salaire, et jamais sous ce qu'il faut pour gagner 10 % de plus que sa prestation
  // (après impôt et cotisation). Le salaire de réserve baisse avec la durée du chômage (Krueger et Mueller 2016, qui
  // le mesurent beaucoup plus lent : ici, le jeu doit dégager les marchés en quelques semaines). Avec un plancher de
  // 0,6, les chômeurs de longue durée demandaient toujours 60 % de leur ancien salaire : chômage médian +1,8 pt
  // (mesuré, 10 graines × 1 000 jours) ; à 0, il ne reste après 100 jours que la prestation comme plancher.
  double reservationDecay = 0.01;
  double reservationFloor = 0;
  // Un employé ne change d'emploi que pour switchPremium de plus que son salaire, plus 1 % par année d'ancienneté
  // perdue (au plus 10 %). 8 % : la règle de mobilité du modèle sans le module.
  double switchPremium = 0.08;
  // Pouvoir de négociation de l'employé (Pissarides 2000) : part du surplus entre le plancher (le plus haut du salaire
  // offert et de son salaire de réserve) et le plafond de l'employeur qui lui revient. bargainBase + bargainTrait ×
  // aplomb + bargainTight × θ/(1 + θ), où θ = postes ouverts ÷ candidats admissibles de sa classe ; borné à [0,05 ; 0,7].
  double bargainBase = 0.1;
  double bargainTrait = 0.3;
  double bargainTight = 0.3;
  // Fourchette salariale : le salaire offert pour un rôle est le milieu d'une fourchette de ± hireRange (une offre
  // d'emploi « entre X et Y $ »). Le bas est le plancher de la négociation ; le haut, majoré d'une souplesse de
  // hireFlexBase à hireFlexBase + hireFlexMax selon l'ancienneté des postes vacants (10 jours pour le maximum) et la
  // demande non servie, est le plafond de l'employeur, jamais au-delà de ce que la valeur ajoutée par employé permet.
  // Avec l'offre pour plancher, chaque embauche se concluait au-dessus de l'offre (+8 à 10 %) : chômage médian 24 %
  // au lieu de 21 % (mesuré, 10 graines × 1 000 jours, avant le renouvellement des contrats).
  double hireRange = 0.10;
  double hireFlexBase = 0.05;
  double hireFlexMax = 0.25;
  // Candidats reçus par poste et par jour avant de renoncer à ce rôle pour la journée.
  int maxInterviews = 3;
  // Renouvellement du contrat tous les reviewDays jours depuis l'embauche (contrats échelonnés, Taylor 1980) : le
  // salaire est renégocié à l'offre du rôle majorée de seniorityStep par année d'ancienneté (au plus seniorityCap).
  // Hausse gelée si l'entreprise perd de l'argent. Baisse : au plus reviewCutMax du salaire (1 : retour au taux du
  // marché ; 0 : jamais de baisse, la rigidité à la baisse des salaires nominaux décrite par Bewley 1999). Mesures
  // (10 graines × 1 000 jours, avec filets ; 9,4 % sans le module) : sans baisse, chômage médian 21 % (les contrats ne
  // descendent jamais quand le chômage fait baisser les offres, alors que le modèle de base ne retrouve l'emploi qu'en
  // baissant les salaires, d'environ 40 % par an) ; renouvellement annuel 15 % ; trimestriel 12 %. Trimestriel : choix
  // de jeu, plus fréquent que les révisions annuelles usuelles, pour suivre la déflation du modèle. Une concession des
  // entreprises en pertes (5 % par mois au plus) a été essayée et ne changeait rien (rapports/emplois-negociation.md).
  int reviewDays = 90;
  double reviewCutMax = 1;
  double seniorityStep = 0.015;
  double seniorityCap = 0.15;
  // Une promotion rapporte au moins cette hausse.
  double promotionRaise = 0.05;

  // ---- Bâtiments et hypothèques (module « buildings »). Le temps du jeu est le temps réel : taux annuels / 365, durées en jours.
  // Un logement = N modules de construction. Le module coûte 1 800 à 3 000 $ selon l'activité du constructeur (un seul
  // employé, mal occupé, renchérit le module), donc un logement 18 000 à 30 000 $, soit 5 à 8 ans du loyer actuel du modèle
  // (~10 $ la nuitée = 3 650 $/an). C'est l'échelle du loyer du modèle, pas celle de l'immobilier canadien (prix de 5 à 8
  // ans de revenu, loyer de 25 à 30 % du revenu). À valider (voir rapports/batiments-hypotheques.md).
  int dwellingModules = 10;
  // Usure structurelle : 4 %/an (durée de vie ~25 ans sans rénovation). Un entretien complet (heures de réparation)
  // compense la part buildingMaintShare de l'usure ; sans entretien, l'état baisse de 4 %/an.
  double buildingWearYear = 0.04;
  double buildingMaintShare = 0.75;
  // Entretien complet : 0,012 heure de réparation par logement et par jour (~0,7 $/j, soit ~1,5 %/an de la valeur ;
  // règle courante de 1 à 2 % par an).
  double maintHoursPerDwelling = 0.012;
  // Mise de fonds (LTV maximal) : 95 % pour un ménage (assurance hypothécaire canadienne : mise de fonds minimale de
  // 5 %), 70 % pour une entreprise qui construit (prêt commercial).
  double ltvHousehold = 0.95;
  double ltvFirm = 0.70;
  // Taux : taux de base + prime croissante avec le levier, de 0 (LTV ≤ 50 %) à mortgageSpreadMax (LTV ≥ 95 %).
  double mortgageSpreadMax = 0.02;
  // Durée d'amortissement : 25 ans pour un ménage, 10 ans pour une entreprise.
  int mortgageTermHousehold = 9125;
  int mortgageTermFirm = 3650;
  // Pondération du risque d'une hypothèque résidentielle dans les fonds propres exigés de la Caisse (Bâle III, approche
  // standard : 35 %). Les prêts aux entreprises restent pondérés à 100 %. Sans elle, 100 $ de capital par citoyen ne
  // financent presque aucun logement (voir Caisse : minCapitalRatio).
  double mortgageRiskWeight = 0.35;
  // Après ce nombre de jours de retard consécutifs, la Caisse saisit le bâtiment et le met en vente.
  int foreclosureDays = 60;
  // Part des citoyens qui voudraient devenir propriétaires (trait fixe, tiré à la naissance).
  double ownerShare = 0.7;
  // Chance quotidienne qu'un locataire désireux d'acheter regarde le marché ; chance quotidienne qu'un propriétaire vende
  // pour déménager.
  double buyLookChance = 0.02;
  double relocateChance = 0.0005;
  // Prix demandé : valeur courante × (1 + marge) ; sans acheteur, il baisse de listingDecay par jour jusqu'à
  // listingFloor × la valeur courante.
  double listingMargin = 0.05;
  double listingDecay = 0.005;
  double listingFloor = 0.7;
  // Un bailleur lance un chantier quand la demande de nuitées dépasse cette part de son parc (y compris les chantiers) ;
  // il ne met en vente que si la demande reste sous cette part du parc restant (il garde de quoi loger ses locataires).
  double landlordBuildAbove = 0.96;
  // Un ménage achète si son coût mensuel de propriétaire (versement + entretien) ne dépasse pas ce multiple du loyer.
  double buyRentRatio = 1.2;

  // ---- Entrepreneuriat des citoyens (Modules.entrepreneurship). Aucune de ces valeurs n'est réglée sur une cible : ce sont
  // des ordres de grandeur a priori, exposés pour être changés. Repère (non visé) : au Canada, environ 10 % d'entrées et 9 %
  // de sorties d'entreprises par an (Statistique Canada).
  // Multiplicateur du taux de fondation : chance quotidienne qu'un candidat éligible examine un projet, × cette valeur.
  double entFoundRate = 1.0;
  // Chance quotidienne de base qu'un candidat éligible examine la possibilité de fonder (avant le multiplicateur).
  double entConsiderRate = 0.001;
  // Tolérance au risque = clamp(moyenne + écart × (2u − 1)), u tiré à la naissance (uniforme). Avec 0,5 et 0,5 : uniforme sur
  // [0, 1]. Le tirage est gardé : changer ces deux valeurs déplace la distribution de tous les citoyens, présents compris.
  double entRiskMean = 0.5;
  double entRiskSpread = 0.5;
  // Seuils d'éligibilité : ambition et tolérance au risque minimales (avec le désir de posséder, Params.ownerShare).
  double entMinAmbition = 0.3;
  double entMinTolerance = 0.25;
  // Exigence de capital : multiple du capital de démarrage d'une entreprise (10 jours de salaires + 5 jours d'intrants).
  double entCapitalMult = 1.0;
  // Part du capital que le fondateur doit mettre de sa poche (le reste vient de la Caisse, selon ses règles prudentielles).
  double entMinOwnShare = 0.3;
  // Jours travaillés dans un secteur pour connaître 63 % de ce qu'il y a à savoir (connaissance = 1 − exp(−jours / valeur)).
  double entKnowledgeDays = 365;
  // Chance de survie sans connaissance du secteur, et gain maximal que la connaissance y ajoute.
  double entSurviveBase = 0.5;
  double entSurviveKnowledge = 0.35;

  // ---- Variétés de produits (Modules.products). Ordres de grandeur a priori, non réglés sur un résultat.
  // Utilité d'une variété pour un ménage : poids de la qualité × qualité × goût de sa classe pour la catégorie
  // − sensibilité au prix × prix / prix mondial + notoriété (publicité) + habitude + goût personnel.
  double prodQualityWeight = 1.0;
  double prodPriceSens = 1.0; // sensibilité moyenne ; celle d'un citoyen va de 0,5 à 1,5 fois cette valeur (trait)
  double prodTasteSpread = 0.5; // goût personnel durable : uniforme dans ± cette valeur
  double prodHabit = 0.15; // bonus de la dernière variété achetée dans la catégorie
  int prodForgetDays = 60; // une variété ni achetée ni revue depuis ce nombre de jours est oubliée
  int prodKnownMax = 8; // variétés connues au plus, par catégorie
  double prodAdRate = 0.03; // chance quotidienne de découvrir une variété (vitrine, publicité : pondérée par la notoriété)
  double prodWordRate = 0.02; // chance quotidienne d'apprendre celle qu'achète un collègue (bouche-à-oreille)
  double prodQualityCost = 0.5; // la productivité est divisée par 1 + ce coefficient × (qualité − 1)
  int prodMakersMax = 3; // fabricants de machines connus par une entreprise
  double prodMakerLearn = 0.01; // chance quotidienne qu'une entreprise découvre un fabricant
  double prodLoyalty = 0.1; // préférence pour le fournisseur habituel (score × 1 + cette valeur)
  double prodEntryMargin = 0.15; // marge moyenne des vendeurs en place jugée attrayante pour lancer une variété

  // ---- Crédit aux citoyens et banques (Modules.banking). Ordres de grandeur a priori, non réglés sur un résultat.
  double cardRate = 0.20; // taux annuel de base de la carte de crédit
  double cardMinPct = 0.03; // paiement minimum mensuel : part du solde (au moins les intérêts du mois)
  double cardLimitDays = 30; // limite de la carte : jours de revenu, selon la cote
  double loanRateSpread = 0.04; // prêt personnel : taux d'intérêt de base + cette marge
  int loanTermMonths = 12; // durée d'un prêt personnel (mois de 30 jours)
  double creditRiskPremium = 0.10; // prime annuelle maximale selon la cote (cote 300 : toute la prime)
  double dsrMax = 0.40; // service de la dette (mensualités + paiement minimum de la carte) ≤ cette part du revenu mensuel
  int creditMinScore = 550; // cote minimale pour obtenir un crédit
  int bkArrearsDays = 90; // faillite d'un citoyen : paiements en retard depuis ce nombre de jours…
  double bkDebtIncome = 2.0; // … ou, sans emploi, dette au-delà de ce nombre d'années de revenu
  int bkBanDays = 730; // après une faillite : crédit fermé pendant ce nombre de jours, cote abaissée ensuite
  double bankTightLoss = 0.03; // pertes annualisées sur les prêts aux particuliers à partir desquelles la banque resserre
  // Plusieurs banques (à partir de deux) : dotation, coûts, marché interbancaire, choix des clients, faillite.
  int nBanks = 3; // banques de départ (1 : la Caisse seule, comme sans concurrence)
  double reservePerCitizen = 100000; // dotation de chaque banque de départ, par citoyen : réserves, contrepartie fonds propres
  double policyRate = 0.03; // taux directeur : taux annuel du marché interbancaire (plafond des taux de dépôt)
  double reserveRatio = 0.02; // réserves minimales d'une banque, en part de ses dépôts
  int bankStaff = 3; // employés réels d'une banque : elle achète chaque jour leur travail de services (comptabilité)
  double bankRentDaily = 100; // local : loyer quotidien versé à un bailleur
  double bankLookChance = 0.005; // chance quotidienne qu'un client compare sa banque à une autre
  double bankSwitchGain = 0.005; // avantage annuel minimal pour changer de banque (coût de changer)
  int bankLossDays = 365; // faillite : profit lissé négatif depuis ce nombre de jours (ou capital sous le minimum)
  // Fondation de banques par des citoyens : freins d'entrée (des mécanismes, pas des plafonds de nombre).
  double bankFoundRate = 0.0005; // chance quotidienne qu'un candidat examine un projet de banque
  double bankMinCapital = 100000; // capital minimum absolu, en dollars (pas proportionnel à la population)
  double bankEntryCost = 20000; // coût d'entrée irrécupérable (permis, systèmes), versé à l'État

  // ---- Distribution de l'excédent de trésorerie (stabilisation, 2026-10-20). Coupé par défaut.
  // Une entreprise qui garde plus que excessCashDays jours de coûts (salaires, intrants, frais), plus sa dette et ses
  // fonds de réinvestissement, en reverse chaque jour la part excessCashRate de l'excédent à son propriétaire (imposée comme
  // un dividende). Sans elle, l'argent d'une vente de logements financée par hypothèque reste dans la caisse du bailleur :
  // ce n'est pas un bénéfice, le dividende (I1) ne le distribue pas, et les ménages s'appauvrissent en remboursant.
  bool excessCashReturn = false;
  double excessCashDays = 60;
  double excessCashRate = 0.02;

  // ---- Banque centrale : politique monétaire (2026-10-20). Coupée par défaut.
  // Avec policyPassThrough, le taux de base de tous les prêts (entreprises, hypothèques, particuliers ; plan de départ
  // compris) est le taux directeur (policyRate) plus policySpread, au lieu du taux fixe interestRate. Aux valeurs par
  // défaut, 3 % + 3 % = 6 % = interestRate (exactement, en virgule flottante) : activer la transmission ne change rien tant
  // que la banque centrale ne bouge pas son taux. Sans module banques, policyRate n'a pas d'autre effet.
  bool policyPassThrough = false;
  double policySpread = 0.03;

  // ---- Douane : prix mondiaux en vagues et droit de douane (2026-10-21). Neutres par défaut. Voir MODELE.md § 6.21.
  // Avec tradeWaves, les prix d'import et d'export de chaque bien sont multipliés par un facteur qui suit une vague
  // (amplitude tradeWaveAmp, période tradeWavePeriod jours, phase et période propres à chaque bien, tirées de la graine)
  // et un bruit quotidien AR(1) d'écart tradeNoise. Le droit de douane `tariff` majore le prix des importations ; la
  // part du droit va à l'État (comme une taxe), le reste sort de l'économie. Sans commerce (trade), rien ne change.
  bool tradeWaves = false;
  double tradeWaveAmp = 0.3;
  double tradeWavePeriod = 365;
  double tradeNoise = 0.02;
  double tariff = 0;
  // Taux de change flottant (floatingFx) : prix d'une unité de monnaie étrangère, 1 au départ. Chaque soir, frontières
  // ouvertes, il varie de fxSpeed × (importations − exportations) / (importations + exportations), moyennes lissées sur
  // une vingtaine de jours : un déficit commercial déprécie la monnaie (import plus cher, export mieux payé).
  bool floatingFx = false;
  double fxSpeed = 0.05;
  // Demande étrangère active (foreignDemand) : chaque entreprise d'un bien exportable a un carnet de commandes de
  // l'étranger. Tant que le prix à l'export couvre son coût unitaire + fdMinMargin et au moins 95 % de son prix d'ici, la
  // commande quotidienne grossit de fdGrowth par jour (si elle a été livrée à 90 % ou plus) ; sinon elle fond de 10 % par
  // jour. Elle démarre à fdStart de sa demande d'ici et plafonne à fdMaxCap fois cette demande (10 % de la production de
  // l'équipe pour une entreprise presque sans clients ici). Les livraisons comptent comme des ventes : la production et
  // l'embauche les suivent.
  bool foreignDemand = false;
  double fdGrowth = 0.02;
  double fdMinMargin = 0.05;
  double fdStart = 0.1;
  double fdMaxCap = 1;
}

// ------------------------------------------------------------------ interrupteurs de configuration

/// Modules ajoutés au modèle de base : chacun peut être coupé (en direct, et pour dimensionner une nouvelle partie).
class Modules {
  bool credit = true; // la Caisse prête pour acheter des machines (création monétaire)
  bool capital = true; // machines : productivité, usure, entretien, investissement
  bool rnd = true; // recherche et développement → niveaux technologiques
  bool marketing = true; // publicité : notoriété et dépense des ménages
  bool accounting = true; // comptabilité obligatoire pour les entreprises
  bool health = true; // maladies et soins
  bool education = true; // cours et progression des qualifications
  bool publicHealth = true; // l'État paie les soins
  bool publicEducation = true; // l'État paie les cours
  bool entry = true; // une entreprise sans employé ferme ; un bien qui manque attire une nouvelle entreprise
  // Institutions qui remplacent un filet de sécurité :
  // I1. Test de solvabilité avant dividende. Repère : Loi canadienne sur les sociétés par actions, art. 42 (une société
  // ne peut déclarer ni verser de dividende s'il y a des motifs raisonnables de croire qu'elle ne pourrait plus
  // acquitter son passif à échéance). Ici : pas de dividende sans bénéfice lissé, ni s'il empêche d'ouvrir les postes
  // voulus ; jamais plus que le bénéfice lissé du jour. Aucun paramètre nouveau.
  bool dividendTest = true;
  // I2. Enveloppe budgétaire des services publics (hôpital, école). L'État finance l'équipe nécessaire à la demande
  // attendue ; soins et cours publics sont gratuits et servis par ordre d'arrivée, avec une file d'attente mesurée.
  // Repère : au Canada, les hôpitaux sont surtout financés par un budget global versé par la province (Fraser
  // Institute, 2021), et non à la visite. Ne joue que si la santé (ou l'éducation) publique est active.
  bool publicBudget = true;
  // I3. Assurance-emploi indexée, puis aide sociale. La prestation suit le dernier salaire (55 %, plafonnée) pendant une
  // durée limitée qui s'allonge quand le chômage est élevé ; elle est financée par une cotisation prélevée avec l'impôt.
  // Après la durée maximale, ou sans emploi assurable suffisant, l'aide sociale verse le panier de survie.
  // Repères : régime canadien de 2025 (paramètres « ei… » ci-dessous).
  bool insurance = true;
  // I4. Règles prudentielles dans la politique normale de la Caisse : fonds propres d'au moins 11,5 % des prêts et
  // paiements de la dette d'un emprunteur au plus 35 % de sa valeur ajoutée (seuils de Safeguards.minCapitalRatio et
  // maxPaymentRatio, déjà documentés). Avant, ils n'existaient que dans le filet anti-crédit-fou ; le filet ne fait
  // plus que compter les refus.
  bool bankRegulation = true;
  // I5. Faillite ordonnée : à la fermeture, la trésorerie rembourse d'abord la dette envers la Caisse (la monnaie est
  // détruite), seul le solde impayé est radié, le reste va au propriétaire ou, s'il n'y en a pas, à l'État. Avant, la
  // dette était radiée avant que la trésorerie revienne au propriétaire : l'argent d'un prêt finissait chez lui et la
  // Caisse encaissait la perte. Aucun paramètre.
  bool bankruptcy = true;
  // Bâtiments et hypothèques : le parc de logements est fait de bâtiments qu'on construit, qu'on loue, qu'on achète à
  // crédit (hypothèque de la Caisse), qu'on revend et qui s'usent. Coupé par défaut : le parc suit alors la capacité fixée
  // au départ (comportement historique).
  bool buildings = false;
  // Rôles, contrats individuels et négociation salariale : chaque employé a un rôle de l'organigramme de son entreprise,
  // un salaire négocié à l'embauche (salaire de réserve contre plafond de l'employeur), révisé à chaque anniversaire et
  // relevé par une contre-offre quand un concurrent veut le débaucher ; promotions internes. Coupé par défaut : un seul
  // salaire par entreprise (comportement historique). L'interface lance ses parties avec le module actif.
  bool jobs = false;
  // Entrepreneuriat des citoyens : des citoyens ambitieux et peu averses au risque fondent des entreprises avec leur épargne
  // et un prêt de la Caisse, au lieu de créations mécaniques de clones. Coupé par défaut. Suppose « Entrée et sortie
  // d'entreprises » (les fermetures) : seule la fondation change.
  bool entrepreneurship = false;
  // Variétés de produits et marques : chaque entreprise d'un bien de consommation ou d'équipement vend sa variété (nom,
  // qualité, goût des ménages, notoriété) au lieu d'un clone. Coupé par défaut. Les variétés naissent et meurent avec les
  // entreprises : leur nombre n'est jamais fixé d'avance.
  bool products = false;
  // Crédit aux citoyens (prêt personnel, carte de crédit, cote, faillite personnelle) et, à partir de deux banques,
  // concurrence bancaire (réserves, marché interbancaire, fondations et faillites de banques). Coupé par défaut.
  bool banking = false;

  Modules();

  /// Tous les modules coupés : chaînes de production, emploi, nourriture, logement, loisirs.
  Modules.none() {
    for (final k in keys) {
      set(k, false);
    }
  }

  /// Le noyau du protocole : les modules économiques ajoutés au modèle de base sont coupés, les institutions qui
  /// remplacent les filets de sécurité restent actives (on mesure chaque institution dans le noyau aussi).
  Modules.noyau() {
    for (final k in keys) {
      if (!institutions.contains(k)) set(k, false);
    }
  }

  /// Institutions qui remplacent un filet de sécurité (voir rapports/stabilisation.md).
  static const List<String> institutions = [
    'dividendTest', 'publicBudget', 'insurance', 'bankRegulation', 'bankruptcy',
  ];

  static const List<String> keys = [
    'credit', 'capital', 'rnd', 'marketing', 'accounting', 'health', 'education', 'publicHealth', 'publicEducation',
    'entry', 'dividendTest', 'publicBudget', 'insurance', 'bankRegulation', 'bankruptcy', 'buildings', 'jobs',
    'entrepreneurship', 'products', 'banking',
  ];

  /// Modules apparus après la référence du moteur : ils n'apparaissent dans les instantanés, les empreintes et les
  /// synthèses que lorsqu'ils sont actifs.
  static const List<String> lateKeys = ['entrepreneurship', 'products', 'banking'];

  /// Les modules sous forme de table pour les instantanés et les empreintes. Un module apparu après la référence du moteur
  /// n'y figure que lorsqu'il est actif : coupé, la sérialisation est celle d'avant lui.
  Map<String, bool> toJson() => {
        for (final k in keys)
          if (!lateKeys.contains(k) || get(k)) k: get(k),
      };
  static const Map<String, String> labels = {
    'credit': 'Crédit bancaire (Caisse)',
    'capital': 'Machines et entretien',
    'rnd': 'Recherche et développement',
    'marketing': 'Publicité',
    'accounting': 'Comptabilité obligatoire',
    'health': 'Maladies et soins',
    'education': 'Formation et qualifications',
    'publicHealth': 'Santé publique (l’État paie)',
    'publicEducation': 'Éducation publique (l’État paie)',
    'entry': 'Entrée et sortie d’entreprises',
    'dividendTest': 'Dividendes : test de solvabilité',
    'publicBudget': 'Hôpital et école publics : enveloppe et file d’attente',
    'insurance': 'Assurance-emploi indexée et aide sociale',
    'bankRegulation': 'Caisse : règles prudentielles',
    'bankruptcy': 'Faillite ordonnée',
    'buildings': 'Bâtiments, construction et hypothèques',
    'jobs': 'Rôles, contrats et négociation salariale',
    'entrepreneurship': 'Entrepreneuriat des citoyens',
    'products': 'Variétés de produits et marques',
    'banking': 'Crédit aux citoyens et banques',
  };

  bool get(String k) {
    switch (k) {
      case 'credit':
        return credit;
      case 'capital':
        return capital;
      case 'rnd':
        return rnd;
      case 'marketing':
        return marketing;
      case 'accounting':
        return accounting;
      case 'health':
        return health;
      case 'education':
        return education;
      case 'publicHealth':
        return publicHealth;
      case 'publicEducation':
        return publicEducation;
      case 'entry':
        return entry;
      case 'dividendTest':
        return dividendTest;
      case 'publicBudget':
        return publicBudget;
      case 'insurance':
        return insurance;
      case 'bankRegulation':
        return bankRegulation;
      case 'bankruptcy':
        return bankruptcy;
      case 'buildings':
        return buildings;
      case 'jobs':
        return jobs;
      case 'entrepreneurship':
        return entrepreneurship;
      case 'products':
        return products;
      case 'banking':
        return banking;
    }
    throw ArgumentError('Module inconnu : $k');
  }

  void set(String k, bool v) {
    switch (k) {
      case 'credit':
        credit = v;
      case 'capital':
        capital = v;
      case 'rnd':
        rnd = v;
      case 'marketing':
        marketing = v;
      case 'accounting':
        accounting = v;
      case 'health':
        health = v;
      case 'education':
        education = v;
      case 'publicHealth':
        publicHealth = v;
      case 'publicEducation':
        publicEducation = v;
      case 'entry':
        entry = v;
      case 'dividendTest':
        dividendTest = v;
      case 'publicBudget':
        publicBudget = v;
      case 'insurance':
        insurance = v;
      case 'bankRegulation':
        bankRegulation = v;
      case 'bankruptcy':
        bankruptcy = v;
      case 'buildings':
        buildings = v;
      case 'jobs':
        jobs = v;
      case 'entrepreneurship':
        entrepreneurship = v;
      case 'products':
        products = v;
      case 'banking':
        banking = v;
      default:
        throw ArgumentError('Module inconnu : $k');
    }
  }

  Modules copy() {
    final m = Modules();
    for (final k in keys) {
      m.set(k, get(k));
    }
    return m;
  }
}

/// Filets de sécurité : des instruments de diagnostic, pas des cache-misère.
/// Chacun se coupe ; chaque déclenchement est compté et journalisé (jour, agent, montant, raison).
class Safeguards {
  bool famine = true; // l'État nourrit qui n'a pas mangé depuis famineDays jours
  int famineDays = 3;
  bool bailout = true; // le propriétaire (ou un racheteur) renfloue une entreprise à court d'argent
  bool shelter = true; // abri d'urgence pour qui est sans logis depuis shelterDays jours
  int shelterDays = 3;
  bool drift = true; // variation quotidienne des prix et salaires plafonnée
  double maxDailyChange = 0.02;
  bool credit = true; // la Caisse refuse les prêts trop lourds ou au-delà de ses fonds propres
  double maxPaymentRatio = 0.35; // paiements de la dette / valeur ajoutée de l'emprunteur
  double minCapitalRatio = 0.115; // fonds propres de la Caisse / prêts (CET1 attendu des grandes banques)

  Safeguards();

  Safeguards.none() {
    for (final k in keys) {
      set(k, false);
    }
  }

  static const List<String> keys = ['famine', 'bailout', 'shelter', 'drift', 'credit'];
  static const Map<String, String> labels = {
    'famine': 'Anti-famine',
    'bailout': 'Renflouement d’entreprise',
    'shelter': 'Plancher de logement',
    'drift': 'Plafond de dérive des prix et salaires',
    'credit': 'Anti-crédit-fou',
  };

  bool get(String k) {
    switch (k) {
      case 'famine':
        return famine;
      case 'bailout':
        return bailout;
      case 'shelter':
        return shelter;
      case 'drift':
        return drift;
      case 'credit':
        return credit;
    }
    throw ArgumentError('Filet inconnu : $k');
  }

  void set(String k, bool v) {
    switch (k) {
      case 'famine':
        famine = v;
      case 'bailout':
        bailout = v;
      case 'shelter':
        shelter = v;
      case 'drift':
        drift = v;
      case 'credit':
        credit = v;
      default:
        throw ArgumentError('Filet inconnu : $k');
    }
  }

  Safeguards copy() {
    final s = Safeguards();
    for (final k in keys) {
      s.set(k, get(k));
    }
    s
      ..famineDays = famineDays
      ..shelterDays = shelterDays
      ..maxDailyChange = maxDailyChange
      ..maxPaymentRatio = maxPaymentRatio
      ..minCapitalRatio = minCapitalRatio;
    return s;
  }
}

/// Un service public gratuit (soins, cours) : son enveloppe et sa file d'attente.
class ServiceStats {
  double envelopeToday = 0; // versé aujourd'hui par l'État
  double wantedToday = 0; // ce que l'enveloppe aurait dû verser
  double envelopeTotal = 0; // net de ce qui est revenu au trésor
  int shortDays = 0; // jours où le trésor n'a pas couvert l'enveloppe en entier
  int servedToday = 0;
  int servedTotal = 0;
  double servedWait = 0; // attente des derniers servis, moyenne lissée (jours)
  int queue = 0; // personnes en file en fin de journée
  double queueAge = 0; // attente moyenne des personnes encore en file (jours)

  /// Attente moyenne : celle des derniers servis, ou celle des personnes en file si elle est plus longue.
  double get wait => servedWait > queueAge ? servedWait : queueAge;
}

/// Un déclenchement de filet.
class NetEvent {
  final int day;
  final String net;
  final String agent;
  final double amount;
  final String reason;
  const NetEvent(this.day, this.net, this.agent, this.amount, this.reason);
}

/// Compteurs des filets : un compteur élevé signale une fuite dans le modèle.
class NetStats {
  final Map<String, int> count = {};
  final Map<String, double> amount = {};
  final Map<String, Map<String, int>> byAgent = {};
  final Map<String, Map<String, int>> causes = {}; // filet → cause → nombre (depuis le début)
  final Map<String, int> today = {};
  final Map<String, Map<String, int>> causesToday = {};
  final List<NetEvent> log = [];

  void add(NetEvent e, String cause) {
    count[e.net] = (count[e.net] ?? 0) + 1;
    amount[e.net] = (amount[e.net] ?? 0) + e.amount;
    final a = byAgent[e.net] ??= {};
    a[e.agent] = (a[e.agent] ?? 0) + 1;
    final all = causes[e.net] ??= {};
    all[cause] = (all[cause] ?? 0) + 1;
    today[e.net] = (today[e.net] ?? 0) + 1;
    final c = causesToday[e.net] ??= {};
    c[cause] = (c[cause] ?? 0) + 1;
    log.add(e);
    if (log.length > 1000) log.removeAt(0);
  }

  int total([String? net]) => net == null ? count.values.fold(0, (a, b) => a + b) : (count[net] ?? 0);

  void clear() {
    count.clear();
    amount.clear();
    byAgent.clear();
    causes.clear();
    today.clear();
    causesToday.clear();
    log.clear();
  }
}

/// Un agent cité par une alerte : entreprise ou citoyen (l'interface ouvre son inspecteur).
class AgentRef {
  final String kind; // firm | citizen
  final int id;
  const AgentRef(this.kind, this.id);
}

/// Une anomalie détectée : quoi, depuis quand, valeur, seuil, agents impliqués.
class Alert {
  final String key; // type, ou type:id de l'entreprise
  final String type;
  final bool critical;
  final int since;
  int? until;
  String what;
  double value;
  double threshold;
  List<String> agents;
  List<AgentRef?> refs; // l'agent de chaque ligne de [agents], s'il y en a un
  final AgentRef? subject; // l'entreprise que l'alerte concerne (alertes par entreprise)
  Alert(this.key, this.type, this.critical, this.since, this.what, this.value, this.threshold, this.agents,
      {List<AgentRef?>? refs, this.subject})
      : refs = refs ?? List<AgentRef?>.filled(agents.length, null);
  bool get active => until == null;
}

/// Un événement du journal complet (outil en ligne de commande, voir trace.dart).
class TraceEvent {
  final int day;
  final String category; // compta | travail | credit | filets | institutions | entrees_sorties | alertes
  final String type;
  final String agent; // citoyen ou entreprise ('' : l'économie entière)
  final int? id; // identifiant de l'agent
  final String rule; // règle déclenchée
  final String cause;
  final double amount; // $ (0 si sans objet)
  final String detail;
  const TraceEvent(this.day, this.category, this.type, this.agent, this.id, this.rule, this.cause, this.amount,
      [this.detail = '']);

  Map<String, Object?> toJson() => {
        'jour': day,
        'categorie': category,
        'type': type,
        'agent': agent,
        'id': id,
        'regle': rule,
        'cause': cause,
        'montant': amount.isFinite ? amount : null,
        if (detail.isNotEmpty) 'detail': detail,
      };
}

/// Flux monétaires du jour qui changent la masse détenue par le public (dépôts).
class DayFlows {
  double loans = 0, repaid = 0, interest = 0, rebates = 0, godPublic = 0, godBank = 0, exports = 0, imports = 0;
  double capitalized = 0, writtenOff = 0;
  // module banking : argent du public versé aux fonds propres d'une banque (capital d'un fondateur), et argent des banques
  // versé au public (intérêts des dépôts, coûts de fonctionnement)
  double bankIn = 0, bankOut = 0;
  void reset() {
    loans = repaid = interest = rebates = godPublic = godBank = exports = imports = capitalized = writtenOff = 0;
    bankIn = bankOut = 0;
  }

  /// Variation des dépôts expliquée par les flux.
  double get explained => loans - repaid - interest + rebates + godPublic + exports - imports + bankOut - bankIn;
}

/// Écarts des invariants comptables (exactement 0 si tout est cohérent).
class Invariants {
  double money = 0; // masse réelle − (départ + god mode + exportations − importations + crédit net)
  double loans = 0; // dette en cours − (prêté + intérêts capitalisés − remboursé − radié)
  double bank = 0; // (réserves + prêts) − (dépôts + fonds propres)
  double flows = 0; // variation des dépôts non expliquée par les flux du jour
  double get worst => [money.abs(), loans.abs(), bank.abs(), flows.abs()].reduce((a, b) => a > b ? a : b);
}

class ScenarioFirm {
  final String type;
  final String name;
  const ScenarioFirm(this.type, this.name);
}

/// Une entreprise de chaque type ; le nombre d'employés est calculé au démarrage.
const List<ScenarioFirm> defaultScenario = [
  ScenarioFirm('ferme', 'Ferme Gagnon'),
  ScenarioFirm('peche', 'Pêcheries de Gaspé'),
  ScenarioFirm('puits', 'Pétroles Anticosti'),
  ScenarioFirm('bucheron', 'Chantier Boréal'),
  ScenarioFirm('mineFer', 'Mine de Fermont'),
  ScenarioFirm('mineOr', 'Mine d’or de Val-d’Or'),
  ScenarioFirm('mineBauxite', 'Bauxite du Nord'),
  ScenarioFirm('mineCuivre', 'Cuivre Murdochville'),
  ScenarioFirm('boucherie', 'Boucherie Roy'),
  ScenarioFirm('boulangerie', 'Boulangerie Côté'),
  ScenarioFirm('raffinerie', 'Raffinerie Saint-Laurent'),
  ScenarioFirm('petrochimie', 'Plastiques Bélanger'),
  ScenarioFirm('bijouterie', 'Bijouterie Morin'),
  ScenarioFirm('cpu', 'Puces Lavoie'),
  ScenarioFirm('fonderie', 'Fonderie Laflamme'),
  ScenarioFirm('aluminerie', 'Aluminerie du Saguenay'),
  ScenarioFirm('electronique', 'Électronique Fortin'),
  ScenarioFirm('ordinateurs', 'Ordinateurs Pelletier'),
  ScenarioFirm('machinerie', 'Machinerie Tremblay'),
  ScenarioFirm('garage', 'Garage Bouchard'),
  ScenarioFirm('ingPetrole', 'Génie pétrolier Gauthier'),
  ScenarioFirm('ingCpu', 'Conception Lévesque'),
  ScenarioFirm('marketing', 'Agence Créa'),
  ScenarioFirm('comptable', 'Comptables Bergeron'),
  ScenarioFirm('restaurant', 'Casse-croûte Ginette'),
  ScenarioFirm('tele', 'Télé-Boréal'),
  ScenarioFirm('hotel', 'Château Simard'),
  ScenarioFirm('tourisme', 'Voyages Caron'),
  ScenarioFirm('hopital', 'Hôpital Sainte-Anne'),
  ScenarioFirm('ecole', 'Cégep du Nord'),
  ScenarioFirm('immobilier', 'Gestion Bédard'),
  ScenarioFirm('divertissement', 'Bar Le Trappeur'),
];

const List<String> firstNames = [
  'Marc', 'Julie', 'Éric', 'Annie', 'Steve', 'Mélanie', 'Patrick', 'Karine', 'Martin', 'Isabelle', 'Sylvain',
  'Nathalie', 'Jean-Guy', 'Chantal', 'Kevin', 'Valérie', 'Dany', 'Josée', 'Mathieu', 'Geneviève', 'Simon',
  'Caroline', 'Luc', 'Émilie', 'Yannick', 'Sophie', 'Jonathan', 'Marie-Ève', 'Guillaume', 'Audrey', 'Pierre-Luc',
  'Catherine', 'Francis', 'Stéphanie', 'Maxime', 'Véronique', 'Olivier', 'Mélissa', 'Réjean', 'Ginette', 'Gilles',
  'Lise', 'Normand', 'Carole', 'Samuel', 'Jessica', 'Alexandre', 'Roxanne',
];
const List<String> lastNames = [
  'Gagnon', 'Tremblay', 'Roy', 'Côté', 'Bouchard', 'Gauthier', 'Morin', 'Lavoie', 'Fortin', 'Gagné', 'Ouellet',
  'Pelletier', 'Bélanger', 'Lévesque', 'Bergeron', 'Leblanc', 'Paquette', 'Girard', 'Simard', 'Boucher', 'Caron',
  'Beaulieu', 'Cloutier', 'Dubé', 'Poirier', 'Fournier', 'Lapointe', 'Leclerc', 'Lefebvre', 'Poulin', 'Thibault',
  'Bédard', 'Lessard', 'Laflamme', 'Rivard', 'Audet', 'Grenier', 'Dion',
];

// ------------------------------------------------------------------ entités

/// Tout ce qui possède de l'argent.
abstract class Account {
  double money;
  Account(this.money);
}

class Citizen extends Account {
  final int id;
  final String name;
  int? employer; // id de l'entreprise
  double skill; // 0 à 3 : la partie entière donne la classe (plafonnée à professionnel)
  final double ambition; // 0 à 1 : envie de se former
  final Map<String, double> sat = {for (final d in desires) d: 1.0};
  int hungerDays = 0;
  bool homeless = false;
  int homelessDays = 0;
  int computerDays = 0; // jours d'usage restants de son ordinateur
  double happiness = 1;
  double income = 0;
  double incomeEma = 0; // revenu net lissé (~10 jours) : base de la consommation
  double spend = 0;
  int daysUnemployed = 0;
  int? careSince; // jour d'inscription dans la file de l'hôpital public (null : pas en file)
  double lastWage = 0; // dernier salaire (assurance-emploi)
  int insuredDays = 0; // jours d'emploi assurable depuis la dernière demande
  int eiDaysLeft = 0; // jours de prestations restants
  double eiBenefit = 0; // prestation quotidienne de la demande en cours
  int? schoolSince; // jour d'inscription dans la file de l'école publique
  int? homeId; // bâtiment dont il est propriétaire-occupant (module buildings) ; null : locataire
  bool wantsToOwn = false; // trait : veut devenir propriétaire (module buildings)
  // emploi (ancienneté tenue dans tous les cas ; rôle, contrat et aplomb ne servent qu'avec le module jobs)
  int hiredDay = 0; // jour d'embauche chez l'employeur actuel (négatif : avant le début de la partie)
  int role = -1; // rang du rôle dans roles[type de l'employeur] ; -1 : aucun
  double wage = 0; // salaire du contrat (brut, par jour) ; après une fin d'emploi, celui du dernier contrat
  double aplomb = 0.5; // trait : aplomb en négociation, de 0 à 1
  // Entrepreneuriat : jours travaillés dans chaque type d'entreprise (connaissance du secteur ; tenu seulement avec le module).
  final Map<String, int> sectorDays = {};
  // Variétés (module products) : par catégorie, les variétés connues et le dernier jour où chacune a été achetée ou revue ;
  // la dernière achetée (habitude, bouche-à-oreille).
  final Map<String, Map<int, int>> known = {};
  final Map<String, int> lastChoice = {};
  // Crédit (module banking) : prêts personnels, carte (solde, limite, intérêts courus, jour d'ouverture), arriérés
  // (montant en retard et jour du premier retard), retards récents, faillites, crédit fermé jusqu'au jour…, banque.
  final List<PersonalLoan> loans = [];
  double card = 0;
  double cardLimit = 0;
  double cardInterest = 0;
  int cardOpened = -1;
  double arrears = 0;
  int? arrearsSince;
  int latePayments = 0;
  int lastLate = -1000;
  int bankruptcies = 0;
  int creditBanUntil = 0;
  String lastBankruptcy = '';
  int bankId = 0;
  double get consumerDebt {
    var d = card;
    for (final l in loans) {
      d += l.balance;
    }
    return d;
  }
  Citizen(this.id, this.name, super.money, this.skill, this.ambition);

  /// 0 manœuvre, 1 technicien, 2 professionnel.
  int get level => skill >= 2 ? 2 : (skill >= 1 ? 1 : 0);
  double get health => sat['sante']!;
}

/// Une banque (module banking, à partir de deux). Ses comptes sont une répartition du bilan consolidé du système bancaire
/// (`Sim.bank`) : toute la monnaie passe par ce compte unique, si bien que les invariants consolidés restent exacts ; chaque
/// banque tient ses fonds propres (la Caisse populaire, banque 0, a le reste), ses prêts et ses dépôts se lisent dans les
/// comptes de ses clients, et ses réserves sont le solde de son bilan.
class Bank {
  final int id;
  String name;
  int? ownerId; // fondateur ; null : actionnaire institutionnel (dividendes redistribués aux citoyens)
  double equity = 0; // fonds propres (banque 0 : calculés comme le reste du bilan consolidé)
  double capital = 0; // capital de départ, jamais distribué
  double interbank = 0; // > 0 : prêté aux autres banques ; < 0 : emprunté
  double loanSpread = 0; // marge sur le taux de base des prêts
  double cardSpread = 0; // marge sur le taux de base de la carte
  double depositRate = 0; // taux annuel versé sur les dépôts
  int founded = 0;
  bool alive = true;
  int? closed;
  String state = 'saine';
  int lossDays = 0; // jours consécutifs de profit lissé négatif
  double profitEma = 0;
  double lossEma = 0; // radiations lissées (~100 jours), par jour
  double incomeToday = 0, lossToday = 0, costToday = 0;
  double incomeEma = 0, costEma = 0; // intérêts reçus et coûts (intérêts des dépôts, fonctionnement), lissés, par jour
  // chiffres du jour, pour les règles et l'interface (non sérialisés : ils se recalculent)
  double equityNow = 0, deposits = 0, reserves = 0, firmLoans = 0, consumerLoans = 0, riskLoans = 0;
  int clients = 0;
  double get loans => firmLoans + consumerLoans;
  double get capitalRatio => riskLoans > 0 ? equityNow / riskLoans : double.infinity;
  Bank(this.id, this.name);
}

/// Prêt personnel à terme : mensualités constantes (amortissement), tous les 30 jours depuis l'octroi.
class PersonalLoan {
  final int bankId;
  double balance;
  final double rate; // annuel
  final int months;
  final double payment; // mensualité
  final int start;
  final String reason;
  PersonalLoan(this.bankId, this.balance, this.rate, this.months, this.payment, this.start, this.reason);
}

class StateAccount extends Account {
  double taxes = 0;
  double paid = 0;
  double taxesToday = 0;
  double paidToday = 0;
  double healthPaid = 0;
  double educationPaid = 0;
  // assurance-emploi et aide sociale (I3) : compte des opérations, comme le compte notionnel canadien
  double eiPremiums = 0; // cotisations perçues (total)
  double eiPaid = 0; // prestations versées (total)
  double assistPaid = 0; // aide sociale versée (total)
  int eiClaimants = 0; // prestataires aujourd'hui
  int assistRecipients = 0; // bénéficiaires de l'aide sociale aujourd'hui
  double benefitCut = 1; // part des prestations dues versée aujourd'hui (1 : toutes ; moins : trésor insuffisant)
  StateAccount(super.money);
}

/// La Caisse populaire : prête aux entreprises en créant de la monnaie, ristourne ses intérêts aux membres.
/// Bilan : réserves + prêts = dépôts + fonds propres. Les réserves sont la monnaie « extérieure »
/// (départ, god mode, commerce) ; les dépôts, l'argent du public (citoyens, entreprises, État).
class BankAccount extends Account {
  double lent = 0; // total prêté depuis le début
  double lentMachines = 0; // dont prêts pour acheter des machines
  double lentWorking = 0; // dont fonds de roulement
  double repaid = 0; // capital remboursé (monnaie détruite)
  double interest = 0; // intérêts encaissés
  double capitalized = 0; // intérêts impayés ajoutés à la dette
  double writtenOff = 0; // créances radiées
  double rebates = 0; // ristournes versées
  double reserves = 0; // tenu par les flux : départ + god mode + exportations − importations
  double equity = 0; // tenu par les flux : intérêts + intérêts capitalisés − radiations − ristournes + god mode
  double capital = 0; // parts sociales de départ, jamais ristournées
  int refusals = 0; // prêts refusés par les règles prudentielles (ou le filet)
  BankAccount(super.money);
}

class FirmPoint {
  final double money;
  final int workers;
  final double price;
  final double sold;
  final double profit;
  final double machines;
  final double debt;
  const FirmPoint(this.money, this.workers, this.price, this.sold, this.profit, this.machines, this.debt);
}

class Firm extends Account {
  final int id;
  final String type;
  String name;
  final Map<String, double> inputs;
  final Map<String, double> outputs;
  double rate; // lots par employé et par jour ; réduit au départ si la demande n'occupe pas un employé (échelle minimale)
  double? capacity;
  double prodMult = 1;
  int? ownerId;
  double wage;
  final List<int> workers = [];
  int vacancies = 0;
  int unfilledDays = 0;
  final Map<String, double> inv = {};
  final Map<String, double> price = {};
  final Map<String, double> markup = {};
  final Map<String, double> demandEma = {};
  Map<String, double> sold = {};
  Map<String, double> produced = {};
  final Map<String, double> unmetShare = {};
  Map<String, double> unitCostCache = {};
  bool lockPrice = false;
  bool lockWage = false;
  double x;
  double y;
  double revenue = 0;
  double costs = 0;
  double profitEma = 0;
  double retained = 0; // bénéfices non répartis : bénéfices cumulés moins dividendes versés (le capital apporté n'en fait pas partie)
  double revenueEma = 0;
  double inputSpendEma = 0;
  double inputSpend = 0;
  double wagesPaid = 0;
  double dividends = 0;
  int lastDistressLog = -99;
  int lastRecapLog = -99;
  // Entrepreneuriat : le citoyen qui a fondé l'entreprise, le jour, et le capital de départ (épargne + prêt).
  int? founderId;
  int foundedDay = 0;
  double startCapital = 0;
  // Variétés (module products) : la variété de l'entreprise ; machines installées (gain et durabilité moyens, 0 : modèle
  // standard d'avant le module) ; fabricants connus et fournisseur habituel.
  int? productId;
  double machineGain = 0;
  double machineLife = 0;
  final List<int> knownMakers = [];
  int? supplier;
  int bankId = 0; // module banking : la banque de l'entreprise (0 : la Caisse populaire)
  double lastBatches = 0;
  double outputEma = 0; // production lissée (~20 jours) : base du coût du travail réellement payé
  double effWorkers = 0;
  bool inputLimited = false;
  int desired = 0;
  double urgency = 0;
  int prevWorkers = 0;
  // capital et technologie
  double machines = 0;
  int techLevel = 1;
  double rndProgress = 0;
  double maintCover = 1; // couverture de l'entretien (moyenne lissée)
  double maintToday = 1;
  double adminCover = 1; // couverture comptable (moyenne lissée)
  double brand = 0; // notoriété accumulée par la publicité
  double overhead = 0; // services aux entreprises achetés aujourd'hui
  double overheadEma = 0;
  int lastInvest = -99;
  // dette
  double debt = 0;
  double workingDebt = 0; // part de la dette prêtée en fonds de roulement (pour le suivi des pertes)
  double interestToday = 0;
  int missedPayments = 0;
  int idleDays = 0; // jours consécutifs sans employé
  int creditBanUntil = -1;
  String lastLoss = ''; // raison de la dernière fin d'emploi (mesure des causes de fermeture)
  double carry = 0; // bâtiments : coût quotidien du parc (intérêts hypothécaires + provision d'usure), pour le loyer
  double reinvest = 0; // bâtiments : produit de ventes de logements à garder pour reconstruire (exclu des dividendes)
  // Module jobs : salaire affiché pour la qualification du gabarit (les rôles s'en déduisent, voir roleRel) ; [wage]
  // est alors le salaire moyen des contrats de l'équipe (sans employé : l'offre du prochain poste), le coût d'un
  // employé dans toutes les règles qui comptent en jours de salaires.
  double offer;
  final List<Talk> talks = []; // dernières négociations (affichage)
  final List<FirmPoint> hist = [];

  Firm(this.id, this.type, this.name, this.inputs, this.outputs, this.rate, this.capacity, double money, this.ownerId,
      this.wage, this.x, this.y)
      : offer = wage,
        super(money);

  /// Premier extrant : celui qui pilote la demande.
  String get g0 => outputs.keys.first;
  Template get template => templates[type]!;
}

/// Une négociation salariale (module jobs), gardée pour l'affichage.
class Talk {
  final int day;
  final int citizen;
  final String name;
  final int role;
  final String kind; // embauche | refus | contre_offre | depart | promotion | revision | baisse
  final double wage; // salaire convenu (ou dernier salaire demandé, pour un refus)
  final double reservation; // salaire de réserve du candidat
  final double offer; // salaire offert pour le rôle
  final double cap; // plafond de l'employeur
  const Talk(this.day, this.citizen, this.name, this.role, this.kind, this.wage, this.reservation, this.offer, this.cap);
}

/// Compteurs du marché du travail (module jobs), depuis le début et pour le jour.
class LabourStats {
  static const List<String> kinds = [
    'embauche', 'refus', 'contre_offre', 'depart', 'promotion', 'revision', 'baisse',
  ];
  static const Map<String, String> labels = {
    'embauche': 'Embauches négociées',
    'refus': 'Offres refusées',
    'contre_offre': 'Contre-offres (employé retenu)',
    'depart': 'Départs vers un concurrent',
    'promotion': 'Promotions internes',
    'revision': 'Renouvellements à la hausse',
    'baisse': 'Renouvellements à la baisse',
  };
  final Map<String, int> total = {for (final k in kinds) k: 0};
  final Map<String, int> today = {for (final k in kinds) k: 0};
  double premium = 0; // somme des écarts (salaire convenu ÷ offre − 1) des embauches, pour la moyenne

  void add(String kind) {
    total[kind] = total[kind]! + 1;
    today[kind] = today[kind]! + 1;
  }

  void newDay() {
    for (final k in kinds) {
      today[k] = 0;
    }
  }

  void clear() {
    newDay();
    for (final k in kinds) {
      total[k] = 0;
    }
    premium = 0;
  }
}

class HistPoint {
  final int day;
  final double mH, mF, mE, mB, total, unemp, wage, gdp, gini, need;
  final double happiness, debt, machines, tech, credit, cpi;
  final int hungry, homeless, pop;
  final Map<String, double> prices;
  final Map<String, double> sat; // satisfaction moyenne par désir
  final List<int> classes; // effectifs par classe de qualification
  const HistPoint({
    required this.day,
    required this.mH,
    required this.mF,
    required this.mE,
    required this.mB,
    required this.total,
    required this.unemp,
    required this.wage,
    required this.gdp,
    required this.gini,
    required this.need,
    required this.happiness,
    required this.debt,
    required this.machines,
    required this.tech,
    required this.credit,
    required this.cpi,
    required this.hungry,
    required this.homeless,
    required this.pop,
    required this.prices,
    required this.sat,
    required this.classes,
  });
}

class SimEvent {
  final int day;
  final String type; // god | warn | short | info | alert | net
  final String text;
  const SimEvent(this.day, this.type, this.text);
}

class FlowEdge {
  final String from;
  final String to;
  final String good; // clé de bien, ou '$salaires', '$impôts'…
  double qty;
  double value;
  FlowEdge(this.from, this.to, this.good, this.qty, this.value);
  bool get isMoney => good.startsWith('\$');
}

class MarketStat {
  double qty = 0;
  double value = 0;
}

class BuyResult {
  final double qty;
  final double spent;
  const BuyResult(this.qty, this.spent);
}

// ------------------------------------------------------------------ bâtiments et hypothèques (module « buildings »)

/// Un bâtiment : un logement d'une unité, en chantier (modules posés < Params.dwellingModules) ou terminé.
class Building {
  final int id;
  int ownerKind; // 0 entreprise (bailleur), 1 citoyen (propriétaire-occupant), 2 liquidation (saisie ou succession)
  int? ownerId; // identifiant de l'entreprise ou du citoyen
  int? payee; // en liquidation : le citoyen qui touchera le surplus de la vente (null : l'État)
  int modules = 0; // modules de construction posés
  bool done = false; // terminé : habitable (si son état le permet) et vendable
  double cond = 1; // état de 0 (ruine) à 1 (neuf)
  double basis = 0; // ce que le propriétaire actuel a payé (achat) ou dépensé (construction)
  int? mortgageId;
  int? listedDay; // jour de mise en vente (null : pas en vente)
  final int builtDay;
  Building(this.id, this.ownerKind, this.ownerId, this.builtDay);

  /// Sous ce seuil d'état, le logement est inhabitable.
  static const double minCond = 0.3;
  bool get habitable => done && cond >= minCond;
}

/// Une hypothèque de la Caisse : prêt garanti par un bâtiment. Le prêt crée de la monnaie, chaque remboursement de capital
/// en détruit. Tant que le bâtiment est en chantier, seuls les intérêts sont dus.
class Mortgage {
  final int id;
  final int buildingId;
  int borrowerKind; // 0 entreprise, 1 citoyen, 2 plus de débiteur (bâtiment saisi ou débiteur disparu)
  int? borrowerId;
  double principal; // capital dû (intérêts impayés capitalisés compris)
  final double rate; // taux annuel fixé à l'octroi
  int termLeft; // jours d'amortissement restants
  double payment = 0; // versement quotidien (intérêts + capital), fixé à l'octroi puis à chaque tirage
  int missed = 0; // jours consécutifs de versement manqué
  final int since;
  Mortgage(this.id, this.buildingId, this.borrowerKind, this.borrowerId, this.principal, this.rate, this.termLeft, this.since);
}

/// Cible d'une injection ou d'un retrait d'argent.
class Target {
  final String kind; // allCitizens | allFirms | unemployed | state | bank | citizen | firm
  final int? id;
  const Target(this.kind, [this.id]);
}
