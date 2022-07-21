# Refresh PATH
function Update-Path {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}
Update-Path

# Java shenanigans
function Set-JavaVersion {
  param(
    [string] $Version,
    [switch] $Persist
  )

  switch ($version) {
    default { echo "Missing or invalid Java version. Available versions: 8, 11"; return }
    8 { $env:JAVA_HOME = "C:\\Program Files\\Amazon Corretto\\8" }
    11 { $env:JAVA_HOME = "C:\\Program Files\\Amazon Corretto\\11" }
    17 { $env:JAVA_HOME = "C:\\Program Files\\Amazon Corretto\\17" }
  }

  if ($Persist) {
    New-Item -ItemType SymbolicLink -Path "C:\Program Files\Amazon Corretto\default" -Target $env:JAVA_HOME -Force
  }

  Update-Path
  java -version
}

# Exit on Ctrl+D
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

# Starship Shell
Invoke-Expression (&starship init powershell)