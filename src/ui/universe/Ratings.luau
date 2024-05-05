local universes = require(script.Parent.Parent.Parent.universes)
local lucide = require(script.Parent.Parent.Parent.packages.lucide)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local theme = require(script.Parent.Parent.theme)

local function RatingDivider()
	return vide.create "Frame" {
		Name = "divider",
		BackgroundColor3 = theme(Enum.StudioStyleGuideColor.Tab),
		Size = UDim2.fromOffset(1, 55),
	}
end

export type RatingCategory = {
	image: string,
	imageRectOffset: Vector2?,
	imageRectSize: Vector2?,
	count: number,
}

local function RatingCategory(props: RatingCategory)
	return vide.create "Frame" {
		Name = "rating",
		Size = UDim2.fromOffset(65, 65),
		BackgroundTransparency = 1,

		vide.create "ImageLabel" {
			Name = "icon",

			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.fromScale(0.5, 0),
			Size = UDim2.fromOffset(40, 40),

			BackgroundTransparency = 1,

			Image = props.image,
			ImageRectOffset = props.imageRectOffset,
			ImageRectSize = props.imageRectSize,
			ImageColor3 = theme(Enum.StudioStyleGuideColor.SubText),
		},

		vide.create "TextLabel" {
			Name = "count",

			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.fromScale(0.5, 1),
			Size = UDim2.new(1, 0, 0, 20),

			BackgroundTransparency = 1,

			Text = "10.2K",
			FontFace = Font.fromEnum(Enum.Font.SourceSansSemibold),
			TextSize = 20,
			TextColor3 = theme(Enum.StudioStyleGuideColor.SubText),
			TextYAlignment = Enum.TextYAlignment.Bottom,
		},
	}
end

export type RatingsProps = {
	universe: universes.Universe,
}

local function Ratings(props: RatingsProps)
	local likesIcon = lucide.GetAsset("thumbs-up")
	local dislikesIcon = lucide.GetAsset("thumbs-down")
	local favoritesIcon = lucide.GetAsset("star")

	return vide.create "Frame" {
		Name = "ratings",
		Size = UDim2.new(1, 0, 0, 65),
		BackgroundTransparency = 1,

		vide.create "UIListLayout" {
			Padding = UDim.new(0, 10),
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
		},

		RatingCategory {
			image = favoritesIcon.Url,
			imageRectOffset = favoritesIcon.ImageRectOffset,
			imageRectSize = favoritesIcon.ImageRectSize,
			count = 0,
		},

		RatingDivider(),

		RatingCategory {
			image = likesIcon.Url,
			imageRectOffset = likesIcon.ImageRectOffset,
			imageRectSize = likesIcon.ImageRectSize,
			count = 0,
		},

		RatingDivider(),

		RatingCategory {
			image = dislikesIcon.Url,
			imageRectOffset = dislikesIcon.ImageRectOffset,
			imageRectSize = dislikesIcon.ImageRectSize,
			count = 0,
		},
	}
end

return Ratings
