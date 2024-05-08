local vide = require(script.Parent.Parent.packages.vide)
local studio = settings():GetService("Studio")

local GUI_STATE_MODIFIER_MAP = {
	[Enum.GuiState.Idle] = Enum.StudioStyleGuideModifier.Default,
	[Enum.GuiState.Hover] = Enum.StudioStyleGuideModifier.Hover,
	[Enum.GuiState.Press] = Enum.StudioStyleGuideModifier.Pressed,
	[Enum.GuiState.NonInteractable] = Enum.StudioStyleGuideModifier.Disabled,
}

local theme = vide.source(studio.Theme)
studio.ThemeChanged:Connect(function()
	theme(studio.Theme)
end)

local function useTheme(color: Enum.StudioStyleGuideColor, guiState: (Enum.GuiState | vide.Source<Enum.GuiState>)?)
	return function()
		local modifier = if guiState then GUI_STATE_MODIFIER_MAP[vide.read(guiState)] else nil
		return theme():GetColor(color, modifier)
	end
end

return useTheme
