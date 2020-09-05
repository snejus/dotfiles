export POETRYPATH=$HOME/.poetry/bin
export NVMPATH=$HOME/.nvm
export RUSTPATH=$HOME/.cargo/bin
export USERPATH=$HOME/.local/bin
export PYENVPATH=$HOME/.pyenv/bin
export GOPATH=$HOME/.local/go/bin/bin
export LUAROCKSPATH=$HOME/.luarocks/bin
export -U PATH=$POETRYPATH:$RUSTPATH:$GOPATH:$USERPATH:$PYENVPATH:$LUAROCKSPATH:$PATH

export MYPYPATH=$HOME/stubs

export PYTHONDONTWRITEBYTECODE=1
export TERM='xterm-256color'
export ZSH=$HOME/.oh-my-zsh
export BAT_STYLE=plain

set -o vi
export EDITOR=vim
export VISUAL=vim

ZSH_THEME=glister

# caps lock is an escape
setxkbmap -option caps:escape

fpath=(
    $HOME/.oh-my-zsh/custom/functions
    $fpath
)

plugins=(
    timer
    extract
    colorize
    cheatsheet
    zsh-completions
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
)
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs  # initialise cdr

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
export KEYTIMEOUT=1

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(pandoc --bash-completion)"
eval "$(jira --completion-script-bash)"
eval "$(register-python-argcomplete pipx)"
source $HOME/.local/share/dephell/_dephell_zsh_autocomplete

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
[ -f $HOME/.zsh_fzf ] && source $HOME/.zsh_fzf
[ -f $HOME/.zsh_func ] && source $HOME/.zsh_func
[ -f $HOME/.zsh_sens ] && source $HOME/.zsh_sens
[ -f $HOME/.zsh_aliases ] && source $HOME/.zsh_aliases
[ -f $HOME/.completions/git-extras-completion.zsh ] && source $HOME/.completions/git-extras-completion.zsh

# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#     tmux attach -t default || tmux new -s default
# fi

# zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more
zstyle :compinstall filename "$HOME/.zshrc"

autoload -U bashcompinit
bashcompinit
autoload -Uz compinit
compinit

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/home/sarunas/.cache/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
