local vide = require(script.packages.vide)
local App = require(script.ui.App)

local unmount = vide.mount(function()
	App { plugin = plugin }
end)

plugin.Unloading:Connect(unmount)
