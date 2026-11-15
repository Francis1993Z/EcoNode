part of 'sim.dart';

// Formation par filières (Params.formation, 2026-11-14). Voir MODELE.md § 6.23 et rapports/formation.md.
//
// - Diplômes. Un citoyen a un niveau de diplôme par filière (fieldKeys) : 0 aucun, 1 technicien, 2 professionnel. Sa
//   qualification dans une filière = diplôme de la filière + talent (la partie fractionnaire de sa qualification de
//   départ, une aptitude qui le suit partout) ; elle remplace la qualification unique dans toutes les règles d'embauche,
//   de promotion, de mobilité et de rendement. Sans le diplôme d'une filière, il n'y tient que les postes de manœuvre.
//   Sa qualification générale (classe, goûts) = son meilleur diplôme + talent.
// - Départ. Au premier matin où le paramètre est actif, chaque technicien ou professionnel reçoit le diplôme de son
//   niveau dans la filière de son employeur (les postes qu'il occupe restent à sa portée : l'économie de départ est la
//   même) ; un sans-emploi, dans une filière tirée au sort selon les pénuries et le nombre de diplômés. Un nouvel
//   arrivant (god mode) reçoit de même, au matin suivant, un diplôme de son niveau dans une filière où l'on en manque.
// - Débouchés. Chaque matin : postes vacants par filière et par niveau (rôle du prochain poste), lissés sur 30 jours ;
//   diplômés disponibles (chômeurs qui cherchent, au niveau ou au-dessus) et étudiants déjà inscrits ; pénurie =
//   max(0, vacants lissés − disponibles − étudiants).
// - Inscription. Chaque jour, un citoyen y songe avec la chance ambition × eduRate (comme avant) ; un chômeur, seulement
//   après eduIdleDays jours sans emploi. Il retient les programmes (filière, niveau) où l'on manque de diplômés, qui
//   paient plus que sa situation (offre moyenne de la classe contre son salaire ou sa prestation) et dont le gain sur
//   eduHorizon jours, moins la durée des études, couvre sa part des frais de cours et, pour un chômeur, la prestation
//   perdue ; il en tire un au sort, au prorata de pénurie × gain.
// - Études. Durée à temps plein : eduTechDays (technicien), eduProDays (professionnel), eduProDays − eduTechDays pour un
//   technicien de la même filière. Un employé suit des cours du soir : chaque jour compte pour 1 ÷ eduNightFactor. Un
//   cours tous les 365 ÷ eduCoursesPerYear jours d'études : à l'école publique (l'élève verse à l'État 1 − eduStateShare
//   du prix de référence), sinon acheté au marché (l'État lui rembourse eduStateShare, au-dessus du plancher du trésor).
//   Faute de cours (école pleine, pas d'argent), les études n'avancent pas ce jour-là.
// - Vivre pendant les études. Un étudiant sans emploi ne touche ni assurance-emploi ni aide sociale : il vit de son
//   épargne et, sous 10 jours de besoins, d'un prêt étudiant (taux eduLoanRate, intérêts capitalisés, aucune échéance
//   avant eduGraceDays jours après le diplôme, plafond eduLoanDays jours de besoins). Sous eduWorkBelow jours de besoins
//   (prêt refusé ou plafonné), il cherche un emploi : il revient au marché du travail (et aux prestations) et, embauché,
//   continue en cours du soir.
// - Aucun argent n'est créé hors du crédit : cours, quote-part et remboursements passent par transfer() ; le prêt crée
//   des dépôts comme tout prêt personnel (banques.dart).

/// Compteurs du module (depuis le début de la partie, ou depuis le chargement d'un instantané : ils n'y sont pas gardés).
class FormationStats {
  /// Diplômes décernés à la fin d'un programme, par filière et niveau.
  final List<List<int>> awarded = [for (var i = 0; i < fieldKeys.length; i++) [0, 0, 0]];
  int enrolFull = 0; // inscriptions à temps plein (chômeurs)
  int enrolNight = 0; // inscriptions en cours du soir (employés)
  int graduations = 0;
  int reconversions = 0; // diplômes dans une filière nouvelle pour un citoyen déjà diplômé ailleurs
  double studyDays = 0; // somme des jours de calendrier des programmes terminés
  int stalledDays = 0; // jours d'études perdus faute de cours (école pleine ou argent manquant)
  double tuitionStudents = 0; // part des cours payée par les élèves
  double tuitionState = 0; // part payée par l'État (cours achetés au marché)
  double loans = 0; // prêts étudiants accordés
  int seekers = 0; // étudiants qui cherchent un emploi (aujourd'hui)
}

extension SimFormation on Sim {
  /// Niveau du diplôme de [c] dans la filière [f].
  int degreeIn(Citizen c, int f) => f < c.degrees.length ? c.degrees[f] : 0;

  /// Qualification de [c] dans la filière [f] (sans le module : sa qualification unique).
  double skillIn(Citizen c, int f) => params.formation && c.degrees.isNotEmpty ? c.degrees[f] + c.talent : c.skill;

  /// Qualification de [c] pour un poste dans une entreprise de type [type].
  double skillFor(Citizen c, String type) => params.formation && c.degrees.isNotEmpty ? skillIn(c, fieldOf(type)) : c.skill;

  /// L'étudiant à temps plein n'est pas sur le marché du travail (ni dans le chômage, ni aux prestations).
  bool studiesFullTime(Citizen c) =>
      params.formation && c.studyField >= 0 && c.employer == null && !c.studySeeksWork;

  /// Sans emploi et en recherche d'emploi (le chômage au sens du moteur).
  bool seeksJob(Citizen c) => c.employer == null && !studiesFullTime(c);

  /// Meilleur diplôme du citoyen.
  int topDegree(Citizen c) {
    var m = 0;
    for (final d in c.degrees) {
      if (d > m) m = d;
    }
    return m;
  }

  /// Durée à temps plein (jours) du programme ([f], [level]) pour ce citoyen.
  int programDays(Citizen c, int f, int level) {
    final p = params;
    if (level >= 2) return degreeIn(c, f) >= 1 ? p.eduProDays - p.eduTechDays : p.eduProDays;
    return p.eduTechDays;
  }

  /// Prix de référence d'un cours : le prix affiché de l'école (publique ou non) la moins chère, sinon le prix indicatif.
  double coursePrice() {
    var best = double.infinity;
    for (final f in sellersOf('cours')) {
      final pr = f.price['cours'];
      if (pr != null && pr > 0 && pr < best) best = pr;
    }
    return best.isFinite ? best : goods['cours']!.guess;
  }

  // ------------------------------------------------------------------ le matin

  /// Diplômes des citoyens qui n'en ont pas encore (départ, nouveaux arrivants), puis tableau des débouchés.
  void _formationMorning() {
    final nf = fieldKeys.length;
    if (!formationReady) {
      formationReady = true;
      fieldVacancies = [for (var i = 0; i < nf; i++) List<double>.filled(3, 0)];
      fieldSupply = [for (var i = 0; i < nf; i++) List<double>.filled(3, 0)];
      fieldShortage = [for (var i = 0; i < nf; i++) List<double>.filled(3, 0)];
      // les employés d'abord : la répartition des sans-emploi suit celle des diplômés
      for (final c in citizens) {
        if (c.degrees.isEmpty && c.employer != null) _initDegrees(c);
      }
    }
    for (final c in citizens) {
      if (c.degrees.isEmpty) _initDegrees(c);
    }
    // postes vacants par filière et niveau : le rôle de chacun des prochains postes
    final vac = [for (var i = 0; i < nf; i++) List<double>.filled(3, 0)];
    for (final f in firms) {
      if (f.vacancies <= 0) continue;
      final fl = fieldOf(f.type);
      if (modules.jobs) {
        final counts = roleCounts(f);
        for (var i = 0; i < f.vacancies; i++) {
          final r = nextSeat(f.type, counts);
          counts[r]++;
          // un poste d'encadrement se pourvoit par promotion interne : il ne fait pas de place à un nouveau diplômé
          if (!roles[f.type]![r].internal) vac[fl][roles[f.type]![r].level]++;
        }
      } else {
        vac[fl][f.template.skill] += f.vacancies;
      }
    }
    final sup = [for (var i = 0; i < nf; i++) List<double>.filled(3, 0)];
    var seekers = 0;
    for (final c in citizens) {
      if (c.studyField >= 0) {
        if (c.studySeeksWork) seekers++;
        for (var l = 1; l <= c.studyLevel; l++) {
          sup[c.studyField][l]++;
        }
      }
      if (!seeksJob(c)) continue;
      for (var f = 0; f < c.degrees.length; f++) {
        for (var l = 1; l <= c.degrees[f]; l++) {
          sup[f][l]++;
        }
      }
    }
    formationStats.seekers = seekers;
    for (var f = 0; f < nf; f++) {
      for (var l = 1; l <= 2; l++) {
        fieldVacancies[f][l] += (vac[f][l] - fieldVacancies[f][l]) / 30;
        fieldSupply[f][l] = sup[f][l];
        final s = fieldVacancies[f][l] - sup[f][l];
        fieldShortage[f][l] = s > 0 ? s : 0;
      }
    }
  }

  /// Diplôme de départ : celui de son niveau dans la filière de son employeur, sinon dans une filière tirée au sort.
  void _initDegrees(Citizen c) {
    c.degrees = List<int>.filled(fieldKeys.length, 0);
    c.talent = math.max(0.0, c.skill - c.level);
    final lvl = c.level;
    if (lvl == 0) return;
    final f = c.employer == null ? null : firm(c.employer!);
    c.degrees[f != null ? fieldOf(f.type) : _pickField(c, lvl)] = lvl;
    c.skill = math.min(3.0, lvl + c.talent);
  }

  /// Filière d'un nouveau diplômé de niveau [level] : tirage au prorata de la pénurie + 0,3 + 0,05 × diplômés du niveau.
  int _pickField(Citizen c, int level) {
    final nf = fieldKeys.length;
    final held = List<double>.filled(nf, 0);
    for (final x in citizens) {
      if (x.degrees.isEmpty) continue;
      for (var f = 0; f < nf; f++) {
        if (x.degrees[f] >= level) held[f]++;
      }
    }
    final w = [
      for (var f = 0; f < nf; f++)
        (fieldShortage.isEmpty ? 0.0 : fieldShortage[f][level]) + 0.3 + 0.05 * held[f],
    ];
    return _roulette(w, draw(Flux.etudes, c.id, 2));
  }

  int _roulette(List<double> w, double u) {
    var tot = 0.0;
    for (final x in w) {
      tot += x;
    }
    var acc = 0.0;
    for (var i = 0; i < w.length; i++) {
      acc += w[i];
      if (u * tot < acc) return i;
    }
    return w.length - 1;
  }

  // ------------------------------------------------------------------ la journée d'un citoyen (pendant la consommation)

  void _studyFormation(Citizen c, double floor) {
    if (c.degrees.isEmpty) return; // arrivé aujourd'hui : diplôme demain matin
    if (c.studyField < 0) _maybeEnrol(c);
    if (c.studyField >= 0) _attend(c, floor);
  }

  /// Salaire de [c] aujourd'hui, ou sa prestation s'il est sans emploi.
  double _currentPay(Citizen c) {
    if (c.employer != null) return modules.jobs ? c.wage : (firm(c.employer!)?.wage ?? 0.0);
    return c.eiDaysLeft > 0 && c.eiBenefit > 0 ? c.eiBenefit : params.benefit;
  }

  void _maybeEnrol(Citizen c) {
    final p = params;
    if (draw(Flux.etudes, c.id) >= c.ambition * p.eduRate) return;
    final employed = c.employer != null;
    if (!employed && c.daysUnemployed < p.eduIdleDays) return;
    final w0 = _currentPay(c);
    final perCourse = (1 - p.eduStateShare) * coursePrice();
    final nf = fieldKeys.length;
    final w = List<double>.filled(2 * nf, 0);
    var any = false;
    for (var f = 0; f < nf; f++) {
      for (var l = 1; l <= 2; l++) {
        if (c.degrees[f] >= l) continue;
        final short = fieldShortage[f][l];
        if (short <= 0) continue;
        final gain = marketOffer(l) - w0;
        if (gain <= 0) continue;
        final full = programDays(c, f, l);
        final span = employed ? full * p.eduNightFactor : full.toDouble();
        final cost = full / 365 * p.eduCoursesPerYear * perCourse + (employed ? 0.0 : full * w0);
        if (gain * (p.eduHorizon - span) <= cost) continue;
        w[2 * f + l - 1] = short * gain;
        any = true;
      }
    }
    if (!any) return;
    final k = _roulette(w, draw(Flux.etudes, c.id, 1));
    final f = k ~/ 2, l = k % 2 + 1;
    c.studyField = f;
    c.studyLevel = l;
    c.studyNeed = programDays(c, f, l).toDouble();
    c.studyDone = 0;
    c.studyCourses = 0;
    c.studyStart = day;
    c.studySeeksWork = false;
    // la place est prise dès aujourd'hui : les suivants du jour voient la pénurie réduite d'autant
    for (var k = 1; k <= l; k++) {
      fieldShortage[f][k] = math.max(0.0, fieldShortage[f][k] - 1);
    }
    if (employed) {
      formationStats.enrolNight++;
    } else {
      formationStats.enrolFull++;
    }
    if (trace != null) {
      _t('travail', 'inscription', c.name, c.id, '${fieldLabels[fieldKeys[f]]} : ${classLabels[l].toLowerCase()}',
          employed ? 'cours du soir' : 'temps plein', c.studyNeed, 'gain ${fmtMoney0(marketOffer(l) - w0)} par jour');
    }
  }

  void _attend(Citizen c, double floor) {
    final p = params;
    final employed = c.employer != null;
    if (!employed) {
      if (c.money < 10 * needCost) _studentLoan(c);
      c.studySeeksWork = c.money < p.eduWorkBelow * needCost;
    } else {
      c.studySeeksWork = false;
    }
    final pace = employed ? 1 / p.eduNightFactor : 1.0;
    if (c.studyCourses >= 1) {
      if (_takeCourse(c, floor)) {
        c.studyCourses -= 1;
      } else {
        formationStats.stalledDays++;
      }
    }
    if (c.studyCourses < 1) {
      c.studyCourses += pace * p.eduCoursesPerYear / 365;
      c.studyDone += pace;
    }
    if (c.studyDone >= c.studyNeed - 1e-9) _graduate(c);
  }

  /// Un cours : à l'école publique (quote-part versée à l'État), sinon au marché (l'État rembourse sa part).
  bool _takeCourse(Citizen c, double floor) {
    final p = params;
    if (publicGood('cours')) {
      final copay = quantize((1 - p.eduStateShare) * coursePrice());
      if (c.money < copay + needCost) return false;
      if (!_takePublic('cours')) {
        unmet['cours'] = (unmet['cours'] ?? 0) + 1; // l'école publique est pleine : son enveloppe le verra
        return false;
      }
      final a = transfer(c, state, copay);
      formationStats.tuitionStudents += a;
      if (a > 0) _flow('M', 'E', '\$frais de scolarité', 1, a);
      return true;
    }
    final pr = quote('cours');
    if (!pr.isFinite) {
      unmet['cours'] = (unmet['cours'] ?? 0) + 1;
      return false;
    }
    if (c.money < pr + needCost) return false;
    final r = buy(c, 'M', 'cours', 1, c.money - needCost, true, forCitizen: c);
    if (r.qty < 1) return false;
    final room = math.max(0.0, state.money - floor);
    final refund = transfer(state, c, math.min(p.eduStateShare * r.spent, room));
    formationStats.tuitionStudents += r.spent - refund;
    formationStats.tuitionState += refund;
    if (refund > 0) {
      state.paid += refund;
      state.paidToday += refund;
      state.educationPaid += refund;
      _flow('E', 'M', '\$éducation publique', 1, refund);
    }
    return true;
  }

  /// Prêt étudiant : 30 jours de besoins à la fois, jusqu'au plafond ; aucune échéance pendant les études.
  void _studentLoan(Citizen c) {
    final p = params;
    if (!bankingActive) return;
    if (day < c.creditBanUntil || c.arrears > 0) return;
    PersonalLoan? sl;
    var owed = 0.0;
    for (final l in c.loans) {
      if (l.student) {
        owed += l.balance;
        if (l.graceUntil > day) sl = l;
      }
    }
    final room = p.eduLoanDays * needCost - owed;
    if (room < needCost) return;
    final amt = quantize(math.min(room, 30 * needCost));
    if (!_consumerCreditOk(c.bankId, amt)) return;
    final a = _lendCitizen(c, amt);
    if (a <= 0) return;
    formationStats.loans += a;
    if (sl != null) {
      sl.balance = quantize(sl.balance + a);
    } else {
      c.loans.add(PersonalLoan(c.bankId, a, p.eduLoanRate, p.loanTermMonths, 0, day, studentLoanReason,
          graceUntil: Sim.studying));
    }
  }

  /// Fin du programme : le diplôme, puis le report des prêts étudiants court jusqu'à eduGraceDays jours d'ici.
  void _graduate(Citizen c) {
    final f = c.studyField, l = c.studyLevel;
    final st = formationStats;
    if (c.degrees[f] == 0 && topDegree(c) > 0) st.reconversions++;
    if (l > c.degrees[f]) c.degrees[f] = l;
    c.skill = math.min(3.0, topDegree(c) + c.talent);
    st.awarded[f][l]++;
    st.graduations++;
    st.studyDays += day - c.studyStart;
    for (final x in c.loans) {
      if (x.student && x.graceUntil == Sim.studying) x.graceUntil = day + params.eduGraceDays;
    }
    if (trace != null) {
      _t('travail', 'diplome', c.name, c.id, '${fieldLabels[fieldKeys[f]]} : ${classLabels[l].toLowerCase()}',
          '${day - c.studyStart} j', c.studyNeed, '');
    }
    c.studyField = -1;
    c.studyLevel = 0;
    c.studyNeed = 0;
    c.studyDone = 0;
    c.studyCourses = 0;
    c.studySeeksWork = false;
    if (c.employer == null) c.daysUnemployed = 0;
  }

  /// Formation accélérée du god mode : un niveau de plus dans la filière de son employeur (sinon sa meilleure).
  void _godDiploma(Citizen c) {
    if (c.degrees.isEmpty) _initDegrees(c);
    var f = -1;
    final e = c.employer == null ? null : firm(c.employer!);
    if (e != null) {
      f = fieldOf(e.type);
    } else {
      for (var i = 0; i < c.degrees.length; i++) {
        if (f < 0 || c.degrees[i] > c.degrees[f]) f = i;
      }
    }
    if (c.degrees[f] < 2) c.degrees[f]++;
    c.skill = math.min(3.0, topDegree(c) + c.talent);
  }

  /// Diplômés par filière et niveau (meilleur diplôme de chaque filière), et étudiants inscrits par filière et niveau.
  ({List<List<int>> holders, List<List<int>> students}) diplomaStock() {
    final nf = fieldKeys.length;
    final h = [for (var i = 0; i < nf; i++) [0, 0, 0]];
    final s = [for (var i = 0; i < nf; i++) [0, 0, 0]];
    for (final c in citizens) {
      for (var f = 0; f < c.degrees.length; f++) {
        if (c.degrees[f] > 0) h[f][c.degrees[f]]++;
      }
      if (c.studyField >= 0) s[c.studyField][c.studyLevel]++;
    }
    return (holders: h, students: s);
  }
}
