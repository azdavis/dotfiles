note() {
    echo "==> $1"
}

need_cmd() {
    which "$1" >/dev/null 2>&1 && return
    note "fatal: command not found: $1"
    exit 1
}

main() {
    set -o errexit
    set -o nounset

    note "checking for commands"
    need_cmd "chsh"
    need_cmd "git"
    need_cmd "zsh"

    repo="https://github.com/azdavis/dotfiles"
    dst="$HOME/.config"
    dst_git="$dst/.git"
    new_shell="$(which zsh)"

    note "dsting '$repo' to '$dst'"
    if ! [ -e "$dst_git" ]; then
        tmp_dir="$(mktemp -d)"
        git clone "$repo" "$tmp_dir"
        mkdir -p "$dst"
        rm -rf "$dst_git"
        mv "$tmp_dir/.git" "$dst_git"
        rm -rf "$tmp_dir"
        git -C "$dst" reset -q --hard
        note "doing dotfile actions"
        "$dst/bin/do-dotfiles" < /dev/tty
    fi

    note "changing \$SHELL to '$new_shell'"
    if [ "$SHELL" != "$new_shell" ]; then
        chsh -s "$new_shell" < /dev/tty
    fi

    note "finishing up"
}

main
