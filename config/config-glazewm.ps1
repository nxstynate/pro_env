$source = "$HOME/pro-env/files/glazewm/.glzr"  # Change to the source directory
$target = "$HOME/.glzr"  # Change to the target directory

# Check if something exists at the target path
if (Test-Path $target) {
    $existing = Get-Item $target -Force
    if ($existing.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        Write-Host "🔗 Existing symbolic link found at: $target — removing it."
    } else {
        Write-Host "⚠️ $target exists and is not a symlink — removing it anyway."
    }
    Remove-Item -Path $target -Recurse -Force
}

# Create new symbolic link
try {
    New-Item -ItemType SymbolicLink -Path $target -Target $source -Force
    Write-Host "✅ Created symbolic link at: $target"
}
catch {
    Write-Host "❌ Failed to create symbolic link: $_"
}
