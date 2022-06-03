# Refresh PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Exit on Ctrl+D
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

# Starship SHELL
Invoke-Expression (&starship init powershell)

# Functions
Function Stop-Docker {
    docker stop $(docker ps -aq)
    Get-Process *docker* | Stop-Process -Force
    wsl -t docker-desktop
    wsl -t docker-desktop-data
}

Function Start-Docker {
    Write-Output "Starting Docker service..."
    Start-Service com.docker.service
    Start-Sleep -Seconds 5
    Write-Output "Starting Docker Desktop (wait for GUI)..."
    & "C:\Program Files\Docker\Docker\Docker Desktop.exe"
}

Function Stop-DailyProcess {
    ps code | kill
    ps firefox | kill
    wsl keychain --clear
    wsl --shutdown
}
New-Alias -Name bye -Value Stop-DailyProcess