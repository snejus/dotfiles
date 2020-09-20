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
export XDG_CONFIG_HOME=$HOME/.config
export WAKATIME_HOME=$HOME/.wakatime
export ZDOTDIR=$HOME/.zsh
