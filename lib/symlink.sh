symlink() {
    if [ -L "$2" ]; then
        rm "$2"
    fi
    if [ -e "$2" ]; then
        printf "rm '%s' [yn]? " "$2"
        read x
        if [ "$x" != y ]; then
            return
        fi
        rm -rf "$2"
    fi
    mkdir -p "$(dirname "$2")"
    ln -s "$1" "$2"
}
