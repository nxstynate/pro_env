
function Log {
    param (
        [string]$Message,
        [switch]$Dry
    )

    if ($Dry) {
        Write-Host "[DRY_RUN] $Message"
    } else {
        Write-Host "$Message"
    }
}

function RunPhase {
    param (
        [string]$Label,
        [string]$Directory,
        [string]$Grep = "",
        [switch]$DryRun
    )

    if (-not (Test-Path $Directory)) {
        return
    }

    $scripts = Get-ChildItem -Path $Directory -Filter "*.ps1" -File

    foreach ($script in $scripts) {
        if ($Grep -and ($script.Name -notmatch $Grep)) {
            Log "$Label: Skipping $($script.Name) due to grep filter" -Dry:$DryRun
            continue
        }

        Log "$Label: Running $($script.Name)" -Dry:$DryRun

        if (-not $DryRun) {
            try {
                & $script.FullName
            } catch {
                Write-Host "❌ ERROR in $($script.Name): $_"
            }
        }
    }
}
