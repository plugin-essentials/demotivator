local vide = require(script.Parent.Parent.packages.vide)
local theme = require(script.Parent.Parent.ui.theme)

local function useColor(
	color: Enum.StudioStyleGuideColor,
	state: {
		hovering: boolean | vide.Source<boolean>,
		pressing: boolean | vide.Source<boolean>,
	}
)
	return function()
		if vide.read(state.pressing) then
			return theme(color, Enum.StudioStyleGuideModifier.Pressed)()
		end

		if vide.read(state.hovering) then
			return theme(color, Enum.StudioStyleGuideModifier.Hover)()
		end

		return theme(color)()
	end
end

return useColor
