local M = {}

function M.apply(config)
	local bg_image = os.getenv("HOME") .. "/dotfiles/wezterm/nxstynate/images/background.jpg"

	config.window_background_image = bg_image
	config.window_background_image_hsb = {
		brightness = 0.04, -- 0 = black, 1 = full brightness
		hue = 1.0,
		saturation = 0.5,
	}
end

return M
