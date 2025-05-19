# ===========================
# dotfiles-windows/run.ps1
# ===========================
param (
    [string]$Grep = "",
    [ValidateSet("all", "install", "config", "post")]
    [string]$Phase = "all",
    [switch]$DryRun
)

$ScoopInstall = "./runs/installScoop.ps1"
$ChocoInstall = "./runs/installChoco.ps1"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$ScriptDir\settings.ps1"
. "$ScriptDir\lib\common.ps1"

function Main {
    $ChocoInstall
    $ScoopInstall
    Validate-Environment

    if ($Phase -eq "install" -or $Phase -eq "all") {
        Log-Header "INSTALL PHASE"
        RunPhase -Label "INSTALL" -Directory "$ScriptDir\runs" -Grep $Grep -DryRun:$DryRun
    }

    if ($Phase -eq "config" -or $Phase -eq "all") {
        Log-Header "CONFIG PHASE"
        RunPhase -Label "CONFIG" -Directory "$ScriptDir\config" -Grep $Grep -DryRun:$DryRun
    }

    if ($Phase -eq "post" -or $Phase -eq "all") {
        Log-Header "POST PHASE"
        RunPhase -Label "POST" -Directory "$ScriptDir\post" -Grep $Grep -DryRun:$DryRun
    }
}

Main
