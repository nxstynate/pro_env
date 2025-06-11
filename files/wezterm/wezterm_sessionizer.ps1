# Set paths
$HOME = "$env:USERPROFILE"
$configHOME = $env:XDG_CONFIG_HOME
if (-not $configHOME) { $configHOME = Join-Path $HOME ".config" }
$configDir = Join-Path $configHOME "wezterm-sessionizer"
$configFile = Join-Path $configDir "wezterm-sessionizer.conf"

# Defaults
$TS_SEARCH_PATHS = @("X:/Dropbox/1_Projects/", "X:/LocalProduction/", "X:/Dropbox/2_Library/", "X:/GoogleDriveBlackout")
$TS_EXTRA_SEARCH_PATHS = @()
$TS_MAX_DEPTH = 2

# Load config if it exists
if (Test-Path $configFile) {
    Get-Content $configFile | ForEach-Object {
        if ($_ -match "^\s*TS_SEARCH_PATHS=\((.+?)\)") {
            $TS_SEARCH_PATHS = $matches[1] -split "\s+" | ForEach-Object { $_.Trim("`"","'") }
        } elseif ($_ -match "^\s*TS_EXTRA_SEARCH_PATHS=\((.+?)\)") {
            $TS_EXTRA_SEARCH_PATHS = $matches[1] -split "\s+" | ForEach-Object { $_.Trim("`"","'") }
        } elseif ($_ -match "^\s*TS_MAX_DEPTH=(\d+)") {
            $TS_MAX_DEPTH = [int]$matches[1]
        }
    }
    $TS_SEARCH_PATHS += $TS_EXTRA_SEARCH_PATHS
}

# Check dependencies
if (-not (Get-Command "fzf" -ErrorAction SilentlyContinue)) {
    Write-Host "fzf is not installed. Please install it first." -ForegroundColor Red
    exit 1
}

if (-not (Get-Command "wezterm" -ErrorAction SilentlyContinue)) {
    Write-Host "wezterm CLI is not installed. Please install it first." -ForegroundColor Red
    exit 1
}

# Function to find directories
function Find-Dirs {
    foreach ($entry in $TS_SEARCH_PATHS) {
        if ($entry -match "^(.*):(\d+)$") {
            $path = $matches[1]
            $depth = [int]$matches[2]
        } else {
            $path = $entry
            $depth = $TS_MAX_DEPTH
        }

        if (Test-Path $path) {
            Get-ChildItem -Path $path -Recurse -Directory -Depth $depth -ErrorAction SilentlyContinue |
                Where-Object { $_.FullName -notmatch '\\\.git\\?$' } |
                Select-Object -ExpandProperty FullName
        }
    }
}

# Directory selection
if ($args.Count -eq 1) {
    $selected = $args[0]
} else {
    $selected = Find-Dirs | fzf
}

if (-not $selected) { exit 0 }

# Strip TMUX label if present
if ($selected -match "^\[TMUX\]\s+(.+)$") {
    $selected = $matches[1]
}

# Normalize workspace name
$workspaceName = (Split-Path $selected -Leaf) -replace '[^a-zA-Z0-9]', '_'

# Launch WezTerm in the selected folder
wezterm cli spawn --new-window --cwd "$selected" --workspace "$workspaceName"
