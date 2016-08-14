# config

a potpourri of os x config files

## install

    curl -fsSL "https://git.io/voEgC" | sh

- this will clone the repository to `~/.config`
- if `~/.config` already exists, a backup will be made
- to avoid the [security risk][sec] of [executing code over the network][exc],
  download and run the [install script][ins] in two separate steps

[sec]: https://www.idontplaydarts.com/2016/04/detecting-curl-pipe-bash-server-side
[exc]: https://curlpipesh.tumblr.com
[ins]: libexec/install
