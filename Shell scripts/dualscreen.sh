#!/bin/sh

# handle dual screen config for laptop (requires screen variables to be set)

MAIN="LVDS1"
VGA="VGA1"
HDMI="HDMI1"

print_usage() {
	echo "Usage: ${0##*/} --hdmi|--vga|--off (--left|--right|--above|--under)"
}

case "$1" in
	--hdmi)
		output="$HDMI"
		xrandr --output LVDS1 --auto --output $HDMI --auto;;
	--vga)
		output="$VGA"
		xrandr --output LVDS1 --auto --output $VGA --auto;;
	--off)
		xrandr --output LVDS1 --auto --output $HDMI --off --output $VGA --off;;
	-h)
		print_usage
		exit 0;;
	*)
		print_usage
		exit 1;;
esac

if [ "$2" != "" -a "$output" != "" ]
then
	case "$2" in
		--left|--right)
			xrandr --output $output $2-of LVDS1;;
		--above|--below)
			xrandr --output $output $2 LVDS1;;
		*)
			print_usage
			exit 1;;
	esac
fi

sh ~/.fehbg

exit 0
