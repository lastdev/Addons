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

local module = addon:GetModule(private.module_name)
local L = _G.LibStub("AceLocale-3.0"):GetLocale(addon.constants.addon_name)

-----------------------------------------------------------------------
-- What we _really_ came here to see...
-----------------------------------------------------------------------
function module:InitializeDiscoveries()
	local function AddDiscovery(identifier, location, coordX, coordY, faction)
		addon.AcquireTypes.Discovery:AddEntity(module, {
			coord_x = coordX,
			coord_y = coordY,
			faction = faction,
			identifier = identifier,
			item_list = {},
			location = location,
			name = L[identifier],
		})
	end

	AddDiscovery("DISCOVERY_INSC_AUTOLEARN")
	AddDiscovery("DISCOVERY_INSC_BLACKFALLOW")
	AddDiscovery("DISCOVERY_INSC_CELESTIAL")
	AddDiscovery("DISCOVERY_INSC_DREAMS")
	AddDiscovery("DISCOVERY_INSC_ETHEREAL")
	AddDiscovery("DISCOVERY_INSC_JADEFIRE")
	AddDiscovery("DISCOVERY_INSC_LIONS")
	AddDiscovery("DISCOVERY_INSC_MIDNIGHT")
	AddDiscovery("DISCOVERY_INSC_MOONGLOW")
	AddDiscovery("DISCOVERY_INSC_SEA")
	AddDiscovery("DISCOVERY_INSC_SHIMMERING")
	AddDiscovery("DISCOVERY_INSC_WARBINDER")

	self.InitializeDiscoveries = nil
end
