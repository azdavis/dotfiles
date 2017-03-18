dotfiles
========

a potpourri of macOS dotfiles

install
-------

Before you install, you should understand what this repository is and does.

If you're using this repository, you should pretty much be comfortable with it
taking over your ``$HOME/.config``. That is where it's installed, after all.

This repository also manages dotfiles, i.e. those configuration files in your
home directory whose filenames start with a dot.

With this in mind, note that a file named X on your system will be replaced by
the file named Y in this repository, where X and Y are:

+--------------------------------+------------------+
| X                              | Y                |
+================================+==================+
| ``$HOME/.config/path/to/file`` | ``path/to/file`` |
+--------------------------------+------------------+
| ``$HOME/.file``                | ``home/file``    |
+--------------------------------+------------------+

Note also that this is true not only when the install script is run, but also
the auto-update script.

A file named X for which there does *not* exist an corresponding file named Y
will be ignored. Be warned, however, that if in the future, a corresponding
file *is* added in this repository, it will replace the other one.

Note also, however, that it *is* possible to use this repository both while
tracking upstream changes and keeping your own modifications intact. If you
commit your changes in ``$HOME/.config``, the auto-update script will respect
them.

More technically, the auto-update script rebases your local HEAD against the
upstream origin/master. If merge conflicts arise between upstream and what you
have, the conflicts are always resolved with your version.

If you understand and accept the risks::

    curl -fsSL http://d.azdavis.xyz | sh
