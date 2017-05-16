#!/bin/sh

# wrapper script for ncmpcpp (used to have equivalent parameters with spotifyctl)

print_usage() {
	echo "Usage:"
	echo "${0##*/} toggle\t Toggle play/pause"
	echo "${0##*/} stop\t\t Stop playback"
	echo "${0##*/} prev\t\t Previous track"
	echo "${0##*/} next\t\t Next track"
	echo "${0##*/} info\t\t Show song info/metadata"
}

case $1 in
	-toggle|toggle)
		ncmpcpp toggle;;
	-stop|stop)
		ncmpcpp stop;;
	-prev|prev)
		ncmpcpp prev;;
	-next|next)
		ncmpcpp next;;
	-info|info)
		info=$(ncmpcpp --now-playing "{%n. }{%t}|{%f}{ - %a}{ (%b)}")
		if [ "$info" ]
		then
			echo $info
		else
			echo "stopped"
		fi;;
	-rawinfo|rawinfo)
		rawinfo=$(ncmpcpp --now-playing "{%t %a}")
		if [ "$rawinfo" ]
		then
			echo $rawinfo
		else
			echo "stopped"
		fi;;
	*)
		print_usage
		exit 1;;
esac

exit 0
