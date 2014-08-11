# randomize wallpaper from a wallpaper directory

#!/bin/sh

function print_usage {
	echo "Usage:"
	echo -e "carousel -l <wallpapers dir> (timer)\tLinear mode (wallpapers will be set in the same order as in the folder)"
	echo -e "carousel -r <wallpapers dir> (timer)\tRandom mode (wallpapers will be set in random order)"
	echo -e "carousel -h\t\t\t\tPrint this help message"
	echo "Info: timer is in seconds and is facultative (default to 10 minutes)"
}

if ! test $1 2> /dev/null
then
	print_usage
	exit 1;

elif ! test "$2"
then
	print_usage
	exit 1;

elif ! test -d "$2"
then
	echo "Wallpaper dir \"$2\" not found"
	exit 2
fi

if test $3
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
	-h)
		print_usage
		exit 0;;
	*)
		print_usage
		exit 1;;
esac

exit 0

#ajouter prise en compte d'images ajoutées pendant que script tourne
