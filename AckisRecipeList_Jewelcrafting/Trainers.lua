-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-------------------------------------------------------------------------------
-- Module namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local addon = private.addon
local constants = addon.constants
local module = addon:GetModule(private.module_name)

local Z = constants.ZONE_NAMES

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeTrainers()
	addon:AddTrainer(5388,  "Ingo Woolybush", Z.DUSTWALLOW_MARSH, 66.3, 45.1, "Alliance")
	addon:AddTrainer(15501, "Aleinia", Z.EVERSONG_WOODS, 48.5, 47.5, "Horde")
	addon:AddTrainer(18751, "Kalaen", Z.HELLFIRE_PENINSULA, 56.8, 37.7, "Horde")
	addon:AddTrainer(18774, "Tatiana", Z.HELLFIRE_PENINSULA, 54.6, 63.6, "Alliance")
	addon:AddTrainer(19063, "Hamanar", Z.SHATTRATH_CITY, 35.7, 20.5, "Neutral")
	addon:AddTrainer(19539, "Jazdalaad", Z.NETHERSTORM, 44.5, 34, "Neutral")
	addon:AddTrainer(19775, "Kalinda", Z.SILVERMOON_CITY, 90.5, 74.1, "Horde")
	addon:AddTrainer(19778, "Farii", Z.THE_EXODAR, 45, 24, "Alliance")
	addon:AddTrainer(26915, "Ounhulo", Z.HOWLING_FJORD, 59.9, 63.8, "Alliance")
	addon:AddTrainer(26960, "Carter Tiffens", Z.HOWLING_FJORD, 79.3, 28.8, "Horde")
	addon:AddTrainer(26982, "Geba'li", Z.BOREAN_TUNDRA, 41.6, 53.4, "Horde")
	addon:AddTrainer(26997, "Alestos", Z.BOREAN_TUNDRA, 57.5, 72.3, "Alliance")
	addon:AddTrainer(28701, "Timothy Jones", Z.DALARAN, 40.5, 35.2, "Neutral")
	addon:AddTrainer(33590, "Oluros", Z.ICECROWN, 71.5, 20.8, "Neutral")
	addon:AddTrainer(33614, 51311, Z.SHATTRATH_CITY, 43.6, 90.8, "Neutral")
	addon:AddTrainer(33637, "Kirembri Silvermane", Z.SHATTRATH_CITY, 58.1, 75, "Neutral")
	addon:AddTrainer(33680, "Nemiha", Z.SHATTRATH_CITY, 36.1, 47.7, "Neutral")
	addon:AddTrainer(44582, "Theresa Denman", Z.STORMWIND_CITY, 63.5, 61.6, "Alliance")
	addon:AddTrainer(46675, "Lugrah", Z.ORGRIMMAR, 72.49, 34.31, "Horde")
	addon:AddTrainer(52586, "Hanner Gembold", Z.IRONFORGE, 51, 25.4, "Alliance")
	addon:AddTrainer(52645, "Aessa Silverdew", Z.DARNASSUS, 54.2, 30.4, "Alliance")
	addon:AddTrainer(52657, "Nahari Cloudchaser", Z.THUNDER_BLUFF, 35.0, 54.0, "Horde")
	addon:AddTrainer(65098, "Mai the Jade Shaper", Z.THE_JADE_FOREST, 48.1, 35.0, "Neutral")
	addon:AddTrainer(85916, "Artificer Nissea", Z.STORMSHIELD, 43.5, 33.9, "Alliance")
	addon:AddTrainer(86010, "Alixander Swiftsteel", Z.WARSPEAR, 60.0, 40.6, "Horde")

	self.InitializeTrainers = nil
end
