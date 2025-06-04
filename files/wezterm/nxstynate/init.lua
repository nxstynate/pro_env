local wezterm = require("wezterm")
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- require("nxstynate.theme").apply(config)
-- require("nxstynate.statusline_rose_pine").apply(config)
require("nxstynate.theme_solarized_osaka").apply(config)
require("nxstynate.statusline_osaka").apply(config)
require("nxstynate.theme_custom").apply(config)
-- require("nxstynate.tabtitle").apply(config)
require("nxstynate.shell").apply(config)
require("nxstynate.options").apply(config)
require("nxstynate.background").apply(config)
require("nxstynate.keys").apply(config)
-- require("nxstynate.ssh_domain").apply(config)

return config
