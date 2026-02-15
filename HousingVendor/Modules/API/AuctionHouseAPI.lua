-- Auction House API integration
-- Scans AH prices for decor items and caches results in SavedVariables.

local AuctionHouseAPI = {}
AuctionHouseAPI.__index = AuctionHouseAPI

local _G = _G
local CreateFrame = CreateFrame
local ipairs = ipairs
local pairs = pairs
local tonumber = tonumber
local tostring = tostring
local table_insert = table.insert
local time = time
local C_Timer = _G.C_Timer
local C_Item = _G.C_Item
local C_AuctionHouse = _G.C_AuctionHouse

-- If true, do not run Blizzard C_AuctionHouse search queries/events at all.
-- Only use Auctionator/TSM pricing (recommended and far more reliable).
local ADDON_PRICING_ONLY = true

local DEFAULT_TSM_PRICE_SOURCE = "DBMinBuyout"
local DEBUG_MODE = false  -- Set to true to enable debug logging

local function DebugLog(...)
    if DEBUG_MODE then
        print("|cFF8A7FD4[AH Debug]|r", ...)
    end
end

-- Forward declarations (used by helpers defined earlier in the file).
local EnsureCache

local function EnsureAddOnLoaded(addonName)
    if type(addonName) ~= "string" or addonName == "" then
        return false
    end
    if _G.IsAddOnLoaded and _G.IsAddOnLoaded(addonName) then
        return true
    end
    if _G.LoadAddOn then
        pcall(_G.LoadAddOn, addonName)
    end
    return _G.IsAddOnLoaded and _G.IsAddOnLoaded(addonName) or false
end

function AuctionHouseAPI:HasAddonPriceSource()
    -- Auctionator is often LoadOnDemand; try loading it when we need prices.
    EnsureAddOnLoaded("Auctionator")

    local tsm = _G.TSM_API
    if tsm and tsm.ToItemString and tsm.GetCustomPriceValue then
        return true
    end
    local auctionator = _G.Auctionator
    if auctionator and auctionator.API and auctionator.API.v1 and auctionator.API.v1.GetAuctionPriceByItemLink then
        return true
    end
    return false
end

local function GetPreferredPriceSource()
    local settings = _G.HousingDB and _G.HousingDB.settings
    local source = settings and settings.ahPriceSource
    if source == "tsm" or source == "auctionator" then
        return source
    end
    return nil
end

local function GetTSMPriceSource()
    local settings = _G.HousingDB and _G.HousingDB.settings
    local source = settings and settings.ahTsmPriceSource
    if type(source) == "string" and source ~= "" then
        return source
    end
    return DEFAULT_TSM_PRICE_SOURCE
end

local function GetItemLinkForAddonPricing(itemID, fallbackLink)
    if C_Item and C_Item.GetItemLinkByID then
        local ok, link = pcall(C_Item.GetItemLinkByID, itemID)
        if ok and link then
            return link
        end
    end
    if C_Item and C_Item.GetItemInfo then
        local _, link = C_Item.GetItemInfo(itemID)
        if link then
            return link
        end
    end
    if C_Item and C_Item.RequestLoadItemDataByID then
        pcall(C_Item.RequestLoadItemDataByID, itemID)
    end
    return fallbackLink
end

local function BuildFallbackItemLink(itemID)
    local id = tonumber(itemID) or 0
    local name = nil
    if C_Item and C_Item.GetItemNameByID then
        local ok, n = pcall(C_Item.GetItemNameByID, id)
        if ok and n then
            name = n
        end
    end
    name = name or ("item:" .. tostring(id))
    return string.format("|cffffffff|Hitem:%d:::::::::|h[%s]|h|r", id, name)
end

function AuctionHouseAPI:_TryGetTSMPrice(itemID)
    local tsm = _G.TSM_API
    if not (tsm and tsm.ToItemString and tsm.GetCustomPriceValue) then
        return nil
    end

    local itemLink = GetItemLinkForAddonPricing(itemID, string.format("item:%d", itemID))

    local okStr, itemString = pcall(tsm.ToItemString, itemLink)
    if not okStr or not itemString then
        return nil
    end

    local okPrice, price = pcall(tsm.GetCustomPriceValue, GetTSMPriceSource(), itemString)
    if not okPrice then
        return nil
    end

    price = tonumber(price)
    if price and price > 0 then
        return price
    end
    return nil
end

function AuctionHouseAPI:_TryGetAuctionatorPrice(itemID)
    EnsureAddOnLoaded("Auctionator")

    local auctionator = _G.Auctionator
    if not (auctionator and auctionator.API and auctionator.API.v1 and auctionator.API.v1.GetAuctionPriceByItemLink) then
        return nil
    end

    local itemLink = GetItemLinkForAddonPricing(itemID, BuildFallbackItemLink(itemID))
    local okPrice, price = pcall(auctionator.API.v1.GetAuctionPriceByItemLink, "HousingVendor", itemLink)
    if not okPrice then
        return nil
    end

    price = tonumber(price)
    if price and price > 0 then
        return price
    end
    return nil
end

-- Public helper: try to fetch an addon-provided price (Auctionator/TSM) on-demand, and cache it.
-- Useful when itemLinks weren't loaded yet during a bulk scan.
function AuctionHouseAPI:GetOrFetchAddonPrice(itemID)
    local idNum = tonumber(itemID)
    if not idNum then
        return nil, nil
    end

    self:Initialize()
    if EnsureCache then
        EnsureCache()
    end

    -- Return cached price if present
    local cachedPrice, cachedAt = self:GetCachedPrice(idNum)
    if cachedPrice and cachedPrice > 0 then
        return cachedPrice, cachedAt
    end

    -- Throttle repeated misses per session
    self._addonPriceSession = self._addonPriceSession or {}
    local now = time()
    local st = self._addonPriceSession[idNum]
    if st and st.lastTried and (now - st.lastTried) < 15 then
        return nil, nil
    end
    st = st or {}
    st.lastTried = now
    self._addonPriceSession[idNum] = st

    local price, source, attempted = self:_TryGetAddonPrice(idNum)
    price = tonumber(price)
    if attempted and price and price > 0 then
        self:CachePrice(idNum, price)
        self:NotifyListeners("price_updated", idNum, price, source)
        return price, now
    end

    return nil, nil
end

function AuctionHouseAPI:_TryGetAddonPrice(itemID)
    local preferred = GetPreferredPriceSource()

    if preferred == "auctionator" then
        return self:_TryGetAuctionatorPrice(itemID), "auctionator", true
    end
    if preferred == "tsm" then
        return self:_TryGetTSMPrice(itemID), "tsm", true
    end

    local tsmPrice = self:_TryGetTSMPrice(itemID)
    if tsmPrice then
        return tsmPrice, "tsm", true
    end

    local auctionator = _G.Auctionator
    if auctionator and auctionator.API and auctionator.API.v1 then
        local aucPrice = self:_TryGetAuctionatorPrice(itemID)
        if aucPrice then
            return aucPrice, "auctionator", true
        end
    end

    return nil, nil, false
end

local function FirstPositiveNumber(...)
    for i = 1, select("#", ...) do
        local v = tonumber(select(i, ...))
        if v and v > 0 then
            return v
        end
    end
    return nil
end

local function GetScanTimeoutSeconds()
    local settings = _G.HousingDB and _G.HousingDB.settings
    local seconds = settings and tonumber(settings.ahScanTimeoutSeconds)
    if not seconds then
        seconds = 0.8  -- Reduced from 2.0 to 0.8 for faster scanning
    end
    if seconds < 0.3 then
        seconds = 0.3  -- Minimum reduced to 0.3
    end
    if seconds > 10.0 then
        seconds = 10.0
    end
    return seconds
end

local function GetPriceSortOrder()
    local enum = _G.Enum
    if enum and enum.AuctionHouseSortOrder then
        return enum.AuctionHouseSortOrder.Price
            or enum.AuctionHouseSortOrder.UnitPrice
            or enum.AuctionHouseSortOrder.Buyout
            or 0
    end
    return 0
end

EnsureCache = function()
    if not _G.HousingDB then
        return
    end
    if not _G.HousingDB.auctionCache then
        _G.HousingDB.auctionCache = {
            items = {},
            lastScan = 0,
        }
    elseif not _G.HousingDB.auctionCache.items then
        _G.HousingDB.auctionCache.items = {}
    end
end

function AuctionHouseAPI:Initialize()
    if self._initialized then
        return
    end

    EnsureCache()

    local frame = CreateFrame("Frame")
    frame:RegisterEvent("AUCTION_HOUSE_SHOW")
    frame:RegisterEvent("AUCTION_HOUSE_CLOSED")
    -- Standalone Blizzard scan events (disabled in addon pricing mode)
    if not ADDON_PRICING_ONLY then
        frame:RegisterEvent("ITEM_SEARCH_RESULTS_UPDATED")
        frame:RegisterEvent("ITEM_SEARCH_RESULTS_ADDED")
        frame:RegisterEvent("COMMODITY_SEARCH_RESULTS_UPDATED")
        frame:RegisterEvent("COMMODITY_SEARCH_RESULTS_ADDED")
    end
    frame:SetScript("OnEvent", function(_, event, ...)
        self:OnEvent(event, ...)
    end)

    self._eventFrame = frame
    self._listeners = {}
    self._scanQueue = {}
    self._scanQueueIndex = 0
    self._scanTotal = 0
    self._isScanning = false
    self._scanStartedAt = nil
    self._pendingSearch = false
    self._currentItemID = nil
    self._pendingToken = 0
    self._pendingStartedAt = nil
    self._initialized = true
end

function AuctionHouseAPI:IsScanning()
    return self._isScanning == true
end

function AuctionHouseAPI:GetScanProgress()
    return {
        isScanning = self._isScanning == true,
        index = tonumber(self._scanQueueIndex) or 0,
        total = tonumber(self._scanTotal) or 0,
        currentItemID = tonumber(self._currentItemID),
        pendingSearch = self._pendingSearch == true,
        startedAt = tonumber(self._scanStartedAt),
    }
end

function AuctionHouseAPI:IsAuctionHouseOpen()
    if C_AuctionHouse and C_AuctionHouse.IsAuctionHouseOpen then
        local ok, open = pcall(C_AuctionHouse.IsAuctionHouseOpen)
        if ok then
            if open == true or open == 1 then
                return true
            end
            if open == false or open == 0 then
                return false
            end
        end
    end

    local ahFrame = _G.AuctionHouseFrame
    if ahFrame and ahFrame.IsShown then
        if ahFrame:IsShown() then
            return true
        end
    end
    if ahFrame and ahFrame.IsVisible then
        if ahFrame:IsVisible() then
            return true
        end
    end

    return false
end

function AuctionHouseAPI:RegisterListener(key, callback)
    if type(key) ~= "string" or key == "" then
        return
    end
    if type(callback) ~= "function" then
        return
    end
    self._listeners[key] = callback
end

function AuctionHouseAPI:UnregisterListener(key)
    if type(key) ~= "string" then
        return
    end
    self._listeners[key] = nil
end

function AuctionHouseAPI:NotifyListeners(event, ...)
    for _, callback in pairs(self._listeners or {}) do
        pcall(callback, event, ...)
    end
end

function AuctionHouseAPI:GetCachedPrice(itemID)
    local idNum = tonumber(itemID)
    if not idNum or not _G.HousingDB or not _G.HousingDB.auctionCache then
        return nil, nil
    end
    local entry = _G.HousingDB.auctionCache.items[idNum]
    if not entry then
        return nil, nil
    end
    return entry.price, entry.time
end

function AuctionHouseAPI:IsPriceStale(itemID, maxAgeSeconds)
    local maxAge = tonumber(maxAgeSeconds)
    if not maxAge or maxAge <= 0 then
        return true
    end

    local price, cachedAt = self:GetCachedPrice(itemID)
    if not price or not cachedAt then
        return true
    end

    return (time() - cachedAt) >= maxAge
end

function AuctionHouseAPI:StopScan(reason)
    if not self._isScanning then
        return
    end
    self._isScanning = false
    self._pendingSearch = false
    self._currentItemID = nil
    self._scanStartedAt = nil
    self._pendingToken = 0
    self._pendingStartedAt = nil
    self:NotifyListeners("scan_stopped", reason)
end

function AuctionHouseAPI:QueueScan(itemIDs, force)
    if type(itemIDs) ~= "table" then
        return
    end

    self:Initialize()
    EnsureCache()

    local queue = {}
    local seen = {}
    for _, itemID in ipairs(itemIDs) do
        local idNum = tonumber(itemID)
        if idNum and not seen[idNum] then
            seen[idNum] = true
            table_insert(queue, idNum)
            if force and _G.HousingDB and _G.HousingDB.auctionCache and _G.HousingDB.auctionCache.items then
                _G.HousingDB.auctionCache.items[idNum] = nil
            end
        end
    end

    self._scanQueue = queue
    self._scanQueueIndex = 1
    self._scanTotal = #queue
    self._isScanning = self._scanTotal > 0
    self._scanStartedAt = self._isScanning and time() or nil
    self._pendingSearch = false
    self._currentItemID = nil
    self._pendingToken = 0
    self._pendingStartedAt = nil

    -- Notify user which method will be used
    if self:HasAddonPriceSource() then
        local tsm = _G.TSM_API
        local auctionator = _G.Auctionator and _G.Auctionator.API
        if tsm and tsm.ToItemString and tsm.GetCustomPriceValue then
            print("|cFF8A7FD4[HousingVendor]|r Using TSM for fast price lookups")
        elseif auctionator then
            print("|cFF8A7FD4[HousingVendor]|r Using Auctionator for fast price lookups")
        end
    else
        print("|cFF8A7FD4[HousingVendor]|r Using Blizzard AH API (slower - consider installing TSM or Auctionator)")
    end

    self:NotifyListeners("scan_started", self._scanTotal)
    self:ProcessNext()
end

function AuctionHouseAPI:ImportBrowseResults(opts)
    if ADDON_PRICING_ONLY then
        return false, "addon_pricing_only"
    end
    self:Initialize()
    EnsureCache()

    if not self:IsAuctionHouseOpen() then
        return false, "auction_house_closed"
    end

    if not C_AuctionHouse then
        return false, "auction_api_missing"
    end

    local maxResults = nil
    if type(opts) == "table" then
        maxResults = tonumber(opts.maxResults)
    end

    local imported = 0
    local priced = 0

    self:NotifyListeners("browse_import_started")

    local function ImportInfo(itemKey, info)
        local key = itemKey
        local browseInfo = info

        local itemID = nil
        if type(key) == "table" and key.itemID then
            itemID = tonumber(key.itemID)
        end
        if not itemID and type(browseInfo) == "table" then
            if browseInfo.itemKey and browseInfo.itemKey.itemID then
                itemID = tonumber(browseInfo.itemKey.itemID)
            elseif browseInfo.itemID then
                itemID = tonumber(browseInfo.itemID)
            end
        end

        if not itemID then
            return
        end

        local price = nil
        if type(browseInfo) == "table" then
            price = FirstPositiveNumber(
                browseInfo.minPrice,
                browseInfo.minBuyout,
                browseInfo.buyoutAmount,
                browseInfo.unitPrice
            )
        end

        imported = imported + 1
        if price and price > 0 then
            self:CachePrice(itemID, price)
            priced = priced + 1
            self:NotifyListeners("price_updated", itemID, price)
        else
            self:NotifyListeners("price_updated", itemID, nil)
        end
    end

    local function ImportFromNumResults()
        if not (C_AuctionHouse.GetNumBrowseResults and C_AuctionHouse.GetBrowseResultInfo) then
            return false
        end

        local okNum, num = pcall(C_AuctionHouse.GetNumBrowseResults)
        num = (okNum and tonumber(num)) or 0
        if num <= 0 then
            return true
        end

        if maxResults and maxResults > 0 then
            num = math.min(num, maxResults)
        end

        for i = 1, num do
            local okInfo, info = pcall(C_AuctionHouse.GetBrowseResultInfo, i)
            if okInfo and info then
                ImportInfo(info.itemKey, info)
            end
        end
        return true
    end

    local function ImportFromBrowseResults()
        if not (C_AuctionHouse.GetBrowseResults and C_AuctionHouse.GetBrowseResultInfo) then
            return false
        end

        local okRes, results = pcall(C_AuctionHouse.GetBrowseResults)
        if not okRes or type(results) ~= "table" then
            return false
        end

        local limit = #results
        if maxResults and maxResults > 0 then
            limit = math.min(limit, maxResults)
        end

        for i = 1, limit do
            local key = results[i]
            local okInfo, info = pcall(C_AuctionHouse.GetBrowseResultInfo, key)
            if not okInfo then
                okInfo, info = pcall(C_AuctionHouse.GetBrowseResultInfo, i)
            end
            if okInfo and info then
                ImportInfo(key, info)
            else
                ImportInfo(key, nil)
            end
        end

        return true
    end

    local ok = ImportFromBrowseResults()
    if not ok then
        ok = ImportFromNumResults()
    end

    if _G.HousingDB and _G.HousingDB.auctionCache then
        _G.HousingDB.auctionCache.lastBrowseImport = time()
    end

    self:NotifyListeners("browse_import_complete", imported, priced)
    return true, imported, priced
end

function AuctionHouseAPI:_ScheduleTimeout(itemID, token)
    if not (C_Timer and C_Timer.After) then
        return
    end

    C_Timer.After(GetScanTimeoutSeconds(), function()
        if not self._isScanning then
            return
        end
        if not self._pendingSearch then
            return
        end
        if self._pendingToken ~= token then
            return
        end
        if self._currentItemID ~= itemID then
            return
        end

        self:NotifyListeners("scan_timeout", itemID)

        self._pendingSearch = false
        self._pendingStartedAt = nil
        self._scanQueueIndex = self._scanQueueIndex + 1
        self:ProcessNext()
    end)
end

function AuctionHouseAPI:ProcessNext()
    if not self._isScanning then
        return
    end

    if ADDON_PRICING_ONLY and not self:HasAddonPriceSource() then
        DebugLog("ProcessNext: addon pricing only but no addon source available")
        self:StopScan("addon_pricing_unavailable")
        return
    end

    if not ADDON_PRICING_ONLY then
        local isOpen = self:IsAuctionHouseOpen()
        if not isOpen and not self:HasAddonPriceSource() then
            DebugLog("ProcessNext: AH closed and no addon price source, stopping scan")
            self:StopScan("auction_house_closed")
            return
        end
    end

    local itemID = self._scanQueue[self._scanQueueIndex]
    DebugLog("ProcessNext: Processing item", self._scanQueueIndex, "of", self._scanTotal, "- itemID:", itemID)
    if not itemID then
        self._isScanning = false
        if _G.HousingDB and _G.HousingDB.auctionCache then
            _G.HousingDB.auctionCache.lastScan = time()
        end
        DebugLog("ProcessNext: Scan complete!")
        self:NotifyListeners("scan_complete", self._scanTotal)
        return
    end

    local addonPrice, addonSource, addonAttempted = self:_TryGetAddonPrice(itemID)
    if addonAttempted and addonPrice ~= nil then
        self._currentItemID = itemID
        self._pendingSearch = false
        self._pendingStartedAt = nil
        self:NotifyListeners("scan_progress", self._scanQueueIndex, self._scanTotal, itemID)
        self:CachePrice(itemID, addonPrice)
        self:NotifyListeners("price_updated", itemID, addonPrice, addonSource)

        self._scanQueueIndex = self._scanQueueIndex + 1
        if _G.C_Timer and _G.C_Timer.After then
            _G.C_Timer.After(0, function()
                self:ProcessNext()
            end)
        else
            self:ProcessNext()
        end
        return
    end

    if ADDON_PRICING_ONLY then
        -- Addon pricing was attempted but no price was found; move on (no Blizzard query fallback).
        self._currentItemID = itemID
        self._pendingSearch = false
        self._pendingStartedAt = nil
        self:NotifyListeners("scan_progress", self._scanQueueIndex, self._scanTotal, itemID)
        self:NotifyListeners("price_updated", itemID, nil, addonSource)

        self._scanQueueIndex = self._scanQueueIndex + 1
        if _G.C_Timer and _G.C_Timer.After then
            _G.C_Timer.After(0, function()
                self:ProcessNext()
            end)
        else
            self:ProcessNext()
        end
        return
    end

    self._currentItemID = itemID
    self._pendingSearch = true
    self._pendingStartedAt = time()
    self._pendingToken = (self._pendingToken or 0) + 1
    local pendingToken = self._pendingToken

    if not self:SendSearchQuery(itemID) then
        self._pendingSearch = false
        self._pendingStartedAt = nil
        self._scanQueueIndex = self._scanQueueIndex + 1
        self:ProcessNext()
    else
        self:NotifyListeners("scan_progress", self._scanQueueIndex, self._scanTotal, itemID)
        self:_ScheduleTimeout(itemID, pendingToken)
        -- Start polling for results since events may not fire reliably
        self:_StartResultPolling(itemID, pendingToken)
    end
end

function AuctionHouseAPI:_StartResultPolling(itemID, pendingToken)
    -- Poll for results every 0.2 seconds since events may not fire reliably
    -- This is a fallback mechanism in case ITEM_SEARCH_RESULTS_UPDATED doesn't fire
    local pollCount = 0
    local maxPolls = 15  -- Poll for up to 3 seconds (15 * 0.2s)

    local function PollResults()
        if not self._pendingSearch or self._pendingToken ~= pendingToken then
            DebugLog("  Polling stopped (search no longer pending or token changed)")
            return
        end

        pollCount = pollCount + 1
        DebugLog("  Polling for results (attempt", pollCount, "of", maxPolls, ") for itemID:", itemID)

        local hasResults = self:_HasSearchResults(itemID)
        if hasResults then
            DebugLog("  Polling found results! Processing...")
            -- Process the results
            local price = self:ExtractLowestPrice(itemID)
            if price then
                self:CachePrice(itemID, price)
            end

            self._pendingSearch = false
            self._pendingStartedAt = nil
            self._scanQueueIndex = self._scanQueueIndex + 1
            self:NotifyListeners("price_updated", itemID, price)

            if _G.C_Timer and _G.C_Timer.After then
                _G.C_Timer.After(0.15, function()
                    self:ProcessNext()
                end)
            else
                self:ProcessNext()
            end
        elseif pollCount < maxPolls then
            -- Keep polling
            if _G.C_Timer and _G.C_Timer.After then
                _G.C_Timer.After(0.1, PollResults)
            end
        else
            DebugLog("  Polling exhausted, no results found. Waiting for timeout or event...")
        end
    end

    -- Start first poll after a short delay to let the API process the query
    if _G.C_Timer and _G.C_Timer.After then
        _G.C_Timer.After(0.1, PollResults)
    end
end

function AuctionHouseAPI:SendSearchQuery(itemID)
    DebugLog("SendSearchQuery for itemID:", itemID)
    if not (C_AuctionHouse and C_AuctionHouse.MakeItemKey) then
        DebugLog("  C_AuctionHouse.MakeItemKey not available")
        return false
    end

    local ok, itemKey = pcall(C_AuctionHouse.MakeItemKey, itemID)
    if not ok or not itemKey then
        DebugLog("  Failed to make item key for itemID:", itemID)
        return false
    end

    local sorts = {
        { sortOrder = GetPriceSortOrder(), reverseSort = false },
    }

    if C_AuctionHouse and C_AuctionHouse.SearchForItemKeys then
        DebugLog("  Using SearchForItemKeys")
        local success = pcall(C_AuctionHouse.SearchForItemKeys, { itemKey }, sorts, false)
        DebugLog("  SearchForItemKeys success:", success)
        return success
    end

    if C_AuctionHouse and C_AuctionHouse.SendSearchQuery then
        DebugLog("  Using SendSearchQuery")
        local success = pcall(C_AuctionHouse.SendSearchQuery, itemKey, sorts, false)
        DebugLog("  SendSearchQuery success:", success)
        return success
    end

    DebugLog("  No search API available")
    return false
end

function AuctionHouseAPI:ExtractLowestPrice(itemID)
    local price = nil
    DebugLog("ExtractLowestPrice for itemID:", itemID)

    -- Try commodity search first (for stackable items like materials)
    if C_AuctionHouse and C_AuctionHouse.GetCommoditySearchResults then
        local ok, results = pcall(C_AuctionHouse.GetCommoditySearchResults, itemID)
        DebugLog("  GetCommoditySearchResults: ok=", ok, "results type=", type(results))
        if ok and type(results) == "table" then
            DebugLog("  GetCommoditySearchResults returned", #results, "results")
            if #results > 0 then
                local first = results[1]
                DebugLog("  First result type:", type(first))
                if type(first) == "table" then
                    DebugLog("  First result fields: unitPrice=", first.unitPrice, "minPrice=", first.minPrice, "price=", first.price)
                end
                if first and first.unitPrice and first.unitPrice > 0 then
                    price = first.unitPrice
                    DebugLog("  Found commodity price:", price)
                end
            else
                DebugLog("  GetCommoditySearchResults: empty table")
            end
        elseif ok then
            DebugLog("  GetCommoditySearchResults: returned non-table:", results)
        end
    end

    if not price and C_AuctionHouse and C_AuctionHouse.GetNumCommoditySearchResults and C_AuctionHouse.GetCommoditySearchResultInfo then
        local okNum, num = pcall(C_AuctionHouse.GetNumCommoditySearchResults, itemID)
        num = (okNum and tonumber(num)) or 0
        DebugLog("  GetNumCommoditySearchResults:", num)
        if num > 0 then
            local okInfo, info = pcall(C_AuctionHouse.GetCommoditySearchResultInfo, itemID, 1)
            if okInfo and info then
                price = FirstPositiveNumber(info.unitPrice, info.minPrice, info.price)
                if price then
                    DebugLog("  Found commodity price from info:", price)
                end
            end
        end
    end

    if not price and C_AuctionHouse and C_AuctionHouse.MakeItemKey and C_AuctionHouse.GetItemSearchResultInfo then
        local okKey, itemKey = pcall(C_AuctionHouse.MakeItemKey, itemID)
        if okKey and itemKey then
            local okNum = false
            local num = 0
            if C_AuctionHouse.GetNumItemSearchResults then
                okNum, num = pcall(C_AuctionHouse.GetNumItemSearchResults, itemKey)
                num = (okNum and tonumber(num)) or 0
                DebugLog("  GetNumItemSearchResults:", num)
            end

            -- If we don't have a count, try checking at least a few indices to see if there are results
            if num <= 0 then
                num = 10  -- Check up to 10 results in case GetNumItemSearchResults isn't working
                DebugLog("  No count from GetNumItemSearchResults, will check up to 10 indices")
            end

            local limit = math.min(num, 10)  -- Check up to 10 results instead of just 3
            DebugLog("  Checking", limit, "item search results")
            for i = 1, limit do
                local okInfo, info = pcall(C_AuctionHouse.GetItemSearchResultInfo, itemKey, i)
                DebugLog("  GetItemSearchResultInfo index", i, ": ok=", okInfo, "info type=", type(info))
                if okInfo and info then
                    if type(info) == "table" then
                        DebugLog("    Info fields: buyoutAmount=", info.buyoutAmount, "minBuyout=", info.minBuyout,
                                "minBid=", info.minBid, "unitPrice=", info.unitPrice, "minPrice=", info.minPrice)
                    end
                    price = FirstPositiveNumber(
                        info.buyoutAmount,
                        info.minBuyout,
                        info.minBid,
                        info.unitPrice,
                        info.minPrice
                    )
                    if price then
                        DebugLog("  Found item price at index", i, ":", price)
                        break
                    else
                        DebugLog("  No valid price at index", i)
                    end
                elseif not okInfo and num > 10 then
                    -- If the call failed and we were checking beyond real results, stop
                    DebugLog("  GetItemSearchResultInfo failed at index", i, ", stopping")
                    break
                end
            end
        end
    end

    if not price then
        DebugLog("  No price found for itemID:", itemID)
    end

    return price
end

function AuctionHouseAPI:_HasSearchResults(itemID)
    local id = tonumber(itemID)
    if not id or not C_AuctionHouse then
        DebugLog("  _HasSearchResults: invalid itemID or no C_AuctionHouse")
        return false
    end

    -- Check if commodity search has completed (new method from API docs)
    if C_AuctionHouse.HasFullCommoditySearchResults then
        local ok, hasFull = pcall(C_AuctionHouse.HasFullCommoditySearchResults, id)
        DebugLog("  _HasSearchResults: HasFullCommoditySearchResults ok=", ok, "hasFull=", hasFull)
        if ok and hasFull then
            DebugLog("  HasFullCommoditySearchResults returned true for itemID:", id)
            return true
        end
    end

    -- Check commodity results (stackable items)
    if C_AuctionHouse.GetNumCommoditySearchResults then
        local ok, num = pcall(C_AuctionHouse.GetNumCommoditySearchResults, id)
        num = (ok and tonumber(num)) or 0
        DebugLog("  _HasSearchResults: GetNumCommoditySearchResults ok=", ok, "num=", num)
        if num > 0 then
            return true
        end
    end

    -- Also try GetCommoditySearchResults as an alternative
    if C_AuctionHouse.GetCommoditySearchResults then
        local ok, results = pcall(C_AuctionHouse.GetCommoditySearchResults, id)
        DebugLog("  _HasSearchResults: GetCommoditySearchResults ok=", ok, "type=", type(results), "count=", (type(results) == "table" and #results or "N/A"))
        if ok and type(results) == "table" and #results > 0 then
            return true
        end
    end

    -- Check item results (equipment, unique items, etc.)
    if C_AuctionHouse.MakeItemKey and C_AuctionHouse.GetNumItemSearchResults then
        local okKey, itemKey = pcall(C_AuctionHouse.MakeItemKey, id)
        DebugLog("  _HasSearchResults: MakeItemKey ok=", okKey, "itemKey=", itemKey and "present" or "nil")
        if okKey and itemKey then
            local okNum, num = pcall(C_AuctionHouse.GetNumItemSearchResults, itemKey)
            num = (okNum and tonumber(num)) or 0
            DebugLog("  _HasSearchResults: GetNumItemSearchResults ok=", okNum, "num=", num)
            if num > 0 then
                return true
            end
        end
    end

    -- If GetNumItemSearchResults doesn't work, try to actually get one result
    if C_AuctionHouse.MakeItemKey and C_AuctionHouse.GetItemSearchResultInfo then
        local okKey, itemKey = pcall(C_AuctionHouse.MakeItemKey, id)
        if okKey and itemKey then
            local okInfo, info = pcall(C_AuctionHouse.GetItemSearchResultInfo, itemKey, 1)
            DebugLog("  _HasSearchResults: GetItemSearchResultInfo ok=", okInfo, "info=", info and "present" or "nil")
            if okInfo and info then
                return true
            end
        end
    end

    DebugLog("  _HasSearchResults: No results found via any method")
    return false
end

function AuctionHouseAPI:CachePrice(itemID, price)
    if not price or price <= 0 then
        return
    end
    EnsureCache()
    if not _G.HousingDB or not _G.HousingDB.auctionCache then
        return
    end
    _G.HousingDB.auctionCache.items[itemID] = {
        price = price,
        time = time(),
    }

    -- Prevent unbounded SavedVariables growth.
    do
        local settings = _G.HousingDB and _G.HousingDB.settings
        local maxEntries = settings and tonumber(settings.ahPriceMaxEntries)
        if maxEntries and maxEntries > 0 then
            local items = _G.HousingDB.auctionCache.items
            local count = 0
            for _ in pairs(items) do
                count = count + 1
                if count > maxEntries then
                    break
                end
            end
            if count > maxEntries then
                local entries = {}
                for id, entry in pairs(items) do
                    entries[#entries + 1] = { id = id, t = (type(entry) == "table" and tonumber(entry.time)) or 0 }
                end
                table.sort(entries, function(a, b) return (a.t or 0) < (b.t or 0) end)
                local toRemove = #entries - maxEntries
                for i = 1, toRemove do
                    items[entries[i].id] = nil
                end
            end
        end
    end
end

function AuctionHouseAPI:OnEvent(event, ...)
    -- Log ALL events to diagnose which events are actually firing
    DebugLog("OnEvent received:", event)

    if event == "AUCTION_HOUSE_SHOW" then
        self:NotifyListeners("auction_house_open")
        return
    end

    if event == "AUCTION_HOUSE_CLOSED" then
        self:NotifyListeners("auction_house_closed")
        if self._isScanning then
            self:StopScan("auction_house_closed")
        end
        return
    end

    -- Standalone Blizzard scan path disabled.
    if ADDON_PRICING_ONLY then
        return
    end

    if not self._pendingSearch then
        DebugLog("  No pending search, ignoring event:", event)
        return
    end

    if event == "ITEM_SEARCH_RESULTS_UPDATED" or event == "COMMODITY_SEARCH_RESULTS_UPDATED" or
       event == "ITEM_SEARCH_RESULTS_ADDED" or event == "COMMODITY_SEARCH_RESULTS_ADDED" then
        local arg1 = ...
        local itemID = self._currentItemID
        DebugLog("Search results event received:", event, "for itemID:", itemID, "arg1:", arg1)
        if not itemID then
            DebugLog("  No current itemID, ignoring event")
            return
        end

        -- Some client builds include an itemKey/itemID argument; others fire a generic "results updated"
        -- with unrelated args. Since we run only one query at a time, accept generic updates, but
        -- still ignore explicit updates for a different itemID (when provided).
        if arg1 ~= nil then
            if type(arg1) == "table" and arg1.itemID then
                if tonumber(arg1.itemID) ~= itemID then
                    return
                end
            elseif type(arg1) == "number" then
                -- Some builds pass itemID; others pass a result count. If it's not our itemID,
                -- treat it as generic and continue.
            else
                -- Unknown arg: treat as generic and continue.
            end
        end

        -- Some builds fire results-updated multiple times (often with 0 results first). Only consume
        -- the event when the API reports at least one result, otherwise keep waiting until timeout.
        local hasResults = self:_HasSearchResults(itemID)
        DebugLog("  Has results:", hasResults)

        -- If we've been waiting more than half the timeout and still no results, accept it as "no listings"
        local waitTime = self._pendingStartedAt and (time() - self._pendingStartedAt) or 0
        local shouldAcceptNoResults = waitTime >= (GetScanTimeoutSeconds() * 0.5)  -- Accept faster (50% instead of 60%)
        DebugLog("  Wait time:", waitTime, "Should accept no results:", shouldAcceptNoResults)

        if not hasResults and not shouldAcceptNoResults then
            DebugLog("  Waiting for results...")
            return
        end

        DebugLog("  Processing results for itemID:", itemID)
        local price = self:ExtractLowestPrice(itemID)

        -- Cache the price even if nil - this marks the item as scanned
        if price then
            self:CachePrice(itemID, price)
        end

        self._pendingSearch = false
        self._pendingStartedAt = nil
        self._scanQueueIndex = self._scanQueueIndex + 1
        self:NotifyListeners("price_updated", itemID, price)

        if _G.C_Timer and _G.C_Timer.After then
            _G.C_Timer.After(0.15, function()  -- Increased delay to 0.15 seconds to avoid event throttling
                self:ProcessNext()
            end)
        else
            self:ProcessNext()
        end
    end
end

_G["HousingAuctionHouseAPI"] = AuctionHouseAPI

return AuctionHouseAPI
