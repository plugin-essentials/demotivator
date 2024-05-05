local function mergeDictionaries(t: {}, ...: {})
	local new = table.clone(t)

	for _, merge in { ... } do
		for index, value in merge do
			new[index] = value
		end
	end

	return new
end

return mergeDictionaries
