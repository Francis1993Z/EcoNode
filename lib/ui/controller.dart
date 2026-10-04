import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import '../engine/model.dart';
import '../engine/sim.dart';
import 'layout.dart';

/// Ce qui est sélectionné dans le graphe.
class Selection {
  final String kind; // M | E | B | X | firm | citizen
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
  static const labels = ['Inspecteur', 'Diagnostic', 'God mode', 'Économie', 'Journal', 'Modèle'];
}

/// Pilote la simulation : boucle de temps, vitesse, sélection, notifications d'interface.
class SimController extends ChangeNotifier {
  Sim sim;
  bool playing = true;
  double speed = 4; // jours par seconde
  Selection selection = const Selection('M');
  bool showMoneyFlows = false;
  bool showServices = false; // flux de services aux entreprises (comptabilité, entretien, publicité, machines)
  bool panelOpen = true;
  int panelTab = Tabs.inspector;

  late final Ticker _ticker;
  Duration _last = Duration.zero;
  double _acc = 0;
  double _sinceNotify = 0;

  SimController({int seed = 42}) : sim = Sim(seed: seed) {
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
      var n = 0;
      while (_acc >= 1 && n < 120) {
        sim.step();
        _acc -= 1;
        n++;
      }
      if (n > 0) {
        _sinceNotify += dt;
        if (_sinceNotify >= 0.12) {
          _sinceNotify = 0;
          notifyListeners();
        }
      }
    }
  }

  /// À appeler après toute action de l'utilisateur qui change l'état de la simulation.
  void touch() => notifyListeners();

  void togglePlay() {
    playing = !playing;
    notifyListeners();
  }

  void stepOnce() {
    playing = false;
    sim.step();
    notifyListeners();
  }

  void setSpeed(double s) {
    speed = s;
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

  /// Nouvelle partie : les modules et les filets en cours sont conservés.
  void newGame(int seed, {Params? params}) {
    sim = Sim(seed: seed, params: params, modules: sim.modules.copy(), safeguards: sim.safeguards.copy());
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
