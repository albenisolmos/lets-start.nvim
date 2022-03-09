local Util = require('lets-start.util')
local Box = {
	margin = 1,
	x = 0,
	y = 0,
	width = 0,
	max_width = 0,
	height = -1,
	center = false,
	longest = 0,
	buffer = false,
}

local function indent_text(text, side, nspace)
	local space = string.rep(' ', nspace)
	if side == 'left' then
		return space .. text
	elseif side == 'right' then
		return text .. space
	elseif type(side) == 'number' then
		local a = string.sub(text, 1, side)
		local b = string.sub(text, side, -1)
		return a .. space .. b
	end
end

local function indent_lines(lines, side, nspace)
	for i, text in pairs(lines) do
		lines[i] = indent_text(text, side, nspace)
	end
end

function Box.append(self, text)
	self.height = self.height + 1

	assert(self.buffer, "Error: Box needs a buffer to draw")

	local y = self.y + self.height
	vim.api.nvim_buf_set_lines(self.buffer, y, -1, false, {text})
end

function Box.set_options(self, opts)
	opts.parent = self

	opts:on('option_made', function(text)
		local indent = self.center and
			math.abs(self.width - self.max_width)/2 or 0

		self:append(Util.indent_text(text, 'left', indent))
	end)

	opts:on('add', function(prefix, label, suffix)
		local len = string.len(prefix) + string.len(label) + string.len(suffix)

		if len > self.longest then
			self.longest = len
		end

		self.width = self.longest
	end)
end

function Box.fit(self)
	if self.center then
		self.x = (self.width - self.longest)/2
		local lines = vim.api.nvim_buf_get_lines(0, self.y, self.height+1, false)

		indent_lines(lines, 'left', self.x)
		vim.api.nvim_buf_set_lines(0, self.y, self.height+1, false, lines)
	end
end

function Box.new(args)
	local o = {}

	setmetatable(o, Box)
	Box.__index = Box

	local win = args.win or vim.api.nvim_get_current_win()
	o.max_width = vim.api.nvim_win_get_width(win)

	for k, v in pairs(args) do
		if o[k] ~= nil then
			o[k] = v
		end
	end

	return o
end

return Box
