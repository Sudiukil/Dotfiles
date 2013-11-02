#!/bin/bash

if test -d /run/media/quentin/EHDD1To/
then

	backupDisk=/run/media/quentin/EHDD1To
	backupDir=$backupDisk/Backup

	cp ~/.zshrc ~/Autre/Custo/Zsh/zshrc
	cp ~/.xinitrc ~/Autre/Custo/X/xinitrc
	cp ~/.Xresources ~/Autre/Custo/X/Xresources
	cp -r ~/.i3/* ~/Autre/Custo/i3/
	cp ~/.vimrc ~/Autre/Custo/Vim/vimrc
	cp ~/.vim/colors/* ~/Autre/Custo/Vim/
	cp -r ~/.thunderbird/* ~/Autre/Backups/Thunderbird/
	cp ~/.newsbeuter/urls ~/Autre/Backups/rss-urls
	~/Autre/Scripts/mcbackup
	cp -r /home/wine/Documents/* ~/Autre/Backups/Wine/Documents/

	rsync -rltv --delete-after ~/Autre/ $backupDir/Autre/
	rsync -rltv --delete-after ~/Documents/ $backupDir/Documents/
	rsync -rltv --delete-after ~/Images/ $backupDir/Images/
	rsync -rltv --delete-after ~/Musique/ $backupDir/Musique/
	rsync -rltv --delete-after ~/Tri/ $backupDir/Tri/
	rsync -rltv --delete-after ~/Téléchargements/ $backupDir/Téléchargements/
	rsync -rltv --delete-after ~/Vidéos/ $backupDir/Vidéos/
	rsync -rltv --delete-after ~/.local/share/Steam/ $backupDir/Steam/

	rm -r $backupDisk/.Trash-*/
	umount $backupDisk

else
	echo "Le disque n'est pas monté."
fi

exit
