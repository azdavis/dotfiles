set -o errexit
set -o nounset
set -o pipefail
set -o posix
IFS=$'\n\t'

abort() {
    printf "\e[31merror:\e[0m $1\n" 1>&2
    exit 1
}
