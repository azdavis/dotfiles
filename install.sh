check_no_root() {
    echo "checking user is not root"
    if [ "$USER" != root ]; then
        return
    fi
    echo "do not run as root"
    exit 1
}

check_os() {
    echo "checking OS"
    if [ "$(uname)" = Darwin ]; then
        return
    fi
    echo "'macOS' not installed"
    exit 1
}

check_for_deps() {
    echo "checking for deps"
    ok=true
    for x in \
        basename brew cat chmod chsh curl date defaults find git grep ln \
        mkdir mktemp mv pgrep rm sed sh touch tr wc zsh \
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
    echo "installing '$url' to '$dst'"
    if [ -d "$dst" ] \
    && [ "$(git -C "$dst" config remote.origin.url)" = "$url" ]; then
        return
    fi
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
    echo "changing shell to '$new_shell'"
    if [ "$SHELL" = "$new_shell" ]; then
        return
    fi
    chsh -s "$new_shell" < /dev/tty
}

main() {
    set -o errexit
    set -o nounset
    check_no_root
    check_os
    check_for_deps
    install_repo
    change_shell
    echo "finishing"
}

main
