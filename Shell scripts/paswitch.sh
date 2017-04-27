#!/bin/sh

# Wrapper to switch easily all inputs between PulseAudio sinks

print_usage() {
	echo "Usage:"
	echo "${0##*/} -o|--outputs\t\t\tList PulseAudio \"sinks\""
	echo "${0##*/} -i|--inputs\t\t\tList PulseAudio \"inputs\""
	echo "${0##*/} -s|--set-output <output id>\tSet PulseAudio \"sink\" as default and move all \"input\" to it"
	echo "${0##*/} -c|--cycle\t\t\tCycle through all PulseAudio \"sinks\""
	echo "${0##*/} -h|--help\t\t\tShow this help message"
}

case $1 in
	-o|--outputs)
		pacmd list-sinks | grep -e "index" -e "device\.desc" | sed -e 'N;s/\n//g' -e 's/\t/ /g' | cut -d ':' -f 2 | cut -d ' ' -f 2,6-;;
	-i|--inputs)
		pacmd list-sink-inputs | grep -e "index" -e "application\.name" | sed -e 'N;s/\n//g' -e 's/\t/ /g' | cut -d ' ' -f 6,10-;;
	-s|--set-output)
		if [ $2 ]
		then
			pacmd set-default-sink $2
			for i in $($0 -i | cut -d ' ' -f 1)
			do
				pacmd move-sink-input $i $2
			done
		else
			print_usage
		fi;;
	-c|--cycle)
		max=$($0 -o | cut -d ' ' -f 1 | sort -n | tail -1)
		current=$(pacmd list-sinks | grep "index" | grep "\*" | rev | cut -d ' ' -f 1)
		$0 -s $(((current+1)%(max+1)));;
	-h|--help)
		print_usage;;
	*)
		print_usage
		exit 1;;
esac

exit 0
