local vide = require(script.Parent.Parent.Parent.packages.vide)

export type WidgetProps = {
	plugin: Plugin,
	id: string,
	title: string,
	dockState: Enum.InitialDockState,
	enabled: boolean | vide.Source<boolean>,
	floatSize: Vector2,
	minSize: Vector2,
	zIndexBehavior: Enum.ZIndexBehavior,
	onClose: () -> ()?,
	children: ({ Instance } | vide.Source<{ Instance }>)?,
}

local function Widget(props: WidgetProps): DockWidgetPluginGui
	local widget = props.plugin:CreateDockWidgetPluginGui(
		props.id,
		DockWidgetPluginGuiInfo.new(
			props.dockState,
			vide.read(props.enabled),
			true,
			props.floatSize.X,
			props.floatSize.Y,
			props.minSize.X,
			props.minSize.Y
		)
	)

	widget.Title = props.title
	widget.ZIndexBehavior = props.zIndexBehavior

	vide.apply(widget) { props.children }

	if props.onClose then
		widget:BindToClose(props.onClose)
	end

	vide.effect(function()
		widget.Enabled = vide.read(props.enabled)
	end)

	return widget
end

return Widget
