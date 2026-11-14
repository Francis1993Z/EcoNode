#!/usr/bin/env bash
# Lot long : 20 graines × 36 000 j à 2 500 citoyens, tous les modules, filets coupés / actifs ; arrêt du serveur à la fin.
cd "$(dirname "$0")"
rev=$(basename "$PWD" | sed 's/.*-//')
printf '%s\tlot-debut\t%s\tmain\t%s : %s\n' "$(date -Is)" "$rev" "$PWD" "20 graines × 36 000 j, 2 500 citoyens, réglages de l'interface, tous les modules (Produits, Bâtiments, Banques), filets 0/1 ; arrêt à la fin" >> ~/resultats/JOURNAL
xargs -P 8 -L 1 -a cmds.txt bash -c 'out=$0; "$@" > "$out" 2>&1 || true'
touch FINI
printf '%s\tlot-fin\t%s\tmain\t%s : fini\n' "$(date -Is)" "$rev" "$PWD" >> ~/resultats/JOURNAL
printf '%s\tarret\t-\t-\tlot derive36k fini : arrêt dans 5 min\n' "$(date -Is)" >> ~/resultats/JOURNAL
sudo -n shutdown -h +5
