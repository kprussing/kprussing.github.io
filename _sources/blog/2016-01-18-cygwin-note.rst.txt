:author: Keith F. Prussing, Ph.D.
:date: 2016-01-18
:template: post.html

Starting X Under Cygwin
=======================

.. container:: abstract

    This is just a quick note to myself on how to launch Cygwin's X
    server using native windows so I can delete it from my desktop.

After installing the `X server from Cygwin <see>`_, the server can
be launched using::

    $ XWin -multiwindow -clipboard -silent-dup-err

to let Windows handle the windowing.  To launch X at log in, use
``/bin/run``.  This boils down to creating a shortcut and setting the
target to ::

    C:\Programs\CygWin\bin\run.exe XWin -multiwindow -clipboard -silent-dup-error

Then, place the short cut in the start up directory.

Edit: Desktop Environment
-------------------------

To use a desktop environment, follow `these notes <these>`_.  KDE
appears to work out of the box.  The Gnome and Mate desktops are not
working yet.  It appears like the Gnome session looks in
``/home/userid/`` instead of ``$HOME``.  I'm still looking though.

.. _see: http://x.cygwin.com/docs/ug/setup.html
.. _these: http://x.cygwin.com/docs/ug/using.html

