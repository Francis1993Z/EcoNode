#!/usr/bin/env bash
# Batterie de parité entre machines (PC Windows, serveur Linux) : les mêmes parties, jouées par les exécutables natifs
# de build/outils/, écrivent leurs sorties dans un dossier ; tool/parite_comparer.dart compare ensuite deux dossiers.
# tool/parite_serveur.sh lance tout depuis le PC.
#
#   bash tool/parite_plateformes.sh <dossier econodes> <dossier de sortie>
#
# - parite.exe (graines 1 et 42, 400 jours) ;
# - 240 habitants : graines 1 à 3 × 1 500 jours, filets actifs et coupés ; empreintes de chaque jour (16 parties de
#   l'état) et instantanés complets aux jours 100, 500 et 1 500 ;
# - protocole niveau 0 de stabilite.exe (5 graines × 500 jours, sans et avec filets) ;
# - 10 000 habitants : graines 1 à 3 × 100 jours, empreintes de chaque jour et instantané du jour 100.
# Durée : 3 min environ (PC ou serveur).
set -euo pipefail
R=$(cd "$1" && pwd)
mkdir -p "$2"
O=$(cd "$2" && pwd)
B="$R/build/outils"
t0=$(date +%s)
"$B/parite.exe" > "$O/parite.txt"
for f in 1 0; do
  for g in 1 2 3; do
    ("$B/partie.exe" --graine $g --jours 1500 --filets $f --empreintes "$O/emp-g$g-f$f.jsonl" \
      --snapshot-at 100,500,1500 --snapshot-dir "$O/snap-g$g-f$f" | grep -v '^Temps' > "$O/partie-g$g-f$f.txt") &
  done
done
wait
echo "240 habitants : $(($(date +%s) - t0)) s"
(cd "$O" && "$B/stabilite.exe" --niveau 0 --save "$O/niveau0.json" --out "$O/niveau0.md" 2> "$O/niveau0.log")
echo "niveau 0 : $(($(date +%s) - t0)) s"
for g in 1 2 3; do
  ("$B/partie.exe" --graine $g --jours 100 --population 10000 --empreintes "$O/emp10k-g$g.jsonl" \
    --snapshot-at 100 --snapshot-dir "$O/snap10k-g$g" | grep -v '^Temps' > "$O/partie10k-g$g.txt") &
done
wait
echo "10 000 habitants : $(($(date +%s) - t0)) s"
(cd "$O" && find . -type f \( -name '*.jsonl' -o -name 'instantane-*.json' -o -name '*.txt' \) ! -name sha256.txt |
  LC_ALL=C sort | xargs sha256sum) > "$O/sha256.txt"
cat "$R/.revision" 2> /dev/null > "$O/revision" || git -C "$R" rev-parse HEAD > "$O/revision"
echo "fini : $O"
