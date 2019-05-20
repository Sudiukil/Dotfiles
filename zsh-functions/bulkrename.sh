# Bulk rename file (replace first arg by second arg)
function bulkrename() {
  if ! [ "$1" ]
  then
    echo "Require at least one arg (what to replace). Second arg (by what to replace) is optionnal"
  else
    arg1="$(echo $1 | sed -e 's/\[/\\[/' -e 's/\]/\\]/')"
    arg2="$(echo $2 | sed -e 's/\[/\\[/' -e 's/\]/\\]/')"
    \ls | while read i; do mv "$i" "$(echo $i | sed -e 's/'"$arg1"'/'"$arg2"'/')"; done
  fi
}
