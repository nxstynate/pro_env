local M = {}

function M.apply(config)
	config.colors = config.colors or {}
	config.colors.background = "#000"
end
return M
