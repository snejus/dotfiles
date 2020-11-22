local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"

function git_tag() {
    echo "$(git tag --list '[0-9]*.[0-9]*.[0-9]*' --sort -version:refname --merged 2> /dev/null | head -1) "
}

function get_project() {
    dir="$PWD"
    project="$(git rev-parse --show-toplevel 2> /dev/null)"
    if [[ -z $project ]]; then
        [[ "$dir" == "$HOME" ]] && echo "~" || echo $dir | sed 's/.*\/\(.*\/.*\)/\1/' | sed "s/$USER/~/"
    else
        echo $project | sed 's/.*\///'
    fi
}

function get_suffix() {
    git rev-parse --show-prefix 2> /dev/null | sed 's/\([^/]\)[^/]*/\1/g' || echo '/'
}

venv_prompt_info () {
    virtualenv_prompt_info | grep -o 'py[^]]*'
}

PS1=' $ret_status%{$fg[yellow]%}$(get_project)%{$reset_color%}%{$fg_bold[green]%} $(git_tag)$(git_prompt_info)%{$reset_color%} '
RPS1='%{$fg_bold[magenta]%}$(venv_prompt_info)%{$reset_color%} %{$fg_bold[cyan]%}$(get_suffix)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓%{$reset_color%}"

# vim:ft=bash
