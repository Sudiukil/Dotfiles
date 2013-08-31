#!/bin/bash

if [ "$1" == "-c" ]
then
	cd ~/Other/Code/C/
	urxvt -title "Dev - C/C++ - Code" & sleep 1
	urxvt -title "Dev - C/C++ - Makefile" & sleep 1
	i3-msg split v && urxvt -title "Dev - C/C++ - Files & Execution" & sleep 1
elif [ "$1" == "-p" ]
then
	cd ~/Other/Code/Python/
	urxvt -title "Dev - Python - Code" & sleep 1
	urxvt -title "Dev - Python - Interpreter" & sleep 1
	i3-msg split v && urxvt -title "Dev - Python - Files & Execution" & sleep 1
elif [ "$1" == "-h" ]
then
	cd ~/Other/Code/HTML-CSS/
	urxvt -title "Dev - HTML - Code" & sleep 1
	urxvt -title "Dev - CSS - Code" & sleep 1
	i3-msg split v && urxvt -title "Dev - HTML/CSS - Files" & sleep 1

else
	echo "You have to choose a language..."

fi

exit
