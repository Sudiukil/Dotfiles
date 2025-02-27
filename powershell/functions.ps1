function Update-Path {
  $MachinePath = @([System.Environment]::GetEnvironmentVariable("Path", "Machine").Split(";"))
  $UserPath = @([System.Environment]::GetEnvironmentVariable("Path", "User").Split(";"))
  $ShellPath = @(
    "$env:USERPROFILE\.bin",
    "$env:USERPROFILE\.dotfiles\bin",
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

function sudo {
  param(
    [Parameter(Mandatory, ValueFromRemainingArguments = $true)] [string[]] $Command
  )

  $Command = $Command -join " "
  Start-Process -FilePath "pwsh" -ArgumentList "-NoProfile -Command $Command; Start-Sleep 5" -Verb RunAs
}