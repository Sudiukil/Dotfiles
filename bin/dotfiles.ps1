# Dotfiles management script for Windows installations
# Note: requires developer mode to be enabled in Windows settings

# Deploys the Dotfiles
function deploy {
  $DotfilesRoot = Split-Path -Parent (Split-Path -Parent $PSCommandPath)
  $PSProfileDir = Split-Path $PROFILE -Parent
  $VSCodeUserDir = "$env:USERPROFILE\AppData\Roaming\Code\User"

  # Create config directory if it doesn't exist
  if (!(Test-Path "$env:USERPROFILE/.config")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE/.config"
  }

  # PowerShell config
  New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$DotfilesRoot/powershell/profile.ps1" -Force
  Get-ChildItem -Path "$DotfilesRoot/powershell" -Exclude "profile.ps1" | ForEach-Object {
    New-Item -ItemType SymbolicLink -Path "$PSProfileDir\$($_.Name)" -Target "$DotfilesRoot/powershell/$($_.Name)" -Force
  }

  # VSCode config
  New-Item -ItemType SymbolicLink -Path "$VSCodeUserDir/settings.json" -Target "$DotfilesRoot/vscode/settings.jsonc" -Force
  New-Item -ItemType SymbolicLink -Path "$VSCodeUserDir/keybindings.json" -Target "$DotfilesRoot/vscode/keybindings.jsonc" -Force

  # Git config
  New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE/.gitconfig" -Target "$DotfilesRoot/misc/gitconfig" -Force

  # Starship config
  New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE/.config/starship.toml" -Target "$DotfilesRoot/misc/starship.toml" -Force
}

# Checks the status of the dotfiles and writes it to a file
# Meant to be run as a scheduled task or in the background to avoid shell hangs
function checkStatus {
  $CurrentBranch = git rev-parse --abbrev-ref HEAD
  $Changes = $false

  Set-Location "$env:USERPROFILE\.dotfiles"

  # Check for local uncommitted changes
  if (git status -s) { $Changes = $true }

  # Fetch the latest changes from the remote repository
  git fetch

  # Check for local unpushed commits
  if (git log origin/$CurrentBranch..HEAD) { $Changes = $true }

  # Check for remote changes that need to be pulled
  if (git log HEAD..origin/$CurrentBranch) { $Changes = $true }

  if ($Changes) { Set-Content -Path C:\Temp\dotfiles_status.txt -Value "OUTDATED" }
  else { Set-Content -Path C:\Temp\dotfiles_status.txt -Value "SYNCED" }
}

# Show a warning if the dotfiles are outdated
function statusWarning {
  $Status = Get-Content -Path C:\Temp\dotfiles_status.txt
  if ($Status -eq "OUTDATED") {
    Write-Host "WARN: Dotfiles are outdated." -ForegroundColor Yellow
  }
}

if ($args[0] -eq "-d") {
  deploy
}
elseif ($args[0] -eq "-c") {
  checkStatus
}
elseif ($args[0] -eq "-w") {
  statusWarning
}
else {
  Write-Host "Usage: dotfiles.ps1 [-d | -c | -w]"
  Write-Host "  -d: Deploy the dotfiles"
  Write-Host "  -c: Check the status of the dotfiles"
  Write-Host "  -w: Show a warning if the dotfiles are outdated"
}