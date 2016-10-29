main() {

set -o errexit
set -o nounset

abort() {
    echo "$1"
    exit 1
}

repo="azdavis/dotfiles"
dst="$HOME/.config"
zsh="$(which zsh)"

echo "installing '$repo' to '$dst'"
[ -L "$dst" ] && rm "$dst"
[ -e "$dst" ] && rm -ri "$dst" < /dev/tty
[ -e "$dst" ] && abort "cancelling install"
git clone -q "https://github.com/$repo" "$dst"
chmod 700 "$dst"

echo "doing dotfile actions"
"$dst/bin/do-dotfiles" < /dev/tty

if [ "$SHELL" != "$zsh" ]; then
    echo "changing shell to $zsh"
    chsh -s "$zsh" < /dev/tty
fi

echo "relog for all changes to take effect"

}; main
