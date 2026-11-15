import 'package:flutter/material.dart';

import '../engine/model.dart';
import '../engine/sim.dart';
import 'controller.dart';
import 'format.dart';
import 'palette.dart';
import 'widgets.dart';

/// Onglet Formation (Params.formation, MODELE.md § 6.23) : l'interrupteur, les durées et la politique de financement,
/// puis le stock de diplômés et d'étudiants par filière et par niveau, et ce que le module a produit depuis le début.
class FormationTab extends StatelessWidget {
  final SimController ctrl;
  const FormationTab(this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    final pal = Pal.of(context);
    final sim = ctrl.sim;
    final p = sim.params;
    void upd(void Function() f) {
      f();
      ctrl.touch();
    }

    String years(double d) => '${fmtNum(d / 365, 1)} an${d >= 730 ? 's' : ''} (${fmtNum(d, 0)} j)';

    Widget row(List<String> cells, {bool head = false, Color? color}) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(children: [
            for (var k = 0; k < cells.length; k++)
              Expanded(
                  flex: k == 0 ? 5 : 2,
                  child: Text(cells[k],
                      textAlign: k == 0 ? TextAlign.left : TextAlign.right,
                      style: head
                          ? TextStyle(color: pal.ink3, fontSize: 11, fontWeight: FontWeight.w600)
                          : mono(color ?? pal.ink, 11.5))),
          ]),
        );

    final ready = p.formation && sim.formationReady;
    final stock = ready ? sim.diplomaStock() : null;
    final st = sim.formationStats;
    var studentDebt = 0.0;
    var fullTime = 0, night = 0;
    for (final c in sim.citizens) {
      for (final l in c.loans) {
        if (l.student) studentDebt += l.balance;
      }
      if (c.studyField >= 0) {
        if (c.employer == null) {
          fullTime++;
        } else {
          night++;
        }
      }
    }

    return ListView(padding: const EdgeInsets.all(12), children: [
      Section('Formation par filières', [
        Text(
            'Un diplôme est lié à une filière et à un niveau : technicien ou professionnel. Un poste de technicien ou de '
            'professionnel exige le diplôme de la filière de l’entreprise ; les postes de manœuvre restent ouverts à tous. '
            'Un chômeur étudie à temps plein, sans prestations, en vivant de son épargne et d’un prêt étudiant ; un '
            'employé suit des cours du soir, plus longs. On s’inscrit là où des postes qualifiés restent vacants faute de '
            'diplômés, si le salaire espéré couvre le coût des études.',
            style: TextStyle(color: pal.ink3, fontSize: 11.5, height: 1.35)),
        SwitchListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: const Text('Diplômes par filière', style: TextStyle(fontSize: 13)),
          subtitle: Text(
              'Prend effet au prochain jour : chaque technicien et professionnel reçoit le diplôme de la filière de son '
              'employeur. Coupé : une qualification unique, qui monte d’un cran tous les 50 cours.'
              '${sim.modules.education ? '' : ' Sans études tant que le module « ${Modules.labels['education']} » est coupé.'}',
              style: const TextStyle(fontSize: 11)),
          value: p.formation,
          onChanged: (v) => upd(() => p.formation = v),
        ),
        if (p.formation) ...[
          ParamSlider(
              label: 'Durée d’une formation de technicien',
              value: p.eduTechDays.toDouble(),
              min: 90,
              max: 1460,
              format: years,
              hint: 'À temps plein. 2 ans par défaut.',
              onChanged: (v) => upd(() {
                    p.eduTechDays = (v / 30).round() * 30;
                    if (p.eduProDays < p.eduTechDays) p.eduProDays = p.eduTechDays;
                  })),
          ParamSlider(
              label: 'Durée d’une formation de professionnel',
              value: p.eduProDays.toDouble(),
              min: 180,
              max: 2920,
              format: years,
              hint: 'À temps plein. 4 ans par défaut ; un technicien de la même filière n’en refait que la différence.',
              onChanged: (v) => upd(() => p.eduProDays = ((v / 30).round() * 30).clamp(p.eduTechDays, 2920))),
          ParamSlider(
              label: 'Part des cours payée par l’État',
              value: p.eduStateShare,
              min: 0,
              max: 1,
              format: pct,
              hint: 'Politique publique : l’élève paie le reste du prix des cours.',
              onChanged: (v) => upd(() => p.eduStateShare = (v * 20).round() / 20)),
          ParamSlider(
              label: 'Durée des cours du soir',
              value: p.eduNightFactor,
              min: 1,
              max: 4,
              format: (v) => '× ${fmtNum(v, 1)}',
              hint: 'Un employé qui étudie le soir met ce multiple de la durée à temps plein.',
              onChanged: (v) => upd(() => p.eduNightFactor = (v * 4).round() / 4)),
          ParamSlider(
              label: 'Taux du prêt étudiant',
              value: p.eduLoanRate,
              min: 0,
              max: 0.12,
              format: pct,
              hint: 'Intérêts ajoutés au solde jusqu’à ${p.eduGraceDays} jours après le diplôme, puis remboursement en '
                  '${p.loanTermMonths} mensualités.',
              onChanged: (v) => upd(() => p.eduLoanRate = (v * 400).round() / 400)),
          ParamSlider(
              label: 'Cours par année d’études',
              value: p.eduCoursesPerYear,
              min: 10,
              max: 300,
              format: (v) => fmtNum(v, 0),
              hint: 'Prix de référence d’un cours aujourd’hui : ${money(sim.coursePrice())}.',
              onChanged: (v) => upd(() => p.eduCoursesPerYear = (v / 5).round() * 5)),
        ],
      ]),
      if (stock != null)
        Section('Diplômés et étudiants par filière', [
          row(['Filière', 'Tech.', 'Prof.', 'Étud. tech.', 'Étud. prof.', 'Pénurie'], head: true),
          for (var f = 0; f < fieldKeys.length; f++)
            row([
              fieldLabels[fieldKeys[f]]!,
              '${stock.holders[f][1]}',
              '${stock.holders[f][2]}',
              '${stock.students[f][1]}',
              '${stock.students[f][2]}',
              fmtNum(sim.fieldShortage[f][1] + sim.fieldShortage[f][2], 1),
            ], color: sim.fieldShortage[f][1] + sim.fieldShortage[f][2] >= 1 ? pal.warn : null),
          Divider(height: 10, color: pal.rule),
          row([
            'Total',
            '${stock.holders.fold(0, (a, r) => a + r[1])}',
            '${stock.holders.fold(0, (a, r) => a + r[2])}',
            '${stock.students.fold(0, (a, r) => a + r[1])}',
            '${stock.students.fold(0, (a, r) => a + r[2])}',
            '',
          ]),
          Text(
              'Diplômés : meilleur diplôme de chaque filière (un citoyen peut en avoir plusieurs). Pénurie : postes '
              'qualifiés vacants (moyenne de 30 jours) moins les diplômés qui cherchent un emploi et les étudiants inscrits.',
              style: TextStyle(color: pal.ink3, fontSize: 11, height: 1.35)),
        ]),
      if (ready)
        Section('Études', [
          KV('Étudiants à temps plein', '$fullTime'),
          KV('Étudiants en cours du soir', '$night'),
          KV('Étudiants qui cherchent un emploi', '${st.seekers}'),
          KV('Inscriptions (temps plein / soir)', '${st.enrolFull} / ${st.enrolNight}'),
          KV('Diplômes décernés', '${st.graduations}'),
          KV('Dont reconversions', '${st.reconversions}'),
          KV('Durée moyenne des études', st.graduations > 0 ? years(st.studyDays / st.graduations) : '—'),
          KV('Jours d’études perdus faute de cours', '${st.stalledDays}', color: st.stalledDays > 0 ? pal.warn : null),
          KV('Cours refusés (école pleine)', '${st.stalledFull}'),
          KV('Frais payés par les élèves', money0(st.tuitionStudents)),
          KV('Frais payés par l’État (cours au marché)', money0(st.tuitionState)),
          KV('Prêts étudiants accordés', money0(st.loans)),
          KV('Encours des prêts étudiants', money0(studentDebt)),
          Text('Compteurs depuis le début de la partie (ou le chargement de l’instantané).',
              style: TextStyle(color: pal.ink3, fontSize: 11)),
        ]),
    ]);
  }
}
