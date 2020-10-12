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

path=(
    # $HOME/.nvm
    # $HOME/.cargo/bin
    # $HOME/.poetry/bin
    # $HOME/.luarocks/bin
    # $HOME/.nvm/versions/node/v14.4.0/bin/
    # $HOME/.gem/ruby/2.7.0/bin
    # $HOME/.fzf/bin
    $HOME/go/bin
    $HOME/.pyenv/bin
    $PATH
)
export -U PATH=$PATH

export BAT_STYLE=plain
export MYPYPATH=$HOME/stubs
export PYTHONDONTWRITEBYTECODE=1
export SHELL=/usr/bin/zsh
export SUSHELL=/bin/sh
export WAKATIME_HOME=$HOME/.wakatime
export XDG_CONFIG_HOME=$HOME/.config
export NOTMUCH_CONFIG=$HOME/.config/notmuch/config
export TERM=xterm-256color
export VISUAL=vim
export ZDOTDIR=$HOME/.zsh
export ZSH=$HOME/.oh-my-zsh
