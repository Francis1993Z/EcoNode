part of 'sim.dart';

// Douane : prix du commerce international en vagues et droit de douane. Voir MODELE.md § 6.21.
//
// Sans Params.tradeWaves, le prix d'import d'un bien est worldPrice × importMarkup et son prix d'export worldPrice ×
// exportDiscount, comme avant. Avec les vagues, les deux sont multipliés par un facteur propre au bien :
//   facteur = (1 + amplitude × sin(2π (jour / période + phase))) × (1 + bruit),
// où phase, période (± 30 %) et amplitude (± 30 %) sont tirées une fois de la graine, et le bruit suit un AR(1) quotidien
// (bruit ← 0,97 · bruit + tradeNoise · u, u uniforme dans [−1, 1], borné à ±0,6). Le facteur est borné à [0,25 ; 4].
// Le droit de douane (Params.tariff) majore ensuite le prix d'import ; il ne touche pas les exportations.
// Taux de change flottant (Params.floatingFx) : les deux prix sont aussi multipliés par fxRate, qui suit chaque soir le
// solde commercial lissé (voir _updateFx).
// Demande étrangère active (Params.foreignDemand) : carnet de commandes par entreprise et par bien (voir _foreignOrders).
//
// Pas de math.sin (résultats différents entre la VM et le web) : approximation de Bhaskara, en opérations élémentaires.

extension Douane on Sim {
  /// Facteur du jour des prix mondiaux d'un bien (1 sans vagues).
  double tradeFactorOf(String good) => params.tradeWaves ? (tradeFactor[good] ?? 1.0) : 1.0;

  /// Taux de change en vigueur (1 sans taux flottant).
  double get fx => params.floatingFx ? fxRate : 1.0;

  /// Prix d'une unité importée, droit de douane compris.
  double importPrice(String good) {
    var v = worldPrice[good]! * params.importMarkup;
    if (params.tradeWaves) v *= tradeFactor[good] ?? 1.0;
    if (params.floatingFx) v *= fxRate;
    if (params.tariff != 0) v *= 1 + params.tariff;
    return v;
  }

  /// Prix reçu pour une unité exportée.
  double exportPrice(String good) {
    var v = worldPrice[good]! * params.exportDiscount;
    if (params.tradeWaves) v *= tradeFactor[good] ?? 1.0;
    if (params.floatingFx) v *= fxRate;
    return v;
  }

  /// Fin de journée : moyennes lissées (α = 0,05) des importations sorties de l'économie (droit de douane exclu) et des
  /// exportations, puis taux de change × (1 + fxSpeed × déséquilibre relatif), borné à [0,1 ; 10].
  void _updateFx() {
    fxImportsEma = 0.95 * fxImportsEma + 0.05 * dayFlows.imports;
    fxExportsEma = 0.95 * fxExportsEma + 0.05 * dayFlows.exports;
    final sum = fxImportsEma + fxExportsEma;
    if (sum <= 0) return;
    fxRate = (fxRate * (1 + params.fxSpeed * (fxImportsEma - fxExportsEma) / sum)).clamp(0.1, 10.0).toDouble();
  }

  /// Commande quotidienne de l'étranger pour un bien d'une entreprise (0 sans commande).
  double foreignOrderOf(Firm f, String good) => foreignOrders['${f.id}:$good'] ?? 0.0;

  /// Livraisons aux clients étrangers, après les ventes du jour. L'entreprise garde deux jours de sa demande d'ici en stock
  /// et livre le reste, jusqu'à la commande, au prix à l'export. La commande grossit tant que l'export est rentable et
  /// qu'elle a été livrée ; elle fond sinon. Une entreprise sans employé perd ses commandes.
  void _foreignOrders() {
    final p = params;
    final next = <String, double>{};
    for (final f in firms) {
      if (f.workers.isEmpty || publicService(f)) continue;
      for (final e in f.outputs.entries) {
        final g = e.key;
        if (goods[g]!.perish || !goods[g]!.tradable) continue;
        final key = '${f.id}:$g';
        var order = foreignOrders[key] ?? 0.0;
        final cost = f.unitCostCache[g];
        final price = exportPrice(g);
        // rentable, et pas moins payé qu'ici : sinon le prix local monterait vers le prix d'import et les clients d'ici
        // importeraient ce que l'entreprise exporte (aller-retour perdant, la monnaie s'effondrerait)
        final ok = cost != null && cost > 0 && price >= cost * (1 + p.fdMinMargin) && price >= 0.95 * f.price[g]!;
        if (order <= 0 && !ok) continue;
        // taille de référence : la demande d'ici (ventes lissées moins la commande), ou 10 % de ce que l'équipe produit
        // pour une entreprise qui n'a presque pas de clients ici
        final local = math.max(0.0, (f.demandEma[g] ?? 0) - order);
        final base = math.max(local, 0.1 * math.max(1, f.workers.length) * perWorker(f) * e.value);
        if (order <= 0) order = p.fdStart * base;
        final keep = 2 * math.max(local, 0.5);
        final q = math.min(order, math.max(0.0, (f.inv[g] ?? 0) - keep));
        if (q > eps) {
          final value = transfer(null, f, q * price);
          _setStock(f, g, (f.inv[g] ?? 0) - q);
          f.revenue += value;
          f.sold[g] = (f.sold[g] ?? 0) + q; // une vraie vente : la production et l'embauche la suivent
          ledgerExports += value;
          bank.reserves += value;
          dayFlows.exports += value;
          _flow(f.id.toString(), 'X', g, q, value);
        }
        if (!ok) {
          order *= 0.9;
        } else if (q >= 0.9 * order) {
          order *= 1 + p.fdGrowth;
        }
        order = math.min(order, p.fdMaxCap * base);
        if (order >= 0.01) next[key] = order;
      }
    }
    foreignOrders
      ..clear()
      ..addAll(next);
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
