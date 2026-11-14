#!/usr/bin/env bash
# Lot sur le PC : nouveaux réglages par défaut (feature/tout-actif). 10 graines × 3 000 j, 240 / 1 000 / 2 500 citoyens,
# réglages de l'interface, filets actifs (comme l'interface). Trois configurations :
#   A  anciens défauts de l'interface : rôles, entrepreneuriat et produits ; bâtiments, banques et rénovation coupés ;
#      frontières fermées
#   B  nouveaux défauts : tous les modules, frontières ouvertes
#   C  tous les modules, frontières fermées (pour séparer l'effet des modules de celui du commerce extérieur)
# derive.exe : dart compile exe tool/derive.dart -o <dossier>/derive.exe (son chemin est dans cmds.txt, à adapter).
# Argument facultatif : un autre fichier de commandes (cmds-ac.txt : relance des configurations A et C).
cd "$(dirname "$0")"
date -Is >> DEBUT
xargs -P 12 -L 1 -a "${1:-cmds.txt}" bash -c 'out=$0; "$@" > "$out" 2>&1 || true'
date -Is >> FINI
