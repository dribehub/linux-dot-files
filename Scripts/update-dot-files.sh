#!/bin/sh

REPO=$HOME/Repos/dot-files
cd $REPO
cp $HOME/.config/awesome/rc.lua awesome/rc.lua
cp $HOME/.config/neofetch/config.conf neofetch/config.conf
cp $HOME/.config/polybar/config.ini polybar/config.ini
cp $HOME/.config/nvim/init.vim  vim/init.vim
cp $HOME/.vimrc vim/.vimrc
cp $HOME/.zshrc zshrc/.zshrc
cp $HOME/.zshenv zshrc/.zshenv
cp $HOME/Scripts/* Scripts
#cp $ZSHRC/* zshrc

git add .
git commit -am "$1"
git status
git push
