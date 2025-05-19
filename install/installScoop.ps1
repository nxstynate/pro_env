# installs scoop package manager

function InstallScoop {
    $scoopPath = Get-Command scoop -ErrorAction SilentlyContinue

    if ($scoopPath) {
        Write-Host "Scoop is installed.  Path: $($scoopPath.Definition)" -ForegroundColor Green
    }
    else {
        Write-Host "Scoop is not installed now installing..." -ForegroundColor Red
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    }

  }

InstallScoop
