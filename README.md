## brew

```bash
brew upgrade $(<brew_packages.txt) && yes | /usr/local/opt/fzf/install
```

## vim

```bash
cp -r .vim ~ && cp .vimrc ~ && vim -c ":silent PlugInstall | qa"

# custom solarized airline theme
cp solarized_patched.vim ~/.vim/plugged/vim-airline-themes/autoload/airline/themes/solarized.vim
```

## tmux

Tmux plugins manager

```git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm```

Copy tmux config

```cp .tmux.conf ~```


In a tmux session install with prefix + I

## emacs

```cp -r dotfiles/emacs24_config ~/.emacs.d```
