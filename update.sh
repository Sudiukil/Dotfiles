#!/bin/sh

# Does a two way sync of the dotfiles by:
# - Pulling git changes and updating the links/copies to the local system
# - Pushing git changes to the repo (this requires git to use SSH with a key)
# To ensure a perfect sync, make sure to always edit your dotfiles from this repo

# Update from the repo
git pull -q

# Linux
mkdir -p "$HOME/.config"
ln -sf "$PWD/zshrc" "$HOME/.zshrc"
ln -sf "$PWD/zshenv" "$HOME/.zshenv"
ln -sf "$PWD/aliases" "$HOME/.aliases"
ln -sf "$PWD/functions" "$HOME/.functions"
ln -sf "$PWD/gitconfig.linux" "$HOME/.gitconfig"

if [ -d "$USERPROFILE" ]; then
  # Windows
  cp ./Microsoft.PowerShell_profile.ps1 "$USERPROFILE/Documents/PowerShell/"
  cp ./starship.toml "$USERPROFILE/.config/"
  cp ./gitconfig.windows "$USERPROFILE/.gitconfig"
  cp ./gitconfig.global "$USERPROFILE/.gitconfig.global"

  # Windows <=> WSL sync
  ln -sf "$USERPROFILE/.config/starship.toml" "$HOME/.config/starship.toml"
  ln -sf "$USERPROFILE/.gitconfig.global" "$HOME/.gitconfig.global"
else
  # Linux only if WSL isn't detected
  echo "WARNING: can't access Windows drive, linking Linux files only..."
  
  ln -sf "$PWD/starship.toml" "$HOME/.config/starship.toml"
  ln -sf "$PWD/gitconfig.global" "$HOME/.gitconfig.global"
fi

printf "\nWARNING: Some files need to be copied/linked manually (possibly as root):
- wsl.conf -> /etc/wsl.conf
- windows_terminal.json -> via Windows Terminal

Reminder: some files were copied (not linked) and will need to be updated manually.
Also remember to correctly set WSLENV (Windows side, should include USERPROFILE and windir).

Tip: run this script via crontab!\n\n"

# Update to the repo
[ "$1" = "-n" ] && exit 0 # lazy
git add -A
git commit -m "Update"
git push -q

exit 0
