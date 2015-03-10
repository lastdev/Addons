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

	AddTrainer(1676, "Finbus Geargrind", Z.DUSKWOOD, 77.4, 48.6, "Alliance")
	AddTrainer(1702, "Bronk Guzzlegear", Z.DUN_MOROGH, 50.2, 50.4, "Alliance")
	AddTrainer(3290, "Deek Fizzlebizz", Z.LOCH_MODAN, 45.9, 13.6, "Alliance")
	AddTrainer(3494, "Tinkerwiz", Z.NORTHERN_BARRENS, 68.5, 69.2, "Neutral")
	AddTrainer(4941, "Caz Twosprocket", Z.DUSTWALLOW_MARSH, 64.7, 50.4, "Alliance")
	AddTrainer(5174, "Springspindle Fizzlegear", Z.IRONFORGE, 68.4, 44, "Alliance")
	AddTrainer(5518, "Lilliam Sparkspindle", Z.STORMWIND_CITY, 62.8, 32, "Alliance")
	AddTrainer(7406, "Oglethorpe Obnoticus", Z.THE_CAPE_OF_STRANGLETHORN, 43, 72.1, "Neutral")
	AddTrainer(7944, "Tinkmaster Overspark", Z.IRONFORGE, 69.8, 50, "Alliance")
	AddTrainer(8126, "Nixx Sprocketspring", Z.TANARIS, 52.4, 28.3, "Neutral")
	AddTrainer(8736, "Buzzek Bracketswing", Z.TANARIS, 51.7, 30.4, "Neutral")
	AddTrainer(8738, "Vazario Linkgrease", Z.NORTHERN_BARRENS, 68.5, 69.2, "Neutral")
	AddTrainer(11017, "Roxxik", Z.ORGRIMMAR, 56.85, 56.54, "Horde")
	AddTrainer(11025, "Mukdrak", Z.DUROTAR, 52.2, 40.8, "Horde")
	AddTrainer(11031, "Franklin Lloyd", Z.UNDERCITY, 75.9, 73.7, "Horde")
	AddTrainer(11037, "Jenna Lemkenilli", Z.DARKSHORE, 50.8, 20.7, "Alliance")
	AddTrainer(14742, "Zap Farflinger", Z.WINTERSPRING, 59.7, 49.8, "Neutral")
	AddTrainer(14743, "Jhordy Lapforge", Z.TANARIS, 52.2, 27.9, "Neutral")
	AddTrainer(16667, "Danwe", Z.SILVERMOON_CITY, 76.5, 40.9, "Horde")
	AddTrainer(16726, "Ockil", Z.THE_EXODAR, 54, 92.1, "Alliance")
	AddTrainer(17222, "Artificer Daelo", Z.AZUREMYST_ISLE, 48, 51, "Alliance")
	AddTrainer(17634, "K. Lee Smallfry", Z.ZANGARMARSH, 68.6, 50.2, "Alliance")
	AddTrainer(17637, "Mack Diver", Z.ZANGARMARSH, 34, 50.8, "Horde")
	AddTrainer(18752, "Zebig", Z.HELLFIRE_PENINSULA, 54.8, 38.5, "Horde")
	AddTrainer(18775, "Lebowski", Z.HELLFIRE_PENINSULA, 55.7, 65.5, "Alliance")
	AddTrainer(19576, "Xyrol", Z.NETHERSTORM, 32.5, 66.7, "Neutral")
	AddTrainer(21493, "Kablamm Farflinger", Z.NETHERSTORM, 32.9, 63.7, "Neutral")
	AddTrainer(21494, "Smiles O'Byron", Z.BLADES_EDGE_MOUNTAINS, 60.3, 65.2, "Neutral")
	AddTrainer(24868, "Niobe Whizzlespark", Z.SHADOWMOON_VALLEY, 36.7, 54.8, "Alliance")
	AddTrainer(25099, "Jonathan Garrett", Z.SHADOWMOON_VALLEY, 29.2, 28.5, "Horde")
	AddTrainer(25277, "Chief Engineer Leveny", Z.BOREAN_TUNDRA, 42.6, 53.7, "Horde")
	AddTrainer(26907, "Tisha Longbridge", Z.HOWLING_FJORD, 59.7, 64, "Alliance")
	AddTrainer(26955, "Jamesina Watterly", Z.HOWLING_FJORD, 78.5, 30, "Horde")
	AddTrainer(26991, "Sock Brightbolt", Z.BOREAN_TUNDRA, 57.7, 72.2, "Alliance")
	AddTrainer(28697, "Timofey Oshenko", Z.DALARAN, 39, 27.5, "Neutral")
	AddTrainer(29513, "Didi the Wrench", Z.DALARAN, 39.5, 25.5, "Neutral")
	AddTrainer(29514, "Findle Whistlesteam", Z.DALARAN, 39.5, 25.2, "Neutral")
	AddTrainer(33586, "Binkie Brightgear", Z.ICECROWN, 72.1, 20.9, "Neutral")
	AddTrainer(33611, 51306, Z.SHATTRATH_CITY, 43.7, 90.1, "Neutral")
	AddTrainer(33634, "Engineer Sinbei", Z.SHATTRATH_CITY, 43.1, 64.9, "Neutral")
	AddTrainer(45545, "\"Jack\" Pisarek Slamfix", Z.ORGRIMMAR, 36.34, 86.74, "Horde")
	AddTrainer(52636, "Tana Lentner", Z.DARNASSUS, 49.6, 32.3, "Alliance")
	AddTrainer(52651, "Engineer Palehoof", Z.THUNDER_BLUFF, 36.1, 59.6, "Horde")
	AddTrainer(55143, "Sally Fizzlefury", Z.VALLEY_OF_THE_FOUR_WINDS, 16.1, 83.1, "Neutral")
	AddTrainer(85918, "Hilda Copperfuze", Z.STORMSHIELD, 48.2, 40.5, "Alliance")
	AddTrainer(86012, "Han Leaprocket", Z.WARSPEAR, 71.8, 39.2, "Horde")

	self.InitializeTrainers = nil
end
