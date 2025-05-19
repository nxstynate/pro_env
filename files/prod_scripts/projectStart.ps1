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
        $max = ($existingProjects.Name | ForEach-Object {
            if ($_ -match "$datePrefix\.(\d{2})-") { [int]$matches[1] } else { 0 }
        } | Measure-Object -Maximum).Maximum
        return $max + 1
    } else {
        return 1
    }
}

function Create-ProjectName {
    param ([string]$rawName)
    $datePrefix = Get-FormattedDatePrefix
    $index = Get-NextProjectIndex -datePrefix $datePrefix
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
