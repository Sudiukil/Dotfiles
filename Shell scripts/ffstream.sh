#!/bin/sh

# easily stream a file on localhost:2612/stream.ext with ffmpeg and ffserver

function print_usage {
echo "Usage:"
echo -e "${0##*/} <file>\tStream a file to localhost:2612/stream.file_ext"
echo -e "${0##*/} -h\tPrint this help message"
}

case $1 in
	-h) print_usage;;
	'')
		print_usage
		exit 1;;
	*)
		file_ext=${1##*.}

		case $file_ext in
			part)
				file_name=`echo $1 | sed -e 's/.part//'`
				file_ext=${file_name##*.};;
			*);;
		esac

		cp ~/Documents/ffserver.conf ffserver-tmp.conf
		sed -e 's/file_ext/'$file_ext'/' -e 's/file_name/'"$1"'/' -i ffserver-tmp.conf

		ffserver -f ffserver-tmp.conf;;
esac

exit 0
