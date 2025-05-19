
$source = "../files/starship.toml"
$target = "$HOME/.config/starship.toml"

$targetDir = Split-Path $target
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force
}

if (Test-Path $target) {
    Remove-Item -Path $target -Force
    Write-Host "🗑️ Removed existing item at: $target"
} 

else {
  Write-Host "Cannot create Symbolic Link at: $target"
}

# Create the symbolic link
New-Item -ItemType SymbolicLink -Path $target -Target $source -Force
Write-Host "✅ Created symbolic link for Hello World at: $target"
