local PLUGIN_NAME = "Demotivator"
local IS_DEV = false -- IS_DEV will fetch a game off the front page instead of your own

if IS_DEV then
	PLUGIN_NAME ..= " [DEV]"
end

return {
	PLUGIN_NAME = PLUGIN_NAME,
	IS_DEV = IS_DEV,
}
