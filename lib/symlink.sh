symlink() {
    [ -L "$2" ] && rm "$2"
    [ -e "$2" ] && rm -ri "$2"
    [ -e "$2" ] && return
    mkdir -p "$(dirname "$2")"
    ln -s "$1" "$2"
}
