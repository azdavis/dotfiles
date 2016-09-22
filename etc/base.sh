set -o errexit
set -o nounset
set -o pipefail
set -o posix
IFS=$'\n\t'

abort() {
    printf "\e[31merror:\e[0m $1\n" 1>&2
    exit 1
}

confirm() {
    local x
    printf "\e[33mconfirm:\e[0m $1? " 1>&2
    read x
    return $([ "$x" = y ])
}
