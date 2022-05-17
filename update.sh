#!/bin/sh

# Does a two way sync of the dotfiles by:
# - Pulling git changes and updating the links/copies to the local system
# - Pushing git changes to the repo (this requires git to use SSH with a key)
# To ensure a perfect sync, make sure to always edit you dotfiles from this repo

# Update from the repo
git pull -q

# Checkup
mkdir -p $HOME/.config

# Linux
ln -sf $PWD/zshrc $HOME/.zshrc
ln -sf $PWD/zshenv $HOME/.zshenv
ln -sf $PWD/aliases $HOME/.aliases
ln -sf $PWD/functions $HOME/.functions
ln -sf $PWD/gitconfig.linux $HOME/.gitconfig
ln -sf $PWD/gitconfig.global $HOME/.gitconfig.global
ln -sf $PWD/starship.toml $HOME/.config/starship.toml

# Update to the repo
git add -A
git commit -m "Update"
git push -q

exit 0
