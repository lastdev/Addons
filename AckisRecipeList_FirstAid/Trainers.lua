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

	AddTrainer(2326, "Thamner Pol", Z.DUN_MOROGH, 54.3, 50.9, "Alliance")
	AddTrainer(2327, "Shaina Fuller", Z.STORMWIND_CITY, 52.2, 45.4, "Alliance")
	AddTrainer(2329, "Michelle Belle", Z.ELWYNN_FOREST, 43.4, 65.6, "Alliance")
	AddTrainer(2798, "Pand Stonebinder", Z.THUNDER_BLUFF, 29.7, 21.2, "Horde")
	AddTrainer(3181, "Fremal Doohickey", Z.WETLANDS, 10.8, 61.3, "Alliance")
	AddTrainer(4211, "Dannelor", Z.DARNASSUS, 51.7, 30.4, "Alliance")
	AddTrainer(4591, "Mary Edras", Z.UNDERCITY, 73.5, 54.8, "Horde")
	AddTrainer(5150, "Nissa Firestone", Z.IRONFORGE, 54, 57.8, "Alliance")
	AddTrainer(5759, "Nurse Neela", Z.TIRISFAL_GLADES, 61.8, 52.8, "Horde")
	AddTrainer(5939, "Vira Younghoof", Z.MULGORE, 46.8, 60.8, "Horde")
	AddTrainer(5943, "Rawrk", Z.DUROTAR, 54.1, 42, "Horde")
	AddTrainer(6094, "Byancie", Z.TELDRASSIL, 55.3, 56.8, "Alliance")
	AddTrainer(12939, "Doctor Gustaf VanHowzen", Z.DUSTWALLOW_MARSH, 67.8, 49.0, "Alliance")
	AddTrainer(16272, "Kanaria", Z.EVERSONG_WOODS, 48.5, 47.6, "Horde")
	AddTrainer(16662, "Alestus", Z.SILVERMOON_CITY, 77.6, 71.3, "Horde")
	AddTrainer(16731, "Nus", Z.THE_EXODAR, 39, 22.5, "Alliance")
	AddTrainer(17214, "Anchorite Fateema", Z.AZUREMYST_ISLE, 48.5, 51.8, "Alliance")
	AddTrainer(17424, "Anchorite Paetheus", Z.BLOODMYST_ISLE, 54.7, 54, "Alliance")
	AddTrainer(18990, "Burko", Z.HELLFIRE_PENINSULA, 22.4, 39.3, "Alliance")
	AddTrainer(18991, "Aresella", Z.HELLFIRE_PENINSULA, 26.3, 62, "Horde")
	AddTrainer(19184, "Mildred Fletcher", Z.SHATTRATH_CITY, 66.5, 13.5, "Neutral")
	AddTrainer(19478, "Fera Palerunner", Z.BLADES_EDGE_MOUNTAINS, 54, 55.1, "Horde")
	AddTrainer(22477, "Anchorite Ensham", Z.TEROKKAR_FOREST, 30.8, 75.9, "Neutral")
	AddTrainer(23734, "Anchorite Yazmina", Z.HOWLING_FJORD, 59.5, 62.3, "Alliance")
	AddTrainer(26956, "Sally Tompkins", Z.HOWLING_FJORD, 79.4, 29.4, "Horde")
	AddTrainer(26992, "Brynna Wilson", Z.BOREAN_TUNDRA, 57.8, 66.5, "Alliance")
	AddTrainer(28706, "Olisarra the Kind", Z.DALARAN, 37.5, 36.7, "Neutral")
	AddTrainer(29233, "Nurse Applewood", Z.BOREAN_TUNDRA, 41.7, 54.5, "Horde")
	AddTrainer(33589, "Joseph Wilson", Z.ICECROWN, 71.5, 22.5, "Neutral")
	AddTrainer(33621, 45542, Z.SHATTRATH_CITY, 43.6, 90.4, "Neutral")
	AddTrainer(36615, "Doc Zapnozzle", Z.THE_LOST_ISLES, 45.6, 65.6, "Horde")
	AddTrainer(45540, "Krenk Choplimb", Z.ORGRIMMAR, 37.5, 87.3, "Horde")
	AddTrainer(49879, "Doc Zapnozzle", Z.AZSHARA, 57.07, 50.71, "Horde")
	AddTrainer(50574, "Amelia Atherton", Z.GILNEAS, 36.8, 65.7, "Alliance")
	AddTrainer(56796, "Angela Leifeld", Z.STORMWIND_CITY, 52.19, 45.36, "Alliance")
	AddTrainer(59077, "Apothecary Cheng", Z.KUN_LAI_SUMMIT, 71.6, 92.8, "Neutral")
	AddTrainer(59619, "Mishka", Z.THE_JADE_FOREST, 59.91, 86.33, "Alliance")
	AddTrainer(64482, "Healer Nan", Z.SHRINE_OF_SEVEN_STARS, 87.8, 68.6, "Alliance")
	AddTrainer(65983, "Soraka", Z.THE_JADE_FOREST, 45.4, 85.8, "Alliance")
	AddTrainer(66222, "Elder Muur", Z.THE_JADE_FOREST, 28.2, 15.2, "Horde")
	AddTrainer(66357, "Master Bier", Z.KUN_LAI_SUMMIT, 51.1, 40.2, "Neutral")
	AddTrainer(85930, "Telys Vinemender", Z.STORMSHIELD, 47.0, 30.6, "Alliance")
	AddTrainer(86034, "Wei Suremend", Z.WARSPEAR, 65.2, 51.6, "Horde")

	self.InitializeTrainers = nil
end
