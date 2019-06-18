source ~/.bash_profile

#export PATH=$HOME/bin:/usr/local/bin:$PATH

# How often to auto-update (in days).
export UPDATE_ZSH_DAYS=10

# enable iex history
export ERL_AFLAGS="-kernel shell_history enabled"

plugins=(
  # https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins#osx
  osx

  # git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  zsh-autosuggestions
)

alias ssaver='/System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine'

export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Custom theme
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
RPROMPT="%{$fg[cyan]%} ◴ %{$reset_color%}%*"

export EDITOR='vim'
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

eval "$(direnv hook $SHELL)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init -)"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
