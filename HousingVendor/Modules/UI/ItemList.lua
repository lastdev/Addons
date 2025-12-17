local ItemList = {}
ItemList.__index = ItemList

-- Cache global references for performance
local _G = _G
local C_Timer = C_Timer
local CreateFrame = CreateFrame
local GameTooltip = GameTooltip
local tonumber = tonumber
local tostring = tostring
local string_format = string.format
local string_find = string.find
local string_match = string.match
local string_sub = string.sub
local string_lower = string.lower
local math_floor = math.floor
local math_min = math.min
local math_max = math.max
local table_insert = table.insert

local BUTTON_HEIGHT = 48  -- Slightly taller for modern look
local BUTTON_SPACING = 4   -- More spacing between cards
local VISIBLE_BUTTONS = 12 -- Fewer visible due to larger size

-- Theme reference
local Theme = nil
local function GetTheme()
    if not Theme then
        Theme = HousingTheme or {}
    end
    return Theme
end

local container = nil
local scrollFrame = nil
local buttons = {}
local allItems = {}
local filteredItems = {}
local currentFilters = {}
local sortDirty = true  -- Dirty flag to track when sorting is needed

-- Event frame for housing decor collection updates
local eventFrame = CreateFrame("Frame")
-- Note: Blizzard may not have a specific favorite changed event
-- We'll check favorites on item update instead

local tooltipScanner = CreateFrame("GameTooltip", "HousingVendorItemListTooltipScanner", UIParent, "GameTooltipTemplate")
tooltipScanner:SetOwner(UIParent, "ANCHOR_NONE")

-- Reusable tooltip scan callback (avoids creating new closures)
local tooltipScanCallback
local pendingTooltipData = {}

local function ProcessTooltipData(tooltipData)
    local numLines = tooltipScanner:NumLines()

    for i = 1, numLines do
        local leftText = _G[string.format("HousingVendorItemListTooltipScannerTextLeft%d", i)]
        local rightText = _G[string.format("HousingVendorItemListTooltipScannerTextRight%d", i)]
        local leftTexture = _G[string.format("HousingVendorItemListTooltipScannerTexture%d", i)]
        local rightTexture = _G[string.format("HousingVendorItemListTooltipScannerTexture%dRight", i)]

        local lineData = {
            leftText = nil,
            rightText = nil,
            leftTexture = nil,
            rightTexture = nil,
            leftColor = nil,
            rightColor = nil
        }

        if leftText then
            local text = leftText:GetText()
            if text then
                lineData.leftText = text
                local r, g, b = leftText:GetTextColor()
                lineData.leftColor = {r, g, b}

                if i == 1 then
                    tooltipData.itemName = text
                end

                local weight = string.match(text, "Weight:%s*(%d+)")
                if weight then
                    tooltipData.weight = tonumber(weight)
                end

                if string.find(text, "Binds") then
                    tooltipData.binding = text
                end

                if string.find(text, "Use:") then
                    tooltipData.useText = text
                end

                if string.find(text, "Collection Bonus") or string.find(text, "First%-Time") then
                    tooltipData.collectionBonus = text
                end

                local itemLevel = string.match(text, "Item Level (%d+)")
                if itemLevel then
                    tooltipData.itemLevel = tonumber(itemLevel)
                end

                local reqLevel = string.match(text, "Requires Level (%d+)")
                if reqLevel then
                    tooltipData.requiredLevel = tonumber(reqLevel)
                end

                if string.find(text, "Requires") and (string.find(text, "Class:") or string.find(text, "Warrior") or string.find(text, "Paladin") or string.find(text, "Hunter") or string.find(text, "Rogue") or string.find(text, "Priest") or string.find(text, "Death Knight") or string.find(text, "Shaman") or string.find(text, "Mage") or string.find(text, "Warlock") or string.find(text, "Monk") or string.find(text, "Druid") or string.find(text, "Demon Hunter") or string.find(text, "Evoker")) then
                    tooltipData.requiredClass = text
                end

                local font = tostring(leftText:GetFont() or "")
                if string.find(font, "Italic") and not tooltipData.description then
                    tooltipData.description = text
                end
            end
        end

        if rightText then
            local text = rightText:GetText()
            if text then
                lineData.rightText = text
                local r, g, b = rightText:GetTextColor()
                lineData.rightColor = {r, g, b}
            end
        end
        if leftTexture and leftTexture:IsShown() then
            local texture = leftTexture:GetTexture()
            if texture and texture ~= "" then
                local textureStr = tostring(texture)
                lineData.leftTexture = textureStr
                
                -- Look for house icon (not weapon icons or question marks)
                if not string.find(textureStr, "INV_Weapon") and
                   not string.find(textureStr, "INV_Sword") and
                   not string.find(textureStr, "INV_Axe") and
                   not string.find(textureStr, "INV_Mace") and
                   not string.find(textureStr, "INV_Shield") and
                   not string.find(textureStr, "INV_Misc_QuestionMark") and
                   not string.find(textureStr, "INV_Helmet") and
                   not string.find(textureStr, "INV_Armor") then
                    -- This could be the house icon
                    if not tooltipData.houseIcon then
                        tooltipData.houseIcon = texture
                    end
                end
            end
        end
        
        if rightTexture and rightTexture:IsShown() then
            local texture = rightTexture:GetTexture()
            if texture and texture ~= "" then
                local textureStr = tostring(texture)
                lineData.rightTexture = textureStr
                
                -- Check right texture for house icon too
                if not string.find(textureStr, "INV_Weapon") and
                   not string.find(textureStr, "INV_Sword") and
                   not string.find(textureStr, "INV_Axe") and
                   not string.find(textureStr, "INV_Mace") and
                   not string.find(textureStr, "INV_Shield") and
                   not string.find(textureStr, "INV_Misc_QuestionMark") and
                   not string.find(textureStr, "INV_Helmet") and
                   not string.find(textureStr, "INV_Armor") then
                    if not tooltipData.houseIcon then
                        tooltipData.houseIcon = texture
                    end
                end
            end
        end
        
        table.insert(tooltipData.allLines, lineData)
    end
end

local function ScanTooltipForAllData(itemID)
    local tooltipData = {
        weight = nil,
        houseIcon = nil,
        description = nil,
        itemName = nil,
        itemQuality = nil,
        itemLevel = nil,
        itemType = nil,
        itemSubType = nil,
        binding = nil,
        useText = nil,
        collectionBonus = nil,
        sellPrice = nil,
        requiredLevel = nil,
        requiredClass = nil,
        requiredFaction = nil,
        requiredReputation = nil,
        allLines = {}
    }

    if not itemID or itemID == "" then
        return tooltipData
    end

    local numericItemID = tonumber(itemID)
    if not numericItemID then
        return tooltipData
    end

    tooltipScanner:ClearLines()
    tooltipScanner:SetItemByID(numericItemID)

    -- Use single reusable callback instead of creating closures
    if not tooltipScanCallback then
        tooltipScanCallback = function()
            -- Process data from pending table
            for itemID, data in pairs(pendingTooltipData) do
                ProcessTooltipData(data)
                pendingTooltipData[itemID] = nil
            end
        end
    end
    
    -- Store pending data
    pendingTooltipData[numericItemID] = tooltipData
    C_Timer.After(0.1, tooltipScanCallback)

    return tooltipData
end

-- Legacy function name for compatibility
local function ScanTooltipForHousingData(itemID)
    local allData = ScanTooltipForAllData(itemID)
    return {
        weight = allData.weight,
        houseIcon = allData.houseIcon,
        description = allData.description
    }
end

-- Refresh collection status for all visible buttons
local DecorSearcherCached = false

function ItemList:RefreshCollectionStatus()
    if not container or not container:IsVisible() then
        return
    end
    
    -- Update collection status for all visible buttons using CollectionAPI
    for _, button in ipairs(buttons) do
        if button:IsVisible() and button.itemData and button.collectedIcon then
            local item = button.itemData
            local isCollected = false
            
            -- First check: Do we have quantity data showing ownership?
            local numStored = item._apiNumStored or 0
            local numPlaced = item._apiNumPlaced or 0
            local totalOwned = numStored + numPlaced
            
            if totalOwned > 0 then
                isCollected = true
            elseif item.itemID and item.itemID ~= "" then
                -- Fallback: Check via CollectionAPI (for items without quantity data yet)
                local itemID = tonumber(item.itemID)
                if itemID and CollectionAPI then
                    isCollected = CollectionAPI:IsItemCollected(itemID)
                end
            end
            
            if isCollected then
                button.collectedIcon:Show()
            else
                button.collectedIcon:Hide()
            end
        end
    end
end

-- Initialize item list
function ItemList:Initialize(parentFrame)
    self:CreateItemListSection(parentFrame)
    
    -- Register events for housing decor collection updates
    -- Primary events (may not exist in all WoW versions - use pcall for safety)
    local function SafeRegisterEvent(eventName)
        local success, err = pcall(function()
            eventFrame:RegisterEvent(eventName)
        end)
        if not success then
            -- Event doesn't exist in this version, skip it silently
            return false
        end
        return true
    end
    
    -- Try to register housing-specific events (may not exist in all versions)
    SafeRegisterEvent("HOUSE_DECOR_ADDED_TO_CHEST")  -- Fires when decor added to chest
    SafeRegisterEvent("HOUSING_COLLECTION_UPDATED")  -- Fires when collection status changes
    SafeRegisterEvent("HOUSING_ITEM_PURCHASED")     -- Fires when item is purchased
    SafeRegisterEvent("HOUSING_STORAGE_UPDATED")     -- Fires when storage changes (triggers twice)
    
    -- Backup/edge case events (always available)
    eventFrame:RegisterEvent("MERCHANT_SHOW")  -- Backup refresh when vendor is opened
    eventFrame:RegisterEvent("MERCHANT_CLOSED")  -- Scan after closing vendor (catches items that may not have fired events)
    eventFrame:RegisterEvent("BAG_UPDATE_DELAYED")  -- Catches items appearing in bags silently (covers edge cases)
    eventFrame:RegisterEvent("CHAT_MSG_LOOT")  -- Detect when items are received via loot
    eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")  -- CLEU: Detect item loots from combat
    eventFrame:RegisterEvent("ENCOUNTER_LOOT_RECEIVED")  -- Detect encounter loot (raids/dungeons)
    eventFrame:RegisterEvent("PLAYER_LOGIN")  -- Initial scan after login
    
    eventFrame:SetScript("OnEvent", function(self, event, ...)
        if event == "HOUSE_DECOR_ADDED_TO_CHEST" then
            -- Decor added to chest (collected)
            local decorUid, decorID = ...
            -- Cache the decorID immediately using CollectionAPI
            if decorID and CollectionAPI then
                CollectionAPI:MarkItemCollected(decorID)
            end
            -- Single debounced refresh (replaces 3x stacked calls)
            C_Timer.After(1, function() ItemList:RefreshCollectionStatus() end)
        elseif event == "HOUSING_COLLECTION_UPDATED" then
            -- Single debounced refresh (replaces 4x stacked calls)
            C_Timer.After(1, function() ItemList:RefreshCollectionStatus() end)
        elseif event == "HOUSING_ITEM_PURCHASED" then
            -- Single debounced refresh (replaces 3x stacked calls)
            C_Timer.After(1, function() ItemList:RefreshCollectionStatus() end)
        elseif event == "HOUSING_STORAGE_UPDATED" then
            -- This event triggers twice, so add delay
            C_Timer.After(2, function() ItemList:RefreshCollectionStatus() end)
        elseif event == "MERCHANT_SHOW" or event == "MERCHANT_CLOSED" or event == "BAG_UPDATE_DELAYED" or event == "CHAT_MSG_LOOT" then
            -- Single debounced refresh (replaces 2x stacked calls)
            C_Timer.After(1, function() ItemList:RefreshCollectionStatus() end)
        elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
            -- CLEU: Detect item loots and force recache
            local timestamp, subevent, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName, _, itemID = CombatLogGetCurrentEventInfo()
            if subevent == "ENCHANT_APPLIED" or subevent == "SPELL_CAST_SUCCESS" then
                -- Check if itemID is a housing decor item and force recache
                if itemID and itemID > 0 and CollectionAPI then
                    -- Force recache for this item
                    CollectionAPI:ForceRecache(itemID)
                    -- Debounced refresh of visible items
                    C_Timer.After(0.5, function() ItemList:RefreshCollectionStatus() end)
                end
            end
        elseif event == "ENCOUNTER_LOOT_RECEIVED" then
            -- Encounter loot received (raids/dungeons)
            local encounterID, itemID, itemLink = ...
            if itemID and itemID > 0 and CollectionAPI then
                -- Force recache for this item
                CollectionAPI:ForceRecache(itemID)
                -- Debounced refresh of visible items
                C_Timer.After(0.5, function() ItemList:RefreshCollectionStatus() end)
            end
        elseif event == "PLAYER_LOGIN" then
            -- Initialize catalog searcher (caches decor data)
            if HousingAPI then
                HousingAPI:CreateCatalogSearcher()
            end
            -- Initial scan after login
            C_Timer.After(1, function()
                ItemList:RefreshCollectionStatus()
            end)
        end
    end)
end

-- Create item list section
function ItemList:CreateItemListSection(parentFrame)
    -- Create scroll frame (narrower to fit preview panel on the right)
    -- Preview panel is 500px wide + 20px margin = 520px from right edge
    -- No header row - items start directly below filters
    scrollFrame = CreateFrame("ScrollFrame", "HousingItemListScrollFrame", parentFrame, "UIPanelScrollFrameTemplate")
    -- Header is ~55px, filters are 140px (3 compact rows), plus small spacing
    local scrollTopOffset = -215  -- Base offset (header 55 + filters 140 + spacing 20)
    if parentFrame.warningMessage then
        scrollTopOffset = -250  -- Extra offset if warning message exists (35px warning)
    end
    scrollFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, scrollTopOffset)
    scrollFrame:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -520, 52)  -- Leave space for preview panel (520px = 500px panel + 20px margin)
    
    -- Create container
    container = CreateFrame("Frame", "HousingItemListContainer", scrollFrame)
    container:SetWidth(scrollFrame:GetWidth() - 20)
    container:SetHeight(100) -- Will be updated based on item count
    scrollFrame:SetScrollChild(container)
    
    -- Buttons will be lazy-created on demand (no pre-allocation)
    
    -- Scroll handler - update visible buttons when scrolling
    scrollFrame:SetScript("OnVerticalScroll", function(self, offset)
        ScrollFrame_OnVerticalScroll(self, offset, BUTTON_HEIGHT + BUTTON_SPACING)
        C_Timer.After(0, function()
            if HousingItemList then
                HousingItemList:UpdateVisibleButtons()
            end
        end)
    end)
    
    -- Store references
    _G["HousingItemListContainer"] = container
    _G["HousingItemListScrollFrame"] = scrollFrame
end

-- Create a single item button (Midnight Theme)
function ItemList:CreateItemButton(parent, index)
    local theme = GetTheme()
    local colors = theme.Colors or {}
    
    local button = CreateFrame("Button", "HousingItemButton" .. index, parent, "BackdropTemplate")
    button:SetSize(parent:GetWidth() - 16, BUTTON_HEIGHT)
    button:SetPoint("TOPLEFT", 8, -(index - 1) * (BUTTON_HEIGHT + BUTTON_SPACING))
    
    -- Midnight theme backdrop (card style)
    button:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\Buttons\\WHITE8x8",
        tile = false,
        tileSize = 0,
        edgeSize = 1,
        insets = { left = 0, right = 0, top = 0, bottom = 0 }
    })
    
    -- Deep purple background
    local bgTertiary = colors.bgTertiary or {0.16, 0.12, 0.24, 0.90}
    local borderPrimary = colors.borderPrimary or {0.35, 0.30, 0.50, 0.8}
    button:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
    button:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
    
    -- Source color bar on LEFT edge (combined faction + source)
    local factionBar = button:CreateTexture(nil, "OVERLAY")
    factionBar:SetWidth(4)  -- Thinner, more elegant
    factionBar:SetPoint("TOPLEFT", 0, 0)
    factionBar:SetPoint("BOTTOMLEFT", 0, 0)
    factionBar:SetTexture("Interface\\Buttons\\WHITE8x8")
    factionBar:SetVertexColor(0.35, 0.80, 0.45, 1)  -- Default green (vendor)
    button.factionBar = factionBar
    
    -- Right edge source bar (hidden by default, all info on left)
    local sourceBar = button:CreateTexture(nil, "OVERLAY")
    sourceBar:SetWidth(4)
    sourceBar:SetPoint("TOPRIGHT", 0, 0)
    sourceBar:SetPoint("BOTTOMRIGHT", 0, 0)
    sourceBar:SetTexture("Interface\\Buttons\\WHITE8x8")
    sourceBar:Hide()
    button.sourceBar = sourceBar
    
    -- Icon (larger for modern look)
    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetSize(38, 38)  -- Larger icon
    icon:SetPoint("LEFT", 12, 0)
    icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)  -- Trim icon borders
    button.icon = icon

    -- Icon border (quality glow)
    local iconBorder = button:CreateTexture(nil, "BORDER")
    iconBorder:SetTexture("Interface\\Buttons\\WHITE8x8")
    iconBorder:SetSize(42, 42)
    iconBorder:SetPoint("CENTER", icon, "CENTER", 0, 0)
    iconBorder:SetVertexColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], 0.8)
    button.iconBorder = iconBorder
    
    -- Collected indicator (checkmark)
    local collectedIcon = button:CreateTexture(nil, "OVERLAY")
    collectedIcon:SetSize(18, 18)
    collectedIcon:SetPoint("TOPRIGHT", icon, "TOPRIGHT", 4, 4)
    collectedIcon:SetTexture("Interface\\RAIDFRAME\\ReadyCheck-Ready")
    local statusSuccess = colors.statusSuccess or {0.30, 0.85, 0.50, 1.0}
    collectedIcon:SetVertexColor(statusSuccess[1], statusSuccess[2], statusSuccess[3], 1)
    collectedIcon:Hide()
    button.collectedIcon = collectedIcon

    -- Owned quantity text (bottom-left of icon, larger)
    local quantityText = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    quantityText:SetPoint("BOTTOMLEFT", icon, "BOTTOMLEFT", -2, -2)
    quantityText:SetTextColor(statusSuccess[1], statusSuccess[2], statusSuccess[3], 1)
    quantityText:Hide()
    button.quantityText = quantityText
    
    -- Name text (primary)
    local nameText = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    nameText:SetPoint("LEFT", icon, "RIGHT", 12, 4)
    nameText:SetWidth(200)
    nameText:SetJustifyH("LEFT")
    local textPrimary = colors.textPrimary or {0.92, 0.90, 0.96, 1.0}
    nameText:SetTextColor(textPrimary[1], textPrimary[2], textPrimary[3], 1)
    button.nameText = nameText
    
    -- Vendor text (secondary, below name)
    local vendorText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    vendorText:SetPoint("TOPLEFT", nameText, "BOTTOMLEFT", 0, -2)
    vendorText:SetWidth(200)
    vendorText:SetJustifyH("LEFT")
    local textSecondary = colors.textSecondary or {0.70, 0.68, 0.78, 1.0}
    vendorText:SetTextColor(textSecondary[1], textSecondary[2], textSecondary[3], 1)
    vendorText:SetText("")
    button.vendorText = vendorText
    
    -- Cost text (right side, gold accent)
    local costText = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    costText:SetPoint("RIGHT", button, "RIGHT", -12, 0)
    costText:SetJustifyH("RIGHT")
    local accentGold = colors.accentGold or {0.85, 0.75, 0.45, 1.0}
    costText:SetTextColor(accentGold[1], accentGold[2], accentGold[3], 1)
    button.costText = costText
    
    -- Zone text (above cost, smaller)
    local zoneText = button:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    zoneText:SetPoint("BOTTOMRIGHT", costText, "TOPRIGHT", 0, 2)
    zoneText:SetJustifyH("RIGHT")
    local textMuted = colors.textMuted or {0.50, 0.48, 0.58, 1.0}
    zoneText:SetTextColor(textMuted[1], textMuted[2], textMuted[3], 1)
    button.zoneText = zoneText
    
    -- Make the entire button clickable
    button:EnableMouse(true)
    button:RegisterForClicks("LeftButtonUp")
    button:SetScript("OnClick", function(self, mouseButton)
        local item = self.itemData
        if not item then return end
        
        -- Click: Show preview panel
        if HousingPreviewPanel then
            HousingPreviewPanel:ShowItem(item)
        else
            -- Silently handle missing PreviewPanel
            -- print("|cFF8A7FD4HousingVendor:|r HousingPreviewPanel not found")
        end
    end)
    
    -- Hover effects (Midnight theme)
    local bgHover = colors.bgHover or {0.22, 0.16, 0.32, 0.95}
    local accentPrimary = colors.accentPrimary or {0.55, 0.65, 0.90, 1.0}
    
    button:SetScript("OnEnter", function(self)
        local item = self.itemData
        if item then
            -- Hover state: lighter background, accent border
            self:SetBackdropColor(bgHover[1], bgHover[2], bgHover[3], bgHover[4])
            self:SetBackdropBorderColor(accentPrimary[1], accentPrimary[2], accentPrimary[3], 1)
            
            -- No map icon hover effect needed anymore
            
            -- Brighten the backdrop color on hover (preserve faction/source colors)
            if self.originalBackdropColor then
                local r, g, b, a = unpack(self.originalBackdropColor)
                -- Brighten significantly for better visibility
                self:SetBackdropColor(math.min(r + 0.2, 1), math.min(g + 0.2, 1), math.min(b + 0.2, 1), 1)
            else
                -- Fallback if color wasn't stored
                self:SetBackdropColor(0.3, 0.3, 0.3, 1)
            end
            
            -- Gather all available information from all APIs
            local allInfo = {}
            if HousingPreviewPanel and HousingPreviewPanel.GatherAllItemInfo then
                allInfo = HousingPreviewPanel:GatherAllItemInfo(item)
                -- Safety check: ensure catalogInfo and decorInfo are tables or nil (never numbers)
                if allInfo.catalogInfo and type(allInfo.catalogInfo) ~= "table" then
                    allInfo.catalogInfo = nil
                end
                if allInfo.decorInfo and type(allInfo.decorInfo) ~= "table" then
                    allInfo.decorInfo = nil
                end
            end
            
            -- Show comprehensive tooltip
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:ClearLines()
            
            -- Try to show official WoW item tooltip first (if itemID is available)
            local showOfficialTooltip = false
            if item.itemID and item.itemID ~= "" then
                local numericItemID = tonumber(item.itemID)
                if numericItemID then
                    -- Request item data to be loaded
                    if C_Item and C_Item.RequestLoadItemDataByID then
                        C_Item.RequestLoadItemDataByID(numericItemID)
                    end
                    
                    -- Try to get item info
                    local itemInfo = allInfo.itemInfo
                    if not itemInfo and C_Item and C_Item.GetItemInfo then
                        if C_Item.RequestLoadItemDataByID then
                            C_Item.RequestLoadItemDataByID(numericItemID)
                        end
                        local ok, info = pcall(C_Item.GetItemInfo, numericItemID)
                        if ok then
                            itemInfo = info
                        end
                    end
                    
                    -- If we have item info, show official tooltip
                    if itemInfo then
                        GameTooltip:SetItemByID(numericItemID)
                        showOfficialTooltip = true
                    end
                end
            end
            
            -- If official tooltip didn't work, use custom tooltip
            if not showOfficialTooltip then
                -- Item name (colored by faction or quality)
                local nameColor = {1, 1, 1, 1}
                if item.faction == "Horde" then
                    nameColor = {1, 0.3, 0.3, 1} -- Red
                elseif item.faction == "Alliance" then
                    nameColor = {0.3, 0.6, 1, 1} -- Blue
                elseif allInfo.itemInfo and type(allInfo.itemInfo) == "table" and allInfo.itemInfo.itemQuality then
                    -- Use quality color if available
                    local qualityColors = {
                        [0] = {0.62, 0.62, 0.62, 1}, -- Poor
                        [1] = {1, 1, 1, 1}, -- Common
                        [2] = {0.12, 1, 0, 1}, -- Uncommon
                        [3] = {0, 0.44, 0.87, 1}, -- Rare
                        [4] = {0.64, 0.21, 0.93, 1}, -- Epic
                        [5] = {1, 0.5, 0, 1}, -- Legendary
                        [6] = {0.9, 0.8, 0.5, 1}, -- Artifact
                        [7] = {0.9, 0.8, 0.5, 1} -- Heirloom
                    }
                    local qualityColor = qualityColors[allInfo.itemInfo.itemQuality] or {1, 1, 1, 1}
                    nameColor = qualityColor
                end
                
                local displayName = item.name or "Unknown Item"
                if allInfo.itemInfo and type(allInfo.itemInfo) == "table" and allInfo.itemInfo.itemName then
                    displayName = allInfo.itemInfo.itemName
                elseif allInfo.catalogInfo and type(allInfo.catalogInfo) == "table" and allInfo.catalogInfo.name then
                    displayName = allInfo.catalogInfo.name
                elseif allInfo.decorInfo and type(allInfo.decorInfo) == "table" and allInfo.decorInfo.name then
                    displayName = allInfo.decorInfo.name
                end
                
                GameTooltip:SetText(displayName, nameColor[1], nameColor[2], nameColor[3], 1, true)
                
                -- Add API info if available
                if allInfo.itemInfo and type(allInfo.itemInfo) == "table" then
                    if allInfo.itemInfo.itemLevel then
                        GameTooltip:AddLine("Item Level: " .. allInfo.itemInfo.itemLevel, 0.8, 0.8, 0.8, 1)
                    end
                    if allInfo.itemInfo.itemType then
                        local typeText = allInfo.itemInfo.itemType
                        if allInfo.itemInfo.itemSubType then
                            typeText = string.format("%s - %s", typeText, allInfo.itemInfo.itemSubType)
                        end
                        GameTooltip:AddLine("Type: " .. typeText, 0.8, 0.8, 0.8, 1)
                    end
                end
            else
                -- Add separator after official tooltip (no header text)
                GameTooltip:AddLine(" ")
            end
            
            -- Add API information section (no header text)
            if allInfo.itemInfo or (allInfo.catalogInfo and type(allInfo.catalogInfo) == "table") or (allInfo.decorInfo and type(allInfo.decorInfo) == "table") then
                if (allInfo.catalogInfo and type(allInfo.catalogInfo) == "table") or (allInfo.decorInfo and type(allInfo.decorInfo) == "table") then
                    local desc = nil
                    if allInfo.catalogInfo and type(allInfo.catalogInfo) == "table" and allInfo.catalogInfo.description then
                        desc = allInfo.catalogInfo.description
                    elseif allInfo.decorInfo and type(allInfo.decorInfo) == "table" and allInfo.decorInfo.description then
                        desc = allInfo.decorInfo.description
                    end
                    if desc and desc ~= "" then
                        GameTooltip:AddLine("Description: " .. desc, 0.9, 0.9, 0.8, true)
                    end
                end
            end
            
            -- Type and Category
            if item.type and item.type ~= "" then
                GameTooltip:AddLine("Type: " .. item.type, 0.8, 0.8, 0.8, 1)
            end
            if item.category and item.category ~= "" then
                GameTooltip:AddLine("Category: " .. item.category, 0.8, 0.8, 0.8, 1)
            end
            
            GameTooltip:AddLine(" ") -- Spacer
            
            -- Generic NonVendor names to skip (redundant with source type)
            local genericVendors = {
                ["Achievement Items"] = true,
                ["Quest Items"] = true,
                ["Drop Items"] = true,
                ["Crafted Items"] = true,
                ["Replica Items"] = true,
                ["Miscellaneous Items"] = true,
                ["Event Rewards"] = true,
                ["Collection Items"] = true
            }
            local genericZones = {
                ["Achievement Rewards"] = true,
                ["Quest Rewards"] = true,
                ["Drop Rewards"] = true,
                ["Crafted"] = true,
                ["Replicas"] = true,
                ["Miscellaneous"] = true,
                ["Events"] = true,
                ["Collections"] = true
            }
            
            -- Vendor information (skip generic NonVendor names)
            if item.vendorName and item.vendorName ~= "" and not genericVendors[item.vendorName] then
                GameTooltip:AddLine("Vendor: " .. item.vendorName, 1, 0.82, 0, 1)
            end
            if item.zoneName and item.zoneName ~= "" and not genericZones[item.zoneName] then
                GameTooltip:AddLine("Zone: " .. item.zoneName, 1, 0.82, 0, 1)
            end
            if item.expansionName and item.expansionName ~= "" and not genericVendors[item.expansionName] then
                local expansionText = item.expansionName
                -- Add indicator for Midnight expansion (not yet released)
                if expansionText == "Midnight" then
                    expansionText = expansionText .. " (Not Yet Released)"
                end
                GameTooltip:AddLine("Expansion: " .. expansionText, 1, 0.82, 0, 1)
            end
            
            -- Coordinates
            if item.vendorCoords and item.vendorCoords.x and item.vendorCoords.y then
                GameTooltip:AddLine("Coordinates: " .. string.format("%.1f, %.1f", item.vendorCoords.x, item.vendorCoords.y), 0.7, 0.7, 0.7, 1)
            end
            
            -- Cost/Price information REMOVED from tooltip
            -- Cost is now shown only in the preview panel info section
            -- This avoids confusion with WoW's built-in "Sell Price" tooltip line
            
            -- Achievement requirement (prioritize API data)
            local achievementText = nil
            if item._apiAchievement then
                -- Parse achievement name from formatted text if needed
                achievementText = item._apiAchievement
                if string.find(achievementText, "|n|cFFFFD200") then
                    achievementText = string.match(achievementText, "^([^|]+)") or achievementText
                end
            elseif item.achievementRequired and item.achievementRequired ~= "" then
                achievementText = item.achievementRequired
            end
            
            -- Try to get from catalog data if API data not loaded yet
            if not achievementText and item.itemID then
                local numericItemID = tonumber(item.itemID)
                if numericItemID and HousingAPI then
                    local catalogData = HousingAPI:GetCatalogData(numericItemID)
                    if catalogData and catalogData.achievement then
                        achievementText = catalogData.achievement
                    end
                end
            end
            
            if achievementText and achievementText ~= "" then
                GameTooltip:AddLine("Achievement: " .. achievementText, 1, 0.5, 0, 1)
            end
            
            -- Quest requirement (ALWAYS use Housing Catalog API - it's the authoritative source)
            local questText = nil
            local questID = nil
            
            -- Priority 1: Get from Housing Catalog API (most accurate for housing decor)
            if item.itemID then
                local numericItemID = tonumber(item.itemID)
                if numericItemID and HousingAPI then
                    local catalogData = HousingAPI:GetCatalogData(numericItemID)
                    if catalogData and catalogData.quest then
                        questText = catalogData.quest
                        questID = catalogData.questID
                    end
                end
            end
            
            -- Priority 2: Use cached API data if catalog fetch didn't work
            if not questText and item._apiQuest then
                questText = item._apiQuest
            end
            
            -- Priority 3: Fallback to static data (least accurate)
            if not questText and item.questRequired and item.questRequired ~= "" then
                questText = item.questRequired
            end
            
            -- Only show quest if we have Housing Catalog API data (don't show static data quest)
            -- This ensures we only show the correct quest that unlocks the item
            if questText and questText ~= "" and (item._apiDataLoaded or HousingAPI) then
                GameTooltip:AddLine("Quest: " .. questText, 0.5, 0.8, 1, 1)
            end
            
            -- Drop source (prioritize API data)
            local dropText = nil
            if item._apiSourceText and (item._apiSourceText:find("Drop") or item._apiSourceText:find("Loot")) then
                -- Extract drop source from sourceText
                dropText = item._apiSourceText:match("Drop: ([^\r\n|:]+)") or item._apiSourceText:match("Loot: ([^\r\n|:]+)")
                if dropText then
                    dropText = dropText:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|H[^|]*|h", ""):gsub("|h", ""):gsub("|T[^|]*|t", ""):gsub("|n", "")
                    dropText = dropText:match("^%s*(.-)%s*$")
                end
            elseif item.dropSource and item.dropSource ~= "" then
                dropText = item.dropSource
            end
            
            if dropText and dropText ~= "" then
                GameTooltip:AddLine("Drops from: " .. dropText, 0.8, 0.5, 1, 1)
            end
            
            -- Faction
            if item.faction and item.faction ~= "Neutral" then
                local factionColor = {1, 1, 1, 1}
                if item.faction == "Horde" then
                    factionColor = {1, 0.3, 0.3, 1}
                elseif item.faction == "Alliance" then
                    factionColor = {0.3, 0.6, 1, 1}
                end
                GameTooltip:AddLine("Faction: " .. item.faction, factionColor[1], factionColor[2], factionColor[3], 1)
            end
            
            -- Item ID (if available)
            if item.itemID and item.itemID ~= "" then
                GameTooltip:AddLine("Item ID: " .. item.itemID, 0.5, 0.5, 0.5, 1)
            end
            
            GameTooltip:Show()
        end
    end)
    button:SetScript("OnLeave", function(self)
        local theme = GetTheme()
        local colors = theme.Colors or {}
        local bgTertiary = colors.bgTertiary or {0.16, 0.12, 0.24, 0.90}
        local borderPrimary = colors.borderPrimary or {0.35, 0.30, 0.50, 0.8}
        
        -- Restore original colors
        if self.originalBackdropColor then
            self:SetBackdropColor(unpack(self.originalBackdropColor))
        else
            self:SetBackdropColor(bgTertiary[1], bgTertiary[2], bgTertiary[3], bgTertiary[4])
        end
        self:SetBackdropBorderColor(borderPrimary[1], borderPrimary[2], borderPrimary[3], borderPrimary[4])
        
        GameTooltip:Hide()
    end)
    
    button:Hide()
    return button
end

-- Update item list with filtered items
function ItemList:UpdateItems(items, filters)
    if not container then return end
    
    allItems = items or {}
    filteredItems = allItems
    currentFilters = filters or {}
    
    -- Apply filters if provided
    if filters and HousingDataManager then
        local previousCount = #filteredItems
        filteredItems = HousingDataManager:FilterItems(allItems, filters)
        
        -- Mark as dirty if filter results changed
        if #filteredItems ~= previousCount then
            sortDirty = true
        end
    end
    
    -- Refresh collection status after updating items (with delayed re-check)
    C_Timer.After(0.1, function()
        ItemList:RefreshCollectionStatus()
    end)
    
    -- Only sort if data is dirty (not on every render)
    if sortDirty then
        -- Get player faction for smart sorting
        local playerFaction = UnitFactionGroup("player")
        
        -- Sort by faction priority (player's faction first, then neutral, then opposite faction), then alphabetically
        table.sort(filteredItems, function(a, b)
            local aFaction = a.faction or "Neutral"
            local bFaction = b.faction or "Neutral"
            
            -- Assign priority values (lower = shown first)
            local function getFactionPriority(faction)
                if faction == playerFaction then
                    return 1  -- Player's faction first
                elseif faction == "Neutral" then
                    return 2  -- Neutral second
                else
                    return 3  -- Opposite faction last
                end
            end
            
            local aPriority = getFactionPriority(aFaction)
            local bPriority = getFactionPriority(bFaction)
            
            -- If same priority, sort alphabetically
            if aPriority == bPriority then
                return a.name < b.name
            end
            
            -- Otherwise sort by priority
            return aPriority < bPriority
        end)
        
        sortDirty = false  -- Clear dirty flag
    end
    
    -- Update container height
    local totalHeight = math.max(100, #filteredItems * (BUTTON_HEIGHT + BUTTON_SPACING) + 10)
    container:SetHeight(totalHeight)

    -- Update scroll frame
    if scrollFrame then
        scrollFrame:UpdateScrollChildRect()
        -- Reset scroll to top when filters change
        scrollFrame:SetVerticalScroll(0)
    end

    -- Update visible buttons synchronously (no delay needed)
    self:UpdateVisibleButtons()
end

-- Update which buttons are visible (virtual scrolling with lazy creation)
function ItemList:UpdateVisibleButtons()
    if not container or not scrollFrame then return end
    
    local scrollOffset = scrollFrame:GetVerticalScroll()
    local startIndex = math.floor(scrollOffset / (BUTTON_HEIGHT + BUTTON_SPACING)) + 1
    local endIndex = math.min(startIndex + VISIBLE_BUTTONS, #filteredItems)
    
    -- Hide all buttons first
    for _, button in ipairs(buttons) do
        button:Hide()
    end
    
    -- Show and update visible buttons (create on demand)
    for i = startIndex, endIndex do
        local buttonIndex = i - startIndex + 1
        
        -- Lazy-create button if it doesn't exist
        if not buttons[buttonIndex] then
            buttons[buttonIndex] = self:CreateItemButton(container, buttonIndex)
        end
        
        local button = buttons[buttonIndex]
        local item = filteredItems[i]
        
        if item then
            -- Update button position
            button:ClearAllPoints()
            button:SetPoint("TOPLEFT", container, "TOPLEFT", 10, -(i - 1) * (BUTTON_HEIGHT + BUTTON_SPACING))
            
            -- Update button data
            button.itemData = item
            
            -- Check if this is a special view item (expansion, location, vendor)
            if item._isExpansion or item._isZone or item._isVendor then
                -- Handle special view items differently
                self:UpdateSpecialViewItemButton(button, item)
            else
                -- Handle regular item buttons
                self:UpdateRegularItemButton(button, item, buttonIndex)
            end
            
            button:Show()
        end
    end
    
    -- Refresh collection status after updating visible buttons (with delayed re-check)
    C_Timer.After(0.1, function()
        ItemList:RefreshCollectionStatus()
    end)
end

-- Update a special view item button (expansion, location, vendor)
function ItemList:UpdateSpecialViewItemButton(button, item)
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
    button:SetBackdropColor(unpack(backdropColor))
    
    -- Update item name
    button.nameText:SetText(item.name)
    
    -- Removed: Type text and tooltip info text (fields removed)
    
    -- Price text removed - no longer displaying price in main UI
    
    -- Hide map icon for special view items
    button.mapIcon:Hide()
    
    -- Set a generic icon for special views
    button.icon:SetTexture("Interface\\Icons\\INV_Misc_Map02")
    
    -- Removed: housing icon and weight (fields removed)
    
    -- Override click behavior for special view items - drill down to show items
    button:SetScript("OnClick", function(self, mouseButton)
        if item._isExpansion and item._expansionData then
            -- Show all items in this expansion
            local expansionItems = item._expansionData.items
            if HousingFilters then
                local filters = HousingFilters:GetFilters()
                ItemList:UpdateItems(expansionItems, filters)
                -- Show back button
                if _G["HousingBackButton"] then
                    _G["HousingBackButton"]:Show()
                end
            end
        elseif item._isZone and item._zoneData then
            -- Show all items in this zone
            local zoneItems = item._zoneData.items
            if HousingFilters then
                local filters = HousingFilters:GetFilters()
                ItemList:UpdateItems(zoneItems, filters)
                -- Show back button
                if _G["HousingBackButton"] then
                    _G["HousingBackButton"]:Show()
                end
            end
        elseif item._isVendor and item._vendorData then
            -- Show all items from this vendor
            local vendorItems = item._vendorData.items
            if HousingFilters then
                local filters = HousingFilters:GetFilters()
                ItemList:UpdateItems(vendorItems, filters)
                -- Show back button
                if _G["HousingBackButton"] then
                    _G["HousingBackButton"]:Show()
                end
            end
        end
    end)
end

function ItemList:UpdateRegularItemButton(button, item, buttonIndex)
    buttonIndex = buttonIndex or 1
    
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
    
    -- LEFT EDGE: Combined Faction + Source color bar (Midnight theme colors)
    if button.factionBar then
        local factionHorde = colors.factionHorde or {0.85, 0.20, 0.25, 1.0}
        local factionAlliance = colors.factionAlliance or {0.25, 0.50, 0.90, 1.0}
        local sourceAchievement = colors.sourceAchievement or {0.95, 0.80, 0.25, 1.0}
        local sourceQuest = colors.sourceQuest or {0.40, 0.70, 0.95, 1.0}
        local sourceDrop = colors.sourceDrop or {0.95, 0.60, 0.25, 1.0}
        local sourceVendor = colors.sourceVendor or {0.35, 0.80, 0.45, 1.0}
        
        if item.faction == "Horde" then
            button.factionBar:SetVertexColor(factionHorde[1], factionHorde[2], factionHorde[3], 1)
            button.factionBar:Show()
        elseif item.faction == "Alliance" then
            button.factionBar:SetVertexColor(factionAlliance[1], factionAlliance[2], factionAlliance[3], 1)
            button.factionBar:Show()
        elseif isAchievement then
            button.factionBar:SetVertexColor(sourceAchievement[1], sourceAchievement[2], sourceAchievement[3], 1)
            button.factionBar:Show()
        elseif isQuest then
            button.factionBar:SetVertexColor(sourceQuest[1], sourceQuest[2], sourceQuest[3], 1)
            button.factionBar:Show()
        elseif isDrop then
            button.factionBar:SetVertexColor(sourceDrop[1], sourceDrop[2], sourceDrop[3], 1)
            button.factionBar:Show()
        else
            button.factionBar:SetVertexColor(sourceVendor[1], sourceVendor[2], sourceVendor[3], 1)
            button.factionBar:Show()
        end
    end
    
    -- Hide the right edge source bar
    if button.sourceBar then
        button.sourceBar:Hide()
    end
    
    -- Update backdrop color (Midnight theme with faction tint)
    local bgTertiary = colors.bgTertiary or {0.16, 0.12, 0.24, 0.90}
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
    button:SetBackdropColor(unpack(backdropColor))
    
    local displayName = item.name or "Unknown"

    if item.itemID then
        local itemID = tonumber(item.itemID)
        if itemID then
            local itemName, itemLink = GetItemInfo(itemID)

            if itemName and itemName ~= "" then
                displayName = itemName
            elseif itemLink and type(itemLink) == "string" then
                local linkName = itemLink:match("%[(.+)%]")
                if linkName and linkName ~= "" then
                    displayName = linkName
                end
            end
        end
    end

    -- Quality color codes (slightly brighter for dark theme)
    local qualityColors = {
        [0] = "|cff9d9d9d", -- Poor (gray)
        [1] = "|cffEBE8F0", -- Common (soft white-purple)
        [2] = "|cff1EFF00", -- Uncommon (green)
        [3] = "|cff4080E6", -- Rare (moonlit blue)
        [4] = "|cffA855F7", -- Epic (vibrant purple)
        [5] = "|cffFF8000", -- Legendary (orange)
    }

    -- Use cached API quality if available
    if item._apiQuality then
        local colorCode = qualityColors[item._apiQuality] or "|cffEBE8F0"
        button.nameText:SetText(colorCode .. displayName .. "|r")
    else
        button.nameText:SetText(displayName)
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
    -- Quality color codes (WoW format: |cAARRGGBB)
    local qualityColors = {
        [0] = "|cff9d9d9d", -- Poor (gray)
        [1] = "|cffffffff", -- Common (white)
        [2] = "|cff1eff00", -- Uncommon (green)
        [3] = "|cff0070dd", -- Rare (blue)
        [4] = "|cffa335ee", -- Epic (purple)
        [5] = "|cffff8000", -- Legendary (orange)
    }
    
    if button.costText then
        button.costText:SetText("...") -- Show loading indicator
        button.costText:Show()
    end
    
    -- Initialize vendor text (show empty initially)
    if button.vendorText then
        button.vendorText:SetText("")
        button.vendorText:Show()
    end
    
    local itemID = tonumber(item.itemID)
    if itemID and HousingAPI then
        -- Try to get quality and cost asynchronously
        C_Timer.After(0.1, function()
            if not button:IsVisible() then return end
            
            local entryInfo = HousingAPI:GetCatalogEntryInfoByItem(itemID)
            if entryInfo and entryInfo.entryID then
                local entryID = entryInfo.entryID
                if type(entryID) == "table" and entryID.recordID and entryID.entryType then
                    local fullEntry = HousingAPI:GetCatalogEntryInfoByRecordID(entryID.entryType, entryID.recordID)
                    if fullEntry then
                        if fullEntry.quality ~= nil and button.nameText then
                            local quality = fullEntry.quality
                            local colorCode = qualityColors[quality] or "|cffffffff"

                            local displayName = item.name or "Unknown"
                            if itemID then
                                local itemName = GetItemInfo(itemID)
                                if itemName and itemName ~= "" then
                                    displayName = itemName
                                end
                            end

                            button.nameText:SetText(colorCode .. displayName .. "|r")
                        end
                        
                        -- Parse vendor and cost from sourceText
                        if fullEntry.sourceText then
                            -- Extract vendor
                            if button.vendorText then
                                -- Try multiple patterns to extract vendor
                                local vendor = fullEntry.sourceText:match("Vendor: ([^\r\n|:]+)")
                                if not vendor then
                                    vendor = fullEntry.sourceText:match("Vendor%s*:%s*([^\r\n|:]+)")
                                end
                                if vendor then
                                    -- Clean vendor text (remove WoW formatting codes)
                                    vendor = vendor:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|H[^|]*|h", ""):gsub("|h", ""):gsub("|T[^|]*|t", ""):gsub("|n", "")
                                    vendor = vendor:match("^%s*(.-)%s*$")  -- Trim
                                    if vendor and vendor ~= "" then
                                        button.vendorText:SetText(vendor)
                                        button.vendorText:Show()
                                    end
                                end
                            end
                            
                            -- Extract cost (stop before Vendor, Zone, Achievement, or Category)
                            if button.costText then
                                local cost = nil
                                -- Find cost start position
                                local costStart = fullEntry.sourceText:find("Cost:", 1, true)
                                if costStart then
                                    -- Find the earliest next field (in order of likely appearance)
                                    local costEnd = nil
                                    local vendorPos = fullEntry.sourceText:find("Vendor:", costStart + 5, true)
                                    local zonePos = fullEntry.sourceText:find("Zone:", costStart + 5, true)
                                    local achievementPos = fullEntry.sourceText:find("Achievement:", costStart + 5, true)
                                    local categoryPos = fullEntry.sourceText:find("Category:", costStart + 5, true)
                                    
                                    -- Find the earliest next field
                                    costEnd = vendorPos
                                    if zonePos and (not costEnd or zonePos < costEnd) then
                                        costEnd = zonePos
                                    end
                                    if achievementPos and (not costEnd or achievementPos < costEnd) then
                                        costEnd = achievementPos
                                    end
                                    if categoryPos and (not costEnd or categoryPos < costEnd) then
                                        costEnd = categoryPos
                                    end
                                    
                                    -- If no next field found, use end of string
                                    if not costEnd then
                                        costEnd = #fullEntry.sourceText + 1
                                    end
                                    
                                    -- Extract cost text (from "Cost:" to next field)
                                    if costEnd > costStart + 5 then
                                        cost = fullEntry.sourceText:sub(costStart + 5, costEnd - 1)
                                    end
                                end
                                
                                if cost then
                                    -- Strip WoW formatting but preserve texture codes for icons
                                    cost = cost:gsub("|c%x%x%x%x%x%x%x%x", "")  -- Color codes
                                        :gsub("|r", "")
                                        :gsub("|H[^|]*|h", "")  -- Hyperlinks
                                        :gsub("|h", "")
                                        :gsub("|n", " ")        -- Newlines
                                    -- Keep texture codes for gold/currency icons
                                    cost = cost:match("^%s*(.-)%s*$")  -- Trim
                                    if cost and cost ~= "" and cost ~= "..." then
                                        button.costText:SetText(cost)
                                        button.costText:Show()
                                    else
                                        button.costText:Hide()
                                    end
                                else
                                    button.costText:Hide()
                                end
                            end
                        end
                    end
                end
            end
            
            -- Also try to get vendor and cost from C_Housing API (more reliable than sourceText)
            if HousingAPI and itemID then
                local baseInfo = HousingAPI:GetDecorItemInfoFromItemID(itemID)
                if baseInfo and baseInfo.decorID then
                    local decorID = baseInfo.decorID
                    local vendorInfo = HousingAPI:GetDecorVendorInfo(decorID)
                    if vendorInfo then
                        -- Get vendor name
                        if button.vendorText and vendorInfo.name and vendorInfo.name ~= "" then
                            button.vendorText:SetText(vendorInfo.name)
                            button.vendorText:Show()
                        end
                        
                        -- Get cost from API (amount is in copper)
                        if button.costText and vendorInfo.cost and #vendorInfo.cost > 0 then
                            local costEntry = vendorInfo.cost[1]
                            local costText = ""
                            if costEntry.currencyID == 0 then
                                -- Gold (amount is in copper, divide by 10000 to get gold)
                                local copperAmount = costEntry.amount or 0
                                local gold = math.floor(copperAmount / 10000)
                                local silver = math.floor((copperAmount % 10000) / 100)
                                if gold > 0 then
                                    if silver > 0 then
                                        costText = string.format("%dg %ds", gold, silver)
                                    else
                                        costText = string.format("%dg", gold)
                                    end
                                elseif silver > 0 then
                                    costText = string.format("%ds", silver)
                                else
                                    local copper = copperAmount % 100
                                    if copper > 0 then
                                        costText = string.format("%dc", copper)
                                    end
                                end
                            elseif costEntry.currencyID then
                                -- Currency (amount is the actual currency count)
                                local currencyName = "Currency #" .. costEntry.currencyID
                                local currencyInfo = HousingAPI:GetCurrencyInfo(costEntry.currencyID)
                                if currencyInfo and currencyInfo.name then
                                    currencyName = currencyInfo.name
                                end
                                costText = (costEntry.amount or 0) .. " " .. currencyName
                            end
                            
                            if costText and costText ~= "" then
                                button.costText:SetText(costText)
                                button.costText:Show()
                            end
                        end
                    end
                end
            end
            
            -- Fallback: try to get vendor from item data if available
            if button.vendorText and (not button.vendorText:GetText() or button.vendorText:GetText() == "") then
                if item.vendorName and item.vendorName ~= "" then
                    button.vendorText:SetText(item.vendorName)
                    button.vendorText:Show()
                end
            end
            -- If we get here, try fallback to item.price (only if cost hasn't been set yet)
            -- Note: Static data stores price in GOLD, not copper
            if button.costText then
                local currentCost = button.costText:GetText()
                if (not currentCost or currentCost == "" or currentCost == "...") then
                    if item.price and item.price > 0 then
                        -- Static data price is in gold directly
                        button.costText:SetText(string.format("%dg", item.price))
                        button.costText:Show()
                    else
                        -- Hide if still showing "..." and no price
                        if currentCost == "..." then
                            button.costText:Hide()
                        end
                    end
                end
            end
        end)
    else
        -- No catalog API, try item.price directly
        -- Note: Static data stores price in GOLD, not copper
        if button.costText then
            if item.price and item.price > 0 then
                button.costText:SetText(string.format("%dg", item.price))
            else
                button.costText:Hide()
            end
        end
    end
    
    -- Removed: Vendor/zone info display (tooltipInfoText field removed)
    -- Wishlist button removed - now in preview panel
    -- Map icon removed - now in preview panel

    -- Update icon - try to get from cache or load asynchronously
    if item.itemID and item.itemID ~= "" then
        local itemID = tonumber(item.itemID)
        if itemID then
            -- Set question mark as placeholder
            button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")

            -- Request item data to be loaded
            if C_Item and C_Item.RequestLoadItemDataByID then
                C_Item.RequestLoadItemDataByID(itemID)
            end

            -- Try to get icon with retries (item data may take time to load)
            local attempts = 0
            local maxAttempts = 5
            local retryDelay = 0.1

            local function TryLoadIcon()
                if not button:IsVisible() then return end

                local iconTexture = nil

                -- Method 1: Try C_Item.GetItemIconByID
                if C_Item and C_Item.GetItemIconByID then
                    iconTexture = C_Item.GetItemIconByID(itemID)
                end

                -- Method 2: Fallback to GetItemIcon
                if not iconTexture and GetItemIcon then
                    iconTexture = GetItemIcon(itemID)
                end

                -- If we got a valid texture, use it
                if iconTexture and iconTexture ~= "" then
                    button.icon:SetTexture(iconTexture)
                else
                    -- Retry if we haven't exceeded max attempts
                    attempts = attempts + 1
                    if attempts < maxAttempts then
                        C_Timer.After(retryDelay, TryLoadIcon)
                    end
                    -- If max attempts reached, keep the question mark
                end
            end

            -- Start loading with a small delay to stagger requests
            C_Timer.After(0.01 * buttonIndex, TryLoadIcon)
            
            -- Removed: tooltip scanning for weight and house icon (fields removed)
        else
            button.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        end
    else
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
            -- Fallback: Check via CollectionAPI (for items without quantity data yet)
            if item.itemID and item.itemID ~= "" then
                local itemID = tonumber(item.itemID)
                if itemID and CollectionAPI then
                    isCollected = CollectionAPI:IsItemCollected(itemID)
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
    button:EnableMouse(true)
    button:RegisterForClicks("LeftButtonUp")
    button:SetScript("OnClick", function(self, mouseButton)
        local item = self.itemData
        if not item then return end
        
        -- Click: Show preview panel
        if HousingPreviewPanel then
            HousingPreviewPanel:ShowItem(item)
        else
            -- Silently handle missing PreviewPanel
            -- print("HousingVendor: HousingPreviewPanel not found")
        end
    end)
end

-- Apply font size to all buttons
function ItemList:ApplyFontSize(fontSize)
    fontSize = fontSize or 12
    
    -- Update all button text elements
    for _, button in ipairs(buttons) do
        if button.nameText then
            local nameFont, _, nameFlags = button.nameText:GetFont()
            button.nameText:SetFont(nameFont or "Fonts\\FRIZQT__.TTF", fontSize, nameFlags)
        end
        -- Removed: typeText, tooltipInfoText, weightText (fields removed)
    end
    
    -- Refresh visible buttons
    C_Timer.After(0.1, function()
        if HousingItemList then
            HousingItemList:UpdateVisibleButtons()
        end
    end)
end

-- Cleanup function to unregister events and clear references
-- This is called when the UI is hidden to free resources
function ItemList:Cleanup()
    -- Unregister all events to stop processing when UI is closed
    if eventFrame then
        eventFrame:UnregisterAllEvents()
        -- Note: We don't clear the OnEvent handler, so events can be re-registered on Show
    end

    -- Hide buttons but keep references for re-use (better performance than recreating)
    for i = 1, #buttons do
        if buttons[i] then
            buttons[i]:Hide()
        end
    end

    -- Clear data arrays to allow garbage collection of large tables
    -- These will be repopulated when UI is shown again
    allItems = {}
    filteredItems = {}

    -- Note: We intentionally keep currentFilters and button pool for faster reopening
end

-- Re-register events after cleanup (called on UI Show)
function ItemList:ReRegisterEvents()
    if not eventFrame then return end

    local function SafeRegisterEvent(eventName)
        local success = pcall(function()
            eventFrame:RegisterEvent(eventName)
        end)
        return success
    end

    -- Re-register all housing events
    SafeRegisterEvent("HOUSE_DECOR_ADDED_TO_CHEST")
    SafeRegisterEvent("HOUSING_COLLECTION_UPDATED")
    SafeRegisterEvent("HOUSING_ITEM_PURCHASED")
    SafeRegisterEvent("MERCHANT_SHOW")
    SafeRegisterEvent("MERCHANT_CLOSED")
    SafeRegisterEvent("BAG_UPDATE_DELAYED")
    SafeRegisterEvent("CHAT_MSG_LOOT")
    SafeRegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    SafeRegisterEvent("ENCOUNTER_LOOT_RECEIVED")
end

-- Refresh theme colors dynamically
function ItemList:RefreshTheme()
    if not scrollFrame then return end
    
    -- Re-render visible items with new theme colors
    ItemList:UpdateVisibleButtons()
end

-- Make globally accessible
_G["HousingItemList"] = ItemList

return ItemList


