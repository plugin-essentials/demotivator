local RunService = game:GetService("RunService")
local vide = require(script.Parent.Parent.packages.vide)

export type SpinnerProps = {
	color: Color3 | vide.Source<Color3>,
}

local function Spinner(props: SpinnerProps)
	local timer = vide.source(os.clock())

	return vide.create "ImageLabel" {
		Name = "spinner",

		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(95, 95),

		BackgroundTransparency = 1,

		Image = "rbxassetid://17129201431",
		ImageColor3 = props.color,

		Rotation = function()
			local angle = timer() * 180
			angle %= 360
			return angle
		end,

		vide.cleanup(RunService.RenderStepped:Connect(function()
			timer(os.clock())
		end)),
	}
end

return Spinner
