function Update-Path {
  $MachinePath = @([System.Environment]::GetEnvironmentVariable("Path", "Machine").Split(";"))
  $UserPath = @([System.Environment]::GetEnvironmentVariable("Path", "User").Split(";"))
  $ShellPath = @(
    "$env:USERPROFILE\.bin"
  )
  $env:Path = ($ShellPath + $UserPath + $MachinePath | Select-Object -Unique) -Join ";"
}

function ctu {
  Invoke-WebRequest -useb "https://christitus.com/win" | Invoke-Expression
}