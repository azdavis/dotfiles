check_for_user() {
    if [ "$USER" = root ]; then
        echo "do not run as root"
        exit 1
    fi
}

check_for_deps() {
    ok=true
    for x in cat chsh comm git grep ls mkdir mktemp mv rm sh sort zsh; do
        if ! which "$x" > /dev/null 2>&1; then
            echo "'$x' not installed"
            ok=false
        fi
    done
    if [ "$(uname)" = Darwin ] && ! xcode-select -p > /dev/null 2>&1; then
        echo "'Command Line Developer Tools' not installed"
        ok=false
    fi
    if ! $ok; then
        exit 1
    fi
}

install_repo() {
    url="https://github.com/azdavis/dotfiles.git"
    dst_d="$HOME/.config"
    dst_d_git="$dst_d/.git"
    if [ -d "$dst_d" ] \
    && [ "$(git -C "$dst_d" config remote.origin.url)" = "$url" ]; then
        return
    fi
    echo "installing '$url' to '$dst_d'"
    tmp_d="$(mktemp -d)"
    trap "rm -rf '$tmp_d'" EXIT
    git clone -q -n --single-branch "$url" "$tmp_d"
    if ! [ -d "$dst_d" ]; then
        rm -rf "$dst_d"
    fi
    mkdir -p "$dst_d"
    chmod 700 "$dst_d"
    rm -rf "$dst_d_git"
    mv "$tmp_d/.git" "$dst_d_git"
    git -C "$dst_d" checkout .
    echo "doing home actions"
    "$dst_d/bin/do-home" < /dev/tty
}

change_shell() {
    new_shell="$(which zsh)"
    if [ "$SHELL" = "$new_shell" ]; then
        return
    fi
    echo "changing \$SHELL to '$new_shell'"
    chsh -s "$new_shell" < /dev/tty
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
