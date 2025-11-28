#!/bin/sh

# Existing commands
alias ls="ls --color=auto"
alias grep="grep --color -E"
alias rm="rm -I"
alias wget="wget -q --show-progress"

# Shell QoL
alias cs="cheatsheet" # See functions
alias renv="source ~/.zshenv && source ~/.zshrc"
alias path='echo $PATH'
alias trim="cut -c \"1-\$COLUMNS\""

# Dev stuff
alias getrvm="\curl -sSL https://get.rvm.io | bash -s stable"
alias getnvm="\curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash"
alias getpyenv="\curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash"
alias getsdkman="\curl -s 'https://get.sdkman.io?rcupdate=false' | bash"
alias getstarship="\curl -fsSL https://starship.rs/install.sh | sh"