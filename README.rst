========
dotfiles
========


Building vim
============

#. Install dependencies

   .. code:: bash

       sudo apt update
       sudo apt build-dep vim

#. Configure

   .. code:: bash

       ./configure --with-features=huge \
                   --enable-multibyte \
                   --enable-rubyinterp=yes \
                   --enable-python3interp=yes \
                   --with-python3-config-dir=$(python3-config --configdir) \
                   --enable-perlinterp=yes \
                   --enable-luainterp=yes \
                   --enable-gui=gtk3 \
                   --enable-cscope \
                   --prefix=/usr/local

       make VIMRUNTIMEDIR=/usr/local/share/vim/vim82

#. Install

   .. code:: bash

       make install
