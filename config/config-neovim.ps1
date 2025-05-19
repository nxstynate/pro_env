
$source = "../files/neovim/nvim"  # Change to the source directory
$target = "$HOME/AppData/Local/nvim"  # Change to the target directory

$targetDir = Split-Path $target
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force
}

if (Test-Path $target) {
    Remove-Item -Path $target -Recurse -Force  # Use -Recurse for directories
    Write-Host "🗑️ Removed existing directory at: $target"
}

# Create the symbolic link for the directory
New-Item -ItemType SymbolicLink -Path $target -Target $source -Force
Write-Host "✅ Created symbolic link for directory at: $target"
