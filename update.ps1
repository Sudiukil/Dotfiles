# PS1 one-shot alternative to update.sh
# For Windows-only setups

if (!(Test-Path ~/.config)) {
  New-Item -ItemType Directory -Path ~/.config
}

cp ./Microsoft.PowerShell_profile.ps1 $PROFILE
cp ./gitconfig.windows "$env:USERPROFILE/.gitconfig"
cp ./gitconfig.global "$env:USERPROFILE/.gitconfig.global"
cp ./starship.toml "$env:USERPROFILE/.config/starship.toml"