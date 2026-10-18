// Référence du moteur : empreintes de la batterie de parité (tool/parite_plateformes.sh), à écrire une fois et à vérifier
// après chaque changement qui ne doit rien changer au moteur (optimisation, outil, interface).
//
//   dart run tool/reference.dart ecrire   <dossier de la batterie> <fichier de référence>
//   dart run tool/reference.dart verifier <dossier de la batterie> <fichier de référence>
//   dart run tool/reference.dart afficher <dossier de la batterie>
//
// Le fichier de référence a une ligne par fichier de la batterie qui décrit l'état du moteur : « sha256  chemin » pour les
// empreintes quotidiennes (*.jsonl) et les instantanés complets (instantane-*.json), puis « niveau0 » (synthèse du
// protocole niveau 0 sans la date, la durée ni le nombre d'isolats) et « parite » (sortie de parite.exe, sans retours
// chariot). Sans chemin de machine ni date : le même fichier convient au PC et au serveur. `tool/reference.sh` fait le tout.
// Code de sortie de « verifier » : 0 si identique, 1 sinon.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

void main(List<String> args) {
  if (args.length < 2) _usage();
  final cmd = args[0];
  final dossier = args[1];
  final lignes = reference(dossier);
  switch (cmd) {
    case 'afficher':
      stdout.write('${lignes.join('\n')}\n');
    case 'ecrire':
      if (args.length < 3) _usage();
      File(args[2])
        ..parent.createSync(recursive: true)
        ..writeAsStringSync('${lignes.join('\n')}\n');
      stdout.writeln('${lignes.length} lignes écrites : ${args[2]}');
    case 'verifier':
      if (args.length < 3) _usage();
      final attendu = File(args[2]).readAsLinesSync().where((l) => l.trim().isNotEmpty).toList();
      final a = {for (final l in attendu) _cle(l): l}, b = {for (final l in lignes) _cle(l): l};
      var diff = 0;
      for (final k in {...a.keys, ...b.keys}) {
        if (a[k] == b[k]) continue;
        diff++;
        stdout.writeln(a[k] == null
            ? 'EN PLUS : $k'
            : (b[k] == null ? 'MANQUE : $k' : 'DIFFÉRENT : $k\n  référence : ${a[k]}\n  obtenu    : ${b[k]}'));
      }
      stdout.writeln(diff == 0
          ? 'RÉFÉRENCE : IDENTIQUE (${lignes.length} éléments)'
          : 'RÉFÉRENCE : DIVERGENCE ($diff élément(s) sur ${a.length})');
      exit(diff == 0 ? 0 : 1);
    default:
      _usage();
  }
}

Never _usage() {
  stderr.writeln('Usage : dart run tool/reference.dart ecrire|verifier <dossier batterie> <référence> | afficher <dossier>');
  exit(2);
}

String _cle(String ligne) => ligne.substring(ligne.indexOf('  ') + 2);

/// Les lignes de référence d'un dossier de sortie de tool/parite_plateformes.sh.
List<String> reference(String dossier) {
  final racine = Directory(dossier).absolute.path.replaceAll('\\', '/');
  final out = <String>[];
  final fichiers = <String>[
    for (final e in Directory(dossier).listSync(recursive: true))
      if (e is File)
        if (e.path.endsWith('.jsonl') || RegExp(r'instantane-[^/\\]*\.json$').hasMatch(e.path))
          e.absolute.path.replaceAll('\\', '/').substring(racine.length + 1),
  ]..sort();
  for (final f in fichiers) {
    out.add('${sha256Hex(File('$racine/$f').readAsBytesSync())}  $f');
  }
  final niveau0 = jsonDecode(File('$racine/niveau0.json').readAsStringSync()) as Map;
  for (final k in ['date', 'seconds', 'isolates']) {
    niveau0.remove(k);
  }
  out.add('${sha256Hex(utf8.encode(jsonEncode(niveau0)))}  niveau0');
  final parite = File('$racine/parite.txt').readAsStringSync().replaceAll('\r', '');
  out.add('${sha256Hex(utf8.encode(parite))}  parite');
  return out;
}

// ------------------------------------------------------------------ SHA-256 (FIPS 180-4)

const List<int> _k = [
  0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01,
  0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
  0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da, 0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147,
  0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
  0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070, 0x19a4c116, 0x1e376c08,
  0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
  0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
];

int _rotr(int x, int n) => ((x >> n) | (x << (32 - n))) & 0xFFFFFFFF;

String sha256Hex(List<int> data) {
  var h0 = 0x6a09e667, h1 = 0xbb67ae85, h2 = 0x3c6ef372, h3 = 0xa54ff53a;
  var h4 = 0x510e527f, h5 = 0x9b05688c, h6 = 0x1f83d9ab, h7 = 0x5be0cd19;
  final n = data.length;
  final total = ((n + 9 + 63) ~/ 64) * 64;
  final msg = Uint8List(total);
  msg.setRange(0, n, data);
  msg[n] = 0x80;
  final bits = n * 8;
  for (var i = 0; i < 8; i++) {
    msg[total - 1 - i] = (bits >> (8 * i)) & 0xFF;
  }
  final w = Uint32List(64);
  for (var off = 0; off < total; off += 64) {
    for (var i = 0; i < 16; i++) {
      w[i] = (msg[off + 4 * i] << 24) | (msg[off + 4 * i + 1] << 16) | (msg[off + 4 * i + 2] << 8) | msg[off + 4 * i + 3];
    }
    for (var i = 16; i < 64; i++) {
      final s0 = _rotr(w[i - 15], 7) ^ _rotr(w[i - 15], 18) ^ (w[i - 15] >> 3);
      final s1 = _rotr(w[i - 2], 17) ^ _rotr(w[i - 2], 19) ^ (w[i - 2] >> 10);
      w[i] = (w[i - 16] + s0 + w[i - 7] + s1) & 0xFFFFFFFF;
    }
    var a = h0, b = h1, c = h2, d = h3, e = h4, f = h5, g = h6, h = h7;
    for (var i = 0; i < 64; i++) {
      final s1 = _rotr(e, 6) ^ _rotr(e, 11) ^ _rotr(e, 25);
      final ch = (e & f) ^ (~e & 0xFFFFFFFF & g);
      final t1 = (h + s1 + ch + _k[i] + w[i]) & 0xFFFFFFFF;
      final s0 = _rotr(a, 2) ^ _rotr(a, 13) ^ _rotr(a, 22);
      final maj = (a & b) ^ (a & c) ^ (b & c);
      final t2 = (s0 + maj) & 0xFFFFFFFF;
      h = g;
      g = f;
      f = e;
      e = (d + t1) & 0xFFFFFFFF;
      d = c;
      c = b;
      b = a;
      a = (t1 + t2) & 0xFFFFFFFF;
    }
    h0 = (h0 + a) & 0xFFFFFFFF;
    h1 = (h1 + b) & 0xFFFFFFFF;
    h2 = (h2 + c) & 0xFFFFFFFF;
    h3 = (h3 + d) & 0xFFFFFFFF;
    h4 = (h4 + e) & 0xFFFFFFFF;
    h5 = (h5 + f) & 0xFFFFFFFF;
    h6 = (h6 + g) & 0xFFFFFFFF;
    h7 = (h7 + h) & 0xFFFFFFFF;
  }
  return [h0, h1, h2, h3, h4, h5, h6, h7].map((x) => x.toRadixString(16).padLeft(8, '0')).join();
}
