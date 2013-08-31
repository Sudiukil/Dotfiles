#!/bin/bash

echo -e "\n----- Temperature report -----\n"

sensors | grep Core | cut -d '(' -f 1 | sed 's/Core/CPU Core Temperature/' | sed 's/+//'
echo ""

nvidia-smi -q -d temperature | grep Gpu | cut -d ':' -f 2 | sed 's/ /GPU Temperature:                 /' | sed 's/ C/.0°C/'
echo ""

echo -e "HDD Temperature (/dev/sda):      "`nc localhost 7634 | cut -d '|' -f 4`".0°C"
echo -e "HDD Temperature (/dev/sdb):      "`nc localhost 7634 | cut -d '|' -f 9`".0°C\n"

ssh -x -p 443 sudiukil@192.168.1.28 '/opt/vc/bin/vcgencmd measure_temp' | sed 's/temp=/Server temperature:             /' | sed 's/'"'"'/°/'
echo ""

exit
