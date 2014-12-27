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
local L = _G.LibStub("AceLocale-3.0"):GetLocale(addon.constants.addon_name)
local BB = _G.LibStub("LibBabble-Boss-3.0"):GetLookupTable()

local BN = constants.BOSS_NAMES
local Z = constants.ZONE_NAMES

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeMobDrops()
	local function AddMob(mob_id, mob_name, zone_name, coord_x, coord_y)
		addon.AcquireTypes.MobDrop:AddEntity(mob_id, mob_name, zone_name, coord_x, coord_y, nil)
	end

	AddMob(590,	L["Defias Looter"],			Z.WESTFALL,			37.5, 58.4)
	AddMob(2242,	L["Syndicate Spy"],			Z.HILLSBRAD_FOOTHILLS,		56.0, 24.2)
	AddMob(3530,	L["Pyrewood Tailor"],			Z.SILVERPINE_FOREST,		45.7, 71.0)
	AddMob(3531,	L["Moonrage Tailor"],			Z.SILVERPINE_FOREST,		45.5, 73.3)
	AddMob(4834,	L["Theramore Infiltrator"],		Z.DUSTWALLOW_MARSH,		44.0, 27.3)
	AddMob(5861,	L["Twilight Fire Guard"],		Z.SEARING_GORGE,		25.5, 33.8)
	AddMob(7037,	L["Thaurissan Firewalker"],		Z.BURNING_STEPPES,		61.1, 42.0)
	AddMob(9026,	BB["Overmaster Pyron"],			Z.SEARING_GORGE,		26.2, 74.9)
	AddMob(11487,	BN.MAGISTER_KALENDRIS,			Z.DIRE_MAUL,			59.04, 48.82)
	AddMob(16406,	L["Phantom Attendant"],			Z.KARAZHAN,			0, 0)
	AddMob(16408,	L["Phantom Valet"],			Z.KARAZHAN,			0, 0)
	AddMob(16807,	BN.GRAND_WARLOCK_NETHEKURSE,		Z.THE_SHATTERED_HALLS,		0, 0)
	AddMob(17798,	BN.WARLORD_KALITHRESH,			Z.THE_STEAMVAULT,		0, 0)
	AddMob(17977,	BN.WARP_SPLINTER,			Z.THE_BOTANICA,			0, 0)
	AddMob(17978,	BN.THORNGRIN_THE_TENDER,		Z.THE_BOTANICA,			0, 0)
	AddMob(18708,	BN.MURMUR,				Z.SHADOW_LABYRINTH,		0, 0)
	AddMob(18872,	L["Disembodied Vindicator"],		Z.NETHERSTORM,			36.0, 55.5)
	AddMob(19220,	BN.PATHALEON_THE_CALCULATOR,		Z.THE_MECHANAR,			0, 0)
	AddMob(20134,	L["Sunfury Arcanist"],			Z.NETHERSTORM,			51.0, 82.5)
	AddMob(20135,	L["Sunfury Arch Mage"],			Z.NETHERSTORM,			46.5, 81.0)
	AddMob(20869,	L["Arcatraz Sentinel"],			Z.THE_ARCATRAZ,			0, 0)
	AddMob(20885,	BN.DALLIAH_THE_DOOMSAYER,		Z.THE_ARCATRAZ,			0, 0)

	self.InitializeMobDrops = nil
end
