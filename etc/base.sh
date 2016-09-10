set -euo pipefail
IFS=$'\n\t'

abort() {
    echo 1>&2 $'\e[31merror:\e[0m' "$1"
    exit 1
}

[ "$USER" = "root" ] && abort "do not run as root"

remove() {
    rm -rf "$1"
}

symlink() {
    remove "$2"
    ln -sn "$1" "$2"
}

get() {
    printf "$1: "
    read "$1"
}
