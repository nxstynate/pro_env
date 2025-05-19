# Uninstalls Blender Portable

$version = "4.4"

function UninstallBlender {
  Write-Output "Removing Blender$version..."
  if (Get-Process -Name "blender" -ErrorAction SilentlyContinue) {
      Write-Output "Blender is running. Stopping process..."
      Stop-Process -Name "blender" -Force
  } else {
      Write-Output "Blender is not running. Proceeding..."
    }
  Start-Sleep -Seconds 2
  rm "$HOME/programs/Blender$version" -Force  -Recurse
  rm "$ENV:APPDATA/Blender Foundation/Blender/$version" -Force -Recurse
  Write-Output "Removing Blender $version Complete..."
  }

UninstallBlender
