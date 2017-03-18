dotfiles
========

a potpourri of macOS dotfiles

install
-------

Before you install, you should understand what this project, hereafter
``dotfiles``, is and does.

The install script clones ``dotfiles`` to your ``$HOME/.config``. Thereafter,
it is auto-updated daily.

One of the primary purposes of ``dotfiles`` (the project) is to manage
dotfiles (those files in your home directory whose filenames start with a dot).

With these facts in mind, note that a file named X on your system will be
replaced by the file named Y in ``dotfiles``, where X and Y are:

+--------------------------------+------------------+
| X                              | Y                |
+================================+==================+
| ``$HOME/.config/path/to/file`` | ``path/to/file`` |
+--------------------------------+------------------+
| ``$HOME/.file``                | ``home/file``    |
+--------------------------------+------------------+

A few other files in ``$HOME/.config`` that will be replaced are

- ``.git``, because that's where Git information goes,
- ``update-dotfiles.last``, because that's how we track when we've updated, and
- ``update-dotfiles.lock``, because that's how we make sure we don't have two
  instances of the update script running at once.

Note also that this is true not only when the install script is run, but also
the auto-update script.

A file named X for which there does *not* exist an corresponding file named Y
will not be affected. Be warned, however, that if in the future, a
corresponding file *is* added in ``dotfiles``, it will replace the other one.

Note also, however, that it *is* possible to use ``dotfiles`` both while
tracking upstream changes and keeping your own modifications intact. If you
commit your changes in ``$HOME/.config``, the auto-update script will respect
them.

More technically, the auto-update script rebases your local HEAD against the
upstream origin/master. If merge conflicts arise between upstream and what you
have, the conflicts are always resolved with your version.

If you understand and accept the risks::

    curl -fsSL http://d.azdavis.xyz | sh
