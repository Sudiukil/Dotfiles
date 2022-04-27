#!/bin/sh

# Checkup
mkdir -p $HOME/.config
! [ -d "$USERPROFILE" ] && echo "ERROR: can't access Windows drive, aborting." && exit 1

# Linux
ln -sf $PWD/zshrc $HOME/.zshrc
ln -sf $PWD/zshenv $HOME/.zshenv
ln -sf $PWD/aliases $HOME/.aliases
ln -sf $PWD/gitconfig.linux $HOME/.gitconfig

# Windows
cp ./Microsoft.PowerShell_profile.ps1 $USERPROFILE/Documents/PowerShell/
cp ./starship.toml $USERPROFILE/.config/
cp ./gitconfig.windows $USERPROFILE/.gitconfig
cp ./gitconfig.global $USERPROFILE/.gitconfig.global

# Windows <=> WSL sync
ln -sf $USERPROFILE/.config/starship.toml $HOME/.config/starship.toml
ln -sf $USERPROFILE/.gitconfig.global $HOME/.gitconfig.global

echo "\nWARNING: Some files need to be copied/linked manually (possibly as root):
- wsl.conf -> /etc/wsl.conf
- windows_terminal.json -> via Windows Terminal"

echo "Reminder: some files were copied (not linked) and will need to be updated manually."

exit 0
