// Anatomie d'une crise (anomalie N16), lecture seule : une partie aux réglages de l'interface, suivie de près entre deux
// jours (relevé tous les [pas] jours) : chômage, dépenses et argent des ménages, fermetures par cause, créations, emploi
// par secteur, État, crédit.
//
//   dart run tool/crise.dart graine population début fin [pas] [--produits 0|1] [--param nom=valeur,...]

import 'package:econodes/engine/model.dart';
import 'package:econodes/engine/sim.dart';

import 'emergence.dart' show parametresInterface, regler;

String f1(double v) => v.toStringAsFixed(1);
String f2(double v) => v.toStringAsFixed(2);

void main(List<String> a) {
  final seed = int.parse(a[0]), pop = int.parse(a[1]), from = int.parse(a[2]), to = int.parse(a[3]);
  var step = 25, produits = true;
  final p = parametresInterface(pop);
  for (var i = 4; i < a.length; i++) {
    if (a[i] == '--produits') {
      produits = a[++i] == '1';
    } else if (a[i] == '--param') {
      for (final kv in a[++i].split(',')) {
        final j = kv.indexOf('=');
        regler(p, kv.substring(0, j), kv.substring(j + 1));
      }
    } else {
      step = int.parse(a[i]);
    }
  }
  final s = Sim(
      seed: seed,
      params: p,
      modules: Modules()
        ..jobs = true
        ..entrepreneurship = true
        ..products = produits);
  var closes = <String, int>{};
  var created = 0;
  var spend = 0.0;
  var empl = <String, int>{};
  for (var d = 1; d <= to; d++) {
    s.step();
    spend += s.householdSpend;
    if (d < from - step || (d - from) % step != 0) continue;
    final nowCloses = {
      for (final e in s.entryFunnel.entries)
        if (e.key.startsWith('fermeture_')) e.key.substring(10): e.value
    };
    final dc = {
      for (final k in nowCloses.keys)
        if (nowCloses[k]! - (closes[k] ?? 0) > 0) k: nowCloses[k]! - (closes[k] ?? 0)
    };
    final dCreated = s.firmsCreated - created;
    closes = nowCloses;
    created = s.firmsCreated;
    final byType = <String, int>{};
    for (final f in s.firms) {
      byType[f.type] = (byType[f.type] ?? 0) + f.workers.length;
    }
    final moves = <String>[];
    for (final t in {...byType.keys, ...empl.keys}) {
      final dv = (byType[t] ?? 0) - (empl[t] ?? 0);
      if (dv.abs() >= 8) moves.add('$t ${dv > 0 ? '+' : ''}$dv');
    }
    empl = byType;
    final moneys = [for (final c in s.citizens) c.money]..sort();
    final hh = moneys.fold(0.0, (x, v) => x + v);
    final fm = s.firms.fold(0.0, (x, f) => x + f.money);
    final h = s.history.last;
    if (d < from) {
      spend = 0;
      continue;
    }
    // concentration de l'argent des ménages : part des 1 % et 10 % les plus riches, propriétaires d'entreprise parmi eux,
    // dépense du jour des 10 % les plus riches rapportée à leur argent
    final owners = <int>{for (final f in s.firms) if (f.ownerId != null) f.ownerId!};
    final rich = List<Citizen>.of(s.citizens)..sort((x, y) => y.money.compareTo(x.money));
    final n1 = (rich.length / 100).ceil(), n10 = (rich.length / 10).ceil();
    final top1 = rich.take(n1).fold(0.0, (x, c) => x + c.money), top10 = rich.take(n10).fold(0.0, (x, c) => x + c.money);
    final own10 = rich.take(n10).where((c) => owners.contains(c.id)).length;
    final spend10 = rich.take(n10).fold(0.0, (x, c) => x + c.spend);
    final budget10 = rich.take(n10).fold(0.0, (x, c) => x + s.leisureBudget(c));
    print('     argent des ménages : 1 % les plus riches ${f1(top1 / hh * 100)} %, 10 % ${f1(top10 / hh * 100)} % '
        '(propriétaires d’entreprise $own10/$n10, le plus riche ${f1(rich.first.money / 1000)} k\$) ; dépense du jour des 10 % '
        '${f1(spend10 / 1000)} k\$ pour un budget de loisirs ${f1(budget10 / 1000)} k\$ et ${f2(top10 / 1e6)} M\$ d’argent');
    final top = rich.first;
    final mine = [for (final f in s.firms) if (f.ownerId == top.id) f];
    print('     le plus riche : ${top.name}, ${top.employer != null ? 'salarié' : 'sans emploi'}, revenu du jour '
        '${f1(top.income)} \$, dépense ${f1(top.spend)} \$, budget de loisirs ${f1(s.leisureBudget(top))} \$ ; possède '
        '${mine.map((f) => '${f.type} (${f.workers.length} employés, dividendes cumulés ${f1(f.dividends / 1000)} k\$)').join(', ')}');
    final sector = (byType.entries.toList()..sort((x, y) => y.value.compareTo(x.value))).take(5).map((e) => '${e.key} ${e.value}');
    print('j$d chômage ${f1(h.unemp * 100)} % dépense ${f1(spend / step / 1000)} k\$/j IPC ${f2(h.cpi)} salaire ${f1(h.wage)} ; '
        'ménages ${f2(hh / 1e6)} M (médiane ${f1(moneys[moneys.length ~/ 2])}), entreprises ${f2(fm / 1e6)} M, '
        'État ${f2(s.state.money / 1e6)} M dette ${f2(s.stateDebt / 1e6)} M ; entreprises ${s.firms.length} '
        '(actives ${s.firms.where((f) => f.workers.isNotEmpty).length}), créées $dCreated, fermées $dc ; '
        'affamés ${h.hungry} ; secteurs ${sector.join(', ')} ; mouvements ${moves.join(', ')}');
    spend = 0;
  }
}
