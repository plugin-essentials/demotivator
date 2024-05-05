local constants = require(script.Parent.Parent.constants)
local universes = require(script.Parent.Parent.universes)
local Promise = require(script.Parent.Parent.packages.Promise)
local vide = require(script.Parent.Parent.packages.vide)
local Toolbar = require(script.Parent.studio.Toolbar)
local ToolbarButton = require(script.Parent.studio.ToolbarButton)
local Widget = require(script.Parent.studio.Widget)
local Universe = require(script.Parent.universe.Universe)

export type AppProps = {
	plugin: Plugin,
}

local function App(props: AppProps)
	local enabled = vide.source(false)
	local universe = vide.source(nil)
	local currentUniverse = vide.source(nil)

	local promise: Promise.TypedPromise<nil>? = nil
	local function nextUniverse()
		if promise then
			promise:cancel()
			promise = nil
		end

		universe(nil) -- vide.show wouldn't reload because it was always truthy
		task.wait()
		promise = universes.loadUniverse():andThen(universe)
	end

	nextUniverse()
	universes.loadCurrentUniverse():andThen(currentUniverse)

	local toolbar = Toolbar {
		plugin = props.plugin,
		name = constants.PLUGIN_NAME,
	}
	vide.cleanup(toolbar)

	local open = ToolbarButton {
		toolbar = toolbar,
		id = "open",
		text = constants.PLUGIN_NAME,
		tooltip = `Open {constants.PLUGIN_NAME}`,
		icon = "rbxassetid://17389034771",
		active = enabled,
		onClick = function()
			enabled(not enabled())
		end,
	}
	vide.cleanup(open)

	local widget = Widget {
		plugin = props.plugin,
		id = "main",
		title = constants.PLUGIN_NAME,
		dockState = Enum.InitialDockState.Float,
		enabled = enabled,
		floatSize = Vector2.new(350, 500),
		minSize = Vector2.new(350, 500),
		zIndexBehavior = Enum.ZIndexBehavior.Sibling,
		onClose = function()
			enabled(false)
		end,
		children = {
			vide.create "UIPadding" {
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
				PaddingTop = UDim.new(0, 10),
				PaddingBottom = UDim.new(0, 10),
			},

			Universe {
				universe = universe,
				currentUniverse = currentUniverse,
				onNext = nextUniverse,
			},
		},
	}
	vide.cleanup(widget)
end

return App
