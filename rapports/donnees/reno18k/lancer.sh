#!/usr/bin/env bash
# Lot sur le PC : 20 graines × 18 000 j à 2 500 citoyens, tous les modules + Rénovation, filets coupés (feature/renovation 93033b5).
# À comparer aux parties filets 0 de rapports/donnees/derive36k (mêmes graines, sans Rénovation), jours ≤ 18 000.
# derive.exe : dart compile exe tool/derive.dart -o <dossier>/derive.exe (son chemin est dans cmds.txt, à adapter).
cd "$(dirname "$0")"
date -Is > DEBUT
xargs -P 12 -L 1 -a cmds.txt bash -c 'out=$0; "$@" > "$out" 2>&1 || true'
date -Is > FINI
