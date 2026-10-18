#!/usr/bin/env bash
# Compile les outils en exécutables natifs (AOT) dans build/outils/. Le moteur est figé dans chaque exécutable :
# modifier lib/ pendant qu'un protocole tourne ne change pas la partie en cours (relancer ce script ensuite).
#
#   bash tool/compiler.sh
set -e
cd "$(dirname "$0")/.."
mkdir -p build/outils
for t in stabilite fusion_syntheses partie perf parite echelle reference; do
  dart compile exe "tool/$t.dart" -o "build/outils/$t.exe" > /dev/null
  echo "build/outils/$t.exe"
done
