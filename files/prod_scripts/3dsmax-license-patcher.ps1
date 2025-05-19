function 3DSMax-License-Patcher {
# Check for Admin rights
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    
    Write-Host "Restarting as Administrator..."
    Start-Process -FilePath "powershell" -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

  $isoPath = "X:\Dropbox\2_Library\9_software\programs\2022SoftwarePackage\3DStudioMax2022\3ds_Max_2022.3.3_Win_64bit\3ds_Max_2022.3.3_Win_64bit.iso"
  $relativePathInsideISO = "Crack\Autodesk License Patcher\Autodesk License Patcher Installer.exe"
  Write-Host "Mounting ISO: $isoPath"
  $mountResult = Mount-DiskImage -ImagePath $isoPath -PassThru
  Start-Sleep -Seconds 2
  $driveLetter = (Get-Volume -DiskImage $mountResult).DriveLetter
  if (-not $driveLetter) {
      Write-Error "Failed to find mounted ISO drive letter."
      exit 1
  }
  $fullExecutablePath = "$driveLetter`:\$relativePathInsideISO"
  Write-Host "Running: $fullExecutablePath"
    try {
        Add-MpPreference -ExclusionPath (Split-Path $fullExecutablePath -Parent)
        Write-Host "Defender exclusion added for: $(Split-Path $fullExecutablePath -Parent)"
    } catch {
        Write-Warning "Could not set Defender exclusion — try running as Admin."
    }
  Start-Process -FilePath $fullExecutablePath -Wait
  Write-Host "Dismounting ISO..."
  Dismount-DiskImage -ImagePath $isoPath
  Write-Host "Done."
  }
3DSMax-License-Patcher
 # function Function-Loop {
 #    for ($i = 0; $i -lt 5; $i++) {
 #        3DSMax-License-Patcher
 #        Start-Sleep -Seconds 5
 #    } 
 #  }
 #
 #  Function-Loop
