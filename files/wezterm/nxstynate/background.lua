local wezterm = require("wezterm")
local home = os.getenv("HOME") or os.getenv("USERPROFILE") or os.getenv(XDG_CONFIG_HOME)

local M = {}

function M.apply(config)
	-- local bg_image = os.getenv("HOME") .. "/pro-env/files/wezterm/nxstynate/images/background-05.jpg"
	local bg_image = home .. "/pro-env/files/wezterm/nxstynate/images/background-05.jpg"

	config.background = {
		{
			source = { File = bg_image },
			hsb = {
				brightness = 0.3,
				hue = 1.0,
				saturation = 1.0,
			},
			attachment = "Fixed",
			width = "Cover",
			height = "Cover",
			repeat_x = "NoRepeat",
			repeat_y = "NoRepeat",
			horizontal_align = "Center",
			vertical_align = "Middle",
		},
	}
end

return M
