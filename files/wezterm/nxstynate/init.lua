local wezterm = require("wezterm")
local config = wezterm.config_builder and wezterm.config_builder() or {}
local global_theme = "osaka"

if global_theme == "rose_pine" then
	require("nxstynate.theme_rose_pine").apply(config, global_theme)
else
	require("nxstynate.theme_solarized_osaka").apply(config, global_theme)
end

require("nxstynate.statusline").apply(config, global_theme)
require("nxstynate.colors.custom").apply(config)
require("nxstynate.shell").apply(config)
require("nxstynate.options").apply(config)
require("nxstynate.background").apply(config)
require("nxstynate.keys").apply(config)
-- require("nxstynate.ssh_domain").apply(config)

return config
