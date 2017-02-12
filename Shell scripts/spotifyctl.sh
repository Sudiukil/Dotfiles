#!/bin/sh

# wrapper script for playerctl, allowing direct control over spotify

print_usage() {
	echo "Usage:"
	echo "${0##*/} toggle\t Toggle play/pause"
	echo "${0##*/} stop\t\t Stop playback"
	echo "${0##*/} prev\t\t Previous track"
	echo "${0##*/} next\t\t Next track"
	echo "${0##*/} info\t\t Show song info/metadata"
}

spotify_info() {
	trackNumber=$(playerctl -p spotify metadata "xesam:trackNumber")
	title=$(playerctl -p spotify metadata "xesam:title")
	artist=$(playerctl -p spotify metadata "xesam:artist")
	album=$(playerctl -p spotify metadata "xesam:album")

	if [ "$trackNumber" -lt "10" ]
	then
		trackNumber="0$trackNumber"
	fi

	echo "$trackNumber. $title - $artist ($album)"
}

spotify_raw_info() {
	title=$(playerctl -p spotify metadata "xesam:title")
	artist=$(playerctl -p spotify metadata "xesam:artist")

	echo "$title $artist"
}

case $1 in
	-toggle|toggle)
		playerctl -p spotify play-pause;;
	-stop|stop)
		playerctl -p spotify stop;;
	-prev|prev)
		playerctl -p spotify previous;;
	-next|next)
		playerctl -p spotify next;;
	-info|info)
		spotify_info;;
	-rawinfo|rawinfo)
		spotify_raw_info;;
	*)
		print_usage
		exit 1;;
esac

exit 0
