#!/bin/bash

if [ $1 == "-c" ]
then
	urxvt -cd ~/Autre/Programmation/C/ -title "Dev - C/C++ - Code" & sleep 1
	urxvt -cd ~/Autre/Programmation/C/ -title "Dev - C/C++ - Makefile" & sleep 1
	i3-msg split v && urxvt -cd ~/Autre/Programmation/C/ -title "Dev - C/C++ - Files & Execution" & sleep 1
elif [ $1 == "-html" ]
then
	urxvt -cd ~/Autre/Programmation/HTML/ -title "Dev - HTML - HTML code" & sleep 1
	urxvt -cd ~/Autre/Programmation/HTML/ -title "Dev - HTML - CSS code" & sleep 1
	i3-msg split v && urxvt -cd ~/Autre/Programmation/HTML/ -title "Dev - HTML/CSS - Files" & sleep 1
elif [ $1 == "-js" ]
then
	urxvt -cd ~/Autre/Programmation/JS/ -title "Dev - JS - Main code" & sleep 1
	urxvt -cd ~/Autre/Programmation/JS/ -title "Dev - JS - Secondary code" & sleep 1
	i3-msg split v && urxvt -cd ~/Autre/Programmation/JS/ -title "Dev - JS - Files" & sleep 1
elif [ $1 == "-php" ]
then
	urxvt -cd ~/Autre/Programmation/PHP/ -title "Dev - PHP - Main code" & sleep 1
	urxvt -cd ~/Autre/Programmation/PHP/ -title "Dev - PHP - Secondary code" & sleep 1
	i3-msg split v && urxvt -cd ~/Autre/Programmation/PHP/ -title "Dev - PHP - Files" & sleep 1
elif [ $1 == "-python" ]
then
	urxvt -cd ~/Autre/Programmation/Python/ -title "Dev - Python - Code" & sleep 1
	urxvt -cd ~/Autre/Programmation/Python/ -title "Dev - Python - Interpreter" -e python & sleep 1
	i3-msg split v && urxvt -cd ~/Autre/Programmation/Python/ -title "Dev - Python - Files & Execution" & sleep 1

fi

exit
