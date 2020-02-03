.. meta::
   :date: 2015-08-24

Setting a Break Point Under PyQt
================================

.. class:: summary

    This is simply a note to myself so I can quit googling how to do this.
    From `this answer`_ on Stack Overflow, to set a break point in a PyQt4
    application insert::

        import pdb, PyQt4
        PyQt4.QtCore.pyqtRemoveInputHook()
        pdb.set_trace()

.. _`this answer`: http://stackoverflow.com/questions/1736015/debugging-a-pyqt4-app

