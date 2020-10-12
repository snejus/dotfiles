neofetch || echo Neofetch not found

DISABLE_LS_COLORS=true
HISTFILE=$HOME/.zsh/.zsh_history
HISTSIZE=50000
ZSH_THEME=glister

set -o vi
unset READNULLCMD

fpath=(
    $ZSH/custom/functions
    $fpath
)

plugins=(
    timer
    extract
    cheatsheet
    colored-man-pages
    zsh-autosuggestions
)
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs # initialise cdr
autoload -U zsh-mime-setup
zsh-mime-setup

source $ZSH/oh-my-zsh.sh

### Some zle mappings
bindkey -v
bindkey '^k' up-history
bindkey '^j' down-history
bindkey '^d' backward-kill-word

export PATH=$HOME/.local/bin:$PATH
export GPG_TTY=$(tty)
systemctl --user set-environment GPG_TTY=$GPG_TTY

eval "$(pyenv init -)"
eval "$(register-python-argcomplete pipx)"
source /usr/share/todoist/todoist_functions_fzf.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# eval "$(pyenv virtualenv-init -)"
# eval "$(pandoc --bash-completion)"


to_source=(
    aliases
    fzf
    functions
    git
    jira
    sens
    todoist
    # .completions/git-extras-completion.zsh
    # .completions/zsh-completion.zsh
)
for name in $to_source; do [ -f $ZDOTDIR/$name ] && source $ZDOTDIR/$name; done

if [[ -n $DISPLAY ]] then
    setxkbmap -option caps:escape  # caps lock is an escape
    xset r rate 180 30             # keyboard press delays
fi

# autoload -Uz compinit
# compinit

# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#     tmux attach -t default || tmux new -s default
# fi

# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# zstyle ':completion:*' expand prefix suffix
# zstyle ':completion:*' completer _expand _complete _ignored _correct
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-suffixes
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more
# zstyle :compinstall filename "$HOME/.zsh/.zshrc"

# autoload -U bashcompinit
# bashcompinit
