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

```bash
brew install neovim

# copy files
n_dir=~/.config/nvim && mkdir -p $n_dir && cp init.vim $n_dir && cp coc-settings.json $n_dir

# install plug https://github.com/junegunn/vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install plugins with plug
nvim -c ":silent PlugInstall | qa"

# install coc extensions https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
nvim -c 'CocInstall -sync coc-json coc-html coc-vimlsp coc-solargraph coc-python coc-css| q'

# copy custom solarized airline theme
cp solarized_patched.vim ~/.local/share/nvim/plugged/vim-airline-themes/autoload/airline/themes/solarized.vim
```

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
