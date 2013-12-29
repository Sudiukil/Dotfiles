#!/bin/bash

if test -d /run/media/quentin/EHDD1To/
then

	backupDir=~/Autre/Backups
	backupDisk=/run/media/quentin/EHDD1To
	backupDiskDir=$backupDisk/Backup
	serv=quentin@192.168.1.28
	servDir=quentin@192.168.1.28:/var/www

	cp ~/.zshrc ~/Autre/Custo/Zsh/zshrc
	cp ~/.xinitrc ~/Autre/Custo/X/xinitrc
	cp ~/.Xresources ~/Autre/Custo/X/Xresources
	cp -r ~/.i3/* ~/Autre/Custo/i3/
	cp ~/.vimrc ~/Autre/Custo/Vim/vimrc
	cp ~/.vim/colors/* ~/Autre/Custo/Vim/
	cp -r ~/.thunderbird/* $backupDir/Thunderbird/
	cp ~/.newsbeuter/urls $backupDir/rss-urls
	~/Autre/Scripts/mcbackup
	~/Autre/Scripts/skyrimbkp
	rsync $serv:/etc/lighttpd/lighttpd.conf $backupDir/Serveur/
	rsync -r $serv:/etc/php5/ $backupDir/Serveur/php5/
	rsync $servDir/owncloud/config/config.php $backupDir/owncloud-config.php
	pacman -Qe > $backupDir/pkgs.list

	rsync -rltv --delete-after $servDir/index.php $backupDir/Serveur/www/
	rsync -rltv --delete-after $servDir/private/ $backupDir/Serveur/www/private/
	rsync -rltv --delete-after $servDir/scripts/ $backupDir/Serveur/www/scripts/
	rsync -rltv --delete-after $servDir/src/ $backupDir/Serveur/www/src/
	rsync -rltv --delete-after $servDir/style/ $backupDir/Serveur/www/style/

	rsync -rltv --delete-after ~/Autre/ $backupDiskDir/Autre/
	rsync -rltv --delete-after ~/Documents/ $backupDiskDir/Documents/
	rsync -rltv --delete-after ~/Images/ $backupDiskDir/Images/
	rsync -rltv --delete-after ~/Musique/ $backupDiskDir/Musique/
#	rsync -rltv --delete-after ~/Tri/ $backupDiskDir/Tri/
	rsync -rltv --delete-after ~/Téléchargements/ $backupDiskDir/Téléchargements/
	rsync -rltv --delete-after ~/Vidéos/ $backupDiskDir/Vidéos/
	rsync -rltv --delete-after ~/.local/share/Steam/ $backupDiskDir/Steam/

	rm -r $backupDisk/.Trash-*/
	umount $backupDisk
	exit 0

else
	echo "Le disque n'est pas monté."
	exit 1
fi
