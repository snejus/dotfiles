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

export -U PATH=$HOME/go/bin:$HOME/.pyenv/bin:$PATH
export NO_AT_BRIDGE=1
export LANG=en_US.UTF-8
export EDITOR=nvim
export SHELL=/usr/bin/zsh
export BROWSER=qutebrowser
export XDG_CONFIG_HOME=$HOME/.config
export MPD_HOST=$XDG_RUNTIME_DIR/mpd/socket

export CACHEDIR=$HOME/.cache
export FONTCONFIG_PATH=/etc/fonts
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch/config
export WAKATIME_HOME=$XDG_CONFIG_HOME/wakatime
export ZDOTDIR=$HOME/.zsh
