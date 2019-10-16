# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/sarunasnejus/.oh-my-zsh"
export TERM="xterm-256color"

 #Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="simple"
#ZSH_THEME="amuse"
#ZSH_THEME="powerlevel9k/powerlevel9k"
#ZSH_THEME="spaceship"
ZSH_THEME="glister"
#ZSH_THEME="pure"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source ~/.alias_clockpost

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias todos="grep -RI TODO ."
alias typora="open -a typora"
alias vim="/usr/local/bin/vim"
alias ls="gls -lah --color --group-directories-first" # show hidden files, expanded infoand proper K/M/GB by default

# Servers
alias workhorse2="ssh sarunas@37.59.31.66"
alias workhorse3="ssh sarunas@37.187.155.228"
alias workhorse4="ssh sarunas@94.23.219.100"
alias projecty="ssh sarunas@34.214.75.198"
alias projecty2="ssh sarunas@37.187.79.72"
alias madscientist="ssh sarunas@ns3311209.ip-5-135-161.eu"
alias shopping="ssh sarunas@ns352932.ip-37-187-146.eu"

# Folders
alias ceta="cd ~/Documents/brainlabs/CetaAdGroupDeviceModifiers/"
alias megachecker="cd ~/Documents/brainlabs/MegaChecker/services/checkers/"

# Other
alias dockerip='eval $(docker-machine env default)'
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/Cellar:~/.composer/vendor/bin:$PATH
export GITHUB_TOKEN=6924b264f2567c4495c702edaf9b1da8f42d2463
export PIPENV_VENV_IN_PROJECT=1
export TERM=xterm
export LESS="-XFN" # X: keeps output on screen, F: auto exit if short file, N: line numbers
export VIMRUNTIME=/usr/local/Cellar/macvim/8.1-152/MacVim.app/Contents/Resources/vim/runtime
export CETA_CONFIG_PATH="/Users/sarunasnejus/Documents/brainlabs/CetaAdGroupDeviceModifiers/config.json"
export MEGACHECKER_PRODUCTION_CREDS="/Users/sarunasnejus/Documents/cred/credentials.json"
export MEGACHECKER_MAINTAINER_CREDS="/Users/sarunasnejus/Documents/cred/credentials.yaml"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g ""'

# added by travis gem
[ -f /Users/sarunasnejus/.travis/travis.sh ] && source /Users/sarunasnejus/.travis/travis.sh
