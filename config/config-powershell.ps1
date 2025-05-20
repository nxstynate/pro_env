
$Dotfiles = @(
    @{Source="$HOME/pro-env/files/powershell/Microsoft.PowerShell_profile.ps1"; Target="$PROFILE"}
    @{Source="$HOME/pro-env/files/powershell/settings.json"; Target="$env:LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"}
    @{Source="$HOME/pro-env/files/powershell/takuya.omp.json"; Target="$HOME/Documents/PowerShell/takuya.omp.json"}
)

foreach ($item in $Dotfiles) {
    $Source = $item.Source
    $Target = $item.Target

    $targetDir = Split-Path $target
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force
    }

    if (Test-Path $target) {
        Remove-Item -Path $target -Force
        Write-Host "🗑️ Removed existing item at: $target"
    }

# Create the symbolic link
    try {
        New-Item -ItemType SymbolicLink -Path $target -Target $source -Force
        Write-Host "✅ Created symbolic link at: $target"
    }
    catch {
        Write-Host "❌ Failed to create symbolic link: $_"
    }
}

