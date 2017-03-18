check_for_user() {
    if [ "$USER" = root ]; then
        echo "do not run as root"
        exit 1
    fi
}

check_for_deps() {
    ok=true
    for x in \
        basename brew cat chmod chsh curl date defaults find git grep ln \
        mkdir mktemp mv rm sed sh touch tr wc zsh \
    ; do
        if ! which "$x" > /dev/null 2>&1; then
            echo "'$x' not installed"
            ok=false
        fi
    done
    if ! xcode-select -p > /dev/null 2>&1; then
        echo "'Command Line Developer Tools' not installed"
        ok=false
    fi
    if ! $ok; then
        exit 1
    fi
}

install_repo() {
    url="https://github.com/azdavis/dotfiles.git"
    dst="$HOME/.config"
    if [ -d "$dst" ] \
    && [ "$(git -C "$dst" config remote.origin.url)" = "$url" ]; then
        return
    fi
    echo "installing '$url' to '$dst'"
    tmp="$(mktemp -d)"
    trap "rm -rf '$tmp'" EXIT
    git clone -q -n --single-branch "$url" "$tmp"
    if ! [ -d "$dst" ]; then
        rm -rf "$dst"
    fi
    mkdir -p "$dst"
    chmod 700 "$dst"
    rm -rf "$dst/.git"
    mv "$tmp/.git" "$dst/.git"
    git -C "$dst" reset -q --hard
    echo "doing home actions"
    "$dst/bin/do-home" < /dev/tty
}

change_shell() {
    new_shell="$(which zsh)"
    if [ "$SHELL" != "$new_shell" ]; then
        echo "changing \$SHELL to '$new_shell'"
        chsh -s "$new_shell" < /dev/tty
    fi
}

main() {
    set -o errexit
    set -o nounset
    check_for_user
    check_for_deps
    install_repo
    change_shell
}

main
