#!/usr/bin/env bash
# Référence du moteur : la batterie de parité (tool/parite_plateformes.sh : empreintes quotidiennes de 9 000 jours à
# 240 habitants, 21 instantanés complets, protocole niveau 0, 10 000 habitants), jouée par les exécutables de
# build/outils/, comparée à rapports/reference/reference.txt. Durée : 3 minutes environ.
#
#   bash tool/reference.sh --verifier [--depuis dossier]   compare ; sort 0 si IDENTIQUE (à lancer après chaque changement
#                                                          qui ne doit rien changer au moteur, sur le PC et le serveur)
#   bash tool/reference.sh --ecrire [--depuis dossier]     (ré)écrit la référence : seulement après un changement de
#                                                          comportement voulu, décidé par Francis, avec le commit qui dit
#                                                          pourquoi
#
# --depuis dossier : un dossier déjà produit par tool/parite_plateformes.sh, sans rejouer la batterie.
# Prérequis : bash tool/compiler.sh (build/outils/ à jour avec le code à vérifier).
set -euo pipefail
cd "$(dirname "$0")/.."
mode=
depuis=
while [[ $# -gt 0 ]]; do
  case $1 in
    --verifier | --ecrire) mode=${1#--}; shift ;;
    --depuis) depuis=$2; shift 2 ;;
    -h | --help) sed -n '2,/^set -euo/p' "$0" | sed '$d; s/^# \{0,1\}//'; exit 0 ;;
    *) echo "Option inconnue : $1 (voir --help)" >&2; exit 2 ;;
  esac
done
[[ -n $mode ]] || { echo "Usage : bash tool/reference.sh --verifier|--ecrire [--depuis dossier]" >&2; exit 2; }
ref=rapports/reference/reference.txt
if [[ -z $depuis ]]; then
  depuis=build/reference
  rm -rf "$depuis"
  bash tool/parite_plateformes.sh . "$depuis" > /dev/null
fi
exe=build/outils/reference.exe
[[ -x $exe ]] || { echo "build/outils/reference.exe manque : bash tool/compiler.sh" >&2; exit 2; }
if [[ $mode == ecrire ]]; then
  "$exe" ecrire "$depuis" "$ref"
else
  "$exe" verifier "$depuis" "$ref"
fi
