part of 'sim.dart';

// Instantané : l'état complet d'une partie, en JSON. Reprendre une partie depuis un instantané donne exactement la même
// suite qu'une partie jouée d'une traite (test/instantane_test.dart).
//
// Ne sont pas enregistrés, parce qu'ils sont recalculés : les clés de hasard du jour (_dayKeys), les numéros d'achat du
// jour (_buySeq, vidés au début de chaque journée), les vendeurs par bien et les index par identifiant (_sellers, _cmap,
// _fmap, reconstruits à partir des listes). Les nombres sont écrits par jsonEncode, au plus court qui se relit à
// l'identique ; les valeurs non finies sont écrites en toutes lettres. L'ordre des clés des tables est conservé : il
// fixe l'ordre des sommes, donc leurs arrondis.
//
// Tout champ ajouté à Sim, Citizen, Firm, Params, StateAccount, BankAccount… doit être ajouté ici.

const int snapshotVersion = 1;

Object? _d(double v) => v.isFinite ? v : (v.isNaN ? 'NaN' : (v > 0 ? 'Infinity' : '-Infinity'));

double _rd(Object? v) {
  if (v is num) return v.toDouble();
  switch (v) {
    case 'NaN':
      return double.nan;
    case 'Infinity':
      return double.infinity;
    case '-Infinity':
      return double.negativeInfinity;
  }
  throw FormatException('Instantané : nombre attendu, lu $v');
}

double? _rdn(Object? v) => v == null ? null : _rd(v);
double _rdOr(Object? v, double fallback) => v == null ? fallback : _rd(v); // champ absent d'un instantané plus ancien
Map<String, Object?> _dm(Map<String, double> m) => {for (final e in m.entries) e.key: _d(e.value)};
Map<String, double> _rdm(Object? m) => {for (final e in (m as Map).entries) e.key as String: _rd(e.value)};
Map<String, int> _rim(Object? m) => {for (final e in (m as Map).entries) e.key as String: e.value as int};
List<int> _ril(Object? l) => [for (final x in l as List) x as int];
Map<String, Map<String, int>> _rimm(Object? m) =>
    {for (final e in (m as Map).entries) e.key as String: _rim(e.value)};

Map<String, Object?> _labourJson(LabourStats l) => {'total': l.total, 'today': l.today, 'premium': _d(l.premium)};

Map<String, Object?> _paramsJson(Params p) => {
      'population': p.population,
      'startWallet': _d(p.startWallet),
      'startWage': _d(p.startWage),
      'markup': _d(p.markup),
      'bufferDays': _d(p.bufferDays),
      'mpcIncome': _d(p.mpcIncome),
      'wealthTargetDays': _d(p.wealthTargetDays),
      'trade': p.trade,
      'importMarkup': _d(p.importMarkup),
      'exportDiscount': _d(p.exportDiscount),
      'ubi': _d(p.ubi),
      'priceStep': _d(p.priceStep),
      'wageStep': _d(p.wageStep),
      'priceMaxDaily': _d(p.priceMaxDaily),
      'wageMaxDaily': _d(p.wageMaxDaily),
      'dividendRate': _d(p.dividendRate),
      'invTargetDays': _d(p.invTargetDays),
      'jobSwitch': _d(p.jobSwitch),
      'taxRate': _d(p.taxRate),
      'benefit': _d(p.benefit),
      'minWage': _d(p.minWage),
      'stateRebate': _d(p.stateRebate),
      'interestRate': _d(p.interestRate),
      'loanTermDays': _d(p.loanTermDays),
      'workingCapitalDays': _d(p.workingCapitalDays),
      'exitIdleDays': p.exitIdleDays,
      'entryCooldown': p.entryCooldown,
      'entryMinShare': _d(p.entryMinShare),
      'entryMarginRatio': _d(p.entryMarginRatio),
      'depreciation': _d(p.depreciation),
      'maintNeed': _d(p.maintNeed),
      'softInputShare': _d(p.softInputShare),
      'rndShare': _d(p.rndShare),
      'bankRebate': _d(p.bankRebate),
      'bankCapitalPerCitizen': _d(p.bankCapitalPerCitizen),
      'bankTargetRatio': _d(p.bankTargetRatio),
      'riskSpread': _d(p.riskSpread),
      'adsShare': _d(p.adsShare),
      'adsEffect': _d(p.adsEffect),
      'illness': _d(p.illness),
      'eduRate': _d(p.eduRate),
      'learnRate': _d(p.learnRate),
      'computerLife': p.computerLife,
      'dividendFromRetained': p.dividendFromRetained,
      'publicCashDays': _d(p.publicCashDays),
      'eiReplacement': _d(p.eiReplacement),
      'eiInsurableCap': _d(p.eiInsurableCap),
      'eiRate': _d(p.eiRate),
      'eiDaysLow': p.eiDaysLow,
      'eiDaysHigh': p.eiDaysHigh,
      'eiQualifyingDays': p.eiQualifyingDays,
      'healthWearIfDeprived': p.healthWearIfDeprived,
      'partTime': p.partTime,
      'dwellingModules': p.dwellingModules,
      'buildingWearYear': _d(p.buildingWearYear),
      'buildingMaintShare': _d(p.buildingMaintShare),
      'maintHoursPerDwelling': _d(p.maintHoursPerDwelling),
      'ltvHousehold': _d(p.ltvHousehold),
      'ltvFirm': _d(p.ltvFirm),
      'mortgageSpreadMax': _d(p.mortgageSpreadMax),
      'mortgageTermHousehold': p.mortgageTermHousehold,
      'mortgageTermFirm': p.mortgageTermFirm,
      'mortgageRiskWeight': _d(p.mortgageRiskWeight),
      'foreclosureDays': p.foreclosureDays,
      'ownerShare': _d(p.ownerShare),
      'buyLookChance': _d(p.buyLookChance),
      'relocateChance': _d(p.relocateChance),
      'listingMargin': _d(p.listingMargin),
      'listingDecay': _d(p.listingDecay),
      'listingFloor': _d(p.listingFloor),
      'landlordBuildAbove': _d(p.landlordBuildAbove),
      'buyRentRatio': _d(p.buyRentRatio),
      'scenarioPopulation': p.scenarioPopulation,
      'sellerSample': p.sellerSample,
      'reservationDecay': _d(p.reservationDecay),
      'reservationFloor': _d(p.reservationFloor),
      'switchPremium': _d(p.switchPremium),
      'bargainBase': _d(p.bargainBase),
      'bargainTrait': _d(p.bargainTrait),
      'bargainTight': _d(p.bargainTight),
      'hireRange': _d(p.hireRange),
      'hireFlexBase': _d(p.hireFlexBase),
      'hireFlexMax': _d(p.hireFlexMax),
      'maxInterviews': p.maxInterviews,
      'reviewDays': p.reviewDays,
      'reviewCutMax': _d(p.reviewCutMax),
      'seniorityStep': _d(p.seniorityStep),
      'seniorityCap': _d(p.seniorityCap),
      'promotionRaise': _d(p.promotionRaise),
    };

/// Paramètres de l'entrepreneuriat : seuls ceux qui diffèrent du défaut sont écrits, si bien qu'un instantané sans
/// changement est celui d'avant le module.
Map<String, Object?> _entParamsJson(Params p) {
  final d = Params();
  return {
    if (p.entFoundRate != d.entFoundRate) 'entFoundRate': _d(p.entFoundRate),
    if (p.entConsiderRate != d.entConsiderRate) 'entConsiderRate': _d(p.entConsiderRate),
    if (p.entRiskMean != d.entRiskMean) 'entRiskMean': _d(p.entRiskMean),
    if (p.entRiskSpread != d.entRiskSpread) 'entRiskSpread': _d(p.entRiskSpread),
    if (p.entMinAmbition != d.entMinAmbition) 'entMinAmbition': _d(p.entMinAmbition),
    if (p.entMinTolerance != d.entMinTolerance) 'entMinTolerance': _d(p.entMinTolerance),
    if (p.entCapitalMult != d.entCapitalMult) 'entCapitalMult': _d(p.entCapitalMult),
    if (p.entMinOwnShare != d.entMinOwnShare) 'entMinOwnShare': _d(p.entMinOwnShare),
    if (p.entKnowledgeDays != d.entKnowledgeDays) 'entKnowledgeDays': _d(p.entKnowledgeDays),
    if (p.entSurviveBase != d.entSurviveBase) 'entSurviveBase': _d(p.entSurviveBase),
    if (p.entSurviveKnowledge != d.entSurviveKnowledge) 'entSurviveKnowledge': _d(p.entSurviveKnowledge),
    if (p.prodQualityWeight != d.prodQualityWeight) 'prodQualityWeight': _d(p.prodQualityWeight),
    if (p.prodPriceSens != d.prodPriceSens) 'prodPriceSens': _d(p.prodPriceSens),
    if (p.prodTasteSpread != d.prodTasteSpread) 'prodTasteSpread': _d(p.prodTasteSpread),
    if (p.prodHabit != d.prodHabit) 'prodHabit': _d(p.prodHabit),
    if (p.prodForgetDays != d.prodForgetDays) 'prodForgetDays': p.prodForgetDays,
    if (p.prodKnownMax != d.prodKnownMax) 'prodKnownMax': p.prodKnownMax,
    if (p.prodAdRate != d.prodAdRate) 'prodAdRate': _d(p.prodAdRate),
    if (p.prodWordRate != d.prodWordRate) 'prodWordRate': _d(p.prodWordRate),
    if (p.prodQualityCost != d.prodQualityCost) 'prodQualityCost': _d(p.prodQualityCost),
    if (p.prodMakersMax != d.prodMakersMax) 'prodMakersMax': p.prodMakersMax,
    if (p.prodMakerLearn != d.prodMakerLearn) 'prodMakerLearn': _d(p.prodMakerLearn),
    if (p.prodLoyalty != d.prodLoyalty) 'prodLoyalty': _d(p.prodLoyalty),
    if (p.prodEntryMargin != d.prodEntryMargin) 'prodEntryMargin': _d(p.prodEntryMargin),
    if (p.cardRate != d.cardRate) 'cardRate': _d(p.cardRate),
    if (p.cardMinPct != d.cardMinPct) 'cardMinPct': _d(p.cardMinPct),
    if (p.cardLimitDays != d.cardLimitDays) 'cardLimitDays': _d(p.cardLimitDays),
    if (p.loanRateSpread != d.loanRateSpread) 'loanRateSpread': _d(p.loanRateSpread),
    if (p.loanTermMonths != d.loanTermMonths) 'loanTermMonths': p.loanTermMonths,
    if (p.creditRiskPremium != d.creditRiskPremium) 'creditRiskPremium': _d(p.creditRiskPremium),
    if (p.dsrMax != d.dsrMax) 'dsrMax': _d(p.dsrMax),
    if (p.creditMinScore != d.creditMinScore) 'creditMinScore': p.creditMinScore,
    if (p.bkArrearsDays != d.bkArrearsDays) 'bkArrearsDays': p.bkArrearsDays,
    if (p.bkDebtIncome != d.bkDebtIncome) 'bkDebtIncome': _d(p.bkDebtIncome),
    if (p.bkBanDays != d.bkBanDays) 'bkBanDays': p.bkBanDays,
    if (p.bankTightLoss != d.bankTightLoss) 'bankTightLoss': _d(p.bankTightLoss),
  };
}

Params _paramsFrom(Map j) => Params()
  ..population = j['population'] as int
  ..startWallet = _rd(j['startWallet'])
  ..startWage = _rd(j['startWage'])
  ..markup = _rd(j['markup'])
  ..bufferDays = _rd(j['bufferDays'])
  ..mpcIncome = _rd(j['mpcIncome'])
  ..wealthTargetDays = _rd(j['wealthTargetDays'])
  ..trade = j['trade'] as bool
  ..importMarkup = _rd(j['importMarkup'])
  ..exportDiscount = _rd(j['exportDiscount'])
  ..ubi = _rd(j['ubi'])
  ..priceStep = _rd(j['priceStep'])
  ..wageStep = _rd(j['wageStep'])
  ..priceMaxDaily = _rd(j['priceMaxDaily'])
  ..wageMaxDaily = _rd(j['wageMaxDaily'])
  ..dividendRate = _rd(j['dividendRate'])
  ..invTargetDays = _rd(j['invTargetDays'])
  ..jobSwitch = _rd(j['jobSwitch'])
  ..taxRate = _rd(j['taxRate'])
  ..benefit = _rd(j['benefit'])
  ..minWage = _rd(j['minWage'])
  ..stateRebate = _rd(j['stateRebate'])
  ..interestRate = _rd(j['interestRate'])
  ..loanTermDays = _rd(j['loanTermDays'])
  ..workingCapitalDays = _rd(j['workingCapitalDays'])
  ..exitIdleDays = j['exitIdleDays'] as int
  ..entryCooldown = j['entryCooldown'] as int
  ..entryMinShare = _rd(j['entryMinShare'])
  ..entryMarginRatio = _rd(j['entryMarginRatio'])
  ..depreciation = _rd(j['depreciation'])
  ..maintNeed = _rd(j['maintNeed'])
  ..softInputShare = _rd(j['softInputShare'])
  ..rndShare = _rd(j['rndShare'])
  ..bankRebate = _rd(j['bankRebate'])
  ..bankCapitalPerCitizen = _rd(j['bankCapitalPerCitizen'])
  ..bankTargetRatio = _rd(j['bankTargetRatio'])
  ..riskSpread = _rd(j['riskSpread'])
  ..adsShare = _rd(j['adsShare'])
  ..adsEffect = _rd(j['adsEffect'])
  ..illness = _rd(j['illness'])
  ..eduRate = _rd(j['eduRate'])
  ..learnRate = _rd(j['learnRate'])
  ..computerLife = j['computerLife'] as int
  ..dividendFromRetained = j['dividendFromRetained'] as bool
  ..publicCashDays = _rd(j['publicCashDays'])
  ..eiReplacement = _rd(j['eiReplacement'])
  ..eiInsurableCap = _rd(j['eiInsurableCap'])
  ..eiRate = _rd(j['eiRate'])
  ..eiDaysLow = j['eiDaysLow'] as int
  ..eiDaysHigh = j['eiDaysHigh'] as int
  ..eiQualifyingDays = j['eiQualifyingDays'] as int
  ..healthWearIfDeprived = (j['healthWearIfDeprived'] as bool?) ?? false
  ..partTime = (j['partTime'] as bool?) ?? false
  ..dwellingModules = (j['dwellingModules'] as int?) ?? 10
  ..buildingWearYear = _rdOr(j['buildingWearYear'], 0.04)
  ..buildingMaintShare = _rdOr(j['buildingMaintShare'], 0.75)
  ..maintHoursPerDwelling = _rdOr(j['maintHoursPerDwelling'], 0.012)
  ..ltvHousehold = _rdOr(j['ltvHousehold'], 0.95)
  ..ltvFirm = _rdOr(j['ltvFirm'], 0.70)
  ..mortgageSpreadMax = _rdOr(j['mortgageSpreadMax'], 0.02)
  ..mortgageTermHousehold = (j['mortgageTermHousehold'] as int?) ?? 9125
  ..mortgageTermFirm = (j['mortgageTermFirm'] as int?) ?? 3650
  ..mortgageRiskWeight = _rdOr(j['mortgageRiskWeight'], 0.35)
  ..foreclosureDays = (j['foreclosureDays'] as int?) ?? 60
  ..ownerShare = _rdOr(j['ownerShare'], 0.7)
  ..buyLookChance = _rdOr(j['buyLookChance'], 0.02)
  ..relocateChance = _rdOr(j['relocateChance'], 0.0005)
  ..listingMargin = _rdOr(j['listingMargin'], 0.05)
  ..listingDecay = _rdOr(j['listingDecay'], 0.005)
  ..listingFloor = _rdOr(j['listingFloor'], 0.7)
  ..landlordBuildAbove = _rdOr(j['landlordBuildAbove'], 0.96)
  ..buyRentRatio = _rdOr(j['buyRentRatio'], 1.2)
  ..scenarioPopulation = (j['scenarioPopulation'] as int?) ?? 240
  ..sellerSample = (j['sellerSample'] as int?) ?? 0
  ..reservationDecay = _rdOr(j['reservationDecay'], 0.01)
  ..reservationFloor = _rdOr(j['reservationFloor'], 0)
  ..switchPremium = _rdOr(j['switchPremium'], 0.08)
  ..bargainBase = _rdOr(j['bargainBase'], 0.1)
  ..bargainTrait = _rdOr(j['bargainTrait'], 0.3)
  ..bargainTight = _rdOr(j['bargainTight'], 0.3)
  ..hireRange = _rdOr(j['hireRange'], 0.10)
  ..hireFlexBase = _rdOr(j['hireFlexBase'], 0.05)
  ..hireFlexMax = _rdOr(j['hireFlexMax'], 0.25)
  ..maxInterviews = (j['maxInterviews'] as int?) ?? 3
  ..reviewDays = (j['reviewDays'] as int?) ?? 90
  ..reviewCutMax = _rdOr(j['reviewCutMax'], 1)
  ..seniorityStep = _rdOr(j['seniorityStep'], 0.015)
  ..seniorityCap = _rdOr(j['seniorityCap'], 0.15)
  ..promotionRaise = _rdOr(j['promotionRaise'], 0.05)
  ..entFoundRate = _rdOr(j['entFoundRate'], 1.0)
  ..entConsiderRate = _rdOr(j['entConsiderRate'], 0.001)
  ..entRiskMean = _rdOr(j['entRiskMean'], 0.5)
  ..entRiskSpread = _rdOr(j['entRiskSpread'], 0.5)
  ..entMinAmbition = _rdOr(j['entMinAmbition'], 0.3)
  ..entMinTolerance = _rdOr(j['entMinTolerance'], 0.25)
  ..entCapitalMult = _rdOr(j['entCapitalMult'], 1.0)
  ..entMinOwnShare = _rdOr(j['entMinOwnShare'], 0.3)
  ..entKnowledgeDays = _rdOr(j['entKnowledgeDays'], 365)
  ..entSurviveBase = _rdOr(j['entSurviveBase'], 0.5)
  ..entSurviveKnowledge = _rdOr(j['entSurviveKnowledge'], 0.35)
  ..prodQualityWeight = _rdOr(j['prodQualityWeight'], 1.0)
  ..prodPriceSens = _rdOr(j['prodPriceSens'], 1.0)
  ..prodTasteSpread = _rdOr(j['prodTasteSpread'], 0.5)
  ..prodHabit = _rdOr(j['prodHabit'], 0.15)
  ..prodForgetDays = (j['prodForgetDays'] as int?) ?? 60
  ..prodKnownMax = (j['prodKnownMax'] as int?) ?? 8
  ..prodAdRate = _rdOr(j['prodAdRate'], 0.03)
  ..prodWordRate = _rdOr(j['prodWordRate'], 0.02)
  ..prodQualityCost = _rdOr(j['prodQualityCost'], 0.5)
  ..prodMakersMax = (j['prodMakersMax'] as int?) ?? 3
  ..prodMakerLearn = _rdOr(j['prodMakerLearn'], 0.01)
  ..prodLoyalty = _rdOr(j['prodLoyalty'], 0.1)
  ..prodEntryMargin = _rdOr(j['prodEntryMargin'], 0.15)
  ..cardRate = _rdOr(j['cardRate'], 0.20)
  ..cardMinPct = _rdOr(j['cardMinPct'], 0.03)
  ..cardLimitDays = _rdOr(j['cardLimitDays'], 30)
  ..loanRateSpread = _rdOr(j['loanRateSpread'], 0.04)
  ..loanTermMonths = (j['loanTermMonths'] as int?) ?? 12
  ..creditRiskPremium = _rdOr(j['creditRiskPremium'], 0.10)
  ..dsrMax = _rdOr(j['dsrMax'], 0.40)
  ..creditMinScore = (j['creditMinScore'] as int?) ?? 550
  ..bkArrearsDays = (j['bkArrearsDays'] as int?) ?? 90
  ..bkDebtIncome = _rdOr(j['bkDebtIncome'], 2.0)
  ..bkBanDays = (j['bkBanDays'] as int?) ?? 730
  ..bankTightLoss = _rdOr(j['bankTightLoss'], 0.03);

/// Crédit d'un citoyen (module banking) : écrit seulement s'il diffère de l'état initial.
bool _hasCredit(Citizen c) =>
    c.loans.isNotEmpty || c.card > 0 || c.cardLimit > 0 || c.cardOpened >= 0 || c.arrears > 0 || c.latePayments > 0 ||
    c.bankruptcies > 0 || c.creditBanUntil > 0 || c.bankId != 0 || c.cardInterest > 0;

Map<String, Object?> _creditJson(Citizen c) => {
      'loans': [
        for (final l in c.loans) [l.bankId, _d(l.balance), _d(l.rate), l.months, _d(l.payment), l.start, l.reason]
      ],
      'card': _d(c.card),
      'cardLimit': _d(c.cardLimit),
      'cardInterest': _d(c.cardInterest),
      'cardOpened': c.cardOpened,
      'arrears': _d(c.arrears),
      'arrearsSince': c.arrearsSince,
      'latePayments': c.latePayments,
      'lastLate': c.lastLate,
      'bankruptcies': c.bankruptcies,
      'creditBanUntil': c.creditBanUntil,
      'lastBankruptcy': c.lastBankruptcy,
      'bankId': c.bankId,
    };

void _creditFrom(Citizen c, Map j) {
  for (final l in j['loans'] as List) {
    final x = l as List;
    c.loans.add(PersonalLoan(x[0] as int, _rd(x[1]), _rd(x[2]), x[3] as int, _rd(x[4]), x[5] as int, x[6] as String));
  }
  c
    ..card = _rd(j['card'])
    ..cardLimit = _rd(j['cardLimit'])
    ..cardInterest = _rd(j['cardInterest'])
    ..cardOpened = j['cardOpened'] as int
    ..arrears = _rd(j['arrears'])
    ..arrearsSince = j['arrearsSince'] as int?
    ..latePayments = j['latePayments'] as int
    ..lastLate = j['lastLate'] as int
    ..bankruptcies = j['bankruptcies'] as int
    ..creditBanUntil = j['creditBanUntil'] as int
    ..lastBankruptcy = j['lastBankruptcy'] as String
    ..bankId = j['bankId'] as int;
}

/// Une variété : liste compacte.
List<Object?> _productJson(Product p) => [
      p.id, p.category, p.firmId, p.name, _d(p.quality), p.launched, _d(p.gain), _d(p.durability), p.maker, p.alive,
      p.ended, _d(p.salesEma), p.inStock, p.lastRupture,
    ];

Product _productFrom(List l) => Product(l[0] as int, l[1] as String, l[2] as int, l[3] as String, _rd(l[4]), l[5] as int,
    gain: _rd(l[6]), durability: _rd(l[7]), maker: l[8] as String)
  ..alive = l[9] as bool
  ..ended = l[10] as int?
  ..salesEma = _rd(l[11])
  ..inStock = l[12] as bool
  ..lastRupture = l[13] as int;

Map<String, Object?> _safeguardsJson(Safeguards s) => {
      for (final k in Safeguards.keys) k: s.get(k),
      'famineDays': s.famineDays,
      'shelterDays': s.shelterDays,
      'maxDailyChange': _d(s.maxDailyChange),
      'maxPaymentRatio': _d(s.maxPaymentRatio),
      'minCapitalRatio': _d(s.minCapitalRatio),
    };

Safeguards _safeguardsFrom(Map j) {
  final s = Safeguards();
  for (final k in Safeguards.keys) {
    s.set(k, j[k] as bool);
  }
  return s
    ..famineDays = j['famineDays'] as int
    ..shelterDays = j['shelterDays'] as int
    ..maxDailyChange = _rd(j['maxDailyChange'])
    ..maxPaymentRatio = _rd(j['maxPaymentRatio'])
    ..minCapitalRatio = _rd(j['minCapitalRatio']);
}

Map<String, Object?> _citizenJson(Citizen c) => {
      'id': c.id,
      'name': c.name,
      'money': _d(c.money),
      'employer': c.employer,
      'skill': _d(c.skill),
      'ambition': _d(c.ambition),
      'sat': _dm(c.sat),
      'hungerDays': c.hungerDays,
      'homeless': c.homeless,
      'homelessDays': c.homelessDays,
      'computerDays': c.computerDays,
      'happiness': _d(c.happiness),
      'income': _d(c.income),
      'incomeEma': _d(c.incomeEma),
      'spend': _d(c.spend),
      'daysUnemployed': c.daysUnemployed,
      'careSince': c.careSince,
      'lastWage': _d(c.lastWage),
      'insuredDays': c.insuredDays,
      'eiDaysLeft': c.eiDaysLeft,
      'eiBenefit': _d(c.eiBenefit),
      'schoolSince': c.schoolSince,
      'homeId': c.homeId,
      'wantsToOwn': c.wantsToOwn,
      'hiredDay': c.hiredDay,
      'role': c.role,
      'wage': _d(c.wage),
      'aplomb': _d(c.aplomb),
      if (c.sectorDays.isNotEmpty) 'sectorDays': c.sectorDays,
      if (c.known.isNotEmpty)
        'known': {for (final e in c.known.entries) e.key: {for (final k in e.value.entries) '${k.key}': k.value}},
      if (c.lastChoice.isNotEmpty) 'lastChoice': c.lastChoice,
      if (_hasCredit(c)) 'credit': _creditJson(c),
    };

Citizen _citizenFrom(Map j) {
  final c = Citizen(j['id'] as int, j['name'] as String, _rd(j['money']), _rd(j['skill']), _rd(j['ambition']))
    ..employer = j['employer'] as int?
    ..hungerDays = j['hungerDays'] as int
    ..homeless = j['homeless'] as bool
    ..homelessDays = j['homelessDays'] as int
    ..computerDays = j['computerDays'] as int
    ..happiness = _rd(j['happiness'])
    ..income = _rd(j['income'])
    ..incomeEma = _rd(j['incomeEma'])
    ..spend = _rd(j['spend'])
    ..daysUnemployed = j['daysUnemployed'] as int
    ..careSince = j['careSince'] as int?
    ..lastWage = _rd(j['lastWage'])
    ..insuredDays = j['insuredDays'] as int
    ..eiDaysLeft = j['eiDaysLeft'] as int
    ..eiBenefit = _rd(j['eiBenefit'])
    ..schoolSince = j['schoolSince'] as int?
    ..homeId = j['homeId'] as int?
    ..wantsToOwn = (j['wantsToOwn'] as bool?) ?? false
    ..hiredDay = (j['hiredDay'] as int?) ?? 0
    ..role = (j['role'] as int?) ?? -1
    ..wage = _rdOr(j['wage'], 0)
    ..aplomb = _rdOr(j['aplomb'], 0.5);
  c.sat
    ..clear()
    ..addAll(_rdm(j['sat']));
  if (j['sectorDays'] != null) c.sectorDays.addAll(_rim(j['sectorDays']));
  if (j['known'] != null) {
    for (final e in (j['known'] as Map).entries) {
      c.known[e.key as String] = {for (final k in (e.value as Map).entries) int.parse(k.key as String): k.value as int};
    }
  }
  if (j['lastChoice'] != null) c.lastChoice.addAll(_rim(j['lastChoice']));
  if (j['credit'] != null) _creditFrom(c, j['credit'] as Map);
  return c;
}

Map<String, Object?> _firmJson(Firm f) => {
      'id': f.id,
      'type': f.type,
      'name': f.name,
      'money': _d(f.money),
      'inputs': _dm(f.inputs),
      'outputs': _dm(f.outputs),
      'rate': _d(f.rate),
      'capacity': f.capacity == null ? null : _d(f.capacity!),
      'prodMult': _d(f.prodMult),
      'ownerId': f.ownerId,
      'wage': _d(f.wage),
      'workers': f.workers,
      'vacancies': f.vacancies,
      'unfilledDays': f.unfilledDays,
      'inv': _dm(f.inv),
      'price': _dm(f.price),
      'markup': _dm(f.markup),
      'demandEma': _dm(f.demandEma),
      'sold': _dm(f.sold),
      'produced': _dm(f.produced),
      'unmetShare': _dm(f.unmetShare),
      'unitCostCache': _dm(f.unitCostCache),
      'lockPrice': f.lockPrice,
      'lockWage': f.lockWage,
      'x': _d(f.x),
      'y': _d(f.y),
      'revenue': _d(f.revenue),
      'costs': _d(f.costs),
      'profitEma': _d(f.profitEma),
      'retained': _d(f.retained),
      'revenueEma': _d(f.revenueEma),
      'inputSpendEma': _d(f.inputSpendEma),
      'inputSpend': _d(f.inputSpend),
      'wagesPaid': _d(f.wagesPaid),
      'dividends': _d(f.dividends),
      'lastDistressLog': f.lastDistressLog,
      'lastRecapLog': f.lastRecapLog,
      'lastLoss': f.lastLoss,
      'lastBatches': _d(f.lastBatches),
      'outputEma': _d(f.outputEma),
      'effWorkers': _d(f.effWorkers),
      'inputLimited': f.inputLimited,
      'desired': f.desired,
      'urgency': _d(f.urgency),
      'prevWorkers': f.prevWorkers,
      'machines': _d(f.machines),
      'techLevel': f.techLevel,
      'rndProgress': _d(f.rndProgress),
      'maintCover': _d(f.maintCover),
      'maintToday': _d(f.maintToday),
      'adminCover': _d(f.adminCover),
      'brand': _d(f.brand),
      'overhead': _d(f.overhead),
      'overheadEma': _d(f.overheadEma),
      'lastInvest': f.lastInvest,
      'debt': _d(f.debt),
      'workingDebt': _d(f.workingDebt),
      'interestToday': _d(f.interestToday),
      'missedPayments': f.missedPayments,
      'idleDays': f.idleDays,
      'creditBanUntil': f.creditBanUntil,
      'carry': _d(f.carry),
      'reinvest': _d(f.reinvest),
      'offer': _d(f.offer),
      'talks': [for (final t in f.talks) _talkJson(t)],
      'hist': [for (final p in f.hist) _pointJson(p)],
      if (f.founderId != null) ...{'founderId': f.founderId, 'foundedDay': f.foundedDay, 'startCapital': _d(f.startCapital)},
      if (f.productId != null) 'productId': f.productId,
      if (f.machineGain > 0) 'machineGain': _d(f.machineGain),
      if (f.machineLife > 0) 'machineLife': _d(f.machineLife),
      if (f.knownMakers.isNotEmpty) 'knownMakers': f.knownMakers,
      if (f.supplier != null) 'supplier': f.supplier,
      if (f.bankId != 0) 'bankId': f.bankId,
    };

List<Object?> _talkJson(Talk t) =>
    [t.day, t.citizen, t.name, t.role, t.kind, _d(t.wage), _d(t.reservation), _d(t.offer), _d(t.cap)];

Talk _talkFrom(List l) => Talk(l[0] as int, l[1] as int, l[2] as String, l[3] as int, l[4] as String, _rd(l[5]),
    _rd(l[6]), _rd(l[7]), _rd(l[8]));

List<Object?> _pointJson(FirmPoint p) =>
    [_d(p.money), p.workers, _d(p.price), _d(p.sold), _d(p.profit), _d(p.machines), _d(p.debt)];

Firm _firmFrom(Map j) {
  final f = Firm(
      j['id'] as int,
      j['type'] as String,
      j['name'] as String,
      _rdm(j['inputs']),
      _rdm(j['outputs']),
      _rd(j['rate']),
      _rdn(j['capacity']),
      _rd(j['money']),
      j['ownerId'] as int?,
      _rd(j['wage']),
      _rd(j['x']),
      _rd(j['y']))
    ..prodMult = _rd(j['prodMult'])
    ..vacancies = j['vacancies'] as int
    ..unfilledDays = j['unfilledDays'] as int
    ..sold = _rdm(j['sold'])
    ..produced = _rdm(j['produced'])
    ..unitCostCache = _rdm(j['unitCostCache'])
    ..lockPrice = j['lockPrice'] as bool
    ..lockWage = j['lockWage'] as bool
    ..revenue = _rd(j['revenue'])
    ..costs = _rd(j['costs'])
    ..profitEma = _rd(j['profitEma'])
    ..retained = _rd(j['retained'])
    ..revenueEma = _rd(j['revenueEma'])
    ..inputSpendEma = _rd(j['inputSpendEma'])
    ..inputSpend = _rd(j['inputSpend'])
    ..wagesPaid = _rd(j['wagesPaid'])
    ..dividends = _rd(j['dividends'])
    ..lastDistressLog = j['lastDistressLog'] as int
    ..lastRecapLog = j['lastRecapLog'] as int
    ..lastLoss = (j['lastLoss'] as String?) ?? ''
    ..lastBatches = _rd(j['lastBatches'])
    ..outputEma = _rd(j['outputEma'])
    ..effWorkers = _rd(j['effWorkers'])
    ..inputLimited = j['inputLimited'] as bool
    ..desired = j['desired'] as int
    ..urgency = _rd(j['urgency'])
    ..prevWorkers = j['prevWorkers'] as int
    ..machines = _rd(j['machines'])
    ..techLevel = j['techLevel'] as int
    ..rndProgress = _rd(j['rndProgress'])
    ..maintCover = _rd(j['maintCover'])
    ..maintToday = _rd(j['maintToday'])
    ..adminCover = _rd(j['adminCover'])
    ..brand = _rd(j['brand'])
    ..overhead = _rd(j['overhead'])
    ..overheadEma = _rd(j['overheadEma'])
    ..lastInvest = j['lastInvest'] as int
    ..debt = _rd(j['debt'])
    ..workingDebt = _rd(j['workingDebt'])
    ..interestToday = _rd(j['interestToday'])
    ..missedPayments = j['missedPayments'] as int
    ..idleDays = j['idleDays'] as int
    ..creditBanUntil = j['creditBanUntil'] as int
    ..carry = _rdOr(j['carry'], 0)
    ..reinvest = _rdOr(j['reinvest'], 0)
    ..offer = _rdOr(j['offer'], _rd(j['wage']));
  if (j['founderId'] != null) {
    f
      ..founderId = j['founderId'] as int
      ..foundedDay = (j['foundedDay'] as int?) ?? 0
      ..startCapital = _rdOr(j['startCapital'], 0);
  }
  f
    ..productId = j['productId'] as int?
    ..machineGain = _rdOr(j['machineGain'], 0)
    ..machineLife = _rdOr(j['machineLife'], 0)
    ..supplier = j['supplier'] as int?
    ..bankId = (j['bankId'] as int?) ?? 0;
  if (j['knownMakers'] != null) f.knownMakers.addAll(_ril(j['knownMakers']));
  f.talks.addAll([for (final t in (j['talks'] as List?) ?? const []) _talkFrom(t as List)]);
  f.workers.addAll(_ril(j['workers']));
  f.inv.addAll(_rdm(j['inv']));
  f.price.addAll(_rdm(j['price']));
  f.markup.addAll(_rdm(j['markup']));
  f.demandEma.addAll(_rdm(j['demandEma']));
  f.unmetShare.addAll(_rdm(j['unmetShare']));
  for (final p in j['hist'] as List) {
    final l = p as List;
    f.hist.add(FirmPoint(_rd(l[0]), l[1] as int, _rd(l[2]), _rd(l[3]), _rd(l[4]), _rd(l[5]), _rd(l[6])));
  }
  return f;
}

Map<String, Object?> _histJson(HistPoint h) => {
      'day': h.day,
      'mH': _d(h.mH),
      'mF': _d(h.mF),
      'mE': _d(h.mE),
      'mB': _d(h.mB),
      'total': _d(h.total),
      'unemp': _d(h.unemp),
      'wage': _d(h.wage),
      'gdp': _d(h.gdp),
      'gini': _d(h.gini),
      'need': _d(h.need),
      'happiness': _d(h.happiness),
      'debt': _d(h.debt),
      'machines': _d(h.machines),
      'tech': _d(h.tech),
      'credit': _d(h.credit),
      'cpi': _d(h.cpi),
      'hungry': h.hungry,
      'homeless': h.homeless,
      'pop': h.pop,
      'prices': _dm(h.prices),
      'sat': _dm(h.sat),
      'classes': h.classes,
    };

HistPoint _histFrom(Map j) => HistPoint(
      day: j['day'] as int,
      mH: _rd(j['mH']),
      mF: _rd(j['mF']),
      mE: _rd(j['mE']),
      mB: _rd(j['mB']),
      total: _rd(j['total']),
      unemp: _rd(j['unemp']),
      wage: _rd(j['wage']),
      gdp: _rd(j['gdp']),
      gini: _rd(j['gini']),
      need: _rd(j['need']),
      happiness: _rd(j['happiness']),
      debt: _rd(j['debt']),
      machines: _rd(j['machines']),
      tech: _rd(j['tech']),
      credit: _rd(j['credit']),
      cpi: _rd(j['cpi']),
      hungry: j['hungry'] as int,
      homeless: j['homeless'] as int,
      pop: j['pop'] as int,
      prices: _rdm(j['prices']),
      sat: _rdm(j['sat']),
      classes: _ril(j['classes']),
    );

Map<String, Object?> _flowJson(FlowEdge e) => {'from': e.from, 'to': e.to, 'good': e.good, 'qty': _d(e.qty), 'value': _d(e.value)};
FlowEdge _flowFrom(Map j) => FlowEdge(j['from'] as String, j['to'] as String, j['good'] as String, _rd(j['qty']), _rd(j['value']));

Map<String, Object?> _dayFlowsJson(DayFlows f) => {
      'loans': _d(f.loans),
      'repaid': _d(f.repaid),
      'interest': _d(f.interest),
      'rebates': _d(f.rebates),
      'godPublic': _d(f.godPublic),
      'godBank': _d(f.godBank),
      'exports': _d(f.exports),
      'imports': _d(f.imports),
      'capitalized': _d(f.capitalized),
      'writtenOff': _d(f.writtenOff),
    };

void _dayFlowsLoad(DayFlows f, Map j) {
  f
    ..loans = _rd(j['loans'])
    ..repaid = _rd(j['repaid'])
    ..interest = _rd(j['interest'])
    ..rebates = _rd(j['rebates'])
    ..godPublic = _rd(j['godPublic'])
    ..godBank = _rd(j['godBank'])
    ..exports = _rd(j['exports'])
    ..imports = _rd(j['imports'])
    ..capitalized = _rd(j['capitalized'])
    ..writtenOff = _rd(j['writtenOff']);
}

Map<String, Object?> _serviceJson(ServiceStats s) => {
      'envelopeToday': _d(s.envelopeToday),
      'wantedToday': _d(s.wantedToday),
      'envelopeTotal': _d(s.envelopeTotal),
      'shortDays': s.shortDays,
      'servedToday': s.servedToday,
      'servedTotal': s.servedTotal,
      'servedWait': _d(s.servedWait),
      'queue': s.queue,
      'queueAge': _d(s.queueAge),
    };

ServiceStats _serviceFrom(Map j) => ServiceStats()
  ..envelopeToday = _rd(j['envelopeToday'])
  ..wantedToday = _rd(j['wantedToday'])
  ..envelopeTotal = _rd(j['envelopeTotal'])
  ..shortDays = j['shortDays'] as int
  ..servedToday = j['servedToday'] as int
  ..servedTotal = j['servedTotal'] as int
  ..servedWait = _rd(j['servedWait'])
  ..queue = j['queue'] as int
  ..queueAge = _rd(j['queueAge']);

Map<String, Object?> _netsJson(NetStats n) => {
      'count': n.count,
      'amount': _dm(n.amount),
      'byAgent': n.byAgent,
      'causes': n.causes,
      'today': n.today,
      'causesToday': n.causesToday,
      'log': [for (final e in n.log) [e.day, e.net, e.agent, _d(e.amount), e.reason]],
    };

void _netsLoad(NetStats n, Map j) {
  n.clear();
  n.count.addAll(_rim(j['count']));
  n.amount.addAll(_rdm(j['amount']));
  n.byAgent.addAll(_rimm(j['byAgent']));
  n.causes.addAll(_rimm(j['causes']));
  n.today.addAll(_rim(j['today']));
  n.causesToday.addAll(_rimm(j['causesToday']));
  for (final e in j['log'] as List) {
    final l = e as List;
    n.log.add(NetEvent(l[0] as int, l[1] as String, l[2] as String, _rd(l[3]), l[4] as String));
  }
}

Map<String, Object?> _stateJson(StateAccount st) => {
      'money': _d(st.money),
      'taxes': _d(st.taxes),
      'paid': _d(st.paid),
      'taxesToday': _d(st.taxesToday),
      'paidToday': _d(st.paidToday),
      'healthPaid': _d(st.healthPaid),
      'educationPaid': _d(st.educationPaid),
      'eiPremiums': _d(st.eiPremiums),
      'eiPaid': _d(st.eiPaid),
      'assistPaid': _d(st.assistPaid),
      'eiClaimants': st.eiClaimants,
      'assistRecipients': st.assistRecipients,
      'benefitCut': _d(st.benefitCut),
    };

Map<String, Object?> _bankJson(BankAccount b) => {
      'money': _d(b.money),
      'lent': _d(b.lent),
      'lentMachines': _d(b.lentMachines),
      'lentWorking': _d(b.lentWorking),
      'repaid': _d(b.repaid),
      'interest': _d(b.interest),
      'capitalized': _d(b.capitalized),
      'writtenOff': _d(b.writtenOff),
      'rebates': _d(b.rebates),
      'reserves': _d(b.reserves),
      'equity': _d(b.equity),
      'capital': _d(b.capital),
      'refusals': b.refusals,
    };

/// Hachage FNV-1a 32 bits d'un texte (empreintes de --diff ; outil en ligne de commande seulement : sur le web, le
/// produit dépasserait la précision des nombres JavaScript).
int _fnv(String t) {
  var h = 0x811C9DC5;
  for (final u in t.codeUnits) {
    h = ((h ^ u) * 0x01000193) & 0xFFFFFFFF;
  }
  return h;
}

List<Object?> _buildingJson(Building b) => [
      b.id, b.ownerKind, b.ownerId, b.payee, b.modules, b.done, _d(b.cond), _d(b.basis), b.mortgageId, b.listedDay, b.builtDay,
    ];

Building _buildingFrom(List j) => Building(j[0] as int, j[1] as int, j[2] as int?, j[10] as int)
  ..payee = j[3] as int?
  ..modules = j[4] as int
  ..done = j[5] as bool
  ..cond = _rd(j[6])
  ..basis = _rd(j[7])
  ..mortgageId = j[8] as int?
  ..listedDay = j[9] as int?;

List<Object?> _mortgageJson(Mortgage m) => [
      m.id, m.buildingId, m.borrowerKind, m.borrowerId, _d(m.principal), _d(m.rate), m.termLeft, _d(m.payment), m.missed, m.since,
    ];

Mortgage _mortgageFrom(List j) => Mortgage(
    j[0] as int, j[1] as int, j[2] as int, j[3] as int?, _rd(j[4]), _rd(j[5]), j[6] as int, j[9] as int)
  ..payment = _rd(j[7])
  ..missed = j[8] as int;

extension SimSnapshot on Sim {
  /// Bâtiments, hypothèques et statistiques du parc (module buildings).
  Map<String, Object?> _buildingsState() => {
        'seeded': _buildingsSeeded,
        'nextBuildingId': _nextBuildingId,
        'nextMortgageId': _nextMortgageId,
        'heat': _d(housingHeat),
        'stats': [
          bstats.built, bstats.sales, bstats.foreclosures, bstats.opened, bstats.refused, bstats.abandoned,
          _d(bstats.gains), _d(bstats.losses), _d(bstats.priceEma),
        ],
        'list': [for (final b in buildings) _buildingJson(b)],
        'mortgages': [for (final m in mortgages) _mortgageJson(m)],
      };

  /// L'état complet de la partie, à la fin du jour [day].
  Map<String, dynamic> toSnapshot() => {
        'format': 'econodes-instantane',
        'version': snapshotVersion,
        'seed': seed,
        'day': day,
        'devChecks': devChecks,
        'sansHasard': sansHasard,
        'params': {..._paramsJson(params), ..._entParamsJson(params)},
        'modules': modules.toJson(),
        'safeguards': _safeguardsJson(safeguards),
        'nextCitizenId': _nextCitizenId,
        'firmSeq': _firmSeq,
        'godSeq': _godSeq,
        'ledgerGod': _d(ledgerGod),
        'ledgerImports': _d(ledgerImports),
        'ledgerExports': _d(ledgerExports),
        'ledgerCredit': _d(ledgerCredit),
        'm0': _d(m0),
        'needCost': _d(needCost),
        'avgWage': _d(avgWage),
        'wage0': _d(wage0),
        'adsBoost': _d(adsBoost),
        'householdSpend': _d(householdSpend),
        'firmsCreated': firmsCreated,
        'firmsClosed': firmsClosed,
        if (foundedByYear.isNotEmpty) 'foundedByYear': {for (final e in foundedByYear.entries) '${e.key}': e.value},
        if (closedByYear.isNotEmpty) 'closedByYear': {for (final e in closedByYear.entries) '${e.key}': e.value},
        if (productsActive) 'productsActive': true,
        if (productSeq > 0) 'productSeq': productSeq,
        if (products.isNotEmpty) 'products': [for (final p in products.values) _productJson(p)],
        if (poorEma.isNotEmpty) 'poorEma': _dm(poorEma),
        if (bankingActive) 'bankingActive': true,
        if (consumerLent > 0 || consumerBankruptcies > 0)
          'consumerCredit': [
            _d(consumerLent), _d(consumerWrittenOff), consumerBankruptcies, _d(consumerLossEma), _d(consumerLossToday)
          ],
        'depositsAtCheck': _d(_depositsAtCheck),
        'cpiBase': _d(_cpiBase),
        'cpiWeights': _dm(cpiWeights),
        'worldPrice': _dm(worldPrice),
        'hype': _dm(hype),
        'unmet': _dm(unmet),
        'unmetEma': _dm(unmetEma),
        'lastShortage': lastShortage,
        'lastEntry': _lastEntry,
        'entryFunnel': entryFunnel,
        'lastSeller': {for (final e in lastSeller.entries) '${e.key}': e.value},
        'slots': {for (final e in _slots.entries) e.key: [for (final v in e.value) _d(v)]},
        'nodePos': {for (final e in nodePos.entries) e.key: [for (final v in e.value) _d(v)]},
        'marketStats': {for (final e in marketStats.entries) e.key: [_d(e.value.qty), _d(e.value.value)]},
        'flows': {for (final e in flows.entries) e.key: _flowJson(e.value)},
        'flowsEma': {for (final e in flowsEma.entries) e.key: _flowJson(e.value)},
        'state': _stateJson(state),
        'bank': _bankJson(bank),
        'citizens': [for (final c in citizens) _citizenJson(c)],
        'firms': [for (final f in firms) _firmJson(f)],
        'careQueue': careQueue,
        'schoolQueue': schoolQueue,
        'services': {for (final e in services.entries) e.key: _serviceJson(e.value)},
        'buildings': _buildingsState(),
        'jobsActive': jobsActive,
        'labour': _labourJson(labour),
        'nets': _netsJson(nets),
        'monitor': monitor.toJson(),
        'inv': [_d(inv.money), _d(inv.loans), _d(inv.bank), _d(inv.flows)],
        'dayFlows': _dayFlowsJson(dayFlows),
        'lastFlows': _dayFlowsJson(lastFlows),
        'events': [for (final e in events) [e.day, e.type, e.text]],
        'history': [for (final h in history) _histJson(h)],
      };

  /// Empreintes de l'état à la fin du jour, par partie (pour comparer deux versions du moteur, tool/partie.dart
  /// --diff). Les listes qui ne font que s'allonger (historique, historique des entreprises, journal, déclenchements
  /// des filets) ne comptent que leurs entrées du jour : les précédentes ont été comparées les jours d'avant.
  Map<String, int> digest() {
    String j(Object? v) => jsonEncode(v);
    return {
      'temps': _fnv(j([seed, day, _nextCitizenId, _firmSeq, _godSeq, firmsCreated, firmsClosed])),
      'reglages': _fnv(j([
        {..._paramsJson(params), ..._entParamsJson(params)},
        modules.toJson(),
        _safeguardsJson(safeguards),
      ])),
      'citoyens': _fnv(j([for (final c in citizens) _citizenJson(c)])),
      'entreprises': _fnv(j([for (final f in firms) _firmJson(f)..remove('hist')])),
      'historique_entreprises': _fnv(j([for (final f in firms) if (f.hist.isNotEmpty) _pointJson(f.hist.last)])),
      'etat': _fnv(j(_stateJson(state))),
      'caisse': _fnv(j(_bankJson(bank))),
      'marches': _fnv(j([
        _dm(cpiWeights), _d(_cpiBase), _dm(worldPrice), _dm(hype), _dm(unmet), _dm(unmetEma),
        {for (final e in marketStats.entries) e.key: [_d(e.value.qty), _d(e.value.value)]},
        lastShortage, _lastEntry, _d(needCost), _d(avgWage), _d(wage0), _d(adsBoost), _d(householdSpend),
      ])),
      'flux': _fnv(j([
        {for (final e in flows.entries) e.key: _flowJson(e.value)},
        {for (final e in flowsEma.entries) e.key: _flowJson(e.value)},
      ])),
      'comptes': _fnv(j([
        _d(ledgerGod), _d(ledgerImports), _d(ledgerExports), _d(ledgerCredit), _d(m0), _d(_depositsAtCheck),
        [_d(inv.money), _d(inv.loans), _d(inv.bank), _d(inv.flows)], _dayFlowsJson(dayFlows), _dayFlowsJson(lastFlows),
      ])),
      'services': _fnv(j([
        {for (final e in services.entries) e.key: _serviceJson(e.value)},
        careQueue,
        schoolQueue,
      ])),
      'filets': _fnv(j([
        nets.count, _dm(nets.amount), nets.byAgent, nets.causes,
        [for (final e in nets.log) if (e.day == day) [e.day, e.net, e.agent, _d(e.amount), e.reason]],
      ])),
      if (buildings.isNotEmpty || mortgages.isNotEmpty) 'batiments': _fnv(j(_buildingsState())),
      if (jobsActive) 'travail': _fnv(j(_labourJson(labour))),
      if (products.isNotEmpty) 'produits': _fnv(j([for (final p in products.values) _productJson(p), _dm(poorEma)])),
      'moniteur': _fnv(j(monitor.toJson())),
      'historique': _fnv(j(history.isEmpty ? null : _histJson(history.last))),
      'journal': _fnv(j([for (final e in events) if (e.day == day) [e.day, e.type, e.text]])),
      'positions': _fnv(j([
        {for (final e in nodePos.entries) e.key: [for (final v in e.value) _d(v)]},
        {for (final e in _slots.entries) e.key: [for (final v in e.value) _d(v)]},
      ])),
    };
  }

  /// Remplace l'état de la partie par celui d'un instantané.
  void loadSnapshot(Map<String, dynamic> j) {
    if (j['format'] != 'econodes-instantane') throw const FormatException('Ce fichier n’est pas un instantané ÉcoNodes');
    if (j['version'] != snapshotVersion) {
      throw FormatException('Instantané de version ${j['version']}, ce moteur lit la version $snapshotVersion');
    }
    seed = j['seed'] as int;
    day = j['day'] as int;
    devChecks = j['devChecks'] as bool;
    sansHasard = (j['sansHasard'] as bool?) ?? false;
    params = _paramsFrom(j['params'] as Map);
    modules = Modules();
    for (final e in (j['modules'] as Map).entries) {
      modules.set(e.key as String, e.value as bool);
    }
    safeguards = _safeguardsFrom(j['safeguards'] as Map);
    _nextCitizenId = j['nextCitizenId'] as int;
    _firmSeq
      ..clear()
      ..addAll(_rim(j['firmSeq']));
    _keysDay = -1;
    _buySeq.clear();
    _godSeq = j['godSeq'] as int;
    ledgerGod = _rd(j['ledgerGod']);
    ledgerImports = _rd(j['ledgerImports']);
    ledgerExports = _rd(j['ledgerExports']);
    ledgerCredit = _rd(j['ledgerCredit']);
    m0 = _rd(j['m0']);
    needCost = _rd(j['needCost']);
    avgWage = _rd(j['avgWage']);
    wage0 = _rd(j['wage0']);
    adsBoost = _rd(j['adsBoost']);
    householdSpend = _rd(j['householdSpend']);
    firmsCreated = j['firmsCreated'] as int;
    firmsClosed = j['firmsClosed'] as int;
    foundedByYear
      ..clear()
      ..addAll({for (final e in ((j['foundedByYear'] as Map?) ?? const {}).entries) int.parse(e.key as String): e.value as int});
    productsActive = (j['productsActive'] as bool?) ?? false;
    bankingActive = (j['bankingActive'] as bool?) ?? false;
    final cc = (j['consumerCredit'] as List?) ?? const [0, 0, 0, 0, 0];
    consumerLent = _rd(cc[0]);
    consumerWrittenOff = _rd(cc[1]);
    consumerBankruptcies = cc[2] as int;
    consumerLossEma = _rd(cc[3]);
    consumerLossToday = _rd(cc[4]);
    productSeq = (j['productSeq'] as int?) ?? 0;
    products
      ..clear()
      ..addAll({for (final l in (j['products'] as List?) ?? const []) (l as List)[0] as int: _productFrom(l)});
    poorToday.clear();
    poorEma
      ..clear()
      ..addAll(_rdm(j['poorEma'] ?? const {}));
    closedByYear
      ..clear()
      ..addAll({for (final e in ((j['closedByYear'] as Map?) ?? const {}).entries) int.parse(e.key as String): e.value as int});
    _depositsAtCheck = _rd(j['depositsAtCheck']);
    _cpiBase = _rd(j['cpiBase']);
    cpiWeights = _rdm(j['cpiWeights']);
    worldPrice = _rdm(j['worldPrice']);
    hype = _rdm(j['hype']);
    unmet = _rdm(j['unmet']);
    unmetEma
      ..clear()
      ..addAll(_rdm(j['unmetEma']));
    lastShortage
      ..clear()
      ..addAll(_rim(j['lastShortage']));
    _lastEntry
      ..clear()
      ..addAll(_rim(j['lastEntry']));
    entryFunnel
      ..clear()
      ..addAll(_rim(j['entryFunnel'] ?? const {}));
    lastSeller
      ..clear()
      ..addAll({for (final e in ((j['lastSeller'] as Map?) ?? const {}).entries) int.parse(e.key as String): e.value as int});
    _slots
      ..clear()
      ..addAll({for (final e in (j['slots'] as Map).entries) e.key as String: [for (final v in e.value as List) _rd(v)]});
    nodePos
      ..clear()
      ..addAll({for (final e in (j['nodePos'] as Map).entries) e.key as String: [for (final v in e.value as List) _rd(v)]});
    marketStats.clear();
    for (final e in (j['marketStats'] as Map).entries) {
      final l = e.value as List;
      marketStats[e.key as String] = MarketStat()
        ..qty = _rd(l[0])
        ..value = _rd(l[1]);
    }
    flows = {for (final e in (j['flows'] as Map).entries) e.key as String: _flowFrom(e.value as Map)};
    flowsEma
      ..clear()
      ..addAll({for (final e in (j['flowsEma'] as Map).entries) e.key as String: _flowFrom(e.value as Map)});
    final st = j['state'] as Map;
    state = StateAccount(_rd(st['money']))
      ..taxes = _rd(st['taxes'])
      ..paid = _rd(st['paid'])
      ..taxesToday = _rd(st['taxesToday'])
      ..paidToday = _rd(st['paidToday'])
      ..healthPaid = _rd(st['healthPaid'])
      ..educationPaid = _rd(st['educationPaid'])
      ..eiPremiums = _rd(st['eiPremiums'])
      ..eiPaid = _rd(st['eiPaid'])
      ..assistPaid = _rd(st['assistPaid'])
      ..eiClaimants = st['eiClaimants'] as int
      ..assistRecipients = st['assistRecipients'] as int
      ..benefitCut = _rd(st['benefitCut']);
    final bk = j['bank'] as Map;
    bank = BankAccount(_rd(bk['money']))
      ..lent = _rd(bk['lent'])
      ..lentMachines = _rd(bk['lentMachines'])
      ..lentWorking = _rd(bk['lentWorking'])
      ..repaid = _rd(bk['repaid'])
      ..interest = _rd(bk['interest'])
      ..capitalized = _rd(bk['capitalized'])
      ..writtenOff = _rd(bk['writtenOff'])
      ..rebates = _rd(bk['rebates'])
      ..reserves = _rd(bk['reserves'])
      ..equity = _rd(bk['equity'])
      ..capital = _rd(bk['capital'])
      ..refusals = bk['refusals'] as int;
    citizens = [for (final c in j['citizens'] as List) _citizenFrom(c as Map)];
    _cmap
      ..clear()
      ..addAll({for (final c in citizens) c.id: c});
    firms = [for (final f in j['firms'] as List) _firmFrom(f as Map)];
    usedNames
      ..clear()
      ..addAll([for (final p in products.values) p.name, for (final f in firms) f.name]);
    _fmap
      ..clear()
      ..addAll({for (final f in firms) f.id: f});
    _rebuildSellers();
    careQueue
      ..clear()
      ..addAll(_ril(j['careQueue']));
    schoolQueue
      ..clear()
      ..addAll(_ril(j['schoolQueue']));
    services.clear();
    for (final e in (j['services'] as Map).entries) {
      services[e.key as String] = _serviceFrom(e.value as Map);
    }
    buildings.clear();
    _bmap.clear();
    mortgages.clear();
    _mmap.clear();
    final bj = j['buildings'] as Map?;
    if (bj == null) {
      _nextBuildingId = 1;
      _nextMortgageId = 1;
      _buildingsSeeded = false;
      housingHeat = 0;
      bstats.clear();
    } else {
      _buildingsSeeded = bj['seeded'] as bool;
      _nextBuildingId = bj['nextBuildingId'] as int;
      _nextMortgageId = bj['nextMortgageId'] as int;
      housingHeat = _rd(bj['heat']);
      final st = bj['stats'] as List;
      bstats
        ..built = st[0] as int
        ..sales = st[1] as int
        ..foreclosures = st[2] as int
        ..opened = st[3] as int
        ..refused = st[4] as int
        ..abandoned = st[5] as int
        ..gains = _rd(st[6])
        ..losses = _rd(st[7])
        ..priceEma = _rd(st[8]);
      buildings.addAll([for (final b in bj['list'] as List) _buildingFrom(b as List)]);
      for (final b in buildings) {
        _bmap[b.id] = b;
      }
      mortgages.addAll([for (final m in bj['mortgages'] as List) _mortgageFrom(m as List)]);
      for (final m in mortgages) {
        _mmap[m.id] = m;
      }
    }
    jobsActive = (j['jobsActive'] as bool?) ?? false;
    labour.clear();
    final lj = j['labour'] as Map?;
    if (lj != null) {
      labour.total.addAll(_rim(lj['total']));
      labour.today.addAll(_rim(lj['today']));
      labour.premium = _rd(lj['premium']);
    }
    _netsLoad(nets, j['nets'] as Map);
    monitor.loadJson(j['monitor'] as Map);
    final iv = j['inv'] as List;
    inv
      ..money = _rd(iv[0])
      ..loans = _rd(iv[1])
      ..bank = _rd(iv[2])
      ..flows = _rd(iv[3]);
    _dayFlowsLoad(dayFlows, j['dayFlows'] as Map);
    lastFlows = DayFlows();
    _dayFlowsLoad(lastFlows, j['lastFlows'] as Map);
    events
      ..clear()
      ..addAll([for (final e in j['events'] as List) SimEvent((e as List)[0] as int, e[1] as String, e[2] as String)]);
    history
      ..clear()
      ..addAll([for (final h in j['history'] as List) _histFrom(h as Map)]);
  }
}

/// Une partie reprise depuis un instantané.
Sim simFromSnapshot(Map<String, dynamic> j) {
  final s = Sim(seed: j['seed'] as int); // une partie neuve, aussitôt remplacée
  s.loadSnapshot(j);
  return s;
}
