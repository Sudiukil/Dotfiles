#!/bin/sh

# cheat.sh shortcut
cheatsheet() {
  curl "http://cheat.sh/$1"
}

# Grep processes, excluding the grep process with grep (grep!)
pgrep() {
  ps -axo "user,pid,%cpu,%mem,start,command" | head -n 1 # for the header
  # shellcheck disable=SC2009
  ps -axo "user,pid,%cpu,%mem,start,command" | grep -v grep | grep "$1" | trim # see aliases for trim
}

# Cut space-separated columns easily
col() {
  tr -s ' ' | cut -d ' ' -f "$1"
}