part of 'sim.dart';

// Douane : prix du commerce international en vagues et droit de douane. Voir MODELE.md § 6.21.
//
// Sans Params.tradeWaves, le prix d'import d'un bien est worldPrice × importMarkup et son prix d'export worldPrice ×
// exportDiscount, comme avant. Avec les vagues, les deux sont multipliés par un facteur propre au bien :
//   facteur = (1 + amplitude × sin(2π (jour / période + phase))) × (1 + bruit),
// où phase, période (± 30 %) et amplitude (± 30 %) sont tirées une fois de la graine, et le bruit suit un AR(1) quotidien
// (bruit ← 0,97 · bruit + tradeNoise · u, u uniforme dans [−1, 1], borné à ±0,6). Le facteur est borné à [0,25 ; 4].
// Le droit de douane (Params.tariff) majore ensuite le prix d'import ; il ne touche pas les exportations.
//
// Pas de math.sin (résultats différents entre la VM et le web) : approximation de Bhaskara, en opérations élémentaires.

extension Douane on Sim {
  /// Facteur du jour des prix mondiaux d'un bien (1 sans vagues).
  double tradeFactorOf(String good) => params.tradeWaves ? (tradeFactor[good] ?? 1.0) : 1.0;

  /// Prix d'une unité importée, droit de douane compris.
  double importPrice(String good) {
    var v = worldPrice[good]! * params.importMarkup;
    if (params.tradeWaves) v *= tradeFactor[good] ?? 1.0;
    if (params.tariff != 0) v *= 1 + params.tariff;
    return v;
  }

  /// Prix reçu pour une unité exportée.
  double exportPrice(String good) {
    var v = worldPrice[good]! * params.exportDiscount;
    if (params.tradeWaves) v *= tradeFactor[good] ?? 1.0;
    return v;
  }

  /// Caractéristiques fixes de la vague d'un bien, tirées de la graine : (phase en tours, période en jours, amplitude).
  (double, double, double) tradeWaveOf(int gi) {
    final h = hash32(hash32(seed, 0x0D0A4E), gi);
    final phase = Mulberry32.first(h);
    final period = params.tradeWavePeriod * (0.7 + 0.6 * Mulberry32.first(hash32(h, 1)));
    final amp = params.tradeWaveAmp * (0.7 + 0.6 * Mulberry32.first(hash32(h, 2)));
    return (phase, math.max(period, 1.0), amp);
  }

  void _updateTradeFactors() {
    final p = params;
    var gi = 0;
    for (final g in goods.keys) {
      gi++;
      final (phase, period, amp) = tradeWaveOf(gi);
      var t = day / period + phase;
      t -= t.floorToDouble();
      var n = tradeNoiseState[g] ?? 0.0;
      n = 0.97 * n + p.tradeNoise * (2 * draw(Flux.commerce, gi) - 1);
      n = n.clamp(-0.6, 0.6).toDouble();
      tradeNoiseState[g] = n;
      tradeFactor[g] = ((1 + amp * _sinTurns(t)) * (1 + n)).clamp(0.25, 4.0).toDouble();
    }
  }
}

/// sin(2π t) pour t dans [0, 1[, par l'approximation de Bhaskara (erreur < 0,002).
double _sinTurns(double t) {
  const pi = 3.141592653589793;
  final neg = t >= 0.5;
  final x = (neg ? t - 0.5 : t) * 2 * pi; // dans [0, π[
  final a = x * (pi - x);
  final s = 16 * a / (5 * pi * pi - 4 * a);
  return neg ? -s : s;
}
