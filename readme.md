# dotfiles

a potpourri of macOS dotfiles

## install

A file on your system, if it exists, will be replaced with a file (or symlink
to a file) in `dotfiles`, if it exists, according to the following table:

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
| `bin/update-dotfiles` | Y | Y | Y | N |
| `bin/do-home`         | N | N | Y | N |
| `bin/do-subl`         | N | N | N | Y |

If you understand and accept the risks:

	curl -fsSL https://git.io/vM2Jb | sh
