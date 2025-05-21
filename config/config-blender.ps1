$ver = "4.4"
$blenderPath = "$HOME/programs"
$dropboxConfigFiles = "https://www.dropbox.com/scl/fi/3mp73hnzl4eyuu5b4628g/configFiles.zip?rlkey=1snswsc65ouexugsmyj1gymum&st=slw6e39a&dl=1"
$configPath = "$env:APPDATA/Blender Foundation/Blender"

function configBlender  {
  Write-Output "Copying config files to setup your envinronment..."
  Invoke-WebRequest -Uri "$dropboxConfigFiles" -OutFile "$blenderPath/configFiles.zip"
  Expand-Archive "$blenderPath/configFiles.zip" "$blenderPath/."
  Copy-Item -Path "$blenderPath/configFiles" -Destination "$configPath/$ver" -Force -Recurse
  Write-Output "Removing config files..."
  Remove-Item -Path "$blenderPath/configFiles.zip" -Force
  Remove-Item -Path "$blenderPath/configFiles" -Force -Recurse
  Write-Output "Copying config files to setup your envinronment complete..."
}

configBlender

