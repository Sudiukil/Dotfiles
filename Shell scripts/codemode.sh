#!/bin/bash

if [ $1 == "-c" ]
then
	urxvt -title "Dev - C/C++ - Code" & sleep 1
	urxvt -title "Dev - C/C++ - Makefile" & sleep 1
	i3-msg split v && urxvt -title "Dev - C/C++ - Files & Execution" & sleep 1
elif [ $1 == "-html" ]
then
	urxvt -title "Dev - HTML - HTML code" & sleep 1
	urxvt -title "Dev - HTML - CSS code" & sleep 1
	i3-msg split v && urxvt -title "Dev - HTML/CSS - Files" & sleep 1
elif [ $1 == "-js" ]
then
	urxvt -title "Dev - JS - Main code" & sleep 1
	urxvt -title "Dev - JS - Secondary code" & sleep 1
	i3-msg split v && urxvt -title "Dev - JS - Files" & sleep 1
elif [ $1 == "-php" ]
then
	urxvt -title "Dev - PHP - Main code" & sleep 1
	urxvt -title "Dev - PHP - Secondary code" & sleep 1
	i3-msg split v && urxvt -title "Dev - PHP - Files" & sleep 1
elif [ $1 == "-python" ]
then
	urxvt -title "Dev - Python - Code" & sleep 1
	urxvt -title "Dev - Python - Interpreter" -e python & sleep 1
	i3-msg split v && urxvt -title "Dev - Python - Files & Execution" & sleep 1

fi

exit
