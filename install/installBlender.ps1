# Installs Blender and sets up work environment.

$ver = "4.5"
$verSub = ".0"
$blenderPath = "$HOME/programs"
$extension = ".zip"
$package = "blender-$ver$verSub-windows-x64"
$webRequest = "https://ftp.blender.org/release/Blender$ver/$package$extension"
$configPath = "$env:APPDATA/Blender Foundation/Blender"
$dropboxConfigFiles = "https://www.dropbox.com/scl/fi/3mp73hnzl4eyuu5b4628g/configFiles.zip?rlkey=1snswsc65ouexugsmyj1gymum&st=slw6e39a&dl=1"

function CheckDir {
    $blenderPath = "$HOME/programs/"
    if (-not (Test-Path $blenderPath)) {
        Write-Host "❌ Directory does not exist: $blenderPath"
        Write-Host "Creating: $blenderPath"
        New-Item -ItemType Directory -Path $blenderPath 
        Write-Host "📁 Created directory: $blenderPath"
    } else {
        Write-Host "✅ Directory exists: $blenderPath"
    }
}

function InstallBlender {
  Write-Output "Downloading Blender $ver..."
  Invoke-WebRequest -Uri "$webRequest" -OutFile "$blenderPath/"

  Write-Output "Extracting Blender..."
  Expand-Archive "$blenderPath/$package$extension" "$blenderPath/."

  Set-Location $blenderPath/
  Write-Output "Renaming Folder..."
  Move-Item -Path "$package" -Destination "Blender$ver" -Force 

  Write-Output "Removing installation files..."
  Remove-Item -Path "$blenderPath/$package$extension" -Force

  Write-Output "Installation of Blender$ver$verSub complete..."
  }

function ConfigPaths {
  # $blenderRoot = "$blenderPath/Blender$ver/$ver"
  #
  # $env:BLENDER_USER_CONFIG = "$blenderRoot/config"
  # $env:BLENDER_USER_DATAFILES = "$blenderRoot/datafiles"
  # $env:BLENDER_USER_SCRIPTS = "$blenderRoot/scripts"
  # $env:BLENDER_USER_EXTENSIONS = "$blenderRoot/extensions"
  
  $BlenderExePath = "$blenderPath/Blender4.4/blender.exe"  # Replace with the actual path to your blender.exe
  $ShortcutPath = "$blenderPath/Blender4.4/Blender Portable.lnk" # Replace with where you want to save the shortcut

  $WScriptShell = New-Object -ComObject WScript.Shell
  $Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
  $Shortcut.TargetPath = $BlenderExePath
  $Shortcut.Arguments = "--config-name ."
  $Shortcut.Save()

  Write-Host "Shortcut created at: $ShortcutPath"
  Write-Host "Run Blender using this shortcut to use portable configuration."
  }

CheckDir
InstallBlender
ShortCutSetup
# ConfigPaths

