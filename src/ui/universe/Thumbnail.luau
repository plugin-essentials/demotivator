local universes = require(script.Parent.Parent.Parent.universes)
local vide = require(script.Parent.Parent.Parent.packages.vide)

local ASPECT_RATIO = 16 / 9

export type ThumbnailProps = {
	universe: universes.Universe,
}

local function Thumbnail(props: ThumbnailProps)
	return vide.create "ImageLabel" {
		Name = "thumbnail",
		Size = UDim2.fromScale(1, 1),

		BackgroundTransparency = 1,
		Image = `rbxthumb://type=GameThumbnail&id={props.universe.rootPlaceId}&w=768&h=432`,

		vide.create "UIAspectRatioConstraint" {
			AspectRatio = ASPECT_RATIO,
			DominantAxis = Enum.DominantAxis.Width,
		},
	}
end

return Thumbnail
