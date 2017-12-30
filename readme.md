# dotfiles

a potpourri of macOS dotfiles

## install

Note: A path on your system, if it exists, will be replaced with a path (or
symlink to a path) in `dotfiles`, if it exists, according to the following
table:

| # | On your system                                 | In `dotfiles`    |
|---|------------------------------------------------|------------------|
| 1 | `~/.config/.git`                               | N/A              |
| 2 | `~/.config/<path>`                             | `<path>`         |
| 3 | `~/.<path>`                                    | `home/<path>`    |
| 4 | `~/Library/Application Support/Sublime Text 3` | `sublime-text-3` |

When the following commands in `dotfiles` are run:

| Command               | 1 | 2 | 3 | 4 |
|-----------------------|---|---|---|---|
| `install.sh`          | Y | Y | Y | Y |
| `bin/update-dotfiles` | Y | Y | N | N |
| `bin/do-home`         | N | N | Y | N |
| `bin/do-subl`         | N | N | N | Y |

You can get the install script and execute it with:

	$ curl -fsSL https://git.io/vM2Jb | sh
