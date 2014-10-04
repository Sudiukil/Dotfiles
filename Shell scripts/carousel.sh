#!/bin/sh

# randomize wallpaper from a wallpaper directory

function print_usage {
echo "Usage:"
echo -e "${0##*/} -l <wallpapers dir> (timer)\tLinear mode (wallpapers will be set in the same order as in the folder)"
echo -e "${0##*/} -r <wallpapers dir> (timer)\tRandom mode (wallpapers will be set in random order)"
echo -e "${0##*/} -h\t\t\t\tPrint this help message"
echo "Info: timer is in seconds and is facultative (default to 10 minutes)"
}

if [ $# -lt 2 ]
then
	print_usage
	exit 1
fi

if ! [ -d "$2" ]
then
	echo "Wallpaper dir \"$2\" not found or not a directory"
	exit 2
fi

if [ $3 ]
then
	timer=$3
else
	timer=600
fi

if ! ls "$2"/*.jpg > /tmp/walllist 2> /dev/null
then
	if ! ls "$2"/*.png > /tmp/walllist 2> /dev/null
	then
		echo "No images found in dir \"$2\""
		exit 3
	fi
fi

ls "$2"/*.png >> /tmp/walllist 2> /dev/null

nb=`cat /tmp/walllist | wc -l`

case $1 in
	-l)
		while [ 1 ]
		do
			for i in `seq 1 $nb`
			do
				feh --bg-fill "`sed -n $i'p' /tmp/walllist`"
				sleep $timer
			done
		done;;
	-r)
		while [ 1 ]
		do
			random=$[($RANDOM % ($[$nb - 1] +1)) +1]
			feh --bg-fill "`sed -n $random'p' /tmp/walllist`"
			sleep $timer
		done;;
	-h) print_usage;;
	*)
		print_usage
		exit 1;;
esac

exit 0
