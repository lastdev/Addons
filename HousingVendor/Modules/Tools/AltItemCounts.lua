-- AltItemCounts.lua
-- Persisted per-character item counts (bags + bank) to support cross-alt planning displays.

local ADDON_NAME, ns = ...

local AltItemCounts = {}
AltItemCounts.__index = AltItemCounts

local trackedItemIDs = {} -- set[itemID] = true

local function EnsureDB()
    if not _G.HousingDB then
        return nil
    end
    _G.HousingDB.altItemCounts = _G.HousingDB.altItemCounts or {}
    local db = _G.HousingDB.altItemCounts
    db.chars = db.chars or {}
    return db
end

local function GetCurrentCharKey()
    local name, realm = nil, nil
    if _G.UnitFullName then
        name, realm = _G.UnitFullName("player")
    end
    if not realm or realm == "" then
        realm = (_G.GetRealmName and _G.GetRealmName()) or "UnknownRealm"
    end
    name = name or (_G.UnitName and _G.UnitName("player")) or "Unknown"
    return tostring(name) .. "-" .. tostring(realm)
end

local function NormalizeItemIDs(itemIDs)
    local out = {}
    local seen = {}
    if type(itemIDs) ~= "table" then
        local id = tonumber(itemIDs)
        if id then
            out[1] = id
        end
        return out
    end

    for i = 1, #itemIDs do
        local id = tonumber(itemIDs[i])
        if id and not seen[id] then
            seen[id] = true
            out[#out + 1] = id
        end
    end
    return out
end

function AltItemCounts:SetTrackedItemIDs(itemIDs)
    trackedItemIDs = {}
    local ids = NormalizeItemIDs(itemIDs)
    for i = 1, #ids do
        trackedItemIDs[ids[i]] = true
    end
end

function AltItemCounts:GetTrackedItemIDs()
    local out = {}
    for id in pairs(trackedItemIDs) do
        out[#out + 1] = id
    end
    table.sort(out)
    return out
end

function AltItemCounts:UpdateItems(itemIDs)
    local db = EnsureDB()
    if not db then
        return
    end

    local ids = NormalizeItemIDs(itemIDs)
    if #ids == 0 then
        return
    end

    local key = GetCurrentCharKey()
    db.chars[key] = db.chars[key] or { items = {}, updatedAt = 0 }
    local rec = db.chars[key]
    rec.items = rec.items or {}
    rec.updatedAt = _G.time and _G.time() or 0

    local itemCounts = ns.ItemCounts or _G.HousingItemCounts

    for i = 1, #ids do
        local itemID = ids[i]
        local bagCount = 0
        if itemCounts and itemCounts.GetCounts then
            bagCount = select(1, itemCounts:GetCounts(itemID, { includeWarbandBank = false, includeReagentBag = true }))
        end

        local total = bagCount
        if _G.C_Item and _G.C_Item.GetItemCount then
            -- (itemID, includeBank, includeCharges, includeVoidStorage, includeReagentBank, includeAccountBank)
            local ok, v = pcall(_G.C_Item.GetItemCount, itemID, true, false, false, true, false)
            if ok and type(v) == "number" then
                total = v
            end
        end

        local bankCount = total - bagCount
        if bankCount < 0 then
            bankCount = 0
        end

        rec.items[itemID] = {
            bag = bagCount,
            bank = bankCount,
            total = total,
        }
    end
end

function AltItemCounts:RefreshTracked()
    self:UpdateItems(self:GetTrackedItemIDs())
end

-- Returns bag, bank, total for the current character from cache (fallbacks to bagFallback if unknown).
function AltItemCounts:GetCurrentCounts(itemID, bagFallback)
    local id = tonumber(itemID)
    if not id then
        return 0, 0, 0
    end

    local db = EnsureDB()
    if not db then
        local b = tonumber(bagFallback) or 0
        return b, 0, b
    end

    local key = GetCurrentCharKey()
    local rec = db.chars and db.chars[key]
    local info = rec and rec.items and rec.items[id]
    if info then
        local bag = tonumber(info.bag) or 0
        local bank = tonumber(info.bank) or 0
        local total = tonumber(info.total) or (bag + bank)
        return bag, bank, total
    end

    local b = tonumber(bagFallback) or 0
    return b, 0, b
end

-- Returns total count on other characters (bags + bank), based on prior logins.
function AltItemCounts:GetAltTotal(itemID)
    local id = tonumber(itemID)
    if not id then
        return 0
    end
    local db = EnsureDB()
    if not db then
        return 0
    end

    local currentKey = GetCurrentCharKey()
    local total = 0
    for key, rec in pairs(db.chars or {}) do
        if key ~= currentKey and rec and rec.items then
            local info = rec.items[id]
            if info and info.total then
                total = total + (tonumber(info.total) or 0)
            end
        end
    end
    return total
end

-- Returns up to max entries: { {charKey, total, bag, bank}, ... }, sorted by total desc.
function AltItemCounts:GetAltBreakdown(itemID, maxEntries)
    local id = tonumber(itemID)
    if not id then
        return {}
    end
    local db = EnsureDB()
    if not db then
        return {}
    end

    local currentKey = GetCurrentCharKey()
    local out = {}
    for key, rec in pairs(db.chars or {}) do
        if key ~= currentKey and rec and rec.items then
            local info = rec.items[id]
            local total = info and tonumber(info.total) or 0
            if total and total > 0 then
                out[#out + 1] = {
                    charKey = key,
                    total = total,
                    bag = info and tonumber(info.bag) or 0,
                    bank = info and tonumber(info.bank) or 0,
                }
            end
        end
    end

    table.sort(out, function(a, b)
        if (a.total or 0) ~= (b.total or 0) then
            return (a.total or 0) > (b.total or 0)
        end
        return tostring(a.charKey) < tostring(b.charKey)
    end)

    local maxN = tonumber(maxEntries) or 5
    if maxN < 1 then maxN = 1 end
    if #out > maxN then
        for i = #out, maxN + 1, -1 do
            out[i] = nil
        end
    end
    return out
end

ns.AltItemCounts = AltItemCounts
_G.HousingAltItemCounts = AltItemCounts

return AltItemCounts

