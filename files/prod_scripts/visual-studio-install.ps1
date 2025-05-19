# Set script to stop on errors
$ErrorActionPreference = "Stop"

# Define download URL and installer path
$vsInstallerUrl = "https://aka.ms/vs/17/release/vs_community.exe"
$vsInstallerPath = "$env:TEMP\vs_community.exe"
$vsInstallPath = "C:\Program Files\Microsoft Visual Studio\2022\Community"

Write-Host "Downloading Visual Studio 2022 Community Installer..."
Invoke-WebRequest -Uri $vsInstallerUrl -OutFile $vsInstallerPath

Write-Host "Starting Visual Studio installation..."

# Start the installation
Start-Process -FilePath $vsInstallerPath -ArgumentList @(
    "--quiet",
    "--wait",
    "--norestart",
    "--nocache",
    "--installPath `"$vsInstallPath`"",
    "--add Microsoft.VisualStudio.Workload.NativeDesktop",
    "--add Microsoft.VisualStudio.Component.VC.Tools.x86.x64",
    "--add Microsoft.VisualStudio.Component.Windows10SDK.19041",
    "--includeRecommended"
) -Wait -NoNewWindow

Write-Host "Visual Studio 2022 installation complete."
