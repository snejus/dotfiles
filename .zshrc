export NVMPATH=~/.nvm
export RUSTPATH=~/.cargo/bin
export PYENVPATH=~/.pyenv/bin
export GOPATH=~/.local/go/bin
export -U PATH=$RUSTPATH:$GOPATH:$PYENVPATH:~/.local/bin:$PATH

export PIPENV_VENV_IN_PROJECT=1
export PYTHONDONTWRITEBYTECODE=1
export TERM='xterm-256color'
export ZSH=~/.oh-my-zsh


ZSH_THEME=glister

# caps lock is an escape
setxkbmap -option "caps:escape"

fpath=(
    $HOME/.oh-my-zsh/custom/functions
    $fpath
)

plugins=(
  colored-man-pages
  colorize
  git
  zsh-completions
  zsh-autosuggestions
  django
)

source $ZSH/oh-my-zsh.sh

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

### Some zle stuff
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
eval "$(register-python-argcomplete pipx)"
eval "$(jira --completion-script-bash)"
source $HOME/.local/share/dephell/_dephell_zsh_autocomplete

autoload -U bashcompinit
bashcompinit
autoload -Uz compinit && compinit
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh_fzf ] && source ~/.zsh_fzf
[ -f ~/.zsh_sens ] && source ~/.zsh_sens
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
[ -s "$NVMPATH/nvm.sh" ] && \. "$NVMPATH/nvm.sh"  # Load nvm
[ -s "$NVMPATH/bash_completion" ] && \. "$NVMPATH/bash_completion"  # Load nvm bash_completion
