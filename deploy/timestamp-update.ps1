# UpdateFileTimestamps.ps1
param (
    [Parameter(Mandatory = $true)]
    [string]$Path
)

if (-Not (Test-Path $Path)) {
    Write-Error "Path does not exist: $Path"
    exit
}

$currentTime = Get-Date
$files = Get-ChildItem -Path $Path -File -Recurse

foreach ($file in $files) {
    [System.IO.File]::SetCreationTime($file.FullName, $currentTime)
    [System.IO.File]::SetLastWriteTime($file.FullName, $currentTime)
    [System.IO.File]::SetLastAccessTime($file.FullName, $currentTime)
    Write-Output "Timestamps updated: $($file.FullName)"
}
