-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                          https://tradeskillmaster.com                          --
--    All Rights Reserved - Detailed license information included with addon.     --
-- ------------------------------------------------------------------------------ --

local TSM = select(2, ...) ---@type TSM
local Environment = TSM.Init("Environment") ---@class Environment
Environment.FEATURES = {
	TEXTURE_SET_GRADIENT = newproxy(),
	REGION_SET_RESIZE_BOUNDS = newproxy(),
	PLAYER_INTERACTION_MANAGER = newproxy(),
	C_CONTAINER = newproxy(),
	REAGENT_BAG = newproxy(),
	CONNECTED_FACTION_AH = newproxy(),
	HONOR_POINTS = newproxy(),
	MULTIPLE_ENCHANTING_VELLUMS = newproxy(),
	SUB_PROFESSION_NAMES = newproxy(),
	AH_COPPER = newproxy(),
	AH_STACKS = newproxy(),
	AH_UNCOLLECTED_FILTER = newproxy(),
	AH_UPGRADES_FILTER = newproxy(),
	BATTLE_PETS = newproxy(),
	GARRISON = newproxy(),
	GUILD_BANK = newproxy(),
	C_AUCTION_HOUSE = newproxy(),
	COMMODITY_ITEMS = newproxy(),
	CRAFTING_QUALITY = newproxy(),
	C_TRADE_SKILL_UI = newproxy(),
	C_TOOLTIP_INFO = newproxy(),
	REAGENT_BANK = newproxy(),
	BLACK_MARKET_AH = newproxy(),
}
local private = {
	features = nil,
}
local VERSION_RAW = GetAddOnMetadata("TradeSkillMaster", "Version")
local IS_DEV_VERSION = strmatch(VERSION_RAW, "^@tsm%-project%-version@$") and true or false
local GAME_VERSION = nil
do
	if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
		GAME_VERSION = "VANILLA"
	elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
		GAME_VERSION = "WRATH"
	elseif WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
		GAME_VERSION = "RETAIL"
	end
	assert(GAME_VERSION, "Invalid WoW game version: "..tostring(WOW_PROJECT_ID))
end



-- ============================================================================
-- Module Loading
-- ============================================================================

Environment:OnModuleLoad(function()
	private.features = {
		[Environment.FEATURES.TEXTURE_SET_GRADIENT] = not Environment.IsVanillaClassic(),
		[Environment.FEATURES.REGION_SET_RESIZE_BOUNDS] = not Environment.IsVanillaClassic(),
		[Environment.FEATURES.PLAYER_INTERACTION_MANAGER] = not Environment.IsVanillaClassic(),
		[Environment.FEATURES.C_CONTAINER] = not Environment.IsVanillaClassic(),
		[Environment.FEATURES.REAGENT_BAG] = Environment.IsRetail(),
		[Environment.FEATURES.CONNECTED_FACTION_AH] = Environment.IsRetail(),
		[Environment.FEATURES.HONOR_POINTS] = Environment.IsWrathClassic(),
		[Environment.FEATURES.MULTIPLE_ENCHANTING_VELLUMS] = Environment.IsWrathClassic(),
		[Environment.FEATURES.SUB_PROFESSION_NAMES] = not Environment.IsRetail(),
		[Environment.FEATURES.AH_COPPER] = not Environment.IsRetail(),
		[Environment.FEATURES.AH_STACKS] = not Environment.IsRetail(),
		[Environment.FEATURES.AH_UNCOLLECTED_FILTER] = Environment.IsRetail(),
		[Environment.FEATURES.AH_UPGRADES_FILTER] = Environment.IsRetail(),
		[Environment.FEATURES.BATTLE_PETS] = Environment.IsRetail(),
		[Environment.FEATURES.GARRISON] = Environment.IsRetail(),
		[Environment.FEATURES.GUILD_BANK] = not Environment.IsVanillaClassic(),
		[Environment.FEATURES.C_AUCTION_HOUSE] = Environment.IsRetail(),
		[Environment.FEATURES.COMMODITY_ITEMS] = Environment.IsRetail(),
		[Environment.FEATURES.CRAFTING_QUALITY] = Environment.IsRetail(),
		[Environment.FEATURES.C_TRADE_SKILL_UI] = Environment.IsRetail(),
		[Environment.FEATURES.C_TOOLTIP_INFO] = Environment.IsRetail(),
		[Environment.FEATURES.REAGENT_BANK] = Environment.IsRetail(),
		[Environment.FEATURES.BLACK_MARKET_AH] = Environment.IsRetail(),
	}
end)



-- ============================================================================
-- Module Functions
-- ============================================================================

---Returns whether or not we're running in a dev environment.
---@return boolean
function Environment.IsDev()
	return IS_DEV_VERSION
end

---Returns whether or not we're running in a test environment.
---@return boolean
function Environment.IsTest()
	return VERSION_RAW == "v4.99.99"
end

---Gets the current addon version.
---@return string
function Environment.GetVersion()
	return Environment.IsDev() and "Dev" or VERSION_RAW
end

---Returns whether or not we're running within the retail version of the game.
---@return boolean
function Environment.IsRetail()
	return GAME_VERSION == "RETAIL"
end

---Returns whether or not we're running within the Vanilla Classic version of the game.
---@return boolean
function Environment.IsVanillaClassic()
	return GAME_VERSION == "VANILLA"
end

---Returns whether or not we're running within the Wrath Classic version of the game.
---@return boolean
function Environment.IsWrathClassic()
	return GAME_VERSION == "WRATH"
end

---Checks whether or not a features is available in the current game version.
---@param feature table A value of Environment.FEATURES
---@return boolean
function Environment.HasFeature(feature)
	local result = private.features[feature]
	assert(type(result) == "boolean")
	return result
end
