note() {
    echo "==> $1"
}

main() {
    set -o errexit
    set -o nounset

    ok=true
    for x in [ cat chsh comm git ls mkdir mv rm sort wc zsh; do
        if ! which "$x" >/dev/null 2>&1; then
            note "fatal: command not found: $x"
            ok=false
        fi
    done
    if ! $ok; then
        exit 1
    fi

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
        tmp_f1="$(mktemp)"
        tmp_f2="$(mktemp)"
        tmp_f3="$(mktemp)"
        trap "rm -rf '$tmp_d' '$tmp_f1' '$tmp_f2' '$tmp_f3'" EXIT
        git clone "$repo" "$tmp_d"
        if [ -e "$dst_d" ]; then
            ls -a1 "$dst_d" | sort > "$tmp_f1"
            ( echo .git; git -C "$tmp_d" ls-tree --name-only @ ) | sort > "$tmp_f2"
            comm -12 "$tmp_f1" "$tmp_f2" > "$tmp_f3"
            if [ "$(cat "$tmp_f3" | wc -l)" -gt 0 ]; then
                ok=false
                note "the following files would be overwritten:"
                cat "$tmp_f3"
                note "continue [yn]?"
                printf ">>> "
                read x < /dev/tty
                if [ "$x" = y ]; then
                    ok=true
                fi
            fi
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
