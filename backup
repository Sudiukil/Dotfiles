#!/bin/bash

cp ~/.xinitrc ~/Other/Custo/X/xinitrc
cp ~/.zshrc ~/Other/Custo/Zsh/zshrc
cp ~/.i3/config ~/Other/Custo/i3/config
cp ~/.i3/i3status.conf ~/Other/Custo/i3/
cp ~/.Xresources ~/Other/Custo/X/Xresources
cp ~/.vimrc ~/Other/Custo/Vim/vimrc
cp ~/.vim/colors/* ~/Other/Custo/Vim/
cp -r ~/.thunderbird/* ~/Other/Backups/Mails/
newsbeuter -e > ~/Other/Backups/feedlist.opml

rsync -rltv --delete-after ~/Other/ /run/media/sudiukil/EHDD1To/Backup/Other/
rsync -rltv --delete-after ~/Documents/ /run/media/sudiukil/EHDD1To/Backup/Documents/
rsync -rltv --delete-after ~/Pictures/ /run/media/sudiukil/EHDD1To/Backup/Pictures/
rsync -rltv --delete-after ~/Music/ /run/media/sudiukil/EHDD1To/Backup/Music/
rsync -rltv --delete-after ~/Mess/ /run/media/sudiukil/EHDD1To/Backup/Mess/
rsync -rltv --delete-after ~/Downloads/ /run/media/sudiukil/EHDD1To/Backup/Downloads/
rsync -rltv --delete-after ~/Videos/ /run/media/sudiukil/EHDD1To/Backup/Videos/
rsync -rltv --delete-after ~/.local/share/Steam/ /run/media/sudiukil/EHDD1To/Backup/Steam/

rm -r /run/media/sudiukil/EHDD1To/.Trash-*/
umount /run/media/sudiukil/EHDD1To/

exit
