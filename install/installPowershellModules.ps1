function installPowershellModules{

    PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force

    Install-Module -Name Terminal-Icons -RequiredVersion 0.9.0

    Install-Module -Name PSFzf -RequiredVersion 2.6.1

    scoop install fastfetch

  }

installPowershellModules
