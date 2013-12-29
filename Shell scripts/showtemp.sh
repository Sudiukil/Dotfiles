#!/bin/bash

echo -e "\n----- Rapport de températures -----\n"

sensors | grep Core | cut -d '(' -f 1 | sed 's/Core/Coeur CPU/' | sed 's/+/\t/'
echo ""

nvidia-smi -q -d temperature | grep Gpu | cut -d ':' -f 2 | sed 's/ /GPU:\t\t\t/' | sed 's/ C/.0°C/'
echo ""

echo -e "/dev/sda:\t\t"`nc localhost 7634 | cut -d '|' -f 4`".0°C"
echo -e "/dev/sdb:\t\t"`nc localhost 7634 | cut -d '|' -f 9`".0°C\n"

ssh -x quentin@192.168.1.28 '/opt/vc/bin/vcgencmd measure_temp' | sed 's/temp=/Serveur:\t\t/' | sed 's/'"'"'/°/'
echo ""

exit 0
