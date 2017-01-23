symlink() {
    [ -L "$2" ] && rm "$2"
    if [ -e "$2" ]; then
        printf "rm '%s' [yn]? " "$2"
        read x
        [ "$x" != y ] && return
        rm -rf "$2"
    fi
    mkdir -p "$(dirname "$2")"
    ln -s "$1" "$2"
}
