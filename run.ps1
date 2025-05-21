param (
    [string]$Filter = "",
    [ValidateSet("all", "install", "config", "uninstall")]
    [string]$Phase = "all",
    [switch]$DryRun
)

function Invoke-PhaseScripts {
    param (
        [string]$Filter,
        [string]$Phase,
        [switch]$DryRun
    )

    $basePath = "..\pro-env"

    # Only include uninstall if it's explicitly requested
    $allPhases = @()
    switch ($Phase) {
        "all" {
            $allPhases = @(
                @{ Name = "install"; Path = Join-Path $basePath "install" },
                @{ Name = "config"; Path = Join-Path $basePath "config" }
            )
        }
        "install" {
            $allPhases = @(
                @{ Name = "install"; Path = Join-Path $basePath "install" }
            )
        }
        "config" {
            $allPhases = @(
                @{ Name = "config"; Path = Join-Path $basePath "config" }
            )
        }
        "uninstall" {
            $allPhases = @(
                @{ Name = "uninstall"; Path = Join-Path $basePath "uninstall" }
            )
        }
    }

    foreach ($entry in $allPhases) {
        $phaseName = $entry.Name.ToUpper()
        $phasePath = Resolve-Path -Path $entry.Path

        Write-Host "PHASE: $phaseName — SEARCHING IN: $phasePath"

        $scripts = Get-ChildItem -Path $phasePath -Filter "*.ps1" -File

        foreach ($script in $scripts) {
            if ($Filter -and ($script.Name -notmatch $Filter)) {
                continue
            }

            Write-Host "Running Script: $($script.FullName)"
            if (-not $DryRun) {
                & $script.FullName
            }
        }
    }
}

Invoke-PhaseScripts -Filter $Filter -Phase $Phase -DryRun:$DryRun
