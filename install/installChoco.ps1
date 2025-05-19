# installs choco package manager

function Installchoco {
    $chocoPath = Get-Command choco -ErrorAction SilentlyContinue

    if ($chocoPath) {
        Write-Host "choco is installed.  Path: $($chocoPath.Definition)" -ForegroundColor Green
    }
    else {
        Write-Host "choco is not installed now installing..." -ForegroundColor Red
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }

  }

Installchoco
