-- ItemCounts.lua
-- Lightweight helpers for counting items in bags + warband bank.

local ADDON_NAME, ns = ...

local ItemCounts = {}
ItemCounts.__index = ItemCounts

local BAG_CACHE_MAX_AGE_SECONDS = 0.5
local ACCOUNT_CACHE_MAX_AGE_SECONDS = 2.0

local bagCache = {
  at = 0,
  normal = nil,
  reagent = nil,
}

local accountCache = {
    atByID = {},
    totalByID = {},
}

local function Now()
    if _G.GetTime then
        return _G.GetTime()
    end
    return (_G.time and _G.time()) or 0
end

local function WipeTable(t)
    if not t then return end
    for k in pairs(t) do
        t[k] = nil
    end
end

local function ScanContainerCounts(containerID, outCounts)
    if not (C_Container and C_Container.GetContainerNumSlots and C_Container.GetContainerItemInfo) then
        return
    end

    local numSlots = C_Container.GetContainerNumSlots(containerID) or 0
    for slot = 1, numSlots do
        local info = C_Container.GetContainerItemInfo(containerID, slot)
        local itemID = info and info.itemID or nil
        if itemID then
            outCounts[itemID] = (outCounts[itemID] or 0) + (info.stackCount or 1)
        end
    end
end

function ItemCounts:InvalidateBagCache()
    bagCache.at = 0
    bagCache.normal = nil
    bagCache.reagent = nil
end

function ItemCounts:InvalidateAccountCache()
    accountCache.atByID = {}
    accountCache.totalByID = {}
end

function ItemCounts:GetBagSnapshot()
    local now = Now()
    if bagCache.normal and bagCache.reagent and (now - (bagCache.at or 0)) <= BAG_CACHE_MAX_AGE_SECONDS then
        return bagCache.normal, bagCache.reagent
    end

    local normal = bagCache.normal or {}
    local reagent = bagCache.reagent or {}
    WipeTable(normal)
    WipeTable(reagent)

    if type(NUM_BAG_SLOTS) == "number" then
        for bag = 0, NUM_BAG_SLOTS do
            ScanContainerCounts(bag, normal)
        end
    end

    if type(REAGENTBAG_CONTAINER) == "number" then
        ScanContainerCounts(REAGENTBAG_CONTAINER, reagent)
    end

    bagCache.at = now
    bagCache.normal = normal
    bagCache.reagent = reagent

    return normal, reagent
end

local function GetItemCountInBags(itemID, includeReagentBag)
    local total = 0
    local normal, reagent = ItemCounts:GetBagSnapshot()
    total = (normal and normal[itemID]) or 0
    if includeReagentBag then
        total = total + ((reagent and reagent[itemID]) or 0)
    end
    return total
end

local function GetAccountItemCount(id)
    if not (_G.C_Item and _G.C_Item.GetItemCount) then
        return nil
    end

    local now = Now()
    local lastAt = accountCache.atByID[id]
    local cached = accountCache.totalByID[id]
    if cached ~= nil and lastAt and (now - lastAt) <= ACCOUNT_CACHE_MAX_AGE_SECONDS then
        return cached
    end

    local function Try(...)
        local ok, total = pcall(_G.C_Item.GetItemCount, id, ...)
        if ok and type(total) == "number" then
            return total
        end
        return nil
    end

    -- Retail signatures have changed over time; try newest → oldest.
    local total =
        Try(false, false, false, true) or  -- include account/warband bank (newer)
        Try(false, false, true) or         -- include account/warband bank (older)
        Try(false, true) or                -- include bank (older)
        Try(false) or                      -- base count
        Try()

    if total ~= nil then
        accountCache.atByID[id] = now
        accountCache.totalByID[id] = total
    end
    return total
end

-- Returns bagCount, warbandCount, total
function ItemCounts:GetCounts(itemID, opts)
    local id = tonumber(itemID)
    if not id then
        return 0, 0, 0
    end

    opts = opts or {}
    local includeReagentBag = opts.includeReagentBag ~= false
    local includeWarbandBank = opts.includeWarbandBank ~= false

    local bagCount = GetItemCountInBags(id, includeReagentBag)
    local warbandCount = 0

    if includeWarbandBank then
        -- Compute warband as (account total - bags) to keep breakdowns accurate.
        local totalWithAccount = GetAccountItemCount(id)
        if type(totalWithAccount) == "number" then
            warbandCount = totalWithAccount - bagCount
            if warbandCount < 0 then
                warbandCount = 0
            end
        end
    end

    return bagCount, warbandCount, bagCount + warbandCount
end

-- Returns bagCount, warbandCount, total for a list of IDs.
function ItemCounts:GetCountsForIDs(itemIDs, opts)
    if type(itemIDs) ~= "table" then
        return self:GetCounts(itemIDs, opts)
    end

    local bagTotal, warbandTotal = 0, 0
    for _, id in ipairs(itemIDs) do
        local b, w = self:GetCounts(id, opts)
        bagTotal = bagTotal + (b or 0)
        warbandTotal = warbandTotal + (w or 0)
    end
    return bagTotal, warbandTotal, bagTotal + warbandTotal
end

-- Returns bagCount, warbandCount, total for an itemID, merging variants via a variantsMap[itemID] = {ids...}.
function ItemCounts:GetCountsWithVariants(itemID, variantsMap, opts)
    local id = tonumber(itemID)
    if not id then
        return 0, 0, 0
    end

    local variants = (type(variantsMap) == "table") and variantsMap[id] or nil
    if type(variants) == "table" and #variants > 0 then
        return self:GetCountsForIDs(variants, opts)
    end
    return self:GetCounts(id, opts)
end

ns.ItemCounts = ItemCounts
_G.HousingItemCounts = ItemCounts

return ItemCounts
