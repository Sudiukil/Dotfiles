# Show how much memory is used by a command
function mem() {
  if [ $1 ]
  then
    echo "$1 mem usage:\n"

    ps -eo "rss,cmd" | sed -e 's/^[ \t]*//' | cut -d ' ' -f -2 | grep "$1" | while read data
  do
    mem=$(echo $data | cut -d ' ' -f 1)
    bin=$(echo $data | cut -d ' ' -f 2)
    if [ $sum ]; then echo -n '+'; fi
    echo "$(($mem/1024)) Mio ($bin)"
    sum=$((sum+mem))
  done

  echo "\nTotal $1 mem usage: $((sum/1024)) Mio"
  unset sum
fi
}
