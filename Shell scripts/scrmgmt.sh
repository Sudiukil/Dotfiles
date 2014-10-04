#!/bin/sh

# handle screen management via xrandr

function print_usage {
echo "Usage:"
echo -e "${0##*/} --dual\t\tDualscreen mode"
echo -e "${0##*/} --dvi\t\tDVI only"
echo -e "${0##*/} --hdmi\t\tHDMI only"
echo -e "${0##*/} --visual\tVisual menu using i3bar"
echo -e "${0##*/} -h\t\tShow this help message"
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
		killall i3-nagbar;;
	--dvi)
		xrandr --output DVI-D-0 --primary --mode 1920x1080 --output HDMI-0 --off
		setwallpaper;;
	--hdmi)
		xrandr --output HDMI-0 --primary --mode 1440x900 --output DVI-D-0 --off
		setwallpaper;;
	--dual)
		xrandr --output DVI-D-0 --primary --mode 1920x1080 --output HDMI-0 --mode 1440x900 --left-of DVI-D-0
		setwallpaper;;
	-h)
		print_usage;;
	*)
		print_usage
		exit 1;;
esac

exit 0
