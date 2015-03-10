-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
local MODULE_VERSION = 1

-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local MODULE_NAME = "Inscription"
private.module_name = MODULE_NAME

local LibStub = _G.LibStub
local addon = LibStub("AceAddon-3.0"):GetAddon("Ackis Recipe List")

if MODULE_VERSION ~= addon.SUPPORTED_MODULE_VERSION then
	addon:SpawnModuleWrongVersionDialog({
		moduleName = MODULE_NAME,
		moduleVersion = MODULE_VERSION
	})
	return
end

private.addon = addon

local module = addon:NewModule(MODULE_NAME)
module.Version = MODULE_VERSION
module.Name  = FOLDER_NAME

function module:OnInitialize()
	local defaults = {
		profile = {
			filters = {
				item = {} -- Populated below.
			}
		}
	}

	for filter_name in pairs(self.ITEM_FILTER_TYPES) do
		defaults.profile.filters.item[filter_name:lower()] = true
		addon.constants.ITEM_FILTER_TYPES[filter_name] = true
	end

	self.db = addon.db:RegisterNamespace(MODULE_NAME, defaults)
end

function module:OnEnable()
	self:InitializeDiscoveries()
	self:InitializeMobDrops()
	self:InitializeQuests()
	self:InitializeTrainers()
	self:InitializeVendors()
	self:InitializeRecipes()
end
