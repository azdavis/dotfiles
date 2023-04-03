#!/bin/sh

set -eux

run() {
  cd
  git clone -n https://github.com/azdavis/dotfiles.git
  mv dotfiles/.git .
  rmdir dotfiles
  git reset
  git checkout .
  git ls-files -z | xargs -0 chmod go-rwx
}

run
