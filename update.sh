#!/bin/sh

# Does a two way sync of the dotfiles by:
# - Pulling git changes and updating the links/copies to the local system
# - Pushing git changes to the repo (this requires git to use SSH with a key)
# To ensure a perfect sync, make sure to always edit you dotfiles from this repo

# Update from the repo
git pull -q

# Checkup
mkdir -p "$HOME/.config"
! [ -d "$USERPROFILE" ] && echo "ERROR: can't access Windows drive, aborting." && exit 1

# Linux
ln -sf "$PWD/zshrc" "$HOME/.zshrc"
ln -sf "$PWD/zshenv" "$HOME/.zshenv"
ln -sf "$PWD/aliases" "$HOME/.aliases"
ln -sf "$PWD/functions" "$HOME/.functions"
ln -sf "$PWD/gitconfig.linux" "$HOME/.gitconfig"

# Windows
cp ./Microsoft.PowerShell_profile.ps1 "$USERPROFILE/Documents/PowerShell/"
cp ./starship.toml "$USERPROFILE/.config/"
cp ./gitconfig.windows "$USERPROFILE/.gitconfig"
cp ./gitconfig.global "$USERPROFILE/.gitconfig.global"

# Windows <=> WSL sync
ln -sf "$USERPROFILE/.config/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$USERPROFILE/.gitconfig.global" "$HOME/.gitconfig.global"

printf "\nWARNING: Some files need to be copied/linked manually (possibly as root):
- wsl.conf -> /etc/wsl.conf
- windows_terminal.json -> via Windows Terminal

Reminder: some files were copied (not linked) and will need to be updated manually.
Also remember to correctly set WSLENV (Windows side, should include USERPROFILE and windir).

Tip: run this script via crontab!\n"

Update to the repo
git add -A
git commit -m "Update"
git push -q

exit 0
