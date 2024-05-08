local RunService = game:GetService("RunService")
local vide = require(script.packages.vide)
local App = require(script.ui.App)

if RunService:IsClient() then
	return
end

local unmount = vide.mount(function()
	App { plugin = plugin }
end)

plugin.Unloading:Connect(unmount)
