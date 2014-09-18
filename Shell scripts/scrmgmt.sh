#!/bin/sh

# handle screen management via xrandr

function print_usage {
echo "Usage:"
echo -e "Dual:\t\t--dual"
echo -e "DVI:\t\t--dvi"
echo -e "HDMI:\t\t--hdmi"
echo -e "Visual mode:\t--visual"
echo -e "Help: \t\t-h"
}

function setwallpaper {
sleep 5
sh ~/.fehbg
}

case $1 in
	--visual)
		i3-nagbar -t warning -m ""\
			-b "DVI" "scrmgmt --dvi"\
			-b "DUAL" "scrmgmt --dual"\
			-b "HDMI" "scrmgmt --hdmi" &
		sleep 5
		killall i3-nagbar
		exit 0;;
	--dvi)
		xrandr --output DVI-D-0 --primary --mode 1920x1080 --output HDMI-0 --off
		setwallpaper
		exit 0;;
	--hdmi)
		xrandr --output HDMI-0 --primary --mode 1440x900 --output DVI-D-0 --off
		setwallpaper
		exit 0;;
	--dual)
		xrandr --output DVI-D-0 --primary --mode 1920x1080 --output HDMI-0 --mode 1440x900 --left-of DVI-D-0
		setwallpaper
		exit 0;;
	-h)
		print_usage
		exit 0;;
	*)
		print_usage
		exit 1;;
esac
