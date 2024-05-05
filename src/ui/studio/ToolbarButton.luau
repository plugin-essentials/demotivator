local vide = require(script.Parent.Parent.Parent.packages.vide)

export type ToolbarButtonProps = {
	toolbar: PluginToolbar,
	id: string,
	text: string?,
	tooltip: string,
	icon: string,
	active: boolean | vide.Source<boolean>,
	onClick: () -> ()?,
}

local function ToolbarButton(props: ToolbarButtonProps)
	local button = props.toolbar:CreateButton(props.id, props.tooltip, props.icon, props.text)

	vide.effect(function()
		button:SetActive(vide.read(props.active))
	end)

	if props.onClick then
		vide.cleanup(button.Click:Connect(props.onClick))
	end

	return button
end

return ToolbarButton
