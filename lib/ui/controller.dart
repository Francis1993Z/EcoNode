import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import '../engine/model.dart';
import '../engine/sim.dart';

/// Ce qui est sélectionné dans le graphe.
class Selection {
  final String kind; // M | E | X | firm | citizen
  final int? id;
  const Selection(this.kind, [this.id]);

  @override
  bool operator ==(Object other) => other is Selection && other.kind == kind && other.id == id;
  @override
  int get hashCode => Object.hash(kind, id);
}

/// Pilote la simulation : boucle de temps, vitesse, sélection, notifications d'interface.
class SimController extends ChangeNotifier {
  Sim sim;
  bool playing = true;
  double speed = 4; // jours par seconde
  Selection selection = const Selection('M');
  bool showMoneyFlows = false;
  bool panelOpen = true;
  int panelTab = 0;

  late final Ticker _ticker;
  Duration _last = Duration.zero;
  double _acc = 0;
  double _sinceNotify = 0;

  SimController({int seed = 42}) : sim = Sim(seed: seed);

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
    panelTab = 0;
    panelOpen = true;
    notifyListeners();
  }

  void setTab(int t) {
    panelTab = t;
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

  void newGame(int seed, {Params? params}) {
    sim = Sim(seed: seed, params: params);
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
