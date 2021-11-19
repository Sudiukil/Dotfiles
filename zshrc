# Modules

autoload -U compinit promptinit colors
compinit
promptinit
colors

# History file

export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=$HOME/.histfile

setopt HIST_IGNORE_DUPS

# Key bindings

bindkey '^R' history-incremental-search-backward

# Plugins

. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Environment variables

[ -f $HOME/.envrc ] && [ "$ENV_USER" != "$USER" ] && . $HOME/.envrc

# Aliases and functions

[ -f $HOME/.aliases ] && . $HOME/.aliases
[ -f $HOME/.aliases.local ] && . $HOME/.aliases.local
[ -d $HOME/.functions ] && for i in $HOME/.functions/*.sh; do . $i; done

# Starship prompt
eval "$(starship init zsh)"

# Keychain config
eval "$(keychain --eval --agents ssh)"
