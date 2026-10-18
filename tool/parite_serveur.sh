#!/usr/bin/env bash
# Parité PC ↔ serveur de calcul, en une commande (à lancer sur le PC, Git Bash) : la batterie de
# tool/parite_plateformes.sh tourne en même temps sur les deux machines, puis tool/parite_comparer.dart compare.
# À refaire après chaque changement du moteur, avant de lancer un lot sur le serveur.
#
#   bash tool/parite_serveur.sh [hôte]           (défaut : ubuntu@econodes-calc)
#
# Les deux côtés doivent être à la même révision : compiler ici (bash tool/compiler.sh) et envoyer
# (bash tool/envoyer_serveur.sh). Sorties : build/parite/pc et build/parite/serveur (environ 100 Mo chacune).
set -euo pipefail
cd "$(dirname "$0")/.."
hote=${1:-ubuntu@econodes-calc}
rev=$(git rev-parse HEAD)
distant=$(ssh "$hote" 'cat ~/econodes/.revision 2> /dev/null || echo aucune')
if [[ $distant != "$rev" ]]; then
  echo "Le serveur est à la révision ${distant:0:7}, le PC à ${rev:0:7} : lancer d'abord bash tool/envoyer_serveur.sh." >&2
  exit 2
fi
if [[ -n $(git status --porcelain -- lib/engine tool) ]]; then
  echo "Attention : lib/engine ou tool/ ont des modifications non commitées ; elles comptent ici, pas sur le serveur." >&2
fi
rm -rf build/parite
mkdir -p build/parite/serveur
scp -q tool/parite_plateformes.sh "$hote":/tmp/parite_plateformes.sh
ssh "$hote" 'rm -rf ~/resultats/parite && bash /tmp/parite_plateformes.sh ~/econodes ~/resultats/parite' \
  < /dev/null > build/parite/serveur.log 2>&1 &
serveur=$!
bash tool/parite_plateformes.sh . build/parite/pc
wait $serveur || { echo "Échec sur le serveur :" >&2; cat build/parite/serveur.log >&2; exit 1; }
ssh "$hote" 'tar -C ~/resultats/parite -cf - .' | tar -xf - -C build/parite/serveur
dart run tool/parite_comparer.dart build/parite/pc build/parite/serveur
