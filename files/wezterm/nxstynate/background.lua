local M = {}

function M.apply(config)
	-- local bg_image = os.getenv("HOME") .. "/pro-env/files/wezterm/nxstynate/images/background-01.jpg"
	local bg_image = os.getenv("HOME") .. "/pro-env/files/wezterm/nxstynate/images/background-02.jpg"

	config.window_background_image = bg_image
	config.window_background_image_hsb = {
		brightness = 0.015, -- 0 = black, 1 = full brightness
		hue = 1.0,
		saturation = 0.5,
	}
end

return M
