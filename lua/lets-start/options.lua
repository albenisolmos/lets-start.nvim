local Util = require('lets-start.util')
local M = {
	width = 0,
	expand = 5,
	keymaps = false,
	options = false,
	parent = false,
	signals = {
		add = nil,
		reset = nil,
		option_made = nil
	}
}

function M.reset(self)
	self.keymaps:foreach(function(a, b)
		vim.api.nvim_buf_del_keymap(a, b)
	end)

	self.keymaps = nil
	pcall(self.signals.reset)
end

function M.on(self, signal, callback)
	self.signals[signal] = callback
end

function M.add(self, prefix, label, suffix, keymap)
	if keymap then
		self.keymaps:insert(keymap[2], keymap[3])
		table.insert(keymap, { noremap = true, silent = true})
		vim.api.nvim_buf_set_keymap(unpack(keymap))
	end

	self.options:insert(prefix..label, suffix)
	pcall(self.signals.add, prefix, label, suffix, keymap)
end

function M.done(self)
	local text = ''
	local len = 0
	local total_len = 0
	local parent = self.parent or {
		max_width = 0,
		width = 0
	}

	parent.width = parent.width + self.expand
	self.options:foreach(function(a, b)
		len = string.len(a) + string.len(b)
		total_len = len + self.expand

		if total_len < parent.max_width then
			if len == parent.width then
				parent.width = parent.width + self.expand
			end
		elseif total_len > parent.max_width then
			parent.width = total_len - (total_len - parent.max_width)
		end

		text = Util.indent_text(a, 'right',
			Util.get_n_spaces_needed(len, parent.width)) .. b

		pcall(self.signals.option_made, text)
	end)
end

function M.new()
	local o = {}

	setmetatable(o, M)
	M.__index = M
	o.keymaps = Util.PairTable.new()
	o.options = Util.PairTable.new()

	return o
end

return M
