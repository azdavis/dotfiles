symlink() {
    [ -L "$2" ] && rm "$2"
    if [ -e "$2" ]; then
        printf 'rm %s? ' "$2"
        read x
        [ "$x" != y ] && return
        rm -rf "$2"
    fi
    mkdir -pv "$(dirname "$2")"
    ln -sv "$1" "$2"
}
