local universes = require(script.Parent.Parent.Parent.universes)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local useTheme = require(script.Parent.Parent.Parent.util.useTheme)

local PROGRESS_BAR_PERIOD = 0.5
local PROGRESS_BAR_DAMPING = 1

export type ProgressProps = {
	universe: universes.Universe,
	title: string,
	percentage: number,
	messageIncomplete: string?,
	messageComplete: string?,
}

local function Progress(props: ProgressProps)
	local color = if props.percentage >= 1
		then useTheme(Enum.StudioStyleGuideColor.MainButton)
		else useTheme(Enum.StudioStyleGuideColor.ErrorText)
	local message = if props.percentage >= 1 then props.messageComplete else props.messageIncomplete

	local progressBarFill = vide.source(0)

	return vide.create "Frame" {
		Name = "progress",
		Size = UDim2.new(1, 0, 0, 35),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,

		vide.create "TextLabel" {
			Name = "title",
			Size = UDim2.new(1, 0, 0, 25),
			BackgroundTransparency = 1,

			Text = props.title,
			FontFace = Font.fromEnum(Enum.Font.SourceSansBold),
			TextSize = 25,
			TextColor3 = useTheme(Enum.StudioStyleGuideColor.MainText),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
		},

		vide.create "Frame" {
			Name = "bar",

			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.fromScale(0, 1),
			Size = UDim2.new(1, 0, 0, 8),

			BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.Dark),

			vide.create "Frame" {
				Name = "completed",
				Size = vide.spring(function()
					return UDim2.fromScale(progressBarFill(), 1)
				end, PROGRESS_BAR_PERIOD, PROGRESS_BAR_DAMPING),
				BackgroundColor3 = color,

				vide.action(function()
					progressBarFill(math.clamp(props.percentage, 0, 1))
				end),
			},
		},

		vide.create "TextLabel" {
			Name = "message",
			Position = UDim2.new(0, 0, 1, 5),
			AutomaticSize = Enum.AutomaticSize.XY,

			BackgroundTransparency = 1,

			Text = message,
			FontFace = Font.fromEnum(Enum.Font.SourceSans),
			TextSize = 20,
			TextColor3 = useTheme(Enum.StudioStyleGuideColor.SubText),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
		},
	}
end

return Progress
