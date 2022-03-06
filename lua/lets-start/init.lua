local Box = require('./box')
local M = {}

function M.init()
	local buf = vim.api.nvim_get_current_buf() -- ...and it's buffer handle.
	local box = Box.new {
		buffer = buf,
		y = 0,
		x = 0
	}

	box:append_option("", "New file", "[n]")
	box:append_option("", "Open file", "[f]")
	box:append_option("", "Close", "[q]")
end

return M
