set -eu

panic() {
  echo "$1" >&2
  exit 1
}

run() {
  url="https://github.com/azdavis/dotfiles.git"
  dst="$HOME/.config"
  if [ "$(uname)" = Darwin ] && ! xcode-select -p >/dev/null; then
    panic "'Command Line Developer Tools' not found"
  fi
  for x in /bin/sh /bin/zsh chsh git; do
    if ! command -v "$x" >/dev/null; then
      panic "'$x' not found"
    fi
  done
  if ! [ -d "$dst" ]; then
    rm -f "$dst"
    mkdir "$dst"
  fi
  cd "$dst"
  chmod 700 .
  if [ "$(git config remote.origin.url)" != "$url" ]; then
    rm -rf .git
    git init -q
    git config remote.origin.url "$url"
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    git fetch -q origin refs/heads/master:refs/remotes/origin/master
    git reset -q --hard refs/remotes/origin/master
  fi
  "$dst/bin/do-home" </dev/tty
  if [ "$SHELL" != /bin/zsh ]; then
    chsh -s /bin/zsh </dev/tty
  fi
  echo "done."
}

run
