panic() {
  echo "$1" >&2
  exit 1
}

find_deps() {
  echo "finding dependencies"
  if [ "$(uname)" = Darwin ] && ! xcode-select -p >/dev/null; then
    panic "'Command Line Developer Tools' not found"
  fi
  for x in /bin/sh chsh git; do
    if ! command -v "$x" >/dev/null; then
      panic "'$x' not found"
    fi
  done
}

install_repo() {
  echo "preparing '$dst'"
  if ! [ -d "$dst" ]; then
    rm -f "$dst"
    mkdir "$dst"
  fi
  cd "$dst"
  chmod 700 .
  echo "installing '$url'"
  if [ "$(git config remote.origin.url)" = "$url" ]; then
    return
  fi
  rm -rf .git
  git init -q
  git config remote.origin.url "$url"
  git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
  git fetch -q origin refs/heads/master:refs/remotes/origin/master
  git reset -q --hard origin/master
}

do_home() {
  echo "doing home actions"
  "$dst/bin/do-home" </dev/tty
}

change_shell() {
  echo "changing shell to zsh"
  new_shell="$(grep '/zsh$' /etc/shells | head -n 1)"
  if [ -z "$new_shell" ]; then
    echo "error: zsh is not an allowed shell"
    return
  fi
  if [ "$SHELL" != "$new_shell" ]; then
    chsh -s "$new_shell" </dev/tty
  fi
}

main() {
  set -eu
  url="https://github.com/azdavis/dotfiles.git"
  dst="$HOME/.config"
  find_deps
  install_repo
  do_home
  change_shell
  echo "finishing"
}

main
