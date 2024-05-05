local lucide = require(script.Parent.Parent.Parent.packages.lucide)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local useColor = require(script.Parent.Parent.Parent.util.useColor)
local theme = require(script.Parent.Parent.theme)

export type NextButtonProps = {
	onClick: () -> ()?,
}

local function NextButton(props: NextButtonProps)
	local nextIcon = lucide.GetAsset("arrow-big-right")

	local hovering = vide.source(false)
	local pressing = vide.source(false)

	return vide.create "TextButton" {
		Name = "next",

		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.fromScale(1, 1),
		Size = UDim2.new(0, 40, 0, 40),

		BackgroundColor3 = useColor(Enum.StudioStyleGuideColor.Button, {
			hovering = hovering,
			pressing = pressing,
		}),

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
			Color = useColor(Enum.StudioStyleGuideColor.ButtonBorder, {
				hovering = hovering,
				pressing = pressing,
			}),
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
			ImageColor3 = theme(Enum.StudioStyleGuideColor.ButtonText),
		},

		vide.action(function(button)
			vide.cleanup(button.MouseEnter:Connect(function()
				hovering(true)
			end))

			vide.cleanup(button.MouseLeave:Connect(function()
				hovering(false)
			end))

			vide.cleanup(button.MouseButton1Down:Connect(function()
				pressing(true)
			end))

			vide.cleanup(button.MouseButton1Up:Connect(function()
				pressing(false)
			end))

			if props.onClick then
				vide.cleanup(button.MouseButton1Click:Connect(props.onClick))
			end
		end),
	}
end

return NextButton
