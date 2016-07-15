set -euo pipefail
IFS=$'\n\t'

abort() {
    echo "\e[31merror:\e[0m $1" && exit 1
}

[[ "$USER" == "root" ]] && abort "do not run as root"

rm_file() {
    if [[ ! -e "$1" ]]; then
        [[ -h "$1" ]] && rm "$1"
        return 0
    fi
    echo -n "rm $1 [yn]? " && read x
    [[ "$x" == "y" ]] && rm -rf "$1"
}

sym() {
    rm_file "$2"
    ln -sn "$1" "$2"
}

true
