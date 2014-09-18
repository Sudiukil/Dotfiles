#!/bin/sh

# switch keymap between two layout

keymap=`setxkbmap -query | grep layout | cut -d ':' -f 2 | sed -e 's/ //g'`

case $1 in
	-p)
		echo $keymap
		exit 1;;
	*);;
esac

case $keymap in
	fr)
		setxkbmap us
		exit 0;;
	us)
		setxkbmap fr
		exit 0;;
	*)
		setxkbmap fr
		exit 0;;
esac
