case "$HOST" in
    ripples-MBP)
        local host_color=$fg_bold[red]
        ;;
    *)
        local host_color=$fg_bold[magenta]
        ;;
esac

local user_host="%{$fg_bold[blue]%}(%{$host_color%}%m%{$fg_bold[blue]%})%{$reset_color%}"

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='${ret_status} ${user_host}%{$fg_bold[green]%}%p %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

ZSH_THEME_CURRENT_DATE=`date +"%Y-%m-%d %H:%M:%S"`
#RPROMPT='%{$fg_bold[green]%}[%W %*]%{$reset_color%}'
