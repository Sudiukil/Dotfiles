# Modules

autoload -U compinit promptinit colors
compinit
promptinit
colors

# History file

export HISTFILE=$HOME/.histfile
export HISTSIZE=1000
export SAVEHIST=1000

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
	branch="$(git symbolic-ref --short HEAD 2> /dev/null)"
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

export PROMPT="┌[$(host)]-[$(u_color):%~]"'$(git_branch)'"
└─────╸ "
export RPROMPT='$(c_ret_code)'" ╺┘"

# Plugins

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Environment variables

export EDITOR="vim"

# Aliases and functions

source $HOME/.aliases

if [ -f $HOME/.privaliases ]; then
	source $HOME/.privaliases
fi

if [ -d $HOME/.shellfuncs ]; then
	for i in $HOME/.shellfuncs/*.sh; do source $i; done
fi

# User and machine specific conf

if [ $USER != "root" ] && [ ! $SSH_CLIENT ]
then
	eval "$(keychain --eval --agents ssh -Q --quiet)"
fi
