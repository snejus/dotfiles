export PATH=$HOME/.pyenv/bin:$HOME/Documents/misc/vale-boilerplate:$HOME/.cargo/bin:$HOME/.local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh
export TERM='xterm-256color'
export PIPENV_VENV_IN_PROJECT=1
export PYENV_ROOT="$HOME/.pyenv"
export BAT_PAGER='less -R'

ZSH_THEME=glister

# caps lock is an escape
setxkbmap -option "caps:escape"

fpath=(
    $HOME/.oh-my-zsh/custom/functions
    $fpath
)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
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
source $HOME/.local/share/dephell/_dephell_zsh_autocomplete
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi

[ -f ~/.zsh_fzf ] && source ~/.zsh_fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
[ -f ~/.zsh_sens ] && source ~/.zsh_sens

autoload -Uz compinit && compinit
