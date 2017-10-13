# dotfiles

a potpourri of macOS dotfiles

## install

The install script clones `dotfiles` to `~/.config`. You can trigger an
update with `update-dotfiles`.

One of the primary purposes of `dotfiles` (the project) is to manage
dotfiles, i.e., those files in your home directory whose filenames start with a
dot.

`dotfiles` also manages Sublime Text 3 configuration, which on macOS is
stored elsewhere.

Therefore, a file on your system, if it exists, will be replaced with a file
(or symlink to a file) in `dotfiles`, if it exists, according to the
following table:

| # | On your system                                 | In `dotfiles`    |
|---|------------------------------------------------|------------------|
| 1 | `~/.config/.git`                               | N/A              |
| 2 | `~/.config/<path>`                             | `<path>`         |
| 3 | `~/.<path>`                                    | `home/<path>`    |
| 4 | `~/Library/Application Support/Sublime Text 3` | `sublime-text-3` |

These replacements occur when the following commands in `dotfiles` are run:

| Command               | 1 | 2 | 3 | 4 |
|-----------------------|---|---|---|---|
| `install.sh`          | Y | Y | Y | Y |
| `bin/update-dotfiles` | Y | Y | Y | N |
| `bin/do-home`         | N | N | Y | N |
| `bin/do-subl`         | N | N | N | Y |

A file on your system for which there does not exist an corresponding file in
`dotfiles` will not be affected. But be warned that if in the future, a
corresponding file is added to `dotfiles`, the replacements will occur as
detailed.

It is possible to use `dotfiles` both while tracking upstream changes and
keeping your own modifications intact. The update script rebases your local
HEAD against the upstream origin/master. If merge conflicts arise, you will
have to resolve them.

If you understand and accept the risks:

	curl -fsSL https://git.io/vM2Jb | sh
