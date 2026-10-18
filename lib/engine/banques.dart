part of 'sim.dart';

// Crédit aux citoyens et banques (Modules.banking). Voir MODELE.md § 6.19.
//
// Phase A — crédit aux particuliers, une banque (la Caisse populaire). Un citoyen a une cote de crédit (300 à 900 : retards
// récents, dette rapportée au revenu, emploi, faillite passée). Il emprunte pour une raison lisible, enregistrée :
//  - carte de crédit, quand son argent ne couvre pas les besoins du jour (nourriture, nuitée, soins) ; il la rembourse quand
//    son revenu arrive (au-delà de deux coussins, la moitié de l'excédent) ; paiement minimum mensuel, solde reporté, taux
//    annuel élevé ;
//  - prêt personnel à terme (mensualités constantes) pour un creux de chômage ou un achat important (ordinateur).
// Le taux suit le risque (cote) ; le service de la dette est plafonné (dsrMax du revenu mensuel). Un prêt crée des dépôts (la
// Caisse crée la monnaie qu'elle prête, comme pour les entreprises) ; un remboursement en détruit ; les intérêts payés vont aux
// fonds propres de la banque ; des intérêts impayés sont capitalisés. Faillite personnelle : paiements en retard depuis
// bkArrearsDays jours, ou, sans emploi, dette au-delà de bkDebtIncome années de revenu. Les dettes sont radiées (la banque
// absorbe la perte sur ses fonds propres, comme pour I5), le citoyen n'a plus de crédit pendant bkBanDays jours, et sa cote
// reste abaissée ensuite. Une banque dont les pertes sur ces prêts dépassent bankTightLoss (annualisées) resserre : taux plus
// hauts, limites plus basses, cote minimale plus haute.

extension SimBanking on Sim {
  // ------------------------------------------------------------------ cote, revenu, taux

  /// Revenu annuel estimé : le revenu net lissé (salaire, prestations, dividendes), au moins la prestation de base.
  double annualIncome(Citizen c) => 365 * math.max(c.incomeEma, c.employer == null ? params.benefit : 0.0);

  /// Cote de crédit, de 300 à 900.
  int creditScore(Citizen c) {
    final inc = annualIncome(c);
    final dti = inc > 0 ? c.consumerDebt / inc : 3.0;
    var s = 720.0 - 70 * math.min(c.latePayments, 4) - 120 * math.min(dti, 2.5) + (c.employer != null ? 40 : -60);
    if (day < c.creditBanUntil) {
      s -= 250;
    } else if (c.bankruptcies > 0) {
      s -= 80;
    }
    return s.round().clamp(300, 900).toInt();
  }

  /// Resserrement d'une banque, de 0 à 1 : pertes annualisées sur ses prêts aux particuliers au-delà de bankTightLoss, ou
  /// fonds propres proches du minimum réglementaire. Calculé une fois par jour (début de la consommation).
  double creditTightness(int bankId) {
    if (tightDay == day && bankId < tightToday.length) return tightToday[bankId];
    return computeTightness(bankId);
  }

  double computeTightness(int bankId) {
    final st = bankStats(bankId);
    final loss = st.loans > 0 ? st.lossEma * 365 / st.loans : 0.0;
    var t = ((loss - params.bankTightLoss) / params.bankTightLoss).clamp(0.0, 1.0).toDouble();
    if (st.capitalRatio < 2 * safeguards.minCapitalRatio) t = 1;
    return t;
  }

  /// Prime de risque d'un citoyen (0 à 1) selon sa cote.
  double _risk(Citizen c) => ((900 - creditScore(c)) / 600).clamp(0.0, 1.0).toDouble();

  double personalLoanRate(Citizen c) =>
      params.interestRate + bankLoanSpread(c.bankId) + params.creditRiskPremium * _risk(c) + 0.05 * creditTightness(c.bankId);

  double cardRateOf(Citizen c) =>
      params.cardRate + bankCardSpread(c.bankId) + 0.5 * params.creditRiskPremium * _risk(c) + 0.05 * creditTightness(c.bankId);

  /// Mensualités en cours (prêts) et paiement minimum de la carte à son solde actuel.
  double monthlyDebtService(Citizen c, [double? cardBalance]) {
    var m = 0.0;
    for (final l in loans(c)) {
      m += l.payment;
    }
    final b = cardBalance ?? c.card;
    return m + b * (params.cardMinPct + cardRateOf(c) / 12);
  }

  List<PersonalLoan> loans(Citizen c) => c.loans;

  /// Facteur d'annuité : valeur actuelle d'une mensualité de 1 $ sur n mois au taux mensuel i (puissance par
  /// multiplications successives : même résultat sur la VM et sur le web).
  double _annuity(double i, int n) {
    if (i <= 0) return n.toDouble();
    var f = 1.0;
    for (var k = 0; k < n; k++) {
      f *= 1 + i;
    }
    return (1 - 1 / f) / i;
  }

  /// Le citoyen peut-il obtenir un crédit ? Null si oui, sinon la raison.
  String? creditBlocker(Citizen c) {
    if (!modules.banking) return 'module coupé';
    if (day < c.creditBanUntil) return 'faillite récente (jusqu’au jour ${c.creditBanUntil})';
    final min = params.creditMinScore + 100 * creditTightness(c.bankId);
    if (creditScore(c) < min) return 'cote ${creditScore(c)} sous ${min.round()}';
    if (c.arrears > 0) return 'paiements en retard';
    return null;
  }

  // ------------------------------------------------------------------ comptes de la banque

  /// Règle prudentielle (I4) pour un nouveau crédit à un particulier : fonds propres de la banque ≥ minCapitalRatio des prêts
  /// pondérés, ce crédit compris.
  bool _consumerCreditOk(int bankId, double amt) {
    if (!(modules.bankRegulation || safeguards.credit)) return true;
    final equity = banks.isEmpty ? bank.equity : banks[bankId < banks.length ? bankId : 0].equityNow;
    final risk = banks.isEmpty ? _debtBase : banks[bankId < banks.length ? bankId : 0].riskLoans;
    if (equity >= safeguards.minCapitalRatio * (risk + _creditToday + amt)) return true;
    bank.refusals++;
    return false;
  }

  double _lendCitizen(Citizen c, double amt) {
    final a = transfer(null, c, amt); // la banque crée la monnaie qu'elle prête
    ledgerCredit += a;
    bank.lent += a;
    dayFlows.loans += a;
    consumerLent += a;
    _creditToday += a;
    _flow('B', 'M', '\$prêts', 1, a);
    return a;
  }

  /// Remboursement de capital : détruit la monnaie créée par le prêt.
  double _repayCitizen(Citizen c, double amt) {
    final a = transfer(c, null, math.min(amt, c.money));
    if (a <= 0) return 0;
    ledgerCredit -= a;
    bank.repaid += a;
    dayFlows.repaid += a;
    _flow('M', 'B', '\$remboursements', 1, a);
    return a;
  }

  double _payInterest(Citizen c, double amt, int bankId) {
    final a = transfer(c, bank, math.min(amt, c.money));
    if (a <= 0) return 0;
    bank.interest += a;
    bank.equity += a;
    dayFlows.interest += a;
    _attrib(bankId, a, income: a);
    _flow('M', 'B', '\$intérêts', 1, a);
    return a;
  }

  void _capitalize(double amt, int bankId) {
    bank.capitalized += amt;
    bank.equity += amt;
    dayFlows.capitalized += amt;
    _attrib(bankId, amt, income: amt);
  }

  void _writeOffConsumer(double amt, int bankId) {
    if (amt <= 0) return;
    bank.writtenOff += amt;
    bank.equity -= amt;
    dayFlows.writtenOff += amt;
    consumerWrittenOff += amt;
    _attrib(bankId, -amt, loss: amt);
  }

  // ------------------------------------------------------------------ la journée d'un emprunteur

  /// Avant ses achats : intérêts de la carte, échéances, arriérés, remboursement volontaire, faillite ; puis emprunt si
  /// l'argent ne couvre pas les besoins du jour.
  void _citizenCredit(Citizen c) {
    final p = params;
    final buffer = p.bufferDays * needCost;
    // intérêts courus de la carte (payés à la facturation mensuelle)
    if (c.card > 0) c.cardInterest += c.card * cardRateOf(c) / 365;
    // facturation mensuelle de la carte
    if (c.cardOpened >= 0 && day > c.cardOpened && (day - c.cardOpened) % 30 == 0) {
      final interest = quantize(c.cardInterest);
      c.cardInterest = 0;
      final principal = quantize(math.min(c.card, p.cardMinPct * c.card));
      _due(c, interest, principal, c.bankId, card: true);
      // limite revue chaque mois : un client qui a des retards, ou une banque qui resserre, la baisse
      final lim = cardLimitFor(c);
      if (lim < c.cardLimit) c.cardLimit = math.max(c.card, lim);
    }
    // échéances des prêts personnels
    for (final l in List<PersonalLoan>.of(c.loans)) {
      if (day > l.start && (day - l.start) % 30 == 0) {
        final interest = quantize(l.balance * l.rate / 12);
        final principal = quantize(math.min(l.balance, math.max(0.0, l.payment - interest)));
        _due(c, interest, principal, l.bankId, loan: l);
      }
      if (l.balance <= eps) c.loans.remove(l);
    }
    // arriérés : payés dès que possible, sans entamer le coût d'une journée de survie
    if (c.arrears > 0) {
      final pay = math.min(math.min(c.arrears, c.consumerDebt), c.money - needCost);
      if (pay > 0) {
        final a = _repayCitizen(c, pay);
        _reduceBalances(c, a);
        c.arrears = quantize(math.max(0.0, c.arrears - a));
      }
      if (c.arrears <= eps) {
        c.arrears = 0;
        c.arrearsSince = null;
      }
    }
    if (c.latePayments > 0 && day - c.lastLate > 180) {
      c.latePayments--; // un retard s'efface de la cote après six mois sans nouveau retard
      c.lastLate = day;
    }
    // faillite personnelle
    final debt = c.consumerDebt;
    if (debt > 0) {
      if (c.arrearsSince != null && day - c.arrearsSince! >= p.bkArrearsDays) {
        _bankrupt(c, 'paiements impossibles depuis ${day - c.arrearsSince!} jours');
        return;
      }
      if (c.employer == null && debt > p.bkDebtIncome * annualIncome(c)) {
        _bankrupt(c, 'sans emploi, dette de ${fmtMoney0(debt)} au-delà de ${fmtNum1(p.bkDebtIncome)} ans de revenu');
        return;
      }
    }
    // remboursement volontaire de la carte quand le revenu arrive
    if (c.card > 0 && c.arrears <= 0 && c.money > 2 * buffer) {
      final a = _repayCitizen(c, math.min(c.card, 0.5 * (c.money - 2 * buffer)));
      c.card = quantize(c.card - a);
    }
    if (!modules.banking) return; // module coupé en cours de partie : les dettes se servent, aucun crédit nouveau
    // besoins du jour non couverts : la carte
    var need = needCost;
    if (modules.health && c.health < 0.75 && !publicGood('soins') && !modules.publicHealth) need += bestPrice('soins');
    if (c.money < need) _drawCard(c, need - c.money + 1, 'besoins du jour (nourriture, nuitée${need > needCost ? ', soins' : ''})');
    // creux de chômage : un prêt personnel
    if (c.employer == null && c.daysUnemployed >= 5 && c.loans.isEmpty && c.money < 0.5 * buffer) {
      _personalLoan(c, 30 * needCost, 'creux de chômage');
    } else if (c.employer != null && c.computerDays == 0 && c.level >= 1 && c.loans.isEmpty &&
        draw(Flux.credit, c.id, 1) < 0.003) {
      // achat important : un ordinateur à crédit
      final pr = bestPrice('ordinateur');
      if (c.money - buffer < 2 * pr) _personalLoan(c, 2 * pr, 'achat important (ordinateur)');
    }
  }

  /// Une échéance : intérêts (payés à la banque, sinon capitalisés), puis capital (détruit, sinon en arriérés).
  void _due(Citizen c, double interest, double principal, int bankId, {bool card = false, PersonalLoan? loan}) {
    final paidI = interest > 0 ? _payInterest(c, interest, bankId) : 0.0;
    final unpaidI = quantize(interest - paidI);
    if (unpaidI > 0) {
      _capitalize(unpaidI, bankId);
      if (card) {
        c.card += unpaidI;
      } else {
        loan!.balance += unpaidI;
      }
    }
    final paidP = principal > 0 ? _repayCitizen(c, principal) : 0.0;
    if (card) {
      c.card = quantize(c.card - paidP);
    } else {
      loan!.balance = quantize(loan.balance - paidP);
    }
    final unpaidP = quantize(principal - paidP);
    if (unpaidP > 0 || unpaidI > 0) {
      // les arriérés sont une part des soldes : une échéance impayée deux fois ne compte pas deux fois le même capital
      c.arrears = math.min(c.arrears + unpaidP, c.consumerDebt);
      if (c.arrearsSince == null) {
        c.arrearsSince = day;
        _log('warn', 'Paiement manqué : ${c.name} (${card ? 'carte de crédit' : 'prêt personnel'}, '
            '${fmtMoney0(unpaidP + unpaidI)} dus).');
      }
      c.latePayments++;
      c.lastLate = day;
    }
  }

  /// Réduit les soldes d'un montant remboursé hors échéance : la carte d'abord, puis les prêts du plus ancien au plus récent.
  void _reduceBalances(Citizen c, double a) {
    var left = a;
    final fromCard = math.min(left, c.card);
    c.card = quantize(c.card - fromCard);
    left -= fromCard;
    for (final l in c.loans) {
      if (left <= 0) break;
      final x = math.min(left, l.balance);
      l.balance = quantize(l.balance - x);
      left -= x;
    }
    c.loans.removeWhere((l) => l.balance <= eps);
  }

  /// Limite de carte que la banque accorde aujourd'hui à ce citoyen (0 : refus).
  double cardLimitFor(Citizen c) {
    final p = params;
    if (creditBlocker(c) != null) return 0;
    final inc = annualIncome(c) / 365;
    var lim = p.cardLimitDays * inc * (creditScore(c) - 300) / 600 * (1 - 0.5 * creditTightness(c.bankId));
    // plafond du service de la dette : mensualités + paiement minimum de la carte pleine ≤ dsrMax du revenu mensuel
    var loanPay = 0.0;
    for (final l in c.loans) {
      loanPay += l.payment;
    }
    final room = p.dsrMax * 30 * inc - loanPay;
    final perDollar = p.cardMinPct + cardRateOf(c) / 12;
    lim = math.min(lim, room / perDollar);
    return lim < 3 * needCost ? 0 : quantize(lim);
  }

  void _drawCard(Citizen c, double want, String why) {
    if (c.cardLimit <= 0) {
      final lim = cardLimitFor(c);
      if (lim <= 0 || !_consumerCreditOk(c.bankId, lim)) return;
      c.cardLimit = lim;
      c.cardOpened = day;
      _log('info', 'Carte ouverte : ${c.name} (${bankName(c.bankId)}, limite ${fmtMoney0(lim)}, '
          'taux ${fmtPct(cardRateOf(c))}, cote ${creditScore(c)}) — $why.');
    }
    if (creditBlocker(c) != null) return;
    final amt = math.min(want, c.cardLimit - c.card);
    if (amt < 1 || !_consumerCreditOk(c.bankId, amt)) return;
    final a = _lendCitizen(c, amt);
    c.card += a;
    if (trace != null) _t('credit', 'carte', c.name, c.id, 'achat à crédit', why, a, 'solde ${fmtMoney0(c.card)}');
  }

  void _personalLoan(Citizen c, double want, String why) {
    final p = params;
    if (creditBlocker(c) != null) return;
    final rate = personalLoanRate(c);
    final i = rate / 12;
    final af = _annuity(i, p.loanTermMonths);
    final inc = annualIncome(c) / 365;
    final room = p.dsrMax * 30 * inc - monthlyDebtService(c);
    final amt = quantize(math.min(want, room * af));
    if (amt < 5 * needCost || !_consumerCreditOk(c.bankId, amt)) return;
    final a = _lendCitizen(c, amt);
    final payment = quantize(a / af) + 1 / 1024;
    c.loans.add(PersonalLoan(c.bankId, a, rate, p.loanTermMonths, payment, day, why));
    _log('info', 'Prêt accordé : ${c.name}, ${fmtMoney0(a)} sur ${p.loanTermMonths} mois à ${fmtPct(rate)} '
        '(${bankName(c.bankId)}, mensualité ${fmtMoney0(payment)}) — $why.');
  }

  /// Faillite personnelle : toutes ses dettes sont radiées (la banque absorbe la perte), crédit fermé un temps.
  void _bankrupt(Citizen c, String why) {
    final cardBank = c.bankId;
    _writeOffConsumer(c.card, cardBank);
    for (final l in c.loans) {
      _writeOffConsumer(l.balance, l.bankId);
    }
    final total = c.consumerDebt;
    c.loans.clear();
    c
      ..card = 0
      ..cardLimit = 0
      ..cardInterest = 0
      ..cardOpened = -1
      ..arrears = 0
      ..arrearsSince = null
      ..bankruptcies = c.bankruptcies + 1
      ..creditBanUntil = day + params.bkBanDays
      ..lastBankruptcy = 'jour $day : $why';
    consumerBankruptcies++;
    _log('warn', 'Faillite personnelle : ${c.name} — $why ; ${fmtMoney0(total)} radiés, crédit fermé '
        '${params.bkBanDays} jours.');
    if (trace != null) _t('credit', 'faillite_citoyen', c.name, c.id, 'faillite personnelle', why, total);
  }

  /// Dette des particuliers envers une banque (toutes les banques si null).
  double consumerDebtOf([int? bankId]) {
    var d = 0.0;
    for (final c in citizens) {
      if (bankId == null || c.bankId == bankId) d += c.card;
      for (final l in c.loans) {
        if (bankId == null || l.bankId == bankId) d += l.balance;
      }
    }
    return d;
  }

  // ------------------------------------------------------------------ banques (phase A : la Caisse seule)

  String bankName(int id) => id < banks.length ? banks[id].name : 'Caisse populaire';
  double bankLoanSpread(int id) => id < banks.length ? banks[id].loanSpread : 0.0;
  double bankCardSpread(int id) => id < banks.length ? banks[id].cardSpread : 0.0;

  /// Répartition d'une variation des fonds propres entre les banques (phase B) ; avec la Caisse seule, rien à répartir.
  void _attrib(int bankId, double delta, {double income = 0, double loss = 0}) {
    if (banks.isEmpty) {
      if (loss > 0) consumerLossToday += loss;
      return;
    }
    final b = banks[bankId < banks.length ? bankId : 0];
    if (b.id != 0) b.equity += delta;
    b.incomeToday += income;
    b.lossToday += loss;
  }

  /// Chiffres d'une banque : fonds propres, prêts (au nominal et pondérés), pertes lissées, ratio de capital.
  BankStats bankStats(int bankId) {
    if (banks.isEmpty) {
      final consumer = consumerDebtOf();
      final risk = _debtBase > 0 ? _debtBase : totalDebt();
      return BankStats(bank.equity, consumer, risk, consumerLossEma,
          risk > 0 ? bank.equity / risk : double.infinity);
    }
    final b = banks[bankId < banks.length ? bankId : 0];
    return BankStats(b.equityNow, b.consumerLoans, b.riskLoans, b.lossEma, b.capitalRatio);
  }

  /// Début de la consommation : exposition du matin et resserrement de chaque banque.
  void _creditMorning() {
    _debtBase = totalDebt();
    _creditToday = 0;
    tightToday
      ..clear()
      ..addAll([for (var i = 0; i < math.max(1, banks.length); i++) computeTightness(i)]);
    tightDay = day;
  }

  /// Fin de journée (phase A) : pertes lissées des prêts aux particuliers.
  void _creditEndOfDay() {
    consumerLossEma = 0.99 * consumerLossEma + 0.01 * consumerLossToday;
    consumerLossToday = 0;
  }
}

/// Chiffres d'une banque lus par les règles de crédit.
class BankStats {
  final double equity, loans, riskLoans, lossEma, capitalRatio;
  const BankStats(this.equity, this.loans, this.riskLoans, this.lossEma, this.capitalRatio);
}

// ==================================================================== phase B : plusieurs banques en concurrence
//
// Comptabilité : toute la monnaie passe par le compte consolidé du système bancaire (`Sim.bank`), comme avant ; les
// invariants consolidés (masse, prêts, bilan, flux) restent donc exacts. Chaque banque en est une répartition : ses fonds
// propres (la Caisse, banque 0, a le reste du bilan consolidé), ses prêts (les dettes de ses clients), ses dépôts (l'argent de
// ses clients ; l'État est client de la Caisse) et sa position interbancaire. Ses réserves sont le solde de son bilan :
// réserves = dépôts + fonds propres − prêts − prêté aux autres banques. Les paiements entre clients de banques différentes se
// règlent ainsi en réserves à la fin de la journée (règlement net). Une banque sous ses réserves minimales emprunte aux autres
// au taux directeur ; elle rembourse quand elle en a de trop.
//
// Dotation initiale : chaque banque de départ reçoit reservePerCitizen × population en réserves, en monnaie extérieure (comme
// une injection du god mode à la Caisse : réserves et fonds propres augmentent ensemble). La contrepartie est son capital
// propre, détenu par un actionnaire institutionnel : il n'est jamais distribué (capital plancher) ; les dividendes, prélevés
// sur les profits au-delà de ce plancher, sont redistribués à parts égales aux citoyens (pour la Caisse, c'est sa ristourne).

extension SimBanks on Sim {
  int _pickBank(int id) {
    final alive = [for (final b in banks) if (b.alive) b.id];
    if (alive.isEmpty) return 0;
    return alive[(draw(Flux.banques, id) * alive.length).floor().clamp(0, alive.length - 1)];
  }

  /// Activation du module : avec nBanks ≥ 2, les banques de départ, leur dotation et la répartition des clients.
  void _bankingSwitch({bool atReset = false}) {
    bankingActive = modules.banking;
    final p = params;
    if (!bankingActive || banks.isNotEmpty || p.nBanks < 2) return;
    final dot = quantize(p.reservePerCitizen * math.max(1, citizens.length));
    for (var i = 0; i < p.nBanks; i++) {
      final b = Bank(i, i == 0 ? 'Caisse populaire' : 'Banque ${_brand(2000000 + i, 1)}');
      usedNames.add(b.name);
      // marges de départ un peu différentes d'une banque à l'autre (même règle pour toutes)
      b.loanSpread = 0.005 + 0.01 * draw(Flux.banques, 900000 + i, 1);
      b.cardSpread = 0.02 * draw(Flux.banques, 900000 + i, 2);
      b.depositRate = 0.5 * p.policyRate * draw(Flux.banques, 900000 + i, 3);
      b.founded = day;
      if (i > 0) {
        b.equity = dot;
        b.capital = dot;
      }
      banks.add(b);
    }
    final a = transfer(null, bank, dot * p.nBanks);
    bank.capital += dot; // la dotation de la Caisse n'est jamais ristournée
    if (!atReset) {
      // en cours de partie : monnaie extérieure, comme une injection du god mode à la Caisse
      ledgerGod += a;
      bank.reserves += a;
      bank.equity += a;
      dayFlows.godBank += a;
    }
    for (final c in citizens) {
      c.bankId = _pickBank(c.id);
    }
    for (final f in firms) {
      f.bankId = _pickBank(f.id);
    }
    var payroll = 0.0;
    for (final f in firms) {
      payroll += f.wage * f.workers.length;
    }
    _log('info', 'Banques : ${p.nBanks} banques de départ, dotation de ${fmtMoney0(dot)} chacune '
        '(${fmtMoney0(p.reservePerCitizen)} par citoyen) ; la dotation totale vaut '
        '${payroll > 0 ? fmtNum1(a / (365 * payroll)) : '—'} fois la masse salariale annuelle (${fmtMoney0(365 * payroll)}).');
    _banksMeasure();
  }

  /// Chiffres du jour de chaque banque : dépôts, prêts, fonds propres, réserves, clients.
  void _banksMeasure() {
    for (final b in banks) {
      b.deposits = 0;
      b.firmLoans = 0;
      b.consumerLoans = 0;
      b.riskLoans = 0;
      b.clients = 0;
    }
    Bank of(int id) => banks[id < banks.length ? id : 0];
    for (final c in citizens) {
      final b = of(c.bankId);
      b.deposits += c.money;
      b.clients++;
      if (c.card > 0) {
        b.consumerLoans += c.card;
        b.riskLoans += c.card;
      }
      for (final l in c.loans) {
        final lb = of(l.bankId);
        lb.consumerLoans += l.balance;
        lb.riskLoans += l.balance;
      }
    }
    for (final f in firms) {
      final b = of(f.bankId);
      b.deposits += f.money;
      b.clients++;
      b.firmLoans += f.debt;
      b.riskLoans += f.debt;
    }
    final b0 = banks[0];
    b0.deposits += state.money; // l'État est client de la Caisse
    if (mortgages.isNotEmpty) {
      final m = mortgageDebt(); // hypothèques (module bâtiments) : la Caisse
      b0.firmLoans += m;
      b0.riskLoans += params.mortgageRiskWeight * m;
    }
    var others = 0.0;
    for (final b in banks) {
      if (b.id != 0) others += b.equity;
    }
    b0.equity = bank.equity - others;
    for (final b in banks) {
      b.equityNow = b.equity;
      b.reserves = b.deposits + b.equityNow - b.loans - b.interbank;
    }
  }

  /// La journée des banques : intérêts des dépôts, coûts, marché interbancaire, dividendes, taux, clients, faillites.
  void _banksDay() {
    final p = params;
    _banksMeasure();
    // 1. intérêts des dépôts (argent du système bancaire versé aux clients)
    final rates = [for (final b in banks) b.alive ? b.depositRate / 365 : 0.0];
    final paid = List<double>.filled(banks.length, 0);
    void payDeposit(Account a, int bankId) {
      final r = rates[bankId < rates.length ? bankId : 0];
      if (r <= 0 || a.money <= 0) return;
      final x = transfer(bank, a, math.min(a.money * r, bank.money));
      if (x > 0) {
        paid[bankId < paid.length ? bankId : 0] += x;
        if (a is Citizen) a.income += x;
      }
    }

    for (final c in citizens) {
      payDeposit(c, c.bankId);
    }
    for (final f in firms) {
      payDeposit(f, f.bankId);
    }
    // 2. coûts de fonctionnement : le travail de bankStaff employés (services comptables achetés au marché) et le loyer
    final staffUnits = p.bankStaff * (templates['comptable']!.rate * templates['comptable']!.outputs['compta']!);
    final landlord = sellersOf('logement').where((f) => f.workers.isNotEmpty).firstOrNull;
    for (final b in banks) {
      if (!b.alive) continue;
      var cost = 0.0;
      if (staffUnits > 0) cost += buy(bank, 'B', 'compta', staffUnits, bank.money, false).spent;
      final rent = math.min(p.bankRentDaily, bank.money);
      if (rent > 0) {
        final x = transfer(bank, landlord ?? state, rent);
        if (landlord != null) landlord.revenue += x;
        cost += x;
      }
      b.costToday = cost + paid[b.id];
    }
    var out = 0.0;
    for (final b in banks) {
      out += b.costToday;
      bank.equity -= b.costToday;
      if (b.id != 0) b.equity -= b.costToday;
    }
    dayFlows.bankOut += out;
    if (out > 0) _flow('B', 'M', '\$intérêts des dépôts et frais', 1, out);
    _banksMeasure();
    // 3. marché interbancaire : réserves minimales, emprunts au taux directeur, remboursements
    for (final b in banks) {
      if (!b.alive) continue;
      final need = p.reserveRatio * b.deposits - b.reserves;
      if (need > 0) {
        final lenders = [for (final o in banks) if (o.alive && !identical(o, b)) o]
          ..sort((x, y) => (y.reserves - p.reserveRatio * y.deposits).compareTo(x.reserves - p.reserveRatio * x.deposits));
        var left = need;
        for (final o in lenders) {
          final room = o.reserves - p.reserveRatio * o.deposits;
          if (room <= 0 || left <= 0) break;
          final x = math.min(room, left);
          o.interbank += x;
          o.reserves -= x;
          b.interbank -= x;
          b.reserves += x;
          left -= x;
        }
      } else if (b.interbank < 0) {
        // rembourse ses emprunts avec ses réserves de trop ; les prêteurs sont remboursés au prorata
        final x = math.min(-need, -b.interbank);
        var lent = 0.0;
        for (final o in banks) {
          if (o.interbank > 0) lent += o.interbank;
        }
        if (x > 0 && lent > 0) {
          for (final o in banks) {
            if (o.interbank > 0) {
              final y = x * o.interbank / lent;
              o.interbank -= y;
              o.reserves += y;
            }
          }
          b.interbank += x;
          b.reserves -= x;
        }
      }
    }
    // intérêts interbancaires : une répartition entre banques (le total est nul)
    for (final b in banks) {
      final i = b.interbank * p.policyRate / 365;
      if (b.id != 0) b.equity += i;
      b.incomeToday += i;
    }
    // 4. dividendes : au-delà du capital plancher et de la cible de fonds propres
    _banksMeasure();
    for (final b in banks) {
      if (!b.alive || p.bankRebate <= 0) continue;
      final surplus = math.min(bank.money, b.equityNow - math.max(b.capital, p.bankTargetRatio * b.riskLoans));
      if (surplus <= eps || b.profitEma <= 0) continue;
      final owner = b.ownerId != null ? _cmap[b.ownerId!] : null;
      final total0 = surplus * p.bankRebate;
      var total = 0.0;
      if (owner != null) {
        total = transfer(bank, owner, total0);
        owner.income += total;
      } else if (citizens.isNotEmpty) {
        for (final c in citizens) {
          final a = transfer(bank, c, total0 / citizens.length);
          c.income += a;
          total += a;
        }
      }
      bank.rebates += total;
      bank.equity -= total;
      if (b.id != 0) b.equity -= total;
      dayFlows.rebates += total;
      if (total > 0) _flow('B', 'M', '\$dividendes des banques', 1, total);
    }
    // 5. profit, pertes, état ; taux revus tous les 30 jours ; clients ; faillites
    for (final b in banks) {
      if (!b.alive) continue;
      final profit = b.incomeToday - b.costToday - b.lossToday;
      b.profitEma = 0.98 * b.profitEma + 0.02 * profit;
      b.incomeEma = 0.98 * b.incomeEma + 0.02 * b.incomeToday;
      b.costEma = 0.98 * b.costEma + 0.02 * b.costToday;
      b.lossEma = 0.99 * b.lossEma + 0.01 * b.lossToday;
      b.incomeToday = b.lossToday = b.costToday = 0;
      b.lossDays = b.profitEma < 0 ? b.lossDays + 1 : 0;
    }
    _banksMeasure();
    for (final b in List<Bank>.of(banks)) {
      if (!b.alive) continue;
      final weak = b.capitalRatio < 2 * safeguards.minCapitalRatio || b.lossDays > 90;
      if (weak && b.state == 'saine') {
        b.state = 'en difficulté';
        _log('warn', 'Banque en difficulté : ${b.name} (ratio de capital ${b.capitalRatio.isFinite ? fmtPct(b.capitalRatio) : '—'}, '
            'profit lissé ${fmtMoney0(b.profitEma)}/j depuis ${b.lossDays} j).');
      } else if (!weak && b.state != 'saine') {
        b.state = 'saine';
      }
      if (day % 30 == 0) _adjustRates(b);
      final failing = b.equityNow < 0 ||
          (b.riskLoans > 0 && b.capitalRatio < safeguards.minCapitalRatio) ||
          b.lossDays >= p.bankLossDays;
      if (failing && b.id != 0) _resolveBank(b);
    }
    _switchBanks();
    if (modules.banking) _bankFounding();
    bankCountHist.add(banks.where((b) => b.alive).length);
  }

  /// Règle simple des taux : capital bas ou défauts en hausse → marges plus hautes ; réserves inactives → marges plus basses
  /// et dépôts mieux payés pour gagner des clients ; des réserves sous le minimum → dépôts mieux payés.
  void _adjustRates(Bank b) {
    final p = params;
    final lossRate = b.loans > 0 ? b.lossEma * 365 / b.loans : 0.0;
    final stressed = b.capitalRatio < 2 * safeguards.minCapitalRatio || lossRate > p.bankTightLoss;
    final idle = b.reserves > 0.5 * b.deposits;
    if (stressed) {
      b.loanSpread = math.min(0.10, b.loanSpread + 0.005);
      b.cardSpread = math.min(0.15, b.cardSpread + 0.01);
    } else if (idle) {
      b.loanSpread = math.max(0.0, b.loanSpread - 0.0025);
      b.cardSpread = math.max(0.0, b.cardSpread - 0.005);
    }
    if (b.reserves < p.reserveRatio * b.deposits || idle) {
      b.depositRate = math.min(p.policyRate, b.depositRate + 0.0025);
    } else if (stressed) {
      b.depositRate = math.max(0.0, b.depositRate - 0.0025);
    }
  }

  /// Valeur d'une banque pour un client : ce qu'elle paie sur les dépôts moins ce qu'elle prend en plus sur le crédit.
  double bankAppeal(Bank b) => b.depositRate - 0.5 * b.loanSpread - 0.25 * b.cardSpread;

  /// Information limitée et inertie : chaque jour, quelques clients sans dette comparent leur banque à une autre tirée au
  /// hasard, et changent si elle vaut mieux d'au moins bankSwitchGain.
  void _switchBanks() {
    final p = params;
    final alive = [for (final b in banks) if (b.alive) b];
    if (alive.length < 2) return;
    Bank? other(int id, Bank cur) {
      final o = alive[(draw(Flux.banques, id, 5) * alive.length).floor().clamp(0, alive.length - 1)];
      return identical(o, cur) ? null : o;
    }

    for (final c in citizens) {
      if (draw(Flux.banques, c.id, 4) >= p.bankLookChance || c.card > 0 || c.loans.isNotEmpty) continue;
      final cur = banks[c.bankId < banks.length ? c.bankId : 0];
      final o = other(c.id, cur);
      if (o != null && (!cur.alive || bankAppeal(o) - bankAppeal(cur) > p.bankSwitchGain)) c.bankId = o.id;
    }
    for (final f in firms) {
      if (draw(Flux.banques, f.id, 4) >= p.bankLookChance || f.debt > 0) continue;
      final cur = banks[f.bankId < banks.length ? f.bankId : 0];
      final o = other(f.id, cur);
      if (o != null && (!cur.alive || bankAppeal(o) - bankAppeal(cur) > p.bankSwitchGain)) f.bankId = o.id;
    }
  }

  /// Résolution ordonnée d'une banque en faillite : ses comptes et ses prêts passent à la banque la plus solide, qui reprend
  /// aussi ses fonds propres (négatifs : elle absorbe le trou) et sa position interbancaire ; les actionnaires perdent tout,
  /// les déposants rien (leurs comptes ne bougent pas).
  void _resolveBank(Bank b) {
    Bank? acq;
    for (final o in banks) {
      if (!o.alive || identical(o, b)) continue;
      if (acq == null || o.equityNow > acq.equityNow) acq = o;
    }
    if (acq == null) return;
    for (final c in citizens) {
      if (c.bankId == b.id) c.bankId = acq.id;
      for (var k = 0; k < c.loans.length; k++) {
        final l = c.loans[k];
        if (l.bankId == b.id) c.loans[k] = PersonalLoan(acq.id, l.balance, l.rate, l.months, l.payment, l.start, l.reason);
      }
    }
    for (final f in firms) {
      if (f.bankId == b.id) f.bankId = acq.id;
    }
    if (acq.id != 0) acq.equity += b.equity;
    acq.interbank += b.interbank;
    final lost = b.equity;
    b
      ..equity = 0
      ..interbank = 0
      ..alive = false
      ..closed = day
      ..state = 'fermée';
    banksClosed++;
    _log('warn', 'Banque fermée : ${b.name} — reprise par ${acq.name} (fonds propres ${fmtMoney0(lost)} : les actionnaires '
        'perdent leur mise, les déposants ne perdent rien).');
    _banksMeasure();
  }
}


// ==================================================================== phase C : des citoyens fondent des banques
//
// Même décision que l'entrepreneuriat (désir de posséder, ambition, tolérance au risque, connaissance du secteur : les jours
// travaillés dans un cabinet de services comptables, qui fait le travail des banques), avec cinq freins d'entrée qui sont des
// mécanismes : (1) capital minimum absolu bankMinCapital ; (2) coût fixe d'existence : le travail de bankStaff employés et un
// loyer chaque jour ; (3) coût d'entrée irrécupérable bankEntryCost, versé à l'État ; (4) le profit espéré se calcule sur la
// part de marché restante, 1 / (banques + 1) des intérêts nets du marché : plus il y a de banques, plus il est faible ; (5) le
// fondateur verse son propre capital, par transfer() : aucune création d'argent. Sortie : faillite et résolution (la reprise
// par une autre banque est la fusion).

extension SimBankFounders on Sim {
  /// Coût fixe quotidien d'une banque : le travail de bankStaff employés de services comptables et le loyer.
  double bankFixedCost() {
    final t = templates['comptable']!;
    return params.bankStaff * t.rate * t.outputs['compta']! * bestPrice('compta') + params.bankRentDaily;
  }

  /// Profit quotidien qu'espère une nouvelle banque : sa part des intérêts nets du marché (1 / (banques vivantes + 1)) moins
  /// son coût fixe.
  double bankEntrantProfit() {
    final fixed = bankFixedCost();
    var net = 0.0;
    var n = 0;
    for (final b in banks) {
      if (!b.alive) continue;
      n++;
      net += b.incomeEma - math.max(0.0, b.costEma - fixed); // intérêts reçus moins intérêts versés sur les dépôts
    }
    return net / (n + 1) - fixed;
  }

  void _bankFounding() {
    final p = params;
    final buffer = p.bufferDays * (needCost > 0 ? needCost : 140);
    final need = p.bankMinCapital + p.bankEntryCost;
    Set<int>? owners;
    double? expected;
    for (final c in List<Citizen>.of(citizens)) {
      if (draw(Flux.banques, c.id, 6) >= p.bankFoundRate || c.money - buffer < need) continue;
      owners ??= {
        for (final f in firms)
          if (f.ownerId != null) f.ownerId!,
        for (final b in banks)
          if (b.alive && b.ownerId != null) b.ownerId!,
      };
      if (foundingBlocker(c, owners) != null) continue;
      expected ??= bankEntrantProfit();
      final tol = riskTolerance(c);
      final k = sectorKnowledge(c, 'comptable');
      final pS = (p.entSurviveBase + p.entSurviveKnowledge * k).clamp(0.05, 0.95).toDouble();
      final stake = p.bankMinCapital + p.bankEntryCost;
      final gain = pS * expected * (1 - p.taxRate) -
          2 * (1 - tol) * (1 - pS) * stake / 365 -
          p.bankMinCapital * p.policyRate / 365; // ce que son capital rapporterait placé au taux directeur
      entryFunnel['banque_projet'] = (entryFunnel['banque_projet'] ?? 0) + 1;
      if (gain <= 0) continue;
      final fee = transfer(c, state, p.bankEntryCost); // irrécupérable
      final cap = transfer(c, bank, p.bankMinCapital); // son capital : de l'argent du public, aucune création
      bank.equity += cap;
      dayFlows.bankIn += cap;
      _flow('M', 'B', '\$capital des banques', 1, cap);
      final b = Bank(banks.length, 'Banque ${c.name.split(' ').last}');
      if (usedNames.contains(b.name)) b.name = '${b.name} ${b.id}';
      usedNames.add(b.name);
      final alive = banks.where((x) => x.alive).toList();
      double avg(double Function(Bank) f) => alive.isEmpty ? 0 : alive.map(f).reduce((x, y) => x + y) / alive.length;
      b
        ..ownerId = c.id
        ..equity = cap
        ..capital = cap
        ..founded = day
        ..loanSpread = avg((x) => x.loanSpread)
        ..cardSpread = avg((x) => x.cardSpread)
        ..depositRate = math.min(p.policyRate, avg((x) => x.depositRate) + 0.0025); // pour attirer des clients
      banks.add(b);
      owners.add(c.id);
      banksFounded++;
      entryFunnel['banque_creation'] = (entryFunnel['banque_creation'] ?? 0) + 1;
      _log('info', 'Banque fondée : ${c.name} fonde ${b.name} (capital ${fmtMoney0(cap)}, frais d’entrée ${fmtMoney0(fee)}, '
          'profit espéré ${fmtMoney0(expected)}/j sur ${alive.length + 1} banques).');
      expected = bankEntrantProfit();
    }
  }
}
