local HttpService = game:GetService("HttpService")
local constants = require(script.Parent.constants)
local gamesApiTypes = require(script.Parent.gamesApiTypes)
local Promise = require(script.Parent.packages.Promise)
local map = require(script.Parent.util.map)

export type Universe = gamesApiTypes.GameDetailResponse

local random = Random.new()
local currentUniverse: Promise.TypedPromise<Universe>? = nil

local function loadSorts(): Promise.TypedPromise<gamesApiTypes.GameSortsResponse>
	return Promise.try(function()
		local response = HttpService:GetAsync("https://games.roproxy.com/v1/games/sorts?GameSortsContext=3")
		local sorts = HttpService:JSONDecode(response)
		return sorts
	end):catch(warn)
end

local function listGames(): Promise.TypedPromise<{ gamesApiTypes.GameResponseModel }>
	return loadSorts()
		:andThen(function(sorts)
			local popularSort = sorts.sorts[1]
			local response = HttpService:GetAsync(
				`https://games.roproxy.com/v1/games/list?sortToken={popularSort.token}&startRows=0&maxRows=0&hasMoreRows=true&sortPosition=5&contextCountryRegionId={popularSort.contextCountryRegionId}&pageContext.pageId={sorts.pageContext.pageId}&pageContext.isSeeAllPage={sorts.pageContext.isSeeAllPage}`
			)
			local search = HttpService:JSONDecode(response)
			return search.games
		end)
		:catch(warn)
end

local universes = listGames()
	:andThen(function(games)
		local universeIds = map(games, function(game)
			return game.universeId
		end)

		local response =
			HttpService:GetAsync("https://games.roproxy.com/v1/games?universeIds=" .. table.concat(universeIds, ","))
		local details: { gamesApiTypes.GameDetailResponse } = HttpService:JSONDecode(response).data
		return details
	end)
	:catch(warn)

local function loadUniverse(): Promise.TypedPromise<Universe>
	return universes:andThen(function(universes)
		local universe = universes[random:NextInteger(1, #universes)]
		return universe
	end)
end

local function loadCurrentUniverse(): Promise.TypedPromise<Universe>
	if currentUniverse then
		return currentUniverse
	end

	if constants.IS_DEV then
		currentUniverse = loadUniverse() :: any
		return currentUniverse :: any
	end

	if game.GameId <= 0 then
		currentUniverse = Promise.delay(2e9) :: any
		return currentUniverse :: any
	end

	currentUniverse = Promise.try(function()
		local response = HttpService:GetAsync("https://games.roproxy.com/v1/games?universeIds=" .. game.GameId)
		local details = HttpService:JSONDecode(response).data[1]
		return details
	end)

	return currentUniverse :: any
end

return {
	loadUniverse = loadUniverse,
	loadCurrentUniverse = loadCurrentUniverse,
}
