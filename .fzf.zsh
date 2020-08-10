#!/usr/bin zsh
# Setup fzf
# ---------
if [[ ! "$PATH" == */home/sarunas/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/sarunas/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/sarunas/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/sarunas/.fzf/shell/key-bindings.zsh"
