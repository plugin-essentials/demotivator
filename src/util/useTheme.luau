local vide = require(script.Parent.Parent.packages.vide)
local theme = require(script.Parent.Parent.ui.theme)

local function useTheme(color: Enum.StudioStyleGuideColor, guiState: vide.Source<Enum.GuiState>)
	return vide.switch(guiState) {
		[Enum.GuiState.Idle] = theme(color, Enum.StudioStyleGuideModifier.Default),
		[Enum.GuiState.Hover] = theme(color, Enum.StudioStyleGuideModifier.Hover),
		[Enum.GuiState.Press] = theme(color, Enum.StudioStyleGuideModifier.Pressed),
		[Enum.GuiState.NonInteractable] = theme(color, Enum.StudioStyleGuideModifier.Disabled),
	}
end

return useTheme
