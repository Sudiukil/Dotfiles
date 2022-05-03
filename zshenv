# Token
export ENV_USER=$USER

# Path
export PATH=/bin:/sbin
export PATH=$PATH:/usr/bin:/usr/sbin
export PATH=$PATH:/usr/local/bin:/usr/local/sbin
export PATH=$PATH:$HOME/.bin

# Others
export EDITOR=vim
export ANDROID_HOME=/opt/android-sdk
export OSNAME="WSL/$WSL_DISTRO_NAME"
export PROJECTS_DIR="$HOME/Projets/"

# WSL specific
export SCREENDIR=$HOME/.screen

# Ruby Version Manager
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
