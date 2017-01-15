note() {
    echo "==> $1"
}

main() {
    set -o errexit
    set -o nounset

    have_all_cmds=true
    for x in cat chsh comm git ls mkdir mktemp mv rm sort wc zsh; do
        if ! which "$x" >/dev/null 2>&1; then
            note "fatal: command not found: $x"
            have_all_cmds=false
        fi
    done
    if ! $have_all_cmds; then
        exit 1
    fi

    repo="https://github.com/azdavis/dotfiles"
    dst_d="$HOME/.config"
    dst_d_git="$dst_d/.git"
    note "installing '$repo' to '$dst_d'"
    if [ ! -e "$dst_d_git" ] \
    || ! git -C "$dst_d" rev-parse >/dev/null 2>&1 \
    || [ "$(git -C "$dst_d" config remote.origin.url)" != "$repo" ]; then
        should_install=true
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
                should_install=false
                note "the following files in '$dst_d' would be overwritten:"
                cat "$tmp_f3"
                note "continue [yn]?"
                printf ">>> "
                read x < /dev/tty
                if [ "$x" = y ]; then
                    should_install=true
                fi
            fi
        fi
        if $should_install; then
            mkdir -p "$dst_d"
            rm -rf "$dst_d_git"
            mv "$tmp_d/.git" "$dst_d_git"
            git -C "$dst_d" reset -q --hard
            note "doing dotfile actions"
            "$dst_d/bin/do-dotfiles" < /dev/tty
        fi
    fi

    new_shell="$(which zsh)"
    note "changing \$SHELL to '$new_shell'"
    if [ "$SHELL" != "$new_shell" ]; then
        chsh -s "$new_shell" < /dev/tty
    fi
}

main
