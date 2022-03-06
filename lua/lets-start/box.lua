local Option = require('./option')
local Box = {
	margin = 0,
	x = 0,
	y = 0,
	width = 0,
	center = false,
	longest = 0,
	buffer = nil,
}

function Box.append(self, text)
	assert(self.buffer, "Error: Box needs a buffer to draw")
	vim.api.nvim_buf_set_lines(self.buffer, self.y, -1, false, {text})
end

function Box.append_option(self, preffix, label, suffix)
	vim.api.append(self.y, )
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
