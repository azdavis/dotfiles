panic() {
    echo "$1" >&2
    exit 1
}

cmd_found() {
    command -v "$1" >/dev/null
}

find_deps() {
    echo "finding dependencies"
    if cmd_found xcode-select && ! xcode-select -p >/dev/null; then
        panic "'Command Line Developer Tools' not found"
    fi
    for x in /bin/sh chsh git; do
        if ! cmd_found "$x"; then
            panic "'$x' not found"
        fi
    done
}

install_repo() {
    echo "preparing '$dst'"
    if ! [ -d "$dst" ]; then
        rm -f "$dst"
        mkdir "$dst"
    fi
    cd "$dst"
    chmod 700 .
    echo "installing '$url'"
    if [ "$(git config remote.origin.url)" = "$url" ]; then
        return
    fi
    rm -rf .git
    git init -q
    git remote add origin "$url"
    git fetch -q origin master:refs/remotes/origin/master
    git reset -q --hard origin/master
}

do_home() {
    echo "doing home actions"
    "$dst/bin/do-home"
}

do_subl() {
    echo "doing subl actions"
    "$dst/bin/do-subl"
}

change_shell() {
    echo "changing shell to zsh"
    new_shell="$(grep '/zsh$' /etc/shells | head -n 1)"
    if [ -z "$new_shell" ]; then
        echo "error: zsh is not an allowed shell"
        return
    fi
    if [ "$SHELL" != "$new_shell" ]; then
        chsh -s "$new_shell" </dev/tty
    fi
}

main() {
    set -eu
    url="https://github.com/azdavis/dotfiles.git"
    dst="$HOME/.config"
    find_deps
    install_repo
    do_home
    do_subl
    change_shell
    echo "finishing"
}

main
