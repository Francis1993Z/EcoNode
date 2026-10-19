#!/usr/bin/env bash
# Batterie « un module à la fois » : quel module (ou quelle combinaison) fait s'effondrer la petite économie ?
# Deux plans, mêmes graines et même durée que le protocole niveau 1 (sans les chocs) :
#   ajout   : les modules par défaut + UN module ajouté      (comparé au défaut, graine par graine)
#   retrait : tous les modules − UN module                     (comparé à « tous », graine par graine)
# Les synthèses de référence (défaut et tous modules) sont rejouées ici, sans chocs, pour que tout vienne du même lancement.
#
#   bash tool/batterie_modules.sh [dossier de sortie] [population] [graines] [jours]
#   (défauts : build/batterie-modules, 240 habitants, 30 graines, 1 500 jours)
#
# Exécutables : build/outils/stabilite.exe (bash tool/compiler.sh). Fonctionne sur le PC (Git Bash) et sur le serveur.
set -euo pipefail
cd "$(dirname "$0")/.."
out=${1:-build/batterie-modules}
pop=${2:-240}
seeds=${3:-30}
days=${4:-1500}
exe=build/outils/stabilite.exe
[[ -x $exe ]] || { echo "Compiler d'abord : bash tool/compiler.sh" >&2; exit 2; }
mkdir -p "$out"
mods=(buildings jobs entrepreneurship products banking)
tous=$(IFS=,; echo "${mods[*]/%/=1}")
common=(--population "$pop" --graines "$seeds" --days "$days" --phases base,nets)
log() { echo "$(date -u +%FT%TZ) $*" | tee -a "$out/batterie.log"; }

run() { # nom, options de modules (vide : défaut)
  local nom=$1 m=${2:-}
  if [[ -f $out/$nom.json ]]; then log "$nom : déjà fait"; return; fi
  log "$nom : ${m:-modules par défaut}"
  $exe "${common[@]}" ${m:+--modules "$m"} --save "$out/$nom.json" --out "$out/$nom.md" > "$out/$nom.log" 2>&1
  log "$nom : fini"
}

run defaut ""
run tous "$tous"
for m in "${mods[@]}"; do
  run "ajout-$m" "$m=1"
  reste=$(for x in "${mods[@]}"; do [[ $x == "$m" ]] && echo "$x=0" || echo "$x=1"; done | paste -sd,)
  run "retrait-$m" "$reste"
done
for m in "${mods[@]}"; do
  $exe --compare "$out/defaut.json" "$out/ajout-$m.json" --out "$out/cmp-ajout-$m.md" > /dev/null 2>&1
  $exe --compare "$out/tous.json" "$out/retrait-$m.json" --out "$out/cmp-retrait-$m.md" > /dev/null 2>&1
done
log "comparaisons écrites ; batterie finie"
touch "$out/batterie.fini"
