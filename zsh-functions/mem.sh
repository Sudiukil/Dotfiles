# Show how much memory is used by a command
function mem() {
	if [ $1 ]
	then
		ps -eo "rss,cmd" |
		grep "$1" |
		sed -e 's/^[ \t]*//' |
		cut -d ' ' -f 1 |
		while read i
		do
			echo "+$(($i/1024)) Mio"
			sum=$((sum+i))
		done

		echo "$1 mem usage : $((sum/1024)) Mio"
		unset sum
	fi
}
