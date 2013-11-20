#!/bin/bash

echo -e "\n----- Rapport de températures -----\n"

sensors | grep Core | cut -d '(' -f 1 | sed 's/Core/Température CPU Coeur/' | sed 's/+//'
echo ""

nvidia-smi -q -d temperature | grep Gpu | cut -d ':' -f 2 | sed 's/ /Température GPU:                 /' | sed 's/ C/.0°C/'
echo ""

echo -e "Température HDD (/dev/sda):      "`nc localhost 7634 | cut -d '|' -f 4`".0°C"
echo -e "Température HDD (/dev/sdb):      "`nc localhost 7634 | cut -d '|' -f 9`".0°C\n"

ssh -x quentin@192.168.1.28 '/opt/vc/bin/vcgencmd measure_temp' | sed 's/temp=/Température serveur:             /' | sed 's/'"'"'/°/'
echo ""

exit
