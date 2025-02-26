# Dotfiles management script for Windows installations
# Note: requires developer mode to be enabled in Windows settings

# Deploys the Dotfiles
function deploy {
  $DotfilesRoot = Split-Path -Parent (Split-Path -Parent $PSCommandPath)
  $ProfileDir = Split-Path $PROFILE -Parent

  # Create config directory if it doesn't exist
  if (!(Test-Path "$env:USERPROFILE/.config")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE/.config"
  }

  # PowerShell config
  New-Item -ItemType SymbolicLink -Path $PROFILE -Target "$DotfilesRoot/powershell/profile.ps1" -Force
  Get-ChildItem -Path "$DotfilesRoot/powershell" -Exclude "profile.ps1" | ForEach-Object {
    New-Item -ItemType SymbolicLink -Path "$ProfileDir\$($_.Name)" -Target "$DotfilesRoot/powershell/$($_.Name)" -Force
  }

  # Git config
  New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE/.gitconfig" -Target "$DotfilesRoot/git/gitconfig.windows" -Force
  New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE/.gitconfig.global" -Target "$DotfilesRoot/git/gitconfig.global" -Force

  # Starship config
  New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE/.config/starship.toml" -Target "$DotfilesRoot/misc/starship.toml" -Force
}

# Checks the status of the dotfiles and writes it to a file
# Meant to be run as a scheduled task or in the background to avoid shell hangs
function checkStatus {
  $CurrentBranch = git rev-parse --abbrev-ref HEAD
  $UncommitedChanges = $true
  $UnpushedCommits = $true
  $UnpulledCommits = $true

  Set-Location "$env:USERPROFILE\.dotfiles"

  # Check for local uncommitted changes
  if (-Not (git status -s)) {
    $UncommitedChanges = $false
  }

  # Fetch the latest changes from the remote repository
  git fetch

  # Check for local unpushed commits
  if (-Not (git log origin/$CurrentBranch..HEAD --oneline)) {
    $UnpushedCommits = $false
  }

  # Check for remote changes that need to be pulled
  if (-Not (git log HEAD..origin/$CurrentBranch --oneline)) {
    $UnpulledCommits = $false
  }

  if ($UncommitedChanges -or $UnpushedCommits -or $UnpulledCommits) {
    Set-Content -Path C:\Temp\dotfiles_status.txt -Value "SYNCED"
  }
  else {
    Set-Content -Path C:\Temp\dotfiles_status.txt -Value "OUTDATED"
  }
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