#!/bin/sh

# cheat.sh shortcut
cheatsheet() {
  curl "http://cheat.sh/$1"
}

# Cut space-separated columns easily
col() {
  tr -s ' ' | cut -d ' ' -f "$1"
}
