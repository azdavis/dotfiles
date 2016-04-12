set -euo pipefail
IFS=$'\n\t'
err() { echo "error: $1" && exit 1 }
if [[ "$USER" == 'root' ]]; then err 'do not run as root'; fi
