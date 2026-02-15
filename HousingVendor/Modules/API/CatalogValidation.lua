-- CatalogValidation.lua
-- Uses C_HousingCatalog to build a set of valid decorIDs from the current game client.
-- Items in HousingAllItems whose decorID isn't in this set are filtered from the UI.
-- Before the scan completes (or if the API is unavailable), all items pass through.

local HousingCatalogValidation = {}
HousingCatalogValidation.__index = HousingCatalogValidation

local validDecorIDs = nil
local scanInProgress = false
local scanComplete = false
local lastScanTime = 0
local SCAN_COOLDOWN = 300
local MIN_VALID_ENTRIES = 100

-- ---------------------------------------------------------------------------
-- Public accessors
-- ---------------------------------------------------------------------------

function HousingCatalogValidation:IsScanComplete()
    return scanComplete
end

function HousingCatalogValidation:IsItemInCatalog(itemID)
    if not scanComplete or not validDecorIDs then
        return true
    end
    if HousingDB and HousingDB.settings and HousingDB.settings.hideCatalogUnknowns == false then
        return true
    end
    local allItems = _G.HousingAllItems
    if not allItems then return true end
    local decorData = allItems[itemID]
    if not decorData then
        return false
    end
    local decorID = decorData[1]
    if not decorID then
        return true
    end
    return validDecorIDs[decorID] == true
end

-- ---------------------------------------------------------------------------
-- Scan logic
-- ---------------------------------------------------------------------------

local function ExtractDecorID(entryID)
    if type(entryID) == "table" then
        if entryID.recordID then
            return entryID.recordID
        end
        return nil
    elseif type(entryID) == "number" then
        return entryID
    end
    return nil
end

local function ProcessSearchResults(searcher, callback)
    local ok, allItems = pcall(searcher.GetAllSearchItems, searcher)
    if not ok or not allItems then
        scanInProgress = false
        if searcher.Release then pcall(searcher.Release, searcher) end
        if callback then callback(false, "GetAllSearchItems failed") end
        return
    end

    local newValidSet = {}
    local count = 0
    for i = 1, #allItems do
        local decorID = ExtractDecorID(allItems[i])
        if decorID then
            newValidSet[decorID] = true
            count = count + 1
        end
    end

    if searcher.Release then pcall(searcher.Release, searcher) end

    if count < MIN_VALID_ENTRIES then
        scanInProgress = false
        if callback then callback(false, "Too few entries: " .. count) end
        return
    end

    validDecorIDs = newValidSet
    scanComplete = true
    scanInProgress = false
    lastScanTime = time()

    local rev = (_G.HousingDataAggregatorRevision or 0) + 1
    _G.HousingDataAggregatorRevision = rev

    if _G.HousingVendorLog and _G.HousingVendorLog.Info then
        _G.HousingVendorLog:Info("CatalogValidation: scan complete, " .. count .. " valid decor entries.")
    end

    if callback then callback(true, count) end
end

function HousingCatalogValidation:RunScan(callback)
    if not _G.HousingCatalogSafeToCall then
        if callback then callback(false, "API not safe") end
        return
    end
    if scanInProgress then
        if callback then callback(false, "Scan in progress") end
        return
    end
    local now = time()
    if scanComplete and (now - lastScanTime) < SCAN_COOLDOWN then
        if callback then callback(true, "Cached") end
        return
    end
    if not C_HousingCatalog or not C_HousingCatalog.CreateCatalogSearcher then
        if callback then callback(false, "API unavailable") end
        return
    end

    scanInProgress = true

    local ok, searcher = pcall(C_HousingCatalog.CreateCatalogSearcher)
    if not ok or not searcher then
        scanInProgress = false
        if callback then callback(false, "Searcher creation failed") end
        return
    end

    pcall(function()
        searcher:SetCollected(true)
        searcher:SetUncollected(true)
        if searcher.SetAllowedIndoors then searcher:SetAllowedIndoors(true) end
        if searcher.SetAllowedOutdoors then searcher:SetAllowedOutdoors(true) end
        if searcher.SetCustomizableOnly then searcher:SetCustomizableOnly(false) end
        if searcher.SetFirstAcquisitionBonusOnly then searcher:SetFirstAcquisitionBonusOnly(false) end
    end)

    if searcher.SetResultsUpdatedCallback and searcher.RunSearch then
        searcher:SetResultsUpdatedCallback(function()
            ProcessSearchResults(searcher, callback)
        end)
        local runOk = pcall(searcher.RunSearch, searcher)
        if not runOk then
            -- Async path failed, try synchronous fallback
            ProcessSearchResults(searcher, callback)
        end
    else
        -- No async API, try synchronous
        ProcessSearchResults(searcher, callback)
    end
end

-- ---------------------------------------------------------------------------
-- Initialization (called from CollectionAPI:TryEnableHousingCatalog)
-- ---------------------------------------------------------------------------

function HousingCatalogValidation:Initialize()
    if HousingDB and HousingDB.settings and HousingDB.settings.hideCatalogUnknowns == false then
        return
    end
    self:RunScan()
end

_G.HousingCatalogValidation = HousingCatalogValidation
