main() {

set -o errexit
set -o nounset
set -o pipefail
set -o posix
IFS=$'\n\t'

dst="$HOME/.config"
repo="azdavis/config"
tty="/dev/tty"
zsh="$(which zsh)"

echo "installing '$repo' to '$dst'"
[ -L "$dst" ] && rm "$dst"
[ -e "$dst" ] && rm -ri "$dst" < "$tty"
[ -e "$dst" ] && exit 0
git clone -q "https://github.com/$repo" "$dst"
chmod 700 "$dst"

echo "doing dotfile actions"
"$dst/bin/do-dotfiles" < "$tty"

echo "changing shell to $zsh"
chsh -s "$zsh" < "$tty"

echo "all done"

}; main
