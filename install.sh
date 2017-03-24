check_user() {
    echo "checking user is not root"
    if [ "$USER" != root ]; then
        return
    fi
    echo "user is root"
    exit 1
}

check_os() {
    echo "checking OS is macOS"
    if [ "$(uname)" = Darwin ]; then
        return
    fi
    echo "OS is not macOS"
    exit 1
}

check_deps() {
    echo "checking deps are installed"
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
}

do_home() {
    echo "doing home actions"
    "$dst/bin/do-home"
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
    set -eu
    url="https://github.com/azdavis/dotfiles.git"
    dst="$HOME/.config"
    check_user
    check_os
    check_deps
    install_repo
    do_home
    change_shell
    echo "finishing"
}

main
