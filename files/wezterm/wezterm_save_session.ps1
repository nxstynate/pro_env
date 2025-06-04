$weztermStatePath = "$HOME/pro-env/files/wezterm/sessions.json"
$sessions = @()

# List current windows and tabs
$weztermList = wezterm cli list --format json | ConvertFrom-Json

foreach ($window in $weztermList) {
    foreach ($tab in $window.tabs) {
        $cwd = $tab.active_pane.cwd
        $workspace = $window.workspace

        $sessions += [pscustomobject]@{
            cwd = $cwd
            workspace = $workspace
        }
    }
}

# Save to file
$sessions | ConvertTo-Json -Depth 5 | Set-Content -Path $weztermStatePath -Encoding UTF8
