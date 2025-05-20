local wezterm = require("wezterm")

local M = {}

function M.apply(config)
	-- Appearence
	config.adjust_window_size_when_changing_font_size = false
	config.enable_scroll_bar = false
	-- config.color_scheme = theme_custom
	-- config.dpi = 300
	config.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Thin" })
	-- config.font = wezterm.font("FiraMono Nerd Font Mono", { weight = "Regular" })
	-- config.font = wezterm.font("BlexMono Nerd Font Mono", { weight = "Light" })
	-- config.font = wezterm.font("Hack Nerd Font Mono", { weight = "Regular" })
	config.font_size = 20
	config.force_reverse_video_cursor = false
	config.freetype_load_flags = "NO_HINTING" -- Alternative option for cleaner text
	config.freetype_render_target = "HorizontalLcd" -- Improves subpixel rendering
	config.inactive_pane_hsb = {
		saturation = 1.0, -- Keep saturation the same (no dimming)
		brightness = 1.0, -- Keep brightness the same (fully visible text)
	}
	config.line_height = 1
	config.cell_width = 1
	config.use_resize_increments = true
	config.window_background_opacity = 1
	-- config.win32_system_backdrop = "Acrylic"
	config.window_decorations = "NONE | RESIZE"
	config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

	-- Performance
	config.term = "xterm-256color"
	config.front_end = "WebGpu"
	config.prefer_egl = true
	config.webgpu_power_preference = "HighPerformance"
	config.max_fps = 144
	config.underline_thickness = "1pt"
	--Workspace
	config.default_workspace = "HOME"

	--Distribution
	-- config.default_domain = "WSL:archlinux"
end

return M
