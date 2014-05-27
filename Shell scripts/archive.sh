#!/bin/sh

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
					echo "Erreur : format incorrect (supporté : tar(.*), zip, rar, jar, 7z)"
					exit 1;;
			esac
		else
			echo "Archive non trouvée ou format non reconnu"
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
					echo "Erreur : format incorrect (supporté : tar(.*), zip, jar, 7z)"
					exit 1;;
			esac
		else
			echo "Fichier à compresser non trouvé ou commande incorrecte"
			exit 1
		fi;;
	*)
		echo -e "Usage :\n"
		echo -e "-x|x <archive>\t\t\tExtraire l'archive"
		echo -e "-c|c <fichier> <archive>\tCompresser le fichier en archive (selon extension)"
		echo -e "Attention : ne fonctionne que pour une archive et un fichier à la fois"
		exit 0;;
esac
