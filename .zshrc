path=(
    $HOME/.nvm
    $HOME/.cargo/bin
    $HOME/.local/bin
    $HOME/.pyenv/bin
    $HOME/.local/go/bin
    $HOME/.luarocks/bin
    $PATH
)
export PATH=$PATH
export MYPYPATH=$HOME/stubs
export ZSH=$HOME/.oh-my-zsh

export PYTHONDONTWRITEBYTECODE=1
export TERM=xterm-256color

export BAT_STYLE=plain

set -o vi
export VISUAL=vim

unset READNULLCMD
ZSH_THEME=glister
HISTSIZE=50000
HISTFILE=$HOME/.zsh/.zsh_history


fpath=(
    $ZSH/custom/functions
    $fpath
)

plugins=(
    timer
    extract
    cheatsheet
    zsh-completions
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
)
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs # initialise cdr
autoload -U zsh-mime-setup
zsh-mime-setup

DISABLE_LS_COLORS=true
source $ZSH/oh-my-zsh.sh

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

### Some zle mappings
bindkey -v
bindkey '^k' up-history
bindkey '^j' down-history
bindkey '^d' backward-kill-word

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(pandoc --bash-completion)"
eval "$(jira --completion-script-bash)"
eval "$(register-python-argcomplete pipx)"
source "$HOME/.local/share/dephell/_dephell_zsh_autocomplete"
# PROG=td source "$GOPATH/src/github.com/urfave/cli/autocomplete/zsh_autocomplete"

[ -f $ZDOTDIR/.fzf.zsh ] && source $ZDOTDIR/.fzf.zsh
[ -f $ZDOTDIR/.zsh_fzf ] && source $ZDOTDIR/.zsh_fzf
[ -f $ZDOTDIR/.zsh_func ] && source $ZDOTDIR/.zsh_func
[ -f $ZDOTDIR/.zsh_sens ] && source $ZDOTDIR/.zsh_sens
[ -f $ZDOTDIR/.zsh_aliases ] && source $ZDOTDIR/.zsh_aliases
[ -f $HOME/.completions/git-extras-completion.zsh ] && source $HOME/.completions/git-extras-completion.zsh
[ -s "$NVMPATH/nvm.sh" ] && \. "$NVMPATH/nvm.sh"  # Load nvm
# [ -s "$NVMPATH/bash_completion" ] && \. "$NVMPATH/bash_completion"  # Load nvm bash_completion

# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#     tmux attach -t default || tmux new -s default
# fi

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' group-name ''
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more
zstyle :compinstall filename "$HOME/.zshrc"

autoload -U bashcompinit
bashcompinit
# autoload -Uz compinit
# compinit

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/home/sarunas/.cache/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
