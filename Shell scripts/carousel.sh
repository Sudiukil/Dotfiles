#!/bin/sh

function print_usage() {
	echo "Usage: randomwall [-l|-r] [wallpapers dir] [timer] (timer is facultative (default to 10 minutes))"
	exit 1
}

if ! test $1 2> /dev/null
then
	print_usage

elif ! test "$2"
then
	print_usage

elif ! test -d "$2"
then
	echo "Wallpaper dir \"$2\" not found"
	exit 2
fi

if test $3
then
	timer=`echo "$3*60" | bc -l`
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
	*)
		print_usage;;
esac

exit 0

#ajouter prise en compte d'images ajoutées pendant que script tourne
