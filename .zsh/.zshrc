#
#  ███ ███   ███ ███   ██   ██
#       ██   ██        ██   ██
#       ██   ██        ██   ██
#   ██ ██     ██ ██    ███ ███
#  ██             ██   ██   ██
#  ██             ██   ██   ██
#  ███ ███   ███ ███   ██   ██
#
# wal -R

# {{{ Environmental variables
export GPG_TTY=$(tty)
export PYENV_SHELL=zsh
export LESS=-XLR
export PAGER="less -XLR"
export PSQL_PAGER="pspg -b --bold-labels --double-header --force-uniborder --interactive"
export UID=$(id -u)
export GID=$(id -g)

export PYTHONDONTWRITEBYTECODE=1
export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export LESSHISTFILE=$CACHEDIR/less
export LOCAL_BINDIR=$HOME/.local/bin
export MUSIC_DIR=/media/music
export MYPY_CACHE_DIR=$CACHEDIR/mypy
export MYPYPATH=$HOME/stubs
export PIPX_VENVS_PATH=$HOME/.local/pipx/venvs
export PIP_REQUIRE_VIRTUALENV=true
export PYLINTHOME=$CACHEDIR/pylint
export PSQL_HISTORY=$CACHEDIR/psql
export REPODIR=$HOME/repo
export ALIAS_DIR=$HOME/.d/.zsh/alias
export TASKRC=$XDG_CONFIG_HOME/task/taskrc
export VAGRANT_HOME=$CACHEDIR/vagrant
export WEECHAT_HOME=$XDG_CONFIG_HOME/weechat
export PATH=$HOME/.pyenv/shims:$LOCAL_BINDIR:$PATH

export GREP_COLORS="ms=07;36:mc=01;35:sl=:cx=:fn=35:ln=32:bn=32:se=36"
export JQ_COLORS="1;31:1;32:1;33:1;34:1;35:1;36:1;37"
export VIRTUALENV_PROMPT=''
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;33;40:\
*.tar=01;31:*.zip=01;31:*.gz=01;31:*.jar=01;31:\
*.jpg=01;35:*.png=01;35:*.svg=01;35:\
*.mov=01;35:*.mpg=01;35:*.mkv=01;35:*.mp4=01;35:\
*.aac=01;36:*.flac=01;36:*.mp3=00;36:*.wav=01;36:\
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
# {{{ zsh variables
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=200000
SAVEHIST=200000
setopt AUTO_CD
setopt AUTO_LIST
setopt GLOB_COMPLETE
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt COMPLETE_IN_WORD
# }}}
# {{{ zle mappings{{{}}}
bindkey -v
bindkey ^k  up-history
bindkey ^j  down-history
bindkey ^d  backward-kill-word
# }}}
# {{{ completions
zmodload -i zsh/complist
autoload -Uz compaudit compinit && compinit -D

# Thanks @Tropical_Peach on SO
zstyle ':completion:*' list-separator '⼁'
zstyle ':completion:*:default' list-colors \
"${(s.:.)LS_COLORS}=(#b)(--*)|(-*)|(*⼁*)=36=35=31"

zstyle ':completion:*:expand:*' tag-order all-expansions

# Don't complete current directory
# zstyle ':completion:*' ignore-parents parent pwd

# Prevent a tab from being inserted when there are no characters to the left of the cursor
zstyle ':completion:*' insert-tab false

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
# zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'
zstyle ':completion:*' group-name ''

# Fix some formatting issues for long lists
zstyle ':completion:*' list-grouped false
zstyle ':completion:*' list-packed false
# zstyle ':completion:*' list-dirs-first true

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
zstyle ':completion:*:*:cdr:*:*' menu selection
# }}}
# {{{ zsh modules
autoload -U zsh-mime-setup
zsh-mime-setup
# }}}
# {{{ Source tings
export ZSH_GIT_PROMPT_ENABLE_SECONDARY=1
export ZSH_GIT_PROMPT_SHOW_STASH=1
# kitty + complete setup zsh | source /dev/stdin
to_source=(
    $ZDOTDIR/.zsh_aliases
    /usr/share/fzf/completion.zsh
    $REPODIR/misc/fzf/shell/key-bindings.zsh
    /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
    $HOME/.pyenv/completions/pyenv.zsh
    $ZDOTDIR/pygit-prompt.zsh
    ~/.d/.zsh/completions/git-extras-completion.zsh
)
for name in $to_source; do
    [ -f $name ] && source $name
done
eval "$(jira --completion-script-zsh)"
# }}}
# {{{ X-specific options
if [[ -n $DISPLAY ]]; then
    xset r rate 160 40
    setxkbmap -option ""\
        -option "terminate:ctrl_alt_bksp" \
        -option "shift:both_capslock" \
        -option "caps:super"
fi
# }}}
