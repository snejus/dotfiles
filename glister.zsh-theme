local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

function git_tag() {
    echo "$(git describe 2> /dev/null)"
}

function get_project() {
    dir="$PWD"
    project="$(git rev-parse --show-toplevel 2> /dev/null)"
    if [[ -z $project ]]; then
        [[ "$dir" == "$HOME" ]] && echo "~" || echo $dir | sed 's/.*\/\(.*\/.*\)/\1/'
    else
        echo $project | sed 's/.*\///'
    fi
}

PROMPT=' $ret_status %{$fg[grey]%}$(get_project) %{$fg_bold[green]%}$(git_tag) $(git_prompt_info)%{$reset_color%}%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓%{$reset_color%}"
