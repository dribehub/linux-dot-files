#!/bin/sh

cd $HOME/Repos/dot-files

# configs
cp $HOME/.config/awesome/rc.lua awesome/rc.lua
cp $HOME/.config/neofetch/config.conf neofetch/config.conf
cp $HOME/.config/polybar/config.ini polybar/config.ini
cp $HOME/.config/nvim/init.vim  vim/init.vim
cp $HOME/.vimrc vim/.vimrc

# zshrc
cp $HOME/.zshrc zshrc/.zshrc
cp $HOME/.zshenv zshrc/.zshenv
cp $ZSHRC/aliases.zsh zshrc/aliases.zsh
cp $ZSHRC/cli-commands.sh zshrc/cli-commands.sh
cp $ZSHRC/functions.zsh zshrc/functions.zsh

# scripts
cp $HOME/Scripts/* Scripts

git add . &&
git commit -am "$1" &&
git status &&
git push
