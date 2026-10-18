#!/usr/bin/env bash
# Débit du serveur de calcul : N parties en parallèle, chacune dans son processus (partie.exe), pour plusieurs N.
# Pour chaque palier : temps et mémoire maximale de chaque partie (/usr/bin/time -v), vmstat toutes les 5 s (colonne
# st : temps volé par l'hyperviseur) et empreinte SHA-256 de l'état complet au dernier jour (instantané), qui ne doit
# pas dépendre de la charge.
#
#   bash ~/econodes/<révision>/tool/mesure_debit.sh [--paliers 1,2,4,6,8] [--population 10000] [--jours 100]
#                             [--sortie dossier] [--graines 1|n] [--force] [-- options de partie.exe]
#
#   --graines n   (défaut) la partie k du palier joue la graine k ; --graines 1 : toutes jouent la graine 1
#   --force       mesurer même si d'autres parties tournent (sans --force : refus, la mesure serait faussée)
#
# Joue la révision du dossier d'où le script est lancé (~/econodes/<révision>/, installé par tool/envoyer_serveur.sh).
# Sortie : <sortie>/n<N>/ (journaux, vmstat.log), <sortie>/parties.tsv (une ligne par partie) et
# <sortie>/paliers.tsv (une ligne par palier), aussi affichés. La mesure est notée dans ~/resultats/JOURNAL.
set -euo pipefail
racine=$(cd "$(dirname "$(readlink -f "$0")")/.." && pwd)
exe=$racine/build/outils/partie.exe
[[ -x $exe && -f $racine/.revision ]] || { echo "Aucune révision compilée dans $racine (tool/envoyer_serveur.sh)." >&2; exit 2; }
rev=$(cat "$racine/.revision")
paliers=1,2,4,6,8
pop=10000
jours=100
graines=n
force=0
sortie=~/resultats/debit-$(date +%F-%H%M)-${rev:0:12}
extra=()
while [[ $# -gt 0 ]]; do
  case $1 in
    --paliers) paliers=$2; shift 2 ;;
    --population) pop=$2; shift 2 ;;
    --jours) jours=$2; shift 2 ;;
    --sortie) sortie=$2; shift 2 ;;
    --graines) graines=$2; shift 2 ;;
    --force) force=1; shift ;;
    --) shift; extra=("$@"); break ;;
    *) echo "Option inconnue : $1" >&2; exit 2 ;;
  esac
done
# parties en cours : processus dont l'exécutable est partie, stabilite ou perf (Dart renomme ses processus, et les
# coquilles qui les lancent ont le même chemin dans leur ligne de commande)
autres=$(for p in $(pgrep -f '(partie|stabilite|perf)\.exe'); do
  if [[ $(readlink "/proc/$p/exe" 2> /dev/null) =~ /(partie|stabilite|perf)\.exe( \(deleted\))?$ ]]; then
    echo "$p $(tr '\0' ' ' < "/proc/$p/cmdline" 2> /dev/null)"
  fi
done)
if [[ -n $autres && $force == 0 ]]; then
  echo "D'autres parties tournent déjà ; la mesure serait faussée :" >&2
  echo "$autres" | cut -c1-160 | sed 's/^/  /' >&2
  echo "Attendre, ou relancer avec --force." >&2
  exit 1
fi
mkdir -p "$sortie" ~/resultats
printf '%s\tmesure\t%s\t%s\t%s\n' "$(date -Is)" "${rev:0:12}" "$(cat "$racine/.branche" 2> /dev/null || echo inconnue)" \
  "$sortie : paliers $paliers, $pop habitants, $jours jours" >> ~/resultats/JOURNAL
{
  echo "# $(date -Is) $(hostname), révision $rev"
  echo "# $(lscpu | sed -n 's/^Model name: *//p'), $(nproc) vCPU, $(free -g | awk '/^Mem/ { print $2 }') Gio"
  echo "# population $pop, $jours jours, graines $graines, options : ${extra[*]:-aucune}"
} | tee "$sortie/contexte.txt"
printf 'N\tgraine\tsecondes\tms_par_jour\trss_mo\tsha256_jour_%s\n' "$jours" > "$sortie/parties.tsv"
printf 'N\tmur_s\tms_jour_moyen\tms_jour_pire\trss_total_mo\tjours_par_heure\tst_moyen\tst_max\tus_moyen\n' > "$sortie/paliers.tsv"

for n in ${paliers//,/ }; do
  d="$sortie/n$n"
  mkdir -p "$d"
  vmstat -n 5 > "$d/vmstat.log" &
  vm=$!
  t0=$(date +%s.%N)
  pids=()
  for k in $(seq 1 "$n"); do
    g=$k
    [[ $graines == 1 ]] && g=1
    /usr/bin/time -v -o "$d/p$k.time" "$exe" --graine "$g" --population "$pop" --jours "$jours" "${extra[@]}" \
      --snapshot-at "$jours" --snapshot-dir "$d/p$k" > "$d/p$k.log" 2>&1 &
    pids+=($!)
  done
  for p in "${pids[@]}"; do
    wait "$p" || echo "palier $n : une partie a échoué (voir $d/p*.log)" >&2
  done
  t1=$(date +%s.%N)
  sleep 1
  kill $vm
  wait $vm 2> /dev/null || true
  mur=$(awk -v a="$t0" -v b="$t1" 'BEGIN { printf "%.1f", b - a }')
  for k in $(seq 1 "$n"); do
    g=$k
    [[ $graines == 1 ]] && g=1
    s=$(sed -n 's/.*Elapsed (wall clock) time.*: //p' "$d/p$k.time" | awk -F: '{ s = 0; for (i = 1; i <= NF; i++) s = s * 60 + $i; printf "%.1f", s }')
    rss=$(sed -n 's/.*Maximum resident set size (kbytes): //p' "$d/p$k.time" | awk '{ printf "%.0f", $1 / 1024 }')
    sha=$(sha256sum "$d"/p$k/instantane-*.json 2> /dev/null | cut -c1-16)
    sha=${sha:-absent}
    rm -rf "$d/p$k" # 20 à 25 Mo par instantané à 10 000 habitants : on ne garde que l'empreinte
    printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$n" "$g" "$s" "$(awk -v s="$s" -v j="$jours" 'BEGIN { printf "%.0f", 1000 * s / j }')" \
      "$rss" "$sha" >> "$sortie/parties.tsv"
  done
  # vmstat : colonnes repérées par leur nom ; la première ligne de données (moyenne depuis le démarrage) est écartée
  read -r stm stx usm < <(awk 'NR == 2 { for (i = 1; i <= NF; i++) c[$i] = i; next }
    NR > 3 && $1 ~ /^[0-9]+$/ { st += $c["st"]; us += $c["us"]; if ($c["st"] > mx) mx = $c["st"]; k++ }
    END { if (k) printf "%.1f %d %.0f\n", st / k, mx, us / k; else print "? ? ?" }' "$d/vmstat.log")
  awk -F'\t' -v n="$n" -v mur="$mur" -v j="$jours" -v stm="$stm" -v stx="$stx" -v usm="$usm" '
    $1 == n { k++; ms += $4; if ($4 > pire) pire = $4; rss += $5 }
    END { printf "%s\t%s\t%.0f\t%d\t%d\t%.0f\t%s\t%s\t%s\n", n, mur, ms / k, pire, rss, 3600 * n * j / mur, stm, stx, usm }' \
    "$sortie/parties.tsv" >> "$sortie/paliers.tsv"
  tail -1 "$sortie/paliers.tsv"
done
echo
column -t -s $'\t' "$sortie/paliers.tsv"
echo
column -t -s $'\t' "$sortie/parties.tsv"
