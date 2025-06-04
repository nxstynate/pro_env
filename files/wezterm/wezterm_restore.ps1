$weztermStatePath = "$HOME/pro-env/files/wezterm/sessions.json"

if (-not (Test-Path $weztermStatePath)) {
    Write-Host "No session to restore."
    exit 0
}

$sessions = Get-Content $weztermStatePath | ConvertFrom-Json

foreach ($session in $sessions) {
    $cwd = $session.cwd
    $workspace = $session.workspace
    wezterm cli spawn --new-window --cwd "$cwd" --workspace "$workspace"
}
