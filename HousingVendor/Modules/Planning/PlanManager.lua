-- PlanManager.lua
-- Session-only batch planning ("shopping list") manager.

local ADDON_NAME, ns = ...

local PlanManager = {}
PlanManager.__index = PlanManager

local planItems = {} -- set[itemID] = true (session only)
local listeners = {} -- key -> fn(event, ...)
local loadedFromSaved = false

local function HasReagentsForItem(itemID)
    local id = tonumber(itemID)
    if not id then return false end
    local pr = ns.ProfessionReagents or (_G.HousingVendor and _G.HousingVendor.ProfessionReagents) or nil
    if not pr then return false end
    if pr.HasReagents then
        return pr:HasReagents(id) == true
    end
    local data = pr.GetReagents and pr:GetReagents(id) or nil
    return data and data.reagents and #data.reagents > 0
end

local function Notify(event, ...)
    for _, fn in pairs(listeners) do
        if type(fn) == "function" then
            pcall(fn, event, ...)
        end
    end
end

local function GetPlanCount()
    local n = 0
    for _ in pairs(planItems) do
        n = n + 1
    end
    return n
end

local function EnsurePlanDB()
    if not _G.HousingDB then
        return nil
    end
    _G.HousingDB.plan = _G.HousingDB.plan or {}
    _G.HousingDB.plan.items = _G.HousingDB.plan.items or {}
    return _G.HousingDB.plan
end

local function LoadFromSaved()
    if loadedFromSaved then
        return
    end
    local planDB = EnsurePlanDB()
    if not planDB then
        return
    end
    loadedFromSaved = true

    local items = planDB.items
    if type(items) ~= "table" then
        return
    end

    for _, rawID in pairs(items) do
        local id = tonumber(rawID)
        if id and HasReagentsForItem(id) then
            planItems[id] = true
        end
    end

    Notify("plan_loaded", nil, nil, GetPlanCount())
end

local function SaveToSaved()
    local planDB = EnsurePlanDB()
    if not planDB then
        return
    end

    local out = {}
    for id in pairs(planItems) do
        out[#out + 1] = id
    end
    table.sort(out)
    planDB.items = out
end

function PlanManager:RegisterListener(key, fn)
    if not key then return end
    if fn == nil then
        listeners[key] = nil
        return
    end
    listeners[key] = fn
end

function PlanManager:GetCount()
    LoadFromSaved()
    return GetPlanCount()
end

function PlanManager:IsInPlan(itemID)
    LoadFromSaved()
    local id = tonumber(itemID)
    if not id then return false end
    return planItems[id] == true
end

function PlanManager:ToggleItem(itemID)
    LoadFromSaved()
    local id = tonumber(itemID)
    if not id then return false end

    -- Batch planning is profession-only (items must have reagents).
    if not HasReagentsForItem(id) then
        return false
    end

    if planItems[id] then
        planItems[id] = nil
        SaveToSaved()
        Notify("plan_changed", id, false, GetPlanCount())
        return false
    end

    planItems[id] = true
    SaveToSaved()
    Notify("plan_changed", id, true, GetPlanCount())
    return true
end

function PlanManager:RemoveItem(itemID)
    LoadFromSaved()
    local id = tonumber(itemID)
    if not id then return end
    if planItems[id] then
        planItems[id] = nil
        SaveToSaved()
        Notify("plan_changed", id, false, GetPlanCount())
    end
end

function PlanManager:Clear()
    LoadFromSaved()
    if next(planItems) == nil then
        return
    end
    for k in pairs(planItems) do
        planItems[k] = nil
    end
    SaveToSaved()
    Notify("plan_cleared", GetPlanCount())
end

function PlanManager:GetItemIDs()
    LoadFromSaved()
    local out = {}
    for id in pairs(planItems) do
        table.insert(out, id)
    end
    table.sort(out)
    return out
end

-- Returns:
--  materials = { {itemID, required, ownedBags, ownedWarband, ownedTotal, missing, blocker, state}, ... }
--  totals = { requiredTotal, missingTotal }
function PlanManager:GetAggregatedMaterials()
    LoadFromSaved()
    local pr = ns.ProfessionReagents or (ns and ns.ProfessionReagents)
    if not pr then
        pr = _G.HousingVendor and _G.HousingVendor.ProfessionReagents or nil
    end
    local counts = ns.ItemCounts or _G.HousingItemCounts
    local altCounts = ns.AltItemCounts or _G.HousingAltItemCounts
    local reagentSources = ns.ReagentSources or (_G.HousingVendor and _G.HousingVendor.ReagentSources) or nil

    local requiredByID = {}
    local usedByReagent = {} -- reagentID -> planItemID -> amount

    for itemID in pairs(planItems) do
        local data = pr and pr.GetReagents and pr:GetReagents(itemID) or nil
        local reagents = data and data.reagents
        if type(reagents) == "table" then
            for i = 1, #reagents do
                local r = reagents[i]
                local rid = r and tonumber(r.id)
                local amt = r and tonumber(r.amount)
                if rid and amt and amt > 0 then
                    requiredByID[rid] = (requiredByID[rid] or 0) + amt
                    usedByReagent[rid] = usedByReagent[rid] or {}
                    usedByReagent[rid][itemID] = (usedByReagent[rid][itemID] or 0) + amt
                end
            end
        end
    end

    local reagentIDs = {}
    for reagentID in pairs(requiredByID) do
        reagentIDs[#reagentIDs + 1] = reagentID
    end
    table.sort(reagentIDs)
    if altCounts and altCounts.SetTrackedItemIDs and altCounts.UpdateItems then
        altCounts:SetTrackedItemIDs(reagentIDs)
        altCounts:UpdateItems(reagentIDs)
    end

    local materials = {}
    local requiredTotal = 0
    local missingTotal = 0 -- missing for current+bank+warband
    local missingWithAltsTotal = 0
    local bagsTotal, bankTotal, warbandTotal, altsTotal = 0, 0, 0, 0

    for reagentID, required in pairs(requiredByID) do
        local bagCount, warbandCount, _ = 0, 0, 0
        if counts and counts.GetCounts then
            bagCount, warbandCount = counts:GetCounts(reagentID, { includeReagentBag = true, includeWarbandBank = true })
        end

        local bankCount, charTotal = 0, bagCount
        if altCounts and altCounts.GetCurrentCounts then
            local b, k, t = altCounts:GetCurrentCounts(reagentID, bagCount)
            bagCount = b or bagCount
            bankCount = k or 0
            charTotal = t or (bagCount + bankCount)
        end

        local altTotal = 0
        if altCounts and altCounts.GetAltTotal then
            altTotal = altCounts:GetAltTotal(reagentID) or 0
        end

        local ownedNow = (bagCount or 0) + (bankCount or 0) + (warbandCount or 0)
        local ownedWithAlts = ownedNow + (altTotal or 0)

        local missing = required - ownedNow
        if missing < 0 then missing = 0 end
        local missingWithAlts = required - ownedWithAlts
        if missingWithAlts < 0 then missingWithAlts = 0 end

        local blocker = missing > 0 and ownedNow == 0
        local state = "ready"
        if missing > 0 and blocker then
            state = "not_ready"
        elseif missing > 0 then
            state = "almost"
        end

        materials[#materials + 1] = {
            itemID = reagentID,
            required = required,
            ownedBags = bagCount,
            ownedBank = bankCount,
            ownedWarband = warbandCount,
            ownedAlts = altTotal,
            ownedChar = charTotal,
            ownedNow = ownedNow,
            ownedWithAlts = ownedWithAlts,
            ownedTotal = ownedNow,
            missing = missing,
            missingWithAlts = missingWithAlts,
            blocker = blocker,
            state = state,
            usedBy = usedByReagent[reagentID],
            source = reagentSources and reagentSources.GetSource and reagentSources:GetSource(reagentID) or "unknown",
        }

        requiredTotal = requiredTotal + required
        missingTotal = missingTotal + missing
        missingWithAltsTotal = missingWithAltsTotal + missingWithAlts
        bagsTotal = bagsTotal + (bagCount or 0)
        bankTotal = bankTotal + (bankCount or 0)
        warbandTotal = warbandTotal + (warbandCount or 0)
        altsTotal = altsTotal + (altTotal or 0)
    end

    table.sort(materials, function(a, b)
        if a.missing ~= b.missing then
            return a.missing > b.missing
        end
        return (a.itemID or 0) < (b.itemID or 0)
    end)

    return materials, {
        requiredTotal = requiredTotal,
        missingTotal = missingTotal,
        missingWithAltsTotal = missingWithAltsTotal,
        bagsTotal = bagsTotal,
        bankTotal = bankTotal,
        warbandTotal = warbandTotal,
        altsTotal = altsTotal,
    }
end

ns.PlanManager = PlanManager
_G.HousingPlanManager = PlanManager

return PlanManager
