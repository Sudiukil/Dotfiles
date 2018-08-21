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

function ret_code {
if [ $? != 0 ]
then
	echo "%{$fg[red]%}%B%?%b%{$reset_color%}"
else
	echo "%B%?%b"
fi
}

function ror_env {
	if [ $RAILS_ENV ]
	then
		echo "%{$fg[red]%}($RAILS_ENV)%{$reset_color%}"
	fi
}

export PROMPT="┌[$(host)]-[$(u_color):%~]"'$(git_branch)'""'$(ror_env)'"
└─────╸ "
export RPROMPT='$(ret_code)'" ╺┘"

# Plugins

. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Environment variables

[ -f $HOME/.envrc ] && ! [ $ENV_RC ] && . $HOME/.envrc

# Aliases and functions

[ -f $HOME/.aliases ] && . $HOME/.aliases
[ -d $HOME/.functions ] && for i in $HOME/.functions/*.sh; do . $i; done
