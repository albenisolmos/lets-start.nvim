local M = {
	PairTable = { items = nil }
}

function M.PairTable.print(self)
	local text = '{'
	for i, v in pairs(self.items) do
		text = text .. i .. ':'..v .. ','
	end
	text = text .. '}'
	print(text)
end

function M.PairTable.insert(self, item1, item2)
	assert(item1 and item1, "There must be two items to insert")

	table.insert(self.items, item1)
	table.insert(self.items, item2)
end

function M.PairTable.foreach(self, callback)
	local i = 0
	local t = self.items
	for _, _ in pairs(t) do
		i = i+1
		pcall(callback, t[i], t[i+1], i)
		i = i + 1
	end
end

function M.PairTable.new()
	local o = {}

	setmetatable(o, M.PairTable)
	M.PairTable.__index = M.PairTable
	o.items = {}
	setmetatable(o.items, {__mode = 'v'})

	return o
end

function M.indent_text(text, side, nspace)
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

function M.indent_lines(lines, side, nspace)
	for i, text in pairs(lines) do
		lines[i] = M.indent_text(text, side, nspace)
	end
end

function M.get_n_spaces_needed(textlen, width)
	local space_len = width - textlen

	if space_len < 0 then space_len = 0 end

	return space_len
end

function M.debug(text)
	vim.api.nvim_command('!echo "'..text..'" >> ~/nvim-debug.txt')
end

return M
