dotfiles
========

a potpourri of macOS dotfiles

install
-------

The install script clones ``dotfiles`` to your ``$HOME/.config``. Thereafter,
it is auto-updated daily. (You can also trigger a manual update with
``update-dotfiles``.)

One of the primary purposes of ``dotfiles`` (the project) is to manage dotfiles
i.e., those files in your home directory whose filenames start with a dot.

``dotfiles`` also manages Sublime Text 3 configuration, which on macOS is
stored elsewhere.

Therefore, a file named X on your system will be replaced by the file named Y
in ``dotfiles``, whenever the install or update scripts are run, where X and Y
are:

+------------------------------------------------------+--------------------+
| X                                                    | Y                  |
+======================================================+====================+
| ``$HOME/.config/path/to/file``                       | ``path/to/file``   |
+------------------------------------------------------+--------------------+
| ``$HOME/.file``                                      | ``home/file``      |
+------------------------------------------------------+--------------------+
| ``$HOME/Library/Application Support/Sublime Text 3`` | ``sublime-text-3`` |
+------------------------------------------------------+--------------------+

A few other files in ``$HOME/.config`` that will be replaced are

- ``.git``, because that's where Git information goes,
- ``update-dotfiles.last``, because that's how we track when we've updated, and
- ``update-dotfiles.lock``, because that's how we make sure we don't have two
  instances of the update script running at once.

A file named X for which there does not exist an corresponding file named Y
will not be affected. But be warned that if in the future, a corresponding Y is
added in ``dotfiles``, it will replace X.

Despite this, it is possible to use ``dotfiles`` both while tracking upstream
changes and keeping your own modifications intact. If you commit your changes
in ``$HOME/.config``, the update script will respect them.

More technically, the update script rebases your local HEAD against the
upstream origin/master. If merge conflicts arise between upstream and what you
have, the conflicts are always resolved with your version.

If you understand and accept the risks::

    curl -fsSL http://d.azdavis.xyz | sh
