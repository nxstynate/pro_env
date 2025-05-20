echo 'No config for 3DSMax at the moment...'

$Dotfiles = @(
    @{Source="$HOME/pro-env/files/3dsmax/MaxStart.max"; Target="$HOME/documents/3ds Max 2022/scenes/MaxStart.max"}
    @{Source="$HOME/pro-env/files/3dsmax/mat_arroway_wood_veneers.mat"; Target="$HOME/documents/3ds Max 2022/scenes/mat_arroway_wood_veneers.mat"}
    @{Source="$HOME/pro-env/files/3dsmax/mat_base_004.mat"; Target="$HOME/documents/3ds Max 2022/scenes/mat_base_004.mat"}
    @{Source="$HOME/pro-env/files/3dsmax/mats_nate_lewis_001.mat"; Target="$HOME/documents/3ds Max 2022/scenes/mats_nate_lewis_001.mat"}
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

