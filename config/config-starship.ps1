$source = "$HOME/pro-env/files/starship/starship.toml"
$target = "$HOME/.config/starship.toml"

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
