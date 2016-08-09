set -euo pipefail
IFS=$'\n\t'

abort() {
    echo 1>&2 $'\e[31merror:\e[0m' "$1"
    exit 1
}

[[ "$USER" == "root" ]] && abort "do not run as root"

remove() {
    if [[ ! -e "$1" ]]; then
        [[ -h "$1" ]] && rm "$1"
        return 0
    fi
    printf "remove $1 [yn]? "
    read x
    [[ "$x" == "y" ]] && rm -rf "$1"
}

symlink() {
    echo "symlink $1 -> $2"
    remove "$2"
    ln -sn "$1" "$2"
}

get() {
    printf "$1: "
    read "$1"
}
