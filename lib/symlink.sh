symlink() {
    if [ -e "$2" ] && ! [ -L "$2" ]; then
        printf 'rm %s? ' "$2"
        read ans
        if [ "$ans" != y ]; then
            continue
        fi
    fi
    rm -rf "$2"
    mkdir -p "$(dirname "$2")"
    ln -s "$1" "$2"
}
