-- FilterModel.lua
-- Shared filter defaults + helpers for both Full UI and Compact UI.

local ADDON_NAME, ns = ...

local FilterModel = {}
FilterModel.__index = FilterModel

function FilterModel:GetDefaultFaction()
    local playerFaction = _G.UnitFactionGroup and _G.UnitFactionGroup("player") or nil
    if playerFaction == "Alliance" or playerFaction == "Horde" then
        return playerFaction
    end
    return "All Factions"
end

function FilterModel:GetDefaultShowOnlyAvailable()
    -- Single-client model: default to showing only items considered "available".
    return true
end

function FilterModel:CreateDefaultFilters()
    return {
        searchText = "",
        expansion = "All Expansions",
        vendor = "All Vendors",
        zone = "All Zones",
        type = "All Types",
        category = "All Categories",
        faction = self:GetDefaultFaction(),
        source = "All Sources",
        collection = "All",
        quality = "All Qualities",
        requirement = "All Requirements",
        hideVisited = false,
        hideNotReleased = false,
        showOnlyAvailable = self:GetDefaultShowOnlyAvailable(),
        selectedExpansions = {},
        selectedSources = {},
        selectedFactions = {},
        selectedCategories = {},
        excludeExpansions = false,
        excludeSources = false,
        zoneMapID = nil,
        _userSetZone = false,
    }
end

local function ClearTable(t)
    if type(t) ~= "table" then return end
    for k in pairs(t) do
        t[k] = nil
    end
end

local function DeepCopyTables(dst, src)
    for k, v in pairs(src) do
        if type(v) == "table" then
            local child = {}
            for ck, cv in pairs(v) do
                child[ck] = cv
            end
            dst[k] = child
        else
            dst[k] = v
        end
    end
end

function FilterModel:ResetToDefaults(filters)
    if type(filters) ~= "table" then
        return self:CreateDefaultFilters()
    end
    local defaults = self:CreateDefaultFilters()
    ClearTable(filters)
    DeepCopyTables(filters, defaults)
    return filters
end

ns.FilterModel = setmetatable({}, FilterModel)

return ns.FilterModel
