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
      final pay = math.min(c.arrears, c.money - needCost);
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
      c.arrears += unpaidP;
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
