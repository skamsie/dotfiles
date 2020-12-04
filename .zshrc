#ZSH_DISABLE_COMPFIX="true"
#DISABLE_UNTRACKED_FILES_DIRTY="true"

export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh

plugins=(
  # https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#osx
  osx

  # show github status
  git

  # git clone https://github.com/zsh-users/zsh-autosuggestions \
  #   $ZSH_CUSTOM/plugins/zsh-autosuggestions
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

#custom theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✖ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[yellow]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[white]%}ᐃ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[white]%}− "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[white]%}ρ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}◒ "

PROMPT='%{$fg[cyan]%}%2~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)$(git_prompt_status)%{$fg[red]%}>%{$reset_color%} '

eval "$(direnv hook $SHELL)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
