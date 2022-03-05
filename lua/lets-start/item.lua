local Item = {}

Item.prototype = {
	prefix = '',
	label = '',
	suffix = ''
}

function Item.render(self, width)
	local total_len = string.len(self.prefix) + string.len(self.label) + string.len(self.suffix)
	local space = string.rep(" ", math.abs(width - total_len))
	local item = string.format('%s %s%s%s', self.prefix, self.label, space, self.suffix)

	return item
end

function Item:new()
	local o = {}

	setmetatable(o, self)
	self.__index = self

	return o
end

return Item
