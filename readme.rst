dotfiles
========

a potpourri of macOS dotfiles

install
-------

The install script clones ``dotfiles`` to ``$XDG_CONFIG_HOME``, or
``~/.config`` by default. Thereafter, it is auto-updated daily. You can also
trigger a manual update with ``update-dotfiles``.

One of the primary purposes of ``dotfiles`` (the project) is to manage
dotfiles, i.e., those files in your home directory whose filenames start with a
dot.

``dotfiles`` also manages Sublime Text 3 configuration, which on macOS is
stored in Application Support.

Therefore, a file on your system, if it exists, will be replaced with a file
(or symlink to a file) in ``dotfiles``, if it exists, according to the
following table:

+---+--------------------------------------------------+--------------------+
| # | On your system                                   | In ``dotfiles``    |
+===+==================================================+====================+
| 1 | ``$XDG_CONFIG_HOME/.git``                        | N/A                |
+---+--------------------------------------------------+--------------------+
| 2 | ``$XDG_CONFIG_HOME/update-dotfiles.last``        | N/A                |
+---+--------------------------------------------------+--------------------+
| 3 | ``$XDG_CONFIG_HOME/<path>``                      | ``<path>``         |
+---+--------------------------------------------------+--------------------+
| 4 | ``~/.<path>``                                    | ``home/<path>``    |
+---+--------------------------------------------------+--------------------+
| 5 | ``~/Library/Application Support/Sublime Text 3`` | ``sublime-text-3`` |
+---+--------------------------------------------------+--------------------+

These replacements occur when the following commands in ``dotfiles`` are run:

+-------------------------+---+---+---+---+---+
| Command                 | 1 | 2 | 3 | 4 | 5 |
+=========================+===+===+===+===+===+
| ``install.sh``          | Y | N | Y | Y | N |
+-------------------------+---+---+---+---+---+
| ``bin/update-dotfiles`` | Y | Y | Y | Y | N |
+-------------------------+---+---+---+---+---+
| ``bin/do-home``         | N | N | N | Y | N |
+-------------------------+---+---+---+---+---+
| ``bin/do-subl``         | N | N | N | N | Y |
+-------------------------+---+---+---+---+---+

A file on your system for which there does not exist an corresponding file in
``dotfiles`` will not be affected. But be warned that if in the future, a
corresponding file is added to ``dotfiles``, the replacements will occur as
detailed.

It is possible to use ``dotfiles`` both while tracking upstream changes and
keeping your own modifications intact. If you commit your changes in
``$XDG_CONFIG_HOME``, the update script will respect them. This is useful for
things like making changes to the ``user`` section of ``git/config``.

The update script rebases your local HEAD against the upstream origin/master.
If merge conflicts arise between upstream and what you have, the conflicts are
always resolved with your version.

If you have uncommitted changes and the updater is invoked, the changes will be
auto-committed, then reset when the updater is finished.

If you understand and accept the risks::

    curl -fsSL http://d.azdavis.xyz | sh
