#!/bin/sh

# lazy script to share ncmpcpp/spotify music with the youtube plebs :)

xdg-open "https://www.youtube.com/results?search_query=$(mediactl rawinfo | sed -e 's/ /%20/g')" &

exit 0
