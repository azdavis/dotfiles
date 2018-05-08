# dotfiles

A potpourri of macOS dotfiles

## install

Note: a path on your system, if it exists, will be replaced with a path (or
symlink to a path) in `dotfiles`, if it exists, according to the following
table:

| # | on your system                                 | in `dotfiles`    |
|---|------------------------------------------------|------------------|
| 1 | `~/.config/.git`                               | N/A              |
| 2 | `~/.config/<path>`                             | `<path>`         |
| 3 | `~/.<path>`                                    | `home/<path>`    |
| 4 | `~/Library/Application Support/Sublime Text 3` | `sublime-text-3` |

When the following commands in `dotfiles` are run:

| command               | 1 | 2 | 3 | 4 |
|-----------------------|---|---|---|---|
| `install.sh`          | y | y | y | y |
| `bin/update-dotfiles` | y | y | n | n |
| `bin/do-home`         | n | n | y | n |
| `bin/do-subl`         | n | n | n | y |

If you're OK with both this and the possible [dangers][1] of curl-pipe-sh, you
can get the install script and execute it with:

    $ curl -fsSL https://git.io/vM2Jb | sh

You may also want to look into the font [Input][2].

[1]: https://jordaneldredge.com/blog/one-way-curl-pipe-sh-install-scripts-can-be-dangerous/
[2]: http://input.fontbureau.com
