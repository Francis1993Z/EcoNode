#!/usr/bin/env bash
# État du serveur de calcul (à lancer sur le PC, Git Bash) : révisions installées, parties et sessions tmux en cours,
# fin du journal des lancements. À regarder avant d'envoyer du code ou de lancer un lot : un seul lot à la fois.
#
#   bash tool/etat_serveur.sh [hôte]                          (défaut : ubuntu@econodes-calc)
#   bash tool/etat_serveur.sh --supprimer <révision> [hôte]   retire ~/econodes/<révision>/
#
# Une révision n'est supprimée que si aucune partie ne tourne avec ses exécutables. Les lots n'en dépendent pas : chacun
# garde sa copie de partie.exe (tool/lot_serveur.sh). Une révision supprimée se réinstalle par tool/envoyer_serveur.sh.
set -euo pipefail
cd "$(dirname "$0")/.."
supprimer=
if [[ ${1:-} == --supprimer ]]; then
  supprimer=${2:-}
  [[ $supprimer =~ ^[0-9a-f]{4,40}$ ]] || { echo "--supprimer : une empreinte de commit (au moins 4 caractères)." >&2; exit 2; }
  shift 2
fi
hote=${1:-ubuntu@econodes-calc}
head=$(git rev-parse HEAD)

if [[ -n $supprimer ]]; then
  ssh "$hote" "CIBLE=${supprimer:0:12} bash -s" << 'FIN'
shopt -s nullglob
d=(~/econodes/"$CIBLE"*/)
if [[ ${#d[@]} != 1 ]]; then
  echo "${#d[@]} révision(s) installée(s) correspondent à $CIBLE : $(ls ~/econodes | tr '\n' ' ')" >&2
  exit 2
fi
d=${d[0]%/}
# processus dont l'exécutable vient de ce dossier (pas les coquilles qui l'ont lancé)
utilisent=$(for p in $(pgrep -f "$d/build/outils/"); do
  [[ $(readlink "/proc/$p/exe" 2> /dev/null) == "$d/build/outils/"* ]] && echo "  $p $(tr '\0' ' ' < "/proc/$p/cmdline")"
done)
if [[ -n $utilisent ]]; then
  echo "Des parties utilisent $d ; rien n'est supprimé :" >&2
  cut -c1-160 <<< "$utilisent" >&2
  exit 1
fi
b=$(cat "$d/.branche" 2> /dev/null || echo inconnue)
rm -rf "$d"
mkdir -p ~/resultats
printf '%s\tsuppression\t%s\t%s\t%s\n' "$(date -Is)" "$(basename "$d")" "$b" "$d" >> ~/resultats/JOURNAL
echo "Supprimée : $d ($b). Restent : $(ls ~/econodes | tr '\n' ' ')"
FIN
  exit
fi

ssh "$hote" "TETE=${head:0:12} bash -s" << 'FIN'
# parties en cours : processus dont l'exécutable est partie, stabilite ou perf (Dart renomme ses processus, et les
# coquilles qui les lancent ont le même chemin dans leur ligne de commande) ; « pid exécutable ligne de commande »
parties() {
  local p x
  for p in $(pgrep -f '(partie|stabilite|perf)\.exe'); do
    x=$(readlink "/proc/$p/exe" 2> /dev/null)
    [[ $x =~ /(partie|stabilite|perf)\.exe( \(deleted\))?$ ]] && echo "$p ${x% (deleted)} $(tr '\0' ' ' < "/proc/$p/cmdline")"
  done
  return 0
}
en_cours=$(parties)
echo "Révisions installées (~/econodes) :"
vu=0
for d in ~/econodes/*/; do
  d=${d%/}
  [[ -f $d/.revision ]] || continue
  r=$(basename "$d")
  b=$(cat "$d/.branche" 2> /dev/null || echo inconnue)
  e=$(cut -c1-16 "$d/.envoi" 2> /dev/null | tr T ' ')
  t=$(du -sh "$d" | cut -f1)
  u=$(awk -v d="$d/build/outils/" 'index($2, d) == 1' <<< "$en_cours" | wc -l)
  m=
  if [[ $r == "$TETE" ]]; then m="  ← HEAD du PC"; vu=1; fi
  printf '  %s  %-30s envoyée le %s  %5s  %s partie(s) lancée(s) depuis ce dossier%s\n' "$r" "$b" "${e:-?}" "$t" "$u" "$m"
done
[[ $vu == 1 ]] || echo "  (la révision HEAD du PC, $TETE, n'est pas installée : tool/envoyer_serveur.sh)"
echo
echo "Parties en cours (lots compris) :"
if [[ -n $en_cours ]]; then cut -d' ' -f1,3- <<< "$en_cours" | cut -c1-160 | sed 's/^/  /'; else echo "  aucune"; fi
echo
echo "Sessions tmux :"
s=$(tmux ls 2> /dev/null)
if [[ -n $s ]]; then echo "$s" | sed 's/^/  /'; else echo "  aucune"; fi
echo
echo "Fin du journal (~/resultats/JOURNAL : date, événement, révision, branche, détail) :"
if [[ -s ~/resultats/JOURNAL ]]; then tail -n 10 ~/resultats/JOURNAL | sed 's/^/  /'; else echo "  vide"; fi
FIN
