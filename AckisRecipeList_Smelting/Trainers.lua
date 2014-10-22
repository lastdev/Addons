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
	addon:AddTrainer(1443, "Stonebreaker Ruian", Z.THE_JADE_FOREST, 27.82, 14.85, "Horde")
	addon:AddTrainer(1681, "Brock Stoneseeker", Z.LOCH_MODAN, 37.1, 47.8, "Alliance")
	addon:AddTrainer(1701, "Dank Drizzlecut", Z.DUN_MOROGH, 76.6, 53.8, "Alliance")
	addon:AddTrainer(3001, "Brek Stonehoof", Z.THUNDER_BLUFF, 34.4, 57.9, "Horde")
	addon:AddTrainer(3137, "Matt Johnson", Z.DUSKWOOD, 74, 49.7, "Alliance")
	addon:AddTrainer(3175, "Krunn", Z.DUROTAR, 51.9, 40.9, "Horde")
	addon:AddTrainer(3357, "Makaru", Z.ORGRIMMAR, 72.31, 34.91, "Horde")
	addon:AddTrainer(3555, "Johan Focht", Z.SILVERPINE_FOREST, 43.4, 40.5, "Horde")
	addon:AddTrainer(4254, "Geofram Bouldertoe", Z.IRONFORGE, 50.3, 26, "Alliance")
	addon:AddTrainer(4598, "Brom Killian", Z.UNDERCITY, 55.8, 37, "Horde")
	addon:AddTrainer(5392, "Yarr Hammerstone", Z.DUN_MOROGH, 50, 50.3, "Alliance")
	addon:AddTrainer(5513, "Gelman Stonehand", Z.STORMWIND_CITY, 59.5, 37.8, "Alliance")
	addon:AddTrainer(8128, "Pikkle", Z.TANARIS, 51, 29.1, "Neutral")
	addon:AddTrainer(16663, "Belil", Z.SILVERMOON_CITY, 79.1, 42.9, "Horde")
	addon:AddTrainer(16752, "Muaat", Z.THE_EXODAR, 60, 87.9, "Alliance")
	addon:AddTrainer(17488, "Dulvi", Z.AZUREMYST_ISLE, 48.9, 51.1, "Alliance")
	addon:AddTrainer(18747, "Krugosh", Z.HELLFIRE_PENINSULA, 55.5, 37.6, "Horde")
	addon:AddTrainer(18779, "Hurnak Grimmord", Z.HELLFIRE_PENINSULA, 56.7, 63.8, "Alliance")
	addon:AddTrainer(18804, "Prospector Nachlan", Z.BLOODMYST_ISLE, 56.3, 54.3, "Alliance")
	addon:AddTrainer(26912, "Grumbol Stoutpick", Z.HOWLING_FJORD, 59.9, 63.9, "Alliance")
	addon:AddTrainer(26962, "Jonathan Lewis", Z.HOWLING_FJORD, 79.3, 29, "Horde")
	addon:AddTrainer(26976, "Brunna Ironaxe", Z.BOREAN_TUNDRA, 42.6, 53.2, "Horde")
	addon:AddTrainer(26999, "Fendrig Redbeard", Z.BOREAN_TUNDRA, 57.5, 66.2, "Alliance")
	addon:AddTrainer(28698, "Jedidiah Handers", Z.DALARAN, 41.5, 26, "Neutral")
	addon:AddTrainer(33617, 32606, Z.SHATTRATH_CITY, 43.6, 90.9, "Neutral")
	addon:AddTrainer(33640, "Hanlir", Z.SHATTRATH_CITY, 58, 75, "Neutral")
	addon:AddTrainer(33682, "Fono", Z.SHATTRATH_CITY, 36, 48.5, "Neutral")
	addon:AddTrainer(43431, "Periale", Z.DARKSHORE, 51.3, 19.1, "Alliance")
	addon:AddTrainer(46357, "Gonto", Z.ORGRIMMAR, 44.57, 78.61, "Horde")
	addon:AddTrainer(52170, "Gizzik Oregrab", Z.ORGRIMMAR, 36.05, 82.58, "Horde")
	addon:AddTrainer(52642, "Foreman Pernic", Z.DARNASSUS, 50.6, 33.8, "Alliance")
	addon:AddTrainer(53409, "\"Kobold\" Kerik", Z.DUSTWALLOW_MARSH, 64.6, 49.8, "Alliance")
	addon:AddTrainer(65092, "Smeltmaster Ashpaw", Z.THE_JADE_FOREST, 46.09, 29.44, "Alliance")
	addon:AddTrainer(85919, "Jonath Chainfist", Z.STORMSHIELD, 43.3, 35.0, "Alliance")

	self.InitializeTrainers = nil
end
