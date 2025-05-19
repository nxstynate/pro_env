local wezterm = require("wezterm")

local M = {}

function M.apply(config)
	local os_name = wezterm.target_triple

	if os_name:find("windows") then
		-- Leave default as PowerShell
		config.default_prog = { "pwsh.exe", "-NoLogo" }

		-- Add Arch to launch menu
		config.launch_menu = config.launch_menu or {}
		table.insert(config.launch_menu, {
			label = "WSL: Arch Linux (Zsh)",
			args = { "wsl.exe", "--distribution", "Arch", "--exec", "zsh", "-l", "fish" },
		})
	else
		-- For Unix-based systems (if you use WezTerm on Linux/macOS too)
		config.default_prog = { "/bin/zsh", "-l" }
	end
end

return M
