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

    need_cmd "chsh"
    need_cmd "git"
    need_cmd "zsh"

    repo="https://github.com/azdavis/dotfiles"
    dst="$HOME/.config"
    dst_git="$dst/.git"
    new_shell="$(which zsh)"

    note "installing '$repo' to '$dst'"
    if [ ! -e "$dst_git" ] \
    || ! git -C "$dst" rev-parse >/dev/null 2>&1 \
    || [ "$(git -C "$dst" config remote.origin.url)" != "$repo" ]; then
        tmp="$(mktemp -d)"
        git clone "$repo" "$tmp"
        mkdir -p "$dst"
        rm -rf "$dst_git"
        mv "$tmp/.git" "$dst_git"
        rm -rf "$tmp"
        git -C "$dst" reset -q --hard
        note "doing dotfile actions"
        "$dst/bin/do-dotfiles" < /dev/tty
    fi

    note "changing \$SHELL to '$new_shell'"
    if [ "$SHELL" != "$new_shell" ]; then
        chsh -s "$new_shell" < /dev/tty
    fi
}

main
