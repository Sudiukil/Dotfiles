# Check if the dotnet command is available
if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
  Write-Output "dotnet command not found. Please install the .NET SDK."
  return
}

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  dotnet complete --position $cursorPosition "$commandAst" | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}

# Dotnet Suggest
# dotnet suggest script powershell > $env:USERPROFILE\Documents\PowerShell\dotnet-suggest-shim.ps1
# . $env:USERPROFILE\Documents\PowerShell\dotnet-suggest-shim.ps1
. (dotnet suggest script powershell)