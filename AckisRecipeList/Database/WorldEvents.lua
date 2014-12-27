-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local FOLDER_NAME, private = ...

local LibStub = _G.LibStub

local addon = LibStub("AceAddon-3.0"):GetAddon(private.addon_name)
local L = LibStub("AceLocale-3.0"):GetLocale(private.addon_name)

function addon:InitWorldEvents()
	local function AddWorldEvent(identifier, name)
		private.AcquireTypes.WorldEvents:AddEntity(identifier, name, _G.GetCategoryInfo(155))
	end

	AddWorldEvent("WINTER_VEIL", _G.GetCategoryInfo(156))
	AddWorldEvent("LUNAR_FESTIVAL", _G.GetCategoryInfo(160))
	AddWorldEvent("MIDSUMMER", _G.GetCategoryInfo(161))
	AddWorldEvent("PILGRIMS_BOUNTY", _G.GetCategoryInfo(14981))
	AddWorldEvent("DAY_OF_THE_DEAD", L["Day of the Dead"])

	self.InitWorldEvents = nil
end
