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
local L = _G.LibStub("AceLocale-3.0"):GetLocale(addon.constants.addon_name)

local Z = constants.ZONE_NAMES

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeVendors()
	local function AddVendor(vendorID, vendorName, zoneName, coordX, coordY, faction)
		addon.AcquireTypes.Vendor:AddEntity(module, {
			coord_x = coordX,
			coord_y = coordY,
			faction = faction,
			identifier = vendorID,
			item_list = {},
			location = zoneName,
			name = vendorName,
		})
	end

	AddVendor(12043,	L["Kulwia"],				Z.STONETALON_MOUNTAINS,		48.6,	61.6,	"Horde")
	AddVendor(18664,	L["Aged Dalaran Wizard"],		Z.OLD_HILLSBRAD_FOOTHILLS,	0,	0,	"Neutral")
	AddVendor(19536,	L["Dealer Jadyan"],			Z.NETHERSTORM,			44.0,	36.6,	"Neutral")
	AddVendor(32514,	L["Vanessa Sellers"],			Z.DALARAN,			38.7,	40.8,	"Neutral")
	AddVendor(44030,	L["Draelan"],				Z.TELDRASSIL,			39.0,	30.0,	"Alliance")
	AddVendor(50134,	L["Senthii"],				Z.TWILIGHT_HIGHLANDS,		78.7,	77.0,	"Alliance")
	AddVendor(50146,	L["Agatian Fallanos"],			Z.TWILIGHT_HIGHLANDS,		76.7,	49.5,	"Horde")
	AddVendor(64001,	L["Sage Lotusbloom"],			Z.SHRINE_OF_TWO_MOONS,		62.6,	23.2,	"Horde")
	AddVendor(64595,	L["Rushi the Fox"],			Z.TOWNLONG_STEPPES,		48.8,	70.6,	"Neutral")
	AddVendor(77354,	L["Ayada the White"],			Z.LUNARFALL,			 0.0,	 0.0,	"Alliance") -- Alliance Garrison
	AddVendor(79821,	L["Yukla Greenshadow"],			Z.FROSTWALL,			 0.0,	 0.0,	"Horde") -- Horde Garrison
	AddVendor(86045,	L["Ged'kah"],				Z.WARSPEAR,			78.6,	52.6,	"Horde") -- Horde Ashran
	AddVendor(87022,	L["Bob"],				Z.STORMSHIELD,			56.7,	64.6,	"Alliance") -- Alliance Ashran
	AddVendor(91020,	L["Enchantress Ismae"],			Z.LUNARFALL,			 0.0,	 0.0,	"Alliance")
	AddVendor(91029,	L["Rath'thul Moonvale"],		Z.FROSTWALL,			 0.0,	 0.0,	"Horde")

	self.InitializeVendors = nil
end
