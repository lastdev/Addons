local _G = _G
local C_Timer = C_Timer
local tonumber = tonumber
local type = type
local ipairs = ipairs
local next = next
local pcall = pcall
local unpack = unpack or table.unpack
local table_insert = table.insert
local table_concat = table.concat
local math_floor = math.floor
local tostring = tostring
local string_format = string.format
local string_find = string.find
local string_gsub = string.gsub
local GetTime = GetTime

local ItemList = _G["HousingItemList"] or {}
_G["HousingItemList"] = ItemList

local Theme = nil
local function GetTheme()
    if not Theme then
        Theme = HousingTheme or {}
    end
    return Theme
end

local QUALITY_COLOR_BY_ID = {
    [0] = "|cff9d9d9d", -- Poor (gray)
    [1] = "|cffEBE8F0", -- Common (soft white-purple)
    [2] = "|cff1EFF00", -- Uncommon (green)
    [3] = "|cff4080E6", -- Rare (moonlit blue)
    [4] = "|cffA855F7", -- Epic (vibrant purple)
    [5] = "|cffFF8000", -- Legendary (orange)
}

local QUALITY_COLOR_BY_NAME = {
    Poor = QUALITY_COLOR_BY_ID[0],
    Common = QUALITY_COLOR_BY_ID[1],
    Uncommon = QUALITY_COLOR_BY_ID[2],
    Rare = QUALITY_COLOR_BY_ID[3],
    Epic = QUALITY_COLOR_BY_ID[4],
    Legendary = QUALITY_COLOR_BY_ID[5],
}

local function GetQualityColorCode(quality)
    if quality == nil then return nil end
    if type(quality) == "number" then
        return QUALITY_COLOR_BY_ID[quality]
    end
    if type(quality) == "string" then
        return QUALITY_COLOR_BY_NAME[quality]
    end
    return nil
end

local function GetQualityRGB(quality)
    if quality == nil then return nil end
    if C_Item and C_Item.GetItemQualityColor then
        local r, g, b = C_Item.GetItemQualityColor(quality)
        if r then return r, g, b end
    end
    if GetItemQualityColor then
        local r, g, b = GetItemQualityColor(quality)
        if r then return r, g, b end
    end
    return nil
end

local DEFAULT_COLORS = {
    factionHorde = { 0.85, 0.20, 0.25, 1.0 },
    factionAlliance = { 0.25, 0.50, 0.90, 1.0 },
    factionNeutral = { 0.60, 0.58, 0.65, 1.0 },
    sourceAchievement = { 0.95, 0.80, 0.25, 1.0 },
    sourceQuest = { 0.80, 0.45, 0.95, 1.0 },
    sourceDrop = { 0.95, 0.60, 0.25, 1.0 },
    sourceVendor = { 0.35, 0.80, 0.45, 1.0 },
    bgTertiary = { 0.16, 0.12, 0.24, 0.90 },
}

local NEW_TIMER = C_Timer and C_Timer.NewTimer or nil
local NEW_TICKER = C_Timer and C_Timer.NewTicker or nil

local ITEM_LOAD_REQUESTED = {}
local ITEM_ICON_CACHE = {}
local ITEM_LOAD_REQUESTED_COUNT = 0
local ITEM_ICON_CACHE_COUNT = 0
local MAX_ITEM_LOAD_REQUESTED = 8000
local MAX_ITEM_ICON_CACHE = 2000

local COST_ICON_CACHE = {}
local COST_ICON_CACHE_COUNT = 0
local MAX_COST_ICON_CACHE = 2500

local CURRENCY_ICON_MARKUP_CACHE = {}
local ITEM_ICON_MARKUP_CACHE = {}
local CURRENCY_ICON_MARKUP_CACHE_COUNT = 0
local ITEM_ICON_MARKUP_CACHE_COUNT = 0
local MAX_ICON_MARKUP_CACHE = 2000

local function GetItemIconMarkup(itemID)
    local id = tonumber(itemID)
    if not id or id <= 0 then return nil end

    local cached = ITEM_ICON_MARKUP_CACHE[id]
    if cached ~= nil then
        return cached
    end

    local icon = nil
    if C_Item and C_Item.GetItemIconByID then
        icon = C_Item.GetItemIconByID(id)
    end
    if (not icon or icon == "") and GetItemIcon then
        icon = GetItemIcon(id)
    end

    if not icon or icon == "" then
        ITEM_ICON_MARKUP_CACHE[id] = nil
        return nil
    end

    local markup = "|T" .. tostring(icon) .. ":14|t"
    if ITEM_ICON_MARKUP_CACHE[id] == nil then
        ITEM_ICON_MARKUP_CACHE_COUNT = ITEM_ICON_MARKUP_CACHE_COUNT + 1
        if ITEM_ICON_MARKUP_CACHE_COUNT > MAX_ICON_MARKUP_CACHE then
            ResetTable(ITEM_ICON_MARKUP_CACHE)
            ITEM_ICON_MARKUP_CACHE_COUNT = 0
        end
    end
    ITEM_ICON_MARKUP_CACHE[id] = markup
    return markup
end

local function GetCurrencyIconMarkup(currencyID)
    local id = tonumber(currencyID)
    if not id or id <= 0 then return nil end

    local fallbackIconFileIDs = {
        -- Legacy currencies may not return iconFileID unless discovered; provide known icons for common ones.
        [1220] = 7382824, -- Order Resources
    }

    local cached = CURRENCY_ICON_MARKUP_CACHE[id]
    if cached ~= nil then
        return cached
    end

    local currencyInfo = nil
    if HousingAPI and HousingAPI.GetCurrencyInfo then
        currencyInfo = HousingAPI:GetCurrencyInfo(id)
    elseif C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
        local ok, info = pcall(C_CurrencyInfo.GetCurrencyInfo, id)
        if ok then currencyInfo = info end
    end

    local iconFileID = currencyInfo and (currencyInfo.iconFileID or currencyInfo.icon)
    if not iconFileID then
        iconFileID = fallbackIconFileIDs[id]
    end
    if not iconFileID then
        CURRENCY_ICON_MARKUP_CACHE[id] = nil
        return nil
    end

    local markup = "|T" .. tostring(iconFileID) .. ":14|t"
    if CURRENCY_ICON_MARKUP_CACHE[id] == nil then
        CURRENCY_ICON_MARKUP_CACHE_COUNT = CURRENCY_ICON_MARKUP_CACHE_COUNT + 1
        if CURRENCY_ICON_MARKUP_CACHE_COUNT > MAX_ICON_MARKUP_CACHE then
            ResetTable(CURRENCY_ICON_MARKUP_CACHE)
            CURRENCY_ICON_MARKUP_CACHE_COUNT = 0
        end
    end
    CURRENCY_ICON_MARKUP_CACHE[id] = markup
    return markup
end

local function ApplyStaticCostIcons(text, components)
    if type(text) ~= "string" or text == "" then
        return text
    end

    local cacheKey = text
    if type(components) == "table" and #components > 0 then
        local parts = { text, "|" }
        for i = 1, #components do
            local c = components[i]
            if c then
                parts[#parts + 1] = tostring(c.currencyTypeID or 0)
                parts[#parts + 1] = ":"
                parts[#parts + 1] = tostring(c.itemID or 0)
                parts[#parts + 1] = ":"
                parts[#parts + 1] = tostring(c.amount or 0)
                parts[#parts + 1] = ";"
            end
        end
        cacheKey = table_concat(parts, "")
    end

    local cached = COST_ICON_CACHE[cacheKey]
    if cached ~= nil then
        return cached
    end

    if not string_find(text, "|TInterface\\MoneyFrame\\UI-GoldIcon", 1, true) then
        text = string_gsub(text, "([%d,]+)%s*[Gg]old(%*?)", "%1 |TInterface\\MoneyFrame\\UI-GoldIcon:0|t%2")
    end

    -- If we don't have structured components for a mixed cost (e.g. API only),
    -- still attempt to replace known currency words with their icons.
    do
        local known = {
            { id = 1220, name = "Order Resources" },
            { id = 1560, name = "War Resources" },
            { id = 1155, name = "Ancient Mana" },
            { id = 2815, name = "Resonance Crystals" },
            { id = 2003, name = "Dragon Isles Supplies" },
        }
        for _, k in ipairs(known) do
            local icon = GetCurrencyIconMarkup(k.id)
            if icon and icon ~= "" then
                local escapedName = string_gsub(k.name, "([^%w])", "%%%1")
                text = string_gsub(text, "([%d,]+)%s+" .. escapedName .. "(%*?)", "%1 " .. icon .. "%2")
            end
        end
    end

    -- Same idea for item-based costs (Mechagon parts, etc.).
    do
        local knownItems = {
            { id = 166970, name = "Energy Cell" },
            { id = 168832, name = "Galvanic Oscillator" },
            { id = 168327, name = "Chain Ignitercoil" },
            { id = 169610, name = "S.P.A.R.E. Crate" },
            { id = 166846, name = "Spare Parts" },
        }
        for _, k in ipairs(knownItems) do
            local icon = GetItemIconMarkup(k.id)
            if icon and icon ~= "" then
                local escapedName = string_gsub(k.name, "([^%w])", "%%%1")
                text = string_gsub(text, "([%d,]+)%s+" .. escapedName .. "(%*?)", "%1 " .. icon .. "%2")
            end
        end
    end

    if type(components) ~= "table" or #components == 0 then
        COST_ICON_CACHE[cacheKey] = text
        COST_ICON_CACHE_COUNT = COST_ICON_CACHE_COUNT + 1
        if COST_ICON_CACHE_COUNT > MAX_COST_ICON_CACHE then
            ResetTable(COST_ICON_CACHE)
            COST_ICON_CACHE_COUNT = 0
        end
        return text
    end

    for _, component in ipairs(components) do
        local itemID = component and component.itemID
        local currencyTypeID = component and component.currencyTypeID
        local amount = component and component.amount
        if itemID and amount then
            local icon = GetItemIconMarkup(itemID)
            if icon and icon ~= "" then
                local name = component.name or ""
                name = tostring(name or "")
                if name ~= "" then
                    local escapedName = string_gsub(name, "([^%w])", "%%%1")
                    local amountStr = tostring(amount)
                    local amountWithComma = amountStr:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
                    text = string_gsub(text, amountWithComma .. "%s+" .. escapedName, amountWithComma .. " " .. icon)
                    text = string_gsub(text, amountStr .. "%s+" .. escapedName, amountStr .. " " .. icon)
                end
            end
        elseif currencyTypeID and amount then
            local icon = GetCurrencyIconMarkup(currencyTypeID)
            if icon and icon ~= "" then
                local name = component.name or ""
                name = tostring(name or "")
                if name ~= "" then
                    local escapedName = string_gsub(name, "([^%w])", "%%%1")
                    local amountStr = tostring(amount)
                    local amountWithComma = amountStr:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
                    text = string_gsub(text, amountWithComma .. "%s+" .. escapedName, amountWithComma .. " " .. icon)
                    text = string_gsub(text, amountStr .. "%s+" .. escapedName, amountStr .. " " .. icon)
                end
            end
        end
    end

    COST_ICON_CACHE[cacheKey] = text
    COST_ICON_CACHE_COUNT = COST_ICON_CACHE_COUNT + 1
    if COST_ICON_CACHE_COUNT > MAX_COST_ICON_CACHE then
        ResetTable(COST_ICON_CACHE)
        COST_ICON_CACHE_COUNT = 0
    end
    return text
end

function ItemList:GetCostIconCacheStats()
    local n = 0
    for _ in pairs(COST_ICON_CACHE) do n = n + 1 end
    return { entries = n, max = MAX_COST_ICON_CACHE }
end

local function ResetTable(t)
    if not t then return end
    for k in pairs(t) do
        t[k] = nil
    end
end

local function CancelHandle(handle)
    if handle and handle.Cancel then
        handle:Cancel()
    end
end

local function CancelAsyncWork(button)
    if not button then return end
    CancelHandle(button._hvVendorCostTimer)
    CancelHandle(button._hvVendorCostTicker)
    CancelHandle(button._hvIconTimer)
    CancelHandle(button._hvIconTicker)
    CancelHandle(button._hvQualityTimer)
    CancelHandle(button._hvQualityTicker)
    button._hvVendorCostTimer = nil
    button._hvVendorCostTicker = nil
    button._hvIconTimer = nil
    button._hvIconTicker = nil
    button._hvQualityTimer = nil
    button._hvQualityTicker = nil
end

-- Expose cleanup so other modules (e.g., ItemList:Cleanup) can cancel in-flight async work.
ItemList.CancelAsyncWork = CancelAsyncWork

function ItemList:ClearSessionCaches()
    ResetTable(ITEM_LOAD_REQUESTED)
    ITEM_LOAD_REQUESTED_COUNT = 0

    ResetTable(ITEM_ICON_CACHE)
    ITEM_ICON_CACHE_COUNT = 0

    ResetTable(COST_ICON_CACHE)
    COST_ICON_CACHE_COUNT = 0

    ResetTable(CURRENCY_ICON_MARKUP_CACHE)
    CURRENCY_ICON_MARKUP_CACHE_COUNT = 0

    ResetTable(ITEM_ICON_MARKUP_CACHE)
    ITEM_ICON_MARKUP_CACHE_COUNT = 0
end

local function SetBackdropColorSafe(frame, color)
    if frame and frame.SetBackdropColor and color then
        frame:SetBackdropColor(color[1], color[2], color[3], color[4])
    end
end

local function SetClickHandler(button, mode, handler)
    if not button then return end
    if button._hvClickMode == mode then return end
    button:EnableMouse(true)
    button:RegisterForClicks("LeftButtonUp")
    button:SetScript("OnClick", handler)
    button._hvClickMode = mode
end

local function OnRegularItemButtonClick(button)
    local item = button and button.itemData
    if not item then return end
    if HousingPreviewPanel then
        HousingPreviewPanel:ShowItem(item)
    end
end

local function OnSpecialViewItemButtonClick(button)
    local item = button and button.itemData
    if not item then return end

    local itemsToShow = nil
    if item._isExpansion and item._expansionData then
        itemsToShow = item._expansionData.items
    elseif item._isZone and item._zoneData then
        itemsToShow = item._zoneData.items
    elseif item._isVendor and item._vendorData then
        itemsToShow = item._vendorData.items
    end

    if itemsToShow and HousingFilters then
        local filters = HousingFilters:GetFilters()
        ItemList:UpdateItems(itemsToShow, filters)
        if _G["HousingBackButton"] then
            _G["HousingBackButton"]:Show()
        end
    end
end

local function RequestItemDataOnce(itemID)
    if not itemID then return end
    if ITEM_LOAD_REQUESTED[itemID] then return end
    ITEM_LOAD_REQUESTED[itemID] = true
    ITEM_LOAD_REQUESTED_COUNT = ITEM_LOAD_REQUESTED_COUNT + 1
    if ITEM_LOAD_REQUESTED_COUNT > MAX_ITEM_LOAD_REQUESTED then
        ResetTable(ITEM_LOAD_REQUESTED)
        ITEM_LOAD_REQUESTED_COUNT = 0
    end
    if C_Item and C_Item.RequestLoadItemDataByID then
        C_Item.RequestLoadItemDataByID(itemID)
    end
end

local function GetIconTextureForItemID(itemID)
    if not itemID then return nil end

    local cached = ITEM_ICON_CACHE[itemID]
    if cached and cached ~= "" then
        return cached
    end

    local iconTexture = nil
    if C_Item and C_Item.GetItemIconByID then
        iconTexture = C_Item.GetItemIconByID(itemID)
    end
    if not iconTexture and GetItemIcon then
        iconTexture = GetItemIcon(itemID)
    end

    if iconTexture and iconTexture ~= "" then
        if not ITEM_ICON_CACHE[itemID] then
            ITEM_ICON_CACHE_COUNT = ITEM_ICON_CACHE_COUNT + 1
            if ITEM_ICON_CACHE_COUNT > MAX_ITEM_ICON_CACHE then
                ResetTable(ITEM_ICON_CACHE)
                ITEM_ICON_CACHE_COUNT = 0
            end
        end
        ITEM_ICON_CACHE[itemID] = iconTexture
        return iconTexture
    end

    return nil
end

local function TrySetThumbnailTexture(button, item)
    if not button or not button.icon or not item then return false end

    local thumb = item.thumbnailFileID or item._thumbnailFileID
    local thumbID = thumb and tonumber(thumb) or nil
    if not (thumbID and thumbID > 0) then return false end

    if C_Texture and C_Texture.GetFileTextureInfo then
        local ok, texturePath = pcall(C_Texture.GetFileTextureInfo, thumbID)
        if ok and texturePath and texturePath ~= "" then
            button.icon:SetTexture(texturePath)
            return true
        end
    end

    return false
end

local function UpdateIconAsync(button, item, itemID, buttonIndex)
    if not (button and button.icon and itemID) then return end

    local questionMark = "Interface\\Icons\\INV_Misc_QuestionMark"
    local currentTexture = button.icon.GetTexture and button.icon:GetTexture() or nil
    local hasRealIcon = currentTexture and currentTexture ~= "" and currentTexture ~= questionMark

    if not hasRealIcon then
        button.icon:SetTexture(questionMark)
    end

    if TrySetThumbnailTexture(button, item) then
        return
    end

    local cachedIcon = GetIconTextureForItemID(itemID)
    if cachedIcon then
        button.icon:SetTexture(cachedIcon)
        return
    end

    RequestItemDataOnce(itemID)

    local maxAttempts = 5
    local retryDelay = 0.1
    local delay = 0.01 * (buttonIndex or 1)

    local function Try()
        if not button:IsVisible() then return end
        if button._hvItemID ~= itemID then return end

        local iconTexture = GetIconTextureForItemID(itemID)
        if iconTexture then
            button.icon:SetTexture(iconTexture)
            CancelHandle(button._hvIconTicker)
            button._hvIconTicker = nil
        end
    end

    if NEW_TIMER then
        CancelHandle(button._hvIconTimer)
        button._hvIconTimer = NEW_TIMER(delay, function()
            Try()
            if button:IsVisible() and button._hvItemID == itemID and not ITEM_ICON_CACHE[itemID] then
                CancelHandle(button._hvIconTicker)
                if NEW_TICKER then
                    button._hvIconTicker = NEW_TICKER(retryDelay, Try, maxAttempts)
                else
                    for _ = 1, maxAttempts do
                        C_Timer.After(retryDelay, Try)
                    end
                end
            end
        end)
    else
        C_Timer.After(delay, Try)
    end
end

local function UpdateQualityAsync(button, item, itemID, buttonIndex)
    if not (button and itemID) then return end

    RequestItemDataOnce(itemID)

    local maxAttempts = 6
    local retryDelay = 0.2
    local delay = 0.01 * (buttonIndex or 1)

    local function Try()
        if not button:IsVisible() then return end
        if button._hvItemID ~= itemID then return end

        local quality = nil
        if C_Item and C_Item.GetItemQualityByID then
            quality = C_Item.GetItemQualityByID(itemID)
        end
        if quality == nil and GetItemInfo then
            local _, _, q = GetItemInfo(itemID)
            quality = q
        end

        if quality ~= nil then
            item._apiQuality = item._apiQuality or quality

            local displayName = item.name or "Unknown"
            local colorCode = GetQualityColorCode(quality)
            if colorCode and button.nameText then
                button.nameText:SetText(colorCode .. displayName .. "|r")
            elseif button.nameText then
                button.nameText:SetText(displayName)
            end

            if button.iconBorder then
                local r, g, b = GetQualityRGB(quality)
                local colors = (GetTheme().Colors or {})
                local borderPrimary = colors.borderPrimary or {0.35, 0.30, 0.50, 0.8}
                if r and g and b then
                    button.iconBorder:SetBackdropBorderColor(r, g, b, 1)
                else
                    button.iconBorder:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
                end
            end

            CancelHandle(button._hvQualityTicker)
            button._hvQualityTicker = nil
        end
    end

    if NEW_TIMER then
        CancelHandle(button._hvQualityTimer)
        button._hvQualityTimer = NEW_TIMER(delay, function()
            Try()
            if button:IsVisible() and button._hvItemID == itemID and (item._apiQuality == nil) then
                CancelHandle(button._hvQualityTicker)
                if NEW_TICKER then
                    button._hvQualityTicker = NEW_TICKER(retryDelay, Try, maxAttempts)
                else
                    for _ = 1, maxAttempts do
                        C_Timer.After(retryDelay, Try)
                    end
                end
            end
        end)
    else
        C_Timer.After(delay, Try)
    end
end

local function FormatCostFromVendorInfo(vendorInfo)
    if not vendorInfo or not vendorInfo.cost or #vendorInfo.cost == 0 then
        return nil
    end

    local parts = {}
    for _, costEntry in ipairs(vendorInfo.cost) do
        if costEntry then
            if costEntry.currencyID == 0 then
                local copperAmount = tonumber(costEntry.amount) or 0
                if GetCoinTextureString then
                    table_insert(parts, GetCoinTextureString(copperAmount))
                else
                    local gold = math_floor(copperAmount / 10000)
                    local silver = math_floor((copperAmount % 10000) / 100)
                    local copper = copperAmount % 100

                    if gold > 0 and silver > 0 then
                        table_insert(parts, string_format("%dg %ds", gold, silver))
                    elseif gold > 0 then
                        table_insert(parts, string_format("%dg", gold))
                    elseif silver > 0 then
                        table_insert(parts, string_format("%ds", silver))
                    elseif copper > 0 then
                        table_insert(parts, string_format("%dc", copper))
                    end
                end
            elseif costEntry.currencyID then
                local amount = tonumber(costEntry.amount) or 0
                local icon = GetCurrencyIconMarkup(costEntry.currencyID)
                if icon and icon ~= "" then
                    table_insert(parts, tostring(amount) .. " " .. icon)
                else
                    local currencyName = "Currency #" .. tostring(costEntry.currencyID)
                    local currencyInfo = HousingAPI and HousingAPI.GetCurrencyInfo and HousingAPI:GetCurrencyInfo(costEntry.currencyID)
                    if currencyInfo and currencyInfo.name then
                        currencyName = currencyInfo.name
                    elseif HousingCurrencyTypes and HousingCurrencyTypes[costEntry.currencyID] then
                        currencyName = HousingCurrencyTypes[costEntry.currencyID]
                    end
                    table_insert(parts, tostring(amount) .. " " .. currencyName)
                end
            end
        end
    end

    if #parts == 0 then return nil end
    return table_concat(parts, " + ")
end

local function PopulateVendorAndCostOnce(button, item, itemID)
    if not (button and item and itemID and HousingAPI) then return end
    if not button:IsVisible() then return end
    if button._hvItemID ~= itemID then return end
    if button._hvCostDone and button._hvVendorDone then return end

    local catalogData = nil
    if HousingAPICache and HousingAPICache.GetCatalogData then
        catalogData = HousingAPICache:GetCatalogData(itemID)
    else
        catalogData = HousingAPI:GetCatalogData(itemID)
    end

    if catalogData and button.nameText then
        if catalogData.name and (not item.name or item.name == "" or item.name == "Unknown Item") then
            item.name = catalogData.name
        end
        if catalogData.quality ~= nil then
            item._apiQuality = catalogData.quality
            local colorCode = GetQualityColorCode(catalogData.quality) or QUALITY_COLOR_BY_ID[1]
            local displayName = item.name or catalogData.name or "Unknown"
            button.nameText:SetText(colorCode .. displayName .. "|r")
        else
            local displayName = item.name or catalogData.name or "Unknown"
            button.nameText:SetText(displayName)
        end
    end

    if button.vendorText then
        local Filters = _G.HousingFilters
        local filterVendor = Filters and Filters.currentFilters and Filters.currentFilters.vendor or nil
        if _G.HousingVendorHelper then
            local staticVendor = _G.HousingVendorHelper:GetVendorName(item, filterVendor)
            if staticVendor and staticVendor ~= "" then
                button.vendorText:SetText(staticVendor)
                button.vendorText:Show()
                button._hvVendorDone = true
            end
        end

        local currentVendor = button.vendorText:GetText()
        if (not currentVendor or currentVendor == "") and catalogData and catalogData.vendor and catalogData.vendor ~= "" then
            button.vendorText:SetText(catalogData.vendor)
            button.vendorText:Show()
            button._hvVendorDone = true
        end
    end

    if catalogData and button.costText and catalogData.cost and catalogData.cost ~= "" then
        local current = button.costText:GetText()
        if not current or current == "" or current == "..." or current ~= catalogData.cost then
            local decorated = ApplyStaticCostIcons(catalogData.cost, item and item._staticCostComponents)
            local canUpgrade = (not current or current == "" or current == "...")
                or (type(current) == "string" and not string_find(current, "|T", 1, true) and string_find(catalogData.cost, "|T", 1, true))
            if canUpgrade then
                button.costText:SetText(decorated)
            end
        end
        button.costText:Show()
        button._hvCostDone = true
    end

    if button._hvCostDone and button._hvVendorDone then
        return
    end

    local enrichedVendors = nil
    if HousingDataEnrichment then
        enrichedVendors = HousingDataEnrichment:GetVendorInfo(itemID)
    end
    if enrichedVendors and #enrichedVendors > 0 then
        local vendor = enrichedVendors[1]
        if button.vendorText and vendor.name and vendor.name ~= "" then
            button.vendorText:SetText(vendor.name)
            button.vendorText:Show()
            button._hvVendorDone = true
        end
        if button.costText and vendor.price and vendor.currency and vendor.price > 0 then
            local costText = (vendor.currency == "Gold")
                and string_format("%dg", vendor.price)
                or string_format("%d %s", vendor.price, vendor.currency)
            local current = button.costText:GetText()
            if not current or current == "" or current == "..." or current ~= costText then
                button.costText:SetText(costText)
            end
            button.costText:Show()
            button._hvCostDone = true
        end
        return
    end

    local vendorInfo = nil
    local baseInfo = HousingAPI:GetDecorItemInfoFromItemID(itemID)
    if baseInfo and baseInfo.decorID then
        if HousingAPICache and HousingAPICache.GetVendorInfo then
            vendorInfo = HousingAPICache:GetVendorInfo(baseInfo.decorID)
        else
            vendorInfo = HousingAPI:GetDecorVendorInfo(baseInfo.decorID)
        end
    end

    if vendorInfo then
        if button.vendorText then
            local currentVendor = button.vendorText:GetText()
            if (not currentVendor or currentVendor == "") and vendorInfo.name and vendorInfo.name ~= "" then
                button.vendorText:SetText(vendorInfo.name)
                button.vendorText:Show()
                button._hvVendorDone = true
            end
        end

        if button.costText then
            local currentCost = button.costText:GetText()
            if not currentCost or currentCost == "" or currentCost == "..." then
                local formatted = FormatCostFromVendorInfo(vendorInfo)
                if formatted and formatted ~= "" then
                    button.costText:SetText(formatted)
                    button.costText:Show()
                    button._hvCostDone = true
                end
            end
        end
    end
end

-- Update a special view item button (expansion, location, vendor)
function ItemList:UpdateSpecialViewItemButton(button, item)
    if not button or not item then return end

    button.itemData = item

    -- Determine the type and set appropriate visuals
    local viewType = "Item"
    local viewColor = {0.196, 0.804, 0.196, 1}  -- Green for vendor (#32CD32)
    
    if item._isExpansion then
        viewType = "Expansion"
        viewColor = {0.64, 0.21, 0.93, 1}  -- Purple for expansion (#A035EE)
    elseif item._isZone then
        viewType = "Location"
        viewColor = {0, 0.44, 0.87, 1}  -- Blue for location (#0070DD)
    elseif item._isVendor then
        viewType = "Vendor"
        viewColor = {1, 0.5, 0, 1}  -- Orange for vendor (#FF8000)
    end
    
    -- Update faction/source color bar
    if button.factionBar then
        button.factionBar:SetVertexColor(viewColor[1], viewColor[2], viewColor[3], 1)
        button.factionBar:Show()
    end
    
    -- Update backdrop color
    local backdropColor = {0.1, 0.1, 0.1, 0.7}
    if item._isExpansion then
        backdropColor = {0.15, 0.05, 0.2, 0.9}  -- Dark purple for expansion
    elseif item._isZone then
        backdropColor = {0.05, 0.1, 0.2, 0.9}  -- Dark blue for location
    elseif item._isVendor then
        backdropColor = {0.2, 0.1, 0.05, 0.9}  -- Dark orange for vendor
    end
    
    button.originalBackdropColor = backdropColor
    SetBackdropColorSafe(button, backdropColor)
    
    -- Update item name
    if button.nameText then
        button.nameText:SetText(item.name or "")
    end
    
    -- Removed: Type text and tooltip info text (fields removed)
    
    -- Price text removed - no longer displaying price in main UI
    
    -- Hide map icon for special view items
    if button.mapIcon then
        button.mapIcon:Hide()
    end
    
    -- Set a generic icon for special views
    if button.icon then
        button.icon:SetTexture("Interface\\Icons\\INV_Misc_Map02")
    end
    
    -- Removed: housing icon and weight (fields removed)
    
    -- Override click behavior for special view items - drill down to show items
    SetClickHandler(button, "special", OnSpecialViewItemButtonClick)
end

function ItemList:UpdateRegularItemButton(button, item, buttonIndex)
    if not button then return end
    buttonIndex = buttonIndex or 1

    -- Accept itemIDs (number) and resolve to a lightweight record on demand
    if type(item) == "number" and _G.HousingDataManager and _G.HousingDataManager.GetItemRecord then
        item = _G.HousingDataManager:GetItemRecord(item)
        if not item then
            button.itemData = nil
            return
        end
    elseif type(item) == "number" then
        -- Numeric itemID but no resolver available; avoid indexing a number below.
        button.itemData = nil
        return
    end

    if type(item) ~= "table" then
        button.itemData = nil
        return
    end

    button.itemData = item
    
    -- Determine source type - prioritize API data over static data
    local isAchievement = false
    local isQuest = false
    local isDrop = false
    
    -- Check API data first (most accurate)
    if item._apiDataLoaded then
        if item._apiRequirementType == "Achievement" or item._apiAchievement then
            isAchievement = true
        elseif item._apiRequirementType == "Quest" then
            isQuest = true
        elseif item._apiRequirementType == "Drop" then
            isDrop = true
        end
    end
    
    -- Also check _sourceType field (set during data loading)
    if not isAchievement and not isQuest and not isDrop then
        if item._sourceType == "Achievement" then
            isAchievement = true
        elseif item._sourceType == "Quest" then
            isQuest = true
        elseif item._sourceType == "Drop" then
            isDrop = true
        end
    end
    
    -- Fallback to static data if API data not available
    if not isAchievement and not isQuest and not isDrop then
        isAchievement = item.achievementRequired and item.achievementRequired ~= ""
        isQuest = item.questRequired and item.questRequired ~= ""
        isDrop = item.dropSource and item.dropSource ~= ""
    end
    
    -- Get theme colors
    local theme = GetTheme()
    local colors = theme.Colors or {}

    -- LEFT EDGE: Split bar - TOP half = faction, BOTTOM half = source type
    local factionHorde = colors.factionHorde or DEFAULT_COLORS.factionHorde
    local factionAlliance = colors.factionAlliance or DEFAULT_COLORS.factionAlliance
    local factionNeutral = colors.factionNeutral or DEFAULT_COLORS.factionNeutral
    local sourceAchievement = colors.sourceAchievement or DEFAULT_COLORS.sourceAchievement
    local sourceQuest = colors.sourceQuest or DEFAULT_COLORS.sourceQuest
    local sourceDrop = colors.sourceDrop or DEFAULT_COLORS.sourceDrop
    local sourceVendor = colors.sourceVendor or DEFAULT_COLORS.sourceVendor

    -- TOP HALF (factionBar): Faction color, or source color if no faction
    if button.factionBar then
        if item.faction == "Horde" then
            button.factionBar:SetVertexColor(factionHorde[1], factionHorde[2], factionHorde[3], 1)
        elseif item.faction == "Alliance" then
            button.factionBar:SetVertexColor(factionAlliance[1], factionAlliance[2], factionAlliance[3], 1)
        elseif isAchievement then
            -- No faction, show source type in top half
            button.factionBar:SetVertexColor(sourceAchievement[1], sourceAchievement[2], sourceAchievement[3], 1)
        elseif isQuest then
            button.factionBar:SetVertexColor(sourceQuest[1], sourceQuest[2], sourceQuest[3], 1)
        elseif isDrop then
            button.factionBar:SetVertexColor(sourceDrop[1], sourceDrop[2], sourceDrop[3], 1)
        else
            button.factionBar:SetVertexColor(sourceVendor[1], sourceVendor[2], sourceVendor[3], 1)
        end
        button.factionBar:Show()
    end

    -- BOTTOM HALF (sourceBar): Source type color (always show if faction exists, otherwise matches top)
    if button.sourceBar then
        if item.faction == "Horde" or item.faction == "Alliance" then
            -- Faction exists, show source type in bottom half
            if isAchievement then
                button.sourceBar:SetVertexColor(sourceAchievement[1], sourceAchievement[2], sourceAchievement[3], 1)
            elseif isQuest then
                button.sourceBar:SetVertexColor(sourceQuest[1], sourceQuest[2], sourceQuest[3], 1)
            elseif isDrop then
                button.sourceBar:SetVertexColor(sourceDrop[1], sourceDrop[2], sourceDrop[3], 1)
            else
                button.sourceBar:SetVertexColor(sourceVendor[1], sourceVendor[2], sourceVendor[3], 1)
            end
        else
            -- No faction, match the top half to create unified bar
            if isAchievement then
                button.sourceBar:SetVertexColor(sourceAchievement[1], sourceAchievement[2], sourceAchievement[3], 1)
            elseif isQuest then
                button.sourceBar:SetVertexColor(sourceQuest[1], sourceQuest[2], sourceQuest[3], 1)
            elseif isDrop then
                button.sourceBar:SetVertexColor(sourceDrop[1], sourceDrop[2], sourceDrop[3], 1)
            else
                button.sourceBar:SetVertexColor(sourceVendor[1], sourceVendor[2], sourceVendor[3], 1)
            end
        end
        button.sourceBar:Show()
    end
    
    -- Update backdrop color (Midnight theme with faction tint)
    local bgTertiary = colors.bgTertiary or DEFAULT_COLORS.bgTertiary
    local backdropColor
    if item.faction == "Horde" then
        backdropColor = {0.22, 0.10, 0.14, 0.90} -- Subtle red-purple tint
    elseif item.faction == "Alliance" then
        backdropColor = {0.10, 0.14, 0.24, 0.90} -- Subtle blue-purple tint
    else
        backdropColor = {bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4]}
    end
    
    -- Store and apply
    button.originalBackdropColor = backdropColor
    SetBackdropColorSafe(button, backdropColor)
    
    -- Update item name with quality color (Midnight theme enhanced)
    local displayName = item.name or "Unknown"

    local quality = item._apiQuality
    if quality == nil and itemID and C_Item and C_Item.GetItemQualityByID then
        quality = C_Item.GetItemQualityByID(itemID)
        if quality ~= nil then
            item._apiQuality = quality
        end
    elseif quality == nil and itemID and GetItemInfo then
        local _, _, q = GetItemInfo(itemID)
        if q ~= nil then
            quality = q
            item._apiQuality = q
        end
    end

    local colorCode = GetQualityColorCode(quality)
    if colorCode and button.nameText then
        button.nameText:SetText(colorCode .. displayName .. "|r")
    elseif button.nameText then
        button.nameText:SetText(displayName)
    end

    if button.iconBorder then
        local r, g, b = GetQualityRGB(quality)
        local borderPrimary = colors.borderPrimary or {0.35, 0.30, 0.50, 0.8}
        if r and g and b then
            button.iconBorder:SetBackdropBorderColor(r, g, b, 1)
        else
            button.iconBorder:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
        end
    end

    if quality == nil and itemID then
        UpdateQualityAsync(button, item, itemID, buttonIndex)
    end
    
    -- Update zone text (new field)
    if button.zoneText then
        local zoneName = item._apiZone or item.zoneName or ""
        button.zoneText:SetText(zoneName)
    end

    -- Display owned quantity if available (from cached API data)
    if button.quantityText then
        local numStored = item._apiNumStored or 0
        local numPlaced = item._apiNumPlaced or 0
        local totalOwned = numStored + numPlaced

        if totalOwned > 0 then
            button.quantityText:SetText(totalOwned)
            button.quantityText:Show()
        else
            button.quantityText:Hide()
        end
    end
    
    -- Removed: Source type display (typeText field removed)
    
    --------------------------------------------------------
    -- GET QUALITY & COST FROM CATALOG API (async - may take time)
    --------------------------------------------------------
    
    if button.costText then
        local currentCost = button.costText:GetText()
        -- Only show a loading indicator if we don't already have a real cost.
        if not currentCost or currentCost == "" then
            button.costText:SetText("...")
            button.costText:Show()
        end
    end
    
    local itemID = tonumber(item.itemID)
    if button._hvItemID ~= itemID then
        CancelAsyncWork(button)
    end
    -- Reset per-item async state if this button is being reused for a different item.
    if button._hvItemID ~= itemID then
        button._hvCostDone = false
        button._hvVendorDone = false
        -- Only clear vendor text when the button is reused for a different item (prevents flicker on refresh).
        if button.vendorText then
            button.vendorText:SetText("")
            button.vendorText:Show()
        end
    end
    button._hvItemID = itemID

    -- Synchronous vendor fallback (stable): fill vendor immediately from hard data if possible.
    if button.vendorText then
        local currentVendor = button.vendorText:GetText()
        if (not currentVendor or currentVendor == "") then
            local vendorName = nil
            local Filters = _G.HousingFilters
            local filterVendor = Filters and Filters.currentFilters and Filters.currentFilters.vendor or nil
            if _G.HousingVendorHelper then
                vendorName = _G.HousingVendorHelper:GetVendorName(item, filterVendor)
            else
                vendorName = item.vendorName or item._apiVendor
            end
            if vendorName and vendorName ~= "" then
                button.vendorText:SetText(vendorName)
                button.vendorText:Show()
                button._hvVendorDone = true
            end
        end
    end

    -- Synchronous cost fallback (stable): prefer static cost/price so we don't flicker while APIs warm.
    if button.costText and not button._hvCostDone then
        local currentCost = button.costText:GetText()
        if not currentCost or currentCost == "" or currentCost == "..." then
            if item.cost and item.cost ~= "" then
                button.costText:SetText(ApplyStaticCostIcons(item.cost, item._staticCostComponents))
                button.costText:Show()
                button._hvCostDone = true
            elseif item.price and item.price > 0 then
                button.costText:SetText(string_format("%dg", item.price))
                button.costText:Show()
                button._hvCostDone = true
            end
        end
    end

    if itemID and HousingAPI then
        local maxAttempts = 4

        local function ApplyStaticFallbacks()
            if button.costText then
                local currentCost = button.costText:GetText()
                if (not currentCost or currentCost == "" or currentCost == "...") then
                    if item.cost and item.cost ~= "" then
                        button.costText:SetText(ApplyStaticCostIcons(item.cost, item._staticCostComponents))
                        button.costText:Show()
                        button._hvCostDone = true
                    elseif item.price and item.price > 0 then
                        button.costText:SetText(string_format("%dg", item.price))
                        button.costText:Show()
                        button._hvCostDone = true
                    elseif currentCost == "..." then
                        button.costText:Hide()
                    end
                end
            end

            if button.vendorText then
                local currentVendor = button.vendorText:GetText()
                if not currentVendor or currentVendor == "" then
                    local vendorName = nil
                    if _G.HousingVendorHelper then
                        local Filters = _G.HousingFilters
                        local filterVendor = Filters and Filters.currentFilters and Filters.currentFilters.vendor
                        vendorName = _G.HousingVendorHelper:GetVendorName(item, filterVendor)
                    else
                        vendorName = item.vendorName or item._apiVendor
                    end

                    if vendorName and vendorName ~= "" then
                        button.vendorText:SetText(vendorName)
                        button.vendorText:Show()
                        button._hvVendorDone = true
                    end
                end
            end
        end

        local function Tick()
            if not button:IsVisible() then return end
            if button._hvItemID ~= itemID then return end
            if button._hvCostDone and button._hvVendorDone then return end

            PopulateVendorAndCostOnce(button, item, itemID)
            ApplyStaticFallbacks()

            if button._hvCostDone and button._hvVendorDone then
                CancelHandle(button._hvVendorCostTicker)
                button._hvVendorCostTicker = nil
            end
        end

        if not (button._hvCostDone and button._hvVendorDone) then
            if NEW_TIMER then
                CancelHandle(button._hvVendorCostTimer)
                button._hvVendorCostTimer = NEW_TIMER(0.1, function()
                    Tick()
                    if not (button._hvCostDone and button._hvVendorDone) then
                        CancelHandle(button._hvVendorCostTicker)
                        if NEW_TICKER then
                            button._hvVendorCostTicker = NEW_TICKER(0.6, Tick, maxAttempts)
                        else
                            for _ = 1, maxAttempts do
                                C_Timer.After(0.6, Tick)
                            end
                        end
                    end
                end)
            else
                C_Timer.After(0.1, Tick)
            end
        end
    else
        -- No catalog API, try item.price directly
        -- Note: Static data stores price in GOLD, not copper
        if button.costText then
            if item.cost and item.cost ~= "" then
                button.costText:SetText(ApplyStaticCostIcons(item.cost, item._staticCostComponents))
                button.costText:Show()
            elseif item.price and item.price > 0 then
                button.costText:SetText(string_format("%dg", item.price))
                button.costText:Show()
            else
                button.costText:Hide()
            end
        end
    end
    
    -- Removed: Vendor/zone info display (tooltipInfoText field removed)
    -- Wishlist button removed - now in preview panel
    -- Map icon removed - now in preview panel

    -- Update icon - try to get from cache or load asynchronously
    if itemID and button.icon then
        UpdateIconAsync(button, item, itemID, buttonIndex)
    elseif button.icon then
        button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    end
    
    -- Removed: housing icon and weight (fields removed)
    
    -- Check if item is collected and show green tick
    -- If quantity > 0, item is collected (owned = collected)
    if button.collectedIcon then
        local isCollected = false
        
        -- First check: Do we have quantity data showing ownership?
        local numStored = item._apiNumStored or 0
        local numPlaced = item._apiNumPlaced or 0
        local totalOwned = numStored + numPlaced
        
        if totalOwned > 0 then
            isCollected = true
        else
            -- Fallback: Check via HousingCollectionAPI (for items without quantity data yet)
            if item.itemID and item.itemID ~= "" then
                local itemID = tonumber(item.itemID)
                if itemID and HousingCollectionAPI then
                    isCollected = HousingCollectionAPI:IsItemCollected(itemID)
                end
            end
        end
        
        if isCollected then
            button.collectedIcon:Show()
        else
            button.collectedIcon:Hide()
        end
    end
    
    -- Restore default click behavior for regular items (preview panel only)
    SetClickHandler(button, "regular", OnRegularItemButtonClick)
end
