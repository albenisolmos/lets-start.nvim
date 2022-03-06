local Option = require('lets-start.option')
local Box = {
	margin = 1,
	x = 1,
	y = 1,
	width = 1,
	center = false,
	longest = 0,
	buffer = true,
}

function Box.append(self, text)
	assert(self.buffer, "Error: Box needs a buffer to draw")
	vim.api.nvim_buf_set_lines(self.buffer, self.y, -1, false, {text})
end

function Box.append_option(self, preffix, label, suffix)
	assert(self.buffer, "Error: Box needs a buffer to draw")
	vim.api.nvim_buf_set_lines(self.buffer, self.y, -1, false, {
		Option(preffix, label, suffix, self.width)})
end

function Box.new(args)
	local o = {}

	setmetatable(o, Box)
	Box.__index = Box

	for k, v in pairs(args) do
		if o[k] then
			o[k] = v
		end
	end

	return o
end

return Box
