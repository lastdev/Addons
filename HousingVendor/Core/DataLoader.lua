-- DataLoader.lua
-- Data is loaded directly via TOC (single addon mode)

local _G = _G

_G.HousingDataLoader = _G.HousingDataLoader or {}
local DataLoader = _G.HousingDataLoader

function DataLoader:IsDataLoaded()
    return type(_G.HousingAllItems) == "table" and next(_G.HousingAllItems) ~= nil
end

function DataLoader:LoadData(callback)
    -- Data is always loaded (single-TOC mode)
    local loaded = self:IsDataLoaded()

    -- Rebuild any derived lookup tables which were previously built at login.
    if loaded and _G.HousingReputationLoader and _G.HousingReputationLoader.Rebuild then
        pcall(_G.HousingReputationLoader.Rebuild, _G.HousingReputationLoader)
    end

    if type(callback) == "function" then
        pcall(callback, loaded)
    end

    return loaded
end

-- Ensure data is loaded before executing a function.
-- Data should always be loaded at startup in single-TOC mode.
function DataLoader:EnsureDataLoaded(func)
    if type(func) ~= "function" then
        return nil
    end

    if not self:IsDataLoaded() then
        print("|cFFFF0000HousingVendor:|r Data is not loaded - addon files may be missing or failed to load")
        return nil
    end

    return func()
end

-- Optional stubs (some modules assume these globals exist even before real data is present)
_G.HousingAllItems = _G.HousingAllItems or {}
_G.HousingExpansionData = _G.HousingExpansionData or {}
_G.HousingVendorLocations = _G.HousingVendorLocations or {}
_G.HousingModelPositions = _G.HousingModelPositions or {}
_G.HousingProfessionData = _G.HousingProfessionData or {}
_G.HousingReputationData = _G.HousingReputationData or {}
-- Legacy alias used across UI/modules: ensure it always references the same table as HousingReputationData.
_G.HousingReputations = _G.HousingReputationData
_G.HousingVendorPool = _G.HousingVendorPool or {}
_G.HousingVendorPoolIndex = _G.HousingVendorPoolIndex or {}
_G.HousingItemVendorIndex = _G.HousingItemVendorIndex or {}
_G.HousingVendorFilterIndex = _G.HousingVendorFilterIndex or { vendorsByExpansion = {}, zonesByExpansion = {} }
