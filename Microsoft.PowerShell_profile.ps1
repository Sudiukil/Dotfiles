# Refresh PATH
function Update-Path {
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
  if ($env:Path -notlike "*$env:USERPROFILE\.bin*") {
    $env:Path += ";" + "$env:USERPROFILE\.bin"
  }
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

function sudo {
  param(
    [Parameter(Mandatory, ValueFromRemainingArguments = $true)] [string[]] $Command
  )

  $Command = $Command -join " "
  Start-Process -FilePath "pwsh" -ArgumentList "-NoProfile -Command $Command; Start-Sleep 5" -Verb RunAs
}

# Aliases
Set-Alias -name grep -Value Select-String
Set-Alias -name clip -Value Set-Clipboard

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  dotnet complete --position $cursorPosition "$commandAst" | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}

# Dotnet Suggest
dotnet suggest script powershell > $env:USERPROFILE\Documents\PowerShell\dotnet-suggest-shim.ps1
. $env:USERPROFILE\Documents\PowerShell\dotnet-suggest-shim.ps1

# Starship Shell
Invoke-Expression (&starship init powershell)
