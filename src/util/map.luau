local function map<T, K>(t: { T }, transform: (T) -> K): { K }
	local new = {}

	for _, value in t do
		table.insert(new, transform(value))
	end

	return new
end

return map
