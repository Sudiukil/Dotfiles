#!/bin/bash

if [ $1 == "--dual" ]
then
	xrandr --output DVI-D-0 --primary --mode 1920x1080 --output HDMI-0 --mode 1440x900 --left-of DVI-D-0 &
	sleep 5
	feh --bg-fill ~/Autre/Custo/Wallpapers/Sons\ Of\ Anarchy/Ireland.jpg &
elif [ $1 == "--dvi" ]
then
	xrandr --output DVI-D-0 --primary --mode 1920x1080 --output HDMI-0 --off &
	sleep 5
	feh --bg-fill ~/Autre/Custo/Wallpapers/Sons\ Of\ Anarchy/Ireland.jpg &
elif [ $1 == "--hdmi" ]
then
	xrandr --output HDMI-0 --primary --mode 1440x900 --output DVI-D-0 --off &
	sleep 5
	feh --bg-fill ~/Autre/Custo/Wallpapers/Sons\ Of\ Anarchy/Ireland.jpg &
else
	echo -e "Choisir une option :\n"
	echo -e "--dual 		mode double écran\n--dvi 		sortie unique sur DVI-D-0\n--hdmi 		sortie unique sur HDMI-0\n"
fi

exit
