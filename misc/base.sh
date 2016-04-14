set -euo pipefail
IFS=$'\n\t'
err() { echo "\e[31merror:\e[0m $1" && exit 1 }
if [[ "$USER" == 'root' ]]; then err 'do not run as root'; fi
