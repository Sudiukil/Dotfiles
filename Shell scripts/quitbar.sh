#!/bin/bash

i3-nagbar -m "Menu d'extinction"\
	-b "Éteindre" "systemctl poweroff"\
	-b "Redémarrer" "systemctl reboot"\
	-b "Hiberner" "i3lock -i ~/.lockscreen.png && sleep 2 && systemctl hibernate"\
	-b "Veille" "i3lock -i ~/.lockscreen.png && sleep 2 && systemctl suspend"\
	-b "Hybride" "i3lock -i ~/.lockscreen.png && sleep 2 && systemctl hybrid-sleep"\
	-b "Quitter i3" "i3-msg exit" &
sleep 5
killall i3-nagbar

exit
