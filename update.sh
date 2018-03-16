#!/bin/sh

cp ~/.aliases aliases
cp ~/.config/dunst/dunstrc dunstrc
cp ~/.gitconfig gitconfig
cp ~/.config/i3/config i3wm
cp -r ~/.config/ranger/rc.conf ranger-rc.conf
cp ~/.vimrc vim
cp ~/.Xresources Xresources
cp ~/.zshrc zshrc
cp ~/.shellfuncs/*.sh zsh-functions/

exit 0
