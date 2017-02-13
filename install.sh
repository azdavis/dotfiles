note() {
    echo "==> $1"
}

check_for_commands() {
    have_all=true
    for x in cat chsh comm git ls mkdir mktemp mv rm sort wc zsh; do
        if ! which "$x" > /dev/null 2>&1; then
            note "command not found: $x"
            have_all=false
        fi
    done
    if ! $have_all; then
        exit 1
    fi
}

install_repo() {
    repo="https://github.com/azdavis/dotfiles"
    dst_d="$HOME/.config"
    dst_d_git="$dst_d/.git"

    if [ -e "$dst_d_git" ] \
    && git -C "$dst_d" rev-parse > /dev/null 2>&1 \
    && remote="$(git -C "$dst_d" config remote.origin.url)" \
    && ( [ "$remote" == "$repo" ] || [ "$remote" == "$repo.git" ] ); then
        return
    fi

    note "installing '$repo' to '$dst_d'"

    tmp_d="$(mktemp -d)"
    tmp_f1="$(mktemp)"
    tmp_f2="$(mktemp)"
    tmp_f3="$(mktemp)"
    trap "rm -rf '$tmp_d' '$tmp_f1' '$tmp_f2' '$tmp_f3'" EXIT

    git clone "$repo" "$tmp_d"

    if [ -e "$dst_d" ]; then
        ls -a1 "$dst_d" | sort > "$tmp_f1"
        ( echo .git; \
          echo update-dotfiles.last; \
          echo update-dotfiles.lock; \
          git -C "$tmp_d" ls-tree --name-only @ \
        ) | sort > "$tmp_f2"
        comm -12 "$tmp_f1" "$tmp_f2" > "$tmp_f3"
        if [ "$(cat "$tmp_f3" | wc -l)" -ne 0 ]; then
            note "the following items in '$dst_d' would be replaced:"
            cat "$tmp_f3"
            note "continue [yn]?"
            printf ">>> "
            read x < /dev/tty
            if [ "$x" != y ]; then
                exit 1
            fi
        fi
    fi

    mkdir -p "$dst_d"
    rm -rf "$dst_d_git"
    mv "$tmp_d/.git" "$dst_d_git"
    git -C "$dst_d" reset -q --hard

    note "doing home actions"
    "$dst_d/bin/do-home" < /dev/tty
}

change_shell() {
    new_shell="$(which zsh)"
    if [ "$SHELL" == "$new_shell" ]; then
        return
    fi

    note "changing \$SHELL to '$new_shell'"
    chsh -s "$new_shell" < /dev/tty
}

main() {
    set -o errexit
    set -o nounset
    check_for_commands
    install_repo
    change_shell
}

main
