-- nxstynate/statusline.lua
local wezterm = require("wezterm")
local colors = require("nxstynate.theme_colors_osaka")

local M = {}

function M.apply(config)
	config.enable_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = false
	config.tab_and_split_indices_are_zero_based = false
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.tab_max_width = 16
	config.colors = config.colors or {}

	config.colors.tab_bar = {
		background = colors.gunmetal_black,
		active_tab = {
			bg_color = colors.gunmetal_black,
			fg_color = colors.bright_purple,
			intensity = "Bold",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = colors.gunmetal_black,
			fg_color = colors.bright_green,
		},
		inactive_tab_hover = {
			bg_color = colors.gunmetal_black,
			fg_color = colors.bright_green,
			italic = true,
		},
		new_tab = {
			bg_color = colors.gunmetal_black,
			fg_color = colors.bright_green,
		},
		new_tab_hover = {
			bg_color = colors.gunmetal_black,
			fg_color = colors.bright_green,
			italic = true,
		},
	}
	wezterm.on("update-right-status", function(window, _)
		local workspace = window:active_workspace()
		local elements = {
			{ Background = { Color = colors.gunmetal_black } },
			{ Foreground = { Color = colors.green } },
			{ Text = "WS:[" .. workspace .. "] " },
		}

		if workspace ~= "YOUTUBE" then
			local time = wezterm.strftime("%a %Y-%m-%d %H:%M")
			table.insert(elements, { Foreground = { Color = colors.green } })
			table.insert(elements, { Text = " " .. time .. " " })
		end

		window:set_right_status(wezterm.format(elements))
	end)
end
return M
