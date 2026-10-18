// Moteur de simulation ÉcoNodes. Un tour = un jour.
// Toute la monnaie passe par transfer() : la masse monétaire ne change que par le god mode,
// le commerce extérieur et le crédit (un prêt de la Caisse crée de la monnaie, un remboursement en détruit).
// Les montants sont des multiples de 2⁻¹⁰ $ : additions et soustractions sont exactes en virgule flottante,
// si bien que les invariants comptables tiennent au bit près (tout écart non nul est un bogue).

import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'model.dart';
import 'monitor.dart';

part 'snapshot.dart';
part 'buildings.dart';
part 'jobs.dart';
part 'entrepreneuriat.dart';
part 'produits.dart';
part 'banques.dart';

/// mulberry32 (arithmétique 32 bits non signée) : même graine, même partie.
class Mulberry32 {
  int _a;
  Mulberry32(int seed) : _a = seed & 0xFFFFFFFF;

  /// Vrai en JavaScript, où 1 et 1.0 sont le même nombre (les entiers y sont des doubles de 53 bits).
  static const bool _web = identical(1, 1.0);

  /// Produit de deux entiers de 32 bits, modulo 2³². Sur la VM, les entiers font 64 bits et le produit de deux entiers de
  /// 32 bits y est exact modulo 2⁶⁴ : un seul produit suffit. En JavaScript, il dépasserait 2⁵³ : on le fait par moitiés
  /// de 16 bits. Les deux voies donnent le même résultat (test hash_test.dart).
  static int _imul(int a, int b) => _web ? imulHalves(a, b) : (a * b) & 0xFFFFFFFF;

  /// Le produit par moitiés de 16 bits (la voie JavaScript), public pour que les tests le comparent à l'autre.
  static int imulHalves(int a, int b) {
    final ah = (a >>> 16) & 0xFFFF, al = a & 0xFFFF;
    final bh = (b >>> 16) & 0xFFFF, bl = b & 0xFFFF;
    return (al * bl + (((ah * bl + al * bh) & 0xFFFF) << 16)) & 0xFFFFFFFF;
  }

  /// Le produit exact modulo 2³² sur la VM (entiers de 64 bits).
  static int imulWide(int a, int b) => (a * b) & 0xFFFFFFFF;

  /// Le premier tirage d'un générateur de graine [seed] : `Mulberry32(seed).next()` sans créer d'objet.
  static double first(int seed) {
    final a = ((seed & 0xFFFFFFFF) + 0x6D2B79F5) & 0xFFFFFFFF;
    var t = a;
    t = _imul(t ^ (t >>> 15), 1 | t);
    t = ((t + _imul(t ^ (t >>> 7), 61 | t)) & 0xFFFFFFFF) ^ t;
    return ((t ^ (t >>> 14)) & 0xFFFFFFFF) / 4294967296.0;
  }

  double next() {
    _a = (_a + 0x6D2B79F5) & 0xFFFFFFFF;
    var t = _a;
    t = _imul(t ^ (t >>> 15), 1 | t);
    t = ((t + _imul(t ^ (t >>> 7), 61 | t)) & 0xFFFFFFFF) ^ t;
    return ((t ^ (t >>> 14)) & 0xFFFFFFFF) / 4294967296.0;
  }
}

/// Mélange deux entiers de 32 bits : une étape de MurmurHash3 (x86, 32 bits) suivie de son brassage final.
/// Même arithmétique que Mulberry32 (masques, multiplication 32 bits en deux moitiés de 16 bits) : le résultat est
/// identique sur la VM (Android, ordinateur) et sur le web, où les entiers Dart sont des nombres JavaScript.
int hash32(int a, int b) {
  var k = Mulberry32._imul(b & 0xFFFFFFFF, 0xCC9E2D51);
  k = ((k << 15) | (k >>> 17)) & 0xFFFFFFFF;
  k = Mulberry32._imul(k, 0x1B873593);
  var h = (a & 0xFFFFFFFF) ^ k;
  h = ((h << 13) | (h >>> 19)) & 0xFFFFFFFF;
  h = (Mulberry32._imul(h, 5) + 0xE6546B64) & 0xFFFFFFFF;
  h ^= h >>> 16;
  h = Mulberry32._imul(h, 0x85EBCA6B);
  h ^= h >>> 13;
  h = Mulberry32._imul(h, 0xC2B2AE35);
  h ^= h >>> 16;
  return h & 0xFFFFFFFF;
}

/// Flux de hasard : un par décision. Un tirage ne dépend que de (graine, flux, jour, agent, sous-tirage), jamais de
/// l'ordre des appels : deux parties qui ne diffèrent que par une règle gardent les mêmes tirages partout ailleurs
/// (nombres aléatoires communs ; Klein et al. 2024, arXiv 2409.02086). Chaque flux a un code fixe : en ajouter un ne
/// change pas les tirages des autres. La création mécanique d'entreprise n'a pas de flux : elle ne tire rien (le fondateur est
/// le citoyen le plus riche) ; avec le module entrepreneurship, c'est le flux `entrepreneuriat`.
enum Flux {
  traits(1), // traits à la naissance : qualification, argent, ambition, ordinateur, nom
  classes(2), // répartition des qualifications au départ
  recrutement(3), // ordre du premier recrutement
  proprietaire(4), // propriétaire d'une entreprise
  embauche(5), // ordre des chômeurs sur le marché du travail
  depart(6), // un employé part pour un meilleur salaire
  maladie(7), // maladie et sa gravité
  ordinateur(8), // envie d'acheter un ordinateur
  etudes(9), // envie de suivre un cours
  loisirs(10), // s'offrir un loisir plus cher que le budget du jour
  consommation(11), // ordre de passage des ménages
  achats(12), // ordre des entreprises pour leurs achats d'intrants et de services
  capital(13), // ordre des entreprises pour l'usure, la dette et l'investissement
  offres(14), // départage des offres à prix voisins
  prix(15), // pas d'ajustement de la marge
  divin(16), // actions du god mode (épidémie)
  logement(17), // bâtiments : état à la naissance, déménagement, regard sur le marché
  vendeurs(18), // recherche limitée : vendeurs examinés par un achat de ménage (Params.sellerSample)
  anciennete(19), // ancienneté des employés au départ de la partie (affichage ; module jobs : promotions, révisions)
  entrepreneuriat(20), // un citoyen examine-t-il aujourd'hui la possibilité de fonder une entreprise (module entrepreneurship)
  qualite(21), // qualité d'une variété à son lancement ; gain et durabilité d'un modèle de machine (module products)
  gouts(22), // goût personnel durable d'un citoyen pour une variété (tiré « au jour 0 » : rien à stocker)
  connaissance(23), // découvertes du jour : vitrine et publicité, bouche-à-oreille, fabricants de machines
  noms(24), // générateur de noms de variétés, de marques et d'entreprises (tiré « au jour 0 »)
  credit(25), // crédit aux particuliers : achat important à crédit (module banking)
  banques(26); // choix d'une banque, fondation d'une banque par un citoyen (module banking)

  const Flux(this.code);
  final int code;
}

/// Tri stable (List.sort de Dart ne l'est pas).
void stableSort<T>(List<T> list, int Function(T a, T b) cmp) {
  final idx = List<int>.generate(list.length, (i) => i);
  final copy = List<T>.from(list);
  idx.sort((i, j) {
    final c = cmp(copy[i], copy[j]);
    return c != 0 ? c : i.compareTo(j);
  });
  for (var k = 0; k < idx.length; k++) {
    list[k] = copy[idx[k]];
  }
}

String fmtMoney0(double v) {
  final r = v.round();
  final neg = r < 0;
  final s = r.abs().toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) b.write(' ');
    b.write(s[i]);
  }
  return '${neg ? '-' : ''}${b.toString()} \$';
}

String fmtPct(double v, [int decimals = 1]) => '${(v * 100).toStringAsFixed(decimals).replaceAll('.', ',')} %';

double round1(double v) => (v * 10).roundToDouble() / 10;

String fmtNum1(double v) => round1(v).toStringAsFixed(1).replaceAll('.', ',');

/// Quantifie un montant au 2⁻¹⁰ $ inférieur : la somme de tels montants est exacte.
double quantize(double v) => (v * 1024).floorToDouble() / 1024;

/// Vendeurs d'un bien triés par prix, pour `Sim.quote` et `Sim.bestPrice` pendant la consommation (voir `_quoteCache`).
class _BestOffers {
  final String good;
  final List<Firm> sellers; // dans l'ordre de Sim.sellersOf
  late final List<double> prices = [for (final f in sellers) f.price[good]!];
  List<double>? _pulls;
  final List<Firm> byPrice;
  late final List<double> sortedPrices = [for (final f in byPrice) f.price[good]!]; // les prix ne changent pas ici
  final double imported; // prix d'importation, ou l'infini
  final double fallback; // plus bas prix affiché, sinon le prix mondial
  int _next = 0; // premier vendeur qui peut encore avoir une unité en stock
  _BestOffers._(this.good, this.sellers, this.byPrice, this.imported, this.fallback);

  /// Attrait de chaque vendeur pour un ménage (la notoriété ne change pas pendant la consommation).
  List<double> householdPulls(Sim s) => _pulls ??= [for (final f in sellers) 1 / (1 + s.brandPull(f))];

  factory _BestOffers(Sim s, String good) {
    final sellers = List<Firm>.of(s.sellersOf(good));
    final list = List<Firm>.of(sellers)..sort((a, b) => a.price[good]!.compareTo(b.price[good]!));
    final p = s.params;
    final g = goods[good]!;
    final imported = p.trade && !g.perish && g.tradable ? s.worldPrice[good]! * p.importMarkup : double.infinity;
    final fallback = list.isEmpty ? s.worldPrice[good]! : list.first.price[good]!;
    return _BestOffers._(good, sellers, list, imported, fallback);
  }

  List<int>? _priceIdx;

  /// Pour chaque vendeur de `byPrice`, sa place dans `sellers` (l'ordre qui départage les égalités de clé).
  List<int> get priceIdx => _priceIdx ??= () {
        final pos = {for (var i = 0; i < sellers.length; i++) sellers[i].id: i};
        return [for (final f in byPrice) pos[f.id]!];
      }();

  double quote() {
    while (_next < byPrice.length && (byPrice[_next].inv[good] ?? 0) < 1 - eps) {
      _next++;
    }
    final best = _next < byPrice.length ? sortedPrices[_next] : double.infinity;
    return math.min(best, imported);
  }

  double bestPrice() {
    final q = quote();
    return q == double.infinity ? fallback : q;
  }

}

/// Toutes les offres d'un achat, tirées et ordonnées : clé croissante, à égalité l'ordre des vendeurs (tri stable). Un
/// achat s'arrête presque toujours après une ou deux offres : les premières sont prises par sélection de la plus petite
/// clé (la première à égalité), le reste n'est trié que s'il en faut plus de 4. L'ordre obtenu est exactement celui du
/// tri stable de toutes les offres (performance).
class _AllOffers {
  final List<_Offer> offers = [];
  late final List<double> keys;
  late final List<bool> used;
  List<int>? rest;

  /// Recherche limitée (Params.sellerSample = k) : seuls k vendeurs tirés dans la liste des vendeurs qui ont du stock
  /// vendable (`Sim._avail`), plus le vendeur du dernier achat (habitude) s'il en a encore, sont examinés. Le coût est
  /// en O(k), pas en nombre de vendeurs. Une liste vide veut dire qu'aucune offre n'existe : seulement alors l'achat
  /// échoue pour cause de « pas d'offre ». Flux « vendeurs », sous-tirage (bien, n-ième achat, essai). Les offres gardent
  /// l'ordre du tirage ; à égalité exacte de clé, la première tirée l'emporte (le hasard des clés rend l'égalité rare).
  _AllOffers.sampled(Sim s, Account buyer, String good, int base, int k, int who, int gi, int n) {
    final a = s._availFor(good);
    final list = a.list;
    final chosen = <Firm>[]; // au plus k + 1 vendeurs : une recherche linéaire suffit pour écarter les doublons
    final habit = Sim.sellerHabit ? s.lastSeller[who * 64 + gi] : null;
    final hi = habit == null ? null : a.pos[habit];
    if (hi != null && !identical(list[hi], buyer)) chosen.add(list[hi]);
    final want = chosen.length + k;
    if (list.length <= want) {
      for (final f in list) {
        if (!identical(f, buyer) && !chosen.contains(f)) chosen.add(f);
      }
    } else {
      final sub0 = hash32(gi, n);
      for (var t = 1; t <= 4 * k && chosen.length < want; t++) {
        final f = list[(s.draw(Flux.vendeurs, who, hash32(sub0, t)) * list.length).floor()];
        if (!identical(f, buyer) && !chosen.contains(f)) chosen.add(f);
      }
      if (chosen.isEmpty) {
        // le tirage n'a trouvé que l'acheteur lui-même (cas dégénéré) : le premier autre vendeur de la liste
        for (final f in list) {
          if (!identical(f, buyer)) {
            chosen.add(f);
            break;
          }
        }
      }
    }
    for (final f in chosen) {
      offers.add(_Offer(f, f.price[good]!, s.sansHasard ? 0.5 : Mulberry32.first(hash32(base, f.id)), 1 / (1 + s.brandPull(f))));
    }
    final p = s.params;
    if (p.trade && !goods[good]!.perish && goods[good]!.tradable) {
      offers.add(
          _Offer(null, s.worldPrice[good]! * p.importMarkup, s.sansHasard ? 0.5 : Mulberry32.first(hash32(base, 0)), 1));
    }
    keys = [for (final o in offers) o.p * (1 + 0.03 * o.r) * o.pull];
    used = List<bool>.filled(offers.length, false);
  }

  /// Offres déjà construites, avec leurs clés (module products : l'opposé de l'utilité de chaque variété).
  _AllOffers.fromOffers(List<_Offer> list, List<double> k) {
    offers.addAll(list);
    keys = k;
    used = List<bool>.filled(offers.length, false);
  }

  _AllOffers(Sim s, Account buyer, String good, int base, bool household, [_BestOffers? cached]) {
    if (cached != null) {
      // mêmes vendeurs, même ordre, mêmes valeurs : seuls les stocks sont relus
      final sellers = cached.sellers, prices = cached.prices, pulls = cached.householdPulls(s);
      for (var i = 0; i < sellers.length; i++) {
        final f = sellers[i];
        if ((f.inv[good] ?? 0) > eps) {
          offers.add(_Offer(f, prices[i], s.sansHasard ? 0.5 : Mulberry32.first(hash32(base, f.id)), pulls[i]));
        }
      }
    } else {
      for (final f in s.sellersOf(good)) {
        if (identical(f, buyer)) continue;
        if ((f.inv[good] ?? 0) > eps) {
          offers.add(_Offer(f, f.price[good]!, s.sansHasard ? 0.5 : Mulberry32.first(hash32(base, f.id)),
              household ? 1 / (1 + s.brandPull(f)) : 1));
        }
      }
    }
    final p = s.params;
    if (p.trade && !goods[good]!.perish && goods[good]!.tradable) {
      offers.add(
          _Offer(null, s.worldPrice[good]! * p.importMarkup, s.sansHasard ? 0.5 : Mulberry32.first(hash32(base, 0)), 1));
    }
    keys = [for (final o in offers) o.p * (1 + 0.03 * o.r) * o.pull];
    used = List<bool>.filled(offers.length, false);
  }

  _Offer? pick(int k) {
    if (k >= offers.length) return null;
    if (k < 4) {
      var m = -1;
      for (var i = 0; i < offers.length; i++) {
        if (!used[i] && (m < 0 || keys[i] - keys[m] < 0)) m = i;
      }
      used[m] = true;
      return offers[m];
    }
    if (rest == null) {
      rest = [for (var i = 0; i < offers.length; i++) if (!used[i]) i];
      stableSort<int>(rest!, (a, b) {
        final d = keys[a] - keys[b];
        return d < 0 ? -1 : (d > 0 ? 1 : 0);
      });
    }
    return offers[rest![k - 4]];
  }
}

/// Les offres d'un achat d'entreprise (attrait 1), dans l'ordre exact de `_AllOffers` (clé croissante, à égalité l'ordre des
/// vendeurs) mais sans construire toutes les offres. La clé d'un vendeur de prix p est dans [p, 1,03 p] : on prend les
/// vendeurs par prix croissant (`_BestOffers.byPrice`) et on ne tire le hasard (r) que de ceux qui peuvent encore passer
/// avant un vendeur non examiné. À très grande échelle (des centaines de vendeurs par bien), c'était le quart d'une
/// journée. Servi seulement pendant les achats d'intrants (prix constants, stocks qui ne font que baisser).
class _LazyOffers {
  final Sim s;
  final _BestOffers bo;
  final Account buyer;
  final String good;
  final int base;
  final List<int> idx;
  int _front = 0;
  bool _import;
  final double _importPrice;
  // tas binaire des offres examinées : clé, place ; offers[i] est l'offre
  final List<double> _keys = [];
  final List<int> _place = [];
  final List<_Offer> _offers = [];

  _LazyOffers(this.s, this.bo, this.buyer, this.good, this.base)
      : idx = bo.priceIdx,
        _import = s.params.trade && !goods[good]!.perish && goods[good]!.tradable,
        _importPrice = s.params.trade && !goods[good]!.perish && goods[good]!.tradable
            ? s.worldPrice[good]! * s.params.importMarkup
            : double.infinity;

  bool _less(int a, int b) => _keys[a] < _keys[b] || (_keys[a] == _keys[b] && _place[a] < _place[b]);

  void _swap(int a, int b) {
    final k = _keys[a], pl = _place[a], o = _offers[a];
    _keys[a] = _keys[b];
    _place[a] = _place[b];
    _offers[a] = _offers[b];
    _keys[b] = k;
    _place[b] = pl;
    _offers[b] = o;
  }

  void _push(double key, int place, _Offer o) {
    _keys.add(key);
    _place.add(place);
    _offers.add(o);
    var i = _keys.length - 1;
    while (i > 0) {
      final up = (i - 1) >> 1;
      if (!_less(i, up)) break;
      _swap(i, up);
      i = up;
    }
  }

  _Offer _pop() {
    final top = _offers[0];
    final last = _keys.length - 1;
    _swap(0, last);
    _keys.removeLast();
    _place.removeLast();
    _offers.removeLast();
    var i = 0;
    for (;;) {
      final l = 2 * i + 1, r = l + 1;
      var m = i;
      if (l < _keys.length && _less(l, m)) m = l;
      if (r < _keys.length && _less(r, m)) m = r;
      if (m == i) break;
      _swap(i, m);
      i = m;
    }
    return top;
  }

  /// L'offre suivante dans l'ordre, ou null quand il n'y en a plus.
  _Offer? next() {
    for (;;) {
      // plus petit prix parmi les vendeurs pas encore examinés (leur clé ne peut pas être plus basse)
      final nextSeller = _front < bo.byPrice.length ? bo.sortedPrices[_front] : double.infinity;
      final lb = _import && _importPrice < nextSeller ? _importPrice : nextSeller;
      if (_keys.isNotEmpty && (lb == double.infinity || _keys[0] < lb)) return _pop();
      if (lb == double.infinity) return null;
      if (_import && _importPrice <= nextSeller) {
        _import = false;
        final r = s.sansHasard ? 0.5 : Mulberry32.first(hash32(base, 0));
        final o = _Offer(null, _importPrice, r, 1);
        _push(o.p * (1 + 0.03 * o.r) * o.pull, 1 << 30, o);
        continue;
      }
      final f = bo.byPrice[_front];
      final place = idx[_front++];
      if (identical(f, buyer) || (f.inv[good] ?? 0) <= eps) continue;
      final r = s.sansHasard ? 0.5 : Mulberry32.first(hash32(base, f.id));
      final o = _Offer(f, f.price[good]!, r, 1);
      _push(o.p * (1 + 0.03 * o.r) * o.pull, place, o);
    }
  }
}

/// Candidats à l'embauche du départ, triés par qualification croissante (à égalité : le dernier de la liste du jour, ou
/// le premier avec le module jobs). `take(req)` rend le candidat admissible (qualification ≥ req, à `eps` près) le moins
/// qualifié et le retire : le même choix que `_pickWorker` ou `_pickCandidate` suivi de `remove`, sans parcourir la liste
/// à chaque poste (à 100 000 citoyens, l'initialisation prenait 50 s dans ces parcours). Les retraits sont des liens
/// vers le candidat suivant, comme dans une structure d'ensembles disjoints.
class _SkillPool {
  final List<Citizen> _sorted;
  final List<double> _skills;
  final List<int> _next; // premier candidat encore là à partir de la place i (n : aucun)
  _SkillPool(List<Citizen> pool, {required bool lowIndexOnTie})
      : _sorted = [],
        _skills = [],
        _next = [] {
    final n = pool.length;
    final order = List<int>.generate(n, (i) => i);
    order.sort((a, b) {
      final d = pool[a].skill.compareTo(pool[b].skill);
      return d != 0 ? d : (lowIndexOnTie ? a - b : b - a);
    });
    for (final i in order) {
      _sorted.add(pool[i]);
      _skills.add(pool[i].skill);
    }
    for (var i = 0; i <= n; i++) {
      _next.add(i);
    }
  }

  int _find(int i) {
    var r = i;
    while (_next[r] != r) {
      r = _next[r];
    }
    while (_next[i] != r) {
      final j = _next[i];
      _next[i] = r;
      i = j;
    }
    return r;
  }

  Citizen? take(double req) {
    final n = _sorted.length;
    var lo = 0, hi = n;
    while (lo < hi) {
      final mid = (lo + hi) >> 1;
      if (_skills[mid] + eps < req) {
        lo = mid + 1;
      } else {
        hi = mid;
      }
    }
    final p = _find(lo);
    if (p >= n) return null;
    _next[p] = p + 1;
    return _sorted[p];
  }
}

/// Les vendeurs d'un bien, en tableaux : prix affiché et « a au moins une unité en stock » de chacun, dans l'ordre de
/// `Sim.sellersOf`. Ils se mettent à jour à chaque changement de stock (`_setStock`) et de prix (`_setPrice`). Le meilleur
/// prix d'un bien (`_quoteAll`) est alors une boucle sur deux tableaux au lieu de deux lectures de table par vendeur
/// (à 100 000 citoyens, un bien a des centaines de vendeurs et ce parcours était le cinquième d'une journée).
class _Book {
  final List<Firm> firms;
  final Float64List price;
  final Uint8List stocked;
  final Map<int, int> pos; // identifiant de l'entreprise -> place
  _Book(this.firms, String good)
      : price = Float64List(firms.length),
        stocked = Uint8List(firms.length),
        pos = {for (var i = 0; i < firms.length; i++) firms[i].id: i} {
    for (var i = 0; i < firms.length; i++) {
      price[i] = firms[i].price[good]!;
      stocked[i] = (firms[i].inv[good] ?? 0) >= 1 - eps ? 1 : 0;
    }
  }
}

/// Vendeurs d'un bien qui ont du stock vendable : tableau, et place de chacun par identifiant (retrait O(1)).
class _Avail {
  final List<Firm> list = [];
  final Map<int, int> pos = {};

  void add(Firm f) {
    pos[f.id] = list.length;
    list.add(f);
  }

  /// Retrait par échange avec le dernier élément.
  void remove(Firm f) {
    final i = pos.remove(f.id)!;
    final last = list.removeLast();
    if (i < list.length) {
      list[i] = last;
      pos[last.id] = i;
    }
  }
}

class _Offer {
  final Firm? firm; // null = extérieur
  final double p;
  final double r;
  final double pull; // < 1 : la publicité rend l'offre plus attirante
  _Offer(this.firm, this.p, this.r, this.pull);
}

/// Plan de départ : prix et effectifs qui équilibrent l'offre et une demande estimée.
class _Plan {
  final Map<String, double> price;
  final Map<String, double> workers; // par type d'entreprise
  final Map<String, double> batches; // par type d'entreprise
  final Map<String, double> machinesPerWorker; // par type d'entreprise
  final double lambda; // part discrétionnaire de la demande retenue
  _Plan(this.price, this.workers, this.batches, this.machinesPerWorker, this.lambda);
}

// Demande quotidienne estimée par citoyen, pour dimensionner l'économie de départ.
const Map<String, double> _basicDemand = {
  'pain': 0.8,
  'viande': 0.25,
  'poisson': 0.15,
  'repas': 0.25,
  'logement': 1,
  'soins': 0.03,
  'cours': 0.12,
  'tele': 0.3,
  // module buildings : remplacement du parc (≈ 1 %/an de 10 modules par logement et 1,06 logement par citoyen)
  'batiment': 0.0004,
};
const Map<String, double> _extraDemand = {
  'tele': 0.5,
  'loisirs': 0.25,
  'repas': 0.25,
  'bijoux': 0.03,
  'hotel': 0.05,
  'voyage': 0.02,
  'ordinateur': 0.003,
};

class Sim {
  late int seed;
  late Params params;
  late Modules modules;
  late Safeguards safeguards;
  bool devChecks; // mode développement : un invariant rompu lève une exception
  // Drapeau de test (tâche 4, cas extrêmes) : tous les tirages valent 0,5 et tous les ordres du jour suivent les
  // identifiants. Jamais actif dans le jeu.
  bool sansHasard = false;
  // Drapeau de vérification (performance) : le chemin rapide (meilleurs prix en cache pendant la consommation) est aussi
  // calculés par le chemin complet, et la moindre différence lève une erreur. Jamais actif dans le jeu.
  bool verifyFastPaths = false;
  int day = 0;
  // identifiants stables, jamais réutilisés : les citoyens sont numérotés à partir de 1 ; une entreprise reçoit
  // 100 000 + 10 000 × (rang de son type) + son rang de création dans ce type (voir _newFirmId)
  int _nextCitizenId = 1;
  final Map<String, int> _firmSeq = {};
  // hasard (voir draw) : clés du jour par flux, achats du jour par (acheteur, bien), actions divines
  int _keysDay = -1;
  final List<int> _dayKeys = List<int>.filled(Flux.values.length, 0);
  final Map<int, int> _buySeq = {};
  int _godSeq = 0;
  List<Citizen> citizens = [];
  final Map<int, Citizen> _cmap = {};
  List<Firm> firms = [];
  final Map<int, Firm> _fmap = {};
  final Map<String, List<Firm>> _sellers = {};
  double ledgerGod = 0;
  double ledgerImports = 0;
  double ledgerExports = 0;
  double ledgerCredit = 0; // monnaie créée par le crédit, nette des remboursements
  final List<SimEvent> events = [];
  final List<HistPoint> history = [];
  Map<String, FlowEdge> flows = {};
  final Map<String, FlowEdge> flowsEma = {};
  Map<String, double> unmet = {};
  final Map<String, MarketStat> marketStats = {};
  final Map<String, int> lastShortage = {};
  final Map<String, double> unmetEma = {}; // demande non servie lissée (~10 jours), par bien
  final Map<String, int> _lastEntry = {}; // dernier jour de création, par type d'entreprise
  /// Entonnoir de création (mesure seulement) : projets envisagés (un type dont le bien a une demande non servie
  /// suffisante, un jour donné), refus par cause, créations ; cumulé depuis le début de la partie.
  final Map<String, int> entryFunnel = {};
  final Map<String, List<double>> _slots = {}; // place laissée dans le graphe par une entreprise fermée, par type
  int firmsCreated = 0;
  int firmsClosed = 0;
  /// Entrepreneuriat : fondations par des citoyens et fermetures, par année de partie (jour ÷ 365). Vides sans le module.
  final Map<int, int> foundedByYear = {};
  final Map<int, int> closedByYear = {};
  /// Variétés de produits (module products) : toutes les variétés, vivantes ou abandonnées (identifiants jamais réutilisés),
  /// la demande faiblement servie par catégorie (du jour, lissée) et les noms déjà pris.
  bool productsActive = false;
  final Map<int, Product> products = {};
  int productSeq = 0;
  final Map<String, double> poorToday = {};
  final Map<String, double> poorEma = {};
  final Set<String> usedNames = {};
  /// Crédit et banques (module banking) : les banques (vide : la Caisse seule), totaux des prêts aux particuliers, pertes
  /// lissées, et caches du jour (dette pondérée au début de la consommation, crédit accordé depuis).
  bool bankingActive = false;
  final List<Bank> banks = [];
  double consumerLent = 0;
  double consumerWrittenOff = 0;
  int consumerBankruptcies = 0;
  double consumerLossEma = 0;
  double consumerLossToday = 0;
  double _creditToday = 0;
  double _debtBase = 0;
  final List<double> tightToday = [];
  final List<int> bankCountHist = []; // banques vivantes, chaque jour (module banking, plusieurs banques)
  int tightDay = -1;
  double householdSpend = 0;
  // positions des nodes spéciaux (ménages, État, Caisse, extérieur) ; l'interface les dispose
  final Map<String, List<double>> nodePos = {
    'M': [1800, 120],
    'E': [1800, 0],
    'B': [1800, 520],
    'X': [1800, 640],
  };
  late StateAccount state;
  late BankAccount bank;
  late Map<String, double> worldPrice;
  late double m0;
  double needCost = 0;
  double avgWage = 0;
  double wage0 = 1; // salaire moyen au départ : base de l'indice des salaires (prix de référence corrigés)
  Map<String, double> hype = {}; // notoriété cumulée des vendeurs de chaque bien
  double adsBoost = 1; // hausse de la dépense des ménages due à la publicité
  // diagnostic
  final NetStats nets = NetStats();
  // services publics gratuits (institution I2) : files d'attente par ordre d'arrivée
  final List<int> careQueue = [];
  final List<int> schoolQueue = [];
  final Map<String, ServiceStats> services = {'soins': ServiceStats(), 'cours': ServiceStats()};
  final Monitor monitor = Monitor();
  // bâtiments et hypothèques (module buildings, voir buildings.dart)
  final List<Building> buildings = [];
  final Map<int, Building> _bmap = {};
  final List<Mortgage> mortgages = [];
  final Map<int, Mortgage> _mmap = {};
  int _nextBuildingId = 1;
  int _nextMortgageId = 1;
  bool _buildingsSeeded = false;
  double housingHeat = 0; // −1 : logements vacants en abondance ; +1 : marché serré
  final BuildingStats bstats = BuildingStats();
  // rôles, contrats et négociation (module jobs, voir jobs.dart) : contrats en place, compteurs du marché du travail
  bool jobsActive = false;
  final LabourStats labour = LabourStats();
  final Invariants inv = Invariants();
  final DayFlows dayFlows = DayFlows(); // flux depuis la dernière vérification
  DayFlows lastFlows = DayFlows(); // flux de la dernière journée vérifiée
  double _depositsAtCheck = 0;
  Map<String, double> cpiWeights = {}; // panier par citoyen pour l'indice des prix
  double _cpiBase = 1;
  // Journal complet (outil en ligne de commande, trace.dart) : reçoit chaque événement ; null dans l'interface. Il ne
  // change aucun calcul : chaque appel est gardé par « trace != null », les textes ne sont construits que s'il écoute.
  void Function(TraceEvent e)? trace;

  void _t(String category, String type, String agent, int? id, String rule, String cause, double amount,
      [String detail = '']) {
    trace!(TraceEvent(day, category, type, agent, id, rule, cause, amount, detail));
  }

  Sim(
      {int seed = 42,
      Params? params,
      List<ScenarioFirm>? scenario,
      Modules? modules,
      Safeguards? safeguards,
      this.devChecks = false}) {
    reset(seed: seed, params: params, scenario: scenario, modules: modules, safeguards: safeguards);
  }

  /// Clé du jour d'un flux : hachage de (graine, flux, jour).
  int _dayKey(Flux f) {
    if (_keysDay != day) {
      for (final x in Flux.values) {
        _dayKeys[x.index] = hash32(hash32(seed & 0xFFFFFFFF, x.code), day);
      }
      _keysDay = day;
    }
    return _dayKeys[f.index];
  }

  /// Tirage uniforme dans [0, 1) qui ne dépend que de (graine, flux, jour, agent, sous-tirage), jamais de l'ordre des
  /// appels. Le sous-tirage distingue plusieurs tirages d'une même décision, pour un même agent, le même jour.
  double draw(Flux flux, int id, [int sub = 0]) {
    if (sansHasard) return 0.5;
    var h = hash32(_dayKey(flux), id);
    if (sub != 0) h = hash32(h, sub);
    return Mulberry32.first(h);
  }

  /// Clé d'ordre du jour d'un agent dans un flux.
  int orderKey(Flux flux, int id) => sansHasard ? 0 : hash32(_dayKey(flux), id);

  /// Les agents rangés selon leur clé d'ordre du jour (égalités départagées par l'identifiant). Retirer un agent ne
  /// change pas l'ordre relatif des autres ; le mélange de Fisher-Yates qu'il remplace consommait un nombre de tirages
  /// variable, ce qui décalait tous les tirages suivants de la partie.
  List<T> _ordered<T>(Iterable<T> items, Flux flux, int Function(T) id) {
    final keyed = [for (final x in items) (orderKey(flux, id(x)), id(x), x)];
    keyed.sort((a, b) => a.$1 != b.$1 ? a.$1.compareTo(b.$1) : a.$2.compareTo(b.$2));
    return [for (final k in keyed) k.$3];
  }

  static final Map<String, int> _goodIndex = {for (final (i, g) in goods.keys.indexed) g: i};
  static final Map<String, int> _typeIndex = {for (final (i, t) in templates.keys.indexed) t: i};

  /// Identifiant d'un compte acheteur pour les tirages : citoyen, entreprise, ou 0 pour l'État.
  int _accountId(Account a) => a is Citizen ? a.id : (a is Firm ? a.id : 0);

  // ================================================================== Setup
  void reset(
      {int seed = 42, Params? params, List<ScenarioFirm>? scenario, Modules? modules, Safeguards? safeguards}) {
    this.seed = seed;
    this.params = params ?? Params();
    this.modules = modules ?? Modules();
    this.safeguards = safeguards ?? Safeguards();
    day = 0;
    _nextCitizenId = 1;
    _firmSeq.clear();
    _keysDay = -1;
    _buySeq.clear();
    _godSeq = 0;
    citizens = [];
    _cmap.clear();
    firms = [];
    _fmap.clear();
    _sellers.clear();
    ledgerGod = 0;
    ledgerImports = 0;
    ledgerExports = 0;
    ledgerCredit = 0;
    events.clear();
    history.clear();
    flows = {};
    flowsEma.clear();
    unmet = {};
    marketStats.clear();
    lastShortage.clear();
    unmetEma.clear();
    _lastEntry.clear();
    entryFunnel.clear();
    lastSeller.clear();
    _slots.clear();
    firmsCreated = 0;
    firmsClosed = 0;
    foundedByYear.clear();
    closedByYear.clear();
    productsActive = false;
    products.clear();
    productSeq = 0;
    poorToday.clear();
    poorEma.clear();
    usedNames.clear();
    bankingActive = false;
    banks.clear();
    consumerLent = 0;
    consumerWrittenOff = 0;
    consumerBankruptcies = 0;
    consumerLossEma = 0;
    consumerLossToday = 0;
    _creditToday = 0;
    _debtBase = 0;
    tightToday.clear();
    tightDay = -1;
    bankCountHist.clear();
    householdSpend = 0;
    hype = {};
    adsBoost = 1;
    nets.clear();
    careQueue.clear();
    schoolQueue.clear();
    services['soins'] = ServiceStats();
    services['cours'] = ServiceStats();
    monitor.clear();
    buildings.clear();
    _bmap.clear();
    mortgages.clear();
    _mmap.clear();
    _nextBuildingId = 1;
    _nextMortgageId = 1;
    _buildingsSeeded = false;
    housingHeat = 0;
    bstats.clear();
    jobsActive = false;
    labour.clear();
    dayFlows.reset();
    lastFlows = DayFlows();
    final p = this.params;
    state = StateAccount(250.0 * p.population);
    bank = BankAccount(quantize(p.bankCapitalPerCitizen * p.population));
    bank.capital = bank.money;
    for (final g in goods.keys) {
      marketStats[g] = MarketStat();
    }

    // le scénario par défaut suit la taille de la population (une seule copie jusqu'à 1,5 × scenarioPopulation)
    final copies = scenario == null ? math.max(1, (p.population / p.scenarioPopulation).round()) : 1;
    final full = <ScenarioFirm>[
      ...(scenario ??
          [
            for (var k = 1; k <= copies; k++)
              for (final s in defaultScenario) k == 1 ? s : ScenarioFirm(s.type, '${s.name} $k'),
          ]),
    ];
    // module buildings : l'entreprise de construction fait partie du scénario ; elle n'est créée que si elle a une demande
    if (this.modules.buildings && !full.any((s) => s.type == 'construction')) {
      full.add(const ScenarioFirm('construction', 'Construction Pelletier'));
    }
    final perType = <String, int>{};
    for (final s in full) {
      perType[s.type] = (perType[s.type] ?? 0) + 1;
    }
    final plan = _plan(p, full, perType);
    // une entreprise dont le produit n'a aucune demande (module coupé) n'est pas créée
    final scen = full.where((s) => plan.batches[s.type]! > 1e-6).toList();
    worldPrice = Map<String, double>.from(plan.price);
    cpiWeights = {
      for (final g in householdGoods)
        if ((_basicDemand[g] ?? 0) + plan.lambda * (_extraDemand[g] ?? 0) > 0)
          g: (_basicDemand[g] ?? 0) + plan.lambda * (_extraDemand[g] ?? 0),
    };
    if (!this.modules.health) cpiWeights.remove('soins');
    if (!this.modules.education) cpiWeights.remove('cours');
    // un service public gratuit n'est pas un prix payé par les ménages
    for (final g in const ['soins', 'cours']) {
      if (publicGood(g)) cpiWeights.remove(g);
    }
    _cpiBase = 0;
    for (final e in cpiWeights.entries) {
      _cpiBase += e.value * plan.price[e.key]!;
    }

    // effectifs par entreprise, et qualifications à prévoir pour les pourvoir
    final staff = <int>[];
    final needByClass = [0, 0, 0];
    for (final s in scen) {
      final w = math.max(1, (plan.workers[s.type]! / perType[s.type]!).round());
      staff.add(w);
      if (this.modules.jobs) {
        for (final r in seatOrder(s.type, w)) {
          needByClass[roles[s.type]![r].level]++;
        }
      } else {
        needByClass[templates[s.type]!.skill] += w;
      }
    }
    final pop = p.population;
    final pros = math.min(pop, (needByClass[2] * 1.15).ceil() + 1);
    final techs = math.min(pop - pros, (needByClass[1] * 1.1).ceil() + 1);
    final levels = <int>[for (var i = 0; i < pop; i++) i < pros ? 2 : (i < pros + techs ? 1 : 0)];
    // répartition des qualifications : les rangs sont rangés selon le hachage de l'identifiant à venir (i + 1)
    final ranks = _ordered(List<int>.generate(pop, (i) => i), Flux.classes, (i) => i + 1);
    final levelOf = List<int>.filled(pop, 0);
    for (var j = 0; j < pop; j++) {
      levelOf[ranks[j]] = levels[j];
    }
    for (var i = 0; i < pop; i++) {
      _newCitizen(level: levelOf[i]);
    }

    final created = <Firm>[];
    for (final s in scen) {
      final f = _newFirm(s.type, s.name, 0, null, 0, 0, plan.price);
      // échelle minimale : si la demande n'occupe pas un employé à plein temps, la petite production est moins productive
      f.rate = f.template.rate * _minScale(plan.workers[s.type]!, perType[s.type]!);
      created.add(f);
    }
    // les postes les plus qualifiés d'abord, chacun pris par le candidat le moins surqualifié
    // les candidats, triés par qualification : chaque poste prend le moins surqualifié sans parcourir toute la liste
    final pool = _SkillPool(_ordered(citizens, Flux.recrutement, (c) => c.id), lowIndexOnTie: this.modules.jobs);
    if (this.modules.jobs) {
      // module jobs : chaque poste de l'organigramme de chaque entreprise, les plus exigeants d'abord, à l'offre du rôle
      final seats = <(Firm, int)>[
        for (var i = 0; i < scen.length; i++)
          for (final r in seatOrder(created[i].type, staff[i])) (created[i], r),
      ];
      stableSort<(Firm, int)>(seats, (a, b) => roles[b.$1.type]![b.$2].minSkill.compareTo(roles[a.$1.type]![a.$2].minSkill));
      for (final (f, r) in seats) {
        final c = pool.take(roles[f.type]![r].minSkill);
        if (c == null) continue;
        _hire(f, c, 'poste ouvert', r, roleOffer(f, r));
      }
    } else {
      final order = List<int>.generate(scen.length, (i) => i);
      stableSort<int>(order, (a, b) => created[b].template.skill - created[a].template.skill);
      for (final i in order) {
        final f = created[i];
        for (var k = 0; k < staff[i]; k++) {
          final c = pool.take(f.template.skill.toDouble());
          if (c == null) break;
          _hire(f, c);
        }
      }
    }
    // ancienneté de départ : de 0 à 4 ans (les rôles d'encadrement, au moins l'ancienneté qu'ils exigent)
    for (final c in citizens) {
      if (c.employer == null) continue;
      final need = this.modules.jobs && c.role >= 0 ? roles[firm(c.employer!)!.type]![c.role].minTenure : 0;
      c.hiredDay = -(need + (draw(Flux.anciennete, c.id) * 1460).floor());
    }

    for (final f in firms) {
      final n = perType[f.type]!;
      if (f.type == 'immobilier') f.capacity = (1.06 * pop / n).ceilToDouble();
      final batches = _capBatches(f, plan.batches[f.type]! / n);
      var revenue = 0.0;
      for (final e in f.outputs.entries) {
        final d = batches * e.value;
        f.demandEma[e.key] = d;
        _setStock(f, e.key, goods[e.key]!.perish ? 0 : d * p.invTargetDays);
        revenue += d * f.price[e.key]!;
      }
      var inputCost = 0.0;
      for (final e in f.inputs.entries) {
        f.inv[e.key] = batches * e.value * 5;
        inputCost += batches * e.value * plan.price[e.key]!;
      }
      f.machines = (plan.machinesPerWorker[f.type]! * f.workers.length).roundToDouble();
      f.revenueEma = revenue;
      f.outputEma = batches;
      f.money = quantize(math.max(6000.0, 12 * (f.wage * f.workers.length + inputCost)));
      // sans citoyen (cas extrême), pas de propriétaire : la trésorerie d'une fermeture revient à l'État
      if (citizens.isNotEmpty) f.ownerId = citizens[(draw(Flux.proprietaire, f.id) * citizens.length).floor()].id;
      if (publicService(f)) f.ownerId = null; // établissement public : l'État en est le propriétaire
    }
    for (final c in citizens) {
      final f = c.employer != null ? firm(c.employer!) : null;
      c.incomeEma = f != null ? (this.modules.jobs ? c.wage : f.wage) * (1 - p.taxRate) : p.benefit;
    }
    jobsActive = this.modules.jobs;
    if (this.modules.products) _productsSwitch(); // les entreprises du départ reçoivent leur variété
    bankingActive = this.modules.banking;
    if (bankingActive) _bankingSwitch(atReset: true); // banques de départ et leur dotation (avant m0)
    if (this.modules.buildings) _seedBuildings();
    m0 = totalMoney();
    bank.reserves = m0; // toute la monnaie de départ est « extérieure »
    bank.equity = bank.money;
    _depositsAtCheck = deposits();
    needCost = _needCost();
    _record();
    wage0 = history.last.wage > 0 ? history.last.wage : p.startWage;
    _checkInvariants();
  }

  /// Prix de référence d'un bien aujourd'hui : son prix d'équilibre au départ, corrigé de la hausse des salaires
  /// (le travail est le principal coût). Un prix bien au-dessus n'est pas de l'inflation, c'est une rente ou un coût
  /// de revient gonflé par une équipe sous-employée.
  double referencePrice(String good) {
    final w = history.isNotEmpty ? history.last.wage : 0.0;
    return worldPrice[good]! * (w > 0 && wage0 > 0 ? w / wage0 : 1.0);
  }

  /// Résout prix et effectifs de départ : la demande des ménages (besoins de base + une part discrétionnaire
  /// ajustée pour employer 94 % de la population) remonte les chaînes d'approvisionnement.
  _Plan _plan(Params p, List<ScenarioFirm> scen, Map<String, int> count) {
    final m = modules;
    final types = count.keys.toList();
    final price = <String, double>{for (final g in goods.keys) g: goods[g]!.guess};
    final pop = p.population.toDouble();
    final r = p.interestRate / 365;
    final b = <String, double>{for (final t in types) t: 1.0};
    final w = <String, double>{for (final t in types) t: 1.0};
    final k = <String, double>{for (final t in types) t: m.capital ? 0.5 * templates[t]!.capital : 0.0};
    final basic = Map<String, double>.from(_basicDemand);
    if (!m.health) basic.remove('soins');
    if (!m.education) basic.remove('cours');
    if (!m.buildings) basic.remove('batiment');

    double perW(String ty) {
      final t = templates[ty]!;
      final kk = k[ty]!;
      return t.rate * (1 + t.capital * kk / (kk + 1));
    }

    double maintNeed(Template t, double workers, double machines) =>
        p.maintNeed * machines + (t.heavy ? 0.06 * workers : 0);
    bool needsMaint(Template t) => m.capital && t.maint != null && !t.outputs.containsKey(t.maint);
    bool needsCompta(Template t) => m.accounting && !t.outputs.containsKey('compta');

    // machines par employé là où une machine de plus ne rapporte plus assez (cf. _invest)
    double kStar(Template t, double wage) {
      final a = t.capital;
      if (a <= 0 || !m.capital) return 0;
      final cost = price['machines']! * (r + p.depreciation + 0.001) * 1.3;
      double gain(double kk) {
        final mpM = a / ((kk + 1) * (kk + 1));
        final mpL = 1 + a * kk / (kk + 1) - a * kk / ((kk + 1) * (kk + 1));
        return wage * mpM / mpL;
      }

      if (gain(0) <= cost) return 0;
      var lo = 0.0, hi = 4.0;
      for (var i = 0; i < 30; i++) {
        final mid = (lo + hi) / 2;
        if (gain(mid) > cost) {
          lo = mid;
        } else {
          hi = mid;
        }
      }
      return lo;
    }

    // passe 1 : équipements et effectifs sans pénalité de petite taille ; passe 2 : prix avec la pénalité,
    // équipements figés (sinon des machines chères font disparaître la demande de machines, et la Machinerie avec)
    var scaled = false;

    void solve(double lambda) {
      for (var it = 0; it < 80; it++) {
        final d = <String, double>{
          for (final g in goods.keys) g: pop * ((basic[g] ?? 0) + lambda * (_extraDemand[g] ?? 0)),
        };
        for (final ty in types) {
          final t = templates[ty]!;
          final n = count[ty]!;
          final mach = k[ty]! * w[ty]!;
          for (final e in t.inputs.entries) {
            d[e.key] = d[e.key]! + b[ty]! * e.value;
          }
          if (needsCompta(t)) d['compta'] = d['compta']! + 0.1 * n + 0.03 * w[ty]!;
          if (needsMaint(t)) d[t.maint!] = d[t.maint!]! + maintNeed(t, w[ty]!, mach);
          if (m.capital) d['machines'] = d['machines']! + p.depreciation * mach;
          if (t.ads && m.marketing) {
            var rev = 0.0;
            for (final e in t.outputs.entries) {
              rev += b[ty]! * e.value * price[e.key]!;
            }
            d['pub'] = d['pub']! + p.adsShare * rev / price['pub']!;
          }
          final rd = t.rnd;
          if (rd != null && m.rnd) d[rd] = d[rd]! + 0.3 * n;
        }
        for (final ty in types) {
          final t = templates[ty]!;
          var bb = 0.0;
          for (final e in t.outputs.entries) {
            bb = math.max(bb, d[e.key]! / e.value);
          }
          b[ty] = bb;
          w[ty] = bb / perW(ty);
        }
        for (final ty in types) {
          final t = templates[ty]!;
          final n = count[ty]!;
          // module jobs : salaire moyen de l'organigramme complet (les rôles moins qualifiés coûtent moins)
          final wage = m.jobs ? p.startWage * classWage[t.skill] * avgRoleRel(ty) : p.startWage * classWage[t.skill];
          if (!scaled) k[ty] = kStar(t, wage);
          final mach = k[ty]! * w[ty]!;
          var cost = wage / (perW(ty) * (scaled ? _minScale(w[ty]!, n) : 1.0));
          for (final e in t.inputs.entries) {
            cost += e.value * price[e.key]!;
          }
          var fixed = m.capital ? price['machines']! * (r + p.depreciation) * mach : 0.0;
          if (needsCompta(t)) fixed += price['compta']! * (0.1 * n + 0.03 * w[ty]!);
          if (needsMaint(t)) fixed += price[t.maint!]! * maintNeed(t, w[ty]!, mach);
          cost += fixed / math.max(b[ty]!, 1e-3);
          final value = cost * p.markup / (t.ads && m.marketing ? 1 - p.adsShare : 1);
          var tot = 0.0;
          for (final e in t.outputs.entries) {
            tot += e.value * price[e.key]!;
          }
          for (final e in t.outputs.entries) {
            price[e.key] = value * (e.value * price[e.key]! / tot) / e.value;
          }
        }
      }
    }

    double total() => w.values.fold(0.0, (a, v) => a + v);
    final target = 0.94 * pop;
    var lambda = 0.0;
    solve(0);
    if (total() >= target) {
      // les besoins de base suffisent à occuper tout le monde : on réduit l'échelle
      final s = target / total();
      for (final ty in types) {
        w[ty] = w[ty]! * s;
        b[ty] = b[ty]! * s;
      }
    } else {
      var lo = 0.0, hi = 40.0;
      for (var i = 0; i < 30; i++) {
        final mid = (lo + hi) / 2;
        solve(mid);
        if (total() < target) {
          lo = mid;
        } else {
          hi = mid;
        }
      }
      lambda = lo;
      solve(lo);
    }
    scaled = true;
    solve(lambda);
    return _Plan(price, w, b, k, lambda);
  }

  /// Part de la productivité nominale d'une entreprise trop petite pour occuper un employé à plein temps.
  static double _minScale(double workers, int firms) => (workers / firms).clamp(0.001, 1.0).toDouble();

  /// Un citoyen. Ses traits ne dépendent que de (graine, jour, identifiant), par le flux « traits ». Au départ, sa
  /// qualification prévue (`level`) fixe son argent ; un immigrant (`money` donné) a une qualification de 0 à 1,6.
  Citizen _newCitizen({int? level, double? money}) {
    final id = _nextCitizenId++;
    double t(int k) => draw(Flux.traits, id, k);
    final skill = level != null ? level + 0.9 * t(1) : t(1) * 1.6;
    final cash = money ?? params.startWallet * (0.6 + 0.8 * t(2)) * const [1.0, 1.3, 1.8][level ?? 0];
    var name = '';
    for (var k = 0; k < 30; k++) {
      final a = firstNames[(t(10 + 2 * k) * firstNames.length).floor()];
      final b = lastNames[(t(11 + 2 * k) * lastNames.length).floor()];
      name = '$a $b';
      if (!citizens.any((x) => x.name == name)) break;
    }
    final c = Citizen(id, name, quantize(cash), skill, t(3));
    if (t(4) < const [0.2, 0.6, 0.7][c.level]) c.computerDays = (t(5) * params.computerLife).floor();
    c.wantsToOwn = modules.buildings && t(6) < params.ownerShare;
    c.aplomb = t(7);
    if (banks.isNotEmpty) c.bankId = _pickBank(c.id); // module banking : sa banque
    citizens.add(c);
    _cmap[c.id] = c;
    return c;
  }

  Firm _newFirm(String type, String? name, double money, int? ownerId, double x, double y,
      [Map<String, double>? priceTable]) {
    final t = templates[type]!;
    final f = Firm(_newFirmId(type), type, name ?? t.label, Map<String, double>.from(t.inputs),
        Map<String, double>.from(t.outputs), t.rate, t.capacity, quantize(money), ownerId,
        params.startWage * classWage[t.skill], x, y);
    final pt = priceTable ?? worldPrice;
    for (final g in f.outputs.keys) {
      f.price[g] = pt[g] ?? goods[g]!.guess;
      f.inv[g] = 0;
      f.demandEma[g] = 0;
    }
    for (final g in f.inputs.keys) {
      f.inv[g] = f.inv[g] ?? 0.0;
    }
    firms.add(f);
    _fmap[f.id] = f;
    _rebuildSellers();
    if (productsActive) _launchProduct(f); // module products : sa variété et un nom généré
    if (banks.isNotEmpty) f.bankId = _pickBank(f.id); // module banking : sa banque
    return f;
  }

  void _rebuildSellers() {
    _sellers.clear();
    for (final f in firms) {
      for (final g in f.outputs.keys) {
        final l = _sellers[g] ??= [];
        l.add(f);
      }
    }
    // la liste des vendeurs disponibles se refait à la demande (_availFor) ou chaque matin : à chaque fermeture, une
    // reconstruction complète coûtait autant que le reste de la journée à très grande échelle
    _availValid = false;
    _booksValid = false;
  }

  /// Diagnostic de performance (non sérialisé) : achats des ménages pendant la phase de consommation, et temps passé
  /// dans cette phase (tool/perf.dart).
  int consumeBuys = 0;
  final Stopwatch consumeClock = Stopwatch();

  /// Recherche limitée (Params.sellerSample) : dernier vendeur de chaque ménage, par (acheteur × 64 + bien).
  final Map<int, int> lastSeller = {};

  // ------------------------------------------------- liste des vendeurs disponibles (Params.sellerSample > 0)
  /// Par bien, les entreprises qui ont du stock vendable à l'unité (`availThreshold`), avec la place de chacune dans
  /// la liste. Un retrait se fait par échange avec le dernier élément : O(1). Elle est reconstruite chaque matin et à
  /// chaque changement du parc, en ordre d'identifiant croissant ; ensuite chaque changement de stock la met à jour
  /// (`_setStock`). Elle n'est pas sérialisée : elle se déduit de l'état du matin.
  final Map<String, _Avail> _avail = {};
  bool _availValid = false;

  // vendeurs en tableaux (voir _Book), refaits à la demande après un changement du parc
  final Map<String, _Book> _books = {};
  bool _booksValid = false;

  _Book? _book(String good) {
    if (!_booksValid) {
      _books.clear();
      for (final e in _sellers.entries) {
        _books[e.key] = _Book(e.value, e.key);
      }
      _booksValid = true;
    }
    return _books[good];
  }

  /// Prix affiché d'une entreprise pour l'un de ses extrants : le seul endroit où il change (avec la création, qui passe
  /// par `_rebuildSellers`).
  void _setPrice(Firm f, String g, double v) {
    f.price[g] = v;
    if (!_booksValid) return;
    final b = _books[g];
    final i = b?.pos[f.id];
    if (i != null) b!.price[i] = v;
  }

  /// Stock minimal qui compte comme « vendable » : les ménages achètent des unités entières (une unité moins une
  /// tolérance d'arrondi, voir `buy`). Drapeau de test : `eps` donne la définition « stock > 0 » (voir le rapport).
  static double availThreshold = 1 - 1e-7;

  /// Drapeau de test : faux supprime l'habitude (le dernier vendeur n'est plus examiné d'office) pour mesurer son effet.
  static bool sellerHabit = true;

  bool _sellable(Firm f, String g) => (f.inv[g] ?? 0) >= availThreshold;

  _Avail _availFor(String good) {
    if (!_availValid) _rebuildAvail();
    return _avail[good] ?? _Avail();
  }

  void _rebuildAvail() {
    _avail.clear();
    _availValid = params.sellerSample > 0;
    if (!_availValid) return;
    for (final e in _sellers.entries) {
      final a = _avail[e.key] = _Avail();
      for (final f in e.value) {
        if (_sellable(f, e.key)) a.add(f);
      }
      a.list.sort((x, y) => x.id.compareTo(y.id));
      for (var i = 0; i < a.list.length; i++) {
        a.pos[a.list[i].id] = i;
      }
    }
  }

  /// Le seul endroit où le stock d'un bien produit par une entreprise change (avec les créations d'entreprises, qui
  /// passent par `_rebuildSellers`) : met à jour la liste des vendeurs disponibles.
  void _setStock(Firm f, String g, double v) {
    f.inv[g] = v;
    if (_booksValid) {
      final b = _books[g];
      final i = b?.pos[f.id];
      if (i != null) b!.stocked[i] = v >= 1 - eps ? 1 : 0;
    }
    if (!_availValid) return;
    final a = _avail[g];
    if (a == null) return;
    final has = v >= availThreshold;
    final listed = a.pos.containsKey(f.id);
    if (has) {
      if (!listed && f.outputs.containsKey(g)) a.add(f); // un intrant n'est pas un bien vendu
    } else if (listed) {
      a.remove(f);
    }
  }

  /// Détecteur : la liste de chaque bien est exactement l'ensemble des entreprises actives dont le stock est vendable
  /// (et les places sont cohérentes). Retourne les écarts (vide si tout va bien).
  List<String> availMismatches() {
    final out = <String>[];
    if (params.sellerSample <= 0) return out;
    if (!_availValid) _rebuildAvail(); // refaite à la demande après un changement du parc : on la vérifie quand même
    for (final e in _sellers.entries) {
      final a = _avail[e.key];
      final want = <int>{for (final f in e.value) if (_sellable(f, e.key)) f.id};
      final got = <int>{for (final f in a?.list ?? const <Firm>[]) f.id};
      if (a == null || got.length != a.list.length || a.pos.length != a.list.length) {
        out.add('${e.key} : liste incohérente');
        continue;
      }
      for (var i = 0; i < a.list.length; i++) {
        if (a.pos[a.list[i].id] != i) {
          out.add('${e.key} : place fausse de ${a.list[i].name}');
          break;
        }
      }
      if (want.length != got.length || !want.containsAll(got)) {
        final missing = want.difference(got).length, extra = got.difference(want).length;
        out.add('${e.key} : $missing absents, $extra en trop');
      }
    }
    return out;
  }

  /// Identifiant stable d'une entreprise : 100 000 + 10 000 × (rang du type) + rang de création dans ce type. Créer
  /// une entreprise d'un type ne décale pas les identifiants (donc les tirages) des entreprises des autres types.
  int _newFirmId(String type) {
    final k = _firmSeq[type] = (_firmSeq[type] ?? 0) + 1;
    if (k >= 10000) throw StateError('Trop d’entreprises de type $type pour des identifiants stables');
    return 100000 + 10000 * _typeIndex[type]! + k;
  }

  // ============================================================= Utilitaires

  Citizen? citizen(int id) => _cmap[id];
  Firm? firm(int id) => _fmap[id];

  /// Dépôts : l'argent du public (citoyens, entreprises, État).
  double deposits() {
    var m = state.money;
    for (final c in citizens) {
      m += c.money;
    }
    for (final f in firms) {
      m += f.money;
    }
    return m;
  }

  /// Toute la monnaie, encaisse de la Caisse comprise.
  double totalMoney() => deposits() + bank.money;

  double expectedMoney() => m0 + ledgerGod + ledgerExports - ledgerImports + ledgerCredit;

  /// Exposition de la Caisse, pondérée par le risque : dettes des entreprises à 100 %, hypothèques à
  /// Params.mortgageRiskWeight (35 %, Bâle III). Sert aux fonds propres exigés (I4) et à la cible de ristourne.
  double totalDebt() {
    var d = 0.0;
    for (final f in firms) {
      d += f.debt;
    }
    if (mortgages.isNotEmpty) d += params.mortgageRiskWeight * mortgageDebt();
    if (consumerLent > 0) d += consumerDebtOf(); // module banking : crédit aux particuliers, pondéré à 100 %
    return d;
  }

  /// Tous les prêts de la Caisse au nominal : dettes des entreprises et hypothèques (pour l'invariant des prêts).
  double totalLoans() {
    var d = 0.0;
    for (final f in firms) {
      d += f.debt;
    }
    if (mortgages.isNotEmpty) d += mortgageDebt();
    if (consumerLent > 0) d += consumerDebtOf(); // module banking : prêts personnels et soldes de carte
    return d;
  }

  /// Montant effectivement transféré (quantifié au 2⁻¹⁰ $ inférieur ; jamais au-delà du solde).
  double transfer(Account? from, Account? to, double amt) {
    if (!(amt > 0)) return 0;
    amt = quantize(amt);
    if (amt <= 0) return 0;
    if (from != null) {
      if (from.money + eps < amt) throw StateError('Transfert à découvert');
      if (amt > from.money) amt = from.money;
      from.money -= amt;
    }
    if (to != null) to.money += amt;
    return amt;
  }

  void _flow(String from, String to, String good, double qty, double value) {
    final k = '$from>$to>$good';
    final e = flows[k] ?? (flows[k] = FlowEdge(from, to, good, 0, 0));
    e.qty += qty;
    e.value += value;
  }

  /// Embauche. Module jobs : au rôle [role] (par défaut, celui du prochain poste de l'organigramme) et au salaire
  /// [wage] (par défaut, l'offre du rôle).
  void _hire(Firm f, Citizen c, [String why = 'poste ouvert', int role = -1, double wage = 0]) {
    if (c.employer != null) {
      final old = firm(c.employer!);
      if (old != null) _fire(old, c, 'départ pour un autre emploi');
    }
    c.employer = f.id;
    c.daysUnemployed = 0;
    c.hiredDay = day;
    if (modules.jobs) {
      c.role = role >= 0 ? role : nextRole(f);
      c.wage = wage > 0 ? wage : roleOffer(f, c.role);
    } else {
      c.role = -1;
    }
    f.workers.add(c.id);
    _syncWage(f);
    if (trace != null) {
      _t('travail', 'embauche', c.name, c.id, why, f.name, modules.jobs ? c.wage : f.wage,
          'entreprise ${f.id}${modules.jobs ? ' ; ${roles[f.type]![c.role].label}' : ''}');
    }
  }

  /// Fin d'emploi. Le citoyen garde le salaire de son dernier contrat (base de son salaire de réserve).
  void _fire(Firm? f, Citizen? c, [String why = '']) {
    if (f == null || c == null) return;
    f.workers.remove(c.id);
    f.lastLoss = why;
    c.employer = null;
    c.role = -1;
    _syncWage(f);
    if (trace != null) {
      _t('travail', 'fin_emploi', c.name, c.id, why, f.name, modules.jobs ? c.wage : f.wage, 'entreprise ${f.id}');
    }
  }

  /// Candidat admissible le moins surqualifié (garde les plus qualifiés pour les postes qui les exigent).
  Citizen? _pickWorker(List<Citizen> pool, int req) {
    Citizen? best;
    for (var i = pool.length - 1; i >= 0; i--) {
      final c = pool[i];
      if (c.skill + eps < req) continue;
      if (best == null || c.skill < best.skill) best = c;
    }
    return best;
  }

  /// Facteurs du rendement d'un employé ; leur produit est son efficacité (hors bonus de qualification).
  ({double faim, double logement, double sante, double moral}) efficiencyFactors(Citizen c) {
    final fun = math.min(1.0, c.sat['divertissement']! + 0.5 * c.sat['luxe']!);
    return (
      faim: c.hungerDays >= 2 ? 0.5 : (c.hungerDays == 1 ? 0.85 : 1.0),
      logement: c.homeless ? 0.8 : 1.0,
      sante: modules.health ? 0.4 + 0.6 * c.health : 1.0,
      moral: 0.85 + 0.15 * fun,
    );
  }

  /// Rendement d'un employé : faim, logement, santé, moral, et un bonus s'il est plus qualifié que le poste.
  double efficiency(Citizen c, [Firm? f]) {
    final k = efficiencyFactors(c);
    var e = k.faim * k.logement * k.sante * k.moral;
    if (f != null) {
      // module jobs : la surqualification se mesure par rapport au rôle tenu
      final req = modules.jobs && c.role >= 0 ? roles[f.type]![c.role].minSkill : f.template.skill.toDouble();
      e *= 1 + 0.05 * math.min(3.0, math.max(0.0, c.skill - req));
    }
    return e;
  }

  // ---- productivité d'une entreprise

  /// Gain dû aux machines : rendements décroissants selon le nombre de machines par employé.
  double machineMult(Firm f) {
    final a = f.template.capital;
    if (a <= 0 || !modules.capital) return 1;
    final k = f.machines / math.max(1, f.workers.length);
    // module products : le gain moyen des modèles installés, rapporté au modèle standard
    if (productsActive && f.machineGain > 0) return 1 + a * (f.machineGain / machineGainRef) * k / (k + 1);
    return 1 + a * k / (k + 1);
  }

  /// ×1,15 par niveau. Des multiplications successives plutôt que math.pow, dont le dernier chiffre peut différer entre
  /// la VM et le web : une même graine doit donner la même partie partout.
  double techMult(Firm f) {
    var m = 1.0;
    for (var i = 1; i < f.techLevel; i++) {
      m *= 1.15;
    }
    return m;
  }

  /// Sans ingénierie, l'industrie lourde tourne au ralenti (jusqu'à moitié).
  double uptime(Firm f) => f.template.heavy && modules.capital ? 0.5 + 0.5 * f.maintCover : 1.0;

  /// Sans comptabilité, la gestion se désorganise (jusqu'à −12 %).
  double adminMult(Firm f) => 0.88 + 0.12 * f.adminCover;

  /// Lots par employé et par jour, à efficacité 1.
  double perWorker(Firm f) {
    final v = f.rate * f.prodMult * machineMult(f) * techMult(f) * uptime(f) * adminMult(f);
    return productsActive && f.productId != null ? v * qualityRate(f) : v; // module products : la qualité coûte
  }

  /// Taux annuel d'une entreprise : taux de base + prime de risque proportionnelle à son endettement,
  /// mesuré par rapport à la valeur de ses machines (garantie maximale : 80 %).
  double loanRate(Firm f, [double? machinePrice]) {
    final p = params;
    if (f.debt <= 0) return banks.isEmpty ? p.interestRate : p.interestRate + bankLoanSpread(f.bankId);
    final pm = machinePrice ?? bestPrice('machines');
    final lev = pm > 0 ? (f.debt / (math.max(f.machines, 1.0) * pm)).clamp(0.0, 1.0) : 0.0;
    final r = p.interestRate + p.riskSpread * lev;
    return banks.isEmpty ? r : r + bankLoanSpread(f.bankId); // module banking : la marge de sa banque
  }

  /// Services de R-D à accumuler pour passer au niveau technologique suivant.
  double rndCost(int level) => 40.0 * level * level;

  double brandPull(Firm f) => 0.3 * f.brand / (f.brand + 20);

  double _capBatches(Firm f, double b) => f.capacity != null ? math.min(b, f.capacity!) : b;

  List<Firm> sellersOf(String good) => _sellers[good] ?? const <Firm>[];

  /// Meilleurs prix par bien, tenus pendant la consommation des ménages seulement (null en dehors). Pendant cette
  /// phase, aucun prix ne change et les stocks ne font que baisser : un vendeur passé sous une unité n'y revient pas.
  /// Le cache donne donc exactement les mêmes valeurs que le parcours de tous les vendeurs (performance).
  Map<String, _BestOffers>? _quoteCache;

  /// Meilleur prix pour une unité en stock (ou importée) ; infini si rien n'est disponible.
  double quote(String good) {
    final cache = _quoteCache;
    if (cache != null) {
      final q = (cache[good] ??= _BestOffers(this, good)).quote();
      if (verifyFastPaths && q != _quoteAll(good)) throw StateError('Meilleur prix différent au jour $day ($good)');
      return q;
    }
    return _quoteAll(good);
  }

  double _quoteAll(String good) {
    var best = double.infinity;
    final b = _book(good);
    if (b != null) {
      final price = b.price, stocked = b.stocked;
      for (var i = 0; i < price.length; i++) {
        if (stocked[i] != 0 && price[i] < best) best = price[i];
      }
    }
    if (verifyFastPaths && best != _quoteScan(good)) throw StateError('Meilleur prix (tableaux) différent au jour $day ($good)');
    if (params.trade && !goods[good]!.perish && goods[good]!.tradable) {
      best = math.min(best, worldPrice[good]! * params.importMarkup);
    }
    return best;
  }

  /// Prix de référence : le meilleur disponible, sinon le plus bas affiché, sinon le prix mondial.
  double bestPrice(String good) {
    final cache = _quoteCache;
    if (cache != null) {
      final b = (cache[good] ??= _BestOffers(this, good)).bestPrice();
      if (verifyFastPaths && b != _bestPriceAll(good)) throw StateError('Prix de référence différent au jour $day ($good)');
      return b;
    }
    return _bestPriceAll(good);
  }

  /// Le même meilleur prix, par lecture des tables de chaque vendeur (vérification : verifyFastPaths).
  double _quoteScan(String good) {
    var best = double.infinity;
    for (final f in sellersOf(good)) {
      final pr = f.price[good]!;
      if (pr < best && (f.inv[good] ?? 0) >= 1 - eps) best = pr;
    }
    return best;
  }

  double _bestPriceAll(String good) {
    var best = _quoteAll(good);
    if (best == double.infinity) {
      final b = _book(good);
      if (b != null) {
        for (var i = 0; i < b.price.length; i++) {
          best = math.min(best, b.price[i]);
        }
      }
    }
    return best == double.infinity ? worldPrice[good]! : best;
  }

  /// Coût d'un lot : salaires, intrants au prix du marché, frais fixes (services, intérêts, usure), réparti entre les extrants.
  /// Un employé ne se divise pas : si l'équipe est sous-employée, ses salaires se répartissent sur la production prévue.
  Map<String, double> unitCost(Firm f) {
    final p = params;
    final per = math.max(eps, perWorker(f));
    final capacity = math.max(1, f.workers.length) * per;
    // utilisation de l'équipe sur ~20 jours : les achats des clients arrivent par lots, le coût ne doit pas suivre chaque creux
    final util = f.workers.isEmpty ? 1.0 : (f.outputEma / capacity).clamp(0.05, 1.0);
    // variante A2 (temps partiel) : seules les heures travaillées sont payées
    var batch = f.wage * (p.partTime ? math.max(util, minHours) : 1.0) / (per * util);
    final planned = math.max(math.max(f.lastBatches, _plannedBatches(f)), 0.05 * capacity);
    for (final e in f.inputs.entries) {
      batch += e.value * bestPrice(e.key);
    }
    var fixed = f.overheadEma + f.debt * loanRate(f) / 365 + f.carry;
    if (modules.capital) fixed += f.machines * p.depreciation * bestPrice('machines');
    batch += fixed / planned;
    var tot = 0.0;
    for (final e in f.outputs.entries) {
      tot += e.value * worldPrice[e.key]!;
    }
    final out = <String, double>{};
    for (final e in f.outputs.entries) {
      final share = tot > 0 ? e.value * worldPrice[e.key]! / tot : 1 / f.outputs.length;
      out[e.key] = batch * share / e.value;
    }
    return out;
  }

  /// Achat sur le marché : le moins cher d'abord (les ménages préfèrent un peu les marques connues).
  /// `forCitizen` : le citoyen pour qui l'État achète (aides, soins) ; ses tirages restent les siens.
  BuyResult buy(Account buyer, String buyerKey, String good, double qty, double budget, bool integer,
      {Citizen? forCitizen}) {
    budget = math.min(budget, buyer.money);
    if (qty <= eps || budget <= eps) return const BuyResult(0, 0);
    final household = buyerKey == 'M';
    // départage des offres : un tirage par (acheteur, bien, n-ième achat de ce bien aujourd'hui, vendeur)
    final who = forCitizen?.id ?? _accountId(buyer);
    final gi = _goodIndex[good]!;
    final n = _buySeq[who * 64 + gi] = (_buySeq[who * 64 + gi] ?? -1) + 1;
    final base = hash32(hash32(_dayKey(Flux.offres), who), hash32(gi, n));
    // pendant la consommation, prix et attrait des vendeurs sont lus une fois par bien et par jour (ils ne changent pas)
    final qc = _quoteCache;
    if (qc != null && household) consumeBuys++;
    final cached = household && buyer is! Firm && qc != null ? (qc[good] ??= _BestOffers(this, good)) : null;
    final k = params.sellerSample;
    if (verifyFastPaths && k > 0) {
      final bad = availMismatches();
      if (bad.isNotEmpty) throw StateError('Liste des vendeurs disponibles fausse au jour $day : ${bad.first}');
    }
    Citizen? vc; // module products : le ménage qui choisit une variété
    var searched = false;
    // achat d'entreprise pendant les achats d'intrants : offres servies dans l'ordre, sans toutes les construire
    final lazy = !household && qc != null ? _LazyOffers(this, qc[good] ??= _BestOffers(this, good), buyer, good, base) : null;
    _Offer? Function(int) pick;
    if (lazy != null) {
      pick = (_) => lazy.next();
      if (verifyFastPaths) {
        final full = _AllOffers(this, buyer, good, base, household, cached).pick;
        final fast = pick;
        pick = (i) {
          final a = fast(i), b = full(i);
          if ((a == null) != (b == null) || (a != null && (!identical(a.firm, b!.firm) || a.p != b.p))) {
            throw StateError('Offres différentes au jour $day (achat de $good, offre $i)');
          }
          return a;
        };
      }
    } else {
      // module products : un ménage choisit parmi les variétés qu'il connaît ; faute d'en avoir une en stock, il cherche
      // parmi les vendeurs disponibles (et apprend la variété trouvée)
      _AllOffers? vo;
      if (productsActive && household && integer && isDifferentiated(good)) {
        vc = forCitizen ?? (buyer is Citizen ? buyer : null);
        if (vc != null) vo = _varietyOffers(vc, buyer, good);
      }
      pick = (vo ??
              (k > 0 && household && integer
                  ? _AllOffers.sampled(this, buyer, good, base, k, who, gi, n)
                  : _AllOffers(this, buyer, good, base, household, cached)))
          .pick;
      searched = vc != null && vo == null;
    }

    var remaining = qty;
    var spent = 0.0;
    var broke = false;
    for (var k = 0;; k++) {
      if (remaining <= eps) break;
      final o = pick(k);
      if (o == null) break;
      final double avail = o.firm == null ? double.infinity : (o.firm!.inv[good] ?? 0.0);
      final afford = (budget - spent) / o.p;
      double q = math.min(remaining, math.min(avail, afford));
      if (integer) q = (q + 1e-7).floorToDouble();
      if (afford < remaining && afford <= avail) broke = true;
      if (q <= eps) continue;
      final cost = math.min(q * o.p, buyer.money);
      double paid;
      if (o.firm == null) {
        paid = transfer(buyer, null, cost);
        ledgerImports += paid;
        bank.reserves -= paid;
        dayFlows.imports += paid;
      } else {
        final s = o.firm!;
        paid = transfer(buyer, s, cost);
        _setStock(s, good, (s.inv[good] ?? 0) - q);
        s.sold[good] = (s.sold[good] ?? 0) + q;
        s.revenue += paid;
        if (k > 0 && household && sellerHabit) lastSeller[who * 64 + gi] = s.id; // habitude
        if (vc != null) _boughtVariety(vc, good, s, q, searched);
      }
      if (o.firm == null && vc != null) _boughtVariety(vc, good, null, q, searched);
      _flow(o.firm == null ? 'X' : o.firm!.id.toString(), buyerKey, good, q, paid);
      final ms = marketStats[good]!;
      ms.qty += q;
      ms.value += paid;
      remaining -= q;
      spent += paid;
      if (broke) break;
    }
    if (remaining > eps && !broke) {
      if (verifyFastPaths && k > 0 && household && integer && qty <= 1 + eps) {
        // propriété : l'achat d'une unité n'échoue pour « pas d'offre » que si aucun autre vendeur n'a une unité en stock
        for (final f in sellersOf(good)) {
          if (!identical(f, buyer) && _sellable(f, good)) {
            throw StateError('Fausse pénurie au jour $day : ${f.name} a ${f.inv[good]} de $good, achat sans offre');
          }
        }
      }
      unmet[good] = (unmet[good] ?? 0) + remaining;
    }
    return BuyResult(qty - remaining, spent);
  }

  void _log(String type, String text) {
    events.add(SimEvent(day, type, text));
    if (events.length > 300) events.removeAt(0);
  }

  /// Journal des alertes (ouverture et fermeture), appelé par le moniteur.
  void logAlert(Alert a, {required bool opened}) {
    final label = alertLabels[a.type] ?? a.type;
    if (trace != null) {
      final sub = a.subject;
      final name = sub == null ? '' : (sub.kind == 'firm' ? firm(sub.id)?.name : citizen(sub.id)?.name) ?? '';
      _t('alertes', opened ? 'ouverture' : 'fermeture', name, sub?.id, label, a.what, a.value,
          '${a.critical ? 'critique' : 'attention'} ; seuil ${a.threshold}${opened ? '' : ' ; ${(a.until ?? day) - a.since} j'}');
    }
    if (opened) {
      final who = a.agents.isEmpty ? '' : ' — ${a.agents.take(3).join(' ; ')}';
      _log('alert', '${a.critical ? '⛔' : '⚠'} $label : ${a.what}$who');
    } else {
      _log('alert', '✓ Fin de l’alerte « $label » (${(a.until ?? day) - a.since} j).');
    }
  }

  /// Coût quotidien de la survie : le point de faim le moins cher et une nuitée.
  double _needCost() {
    var food = double.infinity;
    for (final g in foods) {
      food = math.min(food, bestPrice(g) / uses[g]!.pts['faim']!);
    }
    return food + bestPrice('logement');
  }

  /// Sous ce seuil, l'État cesse de payer les soins et les cours.
  double _stateFloor() => 5 * params.benefit * math.max(4.0, citizens.length * 0.1);

  // ================================================================= Tick
  void step() {
    final p = params;
    day++;
    _buySeq.clear();
    flows = {};
    unmet = {};
    householdSpend = 0;
    for (final g in goods.keys) {
      marketStats[g] = MarketStat();
    }
    for (final f in firms) {
      f.sold = {};
      f.produced = {};
      f.revenue = 0;
      f.costs = 0;
      f.inputSpend = 0;
      f.wagesPaid = 0;
      f.overhead = 0;
      f.prevWorkers = f.workers.length;
    }
    for (final c in citizens) {
      c.incomeEma = 0.9 * c.incomeEma + 0.1 * c.income; // revenu complet de la veille (dividendes compris)
      c.income = 0;
      c.spend = 0;
    }
    state.taxesToday = 0;
    state.paidToday = 0;
    labour.newDay();
    // module jobs activé ou coupé depuis la veille (onglet Diagnostic) : contrats créés ou mis de côté
    if (modules.jobs != jobsActive) _jobsSwitch();
    if (modules.products != productsActive) _productsSwitch();
    if (modules.banking != bankingActive) _bankingSwitch();

    // 0. Revenu de base divin (création monétaire)
    if (p.ubi > 0) {
      for (final c in citizens) {
        final a = transfer(null, c, p.ubi);
        _godIn(a);
        c.income += a;
      }
    }

    if (params.sellerSample > 0 || _availValid) _rebuildAvail(); // liste des vendeurs : reconstruite chaque matin
    if (modules.buildings) _buildingsMorning();
    _laborMarket();
    if (modules.entrepreneurship) _learnSectors();
    if (productsActive) _productsDay();
    if (modules.publicBudget) _publicBudget();
    _produce();
    _payWages();
    if (modules.buildings) _buildingsDay();
    _buyInputs();
    _consume();
    _safetyNets();
    if (p.trade) _export();
    _expire();
    _quoteCache = {}; // investissements : prix constants, stocks qui ne font que baisser (comme pendant les achats d'intrants)
    _capital();
    _quoteCache = null;
    _decide();
    _finance();
    for (final g in goods.keys) {
      unmetEma[g] = 0.9 * (unmetEma[g] ?? 0) + 0.1 * (unmet[g] ?? 0);
    }
    if (productsActive) _productsEndOfDay();
    if (bankingActive || consumerLent > 0) _creditEndOfDay();
    if (banks.isNotEmpty) _banksDay();
    if (modules.entry) {
      _entryExit();
      _purgeFlows();
    }
    _record();
    _netSummary();
    _checkInvariants();
    monitor.check(this);
  }

  /// Monnaie créée (ou détruite si négatif) par le god mode pour le public.
  void _godIn(double a) {
    ledgerGod += a;
    bank.reserves += a;
    dayFlows.godPublic += a;
  }

  void _laborMarket() {
    if (modules.jobs) {
      _jobMarket(); // rôles, salaire de réserve, négociation, contre-offres, promotions, révisions (jobs.dart)
    } else {
      _postedWageMarket();
    }
    _jobDays();
  }

  /// Marché du travail sans le module jobs : un salaire unique affiché par entreprise.
  void _postedWageMarket() {
    final unemployed = _ordered(citizens.where((c) => c.employer == null), Flux.embauche, (c) => c.id);
    final hiring = firms.where((f) => f.vacancies > 0).toList();
    stableSort<Firm>(hiring, (a, b) => b.wage.compareTo(a.wage));
    for (final f in hiring) {
      while (f.vacancies > 0) {
        final c = _pickWorker(unemployed, f.template.skill);
        if (c == null) break;
        unemployed.remove(c);
        _hire(f, c, 'marché du travail : candidat admissible le moins surqualifié');
        f.vacancies--;
      }
      f.unfilledDays = f.vacancies > 0 ? f.unfilledDays + 1 : 0;
    }
    // mobilité : un employé quitte pour un meilleur salaire, si le poste est à sa portée
    final open = firms.where((f) => f.vacancies > 0).toList();
    if (open.isNotEmpty) {
      for (final c in List<Citizen>.from(citizens)) {
        if (c.employer == null || draw(Flux.depart, c.id) > params.jobSwitch) continue;
        final cur = firm(c.employer!);
        Firm? best;
        for (final b in open) {
          if (b.vacancies <= 0 || c.skill + eps < b.template.skill) continue;
          if (best == null || b.wage > best.wage) best = b;
        }
        if (cur != null && best != null && !identical(best, cur) && best.wage > cur.wage * 1.08 && cur.founderId != c.id) {
          _hire(best, c, 'mobilité : salaire plus de 8 % au-dessus');
          best.vacancies--;
        }
      }
    }
  }

  /// Jours de chômage et prestations, après le marché du travail.
  void _jobDays() {
    for (final c in citizens) {
      if (c.employer == null) c.daysUnemployed++;
    }
    // assurance-emploi payée par l'État, au prorata si la caisse est vide
    final idle = citizens.where((c) => c.employer == null).toList();
    state.benefitCut = 1;
    if (modules.insurance) {
      _insurance(idle);
    } else if (idle.isNotEmpty && params.benefit > 0) {
      final each = math.min(params.benefit, state.money / idle.length);
      state.benefitCut = each / params.benefit;
      if (each > eps) {
        var total = 0.0;
        for (final c in idle) {
          final a = transfer(state, c, each);
          c.income += a;
          total += a;
        }
        state.paid += total;
        state.paidToday += total;
        _flow('E', 'M', '\$prestations', idle.length.toDouble(), total);
        if (trace != null) {
          _t('compta', 'prestations', '', null, 'prestation forfaitaire aux sans-emploi', '${idle.length} sans-emploi',
              total, state.benefitCut < 1 ? 'trésor insuffisant : ${fmtPct(state.benefitCut)} versés' : '');
        }
      }
    }
  }

  /// Rémunération assurable maximale : le salaire moyen de l'économie (I3).
  double insurableCap() {
    final w = avgWage > 0 ? avgWage : (history.isNotEmpty && history.last.wage > 0 ? history.last.wage : params.startWage);
    return params.eiInsurableCap * w;
  }

  /// Jours de prestations d'une demande, selon le taux de chômage du jour : de 36 semaines (6 % ou moins) à 45 (16 % et
  /// plus), comme pour un emploi à plein temps dans la table de la Loi sur l'assurance-emploi.
  int eiDuration(double unemp) {
    final p = params;
    final x = ((unemp - 0.06) / 0.10).clamp(0.0, 1.0);
    return (p.eiDaysLow + (p.eiDaysHigh - p.eiDaysLow) * x).round();
  }

  /// Assurance-emploi indexée puis aide sociale (institution I3). Au premier jour sans emploi, le citoyen qui a assez
  /// d'emploi assurable ouvre une demande : 55 % de son dernier salaire (plafonné) pendant une durée qui dépend du
  /// chômage. Sinon, ou une fois la durée épuisée, l'aide sociale lui verse le panier de survie. Si le trésor ne suffit
  /// pas, toutes les prestations baissent dans la même proportion.
  void _insurance(List<Citizen> idle) {
    final p = params;
    final st = state;
    st.eiClaimants = 0;
    st.assistRecipients = 0;
    st.benefitCut = 1;
    if (idle.isEmpty) return;
    final unemp = idle.length / math.max(1, citizens.length);
    final cap = insurableCap();
    final due = <double>[];
    var total = 0.0;
    for (final c in idle) {
      if (c.daysUnemployed == 1) {
        if (c.insuredDays >= p.eiQualifyingDays && c.lastWage > 0) {
          c.eiDaysLeft = eiDuration(unemp);
          c.eiBenefit = p.eiReplacement * math.min(c.lastWage, cap);
          if (trace != null) {
            _t('institutions', 'demande_ae', c.name, c.id, 'I3 : assurance-emploi', '${c.insuredDays} j assurables',
                c.eiBenefit, '${c.eiDaysLeft} j de prestations, chômage ${fmtPct(unemp)}');
          }
          c.insuredDays = 0;
        } else {
          c.eiDaysLeft = 0;
        }
      }
      final a = c.eiDaysLeft > 0 ? c.eiBenefit : needCost; // aide sociale : le panier de survie
      due.add(a);
      total += a;
    }
    final k = total > st.money ? st.money / total : 1.0;
    st.benefitCut = k;
    var ei = 0.0, assist = 0.0;
    for (var i = 0; i < idle.length; i++) {
      final c = idle[i];
      final a = transfer(st, c, due[i] * k);
      c.income += a;
      if (c.eiDaysLeft > 0) {
        c.eiDaysLeft--;
        ei += a;
        st.eiClaimants++;
      } else {
        assist += a;
        st.assistRecipients++;
      }
    }
    st.eiPaid += ei;
    st.assistPaid += assist;
    st.paid += ei + assist;
    st.paidToday += ei + assist;
    if (ei > 0) _flow('E', 'M', '\$assurance-emploi', st.eiClaimants.toDouble(), ei);
    if (assist > 0) _flow('E', 'M', '\$aide sociale', st.assistRecipients.toDouble(), assist);
    if (trace != null) {
      _t('institutions', 'prestations', '', null, 'I3 : assurance-emploi et aide sociale',
          '${st.eiClaimants} prestataires, ${st.assistRecipients} à l’aide sociale', ei + assist,
          'assurance-emploi ${fmtMoney0(ei)}, aide sociale ${fmtMoney0(assist)}'
              '${k < 1 ? ' ; trésor insuffisant : ${fmtPct(k)} versés' : ''}');
    }
  }

  void _produce() {
    for (final f in firms) {
      var eff = 0.0;
      for (final id in f.workers) {
        eff += efficiency(_cmap[id]!, f);
      }
      final laborBatches = _capBatches(f, eff * perWorker(f));
      var batches = laborBatches;
      if (f.inputs.isNotEmpty) {
        // intrants principaux : recette stricte ; intrants secondaires : la cadence baisse en proportion de leur poids.
        // Le poids se mesure au prix du jour. Essais moins bons : aux prix de référence (pain, viande et poisson
        // devenaient tous secondaires) et avec une liste explicite par recette (famine ×15) ; voir le journal.
        final theta = params.softInputShare;
        final prices = <String, double>{for (final g in f.inputs.keys) g: bestPrice(g)};
        var lotCost = f.wage / math.max(eps, perWorker(f));
        for (final e in f.inputs.entries) {
          lotCost += e.value * prices[e.key]!;
        }
        var soft = 1.0;
        for (final e in f.inputs.entries) {
          final stock = f.inv[e.key] ?? 0;
          final share = lotCost > eps ? e.value * prices[e.key]! / lotCost : 1.0;
          if (share >= theta) {
            batches = math.min(batches, stock / e.value);
          } else if (laborBatches > eps) {
            final avail = math.min(1.0, stock / (e.value * laborBatches));
            soft *= 1 - (1 - avail) * share / theta;
          }
        }
        batches = math.min(batches, laborBatches * soft);
      }
      f.inputLimited = batches < laborBatches - eps;
      // on produit la demande prévue (et le réassort du stock visé), pas toute la capacité de l'équipe
      batches = math.max(0.0, math.min(batches, _plannedBatches(f)));
      f.lastBatches = batches;
      f.outputEma = 0.95 * f.outputEma + 0.05 * batches;
      f.effWorkers = eff;
      for (final e in f.inputs.entries) {
        final stock = f.inv[e.key] ?? 0;
        _setStock(f, e.key, stock - math.min(stock, batches * e.value)); // un intrant secondaire manquant n'est pas consommé
      }
      for (final e in f.outputs.entries) {
        final q = batches * e.value;
        _setStock(f, e.key, (f.inv[e.key] ?? 0) + q);
        f.produced[e.key] = q;
      }
    }
  }

  /// Variante A2 : part minimale du temps de travail (un jour par semaine).
  static const double minHours = 0.2;

  /// Part du temps payée aujourd'hui : 1, sauf dans la variante A2 (temps partiel), où l'équipe n'est payée que pour
  /// la part de sa capacité du jour qu'elle a produite.
  double hoursToday(Firm f) {
    if (!params.partTime || f.workers.isEmpty) return 1;
    final cap = _capBatches(f, f.effWorkers * perWorker(f));
    return cap > eps ? (f.lastBatches / cap).clamp(minHours, 1.0).toDouble() : 1.0;
  }

  void _payWages() {
    for (final f in firms) {
      final n = f.workers.length;
      if (n == 0) continue;
      if (modules.jobs) {
        _payContracts(f);
        continue;
      }
      final wage = f.wage * hoursToday(f);
      final bill = wage * n;
      final each = f.money >= bill ? wage : f.money / n;
      final t = params.taxRate;
      // assurance-emploi (I3) : cotisation sur la rémunération assurable, plafonnée au salaire moyen
      final ins = modules.insurance;
      final cot = ins ? math.min(each, insurableCap()) * params.eiRate : 0.0;
      var net = 0.0, tax = 0.0, premiums = 0.0;
      for (final id in f.workers) {
        final c = _cmap[id]!;
        final a = transfer(f, c, each * (1 - t) - cot);
        net += a;
        tax += transfer(f, state, each * t);
        if (ins) {
          premiums += transfer(f, state, cot);
          c.lastWage = wage;
          c.insuredDays++;
        }
        c.income += a;
      }
      f.wagesPaid = net + tax + premiums;
      f.costs += net + tax + premiums;
      state.taxes += tax;
      state.taxesToday += tax;
      state.eiPremiums += premiums;
      if (each > 0) {
        _flow(f.id.toString(), 'M', '\$salaires', n.toDouble(), net);
        if (tax > 0) _flow('M', 'E', '\$impôts', 1, tax);
      }
      if (trace != null) {
        _t('compta', 'salaires', f.name, f.id, 'paie', '$n employé(s)', net + tax + premiums,
            'net ${fmtMoney0(net)}, impôt ${fmtMoney0(tax)}, cotisations ${fmtMoney0(premiums)}'
                '${each < wage - eps ? ' ; salaires versés en partie' : ''}');
      }
      if (each < wage - eps) {
        // ne peut pas payer : mise à pied du dernier embauché
        final c = _cmap[f.workers.last];
        _fire(f, c, 'salaires impayables : mise à pied du dernier embauché');
        f.vacancies = 0;
        if (day - f.lastDistressLog > 10) {
          _log('warn', '${f.name} ne peut plus payer ses salaires — mise à pied.');
          f.lastDistressLog = day;
        }
      }
    }
  }

  /// Paie du module jobs : chaque employé reçoit le salaire de son contrat ; si la caisse ne suffit pas, tous sont payés
  /// dans la même proportion et le dernier embauché est mis à pied (même règle que le salaire unique).
  void _payContracts(Firm f) {
    final n = f.workers.length;
    final hours = hoursToday(f);
    var bill = 0.0;
    for (final id in f.workers) {
      bill += _cmap[id]!.wage * hours;
    }
    final k = f.money >= bill ? 1.0 : f.money / bill;
    final t = params.taxRate;
    final ins = modules.insurance;
    final capIns = ins ? insurableCap() : 0.0;
    var net = 0.0, tax = 0.0, premiums = 0.0;
    for (final id in f.workers) {
      final c = _cmap[id]!;
      final wage = c.wage * hours;
      final each = k < 1 ? wage * k : wage;
      final cot = ins ? math.min(each, capIns) * params.eiRate : 0.0;
      final a = transfer(f, c, each * (1 - t) - cot);
      net += a;
      tax += transfer(f, state, each * t);
      if (ins) {
        premiums += transfer(f, state, cot);
        c.lastWage = wage;
        c.insuredDays++;
      }
      c.income += a;
    }
    f.wagesPaid = net + tax + premiums;
    f.costs += net + tax + premiums;
    state.taxes += tax;
    state.taxesToday += tax;
    state.eiPremiums += premiums;
    if (net > 0) {
      _flow(f.id.toString(), 'M', '\$salaires', n.toDouble(), net);
      if (tax > 0) _flow('M', 'E', '\$impôts', 1, tax);
    }
    if (trace != null) {
      _t('compta', 'salaires', f.name, f.id, 'paie (contrats)', '$n employé(s)', net + tax + premiums,
          'net ${fmtMoney0(net)}, impôt ${fmtMoney0(tax)}, cotisations ${fmtMoney0(premiums)}'
              '${k < 1 ? ' ; salaires versés en partie' : ''}');
    }
    if (k < 1) {
      final c = _cmap[f.workers.last];
      _fire(f, c, 'salaires impayables : mise à pied du dernier embauché');
      f.vacancies = 0;
      if (day - f.lastDistressLog > 10) {
        _log('warn', '${f.name} ne peut plus payer ses salaires — mise à pied.');
        f.lastDistressLog = day;
      }
    }
  }

  /// Le bien est un service public gratuit, financé par enveloppe (institution I2).
  bool publicGood(String g) =>
      modules.publicBudget &&
      ((g == 'soins' && modules.health && modules.publicHealth) ||
          (g == 'cours' && modules.education && modules.publicEducation));

  /// Établissement public : il produit un service public gratuit (hôpital, école).
  bool publicService(Firm f) => f.outputs.keys.any(publicGood);

  /// Coût quotidien de l'équipe nécessaire à la demande attendue d'un établissement public, telle que la règle
  /// d'embauche permet de la constituer : l'effectif actuel plus les postes qu'elle ouvrirait aujourd'hui (au plus 3,
  /// et rien de plus si les intrants manquent), les intrants de ce que cette équipe peut produire, les services.
  /// Financer l'équipe théorique de la demande entière accumulerait l'argent du trésor dans un établissement qui ne peut
  /// pas l'employer (constaté : 500 000 $ dans un hôpital privé d'électronique).
  double serviceBudget(Firm f) {
    final nw = f.workers.length;
    final team = math.max(1, math.min(math.max(f.desired, nw), nw + maxPostsPerDay));
    final avgEff = nw > 0 ? math.max(0.3, f.effWorkers / nw) : 1.0;
    final batches = math.min(_plannedBatches(f), team * math.max(eps, perWorker(f) * avgEff));
    var inputs = 0.0;
    for (final e in f.inputs.entries) {
      inputs += batches * e.value * bestPrice(e.key);
    }
    return team * f.wage + inputs + f.overheadEma;
  }

  /// Enveloppe budgétaire des établissements publics (institution I2). L'État porte la trésorerie de chacun à
  /// `publicCashDays` jours du coût de l'équipe nécessaire : il rembourse ainsi chaque jour ce qui a été dépensé, dans la
  /// limite de ce coût. Au-dessus de son plancher, si le trésor ne suffit pas, toutes les enveloppes baissent dans la
  /// même proportion (et les files s'allongent). Un budget non dépensé revient au trésor.
  void _publicBudget() {
    for (final st in services.values) {
      st.envelopeToday = 0;
      st.wantedToday = 0;
    }
    final list = firms.where(publicService).toList();
    if (list.isEmpty) return;
    final want = <double>[];
    var total = 0.0;
    for (final f in list) {
      final target = params.publicCashDays * serviceBudget(f);
      final st = services[f.outputs.keys.firstWhere(publicGood)]!;
      if (f.money > 1.5 * target) {
        final back = transfer(f, state, f.money - target);
        st.envelopeTotal -= back;
        _flow(f.id.toString(), 'E', '\$budget non dépensé', 1, back);
        if (trace != null) {
          _t('institutions', 'budget_non_depense', f.name, f.id, 'I2 : enveloppe budgétaire',
              'trésorerie au-delà de 1,5 fois la cible', back, 'cible ${fmtMoney0(target)}');
        }
      }
      final w = math.max(0.0, target - f.money);
      want.add(w);
      total += w;
      st.wantedToday += w;
    }
    final avail = math.max(0.0, state.money - _stateFloor());
    final k = total > avail ? avail / total : 1.0;
    final short = <ServiceStats>{};
    for (var i = 0; i < list.length; i++) {
      if (want[i] <= 0) continue;
      final f = list[i];
      final g = f.outputs.keys.firstWhere(publicGood);
      final st = services[g]!;
      if (k < 1) short.add(st);
      final amt = transfer(state, f, want[i] * k);
      f.revenue += amt;
      st.envelopeToday += amt;
      st.envelopeTotal += amt;
      state.paid += amt;
      state.paidToday += amt;
      if (g == 'soins') {
        state.healthPaid += amt;
      } else {
        state.educationPaid += amt;
      }
      _flow('E', f.id.toString(), '\$enveloppe', 1, amt);
      if (trace != null) {
        _t('institutions', 'enveloppe', f.name, f.id, 'I2 : enveloppe budgétaire',
            k < 1 ? 'trésor insuffisant : ${fmtPct(k)} de l’enveloppe' : 'trésorerie ramenée à la cible', amt,
            'voulu ${fmtMoney0(want[i])}');
      }
    }
    for (final st in short) {
      st.shortDays++;
    }
  }

  /// Prend une unité de service public produite aujourd'hui chez un établissement public ; faux s'il n'en reste plus.
  bool _takePublic(String g) {
    for (final f in sellersOf(g)) {
      if (!publicService(f)) continue;
      final q = f.inv[g] ?? 0;
      if (q >= 1 - eps) {
        _setStock(f, g, q - 1);
        f.sold[g] = (f.sold[g] ?? 0) + 1;
        _flow(f.id.toString(), 'M', g, 1, 0);
        return true;
      }
    }
    return false;
  }

  void _served(ServiceStats st, int wait) {
    st.servedToday++;
    st.servedTotal++;
    st.servedWait = 0.95 * st.servedWait + 0.05 * wait;
  }

  void _queueStats(ServiceStats st, List<int> queue, int? Function(Citizen) since) {
    st.queue = queue.length;
    var sum = 0;
    for (final id in queue) {
      sum += day - (since(_cmap[id]!) ?? day);
    }
    st.queueAge = queue.isEmpty ? 0 : sum / queue.length;
  }

  /// Soins et cours publics gratuits, servis par ordre d'arrivée avec la capacité produite aujourd'hui (I2).
  /// Ce qui reste à servir est noté comme demande non servie : c'est le signal d'embauche de l'établissement.
  void _serveQueues() {
    if (publicGood('soins')) {
      final st = services['soins']!;
      st.servedToday = 0;
      final rest = <int>[];
      var backlog = 0;
      var open = true;
      for (final id in careQueue) {
        final c = _cmap[id];
        if (c == null) continue; // a quitté l'économie
        // jusqu'à trois visites, comme une consultation payée
        var h = c.health, n = 0;
        while (open && n < 3 && h < 0.95) {
          if (!_takePublic('soins')) {
            open = false;
            break;
          }
          h = math.min(1.0, h + 0.3);
          n++;
        }
        if (n == 0) {
          rest.add(id);
          backlog += math.min(3, ((0.95 - h) / 0.3).ceil());
          continue;
        }
        c.sat['sante'] = h;
        _served(st, day - c.careSince!);
        c.careSince = null;
      }
      careQueue
        ..clear()
        ..addAll(rest);
      _queueStats(st, careQueue, (c) => c.careSince);
      if (backlog > 0) unmet['soins'] = (unmet['soins'] ?? 0) + backlog;
    }
    if (publicGood('cours')) {
      final st = services['cours']!;
      st.servedToday = 0;
      final rest = <int>[];
      var open = true;
      for (final id in schoolQueue) {
        final c = _cmap[id];
        if (c == null) continue;
        if (!open || !_takePublic('cours')) {
          open = false;
          rest.add(id);
          continue;
        }
        c.skill = math.min(3.0, c.skill + params.learnRate);
        _served(st, day - c.schoolSince!);
        c.schoolSince = null;
      }
      schoolQueue
        ..clear()
        ..addAll(rest);
      _queueStats(st, schoolQueue, (c) => c.schoolSince);
      if (rest.isNotEmpty) unmet['cours'] = (unmet['cours'] ?? 0) + rest.length;
    }
  }

  /// Lots que l'entreprise prévoit de produire (demande prévue et réassort du stock visé).
  double plannedBatches(Firm f) => _plannedBatches(f);

  /// Règle d'embauche : pour ouvrir un poste, il faut en caisse ce nombre de jours de salaire pour chaque employé,
  /// nouveaux compris.
  static const int hireCashDays = 8;

  /// Règle d'embauche : au plus ce nombre de postes ouverts par jour.
  static const int maxPostsPerDay = 3;

  /// Postes que la trésorerie permet d'ouvrir (négatif si elle ne couvre même pas l'équipe actuelle).
  int affordablePosts(Firm f) => (f.money / (f.wage * hireCashDays)).floor() - f.workers.length;

  double _plannedBatches(Firm f) {
    final g0 = f.g0;
    final per = f.outputs[g0]!;
    final d = f.demandEma[g0] ?? 0;
    double target;
    if (goods[g0]!.perish) {
      target = d * 1.05;
    } else {
      target = d + (params.invTargetDays * d - (f.inv[g0] ?? 0)) / 10;
    }
    return _capBatches(f, math.max(0.0, target / per));
  }

  void _buyInputs() {
    // prix et stocks des vendeurs, relevés une fois par bien : pendant cette phase les prix ne changent pas et les stocks
    // des vendeurs ne font que baisser (un acheteur ne vend pas ce qu'il achète), comme pendant la consommation
    _quoteCache = {};
    for (final f in _ordered(firms, Flux.achats, (f) => f.id)) {
      if (f.inputs.isNotEmpty) {
        // on n'achète pas plus de matière que l'équipe peut transformer
        final crew = (f.workers.length + f.vacancies) * perWorker(f) * 1.2;
        final plan = math.min(math.max(_plannedBatches(f), f.lastBatches), _capBatches(f, crew));
        final want = <String, double>{};
        var wantValue = 0.0;
        for (final e in f.inputs.entries) {
          final target = plan * e.value * 5;
          final deficit = target - (f.inv[e.key] ?? 0);
          if (deficit > eps) {
            want[e.key] = deficit;
            wantValue += deficit * bestPrice(e.key);
          }
        }
        if (wantValue > 0) {
          final budget = math.max(0.0, f.money - 5 * f.wage * f.workers.length);
          for (final e in want.entries) {
            final share = budget * (e.value * bestPrice(e.key)) / wantValue;
            final r = buy(f, f.id.toString(), e.key, e.value, math.min(share, f.money), false);
            _setStock(f, e.key, (f.inv[e.key] ?? 0) + r.qty);
            f.costs += r.spent;
            f.inputSpend += r.spent;
          }
        }
      }
      _buyServices(f);
    }
    _quoteCache = null;
  }

  /// Services aux entreprises : comptabilité, entretien, publicité, recherche et développement.
  void _buyServices(Firm f) {
    final p = params;
    final m = modules;
    final t = f.template;
    final key = f.id.toString();
    final keep = 3 * f.wage * f.workers.length;
    double avail() => math.max(0.0, f.money - keep);
    double purchase(String g, double q, double budget) {
      final r = buy(f, key, g, q, budget, false);
      f.costs += r.spent;
      f.overhead += r.spent;
      return r.qty;
    }

    // comptabilité : toute entreprise en a besoin, selon sa taille
    if (!m.accounting || f.outputs.containsKey('compta')) {
      f.adminCover = 1;
    } else {
      final need = 0.1 + 0.03 * f.workers.length;
      final got = purchase('compta', need, avail());
      f.adminCover = 0.8 * f.adminCover + 0.2 * math.min(1.0, got / need);
    }
    // entretien des machines (et des opérations, pour l'industrie lourde)
    final mt = t.maint;
    if (!m.capital || mt == null || f.outputs.containsKey(mt)) {
      f.maintToday = 1;
      f.maintCover = 1;
    } else {
      final need = p.maintNeed * f.machines + (t.heavy ? 0.06 * f.workers.length : 0);
      final cover = need > eps ? math.min(1.0, purchase(mt, need, avail()) / need) : 1.0;
      f.maintToday = cover;
      f.maintCover = 0.85 * f.maintCover + 0.15 * cover;
    }
    // publicité : une part du chiffre d'affaires, tant que l'entreprise est rentable
    if (m.marketing && t.ads && f.profitEma > 0) {
      final budget = math.min(avail(), p.adsShare * f.revenueEma);
      final pp = bestPrice('pub');
      if (budget > 0.05 * pp) f.brand += purchase('pub', budget / pp, budget);
    }
    // recherche et développement : une part de la trésorerie excédentaire
    final rd = t.rnd;
    if (m.rnd && rd != null && f.profitEma > 0) {
      final reserve = 8 * (f.wage * f.workers.length + f.inputSpendEma);
      final budget = p.rndShare * math.max(0.0, f.money - reserve);
      final pr = bestPrice(rd);
      if (budget > 0.1 * pr) {
        f.rndProgress += purchase(rd, budget / pr, budget);
        final cost = rndCost(f.techLevel);
        if (f.rndProgress >= cost) {
          f.rndProgress -= cost;
          f.techLevel++;
          _log('info',
              '${f.name} passe à la technologie de niveau ${f.techLevel} (productivité ×${techMult(f).toStringAsFixed(2)}).');
        }
      }
    }
  }

  void _consume() {
    final p = params;
    consumeClock.start();
    _quoteCache = {};
    needCost = _needCost();
    // pression publicitaire : notoriété des vendeurs de chaque bien
    hype = {};
    var totalBrand = 0.0;
    if (modules.marketing) {
      for (final f in firms) {
        if (f.brand <= eps) continue;
        totalBrand += f.brand;
        for (final g in f.outputs.keys) {
          hype[g] = (hype[g] ?? 0) + f.brand;
        }
      }
    }
    adsBoost = 1 + p.adsEffect * totalBrand / (totalBrand + 0.3 * math.max(1, citizens.length));
    _prepareLeisure();
    final floor = _stateFloor();
    if (bankingActive) _creditMorning(); // exposition du matin (I4 des crédits du jour), resserrement des banques

    for (final c in _ordered(citizens, Flux.consommation, (c) => c.id)) {
      if (bankingActive || c.card > 0 || c.loans.isNotEmpty) _citizenCredit(c); // module banking
      final before = c.money;
      for (final d in desires) {
        if (d != 'sante') c.sat[d] = math.max(0.0, c.sat[d]! - desireDecay[d]!);
      }
      // 1. manger : l'aliment qui rassasie le mieux pour son prix, selon ses goûts
      for (var n = 0; n < 5 && c.sat['faim']! < 1 - eps; n++) {
        final g = _choose(c, foods, 'faim', c.money, null, signal: n == 0);
        if (g == null) break;
        final r = buy(c, 'M', g, 1, c.money, true);
        if (r.qty < 1) break;
        _enjoy(c, g);
      }
      c.hungerDays = c.sat['faim']! < 0.5 ? c.hungerDays + 1 : 0;
      // 2. se loger
      // un propriétaire-occupant habite chez lui (module buildings) : pas de nuitée à payer
      final rl = c.homeId != null ? const BuyResult(1, 0) : buy(c, 'M', 'logement', 1, c.money, true);
      c.homeless = rl.qty < 1;
      c.homelessDays = c.homeless ? c.homelessDays + 1 : 0;
      c.sat['logement'] = c.homeless ? 0 : 1;
      // 3. se soigner, s'équiper, se former
      _health(c, floor);
      _computer(c);
      if (modules.education) _study(c, floor);
      // 4. se faire plaisir avec une part de l'épargne au-delà du coussin
      _leisure(c);
      c.spend = before - c.money;
      householdSpend += c.spend;
      c.happiness = happinessOf(c);
    }
    if (modules.publicBudget) _serveQueues();
    _quoteCache = null;
    consumeClock.stop();
  }

  /// Le bien qui apporte le plus de satisfaction par dollar, parmi ceux en stock et abordables.
  /// Si le favori manque, la demande non servie est notée (signal pour son producteur).
  String? _choose(Citizen c, List<String> list, String desire, double budget, Map<String, int>? counts,
      {bool signal = false}) {
    final lvl = c.level;
    String? best, top;
    var bestScore = 0.0, topScore = 0.0;
    for (final g in list) {
      final u = uses[g]!;
      final pts = u.pts[desire] ?? 0;
      if (pts <= 0) continue;
      final h = hype[g] ?? 0;
      final n = (counts?[g] ?? 0) / (dailyNorm[g] ?? 1);
      final appeal = u.taste[lvl] * pts * (1 + 0.4 * h / (h + 10)) / (1 + n * n);
      final q = quote(g);
      final s0 = appeal / math.max(0.01, q.isFinite ? q : bestPrice(g)); // bestPrice(g) = q quand q est fini
      if (s0 > topScore) {
        topScore = s0;
        top = g;
      }
      if (!q.isFinite || q > budget) continue;
      final s = appeal / math.max(0.01, q);
      if (s > bestScore) {
        bestScore = s;
        best = g;
      }
    }
    if (signal && top != null && top != best && !quote(top).isFinite) unmet[top] = (unmet[top] ?? 0) + 1;
    return best;
  }

  void _enjoy(Citizen c, String g) {
    for (final e in uses[g]!.pts.entries) {
      c.sat[e.key] = math.min(1.0, c.sat[e.key]! + e.value);
    }
  }

  /// Usure lente, maladies au hasard ; sous 75 % on consulte (aux frais de l'État si la santé est publique).
  void _health(Citizen c, double floor) {
    final p = params;
    if (!modules.health) {
      c.sat['sante'] = 1;
      return;
    }
    // variante A1 : pas d'usure les jours où le citoyen est nourri et logé
    final wear = p.healthWearIfDeprived && c.hungerDays == 0 && !c.homeless ? 0.0 : desireDecay['sante']!;
    var h = c.health - wear;
    if (draw(Flux.maladie, c.id) < p.illness) h -= 0.2 + 0.3 * draw(Flux.maladie, c.id, 1);
    h = h.clamp(0.05, 1.0).toDouble();
    if (publicGood('soins')) {
      // soins publics gratuits : on s'inscrit dans la file de l'hôpital, servie par ordre d'arrivée (I2)
      if (h < 0.75 && c.careSince == null) {
        c.careSince = day;
        careQueue.add(c.id);
      }
      c.sat['sante'] = h;
      return;
    }
    if (h < 0.75) {
      for (var n = 0; n < 3 && h < 0.95; n++) {
        final pub = modules.publicHealth && state.money > floor;
        final r = buy(pub ? state : c, 'M', 'soins', 1, pub ? state.money - floor : c.money, true, forCitizen: c);
        if (r.qty < 1) break;
        h = math.min(1.0, h + 0.3);
        if (pub) {
          state.paid += r.spent;
          state.paidToday += r.spent;
          state.healthPaid += r.spent;
          _flow('E', 'M', '\$santé publique', 1, r.spent);
        }
      }
    }
    c.sat['sante'] = h;
  }

  /// Un ordinateur dure un an et divertit chaque jour ; techniciens et professionnels y tiennent.
  void _computer(Citizen c) {
    if (c.computerDays > 0) {
      c.computerDays--;
      c.sat['divertissement'] = math.min(1.0, c.sat['divertissement']! + 0.08);
      return;
    }
    if (draw(Flux.ordinateur, c.id) >= computerWish[c.level] * adsBoost) return;
    final pr = quote('ordinateur');
    if (!pr.isFinite) {
      unmet['ordinateur'] = (unmet['ordinateur'] ?? 0) + 1;
      return;
    }
    if (c.money - params.bufferDays * needCost < 2 * pr) return;
    final r = buy(c, 'M', 'ordinateur', 1, c.money, true);
    if (r.qty >= 1) c.computerDays = params.computerLife;
  }

  /// Les ambitieux suivent des cours ; la qualification monte d'un cran tous les 50 cours.
  void _study(Citizen c, double floor) {
    final p = params;
    if (c.skill >= 3 || draw(Flux.etudes, c.id) >= c.ambition * p.eduRate) return;
    if (publicGood('cours')) {
      // cours publics gratuits : on s'inscrit dans la file de l'école (I2)
      if (c.schoolSince == null) {
        c.schoolSince = day;
        schoolQueue.add(c.id);
      }
      return;
    }
    final pub = modules.publicEducation && state.money > floor;
    if (!pub) {
      final pr = quote('cours');
      if (pr.isFinite && c.money - p.bufferDays * needCost < 10 * pr) return;
    }
    final r = buy(pub ? state : c, 'M', 'cours', 1, pub ? state.money - floor : c.money, true, forCitizen: c);
    if (r.qty < 1) return;
    c.skill = math.min(3.0, c.skill + p.learnRate);
    if (pub) {
      state.paid += r.spent;
      state.paidToday += r.spent;
      state.educationPaid += r.spent;
      _flow('E', 'M', '\$éducation publique', 1, r.spent);
    }
  }

  /// Budget discrétionnaire du jour : C = α₁ · (revenu − besoins) + α₂ · (richesse − coussin), à la Godley-Lavoie.
  /// Chaque ménage converge vers T jours de revenu discrétionnaire ; personne n'accumule sans fin.
  /// La publicité accélère la dépense de l'épargne (richesse visée T / adsBoost) ; elle ne fait pas dépenser
  /// plus que le revenu, ce qui viderait les ménages puis ferait monter les prix.
  double leisureBudget(Citizen c) {
    final p = params;
    final excess = math.max(0.0, c.money - p.bufferDays * needCost);
    final income = math.max(0.0, c.incomeEma - needCost);
    return p.mpcIncome * income + p.propensity * adsBoost * excess;
  }

  /// Dépenses discrétionnaires : le budget du jour, réparti entre divertissement et luxe selon la classe,
  /// puis dépensé bien par bien (le plus de satisfaction par dollar, lassitude comprise).
  // ---- choix des loisirs (performance) : ce qui ne change pas pendant la consommation est calculé une fois par jour,
  // et les achats du jour d'un citoyen sont comptés dans un petit tableau plutôt que dans une table par nom de bien.
  static const List<String> _lzDesires = ['divertissement', 'luxe'];
  static const List<String> _lzGoods = ['tele', 'loisirs', 'repas', 'hotel', 'voyage', 'bijoux']; // les 6 biens des deux listes
  late final List<List<int>> _lzSlot = [
    for (final d in _lzDesires) [for (final g in desireGoods[d]!) _lzGoods.indexOf(g)]
  ]; // case du compteur de chaque bien de chaque liste (un bien présent dans les deux listes partage sa case)
  late final List<double> _lzNorm = [for (final g in _lzGoods) dailyNorm[g] ?? 1];
  List<List<List<double>>> _lzBase = const []; // [désir][niveau][bien] : attrait avant la lassitude (NaN : bien sans ce désir)
  List<List<_BestOffers>> _lzOffers = const []; // [désir][bien]
  final List<int> _lzCounts = List<int>.filled(6, 0);

  /// Début de la consommation : l'attrait de base de chaque bien de loisir (selon le niveau du citoyen) ne dépend que de
  /// la pression publicitaire du jour ; les meilleures offres de chaque bien sont relevées une fois.
  void _prepareLeisure() {
    final cache = _quoteCache!;
    _lzBase = [
      for (final d in _lzDesires)
        [
          for (var lvl = 0; lvl < 3; lvl++)
            [
              for (final g in desireGoods[d]!)
                () {
                  final u = uses[g]!;
                  final pts = u.pts[d] ?? 0;
                  if (pts <= 0) return double.nan;
                  final h = hype[g] ?? 0;
                  return u.taste[lvl] * pts * (1 + 0.4 * h / (h + 10));
                }()
            ]
        ]
    ];
    _lzOffers = [
      for (final d in _lzDesires) [for (final g in desireGoods[d]!) cache[g] ??= _BestOffers(this, g)]
    ];
  }

  /// Le bien de la liste [di] (index) qui apporte le plus de satisfaction par dollar, comme `_choose` : même formules, mêmes
  /// comparaisons, dans le même ordre ; rend -1 s'il n'y en a pas d'abordable.
  int _chooseLeisure(Citizen c, int di, double budget, {bool signal = false}) {
    final list = desireGoods[_lzDesires[di]]!;
    final base = _lzBase[di][c.level];
    final slot = _lzSlot[di];
    final offers = _lzOffers[di];
    var best = -1, top = -1;
    var bestScore = 0.0, topScore = 0.0;
    for (var j = 0; j < list.length; j++) {
      final b = base[j];
      if (b.isNaN) continue;
      final n = _lzCounts[slot[j]] / _lzNorm[slot[j]];
      final appeal = b / (1 + n * n);
      final q = verifyFastPaths ? quote(list[j]) : offers[j].quote();
      final s0 = appeal / math.max(0.01, q.isFinite ? q : bestPrice(list[j])); // bestPrice(g) = q quand q est fini
      if (s0 > topScore) {
        topScore = s0;
        top = j;
      }
      if (!q.isFinite || q > budget) continue;
      final s = appeal / math.max(0.01, q);
      if (s > bestScore) {
        bestScore = s;
        best = j;
      }
    }
    if (signal && top >= 0 && top != best && !quote(list[top]).isFinite) {
      unmet[list[top]] = (unmet[list[top]] ?? 0) + 1;
    }
    return best;
  }

  void _leisure(Citizen c) {
    final budget = math.min(leisureBudget(c), c.money);
    if (budget <= eps) return;
    final lvl = c.level;
    final wDiv = desireWeight['divertissement']![lvl] * (0.25 + math.max(0.0, 1 - c.sat['divertissement']!));
    final wLux = desireWeight['luxe']![lvl] * (0.25 + math.max(0.0, 1 - c.sat['luxe']!));
    _lzCounts.fillRange(0, _lzCounts.length, 0);
    for (var di = 0; di < 2; di++) {
      final d = _lzDesires[di];
      final list = desireGoods[d]!;
      var share = budget * (d == 'luxe' ? wLux : wDiv) / (wDiv + wLux);
      for (var k = 0; k < 60 && share > eps; k++) {
        var j = _chooseLeisure(c, di, share, signal: k == 0);
        if (j < 0) {
          // rien d'abordable avec ce budget : on s'offre le favori de temps en temps (en moyenne, le budget)
          j = _chooseLeisure(c, di, double.infinity);
          if (j < 0 || draw(Flux.loisirs, c.id, di * 64 + k) >= share / quote(list[j])) break;
        }
        final g = list[j];
        final r = buy(c, 'M', g, 1, c.money, true);
        if (r.qty < 1) break;
        _enjoy(c, g);
        _lzCounts[_lzSlot[di][j]]++;
        share -= r.spent;
      }
    }
  }

  /// Bonheur : moyenne des satisfactions, pondérée selon ce qui compte pour sa classe.
  double happinessOf(Citizen c) {
    final lvl = c.level;
    var s = 0.0, w = 0.0;
    for (final d in desires) {
      final k = happinessWeight[d]![lvl];
      s += k * c.sat[d]!;
      w += k;
    }
    return s / w;
  }

  // ================================================================ Filets de sécurité

  /// Enregistre un déclenchement : compté, journalisé (jour, agent, montant, raison), résumé dans le journal du jour.
  void _net(String net, String agent, double amount, String cause, [String detail = '', int? id]) {
    nets.add(NetEvent(day, net, agent, amount, detail.isEmpty ? cause : '$cause — $detail'), cause);
    if (trace != null) _t('filets', net, agent, id, 'filet : ${Safeguards.labels[net]}', cause, amount, detail);
  }

  /// Pourquoi ce citoyen n'arrive pas à manger.
  String famineCause(Citizen c) {
    var cheapest = double.infinity;
    for (final g in foods) {
      cheapest = math.min(cheapest, quote(g));
    }
    if (!cheapest.isFinite) return 'pas de producteur';
    if (c.income <= eps && c.money < cheapest) return 'pas de revenu';
    return 'prix trop élevé';
  }

  /// Pourquoi ce citoyen n'a pas de logis.
  String shelterCause(Citizen c) {
    final q = quote('logement');
    if (!q.isFinite) return 'parc plein';
    if (c.income <= eps && c.money < q) return 'pas de revenu';
    return 'prix trop élevé';
  }

  void _safetyNets() {
    final sg = safeguards;
    if (!sg.famine && !sg.shelter) return;
    for (final c in citizens) {
      if (sg.famine && c.hungerDays >= sg.famineDays) _famineAid(c);
      if (sg.shelter && c.homelessDays >= sg.shelterDays) _shelterAid(c);
    }
  }

  /// Anti-famine : l'État achète de quoi manger ; à défaut (aucun stock, trésor vide), une ration magique.
  void _famineAid(Citizen c) {
    final cause = famineCause(c);
    final detail = cause == 'pas de producteur'
        ? 'aucun aliment en stock'
        : 'argent ${fmtMoney0(c.money)}, revenu du jour ${fmtMoney0(c.income)}';
    var spent = 0.0;
    for (var n = 0; n < 4 && c.sat['faim']! < 1 - eps; n++) {
      final g = _choose(c, foods, 'faim', state.money, null);
      if (g == null) break;
      final r = buy(state, 'M', g, 1, state.money, true, forCitizen: c);
      if (r.qty < 1) break;
      _enjoy(c, g);
      spent += r.spent;
    }
    final magic = c.sat['faim']! < 0.5;
    if (magic) c.sat['faim'] = 1; // ration magique : ni bien ni argent
    if (spent > 0) {
      state.paid += spent;
      state.paidToday += spent;
      _flow('E', 'M', '\$aide alimentaire', 1, spent);
    }
    c.hungerDays = 0;
    _net('famine', c.name, spent, cause, magic ? '$detail ; ration magique' : detail, c.id);
  }

  /// Plancher de logement : l'État paie une nuitée ; si le parc est plein, un abri d'urgence (magique).
  void _shelterAid(Citizen c) {
    final cause = shelterCause(c);
    final r = buy(state, 'M', 'logement', 1, state.money, true, forCitizen: c);
    final magic = r.qty < 1;
    if (r.spent > 0) {
      state.paid += r.spent;
      state.paidToday += r.spent;
      _flow('E', 'M', '\$abri d’urgence', 1, r.spent);
    }
    c.homeless = false;
    c.homelessDays = 0;
    c.sat['logement'] = 1;
    _net('shelter', c.name, r.spent, cause,
        magic ? 'abri d’urgence magique' : 'argent ${fmtMoney0(c.money)}, revenu du jour ${fmtMoney0(c.income)}', c.id);
  }

  /// Résumé quotidien des filets déclenchés, dans le journal principal.
  void _netSummary() {
    for (final e in nets.today.entries) {
      final causes = nets.causesToday[e.key]!.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
      final why = causes.take(3).map((c) => '${c.key} ×${c.value}').join(', ');
      _log('net', 'Filet « ${Safeguards.labels[e.key]} » : ${e.value} déclenchement${e.value > 1 ? 's' : ''} ($why).');
    }
    nets.today.clear();
    nets.causesToday.clear();
  }

  void _export() {
    for (final f in firms) {
      for (final g in f.outputs.keys) {
        if (goods[g]!.perish || !goods[g]!.tradable) continue;
        final excess = (f.inv[g] ?? 0) - 8 * math.max(f.demandEma[g] ?? 0, 0.5);
        if (excess <= eps) continue;
        final value = transfer(null, f, excess * worldPrice[g]! * params.exportDiscount);
        _setStock(f, g, (f.inv[g] ?? 0) - excess);
        f.revenue += value;
        ledgerExports += value;
        bank.reserves += value;
        dayFlows.exports += value;
        f.sold[g] = f.sold[g] ?? 0.0; // l'export ne compte pas comme demande locale
        _flow(f.id.toString(), 'X', g, excess, value);
      }
    }
  }

  void _expire() {
    for (final f in firms) {
      for (final g in f.outputs.keys) {
        if (goods[g]!.perish) _setStock(f, g, 0);
      }
    }
  }

  /// Usure des machines, service de la dette, investissement, ristournes de la Caisse.
  void _capital() {
    final p = params;
    final pm = bestPrice('machines');
    for (final f in _ordered(firms, Flux.capital, (f) => f.id)) {
      final key = f.id.toString();
      // usure : deux fois et demie plus rapide sans entretien
      if (modules.capital && f.machines > eps) {
        final cover = f.template.maint == null ? 1.0 : f.maintToday;
        var dep = f.machines * p.depreciation * (1 + 1.5 * (1 - cover));
        if (productsActive && f.machineLife > 0) dep /= f.machineLife; // module products : durabilité des modèles
        f.machines = math.max(0.0, f.machines - dep);
        f.costs += dep * pm; // amortissement : un coût, sans mouvement d'argent
      }
      // service de la dette
      f.interestToday = 0;
      if (f.debt > 0) {
        final interest = quantize(f.debt * loanRate(f, pm) / 365);
        if (f.money >= interest) {
          final paid = transfer(f, bank, interest);
          bank.interest += paid;
          bank.equity += paid;
          if (banks.isNotEmpty) _attrib(f.bankId, paid, income: paid); // module banking
          dayFlows.interest += paid;
          f.costs += paid;
          f.interestToday = paid;
          _flow(key, 'B', '\$intérêts', 1, paid);
          if (trace != null) {
            _t('compta', 'interets', f.name, f.id, 'service de la dette', 'intérêts du jour', paid,
                'dette ${fmtMoney0(f.debt)}');
          }
          final reserve = 6 * (f.wage * f.workers.length + f.inputSpendEma);
          var pay = math.max(f.debt / p.loanTermDays, 5.0);
          if (f.money > 2 * reserve) pay += 0.05 * (f.money - 2 * reserve); // remboursement anticipé
          pay = math.min(pay, math.min(f.debt, math.max(0.0, f.money - 2 * f.wage * f.workers.length)));
          final repaid = transfer(f, null, pay); // le remboursement détruit la monnaie créée par le prêt
          if (repaid > 0) {
            ledgerCredit -= repaid;
            f.debt -= repaid;
            bank.repaid += repaid;
            dayFlows.repaid += repaid;
            _flow(key, 'B', '\$remboursements', 1, repaid);
            if (trace != null) {
              _t('compta', 'remboursement', f.name, f.id, 'service de la dette', 'remboursement du capital', repaid,
                  'reste ${fmtMoney0(f.debt)}');
            }
          }
          f.missedPayments = 0;
        } else {
          f.debt += interest; // intérêts impayés ajoutés à la dette
          bank.capitalized += interest;
          bank.equity += interest;
          if (banks.isNotEmpty) _attrib(f.bankId, interest, income: interest); // module banking
          dayFlows.capitalized += interest;
          f.missedPayments++;
          if (trace != null) {
            _t('credit', 'interets_impayes', f.name, f.id, 'service de la dette', 'trésorerie insuffisante', interest,
                '${f.missedPayments} j de retard');
          }
          if (f.missedPayments > 60) {
            _log('warn', '${f.name} ne rembourse plus : la Caisse radie ${fmtMoney0(f.debt)} de dette.');
            _writeOff(f, 'plus de 60 jours de retard');
            f.creditBanUntil = day + 180;
          }
        }
      }
      if (modules.capital) _invest(f, pm);
    }
    // la Caisse ristourne son surplus à ses membres (tous les citoyens), une fois ses fonds propres au-dessus
    // de la cible (part des prêts) et de son capital de départ
    // module banking, plusieurs banques : la ristourne de la Caisse devient le dividende de chaque banque (_banksDay)
    final surplus = banks.isNotEmpty
        ? 0.0
        : math.min(bank.money, bank.equity - math.max(bank.capital, p.bankTargetRatio * totalDebt()));
    if (surplus > eps && citizens.isNotEmpty && p.bankRebate > 0) {
      final each = surplus * p.bankRebate / citizens.length;
      var total = 0.0;
      for (final c in citizens) {
        final a = transfer(bank, c, each);
        c.income += a;
        total += a;
      }
      bank.rebates += total;
      bank.equity -= total;
      dayFlows.rebates += total;
      _flow('B', 'M', '\$ristournes', 1, total);
      if (trace != null) {
        _t('compta', 'ristourne', 'Caisse', null, 'ristourne du surplus de la Caisse', 'fonds propres au-dessus de la cible',
            total, '${citizens.length} membres');
      }
    }
  }

  /// Faillite ordonnée (I5) : la trésorerie rembourse d'abord la dette envers la Caisse. Comme tout remboursement de
  /// capital, il détruit la monnaie créée par le prêt. Rend le montant remboursé ; le solde éventuel sera radié.
  double _repayFromCash(Firm f) {
    if (f.debt <= 0 || f.money <= 0) return 0;
    final repaid = transfer(f, null, math.min(f.money, f.debt));
    if (repaid <= 0) return 0;
    ledgerCredit -= repaid;
    f.debt -= repaid;
    bank.repaid += repaid;
    dayFlows.repaid += repaid;
    _flow(f.id.toString(), 'B', '\$remboursements', 1, repaid);
    if (trace != null) {
      _t('institutions', 'remboursement_faillite', f.name, f.id, 'I5 : faillite ordonnée',
          'la trésorerie rembourse la Caisse avant tout', repaid, 'reste ${fmtMoney0(f.debt)} à radier');
    }
    return repaid;
  }

  /// La Caisse renonce à la créance : la perte est imputée à ses fonds propres, la monnaie déjà créée reste.
  void _writeOff(Firm f, [String why = '']) {
    if (f.debt <= 0) return;
    if (trace != null) _t('credit', 'radiation', f.name, f.id, 'radiation de créance', why, f.debt);
    bank.writtenOff += f.debt;
    bank.equity -= f.debt;
    if (banks.isNotEmpty) _attrib(f.bankId, -f.debt, loss: f.debt); // module banking
    dayFlows.writtenOff += f.debt;
    f.debt = 0;
    f.missedPayments = 0;
  }

  /// Achète une machine si elle rapporte plus qu'elle ne coûte (intérêts + usure), à crédit au besoin.
  void _invest(Firm f, double pm) {
    final p = params;
    final t = f.template;
    final nw = f.workers.length;
    if (t.capital <= 0 || nw == 0 || day - f.lastInvest < 3 || !pm.isFinite) return;
    final w = nw.toDouble();
    final k = f.machines / w;
    if (k >= 4) return;
    final base = f.rate * f.prodMult * techMult(f) * uptime(f) * adminMult(f) * math.max(0.3, f.effWorkers / w);
    final a = t.capital;
    final mpM = base * a / ((k + 1) * (k + 1)); // lots/jour qu'apporterait une machine de plus
    final mpL = base * (1 + a * k / (k + 1)) - base * a * k / ((k + 1) * (k + 1)); // … un employé de plus
    var margin = 0.0;
    for (final e in f.outputs.entries) {
      margin += e.value * (f.price[e.key] ?? 0);
    }
    for (final e in f.inputs.entries) {
      margin -= e.value * bestPrice(e.key);
    }
    // une équipe déjà sous-employée n'a besoin d'aucune capacité de plus
    if (f.outputEma < 0.8 * w * perWorker(f)) return;
    // si la demande attend, la machine rapporte des ventes ; sinon elle remplace du travail, ce qui suppose
    // de pouvoir se passer d'un employé (impossible sous un employé)
    final growing = f.urgency > 0.05 || (f.vacancies > 0 && f.unfilledDays > 1);
    final value = growing ? mpM * math.max(0.0, margin) : (nw >= 2 ? f.wage * mpM / math.max(eps, mpL) : 0.0);
    final cost = pm * (loanRate(f, pm) / 365 + p.depreciation + 0.001);
    if (value < 1.3 * cost) return;
    final price = quote('machines');
    if (!price.isFinite) {
      unmet['machines'] = (unmet['machines'] ?? 0) + 1;
      return;
    }
    final cash = f.money - 6 * (f.wage * w + f.inputSpendEma);
    if (cash < price) {
      // pas de crédit à une entreprise en perte, ni à un établissement public (l'État le finance)
      if (!modules.credit || day < f.creditBanUntil || f.profitEma <= 0 || publicService(f)) return;
      final need = price - math.max(0.0, cash);
      if (f.debt + need > 0.8 * (f.machines + 1) * price) return; // garantie : 80 % de la valeur des machines
      if ((modules.bankRegulation || safeguards.credit) && !_creditOk(f, need)) return;
      _lend(f, need);
    }
    // module products : le modèle au meilleur gain par dollar parmi les fabricants connus
    final bought = productsActive ? _investBuy(f) : buy(f, f.id.toString(), 'machines', 1, f.money, true).qty;
    if (bought >= 1) {
      f.machines += 1;
      f.lastInvest = day;
    }
  }

  /// Fonds de roulement : une entreprise qui a des clients en attente et vend au-dessus de son coût emprunte
  /// de quoi payer 8 jours de salaires aux postes qu'elle veut ouvrir, dans la limite de 30 jours de chiffre d'affaires.
  void _workingCapital(Firm f, int posts) {
    final p = params;
    if (!modules.credit || posts <= 0 || day < f.creditBanUntil || f.urgency < 0.05) return;
    if (publicService(f)) return; // un établissement public n'emprunte pas : l'État le finance
    // la Caisse ne finance qu'une entreprise durablement rentable, dont les ventes couvrent déjà les salaires
    if (f.profitEma <= 0 || f.revenueEma < f.wage * f.workers.length) return;
    final need = f.wage * 8 * (f.workers.length + posts) - f.money;
    if (need <= 0) return;
    final room = p.workingCapitalDays * f.revenueEma - f.debt;
    final amt = math.min(need, room);
    if (amt < f.wage * 8) return; // pas même de quoi ouvrir un poste
    if ((modules.bankRegulation || safeguards.credit) && !_creditOk(f, amt)) return;
    _lend(f, amt, working: true);
  }

  /// Anti-crédit-fou : plafond paiements/valeur ajoutée et ratio minimal de fonds propres de la Caisse.
  bool _creditOk(Firm f, double need) {
    final sg = safeguards;
    final p = params;
    final pay = (f.debt + need) * (loanRate(f) / 365 + 1 / p.loanTermDays);
    final added = math.max(0.0, f.revenueEma - f.inputSpendEma);
    if (pay > sg.maxPaymentRatio * added) {
      _refuse(f, need, 'paiements > ${fmtPct(sg.maxPaymentRatio, 0)} de la valeur ajoutée',
          '${fmtMoney0(pay)}/j pour ${fmtMoney0(added)}/j de valeur ajoutée');
      return false;
    }
    // module banking, plusieurs banques : les fonds propres et les prêts de la banque de l'entreprise
    final lender = banks.isEmpty ? null : banks[f.bankId < banks.length ? f.bankId : 0];
    final loans = (lender == null ? totalDebt() : lender.riskLoans) + need;
    if ((lender == null ? bank.equity : lender.equityNow) < sg.minCapitalRatio * loans) {
      _refuse(f, need, 'fonds propres de la Caisse insuffisants',
          '${fmtMoney0(bank.equity)} pour ${fmtMoney0(loans)} de prêts (minimum ${fmtPct(sg.minCapitalRatio)})');
      return false;
    }
    return true;
  }

  /// Un prêt refusé : compté par la Caisse ; le filet anti-crédit-fou, s'il est actif, le compte aussi. Avec les règles
  /// prudentielles (I4), le filet n'a plus d'effet propre : c'est la Caisse qui refuse.
  void _refuse(Firm f, double need, String cause, String detail) {
    bank.refusals++;
    if (safeguards.credit) _net('credit', f.name, need, cause, detail, f.id);
    if (trace != null) {
      _t('credit', 'refus', f.name, f.id,
          modules.bankRegulation ? 'I4 : règles prudentielles de la Caisse' : 'filet : anti-crédit-fou', cause, need,
          detail);
    }
  }

  void _lend(Firm f, double amt, {bool working = false}) {
    final a = transfer(null, f, amt); // la Caisse crée la monnaie qu'elle prête
    f.debt += a;
    ledgerCredit += a;
    bank.lent += a;
    if (working) {
      bank.lentWorking += a;
      f.workingDebt += a;
    } else {
      bank.lentMachines += a;
    }
    dayFlows.loans += a;
    _flow('B', f.id.toString(), '\$prêts', 1, a);
    if (trace != null) {
      _t('credit', 'pret', f.name, f.id, working ? 'fonds de roulement' : 'achat de machine',
          working ? 'clients en attente, postes à ouvrir' : 'machine rentable', a, 'dette ${fmtMoney0(f.debt)}');
    }
  }

  // ================================================================ Entrée et sortie d'entreprises

  /// Salaire du marché pour une qualification exigée (moyenne pondérée par les effectifs).
  double marketWage(int skill) {
    var ws = 0.0, wn = 0;
    for (final o in firms) {
      if (o.template.skill != skill) continue;
      ws += o.wage * o.workers.length;
      wn += o.workers.length;
    }
    return wn > 0 ? ws / wn : params.startWage * classWage[skill];
  }

  /// Sortie : une entreprise sans employé depuis 30 jours ferme. Entrée : un bien qui n'a plus de producteur
  /// (ou dont les producteurs ont de fortes marges et laissent de quoi occuper un employé) attire une nouvelle entreprise.
  void _entryExit() {
    final p = params;
    for (final f in List<Firm>.from(firms)) {
      f.idleDays = f.workers.isEmpty ? f.idleDays + 1 : 0;
      if (f.idleDays >= p.exitIdleDays && !publicService(f)) _close(f); // un établissement public ne ferme pas
    }
    if (day < 30) return; // pas pendant le démarrage
    if (modules.entrepreneurship) {
      _entrepreneurship(); // ce sont les citoyens qui fondent, plus la création mécanique ci-dessous
      return;
    }
    // Entonnoir (mesure) : les conditions sont lues dans un ordre qui permet de nommer la première qui manque ; la
    // décision est la même qu'avant (toutes les conditions sont requises, une seule création par jour).
    var created = false;
    for (final ty in templates.keys) {
      final t = templates[ty]!;
      final g = t.outputs.keys.first;
      if (publicGood(g)) continue; // l'État fournit ce service : pas de concurrent privé
      if (g == 'logement' && modules.buildings) continue; // un bailleur sans bâtiment n'a rien à louer : on construit
      // module products, catégorie différenciée : demande non servie ou faiblement servie (voir entryWant)
      final diff = productsActive && isDifferentiated(g);
      final wantD = diff ? entryWant(g) : 0.0;
      final want = diff ? math.max(0.0, wantD) : (unmetEma[g] ?? 0); // unités par jour non servies
      final perWorker0 = t.rate * t.outputs[g]!; // unités par employé et par jour, sans machines
      if (want < p.entryMinShare * perWorker0) continue; // pas de signal : pas de projet
      String? refused;
      String why = '';
      String detail = '';
      final active = sellersOf(g).where((f) => f.workers.isNotEmpty).toList();
      if (created) {
        refused = 'plafond_quotidien';
      } else if (day - (_lastEntry[ty] ?? -100000) < p.entryCooldown) {
        refused = 'delai';
      } else if (active.isEmpty) {
        why = 'plus personne ne produit';
      } else if (day < 100) {
        // concurrence : seulement après le démarrage, si les marges sont fortes et que la demande laissée occupe
        // un employé à plein temps
        (refused, detail) = ('concurrence', 'avant le jour 100');
      } else if (!diff && active.length >= 3) {
        (refused, detail) = ('concurrence', '${active.length} producteurs actifs');
      } else if (diff && wantD < 0) {
        (refused, detail) = ('concurrence', 'marge des variétés en place peu attrayante');
      } else if (want < perWorker0) {
        (refused, detail) = ('demande', 'n’occupe pas un employé');
      } else if (!diff && !active.every((f) => f.profitEma > 0 && f.price[g]! >= p.entryMarginRatio * (f.unitCostCache[g] ?? double.infinity))) {
        (refused, detail) = ('concurrence', 'marges des producteurs en place trop faibles');
      } else {
        why = 'demande non servie et fortes marges';
      }
      refused ??= _found(ty, want, why);
      _funnel('projet', ty, want);
      if (refused == null) {
        created = true; // au plus une création par jour
        _funnel('creation', ty, want);
      } else {
        _funnel(refused, ty, want, detail);
      }
    }
  }

  /// Compte une étape de l'entonnoir de création ; dans le journal complet, chaque refus est un événement.
  void _funnel(String step, String ty, double want, [String detail = '']) {
    entryFunnel[step] = (entryFunnel[step] ?? 0) + 1;
    if (trace != null && step != 'projet' && step != 'creation') {
      _t('entrees_sorties', 'projet_refuse', templates[ty]!.label, null, 'entonnoir de création', step, want,
          detail.isEmpty ? 'demande non servie ${fmtNum1(want)} ${goods[templates[ty]!.outputs.keys.first]!.unit}/j' : detail);
    }
  }

  /// Un citoyen fonde une entreprise de ce type avec son épargne (10 jours de salaires, 5 jours d'intrants).
  /// Rend null si l'entreprise est créée, sinon la cause du refus : main_oeuvre, viabilite ou capital.
  String? _found(String ty, double want, String why) {
    final p = params;
    final t = templates[ty]!;
    final g = t.outputs.keys.first;
    final batches = want / t.outputs[g]!;
    final w = batches / t.rate; // employés nécessaires à productivité nominale
    final team = w.ceil().clamp(1, 3).toInt();
    // module jobs : coût moyen d'un employé de l'organigramme, au salaire affiché du marché
    final wage = modules.jobs ? marketOffer(t.skill) * avgRoleRel(ty) : marketWage(t.skill);
    var inputCost = 0.0;
    for (final e in t.inputs.entries) {
      inputCost += batches * e.value * bestPrice(e.key);
    }
    // une entreprise nouvelle embauche des chômeurs ; au plein emploi, elle ne ferait que débaucher ses voisines
    final available = citizens.where((c) => c.employer == null && c.skill + eps >= t.skill).length;
    if (available < team) return 'main_oeuvre';
    // viabilité : au prix que le marché paie (borné au double du prix mondial), les ventes attendues doivent couvrir
    // l'équipe et ses intrants ; un marché trop petit pour un employé reste sans producteur
    var revenue0 = 0.0;
    for (final e in t.outputs.entries) {
      revenue0 += batches * e.value * math.min(bestPrice(e.key), 2 * worldPrice[e.key]!);
    }
    if (revenue0 < 1.1 * (team * wage + inputCost)) return 'viabilite';
    final capital = 10 * wage * team + 5 * inputCost;
    final buffer = p.bufferDays * needCost;
    Citizen? founder;
    for (final c in citizens) {
      if (c.money - buffer >= 1.5 * capital && (founder == null || c.money > founder.money)) founder = c;
    }
    if (founder == null) return 'capital';
    final same = firms.where((o) => o.type == ty).toList();
    final slot = _slots.remove(ty) ?? (same.isNotEmpty ? [same.last.x, same.last.y + 170] : [600.0, 300.0]);
    final f = _newFirm(ty, '${t.label} ${founder.name.split(' ').last}', 0, founder.id, slot[0], slot[1]);
    // échelle minimale si la demande n'occupe pas un employé ; module products, catégorie différenciée : pas de fraction
    // d'employé, la variété doit faire vivre un employé entier
    f.rate = productsActive && isDifferentiated(g) ? t.rate : t.rate * _minScale(w, 1);
    f.wage = wage;
    if (modules.jobs) {
      f.offer = marketOffer(t.skill);
      _syncWage(f);
    }
    final paid = transfer(founder, f, capital);
    _flow('M', f.id.toString(), '\$capital', 1, paid);
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
    f.vacancies = team;
    _lastEntry[ty] = day;
    firmsCreated++;
    if (trace != null) {
      _t('entrees_sorties', 'creation', f.name, f.id, 'entrée : demande non servie', why, paid,
          'fondateur ${founder.name} ; ${fmtNum1(want)} ${goods[g]!.unit}/j non servis ; équipe $team');
    }
    _log('info', '${founder.name} fonde ${f.name} avec ${fmtMoney0(paid)} : $why '
        '(${goods[g]!.label.toLowerCase()}, ${fmtNum1(want)} ${goods[g]!.unit}/j non servis).');
    return null;
  }

  /// Fermeture faute d'activité : la trésorerie revient au propriétaire, la dette est radiée, la place est libérée.
  /// Cause d'une fermeture (mesure seulement). Une entreprise ferme toujours faute d'employé depuis exitIdleDays
  /// jours ; la cause est ce qui l'y a menée, lue dans cet ordre : prix aberrant (plus de 5 fois le prix de référence
  /// corrigé des salaires), faillite (dernière fin d'emploi faute de pouvoir payer), demande perdue (effectif au-dessus
  /// du plan de production, ou demande lissée quasi nulle), sans employé (départs volontaires, ou postes jamais
  /// pourvus), autre.
  String closeCause(Firm f) {
    final g = f.g0;
    if ((f.price[g] ?? 0) > 5 * referencePrice(g)) return 'prix_aberrant';
    final why = f.lastLoss;
    if (why.startsWith('salaires impayables') || why.startsWith('trésorerie sous')) return 'faillite';
    if (why.startsWith('effectif au-dessus') || (f.demandEma[g] ?? 0) < 0.05) return 'demande_perdue';
    if (why.isEmpty || why.startsWith('départ')) return 'sans_employe';
    return 'autre';
  }

  /// Flux lissés à retirer : ceux des entreprises fermées pendant _entryExit. Une seule passe sur les flux, au lieu d'une
  /// par fermeture (à très grande échelle, chaque fermeture parcourait tous les flux : le quart d'une journée).
  final Set<String> _flowPurge = {};

  void _purgeFlows() {
    if (_flowPurge.isEmpty) return;
    flowsEma.removeWhere((k, v) => _flowPurge.contains(v.from) || _flowPurge.contains(v.to));
    _flowPurge.clear();
  }

  void _close(Firm f) {
    final cause = closeCause(f);
    entryFunnel['fermeture_$cause'] = (entryFunnel['fermeture_$cause'] ?? 0) + 1;
    if (buildings.isNotEmpty) _firmGone(f); // ses bâtiments passent en liquidation (la Caisse les vend)
    final repaid = modules.bankruptcy ? _repayFromCash(f) : 0.0;
    final lost = f.debt;
    _writeOff(f, 'fermeture');
    final owner = f.ownerId != null ? _cmap[f.ownerId!] : null;
    final left = f.money;
    if (left > 0) transfer(f, owner ?? state, left);
    if (trace != null) {
      _t('entrees_sorties', 'fermeture', f.name, f.id, 'sortie : aucun employé depuis ${params.exitIdleDays} jours',
          cause, left, 'trésorerie rendue à ${owner?.name ?? 'l’État'} ; dette remboursée '
              '${fmtMoney0(repaid)}, radiée ${fmtMoney0(lost)}');
    }
    if (repaid > 0 || lost > 0) {
      _log('info', '${f.name} : ${fmtMoney0(repaid)} de dette remboursés par sa trésorerie, ${fmtMoney0(lost)} radiés.');
    }
    _slots[f.type] = [f.x, f.y];
    firms.remove(f);
    _fmap.remove(f.id);
    _rebuildSellers();
    _flowPurge.add(f.id.toString()); // ses flux lissés sont retirés en une passe à la fin de _entryExit (_purgeFlows)
    firmsClosed++;
    if (productsActive) _productGone(f, '${f.name} ferme : ${SimEntrepreneurship.closeReasons[cause] ?? cause}');
    if (modules.entrepreneurship) {
      _entClosed(f, cause, left, owner);
      return;
    }
    _log('info', '${f.name} ferme ses portes : aucun employé depuis ${params.exitIdleDays} jours'
        '${left > 0 ? ' (${fmtMoney0(left)} rendus à ${owner?.name ?? 'l’État'})' : ''}.');
  }

  /// Applique le plafond de dérive à une nouvelle valeur (prix ou salaire) ; journalise chaque plafonnement.
  double _capDrift(Firm f, double old, double next, String kind, String what) {
    if (!safeguards.drift || old <= 0) return next;
    final m = safeguards.maxDailyChange;
    final hi = old * (1 + m), lo = old * (1 - m);
    if (next <= hi && next >= lo) return next;
    final capped = next > hi ? hi : lo;
    final up = next > hi;
    _net('drift', f.name, (next - capped).abs(), '${up ? 'hausse' : 'baisse'} de $kind',
        '$what : ${fmtPct(next / old - 1)} ramené à ${fmtPct(capped / old - 1)}', f.id);
    return capped;
  }

  void _decide() {
    final p = params;
    final n = citizens.length;
    final unemp = n > 0 ? citizens.where((c) => c.employer == null).length / n : 0.0;

    // répartir la demande non servie entre les producteurs du bien
    for (final e in unmet.entries) {
      final s = sellersOf(e.key);
      for (final f in s) {
        f.unmetShare[e.key] = e.value / s.length;
      }
    }

    // salaire de référence par qualification exigée (norme du marché du travail)
    final wsum = [0.0, 0.0, 0.0];
    final wn = [0, 0, 0];
    for (final f in firms) {
      final s = f.template.skill;
      wsum[s] += f.wage * f.workers.length;
      wn[s] += f.workers.length;
    }
    final norm = [for (var s = 0; s < 3; s++) wn[s] > 0 ? wsum[s] / wn[s] : p.startWage * classWage[s]];
    // module jobs : la norme porte sur les salaires affichés (les contrats ne bougent pas avec l'offre)
    final normOffer = modules.jobs ? [for (var s = 0; s < 3; s++) marketOffer(s)] : norm;
    final tw = wn[0] + wn[1] + wn[2];
    avgWage = tw > 0 ? (wsum[0] + wsum[1] + wsum[2]) / tw : p.startWage;
    final baseMk = p.markup - 1;

    for (final f in firms) {
      f.revenueEma = 0.9 * f.revenueEma + 0.1 * f.revenue;
      f.overheadEma = 0.9 * f.overheadEma + 0.1 * f.overhead;
      f.brand *= 0.97; // la notoriété s'estompe sans nouvelles campagnes
      final cost = unitCost(f);
      f.unitCostCache = cost;
      for (final g in f.outputs.keys) {
        final um = f.unmetShare[g] ?? 0;
        f.unmetShare[g] = 0;
        final demand = (f.sold[g] ?? 0) + um;
        if (g == f.g0) f.urgency = demand > eps ? um / demand : 0.0;
        f.demandEma[g] = 0.85 * (f.demandEma[g] ?? 0) + 0.15 * demand;
        f.markup[g] = f.markup[g] ?? baseMk;
        // sans employés, le prix affiché reste celui de la fermeture ; un service public gratuit n'a pas de prix
        if (f.lockPrice || f.workers.isEmpty || publicService(f)) continue;
        // signal de rareté : stock trop bas (ou capacité saturée) → marge ↑ ; surstock → marge ↓
        var dir = 0;
        final prod = f.produced[g] ?? 0;
        if (goods[g]!.perish) {
          final util = prod > eps ? (f.sold[g] ?? 0) / prod : 0.0;
          if (um > eps && util > 0.97) {
            dir = 1;
          } else if (util < 0.85 && prod > eps) {
            dir = -1;
          }
        } else {
          final days = (f.inv[g] ?? 0) / math.max(f.demandEma[g]!, 0.05);
          if (days < 2 && demand > eps && (prod > eps || (f.inv[g] ?? 0) > eps)) {
            dir = 1; // la rareté ne fait monter le prix que si l'entreprise a de quoi vendre ou produit
          } else if (days > 8) {
            dir = -1;
          }
        }
        final pressure = 1 + 2 * math.min(1.0, um / math.max(f.sold[g] ?? 0, 1.0));
        final stepSize = p.priceStep * (0.5 + draw(Flux.prix, f.id, _goodIndex[g]!));
        final mkOld = f.markup[g]!;
        var mk = mkOld;
        if (dir > 0) {
          mk += stepSize * pressure;
        } else if (dir < 0) {
          mk -= stepSize;
        } else {
          mk += (baseMk - mk) * 0.03; // la concurrence ramène la marge vers la normale
        }
        mk = math.max(-0.4, math.min(3.0, mk));
        final target = cost[g]! * (1 + mk);
        final old = f.price[g]!;
        var np = old + (target - old) * 0.25;
        final hi = old * (1 + p.priceMaxDaily), lo = old * (1 - p.priceMaxDaily);
        // anti-emballement : tant que le prix est bridé dans un sens, la marge visée cesse d'aller dans ce sens ;
        // sinon elle continuerait de monter pendant la pénurie et ferait grimper les prix pendant des semaines.
        // Les hausses de coût, elles, continuent de se répercuter.
        if (np > hi) {
          np = hi;
          if (mk > mkOld) mk = mkOld;
        } else if (np < lo) {
          np = lo;
          if (mk < mkOld) mk = mkOld;
        }
        f.markup[g] = mk;
        np = _capDrift(f, old, np, 'prix', goods[g]!.label.toLowerCase());
        _setPrice(f, g, np < 0.01 ? 0.01 : np);
      }

      // ------- plan d'embauche
      final nw = f.workers.length;
      final avgEff = nw > 0 ? math.max(0.3, f.effWorkers / nw) : 1.0;
      final per = math.max(eps, perWorker(f) * avgEff);
      var desired = (_plannedBatches(f) / per - 0.2).ceil();
      if (f.inputLimited) desired = math.min(desired, (f.lastBatches / per).ceil()); // pas d'embauche sans matière
      f.desired = desired;
      final bill = f.wage * nw;
      f.vacancies = 0;
      if (nw > 0 && f.money < bill * 2) {
        _fire(f, _cmap[f.workers[nw - 1]], 'trésorerie sous 2 jours de salaires');
      } else if (desired > nw) {
        var affordable = affordablePosts(f);
        if (affordable < math.min(desired - nw, maxPostsPerDay)) {
          _workingCapital(f, math.min(desired - nw, maxPostsPerDay));
          affordable = affordablePosts(f);
        }
        f.vacancies = math.max(0, math.min(desired - nw, math.min(maxPostsPerDay, affordable)));
      } else if (desired < nw - 1) {
        final k = math.min(nw - desired - 1, math.max(1, (nw * 0.08).ceil()));
        for (var i = 0; i < k; i++) {
          _fire(f, _cmap[f.workers.last], 'effectif au-dessus du plan de production');
        }
      }

      // ------- salaires
      if (!f.lockWage && modules.jobs) {
        _adjustOffer(f, unemp, normOffer);
      } else if (!f.lockWage) {
        final old = f.wage;
        var w = old;
        // postes vacants depuis 2 jours : on monte le salaire chaque jour, plus vite si des clients repartent les
        // mains vides (avant : un jour sur deux, par à-coups de 1,5 à 6 %)
        if (f.vacancies > 0 && f.unfilledDays >= 2) {
          w *= 1 + p.wageStep * (1 + 3 * math.min(1.0, f.urgency));
        } else if (f.vacancies == 0 && unemp > 0.08) {
          w *= 1 - p.wageStep * 0.1;
        }
        w += (norm[f.template.skill] - w) * 0.01; // les écarts de salaire se résorbent lentement
        w = w.clamp(old * (1 - p.wageMaxDaily), old * (1 + p.wageMaxDaily)).toDouble();
        if (w < math.max(1.0, p.minWage)) w = math.max(1.0, p.minWage);
        // le salaire minimum est une loi : le plafond de dérive ne s'y applique pas
        f.wage = w > p.minWage ? math.max(p.minWage, _capDrift(f, old, w, 'salaire', 'salaire')) : w;
      }

      // ------- profits et dividendes
      final profit = f.revenue - f.costs;
      f.retained += profit;
      f.profitEma = 0.9 * f.profitEma + 0.1 * profit;
      f.inputSpendEma = 0.9 * f.inputSpendEma + 0.1 * f.inputSpend;
      final reserve = 8 * (f.wage * f.workers.length + f.inputSpendEma + f.overheadEma) + f.debt * 0.1 + f.reinvest;
      final owner = f.ownerId != null ? _cmap[f.ownerId!] : null;
      f.dividends = 0;
      if (owner != null && f.money > reserve && !publicService(f)) {
        var d = (f.money - reserve) * p.dividendRate;
        if (modules.dividendTest) {
          final d0 = d;
          d = solventDividend(f, d);
          if (trace != null && d < d0) {
            _t('institutions', 'dividende_retenu', f.name, f.id, 'I1 : test de solvabilité', _dividendCause(f),
                d0 - d, 'dividende voulu ${fmtMoney0(d0)}, versé ${fmtMoney0(d)}');
          }
        }
        if (d > 0) {
          final net = transfer(f, owner, d * (1 - p.taxRate));
          final tax = transfer(f, state, d * p.taxRate);
          state.taxes += tax;
          state.taxesToday += tax;
          owner.income += net;
          f.dividends = net + tax;
          f.retained -= f.dividends;
          _flow(f.id.toString(), 'M', '\$dividendes', 1, net);
          if (tax > 0) _flow('M', 'E', '\$impôts', 1, tax);
          if (trace != null) {
            _t('compta', 'dividende', f.name, f.id, 'dividende : ${fmtPct(p.dividendRate, 0)} de la trésorerie au-delà '
                'de la réserve', 'à ${owner.name}', net + tax, 'net ${fmtMoney0(net)}, impôt ${fmtMoney0(tax)}');
          }
        }
      }
    }

    // pénuries notables
    for (final e in unmet.entries) {
      final ms = marketStats[e.key]!;
      if (e.value > 0.2 * (ms.qty + e.value) && e.value >= 1 && day - (lastShortage[e.key] ?? -99) > 20) {
        _log('short', 'Pénurie de ${goods[e.key]!.label.toLowerCase()} : ${e.value.round()} ${goods[e.key]!.unit} non servis.');
        lastShortage[e.key] = day;
      }
    }

    // flux lissés pour l'affichage
    for (final e in flowsEma.values) {
      e.qty *= 0.8;
      e.value *= 0.8;
    }
    for (final e in flows.entries) {
      final cur = flowsEma[e.key] ?? (flowsEma[e.key] = FlowEdge(e.value.from, e.value.to, e.value.good, 0, 0));
      cur.qty += 0.2 * e.value.qty;
      cur.value += 0.2 * e.value.value;
    }
    flowsEma.removeWhere((k, v) => v.value < 0.5 && !flows.containsKey(k));
  }

  /// Test de solvabilité avant dividende (institution I1, LCSA art. 42) : pas de dividende sans bénéfice lissé ; pas de
  /// dividende qui laisserait en caisse moins que le seuil d'embauche des postes voulus (8 jours de salaire par employé,
  /// nouveaux compris, pour les postes que la règle d'embauche ouvrirait aujourd'hui) ; jamais plus que le bénéfice
  /// lissé du jour.
  /// La contrainte du test de solvabilité qui a réduit le dividende (pour le journal complet).
  String _dividendCause(Firm f) {
    if (f.profitEma <= 0) return 'pas de bénéfice lissé';
    final want = math.min(f.desired - f.workers.length, maxPostsPerDay);
    final hire = want > 0 ? hireCashDays * f.wage * (f.workers.length + want) : 0.0;
    final cap = params.dividendFromRetained ? f.retained : f.profitEma;
    if (f.money - hire <= cap) return 'trésorerie nécessaire aux postes voulus';
    return params.dividendFromRetained ? 'plafond : bénéfices non répartis' : 'plafond : bénéfice lissé du jour';
  }

  double solventDividend(Firm f, double d) {
    if (f.profitEma <= 0) return 0;
    final want = math.min(f.desired - f.workers.length, maxPostsPerDay);
    final hire = want > 0 ? hireCashDays * f.wage * (f.workers.length + want) : 0.0;
    final cap = params.dividendFromRetained ? f.retained : f.profitEma;
    return math.max(0.0, math.min(d, math.min(cap, f.money - hire)));
  }

  /// Renflouement par les propriétaires (filet), rachats, redistribution du surplus de l'État.
  void _finance() {
    final p = params;
    final buffer = p.bufferDays * (needCost > 0 ? needCost : 140);
    if (safeguards.bailout) {
      for (final f in firms) {
        if ((f.demandEma[f.g0] ?? 0) < 0.05) continue;
        if (publicService(f)) continue; // établissement public : financé par son enveloppe, pas par un propriétaire
        final nw = math.max(1, math.min(f.desired == 0 ? 1 : f.desired, f.workers.length + 3));
        final need = 10 * f.wage * nw - f.money;
        if (need <= 0 || f.money > 4 * f.wage * nw) continue;
        var owner = f.ownerId != null ? _cmap[f.ownerId!] : null;
        var surplus = owner != null ? owner.money - buffer : 0.0;
        var bought = false;
        if (surplus < need * 0.5) {
          // le propriétaire n'a pas les moyens : le citoyen le plus riche rachète
          Citizen? rich;
          for (final c in citizens) {
            if (rich == null || c.money > rich.money) rich = c;
          }
          if (rich != null && !identical(rich, owner) && rich.money - buffer > need * 2) {
            if (trace != null) {
              _t('entrees_sorties', 'rachat', f.name, f.id, 'filet : renflouement (rachat)',
                  'le propriétaire n’a pas les moyens', 0, 'nouveau propriétaire ${rich.name}');
            }
            f.ownerId = rich.id;
            owner = rich;
            surplus = rich.money - buffer;
            bought = true;
            _log('info', '${rich.name} rachète ${f.name}.');
          }
        }
        if (owner != null && surplus > 0) {
          final want = math.min(need, surplus * 0.5);
          if (want > f.wage) {
            final amt = transfer(owner, f, want);
            _flow('M', f.id.toString(), '\$capital', 1, amt);
            _net('bailout', f.name, amt, bought ? 'après rachat' : 'par le propriétaire',
                '${owner.name} ; caisse ${fmtMoney0(f.money - amt)} pour $nw poste(s)', f.id);
            if (day - f.lastRecapLog > 30) {
              _log('info', '${owner.name} renfloue ${f.name} (${fmtMoney0(amt)}).');
              f.lastRecapLog = day;
            }
          }
        }
      }
    }
    // l'État redistribue son surplus au-delà d'une réserve
    final e = state;
    final reserve = 30 * p.benefit * math.max(4.0, citizens.length * 0.1);
    if (p.stateRebate > 0 && e.money > reserve && citizens.isNotEmpty) {
      final each = (e.money - reserve) * p.stateRebate / citizens.length;
      var total = 0.0;
      for (final c in citizens) {
        final a = transfer(e, c, each);
        c.income += a;
        total += a;
      }
      e.paid += total;
      e.paidToday += total;
      _flow('E', 'M', '\$redistribution', 1, total);
      if (trace != null) {
        _t('compta', 'redistribution', 'État', null, 'redistribution du surplus de l’État', 'trésor au-delà de la réserve',
            total, '${citizens.length} citoyens');
      }
    }
  }

  double gini() {
    final v = citizens.map((c) => math.max(0.0, c.money)).toList()..sort();
    final n = v.length;
    if (n == 0) return 0;
    var cum = 0.0, tot = 0.0;
    for (var i = 0; i < n; i++) {
      cum += (i + 1) * v[i];
      tot += v[i];
    }
    return tot > 0 ? (2 * cum) / (n * tot) - (n + 1) / n : 0.0;
  }

  /// Richesse médiane des citoyens.
  double medianWealth() {
    if (citizens.isEmpty) return 0;
    final v = citizens.map((c) => c.money).toList()..sort();
    final n = v.length;
    return n.isOdd ? v[n ~/ 2] : (v[n ~/ 2 - 1] + v[n ~/ 2]) / 2;
  }

  void _record() {
    final n = citizens.length;
    var mH = 0.0, mF = 0.0, wsum = 0.0, happy = 0.0;
    var employed = 0;
    final sat = <String, double>{for (final d in desires) d: 0.0};
    final classes = [0, 0, 0];
    for (final c in citizens) {
      mH += c.money;
      happy += c.happiness;
      classes[c.level]++;
      for (final d in desires) {
        sat[d] = sat[d]! + c.sat[d]!;
      }
      if (c.employer != null) {
        final f = firm(c.employer!);
        if (f != null) {
          wsum += f.wage;
          employed++;
        }
      }
    }
    if (n > 0) {
      for (final d in desires) {
        sat[d] = sat[d]! / n;
      }
    }
    var debt = 0.0, machines = 0.0, tech = 0.0;
    for (final f in firms) {
      mF += f.money;
      debt += f.debt;
      machines += f.machines;
      tech += f.techLevel;
    }
    final prices = <String, double>{};
    for (final g in goods.keys) {
      final ms = marketStats[g];
      // sans transaction aujourd'hui, on reprend le dernier prix observé (comme les instituts statistiques) :
      // un bien qui ne se vend pas ne fait pas bouger l'indice quand son vendeur ferme ou change d'affiche
      prices[g] = ms != null && ms.qty > eps
          ? ms.value / ms.qty
          : (history.isNotEmpty ? history.last.prices[g] ?? bestPrice(g) : bestPrice(g));
    }
    var basket = 0.0;
    for (final e in cpiWeights.entries) {
      basket += e.value * prices[e.key]!;
    }
    history.add(HistPoint(
      day: day,
      mH: mH,
      mF: mF,
      mE: state.money,
      mB: bank.money,
      total: mH + mF + state.money + bank.money,
      unemp: n > 0 ? (n - employed) / n : 0.0,
      wage: employed > 0 ? wsum / employed : 0.0,
      prices: prices,
      gdp: householdSpend,
      hungry: citizens.where((c) => c.hungerDays >= 1).length,
      homeless: citizens.where((c) => c.homeless).length,
      gini: gini(),
      pop: n,
      need: needCost,
      happiness: n > 0 ? happy / n : 0.0,
      debt: debt,
      machines: machines,
      tech: firms.isNotEmpty ? tech / firms.length : 1.0,
      credit: ledgerCredit,
      cpi: _cpiBase > 0 ? basket / _cpiBase : 1.0,
      sat: sat,
      classes: classes,
    ));
    if (history.length > 1500) history.removeAt(0);
    for (final f in firms) {
      final g0 = f.g0;
      f.hist.add(FirmPoint(f.money, f.workers.length, f.price[g0]!, f.sold[g0] ?? 0, f.revenue - f.costs, f.machines, f.debt));
      if (f.hist.length > 365) f.hist.removeAt(0);
      if (f.prevWorkers > 0 && f.workers.isEmpty) _log('warn', "${f.name} n'a plus d'employés.");
    }
  }

  // ================================================================ Invariants comptables

  /// Vérifie les quatre identités ; en mode développement, un écart lève une exception.
  void _checkInvariants() {
    final d = deposits();
    final loans = totalLoans();
    inv.money = totalMoney() - expectedMoney();
    inv.loans = loans - (bank.lent + bank.capitalized - bank.repaid - bank.writtenOff);
    inv.bank = (bank.reserves + loans) - (d + bank.equity);
    inv.flows = (d - _depositsAtCheck) - dayFlows.explained;
    lastFlows = DayFlows()
      ..loans = dayFlows.loans
      ..repaid = dayFlows.repaid
      ..interest = dayFlows.interest
      ..rebates = dayFlows.rebates
      ..godPublic = dayFlows.godPublic
      ..godBank = dayFlows.godBank
      ..exports = dayFlows.exports
      ..imports = dayFlows.imports
      ..capitalized = dayFlows.capitalized
      ..writtenOff = dayFlows.writtenOff;
    dayFlows.reset();
    _depositsAtCheck = d;
    if (devChecks && inv.worst > 0) {
      throw StateError('Invariant comptable rompu au jour $day : masse ${inv.money}, prêts ${inv.loans}, '
          'bilan ${inv.bank}, ΔM ${inv.flows}');
    }
  }

  // ============================================================= God mode
  double godMoney(Target target, double amount) {
    final list = _targets(target);
    var total = 0.0;
    for (final e in list) {
      final a = amount >= 0 ? transfer(null, e, amount) : -transfer(e, null, math.min(-amount, e.money));
      total += a;
      if (identical(e, bank)) {
        ledgerGod += a;
        bank.reserves += a;
        bank.equity += a;
        dayFlows.godBank += a;
      } else {
        _godIn(a);
      }
    }
    _log('god', '${total >= 0 ? 'Injection de ' : 'Retrait de '}${fmtMoney0(total.abs())} → ${_targetLabel(target)}.');
    if (trace != null) _t('compta', 'divin', _targetLabel(target), target.id, 'god mode', 'injection ou retrait', total);
    return total;
  }

  double godGoods(int firmId, String good, double qty) {
    final f = firm(firmId);
    if (f == null) return 0;
    final before = f.inv[good] ?? 0;
    _setStock(f, good, math.max(0.0, before + qty));
    final d = f.inv[good]! - before;
    _log('god',
        '${d >= 0 ? 'Ajout de ' : 'Retrait de '}${round1(d.abs())} ${goods[good]!.unit} de ${goods[good]!.label.toLowerCase()} chez ${f.name}.');
    return d;
  }

  double godDestroy(String good, double pct) {
    var lost = 0.0;
    for (final f in firms) {
      final cur = f.inv[good] ?? 0;
      if (cur > 0) {
        final q = cur * pct;
        _setStock(f, good, cur - q);
        lost += q;
      }
    }
    _log('god',
        'Catastrophe : ${(pct * 100).round()} % des stocks de ${goods[good]!.label.toLowerCase()} détruits (${round1(lost)} ${goods[good]!.unit}).');
    return lost;
  }

  /// Épidémie : une part de la population perd la moitié de sa santé.
  int godEpidemic(double share) {
    var sick = 0;
    final seq = ++_godSeq;
    for (final c in citizens) {
      if (draw(Flux.divin, c.id, seq) < share) {
        c.sat['sante'] = math.max(0.05, c.health - 0.5);
        sick++;
      }
    }
    _log('god', 'Épidémie : $sick citoyens tombent malades.');
    return sick;
  }

  /// Formation accélérée : le citoyen passe à la classe suivante.
  void godTrain(int citizenId) {
    final c = citizen(citizenId);
    if (c == null || c.skill >= 3) return;
    c.skill = math.min(3.0, c.skill.floorToDouble() + 1);
    _log('god', '${c.name} devient ${classLabels[c.level].toLowerCase()}.');
  }

  void godAddCitizens(int n, double money) {
    for (var i = 0; i < n; i++) {
      final c = _newCitizen(money: money);
      _godIn(c.money);
      if (trace != null) _t('entrees_sorties', 'arrivee', c.name, c.id, 'god mode', 'immigration', c.money);
    }
    _log('god', '$n nouveaux citoyens arrivent avec ${fmtMoney0(money)} chacun.');
  }

  void godRemoveCitizens(int n) {
    // départs : les sans-emploi d'abord ; leur argent quitte l'économie
    final order = List<Citizen>.from(citizens);
    stableSort<Citizen>(order, (a, b) => (a.employer != null ? 1 : 0) - (b.employer != null ? 1 : 0));
    var gone = 0;
    var money = 0.0;
    for (var i = 0; i < n && i < order.length; i++) {
      final c = order[i];
      if (firms.any((f) => f.ownerId == c.id)) continue;
      if (c.employer != null) _fire(firm(c.employer!), c, 'départ de la région');
      if (trace != null) _t('entrees_sorties', 'depart', c.name, c.id, 'god mode', 'émigration', c.money);
      money += c.money;
      _citizenGone(c); // son logement passe en liquidation
      _godIn(-c.money);
      c.money = 0;
      citizens.remove(c);
      _cmap.remove(c.id);
      gone++;
    }
    _log('god', '$gone citoyens quittent la région (emportant ${fmtMoney0(money)}).');
  }

  /// Modifie une entreprise. `setCapacity` distingue « ne pas toucher » de « illimitée » (capacity == null).
  void godFirm(int id,
      {double? wage,
      bool? lockWage,
      Map<String, double>? prices,
      bool? lockPrice,
      double? prodMult,
      bool setCapacity = false,
      double? capacity,
      double? machines,
      int? techLevel,
      bool forgiveDebt = false}) {
    final f = firm(id);
    if (f == null) return;
    final notes = <String>[];
    if (wage != null && wage.isFinite) {
      if (modules.jobs && f.wage > 0) {
        // l'échelle salariale entière : salaire affiché et contrats dans la même proportion
        final k = math.max(1.0, wage) / f.wage;
        f.offer = math.max(1.0, f.offer * k);
        for (final id in f.workers) {
          final c = _cmap[id]!;
          c.wage = math.max(1.0, c.wage * k);
        }
        _syncWage(f);
      } else {
        f.wage = math.max(1.0, wage);
        f.offer = f.wage;
      }
      notes.add('salaire ${fmtMoney0(f.wage)}');
    }
    if (lockWage != null) f.lockWage = lockWage;
    if (prices != null) {
      for (final e in prices.entries) {
        if (e.value.isFinite && f.price.containsKey(e.key)) {
          _setPrice(f, e.key, math.max(0.01, e.value));
          notes.add('prix ${goods[e.key]!.label.toLowerCase()} ${fmtMoney0(f.price[e.key]!)}');
        }
      }
    }
    if (lockPrice != null) f.lockPrice = lockPrice;
    if (prodMult != null && prodMult.isFinite) {
      f.prodMult = math.max(0.05, prodMult);
      notes.add('productivité ×${f.prodMult.toStringAsFixed(2)}');
    }
    if (setCapacity) {
      f.capacity = capacity == null ? null : math.max(0.0, capacity);
      notes.add('capacité ${f.capacity == null ? 'illimitée' : f.capacity!.round().toString()}');
    }
    if (machines != null && machines.isFinite) {
      f.machines = math.max(0.0, machines);
      notes.add('${round1(f.machines)} machines');
    }
    if (techLevel != null) {
      f.techLevel = math.max(1, techLevel);
      f.rndProgress = 0;
      notes.add('technologie niveau ${f.techLevel}');
    }
    if (forgiveDebt && f.debt > 0) {
      notes.add('dette de ${fmtMoney0(f.debt)} effacée');
      _writeOff(f, 'dette effacée (god mode)');
    }
    if (notes.isNotEmpty) _log('god', '${f.name} : ${notes.join(', ')}.');
  }

  void setUBI(double v) {
    params.ubi = math.max(0.0, v);
    _log('god', v > 0 ? 'Revenu de base divin : ${fmtMoney0(v)}/jour par citoyen.' : 'Revenu de base divin arrêté.');
  }

  void setTrade(bool on) {
    params.trade = on;
    _log('god', on ? 'Frontières ouvertes : import/export aux prix mondiaux.' : 'Frontières fermées : économie autarcique.');
  }

  Firm addFirm(String type, String? name, double money, int? ownerId, double x, double y) {
    final f = _newFirm(type, name, money, ownerId, x, y);
    if (f.ownerId == null && citizens.isNotEmpty) {
      f.ownerId = citizens[(draw(Flux.proprietaire, f.id) * citizens.length).floor()].id;
    }
    _godIn(f.money);
    // salaire du marché pour cette qualification
    var ws = 0.0, wn = 0;
    for (final o in firms) {
      if (identical(o, f) || o.template.skill != f.template.skill) continue;
      ws += o.wage * o.workers.length;
      wn += o.workers.length;
    }
    if (wn > 0) f.wage = ws / wn;
    if (modules.jobs) {
      f.offer = marketOffer(f.template.skill);
      _syncWage(f);
    }
    for (final g in f.outputs.keys) {
      final s = sellersOf(g).where((o) => !identical(o, f)).toList();
      if (s.isNotEmpty) {
        var sum = 0.0;
        var minP = double.infinity;
        for (final o in s) {
          sum += o.demandEma[g] ?? 0.0;
          minP = math.min(minP, o.price[g]!);
        }
        f.demandEma[g] = sum / (s.length + 1);
        _setPrice(f, g, minP);
      } else {
        f.demandEma[g] = 1;
      }
    }
    f.vacancies = 2;
    _log('god', 'Nouvelle entreprise : ${f.name} (${templates[type]!.label.toLowerCase()}, capital ${fmtMoney0(money)}).');
    if (trace != null) _t('entrees_sorties', 'creation', f.name, f.id, 'god mode', 'entreprise ajoutée', f.money);
    return f;
  }

  void removeFirm(int id) {
    final f = firm(id);
    if (f == null) return;
    for (final wid in List<int>.from(f.workers)) {
      _fire(f, _cmap[wid], 'fermeture de l’entreprise (god mode)');
    }
    if (buildings.isNotEmpty) _firmGone(f);
    if (modules.bankruptcy) _repayFromCash(f);
    final hadDebt = f.debt > 0;
    _writeOff(f, 'fermeture (god mode)');
    if (trace != null) _t('entrees_sorties', 'retrait', f.name, f.id, 'god mode', 'entreprise retirée', f.money);
    final owner = f.ownerId != null ? _cmap[f.ownerId!] : null;
    if (owner != null) {
      transfer(f, owner, f.money);
    } else if (modules.bankruptcy) {
      transfer(f, state, f.money); // sans propriétaire (établissement public), le reste revient à l'État
    } else {
      _godIn(-f.money);
      f.money = 0;
    }
    firms.remove(f);
    _fmap.remove(id);
    _rebuildSellers();
    final key = id.toString();
    flowsEma.removeWhere((k, v) => v.from == key || v.to == key);
    _log('god', '${f.name} ferme ses portes. Les employés sont mis à pied${hadDebt ? ', la dette est radiée' : ''}.');
  }

  /// Faillite : l'entreprise perd sa trésorerie et ses stocks, sa dette est radiée ; elle reste en place.
  void godBankrupt(int id) {
    final f = firm(id);
    if (f == null) return;
    final lost = f.money;
    _godIn(-transfer(f, null, f.money));
    for (final g in f.inv.keys.toList()) {
      _setStock(f, g, 0);
    }
    final debt = f.debt;
    _writeOff(f, 'faillite (god mode)');
    _log('god', 'Faillite de ${f.name} : ${fmtMoney0(lost)} de trésorerie et tous les stocks perdus'
        '${debt > 0 ? ', ${fmtMoney0(debt)} de dette radiés' : ''}.');
  }

  List<Account> _targets(Target t) {
    switch (t.kind) {
      case 'allCitizens':
        return List<Account>.from(citizens);
      case 'allFirms':
        return List<Account>.from(firms);
      case 'citizen':
        final c = citizen(t.id ?? -1);
        return c == null ? <Account>[] : <Account>[c];
      case 'firm':
        final f = firm(t.id ?? -1);
        return f == null ? <Account>[] : <Account>[f];
      case 'unemployed':
        return List<Account>.from(citizens.where((c) => c.employer == null));
      case 'state':
        return <Account>[state];
      case 'bank':
        return <Account>[bank];
    }
    return <Account>[];
  }

  String _targetLabel(Target t) {
    switch (t.kind) {
      case 'allCitizens':
        return 'tous les citoyens';
      case 'allFirms':
        return 'toutes les entreprises';
      case 'unemployed':
        return 'les sans-emploi';
      case 'state':
        return "l'État";
      case 'bank':
        return 'la Caisse';
      case 'citizen':
        return citizen(t.id ?? -1)?.name ?? '?';
      case 'firm':
        return firm(t.id ?? -1)?.name ?? '?';
    }
    return '?';
  }
}
