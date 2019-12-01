## brew

```bash
brew install $(<brew_packages.txt) && brew upgrade && yes | /usr/local/opt/fzf/install
```

## vim

```bash
cp -r .vim ~ && cp .vimrc ~ && vim -c ":silent PlugInstall | qa"

# custom solarized airline theme
cp solarized_patched.vim ~/.vim/plugged/vim-airline-themes/autoload/airline/themes/solarized.vim
```

## neovim

```bash
> brew install neovim

> n_dir=~/.config/nvim mkdir -p $n_dir && cp init.vim $n_dir && cp coc-settings.json $n_dir

> nvim -c ":silent PlugInstall | qa"
```

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
