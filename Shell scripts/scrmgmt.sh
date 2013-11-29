#!/bin/bash

case $1 in
	--dual)
		xrandr --output DVI-D-0 --primary --mode 1920x1080 --output HDMI-0 --mode 1440x900 --left-of DVI-D-0 &
		sleep 5
		feh --bg-fill ~/Autre/Custo/Wallpapers/Sons\ Of\ Anarchy/Ireland.jpg &
		exit 0;;
	--dvi)
		xrandr --output DVI-D-0 --primary --mode 1920x1080 --output HDMI-0 --off &
		sleep 5
		feh --bg-fill ~/Autre/Custo/Wallpapers/Sons\ Of\ Anarchy/Ireland.jpg &
		exit 0;;
	--hdmi)
		xrandr --output HDMI-0 --primary --mode 1440x900 --output DVI-D-0 --off &
		sleep 5
		feh --bg-fill ~/Autre/Custo/Wallpapers/Sons\ Of\ Anarchy/Ireland.jpg &
		exit 0;;
	*)
		echo "Args:"
		echo -e "Dual:\t\t--dual"
		echo -e "DVI:\t\t--dvi"
		echo -e "HDMI:\t\t--hdmi"
		exit 1;;
esac

exit
