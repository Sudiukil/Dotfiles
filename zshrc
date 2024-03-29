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

zle -N fzf-file-widget
bindkey '^P' fzf-file-widget

# Plugins

. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases and functions

[ -f "$HOME/.aliases" ] && . "$HOME/.aliases"
[ -f "$HOME/.aliases.local" ] && . "$HOME/.aliases.local"
[ -f "$HOME/.functions" ] && . "$HOME/.functions"

# Tools
eval "$(starship init zsh)" # Starship
eval "$(direnv hook zsh)" # Direnv
eval "$(keychain --eval --agents "ssh" --quiet)" # Keychain
. /usr/share/doc/fzf/examples/key-bindings.zsh # FZF

# WSL specific
[ -f "$HOME/.zshrc.wsl" ] && . "$HOME/.zshrc.wsl"

# Current machine only
[ -f "$HOME/.zshrc.local" ] && . "$HOME/.zshrc.local"
