main() {

set -o errexit
set -o nounset
set -o pipefail
set -o posix
IFS=$'\n\t'

ok() {
    printf "\e[31mok:\e[0m $1\n" 1>&2
}

confirm() {
    local x
    printf "\e[33mconfirm:\e[0m $1? " 1>&2
    read x < /dev/tty
    return $([ "$x" = y ])
}

dst="$HOME/.config"
repo="azdavis/config"

ok "installing $repo to $dst..."
if [ -e "$dst" ]; then
    if confirm "remove $dst"; then
        rm -rf "$dst"
    else
        exit 0
    fi
fi
git clone -q "https://github.com/$repo" "$dst"
chmod 700 "$dst"
"$dst/bin/do-dotfiles"
ok "install complete"

}; main
