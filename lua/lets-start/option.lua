return function(prefix, label, suffix, width)
	width = width or 0
	local total_len = string.len(prefix) + string.len(label) + string.len(suffix)
	local space_len = width - total_len

	if space_len < 0 then space_len = 0 end

	local space = string.rep(' ', space_len)
	return string.format('%s %s%s%s', prefix, label, space, suffix)
end
