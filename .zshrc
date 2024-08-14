ZSH_DISABLE_COMPFIX="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

source ~/.bashrc

unsetopt nomatch

export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh

plugins=(
  # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
  macos

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
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[blue]%}⊄ "

PROMPT='%{$fg[cyan]%}%2~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}$(git_prompt_info)$(git_prompt_status)%{$fg[red]%}>%{$reset_color%} '

eval "$(direnv hook $SHELL)"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"
eval "$(rbenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

source <(fzf --zsh)

export BAT_THEME="skamsie"

function Rg() {
  rg --column --line-number --no-heading --color=always --smart-case "$1" |
    fzf --ansi \
      --delimiter : --nth 4.. \
      --bind 'enter:execute(nvim -c ":`echo {}| cut -d: -f2`" `echo {}| cut -d: -f1`)+abort' \
      --preview 'bat --style=numbers,header,changes,snip --color=always --highlight-line {2} {1}' \
      --preview-window 'default:right:60%:~1:+{2}+3/2:border-left'
}
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"
export PATH="/usr/local/opt/elasticsearch@6/bin:$PATH"

export PATH="$PATH:$HOME/.local/bin"
