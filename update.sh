#!/bin/sh

# CLI env
cp ~/.Xresources Xresources
cp ~/.zshrc zshrc
cp ~/.zprofile zprofile
cp ~/.xinitrc xinitrc
cp ~/.envrc envrc
cp ~/.aliases aliases
cp ~/.functions/*.sh zsh-functions/

# Graphical env
cp ~/.config/i3/config i3wm
cp ~/.config/dunst/dunstrc dunstrc

# Various tools
cp ~/.gitconfig gitconfig
cp ~/.vimrc vim
cp ~/.vimrc.mappings vim_mappings
cp -r ~/.config/ranger/rc.conf ranger-rc.conf

# Vim plugins
this_dir=$(pwd)
cd ~/.vim/pack/plugins/start
[ -f list ] && rm list
ls | while read i; do
  cd $i
  echo $(git config --get remote.origin.url) >> ../list
  cd ..
done
cd $this_dir
mv ~/.vim/pack/plugins/start/list vim_plugins

# Multimedia
cp ~/.config/mpd/mpd.conf mpd
cp ~/.config/ncmpcpp/config ncmpcpp

git status

exit 0
