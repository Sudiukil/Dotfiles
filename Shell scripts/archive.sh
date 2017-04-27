#!/bin/sh

# extract or create various type of archive

print_usage() {
	echo "Usage:"
	echo "${0##*/} -x <archive>\t\tExtract archive"
	echo "${0##*/} -c <file> <archive>\tCreate archive (according to archive extension provided)"
	echo "${0##*/} -h\t\t\tPrint this help message"
	echo "Warning: only works for one archive and one file at a time for compression (-c)"
}

case $1 in
	-x|x)
		if [ $# -ge 2 ]
		then
			for arg in $*
			do
				if [ $arg = $1 ]
				then
					continue
				fi
				case $arg in
					*.tar|*.tar.*|*.tgz) tar xvf "$arg";;
					*.zip) unzip "$arg";;
					*.rar) unrar x "$arg";;
					*.jar) jar xvf "$arg";;
					*.7z) 7z x "$arg";;
					*)
						echo "Error: $arg: bad file type (compatible types: tar(.*), zip, rar, jar, 7z)"
						exit 1;;
				esac
			done
		else
			echo "Error: file $2 not found or not a regular file"
			exit 1
		fi;;
	-c|c)
		if [ -e "$2" ]
		then
			case $3 in
				*.tar|*.tar.*) tar cavf "$3" "$2";;
				*.zip) zip -r "$3" "$2";;
				*.jar) jar cvf "$3" "$2";;
				*.7z) 7z a "$3" "$2";;
				*)
					echo "Error: $3: bad file type (compatible types: tar(.*), zip, jar, 7z)"
					exit 1;;
			esac
		else
			echo "Error: file $2 not found"
			exit 1
		fi;;
	-h|h) print_usage;;
	*)
		print_usage
		exit 1;;
esac

exit 0
