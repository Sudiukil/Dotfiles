function Update-Path {
  $MachinePath = @([System.Environment]::GetEnvironmentVariable("Path", "Machine").Split(";"))
  $UserPath = @([System.Environment]::GetEnvironmentVariable("Path", "User").Split(";"))
  $ShellPath = @(
    "$env:USERPROFILE\.bin"
  )
  $env:Path = ($ShellPath + $UserPath + $MachinePath | Select-Object -Unique) -Join ";"
}

function Start-ChrisTitusWinUtil {
  Invoke-WebRequest -useb "https://christitus.com/win" | Invoke-Expression
}

function Get-CheatSheet {
  param(
    [string]$Topic
  )

  curl "https://cheat.sh/$Topic"
}