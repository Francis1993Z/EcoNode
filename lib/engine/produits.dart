part of 'sim.dart';

// Variétés de produits, marques et noms (Modules.products). Voir MODELE.md § 6.18.
//
// Une catégorie est un bien (pain, téléviseurs, machines) ; une variété est le produit d'une entreprise dans cette
// catégorie, une par entreprise dans cette version. Stock, prix, marge, ventes et demande d'une variété sont donc ceux de son
// entreprise pour ce bien. Aucune variété n'est créée d'avance : chaque entreprise d'une catégorie différenciée a la sienne,
// lancée à sa création (ou à l'activation du module pour les entreprises du départ) et abandonnée à sa fermeture. Le nombre
// de variétés d'une catégorie suit donc les entrées et les sorties.
//
// Biens de consommation : chaque ménage connaît au plus prodKnownMax variétés par catégorie (vitrine et publicité,
// bouche-à-oreille entre collègues, habitude ; oubli après prodForgetDays jours sans achat ni rappel) et achète celle qui lui
// apporte la plus grande utilité parmi celles en stock. Faute de variété connue en stock, il cherche parmi les vendeurs
// disponibles (comme sans le module) et apprend la variété trouvée. Biens d'équipement : une entreprise ne connaît que
// quelques fabricants et achète le modèle au meilleur gain de productivité par dollar, durabilité comprise, avec une
// préférence pour son fournisseur habituel.

/// Mots par catégorie pour le générateur de noms : noms communs, puis mots d'accroche.
const Map<String, List<List<String>>> _catWords = {
  'pain': [
    ['Pain', 'Miche', 'Baguette', 'Brioche', 'Fournée'],
    ['Croûte', 'Mie', 'Levain', 'Blé', 'Fournil']
  ],
  'viande': [
    ['Boucherie', 'Grillade', 'Terrine', 'Rôti', 'Charcuterie'],
    ['Grill', 'Boucan', 'Fumoir', 'Braise', 'Tendre']
  ],
  'repas': [
    ['Cantine', 'Bistro', 'Casse-croûte', 'Table', 'Popote'],
    ['Festin', 'Régal', 'Gourmet', 'Mijoté', 'Bouchée']
  ],
  'tele': [
    ['Canal', 'Télé', 'Ondes', 'Chaîne', 'Antenne'],
    ['Écran', 'Zapping', 'Signal', 'Image', 'Studio']
  ],
  'loisirs': [
    ['Club', 'Arcade', 'Récré', 'Salle', 'Cercle'],
    ['Fun', 'Évasion', 'Tourbillon', 'Fiesta', 'Délire']
  ],
  'hotel': [
    ['Auberge', 'Relais', 'Hôtel', 'Gîte', 'Manoir'],
    ['Repos', 'Étape', 'Halte', 'Nuitée', 'Oreiller']
  ],
  'voyage': [
    ['Escapade', 'Périple', 'Virée', 'Croisière', 'Tournée'],
    ['Horizon', 'Boussole', 'Cap', 'Alizé', 'Envol']
  ],
  'bijoux': [
    ['Joaillerie', 'Bijouterie', 'Écrin', 'Atelier', 'Parure'],
    ['Éclat', 'Perle', 'Joyau', 'Reflet', 'Carat']
  ],
  'ordinateur': [
    ['Calcul', 'Station', 'Terminal', 'Console', 'Portable'],
    ['Octet', 'Pixel', 'Puce', 'Algo', 'Binaire']
  ],
};

const List<String> _boosters = ['Super', 'Méga', 'Royal', 'Délice', 'Petit', 'Grand', 'Bon', 'Vrai'];
const List<String> _doubles = ['Miam', 'Croc', 'Zou', 'Hop', 'Glou', 'Tchic', 'Pif', 'Frip', 'Zig', 'Bidou', 'Tralala', 'Youpi'];
const List<String> _houses = ['Maison', 'Comptoir', 'Fabrique', 'Atelier', 'Les Délices', 'Boutique'];
const List<String> _brandSyllables = [
  'Bo', 'ré', 'lia', 'No', 'rak', 'Ka', 'lun', 'Mi', 'stral', 'Val', 'tor', 'Si', 'lex', 'Ar', 'gol', 'Ze', 'phyr',
  'Tu', 'ran', 'Ma', 'nic', 'Ou', 'tar', 'Gra', 'nit', 'Fé', 'lis', 'Ro', 'kan', 'Té', 'mis'
];
const List<String> _makerSuffix = ['Mécanique', 'Industries', 'Machinerie', 'Outillage', 'Équipements', 'Ateliers'];

/// Marques réelles exclues du générateur (en minuscules, sans accents ; comparées mot à mot et au nom entier).
const Set<String> realBrands = {
  'deere', 'john deere', 'caterpillar', 'cat', 'komatsu', 'kubota', 'volvo', 'case', 'hitachi', 'liebherr', 'bobcat',
  'jcb', 'doosan', 'hyundai', 'bombardier', 'apple', 'dell', 'lenovo', 'samsung', 'sony', 'ibm', 'intel', 'amd', 'asus',
  'acer', 'ikea', 'nestle', 'kraft', 'mcdonald', 'mcdonalds', 'tim', 'hortons', 'weston', 'vachon', 'olymel', 'molson',
  'labatt', 'bell', 'videotron', 'rogers', 'telus', 'cartier', 'tiffany', 'birks', 'pandora', 'hilton', 'marriott',
  'transat', 'westjet', 'tesla', 'toyota', 'ford', 'honda', 'kodiak', 'caribou', 'boreale', 'nordex', 'canon', 'nikon',
  'durabuilt', 'stihl', 'makita', 'dewalt', 'bosch', 'siemens', 'miele', 'subway', 'starbucks', 'netflix', 'disney',
};

String _plain(String s) {
  const from = 'àâäéèêëîïôöùûüçÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ';
  const to = 'aaaeeeeiioouuucAAAEEEEIIOOUUUC';
  final b = StringBuffer();
  for (final ch in s.split('')) {
    final i = from.indexOf(ch);
    b.write(i >= 0 ? to[i] : ch);
  }
  return b.toString().toLowerCase();
}

/// Vrai si le nom contient une marque réelle (mot à mot, ou le nom entier).
bool isRealBrand(String name) {
  final p = _plain(name);
  if (realBrands.contains(p)) return true;
  for (final w in p.split(RegExp(r"[^a-z0-9]+"))) {
    if (w.isNotEmpty && realBrands.contains(w)) return true;
  }
  for (final b in realBrands) {
    if (b.contains(' ') && p.contains(b)) return true;
  }
  return false;
}

extension SimProducts on Sim {
  // ------------------------------------------------------------------ tirages sans jour (pure fonction de la graine)

  /// Tirage stable d'un flux pour (a, b) : le flux tiré « au jour 0 », comme `traitDraw` (rien à sérialiser).
  double _stable(Flux flux, int a, int b) {
    if (sansHasard) return 0.5;
    return Mulberry32.first(hash32(hash32(hash32(hash32(seed & 0xFFFFFFFF, flux.code), 0), a), b));
  }

  /// Goût personnel durable d'un citoyen pour une variété : uniforme dans ± prodTasteSpread, par hachage de (graine,
  /// citoyen, variété). Rien n'est stocké.
  double tasteOf(Citizen c, int productId) => params.prodTasteSpread * (2 * _stable(Flux.gouts, c.id, productId) - 1);

  /// Sensibilité au prix d'un citoyen : de 0,5 à 1,5 fois prodPriceSens (trait, Flux.traits sous-indice 72).
  double priceSensitivity(Citizen c) => params.prodPriceSens * (0.5 + traitDraw(c.id, 72));

  // ------------------------------------------------------------------ accès

  Product? productOf(Firm f) => f.productId != null ? products[f.productId!] : null;

  /// Variétés d'une catégorie, vivantes seulement par défaut, la plus vendue d'abord.
  List<Product> varietiesOf(String g, {bool alive = true}) {
    final l = [for (final p in products.values) if (p.category == g && (!alive || p.alive)) p];
    l.sort((a, b) => b.salesEma.compareTo(a.salesEma));
    return l;
  }

  /// Part de marché d'une variété dans sa catégorie (ventes lissées des variétés vivantes).
  double marketShare(Product pr) {
    var tot = 0.0;
    for (final p in products.values) {
      if (p.alive && p.category == pr.category) tot += p.salesEma;
    }
    return tot > 0 ? pr.salesEma / tot : 0;
  }

  /// Productivité relative d'une entreprise selon la qualité de sa variété : 1 / (1 + prodQualityCost × (qualité − 1)).
  double qualityRate(Firm f) {
    final pr = productOf(f);
    return pr == null ? 1.0 : 1 / (1 + params.prodQualityCost * (pr.quality - 1));
  }

  // ------------------------------------------------------------------ noms

  double _nameDraw(int who, int k) => _stable(Flux.noms, who, k);

  String _pick(List<String> l, int who, int k) => l[(_nameDraw(who, k) * l.length).floor()];

  String _brand(int who, int k0) {
    final n = 2 + (_nameDraw(who, k0) * 2).floor(); // 2 ou 3 syllabes
    final b = StringBuffer();
    for (var i = 0; i < n; i++) {
      var s = _pick(_brandSyllables, who, k0 + 1 + i);
      s = i == 0 ? s[0].toUpperCase() + s.substring(1) : s.toLowerCase();
      b.write(s);
    }
    return b.toString();
  }

  /// Un nom neuf : déterministe, unique dans la partie, sans marque réelle. [kind] : 'produit', 'machine', 'entreprise'.
  String _uniqueName(String kind, String g, int who, {String? lastName}) {
    for (var attempt = 0; attempt < 40; attempt++) {
      final k = 100 * attempt;
      String name;
      if (kind == 'machine') {
        final brand = _brand(who, k + 1);
        final num = 100 * (1 + (_nameDraw(who, k + 9) * 9).floor());
        name = '$brand ${brand[0]}-$num';
      } else if (kind == 'fabricant') {
        name = '${_brand(who, k + 1)} ${_pick(_makerSuffix, who, k + 8)}';
      } else if (kind == 'entreprise') {
        name = '${_pick(_houses, who, k + 1)} ${lastName ?? _pick(lastNames, who, k + 2)}';
      } else {
        final w = _catWords[g] ?? const [
          ['Produit'],
          ['Choix']
        ];
        switch ((_nameDraw(who, k) * 3).floor()) {
          case 0:
            // « Pain de Julie », « Escapade d'Éric », ou « Chez Martin »
            final first = _pick(firstNames, who, k + 3);
            if (_nameDraw(who, k + 2) < 0.25) {
              name = 'Chez $first';
            } else {
              final elide = 'AEIOUYÉÈÊaeiouyéèê'.contains(first[0]);
              name = '${_pick(w[0], who, k + 1)} ${elide ? 'd’' : 'de '}$first';
            }
          case 1:
            name = '${_pick(_boosters, who, k + 1)} ${_pick(w[1], who, k + 2)}';
          default:
            final d = _pick(_doubles, who, k + 1);
            name = '$d $d ${_pick(w[1], who, k + 2)}';
        }
      }
      if (attempt > 30) name = '$name ${attempt - 29}';
      if (!usedNames.contains(name) && !isRealBrand(name)) {
        usedNames.add(name);
        return name;
      }
    }
    final name = '${goods[g]?.label ?? g} n° $who';
    usedNames.add(name);
    return name;
  }

  // ------------------------------------------------------------------ cycle de vie

  /// Activation (ou coupure) du module : à l'activation, chaque entreprise d'une catégorie différenciée reçoit sa variété.
  void _productsSwitch() {
    productsActive = modules.products;
    if (!productsActive) return;
    for (final f in List<Firm>.of(firms)) {
      _launchProduct(f, rename: false, quiet: day == 0);
    }
  }

  /// Lance la variété d'une entreprise : qualité tirée (Flux.qualite), meilleure en moyenne si le propriétaire connaît le
  /// secteur ; pour une machine, gain et durabilité tirés. Une entreprise créée pendant que le module est actif reçoit aussi
  /// un nom généré.
  void _launchProduct(Firm f, {bool rename = true, bool quiet = false}) {
    final g = f.g0;
    if (!isDifferentiated(g) || f.productId != null || publicService(f)) return;
    final id = ++productSeq;
    final owner = f.ownerId != null ? _cmap[f.ownerId!] : null;
    final k = owner != null ? sectorKnowledge(owner, f.type) : 0.0;
    final u = draw(Flux.qualite, id);
    final quality = 0.6 + 0.8 * (u + k * (1 - u) * 0.5); // de 0,6 à 1,4 ; la connaissance tire vers le haut
    final equip = equipmentVarieties.contains(g);
    var gain = 1.0, life = 1.0;
    if (equip) {
      final v = draw(Flux.qualite, id, 2);
      gain = 1.01 + 0.99 * v * v * v; // ×1,01 à ×2, les valeurs hautes rares (espérance 1,2575)
      life = 0.7 + 0.6 * draw(Flux.qualite, id, 3);
    }
    if (rename) {
      final last = owner?.name.split(' ').last;
      f.name = _uniqueName(equip ? 'fabricant' : 'entreprise', g, 1000000 + id, lastName: equip ? null : last);
    }
    final name = equip ? _uniqueName('machine', g, id) : _uniqueName('produit', g, id);
    final maker = equip ? name.split(' ').first : '';
    final pr = Product(id, g, f.id, name, quality, day, gain: gain, durability: life, maker: maker);
    pr.inStock = (f.inv[g] ?? 0) >= 1 - eps;
    products[id] = pr;
    f.productId = id;
    if (!quiet) {
      _log('info', 'Nouveau produit : « $name », par ${f.name} (${goods[g]!.label.toLowerCase()}, qualité '
          '${fmtNum1(quality * 100)} %${equip ? ', gain ×${gain.toStringAsFixed(2)}' : ''}).');
    }
  }

  /// L'entreprise ferme : sa variété est abandonnée.
  void _productGone(Firm f, String why) {
    final pr = productOf(f);
    if (pr == null || !pr.alive) return;
    pr.alive = false;
    pr.ended = day;
    _log('info', 'Produit abandonné : « ${pr.name} » ($why).');
  }

  // ------------------------------------------------------------------ connaissance des ménages

  /// Variétés connues d'un citoyen dans une catégorie, après l'oubli (variétés mortes ou sans achat ni rappel depuis
  /// prodForgetDays jours).
  Map<int, int>? _knownFor(Citizen c, String g) {
    final m = c.known[g];
    if (m == null) return null;
    m.removeWhere((pid, d) => day - d > params.prodForgetDays || !(products[pid]?.alive ?? false));
    if (m.isEmpty) {
      c.known.remove(g);
      return null;
    }
    return m;
  }

  /// Le citoyen apprend (ou se rappelle) une variété ; la liste pleine, la plus ancienne est oubliée.
  void _learn(Citizen c, String g, int pid) {
    final m = c.known[g] ??= {};
    if (!m.containsKey(pid) && m.length >= params.prodKnownMax) {
      int? old;
      for (final e in m.entries) {
        if (old == null || e.value < m[old]!) old = e.key;
      }
      m.remove(old);
    }
    m[pid] = day;
  }

  /// Variétés connues par catégorie pour l'affichage : (variété, dernier jour d'achat ou de rappel), après l'oubli.
  Map<String, List<(Product, int)>> knownVarieties(Citizen c) {
    final out = <String, List<(Product, int)>>{};
    for (final g in List<String>.of(c.known.keys)) {
      final m = _knownFor(c, g);
      if (m == null) continue;
      out[g] = [for (final e in m.entries) (products[e.key]!, e.value)];
    }
    return out;
  }

  /// Utilité d'une variété au prix [price] pour ce citoyen.
  double varietyUtility(Citizen c, Product pr, double price) {
    final p = params;
    final g = pr.category;
    final imp = uses[g]?.taste[c.level] ?? 1.0;
    var u = p.prodQualityWeight * pr.quality * imp - priceSensitivity(c) * price / worldPrice[g]!;
    final f = _fmap[pr.firmId];
    if (f != null && modules.marketing) u += brandPull(f);
    if (c.lastChoice[g] == pr.id) u += p.prodHabit;
    return u + tasteOf(c, pr.id);
  }

  /// Offres d'un achat de ménage dans une catégorie différenciée : ses variétés connues en stock, la meilleure utilité
  /// d'abord (et l'importation, variété sans goût ni marque). Null si aucune variété connue n'est en stock : l'achat cherche
  /// alors parmi les vendeurs disponibles. Choix : la meilleure utilité plutôt qu'un tirage logit, car le goût personnel
  /// durable joue déjà le rôle du terme aléatoire du logit (il varie d'un citoyen à l'autre) sans changer chaque jour.
  _AllOffers? _varietyOffers(Citizen c, Account buyer, String g) {
    final m = _knownFor(c, g);
    if (m == null) return null;
    final offers = <_Offer>[];
    final keys = <double>[];
    for (final pid in m.keys) {
      final pr = products[pid]!;
      final f = _fmap[pr.firmId];
      if (f == null || identical(f, buyer) || (f.inv[g] ?? 0) < 1 - eps) continue;
      final price = f.price[g]!;
      offers.add(_Offer(f, price, 0.5, 1));
      keys.add(-varietyUtility(c, pr, price));
    }
    if (offers.isEmpty) return null;
    final p = params;
    if (p.trade && !goods[g]!.perish && goods[g]!.tradable) {
      final price = worldPrice[g]! * p.importMarkup;
      offers.add(_Offer(null, price, 0.5, 1));
      keys.add(-(p.prodQualityWeight * (uses[g]?.taste[c.level] ?? 1.0) - priceSensitivity(c) * price / worldPrice[g]!));
    }
    return _AllOffers.fromOffers(offers, keys);
  }

  /// Après un achat de ménage dans une catégorie différenciée : la variété est apprise et devient l'habitude ; une
  /// demande servie par une variété qu'il n'aime pas (goût négatif), ou trouvée faute de variété connue, compte comme
  /// faiblement servie (signal d'entrée d'une nouvelle variété).
  void _boughtVariety(Citizen c, String g, Firm? s, double q, bool searched) {
    final pid = s?.productId;
    if (pid != null) {
      _learn(c, g, pid);
      c.lastChoice[g] = pid;
    }
    if (searched || pid == null || tasteOf(c, pid) < 0) poorToday[g] = (poorToday[g] ?? 0) + q;
  }

  // ------------------------------------------------------------------ journée

  /// Découvertes du jour : vitrine et publicité (pondérées par la notoriété), bouche-à-oreille entre collègues ; les
  /// entreprises découvrent des fabricants de machines.
  void _productsDay() {
    final p = params;
    final byCat = <String, List<Product>>{};
    for (final pr in products.values) {
      if (pr.alive && _fmap.containsKey(pr.firmId)) (byCat[pr.category] ??= []).add(pr);
    }
    if (byCat.isEmpty) return;
    double weight(Product pr) => 0.2 + (modules.marketing ? (_fmap[pr.firmId]?.brand ?? 0) : 0);
    Product? weighted(List<Product> l, double u) {
      var tot = 0.0;
      for (final x in l) {
        tot += weight(x);
      }
      var acc = 0.0;
      for (final x in l) {
        acc += weight(x);
        if (u * tot < acc) return x;
      }
      return l.isEmpty ? null : l.last;
    }

    final cats = [for (final g in consumerVarieties) if (byCat.containsKey(g)) g];
    for (final c in citizens) {
      if (cats.isNotEmpty && draw(Flux.connaissance, c.id) < p.prodAdRate) {
        final g = cats[(draw(Flux.connaissance, c.id, 1) * cats.length).floor()];
        final pr = weighted(byCat[g]!, draw(Flux.connaissance, c.id, 2));
        if (pr != null) _learn(c, g, pr.id);
      }
      final emp = c.employer != null ? _fmap[c.employer!] : null;
      if (emp != null && emp.workers.length > 1 && draw(Flux.connaissance, c.id, 3) < p.prodWordRate) {
        final mate = _cmap[emp.workers[(draw(Flux.connaissance, c.id, 4) * emp.workers.length).floor()]];
        if (mate != null && !identical(mate, c) && mate.lastChoice.isNotEmpty) {
          final ks = mate.lastChoice.keys.toList();
          final g = ks[(draw(Flux.connaissance, c.id, 5) * ks.length).floor()];
          final pr = products[mate.lastChoice[g]!];
          if (pr != null && pr.alive) _learn(c, g, pr.id);
        }
      }
    }
    final makers = byCat['machines'];
    if (makers != null && modules.capital) {
      for (final f in firms) {
        if (f.template.capital <= 0 || draw(Flux.connaissance, f.id, 7) >= p.prodMakerLearn) continue;
        final pr = weighted(makers, draw(Flux.connaissance, f.id, 8));
        if (pr != null && pr.firmId != f.id) _learnMaker(f, pr.id);
      }
    }
  }

  void _learnMaker(Firm f, int pid) {
    if (f.knownMakers.contains(pid)) return;
    f.knownMakers.removeWhere((x) => !(products[x]?.alive ?? false));
    if (f.knownMakers.length >= params.prodMakersMax) {
      final i = f.knownMakers.indexWhere((x) => x != f.supplier);
      if (i >= 0) f.knownMakers.removeAt(i);
    }
    f.knownMakers.add(pid);
  }

  /// Fin de journée : ventes lissées, ruptures, variétés dont l'entreprise a disparu (god mode), demande faiblement servie.
  void _productsEndOfDay() {
    for (final pr in products.values) {
      if (!pr.alive) continue;
      final f = _fmap[pr.firmId];
      if (f == null) {
        pr.alive = false;
        pr.ended = day;
        _log('info', 'Produit abandonné : « ${pr.name} » (l’entreprise a disparu).');
        continue;
      }
      pr.salesEma = 0.9 * pr.salesEma + 0.1 * (f.sold[pr.category] ?? 0);
      final has = (f.inv[pr.category] ?? 0) >= 1 - eps;
      if (!has && pr.inStock && day - pr.lastRupture > 30 && f.workers.isNotEmpty) {
        _log('short', 'Rupture : « ${pr.name} » (${f.name}) n’a plus de stock.');
        pr.lastRupture = day;
      }
      pr.inStock = has;
    }
    for (final g in [...consumerVarieties, ...equipmentVarieties]) {
      final v = 0.9 * (poorEma[g] ?? 0) + 0.1 * (poorToday[g] ?? 0);
      if (v > 1e-9 || poorEma.containsKey(g)) poorEma[g] = v;
    }
    poorToday.clear();
  }

  // ------------------------------------------------------------------ équipement

  /// Achat d'une machine avec le module : parmi les fabricants connus qui ont un modèle en stock et abordable, le meilleur
  /// gain de productivité par dollar, durabilité comprise (score = gain / gain standard × durabilité / prix, × 1 +
  /// prodLoyalty pour le fournisseur habituel). Faute de fabricant connu, le moins cher en stock, qu'on apprend. Rend le
  /// nombre de machines achetées.
  double _investBuy(Firm f) {
    const g = 'machines';
    Product? best;
    Firm? seller;
    var bestScore = 0.0;
    for (final pid in f.knownMakers) {
      final pr = products[pid];
      if (pr == null || !pr.alive) continue;
      final s = _fmap[pr.firmId];
      if (s == null || identical(s, f) || (s.inv[g] ?? 0) < 1 - eps) continue;
      final price = s.price[g]!;
      if (price > f.money) continue;
      var score = pr.gain / machineGainRef * pr.durability / price;
      if (f.supplier == pid) score *= 1 + params.prodLoyalty;
      if (best == null || score > bestScore) {
        best = pr;
        seller = s;
        bestScore = score;
      }
    }
    var searched = false;
    if (best == null) {
      searched = true;
      for (final s in sellersOf(g)) {
        if (identical(s, f) || (s.inv[g] ?? 0) < 1 - eps || s.price[g]! > f.money) continue;
        final pr = productOf(s);
        if (pr == null) continue;
        if (seller == null || s.price[g]! < seller.price[g]!) {
          seller = s;
          best = pr;
        }
      }
      if (seller == null) return buy(f, f.id.toString(), g, 1, f.money, true).qty; // importation, ou pénurie notée
    }
    final paid = _buyFrom(f, f.id.toString(), seller!, g, 1);
    if (paid <= 0) return 0;
    if (searched) poorToday[g] = (poorToday[g] ?? 0) + 1;
    _learnMaker(f, best!.id);
    f.supplier = best.id;
    // machines installées : gain et durabilité moyens, pondérés par le nombre (jamais un produit des gains)
    final m = f.machines;
    final g0 = f.machineGain > 0 ? f.machineGain : machineGainRef;
    final d0 = f.machineLife > 0 ? f.machineLife : 1.0;
    f.machineGain = (g0 * m + best.gain) / (m + 1);
    f.machineLife = (d0 * m + best.durability) / (m + 1);
    return 1;
  }

  /// Achat d'une quantité à un vendeur précis, au prix affiché (mêmes comptes que `buy`).
  double _buyFrom(Account buyer, String buyerKey, Firm s, String g, double q) {
    final cost = q * s.price[g]!;
    if (buyer.money < cost || (s.inv[g] ?? 0) < q - eps) return 0;
    final paid = transfer(buyer, s, cost);
    _setStock(s, g, (s.inv[g] ?? 0) - q);
    s.sold[g] = (s.sold[g] ?? 0) + q;
    s.revenue += paid;
    _flow(s.id.toString(), buyerKey, g, q, paid);
    final ms = marketStats[g]!;
    ms.qty += q;
    ms.value += paid;
    return paid;
  }

  // ------------------------------------------------------------------ signal d'entrée

  /// Demande qui justifie une nouvelle variété dans une catégorie différenciée : la demande non servie plus la demande
  /// faiblement servie (achats d'une variété mal aimée, ou trouvée faute d'en connaître une), partagée avec les variétés en
  /// place (÷ 1 + leur nombre). −1 si la marge moyenne des vendeurs en place, pondérée par leur demande, est sous
  /// prodEntryMargin. Hors du module ou d'une catégorie différenciée : la demande non servie, comme avant.
  double entryWant(String g) {
    final base = unmetEma[g] ?? 0;
    if (!productsActive || !isDifferentiated(g)) return base;
    var rev = 0.0, mar = 0.0;
    var n = 0;
    for (final f in sellersOf(g)) {
      if (f.workers.isEmpty) continue;
      n++;
      final d = f.demandEma[g] ?? 0;
      final pr = f.price[g]!;
      rev += d * pr;
      mar += d * (pr - (f.unitCostCache[g] ?? pr));
    }
    if (n > 0 && (rev <= 0 || mar / rev < params.prodEntryMargin)) return -1;
    return base + (poorEma[g] ?? 0) / (1 + n);
  }

  /// Marge moyenne des vendeurs en place d'une catégorie (pour l'interface) ; null sans vendeur actif.
  double? categoryMargin(String g) {
    var rev = 0.0, mar = 0.0;
    for (final f in sellersOf(g)) {
      if (f.workers.isEmpty) continue;
      final d = f.demandEma[g] ?? 0;
      final pr = f.price[g]!;
      rev += d * pr;
      mar += d * (pr - (f.unitCostCache[g] ?? pr));
    }
    return rev > 0 ? mar / rev : null;
  }
}
