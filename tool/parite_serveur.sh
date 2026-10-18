#!/usr/bin/env bash
# Parité PC ↔ serveur de calcul, en une commande (à lancer sur le PC, Git Bash) : la batterie de
# tool/parite_plateformes.sh tourne en même temps sur les deux machines, puis tool/parite_comparer.dart compare.
# À refaire après chaque changement du moteur, avant de lancer un lot sur le serveur.
#
#   bash tool/parite_serveur.sh [hôte]           (défaut : ubuntu@econodes-calc)
#
# Les deux côtés jouent la révision HEAD : compiler ici (bash tool/compiler.sh) et l'envoyer
# (bash tool/envoyer_serveur.sh), qui l'installe dans ~/econodes/<révision>/. Sorties : build/parite/pc et
# build/parite/serveur (environ 100 Mo chacune) ; sur le serveur, ~/resultats/parite-<révision>. Le verdict est noté dans
# ~/resultats/JOURNAL.
set -euo pipefail
cd "$(dirname "$0")/.."
hote=${1:-ubuntu@econodes-calc}
rev=$(git rev-parse HEAD)
court=${rev:0:12}
branche=$(git rev-parse --abbrev-ref HEAD)
[[ $branche =~ ^[A-Za-z0-9._/-]+$ ]] || branche=inconnue
distant=$(ssh "$hote" "cat ~/econodes/$court/.revision 2> /dev/null || echo aucune")
if [[ $distant != "$rev" ]]; then
  echo "La révision $court ($branche) n'est pas installée sur le serveur : lancer d'abord bash tool/envoyer_serveur.sh." >&2
  exit 2
fi
if [[ -n $(git status --porcelain -- lib/engine tool) ]]; then
  echo "Attention : lib/engine ou tool/ ont des modifications non commitées ; elles comptent ici, pas sur le serveur." >&2
fi
autres=$(ssh "$hote" 'for p in $(pgrep -f "(partie|stabilite|perf)\.exe"); do readlink /proc/$p/exe; done' |
  grep -E '/(partie|stabilite|perf)\.exe' || true)
if [[ -n $autres ]]; then
  echo "Note : des parties tournent sur le serveur ; la parité n'en dépend pas, mais elles seront ralenties 3 minutes." >&2
fi
rm -rf build/parite
mkdir -p build/parite/serveur
# sans les retours chariot : sur ce PC, git écrit les fichiers en CRLF (core.autocrlf), que bash refuse sous Linux
tr -d '\r' < tool/parite_plateformes.sh | ssh "$hote" "cat > /tmp/parite_plateformes-$court.sh"
ssh "$hote" "rm -rf ~/resultats/parite-$court && bash /tmp/parite_plateformes-$court.sh ~/econodes/$court ~/resultats/parite-$court" \
  < /dev/null > build/parite/serveur.log 2>&1 &
serveur=$!
bash tool/parite_plateformes.sh . build/parite/pc
wait $serveur || { echo "Échec sur le serveur :" >&2; cat build/parite/serveur.log >&2; exit 1; }
ssh "$hote" "tar -C ~/resultats/parite-$court -cf - ." | tar -xf - -C build/parite/serveur
set +e
dart run tool/parite_comparer.dart build/parite/pc build/parite/serveur
statut=$?
set -e
verdict=$([[ $statut == 0 ]] && echo IDENTIQUE || echo DIVERGENCE)
ssh "$hote" "mkdir -p ~/resultats && printf '%s\tparite\t%s\t%s\t%s\n' \"\$(date -Is)\" $court $branche \
  '$verdict (~/resultats/parite-$court)' >> ~/resultats/JOURNAL"
exit $statut
