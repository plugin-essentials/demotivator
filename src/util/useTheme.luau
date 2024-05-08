local vide = require(script.Parent.Parent.packages.vide)
local theme = require(script.Parent.Parent.ui.theme)

local GUI_STATE_MODIFIER_MAP = {
	[Enum.GuiState.Idle] = Enum.StudioStyleGuideModifier.Default,
	[Enum.GuiState.Hover] = Enum.StudioStyleGuideModifier.Hover,
	[Enum.GuiState.Press] = Enum.StudioStyleGuideModifier.Pressed,
	[Enum.GuiState.NonInteractable] = Enum.StudioStyleGuideModifier.Disabled,
}

local function useTheme(color: Enum.StudioStyleGuideColor, guiState: Enum.GuiState | vide.Source<Enum.GuiState>)
	return function()
		local modifier = GUI_STATE_MODIFIER_MAP[vide.read(guiState)]
		return theme(color, modifier)()
	end
end

return useTheme
