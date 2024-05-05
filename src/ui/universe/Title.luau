local universes = require(script.Parent.Parent.Parent.universes)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local theme = require(script.Parent.Parent.theme)

export type TitleProps = {
	universe: universes.Universe,
}

local function Title(props: TitleProps)
	return vide.create "TextLabel" {
		Name = "title",
		AutomaticSize = Enum.AutomaticSize.XY,

		BackgroundTransparency = 1,

		Text = props.universe.name,
		FontFace = Font.fromEnum(Enum.Font.SourceSansBold),
		TextSize = 34,
		TextColor3 = theme(Enum.StudioStyleGuideColor.MainText),
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	}
end

return Title
