# Custom Home Directory----------------------------------------------------------------------------------------
#$CustomHome = "C:\Users\Paul"
#Set-Location -Path $CustomHome

# set PowerShell to UTF-8-----------------------------------------------------------------------------------------
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Env-----------------------------------------------------------------------------------------
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# posh-git -----------------------------------------------------------------------------------------
Import-Module posh-git


# Prompt Styling-----------------------------------------------------------------------------------------
# Oh My Posh Prompt
# $omp_config = Join-Path $PSScriptRoot ".\takuya.omp.json"
# oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# Starship Prompt
Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$HOME\dotfiles\starship.toml"

# Terminal Icons-----------------------------------------------------------------------------------------
Import-Module -Name Terminal-Icons

# Zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

#PS ReadLine -----------------------------------------------------------------------------------------
Import-Module -Name PSReadLine
Set-PSReadLineOption -PredictionSource History 
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -HistorySavePath "C:\Users\Paul\Documents\PowerShell\PSReadLineHistory.txt"

#Fzf-----------------------------------------------------------------------------------------
Import-Module PSfzf
Set-PsFzfOption -PSReadLineChordProvider 'Ctrl+f' 
Set-PsFzfOption -PSReadLineChordReverseHistory 'Ctrl+r'

function fcd {
    # List directories recursively from the current directory
    $dir = Get-ChildItem -Directory -Recurse -ErrorAction SilentlyContinue |
           Select-Object -ExpandProperty FullName |
           fzf
    if ($dir) {
        Set-Location $dir
    }
}

#Fastfetch-----------------------------------------------------------------------------------------
if (-not $env:SKIP_FASTFETCH) {
    Fastfetch
  }

#Python Scripts-----------------------------------------------------------------------------------------
Set-Alias mm "$HOME\scripts\mm.py"

# Alias-----------------------------------------------------------------------------------------
Set-Alias -Name vim -Value nvim
Set-Alias cat bat
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias touch New-Item
#Set-Alias which Get-Command
function which { (Get-Command $args[0] -ErrorAction SilentlyContinue).Source }
#Set-Alias lockscreen "rundll32.exe user32.dll,LockWorkStation"
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias 3dsmax2022 "C:\Program Files\Autodesk\3ds Max 2022\3dsmax.exe"
Set-Alias 3dsmaxcmd "C:\Program Files\Autodesk\3ds Max 2022\3dsmaxcmd.exe"
Set-Alias blender42 "C:\Program Files\Blender Foundation\Blender 4.2\blender.exe"
Set-Alias blender41 "C:\Program Files\Blender Foundation\Blender 4.1\blender.exe"
Set-Alias blender40 "C:\Program Files\Blender Foundation\Blender 4.0\blender.exe"
Set-Alias photoshop "C:\Program Files\Adobe\Adobe Photoshop 2025\Photoshop.exe"
Set-Alias illustrator "C:\Program Files\Adobe\Adobe Illustrator 2025\Support Files\Contents\Windows\Illustrator.exe"
Set-Alias AfterFx "C:\Program Files\Adobe\Adobe After Effects 2025\Support Files\AfterFX.exe"
Set-Alias aerender "C:\Program Files\Adobe\Adobe After Effects 2025\Support Files\aerender.exe"
Set-Alias indesigin "C:\Program Files\Adobe\Adobe InDesign 2023\InDesign.exe"
Set-Alias bridge "C:\Program Files\Adobe\Adobe Bridge 2024\Adobe Bridge.exe"
Set-Alias chrome "C:\Program Files\Google\Chrome\Application\chrome.exe"
Set-Alias ableton "C:\ProgramData\Ableton\Live 11 Suite\Program\Ableton Live 11 Suite.exe"
Set-Alias sketchup "C:\Program Files\SketchUp\SketchUp 2021\SketchUp.exe"
Set-Alias layout "C:\Program Files\SketchUp\SketchUp 2021\LayOut\LayOut.exe"
Set-Alias premiere "C:\Program Files\Adobe\Adobe Premiere Pro 2023\Adobe Premiere Pro.exe"
Set-Alias signal "C:\Users\Nate Lewis\AppData\Local\Programs\signal-desktop\Signal.exe"
Set-Alias minifuse "C:\Program Files (x86)\Arturia\MiniFuse Control Center\MiniFuse Control Center.exe"
Set-Alias obs "C:\Program Files\obs-studio\bin\64bit\obs64.exe"
Set-Alias powertoys "C:\Program Files\PowerToys\PowerToys.exe"
Set-Alias mozilla "C:\Program Files\Mozilla Firefox\private_browsing.exe"
Set-Alias dropbox "C:\Program Files (x86)\Dropbox\Client\Dropbox.exe"
Set-Alias fusion "C:\Program Files\Blackmagic Design\Fusion 17\Fusion.exe"
Set-Alias fusionRenderNode "C:\Program Files\Blackmagic Design\Fusion Render Node 17\FusionRenderNode.exe"
Set-Alias acrobat "C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe"
Set-Alias sp404 "C:\Program Files (x86)\Roland\SP-404MKII\SP-404MKII.exe"
Set-Alias timewarp "C:\Program Files\Timewarp\dist\main\Timewarp.exe"
Set-Alias flamencoManager "C:\Users\Paul\Documents\Nate\flamenco-render-management\flamenco-3.4-windows-amd64\flamenco-manager.exe"
Set-Alias flamencoWorker "C:\Users\Paul\Documents\Nate\flamenco-render-management\flamenco-3.4-windows-amd64\flamenco-worker.exe"
Set-Alias OctaneServer "C:\Program Files\Otoy\OctaneServerPrime\OctaneServer.exe"
Set-Alias ccleaner "C:\Program Files\CCleaner\CCleaner64.exe"
#Set-Alias EditTerminalSettings "cd C:\Users\Paul\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
function EditTerminalSettings { vim "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" }

# Utilities-----------------------------------------------------------------------------------------
# Function to find the full path of a command
function Find-CommandPath
{
  param([string]$command)

  Get-Command -Name $command -ErrorAction Stop |
    Select-Object -ExpandProperty Path
}

# Alias to extract contents of archives inside a folder and its subdirectories
# New-Alias -Name ExpandAll -Value {
#     Get-ChildItem -Path .\my_folder\* -Recurse -File |
#         ForEach-Object {
#             Expand-Archive -Path $_.FullName -DestinationPath $_.DirectoryName
#         }
# }

# Copy File Path to Clipboard-----------------------------------------------------------------------------------------
function Copy-CurrentLocation
{
  Get-Location | Set-Clipboard
}

Set-Alias cptc Copy-CurrentLocation

# Sleep-----------------------------------------------------------------------------------------
function Sleep-Computer
{
  Add-Type -TypeDefinition @"
        using System;
        using System.Runtime.InteropServices;

        public class Power
        {
            [DllImport("powrprof.dll", SetLastError = true)]
            public static extern bool SetSuspendState(bool hibernate, bool forceCritical, bool disableWakeEvent);
        }
"@
  [Power]::SetSuspendState($false, $false, $false)
}
Set-Alias -Name hibernate -Value Sleep-Computer

# Lock Computer-----------------------------------------------------------------------------------------
function Lock-Computer
{
  rundll32.exe user32.dll,LockWorkStation
}

Set-Alias -Name lock -Value Lock-Computer

# Copy File Path-----------------------------------------------------------------------------------------
function Copy-FileLocationToClipboard
{
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias('FullName')]
    [string]$Path
  )

  # Resolve the path to get the full file path
  $resolvedPath = Resolve-Path -Path $Path

  # Copy the file location to the clipboard
  $resolvedPath | Set-Clipboard

  # Output a message confirming the copy
  # Write-Host "File location copied to clipboard: $resolvedPath"
}
Set-Alias -Name cpfp -Value Copy-FileLocationToClipboard

# Uninstall-Software-----------------------------------------------------------------------------------------
function Uninstall-Software
{
  param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String]$SoftwareName
  )
 
  $software = Get-CimInstance -ClassName Win32_Product | Where-Object { $_.Name -eq $SoftwareName }
 
  if ($software)
  {
    $software | ForEach-Object {
      $_.Uninstall()
    }
  } else
  {
    Write-Warning "Software '$SoftwareName' not found."
  }
}

# Chrome Inject Process Render Doc-----------------------------------------------------------------------------------------
function Start-ChromeRenderDoc
{
  $chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"

  Set-Variable RENDERDOC_HOOK_EGL=0

  $chromePath
}

# Clear Temp Files-----------------------------------------------------------------------------------------

function Clear-TempFiles
{

    # Clear Windows Temp directory
    Get-ChildItem -Path "$env:windir\Temp\*" -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

    # Clear User Temp directory
    Get-ChildItem -Path "$env:TEMP\*" -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

    # Clear Downloaded Program Files
    Get-ChildItem -Path "$env:windir\Downloaded Program Files\*" -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

    # Clear Windows Error Reporting
    Get-ChildItem -Path "C:\ProgramData\Microsoft\Windows\WER\*" -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

    # Clear Internet Explorer/Edge Cache
    Get-ChildItem -Path "$env:USERPROFILE\AppData\Local\Microsoft\Windows\INetCache\*" -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

    # Clear Application Data Temp (Local)
    Get-ChildItem -Path "$env:USERPROFILE\AppData\Local\Temp\*" -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

    # Clear Application Data Temp (Roaming)
    Get-ChildItem -Path "$env:USERPROFILE\AppData\Roaming\Temp\*" -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

    # Empty Recycle Bin
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    Write-Output "Temp Files cleared successfully."

# Clear Windows Update Cache-----------------------------------------------------------------------------------------
  }
function Clear-WindowsUpdateCache {
    # Define the path to the Windows Update cache
    $updateCachePath = "C:\Windows\SoftwareDistribution\Download\*"

    # Check if the directory exists
    if (Test-Path -Path $updateCachePath) {
        # Remove all contents in the Windows Update cache folder
        Get-ChildItem -Path $updateCachePath -Recurse -Force | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
        Write-Output "Windows Update cache cleared successfully."
    } else {
        Write-Output "Windows Update cache directory not found."
    }
}


# File Size Search-----------------------------------------------------------------------------------------
function Get-LargestFiles {
    [CmdletBinding()]
    param (
        [string]$Path = "C:\", # Default path to search
        [int]$TopN = 10 # Number of top files to list
    )

    # Find and list the top N largest files
    Get-ChildItem -Path $Path -Recurse | 
    Where-Object { ! $_.PSIsContainer } | 
    Sort-Object Length -Descending | 
    Select-Object -First $TopN Name, 
    @{Name="Size";Expression={"{0:N2} MB" -f ($_.length / 1MB)}}, 
    Directory
}

function Get-LargestFolders {
    [CmdletBinding()]
    param (
        [string]$Path = "C:\", # Default path to search
        [int]$TopN = 10 # Number of top folders to list
    )

    Get-ChildItem -Path $Path -Recurse -File | 
    Group-Object -Property Directory | 
    Select-Object -Property Name, 
    @{Name="TotalSize";Expression={($_.Group | Measure-Object -Property Length -Sum).Sum / 1MB}} | 
    Sort-Object -Property TotalSize -Descending | 
    Select-Object -First $TopN
}

$cdHistoryPath = 'X:\Dropbox\.cdHistory'
if (-not (Test-Path $cdHistoryPath)) {
    New-Item -ItemType File -Path $cdHistoryPath -Force
}

function Copy-FilesToRoot {
    param (
        [Parameter(Mandatory=$true)]
        [string]$RootPath,
        
        [Parameter(Mandatory=$true)]
        [string]$FileExtension
    )

    # Check if the root path exists
    if (-Not (Test-Path -Path $RootPath)) {
        Write-Host "The specified root path does not exist: $RootPath" -ForegroundColor Red
        return
    }

    # Get all files with the specified extension in the root folder and its subfolders
    $files = Get-ChildItem -Path $RootPath -Recurse -Filter "*$FileExtension"

    foreach ($file in $files) {
        # Define the new path for the file in the root folder
        $newPath = Join-Path -Path $RootPath -ChildPath $file.Name
        
        try {
            # Move the file to the root folder
            Copy-Item -Path $file.FullName -Destination $newPath -Force
            Write-Host "Moved $($file.FullName) to $newPath" -ForegroundColor Green
        } catch {
            Write-Host "Failed to move $($file.FullName): $_" -ForegroundColor Red
        }
    }

    Write-Host "File move operation completed." -ForegroundColor Cyan
}

#---------------------------------------------------------------------------------------------

function Copy-FilesToDestination {
    param (
        [Parameter(Mandatory=$true)]
        [string]$SourcePath,

        [Parameter(Mandatory=$true)]
        [string]$DestinationPath,

        [Parameter(Mandatory=$true)]
        [string]$FileExtension
    )

    # Check if the source path exists
    if (-Not (Test-Path -Path $SourcePath)) {
        Write-Host "The specified source path does not exist: $SourcePath" -ForegroundColor Red
        return
    }

    # Check if the destination path exists. Create it if it doesn't.
    if (-Not (Test-Path -Path $DestinationPath)) {
        try {
            New-Item -ItemType Directory -Path $DestinationPath -Force | Out-Null # Create the directory, suppress output
            Write-Host "Destination directory created: $DestinationPath" -ForegroundColor Green
        }
        catch {
            Write-Host "Failed to create destination directory: $_" -ForegroundColor Red
            return
        }
    }


    # Get all files with the specified extension in the source folder and its subfolders
    $files = Get-ChildItem -Path $SourcePath -Recurse -Filter "*$FileExtension"

    foreach ($file in $files) {
        # Define the new path for the file in the destination folder.  Preserve subfolder structure!
        $relativePath = $file.FullName.Substring($SourcePath.Length).TrimStart("\").TrimStart("/") # Get path relative to source
        $newPath = Join-Path -Path $DestinationPath -ChildPath $relativePath # Reconstruct in destination

        try {
            # Copy the file to the destination folder
            Copy-Item -Path $file.FullName -Destination $newPath -Force
            Write-Host "Copied $($file.FullName) to $newPath" -ForegroundColor Green
        } catch {
            Write-Host "Failed to copy $($file.FullName): $_" -ForegroundColor Red
        }
    }

    Write-Host "File copy operation completed." -ForegroundColor Cyan
}
#---------------------------------------------------------------------------------------------


function Update-FileTimestamp {
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath,
        
        [Parameter(Mandatory=$true)]
        [datetime]$NewTimestamp,
        
        [string]$TimestampType = "LastWriteTime" # Default to LastWriteTime
    )

    switch ($TimestampType) {
        "LastWriteTime" { Set-ItemProperty -Path $FilePath -Name LastWriteTime -Value $NewTimestamp }
        "LastAccessTime" { Set-ItemProperty -Path $FilePath -Name LastAccessTime -Value $NewTimestamp }
        "CreationTime" { Set-ItemProperty -Path $FilePath -Name CreationTime -Value $NewTimestamp }
        default { Write-Error "Invalid TimestampType specified. Valid types are: LastWriteTime, LastAccessTime, CreationTime." }
    }
}

# Example usage:
# Update-FileTimestamp -FilePath "C:\path\to\your\file.txt" -NewTimestamp (Get-Date "2024-07-30 10:00:00") -TimestampType "LastWriteTime"

#---------------------------------------------------------------------------------------------

# Function to recursively search for files with a specified extension and copy them
function Copy-FilesByExtension {
    param (
        [string]$sourceDir,
        [string]$destDir,
        [string]$extension
    )

    # Construct the file filter by appending the extension
    $fileFilter = "*.$extension"

    # Get all files with the specified extension in the current directory and its subdirectories
    $files = Get-ChildItem -Path $sourceDir -Recurse -Filter $fileFilter

    foreach ($file in $files) {
        # Construct the destination path
        $destinationPath = Join-Path $destDir $file.Name

        # Copy the file to the destination directory
        Copy-Item -Path $file.FullName -Destination $destinationPath -Force

        Write-Host "Copied $($file.FullName) to $destinationPath"
    }
# Optional: Provide a description for how to call the function
Write-Host "Function 'Copy-FilesByExtension' loaded. Call it like this:"
Write-Host "`nCopy-FilesByExtension -sourceDir 'C:\Source\Path' -destDir 'C:\Destination\Path' -extension 'skp'`n"
}
#---------------------------------------------------------------------------------------------

function New-DateTimeDir {
    param(
        [string]$BasePath = "."
    )
    $directoryName = (Get-Date -Format "yyyy-MM-dd-HH-mm-ss")
    New-Item -Path $BasePath -Name $directoryName -ItemType Directory
}


#---------------------------------------------------------------------------------------------
function Check-FontInstalled {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$FontNames
    )

    $fontsKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"

    foreach ($font in $FontNames) {
        $fontInstalled = Get-ItemProperty -Path $fontsKey | Select-Object -Property PSChildName | Where-Object { $_.PSChildName -like "*$font*" }
        if ($fontInstalled) {
            Write-Host "The font '$font' is installed." -ForegroundColor Green
        } else {
            Write-Host "The font '$font' is not installed." -ForegroundColor Red
        }
    }
}


#LockScreen---------------------------------------------------------------------------------------------
function Lock-Screen {
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    
    public class LockWorkStationHelper {
        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool LockWorkStation();
    }
"@ -PassThru | Out-Null

    [LockWorkStationHelper]::LockWorkStation()
}


#Script Executions---------------------------------------------------------------------------------------------
#Clear-TempFiles
#Clear-WindowsUpdateCache 
#Clear-RecycleBin -Force -ErrorAction SilentlyContinue

function Update-GitRepo {
  git status
  git add .
  git commit -m "Updated files on $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")"
  git status
  git push
}

