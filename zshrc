#!/bin/sh

# Modules

autoload -U compinit promptinit colors
compinit
promptinit
colors

# History file

export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE="$HOME/.histfile"

setopt HIST_IGNORE_DUPS

# Key bindings

bindkey '^R' history-incremental-search-backward

# Plugins

. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases and functions

[ -f "$HOME/.aliases" ] && . "$HOME/.aliases"
[ -f "$HOME/.aliases.local" ] && . "$HOME/.aliases.local"
[ -f "$HOME/.functions" ] && . "$HOME/.functions"

# Starship prompt
eval "$(starship init zsh)"

# Keychain config
eval "$(keychain --eval --agents "ssh,gpg" --quiet)"

# WSL specific
[ -f "$HOME/.zshrc.wsl" ] && . "$HOME/.zshrc.wsl"

# Message queue (see scripts)
[ "$USER" != "root" ] && [ -x "$(which messages)" ] && messages -c