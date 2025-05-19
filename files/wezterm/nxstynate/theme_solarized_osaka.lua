local M = {}

function M.apply(config)
	config.colors = {
		foreground = "#657B83",
		background = "#000",
		cursor_bg = "#586E75",
		cursor_border = "#586E75",
		cursor_fg = "#101010",
		selection_bg = "#103956",
		selection_fg = "#657B83",

		ansi = {
			"#00141A", -- black
			"#B7211F", -- red
			"#859900", -- green
			"#B58900", -- yellow
			"#268BD2", -- blue
			"#D33682", -- purple
			"#2AA198", -- cyan
			"#EEE8D5", -- white
		},

		brights = {
			"#586E75", -- brightBlack
			"#B7211F", -- brightRed
			"#9EACAD", -- brightGreen
			"#B58900", -- brightYellow
			"#6C71C4", -- brightBlue
			"#494FB6", -- brightPurple
			"#859900", -- brightCyan
			"#FFFFFF", -- brightWhite
		},
	}
end

return M
