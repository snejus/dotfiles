export POETRYPATH=$HOME/.poetry/bin
export NVMPATH=$HOME/.nvm
export RUSTPATH=$HOME/.cargo/bin
export USERPATH=$HOME/.local/bin
export PYENVPATH=$HOME/.pyenv/bin
export GOPATH=$HOME/.local/go/bin
export -U PATH=$POETRYPATH:$RUSTPATH:$GOPATH:$USERPATH:$PYENVPATH:$PATH

export MYPYPATH=$HOME/stubs

export PYTHONDONTWRITEBYTECODE=1
export TERM='xterm-256color'
export ZSH=$HOME/.oh-my-zsh

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh_fzf ] && source ~/.zsh_fzf
[ -f ~/.zsh_func ] && source ~/.zsh_func
[ -f ~/.zsh_sens ] && source ~/.zsh_sens
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
[ -f ~/.completions/git-extras-completion.zsh ] && source ~/.completions/git-extras-completion.zsh

[ -s "$NVMPATH/nvm.sh" ] && \. "$NVMPATH/nvm.sh"  # Load nvm
[ -s "$NVMPATH/bash_completion" ] && \. "$NVMPATH/bash_completion"  # Load nvm bash_completion

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
