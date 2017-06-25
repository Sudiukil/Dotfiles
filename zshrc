# Modules

autoload -U compinit promptinit colors
compinit
promptinit
colors

# History file

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt HIST_IGNORE_DUPS

# Prompt

setopt prompt_subst

function set_host_color {
if [ $HOST != "GW" -a $HOST != "GW-Mk2" ]
then
	echo "%{$fg[yellow]%}%B%M%b%{$reset_color%}"
else
	echo "%{$fg[cyan]%}%B%M%b%{$reset_color%}"
fi
}

function set_user_color {
if [ $USER = "root" ]
then
	echo "%{$fg[red]%}%B%n%b%{$reset_color%}"
else
	echo "%{$fg[green]%}%B%n%b%{$reset_color%}"
fi
}

function get_git_branch {
branch=`git symbolic-ref HEAD 2> /dev/null`
if [ $branch ]
then
	echo "%{$fg[blue]%}(${branch#refs/heads/})%{$reset_color%}"
fi
}

function set_return_code_color {
if [ $? != 0 ]
then
	echo "%{$fg[red]%}%B%?%b%{$reset_color%}"
else
	echo "%B%?%b"
fi
}

host='`set_host_color`'
user='`set_user_color`'
git_branch='`get_git_branch`'
return_code='`set_return_code_color`'

PROMPT="┌[$host]-[$user:%~]$git_branch
└─────╸ "
RPROMPT="$return_code ╺┘"

# Colors

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Environment variables

export EDITOR="vim"

eval `keychain --eval --agents ssh -Q --quiet`

# Aliases

source $HOME/.aliases

# Functions

function man {
env LESS_TERMCAP_md=$'\033[1;34m' \
	LESS_TERMCAP_us=$'\033[0;36m' \
	LESS_TERMCAP_so=$'\033[1;31m' \
	LESS_TERMCAP_mb=$'\033[0m' \
	LESS_TERMCAP_me=$'\033[0m' \
	LESS_TERMCAP_se=$'\033[0m' \
	LESS_TERMCAP_ue=$'\033[0m' \
	man "$@"
}

# User and machine specific conf

if [ $USER != "root" ]
then
	tasky | cowsay -f /usr/share/cowsay/cows/unipony-smaller.cow -n

	if [ -d "$HOME/.rvm" ]
	then
		export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
	fi

	if [ -d "$HOME/.nvm" ]
	then
		export NVM_DIR="$HOME/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	fi
fi
