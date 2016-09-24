main() {

set -o errexit
set -o nounset
set -o pipefail
set -o posix
IFS=$'\n\t'

note() {
    printf "\e[32mnote:\e[0m $1\n" 1>&2
}

dst="$HOME/.config"
repo="azdavis/config"

note "installing $repo to $dst..."
[ -L "$dst" ] && rm "$dst"
[ -e "$dst" ] && rm -ri "$dst"
[ -e "$dst" ] && exit 0
git clone -q "https://github.com/$repo" "$dst"
chmod 700 "$dst"
"$dst/bin/do-dotfiles"
note "install complete"

}; main
