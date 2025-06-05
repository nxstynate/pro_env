-- nxstynate/statusline.lua
local wezterm = require("wezterm")

local M = {}

function M.apply(config, theme_name)
	local colors = require("nxstynate.colors." .. theme_name)

	config.enable_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = false
	config.tab_and_split_indices_are_zero_based = false
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.tab_max_width = 16
	config.colors = config.colors or {}

	local function build_tab_bar()
		local active_fg = theme_name == "rose_pine" and colors.rose or colors.bright_purple
		local inactive_fg = theme_name == "rose_pine" and colors.pine or colors.bright_green

		return {
			background = colors.gunmetal_black,
			active_tab = {
				bg_color = colors.gunmetal_black,
				fg_color = active_fg,
				intensity = "Bold",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = colors.gunmetal_black,
				fg_color = inactive_fg,
			},
			inactive_tab_hover = {
				bg_color = colors.gunmetal_black,
				fg_color = inactive_fg,
				italic = true,
			},
			new_tab = {
				bg_color = colors.gunmetal_black,
				fg_color = inactive_fg,
			},
			new_tab_hover = {
				bg_color = colors.gunmetal_black,
				fg_color = inactive_fg,
				italic = true,
			},
		}
	end

	config.colors.tab_bar = build_tab_bar()

	wezterm.on("update-right-status", function(window, _)
		local workspace = window:active_workspace()
		local elements = {
			{ Background = { Color = colors.gunmetal_black } },
			{ Foreground = { Color = colors.green or colors.pine } },
			{ Text = "WS:[" .. workspace .. "] " },
		}

		if workspace ~= "YOUTUBE: @NXSTYNATE" then
			local time = wezterm.strftime("%a %Y-%m-%d %H:%M")
			table.insert(elements, { Foreground = { Color = colors.green or colors.pine } })
			table.insert(elements, { Text = " " .. time .. " " })
		end

		window:set_right_status(wezterm.format(elements))
	end)
end

return M
