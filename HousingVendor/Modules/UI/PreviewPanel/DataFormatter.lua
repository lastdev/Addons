-- PreviewPanel Sub-module: Data formatting/parsing helpers
-- Part of PreviewPanelData

local _G = _G
local _, HousingVendor = ...
if not HousingVendor then return end

local PreviewPanelData = HousingVendor.PreviewPanelData or _G["HousingPreviewPanelData"]
if not PreviewPanelData then
    PreviewPanelData = {}
    HousingVendor.PreviewPanelData = PreviewPanelData
    _G["HousingPreviewPanelData"] = PreviewPanelData
end

PreviewPanelData.Util = PreviewPanelData.Util or {}

function PreviewPanelData.Util.CleanText(text)
    local DataManager = _G["HousingDataManager"]
    if DataManager and DataManager.Util and DataManager.Util.CleanText then
        return DataManager.Util.CleanText(text, false)
    end
    if not text or text == "" then return "" end
    return text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|[Hh]", ""):gsub("|T[^|]*|t", ""):gsub("|n", " "):match("^%s*(.-)%s*$") or text
end

-- Cache for resolved encounter names
local encounterNameCache = {}

--- Resolves "Encounter XXXXX" or "NPC XXXXX" placeholder strings to actual names
--- Uses the Encounter Journal API (EJ_GetEncounterInfo) for encounters
--- @param name string The name to check/resolve
--- @return string resolvedName The resolved name, or original if not a placeholder
function PreviewPanelData.Util.ResolveEncounterName(name)
    if not name or type(name) ~= "string" then
        return name
    end

    -- Check if this is an "Encounter XXXXX" placeholder
    local encounterID = name:match("^Encounter%s+(%d+)$")
    if encounterID then
        encounterID = tonumber(encounterID)
        if encounterID then
            -- Check cache first
            if encounterNameCache[encounterID] then
                return encounterNameCache[encounterID]
            end

            -- Try to resolve via Encounter Journal API
            if EJ_GetEncounterInfo then
                local bossName = EJ_GetEncounterInfo(encounterID)
                if bossName and bossName ~= "" then
                    encounterNameCache[encounterID] = bossName
                    return bossName
                end
            end
        end
    end

    -- Return original if couldn't resolve
    return name
end

function PreviewPanelData.Util.FormatMoneyFromCopper(copperAmount)
    local amount = tonumber(copperAmount) or 0
    if amount <= 0 then
        if GetCoinTextureString then
            return GetCoinTextureString(0)
        end
        return "0 Copper"
    end

    if GetCoinTextureString then
        return GetCoinTextureString(amount)
    end

    local gold = math.floor(amount / 10000)
    local silver = math.floor((amount % 10000) / 100)
    local copper = amount % 100

    local parts = {}
    if gold > 0 then table.insert(parts, gold .. " Gold") end
    if silver > 0 then table.insert(parts, silver .. " Silver") end
    if copper > 0 then table.insert(parts, copper .. " Copper") end

    return table.concat(parts, " ")
end

function PreviewPanelData.Util.FormatMoneyTooltipFromCopper(copperAmount)
    local icons = PreviewPanelData.Util.FormatMoneyFromCopper(copperAmount)
    if GetCoinTextureString then
        return icons .. " (Gold)"
    end
    return icons
end

function PreviewPanelData.Util.GetCurrencyName(currencyID, fallbackName)
    local id = tonumber(currencyID)
    if not id or id <= 0 then
        return fallbackName or "Currency"
    end

    local currencyInfo = nil
    if HousingAPI and HousingAPI.GetCurrencyInfo then
        currencyInfo = HousingAPI:GetCurrencyInfo(id)
    elseif C_CurrencyInfo and C_CurrencyInfo.GetCurrencyInfo then
        local ok, info = pcall(C_CurrencyInfo.GetCurrencyInfo, id)
        if ok then currencyInfo = info end
    end

    if currencyInfo and currencyInfo.name and currencyInfo.name ~= "" then
        return currencyInfo.name
    end

    if HousingCurrencyTypes and HousingCurrencyTypes[id] then
        return HousingCurrencyTypes[id]
    end

    return fallbackName or ("Currency (ID: " .. tostring(id) .. ")")
end

function PreviewPanelData.Util.GetCurrencyIconMarkup(currencyID)
    local id = tonumber(currencyID)
    if not id or id <= 0 then return nil end

    local fallbackIconFileIDs = {
        -- Legacy currencies may not return iconFileID unless discovered; provide known icons for common ones.
        [1220] = 7382824, -- Order Resources
    }

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
    if not iconFileID then return nil end

    return "|T" .. tostring(iconFileID) .. ":14|t"
end

local ITEM_ICON_MARKUP_CACHE = {}
local ITEM_ICON_MARKUP_CACHE_COUNT = 0
local MAX_ITEM_ICON_MARKUP_CACHE = 2000
function PreviewPanelData.Util.GetItemIconMarkup(itemID)
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
        if ITEM_ICON_MARKUP_CACHE_COUNT > MAX_ITEM_ICON_MARKUP_CACHE then
            for k in pairs(ITEM_ICON_MARKUP_CACHE) do
                ITEM_ICON_MARKUP_CACHE[k] = nil
            end
            ITEM_ICON_MARKUP_CACHE_COUNT = 0
        end
    end
    ITEM_ICON_MARKUP_CACHE[id] = markup
    return markup
end

function PreviewPanelData.Util.NormalizeCostString(costStr)
    if not costStr or type(costStr) ~= "string" then return nil end

    local money = costStr:match("|Hmoney:(%d+)|h")
    if money then
        return PreviewPanelData.Util.FormatMoneyTooltipFromCopper(money)
    end

    local currencyID = costStr:match("|Hcurrency:(%d+)")
    if currencyID then
        local amount = tonumber(costStr:match("(%d+)")) or 0
        local name = PreviewPanelData.Util.GetCurrencyName(currencyID)
        local icon = costStr:match("(|T[^|]*|t)") or PreviewPanelData.Util.GetCurrencyIconMarkup(currencyID) or ""
        if icon ~= "" then icon = " " .. icon end
        return amount .. icon .. " (" .. name .. ")"
    end

    local amount = costStr:match("(%d+)")
    if amount and (costStr:find("INV_Misc_Coin_01") or costStr:lower():find("gold")) then
        return amount .. " Gold"
    end

    return costStr ~= "" and costStr or nil
end

function PreviewPanelData:DisplayNameAndIcon(previewFrame, item, catalogData)
    local name = catalogData.name or item.name or "Unknown Item"

    -- Get quality from catalogData or fallback to C_Item API (API safety)
    local quality = catalogData.quality
    if quality == nil then
        local itemID = tonumber(item.itemID)
        if itemID and C_Item and C_Item.GetItemQualityByID then
            quality = C_Item.GetItemQualityByID(itemID)
        end
    end

    if quality ~= nil then
        local qualityColors = {
            [0] = "|cff9d9d9d",
            [1] = "|cffffffff",
            [2] = "|cff1eff00",
            [3] = "|cff0070dd",
            [4] = "|cffa335ee",
            [5] = "|cffff8000",
        }
        local colorCode = qualityColors[quality] or "|cffffffff"
        previewFrame.name:SetText(colorCode .. name .. "|r")
    else
        previewFrame.name:SetText(name)
    end
    
    previewFrame.idText:SetText("Item ID: " .. (item.itemID or "Unknown"))
    
    -- Try to get icon from multiple sources
    local icon = nil
    
    -- 1. Try icon cache module first
    if _G["HousingIcons"] and item.itemID then
        icon = _G["HousingIcons"]:GetIcon(item.itemID, item.thumbnailFileID or item._thumbnailFileID or nil)
    elseif _G["HousingIconCache"] and item.itemID then
        -- Backwards-compatible alias
        icon = _G["HousingIconCache"]:GetItemIcon(item.itemID, item.thumbnailFileID or item._thumbnailFileID or nil)
    end
    
    -- 2. Fall back to catalogData.icon
    if not icon then
        icon = catalogData.icon
    end
    
    -- 3. Fall back to item.icon
    if not icon then
        icon = item.icon
    end
    
    -- 4. Fall back to GetItemIcon API
    if not icon and item.itemID then
        local itemID = tonumber(item.itemID)
        if itemID then
            icon = GetItemIcon(itemID)
        end
    end
    
    -- 5. Final fallback to question mark
    if not icon or icon == "" then
        icon = "Interface\\Icons\\INV_Misc_QuestionMark"
    end
    
    previewFrame.icon:SetTexture(icon)

    -- Use the same quality variable from above (already has fallback to C_Item API)
    if quality ~= nil then
        local qualityColors = {
            [0] = {0.62, 0.62, 0.62},
            [1] = {1.00, 1.00, 1.00},
            [2] = {0.12, 1.00, 0.00},
            [3] = {0.00, 0.44, 0.87},
            [4] = {0.64, 0.21, 0.93},
            [5] = {1.00, 0.50, 0.00},
        }
        local color = qualityColors[quality] or {1, 1, 1}
        if previewFrame.iconBorder and previewFrame.iconBorder.SetBackdropBorderColor then
            previewFrame.iconBorder:SetBackdropBorderColor(color[1], color[2], color[3], 0.9)
        elseif previewFrame.iconBorder and previewFrame.iconBorder.SetVertexColor then
            previewFrame.iconBorder:SetVertexColor(color[1], color[2], color[3], 0.8)
        end
    end
end

function PreviewPanelData:DisplayCollectionStatus(previewFrame, item, catalogData)
    local itemID = tonumber(item.itemID)
    local collectionText = nil
    local numPlaced = item._apiNumPlaced or catalogData.numPlaced or 0
    local numStored = item._apiNumStored or catalogData.numStored or 0
    local totalOwned = numPlaced + numStored
    local isCollected = totalOwned > 0
    local themeColors = _G.HousingTheme and _G.HousingTheme.Colors or {}
    local statusSuccess = themeColors.statusSuccess or { 0.30, 0.85, 0.50, 1.0 }
    local statusError = themeColors.statusError or { 0.95, 0.35, 0.40, 1.0 }
    local textMuted = themeColors.textMuted or { 0.50, 0.48, 0.58, 1.0 }

    if not isCollected and itemID and HousingCollectionAPI then
        isCollected = HousingCollectionAPI:IsItemCollected(itemID)
    end

    if isCollected then
        previewFrame.collectedCheck:Show()
        if previewFrame.collectedValue then
            previewFrame.collectedValue:SetText("|cFF00FF00Yes|r")
        end
    else
        previewFrame.collectedCheck:Hide()
        if previewFrame.collectedValue then
            previewFrame.collectedValue:SetText("|cFFFF0000No|r")
        end
    end

    -- Recipe known/unknown (profession items only). If we can't determine known/unknown yet,
    -- show trainer guidance instead.
    if previewFrame.recipeValue and previewFrame.recipeValue.label then
        local hv = _G.HousingVendor
        local pr = hv and hv.ProfessionReagents
        local hasReagents = pr and pr.HasReagents and itemID and pr:HasReagents(itemID) or false

        if hasReagents then
            local known = pr and pr.IsRecipeKnown and pr:IsRecipeKnown(itemID) or nil
            local altProfs = _G.HousingAltProfessions
            local altsWithRecipe = altProfs and altProfs.GetCharsWithRecipe and altProfs:GetCharsWithRecipe(itemID) or {}
            
            if known == nil then
                local pt = hv and hv.ProfessionTrainers
                local trainer = pt and pt.GetTrainerForItem and pt:GetTrainerForItem(itemID, item) or nil
                local trainerName = trainer and trainer.name or nil
                local trainerLocation = trainer and trainer.location or nil

                previewFrame.recipeValue.label:SetText("Trainer:")
                previewFrame.recipeValue:SetText(trainerName or trainerLocation or "")
                previewFrame.recipeValue:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
            elseif known == true then
                previewFrame.recipeValue.label:SetText("Recipe:")
                previewFrame.recipeValue:SetText("Known")
                previewFrame.recipeValue:SetTextColor(statusSuccess[1], statusSuccess[2], statusSuccess[3], 1)
            else
                -- Not known by current char, check alts
                if #altsWithRecipe > 0 then
                    local altNames = {}
                    for i = 1, math.min(#altsWithRecipe, 3) do
                        altNames[#altNames + 1] = altsWithRecipe[i].name
                    end
                    if #altsWithRecipe > 3 then
                        altNames[#altNames + 1] = "..." .. (#altsWithRecipe - 3) .. " more"
                    end
                    previewFrame.recipeValue.label:SetText("Known by:")
                    previewFrame.recipeValue:SetText(table.concat(altNames, ", "))
                    previewFrame.recipeValue:SetTextColor(statusWarning[1], statusWarning[2], statusWarning[3], 1)
                else
                    previewFrame.recipeValue.label:SetText("Recipe:")
                    previewFrame.recipeValue:SetText("Unknown")
                    previewFrame.recipeValue:SetTextColor(statusError[1], statusError[2], statusError[3], 1)
                end
            end
            previewFrame.recipeValue:Show()
            previewFrame.recipeValue.label:Show()
        else
            previewFrame.recipeValue:SetText("")
            previewFrame.recipeValue:Hide()
            previewFrame.recipeValue.label:Hide()
        end
    end

    if numPlaced > 0 then
        collectionText = string.format("Placed: %d", numPlaced)
        if numStored > 0 then
            collectionText = collectionText .. string.format(" | Stored: %d", numStored)
        end
    elseif numStored > 0 then
        collectionText = string.format("Stored: %d", numStored)
    elseif catalogData.quantity and catalogData.quantity > 0 and catalogData.quantity < 4294967290 then
        -- Filter out invalid Midnight beta API values (max uint32 = 4294967295, likely -1 as unsigned)
        collectionText = string.format("Owned: %d", catalogData.quantity)
    end
    
    if collectionText and collectionText ~= "" then
        if previewFrame.collectionValue and previewFrame.SetFieldValue then
            previewFrame.SetFieldValue(previewFrame.collectionValue, collectionText, previewFrame.collectionValue.label)
        end
    else
        if previewFrame.collectionValue then
            previewFrame.collectionValue:Hide()
            if previewFrame.collectionValue.label then
                previewFrame.collectionValue.label:Hide()
            end
        end
    end
end

function PreviewPanelData:DisplayExpansionAndFaction(previewFrame, item, catalogData)
    local expansionText = nil
    if HousingAPI and item.itemID then
        local apiExpansion = HousingAPI:GetExpansionFromFilterTags(item.itemID)
        if apiExpansion and apiExpansion ~= "" then
            expansionText = apiExpansion
        end
    end
    if not expansionText and item.expansionName and item.expansionName ~= "" then
        expansionText = item.expansionName
    end
    
    local displayExpansion = expansionText
    if displayExpansion then
        displayExpansion = displayExpansion:gsub("|c%x%x%x%x%x%x%x%x", "")
        displayExpansion = displayExpansion:gsub("|r", "")
        displayExpansion = displayExpansion:gsub("|H[^|]*|h", "")
        displayExpansion = displayExpansion:gsub("|h", "")
        displayExpansion = displayExpansion:gsub("|T[^|]*|t", "")
        displayExpansion = displayExpansion:gsub("|n", " ")
        displayExpansion = displayExpansion:match("^%s*(.-)%s*$") or displayExpansion
    end
    
    previewFrame.SetFieldValue(previewFrame.expansionValue, displayExpansion, previewFrame.expansionValue.label)

    local factionText = item.faction or "Neutral"
    if factionText == "Alliance" then
        factionText = "|cFF0070DD" .. factionText .. "|r"
    elseif factionText == "Horde" then
        factionText = "|cFFC41E3A" .. factionText .. "|r"
    elseif factionText == "Neutral" then
        factionText = "|cFFFFD100" .. factionText .. "|r"
    end
    previewFrame.SetFieldValue(previewFrame.factionValue, factionText, previewFrame.factionValue.label)
end

function PreviewPanelData:DisplayVendorInfo(previewFrame, item, catalogData)
    local itemID = item and tonumber(item.itemID) or nil
    local vendor = nil
    local zone = nil
    local cost = (item and item.cost and item.cost ~= "") and nil or (catalogData and catalogData.cost)
    local costBreakdown = {}
    local costBreakdownIcons = {}
    local coordsText = nil
    local apiCoords = nil
    local apiMapID = nil

    local function ApplyStaticCostIcons(text, components)
        if type(text) ~= "string" or text == "" then
            return text
        end

        -- Ensure gold uses the coin icon (in case it wasn't normalized upstream).
        text = text:gsub("([%d,]+)%s*[Gg]old(%*?)", "%1 |TInterface\\MoneyFrame\\UI-GoldIcon:0|t%2")

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
                local icon = PreviewPanelData.Util.GetCurrencyIconMarkup(k.id)
                if icon and icon ~= "" then
                    local escapedName = k.name:gsub("([^%w])", "%%%1")
                    text = text:gsub("([%d,]+)%s+" .. escapedName .. "(%*?)", "%1 " .. icon .. "%2")
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
                local icon = PreviewPanelData.Util.GetItemIconMarkup(k.id)
                if icon and icon ~= "" then
                    local escapedName = k.name:gsub("([^%w])", "%%%1")
                    text = text:gsub("([%d,]+)%s+" .. escapedName .. "(%*?)", "%1 " .. icon .. "%2")
                end
            end
        end

        if type(components) ~= "table" then
            return text
        end

        for _, component in ipairs(components) do
            local itemID = component and component.itemID
            local currencyTypeID = component and component.currencyTypeID
            local amount = component and component.amount
            if itemID and amount then
                local icon = PreviewPanelData.Util.GetItemIconMarkup(itemID)
                if icon and icon ~= "" then
                    local name = component.name or ""
                    name = tostring(name or "")
                    if name ~= "" then
                        local escapedName = name:gsub("([^%w])", "%%%1")
                        local amountStr = tostring(amount)
                        local amountWithComma = amountStr:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
                        text = text:gsub(amountWithComma .. "%s+" .. escapedName, amountWithComma .. " " .. icon)
                        text = text:gsub(amountStr .. "%s+" .. escapedName, amountStr .. " " .. icon)
                    end
                end
            elseif currencyTypeID and amount then
                local icon = PreviewPanelData.Util.GetCurrencyIconMarkup(currencyTypeID)
                if icon and icon ~= "" then
                    local name = component.name or PreviewPanelData.Util.GetCurrencyName(currencyTypeID, nil) or ""
                    name = tostring(name or "")
                    if name ~= "" then
                        local escapedName = name:gsub("([^%w])", "%%%1")
                        local amountStr = tostring(amount)
                        local amountWithComma = amountStr:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
                        text = text:gsub(amountWithComma .. "%s+" .. escapedName, amountWithComma .. " " .. icon)
                        text = text:gsub(amountStr .. "%s+" .. escapedName, amountStr .. " " .. icon)
                    end
                end
            end
        end

        return text
    end

    -- Store actual coordinate values for waypoint button (not just formatted text)
    local waypointX = nil
    local waypointY = nil
    local waypointMapID = nil
    
    local enrichedVendors = nil
    if USE_STATIC_VENDOR_ENRICHMENT and HousingDataEnrichment and item.itemID then
        enrichedVendors = HousingDataEnrichment:GetVendorInfo(item.itemID)
    end
    
    if enrichedVendors and #enrichedVendors > 0 then
        local vendorData = enrichedVendors[1]
        if vendorData.name and vendorData.name ~= "" then
            vendor = vendorData.name
        end
        
        if vendorData.location and vendorData.location ~= "" then
            zone = vendorData.location
        end
        
        if vendorData.coordX and vendorData.coordY then
            apiCoords = string.format("%.1f, %.1f", vendorData.coordX, vendorData.coordY)
            coordsText = apiCoords
            if not waypointX then
                waypointX = vendorData.coordX
                waypointY = vendorData.coordY
            end
            if vendorData.mapID and not waypointMapID then
                waypointMapID = vendorData.mapID
            end
        end
        
        if vendorData.price and vendorData.currency then
            if vendorData.price > 0 then
                if vendorData.currency == "Gold" then
                    cost = string.format("%dg", vendorData.price)
                    table.insert(costBreakdown, string.format("%d Gold", vendorData.price))
                    table.insert(costBreakdownIcons, PreviewPanelData.Util.FormatMoneyFromCopper((vendorData.price or 0) * 10000))
                else
                    cost = string.format("%d %s", vendorData.price, vendorData.currency)
                    local currencyName = vendorData.currency
                    local icon = PreviewPanelData.Util.GetCurrencyIconMarkup(vendorData.currencyId or 0)
                    if icon then
                        table.insert(costBreakdown, string.format("%d %s (%s)", vendorData.price, icon, currencyName))
                    else
                        table.insert(costBreakdown, string.format("%d (%s)", vendorData.price, currencyName))
                    end
                    local icon = PreviewPanelData.Util.GetCurrencyIconMarkup(vendorData.currencyId or 0)
                    if icon then
                        table.insert(costBreakdownIcons, string.format("%d %s", vendorData.price, icon))
                    end
                end
            end
        end
    elseif HousingAPI and item.itemID then
        local itemID = tonumber(item.itemID)
        if itemID then
            local baseInfo = HousingAPI:GetDecorItemInfoFromItemID(itemID)
            if baseInfo and baseInfo.decorID then
                local decorID = baseInfo.decorID
                local vendorInfo = HousingAPI:GetDecorVendorInfo(decorID)
                if vendorInfo then
                    if vendorInfo.name and vendorInfo.name ~= "" then
                        vendor = vendorInfo.name
                    end
                    
                    if vendorInfo.zone and vendorInfo.zone ~= "" then
                        zone = vendorInfo.zone
                    end
                    
                    if vendorInfo.coords and vendorInfo.coords.x and vendorInfo.coords.y then
                        apiCoords = string.format("%.1f, %.1f", vendorInfo.coords.x, vendorInfo.coords.y)
                        coordsText = apiCoords
                        if not waypointX then
                            waypointX = vendorInfo.coords.x
                            waypointY = vendorInfo.coords.y
                        end
                    end
                    if vendorInfo.mapID then
                        apiMapID = vendorInfo.mapID
                        if not waypointMapID then
                            waypointMapID = vendorInfo.mapID
                        end
                    end
                    
                    if vendorInfo.cost and #vendorInfo.cost > 0 then
                        for _, costEntry in ipairs(vendorInfo.cost) do
                            if costEntry.currencyID == 0 then
                                table.insert(costBreakdown, PreviewPanelData.Util.FormatMoneyTooltipFromCopper(costEntry.amount))
                                table.insert(costBreakdownIcons, PreviewPanelData.Util.FormatMoneyFromCopper(costEntry.amount))
                            elseif costEntry.currencyID then
                                local amount = tonumber(costEntry.amount) or 0
                                local name = PreviewPanelData.Util.GetCurrencyName(costEntry.currencyID)
                                local icon = PreviewPanelData.Util.GetCurrencyIconMarkup(costEntry.currencyID)
                                if icon then
                                    table.insert(costBreakdown, amount .. " " .. icon .. " (" .. name .. ")")
                                    table.insert(costBreakdownIcons, amount .. " " .. icon)
                                else
                                    table.insert(costBreakdown, amount .. " (" .. name .. ")")
                                end
                            elseif costEntry.itemID then
                                local itemName = "Item #" .. costEntry.itemID
                                if C_Item and C_Item.GetItemInfo then
                                    local ok3, itemInfo = pcall(C_Item.GetItemInfo, costEntry.itemID)
                                    if ok3 and itemInfo and itemInfo.itemName then
                                        itemName = itemInfo.itemName
                                    end
                                end
                                table.insert(costBreakdown, (costEntry.amount or 0) .. "x " .. itemName)
                            end
                        end
                    end
                end
            end
        end
    end
    
    -- Prefer hard data vendor selection over API-provided vendor text (API can be wrong/overwritten).
    if item then
        local Filters = _G.HousingFilters
        local filterVendor = Filters and Filters.currentFilters and Filters.currentFilters.vendor or nil
        local filterZone = Filters and Filters.currentFilters and Filters.currentFilters.zone or nil

        if _G.HousingVendorHelper then
            local filterMapID = Filters and Filters.currentFilters and Filters.currentFilters.zoneMapID or nil

            local hardVendor = _G.HousingVendorHelper:GetVendorName(item, filterVendor, filterZone, filterMapID)
            local hardZone = _G.HousingVendorHelper:GetZoneName(item, filterZone, filterMapID)

            -- Override API/enrichment text when we have hard data (authoritative).
            if hardVendor and hardVendor ~= "" then
                vendor = hardVendor
            end
            if hardZone and hardZone ~= "" then
                zone = hardZone
            end

            local coords = _G.HousingVendorHelper:GetVendorCoords(item, filterVendor, filterZone, filterMapID)
            if coords and coords.x and coords.y and coords.x > 0 and coords.y > 0 then
                -- Store actual numeric coordinates for waypoint
                waypointX = coords.x
                waypointY = coords.y
                if coords.mapID and coords.mapID > 0 then
                    waypointMapID = coords.mapID
                    apiMapID = coords.mapID
                end

                -- Keep displayed coords in sync with the waypoint coords when we have hard data.
                coordsText = string.format("%.1f, %.1f", coords.x, coords.y)
                apiCoords = coordsText
            end
        end
    end

    -- Fallback: pull from static expansion data (drops/quests/rewards) even if the item record
    -- didn't carry the fields through (e.g. stale cache or partial enrichment).
    if itemID and _G.HousingExpansionData then
        local expData = _G.HousingExpansionData[itemID]
        if expData and expData.drop then
            local d = expData.drop[1] or expData.drop
            if not vendor and d and d.npcName and d.npcName ~= "" then
                vendor = d.npcName
            end
            if not zone and d and d.zone and d.zone ~= "" then
                zone = d.zone
            end
            if not coordsText and d and d.coordinates then
                local c = d.coordinates
                if c.x and c.y and c.x > 0 and c.y > 0 then
                    coordsText = string.format("%.1f, %.1f", c.x, c.y)
                    waypointX, waypointY = c.x, c.y
                    if c.mapID and c.mapID > 0 then
                        waypointMapID = c.mapID
                        apiMapID = c.mapID
                    end
                end
            end
        end
        -- Reward fallback: extract zone from reward data
        if expData and expData.reward then
            local r = expData.reward[1] or expData.reward
            if not zone and r and r.zone and r.zone ~= "" then
                zone = r.zone
            end
        end
    end

    if not vendor and catalogData.vendor then
        vendor = PreviewPanelData.Util.CleanText(catalogData.vendor)
        vendor = PreviewPanelData.Util.ResolveEncounterName(vendor)
    end

    -- FIX: Fallback to item npcName for drop items
    if not vendor and item and item.npcName then
        vendor = item.npcName
    end

    if not zone and catalogData.zone then
        zone = PreviewPanelData.Util.CleanText(catalogData.zone)
        if zone:find("Zone:") then
            zone = zone:gsub("%s*Zone:%s*", "\n")
            zone = zone:gsub("^\n", "")
        end
    end

    -- Fallback to item zone if API data not available (zone may already be set by vendor helper above)
    if not zone and item then
        -- NEW: If user has filtered by zone, show that zone (not the overwritten one)
        local Filters = _G.HousingFilters
        if Filters and Filters.currentFilters and Filters.currentFilters.zone and Filters.currentFilters.zone ~= "All Zones" then
            -- User filtered by a specific zone, show that zone
            zone = Filters.currentFilters.zone
        else
            -- FIX: For drop items, use item.zone field first, then zoneName, then API zone
            zone = item.zone or item.zoneName or item._apiZone
        end
    end

    -- NOTE: Coordinate extraction is now handled by VendorHelper:GetVendorCoords() above (lines 726-740)
    -- which already has the fallback logic for item.coords and item.vendorCoords.
    -- FIX: Additional fallback for drop items with coordinates field
    if not coordsText and item and item.coordinates then
        if item.coordinates.x and item.coordinates.y and item.coordinates.x > 0 and item.coordinates.y > 0 then
            coordsText = string.format("%.1f, %.1f", item.coordinates.x, item.coordinates.y)
            waypointX = item.coordinates.x
            waypointY = item.coordinates.y
            if item.coordinates.mapID and item.coordinates.mapID > 0 then
                waypointMapID = item.coordinates.mapID
                apiMapID = item.coordinates.mapID
            end
        end
    end

    local parsedReputation = nil
    local repProgress = nil
    local isRenownRequirement = false

    -- Reputation display: prefer catalog/API reputation text, then item record fields,
    -- and finally fall back to older "Faction:" suffix parsing in the zone string.
    local repInfoText = (catalogData and catalogData.reputation) or nil
    if (not repInfoText or repInfoText == "" or repInfoText == "N/A") and item then
        local required = item.reputationRequired
        if required and required ~= "" and required ~= "N/A" then
            local factionName = item.factionName
            if (not factionName or factionName == "") and item.factionID and HousingReputations then
                local cfg = HousingReputations[item.factionID]
                factionName = cfg and cfg.label or factionName
            end
            if factionName and factionName ~= "" then
                repInfoText = string.format("%s - %s", factionName, required)
            else
                repInfoText = required
            end
        end
    end
    if (not repInfoText or repInfoText == "" or repInfoText == "N/A") and itemID and HousingVendorItemToFaction and HousingReputations then
        local repLookup = HousingVendorItemToFaction[itemID]
        if repLookup then
            local cfg = HousingReputations[repLookup.factionID]
            if cfg and cfg.label and repLookup.requiredStanding then
                repInfoText = string.format("%s - %s", cfg.label, repLookup.requiredStanding)
            elseif repLookup.requiredStanding then
                repInfoText = repLookup.requiredStanding
            end
        end
    end

    local factionName, requiredStanding = nil, nil
    if repInfoText and repInfoText ~= "" and repInfoText ~= "N/A" then
        factionName, requiredStanding = repInfoText:match("^(.-)%s*%-%s*(.+)$")
        if factionName and requiredStanding then
            parsedReputation = repInfoText
        else
            -- Unknown formatting; still show the text as-is
            parsedReputation = repInfoText
            -- If the text is just a standing (e.g. "Revered"), still allow progress calc.
            if item and item.reputationRequired and repInfoText == item.reputationRequired then
                requiredStanding = item.reputationRequired
                factionName = item.factionName
                if (not factionName or factionName == "") and item.factionID and HousingReputations then
                    local cfg = HousingReputations[item.factionID]
                    factionName = cfg and cfg.label or factionName
                end
            end
        end
    elseif zone and zone:find("Faction:") then
        local actualZone, repInfo = zone:match("^(.-)%.?Faction:%s*(.+)$")
        if actualZone and repInfo then
            factionName, requiredStanding = repInfo:match("^(.-)%s*%-%s*(.+)$")
            parsedReputation = repInfo
            zone = actualZone
        end
    end

    -- Progress/validation uses the reputation lookup tables (by numeric itemID).
    if parsedReputation and HousingReputation and itemID and HousingVendorItemToFaction and HousingReputations then
        if HousingReputation.SnapshotReputation then
            pcall(HousingReputation.SnapshotReputation)
        end

        local repLookup = HousingVendorItemToFaction[itemID]
        if repLookup then
            local cfg = HousingReputations[repLookup.factionID]
            if cfg then
                if cfg.rep == "renown" then
                    isRenownRequirement = true
                end
                local bestRec = HousingReputation.GetBestRepRecord(repLookup.factionID)

                local current = nil
                if bestRec then
                    if cfg.rep == "renown" then
                        current = string.format("Renown %d", bestRec.renownLevel or 0)
                    elseif cfg.rep == "friendship" then
                        current = bestRec.reactionText or "Unknown"
                    elseif cfg.rep == "standard" then
                        local reactionNames = {"Hated", "Hostile", "Unfriendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted"}
                        current = reactionNames[bestRec.reaction] or "Unknown"
                    end
                end

                local required = requiredStanding
                local isUnlocked = HousingReputation.IsItemUnlocked(itemID)
                local labelName = factionName or (cfg and cfg.label) or "Reputation"
                local baseReputationText = (required and labelName) and string.format("%s - %s", labelName, required) or parsedReputation

                if required then
                    if isUnlocked then
                        parsedReputation = "|cFF00FF00" .. baseReputationText .. "|r"  -- Green for met
                        repProgress = { current = 1, max = 1, text = "Requirement Met" }
                    else
                        parsedReputation = "|cFFFF4040" .. baseReputationText .. "|r"  -- Red for not met

                        if cfg.rep == "renown" then
                            local requiredRenown = tonumber(required:match("Renown%s+(%d+)")) or 0
                            local currentRenown = (bestRec and bestRec.renownLevel) or 0
                            repProgress = {
                                current = currentRenown,
                                max = requiredRenown,
                                text = string.format("%d / %d", currentRenown, requiredRenown)
                            }
                        elseif cfg.rep == "standard" then
                            local reactionNames = {"Hated", "Hostile", "Unfriendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted"}
                            local requiredReaction = 0
                            for i, name in ipairs(reactionNames) do
                                if name == required then
                                    requiredReaction = i
                                    break
                                end
                            end

                            if requiredReaction > 0 then
                                local currentReaction = (bestRec and bestRec.reaction) or 0
                                repProgress = {
                                    current = currentReaction,
                                    max = requiredReaction,
                                    text = string.format("%s / %s", reactionNames[currentReaction] or "Unknown", required)
                                }
                            end
                        end
                    end
                end
            end
        end
    end

    -- Update vendor label/value based on source type.
    local vendorLabel = "Vendor:"
    if item then
        local sourceType = tostring(item._sourceType or "")
        local sourceTypes = item._sourceTypes
        local isQuest = (sourceType == "Quest") or (sourceTypes and sourceTypes["Quest"])
            or item._questId or item._questName or item._allQuests
        local isAchievement = (sourceType == "Achievement") or (sourceTypes and sourceTypes["Achievement"])
            or item._achievementId or item._achievementName or item._apiAchievement

        if sourceType == "Loot Drop" or sourceType == "Drop" or sourceType == "Reward" then
            vendorLabel = "Drops from:"
        elseif isQuest then
            vendorLabel = "Quest:"
            vendor = vendor or item._questName or item.title
        elseif isAchievement then
            vendorLabel = "Achievement:"
            vendor = vendor or item._achievementName or item._apiAchievement
        end
    end
    if previewFrame.vendorValue and previewFrame.vendorValue.label then
        previewFrame.vendorValue.label:SetText(vendorLabel)
    end

    previewFrame.SetFieldValue(previewFrame.vendorValue, vendor, previewFrame.vendorValue.label)

    -- FIX: Add Encounter Journal tooltip for boss drops
    if previewFrame.vendorValue and item and item.npcID and (item._sourceType == "Loot Drop" or item._sourceType == "Drop") then
        -- Store NPC ID for tooltip
        previewFrame.vendorValue._npcID = item.npcID
        previewFrame.vendorValue._npcName = vendor or item.npcName

        -- Add tooltip with encounter journal information
        if not previewFrame.vendorValue._hasEncounterTooltip then
            previewFrame.vendorValue:SetScript("OnEnter", function(self)
                if not self._npcID or not self._npcName then return end

                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(self._npcName, 1, 1, 1)
                GameTooltip:AddLine(" ")

                -- Try to get encounter info from Encounter Journal using NPC ID
                -- Note: The Encounter Journal API doesn't have a direct NPC ID -> Encounter ID lookup
                -- We can try to show NPC info and suggest opening the Encounter Journal
                if C_TooltipInfo and C_TooltipInfo.GetHyperlink then
                    local npcLink = "unit:Creature-0-0-0-0-" .. self._npcID
                    local tooltipData = C_TooltipInfo.GetHyperlink(npcLink)
                    if tooltipData and tooltipData.lines then
                        for _, line in ipairs(tooltipData.lines) do
                            if line.leftText and line.leftText ~= "" and line.leftText ~= self._npcName then
                                local r, g, b = 0.8, 0.8, 0.8
                                if line.leftColor then
                                    r, g, b = line.leftColor.r or r, line.leftColor.g or g, line.leftColor.b or b
                                end
                                GameTooltip:AddLine(line.leftText, r, g, b)
                            end
                        end
                    end
                end

                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("NPC ID: " .. self._npcID, 0.6, 0.6, 0.6)
                GameTooltip:AddLine("|cFFFFAA00Click to open Encounter Journal|r", 0.7, 0.7, 0.7)
                GameTooltip:Show()
            end)

            previewFrame.vendorValue:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)

            -- Make clickable to open Encounter Journal
            previewFrame.vendorValue:SetScript("OnMouseUp", function(self, button)
                if button == "LeftButton" and self._npcID then
                    -- Try to open Encounter Journal
                    if EncounterJournal_OpenJournal then
                        EncounterJournal_OpenJournal(nil, nil, self._npcID)
                    elseif ToggleEncounterJournal then
                        ToggleEncounterJournal()
                    end
                end
            end)

            -- Enable mouse interaction
            previewFrame.vendorValue:SetMouseClickEnabled(true)
            previewFrame.vendorValue._hasEncounterTooltip = true
        end
    elseif previewFrame.vendorValue and previewFrame.vendorValue._hasEncounterTooltip then
        -- Clear encounter tooltip for non-drop items
        previewFrame.vendorValue:SetScript("OnEnter", nil)
        previewFrame.vendorValue:SetScript("OnLeave", nil)
        previewFrame.vendorValue:SetScript("OnMouseUp", nil)
        previewFrame.vendorValue:SetMouseClickEnabled(false)
        previewFrame.vendorValue._hasEncounterTooltip = nil
        previewFrame.vendorValue._npcID = nil
        previewFrame.vendorValue._npcName = nil
    end

    local displayZone = zone
    if displayZone then
        -- Strip out color codes and formatting
        displayZone = displayZone:gsub("|c%x%x%x%x%x%x%x%x", "")
        displayZone = displayZone:gsub("|r", "")
        displayZone = displayZone:gsub("|H[^|]*|h", "")
        displayZone = displayZone:gsub("|h", "")
        displayZone = displayZone:gsub("|T[^|]*|t", "")
        displayZone = displayZone:gsub("|n", " ")

        -- Remove "Faction: ..." suffix if present (displayed separately in reputation field)
        displayZone = displayZone:gsub("%s*Faction:.-$", "")

        displayZone = displayZone:match("^%s*(.-)%s*$") or displayZone
    end
    
    previewFrame.SetFieldValue(previewFrame.zoneValue, displayZone, previewFrame.zoneValue.label)

    -- Auction House price (cached via AuctionHouseAPI scans/imports)
    -- Only show for profession items (craftable items that can be sold on AH)
    if previewFrame.ahPriceValue then
        local isProfessionItem = itemID and _G.HousingProfessionData and _G.HousingProfessionData[itemID]

        if isProfessionItem then
            local function FormatAge(seconds)
                seconds = math.max(0, tonumber(seconds) or 0)
                if seconds < 60 then
                    return string.format("%ds", seconds)
                end
                local mins = math.floor(seconds / 60)
                if mins < 60 then
                    return string.format("%dm", mins)
                end
                local hours = math.floor(mins / 60)
                mins = mins % 60
                if hours < 24 then
                    return string.format("%dh %dm", hours, mins)
                end
                local days = math.floor(hours / 24)
                hours = hours % 24
                return string.format("%dd %dh", days, hours)
            end

            local priceText = "|cFF909090Not cached|r"
            local tooltip = "No cached AH price for this item.\nRun Scan All / Scan Visible, or use Import Browse while viewing Housing -> Decor in the Auction House."

            local api = _G.HousingAuctionHouseAPI
            if itemID and api and api.GetCachedPrice then
                local price, cachedAt = api:GetCachedPrice(itemID)
                price = tonumber(price)
                cachedAt = tonumber(cachedAt)
                if price and price > 0 then
                    priceText = PreviewPanelData.Util.FormatMoneyFromCopper(price)
                    if cachedAt and cachedAt > 0 and _G.date and _G.time then
                        local age = _G.time() - cachedAt
                        tooltip = string.format("Last updated: %s\nAge: %s", _G.date("%Y-%m-%d %H:%M:%S", cachedAt), FormatAge(age))
                    else
                        tooltip = "Cached AH price (timestamp unavailable)."
                    end
                end
            end

            previewFrame.SetFieldValue(previewFrame.ahPriceValue, priceText, previewFrame.ahPriceValue.label)
            previewFrame.ahPriceValue.tooltipText = tooltip
        else
            -- Hide AH price for non-profession items
            previewFrame.SetFieldValue(previewFrame.ahPriceValue, nil, previewFrame.ahPriceValue.label)
        end
    end

    local costDisplay = cost
    if #costBreakdown > 0 then
        local displayParts = {}
        for i = 1, #costBreakdown do
            displayParts[i] = (costBreakdownIcons and costBreakdownIcons[i]) or costBreakdown[i]
        end
        costDisplay = table.concat(displayParts, " + ")
        item._costBreakdown = costBreakdown -- tooltip-friendly strings
        item._costBreakdownIcons = costBreakdownIcons
    elseif (not item or not item.cost or item.cost == "") and catalogData and (catalogData.costRaw or catalogData.cost) then
        local costText = catalogData.costRaw or catalogData.cost
        if type(costText) == "string" then
            local numeric = tonumber(costText)
            if numeric then
                table.insert(costBreakdown, PreviewPanelData.Util.FormatMoneyTooltipFromCopper(numeric))
                table.insert(costBreakdownIcons, PreviewPanelData.Util.FormatMoneyFromCopper(numeric))
            else
                for part in string.gmatch(costText, "[^,]+") do
                    local normalized = PreviewPanelData.Util.NormalizeCostString(part) or part
                    if normalized and normalized ~= "" then
                        table.insert(costBreakdown, normalized)
                        local iconOnly = part:match("|Hmoney:(%d+)|h")
                        if iconOnly then
                            table.insert(costBreakdownIcons, PreviewPanelData.Util.FormatMoneyFromCopper(iconOnly))
                        else
                            local currencyID = part:match("|Hcurrency:(%d+)")
                            if currencyID then
                                local amount = tonumber(part:match("(%d+)")) or 0
                                local icon = part:match("(|T[^|]*|t)") or PreviewPanelData.Util.GetCurrencyIconMarkup(currencyID)
                                if icon then
                                    table.insert(costBreakdownIcons, amount .. " " .. icon)
                                end
                            end
                        end
                    end
                end
            end
        end

        if #costBreakdown > 0 then
            local displayParts = {}
            for i = 1, #costBreakdown do
                displayParts[i] = (costBreakdownIcons and costBreakdownIcons[i]) or costBreakdown[i]
            end
            costDisplay = table.concat(displayParts, " + ")
            item._costBreakdown = costBreakdown -- tooltip-friendly strings
            item._costBreakdownIcons = costBreakdownIcons
        end
    elseif item and item.cost and item.cost ~= "" then
        costDisplay = ApplyStaticCostIcons(item.cost, item._staticCostComponents)
        item._costBreakdown = { costDisplay }
        item._costBreakdownIcons = nil
    end

    if item and item._staticCostComponents and costDisplay and costDisplay ~= "" then
        costDisplay = ApplyStaticCostIcons(costDisplay, item._staticCostComponents)
    end

    if costDisplay and costDisplay ~= "" and costDisplay ~= "N/A" then
        previewFrame.costValue:SetText(costDisplay)
        previewFrame.costValue:Show()
        if previewFrame.costValue.label then
            previewFrame.costValue.label:Show()
        end
        
        previewFrame.costValue:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("Cost Details", 1, 1, 1)
            
            if #costBreakdown > 0 then
                for _, costStr in ipairs(costBreakdown) do
                    local readable = costStr
                    if type(costStr) == "string" and costStr:find("|", 1, true) then
                        readable = PreviewPanelData.Util.NormalizeCostString(costStr) or PreviewPanelData.Util.CleanText(costStr) or costStr
                    end
                    GameTooltip:AddLine(readable, 1, 0.82, 0)
                end
            else
                GameTooltip:AddLine("No detailed cost information", 0.7, 0.7, 0.7)
            end
            
            GameTooltip:Show()
        end)
        
        previewFrame.costValue:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
        end)
    else
        previewFrame.SetFieldValue(previewFrame.costValue, nil, previewFrame.costValue.label)
    end
    
    previewFrame.SetFieldValue(previewFrame.reputationValue, parsedReputation, previewFrame.reputationValue.label)

    -- Update reputation progress bar
    if previewFrame.reputationBar then
        if repProgress and repProgress.max > 0 then
            local progress = math.min(repProgress.current / repProgress.max, 1)
            previewFrame.reputationBar:SetValue(progress)
            previewFrame.reputationBar.text:SetText(repProgress.text)

            -- Color: green if met, blue if in progress, red if far away
            if progress >= 1 then
                previewFrame.reputationBar:SetStatusBarColor(0.2, 0.8, 0.2, 1)
            elseif progress >= 0.5 then
                previewFrame.reputationBar:SetStatusBarColor(0.2, 0.6, 1, 1)
            else
                previewFrame.reputationBar:SetStatusBarColor(0.8, 0.3, 0.3, 1)
            end

            previewFrame.reputationBar:Show()

            -- Add tooltip with detailed reputation info
            if not previewFrame.reputationBar.hasTooltip then
                previewFrame.reputationBar:EnableMouse(true)
                previewFrame.reputationBar:SetScript("OnEnter", function(self)
                    local currentItemID = previewFrame and previewFrame._currentItem and tonumber(previewFrame._currentItem.itemID) or nil
                    if currentItemID and HousingReputation then
                        local repInfo = HousingVendorItemToFaction and HousingVendorItemToFaction[currentItemID]
                        if repInfo and HousingReputations then
                            local cfg = HousingReputations[repInfo.factionID]
                            if cfg then
                                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                                GameTooltip:SetText(cfg.label or "Reputation", 1, 1, 1)

                                local bestRec, bestCharKey = HousingReputation.GetBestRepRecord(repInfo.factionID)
                                if bestRec then
                                    if cfg.rep == "renown" then
                                        GameTooltip:AddLine(string.format("Current: Renown %d", bestRec.renownLevel or 0), 0.5, 0.8, 1)
                                        local requiredRenown = tonumber(repInfo.requiredStanding:match("Renown%s+(%d+)")) or 0
                                        GameTooltip:AddLine(string.format("Required: Renown %d", requiredRenown), 1, 1, 0.5)
                                    elseif cfg.rep == "standard" then
                                        local reactionNames = {"Hated", "Hostile", "Unfriendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted"}
                                        GameTooltip:AddLine(string.format("Current: %s", reactionNames[bestRec.reaction] or "Unknown"), 0.5, 0.8, 1)
                                        GameTooltip:AddLine(string.format("Required: %s", repInfo.requiredStanding), 1, 1, 0.5)
                                    elseif cfg.rep == "friendship" then
                                        GameTooltip:AddLine(string.format("Current: %s", bestRec.reactionText or "Unknown"), 0.5, 0.8, 1)
                                        GameTooltip:AddLine(string.format("Required: %s", repInfo.requiredStanding), 1, 1, 0.5)
                                    end

                                    -- Show which character has the best reputation (account-wide tracking)
                                    if bestCharKey then
                                        GameTooltip:AddLine(" ", 1, 1, 1)
                                        GameTooltip:AddLine("Best progress on: " .. bestCharKey, 0.7, 0.7, 0.7)
                                    end

                                    -- Also show this character's current progress (Blizzard API), when available.
                                    local thisCharText = nil
                                    local factionID = tonumber(repInfo.factionID)
                                    local reactionNames = {"Hated", "Hostile", "Unfriendly", "Neutral", "Friendly", "Honored", "Revered", "Exalted"}

                                    if factionID and cfg.rep == "standard" then
                                        if C_ReputationInfo and C_ReputationInfo.GetFactionDataByID then
                                            local ok, fd = pcall(C_ReputationInfo.GetFactionDataByID, factionID)
                                            if ok and fd then
                                                local standingID = tonumber(fd.reaction or fd.standingID)
                                                local standingText = reactionNames[standingID] or "Unknown"

                                                local cur = nil
                                                local max = nil
                                                if fd.currentReactionThreshold and fd.nextReactionThreshold and fd.currentStanding then
                                                    max = tonumber(fd.nextReactionThreshold) - tonumber(fd.currentReactionThreshold)
                                                    cur = tonumber(fd.currentStanding) - tonumber(fd.currentReactionThreshold)
                                                elseif fd.barMin and fd.barMax and fd.barValue then
                                                    max = tonumber(fd.barMax) - tonumber(fd.barMin)
                                                    cur = tonumber(fd.barValue) - tonumber(fd.barMin)
                                                end

                                                if max and max > 0 and cur ~= nil then
                                                    thisCharText = string.format("%s (%d/%d)", standingText, cur, max)
                                                else
                                                    thisCharText = standingText
                                                end
                                            end
                                        elseif _G.GetFactionInfoByID then
                                            local ok, _, _, standingID, barMin, barMax, barValue = pcall(_G.GetFactionInfoByID, factionID)
                                            if ok then
                                                local standingText = reactionNames[tonumber(standingID)] or "Unknown"
                                                if barMin and barMax and barValue then
                                                    thisCharText = string.format("%s (%d/%d)", standingText, tonumber(barValue) - tonumber(barMin), tonumber(barMax) - tonumber(barMin))
                                                else
                                                    thisCharText = standingText
                                                end
                                            end
                                        end
                                    elseif factionID and cfg.rep == "renown" then
                                        if C_MajorFactions and C_MajorFactions.GetMajorFactionData then
                                            local ok, mf = pcall(C_MajorFactions.GetMajorFactionData, factionID)
                                            if ok and mf then
                                                local lvl = tonumber(mf.renownLevel) or 0
                                                local cur = tonumber(mf.renownReputationEarned) or nil
                                                local max = tonumber(mf.renownLevelThreshold) or nil
                                                if max and max > 0 and cur then
                                                    thisCharText = string.format("Renown %d (%d/%d)", lvl, cur, max)
                                                else
                                                    thisCharText = string.format("Renown %d", lvl)
                                                end
                                            end
                                        end
                                    elseif factionID and cfg.rep == "friendship" then
                                        if C_GossipInfo and C_GossipInfo.GetFriendshipReputation then
                                            local ok, fr = pcall(C_GossipInfo.GetFriendshipReputation, factionID)
                                            if ok and fr then
                                                local standingText = fr.reaction or fr.reactionText or fr.standingText
                                                if type(standingText) ~= "string" or standingText == "" then
                                                    standingText = "Unknown"
                                                end
                                                local cur = tonumber(fr.standing) or tonumber(fr.friendshipFactionStanding) or tonumber(fr.rep) or nil
                                                local max = tonumber(fr.maxRep) or tonumber(fr.nextThreshold) or tonumber(fr.friendshipFactionMaxRep) or nil
                                                if max and max > 0 and cur then
                                                    thisCharText = string.format("%s (%d/%d)", standingText, cur, max)
                                                else
                                                    thisCharText = standingText
                                                end
                                            end
                                        elseif _G.GetFriendshipReputation then
                                            local ok, _, _, standingText, barMin, barMax, barValue = pcall(_G.GetFriendshipReputation, factionID)
                                            if ok then
                                                if barMin and barMax and barValue then
                                                    thisCharText = string.format("%s (%d/%d)", standingText or "Unknown", tonumber(barValue) - tonumber(barMin), tonumber(barMax) - tonumber(barMin))
                                                else
                                                    thisCharText = standingText or "Unknown"
                                                end
                                            end
                                        end
                                    end

                                    if thisCharText then
                                        GameTooltip:AddLine(" ", 1, 1, 1)
                                        GameTooltip:AddLine("This character: " .. thisCharText, 0.7, 0.7, 0.7)
                                    end
                                end

                                GameTooltip:Show()
                            end
                        end
                    end
                end)
                previewFrame.reputationBar:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)
                previewFrame.reputationBar.hasTooltip = true
            end
        else
            previewFrame.reputationBar:Hide()
        end
    end

    local renownText = catalogData.renown
    if isRenownRequirement and repProgress then
        renownText = nil
    end
    previewFrame.SetFieldValue(previewFrame.renownValue, renownText, previewFrame.renownValue.label)
    
    -- If the profession block already configured a trainer waypoint, don't hide/override it here.
    local hasTrainerWaypoint = previewFrame._waypointContext == "trainer" and previewFrame._waypointInfo ~= nil
    if not hasTrainerWaypoint then
        if coordsText and coordsText ~= "" then
            -- Use the pre-extracted waypoint coordinates we gathered earlier
            if waypointX and waypointY and waypointMapID then
                previewFrame.mapBtn:Show()
                local npcID = item and item.npcID
                if _G.HousingVendorHelper and _G.HousingVendorHelper.GetVendorNPCID then
                    local Filters = _G.HousingFilters
                    local filterVendor = Filters and Filters.currentFilters and Filters.currentFilters.vendor or nil
                    local filterZone = Filters and Filters.currentFilters and Filters.currentFilters.zone or nil
                    local filterMapID = Filters and Filters.currentFilters and Filters.currentFilters.zoneMapID or nil
                    npcID = _G.HousingVendorHelper:GetVendorNPCID(item, filterVendor, filterZone, filterMapID)
                end

                previewFrame._vendorInfo = {
                    name = vendor,
                    vendorName = vendor,
                    zoneName = zone,
                    expansionName = item.expansionName,
                    coords = {
                        x = waypointX,
                        y = waypointY,
                        mapID = waypointMapID
                    },
                    x = waypointX,
                    y = waypointY,
                    mapID = waypointMapID,
                    itemID = item.itemID,
                    npcID = npcID
                }
            else
                previewFrame.mapBtn:Hide()
            end
        else
            previewFrame.mapBtn:Hide()
        end
    end
    
    previewFrame.UpdateHeaderVisibility(previewFrame.vendorHeader, {
        previewFrame.vendorValue,
        previewFrame.costValue,
        previewFrame.ahPriceValue,
        previewFrame.factionValue,
        previewFrame.reputationValue,
        previewFrame.renownValue,
        previewFrame.expansionValue,
        previewFrame.zoneValue
    })
end

function PreviewPanelData:DisplayProfessionInfo(previewFrame, item, catalogData)
    local professionName = item.profession
    local professionText = nil
    local professionSkillText = nil
    local professionRecipeText = nil
    local professionRecipeLabel = "Recipe:"
    
    if item.profession then
        if item.professionSkillNeeded and item.professionSkillNeeded > 0 then
            local professionID = (C_TradeSkillUI and C_TradeSkillUI.GetTradeSkillLine) and C_TradeSkillUI.GetTradeSkillLine() or nil
            local currentSkill, maxSkill = 0, 0
            
            if professionID and C_TradeSkillUI.GetProfessionSkillLine then
                local skillLineInfo = C_TradeSkillUI.GetProfessionSkillLine(professionID)
                if skillLineInfo then
                    currentSkill = skillLineInfo.skillLineCurrentLevel or 0
                    maxSkill = skillLineInfo.skillLineMaxLevel or 0
                end
            end
            
            if currentSkill >= item.professionSkillNeeded then
                if item.professionSkill then
                    professionSkillText = item.professionSkill .. " - Level " .. item.professionSkillNeeded .. " |cFF00FF00(Have " .. currentSkill .. "/" .. maxSkill .. ")|r"
                else
                    professionSkillText = "Level " .. item.professionSkillNeeded .. " |cFF00FF00(Have " .. currentSkill .. "/" .. maxSkill .. ")|r"
                end
            elseif currentSkill > 0 then
                if item.professionSkill then
                    professionSkillText = item.professionSkill .. " - Level " .. item.professionSkillNeeded .. " |cFFFF0000(Need " .. item.professionSkillNeeded .. ", currently " .. currentSkill .. "/" .. maxSkill .. ")|r"
                else
                    professionSkillText = "Level " .. item.professionSkillNeeded .. " |cFFFF0000(Need " .. item.professionSkillNeeded .. ", currently " .. currentSkill .. "/" .. maxSkill .. ")|r"
                end
            elseif item.professionSkill then
                professionSkillText = item.professionSkill .. " - Level " .. item.professionSkillNeeded
            else
                professionSkillText = "Level " .. item.professionSkillNeeded
            end
        elseif item.professionSkill then
            professionSkillText = item.professionSkill
        end

        local itemID = tonumber(item.itemID)
        local hv = _G.HousingVendor
        local pr = hv and hv.ProfessionReagents
        local hasReagents = pr and pr.HasReagents and itemID and pr:HasReagents(itemID) or false

        local known = nil
        if hasReagents then
            known = pr and pr.IsRecipeKnown and pr:IsRecipeKnown(itemID) or nil
        end

        -- Prefer showing trainer guidance when we can't reliably detect recipe state.
        if hasReagents and known == nil then
            local pt = hv and hv.ProfessionTrainers
            local trainer = pt and pt.GetTrainerForItem and pt:GetTrainerForItem(itemID, item) or nil
            local trainerName = trainer and trainer.name or nil
            local trainerLocation = trainer and trainer.location or nil

            if trainerName or trainerLocation then
                -- If we have trainer coordinates, point the waypoint button at the trainer (profession items only).
                local coords = trainer and trainer.coords or nil
                local x = coords and tonumber(coords.x) or nil
                local y = coords and tonumber(coords.y) or nil
                local mapID = coords and tonumber(coords.mapID) or nil
                if previewFrame.mapBtn and x and y and mapID and x > 0 and y > 0 then
                    previewFrame.mapBtn:Show()
                    previewFrame._waypointContext = "trainer"
                    previewFrame._waypointInfo = {
                        name = trainerName or "Trainer",
                        vendorName = trainerName or "Trainer",
                        zoneName = trainerLocation,
                        expansionName = item.professionSkill or item._apiExpansion or nil,
                        coords = { x = x, y = y, mapID = mapID },
                        x = x,
                        y = y,
                        mapID = mapID,
                        itemID = item.itemID,
                        npcID = nil,
                    }
                end
            end
        elseif hasReagents and known ~= nil then
            professionRecipeLabel = "Recipe:"
            professionRecipeText = known and "Recipe Known" or "Recipe Unknown"
        end

        -- Fallback: actual recipe/spell name if we didn't set trainer/known text above.
        if not professionRecipeText then
            if item.professionSpellID then
            local spellInfo = C_Spell and C_Spell.GetSpellInfo and C_Spell.GetSpellInfo(item.professionSpellID)
            if spellInfo and spellInfo.name then
                professionRecipeText = spellInfo.name
            end
            elseif item.professionRecipeID then
            if C_TradeSkillUI and C_TradeSkillUI.GetRecipeInfo then
                local recipeInfo = C_TradeSkillUI.GetRecipeInfo(item.professionRecipeID)
                if recipeInfo and recipeInfo.name then
                    professionRecipeText = recipeInfo.name
                end
            end
            end
        end

        professionText = professionName
        if professionSkillText then
            professionText = professionText .. " (" .. professionSkillText .. ")"
        end
        if professionRecipeText then
            professionText = professionText .. "\n" .. professionRecipeText
        end
    elseif catalogData.profession then
        professionName = catalogData.profession
        professionText = catalogData.profession
    end
    
    previewFrame.SetFieldValue(previewFrame.professionValue, professionName, previewFrame.professionValue.label)
    previewFrame.SetFieldValue(previewFrame.professionSkillValue, professionSkillText, previewFrame.professionSkillValue.label)
    previewFrame.SetFieldValue(previewFrame.professionRecipeValue, professionRecipeText, previewFrame.professionRecipeValue.label)
    if previewFrame.professionRecipeValue and previewFrame.professionRecipeValue.label and previewFrame.professionRecipeValue.label.SetText then
        previewFrame.professionRecipeValue.label:SetText(professionRecipeLabel)
        -- Keep the value column aligned with the "Profession:" line, even when the label is shorter ("Trainer:").
        local baseLabel = previewFrame.professionValue and previewFrame.professionValue.label or nil
        if baseLabel and baseLabel.GetStringWidth and previewFrame.professionRecipeValue.label.SetWidth then
            local w = tonumber(baseLabel:GetStringWidth()) or nil
            if w and w > 0 then
                previewFrame.professionRecipeValue.label:SetWidth(w + 2)
            end
        end
    end

    self:DisplayReagents(previewFrame, item)
    
    previewFrame.UpdateHeaderVisibility(previewFrame.professionHeader, {
        previewFrame.professionValue,
        previewFrame.professionSkillValue,
        previewFrame.professionRecipeValue,
        previewFrame.reagentsContainer
    })
end

function PreviewPanelData:DisplayReagents(previewFrame, item)
    local itemID = tonumber(item.itemID)
    local reagentData = itemID and HousingVendor.ProfessionReagents and HousingVendor.ProfessionReagents:GetReagents(itemID)
    
    local textPrimary = HousingTheme.Colors.textPrimary
    local accentPrimary = HousingTheme.Colors.accentPrimary
    local textSecondary = HousingTheme.Colors.textSecondary
    local accentGold = HousingTheme.Colors.accentGold
    local api = _G.HousingAuctionHouseAPI
    local formatMoney = PreviewPanelData and PreviewPanelData.Util and PreviewPanelData.Util.FormatMoneyFromCopper

    if previewFrame.reagentsContainer then
        previewFrame.reagentsContainer:Hide()
        if previewFrame.reagentsContainer.header then
            previewFrame.reagentsContainer.header:Hide()
        end
        if previewFrame.reagentsContainer.priceHeader then
            previewFrame.reagentsContainer.priceHeader:Hide()
        end
        for _, line in pairs(previewFrame.reagentsContainer.lines or {}) do
            if line and line.Hide then
                line:Hide()
            end
        end
        for _, line in pairs(previewFrame.reagentsContainer.priceLines or {}) do
            if line and line.Hide then
                line:Hide()
            end
        end
    end
    
    local hasReagents = reagentData and reagentData.reagents and #reagentData.reagents > 0
    if previewFrame.materialsBtn then
        if hasReagents then
            previewFrame.materialsBtn:Show()
        else
            previewFrame.materialsBtn:Hide()
        end
    end

    if hasReagents then
        if not previewFrame.reagentsContainer then
            local container = CreateFrame("Frame", nil, previewFrame.details)
            container:SetPoint("LEFT", previewFrame.details, "LEFT", 0, 0)
            container:SetPoint("RIGHT", previewFrame.details, "RIGHT", 0, 0)
            container:SetHeight(1)
            container.lines = {}
            container.priceLines = {}
            previewFrame.reagentsContainer = container
        end
        
        local container = previewFrame.reagentsContainer
        -- Positioning is now handled by RelayoutProfessionAndRequirements in PreviewPanelUI
        -- Don't override the positioning here
        container:Show()
        
        if not container.header then
            local header = previewFrame.details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            header:SetPoint("TOPLEFT", container, "TOPLEFT", 0, 0)
            header:SetWidth(180)
            header:SetJustifyH("LEFT")
            header:SetText("Reagents:")
            header:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
            container.header = header
        end
        container.header:Show()

        if not container.priceHeader then
            local header = previewFrame.details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            header:SetPoint("TOPLEFT", container, "TOPLEFT", 165, 0)  -- Position to the right of reagent names (moved left for more price space)
            header:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, 0)
            header:SetJustifyH("LEFT")
            header:SetText("AH Price:(Total)")
            header:SetTextColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
            container.priceHeader = header
        end
        container.priceHeader:Show()

        local yOffset = -18
        local lineStep = 22

        for i, reagent in ipairs(reagentData.reagents) do
            -- Support both field naming conventions: id/amount and itemID/count
            local reagentID = reagent.id or reagent.itemID
            local reagentAmount = reagent.amount or reagent.count or 1

            if C_Item and C_Item.RequestLoadItemDataByID and reagentID then
                pcall(C_Item.RequestLoadItemDataByID, reagentID)
            end

            if not container.lines[i] then
                local line = previewFrame.details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                line:SetJustifyH("LEFT")
                line:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
                container.lines[i] = line
            end
            if not container.priceLines[i] then
                -- Use a larger font so embedded coin textures are readable.
                local line = previewFrame.details:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                line:SetJustifyH("LEFT")  -- Changed from RIGHT to LEFT
                line:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
                container.priceLines[i] = line
            end

            local line = container.lines[i]
            local priceLine = container.priceLines[i]
            line:ClearAllPoints()
            line:SetPoint("TOPLEFT", container.header, "BOTTOMLEFT", 0, yOffset)
            line:SetWidth(155)  -- Reduced width to give more space for prices
            priceLine:ClearAllPoints()
            priceLine:SetPoint("TOPLEFT", container.priceHeader, "BOTTOMLEFT", 0, yOffset)
            priceLine:SetPoint("TOPRIGHT", container, "TOPRIGHT", 0, yOffset)
            
            local reagentName = reagent.itemName  -- Use cached name if available
            if not reagentName and C_Item and C_Item.GetItemNameByID then
                reagentName = C_Item.GetItemNameByID(reagentID)
            end

            if not reagentName and C_Item and C_Item.GetItemInfo then
                reagentName = C_Item.GetItemInfo(reagentID)
            end

            if not reagentName then
                reagentName = "Loading..."
                if C_Item and C_Item.RequestLoadItemDataByID then
                    pcall(C_Item.RequestLoadItemDataByID, reagentID)
                end
                local capturedID = reagentID
                local capturedAmount = reagentAmount
                C_Timer.After(0.5, function()
                    local name = capturedID and C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(capturedID)
                    if name and line and capturedAmount then
                        line:SetText(capturedAmount .. "x " .. name)
                    end
                end)
            end

            line:SetText(reagentAmount .. "x " .. reagentName)
            line:Show()

            local unitPrice = nil
            if api and api.GetOrFetchAddonPrice then
                local p = select(1, api:GetOrFetchAddonPrice(reagentID))
                p = tonumber(p)
                if p and p > 0 then
                    unitPrice = p
                end
            elseif api and api.GetCachedPrice then
                local p = api:GetCachedPrice(reagentID)
                p = tonumber(p)
                if p and p > 0 then
                    unitPrice = p
                end
            end

            if unitPrice and formatMoney then
                local total = unitPrice * reagentAmount
                priceLine:SetTextColor(accentGold[1], accentGold[2], accentGold[3], 1)
                priceLine:SetText(formatMoney(unitPrice) .. " (" .. formatMoney(total) .. ")")
            else
                priceLine:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
                priceLine:SetText("|cFF909090No price|r")
            end
            priceLine:Show()
            yOffset = yOffset - lineStep
        end
        
        for i = #reagentData.reagents + 1, #container.lines do
            container.lines[i]:Hide()
        end
        for i = #reagentData.reagents + 1, #(container.priceLines or {}) do
            container.priceLines[i]:Hide()
        end

        container:SetHeight(math.abs(yOffset) + lineStep)
    end
end

function PreviewPanelData:DisplayRequirements(previewFrame, item, catalogData)
    -- Use BOTH static and API sources for quest info:
    -- - Prefer readable static quest text when available
    -- - Fall back to API when missing or when static is just a numeric placeholder
    local function IsNumericPlaceholder(text)
        return type(text) == "string" and text:match("^%d+$") ~= nil
    end

    local staticQuestText = item and (item._questName or item.title) or nil
    if IsNumericPlaceholder(staticQuestText) then
        staticQuestText = nil
    end

    local apiQuestText = nil
    if item and item._apiQuest and item._apiQuest ~= "" then
        apiQuestText = item._apiQuest
    elseif catalogData and catalogData.quest and catalogData.quest ~= "" then
        apiQuestText = catalogData.quest
    end

    local questID = item and (item._questId or item.questRequired or item.questID) or nil
    if (not questID or questID == "") and catalogData and catalogData.questID then
        questID = catalogData.questID
    end

    -- If multiple quests exist for this item, prefer the first quest that has quest giver NPC info,
    -- so the preview panel can show a correct quest giver + waypoint.
    if item and item._allQuests and type(item._allQuests) == "table" and #item._allQuests > 0 and _G.HousingQuestNPCs then
        for _, q in ipairs(item._allQuests) do
            local qid = q and (q.questId or q.questID) or nil
            local numericQID = tonumber(qid)
            if numericQID and _G.HousingQuestNPCs[numericQID] then
                questID = numericQID
                break
            end
        end
    end

    -- Fallback: if we have multiple quest sources, use the first one for display.
    if (not staticQuestText or staticQuestText == "") and item and item._allQuests and type(item._allQuests) == "table" then
        local first = item._allQuests[1]
        if first and type(first) == "table" then
            local t = first.title or first.questName
            if not IsNumericPlaceholder(t) and t and t ~= "" then
                staticQuestText = t
            end
            questID = first.questId or first.questID or questID
        end
    end

    local questText = (staticQuestText and staticQuestText ~= "") and staticQuestText or apiQuestText

    -- If we have a quest ID but no readable quest name, try to get it from WoW API
    local numQuestID = tonumber(questID)
    if numQuestID and (not questText or questText == "" or IsNumericPlaceholder(questText)) then
        -- Request quest data to be loaded (async)
        if C_QuestLog and C_QuestLog.RequestLoadQuestByID then
            pcall(C_QuestLog.RequestLoadQuestByID, numQuestID)
        end
        -- Try to get the quest title
        if C_QuestLog and C_QuestLog.GetTitleForQuestID then
            local ok, title = pcall(C_QuestLog.GetTitleForQuestID, numQuestID)
            if ok and title and title ~= "" then
                questText = title
            end
        end
        -- If still no text, show "Quest #ID" as fallback
        if not questText or questText == "" or IsNumericPlaceholder(questText) then
            questText = "Quest #" .. numQuestID
        end
    end

    local function NormalizeTooltipText(s)
        if not s or s == "" then return nil end
        if PreviewPanelData and PreviewPanelData.Util and PreviewPanelData.Util.CleanText then
            s = PreviewPanelData.Util.CleanText(s)
        end
        s = tostring(s or ""):gsub("%s+", " "):match("^%s*(.-)%s*$")
        if s == "" then return nil end
        return s
    end

    local staticForTooltip = NormalizeTooltipText(staticQuestText)
    local apiForTooltip = NormalizeTooltipText(apiQuestText)
    if previewFrame.questValue then
        previewFrame.questValue.tooltipText = nil
        if staticForTooltip and apiForTooltip and staticForTooltip ~= apiForTooltip then
            previewFrame.questValue.tooltipText = "Quest sources:\nStatic: " .. staticForTooltip .. "\nAPI: " .. apiForTooltip
        end
    end
    -- Check each source explicitly to handle empty strings properly
    local achievementText = nil
    local achievementID = item._achievementId or (catalogData and catalogData.achievementID) or item.achievementRequired

    if item._apiAchievement and item._apiAchievement ~= "" then
        achievementText = item._apiAchievement
    elseif catalogData and catalogData.achievement and catalogData.achievement ~= "" then
        achievementText = catalogData.achievement
    elseif item._achievementName and item._achievementName ~= "" then
        achievementText = item._achievementName
    elseif achievementID then
        -- Fallback: If we have an achievement ID but no name, try to get name from WoW API
        local numAchID = tonumber(achievementID)
        if numAchID then
            local achName = nil
            -- Try C_AchievementInfo first (returns struct with .name field)
            if C_AchievementInfo and C_AchievementInfo.GetAchievementInfo then
                local ok, achInfo = pcall(C_AchievementInfo.GetAchievementInfo, numAchID)
                if ok and achInfo and achInfo.name and achInfo.name ~= "" then
                    achName = achInfo.name
                end
            end
            -- Fallback to legacy GetAchievementInfo (returns multiple values: id, name, ...)
            if not achName and GetAchievementInfo then
                local ok, _, name = pcall(GetAchievementInfo, numAchID)
                if ok and name and name ~= "" then
                    achName = name
                end
            end
            achievementText = achName or ("Achievement #" .. numAchID)
        else
            achievementText = "Achievement #" .. tostring(achievementID)
        end
    end
    local eventText = catalogData.event
    local classText = catalogData.class
    local raceText = catalogData.race
    
    if questText and questText ~= "" and questText ~= "N/A" then
        local questStatus = ""
        local numericQuestID = tonumber(questID)
        if not numericQuestID and type(questID) == "string" then
            numericQuestID = tonumber(string.match(questID, "%d+"))
        end
        if numericQuestID and C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
            local ok, isComplete = pcall(C_QuestLog.IsQuestFlaggedCompleted, numericQuestID)
            if ok and isComplete then
                questStatus = " |cFF00FF00(Completed)|r"
            elseif ok and not isComplete then
                questStatus = " |cFFFF0000(Not Completed)|r"
            end
        end

        previewFrame.questValue:SetText(questText .. questStatus)
        previewFrame.questValue:Show()
        if previewFrame.questValue.label then previewFrame.questValue.label:Show() end

        -- If we had to fall back to "Quest #ID", update the UI once the quest title loads (async).
        if numericQuestID and (questText:match("^Quest%s+#%d+") or IsNumericPlaceholder(questText)) then
            local resolver = _G.HousingQuestTitleResolver
            if resolver and resolver.GetTitle then
                resolver:GetTitle(numericQuestID, function(title)
                    if not previewFrame or not previewFrame.questValue then return end
                    if not previewFrame.IsShown or not previewFrame:IsShown() then return end
                    if not previewFrame._currentItem or not item or not item.itemID then return end
                    if tonumber(previewFrame._currentItem.itemID) ~= tonumber(item.itemID) then return end

                    local updatedStatus = ""
                    if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
                        local ok, isComplete = pcall(C_QuestLog.IsQuestFlaggedCompleted, numericQuestID)
                        if ok and isComplete then
                            updatedStatus = " |cFF00FF00(Completed)|r"
                        elseif ok and not isComplete then
                            updatedStatus = " |cFFFF0000(Not Completed)|r"
                        end
                    end

                    previewFrame.questValue:SetText(title .. updatedStatus)
                end)
            end
        end

        -- Add quest NPC info to panel and tooltip if available
        if numericQuestID and _G.HousingQuestNPCs then
            local npcInfo = _G.HousingQuestNPCs[numericQuestID]
            if npcInfo and npcInfo.npcName and npcInfo.npcName ~= "" and npcInfo.npcName ~= "Unknown" and npcInfo.npcName ~= "Vendor/Drop" then
                local hasValidCoords = npcInfo.coords and npcInfo.coords.x and npcInfo.coords.y and npcInfo.coords.mapID and npcInfo.coords.mapID ~= 0
                local zoneName = nil
                if hasValidCoords then
                    if C_Map and C_Map.GetMapInfo then
                        local ok, mapInfo = pcall(C_Map.GetMapInfo, npcInfo.coords.mapID)
                        if ok and mapInfo and mapInfo.name then
                            zoneName = mapInfo.name
                        end
                    end
                end

                -- Display quest giver in the panel
                if previewFrame.questGiverValue then
                    local questGiverDisplay = npcInfo.npcName
                    if npcInfo.faction and npcInfo.faction ~= "Both" then
                        questGiverDisplay = questGiverDisplay .. " |cFF888888[" .. npcInfo.faction .. "]|r"
                    end
                    previewFrame.questGiverValue:SetText(questGiverDisplay)
                    previewFrame.questGiverValue:Show()
                    if previewFrame.questGiverValue.label then
                        previewFrame.questGiverValue.label:Show()
                    end

                    -- Add tooltip with location details
                    if hasValidCoords then
                        local tooltipText = npcInfo.npcName
                        if zoneName then
                            tooltipText = tooltipText .. string.format("\n|cFFAAAAAA%s (%.1f, %.1f)|r", zoneName, npcInfo.coords.x, npcInfo.coords.y)
                            tooltipText = tooltipText .. string.format("\n|cFFAAAAAA/way %s %.1f %.1f|r", zoneName, npcInfo.coords.x, npcInfo.coords.y)
                        else
                            tooltipText = tooltipText .. string.format("\n|cFFAAAAAA(%.1f, %.1f)|r", npcInfo.coords.x, npcInfo.coords.y)
                        end
                        previewFrame.questGiverValue.tooltipText = tooltipText
                    end

                    -- Store NPC data for potential waypoint functionality
                    previewFrame.questGiverValue._questNPCInfo = npcInfo
                    previewFrame.questGiverValue._questID = numericQuestID
                end

                -- Set up waypoint for quest NPC if no vendor waypoint exists and coords are valid
                if hasValidCoords and previewFrame.mapBtn and not previewFrame._vendorInfo then
                    previewFrame.mapBtn:Show()
                    previewFrame._waypointContext = "questNPC"
                    previewFrame._waypointInfo = {
                        name = npcInfo.npcName,
                        vendorName = npcInfo.npcName,
                        zoneName = zoneName,
                        expansionName = item and item.expansionName or nil,
                        coords = {
                            x = npcInfo.coords.x,
                            y = npcInfo.coords.y,
                            mapID = npcInfo.coords.mapID
                        },
                        x = npcInfo.coords.x,
                        y = npcInfo.coords.y,
                        mapID = npcInfo.coords.mapID,
                        itemID = item and item.itemID or nil,
                        npcID = npcInfo.npcID
                    }
                end
            else
                -- Hide quest giver field if no valid NPC info
                if previewFrame.questGiverValue then
                    previewFrame.SetFieldValue(previewFrame.questGiverValue, nil, previewFrame.questGiverValue.label)
                end
            end
        else
            -- Hide quest giver field if no quest ID
            if previewFrame.questGiverValue then
                previewFrame.SetFieldValue(previewFrame.questGiverValue, nil, previewFrame.questGiverValue.label)
            end
        end
    else
        previewFrame.SetFieldValue(previewFrame.questValue, nil, previewFrame.questValue.label)
        if previewFrame.questGiverValue then
            previewFrame.SetFieldValue(previewFrame.questGiverValue, nil, previewFrame.questGiverValue.label)
        end
    end

    -- Achievement display with progress tracking
    if achievementText and achievementText ~= "" and achievementText ~= "N/A" then
        local isCompleted = false
        local achievementDate = nil
        local criteriaProgress = nil
        local criteriaDetails = nil

        if achievementID then
            local completion = HousingAPI and HousingAPI.GetAchievementCompletion and HousingAPI:GetAchievementCompletion(achievementID) or nil
            if completion then
                isCompleted = completion.completed
                achievementDate = completion.date or completion.completionDate or nil
            elseif C_AchievementInfo and C_AchievementInfo.GetAchievementInfo then
                local ok, achInfo = pcall(C_AchievementInfo.GetAchievementInfo, achievementID)
                if ok and achInfo then
                    isCompleted = achInfo.completed
                    if isCompleted then
                        achievementDate = achInfo.dateCompleted or achievementDate
                        if not achievementDate and achInfo.month and achInfo.day and achInfo.year then
                            local year = tonumber(achInfo.year)
                            if year and year > 0 and year < 100 then year = 2000 + year end
                            if year and year >= 1900 then
                                achievementDate = string.format("%02d/%02d/%04d", tonumber(achInfo.month) or 0, tonumber(achInfo.day) or 0, year)
                            end
                        end
                    end
                end
            end

            -- Get criteria progress
            if C_AchievementInfo and C_AchievementInfo.GetAchievementNumCriteria then
                local numCriteria = C_AchievementInfo.GetAchievementNumCriteria(achievementID)
                if numCriteria and numCriteria > 0 then
                    local completedCount = 0
                    criteriaDetails = {}

                    for i = 1, numCriteria do
                        if C_AchievementInfo.GetAchievementCriteriaInfo then
                            local criteriaString, criteriaType, completed, quantity, reqQuantity =
                                C_AchievementInfo.GetAchievementCriteriaInfo(achievementID, i)

                            if completed then
                                completedCount = completedCount + 1
                            end

                            -- Store criteria details for tooltip
                            table.insert(criteriaDetails, {
                                description = criteriaString or "Criterion " .. i,
                                completed = completed,
                                quantity = quantity or 0,
                                reqQuantity = reqQuantity or 0
                            })
                        end
                    end

                    criteriaProgress = {
                        completed = completedCount,
                        total = numCriteria,
                        percentage = (completedCount / numCriteria) * 100
                    }
                end
            end
        end

        local displayText = achievementText
        if isCompleted then
            displayText = displayText .. " |cFF00FF00(Completed)|r"
            if achievementDate and achievementDate ~= "" then
                displayText = displayText .. " - " .. tostring(achievementDate)
            end
        elseif criteriaProgress then
            displayText = displayText .. string.format(" |cFFFFAA00(%d/%d)|r", criteriaProgress.completed, criteriaProgress.total)
        else
            displayText = displayText .. " |cFFFF0000(Not Completed)|r"
        end

        -- Points omitted (low value/noisy for this addon)

        previewFrame.achievementValue:SetText(displayText)
        previewFrame.achievementValue:Show()
        if previewFrame.achievementValue.label then previewFrame.achievementValue.label:Show() end

        -- Add tooltip with detailed criteria
        if criteriaDetails and #criteriaDetails > 0 then
            if not previewFrame.achievementValue.hasTooltip then
                previewFrame.achievementValue:SetScript("OnEnter", function(self)
                    if not previewFrame._achievementCriteriaDetails then return end

                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    GameTooltip:SetText("Achievement Progress", 1, 1, 1)
                    GameTooltip:AddLine(" ")

                    local achievementID = tonumber(previewFrame._achievementId)
                    if achievementID then
                        local earnedBy = nil
                        local dateText = nil
                        local completed = nil

                        local completion = HousingAPI and HousingAPI.GetAchievementCompletion and HousingAPI:GetAchievementCompletion(achievementID) or nil
                        if completion then
                            completed = completion.completed
                            earnedBy = completion.earnedBy or completion.earnedByCharacter or earnedBy
                            dateText = completion.date or completion.completionDate or dateText
                        end

                        if C_AchievementInfo and C_AchievementInfo.GetAchievementInfo then
                            local ok, achInfo = pcall(C_AchievementInfo.GetAchievementInfo, achievementID)
                            if ok and achInfo then
                                completed = achInfo.completed
                                earnedBy = achInfo.earnedBy or achInfo.earnedByCharacter or achInfo.earnedByName or earnedBy
                                dateText = achInfo.dateCompleted or dateText
                                if not dateText and completed and achInfo.month and achInfo.day and achInfo.year then
                                    local year = tonumber(achInfo.year)
                                    if year and year > 0 and year < 100 then year = 2000 + year end
                                    if year and year >= 1900 then
                                        dateText = string.format("%02d/%02d/%04d", tonumber(achInfo.month) or 0, tonumber(achInfo.day) or 0, year)
                                    end
                                end
                            end
                        elseif _G.GetAchievementInfo then
                            local ok, _, _, _, c, month, day, year, _, _, _, _, _, _, e = pcall(_G.GetAchievementInfo, achievementID)
                            if ok then
                                completed = c
                                earnedBy = e or earnedBy
                                if completed and month and day and year then
                                    local y = tonumber(year)
                                    if y and y > 0 and y < 100 then y = 2000 + y end
                                    if y and y >= 1900 then
                                        dateText = string.format("%02d/%02d/%04d", tonumber(month) or 0, tonumber(day) or 0, y)
                                    end
                                end
                            end
                        end

                        if completed ~= nil then
                            if completed then
                                GameTooltip:AddLine("Completed", 0, 1, 0)
                            else
                                GameTooltip:AddLine("Not Completed", 1, 0.25, 0.25)
                            end
                        end
                        if dateText and dateText ~= "" then
                            GameTooltip:AddLine("Date: " .. tostring(dateText), 0.7, 0.7, 0.7)
                        end
                        if earnedBy and type(earnedBy) == "string" and earnedBy ~= "" then
                            GameTooltip:AddLine("Earned by: " .. earnedBy, 0.7, 0.7, 0.7)
                        end

                        GameTooltip:AddLine(" ")
                    end

                    for i, criteria in ipairs(previewFrame._achievementCriteriaDetails) do
                        local color = criteria.completed and "|cFF00FF00" or "|cFFFF0000"
                        local statusText = criteria.completed and "✓" or "✗"

                        if criteria.reqQuantity > 0 then
                            GameTooltip:AddLine(
                                string.format("%s %s (%d/%d)", statusText, criteria.description, criteria.quantity, criteria.reqQuantity),
                                0.7, 0.7, 0.7
                            )
                        else
                            GameTooltip:AddLine(
                                string.format("%s %s", statusText, criteria.description),
                                0.7, 0.7, 0.7
                            )
                        end
                    end

                    GameTooltip:Show()
                end)
                previewFrame.achievementValue:SetScript("OnLeave", function()
                    GameTooltip:Hide()
                end)
                previewFrame.achievementValue.hasTooltip = true
            end
            previewFrame._achievementCriteriaDetails = criteriaDetails
        end

        -- Show progress bar if we have criteria progress
        if previewFrame.achievementBar and criteriaProgress and not isCompleted then
            previewFrame.achievementBar:Show()
            previewFrame.achievementBar:SetMinMaxValues(0, criteriaProgress.total)
            previewFrame.achievementBar:SetValue(criteriaProgress.completed)

            -- Set bar text
            if previewFrame.achievementBar.text then
                previewFrame.achievementBar.text:SetText(
                    string.format("%d/%d (%.0f%%)", criteriaProgress.completed, criteriaProgress.total, criteriaProgress.percentage)
                )
            end

            -- Color the bar based on progress
            local r, g, b
            if criteriaProgress.percentage >= 75 then
                r, g, b = 0.0, 1.0, 0.0  -- Green when close
            elseif criteriaProgress.percentage >= 50 then
                r, g, b = 1.0, 0.84, 0.0  -- Gold when halfway
            else
                r, g, b = 1.0, 0.5, 0.0  -- Orange when starting
            end
            previewFrame.achievementBar:SetStatusBarColor(r, g, b)
        elseif previewFrame.achievementBar then
            previewFrame.achievementBar:Hide()
        end
    else
        previewFrame.SetFieldValue(previewFrame.achievementValue, nil, previewFrame.achievementValue.label)
        if previewFrame.achievementBar then
            previewFrame.achievementBar:Hide()
        end
    end
    
    if previewFrame.achievementTrackBtn then
        previewFrame.achievementTrackBtn:Hide()
    end
    
    previewFrame.SetFieldValue(previewFrame.eventValue, eventText, previewFrame.eventValue.label)
    previewFrame.SetFieldValue(previewFrame.classValue, classText, previewFrame.classValue.label)
    previewFrame.SetFieldValue(previewFrame.raceValue, raceText, previewFrame.raceValue.label)

    -- Display additional source metadata (rewardType/details), used for reward items AND as a
    -- generic "rich source info" line for drops/quests/etc.
    local rewardTypeText = item.rewardType
    local sourceDetailsText = item.sourceDetails
    local rewardSourceText = item.source  -- "source" field from reward data (e.g. "Strange Recycling Requisition")

    -- Reward fallback: pull from HousingExpansionData[itemID].reward
    if item and item.itemID and _G.HousingExpansionData then
        local expData = _G.HousingExpansionData[tonumber(item.itemID)]
        if expData and expData.reward then
            local r = expData.reward[1] or expData.reward
            if r then
                if (not rewardTypeText or rewardTypeText == "") and r.rewardType and r.rewardType ~= "" then
                    rewardTypeText = r.rewardType
                end
                if (not sourceDetailsText or sourceDetailsText == "") and r.sourceDetails and r.sourceDetails ~= "" then
                    sourceDetailsText = r.sourceDetails
                end
                if (not rewardSourceText or rewardSourceText == "") and r.source and r.source ~= "" then
                    rewardSourceText = r.source
                end
            end
        end
    end

    -- Drop fallback: reuse Details for drop notes, and optionally summarize multiple drop sources.
    if (not sourceDetailsText or sourceDetailsText == "") and item.dropNotes and item.dropNotes ~= "" then
        sourceDetailsText = item.dropNotes
    end

    -- Fallback: if item record is missing drop notes, pull from static expansion data.
    if (not sourceDetailsText or sourceDetailsText == "") and item and item.itemID and _G.HousingExpansionData then
        local expData = _G.HousingExpansionData[tonumber(item.itemID)]
        if expData and expData.drop then
            local d = expData.drop[1] or expData.drop
            if d and d.notes and d.notes ~= "" then
                sourceDetailsText = d.notes
            end
        end
    end

    -- Quest fallback: reuse Details for quest notes (user-maintained metadata).
    if (not sourceDetailsText or sourceDetailsText == "") and item and item.itemID and _G.HousingExpansionData then
        local expData = _G.HousingExpansionData[tonumber(item.itemID)]
        if expData and expData.quest then
            local q = expData.quest[1] or expData.quest
            if q and q.sourceDetails and q.sourceDetails ~= "" then
                sourceDetailsText = q.sourceDetails
            end
        end
    end

    if (not rewardTypeText or rewardTypeText == "") and item._sourceType and item._sourceType ~= "" then
        rewardTypeText = tostring(item._sourceType)
    end

    -- For rewards, combine source and sourceDetails into a richer display
    if rewardSourceText and rewardSourceText ~= "" then
        if sourceDetailsText and sourceDetailsText ~= "" then
            sourceDetailsText = rewardSourceText .. " - " .. sourceDetailsText
        else
            sourceDetailsText = rewardSourceText
        end
    end

    -- If we have multiple drops, provide a richer tooltip.
    if item._allDrops and type(item._allDrops) == "table" and #item._allDrops > 1 then
        local lines = {}
        for _, d in ipairs(item._allDrops) do
            local npc = d and d.npcName or nil
            local zone = d and d.zone or nil
            local notes = d and d.notes or nil

            local parts = {}
            if npc and npc ~= "" then
                table.insert(parts, tostring(npc))
            end
            if zone and zone ~= "" then
                table.insert(parts, tostring(zone))
            end
            local header = table.concat(parts, " - ")
            if header ~= "" then
                table.insert(lines, header)
            end
            if notes and notes ~= "" then
                table.insert(lines, "  " .. tostring(notes))
            end
        end

        if #lines > 0 then
            local tooltip = "Drop sources:\n" .. table.concat(lines, "\n")
            if previewFrame.sourceDetailsValue then
                previewFrame.sourceDetailsValue.tooltipText = tooltip
            end
            if not sourceDetailsText or sourceDetailsText == "" then
                sourceDetailsText = "Multiple drop sources (hover)"
            end
        end
    end

    -- If we have multiple quests, provide a richer tooltip as well.
    if item._allQuests and type(item._allQuests) == "table" and #item._allQuests > 1 then
        local lines = {}
        for _, q in ipairs(item._allQuests) do
            local qid = q and (q.questId or q.questID) or nil
            local title = q and (q.title or q.questName) or nil
            local details = q and q.sourceDetails or nil
            if title and tostring(title):match("^%d+$") and q and q.title and q.title ~= "" then
                title = q.title
            end
            local line = tostring(title or "Quest")
            if qid then
                line = line .. " (#" .. tostring(qid) .. ")"
            end
            if details and details ~= "" then
                line = line .. "\n  " .. tostring(details)
            end
            table.insert(lines, line)
        end

        if #lines > 0 then
            local tooltip = "Quest sources:\n" .. table.concat(lines, "\n")
            if previewFrame.questValue then
                if previewFrame.questValue.tooltipText and previewFrame.questValue.tooltipText ~= "" then
                    previewFrame.questValue.tooltipText = previewFrame.questValue.tooltipText .. "\n\n" .. tooltip
                else
                    previewFrame.questValue.tooltipText = tooltip
                end
            end
        end
    end

    if previewFrame.rewardTypeValue and rewardTypeText and rewardTypeText ~= "" then
        previewFrame.rewardTypeValue:SetText(rewardTypeText)
        previewFrame.rewardTypeValue:Show()
        if previewFrame.rewardTypeValue.label then previewFrame.rewardTypeValue.label:Show() end
    elseif previewFrame.rewardTypeValue then
        previewFrame.SetFieldValue(previewFrame.rewardTypeValue, nil, previewFrame.rewardTypeValue.label)
    end

    if previewFrame.sourceDetailsValue and sourceDetailsText and sourceDetailsText ~= "" then
        previewFrame.sourceDetailsValue:SetText(sourceDetailsText)
        previewFrame.sourceDetailsValue:Show()
        if previewFrame.sourceDetailsValue.label then previewFrame.sourceDetailsValue.label:Show() end
    elseif previewFrame.sourceDetailsValue then
        if previewFrame.sourceDetailsValue.tooltipText then
            previewFrame.sourceDetailsValue.tooltipText = nil
        end
        previewFrame.SetFieldValue(previewFrame.sourceDetailsValue, nil, previewFrame.sourceDetailsValue.label)
    end

    local fieldsToCheck = {
        previewFrame.questValue,
        previewFrame.questGiverValue,
        previewFrame.achievementValue,
        previewFrame.eventValue,
        previewFrame.classValue,
        previewFrame.raceValue
    }

    -- Add reward fields if they exist
    if previewFrame.rewardTypeValue then
        table.insert(fieldsToCheck, previewFrame.rewardTypeValue)
    end
    if previewFrame.sourceDetailsValue then
        table.insert(fieldsToCheck, previewFrame.sourceDetailsValue)
    end

    previewFrame.UpdateHeaderVisibility(previewFrame.requirementsHeader, fieldsToCheck)
end

function PreviewPanelData:Display3DModel(previewFrame, item, catalogData)
    local modelFileID = catalogData and (catalogData.asset or catalogData.modelFileID)

    -- Fallback to static data if Housing APIs are disabled (API safety)
    if (not modelFileID or modelFileID == 0) and item and item.itemID then
        local itemID = tonumber(item.itemID)
        if itemID and _G.HousingAllItems then
            local staticData = _G.HousingAllItems[itemID]
            if staticData then
                -- Format varies: {decorID, modelFileID, iconFileID} or {"Name", decorID, modelFileID, iconFileID}
                -- Check if first element is a string (item name) to determine offset
                if type(staticData[1]) == "string" then
                    -- Format: {"Name", decorID, modelFileID, iconFileID}
                    modelFileID = tonumber(staticData[3])
                else
                    -- Format: {decorID, modelFileID, iconFileID}
                    modelFileID = tonumber(staticData[2])
                end
            end
        end
    end

    previewFrame._currentModelID = modelFileID

    if previewFrame.modelFrame and modelFileID and previewFrame.modelVisible then
        previewFrame.modelContainer:Show()

        if modelFileID > 0 then
            previewFrame.modelFrame:SetModel(modelFileID)
        else
            previewFrame.modelContainer:Hide()
        end
    elseif previewFrame.modelContainer then
        previewFrame.modelContainer:Hide()
    end
end

return PreviewPanelData



