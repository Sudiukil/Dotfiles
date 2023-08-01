#!/bin/sh

# Does a two way sync of the dotfiles using git by:
# - Pulling remote changes and updating the links/copies on the local system
# - Pushing local changes to the repo (works best with a passwordless SSH key)
# To ensure a perfect sync, always edit the dotfiles from this repo and run this script to update them

# Pull updates
git pull -q

# Linux
mkdir -p "$HOME/.config"
ln -sf "$PWD/zshrc" "$HOME/.zshrc"
ln -sf "$PWD/zshrc.wsl" "$HOME/.zshrc.wsl"
ln -sf "$PWD/zshenv" "$HOME/.zshenv"
ln -sf "$PWD/aliases" "$HOME/.aliases"
ln -sf "$PWD/functions" "$HOME/.functions"
ln -sf "$PWD/gitconfig.linux" "$HOME/.gitconfig"
ln -sf "$PWD/rvmrc" "$HOME/.rvmrc"

if [ -d "$USERPROFILE" ]; then
  # Windows only files
  cp ./Microsoft.PowerShell_profile.ps1 "$USERPROFILE/Documents/PowerShell/"
  cp ./gitconfig.windows "$USERPROFILE/.gitconfig"

  # Common files
  cp ./starship.toml "$USERPROFILE/.config/"
  cp ./gitconfig.global "$USERPROFILE/.gitconfig.global"

  # Windows <=> Linux sync for the above files
  ln -sf "$USERPROFILE/.config/starship.toml" "$HOME/.config/starship.toml"
  ln -sf "$USERPROFILE/.gitconfig.global" "$HOME/.gitconfig.global"
else
  # Linux only if WSL isn't detected
  echo "WARNING: can't access Windows drive, linking Linux files only..."
  
  ln -sf "$PWD/starship.toml" "$HOME/.config/starship.toml"
  ln -sf "$PWD/gitconfig.global" "$HOME/.gitconfig.global"
fi

printf "\nWARNING: Some files need to be copied/linked manually (possibly as root/admin):
- wsl.conf -> /etc/wsl.conf
- windows_terminal.json -> via Windows Terminal

WARNING: some files were copied (not linked) and should be handled accordingly.
INFO: remember to correctly set WSLENV (should include 'USERPROFILE/p').
INFO: if using WSL, you might want to sync SSH keys too.
INFO: put this in crontab!\n"

# "Commit mode". Commits current changes before pushing.
# Allows for finer control of the sync (current state vs. staged state).
if [ "$1" = "-c" ]; then
  printf "\n"
  git add -A
  git commit -m "Update: $(git status --porcelain | cut -c 4- | xargs | sed -e 's/ /, /g')"
fi

# Push updates
git push -q

exit 0
