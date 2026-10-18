#!/usr/bin/env bash
# Envoie la révision courante (HEAD) au serveur de calcul et l'y compile (à lancer sur le PC, Git Bash).
#
#   bash tool/envoyer_serveur.sh [--force] [hôte]     (défaut : ubuntu@econodes-calc)
#
#   --force   réinstalle la révision même si elle est déjà sur le serveur
#
# Un dossier par révision : ~/econodes/<12 premiers caractères de la révision>/, avec son code, ses exécutables
# (build/outils/*.exe), .revision (empreinte complète), .branche et .envoi (date). Un envoi ne touche jamais aux autres
# révisions : plusieurs branches peuvent avoir leur code sur le serveur en même temps, et chaque lot joue la révision
# du dossier d'où on le lance. Une révision déjà installée n'est ni renvoyée ni recompilée. Lister ou supprimer les
# révisions, voir ce qui tourne : tool/etat_serveur.sh. Chaque envoi est noté dans ~/resultats/JOURNAL.
#
# Aucun secret ne part : le code va par « git archive » (fichiers suivis seulement, sans .git), le serveur n'a ni clé
# GitHub ni clé AWS. Seul le dernier commit part : les modifications non commitées restent sur le PC.
#
# Deux pièges, réglés ici :
# - Fins de ligne. Sur ce PC, core.autocrlf=true : « git archive » écrirait les fichiers en CRLF, et bash refuse alors
#   tool/compiler.sh. L'archive est faite avec core.autocrlf=false, donc en LF, comme dans le dépôt. (Aucune chaîne
#   multiligne dans lib/engine ni tool/ : la fin de ligne ne change pas le programme.)
# - Flutter. pubspec.yaml dépend de Flutter, absent du serveur : la résolution des paquets y échoue. Le moteur et les
#   outils n'importent que dart: et package:econodes ; un package_config.json limité au paquet econodes, avec la même
#   languageVersion que sur le PC (3.4), suffit. Dart affiche quand même l'échec de résolution, puis compile.
set -euo pipefail
cd "$(dirname "$0")/.."
force=0
if [[ ${1:-} == --force ]]; then
  force=1
  shift
fi
hote=${1:-ubuntu@econodes-calc}
rev=$(git rev-parse HEAD)
court=${rev:0:12}
branche=$(git rev-parse --abbrev-ref HEAD)
[[ $branche =~ ^[A-Za-z0-9._/-]+$ ]] || branche=inconnue
if [[ -n $(git status --porcelain -- lib/engine tool) ]]; then
  echo "Attention : lib/engine ou tool/ ont des modifications non commitées ; elles ne partent pas (révision $court)." >&2
fi

# L'ancienne disposition (un seul dossier ~/econodes) est rangée dans le dossier de sa révision ; puis : cette
# révision est-elle déjà installée ?
deja=$(ssh "$hote" "set -e
  if [ -f ~/econodes/.revision ]; then
    a=\$(cut -c1-12 ~/econodes/.revision)
    mv ~/econodes ~/econodes.ancien && mkdir ~/econodes && mv ~/econodes.ancien ~/econodes/\$a
    echo inconnue > ~/econodes/\$a/.branche
    date -Is -r ~/econodes/\$a/.revision > ~/econodes/\$a/.envoi
    echo \"Ancienne disposition rangée dans ~/econodes/\$a.\" >&2
  fi
  if [ -x ~/econodes/$court/build/outils/partie.exe ] && [ \"\$(cat ~/econodes/$court/.revision 2> /dev/null)\" = $rev ]
  then echo oui; fi")
if [[ $deja == oui && $force == 0 ]]; then
  echo "Révision $court déjà installée sur le serveur : ~/econodes/$court (--force pour la réinstaller)."
  exit 0
fi

# Archive extraite et compilée dans un dossier provisoire, puis mise en place d'un coup : la révision n'est jamais à
# moitié installée, et une partie qui tourne sur l'ancienne copie (--force) garde ses exécutables.
git -c core.autocrlf=false archive HEAD | ssh "$hote" "set -eo pipefail
  t=\$HOME/.econodes-envoi-\$\$
  rm -rf \$t && mkdir -p \$t && tar -x -C \$t
  cd \$t && echo $rev > .revision && echo $branche > .branche && date -Is > .envoi && mkdir -p .dart_tool
  cat > .dart_tool/package_config.json <<'FIN'
{
  \"configVersion\": 2,
  \"packages\": [
    {
      \"name\": \"econodes\",
      \"rootUri\": \"../\",
      \"packageUri\": \"lib/\",
      \"languageVersion\": \"3.4\"
    }
  ],
  \"generator\": \"pub\",
  \"generatorVersion\": \"3.10.4\"
}
FIN
  export PATH=\$HOME/dart-sdk/bin:\$PATH
  dart --version
  bash tool/compiler.sh 2>&1 | grep -v -e 'Flutter SDK is not available' -e 'Flutter users should use' -e '^\$'
  cd && mkdir -p ~/econodes && rm -rf ~/econodes/$court && mv \$t ~/econodes/$court
  mkdir -p ~/resultats
  printf '%s\tenvoi\t%s\t%s\t%s\n' \"\$(date -Is)\" $court $branche '~/econodes/$court' >> ~/resultats/JOURNAL
  echo \"Révision $court ($branche) compilée dans ~/econodes/$court sur \$(hostname).\"
  echo \"Révisions installées : \$(ls ~/econodes | tr '\n' ' ')\""
