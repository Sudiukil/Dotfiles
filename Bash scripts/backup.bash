#!/bin/bash

cp ~/.xinitrc ~/Autre/Custo/X/xinitrc
cp ~/.zshrc ~/Autre/Custo/Zsh/zshrc
cp -r ~/.i3/ ~/Autre/Custo/i3/
cp ~/.Xresources ~/Autre/Custo/X/Xresources
cp ~/.vimrc ~/Autre/Custo/Vim/vimrc
cp ~/.vim/colors/* ~/Autre/Custo/Vim/
cp -r ~/.thunderbird/* ~/Autre/Backups/Mails/
cp ~/.newsbeuter/urls ~/Autre/Backup/rss-urls
~/Autre/Scripts/mcbackup

rsync -rltv --delete-after ~/Autre/ /run/media/quentin/EHDD1To/Backup/Autre/
rsync -rltv --delete-after ~/Documents/ /run/media/quentin/EHDD1To/Backup/Documents/
rsync -rltv --delete-after ~/Images/ /run/media/quentin/EHDD1To/Backup/Images/
rsync -rltv --delete-after ~/Musique/ /run/media/quentin/EHDD1To/Backup/Musique/
rsync -rltv --delete-after ~/Tri/ /run/media/quentin/EHDD1To/Backup/Tri/
rsync -rltv --delete-after ~/Téléchargements/ /run/media/quentin/EHDD1To/Backup/Téléchargements/
rsync -rltv --delete-after ~/Vidéos/ /run/media/quentin/EHDD1To/Backup/Vidéos/
rsync -rltv --delete-after ~/.local/share/Steam/ /run/media/quentin/EHDD1To/Backup/Steam/

rm -r /run/media/quentin/EHDD1To/.Trash-*/
umount /run/media/quentin/EHDD1To/

exit
