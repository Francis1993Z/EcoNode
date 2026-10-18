part of 'sim.dart';

// Entrepreneuriat des citoyens (Modules.entrepreneurship). Voir MODELE.md § 6.17.
//
// Avec le module, la création mécanique d'une entreprise « clone » par le citoyen le plus riche (`_found`) cesse : ce sont des
// citoyens qui décident de fonder. Chaque jour, chaque citoyen qui n'est pas déjà propriétaire tire un nombre (flux
// `Flux.entrepreneuriat`) ; s'il passe sous `entConsiderRate × entFoundRate`, il examine les projets possibles, à condition
// de vouloir posséder (`ownerShare`), d'avoir assez d'ambition et assez de tolérance au risque. Un projet est un secteur où
// la demande réellement non servie (`unmetEma`) occuperait une équipe, au prix que le marché paie aujourd'hui (donc avec la
// marge qu'on y observe). Le citoyen le compare à son revenu actuel (salaire, ou prestation s'il est sans emploi), pondéré
// par son aversion au risque et par la connaissance qu'il a du secteur (jours travaillés dans ce type d'entreprise).
//
// Le capital de départ (10 jours de salaires + 5 jours d'intrants, × entCapitalMult) vient de l'épargne du fondateur (au-delà
// de son coussin) et, pour le reste, d'un prêt de la Caisse soumis à ses règles prudentielles (I4). Tout l'argent passe par
// `transfer()`. Le fondateur quitte son emploi et devient le premier employé de son entreprise (il en est aussi le
// propriétaire : les dividendes suivent la règle I1). Les fermetures passent par `_close` (faillite ordonnée I5) : le
// fondateur perd sa mise, la Caisse radie le solde de la dette de l'entreprise (le citoyen n'a pas de dette personnelle
// dans le modèle), et il retourne au marché du travail avec son expérience.

/// Un projet de fondation évalué pour un citoyen.
class _Project {
  final String type;
  final double want; // demande non servie, en unités par jour
  final int team;
  final double wage;
  final double inputCost;
  final double revenue0;
  final double capital;
  final double own; // part de l'épargne du fondateur
  final double gain; // gain espéré par jour, net de son revenu actuel et du risque
  final double knowledge;
  const _Project(this.type, this.want, this.team, this.wage, this.inputCost, this.revenue0, this.capital, this.own, this.gain,
      this.knowledge);
}

extension SimEntrepreneurship on Sim {
  /// Tirage de trait d'un citoyen : le flux `traits` (sous-indice [sub]) tiré « au jour 0 », donc une fonction pure de la
  /// graine et de l'identifiant. Un trait de naissance ne doit pas changer avec le jour où on le lit, ni dépendre de la
  /// date d'arrivée du citoyen : rien à sérialiser, et un citoyen né avant que le module soit actif a quand même ses traits.
  /// Sous-indices : 70 tolérance au risque, 71 désir de posséder (les noms occupent 10 à 69).
  double traitDraw(int id, int sub) {
    if (sansHasard) return 0.5;
    final h = hash32(hash32(hash32(seed & 0xFFFFFFFF, Flux.traits.code), 0), id);
    return Mulberry32.first(hash32(h, sub));
  }

  /// Tolérance au risque d'un citoyen, de 0 à 1 : son tirage de naissance placé dans la distribution des paramètres.
  double riskTolerance(Citizen c) {
    final p = params;
    return (p.entRiskMean + p.entRiskSpread * (2 * traitDraw(c.id, 70) - 1)).clamp(0.0, 1.0).toDouble();
  }

  /// Le citoyen veut-il posséder ? Avec les bâtiments, c'est le trait déjà tiré (`wantsToOwn`) ; sans eux, ce trait n'existe
  /// pas, on tire le même désir (part `ownerShare`) au sous-indice 71.
  bool wantsToFound(Citizen c) => modules.buildings ? c.wantsToOwn : traitDraw(c.id, 71) < params.ownerShare;

  /// Connaissance d'un secteur, de 0 à 1 : 1 − exp(−jours travaillés dans ce type d'entreprise / entKnowledgeDays).
  double sectorKnowledge(Citizen c, String type) {
    final d = c.sectorDays[type] ?? 0;
    return d <= 0 ? 0.0 : 1 - math.exp(-d / params.entKnowledgeDays);
  }

  /// Pourquoi ce citoyen ne peut pas fonder aujourd'hui ; null s'il est candidat (pour la fiche citoyen et le décompte).
  String? foundingBlocker(Citizen c, [Set<int>? owners]) {
    final p = params;
    if (owners != null ? owners.contains(c.id) : firms.any((f) => f.ownerId == c.id)) return 'déjà propriétaire';
    if (!wantsToFound(c)) return 'ne veut pas posséder';
    if (c.ambition < p.entMinAmbition) return 'ambition trop basse';
    if (riskTolerance(c) < p.entMinTolerance) return 'tolérance au risque trop basse';
    final buffer = p.bufferDays * (needCost > 0 ? needCost : 140);
    if (c.money <= buffer) return 'pas d’épargne au-delà de son coussin';
    return null;
  }

  /// Nombre de citoyens candidats à fonder aujourd'hui (conditions remplies, avant le tirage quotidien et le choix d'un projet).
  int foundingCandidates() {
    final owners = <int>{
      for (final f in firms)
        if (f.ownerId != null) f.ownerId!
    };
    return citizens.where((c) => foundingBlocker(c, owners) == null).length;
  }

  /// Secteurs connus d'un citoyen, du plus connu au moins connu : (type, jours travaillés, connaissance de 0 à 1).
  List<(String, int, double)> knownSectors(Citizen c) {
    final l = [for (final e in c.sectorDays.entries) (e.key, e.value, sectorKnowledge(c, e.key))];
    l.sort((a, b) => b.$2.compareTo(a.$2));
    return l;
  }

  int foundedIn(int year) => foundedByYear[year] ?? 0;
  int closedIn(int year) => closedByYear[year] ?? 0;

  /// Un jour de plus dans le secteur de son employeur, pour chaque citoyen en emploi.
  void _learnSectors() {
    for (final c in citizens) {
      final id = c.employer;
      if (id == null) continue;
      final f = _fmap[id];
      if (f != null) c.sectorDays[f.type] = (c.sectorDays[f.type] ?? 0) + 1;
    }
  }

  /// Compte une étape de l'entonnoir de fondation (mesure) ; préfixe « fond_ » pour ne pas se mêler à celui des créations
  /// mécaniques.
  void _entFunnel(String step, [String ty = '', String detail = '', double amount = 0]) {
    entryFunnel['fond_$step'] = (entryFunnel['fond_$step'] ?? 0) + 1;
    if (trace != null && step != 'projet' && step != 'creation' && ty.isNotEmpty) {
      _t('entrees_sorties', 'projet_refuse', templates[ty]!.label, null, 'entrepreneuriat : fondation refusée', step, amount,
          detail);
    }
  }

  /// La journée des fondateurs : appelée à la place de la création mécanique, après les fermetures.
  void _entrepreneurship() {
    final p = params;
    final owners = <int>{
      for (final f in firms)
        if (f.ownerId != null) f.ownerId!
    };
    final buffer = p.bufferDays * (needCost > 0 ? needCost : 140);
    final chance = p.entConsiderRate * p.entFoundRate;
    List<int>? avail; // chômeurs par seuil de qualification, calculés au premier candidat du jour
    for (final c in List<Citizen>.from(citizens)) {
      if (draw(Flux.entrepreneuriat, c.id) >= chance) continue;
      if (owners.contains(c.id) || c.money <= buffer) continue;
      if (!wantsToFound(c) || c.ambition < p.entMinAmbition) continue;
      final tol = riskTolerance(c);
      if (tol < p.entMinTolerance) continue;
      avail ??= [
        for (var s = 0; s < 3; s++) citizens.where((x) => x.employer == null && x.skill + eps >= s).length
      ];
      _entFunnel('projet');
      final best = _bestProject(c, tol, buffer, avail);
      if (best == null) continue;
      final cause = _foundByCitizen(c, best, buffer);
      if (cause == null) {
        owners.add(c.id);
        _entFunnel('creation');
      } else {
        _entFunnel(cause, best.type, '${c.name} : capital ${fmtMoney0(best.capital)}', best.capital);
      }
    }
  }

  /// Le projet qui rapporte le plus à ce citoyen, ou null si aucun ne vaut mieux que sa situation. Les secteurs sans signal
  /// ou hors de sa portée (qualification, capital, équipe) ne comptent pas.
  _Project? _bestProject(Citizen c, double tol, double buffer, List<int> avail) {
    final p = params;
    final cur = c.employer != null
        ? (modules.jobs ? c.wage : (_fmap[c.employer!]?.wage ?? 0.0))
        : (c.eiBenefit > 0 ? c.eiBenefit : p.benefit);
    final aversion = 2 * (1 - tol);
    _Project? best;
    for (final ty in templates.keys) {
      final t = templates[ty]!;
      final g = t.outputs.keys.first;
      if (publicGood(g)) continue; // l'État fournit ce service
      if (g == 'logement' && modules.buildings) continue; // on construit, on ne fonde pas un bailleur sans bâtiment
      if (day - (_lastEntry[ty] ?? -100000) < p.entryCooldown) continue;
      final want = entryWant(g); // demande non servie (module products : aussi faiblement servie)
      if (want < 0) continue; // module products : marge des variétés en place peu attrayante
      final perWorker0 = t.rate * t.outputs[g]!;
      if (want < p.entryMinShare * perWorker0) continue; // pas de signal : pas de projet
      if (c.skill + eps < t.skill) continue; // il travaillera dans son entreprise
      final batches = want / t.outputs[g]!;
      final w = batches / t.rate; // employés nécessaires à productivité nominale
      final team = w.ceil().clamp(1, 3).toInt();
      if (avail[t.skill] - (c.employer == null && c.skill + eps >= t.skill ? 1 : 0) < team - 1) continue; // pas assez de chômeurs
      final wage = modules.jobs ? marketOffer(t.skill) * avgRoleRel(ty) : marketWage(t.skill);
      var inputCost = 0.0;
      for (final e in t.inputs.entries) {
        inputCost += batches * e.value * bestPrice(e.key);
      }
      var revenue0 = 0.0;
      for (final e in t.outputs.entries) {
        revenue0 += batches * e.value * math.min(bestPrice(e.key), 2 * worldPrice[e.key]!);
      }
      if (revenue0 < 1.1 * (team * wage + inputCost)) continue; // le marché est trop petit pour vivre
      final capital = p.entCapitalMult * (10 * wage * team + 5 * inputCost);
      final own = math.min(c.money - buffer, capital);
      if (own < (modules.credit ? p.entMinOwnShare : 1.0) * capital) continue;
      final k = sectorKnowledge(c, ty);
      final pS = (p.entSurviveBase + p.entSurviveKnowledge * k).clamp(0.05, 0.95).toDouble();
      final profit0 = revenue0 - team * wage - inputCost;
      final income = wage + math.max(0.0, profit0) * (1 - p.taxRate); // son salaire et ses dividendes, s'il réussit
      final fallback = p.benefit; // s'il échoue, il retourne au chômage
      final riskCost = aversion * (1 - pS) * own / 365; // sa mise perdue, répartie sur un an, pesée par son aversion
      final gain = pS * income + (1 - pS) * fallback - riskCost - cur;
      if (gain <= 0 || (best != null && gain <= best.gain)) continue;
      best = _Project(ty, want, team, wage, inputCost, revenue0, capital, own, gain, k);
    }
    return best;
  }

  /// Prêt de la Caisse à une entreprise qui n'existe pas encore : les mêmes règles prudentielles (I4) que `_creditOk`
  /// (paiements au plus 35 % de la valeur ajoutée, fonds propres de la Caisse au moins 11,5 % des prêts).
  String? _loanRefusal(double loan, double valueAdded) {
    final sg = safeguards;
    final p = params;
    if (!(modules.bankRegulation || sg.credit)) return null;
    final pay = loan * (p.interestRate / 365 + 1 / p.loanTermDays);
    if (pay > sg.maxPaymentRatio * valueAdded) return 'pret_paiements';
    if (bank.equity < sg.minCapitalRatio * (totalDebt() + loan)) return 'pret_fonds_propres';
    return null;
  }

  /// Fonde l'entreprise. Rend null si elle est créée, sinon la cause du refus : capital ou pret_*.
  String? _foundByCitizen(Citizen c, _Project pr, double buffer) {
    final p = params;
    final t = templates[pr.type]!;
    final g = t.outputs.keys.first;
    final own = math.min(c.money - buffer, pr.capital);
    final loan = quantize(pr.capital - own);
    if (own < (modules.credit ? p.entMinOwnShare : 1.0) * pr.capital - eps) return 'capital';
    if (loan > eps) {
      if (!modules.credit || day < 0) return 'pret_credit_coupe';
      final refusal = _loanRefusal(loan, pr.revenue0 - pr.inputCost);
      if (refusal != null) {
        bank.refusals++;
        if (trace != null) {
          _t('credit', 'refus', t.label, null, 'I4 : règles prudentielles de la Caisse (fondation)', refusal, loan,
              'pour ${c.name}');
        }
        return refusal;
      }
    }
    final batches = pr.want / t.outputs[g]!;
    final same = firms.where((o) => o.type == pr.type).toList();
    final slot = _slots.remove(pr.type) ?? (same.isNotEmpty ? [same.last.x, same.last.y + 170] : [600.0, 300.0]);
    // il quitte son emploi pour la sienne
    if (c.employer != null) _fire(firm(c.employer!), c, 'départ pour fonder une entreprise');
    final f = _newFirm(pr.type, '${t.label} ${c.name.split(' ').last}', 0, c.id, slot[0], slot[1]);
    // module products, catégorie différenciée : pas de fraction d'employé (la variété fait vivre un employé entier)
    f.rate = productsActive && isDifferentiated(g) ? t.rate : t.rate * Sim._minScale(batches / t.rate, 1);
    f.wage = pr.wage;
    if (modules.jobs) {
      f.offer = marketOffer(t.skill);
      _syncWage(f);
    }
    final paid = transfer(c, f, quantize(own));
    _flow('M', f.id.toString(), '\$capital', 1, paid);
    var lent = 0.0;
    if (loan > eps) {
      _lend(f, loan);
      lent = loan;
    }
    for (final e in f.outputs.entries) {
      f.demandEma[e.key] = batches * e.value;
    }
    f.outputEma = batches;
    final cost = unitCost(f);
    var revenue = 0.0;
    for (final o in f.outputs.keys) {
      final others = sellersOf(o).where((x) => !identical(x, f) && x.workers.isNotEmpty).map((x) => x.price[o]!);
      final own = cost[o]! * p.markup;
      _setPrice(f, o, others.isEmpty ? own : math.min(own, others.reduce(math.min)));
      revenue += f.demandEma[o]! * f.price[o]!;
    }
    f.revenueEma = revenue;
    f.founderId = c.id;
    f.foundedDay = day;
    f.startCapital = paid + lent;
    _lastEntry[pr.type] = day;
    firmsCreated++;
    foundedByYear[day ~/ 365] = foundedIn(day ~/ 365) + 1;
    _hire(f, c, 'fondateur de l’entreprise'); // premier employé de sa propre entreprise
    f.vacancies = pr.team - 1;
    if (trace != null) {
      _t('entrees_sorties', 'creation', f.name, f.id, 'entrée : fondation par un citoyen', 'fondateur ${c.name}', f.startCapital,
          'épargne ${fmtMoney0(paid)}, prêt ${fmtMoney0(lent)} ; ${fmtNum1(pr.want)} ${goods[g]!.unit}/j non servis ; '
              'équipe ${pr.team} ; connaissance du secteur ${fmtPct(pr.knowledge)}');
    }
    _log('info', '${c.name} fonde ${f.name} (${t.label.toLowerCase()}, capital ${fmtMoney0(f.startCapital)}'
        '${lent > 0 ? ', dont ${fmtMoney0(lent)} de prêt' : ''}).');
    return null;
  }

  /// Raisons de fermeture lisibles (voir `closeCause`).
  static const Map<String, String> closeReasons = {
    'prix_aberrant': 'prix aberrant',
    'faillite': 'faillite : salaires impayables',
    'demande_perdue': 'demande perdue',
    'sans_employe': 'plus d’employé',
    'autre': 'autre cause',
  };

  /// Une entreprise ferme (appelé par `_close` avec le module) : compte l'année et écrit l'événement.
  void _entClosed(Firm f, String cause, double left, Citizen? owner) {
    closedByYear[day ~/ 365] = closedIn(day ~/ 365) + 1;
    final why = closeReasons[cause] ?? cause;
    final founder = f.founderId != null ? _cmap[f.founderId!] : null;
    final tail = StringBuffer();
    if (f.founderId != null) {
      tail.write(' ; fondée le jour ${f.foundedDay} par ${founder?.name ?? 'un citoyen parti'}, capital de départ '
          '${fmtMoney0(f.startCapital)}');
      if (founder != null && identical(founder, owner)) tail.write(', ${fmtMoney0(left)} rendus');
    } else if (left > 0) {
      tail.write(' ; ${fmtMoney0(left)} rendus à ${owner?.name ?? 'l’État'}');
    }
    _log('info', '${f.name} ferme ($why$tail).');
  }
}
