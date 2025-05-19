```
dotfiles-windows\
│
├── run.ps1              # Main entry point
├── settings.ps1         # Global config (versions, flags, etc.)
├── lib\                 # Common functions
│   └── common.ps1
├── runs\                # Software installers
│   └── install-scoop.ps1
│   └── install-vscode.ps1
├── config\              # Software config scripts (e.g., linking files)
│   └── config-vscode.ps1
│   └── config-powershell.ps1
├── files\               # Your actual dotfiles/configs
│   └── powershell\Microsoft.PowerShell_profile.ps1
│   └── vscode\settings.json
└── post\                # Final tasks (optional)


```
