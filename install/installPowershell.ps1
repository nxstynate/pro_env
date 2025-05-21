# Define the URL of the MSI file

$url = "https://github.com/PowerShell/PowerShell/releases/download/v7.5.1/PowerShell-7.5.1-win-x64.msi" # Paste the URL you copied from GitHub

# Define the local path where you want to save the MSI file
$outputPath = "$home/downloads/PowerShellInstaller.msi" # Saves to your temporary directory

# Download the file
Write-Host "Downloading PowerShell MSI from: $url"
try {
    Invoke-WebRequest -Uri $url -OutFile $outputPath -TimeoutSec 300 # 5 minutes timeout
    Write-Host "Download complete. MSI saved to: $outputPath"
}
catch {
    Write-Error "Failed to download the MSI file: $($_.Exception.Message)"
}

# You can then proceed to install it silently after the download:
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$outputPath`" /qn" -Wait
Write-Host "PowerShell installation initiated silently."
