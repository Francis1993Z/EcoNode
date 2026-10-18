part of 'sim.dart';

// Rôles, contrats individuels et négociation salariale (module « jobs »). Voir MODELE.md § 6.16 et
// rapports/emplois-negociation.md.
//
// Chaque type d'entreprise a un organigramme (model.dart:roles) : des rôles avec une qualification minimale, une prime
// et une part visée de l'effectif ; les rôles d'encadrement exigent de l'ancienneté et se pourvoient par promotion.
// Chaque employé a un contrat : un rôle, un salaire, une date d'embauche. L'entreprise affiche un salaire pour la
// qualification de son gabarit ([Firm.offer]) ; l'offre d'un rôle s'en déduit (roleRel). Le salaire moyen des contrats
// ([Firm.wage]) est le coût d'un employé dans toutes les règles qui comptent en jours de salaires (embauche, réserve des
// dividendes, mise à pied, fonds de roulement, coût de revient) : elles ne changent pas.
//
// Une journée du marché du travail (étape 1) :
//  1. le salaire minimum relève les contrats qui sont dessous (c'est une loi) ;
//  2. tension par classe : θ = postes ouverts ÷ chômeurs admissibles ;
//  3. rondes d'embauche : à chaque ronde, chaque entreprise qui a des postes ouverts pourvoit le prochain poste de son
//     organigramme (méthode D'Hondt), la mieux payante d'abord. Promotion interne d'abord (l'employé le plus ancien d'un
//     rôle moins payé qui a la qualification et l'ancienneté voulues) ; sinon, entrevues avec les chômeurs admissibles,
//     le moins surqualifié d'abord, au plus maxInterviews. L'offre du rôle est le milieu d'une fourchette de ± hireRange.
//     Négociation : plancher = max(bas de la fourchette, salaire de réserve), plafond = haut de la fourchette majoré
//     d'une souplesse et du bonus de qualification, borné par la valeur ajoutée par employé ; si le plancher dépasse le
//     plafond, le candidat refuse ; sinon salaire = plancher + β × (plafond − plancher) ;
//  4. mobilité : un employé qui regarde ailleurs (flux « depart », chance jobSwitch) reçoit la meilleure offre négociée
//     d'un concurrent qui a un poste ouvert à sa portée ; son employeur, s'il a encore besoin de lui, égale l'offre tant
//     qu'elle reste sous son propre plafond (contre-offre, Postel-Vinay et Robin 2002) ; sinon il part ;
//  5. renouvellement tous les reviewDays jours depuis l'embauche (contrats échelonnés, Taylor 1980) : le salaire est
//     renégocié à l'offre du rôle majorée de l'ancienneté, à la hausse (sauf si l'entreprise perd de l'argent) comme à
//     la baisse (au plus reviewCutMax).
// Les mises à pied suivent l'ancienneté (dernier embauché, premier parti), comme avant le module.
//
// Aucun nouveau flux de hasard pour les décisions : l'aplomb est un trait tiré à la naissance (flux « traits »,
// sous-tirage 7), l'ancienneté de départ vient du flux « anciennete ». Le module ne transfère aucun argent lui-même : la
// paie reste la seule sortie, par transfer(), et les invariants comptables tiennent au bit près.

extension SimJobs on Sim {
  /// Le rôle d'un employé (null sans module, sans employeur ou sans rôle).
  Role? roleOf(Citizen c) {
    if (!modules.jobs || c.role < 0 || c.employer == null) return null;
    final f = firm(c.employer!);
    if (f == null) return null;
    final rs = roles[f.type]!;
    return c.role < rs.length ? rs[c.role] : null;
  }

  /// Effectifs de l'équipe par rôle.
  List<int> roleCounts(Firm f) {
    final counts = List<int>.filled(roles[f.type]!.length, 0);
    for (final id in f.workers) {
      final r = _cmap[id]!.role;
      if (r >= 0 && r < counts.length) counts[r]++;
    }
    return counts;
  }

  /// Rôle du prochain poste de l'entreprise (organigramme, méthode D'Hondt) ; -1 si tous les rôles sont exclus.
  int nextRole(Firm f, [Set<int> skip = const {}]) => nextSeat(f.type, roleCounts(f), skip);

  /// Salaire offert pour un rôle : le salaire affiché de l'entreprise × le rapport du rôle, jamais sous le minimum.
  double roleOffer(Firm f, int r) {
    final w = f.offer * roleRel(f.type, r);
    return w < params.minWage ? params.minWage : w;
  }

  /// Ancienneté chez l'employeur actuel, en jours.
  int tenure(Citizen c) => day - c.hiredDay;

  /// Majoration d'ancienneté : seniorityStep par année complète, au plus seniorityCap.
  double seniorityFactor(Citizen c) {
    final p = params;
    final years = tenure(c) ~/ 365;
    return 1 + math.min(p.seniorityCap, p.seniorityStep * years);
  }

  /// Prestation qu'un sans-emploi touche aujourd'hui : assurance-emploi, aide sociale, ou prestation forfaitaire.
  double benefitNow(Citizen c) =>
      modules.insurance ? (c.eiDaysLeft > 0 ? c.eiBenefit : needCost) : params.benefit;

  /// Salaire de réserve : le salaire brut sous lequel le citoyen refuse une offre.
  /// En emploi : son salaire, plus switchPremium et 1 % par année d'ancienneté qu'il perdrait (au plus 10 %).
  /// Sans emploi : son dernier salaire, qui baisse de reservationDecay par jour de chômage jusqu'à reservationFloor ×
  /// ce salaire, et au moins de quoi gagner 10 % de plus que sa prestation une fois l'impôt et la cotisation payés.
  double reservationWage(Citizen c) {
    final p = params;
    if (c.employer != null) {
      final years = math.min(10, tenure(c) ~/ 365);
      return c.wage * (1 + p.switchPremium + 0.01 * years);
    }
    final keep = 1 - p.taxRate - (modules.insurance ? p.eiRate : 0);
    final floor = math.max(p.minWage, keep > 0.05 ? 1.1 * benefitNow(c) / keep : 0.0);
    final decay = math.max(p.reservationFloor, 1 - p.reservationDecay * c.daysUnemployed);
    return math.max(floor, c.wage * decay);
  }

  /// Valeur ajoutée quotidienne d'un employé : sa production aux prix affichés, moins les intrants au prix du marché.
  /// Null pour un établissement public (gratuit : son plafond ne tient qu'à la souplesse).
  double? valueAddedPerWorker(Firm f) {
    if (publicService(f)) return null;
    var v = 0.0;
    for (final e in f.outputs.entries) {
      v += e.value * (f.price[e.key] ?? 0);
    }
    for (final e in f.inputs.entries) {
      v -= e.value * bestPrice(e.key);
    }
    return perWorker(f) * v;
  }

  /// Bas de la fourchette salariale d'un rôle : le plancher de la négociation (jamais sous le salaire minimum).
  /// Salaire verrouillé (god mode) : l'offre, sans négociation.
  double rangeLow(Firm f, int r) {
    final offer = roleOffer(f, r);
    if (f.lockWage) return offer;
    final w = offer * (1 - params.hireRange);
    return w < params.minWage ? params.minWage : w;
  }

  /// Plafond de l'employeur pour un rôle et un candidat : le haut de la fourchette × (1 + souplesse) × bonus de
  /// qualification (le rendement d'un candidat plus qualifié que le rôle, voir efficiency), jamais plus que l'offre ×
  /// valeur ajoutée par employé ÷ salaire moyen, et jamais moins que le bas de la fourchette. La souplesse croît avec
  /// l'ancienneté des postes vacants (10 j pour le maximum) et la demande non servie. Salaire verrouillé : l'offre.
  double wageCap(Firm f, int r, Citizen c, [double? va]) {
    final p = params;
    final offer = roleOffer(f, r);
    if (f.lockWage) return offer;
    final flex = p.hireFlexBase +
        p.hireFlexMax * (0.6 * math.min(1.0, f.unfilledDays / 10) + 0.4 * math.min(1.0, f.urgency));
    final over = c.skill - roles[f.type]![r].minSkill;
    var cap = offer * (1 + p.hireRange) * (1 + flex) * (1 + 0.05 * math.min(3.0, math.max(0.0, over)));
    final v = va ?? valueAddedPerWorker(f);
    if (v != null) cap = math.min(cap, offer * v / math.max(eps, f.wage));
    return math.max(rangeLow(f, r), cap);
  }

  /// Pouvoir de négociation du candidat : sa part du surplus (Pissarides 2000).
  double bargainPower(Citizen c, double theta) {
    final p = params;
    final b = p.bargainBase + p.bargainTrait * c.aplomb + p.bargainTight * theta / (1 + theta);
    return b < 0.05 ? 0.05 : (b > 0.7 ? 0.7 : b);
  }

  /// Le salaire convenu, ou null si le plancher (bas de la fourchette [low], ou salaire de réserve s'il est plus haut)
  /// dépasse le plafond.
  double? bargain(double low, double reservation, double cap, double beta) {
    final floor = math.max(low, reservation);
    if (floor > cap + 1e-9) return null;
    return floor + beta * (cap - floor);
  }

  /// Le salaire moyen des contrats devient le salaire de l'entreprise (sans employé : l'offre du prochain poste).
  void _syncWage(Firm f) {
    if (!modules.jobs) return;
    final n = f.workers.length;
    if (n == 0) {
      final r = nextRole(f);
      f.wage = r >= 0 ? roleOffer(f, r) : f.offer;
      return;
    }
    var s = 0.0;
    for (final id in f.workers) {
      s += _cmap[id]!.wage;
    }
    f.wage = s / n;
  }

  /// Garde une négociation pour l'affichage, la compte, et l'écrit au journal complet.
  void _talk(Firm f, Citizen c, int r, String kind, double wage, double reservation, double offer, double cap) {
    labour.add(kind);
    f.talks.add(Talk(day, c.id, c.name, r, kind, wage, reservation, offer, cap));
    if (f.talks.length > 12) f.talks.removeAt(0);
    if (trace != null) {
      _t('travail', 'negociation', c.name, c.id, kind, f.name, wage,
          '${r >= 0 ? roles[f.type]![r].label : '—'} ; réserve ${fmtMoney0(reservation)}, offre ${fmtMoney0(offer)}, '
              'plafond ${fmtMoney0(cap)}');
    }
  }

  /// Active ou coupe le module en cours de partie. À l'activation, chaque employé garde son salaire et reçoit le rôle
  /// le plus exigeant à sa portée parmi les postes de l'organigramme de son équipe ; le salaire affiché est fixé pour
  /// que l'offre moyenne de l'organigramme égale le salaire actuel. À la coupure, le salaire moyen devient le salaire
  /// unique de l'entreprise.
  void _jobsSwitch() {
    jobsActive = modules.jobs;
    if (!modules.jobs) {
      for (final c in citizens) {
        c.role = -1;
      }
      return;
    }
    for (final f in firms) {
      f.offer = f.wage / avgRoleRel(f.type);
      final rs = roles[f.type]!;
      final left = List<int>.filled(rs.length, 0);
      for (final r in seatOrder(f.type, f.workers.length)) {
        left[r]++;
      }
      final team = [for (final id in f.workers) _cmap[id]!];
      stableSort<Citizen>(team, (a, b) => b.skill.compareTo(a.skill));
      for (final c in team) {
        int pick(bool quota) {
          var best = -1;
          for (var i = 0; i < rs.length; i++) {
            if (quota && left[i] <= 0) continue;
            if (c.skill + eps < rs[i].minSkill || tenure(c) < rs[i].minTenure) continue;
            if (best < 0 || rs[i].minSkill > rs[best].minSkill ||
                (rs[i].minSkill == rs[best].minSkill && roleRel(f.type, i) > roleRel(f.type, best))) {
              best = i;
            }
          }
          return best;
        }

        var r = pick(true);
        if (r < 0) r = pick(false);
        if (r < 0) r = 0;
        if (left[r] > 0) left[r]--;
        c.role = r;
        c.wage = f.wage;
      }
      _syncWage(f);
    }
    for (final c in citizens) {
      if (c.employer == null) {
        c.role = -1;
        c.wage = c.lastWage;
      }
    }
  }

  /// Candidat admissible le moins surqualifié, hors [skip] (le premier dans l'ordre du jour, à égalité).
  Citizen? _pickCandidate(List<Citizen> pool, double req, Set<int> skip) {
    Citizen? best;
    for (var i = pool.length - 1; i >= 0; i--) {
      final c = pool[i];
      if (c.skill + eps < req || skip.contains(c.id)) continue;
      if (best == null || c.skill <= best.skill) best = c;
    }
    return best;
  }

  /// Promotion interne au rôle [r] : l'employé le plus ancien d'un rôle moins payé qui a la qualification et l'ancienneté
  /// voulues (à égalité, le plus qualifié). Il obtient au moins promotionRaise de plus, et au moins l'offre du rôle.
  bool _promote(Firm f, int r) {
    final rs = roles[f.type]!;
    final role = rs[r];
    final rel = roleRel(f.type, r);
    Citizen? best;
    for (final id in f.workers) {
      final c = _cmap[id]!;
      if (c.role < 0 || c.role == r || roleRel(f.type, c.role) >= rel - 1e-12) continue;
      if (c.skill + eps < role.minSkill || tenure(c) < role.minTenure) continue;
      if (best == null || tenure(c) > tenure(best) || (tenure(c) == tenure(best) && c.skill > best.skill)) best = c;
    }
    if (best == null) return false;
    final offer = roleOffer(f, r);
    final raise = f.lockWage ? best.wage : best.wage * (1 + params.promotionRaise);
    final w = math.max(raise, offer);
    best.role = r;
    best.wage = w;
    _syncWage(f);
    _talk(f, best, r, 'promotion', w, 0, offer, w);
    return true;
  }

  /// Entrevues pour un poste du rôle [r] : au plus maxInterviews candidats, le moins surqualifié d'abord. Rend vrai si
  /// un candidat accepte (il est embauché au salaire négocié).
  bool _interview(Firm f, int r, List<Citizen> unemployed, List<double> theta, Set<int> refused, double? va) {
    final p = params;
    final role = roles[f.type]![r];
    final offer = roleOffer(f, r);
    for (var k = 0; k < p.maxInterviews; k++) {
      final c = _pickCandidate(unemployed, role.minSkill, refused);
      if (c == null) return false;
      final res = reservationWage(c);
      final cap = wageCap(f, r, c, va);
      final w = bargain(rangeLow(f, r), res, cap, bargainPower(c, theta[role.level]));
      if (w == null) {
        refused.add(c.id);
        _talk(f, c, r, 'refus', res, res, offer, cap);
        continue;
      }
      unemployed.remove(c);
      _hire(f, c, 'marché du travail : salaire négocié', r, w);
      labour.premium += w / offer - 1;
      _talk(f, c, r, 'embauche', w, res, offer, cap);
      return true;
    }
    return false;
  }

  /// Le marché du travail du module (étapes 1 à 5 de l'en-tête de ce fichier).
  void _jobMarket() {
    final p = params;
    // 1. salaire minimum
    if (p.minWage > 0) {
      for (final f in firms) {
        var raised = false;
        for (final id in f.workers) {
          final c = _cmap[id]!;
          if (c.wage < p.minWage) {
            c.wage = p.minWage;
            raised = true;
          }
        }
        if (raised) _syncWage(f);
      }
    }
    final unemployed = _ordered(citizens.where((c) => c.employer == null), Flux.embauche, (c) => c.id);
    // 2. tension par classe : postes ouverts (rôles des prochains postes) ÷ chômeurs admissibles
    final open = [0, 0, 0];
    for (final f in firms) {
      if (f.vacancies <= 0) continue;
      final counts = roleCounts(f);
      for (var i = 0; i < f.vacancies; i++) {
        final r = nextSeat(f.type, counts);
        counts[r]++;
        open[roles[f.type]![r].level]++;
      }
    }
    final cand = [0, 0, 0];
    for (final c in unemployed) {
      for (var k = 0; k <= c.level; k++) {
        cand[k]++;
      }
    }
    final theta = [for (var k = 0; k < 3; k++) open[k] / math.max(1, cand[k])];
    final va = <int, double?>{};
    double? vaOf(Firm f) => va.containsKey(f.id) ? va[f.id] : (va[f.id] = valueAddedPerWorker(f));

    // 3. rondes d'embauche
    final hiring = firms.where((f) => f.vacancies > 0).toList();
    final skip = <int, Set<int>>{for (final f in hiring) f.id: <int>{}};
    final refused = <int, Set<int>>{for (final f in hiring) f.id: <int>{}};
    final promos = <int, int>{};
    for (var round = 0; round < 64; round++) {
      final turn = <(Firm, int)>[];
      for (final f in hiring) {
        if (f.vacancies <= 0) continue;
        final r = nextRole(f, skip[f.id]!);
        if (r >= 0) turn.add((f, r));
      }
      if (turn.isEmpty) break;
      // la mieux payante d'abord
      stableSort<(Firm, int)>(turn, (a, b) => roleOffer(b.$1, b.$2).compareTo(roleOffer(a.$1, a.$2)));
      for (final (f, _) in turn) {
        if (f.vacancies <= 0) continue;
        final r = nextRole(f, skip[f.id]!); // relu : une promotion a pu changer les effectifs par rôle
        if (r < 0) continue;
        if ((promos[f.id] ?? 0) < Sim.maxPostsPerDay && _promote(f, r)) {
          promos[f.id] = (promos[f.id] ?? 0) + 1;
          continue; // l'effectif ne change pas : le poste libéré se pourvoit à la ronde suivante
        }
        if (roles[f.type]![r].internal || !_interview(f, r, unemployed, theta, refused[f.id]!, vaOf(f))) {
          skip[f.id]!.add(r); // personne pour ce rôle aujourd'hui
        } else {
          f.vacancies--;
        }
      }
    }
    for (final f in hiring) {
      f.unfilledDays = f.vacancies > 0 ? f.unfilledDays + 1 : 0;
    }

    // 4. mobilité et contre-offres
    final posting = firms.where((f) => f.vacancies > 0).toList();
    if (posting.isNotEmpty) {
      final internal = <String, Set<int>>{};
      Set<int> internalOf(String type) => internal[type] ??= {
            for (var i = 0; i < roles[type]!.length; i++)
              if (roles[type]![i].internal) i,
          };
      for (final c in List<Citizen>.from(citizens)) {
        if (c.employer == null || draw(Flux.depart, c.id) > p.jobSwitch) continue;
        final cur = firm(c.employer!);
        if (cur == null || c.role < 0 || cur.founderId == c.id) continue; // un fondateur ne quitte pas sa propre entreprise
        final res = reservationWage(c);
        Firm? best;
        var bestR = -1;
        var bestW = 0.0, bestOffer = 0.0, bestCap = 0.0;
        for (final b in posting) {
          if (identical(b, cur) || b.vacancies <= 0) continue;
          final r = nextRole(b, internalOf(b.type));
          if (r < 0 || c.skill + eps < roles[b.type]![r].minSkill) continue;
          final offer = roleOffer(b, r);
          final cap = wageCap(b, r, c, vaOf(b));
          final w = bargain(rangeLow(b, r), res, cap, bargainPower(c, theta[roles[b.type]![r].level]));
          if (w != null && w > bestW) {
            best = b;
            bestR = r;
            bestW = w;
            bestOffer = offer;
            bestCap = cap;
          }
        }
        if (best == null) continue;
        // contre-offre : l'employeur qui a encore besoin de lui égale l'offre, jusqu'à son propre plafond
        // (une entreprise qui perd de l'argent ne surenchérit pas)
        final needed = !cur.lockWage && cur.desired >= cur.workers.length && cur.profitEma > 0;
        final keep = needed ? math.max(c.wage, wageCap(cur, c.role, c, vaOf(cur))) : c.wage;
        if (bestW <= keep) {
          _talk(cur, c, c.role, 'contre_offre', bestW, res, c.wage, keep);
          c.wage = bestW;
          _syncWage(cur);
          continue;
        }
        _talk(cur, c, c.role, 'depart', bestW, res, c.wage, keep);
        _hire(best, c, 'mobilité : offre négociée', bestR, bestW);
        best.vacancies--;
        labour.premium += bestW / bestOffer - 1;
        _talk(best, c, bestR, 'embauche', bestW, res, bestOffer, bestCap);
      }
    }

    // 5. renouvellement du contrat, tous les reviewDays jours depuis l'embauche
    final rd = p.reviewDays;
    if (rd > 0) {
      for (final f in firms) {
        if (f.lockWage) continue;
        var changed = false;
        for (final id in f.workers) {
          final c = _cmap[id]!;
          final t = tenure(c);
          if (t <= 0 || t % rd != 0 || c.role < 0) continue;
          final target = roleOffer(f, c.role) * seniorityFactor(c);
          if (target > c.wage + 1e-9 && f.profitEma > 0) {
            _talk(f, c, c.role, 'revision', target, c.wage, roleOffer(f, c.role), target);
            c.wage = target;
            changed = true;
          } else if (target < c.wage - 1e-9 && p.reviewCutMax > 0) {
            final w = math.max(target, c.wage * (1 - p.reviewCutMax));
            _talk(f, c, c.role, 'baisse', w, c.wage, roleOffer(f, c.role), target);
            c.wage = w;
            changed = true;
          }
        }
        if (changed) _syncWage(f);
      }
    }
  }

  /// Salaire affiché moyen des entreprises dont le gabarit exige cette qualification (pondéré par les effectifs).
  double marketOffer(int skill) {
    var s = 0.0, n = 0;
    for (final o in firms) {
      if (o.template.skill != skill) continue;
      s += o.offer * o.workers.length;
      n += o.workers.length;
    }
    return n > 0 ? s / n : params.startWage * classWage[skill];
  }

  /// Ajustement quotidien du salaire affiché (étape 11), avec les règles du salaire unique sans le module : hausse si
  /// des postes restent vacants, légère baisse au chômage élevé, rappel vers la norme du marché, bornes quotidiennes.
  /// Les contrats en cours ne bougent pas : seules les offres des prochains postes changent.
  void _adjustOffer(Firm f, double unemp, List<double> norm) {
    final p = params;
    final old = f.offer;
    var w = old;
    if (f.vacancies > 0 && f.unfilledDays >= 2) {
      w *= 1 + p.wageStep * (1 + 3 * math.min(1.0, f.urgency));
    } else if (f.vacancies == 0 && unemp > 0.08) {
      w *= 1 - p.wageStep * 0.1;
    }
    w += (norm[f.template.skill] - w) * 0.01;
    w = w.clamp(old * (1 - p.wageMaxDaily), old * (1 + p.wageMaxDaily)).toDouble();
    if (w < math.max(1.0, p.minWage)) w = math.max(1.0, p.minWage);
    f.offer = w > p.minWage ? math.max(p.minWage, _capDrift(f, old, w, 'salaire', 'salaire affiché')) : w;
    if (f.workers.isEmpty) _syncWage(f);
  }
}
