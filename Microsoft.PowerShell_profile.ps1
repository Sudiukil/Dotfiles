# Refresh PATH
function Update-Path {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}
Update-Path

# Seriously, Microsoft?
function ln {
  param(
    [Parameter(Mandatory)] [string] $Source,
    [Parameter(Mandatory)] [string] $Symlink
  )

  New-Item -ItemType SymbolicLink -Path "$Symlink" -Target "$Source" -Force
}

# which hunting...
function which {
  param(
    [Parameter(Mandatory)] [string] $Command
  )

  (Get-Command $Command).path
}

# Aliases (I miss Linux...)
Set-Alias -name grep -Value Select-String

# Exit on Ctrl+D
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

# Starship Shell
Invoke-Expression (&starship init powershell)