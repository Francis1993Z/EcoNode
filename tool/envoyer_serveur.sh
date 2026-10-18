#!/usr/bin/env bash
# Envoie la révision courante (HEAD) au serveur de calcul et y compile les outils (à lancer sur le PC, Git Bash).
#
#   bash tool/envoyer_serveur.sh [hôte]          (défaut : ubuntu@econodes-calc)
#
# Aucun secret ne part : le code va par « git archive » (fichiers suivis seulement, sans .git), le serveur n'a ni clé
# GitHub ni clé AWS. Seul le dernier commit part : les modifications non commitées restent sur le PC.
#
# Sur le serveur : ~/econodes (remplacé à chaque envoi), ~/econodes/build/outils/*.exe et ~/econodes/.revision.
# Un lot déjà lancé n'est pas touché : tool/lot_serveur.sh joue une copie figée de partie.exe.
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
hote=${1:-ubuntu@econodes-calc}
rev=$(git rev-parse HEAD)
if [[ -n $(git status --porcelain -- lib/engine tool) ]]; then
  echo "Attention : lib/engine ou tool/ ont des modifications non commitées ; elles ne partent pas (révision ${rev:0:7})." >&2
fi
git -c core.autocrlf=false archive HEAD | ssh "$hote" "set -eo pipefail
  rm -rf ~/econodes.nouveau && mkdir -p ~/econodes.nouveau && tar -x -C ~/econodes.nouveau
  rm -rf ~/econodes && mv ~/econodes.nouveau ~/econodes
  cd ~/econodes && echo $rev > .revision && mkdir -p .dart_tool
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
  echo \"Révision ${rev:0:7} compilée sur \$(hostname).\""
