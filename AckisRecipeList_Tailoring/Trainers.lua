-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-------------------------------------------------------------------------------
-- Module namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local addon = private.addon
if not addon then
	return
end

local constants = addon.constants
local module = addon:GetModule(private.module_name)

local Z = constants.ZONE_NAMES

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeTrainers()
	local function AddTrainer(trainerID, trainerName, zoneName, coordX, coordY, faction)
		return addon:AddTrainer(module, {
			coord_x = coordX,
			coord_y = coordY,
			faction = faction,
			identifier = trainerID,
			item_list = {},
			location = zoneName,
			name = trainerName,
		})
	end

	AddTrainer(1103, "Eldrin", Z.ELWYNN_FOREST, 79.3, 69, "Alliance")
	AddTrainer(1346, "Georgio Bolero", Z.STORMWIND_CITY, 53.2, 81.5, "Alliance")
	AddTrainer(2399, "Daryl Stack", Z.HILLSBRAD_FOOTHILLS, 58.1, 48, "Horde")
	AddTrainer(2627, "Grarnik Goodstitch", Z.THE_CAPE_OF_STRANGLETHORN, 43.6, 73, "Neutral")
	AddTrainer(3004, "Tepa", Z.THUNDER_BLUFF, 44.5, 45.3, "Horde")
	AddTrainer(3363, "Magar", Z.ORGRIMMAR, 63.5, 50, "Horde")
	AddTrainer(3484, "Kil'hala", Z.NORTHERN_BARRENS, 49.9, 61.2, "Horde")
	AddTrainer(3523, "Bowen Brisboise", Z.TIRISFAL_GLADES, 52.6, 55.6, "Horde")
	AddTrainer(3704, "Mahani", Z.SOUTHERN_BARRENS, 41.5, 46.9, "Horde")
	AddTrainer(4159, "Me'lynn", Z.DARNASSUS, 59.8, 37.4, "Alliance")
	AddTrainer(4576, "Josef Gregorian", Z.UNDERCITY, 70.7, 30.3, "Horde")
	AddTrainer(4578, "Josephine Lister", Z.UNDERCITY, 86.5, 22.3, "Horde")
	AddTrainer(5153, "Jormund Stonebrow", Z.IRONFORGE, 43.2, 29, "Alliance")
	AddTrainer(9584, "Jalane Ayrole", Z.STORMWIND_CITY, 40.4, 84.6, "Alliance")
	AddTrainer(11052, "Timothy Worthington", Z.DUSTWALLOW_MARSH, 66.22, 51.7, "Alliance")
	AddTrainer(11557, "Meilosh", Z.FELWOOD, 65.7, 2.9, "Neutral")
	AddTrainer(16366, "Sempstress Ambershine", Z.EVERSONG_WOODS, 37.4, 71.9, "Horde")
	AddTrainer(16640, "Keelen Sheets", Z.SILVERMOON_CITY, 57, 50.1, "Horde")
	AddTrainer(16729, "Refik", Z.THE_EXODAR, 63, 67.9, "Alliance")
	AddTrainer(17487, "Erin Kelly", Z.AZUREMYST_ISLE, 46.2, 70.5, "Alliance")
	AddTrainer(18749, "Dalinna", Z.HELLFIRE_PENINSULA, 56.6, 37.1, "Horde")
	AddTrainer(18772, "Hama", Z.HELLFIRE_PENINSULA, 54.1, 63.6, "Alliance")
	AddTrainer(26914, "Benjamin Clegg", Z.HOWLING_FJORD, 58.6, 62.8, "Alliance")
	AddTrainer(26964, "Alexandra McQueen", Z.HOWLING_FJORD, 79.4, 30.7, "Horde")
	AddTrainer(26969, "Raenah", Z.BOREAN_TUNDRA, 41.6, 53.5, "Horde")
	AddTrainer(27001, "Darin Goodstitch", Z.BOREAN_TUNDRA, 57.5, 72.3, "Alliance")
	AddTrainer(28699, "Charles Worth", Z.DALARAN, 36.5, 33.5, "Neutral")
	AddTrainer(33580, "Dustin Vail", Z.ICECROWN, 73, 20.8, "Neutral")
	AddTrainer(33613, 51309, Z.SHATTRATH_CITY, 44, 91.1, "Neutral")
	AddTrainer(33636, "Miralisse", Z.SHATTRATH_CITY, 41.6, 63.5, "Neutral")
	AddTrainer(33684, "Weaver Aoa", Z.SHATTRATH_CITY, 37.6, 27.2, "Neutral")
	AddTrainer(43428, "Faeyrin Willowmoon", Z.DARKSHORE, 50.6, 20.8, "Alliance")
	AddTrainer(44783, "Hiwahi Three-Feathers", Z.ORGRIMMAR, 38.8, 50.5, "Horde")
	AddTrainer(45559, "Nivi Weavewell", Z.ORGRIMMAR, 41.1, 79.7, "Horde")
	AddTrainer(57405, "Silkmaster Tsai", Z.VALLEY_OF_THE_FOUR_WINDS, 62.62, 59.81, "Alliance")
	AddTrainer(85910, "Joshua Fuesting", Z.STORMSHIELD, 51.9, 37.4, "Alliance")
	AddTrainer(86004, "Saesha Silverblood", Z.WARSPEAR, 59.2, 41.4, "Horde")

	self.InitializeTrainers = nil
end
