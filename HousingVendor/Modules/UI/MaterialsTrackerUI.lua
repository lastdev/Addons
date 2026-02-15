-- MaterialsTrackerUI.lua
-- Small standalone UI to track crafting materials for HousingVendor decor.

local ADDON_NAME, ns = ...
local L = ns.L

local MaterialsTrackerUI = {}
MaterialsTrackerUI.__index = MaterialsTrackerUI

MaterialsTrackerUI._materialsContainer = MaterialsTrackerUI._materialsContainer or nil
MaterialsTrackerUI._parentFrame = MaterialsTrackerUI._parentFrame or nil

local trackerFrame = nil
local scrollFrame = nil
local contentFrame = nil

local currentMode = "wishlist" -- "wishlist" | "item" | "raw"
local currentItemID = nil
local showCompleted = false -- UI toggle removed; keep false to avoid huge lists

local refreshQueued = false
local buildToken = 0

local HousingTheme = _G.HousingTheme

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

local modelViewerWasVisible = false

local function SetMainUIVisible(visible)
    -- Only hide/show item list - keep filters and nav buttons visible
    if _G["HousingItemListScrollFrame"] then
        _G["HousingItemListScrollFrame"]:SetShown(visible)
    end
    if _G["HousingItemListContainer"] then
        _G["HousingItemListContainer"]:SetShown(visible)
    end
    if _G["HousingItemListHeader"] then
        _G["HousingItemListHeader"]:SetShown(visible)
    end
    -- Keep filters visible
    -- Keep nav buttons visible
    -- Keep preview panel visible
end

local function GetThemeColors()
    if HousingTheme and HousingTheme.Colors then
        return HousingTheme.Colors
    end
    local theme = _G.HousingTheme or {}
    local colors = theme.Colors or {}
    return colors
end

local function ApplyRowTheme(row)
    if not row then
        return
    end

    local colors = GetThemeColors()
    local bgHover = colors.bgHover or { 0.22, 0.16, 0.32, 0.95 }
    local borderPrimary = colors.borderPrimary or { 0.35, 0.30, 0.50, 0.8 }
    local accent = colors.accentGold or colors.accentPrimary or borderPrimary
    local textPrimary = colors.textPrimary or { 0.92, 0.90, 0.96, 1.0 }
    local textSecondary = colors.textSecondary or { 0.70, 0.68, 0.78, 1.0 }
    local textHighlight = colors.textHighlight or textPrimary

    if row.highlight then
        row.highlight:SetVertexColor(bgHover[1], bgHover[2], bgHover[3], 0.25)
    end
    if row.iconBorder and row.iconBorder.SetBackdropBorderColor then
        local b = row._wishlisted and accent or borderPrimary
        row.iconBorder:SetBackdropBorderColor(b[1], b[2], b[3], 0.85)
    end
    if row.iconBorder and row.iconBorder.SetBackdropColor then
        row.iconBorder:SetBackdropColor(0, 0, 0, row._wishlisted and 0.45 or 0.25)
    end
    if row.icon and row.icon.SetDesaturated then
        row.icon:SetDesaturated(false)
    end
    if row.iconCount then
        row.iconCount:SetTextColor(textHighlight[1], textHighlight[2], textHighlight[3], 1)
    end
    if row.name then
        row.name:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    end
    if row.topRight then
        row.topRight:SetTextColor(textHighlight[1], textHighlight[2], textHighlight[3], 1)
    end
    if row.bottomLeft then
        row.bottomLeft:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    end
    if row.bottomRight then
        row.bottomRight:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    end
end

-- Forward declarations (some helpers are used before definition below)
local CollectRawMatIDs

local function GetPositionStore()
    if not _G.HousingDB then
        _G.HousingDB = {}
    end
    if not _G.HousingDB.materialsTrackerPosition then
        _G.HousingDB.materialsTrackerPosition = {}
    end
    return _G.HousingDB.materialsTrackerPosition
end

local function GetCharCacheRoot()
    if not _G.HousingDB then
        _G.HousingDB = {}
    end
    if type(_G.HousingDB.materialsTrackerCharCounts) ~= "table" then
        _G.HousingDB.materialsTrackerCharCounts = {}
    end
    return _G.HousingDB.materialsTrackerCharCounts
end

local function GetRealmKey()
    if _G.GetNormalizedRealmName then
        local ok, name = pcall(_G.GetNormalizedRealmName)
        if ok and name and name ~= "" then
            return name
        end
    end
    if _G.GetRealmName then
        local ok, name = pcall(_G.GetRealmName)
        if ok and name and name ~= "" then
            return name
        end
    end
    return "UnknownRealm"
end

local function GetCurrentCharKey()
    local name = (_G.UnitName and _G.UnitName("player")) or nil
    if name and name ~= "" then
        return name
    end
    return "UnknownCharacter"
end

local function UpsertCurrentCharCount(itemID, bagCount)
    local id = tonumber(itemID)
    if not id then
        return
    end

    local root = GetCharCacheRoot()
    local realmKey = GetRealmKey()
    local charKey = GetCurrentCharKey()

    root[realmKey] = root[realmKey] or {}
    root[realmKey][charKey] = root[realmKey][charKey] or { items = {}, lastSeen = 0 }

    local record = root[realmKey][charKey]
    bagCount = tonumber(bagCount) or 0
    if bagCount > 0 then
        record.items[id] = bagCount
    else
        record.items[id] = nil
    end
    record.lastSeen = _G.time and _G.time() or 0
end

local function GetAltCounts(itemID)
    local id = tonumber(itemID)
    if not id then
        return 0, {}
    end

    local root = GetCharCacheRoot()
    local currentChar = GetCurrentCharKey()

    local sum = 0
    local breakdown = {}
    for realmName, realm in pairs(root) do
        if type(realm) == "table" then
            for charName, data in pairs(realm) do
                if charName ~= currentChar and type(data) == "table" and type(data.items) == "table" then
                    local c = tonumber(data.items[id]) or 0
                    if c > 0 then
                        sum = sum + c
                        breakdown[#breakdown + 1] = { name = charName, realm = realmName, count = c }
                    end
                end
            end
        end
    end

    table.sort(breakdown, function(a, b)
        if a.count ~= b.count then
            return a.count > b.count
        end
        local an = tostring(a.name) .. "-" .. tostring(a.realm or "")
        local bn = tostring(b.name) .. "-" .. tostring(b.realm or "")
        return an < bn
    end)

    return sum, breakdown
end

local function GetMaterialsWishlistStore()
    if not _G.HousingDB then
        _G.HousingDB = {}
    end
    if type(_G.HousingDB.materialsTrackerWishlist) ~= "table" then
        _G.HousingDB.materialsTrackerWishlist = {}
    end
    return _G.HousingDB.materialsTrackerWishlist
end

local function SafeItemName(itemID)
    local id = tonumber(itemID)
    if not id then
        return nil
    end

    if _G.C_Item and _G.C_Item.RequestLoadItemDataByID then
        pcall(_G.C_Item.RequestLoadItemDataByID, id)
    end

    if _G.C_Item and _G.C_Item.GetItemNameByID then
        local ok, name = pcall(_G.C_Item.GetItemNameByID, id)
        if ok and name then
            return name
        end
    end

    if _G.C_Item and _G.C_Item.GetItemInfo then
        local ok, itemName = pcall(_G.C_Item.GetItemInfo, id)
        if ok and itemName then
            return itemName
        end
    end

    return nil
end

local function SafeItemIcon(itemID)
    local id = tonumber(itemID)
    if not id then
        return nil
    end
    if _G.C_Item and _G.C_Item.GetItemIconByID then
        local ok, icon = pcall(_G.C_Item.GetItemIconByID, id)
        if ok and icon then
            return icon
        end
    end
    return nil
end

local function GetCounts(itemID)
    local counts = ns.ItemCounts or _G.HousingItemCounts
    if not (counts and counts.GetCounts) then
        return 0, 0, 0
    end
    return counts:GetCounts(itemID, {
        includeReagentBag = true,
        includeWarbandBank = true,
    })
end

local function CacheCurrentCharSnapshot()
    local counts = ns.ItemCounts or _G.HousingItemCounts
    if not (counts and counts.GetCounts) then
        return
    end

    local ids = CollectRawMatIDs()
    if type(ids) ~= "table" or #ids == 0 then
        return
    end

    if counts.GetBagSnapshot then
        local normal, reagent = counts:GetBagSnapshot()

        -- Time-slice large loops to avoid "script ran too long" (can happen during combat-heavy sessions).
        if _G.C_Timer and _G.C_Timer.After and #ids > 250 then
            local index = 1
            local function Step()
                local endIndex = math.min(index + 249, #ids)
                for i = index, endIndex do
                    local id = ids[i]
                    local bagCount = ((normal and normal[id]) or 0) + ((reagent and reagent[id]) or 0)
                    UpsertCurrentCharCount(id, bagCount)
                end
                index = endIndex + 1
                if index <= #ids then
                    _G.C_Timer.After(0, Step)
                end
            end
            Step()
            return
        end

        for _, id in ipairs(ids) do
            local bagCount = ((normal and normal[id]) or 0) + ((reagent and reagent[id]) or 0)
            UpsertCurrentCharCount(id, bagCount)
        end
        return
    end

    for _, id in ipairs(ids) do
        local bagCount = 0
        local b = counts:GetCounts(id, { includeReagentBag = true, includeWarbandBank = false })
        bagCount = tonumber(b) or 0
        UpsertCurrentCharCount(id, bagCount)
    end
end

-- Background per-character cache so alt counts show up after you log into alts.
local cacheFrame = CreateFrame("Frame")
cacheFrame:RegisterEvent("PLAYER_LOGIN")
cacheFrame:RegisterEvent("BAG_UPDATE_DELAYED")
cacheFrame:SetScript("OnEvent", function(_, eventName)
    if _G.InCombatLockdown and _G.InCombatLockdown() then
        cacheFrame._combatPending = true
        cacheFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
        return
    end

    if cacheFrame._combatPending then
        cacheFrame._combatPending = false
        cacheFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
    end

    local counts = ns.ItemCounts or _G.HousingItemCounts
    if counts and counts.InvalidateBagCache then
        counts:InvalidateBagCache()
    end
    -- Account/warband cache should not be invalidated on every bag update; it forces expensive
    -- GetItemCount calls that can contribute to "script ran too long" in busy sessions.
    if eventName == "PLAYER_LOGIN" and counts and counts.InvalidateAccountCache then
        counts:InvalidateAccountCache()
    end

    if not (_G.C_Timer and _G.C_Timer.After) then
        CacheCurrentCharSnapshot()
        return
    end
    if cacheFrame._pending then
        return
    end
    cacheFrame._pending = true
    _G.C_Timer.After(0.6, function()
        cacheFrame._pending = false
        CacheCurrentCharSnapshot()
    end)
end)

local function GetCachedAHUnitPrice(itemID)
    local api = _G.HousingAuctionHouseAPI
    if not api then
        return nil
    end
    if api.GetOrFetchAddonPrice then
        local price = select(1, api:GetOrFetchAddonPrice(itemID))
        price = tonumber(price)
        if price and price > 0 then
            return price
        end
    end
    if api.GetCachedPrice then
        local price = api:GetCachedPrice(itemID)
        price = tonumber(price)
        if price and price > 0 then
            return price
        end
    end
    return nil
end

local function BuildReagentTotalsForDecorItem(decorItemID, totals)
    totals = totals or {}
    local itemID = tonumber(decorItemID)
    if not itemID then
        return totals
    end

    local pr = ns.ProfessionReagents
    if not (pr and pr.GetReagents) then
        return totals
    end

    local data = pr:GetReagents(itemID)
    if not (data and type(data.reagents) == "table") then
        return totals
    end

    for _, reagent in ipairs(data.reagents) do
        local rid = reagent and tonumber(reagent.id)
        local amt = reagent and tonumber(reagent.amount)
        if rid and amt and amt > 0 then
            totals[rid] = (totals[rid] or 0) + amt
        end
    end

    return totals
end

local function BuildTotals()
    local totals = {}

    if currentItemID then
        BuildReagentTotalsForDecorItem(currentItemID, totals)
        return totals
    end

    return totals
end

local function BuildNeededRows(totals)
    local rows = {}
    for reagentID, needed in pairs(totals) do
        local bagCount, warbandCount, totalHave = GetCounts(reagentID)
        local remaining = needed - totalHave
        if showCompleted or remaining > 0 then
            rows[#rows + 1] = {
                mode = "needed",
                itemID = reagentID,
                needed = needed,
                have = totalHave,
                bag = bagCount,
                warband = warbandCount,
                remaining = remaining,
                name = SafeItemName(reagentID) or ("Item " .. tostring(reagentID)),
                icon = SafeItemIcon(reagentID),
            }
        end
    end

    table.sort(rows, function(a, b)
        if a.remaining ~= b.remaining then
            return a.remaining > b.remaining
        end
        return tostring(a.name) < tostring(b.name)
    end)

    return rows
end

local professionMatLookup = nil
local function EnsureProfessionMatLookup()
    if professionMatLookup then
        return professionMatLookup
    end

    professionMatLookup = {}
    local pr = ns.ProfessionReagents
    if pr and pr.LoadProfessionsData then
        local data = pr:LoadProfessionsData()
        for _, info in pairs(data or {}) do
            if type(info.reagents) == "table" then
                for _, reagent in ipairs(info.reagents) do
                    if reagent and reagent.id then
                        professionMatLookup[tonumber(reagent.id)] = true
                    end
                end
            end
        end
    end
    return professionMatLookup
end

CollectRawMatIDs = function()
    local raw = _G.HousingRawMats
    local ids = {}
    if type(raw) ~= "table" then
        return ids
    end

    local seen = {}
    local groups = {
        raw.LUMBER_ITEMS,
        raw.HERB_ITEMS,
        raw.ORE_ITEMS,
        raw.LEATHER_ITEMS,
        raw.FISH_ITEMS,
    }

    local professionOnlyTable = EnsureProfessionMatLookup()

    local function InsertID(itemID)
        local id = tonumber(itemID)
        if not id then
            return
        end
        if professionOnlyTable and not professionOnlyTable[id] then
            return
        end
        if not seen[id] then
            seen[id] = true
            ids[#ids + 1] = id
        end
    end

    for _, expansion in ipairs(groups) do
        if type(expansion) == "table" then
            for _, items in pairs(expansion) do
                if type(items) == "table" then
                    for _, itemID in ipairs(items) do
                        InsertID(itemID)
                    end
                end
            end
        end
    end

    -- Flat list of misc crafting materials (non-gathered intermediates, vendor mats, etc).
    if type(raw.MISC_CRAFTING_MATERIALS) == "table" then
        for _, itemID in ipairs(raw.MISC_CRAFTING_MATERIALS) do
            InsertID(itemID)
        end
    end

    table.sort(ids)
    return ids
end

local function StartRawMatAHScan()
    local api = _G.HousingAuctionHouseAPI
    if not api then
        print("|cFFFF4040HousingVendor:|r AuctionHouseAPI module missing")
        return
    end

    api:Initialize()
    local hasAddonSource = api.HasAddonPriceSource and api:HasAddonPriceSource()
    local ahOpen = api.IsAuctionHouseOpen and api:IsAuctionHouseOpen()
    if not ahOpen and not hasAddonSource then
        print("|cFFFF4040HousingVendor:|r Open the Auction House (or install Auctionator/TSM) before scanning materials.")
        return
    end

    local rawIDs = CollectRawMatIDs()
    if #rawIDs == 0 then
        print("|cFFFF4040HousingVendor:|r No raw materials found to scan.")
        return
    end

    -- If we're in addon-pricing mode, but the user has no price source installed,
    -- QueueScan will immediately stop. Make that explicit.
    if not hasAddonSource and not ahOpen then
        print("|cFFFF4040HousingVendor:|r No price source available. Install Auctionator/TSM or open the Auction House.")
        return
    end

    api:QueueScan(rawIDs, true)
    print("|cFF8A7FD4HousingVendor:|r Scanning AH prices for raw materials (" .. tostring(#rawIDs) .. " items).")
end

local AH_LISTENER_KEY = "HousingMaterialsTrackerUI"
local function RegisterAHListener()
    local api = _G.HousingAuctionHouseAPI
    if not (api and api.RegisterListener) then
        return false
    end

    api:UnregisterListener(AH_LISTENER_KEY)
    api:RegisterListener(AH_LISTENER_KEY, function(event)
        if event == "price_updated" or event == "scan_complete" or event == "scan_stopped" then
            if MaterialsTrackerUI and MaterialsTrackerUI.RefreshSoon then
                MaterialsTrackerUI:RefreshSoon()
            end
        end
    end)
    return true
end

local function UnregisterAHListener()
    local api = _G.HousingAuctionHouseAPI
    if api and api.UnregisterListener then
        api:UnregisterListener(AH_LISTENER_KEY)
    end
end

local function BuildRawMatsRows()
    local rows = {}
    local raw = _G.HousingRawMats
    if type(raw) ~= "table" then
        return rows
    end

    local professionOnly = EnsureProfessionMatLookup()
    local variantsMap = raw.ITEM_VARIANTS
    local overrides = raw.ITEM_NAME_OVERRIDES or {}
    local categories = raw.CATEGORIES or {}

    local function Push(i, kind, itemID)
        local id = tonumber(itemID)
        if not id then
            return
        end

        if professionOnly and not professionOnly[id] then
            return
        end

        local counts = ns.ItemCounts or _G.HousingItemCounts
        local bagCount, warbandCount, totalHave = 0, 0, 0
        if counts and counts.GetCountsWithVariants then
            bagCount, warbandCount, totalHave = counts:GetCountsWithVariants(id, variantsMap, {
                includeReagentBag = true,
                includeWarbandBank = true,
            })
        else
            bagCount, warbandCount, totalHave = GetCounts(id)
        end

        -- In raw mode, the toggle acts like "show zeros".
        if (not showCompleted) and totalHave <= 0 then
            return
        end

        local displayName = overrides[id] or SafeItemName(id) or ("Item " .. tostring(id))
        local expansionName = nil
        if i == 999 then
            expansionName = "Misc"
        else
            expansionName = (categories[i] and categories[i].name) or ("Expansion " .. tostring(i))
        end
        rows[#rows + 1] = {
            mode = "raw",
            itemID = id,
            have = totalHave,
            bag = bagCount,
            warband = warbandCount,
            name = displayName,
            icon = SafeItemIcon(id),
            expansionIndex = i,
            expansionName = expansionName,
            kind = kind,
        }
    end

    local function AddGroup(kind, tableByExpansion)
        if type(tableByExpansion) ~= "table" then
            return
        end
        for i, ids in pairs(tableByExpansion) do
            if type(ids) == "table" then
                for _, id in ipairs(ids) do
                    Push(i, kind, id)
                end
            end
        end
    end

    AddGroup("Lumber", raw.LUMBER_ITEMS)
    AddGroup("Herbs", raw.HERB_ITEMS)
    AddGroup("Ores", raw.ORE_ITEMS)
    AddGroup("Leather", raw.LEATHER_ITEMS)
    AddGroup("Fish", raw.FISH_ITEMS)

    if type(raw.MISC_CRAFTING_MATERIALS) == "table" then
        for _, id in ipairs(raw.MISC_CRAFTING_MATERIALS) do
            Push(999, "Misc", id)
        end
    end

    table.sort(rows, function(a, b)
        if (a.expansionIndex or 0) ~= (b.expansionIndex or 0) then
            return (a.expansionIndex or 0) < (b.expansionIndex or 0)
        end
        if tostring(a.kind) ~= tostring(b.kind) then
            return tostring(a.kind) < tostring(b.kind)
        end
        return tostring(a.name) < tostring(b.name)
    end)

    return rows
end

local function BuildMaterialsWishlistRows()
    local rows = {}
    local wishlist = GetMaterialsWishlistStore()
    if type(wishlist) ~= "table" then
        return rows
    end

    local raw = _G.HousingRawMats
    local variantsMap = type(raw) == "table" and raw.ITEM_VARIANTS or nil
    local overrides = type(raw) == "table" and (raw.ITEM_NAME_OVERRIDES or {}) or {}

    local counts = ns.ItemCounts or _G.HousingItemCounts

    for itemID, enabled in pairs(wishlist) do
        if enabled then
            local id = tonumber(itemID)
            if id then
                local bagCount, warbandCount, totalHave = 0, 0, 0
                if counts and counts.GetCountsWithVariants and variantsMap then
                    bagCount, warbandCount, totalHave = counts:GetCountsWithVariants(id, variantsMap, {
                        includeReagentBag = true,
                        includeWarbandBank = true,
                    })
                else
                    bagCount, warbandCount, totalHave = GetCounts(id)
                end

                local displayName = overrides[id] or SafeItemName(id) or ("Item " .. tostring(id))
                rows[#rows + 1] = {
                    mode = "raw",
                    itemID = id,
                    have = totalHave,
                    bag = bagCount,
                    warband = warbandCount,
                    name = displayName,
                    icon = SafeItemIcon(id),
                    kind = "Wishlist",
                }
            end
        end
    end

    table.sort(rows, function(a, b)
        return tostring(a.name) < tostring(b.name)
    end)

    return rows
end

local ROW_ICON_SIZE = 32
local ROW_PADDING = 14
local ROW_SPACING = 8
local ROW_HEIGHT = 52

local function FormatMoneyFromCopper(copper)
    local ppd = _G.HousingPreviewPanelData
    if ppd and ppd.Util and ppd.Util.FormatMoneyFromCopper then
        return ppd.Util.FormatMoneyFromCopper(copper)
    end
    if _G.GetCoinTextureString then
        return _G.GetCoinTextureString(tonumber(copper) or 0)
    end
    return tostring(tonumber(copper) or 0)
end

local function CreateRow(parent)
    local row = CreateFrame("Button", nil, parent)
    row:SetHeight(ROW_HEIGHT)
    row:RegisterForClicks("LeftButtonUp", "RightButtonUp")

    local colors = GetThemeColors()
    local bgHover = colors.bgHover or { 0.22, 0.16, 0.32, 0.95 }
    local borderPrimary = colors.borderPrimary or { 0.35, 0.30, 0.50, 0.8 }

    row.highlight = row:CreateTexture(nil, "BACKGROUND")
    row.highlight:SetAllPoints()
    row.highlight:SetTexture("Interface\\Buttons\\WHITE8x8")
    row.highlight:SetVertexColor(bgHover[1], bgHover[2], bgHover[3], 0.25)
    row.highlight:Hide()

    row.iconBorder = CreateFrame("Frame", nil, row, "BackdropTemplate")
    row.iconBorder:SetSize(ROW_ICON_SIZE + 6, ROW_ICON_SIZE + 6)
    row.iconBorder:SetPoint("LEFT", ROW_PADDING, 0)
    row.iconBorder:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 },
    })
    row.iconBorder:SetBackdropColor(0, 0, 0, 0.25)
    row.iconBorder:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.85)

    row.icon = row:CreateTexture(nil, "ARTWORK")
    row.icon:SetSize(ROW_ICON_SIZE, ROW_ICON_SIZE)
    row.icon:SetPoint("CENTER", row.iconBorder, "CENTER", 0, 0)
    row.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")

    row.iconButton = CreateFrame("Button", nil, row)
    row.iconButton:SetAllPoints(row.iconBorder)
    row.iconButton:RegisterForClicks("LeftButtonUp")
    row.iconButton:SetScript("OnClick", function()
        local id = row._itemID and tonumber(row._itemID) or nil
        if not id then
            return
        end
        local wishlist = GetMaterialsWishlistStore()
        wishlist[id] = not (wishlist[id] == true)
        row._wishlisted = wishlist[id] == true
        if row.UpdateTheme then
            row:UpdateTheme()
        end
        if MaterialsTrackerUI and MaterialsTrackerUI.RefreshSoon then
            MaterialsTrackerUI:RefreshSoon()
        end
    end)
    row.iconButton:SetScript("OnEnter", function(btn)
        if not GameTooltip then return end
        GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
        local id = row._itemID and tonumber(row._itemID) or nil
        local wishlist = GetMaterialsWishlistStore()
        local enabled = id and wishlist[id] == true
        if enabled then
            GameTooltip:SetText("Remove from materials wishlist", 1, 0.95, 0.80)
        else
            GameTooltip:SetText("Add to materials wishlist", 1, 0.95, 0.80)
        end
        GameTooltip:Show()
    end)
    row.iconButton:SetScript("OnLeave", function()
        if GameTooltip then GameTooltip:Hide() end
    end)

    row.iconCount = row.iconBorder:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.iconCount:SetPoint("BOTTOMRIGHT", row.iconBorder, "BOTTOMRIGHT", -3, 3)
    row.iconCount:SetJustifyH("RIGHT")
    row.iconCount:SetText("")
    if HousingTheme then
        row.iconCount:SetTextColor(unpack(HousingTheme.Colors.textHighlight or HousingTheme.Colors.textPrimary))
    end

    row.name = row:CreateFontString(nil, "OVERLAY", HousingTheme and HousingTheme.Fonts.normal or "GameFontNormal")
    row.name:SetPoint("TOPLEFT", row.iconBorder, "TOPRIGHT", 10, -6)
    row.name:SetJustifyH("LEFT")
    if HousingTheme then
        row.name:SetTextColor(unpack(HousingTheme.Colors.textPrimary))
    end

    row.topRight = row:CreateFontString(nil, "OVERLAY", HousingTheme and HousingTheme.Fonts.small or "GameFontNormalSmall")
    row.topRight:SetPoint("TOPRIGHT", row, "TOPRIGHT", -ROW_PADDING, -6)
    row.topRight:SetJustifyH("RIGHT")
    if HousingTheme then
        row.topRight:SetTextColor(unpack(HousingTheme.Colors.textHighlight or HousingTheme.Colors.textPrimary))
    end

    row.bottomLeft = row:CreateFontString(nil, "OVERLAY", HousingTheme and HousingTheme.Fonts.small or "GameFontNormalSmall")
    row.bottomLeft:SetPoint("BOTTOMLEFT", row.iconBorder, "BOTTOMRIGHT", 10, 6)
    row.bottomLeft:SetJustifyH("LEFT")
    if HousingTheme then
        row.bottomLeft:SetTextColor(unpack(HousingTheme.Colors.textSecondary))
    end

    row.bottomRight = row:CreateFontString(nil, "OVERLAY", HousingTheme and HousingTheme.Fonts.small or "GameFontNormalSmall")
    row.bottomRight:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", -ROW_PADDING, 6)
    row.bottomRight:SetJustifyH("RIGHT")
    if HousingTheme then
        row.bottomRight:SetTextColor(unpack(HousingTheme.Colors.textSecondary))
    end

    row:SetScript("OnEnter", function(self)
        if self.highlight then
            self.highlight:Show()
        end
    end)
    row:SetScript("OnLeave", function(self)
        if self.highlight then
            self.highlight:Hide()
        end
    end)

    row.UpdateTheme = function()
        ApplyRowTheme(row)
    end
    ApplyRowTheme(row)

    return row
end

local function EnsureRows(n)
    contentFrame.rows = contentFrame.rows or {}
    for i = 1, n do
        if not contentFrame.rows[i] then
            contentFrame.rows[i] = CreateRow(contentFrame)
            if i == 1 then
                contentFrame.rows[i]:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", ROW_PADDING, -ROW_PADDING)
                contentFrame.rows[i]:SetPoint("TOPRIGHT", contentFrame, "TOPRIGHT", -ROW_PADDING, -ROW_PADDING)
            else
                contentFrame.rows[i]:SetPoint("TOPLEFT", contentFrame.rows[i - 1], "BOTTOMLEFT", 0, -6)
                contentFrame.rows[i]:SetPoint("TOPRIGHT", contentFrame.rows[i - 1], "BOTTOMRIGHT", 0, -6)
            end
        end
        contentFrame.rows[i]:Show()
    end
    for i = n + 1, #contentFrame.rows do
        contentFrame.rows[i]:Hide()
    end
end

local function CancelBuild()
    buildToken = buildToken + 1
    if trackerFrame then
        trackerFrame._hvBuildToken = buildToken
    end
end

local function IsCurrentBuild(token)
    return trackerFrame
        and trackerFrame.IsShown
        and trackerFrame:IsShown()
        and trackerFrame._hvBuildToken == token
end

local function RenderRows(rows)
    rows = rows or {}

    EnsureRows(#rows)
    for i, rowData in ipairs(rows) do
        local row = contentFrame.rows[i]
        row.icon:SetTexture(rowData.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
        row.name:SetText(rowData.name)
        row._itemID = rowData.itemID
        row._wishlisted = GetMaterialsWishlistStore()[rowData.itemID] == true
        if row.UpdateTheme then
            row:UpdateTheme()
        end
        if row.icon and row.icon.SetVertexColor then
            if row._wishlisted then
                local colors = GetThemeColors()
                local c = colors.accentGold or colors.accentPrimary or { 1, 0.95, 0.80, 1 }
                row.icon:SetVertexColor(c[1], c[2], c[3], 1)
            else
                row.icon:SetVertexColor(1, 1, 1, 1)
            end
        end

        local charName = (_G.UnitName and _G.UnitName("player")) or "Character"
        local unitPrice = GetCachedAHUnitPrice(rowData.itemID)
        UpsertCurrentCharCount(rowData.itemID, rowData.bag)
        local altSum, altBreakdown = GetAltCounts(rowData.itemID)

        if rowData.mode == "raw" then
            if row.iconCount then
                row.iconCount:SetText("")
            end
            row.topRight:SetText(string.format("Have: %d", rowData.have))
            if altSum > 0 then
                row.bottomLeft:SetText(string.format("%s: %d  |  Alts: %d  |  Warband: %d", charName, rowData.bag, altSum, rowData.warband))
            else
                row.bottomLeft:SetText(string.format("%s: %d  |  Warband: %d", charName, rowData.bag, rowData.warband))
            end
            if unitPrice then
                row.bottomRight:SetText("AH: " .. FormatMoneyFromCopper(unitPrice) .. "  |  Value: " .. FormatMoneyFromCopper(unitPrice * rowData.have))
            else
                row.bottomRight:SetText("|cFF909090AH: no price|r")
            end
        else
            if row.iconCount then
                row.iconCount:SetText(tostring(rowData.needed or ""))
            end
            row.topRight:SetText(string.format("Need: %d  |  Left: %d", rowData.needed, math.max(0, rowData.remaining)))
            if altSum > 0 then
                row.bottomLeft:SetText(string.format("%s: %d  |  Alts: %d  |  Warband: %d", charName, rowData.bag, altSum, rowData.warband))
            else
                row.bottomLeft:SetText(string.format("%s: %d  |  Warband: %d", charName, rowData.bag, rowData.warband))
            end
            if unitPrice then
                local left = math.max(0, rowData.remaining)
                row.bottomRight:SetText("AH: " .. FormatMoneyFromCopper(unitPrice) .. "  |  Total: " .. FormatMoneyFromCopper(unitPrice * left))
            else
                row.bottomRight:SetText("|cFF909090AH: no price|r")
            end
        end

        row:SetScript("OnClick", function(_, mouseButton)
            if mouseButton == "LeftButton" then
                if _G.HandleModifiedItemClick and _G.GetItemInfo then
                    local link = select(2, _G.GetItemInfo(rowData.itemID))
                    if link then
                        _G.HandleModifiedItemClick(link)
                    end
                end
            elseif mouseButton == "RightButton" and unitPrice then
                local rowID = rowData.itemID
                if _G.HousingAuctionHouseAPI and _G.HousingAuctionHouseAPI.OpenShoppingListForItem then
                    _G.HousingAuctionHouseAPI:OpenShoppingListForItem(rowID)
                end
            end
        end)

        local baseEnter = row:GetScript("OnEnter")
        row:SetScript("OnEnter", function(self)
            if baseEnter then
                pcall(baseEnter, self)
            end
            if not (_G.GameTooltip and _G.GameTooltip.SetOwner) then
                return
            end
            _G.GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            _G.GameTooltip:SetItemByID(rowData.itemID)
            _G.GameTooltip:AddLine(" ")
            _G.GameTooltip:AddLine(string.format("Bags: %d", rowData.bag), 0.9, 0.9, 0.9)
            _G.GameTooltip:AddLine(string.format("Warband Bank: %d", rowData.warband), 0.9, 0.9, 0.9)
            if altSum > 0 then
                _G.GameTooltip:AddLine(" ")
                _G.GameTooltip:AddLine("Alt bags:", 0.9, 0.9, 0.9)
                local maxShow = 8
                for j = 1, math.min(maxShow, #altBreakdown) do
                    local e = altBreakdown[j]
                    local label = tostring(e.name)
                    if e.realm and e.realm ~= "" then
                        label = label .. "-" .. tostring(e.realm)
                    end
                    _G.GameTooltip:AddLine(string.format("  %s: %d", label, tonumber(e.count) or 0), 0.85, 0.85, 0.85)
                end
                if #altBreakdown > maxShow then
                    _G.GameTooltip:AddLine(string.format("  +%d more", #altBreakdown - maxShow), 0.75, 0.75, 0.75)
                end
            end
            if rowData.mode ~= "raw" then
                _G.GameTooltip:AddLine(string.format("Need: %d  Left: %d", rowData.needed, math.max(0, rowData.remaining)), 0.9, 0.9, 0.9)
            end
            if unitPrice then
                _G.GameTooltip:AddLine("AH unit: " .. FormatMoneyFromCopper(unitPrice), 0.9, 0.9, 0.9)
            end
            if rowData.mode == "raw" and rowData.expansionName and rowData.kind then
                _G.GameTooltip:AddLine(" ")
                _G.GameTooltip:AddLine(string.format("%s - %s", tostring(rowData.expansionName), tostring(rowData.kind)), 0.8, 0.8, 0.8)
            end
            _G.GameTooltip:Show()
        end)
        row:SetScript("OnLeave", function()
            if _G.GameTooltip then
                _G.GameTooltip:Hide()
            end
        end)
    end

    local height = ROW_PADDING + (#rows * ROW_HEIGHT) + math.max(0, (#rows - 1) * ROW_SPACING)
    if height < 1 then height = 1 end
    contentFrame:SetHeight(height)

    if trackerFrame.statusText then
        if currentMode == "item" and currentItemID then
            local name = SafeItemName(currentItemID)
            trackerFrame.statusText:SetText((name and ("Current: " .. name)) or ("Current item: " .. tostring(currentItemID)))
        elseif currentMode == "raw" then
            trackerFrame.statusText:SetText("Raw materials (bags + warband bank)")
        else
            trackerFrame.statusText:SetText("Materials wishlist")
        end
    end
end

local function BuildRowsAsync(callback)
    callback = callback or function() end

    if not (_G.C_Timer and _G.C_Timer.After) then
        local rows = nil
        if currentMode == "raw" then
            rows = BuildRawMatsRows()
        elseif currentMode == "wishlist" then
            rows = BuildMaterialsWishlistRows()
        else
            rows = BuildNeededRows(BuildTotals())
        end
        callback(rows or {})
        return
    end

    CancelBuild()
    local token = buildToken
    if trackerFrame then
        trackerFrame._hvBuildToken = token
    end

    local rows = {}
    local tasks = {}

    local raw = _G.HousingRawMats
    local variantsMap = type(raw) == "table" and raw.ITEM_VARIANTS or nil
    local overrides = type(raw) == "table" and (raw.ITEM_NAME_OVERRIDES or {}) or {}
    local categories = type(raw) == "table" and (raw.CATEGORIES or {}) or {}
    local counts = ns.ItemCounts or _G.HousingItemCounts

    if currentMode == "raw" then
        local professionOnly = EnsureProfessionMatLookup()
        local function PushTask(i, kind, itemID)
            local id = tonumber(itemID)
            if not id then return end
            if professionOnly and not professionOnly[id] then return end
            tasks[#tasks + 1] = { mode = "raw", id = id, kind = kind, expansionIndex = i }
        end
        local function AddGroup(kind, tableByExpansion)
            if type(tableByExpansion) ~= "table" then return end
            for i, ids in pairs(tableByExpansion) do
                if type(ids) == "table" then
                    for _, id in ipairs(ids) do
                        PushTask(i, kind, id)
                    end
                end
            end
        end
        AddGroup("Lumber", raw and raw.LUMBER_ITEMS)
        AddGroup("Herbs", raw and raw.HERB_ITEMS)
        AddGroup("Ores", raw and raw.ORE_ITEMS)
        AddGroup("Leather", raw and raw.LEATHER_ITEMS)
        AddGroup("Fish", raw and raw.FISH_ITEMS)
        if raw and type(raw.MISC_CRAFTING_MATERIALS) == "table" then
            for _, id in ipairs(raw.MISC_CRAFTING_MATERIALS) do
                PushTask(999, "Misc", id)
            end
        end
    elseif currentMode == "wishlist" then
        local wishlist = GetMaterialsWishlistStore()
        if type(wishlist) == "table" then
            for itemID, enabled in pairs(wishlist) do
                if enabled then
                    local id = tonumber(itemID)
                    if id then
                        tasks[#tasks + 1] = { mode = "wishlist", id = id }
                    end
                end
            end
        end
    else
        local totals = BuildTotals()
        for reagentID, needed in pairs(totals or {}) do
            local id = tonumber(reagentID)
            local need = tonumber(needed)
            if id and need and need > 0 then
                tasks[#tasks + 1] = { mode = "needed", id = id, needed = need }
            end
        end
    end

    local total = #tasks
    local idx = 1
    local BATCH = 14

    local function UpdateStatus(processed)
        if trackerFrame and trackerFrame.statusText then
            local label = (currentMode == "raw" and "raw materials") or (currentMode == "wishlist" and "wishlist") or "materials"
            trackerFrame.statusText:SetText(string.format("Building %s... %d/%d", label, processed, total))
        end
    end

    local function ComputeCounts(id)
        if counts and counts.GetCountsWithVariants and variantsMap then
            return counts:GetCountsWithVariants(id, variantsMap, { includeReagentBag = true, includeWarbandBank = true })
        end
        return GetCounts(id)
    end

    local function Step()
        if not IsCurrentBuild(token) then
            return
        end

        local processed = 0
        while idx <= total and processed < BATCH do
            local t = tasks[idx]
            idx = idx + 1
            processed = processed + 1

            local id = t.id
            local bagCount, warbandCount, totalHave = ComputeCounts(id)
            bagCount = bagCount or 0
            warbandCount = warbandCount or 0
            totalHave = totalHave or 0

            if t.mode == "raw" or t.mode == "wishlist" then
                if (not showCompleted) and totalHave <= 0 then
                    -- Skip zeros unless showCompleted is enabled.
                else
                    local displayName = overrides[id] or SafeItemName(id) or ("Item " .. tostring(id))
                    local expansionName = nil
                    if t.expansionIndex == 999 then
                        expansionName = "Misc"
                    elseif t.expansionIndex then
                        expansionName = (categories[t.expansionIndex] and categories[t.expansionIndex].name) or ("Expansion " .. tostring(t.expansionIndex))
                    end
                    rows[#rows + 1] = {
                        mode = "raw",
                        itemID = id,
                        have = totalHave,
                        bag = bagCount,
                        warband = warbandCount,
                        name = displayName,
                        icon = SafeItemIcon(id),
                        expansionIndex = t.expansionIndex,
                        expansionName = expansionName,
                        kind = t.kind or (t.mode == "wishlist" and "Wishlist" or nil),
                    }
                end
            else
                local remaining = (t.needed or 0) - totalHave
                if showCompleted or remaining > 0 then
                    rows[#rows + 1] = {
                        mode = "needed",
                        itemID = id,
                        needed = t.needed or 0,
                        have = totalHave,
                        bag = bagCount,
                        warband = warbandCount,
                        remaining = remaining,
                        name = SafeItemName(id) or ("Item " .. tostring(id)),
                        icon = SafeItemIcon(id),
                    }
                end
            end
        end

        UpdateStatus(math.min(idx - 1, total))
        if idx <= total then
            _G.C_Timer.After(0, Step)
            return
        end

        if currentMode == "raw" then
            table.sort(rows, function(a, b)
                if (a.expansionIndex or 0) ~= (b.expansionIndex or 0) then
                    return (a.expansionIndex or 0) < (b.expansionIndex or 0)
                end
                if tostring(a.kind) ~= tostring(b.kind) then
                    return tostring(a.kind) < tostring(b.kind)
                end
                return tostring(a.name) < tostring(b.name)
            end)
        elseif currentMode == "wishlist" then
            table.sort(rows, function(a, b) return tostring(a.name) < tostring(b.name) end)
        else
            table.sort(rows, function(a, b)
                if a.remaining ~= b.remaining then
                    return a.remaining > b.remaining
                end
                return tostring(a.name) < tostring(b.name)
            end)
        end

        callback(rows)
    end

    UpdateStatus(0)
    _G.C_Timer.After(0, Step)
end

function MaterialsTrackerUI:Refresh()
    if not trackerFrame then
        return
    end

    refreshQueued = false

    local function StartBuild()
        if not (trackerFrame and trackerFrame.IsShown and trackerFrame:IsShown()) then
            return
        end
        if trackerFrame.statusText then
            trackerFrame.statusText:SetText("Loading...")
        end
        BuildRowsAsync(function(rows)
            if trackerFrame and trackerFrame.IsShown and trackerFrame:IsShown() then
                RenderRows(rows)
            end
        end)
    end

    if _G.HousingDataLoader and _G.HousingDataLoader.EnsureDataLoaded then
        _G.HousingDataLoader:EnsureDataLoaded(StartBuild)
    else
        StartBuild()
    end
end

function MaterialsTrackerUI:RefreshSoon()
    if refreshQueued then
        return
    end
    refreshQueued = true
    if _G.C_Timer and _G.C_Timer.After then
        _G.C_Timer.After(0.1, function()
            if trackerFrame and trackerFrame.IsShown and trackerFrame:IsShown() then
                self:Refresh()
            else
                refreshQueued = false
            end
        end)
    else
        self:Refresh()
    end
end

function MaterialsTrackerUI:StartEventHandlers()
    if trackerFrame and trackerFrame._eventFrame then
        return
    end

    local f = CreateFrame("Frame")
    trackerFrame._eventFrame = f
    f:RegisterEvent("BAG_UPDATE_DELAYED")
    f:RegisterEvent("BAG_NEW_ITEMS_UPDATED")
    f:SetScript("OnEvent", function()
        self:RefreshSoon()
    end)
end

function MaterialsTrackerUI:StopEventHandlers()
    if trackerFrame and trackerFrame._eventFrame then
        trackerFrame._eventFrame:UnregisterAllEvents()
        trackerFrame._eventFrame:SetScript("OnEvent", nil)
        trackerFrame._eventFrame = nil
    end
end

function MaterialsTrackerUI:CreateFrame()
    if trackerFrame then
        return trackerFrame
    end

    local parentFrame = self._parentFrame
    if not parentFrame then
        print("|cFF8A7FD4HousingVendor:|r MaterialsTrackerUI: No parent frame set")
        return nil
    end

    local colors = GetThemeColors()
    local bgPrimary = colors.bgPrimary or { 0.1, 0.1, 0.1, 0.95 }
    local bgSecondary = colors.bgSecondary or { 0.15, 0.15, 0.15, 0.9 }
    local borderPrimary = colors.borderPrimary or { 0.3, 0.3, 0.3, 1 }
    local textPrimary = colors.textPrimary or { 0.9, 0.9, 0.9, 1 }
    local accentPrimary = colors.accentPrimary or { 0.55, 0.45, 0.85, 1 }

    -- Create container inside main UI (replaces item list area only, not preview panel)
    local frame = CreateFrame("Frame", "HousingMaterialsTrackerContainer", parentFrame, "BackdropTemplate")
    frame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, -215)  -- Start below filters (same as item list)
    frame:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -370, 52)  -- More space on right (370px) to avoid scroll bar overlap with preview panel
    frame:Hide()
    self._materialsContainer = frame
    if HousingTheme then
        HousingTheme:ApplyBackdrop(frame, "mainFrame", "bgPrimary", "borderPrimary")
    else
        frame:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = false, edgeSize = 2,
            insets = { left = 2, right = 2, top = 2, bottom = 2 },
        })
        frame:SetBackdropColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], 0.95)
        frame:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
    end

    -- No header, no back button - just content area
    -- Toolbar for mode switching (Wishlist, Current Item, Raw Mats)
    local toolbar = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    toolbar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    toolbar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
    toolbar:SetHeight(34)
    if HousingTheme then
        HousingTheme:ApplyBackdrop(toolbar, "panel", "bgPrimary", "borderPrimary")
    else
        toolbar:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8x8",
            edgeFile = "Interface\\Buttons\\WHITE8x8",
            tile = false, edgeSize = 1,
            insets = { left = 0, right = 0, top = 0, bottom = 0 },
        })
        toolbar:SetBackdropColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], 0.6)
        toolbar:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.5)
    end

    local function CreateToolbarButton(label)
        local btn
        if HousingTheme then
            btn = HousingTheme:CreateButton(toolbar, label, 100, 24)
        else
            btn = CreateFrame("Button", nil, toolbar, "BackdropTemplate")
            btn:SetSize(100, 24)
            btn:SetBackdrop({
                bgFile = "Interface\\Buttons\\WHITE8x8",
                edgeFile = "Interface\\Buttons\\WHITE8x8",
                tile = false, edgeSize = 1,
                insets = { left = 0, right = 0, top = 0, bottom = 0 },
            })
            btn:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], 0.7)
            btn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.5)
            btn.label = btn:CreateFontString(nil, "OVERLAY", HousingTheme and HousingTheme.Fonts.normal or "GameFontNormalSmall")
            btn.label:SetPoint("CENTER")
            btn.label:SetText(label)
            btn.label:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        end
        return btn
    end

    local wishlistBtn = CreateToolbarButton("Wishlist")
    wishlistBtn:SetPoint("LEFT", toolbar, "LEFT", 16, 0)
    wishlistBtn:SetScript("OnClick", function()
        currentMode = "wishlist"
        currentItemID = nil
        MaterialsTrackerUI:RefreshSoon()
    end)

    local currentBtn = CreateToolbarButton("Current Item")
    currentBtn:SetPoint("LEFT", wishlistBtn, "RIGHT", 8, 0)
    currentBtn:SetScript("OnClick", function()
        if not currentItemID then
            print("|cFF8A7FD4HousingVendor:|r No current item selected. Open a decor item preview and use the bag button.")
            return
        end
        currentMode = "item"
        MaterialsTrackerUI:RefreshSoon()
    end)

    local rawBtn = CreateToolbarButton("Raw Mats")
    rawBtn:SetPoint("LEFT", currentBtn, "RIGHT", 8, 0)
    rawBtn:SetScript("OnClick", function()
        currentMode = "raw"
        MaterialsTrackerUI:RefreshSoon()
    end)

    local scanBtn = CreateToolbarButton("Scan AH Mats")
    scanBtn:SetPoint("LEFT", rawBtn, "RIGHT", 8, 0)
    scanBtn:SetScript("OnClick", StartRawMatAHScan)
    local status = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    status:SetPoint("TOPLEFT", toolbar, "BOTTOMLEFT", 16, -6)
    status:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    status:SetText("Materials wishlist")
    frame.statusText = status

    scrollFrame = CreateFrame("ScrollFrame", "HousingMaterialsTrackerScrollFrame", frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", status, "BOTTOMLEFT", -16, -6)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -28, 14)
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(self, delta)
        local step = 30
        local current = self:GetVerticalScroll()
        local max = self:GetVerticalScrollRange()
        local nextScroll = current - (delta * step)
        if nextScroll < 0 then nextScroll = 0 end
        if nextScroll > max then nextScroll = max end
        self:SetVerticalScroll(nextScroll)
    end)

    contentFrame = CreateFrame("Frame", nil, scrollFrame)
    contentFrame:SetSize(1, 1)
    scrollFrame:SetScrollChild(contentFrame)

    local function UpdateScrollLayout()
        local availableWidth = scrollFrame:GetWidth() - 20
        if availableWidth < 1 then availableWidth = 1 end
        contentFrame:SetWidth(availableWidth)
    end

    frame:HookScript("OnShow", function()
        MaterialsTrackerUI:StartEventHandlers()
        RegisterAHListener()
        if _G.C_Timer and _G.C_Timer.After then
            _G.C_Timer.After(0, UpdateScrollLayout)
        else
            UpdateScrollLayout()
        end
        MaterialsTrackerUI:RefreshSoon()
    end)
    frame:HookScript("OnHide", function()
        CancelBuild()
        UnregisterAHListener()
        MaterialsTrackerUI:StopEventHandlers()
    end)
    frame:HookScript("OnSizeChanged", function()
        if _G.C_Timer and _G.C_Timer.After then
            _G.C_Timer.After(0, UpdateScrollLayout)
        else
            UpdateScrollLayout()
        end
    end)

    trackerFrame = frame

    frame._header = header
    frame._toolbar = toolbar
    frame._title = title
    frame._closeBtn = closeBtn
    frame._closeText = closeText

    frame.UpdateTheme = function()
        local colorsNow = GetThemeColors()
        local bgPrimary = colorsNow.bgPrimary or { 0.1, 0.1, 0.1, 0.95 }
        local bgSecondary = colorsNow.bgSecondary or { 0.15, 0.15, 0.15, 0.9 }
        local borderPrimary = colorsNow.borderPrimary or { 0.3, 0.3, 0.3, 1 }
        local borderAccent = colorsNow.borderAccent or borderPrimary
        local textPrimary = colorsNow.textPrimary or { 0.9, 0.9, 0.9, 1 }
        local textSecondary = colorsNow.textSecondary or { 0.7, 0.7, 0.8, 1 }
        local textHighlight = colorsNow.textHighlight or textPrimary
        local bgHover = colorsNow.bgHover or { 0.2, 0.2, 0.2, 1 }
        local bgTertiary = colorsNow.bgTertiary or bgSecondary

        if HousingTheme and HousingTheme.ApplyBackdrop then
            HousingTheme:ApplyBackdrop(frame, "mainFrame", "bgPrimary", "borderPrimary")
            if header then
                HousingTheme:ApplyBackdrop(header, "panel", "bgSecondary", "borderAccent")
            end
            if toolbar then
                HousingTheme:ApplyBackdrop(toolbar, "panel", "bgPrimary", "borderPrimary")
            end
            if closeBtn then
                HousingTheme:ApplyBackdrop(closeBtn, "button", "bgPrimary", "borderPrimary")
            end
        else
            if frame.SetBackdropColor then
                frame:SetBackdropColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], bgPrimary[4])
            end
            if frame.SetBackdropBorderColor then
                frame:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
            end
            if header and header.SetBackdropColor then
                header:SetBackdropColor(bgSecondary[1], bgSecondary[2], bgSecondary[3], bgSecondary[4] or 0.92)
            end
            if header and header.SetBackdropBorderColor then
                header:SetBackdropBorderColor(borderAccent[1], borderAccent[2], borderAccent[3], borderAccent[4] or 1)
            end
            if toolbar and toolbar.SetBackdropColor then
                toolbar:SetBackdropColor(bgPrimary[1], bgPrimary[2], bgPrimary[3], 0.6)
            end
            if toolbar and toolbar.SetBackdropBorderColor then
                toolbar:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.5)
            end
            if closeBtn and closeBtn.SetBackdropColor then
                closeBtn:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4] or 0.9)
            end
            if closeBtn and closeBtn.SetBackdropBorderColor then
                closeBtn:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4] or 1)
            end
        end

        if title then
            title:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        end
        if status then
            status:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
        end
        if closeText then
            closeText:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
        end

        if closeBtn and closeBtn.SetScript then
            closeBtn:SetScript("OnEnter", function(self)
                if HousingTheme and HousingTheme.ApplyBackdrop then
                    HousingTheme:ApplyBackdrop(self, "button", "bgHover", "accentPrimary")
                else
                    self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4] or 1)
                end
                if closeText then
                    closeText:SetTextColor(textHighlight[1], textHighlight[2], textHighlight[3], 1)
                end
            end)
            closeBtn:SetScript("OnLeave", function(self)
                if HousingTheme and HousingTheme.ApplyBackdrop then
                    HousingTheme:ApplyBackdrop(self, "button", "bgPrimary", "borderPrimary")
                else
                    self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4] or 0.9)
                end
                if closeText then
                    closeText:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
                end
            end)
        end

        if contentFrame and contentFrame.rows then
            for _, row in ipairs(contentFrame.rows) do
                if row and row.UpdateTheme then
                    row:UpdateTheme()
                end
            end
        end

    end
    frame:UpdateTheme()

    return frame
end

function MaterialsTrackerUI:ApplyTheme()
    if trackerFrame and trackerFrame.UpdateTheme then
        trackerFrame:UpdateTheme()
        self:RefreshSoon()
    end
end

function MaterialsTrackerUI:Initialize(parent)
    self._parentFrame = parent
end

function MaterialsTrackerUI:ShowWishlist()
    if not self._parentFrame then
        print("|cFF8A7FD4HousingVendor:|r MaterialsTrackerUI: Not initialized")
        return
    end
    
    self:CreateFrame()
    if not trackerFrame then
        return
    end
    
    currentMode = "wishlist"
    currentItemID = nil
    
    -- Hide main UI components
    SetMainUIVisible(false)
    
    -- Show materials container
    trackerFrame:Show()
    self:RefreshSoon()
end

function MaterialsTrackerUI:ShowForItem(itemID)
    if not self._parentFrame then
        print("|cFF8A7FD4HousingVendor:|r MaterialsTrackerUI: Not initialized")
        return
    end
    
    self:CreateFrame()
    if not trackerFrame then
        return
    end
    
    currentItemID = tonumber(itemID) or currentItemID
    currentMode = "item"
    
    -- Hide main UI components
    SetMainUIVisible(false)
    
    -- Show materials container
    trackerFrame:Show()
    self:RefreshSoon()
end

function MaterialsTrackerUI:ShowRawMats()
    if not self._parentFrame then
        print("|cFF8A7FD4HousingVendor:|r MaterialsTrackerUI: Not initialized")
        return
    end
    
    self:CreateFrame()
    if not trackerFrame then
        return
    end
    
    currentMode = "raw"
    
    -- Hide main UI components
    SetMainUIVisible(false)
    
    -- Show materials container
    trackerFrame:Show()
    self:RefreshSoon()
end

function MaterialsTrackerUI:Hide()
    if trackerFrame then
        trackerFrame:Hide()
    end
    
    -- Restore main UI components
    SetMainUIVisible(true)
end

function MaterialsTrackerUI:Toggle()
    if not self._parentFrame then
        print("|cFF8A7FD4HousingVendor:|r MaterialsTrackerUI: Not initialized")
        return
    end
    
    self:CreateFrame()
    if not trackerFrame then
        return
    end
    
    if trackerFrame:IsShown() then
        self:Hide()
    else
        -- Hide main UI components
        SetMainUIVisible(false)
        
        trackerFrame:Show()
        self:RefreshSoon()
    end
end

function MaterialsTrackerUI:ToggleForItem(itemID)
    if not self._parentFrame then
        print("|cFF8A7FD4HousingVendor:|r MaterialsTrackerUI: Not initialized")
        return
    end
    
    self:CreateFrame()
    if not trackerFrame then
        return
    end
    
    local id = tonumber(itemID)
    if not id then
        self:ToggleWishlist()
        return
    end

    if trackerFrame:IsShown() and currentMode == "item" and currentItemID == id then
        self:Hide()
        return
    end

    currentItemID = id
    currentMode = "item"
    
    -- Hide main UI components
    SetMainUIVisible(false)
    
    trackerFrame:Show()
    self:RefreshSoon()
end

function MaterialsTrackerUI:ToggleWishlist()
    if not self._parentFrame then
        print("|cFF8A7FD4HousingVendor:|r MaterialsTrackerUI: Not initialized")
        return
    end
    
    self:CreateFrame()
    if not trackerFrame then
        return
    end
    
    if trackerFrame:IsShown() and currentMode == "wishlist" then
        self:Hide()
        return
    end
    
    currentMode = "wishlist"
    currentItemID = nil
    
    -- Hide main UI components
    SetMainUIVisible(false)
    
    trackerFrame:Show()
    self:RefreshSoon()
end

ns.MaterialsTrackerUI = MaterialsTrackerUI
_G.HousingMaterialsTrackerUI = MaterialsTrackerUI

return MaterialsTrackerUI
