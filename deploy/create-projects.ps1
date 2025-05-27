$cgProduction = "cg-production"
$gitRepo = "https://github.com/nxstynate"
$repoURL = "$gitRepo/$cgProduction"
$localRoot = "X:\LocalProduction"
$dropboxRoot = "X:\Dropbox\1_Projects\BlackoutLLC"
$dateFormat = "yyMMdd"

function Get-FormattedDatePrefix {
    return Get-Date -Format "$dateFormat"
}

function Get-NextProjectIndex {
    param ([string]$datePrefix)

    $existingProjects = Get-ChildItem -Path $dropboxRoot -Directory |
        Where-Object { $_.Name -like "$datePrefix.*" }

    if ($existingProjects) {
        $foundIndices = @() # Initialize an array to hold found indices

        foreach ($project in $existingProjects) {
            # FIXED: Escape the datePrefix and anchor the regex pattern
            $escapedDatePrefix = [regex]::Escape($datePrefix)
            if ($project.Name -match "^$escapedDatePrefix\.(\d{2})") {
                # Add the matched number as an integer to our array
                $foundIndices += [int]$matches[1]
            }
        }

        # If we found any indices, get the maximum. Otherwise, default to 0.
        if ($foundIndices.Count -gt 0) {
            $max = ($foundIndices | Measure-Object -Maximum).Maximum
        } else {
            $max = 0 # No valid indices found, start from 0 for calculation
        }

        return $max + 1
    } else {
        return 1
    }
}

function Get-NextProjectIndex {
    param ([string]$datePrefix)

    try {
        $existingProjects = Get-ChildItem -Path $dropboxRoot -Directory -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -like "$datePrefix.*" }

        if ($existingProjects) {
            $foundIndices = @() # Initialize an array to hold found indices

            foreach ($project in $existingProjects) {
                # FIXED: Escape the datePrefix and anchor the regex pattern
                $escapedDatePrefix = [regex]::Escape($datePrefix)
                if ($project.Name -match "^$escapedDatePrefix\.(\d{2})") {
                    # Add the matched number as an integer to our array
                    $foundIndices += [int]$matches[1]
                }
            }

            # If we found any indices, get the maximum. Otherwise, default to 0.
            if ($foundIndices.Count -gt 0) {
                $max = ($foundIndices | Measure-Object -Maximum).Maximum
                return [int]($max + 1)
            } else {
                return [int]1 # No valid indices found, start from 1
            }
        } else {
            return [int]1
        }
    }
    catch {
        Write-Warning "Error in Get-NextProjectIndex: $($_.Exception.Message)"
        return [int]1
    }
}

function Create-ProjectName {
    param ([string]$rawName)

    $datePrefix = Get-FormattedDatePrefix
    $index = Get-NextProjectIndex -datePrefix $datePrefix
    
    # FIXED: Validate that index is a valid integer
    if ($index -eq $null -or $index -isnot [int]) {
        Write-Warning "Invalid index returned: $index. Defaulting to 1."
        $index = 1
    }
    
    $suffix = "{0:D2}" -f $index

    return "$datePrefix.$suffix-$rawName"
}

function StopDropbox {
    $dropboxProcess = Get-Process -Name "Dropbox" -ErrorAction SilentlyContinue
    if ($dropboxProcess) {
        Write-Host "🛑 Dropbox is running. Stopping it now..."
        Stop-Process -Name "Dropbox" -Force
        Start-Sleep -Seconds 2
    } else {
        Write-Host "✅ Dropbox is not running."
    }
}

function Clone-And-SetupProject {
    param ([string]$projectName)
    Write-Host "🚀 Creating project: $projectName"
    Set-Location "$dropboxRoot"
    git clone $repoURL 
    Rename-Item "$dropboxRoot\$cgProduction" "$dropboxRoot\$projectName" -Force
    Set-Location "$dropboxRoot\$projectName"
    Remove-Item -Recurse -Force .git
    git init
    git add .
    git commit -m "Initial commit."
    Set-Location "$localRoot"
    git clone "$dropboxRoot\$projectName"
    Set-Location "$localRoot\$projectName"
    git checkout -b localproduction-round-01
    git push --set-upstream origin localproduction-round-01
    git status
}

# === Main Script Execution ===
$rawName = Read-Host "Enter the project name (e.g., my-cool-project)"
$finalProjectName = Create-ProjectName -rawName $rawName
StopDropbox
Clone-And-SetupProject -projectName $finalProjectName
Write-Host "🚀 Project Deployment Complete: $projectName"
