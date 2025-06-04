local wezterm = require("wezterm")
local home = os.getenv("HOME") or os.getenv("USERPROFILE") or os.getenv(XDG_CONFIG_HOME)

local M = {}
local wezterm_config_path = home .. "/pro-env/files/wezterm/nxstynate/init.lua"
local localproduction = "X:/LocalProduction/"
local dir_youtube = "X:/Youtube/"
local scratch_document = "$env:USERNAME/scratch.txt"
local pro_env = home .. "/pro-env/"
local powershell_profile = home .. "/pro-env/files/powershell/Microsoft.PowerShell_profile.ps1"

function M.apply(config)
	config.leader = { key = "t", mods = "CTRL", timeout_milliseconds = 1000 }

	config.keys = {
		{ mods = "LEADER", key = "c", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		{ mods = "LEADER", key = "x", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
		{ mods = "LEADER", key = "p", action = wezterm.action.ActivateTabRelative(-1) },
		{ mods = "LEADER", key = "n", action = wezterm.action.ActivateTabRelative(1) },
		{ mods = "LEADER", key = "-", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ mods = "LEADER", key = "=", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ mods = "LEADER", key = "h", action = wezterm.action.ActivatePaneDirection("Left") },
		{ mods = "LEADER", key = "j", action = wezterm.action.ActivatePaneDirection("Down") },
		{ mods = "LEADER", key = "k", action = wezterm.action.ActivatePaneDirection("Up") },
		{ mods = "LEADER", key = "l", action = wezterm.action.ActivatePaneDirection("Right") },
		{ mods = "LEADER", key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
		{ mods = "LEADER", key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
		{ mods = "LEADER", key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
		{ mods = "LEADER", key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
		{ mods = "LEADER", key = "s", action = wezterm.action.ShowLauncher },
		{ mods = "LEADER", key = "t", action = wezterm.action.ShowTabNavigator },
		{ mods = "LEADER", key = "Return", action = wezterm.action.TogglePaneZoomState },
		{ mods = "LEADER", key = "f", action = wezterm.action.ToggleFullScreen },
		{ mods = "LEADER|CTRL", key = "j", action = wezterm.action.ActivateCopyMode },
		{
			mods = "LEADER",
			key = "u",
			action = wezterm.action.SwitchToWorkspace({
				name = "ARCH",
				spawn = {
					args = { "wsl.exe", "-d", "archlinux" },
				},
			}),
		},
		{
			mods = "LEADER",
			key = "m",
			action = wezterm.action.SpawnCommandInNewTab({
				cwd = wezterm.home_dir,
				args = { "nvim", wezterm_config_path },
			}),
		},
		{
			mods = "LEADER",
			key = ";",
			action = wezterm.action.SpawnCommandInNewTab({
				cwd = wezterm.home_dir,
				args = { "nvim", scratch_document },
			}),
		},
		{
			mods = "LEADER",
			key = "y",
			action = wezterm.action.SwitchToWorkspace({
				name = "YOUTUBE: @NXSTYNATE",
				spawn = {
					cwd = dir_youtube,
					set_environment_variables = {
						SKIP_FASTFETCH = "1",
					},
					args = {
						"pwsh",
						"-NoExit",
						"-NoLogo",
						"-Command",
						"Set-PSReadLineOption -PredictionSource None",
					},
				},
			}),
		},
		{
			mods = "LEADER",
			key = "i",
			action = wezterm.action.SpawnCommandInNewTab({
				cwd = wezterm.home_dir,
				set_environment_variables = {
					SKIP_FASTFETCH = "1",
				},
				args = { "pwsh", "-NoLogo", "-Command", "nvim", powershell_profile },
			}),
		},
		{
			mods = "LEADER",
			key = "o",
			action = wezterm.action.SpawnCommandInNewTab({
				cwd = localproduction,
				set_environment_variables = {
					SKIP_FASTFETCH = "1",
				},
				args = { "pwsh", "-NoExit", "-NoLogo", "-Command", "fcd" },
			}),
		},
		{
			mods = "LEADER",
			key = "e",
			action = wezterm.action.SpawnCommandInNewTab({
				cwd = pro_env, -- Make sure 'pro_env' is defined elsewhere
				set_environment_variables = {
					SKIP_FASTFETCH = "1",
				},
				args = { "pwsh", "-NoExit", "-NoLogo" }, -- Fixed typo
			}),
		},
		{
			mods = "LEADER",
			key = "r",
			action = wezterm.action.SpawnCommandInNewTab({
				cwd = pro_env, -- Make sure 'pro_env' is defined elsewhere
				set_environment_variables = {
					SKIP_FASTFETCH = "1",
				},
				args = { "pwsh", "-NoExit", "-NoLogo", "-Command", "nvim (fzf)" }, -- Fixed typo
			}),
		},
		{
			key = "w",
			mods = "LEADER",
			action = wezterm.action.ShowLauncherArgs({ flags = "WORKSPACES" }),
		},
		{
			mods = "LEADER|CTRL",
			key = "s",
			action = wezterm.action.SpawnCommandInNewTab({
				set_environment_variables = {
					SKIP_FASTFETCH = "1",
				},
				args = {
					"pwsh",
					-- "-NoExit",
					"-NoLogo",
					"-File",
					wezterm.home_dir .. "/pro-env/files/wezterm/wezterm_sessionizer.ps1",
				}, -- Fixed typo
			}),
		},
	}

	-- Add LEADER + number keys for tab switching
	for i = 1, 9 do
		table.insert(config.keys, {
			key = tostring(i),
			mods = "LEADER",
			action = wezterm.action.ActivateTab(i - 1),
		})
	end
end

return M
