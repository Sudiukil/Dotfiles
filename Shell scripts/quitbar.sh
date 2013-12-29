#!/bin/bash

i3-nagbar -m "Menu d'extinction"\
	-b "Éteindre" "systemctl poweroff"\
	-b "Redémarrer" "systemctl reboot"\
	-b "Hiberner" "systemctl hibernate"\
	-b "Veille" "systemctl suspend"\
	-b "Hybride" "systemctl hybrid-sleep"\
	-b "Quitter i3" "i3-msg exit" &
sleep 5
killall i3-nagbar

exit 0
