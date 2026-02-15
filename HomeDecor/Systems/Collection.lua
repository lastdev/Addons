local ADDON, NS = ...

local Collection = {}
NS.Systems = NS.Systems or {}
NS.Systems.Collection = Collection

Collection.State = {
    COLLECTED = "COLLECTED",
    NOT_COLLECTED = "NOT_COLLECTED",
}

local decorCache = {}
local listeners = {}

local function NotifyChanged(decorID)
    for i = 1, #listeners do
        local fn = listeners[i]
        if fn then
            pcall(fn, decorID)
        end
    end
end

function Collection:RegisterListener(fn)
    if type(fn) ~= "function" then return end
    listeners[#listeners + 1] = fn
end

function Collection:ClearCache(decorID)
    if decorID then
        decorCache[decorID] = nil
        NotifyChanged(decorID)
    else
        wipe(decorCache)
        NotifyChanged(-1)
    end
end

local _entryType
local _entryTypeTried = {}

local function TryRecord(entryType, decorID)
    if not C_HousingCatalog or not C_HousingCatalog.GetCatalogEntryInfoByRecordID then return nil end
    local ok, info = pcall(C_HousingCatalog.GetCatalogEntryInfoByRecordID, entryType, decorID, true)
    if ok and type(info) == "table" then return info end
    ok, info = pcall(C_HousingCatalog.GetCatalogEntryInfoByRecordID, entryType, decorID, false)
    if ok and type(info) == "table" then return info end
    return nil
end

local function DiscoverEntryType(sampleDecorID)
    if _entryType then return _entryType end
    if not sampleDecorID then return nil end

    if Enum and Enum.HousingCatalogEntryType then
        for _, v in pairs(Enum.HousingCatalogEntryType) do
            if type(v) == "number" and not _entryTypeTried[v] then
                _entryTypeTried[v] = true
                if TryRecord(v, sampleDecorID) then
                    _entryType = v
                    return v
                end
            end
        end
    end

    for v = 0, 30 do
        if not _entryTypeTried[v] then
            _entryTypeTried[v] = true
            if TryRecord(v, sampleDecorID) then
                _entryType = v
                return v
            end
        end
    end

    return nil
end

local function IsOwnedViaCatalog(decorID)
    if not decorID then return nil end
    if not C_HousingCatalog or not C_HousingCatalog.GetCatalogEntryInfoByRecordID then return nil end

    local et = DiscoverEntryType(decorID) or 1
    local info = TryRecord(et, decorID)
    if not info then

        info = TryRecord(1, decorID)
    end
    if not info then return nil end

    if type(info.isOwned) == "boolean" then return info.isOwned end
    if type(info.isCollected) == "boolean" then return info.isCollected end
    if type(info.owned) == "boolean" then return info.owned end

    local ownedInfo = info.ownedInfo or info.ownedData or info.ownedStatus
    if type(ownedInfo) == "table" then
        if type(ownedInfo.isOwned) == "boolean" then return ownedInfo.isOwned end
        if type(ownedInfo.isCollected) == "boolean" then return ownedInfo.isCollected end
        if type(ownedInfo.owned) == "boolean" then return ownedInfo.owned end
        if type(ownedInfo.count) == "number" then return ownedInfo.count > 0 end
        if type(ownedInfo.ownedCount) == "number" then return ownedInfo.ownedCount > 0 end
    end

    if type(info.ownedCount) == "number" then return info.ownedCount > 0 end
    if type(info.countOwned) == "number" then return info.countOwned > 0 end

    local q = tonumber(info.quantity) or 0
    local r = tonumber(info.remainingRedeemable) or 0
    local p = tonumber(info.numPlaced) or 0
    if (q + r + p) > 0 then return true end

    if type(info.firstAcquisitionBonus) == "number" and info.firstAcquisitionBonus >= 0 then

        return info.firstAcquisitionBonus == 0
    end

    return nil
end

function Collection:IsDecorCollected(decorID)
    if not decorID then return false end

    local cached = decorCache[decorID]
    if cached ~= nil then
        return cached
    end

    local owned = IsOwnedViaCatalog(decorID)
    if owned ~= nil then
        decorCache[decorID] = owned and true or false
        return decorCache[decorID]
    end

    decorCache[decorID] = false
    return false
end

function Collection:IsCollected(it)
    if not it then return false end

    local decorID = it.decorID
    if decorID then
        return self:IsDecorCollected(decorID)
    end

    local src = it.source or {}
    local st = src.type

    if st == "achievement" and src.id then

        local ok = select(4, GetAchievementInfo(src.id))
        return ok and true or false
    end

    if st == "quest" and src.id then
        return C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted and C_QuestLog.IsQuestFlaggedCompleted(src.id) or false
    end

    return false
end

function Collection:GetState(it)
    return self:IsCollected(it) and Collection.State.COLLECTED or Collection.State.NOT_COLLECTED
end

local f = CreateFrame("Frame")
f:RegisterEvent("HOUSE_DECOR_ADDED_TO_CHEST")
f:RegisterEvent("PLAYER_ENTERING_WORLD")

f:SetScript("OnEvent", function(_, event, decorID)
    if event == "HOUSE_DECOR_ADDED_TO_CHEST" then
        if decorID then
            decorCache[decorID] = nil
            NotifyChanged(decorID)
        else
            wipe(decorCache)
            NotifyChanged(-1)
        end
        return
    end

    if event == "PLAYER_ENTERING_WORLD" then

        wipe(decorCache)
        NotifyChanged(-1)
        return
    end
end)

return Collection