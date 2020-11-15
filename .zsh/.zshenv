#!/bin/sh

#    /etc/zsh/zshenv
# -> $ZDOTDIR/.zshenv
#
# -> /etc/zsh/zprofile  (if login shell)
# -> $ZDOTDIR/.zprofile (if login shell)
#
# -> /etc/zsh/zshrc     (if interactive shell)
# -> $ZDOTDIR/.zshrc    (if interactive shell)
#
# -> /etc/zsh/zlogin    (if login shell)
# -> $ZDOTDIR/.zlogin   (if login shell)
#
# -> /etc/zsh/zlogout
# -> $ZDOTDIR/.zlogout

skip_global_compinit=1

export -U PATH=$HOME/go/bin:$HOME/.pyenv/bin:$PATH
export UID=$(id -u)
export GID=$(id -g)
export LANG=en_US
export EDITOR=vim
export SHELL=/usr/bin/zsh
export BROWSER=qutebrowser
export TZ=Europe/London

export BAT_STYLE=plain
export MPD_HOST=/run/user/$UID/mpd/socket
export PYTHONDONTWRITEBYTECODE=1

export ZDOTDIR=$HOME/.zsh
export CACHEDIR=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config

export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export LESSHISTFILE=$CACHEDIR/less
export MYPY_CACHE_DIR=$CACHEDIR/mypy
export MYPYPATH=$HOME/stubs
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch/config
export PYLINTHOME=$CACHEDIR/pylint
export PSQL_HISTORY=$CACHEDIR/psql
export VAGRANT_HOME=$CACHEDIR/vagrant
export WAKATIME_HOME=$XDG_CONFIG_HOME/wakatime
export WEECHAT_HOME=$XDG_CONFIG_HOME/weechat

source $ZDOTDIR/locale.sh
