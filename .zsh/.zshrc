export GPG_TTY=$(tty)
export TZ=Europe/London

if [[ -n $DISPLAY ]] then
    setxkbmap \
        -option caps:escape \
        -option shift:both_capslock_cancel
fi

HISTFILE=$HOME/.zsh/.zsh_history
HISTSIZE=50000
ZSH=$HOME/.oh-my-zsh
ZSH_THEME=glister

fpath=(
    $ZSH/custom/functions
    $fpath
)
plugins=(
    timer
    cheatsheet
    colored-man-pages
    zsh-autosuggestions
)
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs    # cdr
autoload -U zsh-mime-setup
zsh-mime-setup                          # alias -s

source $ZSH/oh-my-zsh.sh

### Some zle mappings
bindkey -v
bindkey ^k up-history
bindkey ^j down-history
bindkey ^d backward-kill-word

export PATH=$HOME/.local/bin:$PATH
eval "$(pyenv init -)"

to_source=(
    /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    /usr/share/todoist/todoist_functions_fzf.sh
    $HOME/.cache/heroku/autocomplete/zsh_setup
    $ZDOTDIR/.fzf.zsh
    $ZDOTDIR/aliases
    $ZDOTDIR/fzf
    $ZDOTDIR/functions
    $ZDOTDIR/git
    $ZDOTDIR/jira
    $ZDOTDIR/sens
    $ZDOTDIR/python
    $ZDOTDIR/todoist
)
for name in $to_source; do
    [ -f $name ] && source $name;
done

# autoload -U bashcompinit
# bashcompinit

# autoload -Uz compinit
# compinit

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.cache/zsh
zstyle ':completion:*' completer _complete _match _approximate
# zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# most recent completions in a menu
zstyle ':completion:*:*:xdvi:*' menu yes select
zstyle ':completion:*:*:xdvi:*' file-sort time

# process list (like fzf)
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
