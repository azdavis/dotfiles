set -euo pipefail
IFS=$'\n\t'
err() { echo "\e[31merror:\e[0m $1" && exit 1 }
[[ "$USER" == 'root' ]] && err 'do not run as root' || true
