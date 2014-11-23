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

local BN = constants.BOSS_NAMES
local Z = constants.ZONE_NAMES

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeMobDrops()
	local function AddMob(mob_id, mob_name, zone_name, coord_x, coord_y)
		addon.AcquireTypes.MobDrop:AddEntity(mob_id, mob_name, zone_name, coord_x, coord_y, nil)
	end

	AddMob(1853,	BN.DARKMASTER_GANDLING,			Z.SCHOLOMANCE,			0, 0)
	AddMob(9262,	L["Firebrand Invoker"],			Z.BLACKROCK_SPIRE,		0, 0)
	AddMob(17150,	L["Vir'aani Arcanist"],			Z.NAGRAND_OUTLAND,		40.5, 69.6)
	AddMob(17862,	BN.CAPTAIN_SKARLOC,			Z.OLD_HILLSBRAD_FOOTHILLS,	0, 0)
	AddMob(18344,	BN.NEXUS_PRINCE_SHAFFAR,		Z.MANA_TOMBS,			0, 0)
	AddMob(19221,	BN.NETHERMANCER_SEPETHREA,		Z.THE_MECHANAR,			0, 0)
	AddMob(19740,	L["Wrathwalker"],			Z.SHADOWMOON_VALLEY,		25.5, 33.0)
	AddMob(19754,	L["Deathforge Tinkerer"],		Z.SHADOWMOON_VALLEY,		39.0, 38.7)
	AddMob(19756,	L["Deathforge Smith"],			Z.SHADOWMOON_VALLEY,		37.5, 42.0)
	AddMob(19792,	L["Eclipsion Centurion"],		Z.SHADOWMOON_VALLEY,		48.0, 61.8)
	AddMob(19795,	L["Eclipsion Blood Knight"],		Z.SHADOWMOON_VALLEY,		52.7, 63.2)
	AddMob(19796,	L["Eclipsion Archmage"],		Z.SHADOWMOON_VALLEY,		49.5, 58.5)
	AddMob(19806,	L["Eclipsion Bloodwarder"],		Z.SHADOWMOON_VALLEY,		46.5, 66.0)
	AddMob(19973,	L["Abyssal Flamebringer"],		Z.BLADES_EDGE_MOUNTAINS,	30.0, 81.0)
	AddMob(20887,	L["Deathforge Imp"],			Z.SHADOWMOON_VALLEY,		40.5, 39.1)
	AddMob(21302,	L["Shadow Council Warlock"],		Z.SHADOWMOON_VALLEY,		22.9, 38.2)
	AddMob(21314,	L["Terrormaster"],			Z.SHADOWMOON_VALLEY,		24.0, 45.0)
	AddMob(22016,	L["Eclipsion Soldier"],			Z.SHADOWMOON_VALLEY,		52.8, 66.5)
	AddMob(22017,	L["Eclipsion Spellbinder"],		Z.SHADOWMOON_VALLEY,		52.7, 63.4)
	AddMob(22018,	L["Eclipsion Cavalier"],		Z.SHADOWMOON_VALLEY,		52.7, 61.1)
	AddMob(22076,	L["Torloth the Magnificent"],		Z.SHADOWMOON_VALLEY,		51.2, 72.5)
	AddMob(22093,	L["Illidari Watcher"],			Z.SHADOWMOON_VALLEY,		52.5, 72.0)
	AddMob(30921,	L["Skeletal Runesmith"],		Z.ICECROWN,			60.0, 73.1)
	AddMob(31702,	L["Frostbrood Spawn"],			Z.ICECROWN,			75.3, 43.4)
	AddMob(32289,	L["Damned Apothecary"],			Z.ICECROWN,			49.8, 32.7)
	AddMob(32290,	L["Cult Alchemist"],			Z.ICECROWN,			49.5, 33.1)
	AddMob(32297,	L["Cult Researcher"],			Z.ICECROWN,			50.7, 30.9)
	AddMob(32349,	L["Cultist Shard Watcher"],		Z.ICECROWN,			48.1, 67.9)

	self.InitializeMobDrops = nil
end
