#!/usr/bin/env sh

note() {
    echo "==> $1"
}

need_cmd() {
    which "$1" &> /dev/null && return
    note "fatal: command not found: $1"
    exit 1
}

main() {
    set -o errexit
    set -o nounset

    note "checking for commands"
    need_cmd "chsh"
    need_cmd "dirname"
    need_cmd "git"
    need_cmd "mv"
    need_cmd "zsh"

    repo="https://github.com/azdavis/dotfiles"
    install_dir="$HOME/.config"
    install_dir_git="$install_dir/.git"
    new_shell="$(which zsh)"

    note "installing '$repo' to '$install_dir'"
    if ! [ -e "$install_dir_git" ]; then
        mkdir -p "$install_dir_git"
        git clone --bare "$repo" "$install_dir_git"
        git -C "$install_dir_git" config core.bare false
        git -C "$install_dir" reset --hard
        note "doing dotfile actions"
        "$install_dir/bin/do-dotfiles" < /dev/tty
    fi

    note "changing \$SHELL to '$new_shell'"
    if [ "$SHELL" != "$new_shell" ]; then
        chsh -s "$new_shell" < /dev/tty
    fi

    note "finishing up"
}

main
