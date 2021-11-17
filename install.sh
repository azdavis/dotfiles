#!/bin/sh

set -eu

symlink() {
  if [ -e "$2" ]; then
    echo "skipping $2"
    return
  fi
  rm -rf "$2"
  mkdir -p "$(dirname "$2")"
  ln -s "$HOME/.dotfiles/$1" "$2"
}

touch "$HOME/.hushlogin"
chmod 600 "$HOME/.hushlogin"

symlink etc/tarsnaprc "$HOME/.tarsnaprc"
symlink etc/zshrc.sh "$HOME/.zshrc"

symlink git/config.conf "$HOME/.config/git/config"
symlink git/ignore "$HOME/.config/git/ignore"

symlink mpv/input.conf "$HOME/.config/mpv/input.conf"
symlink mpv/mpv.conf "$HOME/.config/mpv/mpv.conf"

symlink vscode "$HOME/Library/Application Support/Code/User"
