local Box = require('lets-start.box')
local Options = require('lets-start.options')
local M = {}

function M.init()
	local buf = vim.api.nvim_get_current_buf()
	local box = Box.new {
		buffer = buf,
		y = 0,
		x = 0,
		center = true
	}

	local opts = Options.new()
	opts.expand = 20
	box:set_options(opts)
	opts:add("", "New file", "[n]", {buf, 'n', 'n', '<cmd>lua vim.api.nvim_command("enew")<cr>'})
	opts:add("", "Open file", "[f]", {buf, 'n', 'f', '<cmd>lua vim.api.nvim_command("NvimTreeOpen")<cr>'})
	opts:add("", "Close", "[q]", {buf, 'n', 'q', '<cmd>qa<cr>'})
	opts:done()
end

return M
