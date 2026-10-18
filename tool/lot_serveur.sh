#!/usr/bin/env bash
# Lot de parties sur le serveur de calcul : une liste de tâches, N parties à la fois, un journal par partie, reprise
# après coupure. À lancer sur le serveur ; sans --premier-plan, le lot part dans une session tmux, qui survit à la
# fermeture du SSH.
#
#   bash ~/econodes/<révision>/tool/lot_serveur.sh [options] taches.txt
#
# La révision jouée est celle du dossier d'où le script est lancé : ~/econodes/<révision>/, installé par
# tool/envoyer_serveur.sh (tool/etat_serveur.sh les liste). --revision en choisit une autre.
#
#   -j, --parallele 8        parties simultanées (défaut : nombre de vCPU, 8 sur c7i.2xlarge ; voir
#                            rapports/serveur-calcul.md : 8 donne 24 % de débit de plus que 4, et 6 est à éviter)
#   --dossier D              dossier du lot (défaut : ~/resultats/<AAAA-MM-JJ>-<nom du fichier de tâches>-<révision>)
#   --eteindre-a-la-fin      quand toutes les parties ont été jouées (réussies ou non) : « sudo shutdown -h +5 », pour
#                            arrêter la facturation du calcul (annulable dans les 5 minutes : « sudo shutdown -c »).
#                            Désactivé par défaut. Le disque reste facturé tant que l'instance existe.
#   --premier-plan           pas de session tmux : le lot tourne dans ce terminal
#   --revision R             révision à jouer, parmi celles de ~/econodes (le début de l'empreinte suffit)
#   --force                  partir même si d'autres parties tournent déjà sur la machine. Sans --force, le lot refuse :
#                            deux lots se partageraient les vCPU, iraient chacun moins vite et fausseraient leurs durées
#
# Fichier de tâches : une partie par ligne, « graine niveau population jours [options de partie.exe] ». Lignes vides et
# commentaires (#) ignorés. Exemple, le protocole de stabilité à 10 000 habitants (30 graines, sans et avec filets) :
#
#   for g in $(seq 1 30); do for f in 0 1; do echo "$g 1 10000 1500 --filets $f"; done; done > stabilite10k.txt
#
# - niveau : niveau du protocole (0, 1, 2, ou « - »). partie.exe n'a pas de niveau : pour une partie seule, un niveau ne
#   fixe que la graine, la durée et la population, données ici. La colonne sert d'étiquette (nom des journaux, résumé).
# - options : passées telles quelles à partie.exe (--filets 0, --modules credit=0, --param x=1, --trace {dossier}…).
#   {dossier} est remplacé par le dossier propre à la partie, où elle tourne : ses instantanés et journaux y vont.
#
# Dans le dossier du lot :
#   taches.txt, noms.txt          les tâches (sans commentaires) et le nom de chaque partie
#   revision, branche             révision du moteur (empreinte complète) et branche d'où elle a été envoyée
#   bin/partie.exe                copie figée de l'exécutable : ni un nouvel envoi ni la suppression de la révision
#                                 ne changent un lot en cours ou sa reprise
#   <nom>.log                     journal de la partie : commande, sortie, puis mesures de /usr/bin/time -v
#   <nom>.fini                    marque d'une partie réussie : une relance la saute
#   <nom>/                        dossier de travail de la partie (supprimé s'il reste vide)
#   lot.log, vmstat.log           sortie du lot ; vmstat toutes les 60 s (colonne st : temps volé par l'hyperviseur)
#   resume.csv                    une ligne par partie (statut, durée, ms par jour, mémoire, résultat), écrit à la fin
#   lot.fini                      toutes les parties ont réussi
#
# Reprise : relancer la même commande. Sans --dossier, le lot le plus récent qui a les mêmes tâches, la même révision et
# n'est pas fini (une partie a échoué, ou le lot a été coupé) est repris, même s'il a commencé un autre jour. Une partie
# interrompue est rejouée depuis le jour 1. Un lot ne se reprend jamais avec une autre révision que la sienne.
#
# Le début et la fin de chaque lot sont notés dans ~/resultats/JOURNAL (avec les envois et les mesures).
set -euo pipefail

soi=$(readlink -f "$0")

# ------------------------------------------------------------------ une partie (appelée par xargs)
if [[ ${1:-} == --une-tache ]]; then
  dossier=$2
  k=$3
  nom=$(sed -n "${k}p" "$dossier/noms.txt")
  [[ -e $dossier/$nom.fini ]] && exit 0
  set -f
  read -r graine niveau population jours reste <<< "$(sed -n "${k}p" "$dossier/taches.txt")"
  travail="$dossier/$nom"
  rm -rf "$travail" && mkdir -p "$travail"
  options=()
  for o in ${reste:-}; do options+=("${o//\{dossier\}/$travail}"); done
  set +f
  cmd=("$dossier/bin/partie.exe" --graine "$graine" --population "$population" --jours "$jours" "${options[@]}")
  {
    echo "# partie $nom (tâche $k, niveau $niveau)"
    echo "# début $(date -Is) sur $(hostname), révision $(cat "$dossier/revision")"
    echo "# commande : ${cmd[*]}"
  } > "$dossier/$nom.log"
  set +e
  (cd "$travail" && /usr/bin/time -v -o "$dossier/$nom.time" "${cmd[@]}") >> "$dossier/$nom.log" 2>&1
  statut=$?
  set -e
  { echo "# fin $(date -Is), code de sortie $statut"; cat "$dossier/$nom.time" 2> /dev/null || true; } >> "$dossier/$nom.log"
  rm -f "$dossier/$nom.time"
  rmdir "$travail" 2> /dev/null || true
  if [[ $statut == 0 ]]; then
    touch "$dossier/$nom.fini"
    echo "[$(date +%T)] finie : $nom"
  else
    echo "[$(date +%T)] ÉCHEC (code $statut) : $nom ; voir $dossier/$nom.log"
  fi
  exit 0 # un échec n'arrête pas les autres parties
fi

# ------------------------------------------------------------------ options
parallele=$(nproc)
dossier=
eteindre=0
premier_plan=0
revision=
force=0
taches=
args=("$@")
while [[ $# -gt 0 ]]; do
  case $1 in
    -j | --parallele) parallele=$2; shift 2 ;;
    --dossier) dossier=$2; shift 2 ;;
    --eteindre-a-la-fin) eteindre=1; shift ;;
    --premier-plan) premier_plan=1; shift ;;
    --revision) revision=$2; shift 2 ;;
    --force) force=1; shift ;;
    -h | --help) sed -n '2,/^set -euo/p' "$soi" | sed '$d; s/^# \{0,1\}//'; exit 0 ;;
    -*) echo "Option inconnue : $1" >&2; exit 2 ;;
    *) [[ -n $taches ]] && { echo "Un seul fichier de tâches." >&2; exit 2; }; taches=$1; shift ;;
  esac
done
[[ -n $taches && -f $taches ]] || {
  echo "Usage : bash ~/econodes/<révision>/tool/lot_serveur.sh [options] taches.txt (voir --help)" >&2
  exit 2
}
[[ $parallele =~ ^[1-9][0-9]*$ ]] || { echo "--parallele : un entier ≥ 1" >&2; exit 2; }
if [[ $eteindre == 1 ]] && ! sudo -n true 2> /dev/null; then
  echo "--eteindre-a-la-fin : sudo demande un mot de passe ici ; l'arrêt ne pourrait pas se faire." >&2
  exit 2
fi

# révision : celle du dossier d'où le script est lancé, ou celle de --revision
racine=$(cd "$(dirname "$soi")/.." && pwd)
if [[ -n $revision ]]; then
  [[ $revision =~ ^[0-9a-f]{4,40}$ ]] || { echo "--revision : une empreinte de commit (au moins 4 caractères)." >&2; exit 2; }
  shopt -s nullglob
  trouvees=(~/econodes/"${revision:0:12}"*/)
  shopt -u nullglob
  if [[ ${#trouvees[@]} != 1 ]]; then
    echo "--revision $revision : ${#trouvees[@]} révision(s) installée(s) correspondent ; installées : $(ls ~/econodes 2> /dev/null | tr '\n' ' ')" >&2
    exit 2
  fi
  racine=${trouvees[0]%/}
fi
outils=$racine/build/outils
if [[ ! -x $outils/partie.exe || ! -f $racine/.revision ]]; then
  echo "Aucune révision compilée dans $racine. Envoyer le code (tool/envoyer_serveur.sh, sur le PC), puis lancer" \
    "~/econodes/<révision>/tool/lot_serveur.sh, ou donner --revision." >&2
  exit 2
fi
rev=$(cat "$racine/.revision")
court=${rev:0:12}
branche=$(cat "$racine/.branche" 2> /dev/null || echo inconnue)

# machine occupée ? (le lot lui-même n'a encore rien lancé). Dart renomme ses processus (« dart:partie.exe ») et les
# lignes de commande des coquilles qui les lancent contiennent le même chemin : on garde les processus dont
# l'exécutable est vraiment partie, stabilite ou perf.
parties_en_cours() {
  local p
  for p in $(pgrep -f '(partie|stabilite|perf)\.exe'); do
    if [[ $(readlink "/proc/$p/exe" 2> /dev/null) =~ /(partie|stabilite|perf)\.exe( \(deleted\))?$ ]]; then
      echo "$p $(tr '\0' ' ' < "/proc/$p/cmdline" 2> /dev/null)"
    fi
  done
  return 0
}
if [[ $force == 0 ]]; then
  autres=$(parties_en_cours)
  if [[ -n $autres ]]; then
    echo "D'autres parties tournent déjà sur le serveur ; deux lots se partageraient les vCPU :" >&2
    echo "$autres" | cut -c1-160 | sed 's/^/  /' >&2
    echo "Attendre qu'elles finissent (tool/etat_serveur.sh depuis le PC, ou tmux ls), ou relancer avec --force." >&2
    exit 1
  fi
fi

# tâches normalisées : sans commentaires ni lignes vides, espaces réduits ; chaque ligne vérifiée et nommée
normal=$(sed -e 's/#.*//' -e 's/[[:space:]]\+/ /g' -e 's/^ //' -e 's/ $//' "$taches" | grep -v '^$' || true)
[[ -n $normal ]] || { echo "Aucune tâche dans $taches." >&2; exit 2; }
k=0
noms=
while read -r graine niveau population jours reste; do
  k=$((k + 1))
  [[ $graine =~ ^[0-9]+$ && ${population:-} =~ ^[0-9]+$ && ${jours:-} =~ ^[0-9]+$ && ${niveau:-} =~ ^([0-2]|-)$ ]] || {
    echo "Tâche $k mal formée : « graine niveau population jours [options] » attendu (niveau : 0, 1, 2 ou -)." >&2
    exit 2
  }
  # nom : g<graine>-n<niveau>-p<population>-j<jours>, puis les options réduites à lettres, chiffres, « = , . _ »
  suffixe=$(printf '%s' "${reste:-}" | tr -c 'A-Za-z0-9=,.' '_' | sed -e 's/__*/_/g' -e 's/^_//' -e 's/_$//')
  noms+="g$graine-n${niveau/-/x}-p$population-j$jours${suffixe:+-$suffixe}"$'\n'
done <<< "$normal"
doublon=$(printf '%s' "$noms" | sort | uniq -d | head -1)
[[ -z $doublon ]] || { echo "Deux tâches identiques : $doublon" >&2; exit 2; }

# dossier du lot : celui donné ; sinon un lot inachevé qui a les mêmes tâches et la même révision ; sinon un nouveau
base=$(basename "$taches")
base=${base%.*}
if [[ -z $dossier ]]; then
  for d in $(ls -1dt ~/resultats/*-"$base"-"$court" 2> /dev/null || true); do
    if [[ -f $d/taches.txt && ! -e $d/lot.fini && "$(cat "$d/taches.txt")" == "$normal" ]]; then
      dossier=$d
      break
    fi
  done
  dossier=${dossier:-~/resultats/$(date +%F)-$base-$court}
fi
dossier=$(mkdir -p "$dossier" && cd "$dossier" && pwd)
if [[ -f $dossier/taches.txt && "$(cat "$dossier/taches.txt")" != "$normal" ]]; then
  echo "$dossier contient un autre lot (d'autres tâches) : choisir un autre --dossier." >&2
  exit 2
fi
if [[ -f $dossier/revision && "$(cat "$dossier/revision")" != "$rev" ]]; then
  echo "$dossier a été lancé avec la révision $(cut -c1-12 "$dossier/revision"), pas $court : le reprendre avec" \
    "~/econodes/$(cut -c1-12 "$dossier/revision")/tool/lot_serveur.sh, ou choisir un autre --dossier." >&2
  exit 2
fi

# ------------------------------------------------------------------ session tmux
if [[ $premier_plan == 0 && -z ${TMUX:-} ]]; then
  session="lot-$(printf '%s' "$(basename "$dossier")" | tr -c 'A-Za-z0-9_-' '_')"
  if tmux has-session -t "$session" 2> /dev/null; then
    echo "La session tmux $session tourne déjà : tmux attach -t $session" >&2
    exit 1
  fi
  tmux new-session -d -s "$session" -c "$PWD" \
    "$(printf '%q ' bash "$soi" "${args[@]}" --premier-plan --dossier "$dossier") 2>&1 | tee -a $(printf '%q' "$dossier/lot.log")"
  echo "Lot lancé dans la session tmux « $session » : $dossier"
  echo "  suivre : tmux attach -t $session   (Ctrl-b puis d pour la quitter sans l'arrêter), ou tail -f $dossier/lot.log"
  exit 0
fi

# ------------------------------------------------------------------ le lot
exec 9> "$dossier/.verrou"
flock -n 9 || { echo "Ce lot tourne déjà ($dossier)." >&2; exit 1; }
[[ -f $dossier/taches.txt ]] || printf '%s\n' "$normal" > "$dossier/taches.txt"
printf '%s' "$noms" > "$dossier/noms.txt"
if [[ ! -x $dossier/bin/partie.exe ]]; then
  mkdir -p "$dossier/bin"
  cp "$outils/partie.exe" "$dossier/bin/partie.exe"
  echo "$rev" > "$dossier/revision"
  echo "$branche" > "$dossier/branche"
fi
n=$(wc -l < "$dossier/taches.txt")
faites=$(find "$dossier" -maxdepth 1 -name '*.fini' ! -name lot.fini | wc -l)
echo "[$(date +%T)] lot $dossier : $n parties, $faites déjà finies, $parallele à la fois, révision $court ($branche)"
journal() {
  mkdir -p ~/resultats
  printf '%s\t%s\t%s\t%s\t%s\n' "$(date -Is)" "$1" "$court" "$branche" "$2" >> ~/resultats/JOURNAL
}
journal lot-debut "$dossier : $n parties, $faites déjà finies, $parallele à la fois"

vmstat -n -t 60 >> "$dossier/vmstat.log" &
vm=$!
trap 'kill $vm 2> /dev/null || true' EXIT
debut=$(date +%s)
seq 1 "$n" | xargs -P "$parallele" -I{} bash "$soi" --une-tache "$dossier" {}
duree=$(($(date +%s) - debut))
kill $vm 2> /dev/null || true

# résumé : une ligne par partie, mesures tirées des journaux
{
  echo "nom;statut;secondes;ms_par_jour;rss_max_mo;resultat"
  paste -d '|' "$dossier/noms.txt" "$dossier/taches.txt" | while IFS='|' read -r nom ligne; do
    read -r _ _ _ jours _ <<< "$ligne"
    log="$dossier/$nom.log"
    if [[ -e $dossier/$nom.fini ]]; then statut=ok; elif [[ -f $log ]]; then statut=echec; else statut=non_jouee; fi
    sec= msj= rss= res=
    if [[ -f $log ]]; then
      sec=$(sed -n 's/.*Elapsed (wall clock) time.*: //p' "$log" | tail -1 |
        awk -F: '{ s = 0; for (i = 1; i <= NF; i++) s = s * 60 + $i; printf "%.1f", s }')
      [[ -n $sec ]] && msj=$(awk -v s="$sec" -v j="$jours" 'BEGIN { printf "%.0f", 1000 * s / j }')
      rss=$(sed -n 's/.*Maximum resident set size (kbytes): //p' "$log" | tail -1 | awk '{ printf "%.0f", $1 / 1024 }')
      res=$(grep -m1 '^Graine ' "$log" | tr ';' ',' || true)
    fi
    echo "$nom;$statut;$sec;$msj;$rss;$res"
  done
} > "$dossier/resume.csv"
ok=$(grep -c ';ok;' "$dossier/resume.csv" || true)
# temps volé : colonne « st » repérée par son nom (vmstat récent a une colonne « gu » après elle)
st=$(awk '$1 == "r" { for (i = 1; i <= NF; i++) c[$i] = i; k = 0; next } # en-tête (un par lancement)
  c["st"] && $1 ~ /^[0-9]+$/ && ++k > 1 { s += $c["st"]; if ($c["st"] > m) m = $c["st"]; j++ }
  END { if (j) printf "moyen %.1f %%, maximum %d %%", s / j, m; else printf "non mesuré" }' "$dossier/vmstat.log")
echo "[$(date +%T)] lot joué en $((duree / 3600)) h $((duree % 3600 / 60)) min : $ok / $n parties réussies ;" \
  "temps volé (st) $st. Résumé : $dossier/resume.csv"
journal lot-fin "$dossier : $ok / $n réussies en $((duree / 3600)) h $((duree % 3600 / 60)) min, st $st"
if [[ $ok == "$n" ]]; then
  touch "$dossier/lot.fini"
else
  echo "Des parties ont échoué ou manquent : relancer la même commande les rejoue (les autres sont sautées)."
fi

if [[ $eteindre == 1 ]]; then
  echo "[$(date +%T)] arrêt de la machine dans 5 minutes (annuler : sudo shutdown -c)."
  sudo -n shutdown -h +5 "Lot $dossier joué"
fi
