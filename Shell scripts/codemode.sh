#!/bin/bash

case $1 in
	-c|-c++)
		urxvt -cd ~/Autre/Programmation/C/ -title "Dev - C/C++ - Code" & sleep 1
		urxvt -cd ~/Autre/Programmation/C/ -title "Dev - C/C++ - Makefile" & sleep 1
		i3-msg split v && urxvt -cd ~/Autre/Programmation/C/ -title "Dev - C/C++ - Files & Execution" & sleep 1
		exit 0;;
	-web|-html|-css|-js|-php)
		urxvt -cd ~/Autre/Programmation/HTML/ -title "Dev - HTML - HTML code" & sleep 1
		urxvt -cd ~/Autre/Programmation/HTML/ -title "Dev - HTML - CSS code" & sleep 1
		i3-msg split v && urxvt -cd ~/Autre/Programmation/HTML/ -title "Dev - HTML/CSS - Files" & sleep 1
		exit 0;;
	-python|-py)
		urxvt -cd ~/Autre/Programmation/Python/ -title "Dev - Python - Code" & sleep 1
		urxvt -cd ~/Autre/Programmation/Python/ -title "Dev - Python - Interpreter" -e python & sleep 1
		i3-msg split v && urxvt -cd ~/Autre/Programmation/Python/ -title "Dev - Python - Files & Execution" & sleep 1
		exit 0;;
	*)
		echo "Args:"
		echo -e "C/C++:\t\t-c -c++"
		echo -e "Web:\t\t-web -html -css -js -php"
		echo -e "Python:\t\t-python -py"
		exit 1;;
esac
