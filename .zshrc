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
bindkey '^h' backward-delete-char
bindkey '^d' backward-kill-word

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
###

zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
eval "$(jira --completion-script-bash)"
source $HOME/.local/share/dephell/_dephell_zsh_autocomplete
#if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[ -f ~/.zsh_fzf ] && source ~/.zsh_fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.zsh_sens ] && source ~/.zsh_sens
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

autoload -Uz compinit && compinit
