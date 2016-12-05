symlink() {
    [ -L "$2" ] && rm "$2"
    [ -e "$2" ] && rm -ri "$2"
    [ -e "$2" ] && return
    mkdir -pv "$(dirname "$2")"
    ln -sv "$1" "$2"
}
