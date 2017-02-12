ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✖ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[white]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[white]%}ᐃ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[white]%}− "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[white]%}ρ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}◒ "

PROMPT='%{$fg[cyan]%}%2~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)$(git_prompt_status)%{$fg[red]%}>%{$reset_color%} '
