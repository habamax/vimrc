.vimrc for older boxes
======================

My minimal vimrc I tend to use on older boxes I have to work with.

Install
-------

.. code:: sh

  curl -LO https://raw.githubusercontent.com/habamax/vimrc/master/.vimrc

or just plain old copy paste.

"Features"
----------

* "built-in" colorscheme (embedded https://github.com/habamax/vim-habamax) 
* NIH ``vim-commentary`` alike ``gc`` and ``gcc``
* Eval vimscript with ``<space>v``
* ``vim-unimpaired`` like toggles with ``yoh``, ``yon`` etc
* quickfix mappings ``[q``, ``]q`` etc
* swap, backup, undo files are in separate ``~/.vimdata`` directory
