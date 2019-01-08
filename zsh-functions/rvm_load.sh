# RVM/Ruby/Gem lazy loading
if [ -d $HOME/.rvm ]
then
  rvm_load() {
    # Remove aliases
    unalias rvm 2> /dev/null
    for i in $(echo $rvm_bins); do unalias $i 2> /dev/null; done

    # Load RVM
    export PATH="$PATH:$HOME/.rvm/bin"
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

    # Chain original command
    eval "$*"
  }
  
  # Aliases for all RVM/Ruby/Gem bins
  alias rvm="rvm_load rvm"
  rvm_bins=$(\find $HOME/.rvm/{gems,rubies}/*/bin/* -printf "%f\n" | uniq)
  for i in $(echo $rvm_bins); do alias $i="rvm_load $i"; done
fi
