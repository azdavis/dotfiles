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
    dst_d="$HOME/.config"
    dst_d_git="$dst_d/.git"
    new_shell="$(which zsh)"

    note "installing '$repo' to '$dst_d'"
    if [ ! -e "$dst_d_git" ] \
    || ! git -C "$dst_d" rev-parse >/dev/null 2>&1 \
    || [ "$(git -C "$dst_d" config remote.origin.url)" != "$repo" ]; then
        ok=true
        tmp_d="$(mktemp -d)"
        trap "rm -rf '$tmp_d'" EXIT
        git clone "$repo" "$tmp_d"
        if [ -e "$dst_d" ]; then
            ok=false
        fi
        if $ok; then
            mkdir -p "$dst_d"
            rm -rf "$dst_d_git"
            mv "$tmp_d/.git" "$dst_d_git"
            git -C "$dst_d" reset -q --hard
            note "doing dotfile actions"
            "$dst_d/bin/do-dotfiles" < /dev/tty
        fi
    fi

    note "changing \$SHELL to '$new_shell'"
    if [ "$SHELL" != "$new_shell" ]; then
        chsh -s "$new_shell" < /dev/tty
    fi
}

main
