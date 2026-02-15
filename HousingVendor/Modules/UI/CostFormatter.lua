-- CostFormatter.lua
-- Shared cost formatting helpers for both Full UI and Compact UI.

local ADDON_NAME, ns = ...

local CostFormatter = {}
CostFormatter.__index = CostFormatter

local _G = _G
local math_floor = math.floor
local string_find = string.find
local string_format = string.format
local string_gsub = string.gsub
local table_concat = table.concat
local table_insert = table.insert

local function ResetTable(t)
    if not t then return end
    for k in pairs(t) do
        t[k] = nil
    end
end

local PERSISTED_CATALOG_COST_TTL_SECONDS = 60 * 60 * 24 * 30 -- 30 days
local PERSISTED_CATALOG_COST_MAX_ENTRIES = 5000

local function GetPersistedCatalogCost(itemID)
    if not (HousingDB and HousingDB.catalogCostCache) then
        return nil
    end
    local entry = HousingDB.catalogCostCache[itemID]
    if type(entry) == "string" then
        return entry
    end
    if type(entry) == "table" then
        local cost = entry.cost
        local ts = tonumber(entry.timestamp) or 0
        if type(cost) == "string" and cost ~= "" then
            if ts <= 0 or (_G.GetTime and (_G.GetTime() - ts) <= PERSISTED_CATALOG_COST_TTL_SECONDS) then
                return cost
            end
        end
    end
    return nil
end

local function PersistCatalogCost(itemID, costText)
    local id = tonumber(itemID)
    if not id or id <= 0 then return end
    if type(costText) ~= "string" or costText == "" then return end
    if not HousingDB then HousingDB = {} end
    if not HousingDB.catalogCostCache then HousingDB.catalogCostCache = {} end

    -- Insert/update
    HousingDB.catalogCostCache[id] = { cost = costText, timestamp = (_G.GetTime and _G.GetTime() or 0) }

    -- Simple cap: when over limit, clear the whole table (keeps logic tiny and safe).
    local n = 0
    for _ in pairs(HousingDB.catalogCostCache) do
        n = n + 1
        if n > PERSISTED_CATALOG_COST_MAX_ENTRIES then
            HousingDB.catalogCostCache = {}
            break
        end
    end
end

function CostFormatter:GetPersistedCatalogCost(itemID)
    return GetPersistedCatalogCost(itemID)
end

function CostFormatter:PersistCatalogCost(itemID, costText)
    return PersistCatalogCost(itemID, costText)
end

function CostFormatter:FormatMoneyFromCopper(copper)
    local ppd = _G.HousingPreviewPanelData
    if ppd and ppd.Util and ppd.Util.FormatMoneyFromCopper then
        return ppd.Util.FormatMoneyFromCopper(copper)
    end
    if _G.GetCoinTextureString then
        return _G.GetCoinTextureString(tonumber(copper) or 0)
    end
    local amount = tonumber(copper) or 0
    local gold = math_floor(amount / 10000)
    local silver = math_floor((amount % 10000) / 100)
    local c = amount % 100
    return string_format("%dg %02ds %02dc", gold, silver, c)
end

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
    if _G.C_Item and _G.C_Item.GetItemIconByID then
        icon = _G.C_Item.GetItemIconByID(id)
    end
    if (not icon or icon == "") and _G.GetItemIcon then
        icon = _G.GetItemIcon(id)
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
        [1220] = 7382824, -- Order Resources
    }

    local cached = CURRENCY_ICON_MARKUP_CACHE[id]
    if cached ~= nil then
        return cached
    end

    local currencyInfo = nil
    if _G.HousingAPI and _G.HousingAPI.GetCurrencyInfo then
        currencyInfo = _G.HousingAPI:GetCurrencyInfo(id)
    elseif _G.C_CurrencyInfo and _G.C_CurrencyInfo.GetCurrencyInfo then
        local ok, info = pcall(_G.C_CurrencyInfo.GetCurrencyInfo, id)
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

function CostFormatter:ApplyStaticCostIcons(text, components)
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

    if type(components) == "table" and #components > 0 then
        for _, component in ipairs(components) do
            local itemID = component and component.itemID
            local currencyTypeID = component and component.currencyTypeID
            local amount = component and component.amount
            if itemID and amount then
                local icon = GetItemIconMarkup(itemID)
                if icon and icon ~= "" then
                    local name = tostring(component.name or "")
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
                    local name = tostring(component.name or "")
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
    end

    COST_ICON_CACHE[cacheKey] = text
    COST_ICON_CACHE_COUNT = COST_ICON_CACHE_COUNT + 1
    if COST_ICON_CACHE_COUNT > MAX_COST_ICON_CACHE then
        ResetTable(COST_ICON_CACHE)
        COST_ICON_CACHE_COUNT = 0
    end

    return text
end

function CostFormatter:FormatCostFromVendorInfo(vendorInfo)
    if not vendorInfo or not vendorInfo.cost or #vendorInfo.cost == 0 then
        return nil
    end

    local parts = {}
    for _, costEntry in ipairs(vendorInfo.cost) do
        if costEntry then
            if costEntry.currencyID == 0 then
                local copperAmount = tonumber(costEntry.amount) or 0
                if _G.GetCoinTextureString then
                    table_insert(parts, _G.GetCoinTextureString(copperAmount))
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
                    local currencyInfo = _G.HousingAPI and _G.HousingAPI.GetCurrencyInfo and _G.HousingAPI:GetCurrencyInfo(costEntry.currencyID)
                    if currencyInfo and currencyInfo.name then
                        currencyName = currencyInfo.name
                    elseif _G.HousingCurrencyTypes and _G.HousingCurrencyTypes[costEntry.currencyID] then
                        currencyName = _G.HousingCurrencyTypes[costEntry.currencyID]
                    end
                    table_insert(parts, tostring(amount) .. " " .. currencyName)
                end
            end
        end
    end

    if #parts == 0 then return nil end
    return table_concat(parts, " + ")
end

-- Get detailed cost breakdown with names for tooltip display
-- Returns: { { display = "10 [icon]", name = "Spare Parts", amount = 10, type = "item" }, ... }
function CostFormatter:GetCostBreakdown(item, itemID)
    local id = tonumber(itemID) or (item and tonumber(item.itemID)) or nil
    if not id then return nil end

    local breakdown = {}

    -- Check HousingCostData for goldCost/currencies/itemCosts from vendor data
    local costData = _G.HousingCostData and _G.HousingCostData[id]
    if costData then
        -- Gold cost (stored in copper)
        if costData.buyPriceCopper and costData.buyPriceCopper > 0 then
            local copperAmount = costData.buyPriceCopper
            local displayText
            if _G.GetCoinTextureString then
                displayText = _G.GetCoinTextureString(copperAmount)
            else
                local gold = math_floor(copperAmount / 10000)
                local silver = math_floor((copperAmount % 10000) / 100)
                local copper = copperAmount % 100
                if gold > 0 then
                    displayText = string_format("%dg", gold)
                    if silver > 0 then displayText = displayText .. " " .. silver .. "s" end
                elseif silver > 0 then
                    displayText = string_format("%ds", silver)
                else
                    displayText = string_format("%dc", copper)
                end
            end
            table_insert(breakdown, {
                display = displayText,
                name = "Gold",
                amount = math_floor(copperAmount / 10000),
                type = "gold",
            })
        end

        -- Currency and item costs from costComponents
        if costData.costComponents and #costData.costComponents > 0 then
            for _, comp in ipairs(costData.costComponents) do
                if comp.currencyTypeID and comp.amount then
                    local icon = GetCurrencyIconMarkup(comp.currencyTypeID)
                    local currencyName = "Currency #" .. tostring(comp.currencyTypeID)
                    local currencyInfo = _G.HousingAPI and _G.HousingAPI.GetCurrencyInfo and _G.HousingAPI:GetCurrencyInfo(comp.currencyTypeID)
                    if currencyInfo and currencyInfo.name then
                        currencyName = currencyInfo.name
                    elseif _G.C_CurrencyInfo and _G.C_CurrencyInfo.GetCurrencyInfo then
                        local ok, info = pcall(_G.C_CurrencyInfo.GetCurrencyInfo, comp.currencyTypeID)
                        if ok and info and info.name then
                            currencyName = info.name
                        end
                    elseif _G.HousingCurrencyTypes and _G.HousingCurrencyTypes[comp.currencyTypeID] then
                        currencyName = _G.HousingCurrencyTypes[comp.currencyTypeID]
                    end
                    local displayText = icon and (tostring(comp.amount) .. " " .. icon) or (tostring(comp.amount) .. " " .. currencyName)
                    table_insert(breakdown, {
                        display = displayText,
                        name = currencyName,
                        amount = comp.amount,
                        type = "currency",
                        currencyID = comp.currencyTypeID,
                    })
                elseif comp.itemID and comp.amount then
                    local icon = GetItemIconMarkup(comp.itemID)
                    local itemName = "Item #" .. tostring(comp.itemID)
                    -- Try to get item name from WoW API
                    if _G.C_Item and _G.C_Item.GetItemInfo then
                        local ok, info = pcall(_G.C_Item.GetItemInfo, comp.itemID)
                        if ok and info then
                            itemName = info
                        end
                    end
                    if itemName == "Item #" .. tostring(comp.itemID) and _G.GetItemInfo then
                        local ok, name = pcall(_G.GetItemInfo, comp.itemID)
                        if ok and name and name ~= "" then
                            itemName = name
                        end
                    end
                    local displayText = icon and (tostring(comp.amount) .. " " .. icon) or (tostring(comp.amount) .. "x " .. itemName)
                    table_insert(breakdown, {
                        display = displayText,
                        name = itemName,
                        amount = comp.amount,
                        type = "item",
                        itemID = comp.itemID,
                    })
                end
            end
        end
    end

    return #breakdown > 0 and breakdown or nil
end

function CostFormatter:GetBestCostText(item, itemID)
    local id = tonumber(itemID) or (item and tonumber(item.itemID)) or nil
    if not id then return nil end

    if item and item.cost and item.cost ~= "" then
        return self:ApplyStaticCostIcons(item.cost, item._staticCostComponents)
    end

    -- NEW FORMAT: Check HousingCostData for goldCost/currencies/itemCosts from vendor data
    do
        local costData = _G.HousingCostData and _G.HousingCostData[id]
        if costData then
            local parts = {}

            -- Gold cost (stored in copper)
            if costData.buyPriceCopper and costData.buyPriceCopper > 0 then
                if _G.GetCoinTextureString then
                    table_insert(parts, _G.GetCoinTextureString(costData.buyPriceCopper))
                else
                    local gold = math_floor(costData.buyPriceCopper / 10000)
                    local silver = math_floor((costData.buyPriceCopper % 10000) / 100)
                    local copper = costData.buyPriceCopper % 100
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
            end

            -- Currency and item costs from costComponents
            if costData.costComponents and #costData.costComponents > 0 then
                for _, comp in ipairs(costData.costComponents) do
                    if comp.currencyTypeID and comp.amount then
                        local icon = GetCurrencyIconMarkup(comp.currencyTypeID)
                        if icon and icon ~= "" then
                            table_insert(parts, tostring(comp.amount) .. " " .. icon)
                        else
                            local currencyName = "Currency #" .. tostring(comp.currencyTypeID)
                            local currencyInfo = _G.HousingAPI and _G.HousingAPI.GetCurrencyInfo and _G.HousingAPI:GetCurrencyInfo(comp.currencyTypeID)
                            if currencyInfo and currencyInfo.name then
                                currencyName = currencyInfo.name
                            elseif _G.HousingCurrencyTypes and _G.HousingCurrencyTypes[comp.currencyTypeID] then
                                currencyName = _G.HousingCurrencyTypes[comp.currencyTypeID]
                            end
                            table_insert(parts, tostring(comp.amount) .. " " .. currencyName)
                        end
                    elseif comp.itemID and comp.amount then
                        local icon = GetItemIconMarkup(comp.itemID)
                        if icon and icon ~= "" then
                            table_insert(parts, tostring(comp.amount) .. " " .. icon)
                        else
                            table_insert(parts, tostring(comp.amount) .. "x Item #" .. tostring(comp.itemID))
                        end
                    end
                end
            end

            if #parts > 0 then
                return table_concat(parts, " + ")
            end
        end
    end

    -- Persisted catalog costs (saved variables): lets Compact UI show costs immediately on login
    -- even before housing catalog APIs become safe to call.
    do
        local persisted = GetPersistedCatalogCost(id)
        if persisted and persisted ~= "" then
            return self:ApplyStaticCostIcons(persisted, item and item._staticCostComponents)
        end
    end

    -- Match Full UI behavior: prefer catalog cost data when available (cached, and gated by HousingCatalogSafeToCall).
    do
        local catalogData = nil
        if _G.HousingAPICache and _G.HousingAPICache.GetCatalogData then
            catalogData = _G.HousingAPICache:GetCatalogData(id)
        elseif _G.HousingAPI and _G.HousingAPI.GetCatalogData then
            catalogData = _G.HousingAPI:GetCatalogData(id)
        end
        if catalogData and catalogData.cost and catalogData.cost ~= "" then
            PersistCatalogCost(id, catalogData.cost)
            return self:ApplyStaticCostIcons(catalogData.cost, item and item._staticCostComponents)
        end
    end

    if item and tonumber(item.buyPriceCopper) and tonumber(item.buyPriceCopper) > 0 then
        return self:FormatMoneyFromCopper(item.buyPriceCopper)
    end

    if item and item._apiVendorCost and tonumber(item._apiVendorCost) then
        return self:FormatMoneyFromCopper(item._apiVendorCost)
    end

    if item and item.price and tonumber(item.price) then
        return string_format("%dg", tonumber(item.price))
    end

    local baseInfo = nil
    if _G.HousingAPI and _G.HousingAPI.GetDecorItemInfoFromItemID then
        baseInfo = _G.HousingAPI:GetDecorItemInfoFromItemID(id)
    end

    -- Fallback: some records don't have `item.cost` populated yet, but the Housing catalog does.
    -- This is what the Full UI uses, and Compact UI should match.
    if baseInfo and baseInfo.cost and baseInfo.cost ~= "" then
        return self:ApplyStaticCostIcons(baseInfo.cost, item and item._staticCostComponents)
    end

    if _G.HousingDataEnrichment and _G.HousingDataEnrichment.GetVendorInfo then
        local enrichedVendors = _G.HousingDataEnrichment:GetVendorInfo(id)
        if enrichedVendors and #enrichedVendors > 0 then
            local vendor = enrichedVendors[1]
            if vendor and vendor.price and vendor.currency and vendor.price > 0 then
                return (vendor.currency == "Gold")
                    and string_format("%dg", vendor.price)
                    or string_format("%d %s", vendor.price, vendor.currency)
            end
        end
    end

    if baseInfo and baseInfo.decorID then
        local vendorInfo = nil
        if _G.HousingAPICache and _G.HousingAPICache.GetVendorInfo then
            vendorInfo = _G.HousingAPICache:GetVendorInfo(baseInfo.decorID)
        elseif _G.HousingAPI and _G.HousingAPI.GetDecorVendorInfo then
            vendorInfo = _G.HousingAPI:GetDecorVendorInfo(baseInfo.decorID)
        end
        local formatted = self:FormatCostFromVendorInfo(vendorInfo)
        if formatted and formatted ~= "" then
            return formatted
        end
    end

    -- Fallback: if the item record already has a decorID, use it directly (avoids depending on item->decor lookup).
    local decorID = item and tonumber(item.decorID) or nil
    if decorID and decorID > 0 then
        local vendorInfo = nil
        if _G.HousingAPICache and _G.HousingAPICache.GetVendorInfo then
            vendorInfo = _G.HousingAPICache:GetVendorInfo(decorID)
        elseif _G.HousingAPI and _G.HousingAPI.GetDecorVendorInfo then
            vendorInfo = _G.HousingAPI:GetDecorVendorInfo(decorID)
        end
        local formatted = self:FormatCostFromVendorInfo(vendorInfo)
        if formatted and formatted ~= "" then
            return formatted
        end
    end

    return nil
end

ns.CostFormatter = setmetatable({}, CostFormatter)
_G.HousingCostFormatter = ns.CostFormatter

return ns.CostFormatter
