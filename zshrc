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

function host {
	if [ $SSH_CLIENT ]
	then
		echo "%{$fg[yellow]%}%B%M (remote)%b%{$reset_color%}"
	else
		echo "%{$fg[cyan]%}%B%M%b%{$reset_color%}"
	fi
}

function u_color {
if [ $USER = "root" ]
then
	echo "%{$fg[red]%}%B%n%b%{$reset_color%}"
else
	echo "%{$fg[green]%}%B%n%b%{$reset_color%}"
fi
}

function git_branch {
	branch=$(git symbolic-ref --short HEAD 2> /dev/null)
	if [ $branch ]
	then
		echo "%{$fg[blue]%}($branch)%{$reset_color%}"
	fi
}

function c_ret_code {
if [ $? != 0 ]
then
	echo "%{$fg[red]%}%B%?%b%{$reset_color%}"
else
	echo "%B%?%b"
fi
}

PROMPT="┌[$(host)]-[$(u_color):%~]"'$(git_branch)'"
└─────╸ "
RPROMPT='$(c_ret_code)'" ╺┘"

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

if [ $USER != "root" -a ! $SSH_CLIENT ]
then
	tasky | cowsay -f /usr/share/cowsay/cows/unipony-smaller.cow -n
fi

# RVM/Ruby/Gem lazy loading
function rvm_load() {
	unalias rvm
	unalias ruby
	unalias gem
	export PATH="$PATH:$HOME/.rvm/bin"
	[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
	eval "$@"
}
alias rvm="rvm_load rvm"
alias ruby="rvm_load ruby"
alias gem="rvm_load gem"

# NVM/Node/NPM lazy loading
function nvm_load {
	unalias nvm
	unalias npm
	unalias node
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
	eval "$@"
}
alias nvm="nvm_load nvm"
alias npm="nvm_load npm"
alias node="nvm_load node"
