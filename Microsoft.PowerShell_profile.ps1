# Refresh PATH
function Update-Path {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}
Update-Path

# Java shenanigans
function Set-JavaVersion {
  param(
    [Parameter(Mandatory)]
    [string] $Version
  )

  switch ($version) {
    default { echo "Invalid Java version. Available versions: 8, 11" }
    8 { $env:JAVA_HOME = "C:\\Program Files\\Amazon Corretto\\8" }
    11 { $env:JAVA_HOME = "C:\\Program Files\\Amazon Corretto\\11" }
  }

  Update-Path
}

# Exit on Ctrl+D
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

# Starship Shell
Invoke-Expression (&starship init powershell)