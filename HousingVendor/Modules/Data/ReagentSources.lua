-- ReagentSources.lua
-- Lightweight lookup for reagent categorization (vendor/gather/craft/unknown).

local AddonName, HousingVendor = ...

local ReagentSources = {}
HousingVendor.ReagentSources = ReagentSources

local function NormalizeSource(value)
    value = type(value) == "string" and value:lower() or nil
    if value == "vendor" or value == "gather" or value == "craft" then
        return value
    end
    return "unknown"
end

local function FindInRawMatsSets(itemID)
    local raw = _G.HousingRawMats
    if type(raw) ~= "table" then
        return "unknown"
    end

    -- Explicit per-item mapping (preferred "source of truth").
    local map = raw.REAGENT_SOURCES
    if type(map) == "table" then
        local v = map[itemID]
        if v then
            return NormalizeSource(v)
        end
    end

    -- Fallback heuristics based on raw mats buckets.
    local function InIndexedLists(tbl)
        if type(tbl) ~= "table" then return false end
        for _, list in pairs(tbl) do
            if type(list) == "table" then
                for i = 1, #list do
                    if tonumber(list[i]) == itemID then
                        return true
                    end
                end
            end
        end
        return false
    end

    if InIndexedLists(raw.HERB_ITEMS) or InIndexedLists(raw.ORE_ITEMS) or InIndexedLists(raw.LEATHER_ITEMS) or InIndexedLists(raw.FISH_ITEMS) then
        return "gather"
    end

    -- Lumber is typically processed material; default to craft unless overridden in REAGENT_SOURCES.
    if InIndexedLists(raw.LUMBER_ITEMS) then
        return "craft"
    end

    return "unknown"
end

function ReagentSources:GetSource(itemID)
    local id = tonumber(itemID)
    if not id then
        return "unknown"
    end
    return FindInRawMatsSets(id)
end

function ReagentSources:SetSource(itemID, source)
    local id = tonumber(itemID)
    if not id then
        return
    end
    local raw = _G.HousingRawMats
    if type(raw) ~= "table" then
        return
    end
    raw.REAGENT_SOURCES = raw.REAGENT_SOURCES or {}
    raw.REAGENT_SOURCES[id] = NormalizeSource(source)
end

function ReagentSources:GetAll()
    local raw = _G.HousingRawMats
    if type(raw) ~= "table" then
        return {}
    end
    raw.REAGENT_SOURCES = raw.REAGENT_SOURCES or {}
    return raw.REAGENT_SOURCES
end

return ReagentSources
