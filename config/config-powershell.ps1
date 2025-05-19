
$Dotfiles = @(
    @{Source="../files/powershell/Microsoft.PowerShell_profile.ps1"; Target="$PROFILE"}
    @{Source="../files/powershell/settings.json"; Target="$env:LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"}
    @{Source="../files/powershell/takuya.omp.json"; Target="$HOME/Documents/PowerShell/takuya.omp.json"}
)

foreach ($item in $Dotfiles) {
    $Source = $item.Source
    $Target = $item.Target

    $targetDir = Split-Path $Target
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force
    }

    if (Test-Path $Target) {
        Remove-Item -Path $Target -Force
        Write-Host "🗑️ Removed existing item at: Target"
    } 

    else {
      Write-Host "Cannot create Symbolic Link at: $Target"
    }

# Create the symbolic link
    New-Item -ItemType SymbolicLink -Path $Target -Target $Source -Force
    Write-Host "✅ Created symbolic link for Hello World at: $Target"
}
