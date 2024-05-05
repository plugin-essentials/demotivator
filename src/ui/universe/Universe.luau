local NextButton = require(script.Parent.NextButton)
local universes = require(script.Parent.Parent.Parent.universes)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local Spinner = require(script.Parent.Parent.Spinner)
local theme = require(script.Parent.Parent.theme)
local Progress = require(script.Parent.Progress)
local Thumbnail = require(script.Parent.Thumbnail)
local Title = require(script.Parent.Title)

export type UniverseProps = {
	universe: universes.Universe | vide.Source<universes.Universe>,
	currentUniverse: universes.Universe | vide.Source<universes.Universe>,
	onNext: () -> ()?,
}

local function calculateDifferencePercentage(a: number, b: number)
	return (b - a) / a
end

local function Universe(props: UniverseProps)
	return vide.show(function()
		return vide.read(props.universe) ~= nil and vide.read(props.currentUniverse) ~= nil
	end, function()
		local universe = vide.read(props.universe)
		local currentUniverse = vide.read(props.currentUniverse)

		return {

			vide.create "Frame" {
				Name = "container",
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,

				vide.create "UIListLayout" {
					Padding = UDim.new(0, 10),
					HorizontalAlignment = Enum.HorizontalAlignment.Left,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					FillDirection = Enum.FillDirection.Vertical,
					SortOrder = Enum.SortOrder.LayoutOrder,
				},

				Thumbnail { universe = universe },
				Title { universe = universe },

				vide.create "Frame" {
					Name = "divider",
					BackgroundTransparency = 1,
					Size = UDim2.fromOffset(0, 5),
				},

				Progress {
					universe = universe,
					title = "Visits",
					percentage = currentUniverse.visits / universe.visits,
					messageIncomplete = `{math.floor(
						calculateDifferencePercentage(currentUniverse.visits, universe.visits) * 100
					)}% more than you`,
					messageComplete = `{math.floor(
						calculateDifferencePercentage(universe.visits, currentUniverse.visits) * 100
					)}% less than you`,
				},

				Progress {
					universe = universe,
					title = "CCU",
					percentage = currentUniverse.playing / universe.playing,
					messageIncomplete = `{math.floor(
						calculateDifferencePercentage(currentUniverse.playing, universe.playing) * 100
					)}% more than you`,
					messageComplete = `{math.floor(
						calculateDifferencePercentage(universe.playing, currentUniverse.playing) * 100
					)}% less than you`,
				},
			},

			NextButton { onClick = props.onNext },
		}
	end, function()
		return Spinner { color = theme(Enum.StudioStyleGuideColor.SubText) }
	end)
end

return Universe
