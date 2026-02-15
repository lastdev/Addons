-- Auction House UI Module
-- Shows cached AH prices and allows scanning while UI is open.

local ADDON_NAME, ns = ...
local AuctionHouseUI = {}
AuctionHouseUI.__index = AuctionHouseUI

local L = (ns and ns.L) or _G["HousingVendorL"] or {}

local C_Item = _G.C_Item
local HousingFilters = _G.HousingFilters
local HousingItemList = _G.HousingItemList
local HousingDataManager = _G.HousingDataManager
local HousingTheme = _G.HousingTheme
local PreviewPanelData = _G.PreviewPanelData
local date = _G.date
local math_min = math.min
local tonumber = tonumber

-- NOTE: `HousingAuctionHouseAPI` is loaded later in `HousingVendor.toc` than this UI file,
-- so we must not cache it at load time. Always fetch from `_G` when needed.
local function GetAuctionHouseAPI()
    return _G.HousingAuctionHouseAPI
end

local DEFAULT_MAX_PRICE_AGE_SECONDS = 6 * 60 * 60 -- 6 hours

local FormatMoney
if PreviewPanelData and PreviewPanelData.Util and PreviewPanelData.Util.FormatMoneyFromCopper then
    FormatMoney = PreviewPanelData.Util.FormatMoneyFromCopper
else
    FormatMoney = function(copper)
        if not copper or copper <= 0 then
            return "N/A"
        end
        local gold = math.floor(copper / 10000)
        local silver = math.floor((copper % 10000) / 100)
        local copperRem = copper % 100
        return string.format("%dg %02ds %02dc", gold, silver, copperRem)
    end
end

local ROW_HEIGHT = 24
local ROW_SPACING = 2
local MAX_ROWS = 200

local modelViewerWasVisible = false

local function Clamp(v, lo, hi)
    v = tonumber(v)
    lo = tonumber(lo)
    hi = tonumber(hi)
    if not v then
        return lo
    end
    if lo and v < lo then
        return lo
    end
    if hi and v > hi then
        return hi
    end
    return v
end

local function GetPriceProviderDesc()
    local api = GetAuctionHouseAPI()
    if api and api.HasAddonPriceSource and api:HasAddonPriceSource() then
        local tsm = _G.TSM_API
        local auctionator = _G.Auctionator
        if tsm and tsm.ToItemString and tsm.GetCustomPriceValue and auctionator and auctionator.API and auctionator.API.v1 then
            return "Auctionator/TSM detected (fast)"
        end
        if auctionator and auctionator.API and auctionator.API.v1 then
            return "Auctionator detected (fast)"
        end
        if tsm and tsm.ToItemString and tsm.GetCustomPriceValue then
            return "TSM detected (fast)"
        end
        return "Addon pricing detected"
    end
    return "Requires Auctionator or TSM"
end

local function EnsureProfessionDataReady()
    if _G.HousingDataAggregator and _G.HousingDataAggregator.ProcessPendingData then
        pcall(_G.HousingDataAggregator.ProcessPendingData, _G.HousingDataAggregator)
    end
end

local function GetProfessionItemIDs()
    EnsureProfessionDataReady()

    local prof = _G.HousingProfessionData
    if type(prof) ~= "table" then
        return {}
    end

    local ids = {}
    for itemID in pairs(prof) do
        local idNum = tonumber(itemID)
        if idNum then
            ids[#ids + 1] = idNum
        end
    end

    table.sort(ids)
    return ids
end

local function IntersectWithProfessionItemIDs(itemIDs)
    if type(itemIDs) ~= "table" then
        return {}
    end

    EnsureProfessionDataReady()
    local prof = _G.HousingProfessionData
    if type(prof) ~= "table" then
        return {}
    end

    local ids = {}
    for _, itemID in ipairs(itemIDs) do
        local idNum = tonumber(itemID)
        if idNum and prof[idNum] then
            ids[#ids + 1] = idNum
        end
    end
    return ids
end

local function SetNavButtonsVisible(visible)
    local buttons = _G["HousingNavButtons"]
    if type(buttons) ~= "table" then
        return
    end
    for _, btn in ipairs(buttons) do
        if btn and btn.SetShown then
            btn:SetShown(visible)
        end
    end
end

local function SetMainUIVisible(visible)
    if _G["HousingFilterFrame"] then
        _G["HousingFilterFrame"]:SetShown(visible)
    end
    if _G["HousingItemListScrollFrame"] then
        _G["HousingItemListScrollFrame"]:SetShown(visible)
    end
    if _G["HousingItemListContainer"] then
        _G["HousingItemListContainer"]:SetShown(visible)
    end
    if _G["HousingItemListHeader"] then
        _G["HousingItemListHeader"]:SetShown(visible)
    end
    if _G["HousingPreviewFrame"] then
        _G["HousingPreviewFrame"]:SetShown(visible)
    end
    local modelFrame = _G["HousingModelViewerFrame"]
    if not visible then
        modelViewerWasVisible = modelFrame and modelFrame:IsShown() or false
        if modelFrame then
            modelFrame:Hide()
        elseif _G["HousingModelViewer"] and _G["HousingModelViewer"].Hide then
            _G["HousingModelViewer"]:Hide()
        end
    elseif modelViewerWasVisible and modelFrame then
        modelFrame:Show()
    elseif modelViewerWasVisible and _G["HousingModelViewer"] and _G["HousingModelViewer"].Show then
        _G["HousingModelViewer"]:Show()
    end
    SetNavButtonsVisible(visible)
end

local function FormatItemName(itemID)
    if C_Item and C_Item.GetItemNameByID then
        local name = C_Item.GetItemNameByID(itemID)
        if name then
            return name
        end
    end
    return tostring(itemID)
end

function AuctionHouseUI:Initialize(parentFrame)
    if self._initialized then
        return
    end

    self._parentFrame = parentFrame
    self:_CreateContainer()
    self:_RegisterAuctionListeners()
    self:_RegisterFilterHook()
    self._initialized = true
end

function AuctionHouseUI:_CreateContainer()
    if self._container or not self._parentFrame then
        return
    end

    local container = CreateFrame("Frame", "HousingVendorAuctionContainer", self._parentFrame)
    container:SetFrameStrata("DIALOG")
    container:SetPoint("TOPLEFT", self._parentFrame, "TOPLEFT", 20, -70)
    container:SetPoint("BOTTOMRIGHT", self._parentFrame, "BOTTOMRIGHT", -20, 52)
    container:Hide()

    local theme = HousingTheme or {}
    local colors = theme.Colors or {}
    local textPrimary = colors.textPrimary or {1, 1, 1, 1}
    local textMuted = colors.textMuted or {0.6, 0.6, 0.6, 1}
    local bgTertiary = colors.bgTertiary or {0.1, 0.1, 0.1, 1}
    local borderPrimary = colors.borderPrimary or {0.3, 0.3, 0.3, 1}
    local accentPrimary = colors.accentPrimary or {0.8, 0.6, 0.2, 1}

    local title = container:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    title:SetPoint("TOP", 0, -10)
    title:SetText("|cFFFFD700" .. (L["AUCTION_HOUSE_TITLE"] or "Auction House") .. "|r")
    title:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)

    local backBtn = CreateFrame("Button", nil, container, "BackdropTemplate")
    backBtn:SetSize(90, 26)
    backBtn:SetPoint("TOPLEFT", 10, -10)
    backBtn:EnableMouse(true)
    backBtn:RegisterForClicks("LeftButtonUp")
    backBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    backBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    backBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])

    local backText = backBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    backText:SetPoint("CENTER")
    backText:SetText(L["BUTTON_BACK"] or "Back")
    backText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    backBtn.label = backText
    backBtn:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)
    backBtn:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    end)
    backBtn:SetScript("OnClick", function()
        self:Hide()
        if _G.HousingUINew and _G.HousingUINew.ReturnToCaller then
            _G.HousingUINew:ReturnToCaller()
        end
    end)
    backBtn:SetFrameLevel((container:GetFrameLevel() or 0) + 20)

    local hint = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    hint:SetPoint("TOP", title, "BOTTOM", 0, -4)
    hint:SetText(L["AUCTION_HOUSE_HINT"] or "Prices are cached per item. Requires Auctionator or TSM. Click Scan All to cache prices.")
    hint:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)

    local statusText = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statusText:SetPoint("TOPLEFT", 20, -60)
    statusText:SetJustifyH("LEFT")
    statusText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    self._statusText = statusText

    local lastScanText = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    lastScanText:SetPoint("TOPLEFT", 20, -82)
    lastScanText:SetJustifyH("LEFT")
    lastScanText:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
    self._lastScanText = lastScanText

    local providerText = container:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    providerText:SetPoint("TOPLEFT", 20, -98)
    providerText:SetJustifyH("LEFT")
    providerText:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
    providerText:SetText((L["AUCTION_HOUSE_PRICE_SOURCE"] or "Price source:") .. " " .. GetPriceProviderDesc())
    self._providerText = providerText

    local progressBar = CreateFrame("StatusBar", nil, container, "BackdropTemplate")
    progressBar:SetPoint("TOPLEFT", 20, -112)
    progressBar:SetPoint("TOPRIGHT", -40, -112)
    progressBar:SetHeight(14)
    progressBar:SetMinMaxValues(0, 1)
    progressBar:SetValue(0)
    progressBar:SetStatusBarTexture("Interface\\Buttons\\WHITE8x8")
    progressBar:SetStatusBarColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 0.9)
    progressBar:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    progressBar:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], 0.85)
    progressBar:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    progressBar:Hide()
    self._progressBar = progressBar

    local progressText = progressBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    progressText:SetPoint("CENTER", 0, 0)
    progressText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    progressText:SetText("")
    self._progressText = progressText

    local scanAllBtn = CreateFrame("Button", nil, container, "BackdropTemplate")
    scanAllBtn:SetSize(120, 28)
    scanAllBtn:SetPoint("TOPRIGHT", -20, -50)
    scanAllBtn:EnableMouse(true)
    scanAllBtn:RegisterForClicks("LeftButtonUp")
    scanAllBtn:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    scanAllBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    scanAllBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])

    local scanAllText = scanAllBtn:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    scanAllText:SetPoint("CENTER")
    scanAllText:SetText(L["AUCTION_HOUSE_FULL_SCAN"] or "Scan All")
    scanAllText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    scanAllBtn.label = scanAllText
    scanAllBtn:SetScript("OnEnter", function(self)
        self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
    end)
    scanAllBtn:SetScript("OnLeave", function(self)
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    end)
    scanAllBtn:SetScript("OnClick", function()
        self:_StartFullScan()
    end)
    scanAllBtn:Enable()
    self._scanBtn = scanAllBtn

    -- Make sure scan button is on top of scroll content and other UI elements.
    local baseLevel = container:GetFrameLevel() or 0
    scanAllBtn:SetFrameLevel(baseLevel + 20)

    local scrollFrame = CreateFrame("ScrollFrame", nil, container, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", 20, -130)
    scrollFrame:SetPoint("BOTTOMRIGHT", -40, 20)

    local content = CreateFrame("Frame", nil, scrollFrame)
    content:SetSize(container:GetWidth() - 80, 1)
    scrollFrame:SetScrollChild(content)
    self._listContent = content
    self._listContainer = container

    self._rowPool = {}
    self._rowByItemID = {}
    self._scanProgress = { current = 0, total = 0 }

    self._container = container
end

function AuctionHouseUI:_CreateRow()
    local content = self._listContent
    if not content then
        return nil
    end

    local row = CreateFrame("Frame", nil, content, "BackdropTemplate")
    row:SetSize(content:GetWidth(), ROW_HEIGHT)
    row:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    row:SetBackdropColor(0, 0, 0, 0.3)
    row:SetBackdropBorderColor(0, 0, 0, 0)

    local name = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    name:SetPoint("LEFT", 5, 0)
    name:SetJustifyH("LEFT")
    name:SetSize(content:GetWidth() * 0.6, ROW_HEIGHT)
    name:SetTextColor(1, 1, 1, 1)
    row.nameText = name

    local price = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    price:SetPoint("RIGHT", -5, 0)
    price:SetJustifyH("RIGHT")
    price:SetTextColor(1, 0.82, 0, 1)
    row.priceText = price

    local rowIndex = #self._rowPool
    table.insert(self._rowPool, row)
    return row
end

function AuctionHouseUI:_UpdateRow(row, itemID, name, priceText)
    if not row then
        return
    end
    row.itemID = itemID
    row.nameText:SetText(name)
    row.priceText:SetText(priceText or "|cFF909090No price|r")
    row:Show()
    self._rowByItemID[itemID] = row
end

function AuctionHouseUI:_IsAuctionAvailable()
    local api = GetAuctionHouseAPI()
    if not api then
        return false
    end
    return api.HasAddonPriceSource and api:HasAddonPriceSource() or false
end

function AuctionHouseUI:_UpdateScanButtonState()
    if not self._scanBtn then
        return
    end

    local enabled = self:_IsAuctionAvailable()

    if enabled then
        self._scanBtn:Enable()
        self._scanBtn.label:SetTextColor(1, 1, 1, 1)
    else
        self._scanBtn:Disable()
        self._scanBtn.label:SetTextColor(0.6, 0.6, 0.6, 1)
    end
end

function AuctionHouseUI:_UpdateProviderText()
    if self._providerText then
        self._providerText:SetText((L["AUCTION_HOUSE_PRICE_SOURCE"] or "Price source:") .. " " .. GetPriceProviderDesc())
    end
end

function AuctionHouseUI:_SetProgress(current, total)
    total = tonumber(total) or 0
    current = tonumber(current) or 0

    if not self._progressBar then
        return
    end

    if total <= 0 then
        self._progressBar:Hide()
        if self._progressText then
            self._progressText:SetText("")
        end
        return
    end

    local pct = Clamp(current / total, 0, 1)
    self._progressBar:SetMinMaxValues(0, 1)
    self._progressBar:SetValue(pct)
    self._progressBar:Show()

    if self._progressText then
        self._progressText:SetText(string.format("Scan progress: %d / %d (%d%%)", current, total, math.floor(pct * 100 + 0.5)))
    end
end

function AuctionHouseUI:_UpdateStatus(line, suffix)
    if self._statusText then
        self._statusText:SetText(line)
    end
    if self._lastScanText then
        local cache = HousingDB and HousingDB.auctionCache
        local lastScan = cache and cache.lastScan
        local total = cache and cache.items and (function()
            local count = 0
            for _ in pairs(cache.items) do
                count = count + 1
            end
            return count
        end)() or 0
        local lastDesc = lastScan and date("%H:%M:%S", lastScan) or "never"
        self._lastScanText:SetText(string.format("Last scan: %s (%d prices cached)%s", lastDesc, total, suffix or ""))
    end
end

function AuctionHouseUI:_ImportBrowse()
    local api = GetAuctionHouseAPI()
    if not api then
        print("|cFFFF4040HousingVendor:|r AuctionHouseAPI module missing")
        return
    end
    if not (_G.C_AuctionHouse and (_G.C_AuctionHouse.GetBrowseResults or _G.C_AuctionHouse.GetNumBrowseResults)) then
        print("|cFFFFD100HousingVendor:|r Import Browse reads the Blizzard AH browse list and isn't available on this client/build.")
        print("|cFFFFD100HousingVendor:|r Tip: with Auctionator/TSM installed, use Scan All instead.")
        return
    end
    if not api:IsAuctionHouseOpen() then
        print("|cFFFF4040HousingVendor:|r Open the Auction House first.")
        return
    end

    print("|cFF8A7FD4HousingVendor:|r Importing current Auction House browse results...")
    local ok, imported, priced = api:ImportBrowseResults({ maxResults = 2000 })
    if not ok then
        print("|cFFFF4040HousingVendor:|r Browse import not available on this client/build.")
        return
    end

    imported = tonumber(imported) or 0
    priced = tonumber(priced) or 0
    print(string.format("|cFF8A7FD4HousingVendor:|r Browse import complete: %d items seen, %d priced", imported, priced))
    self:_RefreshItems()
end

function AuctionHouseUI:_RefreshItems()
    if not self._container or not self._container:IsShown() then
        return
    end

    local api = GetAuctionHouseAPI()

    local itemIDs = {}
    if HousingItemList and HousingItemList.GetFilteredItemIDs then
        itemIDs = IntersectWithProfessionItemIDs(HousingItemList:GetFilteredItemIDs())
    end

    if #itemIDs == 0 then
        itemIDs = GetProfessionItemIDs()
    end

    self._rowByItemID = {}

    local limit = math_min(#itemIDs, MAX_ROWS)
    local content = self._listContent
    if not content then
        return
    end

    local offsetY = 0
    for i = 1, limit do
        local row = self._rowPool[i] or self:_CreateRow()
        row:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -offsetY)
        row:SetPoint("TOPRIGHT", content, "TOPRIGHT", 0, -offsetY)
        local itemID = itemIDs[i]
        local name = FormatItemName(itemID)
        local price, _
        if api then
            price = api:GetCachedPrice(itemID)
        end
        local priceStr
        if price then
            priceStr = FormatMoney(price)
        end
        self:_UpdateRow(row, itemID, name, priceStr)
        offsetY = offsetY + ROW_HEIGHT + ROW_SPACING
    end

    for i = limit + 1, #self._rowPool do
        self._rowPool[i]:Hide()
    end

    content:SetHeight(limit * (ROW_HEIGHT + ROW_SPACING))
    local suffix = (#itemIDs > MAX_ROWS) and string.format(" (showing first %d)", MAX_ROWS) or ""
    self:_UpdateStatus(string.format("Displaying %d profession items%s", #itemIDs, suffix))
end

function AuctionHouseUI:_StartScan()
    print("|cFF8A7FD4HousingVendor:|r DEBUG: _StartScan called")

    local api = GetAuctionHouseAPI()
    if not api then
        print("|cFFFF4040HousingVendor:|r AuctionHouseAPI module missing")
        return
    end
    print("|cFF8A7FD4HousingVendor:|r DEBUG: HousingAuctionHouseAPI exists")

    local ahOpen = api:IsAuctionHouseOpen()
    if not ahOpen and not (api.HasAddonPriceSource and api:HasAddonPriceSource()) then
        print("|cFFFF4040HousingVendor:|r Open the Auction House before scanning")
        return
    end
    print("|cFF8A7FD4HousingVendor:|r DEBUG: AH is " .. (ahOpen and "open" or "not detected") .. " (addon pricing: " .. tostring(api.HasAddonPriceSource and api:HasAddonPriceSource()) .. ")")

    local items = {}
    if HousingItemList and HousingItemList.GetFilteredItemIDs then
        items = IntersectWithProfessionItemIDs(HousingItemList:GetFilteredItemIDs())
    else
        print("|cFFFF4040HousingVendor:|r Item list not available for scanning")
        return
    end
    print("|cFF8A7FD4HousingVendor:|r DEBUG: Got " .. #items .. " items")

    if #items == 0 then
        print("|cFF8A7FD4HousingVendor:|r No filtered items to scan")
        return
    end

    local maxAge = (HousingDB and HousingDB.settings and tonumber(HousingDB.settings.ahPriceMaxAgeSeconds)) or DEFAULT_MAX_PRICE_AGE_SECONDS
    local toScan = {}
    for _, itemID in ipairs(items) do
        if api:IsPriceStale(itemID, maxAge) then
            table.insert(toScan, itemID)
        end
    end

    if #toScan == 0 then
        print("|cFF8A7FD4HousingVendor:|r All visible profession items already have recent prices.")
        return
    end

    print("|cFF8A7FD4HousingVendor:|r Scanning missing/outdated prices for " .. #toScan .. " visible profession items")
    api:QueueScan(toScan, false)
end

function AuctionHouseUI:_StartFullScan()
    local api = GetAuctionHouseAPI()
    if not api then
        print("|cFFFF4040HousingVendor:|r AuctionHouseAPI module missing")
        return
    end

    if not api:IsAuctionHouseOpen() and not (api.HasAddonPriceSource and api:HasAddonPriceSource()) then
        print("|cFFFF4040HousingVendor:|r Open the Auction House before scanning")
        return
    end

    local items = GetProfessionItemIDs()

    if not items or #items == 0 then
        print("|cFF8A7FD4HousingVendor:|r No profession items available for scan")
        return
    end

    local maxAge = (HousingDB and HousingDB.settings and tonumber(HousingDB.settings.ahPriceMaxAgeSeconds)) or DEFAULT_MAX_PRICE_AGE_SECONDS
    local toScan = {}
    for _, itemID in ipairs(items) do
        if api:IsPriceStale(itemID, maxAge) then
            table.insert(toScan, itemID)
        end
    end

    if #toScan == 0 then
        print("|cFF8A7FD4HousingVendor:|r All profession items already have recent prices.")
        return
    end

    print(string.format("|cFF8A7FD4HousingVendor:|r Scanning missing/outdated prices for %d profession items", #toScan))
    api:QueueScan(toScan, false)
end

function AuctionHouseUI:_RegisterAuctionListeners()
    local api = GetAuctionHouseAPI()
    if not api or self._listenerRegistered then
        return
    end

    api:RegisterListener("HousingAuctionHouseUI", function(event, ...)
        self:_OnAuctionEvent(event, ...)
    end)
    self._listenerRegistered = true
    self:_UpdateScanButtonState()
end

function AuctionHouseUI:_RegisterFilterHook()
    if not HousingFilters or self._filtersHooked then
        return
    end
    local original = HousingFilters.ApplyFilters
    if type(original) ~= "function" then
        return
    end

    HousingFilters.ApplyFilters = function(...)
        local result = original(...)
        if AuctionHouseUI and AuctionHouseUI._container and AuctionHouseUI._container:IsShown() then
            AuctionHouseUI:_RefreshItems()
        end
        return result
    end

    self._filtersHooked = true
end

function AuctionHouseUI:_OnAuctionEvent(event, ...)
    if event == "auction_house_open" or event == "auction_house_closed" then
        self:_UpdateScanButtonState()
        self:_UpdateProviderText()
        if event == "auction_house_open" then
            self:_UpdateStatus("Auction House open. Click Scan All to cache prices.", "")
        end
        return
    end

    if event == "scan_started" then
        local total = select(1, ...)
        self._scanProgress.current = 0
        self._scanProgress.total = total or 0
        self:_UpdateStatus("Scan started", "")
        self:_SetProgress(0, self._scanProgress.total)
        return
    end

    if event == "scan_progress" then
        local index = select(1, ...)
        local total = select(2, ...)
        local itemID = select(3, ...)
        self._scanProgress.current = index or self._scanProgress.current
        self._scanProgress.total = total or self._scanProgress.total
        local line = string.format("Scanning %d of %d (%s)", self._scanProgress.current, self._scanProgress.total, FormatItemName(itemID or 0))
        self:_UpdateStatus(line)
        self:_SetProgress(self._scanProgress.current, self._scanProgress.total)
        return
    end

    if event == "scan_complete" then
        self._scanProgress.current = self._scanProgress.total or 0
        self:_UpdateStatus("Scan complete")
        self:_SetProgress(self._scanProgress.current, self._scanProgress.total)
        if _G.C_Timer and _G.C_Timer.After then
            _G.C_Timer.After(1.25, function()
                self:_SetProgress(0, 0)
            end)
        end
        self:_RefreshItems()
        return
    end

    if event == "scan_stopped" then
        self:_UpdateStatus("Scan stopped", "")
        self:_SetProgress(0, 0)
        return
    end

    if event == "price_updated" then
        local itemID = select(1, ...)
        local price = select(2, ...)
        if itemID and self._rowByItemID[itemID] then
            self._rowByItemID[itemID].priceText:SetText(price and FormatMoney(price) or "|cFF909090No price|r")
        end
    end
end

function AuctionHouseUI:Show()
    if not self._container then
        self:_CreateContainer()
    end
    if not self._container then
        return
    end

    if HousingFilters and HousingFilters.HideAllPopups then
        HousingFilters:HideAllPopups()
    end

    if HousingAchievementsUI and HousingAchievementsUI.Hide then
        HousingAchievementsUI:Hide()
    end
    if HousingEndeavorsUI and HousingEndeavorsUI.Hide then
        HousingEndeavorsUI:Hide()
    end
    if HousingReputationUI and HousingReputationUI.Hide then
        HousingReputationUI:Hide()
    end
    if HousingStatisticsUI and HousingStatisticsUI.Hide then
        HousingStatisticsUI:Hide()
    end

    SetMainUIVisible(false)
    self:_UpdateScanButtonState()
    self:_UpdateProviderText()
    self:_RefreshItems()
    self._container:Show()
end

function AuctionHouseUI:Hide()
    if self._container then
        self._container:Hide()
    end
    SetMainUIVisible(true)
end

function AuctionHouseUI:Toggle()
    if self._container and self._container:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end

_G["HousingAuctionHouseUI"] = AuctionHouseUI

return AuctionHouseUI
