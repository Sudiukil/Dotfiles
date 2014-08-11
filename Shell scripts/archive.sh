# extract or create various type of archive

#!/bin/sh

function print_usage {
	echo "Usage:"
	echo -e "-x <archive>\t\tExtract archive"
	echo -e "-c <file> <archive>\tCreate archive (according to archive extension provided)"
	echo -e "-h\t\t\tPrint this help message"
	echo "Warning: only works for one archive and one file at a time"
}

case $1 in
	-x|x)
		if test -f "$2"
		then
			case $2 in
				*.tar|*.tar.*|*.tgz)
					tar xvf "$2"
					exit 0;;
				*.zip)
					unzip "$2"
					exit 0;;
				*.rar)
					unrar x "$2"
					exit 0;;
				*.jar)
					jar xvf "$2"
					exit 0;;
				*.7z)
					7z x "$2"
					exit 0;;
				*)
					echo "Error: "$2": bad file type (compatible types: tar(.*), zip, rar, jar, 7z)"
					exit 1;;
			esac
		else
			echo "Error: file "$2" not found or not a regular file"
			exit 1
		fi;;
	-c|c)
		if test -e "$2"
		then
			case $3 in
				*.tar|*.tar.*)
					tar cavf "$3" "$2"
					exit 0;;
				*.zip)
					zip -r "$3" "$2"
					exit 0;;
				*.jar)
					jar cvf "$3" "$2"
					exit 0;;
				*.7z)
					7z a "$3" "$2"
					exit 0;;
				*)
					echo "Error: "$3": bad file type (compatible types: tar(.*), zip, jar, 7z)"
					exit 1;;
			esac
		else
			echo "Error: file "$2" not found"
			exit 1
		fi;;
	-h|h)
		print_usage
		exit 0;;
	*)
		print_usage
		exit 1;;
esac
