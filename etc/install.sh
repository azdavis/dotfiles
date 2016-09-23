main() {

set -o errexit
set -o nounset
set -o pipefail
set -o posix
IFS=$'\n\t'

confirm() {
    local x
    printf "\e[33mconfirm:\e[0m $1? " 1>&2
    read x < /dev/tty
    return $([ "$x" = y ])
}

cd
if [ -e .config ]; then
    if confirm "remove $HOME/.config"; then
        rm -rf .config
    else
        exit 0
    fi
fi
git clone -q https://github.com/azdavis/config .config
chmod 700 .config
.config/bin/do-dotfiles

}; main