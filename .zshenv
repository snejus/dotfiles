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

ZDOTDIR=$HOME/.zsh

setxkbmap -option caps:escape  # caps lock is an escape
xset r rate 180 30             # keyboard press delays
