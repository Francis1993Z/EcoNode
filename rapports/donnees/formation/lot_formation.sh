#!/usr/bin/env bash
# Lot de mesure de tool/formation.dart : taille, jours, étiquette, graines, options (--param ...) ; parallélisme P (8 par défaut).
#   bash rapports/donnees/formation/lot_formation.sh <etiquette> <jours> "<tailles>" "<graines>" [--param a=b]
cd "$(dirname "$0")/../../.."
et=$1; jours=$2; tailles=$3; graines=$4; shift 4
mkdir -p rapports/donnees/formation/$et
for n in $tailles; do for g in $graines; do
  echo "$g $n"
done; done | xargs -P ${P:-8} -L1 bash -c 'build/outils/formation.exe $0 $1 '$jours' --sortie rapports/donnees/formation/'$et'/g$0_n$1.txt '"$*"' || true'
