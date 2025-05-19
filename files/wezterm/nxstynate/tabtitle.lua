local wezterm = require("wezterm")

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane = tab.active_pane
	local cwd_uri = pane.current_working_dir
	local cwd = ""

	if cwd_uri then
		-- For Windows paths like file:///C:/Users/Paul
		cwd = cwd_uri:match(".*[\\/](.*)")
	end

	return {
		{ Text = " " .. (cwd or "Shell") .. " " },
	}
end)
