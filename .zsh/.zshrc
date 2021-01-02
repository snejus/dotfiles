#
#  ███ ███   ███ ███   ██   ██
#       ██   ██        ██   ██
#       ██   ██        ██   ██
#   ██ ██     ██ ██    ███ ███
#  ██             ██   ██   ██
#  ██             ██   ██   ██
#  ███ ███   ███ ███   ██   ██
#

# {{{ Environmental variables
export GPG_TTY=$(tty)
export PYENV_SHELL=zsh
export LESS=-R
export JQ_COLORS="1;31:1;32:1;33:1;34:1;35:1;36:1;37"
export PAGER="less -XLR"
export PSQL_PAGER="pspg -b --bold-labels --double-header --force-uniborder --interactive"
export UID=$(id -u)
export GID=$(id -g)

export PYTHONDONTWRITEBYTECODE=1
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export LESSHISTFILE=$CACHEDIR/less
export LOCAL_BINDIR=$HOME/.local/bin
export MYPY_CACHE_DIR=$CACHEDIR/mypy
export MYPYPATH=$HOME/stubs
export PIPX_VENVS_PATH=$HOME/.local/pipx/venvs
export PYLINTHOME=$CACHEDIR/pylint
export PSQL_HISTORY=$CACHEDIR/psql
export REPODIR=$HOME/repo
export ALIAS_DIR=$HOME/.d/.zsh/alias
export TASKRC=$XDG_CONFIG_HOME/task/taskrc
export VAGRANT_HOME=$CACHEDIR/vagrant
export WAKATIME_HOME=$XDG_CONFIG_HOME/wakatime
export WEECHAT_HOME=$XDG_CONFIG_HOME/weechat
export PATH=$HOME/.pyenv/shims:$LOCAL_BINDIR:$PATH
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;33;40:\
*.tar=01;31:*.zip=01;31:*.gz=01;31:*.jar=01;31:\
*.jpg=01;35:*.png=01;35:*.svg=01;35:\
*.mov=01;35:*.mpg=01;35:*.mkv=01;35:*.mp4=01;35:\
*.aac=00;36:*.flac=00;36:*.mp3=00;36:*.wav=00;36:\
*.log=3;38;5;245:*.txt=3;38;5;245:*.dump=3;38;5;245:*.coverage=3;38;5;245:*.gitignore=3;38;5;245:\
*.py=00;32:\
*.js=1;33:*.html=3;33:\
*.lock=01;32:*oject.toml=01;32:*etup.py=01;32:*equirements.txt=01;32:\
*etup.cfg=3;32:*ypy.ini=3;32:*ylintrc=3;32:*ox.ini=3;32:\
*.md=01;31:*.rst=01;31:\
*file=01;33:\
*.env=01;37:*.yaml=01;37:*.yml=01;37:*.json=01;37:\
*ockerfile=01;36:*ockerignore=01;36:*-compose.test.yml=01;36:*-compose.yml=01;36:"
pyenv rehash
# }}}

# {{{ zsh Variables and functions
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt  COMPLETE_IN_WORD
# }}}

# {{{ zle mappings
bindkey -v
bindkey ^k  up-history
bindkey ^j  down-history
bindkey ^d  backward-kill-word
bindkey '^[;' autosuggest-execute
# }}}

# {{{ Completions
zmodload -i zsh/complist
autoload -Uz compaudit compinit
compinit

# Thanks @Tropical_Peach on SO
zstyle ':completion:*' list-separator '⼁'
zstyle ':completion:*:default' list-colors \
"${(s.:.)LS_COLORS}=(#b)(--*)|(-*)|(*⼁*)=36=35=31"

zstyle ':completion:*:expand:*' tag-order all-expansions

# Don't complete current directory
zstyle ':completion:*' ignore-parents parent pwd

# Cache long lists
zstyle ':completion:*:complete:*' use-cache true
zstyle ':completion:*' cache-path $ZDOTDIR/comp

# Case insensitivity
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Have the newer files last to select them first
zstyle ':completion:*' file-sort modification reverse

# Generate descriptions with magic
zstyle ':completion:*' auto-description 'specify: %d'

# Group formats
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'
zstyle ':completion:*' group-name ''

# Fix some formatting issues for long lists
zstyle ':completion:*' list-grouped false
zstyle ':completion:*' list-packed false
zstyle ':completion:*' list-dirs-first true

# Page and menu long lists
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:default' menu 'select=0'

# Separate sections for man pages
zstyle ':completion:*:manuals' separate-sections true

# More errors allowed for large words and fewer for small words
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'
# zstyle ':completion:*:approximate*:*' prefix-needed false

# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true

kitty + complete setup zsh | source /dev/stdin                                                                                  /
# }}}

# {{{ zsh modules
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs    # cdr
autoload -U zsh-mime-setup
zsh-mime-setup                          # alias -s
# }}}

# {{{ Source tings
to_source=(
    /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
    /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    /usr/share/zsh/scripts/git-prompt.zsh
    $REPODIR/misc/fzf/shell/key-bindings.zsh
    $HOME/.pyenv/completions/pyenv.zsh
    $HOME/.cache/heroku/autocomplete/zsh_setup
    $ZDOTDIR/.zsh_aliases
)
for name in $to_source; do
    [ -f $name ] && source $name
done
# }}}

# {{{ X-specific options
if [[ -n $DISPLAY ]]; then
    xset r rate 160 40
    setxkbmap -option "" -option "caps:escape" -option "terminate:ctrl_alt_bksp"
fi
# }}}
