#!/usr/bin/env bash
# Compare deux versions du moteur sur des parties plus longues et plus grandes que la batterie de tool/reference.sh :
# mêmes graines, mêmes réglages, empreintes quotidiennes (16 parties de l'état par jour) comparées octet pour octet, et
# instantané du dernier jour (SHA-256). Sert à vérifier qu'une optimisation ne change rien, à toutes les tailles.
#
#   bash tool/comparer_moteurs.sh A/partie.exe B/partie.exe [population:jours:graine:filets ...]
#
# Parties par défaut : 3000:400:1:1  3000:400:2:0  10000:300:1:1  (environ 6 minutes). Code de sortie 0 si identique.
set -euo pipefail
a=$1
b=$2
shift 2
cas=("$@")
[[ ${#cas[@]} -gt 0 ]] || cas=(3000:400:1:1 3000:400:2:0 10000:300:1:1)
tmp=build/comparer-$$ # dans le dépôt : un exécutable Windows ne lit pas /tmp
mkdir -p "$tmp"
trap 'rm -rf "$tmp"' EXIT
mauvais=0
for c in "${cas[@]}"; do
  IFS=: read -r pop jours graine filets <<< "$c"
  d=${c//:/-}
  for x in a b; do
    exe=$a
    [[ $x == b ]] && exe=$b
    mkdir -p "$tmp/$d/$x"
    ("$exe" --graine "$graine" --population "$pop" --jours "$jours" --filets "$filets" --empreintes "$tmp/$d/$x/emp.jsonl" \
      --snapshot-at "$jours" --snapshot-dir "$tmp/$d/$x/snap" > /dev/null) &
  done
  wait
  sa=$(sha256sum "$tmp/$d"/a/snap/instantane-*.json | cut -c1-16)
  sb=$(sha256sum "$tmp/$d"/b/snap/instantane-*.json | cut -c1-16)
  if cmp -s "$tmp/$d/a/emp.jsonl" "$tmp/$d/b/emp.jsonl" && [[ $sa == "$sb" ]]; then
    echo "identique : $pop habitants, $jours jours, graine $graine, filets $filets (instantané $sa)"
  else
    echo "DIVERGENCE : $pop habitants, $jours jours, graine $graine, filets $filets"
    mauvais=1
  fi
done
[[ $mauvais == 0 ]] && echo "MOTEURS : IDENTIQUES" || echo "MOTEURS : DIVERGENCE"
exit $mauvais
