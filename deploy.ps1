# Deploy script for Windows installations

$PSCommandParent = Split-Path -Parent $PSCommandPath
$ProfileDir = Split-Path $PROFILE -Parent

# Create config directory if it doesn't exist
if (!(Test-Path "$env:USERPROFILE/.config")) {
  New-Item -ItemType Directory -Path "$env:USERPROFILE/.config"
}

# PowerShell config
New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$PSCommandParent/powershell/profile.ps1" -Force
Get-ChildItem -Path "$PSCommandParent/powershell" -Exclude "profile.ps1" | ForEach-Object {
  New-Item -ItemType SymbolicLink -Path "$ProfileDir\$($_.Name)" -Target "$PSCommandParent/powershell/$($_.Name)" -Force
}

# Git config
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE/.gitconfig" -Target "$PSCommandParent/git/gitconfig.windows" -Force
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE/.gitconfig.global" -Target "$PSCommandParent/git/gitconfig.global" -Force

# Starship config
New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE/.config/starship.toml" -Target "$PSCommandParent/starship.toml" -Force