#
#  ███ ███   ███ ███   ██   ██
#       ██   ██        ██   ██
#       ██   ██        ██   ██
#   ██ ██     ██ ██    ███ ███
#  ██             ██   ██   ██
#  ██             ██   ██   ██
#  ███ ███   ███ ███   ██   ██
#

export GPG_TTY=$(tty)

center() {
    ncols=$(( $(tput cols) - 3 ))
    sed  -e :a -e 's/^.\{1,'"$ncols"'\}$/ &/;ta' -e 's/\( *\)\1/\1/'
}

if [[ $GPG_TTY == /dev/pts/1 ]]; then
     echo "$(pass show 'test')" | center | lolcat -a -s 10
fi


# {{{ Variables and functions
HISTFILE=$HOME/.zsh/.zsh_history
HISTSIZE=50000
ZSH=$HOME/.oh-my-zsh
ZSH_THEME=glister

fpath=(
    $ZSH/custom/functions
    $fpath
)
plugins=(
    cheatsheet
    virtualenv
    colored-man-pages
    zsh-autosuggestions
)
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs    # cdr
autoload -U zsh-mime-setup
zsh-mime-setup                          # alias -s
# }}}

# {{{ ZLE mappings
bindkey -v
bindkey ^k  up-history
bindkey ^j  down-history
bindkey ^d  backward-kill-word
bindkey '^[l' autosuggest-execute
# }}}

# {{{ Completions
zmodload -i zsh/complist
autoload -Uz compinit
compinit -d $ZDOTDIR/comp/.zcompdump

unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD

# Thanks @Tropical_Peach on SO
bindkey -M viins '\C-i' complete-word

zstyle ':completion:*' list-separator '⼁'
zstyle ':completion:*' list-colors "=(#b) #([0-9.]#)*=36=31"

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

# {{{ Source tings
to_source=(
    /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
    /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    /usr/share/zsh/scripts/git-prompt.zsh
    /usr/share/todoist/todoist_functions_fzf.sh
    $HOME/.pyenv/completions/pyenv.zsh
    $HOME/.cache/heroku/autocomplete/zsh_setup
    $ZDOTDIR/.completions/pip.zsh
    $ZDOTDIR/.zsh_aliases
)
for name in $to_source; do
    [ -f $name ] && source $name
done
# }}}

# {{{ X-specific options
if [[ -n $DISPLAY ]]; then #&& [[ -n $GPG_TTY ~= pts ]]; then
    xset r rate 160 40
    setxkbmap -option "" -option "caps:escape" -option "terminate:ctrl_alt_bksp"
    xmodmap -e "remove Mod5 = ISO_Level3_Shift"
    xmodmap -e "remove Mod5 = Mode_switch"
    xmodmap -e "remove Mod4 = Hyper_L"
    xmodmap -e "keycode 0xce = Super_R"
    xmodmap -e "remove Mod4 = Super_R"
    xmodmap -e "remove Mod2 = Num_Lock"
    xmodmap -e "remove Mod1 = Alt_R"
    xmodmap -e "remove Mod1 = Meta_L"
    xmodmap -e "remove Control = Control_R"
fi
# }}}
