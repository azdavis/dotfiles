set -eu

panic() {
  echo "$1" >&2
  exit 1
}

run() {
  dst="$HOME/dotfiles"
  if [ -e "$dst" ]; then
    panic "$dst already exists"
  fi
  if [ "$(uname)" = Darwin ] && ! xcode-select -p >/dev/null; then
    panic "'Command Line Developer Tools' not found"
  fi
  for x in /bin/sh /bin/zsh chsh git; do
    if ! command -v "$x" >/dev/null; then
      panic "'$x' not found"
    fi
  done
  mkdir "$dst"
  chmod 700 "$dst"
  git clone https://github.com/azdavis/dotfiles.git "$dst"
  "$dst/bin/do-home" </dev/tty
  if [ "$SHELL" != /bin/zsh ]; then
    chsh -s /bin/zsh </dev/tty
  fi
  echo "done."
}

run
