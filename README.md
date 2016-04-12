# config

### install

    curl -fsSL https://git.io/vVFE5 | zsh

- this will install everything to `~/.config`.
- if `~/.config` already exists, a backup will be made.
- to avoid [executing arbitrary code over the network][1], download and run the
  [install script][2] in two separate steps.

[1]: https://curlpipesh.tumblr.com
[2]: https://git.io/vVFE5

### update

    ~/.config/bin/update

- this will check for updates in `~/.config`.
- if updates exist, they will be applied with a git fast-forward merge.
- to avoid having to check for updates manually, automatic updates can be
  configured. peruse `home/zshrc` and `util/auto_update` for more information.
