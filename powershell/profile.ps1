# Get the profile dir
$ProfileDir = Split-Path $PROFILE -Parent

# Load functions and aliases
. "$ProfileDir\functions.ps1"
. "$ProfileDir\aliases.ps1"

# Refresh PATH (see functions.ps1)
Update-Path

# Exit on Ctrl+D
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

# Starship Shell
Invoke-Expression (&starship init powershell)