#!/bin/sh

# Existing commands
alias ls="ls --color=auto"
alias grep="grep --color -E"
alias rm="rm -I"
alias wget="wget -q --show-progress"

# Shell QoL
alias renv="source ~/.zshenv && source ~/.zshrc"
alias path='echo $PATH'
alias syslog="tail -f /var/log/syslog"
alias cdw="cd \$USERPROFILE"
alias cs="cheatsheet" # See functions
alias trim="cut -c \"1-\$COLUMNS\""

# SSH
alias stun="ssh -vTND 2222"
alias unlock='bw get password "$USER@$HOST" | DISPLAY=:0 SSH_ASKPASS="$HOME/.ssh/askpass.sh" ssh-add "$HOME/.ssh/id_ed25519"'
alias lock="keychain --agents \"ssh\" --clear && killall ssh"

# Screen
alias sl="screen -ls"
alias ss="screen -S"
alias sd="screen -dmS"
alias sr="screen -r"
alias sw="screen -wipe"

# Dev stuff
alias getrvm="\curl -sSL https://get.rvm.io | bash -s stable"
alias getnvm="\curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash"
alias getpyenv="\curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash"
alias getsdkman="\curl -s 'https://get.sdkman.io?rcupdate=false' | bash"
alias getstarship="\curl -fsSL https://starship.rs/install.sh | sh"