// Données du modèle : biens, recettes, paramètres, entités.
// Port Dart de engine.js (ÉcoNodes). Aucune dépendance à Flutter.

const double eps = 1e-9;

class Good {
  final String label;
  final String unit;
  final bool perish;
  final double guess;
  final String sector; // primaire | transfo | conso
  const Good(this.label, this.unit, this.perish, this.guess, this.sector);
}

// L'ordre d'insertion compte : il reproduit celui de la version JS.
const Map<String, Good> goods = {
  'viande': Good('Viande', 'kg', false, 60, 'primaire'),
  'cuir': Good('Cuir', 'peau', false, 110, 'primaire'),
  'bois': Good('Bois', 'm³', false, 40, 'primaire'),
  'minerai': Good('Minerai', 't', false, 80, 'primaire'),
  'planches': Good('Planches', 'paquet', false, 180, 'transfo'),
  'acier': Good('Acier', 't', false, 400, 'transfo'),
  'boulons': Good('Boulons', 'boîte', false, 130, 'transfo'),
  'repas': Good('Repas', 'repas', false, 75, 'conso'),
  'souliers': Good('Souliers', 'paire', false, 250, 'conso'),
  'logement': Good('Logement', 'nuitée', true, 55, 'conso'),
  'loisirs': Good('Loisirs', 'sortie', true, 22, 'conso'),
};

/// Biens finaux achetés directement par les ménages.
const List<String> finalGoods = ['repas', 'logement', 'souliers', 'loisirs'];

class Template {
  final String label;
  final String code;
  final String sector;
  final Map<String, double> inputs;
  final Map<String, double> outputs;
  final double rate; // lots par employé par jour
  final double? capacity; // lots/jour max
  const Template(this.label, this.code, this.sector, this.inputs, this.outputs, this.rate, [this.capacity]);
}

const Map<String, Template> templates = {
  'ferme': Template('Ferme', 'FE', 'primaire', {}, {'viande': 4, 'cuir': 0.3}, 1),
  'bucheron': Template('Bûcheron', 'BU', 'primaire', {}, {'bois': 5}, 1),
  'mine': Template('Mine', 'MI', 'primaire', {}, {'minerai': 2.5}, 1),
  'scierie': Template('Scierie', 'SC', 'transfo', {'bois': 2}, {'planches': 1}, 2.5),
  'acierie': Template('Aciérie', 'AC', 'transfo', {'minerai': 2}, {'acier': 1}, 1),
  'boulonnerie': Template('Boulonnerie', 'BO', 'transfo', {'acier': 0.2}, {'boulons': 1}, 5),
  'restaurant': Template('Restaurant', 'RE', 'conso', {'viande': 0.5}, {'repas': 1}, 6),
  'cordonnerie': Template('Cordonnerie', 'CO', 'conso', {'cuir': 1}, {'souliers': 1}, 1.5),
  'immobilier': Template('Immobilier', 'IM', 'conso', {'planches': 0.1, 'boulons': 0.1}, {'logement': 1}, 16, 85),
  'divertissement': Template('Divertissement', 'DI', 'conso', {}, {'loisirs': 1}, 8),
};

class Params {
  int population = 80;
  double startWallet = 3000;
  double startWage = 150;
  double markup = 1.15;
  double propensity = 0.05;
  double bufferDays = 12;
  int shoeLife = 30;
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
  bool recapitalize = true;
}

class ScenarioFirm {
  final String type;
  final String name;
  final int workers;
  final double x;
  final double y;
  const ScenarioFirm(this.type, this.name, this.workers, this.x, this.y);
}

const List<ScenarioFirm> defaultScenario = [
  ScenarioFirm('ferme', 'Ferme Gagnon', 14, 40, 30),
  ScenarioFirm('bucheron', 'Chantier Boréal', 3, 40, 330),
  ScenarioFirm('mine', 'Mine du Nord', 2, 40, 570),
  ScenarioFirm('scierie', 'Scierie Tremblay', 3, 330, 330),
  ScenarioFirm('acierie', 'Aciérie Laflamme', 2, 330, 570),
  ScenarioFirm('restaurant', 'Casse-croûte Ginette', 18, 620, 30),
  ScenarioFirm('cordonnerie', 'Cordonnerie Roy', 3, 620, 250),
  ScenarioFirm('boulonnerie', 'Boulonnerie Côté', 2, 620, 570),
  ScenarioFirm('immobilier', 'Gestion Bédard', 5, 910, 400),
  ScenarioFirm('divertissement', 'Bar Le Trappeur', 24, 910, 640),
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
  int hunger = 0;
  bool homeless = false;
  int shoes;
  double income = 0;
  double spend = 0;
  int daysUnemployed = 0;
  Citizen(this.id, this.name, double money, this.shoes) : super(money);
}

class StateAccount extends Account {
  double taxes = 0;
  double paid = 0;
  double taxesToday = 0;
  double paidToday = 0;
  StateAccount(double money) : super(money);
}

class FirmPoint {
  final double money;
  final int workers;
  final double price;
  final double sold;
  final double profit;
  const FirmPoint(this.money, this.workers, this.price, this.sold, this.profit);
}

class Firm extends Account {
  final int id;
  final String type;
  String name;
  final Map<String, double> inputs;
  final Map<String, double> outputs;
  final double rate;
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
  double inputSpendEma = 0;
  double inputSpend = 0;
  double wagesPaid = 0;
  double dividends = 0;
  int lastDistressLog = -99;
  int lastRecapLog = -99;
  double lastBatches = 0;
  double effWorkers = 0;
  bool inputLimited = false;
  int desired = 0;
  double urgency = 0;
  int prevWorkers = 0;
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
  final double mH, mF, mE, total, unemp, wage, gdp, gini, need;
  final int hungry, homeless, pop;
  final Map<String, double> prices;
  const HistPoint({
    required this.day,
    required this.mH,
    required this.mF,
    required this.mE,
    required this.total,
    required this.unemp,
    required this.wage,
    required this.gdp,
    required this.gini,
    required this.need,
    required this.hungry,
    required this.homeless,
    required this.pop,
    required this.prices,
  });
}

class SimEvent {
  final int day;
  final String type; // god | warn | short | info
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
  final String kind; // allCitizens | allFirms | unemployed | state | citizen | firm
  final int? id;
  const Target(this.kind, [this.id]);
}
