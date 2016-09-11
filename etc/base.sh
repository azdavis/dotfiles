set -euo pipefail
IFS=$'\n\t'

abort() {
    echo $'\e[31merror:\e[0m' "$1" 1>&2
    exit 1
}
