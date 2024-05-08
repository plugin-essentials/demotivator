local lucide = require(script.Parent.Parent.Parent.packages.lucide)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local useTheme = require(script.Parent.Parent.Parent.util.useTheme)

export type NextButtonProps = {
	onClick: () -> ()?,
}

local function NextButton(props: NextButtonProps)
	local nextIcon = lucide.GetAsset("arrow-big-right")
	local guiState = vide.source(Enum.GuiState.Idle)

	return vide.create "TextButton" {
		Name = "next",

		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.fromScale(1, 1),
		Size = UDim2.new(0, 40, 0, 40),

		BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.Button, guiState),

		MouseButton1Click = props.onClick,

		vide.changed("GuiState", guiState),

		vide.create "UIPadding" {
			PaddingTop = UDim.new(0, 5),
			PaddingBottom = UDim.new(0, 5),
			PaddingLeft = UDim.new(0, 5),
			PaddingRight = UDim.new(0, 5),
		},

		vide.create "UICorner" {
			CornerRadius = UDim.new(0, 5),
		},

		vide.create "UIStroke" {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Thickness = 1,
			Color = useTheme(Enum.StudioStyleGuideColor.ButtonBorder, guiState),
		},

		vide.create "ImageLabel" {
			Name = "icon",

			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(35, 35),

			BackgroundTransparency = 1,

			Image = nextIcon.Url,
			ImageRectOffset = nextIcon.ImageRectOffset,
			ImageRectSize = nextIcon.ImageRectSize,
			ImageColor3 = useTheme(Enum.StudioStyleGuideColor.ButtonText, guiState),
		},
	}
end

return NextButton
