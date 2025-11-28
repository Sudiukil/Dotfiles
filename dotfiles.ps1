# Dotfiles management script for Windows installations
# Note: requires developer mode to be enabled in Windows settings

$SCRIPT_NAME = $PSCommandPath | Split-Path -Leaf

# Resolves the root directory of the script, with relative symlink support
function Resolve-DotfilesRoot {
  $Script = Get-Item $PSCommandPath

  # If the script is a symlink, resolve its target and return its parent directory
  if ($null -ne $Script.Target) {
    return $Script.Target | Resolve-Path | Split-Path -Parent
  }

  # Otherwise, return the parent directory of the script
  return $Script | Split-Path -Parent
}

# Deploys the Dotfiles
function Install-Dotfiles {
  $DotfilesRoot = Resolve-DotfilesRoot
  $PSProfileDir = Split-Path $PROFILE -Parent
  $ConfigDir = "$env:USERPROFILE\.config"
  $VSCodeUserDir = "$env:USERPROFILE\AppData\Roaming\Code\User"

  # Create config directory if it doesn't exist
  if (!(Test-Path "$ConfigDir")) {
    New-Item -ItemType Directory -Path "$ConfigDir"
  }

  # PowerShell config
  New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$DotfilesRoot/powershell/profile.ps1" -Force
  Get-ChildItem -Path "$DotfilesRoot/powershell" -Exclude "profile.ps1" | ForEach-Object {
    New-Item -ItemType SymbolicLink -Path "$PSProfileDir\$($_.Name)" -Target "$DotfilesRoot/powershell/$($_.Name)" -Force
  }

  # VSCode config
  New-Item -ItemType SymbolicLink -Path "$VSCodeUserDir/settings.json" -Target "$DotfilesRoot/vscode/settings.jsonc" -Force
  New-Item -ItemType SymbolicLink -Path "$VSCodeUserDir/keybindings.json" -Target "$DotfilesRoot/vscode/keybindings-windows.jsonc" -Force

  # Git config
  New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE/.gitconfig" -Target "$DotfilesRoot/misc/gitconfig" -Force

  # Starship config
  New-Item -ItemType SymbolicLink -Path "$ConfigDir/starship.toml" -Target "$DotfilesRoot/misc/starship.toml" -Force
}

# Create a symlink to this script in the user's .bin directory
function Install-Script {
  $DotfilesRoot = Resolve-DotfilesRoot
  $BinDir = "$env:USERPROFILE\.bin"

  if (!(Test-Path "$BinDir")) {
    New-Item -ItemType Directory -Path "$BinDir"
  }

  New-Item -Type SymbolicLink -Path "$BinDir\$SCRIPT_NAME" -Target "$DotfilesRoot/$SCRIPT_NAME" -Force
}

# Main script logic

if ($args[0] -eq "-d") {
  Install-Dotfiles
  Install-Script
}
else {
  Write-Host "Usage: dotfiles.ps1 [-d]"
  Write-Host "  -d: Deploy the dotfiles"
}