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
  const Good(this.label, this.unit, this.perish, this.guess, this.sector);
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
};

/// Le type d'entreprise qui produit chaque bien.
final Map<String, String> producerOf = {
  for (final e in templates.entries)
    for (final g in e.value.outputs.keys) g: e.key,
};

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

  Modules();

  /// Tous les modules coupés : chaînes de production, emploi, nourriture, logement, loisirs.
  Modules.none() {
    for (final k in keys) {
      set(k, false);
    }
  }

  static const List<String> keys = [
    'credit', 'capital', 'rnd', 'marketing', 'accounting', 'health', 'education', 'publicHealth', 'publicEducation',
    'entry',
  ];
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
  Alert(this.key, this.type, this.critical, this.since, this.what, this.value, this.threshold, this.agents);
  bool get active => until == null;
}

/// Flux monétaires du jour qui changent la masse détenue par le public (dépôts).
class DayFlows {
  double loans = 0, repaid = 0, interest = 0, rebates = 0, godPublic = 0, godBank = 0, exports = 0, imports = 0;
  double capitalized = 0, writtenOff = 0;
  void reset() {
    loans = repaid = interest = rebates = godPublic = godBank = exports = imports = capitalized = writtenOff = 0;
  }

  /// Variation des dépôts expliquée par les flux.
  double get explained => loans - repaid - interest + rebates + godPublic + exports - imports;
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
  Citizen(this.id, this.name, super.money, this.skill, this.ambition);

  /// 0 manœuvre, 1 technicien, 2 professionnel.
  int get level => skill >= 2 ? 2 : (skill >= 1 ? 1 : 0);
  double get health => sat['sante']!;
}

class StateAccount extends Account {
  double taxes = 0;
  double paid = 0;
  double taxesToday = 0;
  double paidToday = 0;
  double healthPaid = 0;
  double educationPaid = 0;
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
  double revenueEma = 0;
  double inputSpendEma = 0;
  double inputSpend = 0;
  double wagesPaid = 0;
  double dividends = 0;
  int lastDistressLog = -99;
  int lastRecapLog = -99;
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
  final List<FirmPoint> hist = [];

  Firm(this.id, this.type, this.name, this.inputs, this.outputs, this.rate, this.capacity, double money, this.ownerId,
      this.wage, this.x, this.y)
      : super(money);

  /// Premier extrant : celui qui pilote la demande.
  String get g0 => outputs.keys.first;
  Template get template => templates[type]!;
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

/// Cible d'une injection ou d'un retrait d'argent.
class Target {
  final String kind; // allCitizens | allFirms | unemployed | state | bank | citizen | firm
  final int? id;
  const Target(this.kind, [this.id]);
}
