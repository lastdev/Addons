--[[
************************************************************************
Vendor.lua
************************************************************************
File date: 2014-10-18T06:19:35Z
File hash: beabe36
Project hash: 0b1c7cf
Project version: 3.0.11
************************************************************************
Please see http://www.wowace.com/addons/arl/ for more information.
************************************************************************
This source code is released under All Rights Reserved.
************************************************************************
]]--

-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local FOLDER_NAME, private	= ...

local LibStub = _G.LibStub

local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

-----------------------------------------------------------------------
-- Imports.
-----------------------------------------------------------------------
local BN = private.BOSS_NAMES
local Z = private.ZONE_NAMES

function addon:InitVendor()
	local function AddVendor(id_num, name, zone_name, x, y, faction)
		private.AcquireTypes.Vendor:AddEntity(id_num, name, zone_name, x, y, faction)
	end

	AddVendor(66,		L["Tharynn Bouden"],			Z.ELWYNN_FOREST,		41.9,	67.1,	"Alliance") -- Cooking, Tailoring
	AddVendor(777,		L["Amy Davenport"],			Z.REDRIDGE_MOUNTAINS,		29.1,	47.5,	"Alliance") -- Leatherworking, Tailoring
	AddVendor(843,		L["Gina MacGregor"],			Z.WESTFALL,			57.6,	54.0,	"Alliance") -- Leatherworking, Tailoring
	AddVendor(989,		L["Banalash"],				Z.SWAMP_OF_SORROWS,		46.6,	56.9,	"Horde") -- Cooking, Enchanting, Jewelcrafting
	AddVendor(1148,		L["Nerrist"],				Z.NORTHERN_STRANGLETHORN,	39.2,	51.0,	"Horde") -- Cooking, Jewelcrafting
	AddVendor(1313,		L["Maria Lumere"],			Z.STORMWIND_CITY,		55.7,	85.5,	"Alliance") -- Alchemy, Enchanting, Engineering
	AddVendor(1318,		L["Jessara Cordell"],			Z.STORMWIND_CITY,		53.0,	74.2,	"Alliance") -- Enchanting, Tailoring
	AddVendor(2393,		L["Christoph Jeffcoat"],		Z.HILLSBRAD_FOOTHILLS,		57.5,	47.8,	"Horde") -- Alchemy, Jewelcrafting, Leatherworking, Tailoring
	AddVendor(2679,		L["Wenna Silkbeard"],			Z.WETLANDS,			25.7,	25.8,	"Alliance") -- Leatherworking, Tailoring
	AddVendor(2810,		L["Hammon Karwn"],			Z.ARATHI_HIGHLANDS,		46.5,	47.3,	"Alliance") -- Cooking, Jewelcrafting, Leatherworking
	AddVendor(2821,		L["Keena"],				Z.ARATHI_HIGHLANDS,		69.2,	33.6,	"Horde") -- Cooking, Jewelcrafting, Leatherworking
	AddVendor(3012,		L["Nata Dawnstrider"],			Z.THUNDER_BLUFF,		44.9,	37.7,	"Horde") -- Enchanting, Tailoring
	AddVendor(3134,		L["Kzixx"],				Z.DUSKWOOD,			81.9,	19.9,	"Neutral") -- Alchemy, Engineering
	AddVendor(3346,		L["Kithas"],				Z.ORGRIMMAR,			53.3,	48.9,	"Horde") -- Enchanting, Tailoring
	AddVendor(3499,		L["Ranik"],				Z.NORTHERN_BARRENS,		67.1,	73.5,	"Neutral") -- Alchemy, Jewelcrafting, Tailoring
	AddVendor(3537,		L["Zixil"],				Z.HILLSBRAD_FOOTHILLS,		49.8,	60.8,	"Neutral") -- Enchanting, Engineering, Leatherworking, Tailoring
	AddVendor(3556,		L["Andrew Hilbert"],			Z.SILVERPINE_FOREST,		43.2,	40.7,	"Horde") -- Cooking, Leatherworking, Tailoring
	AddVendor(3954,		L["Dalria"],				Z.ASHENVALE,			35.1,	52.1,	"Alliance") -- Enchanting, Jewelcrafting
	AddVendor(4228,		L["Vaean"],				Z.DARNASSUS,			56.4,	32.2,	"Alliance") -- Enchanting, Tailoring
	AddVendor(4229,		L["Mythrin'dir"],			Z.DARNASSUS,			58.1,	34.2,	"Alliance") -- Enchanting, Jewelcrafting
	AddVendor(4561,		L["Daniel Bartlett"],			Z.UNDERCITY,			64.1,	37.4,	"Horde") -- Enchanting, Jewelcrafting
	AddVendor(4617,		L["Thaddeus Webb"],			Z.UNDERCITY,			62.4,	61.0,	"Horde") -- Enchanting, Tailoring
	AddVendor(4897,		L["Helenia Olden"],			Z.DUSTWALLOW_MARSH,		66.4,	51.5,	"Alliance") -- Cooking, Jewelcrafting, Leatherworking
	AddVendor(5158,		L["Tilli Thistlefuzz"],			Z.IRONFORGE,			61.0,	44.0,	"Alliance") -- Enchanting, Tailoring
	AddVendor(5757,		L["Lilly"],				Z.SILVERPINE_FOREST,		43.1,	50.8,	"Horde") -- Enchanting, Tailoring
	AddVendor(5758,		L["Leo Sarn"],				Z.SILVERPINE_FOREST,		53.9,	82.3,	"Horde") -- Enchanting, Tailoring
	AddVendor(9499,		BN.PLUGGER_SPAZZRING,			Z.BLACKROCK_DEPTHS,		0,	0,	"Neutral") -- Alchemy, Leatherworking
	AddVendor(9636,		L["Kireena"],				Z.DESOLACE,			51.0,	53.5,	"Horde") -- Cooking, Jewelcrafting, Tailoring
	AddVendor(10856,	L["Argent Quartermaster Hasana"],	Z.TIRISFAL_GLADES,		83.2,	68.1,	"Neutral") -- Alchemy, Blacksmithing, Enchanting, FirstAid, Leatherworking, Tailoring
	AddVendor(10857,	L["Argent Quartermaster Lightspark"],	Z.WESTERN_PLAGUELANDS,		42.8,	83.8,	"Neutral") -- Alchemy, Blacksmithing, Enchanting, FirstAid, Leatherworking, Tailoring
	AddVendor(11189,	L["Qia"],				Z.WINTERSPRING,			59.6,	49.2,	"Neutral") -- Enchanting, Jewelcrafting, Leatherworking, Tailoring
	AddVendor(11278,	L["Magnus Frostwake"],			Z.WESTERN_PLAGUELANDS,		68.1,	77.6,	"Neutral") -- Alchemy, Blacksmithing
	AddVendor(11536,	L["Quartermaster Miranda Breechlock"],	Z.EASTERN_PLAGUELANDS,		75.8,	54.1,	"Neutral") -- Alchemy, Blacksmithing, Enchanting, FirstAid, Leatherworking, Tailoring
	AddVendor(11557,	L["Meilosh"],				Z.FELWOOD,			65.7,	2.9, 	"Neutral") -- Alchemy, Blacksmithing, Enchanting, Leatherworking, Tailoring
	AddVendor(12022,	L["Lorelae Wintersong"],		Z.MOONGLADE,			48.3,	40.1,	"Neutral") -- Enchanting, Tailoring
	AddVendor(12944,	L["Lokhtos Darkbargainer"],		Z.BLACKROCK_DEPTHS,		0,	0,	"Neutral") -- Alchemy, Blacksmithing, Enchanting, Leatherworking, Tailoring
	AddVendor(13420,	L["Penney Copperpinch"],		Z.ORGRIMMAR,			53.5,	66.1,	"Neutral") -- Cooking, Leatherworking, Tailoring
	AddVendor(13433,	L["Wulmort Jinglepocket"],		Z.IRONFORGE,			33.0,	67.6,	"Neutral") -- Cooking, Leatherworking, Tailoring
	AddVendor(15179,	L["Mishta"],				Z.SILITHUS,			53.8,	34.4,	"Neutral") -- Jewelcrafting, Tailoring
	AddVendor(15419,	L["Kania"],				Z.SILITHUS,			55.6,	37.2,	"Neutral") -- Enchanting, Tailoring
	AddVendor(15909,	L["Fariel Starsong"],			Z.MOONGLADE,			54.0,	35.4,	"Neutral") -- Engineering, Tailoring
	AddVendor(16635,	L["Lyna"],				Z.SILVERMOON_CITY,		70.3,	24.9,	"Horde") -- Enchanting, Tailoring
	AddVendor(16722,	L["Egomis"],				Z.THE_EXODAR,			39.9,	40.2,	"Alliance") -- Enchanting, Tailoring
	AddVendor(17518,	L["Ythyar"],				Z.KARAZHAN,			0,	0,	"Neutral") -- Enchanting, Jewelcrafting
	AddVendor(17585,	L["Quartermaster Urgronn"],		Z.HELLFIRE_PENINSULA,		54.9,	37.9,	"Horde") -- Alchemy, Blacksmithing, Enchanting, Jewelcrafting, Leatherworking
	AddVendor(17657,	L["Logistics Officer Ulrike"],		Z.HELLFIRE_PENINSULA,		56.7,	62.6,	"Alliance") -- Alchemy, Blacksmithing, Enchanting, Jewelcrafting, Leatherworking
	AddVendor(17904,	L["Fedryen Swiftspear"],		Z.ZANGARMARSH,			79.3,	63.8,	"Neutral") -- Alchemy, Blacksmithing, Enchanting, Engineering, Jewelcrafting, Leatherworking
	AddVendor(18011,	L["Zurai"],				Z.ZANGARMARSH,			85.3,	54.8,	"Horde") -- Cooking, Tailoring
	AddVendor(18255,	L["Apprentice Darius"],			Z.DEADWIND_PASS,		47.0,	75.3,	"Neutral") -- Enchanting, Jewelcrafting, Leatherworking
	AddVendor(18382,	L["Mycah"],				Z.ZANGARMARSH,			17.9,	51.2,	"Neutral") -- Alchemy, Cooking, Tailoring
	AddVendor(18753,	L["Felannia"],				Z.HELLFIRE_PENINSULA,		52.3,	36.1,	"Horde") -- Enchanting, Tailoring
	AddVendor(18773,	L["Johan Barnes"],			Z.HELLFIRE_PENINSULA,		53.7,	66.1,	"Alliance") -- Enchanting, Tailoring
	AddVendor(18821,	L["Quartermaster Jaffrey Noreliqe"],	Z.NAGRAND_OUTLAND,		41.2,	44.3,	"Horde") -- Alchemy, Jewelcrafting
	AddVendor(18822,	L["Quartermaster Davian Vaclav"],	Z.NAGRAND_OUTLAND,		41.2,	44.3,	"Alliance") -- Alchemy, Jewelcrafting
	AddVendor(18951,	L["Erilia"],				Z.EVERSONG_WOODS,		55.5,	54.0,	"Horde") -- Enchanting, Tailoring
	AddVendor(19234,	L["Yurial Soulwater"],			Z.SHATTRATH_CITY,		43.5,	96.9,	"Neutral") -- Enchanting, Tailoring
	AddVendor(19321,	L["Quartermaster Endarin"],		Z.SHATTRATH_CITY,		47.9,	26.1,	"Neutral") -- Blacksmithing, Jewelcrafting, Leatherworking, Tailoring
	AddVendor(19331,	L["Quartermaster Enuril"],		Z.SHATTRATH_CITY,		60.5,	64.2,	"Neutral") -- Alchemy, Blacksmithing, Jewelcrafting, Leatherworking, Tailoring
	AddVendor(19537,	L["Dealer Malij"],			Z.NETHERSTORM,			44.2,	34.0,	"Neutral") -- Enchanting, Tailoring
	AddVendor(19540,	L["Asarnan"],				Z.NETHERSTORM,			44.2,	33.7,	"Neutral") -- Enchanting, Tailoring
	AddVendor(19663,	L["Madame Ruby"],			Z.SHATTRATH_CITY,		63.1,	69.3,	"Neutral") -- Enchanting, Tailoring
	AddVendor(20240,	L["Trader Narasu"],			Z.NAGRAND_OUTLAND,		54.6,	75.2,	"Alliance") -- Alchemy, Leatherworking
	AddVendor(20241,	L["Provisioner Nasela"],		Z.NAGRAND_OUTLAND,		53.5,	36.9,	"Horde") -- Alchemy, Leatherworking
	AddVendor(20242,	L["Karaaz"],				Z.NETHERSTORM,			43.6,	34.3,	"Neutral") -- Enchanting, Engineering, Jewelcrafting, Leatherworking, Tailoring
	AddVendor(21432,	L["Almaador"],				Z.SHATTRATH_CITY,		51.0,	41.9,	"Neutral") -- Alchemy, Enchanting, Jewelcrafting, Leatherworking
	AddVendor(21643,	L["Alurmi"],				Z.TANARIS,			63.0,	57.3,	"Neutral") -- Alchemy, Enchanting, Jewelcrafting, Leatherworking
	AddVendor(21655,	L["Nakodu"],				Z.SHATTRATH_CITY,		62.1,	69.0,	"Neutral") -- Alchemy, Enchanting, Jewelcrafting, Tailoring
	AddVendor(23007,	L["Paulsta'ats"],			Z.NAGRAND_OUTLAND,		30.6,	57.0,	"Neutral") -- Enchanting, Engineering, Jewelcrafting, Leatherworking, Tailoring
	AddVendor(23159,	L["Okuno"],				Z.BLACK_TEMPLE,			0,	0,	"Neutral") -- Blacksmithing, Leatherworking, Tailoring
	AddVendor(25032,	L["Eldara Dawnrunner"],			Z.ISLE_OF_QUELDANAS,		47.1,	30.0,	"Neutral") -- Alchemy, Enchanting, Jewelcrafting
	AddVendor(26569,	L["Alys Vol'tyr"],			Z.DRAGONBLIGHT,			36.3,	46.5,	"Horde") -- Enchanting, Tailoring
	AddVendor(27030,	L["Bradley Towns"],			Z.DRAGONBLIGHT,			76.9,	62.2,	"Horde") -- Enchanting, Tailoring
	AddVendor(27054,	L["Modoru"],				Z.DRAGONBLIGHT,			28.9,	55.9,	"Alliance") -- Enchanting, Tailoring
	AddVendor(27147,	L["Librarian Erickson"],		Z.BOREAN_TUNDRA,		46.7,	32.5,	"Neutral") -- Enchanting, Tailoring
	AddVendor(28714,	L["Ildine Sorrowspear"],		Z.DALARAN,			39.1,	41.5,	"Neutral") -- Enchanting, Tailoring
	AddVendor(30431,	L["Veteran Crusader Aliocha Segard"],	Z.ICECROWN,			87.6,	75.6,	"Neutral") -- Jewelcrafting, Tailoring
	AddVendor(31916,	L["Tanaika"],				Z.HOWLING_FJORD,		25.5,	58.7,	"Neutral") -- Jewelcrafting, Leatherworking, Tailoring
	AddVendor(32287,	L["Archmage Alvareaux"],		Z.DALARAN,			25.5,	47.4,	"Neutral") -- Jewelcrafting, Tailoring
	AddVendor(32533,	L["Cielstrasza"],			Z.DRAGONBLIGHT,			59.9,	53.1,	"Neutral") -- Jewelcrafting, Tailoring
	AddVendor(32538,	L["Duchess Mynx"],			Z.ICECROWN,			43.5,	20.6,	"Neutral") -- Jewelcrafting, Tailoring
	AddVendor(32540,	L["Lillehoff"],				Z.THE_STORM_PEAKS,		66.2,	61.4,	"Neutral") -- Jewelcrafting, Leatherworking, Tailoring
	AddVendor(32564,	L["Logistics Officer Silverstone"],	Z.BOREAN_TUNDRA,		57.7,	66.5,	"Alliance") -- Blacksmithing, Engineering
	AddVendor(32565,	L["Gara Skullcrush"],			Z.BOREAN_TUNDRA,		41.4,	53.6,	"Horde") -- Blacksmithing, Engineering
	AddVendor(32763,	L["Sairuk"],				Z.DRAGONBLIGHT,			48.5,	75.7,	"Neutral") -- Jewelcrafting, Leatherworking, Tailoring
	AddVendor(32773,	L["Logistics Officer Brighton"],	Z.HOWLING_FJORD,		59.7,	63.9,	"Alliance") -- Blacksmithing, Engineering
	AddVendor(32774,	L["Sebastian Crane"],			Z.HOWLING_FJORD,		79.6,	30.7,	"Horde") -- Blacksmithing, Engineering
	AddVendor(37687,	L["Alchemist Finklestein"],		Z.ICECROWN_CITADEL,		0,	0,	"Neutral") -- Blacksmithing, Leatherworking, Tailoring
	AddVendor(46572,	L["Goram"],				Z.ORGRIMMAR,			48.2,	75.6,	"Horde") -- Alchemy, Cooking
	AddVendor(46602,	L["Shay Pressler"],			Z.STORMWIND_CITY,		64.6,	76.8,	"Alliance") -- Alchemy, Cooking
	AddVendor(51495,	L["Steeg Haskell"],			Z.IRONFORGE,			36.3,	85.8,	"Alliance") -- Alchemy, Cooking
	AddVendor(51512,	L["Mirla Silverblaze"],			Z.DALARAN,			52.6,	56.6,	"Neutral") -- Alchemy, Cooking
	AddVendor(53214,	L["Damek Bloombeard"],			Z.MOLTEN_FRONT,			47.0,	90.6,	"Neutral") -- Blacksmithing, Engineering
	AddVendor(53410,	L["Lissah Spellwick"],			Z.DUSTWALLOW_MARSH,		66.0,	49.7,	"Alliance") -- Enchanting, Tailoring
	AddVendor(53881,	L["Ayla Shadowstorm"],			Z.MOLTEN_FRONT,			44.8,	86.6,	"Neutral") -- Leatherworking, Tailoring
	AddVendor(59908,	L["Jaluu the Generous"],		Z.VALE_OF_ETERNAL_BLOSSOMS,	74.2,	42.6,	"Neutral") -- Leatherworking, Tailoring
	AddVendor(64032,	L["Sage Whiteheart"],			Z.SHRINE_OF_SEVEN_STARS,	84.6,	63.6,	"Alliance") -- Enchanting, Tailoring

	self.InitVendor = nil
end
