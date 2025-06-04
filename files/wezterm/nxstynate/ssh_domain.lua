local wezterm = require("wezterm")

local M = {}

function M.apply(config)
	config.ssh_domains = {
		{
			-- This name identifies the domain
			name = "PaulPurvis",
			-- The hostname or address to connect to. Will be used to match settings
			-- from your ssh config file
			remote_address = "192.168.1.131",
			-- The username to use on the remote host
			username = "nxstynate",
		},
	}
end

return M
