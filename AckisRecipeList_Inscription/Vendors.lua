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

local Z = constants.ZONE_NAMES

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeVendors()
	local function AddVendor(id_num, name, zone_name, x, y, faction)
		addon.AcquireTypes.Vendor:AddEntity(id_num, name, zone_name, x, y, faction)
	end

	AddVendor(77372,	L["Eric Broadoak"],			Z.LUNARFALL,			 0.0,	 0.0,	"Alliance") -- Alliance Garrison
	AddVendor(79829,	L["Urgra"],				Z.FROSTWALL,			 0.0,	 0.0,	"Horde") -- Horde Garrison
	AddVendor(87063,	L["Joao Calhandro"],			Z.STORMSHIELD,			63.0,	34.4,	"Alliance") -- Alliance Ashran
	AddVendor(87551,	L["Maru'sa"],				Z.WARSPEAR,			76.0,	48.6,	"Horde") -- Horde Ashran

	self.InitializeVendors = nil
end
