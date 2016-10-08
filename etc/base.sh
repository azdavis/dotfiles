set -o errexit
set -o nounset
set -o pipefail
set -o posix

abort() {
    echo "$1"
    exit 1
}

symlink() {
    [ -L "$2" ] && rm "$2"
    [ -e "$2" ] && rm -ri "$2"
    [ -e "$2" ] && return
    mkdir -p "$(dirname "$2")"
    ln -s "$1" "$2"
}
