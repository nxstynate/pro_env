Here’s a clean and professional `README.md` draft for your `pro-env` GitHub repo:

---

# pro-env

**pro-env** is a modular, cross-platform environment automation system built to streamline your system setup for productivity, 3D rendering, and creative workflows. Whether you're working on Windows, WSL, or Linux, `pro-env` helps you install, configure, and launch a consistent environment with minimal effort.

---

## 🔧 Features

- 📦 Automated installation of development and creative tools (Blender, Node, Git, WezTerm, etc.)
- 🧠 Preset dotfiles and shell configs for PowerShell, Fish, and Bash
- 🖼️ Custom WezTerm setup with modular keybindings and background configuration
- 🌀 Supports WSL + Windows cross-setup logic
- ⚙️ Production-ready rendering setup for Blender and automation hooks for command-line rendering
- 🎬 CLI rendering pipeline for Blender and Natron (with After Effects integration coming soon)

---

## 🚀 Quick Start

### 1. Clone the Repo

```sh
git clone https://github.com/nxstynate/pro-env.git
cd pro-env
```

### 2. Run Setup

**Windows / PowerShell:**

```powershell
.\run.ps1 -Filter blender
```

**Linux / WSL / Bash:**

```bash
./run.sh --filter blender
```

> Use the `-Filter` or `--filter` flag to limit which setup scripts are executed (e.g., `wezterm`, `blender`, `nvim`, etc.)

---

## 📁 Structure

```bash
pro-env/
├── files/               # Dotfiles, themes, config files
│   ├── wezterm/         # WezTerm configs (background, keys, etc.)
│   ├── powershell/      # PowerShell profile setup
│   └── blender/         # Blender startup scripts
├── phases/              # Scripts grouped by setup phase
│   ├── blender/         # Blender automation and CLI render scripts
│   ├── wezterm/         # WezTerm font/theme/background installers
│   └── shared/          # Scripts used across platforms
├── run.ps1              # PowerShell entry point
├── run.sh               # Bash entry point
└── README.md            # You're here
```

---

## 💡 Use Cases

- Fast setup for a new development or rendering machine
- Port your creative environment between Linux and Windows
- Automate Blender scene rendering using headless CLI
- Deploy 3D pipelines with version-controlled tools and configs

---

## 📸 Screenshot

> _Include a screenshot of WezTerm + terminal setup here to show off the visual._

---

## ✅ Requirements

- Git
- PowerShell 7+ (for Windows)
- Bash/Zsh/Fish (for Linux)
- WSL (optional but supported)
- Blender (if using rendering tools)
- \[Optional] Scoop or Chocolatey for installing Windows packages

---

## 📜 License

MIT License. Feel free to fork, modify, and use.

---

Let me know if you'd like badges, installation GIFs, or walkthrough docs added!
