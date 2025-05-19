param (
    [string]$Filter = "",
    [ValidateSet("all", "install", "config")]
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

    $allPhases = @(
        @{ Name = "install"; Path = Join-Path $basePath "install" },
        @{ Name = "config"; Path = Join-Path $basePath "config" },
    )

    $selectedPhases = if ($Phase -eq "all") {
        $allPhases
    } else {
        $allPhases | Where-Object { $_.Name -eq $Phase }
    }

    foreach ($entry in $selectedPhases) {
        $phaseName = $entry.Name.ToUpper()
        $phasePath = Resolve-Path -Path $entry.Path

        Write-Host "PHASE: $phaseName — Searching in: $phasePath"

        $scripts = Get-ChildItem -Path $phasePath -Filter "*.ps1" -File

        foreach ($script in $scripts) {
            if ($Filter -and ($script.Name -notmatch $Filter)) {
                continue
            }

            Write-Host "RUNNING SCRIPT: $($script.FullName)"
            if (-not $DryRun) {
                & $script.FullName
            }
        }
    }
}

Invoke-PhaseScripts -Filter $Filter -Phase $Phase -DryRun:$DryRun
