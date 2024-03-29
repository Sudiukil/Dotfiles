# Refresh PATH
function Update-Path {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}
Update-Path

# Exit on Ctrl+D
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

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

# Start a Windows app
function Start-WindowsApp {
  param (
    [Parameter(Mandatory)] [String] $AppName
  )
  Start-Process shell:$("AppsFolder\" + (Get-AppxPackage | ?{$_.PackageFamilyName -like "*$AppName*"}).PackageFamilyName + "!App")
}

# Aliases
Set-Alias -name grep -Value Select-String
Set-Alias -name clip -Value Set-Clipboard

# Starship Shell
Invoke-Expression (&starship init powershell)
