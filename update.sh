#!/bin/sh

# CLI env
cp ~/.Xresources Xresources
cp ~/.zshrc zshrc
cp ~/.zprofile zprofile
cp ~/.aliases aliases
cp ~/.shellfuncs/*.sh zsh-functions/

# Graphical env
cp ~/.config/i3/config i3wm
cp ~/.config/dunst/dunstrc dunstrc

# Various tools
cp ~/.gitconfig gitconfig
cp ~/.vimrc vim
cp -r ~/.config/ranger/rc.conf ranger-rc.conf

# Multimedia
cp ~/.config/mpd/mpd.conf mpd
cp ~/.config/ncmpcpp/config ncmpcpp

exit 0
