local function find<T>(t: { T }, predicate: (T) -> boolean): T?
	for _, value in t do
		if predicate(value) then
			return value
		end
	end

	return
end

return find
