#!/bin/sh

# controls ncmpcpp or spotify depending on which is running (using ncmpcppctl and spotifyctl scripts)

ncmpcpp=0
spotify=0

if pgrep ncmpcpp > /dev/null
then
	ncmpcpp=1
fi

if pgrep spotify > /dev/null
then
	spotify=1
fi

if [ "$ncmpcpp" -eq "1" -a "$spotify" -ne "1" ]
then
	cmd="ncmpcppctl"
elif [ "$spotify" -eq "1" -a "$ncmpcpp" -ne "1" ]
then
	cmd="spotifyctl"
else
	cmd="ncmpcppctl"
fi

$cmd $1

exit 0
