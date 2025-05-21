function installPowershellModules{

    scoop bucket add extras
    scoop install posh-git
    Add-PoshGitToProfile

    scoop bucket add extras
    scoop install terminal-icons

    Install-Module -Name PSFzf -RequiredVersion 2.6.1

    scoop install fastfetch

  }

installPowershellModules
