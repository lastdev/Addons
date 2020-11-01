-- Item cache used to store results of scans and track item state for efficient retrieval. This is for bags only, not tooltips.
local AddonName, Addon = ...
local L = Addon:GetLocale()

local bagItemCache = {}

-- This is a wrapper for Evaluate Item that takes GetItemProperties parameters as input.
-- This is for use cases where you do not need the item itself and just want to know
-- the result. This is also the public api implementaion.
function Addon:EvaluateSource(arg1, arg2)
    return Addon:EvaluateItem(Addon:GetItemProperties(arg1, arg2))
end

-- Evaluating items.
-- This is only used for the 'real' rules evaluation, not rules evaluation in the rules editor.
-- Rules for determining if an item should be sold.
-- Retval meanings:
-- 0 = No action
-- 1 = Item will be sold
-- 2 = Item will be deleted
-- Both 1 and 2 will evaluate to True, so you can still use this function as a boolean.
-- The itemCount is returned separately since it depends on the source and is not used
-- for rule evaluations.
-- This method always returns a number as the first parameter, but the others may be nil.
function Addon:EvaluateItem(item)

    -- Check some cases where we know we should never ever sell the item
    if not item then
        return 0, nil, nil
    end

    -- See if this item is already in the cache.
    local retval, ruleid, rule = Addon:GetCachedResult(item.GUID)
    if retval and type(retval) == "number" then
        return retval, ruleid, rule
    end

    if (not self.ruleManager) then
        self.ruleManager = Addon.RuleManager:Create();
    end
    local result = nil
    result, ruleid, rule = self.ruleManager:Run(item)
    retval = 0
    if result then
        -- Only items explicitly in the always sell list are considered for deletion.
        if item.IsUnsellable then
            if Addon:GetList(Addon.c_AlwaysSellList):Contains(item.Id) then
                retval = 2
            end
            -- What to do about items that are to be sold, but are unsellable and not in the list?
            -- We can't sell them, but the user wants them sold. There's nothing Vendor
            -- can do here, but we should potentially catch this and inform the user and update
            -- the tooltip (as in, add this to the always-sell list to delete it).
            -- For now, we will let this fall through and take no action to fix immediate bug.
            -- TODO: Consider Possible new state of -1 to indicate error state/conflict.
        else
            retval = 1
        end
    end

    -- Add item to cache
    Addon:AddResultToCache(item.Link, retval, ruleid, rule)
    
    return retval, ruleid, rule
end

-- Results are cached by guid.
local resultCache = {}
function Addon:GetCachedResult(guid)
    assert(guid)
    result = resultCache[guid]
    if result then
        return result.Result, result.RuleId, result.Rule
    else
        return nil, nil, nil
    end
end

function Addon:ClearResultCache()
    resultCache = {}
    self:Debug("Result Cache cleared.")
    self:ClearTooltipResultCache()
end

-- Clear the cache on addon changes
Addon:GetConfig():AddOnChanged(function() Addon:ClearResultCache() end)

function Addon:AddResultToCache(guid, result, ruleid, rule)
    assert(type(guid) == "string" and type(result) == "number")

    local cacheEntry = {}
    cacheEntry.Result = result
    cacheEntry.RuleId = ruleid
    cacheEntry.Rule = rule

    assert(guid ~= "")
    --self:Debug("Cached result: %s = %s", guid, tostring(result))
    resultCache[guid] = cacheEntry
end

function Addon:GetEvaluationStatus()
    local count = 0
    local value = 0
    local tosell = 0
    local todelete = 0
    for bag=0, NUM_BAG_SLOTS do
        for slot=1, GetContainerNumSlots(bag) do
            local item, itemCount = Addon:GetItemPropertiesFromBag(bag, slot)
            result = Addon:EvaluateItem(item)
            
            if result > 0 then
                count = count + 1
            end

            if result == 1 then
                value = value + item.UnitValue * itemCount
                tosell = tosell + 1
            elseif result == 2 then
                todelete = todelete + 1
            end
        end
    end
    return count, value, tosell, todelete
end

-- This is a bit of a hack to do a call for blizzard to fetch all the item links in our bags to populate the item links.
function Addon:LoadAllBagItemLinks()
    for bag=0, NUM_BAG_SLOTS do
        for slot=1, GetContainerNumSlots(bag) do
            GetContainerItemInfo(bag, slot)
        end
    end
end

-- Placeholder for now
function Addon:OnBagUpdate(event, bag)
end


