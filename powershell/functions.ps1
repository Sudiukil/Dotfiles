function Update-Path {
  $MachinePath = @([System.Environment]::GetEnvironmentVariable("Path", "Machine").Split(";"))
  $UserPath = @([System.Environment]::GetEnvironmentVariable("Path", "User").Split(";"))
  $ShellPath = @(
    "$env:USERPROFILE\.bin",
    "$env:USERPROFILE\.dotfiles\bin\windows",
    "$env:USERPROFILE\.scripts\bin\windows",
    "$env:USERPROFILE\.opt\Vim\vim91"
  )
  $env:Path = ($MachinePath + $UserPath + $ShellPath | Select-Object -Unique) -Join ";"
}

function ln {
  param(
    [Parameter(Mandatory)] [string] $Target,
    [Parameter(Mandatory)] [string] $Symlink
  )

  New-Item -ItemType SymbolicLink -Path "$Symlink" -Target "$Target" -Force
}

function which {
  param(
    [Parameter(Mandatory)] [string] $Command
  )

  (Get-Command $Command).path
}

function stun {
  param(
    [Parameter(Mandatory)] [string] $Hostname
  )

  ssh -vTND 2222 $Hostname
}