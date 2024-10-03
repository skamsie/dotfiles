## brew

```bash
brew install $(<brew_packages.txt) && brew upgrade
```

## bat

```bash
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/skamsie/dotfiles/raw/master/skamsie.tmTheme
bat cache --build
```

## git

```
cp .gitignore ~ && cp .gitconfig ~
```
## neovim

 Just install `neovim` and copy the `nvim` folder to `~/.config`

## tmux

```bash
# Tmux plugins manager (https://github.com/tmux-plugins/tpm)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# copy tmux config
> cp .tmux.conf ~

# In a tmux session install with prefix + I
```

## vim

```bash
cp -r .vim ~ && cp .vimrc ~ && vim -c ":silent PlugInstall | qa"

# custom solarized airline theme
cp solarized_patched.vim ~/.vim/plugged/vim-airline-themes/autoload/airline/themes/solarized.vim
```
