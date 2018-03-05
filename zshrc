# Modules

autoload -U compinit promptinit colors
compinit
promptinit
colors

# History file

HISTFILE=$HOME/.histfile
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

if [ $USER != "root" ] && [ ! $SSH_CLIENT ]
then
	eval `keychain --eval --agents ssh -Q --quiet`
fi

# RVM/Ruby/Gem lazy loading
if [ -d $HOME/.rvm ]
then
	function rvm_load() {
		# Remove aliases
		unalias rvm 2> /dev/null
		for i in $(echo $rvm_bins); do unalias $i 2> /dev/null; done

		# Load RVM
		export PATH="$PATH:$HOME/.rvm/bin"
		[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

		# Chain original command
		eval "$@"
	}
	# Aliases for all RVM/Ruby/Gem bins
	alias rvm="rvm_load rvm"
	rvm_bins=$(find $HOME/.rvm/{gems,rubies}/*/bin/* -printf "%f\n" | uniq)
	for i in $(echo $rvm_bins); do alias $i="rvm_load $i"; done
fi

# NVM/Node/NPM lazy loading
if [ -d $HOME/.nvm ]
then
	function nvm_load {
		# Remove aliases
		unalias nvm 2> /dev/null
		for i in $(echo $nvm_bins); do unalias $i 2> /dev/null; done

		# Load NVM
		export NVM_DIR="$HOME/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

		# Chain original command
		eval "$@"
	}
	# Aliases for all NVM/Node bins
	alias nvm="nvm_load nvm"
	nvm_bins=$(find $HOME/.nvm/versions/node/*/bin/* -printf "%f\n" | uniq)
	for i in $(echo $nvm_bins); do alias $i="nvm_load $i"; done
fi

# Pyenv loading
if [ -d $HOME/.pyenv ]
then
	export PATH="$HOME/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

# Load Atom with RVM and NPM lazy loading
function atom_load() {
	unalias atom
	rvm_load
	nvm_load
	eval "atom $@"
}
alias atom="atom_load"

# Show how much memory is used by a command
function mem() {
	if [ $1 ]
	then
		ps -eo "rss,cmd" | grep "$1" | sed -e 's/^[ \t]*//' | cut -d ' ' -f 1 | while read i; do echo "+$(($i/1024)) Mio"; sum=$((sum+i)); done; echo "$1 mem usage : $((sum/1024)) Mio"; sum=0
	fi
}

# GitHub Pull Request
function pr() {
	git_dir=$(git rev-parse --git-dir 2> /dev/null)

	if [ "$git_dir" ]; then
		if [ "$#" -lt 1 ]; then; echo "Usage: pr <branch to merge> [branch to merge onto]"
		else
			if [ "$2" ]; then; onto="$2"
			else; onto="master"
			fi

			echo "$(git config --get remote.origin.url)/compare/$onto...$1"
		fi
	else; echo "Not in a Git repo"
	fi
}
