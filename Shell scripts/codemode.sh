#!/bin/bash

if !(test $2)
then
	case $1 in
		-c|-c++) dir=~/Autre/Programmation/C/;;
		-web|-html|-css|-js|-php) dir=~/Autre/Programmation/HTML/;;
		-python|-py) dir=~/Autre/Programmation/Python/;;
	esac
else
	dir=$2
fi

case $1 in
	-c|-c++)
		urxvt -cd $dir -title "Dev - C/C++ - Code" & sleep 1

		if test -e $dir/Makefile
		then
			urxvt -cd $dir -title "Dev - C/C++ - Makefile" -e zsh -c "vim Makefile && zsh" & sleep 1
		else
			urxvt -cd $dir -title "Dev - C/C++ - Makefile" & sleep 1
		fi

		i3-msg split v && urxvt -cd $dir -title "Dev - C/C++ - Files & Execution" & sleep 1
		exit 0;;
	-web|-html|-css|-js|-php)
		urxvt -cd $dir -title "Dev - HTML - HTML code" & sleep 1
		urxvt -cd $dir -title "Dev - HTML - CSS code" & sleep 1
		i3-msg split v && urxvt -cd $dir -title "Dev - HTML/CSS - Files" & sleep 1
		exit 0;;
	-python|-py)
		urxvt -cd $dir -title "Dev - Python - Code" & sleep 1
		urxvt -cd $dir -title "Dev - Python - Interpreter" -e zsh -c "python && zsh" & sleep 1
		i3-msg split v && urxvt -cd $dir -title "Dev - Python - Files & Execution" & sleep 1
		exit 0;;
	*)
		echo "Args:"
		echo -e "C/C++:\t\t-c -c++"
		echo -e "Web:\t\t-web -html -css -js -php"
		echo -e "Python:\t\t-python -py"
		exit 1;;
esac
