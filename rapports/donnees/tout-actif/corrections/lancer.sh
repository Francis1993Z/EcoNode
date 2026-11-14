#!/usr/bin/env bash
# Lot sur le PC : corrections du commerce extérieur (feature/tout-actif). 10 graines × 3 000 j, 240 / 1 000 / 2 500
# citoyens, réglages de l'interface (tous les modules, frontières ouvertes), filets actifs. Configurations :
#   B1    prix mondiaux qui vivent seuls (worldPriceDrift)
#   B2    repas non échangeables seuls (localMeals)
#   B3    préférence de 20 % pour ce qui est fait ici seule (homePreference)
#   B123  les trois ensemble (nouveaux réglages de l'interface)
# A, B et C : rapports/donnees/tout-actif/releves.csv (mêmes graines ; corrections coupées, partie identique).
# derive.exe : dart compile exe tool/derive.dart -o <dossier>/derive.exe (son chemin est dans cmds.txt, à adapter).
cd "$(dirname "$0")"
date -Is >> DEBUT
xargs -P 12 -L 1 -a "${1:-cmds.txt}" bash -c 'out=$0; "$@" > "$out" 2>&1 || true'
date -Is >> FINI
