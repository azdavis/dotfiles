dotfiles
========

a potpourri of macOS dotfiles

install
-------

note that a file named A on your system will be replaced by the file named B in
this repository, where A and B are:

+--------------------------------+------------------+
| A                              | B                |
+================================+==================+
| ``$HOME/.config/path/to/file`` | ``path/to/file`` |
+--------------------------------+------------------+
| ``$HOME/.file``                | ``home/file``    |
+--------------------------------+------------------+

note also that this is true not only when the install script is run, but also
the auto-update script.

why? because if you're using this repository, you should pretty much be
comfortable with it taking over your ``$HOME/.config``.

however, it *is* possible to use this repository both while tracking upstream
changes and keeping your own modifications intact. if you commit your changes
in ``$HOME/.config``, the auto-update script, with the power of ``git rebase``,
is designed to respect them.

if you understand and accept the risks::

    curl -fsSL http://d.azdavis.xyz | sh
