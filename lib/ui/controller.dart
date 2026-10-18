import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import '../engine/model.dart';
import '../engine/sim.dart';
import 'housing.dart';
import 'layout.dart';

/// Calque « argent » : tous les flux monétaires, même si leur affichage est coupé.
const String kMoneyLayer = r'$';

/// Ce qui est sélectionné dans le graphe.
class Selection {
  final String kind; // M | E | B | X | firm | citizen | building
  final int? id;
  const Selection(this.kind, [this.id]);

  @override
  bool operator ==(Object other) => other is Selection && other.kind == kind && other.id == id;
  @override
  int get hashCode => Object.hash(kind, id);
}

/// Onglets du panneau latéral.
class Tabs {
  static const inspector = 0;
  static const diagnostic = 1;
  static const god = 2;
  static const economy = 3;
  static const journal = 4;
  static const model = 5;
  static const housing = 6;
  static const labels = ['Inspecteur', 'Diagnostic', 'God mode', 'Économie', 'Journal', 'Modèle', 'Immobilier'];
}

/// Pilote la simulation : boucle de temps, vitesse, sélection, notifications d'interface.
class SimController extends ChangeNotifier {
  Sim sim;
  bool playing = true;
  double speed = 4; // jours par seconde
  Selection selection = const Selection('M');
  bool showMoneyFlows = false;
  bool showServices = false; // flux de services aux entreprises (comptabilité, entretien, publicité, machines)
  bool showParticles = true; // particules animées sur les flux
  bool bundleEdges = true; // flux regroupés en troncs entre colonnes éloignées
  bool panelOpen = true;
  int panelTab = Tabs.inspector;

  /// Calque du graphe : un bien (ou [kMoneyLayer]) mis en avant, les autres flux estompés ; null = tous.
  String? layer;

  /// Relevé quotidien du marché immobilier (courbes de l'onglet Immobilier) ; vide si le module est coupé.
  final HousingLog housing = HousingLog();

  /// Augmente à chaque notification : le graphe garde son dessin tant qu'elle ne change pas.
  int rev = 0;

  /// Vitesse réellement tenue (jours par seconde) : plus basse que [speed] si l'appareil ne suit pas.
  double realSpeed = 0;

  late final Ticker _ticker;
  Duration _last = Duration.zero;
  double _acc = 0;
  double _sinceNotify = 0;
  int _daysSinceNotify = 0;

  /// Temps de calcul accordé à la simulation par image, pour que l'interface reste fluide.
  static const int _budgetUs = 10000;

  /// L'interface lance ses parties avec les rôles, contrats et négociation salariale, l'entrepreneuriat des citoyens et les
  /// variétés de produits (modules jobs, entrepreneurship et products, coupés par défaut dans le moteur et le protocole).
  SimController({int seed = 42})
      : sim = Sim(
            seed: seed,
            modules: Modules()
              ..jobs = true
              ..entrepreneurship = true
              ..products = true) {
    autoLayout(sim);
  }

  void attach(TickerProvider vsync) {
    _ticker = vsync.createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final dt = _last == Duration.zero ? 0.0 : (elapsed - _last).inMicroseconds / 1e6;
    _last = elapsed;
    if (playing) {
      _acc += (dt > 0.25 ? 0.25 : dt) * speed;
      final sw = Stopwatch()..start();
      var n = 0;
      while (_acc >= 1 && n < 120 && sw.elapsedMicroseconds < _budgetUs) {
        sim.step();
        housing.sample(sim);
        _acc -= 1;
        n++;
      }
      // au plus un quart de seconde de retard : au-delà, la vitesse demandée n'est pas tenue
      final cap = speed * 0.25 < 1 ? 1.0 : speed * 0.25;
      if (_acc > cap) _acc = cap;
      _daysSinceNotify += n;
      _sinceNotify += dt;
      // l'interface suit toutes les 0,12 s de temps réel, pas à chaque jour calculé
      if (_sinceNotify >= 0.12) {
        final r = _daysSinceNotify / _sinceNotify;
        realSpeed = realSpeed == 0 ? r : realSpeed * 0.7 + r * 0.3;
        final changed = _daysSinceNotify > 0;
        _sinceNotify = 0;
        _daysSinceNotify = 0;
        if (changed) notifyListeners();
      }
    }
  }

  @override
  void notifyListeners() {
    rev++;
    super.notifyListeners();
  }

  /// À appeler après toute action de l'utilisateur qui change l'état de la simulation.
  void touch() => notifyListeners();

  void togglePlay() {
    playing = !playing;
    realSpeed = 0;
    notifyListeners();
  }

  void stepOnce() {
    playing = false;
    sim.step();
    housing.sample(sim);
    notifyListeners();
  }

  void setSpeed(double s) {
    speed = s;
    realSpeed = 0;
    playing = true;
    notifyListeners();
  }

  void select(Selection s) {
    selection = s;
    panelTab = Tabs.inspector;
    panelOpen = true;
    notifyListeners();
  }

  void setTab(int t) {
    panelTab = t;
    panelOpen = true;
    notifyListeners();
  }

  void togglePanel() {
    panelOpen = !panelOpen;
    notifyListeners();
  }

  void toggleMoneyFlows(bool v) {
    showMoneyFlows = v;
    notifyListeners();
  }

  void toggleServices() {
    showServices = !showServices;
    notifyListeners();
  }

  void toggleParticles() {
    showParticles = !showParticles;
    notifyListeners();
  }

  void toggleBundle() {
    bundleEdges = !bundleEdges;
    notifyListeners();
  }

  /// Met en avant un bien (ou l'argent) dans le graphe ; le même choix une seconde fois revient à tous les flux.
  void setLayer(String? l) {
    layer = layer == l ? null : l;
    notifyListeners();
  }

  /// Nouvelle partie : les modules et les filets en cours sont conservés.
  void newGame(int seed, {Params? params}) {
    realSpeed = 0;
    sim = Sim(seed: seed, params: params, modules: sim.modules.copy(), safeguards: sim.safeguards.copy());
    housing.clear();
    autoLayout(sim);
    selection = const Selection('M');
    _acc = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
