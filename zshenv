# Path
export PATH=/bin:/sbin
export PATH=$PATH:/usr/bin:/usr/sbin
export PATH=$PATH:/usr/local/bin:/usr/local/sbin
export PATH=$PATH:$HOME/.bin

# Others
export EDITOR=vim
export ANDROID_HOME=/opt/android-sdk
export PROJECTS_DIR="$HOME/Projets/"
[ -x "$(which java)" ] && export JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 | grep "java.home" | cut -d '=' -f 2 | sed -e 's/ //g')
[ -n "$WSL_DISTRO_NAME" ] && export OSNAME="WSL/$WSL_DISTRO_NAME"

# WSL specific
export SCREENDIR=$HOME/.screen

# Ruby Version Manager
export PATH="$PATH:$HOME/.rvm/bin"
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
