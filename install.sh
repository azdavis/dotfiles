confirm() {
    printf "continue [yn]? "
    read x < /dev/tty
    if [ "$x" != y ]; then
        exit 1
    fi
}

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
    if [ -e "$dst_d_git" ] \
    && [ "$(git -C "$dst_d" config remote.origin.url)" = "$url" ]; then
        return
    fi
    echo "installing '$url' to '$dst_d'"
    tmp_d="$(mktemp -d)"
    tmp_f1="$(mktemp)"
    tmp_f2="$(mktemp)"
    tmp_f3="$(mktemp)"
    trap "rm -rf '$tmp_d' '$tmp_f1' '$tmp_f2' '$tmp_f3'" EXIT
    git clone -q -n --single-branch "$url" "$tmp_d"
    if [ -d "$dst_d" ]; then
        ls -a1 "$dst_d" | sort > "$tmp_f1"
        ( echo .git; \
          echo update-dotfiles.last; \
          echo update-dotfiles.lock; \
          git -C "$tmp_d" ls-tree --name-only @ \
        ) | sort > "$tmp_f2"
        comm -12 "$tmp_f1" "$tmp_f2" > "$tmp_f3"
        if grep -q . "$tmp_f3"; then
            echo "the following items in '$dst_d' would be replaced:"
            cat "$tmp_f3"
            confirm
        fi
    elif [ -e "$dst_d" ] || [ -L "$dst_d" ]; then
        echo "'$dst_d' would be replaced"
        confirm
        rm -rf "$dst_d"
    fi
    mkdir -p "$dst_d"
    chmod 700 "$dst_d"
    rm -rf "$dst_d_git"
    mv "$tmp_d/.git" "$dst_d_git"
    git -C "$dst_d" reset -q --hard
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
